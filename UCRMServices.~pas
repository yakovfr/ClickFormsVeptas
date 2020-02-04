unit UCRMServices;

interface
uses
  UContainer,ActiveX,WinHTTP_TLB,uLkJSON,SysUtils,ULicUser,Dialogs,Classes,Variants,
  UWebUtils,UForm,Contnrs,IdCoderMIME,{AWSI_Server_MarketConditions,}UMarketConditionServer,XMLDoc,uBase64;
const
  CRM_CensusTractProdUID    = 25;   //this # needs to match with CRM3 prodUID for CensusTract
  CRM_FloodMapsProdUID      = 6;    //this # needs to match with CRM3 prodUID for FloodMaps
  CRM_PictometryProdUID     = 8;    //this # needs to match with CRM3 prodUID for Pictometry
  CRM_BuildFaxProdUID       = 5;    //this # needs to match with CRM3 prodUID for BuildFax
  CRM_LocationMapsProdUID   = 4;    //this # needs to match with CRM3 produID for Location Map
  CRM_LPSProdUID            = 7;    //this # needs to match with CRM3 prodUID for LPS Data(Black-Knight Public Records Service)
  CRM_ClickFORMSProdUID     = 11;   //this # needs to match with CRM3 prodUID for ClickFORMS Software
  CRM_MLSListProdUID        = 27;   //this # needs to match with CRM3 produid for getting MLS state list
  CRM_1004MCProdUID         = 3;    //this # needs to match with CRM3 prodUID for getting 1004MC service
  CRM_MarshalNSwiftProdUID  = 9;    //this # needs to match with CRM3 prodUID for Marshal & Swift

  CRM_CLVSConnectionUID     = 17;   //this # needs to match with CRM3 prodUID for CLVS Connection
  CRM_AppraisalPortProdUID  = 18;   //this # needs to match with CRM3 prodUID for Appraisal Port Connection
  CRM_MercuryNetworkUID     = 19;   //this # needs to match with CRM3 prodUID for Mercury Network Connection
  CRM_VendorPropertyDataUID = 21;   //this # needs to match with CRM3 prodUID for Vendor Property Data


  //Bing Maps Key Service Method
  CRM_BingAccountKey_ServiceMethod = 3;

  //Census Tract Service Method
  CRM_CensusTract_ServiceMethod = 1;

  //Flood Maps by Address Service Method
  CRM_GeoCodeMapByAddress_ServiceMethod = 4;   //need this in get census tract call
  CRM_FloodMapPermission_ServiceMethod = 1;

  //LPS Service Method
  CRM_LPSPublicData_ServiceMethod = 1;

  //Pictometry Service Method
  CRM_Pictometry_ServiceMethod = 1;

  //BuildFax Service Method
  CRM_BuildFax_ServiceMethod = 1;

  //Marshal & Swift Service Method
  CRM_MarshalNSwiftForNew_ServiceMethod  = 1;   //for new
  CRM_MarshalNSwiftForExisting_ServiceMethod = 2;  //for existing

  //1004MC Service Method
  CRM_1004MC_ServiceMethod = 1;


  CRM_GetMLSList_ServiceMethod = 4;
  CRM_GetMLSMap_ServiceMethod  = 3;
  CRM_GetMLSData_ServiceMethod = 1;

  //Appraisal Port Service Method
  CRM_AppraisalPort_ServiceMethod = 1;
  CRM_CLVS_ServiceMethod = 1;
  CRM_Mercury_ServiceMethod = 1;

  CRM_VendorProperty_ServiceMethod = 1;



  CRM_ResponseType = 'json';

  //These are white list with fetchspecial
  CRM_GetMLSList_route           = 'GetMlsList';
  CRM_GetMLSData_route           = 'GetMlsData';
  CRM_GetMLSStateByCountry_route = 'GetMLSStateByCountry';

  CRM_CVRBundleID           = 1;   //this is CompCruncher
  CRM_RedStoneBundleID      = 2;   //this is Redstone
  CRM_CFBundleID            = 0;   //This is ClickFORMS


  CRM_RequestorID_CF        = 1;   //From ClickFORMS always 1

  CRM_Token_MaxHours        = 8;

  COUNTRY_NAME_USA = 'united states';

  CRMBaseURL_DEV = 'https://develop-crmcore.appraisalworld.com';
  CRMBaseURL_LIVE = 'https://crmcore.appraisalworld.com';




Type

  TGeoCode = class (TObject)
  private                                                      
  public
    FTxtStreet: String;
    FTxtCity: String;
    FTxtState: String;
    FTxtZip: String;
    FTxtZipPlus4: String;
    FTxtLon: Double;
    FTxtLat: Double;
    FTxtGeoResult:String;
    FTxtCensusBlockId:String;
    FTxtPrecision:String;
    FNumCandidates: Integer;
    FNumCloseCandidates: Integer;
    FtxtGeoSource:String;
    FGoodCandidate:Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

 TLocation = class (TObject)
 private
 public
   FMapLabel:String;
   FStreet:String;
   FCity:String;
   FState:String;
   FZip:String;
   FPlus4:String;
   FCensusBlock:String;
   FLocSpotted:String;
   FClientID:String;
   FLongitude:String;
   FLatitude:String;
   FGeoResult:String;
   FMapHeight:Integer;
   FMapWidth:Integer;
   FMapZoom: Double;
    constructor Create;
    destructor Destroy; override;
 end;

 TTestResult = class (TObject)
 private
 public
   FName:String;
   FType:String;
   FSFHA:String;
   FNearBy:String;
   FFzDdPhrase:String;
   FCensusTract:String;
   FMapNumber:String;
    constructor Create;
    destructor Destroy; override;
 end;

 TFeature = class (TObject)
 private
 public
   FCommunity:String;
   FCommunity_Name:String;
   FZone:String;
   FPanel:String;
   FPanelDate:String;
   FFIPS:String;
   constructor Create;
   destructor Destroy; override;
 end;

 TMapInfo = class (TObject)
 private
 public
   FImageID:String;
   FLocPtX:String;
   FLocPtY:String;
   FCenterX:String;
   FCenterY:String;
   FImageName:String;
   FImageURL:String;
   FZoom:Integer;
   constructor Create;
   destructor Destroy; override;
 end;

 TFloodMaps = class (TObject)
 private
 public
   FLocation: TLocation;
   FTestResult: TTestResult;
   FFeature: TFeature;
   FMapInfo: TMapInfo;
   FMapImage: String;
   FImageB64: WideString;
   FTxtGeoResult: String;
   constructor Create;
   destructor Destroy; override;
 end;

TNorthImage = class (TObject)
public
  ImageB64: WideString;
  ImageType: String;
end;

TSouthImage = class (TObject)
public
  ImageB64: WideString;
  ImageType: String;
end;

TWestImage = class (TObject)
public
  ImageB64: WideString;
  ImageType: String;
end;

TEastImage = class (TObject)
public
  ImageB64: WideString;
  ImageType: String;
end;

TDownImage = class (TObject)
public
  ImageB64: WideString;
  ImageType: String;
end;


TPictometry = class (TObject)
private
public
  FAddress:String;
  FCity:String;
  FState:String;
  FZip:String;
  FNorthImage: TNorthImage;
  FSouthImage: TSouthImage;
  FWestImage: TWestImage;
  FEastImage: TEastImage;
  FDownImage: TDownImage;
  FMapWidth: Integer;   //Ticket #1561
  FMapHeight: Integer;  //Ticket #1561
  constructor Create;
  destructor Destroy; override;
end;


TContractor = record
  fullName: String;
  address1: String;
  maxDate: String;
  permitCount: Integer;
  id:String;
end;

TCheck = record
  check_Name: String;
  check_result: String;
end;



TJurisdiction = class (TObject)
  address:String;
  city:String;
  state:String;
  zipcode:String;
  website:String;
  maxDate:String;
  minDate:String;
  name:String;
  officialName:String;
  phone:String;
  preferredDate:String;
  CityStZip:String;
end;

TRequestAddress = record
  id:Integer;
  StreetAddress:String;
  city:String;
  state:String;
  zipCode:String;
  County:String;
  Title:String;
  fullAddress:String;
  latitude:String;
  longitude:String;
end;

TPermitResult = Record
  permitNo:Integer;
  LatestPermitDate:String;
  NumberOfPermits:Integer;
  PermitValuation:String;
  NumberOfRisks:Integer;
end;


TBuildFaxPermit = class(TObject)
private
  id:String;
  permitNum:String;
  preferredDate:String;
  issuedDate:String;
  permitTypePreferred:String;
  description:String;
  workClass:String;
  permitStatus:String;
  valuationAmount:String;
  statusDate:String;
  totalSqFt:String;
  contractor:TContractor;
  FCheck: TCheck;
  CheckNames: String;
  officialName:String;
public
  RequestAddress: TRequestAddress;
  PermitResult:TPermitResult;
  jurisdiction:TJurisdiction;
  constructor Create;
  destructor Destroy; override;
end;

TSalesHistory = class(TObject)
  Buyer1FirstName:String;
  Buyer1LastName:String;
  Buyer2FirstName:String;
  Buyer2LastName:String;
  Seller1FirstName:String;
  Seller1LastName:String;
  Seller2FirstName:String;
  Seller2LastName:String;
  DeedType:String;
  SalePrice:Double;
  SaleDate:String;
  REOFlag:Integer;

  constructor Create;
  destructor Destroy; override;
end;

TSubjectProperty = class(TObject)
  Address:String;
  City:String;
  State:String;
  Zip:String;
  Zip4:String;
  Taxes:Double;
  YearBuilt:Integer;
  Longitude:Double;
  Latitude:Double;
  TaxYear:Integer;
  Stories:Integer;
  AssessmentYear:Integer;
  Owner:String;
  TotalRooms:Integer;
  Garage:Integer;
  AssessedLandValue:Double;
  County:String;
  Bedrooms:Integer;
  Basement:Integer;
  AssessedImproveValue:Double;
  APN:String;
  Bath:Double;
  BasementFinish:Integer;
  TotalAssessedValue:Double;
  BriefLegalDescription:String;
  GLA:Integer;
  DesignStyle:String;
  LotSize:Integer;
  CensusTract:String;
  Pool:Integer;
  Fireplace:Integer;
  SiteArea:Double;
  SalesHistory:TSalesHistory;
  FSalesHistory: TObjectList;
  constructor Create;
  destructor Destroy; override;
end;

TPropInfo = class(TObject)
public
  SubjectProperty:TSubjectProperty;

constructor Create;
destructor Destroy; override;
end;

  TGetMlsEnhancementDetails = class(TObject)
  private
    FMlsId: Integer;
    FDataBuffer: WideString;
  published
    property MlsId:      Integer     read FMlsId write FMlsId;
    property DataBuffer: WideString  read FDataBuffer write FDataBuffer;
  end;

  TGetMlsEnhancementResponseData = class(TObject)
  private
    FDataBuffer: WideString;
    FServiceAcknowledgement: WideString;
  published
    property DataBuffer:             WideString  read FDataBuffer write FDataBuffer;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;

  TResults = class(TObject)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code: Integer read FCode write FCode;
    property Type_: WideString read FType_ write FType_;
    property Description: WideString read FDescription write FDescription;
  end;


  TGetMlsEnhancementResponse = class(TObject)
  private
    FResults: TResults;
    FResponseData: TGetMlsEnhancementResponseData;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Results:      TResults                        read FResults write FResults;
    property ResponseData: TGetMlsEnhancementResponseData  read FResponseData write FResponseData;
  end;


TTrendRequest = class(TObject)
  pendingSaleIsSettled: Boolean;
  trendPeriodInterval: Integer;
  effectiveDate: String;
  mlsData: WideString;
  constructor Create;
  destructor Destroy; override;
end;

var
 CRMVendorServer:String;
 CRMServiceRequestURL:String;
 CRMServiceRequest_Fetch_URL:String;
 CRMServiceRequestSendACKURL:String;
 CRM_ServiceRequestURL_GetToken:String;
 CRM_ServiceRequestURL_FetchSpecial:String;
 CRM_Services_URL:String;
 CRM_AddSuggestion_URL:String;
 CRM_AddSupportTicket_URL:String;
 CRM_TopTenSuggesstion_URL:String;

 CRM_RegisterPaid_URL:String;
 CRM_RegisterLogin_URL:String;
 CRM_Registration_Login_URL:String;

 CRMCoreBaseURL:String;


