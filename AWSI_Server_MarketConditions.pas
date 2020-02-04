// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://awstaging/secure/ws/awsi/MarketConditionServer.php?wsdl
// Encoding : ISO-8859-1
// Version  : 1.0
// (9/10/2013 6:46:52 AM - 1.33.2.5)
// ************************************************************************ //

unit AWSI_Server_MarketConditions;

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
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"
  // !:float           - "http://www.w3.org/2001/XMLSchema"

  clsUserCredentials   = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsSubjectPropertyDetails = class;            { "http://awstaging/secure/ws/WSDL" }
  clsResults           = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsExtraCommentsArray = class;                { "http://awstaging/secure/ws/WSDL" }
  clsCountHighLowArray = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsUrarDataArray     = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsUrarResultsArray  = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsAnalysisArray     = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsInventoryAnalysisArray = class;            { "http://awstaging/secure/ws/WSDL" }
  clsMedianSalesArrayItem = class;              { "http://awstaging/secure/ws/WSDL" }
  clsMedianSalesArray  = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsMarketResultsArray = class;                { "http://awstaging/secure/ws/WSDL" }
  clsWorkfileArrayItem = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsCondoResultsArray = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsGraphArrayItem    = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsAddendumDataArray = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsAddendumsArrayItem = class;                { "http://awstaging/secure/ws/WSDL" }
  clsAcknowledgementResponseData = class;       { "http://awstaging/secure/ws/WSDL" }
  clsAcknowledgementResponse = class;           { "http://awstaging/secure/ws/WSDL" }
  clsChartListItem     = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsChartListConnectionResponse = class;       { "http://awstaging/secure/ws/WSDL" }
  clsCustomerInfo      = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsCustomerInfoConnectionResponse = class;    { "http://awstaging/secure/ws/WSDL" }
  clsMarketConditionResponseData = class;       { "http://awstaging/secure/ws/WSDL" }
  clsMarketConditionConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyColumnItem = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketConditionResponseData = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketConditionConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsQuarterlyColumnItem = class;               { "http://awstaging/secure/ws/WSDL" }
  clsQuarterlyMarketResultsArray = class;       { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition2ResponseData = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition2ConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsQuarterly3ColumnItem = class;              { "http://awstaging/secure/ws/WSDL" }
  clsQuarterly3MarketResultsArray = class;      { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition3ResponseData = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition3ConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsQuarterly4ColumnItem = class;              { "http://awstaging/secure/ws/WSDL" }
  clsQuarterly4MarketResultsArray = class;      { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition4ResponseData = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMarketCondition4ConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsMlsDirectoryArrayItem = class;             { "http://awstaging/secure/ws/WSDL" }
  clsMlsDirectoryResponseData = class;          { "http://awstaging/secure/ws/WSDL" }
  clsMlsDirectoryConnectionResponse = class;    { "http://awstaging/secure/ws/WSDL" }
  clsMlsDirectoryStatesResponseData = class;    { "http://awstaging/secure/ws/WSDL" }
  clsMlsDirectoryStatesConnectionResponse = class;   { "http://awstaging/secure/ws/WSDL" }
  clsAcknowledgement   = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsAccessDetails     = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsMlsRequestDetails = class;                 { "http://awstaging/secure/ws/WSDL" }
  clsMonthlyMlsRequestDetails = class;          { "http://awstaging/secure/ws/WSDL" }
  clsMlsListDetails    = class;                 { "http://awstaging/secure/ws/WSDL" }



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
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
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsSubjectPropertyDetails = class(TRemotable)
  private
    FAWUserID: WideString;
    FAppraisalDate: WideString;
    FAppraisalType: WideString;
    FAddress: WideString;
    FCity: WideString;
    FState: WideString;
    FZipCode: WideString;
    FLongitude: WideString;
    FLatitude: WideString;
    FStatus: WideString;
    FStreet_Number: WideString;
    FStreet_Name: WideString;
    FUnit_Number: WideString;
    FClosing_Date: WideString;
    FSale_Price: TXSDecimal;
    FOrg_Lst_Price: TXSDecimal;
    FList_Price: TXSDecimal;
    FList_Date: WideString;
    FOff_Mkt_Date: WideString;
    FSquare_Feet: Integer;
    FBedrooms: Integer;
    FBaths_Full: Integer;
    FBaths_Half: Integer;
    FLot_Descr: WideString;
    FYear_Built: Integer;
    FSubdivision: WideString;
    FBasement: WideString;
    FParking: WideString;
    FListing_Numb: WideString;
    FREO: WideString;
    FRemarks: WideString;
    FZip_Code: WideString;
  public
    destructor Destroy; override;
  published
    property AWUserID: WideString read FAWUserID write FAWUserID;
    property AppraisalDate: WideString read FAppraisalDate write FAppraisalDate;
    property AppraisalType: WideString read FAppraisalType write FAppraisalType;
    property Address: WideString read FAddress write FAddress;
    property City: WideString read FCity write FCity;
    property State: WideString read FState write FState;
    property ZipCode: WideString read FZipCode write FZipCode;
    property Longitude: WideString read FLongitude write FLongitude;
    property Latitude: WideString read FLatitude write FLatitude;
    property Status: WideString read FStatus write FStatus;
    property Street_Number: WideString read FStreet_Number write FStreet_Number;
    property Street_Name: WideString read FStreet_Name write FStreet_Name;
    property Unit_Number: WideString read FUnit_Number write FUnit_Number;
    property Closing_Date: WideString read FClosing_Date write FClosing_Date;
    property Sale_Price: TXSDecimal read FSale_Price write FSale_Price;
    property Org_Lst_Price: TXSDecimal read FOrg_Lst_Price write FOrg_Lst_Price;
    property List_Price: TXSDecimal read FList_Price write FList_Price;
    property List_Date: WideString read FList_Date write FList_Date;
    property Off_Mkt_Date: WideString read FOff_Mkt_Date write FOff_Mkt_Date;
    property Square_Feet: Integer read FSquare_Feet write FSquare_Feet;
    property Bedrooms: Integer read FBedrooms write FBedrooms;
    property Baths_Full: Integer read FBaths_Full write FBaths_Full;
    property Baths_Half: Integer read FBaths_Half write FBaths_Half;
    property Lot_Descr: WideString read FLot_Descr write FLot_Descr;
    property Year_Built: Integer read FYear_Built write FYear_Built;
    property Subdivision: WideString read FSubdivision write FSubdivision;
    property Basement: WideString read FBasement write FBasement;
    property Parking: WideString read FParking write FParking;
    property Listing_Numb: WideString read FListing_Numb write FListing_Numb;
    property REO: WideString read FREO write FREO;
    property Remarks: WideString read FRemarks write FRemarks;
    property Zip_Code: WideString read FZip_Code write FZip_Code;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
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
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsExtraCommentsArray = class(TRemotable)
  private
    Fsummary_1004mc: WideString;
    Furar_comments: WideString;
  published
    property summary_1004mc: WideString read Fsummary_1004mc write Fsummary_1004mc;
    property urar_comments: WideString read Furar_comments write Furar_comments;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsCountHighLowArray = class(TRemotable)
  private
    Fcount: Integer;
    Fhigh_: Integer;
    Flow_: Integer;
  published
    property count: Integer read Fcount write Fcount;
    property high_: Integer read Fhigh_ write Fhigh_;
    property low_: Integer read Flow_ write Flow_;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsUrarDataArray = class(TRemotable)
  private
    Flistings: clsCountHighLowArray;
    Fsales: clsCountHighLowArray;
  public
    destructor Destroy; override;
  published
    property listings: clsCountHighLowArray read Flistings write Flistings;
    property sales: clsCountHighLowArray read Fsales write Fsales;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsUrarResultsArray = class(TRemotable)
  private
    FExtra_Comments: clsExtraCommentsArray;
    FUrar1004_Data: clsUrarDataArray;
  public
    destructor Destroy; override;
  published
    property Extra_Comments: clsExtraCommentsArray read FExtra_Comments write FExtra_Comments;
    property Urar1004_Data: clsUrarDataArray read FUrar1004_Data write FUrar1004_Data;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsAnalysisArray = class(TRemotable)
  private
    Fsold: Integer;
    Factive: Integer;
    Fpending: Integer;
    Fpending_orig: Integer;
    Fpending_sold: Integer;
    Fabsorption_rate: Single;
    Fmonths_of_supply: Single;
  published
    property sold: Integer read Fsold write Fsold;
    property active: Integer read Factive write Factive;
    property pending: Integer read Fpending write Fpending;
    property pending_orig: Integer read Fpending_orig write Fpending_orig;
    property pending_sold: Integer read Fpending_sold write Fpending_sold;
    property absorption_rate: Single read Fabsorption_rate write Fabsorption_rate;
    property months_of_supply: Single read Fmonths_of_supply write Fmonths_of_supply;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsInventoryAnalysisArray = class(TRemotable)
  private
    FMonths7To12: clsAnalysisArray;
    FMonths4To6: clsAnalysisArray;
    FMonths1To3: clsAnalysisArray;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsAnalysisArray read FMonths7To12 write FMonths7To12;
    property Months4To6: clsAnalysisArray read FMonths4To6 write FMonths4To6;
    property Months1To3: clsAnalysisArray read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMedianSalesArrayItem = class(TRemotable)
  private
    Fsale_prices: Integer;
    Freal_doms: Single;
    Fratios: Single;
    Flist_prices: Integer;
    Flisting_days: Single;
  published
    property sale_prices: Integer read Fsale_prices write Fsale_prices;
    property real_doms: Single read Freal_doms write Freal_doms;
    property ratios: Single read Fratios write Fratios;
    property list_prices: Integer read Flist_prices write Flist_prices;
    property listing_days: Single read Flisting_days write Flisting_days;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMedianSalesArray = class(TRemotable)
  private
    FMonths7To12: clsMedianSalesArrayItem;
    FMonths4To6: clsMedianSalesArrayItem;
    FMonths1To3: clsMedianSalesArrayItem;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsMedianSalesArrayItem read FMonths7To12 write FMonths7To12;
    property Months4To6: clsMedianSalesArrayItem read FMonths4To6 write FMonths4To6;
    property Months1To3: clsMedianSalesArrayItem read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketResultsArray = class(TRemotable)
  private
    FInventoryAnalysis: clsInventoryAnalysisArray;
    FMedianSales: clsMedianSalesArray;
  public
    destructor Destroy; override;
  published
    property InventoryAnalysis: clsInventoryAnalysisArray read FInventoryAnalysis write FInventoryAnalysis;
    property MedianSales: clsMedianSalesArray read FMedianSales write FMedianSales;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsWorkfileArrayItem = class(TRemotable)
  private
    FDOM: WideString;
    FListingDate: WideString;
    FListingPrice: WideString;
    FPendingDate: WideString;
    FSellingDate: WideString;
    FSellingPrice: WideString;
    FStatus: WideString;
    FStatusDate: WideString;
    FREO: WideString;
  published
    property DOM: WideString read FDOM write FDOM;
    property ListingDate: WideString read FListingDate write FListingDate;
    property ListingPrice: WideString read FListingPrice write FListingPrice;
    property PendingDate: WideString read FPendingDate write FPendingDate;
    property SellingDate: WideString read FSellingDate write FSellingDate;
    property SellingPrice: WideString read FSellingPrice write FSellingPrice;
    property Status: WideString read FStatus write FStatus;
    property StatusDate: WideString read FStatusDate write FStatusDate;
    property REO: WideString read FREO write FREO;
  end;

  clsWorkfileArray = array of clsWorkfileArrayItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsCondoResultsArray = class(TRemotable)
  private
    FInventoryAnalysis: clsInventoryAnalysisArray;
    FMedianSales: clsMedianSalesArray;
    FWorkFile: clsWorkfileArray;
    FSalesCount: Integer;
  public
    destructor Destroy; override;
  published
    property InventoryAnalysis: clsInventoryAnalysisArray read FInventoryAnalysis write FInventoryAnalysis;
    property MedianSales: clsMedianSalesArray read FMedianSales write FMedianSales;
    property WorkFile: clsWorkfileArray read FWorkFile write FWorkFile;
    property SalesCount: Integer read FSalesCount write FSalesCount;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsGraphArrayItem = class(TRemotable)
  private
    Ftitle: WideString;
    Fchart: WideString;
    Fcomments: WideString;
  published
    property title: WideString read Ftitle write Ftitle;
    property chart: WideString read Fchart write Fchart;
    property comments: WideString read Fcomments write Fcomments;
  end;

  clsFootnotesDataArray = array of WideString;   { "http://awstaging/secure/ws/WSDL" }
  clsAddendumMonthsArray = array of WideString;   { "http://awstaging/secure/ws/WSDL" }
  clsAddendumMedianPriceArray = array of WideString;   { "http://awstaging/secure/ws/WSDL" }
  clsAddendumCurrentMedianArray = array of WideString;   { "http://awstaging/secure/ws/WSDL" }
  clsAddendumChangeArray = array of WideString;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsAddendumDataArray = class(TRemotable)
  private
    Fmonth: clsAddendumMonthsArray;
    Fmedian_price: clsAddendumMedianPriceArray;
    Fcurrent_median: clsAddendumCurrentMedianArray;
    Fchange_to_current: clsAddendumChangeArray;
  published
    property month: clsAddendumMonthsArray read Fmonth write Fmonth;
    property median_price: clsAddendumMedianPriceArray read Fmedian_price write Fmedian_price;
    property current_median: clsAddendumCurrentMedianArray read Fcurrent_median write Fcurrent_median;
    property change_to_current: clsAddendumChangeArray read Fchange_to_current write Fchange_to_current;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsAddendumsArrayItem = class(TRemotable)
  private
    Faddendum_name: WideString;
    Fdata: clsAddendumDataArray;
    Fgraph: clsGraphArrayItem;
    Ffootnotes: clsFootnotesDataArray;
  public
    destructor Destroy; override;
  published
    property addendum_name: WideString read Faddendum_name write Faddendum_name;
    property data: clsAddendumDataArray read Fdata write Fdata;
    property graph: clsGraphArrayItem read Fgraph write Fgraph;
    property footnotes: clsFootnotesDataArray read Ffootnotes write Ffootnotes;
  end;

  clsAddendumsArray = array of clsAddendumsArrayItem;   { "http://awstaging/secure/ws/WSDL" }
  clsGraphArray = array of clsGraphArrayItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsAcknowledgementResponseData = class(TRemotable)
  private
    FReceived: Integer;
  published
    property Received: Integer read FReceived write FReceived;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
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
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsChartListItem = class(TRemotable)
  private
    Ftitle: WideString;
    Ftype_: WideString;
  published
    property title: WideString read Ftitle write Ftitle;
    property type_: WideString read Ftype_ write Ftype_;
  end;

  clsChartListData = array of clsChartListItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsChartListConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsChartListData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsChartListData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsCustomerInfo = class(TRemotable)
  private
    FID: Integer;
    FEmailAddress: WideString;
    FPassword: WideString;
    FPublicKey: WideString;
  published
    property ID: Integer read FID write FID;
    property EmailAddress: WideString read FEmailAddress write FEmailAddress;
    property Password: WideString read FPassword write FPassword;
    property PublicKey: WideString read FPublicKey write FPublicKey;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsCustomerInfoConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsCustomerInfo;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsCustomerInfo read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketConditionResponseData = class(TRemotable)
  private
    FMarketResults: clsMarketResultsArray;
    FGraphs: clsGraphArray;
    FWorkFile: clsWorkfileArray;
    FUrarResults: clsUrarResultsArray;
    FAddendums: clsAddendumsArray;
    FCondoResults: clsCondoResultsArray;
    FQuarterlyGraphs: clsGraphArray;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property MarketResults: clsMarketResultsArray read FMarketResults write FMarketResults;
    property Graphs: clsGraphArray read FGraphs write FGraphs;
    property WorkFile: clsWorkfileArray read FWorkFile write FWorkFile;
    property UrarResults: clsUrarResultsArray read FUrarResults write FUrarResults;
    property Addendums: clsAddendumsArray read FAddendums write FAddendums;
    property CondoResults: clsCondoResultsArray read FCondoResults write FCondoResults;
    property QuarterlyGraphs: clsGraphArray read FQuarterlyGraphs write FQuarterlyGraphs;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketConditionConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMarketConditionResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMarketConditionResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyColumnItem = class(TRemotable)
  private
    Fmonth_label: WideString;
    Ftotal_sales: WideString;
    Fabsorption_rate: WideString;
    Ftotal_listings: WideString;
    Fmonths_of_supply: WideString;
    Fmedian_sales_price: WideString;
    Fmedian_sales_dom: WideString;
    Fmedian_list_price: WideString;
    Fmedian_listing_dom: WideString;
    Fmedian_sale_price_as_percent_list_price: WideString;
  published
    property month_label: WideString read Fmonth_label write Fmonth_label;
    property total_sales: WideString read Ftotal_sales write Ftotal_sales;
    property absorption_rate: WideString read Fabsorption_rate write Fabsorption_rate;
    property total_listings: WideString read Ftotal_listings write Ftotal_listings;
    property months_of_supply: WideString read Fmonths_of_supply write Fmonths_of_supply;
    property median_sales_price: WideString read Fmedian_sales_price write Fmedian_sales_price;
    property median_sales_dom: WideString read Fmedian_sales_dom write Fmedian_sales_dom;
    property median_list_price: WideString read Fmedian_list_price write Fmedian_list_price;
    property median_listing_dom: WideString read Fmedian_listing_dom write Fmedian_listing_dom;
    property median_sale_price_as_percent_list_price: WideString read Fmedian_sale_price_as_percent_list_price write Fmedian_sale_price_as_percent_list_price;
  end;

  clsMonthlyMarketResultsArray = array of clsMonthlyColumnItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketConditionResponseData = class(TRemotable)
  private
    FMarketResults: clsMonthlyMarketResultsArray;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property MarketResults: clsMonthlyMarketResultsArray read FMarketResults write FMarketResults;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketConditionConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMonthlyMarketConditionResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMonthlyMarketConditionResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterlyColumnItem = class(TRemotable)
  private
    Fsold: WideString;
    Factive: WideString;
    Fabsorption_rate: WideString;
    Fmonths_of_supply: WideString;
    Fsale_prices: WideString;
    Freal_doms: WideString;
    Fratios: WideString;
    Flist_prices: WideString;
    Flisting_days: WideString;
  published
    property sold: WideString read Fsold write Fsold;
    property active: WideString read Factive write Factive;
    property absorption_rate: WideString read Fabsorption_rate write Fabsorption_rate;
    property months_of_supply: WideString read Fmonths_of_supply write Fmonths_of_supply;
    property sale_prices: WideString read Fsale_prices write Fsale_prices;
    property real_doms: WideString read Freal_doms write Freal_doms;
    property ratios: WideString read Fratios write Fratios;
    property list_prices: WideString read Flist_prices write Flist_prices;
    property listing_days: WideString read Flisting_days write Flisting_days;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterlyMarketResultsArray = class(TRemotable)
  private
    FMonths10To12: clsQuarterlyColumnItem;
    FMonths7To9: clsQuarterlyColumnItem;
    FMonths4To6: clsQuarterlyColumnItem;
    FMonths1To3: clsQuarterlyColumnItem;
  public
    destructor Destroy; override;
  published
    property Months10To12: clsQuarterlyColumnItem read FMonths10To12 write FMonths10To12;
    property Months7To9: clsQuarterlyColumnItem read FMonths7To9 write FMonths7To9;
    property Months4To6: clsQuarterlyColumnItem read FMonths4To6 write FMonths4To6;
    property Months1To3: clsQuarterlyColumnItem read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition2ResponseData = class(TRemotable)
  private
    FMarketResults: clsMonthlyMarketResultsArray;
    FQuarterlyResults: clsQuarterlyMarketResultsArray;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property MarketResults: clsMonthlyMarketResultsArray read FMarketResults write FMarketResults;
    property QuarterlyResults: clsQuarterlyMarketResultsArray read FQuarterlyResults write FQuarterlyResults;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition2ConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMonthlyMarketCondition2ResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMonthlyMarketCondition2ResponseData read FResponseData write FResponseData;
  end;

  clsMonthlyMarket3ResultsArray = array of clsMonthlyColumnItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterly3ColumnItem = class(TRemotable)
  private
    Fsold: WideString;
    Factive: WideString;
    Fabsorption_rate: WideString;
    Fmonths_of_supply: WideString;
    Fsale_prices: WideString;
    Freal_doms: WideString;
    Fratios: WideString;
    Flist_prices: WideString;
    Flisting_days: WideString;
  published
    property sold: WideString read Fsold write Fsold;
    property active: WideString read Factive write Factive;
    property absorption_rate: WideString read Fabsorption_rate write Fabsorption_rate;
    property months_of_supply: WideString read Fmonths_of_supply write Fmonths_of_supply;
    property sale_prices: WideString read Fsale_prices write Fsale_prices;
    property real_doms: WideString read Freal_doms write Freal_doms;
    property ratios: WideString read Fratios write Fratios;
    property list_prices: WideString read Flist_prices write Flist_prices;
    property listing_days: WideString read Flisting_days write Flisting_days;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterly3MarketResultsArray = class(TRemotable)
  private
    FMonths7To12: clsQuarterly3ColumnItem;
    FMonths10To12: clsQuarterly3ColumnItem;
    FMonths7To9: clsQuarterly3ColumnItem;
    FMonths4To6: clsQuarterly3ColumnItem;
    FMonths1To3: clsQuarterly3ColumnItem;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsQuarterly3ColumnItem read FMonths7To12 write FMonths7To12;
    property Months10To12: clsQuarterly3ColumnItem read FMonths10To12 write FMonths10To12;
    property Months7To9: clsQuarterly3ColumnItem read FMonths7To9 write FMonths7To9;
    property Months4To6: clsQuarterly3ColumnItem read FMonths4To6 write FMonths4To6;
    property Months1To3: clsQuarterly3ColumnItem read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition3ResponseData = class(TRemotable)
  private
    FMarketResults: clsMonthlyMarket3ResultsArray;
    FQuarterlyResults: clsQuarterly3MarketResultsArray;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property MarketResults: clsMonthlyMarket3ResultsArray read FMarketResults write FMarketResults;
    property QuarterlyResults: clsQuarterly3MarketResultsArray read FQuarterlyResults write FQuarterlyResults;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition3ConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMonthlyMarketCondition3ResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMonthlyMarketCondition3ResponseData read FResponseData write FResponseData;
  end;

  clsMonthlyMarket4ResultsArray = array of clsMonthlyColumnItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterly4ColumnItem = class(TRemotable)
  private
    Fsold: WideString;
    Factive: WideString;
    Fabsorption_rate: WideString;
    Fmonths_of_supply: WideString;
    Fsale_prices: WideString;
    Freal_doms: WideString;
    Fratios: WideString;
    Flist_prices: WideString;
    Flisting_days: WideString;
  published
    property sold: WideString read Fsold write Fsold;
    property active: WideString read Factive write Factive;
    property absorption_rate: WideString read Fabsorption_rate write Fabsorption_rate;
    property months_of_supply: WideString read Fmonths_of_supply write Fmonths_of_supply;
    property sale_prices: WideString read Fsale_prices write Fsale_prices;
    property real_doms: WideString read Freal_doms write Freal_doms;
    property ratios: WideString read Fratios write Fratios;
    property list_prices: WideString read Flist_prices write Flist_prices;
    property listing_days: WideString read Flisting_days write Flisting_days;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsQuarterly4MarketResultsArray = class(TRemotable)
  private
    FMonths7To12: clsQuarterly4ColumnItem;
    FMonths10To12: clsQuarterly4ColumnItem;
    FMonths7To9: clsQuarterly4ColumnItem;
    FMonths4To6: clsQuarterly4ColumnItem;
    FMonths1To3: clsQuarterly4ColumnItem;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsQuarterly4ColumnItem read FMonths7To12 write FMonths7To12;
    property Months10To12: clsQuarterly4ColumnItem read FMonths10To12 write FMonths10To12;
    property Months7To9: clsQuarterly4ColumnItem read FMonths7To9 write FMonths7To9;
    property Months4To6: clsQuarterly4ColumnItem read FMonths4To6 write FMonths4To6;
    property Months1To3: clsQuarterly4ColumnItem read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition4ResponseData = class(TRemotable)
  private
    FMarketResults: clsMonthlyMarket4ResultsArray;
    FGraphs: clsGraphArray;
    FWorkFile: clsWorkfileArray;
    FUrarResults: clsUrarResultsArray;
    FAddendums: clsAddendumsArray;
    FCondoResults: clsCondoResultsArray;
    FQuarterlyGraphs: clsGraphArray;
    FQuarterlyResults: clsQuarterly4MarketResultsArray;
    FServiceAcknowledgement: WideString;
  public
    destructor Destroy; override;
  published
    property MarketResults: clsMonthlyMarket4ResultsArray read FMarketResults write FMarketResults;
    property Graphs: clsGraphArray read FGraphs write FGraphs;
    property WorkFile: clsWorkfileArray read FWorkFile write FWorkFile;
    property UrarResults: clsUrarResultsArray read FUrarResults write FUrarResults;
    property Addendums: clsAddendumsArray read FAddendums write FAddendums;
    property CondoResults: clsCondoResultsArray read FCondoResults write FCondoResults;
    property QuarterlyGraphs: clsGraphArray read FQuarterlyGraphs write FQuarterlyGraphs;
    property QuarterlyResults: clsQuarterly4MarketResultsArray read FQuarterlyResults write FQuarterlyResults;
    property ServiceAcknowledgement: WideString read FServiceAcknowledgement write FServiceAcknowledgement;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMarketCondition4ConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMonthlyMarketCondition4ResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMonthlyMarketCondition4ResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryArrayItem = class(TRemotable)
  private
    FState: WideString;
    FMls_Full_Name: WideString;
    FMls_Name: WideString;
    FMls_Url: WideString;
  published
    property State: WideString read FState write FState;
    property Mls_Full_Name: WideString read FMls_Full_Name write FMls_Full_Name;
    property Mls_Name: WideString read FMls_Name write FMls_Name;
    property Mls_Url: WideString read FMls_Url write FMls_Url;
  end;

  clsMlsDirectoryListing = array of clsMlsDirectoryArrayItem;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryResponseData = class(TRemotable)
  private
    FMlsDirectory: clsMlsDirectoryListing;
  public
    destructor Destroy; override;
  published
    property MlsDirectory: clsMlsDirectoryListing read FMlsDirectory write FMlsDirectory;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsDirectoryResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMlsDirectoryResponseData read FResponseData write FResponseData;
  end;

  clsMlsDirectoryStatesListing = array of WideString;   { "http://awstaging/secure/ws/WSDL" }


  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryStatesResponseData = class(TRemotable)
  private
    FMlsStates: clsMlsDirectoryStatesListing;
  published
    property MlsStates: clsMlsDirectoryStatesListing read FMlsStates write FMlsStates;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryStatesConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsDirectoryStatesResponseData;
  public
    destructor Destroy; override;
  published
    property Results: clsResults read FResults write FResults;
    property ResponseData: clsMlsDirectoryStatesResponseData read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
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
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsAccessDetails = class(TRemotable)
  private
    FID: Integer;
    FAccessKey: WideString;
  published
    property ID: Integer read FID write FID;
    property AccessKey: WideString read FAccessKey write FAccessKey;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsRequestDetails = class(TRemotable)
  private
    FMlsName: WideString;
    FPendingSaleFlag: Integer;
    FMlsRawData: WideString;
    FCondoRawData: WideString;
    FMlsTranslatedData: WideString;
    FDateOfAnalysis: WideString;
    FChartGroup: Integer;
  published
    property MlsName: WideString read FMlsName write FMlsName;
    property PendingSaleFlag: Integer read FPendingSaleFlag write FPendingSaleFlag;
    property MlsRawData: WideString read FMlsRawData write FMlsRawData;
    property CondoRawData: WideString read FCondoRawData write FCondoRawData;
    property MlsTranslatedData: WideString read FMlsTranslatedData write FMlsTranslatedData;
    property DateOfAnalysis: WideString read FDateOfAnalysis write FDateOfAnalysis;
    property ChartGroup: Integer read FChartGroup write FChartGroup;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMonthlyMlsRequestDetails = class(TRemotable)
  private
    FMlsName: WideString;
    FPendingSaleFlag: Integer;
    FMlsRawData: WideString;
    FCondoRawData: WideString;
    FMlsTranslatedData: WideString;
    FDateOfAnalysis: WideString;
  published
    property MlsName: WideString read FMlsName write FMlsName;
    property PendingSaleFlag: Integer read FPendingSaleFlag write FPendingSaleFlag;
    property MlsRawData: WideString read FMlsRawData write FMlsRawData;
    property CondoRawData: WideString read FCondoRawData write FCondoRawData;
    property MlsTranslatedData: WideString read FMlsTranslatedData write FMlsTranslatedData;
    property DateOfAnalysis: WideString read FDateOfAnalysis write FDateOfAnalysis;
  end;



  // ************************************************************************ //
  // Namespace : http://awstaging/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsListDetails = class(TRemotable)
  private
    FState: WideString;
    FMlsName: WideString;
  published
    property State: WideString read FState write FState;
    property MlsName: WideString read FMlsName write FMlsName;
  end;


  // ************************************************************************ //
  // Namespace : MarketConditionServerClass
  // soapAction: MarketConditionServerClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : MarketConditionServerBinding
  // service   : MarketConditionServer
  // port      : MarketConditionServerPort
  // URL       : http://awstaging/secure/ws/awsi/MarketConditionServer.php?debug=1
  // ************************************************************************ //
  MarketConditionServerPortType = interface(IInvokable)
  ['{F13B81FE-7BF5-864E-C838-AD358F1B3625}']
    function  MarketConditionServices_CreateMarketConditionReport(const UserCredentials: clsUserCredentials; const MlsDetails: clsMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMarketConditionConnectionResponse; stdcall;
    function  MarketConditionServices_CreateMonthlyMarketConditionReport(const UserCredentials: clsUserCredentials; const MlsDetails: clsMonthlyMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMonthlyMarketConditionConnectionResponse; stdcall;
    function  MarketConditionServices_CreateMonthlyMarketCondition2Report(const UserCredentials: clsUserCredentials; const MlsDetails: clsMonthlyMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMonthlyMarketCondition2ConnectionResponse; stdcall;
    function  MarketConditionServices_CreateMonthlyMarketCondition3Report(const UserCredentials: clsUserCredentials; const MlsDetails: clsMonthlyMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMonthlyMarketCondition3ConnectionResponse; stdcall;
    function  MarketConditionServices_CreateMonthlyMarketCondition4Report(const UserCredentials: clsUserCredentials; const MlsDetails: clsMonthlyMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMonthlyMarketCondition4ConnectionResponse; stdcall;
    function  MarketConditionServices_GetMlsDirectoryListing(const UserCredentials: clsUserCredentials; const MlsListingDetails: clsMlsListDetails): clsMlsDirectoryConnectionResponse; stdcall;
    function  MarketConditionServices_GetMlsDirectoryStatesListing(const UserCredentials: clsUserCredentials): clsMlsDirectoryStatesConnectionResponse; stdcall;
    function  MarketConditionServices_GetCustomerInfo(const AccessDetails: clsAccessDetails): clsCustomerInfoConnectionResponse; stdcall;
    function  MarketConditionServices_GetChartListing(const UserCredentials: clsUserCredentials): clsChartListConnectionResponse; stdcall;
    function  MarketConditionServices_Acknowledgement(const UserCredentials: clsUserCredentials; const Acknowledgement: clsAcknowledgement): clsAcknowledgementResponse; stdcall;
  end;

function GetMarketConditionServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MarketConditionServerPortType;


implementation

function GetMarketConditionServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MarketConditionServerPortType;
const
  defWSDL = 'http://awstaging/secure/ws/awsi/MarketConditionServer.php?wsdl';
  defURL  = 'http://awstaging/secure/ws/awsi/MarketConditionServer.php?debug=1';
  defSvc  = 'MarketConditionServer';
  defPrt  = 'MarketConditionServerPort';
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
    Result := (RIO as MarketConditionServerPortType);
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


destructor clsSubjectPropertyDetails.Destroy;
begin
  if Assigned(FSale_Price) then
    FSale_Price.Free;
  if Assigned(FOrg_Lst_Price) then
    FOrg_Lst_Price.Free;
  if Assigned(FList_Price) then
    FList_Price.Free;
  inherited Destroy;
end;

destructor clsUrarDataArray.Destroy;
begin
  if Assigned(Flistings) then
    Flistings.Free;
  if Assigned(Fsales) then
    Fsales.Free;
  inherited Destroy;
end;

destructor clsUrarResultsArray.Destroy;
begin
  if Assigned(FExtra_Comments) then
    FExtra_Comments.Free;
  if Assigned(FUrar1004_Data) then
    FUrar1004_Data.Free;
  inherited Destroy;
end;

destructor clsInventoryAnalysisArray.Destroy;
begin
  if Assigned(FMonths7To12) then
    FMonths7To12.Free;
  if Assigned(FMonths4To6) then
    FMonths4To6.Free;
  if Assigned(FMonths1To3) then
    FMonths1To3.Free;
  inherited Destroy;
end;

destructor clsMedianSalesArray.Destroy;
begin
  if Assigned(FMonths7To12) then
    FMonths7To12.Free;
  if Assigned(FMonths4To6) then
    FMonths4To6.Free;
  if Assigned(FMonths1To3) then
    FMonths1To3.Free;
  inherited Destroy;
end;

destructor clsMarketResultsArray.Destroy;
begin
  if Assigned(FInventoryAnalysis) then
    FInventoryAnalysis.Free;
  if Assigned(FMedianSales) then
    FMedianSales.Free;
  inherited Destroy;
end;

destructor clsCondoResultsArray.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FWorkFile)-1 do
    if Assigned(FWorkFile[I]) then
      FWorkFile[I].Free;
  SetLength(FWorkFile, 0);
  if Assigned(FInventoryAnalysis) then
    FInventoryAnalysis.Free;
  if Assigned(FMedianSales) then
    FMedianSales.Free;
  inherited Destroy;
end;

destructor clsAddendumsArrayItem.Destroy;
begin
  if Assigned(Fdata) then
    Fdata.Free;
  if Assigned(Fgraph) then
    Fgraph.Free;
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

destructor clsChartListConnectionResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResponseData)-1 do
    if Assigned(FResponseData[I]) then
      FResponseData[I].Free;
  SetLength(FResponseData, 0);
  if Assigned(FResults) then
    FResults.Free;
  inherited Destroy;
end;

destructor clsCustomerInfoConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsMarketConditionResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FGraphs)-1 do
    if Assigned(FGraphs[I]) then
      FGraphs[I].Free;
  SetLength(FGraphs, 0);
  for I := 0 to Length(FWorkFile)-1 do
    if Assigned(FWorkFile[I]) then
      FWorkFile[I].Free;
  SetLength(FWorkFile, 0);
  for I := 0 to Length(FAddendums)-1 do
    if Assigned(FAddendums[I]) then
      FAddendums[I].Free;
  SetLength(FAddendums, 0);
  for I := 0 to Length(FQuarterlyGraphs)-1 do
    if Assigned(FQuarterlyGraphs[I]) then
      FQuarterlyGraphs[I].Free;
  SetLength(FQuarterlyGraphs, 0);
  if Assigned(FMarketResults) then
    FMarketResults.Free;
  if Assigned(FUrarResults) then
    FUrarResults.Free;
  if Assigned(FCondoResults) then
    FCondoResults.Free;
  inherited Destroy;
end;

destructor clsMarketConditionConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketConditionResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMarketResults)-1 do
    if Assigned(FMarketResults[I]) then
      FMarketResults[I].Free;
  SetLength(FMarketResults, 0);
  inherited Destroy;
end;

destructor clsMonthlyMarketConditionConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsQuarterlyMarketResultsArray.Destroy;
begin
  if Assigned(FMonths10To12) then
    FMonths10To12.Free;
  if Assigned(FMonths7To9) then
    FMonths7To9.Free;
  if Assigned(FMonths4To6) then
    FMonths4To6.Free;
  if Assigned(FMonths1To3) then
    FMonths1To3.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition2ResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMarketResults)-1 do
    if Assigned(FMarketResults[I]) then
      FMarketResults[I].Free;
  SetLength(FMarketResults, 0);
  if Assigned(FQuarterlyResults) then
    FQuarterlyResults.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition2ConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsQuarterly3MarketResultsArray.Destroy;
begin
  if Assigned(FMonths7To12) then
    FMonths7To12.Free;
  if Assigned(FMonths10To12) then
    FMonths10To12.Free;
  if Assigned(FMonths7To9) then
    FMonths7To9.Free;
  if Assigned(FMonths4To6) then
    FMonths4To6.Free;
  if Assigned(FMonths1To3) then
    FMonths1To3.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition3ResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMarketResults)-1 do
    if Assigned(FMarketResults[I]) then
      FMarketResults[I].Free;
  SetLength(FMarketResults, 0);
  if Assigned(FQuarterlyResults) then
    FQuarterlyResults.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition3ConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsQuarterly4MarketResultsArray.Destroy;
begin
  if Assigned(FMonths7To12) then
    FMonths7To12.Free;
  if Assigned(FMonths10To12) then
    FMonths10To12.Free;
  if Assigned(FMonths7To9) then
    FMonths7To9.Free;
  if Assigned(FMonths4To6) then
    FMonths4To6.Free;
  if Assigned(FMonths1To3) then
    FMonths1To3.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition4ResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMarketResults)-1 do
    if Assigned(FMarketResults[I]) then
      FMarketResults[I].Free;
  SetLength(FMarketResults, 0);
  for I := 0 to Length(FGraphs)-1 do
    if Assigned(FGraphs[I]) then
      FGraphs[I].Free;
  SetLength(FGraphs, 0);
  for I := 0 to Length(FWorkFile)-1 do
    if Assigned(FWorkFile[I]) then
      FWorkFile[I].Free;
  SetLength(FWorkFile, 0);
  for I := 0 to Length(FAddendums)-1 do
    if Assigned(FAddendums[I]) then
      FAddendums[I].Free;
  SetLength(FAddendums, 0);
  for I := 0 to Length(FQuarterlyGraphs)-1 do
    if Assigned(FQuarterlyGraphs[I]) then
      FQuarterlyGraphs[I].Free;
  SetLength(FQuarterlyGraphs, 0);
  if Assigned(FUrarResults) then
    FUrarResults.Free;
  if Assigned(FCondoResults) then
    FCondoResults.Free;
  if Assigned(FQuarterlyResults) then
    FQuarterlyResults.Free;
  inherited Destroy;
end;

destructor clsMonthlyMarketCondition4ConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsMlsDirectoryResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMlsDirectory)-1 do
    if Assigned(FMlsDirectory[I]) then
      FMlsDirectory[I].Free;
  SetLength(FMlsDirectory, 0);
  inherited Destroy;
