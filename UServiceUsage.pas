unit UServiceUsage;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzLabel, ExtCtrls, Grids, Rio, SOAPHTTPClient,
  Grids_ts, TSGrid, InvokeRegistry, jpeg, UForms, AWSI_Server_Clickforms,
  ClfCustServices2014,Contnrs,uLkJSON,WinHttp_TLB;

type
  TCRMServiceUsage = class(TObject)
    AvailableUnits : String;
    ProdName       : String;
    ProdUID        : Integer;
    ServiceExpire  : String;

    constructor Create;
    destructor Destroy; override;
  end;

  TServiceUsage = class(TAdvancedForm)
    tsUsageSummary: TtsGrid;
    Panel1: TPanel;
    lblMaintenance: TLabel;
    lblMaintExp: TLabel;
    lblLevel: TLabel;
    lblLevelValue: TLabel;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    awsiSummary: clsGetUsageAvailabilitySummaryArray;
    membershipLevel: String;
    FCRMAvailServiceList:TObjectList;
    function GetSummary: Boolean;
    procedure DisplayExpirationDate(ALabel: TLabel; expDate: String);
    function GetAWSIServicesSummary: clsGetUsageAvailabilitySummaryArray;
    procedure UpdateServiceByAWSI(var servInfo: ServiceInfo; isAWSIowner: integer);
    function GetCRMServiceAvailable:String;
    function ReplaceSameServiceOnGrid(CRMServiceUsage:TCRMServiceUsage):Boolean;

  public
    { Public declarations }
  end;

const      //awsi
  srcCustDB = 0;
  srcAWSI = 1;
  awsiExpTypeNotAvailable = -1; // never purchased or expired or no units left
  awsiExpTypeRegular = 0;
  awsiExpTypeMonthlyReqBilling = 1;
  awsiExpTypeAnnualReqBilling = 2;
  awsiExpTypeUnlimited = 3;
  awsiUnitTypeNotAvailable = -1; //never purchased or no units left
  awsiUnitTypeRegular = 0;
  awsiUnitTypeUnlimited = 3;
  custDBDateFormat = 'mm/dd/yyyy';
  custDBDateseparator = '/';
  awsiDateformat = 'yyyy-mm-dd';
  awsiDateseparator = '-';
  srUnlimited = 'unlimited';
  unlimitedUnits = 999999;

  EVALUATION_CAPTION = 'Evaluation';


var
  ServiceUsage: TServiceUsage;


procedure GetServiceUsageSummary;
function GetAWSIServiceID(stServiceID: integer): integer;

implementation

uses
  StrUtils, DateUtils, Types, ULicUser, UStatus, UWebConfig, UWinUtils,
  {messagingservice,} UWebUtils, UUtil1, UUtil2, UCustomerServices, UGlobals,UCRMServices;
  //AWSI_Server_Clickforms;



{$R *.dfm}

procedure GetServiceUsageSummary;
var
  Usage: TServiceUsage;
begin
  Usage := TServiceUsage.Create(nil);
  try
    Usage.ShowModal;
  finally
    Usage.Free;
  end;
end;

function GetAWSIServiceID(stServiceID: integer): integer;
begin
  result := 0;
  case stServiceID of
    stMaintanence:     result := 101;
    stLiveSupport:     result := 103;
    stAppraisalPort:   result := 104;
    stLighthouse:      result := 0;  //not used any more
    stDataImport:      result := 105;
    stMLS:             result := 109;
    stFloodMaps:       result := 3;  //includes map and data
    stLocationMaps:    result := 102;
    stVeroValue:       result := 4;
    stMarshalAndSwift: result := 40;
    stFloodData:       result := 0;  //AWSI does not have the service
    stFIS:             result := 5;
    stRels:            result := 106;
    stUAD:             result := 107;
    stPictometry:      result := 41;
    stBuildfax:        result := 13;
    stPhoenixMobile:   result := 0;  //Ticket #1344: no longer need to call service set to 0, not used any more
    stMarketAnalyses:  result := 8;
    stMercuryNetwork:  result := 160;  //ticket #1202
  end;
