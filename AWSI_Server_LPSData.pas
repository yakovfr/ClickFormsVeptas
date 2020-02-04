// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme/secure/ws/awsi/LpsDataServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (9/9/2013 7:07:38 AM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_LPSData;

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
  // !:float           - "http://www.w3.org/2001/XMLSchema"
  // !:integer         - "http://www.w3.org/2001/XMLSchema"

  clsUserCredentials   = class;                 { "http://carme/secure/ws/WSDL" }
  clsCircle            = class;                 { "http://carme/secure/ws/WSDL" }
  clsPointItem         = class;                 { "http://carme/secure/ws/WSDL" }
  clsShapeItem         = class;                 { "http://carme/secure/ws/WSDL" }
  clsCompsRequest      = class;                 { "http://carme/secure/ws/WSDL" }
  clsResults           = class;                 { "http://carme/secure/ws/WSDL" }
  clsSaleHistoryItem   = class;                 { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponseData = class;       { "http://carme/secure/ws/WSDL" }
  clsAcknowledgementResponse = class;           { "http://carme/secure/ws/WSDL" }
  clsSubjectProperty   = class;                 { "http://carme/secure/ws/WSDL" }
  clsXml178Data        = class;                 { "http://carme/secure/ws/WSDL" }
  clsGetSubjectInformation = class;             { "http://carme/secure/ws/WSDL" }
  clsGetSubjectInformationResponse = class;     { "http://carme/secure/ws/WSDL" }
  clsXml179Data        = class;                 { "http://carme/secure/ws/WSDL" }
  clsNeighborhoodCompsCount = class;            { "http://carme/secure/ws/WSDL" }
  clsGetNeighborhoodCompsCountResponse = class;   { "http://carme/secure/ws/WSDL" }
  clsCompsRecord177ArrayItem = class;           { "http://carme/secure/ws/WSDL" }
  clsXml174Data        = class;                 { "http://carme/secure/ws/WSDL" }
  clsGetStandardComps  = class;                 { "http://carme/secure/ws/WSDL" }
  clsGetStandardCompsResponse = class;          { "http://carme/secure/ws/WSDL" }
  clsCompsRecords      = class;                 { "http://carme/secure/ws/WSDL" }
  clsXml177Data        = class;                 { "http://carme/secure/ws/WSDL" }
  clsGet50NeighborhoodComps = class;            { "http://carme/secure/ws/WSDL" }
  clsGet50NeighborhoodCompsResponse = class;    { "http://carme/secure/ws/WSDL" }
  clsXml175Data        = class;                 { "http://carme/secure/ws/WSDL" }
  clsGetNeighborhoodComps500 = class;           { "http://carme/secure/ws/WSDL" }
  clsGetNeighborhoodComps500Response = class;   { "http://carme/secure/ws/WSDL" }
  clsGetUsageAvailabilityData = class;          { "http://carme/secure/ws/WSDL" }
  clsGetUsageAvailabilityResponse = class;      { "http://carme/secure/ws/WSDL" }
  clsAcknowledgement   = class;                 { "http://carme/secure/ws/WSDL" }
  clsGetSubjectInformationRequest = class;      { "http://carme/secure/ws/WSDL" }
  clsGetNeighborhoodCompsCountRequest = class;   { "http://carme/secure/ws/WSDL" }
  clsGetStandardCompsRequest = class;           { "http://carme/secure/ws/WSDL" }
  clsGet50NeighborhoodCompsRequest = class;     { "http://carme/secure/ws/WSDL" }
  clsGetNeighborhoodComps500Request = class;    { "http://carme/secure/ws/WSDL" }
  clsUsageAccessCredentials = class;            { "http://carme/secure/ws/WSDL" }



  // ************************************************************************ //
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
  published
    property Username: WideString read FUsername write FUsername;
    property Password: WideString read FPassword write FPassword;
    property CompanyKey: WideString read FCompanyKey write FCompanyKey;
    property OrderNumberKey: WideString read FOrderNumberKey write FOrderNumberKey;
    property Purchase: Integer read FPurchase write FPurchase;
    property CustomerOrderNumber: WideString read FCustomerOrderNumber write FCustomerOrderNumber;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsCircle = class(TRemotable)
  private
    FLongitude: Single;
    FLatitude: Single;
    Fradius: Single;
  published
    property Longitude: Single read FLongitude write FLongitude;
    property Latitude: Single read FLatitude write FLatitude;
    property radius: Single read Fradius write Fradius;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsPointItem = class(TRemotable)
  private
    FLongitude: Single;
    FLatitude: Single;
  published
    property Longitude: Single read FLongitude write FLongitude;
    property Latitude: Single read FLatitude write FLatitude;
  end;

  clsPointsArray = array of clsPointItem;       { "http://carme/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsShapeItem = class(TRemotable)
  private
    FCircle: clsCircle;
    FPoints: clsPointsArray;
  public
    destructor Destroy; override;
  published
    property Circle: clsCircle read FCircle write FCircle;
    property Points: clsPointsArray read FPoints write FPoints;
  end;

  clsShapesArray = array of clsShapeItem;       { "http://carme/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsCompsRequest = class(TRemotable)
  private
    FNumComps: integer;
    FShapes: clsShapesArray;
    FStartDate: WideString;
    FEndDate: WideString;
  public
    destructor Destroy; override;
  published
    property NumComps: integer read FNumComps write FNumComps;
    property Shapes: clsShapesArray read FShapes write FShapes;
    property StartDate: WideString read FStartDate write FStartDate;
    property EndDate: WideString read FEndDate write FEndDate;
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
  clsSaleHistoryItem = class(TRemotable)
  private
    FBuyer1FirstName: WideString;
    FBuyer1LastName: WideString;
    FBuyer2FirstName: WideString;
    FBuyer2LastName: WideString;
    FSeller1FirstName: WideString;
    FSeller1LastName: WideString;
    FSeller2FirstName: WideString;
    FSeller2LastName: WideString;
    FDeedType: WideString;
    FSalePrice: WideString;
    FSaleDate: WideString;
    FREOFlag: WideString;
  published
    property Buyer1FirstName: WideString read FBuyer1FirstName write FBuyer1FirstName;
    property Buyer1LastName: WideString read FBuyer1LastName write FBuyer1LastName;
    property Buyer2FirstName: WideString read FBuyer2FirstName write FBuyer2FirstName;
    property Buyer2LastName: WideString read FBuyer2LastName write FBuyer2LastName;
    property Seller1FirstName: WideString read FSeller1FirstName write FSeller1FirstName;
    property Seller1LastName: WideString read FSeller1LastName write FSeller1LastName;
    property Seller2FirstName: WideString read FSeller2FirstName write FSeller2FirstName;
    property Seller2LastName: WideString read FSeller2LastName write FSeller2LastName;
    property DeedType: WideString read FDeedType write FDeedType;
    property SalePrice: WideString read FSalePrice write FSalePrice;
    property SaleDate: WideString read FSaleDate write FSaleDate;
    property REOFlag: WideString read FREOFlag write FREOFlag;
  end;

  clsSalesHistory = array of clsSaleHistoryItem;   { "http://carme/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsAcknowledgementResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsAcknowledgementResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsSubjectProperty = class(TRemotable)
  private
    FAddress: WideString;
    FAPN: WideString;
    FAssessedImproveValue: WideString;
    FAssessedLandValue: WideString;
    FAssessmentYear: WideString;
    FBasement: WideString;
    FBasementFinish: WideString;
    FBath: WideString;
    FBedrooms: WideString;
    FBriefLegalDescription: WideString;
    FCensusTract: WideString;
    FCity: WideString;
    FCounty: WideString;
    FDesignStyle: WideString;
    FFireplace: WideString;
    FGarage: WideString;
    FGarageNum: WideString;
    FGarageType: WideString;
    FGLA: WideString;
    FLatitude: WideString;
    FLongitude: WideString;
    FLotSize: WideString;
    FOwner: WideString;
    FPool: WideString;
    FState: WideString;
    FStories: WideString;
    FSubdivisionName: WideString;
    FTaxes: WideString;
    FTaxYear: WideString;
    FTotalAssessedValue: WideString;
    FTotalRooms: WideString;
    FUseCode: WideString;
    FYearBuilt: WideString;
    FZip: WideString;
    FZip4: WideString;
    FSalesHistory: clsSalesHistory;
  public
    destructor Destroy; override;
  published
    property Address: WideString read FAddress write FAddress;
    property APN: WideString read FAPN write FAPN;
    property AssessedImproveValue: WideString read FAssessedImproveValue write FAssessedImproveValue;
    property AssessedLandValue: WideString read FAssessedLandValue write FAssessedLandValue;
    property AssessmentYear: WideString read FAssessmentYear write FAssessmentYear;
    property Basement: WideString read FBasement write FBasement;
    property BasementFinish: WideString read FBasementFinish write FBasementFinish;
    property Bath: WideString read FBath write FBath;
    property Bedrooms: WideString read FBedrooms write FBedrooms;
    property BriefLegalDescription: WideString read FBriefLegalDescription write FBriefLegalDescription;
    property CensusTract: WideString read FCensusTract write FCensusTract;
    property City: WideString read FCity write FCity;
    property County: WideString read FCounty write FCounty;
    property DesignStyle: WideString read FDesignStyle write FDesignStyle;
    property Fireplace: WideString read FFireplace write FFireplace;
    property Garage: WideString read FGarage write FGarage;
    property GarageNum: WideString read FGarageNum write FGarageNum;
    property GarageType: WideString read FGarageType write FGarageType;
    property GLA: WideString read FGLA write FGLA;
    property Latitude: WideString read FLatitude write FLatitude;
    property Longitude: WideString read FLongitude write FLongitude;
    property LotSize: WideString read FLotSize write FLotSize;
    property Owner: WideString read FOwner write FOwner;
    property Pool: WideString read FPool write FPool;
    property State: WideString read FState write FState;
    property Stories: WideString read FStories write FStories;
    property SubdivisionName: WideString read FSubdivisionName write FSubdivisionName;
    property Taxes: WideString read FTaxes write FTaxes;
    property TaxYear: WideString read FTaxYear write FTaxYear;
    property TotalAssessedValue: WideString read FTotalAssessedValue write FTotalAssessedValue;
    property TotalRooms: WideString read FTotalRooms write FTotalRooms;
    property UseCode: WideString read FUseCode write FUseCode;
    property YearBuilt: WideString read FYearBuilt write FYearBuilt;
    property Zip: WideString read FZip write FZip;
    property Zip4: WideString read FZip4 write FZip4;
    property SalesHistory: clsSalesHistory read FSalesHistory write FSalesHistory;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsXml178Data = class(TRemotable)
  private
    FDateTimeStamp: WideString;
    FErrorMsg: WideString;
    FOrderGUID: WideString;
    FStatus: WideString;
    FSubjectProperty: clsSubjectProperty;
  public
    destructor Destroy; override;
  published
    property DateTimeStamp: WideString read FDateTimeStamp write FDateTimeStamp;
    property ErrorMsg: WideString read FErrorMsg write FErrorMsg;
    property OrderGUID: WideString read FOrderGUID write FOrderGUID;
    property Status: WideString read FStatus write FStatus;
    property SubjectProperty: clsSubjectProperty read FSubjectProperty write FSubjectProperty;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSubjectInformation = class(TRemotable)
  private
    FXml178Data: clsXml178Data;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Xml178Data: clsXml178Data read FXml178Data write FXml178Data;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSubjectInformationResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetSubjectInformation;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetSubjectInformation read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsXml179Data = class(TRemotable)
  private
    FDateTimeStamp: WideString;
    FErrorMsg: WideString;
    FOrderGUID: WideString;
    FStatus: WideString;
    FTotalProperties: WideString;
  published
    property DateTimeStamp: WideString read FDateTimeStamp write FDateTimeStamp;
    property ErrorMsg: WideString read FErrorMsg write FErrorMsg;
    property OrderGUID: WideString read FOrderGUID write FOrderGUID;
    property Status: WideString read FStatus write FStatus;
    property TotalProperties: WideString read FTotalProperties write FTotalProperties;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsNeighborhoodCompsCount = class(TRemotable)
  private
    FXml179Data: clsXml179Data;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Xml179Data: clsXml179Data read FXml179Data write FXml179Data;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNeighborhoodCompsCountResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsNeighborhoodCompsCount;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsNeighborhoodCompsCount read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsCompsRecord177ArrayItem = class(TRemotable)
  private
    FProximity: WideString;
    FSiteAddress: WideString;
    FSiteUnit: WideString;
    FSiteUnitType: WideString;
    FSiteCity: WideString;
    FSiteState: WideString;
    FSiteZip: WideString;
    FSiteZip4: WideString;
    FRecordingDate: WideString;
    FSalePrice: WideString;
    FAssessmentValue: WideString;
    FPriceperSquareFoot: WideString;
    FBuildingArea: WideString;
    FTotalRooms: WideString;
    FBedrooms: WideString;
    FBaths: WideString;
    FYearBuilt: WideString;
    FLotSize: WideString;
    FPool: WideString;
    FFireplace: WideString;
    FAPN: WideString;
    FDocumentNumber: WideString;
    FDocumentType: WideString;
    FPriceCode: WideString;
    FUseCodeDescription: WideString;
    FLotCode: WideString;
    FLotNumber: WideString;
    FBlock: WideString;
    FSection: WideString;
    FDistrict: WideString;
    FLandLot: WideString;
    FUnit_: WideString;
    FCityMunicipalityTownship: WideString;
    FSubdivisionName: WideString;
    FPhaseNumber: WideString;
    FTractNumber: WideString;
    FLegalBriefDescription: WideString;
    FSectionTownshipRangeMeridian: WideString;
    FMapReference: WideString;
    FGarageType: WideString;
    FGarageNums: WideString;
    FCounty: WideString;
    FTaxes: WideString;
    FTaxYear: WideString;
    FLatitude: WideString;
    FLongitude: WideString;
    FBasementFinished: WideString;
    FCensusTract: WideString;
    FBasement: WideString;
    FDesign: WideString;
    FSalesHistory: clsSalesHistory;
  public
    destructor Destroy; override;
  published
    property Proximity: WideString read FProximity write FProximity;
    property SiteAddress: WideString read FSiteAddress write FSiteAddress;
    property SiteUnit: WideString read FSiteUnit write FSiteUnit;
    property SiteUnitType: WideString read FSiteUnitType write FSiteUnitType;
    property SiteCity: WideString read FSiteCity write FSiteCity;
    property SiteState: WideString read FSiteState write FSiteState;
    property SiteZip: WideString read FSiteZip write FSiteZip;
    property SiteZip4: WideString read FSiteZip4 write FSiteZip4;
    property RecordingDate: WideString read FRecordingDate write FRecordingDate;
    property SalePrice: WideString read FSalePrice write FSalePrice;
    property AssessmentValue: WideString read FAssessmentValue write FAssessmentValue;
    property PriceperSquareFoot: WideString read FPriceperSquareFoot write FPriceperSquareFoot;
    property BuildingArea: WideString read FBuildingArea write FBuildingArea;
    property TotalRooms: WideString read FTotalRooms write FTotalRooms;
    property Bedrooms: WideString read FBedrooms write FBedrooms;
    property Baths: WideString read FBaths write FBaths;
    property YearBuilt: WideString read FYearBuilt write FYearBuilt;
    property LotSize: WideString read FLotSize write FLotSize;
    property Pool: WideString read FPool write FPool;
    property Fireplace: WideString read FFireplace write FFireplace;
    property APN: WideString read FAPN write FAPN;
    property DocumentNumber: WideString read FDocumentNumber write FDocumentNumber;
    property DocumentType: WideString read FDocumentType write FDocumentType;
    property PriceCode: WideString read FPriceCode write FPriceCode;
    property UseCodeDescription: WideString read FUseCodeDescription write FUseCodeDescription;
    property LotCode: WideString read FLotCode write FLotCode;
    property LotNumber: WideString read FLotNumber write FLotNumber;
    property Block: WideString read FBlock write FBlock;
    property Section: WideString read FSection write FSection;
    property District: WideString read FDistrict write FDistrict;
    property LandLot: WideString read FLandLot write FLandLot;
    property Unit_: WideString read FUnit_ write FUnit_;
    property CityMunicipalityTownship: WideString read FCityMunicipalityTownship write FCityMunicipalityTownship;
    property SubdivisionName: WideString read FSubdivisionName write FSubdivisionName;
    property PhaseNumber: WideString read FPhaseNumber write FPhaseNumber;
    property TractNumber: WideString read FTractNumber write FTractNumber;
    property LegalBriefDescription: WideString read FLegalBriefDescription write FLegalBriefDescription;
    property SectionTownshipRangeMeridian: WideString read FSectionTownshipRangeMeridian write FSectionTownshipRangeMeridian;
    property MapReference: WideString read FMapReference write FMapReference;
    property GarageType: WideString read FGarageType write FGarageType;
    property GarageNums: WideString read FGarageNums write FGarageNums;
    property County: WideString read FCounty write FCounty;
    property Taxes: WideString read FTaxes write FTaxes;
    property TaxYear: WideString read FTaxYear write FTaxYear;
    property Latitude: WideString read FLatitude write FLatitude;
    property Longitude: WideString read FLongitude write FLongitude;
    property BasementFinished: WideString read FBasementFinished write FBasementFinished;
    property CensusTract: WideString read FCensusTract write FCensusTract;
    property Basement: WideString read FBasement write FBasement;
    property Design: WideString read FDesign write FDesign;
    property SalesHistory: clsSalesHistory read FSalesHistory write FSalesHistory;
  end;

  clsCompsRecord = array of clsCompsRecord177ArrayItem;   { "http://carme/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsXml174Data = class(TRemotable)
  private
    FDateTimeStamp: WideString;
    FErrorMsg: WideString;
    FOrderGUID: WideString;
    FStatus: WideString;
    FCompsRecords: clsCompsRecord;
  public
    destructor Destroy; override;
  published
    property DateTimeStamp: WideString read FDateTimeStamp write FDateTimeStamp;
    property ErrorMsg: WideString read FErrorMsg write FErrorMsg;
    property OrderGUID: WideString read FOrderGUID write FOrderGUID;
    property Status: WideString read FStatus write FStatus;
    property CompsRecords: clsCompsRecord read FCompsRecords write FCompsRecords;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetStandardComps = class(TRemotable)
  private
    FXml179Data: clsXml174Data;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Xml179Data: clsXml174Data read FXml179Data write FXml179Data;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetStandardCompsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetStandardComps;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetStandardComps read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsCompsRecords = class(TRemotable)
  private
    FCompsRecord: clsCompsRecord;
  public
    destructor Destroy; override;
  published
    property CompsRecord: clsCompsRecord read FCompsRecord write FCompsRecord;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsXml177Data = class(TRemotable)
  private
    FDateTimeStamp: WideString;
    FErrorMsg: WideString;
    FOrderGUID: WideString;
    FStatus: WideString;
    FCompsRecords: clsCompsRecords;
  public
    destructor Destroy; override;
  published
    property DateTimeStamp: WideString read FDateTimeStamp write FDateTimeStamp;
    property ErrorMsg: WideString read FErrorMsg write FErrorMsg;
    property OrderGUID: WideString read FOrderGUID write FOrderGUID;
    property Status: WideString read FStatus write FStatus;
    property CompsRecords: clsCompsRecords read FCompsRecords write FCompsRecords;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGet50NeighborhoodComps = class(TRemotable)
  private
    FXml177Data: clsXml177Data;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Xml177Data: clsXml177Data read FXml177Data write FXml177Data;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGet50NeighborhoodCompsResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGet50NeighborhoodComps;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGet50NeighborhoodComps read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsXml175Data = class(TRemotable)
  private
    FDateTimeStamp: WideString;
    FErrorMsg: WideString;
    FOrderGUID: WideString;
    FStatus: WideString;
    FOutputURL: WideString;
  published
    property DateTimeStamp: WideString read FDateTimeStamp write FDateTimeStamp;
    property ErrorMsg: WideString read FErrorMsg write FErrorMsg;
    property OrderGUID: WideString read FOrderGUID write FOrderGUID;
    property Status: WideString read FStatus write FStatus;
    property OutputURL: WideString read FOutputURL write FOutputURL;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNeighborhoodComps500 = class(TRemotable)
  private
    FXml175Data: clsXml175Data;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property Xml175Data: clsXml175Data read FXml175Data write FXml175Data;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNeighborhoodComps500Response = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetNeighborhoodComps500;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetNeighborhoodComps500 read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityData = class(TRemotable)
  private
    FServiceName: WideString;
    FWebServiceId: Integer;
    FProductAvailable: WideString;
    FMessage: WideString;
    FExpirationDate: WideString;
    FAppraiserQuantity: Integer;
    FOwnerQuantity: Integer;
  published
    property ServiceName: WideString read FServiceName write FServiceName;
    property WebServiceId: Integer read FWebServiceId write FWebServiceId;
    property ProductAvailable: WideString read FProductAvailable write FProductAvailable;
    property Message: WideString read FMessage write FMessage;
    property ExpirationDate: WideString read FExpirationDate write FExpirationDate;
    property AppraiserQuantity: Integer read FAppraiserQuantity write FAppraiserQuantity;
    property OwnerQuantity: Integer read FOwnerQuantity write FOwnerQuantity;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetUsageAvailabilityResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsGetUsageAvailabilityData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsGetUsageAvailabilityData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgement = class(TRemotable)
  private
    FReceived: Integer;
    FServiceAcknowledgement: WideString;
  published
    property Received: Integer read FReceived write FReceived;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetSubjectInformationRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FOwnerName: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property OwnerName: WideString read FOwnerName write FOwnerName;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNeighborhoodCompsCountRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FOwnerName: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property OwnerName: WideString read FOwnerName write FOwnerName;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetStandardCompsRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FOwnerName: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property OwnerName: WideString read FOwnerName write FOwnerName;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGet50NeighborhoodCompsRequest = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FOwnerName: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property OwnerName: WideString read FOwnerName write FOwnerName;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsGetNeighborhoodComps500Request = class(TRemotable)
  private
    FStreetAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FOwnerName: WideString;
  published
    property StreetAddress: WideString read FStreetAddress write FStreetAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property OwnerName: WideString read FOwnerName write FOwnerName;
  end;



  // ************************************************************************ //
  // Namespace : http://carme/secure/ws/WSDL
  // ************************************************************************ //
  clsUsageAccessCredentials = class(TRemotable)
  private
    FCustomerId: Integer;
    FServiceId: WideString;
  published
    property CustomerId: Integer read FCustomerId write FCustomerId;
    property ServiceId: WideString read FServiceId write FServiceId;
  end;


  // ************************************************************************ //
  // Namespace : LpsDataServerClass
  // soapAction: LpsDataServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : LpsDataServerBinding
  // service   : LpsDataServer
  // port      : LpsDataServerPort
  // URL       : http://carme/secure/ws/awsi/LpsDataServer.php
  // ************************************************************************ //
  LpsDataServerPortType = interface(IInvokable)
  ['{0B448D1B-BBAA-CF9C-546A-061A615209F5}']
    function  LpsDataService_GetUsageAvailability(const UsageAccessCredentials: clsUsageAccessCredentials): clsGetUsageAvailabilityResponse; stdcall;
    function  LpsDataService_GetSubjectInformation(const UserCredentials: clsUserCredentials; const AddressSearch: clsGetSubjectInformationRequest): clsGetSubjectInformationResponse; stdcall;
    function  LpsDataService_GetNeighborhoodCompsCount(const UserCredentials: clsUserCredentials; const AddressSearch: clsGetNeighborhoodCompsCountRequest; const CompsRequest: clsCompsRequest): clsGetNeighborhoodCompsCountResponse; stdcall;
    function  LpsDataService_GetStandardComps(const UserCredentials: clsUserCredentials; const AddressSearch: clsGetStandardCompsRequest; const CompsRequest: clsCompsRequest): clsGetStandardCompsResponse; stdcall;
    function  LpsDataService_Get50NeighborhoodComps(const UserCredentials: clsUserCredentials; const AddressSearch: clsGet50NeighborhoodCompsRequest; const CompsRequest: clsCompsRequest): clsGet50NeighborhoodCompsResponse; stdcall;
    function  LpsDataService_GetNeighborhoodComps500(const UserCredentials: clsUserCredentials; const AddressSearch: clsGetNeighborhoodComps500Request; const CompsRequest: clsCompsRequest): clsGetNeighborhoodComps500Response; stdcall;
    function  LpsDataService_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetLpsDataServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): LpsDataServerPortType;


implementation

function GetLpsDataServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): LpsDataServerPortType;
const
  defWSDL = 'http://carme/secure/ws/awsi/LpsDataServer.php?wsdl';
  defURL  = 'http://carme/secure/ws/awsi/LpsDataServer.php';
  defSvc  = 'LpsDataServer';
  defPrt  = 'LpsDataServerPort';
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
    Result := (RIO as LpsDataServerPortType);
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


destructor clsShapeItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FPoints)-1 do
    if Assigned(FPoints[I]) then
      FPoints[I].Free;
  SetLength(FPoints, 0);
  if Assigned(FCircle) then
    FCircle.Free;
  inherited Destroy;
end;

destructor clsCompsRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FShapes)-1 do
    if Assigned(FShapes[I]) then
      FShapes[I].Free;
  SetLength(FShapes, 0);
  inherited Destroy;
end;

destructor clsAcknowledgementResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsSubjectProperty.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FSalesHistory)-1 do
    if Assigned(FSalesHistory[I]) then
      FSalesHistory[I].Free;
  SetLength(FSalesHistory, 0);
  inherited Destroy;