end;

destructor clsMlsDirectoryConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

destructor clsMlsDirectoryStatesConnectionResponse.Destroy;
begin
  if Assigned(FResults) then
    FResults.Free;
  if Assigned(FResponseData) then
    FResponseData.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MarketConditionServerPortType), 'MarketConditionServerClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MarketConditionServerPortType), 'MarketConditionServerClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMarketConditionReport', 'MarketConditionServices.CreateMarketConditionReport');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMonthlyMarketConditionReport', 'MarketConditionServices.CreateMonthlyMarketConditionReport');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMonthlyMarketCondition2Report', 'MarketConditionServices.CreateMonthlyMarketCondition2Report');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMonthlyMarketCondition3Report', 'MarketConditionServices.CreateMonthlyMarketCondition3Report');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMonthlyMarketCondition4Report', 'MarketConditionServices.CreateMonthlyMarketCondition4Report');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetMlsDirectoryListing', 'MarketConditionServices.GetMlsDirectoryListing');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetMlsDirectoryStatesListing', 'MarketConditionServices.GetMlsDirectoryStatesListing');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetCustomerInfo', 'MarketConditionServices.GetCustomerInfo');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetChartListing', 'MarketConditionServices.GetChartListing');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_Acknowledgement', 'MarketConditionServices.Acknowledgement');
  RemClassRegistry.RegisterXSClass(clsUserCredentials, 'http://awstaging/secure/ws/WSDL', 'clsUserCredentials');
  RemClassRegistry.RegisterXSClass(clsSubjectPropertyDetails, 'http://awstaging/secure/ws/WSDL', 'clsSubjectPropertyDetails');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://awstaging/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsExtraCommentsArray, 'http://awstaging/secure/ws/WSDL', 'clsExtraCommentsArray');
  RemClassRegistry.RegisterXSClass(clsCountHighLowArray, 'http://awstaging/secure/ws/WSDL', 'clsCountHighLowArray');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsCountHighLowArray), 'high_', 'high');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsCountHighLowArray), 'low_', 'low');
  RemClassRegistry.RegisterXSClass(clsUrarDataArray, 'http://awstaging/secure/ws/WSDL', 'clsUrarDataArray');
  RemClassRegistry.RegisterXSClass(clsUrarResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsUrarResultsArray');
  RemClassRegistry.RegisterXSClass(clsAnalysisArray, 'http://awstaging/secure/ws/WSDL', 'clsAnalysisArray');
  RemClassRegistry.RegisterXSClass(clsInventoryAnalysisArray, 'http://awstaging/secure/ws/WSDL', 'clsInventoryAnalysisArray');
  RemClassRegistry.RegisterXSClass(clsMedianSalesArrayItem, 'http://awstaging/secure/ws/WSDL', 'clsMedianSalesArrayItem');
  RemClassRegistry.RegisterXSClass(clsMedianSalesArray, 'http://awstaging/secure/ws/WSDL', 'clsMedianSalesArray');
  RemClassRegistry.RegisterXSClass(clsMarketResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsMarketResultsArray');
  RemClassRegistry.RegisterXSClass(clsWorkfileArrayItem, 'http://awstaging/secure/ws/WSDL', 'clsWorkfileArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsWorkfileArray), 'http://awstaging/secure/ws/WSDL', 'clsWorkfileArray');
  RemClassRegistry.RegisterXSClass(clsCondoResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsCondoResultsArray');
  RemClassRegistry.RegisterXSClass(clsGraphArrayItem, 'http://awstaging/secure/ws/WSDL', 'clsGraphArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsFootnotesDataArray), 'http://awstaging/secure/ws/WSDL', 'clsFootnotesDataArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumMonthsArray), 'http://awstaging/secure/ws/WSDL', 'clsAddendumMonthsArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumMedianPriceArray), 'http://awstaging/secure/ws/WSDL', 'clsAddendumMedianPriceArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumCurrentMedianArray), 'http://awstaging/secure/ws/WSDL', 'clsAddendumCurrentMedianArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumChangeArray), 'http://awstaging/secure/ws/WSDL', 'clsAddendumChangeArray');
  RemClassRegistry.RegisterXSClass(clsAddendumDataArray, 'http://awstaging/secure/ws/WSDL', 'clsAddendumDataArray');
  RemClassRegistry.RegisterXSClass(clsAddendumsArrayItem, 'http://awstaging/secure/ws/WSDL', 'clsAddendumsArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumsArray), 'http://awstaging/secure/ws/WSDL', 'clsAddendumsArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGraphArray), 'http://awstaging/secure/ws/WSDL', 'clsGraphArray');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponseData, 'http://awstaging/secure/ws/WSDL', 'clsAcknowledgementResponseData');
  RemClassRegistry.RegisterXSClass(clsAcknowledgementResponse, 'http://awstaging/secure/ws/WSDL', 'clsAcknowledgementResponse');
  RemClassRegistry.RegisterXSClass(clsChartListItem, 'http://awstaging/secure/ws/WSDL', 'clsChartListItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsChartListItem), 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsChartListData), 'http://awstaging/secure/ws/WSDL', 'clsChartListData');
  RemClassRegistry.RegisterXSClass(clsChartListConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsChartListConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsCustomerInfo, 'http://awstaging/secure/ws/WSDL', 'clsCustomerInfo');
  RemClassRegistry.RegisterXSClass(clsCustomerInfoConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsCustomerInfoConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsMarketConditionResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMarketConditionResponseData');
  RemClassRegistry.RegisterXSClass(clsMarketConditionConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMarketConditionConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsMonthlyColumnItem, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyColumnItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMonthlyMarketResultsArray), 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketResultsArray');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketConditionResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketConditionResponseData');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketConditionConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketConditionConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsQuarterlyColumnItem, 'http://awstaging/secure/ws/WSDL', 'clsQuarterlyColumnItem');
  RemClassRegistry.RegisterXSClass(clsQuarterlyMarketResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsQuarterlyMarketResultsArray');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition2ResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition2ResponseData');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition2ConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition2ConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMonthlyMarket3ResultsArray), 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarket3ResultsArray');
  RemClassRegistry.RegisterXSClass(clsQuarterly3ColumnItem, 'http://awstaging/secure/ws/WSDL', 'clsQuarterly3ColumnItem');
  RemClassRegistry.RegisterXSClass(clsQuarterly3MarketResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsQuarterly3MarketResultsArray');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition3ResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition3ResponseData');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition3ConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition3ConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMonthlyMarket4ResultsArray), 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarket4ResultsArray');
  RemClassRegistry.RegisterXSClass(clsQuarterly4ColumnItem, 'http://awstaging/secure/ws/WSDL', 'clsQuarterly4ColumnItem');
  RemClassRegistry.RegisterXSClass(clsQuarterly4MarketResultsArray, 'http://awstaging/secure/ws/WSDL', 'clsQuarterly4MarketResultsArray');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition4ResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition4ResponseData');
  RemClassRegistry.RegisterXSClass(clsMonthlyMarketCondition4ConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMarketCondition4ConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryArrayItem, 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsDirectoryListing), 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryListing');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryResponseData');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsDirectoryStatesListing), 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryStatesListing');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryStatesResponseData, 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryStatesResponseData');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryStatesConnectionResponse, 'http://awstaging/secure/ws/WSDL', 'clsMlsDirectoryStatesConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsAcknowledgement, 'http://awstaging/secure/ws/WSDL', 'clsAcknowledgement');
  RemClassRegistry.RegisterXSClass(clsAccessDetails, 'http://awstaging/secure/ws/WSDL', 'clsAccessDetails');
  RemClassRegistry.RegisterXSClass(clsMlsRequestDetails, 'http://awstaging/secure/ws/WSDL', 'clsMlsRequestDetails');
  RemClassRegistry.RegisterXSClass(clsMonthlyMlsRequestDetails, 'http://awstaging/secure/ws/WSDL', 'clsMonthlyMlsRequestDetails');
  RemClassRegistry.RegisterXSClass(clsMlsListDetails, 'http://awstaging/secure/ws/WSDL', 'clsMlsListDetails');

end.