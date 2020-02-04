// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://dev.kyliptix.com/ucrm/soap/WebOrder?WSDL
//  >Import : http://dev.kyliptix.com/ucrm/soap/WebOrder?WSDL:0
// Encoding : UTF-8
// Version  : 1.0
// (08/22/2011 9:06:20 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit AMC_Kyliptix_TLB;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  WebOrderResponse     = class;                 { "http://dev.kyliptix.com/ucrm/soap?WSDL/"[GblCplx] }



  // ************************************************************************ //
  // XML       : WebOrderResponse, global, <complexType>
  // Namespace : http://dev.kyliptix.com/ucrm/soap?WSDL/
  // ************************************************************************ //
  WebOrderResponse = class(TRemotable)
  private
    FstatusCode: WideString;
    Fstatus: WideString;
    Fdetail: WideString;
    FfileId: Integer;
  published
    property statusCode: WideString  read FstatusCode write FstatusCode;
    property status:     WideString  read Fstatus write Fstatus;
    property detail:     WideString  read Fdetail write Fdetail;
    property fileId:     Integer     read FfileId write FfileId;
  end;

  ArrayOfstring = array of WideString;          { "http://dev.kyliptix.com/ucrm/soap?WSDL/"[GblCplx] }

  // ************************************************************************ //
  // Namespace : http://dev.kyliptix.com/ucrm/soap?WSDL/
  // soapAction: urn:WebOrder#WebOrderServer#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : WebOrderBinding
  // service   : WebOrderService
  // port      : WebOrderPort
  // URL       : http://dev.kyliptix.com/ucrm/soap?WSDL/WebOrder
  // ************************************************************************ //
  WebOrderPortType = interface(IInvokable)
  ['{79D00448-62E0-87EF-E67B-3F139D1E3D10}']
    function  post(const username: WideString; const password: WideString; const orderXML: WideString): WebOrderResponse; stdcall;
    function  login(const email: WideString; const password: WideString): WideString; stdcall;
    function  searchUser(const email: WideString): WideString; stdcall;
    function  listUser: ArrayOfstring; stdcall;
  end;

function GetWebOrderPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): WebOrderPortType;


implementation
  uses SysUtils, UGlobals, UDebugTools;

function GetWebOrderPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): WebOrderPortType;
const
  defWSDL = 'http://dev.kyliptix.com/ucrm/soap/WebOrder?WSDL';
  defURL  = 'http://dev.kyliptix.com/ucrm/soap/WebOrder.php';
  defSvc  = 'WebOrderService';
  defPrt  = 'WebOrderPort';
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
    Result := (RIO as WebOrderPortType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
    if debugMode then        //turn on Soap debugging in UDebugTools
      TDebugTools.Debugger.DebugSOAPService(RIO);
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(WebOrderPortType), 'http://dev.kyliptix.com/ucrm/soap?WSDL/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WebOrderPortType), 'urn:WebOrder#WebOrderServer#%operationName%');
  RemClassRegistry.RegisterXSClass(WebOrderResponse, 'http://dev.kyliptix.com/ucrm/soap?WSDL/', 'WebOrderResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfstring), 'http://dev.kyliptix.com/ucrm/soap?WSDL/', 'ArrayOfstring');

end.