unit UCC_Utils;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2013 by Bradford Technologies, Inc.}

interface

uses
  Windows, Jpeg, Classes, DateUtils, Graphics, Clipbrd,Controls,
  TeeProcs, TeEngine, Chart, Grids, Series, SysUtils,
  AWSI_Server_Access, {UCC_Appraisal,} UContainer, UForm, UCC_Globals,XSBuiltIns,
  UInsertPDF, {UCC_ReportsBase,} uCell, UUtil2, StdCtrls, RzSpnEdt, ComCtrls,RzTabs;


  function AWSI_GetSecurityTokenEx(userID, userPSW, userCoKey, orderKey: String; var Token: WideString):Boolean;
  function IsNonZeroNumber(AValStr: String): Boolean;
  function GetMainAddressChars(const address: String): String;
  function GetStreetNameOnly(const streetAddress: String): String;
  function IsPointInPolygon(AX, AY: Real; APolygon: array of TRPoint): Boolean;

//  function AWSI_ConfirmUserIsCVRSpecialist(userID, userPSW: String; Appraisal: TAppraisal; getBilling: Boolean): Boolean;
(*
  function IsCompCruncherVersionOK : Boolean;
  function IsCompCruncherVersionOK2(forNewReport: Boolean) : Boolean;
  function IsCompCruncherWorksheet(AFormKind: Integer): Boolean;
  procedure GetBitmapOfChart(theChart: TChart; var theBitMap: TBitMap);
  function ChartBitmap(theChart: TChart): TBitmap;
  procedure ScrollFormIntoView(doc: TContainer; formID: Integer);
  function PValueSignificance(PValue: Double): String;

  procedure SetSingleChkBox(thisForm: TDocForm; cellSeqID: Integer; Status: Boolean; Pg: Integer=1);
  procedure SetYesNoCheckBox(thisForm: TDocForm; yesCell, noCell: Integer; isYes: Boolean; Pg: Integer=1);
  procedure SetYesNoCheckBox2(thisForm: TDocForm; yesCell, noCell: Integer; AnIndicator: Integer; Pg: Integer=1);
  procedure Set2OptionCheckBox(thisForm: TDocForm; chk1Cell,chk2Cell: Integer; chk1,chk2: Boolean; Pg: Integer=1);
  procedure Set3OptionCheckBox(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; chk1,chk2,chk3: Boolean; Pg: Integer=1);
  procedure Set3OptionCheckBox2(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell, itsThisOne: Integer; Pg: Integer=1);
  procedure Set4OptionCheckBox(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell,chk4Cell: Integer; chk1,chk2,chk3,chk4: Boolean; Pg: Integer=1);
  procedure Set4OptionCheckBox2(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell,chk4Cell, itsThisOne: Integer; Pg: Integer=1);
  procedure Get3OptionCheckBox(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; var chk1,chk2,chk3: Boolean);
  procedure Set3OptionCheckBoxEx3(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; chk1,chk2,chk3: Boolean; Pg: Integer=1);

  //report builder calls - does not override manual entry
  procedure SetYesNoCheckBoxEx(thisForm: TDocForm; yesCell, noCell: Integer; isYes: Boolean; Pg: Integer=1; ForceData:Boolean=False);
  procedure SetYesNoCheckBox2Ex(thisForm: TDocForm; yesCell, noCell: Integer; AnIndicator: Integer; Pg: Integer=1; ForceData: Boolean=False);
  procedure Set3OptionCheckBox2Ex(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell, itsThisOne: Integer; Pg: Integer=1; ForceData:Boolean=False);
  procedure Set3OptionCheckBoxEx(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; chk1,chk2,chk3: Boolean; Pg: Integer=1; ForceData:Boolean=False);
  procedure SetAppealSelectionEx(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell,chk4Cell,chk5Cell, anAppealType: Integer; Pg: Integer=1; ForceData:Boolean=False);
  procedure SetInfluenceCheckBox(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; AInfluenceType: String; Pg: Integer = 1);
  procedure SetSingleChkBoxEx(thisForm: TDocForm; cellSeqID: Integer; Status: Boolean; Pg: Integer=1; ForceData: Boolean=False);

  function GetMarketTrendSelection(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; Pg: Integer=1): Integer;  procedure SetCarStorageType(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell: Integer; storageType: string);
  procedure SetAppealSelection(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell,chk4Cell,chk5Cell, anAppealType: Integer);
  function GetAppealSelection(thisForm: TDocForm; chk1Cell,chk2Cell,chk3Cell,chk4Cell,chk5Cell: Integer): Integer;
//  function GetInfluenceAsString(AInfluenceType: Integer): String;
//  function GetInfluenceAsType(AInfluenceType: String): Integer;
  function SetPropertyKindAsInt(APropKind: String): Integer;
  function GetPropertyKindAsString(APropKind: Integer): String;
  function ConvertAcersToSqft(Acers: Real): Integer;
  function ForceLotSizeToSqFt(lotSize: String): String;
  function ConvertMiles2Kilometers(miles: Double): Double;
  function CalcPricePerGLA(PriceStr, GLAStr: String): String;

  procedure LoadJPEGFromByteArray(const dataArray: String; var JPGImg: TJPEGImage);
  function MemStreamToBase64Str(mStream:TMemoryStream): WideString;  //convert images to base64 string

  procedure SaveImageCellToInspectionPhotoList(doc: TContainer; thisForm: TDocForm; cellSeqID, photoTyp: Integer; photoDesc, photoSrc, photoDate: String);
  function CheckForValidDataString(srcStr:String): String;
//  function IsInMarketArea(Appraisal: TAppraisal; PropLatitude, PropLongitude: Real): Boolean;
  function DivideABStrings(strA, StrB: String; RoundOpt: Integer): String;
  function MultABStrings(strA, strB: String; RoundOpt: Integer): String;
  function SumABStrings(strA, strB: String; showZero: Boolean = True): String;
  function CalcListingDiscountRounded(ListPrice, SLRatio: String; RoundOpt: Integer): String;
  function CalcSLRatioFromDiscountAmt(ListPr, SaleDisc: String): String;
  function Munge2Strings(strA, strB: String): String;
  function Munge3Strings(strA, strB, strC: String): String;
  function StringsAreEmpty(const StrList: array of String): Boolean;
  function GetRoundedValue(value: String): Double;
  function RoundValueIfOver50A(valStr: String): Double;
  function RoundValueIfOver50B(value: Double): Double;
  function FormatCamelCase(const AString : string) : string;
  function CapsLockString(A: String): String;

  function RemoveAllSpaces(Text: String): String;
  function CleanAddress(Address: String): String;
  function CleanDollar(Dollar: String): String;
  function IntToStrTry(AVal: integer): string;
  function IntToStrDef(AInt: Integer; defStr: String): string;
  function CleanNumeric(AVal: string): string;
  function IsNumeric(AVal: string): Boolean;
  function IsIntegerNumber(AValStr: String; var Value: Integer): Boolean;
  function IsRealNumber(AValStr: string; var Value: Double): Boolean;

  //data filters that act on data before grid - ie at anytime
  function GetIntegerString(strValue: String; forceCompliance: Boolean): String;
  function GetRealNumberString(strValue: String; decPts: Integer; forceCompliance: Boolean): String;
  function GetRealNonZeroNumberString(strValue: String; decPts: Integer; forceCompliance: Boolean): String;
  function GetYearString(strValue: String; forceCompliance: Boolean): String;
  function GetDateString(strValue: String; forceCompliance: Boolean): String;
  function GetNonZeroLatLonString(strValue: String): String;

  function HasProperAddress(Addr, City, State, Zip: String): Boolean;
//  procedure FilterPropertyData(AProp: TProperty; forceCompliance: Boolean);
//  procedure EnhancePropertyData(AProp: TProperty);
//  procedure DoPropertyDataCalcs(AProp: TProperty);
  procedure AddZerosToZipCode(var shortZipCode: String);

  function GetNeededSaleXCompPgCount(doc: TContainer): Integer;
  function GetNeededSalePhotoPgCount(doc: TContainer): Integer;
  function GetNeededListXCompPgCount(doc: TContainer): Integer;
  function GetNeededListPhotoPgCount(doc: TContainer): Integer;

  function CalcTrkBarFrequency(aMin,aMax:Real):word;
  function WeightInRange(exclude:Boolean;fWeight,fMin,fMax:Double):Boolean;
  function DateInRange(exclude:Boolean; effDate:TDateTime; fSDayValue,fSDayMin,fSDayMax: String):boolean;
  function XMLDateToDateStr(aXMLStr: String):String;
  function DateStrToXMLDate(aXMLStr: String):String;

  function GetWindowParentHandle(anOwner:TObject;Params:TCreateParams; aSelf:TObject):THandle;
  procedure InsertPDFToContainer(const fName, Title: String; doc: TContainer; Sender: TObject);
  procedure InsertPDFToContainerbyIndex(const fName, title: String; doc: TContainer; Sender: TObject; Index:Integer; ReportOnly:Boolean; PageTitle: string = '');

  procedure SetCellFont(var cell:TBaseCell; fFontStyle: Integer; fFontName: String; fTextSize: Integer);

  function GetImageFiles(var startDir: String): TStringList;
  function FindAnyControl(obj: TWinControl; s: string): TControl;
  procedure ConvertLocDesc(LocDesc: String; var aFactor1, aFactor2, aOther: String);

//  function GetPhotoType(TitleImage:String): Integer;
  function IsMultiChecked(chk1, chk2, chk3:Boolean):Boolean;

  procedure SetAppraisalCompUID(doc: TContainer);  //### HANDLE - this temp until we can set UID at the beginning of Market Munger
  function GetFileDate(aFileName:String):String;
  function ValidateEmail(aEmail: String): Boolean;
  function BooleanToYesNo(aBool:Boolean):String;
  function YesNoToBoolean(aYesNo:String):Boolean;
  function BooleanToInt(aBool:Boolean):Integer;
  function IntToBoolean(aInt:Integer):Boolean;
  function GetXtraPageCounts(nComps: Integer; photosPerPage: Integer= 6): Integer;

  function GetSiteView(site,view: String):String;
  procedure DoTabHandlingWithHelpContext(aSender: TObject; aComponent: TComponent; doBreak: Boolean=False);
  function ConvertToImageToDisplay(ImageData, tempGifFile:String; var aBitMap: TBitMap): Boolean;
  function GetActiveTab(pageCntrl: TrzPageControl; aPage: TRzTabSheet):TRztabSheet;
  procedure DeleteAForm(doc: TContainer; aFormID: Integer);
//  function translateUADBelowgradeRooms(aProperty: TProperty):String;
  function SetFullHalfBath(const aFull, aHalf: String):String; //sets Full and adds to TotalBathCount
//  function CollectGarageCount(Prop: TProperty): String;
  function CombineGarageCarport(garage, carport: string):String;
  function CombineDesignStories(aDesign, aStories: String):String;
  procedure SplitDesignStories(aDesignStories: String; var aDesign, aStories: String);
  function TranslateGarageCount(aGarageCount:Integer):String;
  function TranslateQuality(aQuality:String):String;



  (*
  function FindReplace(Text,Find,Replace : string) : string;
  function GetField2(strRecord: string;delimeter:string): integer;
  function GetNumChar(Char,Field : String) : Integer;

  function RemoveSpace(Text : String): String;
  function FindFromRight(Busca,Text : string) : integer;
  function FindFromLeft(Busca,Text: string) : integer;
  function strtofloattry(str: string): real;
  function ParseStr(Str: string; var Values: array of double): integer;
  function GetFirstNumInStr(numStr: string; IntegerOnly: boolean; var endIdx: integer): string;
  procedure StripCommas(var S: string);
  function cleannumeric(AVal : string): string;

  function CheckDelim(mlsfile: string) : String;
  function GetLineData(fName:String; delim: String; TextQualifier : String):TStringList;
  function ParseRecord(sRecord: string; Row: integer; delimeter : String; Qualifier : String) : TStringList;
  function floattostrtry(AVal: String): string;
  function floattostrtry2(AVal: real): string;
  function getDate(str:String): TDateTime;
  function strtofloattry(str: string): real;
  function StrToIntTry(str: string): integer;
  function stripnumbers(src: string): string;
  function txt(aStr: string): string;
  function dofmtfield(a: string; fmt: string; sz,sc: boolean):string;
  function YearOf(const AValue: TDateTime): Word;
  function stripnumbers2(src: string): string;
*)
  function RoundBathCount(ABathCount: Double): Double;


implementation

uses
  StrUtils, UWindowsInfo, UBase64, USendHelp, RzTrkBar, UGraphics, RzEdit,
  UStatus, UUtil1, USysInfo, uInternetUtils, UGlobals, uFolderSelect;

const
  MaxStAbbrev = 58;

  //substitute for boolean  (for handling Yes/No checkboxes that are not yet set)
  bUnknown  = 0;
  bYes      = 1;
  bNo       = 2;


  AppraisalDataVersion1   = 1;         //this is the version # of the data structure that TAppraisal writes out
  AppraisalDataVersion2   = 2;         //added the extensions for Market Data
  AppraisaldataVersion3   = 3;         //added additional data in regression components of value
  AppraisalDataVersion4   = 4;         //12/1/12: Vers: 1.9.91. Added ReportForms configuration
  AppraisalDataVersion5   = 5;         //12/27/12 vers: 1.9.93 Added CompFilters
  AppraisalDataVersion6   = 6;         //12/8/14 expanded TServiceOrder and added its own version #
  AppraisalDataVersion7   = 7;         //02/9/15 (PAM USE THIS) added 1004MC data, ValuationResearch
  AppraisalDataVersion8   = 8;         //6/1/15 removed TT1004MCData; added TrendAnalyzer data

  PropertyDataVersion1    = 1;         //this is the version # of the data structure that TProperty writes out
  PropertyDataVersion2    = 2;         //8/23/13 - major change in property, added in AppraisalDataVersion6
  PropertyDataVersion3    = 3;         //2/19/16 - added extra ints & Bools, Weight, include, filteredOut, etc
  SubjectDataVersion1     = 1;         //previous TSubject subject
  SubjectDataVersion2     = 2;         //this is the version # of the data structure that TSubject writes out
  SubjectDataVersion3     = 3;         //ammended Zoning structure and added version ID
  ZoningDataVersion2      = 2;         //ammened version of zoning, start at version 2
  MarketTrendsVersion1    = 1;         //this is the version # of the data structure that TMarketTrends writes out
  MarketAreaVersion1      = 1;         //this is the version # of the data structure that TMarketArea writes out
  MarketAreaVersion2      = 2;         //added the UID for the market area to correspond to stored area
  //added in AppraisalDataVersion2
  MarketDataVersion2      = 2;         //this is the version # of the data structure that TMarketData writes out
  MarketConditionVersion2 = 2;         //this is the version # of the data structure that TMarketCondition writes out
  MarketCharacterVersion2 = 2;         //this is the version # of the data structure that TMarketChartacteristics writes out
  //added in AppraisalDataVersion3
  RegressionVersion2      = 2;         //this is the version # of the data structures that TRegression write out
  RegressionVersion3      = 3;         //Added the Sample Size acceptaboility
  ValueComponentVersion2  = 2;         //this is the version # of the data structures that TComponentOfValue writes out
  ComponentsListVersion2  = 2;         //this is the version # of the data structures that TComponents write out
  //added in AppraisalDataVersion5
  CompFilterVersion1      = 1;         //this is the version # of the data structure that TPropertyFilter/TCompFilter uses
  CompFilterVersion2      = 2;         //8/25/2013  added Comp Bracketing parameters
  CompFilterVersion3      = 3;         //3/9/2015 added dual filtering in Redstone
  CompFilterVersion4      = 4;         //6/1/2015 added dual filtering for 1004MC Trend data
  PropFilterVersion1      = 1;         //this is the version # of the data structure for TPropertyFilter
  DualFilterVersion1      = 1;         //version 1 of TPropertyDualFilter
  CompBracketVersion1     = 1;         //this is the version # of the data structure for TPropertyBracket
  CaptainsLogVersion1     = 1;         //this is the version # of the appraisal log that TCaptainsLog uses
  LogEntryVersion1        = 1;         //this is the version # of the log entry structure
  //added in AppraisalDataVersion6
  ServiceOrderVersion2    = 2;         //this is the version # of the service order data structure, v1 had no version#
  //added in AppraisalDataVersion7
  ValResearchVersion1     = 1;        //this is the version # of the Valuation Research data structure
  Data1004MCVersion1      = 1;        //this is the version # of the 1004MC data structure
  //to be added in a future version
  VersionColAnalytics     = 1;        //this is the version # of the collateral Analytics data structure
  CompAdjListVersion2     = 2;         //this is the version # of the structure for the comp adj list
  CompAdjItemVersion1     = 1;         //this is the version # for the structure for the comp adj items
  //Data Source versions
  DataSource2Version1     = 2;         //6/3/15 new DataSource#2, added new fields
  DataSourceListVersion2  = 2;         //this is the current version (iCount converted to VersionID)
  DataSourceListVersion3  = 3;         //6/2/15 - added Relar and Other data source objects


  //these need to be removed. Use the ones UCC_ReportsBase
  //report types
  rtUnknown     = 0;
  rtBPOLike     = 1;
  rtCVRDesktop  = 2;
  rtCVRDriveBy  = 3;
  rtCVRFull     = 4;
  rt2055UAD     = 5;
  rt1073UAD     = 6;
  rt1004UAD     = 7;
  rtVacantLand  = 8;
  rtReview      = 9;

  //influence types
  itUnknown     = 0;
  itBeneficial  = 1;
  itNeutral     = 2;
  itAdverse     = 3;
  itsBeneficial = 'Beneficial';
  itsNeutral    = 'Neutral';
  itsAdverse    = 'Adverse';

  //Appeal types
  apUnknown     = 0;
  apExcellent   = 1;
  apGood        = 2;
  apAverage     = 3;
  apFair        = 4;
  apPoor        = 5;
  
  //Trend Indicators
  tiUnknown     = 0;
  tiIncreasing  = 1;
  tiStable      = 2;
  tiDeclining   = 3;

  //Comparable Kind
  ckUnknown     = 0;
  ckSale        = 1;
  ckListing     = 2;
  ckSubject     = 3;

  //Property Category
  pcUnknown     = 0;
  pcSingleFam   = 1;
  pcCondo       = 2;
  pcVacantLand  = 3;
  pc2To4Units   = 4;
  pcPUD         = 5;

  //Property Unit Type
  utOneUnit         = 1;
  utOneUnitWAccUnit = 2;

  //Building Status Type
  stExisting    = 1;
  stProposed    = 2;
  stInConst     = 3;

  //Building Attachment Type
  atDetached    = 1;
  atAttached    = 2;
  atEndUnit     = 3;
  atBuiltIn     = 4;

  //addendum types
  atUnknown     = 0;
  atLocMap      = 1;
  atSubPhoto    = 2;
  atSalePhotos  = 3;
  atListPhotos  = 4;
  atComments    = 5;

  //photo types
  phUnknown     = 0;     //init state: A real photo should never be of this type
  phSubFront    = 1;
  phSubStreet   = 2;
  phSubRear     = 3;
  phSubMBedRm   = 4;     //master bedroom
  phSubMBath    = 5;     //master bath
  phSubKitchen  = 6;     //kitchen
  phSubLivingRm = 7;     //living room
  phSubExtra    = 8;     //all extra subject photos have this type
  phAddressView = 9;     //photo of the property address from the street
  phAlternateStreetView = 10;

  phFrontView   = 1;     //use for comps and listing
  phStreetView  = 2;

//used for Mobile only
  phSale1Front  = 21;
  phSale2Front  = 22;
  phSale3Front  = 23;
  phSale4Front  = 24;
  phSale5Front  = 25;
  phSale6Front  = 26;

  phList1Front  = 31;
  phList2Front  = 32;
  phList3Front  = 33;
  phList4Front  = 34;
  phList5Front  = 35;
  phList6Front  = 36;

  phGoogleStreetView = 37;		  //Google street view photo type

  //Appraiser license types
  ltUnknown     = 0;
  ltLicensed    = 1;
  ltCertified   = 2;
  ltCertGeneral = 3;
  ltOther       = 4;

  //Style Similarity types
  stUnknow       = 0;
  stIdentical    = 1;
  stVerySimilar  = 2;
  stSimilar      = 3;
  stKindaSimilar = 4;
  stDiffernet    = 5;
  stExclude      = 6;   //this means the comp is excluded from consideration as a comp

  //row indexes in Market Activity Grid
  rTotalSales       = 0;
  rAbsorptionRate   = 1;
  rTotalListings    = 2;
  rMosSupply        = 3;
  rMedSalesPrice    = 4;
  rMedSalesDOM      = 5;
  rMedListPrice     = 6;
  rMedListingDOM    = 7;
  rMedSaleListRatio = 8;
  rPricePerSqft     = 9;

  //Subject comparison Grid Adjustments (ga) Indexes
  gaUnknown     = -1;
  gaSalesCon    = 0;
  gaFinConces   = 1;
  gaSaleDate    = 2;
  gaFeeSimple   = 3;
  gaLocInfl     = 4;
  gaLocDesc     = 5;
  gaViewInfl    = 6;
  gaViewDesc    = 7;
  gaSiteArea    = 8;
  gaDesign      = 9;
  gaQuality     = 10;
  gaAge         = 11;
  gaCondition   = 12;
  gaAboveGrde1  = 13;
  gaAboveGrde2  = 14;
  gaGLA         = 15;
  gaBsmtGLA     = 16;
  gaBsmtFLA     = 17;
  gaUtility     = 18;
  gaHeating     = 19;
  gaEnergy      = 20;
  gaGarage      = 21;
  gaPorch       = 22;
  gaFirePl      = 23;
  gaPool        = 24;
  gaOther       = 25;    //original list
  gaOther2      = 26;    //added 2 more on 9-10-13
  gaOther3      = 27;
  gaSaleDisc    = 28;    //sale discount: listing to sale discount
  gaCarport     = 29;
(*
  //sales comparison adjustments Indexes
  saUnknown     = -1;
  saSalesCon    = 0;
  saFinConces   = 1;
  saSaleDate    = 2;
  saFeeSimple   = 3;
  saLocInfl     = 4;
  saLocDesc     = 5;
  saViewInfl    = 6;
  saViewDesc    = 7;
  saSiteArea    = 8;
  saDesign      = 9;
  saQuality     = 10;
  saAge         = 11;
  saCondition   = 12;
  saAboveGrde1  = 13;
  saAboveGrde2  = 14;
  saGLA         = 15;
  saBsmtGLA     = 16;
  saBsmtFLA     = 17;
  saUtility     = 18;
  saHeating     = 19;
  saEnergy      = 20;
  saGarage      = 21;
  saPorch       = 22;
  saFirePl      = 23;
  saPool        = 24;
  saOther       = 25;

//  Listing Comparison Adjustment Indexs
  laUnknown     = -1;
  laSalesCon    = 0;
  laFinConces   = 1;
  laSaleDate    = 2;
  laFeeSimple   = 3;
  laLocInfl     = 4;
  laLocDesc     = 5;
  laViewInfl    = 6;
  laViewDesc    = 7;
  laSiteArea    = 8;
  laDesign      = 9;
  laQuality     = 10;
  laAge         = 11;
  laCondition   = 12;
  laAboveGrde1  = 13;
  laAboveGrde2  = 14;
  laGLA         = 15;
  laBsmtGLA     = 16;
  laBsmtFLA     = 17;
  laUtility     = 18;
  laHeating     = 19;
  laEnergy      = 20;
  laGarage      = 21;
  laPorch       = 22;
  laFirePl      = 23;
  laPool        = 24;
  laOther       = 25;
*)
//Comment IDs
  cmCVRPropertySummary  = 1;
  cmCVRInteriorInsp     = 2;
  cmOther3              = 3;
  cmOther4              = 4;
  cmOther5              = 5;
  cmOther6              = 6;
  cmOther7              = 7;
  cmOther8              = 8;

//Comment Titles
  ctCVRPropSummary  = 'Subject Overall Comments';
  ctCommentTitle2   = 'Title 2 Comments';
  ctCommentTitle3   = 'Title 3 Comments';
  ctCommentTitle4   = 'Title 4 Comments';
  ctCommentTitle5   = 'Title 5 Comments';
  ctCommentTitle6   = 'Title 6 Comments';
  ctCommentTitle7   = 'Title 7 Comments';

//Range Items - object holds the hi/lo/range for this feature
  riUnknown   = 0;
  riPrice     = 1;
  riGLA       = 2;
  riSite      = 3;
  riBsmtGLA   = 4;
  riBsmtFGLA  = 5;
  riAge       = 6;
  riBeds      = 7;
  riBaths     = 8;
  riCars      = 9;
  riFirepl    = 10;

  //Zone types
  ztUnknown   = 0;
  ztLegal     = 1;
  ztLegalNC   = 2;
  ztNoZoning  = 3;
  ztIllegal   = 4;

  //occupancy type
  ocOwner     = 'Owner';
  ocTenant    = 'Tenant';
  ocVacant    = 'Vacant';

  //data source types
  dsUnknown   = 0;
  dsMLS       = 1;
  dsLPS       = 2;
  dsRELAR     = 3;
  dsCAT       = 4;  //collateral analytics

  

function AWSI_GetSecurityTokenEx(userID, userPSW, userCoKey, orderKey: String; var token: WideString):Boolean;
var
  AWAccess : clsAccessCredentials;   //LPS User Class ?????
  accessDetails : clsAwsiAccessDetailsRequest;
begin
  AWAccess := clsAccessCredentials.Create;
  AWAccess.Username := userID;
  AWAccess.Password := userPSW;

  accessDetails := clsAwsiAccessDetailsRequest.Create;
  accessDetails.CompanyKey  := userCoKey;
  accessDetails.OrderNumber := orderKey;

  token := '';
  try
    try
      with GetAwsiAccessServerPortType(false, awsiServer) do
        with AwsiAccessService_GetSecurityToken(AWAccess, accessDetails) do
          if results.Code = 0 then
            token := ResponseData.SecurityToken
          else
            ShowAlert(atWarnAlert, results.Description);
    except
      on e: Exception do
        ShowAlert(atStopAlert, e.Message);
    end;
  finally
    AWAccess.Free;
    accessDetails.Free;

    result := length(token) > 0;    //do we have a token
  end;
end;

//rounded to 1/2 or whole number
// 1/4 get rounded down; 3/4 get rounded up
function RoundBathCount(ABathCount: Double): Double;
var
  ABath, BathAndHalf: Double;
begin
  result := 0;
  ABath := Int(ABathCount);             //full bath count
  BathAndHalf := ABath + 0.5;
  if ABathCount > BathAndHalf then      //do we round up or down
    result := ABath + 1
  else if ABathCount < BathAndHalf then
    result := ABath
  else if ABathCount = BathAndHalf then
    result := ABathCount;
end;

function IsNonZeroNumber(AValStr: String): Boolean;
var
  value: Double;
begin
  if Trim(AValStr) = '' then
    result := False
  else if AValStr = '0' then
    result := False
  else
    result := IsValidNumber(AValStr, value);
end;

//This routine is used to compose a string of only the main characters in an address
function GetMainAddressChars(const address: String): String;
begin
  result := StringReplace(address,' ','',[rfReplaceAll]);  //remove spaces
  result := StringReplace(result,',','',[rfReplaceAll]);   //remove commas
  result := StringReplace(result,'.','',[rfReplaceAll]);   //remove periods
end;

function GetStreetNameOnly(const streetAddress: String): String;
begin
  result := TrimNumbersLeft(streetAddress);
  //do other street name processing/parsing here
end;

//  The function will return True if the point x,y is inside the polygon, or
//  False if it is not.
//  Original C code: http://www.visibone.com/inpoly/inpoly.c.txt
//  Translation from C by Felipe Monteiro de Carvalho
//  License: Public Domain
function IsPointInPolygon(AX, AY: Real; APolygon: array of TRPoint): Boolean;
var
  xnew, ynew: Real;
  xold,yold: Real;
  x1,y1: Real;
  x2,y2: Real;
  i, npoints: Integer;
  inside: Integer;
begin
  Result := False;
  inside := 0;
  npoints := Length(APolygon);
  if (npoints < 3) then Exit;
  xold := APolygon[npoints-1].X;
  yold := APolygon[npoints-1].Y;
  for i := 0 to npoints - 1 do
  begin
    xnew := APolygon[i].X;
    ynew := APolygon[i].Y;
    if (xnew > xold) then
    begin
      x1:=xold;
      x2:=xnew;
      y1:=yold;
      y2:=ynew;
    end
    else
    begin
      x1:=xnew;
      x2:=xold;
      y1:=ynew;
      y2:=yold;
    end;
    if (((xnew < AX) = (AX <= xold))         // edge "open" at left end
      and ((AY-y1)*(x2-x1) < (y2-y1)*(AX-x1))) then
    begin
      inside := not inside;
    end;
    xold:=xnew;
    yold:=ynew;
  end;
  Result := inside <> 0;
end;







end.
