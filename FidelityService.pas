// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://webservices.bradfordsoftware.com/WSFidelity/FidelityService.asmx?wsdl
// Encoding : utf-8
// Version  : 1.0
// (3/21/2007 5:19:16 PM - 1.33.2.5)
// ************************************************************************ //

unit FidelityService;

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

  FISRequestRec        = class;                 { "http://tempuri.org/" }
  Location             = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  AssessmentInfo       = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  LegalDescriptionInfo = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  Transfer             = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  PriorSale            = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  ComparableSale       = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  ReportResult         = class;                 { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }
  BradfordTechnologiesResult = class;           { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  FISRequestRec = class(TRemotable)
  private
    FszAPN: WideString;
    FszFIPS: WideString;
    FszAddress: WideString;
    FszCity: WideString;
    FszState: WideString;
    FszZip: WideString;
    FszRequestType: WideString;
  published
    property szAPN: WideString read FszAPN write FszAPN;
    property szFIPS: WideString read FszFIPS write FszFIPS;
    property szAddress: WideString read FszAddress write FszAddress;
    property szCity: WideString read FszCity write FszCity;
    property szState: WideString read FszState write FszState;
    property szZip: WideString read FszZip write FszZip;
    property szRequestType: WideString read FszRequestType write FszRequestType;
  end;



  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  Location = class(TRemotable)
  private
    FFIPS: WideString;
    FAPN: WideString;
    FUnitType: WideString;
    FUnitNumber: WideString;
    FAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZip: WideString;
    FZip4: WideString;
  published
    property FIPS: WideString read FFIPS write FFIPS;
    property APN: WideString read FAPN write FAPN;
    property UnitType: WideString read FUnitType write FUnitType;
    property UnitNumber: WideString read FUnitNumber write FUnitNumber;
    property Address: WideString read FAddress write FAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property Zip: WideString read FZip write FZip;
    property Zip4: WideString read FZip4 write FZip4;
  end;

  ArrayOfLocation = array of Location;          { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }


  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  AssessmentInfo = class(TRemotable)
  private
    FSiteAddress: WideString;
    FSiteUnitType: WideString;
    FSiteUnit: WideString;
    FSiteCity: WideString;
    FSiteState: WideString;
    FSiteZip: WideString;
    FSiteZip4: WideString;
    FAPN: WideString;
    FCensusTract: WideString;
    FUseCodeDescription: WideString;
    FZoning: WideString;
    FOwnerName: WideString;
    FOwnerMailUnitType: WideString;
    FOwnerMailUnit: WideString;
    FOwnerMailAddress: WideString;
    FOwnerMailCity: WideString;
    FOwnerMailState: WideString;
    FOwnerMailZip: WideString;
    FOwnerMailZip4: WideString;
    FAssessedLandValue: WideString;
    FAssessedImprovement: WideString;
    FTotalAssessedValue: WideString;
    FMarketLandValue: WideString;
    FMarketImprovementValue: WideString;
    FTotalMarketValue: WideString;
    FTaxRateCodeArea: WideString;
    FTaxAmount: WideString;
    FTaxDelinquentYear: WideString;
    FHomeOwnerExemption: WideString;
    FLotNumber: WideString;
    FLandLot: WideString;
    FBlock: WideString;
    FSection: WideString;
    FDistrict: WideString;
    FUnit_: WideString;
    FCityMuniTwp: WideString;
    FSubdivisionName: WideString;
    FPhaseNumber: WideString;
    FTractNumber: WideString;
    FSecTwpRngMer: WideString;
    FLegalBriefDescription: WideString;
    FMapRef: WideString;
    FLotSize: WideString;
    FLotSizeUnits: WideString;
    FBuildingArea: WideString;
    FYearBuilt: WideString;
    FNumBuildings: WideString;
    FNumUnits: WideString;
    FBedrooms: WideString;
    FBaths: WideString;
    FTotalRooms: WideString;
    FGarageType: WideString;
    FGarageNumCars: WideString;
    FPool: WideString;
    FFirePlace: WideString;
    FImprovedPercentage: WideString;
    FTaxStatus: WideString;
    FHousingTract: WideString;
  published
    property SiteAddress: WideString read FSiteAddress write FSiteAddress;
    property SiteUnitType: WideString read FSiteUnitType write FSiteUnitType;
    property SiteUnit: WideString read FSiteUnit write FSiteUnit;
    property SiteCity: WideString read FSiteCity write FSiteCity;
    property SiteState: WideString read FSiteState write FSiteState;
    property SiteZip: WideString read FSiteZip write FSiteZip;
    property SiteZip4: WideString read FSiteZip4 write FSiteZip4;
    property APN: WideString read FAPN write FAPN;
    property CensusTract: WideString read FCensusTract write FCensusTract;
    property UseCodeDescription: WideString read FUseCodeDescription write FUseCodeDescription;
    property Zoning: WideString read FZoning write FZoning;
    property OwnerName: WideString read FOwnerName write FOwnerName;
    property OwnerMailUnitType: WideString read FOwnerMailUnitType write FOwnerMailUnitType;
    property OwnerMailUnit: WideString read FOwnerMailUnit write FOwnerMailUnit;
    property OwnerMailAddress: WideString read FOwnerMailAddress write FOwnerMailAddress;
    property OwnerMailCity: WideString read FOwnerMailCity write FOwnerMailCity;
    property OwnerMailState: WideString read FOwnerMailState write FOwnerMailState;
    property OwnerMailZip: WideString read FOwnerMailZip write FOwnerMailZip;
    property OwnerMailZip4: WideString read FOwnerMailZip4 write FOwnerMailZip4;
    property AssessedLandValue: WideString read FAssessedLandValue write FAssessedLandValue;
    property AssessedImprovement: WideString read FAssessedImprovement write FAssessedImprovement;
    property TotalAssessedValue: WideString read FTotalAssessedValue write FTotalAssessedValue;
    property MarketLandValue: WideString read FMarketLandValue write FMarketLandValue;
    property MarketImprovementValue: WideString read FMarketImprovementValue write FMarketImprovementValue;
    property TotalMarketValue: WideString read FTotalMarketValue write FTotalMarketValue;
    property TaxRateCodeArea: WideString read FTaxRateCodeArea write FTaxRateCodeArea;
    property TaxAmount: WideString read FTaxAmount write FTaxAmount;
    property TaxDelinquentYear: WideString read FTaxDelinquentYear write FTaxDelinquentYear;
    property HomeOwnerExemption: WideString read FHomeOwnerExemption write FHomeOwnerExemption;
    property LotNumber: WideString read FLotNumber write FLotNumber;
    property LandLot: WideString read FLandLot write FLandLot;
    property Block: WideString read FBlock write FBlock;
    property Section: WideString read FSection write FSection;
    property District: WideString read FDistrict write FDistrict;
    property Unit_: WideString read FUnit_ write FUnit_;
    property CityMuniTwp: WideString read FCityMuniTwp write FCityMuniTwp;
    property SubdivisionName: WideString read FSubdivisionName write FSubdivisionName;
    property PhaseNumber: WideString read FPhaseNumber write FPhaseNumber;
    property TractNumber: WideString read FTractNumber write FTractNumber;
    property SecTwpRngMer: WideString read FSecTwpRngMer write FSecTwpRngMer;
    property LegalBriefDescription: WideString read FLegalBriefDescription write FLegalBriefDescription;
    property MapRef: WideString read FMapRef write FMapRef;
    property LotSize: WideString read FLotSize write FLotSize;
    property LotSizeUnits: WideString read FLotSizeUnits write FLotSizeUnits;
    property BuildingArea: WideString read FBuildingArea write FBuildingArea;
    property YearBuilt: WideString read FYearBuilt write FYearBuilt;
    property NumBuildings: WideString read FNumBuildings write FNumBuildings;
    property NumUnits: WideString read FNumUnits write FNumUnits;
    property Bedrooms: WideString read FBedrooms write FBedrooms;
    property Baths: WideString read FBaths write FBaths;
    property TotalRooms: WideString read FTotalRooms write FTotalRooms;
    property GarageType: WideString read FGarageType write FGarageType;
    property GarageNumCars: WideString read FGarageNumCars write FGarageNumCars;
    property Pool: WideString read FPool write FPool;
    property FirePlace: WideString read FFirePlace write FFirePlace;
    property ImprovedPercentage: WideString read FImprovedPercentage write FImprovedPercentage;
    property TaxStatus: WideString read FTaxStatus write FTaxStatus;
    property HousingTract: WideString read FHousingTract write FHousingTract;
  end;



  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  LegalDescriptionInfo = class(TRemotable)
  private
    FLotCode: WideString;
    FLotNumber: WideString;
    FBlock: WideString;
    FSection: WideString;
    FDistrict: WideString;
    FSubdivision: WideString;
    FTractNumber: WideString;
    FPhaseNumber: WideString;
    FUnit_: WideString;
    FLandLot: WideString;
    FMapRef: WideString;
    FSecTwnshipRange: WideString;
    FLegalBriefDescription: WideString;
    FCityMuniTwp: WideString;
  published
    property LotCode: WideString read FLotCode write FLotCode;
    property LotNumber: WideString read FLotNumber write FLotNumber;
    property Block: WideString read FBlock write FBlock;
    property Section: WideString read FSection write FSection;
    property District: WideString read FDistrict write FDistrict;
    property Subdivision: WideString read FSubdivision write FSubdivision;
    property TractNumber: WideString read FTractNumber write FTractNumber;
    property PhaseNumber: WideString read FPhaseNumber write FPhaseNumber;
    property Unit_: WideString read FUnit_ write FUnit_;
    property LandLot: WideString read FLandLot write FLandLot;
    property MapRef: WideString read FMapRef write FMapRef;
    property SecTwnshipRange: WideString read FSecTwnshipRange write FSecTwnshipRange;
    property LegalBriefDescription: WideString read FLegalBriefDescription write FLegalBriefDescription;
    property CityMuniTwp: WideString read FCityMuniTwp write FCityMuniTwp;
  end;



  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  Transfer = class(TRemotable)
  private
    FTypeCD: WideString;
    FRecordingDate: WideString;
    FDocumentNumber: WideString;
    FDocumentType: WideString;
    FDocumentTypeCode: WideString;
    FBook: WideString;
    FPage: WideString;
    FMultiAPN: WideString;
    FLoan1DueDate: WideString;
    FLoan1Amount: WideString;
    FLoan1Type: WideString;
    FMortDoc: WideString;
    FLenderName: WideString;
    FLenderType: WideString;
    FTypeFinancing: WideString;
    FLoan1Rate: WideString;
    FLoan2Amount: WideString;
    FBuyerName: WideString;
    FBuyerMailCareOfName: WideString;
    FBuyerMailUnit: WideString;
    FBuyerMailUnitType: WideString;
    FBuyerMailAddress: WideString;
    FBuyerMailCity: WideString;
    FBuyerMailState: WideString;
    FBuyerMailZip: WideString;
    FBuyerMailZip4: WideString;
    FBuyerVesting: WideString;
    FBuyerID: WideString;
    FSellerName: WideString;
    FSellerID: WideString;
    FSalePrice: WideString;
    FSalePriceCode: WideString;
    FSaleType: WideString;
    FLegalDescriptionInfo: LegalDescriptionInfo;
  public
    destructor Destroy; override;
  published
    property TypeCD: WideString read FTypeCD write FTypeCD;
    property RecordingDate: WideString read FRecordingDate write FRecordingDate;
    property DocumentNumber: WideString read FDocumentNumber write FDocumentNumber;
    property DocumentType: WideString read FDocumentType write FDocumentType;
    property DocumentTypeCode: WideString read FDocumentTypeCode write FDocumentTypeCode;
    property Book: WideString read FBook write FBook;
    property Page: WideString read FPage write FPage;
    property MultiAPN: WideString read FMultiAPN write FMultiAPN;
    property Loan1DueDate: WideString read FLoan1DueDate write FLoan1DueDate;
    property Loan1Amount: WideString read FLoan1Amount write FLoan1Amount;
    property Loan1Type: WideString read FLoan1Type write FLoan1Type;
    property MortDoc: WideString read FMortDoc write FMortDoc;
    property LenderName: WideString read FLenderName write FLenderName;
    property LenderType: WideString read FLenderType write FLenderType;
    property TypeFinancing: WideString read FTypeFinancing write FTypeFinancing;
    property Loan1Rate: WideString read FLoan1Rate write FLoan1Rate;
    property Loan2Amount: WideString read FLoan2Amount write FLoan2Amount;
    property BuyerName: WideString read FBuyerName write FBuyerName;
    property BuyerMailCareOfName: WideString read FBuyerMailCareOfName write FBuyerMailCareOfName;
    property BuyerMailUnit: WideString read FBuyerMailUnit write FBuyerMailUnit;
    property BuyerMailUnitType: WideString read FBuyerMailUnitType write FBuyerMailUnitType;
    property BuyerMailAddress: WideString read FBuyerMailAddress write FBuyerMailAddress;
    property BuyerMailCity: WideString read FBuyerMailCity write FBuyerMailCity;
    property BuyerMailState: WideString read FBuyerMailState write FBuyerMailState;
    property BuyerMailZip: WideString read FBuyerMailZip write FBuyerMailZip;
    property BuyerMailZip4: WideString read FBuyerMailZip4 write FBuyerMailZip4;
    property BuyerVesting: WideString read FBuyerVesting write FBuyerVesting;
    property BuyerID: WideString read FBuyerID write FBuyerID;
    property SellerName: WideString read FSellerName write FSellerName;
    property SellerID: WideString read FSellerID write FSellerID;
    property SalePrice: WideString read FSalePrice write FSalePrice;
    property SalePriceCode: WideString read FSalePriceCode write FSalePriceCode;
    property SaleType: WideString read FSaleType write FSaleType;
    property LegalDescriptionInfo: LegalDescriptionInfo read FLegalDescriptionInfo write FLegalDescriptionInfo;
  end;

  ArrayOfTransfer = array of Transfer;          { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }


  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  PriorSale = class(TRemotable)
  private
    FBuyer1FirstName: WideString;
    FBuyer1LastName: WideString;
    FBuyer2FirstName: WideString;
    FBuyer2LastName: WideString;
    FSeller1FirstName: WideString;
    FSeller1LastName: WideString;
    FSeller2FirstName: WideString;
    FSeller2LastName: WideString;
    FRecordingDate: WideString;
    FSalePrice: WideString;
  published
    property Buyer1FirstName: WideString read FBuyer1FirstName write FBuyer1FirstName;
    property Buyer1LastName: WideString read FBuyer1LastName write FBuyer1LastName;
    property Buyer2FirstName: WideString read FBuyer2FirstName write FBuyer2FirstName;
    property Buyer2LastName: WideString read FBuyer2LastName write FBuyer2LastName;
    property Seller1FirstName: WideString read FSeller1FirstName write FSeller1FirstName;
    property Seller1LastName: WideString read FSeller1LastName write FSeller1LastName;
    property Seller2FirstName: WideString read FSeller2FirstName write FSeller2FirstName;
    property Seller2LastName: WideString read FSeller2LastName write FSeller2LastName;
    property RecordingDate: WideString read FRecordingDate write FRecordingDate;
    property SalePrice: WideString read FSalePrice write FSalePrice;
  end;

  ArrayOfPriorSale = array of PriorSale;        { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }


  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  ComparableSale = class(TRemotable)
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
    FPriceCode: WideString;
    FSalePrice: WideString;
    FAssessmentValue: WideString;
    FPricePerSQFT: WideString;
    FBuildingArea: WideString;
    FTotalRooms: WideString;
    FBedrooms: WideString;
    FBaths: WideString;
    FYearBuilt: WideString;
    FLotSize: WideString;
    FPool: WideString;
    FAPN: WideString;
    FDocumentNumber: WideString;
    FDocumentType: WideString;
    FUseCodeDescription: WideString;
    FLotCode: WideString;
    FLotNumber: WideString;
    FBlock: WideString;
    FSection: WideString;
    FDistrict: WideString;
    FLandLot: WideString;
    FUnit_: WideString;
    FCityMuniTwp: WideString;
    FSubdivisionName: WideString;
    FPhaseNumber: WideString;
    FTractNumber: WideString;
    FLegalBriefDescription: WideString;
    FSecTwpRngMer: WideString;
    FMapRef: WideString;
    FBuyer1FName: WideString;
    FBuyer1LName: WideString;
    FBuyer2FName: WideString;
    FBuyer2LName: WideString;
    FSeller1FName: WideString;
    FSeller1LName: WideString;
    FSeller2FName: WideString;
    FSeller2LName: WideString;
    FLenderName: WideString;
    FLoan1Amount: WideString;
    FLatitude: WideString;
    FLongitude: WideString;
    FPriorSales: ArrayOfPriorSale;
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
    property PriceCode: WideString read FPriceCode write FPriceCode;
    property SalePrice: WideString read FSalePrice write FSalePrice;
    property AssessmentValue: WideString read FAssessmentValue write FAssessmentValue;
    property PricePerSQFT: WideString read FPricePerSQFT write FPricePerSQFT;
    property BuildingArea: WideString read FBuildingArea write FBuildingArea;
    property TotalRooms: WideString read FTotalRooms write FTotalRooms;
    property Bedrooms: WideString read FBedrooms write FBedrooms;
    property Baths: WideString read FBaths write FBaths;
    property YearBuilt: WideString read FYearBuilt write FYearBuilt;
    property LotSize: WideString read FLotSize write FLotSize;
    property Pool: WideString read FPool write FPool;
    property APN: WideString read FAPN write FAPN;
    property DocumentNumber: WideString read FDocumentNumber write FDocumentNumber;
    property DocumentType: WideString read FDocumentType write FDocumentType;
    property UseCodeDescription: WideString read FUseCodeDescription write FUseCodeDescription;
    property LotCode: WideString read FLotCode write FLotCode;
    property LotNumber: WideString read FLotNumber write FLotNumber;
    property Block: WideString read FBlock write FBlock;
    property Section: WideString read FSection write FSection;
    property District: WideString read FDistrict write FDistrict;
    property LandLot: WideString read FLandLot write FLandLot;
    property Unit_: WideString read FUnit_ write FUnit_;
    property CityMuniTwp: WideString read FCityMuniTwp write FCityMuniTwp;
    property SubdivisionName: WideString read FSubdivisionName write FSubdivisionName;
    property PhaseNumber: WideString read FPhaseNumber write FPhaseNumber;
    property TractNumber: WideString read FTractNumber write FTractNumber;
    property LegalBriefDescription: WideString read FLegalBriefDescription write FLegalBriefDescription;
    property SecTwpRngMer: WideString read FSecTwpRngMer write FSecTwpRngMer;
    property MapRef: WideString read FMapRef write FMapRef;
    property Buyer1FName: WideString read FBuyer1FName write FBuyer1FName;
    property Buyer1LName: WideString read FBuyer1LName write FBuyer1LName;
    property Buyer2FName: WideString read FBuyer2FName write FBuyer2FName;
    property Buyer2LName: WideString read FBuyer2LName write FBuyer2LName;
    property Seller1FName: WideString read FSeller1FName write FSeller1FName;
    property Seller1LName: WideString read FSeller1LName write FSeller1LName;
    property Seller2FName: WideString read FSeller2FName write FSeller2FName;
    property Seller2LName: WideString read FSeller2LName write FSeller2LName;
    property LenderName: WideString read FLenderName write FLenderName;
    property Loan1Amount: WideString read FLoan1Amount write FLoan1Amount;
    property Latitude: WideString read FLatitude write FLatitude;
    property Longitude: WideString read FLongitude write FLongitude;
    property PriorSales: ArrayOfPriorSale read FPriorSales write FPriorSales;
  end;

  ArrayOfComparableSale = array of ComparableSale;   { "http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/" }


  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  ReportResult = class(TRemotable)
  private
    FAssessmentInfo: AssessmentInfo;
    FTransferHistory: ArrayOfTransfer;
    FComparableSales: ArrayOfComparableSale;
  public
    destructor Destroy; override;
  published
    property AssessmentInfo: AssessmentInfo read FAssessmentInfo write FAssessmentInfo;
    property TransferHistory: ArrayOfTransfer read FTransferHistory write FTransferHistory;
    property ComparableSales: ArrayOfComparableSale read FComparableSales write FComparableSales;
  end;



  // ************************************************************************ //
  // Namespace : http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/
  // ************************************************************************ //
  BradfordTechnologiesResult = class(TRemotable)
  private
    FMatchCode: Integer;
    FMessage: WideString;
    FLocations: ArrayOfLocation;
    FReportResult: ReportResult;
  public
    destructor Destroy; override;
  published
    property MatchCode: Integer read FMatchCode write FMatchCode;
    property Message: WideString read FMessage write FMessage;
    property Locations: ArrayOfLocation read FLocations write FLocations;
    property ReportResult: ReportResult read FReportResult write FReportResult;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/GetFISDataFromField
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : FidelityServiceSoap
  // service   : FidelityService
  // port      : FidelityServiceSoap
  // URL       : http://webservices.bradfordsoftware.com/WSFidelity/FidelityService.asmx
  // ************************************************************************ //
  FidelityServiceSoap = interface(IInvokable)
  ['{CCAA8690-87EC-4F92-27CA-48C98B22309A}']
    procedure GetFISDataFromField(const iCustID: Integer; const szPassword: WideString; const oFISRequest: FISRequestRec;  out GetFISDataFromFieldResult: BradfordTechnologiesResult; out iMsgCode: Integer; out sMsgText: WideString); stdcall;
  end;

function GetFidelityServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): FidelityServiceSoap;


