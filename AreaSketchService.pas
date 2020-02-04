// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WSAreaSketch/AreaSketchService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (9/12/2005 1:43:30 PM - 1.33.2.5)
// ************************************************************************ //

unit AreaSketchService;

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

  TrialCustomer        = class;                 { "http://tempuri.org/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  TrialCustomer = class(TRemotable)
  private
    FFName: WideString;
    FLName: WideString;
    FCompanyName: WideString;
    FStreet: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FEmail: WideString;
    FPhone: WideString;
    FDeviceID: WideString;
  published
    property FName: WideString read FFName write FFName;
    property LName: WideString read FLName write FLName;
    property CompanyName: WideString read FCompanyName write FCompanyName;
    property Street: WideString read FStreet write FStreet;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property Email: WideString read FEmail write FEmail;
    property Phone: WideString read FPhone write FPhone;
    property DeviceID: WideString read FDeviceID write FDeviceID;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : AreaSketchServiceSoap
  // service   : AreaSketchService
  // port      : AreaSketchServiceSoap
  // URL       : http://localhost/WSAreaSketch/AreaSketchService.asmx
  // ************************************************************************ //
  AreaSketchServiceSoap = interface(IInvokable)
  ['{4CF6A4EF-5B51-0316-7268-CD38AC1BF74D}']
    procedure EvaluateAreaSketch(const TrialCustRec: TrialCustomer; const iIsPPC: Integer; const sPassword: WideString; out EvaluateAreaSketchResult: WideString; out iMsgCode: Integer; out sMsgs: WideString); stdcall;
    procedure RegisterAreaSketch(const sPass: WideString; const iCustID: Integer; const sDeviceID: WideString; const iIsPPC: Integer; out RegisterAreaSketchResult: WideString; out iMsgCode: Integer; out sMsgs: WideString); stdcall;
  end;

function GetAreaSketchServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AreaSketchServiceSoap;


implementation

function GetAreaSketchServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AreaSketchServiceSoap;
const
  defWSDL = 'http://localhost/WSAreaSketch/AreaSketchService.asmx?wsdl';
  defURL  = 'http://localhost/WSAreaSketch/AreaSketchService.asmx';
  defSvc  = 'AreaSketchService';
  defPrt  = 'AreaSketchServiceSoap';
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
    Result := (RIO as AreaSketchServiceSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(AreaSketchServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AreaSketchServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AreaSketchServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(TrialCustomer, 'http://tempuri.org/', 'TrialCustomer');

end. 