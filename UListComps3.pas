unit UListComps3;

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
  Windows, DateUtils, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Menus,
  ComCtrls, ExtCtrls, ToolWin, Grids_ts, TSGrid, StdCtrls, DBCtrls, TSMask,ImgList,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid,dxTLClms,dxExEdtr,CheckLst,ADODB,DB,
  TMultiP, dxEdLib, MMOpen,
  UListDMSource, UGlobals, UImageView, UStrings, UGridMgr, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, dxDBTLCl, dxGrClms, dxEditor, Mask,
  RzEdit, RzDTP, UForms, DialogsXP, uListCompsUtils,
  UCC_Progress, RzButton, RzRadChk, IniFiles, uUADConsistency, RzLabel,
  RzLine,
  uGAgisCommon,
  uGAgisOverlays,
  uGAgisOnlineOverlays,
  uGAgisCalculations,
  uGAgisBingCommon,
  uGAgisBingOverlays,
  uGAgisOnlineMap,
  cGAgisBingMap,
  cGAgisBingGeo,
  OleCtrls, SHDocVw, RzSpnEdt,uCompGlobal, Buttons,
  RzShellDialogs, AdvMenus,ULicUser{,AWSI_Server_BingMaps,UServer_BingAuthorization};


const
  FieldsListSize = 15;          //this is the max number of rows in the detail grid
  Tmp_Import_LogINI = 'Tmp_Import_Log.ini';

  CApplicationID = 'e3>"w@35o77)f68^LW31n';


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

  TCompsDBList2 = class(TAdvancedForm)
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
    N1: TMenuItem;
    GeoCoding1: TMenuItem;
    BingMaps: TGAgisBingMap;
    Splitter1: TSplitter;
    PageControl: TPageControl;
    tabSearch: TTabSheet;
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
    SaveGroupBox: TGroupBox;
    chkAutoSaveSubject: TRzCheckBox;
    chkConfirmSubjectSaving: TRzCheckBox;
    chkConfirmCompsSaving: TRzCheckBox;
    chkAutoSaveComps: TRzCheckBox;
    cbxSaveListPrefs: TCheckBox;
    DBNavigator1: TDBNavigator;
    ScrollBox1: TScrollBox;
    edtComps: TComboBox;
    Label6: TLabel;
    edtProximity: TRzSpinEdit;
    btnFind: TButton;
    btnClearAll: TButton;
    Label24: TLabel;
    edtSubjectAddr: TEdit;
    Label14: TLabel;
    cmbSubjectCity: TComboBox;
    Label21: TLabel;
    cmbSubjectState: TComboBox;
    Label18: TLabel;
    cmbSubjectZip: TComboBox;
    Label26: TLabel;
    edtSalesDateNow: TRzDateTimeEdit;
    Label27: TLabel;
    edtMonth: TRzSpinEdit;
    Label28: TLabel;
    Label39: TLabel;
    edtSalesPriceMin: TEdit;
    Label40: TLabel;
    edtSalesPriceMax: TEdit;
    btnClearSalesPrice: TButton;
    Label55: TLabel;
    edtGlaMin: TEdit;
    Label20: TLabel;
    edtGlaMax: TEdit;
    btnClearGLA: TButton;
    Label77: TLabel;
    edtTotalRmMin: TEdit;
    Label22: TLabel;
    edtTotalRmMax: TEdit;
    btnClearTotalRm: TButton;
    Label80: TLabel;
    edtBedRmMin: TEdit;
    Label23: TLabel;
    EdtBedRmMax: TEdit;
    btnClearBedRm: TButton;
    Label81: TLabel;
    EdtBathRmMin: TEdit;
    Label41: TLabel;
    edtBathRmMax: TEdit;
    btnClearBathRm: TButton;
    Label49: TLabel;
    edtAgeMin: TEdit;
    Label5: TLabel;
    edtAgeMax: TEdit;
    btnClearAge: TButton;
    Label29: TLabel;
    cmbDesign: TComboBox;
    Label34: TLabel;
    cmbDesign1: TComboBox;
    Label35: TLabel;
    cmbDesign2: TComboBox;
    btnClearDesign: TButton;
    Label19: TLabel;
    edtStreet: TEdit;
    btnClearStreet: TButton;
    Label15: TLabel;
    cmbNeighb: TComboBox;
    Label16: TLabel;
    cmbNeighb1: TComboBox;
    Label17: TLabel;
    cmbNeighb2: TComboBox;
    btnClearNeighb: TButton;
    Label32: TLabel;
    cmbMapref: TComboBox;
    Label30: TLabel;
    cmbMapref1: TComboBox;
    Label31: TLabel;
    cmbMapref2: TComboBox;
    btnClearMapref: TButton;
    Label11: TLabel;
    cmbZip: TComboBox;
    Label12: TLabel;
    cmbZip1: TComboBox;
    Label13: TLabel;
    cmbZip2: TComboBox;
    btnClearZip: TButton;
    Label9: TLabel;
    cmbCity: TComboBox;
    btnClearCity: TButton;
    Label7: TLabel;
    cmbCounty: TComboBox;
    btnClearCounty: TButton;
    Label25: TLabel;
    edtAPN: TEdit;
    btnClearApn: TButton;
    Label44: TLabel;
    edtMLS: TEdit;
    btnClearMLS: TButton;
    lblCustFieldName1: TLabel;
    lblCustFieldName2: TLabel;
    lblCustFieldName3: TLabel;
    Label8: TLabel;
    cmbCustFldValue1: TComboBox;
    Label43: TLabel;
    cmbCustFldValue2: TComboBox;
    Label36: TLabel;
    cmbCustFldValue3: TComboBox;
    btnClearCustFldValue: TButton;
    SearchPanel: TPanel;
    tabList: TTabSheet;
    dxTreeList1: TdxTreeList;
    dxDBGrid: TdxDBGrid;
    btnClearSalesDate: TButton;
    edtSalesDatePrior: TRzDateTimeEdit;
    tabImport: TTabSheet;
    rdoSelection: TRadioGroup;
    Panel3: TPanel;
    Label33: TLabel;
    edtImportFolder: TEdit;
    btnImport: TButton;
    Panel2: TPanel;
    Splitter2: TSplitter;
    SelectFolderDialog: TRzSelectFolderDialog;
    Panel1: TPanel;
    chkListBox: TCheckListBox;
    badListBox: TCheckListBox;
    Label37: TLabel;
    Splitter3: TSplitter;
    ImpPopup: TAdvPopupMenu;
    ViewLog: TMenuItem;
    memoPopup: TAdvPopupMenu;
    PrintLog: TMenuItem;
    PrintDialog: TPrintDialog;
    Logs: TRichEdit;
    btnBrowse: TButton;
    N4: TMenuItem;
    ClearReports: TMenuItem;
    Panel4: TPanel;
    groupbox: TGroupBox;
    chkImportSubject: TCheckBox;
    chkImportSales: TCheckBox;
    chkImportListings: TCheckBox;
    chkImportRentals: TCheckBox;
    ViewLog1: TMenuItem;
    btnClearAddress: TButton;
    GroupBox2: TGroupBox;
    chkCreateNew: TCheckBox;
    chkUpdateExisting: TCheckBox;
    Label45: TLabel;
    Splitter5: TSplitter;
    GroupBox3: TGroupBox;
    chkImport1004: TCheckBox;
    chkImport1073: TCheckBox;
    chkImport2055: TCheckBox;
    chkImportLand: TCheckBox;
    chkImportMobileHm: TCheckBox;
    chkIncludeAllRptTypes: TCheckBox;
    chkImport1075: TCheckBox;
    lblRowNo: TLabel;
    Label38: TLabel;
    Label42: TLabel;
    edtStreetNum: TEdit;
    dxDBGridRowNo: TdxDBGridColumn;
    dxDBGridCompsID: TdxDBGridMaskColumn;
    dxDBGridReportType: TdxDBGridColumn;
    dxDBGridCreateDate: TdxDBGridDateColumn;
    dxDBGridModifiedDate: TdxDBGridDateColumn;
    dxDBGridUnitNo: TdxDBGridColumn;
    dxDBGridStreetNumber: TdxDBGridColumn;
    dxDBGridStreetName: TdxDBGridColumn;
    dxDBGridCity: TdxDBGridColumn;
    dxDBGridState: TdxDBGridColumn;
    dxDBGridZip: TdxDBGridColumn;
    dxDBGridCounty: TdxDBGridColumn;
    dxDBGridProjectName: TdxDBGridColumn;
    dxDBGridProjectSizeType: TdxDBGridColumn;
    dxDBGridFloorLocation: TdxDBGridColumn;
    dxDBGridMapRef1: TdxDBGridColumn;
    dxDBGridMapRef2: TdxDBGridColumn;
    dxDBGridCensus: TdxDBGridColumn;
    dxDBGridLongitude: TdxDBGridColumn;
    dxDBGridLatitude: TdxDBGridColumn;
    dxDBGridSalesPrice: TdxDBGridMaskColumn;
    dxDBGridSalesDate: TdxDBGridDateColumn;
    dxDBGridDataSource: TdxDBGridColumn;
    dxDBGridPrevSalePrice: TdxDBGridColumn;
    dxDBGridPrevSaleDate: TdxDBGridColumn;
    dxDBGridPrevDataSource: TdxDBGridColumn;
    dxDBGridPrev2SalePrice: TdxDBGridColumn;
    dxDBGridPrev2SaleDate: TdxDBGridColumn;
    dxDBGridPrev2DataSource: TdxDBGridColumn;
    dxDBGridVerificationSource: TdxDBGridColumn;
    dxDBGridPricePerGrossLivArea: TdxDBGridColumn;
    dxDBGridPricePerUnit: TdxDBGridColumn;
    dxDBGridFinancingConcessions: TdxDBGridColumn;
    dxDBGridSalesConcessions: TdxDBGridColumn;
    dxDBGridHOA_MoAssesment: TdxDBGridColumn;
    dxDBGridCommonElement1: TdxDBGridColumn;
    dxDBGridCommonElement2: TdxDBGridColumn;
    dxDBGridFurnishings: TdxDBGridColumn;
    dxDBGridDaysOnMarket: TdxDBGridColumn;
    dxDBGridFinalListPrice: TdxDBGridColumn;
    dxDBGridSalesListRatio: TdxDBGridColumn;
    dxDBGridMarketChange: TdxDBGridColumn;
    dxDBGridMH_Make: TdxDBGridColumn;
    dxDBGridMH_TipOut: TdxDBGridColumn;
    dxDBGridLocation: TdxDBGridColumn;
    dxDBGridLeaseFeeSimple: TdxDBGridColumn;
    dxDBGridSiteArea: TdxDBGridColumn;
    dxDBGridView: TdxDBGridColumn;
    dxDBGridDesignAppeal: TdxDBGridColumn;
    dxDBGridInteriorAppealDecor: TdxDBGridColumn;
    dxDBGridNeighbdAppeal: TdxDBGridColumn;
    dxDBGridQualityConstruction: TdxDBGridColumn;
    dxDBGridAge: TdxDBGridMaskColumn;
    dxDBGridCondition: TdxDBGridColumn;
    dxDBGridGrossLivArea: TdxDBGridMaskColumn;
    dxDBGridTotalRooms: TdxDBGridMaskColumn;
    dxDBGridBedRooms: TdxDBGridMaskColumn;
    dxDBGridBathRooms: TdxDBGridMaskColumn;
    dxDBGridUnits: TdxDBGridColumn;
    dxDBGridBasementFinished: TdxDBGridColumn;
    dxDBGridRoomsBelowGrade: TdxDBGridColumn;
    dxDBGridFunctionalUtility: TdxDBGridColumn;
    dxDBGridHeatingCooling: TdxDBGridColumn;
    dxDBGridEnergyEfficientItems: TdxDBGridColumn;
    dxDBGridGarageCarport: TdxDBGridColumn;
    dxDBGridFencesPoolsEtc: TdxDBGridColumn;
    dxDBGridFireplaces: TdxDBGridColumn;
    dxDBGridPorchesPatioEtc: TdxDBGridColumn;
    dxDBGridSignificantFeatures: TdxDBGridColumn;
    dxDBGridOtherItem1: TdxDBGridColumn;
    dxDBGridOtherItem2: TdxDBGridColumn;
    dxDBGridOtherItem3: TdxDBGridColumn;
    dxDBGridOtherItem4: TdxDBGridColumn;
    dxDBGridComment: TdxDBGridColumn;
    dxDBGridUserValue1: TdxDBGridColumn;
    dxDBGridUserValue2: TdxDBGridColumn;
    dxDBGridUserValue3: TdxDBGridColumn;
    dxDBGridAdditions: TdxDBGridColumn;
    dxDBGridNoStories: TdxDBGridColumn;
    dxDBGridParcelNo: TdxDBGridColumn;
    dxDBGridYearBuilt: TdxDBGridColumn;
    dxDBGridLegalDescription: TdxDBGridColumn;
    dxDBGridSiteValue: TdxDBGridColumn;
    dxDBGridSiteAppeal: TdxDBGridColumn;
    BingGeoCoder: TGAgisBingGeo;
    Timer1: TTimer;
    edtUnitNum: TEdit;
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
    procedure CompNoteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFindClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure ListFindAllMItemClick(Sender: TObject);
    procedure ListFindMItemClick(Sender: TObject);
    procedure OnbtnClearFldClick(Sender: TObject);
    procedure OnRefresBtnClick(Sender: TObject);
    procedure OnRecordsMenuClick(Sender: TObject);
    procedure rzDateEdtSalesMinDropDown(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
//    procedure RunProcessTimerTimer(Sender: TObject);
    procedure edtCompsExit(Sender: TObject);
    procedure tabSearchShow(Sender: TObject);
    procedure edtSubjectAddrChange(Sender: TObject);
    procedure edtProximityExit(Sender: TObject);
    procedure BingMapsMapShow(Sender: TObject);
    procedure dxDBGridClick(Sender: TObject);
    procedure BingMapsMapZoomEnd(Sender: TObject; iOldLevel,
      iNewLevel: Integer);
    procedure dxDBGridRowNoCustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure dxDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tabListShow(Sender: TObject);
    procedure dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure edtSalesDateNowExit(Sender: TObject);
    procedure edtMonthExit(Sender: TObject);
    procedure edtSalesDatePriorExit(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtImportFolderExit(Sender: TObject);
    procedure ImpPopupPopup(Sender: TObject);
    procedure ViewLogClick(Sender: TObject);
    procedure PrintLogClick(Sender: TObject);
    procedure tabImportShow(Sender: TObject);
    procedure ClearReportsClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure ViewLog1Click(Sender: TObject);
    procedure chkCreateNewClick(Sender: TObject);
    procedure chkUpdateExistingClick(Sender: TObject);
    procedure chkIncludeAllRptTypesClick(Sender: TObject);
    procedure ResetIncludeAllReportTypes(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dxDBGridDblClick(Sender: TObject);
    procedure RecordImportMItemClick(Sender: TObject);
    procedure TLCustomizeClick(Sender: TObject);
    procedure BingMapsOverlayMouseClick(Sender: TObject;
      eOverlayType: TGAgisOverlayType; iOverlayIndex: Integer);
    procedure Timer1Timer(Sender: TObject);
   private
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
    FSubjectAddrChanged: Boolean;  //true if subject address, city,state, zip is modified
    FFind: Boolean;  //true if find button is click
    FNew: Boolean;   //true if new button is click
    FAbortProcess: Boolean; //true if stop importing
    FFileCount: Integer;
    FAddedRecs: Integer;
    FUpdatedRecs: Integer;
    FIgnoredRecs: Integer;
    FNoDocKeys: Integer;
    FOnStartup: Boolean;
    appPref_ImportReportList: String;
    appPref_NotImportReportList: String;
    FFileNo: Integer;
    FImportOption: Integer;
    FAge: Integer;
    FModifiedDate: String;
//    //Ticket #1161
//    FAWServiceInUse: Boolean;
//    FCredentials : clsUserCredentials;
//    bingAuthKey: String;
//    FBingAuthorizationService: BingAuthorizationSoap;


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
    procedure ImportUADComparable(Index: Integer; CompCol: TCompColumn; lat, lon: String; ImportOption: Integer=0);
    procedure ExportUADComparable(Index: Integer; compCol: TCompColumn);
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
    procedure LoadPrefs;
    procedure SavePrefs;
    procedure GetGEOCode(var prop: AddrInfo);
    function SetupWHERE(Addr: AddrInfo):String;
//    procedure ProcessGeoCode(var geoCode: TGeoCoder);
//    procedure RunGeoCodeInBackground;

    //Professional Level logic starts here
    procedure GetSubjectLatLon;
    procedure AddAllMapPoints(hilite:boolean = False; RowNo:Integer=-1);
    procedure AddProximityRadius;
    procedure AddSubjectCircleAndMarker;
    procedure SetCompColor(RowNo:Integer);
    procedure ShowCompStatus;
    procedure AddMarker(aMarkerName:String; lat,lon:Double);
    procedure HighlightSelectedRow(RowNo:Integer; Lat,Lon: Double);
    procedure InvertSelection(var Grid: TdxDBGrid);


    //Import section
    function SelectSearchStartFolder: String;
    procedure GetReportFiles;
    procedure DoFileSearch(const PathName, FileName : string);
    function CollectImportReportlist: String;
    function CollectNotImportReportlist: String;
    function LoadImportReportListName: String;
    function LoadNotImportReportListName: String;
    procedure EnableMenuOptions;
    function GetReportTypeSelection: String;
    procedure ResetImpReportType(AllChecked:Boolean);
    function GetSearchCriteriaOnTopSection: String;
    function ValidateSubjectAddress:Boolean;

    function ReCalculateAge(age:Integer; ModifiedDate: String): Integer;
    procedure UseDefaultGridSettings;

   public
    FDoc: TComponent;                 //the current documenmt
    FAutoDetectComp:Boolean;   //Ticket #1231
    FNoMatch: Boolean;
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
    function FindRecord(Addr:AddrInfo):Integer;
    procedure OnRecChanged;
    function  SubjectInDB: Boolean;
    function  CompsInDB(CompID, CompType:Integer): Boolean;
    procedure ImportSubject(ImportOption:Integer = 0);
    function ExportComparable(Index: Integer; compType: Integer):Boolean;
    //For GEOCODING
    property ProgressBar: TCCProgress read FProgressBar write FProgressBar;

    property CompGrid: Integer read FGridType write SetGridType;
    property ImportOption: Integer read FImportOption write FImportOption;
  end;


  procedure ShowCompsDBList2(AOwner: TComponent; actPgIndex: Integer);

var
  CompsDBList2: TCompsDBList2;


implementation
{$R *.DFM}

uses
  ShellAPI,UAWSI_Utils,UWebConfig,
  UContainer, UStatus, Math, UBase, UUtil1, UUtil2, UCell,
  UPage, UCellAutoAdjust, UConvert, UWinUtils, UUADUtils, UMain, uListComp_Global, uMapUtils;

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
  GridPrefFile        = 'CompListPref2.ini';


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
  tImport = 5;

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
  tagAddress = 18;
  nSearchFields = 18;

type
  ECompSearchError = class(Exception);



{ This is the routine used to display the Comps Database Interface }
procedure ShowCompsDBList2(AOwner: TComponent; actPgIndex: Integer);
begin
  PushMouseCursor(crHourglass);
  try
  actPgIndex := 0;    //the Search page
  if CompsDBList2 = nil then
    begin
      if FileExists(appPref_DBCompsfPath) then
        begin
          CompsDBList2 := TCompsDBList2.Create(AOwner, actPgIndex, 0);    //the actPgIndex is search page
          CompsDBList2.Show;
        end;
    end
      else //avoid OnFormShow
        ShowWindow(CompsDBList2.Handle,SW_RESTORE);
  finally
    PopMouseCursor;
  end;
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

//we only want to load in the one that's not imported yet.  The check box is checked or the flag is 1
function TCompsDBList2.LoadImportReportListName: String;
var
  rptList, aItem, rptName : String;
  i: integer;
begin
  result := '';
  rptList := appPref_ImportReportList;
  if rptList <> '' then
    begin
      chkListBox.Items.Clear;
        while length(rptList) > 0 do
        begin
          aItem := popStr(rptList, ',');
          rptName := popStr(aItem,'|');
//          chkListBox.Items.Add(rptName);  //don't want to add unless it's a checked for not imported
          if trim(aItem) = '1' then
          begin
            chkListBox.Items.Add(rptName);
            i := chkListBox.Items.IndexOf(rptName);
            chkListBox.Checked[i] := True;
          end;
        end;
    end;
end;

function TCompsDBList2.LoadNotImportReportListName: String;
var
  rptList, aItem, rptName : String;
begin
  result := '';
  rptList := appPref_NotImportReportList;
  if rptList <> '' then
    begin
      badListBox.Items.Clear;

      if chkListBox.Items.Count = 0 then exit;   //if there's no import list, no need to show

      while length(rptList) > 0 do
      begin
         aItem := popStr(rptList, ',');   //separate each item
         rptName := popStr(aItem,'|');    //separate the report for that item
         badListBox.Items.Add(rptName);
      end;
    end;
end;


procedure TCompsDBList2.LoadPrefs;
var
  IniFilePath: String;
  PrefFile : TMemIniFile;
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
  chkUpdateExisting.Checked := appPref_ImportUpdate;
  chkCreateNew.Checked := not appPref_ImportUpdate;
  edtImportFolder.Text := appPref_ImportFolder;
  if appPref_ImportFolder <> '' then
  begin
    IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLists) + Tmp_Import_LogINI;
    PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader
    try
      With PrefFile do
      begin
        appPref_ImportReportList := ReadString('CompsDB', 'ImportReportList', appPref_ImportReportList);
        appPref_NotImportReportList := ReadString('CompsDB', 'NotImportReportList', appPref_NotImportReportList);
        LoadImportReportListName;
        LoadNotImportReportListName;
      end;
    finally
      PrefFile.Free;
    end;
  end;
end;

//github #199: since we change the grid option to include all fields and set field name visible to false
//so we can pick up the ini file setting to load it back
//since this unit is being used in the back ground process to add/update subject, comps through
//the form right click Save to Comp Database option, the form show event never happen,
//so the list grid option still have all the fields set to invisible we don't want to save the original settings
//back to the ini file.
//NOTE: the form show event has grid.loadfromini
constructor TCompsDBList2.Create(AOwner: TComponent; actPgIndex, actGridIndex: Integer);
begin
  inherited Create(AOwner);
  if not ReleaseVersion then
    begin
      BingMaps.APIKey := CF_TestBingMapAPIKey;
      BingMaps.APIURL := CF_BingMapAPIURL;
    end
  else
    begin
      BingMaps.APIURL := CF_BingMapAPIURL;
      BingMaps.APIKey := CF_BingMapAPIKey;
    end;
  BingMaps.ZoomLevel := defaultZoomLevel;
  BingMaps.CenterLatitude := ListDMMgr.FSubjectLat;
  BingMaps.CenterLongitude := ListDMMgr.FSubjectLon;

  BingMaps.RefreshMap;  //github #920: move refreshmap from formshow to create
  Timer1.Enabled := True; //Ticket #1255: Add the timer to wait for bingmaps done in loading so we can get the session key
  SettingsName := CFormSettings_CompsList;
  FNeedGeoCode := False;
  FFind := False;
  FNew := False;
  FOnStartUp := True;
  FDoc := Nil;
  FDocCompTable := Nil;
  FDocListTable := nil;
  KeyPreview := True;
  FAbortProcess := False;  //abort flag when esc key is hit set to TRUE
  FFileNo := 0;  //this will hold the file # on the report.


  //DPI fix for 125 and 144
  AdjustDPISettings;
  //anchor bottom scrollBox after the window has been resized
  ScrollBox.Anchors := [akLeft,akTop,akBottom];

  //Make sure we set the datasource dataset to use ClientDataSet
  ListDMMgr.CompDataSource.DataSet := ListDMMgr.CompClientDataSet;

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

//github #199: move from form show, we need to load the ini file setting to the grid
  PushMouseCursor(crHourglass);
  try
    if not ConnectToDB then
      begin
        CloseDb;
        ShowAlert(atStopAlert, 'The connection to the Comparables database could not be made. The Comparables Manager will now close down.');
        Close;
      end;

   if FileExists(FGridIniFile) then
      dxDBGrid.LoadFromIniFile(FGridIniFile)
   else
      UseDefaultGridSettings;
    FModified := False;
  finally
    PopMouseCursor;
    lblCompsID.Caption := '';
    lblCreateDate.Caption := '';
    lblModDate.Caption := '';
    LoadColumnList;
  end;


//  TLCustomizeColumn1.ColIndex := PrefPageFieldNameCol;
//  TLCustomizeColumn2.ColIndex := PrefPageVisibleCol;

  OpenImgDialog.filter := ImageLibFilter1 + ImageLibFilter2 + ImageLibFilter3;
  LoadFieldToCellIDMap;

  //setup Bing maps: load from ini settings
  edtProximity.Value := appPref_SubjectProximityRadius;
  edtComps.Text := trim(appPref_MaxCompsShow);


  SearchPanel.Height := ScrollBox1.Height;
  SearchPanel.Width := ScrollBox1.Width;
  GetSubjectLatLon;
end;

//Ticket #1161: get the ClickFORMS BingMaps authorization from AppraisalWorld



//github #199: the only time we need to call this routine is when there's no CompListPref.ini file in the preference folder.
procedure TCompsDBList2.UseDefaultGridSettings;
var
  i: Integer;
  aFieldName: String;
begin
  for i := 0 to dxDBGrid.ColumnCount - 1 do
  begin
    if dxDBGrid.Columns[I].Visible then continue
    else
      begin
        aFieldname := uppercase(dxDBGrid.Columns[I].Caption);
        if (pos('STREET', aFieldname) > 0) or
           (pos('CITY', aFieldName) > 0) or
           (pos('STATE', aFieldName) > 0) or
           (pos('ZIP', aFieldname) > 0) or
           (pos('COMPSID', aFieldName) > 0) or
           (pos('ROOM', aFieldName) > 0) or
           (pos('BATH', aFieldName) > 0) or
           (pos('AREA', aFieldname) > 0) or
           (pos('AGE', aFieldName) > 0) or
           (pos('DESIGN', aFieldName) > 0) or
           (pos('SALES', aFieldName) > 0) then
            dxDBGrid.Columns[I].Visible := True;
      end;
  end;
end;


procedure TCompsDBList2.AdjustDPISettings;
begin
   PageControl.Height :=  cmbCustFldValue3.top + cmbCustFldValue3.Height + 20;
   PageControl.Width := Scrollbox.Left + Scrollbox.width + 50;
   self.width := PageControl.Width + 20;
   self.height := PageControl.Height + StatusBar.Height + 20;
   self.ClientHeight := self.height;
   self.ClientWidth := self.width;
end;

(*
procedure TCompsDBList2.DisableMenuOptions;
begin
  DatabaseMenu.Enabled := False;
  ComparableMenu.Enabled := False;
  PhotosMenu.Enabled := False;
  View1.Enabled := False;
  MaintMenu.Enabled := False;
end;
*)

procedure TCompsDBList2.OnFormShow(Sender: TObject);
begin
    if FAutoDetectComp then    //Ticket #1231
      self.Left := 90000;  //move the dialog off the screen
    PageControl.ActivePageIndex := tSearch;  //set active page to search page
    if self.width <= PageControl.Width then  //make the dialog with bigger for user to see maps
      self.width := PageControl.width *2; 
    //save any active data before doing anything
    if Assigned(FDoc) then
      TContainer(FDoc).SaveCurCell;
end;

procedure TCompsDBList2.GetSubjectLatLon;
var
  SubjCol: TCompColumn;
  GeoCodedCell: TGeocodedGridCell;
  prop: AddrInfo;
  StreetAddress, EffDateStr: String;
  Street:String;
  NeedGeoCode: Boolean;
begin
  try
    EffDateStr := '';

    //no need to call the same routine if we already have lat/lon
    if (ListDMMgr.FSubjectLon <> 0) and (ListDMMgr.FSubjectLat <> 0) and FFind then exit;

    if FDoc = nil then
      FDoc := TContainer(main.ActiveContainer);
    if FDoc = nil then
    begin
      if Length(edtSubjectAddr.Text) = 0 then
      begin //load in aprraiser's address if no subject address
        edtSubjectAddr.Text := CurrentUser.UserInfo.Address;
        cmbSubjectCity.Text := CurrentUser.UserInfo.City;
        cmbSubjectState.Text := CurrentUser.UserInfo.State;
        cmbSubjectZip.Text := CurrentUser.UserInfo.Zip;
      end;
      if Length(edtSubjectAddr.Text) > 0 then
      begin
        Street := edtSubjectAddr.Text;
        prop.StreetNum := popStr(Street, #32);
        prop.StreetName := Street;
        prop.City := cmbSubjectCity.Text;
        prop.State := cmbSubjectState.Text;
        prop.Zip := cmbSubjectZip.Text;

        EffDateStr := '';
      end
    end
    else
    begin
      FDocCompTable := TCompMgr2.Create(True);
      FDocCompTable.BuildGrid(FDoc, gtSales);
      FDocListTable := TCompMgr2.Create(True);
      FDocListTable.BuildGrid(FDoc, gtListing);
      if (FDocCompTable = nil) and (FDocListTable = nil) then exit;
      if Assigned(FDocCompTable) and (FDocCompTable.Count > 0) then
        SubjCol := FDocCompTable.Comp[0]    //subject column
      else if assigned(FDocListTable) and (FDocListTable.Count > 0) then
        SubjCol := FDocListTable.Comp[0];
      if (FDocCompTable.Count = 0) and (FDocListTable.Count = 0) then
      begin
        exit;
      end;
      if not FFind then //we don't want to reload from the report after we override the subject
      begin
        StreetAddress := TContainer(FDoc).GetCellTextByID(46);
        prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
        prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

        prop.City := TContainer(FDoc).GetCellTextByID(47);
        prop.State := TContainer(FDoc).GetCellTextByID(48);
        prop.Zip := TContainer(FDoc).GetCellTextByID(49);
        prop.UnitNo := TContainer(FDoc).GetCellTextByID(2141);
        //Use effective date or current date for sales date from
        EffDateStr := TContainer(FDoc).GetCellTextByID(1132); //Effective date
        //load subject to search tab
        edtSubjectAddr.Text := Format('%s %s',[prop.StreetNum, prop.StreetName]);
        cmbSubjectCity.Text := prop.City;
        cmbSubjectState.Text := prop.State;
        cmbSubjectZip.Text := prop.Zip;
        edtUnitNum.Text    := prop.UnitNo;
      end;
    end;
    if subjCol = nil then
      NeedGeoCode := True
    else
    begin
      if assigned(FDoc) and assigned(SubjCol) and not SubjCol.IsEmpty then begin
        // Get report subject geocodes
        prop.Lat := '';  prop.Lon := '';  //clear before fill in
        if (SubjCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
        begin
          GeocodedCell := SubjCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
          if GeocodedCell.Latitude <> 0 then
            prop.lat := FloatToStr(GeocodedCell.Latitude);
          if GeocodedCell.Longitude <> 0 then
            prop.lon := FloatToStr(GeocodedCell.Longitude);

          if (length(prop.lat) <> 0) and (length(prop.lon)<>0) then
            begin
              ListDMMgr.FSubjectLat := StrToFloat(prop.lat);
              ListDMMgr.FSubjectLon := StrToFloat(prop.Lon);
            end
          else    //if no lat/lon from report, get from bingmap
          begin
            NeedGeoCode := True;
          end;
        end;
      end
      else
      begin
        NeedGeoCode := True;
      end;
    end;
  except ; end;
end;


procedure TCompsDBList2.LoadFieldToCellIDMap;
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

procedure TCompsDBList2.OnRecChanged;
begin
    LoadCustFieldNames;
    LoadCurRecToDetailView;
    try
      GetPhotoData;
      LoadImages;
    except on E:Exception do
  //    shownotice('OnRecChanged error: '+e.message);      ///### HANDLE: need to comment out when it's done
    end;
    SetEditMode(False);
    SetNavigationState;
end;


function TCompsDBList2.ConnectToDB: Boolean;
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
end;




procedure TCompsDBList2.LoadColumnList;
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

procedure TCompsDBList2.LoadCustFieldNames;
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
//shownotice('LoadCustFieldNames: '+e.Message);
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

procedure TCompsDBList2.GridTypeChange(Sender: TObject);
begin
  CompGrid := cmbxGridType.ItemIndex;
end;

procedure TCompsDBList2.SetGridType(Value: Integer);
begin
  if value <> FGridType then  //we are changing
    begin
      FGridType := Value;
      SetupDetailGridNames(value);
      LoadFieldList(1);
      LoadFieldList(2);
    end;
end;

procedure TCompsDBList2.SetupDetailGridNames(ViewID: Integer);
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

procedure TCompsDBList2.CloseDb;
begin
  ListDMMgr.CompQuery.Active := False;
  ListDMMgr.CompCFNQuery.Active := False;
  ListDMMgr.CompPhotoQuery.Active := False;
  ListDMMgr.CompConnect.Connected := False;
  ListDMMgr.CompClientDataSet.Active := False;
end;

procedure TCompsDBList2.ConnectionClose(Sender: TObject);
begin
  Close;
end;

function TCompsDBList2.CollectImportReportlist: String;
var
  i: Integer;
  aItem: String;
begin
   aItem := '';
   for i:= 0 to chkListBox.Items.Count - 1 do
   begin
     if chkListBox.Checked[i] then
     begin
       if aItem = '' then
         aItem := Format('%s|1',[chkListBox.Items[i]])
       else
         aItem := Format('%s,%s|1',[aItem, chkListBox.Items[i]]);
     end
     else
     begin
       if aItem = '' then
         aItem := Format('%s|0',[chkListBox.Items[i]])
       else
         aItem := Format('%s,%s|0',[aItem, chkListBox.Items[i]]);
     end;
   end;
   result := aItem;
end;

function TCompsDBList2.CollectNotImportReportlist: String;
var
  i: Integer;
  aItem: String;

begin
   aItem := '';
   for i:= 0 to badListBox.Items.Count - 1 do   //just collect all the items, should be unchecked
   begin
     if aItem = '' then
       aItem := Format('%s|0',[badListBox.Items[i]])
     else
       aItem := Format('%s,%s|0',[aItem, badListBox.Items[i]]);
   end;
   result := aItem;
end;


procedure TCompsDBList2.SavePrefs;
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
        WriteFloat('CompsDB', 'SubjectProximityRadius', appPref_SubjectProximityRadius);
        WriteString('CompsDB', 'MaxCompsShow', appPref_MaxCompsShow);
        WriteString('CompsDB', 'ImportFolder', appPref_ImportFolder);

        appPref_ImportReportList := CollectImportReportlist;
        appPref_NotImportReportList := CollectNotImportReportList;
        WriteBool('CompsDB', 'ImportUpdate', appPref_ImportUpdate);

        UpdateFile;      // do it now
    end;
  finally
    PrefFile.Free;
  end;
  //Save import report list box

  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirLists) + Tmp_Import_LogINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
    With PrefFile do
    begin
      WriteString('CompsDB', 'ImportReportList', appPref_ImportReportList);
      WriteString('CompsDB', 'NotImportReportList', appPref_NotImportReportList);
      UpdateFile;      // do it now
    end;
  finally
    PrefFile.Free;
  end;
end;


procedure TCompsDBList2.OnClose(Sender: TObject; var Action: TCloseAction);
begin
  if FModified then
    if OK2Continue('Do you want to save the changes to this comparable record?') then
      SaveRecord;

  if assigned(FDocCompTable) then
    FDocCompTable.Free;
  if assigned(FDocListTable) then
    FDocListTable.Free;
  if assigned(FGridCellIDMap) then
    FGridCellIDMap.Free;
  if assigned(FHeadCellIDMap) then
    FHeadCellIDMap.Free;
  if assigned(FSubGridCellIDMap) then
    FSubGridCellIDMap.Free;

  SavePrefs;

  CloseDB;
  FreeImages;

  RememberStuff;

  CompsDBList2 := nil;
  Action := caFree;
end;

procedure TCompsDBList2.RememberStuff;
begin
  appPref_CompEqualState := cbxCmpEqualSubjState.checked;
  appPref_CompEqualZip := cbxCmpEqualSubjZip.checked;
  appPref_CompEqualCounty := cbxCmpEqualSubjCounty.checked;
  appPref_CompEqualNeighbor := cbxCmpEqualSubjNeighbor.checked;
  appPref_CompEqualMapRef := cbxCmpEqualSubjMap.checked;
  appPref_CompSavePrefs := cbxSaveListPrefs.Checked;
end;

{**************************************************}
{  Utility routines for loading data into the grids}
{**************************************************}
//Use TClientDataSet to load to detail
procedure TCompsDBList2.LoadSixFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 6 do
    begin
      fldName := strArray[index];
      grid.Cell[colNo,index] := ListDMMgr.CompClientDataSet.FieldByName(fldName).AsString;
    end;
end;

//Use TCompQuery to save to COMPS table
procedure TCompsDBList2.SaveSixFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
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

procedure TCompsDBList2.SaveSixFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrSixNames);
var
  strVal: String;
  valInt: Integer;
  valReal: Double;
begin
{arrSixNames = ('TotalRooms','BedRooms','BathRooms','GrossLivArea','Age','NoStories');}
  strVal := grid.Cell[2,1];
  with ListDMMgr.CompQuery do
  begin
    if IsValidInteger(strVal, valInt) then
      FieldByName('TotalRooms').AsInteger := valInt;

    strVal := grid.Cell[2,2];
    if IsValidInteger(strVal, valInt) then
      FieldByName('BedRooms').AsInteger := valInt;

    strVal := grid.Cell[2,3];
    if HasValidNumber(strVal, valReal) then
      FieldByName('BathRooms').AsFloat := valReal;

    strVal := grid.Cell[2,4];
    if IsValidInteger(strVal, valInt) then
      FieldByName('GrossLivArea').AsInteger := valInt;

    strVal := grid.Cell[2,5];
    if IsValidInteger(strVal, valInt) then
      FieldByName('Age').AsInteger := valInt;

    FieldByName('NoStories').AsString := grid.Cell[2,6];
  end;
end;


procedure TCompsDBList2.LoadThreeFieldsToGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
var
  fldName: String;
  index: Integer;
begin
  for index := 1 to 3 do
    begin
      fldName := strArray[index];
      grid.Cell[colNo,index] := ListDMMgr.CompClientDataSet.FieldByName(fldName).AsString;
    end;
end;

procedure TCompsDBList2.SaveThreeFieldsFromGridCol(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
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

procedure TCompsDBList2.SaveThreeFieldsFromGridCol_B(grid: TtsGrid; colNo: Integer; strArray: arrThreeNames);
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

procedure TCompsDBList2.LoadFieldList(listNo: Integer);
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
        valuesGrid.Cell[colNo,index] := ListDMMgr.CompClientDataSet.FieldByName(curName).AsString;
    end;
end;

procedure TCompsDBList2.SaveFieldList(listNo: Integer);
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

procedure TCompsDBList2.LoadCurRecToDetailView;
var
  index: Integer;
  reportType, dateStr: String;
  cDate, mDate: TDateTime;
begin
  //grids
try
  //use client dataset query to load from the current selected item to the detail tab
  with ListDMMgr.CompClientDataSet do
  begin
    LoadSixFieldsToGridCol(addressGrid,2, addrGridDBFieldNames);
    LoadSixFieldsToGridCol(specsGrid,2, specsGridDBFieldNames);
    LoadSixFieldsToGridCol(locGrid,2, locGridDBFieldNames);
    LoadThreeFieldsToGridCol(SalesGrid,1, saleDateDBNames);
    LoadThreeFieldsToGridCol(SalesGrid,2, SalePriceDBNames);
    LoadThreeFieldsToGridCol(SalesGrid,3, SaleSourceDBNames);
    LoadThreeFieldsToGridCol(UserGrid,2, custValueFieldNames);

    //reportType
    reportType := FieldByName(ReportTypFldName).AsString;
    index := cmbxGridType.Items.IndexOf(reportType);
    if index < 0 then index := 0; //default URAR
    cmbxGridtype.ItemIndex := index;

    //record, Create and Modify Dates
    if FieldByName(compIDfldName).AsString<>'' then
      begin
        lblCompsID.Caption := FieldByName(compIDfldName).AsString;

        try
          if dxDBGrid.DataSource.DataSet.FieldByName('RowNo').AsInteger = 0 then
            lblRowNo.Caption := Format('%d',[dxDBGrid.DataSource.DataSet.RecNo])
          else
            lblRowNo.Caption := Format('%d',[dxDBGrid.DataSource.DataSet.FieldByName('RowNo').AsInteger]);
        except ; end;
        FDetailCmpID := FieldByName(compIDfldname).asInteger;
      end;
    cDate := FieldByName(createDateFldName).AsDateTime;
    mDate := FieldByName(modifDateFldName).AsDateTime;

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
    CompNote.Text := FieldByName(commentFldName).AsString;
  end;
    except on E:Exception do
//      ShowNotice('LoadCurRecToDetailView: '+e.Message);
    end;
end;

function TCompsDBList2.ReCalculateAge(age:Integer; ModifiedDate: String): Integer;
var
  mDate, cDate: TDateTime;
  days, years: Integer;
begin
  result := age;
  try
    if FAge <> age then exit;  //age is changed.  Do not recalculate.
    if IsValidDate(ModifiedDate, mDate, True) then
    cDate := now;
    days  := DateUtils.DaysBetween(cDate, mDate);
    years := round(days/365);
    result := age + years;
  except ; end;
end;



procedure TCompsDBList2.SaveRecord;
var
  reportType: String;
  ExtraComment: String;
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

  //Recalculate Age based on SoldDate not Modified date and current date
  ListDMMgr.CompQuery.FieldByName('Age').asInteger := ReCalculateAge(ListDMMgr.CompQuery.FieldByName('Age').AsInteger,
                                                      FModifiedDate);
  ListDMMgr.CompQuery.UpdateBatch(arCurrent);
//Need to refresh the client data set
  ListDMMgr.CompClientDataSet.Active := False;
  ListDMMgr.CompClientDataSet.Active := True;
  OnRecChanged;

  FModified := False;  //reset the modified flag after we save the record
  if FNew then
  begin
    //we need to refresh the client data set
    btnFind.Click;
  end;
  except
    on E: Exception do ShowNotice(E.Message);
  end;
end;

procedure TCompsDBList2.NewRecord(ImportOption: Integer; CompsID:Integer; Addr:AddrInfo; EffectiveDate:String='');
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
    with ListDMMgr.CompQuery do //should use compquery to do a full look up to determine new/old record
      begin
        where := '';
        if (length(Addr.StreetNum) > 0) and (length(Addr.StreetName) > 0) then
        begin
          where := SetupWHERE(Addr);
        end;
        Active := False;
        SQL.Text := 'Select * From COMPS ';
        SQL.Text := SQL.Text + Where;
        Active := True;
        ListDMMgr.CompClientDataSet.Active := False;
        ListDMMgr.CompClientDataSet.Active := True;
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
        begin  //move cursor to that compsid record
          if eof then
          begin
            CompsID := 0;
            Append;
            SetFieldsDefault;
            FieldByName(createDateFldName).AsDateTime := Date;
          end
          else begin
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
          Edit;
        end;

        FieldByName(modifDateFldName).AsDateTime := Date;
        reportType := cmbxGridType.Items[cmbxGridType.ItemIndex];
        if length(reportType)=0 then reportType := 'Unknown';
        FieldByName(ReportTypFldName).AsString := reportType;
        try
          UpdateBatch(arCurrent);
        except end;
        //Refresh;
        ListDMMgr.CompClientDataSet.Active := False;
        ListDMMgr.CompClientDataSet.Active := True;

        if CompsID = 0 then
          Last;
        OnRecChanged;
      end;
end;


procedure TCompsDBList2.DeleteRecord;
var
  cmpID, actCompID: Integer;
  {ok2Delete: Boolean;}
begin
  //use the label compsid caption to locate record through compquery
  actCompID := StrToInt(lblCompsID.Caption);
  if not ListDMMgr.CompQuery.Active then  //if not active, set it active(MAY BE we don't need this test, since it's already open
    ListDMMgr.CompQuery.Active := True;
  ListDMMgr.CompQuery.Locate(CompIDFldName, actCompID, []); //now at least compquery point to the current detail comps

  cmpID := ListDMMgr.CompQuery.FieldByName(compIDfldName).AsInteger;
  ListDMMgr.CompQuery.Delete;
  ListDMMgr.CompClientDataSet.Active := False;
  ListDMMgr.CompClientDataSet.Active := True;
  RemovePhotos(cmpID, True);

  OnRecChanged;
  if ListDMMgr.CompPhotoQuery.RecordCount = 0 then
    FreeImages;
  SetEditMode(False);
end;

procedure TCompsDBList2.OnGridEdit(Sender: TObject; DataCol, DataRow: Integer;
  ByUser: Boolean);
begin
  if (sender = UserGrid) and (DataCol = 1) then  //Customized names
    SaveCustFieldNames(DataRow)
  else
    FModified := True;
end;

procedure TCompsDBList2.OnCommentChanged(Sender: TObject);
begin
  If TMemo(sender).Modified then
    FModified := True;
end;

procedure TCompsDBList2.GetPhotoData;
var
  curCompID: Integer;
begin
try
  with ListDMMgr.CompPhotoQuery do
    begin
      Active := False;
      SQL.Clear;
//      if not ListDMMgr.CompQuery.FieldByName(compIDfldName).isNull then
//use client data set compid to do a look up in photo
      if not ListDMMgr.CompClientDataSet.FieldByName(compIDfldName).isNull then
//        curCompID := ListDMMgr.CompQuery.FieldByName(compIDFldName).AsInteger
        curCompID := ListDMMgr.CompClientDataSet.FieldByName(compIDFldName).AsInteger
      else //new record
        curCompID := 0;
      SQL.Add(Format(sqlString1,[photoTableName]) + Format(sqlString3,[compIDFldName,IntToStr(curCompID)]));
      Active := True;
  end;
except on E:Exception do
//  shownotice('GetPhotoData: '+e.Message);
end;
end;

procedure TCompsDBList2.LoadImages;
var
  nRecs,rcNo: Integer;
  imgPath: String;
  imgDesc: String;
  thumOrig: TPoint;
  thumb: TThumbEx;
begin
try
//  PushMouseCursor(crHourglass);
  screen.Cursor := crHourglass;
//  LockWindowUpdate(ScrollBox.Handle);
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
//    LockWindowUpdate(0);
//    PopMouseCursor;
    screen.Cursor := crDefault;
  end;
except on E:Exception do
//showNotice('LoadImages: '+e.Message);
end;
end;

procedure TCompsDBList2.FreeImages;
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

procedure  TCompsDBList2.ActivateThumbs(sender: TObject);
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

procedure TCompsDBList2.DesactivateThumbs(sender: TObject);
var
  imgNo: Integer;
begin
  FActiveThumb := nil;
  for imgNo := Low(FThumbNailList) to High(FThumbNailList) do
    FThumbNailList[imgNo].ActivateImg(False);
end;

procedure TCompsDBList2.OnEditImgDescr(sender: TObject);
begin
  with  ListDMMgr.CompPhotoQuery do
    begin
      RecNo := TThumbEx(sender).imgID;
      Edit;
      FieldValues[imgDescrFldName] := TThumbEx(sender).GetImageDescr;
      Post;
    end;
end;

procedure TCompsDBList2.DeletePhoto(sender: TObject);
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
procedure TCompsDBList2.ClickAddPhoto(Sender: TObject);
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
procedure TCompsDBList2.ClickDeletePhoto(Sender: TObject);
begin
  if FActiveThumb <> nil then
    DeletePhoto(FActiveThumb)
  else
    ShowNotice('There are not any selected Photos.');
end;

//user selected Photo/View menu item
procedure TCompsDBList2.ClickViewPhoto(Sender: TObject);
begin
  if FActiveThumb <> nil then
    FActiveThumb.ViewImage;
end;

procedure TCompsDBList2.ClickRestoreDefaults(Sender: TObject);
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

procedure TCompsDBList2.SaveCustFieldNames(custFldNo: Integer);
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

procedure TCompsDBList2.LoadReportCompTables;
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

function TCompsDBList2.SetupWHERE(Addr: AddrInfo):String;
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
      //ticket #1231: for the zip code we need to do a like to handle zip and plus4     
      where := where + ' AND ' + SetKeyLikeValue('Zip', Addr.Zip);
      if Addr.UnitNo <> '' then
        where := where + ' AND '+ SetKeyValue('UnitNo', Addr.UnitNo);
      result := Where;
    end;
end;

function TCompsDBList2.FindRecord(Addr: AddrInfo):Integer;
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

//Ticket #1255: put back the getGeoCode routine but only do with sessionkey not apikey
procedure TCompsDBList2.GetGEOCode(var prop: AddrInfo);
var
  NumStyle: TFloatFormat;
  geoInfo : TGAgisGeoInfo;
  geoStatus : TGAgisGeoStatus;
  sQueryAddress: String;
begin
  if BingMaps.SessionKey = '' then exit;  //don't do it if no session key
  BingGeoCoder.APIKey := BingMaps.SessionKey;
  sQueryAddress := edtSubjectAddr.text + ' ' + cmbSubjectCity.text + ', ' + cmbSubjectState.text + ' ' + cmbSubjectZip.text;
  geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, nil);
  if geoStatus = gsSuccess then
    begin
      prop.lat := FloatToStrF(geoInfo.dLatitude, NumStyle, 15, 10);
      prop.lon := FloatToStrF(geoInfo.dLongitude, NumStyle, 15, 10);
    end;
end;

procedure TCompsDBList2.ImportSubject(ImportOption: Integer = 0);
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
    if (length(prop.lat)=0) or (length(prop.lon)=0) then
    begin
      GetGEOCode(prop);  //Ticket #1255: only do geocode for the subject and only use session key
    end;
    //if no address donot import subject
    if (length(prop.StreetNum) = 0) and (length(prop.StreetName) =0) and (length(prop.City)=0) and
       (length(prop.State)=0) and (length(prop.Zip) = 0) then exit;

    CompsID := FindRecord(prop);

    EffectiveDate := '';
    //Use effective date or current date for sales date from
    if assigned(FDoc) then
      EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
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
                     // FieldByName(fldName).AsInteger := valInt;
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
        //Need to refresh the client data set
        ListDMMgr.CompClientDataSet.Active := False;
        ListDMMgr.CompClientDataSet.Active := True;
        FModified:= False;   //Reset modified flag here since we already save record
      end;

    OnRecChanged;
    PageControl.ActivePage := tabDetail;       //detailed view
    ImportSubPhotos;
    finally
      ProgressBar.Free;
    end;
  except on E:Exception do
//    ShowNotice('ImportSubject: '+e.Message);
  end;
end;

procedure TCompsDBList2.ImportComparable(Index: Integer; compType: Integer; ImportOption:Integer=0);
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
//  prop.Lat := '';  prop.Lon := '';  //clear before fill in
  // Get report subject geocodes
  if (CompCol.GetCellByID(CGeocodedGridCellID) is TGeocodedGridCell) then
  begin
    GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
    if GeocodedCell.Latitude <> 0 then
      prop.lat := FloatToStr(GeocodedCell.Latitude);
    if GeocodedCell.Longitude <> 0 then
      prop.lon := FloatToStr(GeocodedCell.Longitude);
  end;

  StreetAddress := trim(CompCol.GetCellTextByID(925));
  prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
  prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);

  cityStZip := trim(CompCol.GetCellTextByID(926));
  GetUnitCityStateZip(prop.UnitNo, prop.City, prop.State, prop.Zip, CityStZip);
//  prop.City := ParseCityStateZip3(cityStZip,cmdGetCity);
//  prop.State := ParseCityStateZip3(CityStZip,cmdGetState);
//  prop.Zip := ParseCityStateZip3(CityStZip,cmdGetZip);

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
  NewRecord(ImportOption, CompsID, prop, EffectiveDate);

  if TContainer(FDoc).UADEnabled then
    ImportUADComparable(Index, compCol, prop.lat, prop.lon, ImportOption)
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

              cityStZip := trim(CompCol.GetCellTextByID(926));
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
                       // FieldByName(fldName).AsInteger := valInt;
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
          //Need to refresh the client data set
          ListDMMgr.CompClientDataSet.Active := False;
          ListDMMgr.CompClientDataSet.Active := True;
          FModified:= False;  //reset modified flag to False after we save
        end;

      OnRecChanged;
      PageControl.ActivePage := tabDetail;        //detailed view
        if assigned(compCol.Photo.Cell) then
          ImportCompPhoto(compCol);
    end;
end;

function TCompsDBList2.ExportComparable(Index: Integer; compType: Integer):boolean;
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
  result := False;
  //make sure the comp query capture the current compid
  ListDMMgr.CompQuery.Locate(CompIDFldName, FDetailCmpID, []);
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

  if not compCol.IsEmpty  then
    if not FAutoDetectComp then
      if not WarnOK2Continue(msg) then   //Ticket #1231: only show pop up if not Auto Detect
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
  result := True;
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

procedure TCompsDBList2.ImportUADComparable(Index: Integer; CompCol: TCompColumn; lat, lon: String; ImportOption:Integer=0);
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
  actCompID: Integer;
  aFullBath, aHalfBath: String;
  fBath, hBath: Integer;
begin
  with ListDMMgr.CompQuery do
    begin
      Edit;
      //Load header
      StreetAddress := trim(CompCol.GetCellTextByID(925));
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
      actCompID := StrToIntDef(lblCompsID.Caption,0);
      if not ListDMMgr.CompQuery.Active then  //if not active, set it active(MAY BE we don't need this test, since it's already open
        ListDMMgr.CompQuery.Active := True;
      ListDMMgr.CompQuery.Locate(CompIDFldName, actCompID, []); //now at least compquery point to the current detail comps

      //Need to refresh the client data set
      ListDMMgr.CompClientDataSet.Active := False;
      ListDMMgr.CompClientDataSet.Active := True;


    end;

  OnRecChanged;
  PageControl.ActivePage := tabDetail;        //detailed view
  if assigned(compCol.Photo.Cell) then
    ImportCompPhoto(compCol);
end;

procedure TCompsDBList2.ExportUADComparable(Index: Integer; compCol: TCompColumn);
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
  fBath,hBath: Integer;
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
//                    theCell.GSEData := GSEData.CommaText;
                    // Set formatting to ensure that '1.1' does not show as '1.10'
                    theCell := CompCol.GetCellByID(1043);
                    PosGSE := Pos('.', tmpStr);
                    if (PosGSE = 0) or (Length(Copy(tmpStr, Succ(PosGSE), Length(tmpStr))) < 2) then
                      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P1)    //round to 0.1
                    else
                      theCell.FCellFormat := SetBit(theCell.FCellFormat, bRnd1P2);   //round to 0.01
                    //if we have full bath cell id 1868 and half bath cell 1869, use the bath count to populate
                    //tmpstr has f.h
                    aTemp := popStr(tmpStr, '.');
                    fBath := StrToIntDef(aTemp, 0);
                    hBath := StrToIntDef(aTemp, 0);
                    if fBath > 0 then
                      GSEData.Values['1868'] := Format('%d',[fBath]);
                    if hBath > 0 then
                      GSEData.Values['1869'] := Format('%d',[hBath]);

                    theCell.GSEData := GSEData.CommaText;

                    theCell := CompCol.GetCellByID(1868);
                    if assigned(theCell) then
                      theCell.SetText(Format('%d',[fBath]));
                    theCell := CompCol.GetCellByID(1869);
                    if assigned(theCell) then
                      theCell.SetText(Format('%d',[hBath]));
                    //CompCol.SetCellTextByID(1868, Format('%d',[fBath]));
                    //CompCol.SetCellTextByID(1869, Format('%d',[hBath]));

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

