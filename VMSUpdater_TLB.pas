// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx?WSDL
//  >Import : https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (08/23/2011 3:23:51 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit VMSUpdater_TLB;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://pcvmurcor.com/VMSUpdater
  // soapAction: http://pcvmurcor.com/VMSUpdater/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : VMSUpdaterSoap
  // service   : VMSUpdater
  // port      : VMSUpdaterSoap
  // URL       : https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx
  // ************************************************************************ //
  VMSUpdaterSoap = interface(IInvokable)
  ['{E2B2B81B-4C7A-15EC-5FAC-3A2F9051ACB2}']
    function  UpdateVMS(const xmlRequest: WideString): WideString; stdcall;
    function  getPDFPageCount(const strFilePath: WideString): Integer; stdcall;
  end;

function GetVMSUpdaterSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): VMSUpdaterSoap;


implementation
  uses SysUtils;

function GetVMSUpdaterSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): VMSUpdaterSoap;
const
  defWSDL = 'https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx?WSDL';
  defURL  = 'https://vmstest.pcvmurcor.com/webservices/VMSUpdater/VMSUpdater.asmx';
  defSvc  = 'VMSUpdater';
  defPrt  = 'VMSUpdaterSoap';
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
    Result := (RIO as VMSUpdaterSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(VMSUpdaterSoap), 'http://pcvmurcor.com/VMSUpdater', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(VMSUpdaterSoap), 'http://pcvmurcor.com/VMSUpdater/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(VMSUpdaterSoap), ioDocument);

end.