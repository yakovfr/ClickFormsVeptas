// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx?WSDL
//  >Import : http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (7/8/2009 3:08:40 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit UServiceCustomerSubscription;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  WSICustomerInfo      = class;                 { "http://tempuri.org/"[GblCplx] }
  ValidationBase       = class;                 { "http://tempuri.org/"[GblCplx] }
  WSIOrderInfo         = class;                 { "http://tempuri.org/"[GblCplx] }
  BrokenRule           = class;                 { "http://tempuri.org/"[GblCplx] }



  // ************************************************************************ //
  // XML       : WSICustomerInfo, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  WSICustomerInfo = class(TRemotable)
  private
    FEmail: WideString;
    FEmail_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    FResult: WideString;
    FResult_Specified: boolean;
    procedure SetEmail(Index: Integer; const AWideString: WideString);
    function  Email_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetResult(Index: Integer; const AWideString: WideString);
    function  Result_Specified(Index: Integer): boolean;
  published
    property Email:    WideString  Index (IS_OPTN) read FEmail write SetEmail stored Email_Specified;
    property Password: WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property Result:   WideString  Index (IS_OPTN) read FResult write SetResult stored Result_Specified;
  end;

  ArrayOfBrokenRule = array of BrokenRule;      { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : ValidationBase, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ValidationBase = class(TRemotable)
  private
    FBrokenRules: ArrayOfBrokenRule;
    FBrokenRules_Specified: boolean;
    procedure SetBrokenRules(Index: Integer; const AArrayOfBrokenRule: ArrayOfBrokenRule);
    function  BrokenRules_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BrokenRules: ArrayOfBrokenRule  Index (IS_OPTN) read FBrokenRules write SetBrokenRules stored BrokenRules_Specified;
  end;



  // ************************************************************************ //
  // XML       : WSIOrderInfo, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  WSIOrderInfo = class(ValidationBase)
  private
    FUserRefNo: WideString;
    FUserRefNo_Specified: boolean;
    FAddress: WideString;
    FAddress_Specified: boolean;
    FCity: WideString;
    FCity_Specified: boolean;
    FState: WideString;
    FState_Specified: boolean;
    FZip: WideString;
    FZip_Specified: boolean;
    procedure SetUserRefNo(Index: Integer; const AWideString: WideString);
    function  UserRefNo_Specified(Index: Integer): boolean;
    procedure SetAddress(Index: Integer; const AWideString: WideString);
    function  Address_Specified(Index: Integer): boolean;
    procedure SetCity(Index: Integer; const AWideString: WideString);
    function  City_Specified(Index: Integer): boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetZip(Index: Integer; const AWideString: WideString);
    function  Zip_Specified(Index: Integer): boolean;
  published
    property UserRefNo: WideString  Index (IS_OPTN) read FUserRefNo write SetUserRefNo stored UserRefNo_Specified;
    property Address:   WideString  Index (IS_OPTN) read FAddress write SetAddress stored Address_Specified;
    property City:      WideString  Index (IS_OPTN) read FCity write SetCity stored City_Specified;
    property State:     WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zip:       WideString  Index (IS_OPTN) read FZip write SetZip stored Zip_Specified;
  end;



  // ************************************************************************ //
  // XML       : BrokenRule, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  BrokenRule = class(TRemotable)
  private
    FMessage_: WideString;
    FMessage__Specified: boolean;
    FPropertyName: WideString;
    FPropertyName_Specified: boolean;
    procedure SetMessage_(Index: Integer; const AWideString: WideString);
    function  Message__Specified(Index: Integer): boolean;
    procedure SetPropertyName(Index: Integer; const AWideString: WideString);
    function  PropertyName_Specified(Index: Integer): boolean;
  published
    property Message_:     WideString  Index (IS_OPTN) read FMessage_ write SetMessage_ stored Message__Specified;
    property PropertyName: WideString  Index (IS_OPTN) read FPropertyName write SetPropertyName stored PropertyName_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CustomerSubscriptionServiceSoap
  // service   : CustomerSubscriptionService
  // port      : CustomerSubscriptionServiceSoap
  // URL       : http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx
  // ************************************************************************ //
  CustomerSubscriptionServiceSoap = interface(IInvokable)
  ['{BB4834A6-E82B-99E7-049E-557671647509}']
    function  GetSecurityToken(const ipUserName: WideString; const ipPassword: WideString; const ipEntryPoint: WideString; var opOverageFee: TXSDecimal; var opMessage: WideString): WideString; stdcall;
    function  GetCustomerInfoByID(const ipID: Integer; const ipPassword: WideString): WSICustomerInfo; stdcall;
    function  GetOrderNo(const ipUserName: WideString; const ipPassword: WideString; const ipWSIOrderInfo: WSIOrderInfo; var opMessage: WideString): WideString; stdcall;
  end;

function GetCustomerSubscriptionServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CustomerSubscriptionServiceSoap;


implementation
  uses SysUtils;

function GetCustomerSubscriptionServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CustomerSubscriptionServiceSoap;
const
  defWSDL = 'http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx?WSDL';
  defURL  = 'http://wsi.bradfordsoftware.com/WSCustomerSubscription/customerSubscriptionService.asmx';
  defSvc  = 'CustomerSubscriptionService';
  defPrt  = 'CustomerSubscriptionServiceSoap';
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
    Result := (RIO as CustomerSubscriptionServiceSoap);
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


procedure WSICustomerInfo.SetEmail(Index: Integer; const AWideString: WideString);
begin
  FEmail := AWideString;
  FEmail_Specified := True;
end;

function WSICustomerInfo.Email_Specified(Index: Integer): boolean;
begin
  Result := FEmail_Specified;
end;

procedure WSICustomerInfo.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function WSICustomerInfo.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure WSICustomerInfo.SetResult(Index: Integer; const AWideString: WideString);
begin
  FResult := AWideString;
  FResult_Specified := True;
end;

function WSICustomerInfo.Result_Specified(Index: Integer): boolean;
begin
  Result := FResult_Specified;
end;

destructor ValidationBase.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FBrokenRules)-1 do
    FreeAndNil(FBrokenRules[I]);
  SetLength(FBrokenRules, 0);
  inherited Destroy;
