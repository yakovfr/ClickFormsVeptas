// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ws.beta.onpresidio.com/AppraiserSoftwareIntegration/AppraiserSoftwareIntegration.asmx?wsdl
//  >Import : http://ws.beta.onpresidio.com/AppraiserSoftwareIntegration/AppraiserSoftwareIntegration.asmx?wsdl:0
// Encoding : utf-8
// Version  : 1.0
// (10/12/2010 2:16:58 PM - - $Rev: 10138 $)
// ************************************************************************ //

// Unit name change from AppraiserSoftwareIntegration to NasoftOrderService_TLB
//  for consistent naming purpose only. This file was generated using the
//  Delphi2007 WSDLImp.exe program from AppraiserSoftwareIntegration.bat.
unit NasoftOrderService_TLB;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
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
  // !:unsignedShort   - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Response             = class;                 { "http://wavesphere.net/2009/03"[GblCplx] }
  OrderResponse        = class;                 { "http://wavesphere.net/2009/03"[GblCplx] }
  XmlResponse          = class;                 { "http://wavesphere.net/2009/03"[GblCplx] }
  GetDataRequest       = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }
  GetDataResponse      = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }
  ValidateDataRequest  = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }
  ValidateDataResponse = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }
  FulfillDataRequest   = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }
  FulfillDataResponse  = class;                 { "http://wavesphere.net/2009/03"[Lit][GblElm] }



  // ************************************************************************ //
  // XML       : Response, global, <complexType>
  // Namespace : http://wavesphere.net/2009/03
  // ************************************************************************ //
  Response = class(TRemotable)
  private
    FResponseID: Word;
    FDescription: WideString;
    FDescription_Specified: boolean;
    procedure SetDescription(Index: Integer; const AWideString: WideString);
    function  Description_Specified(Index: Integer): boolean;
  published
    property ResponseID:  Word        read FResponseID write FResponseID;
    property Description: WideString  Index (IS_OPTN) read FDescription write SetDescription stored Description_Specified;
  end;



  // ************************************************************************ //
  // XML       : OrderResponse, global, <complexType>
  // Namespace : http://wavesphere.net/2009/03
  // ************************************************************************ //
  OrderResponse = class(Response)
  private
    FOrderData: WideString;
    FOrderData_Specified: boolean;
    procedure SetOrderData(Index: Integer; const AWideString: WideString);
    function  OrderData_Specified(Index: Integer): boolean;
  published
    property OrderData: WideString  Index (IS_OPTN) read FOrderData write SetOrderData stored OrderData_Specified;
  end;



  // ************************************************************************ //
  // XML       : XmlResponse, global, <complexType>
  // Namespace : http://wavesphere.net/2009/03
  // ************************************************************************ //
  XmlResponse = class(Response)
  private
    FResponse: WideString;
    FResponse_Specified: boolean;
    procedure SetResponse(Index: Integer; const AWideString: WideString);
    function  Response_Specified(Index: Integer): boolean;
  published
    property Response: WideString  Index (IS_OPTN) read FResponse write SetResponse stored Response_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetDataRequest, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetDataRequest = class(TRemotable)
  private
    FSoftwareID: WideString;
    FSoftwareID_Specified: boolean;
    FSoftwarePassword: WideString;
    FSoftwarePassword_Specified: boolean;
    FUserID: WideString;
    FUserID_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    FOrderReference: WideString;
    FOrderReference_Specified: boolean;
    procedure SetSoftwareID(Index: Integer; const AWideString: WideString);
    function  SoftwareID_Specified(Index: Integer): boolean;
    procedure SetSoftwarePassword(Index: Integer; const AWideString: WideString);
    function  SoftwarePassword_Specified(Index: Integer): boolean;
    procedure SetUserID(Index: Integer; const AWideString: WideString);
    function  UserID_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetOrderReference(Index: Integer; const AWideString: WideString);
    function  OrderReference_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property SoftwareID:       WideString  Index (IS_OPTN) read FSoftwareID write SetSoftwareID stored SoftwareID_Specified;
    property SoftwarePassword: WideString  Index (IS_OPTN) read FSoftwarePassword write SetSoftwarePassword stored SoftwarePassword_Specified;
    property UserID:           WideString  Index (IS_OPTN) read FUserID write SetUserID stored UserID_Specified;
    property Password:         WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property OrderReference:   WideString  Index (IS_OPTN) read FOrderReference write SetOrderReference stored OrderReference_Specified;
  end;



  // ************************************************************************ //
  // XML       : GetDataResponse, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  GetDataResponse = class(OrderResponse)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : ValidateDataRequest, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ValidateDataRequest = class(TRemotable)
  private
    FSoftwareID: WideString;
    FSoftwareID_Specified: boolean;
    FSoftwarePassword: WideString;
    FSoftwarePassword_Specified: boolean;
    FUserID: WideString;
    FUserID_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    FOrderReference: WideString;
    FOrderReference_Specified: boolean;
    FData: WideString;
    FData_Specified: boolean;
    procedure SetSoftwareID(Index: Integer; const AWideString: WideString);
    function  SoftwareID_Specified(Index: Integer): boolean;
    procedure SetSoftwarePassword(Index: Integer; const AWideString: WideString);
    function  SoftwarePassword_Specified(Index: Integer): boolean;
    procedure SetUserID(Index: Integer; const AWideString: WideString);
    function  UserID_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetOrderReference(Index: Integer; const AWideString: WideString);
    function  OrderReference_Specified(Index: Integer): boolean;
    procedure SetData(Index: Integer; const AWideString: WideString);
    function  Data_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property SoftwareID:       WideString  Index (IS_OPTN) read FSoftwareID write SetSoftwareID stored SoftwareID_Specified;
    property SoftwarePassword: WideString  Index (IS_OPTN) read FSoftwarePassword write SetSoftwarePassword stored SoftwarePassword_Specified;
    property UserID:           WideString  Index (IS_OPTN) read FUserID write SetUserID stored UserID_Specified;
    property Password:         WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property OrderReference:   WideString  Index (IS_OPTN) read FOrderReference write SetOrderReference stored OrderReference_Specified;
    property Data:             WideString  Index (IS_OPTN) read FData write SetData stored Data_Specified;
  end;



  // ************************************************************************ //
  // XML       : ValidateDataResponse, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ValidateDataResponse = class(XmlResponse)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // XML       : FulfillDataRequest, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  FulfillDataRequest = class(TRemotable)
  private
    FSoftwareID: WideString;
    FSoftwareID_Specified: boolean;
    FSoftwarePassword: WideString;
    FSoftwarePassword_Specified: boolean;
    FUserID: WideString;
    FUserID_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    FOrderReference: WideString;
    FOrderReference_Specified: boolean;
    FDataWithPdf: WideString;
    FDataWithPdf_Specified: boolean;
    procedure SetSoftwareID(Index: Integer; const AWideString: WideString);
    function  SoftwareID_Specified(Index: Integer): boolean;
    procedure SetSoftwarePassword(Index: Integer; const AWideString: WideString);
    function  SoftwarePassword_Specified(Index: Integer): boolean;
    procedure SetUserID(Index: Integer; const AWideString: WideString);
    function  UserID_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
    procedure SetOrderReference(Index: Integer; const AWideString: WideString);
    function  OrderReference_Specified(Index: Integer): boolean;
    procedure SetDataWithPdf(Index: Integer; const AWideString: WideString);
    function  DataWithPdf_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property SoftwareID:       WideString  Index (IS_OPTN) read FSoftwareID write SetSoftwareID stored SoftwareID_Specified;
    property SoftwarePassword: WideString  Index (IS_OPTN) read FSoftwarePassword write SetSoftwarePassword stored SoftwarePassword_Specified;
    property UserID:           WideString  Index (IS_OPTN) read FUserID write SetUserID stored UserID_Specified;
    property Password:         WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
    property OrderReference:   WideString  Index (IS_OPTN) read FOrderReference write SetOrderReference stored OrderReference_Specified;
    property DataWithPdf:      WideString  Index (IS_OPTN) read FDataWithPdf write SetDataWithPdf stored DataWithPdf_Specified;
  end;



  // ************************************************************************ //
  // XML       : FulfillDataResponse, global, <element>
  // Namespace : http://wavesphere.net/2009/03
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  FulfillDataResponse = class(XmlResponse)
  private
  public
    constructor Create; override;
  published
  end;


  // ************************************************************************ //
  // Namespace : http://wavesphere.net/2010/03
  // soapAction: http://wavesphere.net/2009/03/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : OrderHandler
  // service   : AppraiserSoftwareIntegration
  // port      : OrderHandler
  // URL       : http://ws.beta.onpresidio.com/AppraiserSoftwareIntegration/AppraiserSoftwareIntegration.asmx
  // ************************************************************************ //
  OrderHandler = interface(IInvokable)
  ['{07433EF6-C99A-6211-27F8-D58F82F2644D}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  GetData(const request: GetDataRequest): GetDataResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  ValidateData(const request: ValidateDataRequest): ValidateDataResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  FulfillData(const request: FulfillDataRequest): FulfillDataResponse; stdcall;
  end;

function GetOrderHandler(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): OrderHandler;


implementation
  uses SysUtils;

function GetOrderHandler(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): OrderHandler;
const
  defWSDL = 'http://ws.beta.onpresidio.com/AppraiserSoftwareIntegration/AppraiserSoftwareIntegration.asmx?wsdl';
  defURL  = 'http://ws.beta.onpresidio.com/AppraiserSoftwareIntegration/AppraiserSoftwareIntegration.asmx';
  defSvc  = 'AppraiserSoftwareIntegration';
  defPrt  = 'OrderHandler';
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
    Result := (RIO as OrderHandler);
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


procedure Response.SetDescription(Index: Integer; const AWideString: WideString);
begin
  FDescription := AWideString;
  FDescription_Specified := True;
end;

function Response.Description_Specified(Index: Integer): boolean;
begin
  Result := FDescription_Specified;
end;

procedure OrderResponse.SetOrderData(Index: Integer; const AWideString: WideString);
begin
  FOrderData := AWideString;
  FOrderData_Specified := True;
end;

function OrderResponse.OrderData_Specified(Index: Integer): boolean;
begin
  Result := FOrderData_Specified;
end;

procedure XmlResponse.SetResponse(Index: Integer; const AWideString: WideString);
begin
  FResponse := AWideString;
  FResponse_Specified := True;
end;

function XmlResponse.Response_Specified(Index: Integer): boolean;
begin
  Result := FResponse_Specified;
end;

constructor GetDataRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure GetDataRequest.SetSoftwareID(Index: Integer; const AWideString: WideString);
begin
  FSoftwareID := AWideString;
  FSoftwareID_Specified := True;
end;

function GetDataRequest.SoftwareID_Specified(Index: Integer): boolean;
begin
  Result := FSoftwareID_Specified;
end;

procedure GetDataRequest.SetSoftwarePassword(Index: Integer; const AWideString: WideString);
begin
  FSoftwarePassword := AWideString;
  FSoftwarePassword_Specified := True;
end;

function GetDataRequest.SoftwarePassword_Specified(Index: Integer): boolean;
begin
  Result := FSoftwarePassword_Specified;
end;

procedure GetDataRequest.SetUserID(Index: Integer; const AWideString: WideString);
begin
  FUserID := AWideString;
  FUserID_Specified := True;
end;

function GetDataRequest.UserID_Specified(Index: Integer): boolean;
begin
  Result := FUserID_Specified;
end;

procedure GetDataRequest.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function GetDataRequest.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure GetDataRequest.SetOrderReference(Index: Integer; const AWideString: WideString);
begin
  FOrderReference := AWideString;
  FOrderReference_Specified := True;
end;

function GetDataRequest.OrderReference_Specified(Index: Integer): boolean;
begin
  Result := FOrderReference_Specified;
end;

constructor GetDataResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor ValidateDataRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure ValidateDataRequest.SetSoftwareID(Index: Integer; const AWideString: WideString);
begin
  FSoftwareID := AWideString;
  FSoftwareID_Specified := True;
end;

function ValidateDataRequest.SoftwareID_Specified(Index: Integer): boolean;
begin
  Result := FSoftwareID_Specified;
end;

procedure ValidateDataRequest.SetSoftwarePassword(Index: Integer; const AWideString: WideString);
begin
  FSoftwarePassword := AWideString;
  FSoftwarePassword_Specified := True;
end;

function ValidateDataRequest.SoftwarePassword_Specified(Index: Integer): boolean;
begin
  Result := FSoftwarePassword_Specified;
end;

procedure ValidateDataRequest.SetUserID(Index: Integer; const AWideString: WideString);
begin
  FUserID := AWideString;
  FUserID_Specified := True;
end;

function ValidateDataRequest.UserID_Specified(Index: Integer): boolean;
begin
  Result := FUserID_Specified;
end;

procedure ValidateDataRequest.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function ValidateDataRequest.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure ValidateDataRequest.SetOrderReference(Index: Integer; const AWideString: WideString);
begin
  FOrderReference := AWideString;
  FOrderReference_Specified := True;
end;

function ValidateDataRequest.OrderReference_Specified(Index: Integer): boolean;
begin
  Result := FOrderReference_Specified;
end;

procedure ValidateDataRequest.SetData(Index: Integer; const AWideString: WideString);
begin
  FData := AWideString;
  FData_Specified := True;
end;

function ValidateDataRequest.Data_Specified(Index: Integer): boolean;
begin
  Result := FData_Specified;
end;

constructor ValidateDataResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor FulfillDataRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure FulfillDataRequest.SetSoftwareID(Index: Integer; const AWideString: WideString);
begin
  FSoftwareID := AWideString;
  FSoftwareID_Specified := True;
end;

function FulfillDataRequest.SoftwareID_Specified(Index: Integer): boolean;
begin
  Result := FSoftwareID_Specified;
end;

procedure FulfillDataRequest.SetSoftwarePassword(Index: Integer; const AWideString: WideString);
begin
  FSoftwarePassword := AWideString;
  FSoftwarePassword_Specified := True;
end;

function FulfillDataRequest.SoftwarePassword_Specified(Index: Integer): boolean;
begin
  Result := FSoftwarePassword_Specified;
end;

procedure FulfillDataRequest.SetUserID(Index: Integer; const AWideString: WideString);
begin
  FUserID := AWideString;
  FUserID_Specified := True;
end;

function FulfillDataRequest.UserID_Specified(Index: Integer): boolean;
begin
  Result := FUserID_Specified;
end;

procedure FulfillDataRequest.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function FulfillDataRequest.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

procedure FulfillDataRequest.SetOrderReference(Index: Integer; const AWideString: WideString);
begin
  FOrderReference := AWideString;
  FOrderReference_Specified := True;
end;

function FulfillDataRequest.OrderReference_Specified(Index: Integer): boolean;
begin
  Result := FOrderReference_Specified;
end;

procedure FulfillDataRequest.SetDataWithPdf(Index: Integer; const AWideString: WideString);
begin
  FDataWithPdf := AWideString;
  FDataWithPdf_Specified := True;
end;

function FulfillDataRequest.DataWithPdf_Specified(Index: Integer): boolean;
begin
  Result := FDataWithPdf_Specified;
end;

constructor FulfillDataResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(OrderHandler), 'http://wavesphere.net/2010/03', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(OrderHandler), 'http://wavesphere.net/2009/03/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(OrderHandler), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(OrderHandler), ioLiteral);
  RemClassRegistry.RegisterXSClass(Response, 'http://wavesphere.net/2009/03', 'Response');
  RemClassRegistry.RegisterXSClass(OrderResponse, 'http://wavesphere.net/2009/03', 'OrderResponse');
  RemClassRegistry.RegisterXSClass(XmlResponse, 'http://wavesphere.net/2009/03', 'XmlResponse');
  RemClassRegistry.RegisterXSClass(GetDataRequest, 'http://wavesphere.net/2009/03', 'GetDataRequest');
  RemClassRegistry.RegisterSerializeOptions(GetDataRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(GetDataResponse, 'http://wavesphere.net/2009/03', 'GetDataResponse');
  RemClassRegistry.RegisterSerializeOptions(GetDataResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ValidateDataRequest, 'http://wavesphere.net/2009/03', 'ValidateDataRequest');
  RemClassRegistry.RegisterSerializeOptions(ValidateDataRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(ValidateDataResponse, 'http://wavesphere.net/2009/03', 'ValidateDataResponse');
  RemClassRegistry.RegisterSerializeOptions(ValidateDataResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(FulfillDataRequest, 'http://wavesphere.net/2009/03', 'FulfillDataRequest');
  RemClassRegistry.RegisterSerializeOptions(FulfillDataRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(FulfillDataResponse, 'http://wavesphere.net/2009/03', 'FulfillDataResponse');
  RemClassRegistry.RegisterSerializeOptions(FulfillDataResponse, [xoLiteralParam]);

end.