procedure TCompsDBList2.ImportSubjectMenuClick(Sender: TObject);
begin
  ImportSubject(FImportOption); //1-import
end;

procedure TCompsDBList2.ImportCompMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    if not assigned(Sender) then exit;
    compID := TMenuItem(Sender).Tag;
    ImportComparable(CompID, tcSales,FImportoption);  //1 - import
    OnRecChanged;
    PageControl.ActivePage := tabDetail;        //detailed view
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList2.ImportListingMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  PushMouseCursor(crHourglass);
  try
    if not assigned(Sender) then exit;
    compID := TMenuItem(Sender).Tag;
    ImportComparable(CompID, tcListing,FImportoption);  //1 - import
    OnRecChanged;
    PageControl.ActivePage := tabDetail;        //detailed view
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList2.ExportCompMenuClick(Sender: TObject);
var
  compID: Integer;
begin
  compID := TMenuItem(Sender).Tag;
  if dxDBGrid.Count > 0 then  //we have to update photos before doing export
    if TDxDbGridNode(dxDBGrid.FocusedNode).ID <> FDetailCmpID then
      OnRecChanged;
  ExportComparable(CompID,tcSales);
end;

procedure TCompsDBList2.ExportListingMenuClick(Sender: TObject);
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

function TCompsDBList2.GetPhotoFilePath(compID: Integer; const Title: String): String;
begin
  if FCompDBPhotosDir = '' then
    FCompDBPhotosDir := IncludeTrailingPathDelimiter(ExtractFileDir(appPref_DBCompsfPath)) + compPhotoDir;
  result := IncludeTrailingPathDelimiter(FCompDBPhotosDir) +
            IntToStr(CompID) + '_' + IntToStr(RandomRange(250,999)) +
            '_' + Title + '.jpg';   //default ext

