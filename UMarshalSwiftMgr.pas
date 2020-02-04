unit UMarshalSwiftMgr;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2008 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, Buttons, ComCtrls,
  RzLabel, StdCtrls,xmldom, XMLIntf, msxmldom, XMLDoc, jpeg,
  UBase, UContainer, UCell, UForm, AWSI_Server_MarshallSwift;

//used for 1007 second page
type
  TRE7EstimateResultRec = record
    Component: string;
    Quantity: string;
    UnitCost: string;
    ExtCost: string;
    Group: integer;
    Order: iNteger;
  end;


  TRE7EstimateResultList = array of TRE7EstimateResultRec;


  TSwiftEstimator = class(TObject)
  private
    FCustomerID: integer;       //read from License
    FDoc: TContainer;           //report container
    FServerUsed: integer;       //which server used{LIVE/EVAL}
    FEstimateID: integer;       //hidden BradfordSoftware estimate id for redo-estimate; CustDB customers
    FAWEstimateID: integer;     //hidden AppraisalWorld estimate id for redo-estimate; AW Customers
    FCRMEstimateID: integer;     //hidden AppraisalWorld estimate id for redo-estimate; CRM Customers
    FSecurityToken: string;     //security token to go to MS Website
    FResultXML: string;         //Result XML from MS Site
    FErrorMsg: string;          //Error message from MS Site
    FChargeUsage: Boolean;      //Charge flag from MS site
    FNewEstimate: Boolean;      //True if new estimate and needs to be saved
    FFileNo: string;
    FStreet: string;
    FCity: string;
    FState: string;
    FZip: string;
    FSwiftSvcAck: string;       //acknowledge string returned by Swift if using AW services
                                // blank if using bradfordsoftware services
    FAWUsername: string;
    FAWPassword: string;
    FAWCompanyKey: string;
    FAWOrderNumberKey: string;
    FSuccessful: Boolean;       //if the dialog was successfully closed
    FTransferToCostApproach: Boolean;
    FVendorTokenKey:String;
    FCRMTokenKey:String;

    function GetInitialInfo: Boolean;
    procedure LaunchSwiftEstimatorSite;
    function ParseResidentialHomeXML(XMLStr: string): boolean;
    function ParseManufacturedHomeXML(XMLStr: string): boolean;
    procedure TransferResultsToDoc;
    procedure TransferResidentialCost(AForm: TDocForm);
    procedure TransferManufacturedCost(AForm: TDocForm);
    procedure TransferResultsToDocCostApproach;
    procedure SaveEstimateIDToDoc;
    procedure ChargeServiceFee;
    function GetMiscComponentTotal(AForm:TDocForm;CM:Double):Double;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure ProcessResults;
    procedure ShowHowToRedoEstimate;

    property Successful: Boolean read FSuccessful write FSuccessful;
    property ChargeUsage: Boolean read FChargeUsage write FChargeUsage;
    property ResultXML: string read FResultXML write FResultXML;
    property ErrorMsg: string read FErrorMsg write FErrorMsg;
    property CustomerID: Integer read FCustomerID write FCustomerID;
    property Doc: TContainer read FDoc write FDoc;
    property SecurityToken: string read FSecurityToken write FSecurityToken;
    property EstimateID: Integer read FEstimateID write FEstimateID;
    property AWEstimateID: Integer read FAWEstimateID write FAWEstimateID;
    property CRMEstimateID: Integer read FCRMEstimateID write FCRMEstimateID;
    property NewEstimate: Boolean read FNewEstimate write FNewEstimate;
    property ServerUsed: Integer read FServerUsed write FServerUsed;
    property FileNo: string read FFileNo write FFileNo;
    property Street: string read FStreet write FStreet;
    property City: string read FCity write FCity;
    property State: string read FState write FState;
    property Zip: string read FZip write FZip;
    property SwiftSvcAck: string read FSwiftSvcAck write FSwiftSvcAck;
    property AWUsername: string read FAWUsername write FAWUsername;
    property AWPassword: string read FAWPassword write FAWPassword;
    property AWCompanyKey: string read FAWCompanyKey write FAWCompanyKey;
    property AWOrderNumberKey: string read FAWOrderNumberKey write FAWOrderNumberKey;
    property VendorTokenKey:String read FVendorTokenKey write FVendorTokenKey;
    property CRMTokenKey:String read FCRMTokenKey write FCRMTokenKey;
  end;


  { Called from UServices to get cost analysis from marshall & swift}
  procedure RequestCostAnalysis(doc: TContainer);



var
  SwiftEstimator: TSwiftEstimator;



implementation

uses
  Clipbrd, UGlobals, UStatus, UEditor, UUtil2, ULicUser, UDebug, UUtil1,
  UUtil3, UWebConfig, UStatusService, UWebUtils, MarshalSwiftService, UPortMarshalSwift,
  UMarshalSwiftSite, UMain, UMath, UDocDataMgr, UStrings,UCRMSErvices;

const
  cMarshalSwiftFormUID          = 468;
  cMarshalSwiftForm_Page2UID    = 469;
  cMarshalSwiftForm_MMH_UID     = 470;
  SUCCESS_STATUS                = 1;     //returned by the BT tranaction server when the MS transaction was ok
  FAILED_STATUS                 = 2;
  HowToReCalc                   = 'You may make modifications to this cost estimate for up to 7 days. To do so, open up this same report file before accessing the Swift Estimator Cost Analysis service.';


 SwiftEstimatorURL = 'https://www.swiftestimator.com/ClickForms/login.aspx?token=';

{ This is the routine that start the process }
{ NOTE: if GetInitialInfo = True, Swift is freed when browser is closed}
procedure RequestCostAnalysis(doc: TContainer);
var
  Swift: TSwiftEstimator;
begin
// - check for available units here, allow to purchase
// - UServiceManager.CheckAvailability(XXXXX);

  Swift := TSwiftEstimator.Create(doc);
  if Swift.GetInitialInfo then
    Swift.LaunchSwiftEstimatorSite
  else
    Swift.Free;

//let user know how many units /time is left
// MS Browser window is modalless, CheckServiceExpiration is on close of window
// UServiceManager.CheckServiceExpiration(stMarshalAndSwift);
end;




{ TSwiftEstimator }

constructor TSwiftEstimator.Create(AOwner: TComponent);
var
  eidStream : TMemoryStream;
begin
  inherited Create;

  FDoc := AOWner as TContainer;

  FCustomerID := StrToIntDef(CurrentUser.UserCustUID, 0);   //set the customer ID

  FChargeUsage := False;        //assume no charge
  FErrorMsg := '';
  FResultXML := '';
  FTransferToCostApproach := True;

  FNewEstimate := True;
  FSwiftSvcAck := '';           //blank assumes bradfordsoftware services

  //AppraisalWorld credentials are set in UPortMarshalSwift.GetCFAW_MarshalAndSwiftInfo
  FAWUsername:= '';
  FAWPassword:= '';
  FAWCompanyKey:= '';
  FAWOrderNumberKey:= '';

  FEstimateID := 0;             //unique BradfordSoftware MS Job Identifier
  FAWEstimateID := 0;           //unique AppraisalWorld MS Job Identifier
  FCRMEstimateID := 0;          //unique CRM MS Job Identifier
  if assigned(FDoc) then        //see if this report already has one; check AW first for latest EstimateID
    begin                       //we need it to do re-estimates
      eidStream := FDoc.docData.FindData(ddAWMSEstimateData);
      if Assigned(eidStream) then
        begin
          FAWEstimateID := PInteger(eidStream.memory)^;
          FNewEstimate := FAWEstimateID = 0;
        end;
      // if we didn't find the AppraisalWorld service stream in DocData or it's zero
      //  see if there's one for BradfordSoftware
      if (not Assigned(eidStream)) or (FAWEstimateID = 0) then
        begin
          eidStream := FDoc.docData.FindData(ddMSEstimateData);
          if Assigned(eidStream) then
            begin
              FEstimateID := PInteger(eidStream.memory)^;
              FNewEstimate := FEstimateID = 0;
            end;
        end;

      if (not Assigned(eidStream)) or (FEstimateID = 0) then
        begin
          eidStream := FDoc.docData.FindData(ddMSEstimateData);
          if Assigned(eidStream) then
            begin
              FCRMEstimateID := PInteger(eidStream.memory)^;
              FNewEstimate := FCRMEstimateID = 0;
            end;
        end;

      // if we didn't find the AppraisalWorld service stream or BradfordSoftware in DocData or it's zero
      //  see if there's one for CRM
       if (not Assigned(eidStream)) or ((FAWEstimateID = 0) and (FEstimateID = 0) and (FCRMEstimateID=0)) then
        begin
          eidStream := FDoc.docData.FindData(ddCRMMSEstimateData);
          if Assigned(eidStream) then
            begin
              FCRMEstimateID := PInteger(eidStream.memory)^;
              FNewEstimate := FEstimateID = 0;
            end;
        end;
    end;
end;

destructor TSwiftEstimator.Destroy;
begin
  //check and do stuff here before freeing

  inherited;
end;

//displays the Swift Estimator property info dialog
function TSwiftEstimator.GetInitialInfo: Boolean;
var
  CEPort: TCostEstimatorPort;
begin
  CEPort := TCostEstimatorPort.Create(nil);   //ask for initial info
  CEPort.Manager := Self;                     //save the data to the manager
  try
    result := CEPort.ShowModal = mrOK;        //show the user
  finally
    FTransferToCostApproach := CEPort.TransferToCostApproach;
    CEPort.Free;
  end;
end;

//launches the Swift Estimator browser
procedure TSwiftEstimator.LaunchSwiftEstimatorSite;
var
  MSSite: TMarshalSwiftSite;
  encodeToken:String;
begin
  try
    MSSite := TMarshalSwiftSite.create(nil);
    MSSite.Manager := Self;
    if pos('http',SecurityToken) = 0 then
      begin
        encodeToken := uWebUtils.URLEncode(TRIM(SecurityToken));
        MSSite.HomeURL := SwiftEstimatorURL+encodeToken;
      end
    else
      MSSite.HomeURL := SecurityToken;     //comes URL encoded from our Web Service
    MSSite.Show;
  except on E:Exception do
     ShowNotice(errOnCostAnalysis+' | '+E.Message);
  end;
end;

procedure TSwiftEstimator.ShowHowToRedoEstimate;
begin
  if Successful then
    ShowOneTime(HowToReCalc, appPref_MSReCalcMsg);
end;


