// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.0.0.7/WSRegistration/RegistrationService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (4/18/2007 9:16:56 AM - 1.33.2.5)
// ************************************************************************ //

unit RegistrationService;

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
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"

  StudentRequest       = class;                 { "http://tempuri.org/" }
  Service              = class;                 { "http://tempuri.org/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  StudentRequest = class(TRemotable)
  private
    FFirstName: WideString;
    FLastName: WideString;
    FStreet: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FCountry: WideString;
    FEmail: WideString;
    FPhone: WideString;
    FPhoneExt: WideString;
    FMachineID: Integer;
  published
    property FirstName: WideString read FFirstName write FFirstName;
    property LastName: WideString read FLastName write FLastName;
    property Street: WideString read FStreet write FStreet;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property Country: WideString read FCountry write FCountry;
    property Email: WideString read FEmail write FEmail;
    property Phone: WideString read FPhone write FPhone;
    property PhoneExt: WideString read FPhoneExt write FPhoneExt;
    property MachineID: Integer read FMachineID write FMachineID;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  Service = class(TRemotable)
  private
    FServiceID: Integer;
    FServiceStartsOn: TXSDateTime;
    FServiceExpiresOn: TXSDateTime;
  public
    destructor Destroy; override;
  published
    property ServiceID: Integer read FServiceID write FServiceID;
    property ServiceStartsOn: TXSDateTime read FServiceStartsOn write FServiceStartsOn;
    property ServiceExpiresOn: TXSDateTime read FServiceExpiresOn write FServiceExpiresOn;
  end;

  ArrayOfService = array of Service;            { "http://tempuri.org/" }

  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RegistrationServiceSoap
  // service   : RegistrationService
  // port      : RegistrationServiceSoap
  // URL       : http://10.0.0.7/WSRegistration/RegistrationService.asmx
  // ************************************************************************ //
  RegistrationServiceSoap = interface(IInvokable)
  ['{489E82E2-0BFE-D8B9-B79D-6C0FFD36DE45}']
    function  RequestActivationCode(const StudentRec: StudentRequest; const sKey: WideString): Integer; stdcall;
    procedure ValidateActivationCode(const StudentRec: StudentRequest; const sActivationCode: WideString; const sKey: WideString; out ValidateActivationCodeResult: Integer; out sCustSN: WideString; out dtExpires: TXSDateTime; out dtToday: TXSDateTime
                                     ); stdcall;
    procedure IsClickFormSubscriptionValid(const ipCustomerID: Integer; const sKey: WideString; out IsClickFormSubscriptionValidResult: Integer; out dateUpdated: TXSDateTime); stdcall;
    procedure UpdateSubscription(const iCustID: Integer; const sKey: WideString; out UpdateSubscriptionResult: ArrayOfService; out iMsgCode: Integer; out dtToday: TXSDateTime); stdcall;
  end;

function GetRegistrationServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RegistrationServiceSoap;


implementation

function GetRegistrationServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RegistrationServiceSoap;
const
  defWSDL = 'http://10.0.0.7/WSRegistration/RegistrationService.asmx?wsdl';
  defURL  = 'http://10.0.0.7/WSRegistration/RegistrationService.asmx';
  defSvc  = 'RegistrationService';
  defPrt  = 'RegistrationServiceSoap';
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
    Result := (RIO as RegistrationServiceSoap);
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


destructor Service.Destroy;
begin
  if Assigned(FServiceStartsOn) then
    FServiceStartsOn.Free;
  if Assigned(FServiceExpiresOn) then
    FServiceExpiresOn.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(RegistrationServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RegistrationServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RegistrationServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(StudentRequest, 'http://tempuri.org/', 'StudentRequest');
  RemClassRegistry.RegisterXSClass(Service, 'http://tempuri.org/', 'Service');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfService), 'http://tempuri.org/', 'ArrayOfService');

end. 