implementation

function GetFidelityServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): FidelityServiceSoap;
const
  defWSDL = 'http://webservices.bradfordsoftware.com/WSFidelity/FidelityService.asmx?wsdl';
  defURL  = 'http://webservices.bradfordsoftware.com/WSFidelity/FidelityService.asmx';
  defSvc  = 'FidelityService';
  defPrt  = 'FidelityServiceSoap';
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
    Result := (RIO as FidelityServiceSoap);
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


destructor Transfer.Destroy;
begin
  if Assigned(FLegalDescriptionInfo) then
    FLegalDescriptionInfo.Free;
  inherited Destroy;
end;

destructor ComparableSale.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FPriorSales)-1 do
    if Assigned(FPriorSales[I]) then
      FPriorSales[I].Free;
  SetLength(FPriorSales, 0);
  inherited Destroy;
end;

destructor ReportResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FTransferHistory)-1 do
    if Assigned(FTransferHistory[I]) then
      FTransferHistory[I].Free;
  SetLength(FTransferHistory, 0);
  for I := 0 to Length(FComparableSales)-1 do
    if Assigned(FComparableSales[I]) then
      FComparableSales[I].Free;
  SetLength(FComparableSales, 0);
  if Assigned(FAssessmentInfo) then
    FAssessmentInfo.Free;
  inherited Destroy;
