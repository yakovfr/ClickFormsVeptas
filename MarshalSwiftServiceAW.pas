// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ws2.bradfordsoftware.com/WSMarshalSwiftAW/MarshalSwiftServiceAW.asmx?wsdl
//  >Import : http://ws2.bradfordsoftware.com/WSMarshalSwiftAW/MarshalSwiftServiceAW.asmx?wsdl:0
// Encoding : utf-8
// Version  : 1.0
// (7/10/2019 11:29:47 AM - - $Rev: 10138 $)
// ************************************************************************ //

unit MarshalSwiftServiceAW;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  MSResponse           = class;                 { "http://tempuri.org/"[GblCplx] }



  // ************************************************************************ //
  // XML       : MSResponse, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  MSResponse = class(TRemotable)
  private
    FmsToken: WideString;
    FmsToken_Specified: boolean;
    FestimateID: Integer;
    FerrCode: Integer;
    FerrMsg: WideString;
    FerrMsg_Specified: boolean;
    procedure SetmsToken(Index: Integer; const AWideString: WideString);
    function  msToken_Specified(Index: Integer): boolean;
    procedure SeterrMsg(Index: Integer; const AWideString: WideString);
    function  errMsg_Specified(Index: Integer): boolean;
  published
    property msToken:    WideString  Index (IS_OPTN) read FmsToken write SetmsToken stored msToken_Specified;
    property estimateID: Integer     read FestimateID write FestimateID;
    property errCode:    Integer     read FerrCode write FerrCode;
    property errMsg:     WideString  Index (IS_OPTN) read FerrMsg write SeterrMsg stored errMsg_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : MarshalSwiftServiceAWSoap
  // service   : MarshalSwiftServiceAW
  // port      : MarshalSwiftServiceAWSoap
  // URL       : http://ws2.bradfordsoftware.com/WSMarshalSwiftAW/MarshalSwiftServiceAW.asmx
  // ************************************************************************ //
  MarshalSwiftServiceAWSoap = interface(IInvokable)
  ['{1669D1C9-9CC3-8605-7CAB-B2464E3334E5}']
    function  getSecurityTokenForNew(const serviceID: WideString; const estimateDesc: WideString; const customerID: Integer; const address: WideString; const city: WideString; const state: WideString; 
                                     const zip: WideString): MSResponse; stdcall;
    function  getSecurityTokenForExisting(const serviceID: WideString; const estimateID: Integer; const customerID: Integer): MSResponse; stdcall;
    function  GetRegionFromZip(const zipCode: WideString): WideString; stdcall;
  end;

function GetMarshalSwiftServiceAWSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MarshalSwiftServiceAWSoap;


implementation
  uses SysUtils;

function GetMarshalSwiftServiceAWSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MarshalSwiftServiceAWSoap;
const
  defWSDL = 'http://ws2.bradfordsoftware.com/WSMarshalSwiftAW/MarshalSwiftServiceAW.asmx?wsdl';
  defURL  = 'http://ws2.bradfordsoftware.com/WSMarshalSwiftAW/MarshalSwiftServiceAW.asmx';
  defSvc  = 'MarshalSwiftServiceAW';
  defPrt  = 'MarshalSwiftServiceAWSoap';
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
    Result := (RIO as MarshalSwiftServiceAWSoap);
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


procedure MSResponse.SetmsToken(Index: Integer; const AWideString: WideString);
begin
  FmsToken := AWideString;
  FmsToken_Specified := True;
end;

function MSResponse.msToken_Specified(Index: Integer): boolean;
begin
  Result := FmsToken_Specified;
end;

procedure MSResponse.SeterrMsg(Index: Integer; const AWideString: WideString);
begin
  FerrMsg := AWideString;
  FerrMsg_Specified := True;
end;

function MSResponse.errMsg_Specified(Index: Integer): boolean;
begin
  Result := FerrMsg_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MarshalSwiftServiceAWSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MarshalSwiftServiceAWSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MarshalSwiftServiceAWSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(MSResponse, 'http://tempuri.org/', 'MSResponse');

end.