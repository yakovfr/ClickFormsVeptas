// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/AreaSketchServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (8/23/2013 12:52:34 PM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_AreaSketch;

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

  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL" }
  clsTrialCustomer     = class;                 { "http://carme/secure/ws/WSDL" }
  clsResults           = class;                 { "http://carme/secure/ws/WSDL" }
  clsEvaluateAreaSketchResponse = class;        { "http://carme/secure/ws/WSDL" }
  clsRegisterAreaSketchResponse = class;        { "http://carme/secure/ws/WSDL" }
  clsRegisterAreaSketchRequest = class;         { "http://carme/secure/ws/WSDL" }



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FAccessId: WideString;
  published
    property Username: WideString read FUsername write FUsername;
    property Password: WideString read FPassword write FPassword;
    property AccessId: WideString read FAccessId write FAccessId;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsTrialCustomer = class(TRemotable)
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
    FIsPPC: Integer;
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
    property IsPPC: Integer read FIsPPC write FIsPPC;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code: Integer read FCode write FCode;
    property Type_: WideString read FType_ write FType_;
    property Description: WideString read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsEvaluateAreaSketchResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: WideString;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: WideString read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsRegisterAreaSketchResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: WideString;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: WideString read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsRegisterAreaSketchRequest = class(TRemotable)
  private
    FDeviceID: WideString;
    FIsPPC: Integer;
  published
    property DeviceID: WideString read FDeviceID write FDeviceID;
    property IsPPC: Integer read FIsPPC write FIsPPC;
  end;


  // ************************************************************************ //
  // Namespace : AreaSketchServerClass
  // soapAction: AreaSketchServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : AreaSketchServerBinding
  // service   : AreaSketchServer
  // port      : AreaSketchServerPort
  // URL       : http://carme/secure/ws/awsi/AreaSketchServer.php
  // ************************************************************************ //
  AreaSketchServerPortType = interface(IInvokable)
  ['{8ADC448A-C58F-6A0C-F096-08BCE71C429D}']
    function  AreaSketchServices_EvaluateAreaSketch(const UserCredentials: clsUserCredentials; const TrialCustRec: clsTrialCustomer): clsEvaluateAreaSketchResponse; stdcall;
    function  AreaSketchServices_RegisterAreaSketch(const UserCredentials: clsUserCredentials; const RequestDetails: clsRegisterAreaSketchRequest): clsRegisterAreaSketchResponse; stdcall;
  end;

function GetAreaSketchServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AreaSketchServerPortType;


implementation

function GetAreaSketchServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AreaSketchServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/AreaSketchServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/AreaSketchServer.php';
  defSvc  = 'AreaSketchServer';
  defPrt  = 'AreaSketchServerPort';
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
    Result := (RIO as AreaSketchServerPortType);
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


destructor clsEvaluateAreaSketchResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  inherited Destroy;
end;

destructor clsRegisterAreaSketchResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(AreaSketchServerPortType), 'AreaSketchServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AreaSketchServerPortType), 'AreaSketchServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(AreaSketchServerPortType), 'AreaSketchServices_EvaluateAreaSketch', 'AreaSketchServices.EvaluateAreaSketch');
  InvRegistry.RegisterExternalMethName(TypeInfo(AreaSketchServerPortType), 'AreaSketchServices_RegisterAreaSketch', 'AreaSketchServices.RegisterAreaSketch');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsTrialCustomer, 'http://carme/secure/ws/WSDL', 'clsTrialCustomer');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsEvaluateAreaSketchResponse, 'http://carme/secure/ws/WSDL', 'clsEvaluateAreaSketchResponse');
  RemClassRegistry.RegisterXSClass(clsRegisterAreaSketchResponse, 'http://carme/secure/ws/WSDL', 'clsRegisterAreaSketchResponse');
  RemClassRegistry.RegisterXSClass(clsRegisterAreaSketchRequest, 'http://carme/secure/ws/WSDL', 'clsRegisterAreaSketchRequest');

end.