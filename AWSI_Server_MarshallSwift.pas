// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme.atbx.net/secure/ws/awsi/MarshallSwiftServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (9/19/2013 10:02:02 AM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_MarshallSwift;

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

  clsUserCredentials   = class;                 { "http://carme.atbx.net/secure/ws/WSDL" }
  clsResults           = class;                 { "http://carme.atbx.net/secure/ws/WSDL" }
  clsAcknowledgementResponseData = class;       { "http://carme.atbx.net/secure/ws/WSDL" }
  clsAcknowledgementResponse = class;           { "http://carme.atbx.net/secure/ws/WSDL" }
  clsCheckSubscriptionResponseData = class;     { "http://carme.atbx.net/secure/ws/WSDL" }
  clsCheckSubscriptionResponse = class;         { "http://carme.atbx.net/secure/ws/WSDL" }
  clsIsActiveMemberResponseData = class;        { "http://carme.atbx.net/secure/ws/WSDL" }
  clsIsActiveMemberResponse = class;            { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetRegionFromZipResponseData = class;      { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetRegionFromZipResponse = class;          { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForExistingResponseData = class;   { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForExistingResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForNewResponseData = class;   { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForNewResponse = class;    { "http://carme.atbx.net/secure/ws/WSDL" }
  clsAcknowledgement   = class;                 { "http://carme.atbx.net/secure/ws/WSDL" }
  clsCheckSubscriptionRequest = class;          { "http://carme.atbx.net/secure/ws/WSDL" }
  clsIsActiveMemberRequest = class;             { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetRegionFromZipRequest = class;           { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForExistingRequest = class;   { "http://carme.atbx.net/secure/ws/WSDL" }
  clsGetSecurityTokenForNewRequest = class;     { "http://carme.atbx.net/secure/ws/WSDL" }



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
    FServiceId: WideString;
  published
    property Username: WideString read FUsername write FUsername;
    property Password: WideString read FPassword write FPassword;
    property CompanyKey: WideString read FCompanyKey write FCompanyKey;
    property OrderNumberKey: WideString read FOrderNumberKey write FOrderNumberKey;
    property Purchase: Integer read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString read FCustomerOrderNumber write FCustomerOrderNumber;
    property ServiceId: WideString read FServiceId write FServiceId;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCheckSubscriptionResponseData = class(TRemotable)
  private
    FCheckSubscriptionResult: WideString;
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property CheckSubscriptionResult: WideString read FCheckSubscriptionResult write FCheckSubscriptionResult;
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCheckSubscriptionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsCheckSubscriptionResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsCheckSubscriptionResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsActiveMemberResponseData = class(TRemotable)
  private
    FIsActiveMemberResult: Integer;
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property IsActiveMemberResult: Integer read FIsActiveMemberResult write FIsActiveMemberResult;
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsActiveMemberResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsIsActiveMemberResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsIsActiveMemberResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetRegionFromZipResponseData = class(TRemotable)
  private
    FGetRegionFromZipResponse: WideString;
  published
    property GetRegionFromZipResponse: WideString read FGetRegionFromZipResponse write FGetRegionFromZipResponse;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetRegionFromZipResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetRegionFromZipResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetRegionFromZipResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForExistingResponseData = class(TRemotable)
  private
    FSecurityToken: WideString;
    FMsg: WideString;
    FMsgCode: Integer;
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property SecurityToken: WideString read FSecurityToken write FSecurityToken;
    property Msg: WideString read FMsg write FMsg;
    property MsgCode: Integer read FMsgCode write FMsgCode;
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForExistingResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetSecurityTokenForExistingResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetSecurityTokenForExistingResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForNewResponseData = class(TRemotable)
  private
    FSecurityToken: WideString;
    FMsg: WideString;
    FEstimateId: Integer;
    FMsgCode: Integer;
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property SecurityToken: WideString read FSecurityToken write FSecurityToken;
    property Msg: WideString read FMsg write FMsg;
    property EstimateId: Integer read FEstimateId write FEstimateId;
    property MsgCode: Integer read FMsgCode write FMsgCode;
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForNewResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetSecurityTokenForNewResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetSecurityTokenForNewResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCheckSubscriptionRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsIsActiveMemberRequest = class(TRemotable)
  private
    FCustomerId: Integer;
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
  published
    property CustomerId: Integer read FCustomerId write FCustomerId;
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetRegionFromZipRequest = class(TRemotable)
  private
    FZipCode: WideString;
  published
    property ZipCode: WideString read FZipCode write FZipCode;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForExistingRequest = class(TRemotable)
  private
    FEstimateId: Integer;
  published
    property EstimateId: Integer read FEstimateId write FEstimateId;
  end;



  // ************************************************************************ //
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSecurityTokenForNewRequest = class(TRemotable)
  private
    FEstimateDescription: WideString;
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
  published
    property EstimateDescription: WideString read FEstimateDescription write FEstimateDescription;
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
  end;


  // ************************************************************************ //
  // Namespace : MarshallSwiftServerClass
  // soapAction: MarshallSwiftServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : MarshallSwiftServerBinding
  // service   : MarshallSwiftServer
  // port      : MarshallSwiftServerPort
  // URL       : http://carme.atbx.net/secure/ws/awsi/MarshallSwiftServer.php
  // ************************************************************************ //
  MarshallSwiftServerPortType = interface(IInvokable)
  ['{3F07E3B3-C7F4-4127-BD19-75D38AA3AD9D}']
    function  MarshallSwiftServices_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
    function  MarshallSwiftServices_CheckSubscription(const UserCredentials: clsUserCredentials; const CheckSubscriptionDetails: clsCheckSubscriptionRequest): clsCheckSubscriptionResponse; stdcall;
    function  MarshallSwiftServices_GetRegionFromZip(const UserCredentials: clsUserCredentials; const RequestDetails: clsGetRegionFromZipRequest): clsGetRegionFromZipResponse; stdcall;
    function  MarshallSwiftServices_GetSecurityTokenForExisting(const UserCredentials: clsUserCredentials; const RequestDetails: clsGetSecurityTokenForExistingRequest): clsGetSecurityTokenForExistingResponse; stdcall;
    function  MarshallSwiftServices_GetSecurityTokenForNew(const UserCredentials: clsUserCredentials; const RequestDetails: clsGetSecurityTokenForNewRequest): clsGetSecurityTokenForNewResponse; stdcall;
    function  MarshallSwiftServices_IsActiveMember(const UserCredentials: clsUserCredentials; const CheckSubscriptionDetails: clsIsActiveMemberRequest): clsIsActiveMemberResponse; stdcall;
  end;

function GetMarshallSwiftServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MarshallSwiftServerPortType;


implementation

function GetMarshallSwiftServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MarshallSwiftServerPortType;
const
  defWSDL = 'http://carme.atbx.net/secure/ws/awsi/MarshallSwiftServer.php?wsdl';
  defURL  = 'http://carme.atbx.net/secure/ws/awsi/MarshallSwiftServer.php';
  defSvc  = 'MarshallSwiftServer';
  defPrt  = 'MarshallSwiftServerPort';
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
    Result := (RIO as MarshallSwiftServerPortType);
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

destructor clsCheckSubscriptionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsIsActiveMemberResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetRegionFromZipResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetSecurityTokenForExistingResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetSecurityTokenForNewResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_Acknowledgement', 'MarshallSwiftServices.Acknowledgement');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_CheckSubscription', 'MarshallSwiftServices.CheckSubscription');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_GetRegionFromZip', 'MarshallSwiftServices.GetRegionFromZip');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_GetSecurityTokenForExisting', 'MarshallSwiftServices.GetSecurityTokenForExisting');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_GetSecurityTokenForNew', 'MarshallSwiftServices.GetSecurityTokenForNew');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarshallSwiftServerPortType), 'MarshallSwiftServices_IsActiveMember', 'MarshallSwiftServices.IsActiveMember');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme.atbx.net/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsCheckSubscriptionResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCheckSubscriptionResponseData');
  RemClassRegistry.RegisterXSClass(clsCheckSubscriptionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCheckSubscriptionResponse');
  RemClassRegistry.RegisterXSClass(clsIsActiveMemberResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsActiveMemberResponseData');
  RemClassRegistry.RegisterXSClass(clsIsActiveMemberResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsActiveMemberResponse');
  RemClassRegistry.RegisterXSClass(clsGetRegionFromZipResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetRegionFromZipResponseData');
  RemClassRegistry.RegisterXSClass(clsGetRegionFromZipResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetRegionFromZipResponse');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForExistingResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForExistingResponseData');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForExistingResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForExistingResponse');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForNewResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForNewResponseData');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForNewResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForNewResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsCheckSubscriptionRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCheckSubscriptionRequest');
  RemClassRegistry.RegisterXSClass(clsIsActiveMemberRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsIsActiveMemberRequest');
  RemClassRegistry.RegisterXSClass(clsGetRegionFromZipRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetRegionFromZipRequest');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForExistingRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForExistingRequest');
  RemClassRegistry.RegisterXSClass(clsGetSecurityTokenForNewRequest, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGetSecurityTokenForNewRequest');

end.