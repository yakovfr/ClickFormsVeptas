// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WSLocation/LocationService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (12/12/2006 1:38:18 PM - 1.33.2.5)
// ************************************************************************ //

unit LocationService;

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
  // !:double          - "http://www.w3.org/2001/XMLSchema"
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"

  AJMAddress           = class;                 { "http://tempuri.org/" }
  BndRectangle         = class;                 { "http://tempuri.org/" }
  GeoPointEx           = class;                 { "http://tempuri.org/GeoSvc/Service1" }
  GeoData              = class;                 { "http://tempuri.org/GeoSvc/Service1" }
  LatLong              = class;                 { "http://s.mappoint.net/mappoint-30/" }
  LatLongRectangle     = class;                 { "http://s.mappoint.net/mappoint-30/" }
  Address              = class;                 { "http://s.mappoint.net/mappoint-30/" }
  EntityPropertyValue  = class;                 { "http://s.mappoint.net/mappoint-30/" }
  ArrayOfEntityPropertyValue = class;           { "http://s.mappoint.net/mappoint-30/"[A] }
  Entity               = class;                 { "http://s.mappoint.net/mappoint-30/" }
  MapView              = class;                 { "http://s.mappoint.net/mappoint-30/" }
  ViewByBoundingRectangle = class;              { "http://s.mappoint.net/mappoint-30/" }
  ViewByHeightWidth    = class;                 { "http://s.mappoint.net/mappoint-30/" }
  ViewByScale          = class;                 { "http://s.mappoint.net/mappoint-30/" }
  MapViewRepresentations = class;               { "http://s.mappoint.net/mappoint-30/" }
  Location             = class;                 { "http://s.mappoint.net/mappoint-30/" }
  FindResult           = class;                 { "http://s.mappoint.net/mappoint-30/" }
  FindResults          = class;                 { "http://s.mappoint.net/mappoint-30/" }
  MimeData             = class;                 { "http://s.mappoint.net/mappoint-30/" }
  PixelRectangle       = class;                 { "http://s.mappoint.net/mappoint-30/" }
  HotArea              = class;                 { "http://s.mappoint.net/mappoint-30/" }
  MapImage             = class;                 { "http://s.mappoint.net/mappoint-30/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  AJMAddress = class(TRemotable)
  private
    FszStreet: WideString;
    FszCity: WideString;
    FszState: WideString;
    FszZip: WideString;
  published
    property szStreet: WideString read FszStreet write FszStreet;
    property szCity: WideString read FszCity write FszCity;
    property szState: WideString read FszState write FszState;
    property szZip: WideString read FszZip write FszZip;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  BndRectangle = class(TRemotable)
  private
    FSWLat: Double;
    FSWLong: Double;
    FNELat: Double;
    FNELong: Double;
  published
    property SWLat: Double read FSWLat write FSWLat;
    property SWLong: Double read FSWLong write FSWLong;
    property NELat: Double read FNELat write FNELat;
    property NELong: Double read FNELong write FNELong;
  end;



  // ************************************************************************ //
  // Namespace : http://tempuri.org/GeoSvc/Service1
  // ************************************************************************ //
  GeoPointEx = class(TRemotable)
  private
    FLoc: WideString;
    FAddress: WideString;
    FBlock: WideString;
    FTract: WideString;
    FZip: WideString;
    FPlace: WideString;
    FPlaceFIPS: WideString;
    FCountySub: WideString;
    FCountySubFIPS: WideString;
    FCounty: WideString;
    FCountyFIPS: WideString;
    FState: WideString;
    FStateFIPS: WideString;
    FLatitude: Double;
    FLongitude: Double;
  published
    property Loc: WideString read FLoc write FLoc;
    property Address: WideString read FAddress write FAddress;
    property Block: WideString read FBlock write FBlock;
    property Tract: WideString read FTract write FTract;
    property Zip: WideString read FZip write FZip;
    property Place: WideString read FPlace write FPlace;
    property PlaceFIPS: WideString read FPlaceFIPS write FPlaceFIPS;
    property CountySub: WideString read FCountySub write FCountySub;
    property CountySubFIPS: WideString read FCountySubFIPS write FCountySubFIPS;
    property County: WideString read FCounty write FCounty;
    property CountyFIPS: WideString read FCountyFIPS write FCountyFIPS;
    property State: WideString read FState write FState;
    property StateFIPS: WideString read FStateFIPS write FStateFIPS;
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
  end;

  ArrayOfGeoPointEx = array of GeoPointEx;      { "http://tempuri.org/GeoSvc/Service1" }


  // ************************************************************************ //
  // Namespace : http://tempuri.org/GeoSvc/Service1
  // ************************************************************************ //
  GeoData = class(TRemotable)
  private
    FStatus: Integer;
    FMessage: WideString;
    FConfidence: Integer;
    FGeoPointsEx: ArrayOfGeoPointEx;
  public
    destructor Destroy; override;
  published
    property Status: Integer read FStatus write FStatus;
    property Message: WideString read FMessage write FMessage;
    property Confidence: Integer read FConfidence write FConfidence;
    property GeoPointsEx: ArrayOfGeoPointEx read FGeoPointsEx write FGeoPointsEx;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  LatLong = class(TRemotable)
  private
    FLatitude: Double;
    FLongitude: Double;
  published
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  LatLongRectangle = class(TRemotable)
  private
    FSouthwest: LatLong;
    FNortheast: LatLong;
  public
    destructor Destroy; override;
  published
    property Southwest: LatLong read FSouthwest write FSouthwest;
    property Northeast: LatLong read FNortheast write FNortheast;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  Address = class(TRemotable)
  private
    FAddressLine: WideString;
    FPrimaryCity: WideString;
    FSecondaryCity: WideString;
    FSubdivision: WideString;
    FPostalCode: WideString;
    FCountryRegion: WideString;
    FFormattedAddress: WideString;
  published
    property AddressLine: WideString read FAddressLine write FAddressLine;
    property PrimaryCity: WideString read FPrimaryCity write FPrimaryCity;
    property SecondaryCity: WideString read FSecondaryCity write FSecondaryCity;
    property Subdivision: WideString read FSubdivision write FSubdivision;
    property PostalCode: WideString read FPostalCode write FPostalCode;
    property CountryRegion: WideString read FCountryRegion write FCountryRegion;
    property FormattedAddress: WideString read FFormattedAddress write FFormattedAddress;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  EntityPropertyValue = class(TRemotable)
  private
    FName: WideString;
    FValue: WideString;
  published
    property Name: WideString read FName write FName;
    property Value: WideString read FValue write FValue;
  end;

  Property_  = array of EntityPropertyValue;    { "http://s.mappoint.net/mappoint-30/" }


  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // Serializtn: [xoInlineArrays]
  // ************************************************************************ //
  ArrayOfEntityPropertyValue = class(TRemotable)
  private
    FProperty_: Property_;
  public
    constructor Create; override;
    destructor Destroy; override;
    function   GetEntityPropertyValueArray(Index: Integer): EntityPropertyValue;
    function   GetEntityPropertyValueArrayLength: Integer;
    property   EntityPropertyValueArray[Index: Integer]: EntityPropertyValue read GetEntityPropertyValueArray; default;
    property   Len: Integer read GetEntityPropertyValueArrayLength;
  published
    property Property_: Property_ read FProperty_ write FProperty_;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  Entity = class(TRemotable)
  private
    FID: Integer;
    FName: WideString;
    FDisplayName: WideString;
    FTypeName: WideString;
    FProperties: ArrayOfEntityPropertyValue;
  public
    destructor Destroy; override;
  published
    property ID: Integer read FID write FID;
    property Name: WideString read FName write FName;
    property DisplayName: WideString read FDisplayName write FDisplayName;
    property TypeName: WideString read FTypeName write FTypeName;
    property Properties: ArrayOfEntityPropertyValue read FProperties write FProperties;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  MapView = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  ViewByBoundingRectangle = class(MapView)
  private
    FBoundingRectangle: LatLongRectangle;
  public
    destructor Destroy; override;
  published
    property BoundingRectangle: LatLongRectangle read FBoundingRectangle write FBoundingRectangle;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  ViewByHeightWidth = class(MapView)
  private
    FHeight: Double;
    FWidth: Double;
    FCenterPoint: LatLong;
  public
    destructor Destroy; override;
  published
    property Height: Double read FHeight write FHeight;
    property Width: Double read FWidth write FWidth;
    property CenterPoint: LatLong read FCenterPoint write FCenterPoint;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  ViewByScale = class(MapView)
  private
    FMapScale: Double;
    FCenterPoint: LatLong;
  public
    destructor Destroy; override;
  published
    property MapScale: Double read FMapScale write FMapScale;
    property CenterPoint: LatLong read FCenterPoint write FCenterPoint;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  MapViewRepresentations = class(TRemotable)
  private
    FByScale: ViewByScale;
    FByHeightWidth: ViewByHeightWidth;
    FByBoundingRectangle: ViewByBoundingRectangle;
  public
    destructor Destroy; override;
  published
    property ByScale: ViewByScale read FByScale write FByScale;
    property ByHeightWidth: ViewByHeightWidth read FByHeightWidth write FByHeightWidth;
    property ByBoundingRectangle: ViewByBoundingRectangle read FByBoundingRectangle write FByBoundingRectangle;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  Location = class(TRemotable)
  private
    FLatLong: LatLong;
    FEntity: Entity;
    FAddress: Address;
    FBestMapView: MapViewRepresentations;
    FDataSourceName: WideString;
  public
    destructor Destroy; override;
  published
    property LatLong: LatLong read FLatLong write FLatLong;
    property Entity: Entity read FEntity write FEntity;
    property Address: Address read FAddress write FAddress;
    property BestMapView: MapViewRepresentations read FBestMapView write FBestMapView;
    property DataSourceName: WideString read FDataSourceName write FDataSourceName;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  FindResult = class(TRemotable)
  private
    FScore: Double;
    FFoundLocation: Location;
  public
    destructor Destroy; override;
  published
    property Score: Double read FScore write FScore;
    property FoundLocation: Location read FFoundLocation write FFoundLocation;
  end;

  ArrayOfFindResult = array of FindResult;      { "http://s.mappoint.net/mappoint-30/" }


  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  FindResults = class(TRemotable)
  private
    FNumberFound: Integer;
    FStartIndex: Integer;
    FResults: ArrayOfFindResult;
    FTopScore: Double;
  public
    destructor Destroy; override;
  published
    property NumberFound: Integer read FNumberFound write FNumberFound;
    property StartIndex: Integer read FStartIndex write FStartIndex;
    property Results: ArrayOfFindResult read FResults write FResults;
    property TopScore: Double read FTopScore write FTopScore;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  MimeData = class(TRemotable)
  private
    FBits: TByteDynArray;
    FContentID: WideString;
    FMimeType: WideString;
  published
    property Bits: TByteDynArray read FBits write FBits;
    property ContentID: WideString read FContentID write FContentID;
    property MimeType: WideString read FMimeType write FMimeType;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  PixelRectangle = class(TRemotable)
  private
    FBottom: Integer;
    FLeft: Integer;
    FRight: Integer;
    FTop: Integer;
  published
    property Bottom: Integer read FBottom write FBottom;
    property Left: Integer read FLeft write FLeft;
    property Right: Integer read FRight write FRight;
    property Top: Integer read FTop write FTop;
  end;



  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  HotArea = class(TRemotable)
  private
    FIconRectangle: PixelRectangle;
    FLabelRectangle: PixelRectangle;
    FPinID: WideString;
  public
    destructor Destroy; override;
  published
    property IconRectangle: PixelRectangle read FIconRectangle write FIconRectangle;
    property LabelRectangle: PixelRectangle read FLabelRectangle write FLabelRectangle;
    property PinID: WideString read FPinID write FPinID;
  end;

  ArrayOfHotArea = array of HotArea;            { "http://s.mappoint.net/mappoint-30/" }


  // ************************************************************************ //
  // Namespace : http://s.mappoint.net/mappoint-30/
  // ************************************************************************ //
  MapImage = class(TRemotable)
  private
    FHotAreas: ArrayOfHotArea;
    FMimeData: MimeData;
    FView: MapViewRepresentations;
    FUrl: WideString;
  public
    destructor Destroy; override;
  published
    property HotAreas: ArrayOfHotArea read FHotAreas write FHotAreas;
    property MimeData: MimeData read FMimeData write FMimeData;
    property View: MapViewRepresentations read FView write FView;
    property Url: WideString read FUrl write FUrl;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : LocationServiceSoap
  // service   : LocationService
  // port      : LocationServiceSoap
  // URL       : http://localhost/WSLocation/LocationService.asmx
  // ************************************************************************ //
  LocationServiceSoap = interface(IInvokable)
  ['{A96E275C-67ED-5B9F-9B0E-3DF63C9AF25C}']
    procedure GetAJMGeocode(const Address: AJMAddress; const iUserID: Integer; const sPassword: WideString;
                            out GetAJMGeocodeResult: Integer; out ResultGeoData: GeoData; out sMsgs: WideString); stdcall;

    procedure GetGeocode(const sAddress: WideString; const iUserID: Integer; const sPassword: WideString;
                        out GetGeocodeResult: FindResults; out sMsgs: WideString); stdcall;

    procedure GetMap(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer; const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer; const iWidth: Integer; const iShowPushPin: Integer;
                     out GetMapResult: TByteDynArray; out dViewScale: Double; out sMsgs: WideString); stdcall;

    procedure GetMapEx(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer; const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer; const iWidth: Integer; const iShowPushPin: Integer; const iZoomPercent: Integer;
                       out GetMapExResult: MapImage; out dViewScale: Double; out sMsgs: WideString); stdcall;

    procedure GetMapBR(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer; const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer; const iWidth: Integer; const iShowPushPin: Integer; const iZoomPercent: Integer;
                        out GetMapBRResult: MapImage; out dViewScale: Double; out sMsgs: WideString); stdcall;

    procedure GetMapBREx(const sLabels: WideString; const sLatLong: WideString; const iUserID: Integer; const sPassword: WideString; const sSubjectAddress: WideString; const iHeight: Integer; const iWidth: Integer; const iShowPushPin: Integer; const iZoomPercent: Integer;
                         out GetMapBRExResult: MapImage; out dViewScale: Double; out BoundingRect: LatLongRectangle; out sMsgs: WideString); stdcall;

    procedure GetPannedMap(const iUserID: Integer; const sPassword: WideString; const iHeight: Integer; const iWidth: Integer; const iDirection: Integer; const iPanPercent: Integer; const OldBoundingRect: BndRectangle;
                           out GetPannedMapResult: MapImage; out dViewScale: Double; out NewBoundingRect: LatLongRectangle; out sMsgs: WideString); stdcall;

    procedure GetMapArea(const iUserID: Integer; const sPassword: WideString; const iHeight: Integer; const iWidth: Integer; const NewBoundingRect: BndRectangle;
                          out GetMapAreaResult: MapImage; out dViewScale: Double; out sMsgs: WideString
                         ); stdcall;

    procedure GetZoomedMap(const iUserID: Integer; const sPassword: WideString; const iHeight: Integer; const iWidth: Integer; const iZoomPercent: Integer; const OldBoundingRect: BndRectangle;
                          out GetZoomedMapResult: MapImage; out dViewScale: Double; out NewBoundingRect: LatLongRectangle; out sMsgs: WideString); stdcall;
  end;

function GetLocationServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): LocationServiceSoap;