procedure LoadBuildFaxPermitData(doc:TContainer;thisForm:TDocForm;ResponseData:WideString; var bfax:TBuildFaxPermit);
procedure LoadLPSSubjectToPropInfo(doc:TContainer;responseData:String;var propInfo:TPropInfo);


function GetCRMToken(UserName,Password:String;GroupUID:Integer=0):String;
function GetCRM_CensusTract(doc:TContainer; UserCredential:TAWCredentials; latitude, longitude: double; muteError:Boolean): String;

//function GetCRM_FloodMap(Location:TLocation; UserCredential:TAWCredentials; var responseData:String; var FloodMaps:TFloodMaps): Boolean;
//function GetCRM_FloodMapsRespotRequest(RespotRequest: TFloodMaps; var ResponseTxt:String):Boolean;

function GetCRM_GeoCode(doc: TContainer;UserCredential:TAWCredentials;VendorTokenKey:String; var GeoCode:TGeoCode):Boolean;
function GetCRM_Pictometry(UserCredential:TAWCredentials; mapWidth, mapHeight:Integer; var responseData:String; var Pictometry:TPictometry): Boolean;
function GetCRM_BuildFaxPermitData(doc: TContainer;UserCredential:TAWCredentials; var responseData:String; var BuildFaxPermit:TBuildFaxPermit;var VendorTokenKey:String):Boolean;
function GetCRM_LocationMapsAuthenticationKey(UserCredential:TAWCredentials; var BingMapsKey:String):Boolean;
function GetCRM_LPSSubjectData(doc: TContainer;UserCredential:TAWCredentials; var propInfo:TPropInfo):Boolean;
function GetCRM_MLSStatesList(UserCredential:TAWCredentials):String;
//function GetCRM_1004MCData(UserCredential:TAWCredentials;pendingSaleFlag:Integer;dateofAnalysis:WideString;MLSRawDataB64:WideString; var ResponseTxt:String):Boolean;

function GetCRM_MLSStateByCountry(UserCredential:TAWCredentials; var ResponseTxt:String):Boolean;
function GetCRM_MLSNamesByState(UserCredential:TAWCredentials; StateName:String; var MlsItemList:clsMlsDirectoryListing):Boolean;

function GetCRM_MLSList(UserCredential:TAWCredentials):String;
function GetCRM_MLSData(UserCredential:TAWCredentials; MLSDetail:TGetMlsEnhancementDetails; var ResponseTxt:WideString):Boolean;

//Get permission only
function GetCRM_PersmissionOnly(prodUID,serviceMethod:Integer;UserCredential:TAWCredentials;muteError:Boolean;var VendorTokenKey:String; ACK:Boolean=True): Boolean;


//Get Trend analysis
//function GetCRM_TrendAnalysis(TrendRequest:TTrendRequest):Boolean;

//Get M&S Token & estimateId from CRM Service Manager
function GetCRM_MarshalNSwiftToken_New(Location:TLocation; UserCredential:TAWCredentials; var VendorTokenKey:String; var CRMSecurityToken:String; var FCRMEstimateID:Integer):Boolean;
function GetCRM_MarshalNSwiftToken_Existing(Location:TLocation; UserCredential:TAWCredentials; var VendorTokenKey:String; var CRMSecurityToken:String; var FCRMEstimateID:Integer):Boolean;

//TOKENS
//function SendAckToCRMServiceMgr(bundleID,prodUID:Integer; RouteName,VendorTokenKey:String): Boolean;
function SendAckToCRMServiceMgr(prodUID,ServiceMethod:Integer; VendorTokenKey:String): Boolean;
function RefreshCRMToken(UserName,Password:String;GroupUID:Integer=0):String;



implementation
uses
  uGlobals,UStatus,UWindowsInfo,UStrings, Controls, USendHelp,
  UUtil2,UUtil1,UMobile_Utils,DateUtils,UBase;


const
  httpRespOK  = 200;  //OK
  httpResp502 = 502;  //Bad gateway
  httpResp500 = 500;  //Internal error
  httpResp404 = 404;  //no record

  Contractor_Title = 'Contractor:';
  Permit_Title     = 'Permit Types:';

var
  FCRMBundleID: Integer;  //For CF bundleId=0 for Redstone bundleid=2 for CC bundleid = 1;


procedure SetCRMServiceURL;
begin
  if UseProductionService then
    begin
      CRMVendorServer                    := 'production'; //FOR LIVE

      CRMCoreBaseURL                     := 'https://crmcore.appraisalworld.com';

      CRMServiceRequestURL               := 'https://servicerequest.appraisalworld.com';
      CRMServiceRequest_Fetch_URL        := 'https://servicerequest.appraisalworld.com/fetch';
      CRMServiceRequestSendACKURL        := 'https://servicerequest.appraisalworld.com/acknowledgement';
      CRM_ServiceRequestURL_GetToken     := 'https://servicerequest.appraisalworld.com/crmauth/gettoken';
      CRM_ServiceRequestURL_FetchSpecial := 'https://servicerequest.appraisalworld.com/fetchspecial';

      CRM_RegisterPaid_URL               := 'https://services.appraisalworld.com/registration/process';
      CRM_Registration_Login_URL         := 'https://services.appraisalworld.com/registration/login';

      CRM_Services_URL                   := 'https://services.appraisalworld.com';
      CRM_AddSuggestion_URL              := 'https://services.appraisalworld.com/support/AddSuggestion';
      CRM_AddSupportTicket_URL           := 'https://services.appraisalworld.com/support/AddSuportTicket';
      CRM_TopTenSuggesstion_URL          := 'https://crmcore.appraisalworld.com/supporttickets/GetTopSupportCategories';
    end
  else
    begin
      CRMVendorServer                    := 'develop';

      CRMCoreBaseURL                     := 'https://develop-crmcore.appraisalworld.com';

      CRMServiceRequestURL               := 'https://develop-servicerequest.appraisalworld.com';
      CRMServiceRequest_Fetch_URL        := 'https://develop-servicerequest.appraisalworld.com/fetch';
      CRMServiceRequestSendACKURL        := 'https://develop-servicerequest.appraisalworld.com/acknowledgement';
      CRM_ServiceRequestURL_GetToken     := 'https://develop-servicerequest.appraisalworld.com/crmauth/gettoken';
      CRM_ServiceRequestURL_FetchSpecial := 'https://develop-servicerequest.appraisalworld.com/fetchspecial';

      CRM_RegisterPaid_URL               := 'https://develop-services.appraisalworld.com/registration/process';
      CRM_Registration_Login_URL         := 'https://develop-services.appraisalworld.com/registration/login';

      CRM_Services_URL                   := 'https://develop-services.appraisalworld.com';
      CRM_AddSuggestion_URL              := 'https://develop-services.appraisalworld.com/support/AddSuggestion';
      CRM_AddSupportTicket_URL           := 'https://develop-services.appraisalworld.com/support/AddSuportTicket';
      CRM_TopTenSuggesstion_URL          := 'https://develop-crmcore.appraisalworld.com/supporttickets/GetTopSupportCategories';
    end;
end;


function GetCRMToken(UserName,Password:String;GroupUID:Integer=0):String;
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr,jsResponse: String;
  jsPostRequest,jsCustomerClaim,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey: WideString;
  aOK:Boolean;
begin
  result := '';
  errMsg := '';
  aOK := False;

  PushMouseCursor(crHourglass);
  try
    url := CRM_ServiceRequestURL_GetToken;   //This point to DEV server for testing
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
      jsPostRequest := TlkJSONObject.Create(true);
      jsPostRequest.Add('email',UserName);
      jsPostRequest.Add('password',Password);
      jsCustomerClaim := TlkJSONObject.Create(true);
      jsCustomerClaim.Add('groupId',groupUID);
      jsPostRequest.Add('customClaims', jsCustomerClaim);
      jsPostRequest.Add('ttl',8);
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      errMsg := msgServiceNotAvaible;
    end;
    if httpRequest.Status <> httpRespOK then
      errMsg := msgServiceNotAvaible
    else
      begin
        result := httpRequest.ResponseText;
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
    if assigned(jsCustomerClaim) then
      jsCustomerClaim.Free;

  end;
end;


constructor TGeoCode.Create;
begin
  inherited create;
  FTxtStreet := '';
  FTxtCity   := '';
  FTxtState  := '';
  FTxtZip    := '';
  FTxtZipPlus4:= '';
  FTxtLon := 0;
  FTxtLat := 0;
  FTxtGeoResult := '';
  FTxtCensusBlockId := '';
  FTxtPrecision := '';
  FNumCandidates := 0;
  FNumCloseCandidates := 0;
  FtxtGeoSource := '';
  FGoodCandidate := False;
end;

destructor TGeoCode.Destroy;
begin
  inherited;
end;

constructor TFloodMaps.Create;
begin
  FLocation   := TLocation.Create;
  FTestResult := TTestResult.Create;
  FFeature    := TFeature.Create;
  FMapInfo    := TMapInfo.Create;
  inherited create;
end;

destructor TFloodMaps.Destroy;
begin
  FLocation.Free;
  FTestResult.Free;
  FFeature.Free;
  FMapInfo.Free;
  inherited;
end;

constructor TLocation.Create;
begin
  inherited create;
  FMapLabel := '';
  FStreet  := '';
  FCity    := '';
  FState   := '';
  FZip     := '';
  FPlus4   := '';
  FClientID := '';
  FCensusBlock  := '';
  FLocSpotted   := '';
end;

destructor TLocation.Destroy;
begin
  inherited;
end;

constructor TTestResult.Create;
begin
  inherited create;
  FName:='';
  FType:='';
  FSFHA:='';
  FNearBy:='';
  FFzDdPhrase:='';
  FCensusTract:='';
  FMapNumber:='';
end;

destructor TTestResult.Destroy;
begin
  inherited;
end;


constructor TFeature.Create;
begin
  inherited create;
  FCommunity:='';
  FCommunity_Name:='';
  FZone:='';
  FPanel:='';
  FPanelDate:='';
  FFIPS:='';
end;

destructor TFeature.Destroy;
begin
  inherited;
end;

constructor TMapInfo.Create;
const
  Default_ZoomLevel = 2;
begin
  inherited create;
  FImageID:='';
  FLocPtX:='';
  FLocPtY:='';
  FCenterX:='';
  FCenterY:='';
  FImageName:='';
  FImageURL:='';
  FZoom:=Default_ZoomLevel;
end;

destructor TMapInfo.Destroy;
begin
  inherited;
end;


constructor TPictometry.Create;
begin
  inherited create;
  FNorthImage := TNorthImage.Create;
  FSouthImage := TSouthImage.Create;
  FEastImage  := TEastImage.Create;
  FWestImage  := TWestImage.Create;
  FDownImage  := TDownImage.Create;
end;

destructor TPictometry.Destroy;
begin
  FNorthImage.Free;
  FSouthImage.Free;
  FEastImage.Free;
  FWestImage.Free;
  FDownImage.Free;
  inherited;
end;


constructor TBuildFaxPermit.Create;
begin
  inherited create;
  jurisdiction := TJurisdiction.Create;
end;

destructor TBuildFaxPermit.Destroy;
begin
  jurisdiction.Free;
  inherited;
end;

constructor TSubjectProperty.Create;
begin
  inherited create;
  SalesHistory := TSalesHistory.Create;
  FSalesHistory := TObjectList.Create(False);
end;

destructor TSubjectProperty.Destroy;
var
  i: Integer;
  aObj: TObject;
begin
  if assigned(FSalesHistory) then
    begin
      if FSalesHistory.Count > 0 then
        for i:= 0 to FSalesHistory.count - 1 do
          begin
            aObj := FSalesHistory.Items[i];
            if assigned(aObj) then
              TObject(aObj) := nil;
          end;
      if assigned(FSalesHistory) then
        TObjectList(FSalesHistory) := nil;
    end;
  SalesHistory.Free;
  inherited;
end;

constructor TSalesHistory.Create;
begin
  inherited create;
end;

destructor TSalesHistory.Destroy;
begin
  inherited;
end;

constructor TPropInfo.Create;
begin
  inherited create;
  SubjectProperty := TSubjectProperty.Create;
end;

destructor TPropInfo.Destroy;
begin
  SubjectProperty.Free;
  inherited;
end;
constructor TGetMlsEnhancementResponse.Create;
begin
  inherited;
  FResults := TResults.Create;
  FResponseData := TGetMlsEnhancementResponseData.Create;
end;


destructor TGetMlsEnhancementResponse.Destroy;
begin
  FResponseData.Free;
  inherited;
end;


