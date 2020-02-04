unit UListComps2;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This unit holds the interface to the Comparables Database. TThumbEx is}
{ a component for holding thumbnail images of the comparable photos. The}
{ Comp DB switches grid views to focus on the different types of comps  }
{ that the database can hold. This version is dedicated to residential, }
{ but also handles mobile home and vacant lands.                        }

{There is some bug in this Form whereby the ScrollBox's bottom is actually}
{some distance from the bottom. This is why the ScrollBox's bottom is   }
{offset from the bottom of the tabSheet by about 105 pixels.            }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Menus,
  ComCtrls, ExtCtrls, ToolWin, Grids_ts, TSGrid, StdCtrls, DBCtrls, TSMask,ImgList,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid,dxTLClms,dxExEdtr,CheckLst,ADODB,DB,
  TMultiP, dxEdLib, MMOpen,
  UListDMSource, UGlobals, UImageView, UStrings, UGridMgr, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, dxDBTLCl, dxGrClms, dxEditor, Mask,
  RzEdit, RzDTP, UForms, DialogsXP,uListCompsUtils,
  UCC_Progress, RzButton, RzRadChk, IniFiles, uUADConsistency, RzLabel,
  RzLine{,uGeoCodeThread};

const
  FieldsListSize = 15;          //this is the max number of rows in the detail grid

type
  arrSixNames   = array[1..6] of String;
  arrThreeNames = array[1..3] of String;
  NameList      = array[1..FieldsListSize] of String; //Field's List for a detail view

  AddrInfo = record  //structure to hold lat/lon and address info
    Lat: String;
    Lon: String;
    StreetNum: String;
    StreetName: String;
    City: String;
    State: String;
    Zip: String;
    UnitNo: String;
  end;

  GridNameRec = record     //structure for handling the different grid views
    numRows: Integer;
    viewName: String;
    DisplayNames1: NameList;
    DisplayNames2: NameList;
    FieldNames1: NameList;
    FieldNames2: NameList;
  end;

  OnThumbExExit = procedure (sender: TObject) of Object;

  TThumbEx = class(TComponent)
    FImage: TPMultiImage;
    imgFrame: TShape;
    imgEditDescr: TDxEdit;
    lbImgNo: TLabel;
    procedure OnDescrExit(Sender: TObject);
    procedure OnImageDblClick(Sender: TObject);
    procedure OnImageKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState) ;
    procedure OnInvalidImage(Sender: TObject; ErrorCode: Smallint; ErrorString: String; ErrorPChar: PChar);
    procedure OnDescrEnter(Sender: TObject);
    procedure OnImageClick(Sender: TObject);
  public
    imgPath: String;
    imgID: Integer;
    FOnDescrEdited: TNotifyEvent;
    FOnImageDelRequired: TNotifyEvent;
    FOnActivateImage: TNotifyEvent;
    FOnDescrEnter: TNotifyEvent;
    constructor Create(AOwner: TComponent; orig: TPoint; ID: Integer;
                                                aImgPath, aImgDesc: String); reintroduce;
    function GetImageDescr: String;
    function GetNominalImagePath: String;
    function GetActualImagePath: String;
    procedure ViewImage;
    procedure ActivateImg(active: Boolean);
  end;

  TCompsDBList = class(TAdvancedForm)
    StatusBar: TStatusBar;
    MainMenu1: TMainMenu;
    DatabaseMenu: TMenuItem;
    DatabaseCloseMItem: TMenuItem;
    ComparableMenu: TMenuItem;
    PhotosMenu: TMenuItem;
    PhotoAddMItem: TMenuItem;
    PhotoDeleteMItem: TMenuItem;
    PhotoViewMItem: TMenuItem;
    RecordImportMItem: TMenuItem;
    RecordExportMItem: TMenuItem;
    ImgList1: TImageList;
    RefreshMItem: TMenuItem;
    View1: TMenuItem;
    ListUndoGroupsMItem: TMenuItem;
    ListUndoSortMItem: TMenuItem;
    ListDivider2: TMenuItem;
    ListRestoreDefMItem: TMenuItem;
    N2: TMenuItem;
    RecordNewMItem: TMenuItem;
    RecordSaveMItem: TMenuItem;
    RecordDeleteMItem: TMenuItem;
    N3: TMenuItem;
    RecordFirstMItem: TMenuItem;
    RecordNextMItem: TMenuItem;
    RecordPrevMItem: TMenuItem;
    RecordLastMItem: TMenuItem;
    RecordEditMItem: TMenuItem;
    MaintMenu: TMenuItem;
    MaintCopyDBMItem: TMenuItem;
    MainRemoveDupsMItem: TMenuItem;
    Q1: TADOQuery;
    SaveDialog: TSaveDialog;
    dxComponentPrinter1: TdxComponentPrinter;
    dxComponentPrinter1Link1: TdxDBGridReportLink;
    ListFindMItem: TMenuItem;
    ListFindAllMItem: TMenuItem;
    ListDivider1: TMenuItem;
    OpenImgDialog: TMMOpenDialog;
    PageControl: TPageControl;
    tabSearch: TTabSheet;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    lblCustFieldName1: TLabel;
    Label39: TLabel;
    Label46: TLabel;
    Label49: TLabel;
    Label55: TLabel;
    Label50: TLabel;
    Label40: TLabel;
    Label77: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label41: TLabel;
    lblCustFieldName2: TLabel;
    lblCustFieldName3: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    cmbCounty: TComboBox;
    btnClearCounty: TButton;
    cmbCity: TComboBox;
    btnClearCity: TButton;
    cmbZip: TComboBox;
    cmbZip1: TComboBox;
    cmbZip2: TComboBox;
    btnClearZip: TButton;
    cmbNeighb: TComboBox;
    cmbNeighb1: TComboBox;
    cmbNeighb2: TComboBox;
    btnClearNeighb: TButton;
    edtStreet: TEdit;
    btnClearStreet: TButton;
    edtAPN: TEdit;
    btnClearApn: TButton;
    cmbMapref: TComboBox;
    btnClearMapref: TButton;
    cmbMapRef1: TComboBox;
    cmbMapref2: TComboBox;
    cmbDesign: TComboBox;
    cmbDesign1: TComboBox;
    cmbDesign2: TComboBox;
    btnClearDesign: TButton;
    cmbCustFldValue1: TComboBox;
    edtSalesPriceMin: TEdit;
    edtSalesPriceMax: TEdit;
    btnClearSalesPrice: TButton;
    btnClearSalesDate: TButton;
    edtAgeMin: TEdit;
    edtAgeMax: TEdit;
    btnClearAge: TButton;
    edtGlaMin: TEdit;
    edtGlaMax: TEdit;
    btnClearGLA: TButton;
    btnFind: TButton;
    btnClearAll: TButton;
    edtTotalRmMin: TEdit;
    edtBedRmMin: TEdit;
    EdtBathRmMin: TEdit;
    edtTotalRmMax: TEdit;
    EdtBedRmMax: TEdit;
    edtBathRmMax: TEdit;
    btnClearTotalRm: TButton;
    btnClearBedRm: TButton;
    btnClearBathRm: TButton;
    btnFindAll: TButton;
    rzDateEdtSalesMin: TRzDateTimeEdit;
    rzDateEdtSalesMax: TRzDateTimeEdit;
    cmbCustFldValue2: TComboBox;
    cmbCustFldValue3: TComboBox;
    btnClearCustFldValue: TButton;
    edtMLS: TEdit;
    btnClearMLS: TButton;
    tabList: TTabSheet;
    dxTreeList1: TdxTreeList;
    dxDBGrid: TdxDBGrid;
    dxDBGridCustId: TdxDBGridColumn;
    dxDBGridStreetNumber: TdxDBGridColumn;
    dxDBGridStreetName: TdxDBGridColumn;
    dxDBGridCity: TdxDBGridColumn;
    dxDBGridZIP: TdxDBGridColumn;
    dxDBGridTotalRooms: TdxDBGridColumn;
    dxDBGridBedRooms: TdxDBGridColumn;
    dxDBGridBathRooms: TdxDBGridColumn;
    dxDBGridGrossLivArea: TdxDBGridColumn;
    dxDBGridSiteArea: TdxDBGridColumn;
    dxDBGridAge: TdxDBGridColumn;
    dxDBGridState: TdxDBGridColumn;
    dxDBGridDesignAppeal: TdxDBGridColumn;
    dxDBGridNoStories: TdxDBGridColumn;
    dxDBGridCounty: TdxDBGridColumn;
    dxDBGridParcelNo: TdxDBGridColumn;
    dxDBGridCensus: TdxDBGridColumn;
    dxDBGridProjectName: TdxDBGridColumn;
    dxDBGridMapRef1: TdxDBGridColumn;
    dxDBGridSalesPrice: TdxDBGridColumn;
    dxDBGridSalesDate: TdxDBGridDateColumn;
    dxDBGridUserValue1: TdxDBGridColumn;
    dxDBGridUserValue2: TdxDBGridColumn;
    dxDBGridUserValue3: TdxDBGridColumn;
    tabDetail: TTabSheet;
    Label1: TLabel;
    lblCreateDate: TLabel;
    lblModDate: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    lblCompsID: TLabel;
    btnDelete: TButton;
    btnSave: TButton;
    btnEdit: TButton;
    btnNew: TButton;
    SalesGrid: TtsGrid;
    UserGrid: TtsGrid;
    ValuesGrid: TtsGrid;
    SpecsGrid: TtsGrid;
    AddressGrid: TtsGrid;
    LocGrid: TtsGrid;
    cmbxGridType: TComboBox;
    CompNote: TMemo;
    btnFirst: TButton;
    btnPrev: TButton;
    btnNext: TButton;
    btnLast: TButton;
    ScrollBox: TScrollBox;
    TabExport: TTabSheet;
    ckbSelectedOnly: TCheckBox;
    btnPrint: TButton;
    btnExport: TButton;
    rdoExportText: TRadioButton;
    rdoExportExcell: TRadioButton;
    tabSetup: TTabSheet;
    Label3: TLabel;
    TLCustomize: TdxTreeList;
    TLCustomizeColumn2: TdxTreeListCheckColumn;
    TLCustomizeColumn1: TdxTreeListColumn;
    Button1: TButton;
    GroupBox1: TGroupBox;
    cbxCmpEqualSubjZip: TCheckBox;
    cbxCmpEqualSubjState: TCheckBox;
    cbxCmpEqualSubjCounty: TCheckBox;
    cbxCmpEqualSubjNeighbor: TCheckBox;
    cbxCmpEqualSubjMap: TCheckBox;
    cbxSaveListPrefs: TCheckBox;
    N1: TMenuItem;
    GeoCoding1: TMenuItem;
    chkAutoSaveComps: TRzCheckBox;
    chkConfirmCompsSaving: TRzCheckBox;
    chkAutoSaveSubject: TRzCheckBox;
    chkConfirmSubjectSaving: TRzCheckBox;
//    Panel1: TPanel;

    procedure GridTypeChange(Sender: TObject);
    procedure ConnectionClose(Sender: TObject);
    procedure OnFormShow(Sender: TObject);
    procedure OnClose(Sender: TObject; var Action: TCloseAction);
    procedure ClickSaveRecord(Sender: TObject);
    procedure ClickNewRecord(Sender: TObject);
    procedure ClickEditRecord(Sender: TObject);
    procedure ClickDeleteRecord(Sender: TObject);
    procedure OnGridEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure OnCommentChanged(Sender: TObject);
    procedure OnGridNodeChange(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure BeforeChangeTab(Sender: TObject; var AllowChange: Boolean);
    procedure GetPhotoData;
    procedure LoadImages;
    procedure FreeImages;
    procedure ClickDeletePhoto(Sender: TObject);
    procedure ClickAddPhoto(Sender: TObject);
    procedure ClickViewPhoto(Sender: TObject);
    procedure ClickRestoreDefaults(Sender: TObject);
    procedure LoadReportCompTables;
    procedure EliminateDuplicates(Sender: TObject);
    procedure ClickRefreshRecord(Sender: TObject);
    procedure ClickBackupDatabase(Sender: TObject);
    procedure OnDragPrefNodeOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OnPrefListDblClick(Sender: TObject);
    procedure OnPrefListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure OnDragEndGridColumn(Sender: TObject;
      AColumn: TdxTreeListColumn; P: TPoint;
      var NewPosInfo: TdxHeaderPosInfo; var Accept: Boolean);
    procedure AfterChangeTab(Sender: TObject);
    procedure ClickListUndoGroups(Sender: TObject);
    procedure ClickListUndoSort(Sender: TObject);
    procedure ClickBtnPrev(Sender: TObject);
    procedure ClickBtnFirst(Sender: TObject);
    procedure ClickBtnNext(Sender: TObject);
    procedure ClickBtnLast(Sender: TObject);
    procedure AddressGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpecsGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SalesGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UserGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ValuesGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LocGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CompNoteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFindClick(Sender: TObject);
    procedure btnFindAllClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    //procedure dtpLowDateCloseUp(Sender: TObject);
    //procedure dtpHiDateCloseUp(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure ListFindAllMItemClick(Sender: TObject);
    procedure ListFindMItemClick(Sender: TObject);
    procedure OnbtnClearFldClick(Sender: TObject);
    procedure OnRefresBtnClick(Sender: TObject);
    procedure OnRecordsMenuClick(Sender: TObject);
    procedure OntabSearchEnter(Sender: TObject);
    procedure rzDateEdtSalesMinDropDown(Sender: TObject);
//    procedure GeoCoding1Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
//    procedure RunProcessTimerTimer(Sender: TObject);
    procedure RecordImportMItemClick(Sender: TObject);
   private
    FDoc: TComponent;                 //the current documenmt
    FGridType: Integer;
    FModified: Boolean;
    FDetailCmpID: Integer;            //compID of the current rec in detail view
    FDocCompTable: TCompMgr2;         //Grid Mgr for the report tables
    FDocListTable: TCompMgr2;
    FHeadCellIDMap: TStringList;
    FSubGridCellIDMap: TStringList;
    FGridCellIDMap: TStringList;
    FCompDBPhotosDir: String;
    FCurGridNames: GridNameRec;
    FThumbNailList: Array of TThumbEx;
    FActiveThumb: TThumbEx;
    FGridIniFile: String;
    FNeedGeoCode: Boolean;
    FProgressBar:TCCProgress;
    FImportOption: Integer;
    FAge: Integer;
    FModifiedDate: String;
    FOriginalWidth:Integer;
    procedure SetGridType(Value: Integer);
    procedure CloseDB;
    procedure LoadColumnList;
    procedure LoadCustFieldNames;
    procedure SaveCustFieldNames(custFldNo: Integer);
    procedure LoadCurRecToDetailView;
    procedure NewRecord(ImportOption: Integer; CompsID:Integer; Addr:AddrInfo; EffectiveDate:String='');   //when compsid > 0 means record exists
    procedure SaveRecord;
    procedure DeleteRecord;
    procedure DeleteSelectedRecords;
    procedure LoadFieldList(listNo: Integer);
    procedure SaveFieldList(listNo: Integer);
    procedure LoadSixFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
    procedure SaveSixFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
    procedure SaveSixFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
    procedure LoadThreeFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
    procedure SaveThreeFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
    procedure SaveThreeFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
//    procedure OnRecChanged;
    procedure SetEditMode(canEdit: Boolean);
    procedure RememberStuff;
    procedure ActivateThumbs(sender: TObject);
    procedure DesactivateThumbs(sender: TObject);
    function GetPhotoFilePath(compID: Integer; const Title: String): String;
    procedure AddPhotoRecord(compID: Integer; Title, filePath: String; relPath, showPhoto: Boolean);
    {procedure AddPhotoFromFile(compID: Integer; Const FileName, Title: String);  FUTURE USE}
    procedure AddPhotoFromCell(compID: Integer; Cell: TObject; Const Title: String);
    procedure ImportSubPhotos;
    procedure ImportCompPhoto(cmpCol :TCompColumn);
    procedure ExportCompPhoto(cmpCol :TCompColumn);
    procedure RemovePhotos(compID: Integer; bDelFiles: Boolean);
    procedure ExportComparable(Index: Integer; compType: Integer);
    procedure ImportUADComparable(Index: Integer; CompCol: TCompColumn; lat, lon: String);
    procedure ExportUADComparable(Index: Integer; compCol: TCompColumn);
//    procedure ImportSubject(ImportOption:Integer = 0);
    procedure ExportCompMenuClick(Sender: TObject);
    procedure ExportListingMenuClick(sender: TObject);
    procedure SetFieldsDefault;
    procedure BackupComps;
    procedure SetNavigationState;
    {function Report2GridType(ReportTyp: Integer): Integer; - FUTURE USE}
    procedure PrintRecords;
    procedure ExportRecords;
    procedure ExportToFile;
    procedure ExportToExcell;
    procedure ClearSearchCriteria(tag: Integer);
    function GetSearchCriteria: String;
    Procedure LoadDistinctSearchCriteria;
    procedure FillOutLookupCombo(sqlStr: String; cmb: TComboBox);
    procedure AdjustDPISettings;
    function GetDateOFSalesCellText(isUAD: boolean): String;
//    procedure LoadPropertyList(var GeoCode:TGeoCoder);
    procedure LoadPrefs;
    procedure SavePrefs;
//    procedure GetGEOCode(var prop: AddrInfo);
    function SetupWHERE(Addr: AddrInfo):String;
//    procedure ProcessGeoCode(var geoCode: TGeoCoder);
//    procedure RunGeoCodeInBackground;
    function ReCalculateAge(age:Integer; ModifiedDate: String): Integer;



   public
    constructor Create(AOwner: TComponent; actPgIndex, actGridIndex: Integer); reintroduce; overload;
    procedure OnEditImgDescr(sender: TObject);
    procedure DeletePhoto(sender: TObject);
    procedure SetupDetailGridNames(ViewID: Integer);

    function ConnectToDB: Boolean;
    procedure ImportSubjectMenuClick(Sender: TObject);
    procedure ImportComparable(Index: Integer; compType: Integer; ImportOption:Integer = 0);
    procedure LoadFieldToCellIDMap;
    procedure ImportAllCompsMenuClick(Sender: TObject);
    procedure ImportCompMenuClick(Sender: TObject);
    procedure ImportListingMenuclick(sender: TObject);
    procedure ImportAllListingsMenuClick(sender: TObject);
    function FindAll: Boolean;
    function FindRecord(Addr:AddrInfo):Integer;
    procedure OnRecChanged;
    function  SubjectInDB: Boolean;
    function  CompsInDB(CompID, CompType:Integer): Boolean;
    procedure ImportSubject(ImportOption:Integer = 0);


    //For GEOCODING
//    procedure DoGeoCoding(ShowMsg:Boolean=False);
    property ProgressBar: TCCProgress read FProgressBar write FProgressBar;

    property CompGrid: Integer read FGridType write SetGridType;
    property ImportOption: Integer read FImportOption write FImportOption;
  end;


  procedure ShowCompsDBList(AOwner: TComponent; actPgIndex: Integer);
//  procedure SaveSubjToCompsDBList(ADoc: TComponent);


//  procedure SaveCompToCompsList(ADoc: TComponent);

var
  CompsDBList: TCompsDBList;


implementation
{$R *.DFM}

uses
  ShellAPI, dateUtils,
  UContainer, UStatus, Math, UBase, UUtil1, UUtil2, UCell,
  UPage, UCellAutoAdjust, UConvert, UWinUtils, UUADUtils, UMain, uListComp_Global, uDebug;

const
  //AddressList Row
  rRowNum   = 1;
  rInclude  = 2;
  rCompID   = 3;
  rAddress  = 4;
  rAccuracy = 5;
  rLat      = 6;
  rLon      = 7;


  poAlwaysDelete  = 0;
  poAlwasyAsk     = 1;
  poNeverDelete   = 2;

  //compDBName          = 'Comparables.mdb';
  GridPrefFile        = 'CompListPref.ini';


  SQLstring1 = 'SELECT * FROM %s';
  SQLstring2 = ' ORDER BY %s';
  SQLstring3 = ' WHERE %s = %s';

  checkStr = '(Trim([StreetNumber]) + "_" + Trim([StreetName]) + "_" + ' +
              'Trim([City]) + "_" + Trim([State]) + "_" + Trim([Zip]) + "_" + ' +
              'Trim([SalesPrice]) + "_" + Trim([SalesDate])) ';
  SQLString4 = 'SELECT ' +
                  checkStr + 'as checkStr, ' + 'compsID  FROM comps ' +
                  'ORDER BY ' +  checkStr;

  addrGridDBFieldNames:   arrSixNames = ('StreetNumber', 'StreetName','UnitNo','City','State','Zip');
  specsGridDBFieldNames:  arrSixNames = ('TotalRooms','BedRooms','BathRooms','GrossLivArea','Age','NoStories');
  locGridDBFieldNames:    arrSixNames = ('County','Census','ParcelNo','ProjectName','MapRef1','MapRef2');
  SaleDateDBNames:        arrThreeNames = ('SalesDate','PrevSaleDate','Prev2SaleDate');
  SalePriceDBNames:       arrThreeNames = ('SalesPrice','PrevSalePrice','Prev2SalePrice');
  SaleSourceDBNames:      arrThreeNames = ('DataSource','PrevDataSource','Prev2DataSource');
  custUserFieldDBNames:   arrThreeNames = ('CustomField1','CustomField2','CustomField3');
  custValueFieldNames:    arrThreeNames = ('UserValue1','UserValue2','UserValue3');


  //Photos Frame constants
   Gap = 2;
   ThumbWidth = 120;      //3 x 5 photo
   ThumbHeight = 80;
   EditHeight = 18;   //21;
   LabelWidth = 20;
   FullImagHeight = ThumbHeight + EditHeight + 2* Gap;
   strLabelItem = '#';
   imgCantFind = 0;             //invalid photo index in the ImageList
   imgCantOpen = 1;             //invalid photo index in the ImageList
   PrefPageFieldNameCol = 0;    //Column order on Preference Page
   PrefPageVisibleCol = 1;

  // USA grids
  compNamesUrar: GridNameRec = (numRows:12; viewName:'URAR';
                 DisplayNames1: ('PricePerGLA','VerifySource','SalesConcess','FinanceConcess','Location',
                            'LeaseOrFeeSimple','Site','View','DesignAppeal','QualityOfConst','Age','Condition','','','');
                 DisplayNames2:  ('BasementFinished','RoomsBelowGrade','FunctionalUtility','HeatingCooling',
                            'EnergyEffItems','GarageCarport','PorchesPatios','Fireplaces','FencesPools','OtherItems','Longitude','Latitude','','','');
                 FieldNames1: ('PricePerGrossLivArea','VerificationSource','SalesConcessions','FinancingConcessions','Location',
                            'LeaseFeeSimple','SiteArea','View','DesignAppeal','QualityConstruction','Age','Condition','','','');
                 FieldNames2:  ('BasementFinished','RoomsBelowGrade','FunctionalUtility','HeatingCooling',
                            'EnergyEfficientItems','GarageCarport','PorchesPatioEtc','Fireplaces','FencesPoolsEtc','OtherItem1','Longitude','Latitude','','',''));

  compNames2055: GridNameRec = (numRows:8; viewName:'2055';
                 DisplayNames1: ('PricePerGLA','SalesConcess','FinanceConcess','Location',
                            'Site','View','DesignAppeal','Age','','','','','','','');
                 DisplayNames2: ('Condition','BasementFinished','RoomsBelowGrade','GarageCarport',
                            'OtherItems1','OtherItems2','Longitude','Latitude','','','','','','','');
                 FieldNames1: ('PricePerGrossLivArea','SalesConcessions','FinancingConcessions','Location',
                            'SiteArea','View','DesignAppeal','Age','','','','','','','');
                 FieldNames2: ('Condition','BasementFinished','RoomsBelowGrade','GarageCarport',
                            'OtherItem1','OtherItem2','Longitude','Latitude','','','','','','',''));

 compNames2065: GridNameRec = (numRows:8; viewName:'2065'; //queryName:'Query2065'; iniFileName: 'dbComps2065.ini';
                 DisplayNames1: ('PricePerGLA','SalesConcess','FinanceConcess','Location',
                            'Site','View','DesignAppeal','Age','','','','','','','');
                 DisplayNames2: ('Condition','BasementFinished','RoomsBelowGrade','GarageCarport',
                            'OtherItems1','OtherItems2','Longitude','Latitude','','','','','','','');
                 FieldNames1: ('PricePerGrossLivArea','SalesConcessions','FinancingConcessions','Location',
                            'SiteArea','View','DesignAppeal','Age','','','','','','','');
                 FieldNames2: ('Condition','BasementFinished','RoomsBelowGrade','GarageCarport',
                            'OtherItem1','OtherItem2','Longitude','Latitude','','','','','','',''));

  compNamesCondo: GridNameRec = (numRows:13; viewName: 'Condo';// queryName: 'QueryCondo';iniFileName: 'dbCompsCondo.ini';
                  DisplayNames1: ('PricePerGLA','VerifySource','SalesConcess','FinanceConcess','Location','LeaseOrFeeSimple',
                              'HOA_MoAssesment','CommonElement1','CommnElement2','ProjectSizeType','FloorLocation','View',
                              'DesignAppeal','','');
                  DisplayNames2: ('QualityOfConst','Condition','BasementFinished','RoomsBelowGrade','FunctionalUtility',
                             'HeatingCooling','EnergyEffItems','GarageCarport','PorchesPatios','Fireplaces','OtherItems',
                             'Longitude','Latitude','','');
                  FieldNames1: ('PricePerGrossLivArea','VerificationSource','SalesConcessions','FinancingConcessions','Location','LeaseFeeSimple',
                              'HOA_MoAssesment','CommonElement1','CommonElement2','ProjectSizeType','FloorLocation','View',
                              'DesignAppeal','','');
                  FieldNames2: ('QualityConstruction','Condition','BasementFinished','RoomsBelowGrade','FunctionalUtility',
                             'HeatingCooling','EnergyEfficientItems','GarageCarport','PorchesPatioEtc','Fireplaces','OtherItem1',
                             'Longitude','Latitude','',''));

  compNamesERC: GridNameRec = (numRows:13; viewName: 'ERC';//queryName: 'QueryErc';iniFileName: 'dbCompsErc.ini';
                  DisplayNames1:   ('FinalListPrice','SalesListingRatio','DaysOnMarket','SalesConcess','FinanceConcess',
                              'MarketChange','NeighbhdAppeal','SiteArea','SiteAppeal','ArchStyle','QualityConstr',
                              'Age','Condition','','');
                  DisplayNames2:   ('InteriorAppeal','BasementFinished','RoomsBelowGrade','FunctionalUtility',
                              'HeatingCooling','GarageCarport','Fireplaces','SignificantFeatures','OtherItems1',
                              'OtherItems2','OtherItems3','Longitude','Latitude','','');
                  FieldNames1:   ('FinalListPrice','SalesListRatio','DaysOnMarket','SalesConcessions','FinancingConcessions',
                              'MarketChange','NeighbdAppeal','SiteArea','SiteAppeal','DesignAppeal','QualityConstruction',
                              'Age','Condition','','');
                  FieldNames2:   ('InteriorAppealDecor','BasementFinished','RoomsBelowGrade','FunctionalUtility',
                              'HeatingCooling','GarageCarport','Fireplaces','SignificantFeatures','OtherItem1',
                              'OtherItem2','OtherItem3','Longitude','Latitude','',''));

  compNamesLand: GridNameRec = (numRows:6; viewName:'LAND'; //queryName:'QueryLand'; iniFileName:'dbCompsLand.ini';
                   DisplayNames1:   ('Units','PricePerUnit','SalesConcess','FinanceConcess','Location','Site / View','','','','','','','','','');
                   DisplayNames2:   ('OtherItems1','OtherItems2','OtherItems3','OtherItems4','Longitude','Latitude','','','','','','','','','');

                   FieldNames1:   ('Units','PricePerUnit','SalesConcessions','FinancingConcessions','Location','SiteArea','','','','','','','','','');
                   FieldNames2:   ('OtherItem1','OtherItem2','OtherItem3','OtherItem4','Longitude','Latitude','','','','','','','','',''));

  compNamesMobil: GridNameRec = (numRows:9; viewName: 'Mobile';//queryName: 'QueryMobil';iniFileName: 'dbCompsMobil.ini';
                  DisplayNames1:   ('PricePerGLA','Location','Make','Year','Condition','TipOut',
                                    'Addition','Other1','Other2','','','','','','');
                  DisplayNames2:   ('Furnishings', 'Woodstoves','Extra','Other3','SiteValue',
                                    'Financing','Longitude','Latitude','','','','','','','');
                  FieldNames1:   ('PricePerGrossLivArea','Location','MH_Make','YearBuilt','Condition','MH_TipOut',
                                  'SignificantFeatures','OtherItem1','OtherItem2','','','','','','');
                  FieldNames2:   ('Furnishings','Fireplaces','OtherItem4','OtherItem3','SiteValue',
                                  'FinancingConcessions','Longitude','Latitude','','','','','','',''));

  compNames704: GridNameRec = (numRows:6; viewName: '704';//queryName: 'Query704';iniFileName: 'dbComps704.ini';
                  DisplayNames1:   ('Location','Site','Condition','HeatingCooling','EnergyEffItems',
                                'GarageCarport','','','','','','','','','');
                  DisplayNames2:   ('PorchesPatios','FencesPools','OtherItems1','OtherItems2',
                                'Longitude','Latitude','','','','','','','','','');
                  FieldNames1:   ('Location','SiteArea','Condition','HeatingCooling','EnergyEfficientItems',
                                'GarageCarport','','','','','','','','','');
                  FieldNames2:   ('PorchesPatioEtc','FencesPoolsEtc','OtherItem1','OtherItem2',
                                'Longitude','Latitude','','','','','','','','',''));
(*
  {Small Income will be dealt with later}
  compNamesSmInc: GridNameRec = (numRows:12; viewName: 'SMALL INCOME';//queryName: 'QuerySmIncome';iniFileName: 'dbCompsMulti.ini';
                 fldList1:   ( 'LATITUDE','LONGITUDE','VerificationSource','PricePerGrossLivArea','PricePerRoom',
                                  'PricePerUnit','Furnishings','MonthlyRent','RentMultiplier','Location',
                                  'LeaseHoldFeeSimple','','','','');
                  fldList2:   ( 'DesignAppeal','QualityConstruction','GrossLivArea','BasementFinished','FunctionalUtility',
                                  'HeatingCooling','GarageCarport','OtherItem1','OtherItem2','OtherItem3',
                                  '','','','',''));
*)


//index of tab panels
  tSearch = 0;
  tList = 1;
  tDetail = 2;
  tExport = 3;
  tPref = 4;

//tag for Clear buttons on Search Tab
  tagDesign = 1;
  tagStreetName = 2;
  tagNeighb = 3;
  tagMapRef = 4;
  tagZip = 5;
  tagCity = 6;
  tagCounty = 7;
  tagAPN = 8;
  tagMLS    = 9 ;
  tagSalesPrice = 10;
  tagGla = 11;
  tagTotalRm = 12;
  tagBedRm = 13;
  tagBathRm = 14;
  tagAge = 15;
  tagSalesDate = 16;
  tagCustFld = 17;
  nSearchFields = 17;

type
  ECompSearchError = class(Exception);



{ This is the routine used to display the Comps Database Interface }
procedure ShowCompsDBList(AOwner: TComponent; actPgIndex: Integer);
begin
  actPgIndex := 1;    //the list page
  if CompsDBList = nil then
    begin
      if FileExists(appPref_DBCompsfPath) then
        begin
          CompsDBList := TCompsDBList.Create(AOwner, actPgIndex, 0);
          CompsDBList.Show;
        end;
    end
      else //avoid OnFormShow
        ShowWindow(CompsDBList.Handle,SW_RESTORE);
end;


procedure ShowUADConsistency(AOwner: TComponent; actPgIndex: Integer);
var
  uCon:TUADConsistency;
begin
  uCon := TUADConsistency.Create(nil);
  try
    uCon.doc := TContainer(main.ActiveContainer);
    if uCon.ShowModal = mrCancel then
      FModified := False;   //set FModified to False so it won't go through the pre or post process.
  finally
    uCon.Free;
    refreshCompList(-1);
  end;
end;



{ TCompsList }

procedure TCompsDBList.LoadPrefs;
begin
  cbxCmpEqualSubjState.checked := appPref_CompEqualState;
  cbxCmpEqualSubjZip.checked := appPref_CompEqualZip;
  cbxCmpEqualSubjCounty.checked := appPref_CompEqualCounty;
  cbxCmpEqualSubjNeighbor.checked := appPref_CompEqualNeighbor;
  cbxCmpEqualSubjMap.checked := appPref_CompEqualMapRef;
  cbxSaveListPrefs.Checked := appPref_CompSavePrefs;

  chkAutoSaveComps.Checked := appPref_AutoSaveComps;     //auto save Comps DB
  chkConfirmCompsSaving.Checked := appPref_ConfirmCompsSaving;
  chkAutoSaveSubject.Checked := appPref_AutoSaveSubject;     //auto save Subject data
  chkConfirmSubjectSaving.Checked := appPref_ConfirmSubjectSaving;
end;

constructor TCompsDBList.Create(AOwner: TComponent; actPgIndex, actGridIndex: Integer);
begin
  inherited Create(AOwner);
  SettingsName := CFormSettings_CompsList;
  FNeedGeoCode := False;

  FDoc := Nil;
  FDocCompTable := Nil;
  FDocListTable := nil;
  //DPI fix for 125 and 144
  AdjustDPISettings;
  //anchor bottom scrollBox after the window has been resized
  ScrollBox.Anchors := [akLeft,akTop,akBottom];

  //Make sure we set the datasource dataset to use COMPQUERY
  ListDMMgr.CompDataSource.DataSet := ListDMMgr.CompQuery;

  //preferences for auto populating fields
  LoadPrefs;

  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  if not VerifyFolder(FCompDBPhotosDir) then
    if ForceValidFolder(FCompDBPhotosDir) then
      ShowAlert(atWarnAlert, 'The Comparable Photos directory was missing. A new one was created.')
    else
      begin
        ShowAlert(atStopAlert, 'The Comparable Photos directory was missing and could not be recreated. Check your disk space.');
        Close;
      end;

  FGridType := cCompTypURAR;        //default grid type
  SetupDetailGridNames(FGridType);  //setup the detail grid
  FDetailCmpID := -1;               //no rec in detail view

  FGridIniFile := IncludeTrailingPathDelimiter(appPref_DirPref) + GridPrefFile;
  dxDBGrid.IniSectionName := 'ListPref'; //Important to set!

  TLCustomizeColumn1.ColIndex := PrefPageFieldNameCol;
  TLCustomizeColumn2.ColIndex := PrefPageVisibleCol;

  OpenImgDialog.filter := ImageLibFilter1 + ImageLibFilter2 + ImageLibFilter3;
  LoadFieldToCellIDMap;
  PageControl.ActivePageIndex := actPgIndex;
end;

(*
procedure TCompsDBList.LoadPropertyList(var GeoCode:TGeoCoder);
var
  gridRow: Integer;
  aNum, aName, aCity, aState, aZip, FullAddress: String;
begin
  gridRow := 0;
  GeoCode.AddressList.rows := ListDMMgr.CompQuery.RecordCount;
  ListDMMgr.CompQuery.DisableControls;
  try
    ListDMMgr.CompQuery.First;
    GeoCode.NotGeoCodeCount := 0;
    while not ListDMMgr.CompQuery.EOF do begin //load properties from Comps table to the grid
      aNum := ListDMMgr.CompQuery.FieldByName('StreetNumber').AsString;
      aName := ListDMMgr.CompQuery.FieldByName('StreetName').AsString;
      aCity := ListDMMgr.CompQuery.FieldByName('City').AsString;
      aState := ListDMMgr.CompQuery.FieldByName('State').asString;
      aZip := ListDMMgr.CompQuery.FieldByName('Zip').AsString;
      FullAddress := GetFullAddress(aNum,aName,aCity,aState,aZip);

      gridRow := gridRow+1;
      GeoCode.AddressList.Cell[rRowNum, gridRow] := gridRow;                    //set the index number
      GeoCode.AddressList.CellCheckBoxState[rInclude, gridRow] := cbUnchecked;
      GeoCode.AddressList.Cell[rCompID, gridRow] := ListDMMgr.CompQuery.FieldByName('CompsID').asString;
      GeoCode.AddressList.Cell[rAddress, gridRow] := FullAddress;
      GeoCode.AddressList.Cell[rLat, gridRow] := ListDMMgr.CompQuery.FieldByName('Latitude').asString;
      GeoCode.AddressList.Cell[rLon, gridRow] := ListDMMgr.CompQuery.FieldByName('Longitude').asString;
      GeoCode.AddressList.Cell[rAccuracy, gridRow] := '';
      if (GeoCode.AddressList.Cell[rLat, gridRow]='') or (GeoCode.AddressList.Cell[rLon, gridRow] = '') then
        begin
          GeoCode.AddressList.CellCheckBoxState[rInclude, gridRow] := cbChecked;
          GeoCode.NotGeoCodeCount := GeoCode.NotGeoCodeCount + 1;
          FNeedGeoCode := true;
        end;
      ListDMMgr.CompQuery.Next;
    end;
  finally
    ListDMMgr.CompQuery.EnableControls;
  end;
end;
*)


//Bring up GeoCoder and load comps data into GeoCode address grid
(*
procedure TCompsDBList.DoGeoCoding(ShowMsg:Boolean=False);
var
  GeoCode:TGeoCoder;
  doc: TContainer;
  Msg: String;
  doIt: Boolean;
  max, minGeo: Integer;
begin
  doc := Main.ActiveContainer;
  GeoCode := TGeoCoder.CreateGeoCoder(doc,True);
  max := GeoCode.NotGeoCodeCount;
   try
     LoadPropertyList(GeoCode);
     if GeoCode.NotGeoCodeCount > 0 then
       begin
          PushMouseCursor(crHourGlass);
          try
            doIt := False;
            if ShowMsg then
              begin
                minGeo := round((max/60)/5);  //to get the minutes
                Msg := 'Some properties are not GeoCode in your Comps Database. Would you like to GeoCode first?';
                Msg := Msg + #13#10+ Format(' This might take %d minutes to geo-code.',[minGeo]);
                if Ok2Continue(Msg) then
                  doIt := True;
              end
            else
              doIt := True;
            if doIt then
            begin
              ProcessGeoCode(geoCode);
            end;
          finally
            PopMouseCursor;
          end;
//          if doIt then
//           GeoCode.SaveGeoCodeToComp(True);
       end;
     ListDMMgr.CompQuery.Active := False;
     ListDMMgr.CompQuery.SQL.Text := 'Select * from COMPS order by CompsID';
     ListDMMgr.CompQuery.Active := True;
     ListDMMgr.CompQuery.First;  //move to the first row
   finally
     GeoCode.Free;
   end;
end;
*)

procedure TCompsDBList.AdjustDPISettings;
begin
   PageControl.Height :=  cmbCustFldValue3.top + cmbCustFldValue3.Height + 20;
   PageControl.Width := Scrollbox.Left + Scrollbox.width + 50;
   self.width := PageControl.Width + 20;
   self.height := PageControl.Height + StatusBar.Height + 20;
   self.ClientHeight := self.height;
   self.ClientWidth := self.width;
end;


procedure TCompsDBList.OnFormShow(Sender: TObject);
begin
  PushMouseCursor(crHourglass);
  try
    if not ConnectToDB then
      begin
        CloseDb;
        ShowAlert(atStopAlert, 'The connection to the Comparables database could not be made. The Comparables Manager will now close down.');
        Close;
      end;

   if FileExists(FGridIniFile) then
      dxDBGrid.LoadFromIniFile(FGridIniFile);

    //save any active data before doing anything
    if Assigned(FDoc) then
      TContainer(FDoc).SaveCurCell;

    //select the Tab
    //PageControl.ActivePageIndex := appPref_CompLastTabShown;
    if PageControl.ActivePageIndex = tDetail then                //if detail then show rec
      OnRecChanged;
    FModified := False;
  finally
    PopMouseCursor;
    lblCompsID.Caption := '';
    lblCreateDate.Caption := '';
    lblModDate.Caption := '';
    LoadColumnList;
//    RunGeoCodeInBackground;
    FOriginalWidth := self.width;
  end;
end;

procedure TCompsDBList.LoadFieldToCellIDMap;
begin
  FHeadCellIDMap := TStringList.Create;
  FHeadCellIDMap.Duplicates := dupAccept;
  FHeadCellIDMap.Delimiter := ',';
  FHeadCellIDMap.DelimitedText := HeadCellIDMap;

  FSubGridCellIDMap := TStringList.Create;
  FSubGridCellIDMap.Duplicates := dupAccept;
  FSubGridCellIDMap.Delimiter := ',';
  FSubGridCellIDMap.DelimitedText := SubGridCellIDMap;

  FGridCellIDMap := TStringList.Create;
  FGridCellIDMap.Duplicates := dupAccept;
  FGridCellIDMap.Delimiter := ',';
  FGridCellIDMap.DelimitedText := CompGridCellIDMap;
end;

procedure TCompsDBList.OnRecChanged;
begin
  LoadCustFieldNames;
  LoadCurRecToDetailView;
  try
    GetPhotoData;
    LoadImages;
  except on E:Exception do
    shownotice('OnRecChanged error: '+e.message);      ///### HANDLE: need to comment out when it's done 
  end;
  SetEditMode(False);
  SetNavigationState;
end;

function TCompsDBList.FindAll: Boolean;
var
  sqlStr: String;
begin
  result := False;
  with ListDMMgr do
    try
      CompQuery.Close;
      CompQuery.SQL.Clear;
      sqlStr := Format(sqlString1,[compsTableName]) + Format(sqlString2,[compIDFldName]);
      CompQuery.SQL.Add(sqlStr);
      CompQuery.Open;
      CompQuery.First;
      result := CompQuery.Active;
    except
      ShowAlert(atWarnAlert, errCompsConnection);
      exit;
    end;
  PageControl.ActivePage := tabList;
end;

function TCompsDBList.ConnectToDB: Boolean;
begin
  result := FindAll;
end;




procedure TCompsDBList.LoadColumnList;
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  TLCustomize.ClearNodes;
  for I := 0 to dxDBGrid.ColumnCount - 1 do
  begin
    Node := TLCustomize.Add;
    Node.Values[PrefPageFieldNameCol] := dxDBGrid.Columns[I].Caption;
    if dxDBGrid.Columns[I].Visible then
      Node.Values[PrefPageVisibleCol] := TLCustomizeColumn2.ValueChecked;
    Node.Data := dxDBGrid.Columns[I];
  end;
end;

procedure TCompsDBList.LoadCustFieldNames;
var
  column: TdxDBTreeListColumn;
  colName: String;
  index: Integer;
  sqlStr: String;
begin
try
  for index := 1 to 3 do
    with ListDMMgr.CompCFNQuery do
      begin
        Active := False;
        sqlStr := Format(sqlString1,[userTableName]) +
                            Format(sqlString3,[custFldNameID, IntToStr(index)]);
        SQL.Clear;
        SQL.Add(sqlStr);
        Active := True;
        colName := FieldByName(CustFldNameFldName).AsString;
        //List view
        column := dxDBGrid.ColumnByFieldName(custValueFieldNames[index]);
        column.Caption := colName;
        //editView
        UserGrid.Cell[1,index] := colName;
    end;
except on E:Exception do
shownotice('LoadCustFieldNames: '+e.Message);
end;
end;


(*
//FUTURE USE
//this is here so when Comps is modeless, we can switch grid based on report
function TCompsLIst.Report2GridType(ReportTyp: Integer): Integer;
begin
  case ReportTyp of
    1 :       result := cCompTypURAR;
    37,93:    result := cCompTyp2055;
    39:       result := cCompTyp2065;
    7 :       result := cCompTypCondo;
    87:       result := cCompTypERC;
    9 :       result := cCompTypLand;
    11:       result := cCompTypMobil;
    13,14:    result := cCompTyp704;
  else
    result := cCompTypURAR;
  end;
end;
*)

procedure TCompsDBList.GridTypeChange(Sender: TObject);
begin
  CompGrid := cmbxGridType.ItemIndex;
end;

procedure TCompsDBList.SetGridType(Value: Integer);
begin
  if value <> FGridType then  //we are changing
    begin
      FGridType := Value;
      SetupDetailGridNames(value);
      LoadFieldList(1);
      LoadFieldList(2);
    end;
end;

procedure TCompsDBList.SetupDetailGridNames(ViewID: Integer);
var
  i: Integer;
  isGridEdited: Boolean;
begin
  isGridEdited := FModified; // we do not have to change FFmodified just because we
                            //change the view
  case ViewID of
    cCompTypURAR:   FCurGridNames := compNamesUrar;
    cCompTyp2055:   FCurGridNames := compNames2055;
    cCompTyp2065:   FCurGridNames := compNames2065;
    cCompTypCondo:  FCurGridNames := compNamesCondo;
    cCompTypERC:    FCurGridNames := compNamesERC;
    cCompTypLand:   FCurGridNames := compNamesLand;
    cCompTypMobil:  FCurGridNames := compNamesMobil;
    cCompTyp704:    FCurGridNames := compNames704;
    // cCompTypSmInc:  GridNames := compNamesSmInc;
  else
    FCurGridNames := compNamesUrar;
  end;

  ValuesGrid.Rows := FCurGridNames.NumRows;
  with ValuesGrid do
    For i := 1 to Rows do
      begin
        Cell[1,i] := FCurGridNames.DisplayNames1[i];
        Cell[2,i] := '';
        Cell[4,i] := FCurGridNames.DisplayNames2[i];
        Cell[5,i] := '';
      end;
  FModified := isGridEdited;
end;

procedure TCompsDBList.CloseDb;
begin
  ListDMMgr.CompQuery.Active := False;
  ListDMMgr.CompCFNQuery.Active := False;
  ListDMMgr.CompPhotoQuery.Active := False;
  ListDMMgr.CompConnect.Connected := False;
end;

procedure TCompsDBList.ConnectionClose(Sender: TObject);
begin
  Close;
end;

procedure TCompsDBList.SavePrefs;
var
  IniFilePath: String;
  PrefFile: TMemIniFile;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
    appPref_AutoSaveComps := chkAutoSaveComps.Checked;
    appPref_AutoSaveSubject := chkAutoSaveSubject.Checked;
    appPref_ConfirmCompsSaving := chkConfirmCompsSaving.Checked;
    appPref_ConfirmSubjectSaving := chkConfirmSubjectSaving.Checked;
    if cbxSaveListPrefs.Checked then
      dxDBGrid.SaveToIniFile(FGridIniFile);

    with PrefFile do
      begin
        //Saving Comps DB
        WriteBool('CompsDB', 'AutoSaveComps', appPref_AutoSaveComps);
        WriteBool('CompsDB', 'AutoSaveSubject', appPref_AutoSaveSubject);
        WriteBool('CompsDB', 'ConfirmCompsSaving', appPref_ConfirmCompsSaving);
        WriteBool('CompsDB', 'ConfirmSubjectSaving', appPref_ConfirmSubjectSaving);

        UpdateFile;      // do it now
    end;
  finally
    PrefFile.Free;
  end;
end;


procedure TCompsDBList.OnClose(Sender: TObject; var Action: TCloseAction);
begin
  if FModified then
    if OK2Continue('Do you want to save the changes to this comparable record?') then
      SaveRecord;

  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  if assigned(FDocListTable) then
    FDocListTable.Free;

  SavePrefs;

  CloseDB;
  FreeImages;

  RememberStuff;

  CompsDBList := nil;
  Action := caFree;
end;

procedure TCompsDBList.RememberStuff;
begin
  appPref_CompEqualState := cbxCmpEqualSubjState.checked;
  appPref_CompEqualZip := cbxCmpEqualSubjZip.checked;
  appPref_CompEqualCounty := cbxCmpEqualSubjCounty.checked;
  appPref_CompEqualNeighbor := cbxCmpEqualSubjNeighbor.checked;
  appPref_CompEqualMapRef := cbxCmpEqualSubjMap.checked;
  appPref_CompSavePrefs := cbxSaveListPrefs.Checked;

  //appPref_CompLastTabShown := PageControl.ActivePageIndex;
end;

{**************************************************}
{  Utility routines for loading data into the grids}
{**************************************************}
procedure TCompsDBList.LoadSixFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 6 do
    begin
      fldName := strArray[index];
      grid.Cell[colNo,index] := ListDMMgr.CompQuery.FieldByName(fldName).AsString;
    end;
end;

procedure TCompsDBList.SaveSixFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 6 do
    begin
      fldName := strArray[index];
      ListDMMgr.CompQuery.FieldByName(fldName).AsString := grid.Cell[colNo,index];
    end;
end;

procedure TCompsDBList.SaveSixFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
var
  strVal: String;
  valInt: Integer;
  valReal: Double;
begin
{arrSixNames = ('TotalRooms','BedRooms','BathRooms','GrossLivArea','Age','NoStories');}
  strVal := grid.Cell[2,1];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('TotalRooms').AsInteger := valInt;

  strVal := grid.Cell[2,2];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('BedRooms').AsInteger := valInt;

  strVal := grid.Cell[2,3];
  if HasValidNumber(strVal, valReal) then
    ListDMMgr.CompQuery.FieldByName('BathRooms').AsFloat := valReal;

  strVal := grid.Cell[2,4];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('GrossLivArea').AsInteger := valInt;

  strVal := grid.Cell[2,5];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('Age').AsInteger := valInt;

  ListDMMgr.CompQuery.FieldByName('NoStories').AsString := grid.Cell[2,6];
end;


procedure TCompsDBList.LoadThreeFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 3 do
    begin
      fldName := strArray[index];
      grid.Cell[colNo,index] := ListDMMgr.CompQuery.FieldByName(fldName).AsString;
    end;
end;
procedure TCompsDBList.SaveThreeFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 3 do
    begin
      fldName := strArray[index];
      ListDMMgr.CompQuery.FieldByName(fldName).AsString := grid.Cell[colNo,index];
    end;
end;
(*
procedure TCompsList.SaveThreeFieldsFromGridCol_A(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
var
  fldName: String;
  strVal: String;
  valDate: TDateTime;
  index: Integer;
begin
  {arrThreeNames = ('SalesDate','PrevSaleDate','Prev2SaleDate');}
  strVal := grid.Cell[1,1];
  strVal := grid.Cell[1,2];
  strVal := grid.Cell[1,3];

  for index := 1 to 3 do
    begin
      fldName := strArray[index];
      ListDMMgr.CompQuery.FieldByName(fldName).AsString := grid.Cell[colNo,index];
    end;
end;
*)
procedure TCompsDBList.SaveThreeFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
var
  strVal: String;
  valInt: Integer;
begin
  {arrThreeNames = ('SalesPrice','PrevSalePrice','Prev2SalePrice'); }
  strVal := grid.Cell[2,1];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('SalesPrice').AsInteger := valInt;

  strVal := grid.Cell[2,2];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('PrevSalePrice').AsInteger := valInt;

  strVal := grid.Cell[2,3];
  if IsValidInteger(strVal, valInt) then
    ListDMMgr.CompQuery.FieldByName('Prev2SalePrice').AsInteger := valInt;
end;

procedure TCompsDBList.LoadFieldList(listNo: Integer);
var
  curName: String;
  index: Integer;
  Names: NameList;
  colNo: Integer;
begin
  if listNo = 1 then
    begin
      colNo := 2;
      Names := FCurGridNames.FieldNames1;
    end
  else
    if listNo = 2 then
      begin
        colNo := 5;
        Names := FCurGridNames.FieldNames2;
      end
    else  //never happens
      exit;

  for index := 1 to FCurGridNames.NumRows do
    begin
      curName := Names[index];
      if Length(curName) > 0 then
        valuesGrid.Cell[colNo,index] := ListDMMgr.CompQuery.FieldByName(curName).AsString;
    end;
end;

procedure TCompsDBList.SaveFieldList(listNo: Integer);
var
  curName: String;
  index: Integer;
  Names: NameList;
  colNo: Integer;
begin
  if listNo = 1 then
    begin
      colNo := 2;
      Names := FCurGridNames.FieldNames1;
    end
  else
    if listNo = 2 then
      begin
        colNo := 5;
        Names := FCurGridNames.FieldNames2;
      end
    else  //never happens
      exit;
  for index := 1 to FCurGridNames.numRows do
    begin
      curName := Names[index];
      if Length(curName) > 0 then
        ListDMMgr.CompQuery.FieldByName(curName).AsString := ValuesGrid.Cell[colNo,index];
    end;
end;

procedure TCompsDBList.LoadCurRecToDetailView;
var
  index: Integer;
  reportType, dateStr: String;
  cDate, mDate: TDateTime;
begin
  //grids
try
  LoadSixFieldsToGridCol(addressGrid,2, addrGridDBFieldNames);
  LoadSixFieldsToGridCol(specsGrid,2, specsGridDBFieldNames);
  LoadSixFieldsToGridCol(locGrid,2, locGridDBFieldNames);
  LoadThreeFieldsToGridCol(SalesGrid,1, saleDateDBNames);
  LoadThreeFieldsToGridCol(SalesGrid,2, SalePriceDBNames);
  LoadThreeFieldsToGridCol(SalesGrid,3, SaleSourceDBNames);
  LoadThreeFieldsToGridCol(UserGrid,2, custValueFieldNames);

  //reportType
  reportType := ListDMMgr.CompQuery.FieldByName(ReportTypFldName).AsString;
  index := cmbxGridType.Items.IndexOf(reportType);
  if index < 0 then index := 0; //default URAR
  cmbxGridtype.ItemIndex := index;

  //record, Create and Modify Dates
  lblCompsID.Caption := ListDMMgr.CompQuery.FieldByName(compIDfldName).AsString;

  cDate := ListDMMgr.CompQuery.FieldByName(createDateFldName).AsDateTime;
  mDate := ListDMMgr.CompQuery.FieldByName(modifDateFldName).AsDateTime;

  dateStr := '';
  if cDate <> 0 then
    DateTimeToString(dateStr, 'mm/dd/yyyy', cDate);
  lblCreateDate.Caption := dateStr;

  dateStr := '';
  if mDate <> 0 then
  DateTimeToString(dateStr, 'mm/dd/yyyy', mDate);
  lblModDate.Caption := dateStr;

  //Field Lists
  LoadFieldList(1);
  LoadFieldList(2);

  //Comment
  CompNote.Text := ListDMMgr.CompQuery.FieldByName(commentFldName).AsString;
except on E:Exception do
ShowNotice('LoadCurRecToDetailView: '+e.Message);
end;
end;


function TCompsDBList.ReCalculateAge(age:Integer; ModifiedDate: String): Integer;
var
  mDate, cDate: TDateTime;
  days, years: Integer;
begin
  result := age;
  try
    if (FAge = 0) and (not ListDMMgr.CompQuery.EOF) then
      FAge := ListDMMgr.CompQuery.FieldByName('age').asInteger;
    if FAge <> age then exit;  //age is changed.  Do not recalculate.
    if IsValidDate(ModifiedDate, mDate, True) then
    cDate := now;
    days  := DateUtils.DaysBetween(cDate, mDate);
    years := round(days/365);
    result := age + years;
  except ; end;
end;

procedure TCompsDBList.SaveRecord;
var
  reportType, ExtraComment: String;
begin
  FModifiedDate := ListDMMgr.CompQuery.FieldByName('ModifiedDate').AsString;

  ListDMMgr.CompQuery.Edit;
  try
  //grids
  SaveSixFieldsFromGridCol(addressGrid,2, addrGridDBFieldNames);
  SaveSixFieldsFromGridCol_B(specsGrid,2, specsGridDBFieldNames);
  SaveSixFieldsFromGridCol(locGrid,2, locGridDBFieldNames);
  SaveThreeFieldsFromGridCol(SalesGrid,1, saleDateDBNames);
  SaveThreeFieldsFromGridCol_B(SalesGrid,2, SalePriceDBNames);
  SaveThreeFieldsFromGridCol(SalesGrid,3, SaleSourceDBNames);
  SaveThreeFieldsFromGridCol(UserGrid,2, custValueFieldNames);

  //reportType
  reportType := cmbxGridType.Items[cmbxGridType.ItemIndex];
  if length(reportType)=0 then reportType := 'Unknown';
  ListDMMgr.CompQuery.FieldByName(ReportTypFldName).AsString := reportType;

  //Field Lists
  SaveFieldList(1);
  SaveFieldList(2);

  //Comment
  ListDMMgr.CompQuery.FieldByName(commentFldName).AsString := CompNote.Text;

  //Set New Modified Date
  ListDMMgr.CompQuery.FieldByName(modifDateFldName).AsDateTime := Date;

  ExtraComment := LoadSpecificFieldsToComment(TContainer(Fdoc), ListDMMgr.CompQuery.FieldByName(commentFldName).AsString);
  if ExtraComment <> '' then
    ListDMMgr.CompQuery.FieldByName(CommentFldName).asString := ExtraComment;

  //Recalculate Age based on SalesDate NOT Modified date and current date
  ListDMMgr.CompQuery.FieldByName('Age').asInteger := ReCalculateAge(ListDMMgr.CompQuery.FieldByName('Age').AsInteger,
                                                      FModifiedDate);

  ListDMMgr.CompQuery.UpdateBatch(arCurrent);

  OnRecChanged;

  FModified := False;  //reset the modified flag after we save the record

  except
    on E: Exception do ShowNotice(E.Message);
  end;
end;

procedure TCompsDBList.NewRecord(ImportOption: Integer; CompsID:Integer; Addr:AddrInfo; EffectiveDate:String='');   //when compsid > 0 means record exists
var
  reportType: String;
  where:String;
begin
  if ImportOption = 0 then  //saving
  begin
    if not appPref_SavingUpdate then //if the setting is True means we want to do an update if record exists
      CompsID := 0;  //Force to do an insert
  end
  else
  begin
    if not appPref_ImportUpdate then //if the setting is True means we want to do an update if record exists
      CompsID := 0;  //Force to do an insert
  end;
  if FModified then
    SaveRecord;

  if not FModified then    //a good save= (FModified = False)
    with ListDMMgr.CompQuery do
      begin
        where := '';
        if CompsID > 0 then
        begin
          where := Format(' Where CompsID = %d',[CompsID])
        end
        else if (length(Addr.StreetNum) > 0) and (length(Addr.StreetName) > 0) then
        begin
          where := SetupWHERE(Addr);
        end;
        Active := False;
        SQL.Text := 'Select * From COMPS ';
        SQL.Text := SQL.Text + Where;
        Active := True;

        //Append a new record if not exists
        if CompsID = 0 then
        begin
          Append;
          SetFieldsDefault;
//          if EffectiveDate <> '' then
//            FieldByName(createDateFldName).AsString := EffectiveDate
//          else
            FieldByName(createDateFldName).AsDateTime := Date;
        end
        else
        begin
          if eof then
          begin
            CompsID := 0;
            Append;
            SetFieldsDefault;
            FieldByName(createDateFldName).AsDateTime := Date;
          end
          else
          begin
            First;
            while not eof do
            begin
              if FieldByname('CompsID').AsInteger = CompsID then
              begin
                //remove photo for existing record if there's one
                RemovePhotos(CompsID, True);
                break;
              end
              else
                Next;
            end;
          end;
        end;
        Edit;
        FieldByName(modifDateFldName).AsDateTime := Date;
        reportType := cmbxGridType.Items[cmbxGridType.ItemIndex];
        if length(reportType)=0 then reportType := 'Unknown';
        FieldByName(ReportTypFldName).AsString := reportType;
        try
          UpdateBatch(arCurrent);
        except end;
        //Refresh;
        if CompsID = 0 then
          Last;
        OnRecChanged;
      end;
end;


procedure TCompsDBList.DeleteRecord;
var
  cmpID: Integer;
  {ok2Delete: Boolean;}
begin
  //if OK2Continue(warnMsg2) then
    begin
      cmpID := ListDMMgr.CompQuery.FieldByName(compIDfldName).AsInteger;
      ListDMMgr.CompQuery.Delete;

      //if there are photo records
      //if ListDMMgr.CompPhotoQuery.RecordCount > 0 then
        begin
(*
          if rdoDeletePhotoOption.ItemIndex = poNeverDelete then
            ok2Delete := False
          else begin
            ok2Delete := rdoDeletePhotoOption.ItemIndex = poAlwaysDelete;
            if not ok2Delete then
              ok2Delete := WarnOK2Continue(warnMsg3);
          end;
*)
          RemovePhotos(cmpID, True);
        end;

      OnRecChanged;
      if ListDMMgr.CompPhotoQuery.RecordCount = 0 then
        FreeImages;
      SetEditMode(False);
    end;
end;

procedure TCompsDBList.OnGridEdit(Sender: TObject; DataCol, DataRow: Integer;
  ByUser: Boolean);
begin
  if (sender = UserGrid) and (DataCol = 1) then  //Customized names
    SaveCustFieldNames(DataRow)
  else
    FModified := True;
end;

procedure TCompsDBList.OnCommentChanged(Sender: TObject);
begin
  If TMemo(sender).Modified then
    FModified := True;
end;

procedure TCompsDBList.GetPhotoData;
var
  curCompID: Integer;
begin
try
  with ListDMMgr.CompPhotoQuery do
    begin
      Active := False;
      SQL.Clear;
      if not ListDMMgr.CompQuery.FieldByName(compIDfldName).isNull then
        curCompID := ListDMMgr.CompQuery.FieldByName(compIDFldName).AsInteger
      else //new record
        curCompID := 0;
      SQL.Add(Format(sqlString1,[photoTableName]) + Format(sqlString3,[compIDFldName,IntToStr(curCompID)]));
      Active := True;
  end;
except on E:Exception do
shownotice('GetPhotoData: '+e.Message);
end;
end;

procedure TCompsDBList.LoadImages;
var
  nRecs,rcNo: Integer;
  imgPath: String;
  imgDesc: String;
  thumOrig: TPoint;
  thumb: TThumbEx;
begin
try
  PushMouseCursor(crHourglass);
  LockWindowUpdate(ScrollBox.Handle);
  try
    FreeImages;
    if FCompDBPhotosDir = '' then
      FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;

    with ListDMMgr.CompPhotoQuery do
    begin
      nRecs := RecordCount;
      First;
      thumOrig.X := gap;
      thumOrig.Y := gap;

      for rcNo := 1 to nRecs do
        begin
          imgPath := '';
          imgDesc := '';
          if FieldByName(imgPathTypeFldName).AsBoolean then //FileName keeps just fileName
            imgPath := IncludeTrailingPathDelimiter(FCompDBPhotosDir) + FieldByName(imgFnameFldName).AsString
          else
            imgPath := FieldByName(imgFnameFldName).AsString; //fullPath
          imgDesc := FieldByName(imgDescrFldName).AsString;

          thumb := TThumbEx.Create(Scrollbox,thumOrig,rcNo,imgPath,imgDesc);
          if (thumb<>nil) and  assigned(thumb) then
          begin
            thumb.FOnActivateImage := ActivateThumbs;
            thumb.FOnDescrEnter := DesactivateThumbs;
            thumb.FOnDescrEdited := OnEditImgDescr;
            thumb.FOnImageDelRequired := DeletePhoto;

            SetLength(FThumbNailList,Length(FThumbNailList) + 1);
            FThumbNailList[High(FThumbNailList)] := thumb;
          end;
          Next;
          inc(thumOrig.Y, FullImagHeight + Gap+ gap+ gap);
      end;
    end;
  finally
    LockWindowUpdate(0);
    PopMouseCursor;
  end;
except on E:Exception do
showNotice('LoadImages: '+e.Message);
end;
end;

procedure TCompsDBList.FreeImages;
var
  curImg, nImgs: Integer;
begin
  FActiveThumb := nil;
  nImgs := High(FThumbNailList);
//  for curImg := low(FThumbNailList) to nImgs do
  for curImg := nImgs downto low(FThumbNailList) do
  begin
    if FThumbNailList[curImg].FImage.Picture.Graphic<>nil then
      FThumbNailList[curImg].FImage.Picture.Graphic.Assign(nil);
    if FThumbNailList[curImg].FImage <> nil then
      FThumbNailList[curImg].FImage.Parent := nil;
    if FThumbNailList[curImg].imgFrame <> nil then
      FThumbNailList[curImg].imgFrame.Parent := nil;
    if FThumbNailList[curImg].imgEditDescr <> nil then
      FThumbNailList[curImg].imgEditDescr.Parent := nil;
//      FThumbNailList[curImg].lbImgNo.Parent := nil;
  end;
  SetLength(FThumbNailList,0);
end;

procedure  TCompsDBList.ActivateThumbs(sender: TObject);
var
  imgNo: Integer;
begin
  FActiveThumb := nil;
  for imgNo := Low(FThumbNailList) to High(FThumbNailList) do
    if FThumbNailList[imgNo] = sender then
      begin
        FThumbNailList[imgNo].ActivateImg(True);
        FActiveThumb := FThumbNailList[imgNo];
      end
    else
      FThumbNailList[imgNo].ActivateImg(False);
end;

procedure TCompsDBList.DesactivateThumbs(sender: TObject);
var
  imgNo: Integer;
begin
  FActiveThumb := nil;
  for imgNo := Low(FThumbNailList) to High(FThumbNailList) do
    FThumbNailList[imgNo].ActivateImg(False);
end;

procedure TCompsDBList.OnEditImgDescr(sender: TObject);
begin
  with  ListDMMgr.CompPhotoQuery do
    begin
      RecNo := TThumbEx(sender).imgID;
      Edit;
      FieldValues[imgDescrFldName] := TThumbEx(sender).GetImageDescr;
      Post;
    end;
end;

procedure TCompsDBList.DeletePhoto(sender: TObject);
var
  img: TThumbEx;
begin
  with ListDMMgr.CompPhotoQuery do
    begin
      img := TThumbEx(sender);
      RecNo := img.imgID;

      if WarnOK2Continue(warnMsg7) then
        begin
          Delete;
          if FileExists(img.imgPath) then
            DeleteFile(img.imgPath);

          //this is terrible
          SaveRecord;
          LoadImages;
        end;
    end;
end;

//user selected Photo/Add menu item
procedure TCompsDBList.ClickAddPhoto(Sender: TObject);
var
  newFileName: String;
begin
  Randomize;
  if DirectoryExists(appPref_DirPhotos) then
    OpenImgDialog.InitialDir := VerifyInitialDir(appPref_DirPhotos, '');

  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  if OpenImgDialog.Execute then
    with ListDMMgr.CompPhotoQuery do
      begin
        newFileName := ExtractFileName(OpenImgDialog.FileName);
        newFileName := IntToStr(ListDMMgr.CompQuery.FieldValues[compIDFldName]) + '_' +
                              IntToStr(RandomRange(250,999)) + '_' + newFileName;
        while fileExists(IncludeTrailingPathDelimiter(FCompDBPhotosDir) + newFileName) do
          newFileName := IntToStr(ListDMMgr.CompQuery.FieldValues[compIDFldName]) + '_' +
                              IntToStr(RandomRange(250,999)) + '_' + newFileName;
        if CopyFile(PChar(OpenImgDialog.FileName),
              PChar(IncludeTrailingPathDelimiter(FCompDBPhotosDir) + newFileName),False) then

          begin
            Append;
            FieldValues[compIDFldName] := ListDMMgr.CompQuery.FieldValues[compIDFldName];
            FieldValues[imgDescrFldName] := '';
            FieldValues[imgPathTypeFldName] := True;
            FieldValues[imgFNameFldName] := newFileName;
            UpdateBatch(arCurrent);
            LoadImages;
          end;
      end;
end;

//user selected Photo/Delete manu item
procedure TCompsDBList.ClickDeletePhoto(Sender: TObject);
begin
  if FActiveThumb <> nil then
    DeletePhoto(FActiveThumb)
  else
    ShowNotice('There are not any selected Photos.');
end;

//user selected Photo/View menu item
procedure TCompsDBList.ClickViewPhoto(Sender: TObject);
begin
  if FActiveThumb <> nil then
    FActiveThumb.ViewImage;
end;

procedure TCompsDBList.ClickRestoreDefaults(Sender: TObject);
var
  colNo: Integer;
  col: TDxDbTreeListColumn;
  nameList: TStringList;
begin
  nameList := TStringList.Create;
  try
    with dxDBGrid do
      begin
        for colNo := 0 to ColumnCount - 1 do   //I can't reorder columns using their index
          NameList.Add(Columns[colNo].FieldName);

        for colNo := 0 to nameList.Count - 1 do
          begin
            col := ColumnByFieldName(nameList.Strings[colNo]);
            col.ColIndex := col.Tag;          // restore the original column position
            col.Visible := True;              //make the  column visible
            col.Width := col.DefaultWidth;    //set the default width
          end;
      end;
  finally
    nameList.Free;
    LoadColumnList;    //syncronize the preference view with grid
  end;
end;

procedure TCompsDBList.SaveCustFieldNames(custFldNo: Integer);
var
  column: TdxDBTreeListColumn;
  colName: String;
  sqlStr: String;
begin
  with ListDMMgr.CompCFNQuery do
    begin
      Active := False;
      sqlStr := Format(sqlString1,[userTableName]) +
                          Format(sqlString3,[custFldNameID, IntToStr(custFldNo)]);
      SQL.Clear;
      SQL.Add(sqlStr);
      Active := True;
      Edit;
      colName := UserGrid.Cell[1,custFldNo];
       //List view
      column := dxDBGrid.ColumnByFieldName(custValueFieldNames[custFldNo]);
      column.Caption := colName;
      //DB
      FieldByName(CustFldNameFldName).AsString := colName;
      UpdateBatch(arCurrent);
  end;
end;

procedure TCompsDBList.LoadReportCompTables;
var
  newMItem: TMenuItem;
  col: Integer;
  bAllCompsEmpty: Boolean;
  bCompsExist: Boolean;
begin
  if not assigned(FDoc) then      //no documents
    exit;
  bCompsExist := False;
  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  if assigned(FDocListTable) then
    FDocListTable.Free;

  FDocCompTable := TCompMgr2.Create(True);
  FDocCompTable.BuildGrid(FDoc, gtSales);
  FDocListTable := TCompMgr2.Create(True);
  FDocListTable.BuildGrid(FDoc, gtListing);

  if (FDocCompTable.Count > 0) or (FDocListTable.Count > 0) then      //subject
    begin
      bCompsExist := True;
      //Import menu {Subject}
      RecordImportMItem.Clear;
      RecordExportMItem.Clear;
      newMItem := TMenuItem.Create(self);
      newMItem.Caption := 'Subject';
      newMItem.Tag := 0;
      newMItem.OnClick := ImportSubjectMenuClick;
      RecordImportMItem.Add(newMItem);
    end;
  if (FDocCompTable.Count > 0) then
    begin
      //Import Menu {Comps}
      bAllCompsEmpty := True;
      for col := 1 to FDocCompTable.Count - 1 do
        if not FDocCompTable.Comp[col].IsEmpty then
          begin
            bAllCompsEmpty := False;
            newMItem := TMenuItem.Create(self);
            newMItem.Caption := 'Comp ' + IntToStr(col);
            newMItem.Tag := col;
            newMItem.OnClick := ImportCompMenuClick;
            RecordImportMItem.Add(newMItem);
          end;
       //All Comps Menu Item
       if not bAllCompsEmpty then
        begin
          newMItem := TMenuItem.Create(self);
          newMItem.Caption := 'All Comps';
          newMItem.OnClick := ImportAllCompsMenuClick;
          RecordImportMItem.Add(newMItem);
          newMItem.MenuIndex := 1;
        end;
      //Export menu
      RecordExportMItem.Clear;
      for col := 1 to FDocCompTable.Count - 1 do
        begin
          newMItem := TMenuItem.Create(self);
          newMItem.Caption := 'Comp ' + IntToStr(col);
          newMItem.Tag := col;
          newMItem.OnClick := ExportCompMenuClick;      //ExportRecMenuItemClick;
          RecordExportMItem.Add(newMItem);
        end;
    end;
  if (FDocListTable.Count > 0) then      //listings
    begin
      //Import Menu {Listing}
      bAllCompsEmpty := True;
      for col := 1 to FDocListTable.Count - 1 do
        if not FDocListTable.Comp[col].IsEmpty then
          begin
            bAllCompsEmpty := False;
            newMItem := TMenuItem.Create(self);
            newMItem.Caption := 'Listing ' + IntToStr(col);
            newMItem.Tag := col;
            newMItem.OnClick := ImportListingMenuClick;
            RecordImportMItem.Add(newMItem);
          end;
       //All Listing Menu Item
       if not bAllCompsEmpty then
        begin
          newMItem := TMenuItem.Create(self);
          newMItem.Caption := 'All Listing';
          newMItem.OnClick := ImportAllListingsMenuClick;
          RecordImportMItem.Add(newMItem);
          newMItem.MenuIndex := 1;
        end;
      //Export menu
      if not bCompsExist then
        RecordExportMItem.Clear;
      for col := 1 to FDocListTable.Count - 1 do
        begin
          newMItem := TMenuItem.Create(self);
          newMItem.Caption := 'Listing ' + IntToStr(col);
          newMItem.Tag := col;
          newMItem.OnClick := ExportListingMenuClick;      //ExportRecMenuItemClick;
          RecordExportMItem.Add(newMItem);
        end;
    end;
end;

function TCompsDBList.SetupWHERE(Addr: AddrInfo):String;
var
  where: String;
begin
  result := '';
  if (Addr.StreetNum <> '') or (Addr.StreetName <> '') then
    begin
      where := 'WHERE '+ SetKeyValue('StreetNumber', Addr.StreetNum);
      where := where + ' AND ' + SetKeyValue('StreetName',Addr.StreetName);
      where := where + ' AND ' + SetKeyValue('City', Addr.City);
      where := where + ' AND ' + SetKeyValue('State', Addr.State);
      where := where + ' AND ' + SetKeyValue('Zip', Addr.Zip);
      if Addr.UnitNo <> '' then
        where := where + ' AND '+ SetKeyValue('UnitNo', Addr.UnitNo);
      result := Where;
    end;
end;

function TCompsDBList.FindRecord(Addr: AddrInfo):Integer;
var
  where: String;
begin
  result := 0;
  with Q1 do begin
    Active := False;
    SQL.Text := 'SELECT * FROM COMPS ';
    where := SetupWHERE(Addr);
    SQL.Text := SQL.Text + where;
    Active := True;
    if not Q1.EOF then
      begin
        result := Q1.FieldByName('CompsID').AsInteger;
        FAge := Q1.FieldByName('Age').AsInteger;
        FModifiedDate := Q1.FieldByName('ModifiedDate').AsString;
      end;
  end;
end;

(*
procedure TCompsDBList.GetGEOCode(var prop: AddrInfo);
var
  geoCoder: TGeoCoder;
  FullAddress, accuracy: String;
begin
    GeoCoder := TGeoCoder.Create(nil);
    try
      FullAddress := GetFullAddress(prop.StreetNum,prop.StreetName,prop.City,prop.State,prop.Zip);
      GeoCoder.GetGeoCodeProperty(FullAddress, accuracy, prop.lat, prop.lon);
    finally
      GeoCoder.Free;
    end;
end;
*)


procedure TCompsDBList.ImportSubject(ImportOption:Integer = 0);
var
  SubjCol: TCompColumn;
  StreetAddress: String;
  strVal: String;
  valInt: Integer;
  valDate: TDateTime;
  valReal: Double;
  fldName: String;
  n, fldID: Integer;
  CompsID: Integer;
  prop: AddrInfo;
  GeoCodedCell: TGeocodedGridCell;
  EffectiveDate, ExtraComment: String;
begin
  try
  // If we have grid, use it
  //  if Assigned(FDocCompTable) then
    if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
      SubjCol := FDocCompTable.Comp[0]    //subject column
    else if Assigned(FDocListTable) and (FDocListTable.Count > 0) then
      SubjCol := FDocListTable.Comp[0];
    if assigned(SubjCol) and not SubjCol.IsEmpty then begin
      // Get report subject geocodes
      prop.Lat := '';  prop.Lon := '';  //clear before fill in
      if (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
      begin
        GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
        if GeocodedCell.Latitude <> 0 then
          prop.lat := FloatToStr(GeocodedCell.Latitude);
        if GeocodedCell.Longitude <> 0 then
          prop.lon := FloatToStr(GeocodedCell.Longitude);
      end;
    end;

    StreetAddress := TContainer(FDoc).GetCellTextByID(46);
    prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
    prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

    prop.City := TContainer(FDoc).GetCellTextByID(47);
    prop.State := TContainer(FDoc).GetCellTextByID(48);
    prop.Zip := TContainer(FDoc).GetCellTextByID(49);
    prop.UnitNo := TContainer(FDoc).GetCellTextByID(2141);

    //if no lat/lon from report, get from bingmap
//    if (length(prop.lat)=0) or (length(prop.lon)=0) then
//    begin
//      GetGEOCode(prop);
//    end;
    //if no address donot import subject
    if (length(prop.StreetNum) = 0) and (length(prop.StreetName) =0) and (length(prop.City)=0) and
       (length(prop.State)=0) and (length(prop.Zip) = 0) then exit;

    CompsID := FindRecord(prop);

    EffectiveDate := '';
    //Use effective date or current date for sales date from
//    if assigned(FDoc) then
//      EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
    NewRecord(ImportOption,CompsID,prop, EffectiveDate);
    FModified:= True;
    ProgressBar := TCCProgress.Create(self, False, 0, 2, 1, 'Saving Subject ...');
    ProgressBar.IncrementProgress;
    try
    with ListDMMgr.CompQuery do
      begin
        Edit;
        //Only update lat/lon if they are empty in the table
        if FieldByname('Latitude').AsString = '' then
          FieldByName('Latitude').AsString := prop.Lat;
        if FieldByname('Longitude').AsString = '' then
          FieldByName('Longitude').AsString := prop.Lon;

        StreetAddress := TContainer(FDoc).GetCellTextByID(46);

        FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
        FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

        //load rest of header direct from report
        for n := 0 to FHeadCellIDMap.Count-1 do
          begin
            fldName := FHeadCellIDMap.Names[n];
            fldID  := StrToIntDef(FHeadCellIDMap.Values[fldName], 0);

            case fldID of
              930:
                begin
                  FieldByName(fldName).AsString := TContainer(FDoc).GetCellTextByID(fldID);
                end;
              947:   //'"SalesPrice=447"
                begin
                  strVal := TContainer(FDoc).GetCellTextByID(fldID);
                  if IsValidInteger(strVal, valInt) then
                    FieldByName(fldName).AsInteger := valInt;
                end;
              960:    //'"SalesDate=448",'+
                begin
                  strVal := TContainer(FDoc).GetCellTextByID(fldID);
                  //valDate := GetValidDate(strVal);
                  if ExtractDate(strVal, valDate) then
                 // if valDate > 0 then
                    FieldByName(fldName).AsDateTime := valDate;
                end;
              {
              447:   //'"SalesPrice=447"
                begin
                  strVal := TContainer(FDoc).GetCellTextByID(fldID);
                  if IsValidInteger(strVal, valInt) then
                    FieldByName(fldName).AsInteger := valInt;
                end;
              448:    //'"SalesDate=448",'+
                begin
                  strVal := TContainer(FDoc).GetCellTextByID(fldID);
                  valDate := GetValidDate(strVal);
                  if valDate > 0 then
                    FieldByName(fldName).AsDateTime := valDate;
                end;}
            else
              if fldID > 0 then
                FieldByName(fldName).AsString := TContainer(FDoc).GetCellTextByID(fldID);
            end;
          end;

        if assigned(subjCol) then begin
          //Load the grid - it may overwrite rms, gla, design, site
          for n := 0 to FSubGridCellIDMap.count-1 do
            begin
              fldName := FSubGridCellIDMap.Names[n];
              fldID  := StrToIntDef(FSubGridCellIDMap.Values[fldName], 0);

              case fldID of
                996:    //'"Age=996",'
                 begin
                    strVal := SubjCol.GetCellTextByID(fldID);
                    if IsValidInteger(strVal, valInt) then
                      begin
                        FieldByName(fldName).AsInteger := ReCalculateAge(valInt,FModifiedDate);
                      end;
                 end;
                1041,   //'"TotalRooms=1041",'
                1042,   //'"BedRooms=1042",'
                1004:   // GrossLivArea=1004",'
                  begin
                    strVal := SubjCol.GetCellTextByID(fldID);
                    if IsValidInteger(strVal, valInt) then
                      FieldByName(fldName).AsInteger := valInt;
                  end;
                1043:     //'"BathRooms=1043",'+
                  begin
                    strVal := SubjCol.GetCellTextByID(fldID);
                    if HasValidNumber(strVal, valReal) then
                      FieldByName(fldName).AsFloat := valReal;
                  end;
              else
                if fldID > 0 then
                  FieldByName(fldName).AsString := SubjCol.GetCellTextByID(fldID);
              end;
            end;
          end;
        //update unit #
        FieldByName('UnitNo').asString := prop.UnitNo;

        ExtraComment := LoadSpecificFieldsToComment(TContainer(Fdoc), FieldByName(commentFldName).AsString);
        if ExtraComment <> '' then
          FieldByName(CommentFldName).asString := ExtraComment;

        UpdateBatch;
        FModified:= False;   //Reset modified flag here since we already save record
      end;

    OnRecChanged;
    PageControl.ActivePage := tabDetail;       //detailed view
    ImportSubPhotos;
    finally
      ProgressBar.Free;
    end;
  except on E:Exception do
    ShowNotice('ImportSubject: '+e.Message);
  end;
end;

procedure TCompsDBList.ImportComparable(Index: Integer; compType: Integer; ImportOption:Integer = 0);
var
  compCol: TCompColumn;
  n, fldID: Integer;
  strVal: String;
  valInt: Integer;
  valReal: Double;
  valDate: TDateTime;
  fldName: String;
  streetAddress: String;
  citySTZip, sCity, sState, sZip: String;
  GeoCodedCell: TGeocodedGridCell;
  CompsID: Integer;
  prop: AddrInfo;
  EffectiveDate, ExtraComment: String;
  msg: String;
  aFullBath, aHalfBath: String;
  fBath, hBath: Integer;
begin
  case compType of
    tcSales:
      CompCol :=FDocCompTable.Comp[Index];
    tcListing:
      CompCol := FDocListTable.Comp[Index];
    else
      exit;
  end;
  prop.Lat := '';  prop.Lon := '';  //clear before fill in
  // Get report subject geocodes
  if (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
  begin
    GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
    if GeocodedCell.Latitude <> 0 then
      prop.lat := FloatToStr(GeocodedCell.Latitude);
    if GeocodedCell.Longitude <> 0 then
      prop.lon := FloatToStr(GeocodedCell.Longitude);
  end;

  StreetAddress := CompCol.GetCellTextByID(925);
  prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
  prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

  cityStZip := CompCol.GetCellTextByID(926);
  GetUnitCityStateZip(prop.UnitNo, prop.City, prop.State, prop.Zip, CityStZip);

  //if no lat/lon from report, get from bingmap
//  if (length(prop.lat)=0) or (length(prop.lon)=0) then
//  begin
//    GetGEOCode(prop);
//  end;
  //if no address donot import subject
  if (length(prop.StreetNum) = 0) and (length(prop.StreetName) =0) and (length(prop.City)=0) and
     (length(prop.State)=0) and (length(prop.Zip) = 0) then exit;
  CompsID := FindRecord(prop);

  EffectiveDate := '';
  //Use effective date or current date for sales date from
//  if assigned(FDoc) then
//    EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
  NewRecord(ImportOption,CompsID,prop, EffectiveDate);

  if TContainer(FDoc).UADEnabled then
  begin
    ImportUADComparable(Index, compCol, prop.lat, prop.lon);
  end
  else
    begin
      with ListDMMgr.CompQuery do
        begin
          Edit;
          //Load header
          StreetAddress := CompCol.GetCellTextByID(925);
          FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
          FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

          //Update lat/lon to Comps Database if it's empty in the table
          if FieldByName('Latitude').AsString = '' then
            FieldByName('Latitude').AsString := prop.Lat;
          if FieldbyName('Longitude').AsString = '' then
            FieldbyName('Longitude').AsString := prop.Lon;

          cityStZip := CompCol.GetCellTextByID(926);
          if Pos(',',cityStZip) > 0 then
            begin
              sCity  := ParseCityStateZip2(cityStZip, cmdGetCity);
              sState := ParseCityStateZip2(cityStZip, cmdGetState);
              sZip   := ParseCityStateZip2(cityStZip, cmdGetZip);
            end
          else
            begin
              sCity  := ParseCityStateZip3(cityStZip, cmdGetCity);
              sState := ParseCityStateZip3(cityStZip, cmdGetState);
              sZip   := ParseCityStateZip3(cityStZip, cmdGetZip);
            end;
          if (length(sState)= 0) and cbxCmpEqualSubjState.checked then
            sState := TContainer(FDoc).GetCellTextByID(48);
          if (length(sZip)= 0) and cbxCmpEqualSubjZip.checked then
            sZip := TContainer(FDoc).GetCellTextByID(49);

          //set values for city, state zip and unit
          FieldByName('City').AsString := sCity;
          FieldByName('State').AsString := sState;
          FieldByName('Zip').AsString := sZip;

          //set additional fields
          if cbxCmpEqualSubjCounty.checked then
            FieldByName('County').AsString := TContainer(FDoc).GetCellTextByID(50);
          if cbxCmpEqualSubjNeighbor.checked then
            FieldByName('ProjectName').AsString := TContainer(FDoc).GetCellTextByID(595);
          if cbxCmpEqualSubjMap.checked then
            FieldByName('MapRef1').AsString := TContainer(FDoc).GetCellTextByID(598);

          //Load comp Grid
          for n := 0 to FGridCellIDMap.Count-1 do
            begin
              fldName := FGridCellIDMap.Names[n];
              fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);

              case fldID of
                996:    //'"Age=996",'
                 begin
                    strVal := CompCol.GetCellTextByID(fldID);
                    if IsValidInteger(strVal, valInt) then
                      begin
                        FieldByName(fldName).AsInteger := ReCalculateAge(valInt,FModifiedDate);
                      end;
                 end;
                947,    //'"SalesPrice=947",'
                1004,   //'"GrossLivArea=1004",'
                1041,   //'"TotalRooms=1041",'
                1042:   //'"BedRooms=1042",'
                  begin
                    strVal := CompCol.GetCellTextByID(fldID);
                    if IsValidInteger(strVal, valInt) then
                      FieldByName(fldName).AsInteger := valInt;
                  end;
                960:    //'"SalesDate=960",'
                  begin
                    strVal := CompCol.GetCellTextByID(fldID);
                    //valDate := GetValidDate(strVal);
                    if ExtractDate(strVal, valDate) then
                    //if valDate > 0 then
                      FieldByName(fldName).AsDateTime := valDate;
                  end;
                1043:   //'"BathRooms=1043",'
                  begin
                    strVal := CompCol.GetCellTextByID(fldID);
                    if HasValidNumber(strVal, valReal) then
                      FieldByName(fldName).AsFloat := valReal;
                  end;
                1868, 1869:    //Fullbath/half bath to go to "BathRooms = 1043"
                  begin
                    aFullBath := CompCol.GetCellTextByID(1868);
                    aHalfBath := CompCol.GetCellTextByID(1869);
                    if aFullBath <> '' then
                      begin
                        fBath := StrToIntDef(aFullBath, 0);
                        hBath := STrToIntDef(aHalfBath, 0);
                        if fBath > 0 then
                          FIeldByName('BathRooms').AsString := Format('%d.%d',[fBath, hBath]);
                      end;
                 end
              else
                if fldID > 0 then
                  if (fldID <> 1868) and (fldID <> 1869) then
                    FieldByName(fldName).AsString := CompCol.GetCellTextByID(fldID);
              end;
            end;
          ExtraComment := LoadSpecificFieldsToComment(TContainer(Fdoc), FieldByName(commentFldName).AsString);
          if ExtraComment <> '' then
            FieldByName(CommentFldName).asString := ExtraComment;
          UpdateBatch;
          FModified:= False;  //reset modified flag to False after we save

        end;

      //OnRecChanged;
      //PageControl.ActivePage := tabDetail;        //detailed view
        if assigned(compCol.Photo.Cell) then
          ImportCompPhoto(compCol);
    end;
end;

procedure TCompsDBList.ExportComparable(Index: Integer; compType: Integer);
var
  n, fldID: Integer;
  StreetAddress, CityStZip, sState,sZip: String;
  fldName, tmpStr: String;
  compCol: TCompColumn;
  msg: String;
  GeocodedCell:TGeocodedGridCell;
  lat,lon: Double;
  fBath, hBath: Integer;
  aTemp: String;
begin
  case compType of
    tcSales:
      begin
        CompCol :=FDocCompTable.Comp[Index];
        msg := Format(warnMsg1,['sale',Index]);
      end;
    tcListing:
      begin
        CompCol := FDocListTable.Comp[Index];
        msg := Format(warnMsg1,['listing',Index]);
      end;
    else
      exit;
  end;

  if not compCol.IsEmpty then
    if not WarnOK2Continue(msg) then
      exit
    else
      case compType of
        tcSales:
          FDocCompTable.ClearCompAllCells(Index, True);  //clear the photo also
        tcListing:
          FDocListTable.ClearCompAllCells(Index,true);
        else
          exit;
      end;

  if TContainer(FDoc).UADEnabled then
    ExportUADComparable(Index, compCol)
  else
    with ListDMMgr.CompQuery do
      begin
        //load the streetAddress
        StreetAddress := FieldByName('StreetNumber').AsString + ' '+ FieldByName('StreetName').AsString;
        CompCol.SetCellTextByID(925, StreetAddress);

        //load the City State Zip
        CityStZip := FieldByName('City').AsString;
        sState := FieldByName('State').AsString;
        if length(sState)> 0 then
          CityStZip := CityStZip +', '+ sState;    //need a space between city and state
        sZip := FieldByName('Zip').AsString;
        if length(sZip)> 0 then
          CityStZip := CityStZip +' '+ sZip;
        CompCol.SetCellTextByID(926, CityStZip);

        //Update Geocode lat/lon
        if (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
        begin
          GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
          if tryStrToFloat(FieldByName(latFldName).AsString, Lat) then
            GeocodedCell.Latitude := Lat;
          if tryStrToFloat(FieldByName(lonFldName).AsString, Lon) then
            GeocodedCell.Longitude := Lon;
          GeocodedCell.PostProcess;
        end;

        //add rest of grid - straight insert
        for n := 0 to FGridCellIDMap.Count-1 do
          begin
            fldName := FGridCellIDMap.Names[n];
            fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);
            if fldID > 0 then
              if (fldID = 996) then
                begin
                  tmpStr := FieldByName(fldName).AsString;
                  if appPref_AppraiserAddYrSuffix then
                    tmpStr := tmpStr + ' yrs';
                  CompCol.SetCellTextByID(fldID, tmpStr);
                end
              else
                if (fldID = 960) then //date of sales
                  begin
                    tmpStr := GetDateOfSalesCellText(false);
                    CompCol.SetCellTextByID(fldID, tmpStr);
                  end
                else if (fldID = 1043) then //Pam: this is the combine full/half bath
                  begin //we need to split the full and half bath to individual cell
                    tmpStr := FieldByName(fldName).AsString;
                    if tmpStr <> '' then
                      begin
                        CompCol.SetCellTextByID(fldID, tmpStr);   //set cell value for cellid 1043
                        aTemp := PopStr(tmpStr, '.');
                        if aTemp <> '' then
                          begin
                            fBath := StrToIntDef(aTemp, 0);
                            hBath := StrToIntDef(tmpStr, 0);
                            CompCol.SetCellTextByID(1868, Format('%d',[fBath]));
                            CompCol.SetCellTextByID(1869, Format('%d',[hBath]));
                          end;
                      end;
                  end
                else if (fldID = 1868) or (fldID = 1869)  then //do nothing
                  begin
                    //do nothing
                  end
                else
                  CompCol.SetCellTextByID(fldID, FieldByName(fldName).AsString);
          end;

        ExportCompPhoto(compCol);

        //finally do the adjustments on the new comp data
        AdjustThisComparable(FDoc, Index);
      end;
end;

procedure TCompsDBList.ImportUADComparable(Index: Integer; CompCol: TCompColumn; lat, lon: String);
const
  MaxDateVals = 10;
  SaleDateStat: array[1..MaxDateVals] of String = ('Settled sale','Settled sale',
    'Expired','Expired','Withdrawn','Withdrawn','Active','Contract','Contract','Contract');
  SaleDateVals: array[1..MaxDateVals] of String = ('s0','s1','e0','e1','w0','w1','Active','cUnk','c0','c1');
var
  n, fldID: Integer;
  strVal: String;
  valInt: Integer;
  valReal: Double;
  valDate: TDateTime;
  fldName: String;
  streetAddress: String;
  citySTZip, sCity, sState, sUnit, sZip: String;
  sUAD: String;
  CntrGSE, PosGSE: Integer;
  ExtraComment: String;
  aFullBath, aHalfBath: String;
  fBath, hBath: Integer;
begin
  with ListDMMgr.CompQuery do
    begin
      Edit;
      //Load header
      StreetAddress := CompCol.GetCellTextByID(925);
      FieldByName('StreetNumber').AsString := ParseStreetAddress(StreetAddress, 1, 0);
      FieldByName('StreetName').AsString := ParseStreetAddress(StreetAddress, 2, 0);

      //put lat/lon to the table
      //Only update lat/lon if they are empty in the table
      if FieldByname('Latitude').AsString = '' then
        FieldByName('Latitude').AsString := Lat;
      if FieldByname('Longitude').AsString = '' then
        FieldByName('Longitude').AsString := Lon;

      cityStZip := CompCol.GetCellTextByID(926);
      sUnit := '';
      PosGSE := Pos(',',cityStZip);
      if PosGSE > 0 then
        begin
          // It's a UAD report so if there is a unit number (2 commas in the address)
          //  then retrieve the unit and capture only the city, state and zip for
          //  further processing
          if Pos(',', Copy(cityStZip, Succ(PosGSE), Length(cityStZip))) > 0 then
            begin
              sUnit := Copy(cityStZip, 1, Pred(PosGSE));
              cityStZip := Copy(cityStZip, Succ(PosGSE), Length(cityStZip));
            end;
          sCity  := ParseCityStateZip2(cityStZip, cmdGetCity);
          sState := ParseCityStateZip2(cityStZip, cmdGetState);
          sZip   := ParseCityStateZip2(cityStZip, cmdGetZip);
        end
      else
        begin
          sCity  := ParseCityStateZip3(cityStZip, cmdGetCity);
          sState := ParseCityStateZip3(cityStZip, cmdGetState);
          sZip   := ParseCityStateZip3(cityStZip, cmdGetZip);
        end;
      if (length(sState)= 0) and cbxCmpEqualSubjState.checked then
        sState := TContainer(FDoc).GetCellTextByID(48);
      if (length(sZip)= 0) and cbxCmpEqualSubjZip.checked then
        sZip := TContainer(FDoc).GetCellTextByID(49);

      //set values for city, state zip and unit
      FieldByName('City').AsString := sCity;
      FieldByName('State').AsString := sState;
      FieldByName('Zip').AsString := sZip;
      FieldByName('UnitNo').AsString := sUnit;

      //set additional fields
      if cbxCmpEqualSubjCounty.checked then
        FieldByName('County').AsString := TContainer(FDoc).GetCellTextByID(50);
      if cbxCmpEqualSubjNeighbor.checked then
        FieldByName('ProjectName').AsString := TContainer(FDoc).GetCellTextByID(595);
      if cbxCmpEqualSubjMap.checked then
        FieldByName('MapRef1').AsString := TContainer(FDoc).GetCellTextByID(598);

      sUAD := '{UAD}';

      //Load comp Grid
      for n := 0 to FGridCellIDMap.Count-1 do
        begin
          fldName := FGridCellIDMap.Names[n];
          fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);

          case fldID of
            996:    //'"Age=996",'
             begin
                strVal := CompCol.GetCellTextByID(fldID);
                if IsValidInteger(strVal, valInt) then
                  begin
                    FieldByName(fldName).AsInteger := ReCalculateAge(valInt,FModifiedDate);
                  end;
             end;
            947,    //'"SalesPrice=947",'
//            996,    //'"Age=996",'
            1004,   //'"GrossLivArea=1004",'
            1041,   //'"TotalRooms=1041",'
            1042:   //'"BedRooms=1042",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                if (fldID = 996) and (Pos('~', strVal) > 0) then
                  sUAD := sUAD + '{Estimated Age}';
                if IsValidInteger(strVal, valInt) then
                  FieldByName(fldName).AsInteger := valInt;
              end;
            960:    //'"SalesDate=960",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                PosGSE := 0;
                CntrGSE := 0;
                repeat
                  CntrGSE := Succ(CntrGSE);
                  if SaleDateVals[CntrGSE] = Copy(strVal, 1, Length(SaleDateVals[CntrGSE])) then
                    PosGSE := CntrGSE;
                until (PosGSE > 0) or (CntrGSE = MaxDateVals);
                if PosGSE > 0 then
                  case PosGSE of
                    1,2:
                      begin
                        sUAD := sUAD + '{' + SaleDateStat[PosGSE] + ' ' + Copy(strVal, 2, 5) + '}';
                        strVal := Copy(strVal, 9, 2) + '/1' + Copy(strVal, 11, 3);
                        //valDate := GetValidDate(strVal);
                        if ExtractDate(strVal, valDate) then
                        //if valDate > 0 then
                          FieldByName(fldName).AsDateTime := valDate;
                      end;
                    3..6,8: sUAD := sUAD + '{' + SaleDateStat[PosGSE] + ' ' + Copy(strVal, 2, 5) + '}';
                    7: sUAD := sUAD + '{' + SaleDateStat[PosGSE] + '}';
                    9,10:
                      begin
                        strVal := Copy(strVal, 2, 2) + '/1' + Copy(strVal, 4, 3);
                        //valDate := GetValidDate(strVal);
                        if ExtractDate(strVal, valDate) then
                        //if valDate > 0 then
                          FieldByName(fldName).AsDateTime := valDate;
                      end;
                  end;
              end;
            1043:   //'"BathRooms=1043",'
              begin
                strVal := CompCol.GetCellTextByID(fldID);
                if HasValidNumber(strVal, valReal) then
                  FieldByName(fldName).AsFloat := valReal;
              end;
            1868, 1869:    //Fullbath/half bath to go to "BathRooms = 1043"
              begin
                aFullBath := CompCol.GetCellTextByID(1868);
                aHalfBath := CompCol.GetCellTextByID(1869);
                if aFullBath <> '' then
                  begin
                    fBath := StrToIntDef(aFullBath, 0);
                    hBath := STrToIntDef(aHalfBath, 0);
                    if fBath > 0 then
                      FIeldByName('BathRooms').AsString := Format('%d.%d',[fBath, hBath]);
                  end;
              end
          else
            if fldID > 0 then
              if (fldID <> 1868) and (fldID <> 1869) then
                FieldByName(fldName).AsString := CompCol.GetCellTextByID(fldID);
          end;
        end;
      if POS(upperCase(sUAD),UpperCase(FieldByName('Comment').AsString)) <= 0 then
        FieldByName('Comment').AsString := sUAD + Trim(FieldByName('Comment').AsString);

      ExtraComment := LoadSpecificFieldsToComment(TContainer(Fdoc), FieldByName(commentFldName).AsString);
      if ExtraComment <> '' then
        FieldByName(CommentFldName).asString := ExtraComment;

      UpdateBatch;
    end;

  //OnRecChanged;
  //PageControl.ActivePage := tabDetail;        //detailed view
  if assigned(compCol.Photo.Cell) then
    ImportCompPhoto(compCol);
end;

procedure TCompsDBList.ExportUADComparable(Index: Integer; compCol: TCompColumn);
const
  MaxAddrXID = 9;
  FactorID: array[0..1] of String = ('4420','4421');
  FeatureID: array[0..1] of String = ('4413','4414');
  PropAddrXID: array[0..MaxAddrXID] of String = ('925','4527','4528','4529','4530','3981','4488','4489','4490','4491');
var
  n, fldID: Integer;
  StreetAddress, CityStZip, sState,sZip: String;
  cmntStr, dateStr, fldName, locStr, tmpStr: String;
  theCell, UADUnitCell: TBaseCell;
  GSEData: TStringList;
  PosGSE, CntrGSE, BaseAddrPtr: Integer;
  //Yr, Mo, Dy: Word;
  //sYr, sMo: String;
  ItemFound: Boolean;
  GeocodedCell:TGeocodedGridCell;
  latFloat,lonFloat: Double;
  fBath, hBath: Integer;
  aTemp: String;
begin
  with ListDMMgr.CompQuery do
    begin
      //load the streetAddress
      StreetAddress := FieldByName('StreetNumber').AsString + ' '+ FieldByName('StreetName').AsString;
      CompCol.SetCellTextByID(925, StreetAddress);

      theCell := CompCol.GetCellByID(925);  // Default to standard comparable
      if theCell.FCellXID = 3981 then
        BaseAddrPtr := 5
      else
        BaseAddrPtr := 0;
      GSEData := TStringList.Create;
      GSEData.Values[PropAddrXID[BaseAddrPtr]] := StreetAddress;
      //load the City State Zip
      CityStZip := FieldByName('City').AsString;
      sState := FieldByName('State').AsString;
      if length(sState)> 0 then
        CityStZip := CityStZip +', '+ sState;
      sZip := FieldByName('Zip').AsString;
      if length(sZip)> 0 then
        CityStZip := CityStZip +' '+ sZip;
      GSEData.Values[PropAddrXID[BaseAddrPtr+2]] := FieldByName('City').AsString;
      GSEData.Values[PropAddrXID[BaseAddrPtr+3]] := sState;
      GSEData.Values[PropAddrXID[BaseAddrPtr+4]] := sZip;
      // 041911 JWyatt Check for a unit cell and add the data point & text if found
      UADUnitCell := GetUADUnitCell(TContainer(FDoc));
      if assigned(UADUnitCell) and (Trim(FieldByName('UnitNo').AsString) <> '') then
        begin
          if CompCol.CompNumber = 0 then
            // 041911 JWyatt This code currently doesn't execute as we do not
            //  allow exporting to the subject column at this time.
            GSEData.Values['2141'] := FieldByName('UnitNo').AsString
          else
            GSEData.Values[PropAddrXID[BaseAddrPtr+1]] := FieldByName('UnitNo').AsString;
          CityStZip := FieldByName('UnitNo').AsString + ', ' + CityStZip;
        end;
      theCell.GSEData := GSEData.CommaText;
      CompCol.SetCellTextByID(926, CityStZip);
      GSEData.Free;
      //Update Geocode lat/lon
      if (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
      begin
        GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
        //GeocodedCell.Latitude := FieldByName('Latitude').AsFloat;
        //GeocodedCell.Longitude := FieldByName('Longitude').AsFloat;
        if TryStrToFloat(FieldByName('Longitude').AsString, lonFloat) then
          GeocodedCell.Longitude := lonFloat;

        if TryStrToFloat(FieldByName('Latitude').AsString, latFloat) then
          GeocodedCell.Latitude := latFloat;

        GeocodedCell.PostProcess;
      end;

      //add rest of grid - straight insert
      for n := 0 to FGridCellIDMap.Count-1 do
        begin
          fldName := FGridCellIDMap.Names[n];
          fldID  := StrToIntDef(FGridCellIDMap.Values[fldName], 0);
          case fldID of
            930:
              begin
                theCell := CompCol.GetCellByID(930);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    PosGSE := Pos(';DOM', tmpStr);
                    if PosGSE > 0 then
                      begin
                        GSEData := TStringList.Create;
                        GSEData.Values['4531'] := Trim(Copy(tmpStr, (PosGSE + 4), Length(tmpStr)));
                        cmntStr := Copy(tmpStr, 1, Pred(PosGSE));
                        GSEData.Values['4431'] := Trim(cmntStr);
                        CntrGSE := 0;
                        repeat
                          PosGSE := Pos(';', cmntStr);
                          if Trim(cmntStr) = '' then
                            PosGSE := 0
                          else if PosGSE = 0 then
                            GSEData.Values['4431-10-' + IntToStr(CntrGSE)] := Trim(cmntStr)
                          else
                            begin
                              GSEData.Values['4431-10-' + IntToStr(CntrGSE)] := Trim(Copy(cmntStr, 1, Pred(PosGSE)));
                              cmntStr := Copy(cmntStr, Succ(PosGSE), Length(cmntStr));
                            end;
                          CntrGSE := Succ(CntrGSE);
                        until (PosGSE = 0);
                        theCell.GSEData := GSEData.CommaText;
                        GSEData.Free;
                      end;
                  end;
              end;
            956:
              begin
                theCell := CompCol.GetCellByID(956);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    CntrGSE := -1;
                    repeat
                      CntrGSE := Succ(CntrGSE);
                      ItemFound := (Pos(tmpStr, SalesTypesDisplay[CntrGSE]) > 0);
                    until ItemFound or (CntrGSE = MaxSalesTypes);
                    if ItemFound then
                      GSEData.Values['4532'] := SalesTypesXML[CntrGSE];
                    tmpStr := FieldByName('FinancingConcessions').AsString;
                    CompCol.SetCellTextByID(958, tmpStr);
                    PosGSE := Pos(';', tmpStr);
                    if (PosGSE > 0) then
                      begin
                        cmntStr := Copy(tmpStr, 1, Pred(PosGSE));
                        tmpStr :=  Copy(tmpStr, Succ(PosGSE), Length(tmpStr));
                      end
                    else
                      begin
                        cmntStr := Copy(tmpStr, 1, Length(tmpStr));
                        tmpStr := '';
                      end;
                    if cmntStr <> '' then
                      begin
                        CntrGSE := 0;
                        repeat
                          CntrGSE := Succ(CntrGSE);
                          ItemFound := (Pos(cmntStr, FinDesc[CntrGSE]) > 0);
                        until ItemFound or (CntrGSE = MaxFinTypes);
                        if ItemFound then
                          GSEData.Values['4432'] := FinType[CntrGSE]
                        else
                          begin
                            GSEData.Values['4432'] := FinType[MaxFinTypes];
                            GSEData.Values['4433'] := cmntStr;
                          end;
                        if tmpStr <> '' then
                          GSEData.Values['4533'] := tmpStr;
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            960:
              begin
                  dateStr := GetDateOfSalesCellText(true);
                  CompCol.SetCellTextByID(fldID, dateStr);
              end;
            962:
              begin
                theCell := CompCol.GetCellByID(962);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    if Trim(tmpStr) <> '' then
                      begin
                        PosGSE := Pos(';', tmpStr);
                        if (PosGSE = 2) then
                          begin
                            CntrGSE := -1;
                            repeat
                              CntrGSE := Succ(CntrGSE);
                              ItemFound := (tmpStr[1] = InfluenceDisplay[CntrGSE]);
                            until ItemFound or (CntrGSE = MaxInfluences);
                            if ItemFound then
                              GSEData.Values['4419'] := InfluenceList[CntrGSE];
                            cmntStr := Trim(Copy(tmpStr, 3, Length(tmpStr)));
                            if cmntStr <> '' then
                              begin
                                PosGSE := Pos(';', cmntStr);
                                if PosGSE > 0 then
                                  begin
                                    locStr := Trim(Copy(cmntStr, 1, Pred(PosGSE)));
                                    cmntStr := Trim(Copy(cmntStr, Succ(PosGSE), Length(cmntStr)));
                                  end
                                else
                                  begin
                                    locStr := cmntStr;
                                    cmntStr := '';
                                  end;
                                if locStr <> '' then
                                  begin
                                    CntrGSE := -1;
                                    repeat
                                      CntrGSE := Succ(CntrGSE);
                                      ItemFound := (locStr = LocListDisplay[CntrGSE]);
                                    until ItemFound or (CntrGSE = MaxLocFactors);
                                    if ItemFound then
                                      GSEData.Values[FactorID[0]] := LocListXML[CntrGSE]
                                    else
                                      begin
                                        GSEData.Values[FactorID[0]] := LocListXML[MaxLocFactors];
                                        GSEData.Values['4515'] := locStr;
                                      end;
                                  end;
                                if cmntStr <> '' then
                                  begin
                                    CntrGSE := -1;
                                    repeat
                                      CntrGSE := Succ(CntrGSE);
                                      ItemFound := (cmntStr = LocListDisplay[CntrGSE]);
                                    until ItemFound or (CntrGSE = MaxLocFactors);
                                    if ItemFound then
                                      GSEData.Values[FactorID[1]] := LocListXML[CntrGSE]
                                    else
                                      begin
                                        GSEData.Values[FactorID[1]] := LocListXML[MaxLocFactors];
                                        if Trim(GSEData.Values['4515']) = '' then
                                          GSEData.Values['4515'] := cmntStr
                                        else
                                          GSEData.Values['4515'] := GSEData.Values['4515'] + ';' + cmntStr;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            984:
              begin
                theCell := CompCol.GetCellByID(984);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    if Trim(tmpStr) <> '' then
                      begin
                        PosGSE := Pos(';', tmpStr);
                        if (PosGSE = 2) then
                          begin
                            CntrGSE := -1;
                            repeat
                              CntrGSE := Succ(CntrGSE);
                              ItemFound := (tmpStr[1] = InfluenceDisplay[CntrGSE]);
                            until ItemFound or (CntrGSE = MaxInfluences);
                            if ItemFound then
                              GSEData.Values['4412'] := InfluenceList[CntrGSE];
                            cmntStr := Trim(Copy(tmpStr, 3, Length(tmpStr)));
                            if cmntStr <> '' then
                              begin
                                PosGSE := Pos(';', cmntStr);
                                if PosGSE > 0 then
                                  begin
                                    locStr := Trim(Copy(cmntStr, 1, Pred(PosGSE)));
                                    cmntStr := Trim(Copy(cmntStr, Succ(PosGSE), Length(cmntStr)));
                                  end
                                else
                                  begin
                                    locStr := cmntStr;
                                    cmntStr := '';
                                  end;
                                if locStr <> '' then
                                  begin
                                    CntrGSE := -1;
                                    repeat
                                      CntrGSE := Succ(CntrGSE);
                                      ItemFound := (locStr = ViewListDisplay[CntrGSE]);
                                    until ItemFound or (CntrGSE = MaxViewFeatures);
                                    if ItemFound then
                                      GSEData.Values[FeatureID[0]] := ViewListXML[CntrGSE]
                                    else
                                      begin
                                        GSEData.Values[FeatureID[0]] := ViewListXML[MaxViewFeatures];
                                        GSEData.Values['4513'] := locStr;
                                      end;
                                  end;
                                if cmntStr <> '' then
                                  begin
                                    CntrGSE := -1;
                                    repeat
                                      CntrGSE := Succ(CntrGSE);
                                      ItemFound := (cmntStr = ViewListDisplay[CntrGSE]);
                                    until ItemFound or (CntrGSE = MaxViewFeatures);
                                    if ItemFound then
                                      GSEData.Values[FeatureID[1]] := ViewListXML[CntrGSE]
                                    else
                                      begin
                                        GSEData.Values[FeatureID[1]] := ViewListXML[MaxViewFeatures];
                                        if Trim(GSEData.Values['4513']) = '' then
                                          GSEData.Values['4513'] := cmntStr
                                        else
                                          GSEData.Values['4513'] := GSEData.Values['4513'] + ';' + cmntStr;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            994:
              begin
                theCell := CompCol.GetCellByID(994);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    CntrGSE := -1;
                    repeat
                      CntrGSE := Succ(CntrGSE);
                      ItemFound := (tmpStr = QualityListTypCode[CntrGSE]);
                    until ItemFound or (CntrGSE = MaxQualityTypes);
                    if ItemFound then
                      begin
                        GSEData.Values['4517'] := QualityListTypCode[CntrGSE];
                        if theCell.FCellXID = 3999 then
                          GSEData.Values['3999'] := QualityListTypCode[CntrGSE];
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            996:
              begin
                theCell := CompCol.GetCellByID(996);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    if Trim(tmpStr) <> '' then
                      begin
                        GSEData.Values['996'] := tmpStr;
                        if Pos('{Estimated Age}', FieldByName('Comment').AsString) > 0 then
                          begin
                            tmpStr := '~' + tmpStr;
                            GSEData.Values['4425'] := 'Y';
                          end
                        else
                          GSEData.Values['4425'] := 'N';
                      end;
                    if theCell.FCellXID = 4000 then
                      GSEData.Values['4000'] := tmpStr;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            998:
              begin
                theCell := CompCol.GetCellByID(998);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    CntrGSE := -1;
                    repeat
                      CntrGSE := Succ(CntrGSE);
                      ItemFound := (tmpStr = ConditionListTypCode[CntrGSE]);
                    until ItemFound or (CntrGSE = MaxConditionTypes);
                    if ItemFound then
                      begin
                        GSEData.Values['4518'] := ConditionListTypCode[CntrGSE];
                        if theCell.FCellXID = 4001 then
                          GSEData.Values['4001'] := ConditionListTypCode[CntrGSE];
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            1006:
              begin
                theCell := CompCol.GetCellByID(1006);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    if Trim(tmpStr) <> '' then
                      begin
                        PosGSE := Pos('sf', tmpStr);
                        if PosGSE > 0 then
                          begin
                            GSEData.Values['4426'] := Copy(tmpStr, 1, Pred(PosGSE));
                            cmntStr := Copy(tmpStr, (PosGSE + 2), Length(tmpStr));
                            PosGSE := Pos('sf', cmntStr);
                            if PosGSE > 0 then
                              begin
                                GSEData.Values['4427'] := Copy(cmntStr, 1, Pred(PosGSE));
                                cmntStr := Copy(cmntStr, (PosGSE + 2), Length(cmntStr));
                                CntrGSE := -1;
                                repeat
                                  CntrGSE := Succ(CntrGSE);
                                  ItemFound := (cmntStr = BsmtAccessDisplay[CntrGSE])
                                until ItemFound or (CntrGSE = MaxAccessIdx);
                                if ItemFound then
                                  GSEData.Values['4519'] := BsmtAccessListXML[CntrGSE];
                              end;
                          end;
                        tmpStr := FieldByName('RoomsBelowGrade').AsString;
                        CompCol.SetCellTextByID(1008, tmpStr);
                        PosGSE := Pos('rr', tmpStr);
                        if PosGSE > 0 then
                          begin
                            GSEData.Values['4428'] := Copy(tmpStr, 1, Pred(PosGSE));
                            cmntStr := Copy(tmpStr, (PosGSE + 2), Length(tmpStr));
                          end;
                        PosGSE := Pos('br', cmntStr);
                        if PosGSE > 0 then
                          begin
                            GSEData.Values['4429'] := Copy(cmntStr, 1, Pred(PosGSE));
                            cmntStr := Copy(cmntStr, (PosGSE + 2), Length(cmntStr));
                          end;
                        PosGSE := Pos('ba', cmntStr);
                        if PosGSE > 0 then
                          begin
                            GSEData.Values['4430'] := Copy(cmntStr, 1, Pred(PosGSE));
                            cmntStr := Copy(cmntStr, (PosGSE + 2), Length(cmntStr));
                          end;
                        PosGSE := Pos('o', cmntStr);
                        if PosGSE > 0 then
                          begin
                            GSEData.Values['4520'] := Copy(cmntStr, 1, Pred(PosGSE));
                            cmntStr := Copy(cmntStr, (PosGSE + 2), Length(cmntStr));
                          end;
                      end;
                    theCell.GSEData := GSEData.CommaText;
                    GSEData.Free;
                  end;
              end;
            1041:
              begin
                theCell := CompCol.GetCellByID(1041);
                if theCell <> nil then
                  begin
                    tmpStr := FieldByName(fldName).AsString;
                    CompCol.SetCellTextByID(fldID, tmpStr);
                    GSEData := TStringList.Create;
                    if Trim(tmpStr) <> '' then
                      GSEData.Values['1041'] := tmpStr;
                    tmpStr := FieldByName('Bedrooms').AsString;
                    CompCol.SetCellTextByID(1042, tmpStr);
                    if Trim(tmpStr) <> '' then
                      GSEData.Values['1042'] := tmpStr;
                    tmpStr := FieldByName('Bathrooms').AsString;
                    CompCol.SetCellTextByID(1043, tmpStr);
                    if Trim(tmpStr) <> '' then
                      GSEData.Values['1043'] := tmpStr;
                    theCell.GSEData := GSEData.CommaText;
                    // Set formatting to ensure that '1.1' does not show as '1.10'
                    theCell := CompCol.GetCellByID(1043);
                    PosGSE := Pos('.', tmpStr);
                    if (PosGSE = 0) or (Length(Copy(tmpStr, Succ(PosGSE), Length(tmpStr))) < 2) then
                      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1)    //round to 0.1
                    else
                      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);   //round to 0.01

                    //if we have full bath cell id 1868 and half bath cell 1869, use the bath count to populate
                    //tmpstr has f.h
                    //tmpstr has f.h
                    aTemp := popStr(tmpStr, '.');
                    fBath := StrToIntDef(aTemp, 0);
                    hBath := StrToIntDef(aTemp, 0);
                    if fBath > 0 then
                      GSEData.Values['1868'] := Format('%d',[fBath]);
                    if hBath > 0 then
                      GSEData.Values['1869'] := Format('%d',[hBath]);

                    CompCol.SetCellTextByID(1868, Format('%d',[fBath]));
                    CompCol.SetCellTextByID(1869, Format('%d',[hBath]));

                    GSEData.Free;
                end;
              end;
          else if (fldID = 1868) or (fldID = 1869) then //ignore
            begin
              //ignore
            end
          else
            CompCol.SetCellTextByID(fldID, FieldByName(fldName).AsString);
          end;
        end;

      ExportCompPhoto(compCol);

      //finally do the adjustments on the new comp data
      AdjustThisComparable(FDoc, Index);
    end;
end;

procedure TCompsDBList.ImportSubjectMenuClick(Sender: TObject);
begin
  ImportSubject(FImportOption); //1-import
end;

procedure TCompsDBList.ImportCompMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    if not assigned(Sender) then exit;
    compID := TMenuItem(Sender).Tag;
    ImportComparable(CompID, tcSales,ImportOption);  //ImportOption: 1 - import , 0 - saving
    OnRecChanged;
    PageControl.ActivePage := tabDetail;        //detailed view
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList.ImportListingMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    if not assigned(Sender) then exit;
    compID := TMenuItem(Sender).Tag;
    ImportComparable(CompID, tcListing,ImportOption);  //ImportOption: 1 - import , 0 - saving
    OnRecChanged;
    PageControl.ActivePage := tabDetail;        //detailed view
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList.ExportCompMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  compID := TMenuItem(Sender).Tag;
  if dxDBGrid.Count > 0 then  //we have to update photos before doing export
    if TDxDbGridNode(dxDBGrid.FocusedNode).ID <> FDetailCmpID then
      OnRecChanged;
  ExportComparable(CompID,tcSales);
end;

procedure TCompsDBList.ExportListingMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  compID := TMenuItem(Sender).Tag;
  if dxDBGrid.Count > 0 then  //we have to update photos before doing export
    if TDxDbGridNode(dxDBGrid.FocusedNode).ID <> FDetailCmpID then
      OnRecChanged;
  ExportComparable(CompID, tcListing);
end;
(*
function TCompsList.GetFieldID(fldName: String; isSubjSpec: Boolean): Integer;
var
  strID: String;
begin
  result := -1;     //do not find the filed name in the StringList
  if isSubjSpec then
    strID := FSubjSpecCellIDMap.Values[fldName]
  else
    strID := FGridCellIDMap.Values[fldName];
  if length(strID) > 0 then
    result := StrToIntDef(strID,0);
end;
*)
(*
function TCompsList.HandleImportExcepts(text, fldName: String; clID: Integer): String;
begin
  case clID of
    925,  //Comp street address
    46:   //Subject street adress
      if CompareText(fldName,streetNoFldName) = 0 then
        result := ParseStreetAddress(Text,1,1) //trim appartmennt No
      else
        if CompareText(fldName,streetNameFldName) = 0 then
          result := ParseStreetAddress(text,2,1)
        else
          result := text;
    926:  //Comp city
      begin
        if CompareText(fldName,cityFldName) = 0 then
          result := ParseCityStateZip2(text, cmdGetCity)         //city
        else
          if CompareText(fldName,StateFldName) = 0 then
            result := ParseCityStateZip(text, cmdGetSate)       //state
          else
            if CompareText(fldName,zipFldName) = 0 then
              result := ParseCityStateZip(text, cmdGetZip)    //zip
            else
              result := text;
        if (CompareText(fldName,StateFldName) = 0) and (length(result) = 0) then
          result := TContainer(FDoc).GetCellTextByID(48); //subject state
      end;
    else
      result := text;
  end;
end;
*)
(*
FUTURE USE
procedure TCompsList.AddPhotoFromFile(compID: Integer; const FileName, Title: String);
begin
end;
*)

function TCompsDBList.GetPhotoFilePath(compID: Integer; const Title: String): String;
begin
  if FCompDBPhotosDir = '' then
    FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  result := IncludeTrailingPathDelimiter(FCompDBPhotosDir) +
            IntToStr(CompID) + '_' + IntToStr(RandomRange(250,999)) +
            '_' + Title + '.jpg';   //default ext

// result := folder/compID_###_Front.jpg    (recNo_randomNo_Title.ext)
end;

procedure TCompsDBList.AddPhotoRecord(compID: Integer; Title, filePath: String; relPath, showPhoto: Boolean);
begin
  with ListDMMgr.CompPhotoQuery do
    begin
      Append;

      FieldValues[compIDFldName] := compID;
      FieldValues[imgDescrFldName] := Title;
      FieldValues[imgPathTypeFldName] := relPath;
      if relPath then
        FieldValues[imgFNameFldName] := ExtractFileName(filePath)
      else
        FieldValues[imgFNameFldName] := filePath;

      UpdateBatch(arCurrent);

      if showPhoto then
        LoadImages;
    end;
end;

procedure TCompsDBList.AddPhotoFromCell(compID: Integer; Cell: TObject; Const Title: String);
var
  photoPath: String;
begin
  //add photo to Photos Directory
  try  //two excepts because SaveToFile will catch the first one.
    try
      StatusBar.SimpleText := 'Adding photo ' + Title;
      photoPath := GetPhotoFilePath(compID, Title);
//      photoPath := StripUnwantedCharForFileName(photoPath);  //Ticket #1194 (Ticket#1226 Roll back}
      TPhotoCell(Cell).SaveToFile(photoPath);
//      AddPhotoRecord(compID, Title, photoPath, True, True);
      AddPhotoRecord(compID, Title, photoPath, True, False);
      StatusBar.SimpleText := '';
    except
    end;
  except
    ShowNotice('There was a problem adding the image "'+Title+'" to the Comparables database.');
  end;
end;

procedure TCompsDBList.ImportSubPhotos;
var
  title: String;
  cell: TBaseCell;
  f,c, cmpID: Integer;
begin
  cmpID := ListDMMgr.CompQuery.FieldValues[compIDFldName];    //photo will be assoc w/this comp rec

  for f := 0 to TContainer(FDoc).docForm.count-1 do
    with TContainer(FDoc).docForm[f].frmPage[0] do //with the first pg of each form
      begin
        if pgDesc.PgType = ptPhotoSubject then     //is it the main subj photo page?
          begin
            for c := 0 to pgData.count-1 do
              if pgData[c].ClassNameIs('TPhotoCell') and pgData[c].hasData then
                case pgData[c].FCellID of
                  1205:  //front
                    AddPhotoFromCell(cmpID, pgData[c],'Front');
                  1206:
                    AddPhotoFromCell(cmpID, pgData[c],'Rear');
                  1207:
                    AddPhotoFromCell(cmpID, pgData[c],'Street');
                end;
          end

        else if pgDesc.PgType = ptPhotoSubExtra then  //is it the extra sub photos
          begin
            for c := 0 to pgData.count-1 do
              if pgData[c].ClassNameIs('TPhotoCell') and pgData[c].hasData then
                begin
                  title := 'Untitled';
                  cell := nil;
                  case pgData[c].FCellID of
                    1208:
                      cell := GetCellByID(1211);    //title of photo (1st line only)
                    1209:
                      cell := GetCellByID(1212);    //title of photo (1st line only)
                    1210:
                      cell := GetCellByID(1213);    //title of photo (1st line only)
                  end;
                  if assigned(cell) then
                    begin //this will be name of photo file
                      title := Cell.GetText;
                      title := CreateValidFileName(title);
                    end;

                  AddPhotoFromCell(cmpID, pgData[c], title);
                end;
          end;
      end;
end;

procedure TCompsDBList.ImportCompPhoto(cmpCol: TCompColumn);
var
  cmpID: Integer;
  photoCell: TPhotoCell;
begin
  cmpID := ListDMMgr.CompQuery.FieldValues[compIDFldName];    //photo will be assoc w/this comp rec
  photoCell := cmpCol.Photo.Cell;                             //this cell has photo

  if Assigned(photoCell) and photoCell.HasData then
    AddPhotoFromCell(cmpID, photoCell, 'Front');
end;

procedure TCompsDBList.ExportCompPhoto(cmpCol :TCompColumn);
var
  photoPath: String;
begin
  if not assigned(cmpCol.Photo.Cell) then
    exit;

  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  cmpCol.FPhoto.AssignAddress;
  with ListDMMgr.CompPhotoQuery do
    begin
      First;
      if not FieldByName(imgPathTypeFldName).AsBoolean then
        photoPath := FieldByName(imgFNameFldName).AsString
      else
        photoPath := IncludeTrailingPathDelimiter(FCompDBPhotosDir) +
                                          FieldByName(imgFNameFldName).AsString;
    end;

  if FileExists(photoPath) then
    cmpCol.Photo.Cell.SetText(photoPath);
end;

procedure TCompsDBList.EliminateDuplicates(Sender: TObject);
var
  bFreezeUpdate: Boolean;
  actCompId,curCompID: Integer;
  rec,nRecs: Integer;
  prevStr,CurStr: String;
  bDelPhotoFiles: Boolean;
begin
  if OK2Continue(warnMsg5) then
    BackupComps;

  bFreezeUpdate := LockWindowUpdate(Handle);
  actCompID := ListDMMgr.CompQuery.FieldByName(compIDfldName).AsInteger;
  bDelPhotoFiles := WarnOK2Continue(warnMsg3);
  PushMouseCursor(crHourglass);
  try
    with ListDMMgr.CompTempQuery do
      begin
        Close;
        SQL.Clear;
        SQL.Add(SQLString4);
        Open;

        nRecs := RecordCount;
        if nRecs < 2 then
          exit;
        First;
        prevStr := FieldByName(checkStrFldName).AsString;
        Next;
        for rec := 1 to nRecs - 1 do
          begin
            curStr := FieldByName(checkStrFldName).AsString;
            curCompId := FieldByName(compIDfldName).AsInteger;
            if CompareText(prevStr,curStr) = 0 then
              if curCompID = actCompID then
                begin
                  Prior; //save the active record
                  curCompId := FieldByName(compIDfldName).AsInteger;
                  Delete;
                  RemovePhotos(curCompID, bDelPhotoFiles);
                  Next;
                end
              else
                begin
                  Delete;
                  RemovePhotos(curCompID, bDelPhotoFiles);
                end
            else
              begin
                prevStr := curStr;
                Next;
              end;
          end;
        Close;
      end;  //end of compTempQuery

      with ListDMMgr.CompQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add(Format(sqlString1,[compsTableName]) + Format(sqlString2,[compIDFldName]));
          Open;
          Locate(compIDfldName,actCompID,[]);
        end; //end of compQuery
    finally
      if bFreezeUpdate then       //unfreeze window
        LockWindowUpdate(0);
      PopMouseCursor;
    end;
end;

procedure TCompsDBList.RemovePhotos(compID: Integer; bDelFiles: Boolean);
var
  rec, nRecs: Integer;
  imgPath: String;
begin
  FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  with ListDMMgr.CompPhotoQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add(Format(sqlString1,[photoTableName]) + Format(sqlString3,[compIDFldName,IntToStr(CompID)]));
      Open;

      nRecs := RecordCount;
      if nRecs < 1 then exit;

      First;
      for rec := 0 to nRecs - 1 do
        begin
          if bDelFiles then     //ok to delete the actual photo file
            begin
              if FieldByName(imgPathTypeFldName).AsBoolean then
                imgPath := IncludeTrailingPathDelimiter(FCompDBPhotosDir) + FieldByName(imgFnameFldName).AsString
              else
                imgPath := FieldByName(imgFnameFldName).AsString; //fullPath
              if FileExists(imgPath) then
                DeleteFile(imgPath);
            end;

          Delete;             //delete the photo path record
        end;
      Close;
    end;
end;

procedure TCompsDBList.SetFieldsDefault; // set text fields to the empty string
var
  fld, nFlds: Integer;
begin
  with ListDMMgr.CompQuery do
    begin
      nFlds := FieldCount;
      for fld := 0 to nFlds - 1 do
        if (Fields[fld].DataType = ftString) or (Fields[fld].DataType = ftWideString) then
          Fields[fld].AsString := '';
    end;
end;

{******************}
{     TThumbEx     }
{******************}

constructor TThumbEx.Create(AOwner: TComponent; orig: TPoint; id: Integer; aImgPath, aImgDesc: String);
begin
  try
    inherited Create(AOwner);
    imgPath := aImgPath;
    imgID := id;
    FImage := TPMultiImage.Create(Owner);

    with FImage do
      begin
        Parent := TWinControl(Owner);              //scrollBox
  //      left := orig.X + LabelWidth + 2*gap;
        left := orig.x + gap;
  //      top := orig.Y + EditHeight + 2* gap;
        top := orig.y + gap;
        height := thumbHeight;
        width := thumbWidth;
        borderStyle := bsNone;
        center := True;
        Enabled := True;
        Hint := ImgPath;
        ShowHint := True;
        StretchRatio := True;
        Visible := True;

        onClick := OnImageClick;
        onDblClick := OnImageDblClick;
        onKeyDown := OnImageKeyDown;
        onILibError := OnInvalidImage;
        if FileExists(imgPath) then
          ImageName := imgPath
        else
          //if FileExists(IncludeTrailingPathDelimiter(appPref_DirDatabases) + cantFindFileName) then
            //ImageName := IncludeTrailingPathDelimiter(appPref_DirDatabases) + cantFindFileName;
          if assigned(CompsDBList) then
            CompsDBList.ImgList1.GetBitmap(0,Picture.Bitmap)
      end;

    imgFrame := TShape.Create(Owner);
    with imgFrame do
      begin
        Parent := TWinControl(Owner);
        left := orig.x;
        top := orig.y;
        height := thumbHeight + EditHeight + gap+gap+gap+gap;
        width := thumbwidth + gap+gap;

        Enabled := True;
        Shape := stRectangle;
        brush.Style := bsClear;
        Pen.Color := clNavy;
        Pen.Style := psSolid;
        Pen.Width := 2;
        Visible := False;
      end;
    imgEditDescr := TDxEdit.Create(Owner);
    with imgEditDescr do
      begin
        Parent := TWinControl(Owner);
        left := orig.x + gap;
        top := orig.y + gap + thumbHeight;
        height := EditHeight;
        width := thumbwidth;
        enabled := True;
        alignment := taCenter;
        text := aImgDesc;
        color := clWhite;   //cl3Dlight;
        OnEnter := OnDescrEnter;
        OnExit := OnDescrExit;
        visible := True;
      end;
  except on E:Exception do
    showNotice('TThumbEx.Create: '+e.Message);
  end;
end;

function TThumbEx.GetImageDescr: String;
begin
  result := imgEditDescr.Text;
end;

function TThumbEx.GetNominalImagePath: String;
begin
  result := imgPath;
end;

function TThumbEx.GetActualImagePath: String;
begin
  result := FImage.ImageName;
end;

procedure TThumbEx.ViewImage;
var
   viewFrm: TImageViewer;
   strDesc: String;
begin
  if CompareText(imgPath, FImage.ImageName) = 0 then
    try
      PushMouseCursor(crHourglass);
      try
        strDesc := GetImageDescr;
        if strDesc = '' then strDesc := 'Untitled Photo';
        viewFrm := TImageViewer.Create(self);
        viewFrm.LoadImageFromFile(GetNominalImagePath);
        viewFrm.ImageDesc := strDesc;
        viewFrm.Show;
      finally
        PopMouseCursor;
      end;
    except
      ShowNotice('There was a problem loading the image for display.');
    end;
end;

procedure TThumbEx.OnDescrExit(Sender: TObject);
begin
  if imgEditDescr.Modified then
    if Assigned(FOnDescrEdited) then
      FOnDescrEdited(self);
end;

procedure TThumbEx.OnImageDblClick(Sender: TObject);
begin
  ViewImage;
end;

procedure TThumbEx.OnImageKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    if Assigned(FOnImageDelRequired) then
      FOnImageDelRequired(self);
end;

procedure TThumbEx.OnInvalidImage(Sender: TObject;  ErrorCode: Smallint;
                                        ErrorString: String; ErrorPChar: PChar);
begin
  //if FileExists(IncludeTrailingPathDelimiter(appPref_DirDataBases) + cantOpenFileName) then
    //FImage.ImageName := IncludeTrailingPathDelimiter(appPref_DirDataBases) + cantOpenFileName
    CompsDBList.ImgList1.GetBitmap(1,FImage.Picture.Bitmap)
  //else
    //FImage.ImageName := '';
end;

procedure  TThumbEx.ActivateImg(active: Boolean);
begin
  if Active then
      imgFrame.Visible := True
  else
      imgFrame.Visible := False;
end;

procedure TThumbEx.OnDescrEnter(Sender: TObject);
begin
  if assigned(FOnDescrEnter) then
      FOnDescrEnter(self);
end;

procedure TThumbEx.OnImageClick(Sender: TObject);
begin
  if assigned(FOnActivateImage) then
      FOnActivateImage(self);
end;

procedure TCompsDBList.ClickRefreshRecord(Sender: TObject);
var
  bFreeze: Boolean;
begin
  PushMouseCursor(crHourglass);
  bFreeze := LockWindowUpdate(Handle);
  try
    listDMMgr.CompQuery.Refresh;
  finally
    if bFreeze then
      LockWindowUpdate(0);
    PopMouseCursor;
  end;
end;

procedure TCompsDBList.ClickBackupDatabase(Sender: TObject);
begin
  BackupComps;
end;

procedure TCompsDBList.BackupComps;
const
  copyStr = 'Copy of ';
  copyStr1 = 'Copy (%d) of ';
var
  bckFileName: String;
  bckFilePath: String;
  copyNo: Integer;
begin
  copyNo := 1;
  bckFileName := copyStr + DBCompsName;
  bckFilePath := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + bckFileName;
  if FileExists(bckFilePath) then
    if not OK2Continue(warnMsg4) then
      while FileExists(bckFilePath) do
        begin;
          inc(copyNo);
          bckFileName := Format(copyStr1,[copyNo]) + DBCompsName;
          bckFilePath := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + bckFileName;
        end;

  if not CopyFile(PChar(appPref_DBCompsfPath),PChar(bckFilePath),False) then
    ShowAlert(atWarnAlert, Format(errMsg1,[bckFileName]))
  else
    ShowNotice('Your database has been successfully copied. The new file is called '+ bckFileName);
end;

procedure TCompsDBList.OnDragPrefNodeOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if Sender = TLCustomize then
    Accept := True;
end;

//In Preferences - hide/show the columns
procedure TCompsDBList.OnPrefListDblClick(Sender: TObject);
var
  bVisible: Boolean;
begin
  if Sender = TLCustomize then
    with  TLCustomize.FocusedNode do
      begin
        bVisible := not (Values[PrefPageVisibleCol] = TLCustomizeColumn2.ValueChecked);
        if bVisible then
          Values[PrefPageVisibleCol] := TLCustomizeColumn2.ValueChecked
        else
          Values[PrefPageVisibleCol] := TLCustomizeColumn2.ValueUnChecked;
        TdxTreeListColumn(Data).Visible := bVisible;
    end;
end;

procedure TCompsDBList.OnPrefListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if (Sender = TLCustomize) and assigned(TLCustomize.DragNode)  then
    with TLCustomize  do
      begin
        DragNode.MoveTo(FocusedNode,natlInsert); // move the column on the preferences list
        TdxTreeListColumn(DragNode.Data).ColIndex := DragNode.Index; //move the column on the grid
      end;
end;

procedure TCompsDBList.OnDragEndGridColumn(Sender: TObject;
  AColumn: TdxTreeListColumn; P: TPoint; var NewPosInfo: TdxHeaderPosInfo;
  var Accept: Boolean);
var
  curPos,newPos: Integer;
begin
  if Sender = dxDBGrid then
    with TLCustomize do
      begin
        newPos :=  NewPosInfo.ColIndex;
        curPos := AColumn.ColIndex;
        if curPos <> NewPos then    //move the preferences column
          if newPos < dxDBGrid.ColumnCount - 1 then
            Items[curPos].MoveTo(Items[NewPos],natlInsert)
          else
            Items[curPos].MoveTo(Items[NewPos],natlAdd);
    end;
end;

procedure TCompsDBList.OnGridNodeChange(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  //should happen on when moving to Detail View
  //OnRecChanged;
end;

procedure TCompsDBList.ClickListUndoGroups(Sender: TObject);
begin
  dxDBGrid.ClearGroupColumns;
end;

procedure TCompsDBList.ClickListUndoSort(Sender: TObject);
begin
  with dxDBGrid do
    begin
      ClearColumnsSorted;
      FullRefresh;
    end;
end;

procedure TCompsDBList.BeforeChangeTab(Sender: TObject; var AllowChange: Boolean);
begin
  case PageControl.TabIndex of
    tSearch:
      begin  end;
    tList:
      begin end;
    tDetail:
      if FModified then SaveRecord;
    tExport:
      begin end;
    tPref:
      begin end;
  end;
end;

procedure TCompsDBList.AfterChangeTab(Sender: TObject);
begin
  case PageControl.TabIndex of
    tSearch:
      begin
        self.width := ScrollBox.Left + ScrollBox.Width + 10;
      end;
    tList:
      begin
        if dxDBGrid.Count > 0 then
          dxDBGrid.MakeNodeVisible(dxDBGrid.FocusedNode);  //synchronize with the detail view
        self.width := FOriginalWidth;
      end;
    tDetail:   {detail view - sync with grid}
      begin
        self.width := ScrollBox.Left + ScrollBox.Width + 10;
        if dxDBGrid.Count > 0 then
          if TDxDbGridNode(dxDBGrid.FocusedNode).ID <> FDetailCmpID then
            OnRecChanged;
      end;
    tPref:
      begin
        self.width := ScrollBox.Left + ScrollBox.Width + 10;
        LoadColumnList;
      end;
  end;
end;

procedure TCompsDBList.SetNavigationState;
begin
  btnFirst.Enabled := False;
  btnPrev.Enabled := False;
  btnNext.Enabled := False;
  btnLast.Enabled := False;
  RecordFirstMItem.enabled := False;
  RecordPrevMItem.enabled := False;
  RecordLastMItem.enabled := False;
  RecordNextMItem.enabled := False;
  with dxDBGrid do
    if Count > 0 then
      begin
        if FocusedNode <> TopNode then
          begin
            btnFirst.Enabled := True;
            btnPrev.Enabled := True;
            RecordFirstMItem.enabled := True;
            recordPrevMItem.enabled := True;
          end;
        if FocusedNode <> LastNode then
          begin
            btnLast.Enabled := True;
            btnNext.Enabled := True;
            RecordLastMItem.enabled := True;
            recordNextMItem.enabled := True;
          end;
      end;
end;

procedure TCompsDBList.SetEditMode(canEdit: Boolean);
var
  img: Integer;
  hasRecs: Boolean;
begin
  hasRecs := dxDBGrid.Count > 0;

  MainRemoveDupsMItem.Enabled := hasRecs;
  MaintCopyDBMItem.Enabled := hasRecs;
  RecordExportMItem.Enabled := hasRecs;

  RecordSaveMItem.Enabled := canEdit and hasRecs;
  RecordDeleteMItem.Enabled := hasRecs;
  RecordEditMItem.Enabled := canEdit and hasRecs;

  btnDelete.Enabled := hasRecs;
  btnEdit.Enabled := not canEdit and hasRecs;
  btnSave.Enabled := canEdit;

  addressGrid.Col[2].ReadOnly  := not canEdit;
  specsGrid.Col[2].ReadOnly    := not canEdit;
  locGrid.Col[2].ReadOnly      := not canEdit;
  UserGrid.Col[1].ReadOnly     := not canEdit;
  UserGrid.Col[2].ReadOnly     := not canEdit;
  valuesGrid.Col[2].ReadOnly   := not canEdit;
  valuesGrid.Col[5].ReadOnly   := not canEdit;
  SalesGrid.Col[1].ReadOnly    := not canEdit;
  SalesGrid.Col[2].ReadOnly    := not canEdit;
  SalesGrid.Col[3].ReadOnly    := not canEdit;

  compNote.Enabled         := canEdit;

  PhotoAddMItem.Enabled    := canEdit;
  PhotoDeleteMItem.Enabled := canEdit;
  PhotoViewMItem.Enabled   := canEdit;

  for img := low(FThumbNailList) to High(FThumbNailList) do
    FThumbNailList[img].imgEditDescr.Enabled := canEdit;
end;

procedure TCompsDBList.ClickNewRecord(Sender: TObject);
var
  prop: AddrInfo;
  EffectiveDate: String;
begin
  EffectiveDate := '';
  //Use effective date or current date for sales date from
//  if assigned(FDoc) then
//    EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
  NewRecord(0,0,prop, EffectiveDate);
  SetEditMode(True);
end;

procedure TCompsDBList.ClickEditRecord(Sender: TObject);
begin
  SetEditMode(True);
end;

procedure TCompsDBList.ClickSaveRecord(Sender: TObject);
var
  dateStr: String;
begin
  If FModified then            //if there are changes
    SaveRecord;                //save

  //display the new Modified Date (shortcut)
  DateTimeToString(dateStr, 'mm/dd/yyyy', Date);
  lblModDate.Caption := dateStr;

  If not FModified then        //if saved properly...
    SetEditMode(False);
end;

procedure TCompsDBList.ClickDeleteRecord(Sender: TObject);
begin
  if PageControl.ActivePage = tabList then
    begin
      if dxDbGrid.SelectedCount > 0 then
        if OK2Continue(warnMsg6) then
          DeleteSelectedRecords;
    end
  else
    if OK2Continue(warnMsg2) then
      DeleteRecord;
end;

procedure TCompsDBList.ClickBtnPrev(Sender: TObject);
begin
  with dxDBGrid do
    begin
      if FocusedNode <> TopNode  then
        begin
          if FModified then SaveRecord;
          FDetailCmpID := TDxDbGridNode(TDxDbGridNode(FocusedNode).GetPrev).Id;
          ListDMMgr.CompQuery.Locate(compIDfldName, FDetailCmpID, []);
          OnRecChanged;
        end;
    end;
 end;

procedure TCompsDBList.ClickBtnFirst(Sender: TObject);
begin
  with dxDBGrid do
    if FocusedNode <> TopNode  then
      begin
        if FModified then SaveRecord;
        FDetailCmpID := TDxDbGridNode(TopNode).Id;
        ListDMMgr.CompQuery.Locate(compIDfldName, FDetailCmpID, []);
        OnRecChanged;
      end;
end;

procedure TCompsDBList.ClickBtnNext(Sender: TObject);
begin
  with dxDBGrid do
    begin
      if FocusedNode <> LastNode  then
        begin
          if FModified then SaveRecord;
          FDetailCmpID := TDxDbGridNode(TDxDbGridNode(FocusedNode).GetNext).Id;
          ListDMMgr.CompQuery.Locate(compIDfldName, FDetailCmpID, []);
          OnRecChanged;
        end;
    end;
end;

procedure TCompsDBList.ClickBtnLast(Sender: TObject);
begin
  with dxDBGrid do
    if FocusedNode <> LastNode  then
      begin
        if FModified then SaveRecord;
        FDetailCmpID := TDxDbGridNode(LastNode).Id;
        ListDMMgr.CompQuery.Locate(compIDfldName, FDetailCmpID, []);
        OnRecChanged;
      end;
end;

{*****************************}
{  Simulate continous tabbing }
{  between the grids/cntls    }
{*****************************}

procedure TCompsDBList.AddressGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (AddressGrid.CurrentDataRow = 6) and not (ssShift in Shift) then
      begin
        ActiveControl := SpecsGrid;
        SpecsGrid.CurrentCell.MoveTo(2,1);
        UserGrid.CurrentCell.SelectAll;
      end
    else if (AddressGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := ValuesGrid;
        ValuesGrid.CurrentCell.MoveTo(5, ValuesGrid.Rows);    //last cell
        ValuesGrid.CurrentCell.SelectAll;
      end;
end;

procedure TCompsDBList.SpecsGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (SpecsGrid.CurrentDataRow = 6) and not (ssShift in Shift) then
      begin
        ActiveControl := LocGrid;
        LocGrid.CurrentCell.MoveTo(2,1);
        UserGrid.CurrentCell.SelectAll;
      end
    else if (SpecsGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := AddressGrid;
        AddressGrid.CurrentCell.MoveTo(2,6);
        AddressGrid.CurrentCell.SelectAll;
      end;
end;

procedure TCompsDBList.LocGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (LocGrid.CurrentDataRow = 6) and not (ssShift in Shift) then
      begin
        ActiveControl := CompNote;
      end
    else if (LocGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := SpecsGrid;
        SpecsGrid.CurrentCell.MoveTo(2,6);
        UserGrid.CurrentCell.SelectAll;
      end;
end;

procedure TCompsDBList.CompNoteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (ssShift in Shift) then
      begin
        ActiveControl := LocGrid;
        LocGrid.CurrentCell.MoveTo(2,6);
        UserGrid.CurrentCell.SelectAll;
      end
    else
      begin
        ActiveControl := SalesGrid;
        SalesGrid.CurrentCell.MoveTo(1,1);
        UserGrid.CurrentCell.SelectAll;
      end;

  Key := 0;    //do not proces the Tab key in text
end;

procedure TCompsDBList.SalesGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (SalesGrid.CurrentDataCol = 3) and (SalesGrid.CurrentDataRow = 3) and not (ssShift in Shift) then
      begin
        ActiveControl := UserGrid;
        UserGrid.CurrentCell.MoveTo(1,1);
      end
    else if (SalesGrid.CurrentDataCol = 1) and (SalesGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := CompNote;
      end;
end;

procedure TCompsDBList.UserGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (UserGrid.CurrentDataCol = 2)and (UserGrid.CurrentDataRow = 3) and not (ssShift in Shift) then
      begin
        ActiveControl := ValuesGrid;
        ValuesGrid.CurrentCell.MoveTo(2,1);
        ValuesGrid.CurrentCell.SelectAll;
      end
    else if (UserGrid.CurrentDataCol = 1)and (UserGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := SalesGrid;
        SalesGrid.CurrentCell.MoveTo(3,3);
        SalesGrid.CurrentCell.SelectAll;
      end;
end;

procedure TCompsDBList.ValuesGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_TAB then
    if (ValuesGrid.CurrentDataCol = 5)and (ValuesGrid.CurrentDataRow = ValuesGrid.Rows) and not (ssShift in Shift) then  //last row
      begin
        ActiveControl := AddressGrid;
        AddressGrid.CurrentCell.MoveTo(2,1);
        AddressGrid.CurrentCell.SelectAll;
      end
    else if (ValuesGrid.CurrentDataCol = 2)and (ValuesGrid.CurrentDataRow = 1) and (ssShift in Shift) then
      begin
        ActiveControl := UserGrid;
        UserGrid.CurrentCell.MoveTo(2,3);
        UserGrid.CurrentCell.SelectAll;
      end;
end;

Procedure TCompsDBList.LoadDistinctSearchCriteria;
var
  genericSql, sqlStr: String;
begin
  genericSQL := 'SELECT DISTINCT %s AS ' + genericFldName + ' FROM Comps';

  sqlStr := Format(genericSql,[CountyFldName]);
  FillOutLookupCombo(sqlStr,cmbCounty);

  sqlStr := Format(genericSql,[CityFldName]);
  FillOutLookupCombo(sqlStr,cmbCity);

  sqlStr := Format(genericSql,[ZipFldName]);
  FillOutLookupCombo(sqlStr,cmbZip);
  cmbZip1.Items.Assign(cmbZip.Items);
  cmbZip2.Items.Clear;
  cmbZip2.Items.Assign(cmbZip.Items);

  sqlStr := Format(genericSql,[ProjectNameFldName]);
  FillOutLookupCombo(sqlStr,cmbNeighb);
  cmbNeighb1.Items.Clear;
  cmbNeighb1.Items.Assign(cmbNeighb.Items);
  cmbNeighb2.Items.Clear;
  cmbNeighb2.Items.Assign(cmbNeighb.Items);

  sqlStr := Format(genericSql,[DesignFldName]);
  FillOutLookupCombo(sqlStr,cmbDesign);
  cmbDesign1.Items.Clear;
  cmbDesign1.Items.Assign(cmbDesign.Items);
  cmbDesign2.Items.Clear;
  cmbDesign2.Items.Assign(cmbDesign.Items);

  sqlStr := Format(genericSql,[MapRef1FldName]);
  FillOutLookupCombo(sqlStr,cmbMapRef);
  cmbMapref1.Items.Clear;
  cmbMapref1.Items.Assign(cmbMapref.Items);
  cmbMapref2.Items.Clear;
  cmbMapref2.Items.Assign(cmbMapref.Items);

  //custom fields
  sqlStr := 'SELECT ' + CustFldNameFldName + ' FROM UserNames';
  try
  Q1.Close;
  Q1.SQL.Clear;
  Q1.SQL.Add(sqlStr);
  Q1.Open;
   except
    ShowAlert(atWarnAlert, errCompsConnection);
    exit;
  end;
  Q1.First;
  lblCustFieldName1.Caption := Q1.FieldByName(CustFldNameFldName).AsString;
  Q1.Next;
  lblCustFieldName2.Caption := Q1.FieldByName(CustFldNameFldName).AsString;
  Q1.Next;
  lblCustFieldName3.Caption := Q1.FieldByName(CustFldNameFldName).AsString;
  Q1.Close;
  sqlStr := Format(genericSql,[UserValue1FldName]);
  FillOutLookupCombo(sqlStr,cmbCustFldValue1);
  sqlStr := Format(genericSql,[UserValue2FldName]);
  FillOutLookupCombo(sqlStr,cmbCustFldValue2);
  sqlStr := Format(genericSql,[UserValue3FldName]);
  FillOutLookupCombo(sqlStr,cmbCustFldValue3);
end;

function TCompsDBList.GetSearchCriteria: String;
var
  criteriaStr, curCriteria,curSubCriteria: string;

  Procedure AddAndCriteria(var srchStr: String; curCriteria : String);
  begin
    if length(curCriteria) > 0 then
      begin
        if length(SrchStr) > 0 then
          srchStr := srchStr + ' AND ('
        else
          srchStr := ' WHERE (';
        srchStr := srchStr + curCriteria;
        srchStr := srchStr + ') ';
      end;
  end;

  Procedure AddOrCriteria(var existCriteria: String; subCriteria: String);
  begin
    if length(subCriteria) > 0 then
      begin
        if length(existCriteria) > 0 then
          existCriteria := ExistCriteria + ' OR ';
        existCriteria := existCriteria + ' (' + subCriteria + ') ';
      end;
  end;

  function BuildEqualCriteria(fldName, valueStr: String): String;
  begin
    result := '';
    if length(valueStr) > 0 then
      result := fldName + ' = ''' + valueStr + ''' ';
  end;

  function BuildIntRangeCriteria(fldName: String; edtMinValue,edtMaxValue: TEdit): String;
  var
    minValue,maxValue: Integer;
    minValueStr,maxValueStr: String;
  begin
    result := '';
    minValueStr := edtMinValue.Text;
    maxValueStr := edtMaxValue.Text;
    if length(minValueStr) > 0 then
      if not isValidInteger(minValueStr,MinValue) then
        begin
          ShowNotice(fldName + ' you entered are not valid.');
          exit;
        end;
    if length(maxValueStr) > 0 then
      if not isValidInteger(maxValueStr,MaxValue) then
        begin
          ShowNotice(fldName + ' you entered are not valid.');
          exit;
        end;
    if length(minValueStr) > 0 then
      if length(maxValueStr) > 0 then
        begin
          minValueStr := IntToStr(minValue);
          maxValueStr := IntToStr(maxValue);
          edtMinValue.Text := minValueStr;
          edtMaxValue.Text := maxValueStr;
          result := '( ' + fldName + ' >= ' + minValueStr + ' AND ' + fldName  + ' <= ' + maxValueStr + ' ) '
        end
      else
        begin
          minValueStr := IntToStr(minValue);
          edtMinValue.Text := minValueStr;
          result := fldName + ' >= ' + minValueStr + ' '
        end
    else
      if length(maxValueStr) > 0 then
        begin
          maxValueStr := IntToStr(maxValue);
          edtMaxValue.Text := maxValueStr;
          result := fldName + ' <= ' + maxValueStr + ' ';
        end;
  end;

  function BuildDoubleRangeCriteria(fldName: String; edtMinValue,edtMaxValue: TEdit): String;
  var
    minValue,maxValue: Double;
    minValueStr,maxValueStr: String;
  begin
    result := '';
    minValueStr := edtMinValue.Text;
    maxValueStr := edtMaxValue.Text;
    if length(minValueStr) > 0 then
      if not HasValidNumber(minValueStr,MinValue) then
        begin
          ShowNotice(fldName + ' you entered are not valid.');
          exit;
        end;
    if length(maxValueStr) > 0 then
      if not HasValidNumber(maxValueStr,MaxValue) then
        begin
          ShowNotice(fldName + ' you entered are not valid.');
          exit;
        end;
    if length(minValueStr) > 0 then
      if length(maxValueStr) > 0 then
        begin
          minValueStr := FloatToStrF(minValue, ffFixed, 15, 2);
          maxValueStr := FloatToStrF(maxValue, ffFixed, 15, 2);
          edtMinValue.Text := minValueStr;
          edtMaxValue.Text := maxValueStr;
          result := '( ' + fldName + ' >= ' + minValueStr + ' AND ' + fldName  + ' <= ' + maxValueStr + ' ) '
        end
      else
        begin
          minValueStr := FloatToStrF(minValue, ffFixed, 15, 2);
          edtMinValue.Text := minValueStr;
          result := fldName + ' >= ' + minValueStr + ' '
        end
    else
      if length(maxValueStr) > 0 then
        begin
          maxValueStr := FloatToStrF(maxValue, ffFixed, 15, 2);
          edtMaxValue.Text := maxValueStr;
          result := fldName + ' <= ' + maxValueStr + ' ';
        end;
  end;

  function BuildBeginingFromCriteria(fldName,valueStr: String): String;
  begin
    result := '';
    if length(valueStr) > 0 then
      result := fldName + ' LIKE ''' + valueStr + '%'' ';
  end;

  function BuildDateRangeCriteria(fldName: String; dateMin,dateMax: Tdate): String;
  var
    adjustedDateMin,adjustedDateMax: TDateTime;
  begin
    result := '';
    adjustedDateMin := StartOfTheMonth(dateMin);  //the first moment of the month
    adjustedDateMax := EndofTheMonth(dateMax);  //the last moment of the month
    if dateMin > 0 then
      if dateMax > 0 then
        result := fldName + ' >= #' + DateToStr(adjustedDateMin) + '# AND ' + fldName + ' <= #' + DateToStr(adjustedDateMax) + '# '
      else
        result := fldName + ' >= #' + DateToStr(adjustedDateMin) + '# '
    else
      if dateMax > 0 then
        result := fldName + ' <= #' + DateToStr(adjustedDateMax) + '# ';
  end;

begin
  criteriaStr := '';
  //design/appeal field
  curCriteria := '';
     //1st criteria
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(DesignFldName,cmbDesign.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
     //2nd criteria
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(DesignFldName,cmbDesign1.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
    //3rd criteria
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(DesignFldName,cmbDesign2.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
   AddAndCriteria(criteriaStr,curCriteria);
   //Street Name field
  curCriteria := '';
  curCriteria := BuildBeginingFromCriteria(StreetNameFldName,edtStreet.Text);
  AddAndCriteria(criteriaStr,curCriteria);
  //neighborhood, mapref, zip, city, county fields
  curCriteria := '';
    //neighborhood field
      //1st criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ProjectNameFldName,cmbNeighb.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //2nd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ProjectNameFldName,cmbNeighb1.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //3rd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ProjectNameFldName,cmbNeighb2.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
    //Map reference field
      //1st criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(MapRef1FldName,cmbMapref.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //2nd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(MapRef1FldName,cmbMapref1.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //3rd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(Mapref1FldName,cmbMapRef2.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
    //zip field
      //1st criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ZipFldName,cmbZip.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //2nd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ZipFldName,cmbZip1.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
      //3rd criteria
      curSubCriteria := '';
      curSubCriteria := BuildEqualCriteria(ZipFldName,cmbZip2.Text);
      AddOrCriteria(curCriteria,curSubcriteria);
    //City Field
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(CityFldName,cmbCity.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
    //County field
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(CountyFldName,cmbCounty.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
  AddAndCriteria(criteriaStr,curCriteria);
  //APN , MLS fields
  curCriteria := '';
    //APN field
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(ParcelNoFldName,edtAPN.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
    //MLS # field
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(MlsFldName,edtMls.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
  AddAndCriteria(criteriaStr,curCriteria);
  //sales price field
   curCriteria := BuildIntRangeCriteria(SalePriceDBNames[1],edtSalesPriceMin,edtSalesPriceMax);
   AddAndCriteria(criteriaStr,curCriteria);
  //GLA field
  curCriteria := BuildIntRangeCriteria(GlaFldName,edtGlaMin,edtGlaMax);
  AddAndCriteria(criteriaStr,curCriteria);
  //Total rooms field
  curCriteria := BuildIntRangeCriteria(TotalRmsFldName,edtTotalRmMin,edtTotalRmMax);
  AddAndCriteria(criteriaStr,curCriteria);
  //Bed Rooms field
  curCriteria := BuildIntRangeCriteria(BedRmsFldName,edtBedRmMin,edtBedRmMax);
  AddAndCriteria(criteriaStr,curCriteria);
  //Bath rooms field
  curCriteria := BuildDoubleRangeCriteria(BathRmsFldName,edtBathRmMin,edtBathRmMax);
  AddAndCriteria(criteriaStr,curCriteria);
  //age field
  curCriteria := BuildIntRangeCriteria(AgeFldName,edtAgeMin,edtAgeMax);
  AddAndCriteria(criteriaStr,curCriteria);
  //sales date field
  curCriteria := BuildDateRangeCriteria(SaleDateDBNames[1],rzDateEdtSalesMin.Date,rzDateEdtSalesMax.Date);
  AddAndCriteria(criteriaStr,curCriteria);
  //custom fields
  curCriteria := '';
    //custom field 1
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(UserValue1FldName,cmbCustFldValue1.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
    //custom field 2
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(UserValue2FldName,cmbCustFldValue2.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
    //custom field 3
    curSubCriteria := '';
    curSubCriteria := BuildEqualCriteria(UserValue3FldName,cmbCustFldValue3.Text);
    AddOrCriteria(curCriteria,curSubcriteria);
  AddAndCriteria(criteriaStr,curCriteria);
  result := criteriaStr;
end;

procedure TCompsDBList.btnFindClick(Sender: TObject);
var
  sqlStr, criteriaStr: string;
  criteriaOK: Boolean;
begin
  criteriaOK := True;
  sqlStr := 'Select * from Comps';

  try
    criteriaStr := GetSearchCriteria;
  except
    on E: Exception do
      begin
        ShowNotice(E.Message);
        criteriaOK := False;
      end;
  end;

  if criteriaOK then
    begin
      try
      sqlStr := sqlStr + criteriaStr + ' order by CompsID';
      ListDMMgr.CompQuery.Close;
      ListDMMgr.CompQuery.SQL.Clear;
      ListDMMgr.CompQuery.SQL.Add(sqlStr);
      ListDMMgr.CompQuery.Open;
      except
        ShowAlert(atWarnAlert, errCompsConnection);
        exit;
      end;
      if ListDMMgr.CompQuery.RecordCount > 0 then
        PageControl.ActivePage := tabList    //show the results
      else
        ShowNotice('No matching comparables were found.')
    end;
end;

procedure TCompsDBList.btnFindAllClick(Sender: TObject);
begin
  FindAll;
(*
  ListDMMgr.CompQuery.Close;
  ListDMMgr.CompQuery.SQL.Clear;
  ListDMMgr.CompQuery.SQL.Add('Select * from Comps order by CompsID');
  ListDMMgr.CompQuery.Open;
*)
end;

procedure TCompsDBList.btnPrintClick(Sender: TObject);
begin
  PrintRecords;
end;

procedure TCompsDBList.btnExportClick(Sender: TObject);
begin
  ExportRecords;
end;

procedure TCompsDBList.ClearSearchCriteria(tag: Integer);
begin
 case tag of
  tagCounty:
    cmbCounty.Text := '';
  tagCity:
    cmbCity.Text := '';
  tagZip:
    begin
      cmbZip.Text := '';
      cmbZip1.Text := '';
      cmbZip2.Text := '';
    end;
  tagNeighb:
    begin
      cmbNeighb.Text := '';
      cmbNeighb1.Text := '';
      cmbNeighb2.Text := '';
    end;
  tagStreetName:
    edtStreet.Text := '';
  tagApn:
    edtAPN.Text := '';
  tagMapRef:
    begin
      cmbMapRef.Text := '';
      cmbMapref1.Text := '';
      cmbMapRef2.Text := '';
    end;
  tagDesign:
    begin
      cmbDesign.Text := '';
      cmbDesign1.Text := '';
      cmbDesign2.Text := '';
    end;
  tagMLS:
    edtMLS.Text := '';
  tagCustFld:
    begin
      cmbCustFldValue1.Text := '';
      cmbCustFldValue2.Text := '';
      cmbCustFldValue3.Text := '';
    end;
  tagSalesPrice:
    begin
      edtSalesPriceMin.Text := '';
      edtSalesPriceMax.Text := '';
    end;
  tagSalesDate:
    begin
     rzDateEdtSalesMin.Text := '';
     rzDateEdtSalesMax.Text := '';
    end;
 tagAge:
    begin
     edtAgeMin.Text := '';
     edtAgeMax.Text := '';
    end;
  tagGla:
    begin
      edtGlaMin.Text := '';
      edtGlaMax.Text := '';
    end;
  tagTotalRm:
    begin
      edtTotalRmMin.Text := '';
      edtTotalRmMax.Text := '';
    end;
  tagBedRm:
    begin
      edtBedRmMin.Text := '';
      edtBedRmMax.Text := '';
    end;
  tagBathRm:
    begin
      edtBathRmMin.Text := '';
      edtBathRmMax.Text := '';
    end;
  end;
end;

procedure TCompsDBList.ExportRecords;
begin
 //check if there are records then...

 SaveDialog.Title := 'Export Comp Records';
 SaveDialog.FileName := 'Comps';
 if rdoExportText.checked then
    ExportToFile
  else
    ExportToExcell;
end;

procedure TCompsDBList.PrintRecords;
begin
  dxComponentPrinter1Link1.OnlySelected := ckbSelectedOnly.Checked;
  dxComponentPrinter1.Preview(True,nil);
end;

procedure TCompsDBList.ExportToExcell;
var
  fName: String;
  fPath: String;
begin
 SaveDialog.DefaultExt := 'xls';
 SaveDialog.InitialDir := VerifyInitialDir(appPref_DirExports, '');
 SaveDialog.Filter := 'Excel File (Comma Delimited *.xls)|*.xls';
 if SaveDialog.Execute then
   begin
     if (ckbSelectedOnly.Checked) then
       dxDBGrid.SaveToXLS(SaveDialog.FileName,false)
     else
       dxDBGrid.SaveTOXLS(SaveDialog.FileName,true);
     try
        fName := ExtractFileName(SaveDialog.FileName);
        fPath := ExtractFilePath(SaveDialog.FileName);
        ShellExecute(Handle, PChar('Open'), pChar('Excel.exe'), pChar(fName), pChar(fPath), SW_SHOWNORMAL);
     except
        ShowNotice('A problem was encountered when trying to launch Excel.');
     end;
   end;
end;

procedure TCompsDBList.ExportToFile;
begin
  SaveDialog.DefaultExt := 'txt';
  SaveDialog.InitialDir := VerifyInitialDir(appPref_DirExports, '');
  SaveDialog.Filter := 'Text File (Tab Delimited *.txt)|*.txt';
  if SaveDialog.Execute then
    begin
     if (ckbSelectedOnly.Checked) then
       dxDBGrid.SaveToText(SaveDialog.FileName,false, #9, '|', '|')
     else
       dxDBGrid.SaveToText(SaveDialog.FileName,true, #9, '|', '|');
     {ShellExecute(Handle, PChar('Open'), pChar('notepad.exe'), pChar(FFileName), pChar(SaveDialog.InitialDir), SW_SHOWNORMAL);
}
   end;
end;

//procedure TCompsList.dtpLowDateCloseUp(Sender: TObject);
//begin
//  edtLowDate.Text := FormatDateTime('mm/yyyy',dtpLowDate.Date);
//end;

//procedure TCompsList.dtpHiDateCloseUp(Sender: TObject);
//begin
//  edtHiDate.Text := FormatDateTime('mm/yyyy',dtpHiDate.Date);
//end;

procedure TCompsDBList.btnClearAllClick(Sender: TObject);
var
  tag: Integer;
begin
  for tag := 1 to nSearchFields  do
    ClearSearchCriteria(tag);
end;

//make this a command, combine with Find button
procedure TCompsDBList.ListFindAllMItemClick(Sender: TObject);
begin
  FindAll;
end;

procedure TCompsDBList.ListFindMItemClick(Sender: TObject);
begin
  PageControl.ActivePageIndex := tSearch;
end;

procedure TCompsDBList.FillOutLookupCombo(sqlStr: String; cmb: TComboBox);
var
  curItem: String;
begin
  try
  Q1.Close;
  Q1.SQL.Clear;
  Q1.SQL.Add(sqlStr);
  Q1.Open;
  Q1.First;
  except
    ShowAlert(atWarnAlert, errCompsConnection);
    exit;
  end;
  cmb.Items.Clear;
  while not Q1.Eof do
    begin
      curItem := Trim(Q1.FieldByName(GenericFldName).AsString);
      if length(curItem) > 0 then
        cmb.Items.Add(curItem);
      Q1.Next;
    end;
  Q1.Close;
end;

procedure TCompsDBList.OnbtnClearFldClick(Sender: TObject);
begin
  ClearSearchCriteria(TButton(Sender).Tag);
end;

procedure TCompsDBList.OnRefresBtnClick(Sender: TObject);
begin
  btnClearAll.Click;  //the criteria may be not in lookup values any more
  LoadDistinctSearchCriteria;
end;

procedure TCompsDBList.DeleteSelectedRecords;
var
  nSelectedRecs, selRec: Integer;
  dbIDColIndx: Integer;
  compsIDs: Array of String;
  strSql: String;
  compsIDsList: String;
begin
  Repaint;   //remove Warning dialog
  PushMouseCursor(crHourglass);
  try
    with dxDbGrid do
      begin
        nSelectedRecs := SelectedCount;
        dbIDcolIndx := ColumnByFieldName(compIDfldName).Index;
        if nSelectedRecs = 0 then
            exit;
        for selRec := 0 to nSelectedRecs - 1 do
          begin
            SetLength(compsIDs,selRec +1);
            compsIDs[selRec] := SelectedNodes[selRec].Values[dbIdColIndx];
          end;
      end;

      compsIDsList := '(' + CompsIDs[0];
      for selRec := 1  to nSelectedRecs - 1 do
        CompsIDsList := compsIDsList + ', ' + compsIDs[selRec];
      compsIDsList := compsIDsList + ')';

      with Q1 do
        begin
          //delete comp records
          Close;
          SQL.Clear;
          strSql := 'Delete From Comps Where CompsID in ' + CompsIDsList;
          SQL.Add(strSql);
          ExecSQL;
          Close;
        end;

      ListDMMgr.CompQuery.Requery();
      // delete photo records
      for selRec := 0 to nSelectedRecs - 1 do
        RemovePhotos(StrToInt(compsIDs[selRec]),True);
      OnRecChanged;
      SetEditMode(False);
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList.OnRecordsMenuClick(Sender: TObject);
var
  activeDoc: TComponent;
begin
  activeDoc := GetTopMostContainer;
  if not assigned(activeDoc) or not (activeDoc is TContainer) then
    begin
      FDoc := nil;
      if assigned(FDocCompTable) then
        FreeAndNil(FDocCompTable);
      if assigned(FDocListTable) then
        FreeAndNil(FDocListTable);
      RecordImportMItem.Enabled := False;
      RecordExportMItem.Enabled := False;
    end
  else
    begin
      FDoc := activeDoc;
      if assigned(FDocCompTable) then
        FreeAndNil(FDocCompTable);
      if assigned(FDocListTable) then
        FreeAndNil(FDocListTable);
      LoadReportCompTables;
      RecordImportMItem.Enabled := assigned(FDocCompTable) or assigned(FDocListTable);
      RecordExportMItem.Enabled := assigned(FDocCompTable) or assigned(FDocListTable);
    end;
end;

procedure TCompsDBList.OntabSearchEnter(Sender: TObject);
begin
  LoadDistinctSearchCriteria;
end;

procedure TCompsDBList.rzDateEdtSalesMinDropDown(Sender: TObject);
begin
  if length(rzDateEdtSalesMin.Text) = 0 then
    rzDateEdtSalesMin.Date := IncDay(Today, -180);   //start search 6 mos before today
end;

procedure TCompsDBList.ImportAllCompsMenuClick(Sender: TObject);
var
  col: Integer;
begin
  if FDocCompTable.Count > 1 then
    begin
      ProgressBar := TCCProgress.Create(self, False, 0, FDocCompTable.Count, 1, 'Saving Comparables ...');
      ProgressBar.IncrementProgress;
      PushMouseCursor(crHourglass);
      try
        for col := 1 to FDocCompTable.Count - 1 do
          if not FDocCompTable.Comp[col].IsEmpty then
            ImportComparable(col, tcSales, ImportOption);  //1-import; 0-saving
      OnRecChanged;
      FindAll;
      PageControl.ActivePage := tabDetail;        //detailed view
      finally
        PopMouseCursor;
        ProgressBar.Free;
      end;
    end;
end;

procedure TCompsDBList.ImportAllListingsMenuClick(Sender: TObject);
var
  col: Integer;
begin
  if FDocListTable.Count > 1 then
    begin
      ProgressBar := TCCProgress.Create(self, False, 0, FDocListTable.Count, 1, 'Saving Listings ...');
      ProgressBar.IncrementProgress;
      PushMouseCursor(crHourglass);
      try
          for col := 1 to FDocListTable.Count - 1 do
            if not FDocListTable.Comp[col].IsEmpty then
              ImportComparable(col, tcListing, ImportOption); //1-import; 0-saving
        OnRecChanged;
        PageControl.ActivePage := tabDetail;        //detailed view
      finally
        PopMouseCursor;
        ProgressBar.Free;
      end;
    end;
end;

function TCompsDBList.GetDateOFSalesCellText(isUAD: boolean): String;
type
  tSalesStatus = (Unknown, Settled, Active, inContract, Expired, Withdrawn);
const
  MaxDateVals = 10;
  SaleDateStat: array[1..MaxDateVals] of String = ('Settled sale','Settled sale',
    'Expired','Expired','Withdrawn','Withdrawn','Active','Contract','Contract','Contract');
  cmntFleldName = 'Comment';
  salesdateFldName = 'SalesDate';
  cellID = 960;
  sUAD = '{UAD}';
  strUnk = 'Unk';

  function GetStatusArrayIndex(cmntStr: String; var strStatusDate: String): integer;
  var
    curIndex: integer;
    charIndex: Integer;
    strFullDate: String;
    statusDate: TDatetime;
  begin
    result := 0;
    strStatusDate := '';
    //status field format: {fieldname mm/yy}
    for curIndex := 1 to MaxDateVals do
      begin
        charIndex := Pos('{' + SaleDateStat[curIndex], cmntStr);
        if charIndex > 0 then
          begin
          charIndex := charIndex + 1 + length(SaleDateStat[curIndex]);  //reset charIndex to date
            result := curIndex;
            //insert day into status date to validate date
            strFullDate :=  Copy(cmntStr,charIndex + 1,3)  // mm/
                            + '01/'
                            + Copy(cmntStr,charIndex + 4,2); // yy
            if TryStrToDate(strFullDate, statusDate) then
              strStatusDate := Copy(cmntStr, charIndex + 1, 5);
            break;
          end;
      end;
  end;

var
  strDBSalesDate: String;
  dbSalesDate: TDateTime;
  strDBComment: String;
  bUADrecord: boolean;
  saleStatus: tSalesStatus;
  statusArrayIndex: Integer;
  strStatusDate: String;
  strContractDate : String;
 begin
  result := '';
  bUADRecord := false;
  saleStatus := Unknown;
  with ListDMMgr.CompQuery do
    begin
      strDBSalesDate := FieldByName(salesdateFldName).AsString;
      strDBComment := FieldByName(cmntFleldName).AsString;
    end;
  if not tryStrToDate(strDBSalesDate, dbSalesDate) then
    strDBSalesDate := ''; //sales date in DB
  if Pos(sUAD, strDBComment) > 0 then
    bUADrecord := true;

  //get sale status
  if not bUADRecord then
    begin
      if length(strDBSalesDate) = 0 then
        saleStatus := Unknown
      else
        saleStatus := Settled;
    end
  else
    begin
      statusArrayIndex := GetStatusArrayIndex(strDBComment, strStatusDate);
      case statusArrayIndex of
        0: if length(strDBsalesDate) = 0 then
            saleStatus := Unknown
           else
            saleStatus := inContract;
        1,2:
          if length(strStatusDate) > 0 then    //need status date
            saleStatus := Settled
          else
            saleStatus := Unknown;
        3,4: if length(strStatusDate) > 0 then    //need status date
              saleStatus := Expired
             else
              saleStatus := Unknown;
        5,6: if length(strStatusDate) > 0 then    //need status date
              saleStatus := Withdrawn
             else
              saleStatus := Unknown;
        7: saleStatus := Active;
        8,9,10: saleStatus := inContract;  //never happens: ImportUADComparable wrote contract date in SalesDate field
      end;
    end;

  case saleStatus of
    Settled:
      if not bUADrecord then   //sales date in dbSalesdate
        begin
          if not isUAD then
            result := strDBSalesDate
          else
            begin
              DateTimeToString(result,'mm/yy',dbSalesDate);
              result := 's' + result + ';' + strUnk;
            end;
        end
      else //sales date in status date; contract date if exists in dbSalesDate
        begin
          if isUAD then
            begin
              result := 's' + strStatusDate + ';';
              if length(strDBSalesDate) > 0 then
                begin
                 DateTimeToString(strContractDate,'mm/yy',dbSalesDate);
                 result := result + 'c' + strContractDate;
                end
              else
                result := result + strUnk;
            end
          else
          result := Copy(strStatusDate, 1,3) + '01/' + Copy(strStatusDate,4,2); // mm/01/yy
        end;
    InContract:
      if isUAD then
        begin
          DateTimeToString(strContractDate,'mm/yy',dbSalesDate);
          result := 'c' + strContractDate;
        end;
    Active:
      if isUAD then
        result := 'Active';
    Expired:
      if isUAD then
        result := 'e' + strStatusDate;
    Withdrawn:
      if isUAD then
        result := 'w' + strStatusDate;

  end;
end;

(*
procedure TCompsDBList.GeoCoding1Click(Sender: TObject);
var
  ShowDialog,ShowMsg:Boolean;
  geoCode:TGeoCoder;
  ModalResult: TModalResult;
  sqlStr: String;
  p:Pointer;
begin
  ShowDialog := True;
  ShowMsg := True;
  geoCode := TGeoCoder.CreateGeoCoder(nil, True);
  try
    p := ListDMMgr.CompQuery.GetBookmark;
    LoadPropertyList(geoCode);
//    geoCode.GeoCodePropertyList;
    ModalResult := geoCode.ShowModal;
    if (ModalResult = mrOK) or (ModalResult = mrCancel) then
      begin
        with ListDMMgr do
        begin
          CompQuery.Refresh;
          if CompQuery.BookmarkValid(p) then
            CompQuery.GotoBookmark(p);
          OnRecChanged;
        end;
      end;
  finally
   ListDMMgr.CompQuery.FreeBookmark(p);
   geoCode.Free;
  end;
end;
*)

function  TCompsDBList.SubjectInDB: Boolean;
var
  prop: AddrInfo;
  StreetAddress: String;
begin
  StreetAddress := TContainer(FDoc).GetCellTextByID(46);
  prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
  prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);
  prop.City := TContainer(FDoc).GetCellTextByID(47);
  prop.State := TContainer(FDoc).GetCellTextByID(48);
  prop.Zip := TContainer(FDoc).GetCellTextByID(49);
  prop.UnitNo := TContainer(FDoc).GetCellTextByID(2141);

  result := FindRecord(prop) > 0;
end;

function  TCompsDBList.CompsInDB(CompID, compType:Integer): Boolean;
var
  CompCol: TCompColumn;
  StreetAddress,cityStZip: String;
  prop: AddrInfo;
begin
  if (CompType = gtSales) and (FDocCompTable.Count > 0) then
    CompCol := FDocCompTable.Comp[CompID]
  else if (CompType = gtListing) and (FDocListTable.Count > 0) then
    CompCol := FDocListTable.Comp[CompID];

  StreetAddress := CompCol.GetCellTextByID(925);
  prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
  prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);
  cityStZip := CompCol.GetCellTextByID(926);
  GetUnitCityStateZip(prop.UnitNo, prop.City, prop.State, prop.Zip, CityStZip);
  result := FindRecord(prop) > 0;
end;

procedure TCompsDBList.btnNewClick(Sender: TObject);
begin
  ClickNewRecord(sender);
end;

(*
procedure TCompsDBList.ProcessGeoCode(var geoCode: TGeoCoder);
var
  n, propCount: Integer;
  countStr: String;
  proxCount: Integer;
  isgeo:Boolean;
  PosItem: Integer;
  fullAddr, Accuracy, lat, lon: String;
  max: Integer;
begin
  try
    with geoCode do
    begin
      propCount := AddressList.Rows;
      countStr  := Format('%d',[propCount]);
      max := NotGeoCodeCount;
      FProgressBar := TCCProgress.Create(self, True, 0, max, 1, 'Performing Property Geo-Coding');
      FProgressBar.IncrementProgress;
      max := NotGeoCodeCount;
      for n := 0 to AddressList.Rows-1 do
        with AddressList do begin
          lat := Cell[rLat, n+1];
          lon := Cell[rLon, n+1];
          if (lat = '') or (lon = '') or (Cell[rInclude, n+1]=cbChecked) then
            begin
              fullAddr := Cell[rAddress, n+1];
              Accuracy := Cell[rAccuracy, n+1];
              Lat := Cell[rLat, n+1];
              Lon := Cell[rLon, n+1];
              isGeo := GetGeoCodeProperty(fullAddr, Accuracy, Lat, Lon);
              //geo-code
              if isGeo then
                begin
                   Cell[rLat, n+1] := lat;
                   Cell[rLon, n+1] := Lon;
                   Cell[rAccuracy, n+1] := Accuracy;
                   inc(proxCount);
                   FProgressBar.IncrementBy(1);
                end
              else
                begin
                  RowColor[n+1] := clCream;
                  Cell[rAccuracy, n+1] := 'Not Found';
                  Cell[rLat, n+1] := '';
                  Cell[rLon, n+1] := '';
                end;
            end;
        end;
     end;
     finally
       if assigned(FProgressBar) then
         FprogressBar.Free;
       if proxCount > 0 then
         begin
           GeoCode.SaveGeoCodeToComp(True);
           ListDMMgr.CompQuery.Refresh;   //we need to do a refresh to have the comps database refresh the new data
         end;
     end;
end;
*)


(*
procedure TCompsDBList.RunProcessTimerTimer(Sender: TObject);
begin
//  Disable bulk GeoCode
   if appPref_DBGeoCoded then exit; //make sure we only run when it's not set
   try
     if GeoCodeThread=nil then begin
       GeoCodeThread := TGeoCodeThread.Create(True);
       GeoCodeThread.Priority := tpIdle;
       GeoCodeThread.Resume;
     end;
   finally
     RunProcessTimer.Enabled := False;
   end;
end;
*)

(*
procedure TCompsDBList.RunGeoCodeInBackground;
begin
   if not appPref_DBGeoCoded then
    RunProcessTimer.Enabled := True;
end;
*)


procedure TCompsDBList.RecordImportMItemClick(Sender: TObject);
begin
  FImportOption := 1;
end;

end.


