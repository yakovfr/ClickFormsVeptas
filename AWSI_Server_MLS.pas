// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://webservices.appraisalworld.com/ws/awsi/MlsServer.php?wsdl
//  >Import : https://webservices.appraisalworld.com/ws/awsi/MlsServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (12/3/2014 9:13:13 AM - - $Rev: 10138 $)
// ************************************************************************ //

unit AWSI_Server_MLS;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsUserCredentials   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponse = class;           { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponseData = class;       { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsEnhancementResponseData = class;     { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsEnhancementResponse = class;         { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsResponse    = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsData           = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsWordItem       = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsStatusCodeItem = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsListResponse = class;                { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsListData       = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsBoardItem      = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGenericStatusCodeItem = class;             { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityData = class;          { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityResponse = class;      { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgement   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsEnhancementCredentials = class;         { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsEnhancementDetails = class;          { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMlsDetails     = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsUsageAccessCredentials = class;            { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
    FCustomerOrderNumber_Specified: boolean;
    procedure SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
    function  CustomerOrderNumber_Specified(Index: Integer): boolean;
  published
    property Username:            WideString  read FUsername write FUsername;
    property Password:            WideString  read FPassword write FPassword;
    property CompanyKey:          WideString  read FCompanyKey write FCompanyKey;
    property OrderNumberKey:      WideString  read FOrderNumberKey write FOrderNumberKey;
    property Purchase:            Integer     read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString  Index (IS_OPTN) read FCustomerOrderNumber write SetCustomerOrderNumber stored CustomerOrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code:        Integer     read FCode write FCode;
    property Type_:       WideString  read FType_ write FType_;
    property Description: WideString  read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponseData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer  read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsEnhancementResponseData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsEnhancementResponseData = class(TRemotable)
  private
    FDataBuffer: WideString;
    FServiceAcknowledgement: WideString;
  published
    property DataBuffer:             WideString  read FDataBuffer write FDataBuffer;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsEnhancementResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsEnhancementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetMlsEnhancementResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                        read FResults write FResults;
    property ResponseData: clsGetMlsEnhancementResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: clsMlsData  read FResponseData write FResponseData;
  end;

  clsMlsFieldList = array of clsMlsWordItem;    { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsMlsStatusCodeList = array of clsMlsStatusCodeItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsMlsData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsData = class(TRemotable)
  private
    FXmlMap: WideString;
    FMlsWords: clsMlsFieldList;
    FMlsStatusAbbreviations: clsMlsStatusCodeList;
    FExportFields: WideString;
    FVendorName: WideString;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property XmlMap:                 WideString            read FXmlMap write FXmlMap;
    property MlsWords:               clsMlsFieldList       read FMlsWords write FMlsWords;
    property MlsStatusAbbreviations: clsMlsStatusCodeList  read FMlsStatusAbbreviations write FMlsStatusAbbreviations;
    property ExportFields:           WideString            read FExportFields write FExportFields;
    property VendorName:             WideString            read FVendorName write FVendorName;
    property ServiceAcknowledgement: WideString            read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsMlsWordItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsWordItem = class(TRemotable)
  private
    FWordDescr: WideString;
    FWordValue: WideString;
    FWordTypeId: Integer;
    FWordListId: Integer;
  published
    property WordDescr:  WideString  read FWordDescr write FWordDescr;
    property WordValue:  WideString  read FWordValue write FWordValue;
    property WordTypeId: Integer     read FWordTypeId write FWordTypeId;
    property WordListId: Integer     read FWordListId write FWordListId;
  end;



  // ************************************************************************ //
  // XML       : clsMlsStatusCodeItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsStatusCodeItem = class(TRemotable)
  private
    FStatusType: WideString;
    FStatusAbbreviation: WideString;
  published
    property StatusType:         WideString  read FStatusType write FStatusType;
    property StatusAbbreviation: WideString  read FStatusAbbreviation write FStatusAbbreviation;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsListResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsListResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsListData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults      read FResults write FResults;
    property ResponseData: clsMlsListData  read FResponseData write FResponseData;
  end;

  clsMlsBoardList = array of clsMlsBoardItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGenericStatusCodeList = array of clsGenericStatusCodeItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsMlsListData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsListData = class(TRemotable)
  private
    FMlsBoards: clsMlsBoardList;
    FGenericStatusCodes: clsGenericStatusCodeList;
  public
    destructor Destroy; override;
  published
    property MlsBoards:          clsMlsBoardList           read FMlsBoards write FMlsBoards;
    property GenericStatusCodes: clsGenericStatusCodeList  read FGenericStatusCodes write FGenericStatusCodes;
  end;



  // ************************************************************************ //
  // XML       : clsMlsBoardItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsBoardItem = class(TRemotable)
  private
    FMlsId: Integer;
    FMlsName: WideString;
    FMlsState: WideString;
  published
    property MlsId:    Integer     read FMlsId write FMlsId;
    property MlsName:  WideString  read FMlsName write FMlsName;
    property MlsState: WideString  read FMlsState write FMlsState;
  end;



  // ************************************************************************ //
  // XML       : clsGenericStatusCodeItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGenericStatusCodeItem = class(TRemotable)
  private
    FStatusType: WideString;
    FStatusAbbreviation: WideString;
  published
    property StatusType:         WideString  read FStatusType write FStatusType;
    property StatusAbbreviation: WideString  read FStatusAbbreviation write FStatusAbbreviation;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityData = class(TRemotable)
  private
    FServiceName: WideString;
    FWebServiceId: Integer;
    FProductAvailable: WideString;
    FMessage_: WideString;
    FExpirationDate: WideString;
    FAppraiserQuantity: Integer;
    FOwnerQuantity: Integer;
    FOwnerQuantity_Specified: boolean;
    procedure SetOwnerQuantity(Index: Integer; const AInteger: Integer);
    function  OwnerQuantity_Specified(Index: Integer): boolean;
  published
    property ServiceName:       WideString  read FServiceName write FServiceName;
    property WebServiceId:      Integer     read FWebServiceId write FWebServiceId;
    property ProductAvailable:  WideString  read FProductAvailable write FProductAvailable;
    property Message_:          WideString  read FMessage_ write FMessage_;
    property ExpirationDate:    WideString  read FExpirationDate write FExpirationDate;
    property AppraiserQuantity: Integer     read FAppraiserQuantity write FAppraiserQuantity;
    property OwnerQuantity:     Integer     Index (IS_OPTN) read FOwnerQuantity write SetOwnerQuantity stored OwnerQuantity_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilityData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilityData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgement, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Received:               Integer     read FReceived write FReceived;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsMlsEnhancementCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsEnhancementCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
    FCustomerOrderNumber_Specified: boolean;
    FServiceId: WideString;
    procedure SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
    function  CustomerOrderNumber_Specified(Index: Integer): boolean;
  published
    property Username:            WideString  read FUsername write FUsername;
    property Password:            WideString  read FPassword write FPassword;
    property CompanyKey:          WideString  read FCompanyKey write FCompanyKey;
    property OrderNumberKey:      WideString  read FOrderNumberKey write FOrderNumberKey;
    property Purchase:            Integer     read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString  Index (IS_OPTN) read FCustomerOrderNumber write SetCustomerOrderNumber stored CustomerOrderNumber_Specified;
    property ServiceId:           WideString  read FServiceId write FServiceId;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsEnhancementDetails, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsEnhancementDetails = class(TRemotable)
  private
    FMlsId: Integer;
    FDataBuffer: WideString;
  published
    property MlsId:      Integer     read FMlsId write FMlsId;
    property DataBuffer: WideString  read FDataBuffer write FDataBuffer;
  end;



  // ************************************************************************ //
  // XML       : clsGetMlsDetails, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMlsDetails = class(TRemotable)
  private
    FMlsId: Integer;
  published
    property MlsId: Integer  read FMlsId write FMlsId;
  end;



  // ************************************************************************ //
  // XML       : clsUsageAccessCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsUsageAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FServiceId: WideString;
  published
    property CustomerId: Integer     read FCustomerId write FCustomerId;
    property ServiceId:  WideString  read FServiceId write FServiceId;
  end;


  // ************************************************************************ //
  // Namespace : MlsServerClass
  // soapAction: MlsServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : MlsServerBinding
  // service   : MlsServer
  // port      : MlsServerPort
  // URL       : https://webservices.appraisalworld.com:443/ws/awsi/MlsServer.php
  // ************************************************************************ //
  MlsServerPortType = interface(IInvokable)
  ['{A738D578-26FA-F69A-9C9D-2404BB70B087}']
    function  MlsService_GetMls(const UserCredentials: clsUserCredentials; const MlsDetails: clsGetMlsDetails): clsGetMlsResponse; stdcall;
    function  MlsService_GetMlsEnhancement(const UserCredentials: clsMlsEnhancementCredentials; const MlsDetails: clsGetMlsEnhancementDetails): clsGetMlsEnhancementResponse; stdcall;
    function  MlsService_GetMlsList(const UserCredentials: clsUserCredentials): clsGetMlsListResponse; stdcall;
    function  MlsService_GetUsageAvailability(const UsageAccessCredentials: clsUsageAccessCredentials): clsGetUsageAvailabilityResponse; stdcall;
    function  MlsService_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetMlsServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MlsServerPortType;


implementation
  uses SysUtils;

function GetMlsServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MlsServerPortType;
const
  defWSDL = 'https://webservices.appraisalworld.com/ws/awsi/MlsServer.php?wsdl';
  defURL  = 'https://webservices.appraisalworld.com:443/ws/awsi/MlsServer.php';
  defSvc  = 'MlsServer';
  defPrt  = 'MlsServerPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as MlsServerPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure clsUserCredentials.SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FCustomerOrderNumber := AWideString;
  FCustomerOrderNumber_Specified := True;
end;

function clsUserCredentials.CustomerOrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FCustomerOrderNumber_Specified;
end;

destructor clsAcknowledgementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetMlsEnhancementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetMlsResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsMlsData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMlsWords)-1 do
    FreeAndNil(FMlsWords[I]);
  SetLength(FMlsWords, 0);
  for I := 0 to Length(FMlsStatusAbbreviations)-1 do
    FreeAndNil(FMlsStatusAbbreviations[I]);
  SetLength(FMlsStatusAbbreviations, 0);
  inherited Destroy;
end;

destructor clsGetMlsListResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsMlsListData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMlsBoards)-1 do
    FreeAndNil(FMlsBoards[I]);
  SetLength(FMlsBoards, 0);
  for I := 0 to Length(FGenericStatusCodes)-1 do
    FreeAndNil(FGenericStatusCodes[I]);
  SetLength(FGenericStatusCodes, 0);
  inherited Destroy;
end;

procedure clsGetUsageAvailabilityData.SetOwnerQuantity(Index: Integer; const AInteger: Integer);
begin
  FOwnerQuantity := AInteger;
  FOwnerQuantity_Specified := True;
end;

function clsGetUsageAvailabilityData.OwnerQuantity_Specified(Index: Integer): boolean;
begin
  Result := FOwnerQuantity_Specified;
end;

destructor clsGetUsageAvailabilityResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsMlsEnhancementCredentials.SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FCustomerOrderNumber := AWideString;
  FCustomerOrderNumber_Specified := True;
end;

function clsMlsEnhancementCredentials.CustomerOrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FCustomerOrderNumber_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MlsServerPortType), 'MlsServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MlsServerPortType), 'MlsServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(MlsServerPortType), 'MlsService_GetMls', 'MlsService.GetMls');
  InvRegistry.RegisterExternalMethName(TypeInfo(MlsServerPortType), 'MlsService_GetMlsEnhancement', 'MlsService.GetMlsEnhancement');
  InvRegistry.RegisterExternalMethName(TypeInfo(MlsServerPortType), 'MlsService_GetMlsList', 'MlsService.GetMlsList');
  InvRegistry.RegisterExternalMethName(TypeInfo(MlsServerPortType), 'MlsService_GetUsageAvailability', 'MlsService.GetUsageAvailability');
  InvRegistry.RegisterExternalMethName(TypeInfo(MlsServerPortType), 'MlsService_Acknowledgement', 'MlsService.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsGetMlsEnhancementResponseData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsEnhancementResponseData');
  RemClassRegistry.RegisterXSClass(clsGetMlsEnhancementResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsEnhancementResponse');
  RemClassRegistry.RegisterXSClass(clsGetMlsResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsFieldList), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsFieldList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsStatusCodeList), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsStatusCodeList');
  RemClassRegistry.RegisterXSClass(clsMlsData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsData');
  RemClassRegistry.RegisterXSClass(clsMlsWordItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsWordItem');
  RemClassRegistry.RegisterXSClass(clsMlsStatusCodeItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsStatusCodeItem');
  RemClassRegistry.RegisterXSClass(clsGetMlsListResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsListResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsBoardList), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsBoardList');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGenericStatusCodeList), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGenericStatusCodeList');
  RemClassRegistry.RegisterXSClass(clsMlsListData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsListData');
  RemClassRegistry.RegisterXSClass(clsMlsBoardItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsBoardItem');
  RemClassRegistry.RegisterXSClass(clsGenericStatusCodeItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGenericStatusCodeItem');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetUsageAvailabilityData');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsGetUsageAvailabilityData), 'Message_', 'Message');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetUsageAvailabilityResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsMlsEnhancementCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMlsEnhancementCredentials');
  RemClassRegistry.RegisterXSClass(clsGetMlsEnhancementDetails, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsEnhancementDetails');
  RemClassRegistry.RegisterXSClass(clsGetMlsDetails, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMlsDetails');
  RemClassRegistry.RegisterXSClass(clsUsageAccessCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsUsageAccessCredentials');

end.
