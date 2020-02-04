// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://webservices.bradfordsoftware.com/WSEMail/EmailService.asmx?WSDL
// Encoding : utf-8
// Version  : 1.0
// (12/27/2004 10:11:30 AM - 1.33.2.5)
// ************************************************************************ //

unit EmailService;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/SendMessage
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : EmailServiceSoap
  // service   : EmailService
  // port      : EmailServiceSoap
  // URL       : http://webservices.bradfordsoftware.com/WSEMail/EmailService.asmx
  // ************************************************************************ //
  EmailServiceSoap = interface(IInvokable)
  ['{BA7C9A05-B298-3F26-318B-31E65F4A3754}']
    function  SendMessage(const iCustID: Integer; const sPassword: WideString; const sMsg: WideString; const iMsgType: Integer): WideString; stdcall;
  end;

function GetEmailServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): EmailServiceSoap;


implementation

function GetEmailServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): EmailServiceSoap;
const
  defWSDL = 'http://webservices.bradfordsoftware.com/WSEMail/EmailService.asmx?WSDL';
  defURL  = 'http://webservices.bradfordsoftware.com/WSEMail/EmailService.asmx';
  defSvc  = 'EmailService';
  defPrt  = 'EmailServiceSoap';
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
    Result := (RIO as EmailServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(EmailServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(EmailServiceSoap), 'http://tempuri.org/SendMessage');
  InvRegistry.RegisterInvokeOptions(TypeInfo(EmailServiceSoap), ioDocument);

end. 