implementation

function GetLocationServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): LocationServiceSoap;
const
  defWSDL = 'http://localhost/WSLocation/LocationService.asmx?wsdl';
  defURL  = 'http://localhost/WSLocation/LocationService.asmx';
  defSvc  = 'LocationService';
  defPrt  = 'LocationServiceSoap';
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
    Result := (RIO as LocationServiceSoap);
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


destructor GeoData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FGeoPointsEx)-1 do
    if Assigned(FGeoPointsEx[I]) then
      FGeoPointsEx[I].Free;
  SetLength(FGeoPointsEx, 0);
  inherited Destroy;
end;

destructor LatLongRectangle.Destroy;
begin
  if Assigned(FSouthwest) then
    FSouthwest.Free;
  if Assigned(FNortheast) then
    FNortheast.Free;
  inherited Destroy;
end;

constructor ArrayOfEntityPropertyValue.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays];
end;

destructor ArrayOfEntityPropertyValue.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FProperty_)-1 do
    if Assigned(FProperty_[I]) then
      FProperty_[I].Free;
  SetLength(FProperty_, 0);
  inherited Destroy;
end;

function ArrayOfEntityPropertyValue.GetEntityPropertyValueArray(Index: Integer): EntityPropertyValue;
begin
  Result := FProperty_[Index];