end;

{   TServiceUsage  }
function GetJsonStrValue(js:TlkJSONBase; FieldName:String):String;
begin
  result := '';
  if js.Field[FieldName] <> nil then
    begin
      if js.Field[FieldName].Value <> null then
        result := js.Field[FieldName].Value;
    end;
end;


function TServiceUsage.ReplaceSameServiceOnGrid(CRMServiceUsage:TCRMServiceUsage):Boolean;
var
  aRow:Integer;
  aProdName,aCRMProdName:String;
  aServiceExpireDate:TDateTime;
begin
  result := False;
  for aRow:= 0 to tsUsageSummary.Rows-1 do
    begin
      aProdName    := UpperCase(tsUsageSummary.Cell[1,aRow]);
      aCRMProdName := UpperCase(CRMServiceUsage.ProdName);
      if pos(aProdName,aCRMProdName) > 0 then
        begin
          result := True;
          tsUsageSummary.Cell[1,aRow] := CRMServiceUsage.ProdName;
          tsUsageSummary.Cell[2,aRow] := CRMServiceUsage.AvailableUnits;
          if isValidXMLDate(CRMServiceUsage.ServiceExpire, aServiceExpireDate) then
            tsUsageSummary.Cell[3,aRow] := FormatDateTime('mm/dd/yyyy',aServiceExpireDate);
          break;
        end;
    end;
end;
procedure TServiceUsage.FormShow(Sender: TObject);
var
   i,row:Integer;
   CRMServiceUsage: TCRMServiceUsage;
   ResponseText:String;
   jsData:TlkJSONObject;
   js,jsProducts:TlkJSONBase;
   jsProductList:TlkJSONList;
   aServiceExpireDate:TDateTime;
   prodUID:Integer;
   SoftwareBundle:String;
begin
  Caption := 'Service Summary for: ' + CurrentUser.SWLicenseName;
  GetSummary;
  ResponseText := GetCRMServiceAvailable;
  if ResponseText = '' then exit;
  CRMServiceUsage := TCRMServiceUsage.Create;
  jsData := TlkJSON.ParseText(ResponseText) as TlkJSONobject;
  if jsData = nil then exit;
  js :=TlkJsonObject(jsData).Field['availableServices'];
  if js = nil then exit;
  jsProducts := TlkJSonObject(js).Field['allProducts'];
  jsProductList := jsProducts as TlkJSONList;
  if jsProductList <> nil then
  if CurrentUser.LicInfo.FLicType = ltEvaluationLic then
    begin
      tsUsageSummary.Rows := 0;
      lblMaintExp.Caption := EVALUATION_CAPTION;
      lblMaintExp.Font.Color := clRed;
      lblLevel.Visible := False;
      lblLevelValue.Visible := False;
    end;
  row := tsUsageSummary.Rows;
  tsUsageSummary.Rows := row;

  if jsProductList = nil then exit;
  for i:=0 to jsProductList.Count -1 do
    begin
      js := jsProductList.Child[i] as TlkJSONBase;  //
      CRMServiceUsage.ProdUID  := GetJsonInt(js as TlkJsonObject,'ProdUID');
      CRMServiceUsage.ProdName := GetJsonStrValue(js,'ProdName');
      CRMServiceUsage.AvailableUnits := GetJsonStrValue(js,'AvailableUnits');
      CRMServiceUsage.ServiceExpire := GetJsonStrValue(js,'ServiceExpire');
      if ReplaceSameServiceOnGrid(CRMServiceUsage) then
        continue
      else
        begin
          inc(row);
          tsUsageSummary.Rows := row;
          tsUsageSummary.Cell[1,row] := CRMServiceUsage.ProdName;
          tsUsageSummary.Cell[2,row] := CRMServiceUsage.AvailableUnits;
          if isValidXMLDate(CRMServiceUsage.ServiceExpire, aServiceExpireDate) then
            tsUsageSummary.Cell[3,row] := FormatDateTime('mm/dd/yyyy',aServiceExpireDate);
        end;
    end;