constructor TTrendRequest.Create;
begin
  inherited;
  pendingSaleIsSettled := False;
end;

destructor TTrendRequest.Destroy;
begin
  inherited;
end;



function IsTokenExpired:Boolean;
var
  TokenHours:Integer;
begin
  result := False;
  TokenHours := round(now - CRMToken.CRM_TokenStartDateTime);
  result := TokenHours > CRM_Token_MaxHours;   //True: if the hours exceed the maximum hours to hold the token
end;

function GetJsonStrValue(js:TlkJSONBase; FieldName:String):String;
begin
  result := '';
  if js.Field[FieldName] <> nil then
    result := js.Field[FieldName].Value;
end;

function RefreshCRMToken(UserName,Password:String;GroupUID:Integer=0):String;
var
  aMsg:String;
begin
//aMsg := Format('UserName:%s Group:%d Key:%s',[UserName,GroupUID,CRMToken.CRM_Authentication_Token]);
//showMessage(aMsg);
  if groupUID = 0 then //make sure we load groupUID from the license file in case we miss
    begin
      groupUID := CurrentUser.LicInfo.FGroupID;
      CRMToken.CRM_Authentication_Token := '';
    end;

  if (length(CRMToken.CRM_Authentication_Token) = 0) or IsTokenExpired then  //if it's first time or if token is expired, go get token
    begin
      result := trim(GetCRMToken(UserName, Password,GroupUID));  //go get a valid token for this user
      CRMToken.CRM_Authentication_Token := result;    //save this token to use for the second time
      CRMToken.CRM_TokenStartDateTime   := now;    //pick up the current date time for token start using time
    end
  else
    result := trim(CRMToken.CRM_Authentication_Token);  //else use it
end;

//### This is a generic error handler for all the CRM services that are allocated by Units
procedure HandleCRMServerErrors(aServiceName,resultMsg:String);
const
  rspLogin  = 6;
  Dialog_Title    = 'Attention';
var
  errMsg: String;
  DisablePurchaseButton: Boolean;
  rsp: Integer;
  evalMode: Boolean;
begin
  DisablePurchaseButton := False;
  evalMode := CurrentUser.LicInfo.FLicType=ltEvaluationLic;
    if pos('allocations are expired',lowercase(resultMsg)) > 0 then  //Service Expired
      errMsg := Format('Your %s service has expired. To renew,  '+
                'please call us at 800-622-8727 or click "Purchase" to renew this service '+
                'from the AppraisalWorld Store. We appreciate your business.',
                [aServiceName])
    else if pos('insufficient allocations', lowerCase(resultMsg)) > 0 then   //Attention
      begin
        if evalMode then
           begin
             errMsg := 'This service is not available during the evaluation period. '+
                       'If you have any question, please contact our sales team at 800-622-8727.';
             DisablePurchaseButton := True;
           end
        else
          errMsg := Format('You have 0 %s units left or your service has been expired.  To purchase, '+
                         'please call us at 800-622-8727 or click "Purchase" to buy more units '+
                         'from the AppraisalWorld Store. We appreciate your business.',
                    [aServiceName])
      end
    else if pos('no allocation records found',LowerCase(resultMsg)) > 0 then  //Not Purchased
      begin
        if evalMode then
           begin
             errMsg := 'This service is not available during the evaluation period. '+
                       'If you have any question, please contact our sales team at 800-622-8727.';
             DisablePurchaseButton := True;
           end
        else
          errMsg := Format('You need to purchase %s in order to use it. '+
                    'To purchase, please call us at 800-622-8727 or click "Purchase" '+
                    'to buy this service from the AppraisalWorld Store. '+
                    'We appreciate your business.',[aServiceName]);
      end
    else if pos('cannot find an active allocation record',lowerCase(resultMsg)) > 0 then //inactive allocation
      begin
        if evalMode then
           begin
             errMsg := 'This service is not available during the evaluation period. '+
                       'If you have any question, please contact our sales team at 800-622-8727.';
             DisablePurchaseButton := True;
           end
        else
          begin
            errMsg := Format('There''s a problem in getting %s, please call us at 800-622-827.  '+
                      'We appreciate your business.',[aServiceName]);
            DisablePurchaseButton := True;
          end;
      end
    else
      begin
        if CurrentUser.LicInfo.FLicType = ltEvaluationLic then
          begin
            errMsg := 'This service is not available during the evaluation period. '+
                      'If you have any question, please contact our sales team at 800-622-8727.';
            DisablePurchaseButton := True;
          end
        else
          begin
             errMsg := 'This service is not available. '+
                       'If you have any question, please contact our sales team at 800-622-8727.';
             DisablePurchaseButton := True;
          end;
      end;
    if errMsg <> '' then
      begin
        if not DisablePurchaseButton then
          begin
            rsp := WarnWithOption12('Purchase', 'Cancel', errMsg,1,True,Dialog_Title)
          end
        else
          begin
            ShowAlert(atWarnAlert,errMsg);
            rsp := 0;
          end;

        if rsp = rspLogin then
          HelpCmdHandler(cmdHelpAWShop4Service, CurrentUser.AWUserInfo.AWIdentifier, CurrentUser.AWUserInfo.UserLoginEmail);
      end;
end;

function SendAckToCRMServiceMgr(prodUID,ServiceMethod:Integer; VendorTokenKey:String): Boolean;
var
  responseTxt: string;
  requestStr: String;
  js, jsResultCode: TlkJSONBase;
  jsPostRequest: TlkJSONObject;
  HTTPRequest: IWinHTTPRequest;
  url,errMsg,respStr,AuthenticationToken: String;
begin
//showmessage('Calling CRM SendAckToCRMServiceMgr');
  result := False;
  if VendorTokenKey = '' then
    begin
      AuthenticationToken := RefreshCRMToken(CurrentUser.AWUserInfo.UserLoginEmail, CurrentUser.AWUserInfo.UserPassWord);
      if length(AuthenticationToken) = 0 then
        begin
          exit;
        end;
      VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it
    end;
  try
    url := CRMServiceRequestSendACKURL;   //This point to DEV server for testing
    PushMouseCursor(crHourglass);
      httpRequest := CoWinHTTPRequest.Create;
      httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
      httpRequest.Open('POST',url,False);
      jsPostRequest := TlkJSONObject.Create(true);
      jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
      jsPostRequest.Add('prodId',prodUID);  //pass prodUID
      jsPostRequest.Add('serviceMethod',ServiceMethod);      //pass route
      RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
      respStr := httpRequest.ResponseText;
      case httpRequest.Status of
        httpRespOK:  //200 OK
          begin
            result := CompareText(respStr,'Acknowledged') =0;  //we got ACK
          end;
        else
          result := False;
      end;
    finally
      PopMousecursor;
      if assigned(jsPostRequest) then
        jsPostRequest.Free;
    end;
end;


function GetCRM_CensusTract(doc:TContainer;UserCredential:TAWCredentials; latitude, longitude: double; muteError:Boolean): String;
const
  CensusTractName = 'Census Tract';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  GeoCode:TGeoCode;