end;

function ArrayOfEntityPropertyValue.GetEntityPropertyValueArrayLength: Integer;
begin
  if Assigned(FProperty_) then
    Result := Length(FProperty_)
  else
  Result := 0;
end;

destructor Entity.Destroy;
begin
  if Assigned(FProperties) then
    FProperties.Free;
  inherited Destroy;
end;

destructor ViewByBoundingRectangle.Destroy;
begin
  if Assigned(FBoundingRectangle) then
    FBoundingRectangle.Free;
  inherited Destroy;
end;

destructor ViewByHeightWidth.Destroy;
begin
  if Assigned(FCenterPoint) then
    FCenterPoint.Free;
  inherited Destroy;
end;

destructor ViewByScale.Destroy;
begin
  if Assigned(FCenterPoint) then
    FCenterPoint.Free;
  inherited Destroy;
end;

destructor MapViewRepresentations.Destroy;
begin
  if Assigned(FByScale) then
    FByScale.Free;
  if Assigned(FByHeightWidth) then
    FByHeightWidth.Free;
  if Assigned(FByBoundingRectangle) then
    FByBoundingRectangle.Free;
  inherited Destroy;
end;

destructor Location.Destroy;
begin
  if Assigned(FLatLong) then
    FLatLong.Free;
  if Assigned(FEntity) then
    FEntity.Free;
  if Assigned(FAddress) then
    FAddress.Free;
  if Assigned(FBestMapView) then
    FBestMapView.Free;
  inherited Destroy;