{////////////////////////////////////////////////////////////////////////////////
these are just the local functions used while parsing the XML
////////////////////////////////////////////////////////////////////////////////}
function GetStyleDesc(StyleID: Integer): string;
begin
  case StyleID of
    1:  result := 'One Story';
    2:  result := 'Two Story';
    3:  result := 'Three Story';
    4:  result := 'Split Level';
    5:  result := '1 1/2 Story Finished';
    6:  result := '1 1/2 Story Unfinished';
    7:  result := '2 1/2 Story Finished';
    8:  result := '2 1/2 Story Unfinished';
    9:  result := '3 1/2 Story Finished';
    10: result := '3 1/2 Story Unfinished';
    11: result := 'Bi-level (Total Area)';
    12: result := 'Bi-level';
    13: result := 'Singlewide';
    14: result := 'Doublewide';
    15: result := 'Triple Wide';
    16: result := 'Quad Wide';
    17: result := 'Tagalong Singlewide';
    18: result := 'Tagalong Doublewide';
    19: result := 'Yard Improvements';
  else
    result := '';
  end;
end;

function getComponentDesc(ComponentID: integer): string;
begin
  case ComponentID of
    101: Result := 'Frame, Hardboard Sheets';
    102: Result := 'Frame, Metal or Vinyl Siding';
    103: Result := 'Frame, Plywood';
    104: Result := 'Frame, Plywood or Hardboard';
    105: Result := 'Frame, Siding';
    106: Result := 'Frame, Siding, Metal';
    107: Result := 'Frame, Siding, Vinyl';
    108: Result := 'Frame, Siding, Wood';
    109: Result := 'Frame, Stucco';
    110: Result := 'Frame, Stucco or Siding';
    111: Result := 'Frame, Synthetic Plaster (EIFS)';
    112: Result := 'Frame, Wood Shake';
    114: Result := 'Frame, Wood Shingle';
    115: Result := 'Rustic Log';
    116: Result := 'Frame, Siding/Shingle';
    117: Result := 'Frame, Cement Fiber';
    118: Result := 'Frame, Cement Fiber Siding';
    119: Result := 'Frame, Cement Fiber Sheet';
    131: Result := 'Veneer, Brick';
    133: Result := 'Veneer, Masonry';
    134: Result := 'Veneer, Stone';
    161: Result := 'Masonry, Adobe Block';
    162: Result := 'Masonry, Common Brick';
    163: Result := 'Masonry, Concrete Block';
    165: Result := 'Masonry, Face Brick';
    166: Result := 'Masonry, Face Brick or Stone';
    167: Result := 'Masonry, Poured Concrete (SIP Forming)';
    168: Result := 'Masonry, Stone on Block';
    169: Result := 'Masonry, Stucco on Block';
    181: Result := 'Aluminium Sheet';
    182: Result := 'Aluminium Lap';
    183: Result := 'Cement Fiber Sheet';
    184: Result := 'Cement Fiber Lap';
    185: Result := 'Hardboard Sheet';
    186: Result := 'Hardboard Lap';
    187: Result := 'Log Siding';
    188: Result := 'Plywoods with Batts';
    189: Result := 'Stucco';
    190: Result := 'Vinyl Lap';
    191: Result := 'Wood Lap';
    192: Result := 'Aluminium';
    194: Result := 'Lap';
  else
    result := '';
  end;
end;

function getConditionDesc(ConditionValue: integer): string;
begin
  if (ConditionValue = 1) then
       result := 'Worn Out'
  else if (ConditionValue > 1) and (ConditionValue < 2) then
       result := 'Worn Out/Badly Worn'
  else if (ConditionValue = 2) then
       result := 'Badly Worn'
  else if (ConditionValue > 2) and (ConditionValue < 3) then
       result := 'Badly Worn/Average'
  else if (ConditionValue = 3) then
       result := 'Average'
  else if (ConditionValue > 3) and (ConditionValue < 4) then
       result := 'Average/Good'
  else if (ConditionValue = 4) then
       result := 'Good'
  else if (ConditionValue > 4) and (ConditionValue < 5) then
       result := 'Good/Very Good'
  else if (ConditionValue = 5) then
       result := 'Very Good'
  else if (ConditionValue > 5) and (ConditionValue < 6) then
       result := 'Very Good/Excellent'
  else if (ConditionValue >= 6) then
       result := 'Excellent'
  else
      result := '';
end;

//get the Region description from the RE Web service
function getRegionFromZip(sZip: WideString): string;
begin
  try
    with GetMarshalSwiftServiceSoap(True, UWebConfig.GetURLForMarshallSwift) do
    begin
      Result := GetRegionFromZip(sZip);
    end;
  except
    Result := '';
  end;
end;
{////////////////////////////////////////////////////////////////////////////////
determines which adjustment value to use, sometime the
default adjustment values are overridden
////////////////////////////////////////////////////////////////////////////////}
function useAdjustmentValue(RE7Estimate_Node: IXMLNode; sAttrName: string): string;
var i: integer;
    Adj_Node: IXMLNode;

    function getDefaultValue(): string;
      var j: integer;
      Temp_Node: IXMLNode;
    begin
      for j:= 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
      begin
        if (RE7Estimate_Node.ChildNodes[j].LocalName = 'CostAdj') and
           (RE7Estimate_Node.ChildNodes[j].Attributes['Override'] = '0')  then
        begin
          Temp_Node := RE7Estimate_Node.ChildNodes[j];
          if Temp_Node.HasAttribute(sAttrName) then
          begin
             result := Temp_Node.Attributes[sAttrName];
             break;
          end
          else
          begin
             result := '';
             break;
          end;
        end;
      end;
    end;
begin
  for i:=0 to RE7Estimate_Node.ChildNodes.Count - 1 do
  begin
    if (RE7Estimate_Node.ChildNodes[i].LocalName = 'CostAdj') and  //check if override adjustment exists
       (RE7Estimate_Node.ChildNodes[i].Attributes['Override'] = '2')  then
    begin
      Adj_Node := RE7Estimate_Node.ChildNodes[i];
      if Adj_Node.HasAttribute(sAttrName) then
      begin
        result := Adj_Node.Attributes[sAttrName];
        break;
      end
      else
      begin
        result := getDefaultValue(); // use default value from 0 override
        break;
      end;
    end
    else
    begin
      result := getDefaultValue();
      break;
    end;
  end;
end;

function getEnergyAdjDesc(EnergyAdjID: integer): string;
begin
  if (EnergyAdjID >=3) and (EnergyAdjID <=4) then
        Result := 'Mild'
  else if (EnergyAdjID >4) and (EnergyAdjID <=6) then
        Result := 'Moderate'
  else if (EnergyAdjID >6) and (EnergyAdjID <=7) then
        Result := 'Extreme'
  else if (EnergyAdjID >=8) then
        Result := 'Superinsulated'
  else Result := '';
end;

function getFoundationAdjDesc(FoundationAdjID: integer): string;
begin
  if (FoundationAdjID >=3) and (FoundationAdjID <=4) then
        Result := 'Mild'
  else if (FoundationAdjID >4) and (FoundationAdjID <=6) then
        Result := 'Moderate'
  else if (FoundationAdjID >=6) then
        Result := 'Extreme'
  else Result := '';
end;

function getHillsideAdjDesc(HillsideAdjID: integer): string;
begin
  case HillsideAdjID of
  1: Result := 'Flat';
  2: Result := 'Moderate';
  3: Result := 'Steep';
  else
    Result := '';
  end;
end;

function getSeismicAdjDesc(SeismicAdjID: integer): string;
begin
  case SeismicAdjID of
  1: Result := 'None';
  3: Result := '1';
  4: Result := '2';
  5: Result := '3';
  6: Result := '4';
  else
    Result := '';
  end;
end;
{////////////////////////////////////////////////////////////////////////////////
builds the second page for the 1007 SB and 1007 MMH forms

the function builds two arrays which hold the result and total lists
////////////////////////////////////////////////////////////////////////////////}

function BuildSecondPageEx(EstimateResult_Node: IXMLNode;
var TotalList: TRE7EstimateResultList; var DetailList: TRE7EstimateResultList): boolean;
var
  j,len, Group: integer;
  d: double;
begin
  //check if there is customid=0 followed by another customid=0
  Result:= False;
  Group := 0;

  for j:=0 to EstimateResult_Node.ChildNodes.Count - 1 do
  begin
   if (EstimateResult_Node.ChildNodes[j].Attributes['CustomID'] = '0') and (j>1) then
   begin

     //if the prev line has a nonzero customID then add it to the list for total
     if CompareText(EstimateResult_Node.ChildNodes[j-1].Attributes['CustomID'], '0') <> 0 then
     begin
       len := Length(TotalList);
       SetLength(TotalList, len+1);

       d := EstimateResult_Node.ChildNodes[j-1].Attributes['Total'];
       TotalList[len].Component := 'Total for line ' + EstimateResult_Node.ChildNodes[j-1].Attributes['CustomID'] + ':';
       TotalList[len].ExtCost := Format('%8.2f',[d]);

       Group := j-1;
       TotalList[len].Group := Group;
       TotalList[len].Order := Group;
     end;

     len := Length(DetailList);
     SetLength(DetailList,len+1);

     //add the detail
     if EstimateResult_Node.ChildNodes[j].HasAttribute('Description') then
        DetailList[len].Component := EstimateResult_Node.ChildNodes[j].Attributes['Description'];

     if EstimateResult_Node.ChildNodes[j].HasAttribute('Unit') then
        if EstimateResult_Node.ChildNodes[j].Attributes['Unit'] <> 0 then
          DetailList[len].Quantity := EstimateResult_Node.ChildNodes[j].Attributes['Unit'];

     if EstimateResult_Node.ChildNodes[j].HasAttribute('Cost') then
        if EstimateResult_Node.ChildNodes[j].Attributes['Cost'] <> 0 then
          DetailList[len].UnitCost := EstimateResult_Node.ChildNodes[j].Attributes['Cost'];

     if EstimateResult_Node.ChildNodes[j].HasAttribute('DetailLevel') then
        if CompareText(EstimateResult_Node.ChildNodes[j].Attributes['DetailLevel'], '6') = 0 then
        begin
          if EstimateResult_Node.ChildNodes[j].HasAttribute('Factor') then
          begin
            //format to 3 decimal places Format('%8.3f', [Factor]);
            if EstimateResult_Node.ChildNodes[j].Attributes['Factor'] <> 0 then
            begin
              d := EstimateResult_Node.ChildNodes[j].Attributes['Factor'];
              DetailList[len].ExtCost := Format('%8.2f',[d]);
            end;
          end;
        end
        else
        begin
          if EstimateResult_Node.ChildNodes[j].HasAttribute('Total') then
          begin
            //format to 3 decimal places Format('%8.3f', [Factor]);
            if EstimateResult_Node.ChildNodes[j].Attributes['Total'] <> 0 then
            begin
              d := EstimateResult_Node.ChildNodes[j].Attributes['Total'];
              DetailList[len].ExtCost := Format('%8.2f',[d]);
            end;
          end;
        end;

     DetailList[len].Group := Group;
     DetailList[len].Order := j;
     Result := True;
   end;
  end;
end;

{///////////////////////////////////////////////////////////////////////////////
this procedure is just used for testing to write the second page array to a
text file not used in production environment or any other purpose
///////////////////////////////////////////////////////////////////////////////}
procedure writeArrayToText(ResultList: TRE7EstimateResultList; TotalList: TRE7EstimateResultList);
var i: integer;
  F,T: TextFile;
  S: string;

begin
  if FileExists('C:\Projects\DetailList.txt') then DeleteFile('C:\Projects\DetailList.txt');
  AssignFile(F, 'C:\Projects\DetailList.txt');
  Rewrite(F);

  S := 'Component' + #9 + 'Quantity' + #9 + 'UnitCost' + #9 + 'ExtCost' + #9 + 'Group' + #9 + 'Order';
  Writeln(F, S);

  for i:=0 to Length(ResultList) -1 do
  begin
    S := ResultList[i].Component + #9 + ResultList[i].Quantity + #9 + ResultList[i].UnitCost + #9 + ResultList[i].ExtCost + #9 + IntToStr(ResultList[i].Group) + #9 + IntToStr(ResultList[i].Order);
    Writeln(F, S);
  end;
  CloseFile(F);

  if FileExists('C:\Projects\TotalList.txt') then DeleteFile('C:\Projects\TotalList.txt');
  AssignFile(T, 'C:\Projects\TotalList.txt');
  Rewrite(T);
  S := 'Component' + #9 + 'Quantity' + #9 + 'UnitCost' + #9 + 'ExtCost' + #9 + 'Group' + #9 + 'Order';
  Writeln(T, S);

  for i:=0 to Length(TotalList) -1 do
  begin
    S := TotalList[i].Component + #9 + TotalList[i].Quantity + #9 + TotalList[i].UnitCost + #9 + TotalList[i].ExtCost + #9 + IntToStr(TotalList[i].Group) + #9 + IntToStr(TotalList[i].Order);
    Writeln(T, S);
  end;
  CloseFile(T);

end;

procedure writeHeaderInformation(Form: TDocForm; RE7Estimate_Node: IXMLNode);
var s: string;
begin
  //header informations
  if RE7Estimate_Node.HasAttribute('PropertyOwner') then
  Form.SetCellDataNP(1, 5, RE7Estimate_Node.Attributes['PropertyOwner']);

  if RE7Estimate_Node.HasAttribute('PropertyAddress') then
  Form.SetCellDataNP(1, 6, RE7Estimate_Node.Attributes['PropertyAddress']);

  if RE7Estimate_Node.HasAttribute('PropertyCity') then
  Form.SetCellDataNP(1, 7, RE7Estimate_Node.Attributes['PropertyCity']);

  if RE7Estimate_Node.HasAttribute('PropertyState') then
  Form.SetCellDataNP(1, 8, RE7Estimate_Node.Attributes['PropertyState']);

  if RE7Estimate_Node.HasAttribute('SurveyDate') then
  Form.SetCellDataNP(1, 10, RE7Estimate_Node.Attributes['SurveyDate']); //Date

  if RE7Estimate_Node.HasAttribute('EstimateCode') then
  Form.SetCellDataNP(1, 11, RE7Estimate_Node.Attributes['EstimateCode']);

  if RE7Estimate_Node.HasAttribute('SurveyedBy') then
  Form.SetCellDataNP(1, 12, RE7Estimate_Node.Attributes['SurveyedBy']); //survayed by

  if RE7Estimate_Node.HasAttribute('CostAsOf') then
  begin
    s := FormatDateTime('mmmm, yyyy', StrToDateEx(RE7Estimate_Node.Attributes['CostAsOf'], 'MM/dd/yyyy','/'));
    Form.SetCellDataNP(1, 13, s); //cost as of
  end;

  if RE7Estimate_Node.HasAttribute('UserDefined4') then
  Form.SetCellDataNP(1, 14, RE7Estimate_Node.Attributes['UserDefined4']); //appraised for

end;

{///////////////////////////////////////////////////////////////////////////////
this funciton pasres the XML for 1007 Site Built form
///////////////////////////////////////////////////////////////////////////////}
function TSwiftEstimator.ParseResidentialHomeXML(XMLStr: string): boolean;
var
  XMLDOM: IXMLDocument;
  RE7Estimate_Node: IXMLNode;
  EstimateResult_Node: IXMLNode;

  Group_Node: IXMLNode;
  System_Node: IXMLNode;
  Component_Node: IXMLNode;

  Form: TDocForm;
  i,j,k,l, Ln17Ctr, Ln22Ctr : integer;
  TempStr, str: String;
  iComp,iQty, iCost, iExCost: integer;
  wStr: widestring;
  ResultList, TotalList: TRE7EstimateResultList;
  D: Double;

      //used for moving to the 2nd page which doning the components
      procedure movetoNextPage;
      begin
        //if this page is full move to next page
        if (iComp > 375) and (Form.frmSpecs.fFormUID <> cMarshalSwiftForm_Page2UID) then
        begin
          //reset the row sequence id for page2
          iComp := 15;
          iQty  := 16;
          iCost := 17;
          iExCost:=18;

          Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_Page2UID, 0, False);
          if assigned(form) then
            Form.ClearFormText
          else
            Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_Page2UID, 0, True); //True = AutoLoad,0=zero based

          writeHeaderInformation(Form, RE7Estimate_Node);
        end;
      end;

      //writes the result line in the component section
      procedure doResultLine;
      begin
        movetoNextPage;

        Form.SetCellDataNP(1, iComp, ResultList[i].Component);
        if (ResultList[i].Quantity <> '0') or (ResultList[i].Quantity <> '0.00') then Form.SetCellDataNP(1, iQty, ResultList[i].Quantity);
        if (ResultList[i].UnitCost <> '0') or (ResultList[i].UnitCost <> '0.00') then Form.SetCellDataNP(1, iCost, ResultList[i].UnitCost);
        Form.SetCellDataNP(1, iExCost, ResultList[i].ExtCost);

        //increment for next line
        Inc(iComp,7);
        Inc(iQty,7);
        Inc(iCost,7);
        Inc(iExCost,7);
      end;

      //writes the total line in the component section
      procedure doTotalLine;
      var z: integer;
      begin
        movetoNextPage;

        //now do the total line
        for z:= 0 to Length(TotalList) -1 do
        begin
          if TotalList[z].Group = J then
          begin
            //get the Component and Extended cost for the total
            Form.SetCellDataNP(1, iComp, TotalList[z].Component);
            Form.SetCellDataNP(1, iExCost, TotalList[z].ExtCost);
            Break;
          end;
        end;

        //increment to skip one lines
        Inc(iComp,7*2);
        Inc(iQty,7*2);
        Inc(iCost,7*2);
        Inc(iExCost,7*2);
        J := ResultList[i].Group;
      end;

      //parses the cutomID which represent a line number on the 1007 form
      procedure parseCustomID(iDescCellID, iQtyCellID, iCostCellID, iPlus, iMinus, iTotalCellID: integer;
      ER_Node: IXMLNode;
      ShowDesc: boolean; ShowPlusMinus: boolean; ShowTotalOnly: boolean);
      begin
        if (ShowTotalOnly = false) and (ShowDesc = true) then Form.SetCellDataNP(1, iDescCellID, ER_Node.Attributes['Description']);

        if ER_Node.Attributes['Total'] <> 0 then
        begin
          if ShowTotalOnly = false then
          begin
            if ER_Node.Attributes['Unit'] <> 0 then Form.SetCellDataNP(1, iQtyCellID, ER_Node.Attributes['Unit']);
            if ER_Node.Attributes['Cost'] <> 0 then Form.SetCellDataNP(1, iCostCellID, ER_Node.Attributes['Cost']);
          end;

          if ShowPlusMinus then
          begin
            TempStr := '';
            TempStr := Copy(ER_Node.Attributes['Total'], 0, 1 );
            if TempStr = '-' then
               Form.SetCellDataNP(1, iMinus, TempStr)
            else
               Form.SetCellDataNP(1, iPlus, '+');
          end;
          Form.SetCellDataNP(1, iTotalCellID, ER_Node.Attributes['Total']);
        end;
      end;

begin
  try
    result := true;
    Ln17Ctr :=0;
    Ln22Ctr :=0;

    //create doc if we don't have one
    if FDoc = nil then
      FDoc := Main.NewEmptyDoc;

    //if this report has a manufactured housing form, delete it
    k := FDoc.GetFormIndexByOccur(cMarshalSwiftForm_MMH_UID,0);
    if (k>=0) then
        FDoc.DeleteForm(k);

    //if this report has a manufactured housing form second page, delete it
    k := FDoc.GetFormIndexByOccur(cMarshalSwiftForm_Page2UID,0);
    if (k>=0) then
        FDoc.DeleteForm(k);

    //check the for existance in the report
    Form := FDoc.GetFormByOccurance(cMarshalSwiftFormUID, 0, False); //false = do not autoload
    //if exists clear all text on the form
    if assigned(Form) then
      Form.ClearFormText
    //otherwise insert a new form
    else
      Form := FDoc.GetFormByOccurance(cMarshalSwiftFormUID, 0, True); //true = autoload

    if (Form = nil) then
    begin
      ShowNotice('Marshall & Swift form ID '+IntToStr(cMarshalSwiftFormUID)+' was not be found in the Forms Library.');
      result := false;
    end
    else
    begin
      //XMLDOM := LoadXMLDocument('C:\Projects\RE7.XML');
      XMLDOM := LoadXMLData(XMLStr);

      //XMLDOM.SaveToFile(ExtractFileDir(Application.ExeName)+'\RE7_SB.XML');

      if not XMLDOM.IsEmptyDoc then
      begin
        RE7Estimate_Node := XMLDOM.ChildNodes.FindNode('RE7Estimate');
          if RE7Estimate_Node <> nil then
          begin

            //header informations
            if RE7Estimate_Node.HasAttribute('PropertyOwner') then
            Form.SetCellDataNP(1, 5, RE7Estimate_Node.Attributes['PropertyOwner']);
            if RE7Estimate_Node.HasAttribute('PropertyAddress') then
            Form.SetCellDataNP(1, 6, RE7Estimate_Node.Attributes['PropertyAddress']);
            if RE7Estimate_Node.HasAttribute('PropertyCity') then
            Form.SetCellDataNP(1, 7, RE7Estimate_Node.Attributes['PropertyCity']);
            if RE7Estimate_Node.HasAttribute('PropertyState') then
            Form.SetCellDataNP(1, 8, RE7Estimate_Node.Attributes['PropertyState']);
            if RE7Estimate_Node.HasAttribute('PropertyZipcode') then
            begin
              Form.SetCellDataNP(1, 9, RE7Estimate_Node.Attributes['PropertyZipcode']);
              wStr := '';
              wStr := getRegionFromZip(RE7Estimate_Node.Attributes['PropertyZipcode']);
              if CompareText(wStr, 'Western') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,25), true); //western
              if CompareText(wStr, 'Central') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,26), true); //central
              if CompareText(wStr, 'Eastern') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,27), true); //eastern
            end;

            if RE7Estimate_Node.HasAttribute('ResidenceTypeID') then //residence type
            begin
              case RE7Estimate_Node.Attributes['ResidenceTypeID'] of
                1:Form.SetCellDataNP(1, 15, 'Single-family Residence');
                2:Form.SetCellDataNP(1, 15, 'Low-rise Multiple');
                3:Form.SetCellDataNP(1, 15, 'Town House, End Unit');
                4:Form.SetCellDataNP(1, 15, 'Town House, Inside Unit');
                5:Form.SetCellDataNP(1, 15, 'Duplex');
              else
                Form.SetCellDataNP(1, 15, '');
              end;
            end;

            if RE7Estimate_Node.HasAttribute('Style1Percent') then //style
              if (RE7Estimate_Node.Attributes['Style1Percent'] = '100') then
              begin
                  Form.SetCellDataNP(1, 18,
                  getStyleDesc(RE7Estimate_Node.Attributes['Style1ID']) + ' ' +
                  RE7Estimate_Node.Attributes['Style1Percent'] + '%');
              end
              else
              begin
                  str := '';
                  if (RE7Estimate_Node.HasAttribute('Style2ID'))
                  and  (RE7Estimate_Node.HasAttribute('Style1Percent'))
                  and (RE7Estimate_Node.HasAttribute('Style2Percent')) then
                  begin
                    str := getStyleDesc(StrToInt(RE7Estimate_Node.Attributes['Style1ID'])) + ' ' +
                    RE7Estimate_Node.Attributes['Style1Percent'] + '% ' +
                    getStyleDesc(StrToInt(RE7Estimate_Node.Attributes['Style2ID'])) + ' ' +
                    RE7Estimate_Node.Attributes['Style2Percent']+ '%';
                    Form.SetCellDataNP(1, 18, str);
                  end;
              end;

            //now lets check if we have the exterior wall node to parse
            str := '';
            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'Group') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['GroupID'] = '1')  then
              begin
                Group_Node := RE7Estimate_Node.ChildNodes[i];
                for j := 0 to Group_Node.ChildNodes.Count - 1 do
                begin
                  if (Group_Node.ChildNodes[j].LocalName = 'System') and
                     (Group_Node.ChildNodes[j].Attributes['SystemID'] = '1')  then
                  begin
                    System_Node := Group_Node.ChildNodes[j];
                    for k:=0 to System_Node.ChildNodes.Count -1 do
                    begin
                      Component_Node := System_Node.ChildNodes[k];
                      if Component_Node.HasAttribute('ComponentID') then
                      begin
                        str := str + getComponentDesc(Component_Node.Attributes['ComponentID']);
                        if Component_Node.HasAttribute('Percent') then
                           str := str + ' ' +Component_Node.Attributes['Percent'] + '%; '
                        else
                           str := str + '; ';
                      end;
                    end;
                  end;
                end;
              end;
            end;

            if Length(str) > 0 then
            Form.SetCellDataNP(1, 20, str); //exterior wall

            if RE7Estimate_Node.HasAttribute('EffectiveAge') then
            Form.SetCellDataNP(1, 23, RE7Estimate_Node.Attributes['EffectiveAge']); //age

            if RE7Estimate_Node.HasAttribute('ConditionValue') then
            begin
              D := RE7Estimate_Node.Attributes['ConditionValue'];

              Form.SetCellDataNP(1, 24, Format('%1.2f',[D]) + ' ' + getConditionDesc(RE7Estimate_Node.Attributes['ConditionValue'])); //condition
            end;

            if RE7Estimate_Node.HasAttribute('SurveyDate') then
            Form.SetCellDataNP(1, 10, RE7Estimate_Node.Attributes['SurveyDate']); //Date

            if RE7Estimate_Node.HasAttribute('EstimateCode') then
            Form.SetCellDataNP(1, 11, RE7Estimate_Node.Attributes['EstimateCode']);

            //default file number to estimate id by default
            if Length(Form.GetCellText(1,2)) = 0 then
            Form.SetCellDataNP(1, 2, RE7Estimate_Node.Attributes['EstimateCode']); //FileNO

            if RE7Estimate_Node.HasAttribute('SurveyedBy') then
            Form.SetCellDataNP(1, 12, RE7Estimate_Node.Attributes['SurveyedBy']); //survayed by


            if RE7Estimate_Node.HasAttribute('CostAsOf') then
            begin
              str := FormatDateTime('mmmm, yyyy', StrToDateEx(RE7Estimate_Node.Attributes['CostAsOf'], 'MM/dd/yyyy','/'));
              Form.SetCellDataNP(1, 13, str); //cost as of
            end;

            if RE7Estimate_Node.HasAttribute('UserDefined4') then
            Form.SetCellDataNP(1, 14, RE7Estimate_Node.Attributes['UserDefined4']); //appraised for

            if RE7Estimate_Node.HasAttribute('QualityValue') then //quality
            begin
              D:=RE7Estimate_Node.Attributes['QualityValue'];

              if RE7Estimate_Node.Attributes['QualityValue'] = 1 then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Low')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 1) and (RE7Estimate_Node.Attributes['QualityValue'] < 2) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Low/Fair')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 2  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Fair')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 2) and (RE7Estimate_Node.Attributes['QualityValue'] < 3) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Fair/Average')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 3  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Average')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 3) and (RE7Estimate_Node.Attributes['QualityValue'] < 4) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Average/Good')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 4  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Good')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 4) and (RE7Estimate_Node.Attributes['QualityValue'] < 5) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Good/Very Good')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 5  then
               Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Very Good')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 5) and (RE7Estimate_Node.Attributes['QualityValue'] < 6) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Very Good/Excellent')
              else if RE7Estimate_Node.Attributes['QualityValue'] >= 6 then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Excellent')
              else
                Form.SetCellDataNP(1, 16, '');
            end;

            if RE7Estimate_Node.HasAttribute('TotalFloorArea') then
            Form.SetCellDataNP(1, 17, RE7Estimate_Node.Attributes['TotalFloorArea']); //total floor area

            if RE7Estimate_Node.HasAttribute('ApartmentUnits') then
            if RE7Estimate_Node.Attributes['ApartmentUnits'] > 1 then
            Form.SetCellDataNP(1, 19, RE7Estimate_Node.Attributes['ApartmentUnits']); //no of units

            str := useAdjustmentValue(RE7Estimate_Node, 'StoryHeight');
            if Length(str) > 0 then
               Form.SetCellDataNP(1, 21, str); //interior wall height

            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'Group') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['GroupTypeID'] = '9')  then
              begin
                str := useAdjustmentValue(RE7Estimate_Node, 'BasementDepth');
                if Length(str) > 0 then
                   Form.SetCellDataNP(1, 22, str); //Basement Depth
              end;
            end;

            //now lets check if we have the correct results node to parse
            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'EstimateResult') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['ResultType'] = '2')  then
              begin
                EstimateResult_Node := RE7Estimate_Node.ChildNodes[i];
              end;
            end;

            //if we could not find this node exit out with error
            if  EstimateResult_Node <> nil then
            begin
              for i:=0 to EstimateResult_Node.ChildNodes.Count - 1 do
              begin
                if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '1' then
                begin
                  Form.SetCellDataNP(1, 28, EstimateResult_Node.ChildNodes[i].Attributes['Factor']);
                  parseCustomID(0, 29, 30, 0, 0, 31, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '2' then
                begin

                  parseCustomID(32, 33, 34, 35, 36, 37, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '3' then
                begin
                  parseCustomID(38, 39, 40, 41, 42, 43, EstimateResult_Node.ChildNodes[i], true,  true, false);

                  //do the checkbox now
                  str := useAdjustmentValue(RE7Estimate_Node, 'EnergyAdjID');

                  if length(str) > 0 then str := getEnergyAdjDesc(StrToInt(str));

                  if CompareText(str, 'Mild') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,44), true); //mild
                  if CompareText(str, 'Moderate') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,45), true); //moderate
                  if CompareText(str, 'Extreme') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,46), true); //extreme
                  if CompareText(str, 'Superindulated') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,47), true); //superinsulated
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '4' then
                begin
                  parseCustomID(48, 49, 50, 51, 52, 53, EstimateResult_Node.ChildNodes[i], true,  true, false);

                  //FoundationAdjID
                  str := useAdjustmentValue(RE7Estimate_Node, 'FoundationAdjID');

                  if length(str) > 0 then str := getFoundationAdjDesc(StrToInt(str));

                  if CompareText(str, 'Mild') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,54), true); //mild
                  if CompareText(str, 'Moderate') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,55), true); //moderate
                  if CompareText(str, 'Extreme') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,56), true); //extreme

                  //HillsideAdjID
                  str := useAdjustmentValue(RE7Estimate_Node, 'HillsideAdjID');

                  if length(str) > 0 then str := getHillsideAdjDesc(StrToInt(str));
                  if CompareText(str, 'Flat') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,57), true);
                  if CompareText(str, 'Moderate') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,58), true);
                  if CompareText(str, 'Steep') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,59), true);

                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '5' then
                begin
                  parseCustomID(60, 61, 62, 63, 64, 65, EstimateResult_Node.ChildNodes[i], true,  true, false);

                  //SeismicAdjID
                  str := useAdjustmentValue(RE7Estimate_Node, 'SeismicAdjID');

                  if length(str) > 0 then str := getSeismicAdjDesc(StrToInt(str));

                  if CompareText(str, 'None') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,66), true);
                  if CompareText(str, '1') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,67), true);
                  if CompareText(str, '2') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,68), true);
                  if CompareText(str, '3') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,69), true);
                  if CompareText(str, '4') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,70), true);


                  //WindAdjID
                  str := useAdjustmentValue(RE7Estimate_Node, 'WindAdjID');

                  if CompareText(str, '1') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,71), true);
                  if CompareText(str, '4') = 0 then
                          uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,72), true);

                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '6' then
                begin
                  parseCustomID(73, 74, 75, 76, 77, 78, EstimateResult_Node.ChildNodes[i], true,  true, false);

                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '7' then
                begin
                  parseCustomID(79, 80, 81, 82, 83, 84, EstimateResult_Node.ChildNodes[i], true,  true, false);

                  //floor insulation
                  for j := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
                  begin
                    if (RE7Estimate_Node.ChildNodes[j].LocalName = 'Group') and
                       (RE7Estimate_Node.ChildNodes[j].Attributes['GroupID'] = '1')  then
                    begin
                      Group_Node := RE7Estimate_Node.ChildNodes[j];
                      for k := 0 to Group_Node.ChildNodes.Count - 1 do
                      begin
                        if (Group_Node.ChildNodes[k].LocalName = 'System') and
                           (Group_Node.ChildNodes[k].Attributes['SystemID'] = '6')  then
                        begin
                          System_Node := Group_Node.ChildNodes[k];
                          for l:=0 to System_Node.ChildNodes.Count -1 do
                          begin
                            Component_Node := System_Node.ChildNodes[l];
                            if Component_Node.HasAttribute('ComponentID') then
                            begin
                              if CompareText(Component_Node.Attributes['ComponentID'], '651') = 0 then
                                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,85), true);
                              if CompareText(Component_Node.Attributes['ComponentID'], '652') = 0 then
                                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,86), true);
                              if CompareText(Component_Node.Attributes['ComponentID'], '653') = 0 then
                                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftFormUID,1,87), true);
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '8' then
                begin
                  parseCustomID(88, 89, 90, 91, 92, 93, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '9' then
                begin
                  parseCustomID(94, 95, 96, 97, 98, 99, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '10' then
                begin
                  parseCustomID(100, 101, 102, 103, 104, 105, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '11' then
                begin
                  parseCustomID(106, 107, 108, 109, 110, 111, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '12' then
                begin
                  parseCustomID(112, 113, 114, 115, 116, 117, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '13' then
                begin
                  parseCustomID(118, 119, 120, 121, 122, 123, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '14' then
                begin
                  parseCustomID(124, 125, 126, 127, 128, 129, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '15' then
                begin
                  parseCustomID(130, 131, 132, 133, 134, 135, EstimateResult_Node.ChildNodes[i], true,  true, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '16' then
                begin
                  parseCustomID(0, 136, 137, 0, 0, 138, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '17' then
                begin
                  case Ln17Ctr of
                  0:
                    begin
                      parseCustomID(139, 140, 141, 142, 143, 144, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln17Ctr);
                    end;
                  1:
                    begin
                      parseCustomID(145, 146, 147, 148, 149, 150, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln17Ctr);
                    end;
                  2:
                    begin
                      parseCustomID(151, 152, 153, 154, 155, 156, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln17Ctr);
                    end;
                  end;

                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '18' then
                begin
                  parseCustomID(157, 158, 159, 247, 160, 161, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '19' then
                begin
                  parseCustomID(162, 163, 164, 165, 166, 167, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '20' then
                begin
                  parseCustomID(168, 169, 170, 171, 172, 173, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '21' then
                begin
                  parseCustomID(0,174, 175, 0, 0, 176, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '22' then
                begin
                  case Ln22Ctr of
                    0:
                    begin
                      parseCustomID(177, 178, 179, 180, 181, 182, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln22Ctr);
                    end;
                    1:
                    begin
                      parseCustomID(183, 184, 185, 186, 187, 188, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln22Ctr);
                    end;
                    2:
                    begin
                      parseCustomID(189, 190, 191, 192, 193, 194, EstimateResult_Node.ChildNodes[i], true,  true, false);
                      Inc(Ln22Ctr);
                    end;
                  end;
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '23' then
                begin
                  parseCustomID(0, 195, 196, 0, 0, 197, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '24' then
                begin
                  parseCustomID(198, 0, 0, 0, 0, 203, EstimateResult_Node.ChildNodes[i], true,  false, true);
                  Form.SetCellDataNP(1, 198, EstimateResult_Node.ChildNodes[i].Attributes['Description']);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '25' then
                begin
                  parseCustomID(204, 205, 206, 207, 208, 209, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '26' then
                begin
                  parseCustomID(0, 210, 211, 0, 0, 212, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '27' then
                begin
                  parseCustomID(0, 214, 215, 216, 217, 218, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '28' then
                begin
                  parseCustomID(0, 220, 221, 222, 223, 224, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '29' then
                begin
                  parseCustomID(0, 226, 227, 228, 229, 230, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '30' then
                begin
                  parseCustomID(0, 231, 232, 0, 0, 233, EstimateResult_Node.ChildNodes[i], false, false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '31' then
                begin
                  parseCustomID(0, 235, 236, 0, 0, 239, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '32' then
                begin
                  parseCustomID(0, 241, 242, 0, 0, 245, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '33' then
                begin
                  parseCustomID(0, 248, 249, 0, 0, 252, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '34' then
                begin
                  parseCustomID(0, 253, 254, 0, 0, 255, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end;
              end;

              //do the second page, build the array to have all the 4 cols
              if BuildSecondPageEx(EstimateResult_Node, TotalList, ResultList) then
              begin
                //start with cellsequenceids in page1
                iComp := 256;
                iQty  := 257;
                iCost := 258;
                iExCost:=259;
                j := 0;

                //uncomment this line for testing, this write the arrays of second page to text file c:\projects
                //writeArrayToText(ResultList,TotalList);

                //iterate through all the rows in the array
                J := ResultList[0].Group;

                for i:=0 to Length(ResultList) -1 do
                begin
                  if (J <> ResultList[i].Group) then
                        doTotalLine;
                  doResultLine;
                end;

                //do the last line total
                J := ResultList[Length(ResultList) -1].Group;
                doTotalLine;
              end;
            end
            else
            begin
              Exception.Create('ClickFORMS encountered errors importing the results from Marshall & Swift site.');
              result := false;
            end;
          end;
      end;
    end;
  except on e: exception do
    begin
      Raise Exception.Create('Error:' + e.Message);
      result := false;
    end;
  end;
end;

{///////////////////////////////////////////////////////////////////////////////
this function parse XML for manufactured Housing 1007
///////////////////////////////////////////////////////////////////////////////}
function TSwiftEstimator.ParseManufacturedHomeXML(XMLStr: string): boolean;
var
  XMLDOM: IXMLDocument;
  RE7Estimate_Node: IXMLNode;
  EstimateResult_Node: IXMLNode;

  Group_Node: IXMLNode;
  System_Node: IXMLNode;
  Component_Node: IXMLNode;

  Form: TDocForm;
  i,j,k: integer;
  TempStr, str: String;
  iComp,iQty, iCost, iExCost: integer;
  wStr: widestring;
  ResultList, TotalList: TRE7EstimateResultList;
  MainHouse, Tagalong, TagalongSec: integer;

  Line20, Line23, Style1Percent, Style2Percent: Integer;
  D: double;

    procedure movetoNextPage;
    begin
      //if this page is full move to next page
      if (iComp > 332) and (Form.frmSpecs.fFormUID <> cMarshalSwiftForm_Page2UID) then
      begin
        //reset the row sequence id for page2
        iComp := 15;
        iQty  := 16;
        iCost := 17;
        iExCost:=18;

        Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_Page2UID, 0, False);
        if assigned(form) then
          Form.ClearFormText
        else
          Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_Page2UID, 0, True); //True = AutoLoad,0=zero based

        writeHeaderInformation(Form, RE7Estimate_Node);
      end;
    end;

    procedure doResultLine;
    begin
      Form.SetCellDataNP(1, iComp, ResultList[i].Component);
      if (ResultList[i].Quantity <> '0') or (ResultList[i].Quantity <> '0.00') then Form.SetCellDataNP(1, iQty, ResultList[i].Quantity);
      if (ResultList[i].UnitCost <> '0') or (ResultList[i].UnitCost <> '0.00') then Form.SetCellDataNP(1, iCost, ResultList[i].UnitCost);
      Form.SetCellDataNP(1, iExCost, ResultList[i].ExtCost);

      //increment for next line
      Inc(iComp,7);
      Inc(iQty,7);
      Inc(iCost,7);
      Inc(iExCost,7);
    end;

    procedure doTotalLine;
    var z: integer;
    begin
      moveToNextPage;

      //now do the total line
      for z:= 0 to Length(TotalList) -1 do
      begin
        if TotalList[z].Group = J then
        begin
          //get the Component and Extended cost for the total
          Form.SetCellDataNP(1, iComp, TotalList[z].Component);
          Form.SetCellDataNP(1, iExCost, TotalList[z].ExtCost);
          Break;
        end;
      end;

      //increment to skip one lines
      Inc(iComp,7*2);
      Inc(iQty,7*2);
      Inc(iCost,7*2);
      Inc(iExCost,7*2);
      J := ResultList[i].Group;
    end;

    procedure parseCustomID(iDescCellID, iQtyCellID, iCostCellID, iPlus, iMinus, iTotalCellID: integer;
    ER_Node: IXMLNode;
    ShowDesc: boolean; ShowPlusMinus: boolean; ShowTotalOnly: boolean);
    begin
      if (ShowDesc=true) and (ShowTotalOnly = false) then Form.SetCellDataNP(1, iDescCellID, ER_Node.Attributes['Description']);

      if ER_Node.Attributes['Total'] <> 0 then
      begin
        if ShowTotalOnly = false then
        begin
          if ER_Node.Attributes['Unit'] <> 0 then
          begin
            Form.SetCellDataNP(1, iQtyCellID, ER_Node.Attributes['Unit']);
            if ER_Node.Attributes['Cost'] <> 0 then Form.SetCellDataNP(1, iCostCellID, ER_Node.Attributes['Cost']);
          end;
        end;
        if ShowPlusMinus then
        begin
          TempStr := '';
          TempStr := Copy(ER_Node.Attributes['Total'], 0, 1 );
          if TempStr = '-' then
             Form.SetCellDataNP(1, iMinus, TempStr)
          else
             Form.SetCellDataNP(1, iPlus, '+');
        end;
        Form.SetCellDataNP(1, iTotalCellID, ER_Node.Attributes['Total']);
      end;
    end;

begin
  try
    result := true;
    Line20 := 0;
    Line23 := 0;

    //create doc if we don't have one
    if FDoc = nil then
      FDoc := Main.NewEmptyDoc;

    //if this report has a residential form, delete it
    k := FDoc.GetFormIndexByOccur(cMarshalSwiftFormUID,0);
    if (k>=0) then
        FDoc.DeleteForm(k);

    //if this report has a residential form second page, delete it
    k := FDoc.GetFormIndexByOccur(cMarshalSwiftForm_Page2UID,0);
    if (k>=0) then
        FDoc.DeleteForm(k);

    Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_MMH_UID, 0, False);
    if assigned(form) then
      Form.ClearFormText
    else
      Form := FDoc.GetFormByOccurance(cMarshalSwiftForm_MMH_UID, 0, True); //True = AutoLoad,0=zero based

    if (Form = nil) then
      begin
        ShowNotice('Marshall & Swift form ID '+IntToStr(cMarshalSwiftForm_MMH_UID)+' was not be found in the Forms Library.');
        result := false;
      end
    else begin
      //XMLDOM := LoadXMLDocument('C:\Projects\RE7.XML');
      XMLDOM := LoadXMLData(XMLStr);

      //just for testing will remove in final build
      XMLDOM.SaveToFile(ExtractFileDir(Application.ExeName)+'\RE7_MMH.XML');
      if not XMLDOM.IsEmptyDoc then
      begin
        RE7Estimate_Node := XMLDOM.ChildNodes.FindNode('RE7Estimate');
          if RE7Estimate_Node <> nil then
          begin
            //header informations
            if RE7Estimate_Node.HasAttribute('PropertyOwner') then
            Form.SetCellDataNP(1, 5, RE7Estimate_Node.Attributes['PropertyOwner']);

            if RE7Estimate_Node.HasAttribute('PropertyAddress') then
            Form.SetCellDataNP(1, 6, RE7Estimate_Node.Attributes['PropertyAddress']);

            if RE7Estimate_Node.HasAttribute('PropertyCity') then
            Form.SetCellDataNP(1, 7, RE7Estimate_Node.Attributes['PropertyCity']);

            if RE7Estimate_Node.HasAttribute('PropertyState') then
            Form.SetCellDataNP(1, 8, RE7Estimate_Node.Attributes['PropertyState']);

            if RE7Estimate_Node.HasAttribute('PropertyZipcode') then
            begin
              Form.SetCellDataNP(1, 9, RE7Estimate_Node.Attributes['PropertyZipcode']);

              wStr := '';
              wStr := getRegionFromZip(RE7Estimate_Node.Attributes['PropertyZipcode']);
              if CompareText(wStr, 'Western') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftForm_MMH_UID,1,25), true); //western
              if CompareText(wStr, 'Central') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftForm_MMH_UID,1,26), true); //central
              if CompareText(wStr, 'Eastern') = 0 then
                 uMath.SetCellChkMark(FDoc,mc(cMarshalSwiftForm_MMH_UID,1,27), true); //eastern
            end;

            //its always manufactred housing
            Form.SetCellDataNP(1, 15, 'Manufactured Housing');

           //now lets check if we have the exterior wall node to parse
            str := '';
            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'Group') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['GroupID'] = '1')  then
              begin
                Group_Node := RE7Estimate_Node.ChildNodes[i];
                for j := 0 to Group_Node.ChildNodes.Count - 1 do
                begin
                  if (Group_Node.ChildNodes[j].LocalName = 'System') and
                     (Group_Node.ChildNodes[j].Attributes['SystemID'] = '1')  then
                  begin
                    System_Node := Group_Node.ChildNodes[j];
                    for k:=0 to System_Node.ChildNodes.Count -1 do
                    begin
                      Component_Node := System_Node.ChildNodes[k];
                      if Component_Node.HasAttribute('ComponentID') then
                      begin
                        str := str + getComponentDesc(Component_Node.Attributes['ComponentID']);
                        if Component_Node.HasAttribute('Percent') then
                           str := str + ' ' +Component_Node.Attributes['Percent'] + '%; '
                        else
                           str := str + '; ';
                      end;
                    end;
                  end;
                end;
              end;
            end;

            if Length(str) > 0 then
            Form.SetCellDataNP(1, 20, str); //exterior wall

            if RE7Estimate_Node.HasAttribute('EffectiveAge') then
            Form.SetCellDataNP(1, 23, RE7Estimate_Node.Attributes['EffectiveAge']); //age

            if RE7Estimate_Node.HasAttribute('ConditionValue') then
            begin
              D := RE7Estimate_Node.Attributes['ConditionValue'];
              Form.SetCellDataNP(1, 24, Format('%1.2f', [D]) + ' ' + getConditionDesc(RE7Estimate_Node.Attributes['ConditionValue'])); //condition
            end;

            if RE7Estimate_Node.HasAttribute('SurveyDate') then
            Form.SetCellDataNP(1, 10, RE7Estimate_Node.Attributes['SurveyDate']); //Date

            if RE7Estimate_Node.HasAttribute('EstimateCode') then
            Form.SetCellDataNP(1, 11, RE7Estimate_Node.Attributes['EstimateCode']);

            //default file number to estimate id by default
            if Length(Form.GetCellText(1,2)) = 0 then
            Form.SetCellDataNP(1, 2, RE7Estimate_Node.Attributes['EstimateCode']); //FileNO


            if RE7Estimate_Node.HasAttribute('SurveyedBy') then
            Form.SetCellDataNP(1, 12, RE7Estimate_Node.Attributes['SurveyedBy']); //survayed by

            if RE7Estimate_Node.HasAttribute('CostAsOf') then
            begin
              str := FormatDateTime('mmmm, yyyy', StrToDateEx(RE7Estimate_Node.Attributes['CostAsOf'], 'MM/dd/yyyy','/'));
              Form.SetCellDataNP(1, 13, str); //cost as of
            end;

            if RE7Estimate_Node.HasAttribute('UserDefined4') then
            Form.SetCellDataNP(1, 14, RE7Estimate_Node.Attributes['UserDefined4']); //appraised for

            if RE7Estimate_Node.HasAttribute('QualityValue') then //quality
            begin
              D := RE7Estimate_Node.Attributes['QualityValue'];

              if RE7Estimate_Node.Attributes['QualityValue'] = 1 then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Low')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 1) and (RE7Estimate_Node.Attributes['QualityValue'] < 2) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Low/Fair')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 2  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Fair')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 2) and (RE7Estimate_Node.Attributes['QualityValue'] < 3) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Fair/Average')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 3  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Average')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 3) and (RE7Estimate_Node.Attributes['QualityValue'] < 4) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Average/Good')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 4  then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Good')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 4) and (RE7Estimate_Node.Attributes['QualityValue'] < 5) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Good/Very Good')
              else if RE7Estimate_Node.Attributes['QualityValue'] = 5  then
               Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Very Good')
              else if (RE7Estimate_Node.Attributes['QualityValue'] > 5) and (RE7Estimate_Node.Attributes['QualityValue'] < 6) then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Very Good/Excellent')
              else if RE7Estimate_Node.Attributes['QualityValue'] >= 6 then
                Form.SetCellDataNP(1, 16, Format('%1.2f',[D]) + ' Excellent')
              else
                Form.SetCellDataNP(1, 16, '');
            end;

            MainHouse := 0;
            Tagalong  := 0;
            TagalongSec :=0;

            if RE7Estimate_Node.HasAttribute('Style1Width') and RE7Estimate_Node.HasAttribute('Style1Length') then
            begin
              if (RE7Estimate_Node.Attributes['Style1Width'] > 0)  and (RE7Estimate_Node.Attributes['Style1Length'] > 0) then
                MainHouse := RE7Estimate_Node.Attributes['Style1Width'] * RE7Estimate_Node.Attributes['Style1Length'];
            end;

            if RE7Estimate_Node.HasAttribute('Style2Width') and RE7Estimate_Node.HasAttribute('Style2Length') then
            begin
              if (RE7Estimate_Node.Attributes['Style2Width'] > 0)  and (RE7Estimate_Node.Attributes['Style2Length'] > 0) then
                Tagalong  := RE7Estimate_Node.Attributes['Style2Width'] * RE7Estimate_Node.Attributes['Style2Length'];
            end;

            //build the tagalong section
            for i := 0 to RE7Estimate_Node.ChildNodes.Count -1 do
            begin
              Group_Node := RE7Estimate_Node.ChildNodes[i];
              if CompareText(Group_Node.LocalName, 'Group') = 0 then
              if Group_Node.HasAttribute('GroupTypeID') then
              if CompareText(Group_Node.Attributes['GroupTypeID'], '10') = 0 then
              begin
                if Group_Node.HasAttribute('TagalongLength') and Group_Node.HasAttribute('TagalongWidth') then
                TagalongSec := TagalongSec + (Group_Node.Attributes['TagalongLength'] * Group_Node.Attributes['TagalongWidth'])
              end;
            end;

            if RE7Estimate_Node.HasAttribute('TotalFloorArea') then
            Form.SetCellDataNP(1, 17, IntToStr(MainHouse + Tagalong + TagalongSec)); //total floor area


            //style
            //Style1Percent, Style2Percent
            Style1Percent := 0;
            if RE7Estimate_Node.HasAttribute('Style1ID') and (RE7Estimate_Node.HasAttribute('Style1Length')) and (RE7Estimate_Node.HasAttribute('Style1Width')) then
            begin
              Style1Percent := (RE7Estimate_Node.Attributes['Style1Length'] * RE7Estimate_Node.Attributes['Style1Width']) / (MainHouse + Tagalong + TagalongSec)*100;
            end;

            Style2Percent := 0;
            if RE7Estimate_Node.HasAttribute('Style2ID') and (RE7Estimate_Node.HasAttribute('Style2Length')) and (RE7Estimate_Node.HasAttribute('Style2Width')) then
            begin
              Style2Percent := (RE7Estimate_Node.Attributes['Style2Length'] * RE7Estimate_Node.Attributes['Style2Width']) / (MainHouse + Tagalong + TagalongSec)*100;
            end;

            if (Style1Percent = 100) then
            begin
                Form.SetCellDataNP(1, 18,
                getStyleDesc(RE7Estimate_Node.Attributes['Style1ID']) + ' ' +
                IntToStr(Style1Percent)+ '%') ;
            end
            else
            begin
                str := '';
                if (RE7Estimate_Node.HasAttribute('Style2ID')) then
                begin
                  str := getStyleDesc(StrToInt(RE7Estimate_Node.Attributes['Style1ID'])) + ' ' +
                  IntToStr(Style1Percent) + '% ' +
                  getStyleDesc(StrToInt(RE7Estimate_Node.Attributes['Style2ID'])) + ' ' +
                  IntToStr(Style2Percent)+ '% ';
                  Form.SetCellDataNP(1, 18, str);
                end;
            end;

            if RE7Estimate_Node.HasAttribute('ApartmentUnits') then
            if RE7Estimate_Node.Attributes['ApartmentUnits'] > 1 then
            Form.SetCellDataNP(1, 19, RE7Estimate_Node.Attributes['ApartmentUnits']); //no of units

            str := useAdjustmentValue(RE7Estimate_Node, 'StoryHeight');
            if Length(str) > 0 then
               Form.SetCellDataNP(1, 21, str); //interior wall height

            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'Group') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['GroupTypeID'] = '9')  then
              begin
                str := useAdjustmentValue(RE7Estimate_Node, 'BasementDepth');
                if Length(str) > 0 then
                   Form.SetCellDataNP(1, 22, str); //Basement Depth
              end;
            end;

            //now lets check if we have the correct results node to parse
            for i := 0 to RE7Estimate_Node.ChildNodes.Count - 1 do
            begin
              if (RE7Estimate_Node.ChildNodes[i].LocalName = 'EstimateResult') and
                 (RE7Estimate_Node.ChildNodes[i].Attributes['ResultType'] = '2')  then
              begin
                EstimateResult_Node := RE7Estimate_Node.ChildNodes[i];
              end;
            end;

            //if we could not find this node exit out with error
            if  EstimateResult_Node <> nil then
            begin
              for i:=0 to EstimateResult_Node.ChildNodes.Count - 1 do
              begin
                if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '1' then
                begin
                  Form.SetCellDataNP(1, 28, EstimateResult_Node.ChildNodes[i].Attributes['Factor']);
                  parseCustomID(0, 29, 30, 0, 0, 31, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '2' then
                begin
                  if EstimateResult_Node.ChildNodes[i].Attributes['Factor'] <> 0 then
                  begin
                    str := useAdjustmentValue(RE7Estimate_Node, 'WallEnergyAdjID');
                    if str = '2'  then
                       Form.SetCellDataNP(1, 32, IntToStr(EstimateResult_Node.ChildNodes[i].Attributes['Factor'] * 100) + '% of Line 1  (2 x 4) Base Cost')
                    else if str = '3'  then
                       Form.SetCellDataNP(1, 32, IntToStr(EstimateResult_Node.ChildNodes[i].Attributes['Factor'] * 100) + '% of Line 1  (2 x 6)')
                    else if str = '4'  then
                       Form.SetCellDataNP(1, 32, IntToStr(EstimateResult_Node.ChildNodes[i].Attributes['Factor'] * 100) + '% of Line 1  Wood Stresskin Panel')
                    else Form.SetCellDataNP(1, 32, IntToStr(EstimateResult_Node.ChildNodes[i].Attributes['Factor'] * 100))
                  end;
                  parseCustomID(0, 33, 34, 35, 36, 37, EstimateResult_Node.ChildNodes[i], false,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '3' then
                begin
                  parseCustomID(38, 39, 40, 41, 42, 43, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '4' then
                begin
                  parseCustomID(44, 45, 46, 47, 48, 49, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '5' then
                begin
                  parseCustomID(50, 51, 52, 53, 54, 55, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '6' then
                begin
                  parseCustomID(56, 57, 58, 59, 60, 61, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '7' then
                begin
                  parseCustomID(62, 63, 64, 65, 66, 67, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '8' then
                begin
                  parseCustomID(68, 69, 70, 71, 73, 73, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '9' then
                begin
                  parseCustomID(74, 75, 76, 77, 78, 79, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '10' then
                begin
                  parseCustomID(80, 81, 82, 83, 84, 85, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '11' then
                begin
                  parseCustomID(86, 87, 88, 89, 90, 91, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '12' then
                begin
                  parseCustomID(92, 93, 94, 95, 96, 97, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '13' then
                begin
                  parseCustomID(98, 99, 100, 101, 102, 103, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '14' then
                begin
                  parseCustomID(104, 105, 106, 107, 108, 109, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '15' then
                begin
                  parseCustomID(0, 110, 111, 0, 0, 112, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '16' then
                begin
                  parseCustomID(113, 0, 0, 0, 0, 114, EstimateResult_Node.ChildNodes[i], false,  false, true);
                  Form.SetCellDataNP(1, 113, EstimateResult_Node.ChildNodes[i].Attributes['Description']);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '17' then
                begin
                  parseCustomID(0, 116, 117, 0, 0, 118, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '18' then
                begin
                  parseCustomID(119, 120, 121, 122, 123, 124, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '19' then
                begin
                  parseCustomID(125, 126, 127, 128, 129, 130, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                //deal with multiple lines
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '20' then
                begin
                  if Line20 < 3 then
                  begin
                    parseCustomID(131 + (Line20 * 7), 133 + (Line20 * 7), 134 + (Line20 * 7), 135 + (Line20 * 7), 136 + (Line20 * 7), 137 + (Line20 * 7), EstimateResult_Node.ChildNodes[i], true,  true, false);
                    Inc(Line20);
                  end;
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '21' then
                begin
                  parseCustomID(152, 153, 154, 155, 156, 157, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '22' then
                begin
                  parseCustomID(158, 159, 160, 161, 162, 163, EstimateResult_Node.ChildNodes[i], true,  true, false);
                end
                //like line 20
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '23' then
                begin
                  if Line23 < 3 then
                  begin
                    parseCustomID(164 + (Line23 * 7), 166 + (Line23 * 7), 167 + (Line23 * 7), 168 + (Line23 * 7), 169 + (Line23 * 7), 170 + (Line23 * 7), EstimateResult_Node.ChildNodes[i], true,  true, false);
                    Inc(Line23);
                  end;
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '24' then
                begin
                  parseCustomID(0, 185, 186, 0, 0, 187, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '25' then
                begin
                  Form.SetCellDataNP(1, 188, EstimateResult_Node.ChildNodes[i].Attributes['Description']);
                  parseCustomID(0, 0, 0, 0, 0, 189, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '26' then
                begin
                  //Form.SetCellDataNP(1, 190, EstimateResult_Node.ChildNodes[i].Attributes['Description']);
                  parseCustomID(0, 0, 0, 0, 0, 191, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '27' then
                begin
                  parseCustomID(0, 192, 193, 0, 0, 194, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '28' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 196, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '29' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 198, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '30' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 200, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '31' then
                begin
                  parseCustomID(0, 201, 202, 0, 0, 203, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '32' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 205, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '33' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 207, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '34' then
                begin
                  parseCustomID(0, 0, 0, 0, 0, 209, EstimateResult_Node.ChildNodes[i], false,  false, true);
                end
                else if EstimateResult_Node.ChildNodes[i].Attributes['CustomID'] = '35' then
                begin
                  parseCustomID(0, 210, 211, 0, 0, 212, EstimateResult_Node.ChildNodes[i], false,  false, false);
                end;
              end;

              //do the second page, build the array to have all the 4 cols
              if BuildSecondPageEx(EstimateResult_Node, TotalList, ResultList) then
              begin
                //start with cellsequenceids in page1
                iComp := 213;
                iQty  := 214;
                iCost := 215;
                iExCost:=216;
                j := 0;

                //uncomment this line for testing, this write the arrays of second page to text file c:\projects
                //writeArrayToText(ResultList,TotalList);

                J := ResultList[0].Group;

                //iterate through all the rows in the result list
                for i:=0 to Length(ResultList) -1 do
                begin
                  //do the page break
                  if (J <> ResultList[i].Group) then
                     doTotalLine;
                  doResultLine;
                end;

                //do the total for last line
                J := ResultList[Length(ResultList) -1].Group;
                doTotalLine;
              end;
            end
            else
            begin
              Exception.Create('ClickFORMS encountered errors importing the results from Swift Estimator site.');
              result := false;
            end;
          end;
      end;
    end;
  except on e: exception do
    begin
      Raise Exception.Create('Error:' + e.Message);
      result := false;
    end;
  end;
end;

function CalcCost(aQty, aCM:Double):Double;
var
 aCost: Double;
begin
   result := aQty;
   aCost := aQty * aCM;
   if aCost <> 0 then
     result :=  aCost;
end;

function TSwiftEstimator.GetMiscComponentTotal(AForm:TDocFOrm; CM:Double):Double;
var
  VR, VR1, VR2, VR3, VR4, VR5, VR6, VR7, VR8: Double;
begin
  result := 0;
  FDoc.SetCellTextByID(896, 'Other Components');

  VR := 0;
  VR1 := AForm.GetCellValue(1, 158); //Porch
  if VR1 <> 0 then
    VR1 := VR1 * (AForm.GetCellValue(1, 159) * CM);

  VR2 := AForm.GetCellValue(1, 163); //Balconies
  if VR2 <> 0 then
    VR2 := VR2 * (AForm.GetCellValue(1, 164) * CM);

  VR3 := AForm.GetCellValue(1, 169); //Stairway
  if VR3 <> 0 then
    VR3 := VR3 * (AForm.GetCellValue(1, 170) * CM);

  VR4 := AForm.GetCellValue(1, 205); //Additional
  if VR4 <> 0 then
    VR4 := VR4 * (AForm.GetCellValue(1, 206) * CM);

  VR5 := AForm.GetCellValue(1, 146); //bsmt 2
  if VR5 <> 0 then
    VR5 := VR5 * (AForm.GetCellValue(1, 147) * CM);

  VR6 := AForm.GetCellValue(1, 152); //bsmt 3
  if VR6 <> 0 then
    VR6 := VR6 * (AForm.GetCellValue(1, 153) * CM);

  VR7 := AForm.GetCellValue(1, 184); //Garage 2
  if VR7 <> 0 then
    VR7 := VR7 * (AForm.GetCellValue(1, 185) * CM);

  VR8 := AForm.GetCellValue(1, 190); //Garage 4
  if VR8 <> 0 then
    VR8 := VR8 * (AForm.GetCellValue(1, 191) * CM);

  //Sum of all
  VR := VR1 + VR2 + VR3 + VR4 + VR5 + VR6 + VR7 + VR8;

  if VR <> 0 then
    result := VR;
end;


//Ticket #1236: Load the value from Marshal & Swift then let the math calculation works for it's own
//NOTE: Most of the extended total columns, we let the math do the work.
procedure TSwiftEstimator.TransferResidentialCost(AForm: TDocForm);
var
  VR,VR1, VR2, VR3, CM: Double;
  N: Integer;
  aStr: String;
begin
  if assigned(AForm) then
    begin
      FDoc.SetCellTextByID(2079, 'Marshall & Swift - Swift Estimator');
      FDoc.SetCellTextByID(2080, GetFirstNumInStr(AForm.GetCellText(1,16), False, N));  //quality
      FDoc.SetCellTextByID(2081, AbbreviateMonth(AForm.GetCellText(1,13)));
      if length(FDoc.GetCellTextByID(874)) = 0 then
        FDoc.SetCellTextByID(874, 'Quality Rating = ' + AForm.GetCellText(1,16) + '. See Marshall & Swift Square Foot Appraisal addendum for additional details.');
      FDoc.SetCheckBoxByID(2077, 'X');    //set Replacement Cost


      //set the site value
      VR := AForm.GetCellValue(1, 252);
      if VR <> 0 then
        FDoc.SetCellValueByID(870, VR);

      //get overall cost multiplier
      CM := AForm.GetCellValue(1,203);
      if CM = 0 then CM := 1.0;         //non-zero multiplier

      //For Dwelling
      FDoc.SetCellTextByID(877, AForm.GetCellText(1,136));      //dwelling
      VR := CalcCost(AForm.GetCellValue(1, 137), CM);
      FDoc.SetCellValueByID(878, VR);

      //For Basement
      VR := AForm.GetCellValue(1, 144); //bsmt total
      if  VR <> 0 then  //Only include the first item, the second and third item sum up in other components
        begin
          FDoc.SetCellTextByID(880, 'Bsmt.');
          VR := AForm.GetCellValue(1, 140);
          FDoc.SetCellValueByID(881, VR);

          VR := AForm.GetCellValue(1, 141) * CM;
          FDoc.SetCellValueByID(882, VR);
        end;

      //For Garages
      VR := AForm.GetCellValue(1, 182);  //only include the first item, 2nd and 3rd sum up in other components
      if VR <> 0 then
        begin
          VR := AForm.GetCellValue(1, 178);
          FDoc.SetCellValueByID(893, VR);

          VR := AForm.GetCellValue(1, 179) * CM;
          FDoc.SetCellValueByID(894, VR);
        end;

       //For Porches, Decks, Breezeways and other
      VR := GetMiscComponentTotal(AForm, CM);
      if VR <> 0 then
        FDoc.SetCellValueByID(897, VR);

      //Depreciation  Physical & functional
      VR := AForm.GetCellValue(1, 218);
      if VR <> 0 then
        FDoc.SetCellValueByID(911, VR);

      //Depreciation  External
      VR := AForm.GetCellValue(1, 224);
      if VR <> 0 then
        FDoc.SetCellValueByID(915, VR);

      //Depreciation  Additional
      VR := AForm.GetCellValue(1, 230);
      if VR <> 0 then
        begin
          VR   :=  VR * (AForm.GetCellValue(1, 227) * CM);
          FDoc.SetCellValueByID(913, VR);
        end;

      //Yard Improvements
      VR  := AForm.GetCellValue(1, 239);
      VR2 := AForm.GetCellValue(1, 245);
      VR := VR + VR2;
      FDoc.SetCellValueByID(871, VR);
    end;
end;


procedure TSwiftEstimator.TransferManufacturedCost(AForm: TDocForm);
Var
  VR, CM: Double;
  N: Integer;
begin
  if assigned(AForm) then
    begin
      FDoc.SetCheckBoxByID(2077, 'X');    //set Replacement Cost
      FDoc.SetCellTextByID(2079, 'Marshall & Swift');
      FDoc.SetCellTextByID(2080, GetFirstNumInStr(AForm.GetCellText(1,16), False, N));  //quality
      FDoc.SetCellTextByID(2081, AbbreviateMonth(AForm.GetCellText(1,13)));
      if length(FDoc.GetCellTextByID(874)) = 0 then
        FDoc.SetCellTextByID(874, 'Quality Rating = ' + AForm.GetCellText(1,16) + '. See Marshall & Swift Square Foot Appraisal For Manufactured Housing addendum for additional details.');

      if AForm.GetCellValue(1,209) > 0 then
        FDoc.SetCellValueByID(870, AForm.GetCellValue(1,209));  //site value

      //local cost multiplier - there are 2, generally the same
      CM := AForm.GetCellValue(1,114);
      if CM = 0 then CM := 1.0;         //non-zero multiplier

      FDoc.SetCellValueByID(900, AForm.GetCellValue(1,110));    //Section1
      FDoc.SetCellValueByID(901, AForm.GetCellValue(1,111));

      if AForm.GetCellValue(1,137) > 0 then
        begin
          FDoc.SetCellTextByID(880, 'Bsmt.');                      //Other1 basement
          FDoc.SetCellValueByID(881, AForm.GetCellValue(1,133));
          FDoc.SetCellValueByID(882, AForm.GetCellValue(1,134));
        end;

      if AForm.GetCellValue(1,157) > 0 then
        begin
          FDoc.SetCellTextByID(896, AForm.GetCellText(1,152));      //Other2 - proches
          FDoc.SetCellValueByID(897, AForm.GetCellValue(1,157));    //Other2 Cost
        end;

      if AForm.GetCellValue(1,170) > 0 then
        begin
          FDoc.SetCellTextByID(898, AForm.GetCellText(1,164));     //Other3 name garages
          FDoc.SetCellValueByID(899, AForm.GetCellValue(1,170));    //Other3 Cost
        end;

      FDoc.SetCellValueByID(2723, CM);  //cost multiplier
      FDoc.SetCellValueByID(876, AForm.GetCellValue(1,194));    //total cost new
      FDoc.SetCellValueByID(911, AForm.GetCellValue(1,196));   //phy & Funct depr
      FDoc.SetCellValueByID(915, AForm.GetCellValue(1,198));   //ext depr

      VR := AForm.GetCellValue(1,205) + AForm.GetCellValue(1,207); //other impr
      FDoc.SetCellValueByID(871, VR);
    end;
end;

//this routine takes the results form the SwiftEstimator form and
//moves some of the data into the Cost Approach of the main form.
procedure TSwiftEstimator.TransferResultsToDocCostApproach;
const
  ResSqftForm = 468;
  MHSqftForm  = 470;
var
  sqftForm: TDocForm;
begin
  if FTransferToCostApproach and assigned(FDoc) then
    begin
      sqftForm := FDoc.GetFormByOccurance(ResSqftForm, 0, False);     //try res first
      if assigned(sqftForm) then
        TransferResidentialCost(sqftForm)
      else begin
        sqftForm := FDoc.GetFormByOccurance(MHSqftForm, 0, False);   //try MH second
        if assigned(sqftForm) then
          TransferManufacturedCost(sqftForm);
      end;
    end;
end;


{///////////////////////////////////////////////////////////////////////////////
this funciton is only called from the UMarshalSwiftSite form when we have
successfully read the ResulXML and ready to parse. This function initiates all
the parsing and logs the transaction on the subscription server.

the global MSHandler object is freed after this function is done
///////////////////////////////////////////////////////////////////////////////}

procedure TSwiftEstimator.TransferResultsToDoc;
var
  XMLDOM: IXMLDocument;
  RE7Estimate_Node: IXMLNode;
begin
  if Length(FResultXML) > 0 then
    begin
      //replace the chr(148) which Marshal Swift doesn't encode as &quot;
      ResultXML := StringReplace(ResultXML, chr(148),'&quot;', [rfReplaceAll]);

      XMLDOM := LoadXMLData(ResultXML);
      if not XMLDOM.IsEmptyDoc then
        begin
          RE7Estimate_Node := XMLDOM.ChildNodes.FindNode('RE7Estimate');
          if RE7Estimate_Node <> nil then
            begin
              //determine if the report is 1007SB or 1007MMH
              if RE7Estimate_Node.HasAttribute('ConstTypeID') then
                if CompareText(RE7Estimate_Node.Attributes['ConstTypeID'], '2') = 0 then
                  ParseManufacturedHomeXML(ResultXML)   //parse and transfer the result
                else
                  ParseResidentialHomeXML(ResultXML);
            end
          else
            Exception.Create('The result was missing the header information.');
        end
      else
        exception.Create('The result returned from the Swift Estimator website was empty.');
    end;
end;

procedure TSwiftEstimator.ChargeServiceFee;
var
  Credentials : clsUserCredentials;
  AcknowledgeRequest: clsAcknowledgement;
  sMsgs: Widestring;
  iMsgID, iTransStatus: integer;
  logTransRes: boolean;
  aVendorTokenKey,aCRMTokenKey:String;
  Location:TLocation;
  EstimateDescID:String;
begin
  Location := TLocation.Create;
  try
    //if the usage is to be charged then log the transaction on the WSMarshalSwift
    if FChargeUsage then
      begin
        sMsgs :=  '';
        iMsgID := 0;
        logTransRes := False;
        iTransStatus := 1;
          if Length(FSwiftSvcAck) = 0 then       //not an AW estimate - use bradfordsoftware services
            begin
              Location.FStreet := FDoc.GetCellTextByID(46);
              Location.FCity   := FDoc.GetCellTextByID(47);
              Location.FState  := FDoc.GetCellTextByID(48);
              Location.FZip    := FDoc.GetCellTextByID(49);
              if FUseCRMRegistration and GetCRM_MarshalNSwiftToken_New(Location,CurrentUser.AWUserInfo, aVendorTokenKey,aCRMTokenKey,FEstimateID) then
                begin
                  VendorTokenKey := aVendorTokenKey;
                  CRMTokenKey := aCRMTokenKey;
                end;
            end
          else
            with GetMarshallSwiftServerPortType(False, UWebConfig.GetAWURLForMarshallSwift) do
            begin
              try
                if FUseCRMRegistration then //tell CRM SM to deduct from Allocations record
                   begin
  ///                SendAckToCRMServiceMgr(CRM_MarshalNSwiftProdUID,CRM_MarshalNSwift_ServiceMethod,VendorTokenKey)
                   end
                else
                  begin
                    AcknowledgeRequest := clsAcknowledgement.Create;
                    AcknowledgeRequest.Received := 1;
                    AcknowledgeRequest.ServiceAcknowledgement := FSwiftSvcAck;
                    {User Credentials}
                    Credentials := clsUserCredentials.Create;
                    Credentials.Username := FAWUsername;
                    Credentials.Password := FAWPassword;
                    Credentials.CompanyKey := FAWCompanyKey;
                    Credentials.OrderNumberKey := FAWOrderNumberKey;
                    Credentials.ServiceId := awsi_CFMarshallSwiftID;
                    Credentials.Purchase := 0;
                    MarshallSwiftServices_Acknowledgement(Credentials, AcknowledgeRequest);
                 end;
              finally
                Credentials.Free;
                if AcknowLedgeRequest <> nil then
                  AcknowledgeRequest.Free;
              end;
          end;
      end;
  finally
    Location.Free;
  end;
end;

{///////////////////////////////////////////////////////////////////////////////
This funciton saves the unique estimate id that we get from M&S to the report.
EstimateID is used for redoing the estimate if the user decided to save his inputs
in the middle and work later. Its also used for redoing the estimate if the users
needs to do any modification.

The user is not charged for the transaction unless a charge event code is sent.
///////////////////////////////////////////////////////////////////////////////}
procedure TSwiftEstimator.SaveEstimateIDToDoc;
var
  eidStream : TMemoryStream;
  Form:TDocForm;
begin
  //create doc if we don't have one
  if FDoc = nil then
    FDoc := Main.NewEmptyDoc;

  //check for the existance in the report
  Form := FDoc.GetFormByOccurance(cMarshalSwiftFormUID, 0, False); //false = do not autoload
  //if exists clear all text on the form
  if assigned(Form) then
    Form.ClearFormText
  //otherwise insert a new form
  else
    Form := FDoc.GetFormByOccurance(cMarshalSwiftFormUID, 0, True); //true = autoload

  if not assigned(Form) then
    raise exception.Create('Marshall & Swift form ID '+IntToStr(cMarshalSwiftFormUID)+' was not be found in the Forms Library.')
  else

    {if NewEstimate then - }
    begin
      //write the estimate id for future use
      eidStream:= TMemoryStream.Create;
      try
        if FAWEstimateID > 0 then
          begin
            eidStream.Write(FAWEstimateID, SizeOf(integer));
            FDoc.docData.UpdateData(ddAWMSEstimateData, eidStream);
          end
        else if FEstimateID > 0 then
          begin
            eidStream.Write(FEstimateID, SizeOf(integer));
            FDoc.docData.UpdateData(ddMSEstimateData, eidStream);
          end
        else if FCRMEstimateID > 0 then
          begin
            eidStream.Write(FCRMEstimateID, SizeOf(integer));
            FDoc.docData.UpdateData(ddCRMMSEstimateData, eidStream);
          end;
        //also save the basic property address on the form
        Form.SetCellDataNP(1, 6, Street);
        Form.SetCellDataNP(1, 7, City);
        Form.SetCellDataNP(1, 8, State);
        Form.SetCellDataNP(1, 9, Zip);
        Form.SetCellDataNP(1, 11, IntToStr(EstimateID));
        Form.SetCellDataNP(1, 2, IntToStr(EstimateID));
      finally
        eidStream.Free;
      end;
    end;
end;

//Routine is called by Browser on closing
procedure TSwiftEstimator.ProcessResults;
begin
  try
    //do we have error message to process - do it first
    if Length(FErrorMsg) > 0 then
       raise exception.Create(FErrorMsg);

    //do we need to save the estimate ID to the report, do it second
    if NewEstimate then
      SaveEstimateIDToDoc;

    //do we have xml results to process - do it third
    TransferResultsToDoc;
    TransferResultsToDocCostApproach;

    //Do we need to charge for this estimate?
    ChargeServiceFee;

    //At this point we have successfully completed estimate
    Successful := True;

  except on E: Exception do
    ShowAlert(atWarnAlert, E.message);
  end;
end;

end.



