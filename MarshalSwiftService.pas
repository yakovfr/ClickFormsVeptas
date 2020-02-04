// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WSMarshalSwift/MarshalSwiftService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (8/11/2005 2:44:35 PM - 1.33.2.5)
// ************************************************************************ //

unit MarshalSwiftService;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : MarshalSwiftServiceSoap
  // service   : MarshalSwiftService
  // port      : MarshalSwiftServiceSoap
  // URL       : http://localhost/WSMarshalSwift/MarshalSwiftService.asmx
  // ************************************************************************ //
  MarshalSwiftServiceSoap = interface(IInvokable)
  ['{9C19E50F-C082-0F01-555D-377513D688D0}']
    procedure logTransaction(const iCustomerID: Integer; const sPassword: WideString;
    const iServerUsed: Integer; const sPropAddress: WideString; const iTransStatus: Integer;
    out logTransactionResult: Boolean; out sMsgs: WideString; out iMsgsCode: Integer); stdcall;

    procedure getSecurityTokenForNew(const iCustomerID: Integer; const sPassword: WideString;
    const sEstimateDesc: WideString; const sStreet: WideString; const sCity: WideString;
    const sState: WideString; const sZip: WideString;
    out getSecurityTokenForNewResult: WideString; out iServerUsed: Integer;
    out sMsgs: WideString; out iEstimateID: Integer; out iMsgsCode: Integer); stdcall;

    procedure getSecurityTokenForExisting(const iCustomerID: Integer; const sPassword: WideString;
    const iEstimateID: Integer;
    out getSecurityTokenForExistingResult: WideString; out iServerUsed: Integer;
    out sMsgs: WideString; out iMsgsCode: Integer); stdcall;

    function  GetRegionFromZip(const sZipCode: WideString): WideString; stdcall;
  end;

function GetMarshalSwiftServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MarshalSwiftServiceSoap;


implementation

function GetMarshalSwiftServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MarshalSwiftServiceSoap;
const
  defWSDL = 'http://localhost/WSMarshalSwift/MarshalSwiftService.asmx?wsdl';
  defURL  = 'http://localhost/WSMarshalSwift/MarshalSwiftService.asmx';
  defSvc  = 'MarshalSwiftService';
  defPrt  = 'MarshalSwiftServiceSoap';
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
    Result := (RIO as MarshalSwiftServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(MarshalSwiftServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MarshalSwiftServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MarshalSwiftServiceSoap), ioDocument);

end. 