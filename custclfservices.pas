// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/wsclfcustservices/custclfservices.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (02/06/2009 3:45:24 PM - 1.33.2.5)
// ************************************************************************ //

unit custclfservices;

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

  serviceInfo          = class;                 { "http://tempuri.org/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  serviceInfo = class(TRemotable)
  private
    FservID: Integer;
    FservName: WideString;
    Fstatus: Integer;
    FassignedTo: Integer;
    FexpDate: WideString;
    FunitsLeft: Integer;
  published
    property servID: Integer read FservID write FservID;
    property servName: WideString read FservName write FservName;
    property status: Integer read Fstatus write Fstatus;
    property assignedTo: Integer read FassignedTo write FassignedTo;
    property expDate: WideString read FexpDate write FexpDate;
    property unitsLeft: Integer read FunitsLeft write FunitsLeft;
  end;

  ArrayOfServiceInfo = array of serviceInfo;    { "http://tempuri.org/" }

  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : CustClfServicesSoap
  // service   : CustClfServices
  // port      : CustClfServicesSoap
  // URL       : http://localhost/wsclfcustservices/custclfservices.asmx
  // ************************************************************************ //
  CustClfServicesSoap = interface(IInvokable)
  ['{69EF79EF-D634-755F-231B-8EBDE8EAB779}']
    function  GetClfCustServices(const custID: Integer): ArrayOfServiceInfo; stdcall;
    function  GetServiceList: ArrayOfServiceInfo; stdcall;
  end;

function GetCustClfServicesSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CustClfServicesSoap;


implementation

function GetCustClfServicesSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CustClfServicesSoap;
const
  defWSDL = 'http://localhost/wsclfcustservices/custclfservices.asmx?wsdl';
  defURL  = 'http://localhost/wsclfcustservices/custclfservices.asmx';
  defSvc  = 'CustClfServices';
  defPrt  = 'CustClfServicesSoap';
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
    Result := (RIO as CustClfServicesSoap);
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
  InvRegistry.RegisterInterface(TypeInfo(CustClfServicesSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CustClfServicesSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CustClfServicesSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(serviceInfo, 'http://tempuri.org/', 'serviceInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfServiceInfo), 'http://tempuri.org/', 'ArrayOfServiceInfo');

end. 