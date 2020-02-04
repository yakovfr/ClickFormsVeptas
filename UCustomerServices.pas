unit UCustomerServices;

interface

uses
  Controls, SysUtils, InvokeRegistry, ClfCustServices2014;

type
  ServiceIDs = 1..64;
  ClfServiceIDs = set of serviceIDs;

const
  //service IDs   the same as in UServiceManager
  stMaintanence     = 1;
  stLiveSupport     = 2;
  stAppraisalPort   = 3;
  stLighthouse      = 4;
  stDataImport      = 5;
  stMLS             = 6;
  stFloodMaps       = 7;
  stLocationMaps    = 8;
  stVeroValue       = 9;
  stMarshalAndSwift = 10;
  stFloodData       = 11;
  stFIS             = 12;
  stRels            = 13;
  stUAD             = 14;
  stPictometry      = 15;
  stBuildfax        = 16;
  stPhoenixMobile   = 17;
  stMarketAnalyses  = 18;
  stMercuryNetwork  = 160;

  //service responses constants
  srNotPurchased        = 'Not Purchased';
  srOnSubscription      = 'On Subscription';
  srSubscription        = 'subscription';
  ExpDateNotPurchased   = '';

  //service status codes
  statusNotPurchased    = -1;
  statusNotApplicable   = -1;
  statusOK              = 0;
  statusExpired         = 1;
  statusNoUnits         = 2;
  assignedToUser        = 0;
  assignedToOwner       = 1;
  servTypeRegular       = 1;
  servTypeDemo          = 2;

   //error codes
  errUnknownError       = -1;
  errNoError            = 0;
  errWebServGeneric     = 1;    //from web service
  errADOGeneric         = 2;    //from web service
  errInvaidCustID       = 3;      //from web service
  errNoConnection       = 4;
  errUnknownService     = 5;
  errInvalidIndex       = 6;

  errConnectionMsg      = 'ClickFORMS could not connect. Please make sure you are connected to internet and your firewall is not blocking to access the Internet.';
  errUnknownServiceDescr= 'Unknown Service';
  errUnknownServiceMsg  = 'Cannot get the Service Status: Unknown service ID';
  errInvalidIndexDescr  = 'Invalid Service Index';
  errInvalidIndexMsg    = 'Cannot get the Service Status: Invalid service';

  LimitedUnitsServices: ClfServiceIDs  = [stFloodMaps, stVeroValue, stMarshalAndSwift, stFloodData, stFIS, stPictometry, stBuildfax, stPhoenixMobile];
  CompanyOwedServices: ClfServiceIDs = [stFloodMaps, stVeroValue, stMarshalAndSwift, stFloodData, stFIS, stPictometry, stBuildfax];

type
  EServStatusException = class(Exception)
    excCode: integer;
    excDescr: String;

    constructor Create(code: Integer; descr: String; msg: String); overload;
    constructor Create(eRemote: ERemotableException); overload;
  end;

procedure RefreshServStatuses;
function GetServicesCount: Integer;
function GetServiceByServID(servID: Integer): ServiceInfo;
function GetServiceByIndex(index: Integer): ServiceInfo;
procedure UpdateServiceUsage(servID: Integer; srvType: Integer; searchAddr: String);

implementation

uses
  RIO,
  SoapHTTPClient,
  UDebugTools,
  UGlobals,
  Forms,MSXML6_TLB, UWebUtils, UWebConfig, ULicUser, UUtil2;

var
  ServiceStatuses:  ArrayOfServiceInfo;

constructor EServStatusException.Create(code: Integer; descr: String; msg: String);
begin
  inherited Create(msg);
  excCode := code;
  excDescr := descr;
end;

constructor EServStatusException.Create(eRemote: ERemotableException);
const
  xPathDetail = '//detail';
  attrExcID = 'faultID';
var
  xmlDoc: IXMLDOMDocument2;
