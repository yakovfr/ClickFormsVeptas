unit UUADUtils;
 {  ClickForms Application                }
 {  Bradford Technologies, Inc.           }
 {  All Rights Reserved                   }
 {  Source Code Copyrighted � 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, DateUtils, IniFiles,
  UAppraisalIDs, UCell, UContainer, UGlobals, UGridMgr, UUtil1,
  UUtil2, ULicUser, Dialogs, UEditor, UStatus, UStatusService,StdCtrls,
  UForm, WPRTEDefs,Grids_ts, TSGrid, osAdvDbGrid,Graphics, uListComp_Global,
  UMathResid5;

const
  MaxAccessIdx = 2;
  MaxBsmtRoomIdx = 4;
  MaxDOSTypes = 4;
  MaxFinTypes = 6;
  MaxInfluences = 2;
  MaxLocFactors = 10;
  MaxSalesTypes = 7;
  MaxViewFeatures = 12;
  MaxQualityTypes = 5;
  MaxConditionTypes = 5;
  MaxUADCmntCellXID = 5;
  MaxCondoTypes = 6;  // Design (Style) 1073 & 1075
//  MaxCondoForms = 3;  // Garage/Carport
  MaxCondoForms = 5; //github #823 // Garage/Carport
  MaxUADAutoDlgXID = 35;  // Garage/Carport & Design/Style cell XML IDs for auto-display of a UAD dialog
  MaxResidTypes = 2;  // Design (Style) 1004 & 2055
  NoUpd15Yrs = 'No updates in the prior 15 years';
  Kitchen = 'Kitchen-';
  Bathroom = 'Bathrooms-';
  OfferedSale = 'Subject property was offered for sale.';
  ListedFSBO = 'Subject property was listed for sale by owner.';
  DOMHint = 'DOM ';
  LastPriceHint = 'Latest Price $';
  LastDateHint = 'Latest Date ';
  OrigPriceHint = 'Original Price $';
  OrigDateHint = 'Original Date ';
  OtherPriceHint = 'Other Price ';
  OtherDateHint = 'Other Date ';
  NumOfAdjustments = 27;
  //adjstment cell IDs for for 1004,1073,1075,2055 and their XComps
  //the first row adjustment cellIDs, second one is the corresponding description cellids
  // for room count adjustment we have define the 1044 (top row on the form) is adjustment
  //for total rooms, 1045 (bottom row on the form) is bath room adjustment.
  //the 3rd row has 1 for regular adjustment and 0 for adjustment like sales of financing where subject
  //description not defined.
  AdjCellIDs: array[0..2,0..NumOfAdjustments] of Integer =
      ((957,959,961,963,965,967,969,971,977,981,985,987,995,997,999,1044,1045,1005,1007,1009,1011,1013,1015,1017,1019,1021,1023,927),
       (956,958,960,962,964,966,968,970,976,980,984,986,994,996,998,1041,1043,1004,1006,1008,1010,1012,1014,1016,1018,1020,1022,1032),
       (0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1));

  //Set up Grid column
  colLocate = 1;
  colForm   = 2;
  colPg     = 3;
  colCell   = 4;
  colErrorMessage = 5;
  CriticalError_Color = clRed;
  CriticalWarning_Color = colorSalmon;
  kGridDesignStyle = 129;

type
  TCellID = class(TObject)   //YF Reviewer 04.08.02
    Form: Integer;          //form index in formList
    Pg: Integer;            //page index in form's pageList
    Num: Integer;            //cell index in page's cellList
    constructor Create;
  end;


var
  //Improvement Types
  ConditionListTypCode: array[0..MaxConditionTypes] of String = ('C1','C2','C3','C4','C5','C6');
  QualityListTypCode: array[0..MaxQualityTypes] of String = ('Q1','Q2','Q3','Q4','Q5','Q6');
  ImprovementListTypRsp: array[0..2] of string = ('Not Updated','Updated','Remodeled');
  ImprovementListTypXML: array[0..2] of String = ('NotUpdated','Updated','Remodeled');
  ImprovementListTypTxt: array[0..2] of String = ('not updated','updated','remodeled');

  ImprovementListYrsXML: array[0..4] of String = ('LessThanOneYearAgo','OneToFiveYearsAgo','SixToTenYearsAgo',
                                                  'ElevenToFifteenYearsAgo','Unknown');
  ImprovementListYrsRSP: array[0..4] of String = ('lessthen1yrago','1-5yrsago','6-10yrsago','11-15yrsago','unknown');
  ImprovementListYrsSD: array[0..4] of String = ('Less then 1 yr ago','1 - 5 yrs ago','6 - 10 yrs ago','11 - 15 yrs ago','Unknown');
  ImprovementListYrsTxt: array[0..4] of String = ('less than one year ago','one to five years ago',
                                                  'six to ten years ago','eleven to fifteen years ago',
                                                  'timeframe unknown');

  //Influence Types: abbreviations for location and view display & XML data points
  InfluenceList: array[0..MaxInfluences] of string = ('Neutral','Beneficial','Adverse');
  InfluenceDisplay: array[0..MaxInfluences] of String = ('N','B','A');

  //Location Types: abbreviations for display & XML data points
  LocListDisplay: array[0..MaxLocFactors] of String = ('Res','Ind','Comm','BsyRd','WtrFr','GlfCse','AdjPark','AdjPwr',
                                                    'Lndfl','PubTrn','Other');
  LocListRsp: array[0..maxLocFactors] of string = ('Residential','Industrial','Commercial','Busy Road','Water Front','Golf Course','Adjacent to Park','Adjacent to Powerlines','Landfill','Public Transportation','Other');
  LocListXML: array[0..MaxLocFactors] of String = ('Residential','Industrial','Commercial','BusyRoad','WaterFront',
                                                   'GolfCourse','AdjacentToPark','AdjacentToPowerLines','Landfill',
                                                   'PublicTransportation','Other');

  //View Types: abbreviations for display & XML data points
  ViewListDisplay: array[0..MaxViewFeatures] of String = ('Res','Wtr','Glfvw','Prk','Pstrl','Woods','CtySky','Mtn',
                                                          'CtyStr','Ind','PwrLn','LtdSght','Other');
  ViewListRsp: array[0..MaxViewFeatures] of string = ('Residential View','Water View','Golf Course View','Park View',
                                                      'Pastoral View','Woods View','City View Skyline View','Mountain View',
                                                      'City Street View','Industrial View','Power Lines','Limited Sight','Other');
  ViewListXML: array[0..MaxViewFeatures] of String = ('ResidentialView','WaterView','GolfCourseView','ParkView','PastoralView',
                                                      'WoodsView', 'CityViewSkylineView','MountainView',
                                                      'CityStreetView','IndustrialView','PowerLines','LimitedSight','Other');

  //Date of Sale: abbreviations for display & XML data points
  DOSTypes: array[0..MaxDOSTypes] of String = ('s','Active','c','e','w');
  DOSTypesXML: array[0..MaxDOSTypes] of String = ('SettledSale','Active','Contract','Expired','Withdrawn');
  DOSTypesTxt: array[0..MaxDOSTypes] of String = ('Settled sale','Active listing','Contract','Expired listing','Withdrawn listing');

  //Sale Types: these are the user selections and xml data points
  SalesTypesDisplay: array[0..MaxSalesTypes] of String = ('REO','Short','CrtOrd','Estate','Relo','NonArm',
                                            'ArmLth','Listing');
  SalesTypesRsp: array[0..MaxSalesTypes] of String = ('REO sale','Short sale','Court Ordered sale','Estate sale',
                                            'Relocation sale','Non-Arms Length sale','Arms Length sale','Listing');
  SalesTypesTxt: array[0..MaxSalesTypes] of String = ('REO sale','Short sale','Court ordered sale','Estate sale',
                                            'Relocation sale','Non-arms length sale','Arms length sale','Listing');
  SalesTypesXML: array[0..MaxSalesTypes] of String = ('REOSale','ShortSale','CourtOrderedSale','EstateSale',
                                            'RelocationSale','NonArmsLengthSale','ArmsLengthSale','Listing');

  FinType: array[0..MaxFinTypes] of String = ('FHA','VA','Conventional','Cash','Seller',
                                             'RuralHousing','Other');
  FinDesc: array[0..MaxFinTypes] of String = ('FHA','VA','Conv','Cash','Seller',
                                              'RH','Other');

  MgmtGrp: array[0..7] of String = ('','HomeownersAssociation','Developer','HomeownersAssociationAndDeveloper',
                                    'ManagementAgent','HomeownersAssociationAndManagementAgent','DeveloperAndManagementAgent',
                                    'HomeownersAssociationAndDeveloperAndManagementAgent');
  CoopGrp: array[0..7] of String = ('','Developer','CooperativeBoard','DeveloperAndCooperativeBoard',
                                    'ManagementAgent','DeveloperAndManagementAgent','CooperativeBoardAndManagementAgent',
                                    'DeveloperAndCooperativeBoardAndManagementAgent');
  //basement Types
  BsmtAccessDisplay: array[0..MaxAccessIdx] of String = ('wo','wu','in');
  BsmtAccessListXML: array[0..MaxAccessIdx] of String = ('WalkOut','WalkUp','InteriorOnly');
  BsmtRoomsDisplay: array[0..MaxBsmtRoomIdx] of String = ('rr','br','','ba','o');

  //design (style) Types
  CondoAttachType: array[0..MaxCondoTypes] of String = ('DT','RT','GR','MR','HR','O','O');
  CondoAttachID: array[0..MaxCondoTypes] of Integer = (2109,380,381,382,383,384,385);
  ResidAttachType: array[0..MaxResidTypes] of String = ('DT','AT','SD');
  ResidAttachID: array[0..MaxResidTypes] of Integer = (157,2101,2102);

  UADCmntCellXID: array[0..MaxUADCmntCellXID] of String = ('520','830','2056','2057','2065','2116');
  //In the future, if we need to add test for other form, we put main form id in MainFormArray
  // and the sub pages of the main in the sub page array, in the same position.
  MainFormIDArray: array[0..11] of Integer     = (340,342,345,347,349,351,353,355,357,360, 4218, 4365);  //added 1004P
  CertPageIDArray: array[0..11] of Integer     = (341,343,346,348,350,352,354,356,358,361, 4219, 4366);  //added 1004P
  XCompPageIDArray: array[0..9] of Integer    = (363,365,367,367,364,366,366,363,363,364);
  XListingPageIDArray: array[0..9] of Integer = (3545,0,888,888,869,0,0,3545,0,0);
  CondoFormIDArray: array[0..MaxCondoForms] of Integer     = (345,347,367,388,4201,4197);   //github #823
  UADAutoDlgXID: array[0..MaxUADAutoDlgXID] of Integer = (92,148,149,157,345,346,349,355,359,360,363,380,381,382,383,384,385,
                                                          413,414,986,1016,1808,1816,2000,2101,2102,2109,2030,2070,2071,2072,
                                                          2458,2657,3591,3998,4010);
Type
  TPageType = (tCert,tXComp,tXListing,tUnknown);


var
  FMainFormExistArray: array of String;
  FPageType: TPageType;

  function UserUADLicensed(UADIsOK: Boolean): Boolean;
  function IsOKToEnableUAD: Boolean;
  procedure SetUADServiceMenu(Value: Boolean);
  function IsUADForm(ID: Integer): Boolean;
  function IsGSEUADForm(ID: Integer): Boolean;
  function IsGSEUADFormName(FormName: String): Boolean;
  function IsUADWorksheet(theCell: TBaseCell): Boolean;
  function IsUADMasterForm(ID: Integer): Boolean;
  function HasUADForm(doc: TContainer): Boolean;
  function IsUADDataOK(Doc: TContainer; CompCol: TCompColumn; XID: Integer;
        var tmpStr: String; IsSubj: Boolean=False): Boolean;
  function GetImproveType(Desc: String): Integer;
  function GetImproveYrs(Desc: String): Integer;
  function CarStorageResidTextOK(Desc: String; var iGA, iGD, iGBI, iCP, iDW: Integer): Boolean;
  function CarStorageCondoTextOK(Desc: String; var iG, iCV, iOP: Integer): Boolean;
  function IsUADLengthOK(Doc: TContainer; Txt: String; MinLen, MaxLen: Integer; CellClassName: String; ValidateText: Boolean=False): Boolean;
  function IsUADSpecialCellChkOK(Doc: TContainer; theCell: TBaseCell): Boolean;
  function ISUADAdjustCellChkOK(grid: TCompMgr2; theCell: TBaseCell): Integer;
  function IsUADCellTextValid(theCell: TBaseCell; Doc: TContainer): Boolean;
  function UADDateFormatErr(CellXID: Integer; theFmt: String; var theDate: String): Boolean;
  function HasOnlyDecDigits(NumStr: string): boolean;
  function GetOnlyDigits(NumStr: String): String;
  function GetOnlyWholeNumber(NumStr: String): String;
  function PositiveAmtKey(Key: Char): Char;
  function GetNumKey(Key: Char): Char;
  function PositiveNumKey(Key: Char): Char;
  function PositiveRealNumKey(Key: Char): Char;
  function GetAlphaKey(Key: Char): Char;

  function FormatPrice(InAmt: String): String;
  function FormMoYr(InMoYr: String): String;
  function StripBegEndQuotes(theText: String): String;
  procedure SetUADCellFmt(Editor: TEditor; theCell: TBaseCell);
  procedure ProcessPriorSaleCells(doc: TContainer; theCell: TBaseCell; IsUAD: Boolean=False);
  procedure ProcessSpecialCells(doc: TContainer; theCell: TBaseCell; IsUAD: Boolean=False);
  function StripUADSubjCond(BodyText: String; IsUAD: Boolean=False): String;
  procedure ProcessGroupCellAdjs(doc: TContainer; UID: CellUID; IsUAD: Boolean=False);
  procedure ResetSubjAddr(Doc: TContainer);
  procedure SetCompMapAddr(CompCell: TGeocodedGridCell; Addr, UnitNo, City, State, Zip: String);
  function IsUADCell(theCell: TBaseCell): Boolean;
  function GetUADUnitCell(doc: TContainer): TBaseCell;
  function IsUADRestrictCell(doc:TContainer; AComp: TCompColumn; CID: String): Boolean;
  function IsUADRspCell(CellClassName: String): Boolean;
  function IsUADAutoDlgCell(doc:TContainer): Boolean;
  function PadTailWithSpaces(StrToPad: String; totalLen: Integer): String;
  function GetUADOnlyCellByID(doc: TContainer; CellID: Integer): TBaseCell;
  procedure TransferUADSubjectDataToReport(doc: TContainer; CX: CellUID);
  procedure TransferReportDataToUADSubject(doc: TContainer; Worksheet: TDocForm);
  function SetUADSpecialXML(theXML: String): String;
  function GetGSEDisplayGroup0520(GrpID: String; GSEGroups: TStringList; ExtOnly: Boolean=False): String;
  function IsExtOnlyReport(doc: TContainer): Boolean;
  procedure TransferGSEDisplayPts(doc: TContainer; GSEGroups: TStringList);
  function IsUnitAddrReq(theDoc: TContainer): Boolean;
  function IsResidReport(Doc: TContainer): Boolean;
  function DisplayUADStdDlg(doc: TContainer; CellClassName: String=''; CheckOnly: Boolean=False): Boolean;
  function DisplayNonUADStdDlg(doc:TContainer):Boolean;
  procedure SetDisplayUADText(theCell: TBaseCell; CellText: String);
  procedure ShowUADHelp(const HelpFileName, Caption: String; HelpType: Integer=0);
  function GetUADLinkedComments(Doc: TContainer; UADCell: TBaseCell): String;
  function FormUADLinkedCmntText(IsUAD: Boolean; CellXID: Integer; Body, Heading: String): String;

  function CheckRuleMisMatch(FormList:BooleanArray; docForm:TDocFormList; var ReviewList,sl:TStringList; var ReviewGrid:TosAdvDbGrid):Integer;
  function GetMainFormIndex(RevFileID:Integer):Integer;
  function IsCondoForm(theFormID:Integer): Boolean;
  function GetPageID(pType:TPageType;aMainFormIdx:Integer):Integer;
  function TestOtherPages(pType: TPageType; idx:Integer;docForm:TDocFormList;formList:BooleanArray):Boolean;
  procedure RefreshCurCell(Doc: TContainer);
  procedure UADPostProcess(Doc: TContainer; PrevCell, CurCell: TBaseCell);
  procedure AddRecord(var ReviewList:TStringList; var ReviewGrid:TosAdvDbGrid; text: String; frm, pg,cl: Integer;docForm:TDocFormList);
  procedure AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
  function IsUADCellActive(XID: Integer): Boolean;
  function UADTextWillOverflow(theCell: TBaseCell; theText: String): Boolean;

  function GridUADCellIsModified(var cList:TStringList): Boolean;
  function GetCellTextByActiveCell(doc: TContainer; cellID: Integer): String;
  procedure SetbathCellFormat(tmpStr: String; var theCell: TBaseCell);

  function PrefetchUADObject(aCellID:Integer; aCellTxt:String): String; //github 237
  function ConvertUAD_Cell2065(theCell: TBaseCell; doc: TContainer):String;
  function ConvertUAD_Cell2056(theCell: TBaseCell; doc: TContainer):String;
  function ConvertUAD_Cell2057(theCell: TBaseCell; doc: TContainer):String;
  function ConvertUAD_Cell90(theCell: TBaseCell; doc: TContainer):String;
  function ConvertUAD_CellSubjectDesign(theCell: TBaseCell; doc: TContainer):String;

//PAM: this routine is causing issue when trying to convert 07/29/19 will give you 07/29/91
//https://github.com/Bradtech302/ClickFORMs/issues/1602#event-2523744720
//  function ConvertDateStr(aDateStr:String; var aDate:TDateTime;  useNewDateFormat:Boolean=True):String;
//  function SetDateFormatByValue(var aDateValue:String; var AFormatSettings:TFormatSettings):String;
  function ConvertDateStr(aDateStr:String; var aDateTime:TDateTime; silent:Boolean=True):String;
  function AbbreviateViewFactor(str: string): String;
  function MakeFullViewLocFactor(str:String):String;
  procedure SetCellValueUAD(doc: TContainer; cellID: Integer; cellValue: string;FOverride:Boolean=True);
  function CalcBsmtPercent(bsmtGLA, bsmtFGLA:String):Integer;
  procedure InsertXCompPage(doc: TContainer; compNo: Integer);
  procedure InsertXListingPage(doc: TContainer; compNo: Integer);
  function IsListingForm(FormID:Integer):Boolean;
  function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
  function GetFormCertID(FormID:Integer):Integer; //github #647
  function GetFormIndex(doc: TContainer; aFormID:Integer):Integer;
  function GetUnitNoFromStreet(var Street:String):String;

  function GetMainFormID(doc: TContainer):Integer;
  function GetActualAgeByYearBuilt(EffDate:String; aYrBuilt: Integer):Integer;
  function MainFormExist(doc: TContainer; var frmID:Integer):Boolean;

implementation

uses
  StrUtils, UMain, UStrings, UPage, UWindowsInfo, UFormRichHelp, UStdRspUtil,
  UUADConstQuality,
  UUADGridCondition, UUADGridDataSrc, UUADGridRooms, UUADPropSubjAddr, UUADPropLineAddr,
  UUADGridLocRating, UUADSiteView, UUADSiteArea, UUADProjYrBuilt, UUADDateOfSale,
  UUADBasement, UUADSaleFinConcession, UUADMultiChkBox, UUADCommPctDesc,
  UUADContractAnalyze, UUADSubjCondition, UUADContractFinAssist, UUADSubjDataSrc,
  UUADResidDesignStyle, UUADCondoDesignStyle, UUADResidCarStorage, UUADCondoCarStorage,
  UWordProcessor, UAMC_XMLUtils, uBase, UUADObject,uMathMisc,UUADEffectiveAge;

const
  MaxAddrXID = 4;
  MaxUADForms = 21; //Ticket#1113, github #823: remove 4202 and 4198;, 4215 do not include 1025
  MaxUADExtForms = 3;
  MaxGSEUADForms = 11;    //added 1004P
  MaxUADMstrForms = 5;   //added 1004P
  MaxUADCellXID = 61;
  MaxUADGridXID = 81;
  MaxUADRestrictCID = 4;
  MaxUnitAddrFormID = 3;
  MaxUADText = 7;
  MaxImproveYrs = 4;
  MaxStAbbrev = 58;
  EstFlag = '~';

var
  UADForms: array[0..MaxUADForms] of Integer = (340,341,345,346,347,348,355,356,363,367,888,3545,
                                                4195,4187,4201,4188, 4197,4215,4220, 4218,4230, 4365);    //Ticket #1113, github #786 & 783 & 791, 966
  GSEUADForms: array[0..MaxGSEUADForms] of Integer = (340,341,345,346,347,348,355,356, 4218, 4219, 4365, 4366);
  GSEUADFormNames: array[0..MaxGSEUADForms] of String = ('FNMA 1004','FNMA 1004 Certification',
                                                         'FNMA 1073','FNMA 1073 Certification',
                                                         'FNMA 1075','FNMA 1075 Certification',
                                                         'FNMA 2055','FNMA 2055 Certification',
                                                         'FNMA 1004','FNMA 1004 Certification',
                                                         'FNMA 1004','FNMA 1004 Certification');
  UADExtForms: array[0..MaxUADExtForms] of Integer = (347,348,355,356);

  UADMstrForms: array[0..MaxUADMstrForms] of Integer = (340,345,347,355, 4218, 4365);
  UADCellXID: array[0..MaxUADCellXID] of Integer = (9,10,24,41,42,46,47,48,49,67,90,92,148,149,            //14
      151,157,200,201,208,229,230,231,345,346,363,380,381,382,383,384,385,520,827,828,829,830,986,         //23
      2048,2049,2054,2055,2056,2057,2063,2064,2065,2101,2102,2107,2109,2119,2120,2116,2141,2147,           //18
      2463,2464,2465,2758,2759,2760,2761);                                                                 //7
  UADGridXID: array[0..MaxUADGridXID] of Integer = (925,926,962,976,984,986,994,996,998,1041,1042,1043,
      1006,1008,1016,1801,1802,1808,1809,1810,1811,1812,1813,1814,1816,1817,1818,1827,1828,1829,1830,1831,1832,
      1833,1835,1836,1837,1846,1847,1848,1849,1850,1851,1852,1854,1855,1856,1865,1866,1867,1868,1869,
      1870,1871,1873,1874,1875,2282,2310,3981,3982,3995,3996,3998,3999,4000,4001,4002,4003,4004,4005,
      4006,4007,4008,4009,4010,4011,4012,4013,4014,4015,4016);
  UADRestrictCID: array[0..MaxUADRestrictCID] of String = ('930','931','956','958','960');
  UnitAddrFormID: array[0..MaxUnitAddrFormID] of Integer = (345,346,347,348);
  UnitAddrFormIDStr: array[0..MaxUnitAddrFormID] of String = ('345','346','347','348');
  SubjAddrCells: array[0..MaxAddrXID] of Integer = (46,47,48,49,2141);
  SubjMungeID: array[0..MaxAddrXID] of Integer = (kAddress,kCity,kState,kZip,kUnitNo);
  CompAddrCells: array[0..MaxAddrXID] of String = ('925','4527','4528','4529','4530');
  USStateAbbrevs: array[0..MaxStAbbrev] of String = ('AL','AK','AR','AS','AZ','CA','CO','CT','DC','DE','FL',
      'FM','GA','GU','HI','IA','ID','IL','IN','KY','KS','LA','MA','MD','ME','MH','MI','MN','MO','MP','MS',
      'MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','PW','RI','SC','SD','TN','TX',
      'UT','VA','VI','VT','WA','WI','WV','WY');

  BsmtAccessXMLID: array[0..MaxAccessIdx] of Integer = (1520,1521,1524);
  BsmtAreaXMLID: array[0..MaxAccessIdx] of Integer = (200,201,1509);
  BsmtRoomXMLID: array[0..MaxBsmtRoomIdx] of Integer = (1683,1687,1688,1709,1658);

  FReviewErrFound: Boolean;
  FCriticalErrCount: Integer;

constructor TCellID.Create;
begin
  inherited Create;

  Form := - 1;
  Pg := -1;
  Num := -1;
end;



//used to debug the tring groups
procedure DebugGSEGroup(GSEGroup: TStringList; Title:String='');
var
  i: Integer;
  theList: String;
begin
  if True then
    if GSEGroup.Count > 0 then
      begin
        theList := '';
        if Title <> '' then
          theList := Title + #13#10;
        for i := 0 to Pred(GSEGroup.Count) do
          theList := theList + GSEGroup[i] + #13#10;
        ShowMessage(theList);
     end;
end;

//procedure for setting the UAD Service Menu with Cmd.
procedure SetUADServiceMenu(Value: Boolean);
begin
  if Value then    //set the UAD Compliance Menu Item
    begin
      Main.ServiceUADPrefCmd.Caption := msgUADEnableFeatures;
      Main.ServiceUADPrefCmd.checked := True;
    end
  else
    begin
      Main.ServiceUADPrefCmd.Caption := msgUADDisableFeatures;
      Main.ServiceUADPrefCmd.checked := False;
    end;
end;

function FilterDate(aDateStr:String):String;
var
  p: Integer;
  str1, str2: String;
begin
  result := aDateStr;
  if pos('|', aDateStr) > 0 then
    result := StringReplace(aDateStr, '|',';',[rfReplaceAll])
  else if pos('~', aDateStr) > 0 then
    result := StringReplace(aDateStr, '~',';',[rfReplaceAll])
  else if pos(' ', aDateStr) > 0 then
    result := StringReplace(aDateStr, ' ', ';', [rfReplaceAll]);
  p := pos('-', aDateStr);
  if (p > 0) then
    begin
      if p >= 7 then
        begin
          str1 := copy(aDateStr, 1, p);
          str2 := copy(aDateStr, p+1, length(adateStr));
          result:= copy(str1, 1, length(str1) -1) + ';'+str2;
        end;
    end;
end;

function IsUADDataOK(Doc: TContainer; CompCol: TCompColumn; XID: Integer;
  var tmpStr: String; IsSubj: Boolean=False): Boolean;
const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;
var
  UADCell, UADAltCell, theCell: TBaseCell;
  DOMDays, EndIdx, PosIdx, PosItem, PosGSE: Integer;
  Yr, Mo, Dy: Word;
  sCity, sState, sUnit, sZip, sAge, sItem, sItem1, sItem2, sTemp: String;
  HBaths: Integer;
  SiteArea, TmpDbl: Double;
  CityStZip, AgeApprox, Influence: String;
  iGA, iGD, iGBI, iCP, iDW: Integer; // car storage attached, detached, built-in, carport & driveway quantities
  iG, iCV, iOP: Integer; // condo car storage garage, covered, open quantities
  aDateTime:TDateTime;
  sDate, cDate, yrStr, oDateStr: String;
begin
  Result := True; // no validation error - default
  if IsSubj then
    theCell := Doc.GetCellByXID(XID)
  else
    theCell := CompCol.GetCellByID(XID);
  if Assigned(theCell) and Doc.UADEnabled and (not IsUADWorksheet(theCell)) and IsUADCellActive(XID) then
    case XID of
      926:
        try
          UADCell := CompCol.GetCellByID(925);
          sUnit := '';
          CityStZip := tmpStr;
          PosGSE := Pos(',',CityStZip);
          if PosGSE > 0 then
            begin
              // If there is a unit number (2 commas in the address) then
              //  retrieve the unit and capture only the city, state and zip
              //  for further processing
              if Pos(',', Copy(CityStZip, Succ(PosGSE), Length(CityStZip))) > 0 then
                begin
                  sUnit := Copy(cityStZip, 1, Pred(PosGSE));
                  CityStZip := Copy(CityStZip, Succ(PosGSE), Length(CityStZip));
                end;
              sCity  := ParseCityStateZip2(CityStZip, cmdGetCity);
              sState := ParseCityStateZip2(CityStZip, cmdGetState);
              sZip   := ParseCityStateZip2(CityStZip, cmdGetZip);
            end
          else
            begin
              sCity  := ParseCityStateZip3(CityStZip, cmdGetCity);
              sState := ParseCityStateZip3(CityStZip, cmdGetState);
              sZip   := ParseCityStateZip3(CityStZip, cmdGetZip);
            end;
          tmpStr := '';
          if sUnit <> '' then
            tmpStr := sUnit + ', ';
          tmpStr := TmpStr + sCity + ', ';
          tmpStr := TmpStr + sState + ' ';
          tmpStr := TmpStr + sZip;
          if (Trim(UADCell.Text) <> '') and
             ((Length(sCity) = 0) or
              (Length(sState) = 0) or
              (Length(sZip) = 0)) then
            Result := False; // validation error detected
        except
          Result := False;
        end;
      930:
        if (not IsSubj) and (Trim(tmpStr) <> '') then
          try
            Result := False;
            PosItem := Pos(';', tmpStr);
            if (PosItem > 0) then
              begin
                sItem := Trim(Copy(tmpStr, 1, Pred(PosItem)));
                sItem1 := Trim(Copy(tmpStr, Succ(PosItem), Length(tmpStr)));
                if (sItem <> '') and (sItem1 <> '') then
                  if IsValidInteger(sItem1, DOMDays) then
                    begin
                      tmpStr := sItem + ';DOM ' + IntToStr(DOMDays);
                      Result := True;
                    end
                  else if sItem1 = 'DOM Unk' then
                    Result := True;
              end;
          except
            Result := False;
          end;
      956:
        if (not IsSubj) and (Trim(tmpStr) <> '') then
          try
            UADCell := CompCol.GetCellByID(958);
            //gitHub #161: PAM 12/09/2015 if UADCell is nil do not check the rest
            //if (not Assigned(UADCell)) or UADCell.HasValidationError or (Trim(UADCell.Text) = '') then
            if (Assigned(UADCell)) AND
               (UADCell.HasValidationError or (Trim(UADCell.Text) = '')) then
              begin
                Result := False;
                UADCell.HasValidationError := True;
              end
            else
              begin
                Result := (AnsiIndexText(tmpStr, SalesTypesDisplay) >= 0);
                //if not Result then  //PAM
                if not Result and assigned(UADCell) then
                  UADCell.HasValidationError := True;
              end;
          except
            Result := False;
          end;
      958:
        if (not IsSubj) and (Trim(tmpStr) <> '') then
          try
            UADCell := CompCol.GetCellByID(956);
            //gitHub #161: PAM 12/09/2015 if UADCell is nil do not check the rest
            //if (not Assigned(UADCell)) or UADCell.HasValidationError or (Trim(UADCell.Text) = '') then
            if (Assigned(UADCell)) AND
               (UADCell.HasValidationError or (Trim(UADCell.Text) = '')) then
              begin
                Result := False;
                UADCell.HasValidationError := True;
              end
            else
              begin
                PosItem := Pos(';', tmpStr);
                if PosItem > 1 then
                  sItem := Copy(tmpStr, 1, Pred(PosItem))
                else
                  sItem := tmpStr;
                PosIdx := AnsiIndexText(sItem, FinDesc);
                if PosItem > 1 then
                  begin
                    sItem := Copy(sTemp, Succ(PosItem), Length(tmpStr));
                    Result := ((sItem <> '') and IsValidInteger(sItem, PosIdx));
                  end
                else
                  tmpStr := tmpStr + ';0';
              end;
          except
            Result := False;
          end;
      960:
        if (not IsSubj) and (Trim(tmpStr) <> '') then  // UAD specs do not allow subject sale date in the grid
          try
            tmpStr := trim(tmpStr);
            oDateStr := tmpStr;
            //github #370: Handle date in different format: use the input date to temporary change the locate date format in local
            tmpStr := FilterDate(tmpStr);  //set the separator between 2 dates with ';'
            if (pos(';', tmpStr) > 0) then
              begin
                sDate := popStr(tmpStr, ';');
                if sDate <> '' then
                  begin
                    sDate := ConvertDateStr(sDate, aDateTime);
                    if sDate <> '' then
                      TryStrToDate(sDate, aDateTime);
                    if aDateTime > 0 then
                      begin
                        DecodeDate(aDateTime, Yr, Mo, Dy);
                        if yr > 0 then
                          begin
                            yrStr := Format('%d',[yr]);
                            if length(yrStr) = 4 then
                              yrStr := copy(yrStr, 3, 2);  //only pick up the last 2 digits
                            sDate := Format('s%2.2d/%s',[mo,yrStr]);  //put in smm/yy format
                          end;
                      end;
                  end;
                cDate := tmpStr; //handle contract date
                if pos(':', tmpStr) > 0 then //it's time string
                  cDate := ''  //set to EMPTY
                else if pos(';', tmpStr) > 0 then
                  begin
                    popStr(tmpStr, ';');
                    cDate := tmpStr;
                  end;
                if (cDate <> '') then  //a valid date
                  begin
                    cDate := ConvertDateStr(cDate, aDateTime);
                    if aDateTime > 0 then
                      begin
                        DecodeDate(aDateTime, Yr, Mo, Dy);
                        if yr > 0 then
                          begin
                            yrStr := Format('%d',[yr]);
                            if length(yrStr) = 4 then
                              yrStr := copy(yrStr, 3, 2);  //only pick up the last 2 digits
                            cDate := Format('c%2.2d/%s',[mo,yrStr]);  //put in smm/yy format
                          end
                        else
                          cDate := Format('c%2.2d/%2.2d',[mo,yr]);  //put in smm/yy format
                      end;
                  end;
                if (cDate = '') and (sDate <> '') then
                  tmpStr := sDate +';Unk'
                else if (cDate <>'') and (sdate<>'')  then
                  tmpStr := sdate + ';'+cDate
                else
                  begin
                    if trim(oDateStr) = ';' then
                      tmpStr := ''
                    else
                      tmpStr := oDateStr;
                  end;
              end
            else  //we only have one single sales date, contract daet will be unknown
              begin
                tmpStr := ConvertDateStr(tmpStr, aDateTime);
                if aDateTime > 0 then
                  begin
                    DecodeDate(aDateTime, Yr, Mo, Dy);
                    if yr > 0 then
                      begin
                        yrStr := Format('%d',[yr]);
                        if length(yrStr) = 4 then
                          yrStr := copy(yrStr, 3, 2);  //only pick up the last 2 digits
                        sDate := Format('s%2.2d/%s',[mo,yrStr]);  //put in smm/yy format
                      end;
                    if sDate <> '' then
                      tmpStr := sDate + ';' + 'Unk';
                  end;
              end;
          except
            Result := False;
          end;
      962:
        try
          if Trim(tmpStr) <> '' then
            begin
              Influence := Copy(tmpStr, 1, 1);
              PosIdx := AnsiIndexText(Influence, InfluenceDisplay);
              if PosIdx < 0 then
                Result := False
              else if Copy(tmpStr, 2, 1) = ';' then
                begin
                  sTemp := Copy(tmpStr, 3, Length(tmpStr));
                  PosIdx := Pos(';', sTemp);
                  if PosIdx > 1 then
                    begin
                      sItem := Copy(sTemp, 1, Pred(PosIdx));
                      if sItem = '' then
                        Result := False
                      else
                        begin
                          sTemp := Copy(sTemp, Succ(PosIdx), Length(sTemp));
                          if sTemp = '' then
                            Result := False
                        end;
                    end
                  else if sTemp = '' then
                    Result := False;
                end
              else
                Result := False;
            end;
        except
          Result := False;
        end;
      67, 976: //site area
        try
          if Trim(tmpStr) <> '' then
            begin
              if XID = 976 then
                UADCell := CompCol.GetCellByID(976)
              else
                UADCell := Doc.GetCellByXID(67);
              SiteArea := StrToFloat(GetFirstNumInStr(StringReplace(tmpStr, ',', '', [rfReplaceAll]), False, EndIdx));
              if Assigned(UADCell) and (SiteArea > 0) and (tmpStr <> '') then
              begin
                PosItem := Pos('ACRE', Uppercase(tmpStr));
                if PosItem = 0 then
                  PosItem := Pos('AC', Uppercase(tmpStr));
                if (PosItem > 0) then
                  tmpStr := Trim(Format('%-20.2f', [SiteArea])) + ' ' + cAcres
                else
                  // assume square feet
                  begin
                    if SiteArea >= cAcre then
                      tmpStr := Trim(Format('%-20.2f', [SiteArea / cAcre])) + ' ' + cAcres
                    else
                      tmpStr := Trim(Format('%-20.0f', [SiteArea])) + ' ' + cSqFt;
                  end;
                tmpStr := StringReplace(tmpStr, ',', '', [rfReplaceAll]);
              end;
            end;
        except
          Result := False;
        end;
      90, 984:   //view
        try
          if Trim(tmpStr) <> '' then
            begin
              Influence := Copy(tmpStr, 1, 1);
              PosIdx := AnsiIndexText(Influence, InfluenceDisplay);
              if PosIdx < 0 then
                Result := False
              else if Copy(tmpStr, 2, 1) = ';' then
                begin
                  sTemp := Copy(tmpStr, 3, Length(tmpStr));
                  PosIdx := Pos(';', sTemp);
                  if PosIdx > 1 then
                    begin
                      sItem := Copy(sTemp, 1, Pred(PosIdx));
                      if sItem = '' then
                        Result := False
                      else
                        begin
                          sTemp := Copy(sTemp, Succ(PosIdx), Length(sTemp));
                          if sTemp = '' then
                            Result := False
                        end;
                    end
                  else if sTemp = '' then
                    Result := False;
                end
              else
                Result := False;
            end;
        except
          Result := False;
        end;
      986, 1808, 3998:    //design
        try
          if Trim(tmpStr) <> '' then
            begin
              PosIdx := Pos(';', tmpStr);
              if PosIdx < 0 then
                Result := False
              else
                begin
                  sTemp := Copy(tmpStr, 1, Pred(PosIdx));
                  if Doc.GetCellByXID(966) <> nil then   //Cell XID 966 only on 1073 & 1075 families
                    begin
                      Result := (Copy(sTemp, Length(sTemp), 1) = 'L');
                      if Result then
                        begin
                          sTemp := Copy(tmpStr, 1, Pred(Length(sTemp)));
                          if Copy(sTemp, 1, 1) = 'O' then
                            sTemp := Copy(sTemp, 2, Length(sTemp))
                          else
                            begin
                              PosIdx := AnsiIndexText(Copy(sTemp, 1, 2), CondoAttachType);
                              if PosIdx < 0 then
                                Result := False
                              else
                                begin
                                  sTemp := Copy(sTemp, 3, Length(sTemp));
                                  Result := (IsValidNumber(sTemp, TmpDbl) and (Pos('.', sTemp) = 0));
                                end;
                            end;
                        end;
                    end
                  else
                    begin
                      PosIdx := AnsiIndexText(Copy(sTemp, 1, 2), ResidAttachType);
                      if PosIdx < 0 then
                        Result := False
                      else
                        begin
                          sTemp := Copy(sTemp, 3, Length(sTemp));
                          Result := IsValidNumber(sTemp, TmpDbl);
                        end;
                    end;
                end;
            end;
        except
          Result := False;
        end;
      994:  //quality
        if Trim(tmpStr) <> '' then
          Result := (AnsiIndexText(tmpStr, QualityListTypCode) >= 0);
      996:  //age
        if Trim(tmpStr) <> '' then
          begin
            if compcol.FCompID = 0 then
              UADAltCell := Doc.GetCellByID(151)
            else
              UADAltCell := nil;
            if Copy(tmpStr, 1, 1) = EstFlag then
              AgeApprox := EstFlag
            else
              AgeApprox := '';
            sAge := GetOnlyDigits(tmpStr);
            if Length(sAge) > 0 then
              begin
                if (Length(sAge) = 4) then
                  tmpStr := AgeApprox + IntToStr(YearOf(Date) - StrToInt(sAge))
                else
                  tmpStr := AgeApprox + sAge;
                if Assigned(UADAltCell) then
                  UADAltCell.SetText(AgeApprox + IntToStr(YearOf(Date) - StrToInt(sAge)));
              end;
          end;
      998: //condition
        if Trim(tmpStr) <> '' then
          begin
            if compcol.FCompID = 0 then
              UADAltCell := Doc.GetCellByID(520)
            else
              UADAltCell := nil;
            if AnsiIndexText(tmpStr, ConditionListTypCode) < 0 then
              Result := False
            else
              if Assigned(UADAltCell) then
                UADAltCell.SetText(tmpStr + Copy(UADAltCell.GetText, 3, Length(UADAltCell.GetText)));
          end;
      229, 1041:
        Result := (HasOnlyDigits(tmpStr) and (Length(tmpStr) < 3));
      230, 1042:
        Result := (HasOnlyDigits(tmpStr) and (Length(tmpStr) < 3));
      231, 1043:
        begin
          if HasOnlyDecDigits(tmpStr) and (Length(tmpStr) < 5) then
            begin
              PosIdx := Pos('.', tmpStr);
              if (PosIdx = 0) then
                tmpStr := tmpStr + '.0'
              else
                begin
                  // If more than 9 half baths flag it as an error. Most likely
                  //  the incoming data is '25', '50' or '75' signaling 1/4, 1/2
                  //  or 3/4 and not UAD format.
                  HBaths := StrToIntDef(Copy(tmpStr, Succ(PosIdx), Length(tmpStr)), 0);
                  if HBaths > 9 then
                    Result := False;
                  tmpStr := Copy(tmpStr, 1, Pred(PosIdx)) + '.' + IntToStr(HBaths);
                end;

              // Set formatting to ensure that '1.1' does not show as '1.10'
              if (PosIdx = 0) or (StrToIntDef(Copy(tmpStr, Succ(PosIdx), Length(tmpStr)), 0) < 9) then
                begin
                  theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P2);    //clear round to 0.01
                  theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
                end
              else
                begin
                  theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P1);   //clear round to 0.1
                  theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);   //round to 0.01
                end;
            end
           else
             begin
               theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
               Result := False; // validation error detected
             end;
        end;
      200, 1006:
        begin
          if Trim(tmpStr) <> '' then
            begin
              sItem := '';
              sItem1 := '';
              sItem2 := '';
              UADAltCell := CompCol.GetCellByID(1008);
              sTemp := Uppercase(StringReplace(tmpStr, ' ', '', [rfReplaceAll]));
              if ((sTemp = 'CRAWLSPACE') or (sTemp = 'CONCRETESLAB') or
                  (sTemp = 'NONE') or (sTemp = '') or (sTemp = '0SF')) then
                begin
                  sItem := '0';
                  sItem1 := '0';
                  tmpStr := '0sf';
                  if assigned(UADAltCell) then //PAM
                    UADAltCell.SetText(' ');
                  if IsSubj then
                    begin
                      UADAltCell := Doc.GetCellByXID(200);
                      if Assigned(UADAltCell) then
                        begin
                          if XID = 200 then
                            tmpStr := '0';
                          UADAltCell := Doc.GetCellByXID(201);
                          if UADAltCell <> nil then
                            UADAltCell.Text := ' ';
                          UADAltCell := Doc.GetCellByXID(208);
                          if UADAltCell <> nil then
                            UADAltCell.Text := ' ';
                        end;
                    end;
                end
              else
                begin
                  PosItem := Pos('sf', tmpStr);
                  if PosItem > 1 then
                    begin
                      sItem := Copy(tmpStr, 1, Pred(PosItem));
                      if IsValidInteger(sItem, PosIdx) then
                        begin
                          sTemp := Copy(tmpStr, (PosItem + 2), Length(tmpStr));
                          PosItem := Pos('sf', sTemp);
                          if PosItem > 1 then
                            begin
                              sItem := Copy(sTemp, 1, Pred(PosItem));
                              if IsValidInteger(sItem, PosIdx) then
                                sItem1 := IntToStr(Round(100 * (PosIdx / StrToInt(sItem))))
                              else
                                Result := False;
                            end;
                          sTemp := Copy(sTemp, (PosItem + 2), 2);
                          PosIdx := AnsiIndexText(sTemp, BsmtAccessDisplay);
                          if PosIdx >= 0 then
                            sItem2 := BsmtAccessListXML[PosIdx]
                          else
                            Result := False;
                        end
                      else
                        Result := False;
                    end
                  else
                    Result := False;
                  if IsSubj then
                    begin
                      tmpStr := sItem;
                      UADAltCell := Doc.GetCellByXID(201);
                      if Assigned(UADAltCell) then
                        UADAltCell.Text := sItem1;
                      UADAltCell := Doc.GetCellByXID(208);
                      if Assigned(UADAltCell) and ((sItem2 = 'WalkUp') or (sItem2 = 'WalkOut')) then
                        UADAltCell.Text := 'X'
                      else if assigned(UADAltCell) then //PAM
                        UADAltCell.Text := ' ';
                    end;

                end;
            end;
        end;
      201:
        if Trim(tmpStr) <> '' then
          begin
            UADCell := Doc.GetCellByXID(200);
            if Assigned(UADCell) then
              begin
                sTemp := Uppercase(Trim(tmpStr));
                if (sTemp = 'NONE') then
                  tmpStr := '';
              end;
          end;
      1008:   //room below grade
        begin
          UADCell := CompCol.GetCellByID(1006);
          if Assigned(UADCell) then
            begin
              if (Pos('rr', tmpStr) = 2) and
                 (Pos('br', tmpStr) = 5) and
                 (Pos('ba', tmpStr) = 10) and
                 (Pos('o', tmpStr) = 13) then
                begin
                  sItem := Copy(tmpStr, 1, 1);
                  if not IsValidInteger(sItem, PosIdx) then
                    Result := False;
                  sItem := Copy(tmpStr, 4, 1);
                  if not IsValidInteger(sItem, PosIdx) then
                    Result := False;
                  sItem := Copy(tmpStr, 7, 3);
                  if (not IsValidInteger(sItem[1], PosIdx)) or (sItem[2] = '.') or (not IsValidInteger(sItem[3], PosIdx)) then
                    Result := False;
                  sItem := Copy(tmpStr, 12, 1);
                  if not IsValidInteger(sItem, PosIdx) then
                    Result := False;
                  if (UADCell.Text = '') or (UADCell.Text = '0sf') then
                    Result := False;
                end
              else
                if (UADCell.Text = '0sf') then
                  begin
                    tmpStr := ' ';  // Add a space character so later validation does not flag as error
                  end
              else
                if ((Trim(tmpStr) = '') and (UADCell.Text <> '0sf')) or
                   ((tmpStr <> '') and (UADCell.Text = '0sf')) then
                  Result := False;
            end;
        end;
      1016, 1816, 4010: //garage carport
        begin
          UADCell := CompCol.GetCellByID(1016);
          if Assigned(UADCell) then
            if IsCondoForm(UADCell.UID.FormID) then
              begin
                Result := CarStorageCondoTextOK(UADCell.Text, iG, iCV, iOP);
                if Result and (UADCell.FContextID > 0) then
                  begin
                    UADAltCell := Doc.GetCellByXID(345);
                    if Assigned(UADAltCell) then
                      Result := (StrToIntDef(UADAltCell.Text, 0) = (iG + ICV + iOP));
                  end;
              end
            else
              begin
                Result := CarStorageResidTextOK(UADCell.Text, iGA, iGD, iGBI, iCP, iDW);
                if Result and (UADCell.FContextID > 0) then
                  begin
                    UADAltCell := Doc.GetCellByXID(355);
                    if Assigned(UADAltCell) then
                      Result := (StrToIntDef(UADAltCell.Text, 0) = iCP);
                    if Result then
                      begin
                        UADAltCell := Doc.GetCellByXID(360);
                        if Assigned(UADAltCell) then
                          Result := (StrToIntDef(UADAltCell.Text, 0) = iDW);
                      end;
                    if Result then
                      begin
                        UADAltCell := Doc.GetCellByXID(2030);
                        if Assigned(UADAltCell) then
                          Result := (StrToIntDef(UADAltCell.Text, 0) = (iGA + iGD + iGBI));
                      end;
                  end;
              end;
        end;
      2141:
        // We don't need to handle unit numbers for the subject here as they
        //  are handled through the munger.
        if not IsSubj then
          try
            Result := (Length(tmpStr) > 0);
          except
            Result := False; // validation error detected
          end;
    end;
