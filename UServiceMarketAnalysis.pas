// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl
//  >Import : http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl:0
// Encoding : ISO-8859-1
// Version  : 1.0
// (11/23/2009 1:20:04 PM - - $Rev: 10138 $)
// ************************************************************************ //

unit UServiceMarketAnalysis;

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
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]

  clsMlsDirectoryConnectionResponse = class;    { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsDirectoryResponseData = class;          { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsDirectoryArrayItem = class;             { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsDirectoryStatesConnectionResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsDirectoryStatesResponseData = class;    { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMarketConditionConnectionResponse = class;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsResults           = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMarketResultsArray = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUrarResultsArray  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMarketConditionResponseData = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCondoResultsArray = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsExtraCommentsArray = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsUrarDataArray     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCountHighLowArray = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsInventoryAnalysisArray = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMedianSalesArray  = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsGraphArrayItem    = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddendumsArrayItem = class;                { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddendumDataArray = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAnalysisArray     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMedianSalesArrayItem = class;              { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsWorkfileArrayItem = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCustomerInfoConnectionResponse = class;    { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsCustomerInfo      = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsChartListConnectionResponse = class;       { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsChartListItem     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsTransactionData   = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsListDetails    = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsSubjectPropertyDetails = class;            { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsMlsRequestDetails = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAccessDetails     = class;                 { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }



  // ************************************************************************ //
  // XML       : clsMlsDirectoryConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsDirectoryResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                   read FResults write FResults;
    property ResponseData: clsMlsDirectoryResponseData  read FResponseData write FResponseData;
  end;

  clsMlsDirectoryListing = array of clsMlsDirectoryArrayItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsMlsDirectoryResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryResponseData = class(TRemotable)
  private
    FMlsDirectory: clsMlsDirectoryListing;
  public
    destructor Destroy; override;
  published
    property MlsDirectory: clsMlsDirectoryListing  read FMlsDirectory write FMlsDirectory;
  end;



  // ************************************************************************ //
  // XML       : clsMlsDirectoryArrayItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryArrayItem = class(TRemotable)
  private
    FState: WideString;
    FMls_Full_Name: WideString;
    FMls_Name: WideString;
    FMls_Url: WideString;
  published
    property State:         WideString  read FState write FState;
    property Mls_Full_Name: WideString  read FMls_Full_Name write FMls_Full_Name;
    property Mls_Name:      WideString  read FMls_Name write FMls_Name;
    property Mls_Url:       WideString  read FMls_Url write FMls_Url;
  end;



  // ************************************************************************ //
  // XML       : clsMlsDirectoryStatesConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryStatesConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMlsDirectoryStatesResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                         read FResults write FResults;
    property ResponseData: clsMlsDirectoryStatesResponseData  read FResponseData write FResponseData;
  end;

  clsMlsDirectoryStatesListing = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsMlsDirectoryStatesResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsDirectoryStatesResponseData = class(TRemotable)
  private
    FMlsStates: clsMlsDirectoryStatesListing;
  published
    property MlsStates: clsMlsDirectoryStatesListing  read FMlsStates write FMlsStates;
  end;



  // ************************************************************************ //
  // XML       : clsMarketConditionConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketConditionConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsMarketConditionResponseData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults                      read FResults write FResults;
    property ResponseData: clsMarketConditionResponseData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsResults, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
  // XML       : clsMarketResultsArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketResultsArray = class(TRemotable)
  private
    FInventoryAnalysis: clsInventoryAnalysisArray;
    FMedianSales: clsMedianSalesArray;
  public
    destructor Destroy; override;
  published
    property InventoryAnalysis: clsInventoryAnalysisArray  read FInventoryAnalysis write FInventoryAnalysis;
    property MedianSales:       clsMedianSalesArray        read FMedianSales write FMedianSales;
  end;

  clsGraphArray = array of clsGraphArrayItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsWorkfileArray = array of clsWorkfileArrayItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsUrarResultsArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUrarResultsArray = class(TRemotable)
  private
    FExtra_Comments: clsExtraCommentsArray;
    FUrar1004_Data: clsUrarDataArray;
  public
    destructor Destroy; override;
  published
    property Extra_Comments: clsExtraCommentsArray  read FExtra_Comments write FExtra_Comments;
    property Urar1004_Data:  clsUrarDataArray       read FUrar1004_Data write FUrar1004_Data;
  end;

  clsAddendumsArray = array of clsAddendumsArrayItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsMarketConditionResponseData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMarketConditionResponseData = class(TRemotable)
  private
    FMarketResults: clsMarketResultsArray;
    FGraphs: clsGraphArray;
    FWorkFile: clsWorkfileArray;
    FUrarResults: clsUrarResultsArray;
    FUrarResults_Specified: boolean;
    FAddendums: clsAddendumsArray;
    FAddendums_Specified: boolean;
    FCondoResults: clsCondoResultsArray;
    FCondoResults_Specified: boolean;
    FQuarterlyGraphs: clsGraphArray;
    FQuarterlyGraphs_Specified: boolean;
    procedure SetUrarResults(Index: Integer; const AclsUrarResultsArray: clsUrarResultsArray);
    function  UrarResults_Specified(Index: Integer): boolean;
    procedure SetAddendums(Index: Integer; const AclsAddendumsArray: clsAddendumsArray);
    function  Addendums_Specified(Index: Integer): boolean;
    procedure SetCondoResults(Index: Integer; const AclsCondoResultsArray: clsCondoResultsArray);
    function  CondoResults_Specified(Index: Integer): boolean;
    procedure SetQuarterlyGraphs(Index: Integer; const AclsGraphArray: clsGraphArray);
    function  QuarterlyGraphs_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property MarketResults:   clsMarketResultsArray  read FMarketResults write FMarketResults;
    property Graphs:          clsGraphArray          read FGraphs write FGraphs;
    property WorkFile:        clsWorkfileArray       read FWorkFile write FWorkFile;
    property UrarResults:     clsUrarResultsArray    Index (IS_OPTN) read FUrarResults write SetUrarResults stored UrarResults_Specified;
    property Addendums:       clsAddendumsArray      Index (IS_OPTN) read FAddendums write SetAddendums stored Addendums_Specified;
    property CondoResults:    clsCondoResultsArray   Index (IS_OPTN) read FCondoResults write SetCondoResults stored CondoResults_Specified;
    property QuarterlyGraphs: clsGraphArray          Index (IS_OPTN) read FQuarterlyGraphs write SetQuarterlyGraphs stored QuarterlyGraphs_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsCondoResultsArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCondoResultsArray = class(TRemotable)
  private
    FInventoryAnalysis: clsInventoryAnalysisArray;
    FMedianSales: clsMedianSalesArray;
    FWorkFile: clsWorkfileArray;
    FSalesCount: Integer;
    FSalesCount_Specified: boolean;
    procedure SetSalesCount(Index: Integer; const AInteger: Integer);
    function  SalesCount_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property InventoryAnalysis: clsInventoryAnalysisArray  read FInventoryAnalysis write FInventoryAnalysis;
    property MedianSales:       clsMedianSalesArray        read FMedianSales write FMedianSales;
    property WorkFile:          clsWorkfileArray           read FWorkFile write FWorkFile;
    property SalesCount:        Integer                    Index (IS_OPTN) read FSalesCount write SetSalesCount stored SalesCount_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsExtraCommentsArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsExtraCommentsArray = class(TRemotable)
  private
    Fsummary_1004mc: WideString;
    Furar_comments: WideString;
  published
    property summary_1004mc: WideString  read Fsummary_1004mc write Fsummary_1004mc;
    property urar_comments:  WideString  read Furar_comments write Furar_comments;
  end;



  // ************************************************************************ //
  // XML       : clsUrarDataArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsUrarDataArray = class(TRemotable)
  private
    Flistings: clsCountHighLowArray;
    Fsales: clsCountHighLowArray;
  public
    destructor Destroy; override;
  published
    property listings: clsCountHighLowArray  read Flistings write Flistings;
    property sales:    clsCountHighLowArray  read Fsales write Fsales;
  end;



  // ************************************************************************ //
  // XML       : clsCountHighLowArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCountHighLowArray = class(TRemotable)
  private
    Fcount: Integer;
    Fhigh_: Integer;
    Flow_: Integer;
  published
    property count: Integer  read Fcount write Fcount;
    property high_: Integer  read Fhigh_ write Fhigh_;
    property low_:  Integer  read Flow_ write Flow_;
  end;



  // ************************************************************************ //
  // XML       : clsInventoryAnalysisArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsInventoryAnalysisArray = class(TRemotable)
  private
    FMonths7To12: clsAnalysisArray;
    FMonths4To6: clsAnalysisArray;
    FMonths1To3: clsAnalysisArray;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsAnalysisArray  read FMonths7To12 write FMonths7To12;
    property Months4To6:  clsAnalysisArray  read FMonths4To6 write FMonths4To6;
    property Months1To3:  clsAnalysisArray  read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // XML       : clsMedianSalesArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMedianSalesArray = class(TRemotable)
  private
    FMonths7To12: clsMedianSalesArrayItem;
    FMonths4To6: clsMedianSalesArrayItem;
    FMonths1To3: clsMedianSalesArrayItem;
  public
    destructor Destroy; override;
  published
    property Months7To12: clsMedianSalesArrayItem  read FMonths7To12 write FMonths7To12;
    property Months4To6:  clsMedianSalesArrayItem  read FMonths4To6 write FMonths4To6;
    property Months1To3:  clsMedianSalesArrayItem  read FMonths1To3 write FMonths1To3;
  end;



  // ************************************************************************ //
  // XML       : clsGraphArrayItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsGraphArrayItem = class(TRemotable)
  private
    Ftitle: WideString;
    Fchart: WideString;
    Fcomments: WideString;
  published
    property title:    WideString  read Ftitle write Ftitle;
    property chart:    WideString  read Fchart write Fchart;
    property comments: WideString  read Fcomments write Fcomments;
  end;

  clsFootnotesDataArray = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsAddendumsArrayItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddendumsArrayItem = class(TRemotable)
  private
    Faddendum_name: WideString;
    Fdata: clsAddendumDataArray;
    Fdata_Specified: boolean;
    Fgraph: clsGraphArrayItem;
    Fgraph_Specified: boolean;
    Ffootnotes: clsFootnotesDataArray;
    Ffootnotes_Specified: boolean;
    procedure Setdata(Index: Integer; const AclsAddendumDataArray: clsAddendumDataArray);
    function  data_Specified(Index: Integer): boolean;
    procedure Setgraph(Index: Integer; const AclsGraphArrayItem: clsGraphArrayItem);
    function  graph_Specified(Index: Integer): boolean;
    procedure Setfootnotes(Index: Integer; const AclsFootnotesDataArray: clsFootnotesDataArray);
    function  footnotes_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property addendum_name: WideString             read Faddendum_name write Faddendum_name;
    property data:          clsAddendumDataArray   Index (IS_OPTN) read Fdata write Setdata stored data_Specified;
    property graph:         clsGraphArrayItem      Index (IS_OPTN) read Fgraph write Setgraph stored graph_Specified;
    property footnotes:     clsFootnotesDataArray  Index (IS_OPTN) read Ffootnotes write Setfootnotes stored footnotes_Specified;
  end;

  clsAddendumMonthsArray = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddendumMedianPriceArray = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddendumCurrentMedianArray = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }
  clsAddendumChangeArray = array of WideString;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsAddendumDataArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAddendumDataArray = class(TRemotable)
  private
    Fmonth: clsAddendumMonthsArray;
    Fmonth_Specified: boolean;
    Fmedian_price: clsAddendumMedianPriceArray;
    Fmedian_price_Specified: boolean;
    Fcurrent_median: clsAddendumCurrentMedianArray;
    Fcurrent_median_Specified: boolean;
    Fchange_to_current: clsAddendumChangeArray;
    Fchange_to_current_Specified: boolean;
    procedure Setmonth(Index: Integer; const AclsAddendumMonthsArray: clsAddendumMonthsArray);
    function  month_Specified(Index: Integer): boolean;
    procedure Setmedian_price(Index: Integer; const AclsAddendumMedianPriceArray: clsAddendumMedianPriceArray);
    function  median_price_Specified(Index: Integer): boolean;
    procedure Setcurrent_median(Index: Integer; const AclsAddendumCurrentMedianArray: clsAddendumCurrentMedianArray);
    function  current_median_Specified(Index: Integer): boolean;
    procedure Setchange_to_current(Index: Integer; const AclsAddendumChangeArray: clsAddendumChangeArray);
    function  change_to_current_Specified(Index: Integer): boolean;
  published
    property month:             clsAddendumMonthsArray         Index (IS_OPTN) read Fmonth write Setmonth stored month_Specified;
    property median_price:      clsAddendumMedianPriceArray    Index (IS_OPTN) read Fmedian_price write Setmedian_price stored median_price_Specified;
    property current_median:    clsAddendumCurrentMedianArray  Index (IS_OPTN) read Fcurrent_median write Setcurrent_median stored current_median_Specified;
    property change_to_current: clsAddendumChangeArray         Index (IS_OPTN) read Fchange_to_current write Setchange_to_current stored change_to_current_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsAnalysisArray, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
    property sold:             Integer  read Fsold write Fsold;
    property active:           Integer  read Factive write Factive;
    property pending:          Integer  read Fpending write Fpending;
    property pending_orig:     Integer  read Fpending_orig write Fpending_orig;
    property pending_sold:     Integer  read Fpending_sold write Fpending_sold;
    property absorption_rate:  Single   read Fabsorption_rate write Fabsorption_rate;
    property months_of_supply: Single   read Fmonths_of_supply write Fmonths_of_supply;
  end;



  // ************************************************************************ //
  // XML       : clsMedianSalesArrayItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMedianSalesArrayItem = class(TRemotable)
  private
    Fsale_prices: Integer;
    Freal_doms: Single;
    Fratios: Single;
    Flist_prices: Integer;
    Flisting_days: Single;
  published
    property sale_prices:  Integer  read Fsale_prices write Fsale_prices;
    property real_doms:    Single   read Freal_doms write Freal_doms;
    property ratios:       Single   read Fratios write Fratios;
    property list_prices:  Integer  read Flist_prices write Flist_prices;
    property listing_days: Single   read Flisting_days write Flisting_days;
  end;



  // ************************************************************************ //
  // XML       : clsWorkfileArrayItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
    property DOM:          WideString  read FDOM write FDOM;
    property ListingDate:  WideString  read FListingDate write FListingDate;
    property ListingPrice: WideString  read FListingPrice write FListingPrice;
    property PendingDate:  WideString  read FPendingDate write FPendingDate;
    property SellingDate:  WideString  read FSellingDate write FSellingDate;
    property SellingPrice: WideString  read FSellingPrice write FSellingPrice;
    property Status:       WideString  read FStatus write FStatus;
    property StatusDate:   WideString  read FStatusDate write FStatusDate;
    property REO:          WideString  read FREO write FREO;
  end;



  // ************************************************************************ //
  // XML       : clsCustomerInfoConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCustomerInfoConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsCustomerInfo;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults       read FResults write FResults;
    property ResponseData: clsCustomerInfo  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsCustomerInfo, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsCustomerInfo = class(TRemotable)
  private
    FID: Integer;
    FEmailAddress: WideString;
    FPassword: WideString;
    FPublicKey: WideString;
  published
    property ID:           Integer     read FID write FID;
    property EmailAddress: WideString  read FEmailAddress write FEmailAddress;
    property Password:     WideString  read FPassword write FPassword;
    property PublicKey:    WideString  read FPublicKey write FPublicKey;
  end;

  clsChartListData = array of clsChartListItem;   { "http://carme.atbx.net/secure/ws/WSDL"[GblCplx] }


  // ************************************************************************ //
  // XML       : clsChartListConnectionResponse, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsChartListConnectionResponse = class(TRemotable)
  private
    FResults: clsResults;
    FResponseData: clsChartListData;
  public
    destructor Destroy; override;
  published
    property Results:      clsResults        read FResults write FResults;
    property ResponseData: clsChartListData  read FResponseData write FResponseData;
  end;



  // ************************************************************************ //
  // XML       : clsChartListItem, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsChartListItem = class(TRemotable)
  private
    Ftitle: WideString;
    Ftype_: WideString;
  published
    property title: WideString  read Ftitle write Ftitle;
    property type_: WideString  read Ftype_ write Ftype_;
  end;



  // ************************************************************************ //
  // XML       : clsTransactionData, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsTransactionData = class(TRemotable)
  private
    FOrderNum: WideString;
    FTransactionType: Integer;
    FUsername: WideString;
    FPassword: WideString;
  published
    property OrderNum:        WideString  read FOrderNum write FOrderNum;
    property TransactionType: Integer     read FTransactionType write FTransactionType;
    property Username:        WideString  read FUsername write FUsername;
    property Password:        WideString  read FPassword write FPassword;
  end;



  // ************************************************************************ //
  // XML       : clsMlsListDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsListDetails = class(TRemotable)
  private
    FState: WideString;
    FMlsName: WideString;
  published
    property State:   WideString  read FState write FState;
    property MlsName: WideString  read FMlsName write FMlsName;
  end;



  // ************************************************************************ //
  // XML       : clsSubjectPropertyDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
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
    FLongitude_Specified: boolean;
    FLatitude: WideString;
    FLatitude_Specified: boolean;
    FStatus: WideString;
    FStatus_Specified: boolean;
    FStreet_Number: WideString;
    FStreet_Number_Specified: boolean;
    FStreet_Name: WideString;
    FStreet_Name_Specified: boolean;
    FUnit_Number: WideString;
    FUnit_Number_Specified: boolean;
    FClosing_Date: WideString;
    FClosing_Date_Specified: boolean;
    FSale_Price: TXSDecimal;
    FSale_Price_Specified: boolean;
    FOrg_Lst_Price: TXSDecimal;
    FOrg_Lst_Price_Specified: boolean;
    FList_Price: TXSDecimal;
    FList_Price_Specified: boolean;
    FList_Date: WideString;
    FList_Date_Specified: boolean;
    FOff_Mkt_Date: WideString;
    FOff_Mkt_Date_Specified: boolean;
    FSquare_Feet: Integer;
    FSquare_Feet_Specified: boolean;
    FBedrooms: Integer;
    FBedrooms_Specified: boolean;
    FBaths_Full: Integer;
    FBaths_Full_Specified: boolean;
    FBaths_Half: Integer;
    FBaths_Half_Specified: boolean;
    FLot_Descr: WideString;
    FLot_Descr_Specified: boolean;
    FYear_Built: Integer;
    FYear_Built_Specified: boolean;
    FSubdivision: WideString;
    FSubdivision_Specified: boolean;
    FBasement: WideString;
    FBasement_Specified: boolean;
    FParking: WideString;
    FParking_Specified: boolean;
    FListing_Numb: WideString;
    FListing_Numb_Specified: boolean;
    FREO: WideString;
    FREO_Specified: boolean;
    FRemarks: WideString;
    FRemarks_Specified: boolean;
    FZip_Code: WideString;
    FZip_Code_Specified: boolean;
    procedure SetLongitude(Index: Integer; const AWideString: WideString);
    function  Longitude_Specified(Index: Integer): boolean;
    procedure SetLatitude(Index: Integer; const AWideString: WideString);
    function  Latitude_Specified(Index: Integer): boolean;
    procedure SetStatus(Index: Integer; const AWideString: WideString);
    function  Status_Specified(Index: Integer): boolean;
    procedure SetStreet_Number(Index: Integer; const AWideString: WideString);
    function  Street_Number_Specified(Index: Integer): boolean;
    procedure SetStreet_Name(Index: Integer; const AWideString: WideString);
    function  Street_Name_Specified(Index: Integer): boolean;
    procedure SetUnit_Number(Index: Integer; const AWideString: WideString);
    function  Unit_Number_Specified(Index: Integer): boolean;
    procedure SetClosing_Date(Index: Integer; const AWideString: WideString);
    function  Closing_Date_Specified(Index: Integer): boolean;
    procedure SetSale_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  Sale_Price_Specified(Index: Integer): boolean;
    procedure SetOrg_Lst_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  Org_Lst_Price_Specified(Index: Integer): boolean;
    procedure SetList_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  List_Price_Specified(Index: Integer): boolean;
    procedure SetList_Date(Index: Integer; const AWideString: WideString);
    function  List_Date_Specified(Index: Integer): boolean;
    procedure SetOff_Mkt_Date(Index: Integer; const AWideString: WideString);
    function  Off_Mkt_Date_Specified(Index: Integer): boolean;
    procedure SetSquare_Feet(Index: Integer; const AInteger: Integer);
    function  Square_Feet_Specified(Index: Integer): boolean;
    procedure SetBedrooms(Index: Integer; const AInteger: Integer);
    function  Bedrooms_Specified(Index: Integer): boolean;
    procedure SetBaths_Full(Index: Integer; const AInteger: Integer);
    function  Baths_Full_Specified(Index: Integer): boolean;
    procedure SetBaths_Half(Index: Integer; const AInteger: Integer);
    function  Baths_Half_Specified(Index: Integer): boolean;
    procedure SetLot_Descr(Index: Integer; const AWideString: WideString);
    function  Lot_Descr_Specified(Index: Integer): boolean;
    procedure SetYear_Built(Index: Integer; const AInteger: Integer);
    function  Year_Built_Specified(Index: Integer): boolean;
    procedure SetSubdivision(Index: Integer; const AWideString: WideString);
    function  Subdivision_Specified(Index: Integer): boolean;
    procedure SetBasement(Index: Integer; const AWideString: WideString);
    function  Basement_Specified(Index: Integer): boolean;
    procedure SetParking(Index: Integer; const AWideString: WideString);
    function  Parking_Specified(Index: Integer): boolean;
    procedure SetListing_Numb(Index: Integer; const AWideString: WideString);
    function  Listing_Numb_Specified(Index: Integer): boolean;
    procedure SetREO(Index: Integer; const AWideString: WideString);
    function  REO_Specified(Index: Integer): boolean;
    procedure SetRemarks(Index: Integer; const AWideString: WideString);
    function  Remarks_Specified(Index: Integer): boolean;
    procedure SetZip_Code(Index: Integer; const AWideString: WideString);
    function  Zip_Code_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property AWUserID:      WideString  read FAWUserID write FAWUserID;
    property AppraisalDate: WideString  read FAppraisalDate write FAppraisalDate;
    property AppraisalType: WideString  read FAppraisalType write FAppraisalType;
    property Address:       WideString  read FAddress write FAddress;
    property City:          WideString  read FCity write FCity;
    property State:         WideString  read FState write FState;
    property ZipCode:       WideString  read FZipCode write FZipCode;
    property Longitude:     WideString  Index (IS_OPTN) read FLongitude write SetLongitude stored Longitude_Specified;
    property Latitude:      WideString  Index (IS_OPTN) read FLatitude write SetLatitude stored Latitude_Specified;
    property Status:        WideString  Index (IS_OPTN) read FStatus write SetStatus stored Status_Specified;
    property Street_Number: WideString  Index (IS_OPTN) read FStreet_Number write SetStreet_Number stored Street_Number_Specified;
    property Street_Name:   WideString  Index (IS_OPTN) read FStreet_Name write SetStreet_Name stored Street_Name_Specified;
    property Unit_Number:   WideString  Index (IS_OPTN) read FUnit_Number write SetUnit_Number stored Unit_Number_Specified;
    property Closing_Date:  WideString  Index (IS_OPTN) read FClosing_Date write SetClosing_Date stored Closing_Date_Specified;
    property Sale_Price:    TXSDecimal  Index (IS_OPTN) read FSale_Price write SetSale_Price stored Sale_Price_Specified;
    property Org_Lst_Price: TXSDecimal  Index (IS_OPTN) read FOrg_Lst_Price write SetOrg_Lst_Price stored Org_Lst_Price_Specified;
    property List_Price:    TXSDecimal  Index (IS_OPTN) read FList_Price write SetList_Price stored List_Price_Specified;
    property List_Date:     WideString  Index (IS_OPTN) read FList_Date write SetList_Date stored List_Date_Specified;
    property Off_Mkt_Date:  WideString  Index (IS_OPTN) read FOff_Mkt_Date write SetOff_Mkt_Date stored Off_Mkt_Date_Specified;
    property Square_Feet:   Integer     Index (IS_OPTN) read FSquare_Feet write SetSquare_Feet stored Square_Feet_Specified;
    property Bedrooms:      Integer     Index (IS_OPTN) read FBedrooms write SetBedrooms stored Bedrooms_Specified;
    property Baths_Full:    Integer     Index (IS_OPTN) read FBaths_Full write SetBaths_Full stored Baths_Full_Specified;
    property Baths_Half:    Integer     Index (IS_OPTN) read FBaths_Half write SetBaths_Half stored Baths_Half_Specified;
    property Lot_Descr:     WideString  Index (IS_OPTN) read FLot_Descr write SetLot_Descr stored Lot_Descr_Specified;
    property Year_Built:    Integer     Index (IS_OPTN) read FYear_Built write SetYear_Built stored Year_Built_Specified;
    property Subdivision:   WideString  Index (IS_OPTN) read FSubdivision write SetSubdivision stored Subdivision_Specified;
    property Basement:      WideString  Index (IS_OPTN) read FBasement write SetBasement stored Basement_Specified;
    property Parking:       WideString  Index (IS_OPTN) read FParking write SetParking stored Parking_Specified;
    property Listing_Numb:  WideString  Index (IS_OPTN) read FListing_Numb write SetListing_Numb stored Listing_Numb_Specified;
    property REO:           WideString  Index (IS_OPTN) read FREO write SetREO stored REO_Specified;
    property Remarks:       WideString  Index (IS_OPTN) read FRemarks write SetRemarks stored Remarks_Specified;
    property Zip_Code:      WideString  Index (IS_OPTN) read FZip_Code write SetZip_Code stored Zip_Code_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsMlsRequestDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsMlsRequestDetails = class(TRemotable)
  private
    FMlsName: WideString;
    FMlsName_Specified: boolean;
    FPendingSaleFlag: Integer;
    FPendingSaleFlag_Specified: boolean;
    FMlsRawData: WideString;
    FMlsRawData_Specified: boolean;
    FCondoRawData: WideString;
    FCondoRawData_Specified: boolean;
    FMlsTranslatedData: WideString;
    FMlsTranslatedData_Specified: boolean;
    FDateOfAnalysis: WideString;
    FDateOfAnalysis_Specified: boolean;
    FChartGroup: Integer;
    FChartGroup_Specified: boolean;
    procedure SetMlsName(Index: Integer; const AWideString: WideString);
    function  MlsName_Specified(Index: Integer): boolean;
    procedure SetPendingSaleFlag(Index: Integer; const AInteger: Integer);
    function  PendingSaleFlag_Specified(Index: Integer): boolean;
    procedure SetMlsRawData(Index: Integer; const AWideString: WideString);
    function  MlsRawData_Specified(Index: Integer): boolean;
    procedure SetCondoRawData(Index: Integer; const AWideString: WideString);
    function  CondoRawData_Specified(Index: Integer): boolean;
    procedure SetMlsTranslatedData(Index: Integer; const AWideString: WideString);
    function  MlsTranslatedData_Specified(Index: Integer): boolean;
    procedure SetDateOfAnalysis(Index: Integer; const AWideString: WideString);
    function  DateOfAnalysis_Specified(Index: Integer): boolean;
    procedure SetChartGroup(Index: Integer; const AInteger: Integer);
    function  ChartGroup_Specified(Index: Integer): boolean;
  published
    property MlsName:           WideString  Index (IS_OPTN) read FMlsName write SetMlsName stored MlsName_Specified;
    property PendingSaleFlag:   Integer     Index (IS_OPTN) read FPendingSaleFlag write SetPendingSaleFlag stored PendingSaleFlag_Specified;
    property MlsRawData:        WideString  Index (IS_OPTN) read FMlsRawData write SetMlsRawData stored MlsRawData_Specified;
    property CondoRawData:      WideString  Index (IS_OPTN) read FCondoRawData write SetCondoRawData stored CondoRawData_Specified;
    property MlsTranslatedData: WideString  Index (IS_OPTN) read FMlsTranslatedData write SetMlsTranslatedData stored MlsTranslatedData_Specified;
    property DateOfAnalysis:    WideString  Index (IS_OPTN) read FDateOfAnalysis write SetDateOfAnalysis stored DateOfAnalysis_Specified;
    property ChartGroup:        Integer     Index (IS_OPTN) read FChartGroup write SetChartGroup stored ChartGroup_Specified;
  end;



  // ************************************************************************ //
  // XML       : clsAccessDetails, global, <complexType>
  // Namespace : http://carme.atbx.net/secure/ws/WSDL
  // ************************************************************************ //
  clsAccessDetails = class(TRemotable)
  private
    FID: Integer;
    FAccessKey: WideString;
  published
    property ID:        Integer     read FID write FID;
    property AccessKey: WideString  read FAccessKey write FAccessKey;
  end;


  // ************************************************************************ //
  // Namespace : MarketConditionServicesClass
  // soapAction: MarketConditionServicesClass#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : MarketConditionServerBinding
  // service   : MarketConditionServer
  // port      : MarketConditionServerPort
  // URL       : http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php
  // ************************************************************************ //
  MarketConditionServerPortType = interface(IInvokable)
  ['{B8461D7D-F814-DEBF-3B3B-5244C98EC854}']
    function  MarketConditionServices_CreateMarketConditionReport(const TransactionData: clsTransactionData; const MlsDetails: clsMlsRequestDetails; const SubjectPropertyDetails: clsSubjectPropertyDetails): clsMarketConditionConnectionResponse; stdcall;
    function  MarketConditionServices_GetMlsDirectoryStatesListing(const TransactionData: clsTransactionData): clsMlsDirectoryStatesConnectionResponse; stdcall;
    function  MarketConditionServices_GetMlsDirectoryListing(const TransactionData: clsTransactionData; const MlsListingDetails: clsMlsListDetails): clsMlsDirectoryConnectionResponse; stdcall;
    function  MarketConditionServices_GetCustomerInfo(const AccessDetails: clsAccessDetails): clsCustomerInfoConnectionResponse; stdcall;
    function  MarketConditionServices_GetChartListing(const TransactionData: clsTransactionData): clsChartListConnectionResponse; stdcall;
  end;

function GetMarketConditionServerPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MarketConditionServerPortType;


implementation
  uses SysUtils;

function GetMarketConditionServerPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MarketConditionServerPortType;
const
  defWSDL = 'http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php?wsdl';
  defURL  = 'http://carme.atbx.net/secure/ws/mat/MarketConditionServer.php';
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


destructor clsMlsDirectoryConnectionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsMlsDirectoryResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FMlsDirectory)-1 do
    FreeAndNil(FMlsDirectory[I]);
  SetLength(FMlsDirectory, 0);
  inherited Destroy;
end;

destructor clsMlsDirectoryStatesConnectionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsMarketConditionConnectionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsMarketResultsArray.Destroy;
begin
  FreeAndNil(FInventoryAnalysis);
  FreeAndNil(FMedianSales);
  inherited Destroy;
end;

destructor clsUrarResultsArray.Destroy;
begin
  FreeAndNil(FExtra_Comments);
  FreeAndNil(FUrar1004_Data);
  inherited Destroy;
end;

destructor clsMarketConditionResponseData.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FGraphs)-1 do
    FreeAndNil(FGraphs[I]);
  SetLength(FGraphs, 0);
  for I := 0 to Length(FWorkFile)-1 do
    FreeAndNil(FWorkFile[I]);
  SetLength(FWorkFile, 0);
  for I := 0 to Length(FAddendums)-1 do
    FreeAndNil(FAddendums[I]);
  SetLength(FAddendums, 0);
  for I := 0 to Length(FQuarterlyGraphs)-1 do
    FreeAndNil(FQuarterlyGraphs[I]);
  SetLength(FQuarterlyGraphs, 0);
  FreeAndNil(FMarketResults);
  FreeAndNil(FUrarResults);
  FreeAndNil(FCondoResults);
  inherited Destroy;
end;

procedure clsMarketConditionResponseData.SetUrarResults(Index: Integer; const AclsUrarResultsArray: clsUrarResultsArray);
begin
  FUrarResults := AclsUrarResultsArray;
  FUrarResults_Specified := True;
end;

function clsMarketConditionResponseData.UrarResults_Specified(Index: Integer): boolean;
begin
  Result := FUrarResults_Specified;
end;

procedure clsMarketConditionResponseData.SetAddendums(Index: Integer; const AclsAddendumsArray: clsAddendumsArray);
begin
  FAddendums := AclsAddendumsArray;
  FAddendums_Specified := True;
end;

function clsMarketConditionResponseData.Addendums_Specified(Index: Integer): boolean;
begin
  Result := FAddendums_Specified;
end;

procedure clsMarketConditionResponseData.SetCondoResults(Index: Integer; const AclsCondoResultsArray: clsCondoResultsArray);
begin
  FCondoResults := AclsCondoResultsArray;
  FCondoResults_Specified := True;
end;

function clsMarketConditionResponseData.CondoResults_Specified(Index: Integer): boolean;
begin
  Result := FCondoResults_Specified;
end;

procedure clsMarketConditionResponseData.SetQuarterlyGraphs(Index: Integer; const AclsGraphArray: clsGraphArray);
begin
  FQuarterlyGraphs := AclsGraphArray;
  FQuarterlyGraphs_Specified := True;
end;

function clsMarketConditionResponseData.QuarterlyGraphs_Specified(Index: Integer): boolean;
begin
  Result := FQuarterlyGraphs_Specified;
end;

destructor clsCondoResultsArray.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FWorkFile)-1 do
    FreeAndNil(FWorkFile[I]);
  SetLength(FWorkFile, 0);
  FreeAndNil(FInventoryAnalysis);
  FreeAndNil(FMedianSales);
  inherited Destroy;
end;

procedure clsCondoResultsArray.SetSalesCount(Index: Integer; const AInteger: Integer);
begin
  FSalesCount := AInteger;
  FSalesCount_Specified := True;
end;

function clsCondoResultsArray.SalesCount_Specified(Index: Integer): boolean;
begin
  Result := FSalesCount_Specified;
end;

destructor clsUrarDataArray.Destroy;
begin
  FreeAndNil(Flistings);
  FreeAndNil(Fsales);
  inherited Destroy;
end;

destructor clsInventoryAnalysisArray.Destroy;
begin
  FreeAndNil(FMonths7To12);
  FreeAndNil(FMonths4To6);
  FreeAndNil(FMonths1To3);
  inherited Destroy;
end;

destructor clsMedianSalesArray.Destroy;
begin
  FreeAndNil(FMonths7To12);
  FreeAndNil(FMonths4To6);
  FreeAndNil(FMonths1To3);
  inherited Destroy;
end;

destructor clsAddendumsArrayItem.Destroy;
begin
  FreeAndNil(Fdata);
  FreeAndNil(Fgraph);
  inherited Destroy;
end;

procedure clsAddendumsArrayItem.Setdata(Index: Integer; const AclsAddendumDataArray: clsAddendumDataArray);
begin
  Fdata := AclsAddendumDataArray;
  Fdata_Specified := True;
end;

function clsAddendumsArrayItem.data_Specified(Index: Integer): boolean;
begin
  Result := Fdata_Specified;
end;

procedure clsAddendumsArrayItem.Setgraph(Index: Integer; const AclsGraphArrayItem: clsGraphArrayItem);
begin
  Fgraph := AclsGraphArrayItem;
  Fgraph_Specified := True;
end;

function clsAddendumsArrayItem.graph_Specified(Index: Integer): boolean;
begin
  Result := Fgraph_Specified;
end;

procedure clsAddendumsArrayItem.Setfootnotes(Index: Integer; const AclsFootnotesDataArray: clsFootnotesDataArray);
begin
  Ffootnotes := AclsFootnotesDataArray;
  Ffootnotes_Specified := True;
end;

function clsAddendumsArrayItem.footnotes_Specified(Index: Integer): boolean;
begin
  Result := Ffootnotes_Specified;
end;

procedure clsAddendumDataArray.Setmonth(Index: Integer; const AclsAddendumMonthsArray: clsAddendumMonthsArray);
begin
  Fmonth := AclsAddendumMonthsArray;
  Fmonth_Specified := True;
end;

function clsAddendumDataArray.month_Specified(Index: Integer): boolean;
begin
  Result := Fmonth_Specified;
end;

procedure clsAddendumDataArray.Setmedian_price(Index: Integer; const AclsAddendumMedianPriceArray: clsAddendumMedianPriceArray);
begin
  Fmedian_price := AclsAddendumMedianPriceArray;
  Fmedian_price_Specified := True;
end;

function clsAddendumDataArray.median_price_Specified(Index: Integer): boolean;
begin
  Result := Fmedian_price_Specified;
end;

procedure clsAddendumDataArray.Setcurrent_median(Index: Integer; const AclsAddendumCurrentMedianArray: clsAddendumCurrentMedianArray);
begin
  Fcurrent_median := AclsAddendumCurrentMedianArray;
  Fcurrent_median_Specified := True;
end;

function clsAddendumDataArray.current_median_Specified(Index: Integer): boolean;
begin
  Result := Fcurrent_median_Specified;
end;

procedure clsAddendumDataArray.Setchange_to_current(Index: Integer; const AclsAddendumChangeArray: clsAddendumChangeArray);
begin
  Fchange_to_current := AclsAddendumChangeArray;
  Fchange_to_current_Specified := True;
end;

function clsAddendumDataArray.change_to_current_Specified(Index: Integer): boolean;
begin
  Result := Fchange_to_current_Specified;
end;

destructor clsCustomerInfoConnectionResponse.Destroy;
begin
  FreeAndNil(FResults);
  FreeAndNil(FResponseData);
  inherited Destroy;
end;

destructor clsChartListConnectionResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FResponseData)-1 do
    FreeAndNil(FResponseData[I]);
  SetLength(FResponseData, 0);
  FreeAndNil(FResults);
  inherited Destroy;
end;

destructor clsSubjectPropertyDetails.Destroy;
begin
  FreeAndNil(FSale_Price);
  FreeAndNil(FOrg_Lst_Price);
  FreeAndNil(FList_Price);
  inherited Destroy;
end;

procedure clsSubjectPropertyDetails.SetLongitude(Index: Integer; const AWideString: WideString);
begin
  FLongitude := AWideString;
  FLongitude_Specified := True;
end;

function clsSubjectPropertyDetails.Longitude_Specified(Index: Integer): boolean;
begin
  Result := FLongitude_Specified;
end;

procedure clsSubjectPropertyDetails.SetLatitude(Index: Integer; const AWideString: WideString);
begin
  FLatitude := AWideString;
  FLatitude_Specified := True;
end;

function clsSubjectPropertyDetails.Latitude_Specified(Index: Integer): boolean;
begin
  Result := FLatitude_Specified;
end;

procedure clsSubjectPropertyDetails.SetStatus(Index: Integer; const AWideString: WideString);
begin
  FStatus := AWideString;
  FStatus_Specified := True;
end;

function clsSubjectPropertyDetails.Status_Specified(Index: Integer): boolean;
begin
  Result := FStatus_Specified;
end;

procedure clsSubjectPropertyDetails.SetStreet_Number(Index: Integer; const AWideString: WideString);
begin
  FStreet_Number := AWideString;
  FStreet_Number_Specified := True;
end;

function clsSubjectPropertyDetails.Street_Number_Specified(Index: Integer): boolean;
begin
  Result := FStreet_Number_Specified;
end;

procedure clsSubjectPropertyDetails.SetStreet_Name(Index: Integer; const AWideString: WideString);
begin
  FStreet_Name := AWideString;
  FStreet_Name_Specified := True;
end;

function clsSubjectPropertyDetails.Street_Name_Specified(Index: Integer): boolean;
begin
  Result := FStreet_Name_Specified;
end;

procedure clsSubjectPropertyDetails.SetUnit_Number(Index: Integer; const AWideString: WideString);
begin
  FUnit_Number := AWideString;
  FUnit_Number_Specified := True;
end;

function clsSubjectPropertyDetails.Unit_Number_Specified(Index: Integer): boolean;
begin
  Result := FUnit_Number_Specified;
end;

procedure clsSubjectPropertyDetails.SetClosing_Date(Index: Integer; const AWideString: WideString);
begin
  FClosing_Date := AWideString;
  FClosing_Date_Specified := True;
end;

function clsSubjectPropertyDetails.Closing_Date_Specified(Index: Integer): boolean;
begin
  Result := FClosing_Date_Specified;
end;

procedure clsSubjectPropertyDetails.SetSale_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FSale_Price := ATXSDecimal;
  FSale_Price_Specified := True;
end;

function clsSubjectPropertyDetails.Sale_Price_Specified(Index: Integer): boolean;
begin
  Result := FSale_Price_Specified;
end;

procedure clsSubjectPropertyDetails.SetOrg_Lst_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FOrg_Lst_Price := ATXSDecimal;
  FOrg_Lst_Price_Specified := True;
end;

function clsSubjectPropertyDetails.Org_Lst_Price_Specified(Index: Integer): boolean;
begin
  Result := FOrg_Lst_Price_Specified;
end;

procedure clsSubjectPropertyDetails.SetList_Price(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FList_Price := ATXSDecimal;
  FList_Price_Specified := True;
end;

function clsSubjectPropertyDetails.List_Price_Specified(Index: Integer): boolean;
begin
  Result := FList_Price_Specified;
end;

procedure clsSubjectPropertyDetails.SetList_Date(Index: Integer; const AWideString: WideString);
begin
  FList_Date := AWideString;
  FList_Date_Specified := True;
end;

function clsSubjectPropertyDetails.List_Date_Specified(Index: Integer): boolean;
begin
  Result := FList_Date_Specified;
end;

procedure clsSubjectPropertyDetails.SetOff_Mkt_Date(Index: Integer; const AWideString: WideString);
begin
  FOff_Mkt_Date := AWideString;
  FOff_Mkt_Date_Specified := True;
end;

function clsSubjectPropertyDetails.Off_Mkt_Date_Specified(Index: Integer): boolean;
begin
  Result := FOff_Mkt_Date_Specified;
end;

procedure clsSubjectPropertyDetails.SetSquare_Feet(Index: Integer; const AInteger: Integer);
begin
  FSquare_Feet := AInteger;
  FSquare_Feet_Specified := True;
end;

function clsSubjectPropertyDetails.Square_Feet_Specified(Index: Integer): boolean;
begin
  Result := FSquare_Feet_Specified;
end;

procedure clsSubjectPropertyDetails.SetBedrooms(Index: Integer; const AInteger: Integer);
begin
  FBedrooms := AInteger;
  FBedrooms_Specified := True;
end;

function clsSubjectPropertyDetails.Bedrooms_Specified(Index: Integer): boolean;
begin
  Result := FBedrooms_Specified;
end;

procedure clsSubjectPropertyDetails.SetBaths_Full(Index: Integer; const AInteger: Integer);
begin
  FBaths_Full := AInteger;
  FBaths_Full_Specified := True;
end;

function clsSubjectPropertyDetails.Baths_Full_Specified(Index: Integer): boolean;
begin
  Result := FBaths_Full_Specified;
end;

procedure clsSubjectPropertyDetails.SetBaths_Half(Index: Integer; const AInteger: Integer);
begin
  FBaths_Half := AInteger;
  FBaths_Half_Specified := True;
end;

function clsSubjectPropertyDetails.Baths_Half_Specified(Index: Integer): boolean;
begin
  Result := FBaths_Half_Specified;
end;

procedure clsSubjectPropertyDetails.SetLot_Descr(Index: Integer; const AWideString: WideString);
begin
  FLot_Descr := AWideString;
  FLot_Descr_Specified := True;
end;

function clsSubjectPropertyDetails.Lot_Descr_Specified(Index: Integer): boolean;
begin
  Result := FLot_Descr_Specified;
end;

procedure clsSubjectPropertyDetails.SetYear_Built(Index: Integer; const AInteger: Integer);
begin
  FYear_Built := AInteger;
  FYear_Built_Specified := True;
end;

function clsSubjectPropertyDetails.Year_Built_Specified(Index: Integer): boolean;
begin
  Result := FYear_Built_Specified;
end;

procedure clsSubjectPropertyDetails.SetSubdivision(Index: Integer; const AWideString: WideString);
begin
  FSubdivision := AWideString;
  FSubdivision_Specified := True;
end;

function clsSubjectPropertyDetails.Subdivision_Specified(Index: Integer): boolean;
begin
  Result := FSubdivision_Specified;
end;

procedure clsSubjectPropertyDetails.SetBasement(Index: Integer; const AWideString: WideString);
begin
  FBasement := AWideString;
  FBasement_Specified := True;
end;

function clsSubjectPropertyDetails.Basement_Specified(Index: Integer): boolean;
begin
  Result := FBasement_Specified;
end;

procedure clsSubjectPropertyDetails.SetParking(Index: Integer; const AWideString: WideString);
begin
  FParking := AWideString;
  FParking_Specified := True;
end;

function clsSubjectPropertyDetails.Parking_Specified(Index: Integer): boolean;
begin
  Result := FParking_Specified;
end;

procedure clsSubjectPropertyDetails.SetListing_Numb(Index: Integer; const AWideString: WideString);
begin
  FListing_Numb := AWideString;
  FListing_Numb_Specified := True;
end;

function clsSubjectPropertyDetails.Listing_Numb_Specified(Index: Integer): boolean;
begin
  Result := FListing_Numb_Specified;
end;

procedure clsSubjectPropertyDetails.SetREO(Index: Integer; const AWideString: WideString);
begin
  FREO := AWideString;
  FREO_Specified := True;
end;

function clsSubjectPropertyDetails.REO_Specified(Index: Integer): boolean;
begin
  Result := FREO_Specified;
end;

procedure clsSubjectPropertyDetails.SetRemarks(Index: Integer; const AWideString: WideString);
begin
  FRemarks := AWideString;
  FRemarks_Specified := True;
end;

function clsSubjectPropertyDetails.Remarks_Specified(Index: Integer): boolean;
begin
  Result := FRemarks_Specified;
end;

procedure clsSubjectPropertyDetails.SetZip_Code(Index: Integer; const AWideString: WideString);
begin
  FZip_Code := AWideString;
  FZip_Code_Specified := True;
end;

function clsSubjectPropertyDetails.Zip_Code_Specified(Index: Integer): boolean;
begin
  Result := FZip_Code_Specified;
end;

procedure clsMlsRequestDetails.SetMlsName(Index: Integer; const AWideString: WideString);
begin
  FMlsName := AWideString;
  FMlsName_Specified := True;
end;

function clsMlsRequestDetails.MlsName_Specified(Index: Integer): boolean;
begin
  Result := FMlsName_Specified;
end;

procedure clsMlsRequestDetails.SetPendingSaleFlag(Index: Integer; const AInteger: Integer);
begin
  FPendingSaleFlag := AInteger;
  FPendingSaleFlag_Specified := True;
end;

function clsMlsRequestDetails.PendingSaleFlag_Specified(Index: Integer): boolean;
begin
  Result := FPendingSaleFlag_Specified;
end;

procedure clsMlsRequestDetails.SetMlsRawData(Index: Integer; const AWideString: WideString);
begin
  FMlsRawData := AWideString;
  FMlsRawData_Specified := True;
end;

function clsMlsRequestDetails.MlsRawData_Specified(Index: Integer): boolean;
begin
  Result := FMlsRawData_Specified;
end;

procedure clsMlsRequestDetails.SetCondoRawData(Index: Integer; const AWideString: WideString);
begin
  FCondoRawData := AWideString;
  FCondoRawData_Specified := True;
end;

function clsMlsRequestDetails.CondoRawData_Specified(Index: Integer): boolean;
begin
  Result := FCondoRawData_Specified;
end;

procedure clsMlsRequestDetails.SetMlsTranslatedData(Index: Integer; const AWideString: WideString);
begin
  FMlsTranslatedData := AWideString;
  FMlsTranslatedData_Specified := True;
end;

function clsMlsRequestDetails.MlsTranslatedData_Specified(Index: Integer): boolean;
begin
  Result := FMlsTranslatedData_Specified;
end;

procedure clsMlsRequestDetails.SetDateOfAnalysis(Index: Integer; const AWideString: WideString);
begin
  FDateOfAnalysis := AWideString;
  FDateOfAnalysis_Specified := True;
end;

function clsMlsRequestDetails.DateOfAnalysis_Specified(Index: Integer): boolean;
begin
  Result := FDateOfAnalysis_Specified;
end;

procedure clsMlsRequestDetails.SetChartGroup(Index: Integer; const AInteger: Integer);
begin
  FChartGroup := AInteger;
  FChartGroup_Specified := True;
end;

function clsMlsRequestDetails.ChartGroup_Specified(Index: Integer): boolean;
begin
  Result := FChartGroup_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(MarketConditionServerPortType), 'MarketConditionServicesClass', 'ISO-8859-1');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MarketConditionServerPortType), 'MarketConditionServicesClass#%operationName%');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_CreateMarketConditionReport', 'MarketConditionServices.CreateMarketConditionReport');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetMlsDirectoryStatesListing', 'MarketConditionServices.GetMlsDirectoryStatesListing');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetMlsDirectoryListing', 'MarketConditionServices.GetMlsDirectoryListing');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetCustomerInfo', 'MarketConditionServices.GetCustomerInfo');
  InvRegistry.RegisterExternalMethName(TypeInfo(MarketConditionServerPortType), 'MarketConditionServices_GetChartListing', 'MarketConditionServices.GetChartListing');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsDirectoryListing), 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryListing');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryResponseData');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryArrayItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryArrayItem');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryStatesConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryStatesConnectionResponse');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsMlsDirectoryStatesListing), 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryStatesListing');
  RemClassRegistry.RegisterXSClass(clsMlsDirectoryStatesResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsDirectoryStatesResponseData');
  RemClassRegistry.RegisterXSClass(clsMarketConditionConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMarketConditionConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsResults, 'http://carme.atbx.net/secure/ws/WSDL', 'clsResults');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsResults), 'Type_', 'Type');
  RemClassRegistry.RegisterXSClass(clsMarketResultsArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMarketResultsArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsGraphArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsGraphArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsWorkfileArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsWorkfileArray');
  RemClassRegistry.RegisterXSClass(clsUrarResultsArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUrarResultsArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumsArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumsArray');
  RemClassRegistry.RegisterXSClass(clsMarketConditionResponseData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMarketConditionResponseData');
  RemClassRegistry.RegisterXSClass(clsCondoResultsArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCondoResultsArray');
  RemClassRegistry.RegisterXSClass(clsExtraCommentsArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsExtraCommentsArray');
  RemClassRegistry.RegisterXSClass(clsUrarDataArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsUrarDataArray');
  RemClassRegistry.RegisterXSClass(clsCountHighLowArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCountHighLowArray');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsCountHighLowArray), 'high_', 'high');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsCountHighLowArray), 'low_', 'low');
  RemClassRegistry.RegisterXSClass(clsInventoryAnalysisArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsInventoryAnalysisArray');
  RemClassRegistry.RegisterXSClass(clsMedianSalesArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMedianSalesArray');
  RemClassRegistry.RegisterXSClass(clsGraphArrayItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsGraphArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsFootnotesDataArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsFootnotesDataArray');
  RemClassRegistry.RegisterXSClass(clsAddendumsArrayItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumsArrayItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumMonthsArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumMonthsArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumMedianPriceArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumMedianPriceArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumCurrentMedianArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumCurrentMedianArray');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsAddendumChangeArray), 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumChangeArray');
  RemClassRegistry.RegisterXSClass(clsAddendumDataArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAddendumDataArray');
  RemClassRegistry.RegisterXSClass(clsAnalysisArray, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAnalysisArray');
  RemClassRegistry.RegisterXSClass(clsMedianSalesArrayItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMedianSalesArrayItem');
  RemClassRegistry.RegisterXSClass(clsWorkfileArrayItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsWorkfileArrayItem');
  RemClassRegistry.RegisterXSClass(clsCustomerInfoConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCustomerInfoConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsCustomerInfo, 'http://carme.atbx.net/secure/ws/WSDL', 'clsCustomerInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(clsChartListData), 'http://carme.atbx.net/secure/ws/WSDL', 'clsChartListData');
  RemClassRegistry.RegisterXSClass(clsChartListConnectionResponse, 'http://carme.atbx.net/secure/ws/WSDL', 'clsChartListConnectionResponse');
  RemClassRegistry.RegisterXSClass(clsChartListItem, 'http://carme.atbx.net/secure/ws/WSDL', 'clsChartListItem');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(clsChartListItem), 'type_', 'type');
  RemClassRegistry.RegisterXSClass(clsTransactionData, 'http://carme.atbx.net/secure/ws/WSDL', 'clsTransactionData');
  RemClassRegistry.RegisterXSClass(clsMlsListDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsListDetails');
  RemClassRegistry.RegisterXSClass(clsSubjectPropertyDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsSubjectPropertyDetails');
  RemClassRegistry.RegisterXSClass(clsMlsRequestDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsMlsRequestDetails');
  RemClassRegistry.RegisterXSClass(clsAccessDetails, 'http://carme.atbx.net/secure/ws/WSDL', 'clsAccessDetails');

end.