end;

procedure TServiceUsage.DisplayExpirationDate(ALabel: TLabel; expDate: String);
begin
  ALabel.Caption := expDate;
  if Now > StrToDate(expDate) then
    begin
      ALabel.Font.Color := clRed;
      ALabel.Font.Style := [fsBold];
    end;
end;


function TServiceUsage.GetSummary: Boolean;
var
  Service: ServiceInfo;
  nServices, index, row: Integer;
  ADate,LicenseEndDate: TDateTime;
begin
  result := false;
//  if FUseCRMRegistration and (CurrentUser.LicInfo.FLictype = ltEvaluationLic) then exit;
  //get custDB services' status
  try
    RefreshServStatuses;   //now services show status only on custDB
    nServices := GetServicesCount;
    if nServices = 0 then //cannot happen
      exit;
    tsUsageSummary.Rows := nServices - 1;      //maintenance in header rather than in the grid
    awsiSummary := GetAWSIServicesSummary;

    if CurrentUser.LicInfo.FLicType = ltEvaluationLic then   //Ticket #1245: show membership level as Trial for Trial user
      membershipLevel := EVALUATION_CAPTION;

    lblLevelValue.Caption := membershipLevel;

    if compareText(membershipLevel,EVALUATION_CAPTION) = 0 then //Ticket #1245: show Trial in red
      lblLevelValue.Font.Color := clRed;
    //Ticket #1421: show maintenance date from registration table not from the get summary api
    lblMaintenance.Caption := 'Maintenance Expires:';
    if isValidXMLDate(CurrentUser.LicInfo.FLicEndDate, LicenseEndDate) then
      begin
        if LicenseEndDate <= Date then //show in red color if expired
          begin
            lblMaintExp.Font.Color := clRed;
            lblMaintExp.Caption := FormatDateTime('mm/dd/yyyy',LicenseEndDate);
          end
        else
          lblMaintExp.Caption    := FormatDateTime('mm/dd/yyyy',LicenseEndDate);
      end;
    row := 0;
    for index := 0 to nServices -1 do
      begin
        service := GetServiceByIndex(index); //from custDB
        if (service.servID = stMaintanence) and (service.status = -1) then
          begin
(*
            tsUsageSummary.Rows := 0;
            lblLevel.Visible := False;
            lblLevelValue.Visible := False;
            if CompareText(membershipLevel,'Trial') <> 0 then
            exit;   //this user does not purchase anything in CF.
*)
          end;
        //Ticket #1344: no longer need to call service
        UpdateServiceByAWSI(service,assignedToUser);
        if service.servID in CompanyOwedServices then
          UpdateserviceByAWSI(service,assignedToOwner);
        case service.servID of
          stFloodData, stUAD, stMaintanence, stPhoenixMobile:
              begin
                tsUsageSummary.Rows := tsUsageSummary.Rows - 1;
                continue;  //PAM: Ticket #1418: skip flood data, Phoenix mobile, uad compliance, & clickFORMS maintenance
              end;
            else
              begin
                inc(row);
                tsUsageSummary.Cell[1,row] := service.servName;

                //Ticket #1245: show Not Purchase if it's trial user
//                if CurrentUser.LicInfo.FLicType = ltEvaluationLic then
//                  begin
//                    tsUsageSummary.Cell[3, row] := srNotPurchased;
//                    Continue;
//                  end;
                //display expiration date
                if service.status = statusNotPurchased then
                  tsUsageSummary.Cell[3,row] := srNotPurchased
                else if CompareText(service.expDate,srSubscription) = 0 then
                        tsUsageSummary.Cell[3,row] := srOnsubscription
                      else if CompareText(service.expDate,srUnlimited) = 0 then
                             tsUsageSummary.Cell[3,row] := srUnlimited
                          else if isValidDate(service.expDate,ADate,false) then
                              tsUsageSummary.Cell[3,row] := service.expDate;
                //display units
                if (service.status = statusOK) or (service.status = statusNoUnits) then
                  if service.unitsLeft > -1 then
                    if service.unitsLeft =  unlimitedUnits then
                      tsUsageSummary.Cell[2,row] := srUnlimited
                    else if Service.unitsLeft > 0 then
                      tsUsageSummary.Cell[2,row] := service.unitsLeft;
              end;
        end;
      end;
      //now services show status on custDB  + AW
  except
    on e: Exception do
      begin
        Showalert(atWarnAlert,e.Message);
        result := false;
        exit;
      end;
  end;