end;

function GetImproveType(Desc: String): Integer;
var
  Cntr: Integer;
begin
  Result := -1;
  for Cntr := 0 to 2 do
  if Desc = ImproveType[Cntr] then
   Result := Cntr;
end;

function GetImproveYrs(Desc: String): Integer;
var
  Cntr: Integer;
begin
  Result := -1;
  for Cntr := 0 to 4 do
  if Desc = ImproveYrs[Cntr] then
   Result := Cntr;
end;

function CarStorageResidTextOK(Desc: String; var iGA, iGD, iGBI, iCP, iDW: Integer): Boolean;
var
  tmpStr: String;

  function CarStorageIsOK(Idx, IdxLen: Integer; var theStr: String; var Qty: Integer): Boolean;
  begin
    if (Idx > 0) and (Length(theStr) > 0) then
      begin
        Qty := StrToIntDef(Copy(theStr, 1, Pred(Idx)), 0);
        Result := (Qty > 0);
        theStr := Copy(theStr, (Idx + IdxLen), Length(theStr));
      end
    else
      Result := True;
  end;

begin
  Result := (Desc = 'None');
  if not Result then
    begin
      Result := True;
      tmpStr := Desc;
      // check the order ga-->gd-->gbi-->cp-->dw
      iGA := Pos('ga', tmpStr);
      iGD := Pos('gd', tmpStr);
      iGBI := Pos('gbi', tmpStr);
      iCP := Pos('cp', tmpStr);
      iDW := Pos('dw', tmpStr);
      if iGA > 0 then
        begin
          Result := (iGD > iGA) or (iGD = 0);
          if Result then
            Result := (iGBI > iGA) or (iGBI = 0);
          if Result then
            Result := (iCP > iGA) or (iCP = 0);
          if Result then
            Result := (iDW > iGA) or (iDW = 0);
        end;
      if Result and (iGD > 0) then
        begin
          Result := (iGBI > iGD) or (iGBI = 0);
          if Result then
            Result := (iCP > iGD) or (iCP = 0);
          if Result then
            Result := (iDW > iGD) or (iDW = 0);
        end;
      if Result and (iGBI > 0) then
        begin
          Result := (iCP > iGBI) or (iCP = 0);
          if Result then
            Result := (iDW > iGBI) or (iDW = 0);
        end;
      if Result and (iCP > 0) then
        Result := (iDW > iCP) or (iDW = 0);
      //now check for proper amounts
      if Result then
        Result := CarStorageIsOK(Pos('ga', tmpStr), 2, tmpStr, iGA);
      if Result then
        Result := CarStorageIsOK(Pos('gd', tmpStr), 2, tmpStr, iGD)
      else
        CarStorageIsOK(Pos('gd', tmpStr), 2, tmpStr, iGD);
      if Result then
        Result := CarStorageIsOK(Pos('gbi', tmpStr), 3, tmpStr, iGBI)
      else
        CarStorageIsOK(Pos('gbi', tmpStr), 3, tmpStr, iGBI);
      if Result then
        Result := CarStorageIsOK(Pos('cp', tmpStr), 2, tmpStr, iCP)
      else
        CarStorageIsOK(Pos('cp', tmpStr), 2, tmpStr, iCP);
      if Result then
        Result := CarStorageIsOK(Pos('dw', tmpStr), 2, tmpStr, iDW)
      else
        CarStorageIsOK(Pos('dw', tmpStr), 2, tmpStr, iDW);
      //now check for any remaining characters --> tmpStr should be empty now
      if Result then
        Result := (Length(tmpStr) = 0);
    end;
end;

function CarStorageCondoTextOK(Desc: String; var iG, iCV, iOP: Integer): Boolean;
var
  tmpStr: String;
  PosSC1, PosSC2: Integer;

  function CarStorageIsOK(Idx, IdxLen: Integer; var theStr: String; var Qty: Integer): Boolean;
  begin
    if (Idx > 0) and (Length(theStr) > 0) then
      begin
        Qty := StrToIntDef(Copy(theStr, 1, Pred(Idx)), 0);
        Result := (Qty > 0);
        theStr := Copy(theStr, (Idx + IdxLen), Length(theStr));
      end
    else
      Result := True;
  end;

begin
  Result := (Desc = 'None');
  if not Result then
    begin
      Result := True;
      tmpStr := Desc;

      // discard any description after 1st or 2nd semicolon
      PosSC1 := Pos(';', tmpStr);
      if PosSC1 > 0 then
        begin
          PosSC2 := Pos(';', Copy(tmpStr, Succ(PosSC1), Length(tmpStr)));
          if PosSC2 > 0 then
            tmpStr := Copy(tmpStr, 1, Pred(PosSC1 + PosSC2))
          else
            tmpStr := Copy(tmpStr, 1, Pred(PosSC1));
        end;
      // check the order g-->cv-->op
      iG := Pos('g', tmpStr);
      iCV := Pos('cv', tmpStr);
      iOP := Pos('op', tmpStr);
      if iG > 0 then
        begin
          Result := (iCV > iG) or (iCV = 0);
          if Result then
            Result := (iOP > iG) or (iOP = 0);
        end;
      if Result and (iCV > 0) then
        Result := (iOP > iCV) or (iOP = 0);
      //now check for proper amounts
      if Result and (iG > 0) then
        Result := CarStorageIsOK(Pos('g', tmpStr), 1, tmpStr, iG);
      if Result then
        Result := CarStorageIsOK(Pos('cv', tmpStr), 2, tmpStr, iCV)
      else
        CarStorageIsOK(Pos('cv', tmpStr), 2, tmpStr, iCV);
      if Result then
        Result := CarStorageIsOK(Pos('op', tmpStr), 2, tmpStr, iOP)
      else
        CarStorageIsOK(Pos('op', tmpStr), 2, tmpStr, iOP);
    end;
end;

function IsUADLengthOK(Doc: TContainer; Txt: String; MinLen, MaxLen: Integer;
  CellClassName: String; ValidateText: Boolean=False): Boolean;
var
  Str: String;
begin
  Result := True;
  // 062911 JWyatt Add ValidateText parameter if true the routine will check
  //  Txt for min/max compliance even if it is null.
  //Don't you need to check to see if its a UAD cell - JB
  if Doc.UADEnabled and (ValidateText or (Trim(Txt) <> '')) then
    begin
      Str := Txt;
      if (CellClassName = 'TPositiveWholeNumericSLEditor') or
         (CellClassName = 'TPositiveWholeTenThousandsNumericGridEditor') or
         (CellClassName = 'TWholeNumericSLEditor') or
         (CellClassName = 'TWholeNumericGridEditor') or
         (CellClassName = 'TPositiveDollarsNumericSLEditor') or
         (CellClassName = 'TDollarsNumericSLEditor') or
         (CellClassName = 'TDollarsNumericGridEditor') or
         (CellClassName = 'TNumericGridEditor') or
         (CellClassName = 'TSLEditor') then
        StripCommas(Str);
      if (((MinLen > 0) and (Length(Str) < MinLen)) or
         ((MaxLen > 0) and (Length(Str) > MaxLen))) then
        Result := False;
    end;
end;

function IsUADSpecialCellChkOK(Doc: TContainer; theCell: TBaseCell): Boolean;
// This routine performs any special cell checking not covered by IsUADLengthOK
//  and IsUADCellTextValid.
var
  Incr, PosItem, PosItem1, TmpInt, TmpInt1, TmpInt2, TmpInt3, TmpInt4: Integer;
  UID: CellUID;
  AltCell1, AltCell2, FUADCell: TBaseCell;
  AltUID: CellUID;
  AltCell1Chkd, AltCell2Chkd, IsDrByForm: Boolean;
  UnitNo, City, State, Zip, TmpStr, TmpStr1: String;

  function BasementTextOK(sfStr, rmStr: String): Boolean;
  var
    PosItem, FinSqFt: Integer;
    TmpStr: String;
  begin
    // False if there is room text - can't have rooms without a basement
    if (sfStr = '0sf') or (sfStr = '') then
      Result := (Trim(rmStr) = '')
    else
      begin
        PosItem := Pos('sf', sfStr);
        if (PosItem > 0) then
          begin
            TmpStr := Copy(sfStr, (PosItem + 2), Length(sfStr));
            PosItem := Pos('sf', TmpStr);
            if (PosItem > 0) then
              begin
                TmpStr := Copy(TmpStr, 1, Pred(PosItem));
                FinSqFt := StrToIntDef(TmpStr, -1);
                if FinSqFt > 0 then
                  Result := (rmStr <> '')
                else if FinSqFt = 0 then
                  Result := (rmStr = '')
                else
                  Result := False;
              end
            else
              Result := False;
          end
        else
          Result := False;
      end;
  end;

  function XID2116TextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
  begin
    // False if there is no semi-colon or no comment text
    PosItem := Pos(';', CellStr);
    if (PosItem = 0) or (Trim(Copy(CellStr, Pred(PosItem), 1)) <> '%') or
       (StrToIntDef(Copy(CellStr, 1, (PosItem - 2)), 0) = 0) or
       (Trim(Copy(CellStr, Succ(PosItem), Length(CellStr))) = '') then
      Result := False
    else
      Result := True;
  end;

  function XID2065TextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
  begin
    PosItem := Pos(DOMHint, CellStr);
    if (PosItem = 0) then
      Result := False
    else
      begin
        CellStr := Copy(CellStr, 5, Length(CellStr));
        Result := ((CellStr <> '') and ((CellStr = 'Unk') or HasOnlyDigits(CellStr)));
      end;
  end;

  function XID2056TextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
  begin
    PosItem := Pos(';', CellStr);
    if (PosItem = 0) or (Trim(Copy(CellStr, Succ(PosItem), Length(CellStr))) = '') then
      Result := False
    else
      begin
        CellStr := Copy(CellStr, 1, Pred(PosItem));
        // False if there is no sales type match
        Result := (AnsiIndexStr(CellStr, SalesTypesTxt) >= 0);
      end;
  end;

  function XID958TextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
  begin
    PosItem := Pos(';', CellStr);
    if (PosItem = 0) or (Trim(Copy(CellStr, 1, Pred(PosItem))) = '') or (Trim(Copy(CellStr, Succ(PosItem), Length(CellStr))) = '') then
      Result := False
    else
      begin
        CellStr := Copy(CellStr, 1, Pred(PosItem));
        // False if there is no sales type match
        TmpInt := AnsiIndexStr(CellStr, FinType);
        Result := (TmpInt <> MaxFinTypes);
      end;
  end;

  function XID2057YesTextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
    TmpStr, TmpStr1, TmpStr2: String;
  begin
    PosItem := Pos(';', CellStr);
    if (PosItem = 0) then
      Result := False
    else
      begin
        TmpStr1 := Copy(CellStr, 1, Pred(PosItem));
        // Yes so we need no amount or the dollar symbol and an assistance amount
        Result := (TmpStr1 = '') or ((TmpStr1 <> '') and (TmpStr1[1] = '$') and (StrToIntDef(Copy(TmpStr1, 2, Length(TmpStr1)), 0) > 0));
        if Result then
          begin
            TmpStr := Copy(CellStr, Succ(PosItem), Length(CellStr));
            PosItem := Pos(';', TmpStr);
            if (PosItem = 0) then
              Result := False
            else
              begin
                // There is a 2nd semicolon so we need to check for a comment & the unknown assistance
                TmpStr2 := Copy(TmpStr, 1, Pred(PosItem));
                Result := (((TmpStr1 <> '') and ((TmpStr2 = '') or (TmpStr2 = UADUnkFinAssistance))) or
                           ((TmpStr1 = '') and (TmpStr2 = UADUnkFinAssistance))) and
                           (Trim(Copy(TmpStr, Succ(PosItem), Length(TmpStr))) <> '');
              end;
          end;
      end;
  end;

  function XID2057NoTextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
    TmpStr: String;
  begin
    // False if there is no semi-colon or no comment text
    PosItem := Pos(';', CellStr);
    if (PosItem = 0) then
      Result := False
    else
      begin
        TmpStr := Copy(CellStr, 1, Pred(PosItem));
        // Yes so we need the dollar symbol and an assistance amount
        Result := ((TmpStr <> '') and (TmpStr[1] = '$') and (StrToIntDef(Copy(TmpStr, 2, Length(TmpStr)), 0) = 0));
        if Result then
          begin
            TmpStr := Copy(CellStr, Succ(PosItem), Length(CellStr));
            PosItem := Pos(';', TmpStr);
            if (PosItem = 0) then
              Result := False
            else
              Result := (Copy(TmpStr, 1, Pred(PosItem)) = '');
          end;
      end;
  end;

  function XID520TextOK(CellStr: String): Boolean;
  var
    PosItem: Integer;
    CellText, TmpStr: String;
  begin
    Result := (AnsiIndexStr(Copy(CellStr, 1, 2), ConditionListTypCode) >= 0) and (CellStr[3] = ';');
    if Result then
    begin
      CellText := Copy(CellStr, 4, Length(CellStr));
      PosItem := Pos(';', CellText);
      Result := (PosItem > 0);
      if Result then
      begin
        TmpStr := Copy(CellText, 1, Pred(PosItem));
        if TmpStr = NoUpd15Yrs then
          Result := (Trim(Copy(CellText, Succ(PosItem), Length(CellText))) <> '')  //we must have a comment
        else
        begin
          Result := (Copy(TmpStr, 1, Length(Kitchen)) = Kitchen);              //detected 'Kitchen-'
          if Result then
          begin
            CellText := Copy(CellText, Succ(Length(Kitchen)), Length(CellText));
            PosItem := Pos(';', CellText);
            Result := (PosItem > 1);
            if Result then
            begin
             TmpStr := Copy(CellText, 1, Pred(PosItem));
             CellText := Copy(CellText, Succ(PosItem), Length(CellText));      //text balance (Bathrooms...)
             Result := (GetImproveType(TmpStr) = 0);                        //see if it is 'not updated'
             if not Result then                                             //it is not so...
             begin
               //see if it has a dash, is 'updated' or 'remodeled' and has a valid timeframe
               PosItem := Pos('-', TmpStr);
               Result := ((PosItem > 1) and
                          (GetImproveType(Copy(TmpStr, 1, Pred(PosItem))) > -1) and
                          (GetImproveYrs(Copy(TmpStr, Succ(PosItem), Length(TmpStr))) > -1));
             end;
            end;
          end;                                                              //end detected 'Kitchen-' checks
          if Result then                                                    //begin detected 'Bathrooms-'
          begin
            Result := (Copy(CellText, 1, Length(Bathroom)) = Bathroom);
            if Result then
            begin
              CellText := Copy(CellText, Succ(Length(Bathroom)), Length(CellText));
              PosItem := Pos(';', CellText);
              //make sure we have a semi-colon and a comment
              Result := (PosItem > 1) and (Trim(Copy(CellText, Succ(PosItem), Length(CellText))) <> '');
              if Result then
              begin
                TmpStr := Copy(CellText, 1, Pred(PosItem));
                Result := (GetImproveType(TmpStr) = 0);                          //see if it is 'not updated'
                if not Result then                                               //it is not so...
                begin
                  //see if it has a dash, is 'updated' or 'remodeled' and has a valid timeframe
                  PosItem := Pos('-', TmpStr);
                  Result := ((PosItem > 1) and
                             (GetImproveType(Copy(TmpStr, 1, Pred(PosItem))) > -1) and
                             (GetImproveYrs(Copy(TmpStr, Succ(PosItem), Length(TmpStr))) > -1));
                end;
              end;
            end;
          end;                                                              //end detected 'Bathrooms-'
        end;
      end;
    end;
  end;

  function XID520DrByTextOK(CellStr: String): Boolean;
  begin
    Result := (AnsiIndexStr(Copy(CellStr, 1, 2), ConditionListTypCode) >= 0) and (CellStr[3] = ';');
    if Result then
      Result := (Copy(CellStr, 4, Length(CellStr)) <> '');
  end;

