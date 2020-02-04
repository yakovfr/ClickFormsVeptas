// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/PhoenixMobileServer.php?wsdl
//  >Import : http://carme/secure/ws/awsi/PhoenixMobileServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (5/21/2012 1:08:03 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit PhoenixMobileServer;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsPhoenixMobileUserCredentials = class;      { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponse = class;           { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponseData = class;       { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAuthorizeUsageResponse = class;            { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPhoenixMobileAuthorizeUsageData = class;   { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPhoenixMobileAcknowledgement = class;      { "http://carme/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsPhoenixMobileUserCredentials, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPhoenixMobileUserCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FPassword: WideString;
  published
    property CustomerId: Integer     read FCustomerId write FCustomerId;
    property Password:   WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsResults = class(TRemotable)
  private
    FCode: Integer;
    FType_: WideString;
    FDescription: WideString;
  published
    property Code:        Integer     read FCode write FCode;
    property Type_:       WideString  read FType_ write FType_;
    property Description: WideString  read FDescription write FDescription;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponseData, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer  read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // XML       : clsAuthorizeUsageResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAuthorizeUsageResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsPhoenixMobileAuthorizeUsageData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                          read FResults write FResults;
    property ResponseData: clsPhoenixMobileAuthorizeUsageData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsPhoenixMobileAuthorizeUsageData, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPhoenixMobileAuthorizeUsageData = class(TRemotable)
  private
    FAuthorized: Integer;
    FQuantityAvailable: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Authorized:             Integer     read FAuthorized write FAuthorized;
    property QuantityAvailable:      Integer     read FQuantityAvailable write FQuantityAvailable;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsPhoenixMobileAcknowledgement, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPhoenixMobileAcknowledgement = class(TRemotable)
  private
    FQuantity: Integer;
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Quantity:               Integer     read FQuantity write FQuantity;
    property Received:               Integer     read FReceived write FReceived;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;


  // ************************************************************************ //
  // Namespace : PhoenixMobileServerClass
  // soapAction: PhoenixMobileServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : PhoenixMobileServerBinding
  // service   : PhoenixMobileServer
  // port      : PhoenixMobileServerPort
  // URL       : http://carme/secure/ws/awsi/PhoenixMobileServer.php
  // ************************************************************************ //
  PhoenixMobileServerPortType = interface(IInvokable)
  ['{F7C36104-BF94-0EE5-AE71-80F5EA8710EA}']
    function  PhoenixMobileService_AuthorizeUsage(const PhoenixMobileUserCredentials: clsPhoenixMobileUserCredentials): clsAuthorizeUsageResponse; stdcall;
    function  PhoenixMobileService_Acknowledgement(const PhoenixMobileUserCredentials: clsPhoenixMobileUserCredentials; const PhoenixMobileAcknowledgement: clsPhoenixMobileAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetPhoenixMobileServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PhoenixMobileServerPortType;


implementation
  uses SysUtils;

function GetPhoenixMobileServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PhoenixMobileServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/PhoenixMobileServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/PhoenixMobileServer.php';
  defSvc  = 'PhoenixMobileServer';
  defPrt  = 'PhoenixMobileServerPort';

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
    Result := (RIO as PhoenixMobileServerPortType);
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


destructor clsAcknowledgementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsAuthorizeUsageResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PhoenixMobileServerPortType), 'PhoenixMobileServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PhoenixMobileServerPortType), 'PhoenixMobileServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(PhoenixMobileServerPortType), 'PhoenixMobileService_AuthorizeUsage', 'PhoenixMobileService.AuthorizeUsage');
  InvRegistry.RegisterExternalMethName(TypeInfo(PhoenixMobileServerPortType), 'PhoenixMobileService_Acknowledgement', 'PhoenixMobileService.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsPhoenixMobileUserCredentials, 'http://carme/secure/ws/WSDL', 'clsPhoenixMobileUserCredentials');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAuthorizeUsageResponse, 'http://carme/secure/ws/WSDL', 'clsAuthorizeUsageResponse');
  RemClassRegistry.RegisterXSClass(clsPhoenixMobileAuthorizeUsageData, 'http://carme/secure/ws/WSDL', 'clsPhoenixMobileAuthorizeUsageData');
  RemClassRegistry.RegisterXSClass(clsPhoenixMobileAcknowledgement, 'http://carme/secure/ws/WSDL', 'clsPhoenixMobileAcknowledgement');

end.