end;

destructor clsXml178Data.Destroy;
begin
  if Assigned(FSubjectProperty) then
    FSubjectProperty.Free;
  inherited Destroy;
end;

destructor clsGetSubjectInformation.Destroy;
begin
  if Assigned(FXml178Data) then
    FXml178Data.Free;
  inherited Destroy;
end;

destructor clsGetSubjectInformationResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsNeighborhoodCompsCount.Destroy;
begin
  if Assigned(FXml179Data) then
    FXml179Data.Free;
  inherited Destroy;
end;

destructor clsGetNeighborhoodCompsCountResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsCompsRecord177ArrayItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FSalesHistory)-1 do
    if Assigned(FSalesHistory[I]) then
      FSalesHistory[I].Free;
  SetLength(FSalesHistory, 0);
  inherited Destroy;
end;

destructor clsXml174Data.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FCompsRecords)-1 do
    if Assigned(FCompsRecords[I]) then
      FCompsRecords[I].Free;
  SetLength(FCompsRecords, 0);
  inherited Destroy;
end;

destructor clsGetStandardComps.Destroy;
begin
  if Assigned(FXml179Data) then
    FXml179Data.Free;
  inherited Destroy;
end;

destructor clsGetStandardCompsResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsCompsRecords.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FCompsRecord)-1 do
    if Assigned(FCompsRecord[I]) then
      FCompsRecord[I].Free;
  SetLength(FCompsRecord, 0);
  inherited Destroy;