begin
  Result := True;
  if Doc.UADEnabled then
    case theCell.FCellXID of
      201:
        begin
          if (Trim(theCell.Text) <> '') then
            if not HasOnlyDigits(theCell.Text) then
              Result := False
            else
              begin
                AltCell1 := Doc.GetCellByXID(200);
                AltCell2 := Doc.GetCellByXID(1006);
                if (AltCell1 <> nil) and (AltCell2 <> nil) then
                  begin
                    // capture the total square footage
                    TmpInt := StrToIntDef(StringReplace(AltCell1.Text, ',', '', [rfReplaceAll]), 0);
                    if (TmpInt > 0) then
                      begin
                        // capture the current finished percentage
                        TmpInt2 := StrToIntDef(theCell.Text, 0);
                        if TmpInt2 > 0 then
                          begin
                            PosItem := Pos('sf', AltCell2.Text);
                            if PosItem > 0 then
                              begin
                                TmpStr := Copy(AltCell2.Text, (PosItem + 2), Length(AltCell2.Text));
                                PosItem := Pos('sf', TmpStr);
                                if PosItem > 0 then
                                  begin
                                    TmpInt4 := 0;
                                    TmpInt3 := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                                    if (TmpInt3 > 0) and (TmpInt > 0) then
                                      TmpInt4 := Round((TmpInt3 * 100) / TmpInt);
                                    // set a false result if the current & calculated %'s differ
                                    if TmpInt4 <> TmpInt2 then
                                      Result := False;
                                  end;
                              end;
                          end;
                      end;
                    AltCell1.HasValidationError := (not Result);
                    AltCell2.HasValidationError := (not Result);
                  end;
              end;
        end;

      // above grade bathroom counts
      231, 1043, 1049, 2238..2241, 2258..2261, 2337, 2341, 2345, 4004:
        begin
          TmpStr := Trim(theCell.Text);
          if Trim(TmpStr) <> '' then
            begin
              PosItem := Pos('.', TmpStr);
              // 062411 JWyatt Add check and assume all full baths if no period exists.
              if PosItem = 0 then
                Result := False
              else
                begin
                  TmpStr1 := Copy(TmpStr, 1, Pred(PosItem));
                  TmpInt := StrToIntDef(TmpStr1, -1);
                  Result := HasOnlyDigits(TmpStr1) and (TmpInt >= 0) and (TmpInt < 100);
                  if Result then
                    begin
                      TmpStr1 := Copy(TmpStr, Succ(PosItem), Length(TmpStr));
                      TmpInt1 := StrToIntDef(TmpStr1, -1);
                      Result := HasOnlyDigits(TmpStr1) and (TmpInt1 >= 0) and (TmpInt1 < 100);
                      // Set formatting to ensure that '1.1' does not show as '1.10'
                      if (Result) then
                        if (TmpInt1 < 9) then
                          begin
                            theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P2);    //clear round to 0.01
                            theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
                          end
                        else
                          begin
                            theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P1);    //clear round to 0.1
                            theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);    //round to 0.01
                          end;
                    end;
                end;
            end;
        end;

      // subject condition
      520:
        begin
          TmpStr := theCell.Text;
          if Trim(TmpStr) <> '' then
            begin
              IsDrByForm := ((theCell.UID.FormID = 347) or (theCell.UID.FormID = 355));
              if IsDrByForm then
                Result := XID520DrByTextOK(TmpStr)
              else
                Result := XID520TextOK(TmpStr);
              // False if there is no semi-colon or no comment in the PDF text
            end;
        end;

      //Action Reqd: Investigate why sequence 829 is not executed
      829:  // management agent name check
        begin
          if (Trim(theCell.Text) = 'X') then
            begin
              AltCell1 := Doc.GetCellByXID(830);
              if Trim(GetUADLinkedComments(Doc, AltCell1)) = '' then
                Result := False;
              AltCell1.HasValidationError := (not Result);
            end;
        end;
      830:  // management agent name check
        begin
          if (Trim(GetUADLinkedComments(Doc, theCell)) = '') then
            begin
              AltCell1 := Doc.GetCellByXID(829);
              if Trim(AltCell1.Text) = 'X' then
                Result := False;
              AltCell1.HasValidationError := (not Result);
            end;
        end;

      // Primary & secondary address cells - both must have text if one has text
      925, 926:
        begin
          if IsUnitAddrReq(Doc) then
            AltCell2 := GetUADUnitCell(Doc)
          else
            AltCell2 := nil;
          AltUID := theCell.UID;
          if theCell.FCellXID = 925 then
            begin
              AltUID.Num := Succ(AltUID.Num);
              AltCell1 := Doc.GetCell(AltUID);
              TmpStr := Trim(theCell.Text);
              TmpStr1 := Trim(AltCell1.Text);
            end
          else
            begin
              AltUID.Num := Pred(AltUID.Num);
              AltCell1 := Doc.GetCell(AltUID);
              TmpStr := Trim(AltCell1.Text);
              TmpStr1 := Trim(theCell.Text);
            end;
          Result := ((TmpStr = '') and (TmpStr1 = '')) or ((TmpStr <> '') and (TmpStr1 <> ''));
          if (TmpStr <> '') and Result then
            begin
              TmpStr := TmpStr1;
              PosItem := Pos(',', TmpStr);
              if PosItem > 0 then
                begin
                  if AltCell2 <> nil then
                    begin
                      UnitNo := Copy(TmpStr, 1, Pred(PosItem)); // temporary - this could be the city if no other comma
                      TmpStr1 := Copy(TmpStr, Succ(PosItem), Length(TmpStr));
                      PosItem1 := Pos(',', TmpStr1);
                      if (PosItem1 < 2) or (Trim(UnitNo) = '') then                      // we do not have a unit number
                        Result := False
                      else
                        TmpStr := TmpStr1;
                    end;
                  if Result then
                    begin
                      PosItem1 := Pos(',', TmpStr);
                      if PosItem1 = 0 then                      // we have a invalid unit number
                        Result := False
                      else
                        begin
                          TmpStr1 := Copy(TmpStr, Succ(PosItem1), Length(TmpStr));
                          PosItem1 := Pos(',', TmpStr1);
                          if (PosItem1 > 0) and not iscondoForm(AltCell1.UID.FormID) then  //github #823: check for confo form we have an unexpected comma (unit number)
                            Result := False
                          else
                            begin
                              City := ParseCityStateZip3(TmpStr, cmdGetCity);
                              State := ParseCityStateZip3(TmpStr, cmdGetState);
                              Zip   := ParseCityStateZip3(TmpStr, cmdGetZip);
                              Result := (City <> '') and (State <> '') and (Zip <> '') and (AnsiIndexText(State, USStateAbbrevs) > -1);
                            end;
                        end;
                    end;
                end
              else
                Result := False;
            end;
          AltCell1.HasValidationError := (not Result);
        end;

      956:
        begin
          if theCell.FContextID = 0 then // perform checks only for comps, not subject
            begin
              Incr := 2;
              UID := theCell.UID;
              UID.Num := UID.Num + Incr;
              AltCell1 := Doc.GetCell(UID);
              Result := ((theCell.Text = '') and (Trim(AltCell1.Text) = '')) or
                        ((theCell.Text <> '') and XID958TextOK(AltCell1.Text));
              AltCell1.HasValidationError := (not Result);
            end;
        end;
      958:
        begin
          if theCell.FContextID = 0 then // perform checks only for comps, not subject
            begin
              Incr := -2;
              UID := theCell.UID;
              UID.Num := UID.Num + Incr;
              AltCell1 := Doc.GetCell(UID);
              Result := ((theCell.Text = '') and (Trim(AltCell1.Text) = '')) or
                        ((Trim(AltCell1.Text) <> '') and XID958TextOK(theCell.Text));
              AltCell1.HasValidationError := (not Result);
            end;
        end;

      996:
        begin
          if (Length(theCell.Text) = 4) and (theCell.Text[1] <> '~') then
            Result := False;
        end;

      1006, 4006:
        begin
          if theCell.FContextID > 0 then
            Incr := 1
          else if theCell.UID.FormID = 4215 then
            Incr := 1  //Ticket #1119: no adjustment column
          else
            Incr := 2;
          UID := theCell.UID;
          UID.Num := UID.Num + Incr;
          AltCell1 := Doc.GetCell(UID);
          Result := BasementTextOK(theCell.Text, AltCell1.Text);
          AltCell1.HasValidationError := (not Result);
        end;
      1008, 4007:
        begin
          if theCell.FContextID > 0 then
            Incr := -1
          else if theCell.UID.FormID = 4215 then
            Incr := -1 //Ticket #1119 no adjustment 
          else
            Incr := -2;
          UID := theCell.UID;
          UID.Num := UID.Num + Incr;
          AltCell1 := Doc.GetCell(UID);
          Result := BasementTextOK(AltCell1.Text, theCell.Text);
          AltCell1.HasValidationError := (not Result);
        end;

      2048, 2049, 2057:  // financial assistance check boxes & comments
        begin
          AltCell1 := Doc.GetCellByXID(2048);
          AltCell2 := Doc.GetCellByXID(2049);
          if theCell.FCellXID = 2057 then
            FUADCell := theCell
          else
            FUADCell := Doc.GetCellByXID(2057);
            if (AltCell1 <> nil) and (AltCell2 <> nil) and (FUADCell <> nil)then
            begin
              TmpStr := GetUADLinkedComments(Doc, FUADCell);
              // False if both Yes or No checkboxes are checked
              if (Trim(AltCell1.Text) <> '') and (Trim(AltCell2.Text) <> '') then
                Result := False
              // if the Yes checkbox is checked
              else if (Trim(AltCell1.Text) <> '') then
                begin
                  if (Trim(TmpStr) = '') then
                    Result := False
                  else
                    begin
                      // False if there is no semi-colon or no comment text
                      Result := XID2057YesTextOK(TmpStr);
                      // False if there is no semi-colon or no comment in the PDF text
                      if Result and TTextCell(FUADCell).HasLinkedComments then
                        Result := XID2057YesTextOK(FUADCell.GetText);
                    end;
                end
              // if the No checkbox is checked
              else if (Trim(AltCell2.Text) <> '') then
                begin
                  if (Trim(TmpStr) = '') then
                    Result := False
                  else
                    begin
                      // False if there is no semi-colon or no comment text
                      Result := XID2057NoTextOK(TmpStr);
                      // False if there is no semi-colon or no comment in the PDF text
                      if Result and TTextCell(FUADCell).HasLinkedComments then
                        Result := XID2057NoTextOK(FUADCell.GetText);
                    end;
                end;
              AltCell1.HasValidationError := (not Result);
              AltCell2.HasValidationError := (not Result);
              FUADCell.HasValidationError := (not Result);
            end;
        end;

      2054, 2055, 2056:  // contract analysis comments
        begin
          AltCell1 := Doc.GetCellByXID(2054);
          AltCell2 := Doc.GetCellByXID(2055);
          if theCell.FCellXID = 2056 then
            FUADCell := theCell
          else
            FUADCell := Doc.GetCellByXID(2056);
            if (AltCell1 <> nil) and (AltCell2 <> nil) and (FUADCell <> nil)then
            begin
              TmpStr := GetUADLinkedComments(Doc, FUADCell);
              // False if both Yes or No checkboxes are checked
              if (Trim(AltCell1.Text) <> '') and (Trim(AltCell2.Text) <> '') then
                Result := False
              // False if the Yes or No checkbox is checked but there is no comment text
              else if (Trim(AltCell1.Text) <> '') or (Trim(AltCell2.Text) <> '') then
                if (Trim(TmpStr) = '') then
                  Result := False
                else
                  begin
                    // False if there is no semi-colon or no comment text
                    Result := XID2056TextOK(TmpStr);
                    // False if there is no semi-colon or no comment in the PDF text
                    if Result and TTextCell(FUADCell).HasLinkedComments then
                      Result := XID2056TextOK(FUADCell.GetText);
                  end;
              AltCell1.HasValidationError := (not Result);
              AltCell2.HasValidationError := (not Result);
              FUADCell.HasValidationError := (not Result);
            end;
        end;

      2119, 2120, 2116:  // commercial space
        begin
          AltCell1 := Doc.GetCellByXID(2119);
          AltCell2 := Doc.GetCellByXID(2120);
          if theCell.FCellXID = 2116 then
            FUADCell := theCell
          else
            FUADCell := Doc.GetCellByXID(2116);
          if (AltCell1 <> nil) and (AltCell2 <> nil) and (FUADCell <> nil) then
            begin
              TmpStr := GetUADLinkedComments(Doc, FUADCell);
              // False if both Yes or No checkboxes are checked
              if (Trim(AltCell1.Text) = '') and (Trim(AltCell2.Text) = '') then
                Result := (TmpStr = '')
              // False if both Yes or No checkboxes are checked
              else if (Trim(AltCell2.Text) <> '') then
                Result := (TmpStr = '')
              // False if the Yes or No checkbox is checked but there is no comment text
              else if (Trim(AltCell1.Text) <> '') then
                if (Length(TmpStr) < 3) then
                  Result := False
                else
                  begin
                    // False if there is no semi-colon or no comment text in PDF or overflow text
                    Result := XID2116TextOK(TmpStr);
                    // False if there is no semi-colon or no comment text in the PDF text
                    if Result and TTextCell(FUADCell).HasLinkedComments then
                      Result := XID2116TextOK(FUADCell.GetText);
                  end;
              AltCell1.HasValidationError := (not Result);
              AltCell2.HasValidationError := (not Result);
              FUADCell.HasValidationError := (not Result);
            end;
        end;

      2063, 2064, 2065:  // subject days on market, sources & prices
        begin
          AltCell1 := Doc.GetCellByXID(2063);
          AltCell2 := Doc.GetCellByXID(2064);
          if theCell.FCellXID = 2065 then
            FUADCell := theCell
          else
            FUADCell := Doc.GetCellByXID(2065);
          if (AltCell1 <> nil) and (AltCell2 <> nil) and (FUADCell <> nil)then
            begin
                TmpStr := GetUADLinkedComments(Doc, FUADCell);
                AltCell1Chkd := (Trim(AltCell1.Text) <> '');
                AltCell2Chkd := (Trim(AltCell2.Text) <> '');
                // False if both Yes or No checkboxes are checked
                if AltCell1Chkd and AltCell2Chkd then
                  Result := False
                // False if the Yes or No checkbox is checked but there is no comment text
                else if AltCell1Chkd or AltCell2Chkd then
                  if (Trim(TmpStr) = '') then
                    Result := False
                  else
                    begin
                      // False if there is no semi-colon & no DOM with Yes checked, True otherwise
                      PosItem := Pos(';', TmpStr);
                      if (PosItem = 0) then
                        Result := (not AltCell1Chkd)
                      else
                        // False if there is no DOM with Yes checked, True otherwise
                        begin
                          if AltCell1Chkd then
                            begin
                              Result := XID2065TextOK(Copy(TmpStr, 1, Pred(PosItem)));
                              // False if there is no DOM in the PDF text
                              if Result and TTextCell(FUADCell).HasLinkedComments then
                                begin
                                  TmpStr := FUADCell.GetText;
                                  PosItem := Pos(';', TmpStr);
                                  if (PosItem = 0) then
                                    Result := False
                                  else
                                    Result := XID2065TextOK(Copy(TmpStr, 1, Pred(PosItem))) and (Copy(TmpStr, Succ(PosItem), Length(TmpStr)) <> '');
                                end;
                            end;
                        end;
                    end;
                  end;
              AltCell1.HasValidationError := (not Result);
              AltCell2.HasValidationError := (not Result);
              FUADCell.HasValidationError := (not Result);
            end;
      end;

end;
function ConvertUAD_Cell90(theCell: TBaseCell; doc: TContainer):String;
var
  UADObject: TUADObject;
  aCellID : Integer;
  aCellTxt: String;
begin
  UADObject := TUADObject.Create(doc);
  try
    aCellID  := TheCell.FCellID;
    aCellTxt := TheCell.Text;
    result:= UADObject.TranslateToUADFormat(nil, aCellID, aCellTxt); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;

//cell: 148: stories, 157: det 2101: att 2102: bi 149: style 986: design on grid
function ConvertUAD_CellSubjectDesign(theCell: TBaseCell; doc: TContainer):String;
var
  UADObject: TUADObject;
  aCellID : Integer;
  aCellTxt: String;
  design, adt, astr: String;
  iStories: Integer;
begin
  UADObject := TUADObject.Create(doc);
  try
    aCellID  := TheCell.FCellID;
    aCellTxt := theCell.Text;
    design := doc.GetCellTextByID(986);
    case aCellID of //detach, attach, built in are flowing to the subject grid already, just the style and # stories
      148: begin  //we have # of stories
             if (length(design) > 0) and (length(aCellTxt) > 0) then //design on grid exists
               begin  //we need to replace the # of stories on the grid subject column
                 aDt := popStr(design, ';');
                 iStories := getValidInteger(aCellTxt);
                 aDt := copy(aDt, 1, 2);
                 aDt := Format('%s%d',[aDt,iStories]);
                 aStr := aDt+';'+design;
                 doc.SetCellTextByID(986, aStr);//replace # of stories in the design
               end;
           end;
      149: begin //style
             if (length(design) > 0) and (length(aCellTxt) > 0) then
               begin
                 if pos(aCellTxt, design) = 0 then  //style not match
                   begin //we need to replace
                     aDt := popStr(design, ';');
                     aStr := aDt + ';' + aCellTxt;
                     doc.SetCellTextByID(986, aStr); //replace style in the design grid
                   end;
               end;
           end;
    end;

    aCellTxt := TheCell.Text;
    result:= UADObject.TranslateToUADFormat(nil, aCellID, aCellTxt); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;


function ConvertUAD_Cell2056(theCell: TBaseCell; doc: TContainer):String;
var
  UADObject: TUADObject;
  aCellID : Integer;
  aCellTxt: String;
begin
  UADObject := TUADObject.Create(doc);
  try
    aCellID  := TheCell.FCellID;
    aCellTxt := TheCell.Text;
    result:= UADObject.TranslateUADCell2056(aCellTxt); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;

function ConvertUAD_Cell2057(theCell: TBaseCell; doc: TContainer):String;
var
  UADObject: TUADObject;
  aCellID : Integer;
  aCellTxt: String;
begin
  UADObject := TUADObject.Create(doc);
  try
    aCellID  := TheCell.FCellID;
    aCellTxt := TheCell.Text;
    result:= UADObject.TranslateUADCell2057(aCellTxt); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;


function ConvertUAD_Cell2065(theCell: TBaseCell; doc: TContainer):String;
var
  UADObject: TUADObject;
  aCellID : Integer;
  aCellTxt: String;
  aYes: Boolean;
begin
  UADObject := TUADObject.Create(doc);
  try
    aCellID  := TheCell.FCellID;
    aCellTxt := TheCell.Text;
    aYes := compareText('X', doc.GetCellTextByID(2063)) = 0;
    result:= UADObject.TranslateUADCell2065(aCellTxt, aYes); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;

function IsUADCellTextValid(theCell: TBaseCell; Doc: TContainer): Boolean;
const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;
var
  IntVal1, IntVal2, PosItem, Mo, Yr: Integer;
  TmpStr, TmpStr2: String;
  TmpDbl: Double;
  iGA, iGD, iGBI, iCP, iDW: Integer; // residential car storage --> attached, detached, built-in, carport & driveway quantities
  iG, iCV, iOP: Integer; // condo car storage --> garage, covered, open quantities
  UADCell, UADAltCell: TBaseCell;
  TextBaseCell: TTextBaseCell;
  XID: Integer;
  CellText: String;
  IsUAD: Boolean;
begin
  Result := True;
  XID := theCell.FCellXID;
  CellText := theCell.Text;
  IsUAD := Doc.UADEnabled;
  if IsUAD and (Trim(CellText) <> '') and (IsUADCellActive(XID)) then
    case XID of
      // state abbreviations
      48, 2760, 3972: Result := (AnsiIndexStr(CellText, USStateAbbrevs) >= 0);

      // zip code formatting
      49, 2761, 3973:
        begin
          if Length(CellText) = 5 then
            Result := HasOnlyDigits(CellText)
          else if (Length(CellText) = 10) and (CellText[6] = '-') then
            Result := HasOnlyDigits(Copy(CellText, 7, 4))
          else
            Result := False;
        end;

      // grid data source(s) - comparables only
      930:
        begin
          PosItem := Pos(';DOM ', CellText);
          if (PosItem > 1) and (Trim(Copy(CellText, 1, Pred(PosItem))) <> '') then
            begin
              TmpStr := Copy(CellText, (PosItem + 5), Length(CellText));
              Result := ((TmpStr = 'Unk') or HasOnlyDigits(TmpStr));
            end
          else
            Result := False;
        end;

      // sales or financing concessions type
      956: Result := (AnsiIndexStr(CellText, SalesTypesDisplay) >= 0);

      // sales or financing concessions description and amount
      958:
        begin
          PosItem := Pos(';', CellText);
          if (PosItem > 1) and (Trim(Copy(CellText, 1, Pred(PosItem))) <> '') then
            begin
              TmpStr := Copy(CellText, Succ(PosItem), Length(CellText));
              Result := HasOnlyDigits(TmpStr);
            end
          else
            Result := False;
        end;
      // grid date of sale - comparables only
      960:
        begin
          PosItem := AnsiIndexStr(CellText[1], DOSTypes);
          if PosItem < 0 then
            PosItem := AnsiIndexStr(CellText, DOSTypes);
          case PosItem of
            0:
              begin
                // test for "smo/yr"
                Result := ((Length(CellText) = 10) or (Length(CellText) = 13));
                if Result then
                  begin
                    Result := (Copy(CellText, 4, 1) = '/') and (Copy(CellText, 7, 1) = ';');
                    if Result then
                      begin
                        Mo := StrToIntDef(Copy(CellText, 2, 2), 0);
                        Yr := StrToIntDef(Copy(CellText, 5, 2), -1);
                        Result := ((Yr >= 0) and ((Mo > 0) and (Mo < 13)));
                      end;
                    if Result and (Length(CellText) = 13) then
                      begin
                        Mo := StrToIntDef(Copy(CellText, 9, 2), 0);
                        Yr := StrToIntDef(Copy(CellText, 12, 2), -1);
                        Result := ((CellText[8] = 'c') and (Yr >= 0) and ((Mo > 0) and (Mo < 13)));
                      end;
                    if Result and (Length(CellText) = 10) then
                      Result := (Copy(CellText, 8, Length(CellText)) = 'Unk');
                  end;
              end;
            1: Result := True;
            2:
              begin
                // test for "cmo/yr"
                Result := (Length(CellText) = 6);
                if Result then
                  begin
                    Mo := StrToIntDef(Copy(CellText, 2, 2), 0);
                    Yr := StrToIntDef(Copy(CellText, 5, 2), -1);
                    Result := ((Yr >= 0) and ((Mo > 0) and (Mo < 13)));
                  end;
              end;
            3, 4:
              begin
                // test for "emo/yr" or "wmo/yr"
                Result := (Length(CellText) = 6);
                if Result then
                  begin
                    Mo := StrToIntDef(Copy(CellText, 2, 2), 0);
                    Yr := StrToIntDef(Copy(CellText, 5, 2), 0);
                    Result := ((Yr > 0) and ((Mo > 0) and (Mo < 13)));
                  end;
              end;
          else
            Result := False;
          end;
        end;

      // grid location
      962:
        begin
          if Length(CellText) <= 2 then
            Result := False
          else
            begin
              Result := (CellText[2] = ';') and (AnsiIndexStr(CellText[1], InfluenceDisplay) >= 0);
              if Result then
                begin
                  TmpStr := Copy(CellText, 3, Length(CellText));
                  Result := (Length(TmpStr) > 0);
                  if Result then
                    begin
                      // We have some factor text so fail if we have more than one semicolon
                      //  or the last character is a semicolon
                      PosItem := Pos(';', TmpStr);
                      if PosItem = 0 then
                        Result := False
                      else
                        if Pos(';', Copy(TmpStr, Succ(PosItem), Length(TmpStr))) > 0 then
                          Result := False
                        else
                          Result := (TmpStr[1] <> ';');
                    end;
                end;
            end;
        end;

      // site area
      86, 67, 976, 3996:
        begin
          PosItem := Pos(cSqFt, CellText);
          if PosItem > 0 then
            begin
              IntVal1 := StrToIntDef(Trim(Copy(CellText, 1, Pred(PosItem))), 0);
              Result := (IntVal1 >= 0) and (IntVal1 < cAcre)and (Copy(CellText, PosItem + Length(cSqFt), Length(CellText)) = '');
            end
          else
            begin
              PosItem := Pos(cAcres, CellText);
              if PosItem > 0 then
                begin
                  IntVal1 := Trunc(GetValidNumber(Trim(Copy(CellText, 1, Pred(PosItem)))));
                  Result := (IntVal1 >= 1) and (Copy(CellText, PosItem + Length(cAcres), Length(CellText)) = '');
                end
              else
                Result := False;
            end;
        end;

      // site view
      90, 984:
        begin
          if Length(CellText) <= 2 then
            Result := False
          else
            begin
              Result := (CellText[2] = ';') and (AnsiIndexStr(CellText[1], InfluenceDisplay) >= 0);
              if Result then
                begin
                  TmpStr := Copy(CellText, 3, Length(CellText));
                  Result := (Length(TmpStr) > 0);
                  if Result then
                    begin
                      // We have some factor text so fail if we have more than one semicolon
                      //  or the last character is a semicolon
                      PosItem := Pos(';', TmpStr);
                      if PosItem = 0 then
                        Result := False
                      else
                        if Pos(';', Copy(TmpStr, Succ(PosItem), Length(TmpStr))) > 0 then
                          Result := False
                        else
                          Result := (TmpStr[1] <> ';');
                    end;
                end;
            end;
        end;

      986, 1808, 3998:
        try
          PosItem := Pos(';', CellText);
          if PosItem < 0 then
            Result := False
          else
            begin
              TmpStr := Copy(CellText, 1, Pred(PosItem));
              if Doc.GetCellByXID(966) <> nil then   //Cell XID 966 only on 1073 & 1075 families
                begin
                  Result := (Copy(TmpStr, Length(TmpStr), 1) = 'L');
                  if Result then
                    begin
                      TmpStr := Copy(tmpStr, 1, Pred(Length(TmpStr)));
                      if Copy(TmpStr, 1, 1) = 'O' then
                        TmpStr := Copy(TmpStr, 2, Length(TmpStr))
                      else
                        begin
                          PosItem := AnsiIndexText(Copy(TmpStr, 1, 2), CondoAttachType);
                          if PosItem < 0 then
                            Result := False
                          else
                            begin
                              TmpStr := Copy(TmpStr, 3, Length(TmpStr));
                              Result := (IsValidNumber(TmpStr, TmpDbl) and (Pos('.', TmpStr) = 0));
                            end;
                        end;
                    end;
                end
              else
                begin
                  PosItem := AnsiIndexText(Copy(TmpStr, 1, 2), ResidAttachType);
                  if PosItem < 0 then
                    Result := False
                  else
                    begin
                      TmpStr := Copy(TmpStr, 3, Length(TmpStr));
                      Result := IsValidNumber(TmpStr, TmpDbl);
                    end;
                end;
            end;
        except
          Result := False;
        end;

      // subject or comparable grid quality of construction
      994, 3999: Result := (AnsiIndexStr(CellText, QualityListTypCode) >= 0);

      // property year built and grid age
      151, 996, 1809, 2247:
        begin
          if CellText[1] = EstFlag then
            begin
              TmpStr := Copy(CellText, 2, Length(CellText));
              Result := HasOnlyDigits(TmpStr);
            end
          else
            Result := HasOnlyDigits(CellText);
        end;

      // subject or comparable grid condition
      998, 2248, 4001:
        begin
          if (CellText <> '') then
            begin
              if AnsiIndexText(CellText, ConditionListTypCode) < 0 then
                Result := False
              else
                Result := True;
            end;
        end;

      // basement sq footage, finished sq footage & access
      1006:
        begin
          if CellText <> '0sf' then
            begin
              TmpStr := CellText;
              PosItem := Pos('sf', TmpStr);
              if PosItem > 1 then
                Result := HasOnlyDigits(Copy(TmpStr, 1, Pred(PosItem)))
              else
                Result := False;
              if Result then
                begin
                  IntVal1 := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                  TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
                  // We have total sq footage so fail if we no finished sq footage, even zero
                  PosItem := Pos('sf', TmpStr);
                  if PosItem > 1 then
                    Result := HasOnlyDigits(Copy(TmpStr, 1, Pred(PosItem)))
                  else
                    Result := False;
                end;
              if Result then
                begin
                  // We have total & finished sq footage so fail if finished > total
                  IntVal2 := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                  Result := (IntVal1 >= IntVal2) and (IntVal1 > 0) and (IntVal1 < 100000) and (IntVal2 < 100000);
                end;
              if Result then
                begin
                  TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
                  // We have total & finished sq footage so fail if we an invalid or no access
                  PosItem := AnsiIndexStr(TmpStr, BsmtAccessDisplay);
                  Result := (PosItem >= 0);
                end
            end;
        end;

      // basement room counts
      1008:
        begin
          TmpStr := CellText;
          PosItem := Pos('rr', TmpStr);
          if PosItem > 1 then
            begin
              TmpStr2 := Copy(TmpStr, 1, Pred(PosItem));
              Result := HasOnlyDigits(TmpStr2) and (Length(TmpStr2) = 1);
            end
          else
            Result := False;
          if Result then
            begin
              TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
              PosItem := Pos('br', TmpStr);
              if PosItem > 1 then
                begin
                  TmpStr2 := Copy(TmpStr, 1, Pred(PosItem));
                  Result := HasOnlyDigits(TmpStr2) and (Length(TmpStr2) = 1);
                end
              else
                Result := False;
            end;
          if Result then
            begin
              TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
              PosItem := Pos('ba', TmpStr);
              if PosItem = 4 then
                Result := HasOnlyDigits(TmpStr[1]) and (TmpStr[2] = '.') and HasOnlyDigits(TmpStr[3])
              else
                Result := False;
            end;
          if Result then
            begin
              TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
              if TmpStr <> '' then
                Result := HasOnlyDigits(TmpStr[1]) and (TmpStr[2] = 'o') and (Length(TmpStr) = 2);
            end;
        end;

      1016, 1816, 4010: // car storage grid cells
        begin
         if (doc.docActiveCell.UID.FormID = 340) or (doc.docActiveCell.UID.FormID = 355) or
            (doc.docActiveCell.UID.FormID = 363) or (doc.docActiveCell.UID.FormID = 3545) or
            (doc.docActiveCell.UID.FormID = 4218) or (doc.docActiveCell.UID.FormID = 4365) then
             Result := CarStorageResidTextOK(CellText, iGA, iGD, iGBI, iCP, iDW)
           else
             if (doc.docActiveCell.UID.FormID = 345) or (doc.docActiveCell.UID.FormID = 347) or
                (doc.docActiveCell.UID.FormID = 888) or (doc.docActiveCell.UID.FormID = 367) then
               Result := CarStorageCondoTextOK(CellText, iG, iCV, iOP);
        end;

      // above grade total room and bedroom counts
      229, 1041, 1047, 2230..2233, 2250..2253, 2335, 2339, 2343, 4002,
      230, 1042, 1048, 2234..2237, 2254..2257, 2336, 2340, 2344, 4003:
        begin
          IntVal1 := StrToIntDef(CellText, 0);
          Result := HasOnlyDigits(CellText) and (IntVal1 >= 0) and (IntVal1 < 100);
        end;

      // above grade bathroom counts
      231, 1043, 1049, 2238..2241, 2258..2261, 2337, 2341, 2345, 4004:
        begin
          PosItem := Pos('.', CellText);
          // 062411 JWyatt Add check and assume all full baths if no period exists.
          if PosItem = 0 then
            Result := False
          else
            begin
              TmpStr := Copy(CellText, 1, Pred(PosItem));
              IntVal1 := StrToIntDef(TmpStr, 0);
              Result := HasOnlyDigits(TmpStr) and (IntVal1 >= 0) and (IntVal1 < 100);
              if Result then
                begin
                  TmpStr := Copy(CellText, Succ(PosItem), Length(CellText));
                  IntVal1 := StrToIntDef(TmpStr, 0);
                  Result := HasOnlyDigits(TmpStr) and (IntVal1 >= 0) and (IntVal1 < 100);
                end;
            end;
        end;

      // estimated year built indicator
      4415: Result := (Copy(CellText, 1, 1) = EstFlag);

      // estimated age indicator
      4425: Result := (Copy(CellText, 1, 1) = EstFlag);
    end;
end;

function UADDateFormatErr(CellXID: Integer; theFmt: String; var theDate: String): Boolean;
var
  Yr, Mo, Dy: Integer;
begin
  // 062711 JWyatt Change length check for less than 11 characters instead of 10 and
  //  revised sequence for cell 2013 to capture all errors. Use the ParseDateStr
  //  function to ensure that dates are valid before applying FormatDateTime.
  if (Length(theDate) > 10) then
    Result := True
  else if (CellXID = 2013) then
    begin
      if (Length(theDate) = 4) then
        Result := False
      else if (Length(theDate) = 5) then
        Result := True
      else if ParseDateStr(theDate, Mo, Dy, Yr) then
        begin
          Result := False;
          if (Length(theDate) > 7) then
            theDate := FormatDateTime(theFmt, EncodeDate(Yr, Mo, Dy));
        end
        else
          Result := True;
    end
  else
    begin
      if ParseDateStr(theDate, Mo, Dy, Yr) then
        // 101311 JWyatt Add try..except construct to prevent debugger firing
        //  if the user enters an invalid date such as 9/31/2011
        try
          theDate := FormatDateTime(theFmt, EncodeDate(Yr, Mo, Dy));
          Result := False;
        except
          Result := True;
        end
      else
        Result := True;
    end;
end;

function HasOnlyDecDigits(NumStr: String): boolean;
var
  i:  integer;
  OK: boolean;