begin
  result := '';
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  if (latitude = 0) and (longitude = 0) then
   begin
     GetCRM_GeoCode(doc,UserCredential,VendorTokenKey,GeoCode);
     if GeoCode <> nil then
       begin
         latitude := GeoCode.FTxtLat;
         longitude := GeoCode.FTxtLon;
       end;
   end;
  PushMouseCursor(crHourglass);
  try
    url := CRMServiceRequest_Fetch_URL;
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('serviceMethod',CRM_CensusTract_ServiceMethod);  //pass servicemanager to tell SM which service to use
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass develop or production
    jsPostRequest.Add('prodId',CRM_CensusTractProdUID);      //pass prodUID
    jsRequestData := TlkJSONObject.Create(true);
    jsRequestFields := TlkJSONObject.Create(true);
    postJsonFloat('longitude', longitude, jsRequestFields);  //pass longitude
    postJsonFloat('latitude', latitude, jsRequestFields);    //pass latitude
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    jsPostRequest.Add('bundleId', FCRMBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        if not muteError then
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  result := jsResult.Field['data'].Value;
                  if length(result) > 0 then
                    SendAckToCRMServiceMgr(CRM_CensusTractProdUID,CRM_CensusTract_ServiceMethod,VendorTokenKey)
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  if not muteError then
                    HandleCRMServerErrors(CensusTractName,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              if not muteError then
                HandleCRMServerErrors(CensusTractName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              if not muteError then
                HandleCRMServerErrors(CensusTractName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


//NOTE: we don't need to call this api for FloodMaps.
//For FloodMaps, we only need to call one api to pass subject address with route name: geomap and CRM Service Manager will return
//full flood data and map image.
function GetCRM_GeoCode(doc: TContainer;UserCredential:TAWCredentials;VendorTokenKey:String; var GeoCode:TGeoCode):Boolean;
const
  FloodMapsName = 'Flood Maps';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  js: TlkJSONBase;
  aInt: Integer;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  latitude,longitude: Double;
  Address,City,State,Zip,ZipPlus4: String;
  reqestFieldsStr: String;
begin
  result := False;
  if length(VendorTokenKey) = 0 then exit;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

  Address := doc.GetCellTextByID(46);
  City    := doc.GetCellTextByID(47);
  State   := doc.GetCellTextByID(48);
  Zip     := doc.GetCellTextByID(49);

  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('serviceMethod', CRM_GeoCodeMapByAddress_ServiceMethod);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
    jsPostRequest.Add('prodId',CRM_FloodMapsProdUID);      //pass prodUID  24 for geocode and Maps
    jsRequestData := TlkJSONObject.Create(true);
    jsRequestFields := TlkJSONObject.Create(true);
    postJsonStr('txtName', 'FloodMaps testing',jsRequestFields);  //pass Name
    postJsonStr('txtStreet', Address, jsRequestFields);    //pass Subject address
    postJsonStr('txtCity', City, jsRequestFields);    //pass Subject address
    postJsonStr('txtState', State, jsRequestFields);    //pass Subject address
    postJsonStr('txtZip', Zip, jsRequestFields);    //pass Subject address
    postJsonStr('txtPlus4', '', jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
               js :=TlkJsonObject(jsResult).Field['requestFields'];
               if js <> nil then
                 begin
                   result := True;
                   GeoCode.FTxtStreet := js.Field['txtStreet'].Value;
                   GeoCode.FTxtCity   := js.Field['txtCity'].Value;
                   GeoCode.FTxtState  := js.Field['txtState'].Value;
                   GeoCode.FTxtZip    := js.Field['txtZip'].Value;
                   GeoCode.FTxtZipPlus4 := js.Field['txtPlus4'].Value;
                   GeoCode.FTxtLon    := js.Field['txtLon'].Value;
                   GeoCode.FTxtLat    := js.Field['txtLat'].Value;
                   GeoCode.FTxtGeoResult := js.Field['txtGeoResult'].Value;
                   GeoCode.FTxtCensusBlockId := js.Field['txtCensusBlockId'].Value;
                   GeoCode.FTxtPrecision := js.Field['txtPrecision'].Value;
                   GeoCode.FNumCandidates := js.Field['NumCandidates'].Value;
                   GeoCode.FNumCloseCandidates := js.Field['NumCloseCandidates'].Value;
                   GeoCode.FtxtGeoSource := js.Field['txtGeoSource'].Value;
                   GeoCode.FGoodCandidate := js.Field['GoodCandidate'].Value;
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


 (*
function GetCRM_FloodMapsByAddress(Location:TLocation;UserCredential:TAWCredentials;VendorTokenKey:String):String;
const
  FloodMapHeightTWIPS   = '8250';           //Ticket #1264: 8250=550 pixels
  FloodMapWidthTWIPS    = '7960';           //7980=532 pixels;
  FloodMapsName         = 'Flood Maps';
  ZoomLevel             = '1.5';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult, jsResponseType:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  Address,City,State,Zip,ZipPlus4: String;
//sl:TStringList;
begin
  result := '';

  if length(VendorTokenKey) = 0 then exit;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;


  Address := Location.FStreet;
  City    := Location.FCity;
  State   := Location.FState;
  Zip     := Location.FZip;

  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('serviceMethod',CRM_GeoCodeMapByAddress_ServiceMethod);  //tell SM which service to use
    jsPostRequest.Add('vendorServer',CRM_VendorServer_Live);  //pass token
    jsPostRequest.Add('prodId',CRM_FloodMapsProdUID);      //pass prodUID  24 for geocode and Maps
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsResponseType  := TlkJSONObject.Create(False);
    postJsonStr('txtName', 'FloodMaps By Address',jsRequestFields);  //pass Name
    postJsonStr('txtStreet', Address, jsRequestFields);    //pass Subject address
    postJsonStr('txtCity', City, jsRequestFields);         //pass Subject city
    postJsonStr('txtState', State, jsRequestFields);       //pass Subject state
    postJsonStr('txtZip', Zip, jsRequestFields);           //pass Subject zip
    postJsonStr('txtPlus4', '',jsRequestFields);
    postJsonStrWithEmpty('txtRmTestList','',jsRequestFields);
    postJsonStr('txtGenMapImage','true',jsRequestFields);
    postJsonStr('txtMapWidth',FloodMapWidthTWIPS,jsRequestFields);
    postJsonStr('txtMapHeight',FloodMapHeightTWIPS,jsRequestFields);
    postJsonStr('txtZoom',ZoomLevel,jsRequestFields);
    postJsonStr('txtInteractiveMap','true',jsRequestFields);
    postJsonStr('HideLocation','true',jsRequestFields);
    postJsonStr('txtLocLabel','Subject',jsRequestFields);


    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    jsRequestData.Add('responseType',CRM_ResponseType);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
          if length(result) > 0 then
            SendAckToCRMServiceMgr(CRM_FloodMapsProdUID,CRM_GeoCodeMapByAddress_ServiceMethod,VendorTokenKey)
          else
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(FloodMapsName,resultMsg);
            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(FloodMapsName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(FloodMapsName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(FloodMapsName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function GetCRM_FloodMapsRespotRequest(RespotRequest: TFloodMaps; var ResponseTxt:String):Boolean;
const
  FloodMapHeightTWIPS   = '8250';           //Ticket #1264: 8250=550 pixels
  FloodMapWidthTWIPS    = '7960';           //7980=532 pixels;
  FloodMapsName         = 'Flood Maps';
  ZoomLevel             = '1.5';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult, jsResponseType:TlkJSONObject;
  resultMsg:String;
  DisablePurchaseButton: Boolean;
  VendorTokenKey,AuthenticationToken:String;
sl:TStringList;
begin
  result := False;
  if RespotRequest = nil then exit;
  AuthenticationToken := RefreshCRMToken(CurrentUser.AWUserInfo.UserLoginEmail,CurrentUser.AWUserInfo.UserPassWord);
  if length(AuthenticationToken) = 0 then  exit;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('serviceMethod',CRM_GeoCodeMapRespot_ServiceMethod);  //tell SM which service to use
    jsPostRequest.Add('vendorServer',CRM_VendorServer_Live);  //pass token
    jsPostRequest.Add('prodId',CRM_FloodMapsProdUID);      //pass prodUID  24 for geocode and Maps
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsResponseType  := TlkJSONObject.Create(False);
    postJsonStr('Street',RespotRequest.FLocation.FStreet,jsRequestFields);
    postJSonStr('City',RespotRequest.FLocation.FCity,jsRequestFields);
    postJSonStr('State',RespotRequest.FLocation.FState,jsRequestFields);
    postJSonStr('Zip',RespotRequest.FLocation.FZip,jsRequestFields);
    postJSonStr('Plus4',RespotRequest.FLocation.FPlus4,jsRequestFields);
    postJsonStr('Latitude', RespotRequest.FLocation.FLatitude, jsRequestFields);
    postJsonStr('Longitude', RespotRequest.FLocation.FLongitude, jsRequestFields);
    postJsonStr('GeoResult', RespotRequest.FLocation.FGeoResult, jsRequestFields);
    postJsonStr('CensusBlockId',RespotRequest.FLocation.FCensusBlock,jsRequestFields);

    postJsonStr('MapHeight',FloodMapHeightTWIPS, jsRequestFields);
    postJsonStr('MapWidth',FloodMapWidthTWIPS, jsRequestFields);
    postJsonStr('MapZoom', ZoomLevel, jsRequestFields);
    postJSonStr('LocationLabel','Subject',jsRequestFields);


    postJsonStr('ImageID', RespotRequest.FMapInfo.FImageID,jsRequestFields);
//    postJsonStr('ImageName',RespotRequest.FMapInfo.FImageName,jsRequestFields);
    postJsonStr('ImageURL','rmo1web16.riskmeter.com/MapImages',jsRequestFields);
//    postJsonStr('ImageURL', RespotRequest.FMapInfo.FImageURL, jsRequestFields);
    postJsonStr('LocPtX', RespotRequest.FMapInfo.FLocPtX, jsRequestFields);
    postJsonStr('LocPtY', RespotRequest.FMapInfo.FLocPtY, jsRequestFields);
//    postJsonStr('CenterX', RespotRequest.FMapInfo.FCenterX, jsRequestFields);
//    postJsonStr('CenterY', RespotRequest.FMapInfo.FCenterY, jsRequestFields);

    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    jsRequestData.Add('responseType',CRM_ResponseType);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      if pos('\',RequestStr) > 0 then
        begin
          RequestStr := StringReplace(RequestStr,'\','',[rfReplaceAll]);
        end;
//sl:=TStringList.Create;
//sl.Text := Format('url=%s;RequestStr=%s',[url,RequestStr]);
//sl.savetoFile('c:\temp\respotRequestBody.txt');
//sl.free;
        httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          ResponseTxt := httpRequest.ResponseText;
          result := length(ResponseTxt) > 0;
//          if result then
//            SendAckToCRMServiceMgr(CRM_FloodMapsProdUID,CRM_GeoCodeMapByAddress_ServiceMethod,VendorTokenKey)
//          else
//            begin
//              resultMsg := jsResult.Field['message'].Value;
//              HandleCRMServerErrors(FloodMapsName,resultMsg);
//            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(FloodMapsName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(FloodMapsName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(FloodMapsName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function LoadFloodMapsResponseData(ResponseData:String):TFloodMaps;
var
  js,jLocation,jsTestResult, jsFeature, jsMapInfo: TlkJSONBase;
begin
  js:= TlkJSON.ParseText(ResponseData);
  if js <> nil then
    begin
      result := TFloodMaps.Create;
      jLocation := js.Field['Location'];   //Location
      if jLocation <> nil then
        begin
          result.FLocation.FMapLabel := GetJsonStrValue(jLocation,'MapLabel');
          result.FLocation.FStreet   := GetJsonStrValue(jLocation,'Street');
          result.FLocation.FCity     := jLocation.Field['City'].Value;
          result.FLocation.FState    := jLocation.Field['State'].Value;
          result.FLocation.FZip      := jLocation.Field['Zip'].Value;
          result.FLocation.FPlus4    := jLocation.Field['Plus4'].Value;
          result.FLocation.FCensusBlock := jLocation.Field['CensusBlock'].Value;
          result.FLocation.FLocSpotted := jLocation.Field['LocSpotted'].Value;
        end;

      jsTestResult := js.Field['TestResult'];   //TestResult
      if jsTestResult <> nil then
        begin
          result.FTestResult.FName       := jsTestResult.Field['Name'].Value;
          result.FTestResult.FType       := jsTestResult.Field['Type'].Value;
          result.FTestResult.FSFHA       := jsTestResult.Field['SFHA'].Value;
          result.FTestResult.FNearBy     := jsTestResult.Field['Nearby'].Value;
          result.FTestResult.FFzDdPhrase := jsTestResult.Field['FzDdPhrase'].Value;
          result.FTestResult.FCensusTract:= jsTestResult.Field['CensusTract'].Value;
          result.FTestResult.FMapNumber  := jsTestResult.Field['MapNumber'].Value;
        end;

      jsFeature := js.Field['Feature'];   //Feature
      if jsFeature <> nil then
        begin
          result.FFeature.FCommunity := jsFeature.Field['Community'].Value;
          result.FFeature.FCommunity_Name := jsFeature.Field['Community_Name'].Value;
          result.FFeature.FZone := jsFeature.Field['Zone'].Value;
          result.FFeature.FPanel := jsFeature.Field['Panel'].Value;
          result.FFeature.FPanelDate := jsFeature.Field['PanelDate'].Value;
          result.FFeature.FFIPS := jsFeature.Field['FIPS'].Value;
        end;

      jsMapInfo := js.Field['MapInfo'];   //Map Info
      if jsMapInfo <> nil then
        begin
          result.FMapInfo.FImageID := jsMapInfo.Field['ImageID'].Value;
          result.FMapInfo.FLocPtX  := jsMapInfo.Field['LocPtX'].Value;
          result.FMapInfo.FLocPtY  := jsMapInfo.Field['LocPtY'].Value;
          result.FMapInfo.FCenterX := jsMapInfo.Field['CenterX'].Value;
          result.FMapInfo.FCenterY := jsMapInfo.Field['CenterY'].Value;
          result.FMapInfo.FImageName := jsMapInfo.Field['ImageName'].Value;
          result.FMapInfo.FZoom := jsMapInfo.Field['Zoom'].Value;
          result.FMapInfo.FImageURL  := jsMapInfo.Field['ImageURL'].Value;
        end;

      result.FMapImage := js.Field['MapImage'].Value;
      result.FImageB64 := js.Field['imageB64'].Value;
      if js.Field['txtGeoResult'] <> nil then
      result.FTxtGeoResult := js.Field['txtGeoResult'].Value;
    end;
end;

function LoadGeoCodeResponseData(GeoCodeResponseData:String):TGeoCode;
var
  js,jRequestFields: TlkJSONBase;
begin
  js:= TlkJSON.ParseText(GeoCodeResponseData);
  if js <> nil then
    begin
      result := TGeoCode.Create;
      jRequestFields := js.Field['requestFields'];   //RequestFields
      if jRequestFields <> nil then
        begin
          result.FTxtStreet := jRequestFields.Field['txtStreet'].Value;
          result.FTxtCity := jRequestFields.Field['txtCity'].Value;
          result.FTxtState := jRequestFields.Field['txtState'].Value;
          result.FTxtZip := jRequestFields.Field['txtZip'].Value;
          result.FTxtZipPlus4 := jRequestFields.Field['txtPlus4'].Value;
          result.FTxtLon := jRequestFields.Field['txtLon'].Value;
          result.FTxtLat := jRequestFields.Field['txtLat'].Value;
          result.FTxtGeoResult := jRequestFields.Field['txtGeoResult'].Value;
          result.FTxtCensusBlockId := jRequestFields.Field['txtCensusBlockId'].Value;
          result.FTxtPrecision := jRequestFields.Field['txtPrecision'].Value;
          result.FNumCandidates := jRequestFields.Field['NumCandidates'].Value;
          result.FNumCloseCandidates := jRequestFields.Field['NumCloseCandidates'].Value;
          result.FtxtGeoSource := jRequestFields.Field['txtGeoSource'].Value;
          result.FGoodCandidate := jRequestFields.Field['GoodCandidate'].Value;
        end;
    end;
end;


function GetCRM_FloodMap(Location:TLocation; UserCredential:TAWCredentials; var responseData:String; var FLoodMaps: TFloodMaps): Boolean;
const
  FloodMapsName = 'Flood Maps';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  latitude,longitude: Double;
  Address,City,State,Zip,ZipPlus4: String;
  GeoCodeStr, FloodMapsStr: String;
  groupUID:Integer;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  GroupUID := CurrentUser.LicInfo.FGroupID;
  AWIdentifier := UserCredential.AWIdentifier;


//  Address := doc.GetCellTextByID(46);
//  City    := doc.GetCellTextByID(47);
//  State   := doc.GetCellTextByID(48);
//  Zip     := doc.GetCellTextByID(49);
  Address := Location.FStreet;
  City    := Location.FCity;
  State   := Location.FState;
  Zip     := Location.FZip;

  PushMouseCursor(crHourglass);
  FloodMaps := TFloodMaps.Create;
  try
    AuthenticationToken := RefreshCRMToken(UserName, Password,GroupUID); //Get token if needed
    if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
    ResponseData := GetCRM_FloodMapsByAddress(Location,UserCredential,VendorTokenKey);
      begin
        result := trim(ResponseData) <> '';
        FLoodMaps := LoadFloodMapsResponseData(responseData);
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
 //   FloodMaps.Free;
  end;
end;
*)

function GetCRM_PictometryByAddress(pictometry:TPictometry;UserCredential:TAWCredentials;VendorTokenKey:String;mapWidth,mapHeight:Integer):String;
const
  PictometryName = 'Pictometry';
  Default_MapWidth = 500;
  Default_MapHeight = 500;
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult, jsResponseType:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  Address,City,State,Zip,ZipPlus4,FullSubjectAddress: String;
begin
  result := '';

  if length(VendorTokenKey) = 0 then exit;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

  Address := pictometry.FAddress;
  City    := pictometry.FCity;
  State   := pictometry.FState;
  Zip     := pictometry.FZip;
  FullSubjectAddress := Format('%s, %s %s %s',[Address, City, State, Zip]);

  if mapWidth = 0 then mapWidth := Default_MapWidth;  //can never happen, but if it's 0 default to 500
  if mapHeight = 0 then mapHeight := Default_MapHeight; //can never happen, but if it's 0 default to 500

  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('serviceMethod',CRM_Pictometry_ServiceMethod);
    jsPostRequest.Add('prodId',CRM_PictometryProdUID);      //pass prodUID  8 for pictometry
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsResponseType  := TlkJSONObject.Create(False);
    postJsonStr('location', FullSubjectAddress,jsRequestFields);  //pass full address
    postJsonStr('width', Format('%d',[mapWidth]), jsRequestFields);    //pass width
    postJsonStr('height', Format('%d',[mapHeight]), jsRequestFields);         //pass height
//    postJsonBool('productionCall', UseProductionService, jsRequestFields);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
//    jsPostRequest.Add('route', CRM_Pictometry_Route);         //pass route:pictometry
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
          if length(result) > 0 then
            SendAckToCRMServiceMgr(CRM_PictometryProdUID,CRM_Pictometry_ServiceMethod,VendorTokenKey)
          else
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(PictometryName,resultMsg);
            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(PictometryName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(PictometryName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(PictometryName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


function LoadPictometryResponseData(ResponseData:String):TPictometry;
var
  js,jImages,jNorth, jSouth, jEast,jWest,jDown: TlkJSONBase;
  ResponseData2 : String;
  image1,image2,type1,type2:String;
begin
  js:= TlkJSON.ParseText(ResponseData);
  if js <> nil then
    begin
      result := TPictometry.Create;
      jImages := js.Field['images'];   //images
      if jImages <> nil then
        begin
          jNorth := jImages.Field['north'];   //inside north is image base 64
          result.FNorthImage.ImageB64 := jNorth.Field['imageBs64'].Value;
          result.FNorthImage.ImageType := jNorth.Field['type'].Value;

          jSouth := jImages.Field['south'];
          result.FSouthImage.ImageB64 := GetJsonStrValue(jSouth,'imageBs64');
          result.FSouthImage.ImageType := jSouth.Field['type'].Value;

          jWest := jImages.Field['west'];
          result.FWestImage.ImageB64 := GetJsonStrValue(jWest,'imageBs64');
          result.FWestImage.ImageType := jSouth.Field['type'].Value;

          jEast := jImages.Field['east'];
          result.FEastImage.ImageB64 := GetJsonStrValue(jEast,'imageBs64');
          result.FEastImage.ImageType := jSouth.Field['type'].Value;

          jDown := jImages.Field['down'];
          result.FDownImage.ImageB64 := GetJsonStrValue(jDown,'imageBs64');
          result.FDownImage.ImageType := jSouth.Field['type'].Value;
        end;
    end;
end;


function GetCRM_Pictometry(UserCredential:TAWCredentials; mapWidth,mapHeight:Integer; var responseData:String; var Pictometry: TPictometry): Boolean;
const
  PictometryName = 'Pictometry';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  latitude,longitude: Double;
  Address,City,State,Zip,ZipPlus4: String;
  GeoCodeStr, FloodMapsStr: String;
begin
//FOR TESTING ONLY
//result := true;
//Pictometry := LoadPictometryResponseData(responseData);
//exit;
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

  Address := Pictometry.FAddress;
  City    := Pictometry.FCity;
  State   := Pictometry.FState;
  Zip     := Pictometry.FZip;

  PushMouseCursor(crHourglass);
  if Pictometry = nil then
    Pictometry := TPictometry.Create;
  try
    AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
    if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
    ResponseData := GetCRM_PictometryByAddress(Pictometry,UserCredential,VendorTokenKey,mapWidth,mapHeight);
      begin
        result := trim(ResponseData) <> '';
        if result then
          Pictometry := LoadPictometryResponseData(responseData);
      end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;



function GetCRM_BuildFaxPermitByAddress(doc:TContainer;UserCredential:TAWCredentials;VendorTokenKey:String;var bfax:TBuildFaxPermit):String;
const
  BuildFaxName = 'BuildFax';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult, jsResponseType:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  Address,City,State,Zip,ZipPlus4,FullSubjectAddress: String;
begin
  result := '';

  if length(VendorTokenKey) = 0 then exit;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('serviceMethod',CRM_BuildFax_ServiceMethod);      //pass prodUID  5 for buildfax
    jsPostRequest.Add('prodId',CRM_BuildFaxProdUID);      //pass prodUID  5 for buildfax
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsResponseType  := TlkJSONObject.Create(False);
    postJsonStr('address', bfax.RequestAddress.fullAddress,jsRequestFields);  //pass full address
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
          if length(result) = 0 then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(BuildFaxName,resultMsg);
            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(BuildFaxName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(BuildFaxName,resultMsg);
            end;
        end;
      httpResp404:
        begin
          if jsResult <> nil then
            begin
               errMsg := jsResult.Field['message'].Value;
               if pos('errorMsg:', errMsg) > 0 then
                 begin
                   popStr(errMsg,'errorMsg:');
                   errMsg := popStr(errMsg,'}');
                   errMsg := bfax.RequestAddress.fullAddress + ' : '+errMsg;
                   ShowAlert(atWarnAlert, errMsg);
                 end;
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(BuildFaxName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;



function ComposeDescription(bfax:TBuildFaxPermit):String;
var
  contractor,permitType:String;
begin
  result := '';
  if length(bfax.permitTypePreferred) > 0 then
    begin
      permitType := Format('Permit Type: %s',[bfax.permitTypePreferred]);
      result := permitType;
    end;
  if length(bfax.description) > 0 then
    if length(result) > 0 then
      result := result + '-'+bfax.description
    else
      result := bfax.description;
  if length(bfax.workClass) > 0 then
    if length(result) > 0 then
      result := result+'-'+bfax.workClass
    else
      result := bfax.workClass;
  if length(bfax.CheckNames) > 0 then
    if length(result) > 0 then
      result := result+'-'+bfax.CheckNames
    else
      result := bfax.CheckNames;

  if length(bfax.contractor.fullName) > 0 then
    begin
      contractor := Format('Contractor: %s',[bfax.contractor.fullName]);
      result := result + #13#10+contractor;
    end;
end;

function CalcDateCell(i:Integer):Integer;
const
  dateCellID = 37;
begin
  case i of
    0: result := dateCellID;
    else
       begin
         result := dateCellID+(2*i);
       end;
  end;
end;

procedure PopulateBuildFaxData(i:Integer;bfax:TBuildFaxPermit;thisForm:TDocForm);
const
  pNumCellID   = 27;
  dateCellID   = 37;
  ValueCellID  = 57;
  DescCellID   = 67;
var
  AmtStr,permitDesc,StatusDate,PermitStatus,reportDate:String;
  vAmt:Double;
  dCellID, sCellID:Integer;
  PermitPart1,PermitPart2:String;
begin
  thisForm.SetCellText(1,13,bfax.RequestAddress.fullAddress);
  reportDate := FormatdateTime('mm/dd/yyyy',date);
  thisForm.SetCellText(1,14,reportDate);

  dCellID := CalcDateCell(i);
  if trim(bfax.permitNum) = '' then
    thisForm.SetCellText(1,pNumCellID+i,'No permit')
  else
    thisForm.SetCellText(1,pNumCellID+i, bfax.permitNum);
  thisForm.SetCellText(1,dCellID, bfax.statusDate);

  PermitStatus := Format('Status: %s',[bfax.permitStatus]);
  if trim(PermitStatus) = '' then
    thisForm.SetCellText(1,dCellID+1, '')
  else
    thisForm.SetCellText(1,dCellID+1, PermitStatus);
  vAmt := GetValidNumber(bfax.valuationAmount);
  AmtStr := '';
  if vAmt > 0 then
    AmtStr := FormatFloat('$#,###',vAmt);
  thisForm.SetCellText(1,ValueCellID+i, AmtStr);
  permitDesc := ComposeDescription(bfax);
  permitDesc := StringReplace(permitDesc,#13#10,'-',[rfreplaceAll]);
  if pos('-'+Contractor_Title, permitDesc) > 0 then
    begin
      PermitPart1 := popStr(permitDesc,'-'+Contractor_Title);
      permitPart2 := StringReplace(permitDesc,'-',#13#10,[rfreplaceAll]);
      permitDesc := PermitPart1+#13#10+Contractor_Title+PermitPart2;
    end;
  if permitDesc = '' then
    permitDesc := 'This record did not contain data.';
  thisForm.SetCellText(1,DescCellID+i, permitDesc);
end;


procedure LoadBuildFaxPermitData(doc:TContainer; thisForm:TDocForm; ResponseData:WideString; var bfax:TBuildFaxPermit);
var
  jPermits, jJurisdictions, {jDataList,} jCheckList:TlkJSONList;  //permit data list
  js,jData: TlkJSONBase;
  jProperty: TlkJSONBase;
  joData,joCheck,joContractor:TlkJSONObject;
  joPermit,joJurisdiction:TlkJSONObject;
  joProperty:TlkJSONObject;
  i,j:Integer;
  ckList:TStringList;   //a list to store check items
  ValuationAmtStr, alatlon:String;
  MinToMaxDate,fullAddress,StatusDate:String;
begin
  js := TlkJSON.ParseText(ResponseData);
  ckList := TStringList.Create;
  try
    if js <> nil then
      begin
        jProperty := js.Field['property'];
        if jProperty <> nil then  //load property section
          begin
            joProperty := jProperty as TlkJSONObject;
            if joProperty <> nil then
              begin
                bFax.RequestAddress.StreetAddress := getJSonString('address1', joProperty);
                bFax.RequestAddress.city := GetJSonString('city', joProperty);
                bFax.RequestAddress.state := GetJSonString('state', joProperty);
                bFax.RequestAddress.zipCode := GetJSonString('zipcode', joProperty);
                bFax.RequestAddress.latitude := GetJSonString('latitude', joProperty);
                bFax.RequestAddress.longitude := GetJSonString('longitude', joProperty);
                bFax.RequestAddress.fullAddress := Format('%s, %s, %s %s',
                [bfax.RequestAddress.StreetAddress,bfax.RequestAddress.City,
                 bfax.RequestAddress.State,bfax.RequestAddress.ZipCode]);
                //populate property data
    //            thisForm.SetCellText(1, 13, bfax.RequestAddress.fullAddress);
                thisForm.SetCellText(1, 6, bfax.RequestAddress.StreetAddress);
                thisForm.SetCellText(1, 7, bfax.RequestAddress.City);
                thisForm.SetCellText(1, 9, bfax.RequestAddress.State);
                thisForm.SetCellText(1, 10, bfax.RequestAddress.ZipCode);
                thisForm.SetCellText(1, 8, bfax.RequestAddress.County);
                aLatLon := Format('%s;%s',[bfax.RequestAddress.latitude,bfax.RequestAddress.longitude]);
                doc.SetCellTextByID(9250, aLatLon);
              end;
          end;

        //jPermits section
        jJurisdictions := js.Field['jurisdictions'] as TlkJSONList;
        if jJurisdictions <> nil then
          begin
            for i:= 0 to jJurisdictions.count -1 do //load the first 2 only
              begin
                if i > 1 then break;   //we only load in 2 the max
                joJurisdiction := jJurisdictions.Child[i] as TlkJSONObject;  //get each permit
                if joJurisdiction = nil then continue;
                bfax.jurisdiction.officialName := GetJSONString('officialName',joJurisdiction);
                bfax.jurisdiction.address := GetJSONString('address',joJurisdiction);
                bfax.jurisdiction.city    := GetJSonString('city',joJurisdiction);
                bfax.jurisdiction.state   := GetJSonString('state',joJurisdiction);
                bfax.jurisdiction.zipcode := GetJSonString('zipcode',joJurisdiction);
                bfax.jurisdiction.website := GetJSonString('website',joJurisdiction);
                bfax.jurisdiction.phone   := GetJSonString('phone', joJurisdiction);
                bfax.jurisdiction.minDate := SetISOtoDateTime(varToStr(joJurisdiction.Field['minDate'].Value)+ '  00:00', True);
                bfax.jurisdiction.maxDate := SetISOtoDateTime(varToStr(joJurisdiction.Field['maxDate'].Value)+ '  00:00', True);
                bfax.jurisdiction.CityStZip := Format('%s, %s %s',[bfax.jurisdiction.city,
                             bfax.jurisdiction.state, bfax.jurisdiction.zipCode]);
                MinToMaxDate := Format(' %s through %s',[bfax.jurisdiction.minDate,bfax.jurisdiction.maxDate]);
                case i of
                  0: begin
                       thisForm.SetCellText(1,15,bfax.jurisdiction.officialName);
                       thisForm.SetCellText(1,16,bfax.jurisdiction.address);
                       thisForm.SetCellText(1,17,bfax.jurisdiction.CityStZip);
                       thisForm.SetCellText(1,18,bfax.jurisdiction.phone);
                       thisForm.SetCellText(1,19,bfax.jurisdiction.website);
                       thisForm.SetCellText(1,25,MinToMaxDate);
                     end;
                  1: begin
                       thisForm.SetCellText(1,20,bfax.jurisdiction.officialName);
                       thisForm.SetCellText(1,21,bfax.jurisdiction.address);
                       thisForm.SetCellText(1,22,bfax.jurisdiction.CityStZip);
                       thisForm.SetCellText(1,23,bfax.jurisdiction.phone);
                       thisForm.SetCellText(1,24,bfax.jurisdiction.website);
                       thisForm.SetCellText(1,26,MinToMaxDate);
                     end;
                end;
              end;
          end;

        //permits section
        jPermits := js.Field['permits'] as TlkJSONList;
        if jPermits <> nil then
          begin
            for i:= 0 to jPermits.count -1 do  //loop through each permit
              begin
               try
                if i > 9 then break;  //only load the top 10
                joPermit := jPermits.Child[i] as TlkJSONObject;  //get each permit
                if joPermit = nil then continue;
                //bfax := TBuildFaxPermit.Create;
                bfax.id := GetJsonString('id', joPermit);
                bfax.permitNum := GetJsonString('permitNum', joPermit); //permit #
                bfax.permitTypePreferred := GetJsonString('permitTypePreferred',joPermit);
                bfax.workClass := GetJsonString('workClass',joPermit);
                bfax.description := GetJsonString('description',joPermit);
                if joPermit.Field['statusDate'] <> nil then
                  begin
                    StatusDate := varToStr(joPermit.Field['statusDate'].Value);
                    if pos(':', StatusDate) = 0 then
                      StatusDate := StatusDate + '  00:00';
                    try
                      bfax.StatusDate := SetISOtoDateTime(StatusDate, True);
                    except on E:Exception do ; end; //we have to eat the error if garbage or invalid statusDate returns
                  end;
                bfax.permitStatus := GetJsonString('permitStatus',joPermit);
                bfax.valuationAmount := GetJsonString('valuationAmount',joPermit);
                bfax.totalSqFt := GetJsonString('totalSqFt',joPermit);
                if i = 0 then
                  begin
                    bFax.PermitResult.LatestPermitDate := bfax.StatusDate;
                    bFax.PermitResult.PermitValuation := bfax.valuationAmount;
                    bFax.PermitResult.permitNo := jPermits.Count;
                  end;

                jCheckList := joPermit.Field['check'] as TlkJSONList;
                if jCheckList <> nil then
                  begin
                    ckList.Clear;
                    for j:= 0 to jCheckList.Count -1 do
                      begin
                        joCheck := joPermit as TlkJSONObject;  //get each check
                        if joCheck = nil then continue;
                        if GetValidInteger(GetJsonString('result',joCheck)) = 1 then  //only pick up result =1
                          ckList.Add(GetJSonString('name',joCheck));
                      end;
                    bfax.CheckNames := ckList.commatext;
                  end;
                if joPermit.Field['contractor'] <> nil then
                  begin
                    if not (joPermit.Field['contractor'] is TLKJSONnull) then
                      begin
                        joContractor := TlkJSONObject(joPermit.Field['contractor']);
                        begin
                          if joContractor <> nil then
                            begin
                              try
                                if joContractor.Field['fullName'] <> nil then
                                  bfax.contractor.fullName := varToStr(joContractor.Field['fullName'].Value);
                              except on E:Exception do
                                bfax.contractor.fullName := ''; //if exception error set this to Empty
                              end;
                            end;
                         end;
                      end;
                  end;
                except on exception do ; end;
                PopulateBuildFaxData(i,bfax,thisForm); //populate one permit at a time
              end;
          end;
      end;
   finally
     ckList.Free;
     js.Free;   //free this will free all children
   end;

end;


function GetCRM_BuildFaxPermitData(doc: TContainer;UserCredential:TAWCredentials;var ResponseData:String; var BuildFaxPermit:TBuildFaxPermit;var VendorTokenKey:String):Boolean;
const
  BuildFaxName = 'BuildFax';
  fBuildFax_SubjectFormID = 4320;
  fBuildFax_CompFormID    = 4321;
var
  httpRequest: IWinHTTPRequest;
  jsResult:TlkJSONObject;
  AuthenticationToken: WideString;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  thisForm: TDocForm;
  FormID:Integer;
  aFormUID: TFormUID;
begin
  result := False;
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

   PushMouseCursor(crHourglass);
  try
    AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
    if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
    ResponseData := GetCRM_BuildFaxPermitByAddress(doc, UserCredential,VendorTokenKey,BuildFaxPermit);
      begin
        result := length(ResponseData) >0;
        if result then
          begin
            if pos('subject',lowercase(BuildFaxPermit.RequestAddress.Title)) > 0 then  //for subject use form #4320
              FormID := fBuildFax_SubjectFormID
            else
              FormID := fBuildFax_CompFormID;   //for comps use form #4321
//            thisForm := doc.GetFormByOccurance(formID, 0,True);
            aFormUID := TFormUID.Create;
            try
              aFormUID.ID := FormID;
		          thisForm := doc.InsertFormUID(aFormUID, True, -1);		  //inserts and populates forms
            finally
              aFormUID.Free;
            end;
            if thisForm <> nil then
              LoadBuildFaxPermitData(doc,thisForm,responseData,BuildFaxPermit);
          end;
      end;
  finally
    PopMousecursor;
  end;
end;



function GetCRM_LocationMapsAuthenticationKey(UserCredential:TAWCredentials; var BingMapsKey:String):Boolean;
const
  CRM_BingAccountKey = 'Location Maps';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsResult:TlkJSONObject;
  aInt: Integer;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  ResponseData: String;
  AuthenticationToken,VendorTokenKey:String;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  try
    PushMouseCursor(crHourglass);
    AuthenticationToken := RefreshCRMToken(UserName, Password);
    if length(AuthenticationToken) = 0 then
      begin
        exit;
      end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

    url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('serviceMethod',CRM_Bingaccountkey_ServiceMethod);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
    jsPostRequest.Add('prodId',CRM_LocationMapsProdUID);      //pass prodUID
    jsRequestData := TlkJSONObject.Create(true);
    jsPostRequest.Add('requestData',jsRequestData);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  BingMapsKey := jsResult.Field['bingAccountKey'].Value;
                  if length(BingMapsKey) > 0 then
                    begin
                      SendAckToCRMServiceMgr(CRM_LocationMapsProdUID,CRM_Bingaccountkey_ServiceMethod,VendorTokenKey);
                      result := True;
                    end;
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  HandleCRMServerErrors(CRM_BingAccountKey,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(CRM_BingAccountKey,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(CRM_BingAccountKey,errMsg);
            end;
        end;
  end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function GetCRM_LPSSubjectDataByAddress(doc:TContainer;UserCredential:TAWCredentials;VendorTokenKey:String;var propInfo:TPropInfo):String;
const
  LPSName = 'LPS Public Data';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult, jsResponseType:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  Address,City,State,Zip,ZipPlus4,FullSubjectAddress: String;
begin
  result := '';

  if length(VendorTokenKey) = 0 then exit;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;


  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('serviceMethod', CRM_LPSPublicData_ServiceMethod);  //servicemethod
    jsPostRequest.Add('prodId',CRM_LPSProdUID);      //pass prodUID  7 for LPS
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsResponseType  := TlkJSONObject.Create(False);
    postJsonStr('streetAddress', propInfo.SubjectProperty.Address,jsRequestFields);  //pass full address
    postJsonStr('city', propInfo.SubjectProperty.City,jsRequestFields);  //pass full address
    postJsonStr('state', propInfo.SubjectProperty.State,jsRequestFields);  //pass full address
    postJsonStr('zipCode', propInfo.SubjectProperty.Zip,jsRequestFields);  //pass full address
//    postJsonBool('productionCall', UseProductionService,jsRequestFields);    //pass false for not production
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
//    jsPostRequest.Add('route', CRM_LPS_Route);         //pass route: propInfo
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
          if length(result) > 0 then
            SendAckToCRMServiceMgr(CRM_LPSProdUID,CRM_LPSPublicData_ServiceMethod,VendorTokenKey)
          else
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(LPSName,resultMsg);
            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(LPSName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(LPSName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(LPSName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function getjsonText(fieldName:String;json:TlkJsonBase):String;
begin
  if json.Field[fieldName].Field['_text'] <> nil then //example: {"Address":{"_Text":"123 main st"
    result := varToStrDef(json.Field[fieldName].Field['_text'].Value,'')
  else
    result := '';
end;


procedure LoadLPSSubjectToPropInfo(doc:TContainer;responseData:String;var propInfo:TPropInfo);
var
  js,jData,jSubjectProperty,jSaleHistory,jSalesHistory: TlkJSONBase;
  joData,joSubject: TlkJSONObject;
  jSalesHistoryList: TlkJSONList;
  TimeStamp:String;
  i,j:Integer;
  Subject:TSubjectProperty;
  salesHistory:TSalesHistory;
  LotSizeTxt: String;
begin
  if length(responseData) > 0 then
    begin
      js := TlkJSON.ParseText(ResponseData);
      if js <> nil then
        begin
          //Data section
          jData := js.Field['data'];
          if jdata <> nil then  //load data section
            begin
              joData := jData as TlkJSONObject;
              TimeStamp := getJSonString('DateTimeStamp',joData);
              jSubjectProperty:= joData.Field['SubjectProperty'];
              Subject := propInfo.SubjectProperty;
              Subject.Address := getJsonText('Address',jSubjectProperty);  
              Subject.City    := getJsonText('City',jSubjectProperty);     
              Subject.State   := getJsonText('State',jSubjectProperty);    
              Subject.Zip     := getJsonText('Zip',jSubjectProperty);      
              Subject.Zip4    := getJsonText('Zip4',jSubjectProperty);     
              Subject.CensusTract := getJsonText('CensusTract',jSubjectProperty);  
              LotSizeTxt := getJsonText('LotSize', jSubjectProperty); 
              Subject.SiteArea := GetValidNumber(ForceLotSizeToSqFt(LotSizeTxt));
              Subject.Taxes   := GetValidNumber(getJsonText('Taxes',jSubjectProperty));   
              Subject.YearBuilt := GetValidInteger(getJSonText('YearBuilt',jSubjectProperty)); 
              Subject.Longitude := GetValidNumber(getJSonText('Longitude',jSubjectProperty));  
              Subject.Latitude  := GetValidNumber(getJsonText('Latitude', jSubjectProperty));  
              Subject.TaxYear   := GetValidInteger(getJsonText('TaxYear', jSubjectProperty));  
              Subject.Stories   := GetValidInteger(getJsonText('Stories', jSubjectProperty));  
              Subject.DesignStyle := getJsonText('DesignStyle', jSubjectProperty); 
              Subject.AssessmentYear := GetValidInteger(getJsonText('AssessmentYear',jSubjectProperty));
              Subject.Owner := getJsonText('Owner', jSubjectProperty);    
              Subject.TotalRooms := GetValidInteger(getJsonText('TotalRooms', jSubjectProperty));  
              Subject.Garage := GetValidInteger(getJsonText('Garage',jSubjectProperty));  
              Subject.AssessedLandValue := GetValidNumber(getjsonText('AssessedLandValue',jSubjectProperty));   
              Subject.County := getjsonText('County',jSubjectProperty);   
              Subject.Bedrooms := GetValidInteger(getJsonText('Bedrooms',jSubjectProperty));    
              subject.Basement := GetValidInteger(getjsonText('Basement', jSubjectProperty));   
              Subject.BasementFinish := GetValidInteger(getjsonText('BasementFinish',jSubjectProperty));   
              Subject.AssessedImproveValue := GetValidNumber(getJsonText('AssessedImproveValue',jSubjectProperty));  
              Subject.APN := getJsonText('APN',jSubjectProperty);   
              Subject.Bath := GetValidNumber(getJSonText('Bath',jSubjectProperty));   
              Subject.TotalAssessedValue := GetValidNumber(getJsonText('TotalAssessedValue',jSubjectProperty));  
              Subject.BriefLegalDescription := getJsonText('BriefLegalDescription',jSubjectProperty);  
              Subject.GLA := GetValidInteger(getJsonText('GLA',jSubjectProperty));   

              //#### this is for Sales History
              if propInfo.SubjectProperty.FSalesHistory <> nil then
                propInfo.SubjectProperty.FSalesHistory.Clear;

              if jSubjectProperty.Field['SalesHistory'] <> nil then
                jSalesHistory := jSubjectProperty.Field['SalesHistory'];

              if jSalesHistory <> nil then
                jSaleHistory := jSalesHistory.Field['SaleHistory'];

             if jSaleHistory <> nil then
               if (jSaleHistory.Field['Buyer1FirstName'] = nil) and (jSaleHistory.Count > 1) then //this is array
                 begin
                    jSalesHistoryList := jSaleHistory as TlkJSONList;
                 end;

              if jSalesHistoryList <> nil then
                begin
                  for i:= 0 to jSalesHistoryList.Count -1 do
                    begin
                      jSaleHistory := jSalesHistoryList.Child[i] as TlkJSONBase;  //get each permit
                      if jSaleHistory = nil then continue;
                      salesHistory := TSalesHistory.Create;
                        salesHistory.Buyer1FirstName := getJsonText('Buyer1FirstName', jSaleHistory);
                        salesHistory.Buyer1LastName  := getJsonText('Buyer1LastName', jSaleHistory);
                        salesHistory.Buyer2FirstName := getJsonText('Buyer2FirstName', jSaleHistory);
                        salesHistory.Buyer2LastName  := getJsonText('Buyer2LastName', jSaleHistory);
                        salesHistory.Seller1FirstName := getJsonText('Seller1FirstName', jSaleHistory);
                        salesHistory.Seller1LastName  := getJsonText('Seller1LastName', jSaleHistory);
                        salesHistory.Seller2FirstName := getJsonText('Seller2FirstName', jSaleHistory);
                        salesHistory.Seller2LastName  := getJsonText('Seller2LastName', jSaleHistory);
                        salesHistory.DeedType         := getJsonText('DeedType', jSaleHistory);
                        salesHistory.SalePrice        := GetValidNumber(getJsonText('SalePrice', jSaleHistory));
                        salesHistory.SaleDate         := getJsonText('SaleDate', jSaleHistory);
                        salesHistory.REOFlag          := GetValidInteger(getJsonText('REOFlag', jSaleHistory));
                        if propInfo.SubjectProperty.FSalesHistory <> nil then
                          begin
                            propInfo.SubjectProperty.FSalesHistory.Add(salesHistory);
                            salesHistory := TSalesHistory(propInfo.SubjectProperty.FSalesHistory[i]);
                           // showmessage('BuyerFirstName = '+salesHistory.Buyer1FirstName);
                          end;
                    end;
                end
              else if jSaleHistory <> nil then
                begin
                  salesHistory := TSalesHistory.Create;
                  salesHistory.Buyer1FirstName := getJsonText('Buyer1FirstName', jSaleHistory);
                  salesHistory.Buyer1LastName  := getJsonText('Buyer1LastName', jSaleHistory);
                  salesHistory.Buyer2FirstName := getJsonText('Buyer2FirstName', jSaleHistory);
                  salesHistory.Buyer2LastName  := getJsonText('Buyer2LastName', jSaleHistory);
                  salesHistory.Seller1FirstName := getJsonText('Seller1FirstName', jSaleHistory);
                  salesHistory.Seller1LastName  := getJsonText('Seller1LastName', jSaleHistory);
                  salesHistory.Seller2FirstName := getJsonText('Seller2FirstName', jSaleHistory);
                  salesHistory.Seller2LastName  := getJsonText('Seller2LastName', jSaleHistory);
                  salesHistory.DeedType         := getJsonText('DeedType', jSaleHistory);
                  salesHistory.SalePrice        := GetValidNumber(getJsonText('SalePrice', jSaleHistory));
                  salesHistory.SaleDate         := getJsonText('SaleDate', jSaleHistory);
                  salesHistory.REOFlag          := GetValidInteger(getJsonText('REOFlag', jSaleHistory));
                  if propInfo.SubjectProperty.FSalesHistory <> nil then
                    begin
                      propInfo.SubjectProperty.FSalesHistory.Add(salesHistory);
                      salesHistory := TSalesHistory(propInfo.SubjectProperty.FSalesHistory[i]);
                     // showmessage('BuyerFirstName = '+salesHistory.Buyer1FirstName);
                    end;
                end;
            end;
        end;
    end;
end;


function GetCRM_LPSSubjectData(doc: TContainer;UserCredential:TAWCredentials; var propInfo:TPropInfo):Boolean;
const
  LPSName = 'LPS Public Data';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken,VendorTokenKey: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  Address,City,State,Zip,ZipPlus4: String;
  GeoCodeStr, FloodMapsStr: String;
  ResponseData:String;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;

   PushMouseCursor(crHourglass);
  try
    AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
    if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
    VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
    ResponseData := GetCRM_LPSSubjectDataByAddress(doc, UserCredential,VendorTokenKey,PropInfo);
      begin
        result := length(ResponseData) >0;
        if result then
          begin
            LoadLPSSubjectToPropInfo(doc,responseData,PropInfo);
          end;
      end;
  finally
    PopMousecursor;
  end;
end;


function GetCRM_MLSStatesList(UserCredential:TAWCredentials):String;
const
  MLSStateName = 'MLS States';
  UnitedStates = 'united states';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  AuthenticationToken,VendorTokenKey: WideString;
  responseTxt:String;
begin
  result := '';

  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
  if length(AuthenticationToken) = 0 then
  begin
    exit;
  end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
  url := CRM_ServiceRequestURL_FetchSpecial;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('prodId',CRM_MLSListProdUID);      //pass prodUID  7 for LPS
    jsPostRequest.Add('serviceMethod',CRM_GetMLSList_ServiceMethod);      //pass route
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
//    jsPostRequest.Add('route', CRM_GetStateList_route);         //pass route
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    jsResult := TlkJSON.ParseText(httpRequest.ResponseText) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(MLSStateName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(MLSStateName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MLSStateName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


function GetCRM_MLSList(UserCredential:TAWCredentials):String;
const
  MLSListName = 'MLS Name List';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  AuthenticationToken,VendorTokenKey: WideString;
begin
  result := '';

  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
  if length(AuthenticationToken) = 0 then
  begin
    exit;
  end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('serviceMethod',CRM_GetMLSList_ServiceMethod);
    jsPostRequest.Add('prodId',CRM_MLSListProdUID);
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
//    postJsonBool('productionCall', UseProductionService,jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
//    jsPostRequest.Add('route', CRM_GetMLSList_route);         //pass route: propInfo
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert,msgServiceNotAvaible);
      end;
    end;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := httpRequest.ResponseText;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(MLSListName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          HandleCRMServerErrors(MLSListName,resultMsg);
        end;
      else
        begin
          errMsg := 'Server error: Cannot import MLS data. '+ msgServiceGeneralMessage;
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MLSListName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
  end;
end;


function GetCRM_MLSData(UserCredential:TAWCredentials; MLSDetail:TGetMlsEnhancementDetails; var ResponseTxt:WideString):Boolean;
const
  MLSListName = 'MLS Data';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  AuthenticationToken,VendorTokenKey: WideString;
begin
  result := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
  if length(AuthenticationToken) = 0 then
  begin
    exit;
  end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);
  url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsPostRequest.Add('serviceMethod',CRM_GetMLSData_ServiceMethod);  
    jsPostRequest.Add('prodId',CRM_MLSListProdUID);
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsRequestFields.Add('mlsUID',MLSDetail.FMlsId);
    jsRequestFields.Add('mlsExportData',MLSDetail.FDataBuffer);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
    jsPostRequest.Add('bundleId', CRM_CFBundleID); //for ClickFORMS the bundleID is always 0
    jsPostRequest.Add('responseType','xml');   //ask server to return encodebase64 in xml format
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      if pos('\',RequestStr) > 0 then
       RequestStr := StringReplace(RequestStr,'\','',[rfReplaceAll]);


      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    jsResult := TlkJSON.ParseText(httpRequest.ResponseText) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := length(httpRequest.ResponseText) > 0;
          if jsResult <> nil then
            if jsResult.Field['Response'] <> nil then
              begin
                ResponseTxt := VarToStr(jsResult.Field['Response'].Value);
                SendAckToCRMServiceMgr(CRM_MLSListProdUID,CRM_GetMLSData_ServiceMethod,VendorTokenKey)
              end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
              resultMsg := jsResult.Field['message'].Value;

          HandleCRMServerErrors(MLSListName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              //resultMsg := jsResult.Field['message'].Value;
              //HandleCRMServerErrors(MLSListName,resultMsg);
              ResponseTxt := 'No Map';
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MLSListName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function GetCRM_MLSStateByCountry(UserCredential:TAWCredentials; var ResponseTxt:String):Boolean;
const
  MLSListName = 'GetStateByCountry';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  jStateList: TlkJSONList;
  jState:TlkJSONBase;
  resultMsg:String;
  UserName, Password, AWIdentifier: String;
  AuthenticationToken,VendorTokenKey: WideString;
  StateList:TStringList;
  i:Integer;
begin
  result := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
  if length(AuthenticationToken) = 0 then
    exit;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);


  url := CRM_ServiceRequestURL_FetchSpecial;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
    jsPostRequest.Add('prodId',CRM_MLSListProdUID);
    jsRequestFields.Add('country',COUNTRY_NAME_USA);
//    postJsonBool('productionCall', UseProductionService,jsRequestFields);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
    jsPostRequest.Add('requestType','json');
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    jsResult := TlkJSON.ParseText(httpRequest.ResponseText) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := length(httpRequest.ResponseText) > 0;
          if jsResult <> nil then
            if jsResult.Field['success'] <> nil then
              begin
                result := StrToBool(varToStr(jsResult.Field['success'].Value));
                if jsResult.Field['states'] <> nil then
                  jStateList := jsResult.Field['states'] as TlkJSonList;
                if jStateList <> nil then
                  stateList := TStringList.Create;
                  try
                    for i:= 0 to jStateList.count -1 do
                      begin
                       jState := jStateList.child[i].Field['StateName'];
                       if jState <> nil then
                         StateList.Add(varToStr(jState.Value));
                      end;
                    ResponseTxt := StateList.CommaText;
                  finally
                    stateList.Free;
                  end;
              end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
              resultMsg := jsResult.Field['message'].Value;

          HandleCRMServerErrors(MLSListName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              //resultMsg := jsResult.Field['message'].Value;
              //HandleCRMServerErrors(MLSListName,resultMsg);
              ResponseTxt := 'No Map';
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MLSListName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;


function GetCRM_MLSNamesByState(UserCredential:TAWCredentials; StateName:String; var MlsItemList:clsMlsDirectoryListing):Boolean;
const
  MLSListName = 'GetMLSNamesByState';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields:TlkJSONObject;
  jStateList,jMLSNameList: TlkJSONList;
  jState,jMLSName:TlkJSONBase;
  resultMsg:String;
  UserName, Password, AWIdentifier,MLSName: String;
  AuthenticationToken,VendorTokenKey: WideString;
  i:Integer;
  MlsItems: clsMlsDirectoryArrayItem;
begin
  result := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password); //Get token if needed
  if length(AuthenticationToken) = 0 then
    exit;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]);


  url := CRM_ServiceRequestURL_FetchSpecial;   //This point to DEV server for testing
  PushMouseCursor(crHourglass);
  try
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //call develop
    jsRequestData := TlkJSONObject.Create(False);
    jsRequestFields := TlkJSONObject.Create(False);
//    postJsonBool('productionCall', UseProductionService,jsRequestFields);
    jsPostRequest.Add('prodId',CRM_MLSListProdUID);
    jsRequestFields.Add('state',StateName);
    jsRequestFields.Add('outputFormat','json');
    jsRequestData.Add('requestFields',jsRequestFields);
    jsRequestData.Add('requestorId',CRM_RequestorID_CF);
    jsPostRequest.Add('requestData',jsRequestData);
//    jsPostRequest.Add('route', CRM_GetMLSNamesByState_route);         //pass route: propInfo
    jsPostRequest.Add('requestType','json');
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    jMLSNameList := TlkJSON.ParseText(httpRequest.ResponseText) as TlkJSONList;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          result := length(httpRequest.ResponseText) > 0;
          if jMLSNameList <> nil then
            begin
              for i:= 0 to jMLSNameList.Count -1 do
                begin
                  jMLSName := jMLSNameList.child[i];
                   MlsItems := clsMlsDirectoryArrayItem.Create;
                   if jMLSName.Field['FMls_Name'] <> nil then
                     MlsItems.Mls_Name := VarToStr(jMLSName.Field['FMls_Name'].Value);
                   if jMLSName.Field['FState'] <> nil then
                     MlsItems.State := VarToStr(jMLSName.Field['FState'].Value);
                   if jMLSName.Field['FMls_Url'] <> nil then
                     MlsItems.Mls_Url := VarToStr(jMLSName.Field['FMls_Url'].Value);
                   if jMLSName.Field['FMls_Full_Name'] <> nil then
                     MlsItems.Mls_Full_Name := VarToStr(jMLSName.Field['FMls_Full_Name'].Value);
                   SetLength(MlsItemList,jMlsNameList.Count);
                   MlsItemList[i] := MlsItems;
                end;
            end;
        end;
      httpResp500:
        begin
          resultMsg := httpRequest.ResponseText;
          HandleCRMServerErrors(MLSListName,resultMsg);
        end;
      httpResp502: //error code 502
        begin
          if jMLSNameList <> nil then
            begin
              //resultMsg := jsResult.Field['message'].Value;
              //HandleCRMServerErrors(MLSListName,resultMsg);
              //ResponseTxt := 'No Map';
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.',
                    [httpRequest.Status,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MLSListName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jMLSNameList) then
      jMLSNameList.Free;
  end;
end;


function GetCRM_PersmissionOnly(prodUID,serviceMethod:Integer;UserCredential:TAWCredentials;muteError:Boolean; var VendorTokenKey:String;ACK:Boolean=True): Boolean;
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  prodName:String;
begin
//showMessage('Calling CRM GetCRM_PersmissionOnly function');
  case prodUID of   //use prodname in show error
     CRM_1004MCProdUID:
       begin
         prodName := '1004MC';
//         ServiceMethod := CRM_1004MC_ServiceMethod;
       end;
     CRM_FloodMapsProdUID:
       begin
         prodName := 'FloodMaps';
//         ServiceMethod := CRM_FloodMapPermission_ServiceMethod;
       end;
     CRM_CLVSConnectionUID:
       begin
         prodName := 'CLVS Connection';
//         ServiceMethod := CRM_CLVS_ServiceMethod;
       end;
     CRM_AppraisalPortProdUID:
       begin
         prodName := 'AppraisalPort Connection';
//         ServiceMethod := CRM_AppraisalPort_ServiceMethod;
       end;
      CRM_MercuryNetworkUID:
        begin
          prodName := 'Mercury NetWork Connection';
//          ServiceMethod := CRM_Mercury_ServiceMethod;
        end;
     CRM_VendorPropertyDataUID:
       begin
         prodName := 'Vendor Property Data';
//         ServiceMethod := CRM_VendorProperty_ServiceMethod;
       end;
//     CRM_BuildFaxProdUID:  //only call turn on this if we need to do permission on buildfax
//       begin
//         prodName := 'BuildFax Permit History';
//       end;
  end;
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  PushMouseCursor(crHourglass);
  try
    url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
//  jsPostRequest.Add('serviceMethod', CRM_AppraisalPort_ServiceMethod);
    jsPostRequest.Add('serviceMethod', ServiceMethod);
    jsPostRequest.Add('prodId',prodUID);      //pass prodUID
    jsPostRequest.Add('permissionOnly',true);
    jsPostRequest.Add('bundleId', 0); //for ClickFORMS the bundleID is always 0
    jsPostRequest.Add('requestorId', CRM_RequestorID_CF); //tell SM we are ClickFORMS
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',VendorTokenKey);
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := msgServiceNotAvaible;
        showAlert(atWarnAlert,errMsg);
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  result := aOK;
                  if ACK then
                    SendAckToCRMServiceMgr(prodUID,serviceMethod,VendorTokenKey)
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  if not muteError then
                    HandleCRMServerErrors(prodName,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              if not muteError then
                HandleCRMServerErrors(prodName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              if not muteError then
                HandleCRMServerErrors(ProdName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function GetCRM_AppraisalPortAuthorized(UserCredential:TAWCredentials;muteError:Boolean; var VendorTokenKey:String): Boolean;
const
  AppraisalPort = 'Appraisal Port';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  PushMouseCursor(crHourglass);
  try
    url := CRMServiceRequest_Fetch_URL;   //This point to DEV server for testing
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);
    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
    jsPostRequest.Add('serviceMethod', CRM_AppraisalPort_ServiceMethod);
    jsPostRequest.Add('prodId',CRM_AppraisalPortProdUID);      //pass prodUID
    jsPostRequest.Add('permissionOnly',true);
    jsPostRequest.Add('bundleId', 0); //for ClickFORMS the bundleID is always 0
    jsPostRequest.Add('requestorId', CRM_RequestorID_CF); //tell SM we are ClickFORMS
    RequestStr := TlkJSON.GenerateText(jsPostRequest);
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
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  result := aOK;
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  if not muteError then
                    HandleCRMServerErrors(AppraisalPort,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              if not muteError then
                HandleCRMServerErrors(AppraisalPort,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              if not muteError then
                HandleCRMServerErrors(AppraisalPort,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;



function GetCRM_MarshalNSwiftToken_New(Location:TLocation; UserCredential:TAWCredentials; var VendorTokenKey:String; var CRMSecurityToken:String; var FCRMEstimateID:Integer):Boolean;
const
  MarshalName = 'Marshal Swift';
//  Marshal_NewToken_URL_DEV = 'http://develop-servicerequest.appraisalworld.com/fetch';
//  Marshal_NewToken_URL_LIVE = 'http://servicerequest.appraisalworld.com/fetch';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  EstimateId:String;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password,CurrentUser.LicInfo.FGroupID);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  PushMouseCursor(crHourglass);
  try
    url := CRMServiceRequest_Fetch_URL;
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);

    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
    jsPostRequest.Add('serviceMethod', CRM_MarshalNSwiftForNew_ServiceMethod);
    jsPostRequest.Add('prodId',CRM_MarshalNSwiftProdUID);      //pass prodUID

    jsRequestFields := TlkJSONObject.Create(False);
    jsRequestData := TlkJSONObject.Create(true);

    jsRequestFields.Add('propertyAddress',Location.FStreet);
    jsRequestFields.Add('propertyCity',Location.FCity);
    jsRequestFields.Add('propertyState',Location.FState);
    jsRequestFields.Add('propertyZipCode',Location.FZip);
    jsRequestFields.Add('estimateDescId',Location.FClientID);
    jsRequestFields.Add('clientId',Location.FClientID);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',trim(VendorTokenKey));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := msgServiceNotAvaible;
        showAlert(atWarnAlert, errMsg);
        result := False;
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  result := aOK;
                  CRMSecurityToken := trim(VarToStr(jsResult.Field['token'].Value));
                  if jsResult.Field['estimateId'] <> nil then
                    begin
                      EstimateId := varToStr(jsResult.Field['estimateId'].Value);
                      FCRMEstimateID := GetValidInteger(EstimateId);
                    end;
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  HandleCRMServerErrors(MarshalName,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(MarshalName,resultMsg);
              result := False;
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceNotAvaible]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MarshalName,errMsg);
              result := False;
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

function GetCRM_MarshalNSwiftToken_Existing(Location:TLocation; UserCredential:TAWCredentials;
                                            var VendorTokenKey:String; var CRMSecurityToken:String;
                                            var FCRMEstimateID:Integer):Boolean;
const
  MarshalName = 'Marshal Swift';
//  Marshal_Existing_Token_URL_DEV = 'https://develop-clickforms.appraisalworld.com/service-manager/fetch';
//  Marshal_Existing_Token_URL_LIVE = 'https://clickforms.appraisalworld.com/service-manager/fetch';
var
  errMsg,url: String;
  httpRequest: IWinHTTPRequest;
  RequestStr,respStr: String;
  jsResponse,jsPostRequest,jsRequestData,jsRequestFields,jsResult:TlkJSONObject;
  aInt: Integer;
  AuthenticationToken: WideString;
  aOK:Boolean;
  resultMsg:String;
  rsp: Integer;
  UserName, Password, AWIdentifier: String;
  DisablePurchaseButton: Boolean;
  EstimateId:String;
begin
  result := False;
  errMsg := '';
  aOK := False;
  resultMsg := '';
  DisablePurchaseButton := False;
  UserName := UserCredential.UserLoginEmail;
  Password := UserCredential.UserPassWord;
  AWIdentifier := UserCredential.AWIdentifier;
  AuthenticationToken := RefreshCRMToken(UserName, Password,CurrentUser.LicInfo.FGroupID);
  if length(AuthenticationToken) = 0 then
    begin
      exit;
    end;
  VendorTokenKey := Format('Bearer %s',[AuthenticationToken]); //we have the token, use it

  PushMouseCursor(crHourglass);
  try
    url := CRMServiceRequest_Fetch_URL;
    httpRequest := CoWinHTTPRequest.Create;
    httpRequest.SetTimeouts(60000,60000,60000,60000);   //1 minute for everything
    httpRequest.Open('POST',url,False);

    jsPostRequest := TlkJSONObject.Create(true);
    jsPostRequest.Add('vendorServer',CRMVendorServer);  //pass token
    jsPostRequest.Add('serviceMethod', CRM_MarshalNSwiftForExisting_ServiceMethod);
    jsPostRequest.Add('prodId',CRM_MarshalNSwiftProdUID);      //pass prodUID

    jsRequestFields := TlkJSONObject.Create(False);
    jsRequestData := TlkJSONObject.Create(true);

    jsRequestFields.Add('propertyAddress',Location.FStreet);
    jsRequestFields.Add('propertyCity',Location.FCity);
    jsRequestFields.Add('propertyState',Location.FState);
    jsRequestFields.Add('propertyZipCode',Location.FZip);
    jsRequestFields.Add('estimateId',FCRMEstimateID);
    jsRequestFields.Add('clientId',Location.FClientID);
    jsRequestData.Add('requestFields',jsRequestFields);
    jsPostRequest.Add('requestData',jsRequestData);
    RequestStr := TlkJSON.GenerateText(jsPostRequest);

    httpRequest.SetRequestHeader('Content-type','application/json');
    httpRequest.SetRequestHeader('Authorization',trim(VendorTokenKey));
    try
      httpRequest.send(RequestStr);
    except on e:Exception do
      begin
        errMsg := e.Message;
        showAlert(atWarnAlert, 'The server returned error: '+  errMsg);
      end;
    end;
    respStr := httpRequest.ResponseText;
    jsResult := TlkJSON.ParseText(respStr) as TlkJSONobject;
    case httpRequest.Status of
      httpRespOK:  //200 OK
        begin
          if jsResult <> nil then
            begin
              aOK := jsResult.Field['success'].Value;
              if aOK then
                begin
                  result := aOK;
                  CRMSecurityToken := trim(VarToStr(jsResult.Field['token'].Value));
                end
              else
                begin
                  resultMsg := jsResult.Field['message'].Value;
                  HandleCRMServerErrors(MarshalName,resultMsg);
                end;
            end;
        end;
      httpResp502: //error code 502
        begin
          if jsResult <> nil then
            begin
              resultMsg := jsResult.Field['message'].Value;
              HandleCRMServerErrors(MarshalName,resultMsg);
            end;
        end;
      else
        begin
          errMsg := Format('Server error: %d - %s.  %s',
                    [httpRequest.Status,jsResult.Field['message'].Value,msgServiceGeneralMessage]);
          if errMsg <> '' then
            begin
              HandleCRMServerErrors(MarshalName,errMsg);
            end;
        end;
    end;
  finally
    PopMousecursor;
    if assigned(jsResult) then
      jsResult.Free;
  end;
end;

initialization
  FCRMBundleID := CRM_CFBundleID;
  SetCRMServiceURL;


end.
