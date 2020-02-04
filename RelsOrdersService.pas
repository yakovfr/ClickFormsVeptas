// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://devws1/WSRelsOrders/RelsOrdersService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (2/4/2008 12:32:49 PM - 1.33.2.5)
// ************************************************************************ //

unit RelsOrdersService;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : RelsOrdersServiceSoap
  // service   : RelsOrdersService
  // port      : RelsOrdersServiceSoap
  // URL       : http://devws1/WSRelsOrders/RelsOrdersService.asmx
  // ************************************************************************ //
  RelsOrdersServiceSoap = interface(IInvokable)
  ['{5C640006-C773-9976-C90D-6B4E5C771F22}']
    procedure GetRELSOrder(const baseUrl: WideString; const orderNumber: Integer; const vendorID: WideString; const vendorPassword: WideString; const userID: WideString; const userPassword: WideString; out GetRELSOrderResult: WideString; out relsSuccess: Boolean; out relsErrorMessage: WideString; out relsErrorKind: WideString
                           ); stdcall;
    procedure GetRELSData(const baseUrl: WideString; const orderNumber: Integer; const declined: Boolean; const vendorID: WideString; const vendorPassword: WideString; const userID: WideString; const userPassword: WideString; out GetRELSDataResult: WideString; out relsSuccess: Boolean; out relsErrorMessage: WideString;
                          out relsErrorKind: WideString); stdcall;
    procedure GetRELSValidation(const baseUrl: WideString; const orderNumber: Integer; const xmlData: WideString; const vendorID: WideString; const vendorPassword: WideString; const userID: WideString; const userPassword: WideString; out GetRELSValidationResult: WideString; out relsSuccess: Boolean; out relsErrorMessage: WideString;
                                out relsErrorKind: WideString); stdcall;
    procedure SubmitRELSReport(const baseUrl: WideString; const orderNumber: Integer; const xmlData: WideString; const vendorID: WideString; const vendorPassword: WideString; const userID: WideString; const userPassword: WideString; out SubmitRELSReportResult: WideString; out relsSuccess: Boolean; out relsErrorMessage: WideString; 
                               out relsErrorKind: WideString); stdcall;
  end;

function GetRelsOrdersServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RelsOrdersServiceSoap;


implementation

function GetRelsOrdersServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RelsOrdersServiceSoap;
const
  defWSDL = 'http://devws1/WSRelsOrders/RelsOrdersService.asmx?wsdl';
  defURL  = 'http://devws1/WSRelsOrders/RelsOrdersService.asmx';
  defSvc  = 'RelsOrdersService';
  defPrt  = 'RelsOrdersServiceSoap';
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
    Result := (RIO as RelsOrdersServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(RelsOrdersServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RelsOrdersServiceSoap), 'http://tempuri.org/%operationName%');

end. 