end;

destructor FindResult.Destroy;
begin
  if Assigned(FFoundLocation) then
    FFoundLocation.Free;
  inherited Destroy;
end;

destructor FindResults.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResults)-1 do
    if Assigned(FResults[I]) then
      FResults[I].Free;
  SetLength(FResults, 0);
  inherited Destroy;
end;

destructor HotArea.Destroy;
begin
  if Assigned(FIconRectangle) then
    FIconRectangle.Free;
  if Assigned(FLabelRectangle) then
    FLabelRectangle.Free;
  inherited Destroy;
end;

destructor MapImage.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FHotAreas)-1 do
    if Assigned(FHotAreas[I]) then
      FHotAreas[I].Free;
  SetLength(FHotAreas, 0);
  if Assigned(FMimeData) then
    FMimeData.Free;
  if Assigned(FView) then
    FView.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(LocationServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(LocationServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(LocationServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(AJMAddress, 'http://tempuri.org/', 'AJMAddress');
  RemClassRegistry.RegisterXSClass(BndRectangle, 'http://tempuri.org/', 'BndRectangle');
  RemClassRegistry.RegisterXSClass(GeoPointEx, 'http://tempuri.org/GeoSvc/Service1', 'GeoPointEx');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfGeoPointEx), 'http://tempuri.org/GeoSvc/Service1', 'ArrayOfGeoPointEx');
  RemClassRegistry.RegisterXSClass(GeoData, 'http://tempuri.org/GeoSvc/Service1', 'GeoData');
  RemClassRegistry.RegisterXSClass(LatLong, 'http://s.mappoint.net/mappoint-30/', 'LatLong');
  RemClassRegistry.RegisterXSClass(LatLongRectangle, 'http://s.mappoint.net/mappoint-30/', 'LatLongRectangle');
  RemClassRegistry.RegisterXSClass(Address, 'http://s.mappoint.net/mappoint-30/', 'Address');
  RemClassRegistry.RegisterXSClass(EntityPropertyValue, 'http://s.mappoint.net/mappoint-30/', 'EntityPropertyValue');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Property_), 'http://s.mappoint.net/mappoint-30/', 'Property_', 'Property');
  RemClassRegistry.RegisterXSClass(ArrayOfEntityPropertyValue, 'http://s.mappoint.net/mappoint-30/', 'ArrayOfEntityPropertyValue');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ArrayOfEntityPropertyValue), 'Property_', 'Property');
  RemClassRegistry.RegisterSerializeOptions(ArrayOfEntityPropertyValue, [xoInlineArrays]);
  RemClassRegistry.RegisterXSClass(Entity, 'http://s.mappoint.net/mappoint-30/', 'Entity');
  RemClassRegistry.RegisterXSClass(MapView, 'http://s.mappoint.net/mappoint-30/', 'MapView');
  RemClassRegistry.RegisterXSClass(ViewByBoundingRectangle, 'http://s.mappoint.net/mappoint-30/', 'ViewByBoundingRectangle');
  RemClassRegistry.RegisterXSClass(ViewByHeightWidth, 'http://s.mappoint.net/mappoint-30/', 'ViewByHeightWidth');
  RemClassRegistry.RegisterXSClass(ViewByScale, 'http://s.mappoint.net/mappoint-30/', 'ViewByScale');
  RemClassRegistry.RegisterXSClass(MapViewRepresentations, 'http://s.mappoint.net/mappoint-30/', 'MapViewRepresentations');
  RemClassRegistry.RegisterXSClass(Location, 'http://s.mappoint.net/mappoint-30/', 'Location');
  RemClassRegistry.RegisterXSClass(FindResult, 'http://s.mappoint.net/mappoint-30/', 'FindResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfFindResult), 'http://s.mappoint.net/mappoint-30/', 'ArrayOfFindResult');
  RemClassRegistry.RegisterXSClass(FindResults, 'http://s.mappoint.net/mappoint-30/', 'FindResults');
  RemClassRegistry.RegisterXSClass(MimeData, 'http://s.mappoint.net/mappoint-30/', 'MimeData');
  RemClassRegistry.RegisterXSClass(PixelRectangle, 'http://s.mappoint.net/mappoint-30/', 'PixelRectangle');
  RemClassRegistry.RegisterXSClass(HotArea, 'http://s.mappoint.net/mappoint-30/', 'HotArea');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfHotArea), 'http://s.mappoint.net/mappoint-30/', 'ArrayOfHotArea');
  RemClassRegistry.RegisterXSClass(MapImage, 'http://s.mappoint.net/mappoint-30/', 'MapImage');

end. 