// result := folder/compID_###_Front.jpg    (recNo_randomNo_Title.ext)
end;

procedure TCompsDBList2.AddPhotoRecord(compID: Integer; Title, filePath: String; relPath, showPhoto: Boolean);
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

procedure TCompsDBList2.AddPhotoFromCell(compID: Integer; Cell: TObject; Const Title: String);
var
  photoPath: String;
begin
  //add photo to Photos Directory
  try  //two excepts because SaveToFile will catch the first one.
    try
      StatusBar.Panels[3].text := 'Adding photo ' + Title;
      photoPath := GetPhotoFilePath(compID, Title);
      TPhotoCell(Cell).SaveToFile(photoPath);
//      AddPhotoRecord(compID, Title, photoPath, True, True);
      AddPhotoRecord(compID, Title, photoPath, True, False);
      StatusBar.Panels[3].Text := '';
    except
    end;
  except
    ShowNotice('There was a problem adding the image "'+Title+'" to the Comparables database.');
  end;
end;

procedure TCompsDBList2.ImportSubPhotos;
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

procedure TCompsDBList2.ImportCompPhoto(cmpCol: TCompColumn);
var
  cmpID: Integer;
  photoCell: TPhotoCell;
begin
  cmpID := ListDMMgr.CompQuery.FieldValues[compIDFldName];    //photo will be assoc w/this comp rec
  photoCell := cmpCol.Photo.Cell;                             //this cell has photo

  if Assigned(photoCell) and photoCell.HasData then
    AddPhotoFromCell(cmpID, photoCell, 'Front');