end;

destructor BradfordTechnologiesResult.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FLocations)-1 do
    if Assigned(FLocations[I]) then
      FLocations[I].Free;
  SetLength(FLocations, 0);
  if Assigned(FReportResult) then
    FReportResult.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(FidelityServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(FidelityServiceSoap), 'http://tempuri.org/GetFISDataFromField');
  InvRegistry.RegisterInvokeOptions(TypeInfo(FidelityServiceSoap), ioDocument);
  RemClassRegistry.RegisterXSClass(FISRequestRec, 'http://tempuri.org/', 'FISRequestRec');
  RemClassRegistry.RegisterXSClass(Location, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'Location');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfLocation), 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ArrayOfLocation');
  RemClassRegistry.RegisterXSClass(AssessmentInfo, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'AssessmentInfo');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AssessmentInfo), 'Unit_', 'Unit');
  RemClassRegistry.RegisterXSClass(LegalDescriptionInfo, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'LegalDescriptionInfo');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LegalDescriptionInfo), 'Unit_', 'Unit');
  RemClassRegistry.RegisterXSClass(Transfer, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'Transfer');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfTransfer), 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ArrayOfTransfer');
  RemClassRegistry.RegisterXSClass(PriorSale, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'PriorSale');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPriorSale), 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ArrayOfPriorSale');
  RemClassRegistry.RegisterXSClass(ComparableSale, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ComparableSale');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ComparableSale), 'Unit_', 'Unit');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfComparableSale), 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ArrayOfComparableSale');
  RemClassRegistry.RegisterXSClass(ReportResult, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'ReportResult');
  RemClassRegistry.RegisterXSClass(BradfordTechnologiesResult, 'http://BradfordTechnologies.SiteXData.com/BradfordTechnologies/', 'BradfordTechnologiesResult');

end. 