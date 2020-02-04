// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (12/27/2004 10:10:16 AM - 1.33.2.5)
// ************************************************************************ //

unit messagingservice;

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
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"

  ServiceStatus        = class;                 { "http://tempuri.org/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ServiceStatus = class(TRemotable)
  private
    FServiceName: WideString;
    FCurrentStatus: WideString;
    FExpiresOn: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property ServiceName: WideString read FServiceName write FServiceName;
    property CurrentStatus: WideString read FCurrentStatus write FCurrentStatus;
    property ExpiresOn: TXSDateTime read FExpiresOn write FExpiresOn;
  end;

  ArrayOfServiceStatus = array of ServiceStatus;   { "http://tempuri.org/" }

  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : MessagingServiceSoap
  // service   : MessagingService
  // port      : MessagingServiceSoap
  // URL       : http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx
  // ************************************************************************ //
  MessagingServiceSoap = interface(IInvokable)
  ['{970B17F1-9826-34E5-AEBA-9DBFC2BB0A44}']
    procedure getServiceStatusSummary(const iCustID: Integer; const sPassword: WideString; out getServiceStatusSummaryResult: ArrayOfServiceStatus; out sMsgs: WideString); stdcall;
    procedure getServiceStatus(const iCustID: Integer; const iServiceID: Integer; const sPassword: WideString; out getServiceStatusResult: ServiceStatus; out sMsgs: WideString); stdcall;
  end;

function GetMessagingServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MessagingServiceSoap;


implementation

function GetMessagingServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MessagingServiceSoap;
const
  defWSDL = 'http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx?wsdl';
  defURL  = 'http://webservices.bradfordsoftware.com/wsmessages/messagingservice.asmx';
  defSvc  = 'MessagingService';
  defPrt  = 'MessagingServiceSoap';
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
    Result := (RIO as MessagingServiceSoap);
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


destructor ServiceStatus.Destroy;
begin
  if Assigned(FExpiresOn) then
    FExpiresOn.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MessagingServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MessagingServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MessagingServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(ServiceStatus, 'http://tempuri.org/', 'ServiceStatus');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfServiceStatus), 'http://tempuri.org/', 'ArrayOfServiceStatus');

end. 