end;

procedure TCompsDBList2.ExportCompPhoto(cmpCol :TCompColumn);
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

procedure TCompsDBList2.EliminateDuplicates(Sender: TObject);
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

procedure TCompsDBList2.RemovePhotos(compID: Integer; bDelFiles: Boolean);
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

procedure TCompsDBList2.SetFieldsDefault; // set text fields to the empty string
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
          if assigned(CompsDBList2) then
            CompsDBList2.ImgList1.GetBitmap(0,Picture.Bitmap)
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
//    showNotice('TThumbEx.Create: '+e.Message);
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
    CompsDBList2.ImgList1.GetBitmap(1,FImage.Picture.Bitmap)
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

procedure TCompsDBList2.ClickRefreshRecord(Sender: TObject);
var
  bFreeze: Boolean;
begin
  PushMouseCursor(crHourglass);
  bFreeze := LockWindowUpdate(Handle);
  try
    listDMMgr.CompQuery.Refresh;
    listDMMgr.CompClientDataSet.Refresh;
  finally
    if bFreeze then
      LockWindowUpdate(0);
    PopMouseCursor;
  end;
end;

procedure TCompsDBList2.ClickBackupDatabase(Sender: TObject);
begin
  BackupComps;
end;

procedure TCompsDBList2.BackupComps;
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

procedure TCompsDBList2.OnDragPrefNodeOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if Sender = TLCustomize then
    Accept := True;
end;

//In Preferences - hide/show the columns
procedure TCompsDBList2.OnPrefListDblClick(Sender: TObject);
//var
//  bVisible: Boolean;
begin
(*
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
*)
end;

procedure TCompsDBList2.OnPrefListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if (Sender = TLCustomize) and assigned(TLCustomize.DragNode)  then
    with TLCustomize  do
      begin
        DragNode.MoveTo(FocusedNode,natlInsert); // move the column on the preferences list
        TdxTreeListColumn(DragNode.Data).ColIndex := DragNode.Index; //move the column on the grid
      end;
end;

