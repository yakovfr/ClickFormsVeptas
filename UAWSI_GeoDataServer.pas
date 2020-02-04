// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php?wsdl
//  >Import : http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (10/13/2014 4:29:09 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit UAWSI_GeoDataServer;

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
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:float           - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsUserCredentials   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeRequest = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGeoData           = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeResponse = class;                { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeUnrestrictedResponse = class;    { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGeoDataListItem   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeoCodeListResponse = class;            { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGeoDataList2Item  = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeoCodeList2Response = class;           { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeMultiResponse = class;           { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGeoDataMultiList  = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGeoDataMulti      = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeUnrestrictedRequest = class;     { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeListRequestItem = class;         { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsUserCredentials = class(TRemotable)
  private
    FUsername: WideString;
    FPassword: WideString;
  published
    property Username: WideString  read FUsername write FUsername;
    property Password: WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FState_Specified: boolean;
    FZip: WideString;
    FCountry: WideString;
    FCountry_Specified: boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetCountry(Index: Integer; const AWideString: WideString);
    function  Country_Specified(Index: Integer): boolean;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zip:           WideString  read FZip write FZip;
    property Country:       WideString  Index (IS_OPTN) read FCountry write SetCountry stored Country_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
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
  // XML       : clsGeoData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGeoData = class(TRemotable)
  private
    FLatitude: Single;
    FLongitude: Single;
  published
    property Latitude:  Single  read FLatitude write FLatitude;
    property Longitude: Single  read FLongitude write FLongitude;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGeoData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: clsGeoData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeUnrestrictedResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeUnrestrictedResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGeoData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults  read FResults write FResults;
    property ResponseData: clsGeoData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGeoDataListItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGeoDataListItem = class(TRemotable)
  private
    FClientId: Integer;
    FAddress: WideString;
    FGeocodes: clsGeoData;
  public
    destructor Destroy; override;
  published
    property ClientId: Integer     read FClientId write FClientId;
    property Address:  WideString  read FAddress write FAddress;
    property Geocodes: clsGeoData  read FGeocodes write FGeocodes;
  end;

  clsGeoDataListData = array of clsGeoDataListItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGetGeoCodeListResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeoCodeListResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGeoDataListData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults          read FResults write FResults;
    property ResponseData: clsGeoDataListData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGeoDataList2Item, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGeoDataList2Item = class(TRemotable)
  private
    FClientId: Integer;
    FAddress: WideString;
    FGeocodes: clsGeoData;
    FFailed: Integer;
  public
    destructor Destroy; override;
  published
    property ClientId: Integer     read FClientId write FClientId;
    property Address:  WideString  read FAddress write FAddress;
    property Geocodes: clsGeoData  read FGeocodes write FGeocodes;
    property Failed:   Integer     read FFailed write FFailed;
  end;

  clsGeoDataList2Data = array of clsGeoDataList2Item;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGetGeoCodeList2Response, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeoCodeList2Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGeoDataList2Data;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults           read FResults write FResults;
    property ResponseData: clsGeoDataList2Data  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeMultiResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeMultiResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGeoDataMultiList;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults           read FResults write FResults;
    property ResponseData: clsGeoDataMultiList  read FResponseData write FResponseData;
  end;

  clsGeoDataMultiListArray = array of clsGeoDataMulti;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsGeoDataMultiList, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGeoDataMultiList = class(TRemotable)
  private
    FGeoCodeList: clsGeoDataMultiListArray;
  public
    destructor Destroy; override;
  published
    property GeoCodeList: clsGeoDataMultiListArray  read FGeoCodeList write FGeoCodeList;
  end;



  // ************************************************************************ //
  // XML       : clsGeoDataMulti, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGeoDataMulti = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FState_Specified: boolean;
    FZip: WideString;
    FCountry: WideString;
    FGeocodes: clsGeoData;
    FStatus: Boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zip:           WideString  read FZip write FZip;
    property Country:       WideString  read FCountry write FCountry;
    property Geocodes:      clsGeoData  read FGeocodes write FGeocodes;
    property Status:        Boolean     read FStatus write FStatus;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeUnrestrictedRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeUnrestrictedRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FStreetAddress_Specified: boolean;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FZip_Specified: boolean;
    FCountry: WideString;
    FCountry_Specified: boolean;
    procedure SetStreetAddress(Index: Integer; const AWideString: WideString);
    function  StreetAddress_Specified(Index: Integer): boolean;
    procedure SetZip(Index: Integer; const AWideString: WideString);
    function  Zip_Specified(Index: Integer): boolean;
    procedure SetCountry(Index: Integer; const AWideString: WideString);
    function  Country_Specified(Index: Integer): boolean;
  published
    property StreetAddress: WideString  Index (IS_OPTN) read FStreetAddress write SetStreetAddress stored StreetAddress_Specified;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  Index (IS_OPTN) read FZip write SetZip stored Zip_Specified;
    property Country:       WideString  Index (IS_OPTN) read FCountry write SetCountry stored Country_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeListRequestItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeListRequestItem = class(TRemotable)
  private
    FClientId: Integer;
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FState_Specified: boolean;
    FZip: WideString;
    FCountry: WideString;
    FCountry_Specified: boolean;
    procedure SetState(Index: Integer; const AWideString: WideString);
    function  State_Specified(Index: Integer): boolean;
    procedure SetCountry(Index: Integer; const AWideString: WideString);
    function  Country_Specified(Index: Integer): boolean;
  published
    property ClientId:      Integer     read FClientId write FClientId;
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  Index (IS_OPTN) read FState write SetState stored State_Specified;
    property Zip:           WideString  read FZip write FZip;
    property Country:       WideString  Index (IS_OPTN) read FCountry write SetCountry stored Country_Specified;
  end;

  clsGetGeocodeListRequest = array of clsGetGeocodeListRequestItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeMultiRequest = array of clsGetGeocodeRequest;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }

  // ************************************************************************ //
  // Namespace : GeoDataServerClass
  // soapAction: GeoDataServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : GeoDataServerBinding
  // service   : GeoDataServer
  // port      : GeoDataServerPort
  // URL       : http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php
  // ************************************************************************ //
  GeoDataServerPortType = interface(IInvokable)
  ['{E9D76D8D-AD83-05FB-ABFB-E0F805410247}']
    function  GeoDataService_GetGeocode(const UserCredentials: clsUserCredentials; const SearchAddress: clsGetGeocodeRequest): clsGetGeocodeResponse; stdcall;
    function  GeoDataService_GetGeocodeUnrestricted(const UserCredentials: clsUserCredentials; const SearchAddress: clsGetGeocodeUnrestrictedRequest): clsGetGeocodeUnrestrictedResponse; stdcall;
    function  GeoDataService_GetGeoCodeList(const UserCredentials: clsUserCredentials; const SearchAddresses: clsGetGeocodeListRequest): clsGetGeoCodeListResponse; stdcall;
    function  GeoDataService_GetGeoCodeList2(const UserCredentials: clsUserCredentials; const SearchAddresses: clsGetGeocodeListRequest): clsGetGeoCodeList2Response; stdcall;
    function  GeoDataService_GetGeocodeMulti(const UserCredentials: clsUserCredentials; const SearchAddresses: clsGetGeocodeMultiRequest): clsGetGeocodeMultiResponse; stdcall;
  end;

function GetGeoDataServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): GeoDataServerPortType;


implementation
  uses SysUtils;

function GetGeoDataServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): GeoDataServerPortType;
const
  defWSDL = 'http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php?wsdl';
  defURL  = 'http://webservices.appraisalworld.com/secure/ws/awsi/GeoDataServer.php';
  defSvc  = 'GeoDataServer';
  defPrt  = 'GeoDataServerPort';
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
    Result := (RIO as GeoDataServerPortType);
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


procedure clsGetGeocodeRequest.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsGetGeocodeRequest.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsGetGeocodeRequest.SetCountry(Index: Integer; const AWideString: WideString);
begin
  FCountry := AWideString;
  FCountry_Specified := True;
end;

function clsGetGeocodeRequest.Country_Specified(Index: Integer): boolean;
begin
  Result := FCountry_Specified;
end;

destructor clsGetGeocodeResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetGeocodeUnrestrictedResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGeoDataListItem.Destroy;
begin
  FreeAndNil(FGeocodes);
  inherited Destroy;
end;

destructor clsGetGeoCodeListResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResponseData)-1 do
    FreeAndNil(FResponseData[I]);
  SetLength(FResponseData, 0);
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsGeoDataList2Item.Destroy;
begin
  FreeAndNil(FGeocodes);
  inherited Destroy;
end;

destructor clsGetGeoCodeList2Response.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResponseData)-1 do
    FreeAndNil(FResponseData[I]);
  SetLength(FResponseData, 0);
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsGetGeocodeMultiResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGeoDataMultiList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FGeoCodeList)-1 do
    FreeAndNil(FGeoCodeList[I]);
  SetLength(FGeoCodeList, 0);
  inherited Destroy;
end;

destructor clsGeoDataMulti.Destroy;
begin
  FreeAndNil(FGeocodes);
  inherited Destroy;
end;

procedure clsGeoDataMulti.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsGeoDataMulti.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsGetGeocodeUnrestrictedRequest.SetStreetAddress(Index: Integer; const AWideString: WideString);
begin
  FStreetAddress := AWideString;
  FStreetAddress_Specified := True;
end;

function clsGetGeocodeUnrestrictedRequest.StreetAddress_Specified(Index: Integer): boolean;
begin
  Result := FStreetAddress_Specified;
end;

procedure clsGetGeocodeUnrestrictedRequest.SetZip(Index: Integer; const AWideString: WideString);
begin
  FZip := AWideString;
  FZip_Specified := True;
end;

function clsGetGeocodeUnrestrictedRequest.Zip_Specified(Index: Integer): boolean;
begin
  Result := FZip_Specified;
end;

procedure clsGetGeocodeUnrestrictedRequest.SetCountry(Index: Integer; const AWideString: WideString);
begin
  FCountry := AWideString;
  FCountry_Specified := True;
end;

function clsGetGeocodeUnrestrictedRequest.Country_Specified(Index: Integer): boolean;
begin
  Result := FCountry_Specified;
end;

procedure clsGetGeocodeListRequestItem.SetState(Index: Integer; const AWideString: WideString);
begin
  FState := AWideString;
  FState_Specified := True;
end;

function clsGetGeocodeListRequestItem.State_Specified(Index: Integer): boolean;
begin
  Result := FState_Specified;
end;

procedure clsGetGeocodeListRequestItem.SetCountry(Index: Integer; const AWideString: WideString);
begin
  FCountry := AWideString;
  FCountry_Specified := True;
end;

function clsGetGeocodeListRequestItem.Country_Specified(Index: Integer): boolean;
begin
  Result := FCountry_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(GeoDataServerPortType), 'GeoDataServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(GeoDataServerPortType), 'GeoDataServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(GeoDataServerPortType), 'GeoDataService_GetGeocode', 'GeoDataService.GetGeocode');
  InvRegistry.RegisterExternalMethName(TypeInfo(GeoDataServerPortType), 'GeoDataService_GetGeocodeUnrestricted', 'GeoDataService.GetGeocodeUnrestricted');
  InvRegistry.RegisterExternalMethName(TypeInfo(GeoDataServerPortType), 'GeoDataService_GetGeoCodeList', 'GeoDataService.GetGeoCodeList');
  InvRegistry.RegisterExternalMethName(TypeInfo(GeoDataServerPortType), 'GeoDataService_GetGeoCodeList2', 'GeoDataService.GetGeoCodeList2');
  InvRegistry.RegisterExternalMethName(TypeInfo(GeoDataServerPortType), 'GeoDataService_GetGeocodeMulti', 'GeoDataService.GetGeocodeMulti');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeRequest');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsGeoData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoData');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeResponse');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeUnrestrictedResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeUnrestrictedResponse');
  RemClassRegistry.RegisterXSClass(clsGeoDataListItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataListItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGeoDataListData), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataListData');
  RemClassRegistry.RegisterXSClass(clsGetGeoCodeListResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeoCodeListResponse');
  RemClassRegistry.RegisterXSClass(clsGeoDataList2Item, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataList2Item');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGeoDataList2Data), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataList2Data');
  RemClassRegistry.RegisterXSClass(clsGetGeoCodeList2Response, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeoCodeList2Response');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeMultiResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeMultiResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGeoDataMultiListArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataMultiListArray');
  RemClassRegistry.RegisterXSClass(clsGeoDataMultiList, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataMultiList');
  RemClassRegistry.RegisterXSClass(clsGeoDataMulti, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGeoDataMulti');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeUnrestrictedRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeUnrestrictedRequest');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeListRequestItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeListRequestItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGetGeocodeListRequest), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeListRequest');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGetGeocodeMultiRequest), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeMultiRequest');

end.