// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.0.0.39/WSBingauthorization/bingauthorization.asmx?WSDL
//  >Import : http://10.0.0.39/WSBingauthorization/bingauthorization.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (2/9/2012 10:28:29 AM - - $Rev: 10138 $)
// ************************************************************************ //

unit UServer_BingAuthorization;

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



  // ************************************************************************ //
  // Namespace : http://bradfordsoftware.com/
  // soapAction: http://bradfordsoftware.com/GetBingAuthorizationKey
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : BingAuthorizationSoap
  // service   : BingAuthorization
  // port      : BingAuthorizationSoap
  // URL       : http://10.0.0.39/WSBingauthorization/bingauthorization.asmx
  // ************************************************************************ //
  BingAuthorizationSoap = interface(IInvokable)
  ['{DFA019F3-1C50-2459-0F02-C85E80033E84}']
    function  GetBingAuthorizationKey(const servAuthKey: WideString; const subscriberID: WideString): WideString; stdcall;
  end;

function GetBingAuthorizationSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): BingAuthorizationSoap;


implementation
  uses SysUtils;

function GetBingAuthorizationSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): BingAuthorizationSoap;
const
  defWSDL = 'http://10.0.0.39/WSBingauthorization/bingauthorization.asmx?WSDL';
  defURL  = 'http://10.0.0.39/WSBingauthorization/bingauthorization.asmx';
  defSvc  = 'BingAuthorization';
  defPrt  = 'BingAuthorizationSoap';
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
    Result := (RIO as BingAuthorizationSoap);
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


initialization
  InvRegistry.RegisterInterface(TypeInfo(BingAuthorizationSoap), 'http://bradfordsoftware.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(BingAuthorizationSoap), 'http://bradfordsoftware.com/GetBingAuthorizationKey');
  InvRegistry.RegisterInvokeOptions(TypeInfo(BingAuthorizationSoap), ioDocument);

end.