end;

procedure ValidationBase.SetBrokenRules(Index: Integer; const AArrayOfBrokenRule: ArrayOfBrokenRule);
begin
  FBrokenRules := AArrayOfBrokenRule;
  FBrokenRules_Specified := True;
end;

function ValidationBase.BrokenRules_Specified(Index: Integer): boolean;
begin
  Result := FBrokenRules_Specified;
end;

procedure WSIOrderInfo.SetUserRefNo(Index: Integer; const AWideString: WideString);
begin
  FUserRefNo := AWideString;
  FUserRefNo_Specified := True;
end;

function WSIOrderInfo.UserRefNo_Specified(Index: Integer): boolean;
begin
  Result := FUserRefNo_Specified;
end;

procedure WSIOrderInfo.SetAddress(Index: Integer; const AWideString: WideString);
begin
  FAddress := AWideString;
  FAddress_Specified := True;
end;

function WSIOrderInfo.Address_Specified(Index: Integer): boolean;
begin
  Result := FAddress_Specified;
end;

procedure WSIOrderInfo.SetCity(Index: Integer; const AWideString: WideString);
begin
  FCity := AWideString;
  FCity_Specified := True;
end;

function WSIOrderInfo.City_Specified(Index: Integer): boolean;
begin
  Result := FCity_Specified;
end;

procedure WSIOrderInfo.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function WSIOrderInfo.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure WSIOrderInfo.SetZip(Index: Integer; const AWideString: WideString);
begin
  FZip := AWideString;
  FZip_Specified := True;
end;

function WSIOrderInfo.Zip_Specified(Index: Integer): boolean;
begin
  Result := FZip_Specified;
end;

procedure BrokenRule.SetMessage_(Index: Integer; const AWideString: WideString);
begin
  FMessage_ := AWideString;
  FMessage__Specified := True;
end;

function BrokenRule.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure BrokenRule.SetPropertyName(Index: Integer; const AWideString: WideString);
begin
  FPropertyName := AWideString;
  FPropertyName_Specified := True;
end;

function BrokenRule.PropertyName_Specified(Index: Integer): boolean;
begin
  Result := FPropertyName_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(CustomerSubscriptionServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CustomerSubscriptionServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterReturnParamNames(TypeInfo(CustomerSubscriptionServiceSoap), 'GetSecurityTokenResult;GetCustomerInfoByIDResult;GetOrderNoResult');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CustomerSubscriptionServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(WSICustomerInfo, 'http://tempuri.org/', 'WSICustomerInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfBrokenRule), 'http://tempuri.org/', 'ArrayOfBrokenRule');
  RemClassRegistry.RegisterXSClass(ValidationBase, 'http://tempuri.org/', 'ValidationBase');
  RemClassRegistry.RegisterXSClass(WSIOrderInfo, 'http://tempuri.org/', 'WSIOrderInfo');
  RemClassRegistry.RegisterXSClass(BrokenRule, 'http://tempuri.org/', 'BrokenRule');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BrokenRule), 'Message_', 'Message');

end.