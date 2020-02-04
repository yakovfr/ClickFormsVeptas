unit UServices;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface


uses
  UGlobals, UContainer, UCell, Windows, Messages, DateUtils, Types,
  UAppraisalSentry, UGSEUADPref, Classes, uMain,
  ClfCustServices2014, AWSI_Server_Clickforms;


  procedure LaunchService(serviceID: Integer; doc: TContainer; cell: TBaseCell);
  function CheckServiceAvailable(ServiceID: Integer):Boolean;
  function isUnitBasedWebService(aServiceID: Integer):Boolean;




implementation

uses
  Forms,SysUtils,
  UStatus, UCompEditor, UUtil1, UUtil2, UAutoUpdate,
  UToolMapMgr, UPortFloodInsights, UPortCensusNew,
  UServiceUsage, UWebUtils, UMarshalSwiftMgr, UPortFloodZoning,
  UPortFidelity,UFileRelsMLSImport, UPortPictometry, UBuildfaxService,
  UPhoenixMobileLogin, ULicUser, UStrings,
  UCustomerServices,UWebConfig,uSendHelp,uServiceStatus, UMobile_Inspection,
  uMarketData,UMapPortalBingMapsSL,UCRMServices,UFileMLSWizard;

var
   awsiSummary: clsGetUsageAvailabilitySummaryArray;

procedure HandleMapInterfaceSL(ToolID: String; doc: TContainer; cell: TBaseCell; const AppName, AppPath: String; useAWorCustDBService:Boolean);
begin
  if Assigned(doc) then
    begin
      if Assigned(cell) then
        begin
           doc.MapPortalManagerSL.LaunchMapToolSL(ToolID, cell, useAWorCustDBService);
        end
      else
        begin
          doc.MapPortalManagerSL.LaunchMapToolSL(ToolID, nil, useAWorCustDBService);
        end;
    end;
end;

procedure LaunchService(serviceID: Integer; doc: TContainer; cell: TBaseCell);
const
  rspLogin  = 6;
var
  //isServiceAvailable: Boolean;
  aAWLogin, aAWPsw, aAWCustUID: String;
  rsp: Integer;
  responseData,VendorTokenKey:String;
  EvalMode:Boolean;
begin
  //there could be a cell data that is yet to be processed
  if assigned(doc) then
    doc.ProcessCurCell(False);

  EvalMode := CurrentUser.LicInfo.FLicType = ltEvaluationLic;  

  //check for non-internet services
  if (serviceID = cmdUADCompliance) then
      SetUADCompliancePrefs(doc)

  else begin //check the internet connection first
    if not IsConnectedToWeb then
     ShowAlert(atWarnAlert, 'ClickFORMS could not access the service you requested.  This may be due to a problem with your internet connection, a security setting change on your computer, or the Bradford server being offline.')

    else begin //if connected request the service
      case serviceID of
        cmdFloodInsights:
            RequestFloodMap(doc, cell, '', False);

        cmdFloodZoneInfo: //###PAM note: flood zone data service only in CustDB here's the note:
          RequestFloodZone(doc, nil, '', False);

        // Marshall & Swift Cost Estimator
        cmdMSCostInfo:
          RequestCostAnalysis(doc);

        cmdCensusInfo:
          GetCensusTract(doc);

        cmdUsageSummary:
          begin
            GetServiceUsageSummary;
          end;
        cmdBingMaps: //###PAM: call awsi service first
          begin
            if CurrentUser.OK2UseAWProduct(pidOnlineLocMaps, True, True) then  //make it silient
              HandleMapInterfaceSL(CBingMapsMapPortal, Doc, Cell, '', '', True)   //True is using AWSI or CustDB
            else if CurrentUser.OK2UseCustDBproduct(pidOnlineLocMaps) then
              HandleMapInterfaceSL(CBingMapsMapPortal, Doc, Cell, '', '', True)
            else if FUseCRMRegistration then
              HandleMapInterfaceSL(CBingMapsMapPortal, Doc, Cell, '', '', False)  //False is for CRM
            else
              ShowAlert(atWarnAlert, msgServiceNotAvaible);
          end;
        cmdFidelityData:
          RequestFidelityData(doc,cmdFidelityData);

         cmdLPSBlackKnightData:
           RequestBlackKnightLPSData(doc,cmdLPSBlackKnightData);

        cmdAppraisalSentry:
          AppraisalSentryRegistration(doc);

        cmdMarketAnalysis:
          begin
            try