begin
  inherited Create(eRemote.Message);
  //get details from ERemotableException
  xmlDoc := CoDomDocument.Create;
  xmlDoc.async := false;
  xmlDoc.setProperty('SelectionLanguage', 'XPath');
  xmlDoc.loadXML(eRemote.FaultDetail);
  excCode := StrToIntDef(xmlDoc.selectSingleNode(xPathDetail).attributes.GetNamedItem(attrExcID).text,errUnknownError);
  excDescr := xmlDoc.text;
end;

procedure RefreshServStatuses;
var
  custID: Integer;
  service: ClfCustServices2014Soap;
  aAWLogin, aAWPsw, aAWCustUID: String;
begin
  SetLength(ServiceStatuses,0);
  if not IsConnectedToWeb  then
    raise EServStatusException.Create(errNoConnection, 'Failed to connect To Internet',errConnectionMsg);

  CurrentUser.GetUserAWLoginByLicType(pidClickForms, aAWLogin, aAWPsw, aAWCustUID); //base on the license type to return either the Real user or trial user
  custID := StrToIntDef(aAWCustUID,0);
  service := GetClfCustServices2014Soap(true,GetUrlForCustServicesEx);
  try
    if debugMode then
      TDebugTools.Debugger.DebugSOAPService((service as IRIOAccess).Rio as THTTPRIO);
    if (custId > 0) and (aAWCustUID <> CF_Trial_CustID) then  //exclude trial user not to load from custDB
      begin
        ServiceStatuses :=  service.GetClfCustServices(WSClfCustService_Password,custID);
        if length(ServiceStatuses) = 0 then   //return empty services;
          ServiceStatuses := service.GetServiceList(WSClfCustService_Password);
      end
    else
      ServiceStatuses := service.GetServiceList(WSClfCustService_Password);
  except
    on e: ERemotableException do
      raise EServStatusException.Create(e);
    on e: Exception do  //unknown generic error
      raise EServStatusException.Create(errUnknownError, 'Failed to get Service Usage Summary',e.Message);
  end;
end;

function GetServicesCount: Integer;
begin
  //if length(ServiceStatuses) = 0 then
  //  RefreshServStatuses;
  result := length(ServiceStatuses);
end;

function GetServiceByServID(servID: Integer): ServiceInfo;
var
  index, nServs: Integer;
begin
  result := nil;
  if length(ServiceStatuses) = 0 then
    RefreshServStatuses;

  nServs := length(ServiceStatuses);
  for index := 0 to nServs - 1 do
    if ServiceStatuses[index].servID = servID then
      begin
        result := ServiceStatuses[index];
        break;
      end;
      
  if index = nServs then
    raise EServStatusException.Create(errUnknownService,errUnknownServiceDescr,errUnknownServiceMsg);
end;

function GetServiceByIndex(index: Integer): ServiceInfo;
begin
  if length(ServiceStatuses) = 0 then
    RefreshServStatuses;
  if (index < 0) or (index >= length(ServiceStatuses)) then
    raise EServStatusException.Create(errInvalidIndex,errInvalidIndexDescr,errInvalidIndexMsg);
  result := ServiceStatuses[index];
end;

procedure UpdateServiceUsage(servID: Integer; srvType: Integer; searchAddr: String);
var
  custID: Integer;
begin
  if not servID in LimitedUnitsServices then
      exit; //do not need to update usage
  if not IsConnectedToWeb  then
    exit; //does not have sense to invoke the exception: the user already sucessfully used the service

  custID := StrToIntDef(currentUser.AWUserInfo.UserCustUID,0);
  with GetClfCustServices2014Soap(true,GetUrlForCustServicesEx) do
  try
    AddServiceUsage(WSClfCustService_Password, custID, servID, srvType, searchAddr);
  except          //do nothing
  end;
end;




initialization

  RemClassRegistry.RegisterXSClass(serviceInfo);


end.