procedure TCompsDBList2.OnDragEndGridColumn(Sender: TObject;
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

procedure TCompsDBList2.OnGridNodeChange(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  //should happen on when moving to Detail View
  OnRecChanged;
end;

procedure TCompsDBList2.ClickListUndoGroups(Sender: TObject);
begin
  dxDBGrid.ClearGroupColumns;
end;

procedure TCompsDBList2.ClickListUndoSort(Sender: TObject);
begin
  with dxDBGrid do
    begin
      ClearColumnsSorted;
      FullRefresh;
    end;
end;

procedure TCompsDBList2.BeforeChangeTab(Sender: TObject; var AllowChange: Boolean);
begin
  case PageControl.TabIndex of
    tSearch:
      begin  end;
    tList:
      begin
      end;
    tDetail:
      if FModified then SaveRecord;
    tExport:
      begin end;
    tPref:
      begin end;
  end;
end;

procedure TCompsDBList2.AfterChangeTab(Sender: TObject);
begin
  PhotoAddMItem.Enabled    := False;
  PhotoDeleteMItem.Enabled := False;
  PhotoViewMItem.Enabled   := False;;

  try
    case PageControl.TabIndex of
      tList:
        begin
          if FAddedRecs > 0 then
          begin
            btnFind.Click;
            FAddedRecs := 0;  //reset back to 0;
          end
          else if dxDBGrid.Count = 0 then
            btnFind.Click;
          if dxDBGrid.Count > 0 then
            begin
              dxDBGrid.MakeNodeVisible(dxDBGrid.FocusedNode);  //synchronize with the detail view
              
            end;
        end;
      tDetail:   {detail view - sync with grid}
        if dxDBGrid.Count > 0 then
        begin
          if TDxDbGridNode(dxDBGrid.FocusedNode).ID <> FDetailCmpID then
            OnRecChanged;

        end;
      tPref:
        LoadColumnList;
    end;
  except;
  end;
end;

procedure TCompsDBList2.SetNavigationState;
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

procedure TCompsDBList2.SetEditMode(canEdit: Boolean);
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

//  PhotoAddMItem.Enabled    := canEdit;
//  PhotoDeleteMItem.Enabled := canEdit;
//  PhotoViewMItem.Enabled   := canEdit;

  for img := low(FThumbNailList) to High(FThumbNailList) do
    FThumbNailList[img].imgEditDescr.Enabled := canEdit;

  if appPref_UseCompDBOption >= lProfessional then
    RecordEditMItem.Enabled := hasRecs;


end;

procedure TCompsDBList2.ClickNewRecord(Sender: TObject);
var prop: AddrInfo;
  EffectiveDate: String;
begin
  FNew := True;
  EffectiveDate := '';
  //Use effective date or current date for sales date from
  if assigned(FDoc) then
    EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
  NewRecord(0, 0,prop, EffectiveDate);
  SetEditMode(True);
end;

procedure TCompsDBList2.ClickEditRecord(Sender: TObject);
var
  actCompID : Integer;
begin
  //use the label compsid caption to locate record through compquery
  OnRecChanged;
  PageControl.ActivePage := tabDetail;       //detailed view
  actCompID := StrToInt(lblCompsID.Caption);
  if not ListDMMgr.CompQuery.Active then  //if not active, set it active(MAY BE we don't need this test, since it's already open
    ListDMMgr.CompQuery.Active := True;
  ListDMMgr.CompQuery.Locate(CompIDFldName, actCompID, []); //now at least compquery point to the current detail comps
  FAge := ListDMMgr.CompQuery.FieldByName('Age').AsInteger;
  SetEditMode(True);
  PhotoAddMItem.Enabled    := not ListDMMgr.CompQuery.EOF;
  PhotoDeleteMItem.Enabled := not ListDMMgr.CompQuery.EOF;
  PhotoViewMItem.Enabled   := not ListDMMgr.CompQuery.EOF;
end;

procedure TCompsDBList2.ClickSaveRecord(Sender: TObject);
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

procedure TCompsDBList2.ClickDeleteRecord(Sender: TObject);
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

procedure TCompsDBList2.ClickBtnLast(Sender: TObject);
begin
end;

{*****************************}
{  Simulate continous tabbing }
{  between the grids/cntls    }
{*****************************}

procedure TCompsDBList2.AddressGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.SpecsGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.LocGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.CompNoteKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.SalesGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.UserGridKeyDown(Sender: TObject; var Key: Word;
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

procedure TCompsDBList2.ValuesGridKeyDown(Sender: TObject; var Key: Word;
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

Procedure TCompsDBList2.LoadDistinctSearchCriteria;
var
  genericSql, sqlStr: String;
begin
  if (cmbCity.Items.Count > 0) or (cmbZip.Items.Count > 0) then exit;  //do not load again if already load
  ProgressBar := TCCProgress.Create(self, False, 0, 2, 1, 'Loading Drop Down List Items ...');
  ProgressBar.IncrementProgress;
  try
    genericSQL := 'SELECT DISTINCT %s AS ' + genericFldName + ' FROM Comps';

    sqlStr := Format(genericSql,[CountyFldName]);
    FillOutLookupCombo(sqlStr,cmbCounty);

    sqlStr := Format(genericSql,[CityFldName]);
    FillOutLookupCombo(sqlStr,cmbCity);
    cmbSubjectCity.Items.Clear;
    cmbSubjectCity.Items.Assign(cmbCity.Items);

    sqlStr := Format(genericSql,[ZipFldName]);
    FillOutLookupCombo(sqlStr,cmbZip);
    cmbZip1.Items.Assign(cmbZip.Items);
    cmbZip2.Items.Clear;
    cmbZip2.Items.Assign(cmbZip.Items);
    cmbSubjectZip.Items.Clear;
    cmbSubjectZip.Items.Assign(cmbZip.Items);

    sqlStr := Format(genericSql, [StateFldName]);
    FillOutLookupCombo(sqlStr, cmbSubjectState);


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
  finally
    if assigned(ProgressBar) then
      ProgressBar.Free;
  end;
end;


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


  function BuildEqualCriteria(fldName, valueStr: String): String;
  begin
    result := '';
    if length(valueStr) > 0 then
      result := fldName + ' = ''' + valueStr + ''' ';
  end;

  function BuildLikeCriteria(fldName, valueStr: String): String;
  begin
    result := '';
    if length(valueStr) > 0 then
      result := fldName + ' like ''' + valueStr + '%'' ';     //put * at the end to include like %
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

function TCompsDBList2.GetSearchCriteriaOnTopSection: String;
var
  criteriaStr, curCriteria,curSubCriteria: string;
  SalesDatePriorDate: TDate;
  Street, StreetNum, StreetName: String;

begin
  criteriaStr := '';
  curCriteria := '';
  //sales date field
  if edtSalesDatePrior.Text <>'' then
    SalesDatePriorDate := edtSalesDatePrior.Date
  else
    SalesDatePriorDate := 0;

  if (edtSalesDateNow.Text<>'') and (edtSalesDatePrior.Text<>'') then
   curCriteria := BuildDateRangeCriteria(SaleDateDBNames[1],SalesDatePriorDate,edtSalesDateNow.Date);
  if curCriteria <> '' then   //only include this subcriteria is we have sales date criteria
  begin
    curSubcriteria := 'SalesDate is Null';
    AddOrCriteria(curCriteria,curSubcriteria);
  end;
  AddAndCriteria(criteriaStr,curCriteria);

  //1st criteria
  //Compose the subject address
    if (length(edtSubjectAddr.Text) > 0) and
       (length(cmbSubjectCity.Text) > 0) and
       (length(cmbSubjectState.Text) > 0) and
       (length(cmbSubjectZip.Text) > 0) then
    begin
      result := criteriaStr;
      if FAutoDetectComp then   //ticket #1257: for auto detect, only exit if Subject address are filled in
        begin
          if result <> '' then
            exit;
        end
//      else
//        exit;
    end;

    if edtSubjectAddr.Text <> '' then
    begin
      Street := edtSubjectAddr.Text;
      StreetNum := popStr(Street, #32);
      if StreetNum <> '' then
      begin
        curCriteria := Format('%s like ''%s''',[streetNoFldName, streetNum]);
        if FAutoDetectComp and (curCriteria <> '') then
          AddAndCriteria(criteriastr,curCriteria);
      end;
      StreetName := Street;
      if StreetName <> '' then
      begin
        curCriteria := Format('%s like ''%s''',[streetNameFldName, StreetName]);
        if pos('''', StreetName) > 0 then  //Ticket #1269: handle single quote
          curCriteria := Format('%s like "%s"',[streetNameFldName, StreetName]);
        if FAutoDetectComp and (curCriteria <> '') then
          AddAndCriteria(criteriastr,curCriteria);
      end;
    end;
    if cmbSubjectCity.Text <> '' then
    begin
      curCriteria := BuildLikeCriteria(cityFldName, trim(cmbSubjectCity.Text));
      if pos('''', cmbSubjectCity.Text) > 0 then //ticket #1269: handle single quote
        curCriteria := Format('%s like "%s%%"',[cityFldName, trim(cmbSubjectCity.Text)]);
      AddAndCriteria(criteriastr,curCriteria);
    end;
    if cmbSubjectState.Text <> '' then
    begin
      curCriteria := BuildEqualCriteria(stateFldName, trim(cmbSubjectState.Text));
      AddAndCriteria(criteriastr,curCriteria);
    end;
    if cmbSubjectZip.Text <> '' then
    begin
//Pam: Ticket #1231: For zip we need to do a like to handle both zip code and plus4 zip
//so if we just put in the first 5, should return all address with first 5 and plus4
//if we put in both first 5 and plus 4 zip, it will return exact match
///     curCriteria := BuildEqualCriteria(zipFldName, cmbSubjectZip.Text);
      curCriteria := BuildLikeCriteria(zipFldName, cmbSubjectZip.Text);
      if length(cmbSubjectCity.Text) = 0 then  //only include if there's no city
        AddAndCriteria(criteriastr,curCriteria);
    end;
    if edtUnitNum.Text <> '' then
      begin //Ticket #1315: need to include unit # for auto load comp
        CurCriteria := BuildLikeCriteria(UnitNoFldName, edtUnitNum.Text);
        AddAndCriteria(criteriastr, curCriteria);
      end;
  result := criteriastr;
end;


function TCompsDBList2.GetSearchCriteria: String;
var
  criteriaStr, curCriteria,curSubCriteria: string;
begin
  criteriaStr := '';
  //design/appeal field
  curCriteria := '';

    criteriaStr := GetSearchCriteriaOnTopSection;
    curCriteria := '';  //clear current criteria
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
   //Street Number field
   curCriteria := '';
   curCriteria := BuildBeginingFromCriteria(streetNoFldName,edtStreetNum.Text);
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
//      curSubCriteria := BuildEqualCriteria(ZipFldName,cmbZip.Text);
   curSubCriteria := BuildLikeCriteria(ZipFldName,cmbZip.Text);
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
//  curCriteria := BuildDateRangeCriteria(SaleDateDBNames[1],rzDateEdtSalesMin.Date,rzDateEdtSalesMax.Date);
//  AddAndCriteria(criteriaStr,curCriteria);
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


function GetMaxCount(maxCountStr:String): Integer;
var
  aCnt: Integer;
begin
  result := MAX_ROWS;
  if (maxCountStr = '') or (CompareText(maxCountStr, 'ALL')=0) then //show all
    result := MAX_ROWS
  else
  begin
    if tryStrToInt(maxCountStr, aCnt) then
      result := aCnt;
  end;
end;


procedure TCompsDBList2.EnableMenuOptions;
begin
  DatabaseMenu.Enabled := True;
  ComparableMenu.Enabled := True;
  PhotosMenu.Enabled := True;
  View1.Enabled := True;
  MaintMenu.Enabled := True;
end;


function TCompsDBList2.ValidateSubjectAddress:Boolean;
var
  noStreet, noCity, noState, noZip: Boolean;
begin
  result := True;

  //subject can be blank but cannot be in-complete
  //If user put in just street name w/o city, state, zip, give warning

  noStreet := length(edtSubjectAddr.Text) = 0;
  noCity := length(cmbSubjectCity.Text) = 0;
  noState := length(cmbSubjectState.Text) = 0;
  noZip := length(cmbSubjectZip.Text) = 0;

  if noStreet and noCity and noState and noZip then exit;  //this is valid

  if not noStreet then  //we have street
    begin
      if noCity and noState and noZip then
      begin
        result := False;
        ShowAlert(atStopAlert, 'Please enter City/State/Zip to complete the Subject Address.');
        if cmbSubjectCity.CanFocus then
          cmbSubjectCity.SetFocus;
      end;
    end;
end;



procedure TCompsDBList2.btnFindClick(Sender: TObject);
const
  MAX_RECORD = 250;
var
  sqlStr, criteriaStr: string;
  criteriaOK: Boolean;
  prop: AddrInfo;
  streetAddr, streetNum, streetName: String;
  maxRecord: Integer;
  aLevel: Integer;
begin
  aLevel := BingMaps.ZoomLevel;
  FNoMatch := False;
  try
    PushMouseCursor(crHourglass);
    try
    FFind := True;
    EnableMenuOptions;
    //Reset the subject lat/lon for each find
//    ListDMMgr.FSubjectLat := 0;
//    ListDMMgr.FSubjectLon := 0;

    if not ValidateSubjectAddress then exit;

    if Length(edtSubjectAddr.Text) > 0 then
      begin
        //if user enter a different address other than the one from the report, use it as the subject
        StreetAddr := edtSubjectAddr.Text;
        streetNum := popStr(StreetAddr, #32);
        streetName := StreetAddr;
        if (compareText(streetNum, prop.StreetNum) <> 0) or
           (compareText(streetName, prop.StreetName) <> 0) or
           (compareText(cmbSubjectCity.Text, prop.City) <> 0) or
           (compareText(cmbSubjectState.Text, prop.State) <> 0) or
           (compareText(cmbSubjectZip.Text, prop.Zip) <> 0) then
        begin
          prop.StreetNum := streetNum;
          prop.StreetName := StreetName;
          prop.City := cmbSubjectCity.Text;
          prop.State := cmbSubjectState.Text;
          prop.Zip := cmbSubjectZip.Text;
          prop.UnitNo := edtUnitNum.Text;
//          if (GetValidInteger(prop.Lat) = 0) and (GetValidInteger(prop.Lon)=0) then
//            GetGEOCode(prop); //Ticket #1255: only do this for the subject and only when session key is not empty
          if (length(prop.lat) <> 0) and (length(prop.lon)<>0) then
          begin
            ListDMMgr.FSubjectLat := StrToFloat(prop.lat);
            ListDMMgr.FSubjectLon := StrToFloat(prop.Lon);
          end;
        end;
      end;


    ListDMMgr.FShowCount := 0;    //reset the row count
    ListDMMgr.FMaxCount := GetMaxCount(edtComps.Text);
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
        //need to include when there's no sales date
        sqlStr := sqlStr + criteriaStr;
        sqlStr := sqlStr + ' order by SalesDate Desc,ModifiedDate Desc';

        with ListDMMgr do
        begin
          dxDBGrid.DataSource := nil;
          try
            CompClientDataSet.Active := False;
            CompClientDataSet.Filtered := True;   //Turn on filtering
            CompQuery.Active := False;
            CompQuery.SQL.Text := sqlStr;
            //For TESTING
    //ShowNotice('CompQuery.SQL.Text := '+sqlStr);
            CompQuery.Active := True;
            CompQuery.First;

            //Use TClientDataSet to show
            CompDataSetProvider.DataSet := CompQuery;   //use compquery as the data set provider
            CompClientDataSet.ProviderName := 'CompDataSetProvider';  //use Client Data set to store the CompQuery data
            CompDataSource.DataSet := CompClientDataSet;  //the comp data source is now pointing to comp client data set
            CompClientDataSet.Active := True;
            maxRecord := CompClientDataSet.RecordCount;
            if maxRecord > MAX_RECORD then
              begin
                if not OK2Continue(Format('This search will return %d Properties. Click NO to return to the Search Page and refine your search criteria. Click YES to view your results.',[MaxRecord])) then
                begin
                  FAbortProcess := True;
                  CompDataSource.DataSet := nil;
                  btnNew.Enabled := False;
                end;
              end;
            if not FAbortProcess then
              begin
                btnNew.Enabled := True;
                CompClientDataSet.First;
                Statusbar.Panels[0].Text := Format('Total: %d',[CompClientDataSet.RecordCount]);
                if FSubjectLat = StrToFloat(ERROR_LAT) then
                  Statusbar.Panels[3].text := Format('[ERROR] Subject Lat = %10.10f Lon = %10.10f',[FSubjectLat,FSubjectLon])
                else
                  Statusbar.Panels[3].text := Format('Subject Lat = %10.10f Lon = %10.10f',[FSubjectLat,FSubjectLon]);
              end;
          finally
            dxDBGrid.DataSource := CompDataSource;
            if CompClientDataSet.RecordCount > 0 then
              SetEditMode(True);
//            tabDetail.Visible := CompClientDataSet.RecordCount > 0;
          end;
        end;

        except on E:Exception do
          begin
           // ShowAlert(atWarnAlert, errCompsConnection);
            ShowAlert(atWarnAlert, e.message);
            exit;
          end;
        end;
        if not FAbortProcess then
        begin
          if (ListDMMgr.CompClientDataSet.RecordCount > 0) then
          begin
            ListDMMgr.CompClientDataSet.First;
            if FNew then
            begin
              FNew := False;  //reset the flag;
              PageControl.ActivePage := tabDetail;
            end
            else
            begin
              tabList.Visible := True;
              PageControl.ActivePage := tabList;    //show the results
            end;
//            BingMaps.RefreshMap;
AddAllMapPoints;
BingMaps.ZoomLevel := aLevel + 1;  //Ticket #1032: zoom in
          end
          else
            begin
              if not FAutoDetectComp then  //silent the message if it's from auto detect
                ShowNotice('No matching comparables were found.');
              FNoMatch := True;
              exit;
            end;
          end;
        end;
    finally
      PopMouseCursor;
      bingMaps.ZoomLevel := aLevel;  //ticket 1032: zoom back: to make the map refresh so we can have the click event work.
      if FAbortProcess then
        FAbortProcess := False;

    dxDBGrid.DataSource.DataSet.EnableControls;
    //Move to the top
    if ListDMMgr.CompClientDataSet.RecordCount > 0 then  //ticket #1120: donot move on if no record
      begin
       dxDBGrid.DataSource.DataSet.First;
       dxDBGrid.DataSource.DataSet.Next;
       dxDBGridClick(Sender);
      end;
    end;
  except ; end;
end;



procedure TCompsDBList2.AddProximityRadius;
var
  lat,lon: Double;
  radiusCircle: TGAgisCircle;
begin
try
  Lat := ListDMMgr.FSubjectLat;
  Lon := ListDMMgr.FSubjectLon;

  if (Lat<>0) and (lon<>0) then
  begin //only draw big radius if we have subject
    //Radius for proximity distance
    radiusCircle := BingMaps.AddCircle;
    radiusCircle.Name          := 'ProxRadius';
    radiusCircle.Latitude      := Lat;
    radiusCircle.Longitude     := Lon;
    radiusCircle.Radius        := ConvertMiles2Kilometers(appPref_SubjectProximityRadius);
    radiusCircle.Vertices      := 36;
    radiusCircle.StrokeWeight  := 2;
    radiusCircle.StrokeColor   := clNavy;
    radiusCircle.StrokeOpacity := 1;
    radiusCircle.Visible       := TRUE;
  end;
  //Radius for 1 mile
  radiusCircle := BingMaps.AddCircle;
  radiusCircle.Name          := 'Radius2';
  radiusCircle.Latitude      := Lat;
  radiusCircle.Longitude     := Lon;
  radiusCircle.Radius        := ConvertMiles2Kilometers(1.0);
  radiusCircle.Vertices      := 36;
  radiusCircle.StrokeWeight  := 1;
  radiusCircle.StrokeColor   := clBlack;
  radiusCircle.StrokeOpacity := 1;
  radiusCircle.Visible       := TRUE;

  //Radius for 0.5 mile
  radiusCircle := BingMaps.AddCircle;
  radiusCircle.Name          := 'Radius3';
  radiusCircle.Latitude      := Lat;
  radiusCircle.Longitude     := Lon;
  radiusCircle.Radius        := ConvertMiles2Kilometers(0.5);
  radiusCircle.Vertices      := 36;
  radiusCircle.StrokeWeight  := 1;
  radiusCircle.StrokeColor   := clBlack;
  radiusCircle.StrokeOpacity := 1;
  radiusCircle.Visible       := TRUE;
except
end;
end;


procedure TCompsDBList2.AddAllMapPoints(hilite:boolean = False; RowNo:Integer=-1);
var
  aRowNo: Integer;
  aName,msg: String;
  lat,lon: Double;
  cCircle: TGAgisCircle;
  max,cnt: Integer;
  startTime, endTime: String;
begin
  if FAbortProcess then exit;
  BingMaps.ClearCircles;             //Clear all existing circles before adding new ones
  BingMaps.ClearMarkers;             //Clear all existing markers before adding new ones
    max := dxDBGrid.Count;
    cnt := 0;
    try
      if edtProximity.Value > 0  then
         msg := Format('Refreshing All Comparables within %s miles radius...',[edtProximity.Text])
      else
         msg := 'Refreshing All Comparables ...';

      Application.ProcessMessages;
      ProgressBar := TCCProgress.Create(self, False, 0, max, 1, msg);
        try
          ListDMMgr.CompClientDataSet.DisableControls;
          startTime := FormatDateTime('hh:mm:ss', now);
          ListDMMgr.CompClientDataSet.First;
          while not ListDMMgr.CompClientDataSet.EOF do
            begin
             try
               Application.ProcessMessages;
                //if escape key is hit, exit the loop
                if FAbortProcess or ((GetKeyState(VK_Escape) AND 128) = 128) then
                  begin
                    if not OK2Continue('Would you like to stop adding Map Points?') then
                      FAbortProcess := False  //reset the flag
                    else
                    begin
                      FAbortProcess := False;
                      Break;    //stop where we are, post up to here
                    end;
                 end;
               ProgressBar.IncrementProgress;
               aRowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').asInteger;
               if aRowNo <= 0 then
                aRowNo := 1;
               aName := Format('%d',[aRowNo]);
               tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName('Latitude').asString, lat);
               tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName('Longitude').asString, lon);

                Application.ProcessMessages;
                cCircle := BingMaps.AddCircle;
                if assigned(cCircle) then
                  begin
                    cCircle.ID            := aName;
                    cCircle.Name          := aName;
                    cCircle.Latitude      := Lat;
                    cCircle.Longitude     := Lon;
                    //this will work well with zoom level
                    if BingMaps.ZoomLevel <> defaultZoomLevel then
                      cCircle.Radius := GetRadiusByZoomLevel(BingMaps.ZoomLevel)
                    else
                      cCircle.Radius        := CompRadius;         //0.04;
                    cCircle.Vertices      := 8;
                    cCircle.StrokeWeight  := 1;
                    cCircle.StrokeColor   := clBlack;
                    cCircle.FillColor     := clYellow;
                    if hilite and (aRowNo = RowNo) then
                      cCircle.FillColor := clAqua;

                    cCircle.StrokeOpacity := 1;
                    cCircle.FillOpacity   := 1;
                    cCircle.Visible       := TRUE;
                end;
             except on E:Exception do
                begin
                  ShowMessage(Format('AddCircleToMap error on RowNo= %s error: %s',
                             [aName, e.Message]));
                end;
              end;
              ListDMMgr.CompClientDataSet.Next;
            end;
            finally
              ListDMMgr.CompClientDataSet.EnableControls;
              EndTime := FormatDateTime('hh:mm:ss',now);
              StatusBar.Panels[3].Text := Format('Start: %s End: %s',[StartTime, EndTime]);
              StatusBar.Panels[4].Text := '';
            end;
           //Show subject
           Application.ProcessMessages;
           AddSubjectCircleAndMarker;
           AddProximityRadius;
    finally
     if assigned(ProgressBar) then
      ProgressBar.Free;
    end;
end;

procedure TCompsDBList2.AddSubjectCircleAndMarker;
var
  aName:String;
  lat,lon: Double;
  cCircle: TGAgisCircle;
  aMarker: TGAgisMarker;
begin
  if FAbortProcess then exit; 
  if (ListDMMgr.FSubjectLat = 0) or (ListDMMgr.FSubjectLon = 0) then exit;
//  aName := 'Subject';
  aName := 'S';
  Lat := ListDMMgr.FSubjectLat;
  Lon := ListDMMgr.FSubjectLon;
  //create the circle for the subject
  cCircle := BingMaps.AddCircle;
  cCircle.Name := aName;
  cCircle.Latitude      := Lat;
  cCircle.Longitude     := Lon;
  BingMaps.CenterLatitude := lat;
  BingMaps.CenterLongitude := lon;

  if BingMaps.ZoomLevel <> defaultZoomLevel then
    cCircle.Radius := GetRadiusByZoomLevel(BingMaps.ZoomLevel)
  else
    cCircle.Radius      := SubjectRadius;

  cCircle.Vertices      := 8;
  cCircle.StrokeWeight  := 1;
  cCircle.StrokeColor   := clBlack;
  cCircle.FillColor     := SubjectColor;
  cCircle.StrokeOpacity := 1;
  cCircle.FillOpacity   := 1;
  cCircle.Visible := True;


  //create the marker for the subject
  aMarker := BingMaps.AddMarker;
  aMarker.Name          := 'S';
  aMarker.Id            := 'S';
  aMarker.Latitude      := lat;
  aMarker.Longitude     := lon;
  aMarker.Draggable     := False;
  aMarker.InfoHTML      := '';
  aMarker.MoreInfoURL   := '';
  aMarker.PhotoURL      := '';
  aMarker.MinZoom       := 0;
  aMarker.MaxZoom       := 20;
  aMarker.LabelSize     := 2;
  aMarker.Visible       := True;
  aMarker.Label_        := 'S'
end;


procedure TCompsDBList2.btnPrintClick(Sender: TObject);
begin
  PrintRecords;
end;

procedure TCompsDBList2.btnExportClick(Sender: TObject);
begin
  ExportRecords;
end;

procedure TCompsDBList2.ClearSearchCriteria(tag: Integer);
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
    begin
      edtStreetNum.Text := '';
      edtStreet.Text := '';
    end;
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
      edtSalesDateNow.Text   := '';
      edtSalesDatePrior.Text   := '';
      edtMonth.Text := '';
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
  tagAddress:
    begin
      edtSubjectAddr.Text := '';
      cmbSubjectCity.Text := '';
      cmbSubjectState.Text := '';
      cmbSubjectZip.Text := '';
    end;
  end;
end;

procedure TCompsDBList2.ExportRecords;
begin
 //check if there are records then...

 SaveDialog.Title := 'Export Comp Records';
 SaveDialog.FileName := 'Comps';
 if rdoExportText.checked then
    ExportToFile
  else
    ExportToExcell;
end;

procedure TCompsDBList2.PrintRecords;
begin
  dxComponentPrinter1Link1.OnlySelected := ckbSelectedOnly.Checked;
  dxComponentPrinter1.Preview(True,nil);
end;

procedure TCompsDBList2.ExportToExcell;
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

procedure TCompsDBList2.ExportToFile;
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

procedure TCompsDBList2.btnClearAllClick(Sender: TObject);
var
  tag: Integer;
begin
  for tag := 1 to nSearchFields  do
    ClearSearchCriteria(tag);
end;



//make this a command, combine with Find button
procedure TCompsDBList2.ListFindAllMItemClick(Sender: TObject);
begin
//  FindAll;
end;

procedure TCompsDBList2.ListFindMItemClick(Sender: TObject);
begin
  PageControl.ActivePage := tabSearch;
end;

procedure TCompsDBList2.FillOutLookupCombo(sqlStr: String; cmb: TComboBox);
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

procedure TCompsDBList2.OnbtnClearFldClick(Sender: TObject);
begin
  ClearSearchCriteria(TButton(Sender).Tag);
end;

procedure TCompsDBList2.OnRefresBtnClick(Sender: TObject);
begin
  btnClearAll.Click;  //the criteria may be not in lookup values any more
  LoadDistinctSearchCriteria;
end;

procedure TCompsDBList2.DeleteSelectedRecords;
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
      ListDMMgr.CompClientDataSet.Refresh;  //refresh client data set
      // delete photo records
      for selRec := 0 to nSelectedRecs - 1 do
        RemovePhotos(StrToInt(compsIDs[selRec]),True);
      OnRecChanged;
      SetEditMode(False);
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList2.OnRecordsMenuClick(Sender: TObject);
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

procedure TCompsDBList2.rzDateEdtSalesMinDropDown(Sender: TObject);
begin
//  if length(rzDateEdtSalesMin.Text) = 0 then
//    rzDateEdtSalesMin.Date := IncDay(Today, -180);   //start search 6 mos before today
end;

procedure TCompsDBList2.ImportAllCompsMenuClick(Sender: TObject);
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
      PageControl.ActivePage := tabDetail;        //detailed view
      finally
        PopMouseCursor;
        ProgressBar.Free;
      end;
    end;
end;

procedure TCompsDBList2.ImportAllListingsMenuClick(Sender: TObject);
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
              ImportComparable(col, tcListing);
        OnRecChanged;
        PageControl.ActivePage := tabDetail;        //detailed view
      finally
        PopMouseCursor;
        ProgressBar.Free;
      end;
    end;
end;

function TCompsDBList2.GetDateOFSalesCellText(isUAD: boolean): String;
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
  with ListDMMgr.CompClientDataSet do
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

function  TCompsDBList2.SubjectInDB: Boolean;
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

function  TCompsDBList2.CompsInDB(CompID, compType:Integer): Boolean;
var
  CompCol: TCompColumn;
  StreetAddress,cityStZip: String;
  prop: AddrInfo;
begin
  if (CompType = gtSales) and (FDocCompTable.Count > 0) then
    CompCol := FDocCompTable.Comp[CompID]
  else if (CompType = gtListing) and (FDocListTable.Count > 0) then
    CompCol := FDocListTable.Comp[CompID];

  if not assigned(CompCol) then exit;
  StreetAddress := CompCol.GetCellTextByID(925);
  prop.StreetNum := ParseStreetAddress(StreetAddress, 1, 0);
  prop.StreetName := ParseStreetAddress(StreetAddress, 2, 0);
  cityStZip := trim(CompCol.GetCellTextByID(926));
  GetUnitCityStateZip(prop.UnitNo, prop.City, prop.State, prop.Zip, CityStZip);
  result := FindRecord(prop) > 0;
end;

procedure TCompsDBList2.btnNewClick(Sender: TObject);
begin
  ClickNewRecord(sender);
end;

{
procedure TCompsDBList2.ProcessGeoCode(var geoCode: TGeoCoder);
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
           ListDMMgr.CompClientDataSet.Refresh;  //do the same for client data set
         end;
     end;
end;


procedure TCompsDBList2.RunProcessTimerTimer(Sender: TObject);
var
  Lat, Lon: Double;
begin
  if BingMaps.SessionKey <> '' then
    begin
      RunProcessTimer.Enabled := False;

      BingMaps.ZoomLevel := DefaultZoomLevel;
      BingGeoCoder.APIKey := BingMaps.SessionKey;  //Ticket 1052: Use session key
//for debug only
//      statusbar.Panels[0].Text := BingMaps.APIKey;
//      Statusbar.Panels[4].Text := BingGeoCoder.APIKey;

  if not FFind then
      LocatePropertyAddress
  else
    begin
      ListDMMgr.CompClientDataSet.DisableControls;
      try
        Application.ProcessMessages;
        //add map points to load from the grid to the map
        if ((ListDMMgr.FSubjectLat<>0) and (ListDMMgr.FSubjectLon<>0)) then
        begin
          BingMaps.CenterLatitude := ListDMMGr.FSubjectLat;
          BingMaps.CenterLongitude := ListDMMgr.FSubjectLon;
          AddAllMapPoints;
        end
        else //if no subject, use the first one to center
        begin
          with ListDMMgr.CompClientDataSet do
          begin
            tryStrToFloat(FieldByName(latFldName).AsString, lat);
            tryStrToFloat(FieldByName(lonFldName).AsString, lon);
            if (lat <> 0)  and (lon <> 0) then
              begin
                BingMaps.CenterLatitude := lat;
                BingMaps.CenterLongitude := lon;
                AddAllMapPoints;
              end;
          end;
        end;
      finally
        ListDMMgr.CompClientDataSet.EnableControls;
      end;
    end;

    end;
(*
   if appPref_DBGeoCoded then exit; //make sure we only run when it's not set
   try
     if GeoCodeThread=nil then
       begin
         try
           GeoCodeThread := TGeoCodeThread.Create(True);
           GeoCodeThread.Priority := tpIdle;
           GeoCodeThread.Resume;
         except ;
         end;
       end;
   finally
     RunProcessTimer.Enabled := False;
   end;
*)
end;

procedure TCompsDBList2.RunGeoCodeInBackground;
begin
(*
   if not appPref_DBGeoCoded then
    RunProcessTimer.Enabled := True;
*)
end;
}

procedure TCompsDBList2.edtCompsExit(Sender: TObject);
begin
  ListDMMgr.FMaxCount := GetMaxCount(edtComps.Text);
  appPref_MaxCompsShow := edtComps.Text;
end;

procedure TCompsDBList2.tabSearchShow(Sender: TObject);
begin
  PushMouseCursor(crHourglass);
  try
//    GetSubjectLatLon;
    LoadDistinctSearchCriteria;
    if (edtSalesDateNow.Text = '') and (edtSalesDatePrior.Text = '') then
      ClearSearchCriteria(tagSalesDate);

    if edtSubjectAddr.CanFocus then
      edtSubjectAddr.SetFocus;
  finally
    PopMouseCursor;
  end;
end;

procedure TCompsDBList2.edtSubjectAddrChange(Sender: TObject);
begin
  FSubjectAddrChanged := True;
end;

procedure TCompsDBList2.edtProximityExit(Sender: TObject);
begin
   appPref_SubjectProximityRadius := edtProximity.Value;
end;

procedure TCompsDBList2.BingMapsMapShow(Sender: TObject);
var
  lat,lon: Double;
  aleft: Integer;  //ticket #1255
begin
  if FAbortProcess then exit;
  aLeft := Splitter1.Left;   //save the current position
  BingMaps.ZoomLevel := DefaultZoomLevel;

//  RunProcessTimer.Enabled := True;
(*
// github #920: donot do this in mapshow, will get error.  Need to set up a timer to delay 3 seconds then set lat/lon
  BingMaps.ZoomLevel := DefaultZoomLevel;
  BingGeoCoder.APIKey := BingMaps.SessionKey;  //Ticket 1052: Use session key
  if not FFind then
      LocatePropertyAddress
  else
*)    begin
      ListDMMgr.CompClientDataSet.DisableControls;
      try
        Application.ProcessMessages;
        //add map points to load from the grid to the map
        if ((ListDMMgr.FSubjectLat<>0) and (ListDMMgr.FSubjectLon<>0)) then
        begin
          BingMaps.CenterLatitude := ListDMMGr.FSubjectLat;
          BingMaps.CenterLongitude := ListDMMgr.FSubjectLon;
//          AddAllMapPoints;
        end
        else //if no subject, use the first one to center
        begin
          with ListDMMgr.CompClientDataSet do
          begin
            tryStrToFloat(FieldByName(latFldName).AsString, lat);
            tryStrToFloat(FieldByName(lonFldName).AsString, lon);
            BingMaps.CenterLatitude := lat;
            BingMaps.CenterLongitude := lon;
//            AddAllMapPoints;
          end;
        end;
      finally
        AddSubjectCircleAndMarker;
        AddProximityRadius;
        ListDMMgr.CompClientDataSet.EnableControls;
        Splitter1.left := Splitter1.left + 1;   //Ticket #1255: try to move
        Splitter1.Left := aLeft;                //put it back.  this will make the map expand to full
      end;
    end;
end;


procedure TCompsDBList2.AddMarker(aMarkerName:String; lat,lon:Double);
var
  aMarker: TGagisMarker;
begin
  aMarker := BingMaps.AddMarker;
  aMarker.Name          := aMarkername;
  aMarker.Id            := aMarkerName;
  aMarker.Latitude      := lat;
  aMarker.Longitude     := lon;
  aMarker.Draggable     := False;
  aMarker.InfoHTML      := '';
  aMarker.MoreInfoURL   := '';
  aMarker.PhotoURL      := '';
  aMarker.MinZoom       := 0;
  aMarker.MaxZoom       := 20;
  aMarker.LabelSize     := 2;
  aMarker.Visible       := True;
  aMarker.Label_        := aMarkerName;
end;

procedure TCompsDBList2.HighlightSelectedRow(RowNo:Integer; Lat,Lon: Double);
var
  markerName: String;
  cCircle: TGagisCircle;
begin
  if RowNo <= 0 then RowNo := 1;
  SetCompColor(RowNo);
  BingMaps.ClearMarkers;
  AddMarker('S', ListDMMgr.FSubjectLat, ListDMMgr.FSubjectLon); //add subject marker
  MarkerName := Format('%d',[RowNo]);
  AddMarker(MarkerName, Lat, Lon); //add selected comp marker

  cCircle := BingMaps.GetCircle(RowNo);
  if assigned(cCircle) then
    cCircle.FillColor := clAqua;
  ShowCompStatus;
  BingMaps.PanTo(Lat, Lon);
end;


procedure TCompsDBList2.dxDBGridClick(Sender: TObject);
var
  RowNo:Integer;
  lat,lon: Double;
begin
  //Pick up the current comp # and lat/lon
  RowNo := dxDBGrid.DataSource.DataSet.FieldByName('RowNo').AsInteger;
  if RowNo = 0 then
    RowNo :=dxDBGrid.DataSource.DataSet.RecNo;
  with ListDMMgr.CompClientDataSet do begin
    tryStrToFloat(FieldByName(LatFldName).AsString, lat);
    tryStrToFloat(FieldByName(LonFldName).AsString, lon);
    try
      DisableControls;
      HighlightSelectedRow(RowNo,Lat,Lon);
    finally
      EnableControls;
    end;
  end;
end;

procedure TCompsDBList2.ShowCompStatus;
var
  lat,lon: Double;
begin
  StatusBar.Panels[1].Text := Format('Comp : %d',[ListDMMgr.CompClientDataSet.FieldByName(compIDFldName).asInteger]);
  tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName('Latitude').AsString, lat);
  tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName('Longitude').AsString, lon);
  StatusBar.Panels[2].Text := Format('Lat = %10.10f  Lon = %10.10f',[Lat,Lon]);
  if (ListDMMgr.FSubjectLat<>0) and (ListDMMGr.FSubjectLon<>0) then
    StatusBar.Panels[3].Text := Format('Subject: Lat = %10.10f  Lon = %10.10f',[ListDMMGr.FSubjectLat, ListDMMGr.FSubjectLon]);
  StatusBar.Refresh;
end;


procedure TCompsDBList2.SetCompColor(RowNo:Integer);
var
  i, idx, cRowNo: Integer;
  cCircle: TGagisCircle;
  cMarker: TGagisMarker;
begin
  idx := RowNo - 1;
  for i:= 0 to BingMaps.Markers.Count - 1 do
  begin
    cMarker := BingMaps.Markers[i];
    if cMarker.Id <> 'S' then
    begin
      cRowNo := StrToIntDef(cMarker.Id,0);
      if cRowNo > 0 then
        cCircle := TGagisCircle(BingMaps.Circles.Items[cRowNo-1]);
      if assigned(cCircle) then
        cCircle.FillColor := clYellow;  //reset back to yellow
    end;
  end;

  //now highlight the select circle color
  if idx >= 0 then
    cCircle := TGagisCircle(BingMaps.Circles.Items[idx]);
  if assigned(cCircle) then
    cCircle.FillColor := clAqua;
end;


procedure TCompsDBList2.BingMapsMapZoomEnd(Sender: TObject; iOldLevel,
  iNewLevel: Integer);
var aMsg: String;
    i: Integer;
    aRadius: Double;
    aName: String;
    cCircle: TGagisCircle;
    aColor: TColor;
    StartTime, EndTime: String;
begin
  PushMouseCursor(crHourglass);
  try
    StartTime := FormatDateTime('hh:mm:ss',now);
    aRadius := GetRadiusByZoomLevel(iNewLevel);
    //Go through all the map points to readjust the radius based on the zoom level
    for i:= 0 to Bingmaps.Circles.count - 1 do
    begin
      aName := TGagisCircle(Bingmaps.circles.Items[i]).Name;
      aColor := TGagisCircle(Bingmaps.circles.Items[i]).FillColor;
      //Ignore the Radius (0.5, 1, and user define radius proximity)
      if pos('RADIUS', uppercase(aName)) > 0 then
        continue
      else
        cCircle := TGagisCircle(Bingmaps.circles.items[i]);
      cCirCle.Radius := aRadius;
  //    cCirCle.FillColor := aColor;
      amsg:=format('Zoom Level = %d circle.radius = %f',[iNewLevel,TGagisCircle(Bingmaps.circles.items[i]).Radius]);
      Statusbar.Panels[3].Text := aMsg;
      StatusBar.Panels[4].Text := '';
    end;
  finally
    PopMouseCursor;
    EndTime := FormatDateTime('hh:mm:ss',now);
    Statusbar.Panels[4].Text := Format(' Start: %s, End: %s',[StartTime, EndTime]);
  end;
end;


procedure TCompsDBList2.InvertSelection(var Grid: TdxDBGrid);
  procedure InvertChildren(ANode: TdxTreeListNode);
  var
    I: Integer;
  begin
    for I := 0 to ANode.Count - 1 do
    begin
      ANode[I].Selected := False;
      if ANode[I].Count > 0 then
        InvertChildren(ANode[I]);
    end;
  end;

var
  I: Integer;
begin
  with Grid do
  begin
    // requires LoadAllRecords mode
    BeginUpdate;
    for I := 0 to Count - 1 do
    begin
      Items[I].Selected := False;
      if Items[I].Count > 0 then
        InvertChildren(Items[I]); // Inverts children
    end;
    EndUpdate;
  end;
end;


procedure TCompsDBList2.dxDBGridRowNoCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if AText='' then
    aText := '1'
end;

procedure TCompsDBList2.dxDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  RowNo: Integer;
  Lat,Lon: Double;
begin
  case key of
    VK_NEXT: //Page down
      begin
        ListDMMgr.CompClientDataSet.MoveBy(+40); //go forward 40
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
        ListDMMgr.CompClientDataSet.MoveBy(-1);
      end;
    VK_PRIOR:  //Page up
      begin
        ListDMMgr.CompClientDataSet.MoveBy(-40); //go back 40
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
        ListDMMgr.CompClientDataSet.MoveBy(1);
      end;

    VK_UP: //key up
      begin
        ListDMMgr.CompClientDataSet.MoveBy(-1); //go to previous record by one
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
        ListDMMgr.CompClientDataSet.MoveBy(1);
      end;
    VK_DOWN: //key down
      begin
        ListDMMgr.CompClientDataSet.MoveBy(1);
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
        ListDMMgr.CompClientDataSet.MoveBy(-1);
      end;
    VK_HOME: //Home key go to beginning
      begin
        ListDMMgr.CompClientDataSet.First;

        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
      end;
    VK_END: //End key go to the end
      begin
        ListDMMgr.CompClientDataSet.Last;
        //### Hack, when we hit END key and try to catch the rowno in the cursor it was always 0
        // so what we did was to move by one to capture the row then move forward one
        ListDMMgr.CompClientDataSet.MoveBy(-1);
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        RowNo := RowNo + 1;
        ListDMMgr.CompClientDataSet.MoveBy(1);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
        tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
        HighlightSelectedRow(RowNo, Lat, Lon);
      end;
    VK_ESCAPE:
        begin
           FAbortProcess := True;
           StatusBar.Panels[4].Text := 'ESC key is hit';
           StatusBar.Refresh;
        end;
  end;
end;

(*
procedure TCompsDBList2.LocatePropertyAddress;
var
  geoInfo : TGAgisGeoInfo;
  geoStatus : TGAgisGeoStatus;
  sQueryAddress: String;
begin
  sQueryAddress := edtSubjectAddr.text + ' ' + cmbSubjectCity.text + ', ' + cmbSubjectState.text + ' ' + cmbSubjectZip.text;
  geoStatus := BingGeoCoder.GetGeoInfoFromAddress(sQueryAddress, geoInfo, nil);
  if geoStatus = gsSuccess then
    ShowSubject(geoInfo);
end;
*)
(*
procedure TCompsDBList2.ShowSubject(geoInfo : TGAgisGeoInfo);
var
  aMarker: TGagisMarker;
begin
  Statusbar.Panels[3].text := Format('Subject Lat = %10.10f Lon = %10.10f',[geoInfo.dLatitude,geoInfo.dLongitude]);
  //zoom to the subject
  BingMaps.Center(geoInfo.dLatitude, geoInfo.dLongitude);
  BingMaps.ZoomLevel := defaultZoomLevel;

  //mark the subject property
  aMarker := BingMaps.AddMarker;

  aMarker.BeginUpdate;
  try
    aMarker.Name := 'Subject';
    aMarker.Latitude := geoInfo.dLatitude;
    aMarker.Longitude := geoInfo.dLongitude;
    aMarker.Draggable := True;
    aMarker.Label_ := 'S';
    aMarker.ImageURL := '';
    aMarker.InfoHTML := '';
    aMarker.MoreInfoURL := '';
    aMarker.PhotoURL := '';
    aMarker.Type_ := mtDefault;
    aMarker.MinZoom := 0;
    aMarker.MaxZoom := 20;
    aMarker.Visible := True;
  finally
    aMarker.EndUpdate;
  end;
end;

*)

procedure TCompsDBList2.tabListShow(Sender: TObject);
var
 Column: TdxDBTreeListColumn;
 i: Integer;
begin
  try
    dxDBGrid.DataSource.DataSet.DisableControls;
    for i:= 0 to dxDBGrid.ColumnCount-1 do
    begin
      column := dxDBGrid.Columns[i];
      if column.FieldName = 'RowNo' then
      begin
        column.Sorted := csUp;
        break;
      end;
    end;
  finally
    dxDBGrid.DataSource.DataSet.EnableControls;
    //Move to the top
    dxDBGrid.DataSource.DataSet.First;
    dxDBGridClick(Sender);
  end;

end;

procedure TCompsDBList2.dxDBGridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ASelected then
    aColor := clNavy;
end;

procedure TCompsDBList2.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
var
  RowNo: Integer;
  lat, lon: Double;
  prop: AddrInfo;
  EffectiveDate: String;
begin
   if TNavigateBtn(Button) = nbInsert then
   begin
     FNew := True;
     EffectiveDate := '';
     //Use effective date or current date for sales date from
     if Assigned(FDoc) then
       EffectiveDate := TContainer(FDoc).GetCellTextByID(1132); //Effective date
     NewRecord(0, 0,prop, EffectiveDate);  //saving
     SetEditMode(True);
   end
   else if TNavigateBtn(Button) = nbLast then
   begin
      ListDMMgr.CompClientDataSet.MoveBy(-1);
      RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
      RowNo := RowNo + 1;
      ListDMMgr.CompClientDataSet.MoveBy(1);
   end
   else
     RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;

  tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(latFldName).AsString, Lat);
  tryStrToFloat(ListDMMgr.CompClientDataSet.FieldByName(lonFldName).AsString, Lon);
  HighlightSelectedRow(RowNo, Lat, Lon);
  OnRecChanged;
end;

procedure TCompsDBList2.edtSalesDateNowExit(Sender: TObject);
var
  pMonth: Integer;
  EffDateDateTime: TDateTime;
  year,month,day, dow: word;
//  EffDateStr: String;
begin
    tryStrToInt(edtMonth.Text, pMonth);
    pMonth := -(pMonth);

    EffDateDateTime := edtSalesDateNow.Date;
    if EffDateDateTime > 0 then
    begin
      if edtMonth.Text = '' then
         edtMonth.Value := 6;
      tryStrToInt(edtMonth.Text, pMonth);
      pMonth := -(pMonth);
      //Use effective date/current date - 6 months for SalesDateTo
      DecodeDateFully(EffDateDateTime, year, month, day, dow);
      IncAMonth(Year, Month, Day, pMonth);   //go back n months from effective date

      if TryEncodeDate(Year, Month, Day, EffDateDateTime) then
        edtSalesDatePrior.Date := EffDateDateTime;
    end
    else
      begin
        ClearSearchCriteria(tagSalesDate);
      end;
end;

procedure TCompsDBList2.edtMonthExit(Sender: TObject);
var
  pMonth: Integer;
  EffDateDateTime: TDateTime;
  year,month,day, dow: word;
begin
  //if we have effetive date, use it else use current date
  if edtSalesDateNow.Text <> '' then
  begin
    EffDateDateTime := edtSalesDateNow.Date;
    //Use effective date/current date - 6 months for SalesDateTo
    DecodeDateFully(EffDateDateTime, year, month, day, dow);
    tryStrToInt(edtMonth.Text, pMonth);
    pMonth := -(pMonth);
    IncAMonth(Year, Month, Day, pMonth);   //go back n months from effective date

    if TryEncodeDate(Year, Month, Day, EffDateDateTime) then
      edtSalesDatePrior.Date := EffDateDateTime;
  end
  else if edtSalesDatePrior.Date > 0 then
  begin
     EffDateDateTime := edtSalesDatePrior.Date;
     tryStrToInt(edtMonth.Text, pMonth);
     //Use effective date/current date - 6 months for SalesDateTo
     DecodeDateFully(EffDateDateTime, year, month, day, dow);
     IncAMonth(Year, Month, Day, pMonth);   //go back n months from effective date

     if TryEncodeDate(Year, Month, Day, EffDateDateTime) then
       edtSalesDateNow.Text := FormatDateTime('mm/yyyy',EffDateDateTime);
  end;
end;



procedure TCompsDBList2.edtSalesDatePriorExit(Sender: TObject);
var
  pMonth: Integer;
  EffDateDateTime: TDateTime;
  year,month,day, dow: word;
begin
    tryStrToInt(edtMonth.Text, pMonth);
    EffDateDateTime := edtSalesDatePrior.Date;
    if EffDateDateTime > 0 then
    begin
      //Use effective date/current date + 6 months for SalesDateTo
      DecodeDateFully(EffDateDateTime, year, month, day, dow);
      IncAMonth(Year, Month, Day, pMonth);   //go back n months from effective date

      if TryEncodeDate(Year, Month, Day, EffDateDateTime) then
        edtSalesDateNow.Text := FormatDateTime('mm/yyyy',EffDateDateTime);
    end
    else
    begin
      ClearSearchCriteria(tagSalesDate);
    end;
end;

//**************************************//
//    Import From Report to Database    //
//                                      //
//**************************************//

procedure TCompsDBList2.DoFileSearch(const PathName, FileName : string);
var Rec  : TSearchRec;
    Path : string;
    aFileMask,aFileName: String;
begin
  Path := IncludeTrailingBackslash(PathName);
  if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
    begin
      try
       repeat
         if assigned(ProgressBar) then
           ProgressBar.IncrementProgress;
         aFileName := Rec.Name;
         aFileMask := copy(aFileName, 1, 4);

         if CompareText(aFileMask,'tmp_') <> 0 then
           chkListBox.Items.Add(Path + Rec.Name);
       until FindNext(Rec) <> 0;
     finally
       FindClose(Rec);
     end;
     if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
     try
       repeat
         if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then
          DoFileSearch(Path + Rec.Name, FileName);
       until FindNext(Rec) <> 0;
     finally
       FindClose(Rec);
     end;
  end
  else
  begin
     if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
     try
       repeat
         if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then
          DoFileSearch(Path + Rec.Name, FileName);
       until FindNext(Rec) <> 0;
     finally
       FindClose(Rec);
     end;
  end;
end; //procedure FileSearch


procedure TCompsDBList2.GetReportFiles;
var
  i: Integer;
begin
  if chkListBox.Items.Count > 0 then exit;
  if edtImportFolder.text <> '' then
    begin
      appPref_ImportFolder := edtImportFolder.Text;
      chkListBox.Items.Clear;
      chkListBox.Items.BeginUpdate;
      badListBox.Items.Clear;
      try
      ProgressBar := TCCProgress.Create(self, False, 0, 2, 1, 'Please wait! Searching ClickFORMS report files ...');
      DoFileSearch(edtImportFolder.Text, '*.clk');
      finally
        for i:= 0 to chkListBox.Count -1 do
          chkListBox.Checked[i] := True;
        chkListBox.Items.EndUpdate;
        ProgressBar.Free;
        //clean up log box
        Logs.Lines.Clear;
        BadListBox.Items.Clear;
      end;
      btnImport.Enabled := chkListBox.Count > 0;
//      btnStop.Enabled := btnImport.Enabled;
      StatusBar.Panels[0].Text := Format('Total: %d found.',[chkListBox.Count]);
    end;
end;

procedure TCompsDBList2.btnBrowseClick(Sender: TObject);
var
  StartFolder: String;
begin
  if FOnStartUp then
    SelectFolderDialog.SelectedPathName := appPref_DirReports;
//    SelectFolderDialog.BaseFolder.PathName := appPref_DirReports;
  FOnStartUp := False;  //reset the flag  
  StartFolder := SelectSearchStartFolder;
  edtImportFolder.Text := StartFolder;
  btnImport.Enabled := edtImportFolder.Text <>'';
//  btnStop.Enabled := btnImport.Enabled;
  chkListBox.Items.Clear;
  GetReportFiles;
end;

function TCompsDBList2.SelectSearchStartFolder: String;
begin
  result := '';
  SelectFolderDialog.Title := 'Select Folder to Start Importing...';
  if SelectFolderDialog.Execute then
    result := SelectFolderDialog.SelectedPathName;
end;

function TCompsDBList2.GetReportTypeSelection: String;
begin
  if chkIncludeAllRptTypes.Checked then
    result := 'ALL'
  else
  begin
    result := '';
    if chkImport1004.Checked then
      result := 'URAR';
    if chkImport2055.Checked then
      result := result + ',' + '2055';
    if chkImport1073.Checked then
      result := result + ',' + 'Condo';
    if chkImport1075.Checked then
      result := result + ',' + 'CondoExt';
    if chkImportLand.Checked then
      result := result + ','+'Land';
    if chkImportMobileHm.Checked then
      result := result + ','+'MobileHm';
  end;
end;


procedure TCompsDBList2.btnImportClick(Sender: TObject);
var
  fName: String;
  f, totCount: Integer;
  ImportStatus, logFolder, logFile: String;
  importOK:Boolean;
  doc: TContainer;
  rptType: String;
begin
  try
    StatusBar.Panels[2].Text := 'Hit ESC key to Stop Importing.';
    FAbortProcess := False;
    FFileCount := 0;
    FAddedRecs := 0;
    FUpdatedRecs := 0;
    FIgnoredRecs := 0;
    FNoDocKeys := 0;
    StatusBar.Panels[0].Text := '';
    totCount := 0;

    //Collect import report type check box to rptRec
    rptType := GetReportTypeSelection;
    if rptType = '' then
    begin
      ShowNotice('You need select at least one report type to import.');
      if chkIncludeAllRptTypes.CanFocus then
        chkIncludeAllRptTypes.SetFocus;
      Exit;
    end;

    for f:= 0 to chkListBox.Count -1 do
      if chkListBox.Checked[f] then
        inc(totCount);

    if totCount = 0 then
    begin
      ShowNotice('Please select reports to import.');
      Exit;
    end;
    ProgressBar := TCCProgress.Create(self, True, 0, totCount, 1, 'Importing Reports to Comps...');
    ProgressBar.IncrementProgress;
    try
      badListBox.Items.Clear;
      for f := 0 to chkListBox.Count - 1 do
        begin
          Application.ProcessMessages;
          if FAbortProcess or ((GetKeyState(VK_Escape) AND 128) = 128) then
            begin
              if not OK2Continue('Would you like to stop Importing?') then
                FAbortProcess := False  //reset the flag
              else
              begin
                FAbortProcess := False;
                break;    //stop where we are, post up to here
              end;
            end;
          if chkListBox.Checked[f] then
            begin
              chkListBox.Selected[f] := True;

              fName := chkListBox.Items[f];
              ImportStatus := Format('Processing report: %s %d of %d',[fName, f, totCount]);
              doc := TContainer(Main.ActiveContainer);
              ProgressBar.Caption := 'Importing: '+fName;
              try
                importOK := ImportReportToComps(ProgressBar, doc, fName,chkImportSubject.Checked,
                                              chkImportSales.Checked, chkImportListings.Checked, chkImportRentals.Checked, rptType, logs.Lines);

              except on E:Exception do
                importOK := False;
              end;

              if importOK then
              begin
                ProgressBar.IncrementProgress;
                //reset the check box
                chkListBox.checked[f] := False;
                inc(FAddedRecs);
              end
              else
              begin
                badListBox.Items.Add(chkListBox.Items[f]);
                chkListBox.checked[f] := False;
                inc(FIgnoredRecs);
              end;
            end;
        end;
    finally
      ProgressBar.Free;
      if FIgnoredRecs > 0 then
        ImportStatus := Format('Totals: %d   Imports: %d   Skips: %d',[totCount, FAddedRecs,FIgnoredRecs])
      else
        ImportStatus := Format('Totals: %d   Imports: %d',[totCount, FAddedRecs]);
      StatusBar.Panels[0].Text := ImportStatus;
      logs.Lines.Add('');
      logs.Lines.Add(ImportStatus);

      logFolder := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log';
      ForceDirectories(logFolder);
      logFile := logFolder+'\ImportLog.txt';
      logs.Lines.SaveToFile(logFile);

      logFolder := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log';
      logFile := logFolder+'\ImportLogError.txt';
      badListBox.Items.SaveToFile(logFile);
      StatusBar.Panels[4].Text := '';
    end;
  except on e: Exception do
    ShowAlert(atWarnAlert, 'There was problem importing report data to the Comps Database. '+E.message);
  end;
end;

procedure TCompsDBList2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
        begin
           FAbortProcess := True;
           StatusBar.Panels[4].Text := 'ESC key is hit';
           StatusBar.Refresh;
        end;
  end;

end;

procedure TCompsDBList2.edtImportFolderExit(Sender: TObject);
begin
  if edtImportFolder.Text <> '' then
  begin
    chkListBox.Items.Clear;
    GetReportFiles;
  end;
end;

procedure TCompsDBList2.ImpPopupPopup(Sender: TObject);
var
  logFile: String;
begin
  logFile := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log\ImportLogError.txt';
  ViewLog.Enabled := FileExists(logFile);
  ClearReports.Enabled := (chkListBox.Items.Count > 0) or (badListBox.Items.Count > 0);
end;

procedure TCompsDBList2.ViewLogClick(Sender: TObject);
var
  logFile: String;
begin
  logFile := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log\ImportLogError.txt';
  logs.Lines.LoadFromFile(logFile);
end;

procedure TCompsDBList2.PrintLogClick(Sender: TObject);
begin
  if printDialog.execute then
    logs.print('Import Log');
end;

procedure TCompsDBList2.tabImportShow(Sender: TObject);
begin
  if btnBrowse.CanFocus then
    btnBrowse.SetFocus;
end;




procedure TCompsDBList2.ClearReportsClick(Sender: TObject);
begin
  chkListBox.Items.Clear;
  badListBox.Items.Clear;
end;

procedure TCompsDBList2.btnLoadClick(Sender: TObject);
begin
  chkListBox.Items.Clear;
  badListBox.Items.Clear;
  GetReportFiles;
end;

procedure TCompsDBList2.ViewLog1Click(Sender: TObject);
var
  logFile: String;
begin
  logFile := IncludeTrailingPathDelimiter(appPref_DirDatabases)+'\Log\ImportLog.txt';
  logs.Lines.LoadFromFile(logFile);
end;

procedure TCompsDBList2.chkCreateNewClick(Sender: TObject);
begin
  appPref_ImportUpdate := not chkCreateNew.Checked;
  chkUpdateExisting.Checked := not chkCreateNew.Checked;
end;

procedure TCompsDBList2.chkUpdateExistingClick(Sender: TObject);
begin
  appPref_ImportUpdate := chkUpdateExisting.Checked;
  chkCreateNew.Checked := not chkUpdateExisting.Checked;
end;


procedure TCompsDBList2.ResetImpReportType(AllChecked:Boolean);
begin
  if AllChecked then
  begin
    chkImport1004.checked     := True;
    chkImport2055.Checked     := True;
    chkImport1073.Checked     := True;
    chkImport1075.Checked     := True;
    chkImportLand.Checked     := True;
    chkImportMobileHm.Checked := True;
  end;
end;

procedure TCompsDBList2.chkIncludeAllRptTypesClick(Sender: TObject);
begin
  ResetImpReportType(chkIncludeAllRptTypes.Checked);
end;

procedure TCompsDBList2.ResetIncludeAllReportTypes(Sender: TObject);
begin
  if Sender is TCheckBox then
    if not TCheckBox(Sender).Checked then
    begin
      chkIncludeAllRptTypes.Checked := False;
      chkIncludeAllRptTypes.Refresh;
    end;
end;


procedure TCompsDBList2.FormResize(Sender: TObject);
begin
  SearchPanel.Height := ScrollBox1.Height + 5;
  SearchPanel.Width := ScrollBox1.Width + 5;
end;

procedure TCompsDBList2.dxDBGridDblClick(Sender: TObject);
var
  RowNo: Integer;
  lat, lon: Double;
begin
  //Pick up the current comp # and lat/lon
  RowNo := dxDBGrid.DataSource.DataSet.FieldByName('RowNo').AsInteger;
  if RowNo = 0 then
    RowNo :=dxDBGrid.DataSource.DataSet.RecNo;
  with ListDMMgr.CompClientDataSet do begin
    tryStrToFloat(FieldByName(LatFldName).AsString, lat);
    tryStrToFloat(FieldByName(LonFldName).AsString, lon);
    try
      DisableControls;
      HighlightSelectedRow(RowNo,Lat,Lon);
      OnRecChanged;
      PageControl.ActivePage := tabDetail;        //detailed view
    finally
      EnableControls;
    end;
  end;

end;

procedure TCompsDBList2.RecordImportMItemClick(Sender: TObject);
begin
  FImportoption := 1;
end;

procedure TCompsDBList2.TLCustomizeClick(Sender: TObject);
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
procedure TCompsDBList2.BingMapsOverlayMouseClick(Sender: TObject;
  eOverlayType: TGAgisOverlayType; iOverlayIndex: Integer);
var
  cOverlayBase: TGAgisBingOverlayBase;
  RowNo: Integer;
  MouseGeoPt,CompGeoPt: TGeoPoint;
  lat, lon: Double;
  startTime, endTime: String;
begin
  cOverlayBase := BingMaps.GetOverlayFromOverlayTypeAndIndex(eOverlayType,iOverlayIndex);
  if cOverlaybase <> nil then

  ListDMMgr.CompClientDataSet.First;
  dxDBGrid.DataSource.DataSet.DisableControls;
  startTime := FormatDateTime('hh:mm:ss', now);
  InvertSelection(dxDBGrid);

  try
    while not ListDMMgr.CompClientDataSet.Eof do
      begin

        MouseGeoPt.Latitude   :=  cOverlayBase.Latitude;
        MouseGeoPt.Longitude  :=  cOverlayBase.Longitude;
        //use the circle to get the index
        TryStrToFloat(ListDMMgr.CompClientDataSet.FieldByname(LatFldName).AsString, Lat);
        TryStrToFloat(ListDMMgr.CompClientDataSet.FieldByname(LonFldName).AsString, Lon);
        CompGeoPt.Latitude    := Lat;
        CompGeoPt.Longitude   := Lon;
        RowNo := ListDMMgr.CompClientDataSet.FieldByName('RowNo').AsInteger;
        if RowNo <=0 then RowNo := 1;
        //found it
        if PtInCircle(MouseGeoPt, CompGeoPt, 0.05) then  //we found it
          begin
            HighlightSelectedRow(RowNo,Lat,Lon);
            dxDBGrid.FocusedNode.Selected := True;
            if PageControl.ActivePage = tabDetail then
              OnRecChanged;
            break;
          end;
         ListDMMgr.CompClientDataSet.Next;
      end;
  finally
    dxDBGrid.DataSource.DataSet.EnableControls;
    endTime := FormatDateTime('hh:mm:ss', now);
  end;
end;


procedure TCompsDBList2.Timer1Timer(Sender: TObject);
var
  prop: AddrInfo;
begin
  if BingMaps.SessionKey <> '' then
    begin
      if (ListDMMgr.FSubjectLat = 0) and (ListDMMgr.FSubjectLon=0) then
        begin
           GetGEOCode(prop); //Ticket #1255: only do this for the subject and only when session key is not empty
           ListDMMgr.FSubjectLon := StrToFloat(prop.Lon);
           ListDMMgr.FSubjectLat := StrToFloat(prop.lat);
           AddSubjectCircleAndMarker;
           AddProximityRadius;
           ListDMMgr.FSubjectLon := 0; //we need to reset it here for the filtering works 
           ListDMMgr.FSubjectLat := 0;
        end;
      Timer1.Enabled := False;
    end;
end;

end.