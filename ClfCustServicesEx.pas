// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WSClfCustServicesEx/ClfCustServicesEx.asmx?wsdl
//  >Import : http://localhost/WSClfCustServicesEx/ClfCustServicesEx.asmx?wsdl:0
// Encoding : utf-8
// Version  : 1.0
// (08/12/2011 1:03:57 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit ClfCustServicesEx;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  serviceInfo          = class;                 { "http://tempuri.org/"[GblCplx] }

  ArrayOfServiceInfo = array of serviceInfo;    { "http://tempuri.org/"[GblCplx] }


  // ************************************************************************ //
  // XML       : serviceInfo, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  serviceInfo = class(TRemotable)
  private
    FservID: Integer;
    FservName: WideString;
    FservName_Specified: boolean;
    FservType: Integer;
    Fstatus: Integer;
    FassignedTo: Integer;
    FexpDate: WideString;
    FexpDate_Specified: boolean;
    FunitsLeft: Integer;
    procedure SetservName(Index: Integer; const AWideString: WideString);
    function  servName_Specified(Index: Integer): boolean;
    procedure SetexpDate(Index: Integer; const AWideString: WideString);
    function  expDate_Specified(Index: Integer): boolean;
  published
    property servID:     Integer     read FservID write FservID;
    property servName:   WideString  Index (IS_OPTN) read FservName write SetservName stored servName_Specified;
    property servType:   Integer     read FservType write FservType;
    property status:     Integer     read Fstatus write Fstatus;
    property assignedTo: Integer     read FassignedTo write FassignedTo;
    property expDate:    WideString  Index (IS_OPTN) read FexpDate write SetexpDate stored expDate_Specified;
    property unitsLeft:  Integer     read FunitsLeft write FunitsLeft;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ClfCustServicesExSoap
  // service   : ClfCustServicesEx
  // port      : ClfCustServicesExSoap
  // URL       : http://localhost/WSClfCustServicesEx/ClfCustServicesEx.asmx
  // ************************************************************************ //
  ClfCustServicesExSoap = interface(IInvokable)
  ['{5E968F6D-CD81-EC8E-DEB6-A69626FF3BF0}']
    function  GetClfCustServices(const servicePin: WideString; const custID: Integer): ArrayOfServiceInfo; stdcall;
    function  GetServiceList(const servicePin: WideString): ArrayOfServiceInfo; stdcall;
    procedure AddServiceUsage(const servicePin: WideString; const iCustID: Integer; const iServiceID: Integer; const iServerUsed: Integer; const sSearchCriteria: WideString); stdcall;
  end;

function GetClfCustServicesExSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ClfCustServicesExSoap;


implementation
  uses SysUtils;

function GetClfCustServicesExSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ClfCustServicesExSoap;
const
  defWSDL = 'http://localhost/WSClfCustServicesEx/ClfCustServicesEx.asmx?wsdl';
  defURL  = 'http://localhost/WSClfCustServicesEx/ClfCustServicesEx.asmx';
  defSvc  = 'ClfCustServicesEx';
  defPrt  = 'ClfCustServicesExSoap';
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
    Result := (RIO as ClfCustServicesExSoap);
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


procedure serviceInfo.SetservName(Index: Integer; const AWideString: WideString);
begin
  FservName := AWideString;
  FservName_Specified := True;
end;

function serviceInfo.servName_Specified(Index: Integer): boolean;
begin
  Result := FservName_Specified;
end;

procedure serviceInfo.SetexpDate(Index: Integer; const AWideString: WideString);
begin
  FexpDate := AWideString;
  FexpDate_Specified := True;
end;

function serviceInfo.expDate_Specified(Index: Integer): boolean;
begin
  Result := FexpDate_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(ClfCustServicesExSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ClfCustServicesExSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ClfCustServicesExSoap), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfServiceInfo), 'http://tempuri.org/', 'ArrayOfServiceInfo');
  RemClassRegistry.RegisterXSClass(serviceInfo, 'http://tempuri.org/', 'serviceInfo');

end.