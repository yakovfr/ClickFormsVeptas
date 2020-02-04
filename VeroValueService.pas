// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://webservices.bradfordsoftware.com/WSVeroValue/VeroValueService.asmx?WSDL
// Encoding : utf-8
// Version  : 1.0
// (12/27/2004 10:11:07 AM - 1.33.2.5)
// ************************************************************************ //

unit VeroValueService;

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
  // soapAction: http://tempuri.org/GetPropertyValuation
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : VeroValueServiceSoap
  // service   : VeroValueService
  // port      : VeroValueServiceSoap
  // URL       : http://webservices.bradfordsoftware.com/WSVeroValue/VeroValueService.asmx
  // ************************************************************************ //
  VeroValueServiceSoap = interface(IInvokable)
  ['{DED3CAC3-53B7-C1EA-8E85-4E9805D62D4A}']
    function  GetPropertyValuation(const iCustID: Integer; const sPassword: WideString; const vvi_address: WideString; const vvi_city: WideString; const vvi_state: WideString; const vvi_zip: WideString; const vvi_apn: WideString; const vvi_owner_first: WideString; const vvi_owner_last: WideString; const vvi_known_sale_price: WideString;
                                   const vvi_known_sale_date: WideString; const vvi_borrowers_name: WideString; const vvi_refno: WideString): WideString; stdcall;
  end;

function GetVeroValueServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): VeroValueServiceSoap;


implementation

function GetVeroValueServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): VeroValueServiceSoap;
const
  defWSDL = 'http://webservices.bradfordsoftware.com/WSVeroValue/VeroValueService.asmx?WSDL';
  defURL  = 'http://webservices.bradfordsoftware.com/WSVeroValue/VeroValueService.asmx';
  defSvc  = 'VeroValueService';
  defPrt  = 'VeroValueServiceSoap';
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
    Result := (RIO as VeroValueServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(VeroValueServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(VeroValueServiceSoap), 'http://tempuri.org/GetPropertyValuation');
  InvRegistry.RegisterInvokeOptions(TypeInfo(VeroValueServiceSoap), ioDocument);

end. 