end;

function TServiceUsage.GetAWSIServicesSummary: clsGetUsageAvailabilitySummaryArray;
var
  credential: clsUsageAccessCredentials;
begin
  result := nil;
  try
    credential := clsUsageAccessCredentials.Create;
    with CurrentUser do
    begin
      credential.CustomerId := StrToIntDef(UserCustUID, 0);
      if credential.CustomerId = 0 then
          credential.CustomerId := StrToIntDef(AWUserInfo.CustDBIdentifier, 0);
      credential.AppraiserId := StrToIntDef(AWUserInfo.AWIdentifier, 0);
      credential.ServiceId := awsi_CFProductAvailableID;
    end;
    with GetClickformsServerPortType(False, GetAWURLForClickFORMSService(False)) do
      with ClickformsServices_GetUsageAvailabilitySummary2(credential) do
        begin
          if results.code  = 0 then
            begin
             result := ResponseData.Summary;
             membershipLevel :=  ResponseData.MembershipLevelName;
            //ShowMessage(ResponseData.MembershipLevelName);
           end;
        end;
    if length(result) = 0 then  //empty array
      result := nil;
  except
  end;
end;

procedure TServiceUsage.UpdateServiceByAWSI(var servInfo: ServiceInfo; isAWSIowner: integer);
var
  awsiServiceID: integer;
  index, nServices: integer;
  awsiService: clsGetUsageAvailabilityItem;
  expType,unitsType: Integer;
  expDate,units: WideString;
  tmpString: string;
  awsiDate,custDBDate: TDateTime;
