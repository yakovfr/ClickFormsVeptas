// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://webservices.appraisalworld.com/ws/awsi/FloodInsightsServer.php?wsdl
//  >Import : https://webservices.appraisalworld.com/ws/awsi/FloodInsightsServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (9/26/2017 4:29:47 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit AWSI_Server_FloodInsights;

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
  clsMapRequest        = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmMapInfo         = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmLocationArrayItem = class;               { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmTestResultArrayItem = class;             { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmTestResult2ArrayItem = class;            { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmFeature2ArrayItem = class;               { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmFeatureArrayItem = class;                { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgement   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeRequest = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsFloodInsightsGetMapRequest = class;        { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetRespottedMapRequest = class;            { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsUsageAccessCredentials = class;            { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponse = class;           { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsAcknowledgementResponseData = class;       { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetGeocodeResponse = class;                { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsCDGeoResults      = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsCdCandidateArrayItem = class;              { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsCDGeneral         = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsFloodInsightsGetMapResponse = class;       { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMapResponse    = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsFloodInsightsGetMap2Response = class;      { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMap2Response   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsFloodInsightsGetMap3Response = class;      { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetMap3Response   = class;                 { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetRespottedMapResponse = class;           { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityData = class;          { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsGetUsageAvailabilityResponse = class;      { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsUserCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
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
  // XML       : clsMapRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsMapRequest = class(TRemotable)
  private
    FStreet: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPlus4: WideString;
    FLongitude: Single;
    FLatitude: Single;
    FGeoResult: WideString;
    FCensusBlockId: WideString;
    FMapHeight: Integer;
    FMapWidth: Integer;
    FMapZoom: Single;
    FLocationLabel: WideString;
  published
    property Street:        WideString  read FStreet write FStreet;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
    property Plus4:         WideString  read FPlus4 write FPlus4;
    property Longitude:     Single      read FLongitude write FLongitude;
    property Latitude:      Single      read FLatitude write FLatitude;
    property GeoResult:     WideString  read FGeoResult write FGeoResult;
    property CensusBlockId: WideString  read FCensusBlockId write FCensusBlockId;
    property MapHeight:     Integer     read FMapHeight write FMapHeight;
    property MapWidth:      Integer     read FMapWidth write FMapWidth;
    property MapZoom:       Single      read FMapZoom write FMapZoom;
    property LocationLabel: WideString  read FLocationLabel write FLocationLabel;
  end;



  // ************************************************************************ //
  // XML       : clsRmMapInfo, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmMapInfo = class(TRemotable)
  private
    FLocPtX: Single;
    FLocPtY: Single;
    FCenterX: Single;
    FCenterY: Single;
    FZoom: Single;
    FImageID: WideString;
    FImageURL: WideString;
  published
    property LocPtX:   Single      read FLocPtX write FLocPtX;
    property LocPtY:   Single      read FLocPtY write FLocPtY;
    property CenterX:  Single      read FCenterX write FCenterX;
    property CenterY:  Single      read FCenterY write FCenterY;
    property Zoom:     Single      read FZoom write FZoom;
    property ImageID:  WideString  read FImageID write FImageID;
    property ImageURL: WideString  read FImageURL write FImageURL;
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
  // XML       : clsRmLocationArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmLocationArrayItem = class(TRemotable)
  private
    FMapLabel: WideString;
    FStreet: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPlus4: WideString;
    FCensusBlock: WideString;
  published
    property MapLabel:    WideString  read FMapLabel write FMapLabel;
    property Street:      WideString  read FStreet write FStreet;
    property City:        WideString  read FCity write FCity;
    property State:       WideString  read FState write FState;
    property Zip:         WideString  read FZip write FZip;
    property Plus4:       WideString  read FPlus4 write FPlus4;
    property CensusBlock: WideString  read FCensusBlock write FCensusBlock;
  end;

  clsRmLocationArray = array of clsRmLocationArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsRmTestResultArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmTestResultArrayItem = class(TRemotable)
  private
    FName_: WideString;
    FType_: Integer;
    FSHFA: WideString;
    FNearby: WideString;
    FFzDdPhrase: WideString;
    FCensusTrack: WideString;
  published
    property Name_:       WideString  read FName_ write FName_;
    property Type_:       Integer     read FType_ write FType_;
    property SHFA:        WideString  read FSHFA write FSHFA;
    property Nearby:      WideString  read FNearby write FNearby;
    property FzDdPhrase:  WideString  read FFzDdPhrase write FFzDdPhrase;
    property CensusTrack: WideString  read FCensusTrack write FCensusTrack;
  end;

  clsRmTestResultArray = array of clsRmTestResultArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsRmTestResult2ArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmTestResult2ArrayItem = class(TRemotable)
  private
    FName_: WideString;
    FType_: Integer;
    FSHFA: WideString;
    FNearby: WideString;
    FFzDdPhrase: WideString;
    FCensusTrack: WideString;
    FMapNumber: WideString;
  published
    property Name_:       WideString  read FName_ write FName_;
    property Type_:       Integer     read FType_ write FType_;
    property SHFA:        WideString  read FSHFA write FSHFA;
    property Nearby:      WideString  read FNearby write FNearby;
    property FzDdPhrase:  WideString  read FFzDdPhrase write FFzDdPhrase;
    property CensusTrack: WideString  read FCensusTrack write FCensusTrack;
    property MapNumber:   WideString  read FMapNumber write FMapNumber;
  end;

  clsRmTestResult2Array = array of clsRmTestResult2ArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsRmFeature2ArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmFeature2ArrayItem = class(TRemotable)
  private
    FCommunity: WideString;
    FCommunityName: WideString;
    FZone: WideString;
    FPanel: WideString;
    FPanelDate: WideString;
    FFIPS: WideString;
    FCOBRA: WideString;
  published
    property Community:     WideString  read FCommunity write FCommunity;
    property CommunityName: WideString  read FCommunityName write FCommunityName;
    property Zone:          WideString  read FZone write FZone;
    property Panel:         WideString  read FPanel write FPanel;
    property PanelDate:     WideString  read FPanelDate write FPanelDate;
    property FIPS:          WideString  read FFIPS write FFIPS;
    property COBRA:         WideString  read FCOBRA write FCOBRA;
  end;

  clsRmFeature2Array = array of clsRmFeature2ArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsRmFeatureArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsRmFeatureArrayItem = class(TRemotable)
  private
    FCommunity: WideString;
    FCommunityName: WideString;
    FZone: WideString;
    FPanel: WideString;
    FPanelDate: WideString;
    FFIPS: WideString;
  published
    property Community:     WideString  read FCommunity write FCommunity;
    property CommunityName: WideString  read FCommunityName write FCommunityName;
    property Zone:          WideString  read FZone write FZone;
    property Panel:         WideString  read FPanel write FPanel;
    property PanelDate:     WideString  read FPanelDate write FPanelDate;
    property FIPS:          WideString  read FFIPS write FFIPS;
  end;

  clsRmFeatureArray = array of clsRmFeatureArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }
  clsRmMapInfoArray = array of clsRmMapInfo;    { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsAcknowledgement, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
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
  // XML       : clsGetGeocodeRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPlus4: WideString;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
    property Plus4:         WideString  read FPlus4 write FPlus4;
  end;



  // ************************************************************************ //
  // XML       : clsFloodInsightsGetMapRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsFloodInsightsGetMapRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPlus4: WideString;
    FLatitude: Single;
    FLongitude: Single;
    FGeoResult: WideString;
    FCensusBlockId: WideString;
    FMapHeight: Integer;
    FMapWidth: Integer;
    FMapZoom: Single;
    FLocationLabel: WideString;
  published
    property StreetAddress: WideString  read FStreetAddress write FStreetAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
    property Plus4:         WideString  read FPlus4 write FPlus4;
    property Latitude:      Single      read FLatitude write FLatitude;
    property Longitude:     Single      read FLongitude write FLongitude;
    property GeoResult:     WideString  read FGeoResult write FGeoResult;
    property CensusBlockId: WideString  read FCensusBlockId write FCensusBlockId;
    property MapHeight:     Integer     read FMapHeight write FMapHeight;
    property MapWidth:      Integer     read FMapWidth write FMapWidth;
    property MapZoom:       Single      read FMapZoom write FMapZoom;
    property LocationLabel: WideString  read FLocationLabel write FLocationLabel;
  end;



  // ************************************************************************ //
  // XML       : clsGetRespottedMapRequest, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetRespottedMapRequest = class(TRemotable)
  private
    FMapRequest: clsMapRequest;
    FMapInfo: clsRmMapInfo;
  public
    destructor Destroy; override;
  published
    property MapRequest: clsMapRequest  read FMapRequest write FMapRequest;
    property MapInfo:    clsRmMapInfo   read FMapInfo write FMapInfo;
  end;



  // ************************************************************************ //
  // XML       : clsUsageAccessCredentials, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsUsageAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FServiceId: WideString;
  published
    property CustomerId: Integer     read FCustomerId write FCustomerId;
    property ServiceId:  WideString  read FServiceId write FServiceId;
  end;



  // ************************************************************************ //
  // XML       : clsAcknowledgementResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
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
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer  read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // XML       : clsGetGeocodeResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetGeocodeResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsCDGeoResults;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults       read FResults write FResults;
    property ResponseData: clsCDGeoResults  read FResponseData write FResponseData;
  end;

  clsCdCandidateArray = array of clsCdCandidateArrayItem;   { "http://webservices.appraisalworld.com/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsCDGeoResults, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsCDGeoResults = class(TRemotable)
  private
    FCdCandidates: clsCdCandidateArray;
    FMatchInfo: clsCDGeneral;
  public
    destructor Destroy; override;
  published
    property CdCandidates: clsCdCandidateArray  read FCdCandidates write FCdCandidates;
    property MatchInfo:    clsCDGeneral         read FMatchInfo write FMatchInfo;
  end;



  // ************************************************************************ //
  // XML       : clsCdCandidateArrayItem, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsCdCandidateArrayItem = class(TRemotable)
  private
    FStreet: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FPlus4: WideString;
    FLongitude: Single;
    FLatitude: Single;
    FGeoResult: WideString;
    FFirm: WideString;
    FCensusBlockId: WideString;
    FPrecision: Integer;
  published
    property Street:        WideString  read FStreet write FStreet;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property Zip:           WideString  read FZip write FZip;
    property Plus4:         WideString  read FPlus4 write FPlus4;
    property Longitude:     Single      read FLongitude write FLongitude;
    property Latitude:      Single      read FLatitude write FLatitude;
    property GeoResult:     WideString  read FGeoResult write FGeoResult;
    property Firm:          WideString  read FFirm write FFirm;
    property CensusBlockId: WideString  read FCensusBlockId write FCensusBlockId;
    property Precision:     Integer     read FPrecision write FPrecision;
  end;



  // ************************************************************************ //
  // XML       : clsCDGeneral, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsCDGeneral = class(TRemotable)
  private
    FNumCandidates: Integer;
    FNumCloseCandidates: Integer;
    FStatus: WideString;
    FGeoSource: WideString;
    FGoodCandidate: Boolean;
  published
    property NumCandidates:      Integer     read FNumCandidates write FNumCandidates;
    property NumCloseCandidates: Integer     read FNumCloseCandidates write FNumCloseCandidates;
    property Status:             WideString  read FStatus write FStatus;
    property GeoSource:          WideString  read FGeoSource write FGeoSource;
    property GoodCandidate:      Boolean     read FGoodCandidate write FGoodCandidate;
  end;



  // ************************************************************************ //
  // XML       : clsFloodInsightsGetMapResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsFloodInsightsGetMapResponse = class(TRemotable)
  private
    FLocation: clsRmLocationArray;
    FTestResult: clsRmTestResultArray;
    FFeature: clsRmFeatureArray;
    FMapInfo: clsRmMapInfoArray;
    FMapImage: WideString;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Location:               clsRmLocationArray    read FLocation write FLocation;
    property TestResult:             clsRmTestResultArray  read FTestResult write FTestResult;
    property Feature:                clsRmFeatureArray     read FFeature write FFeature;
    property MapInfo:                clsRmMapInfoArray     read FMapInfo write FMapInfo;
    property MapImage:               WideString            read FMapImage write FMapImage;
    property ServiceAcknowledgement: WideString            read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsGetMapResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMapResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsFloodInsightsGetMapResponse;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsFloodInsightsGetMapResponse  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsFloodInsightsGetMap2Response, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsFloodInsightsGetMap2Response = class(TRemotable)
  private
    FLocation: clsRmLocationArray;
    FTestResult: clsRmTestResultArray;
    FFeature: clsRmFeature2Array;
    FMapInfo: clsRmMapInfoArray;
    FMapImage: WideString;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Location:               clsRmLocationArray    read FLocation write FLocation;
    property TestResult:             clsRmTestResultArray  read FTestResult write FTestResult;
    property Feature:                clsRmFeature2Array    read FFeature write FFeature;
    property MapInfo:                clsRmMapInfoArray     read FMapInfo write FMapInfo;
    property MapImage:               WideString            read FMapImage write FMapImage;
    property ServiceAcknowledgement: WideString            read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsGetMap2Response, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMap2Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsFloodInsightsGetMap2Response;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                       read FResults write FResults;
    property ResponseData: clsFloodInsightsGetMap2Response  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsFloodInsightsGetMap3Response, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsFloodInsightsGetMap3Response = class(TRemotable)
  private
    FLocation: clsRmLocationArray;
    FTestResult: clsRmTestResult2Array;
    FFeature: clsRmFeature2Array;
    FMapInfo: clsRmMapInfoArray;
    FMapImage: WideString;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Location:               clsRmLocationArray     read FLocation write FLocation;
    property TestResult:             clsRmTestResult2Array  read FTestResult write FTestResult;
    property Feature:                clsRmFeature2Array     read FFeature write FFeature;
    property MapInfo:                clsRmMapInfoArray      read FMapInfo write FMapInfo;
    property MapImage:               WideString             read FMapImage write FMapImage;
    property ServiceAcknowledgement: WideString             read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // XML       : clsGetMap3Response, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetMap3Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsFloodInsightsGetMap3Response;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                       read FResults write FResults;
    property ResponseData: clsFloodInsightsGetMap3Response  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetRespottedMapResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetRespottedMapResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsFloodInsightsGetMapResponse;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsFloodInsightsGetMapResponse  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityData, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityData = class(TRemotable)
  private
    FServiceName: WideString;
    FWebServiceId: Integer;
    FProductAvailable: WideString;
    FMessage_: WideString;
    FExpirationDate: WideString;
    FAppraiserQuantity: Integer;
    FOwnerQuantity: Integer;
    FOwnerQuantity_Specified: boolean;
    procedure SetOwnerQuantity(Index: Integer; const AInteger: Integer);
    function  OwnerQuantity_Specified(Index: Integer): boolean;
  published
    property ServiceName:       WideString  read FServiceName write FServiceName;
    property WebServiceId:      Integer     read FWebServiceId write FWebServiceId;
    property ProductAvailable:  WideString  read FProductAvailable write FProductAvailable;
    property Message_:          WideString  read FMessage_ write FMessage_;
    property ExpirationDate:    WideString  read FExpirationDate write FExpirationDate;
    property AppraiserQuantity: Integer     read FAppraiserQuantity write FAppraiserQuantity;
    property OwnerQuantity:     Integer     Index (IS_OPTN) read FOwnerQuantity write SetOwnerQuantity stored OwnerQuantity_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsGetUsageAvailabilityResponse, global, <complexType>
  // Namespace : http://webservices.appraisalworld.com/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilityData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilityData  read FResponseData write FResponseData;
  end;


  // ************************************************************************ //
  // Namespace : FloodInsightsServerClass
  // soapAction: FloodInsightsServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : FloodInsightsServerBinding
  // service   : FloodInsightsServer
  // port      : FloodInsightsServerPort
  // URL       : https://webservices.appraisalworld.com:443/ws/awsi/FloodInsightsServer.php
  // ************************************************************************ //
  FloodInsightsServerPortType = interface(IInvokable)
  ['{13FD2445-0533-571A-388F-100B0F0634D6}']
    function  FloodInsightsService_GetUsageAvailability(const UsageAccessCredentials: clsUsageAccessCredentials): clsGetUsageAvailabilityResponse; stdcall;
    function  FloodInsightsService_GetGeocode(const UserCredentials: clsUserCredentials; const FIGeocodeRequestRec: clsGetGeocodeRequest): clsGetGeocodeResponse; stdcall;
    function  FloodInsightsService_GetMap(const UserCredentials: clsUserCredentials; const FIGetMapRequestRec: clsFloodInsightsGetMapRequest): clsGetMapResponse; stdcall;
    function  FloodInsightsService_GetMap2(const UserCredentials: clsUserCredentials; const FIGetMapRequestRec: clsFloodInsightsGetMapRequest): clsGetMap2Response; stdcall;
    function  FloodInsightsService_GetMap3(const UserCredentials: clsUserCredentials; const FIGetMapRequestRec: clsFloodInsightsGetMapRequest): clsGetMap3Response; stdcall;
    function  FloodInsightsService_GetRespottedMap(const UserCredentials: clsUserCredentials; const FloodInsightsGetRespottedMap: clsGetRespottedMapRequest): clsGetRespottedMapResponse; stdcall;
    function  FloodInsightsService_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetFloodInsightsServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): FloodInsightsServerPortType;


implementation
  uses SysUtils;

function GetFloodInsightsServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): FloodInsightsServerPortType;
const
  defWSDL = 'https://webservices.appraisalworld.com/ws/awsi/FloodInsightsServer.php?wsdl';
  defURL  = 'https://webservices.appraisalworld.com:443/ws/awsi/FloodInsightsServer.php';
  defSvc  = 'FloodInsightsServer';
  defPrt  = 'FloodInsightsServerPort';
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
    Result := (RIO as FloodInsightsServerPortType);
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


procedure clsUserCredentials.SetCustomerOrderNumber(Index: Integer; const AWideString: WideString);
begin
  FCustomerOrderNumber := AWideString;
  FCustomerOrderNumber_Specified := True;
end;

function clsUserCredentials.CustomerOrderNumber_Specified(Index: Integer): boolean;
begin
  Result := FCustomerOrderNumber_Specified;
end;

destructor clsGetRespottedMapRequest.Destroy;
begin
  FreeAndNil(FMapRequest);
  FreeAndNil(FMapInfo);
  inherited Destroy;
end;

destructor clsAcknowledgementResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetGeocodeResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsCDGeoResults.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FCdCandidates)-1 do
    FreeAndNil(FCdCandidates[I]);
  SetLength(FCdCandidates, 0);
  FreeAndNil(FMatchInfo);
  inherited Destroy;
end;

destructor clsFloodInsightsGetMapResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLocation)-1 do
    FreeAndNil(FLocation[I]);
  SetLength(FLocation, 0);
  for I := 0 to Length(FTestResult)-1 do
    FreeAndNil(FTestResult[I]);
  SetLength(FTestResult, 0);
  for I := 0 to Length(FFeature)-1 do
    FreeAndNil(FFeature[I]);
  SetLength(FFeature, 0);
  for I := 0 to Length(FMapInfo)-1 do
    FreeAndNil(FMapInfo[I]);
  SetLength(FMapInfo, 0);
  inherited Destroy;
end;

destructor clsGetMapResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsFloodInsightsGetMap2Response.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLocation)-1 do
    FreeAndNil(FLocation[I]);
  SetLength(FLocation, 0);
  for I := 0 to Length(FTestResult)-1 do
    FreeAndNil(FTestResult[I]);
  SetLength(FTestResult, 0);
  for I := 0 to Length(FFeature)-1 do
    FreeAndNil(FFeature[I]);
  SetLength(FFeature, 0);
  for I := 0 to Length(FMapInfo)-1 do
    FreeAndNil(FMapInfo[I]);
  SetLength(FMapInfo, 0);
  inherited Destroy;
end;

destructor clsGetMap2Response.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsFloodInsightsGetMap3Response.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLocation)-1 do
    FreeAndNil(FLocation[I]);
  SetLength(FLocation, 0);
  for I := 0 to Length(FTestResult)-1 do
    FreeAndNil(FTestResult[I]);
  SetLength(FTestResult, 0);
  for I := 0 to Length(FFeature)-1 do
    FreeAndNil(FFeature[I]);
  SetLength(FFeature, 0);
  for I := 0 to Length(FMapInfo)-1 do
    FreeAndNil(FMapInfo[I]);
  SetLength(FMapInfo, 0);
  inherited Destroy;
end;

destructor clsGetMap3Response.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsGetRespottedMapResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

procedure clsGetUsageAvailabilityData.SetOwnerQuantity(Index: Integer; const AInteger: Integer);
begin
  FOwnerQuantity := AInteger;
  FOwnerQuantity_Specified := True;
end;

function clsGetUsageAvailabilityData.OwnerQuantity_Specified(Index: Integer): boolean;
begin
  Result := FOwnerQuantity_Specified;
end;

destructor clsGetUsageAvailabilityResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetUsageAvailability', 'FloodInsightsService.GetUsageAvailability');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetGeocode', 'FloodInsightsService.GetGeocode');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetMap', 'FloodInsightsService.GetMap');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetMap2', 'FloodInsightsService.GetMap2');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetMap3', 'FloodInsightsService.GetMap3');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_GetRespottedMap', 'FloodInsightsService.GetRespottedMap');
  InvRegistry.RegisterExternalMethName(TypeInfo(FloodInsightsServerPortType), 'FloodInsightsService_Acknowledgement', 'FloodInsightsService.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsMapRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsMapRequest');
  RemClassRegistry.RegisterXSClass(clsRmMapInfo, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmMapInfo');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsRmLocationArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmLocationArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmLocationArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmLocationArray');
  RemClassRegistry.RegisterXSClass(clsRmTestResultArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmTestResultArrayItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsRmTestResultArrayItem), 'Name_', 'Name');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsRmTestResultArrayItem), 'Type_', 'Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmTestResultArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmTestResultArray');
  RemClassRegistry.RegisterXSClass(clsRmTestResult2ArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmTestResult2ArrayItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsRmTestResult2ArrayItem), 'Name_', 'Name');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsRmTestResult2ArrayItem), 'Type_', 'Type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmTestResult2Array), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmTestResult2Array');
  RemClassRegistry.RegisterXSClass(clsRmFeature2ArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmFeature2ArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmFeature2Array), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmFeature2Array');
  RemClassRegistry.RegisterXSClass(clsRmFeatureArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmFeatureArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmFeatureArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmFeatureArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsRmMapInfoArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsRmMapInfoArray');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeRequest');
  RemClassRegistry.RegisterXSClass(clsFloodInsightsGetMapRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsFloodInsightsGetMapRequest');
  RemClassRegistry.RegisterXSClass(clsGetRespottedMapRequest, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetRespottedMapRequest');
  RemClassRegistry.RegisterXSClass(clsUsageAccessCredentials, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsUsageAccessCredentials');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsGetGeocodeResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetGeocodeResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsCdCandidateArray), 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsCdCandidateArray');
  RemClassRegistry.RegisterXSClass(clsCDGeoResults, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsCDGeoResults');
  RemClassRegistry.RegisterXSClass(clsCdCandidateArrayItem, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsCdCandidateArrayItem');
  RemClassRegistry.RegisterXSClass(clsCDGeneral, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsCDGeneral');
  RemClassRegistry.RegisterXSClass(clsFloodInsightsGetMapResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsFloodInsightsGetMapResponse');
  RemClassRegistry.RegisterXSClass(clsGetMapResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMapResponse');
  RemClassRegistry.RegisterXSClass(clsFloodInsightsGetMap2Response, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsFloodInsightsGetMap2Response');
  RemClassRegistry.RegisterXSClass(clsGetMap2Response, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMap2Response');
  RemClassRegistry.RegisterXSClass(clsFloodInsightsGetMap3Response, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsFloodInsightsGetMap3Response');
  RemClassRegistry.RegisterXSClass(clsGetMap3Response, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetMap3Response');
  RemClassRegistry.RegisterXSClass(clsGetRespottedMapResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetRespottedMapResponse');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityData, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetUsageAvailabilityData');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsGetUsageAvailabilityData), 'Message_', 'Message');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityResponse, 'http://webservices.appraisalworld.com/secure/ws/WSDL', 'clsGetUsageAvailabilityResponse');

end.