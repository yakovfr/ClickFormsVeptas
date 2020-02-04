// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/BingAuthorizationServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (10/4/2013 11:11:41 AM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_BingMaps;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:int             - "http://www.w3.org/2001/XMLSchema"

  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL" }
  clsResults           = class;                 { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponseData = class;       { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponse = class;           { "http://carme/secure/ws/WSDL" }
  clsGetBingAuthorizationKeyResponse = class;   { "http://carme/secure/ws/WSDL" }
  clsGetUsageAvailabilityData = class;          { "http://carme/secure/ws/WSDL" }
  clsGetUsageAvailabilityResponse = class;      { "http://carme/secure/ws/WSDL" }
  clsAcknowledgement   = class;                 { "http://carme/secure/ws/WSDL" }
  clsUsageAccessCredentials = class;            { "http://carme/secure/ws/WSDL" }



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
    FSubscriberId: WideString;
    FAccessId: WideString;
  published
    property Username: WideString read FUsername write FUsername;
    property Password: WideString read FPassword write FPassword;
    property CompanyKey: WideString read FCompanyKey write FCompanyKey;
    property OrderNumberKey: WideString read FOrderNumberKey write FOrderNumberKey;
    property Purchase: Integer read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString read FCustomerOrderNumber write FCustomerOrderNumber;
    property SubscriberId: WideString read FSubscriberId write FSubscriberId;
    property AccessId: WideString read FAccessId write FAccessId;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code: Integer read FCode write FCode;
    property Type_: WideString read FType_ write FType_;
    property Description: WideString read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetBingAuthorizationKeyResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: WideString;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: WideString read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityData = class(TRemotable)
  private
    FServiceName: WideString;
    FWebServiceId: Integer;
    FProductAvailable: WideString;
    FMessage: WideString;
    FExpirationDate: WideString;
    FAppraiserQuantity: Integer;
    FOwnerQuantity: Integer;
  published
    property ServiceName: WideString read FServiceName write FServiceName;
    property WebServiceId: Integer read FWebServiceId write FWebServiceId;
    property ProductAvailable: WideString read FProductAvailable write FProductAvailable;
    property Message: WideString read FMessage write FMessage;
    property ExpirationDate: WideString read FExpirationDate write FExpirationDate;
    property AppraiserQuantity: Integer read FAppraiserQuantity write FAppraiserQuantity;
    property OwnerQuantity: Integer read FOwnerQuantity write FOwnerQuantity;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilityData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilityData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUsageAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FServiceId: WideString;
  published
    property CustomerId: Integer read FCustomerId write FCustomerId;
    property ServiceId: WideString read FServiceId write FServiceId;
  end;


  // ************************************************************************ //
  // Namespace : BingAuthorizationServerClass
  // soapAction: BingAuthorizationServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : BingAuthorizationServerBinding
  // service   : BingAuthorizationServer
  // port      : BingAuthorizationServerPort
  // URL       : http://carme/secure/ws/awsi/BingAuthorizationServer.php
  // ************************************************************************ //
  BingAuthorizationServerPortType = interface(IInvokable)
  ['{4234BFB8-BDC6-2A86-A9A0-1521C79FF7BD}']
    function  BingAuthorizationServices_GetUsageAvailability(const UsageAccessCredentials: clsUsageAccessCredentials): clsGetUsageAvailabilityResponse; stdcall;
    function  BingAuthorizationServices_GetBingAuthorizationKey(const UserCredentials: clsUserCredentials): clsGetBingAuthorizationKeyResponse; stdcall;
    function  BingAuthorizationServices_Acknowledgement(const UserCredentials: clsUserCredentials; const ServiceAcknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetBingAuthorizationServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): BingAuthorizationServerPortType;


implementation

function GetBingAuthorizationServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): BingAuthorizationServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/BingAuthorizationServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/BingAuthorizationServer.php';
  defSvc  = 'BingAuthorizationServer';
  defPrt  = 'BingAuthorizationServerPort';
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
    Result := (RIO as BingAuthorizationServerPortType);
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


destructor clsAcknowledgementResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetBingAuthorizationKeyResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  inherited Destroy;
end;

destructor clsGetUsageAvailabilityResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(BingAuthorizationServerPortType), 'BingAuthorizationServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(BingAuthorizationServerPortType), 'BingAuthorizationServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(BingAuthorizationServerPortType), 'BingAuthorizationServices_GetUsageAvailability', 'BingAuthorizationServices.GetUsageAvailability');
  InvRegistry.RegisterExternalMethName(TypeInfo(BingAuthorizationServerPortType), 'BingAuthorizationServices_GetBingAuthorizationKey', 'BingAuthorizationServices.GetBingAuthorizationKey');
  InvRegistry.RegisterExternalMethName(TypeInfo(BingAuthorizationServerPortType), 'BingAuthorizationServices_Acknowledgement', 'BingAuthorizationServices.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsGetBingAuthorizationKeyResponse, 'http://carme/secure/ws/WSDL', 'clsGetBingAuthorizationKeyResponse');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityData, 'http://carme/secure/ws/WSDL', 'clsGetUsageAvailabilityData');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityResponse, 'http://carme/secure/ws/WSDL', 'clsGetUsageAvailabilityResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsUsageAccessCredentials, 'http://carme/secure/ws/WSDL', 'clsUsageAccessCredentials');

end.