//              if CurrentUser.LicInfo.FLicType = ltEvaluationLic then
//                begin
//                    if GetCRM_PersmissionOnly(CRM_1004MCProdUID,CRM_1004MC_ServiceMethod,currentUser.AWUserInfo, True, VendorTokenKey,False) then //muteError = True
//                      ShowFormModel('TMarketConditionsAnalysisForm') //if CRM is available use AWSI service to go in
//                end
//              else
                if CurrentUser.OK2UseAWProduct(pidMCAnalysis, True) then   //make it silient
                ShowFormModel('TMarketConditionsAnalysisForm') //This is for AWSI
              else if CurrentUser.OK2UseCustDBproduct(pidMCAnalysis) then
                ShowFormModel('TWSIMarketConditionsAnalysisForm')    //This is for CustDB service
              else if GetCRM_PersmissionOnly(CRM_1004MCProdUID,CRM_1004MC_ServiceMethod,currentUser.AWUserInfo, True, VendorTokenKey,False) then //muteError = True
                      ShowFormModel('TMarketConditionsAnalysisForm') //if CRM is available use AWSI service to go in
              else
                begin
                  rsp := WarnWithOption12('Purchase', 'Cancel', ServiceWarning_NotAvailable);
                  if rsp = rspLogin then
                    HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.UserCustUID, CurrentUser.AWUserInfo.UserLoginEmail);   //link to the AppraisalWorld store
                end;
              except on E:Exception do
                 ShowAlert(atWarnAlert,msgServiceNotAvaible);
              end;
          end;
        cmdPictometry:
          TPictometryPortal.Execute(doc);

        cmdBuildfaxService:
          ImportBuildFaxInfo(doc);

        cmdPhoenixMobile:
          ImportPhoenixMobile(doc);

        cmdInspectionMobile:
          CC_ShowInspectionManager(doc);

        cmdMLSImportWizard: {id = 327}
       begin
         if appPref_ImportAutomatedDataMapping then     //github #957
           LaunchMLSImportWizard(doc)
         else
           ImportWizard(doc);
       end;
       cmdAddressVerification: StartNewAppraisal;
      end;
    end;
  end;
end;


function GetAWSIServicesSummary: clsGetUsageAvailabilitySummaryArray;
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
           end;
        end;
    if length(result) = 0 then  //empty array
      result := nil;
  except
  end;
end;

procedure UpdateServiceByAWSI(var servInfo: ServiceInfo; isAWSIowner: integer);
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

function InRemindDateRange(aDay:Integer):Boolean;
begin
  result := False;
  case aDay of
    15, 3, 2, 1: result := True;
  end;
end;

//This is for unit based service: Flood Maps, Marshall & Swift, Pictometry, BuildFax, Phoenix Mobile
function GetUnitByService(aSrvID: Integer):String;
begin
  result := 'credits';
  case aSrvID of
   stFloodMaps: result := 'maps';
  end;
end;


function GetMaxUnitLeftByService(aSrvID:Integer):Integer;
begin
  result := 5;
  case aSrvID of
    stFloodMaps:       result := 10;
    stMarshalAndSwift: result := 1;
    stPictometry:      result := 5;
    stBuildfax:        result := 5;
    stPhoenixMobile:   result := 5;
  end;
end;

function GetUnitLeftByService(aSrvID, aQty: Integer): String;
begin
  result := Format('%d',[aQty]);
  case aSrvID of
    stMarshalAndSwift: if aQty = 1 then result := 'last';
  end;
end;


function CheckServiceAvailable(ServiceID: Integer):Boolean;
const
  MAX_Expired_Days = 15;

 // Warning_Message3 = 'The ClickFORMS service you requested, %s, will expire in %d days.  Please purchase '+
 //                    'from AppraisalWorld to continue with your appraisal.';
  rspLogin  = 6;