begin
  if not assigned(awsiSummary) then
    exit;
  nServices := length(awsiSummary);
  awsiServiceID := GetAWSIServiceID(servInfo.servID);
  awsiService := nil;
  for index := 0 to nServices - 1 do
    if awsiSummary[index].ServiceID = awsiserviceID  then
      begin
       awsiService := awsiSummary[index];
       break;
      end;
  if not assigned(awsiService) then
    exit;
  with awsiService do
    if isAWSIOwner = 0 then
      begin
        expType := UserExpirationType;
        expDate := UserExpDate;
        unitsType := UserUnitsType;
        units := UserUnitsLeft;
      end
    else
      begin
        expType := OwnerExpirationType;
        expDate := OwnerExpDate;
        unitsType := OwnerUnitsType;
        units := OwnerUnitsLeft;
      end;
  case expType of
    awsiExpTypeNotAvailable:
      exit; //leave servInfo how it is
    awsiExpTypeRegular, awsiExpTypeAnnualReqBilling:
      begin
        case servInfo.status of
          statusOK:
            begin
              if compareText(servInfo.expDate,srSubscription) <> 0 then
                begin //select later date
                  TryStrToDate(servInfo.expDate,custDBDate,custDBDateFormat,custDBDateSeparator);
                  TryStrToDate(expDate,awsiDate,awsiDateFormat,awsiDateSeparator);
                  if CompareDateTime(custDBDate,awsiDate) = LessThanValue	then
                    begin
                      DateTimeToString(tmpString,custDBDateFormat,awsiDate);
                      servInfo.expDate := tmpString;
                    end;
                  end;
              //sum units
              if servInfo.servID in LimitedUnitsServices then
                if unitsType = awsiUnitTypeUnlimited  then
                  servInfo.unitsLeft := unlimitedUnits
                else
                  servInfo.unitsLeft := servInfo.unitsLeft + StrToIntDef(units,0);
            end;
          statusExpired, statusNoUnits, statusNotApplicable:
            begin
              servInfo.status := statusOK;
              if TryStrToDate(expDate,awsiDate,awsiDateFormat,awsiDateSeparator) then
                begin
                  DateTimeToString(tmpString,custDBDateFormat,awsiDate);
                  servInfo.expDate := tmpString;
                end;
              if servInfo.servID in LimitedUnitsServices then
                if unitsType = awsiUnitTypeUnlimited  then
                  servInfo.unitsLeft := unlimitedUnits
                else
                 servInfo.unitsLeft := StrToIntDef(units,0);
            end;
        end;
      end;
      awsiExpTypeMonthlyReqBilling:
        begin
          case servInfo.status of
            statusNotApplicable,statusExpired, statusNoUnits:
              begin
                servInfo.status := statusOK;
                servInfo.expDate := srSubscription;
                if servInfo.servID in LimitedUnitsServices then
                  if unitsType = awsiUnitTypeUnlimited  then
                    servInfo.unitsLeft := unlimitedUnits
                  else
                  servInfo.unitsLeft := StrToIntDef(units,0);
              end;
            statusOK:
              begin
                servInfo.status := statusOK;
                servInfo.expDate := srSubscription;
                if servInfo.servID in LimitedUnitsServices then
                  if unitsType = awsiUnitTypeUnlimited  then
                      servInfo.unitsLeft := unlimitedUnits
                  else
                    servInfo.unitsLeft := servInfo.unitsLeft + StrToIntDef(units,0);
              end;
          end;
      end;
      awsiExpTypeUnlimited:
        begin
          //servInfo.status := statusOK;
          servInfo.expDate := srUnlimited;
          if servInfo.servID in LimitedUnitsServices then
            if unitsType = awsiUnitTypeUnlimited  then
              servInfo.unitsLeft := unlimitedUnits
            else if servInfo.status = statusOK then
                    servInfo.unitsLeft := servInfo.unitsLeft + StrToIntDef(units,0)
                  else
                    servInfo.unitsLeft := StrToIntDef(units,0); //unlimitedUnits;
          servInfo.status := statusOK;
        end;
  end;
end;

function TServiceUsage.GetCRMServiceAvailable:String;
const
  GetAvailableService_URL = '/reports/getavailableservices';
var
  CustUID,GroupUID:Integer;
   RequestStr,respStr: String;
   jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
   VendorTokenKey,AuthenticationToken,url:String;
   httpRequest: IWinHTTPRequest;
   errMsg:String;

begin
  result := '';
  AuthenticationToken := RefreshCRMToken(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it
  if length(VendorTokenKey) = 0 then exit;
  CustUID  := GetValidInteger(CurrentUser.AWUserInfo.UserCRMUID);
  GroupUID := CurrentUser.LicInfo.FGroupID;

  url := CRMCoreBaseURL+GetAvailableService_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsRequestFields := TlkJSONObject.Create(true);
    jsRequestData := TlkJSONObject.Create(true);
    postJsonInt('custUID',CustUID,jsRequestFields,False);
    postJsonInt('groupUID', GroupUID, jsRequestFields,False);
    postJsonInt('softwareUID',CRM_Registration_Software_UID, jsRequestFields,False);
    jsRequestData.Add('requestFields',jsRequestFields);
    RequestStr := TlkJSON.GenerateText(jsRequestData);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    result := httpRequest.ResponseText;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
//               js :=TlkJsonObject(jsResult).Field['requestFields'];
//               if js <> nil then
                 begin
//                   result := True;
                 end;
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

procedure TServiceUsage.FormCreate(Sender: TObject);
begin
  FCRMAvailServiceList := TObjectList.Create(False);
end;

procedure TServiceUsage.FormDestroy(Sender: TObject);
begin
  FCRMAvailServiceList.Free;
end;

constructor TCRMServiceUsage.Create;
begin
  inherited create;
  AvailableUnits := '';
  ProdName := '';
  ProdUID  := 0;
  ServiceExpire := '';
end;

destructor TCRMServiceUsage.Destroy;
begin
  inherited;
end;


end.
