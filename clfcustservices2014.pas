// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx?WSDL
//  >Import : http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (6/4/2014 1:49:21 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit clfcustservices2014;

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
  // binding   : ClfCustServices2014Soap
  // service   : ClfCustServices2014
  // port      : ClfCustServices2014Soap
  // URL       : http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx
  // ************************************************************************ //
  ClfCustServices2014Soap = interface(IInvokable)
  ['{95A779E3-5462-1898-08E3-1DC5018279C1}']
    function  GetClfCustServices(const servicePin: WideString; const custID: Integer): ArrayOfServiceInfo; stdcall;
    function  GetServiceList(const servicePin: WideString): ArrayOfServiceInfo; stdcall;
    procedure AddServiceUsage(const servicePin: WideString; const iCustID: Integer; const iServiceID: Integer; const iServerUsed: Integer; const sSearchCriteria: WideString); stdcall;
  end;

function GetClfCustServices2014Soap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ClfCustServices2014Soap;


implementation
  uses SysUtils;

function GetClfCustServices2014Soap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ClfCustServices2014Soap;
const
  defWSDL = 'http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx?WSDL';
  defURL  = 'http://10.0.0.39/wsclfcustservices2014/clfcustservices2014.asmx';
  defSvc  = 'ClfCustServices2014';
  defPrt  = 'ClfCustServices2014Soap';
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
    Result := (RIO as ClfCustServices2014Soap);
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
  InvRegistry.RegisterInterface(TypeInfo(ClfCustServices2014Soap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ClfCustServices2014Soap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ClfCustServices2014Soap), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfServiceInfo), 'http://tempuri.org/', 'ArrayOfServiceInfo');
  RemClassRegistry.RegisterXSClass(serviceInfo, 'http://tempuri.org/', 'serviceInfo');

end.