var
  Service: ServiceInfo;
  qty, rsp, index, nServices: Integer;
  aMsg, srvName: String;
  //awsiServiceID,
  days: Integer;
  //awsiService: clsGetUsageAvailabilityItem;
  aExpiredDate, aDate: TDateTime;
  showPopUp: Boolean;
  qtyUnit, qtyStr: String;
  MaxUnitLeft: Integer;
begin
  result := True;
  RefreshServStatuses;
  nServices := GetServicesCount;
  awsiSummary := GetAWSIServicesSummary;
  //awsiService := nil;
  showPopUp := False;
  aExpiredDate := 0;

  for index := 0 to nServices -1 do
    begin
      service := GetServiceByIndex(index); //from custDB
      UpdateServiceByAWSI(service,assignedToUser);
      if service.servID in CompanyOwedServices then
        UpdateserviceByAWSI(service,assignedToOwner);     //now services show status on custDB and AW
      { Why ???  APPort service is not always monthly subscription
        Also  the break means doesnt matter what serviceID ClF checks after it mets APPort service ClF does not check other services.
        We had to check ServiceID - function parameter not service.servID
        if service.servID = stAppraisalPort then  //Appraisal port service is always monthly subscription
        break; }
      if service.servID = ServiceID then
        begin
          srvName := service.servName;
          qty := service.unitsLeft;
          MaxUnitLeft := GetMaxUnitLeftByService(ServiceID);
          qtyUnit     := GetUnitByService(serviceID);
          //days := 0;  //initialize to 0 first
          days := MAX_Expired_Days + 1;    //Ticket #1175: Should not initiazlie to 0 since expired date can be something other than date
          if length(service.expDate) > 0 then  //github #518
            begin
              //if the service.expDate is not in date format do not try to convert text to date here
              if isValidDate(service.expDate, aDate, True) then
                begin
                  TryStrToDate(service.expDate,aExpiredDate,custDBDateFormat,custDBDateSeparator);
                  days := trunc(abs(Date - aExpiredDate));
                end;
            end;
          qtyStr := GetUnitLeftByService(ServiceID, qty);
          //not purchased, pop up purchase/cancel dialog
          //if the service is unlimited, don't do anything
          if compareText(service.expDate,'unlimited') = 0 then
            break
          else if compareText(service.expDate,srSubscription) = 0 then  //github #687
            break
          //if the service is not sold by units, check for expired date
          else if (aExpiredDate > 0) and (qty <= 0) then
            begin
              if days <= MAX_Expired_Days then
                begin
                  if InRemindDateRange(days) then
                    begin
                      aMsg := Format(ServiceWarning_TimeBasedB4Expired,[srvName, days]);
                      showPopUp := True;
                    end;
                end;
            end
          else if (qty <= MaxUnitLeft) and (qty > 0) then
            begin
              aMsg := Format(ServiceWarning_UnitBasedB4Expired,[srvName, days, qty, qtyUnit]); //github #190
              showPopUp := True;
            end
          else if (service.expDate <> '') and (qty > 0) then //github #518: we have units left, check for days left
            begin
              if days <= Max_Expired_days then
                begin
                  if InRemindDateRange(days) then
                    begin
                      aMsg := Format(ServiceWarning_TimeBasedB4Expired,[srvName, days]);
                      showPopUp := True;
                    end;
                end;
            end;
          //********
          //pop up the reminder: Purchase/Cancel dialog
          if showPopUp then
            begin
              rsp := WarnWithOption12('Purchase', 'Cancel', aMsg);
              result := True;
              if rsp = rspLogin then
                HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
              break;
            end;
          //********
        end;
   end;                                                                                              
end;




function isUnitBasedWebService(aServiceID: Integer):Boolean;
begin
  result := False;
  if aServiceID = GetAWSIServiceID(stPictometry) then result := True
  else if aServiceID = GetAWSIServiceID(stFloodMaps) then result := True
  else if aServiceID = GetAWSIServiceID(stMarshalAndSwift) then result := True
  else if aServiceID = GetAWSIServiceID(stBuildfax) then result := True
  else if aServiceID = GetAWSIServiceID(stPhoenixMobile) then result := True;

end;


end.