end;

destructor clsXml177Data.Destroy;
begin
  if Assigned(FCompsRecords) then
    FCompsRecords.Free;
  inherited Destroy;
end;

destructor clsGet50NeighborhoodComps.Destroy;
begin
  if Assigned(FXml177Data) then
    FXml177Data.Free;
  inherited Destroy;
end;

destructor clsGet50NeighborhoodCompsResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetNeighborhoodComps500.Destroy;
begin
  if Assigned(FXml175Data) then
    FXml175Data.Free;
  inherited Destroy;
end;

destructor clsGetNeighborhoodComps500Response.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsGetUsageAvailabilityResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(LpsDataServerPortType), 'LpsDataServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(LpsDataServerPortType), 'LpsDataServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_GetUsageAvailability', 'LpsDataService.GetUsageAvailability');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_GetSubjectInformation', 'LpsDataService.GetSubjectInformation');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_GetNeighborhoodCompsCount', 'LpsDataService.GetNeighborhoodCompsCount');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_GetStandardComps', 'LpsDataService.GetStandardComps');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_Get50NeighborhoodComps', 'LpsDataService.Get50NeighborhoodComps');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_GetNeighborhoodComps500', 'LpsDataService.GetNeighborhoodComps500');
  InvRegistry.RegisterExternalMethName(TypeInfo(LpsDataServerPortType), 'LpsDataService_Acknowledgement', 'LpsDataService.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://carme/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsCircle, 'http://carme/secure/ws/WSDL', 'clsCircle');
  RemClassRegistry.RegisterXSClass(clsPointItem, 'http://carme/secure/ws/WSDL', 'clsPointItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsPointsArray), 'http://carme/secure/ws/WSDL', 'clsPointsArray');
  RemClassRegistry.RegisterXSClass(clsShapeItem, 'http://carme/secure/ws/WSDL', 'clsShapeItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsShapesArray), 'http://carme/secure/ws/WSDL', 'clsShapesArray');
  RemClassRegistry.RegisterXSClass(clsCompsRequest, 'http://carme/secure/ws/WSDL', 'clsCompsRequest');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsSaleHistoryItem, 'http://carme/secure/ws/WSDL', 'clsSaleHistoryItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsSalesHistory), 'http://carme/secure/ws/WSDL', 'clsSalesHistory');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://carme/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsSubjectProperty, 'http://carme/secure/ws/WSDL', 'clsSubjectProperty');
  RemClassRegistry.RegisterXSClass(clsXml178Data, 'http://carme/secure/ws/WSDL', 'clsXml178Data');
  RemClassRegistry.RegisterXSClass(clsGetSubjectInformation, 'http://carme/secure/ws/WSDL', 'clsGetSubjectInformation');
  RemClassRegistry.RegisterXSClass(clsGetSubjectInformationResponse, 'http://carme/secure/ws/WSDL', 'clsGetSubjectInformationResponse');
  RemClassRegistry.RegisterXSClass(clsXml179Data, 'http://carme/secure/ws/WSDL', 'clsXml179Data');
  RemClassRegistry.RegisterXSClass(clsNeighborhoodCompsCount, 'http://carme/secure/ws/WSDL', 'clsNeighborhoodCompsCount');
  RemClassRegistry.RegisterXSClass(clsGetNeighborhoodCompsCountResponse, 'http://carme/secure/ws/WSDL', 'clsGetNeighborhoodCompsCountResponse');
  RemClassRegistry.RegisterXSClass(clsCompsRecord177ArrayItem, 'http://carme/secure/ws/WSDL', 'clsCompsRecord177ArrayItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsCompsRecord177ArrayItem), 'Unit_', 'Unit');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsCompsRecord), 'http://carme/secure/ws/WSDL', 'clsCompsRecord');
  RemClassRegistry.RegisterXSClass(clsXml174Data, 'http://carme/secure/ws/WSDL', 'clsXml174Data');
  RemClassRegistry.RegisterXSClass(clsGetStandardComps, 'http://carme/secure/ws/WSDL', 'clsGetStandardComps');
  RemClassRegistry.RegisterXSClass(clsGetStandardCompsResponse, 'http://carme/secure/ws/WSDL', 'clsGetStandardCompsResponse');
  RemClassRegistry.RegisterXSClass(clsCompsRecords, 'http://carme/secure/ws/WSDL', 'clsCompsRecords');
  RemClassRegistry.RegisterXSClass(clsXml177Data, 'http://carme/secure/ws/WSDL', 'clsXml177Data');
  RemClassRegistry.RegisterXSClass(clsGet50NeighborhoodComps, 'http://carme/secure/ws/WSDL', 'clsGet50NeighborhoodComps');
  RemClassRegistry.RegisterXSClass(clsGet50NeighborhoodCompsResponse, 'http://carme/secure/ws/WSDL', 'clsGet50NeighborhoodCompsResponse');
  RemClassRegistry.RegisterXSClass(clsXml175Data, 'http://carme/secure/ws/WSDL', 'clsXml175Data');
  RemClassRegistry.RegisterXSClass(clsGetNeighborhoodComps500, 'http://carme/secure/ws/WSDL', 'clsGetNeighborhoodComps500');
  RemClassRegistry.RegisterXSClass(clsGetNeighborhoodComps500Response, 'http://carme/secure/ws/WSDL', 'clsGetNeighborhoodComps500Response');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityData, 'http://carme/secure/ws/WSDL', 'clsGetUsageAvailabilityData');
  RemClassRegistry.RegisterXSClass(clsGetUsageAvailabilityResponse, 'http://carme/secure/ws/WSDL', 'clsGetUsageAvailabilityResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://carme/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsGetSubjectInformationRequest, 'http://carme/secure/ws/WSDL', 'clsGetSubjectInformationRequest');
  RemClassRegistry.RegisterXSClass(clsGetNeighborhoodCompsCountRequest, 'http://carme/secure/ws/WSDL', 'clsGetNeighborhoodCompsCountRequest');
  RemClassRegistry.RegisterXSClass(clsGetStandardCompsRequest, 'http://carme/secure/ws/WSDL', 'clsGetStandardCompsRequest');
  RemClassRegistry.RegisterXSClass(clsGet50NeighborhoodCompsRequest, 'http://carme/secure/ws/WSDL', 'clsGet50NeighborhoodCompsRequest');
  RemClassRegistry.RegisterXSClass(clsGetNeighborhoodComps500Request, 'http://carme/secure/ws/WSDL', 'clsGetNeighborhoodComps500Request');
  RemClassRegistry.RegisterXSClass(clsUsageAccessCredentials, 'http://carme/secure/ws/WSDL', 'clsUsageAccessCredentials');

end.