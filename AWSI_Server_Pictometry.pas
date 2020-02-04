// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/PictometryServer.php?wsdl
//  >Import : http://carme/secure/ws/awsi/PictometryServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (10/8/2012 3:46:00 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit AWSI_Server_Pictometry;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;


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
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsResults           = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPictometryData    = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSearchByGeocodeResponse = class;           { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsSearchByAddressResponse = class;           { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponse = class;           { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponseData = class;       { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsDownloadMapsResponse = class;              { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPictometrySearchByAddressRequest = class;   { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPictometrySearchByGeocodeRequest = class;   { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPictometrySearchModifiers = class;         { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsParcelInfo        = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsPictometrySearchWithParcelModifiers = class;   { "http://carme/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgement   = class;                 { "http://carme/secure/ws/WSDL"[GblCplx] }



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
  // XML       : clsPictometryData, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPictometryData = class(TRemotable)
  private
    FNorthView: WideString;
    FEastView: WideString;
    FSouthView: WideString;
    FWestView: WideString;
    FOrthogonalView: WideString;
    FServiceAcknowledgement: WideString;
  published
    property NorthView:              WideString  read FNorthView write FNorthView;
    property EastView:               WideString  read FEastView write FEastView;
    property SouthView:              WideString  read FSouthView write FSouthView;
    property WestView:               WideString  read FWestView write FWestView;
    property OrthogonalView:         WideString  read FOrthogonalView write FOrthogonalView;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsSearchByGeocodeResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSearchByGeocodeResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsPictometryData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults         read FResults write FResults;
    property ResponseData: clsPictometryData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsSearchByAddressResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSearchByAddressResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsPictometryData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults         read FResults write FResults;
    property ResponseData: clsPictometryData  read FResponseData write FResponseData;
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
  // XML       : clsDownloadMapsResponse, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsDownloadMapsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsPictometryData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults         read FResults write FResults;
    property ResponseData: clsPictometryData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsPictometrySearchByAddressRequest, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPictometrySearchByAddressRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
  end;



  // ************************************************************************ //
  // XML       : clsPictometrySearchByGeocodeRequest, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPictometrySearchByGeocodeRequest = class(TRemotable)
  private
    FLongitude: Single;
    FLatitude: Single;
  published
    property Longitude: Single  read FLongitude write FLongitude;
    property Latitude:  Single  read FLatitude write FLatitude;
  end;



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
    FCompanyKey: WideString;
    FOrderNumberKey: WideString;
    FPurchase: Integer;
    FCustomerOrderNumber: WideString;
    FCustomerOrderNumber_Specified: boolean;
    procedure SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
    function  CustomerOrderNumber_Specified(Index: Integer): boolean;
  published
    property Username:            WideString  read FUsername write FUsername;
    property Password:            WideString  read FPassword write FPassword;
    property CompanyKey:          WideString  read FCompanyKey write FCompanyKey;
    property OrderNumberKey:      WideString  read FOrderNumberKey write FOrderNumberKey;
    property Purchase:            Integer     read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString  Index (IS_OPTN) read FCustomerOrderNumber write SetCustomerOrderNumber stored CustomerOrderNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsPictometrySearchModifiers, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPictometrySearchModifiers = class(TRemotable)
  private
    FMapHeight: Integer;
    FMapHeight_Specified: boolean;
    FMapWidth: Integer;
    FMapWidth_Specified: boolean;
    FMapQuality: Integer;
    FMapQuality_Specified: boolean;
    FGetImages: Integer;
    FGetImages_Specified: boolean;
    procedure SetMapHeight(Index: Integer; const AInteger: Integer);
    function  MapHeight_Specified(Index: Integer): boolean;
    procedure SetMapWidth(Index: Integer; const AInteger: Integer);
    function  MapWidth_Specified(Index: Integer): boolean;
    procedure SetMapQuality(Index: Integer; const AInteger: Integer);
    function  MapQuality_Specified(Index: Integer): boolean;
    procedure SetGetImages(Index: Integer; const AInteger: Integer);
    function  GetImages_Specified(Index: Integer): boolean;
  published
    property MapHeight:  Integer  Index (IS_OPTN) read FMapHeight write SetMapHeight stored MapHeight_Specified;
    property MapWidth:   Integer  Index (IS_OPTN) read FMapWidth write SetMapWidth stored MapWidth_Specified;
    property MapQuality: Integer  Index (IS_OPTN) read FMapQuality write SetMapQuality stored MapQuality_Specified;
    property GetImages:  Integer  Index (IS_OPTN) read FGetImages write SetGetImages stored GetImages_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsParcelInfo, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsParcelInfo = class(TRemotable)
  private
    FStrokeColor: WideString;
    FStrokeColor_Specified: boolean;
    FStrokeOpacity: Single;
    FStrokeOpacity_Specified: boolean;
    FStrokeWidth: WideString;
    FStrokeWidth_Specified: boolean;
    FFillColor: WideString;
    FFillColor_Specified: boolean;
    FFillOpacity: WideString;
    FFillOpacity_Specified: boolean;
    FFeatureBuffer: Integer;
    FFeatureBuffer_Specified: boolean;
    FOrientations: WideString;
    FOrientations_Specified: boolean;
    FDraw: Integer;
    FDraw_Specified: boolean;
    procedure SetStrokeColor(Index: Integer; const AWideString: WideString);
    function  StrokeColor_Specified(Index: Integer): boolean;
    procedure SetStrokeOpacity(Index: Integer; const ASingle: Single);
    function  StrokeOpacity_Specified(Index: Integer): boolean;
    procedure SetStrokeWidth(Index: Integer; const AWideString: WideString);
    function  StrokeWidth_Specified(Index: Integer): boolean;
    procedure SetFillColor(Index: Integer; const AWideString: WideString);
    function  FillColor_Specified(Index: Integer): boolean;
    procedure SetFillOpacity(Index: Integer; const AWideString: WideString);
    function  FillOpacity_Specified(Index: Integer): boolean;
    procedure SetFeatureBuffer(Index: Integer; const AInteger: Integer);
    function  FeatureBuffer_Specified(Index: Integer): boolean;
    procedure SetOrientations(Index: Integer; const AWideString: WideString);
    function  Orientations_Specified(Index: Integer): boolean;
    procedure SetDraw(Index: Integer; const AInteger: Integer);
    function  Draw_Specified(Index: Integer): boolean;
  published
    property StrokeColor:   WideString  Index (IS_OPTN) read FStrokeColor write SetStrokeColor stored StrokeColor_Specified;
    property StrokeOpacity: Single      Index (IS_OPTN) read FStrokeOpacity write SetStrokeOpacity stored StrokeOpacity_Specified;
    property StrokeWidth:   WideString  Index (IS_OPTN) read FStrokeWidth write SetStrokeWidth stored StrokeWidth_Specified;
    property FillColor:     WideString  Index (IS_OPTN) read FFillColor write SetFillColor stored FillColor_Specified;
    property FillOpacity:   WideString  Index (IS_OPTN) read FFillOpacity write SetFillOpacity stored FillOpacity_Specified;
    property FeatureBuffer: Integer     Index (IS_OPTN) read FFeatureBuffer write SetFeatureBuffer stored FeatureBuffer_Specified;
    property Orientations:  WideString  Index (IS_OPTN) read FOrientations write SetOrientations stored Orientations_Specified;
    property Draw:          Integer     Index (IS_OPTN) read FDraw write SetDraw stored Draw_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsPictometrySearchWithParcelModifiers, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPictometrySearchWithParcelModifiers = class(TRemotable)
  private
    FMapHeight: Integer;
    FMapHeight_Specified: boolean;
    FMapWidth: Integer;
    FMapWidth_Specified: boolean;
    FMapQuality: Integer;
    FMapQuality_Specified: boolean;
    FGetImages: Integer;
    FGetImages_Specified: boolean;
    FParcelInfo: clsParcelInfo;
    FParcelInfo_Specified: boolean;
    procedure SetMapHeight(Index: Integer; const AInteger: Integer);
    function  MapHeight_Specified(Index: Integer): boolean;
    procedure SetMapWidth(Index: Integer; const AInteger: Integer);
    function  MapWidth_Specified(Index: Integer): boolean;
    procedure SetMapQuality(Index: Integer; const AInteger: Integer);
    function  MapQuality_Specified(Index: Integer): boolean;
    procedure SetGetImages(Index: Integer; const AInteger: Integer);
    function  GetImages_Specified(Index: Integer): boolean;
    procedure SetParcelInfo(Index: Integer; const AclsParcelInfo: clsParcelInfo);
    function  ParcelInfo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property MapHeight:  Integer        Index (IS_OPTN) read FMapHeight write SetMapHeight stored MapHeight_Specified;
    property MapWidth:   Integer        Index (IS_OPTN) read FMapWidth write SetMapWidth stored MapWidth_Specified;
    property MapQuality: Integer        Index (IS_OPTN) read FMapQuality write SetMapQuality stored MapQuality_Specified;
    property GetImages:  Integer        Index (IS_OPTN) read FGetImages write SetGetImages stored GetImages_Specified;
    property ParcelInfo: clsParcelInfo  Index (IS_OPTN) read FParcelInfo write SetParcelInfo stored ParcelInfo_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgement, global, <complexType>
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Received:               Integer     read FReceived write FReceived;
    property ServiceAcknowledgement: WideString  read FServiceAcknowledgement write FServiceAcknowledgement;
  end;


  // ************************************************************************ //
  // Namespace : PictometryServerClass
  // soapAction: PictometryServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : PictometryServerBinding
  // service   : PictometryServer
  // port      : PictometryServerPort
  // URL       : http://carme/secure/ws/awsi/PictometryServer.php
  // ************************************************************************ //
  PictometryServerPortType = interface(IInvokable)
  ['{D67175BA-F212-7CE0-7AAE-B09F866C1120}']
    function  PictometryService_SearchByAddress(const UserCredentials: clsUserCredentials; const PictometryAddressSearch: clsPictometrySearchByAddressRequest; const PictometrySearchModifiers: clsPictometrySearchModifiers): clsSearchByAddressResponse; stdcall;
    function  PictometryService_SearchByGeocode(const UserCredentials: clsUserCredentials; const PictometryGeoCodeSearch: clsPictometrySearchByGeocodeRequest; const PictometrySearchModifiers: clsPictometrySearchModifiers): clsSearchByGeocodeResponse; stdcall;
    function  PictometryService_SearchByAddressWithParcel(const UserCredentials: clsUserCredentials; const PictometryAddressSearch: clsPictometrySearchByAddressRequest; const PictometrySearchModifiers: clsPictometrySearchWithParcelModifiers): clsSearchByAddressResponse; stdcall;
    function  PictometryService_SearchByGeocodeWithParcel(const UserCredentials: clsUserCredentials; const PictometryGeoCodeSearch: clsPictometrySearchByGeocodeRequest; const PictometrySearchModifiers: clsPictometrySearchWithParcelModifiers): clsSearchByGeocodeResponse; stdcall;
    function  PictometryService_DownloadMaps(const UserCredentials: clsUserCredentials; const PictometryDownloadMaps: clsPictometryData): clsDownloadMapsResponse; stdcall;
    function  PictometryService_Acknowledgement(const UserCredentials: clsUserCredentials; const PictometryAcknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetPictometryServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PictometryServerPortType;


implementation
  uses SysUtils;

function GetPictometryServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PictometryServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/PictometryServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/PictometryServer.php';
  defSvc  = 'PictometryServer';
  defPrt  = 'PictometryServerPort';
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
    Result := (RIO as PictometryServerPortType);
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


destructor clsSearchByGeocodeResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsSearchByAddressResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsAcknowledgementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsDownloadMapsResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsUserCredentials.SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FCustomerOrderNumber := AWideString;
  FCustomerOrderNumber_Specified := True;
end;

function clsUserCredentials.CustomerOrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FCustomerOrderNumber_Specified;
end;

procedure clsPictometrySearchModifiers.SetMapHeight(Index: Integer; const AInteger: Integer);
begin
  FMapHeight := AInteger;
  FMapHeight_Specified := True;
end;

function clsPictometrySearchModifiers.MapHeight_Specified(Index: Integer): boolean;
begin
  Result := FMapHeight_Specified;
end;

procedure clsPictometrySearchModifiers.SetMapWidth(Index: Integer; const AInteger: Integer);
begin
  FMapWidth := AInteger;
  FMapWidth_Specified := True;
end;

function clsPictometrySearchModifiers.MapWidth_Specified(Index: Integer): boolean;
begin
  Result := FMapWidth_Specified;
end;

procedure clsPictometrySearchModifiers.SetMapQuality(Index: Integer; const AInteger: Integer);
begin
  FMapQuality := AInteger;
  FMapQuality_Specified := True;
end;

function clsPictometrySearchModifiers.MapQuality_Specified(Index: Integer): boolean;
begin
  Result := FMapQuality_Specified;
end;

procedure clsPictometrySearchModifiers.SetGetImages(Index: Integer; const AInteger: Integer);
begin
  FGetImages := AInteger;
  FGetImages_Specified := True;
end;

function clsPictometrySearchModifiers.GetImages_Specified(Index: Integer): boolean;
begin
  Result := FGetImages_Specified;
end;

procedure clsParcelInfo.SetStrokeColor(Index: Integer; const AWideString: WideString);
begin
  FStrokeColor := AWideString;
  FStrokeColor_Specified := True;
end;

function clsParcelInfo.StrokeColor_Specified(Index: Integer): boolean;
begin
  Result := FStrokeColor_Specified;
end;

procedure clsParcelInfo.SetStrokeOpacity(Index: Integer; const ASingle: Single);
begin
  FStrokeOpacity := ASingle;
  FStrokeOpacity_Specified := True;
end;

function clsParcelInfo.StrokeOpacity_Specified(Index: Integer): boolean;
begin
  Result := FStrokeOpacity_Specified;
end;

procedure clsParcelInfo.SetStrokeWidth(Index: Integer; const AWideString: WideString);
begin
  FStrokeWidth := AWideString;
  FStrokeWidth_Specified := True;
end;

function clsParcelInfo.StrokeWidth_Specified(Index: Integer): boolean;
begin
  Result := FStrokeWidth_Specified;
end;

procedure clsParcelInfo.SetFillColor(Index: Integer; const AWideString: WideString);
begin
  FFillColor := AWideString;
  FFillColor_Specified := True;
end;

function clsParcelInfo.FillColor_Specified(Index: Integer): boolean;
begin
  Result := FFillColor_Specified;
end;

procedure clsParcelInfo.SetFillOpacity(Index: Integer; const AWideString: WideString);
begin
  FFillOpacity := AWideString;
  FFillOpacity_Specified := True;
end;

function clsParcelInfo.FillOpacity_Specified(Index: Integer): boolean;
begin
  Result := FFillOpacity_Specified;
end;

procedure clsParcelInfo.SetFeatureBuffer(Index: Integer; const AInteger: Integer);
begin
  FFeatureBuffer := AInteger;
  FFeatureBuffer_Specified := True;
end;

function clsParcelInfo.FeatureBuffer_Specified(Index: Integer): boolean;
begin
  Result := FFeatureBuffer_Specified;
end;

procedure clsParcelInfo.SetOrientations(Index: Integer; const AWideString: WideString);
begin
  FOrientations := AWideString;
  FOrientations_Specified := True;
end;

function clsParcelInfo.Orientations_Specified(Index: Integer): boolean;
begin
  Result := FOrientations_Specified;
end;

procedure clsParcelInfo.SetDraw(Index: Integer; const AInteger: Integer);
begin
  FDraw := AInteger;
  FDraw_Specified := True;
end;

function clsParcelInfo.Draw_Specified(Index: Integer): boolean;
begin
  Result := FDraw_Specified;
end;

destructor clsPictometrySearchWithParcelModifiers.Destroy;
begin
  FreeAndNil(FParcelInfo);
  inherited Destroy;
end;

procedure clsPictometrySearchWithParcelModifiers.SetMapHeight(Index: Integer; const AInteger: Integer);
begin
  FMapHeight := AInteger;
  FMapHeight_Specified := True;
end;

function clsPictometrySearchWithParcelModifiers.MapHeight_Specified(Index: Integer): boolean;
begin
  Result := FMapHeight_Specified;
end;

procedure clsPictometrySearchWithParcelModifiers.SetMapWidth(Index: Integer; const AInteger: Integer);
begin
  FMapWidth := AInteger;
  FMapWidth_Specified := True;
end;

function clsPictometrySearchWithParcelModifiers.MapWidth_Specified(Index: Integer): boolean;
begin
  Result := FMapWidth_Specified;
end;

procedure clsPictometrySearchWithParcelModifiers.SetMapQuality(Index: Integer; const AInteger: Integer);
begin
  FMapQuality := AInteger;
  FMapQuality_Specified := True;
end;

function clsPictometrySearchWithParcelModifiers.MapQuality_Specified(Index: Integer): boolean;
begin
  Result := FMapQuality_Specified;
end;

procedure clsPictometrySearchWithParcelModifiers.SetGetImages(Index: Integer; const AInteger: Integer);
begin
  FGetImages := AInteger;
  FGetImages_Specified := True;
end;

function clsPictometrySearchWithParcelModifiers.GetImages_Specified(Index: Integer): boolean;
begin
  Result := FGetImages_Specified;
end;

procedure clsPictometrySearchWithParcelModifiers.SetParcelInfo(Index: Integer; const AclsParcelInfo: clsParcelInfo);
begin
  FParcelInfo := AclsParcelInfo;
  FParcelInfo_Specified := True;
end;

function clsPictometrySearchWithParcelModifiers.ParcelInfo_Specified(Index: Integer): boolean;
begin
  Result := FParcelInfo_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PictometryServerPortType), 'PictometryServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PictometryServerPortType), 'PictometryServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_SearchByAddress', 'PictometryService.SearchByAddress');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_SearchByGeocode', 'PictometryService.SearchByGeocode');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_SearchByAddressWithParcel', 'PictometryService.SearchByAddressWithParcel');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_SearchByGeocodeWithParcel', 'PictometryService.SearchByGeocodeWithParcel');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_DownloadMaps', 'PictometryService.DownloadMaps');
  InvRegistry.RegisterExternalMethName(TypeInfo(PictometryServerPortType), 'PictometryService_Acknowledgement', 'PictometryService.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsPictometryData, 'http://carme/secure/ws/WSDL', 'clsPictometryData');
  RemClassRegistry.RegisterXSClass(clsSearchByGeocodeResponse, 'http://carme/secure/ws/WSDL', 'clsSearchByGeocodeResponse');
  RemClassRegistry.RegisterXSClass(clsSearchByAddressResponse, 'http://carme/secure/ws/WSDL', 'clsSearchByAddressResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsDownloadMapsResponse, 'http://carme/secure/ws/WSDL', 'clsDownloadMapsResponse');
  RemClassRegistry.RegisterXSClass(clsPictometrySearchByAddressRequest, 'http://carme/secure/ws/WSDL', 'clsPictometrySearchByAddressRequest');
  RemClassRegistry.RegisterXSClass(clsPictometrySearchByGeocodeRequest, 'http://carme/secure/ws/WSDL', 'clsPictometrySearchByGeocodeRequest');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsPictometrySearchModifiers, 'http://carme/secure/ws/WSDL', 'clsPictometrySearchModifiers');
  RemClassRegistry.RegisterXSClass(clsParcelInfo, 'http://carme/secure/ws/WSDL', 'clsParcelInfo');
  RemClassRegistry.RegisterXSClass(clsPictometrySearchWithParcelModifiers, 'http://carme/secure/ws/WSDL', 'clsPictometrySearchWithParcelModifiers');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme/secure/ws/WSDL', 'clsAcknowledgement');

end.