begin
  OK := false;
  for i := 1 to length(NumStr) do
  begin
    OK := (NumStr[i] in ['0'..'9','.']);
    if not OK then
      break;
  end;
  Result := OK;
end;

function GetOnlyDigits(NumStr: String): String;
var
  i:  integer;
begin
  Result := '';
  for i := 1 to length(NumStr) do
  begin
    if (NumStr[i] in ['0'..'9']) then
      Result := Result + NumStr[i];
  end;
end;

function GetOnlyWholeNumber(NumStr: String): String;
var
  PerPos:  integer;
begin
  Result := NumStr;
  PerPos := Pos('.', NumStr);
  if PerPos > 0 then
    Result := Copy(NumStr, 1, Pred(PerPos));
end;

function PositiveAmtKey(Key: Char): Char;
begin
  if not (Key in [#08,'0'..'9',',']) then
    Result := #0
  else
    Result := Key;
end;

//replaced by PositiveNumKey
function GetNumKey(Key: Char): Char;
begin
  if not (Key in [#08,'-','0'..'9',',']) then
    Result := #0
  else
    Result := Key;
end;

function PositiveRealNumKey(Key: Char): Char;
begin
  if not (Key in [#08,'0'..'9',',','.']) then
    Result := #0
  else
    Result := Key;
end;

function PositiveNumKey(Key: Char): Char;
begin
  if not (Key in [#08,'0'..'9']) then
    Result := #0
  else
    Result := Key;
end;

function GetAlphaKey(Key: Char): Char;
begin
  if not (Key in [#08,'a'..'z','A'..'Z']) then
    result := #0
  else
    result := Key;
end;

function FormatPrice(InAmt: String): String;
var
  Cntr: Integer;
  theAmt: String;
begin
  if Trim(InAmt) = '' then
    Result := '$0'
  else
    begin
      theAmt := '';
      for Cntr := 1 to Length(InAmt) do
        if InAmt[Cntr] in ['0'..'9'] then
          theAmt := theAmt + InAmt[Cntr];
      if theAmt <> '' then
        Result := Format('%-9.0m', [StrToFloat(theAmt)])
      else
        Result := '$0';
    end;
end;

function PadTailWithSpaces(StrToPad: String; totalLen: Integer): String;
var
  i,n: Integer;
begin
  result := StrToPad;
  n := length(result);
  if n < totalLen then
    for i := n+1 to totalLen do
      result := result + ' ';
end;

function FormMoYr(InMoYr: String): String;
begin
  if Trim(InMoYr) <> '' then
    Result := Format('%2.2d', [StrToInt(Trim(InMoYr))]);
end;

function StripBegEndQuotes(theText: String): String;
var
  Str: String;
begin
  Result := theText;
  if Trim(theText) <> '' then
    begin
      Str := Trim(theText);
      if (Str[1] = '"') and (Str[Length(Str)] = '"') then
        Result := Copy(Str, 2, (Length(Str) - 2));
    end;
end;

procedure SetUADCellFmt(Editor: TEditor; theCell: TBaseCell);
var
  FFormat, FPrefs: Integer;
  OrigTxt: String;
  IsZeroFmtSet: Boolean;

  function IsDecimalFmt(FFormat: Integer): Boolean;
  begin
    Result := (IsBitSet(FFormat,bRnd1P1) or IsBitSet(FFormat,bRnd1P2) or
               IsBitSet(FFormat,bRnd1P3) or IsBitSet(FFormat,bRnd1P4) or
               IsBitSet(FFormat,bRnd1P5));
  end;

  function ClearNumberFormat(FFormat: Integer): Integer;
  var
    CellFmt: Integer;
  begin
    CellFmt := FFormat;
    //clear previous rounding bits - all of them
    CellFmt := ClrBit(CellFmt, bRnd1000);
    CellFmt := ClrBit(CellFmt, bRnd500);
    CellFmt := ClrBit(CellFmt, bRnd100);
    CellFmt := ClrBit(CellFmt, bRnd5);
    CellFmt := ClrBit(CellFmt, bRnd1);
    CellFmt := ClrBit(CellFmt, bRnd1P1);
    CellFmt := ClrBit(CellFmt, bRnd1P2);
    CellFmt := ClrBit(CellFmt, bRnd1P3);
    CellFmt := ClrBit(CellFmt, bRnd1P4);
    CellFmt := ClrBit(CellFmt, bRnd1P5);
    Result := CellFmt;
  end;

begin
  if not (Editor is TGraphicEditor) then
    begin
      FFormat := Editor.FCellFormat;
      IsZeroFmtSet := IsBitSet(FFormat, bDisplayZero);
      FPrefs := Editor.FCellPrefs;
      //Editor.FModified := False;
      // 060311 JWyatt Capture the original text so we can restore it after editor
      //  formatting and preference changes
      OrigTxt := Trim(theCell.Text);
      if (Editor.ClassName = 'TPositiveWholeNumericSLEditor') or
         (Editor.ClassName = 'TPositiveWholeTenThousandsNumericGridEditor') or
         (Editor.ClassName = 'TWholeNumericSLEditor') then
        begin
          // 060211 JWyatt Force the sub-type to ensure that the SetFormat call will
          //  respect these settings. If the sub-type is cKindTx it will not.
          theCell.FSubType := cKindCalc;
          if IsDecimalFmt(FFormat) then
            begin
              FFormat := ClearNumberFormat(FFormat);
              FFormat := SetBit(FFormat, bRnd1);
            end;
          FFormat := SetBit2Flag(FFormat, bDisplayZero, IsZeroFmtSet);
          if theCell.FCellXID = 367 then
            FFormat := SetBit2Flag(FFormat, bAddComma, False);
          FFormat := SetBit2Flag(FFormat, bAddPlus, False);
          FPrefs := SetBit2Flag(FPrefs, bCelNumOnly, True);
          FPrefs := SetBit2Flag(FPrefs, bCelFormat, True);
          Editor.FModified := True;
        end
      else if (Editor.ClassName = 'TWholeNumericGridEditor') then
        begin
          if IsDecimalFmt(FFormat) then
            begin
              FFormat := ClearNumberFormat(FFormat);
              FFormat := SetBit(FFormat, bRnd1);
            end;
          FFormat := SetBit2Flag(FFormat, bDisplayZero, IsZeroFmtSet);
          FPrefs := SetBit2Flag(FPrefs, bCelNumOnly, True);
          FPrefs := SetBit2Flag(FPrefs, bCelFormat, True);
          Editor.FModified := True;
        end
      else if (Editor.ClassName = 'TPositiveDollarsNumericSLEditor') or
              (Editor.ClassName = 'TDollarsNumericSLEditor') then
        begin
          // 060211 JWyatt Force the sub-type to ensure that the SetFormat call will
          //  respect these settings. If the sub-type is cKindTx it will not.
          theCell.FSubType := cKindCalc;
          FFormat := ClearNumberFormat(FFormat);
          FFormat := SetBit(FFormat, bRnd1P2);
          FFormat := SetBit2Flag(FFormat, bDisplayZero, IsZeroFmtSet);
          FFormat := SetBit2Flag(FFormat, bAddPlus, False);
          Editor.FModified := True;
        end
      else if (Editor.ClassName = 'TDollarsNumericGridEditor') then
        begin
          FFormat := ClearNumberFormat(FFormat);
          FFormat := SetBit(FFormat, bRnd1P2);
          FFormat := SetBit2Flag(FFormat, bDisplayZero, IsZeroFmtSet);
          Editor.FModified := True;
        end
      else if (Editor.ClassName = 'TDateSLEditor') or
              (Editor.ClassName = 'TDateGridEditor') then
        begin
          FFormat := SetBit2Flag(FFormat, bDisplayZero, IsZeroFmtSet);
          FPrefs := SetBit2Flag(FPrefs, bCelDateOnly, True);
          Editor.FModified := True;
        end
      else if (Editor.ClassName = 'TNumericGridEditor') then
        begin
          FPrefs := SetBit2Flag(FPrefs, bCelFormat, True);
          FPrefs := SetBit2Flag(FPrefs, bCelNumOnly, True);
          Editor.FModified := True;
        end;

      if Editor.FModified then
        begin
          // UAD Dates are always mm/dd/yyyy
          FFormat := SetBit2Flag(FFormat, bDateMY, False);
          FFormat := SetBit2Flag(FFormat, bDateMDY, False);
          FFormat := SetBit2Flag(FFormat, bDateMD4Y, True);
          FFormat := SetBit2Flag(FFormat, bDateShort, False);
          FFormat := SetBit2Flag(FFormat, bDateLong, False);
          Editor.SetFormat(FFormat);
          Editor.SetPreferences(FPrefs);
          Editor.SaveChanges;
          // 060311 JWyatt Restore the original text to counter any TxStr changes
          // 062811 JWyatt Remove the plus symbol or the text will be rejected if
          //  formatting does not require this symbol.
          if not IsBitSet(FFormat, bAddPlus) then
            OrigTxt := StringReplace(OrigTxt, '+', '', [rfReplaceAll]);
          theCell.SetText(OrigTxt);
        end;
    end;
end;

procedure ProcessPriorSaleCells(doc: TContainer; theCell: TBaseCell; IsUAD: Boolean=False);
var
  n, CompID, UIDIdx: Integer;
  CompIDStr: String;
  DateText: String;
  FromCellUID: CellUID;
  FromCell: TBaseCell;
begin
  if (theCell is TGridCell) then
   doc.docActiveCellChged := True;
  if (Trim(theCell.Text) <> '') then
    case theCell.FCellXID of
      9001..9004:
        begin
          // Conform to UAD Appendix D, Price of Prior Sale/Transfer Page 31
          if (Pos('=', theCell.Text) = 0) then
            begin
              if (doc As TContainer).UADEnabled and (TheCell.FCellXID = 9002) and (Pos('$', theCell.Text) = 0) then
                theCell.SetText('$' + theCell.Text);
              theCell.Display;
            end
          else
            begin
              n := POS('=', theCell.Text);
              CompIDStr := Copy(theCell.Text, n+1, Length(theCell.Text)-n);
              if (CompIDStr = '') or (CompareText(UpperCase(CompIDStr), 'S')= 0) then
                compID := 0
              else
                IsValidInteger(compIDStr, compID);

              if (CompID > -1) and (CompID < 4) then
                begin
                  UIDIdx := -1;
                  FromCellUID := TheCell.UID;
                  FromCellUID.Num := -1;
                  case TheCell.UID.FormID of
                    345:  // FNMA1073
                      case TheCell.UID.Num of
                        103..106: UIDIdx := 1;
                        107..110: UIDIdx := 2;
                        111..114: UIDIdx := 3;
                        115..118: UIDIdx := 4;
                      end;
                    347: // FNMA1075
                      case TheCell.UID.Num of
                        106..109: UIDIdx := 1;
                        110..113: UIDIdx := 2;
                        114..117: UIDIdx := 3;
                        118..121: UIDIdx := 4;
                      end;
                    349:  // FNMA1025
                      case TheCell.UID.Num of
                        213..216: UIDIdx := 1;
                        217..220: UIDIdx := 2;
                        221..224: UIDIdx := 3;
                        225..228: UIDIdx := 4;
                      end;
                    360:  // FNMA2000A
                      case TheCell.UID.Num of
                        23..26:   UIDIdx := 2;
                        27..30:   UIDIdx := 3;
                        31..35:   UIDIdx := 4;
                      end;
                  end;
                  case UIDIdx of
                    1:
                      if CompID > 0 then
                        FromCellUID.Num := theCell.UID.Num + (CompID * 4);
                    2:
                      if CompID < 1 then
                        FromCellUID.Num := theCell.UID.Num - 4
                      else if CompID > 1 then
                        FromCellUID.Num := theCell.UID.Num + ((CompID - 1) * 4);
                    3:
                      if CompID < 2 then
                        FromCellUID.Num := theCell.UID.Num - ((2 - CompID) * 4)
                      else if CompID > 2 then
                        FromCellUID.Num := theCell.UID.Num + 4;
                    4:
                      if CompID < 3 then
                        FromCellUID.Num := theCell.UID.Num - ((3 - CompID) * 4);
                  end;
                  if FromCellUID.Num > -1 then
                    begin
                      FromCell := doc.GetCell(FromCellUID);
                      if FromCell <> nil then
                        begin
                          theCell.SetText(FromCell.Text);
                          if ((theCell.FCellXID = 9001) or (theCell.FCellXID = 9004)) and (doc As TContainer).UADEnabled then
                            begin
                              DateText := theCell.Text;
                              TheCell.HasValidationError := UADDateFormatErr(theCell.FCellXID, CUADDateFormat, DateText);
                              theCell.Text := DateText;
                            end;
                          theCell.Display;
                          theCell.PostProcess;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

procedure ProcessSpecialCells(doc: TContainer; theCell: TBaseCell; IsUAD: Boolean=False);
var
  Incr, PosItem, TmpInt, TmpInt2, TmpInt3, TmpInt4: Integer;
  UID: CellUID;
  AltCell1, AltCell2: TBaseCell;
  TmpStr, TmpStr2: String;
begin
  if (Trim(theCell.Text) <> '') and IsUAD then
  case theCell.FCellXID of
    201:
      begin
        if (Trim(theCell.Text) <> '') then
          if HasOnlyDigits(theCell.Text) then
            begin
              AltCell1 := Doc.GetCellByXID(200);
              AltCell2 := Doc.GetCellByXID(1006);
              if (AltCell1 <> nil) and (AltCell2 <> nil) then
                begin
                  // capture the total square footage
                  TmpInt := StrToIntDef(StringReplace(AltCell1.Text, ',', '', [rfReplaceAll]), 0);
                  if (TmpInt > 0) then
                    begin
                      // capture the current finished percentage
                      TmpInt2 := StrToIntDef(theCell.Text, 0);
                      if TmpInt2 > 0 then
                        begin
                          TmpInt3 := 0;
                          TmpInt4 := 0;
                          PosItem := Pos('sf', AltCell2.Text);
                          if PosItem > 0 then
                            begin
                              TmpStr := Copy(AltCell2.Text, (PosItem + 2), Length(AltCell2.Text));
                              PosItem := Pos('sf', TmpStr);
                              if PosItem > 0 then
                                TmpInt3 := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                              if (TmpInt3 > 0) and (TmpInt > 0) then
                                TmpInt4 := Round((TmpInt3 * 100) / TmpInt);
                            end;
                          // set the new grid values if the current & calculated %'s differ
                          if TmpInt4 <> TmpInt2 then
                            begin
                              // calculate the finished square footage
                              TmpStr := IntToStr(Trunc(TmpInt * (TmpInt2 / 100)));
                              // form the basement area cell text
                              TmpStr := IntToStr(TmpInt) + 'sf' + TmpStr + 'sf';
                            end
                          else
                            // use existing grid values when current & calculated %'s do not differ
                            TmpStr := IntToStr(TmpInt) + 'sf' + IntToStr(TmpInt3) + 'sf';
                          AltCell1 := Doc.GetCellByXID(208);
                          if (AltCell1 is TChkBoxCell) and (Trim((AltCell1 as TChkBoxCell).Text) = '') then
                            AltCell2.Text := TmpStr + 'in'
                          else
                            begin
                              TmpStr2 := Copy(AltCell2.Text, Pred(Length(AltCell2.Text)), 2);
                              if AnsiIndexStr(TmpStr2, BsmtAccessDisplay) >= 0 then
                                AltCell2.Text := TmpStr + TmpStr2;
                            end;
                          AltCell2.Display;
                        end;
                    end;
                end;
            end;
      end;
    1006, 4006:
      begin
        if theCell.FContextID > 0 then
          Incr := 1
        else
          Incr := 2;
        UID := theCell.UID;
        UID.Num := UID.Num + Incr;
        if theCell.FContextID > 0 then
          begin
            AltCell1 := Doc.GetCellByXID(200);
            if AltCell1 <> nil then
              begin
                TmpStr := theCell.Text;
                PosItem := Pos('sf', TmpStr);
                if PosItem > 1 then
                  begin
                    TmpInt := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                    AltCell1.Text := IntToStr(TmpInt);
                    AltCell1 := Doc.GetCellByXID(201);
                    if AltCell1 <> nil then
                      begin
                        TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
                        PosItem := Pos('sf', TmpStr);
                        if PosItem > 1 then
                          begin
                            TmpInt2 := StrToIntDef(Copy(TmpStr, 1, Pred(PosItem)), 0);
                            if (TmpInt2 > 0) and (TmpInt > 0) then
                              begin
                                TmpInt3 := Round((TmpInt2 * 100) / TmpInt);
                                AltCell1.Text := IntToStr(TmpInt3);
                              end;
                            AltCell1 := Doc.GetCellByXID(208);
                            if AltCell1 <> nil then
                              begin
                                TmpStr := Copy(TmpStr, (PosItem + 2), Length(TmpStr));
                                PosItem := AnsiIndexStr(TmpStr, BsmtAccessDisplay);
                                if (PosItem = 0) or (PosItem = 1) then
                                  AltCell1.Text := 'X'
                                else
                                  AltCell1.Text := ' ';
                              end;
                          end;
                      end;
                  end;
              end;
          end;
      end;
  end;
end;

function StripUADSubjCond(BodyText: String; IsUAD: Boolean=False): String;
// This function strips the condition and kitchen and bathroom status from
//  the body of overflow text. It returns just the comment portion.
var
  PosItem: Integer;
  CellText, TmpStr: String;
begin
  Result := BodyText;
  if (Length(Trim(BodyText)) > 2) and IsUAD then
   begin
    if (AnsiIndexStr(Copy(BodyText, 1, 2), ConditionListTypCode) >= 0) and (BodyText[3] = ';') then
     CellText := Copy(BodyText, 4, Length(BodyText))
    else
     CellText := BodyText;
    PosItem := Pos(';', CellText);
    if (PosItem > 0) then
     begin
      TmpStr := Copy(CellText, 1, Pred(PosItem));
      if TmpStr = NoUpd15Yrs then
       Result := Trim(Copy(CellText, Succ(PosItem), Length(CellText)))  //capture the comment
      else
       begin
        if (Copy(TmpStr, 1, Length(Kitchen)) = Kitchen) then            //detected 'Kitchen-'
         begin
          CellText := Copy(CellText, Succ(PosItem), Length(CellText));
          PosItem := Pos(';', CellText);
          if (PosItem > 1) then
           begin
            TmpStr := Copy(CellText, 1, Pred(PosItem));
            if (Copy(TmpStr, 1, Length(Bathroom)) = Bathroom) then      //detected 'Bathrooms-'
             Result := Copy(CellText, Succ(PosItem), Length(CellText))  //comment balance
            else
             Result := CellText; // no "Bathrooms-" so assume text remainder is comments
           end;
         end
        else
         Result := CellText; // no "Kitchen-" so assume text remainder is comments
       end;
     end
    else
     Result := CellText;  // no ";" after removing "C#;" condition code
   end;
end;

procedure ProcessGroupCellAdjs(doc: TContainer; UID: CellUID; IsUAD: Boolean=False);
var
  FromCell: TGridCell;

  procedure ProcessAltCell(Offset: Integer);
  var
    AltUID: CellUID;
    AltCell: TGridCell;
  begin
    AltUID := UID;
    AltUID.Num := UID.Num + Offset;
    AltCell := TGridCell(doc.GetCell(AltUID));
    if (AltCell <> nil) then
      AltCell.PostProcess;
  end;

begin
  if IsUAD then
    try
      FromCell := TGridCell(doc.GetCell(UID));
      if (FromCell <> nil) then
        case FromCell.FCellXID of
          1006, 4006:
            begin
              if FromCell.FContextID > 0 then  // Only the subject column has context IDs
                ProcessAltCell(1)
              else
                ProcessAltCell(2);
            end;
          1008, 4007:
            begin
              if FromCell.FContextID > 0 then  // Only the subject column has context IDs
                ProcessAltCell(-1)
              else
                ProcessAltCell(-2);
            end;
          1041, 4002:
            begin
              ProcessAltCell(1);
              ProcessAltCell(2);
            end;
          1042, 4003:
            begin
              ProcessAltCell(-1);
              ProcessAltCell(1);
            end;
          1043, 4004:
            begin
              ProcessAltCell(-1);
              ProcessAltCell(-2);
            end;
        end;
    finally
    end;
end;

//### - this does not determine if user is licensed.
function UserUADLicensed(UADIsOK: Boolean): Boolean;
begin
  if ((AppEvalUsageLeft > 0) or UADIsOK) then
    Result := True
  else
    Result := False;
end;

// Determine if the form should have UAD dialogs. This can apply to forms such as extra comps,
//   extra listings, etc. that are not strictly defined as UAD by the GSE (see below).
function IsUADForm(ID: Integer): Boolean;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := False;
  repeat
    Cntr := Succ(Cntr);
    if ID = UADForms[Cntr] then
      Result := True;
  until Result or (Cntr = MaxUADForms);
end;

// Determine if this is a UAD form defined by the GSE. As of 12/12/2012 only 8 forms are defined.
function IsGSEUADForm(ID: Integer): Boolean;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := False;
  repeat
    Cntr := Succ(Cntr);
    if ID = GSEUADForms[Cntr] then
      Result := True;
  until Result or (Cntr = MaxGSEUADForms);
end;

// Determine if this is a UAD form name defined by the GSE. As of 12/12/2012 only 8 forms are defined.
function IsGSEUADFormName(FormName: String): Boolean;
begin
  Result := (AnsiIndexText(FormName, GSEUADFormNames) > -1);
end;

function IsUADWorksheet(theCell: TBaseCell): Boolean;
var
  KindID: Integer;
begin
  KindID := (theCell.ParentPage.ParentForm as TDocForm).frmInfo.fFormKindID;
  Result := ((KindID = fkWorksheetUAD) or (KindID = fkWorksheetCVR) or (KindID = fkWorkflow));
end;

//implemented to temporarily turn off UAD for Car Storage and Design
function IsUADCellActive(XID: Integer): Boolean;
begin
  case XID of
    //XIDs for the Car Storage cells
    92,345, 346, 349, 355, 359, 360, 363, 413, 414, 2000, 2030, 2070..2072, 2657, 3591, 1016, 1816, 4010:
      result := appPref_UADCarNDesignActive or (date >= StrToDate(CUADCarAndDesignEffDate));

    //XIDs for the Design cells
    148, 149, 157, 380..385, 986, 1808, 2101, 2102, 2109, 2458, 3998:
      result := appPref_UADCarNDesignActive or (date >= StrToDate(CUADCarAndDesignEffDate));
  else
    result := True;
  end;
end;

function IsUADMasterForm(ID: Integer): Boolean;
var
  Cntr: Integer;
begin
  Cntr := -1;
  Result := False;
  repeat
    Cntr := Succ(Cntr);
    if ID = UADMstrForms[Cntr] then
      Result := True;
  until Result or (Cntr = MaxUADMstrForms);
end;

function HasUADForm(doc: TContainer): Boolean;
var
  n: Integer;
begin
  n := -1;
  result := False;
  repeat
    inc(n);
    result := result or (doc.GetFormIndex(UADForms[n]) > -1);
  until result or (n = MaxUADForms);
end;

function IsExtOnlyReport(doc: TContainer): Boolean;
var
  n: Integer;
begin
  n := -1;
  result := False;
  repeat
    inc(n);
    result := result or (doc.GetFormIndex(UADExtForms[n]) > -1);
  until result or (n = MaxUADExtForms);
end;

function IsOKToEnableUAD: Boolean;
var
  DialogResult: TModalResult;
begin
  DialogResult := WhichOption12('Yes', 'No', 'Would you like to enable the UAD Compliance Rules for this report?');
  result := (DialogResult = mrYes);
end;

//used when bringing in property address from Fidelity
procedure ResetSubjAddr(Doc: TContainer);
var
  Cntr: Integer;
  AddrCell: TBaseCell;
begin
  if Doc.UADEnabled then
    for Cntr := 0 to MaxAddrXID do
      begin
        AddrCell := Doc.GetCellByID(SubjAddrCells[Cntr]);
        if AddrCell <> nil then
          Doc.LoadCellMunger(SubjMungeID[Cntr], AddrCell.GetText);
      end;
end;

//called when comp addresses come in from Bing & Fidelity
procedure SetCompMapAddr(CompCell: TGeocodedGridCell; Addr, UnitNo, City, State, Zip: String);
begin
  CompCell.GSEData := '';
  if Addr <> '' then
    CompCell.GSEData := '"' + CompAddrCells[0] + '=' + Addr + '"';
  if UnitNo <> '' then
    CompCell.GSEData := CompCell.GSEData + ',"' + CompAddrCells[1] + '=' + UnitNo + '"';
  if City <> '' then
    CompCell.GSEData := CompCell.GSEData + ',"' + CompAddrCells[2] + '=' + City + '"';
  if State <> '' then
    CompCell.GSEData := CompCell.GSEData + ',"' + CompAddrCells[3] + '=' + State + '"';
  if Zip <> '' then
    CompCell.GSEData := CompCell.GSEData + ',"' + CompAddrCells[4] + '=' + Zip + '"';
end;

// 100911 JWyatt Used by TBaseCell.ConfigurationChanged to prevent attribute setting
//  changes to the EditorClass when the cell is on a non-UAD and is contextually linked.
function IsUADCell(theCell: TBaseCell): Boolean;
var
  Cntr: Integer;
begin
  Result := True;
  if (not IsUADForm((theCell.ParentPage.ParentForm as TDocForm).FormID)) then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        result := (theCell.FCellXID = UADCellXID[Cntr]);
      until Result or (Cntr = MaxUADCellXID);
      if not Result then
        begin
          Cntr := -1;
          repeat
            Cntr := Succ(Cntr);
            result := ((theCell.FCellXID = UADGridXID[Cntr]) and (theCell.FContextID > 0));
          until Result or (Cntr = MaxUADGridXID);
        end;
    end;
end;

// Determine if a unit number cell exists on the primary form
function GetUADUnitCell(doc: TContainer): TBaseCell;
var
  Cntr: Integer;
  IsPriForm: Boolean;
begin
  Result := nil;
  if doc.UADEnabled and (doc.FormCount > 0) then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        IsPriForm := IsPrimaryAppraisalForm(doc.docForm[Cntr].frmInfo.fFormUID);
        if IsPriForm then
          result := doc.docForm[Cntr].GetCellByXID_MISMO(2141);
      until IsPriForm or (Cntr = Pred(doc.FormCount));
    end;
end;

// 101411 JWyatt Used by TCompMgr2.SetCellIDTextToComp to prevent text & GSE data from
//  being saved into UAD restricted subject cells. 
function IsUADRestrictCell(doc:TContainer; AComp: TCompColumn; CID: String): Boolean;
var
  Cntr: Integer;
begin
  Result := False;
  if Doc.UADEnabled and (AComp.FCompID = 0) then
    begin
      Cntr := -1;
      repeat
        Cntr := Succ(Cntr);
        result := (CID = UADRestrictCID[Cntr]);
      until Result or (Cntr = MaxUADRestrictCID);
    end;
end;

//used in Editor to not allow responses and to not double the responses
function IsUADRspCell(CellClassName: String): Boolean;
begin
  Result := False;
  if (Trim(CellClassName) <> '') then
    if (CellClassName = 'TPositiveWholeNumericSLEditor') or
       (CellClassName = 'TPositiveWholeTenThousandsNumericGridEditor') or
       (CellClassName = 'TWholeNumericSLEditor') or
       (CellClassName = 'TWholeNumericGridEditor') or
       (CellClassName = 'TPositiveDollarsNumericSLEditor') or
       (CellClassName = 'TDollarsNumericSLEditor') or
       (CellClassName = 'TDollarsNumericGridEditor') or
       (CellClassName = 'TNumericGridEditor') then
      Result := True;
end;

//Used in UDocView.ViewMouseDown and UContainer.MoveToNextCell to display a dialog even if
function IsUADAutoDlgCell(doc:TContainer): Boolean;
var
  Cntr: Integer;
  DoChk: Boolean;
begin
  Result := False;
  if doc.docActiveCell <> nil then
    begin
      case doc.docActiveCell.FCellXID of
        //Design-Style
        148,149,157,380,381,382,383,384,385,986,1808,2101,2102,2109,2458,3998:
          DoChk := (not appPref_UADStyleNoAutoDlg);
      else
        //Car storage
        DoChk := (not appPref_UADGarageNoAutoDlg);
      end;
      if doc.UADEnabled and (doc.docActiveCell.FCellXID > 0) and DoChk then
        begin
          Cntr := -1;
          repeat
            Cntr := Succ(Cntr);
            result := (doc.docActiveCell.FCellXID = UADAutoDlgXID[Cntr]);
          until Result or (Cntr = MaxUADAutoDlgXID);
        end;
    end;
end;

{=====================================================================================}

//Subject Condition XML Pts
function GetGSEXMLDataGroup0520(GrpID: String; GSEGroups: TStringList; ExtOnly: Boolean=False): String;
var
  DataPt, NewGroup: TStringList;
  Idx, Idx1, Idx2: Integer;
  ImprovOK: Boolean;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.values['4400'] := DataPt.Values['4400'];     //condition rating
    NewGroup.Values['520'] := DataPt.Values['520'];       //improvement comments

    ImprovOK := True;

    Idx1 := -1;
    Idx2 := -1;
    if DataPt.Values['4401'] = 'X' then                   //property has not been updated in 15 years
      NewGroup.Values['4401'] := 'N'
    else if not ExtOnly then
      begin

        //kitchen updated
        Idx1 := AnsiIndexText(DataPt.values['4404'], ImprovementListTypRsp);     //was kitchen updated?
        if Idx1 > -1 then
          begin
            ImprovOK := True;
            NewGroup.Values['4404'] := ImprovementListTypXML[Idx1];              //set XML update tag
            if (Idx1 > 0) then
              begin
                Idx1 := AnsiIndexText(Lowercase(StringReplace(DataPt.values['4406'], ' ', '', [rfReplaceAll])), ImprovementListYrsRsp);  //when
                if Idx1 > -1 then
                  NewGroup.values['4406'] := ImprovementListYrsXML[Idx1]         //set XML when tag
                else
                  ImprovOK := False;
              end;
          end
        else
          ImprovOK := False;

        //bathroom updated
        Idx2 := AnsiIndexText(DataPt.values['4405'], ImprovementListTypRsp);     //was bathroom updated?
        if Idx2 > -1 then
          begin
            NewGroup.Values['4405'] := ImprovementListTypXML[Idx2];              //set XML update tag
            if (Idx2 > 0) then
              begin
                Idx2 := AnsiIndexText(Lowercase(StringReplace(DataPt.values['4407'], ' ', '', [rfReplaceAll])), ImprovementListYrsRsp);  //when
                if Idx2 > -1 then
                  NewGroup.values['4407'] := ImprovementListYrsXML[Idx2]         //set XML when tag
                else
                  ImprovOK := False;
              end;
          end
        else
          ImprovOK := False;

      end;

    Idx := AnsiIndexText(DataPt.values['4400'], ConditionListTypCode);

    // if one of the cells is not blank then check for a missing item or error
    if not ((Trim(DataPt.Values['4401']) = '') and
            (Trim(DataPt.Values['520']) = '') and
            (Trim(DataPt.values['4400']) = '') and
            (Idx < 0) and
            (Idx1 < 0) and
            (Idx2 < 0)) then
      begin
        if (DataPt.Values['4401'] = 'X') and
           ((Trim(DataPt.Values['520']) = '') or (Idx < 0)) then
          NewGroup.values['Valid'] := 'N'
        else
          if (DataPt.Values['4401'] <> 'X') and
             ((Trim(DataPt.Values['520']) = '') or
              ((Trim(DataPt.values['4400']) <> '') and (Idx < 0))) or
             (not ImprovOK) then
            NewGroup.values['Valid'] := 'N'
        else
          NewGroup.values['Valid'] := 'Y';
      end;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Subject Grid Construction Quality XML Pts
function GetGSEXMLDataGroup0994(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.values['4517'] := DataPt.Values['4517'];     //quality rating
    if Length(Trim(DataPt.Values['4517'])) <> 0 then
      if AnsiIndexText(DataPt.values['4517'], QualityListTypCode) < 0 then
        NewGroup.values['Valid'] := 'N'
      else
        NewGroup.values['Valid'] := 'Y';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Subject Grid Condition XML Pts
function GetGSEXMLDataGroup0998(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.values['4518'] := DataPt.Values['4400'];     //condition rating
    if Length(Trim(DataPt.Values['4400'])) <> 0 then
      if AnsiIndexText(DataPt.values['4400'], ConditionListTypCode) < 0 then
        NewGroup.values['Valid'] := 'N'
      else
        NewGroup.values['Valid'] := 'Y';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Year Built XML Pts
function GetGSEXMLDataGroup0151(doc: TContainer; GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.Values['151'] := DataPt.Values['151'];       //year built
    NewGroup.Values['996'] := DataPt.Values['2659'];      //(YearOf(Today) - GetValidInteger(DataPt.Values['151']));  //age

    if DataPt.Values['4425'] = 'X' then
      begin
        NewGroup.Values['4415'] := 'Y';                    //year is estimated
        NewGroup.Values['4425'] := 'Y';
      end
    else
      begin
        NewGroup.Values['4415'] := 'N';                     //year is not estimated
        NewGroup.Values['4425'] := 'N';
      end;
      
    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Basement room counts XML Pts  (MAYBE MAKE 2 GROUP TO STORE IN MULTIPLE PLACES)
function GetGSEXMLDataGroup1006(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  FBath, HBath: String;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.Values['Valid'] := 'Y';

    NewGroup.Values['4426'] := IntToStr(GetValidInteger(DataPt.Values['4426']));      //basement area

    NewGroup.Values['200'] := IntToStr(GetValidInteger(DataPt.Values['4426']));       //basement area (twice - may be bug in dialog)

    NewGroup.Values['201'] := IntToStr(GetValidInteger(DataPt.Values['201']));        //basement finished percent (strip %)

    NewGroup.Values['4427'] := IntToStr(GetValidInteger(DataPt.Values['4427']));      //basement finished area

    // Finished sq ft cannot exceed total sq ft
    if GetValidInteger(DataPt.Values['4426']) < GetValidInteger(DataPt.Values['4427']) then
      NewGroup.Values['Valid'] := 'N';

    // No room data points if the basement is unfinished  
    if GetValidInteger(DataPt.Values['4427']) > 0 then
      begin
        NewGroup.Values['4428'] := IntToStr(GetValidInteger(DataPt.Values['4428']));      //RecRoom count

        NewGroup.Values['4429'] := IntToStr(GetValidInteger(DataPt.Values['4429']));      //Bedroom count

        NewGroup.Values['4520'] := IntToStr(GetValidInteger(DataPt.Values['4520']));      //Other Room count

        FBath := IntToStr(GetValidInteger(DataPt.Values['44301']));                       //Full baths
        if FBath = '' then FBath := '0';

        HBath := IntToStr(GetValidInteger(DataPt.Values['44302']));                       //Half baths
        if HBath = '' then HBath := '0';

        NewGroup.Values['4430'] := FBath + '.' + HBath;       //concatenate
      end;

    if DataPt.Values['45191'] = 'X' then
      NewGroup.Values['4519'] := BsmtAccessListXML[0]     //walkout
    else if DataPt.Values['45192'] = 'X' then
      NewGroup.Values['4519'] := BsmtAccessListXML[1]     //walkup
    else if DataPt.Values['45193'] = 'X' then
      NewGroup.Values['4519'] := BsmtAccessListXML[2]     //interiorOnly
    else if GetValidInteger(DataPt.Values['4426']) > 0 then
      NewGroup.Values['Valid'] := 'N';                    //basement exists but user did not check a box 

    if (DataPt.Values['45191'] = 'X') or (DataPt.Values['45192'] = 'X') then  //outside entry
      NewGroup.Values['208'] := 'Y'
    else
      NewGroup.Values['208'] := 'N';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Room Count XML Pts
function GetGSEXMLDataGroup0229(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  FBath, HBath: String;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.Values['1041'] := IntToStr(GetValidInteger(DataPt.Values['229']));      //total rooms

    NewGroup.Values['1042'] := IntToStr(GetValidInteger(DataPt.Values['230']));      //total bedrooms

    FBath := IntToStr(GetValidInteger(DataPt.Values['2311']));                       //Full baths
    if FBath = '' then FBath := '0';

    HBath := IntToStr(GetValidInteger(DataPt.Values['2312']));                       //Half baths
    if HBath = '' then HBath := '0';

    NewGroup.Values['1043'] := FBath + '.' + HBath;       //concatenate

    if (GetValidInteger(DataPt.Values['229']) >= GetValidInteger(DataPt.Values['230'])) then
      NewGroup.Values['Valid'] := 'Y'
    else
      NewGroup.Values['Valid'] := 'N';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Site Area XML Pts
function GetGSEXMLDataGroup0067(GrpID: String; GSEGroups: TStringList; IsGrid: Boolean=False): String;
var
  DataPt, NewGRoup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    if GetValidInteger(DataPt.Values['67']) > 0 then                  //we have an area
      begin
        NewGroup.Values['Valid'] := 'Y';
        If DataPt.Values['1721'] = 'X' then                 //area value is sqft
//          NewGroup.Values['67'] :=  DataPt.Values['67'] + ' sf'
          NewGroup.Values['67'] := Trim(Format('%-20.0n', [GetValidNumber(DataPt.Values['67'])])) + ' sf'

        else if DataPt.Values['1722'] = 'X' then            //the area is acerage
//          NewGroup.Values['67'] :=  DataPt.Values['67'] + ' ac'
          NewGroup.Values['67'] := Trim(Format('%-20.2n', [GetValidNumber(DataPt.Values['67'])])) + ' ac'

        else
          NewGroup.Values['Valid'] := 'N';
      end
    else
      NewGroup.Values['67'] :=  ' ';

    if IsGrid then
      begin
        NewGroup.Values['976'] := NewGroup.Values['67'];
        NewGroup.Values['67'] :=  '';
      end;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Location Influence XML Pts
function GetGSEXMLDataGroup0962(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  idx: Integer;
  Factor1ID, Factor2ID: Integer;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  Factor1ID := -1;
  Factor2ID := -1;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    //get first Location factor
    idx := AnsiIndexText(DataPt.values['4420'], LocListRsp);   //which response was selected
    if idx > -1 then
      begin
        if (idx = MaxLocFactors) then                         //other was selected
          begin
            NewGroup.Values['4420'] := LocListXML[idx];
            Factor1ID := -2;
            if Trim(DataPt.Values['45151']) <> '' then
              begin
                NewGroup.Values['4515'] := DataPt.Values['45151'];
                Factor1ID := idx;
              end;
          end
        else  //std factor was selected
          begin
            NewGroup.Values['4420'] := LocListXML[idx];
            Factor1ID := idx;
          end;
      end;

    //get second Location factor
    idx := AnsiIndexText(DataPt.values['4421'], LocListRsp);   //which response was selected
    if idx > -1 then
      begin
        if (idx = MaxLocFactors) then                         //other was selected
          begin
            NewGroup.Values['4421'] := LocListXML[idx];
            Factor2ID := -2;
            if Trim(DataPt.Values['45152']) <> '' then
              begin
                if length(NewGroup.Values['4515']) > 0 then
                  NewGroup.Values['4515'] := NewGroup.Values['4515'] + ';' + DataPt.Values['45152']
                else
                  NewGroup.Values['4515'] := DataPt.Values['45152'];
                Factor2ID := idx;
              end;
          end
        else  //std factor was selected
          begin
            NewGroup.Values['4421'] := LocListXML[idx];
            Factor2ID := idx;
          end;
      end;

    //get influence
    NewGroup.Values['4419'] := DataPt.Values['4419'];

    if not ((Trim(DataPt.Values['4419']) = '') and ((Factor1ID = -1) and (Factor2ID = -1))) then
      begin
        Idx := AnsiIndexText(DataPt.values['4419'], InfluenceList);     //verify location type
        if (Idx >= 0) then
          begin
            if ((Factor1ID = -1) and (Factor2ID = -1)) or               //location ok but no factors
               ((Factor1ID = -2) or (Factor2ID = -2)) then              //location ok but bad factor
              NewGroup.Values['Valid'] := 'N'
            else
              NewGroup.Values['Valid'] := 'Y';
          end
        else
          NewGroup.Values['Valid'] := 'N'
      end;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//View Influence
function GetGSEXMLDataGroup0090(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  idx: Integer;
  Factor1ID, Factor2ID: Integer;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  Factor1ID := -1;
  Factor2ID := -1;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];                //now we can get to the individual pts in the group

    //get first view factor
    idx := AnsiIndexText(DataPt.values['4413'], ViewListRsp);   //which response was selected
    if idx > -1 then
      begin
        if (idx = MaxViewFeatures) then                         //other was selected
          begin
            NewGroup.Values['4413'] := ViewListXML[idx];
            Factor1ID := -2;
            if Trim(DataPt.Values['45131']) <> '' then
              begin
                NewGroup.Values['4513'] := DataPt.Values['45131'];
                Factor1ID := idx;
              end;
          end
        else  //std factor was selected
          begin
            NewGroup.Values['4413'] := ViewListXML[idx];
            Factor1ID := idx;
          end;
      end;

    //get second view factor
    idx := AnsiIndexText(DataPt.values['4414'], ViewListRsp);   //which response was selected
    if idx > -1 then
      begin
        if (idx = MaxViewFeatures) then                         //other was selected
          begin
            NewGroup.Values['4414'] := ViewListXML[idx];
            Factor2ID := -2;
            if Trim(DataPt.Values['45132']) <> '' then
              begin
                if length(NewGroup.Values['4513']) > 0 then
                  NewGroup.Values['4513'] := NewGroup.Values['4513'] + ';' + DataPt.Values['45132']
                else
                  NewGroup.Values['4513'] := DataPt.Values['45132'];
                Factor2ID := idx;
              end;
          end
        else  //std factor was selected
          begin
            NewGroup.Values['4414'] := ViewListXML[idx];
            Factor2ID := idx;
          end;
      end;

    //get influence
    NewGroup.Values['4412'] := DataPt.Values['4412'];

    if not ((Trim(DataPt.Values['4412']) = '') and ((Factor1ID = -1) and (Factor2ID = -1))) then
      begin
        Idx := AnsiIndexText(DataPt.values['4412'], InfluenceList);     //verify influence type
        if (Idx >= 0) then
          begin
            if ((Factor1ID = -1) and (Factor2ID = -1)) or               //influence ok but no factors
               ((Factor1ID = -2) or (Factor2ID = -2)) then              //influence ok but bad factor
              NewGroup.Values['Valid'] := 'N'
            else
              NewGroup.Values['Valid'] := 'Y';
          end
        else
          NewGroup.Values['Valid'] := 'N'
      end;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.free;
  end;
end;

//Contract analysis Financial Assistance XML Pts
function GetGSEXMLDataGroup2057(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup:= TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    //Assistance Comment
    NewGroup.values['2057'] := DataPt.values['2057'];

    NewGroup.Values['2048'] := ' ';
    NewGroup.Values['2049'] := ' ';
    //if there was assistance
    if DataPt.values['2048'] = 'X' then
      begin
        //Yes - assistance
        NewGroup.values['2048'] := 'X';

        if Trim(NewGroup.values['2057']) = '' then
          NewGroup.values['Valid'] := 'N';

      end
    else if DataPt.values['2049'] = 'X' then   //if No Assistance checked
      begin
        NewGroup.values['2049'] := 'X';
        if GetValidInteger(DataPt.values['4410']) > 0 then
          NewGroup.values['Valid'] := 'N';
      end;

    //Assistance Amount
    NewGroup.values['4410'] := DataPt.values['4410'];

    //Unknown Assist. Amount
    if DataPt.values['4411'] = 'X' then
      NewGroup.values['4411'] := 'Y';

    if (NewGroup.values['4411'] = 'N') and (Trim(NewGroup.values['4410']) = '') then
      NewGroup.values['Valid'] := 'N';

    if (NewGroup.values['Valid'] <> 'N') and ((DataPt.values['2048'] = 'X') or (DataPt.values['2049'] = 'X')) then
      NewGroup.values['Valid'] := 'Y';
      
    result := NewGroup.CommaText;
  finally
    DataPt.free;
  end;
end;

//listing history XML points
function GetGSEXMLDataGroup2065(GrpID: String; GSEGroups: TStringList): String;
const
  PriceRow: array[0..2] of String = ('92','94','96');
  DateRow: array[0..2] of String = ('91','93','95');
var
  DataPt: TStringList;
  NewGroup: TStringList;
  i, count: Integer;
  hasPrice: Boolean;
  OrigPriceDate: TDateTime;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    NewGroup.Values['2063'] := ' ';
    NewGroup.Values['2064'] := ' ';
    if DataPt.Values['2063'] = 'X' then                   //captured the Yes
      begin
        NewGroup.Values['2063'] := 'X';
        NewGroup.Values['2064'] := ' ';
        NewGroup.Values['Valid'] := 'Y';
        if length(DataPt.Values['4408']) > 0 then
          begin
            NewGroup.Values['4408'] := DataPt.Values['4408'];    //get the DOM
            if (Length(GetFirstNumInStr(DataPt.Values['4408'], True, i)) = 0) and
               (Uppercase(DataPt.Values['4408']) <> 'UNK') then
              NewGroup.Values['Valid'] := 'N';
          end;

        If DataPt.Values['2'] = 'X' then
          NewGroup.Values['2065-2'] := DataPt.Values['2'];     //Get the FSBO checkbox

        if length(DataPt.values['7']) > 0 then                 //we have original list price
          begin
            NewGroup.Values['2065-7'] := DataPt.Values['7'];
            if (Length(GetFirstNumInStr(DataPt.Values['7'], True, i)) = 0) then
              NewGroup.Values['Valid'] := 'N';
          end
        else
          NewGroup.Values['Valid'] := 'N';

        if length(DataPt.values['8']) > 0 then                 //we have original list price
          begin
            NewGroup.Values['2065-8'] := DataPt.Values['8'];
            if not IsValidDate(DataPt.Values['8'], OrigPriceDate, True) then
              NewGroup.Values['Valid'] := 'N';
          end
        else
          NewGroup.Values['Valid'] := 'N';

        //get count of intermediate and last pricing changes
        count := -1;
        repeat
          hasPrice := length(DataPt.values[PriceRow[count+1]]) > 0;
          if hasPrice then
            inc(count);
        until (not hasPrice) or (count = 2);

        if Count > -1 then    //set the last price change & intermediate points
          begin
            NewGroup.Values['2065-0'] := DataPt.Values[PriceRow[count]];
            NewGroup.Values['2065-1'] := DataPt.Values[DateRow[count]];

            //set the intermediate points
            for i := 0 to count-1 do
              NewGroup.Values['2065-9-'+IntTostr(i)] := DataPt.Values[DateRow[i]] + ' ' + DataPt.Values[PriceRow[i]];
          end;
      end
    else if DataPt.values['2064'] = 'X' then
      begin
        NewGroup.Values['2064'] := 'X';
        NewGroup.Values['Valid'] := 'Y';
      end;

    if (NewGroup.Values['2063'] = 'X') or (NewGroup.Values['2064'] = 'X') then
       //get the MLS Source
      if (length(DataPt.Values['101']) > 0) or (length(DataPt.Values['102']) > 0) then
        NewGroup.Values['2065-10-0'] := Trim(DataPt.Values['102'] + ' ' + DataPt.Values['101'])
      else
        NewGroup.Values['Valid'] := 'N';

    NewGroup.Values['2065'] := 'comment';  //GetSalesDescriptionText

    result := NewGroup.CommaText;
  finally
    DataPt.free;
  end;
end;

//Contract Analysis sale type XML pts
function GetGSEXMLDataGroup2056(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  Idx: Integer;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];          //now we can get to the individual pts in the group

    //capture the checkboxes
    if DataPt.values['2054'] = 'X' then
      NewGroup.values['2054'] := 'X'
    else
      NewGroup.values['2054'] := ' ';

    if DataPt.values['2055'] = 'X' then
      NewGroup.values['2055'] := 'X'
    else
      NewGroup.values['2055'] := ' ';

    //capture the sales type
    Idx := AnsiIndexText(DataPt.values['4409'], SalesTypesRsp);
    if Idx > -1 then
      NewGroup.values['4409'] := SalesTypesXML[Idx];

    //capture the comment
    if Trim(DataPt.values['2056']) <> '' then
      NewGroup.Values['2056'] := DataPt.values['2056']
    else
      NewGroup.values['2056'] := ' ';

    if not (((Trim(NewGroup.values['2054']) = '') and (Trim(NewGroup.values['2055']) = '')) and
            ((Trim(NewGroup.values['2056']) = '') and (Idx < 0))) then
      if ((NewGroup.values['2054'] = '') and (NewGroup.values['2055'] = '')) or
         ((Trim(NewGroup.values['2056']) = '') or (Idx < 0)) then
        NewGroup.values['Valid'] := 'N';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//Property Address XML points
function GetGSEXMLDataGroup0046(GrpID: String; GSEGroups: TStringList): String;
begin
  result := GSEGroups.Values[GrpID];    //for property we don't any translation
end;

{========================================================================}

//Property Address Display Pts
function GetGSEDisplayGroup0046(GrpID: String; GSEGroups: TStringList): String;
begin
  result := GSEGroups.Values[GrpID];  //transfer as is
end;

//contract-sales type
function GetGSEDisplayGroup2056(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  Idx: Integer;
  DisplayStr: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    if DataPt.Values['2054'] = 'X' then
      NewGroup.Values['2054'] :=  'X'
    else
      if DataPt.Values['2055'] = 'X' then
        NewGroup.Values['2055'] := 'X';

    DisplayStr := '';
    Idx := AnsiIndexText(DataPt.values['4409'], SalesTypesXML);     //get sale type
    if Idx > -1 then
      begin
        DisplayStr := SalesTypesTxt[Idx];
        NewGroup.values['2056'] := DisplayStr + ';' + DataPt.values['2056'];   //display sale & comment
      end
    else
      NewGroup.values['2056'] := DataPt.values['2056'];                 //just display comment

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//contract financial assiatance
function GetGSEDisplayGroup2057(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  AssistanceAmountText: String;
  UnknownAssistanceText: String;
  DisplayStr: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    if DataPt.values['2048'] = 'X' then
      begin
        NewGroup.values['2048'] := 'X';
      end
    else if DataPt.values['2049'] = 'X' then
      NewGroup.values['2049'] := 'X';

    AssistanceAmountText := Trim(DataPt.Values['4410']);
    if (AssistanceAmountText <> '') then
      AssistanceAmountText := '$' + StringReplace(AssistanceAmountText, ',', '', [rfReplaceAll]);

    if (DataPt.values['4411'] = 'Y') then
      UnknownAssistanceText := UADUnkFinAssistance
    else
      UnknownAssistanceText := '';

    if (Trim(AssistanceAmountText) <> '') or
       (Trim(UnknownAssistanceText) <> '') or
       (Trim(DataPt.values['2057']) <> '') then
      DisplayStr := Format('%s;%s;%s', [AssistanceAmountText, UnknownAssistanceText, DataPt.values['2057']])
    else
      DisplayStr := ' ';
    NewGroup.values['2057'] := DisplayStr;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//view influence
function GetGSEDisplayGroup0090(GrpID: String; GSEGroups: TStringList; IsGrid: Boolean=False): String;
var
  DataPt, NewGroup: TStringList;
  Idx, Idx1, Idx2: Integer;
  displayStr, factor1, factor2: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    //get influence type
    displayStr := ' ';
    Idx := AnsiIndexText(DataPt.values['4412'], InfluenceList);     //get influence type
    if Idx > -1 then
      displayStr := InfluenceDisplay[Idx];

    //first influence factor
    factor1 := '';
    Idx1 := AnsiIndexText(DataPt.values['4413'], ViewListXML);
    if Idx1 > -1 then
      begin
        factor1 := ViewListDisplay[Idx1];
        if (compareText(factor1, 'Other')= 0) then
          factor1 := DataPt.values['4513'];
      end;

    //second influence factor
    factor2 := '';
    Idx2 := AnsiIndexText(DataPt.values['4414'], ViewListXML);
    if Idx2 > -1 then
      begin
        factor2 := ViewListDisplay[Idx2];
        if (compareText(factor2, 'Other')= 0) then
          factor2 := DataPt.values['4513'];
      end;

    //no duplicates
    if (compareText(factor1, factor2)= 0) then
      begin
        Idx2 := -1;
        factor2 := '';
      end;

    if Idx1 >= 0 then
      displayStr := displayStr + ';';
    if length(factor1) > 0 then
      displayStr := displayStr + factor1;
    if Idx2 >= 0 then
      displayStr := displayStr + ';';
    if length(factor2) > 0 then
      displayStr := displayStr + factor2
    else
      displayStr := displayStr;

    NewGroup.values['90'] := DisplayStr;
    if IsGrid then
      NewGroup.values['984'] := DisplayStr;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//location influence
function GetGSEDisplayGroup0962(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  Idx, Idx1, Idx2: Integer;
  displayStr, factor1, factor2: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    //get influence type
    displayStr := ' ';
    Idx := AnsiIndexText(DataPt.values['4419'], InfluenceList);     //get sale type
    if Idx > -1 then
      displayStr := InfluenceDisplay[Idx];

    //first influence factor
    factor1 := '';
    Idx1 := AnsiIndexText(DataPt.values['4420'], LocListXML);
    if Idx1 > -1 then
      begin
        factor1 := LocListDisplay[Idx1];
        if (compareText(factor1, 'Other')= 0) then
          factor1 := DataPt.values['4515'];
      end;

    //second influence factor
    factor2 := '';
    Idx2 := AnsiIndexText(DataPt.values['4421'], LocListXML);
    if Idx2 > -1 then
      begin
        factor2 := LocListDisplay[Idx2];
        if (compareText(factor2, 'Other')= 0) then
          factor2 := DataPt.values['4515'];
      end;

    //no duplicates
    if (compareText(factor1, factor2)= 0) then
      begin
        Idx2 := -1;
        factor2 := '';
      end;

    if Idx1 >= 0 then
      displayStr := displayStr + ';';
    if length(factor1) > 0 then
      displayStr := displayStr + factor1;
    if Idx2 >= 0 then
      displayStr := displayStr + ';';
    if length(factor2) > 0 then
      displayStr := displayStr + factor2
    else
      displayStr := displayStr;

    NewGroup.values['962'] := DisplayStr;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//room counts
function GetGSEDisplayGroup0229(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    NewGroup.values['229'] := DataPt.Values['1041'];    //total rooms

    NewGroup.values['230'] := DataPt.Values['1042'];    //total bedrooms

    NewGroup.values['231'] := DataPt.Values['1043'];    //total bathrooms

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//basement room counts
function GetGSEDisplayGroup1006(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  BsmtStr1, BsmtStr2: String;
  Idx: Integer;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    BsmtStr1 := ' ';
    BsmtStr2 := ' ';

    if DataPt.Values['4426'] <> '0' then               //we have a basement area
      begin
        //set the subject basement cells
        NewGroup.values['200'] := DataPt.Values['4426'];    //basement area

        NewGroup.values['201'] := DataPt.Values['201'];     //basement finished percent

        if Comparetext(DataPt.Values['4519'], 'InteriorOnly') <> 0 then
          NewGroup.values['208'] := 'X'                     //set the outside entry checkboz
        else
          NewGroup.values['208'] := ' ';                    //sapce so validator thinks it has data

        //set the grid basement cell 1
        BsmtStr1 := IntToStr(GetValidInteger(DataPt.Values['4426'])) + 'sf';
        BsmtStr1 := BsmtStr1 + IntToStr(GetValidInteger(DataPt.Values['4427'])) + 'sf';
        Idx := AnsiIndexText(DataPt.values['4519'], BsmtAccessListXML);
        if Idx > -1 then
          BsmtStr1 := BsmtStr1 + BsmtAccessDisplay[Idx];

        // Only display room counts if the basement is completely or partially finished 
        if (GetValidInteger(DataPt.Values['4427']) > 0) then
          begin
            //set the grid basement cell 2
            BsmtStr2 := IntToStr(GetValidInteger(DataPt.Values['4428'])) + 'rr';
            BsmtStr2 := BsmtStr2 + IntToStr(GetValidInteger(DataPt.Values['4429'])) + 'br';
            BsmtStr2 := BsmtStr2 + DataPt.Values['4430'] + 'ba';
            BsmtStr2 := BsmtStr2 + IntToStr(GetValidInteger(DataPt.Values['4520'])) + 'o';
          end;

        NewGroup.values['1006'] := BsmtStr1;
        NewGroup.values['1008'] := BsmtStr2;
      end
    else   //there is no basement
      begin
        NewGroup.values['200'] := '0';
        NewGroup.values['201'] := '0';
        NewGroup.values['208'] := ' ';
        NewGroup.values['1006'] := BsmtStr1;
        NewGroup.values['1008'] := BsmtStr2;
      end;

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//year built
function GetGSEDisplayGroup0151(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  DisplayStr: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    DisplayStr := '';

    if Trim(DataPt.Values['151']) <> '' then         //we have yr built
      begin
        //capture the approximate flag
        if DataPt.values['4415'] = 'Y' then
          DisplayStr := EstFlag;

        //capture the year built
        DisplayStr := DisplayStr + DataPt.values['151'];

        NewGroup.values['151'] := DisplayStr;
      end
    else
      NewGroup.values['151'] := ' ';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//actual age
function GetGSEDisplayGroup0996(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  DisplayStr: String;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    DisplayStr := '';

    if Trim(DataPt.Values['996']) <> '' then               //we have an age
      begin
        //capture the approximate flag
        if DataPt.values['4425'] = 'Y' then
          DisplayStr := EstFlag;

        //capture the actual age
        DisplayStr := DisplayStr + DataPt.values['996'];

        NewGroup.values['996'] := DisplayStr;
      end
    else
      NewGroup.values['996'] := ' ';

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//subject condition
function GetGSEDisplayGroup0520(GrpID: String; GSEGroups: TStringList; ExtOnly: Boolean=False): String;
var
  DataPt, NewGroup: TStringList;
  DisplayStr: String;
  Idx: Integer;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    DisplayStr := DataPt.values['4400'];

    if DataPt.values['4401'] = 'N' then
      DisplayStr := DisplayStr + ';' + NoUpd15Yrs
    else if not ExtOnly then
      begin
      //kitchen updated
      Idx := AnsiIndexText(DataPt.values['4404'], ImprovementListTypXML);     //was kitchen updated?
      if Idx > -1 then
        begin
          DisplayStr := DisplayStr + ';' + Kitchen;
          if Idx > - 1 then
            DisplayStr := DisplayStr + ImprovementListTypTxt[Idx];
          if (Idx > 0) then
            begin
              Idx := AnsiIndexText(DataPt.values['4406'], ImprovementListYrsXML);  //when
              if Idx > -1 then
                DisplayStr := DisplayStr + '-' + ImprovementListYrsTxt[Idx];
            end;
        end;

      //bathroom updated
      Idx := AnsiIndexText(DataPt.values['4405'], ImprovementListTypXML);     //was kitchen updated?
      if Idx > -1 then
        begin
          DisplayStr := DisplayStr + ';' + Bathroom;
          if Idx > - 1 then
            DisplayStr := DisplayStr + ImprovementListTypTxt[Idx];
          if (Idx > 0) then
            begin
              Idx := AnsiIndexText(DataPt.values['4407'], ImprovementListYrsXML);  //when
              if Idx > -1 then
                DisplayStr := DisplayStr + '-' + ImprovementListYrsTxt[Idx];
            end;
        end;
      end;

    if DisplayStr <> '' then
      begin
        if Trim(DataPt.values['520']) <> '' then
          NewGroup.values['520'] := DisplayStr + ';' + DataPt.values['520']
        else
          NewGroup.values['520'] := DisplayStr;
      end
    else
      if Trim(DataPt.values['520']) <> '' then
        NewGroup.values['520'] := DataPt.values['520']
      else
        NewGroup.values['520'] := ' ';
    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//subject grid quality
function GetGSEDisplayGroup0994(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    NewGroup.values['994'] := DataPt.values['4517'];
    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//subject grid condition
function GetGSEDisplayGroup0998(GrpID: String; GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    NewGroup.values['998'] := DataPt.values['4518'];
    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//Site Area
function GetGSEDisplayGroup0067(GrpID: String; GSEGroups: TStringList; IsGrid: Boolean=False): String;
var
  DataPt, NewGroup: TStringList;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    if length(DataPt.Values['67']) > 0 then                  //we have an area
      NewGroup.Values['67'] := DataPt.Values['67']
    else
      NewGroup.Values['67'] := ' ';

    if IsGrid then
      NewGroup.Values['976'] := NewGroup.Values['67'];

    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//Listing History
function GetGSEDisplayGroup2065(GrpID: String; var GSEGroups: TStringList): String;
var
  DataPt, NewGroup: TStringList;
  DisplayStr, DataPtStr, IdxStr: String;
  DOMLen, Idx, PosSpc: Integer;
  FoundItem: Boolean;
begin
  DataPt := TStringList.Create;
  NewGroup := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];

    DisplayStr := ' ';

    if DataPt.Values['2063'] = 'X' then
      NewGroup.Values['2063'] :=  'X'
    else
      if DataPt.Values['2064'] = 'X' then
        NewGroup.Values['2064'] := 'X';

    If DataPt.Values['2063'] = 'X' then                   //captured the Yes
      begin

        if length(DataPt.Values['4408']) > 0 then
          DisplayStr := DOMHint + DataPt.Values['4408'];

        if DataPt.Values['2065-2'] = 'X' then
          DisplayStr := DisplayStr + ';' + ListedFSBO
        else if DataPt.Values['2063'] = 'X' then
          DisplayStr := DisplayStr + ';' + OfferedSale;

        if length(Trim(DataPt.Values['2065-0'])) > 0 then
          DisplayStr := DisplayStr + ';' + LastPriceHint + DataPt.Values['2065-0'];
        if length(Trim(DataPt.Values['2065-1'])) > 0 then
          DisplayStr := DisplayStr + ';' + LastDateHint + DataPt.Values['2065-1'];

        if length(Trim(DataPt.Values['2065-7'])) > 0 then
          DisplayStr := DisplayStr + ';' + OrigPriceHint + DataPt.Values['2065-7'];
        if length(Trim(DataPt.Values['2065-8'])) > 0 then
          DisplayStr := DisplayStr + ';' + OrigDateHint + DataPt.Values['2065-8'];

        Idx := 0;
        repeat
          DataPtStr := DataPt.Values['2065-9-' + IntToStr(Idx)];
          if length(Trim(DataPtStr)) = 0 then
            FoundItem := False
          else
            begin
              FoundItem := True;
              IdxStr := IntToStr(Succ(Idx)) + ' ';
              PosSpc := Pos(' ', DataPtStr);
              if PosSpc = 0 then
                DisplayStr := DisplayStr + ';' + OtherDateHint + IdxStr + DataPtStr
              else
                DisplayStr := DisplayStr + ';' + OtherDateHint + IdxStr + Copy(DataPtStr, 1, PosSpc) +
                              ';' + OtherPriceHint + IdxStr + '$' + Copy(DataPtStr, Succ(PosSpc), Length(DataPtStr));
            end;
          Idx := Succ(Idx);
        until (not FoundItem);
      end;

    Idx := 0;
    repeat
      DataPtStr := DataPt.Values['2065-10-' + IntToStr(Idx)];
      if length(DataPtStr) = 0 then
        FoundItem := False
      else
        begin
          FoundItem := True;
          if DisplayStr <> '' then
            DisplayStr := DisplayStr + ';' + DataPtStr
          else
            DisplayStr := DataPtStr;
        end;
      Idx := Succ(Idx);
    until (not FoundItem);

    // Capture the formed text that must appear in data point 2065
    DomLen := Length(DataPt.Values['4408']);
    if DOMLen > 0 then
      DataPt.values['2065'] := Copy(DisplayStr, (Length(DomHint) + DomLen + 2), Length(DisplayStr))
    else
      DataPt.values['2065'] := DisplayStr;
    GSEGroups.Values[GrpID] := DataPt.CommaText;

    NewGroup.values['2065'] := DisplayStr;
    result := NewGroup.CommaText;
  finally
    DataPt.free;
    NewGroup.Free;
  end;
end;

//this is built as a long string so we can get to each 'Name' eaisly to check if it has data
//when we check, if the CID is not here, then we allow a blank to transfer later one.
procedure BuildDisplayDataPoints(GSEDisplayGroups, GSEXMLPts: TStringList; ExtOnly: Boolean=False);
var
  XferStr: String;
begin
  XferStr := GetGSEDisplayGroup0046('46', GSEXMLPts);                        //property address
  XferStr := XferStr + ',' + GetGSEDisplayGroup2056('2056', GSEXMLPts);      //contract-sales type
  XferStr := XferStr + ',' + GetGSEDisplayGroup2057('2057', GSEXMLPts);      //contract financial assiatance
  XferStr := XferStr + ',' + GetGSEDisplayGroup0090('90', GSEXMLPts);        //view influence
  XferStr := XferStr + ',' + GetGSEDisplayGroup0090('90', GSEXMLPts, True);  //view influence
  XferStr := XferStr + ',' + GetGSEDisplayGroup0962('962', GSEXMLPts);       //location influence
  XferStr := XferStr + ',' + GetGSEDisplayGroup0229('229', GSEXMLPts);       //room counts
  XferStr := XferStr + ',' + GetGSEDisplayGroup1006('1006', GSEXMLPts);      //basement room counts
  XferStr := XferStr + ',' + GetGSEDisplayGroup0151('151', GSEXMLPts);       //Year built
  XferStr := XferStr + ',' + GetGSEDisplayGroup0996('151', GSEXMLPts);       //actual age
  XferStr := XferStr + ',' + GetGSEDisplayGroup0520('520', GSEXMLPts, ExtOnly);      //subject condition
  XferStr := XferStr + ',' + GetGSEDisplayGroup0998('998', GSEXMLPts);       //subject grid condition
  XferStr := XferStr + ',' + GetGSEDisplayGroup0994('994', GSEXMLPts);       //subject grid quality
  XferStr := XferStr + ',' + GetGSEDisplayGroup0067('67', GSEXMLPts);        //Site Area
  XferStr := XferStr + ',' + GetGSEDisplayGroup0067('67', GSEXMLPts, True);  //Grid Site Area
  XferStr := XferStr + ',' + GetGSEDisplayGroup2065('2065', GSEXMLPts);      //listing history

  GSEDisplayGroups.CommaText := XferStr;
end;

//creates the UAD XML data groups/points
procedure BuildGSEXMLDataGroups(doc: TContainer; GSEGroups, GSEXMLPts: TStringList; ExtOnly: Boolean=False);
begin
  GSEXMLPts.Values['46']    := GetGSEXMLDataGroup0046('46', GSEGroups);       //property address
  GSEXMLPts.Values['2056']  := GetGSEXMLDataGroup2056('2056', GSEGroups);     //contract-sales type
  GSEXMLPts.Values['2057']  := GetGSEXMLDataGroup2057('2057', GSEGroups);     //contract financial assiatance
  GSEXMLPts.Values['90']    := GetGSEXMLDataGroup0090('90', GSEGroups);       //view incluence
  GSEXMLPts.Values['984']   := GSEXMLPts.Values['90'];
  GSEXMLPts.Values['962']   := GetGSEXMLDataGroup0962('962', GSEGroups);      //location influence
  GSEXMLPts.Values['229']   := GetGSEXMLDataGroup0229('229', GSEGroups);      //room counts
  GSEXMLPts.Values['1041']  := GSEXMLPts.Values['229'];                       //grid room counts
  GSEXMLPts.Values['1006']  := GetGSEXMLDataGroup1006('1006', GSEGroups);     //basement room counts
  GSEXMLPts.Values['200']   := GSEXMLPts.Values['1006'];                      //basement area & % - uses 1006 XML group
  GSEXMLPts.Values['151']   := GetGSEXMLDataGroup0151(doc, '151', GSEGroups); //Year built & actual age
  GSEXMLPts.Values['996']   := GSEXMLPts.Values['151'];                       //Year built & actual age
  GSEXMLPts.Values['520']   := GetGSEXMLDataGroup0520('520', GSEGroups, ExtOnly); //subject condition
  GSEXMLPts.Values['998']   := GetGSEXMLDataGroup0998('520', GSEGroups);      //subject grid condition
  GSEXMLPts.Values['994']   := GetGSEXMLDataGroup0994('994', GSEGroups);      //subject grid construction quality
  GSEXMLPts.Values['67']    := GetGSEXMLDataGroup0067('67', GSEGroups);       //Site Area
  GSEXMLPts.Values['976']   := GetGSEXMLDataGroup0067('67', GSEGroups, True); //Site Area on grid
  GSEXMLPts.Values['2065']  := GetGSEXMLDataGroup2065('2065', GSEGroups);     //listing history
end;

function GetUADOnlyCellByID(doc: TContainer; CellID: Integer): TBaseCell;
var
  f:Integer;
begin
  result := nil;
  f := 0;
  if CellID > 0 then              //make sure we have something to find.
    if assigned(doc.docForm) then
      while (result = nil) and (f < doc.docForm.count) do
        begin
          if IsUADForm(doc.docForm[f].frmInfo.fFormUID) then    //is it UAD form?
            result := doc.docForm[f].GetCellByID(CellID);       //get only cell on UAD form
          inc(f);
        end;
end;

//This is a hack to get some data points into the munger
//this MUST be called before the data transfer for display is called
//JB- Not used anymore - are we sure we don't need it for the addresses
procedure TransferGSEToMunger(doc: TContainer; GSEGroups: TStringList);
var
  dataPts: TStringList;
begin
  if assigned(GSEGroups) then
    begin
      dataPts := TStringList.create;
      try
        //set the kYearBuiltEstimated field so the Estimated points in Munger can be created
        dataPts.commaText := GSEGroups.Values['151'];
        doc.Munger.MungedValue[kYearBuiltEstimated] := dataPts.Values['4425'];

        //set the munger address data points (address, unit, city, state, zip)
        dataPts.Clear;
        dataPts.commaText := GSEGroups.values['46'];
        doc.Munger.MungedValue[kAddress]  := dataPts.Values['46'];
        doc.Munger.MungedValue[kUnitNo]   := dataPts.Values['2141'];
        doc.Munger.MungedValue[kCity]     := dataPts.Values['47'];
        doc.Munger.MungedValue[kState]    := dataPts.Values['48'];
        doc.Munger.MungedValue[kZip]      := dataPts.Values['49'];
      finally
        dataPts.Free;
      end;
    end;
end;

//Transfers the individual GSE XML data pt groups to the cells where the dialogs can find them
procedure TransferGSEDataGroups(doc: TContainer; GSEGroups: TStringList);
var
  Cell: TBaseCell;
  GSECellID, N: Integer;
begin
  if GSEGroups.count > 0 then                                     //we have GSE data groups
    begin
      for N := 0 to GSEGroups.count-1 do                          //cycle through them
        begin
          GSECellID := StrToIntDef(GSEGroups.Names[N], 0);        //find the GSE Cell ID - index through list
          if GSECellID > 0 then
            begin
              Cell := GetUADOnlyCellByID(doc, GSECellID) ;        //find cell in UAD only forms
              if assigned(Cell) then
                Cell.GSEData := GSEGroups.Values[IntToStr(GSECellID)];    //transfer the GSE data - find by Name=Value pair
            end;
        end;
    end;
end;

procedure BuildGSEGroups(GSEGroups: TStringList; GrpID, DataPtName, DataPtValue: String);
var
  DataPt: TStringList;
begin
  DataPt := TStringList.Create;
  try
    DataPt.CommaText := GSEGroups.Values[GrpID];                 //this is what is there
    DataPt.Values[DataPtName] := DataPtValue;                    //set the new data pt
    GSEGroups.Values[GrpID] := DataPt.CommaText;                 //replace with new group list
  finally
    DataPt.free;
  end;
end;

//This routine takes all the diaplay pts and places them in cells with XID
procedure TransferGSEDisplayPts(doc: TContainer; GSEGroups: TStringList);
var
  Idx: Integer;
  Cell: TBaseCell;
  cellStr: String;
  CellXID: Integer;
begin
  for Idx := 0 to GSEGroups.Count-1 do
    begin
      CellXID := StrToIntDef(GSEGroups.Names[Idx], 0);
      if CellXID > 0 then
        Cell := doc.GetCellByXID(CellXID)
      else
        Cell := nil;
//      Cell := doc.GetCellByXID(StrToIntDef(GSEGroups.Names[Idx], 0));
      if assigned(Cell) then
        begin
          doc.StartProcessLists;
          cellStr := GSEGroups.ValueFromIndex[Idx];
          Cell.SetText(cellStr);
          Cell.ReplicateLocal(true);
          Cell.Display;
          Cell.ProcessMath;
          if Cell.FContextID > 0 then
            doc.LoadCellMunger(Cell.FContextID, cellStr);
          doc.ClearProcessLists;
        end;
    end;
end;

//this is the rountine that transfers the data form the UAD Power User Subejct form to the report
procedure TransferUADSubjectDataToReport(doc: TContainer; CX: CellUID);
const
  UADSubPowerUserFrm  = 981;
  cUADXferIDFile      = 'UADXferIDs.Ini';
  GroupSection        = 'GSEGrouping';
  SpecialXfers        = 'SpecialTransfers';
var
  UADXferIDPath: String;
  UADXferMap: TMemIniFile;
  GSEGroups: TStringList;
  GSEXMLPts: TStringList;
  GSEDisplayPts: TStringList;
  GSEGroupID: String;
  DataPtName,DataPtValue: String;
  fromPage: TDocPage;
  fromCell: TBaseCell;
  fromCellID, XCount: Integer;
  toForm: TDocForm;
  toPage: TDocPage;
  toCell: TBaseCell;
  ExteriorOnlyReport: Boolean;
	c, f, i, p: Integer;

  //get the group identifier that the cell belongs to; build the GSE Data groups
  function CellInGSEGroup(theCellID: Integer; var theGroupID, theDataPtID: String): Boolean;
  var
    IDStr: String;
    N: Integer;
  begin
    theGroupID := '';
    theDataPtID := '';
    IDStr := UADXferMap.ReadString(GroupSection, IntToStr(theCellID), '');
    if length(IDStr) > 0 then
      begin
        N := POS('|', IDStr);                               //str is divided by "|"
        theGroupID := copy(IDStr,1,N-1);                    //first is group cell ID
        theDataPtID := copy(IDStr,N+1,length(IDStr));       //second is the data pt 'name' = XID
      end;
    result := (length(theGroupID) > 0) and (length(theDataPtID) > 0);
  end;

  function IsGSEGroupCellWithData(GSEDisplayGroup: TStringList; theCellID: Integer): Boolean;
  begin
    result := False;
    if theCellID > 0 then //does this cellID have data, if not allows blanks to transfer
      result := length(GSEDisplayGroup.Values[IntToStr(theCellID)]) > 0;
  end;

  function CheckForSpecialTransfer(theCellID: Integer): Integer;
  begin
    result := UADXferMap.ReadInteger(SpecialXfers, IntToStr(theCellID), 0);
    if result = 0 then
      result := theCellID;
  end;

begin
  UWindowsInfo.PushMouseCursor(crHourglass);
  XCount := 0;

  //This is where GSE dataPt groups are stored - each uniquely identified
  GSEGroups := TStringList.Create;
  GSEXMLPts := TStringList.Create;
  GSEDisplayPts := TStringList.Create;
  try
    //get the XID/UAD_ID transfer map. Setup so we only open it once during all transfers
    UADXferIDPath := IncludeTrailingPathDelimiter(appPref_DirMISMO) + cUADXferIDFile;
    if FileExists(UADXferIDPath) then
      UADXferMap := TMemIniFile.Create(UADXferIDPath);

    ExteriorOnlyReport := IsExtOnlyReport(doc);               //distinguish between UAD forms

    //this is the Subj Details page to transfer from
    fromPage := doc.docForm[CX.form].frmPage[CX.pg];          //CX identifies the page

    //Gather the GSE Data Points, start aggregating into groups
    for i := 0 to fromPage.pgData.count-1 do                  //for every cell in formPage
      begin
        if (fromPage.pgData[i].FCellID > 0) then              //process all Subj Detail cells
          begin
            fromCell := fromPage.pgData[i];
            fromCellID := fromCell.FCellID;
            if CellInGSEGroup(fromCellID, GSEGroupID, DataPtName) then
              begin
                DataPtValue := fromCell.Text;
                BuildGSEGroups(GSEGroups, GSEGroupID, DataPtName, DataPtValue);
              end;
          end;
      end;

    //Build GSEData Pts for each of the groups so the Dialogs can use the points
    if GSEGroups.count > 0 then
      begin
        BuildGSEXMLDataGroups(doc, GSEGroups, GSEXMLPts, ExteriorOnlyReport);
      end;

    //Build the Display pts, put then in groups
    if GSEXMLPts.count > 0 then
      begin
        BuildDisplayDataPoints(GSEDisplayPts, GSEXMLPts, ExteriorOnlyReport);
        TransferGSEDisplayPts(doc, GSEDisplayPts);
        TransferGSEDataGroups(doc, GSEXMLPts);
        TransferGSEToMunger(doc, GSEXMLPts);
      end;

    //do the regular transfers
    for f := 0 to doc.docForm.Count-1 do
      if (f <> CX.form) and (doc.docForm[f].FormID <> CX.FormID) then  //not this one or one of same type
        begin
          Inc(XCount);
          toForm := doc.docForm[f];                               //populate this form
          for p := 0 to toForm.frmPage.count-1 do                 //all pages of it
            begin
              toPage := toForm.frmPage[p];                        //shortcut to it
              for i := 0 to fromPage.pgData.count-1 do            //for every cell in formPage
              begin
                if (fromPage.pgData[i].FCellID > 0) then           //and something to transfer
                  begin
                    fromCell := fromPage.pgData[i];
                    fromCellID := fromCell.FCellID;

                    fromCellID := CheckForSpecialTransfer(fromCellID);  //special transfer switch 'AMC name'

                    //see if its a UAD cell
                    if (not IsGSEGroupCellWithData(GSEDisplayPts, fromCellID)) and   //transfer blanks (only way to erase)
                       (fromCellID <> 8) then                                        //do not transfer company name cell
                        for c := 0 to toPage.pgData.count-1 do      //try all the cells on this page
                          begin
                            toCell := toPage.pgData[c];             //shortcut to the cell
                            if (toCell.FCellID = fromCellID) then
                              begin
                                if toCell.ClassNameIs('TChkBoxCell') then
                                  toCell.DoSetText(fromCell.Text)   // use DoSetText to bypass group enforcement
                                else
                                  begin
                                    doc.StartProcessLists;
                                    toCell.SetText(fromCell.Text);
                                    toCell.Display;
                                    toCell.ProcessMath;
                                    toCell.ReplicateLocal(True);
                                    toCell.ReplicateGlobal;
                                    if toCell.FContextID > 0 then
                                      doc.LoadCellMunger(toCell.FContextID, fromCell.Text);
                                    doc.ClearProcessLists;
                                  end;
                              end;
                          end;
                  end;
              end;
            end;
        end;

  finally
    if assigned(GSEGroups) then
      GSEGroups.Free;
    if assigned(GSEXMLPts) then
      GSEXMLPts.Free;
    if assigned(GSEDisplayPts) then
      GSEDisplayPts.Free;

    if assigned(UADXferMap) then
      UADXferMap.Free;

    UWindowsInfo.PopMouseCursor;

    if XCount = 0 then
      ShowNotice('There were no available forms to transfer the data into.');
  end;
end;


//this is the rountine that transfers data form forms to the UAD Power User Subject worksheet when cloning
procedure TransferReportDataToUADSubject(doc: TContainer; Worksheet: TDocForm);
var
  ClNum, ClSeq, Idx, N, PageCounter, TmpIntVal, WksXID: Integer;
  FactorID: Integer;
  FormXIDStr, WksXIDStr, UADFormSubjFName: String;
  ThisPage: TDocPage;
  UADFormSubj, GSEData: TStringList;
  FormCell, WksCell: TBaseCell;
  DataPtText, Factor: String;
begin
  FactorID := -1;
  UADFormSubjFName := IncludeTrailingPathDelimiter(appPref_DirMISMO) + 'UADFormSubj.txt';
  if (Worksheet <> nil) and FileExists(UADFormSubjFName) then
    begin
      UADFormSubj := TStringList.Create;
      UADFormSubj.LoadFromFile(UADFormSubjFName);
      if UADFormSubj.Count > 0 then
        for PageCounter := 0 to Pred(Worksheet.frmInfo.fFormPgCount) do
          begin
            ThisPage := WorkSheet.frmPage[PageCounter];
            for ClNum := 0 to Pred(ThisPage.pgData.Count) do
              begin
                N := Pos('|', UADFormSubj.Strings[ClNum]);                               //str is divided by "|"
                if N > 0 then
                  begin
                    WksXIDStr := Copy(UADFormSubj.Strings[ClNum], 1, N-1);
                    FormXIDStr :=  Copy(UADFormSubj.Strings[ClNum], N+1, Length(UADFormSubj.ValueFromIndex[ClNum]));
                    WksXID := StrToIntDef(WksXIDStr, 0);
                    ClSeq := Succ(ClNum);
                    if WksXID > 0 then
                      if (FormXIDStr = '0') then
                        begin
                          FormCell := doc.GetCellByXID(WksXID);
                          if FormCell <> nil then
                            if WksXID > 0 then
                              begin
                                WksCell := Worksheet.GetCell(Succ(PageCounter), ClSeq);
                                if WksCell <> nil then
                                  WksCell.DoSetText(FormCell.Text);
                              end;
                        end
                      else
                        begin
                          FormCell := doc.GetCellByXID(WksXID);
                          if FormCell <> nil then
                            begin
                              GSEData := TStringList.Create;
                              GSEData.CommaText := FormCell.GSEData;
                              DataPtText := GSEData.Values[FormXIDStr];
                              if (DataPtText = '') then
                                begin
                                  FormCell := doc.GetCellByXID(WksXID);
                                  if FormCell <> nil then
                                    DataPtText := FormCell.Text;
                                end;
                              case ClSeq of
                                5..9:
                                   if GSEData.Values[FormXIDStr] = '' then
                                     begin
                                       FormCell := doc.GetCellByXID(StrToInt(FormXIDStr));
                                       if FormCell <> nil then
                                         DataPtText := FormCell.Text
                                       else
                                         DataPtText := '';
                                     end;
                                43, 44, 47, 62, 63, 71, 72, 74, 210..213:
                                   if DataPtText = 'Y' then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                45:
                                   begin
                                     DataPtText := GSEData.Values[FormXIDStr];
                                     N := Pos(' ', Trim(DataPtText));
                                     if N > 0 then
                                       DataPtText := Copy(DataPtText, Succ(N), Length(DataPtText));
                                   end;
                                46:
                                   begin
                                     DataPtText := GSEData.Values[FormXIDStr];
                                     N := Pos(' ', Trim(DataPtText));
                                     if N > 0 then
                                       DataPtText := Copy(DataPtText, 1, Pred(N));
                                   end;
                                48:
                                   if (Length(DataPtText) = 3) and (DataPtText = 'Unk') then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                49:
                                   if (Length(DataPtText) = 3) and IsValidInteger(DataPtText, TmpIntVal) then
                                     DataPtText := IntToStr(TmpIntVal)
                                   else
                                     DataPtText := '';
                                50, 51, 53, 54, 56, 57, 59, 60:
                                   DataPtText := GSEData.Values[FormXIDStr];
                                73:
                                  if IsValidInteger(DataPtText, TmpIntVal) then
                                    DataPtText := IntToStr(TmpIntVal)
                                  else
                                    DataPtText := '';
                                81, 86:
                                  if GSEData.Values[FormXIDStr] <> '' then
                                    DataPtText := GSEData.Values[FormXIDStr]
                                  else
                                    begin
                                     N := Pos(';', DataPtText);                                   //assume format like 'B;Wtr;Pstrl
                                     if N = 2 then
                                       begin
                                         Idx := AnsiIndexText(Copy(DataPtText, 1, 1), InfluenceDisplay);      //which influence
                                         if Idx > -1 then
                                           DataPtText := InfluenceList[Idx];
                                        end;
                                    end;
                                82, 84:
                                  begin
                                    FactorID := -1;
                                    //get view factor
                                    if GSEData.Values[FormXIDStr] <> '' then
                                      begin
                                        Factor := GSEData.Values[FormXIDStr];
                                        Idx := AnsiIndexText(Factor, ViewListXML);              //which response
                                        if Idx > -1 then
                                          DataPtText := ViewListRsp[Idx]
                                        else
                                          begin
                                            DataPtText := ViewListRsp[MaxViewFeatures];
                                            Idx := MaxViewFeatures;
                                          end;
                                        FactorID := Idx;
                                      end
                                    else
                                      begin
                                        N := Pos(';', Factor);                                   //assume format like 'B;Wtr;Pstrl
                                        if N > 0 then
                                          Factor := Copy(DataPtText, Succ(N), Length(DataPtText))
                                        else
                                          Factor := DataPtText;
                                        N := Pos(';', Factor);
                                        if N > 0 then
                                          if ClSeq = 82 then
                                            Factor := Copy(Factor, 1, Pred(N))
                                          else
                                            Factor := Copy(Factor, Succ(N), Length(Factor));
                                        if Factor <> '' then
                                          begin
                                            if (ClSeq = 84) and (N = 0) then
                                              begin
                                                DataPtText := '';
                                                Factor := '';
                                              end
                                            else
                                              begin
                                                Idx := AnsiIndexText(Factor, ViewListDisplay);   //which response
                                                if Idx > -1 then
                                                  DataPtText := ViewListRsp[Idx]
                                                else
                                                  begin
                                                    DataPtText := ViewListRsp[MaxViewFeatures];
                                                    Idx := MaxViewFeatures;
                                                  end;
                                                FactorID := Idx;
                                              end;
                                          end
                                        else
                                          DataPtText := '';
                                      end;
                                  end;
                                83, 85:
                                  if (FactorID = MaxViewFeatures) or (FactorID < 0) then
                                    DataPtText := Factor
                                  else
                                    DataPtText := '';
                                87, 89:
                                  begin
                                    FactorID := -1;
                                    //get location factor
                                    if GSEData.Values[FormXIDStr] <> '' then
                                      begin
                                        Factor := GSEData.Values[FormXIDStr];
                                        Idx := AnsiIndexText(Factor, LocListXML);                //which response
                                        if Idx > -1 then
                                          DataPtText := LocListRsp[Idx]
                                        else
                                          begin
                                            DataPtText := LocListRsp[MaxLocFactors];
                                            Idx := MaxLocFactors;
                                          end;
                                        FactorID := Idx;
                                      end
                                    else
                                      begin
                                        N := Pos(';', DataPtText);                               //assume format like 'B;Wtr;Pstrl
                                        if N > 0 then
                                          Factor := Copy(DataPtText, Succ(N), Length(DataPtText))
                                        else
                                          Factor := DataPtText;
                                        N := Pos(';', Factor);
                                        if N > 0 then
                                          if ClSeq = 87 then
                                            Factor := Copy(Factor, 1, Pred(N))
                                          else
                                            Factor := Copy(Factor, Succ(N), Length(Factor));
                                        if Factor <> '' then
                                          begin
                                            if (ClSeq = 89) and (N = 0) then
                                              begin
                                                DataPtText := '';
                                                Factor := '';
                                              end
                                            else
                                              begin
                                                Idx := AnsiIndexText(Factor, LocListDisplay);   //which response was selected
                                                if Idx > -1 then
                                                  DataPtText := LocListRsp[Idx]
                                                else
                                                  begin
                                                    DataPtText := LocListRsp[MaxLocFactors];
                                                    Idx := MaxLocFactors;
                                                  end;
                                                FactorID := Idx;
                                              end;
                                          end
                                        else
                                          DataPtText := '';
                                      end;
                                  end;
                                88, 90:
                                  if (FactorID = MaxLocFactors) or (FactorID < 0) then
                                    DataPtText := Factor
                                  else
                                    DataPtText := '';
                                133:
                                   if (Copy(DataPtText, 1, 1) = 'Y') or (Copy(DataPtText, 1, 1) = EstFlag) then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                141, 157:
                                   begin
                                     N := Pos('.', DataPtText);
                                     if N > 0 then
                                       DataPtText := Copy(DataPtText, 1, Pred(N));
                                   end;
                                142, 158:
                                   begin
                                     N := Pos('.', DataPtText);
                                     if N > 0 then
                                       DataPtText := Copy(DataPtText, Succ(N), Length(DataPtText));
                                   end;
                                148:
                                   if DataPtText = 'WalkOut' then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                149:
                                   if DataPtText = 'WalkUp' then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                150:
                                   if DataPtText = 'InteriorOnly' then
                                     DataPtText := 'X'
                                   else
                                     DataPtText := '';
                                214, 216:
                                  begin
                                    FactorID := -1;
                                    //get improvement factor
                                    if GSEData.Values[FormXIDStr] <> '' then
                                      begin
                                        Idx := AnsiIndexText(GSEData.Values[FormXIDStr], ImprovementListTypXML);                //which response
                                        if Idx > -1 then
                                          DataPtText := ImprovementListTypRsp[Idx];
                                        FactorID := Idx;
                                      end
                                    else
                                      DataPtText := '';  
                                  end;
                                215, 217:
                                  begin
                                    if FactorID < 0 then
                                      DataPtText := ''
                                    else
                                    //get improvement timeframe
                                    if GSEData.Values[FormXIDStr] <> '' then
                                      begin
                                        Idx := AnsiIndexText(GSEData.Values[FormXIDStr], ImprovementListYrsXML);                //which response
                                        if Idx > -1 then
                                          DataPtText := ImprovementListYrsSD[Idx];
                                      end
                                    else
                                      DataPtText := '';
                                  end;
                                218:
                                  if GSEData.Values[FormXIDStr] = '' then
                                    begin
                                      FormCell := doc.GetCellByXID(998);
                                      if FormCell <> nil then
                                        DataPtText := FormCell.Text
                                      else
                                        DataPtText := '';
                                    end;
                              end;
                              WksCell := Worksheet.GetCell(Succ(PageCounter), ClSeq);
                              if (WksCell <> nil) then
                                WksCell.DoSetText(DataPtText);
                            end;
                        end;
                  end;
              end;
          end;
      UADFormSubj.Free;
    end;
end;

function SetUADSpecialXML(theXML: String): String;
begin
  // This function replaces Other# occurrances in the XML with just Other. UAD maps
  //  cells 1500-1502 and 1020, 1022 & 1032 to a path that cannot be reconciled
  //  by the current export mechanism. Other# is used to allow multiple elements
  //  in the base XML and the replacement occurs here to ensure XSD compliance.
  Result := StringReplace(theXML, '_Type="Other1"', '_Type="Other"', [rfReplaceAll]);
  Result := StringReplace(Result, '_Type="Other2"', '_Type="Other"', [rfReplaceAll]);
  Result := StringReplace(Result, '_Type="Other3"', '_Type="Other"', [rfReplaceAll]);
  Result := StringReplace(Result, '_Type="Other4"', '_Type="Other"', [rfReplaceAll]);
end;

function IsUnitAddrReq(theDoc: TContainer): Boolean;
var
  Cntr: Integer;
begin
  Cntr := -1;
  repeat
    Cntr := Succ(Cntr);
    Result := (AnsiIndexStr(IntToStr(thedoc.docForm[Cntr].FormID), UnitAddrFormIDStr) >= 0);
  until Result or (Cntr = Pred(thedoc.docForm.Count));
end;

function IsResidReport(Doc: TContainer): Boolean;
var
  FormID, FormIdx, MaxIdx,i: Integer;
begin
  result := False;
  if Assigned(Doc) and (Doc.docForm.Count > 0) then
    begin
      FormIdx := -1;
      MaxIdx := Pred(Doc.docForm.Count);
      repeat
        FormIdx := Succ(FormIdx);
        FormID := Doc.docForm[FormIdx].FormID;
       // for i:= 0 to MaxUADForms -1 do   //github #791: should walk through the UADForms Array
       //   if FormID = UADForms[i] then   //this will fix the issue of unit # pops up for residentail
       //     result := True;
       case FormID of
         340, 341, 355, 356, 363, 3545,
         4195, 4215,  //Drew's form
         4187, 4188,  //Derek's form
         4220,
         4218,4219,   //1004P
          4365, 4366, //FMAC 70H
         4230: Result := True;  //ticket #1113, 1086
       end;
      until Result or (FormIdx = MaxIdx);
    end;
end;

function DisplayNonUADStdDlg(doc:TContainer):Boolean;
var
  EffectiveAge:TdlgUADEffectiveAge;
  aBaseCell:TBaseCell;
  aFormUID:Integer;
begin
  result := true;
  if doc = nil then exit;
  aBasecell := doc.docActiveCell;
  if not assigned(aBaseCell) then
    exit;  //for example Clickforms in FreeText mode
  aFormUID := aBaseCell.UID.FormID;
  case aFormUID of    //#1605: exclude form 345 and 347
    345,347: exit;
  end;
  case doc.docActiveCell.FCellXID of
    499,875:  //#1605: Effective age/economic life
       begin
          try
            EffectiveAge := TdlgUADEffectiveAge.Create(nil);
            RefreshCurCell(doc);
            EffectiveAge.FCell := doc.docActiveCell;
            EffectiveAge.FDoc  := doc;  //Ticket #1436: bring in current active container
            EffectiveAge.ShowModal;
          finally
            EffectiveAge.Free;
          end;
       end;
  end;
end;

function DisplayUADStdDlg(doc: TContainer; CellClassName: String=''; CheckOnly: Boolean=False): Boolean;
var
  Page: TDocPage;
  PropSubjAddr: TdlgUADPropSubjAddr;
  PropLineAddr: TdlgUADPropLineAddr;
  SaleFinConcession: TdlgUADSaleFinConcession;
  ConstQuality: TdlgUADConstQuality;
  GridCondition: TdlgUADGridCondition;
  GridDataSrc: TdlgUADGridDataSrc;
  GridDateOfSale: TdlgUADDateOfSale;
  GridLocRating: TdlgUADGridLocRating;
  SiteArea: TdlgUADSiteArea;
  SiteView: TdlgUADSiteView;
  ProjYrBuilt: TdlgUADProjYrBuilt;
  GridRooms: TdlgUADGridRooms;
  Basement: TdlgUADBasement;
  MultiChkBox: TdlgUADMultiChkBox;
  CommPctDesc: TdlgUADCommPctDesc;
  ContractAnalyze: TdlgUADContractAnalyze;
  SubjCondition: TdlgUADSubjCondition;
  ContractFinAssist: TdlgUADContractFinAssist;
  SubjDataSrc: TdlgUADSubjDataSrc;
  ResidDesignStyle: TdlgUADResidDesignStyle;
  CondoDesignStyle: TdlgUADCondoDesignStyle;
  ResidCarStorage: TdlgUADResidCarStorage;
  CondoCarStorage: TdlgUADCondoCarStorage;
  aCell: TBaseCell;
  EffectiveAge:TdlgUADEffectiveAge;

  function CellClassIsOK(ClassName: String): Boolean;
  begin
    Result := ((ClassName = '') or
               (ClassName = 'TChkBoxCell') or
               (ClassName = 'TGeocodedGridCell') or
               (ClassName = 'TGridCell') or
               (ClassName = 'TMLnTextCell') or
               (ClassName = 'TTextCell'));
  end;

begin
  Result := False;
(* github #433
  if assigned(doc.docActiveCell) then
    begin
      if doc.docActiveCell.FContextID = 0 then
      case doc.docActiveCell.UID.FormID of
        794, 834, 683:
          exit;
      end;
    end;
*)

  if doc.UADEnabled and
   (doc.docActiveCell <> nil) and
   doc.docActiveCell.CanEdit and
   (not IsUADWorksheet(doc.docActiveCell)) and
   IsUADCellActive(doc.docActiveCell.FCellXID) and
   CellClassIsOK(CellClassName) then
    case doc.docActiveCell.FCellXID of
      9, 10, 24, 41, 42, 925, 926, 1660, 1737, 1801, 1802, 3981, 3982, 932, 933,
      1819, 1820, 1838, 1839, 1857, 1858:
        if CheckOnly then
          Result := True
        else
          try
            PropLineAddr := TdlgUADPropLineAddr.Create(nil);          //create the dialog
            RefreshCurCell(doc);
            PropLineAddr.FCell := doc.docActiveCell;
            PropLineAddr.FDoc  := doc;  //Ticket #1231
            PropLineAddr.ShowModal;
          finally
            PropLineAddr.Free;
          end;
      46, 2758, 3970:
        if CheckOnly then
          Result := True
        else
          begin
            // If we're in a 2-line subject address field such as on a certification form
            //  then use the line address dialog - otherwise use the multi-cell subject dialog
            Page := doc.docActiveCell.ParentPage as TDocPage;
            if Page.pgData.DataCell[doc.docActiveCell.GetCellIndex + 1].FCellXID = 41 then
              try
                PropLineAddr := TdlgUADPropLineAddr.Create(nil);          //create the dialog
                RefreshCurCell(doc);
                PropLineAddr.FCell := doc.docActiveCell;
                PropLineAddr.ShowModal;
              finally
                PropLineAddr.Free;
             end
           else
             try
               PropSubjAddr := TdlgUADPropSubjAddr.Create(nil);          //create the dialog
               RefreshCurCell(doc);
               PropSubjAddr.FCell := doc.docActiveCell;
               PropSubjAddr.PriFormReqUnit := IsUnitAddrReq(doc);
               PropSubjAddr.ShowModal;
             finally
               PropSubjAddr.Free;
             end;
          end;
      47..49, 1790..1793, 2141, 2759..2761, 3971..3973:
        if CheckOnly then
          Result := True
        else
          try
            PropSubjAddr := TdlgUADPropSubjAddr.Create(nil);          //create the dialog
            RefreshCurCell(doc);
            PropSubjAddr.FCell := doc.docActiveCell;
            PropSubjAddr.PriFormReqUnit := IsUnitAddrReq(doc);
            PropSubjAddr.ShowModal;
          finally
            PropSubjAddr.Free;
          end;
      346, 349, 1016, 1816, 1835, 1854, 1873, 4010:
       if CheckOnly then
         Result := True
       else           // 1004 & 2055 use "# of Stories", not "Levels"
         if IsResidReport(doc) then  // is this a residential (non-condo) report
           try
             ResidCarStorage := TdlgUADResidCarStorage.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             ResidCarStorage.FCell := doc.docActiveCell;
             ResidCarStorage.ShowModal;
           finally
             ResidCarStorage.Free;
           end
         else
           try
             CondoCarStorage := TdlgUADCondoCarStorage.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             CondoCarStorage.FCell := doc.docActiveCell;
             CondoCarStorage.ShowModal;
           finally
             CondoCarStorage.Free;
           end;
      92, 355, 359, 360, 2030, 2070..2072, 2657:
       if CheckOnly then
         Result := True
       else
         try
           ResidCarStorage := TdlgUADResidCarStorage.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           ResidCarStorage.FCell := doc.docActiveCell;
           ResidCarStorage.ShowModal;
         finally
           ResidCarStorage.Free;
         end;
      345, 363, 413, 414, 2000, 3591:
       if CheckOnly then
         Result := True
       else
         try
           CondoCarStorage := TdlgUADCondoCarStorage.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           CondoCarStorage.FCell := doc.docActiveCell;
           CondoCarStorage.ShowModal;
         finally
           CondoCarStorage.Free;
         end;
      520:
        if CheckOnly then
          Result := True
        else
          try
            SubjCondition := TdlgUADSubjCondition.Create(nil);          //create the dialog
            RefreshCurCell(doc);
            SubjCondition.FCell := doc.docActiveCell;
            SubjCondition.MainAddictSpell := Main.AddictSpell;
            doc.UADOverflowCheck := True;
            SubjCondition.ShowModal;
          finally
            SubjCondition.Free;
          end;
      827, 828, 829, 830, 2147, 2462:
       if CheckOnly then
         Result := True
       else
         try
            MultiChkBox := TdlgUADMultiChkBox.Create(nil);          //create the dialog
            RefreshCurCell(doc);
            MultiChkBox.FCell := doc.docActiveCell;
            MultiChkBox.MainAddictSpell := Main.AddictSpell;
            doc.UADOverflowCheck := True;
            MultiChkBox.ShowModal;
          finally
            MultiChkBox.Free;
         end;
      2116, 2119, 2120:
       if CheckOnly then
         Result := True
       else
         try
           CommPctDesc := TdlgUADCommPctDesc.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           CommPctDesc.FCell := doc.docActiveCell;
           CommPctDesc.MainAddictSpell := Main.AddictSpell;
           doc.UADOverflowCheck := True;
           CommPctDesc.ShowModal;
         finally
           CommPctDesc.Free;
         end;
      930, 3989:
       if CheckOnly then
         Result := True
       else
         try
           GridDataSrc := TdlgUADGridDataSrc.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           GridDataSrc.FCell := doc.docActiveCell;
           GridDataSrc.ShowModal;
         finally
           GridDataSrc.Free;
         end;
      956, 958:
       if CheckOnly then
         Result := True
       else
         try
           SaleFinConcession := TdlgUADSaleFinConcession.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           SaleFinConcession.FCell := doc.docActiveCell;
           SaleFinConcession.ShowModal;
         finally
           SaleFinConcession.Free;
         end;
      960:
       if CheckOnly then
         Result := True
       else
         try
           GridDateOfSale := TdlgUADDateOfSale.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           GridDateOfSale.FCell := doc.docActiveCell;
           GridDateOfSale.ShowModal;
         finally
           GridDateOfSale.Free;
         end;
      962, 2246, 3995:
       if CheckOnly then
         Result := True
       else
         try
           GridLocRating := TdlgUADGridLocRating.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           GridLocRating.FCell := doc.docActiveCell;
           GridLocRating.ShowModal;
         finally
           GridLocRating.Free;
         end;
      86, 67, 976, 3996:
       if CheckOnly then
         Result := True
       else
         try
           SiteArea := TdlgUADSiteArea.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           SiteArea.FCell := doc.docActiveCell;
           SiteArea.ShowModal;
         finally
           SiteArea.Free;
         end;
      90, 984:
       if CheckOnly then
         Result := True
       else
         try
           SiteView := TdlgUADSiteView.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           SiteView.FCell := doc.docActiveCell;
           SiteView.ShowModal;
         finally
           SiteView.Free;
         end;
      994, 3999:
         try
           ConstQuality := TdlgUADConstQuality.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           ConstQuality.FCell := doc.docActiveCell;
           ConstQuality.ShowModal;
         finally
           ConstQuality.Free;
         end;
      2109:
       if CheckOnly then
         Result := True
       else                                // 1004 & 2055 use different cell for attached project
         if IsResidReport(doc) then  // is this a residential (non-condo) report
           try
              MultiChkBox := TdlgUADMultiChkBox.Create(nil);          //create the dialog
              RefreshCurCell(doc);
              MultiChkBox.FCell := doc.docActiveCell;
              MultiChkBox.MainAddictSpell := Main.AddictSpell;
              doc.UADOverflowCheck := True;
              MultiChkBox.ShowModal;
            finally
              MultiChkBox.Free;
           end
         else
           try
             CondoDesignStyle := TdlgUADCondoDesignStyle.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             CondoDesignStyle.FCell := doc.docActiveCell;
             CondoDesignStyle.ShowModal;
           finally
             CondoDesignStyle.Free;
           end;
      //gitHub: Issue #14
      148, 149, 157, 2101, 2102, 986, 1808, 1827, 1846, 1865, 3998, 159, 160, 161: //include existing, proposed, and underconst
       if CheckOnly then
         Result := True
       else           // 1004 & 2055 use "# of Stories", not "Levels"
         if IsResidReport(doc) then  // is this a residential (non-condo) report
           try
             ResidDesignStyle := TdlgUADResidDesignStyle.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             ResidDesignStyle.FCell := doc.docActiveCell;
             ResidDesignStyle.ShowModal;
           finally
             ResidDesignStyle.Free;
           end
         else if doc.docActiveCell.FCellXID <> 148 then
           try
             CondoDesignStyle := TdlgUADCondoDesignStyle.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             CondoDesignStyle.FCell := doc.docActiveCell;
             CondoDesignStyle.ShowModal;
           finally
             CondoDesignStyle.Free;
           end;
      380..385, 2458:
       if CheckOnly then
         Result := True
       else           // 1073 & 1075 use "Levels", not "# of Stories"
         try
           CondoDesignStyle := TdlgUADCondoDesignStyle.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           CondoDesignStyle.FCell := doc.docActiveCell;
           CondoDesignStyle.ShowModal;
         finally
           CondoDesignStyle.Free;
         end;
      151, 996, 1809, 1828, 1847, 1866, 4000:
         try
           ProjYrBuilt := TdlgUADProjYrBuilt.Create(nil);          //create the dialog
           //ProjYrBuilt.FSalesDate := GetCellTextByActiveCell(doc, 960);
           //ProjYrBuilt.FDoc := doc;
           RefreshCurCell(doc);
           ProjYrBuilt.FCell := doc.docActiveCell;
           ProjYrBuilt.FDoc  := doc;  //Ticket #1436: bring in current active container
           ProjYrBuilt.ShowModal;
         finally
           ProjYrBuilt.Free;
         end;
      998, 2248, 1810, 1829, 1848, 1867, 4001:
       if CheckOnly then
         Result := True
       else
         try
           GridCondition := TdlgUADGridCondition.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           GridCondition.FCell := doc.docActiveCell;
           GridCondition.ShowModal;
         finally
           GridCondition.Free;
         end;
      200, 201, 208, 1006, 1008, 4006, 4007, 1815, 1834, 1853, 1872:
       if CheckOnly then
         Result := True
       else
         try
           Basement := TdlgUADBasement.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           Basement.FCell := doc.docActiveCell;
           if (Basement.ShowModal = mrOK) and (TBaseCell(doc.docActiveCell).FContextID > 0) then //PAM: Ticket #1370:  should only broadcast if it's for subject which is context id > 0
             begin
               doc.StartProcessLists;  //Ticket #1249: increment process count
                 Doc.BroadcastCellContext(168, Basement.FGridAreaText);      //broadcast to update extra comp pages
               doc.ClearProcessLists;  //Ticket #1249: when done broadcasting, decrement the count

               doc.StartProcessLists;   //Ticket #1249: increment process count
                 Doc.BroadcastCellContext(169, Basement.FGridRoomText);      //broadcast to update extra comp pages
               doc.ClearProcessLists;   //Ticket #1249: when done broadcasting, decrement the count
             end;
         finally
           Basement.Free;
         end;
      229..231, 1041..1043, 1047..1049, 1811..1813, 1830..1832, 1849..1851,
      1868..1870, 2230..2241, 2250..2261, 2335..2337, 2339..2341, 2343..2345,
      4002..4004:
       if CheckOnly then
         Result := True
       else
         try
           GridRooms := TdlgUADGridRooms.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           GridRooms.FCell := doc.docActiveCell;
           GridRooms.ShowModal;
         finally
           GridRooms.Free;
         end;
      2054, 2055, 2056:
        begin
         if CheckOnly then
           Result := True
         else
           try
             ContractAnalyze := TdlgUADContractAnalyze.Create(nil);          //create the dialog
             RefreshCurCell(doc);
             ContractAnalyze.FCell := doc.docActiveCell;
             ContractAnalyze.FCommentCell := doc.GetCellByID(2056);
             ContractAnalyze.MainAddictSpell := Main.AddictSpell;
             doc.UADOverflowCheck := True;
             ContractAnalyze.ShowModal;
           finally
             ContractAnalyze.Free;
           end;
        end;
      2048, 2049, 2057:
       if CheckOnly then
         Result := True
       else
         try
           ContractFinAssist := TdlgUADContractFinAssist.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           ContractFinAssist.FCell := doc.docActiveCell;
           ContractFinAssist.MainAddictSpell := Main.AddictSpell;
           doc.UADOverflowCheck := True;
           ContractFinAssist.ShowModal;
         finally
           ContractFinAssist.Free;
         end;
      2063, 2064, 2065:
       if CheckOnly then
         Result := True
       else
         try
           SubjDataSrc := TdlgUADSubjDataSrc.Create(nil);          //create the dialog
           RefreshCurCell(doc);
           SubjDataSrc.FCell := doc.docActiveCell;
           SubjDataSrc.MainAddictSpell := Main.AddictSpell;
           doc.UADOverflowCheck := True;
           SubjDataSrc.ShowModal;
         finally
           SubjDataSrc.Free;
         end;
    end;

  //github #180
  if not doc.UADEnabled and
    (doc.docActiveCell <> nil) and
    (doc.docActiveCell.CanEdit) then
  begin
    case doc.docActiveCell.UID.FormID of
      349,342,365,364,869:  //form 1004C and 1025 (including XListings, XComps)
        begin
           case doc.docActiveCell.FCellXID of
             976, 67: begin
                    try
                      SiteArea := TdlgUADSiteArea.Create(nil);          //create the dialog
                      RefreshCurCell(doc);
                      SiteArea.FCell := doc.docActiveCell;
                      SiteArea.ShowModal;
                    finally
                       SiteArea.Free;
                     end;
                  end;
           end;
        end;
    end;
  end;


end;

/// Set the UAD cell text and display its contents
procedure SetDisplayUADText(theCell: TBaseCell; CellText: String);
begin
  If theCell <> nil then
    begin
      theCell.SetText(CellText);
      theCell.Display;
      theCell.PostProcess;
    end;
end;

/// summary: Shows help for the dialog.
procedure ShowUADHelp(const HelpFileName, Caption: String; HelpType: Integer=0);
var
  HelpForm: TRichHelpForm;
begin
  HelpForm := TRichHelpForm.Create(nil);
  try
    case HelpType of
      1: HelpForm.LoadFormData('Federal Housing Administration', Caption)
    else
      HelpForm.LoadFormData('Uniform Appraisal DataSet', Caption);
    end;  
    HelpForm.LoadHelpFile(HelpFileName);
    HelpForm.ShowModal;
  finally
    HelpForm.Free;
  end;
end;

// Returns the linked comment, if any exist, otherwise simply return the cell's text
function GetUADLinkedComments(Doc: TContainer; UADCell: TBaseCell): String;
var
  Form: TDocForm;
  CommentCell: TWordProcessorCell;
  Paragraph: TParagraph;
  Cmnts: String;

  function GetSubjConditions(CellText: String; XID: Integer): String;
  // This function retrieves the subject condition code and kitchen & bathroom statuses
  //  from the cell when overflow comments are used.
  var
    PosIdx: Integer;
    Header: String;
  begin
    Result := '';
    if XID = 520 then
      begin
        PosIdx := Pos('See comments - ', CellText);
        if PosIdx > 0 then
          Result := Copy(CellText, 1, Pred(PosIdx));
      end;
  end;

  function GetComments(CellText, ParText: String): String;
  // This function looks for comments after the "See comments - [Heading]" in the paragraph.
  // It returns these for use if they are found.
  var
    PosIdx: Integer;
    Header: String;
  begin
    Result := '';
    PosIdx := Pos('See comments - ', CellText);
    if PosIdx > 0 then
      begin
        Header := Copy(CellText, (PosIdx + 15), Length(CellText));
        PosIdx := Pos(Header + char(kLFKey), ParText);
        if PosIdx = 1 then
          Result := Copy(ParText, Succ(Length(Header + char(kLFKey))), Length(ParText));
      end;
  end;

begin
  if TTextCell(UADCell).HasLinkedComments then
    begin
      Form := Doc.GetFormByOccurance(CUADCommentAddendum, 0, False);
      if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
        begin
          CommentCell := Doc.FindCellInstance(TTextCell(UADCell).LinkedCommentCell) as TWordProcessorCell;
          if CommentCell <> nil then
          begin
            Paragraph := CommentCell.FindFirstSectionPar(TTextCell(UADCell).LinkedCommentSection);
            if Assigned(Paragraph) then
              begin
                Result := Paragraph.ANSIText;
                if Result = '' then
                  Result := UADCell.Text
                else
                  begin
                    Cmnts := GetComments(UADCell.Text, Result);
                    // If comments are in the same paragraph use them and do not process the next paragraph.
                    if Length(Cmnts) > 0 then
                      Result := Cmnts
                    else
                      begin
                        Paragraph := Paragraph.nextpardown;
                        if Assigned(Paragraph) then
                          Result := GetSubjConditions(UADCell.Text, UADCell.FCellXID) + Paragraph.ANSIText
                        else
                          Result := UADCell.Text;
                      end;
                  end;
              end
            else
              Result := UADCell.Text;
          end
          else
            Result := UADCell.Text;
        end
      else
        Result := UADCell.Text;
    end
  else
    Result := UADCell.Text;
end;

// Forms the overflow text UAD heading to satisfy UCDP PDF requirements
function FormUADLinkedCmntText(IsUAD: Boolean; CellXID: Integer; Body, Heading: String): String;
var
  PosIdx{, PosIdx2}: Integer;
  FormedStr, TmpStr: String;
begin
  FormedStr := '';
  if IsUAD then
    case CellXID of
       520:
         begin
           PosIdx := Pos(';', Body);
           if PosIdx > 0 then
             begin
               FormedStr := Copy(Body, 1, PosIdx);
               TmpStr := Copy(Body, Succ(PosIdx), Length(Body));
               PosIdx := Pos(';', TmpStr);
               if PosIdx > 0 then
                 begin
                   FormedStr := FormedStr + Copy(TmpStr, 1, PosIdx);
                   if Copy(TmpStr, 1, Pred(PosIdx)) <> NoUpd15Yrs then
                     begin
                       TmpStr := Copy(TmpStr, Succ(PosIdx), Length(TmpStr));
                       PosIdx := Pos(';', TmpStr);
                       if PosIdx > 0 then
                         FormedStr := FormedStr + Copy(TmpStr, 1, PosIdx);
                     end;
                 end;
             end;
         end;
      2057:
        begin
          PosIdx := Pos(';', Body);
          if PosIdx > 0 then
            begin
              FormedStr := Copy(Body, 1, PosIdx);
              TmpStr := Copy(Body, Succ(PosIdx), Length(Body));
              PosIdx := Pos(';', TmpStr);
              if PosIdx > 0 then
                FormedStr := FormedStr + Copy(TmpStr, 1, PosIdx);
            end;
        end;
      2056, 2065, 2116:
        begin
          PosIdx := Pos(';', Body);
          if PosIdx > 0 then
            FormedStr := Copy(Body, 1, PosIdx);
        end;
    end;
  Result := FormedStr + Format(msgCommentsReferenceText, [Heading]);
end;

function ISUADAdjustCellChkOK(grid: TCompMgr2; theCell: TBaseCell): Integer;

  function GetAdjIndex(adjID: Integer): Integer;
  var
    adjIndex: Integer;
  begin
    result := -1;
    for adjIndex := low(AdjCellIDs[0]) to high(AdjCellIDs[0]) do
      if adjID = AdjCellIDs[0,adjIndex] then
        begin
          result := adjIndex;
          break;
        end;
  end;

const
  resOK = 0;
  resDescrDiffAdjEmpty = 1;
  resDescrSameAdj0 = 2;
  compAddrCellID = 925;
var
  subjDescr,compDescr: String;
  compNo: Integer;
  gridCoord: TPoint;
  adjCellID, descrCellID: Integer;
  isAdjEmpty, isSubjCompDescrSame: Boolean;
  adjIndex: Integer;
begin
  result := resOK;
  if not (theCell is TGridCell) then
    exit;
  if not isUADForm(theCell.UID.FormID) then
    exit;
  compNo := grid.GetCellCompID(thecell.UID,gridCoord);
  if CompNo < 0 then
    exit;
  if length(Trim(grid.Comp[compNo].GetCellTextByID(compAddrCellID))) = 0 then
    exit; //the comp is empty: no address
  adjCellID := theCell.FCellID;
  if adjcellID = 0 then
    exit;
  adjIndex := GetAdjIndex(adjCellID);
  if adjIndex < 0 then
    exit;
  descrCellID := AdjCellIDs[1,adjIndex];
  if descrCellID = 0 then
    exit;
  isAdjEmpty := length(trim(theCell.Text)) = 0;
  grid.GetSubject(descrCellID,subjDescr);
  compDescr := grid.Comp[compNo].GetCellTextByID(descrcellID);
  isSubjCompDescrSame := compareText(trim(subjDescr), trim(compDescr)) = 0;
  if AdjCellIDs[2,adjIndex] > 0 then  //not exeptional adjustment like sale financing
    if not isSubjCompDescrSame and isAdjEmpty then
      result := resDescrDiffAdjEmpty;
  if isSubjCompDescrSame and not isAdjEmpty and (GetValidNumber(trim(theCell.Text)) = 0) then
    result := resDescrSameAdj0;
end;

function CheckRuleMisMatch(FormList:BooleanArray; docForm:TDocFormList; var ReviewList,sl:TStringList; var ReviewGrid:TosAdvDbGrid):Integer;
const
  MainSubMisMatch = '** MAIN FORM DOES NOT MATCH WITH CERT PAGE OR XCOMP PAGE';
var
  i, aCertID, aXCompID, aXListingID, n: Integer;
  aCert, aXComp, aXListing:String;
  isCertError, isXCompError, isXListingError:Boolean;
begin
  try
  try
    result := 0;
    for i := 0 to (docForm.Count - 1) do
      if formList[i] then                                          //only selected forms
       sl.Add(IntToStr(docForm[i].frmInfo.fFormUID)); //this will include forms that user add in
//    SetLength(FMainFormExistArray, sl.count);
    SetLength(FMainFormExistArray, high(MainFormIDArray)+1);
    for i:= 0 to sl.count-1 do
       if GetMainFormIndex(strToIntDef(sl[i],0)) > 0 then
         break;
    //init the 3 flags to false
    IsCertError := False;
    IsXCompError := False;
    IsXListingError := False;

//    for i:= low(FMainFormExistArray) to high(FMainFormExistArray) do
    for i:= low(MainFormIDArray) to high(MainFormIDArray) do //walk through the MainFormIDArray
    begin
//      if CompareText(FMainFormExistArray[i],'Y')=0 then //we have main form
      if (i <= high(FMainFormExistArray)) and  (CompareText(FMainFormExistArray[i],'Y')=0) then
      begin
         //Mismatch Cert Page?
         aCertID:=GetPageID(tCert,i);    //use the index to locate the cert page
         if aCertID<>0 then  //ignore 0, the 0 here means there's no cert page or not avail for the main form
         begin
           aCert:=IntToStr(aCertID);
           //check if other cert in the list, give error
           if sl.Indexof(aCert)=-1 then
              IsCertError := TestOtherPages(tCert,i,docForm,formList);
         end;
         //Mismatch XComp Page?
         aXCompID:=GetPageID(tXComp,i);    //use the index to locate the XComp page
         if aXCompID<>0 then //ignore 0, the 0 here means there's no xcomp page or not avail for the main form
         begin
           aXComp:=IntToStr(aXCompID);
           //check if other cert in the list, gives error
           if sl.Indexof(aXComp)=-1 then
              IsXCompError := TestOtherPages(tXComp,i,docForm,formList);
         end;
         //Mismatch XListing Page?
         aXListingID:=GetPageID(tXListing,i);    //use the index to locate the XListing page
         if aXListingID<>0 then  //ignore 0, the 0 here means there's no xlisting page or not avali for the main form
         begin
           aXListing:=IntToStr(aXListingID);
           //check if other cert in the list, give error
           if sl.Indexof(aXListing)=-1 then
              IsXListingError := TestOtherPages(tXListing,i,docForm,formList);
         end;
         if isCertError or isXCompError or isXListingError then //if any one of this fails, gives error
         begin
           for n := 0 to docForm.count-1 do //loop through to get the index of the form #
             if (docForm[n].frmInfo.fFormUID = MainFormIDArray[i]) then
               break;
           AddRecord(ReviewList,ReviewGrid,MainSubMisMatch, n,1,1,docForm);  //n is the form #, 1,1 is page 1 cell 1
           inc(result);
         end;
      end;
    end;
  finally
    Finalize(FMainFormExistArray);   //we are done with the array.
    Finalize(FormList);
  end;
  except on E:Exception do end; //if something wrong, keep going
end;

procedure AddRecord(var ReviewList:TStringList; var ReviewGrid:TosAdvDbGrid; text: String; frm, pg,cl: Integer;docForm:TDocFormList);
var
  curCellID: TCellID;
  i: integer;
  criticalErr: Boolean;
  theErrWarn: String;
begin
  if (pos('=====',text)<1) and (text<>'') and (pg>-1) and (frm>-1) then
    begin
      criticalErr := (Pos('**', text)= 1);
      if criticalErr then
        theErrWarn := Text    //keep ** in the grid
      else
        theErrWarn := Text;

      if theErrWarn <> '' then
        begin
          ReviewGrid.Rows := ReviewGrid.Rows + 1;   //Review MUST start at 0 rows
          i := ReviewGrid.Rows;

          curCellID := TCellID.Create;
          curCellID.Form := frm;
          curCellID.Pg := pg;
          curCellId.Num := cl;

          ReviewList.AddObject(theErrWarn, curCellID);    //so we can locate the cell accurately

          if criticalErr then          //set the global ReviewErr flag
            begin
              FReviewErrFound := True;
              Inc(FCriticalErrCount);
            end;
          ReviewGrid.Cell[colForm,i] := docForm[frm].frmInfo.fFormName;
          ReviewGrid.Cell[colPg,i] := IntToStr(Pg);
          ReviewGrid.Cell[colCell,i] := IntToStr(cl);
          ReviewGrid.Cell[colErrorMessage,i] := theErrWarn;
          if criticalErr then
            ReviewGrid.RowColor[i] := CriticalError_Color;
          AdjustGridHeigh(ReviewGrid,colErrorMessage,i);   //readjust the height of the error message column to fit long message
          ReviewGrid.Repaint;
        end;
    end;
end;

procedure AdjustGridHeigh(var Grid:TosAdvDBGrid; aCol,aRow:Integer);
var
  aTextWidth,aColWidth: Integer;
  aText:String;
begin
  //go through grid column with the current row to find the max text width for that row
  aText := Grid.Cell[aCol,aRow];
  aTextWidth := Grid.Canvas.TextWidth(aText);
  acolWidth  := Grid.Col[aCol].Width;
  if aTextWidth  > acolWidth then
  begin
      Grid.RowHeight[aRow]   := Pred(Round(aTextWidth / aColWidth)) * Trunc(Grid.RowOptions.DefaultRowHeight / 2) + Grid.RowOptions.DefaultRowHeight;
      Grid.RowWordWrap[aRow] := wwOn;
  end;
end;


//This will get page id that's associated with the main form.
function GetPageID(pType: TPageType; aMainFormIdx:Integer):Integer;
var i:integer;
begin
   result := 0;
   case pType of
     tCert:  begin
               for i:=low(CertPageIDArray) to high(CertPageIDArray) do
               begin
                 if (i = aMainFormIdx) and (CertPageIDArray[i]<>0) then
                 begin
                   result := CertPageIDArray[i];
                   Break;
                 end;
               end;
             end;
     tXComp: begin
               for i:=low(XCompPageIDArray) to high(XCompPageIDArray) do
               begin
                 if (i = aMainFormIdx) and (XCompPageIDArray[i]<>0) then
                 begin
                   result := XCompPageIDArray[i];
                   Break;
                 end;
               end;
            end;
     tXListing: begin
                   for i:=low(XListingPageIDArray) to high(XListingPageIDArray) do
                   begin
                     if (i = aMainFormIdx) and (XListingPageIDArray[i]<>0) then
                     begin
                       result := XListingPageIDArray[i];
                       Break;
                     end;
                   end;
                end;
     end;
end;

//This will return the index of the MainFormIDArray based on the main form id.
function GetMainFormIndex(RevFileID:Integer):Integer;
var i:integer;
begin
   result := 0;
   for i:=low(MainFormIDArray) to high(MainFormIDArray) do
   begin
     if MainFormIDArray[i]=RevFileID then // we found main form id that matches with revfileid
     begin
       FMainFormExistArray[i]:='Y'; //set the flag on in the MainFormExistArray
       result := i;
       Break;
     end;
   end;
end;

//This will return true if the ID is a condominium form.
function IsCondoForm(theFormID:Integer): Boolean;
var
  Idx: Integer;
begin
   Idx := -1;
   repeat
     Idx := Succ(Idx);
     Result := (CondoFormIDArray[Idx] = theFormID);
   until Result or (Idx = MaxCondoForms);
end;

function TestOtherPages(pType: TPageType; idx:Integer; docForm:TDocFormList; formList:BooleanArray):Boolean;
var i,n:integer;
    PageArray: Array of Integer;
begin
  result := False;
  try
    SetLength(PageArray,length(CertPageIDArray)); //all the page array has the same # of ids
    case pType of
      tCert: begin
                for i:=low(CertPageIDArray) to high(CertPageIDArray) do
                  PageArray[i]:=CertPageIDArray[i];
             end;
      tXComp: begin
                for i:=low(XCompPageIDArray) to high(XCompPageIDArray) do
                  PageArray[i]:=XCompPageIDArray[i];
              end;
      tXListing: begin
                  for i:=low(XListingPageIDArray) to high(XListingPageIDArray) do
                    PageArray[i]:=XListingPageIDArray[i];
                end;
    end;
    for i:= low(PageArray) to high(PageArray) do
    begin
       if i = idx then //skip the same item
         continue;
       for n := 0 to docForm.count-1 do
         if (docForm[n].frmInfo.fFormUID = PageArray[i]) and (formList[n]) then
         begin
            result := True;
            exit;
         end;
    end;
  finally
    Finalize(PageArray);
  end;
end;

// capture the current cell, switch to no cell and return to refresh the contents
procedure RefreshCurCell(Doc: TContainer);
var
  CurCell: TBaseCell;
  CurPageIdx, CursorPos: Integer;
begin
  if assigned(doc) then
    begin
      CurCell := Doc.docActiveCell;
      if Assigned(CurCell) and (not (CurCell is TWordProcessorCell)) then
        begin
          // Capture the current Page Manager page and the cursor position
          CurPageIdx := doc.PageMgr.ItemIndex;
          if (doc.docEditor <> nil) and (doc.docEditor is TTextEditor) then
            CursorPos := (doc.docEditor as TTextEditor).CaretPosition;

          // Switch out and back into the current cell to refresh
          Doc.Switch2NewCell(nil, True);
          Doc.Switch2NewCell(CurCell, True);

          // Restore the current Page Manager page and the cursor position
          if (doc.docEditor <> nil) and (doc.docEditor is TTextEditor) then
            (doc.docEditor as TTextEditor).SetCaretPosition(CursorPos);
          doc.PageMgr.ItemIndex := CurPageIdx;
      // Restore the page position so the current cell is in view;
      //  otherwise the view is at the page top & the cell may not be in view.
      Doc.docStartingCellUID := CurCell.UID;
      Doc.SetupForInput(False);
        end;
    end;
end;


// This will ensure that condition changes are propogated to the subject
//  property's condition cell.
procedure UADPostProcess(Doc: TContainer; PrevCell, CurCell: TBaseCell);
const
  CXID_SUBJECT_PROPERTY_CONDITION = 142;
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;
var
  TmpStr, str1, str2: String;
  PosIdx: Integer;
  UADAltCell: TBaseCell;
  cellTxt: String;
  iNum, iNum2: Integer;
  UADObject: TUADObject;
  siteArea: Double;
  PosItem: Integer;
  dw, cp, ga: String;
begin
  // only the subject grid cell has a context ID
  if not assigned(PrevCell) then exit;
  if Doc.UADEnabled and (PrevCell <> nil) then
    case PrevCell.FCellXID of
      520:
        if (Length(PrevCell.Text) > 2) and (PrevCell.Text[3] = ';')  then
          begin
            TmpStr := Copy(PrevCell.Text, 1, 2);
            if AnsiIndexText(TmpStr, ConditionListTypCode) >= 0 then
              Doc.BroadcastCellContext(CXID_SUBJECT_PROPERTY_CONDITION, TmpStr);
          end;
      998: //condition
        if (PrevCell.FContextID > 0) then
          begin
            UADAltCell := Doc.GetCellByID(520);
            if Assigned(UADAltCell) and (PrevCell.Text <> Copy(UADAltCell.GetText, 1, 2)) then
              begin
                UADAltCell.DoSetText(PrevCell.Text  + Copy(UADAltCell.GetText, 3, Length(UADAltCell.GetText)));
                Doc.Switch2NewCell(UADAltCell, False);
                Doc.Switch2NewCell(CurCell, False);
              end;
          end;
      end;

 //************* start with appPref_UADAutoConvert
   if doc.UADEnabled and appPref_UADAutoConvert then
     begin
       UADObject := TUADOBject.Create(doc);
       try
        case PrevCell.FCellXID of
         67: //subject site area
           begin
             if (length(PrevCell.Text) > 0)  then
              begin
                cellTxt := PrevCell.Text;
                SiteArea := GetStrValue(cellTxt);
                if (SiteArea > 0) and (cellTxt <> '') then
                begin
                  PosItem := Pos('ACRE', Uppercase(cellTxt));
                  if PosItem = 0 then
                    PosItem := Pos('AC', Uppercase(cellTxt));
                  if (PosItem > 0) then
                    cellTxt := Trim(SysUtils.Format('%-20.2f',[SiteArea])) + ' ' + cAcres
                  else
                    // assume square feet
                    begin
                      if SiteArea >= cAcre then
                        cellTxt := Trim(SysUtils.Format('%-20.2f', [SiteArea / cAcre])) + ' ' + cAcres
                      else
                        cellTxt := Trim(SysUtils.Format('%-20.0f', [SiteArea])) + ' ' + cSqFt;
                    end;
                  PrevCell.Text := StringReplace(cellTxt, ',', '', [rfReplaceAll]);
                  PrevCell.Display;   //refresh
                  doc.SetCellTextByID(976, cellTxt); //populate to cell 976 on the grid
                end;
            end;
           end;
         90: //subject view
           begin
            //github 237
            if (PrevCell.Text <> '') then //github 237
               begin
                 PrevCell.Text := ConvertUAD_Cell90(PrevCell, Doc);
                 PrevCell.HasValidationError := (PrevCell.Text = '');
                 PrevCell.Display;   //refresh
                 doc.SetCellTextByID(984, PrevCell.Text); //populate to cell 984 on the grid
               end
           end;
         148, 157, 2101, 2102, 149: //subject design
           begin
             ConvertUAD_cellSubjectDesign(PrevCell, Doc);
           end;

         151: //year build use year build to calculate age 996
           begin //recalculate the actual age on the subject grid
            if (PrevCell.Text <> '') then //github 237
               begin
                 cellTxt := PrevCell.Text;
                 iNum := GetValidInteger(cellTxt);
                 iNum2 := 0;
                 if iNum > 0 then
                   begin
                     TmpStr := Doc.GetCellTextByID(1132);
                     if length(tmpStr) > 0 then
                       iNum2 := YearOf(StrToDate(TmpStr)) - iNum //eff year - year build
                     else
                       iNum2 := YearOf(Date) - iNum;  //current year - year build
                     TmpStr := Format('%d',[iNum2]);
                     doc.SetCellTextByID(996, TmpStr);
                   end;
               end;
           end;
         200, 201: //bsmt gla and bsmt fgla %
           begin
             str1 := doc.GetCellTextByID(200);
             str2 := doc.GetCellTextByID(201);
             if (length(str1) = 0) and  (length(str2)=0) then
               begin
                 doc.SetCellTextByID(1006, '0sf');
                 doc.SetCellTextByID(200, '0');
                 doc.SetCellTextByID(201, '0');
               end;
           end;
         332, 333, 334, 335: //332=patio check box  333=patio count 334=porch ckbox 335=porch count
           begin
             str1 := ''; str2 := ''; tmpstr := '';
             //if check box is checked load the count to subject patio count on cell 1018
             if doc.GetCellTextByID(332) = 'X' then
               str1 := doc.GetCellTextByID(333);  //this is patio count
            // else
            //   str1 := 'None';   //github #371: empty porch not set to NONE
             if doc.GetCellTextByID(334) = 'X' then
               str2 := doc.GetCellTextByID(335);
            // else
            //   str2 := 'None';  //github #371: empty porch not set to NONE
             if (str1 <> '') and (str2 <> '') then
               TmpStr := Format('Porch/%s,Patio,Deck/%s',[str2, str1])
             else if (str1 <> '') then
               TmpStr := Format('Patio,Deck/%s',[str1])
             else if (str2 <> '')  then
               TmpStr := Format('Porch/%s',[str2]);
             //else
             //  TmpStr := 'None'; //github #371: empty porch not set to NONE
             if TmpStr <> '' then
               doc.SetCellTextByID(1018, TmpStr);
           end;
         339, 340: //Pool 339:pool check box, 340 pool count
           begin
             //if check box is checked load the pool count to subject pool count on cell 1022
             if doc.GetCellTextByID(339) = 'X' then
               doc.SetCellTextByID(1022, doc.GetCellTextByID(340));
           end;
         359, 360, //drive way
         349, 2030, 2070, 2071, 2072, //garage 2070: att, 2071: det, 2072: builtin
         2657, 355: //carport
           begin
             dw := ''; cp:=''; ga:='';
             if (doc.GetCellTextByID(359) = 'X') and (GetValidInteger(doc.GetCellTextByID(360)) > 0) then
               dw := Format('%ddw',[GetValidInteger(doc.GetCellTextByID(360))]);
             if (doc.GetCellTextByID(349) = 'X') and (GetValidInteger(doc.GetCellTextByID(2030)) > 0) and
                (doc.GetCellTextByID(2070) = 'X') then
               ga := Format('%dga',[GetValidInteger(doc.GetCellTextByID(2030))])
             else if (doc.GetCellTextByID(349) = 'X') and (GetValidInteger(doc.GetCellTextByID(2030)) > 0) and
                (doc.GetCellTextByID(2071) = 'X') then
               ga := Format('%dgd',[GetValidInteger(doc.GetCellTextByID(2030))])
             else if (doc.GetCellTextByID(349) = 'X') and (GetValidInteger(doc.GetCellTextByID(2030)) > 0) and
                (doc.GetCellTextByID(2072) = 'X') then
               ga := Format('%dgbi',[GetValidInteger(doc.GetCellTextByID(2030))]);
             if (doc.GetCellTextByID(2657) = 'X') and (GetValidInteger(doc.GetCellTextByID(355)) > 0) then
               cp := Format('%dcp',[GetValidInteger(doc.GetCellTextByID(355))]);
             str1 := '';
             if ga<>'' then
               str1 := ga;
             if cp <> '' then
               str1 := str1 + cp;
             if dw <> '' then
               str1 := str1 + dw;
             str1 := trim(str1);
             if str1 <> '' then
               doc.SetCellTextByID(1016, str1); //set cell 1016 garage carport
           end;
         520: //Condition
           begin
             if PrevCell.Text <> '' then
               begin
                 PrevCell.Text := UADObject.TranslateToUADFormat(nil, 520, PrevCell.Text);
                 PrevCell.Display;   //refresh
                 PrevCell.HasValidationError := (PrevCell.Text = '');
               end
           end;

        2056:
          begin
            //github 237
            if (PrevCell.Text <> '') then //github 237
               begin
                 PrevCell.Text := ConvertUAD_Cell2056(PrevCell, Doc);
                 PrevCell.Display;   //refresh
                 PrevCell.HasValidationError := (PrevCell.Text = '');
               end
          end;
        2057:
          begin
            //github 237
            if (PrevCell.Text <> '') then //github 237
               begin
                 PrevCell.Text := ConvertUAD_Cell2057(PrevCell, Doc);
                 PrevCell.Display; //refresh;
                 PrevCell.HasValidationError := (PrevCell.Text = '');
               end
          end;
        2065:
          begin
            //github 237
            if (PrevCell.Text <> '') then //github 237
               begin
                 PrevCell.Text := ConvertUAD_Cell2065(PrevCell, Doc);
                 PrevCell.Display; //refresh;
                 PrevCell.HasValidationError := (PrevCell.Text = '');
               end
          end;
      end;
     finally
       if assigned(UADObject) then
         FreeAndNil(UADObject);
     end;
    end;
end;

function UADTextWillOverflow(theCell: TBaseCell; theText: String): Boolean;
begin
  if (theCell is TMLnTextCell) then
    begin
      theCell.SetText(theText);
      (theCell as TMLnTextCell).CheckTextOverflow;
      Result := IsBitSet(theCell.FCellStatus, bOverflow);
    end
  else
    Result := False;
end;

procedure GetChangeList(CompTable: TCompMgr2; var cList: TStringList); //Check Sales Comp
var
  CompID: Integer;
  CompCol: TCompColumn;
  baseCell: TBaseCell;
  cStr: String;
  i, fldID: Integer;
begin
  for CompID := 0 to CompTable.Count - 1 do //go through sales comp
    for i:=0 to MaxUADGridXID -1 do
      begin
        fldID := UADGridXID[i];
        CompCol := CompTable.Comp[CompID];
        baseCell := CompCol.GetCellByID(fldID);
        if assigned(baseCell) and baseCell.Modified then
          begin
            if CompID = 0 then //this is subject
              cStr := Format('Subject%d',[CompID])
            else
              cStr := Format('%s%d',[CompTable.GridName,CompID]);
            cList.Add(cStr);
            break;
          end;
      end;
end;


function GridUADCellIsModified(var cList:TStringList): Boolean;
var
  FDocCompTable, FDocListTable: TCompMgr2;
  doc: TContainer;
begin
  try
    doc := Main.ActiveContainer;

    //Build sales comp grid structure
    FDocCompTable := TCompMgr2.Create(True);
    FDocCompTable.BuildGrid(doc, gtSales);

    //Build Listing comp grid structure
    FDocListTable := TCompMgr2.Create(True);
    FDocListTable.BuildGrid(doc, gtListing);

    GetChangeList(FDocCompTable, cList); //Check Sales Comp
    GetChangeList(FDocListTable, cList); //Check Listing Comp

    result := True;  //always return true and we check for the cList
  finally
    FDocCompTable.Free;
    FDocListTable.Free;
  end;
end;

//Pam 12/04/2015: gitHub #154: This function will return the text for the passing cell id base on the
//current active cell, we compare the active cell with the cell for each comp on the grid
//if match then do a getcellbyid within the same column.
function GetCellTextByActiveCell(doc: TContainer; cellID: Integer): String;
var
  grid: TCompMgr2;
  aCell, CurCell: TBaseCell;
  i: integer;                                    
begin
  result := '';
  if not assigned(doc) then exit;
  CurCell := doc.docActiveCell;  //get the current active cell
  if not assigned(CurCell) then exit;
  grid := TCompMgr2.Create;
  try
    grid.BuildGrid(doc, gtSales);   //create and build the grid for sales
    if grid.Count = 0 then
      grid.BuildGrid(doc, gtListing);  //if no sales then create listings
    if grid.Count = 0 then
      exit;
    for i:= 0 to grid.Count - 1 do  //walk through the grid
      begin
        aCell := grid.Comp[i].GetCellByID(CurCell.FCellID);   //get the active cell from the grid
        if not assigned(aCell) then continue;
        if (CurCell.UID.Num = aCell.UID.Num) and   //if active cell matches with the cell on the grid
           (CurCell.UID.Pg = aCell.UID.Pg) and
           (CurCell.UID.Form = aCell.UID.Form) and
           (CurCell.FCellID = aCell.FCellID) then
          begin
            result := grid.Comp[i].GetCellTextByID(CellID); //we are in the same column grid, get text for the desired cell
            break; //we are done.
          end;
     end;
  finally
    grid.Free;
  end;
end;

procedure SetbathCellFormat(tmpStr: String; var theCell: TBaseCell);
var
  posIdx: Integer;
begin
  if tmpStr = '' then exit;
  if not assigned(theCell) then exit;
  PosIdx := Pos('.', tmpStr);
  if (PosIdx = 0) or (round(GetValidNumber(Copy(tmpStr, Succ(PosIdx), Length(tmpStr)))) < 9) then
    begin
      theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P2);    //clear round to 0.01
      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1);    //round to 0.1
    end
  else
    begin
      theCell.FCellFormat := ClrBit(theCell.FCellFormat, bRnd1P1);   //clear round to 0.1
      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);   //round to 0.01
    end;
end;


//github 237: Convert to match with Redstone push down data format
function PrefetchUADObject(aCellID:Integer; aCellTxt:String): String;
const
  atDetached    = 1;
  atAttached    = 2;
  atEndUnit     = 3;

  SEP           = ';';
  vSEP          = '|';
var
  aTmpStr, sDesign, sStories, aStyle: String;
  sBsmGLA, sBsmFGLA, sAccess: String;
  iDesign, iStories, idx: Integer;
  iBsmGLA: Integer;
  iBsmFGLA: Double;
  aMLS, aDOM, str1, str2: String;
begin
  result := aCellTxt;
  case aCellID of
    930: //DOM data source: the format is: DOM;datasource
      begin  //we need to put data source first then DOM to match with Redstone data format
        aTmpStr := aCellTxt;
        if pos(SEP, aTmpStr) > 0 then //we have more than one field
          begin
            str1 := popStr(aTmpStr, SEP); //it can be data source
            if (pos('MLS', uppercase(str1)) > 0) or (pos('#', str1)>0)  then //this is data source
              begin
                if pos('MLS#', upperCase(aCellTxt)) = 0 then
                  result :='MLS#'+aCellTxt
                else
                  result := aCellTxt;
              end
            else
              begin  //this is DOM
                //is unkown DOM?
                if pos('UNK', upperCase(str1)) > 0 then
                  aDOM := 'Unk'
                else
                  aDom := str1;

                if (pos('MLS#', upperCase(aTmpStr)) = 0) and (pos('MLS', upperCase(aTmpStr))>0) then //this is a MLS
                    result := Format('MLS#%s%s%s',[aTmpStr, SEP, aDOM])//mls123231;dom
                else
                  result := Format('%s%s%s',[aTmpStr, SEP, aDOM]);//datasr123231;dom
              end;
          end;
      end;

    986: //Design: the format is: Design;stories;style
      begin
        aTmpStr := aCellTxt;
        iDesign := 0;  //github #412: initialize idesign first
        iStories := 0;
        if pos(SEP,aTmpStr) > 0 then
          begin
            sDesign := popStr(aTmpStr, SEP);
            sDesign := UpperCase(sDesign); //design: 0=Detach; 1 = Attach; 2 = Semi-detach
            if (pos('DETACH', sDesign) > 0) or (pos('DT', sDesign) > 0) then
              iDesign := atDetached
            else if (pos('ATTACH', sDesign) > 0) or (pos('AT', sDesign) > 0) then
              iDesign := atAttached
            else if (pos('SEMI', sDesign) > 0) or (pos('SD', sDesign) > 0) then
              iDesign := atEndUnit;
            iStories := GetValidInteger(sDesign); //user may enter DT3
          end;

         if pos(SEP, aTmpStr) > 0 then
          begin
            sStories := popStr(aTmpStr, SEP);
            iStories := GetValidInteger(sStories);
          end;
        //style
         if pos(SEP, aTmpStr) > 0 then
           begin  //handle style;exis=ting
             aStyle := popStr(aTmpStr, SEP);
             if pos('EXIST', aTmpStr) > 0 then
               sAccess :='Existing'
             else if pos('PROPOSE', aTmpStr) > 0 then
               sAccess := 'Proposed'
             else if pos('UNDER CONST', aTmpStr) > 0 then
               sAccess := 'Under Construction';
           end
         else
           aStyle := aTmpStr;
        if sAccess <> '' then //has access
          result := Format('%d%s%d%s%s%s%s',[iDesign,vSEP, iStories, vSEP, sAccess, vSEP,aStyle])
        //else
        //  result := Format('%d%s%d%s%s',[iDesign,vSEP, iStories, vSEP,aStyle])
        else if (sDesign <> '') and (aStyle <> '')  then
          result := Format('%s;%s',[sDesign,aStyle])
        else if sDesign <> '' then
          result := sDesign
        else //github #412
          result := aStyle;
      end;
    1006: //basement. Input format: bmtGLA;bmtfinish;access or bmtgla;bmtfinish%;access or 0
      begin
        aTmpStr := aCellTxt;
        if pos(SEP, aTmpStr) = 0 then //no seperator, no conversion
          begin
//            iBsmGLA := Round(GetStrValue(aTmpStr));
//            result := Format('%d',[iBsmGLA]);
            exit;
          end
        else
          begin  //get bsmGLA
            sBsmGLA := popStr(aTmpStr, SEP);
            iBsmGLA := GetValidInteger(sBsmGLA);
          end;
        //look for BsmFGLA
        if pos(SEP, aTmpStr) > 0 then
          begin
            sBsmFGLA := popStr(aTmpStr, SEP);
          end
        else
          sBsmFGLA := aTmpStr;

        if pos('%', sBsmFGLA) > 0 then //finish GLS is in %
          begin
            iBsmFGLA := GetStrValue(sBsmFGLA);
            iBsmFGLA := round(ibsmGLA * (iBsmFGLA/100));
          end
        else
          begin
            iBsmFGLA := GetStrValue(sBsmFGLA);
          end;

        //look for access
        if aTmpStr<>'' then
          begin
            sAccess := UpperCase(aTmpStr);
            if (pos('WALK OUT', sAccess) >0)  or (pos('WO', sAccess) > 0) then
              sAccess := 'wo'
            else if (pos('WALK UP', sAccess) >0) or (pos('WU', sAccess) > 0) then
              sAccess := 'wu'
            else if (pos('INTER', sAccess) >0) or (pos('IN', sAccess) > 0) then
              sAccess := 'in';
          end;
        if sAccess <> '' then
          result := Format('%d%s%d%s%s',[iBSMGLA, vSEP, round(iBsmFGLA), vSEP, sAccess])
        else
          result := Format('%d%s%d',[iBSMGLA, vSEP, round(iBsmFGLA)]);
      end;
   else  //replace ; with |
     begin
       if pos(SEP, aCellTxt) > 0 then
         StringReplace(aCellTxt, SEP, vSEP, [rfReplaceAll]);
     end;
  end;
end;

(*
function SetDateFormatByValue(var aDateValue:String; var AFormatSettings:TFormatSettings):String;
var
  mm,dd,yy: String;
  p, iMonth, iDay, iYear: Integer;
  aDateTime: TDateTime;
begin
  result := AFormatSettings.ShortDateFormat;
  if (pos(' ', aDateValue) > 0) and (pos(':', adateValue) > 0) then //we have time stamp, get rid of the time
    aDateValue := popStr(aDateValue, ' ');
  if pos('-', adateValue) > 0 then
    begin
      aDateValue := StringReplace(aDateValue,'-','/',[rfReplaceAll]);
    end;
  if pos('/', aDateValue) > 0 then
    begin
      p:= pos('/', aDateValue);
      case p of
        2..3: result := 'M/d/yyyy';
        5: result := 'yyyy/m/d';
      end;
      if (length(aDateValue) <= 8) and (pos('/', aDateValue) < 4) then //this is mm/dd/yy or yy/mm/dd
        begin
          if tryStrToDate(aDateValue, aDateTime,AFormatSettings) then
            aDateValue := DateToStr(aDateTime);
          result := 'M/d/yyyy';
        end;
    end
  else
    begin
      result := AFormatSettings.LongDateFormat;
    end;
end;
*)

//github #370
(*
function ConvertDateStr(aDateStr:String; var aDate:TDateTime;  useNewDateFormat:Boolean=True):String;
var
  DateType: Integer;
  AFormatSettings:TFormatSettings;
  aShortDateFormat,NewDateFormat: String;
  ALocaleID: integer;

begin
  GetLocaleFormatSettings(ALocaleID, AFormatSettings); //get the local date format
  aShortDateFormat := AFormatSettings.ShortDateFormat; //save the existing short date format

  NewDateFormat := SetDateFormatByValue(aDateStr,AFormatSettings);
  AFormatSettings.ShortDateFormat:= NewDateFormat;    //set the local date format to match with the format we want to convert
  if IsValidDateTimeWithDiffSeparator2(aDateStr, ADate, aFormatSettings) then
  begin
   if useNewDateFormat then
      result := FormatDateTime(NewDateFormat, ADate)
    else
      result := FormatDateTime('mm/dd/yyyy', ADate);  //github #370
  end
  else
   if TryStrToDate(aDateStr, ADate) then
     begin
       result := aDateStr;
     end;
end;
*)

//https://github.com/Bradtech302/ClickFORMs/issues/1602#event-2523744720
function ConvertDateStr(aDateStr:String; var aDateTime:TDateTime; silent:Boolean=True):String;
begin
  result := '';
  if pos('-',aDateStr) > 0 then
    aDateStr := StringReplace(aDateStr,'-','/',[rfReplaceAll]); //in case the date is in mm-dd-yyyy, replace with mm/dd/yyyy
   if isValidDate(aDateStr,aDateTime,silent) then //always keep silient
    result := aDateStr;
end;


function AbbreviateViewFactor(str: string): String;
begin
  result := str;  // if nothing match, use the original string coming in
  str := lowercase(str);
  if pos('res', str) > 0 then
    result := 'Res'
  else if pos('water', str) > 0 then
    result := 'Wtr'
  else if pos('golf', str) > 0 then
    result := 'Glfvw'
  else if pos('park', str) > 0 then
    result := 'Prk'
  else if pos('pastoral', str) > 0 then
    result := 'Pstrl'
  else if pos('wood', str) > 0 then
    result := 'Woods'
  else if pos('skyline', str) > 0 then
    result := 'CtySky'
  else if pos('mountain', str) > 0 then
    result := 'Mtn'
  else if pos('city street', str) > 0 then
    result := 'CtyStr'
  else if pos('industrial', str) > 0 then
    result := 'Ind'
  else if pos('power lines', str) > 0 then
    result := 'PwrLn'
  else if pos('powerlines', str) > 0 then
    result := 'PwrLn'
  else if pos('limited sight', str) > 0 then
    result := 'LtdSght'
  else if pos('comm', str) > 0 then
    result := 'Comm'
  else if pos('busy', str) > 0 then
    result := 'BsyRd'
  else if pos('land', str) > 0 then
    result := 'Lndfl'
  else if pos('adjac', str) > 0 then
    result := 'AdjPark'
  else if pos('transport', str) > 0 then
    result := 'PubTrn'
  else if pos('city view', str) > 0 then
    result := 'CtyView'
  else if pos('other', str) > 0 then
    result := 'Other';
end;

function MakeFullViewLocFactor(str:String):String;
begin
  result := str;  // if nothing match, use the original string coming in
  str := lowercase(str);
  if pos('res', str) > 0 then
    result := 'Residential View'
  else if pos('wtr', str) > 0 then
    result := 'Water View'
  else if pos('glfvw', str) > 0 then
    result := 'Golf Course View'
  else if pos('prk', str) > 0 then
    result := 'Park View'
  else if pos('pstrl', str) > 0 then
    result := 'Pastoral View'
  else if pos('woods', str) > 0 then
    result := 'Woods View'
  else if pos('comm', str) > 0 then
    result := 'Commercial'
  else if pos('ctySky', str) > 0 then
    result := 'City View SkyLine'
  else if pos('mtn', str) > 0 then
    result := 'Mountain View'
  else if pos('ctyStr', str) > 0 then
    result := 'City Street View'
  else if pos('ind', str) > 0 then
    result := 'Industrial View'
  else if pos('pwrLn', str) > 0 then
    result := 'Power Lines'
  else if pos('ltdSght', str) > 0 then
    result := 'Limited Sight'
  else if pos('bsyRd', str) > 0 then
    result := 'Busy Road'
  else if pos('lndfl', str) > 0 then
    result := 'LandFill'
  else if pos('adjpark', str) > 0 then
    result := 'Adjacent To Park'
  else if pos('pubtrn', str) > 0 then
    result := 'Public Transportation'
  else if pos('other', str) > 0 then
    result := 'Other';
end;

function EmptyCellValue(cellValue: String):Boolean;
begin
//  result := True;
  result := False;
  if cellValue = '' then
    result := True
  else
    begin
      cellValue := trim(cellValue);
      if (pos('0', cellValue) > 0) and (length(cellValue)=1) then
        result := True;
    end;
end;

function CalcBsmtPercent(bsmtGLA, bsmtFGLA:String):Integer;
var
  iGLA, iFGLA: Integer;
begin
  result := 0;
  iGLA := GetValidInteger(bsmtGLA);
  iFGLA := GetValidInteger(bsmtFGLA);
  if iGLA = iFGLA then
    result := 100
  else if (iGLA > 0) then
    begin
      if (iFGLA > 0) then
        result := Round((iFGLA/iGLA) * 100);
    end
end;


procedure SetCellValueUAD(doc: TContainer; cellID: Integer; cellValue: string;FOverride:Boolean=True);
var
  f,p,c: Integer;
  aCell: TBaseCell;
  aStr: String;
  aInt, aInt2: Integer;
  GeoCodedCell: TGeocodedGridCell;
begin
  if cellValue = '' then exit;
  for f := 0 to doc.docForm.count-1 do
    for p := 0 to doc.docForm[f].frmPage.count-1 do
      if assigned(doc.docForm[f].frmPage[p].PgData) then  //does page have cells?
      for c := 0 to doc.docForm[f].frmPage[p].PgData.count-1 do
        begin
          aCell := doc.docForm[f].frmPage[p].PgData[c];
          if aCell.FCellID = cellID then
            begin
               if (aCell.Text <> '') then
                 begin
                   if FOverride then
                     begin
                       if cellValue <> '' then
                         begin
                           aCell.SetText(cellValue);
                           //if aCell.FMathID > 0 then    //PAM: Ticket #1406 : should not base on math id, we should always call postprocess when setText.
                           aCell.PostProcess;
                         end;
                     end
                   else if EmptyCellValue(aCell.Text) then
                     begin
                       aCell.SetText(cellValue);
                       //if aCell.FMathID > 0 then  //PAM: Ticket #1406 : should not base on math id, we should always call postprocess when setText.
                       aCell.PostProcess;
                     end;
                 end
               else
                 begin
                   if cellValue <> '' then
                     begin
                       aCell.SetText(cellValue);
                       //we don't want to process math for cell #200 Bsmt GLA when push down
                       //The input value already taken care of
                       if (aCell.FMathID > 0) then
                         begin
                           case cellID of
                             200:
                               begin
                                 //do nothing
                               end;
                             else
                               aCell.PostProcess;
                           end;
                         end;
                         aCell.Display;
                     end;
                 end;
               break;
            end;
        end;
end;

procedure InsertXCompPage(doc: TContainer; compNo: Integer);
var
  i, count, formID: Integer;
  found: boolean;
begin
  found := False;
  for i := 0 to doc.docForm.Count - 1 do
    begin
      case doc.docForm.Forms[i].FormID of
        340, 355, 4218, 4365: //both forms are using the same xcomp page 363
          begin
            formID := 363;
            found := true;
            break;
          end;
        349: //1025
          begin
            formID := 364;
            found := true;
            break;
          end;
        342: //github #887: 1004C
          begin
            formID := 365;
            found := true;
            break;
          end;
        345, 347: //both forms are using the same xcomp page 367
          begin
            formID := 367;
            found := true;
            break;
          end;
        351:  //form 2090
          begin
            formID := 366;
            found := true;
            break;
          end;
        4131: //apple main form
          begin
            formID := 4132;
            found := true;
            break;
          end;
        4136: //apple main form
          begin
            formID := 4137;
            found := true;
            break;
          end;
        916: //ERC main form
          begin
            formID := 918;
            found := true;
            break;
          end;
      end;
    end;
  if found then
    begin
      count := compNo div 3;  //see how many xcomp page we need
      doc.GetFormByOccurance(formID, count-1, True);
    end;
end;

procedure InsertXListingPage(doc: TContainer; compNo: Integer);
var
  i, count, formID: Integer;
  found: boolean;
begin
  found := False;
  for i := 0 to doc.docForm.Count - 1 do
    begin
      case doc.docForm.Forms[i].FormID of
        340, 355, 4218, 4365: //both forms are using the same xcomp page 363
          begin
            formID := 3545;
            found := true;
            break;
          end;
        349: //1025
          begin
            formID := 869;
            found := true;
            break;
          end;
        345, 347: //both forms are using the same xcomp page 367
          begin
            formID := 888;
            found := true;
            break;
          end;
        342: //Ticket #1271: 1004C use xlisting form 733
          begin
            formID := 733;
            found  :=True;
            break;
          end;
        4131: //apple main form
          begin
            formID := 4133;  //extra listing page
            found := true;
            break;
          end;
        4136: //apple main form #2
          begin
            formID := 4138;  //extra listing page
            found := true;
            break;
          end;
        916: //ERC form
          begin
            formID := 917;   //extra listing page
            found := true;
            break;
          end;
      end;
    end;
  if found then
    begin
      count := trunc((compNo + 2)/3);
      doc.GetFormByOccurance(formID, count, True);
    end;
end;



function IsListingForm(FormID:Integer):Boolean;
begin
  case FormID of
    3545, 869, 888, 4133, 4138: result := True
  else
    result := False;
  end;
end;

function YearBuiltToAge(YearStr: String; AddYrSuffix: Boolean): String;
var
  Year, Age: Integer;
begin
  result := '';
  Year := GetValidInteger(YearStr);
  if Year > 0 then
    begin
      Age := CurrentYear - Year;
      result := IntToStr(Age);
      if AddYrSuffix then
        result := result + ' yrs';
    end;
end;

function GetFormCertID(FormID:Integer):Integer; //github #647
begin
   result := 0;
   Case FormID of
      fm2005_1004: result  := fm2005_1004Cert;  //341
      fm2005_1073: result  := fm2005_1073Cert;  //346
      fm2005_1075: result  := fm2005_1075Cert;  //348
      fm2005_2055: result  := fm2005_2055Cert;  //356
      fm2005_1004C: result := fm2005_1004CCert; //343
      fm2005_1025:  result := fm2005_1025Cert;  //349
      fm2005_1025_Ext: result := fm2005_1025ExtCert;  //4371
      4220: result := 4221; //ticket #1085: 4221
      frmIQExp_4195: result := frmIQExpCert_4196; //4196
      frmIQWav_4215, 4230: result := frmIQWavCert_4216;  //4216  //Ticket #966
      fm2005_1004p_4218:    result := fm2005_1004p_4219Cert;
      fm2019_70H_4365:      result := fm2019_70H_4366Cert;
      889, 11: result := 0; //form 889 and 11 don't have cert form, we should set to 0 and for 0 do not populate cert form
//      else
//        result := fm2005_1004Cert;   //do not set default to 1004
   end;
end;


function GetFormIndex(doc: TContainer; aFormID:Integer):Integer;
var
  i: Integer;
begin
  result := -1;
  for i:= 0 to doc.docForm.Count - 1 do
    if doc.docForm.Forms[i].FormID = aFormID then
      begin
       // result := i+1;
        result := i;
      end;
end;

//10 County Road 48 or 123 abc street 789
function GetUnitNoFromStreet(var Street:String):String;
const
  StreetNameList: array[0..9] of String =
             ('ROAD', 'STREET','AVENUE', 'COURT', 'CIRCLE', 'WAY', 'LANE',
              'DRIVE','HWY', 'BLVD');

var
  i, p: Integer;
  str, aTemp: String;
  aMarker: String;
  aUnit: Integer;
begin
  result := '';
  str := UpperCase(street);
  str := trim(str);

  for i:= low(StreetNameList) to high(StreetNameList) do
    begin
      aMarker := StreetNameList[i];
      p := pos(aMarker, str);
      if p > 0 then
        begin
          aTemp := popStr(str, aMarker);
          aUnit := GetValidInteger(str);
          if aUnit > 0 then
            result := Format('%d',[aUnit]);
          //street := copy(Street, 1, p + (length(aMarker) -1)); //github #1001
          street := copy(Street, 1, p + (length(aMarker)));
          break;
        end;
    end;
end;


function GetMainFormID(doc: TContainer):Integer;

var

  i,f, frmID, mFrmID: Integer;

  found:Boolean;

begin

  result := 340;  //default to 340 if no form in the container

  found  := False;

  doc := Main.ActiveContainer;

  if assigned(doc) and (doc.FormCount > 0) then

    begin

       for f := 0 to doc.docForm.Count - 1 do

        begin

          frmID := doc.docForm[f].FormID;

           for i:= low(MainFormIDArray) to high(MainFormIDArray) do //walk through the MainFormIDArray

             if frmID = MainFormIDArray[i] then
               begin
                 result := frmID;
                 found  := True;
                 break;
               end;
        end;
      if not found then
          result := doc.docForm[0].FormID;
    end;
end;



function GetActualAgeByYearBuilt(EffDate:String; aYrBuilt: Integer):Integer;

var

  EffYear: Integer;

  aDateTime: TDateTime;

begin

  if Effdate <> '' then

    aDateTime := StrToDate(EffDate)

  else

    aDateTime := Date;


  EffYear := YearOf(aDateTime);


  if aYrBuilt = 0 then

    result := 0

  else if EffYear > 0 then

    result := EffYear - aYrBuilt;

end;

function MainFormExist(doc: TContainer; var frmID:Integer):Boolean;
var
  f, p, c: Integer;
  aCellID: Integer;
  aCellValue: String;
  aCount: Integer;
  aMessage: String;
begin
  result := false;
  aCount := 0;   //the counter to count cell value not EMPTY
  for f := 0 to doc.docForm.Count - 1 do
    begin
      frmID := doc.docForm[f].FormID;
      case frmID of //should have a better way here
        340, 349, 345, 347, 355, 4131, 4136, 4195, 4220,4218, 4365:
          begin  //make sure we have address not empty
            result := True;
            for p := 0 to doc.docForm[f].frmPage.Count -1 do
              for c:= 0 to doc.docForm[f].frmPage[p].pgData.Count - 1 do
                begin
                   aCellID := doc.docForm[f].frmPage[p].pgData[c].FCellID;
                     if (aCellID > 0) and not doc.docForm[f].frmPage[p].pgData[c].FEmptyCell then
                       begin
                         aCellValue := doc.docForm[f].frmPage[p].pgData[c].Text;
                         if trim(aCellValue) <> '' then
                           begin
                             if (pos('0', aCellValue) > 0) then
                               begin
                                 if (StrToIntDef(aCellValue, 0) <> 0) then
                                   inc(aCount);
                               end
                             else
                               begin
                                 inc(aCount);
                               end
                           end;
                         if aCount > 5 then  //we assume the first 5 cells on the top header are always filled in
                           begin
                             result := True;
                             break;
                           end;
                       end;
                end;
          end;
      end;
    end;
end;



end.
