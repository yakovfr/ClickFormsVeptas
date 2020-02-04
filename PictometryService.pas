// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.0.0.43/WSClfPictometry/PictometryService.asmx?WSDL
//  >Import : http://10.0.0.43/WSClfPictometry/PictometryService.asmx?WSDL:0
// Encoding : utf-8
// Version  : 1.0
// (11/13/2014 12:06:11 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit PictometryService;

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
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]

  PictometryAddress    = class;                 { "http://bradfordsoftware.com/"[GblCplx] }
  PictometrySearchModifiers = class;            { "http://bradfordsoftware.com/"[GblCplx] }
  PictometryMaps       = class;                 { "http://bradfordsoftware.com/"[GblCplx] }
  UserCredentials      = class;                 { "http://bradfordsoftware.com/"[Hdr][GblCplx] }
  UserCredentials2     = class;                 { "http://bradfordsoftware.com/"[Hdr][GblElm] }



  // ************************************************************************ //
  // XML       : PictometryAddress, global, <complexType>
  // Namespace : http://bradfordsoftware.com/
  // ************************************************************************ //
  PictometryAddress = class(TRemotable)
  private
    FstreetAddress: WideString;
    FstreetAddress_Specified: boolean;
    Fcity: WideString;
    Fcity_Specified: boolean;
    Fstate: WideString;
    Fstate_Specified: boolean;
    Fzip: WideString;
    Fzip_Specified: boolean;
    procedure SetstreetAddress(Index: Integer; const AWideString: WideString);
    function  streetAddress_Specified(Index: Integer): boolean;
    procedure Setcity(Index: Integer; const AWideString: WideString);
    function  city_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const AWideString: WideString);
    function  state_Specified(Index: Integer): boolean;
    procedure Setzip(Index: Integer; const AWideString: WideString);
    function  zip_Specified(Index: Integer): boolean;
  published
    property streetAddress: WideString  Index (IS_OPTN) read FstreetAddress write SetstreetAddress stored streetAddress_Specified;
    property city:          WideString  Index (IS_OPTN) read Fcity write Setcity stored city_Specified;
    property state:         WideString  Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property zip:           WideString  Index (IS_OPTN) read Fzip write Setzip stored zip_Specified;
  end;



  // ************************************************************************ //
  // XML       : PictometrySearchModifiers, global, <complexType>
  // Namespace : http://bradfordsoftware.com/
  // ************************************************************************ //
  PictometrySearchModifiers = class(TRemotable)
  private
    FMapWidth: Integer;
    FMapHeight: Integer;
    FMapQuality: Integer;
  published
    property MapWidth:   Integer  read FMapWidth write FMapWidth;
    property MapHeight:  Integer  read FMapHeight write FMapHeight;
    property MapQuality: Integer  read FMapQuality write FMapQuality;
  end;



  // ************************************************************************ //
  // XML       : PictometryMaps, global, <complexType>
  // Namespace : http://bradfordsoftware.com/
  // ************************************************************************ //
  PictometryMaps = class(TRemotable)
  private
    FNorthView: TByteDynArray;
    FNorthView_Specified: boolean;
    FEastView: TByteDynArray;
    FEastView_Specified: boolean;
    FSouthView: TByteDynArray;
    FSouthView_Specified: boolean;
    FWestView: TByteDynArray;
    FWestView_Specified: boolean;
    FOrthogonalView: TByteDynArray;
    FOrthogonalView_Specified: boolean;
    procedure SetNorthView(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  NorthView_Specified(Index: Integer): boolean;
    procedure SetEastView(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  EastView_Specified(Index: Integer): boolean;
    procedure SetSouthView(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  SouthView_Specified(Index: Integer): boolean;
    procedure SetWestView(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  WestView_Specified(Index: Integer): boolean;
    procedure SetOrthogonalView(Index: Integer; const ATByteDynArray: TByteDynArray);
    function  OrthogonalView_Specified(Index: Integer): boolean;
  published
    property NorthView:      TByteDynArray  Index (IS_OPTN) read FNorthView write SetNorthView stored NorthView_Specified;
    property EastView:       TByteDynArray  Index (IS_OPTN) read FEastView write SetEastView stored EastView_Specified;
    property SouthView:      TByteDynArray  Index (IS_OPTN) read FSouthView write SetSouthView stored SouthView_Specified;
    property WestView:       TByteDynArray  Index (IS_OPTN) read FWestView write SetWestView stored WestView_Specified;
    property OrthogonalView: TByteDynArray  Index (IS_OPTN) read FOrthogonalView write SetOrthogonalView stored OrthogonalView_Specified;
  end;



  // ************************************************************************ //
  // XML       : UserCredentials, global, <complexType>
  // Namespace : http://bradfordsoftware.com/
  // Info      : Header
  // ************************************************************************ //
  UserCredentials = class(TSOAPHeader)
  private
    FCustID: WideString;
    FCustID_Specified: boolean;
    FPassword: WideString;
    FPassword_Specified: boolean;
    procedure SetCustID(Index: Integer; const AWideString: WideString);
    function  CustID_Specified(Index: Integer): boolean;
    procedure SetPassword(Index: Integer; const AWideString: WideString);
    function  Password_Specified(Index: Integer): boolean;
  published
    property CustID:   WideString  Index (IS_OPTN) read FCustID write SetCustID stored CustID_Specified;
    property Password: WideString  Index (IS_OPTN) read FPassword write SetPassword stored Password_Specified;
  end;



  // ************************************************************************ //
  // XML       : UserCredentials, global, <element>
  // Namespace : http://bradfordsoftware.com/
  // Info      : Header
  // ************************************************************************ //
  UserCredentials2 = class(UserCredentials)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://bradfordsoftware.com/
  // soapAction: http://bradfordsoftware.com/SearchByAddress
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : PictometryServiceSoap
  // service   : PictometryService
  // port      : PictometryServiceSoap
  // URL       : http://10.0.0.43/WSClfPictometry/PictometryService.asmx
  // ************************************************************************ //
  PictometryServiceSoap = interface(IInvokable)
  ['{8B1AEEE3-BFFA-C30B-EA78-7358EDDB2E5B}']

    // Headers: UserCredentials:pIn
    function  SearchByAddress(const ipAddress: PictometryAddress; const ipSearchModifiers: PictometrySearchModifiers): PictometryMaps; stdcall;
  end;

function GetPictometryServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PictometryServiceSoap;


implementation
  uses SysUtils;

function GetPictometryServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PictometryServiceSoap;
const
  defWSDL = 'http://10.0.0.43/WSClfPictometry/PictometryService.asmx?WSDL';
  defURL  = 'http://10.0.0.43/WSClfPictometry/PictometryService.asmx';
  defSvc  = 'PictometryService';
  defPrt  = 'PictometryServiceSoap';
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
    Result := (RIO as PictometryServiceSoap);
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


procedure PictometryAddress.SetstreetAddress(Index: Integer; const AWideString: WideString);
begin
  FstreetAddress := AWideString;
  FstreetAddress_Specified := True;
end;

function PictometryAddress.streetAddress_Specified(Index: Integer): boolean;
begin
  Result := FstreetAddress_Specified;
end;

procedure PictometryAddress.Setcity(Index: Integer; const AWideString: WideString);
begin
  Fcity := AWideString;
  Fcity_Specified := True;
end;

function PictometryAddress.city_Specified(Index: Integer): boolean;
begin
  Result := Fcity_Specified;
end;

procedure PictometryAddress.Setstate(Index: Integer; const AWideString: WideString);
begin
  Fstate := AWideString;
  Fstate_Specified := True;
end;

function PictometryAddress.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure PictometryAddress.Setzip(Index: Integer; const AWideString: WideString);
begin
  Fzip := AWideString;
  Fzip_Specified := True;
end;

function PictometryAddress.zip_Specified(Index: Integer): boolean;
begin
  Result := Fzip_Specified;
end;

procedure PictometryMaps.SetNorthView(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FNorthView := ATByteDynArray;
  FNorthView_Specified := True;
end;

function PictometryMaps.NorthView_Specified(Index: Integer): boolean;
begin
  Result := FNorthView_Specified;
end;

procedure PictometryMaps.SetEastView(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FEastView := ATByteDynArray;
  FEastView_Specified := True;
end;

function PictometryMaps.EastView_Specified(Index: Integer): boolean;
begin
  Result := FEastView_Specified;
end;

procedure PictometryMaps.SetSouthView(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FSouthView := ATByteDynArray;
  FSouthView_Specified := True;
end;

function PictometryMaps.SouthView_Specified(Index: Integer): boolean;
begin
  Result := FSouthView_Specified;
end;

procedure PictometryMaps.SetWestView(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FWestView := ATByteDynArray;
  FWestView_Specified := True;
end;

function PictometryMaps.WestView_Specified(Index: Integer): boolean;
begin
  Result := FWestView_Specified;
end;

procedure PictometryMaps.SetOrthogonalView(Index: Integer; const ATByteDynArray: TByteDynArray);
begin
  FOrthogonalView := ATByteDynArray;
  FOrthogonalView_Specified := True;
end;

function PictometryMaps.OrthogonalView_Specified(Index: Integer): boolean;
begin
  Result := FOrthogonalView_Specified;
end;

procedure UserCredentials.SetCustID(Index: Integer; const AWideString: WideString);
begin
  FCustID := AWideString;
  FCustID_Specified := True;
end;

function UserCredentials.CustID_Specified(Index: Integer): boolean;
begin
  Result := FCustID_Specified;
end;

procedure UserCredentials.SetPassword(Index: Integer; const AWideString: WideString);
begin
  FPassword := AWideString;
  FPassword_Specified := True;
end;

function UserCredentials.Password_Specified(Index: Integer): boolean;
begin
  Result := FPassword_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PictometryServiceSoap), 'http://bradfordsoftware.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PictometryServiceSoap), 'http://bradfordsoftware.com/SearchByAddress');
  InvRegistry.RegisterInvokeOptions(TypeInfo(PictometryServiceSoap), ioDocument);
  InvRegistry.RegisterHeaderClass(TypeInfo(PictometryServiceSoap), UserCredentials2, 'UserCredentials', 'http://bradfordsoftware.com/');
  RemClassRegistry.RegisterXSClass(PictometryAddress, 'http://bradfordsoftware.com/', 'PictometryAddress');
  RemClassRegistry.RegisterXSClass(PictometrySearchModifiers, 'http://bradfordsoftware.com/', 'PictometrySearchModifiers');
  RemClassRegistry.RegisterXSClass(PictometryMaps, 'http://bradfordsoftware.com/', 'PictometryMaps');
  RemClassRegistry.RegisterXSClass(UserCredentials, 'http://bradfordsoftware.com/', 'UserCredentials');
  RemClassRegistry.RegisterXSClass(UserCredentials2, 'http://bradfordsoftware.com/', 'UserCredentials2', 'UserCredentials');

end.