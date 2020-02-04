unit UContainer;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }

{ This is the main conatiner class for holding and displaying }
{ forms in the Clickforms application. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ComCtrls, ExtCtrls, Printers, Math, Menus, StdCtrls,contnrs,ActiveX, MSXML6_TLB,
	UGlobals, UBase, UCell, UPage, UForm, UEditor, UPgView, UDocView, UStdCmtsList,
  UDocProperty, USignatures, UProgress, ToolWin, ImgList, WPPDFPRP, WPPDFR1,
  WPPDFR2, UDocDataMgr, UCellAutoAdjust, UCellMunger, UPgAnnotation,UDragUtils,
  UWordProcessor, UVersion, UForms, UClasses, UMapPortalManager, UListCellXPath,
  ULicUser, UMessages, uMapPortalManagerSL,UGridMgr,
  UCC_Progress, UPaths;

const
  cMaxSigners = 4;

type
  TFileFormat = (ffClickFORMS6, ffClickFORMS7);

{ TContainer }

// -- This is the window that contains all the data to the forms and holds the reference
// -- to the forms that are actually owned by the ActiveFormsMgr.
// Ver 6.9.9 JWyatt: Added Ctrl+Del as an acceleration key combination to the
//  FMPopDelMItem to allow keyboard usage to delete a form from the container.
	TContainer = class(TAppraisalReport)
		docSaveDialog: TSaveDialog;
		docOpenDialog: TOpenDialog;
    docSplitter: TSplitter;
    CmdButtons: TImageList;
    LeftBasePanel: TPanel;
    PageMgr: TListBox;
    GoToListToolBar: TToolBar;
    tbtnForms: TToolButton;
    tbtnUp: TToolButton;
    tbtnDown: TToolButton;
    tbtnDelete: TToolButton;
    WPPDFPrinter: TWPPDFPrinter;
    WPPDFProperties: TWPPDFProperties;
    docStatus: TStatusBar;
    FMPopDeleteMItem: TMenuItem;
    FormManagerPopup : TPopupMenu;
    FMPopCopyFormNameMItem: TMenuItem;
    FMPopMoveUpMItem: TMenuItem;
    FMPopMoveDownMItem: TMenuItem;
    FMPopMoveToBottomMItem: TMenuItem;
    FMPopMoveToTopMItem: TMenuItem;
    FMPopDuplicateMItem: TMenuItem;
    PageNavigatorUpdateTimer: TTimer;
		procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
		procedure DragOverDoc(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); virtual;
		procedure DragDropOnDoc(Sender, Source: TObject; X, Y: Integer); virtual;
		procedure DragFromDoc(Sender: TObject; var DragObject: TDragObject); virtual;
    procedure docSplitterMoved(Sender: TObject);
    procedure DeleteFormClick(Sender: TObject); virtual;
    procedure MoveFormsUpDownClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PageMgrDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PageMgrDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormManagerPopupPopup(Sender : TObject);
    procedure FMPopupExecuteClick(Sender : TObject);
    procedure PageMgrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageMgrMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PageMgrStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure PageMgrDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PageNavigatorUpdateTimerTimer(Sender: TObject);
  private
    FIDragDrop: TDropTarget;
    FReadOnly: Boolean;
    FDocUID: Int64;                   //Unique identifier for this file.
		FDocAutoRspOn: Boolean;           //is auto display responses on
    FZoomScale: Integer;              //holds user defined scaling, max window uses different scale
    FAutoSaving: Boolean;             //flag to let app know when an auto save is being performed
    FRepGlobalList: TObjectList;      //lists of replicated local cells, prevents endless loops
    FRepLocalList: TObjectList;       //lists of replicated global cells, prevents endless loops
    FRepMathList:TObjectList;         //(not implemented!) lists of math processed cells, prevents endless loops
    FMarkupEditor: TEditor;           //Holds the Markup Layer editor
    FActiveLayer: Integer;            //0=Reg; 1=Annotation Active; 2=Tablet Inking
    FActiveTool: Integer;             //1=Select; 2=Text; 3=Label;
    FMunger: TCellMunger;
    FRecorded: Boolean;               //has the container been recorded in a reports database
    FProcessListCount: Integer;       //number of instances of the transfer and math process lists
    FDocHasBookMarks: Boolean;        //has doc added the bookmark menus, cause activae/deactive may not sync
    FFreezeCanvasCounter : Integer;
		procedure SetAutoRsp(Value: Boolean);
    procedure SetDocUID(Value: Int64);
    procedure SetZoomScale(Value: Integer);
    function GetAutoPgNumbers: Boolean;
    procedure SetAutoPgNumbers(const Value: Boolean);
    function GetDisplayPgNums: Boolean;
    procedure SetDisplayPgNums(const Value: Boolean);
    function GetManualStartPg: Integer;
    function GetManualTotalPg: Integer;
    procedure SetManualStartPg(const Value: Integer);
    procedure SetManualTotalPg(const Value: Integer);
    procedure SetActiveLayer(const value: Integer);
    procedure SetActiveLayerMenus(const value: Integer);
    procedure SetActiveTool(const value: Integer);
    procedure SetActiveToolMenus(const value: Integer);
    procedure SetActiveEditor(value: TEditor);
    function GetActiveEditor: TEditor;
    function GetFreezeCanvas : Boolean;
    procedure SetFreezeCanvas(Value : Boolean);
    procedure WindowScrolled(Sender: TObject; Pos: SmallInt; EventType: TVScrollEventType);

  protected
    function GetLocked: Boolean; override;
    procedure SetDataModified(Value: Boolean); virtual;
    procedure DocumentNotificationProc(var Message: TWMDocumentNotification); message WM_DOCUMENT_NOTIFICATION;
    procedure MoveToCell(var Message: TCLKCellMove); message CLK_CELLMOVE;
    procedure ConfigurationChanged;
    procedure SynchronizeFormsManager;

  // data
  private
    FCellXPathList: TCellXPathList;
    FFileFormat: TFileFormat;
    FModificationTime: TDateTime;
    FOnBuildEditorPopupMenu: TBuildPopupMenuEvent;
    FOnCellEnter: TNotifyEvent;
    FOnCellExit: TNotifyEvent;
    FTextOverflowed: Boolean;
    FShowCommentsForm: TShowCmts;
    FMapPortalManager: TMapPortalManager;
    FMapPortalManagerSL: TMapPortalManagerSL;
    FUADEnabled: Boolean;              //flag for this doc is UAD is on/off
    FRunSiliently: Boolean;   //flag to disable pop up message
  public
    docHasBeenReviewed: Boolean;       //the reviewer has run on active document
		docView: TDocView;                //this is where forms are viewed
		docIsNew: Boolean;
		docDataChged: Boolean;           	//The data somewhere in the container has changed (bubblesup to here)
		docPrefChged: Boolean;            //The preferences/fomatting has changed somewhere in container
		docRspsChged: Boolean;            //the std responses have changed some where

    docOrderAckNeeded: Boolean;        //special for RELS, written for any AMC, sets flag to require Ack of Order
    docOrderAcked: Boolean;           //special for RELS, need to know if order has been acknowledged

		docFileName: String;              //just the name and ext of the file (if there is one)
		docFilePath: String;              //the path to the file (no file name)
		docFullPath: String;              //the path and file name.
		docAutoSave: TTimer;							//auto save timer for this doc.

		docFont: TFont;
    docProgress: TProgress;           //Progress bar for this doc, normally nil;

    {docStatus: LongInt;              //evantually put Booleans above in here}
		docPref: LongInt;              		//31 preference flags that are used in this doc.
    docColors: TColorRec;             //colors used in this document (its a rec not an obj)
 	 {docEditor: TEditor;								//converted to Property so we can editor per layer}
    docStartingCellUID: CellUID;      //this is the cell where user starts when reopening the file
    docLastActCellUID: CellUID;       //is the previous active cell
		docActiveCell: TBaseCell;					//this is the active cell
		docActiveCellChged: Boolean;      //did this cell change during this edit session?
    docActiveItem: TMarkupItem;       //doc has Markup items like FreeText, Lines, Rects

		docLastPgBottom: Integer;         //view dimensions
		docMinWidth: Integer;
		docPageMgrWidth: Integer;
    docProperty: TDocProperty;        //file properties
		docTableOfContents: TStringList;  //list of pages
    docSignatures: TSignatureMgr;     //list of signatures

    docData: TDocDataList;              //generic data held by the container
    docCellAdjusters: TCellAdjustList;  //list of adjusters for automatically adjusting cells in grid
    docForm: TDocFormList;              //List of forms in this container

    UADOverflowCheck: Boolean;        //UAD flag to force overflow check regardless or prior overflow state
    WPDFprinting: Boolean;            //true while creating WPDF. We need to set the flug to properly handle EMF plus images from APEX 6

    FAMCOrderInfo: AMCOrderInfo;  //Ticket #: 1202 to save some important fields to the container for upload file purpose
  published
    SchemaVersion: TDocumentSchemaVersion;

  public
		constructor Create(AOwner: TComponent); override;
    constructor CreateMinimized(AOwner: TComponent);
		destructor Destroy; override;

  // methods
  private
    procedure CMGetDialogKey(var Message: TMessage); message CM_DIALOGKEY;
    function GetOnCellEnter: TNotifyEvent;
    procedure SetOnCellEnter(const Value: TNotifyEvent);
    function GetOnCellExit: TNotifyEvent;
    procedure SetOnCellExit(const Value: TNotifyEvent);
    function GetPageNavigator: TComponent;
    procedure UpdatePageNavigator;
    function GetUADEnabled: Boolean;
    procedure SetUADEnabled(const Value: Boolean);
    procedure HandleTextOverflow;
    procedure BuildEditorPopupMenu(const Sender: TEditor; const Menu: TPopupMenu);
    procedure SetGLAValues;
    procedure SetCellValue(acell:TBaseCell);

  protected
    procedure Activate; override;
    procedure Deactivate; override;
    procedure DoCellEnter; virtual;
    procedure DoCellExit; virtual;

  public
    procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); override;
    procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); override;
    procedure Initialize;
    procedure Invalidate; override;
    procedure SetFocus; override;
		procedure SetupContainer;
    procedure OnDocFormChanged(Sender: TObject);
    procedure UpdateToolbarButtons;
    procedure UpdateFormMgrButtons;

    //annotation stuff
    procedure MakeItemActive(Item: TMarkupItem);
    procedure Switch2NewItem(newItem: TMarkupItem; clicked: Boolean);
    procedure LoadActiveItemEditor(clicked: Boolean);
    procedure UnloadActiveItemEditor;

//		procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
//		procedure FormKeyDown(var Key: Word; Shift: TShiftState);
//    procedure xxFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function AddLiveForm(FormUID:TFormUID; liveForm:TDocForm; Expanded:Boolean; atIndex:Integer): TDocForm;	//add form from another doc
    procedure AddLiveWordProcessorPage(const FormUID: TFormUID; const LiveForm: TDocForm; const Expanded: Boolean; const InsertionIndex: Integer);
    procedure LinkWordProcessorPages(const ParentForm: TDocForm; const ChildForm: TDocForm);
    function PromptLinkWordProcessorPages(const ParentForm: TDocForm; const ChildForm: TDocForm): Boolean;
    function SimpleFormInsert(FormUID: TFormUID; Expanded: Boolean; Idx: Integer): TDocForm;  //inserts a form w/o processing
		function InsertBlankUID(FormUID: TFormUID; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True): TDocForm;    //inserts without populating form
		function InsertFormUID(FormUID: TFormUID; Expanded: Boolean; Idx: Integer): TDocForm;		  //inserts and populates forms
    function ReadAMCOrderInfoFromReport: AMCOrderInfo;
    procedure WriteAMCOrderInfoToReport(const FAMCOrder: AMCOrderInfo);
    function InsertFormDef(AFormDef: TFormDesc; Expanded: Boolean; Idx: Integer): TDocForm;    //inserts form def in DocForm list
    function InsertFormDef2(AFormDef: TFormDesc; Expanded: Boolean; Idx: Integer; bShowMessage: Boolean=True): TDocForm;
		function InsertForm(theForm: TFormDesc; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True): TDocForm;       //inserts the form, builds TC, renumbers pages
    function InsertForm2(theForm: TFormDesc; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True; bShowMessage:Boolean=True): TDocForm;

    procedure InsertDocForm(ADocForm: TDocForm; Index: Integer);
//  procedure ProcessNewForm(docForm: TDocForm);   //takes place of InsertForm eventually

		procedure InsertInPageMgrList(Page: TDocPage; Idx: Integer);
    function GetPageIndexInPageMgrList(Page: TDocPage): Integer;
    function GetPageByPageMgrIndex(Index: Integer): TDocPage;
		procedure BuildPageMgrList;
		procedure TogglePageMgrDisplay;
    function GetPageMgrDisplay: Boolean;
    procedure SetPageMgrDisplay(value: Boolean);
    procedure PageMgrShowSelectedPage;
    procedure RichardsCheckUI;
    function FormCount: Integer;
    procedure SelectForm(AnIndex : Integer);
    procedure SelectSheet(AnIndex : Integer);
    function FirstPageOfForm(AFormIndex : Integer) : Integer;

		procedure DeleteForm(FormIdx: Integer);
		procedure SwapForms(FormIdx1, FormIdx2: Integer);
    procedure MoveForm(fromIndex, toIndex: Integer);
		procedure ArrangeForms;
		procedure DeleteForms;
    //function  GetAreaSketchCell: TSketchCell;
    //function  GetSketchCell(mdSketchType: integer; var SkTyp: integer): TSketchCell;
    //procedure DeleteDocSketches;

		procedure BuildContentsTable;
    procedure DisplayPageCount;
    function  GetPageIndexInTableContents(Page: TDocPage): Integer;
		function  GetTableContentsDesc(Index: Integer):String;
		function  GetTableContentsPage(Index: Integer):String;
		function  GetPageMinWidth: Integer;

//		procedure SetupEditor(cell:TBaseCell);
		procedure DoIdleEvents;                             //this is the Blinking Bar timer

//Utility
    procedure SelectCellID(AnID : Integer = -1);
		function GetCell(CUID: CellUID): TBaseCell;

    //each cell is assigned a type ID, get frist one
    function GetCellByID(ID: Integer): TBaseCell; overload;
    function GetCellByID(ID: Integer; availableForm: BooleanArray): TBaseCell; overload; //same as GetCellByID above but form must be available
    function GetCellsByID(ID:Integer): cellUIDArray; //returns array of all doc cells with given cell ID
    function GetCellByXID(const XID: Integer): TBaseCell;
    function GetCellByXID_MISMO(ID: Integer; availableForm: BooleanArray): TBaseCell; //get XML ID
    function FindNextCellByID(AnID : Integer) : TBaseCell;
    function FindCellInstance(const Instance: TCellInstanceID): TBaseCell;

    function GetCellTextByID(ID: Integer): String; overload;
    function GetCellTextByID(ID: Integer; availableForm: BooleanArray): String; overload;
    function GetCellTextByXID_MISMO(ID: Integer; availableForm: BooleanArray): String;

    procedure SetCellTextByID(ID: Integer; Text: String);
    procedure SetCellTextByID2(ID: Integer; Text: String; isOverride:Boolean=True);  //Ticket #1202: set this up so we can decide to override the text or not default is override
    procedure SetCellTextByIDNP(ID: Integer; Text: String);  //Pam

    procedure SetCheckBoxByID(ID: Integer; Text: String);     //does not set when no text
    function GetCheckBoxValueByID(ID: Integer): Boolean;
    function GetCellValueByID(ID: Integer): Double;
    procedure SetCellValueByID(ID: Integer; Value: Double);
		function GetValidCell(CUID: CellUID; var cell: TBaseCell): Boolean;
    function GetValidInfoCell(CUID: CellUID; var cell: TObject): Boolean;
		function GetFormIndex(formID: Integer): Integer;         //find form with this UID
    function GetFormIndexByOccur2(formID, Occur, CID: Integer; AName: string): Integer;
    function GetFormCountIndexByOccur2(formID, CID: Integer; AName: string): Integer;
    function GetFormIndexByOccur(formID, Occur: Integer): Integer;
    function GetFormByOccurance(formID, Occur: Integer; AutoLoad: Boolean): TDocForm;
    function GetFormByOccuranceByIdx(formID, Occur, idx: Integer; AutoLoad: Boolean):TDocForm;
    function GetFormTypeByOccurance(fCatID, fKindID, Occur: Integer): TDocForm;
    function GetReportGeoCodes: string;

//Cell functions
    procedure LoadLicensedUser(forceCOName: Boolean);   //loads just license user info, no address
    procedure LoadSupervisorUser(User: TUser);          //loads the additional signer - usually supervisor
    procedure SetupUserProfile(forceCOName: Boolean);   //loads address, the Co and User name
		procedure SetupForInput(firstCell: Boolean);        //sets the editor to the first cell or last active one
    procedure SetupUADCompliance(AFormID: Integer; UADCompliance:Boolean=True);     //sets the UAD compliance flags based on Aform being loaded
    procedure CheckUADSettings(AsTemplate: Boolean=False);
		procedure ResetCurCellID;                           //resets the curCellUID incase forms were rearranged
		procedure RemoveCurCell;													  //when a form is removed, this nils out the editor
		procedure LoadActiveCellEditor(clicked: Boolean);
		procedure UnloadActiveCellEditor;

		function  GroupedCheckBoxes: Boolean;
		procedure Skip2NextGroupRow(Shifted: Boolean);
		procedure MoveToNextCell(Direction: Integer);

    procedure ScrollIntoView(Form: TDocForm);
		procedure ShowCurCell;
		procedure SaveCurCell;
    procedure GoToPrevActiveCell;
		Procedure MakeCurCell(cell: TBaseCell);           //make this the cur cell
		procedure ProcessCurCell(PostProcess: Boolean);
    function CanProcessLocal(Cell: TBaseCell): Boolean;
    function CanProcessGlobal(Cell: TbaseCell): Boolean;
    function CanProcessMath(Cell: TBaseCell): Boolean;
    function ReplicationInProgress: Boolean;
    procedure StartProcessLists;
    procedure ClearProcessLists;
    procedure DebugRepLists;

    procedure CommitEdits;
		procedure Switch2NewCell(newCell: TBaseCell; clicked: Boolean);

    procedure ProcessCommand(Sender: TObject; CX: CellUID; CmdID: Integer);

    procedure SetupCellMunger;
    procedure SetupCellMunger2;
    procedure LoadCellMunger(ContextID: Integer; Str: String);
    procedure SetMungedValue(ContextID: Integer; Str: String);
    procedure BroadcastMungedText(Sender: TObject; ContextID: Integer; AStr: String);
    function  FindContextData(ContextID: Integer; var Str: String): Boolean; overload;
    function  FindContextData(ContextID: Integer; out DataCell: TBaseCell): Boolean; overload;
    function FindMungedContextData(ContextID: Integer; var Str: String): Boolean;

		procedure BroadcastCellContext(ContextID: Integer; Str: String); overload;
		procedure BroadcastCellContext(ContextID: Integer; const Source: TBaseCell); overload;
//    procedure BroadcastCellContextOutsideForm(ContextID: Integer; Str: String; startCell: TBaseCell; startForm: TDocForm);
    procedure BroadcastPageContext(aPage: TDocPage; PostProcessFlag: Byte= 0);
		procedure BroadcastFormContext(AForm: TDocForm);
		procedure PopulateFormContext(AForm: TDocForm);
    procedure UpdateFormTables(AForm: TDocForm);
    procedure UpdateTableCells;

    procedure InstallBookmarkMenuItems;
    procedure RemoveBookmarkMenuItems;

    //Tool Functions
    procedure ReviewReport;
    procedure ShowPageNavigator;

    function  GetSignatureTypes: TStringList;
    procedure SetSignatureLock(Value: Boolean);
    procedure UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);    //update this kind of signature

    procedure SignDocWithLicFile(N: Integer);
    procedure SignDocWithRSA;

    function  DocNeedsReviewing: Boolean;
    //function  DocNeedsImageOptimization: Boolean;
    function ImagesToOptimize(prefDPI: Integer; formList: BooleanArray = nil): Integer; //instead of DocNeedsImageOptimization
    //function  DocHasLargeImages(var count: Integer): Boolean;

    function  DefaultFileName: String;
    function  DoSave(fileStream: TFileStream): Boolean;
		function  Save: Boolean;
		function  SaveAs(toDropBox: Boolean = false): Boolean; overload;
		function  SaveAs(const FileName: String): Boolean; overload;
    procedure DeleteValidationForms;
		function  SaveAsTemplate: Boolean;
    function  SaveProperties: Boolean;
    function  SaveFormatChanges: Boolean;
		procedure AutoSave(Sender: TObject);
		procedure ResetAutoSave;
		function  SaveContainer(stream: TStream): Boolean;
		function  LoadContainer(stream: TStream; Version: Integer): Boolean;
		function  LoadContainerForImport(stream: TFileStream; Version: Integer; bShowMessage: Boolean= True): Boolean;
    function  MergeContainer(stream: TFileStream; Populate, MergeAllForms: Boolean; Version: Integer): Boolean;
		procedure ImportFromFile(fileCmd: Integer);
    procedure ImportText(Const TextFilename: String; isUnSystFormat: Boolean = false);

    procedure ImportFromRedStone(Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false); //special for RedStone Data
    procedure ImportRedStoneChartData(Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false); //special for RedStone Data
    procedure ImportRedStoneMapData(MainFORMID:Integer; Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false); //special for RedStone Data

   	function  ExportToFile(fileName: String; exportMode: Integer): Boolean;
    procedure ExportToXSites;

		function ReadContainerSpec(Stream: TStream; var numForms: Integer): Boolean;
		function ReadContainerSpec2(Stream: TStream; var numForms: Integer; bShowMessage:Boolean=True): Boolean;
		function WriteContainerSpec(Stream: TStream): Boolean;
		function ReadFormSpec(Stream: TStream; nForm, Version: Integer): Boolean;
    function ReadFormSpec2(Stream: TStream; nForm, Version: Integer; bShowMessage:Boolean=True): Boolean;
//		function WriteFormSpec(Stream: TFileStream; nForm: Integer): Boolean;

    //this is for future data to be included in the doc
    //for now each just read/write one long equal to zero
    function ReadDocColors(Stream: TStream): Boolean;
    function ReadDocSignatures(Stream: TStream): Boolean;
    function ReadDocSignatures2(Stream: TStream; bShowMessage:Boolean=True): Boolean;
    function ReadDocDataItems(Stream: TStream): Boolean;
    function ReadDocCellAdjusters(Stream: TStream): Boolean;
    function ReadDocMungedText(Stream: TStream): Boolean;

    function ReadFutureData5(Stream: TStream): Boolean;
    function ReadFutureData6(Stream: TStream): Boolean;
    function ReadFutureData7(Stream: TStream): Boolean;
    function ReadFutureData8(Stream: TStream): Boolean;
    function ReadFutureData9(Stream: TStream): Boolean;
    function ReadFutureData10(Stream: TStream): Boolean;
    function ReadFutureData11(Stream: TStream): Boolean;
    function ReadFutureData12(Stream: TStream): Boolean;
    function ReadFutureData13(Stream: TStream): Boolean;
    function ReadFutureData14(Stream: TStream): Boolean;
    function ReadFutureData15(Stream: TStream): Boolean;
    function ReadFutureData16(Stream: TStream): Boolean;
    function ReadFutureData17(Stream: TStream): Boolean;
    function ReadFutureData18(Stream: TStream): Boolean;
    function ReadFutureData19(Stream: TStream): Boolean;
    function ReadFutureData20(Stream: TStream): Boolean;
    function ReadFutureData21(Stream: TStream): Boolean;
    function ReadFutureData22(Stream: TStream): Boolean;
    function ReadFutureData23(Stream: TStream): Boolean;
    function ReadFutureData24(Stream: TStream): Boolean;
    function ReadFutureData25(Stream: TStream): Boolean;
    function ReadFutureData26(Stream: TStream): Boolean;
    function ReadFutureData27(Stream: TStream): Boolean;
    function ReadFutureData28(Stream: TStream): Boolean;
    function ReadFutureData29(Stream: TStream): Boolean;
    function ReadFutureData30(Stream: TStream): Boolean;
    //function ReadFutureData31(Stream: TStream): Boolean;

    function WriteDocColors(Stream: TStream): Boolean;
    function WriteDocSignatures(Stream: TStream): Boolean;
    function WriteDocDataItems(Stream: TStream): Boolean;
    function WriteDocCellAdjusters(Stream: TStream): Boolean;
    function WriteDocMungedText(Stream: TStream): Boolean;

    function WriteFutureData5(Stream: TStream): Boolean;
    function WriteFutureData6(Stream: TStream): Boolean;
    function WriteFutureData7(Stream: TStream): Boolean;
    function WriteFutureData8(Stream: TStream): Boolean;
    function WriteFutureData9(Stream: TStream): Boolean;
    function WriteFutureData10(Stream: TStream): Boolean;
    function WriteFutureData11(Stream: TStream): Boolean;
    function WriteFutureData12(Stream: TStream): Boolean;
    function WriteFutureData13(Stream: TStream): Boolean;
    function WriteFutureData14(Stream: TStream): Boolean;
    function WriteFutureData15(Stream: TStream): Boolean;
    function WriteFutureData16(Stream: TStream): Boolean;
    function WriteFutureData17(Stream: TStream): Boolean;
    function WriteFutureData18(Stream: TStream): Boolean;
    function WriteFutureData19(Stream: TStream): Boolean;
    function WriteFutureData20(Stream: TStream): Boolean;
    function WriteFutureData21(Stream: TStream): Boolean;
    function WriteFutureData22(Stream: TStream): Boolean;
    function WriteFutureData23(Stream: TStream): Boolean;
    function WriteFutureData24(Stream: TStream): Boolean;
    function WriteFutureData25(Stream: TStream): Boolean;
    function WriteFutureData26(Stream: TStream): Boolean;
    function WriteFutureData27(Stream: TStream): Boolean;
    function WriteFutureData28(Stream: TStream): Boolean;
    function WriteFutureData29(Stream: TStream): Boolean;
    function WriteFutureData30(Stream: TStream): Boolean;
    //function WriteFutureData31(Stream: TStream): Boolean;

//process commands from actions and menus
		procedure SetupCellJustMenu(JustM, LeftM, CntrM, RightM: TMenuItem);
		procedure SetupCellStyleMenu(StyleM, BoldM, ItalicM, UnderLine: TMenuItem); //<Add Under Line May/05/2010 was miss in 7.2.1 >//
		procedure SetupCellFontSizMenu(FSizM, smallerM, curSizM, largerM: TMenuItem);
		procedure SetupCellEditRspMenu(EditRspMenu: TMenuItem);
		procedure SetupCellShowRspMenu(ShowRspMenu: TMenuItem);
		procedure SetupCellSaveRspMenu(SaveRspMenu: TMenuItem);
		procedure SetViewPageListMenu(FmMgrMenu: TMenuItem);
		procedure ShowCellResponses;
		procedure EditCellResponses;
		procedure SaveCellResponses;
		procedure SetCellPreferences;
    procedure SaveCellImageToFile;
		procedure SetAllCellsTextSize(value: Integer);
    procedure SetAllCellsFontStyle(fStyle: TFontStyles);
    procedure SetGlobalCellFormating(doIt: Boolean);
		procedure EditFontSize(FontSiz: Integer);

    function GetDocPref(Index: Integer): Boolean;
    procedure SetDocPref(Index: Integer; Value: Boolean);

    function GetPenColor(isPrinting: Boolean): TColor;
    function GetInfoCellColor(isPrinting: Boolean): TColor;
    function GetFormFontColor(isPrinting: Boolean): TColor;
    function GetDataFontColor(isPrinting: Boolean): TColor;
    function GetMarkupFontColor(isPrinting: Boolean): TColor;
    function GetBrushColor(isPrinting: Boolean): TColor;

    procedure PasteRedstoneForms; //# spcial paste Redstone data.
    function CanPaste: Boolean;                       //paste files into doc or docEditor
		procedure FileCmdHandler(FileCmd: Integer);       //menu and cmd handlers
		procedure EditCmdHandler(EditCmd: Integer);
		Procedure ViewCmdHandler(ViewCmd: Integer);
		procedure GoToCmdHandler(sender: TObject);
    procedure FormCmdHandler(FormCmd: Integer);
		Procedure CellCmdHandler(CellCmd: Integer);
		Procedure DebugCmdHandler(DebugCmd: Integer);

    Procedure MarkupCmdHandler(MarkupCmd: Integer; IsActive: Boolean);
    procedure SelectMarkupTool(MarkupTool: Integer; IsActive: Boolean);

		procedure SetDisplayScale;
		procedure SetDisplayNormal;
		procedure SetDisplayFit2Screen;

    procedure ThesaurusLookUpWord;
    function  CanSpellCheck(JustWord: Boolean): Boolean;      //for setting menus
		procedure SpellCheck(section: Integer);                   //main speller routine
    procedure DoSpellCheckWord;
    procedure DoSpellCheckPage;
    procedure DoSpellCheckReport;
    function AllowCellSpellCheck(Cell: TBaseCell): Boolean;   //don't check some cells

    procedure LoadUserLogo;

		procedure FindAndReplace;
    function  DoFindNReplace(var curCUID: cellUID; var SIndex: Integer;
        FStr, RStr: String; MatchWord: Boolean; Direction: Integer; findFirst: Boolean): Integer;

		Procedure PrintReport;
    procedure DoWinPrint(CollateCopies: Integer; PgSpec: Array of PagePrintSpecRec);
    procedure DoPrintReport(PrIndex: Integer; PgSpec: Array of PagePrintSpecRec);
    function  DoCreateWPDF(PgSpec: Array of PagePrintSpecRec): String;
    function  DoCreateWPDF_2(PgList: BooleanArray): String;
    function  CreateReportPDF(Options: Integer): String;
    function  CreateReportPDFEx(fName: String; showPDF, showPref, encryptPDF: Boolean; PgList: BooleanArray): String;

//Misc Unitities
    function IsWordProcessCell: Boolean; ///< Add by Jeferson May/5/2010. New Font Menu for WPCells >\\\
    function CanLinkComments: Boolean;
    procedure LinkComments(Sender: TObject);
		Procedure MakePtVisible(Pt: TPoint);
		Procedure SetModifiedFlag;
    procedure ClearDocSketches;
    function GetDocSketchType(var cell: TBaseCell): Integer;

    procedure DisplayProgressBar(const Title: String; MaxValue: Integer);
    procedure SetProgressBarNote(Const Note: String);
    procedure IncrementProgressBar;
    procedure RemoveProgressBar;
    function ClearGeoCode:Boolean;


// for debugging
    procedure DebugShowCellAttribute(Value: Integer);
    procedure DebugSetCellIDs;
    procedure DebugSetRspIDs;
		procedure ClearDocText;

// For CompsDB
    function ValidateCompsWithUADConsistency(var NotMatchSubject, NotInDBSubject, NotMatchComps, NotInDBComps, NotMatchListings, NotInDBListings:String):Boolean;
    procedure HandleCompsDBPostProcess;
    function IsCompGridDataChanged:Boolean; //GH #750

    //procedure OptimizeAllImages(ResetOptimized:Boolean=False);     not used any more
    function OptimizeReportImages(optDPI: Integer; formList: BooleanArray = nil): Integer;
    function GetFormIndexByFormID(aFormID: Integer):Integer;

    procedure SetActiveCell;

    property CellXPathList: TCellXPathList read FCellXPathList;
    property DataModified: Boolean read docDataChged write SetDataModified;
    property FormatModified: Boolean read docPrefChged write docPrefChged;
    property ResponsesModified: Boolean read docRspsChged write docRspsChged;
		property docAutoRspOn: Boolean read FDocAutoRspOn write SetAutoRsp;
    property docUID: Int64 read FDocUID write SetDocUID;
    property ZoomFactor: Integer read FZoomScale write SetZoomScale;
    property OnlyRead: Boolean read FReadOnly write FReadOnly;
    property DisplayPageMgr: Boolean read GetPageMgrDisplay write SetPageMgrDisplay;
    property Recorded: Boolean read FRecorded write FRecorded;
    property ActiveLayer: Integer read FActiveLayer write SetActiveLayer;
    property ActiveTool: Integer read FActiveTool write SetActiveTool;
    property DisplayPgNums: Boolean read GetDisplayPgNums write SetDisplayPgNums;
    property AutoPgNumber: Boolean read GetAutoPgNumbers write SetAutoPgNumbers;
    property ManualStartPg: Integer read GetManualStartPg write SetManualStartPg;
    property ManualTotalPg: Integer read GetManualTotalPg write SetManualTotalPg;
    property docEditor: TEditor read GetActiveEditor write SetActiveEditor;
    property Munger: TCellMunger read FMunger write FMunger;
    property FreezeCanvas : Boolean read GetFreezeCanvas write SetFreezeCanvas;
    property MapPortalManager: TMapPortalManager read FMapPortalManager;
    property MapPortalManagerSL: TMapPortalManagerSL read FMapPortalManagerSL;
    property PageNavigator: TComponent read GetPageNavigator;
    property UADEnabled: Boolean read GetUADEnabled write SetUADEnabled;
    property RunSiliently: Boolean read FRunSiliently write FRunSiliently;

  published
    property FileFormat: TFileFormat read FFileFormat write FFileFormat default ffClickFORMS7;
    property OnBuildEditorPopupMenu: TBuildPopupMenuEvent read FOnBuildEditorPopupMenu write FOnBuildEditorPopupMenu;
    property OnCellEnter: TNotifyEvent read GetOnCellEnter write SetOnCellEnter;
    property OnCellExit: TNotifyEvent read GetOnCellExit write SetOnCellExit;
end;

var
  CF_RedStoneData: Word;

implementation

{$R *.DFM}

Uses
  DateUtils, ShellAPI, comObj, Clipbrd, StrUtils,
  UUtil1, UFileGlobals, UFiles, UFileUtils, UMain, UDraw, UDrag,
	UActiveForms, UStatus, UEditForms, UDeleteForm, UViewScale, UStdRspsEdit,
	UStdCmtsEdit, UStdRspUtil, UPrefCell, UFindNReplace, UStrings,
  UTwoPrint, UAdobe, UDocSpeller, UFileConvert, UMath, UUtil2, UXMLUtil,
  UWinPrint, UWPDF2, UWPDF3, UReviewer, UFileExport, ad3SpellBase,  UDocCommands,
  UFileFinder, UUtil4, UFormPageNavigator, UUADConfiguration,
//appraisal specific
  UAppraisalIDs,UUADEffectiveAge,
//debug
  UUserSetCellID, UUserSetRspID, UCellIDSearch,
//Tools
  {UImageEditor, }UWinUtils, UToolUtils, UCellMetaData,
  UUADUtils, {UGSECreateXML, }UGSEUADPref, UAMC_Delivery, UXMLConst,
//CompsDB
  UListComps2,
  uListCompsUtils,
  UDebug,
  uUADConsistency,
  UImportRedstoneData,
  UAutoUpdateForm,jpeg,UBase64,uMathMisc;
const
  UpButton    = 1;
  DownButton  = 2;


{******************************************}
{        	                                 }
{          TContainer                      }
{                                          }
{******************************************}

constructor TContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMapPortalManager := TMapPortalManager.Create(Self);
  FMapPortalManagerSL := TMapPortalManagerSL.Create(self);
  Initialize;
end;

//we do this to read the data without displaying the window (shortcut for now)
constructor TContainer.CreateMinimized(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMapPortalManager := TMapPortalManager.Create(Self);
  FMapPortalManagerSL := TMapPortalManagerSL.Create(Self);
  WindowState := wsMinimized;

  Initialize;
end;

/// summary: Indicates whether the cell can link comments.
function TContainer.CanLinkComments: Boolean;
begin
  if (docEditor is TTextEditor) then
    Result := (docEditor as TTextEditor).CanLinkComments
  else
    Result := False;
end;

///< Add by Jeferson May/5/2010. New Font Menu for WPCells >\\\
///< Send True if Cells is Wordprocess >\\\
function TContainer.IsWordProcessCell: Boolean;
begin
  Result := Assigned(docActiveCell)and(docActiveCell is TWordProcessorCell);
end;

procedure TContainer.CMGetDialogKey(var Message: TMessage);
begin
  // Most keyboard messages are sent directly to the form's window proc.
  // Keyboard messages in the application message queue end up here instead.
  // This code is required to support cell editor controls that need to be
  // freed during a keyboard event that causes the active cell to change.

  // False = Give us a WM_KEY message and trigger the form's Key events
  Message.Result := Ord(False);
end;

//this is used to find 'same' cells for the word processor to overflow into
function TContainer.FindCellInstance(const Instance: TCellInstanceID): TBaseCell;
var
  Form: Integer;
  Page: Integer;
  Cell: Integer;
begin
  Result := nil;
  if Assigned(Self.docForm) then
    for Form := 0 to docForm.Count - 1 do
      if Assigned(docForm[Form].frmPage) then
        for Page := 0 to docForm[Form].frmPage.Count - 1 do
         if Assigned(docForm[Form].frmPage[Page].pgData) then
           for Cell := 0 to docForm[Form].frmPage[Page].pgData.Count - 1 do
             if IsEqualGUID(Instance, docForm[Form].frmPage[Page].pgData[Cell].InstanceID) then
               begin
                 Result := docForm[Form].frmPage[Page].pgData[Cell];
                 Exit;
               end;
end;

function TContainer.GetOnCellEnter: TNotifyEvent;
begin
  if Assigned(Self) then
    Result := FOnCellEnter
  else
    Result := nil;
end;

procedure TContainer.SetOnCellEnter(const Value: TNotifyEvent);
begin
  if Assigned(Self) then
    FOnCellEnter := Value;
end;

function TContainer.GetOnCellExit: TNotifyEvent;
begin
  if Assigned(Self) then
    Result := FOnCellExit
  else
    Result := nil;
end;

procedure TContainer.SetOnCellExit(const Value: TNotifyEvent);
begin
  if Assigned(Self) then
    FOnCellExit := Value;
end;

/// summary: Gets the page navigator for the document.
function TContainer.GetPageNavigator: TComponent;
begin
  Result := FindComponent(TPageNavigator.ClassName);
end;

/// summary: Updates the page navigator.
procedure TContainer.UpdatePageNavigator;
var
  Navigator: TPageNavigator;
begin
  Navigator := PageNavigator as TPageNavigator;
  if Assigned(Navigator) then
    Navigator.Update;
end;

/// summary: Gets whether UAD features are enabled.
/// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
function TContainer.GetUADEnabled: Boolean;
begin
  Result := FUADEnabled;    //docData.HasData(ddUADEnabled);   //don't lookup every time
end;

/// summary: Sets whether UAD features are enabled.
/// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
procedure TContainer.SetUADEnabled(const Value: Boolean);
var
  Stream: TStringStream;
  docTitle: String;
begin
  if (Value <> UADEnabled) then
    begin
      if Value then  //true - users wants UAD
        begin
          if (TUADConfiguration.Database <> nil) then           //make sure UAD Database is around
            begin
              Stream := TStringStream.Create(ddUADEnabled);
              try
                docData.UpdateData(ddUADEnabled, Stream);       //save in DocData
                FUADEnabled := True;
                Self.Caption := 'UAD ACTIVE ' + Self.Caption;   //signal user
              finally
                FreeAndNil(Stream);
              end;
            end
          else
            ShowNotice(msgUADDatabaseError);
        end
      else
        begin
          FUADEnabled := False;
          docData.DeleteData(ddUADEnabled);
          if POS('UAD ACTIVE ', Self.Caption) > 0 then
            begin
              docTitle := Self.Caption;
              delete(docTitle, 1, 11);
              self.caption := docTitle;
            end;
        end;
        
      if (docForm.Count > 0) then
        Dispatch(DM_CONFIGURATION_CHANGED, DMS_DOCUMENT, nil);
    end;
end;

procedure TContainer.HandleTextOverflow;
begin
  try
    if (docActiveCell.FCellID <> CCommentsCellID) then
      if docActiveCell.EditorClass = TMLEditor then
        if IsAppPrefSet(bLinkComments) or DisplayUADStdDlg(Self, '', True) then
          LinkComments(Self);
  except
  end;
end;

procedure TContainer.BuildEditorPopupMenu(const Sender: TEditor; const Menu: TPopupMenu);
begin
  if Assigned(FOnBuildEditorPopupMenu) then
    FOnBuildEditorPopupMenu(Sender, Menu);
end;

procedure TContainer.Activate;
begin
  if Assigned(docView) then
    docView.SetFocus;
  if Assigned(docEditor) then
    docEditor.ActivateEditor;
  if not FDocHasBookMarks then
    InstallBookMarkMenuItems;
  inherited;
end;

procedure TContainer.Deactivate;
begin
  if Assigned(docEditor) then
    docEditor.DeactivateEditor;
  if FDocHasBookMarks then
    RemoveBookMarkMenuItems;
  inherited;
end;

procedure TContainer.DoCellEnter;
begin
  if Assigned(FOnCellEnter) then
    FOnCellEnter(Self);
end;

procedure TContainer.DoCellExit;
begin
  if Assigned(FOnCellExit) then
    FOnCellExit(Self);
end;

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then queues the message for
//           delivery to the objects within the scope.
procedure TContainer.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
var
  Notification: PNotificationMessageData;
begin
  // add to message queue
  New(Notification);
  Notification.Msg := Msg;
  Notification.Scope := Scope;
  Notification.Data := Data;
  Notification.NotifyProc := @TContainer.Notify;
  Notification.NotifyInstance := Self;
  PostMessage(Handle, WM_DOCUMENT_NOTIFICATION, 0, Integer(Notification));
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TContainer.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
var
  Index: Integer;
  FormList: TDocFormList;
  ShowProgress: Boolean;
begin
  // process message
  case Msg of
    DM_CONFIGURATION_CHANGED:
      begin
        ShowProgress := True;
        ConfigurationChanged;
      end;
    DM_LOAD_COMPLETE:
      begin
        ShowProgress := False;
        if UADEnabled and (TUADConfiguration.Database = nil) then
          begin
            UADEnabled := False;
            ShowNotice(msgUADDatabaseError);
          end;
      end;
  end;

  // notify forms
  if Assigned(docForm) then
    begin
      FormList := TDocFormList.Create(Self);
      try
        FormList.Assign(docForm);
        if ShowProgress and UADEnabled then
          DisplayProgressBar('Validating UAD Data - Please Wait', FormList.Count);
        for Index := 0 to FormList.Count - 1 do
          begin
            IncrementProgressBar;
            FormList.Forms[Index].Notify(Msg, Data);
          end;
      finally
        FreeAndNil(FormList);
        RemoveProgressBar;
      end;
    end;
end;

procedure TContainer.Initialize;
begin
  FCellXPathList := TCellXPathList.Create(Self);
  FIDragDrop :=  TDropTarget.Create;
  FMunger := TCellMunger.Create(Self);          //holds concatenated text from cells like (city, st zip)
  FMunger.OnChange := BroadcastMungedText;      //when things change, tell the world

	docView := TDocView.Create(Self);
	docView.Parent := self;
	docView.Align := alClient;
  docView.OnVerticalScroll := WindowScrolled;
  docView.OnKeyDown := FormKeyDown;
  docView.OnKeyPress := FormKeyPress;
  PageMgr.OnKeyDown := FormKeyDown;
  PageMgr.OnKeyPress := FormKeyPress;
  ZoomFactor := appPref_DisplayZoom;   //this sets the docView.ViewScale

  FReadOnly := False;                   //opened as read only
  FAutoSaving := False;                 //auto saving is off, read prefs
  FFileFormat := ffClickFORMS7;         //default file format
  FRecorded := False;                   //this file has not been recorded in Reports List
  FProcessListCount := 0;               //number of occurances of process lists
  FDocHasBookMarks := False;            //bookmarks have not been added to GoTo Menu yet
  FDocUID := 0;                         //no uniquie identifier for this report yet
//  docUID := GetUniqueID;                //uniquie identifier for this report
  FRunSiliently := False;

	docIsNew	:= True;
	docDataChged := False;
	docPrefChged := False;
	docRspsChged := False;

  docOrderAckNeeded := False;       //special for AMC's (RELS) to ensure user ack'ed the order
  docOrderAcked := False;

	FDocAutoRspOn := False;

	docFileName := '';       //holds just the name
	docFilePath := '';       //holds just the path
	docFullPath := '';       //holds the path and name

	docFont := TFont.Create;
	docFont.Assign(appPref_InputFont);   //assign the apps default font for now
  docProgress := nil;

  docHasBeenReviewed := False;   //flag for the automated review
	docPref := appPref_PrefFlags;        //current application prefs

	docColors[cFormTxColor]     := appPref_FormTextColor;
	docColors[cFormLnColor]     := appPref_FormFrameColor;
	docColors[cFormArColor]     := appPref_FormFrameColor;   //same for now
	docColors[cInfoCelColor]    := appPref_InfoCellColor;
	docColors[cFreeTxColor]     := appPref_FreeTextColor;
	docColors[cEmptyCellColor]  := appPref_EmptyCellColor;
	docColors[cHiliteColor]	    := appPref_CellHiliteColor;
	docColors[cFilledColor]	    := appPref_CellFilledColor;
	docColors[cUADCellColor]    := appPref_CellUADColor;
	docColors[cInvalidCellColor]:= appPref_CellInvalidColor;

	docEditor := nil;                    // no editor to edit it with
	docActiveCell := nil;                // no cell is active at beginning
  docStartingCellUID := nullUID;
  docLastActCellUID := nullUID;
	docActiveCellChged := False;

  FActiveLayer := alStdEntry;           //Standard Form Entry Mode at beginning
  docActiveItem := nil;                 //There are no annotation items active.

	docLastPgBottom := 0;                // bottom of last page, add new page starting here
	docMinWidth := cPageWidthLetter;

	docPageMgrWidth := appPref_PageMgrWidth;        //go to List stuff
	if IsBitSet(docPref, bShowPageMgr) then
		LeftBasePanel.Width := max(1, docPageMgrWidth)   //kludge: cannot be zero at start
	else
		LeftBasePanel.Width := 1;          //cannot be zero

	docTableOfContents := nil;    			      //doc's table of contents, none yet
	docForm := TDocFormList.Create(self);    	//with slots for 50 forms
  docForm.OnChanged := OnDocFormChanged;

  docAutoSave := TTimer.Create(self);
  docAutoSave.Interval := appPref_AutoSaveInterval;
  docAutoSave.OnTimer := AutoSave;
  docAutoSave.Enabled := appPref_AutoSave and (Not TestVersion);

  docProperty := TDocProperty.Create(Self);         //stores doc property stuff
  docSignatures := TSignatureMgr.Create(Self);      //stores doc sigantures
  docData := TDocDataList.Create(Self);             //stores misc data

  SchemaVersion := TDocumentSchemaVersion.Create(nil);
  SchemaVersion.Document := Self;

//automatic adj list for appraisal
  docCellAdjusters := TCellAdjustList.create(True);

//notify user if in overwrite mode
  if assigned(docStatus) then
    if KeyOverWriteMode then
      docStatus.Panels[1].text := 'Overwrite Mode'
    else
      docStatus.Panels[1].text := 'Insert Mode';
//WPDF is not creating now
  WPDFPrinting := false;
//For DPI fix
  PageMgr.Font.Size  := 7;   //need to set it at run time for dpi 125 and 144
  PageMgr.ItemHeight := 13;  //adjustment for dpi 144
end;

procedure TContainer.Invalidate;
begin
  inherited;
  if Assigned(docView) then
    docView.Invalidate;
end;

destructor TContainer.Destroy;
var
  aForm: TAdvancedForm;
begin
  // deactivate the editor and make docActiveCell = nil
  Switch2NewCell(nil, False);

	//look at what you free. Some is owned by the ActiveForms Mgr
  FreeAndNil(FCellXPathList);
  FreeAndNil(FMapPortalManager);
  FreeAndNil(FMapPortalManagerSL);

 	if assigned(docAutoSave) then
		FreeAndNil(docAutoSave);

	if assigned(docForm) then
		begin
      docForm.FreeContents;      // free all the pages, dataCell lists etc.
      FreeAndNil(docForm);       // now free the list itself, (separation needed for ArrangeForms)
    end;

	if Assigned(docFont) then
		docFont.Free;

//	if Assigned(docEditor) then
//		FreeAndNil(docEditor);
  if Assigned(FMarkupEditor) then
    FreeAndNil(FMarkupEditor);

	if Assigned(docTableOfContents) then       //free tabel of contents
		FreeAndNil(docTableOfContents);

  if assigned(docProperty) then
    FreeAndNil(docProperty);

  if assigned(docSignatures) then
    FreeAndNil(docSignatures);

  FreeAndNil(SchemaVersion);
  if assigned(docData) then
    FreeAndNil(docData);

  if assigned(docCellAdjusters) then
    FreeAndNil(docCellAdjusters);

  if assigned(FRepGlobalList) then
    FreeAndNil(FRepGlobalList);

  if assigned(FRepLocalList) then
    FreeAndNil(FRepLocalList);

  if assigned(FRepMathList) then
    FreeAndNil(FRepMathList);

  if assigned(FMunger) then
    FreeAndNil(FMunger);

  if assigned(FIDragDrop) then
    FIDragDrop.Free;

  if assigned(docView) then      //free the view, MUST be called after docForm.Free
    FreeAndNil(docView);

  aForm := FindFormByName('MarketData');
  if aForm <> nil then
    FreeAndNil(aForm);  

  aForm := FindFormByName('Analysis');  //Look for Service > Analysis dialog
  if aForm <> nil then    //if dialog is open and close we need to free it
    FreeAndNil(aForm);    //free it

  inherited Destroy;
end;

procedure TContainer.SetFocus;
begin
  inherited;

  Windows.SetFocus(Handle);  // MS KB190634: PRB: Activate Event Is Not Triggered with Child Form of MDI Form (http://support.microsoft.com/kb/190634)
end;

//this is called after reading a container to set it properly
procedure TContainer.SetupContainer;
var
  df,p,n: Integer;
begin
  if WindowState <> wsMaximized then    //if maximized, ViewScale has already been set
    docView.ViewScale := FZoomScale;

	if IsBitSet(docPref, bShowPageMgr) then
		LeftBasePanel.Width := max(1, docPageMgrWidth)   //kludge: cannot be zero at start
	else
		LeftBasePanel.Width := 1;    //cannot be zero   {PageMgr}

  // Are we locked or read only?
  //Set the button on the container FormMgr
  UpdateFormMgrButtons;

//setup the Goto Page names stored in the file.
//NOTE: The Table of contents is not setup, but if anything chnages, its rebuilt and automatically updated
  n := 0;
  if docForm.count > 0 then
    for df := 0 to docForm.count-1 do     			//run thru docforms
      with docForm[df] do
        for p := 0 to frmPage.count-1 do        //iterate on docForm's pages
          begin
            PageMgr.Items.Strings[n] := frmPage[p].PgTitleName;
            inc(n);
          end;

  docSignatures.UpdateSignatureBounds;          //set signature rects where user wants them

  FUADEnabled := docData.HasData(ddUADEnabled); //reset the UAD Compliance flag if previously on/off

  //capture configuration changes and make sure that UAD is set on or off
  if (docForm.Count > 0) then
    Dispatch(DM_CONFIGURATION_CHANGED, DMS_DOCUMENT, nil);
end;

/// summary: Flags the document as modified when the forms list has changed.
procedure TContainer.OnDocFormChanged(Sender: TObject);
begin
  SetModifiedFlag;
end;

procedure TContainer.UpdateToolBarButtons;
var
  docHasForms: Boolean;
begin
  docHasForms := docForm.count > 0;
  main.FileSaveCmd.Enabled := docHasForms;
  main.FilePrintCmd.Enabled := docHasForms;
  main.tBtnMarker.Enabled := docHasForms and not Locked;
  main.tbtnZoomText.Enabled := docHasForms;
  main.tbtnZoomUpDn2.Enabled := docHasForms;
end;

procedure TContainer.UpdateFormMgrButtons;
begin
  tbtnUp.enabled := not Locked;
  tbtnDown.enabled := not Locked;
  tbtnDelete.enabled := not Locked;
  FormManagerPopup.AutoPopup := not Locked;
end;

//this is needed so we can save any changes to properties into
//the report file before it goes to the reports database.
function TContainer.SaveProperties: Boolean;
begin
  result := True;
  if not (docUID = docIDNonRecordable) then         //-1 reserved for non-recordable containers
      if (not docIsNew) then  
        if IsAppPrefSet(bAutoSaveProp) then           //we are going to do a save to Reports database
          begin
            docProperty.LoadPropertiesFromDoc;        //get the latest (due to not recording consistently in early versions)
            if IsAppPrefSet(bConfirmPropSave) then    //want us to confirm saving first time
              begin
                if (not Recorded) then                //this is first time
                  if Ok2Continue(docFileName+ ' has not been recorded in the Reports List. Do you want to record it? If so please confirm the data in File/Properties.') then
                    begin
                      docProperty.EditProperty('Please Confirm Report Properties');   //can record here
                      if not Recorded then docProperty.SaveToReportList;              //if not do it here
                    end
                  else
                else
                  docProperty.SaveToReportList;       //all other times
              end
            else //do not confirm - just record
              docProperty.SaveToReportList;      //note: docProperty is reloaded on each save
          end
        else
          result := False;
end;

procedure TContainer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
	response, PosIdx: Integer;
	str, UADNoteStr: String;
  propSaved: Boolean;
  cList: TStringList;
  SubjectInfo, CompInfo: AddrInfo;
begin
  if RunSiliently then
    begin
      Canclose := True;
      Exit;
    end;
  if TestVersion and ControlKeyDown then exit;     //RELS shortcut while testing
  response := mrOK;  //ticket #750 initialize the response.
//  HandleCompsDBPostProcess;

  if (not AppForceQuit) then    //are we being forced to quit (ie bad license)
  try
    Show;
    SaveCurCell;            //save current cell text
//  SaveCurItem;						//save current free text

    //RELS Rule: Warn the user that the order has not been accepted or declined. Give
    // them the option of not closing, so they can accept the order.Before a container holding a RELS Order can close
    //the RELS Order must be acknowledged (either accept or decline)
    if docOrderAckNeeded and (not docOrderAcked) and not RunSiliently then
      begin
        if not WarnOK2Continue(msgOrderNotAccepted) then   //opted to not close
          begin
            CanClose := False;
            Exit;
          end;
      end;

    //auto append the UAD Definition and Abbreviations
    UADNoteStr := '';
    if UADEnabled and HasUADForm(self) and not RunSiliently then         //if doc is UAD Enabled
      if appPref_UADAppendGlossary then             //if they want the UAD def addendum
        if GetFormIndex(4013) = -1 then              //and the UAD defs are not in report
            begin
              //if this report has an older definition of terms addendum, delete it
              PosIdx := GetFormIndexByOccur(965, 0);
              if (PosIdx >= 0) then
                DeleteForm(PosIdx);
              GetFormByOccurance(4013, 0, True);     //add UAD defaddendum if not there & let them know.
              UADNoteStr := ' The UAD Definitions addendum was added to your report.';
            end;

    propSaved := False;
		CanClose := True;
    //response := mrYes;
    if docDataChged and not RunSiliently then
      begin
//        if docDataChged then  //for debug only
//          showmessage('docDataChged flag is set to TRUE');
        str := 'Save changes to '+docFileName+' before closing?' + UADNoteStr;
        response := WantToSave(str);    //YesNoCancel

        if response = mrCancel then            //cancel the close
          begin
            CanClose := False;
            Exit;
          end
        else
          begin
            if response = mrYes then            //YES: wants to save
              begin
                {   not optimize images on closing
                if DocNeedsImageOptimization then //check for large image sizes
                  begin
                    CanClose := False;
                    Exit;
                  end;      }

                if DocNeedsReviewing then        //check if the report needs reviewing
                  begin
                    CanClose := False;
                    Exit;
                  end;
                if docIsNew then                  //its new, so get the name
                  CanClose := Self.SaveAs					//try to save
                else begin
                  propSaved := SaveProperties;    //might need to confirm properties, do before save
                  CanClose := Self.Save;					//try to save
                end;
              end
            else                                //response = NO: does not want to save
              canClose := True;                 //we can close

            if canClose then                    //we are closing
              if docAutoSave <> nil then        //if we have autosave
                docAutoSave.enabled := False;   //turn it off
          end;
      end;

if canClose and  
 (
  (response = mrYes) or
  (response = mrOK)    //ticket #750: needs to consider not just mrYes but also mrOK as well
  ) then
  HandleCompsDBPostProcess;

    if not propSaved then                       //properties not recorded during save
      SaveProperties;                           //try to record it here

    //if order delivery form is open, close it
    if AMCDeliveryProcess<>nil then
       AMCDeliveryProcess.close;

//  Removed saving Form Format changes for Vista compatibiity
(*
    if docPrefChged and IsAppPrefSet(bConfirmFmtSave) then
      if OK2Continue(msgSaveFormats) then
        begin
          Self.SaveFormatChanges;             //Save the format changes to the FormsMgr TFormDesc object
          ActiveFormsMgr.SaveFormDefinitions; //save the changes now, so user has assoc with changes they made
        end;
*)
//Check for auto update
(*
  DONOT do any auto update
  if not TestVersion then		//###JB
    if appPref_EnableAutomaticUpdates then
      begin
        TAutoUpdateForm.Updater.OnUpdatesChecked := Main.ShowAvailableUpdates;
        TAutoUpdateForm.Updater.CheckForUpdates(True);
      end;
*)

	except
    if not RunSiliently then
	  	CanClose := Ok2Continue('An error occured while closing this Window. Do you want to close it anyway?')
    else
      CanClose := True;
	end;
end;

procedure TContainer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Switch2NewCell(nil, False);  // generate OnCellExit event prior to closing the form
	Action := caFree;

  ActiveTool := alToolNone;       //go to std entry mode/layer
  ActiveLayer := alStdEntry;

  //no more spell checking
  if assigned(main.AddictSpell.ControlParser) then
    if UCell.CellContainerObj(TBaseCell(TCellSpeller(main.AddictSpell.ControlParser).FCell)) = self then
      main.addictSpell.StopCheck(True);  //stop spellchecker
end;

//Pass the command on to Command Central, the commands are NOT the same as Math ID cmds
procedure TContainer.ProcessCommand(Sender: TObject; CX: CellUID; CmdID: Integer);
begin
  SaveCurCell;
  ProcessDocCommand(Self, CX, CmdID);
end;

function TContainer.FindContextData(ContextID: Integer; var Str: String): Boolean;
var
	f,p: Integer;
	foundIt: Boolean;
begin
	str := '';
	foundIt := False;
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
			begin
				for p := 0 to docForm[f].frmPage.Count -1 do
					begin
						foundIt := TDocPage(docForm[f].frmPage[p]).FindContextData(contextID, str);
						if foundIt then
							break;       //break off 2nd FOR
					end;
				if foundIt then    //break off 1st FOR
					break;
			end;

	result := length(str) > 0;
end;

function TContainer.FindContextData(ContextID: Integer; out DataCell: TBaseCell): Boolean;
var
	f,p: Integer;
	foundIt: Boolean;
begin
  DataCell := nil;
	foundIt := False;
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
			begin
				for p := 0 to docForm[f].frmPage.Count -1 do
					begin
						foundIt := TDocPage(docForm[f].frmPage[p]).FindContextData(contextID, DataCell);
						if foundIt then
							break;       //break off 2nd FOR
					end;
				if foundIt then    //break off 1st FOR
					break;
			end;

	result := Assigned(DataCell);
end;

//populate form with data from doc
procedure Tcontainer.PopulateFormContext(AForm: TDocForm);
var
	n: Integer;
begin
	if AForm <> nil then                                //we have a form
    begin
      for n := 0 to AForm.frmPage.Count-1 do          //for each form
        AForm.frmPage[n].PopulateContextCells(self); 	//load the context cells and do any cmds
    end;
end;

//special for broadcasting first page from ClickNOTES
procedure TContainer.BroadcastPageContext(aPage: TDocPage;PostProcessFlag:Byte=0);
var
	df, p: Integer;
	docFrm: TDocForm;
begin
	if aPage <> nil then
		if docForm.Count > 0 then
			for df := 0 to docForm.count-1 do     								//run thru docforms
				begin
          docFrm := docForm[df];                              //broadcast to this form
          for p := 0 to docFrm.frmPage.Count-1 do   					//iterate on it's pages
            if docFrm.frmPage[p] <> aPage then                //don't braodcast to ourselves
              aPage.BroadcastContext2Page(docFrm.frmPage[p], PostProcessFlag);   //pass true to do post process
        end;
end;



//broadcast aForm Context to other forms in this doc
procedure Tcontainer.BroadcastFormContext(aForm: TDocForm);
var
	df, n, p: Integer;
	docFrm: TDocForm;
begin
	if aForm <> nil then
		if docForm.Count > 0 then
			for df := 0 to docForm.count-1 do     									//run thru docforms
				begin
					docFrm := docForm[df];
					if docFrm <> aForm then          					 					//don't braodcast to ourselves
						for p := 0 to aForm.frmPage.Count-1 do   					//iterate on aForms's pages
							for n := 0 to docFrm.frmPage.count-1 do        //iterate on docForm's pages (luckily we only look at context)
								aForm.frmPage[p].BroadcastContext2Page(docFrm.frmPage[n]);	 //broadcast to this page n
				end;
end;

procedure TContainer.UpdateTableCells;
var
  TType: Integer;
  Grid: TGridMgr;
begin
  for TType := 1 to 3 do //don't know table type for photo, so do them all
    begin
      Grid := TGridMgr.Create(True);
      try
        Grid.BuildGrid(self, TType);
        Grid.PopulatePhotoLinks;      //sends grid data to photo pages
      finally
        Grid.Free;
      end;
    end;
end;

procedure TContainer.UpdateFormTables(AForm: TDocForm);
var
  p: Integer;
begin
  with AForm do
    for p := 0 to frmPage.count-1 do
      with frmPage[p].pgDesc do
        begin
          //if grid editor is active, update its tables
          if Assigned(docEditor) and docEditor.ClassNameIs('TGRidCellEditor') then
            TGridCellEditor(docEditor).LoadTableGrid(True);

          //if photo page added, populate photo addresses
          if (PgType = ptPhotoComps) or (PgType = ptPhotoListings)
            or (PgType = ptPhotoRentals) or (PgType = ptPhotoSubject) then
              UpdateTableCells;
        end;
end;

(*
//call from Cell to doc to broadcast its data to other forms
procedure TContainer.BroadcastCellContextOutsideForm(ContextID: Integer; Str: String; startCell: TBaseCell; startForm: TDocForm);
var
	f,p: Integer;
  docFrm: TDocForm;
begin
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
      begin
        docFrm := docForm[f];
        if docFrm <> startForm then
          for p := 0 to docForm[f].frmPage.Count -1 do
            TDocPage(docForm[f].frmPage[p]).BroadcastCellContext(contextID, str, startCell); //doc tells pages
      end;
end;
*)
//called from Cell to doc to spread its message, but not to itself (ie startCell)
procedure TContainer.BroadcastCellContext(ContextID: Integer; Str: String);
var
	f,p: Integer;
begin
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
			for p := 0 to docForm[f].frmPage.Count -1 do
				TDocPage(docForm[f].frmPage[p]).BroadcastCellContext(contextID, str); //doc tells pages
end;

//called from Cell to doc to spread its message, but not to itself (ie startCell)
procedure TContainer.BroadcastCellContext(ContextID: Integer; const Source: TBaseCell);
var
  f,p: Integer;
begin
  if docForm.count > 0 then
    for f := 0 to docForm.count-1 do
      for p := 0 to docForm[f].frmPage.Count -1 do
        TDocPage(docForm[f].frmPage[p]).BroadcastCellContext(contextID, Source); //doc tells pages
end;

//special for appraising
procedure TContainer.SetupCellMunger;
var
  Address, CityStZip: String;
begin
  //special for Lender Address - force update due to previous bugs
  //Find the most current address in the report, don't rely on Munder info
  if FindContextData(13, Address) then                    //13 = kLenderAddress
    begin
      FMunger.MungedText[kLenderAddress] := Address;
//      shownotice('setupcellmunger: context id 13 = '+address);
    end;
  if FindContextData(17, CityStZip) then                  //17 = kLenderCityStateZip
    begin
//      shownotice('setupcellmunger: context id 17 = '+citystzip);
      FMunger.MungedText[kLenderCity] := ParseCityStateZip3(CityStZip, cmdGetCity);
      FMunger.MungedText[kLenderState] := ParseCityStateZip3(CityStZip, cmdGetState);
      FMunger.MungedText[kLenderZip] := ParseCityStateZip3(CityStZip, cmdGetZip);
    end;

  if assigned(FMunger) then
    FMunger.SetupMungedValues;
end;

//Github item #11: if the cell preference set not transfer in or not transfer out, do not do the munging
procedure TContainer.SetupCellMunger2;
var
  Address, CityStZip: String;
  acell: TBaseCell;
begin
  if FindContextData(13, aCell) then
    begin
      if IsBitSet(acell.FCellPref, bCelTrans) then
      begin
        if not (IsBitSet(acell.FCellPref, bNoTransferInto)) then
        begin
          FMunger.MungedText[kLenderAddress] := aCell.GetText;
        end;
      end;
    end;
  if FindContextData(17, aCell) then                  //17 = kLenderCityStateZip
    begin
      CityStZip := '';
      if assigned(aCell) then
        CityStZip := aCell.GetText;
      if IsBitSet(acell.FCellPref, bCelTrans) then
        begin
          if not  (IsBitSet(acell.FCellPref, bNoTransferInto)) then
            begin
              FMunger.MungedText[kLenderCity] := ParseCityStateZip3(CityStZip, cmdGetCity);
              FMunger.MungedText[kLenderState] := ParseCityStateZip3(CityStZip, cmdGetState);
              FMunger.MungedText[kLenderZip] := ParseCityStateZip3(CityStZip, cmdGetZip);
            end;
        end;
    end;

  if assigned(FMunger) then
    FMunger.SetupMungedValues;
end;


function TContainer.FindMungedContextData(ContextID: Integer; var Str: String): Boolean;
begin
  If Assigned(FMunger) then
//    Str := FMunger.MungedValue[ContextID];   //see if Munger has a value
    Str := trim(FMunger.MungedValue[ContextID]);   //Ticket #1357: We need to trim the text to make sure we do have some text not just blank
  result := length(Str)> 0;
end;

//used to load munger, munger then broadcasts out to doc
procedure TContainer.LoadCellMunger(ContextID: Integer; Str: String);
begin
  If Assigned(FMunger) then
    FMunger.MungedText[ContextID] := Str;  //load munger & broadcast munged text

  StartProcessLists;
  BroadcastCellContext(ContextID, FMunger.MungedText[ContextID]);
  ClearProcessLists;
end;

//Loads the Cell Munger, but does not broadcast it out
procedure TContainer.SetMungedValue(ContextID: Integer; Str: String);
begin
  if assigned(FMunger) then
    FMunger.MungedValue[ContextID] := Str;
end;

//used by munger to broadcast its changes
procedure TContainer.BroadcastMungedText(Sender: TObject; ContextID: Integer; AStr: String);
begin
  StartProcessLists;
  BroadcastCellContext(ContextID, AStr);
  ClearProcessLists;
end;

//This is a do nothing form insert
function TContainer.SimpleFormInsert(FormUID: TFormUID; Expanded: Boolean; Idx: Integer): TDocForm;      //inserts a form w/o processing
var
	theForm: TFormDesc;
begin
	result := nil;
	if FormUID <> nil then
    begin
      theForm := ActiveFormsMgr.GetFormDefinition(FormUID);       // find it first
      result := InsertFormDef(theForm, Expanded, Idx);
    end;
end;

function TContainer.InsertFormUID(FormUID: TFormUID; Expanded: Boolean; Idx: Integer): TDocForm;
begin
	result := InsertBlankUID(FormUID, Expanded, Idx);

  if assigned(result) then
  begin
    StartProcessLists;
    PopulateFormContext(result);                //pickup what we can form context IDs
    ClearProcessLists;

    StartProcessLists;
    if result.MainForm then                     //if main form, fill-in with cell IDs
      result.PopulateFromSimilarMain(self)

    else if result.MainExtForm then             //if main extension, fill-in with cell IDs
      result.PopulateFromSimilarMainExt(self);
    ClearProcessLists;                          //we need to find a better way to do this
    result.Dispatch(DM_CONFIGURATION_CHANGED, DMS_FORM, nil);
  end;
end;

function TContainer.ReadAMCOrderInfoFromReport: AMCOrderInfo;
var
  strm: TStream;
begin
    result.AppraiserID := '';
    result.OrderID := '';
    result.ProviderID := '';
    result.ProviderIdx := Length(AMCStdInfo) - 1;
    result.XMLVer := '';
    result.TermOfReferURL := '';
    result.SvcGetDataName := '';
    result.SvcGetDataEndPointURL := '';
    result.SvcGetDataInfoURL := '';
    result.SvcVerRptName := '';
    result.SvcVerRptEndPointURL := '';
    result.SvcVerRptInfoURL := '';
    result.SvcSendRptName := '';
    result.SvcSendRptEndPointURL := '';
    result.SvcSendRptInfoURL := '';
    result.RecDate := 0;
    result.DueDate := 0;
    result.SentDate := 0;
    result.Address := '';
    result.City := '';
    result.Province := '';
    result.PostalCode := '';
    result.UnitNo := '';
    result.County := '';
    result.Borrower := '';
    result.LenderName := '';
    result.LenderAddr := '';
    if assigned(self) then begin
      strm := self.docData.FindData(ddAMCOrderInfo);
      if assigned(strm) then begin
        result.AppraiserID := ReadStringFromStream(strm);
        result.OrderID := ReadStringFromStream(strm);
        result.ProviderID := ReadStringFromStream(strm);
        result.ProviderIdx := StrToInt(ReadStringFromStream(strm));
        result.XMLVer := ReadStringFromStream(strm);
        result.TermOfReferURL := ReadStringFromStream(strm);
        result.SvcGetDataName := ReadStringFromStream(strm);
        result.SvcGetDataEndPointURL := ReadStringFromStream(strm);
        result.SvcGetDataInfoURL := ReadStringFromStream(strm);
        result.SvcVerRptName := ReadStringFromStream(strm);
        result.SvcVerRptEndPointURL := ReadStringFromStream(strm);
        result.SvcVerRptInfoURL := ReadStringFromStream(strm);
        result.SvcSendRptName := ReadStringFromStream(strm);
        result.SvcSendRptEndPointURL := ReadStringFromStream(strm);
        result.SvcSendRptInfoURL := ReadStringFromStream(strm);
        result.RecDate := ReadDateFromStream(strm);
        result.DueDate := ReadDateFromStream(strm);
        result.SentDate := ReadDateFromStream(strm);
        result.Address := ReadStringFromStream(strm);
        result.City := ReadStringFromStream(strm);
        result.Province := ReadStringFromStream(strm);
        result.PostalCode := ReadStringFromStream(strm);
        result.UnitNo := ReadStringFromStream(strm);
        result.County := ReadStringFromStream(strm);
        result.Borrower := ReadStringFromStream(strm);
        result.LenderName := ReadStringFromStream(strm);
        result.LenderAddr := ReadStringFromStream(strm);
      end;
    end;
end;

procedure TContainer.WriteAMCOrderInfoToReport(const FAMCOrder: AMCOrderInfo);
var
  strm: TStream;
begin
  strm := TMemoryStream.Create;
  try
    WriteStringToStream(FAMCOrder.AppraiserID, strm);
    WritestringToStream(FAMCOrder.OrderID, strm);
    WriteStringToStream(FAMCOrder.ProviderID, strm);
    WriteStringToStream(IntToStr(FAMCOrder.ProviderIdx), strm);
    WriteStringToStream(FAMCOrder.XMLVer, strm);
    WriteStringToStream(FAMCOrder.TermOfReferURL, strm);
    WriteStringToStream(FAMCOrder.SvcGetDataName, strm);
    WriteStringToStream(FAMCOrder.SvcGetDataEndPointURL, strm);
    WriteStringToStream(FAMCOrder.SvcGetDataInfoURL, strm);
    WriteStringToStream(FAMCOrder.SvcVerRptName, strm);
    WriteStringToStream(FAMCOrder.SvcVerRptEndPointURL, strm);
    WriteStringToStream(FAMCOrder.SvcVerRptInfoURL, strm);
    WriteStringToStream(FAMCOrder.SvcSendRptName, strm);
    WriteStringToStream(FAMCOrder.SvcSendRptEndPointURL, strm);
    WriteStringToStream(FAMCOrder.SvcSendRptInfoURL, strm);
    WriteDateToStream(FAMCOrder.RecDate, strm);
    WriteDateToStream(FAMCOrder.DueDate, strm);
    WriteDateToStream(FAMCOrder.SentDate, strm);
    WriteStringToStream(FAMCOrder.Address, strm);
    WriteStringToStream(FAMCOrder.City, strm);
    WriteStringToStream(FAMCOrder.Province, strm);
    WriteStringToStream(FAMCOrder.PostalCode, strm);
    WriteStringToStream(FAMCOrder.UnitNo, strm);
    WriteStringToStream(FAMCOrder.County, strm);
    WriteStringToStream(FAMCOrder.Borrower, strm);
    WriteStringToStream(FAMCOrder.LenderName, strm);
    WriteStringToStream(FAMCOrder.LenderAddr, strm);

    self.docData.UpdateData(ddAMCOrderInfo, strm);
  finally
    strm.Free;
  end;
end;

function TContainer.InsertBlankUID(FormUID: TFormUID; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True): TDocForm;
var
	theForm: TFormDesc;
begin
	result := nil;
	if FormUID <> nil then
    begin
      theForm := ActiveFormsMgr.GetFormDefinition(FormUID);       // find it first
      result := InsertForm(theForm, Expanded, Idx, UADCompliance);               // insert it
    end;
end;

//Only call this directly when reading in a file.
function TContainer.InsertFormDef(AFormDef: TFormDesc; Expanded: Boolean; Idx: Integer): TDocForm;
var
  n: Integer;
	aPage: TDocPage;
	aForm: TDocForm;
begin
	aForm := nil;
  if AFormDef <> nil then                        // make sure we have a form
    begin
      aForm := TDocForm.Create(self);             // create the form object
      aForm.frmOwner := AFormDef.FOwner;           //ref to FormsMgr Item that owns the form
      aForm.frmInfo := AFormDef.Info;              //just reference the info
      aForm.frmSpecs := AFormDef.Specs;            //just reference the specs
      aForm.frmDefs := AFormDef.PgDefs;            //just reference the pages desc
      aForm.frmPage.Capacity := AFormDef.Specs.fNumPages;    //with space for spec.NumPages

      //add the blank pages to the form
      for n := 1 to AFormDef.Specs.fNumPages do
        begin                                       //create dataPg and displayPg
          aPage := TDocPage.Create(aForm, AFormDef.PgDefs.PgDesc[n-1], Expanded);
          aForm.frmPage.Add(aPage);             		// add the page to the form's page list
        end;

      FreezeCanvas := True;                   // stop the painting
      try
        docForm.InsertForm(aForm, Idx);
        ScrollInToView(aForm);                //now show it to the world
      finally
        FreezeCanvas := False;                // restart the painting
      end;
    end;
	result := aForm;
end;

//Only call this directly when reading in a file.
function TContainer.InsertFormDef2(AFormDef: TFormDesc; Expanded: Boolean; Idx: Integer; bShowMessage: Boolean=True): TDocForm;
var
  n: Integer;
	aPage: TDocPage;
	aForm: TDocForm;
begin
	aForm := nil;
  if AFormDef <> nil then                        // make sure we have a form
    begin
      aForm := TDocForm.Create(self);             // create the form object
      aForm.frmOwner := AFormDef.FOwner;           //ref to FormsMgr Item that owns the form
      aForm.frmInfo := AFormDef.Info;              //just reference the info
      aForm.frmSpecs := AFormDef.Specs;            //just reference the specs
      aForm.frmDefs := AFormDef.PgDefs;            //just reference the pages desc
      aForm.frmPage.Capacity := AFormDef.Specs.fNumPages;    //with space for spec.NumPages

      //add the blank pages to the form
      for n := 1 to AFormDef.Specs.fNumPages do
        begin
          Application.ProcessMessages;
          if (GetKeyState(VK_Escape) AND 128) = 128 then
            break;
          if bShowMessage then                                      //create dataPg and displayPg
            aPage := TDocPage.Create(aForm, AFormDef.PgDefs.PgDesc[n-1], Expanded)
          else
            aPage := TDocPage.CreateForImport(aForm, AFormDef.PgDefs.PgDesc[n-1], Expanded, bShowMessage);
          aForm.frmPage.Add(aPage);             		// add the page to the form's page list
        end;

      FreezeCanvas := True;                   // stop the painting
      try
        docForm.InsertForm(aForm, Idx);
        ScrollInToView(aForm);                //now show it to the world
      finally
        FreezeCanvas := False;                // restart the painting
      end;
    end;
	result := aForm;
end;



//main routine for inserting a form into a container. Everything happens here!
function TContainer.InsertForm(theForm: TFormDesc; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True): TDocForm;
var
	AForm: TDocForm;
begin
  AForm := InsertFormDef(theForm, Expanded, Idx);
  if AForm <> nil then
    begin
      SetupUADCompliance(AForm.FormID,UADCompliance);   //see if the doc should be UAD Compliant because of this form;
      ActiveLayer := alStdEntry;          // adding a form so setup for text entry

      docForm.RenumberPages;              // renumber all pages in list
      docForm.SetupTableContentPages;     // index the table of content pages
      BuildContentsTable;                 // build the table of contents
      docForm.ConfigInstance(AForm);      // Comes after TableOfContents;config multi-instances of forms
      DisplayPageCount;                    // Show the current page count in status bar
      docSignatures.UpdateFormSignatures(AForm);   //update the forms signature bounds (auto sign)
      AForm.SetAllCellsTextSize(docFont.Size);     //set font size same as report
      AForm.SetAllCellsFontStyle(docFont.Style);
      AForm.SetGlobalCellFormating(appPref_AutoTextAlignNewForms); //format cells on new forms
      UpdateFormTables(AForm);            //if there are tables in new form, notify table users
      UpdateToolbarButtons;               //we have forms, update the buttons
      AForm.LoadUserLogo;

      if docForm.count > 0 then           //if not starting from blank container
        docDataChged := True;             //remember to ask if want to save
      if docForm.count = 1 then           //first and only one
        SetupForInput(cFirstCell);        //then setup for input
    end;
  result := aForm;
end;

//main routine for inserting a form into a container. Everything happens here!
function TContainer.InsertForm2(theForm: TFormDesc; Expanded: Boolean; Idx: Integer; UADCompliance:Boolean=True; bShowMessage:Boolean=True): TDocForm;
var
	AForm: TDocForm;
begin
  AForm := InsertFormDef(theForm, Expanded, Idx);
  if AForm <> nil then
    begin
      if bShowMessage then
        SetupUADCompliance(AForm.FormID,UADCompliance);   //see if the doc should be UAD Compliant because of this form;
      ActiveLayer := alStdEntry;          // adding a form so setup for text entry

      docForm.RenumberPages;              // renumber all pages in list
      docForm.SetupTableContentPages;     // index the table of content pages
      BuildContentsTable;                 // build the table of contents
      docForm.ConfigInstance(AForm);      // Comes after TableOfContents;config multi-instances of forms
      DisplayPageCount;                    // Show the current page count in status bar
      docSignatures.UpdateFormSignatures(AForm);   //update the forms signature bounds (auto sign)
      AForm.SetAllCellsTextSize(docFont.Size);     //set font size same as report
      AForm.SetAllCellsFontStyle(docFont.Style);
      AForm.SetGlobalCellFormating(appPref_AutoTextAlignNewForms); //format cells on new forms
      UpdateFormTables(AForm);            //if there are tables in new form, notify table users
      UpdateToolbarButtons;               //we have forms, update the buttons
      AForm.LoadUserLogo;

      if docForm.count > 0 then           //if not starting from blank container
        docDataChged := True;             //remember to ask if want to save
      if docForm.count = 1 then           //first and only one
        SetupForInput(cFirstCell);        //then setup for input
    end;
  result := aForm;
end;


//this is from a drag and drop
function TContainer.AddLiveForm(FormUID:TFormUID; liveForm:TDocForm; Expanded:Boolean; atIndex:Integer): TDocForm;		//FForm, theForm, -1);
var
	theForm: TformDesc;
	n : integer;
	doOption: Integer;
begin
	if FormUID <> nil then
	begin
		theForm := ActiveFormsMgr.GetFormDefinition(FormUID);       // find it first
		Result := InsertForm(theForm, Expanded, atIndex);    							//insert the form definition

		if liveForm <> nil then                //liveForm=nil if coming from lib; non-nil if from another doc
		with theForm do                        // with the form description
			for n := 1 to Specs.fNumPages do     // add the view controls (Title, DisplayPanel, Toggle)
			begin
        Result.frmPage[n-1].Assign(liveForm.frmPage[n-1]);
			end;
    //Pages may be unique, so rebuild the TofC
    BuildContentsTable;

    //Tablet Inspection Form
    if (Result <> nil) and (Result.FormID <> 699) then         //699 is property inspection
      begin
        if (docForm.count > 1) and Result.HasContext then     //don't do this if its the only form
          begin
            doOption:=	WhichOption123('Export', 'Import', 'Neither', msgPopOrBroadcast);

            StartProcessLists;
            if doOption = mrYes then
              BroadcastFormContext(Result)
            else if doOption = mrNo then
              PopulateFormContext(Result);
            ClearProcessLists;
          end;
      end;  //theForm <> nil

      Result.Dispatch(DM_CONFIGURATION_CHANGED, DMS_FORM, nil);
	end else	//formID <>nil
    Result := nil;
end;

procedure TContainer.AddLiveWordProcessorPage(const FormUID: TFormUID; const LiveForm: TDocForm; const Expanded: Boolean; const InsertionIndex: Integer);
type
  TCopyMode = (cmCopyPage, cmLinkPage, cmCopyForm);
var
  CopyMode: TCopyMode;
  Form: TDocForm;
  FormIndex: Integer;
  ExistingWordProcessor: TWordProcessorCell;
  NewWordProcessor: TWordProcessorCell;
begin
  // determine form insertion index
  if (InsertionIndex < 0) or (InsertionIndex >= docForm.Count) then
    FormIndex := docForm.Count
  else
    FormIndex := InsertionIndex;

  // find word processor on previous page
  if (FormIndex > 0) and (docForm[FormIndex - 1].GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
    ExistingWordProcessor := docForm[FormIndex - 1].GetCellByID(CWordProcessorCellID) as TWordProcessorCell
  else
    ExistingWordProcessor := nil;

  // find word processor on live page
  if (LiveForm.GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
    NewWordProcessor := LiveForm.GetCellByID(CWordProcessorCellID) as TWordProcessorCell
  else
    NewWordProcessor := nil;

  // determine copy mode
  if Assigned(NewWordProcessor) then
    if Assigned(ExistingWordProcessor) then
      if WarnOK2Continue(msgLinkWordProcessorPages) then
        CopyMode := cmLinkPage
      else
        CopyMode := cmCopyPage
    else
      CopyMode := cmCopyPage
  else
    CopyMode := cmCopyForm;

  // execute copy procedure
    if (CopyMode = cmLinkPage) then
     begin
      ExistingWordProcessor.CopyPage(NewWordProcessor, ExistingWordProcessor.DisplayPageNumber + 1);
     end
  else if (CopyMode = cmCopyPage) then
    begin
      Form := InsertFormUID(FormUID, True, InsertionIndex);
      ExistingWordProcessor := Form.GetCellByID(CWordProcessorCellID) as TWordProcessorCell;
      ExistingWordProcessor.CopyPage(NewWordProcessor, ExistingWordProcessor.DisplayPageNumber);
    end
  else
    AddLiveForm(FormUID, LiveForm, Expanded, InsertionIndex);

end;

/// summary: Links the word processor cells on two forms.
procedure TContainer.LinkWordProcessorPages(const ParentForm: TDocForm; const ChildForm: TDocForm);
var
  ChildCell: TBaseCell;
  ParentCell: TBaseCell;
  ChildWordProcessor: TWordProcessorCell;
  ParentWordProcessor: TWordProcessorCell;
begin
  ChildCell := ChildForm.GetCellByID(CWordProcessorCellID);
  ParentCell := ParentForm.GetCellByID(CWordProcessorCellID);
  if (ChildCell is TWordProcessorCell) and (ParentCell is TWordProcessorCell) then
    begin
      ChildWordProcessor := ChildCell as TWordProcessorCell;
      ParentWordProcessor := ParentCell as TWordProcessorCell;
      ParentWordProcessor.MergeDocument(ChildWordProcessor, ParentWordProcessor.DisplayPageNumber + 1);
    end;
end;

/// summary: Prompts the user whether to link the word processor cells on two forms.
function TContainer.PromptLinkWordProcessorPages(const ParentForm: TDocForm; const ChildForm: TDocForm): Boolean;
var
  ChildCell: TBaseCell;
  ParentCell: TBaseCell;
begin
  ChildCell := ChildForm.GetCellByID(CWordProcessorCellID);
  ParentCell := ParentForm.GetCellByID(CWordProcessorCellID);
  if (ChildCell is TWordProcessorCell) and (ParentCell is TWordProcessorCell) then
    Result := WarnOK2Continue(msgLinkWordProcessorPages)
  else
    Result := False;
end;

procedure TContainer.InsertInPageMgrList(Page: TDocPage; Idx: Integer);
begin
//	if Idx < 0 then
//		PageMgr.Items.Add(Page.pgDesc.PgName);
//    PageMgr.Items.Add(Page.PgTitleName);        //show the page the user sets or sees

  if (Idx < 0) or (Idx >= PageMgr.Items.Count) then  //append if =-1 or =count
    PageMgr.Items.Add(Page.PgTitleName)
  else
    PageMgr.Items.Insert(Idx, Page.PgTitleName);
end;

function TContainer.GetPageIndexInPageMgrList(Page: TDocPage): Integer;
var
	f,p: Integer;
begin
  result := -1;
	if (docForm <> nil) and (docForm.Count > 0) then
    for f := 0 to docForm.count-1 do                 //iterate on forms
      with docForm[f] do
        for p := 0 to frmPage.count -1 do            // iterate on pages
          with frmPage[p] do
          begin
            inc(result);                             //count the page
            if frmPage[p] = Page then exit;          //got to our page, outta here
          end;
end;

function TContainer.GetPageByPageMgrIndex(Index: Integer): TDocPage;
var
	f,p,n: Integer;
begin
  result := nil;
  n := -1;
  if (docForm <> nil) and (docForm.Count > 0) then
    for f := 0 to docForm.count-1 do                 //iterate on forms
      with docForm[f] do
        for p := 0 to frmPage.count -1 do            // iterate on pages
          begin
            inc(n);                              //count the page
            if n = Index then
              begin
                result := frmPage[p];
                exit;                            //got to our page, outta here
              end;
          end;
end;

//Note: Make sure pages are renumbered before calling this routine
procedure TContainer.BuildPageMgrList;
var
	f,p,n,z: Integer;
begin
  FreezeCanvas := True;
  PageMgr.Items.BeginUpdate;
  try
    PageMgr.Items.Clear;					//get rid of whatever was there
    PageMgr.Items.Capacity:= docForm.TotalPages;

    z := docForm.count;
    if z > 0 then             //if we have some forms
      for f := 0 to z-1 do
        begin
          n := docForm[f].frmPage.count;
          for p := 0 to n-1 do
            begin
              PageMgr.Items.add(docForm[f].frmPage[p].PgTitleName);
            end;
        end;
  finally
    PageMgr.Items.EndUpdate;
    FreezeCanvas := False;
  end;
end;

function TContainer.GetPageMgrDisplay: Boolean;
begin
  result := IsBitSet(docPref, bShowPageMgr);
end;

procedure TContainer.SetPageMgrDisplay(value: Boolean);
begin
  if value <> IsBitSet(docPref, bShowPageMgr) then
    if value then
      begin
        if docPageMgrWidth <= 1 then docPageMgrWidth := appPref_PageMgrWidth;
        LeftBasePanel.width := max(1, docPageMgrWidth);
        docPref := SetBit(docPref, bShowPageMgr);
      end
    else
      begin
        LeftBasePanel.width := 1;
        docPref := ClrBit(docPref, bShowPageMgr);
      end;
end;

procedure TContainer.TogglePageMgrDisplay;
begin
  if IsBitSet(docPref, bShowPageMgr) then
    DisplayPageMgr := False
  else
    DisplayPageMgr := True;
end;

procedure TContainer.ScrollIntoView(Form: TDocForm);
var
  firstPage: TDocPage;
begin
  if assigned(form) then
    begin
      firstPage := Form.frmPage[0];
      docView.ScrollPageIntoView(firstPage.PgDisplay);
    end;
end;

/// summary: Links a comments section to the text cell.
procedure TContainer.LinkComments(Sender: TObject);
begin
  if CanLinkComments then
    (docEditor as TTextEditor).LinkComments;
end;

procedure TContainer.WindowScrolled(Sender: TObject; Pos: SmallInt; EventType: TVScrollEventType);
begin
  PageMgr.Invalidate;      //  so the PageMgr List indicates what is in the viewport
  if EventType = vsThumbTrack then
    begin
      {Richard - It might be better to put this in DocView, but maybe not}
      {TODO: show a hint window with the current page name next to the vertical scroll thumb }
    end;
end;

procedure TContainer.ArrangeForms;
var
	EditForms: TArrangeForms;
begin
	EditForms := TArrangeForms.create(nil);   //Application
	if EditForms.ShowModal = mrOK then
	begin
		EditForms.ArrangeForms;
	end;
	EditForms.Free;
end;

procedure TContainer.DeleteForms;
var
	EditForms: TDeleteForms;
begin
	EditForms := TDeleteForms.create(nil);    //Application
	if EditForms.ShowModal = mrOK then
	begin
		EditForms.DeleteForms;
	end;
	EditForms.Free;
end;

procedure TContainer.DeleteForm(FormIdx: Integer);
var
	removeActCell: Boolean;
begin
	if FormIdx < docForm.Count then
    try
      ActiveLayer := alStdEntry;           //ony delete forms when in this layer.

      removeActCell := docActiveCell.UID.form = FormIdx;   //are we active in form to delete
      if removeActCell then
        begin
          UnloadActiveCellEditor;
          RemoveCurCell;
        end;

      docForm[FormIdx].Free;              //delete it
      docForm[FormIdx] := nil;            //nil and pack
      docForm.Pack;

      docView.ResequencePages;
      docForm.RenumberPages;              //renumber the pages
      docForm.ReConfigMultiInstances;     //redo the instance settings
      BuildContentsTable;                 //rebuild table of contents
      BuildPageMgrList;                    //rebuild the page list
      DisplayPageCount;                    //update page count in status bar
      ResetCurCellID;                     //reset IDs
    except
      //### just for debugging
      on e: Exception do
      //ShowNotice('Error on Delete: '+ E.message);
    end;
end;

//clicked the container toolbar Delete Button (trash can)
procedure TContainer.DeleteFormClick(Sender: TObject);
var
  N, PgIdx: Integer;
  formName, AskQuestion: String;
  theForm: TDocForm;
  formIdx: Integer;
begin
  N := PageMgr.ItemIndex;
  if N > -1 then
    begin
      //get the form from the selected page in view list
      theForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
      formIdx := docForm.IndexOf(theForm);    // get the forms index
      if formIdx > -1 then
        begin
          N := theForm.frmInfo.fFormPgCount;
          if N > 1 then
            begin
              formName := theForm.frmInfo.fFormName;
              AskQuestion := 'Are you sure you want to remove all ' + IntToStr(N) + ' pages of the form ' + formName + ' from the report? Any data in the form will be lost.';
            end
          else
            begin
              formName := TDocPage(theForm.frmPage[0]).PgTitleName;
              AskQuestion := 'Are you sure you want to remove the form ' + formName + ' from the report? Any data in the form will be lost.';
            end;

          if WarnOK2Continue(AskQuestion) then
            begin
              if (docForm[FormIdx].GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
                (docForm[FormIdx].GetCellByID(CWordProcessorCellID) as TWordProcessorCell).DeletePage
              else
                begin
                  PgIdx := PageMgr.ItemIndex;       //reset the highlighted page
                  DeleteForm(formIdx);
                  PgIdx := InRange(0, PageMgr.count-1, PgIdx);
                  PageMgr.ItemIndex := PgIdx;
                end;
              if UADEnabled and (not HasUADForm(self)) then
                UADEnabled := False;  
            end;
        end;
    end;
end;

procedure TContainer.SwapForms(FormIdx1, FormIdx2: Integer);
var
	k,i,j,GoToPgIndex: Integer;
begin
  docForm.Exchange(formIdx1, formIdx2);    //switch the forms

  FreezeCanvas := True;                    // stop the painting
  k := 0;
  GoToPgIndex := k;
  try
    for i := 0 to docForm.count-1 do         //for each form
      with docForm[i] do
      begin
        if formIdx1 = i then
          GoToPgIndex := k;
        for j := 0 to frmPage.count-1 do    //for each page in form
          begin
            docView.PageList.Items[k] := frmPage[j].PgDisplay;    //update PgDisplays
            PageMgr.Items[k] := frmPage[j].PgTitleName;     //update GOTOPageList
            inc(k);
          end;
      end;

    docView.ResequencePages;            //get all dimension in order
    docForm.RenumberPages;              //renumber the pages
    docForm.ReConfigMultiInstances;
  //  BuildPageMgrList;
    BuildContentsTable;                 //rebuild the table of contents
    UpdateTableCells;                   //update text in cells associated by tables
    ResetCurCellID;                     //reset the cur cell UID
  finally
    FreezeCanvas := False;
  end;
  PageMgr.ItemIndex := GoToPgIndex; //select this one
//  PageMgrClick(nil);                //by clicking it
  PageMgrShowSelectedPage;

	docView.SetFocus;
	docView.Invalidate;                 //show our work
  SetModifiedFlag;
end;

  //before calling make sure index are in range
procedure TContainer.MoveForm(fromIndex, toIndex: Integer);
var
	k,i,j,GoToPgIndex: Integer;
begin
  docForm.Move(fromIndex, toIndex);         //move
  FreezeCanvas := True;                    // stop the painting
  k := 0;
  GoToPgIndex := k;
  try
    for i := 0 to docForm.count-1 do         //for each form
      with docForm[i] do
      begin
        if toIndex = i then
          GoToPgIndex := k;
        for j := 0 to frmPage.count-1 do    //for each page in form
          begin
            docView.PageList.Items[k] := frmPage[j].PgDisplay;    //update PgDisplays
            PageMgr.Items[k] := frmPage[j].PgTitleName;     //update GOTOPageList
            inc(k);
          end;
      end;

    docView.ResequencePages;            //get all dimension in order
    docForm.RenumberPages;              //renumber the pages
    docForm.ReConfigMultiInstances;
  //  BuildPageMgrList;
    BuildContentsTable;                 //rebuild the table of contents
    UpdateTableCells;                   //update text in cells associated by tables
    ResetCurCellID;                     //reset the cur cell UID
  finally
    FreezeCanvas := False;
  end;
  PageMgr.ItemIndex := GoToPgIndex; //select this one
  PageMgrShowSelectedPage;
//  PageMgrClick(nil);                //by clicking it

	docView.SetFocus;
	docView.Invalidate;                 //show our work
  SetModifiedFlag;
end;

//clicked one of the Up or Down buttons
procedure TContainer.MoveFormsUpDownClick(Sender: TObject);
var
  N, formIdx1, formIdx2: Integer;
  AForm: TDocForm;
begin
  N := PageMgr.ItemIndex;
  if N > -1 then
    begin
      AForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
      formIdx1 := docForm.IndexOf(AForm);             // get the forms index
      if TToolButton(sender).tag = UpButton then      //clicked up button
        begin
          if formIdx1 = 0 then
            MessageBeep(MB_ICONHAND)                   //already at the top
          else begin
            formIdx2 := formIdx1 -1;
            SwapForms(formIdx2, formIdx1);             //put #1 into #2 slot
            //select first page in formIdx
          end;
        end
      else if TToolButton(sender).tag = DownButton then   //clicked down button
        begin
          if formIdx1 = docForm.Count-1 then
            MessageBeep(MB_ICONHAND)                   //already at the bottom
          else begin
            formIdx2 := formIdx1 +1;
            SwapForms(formIdx2, formIdx1);             //put #1 into #2 slot
            //select first page in formIdx
          end;
        end;
    end;
  Activate;
end;

procedure TContainer.DisplayPageCount;
begin
  if assigned(docStatus) then
    docStatus.Panels[0].Text := 'Pages: ' + IntToStr(docForm.TotalPages);     //show the user
end;

//For now, just rebuild the table everytime we add, delete or move forms
procedure TContainer.BuildContentsTable;
var
	f,p: Integer;
  PgNumStr: String;
begin
	if (docTableOfContents <> nil) then            		//delete whatever was there
		begin
			docTableOfContents.Free;
			docTableOfContents := nil;
		end;

	if (docForm <> nil) and (docForm.Count > 0) then
		begin
			docTableOfContents := TStringList.Create;
			for f := 0 to docForm.count-1 do                 //iterate on forms
				with docForm[f] do
					for p := 0 to frmPage.count -1 do            // iterate on pages
						with frmPage[p] do
              if IsPageInContents then                 //does this page go into contents
							begin
                docTableOfContents.add(PgTitleName);   //Get Page name stored in Page object
                PgNumStr := '';
                if GetPageNumber <> 0 then             //allows us to have name in contents without page #
                  PgNumStr := IntToStr(GetPageNumber);
								docTableofContents.add(PgNumStr);      //desc followed by page #
							end;
		end;
end;

//Finds a specific page in the table of contents list
function TContainer.GetPageIndexInTableContents(Page: TDocPage): Integer;
var
	f,p: Integer;
begin
  result := -1;
	if (docForm <> nil) and (docForm.Count > 0) and (docTableOfContents <> nil) then
		begin
			for f := 0 to docForm.count-1 do                 //iterate on forms
				with docForm[f] do
					for p := 0 to frmPage.count -1 do            // iterate on pages
            with frmPage[p] do
						if frmPage[p] = Page then
              begin
                inc(result);
                if not IsPageInContents then    //this page is not in contents
                  result := -1;
                exit;
              end
             else if IsPageInContents then      //does this page go into contents
              inc(result);
		end;
end;

function TContainer.GetTableContentsDesc(Index: Integer):String;
begin
	result := '';
	if (docTableOfContents <> nil) and (docTableOfContents.count > 0) then  //do we have contents
		if 2*index <= docTableOfContents.count then                        		//are we in range
			result := docTableOfContents[(index-1)*2];                          //-1, zero based,pairs
end;

function TContainer.GetTableContentsPage(Index: Integer): String;
begin
	result := '';
	if (docTableOfContents <> nil) and (docTableOfContents.count > 0) then   //do we have contents
		if 2*index <= docTableOfContents.count then                         	 //are we in range
			result := docTableOfContents[(index-1)*2+1];                         //-1, zero based,pairs
end;

//given a CellUID return the cell
//### This is not using the "occur" value in CellUID
function TContainer.GetCell(CUID: CellUID): TBaseCell;
begin
	result := nil;
	if (CUID.form < 0) and (CUID.FormID > 0) then               //minus indicates to use first formUID
		CUID.form := GetFormIndex(CUID.FormID);                   //gets the first one of type formUID

	if (CUID.form >= 0) and (CUID.form < docForm.count) then        //form index is in range
		if (CUID.Pg < docForm[CUID.form].frmPage.count) then          //page is in reange
      if docForm[CUID.form].frmPage[CUID.pg].PgData <> nil then   //page has some cells
			  if (CUID.Num>-1) and (CUID.Num < docForm[CUID.form].frmPage[CUID.pg].PgData.Count) then  //and cell is in range
				  result := docForm[CUID.form].frmPage[CUID.pg].PgData[CUID.num];   //then this is the cell
end;

 //Implemented so find IDs easier for MISMO
function TContainer.FindNextCellByID(AnID : Integer): TBaseCell;
var
  Counter : Integer;
  StartingFormIndex : Integer;
  ThisUID : CellUID;
begin
  if (AnID > 0) and (docForm <> nil) then                 //make sure we have something to find.
    begin
      if docForm.Count > 0 then
        begin
          StartingFormIndex := docActiveCell.UID.Form;

          Result := docForm[StartingFormIndex].GetCellByID(AnID);
          if Result <> nil then
            begin
              ThisUID := Result.UID;

               //if it is after the current cell, then it's okay
              if (ThisUID.Pg > docActiveCell.UID.Pg) or
                ((ThisUID.Pg = docActiveCell.UID.Pg) and (ThisUID.Num > docActiveCell.UID.Num)) then
                begin
                  Exit;
                end;
            end;

          for Counter := StartingFormIndex + 1 to docForm.Count - 1 do //  start looking on the next form
            begin
              Result := docForm[Counter].GetCellByID(AnID);
              if Result <> nil then
                Exit;
            end;

          for Counter := 0 to StartingFormIndex do        //      wrap-around and start looking from the first form
            begin
              Result := docForm[Counter].GetCellByID(AnID);
              if Result <> nil then
                Exit;
            end;
        end;
    end;
  Result := nil;
end;

procedure TContainer.SelectCellID(AnID : Integer);
var
  ThisCell: TBaseCell;
  ThisCellID: string;
begin
  while AnID = -1 do
    begin
      if not InputQuery('Find Cell by CellID', 'Cell ID:', ThisCellID) then
        Abort;
      AnID := StrToIntDef(ThisCellID, -1);
    end;

  ThisCell := FindNextCellByID(AnID);
  if ThisCell <> nil then
    begin
      MakeCurCell(ThisCell);
      ShowCurCell;
    end
  else
    Beep;
end;

 //each cell is assigned a type ID, get the first one
function TContainer.GetCellByID(ID: Integer): TBaseCell;
var
  f:Integer;
begin
  result := nil;
  f := 0;
  if ID > 0 then       //make sure we have something to find.
    if (docForm <> nil) then
      while (result = nil) and (f < docForm.count) do
        begin
          result := docForm[f].GetCellByID(ID);
          inc(f);
        end;
end;

function TContainer.GetCellsByID(ID:Integer): cellUIDArray;
var
  formNo, pageNo, cellNo: Integer;
  cUID: cellUID;
begin
  setlength(result,0);
  if not assigned(docForm) then
    exit;
  for formNo := 0 to docForm.Count - 1 do
    with docForm[formNo] do
      begin
        if not assigned(frmPage) then
          continue;
        for pageNo := 0 to frmPage.Count - 1 do
          with frmPage[pageNo] do
            begin
              if not assigned(pgData) then
                continue;
              for cellNo := 0 to pgData.Count - 1 do
                with pgData[cellNo] do
                  if FCellID = ID then
                    begin
                      setlength(result,length(result) + 1);
                      cuid.FormID := uid.formID;
                      cuid.Form := uid.form;
                      cuid.Occur := uid.Occur;
                      cuid.Pg := uid.Pg;
                      cuid.Num := uid.num;
                      result[length(result) - 1] := cuid;
                    end;
            end;
      end;
end;

function TContainer.GetCellTextByID(ID: Integer): String;
Var
  cell: TBaseCell;
begin
  result := '';
  cell := GetCellByID(ID);
  if cell <> nil then
    if Cell.FIsActive and (Cell.Editor is TTextEditor) then
      result := (Cell.Editor as TTextEditor).AnsiText
    else
      result := cell.GetText;
end;

// Get cell only if its form is active
function TContainer.GetCellByID(ID: Integer; availableForm: BooleanArray): TBaseCell;
var
  f:Integer;
begin
  result := nil;
  f := 0;
  if ID > 0 then       //make sure we have something to find.
    if (docForm <> nil) then
      while (result = nil) and (f < docForm.count) do
        begin
          if (availableForm[f]) THEN
            result := docForm[f].GetCellByID(ID);
          inc(f);
        end;
end;

/// summary: Gets a cell by searching for a matching XID.
function TContainer.GetCellByXID(const XID: Integer): TBaseCell;
var
  Cell: TBaseCell;
  Index: Integer;
begin
  Cell := nil;
  if Assigned(docForm) then
    for Index := 0 to docForm.Count - 1 do
      begin
        Cell := docForm[Index].GetCellByXID(XID);
        if Assigned(Cell) then
          Break;
      end;

  Result := Cell;
end;

// Get cell by its XML ID, but only if the form is available (ie in report)
{ this method assumes that the CID matches the XID, which is not always the case }
{ this code is maintained for backward compatability of the MISMO code }
function TContainer.GetCellByXID_MISMO(ID: Integer; availableForm: BooleanArray): TBaseCell;
var
  f:Integer;
begin
  result := nil;
  f := 0;
  if ID > 0 then       //make sure we have something to find.
    if (docForm <> nil) then
      while (result = nil) and (f < docForm.count) do
        begin
          if (availableForm[f]) then
            result := docForm[f].GetCellByID(ID);
          inc(f);
        end;
end;

// Get cells only if its form is active
function TContainer.GetCellTextByID(ID: Integer; availableForm: BooleanArray): String;
Var
  cell: TBaseCell;
begin
  result := '';
  cell := GetCellByID(ID, availableForm);
  if cell <> nil then
    if Cell.FIsActive and (Cell.Editor is TTextEditor) then
      result := (Cell.Editor as TTextEditor).AnsiText
    else
      result := cell.GetText;
end;

{ this method calls GetCellByXID_MISMO maintained for backward compatability }
function TContainer.GetCellTextByXID_MISMO(ID: Integer; availableForm: BooleanArray): String;
var
  cell: TBaseCell;
begin
  result := '';
  cell := GetCellByXID_MISMO(ID, availableForm);
  if cell <> nil then
    if Cell.FIsActive and (Cell.Editor is TTextEditor) then
      result := (Cell.Editor as TTextEditor).AnsiText
    else
      result := cell.GetText;
end;


procedure TContainer.SetCellTextByID(ID: Integer; Text: String);
Var
  cell: TBaseCell;
begin
  cell := GetCellByID(ID);
  if cell <> nil then
    begin
      Cell.SetText(text);   //cell handles if its being edited or not
      Cell.Display;
      Cell.PostProcess;
    end;
end;

procedure TContainer.SetCellTextByID2(ID: Integer; Text: String; isOverride: Boolean=True);  //Ticket #1202
Var
  cell: TBaseCell;
begin
  if Text = '' then exit;
  cell := GetCellByID(ID);
  if cell <> nil then
    begin
      if not isOverride then
        begin
          if Cell.Text = '' then
            Cell.SetText(text); 
        end
      else
        Cell.SetText(text);   //cell handles if its being edited or not
      Cell.Display;
      Cell.PostProcess;
    end;
end;
//Pam: we sometimes don't want the post process happen for the text that we want to put in the cell
//so the math process and munging process will not intervene
//example: basement GLA when set cell value, it always put basement access = in when going through math process.
procedure TContainer.SetCellTextByIDNP(ID: Integer; Text: String);
Var
  cell: TBaseCell;
begin
  cell := GetCellByID(ID);
  if cell <> nil then
    begin
      Cell.SetText(text);   //cell handles if its being edited or not
      Cell.Display;
//      Cell.PostProcess;
    end;
end;


procedure TContainer.SetCheckBoxByID(ID: Integer; Text: String);
begin
  if length(Text)> 0 then
    SetCellTextByID(ID, Text);
end;

function TContainer.GetCheckBoxValueByID(ID: Integer): Boolean;
var
  cbxText: String;
begin
  cbxText := GetCellTextByID(ID);
  result := length(cbxText) > 0;
end;

function TContainer.GetCellValueByID(ID: Integer): Double;
Var
  cell: TBaseCell;
begin
  result := 0;
  cell := GetCellByID(ID);
  if cell <> nil then
    if Cell.FIsActive then
      result := TEditor(Cell.Editor).GetValue
    else
      result := cell.GetRealValue;
end;

procedure TContainer.SetCellValueByID(ID: Integer; Value: Double);
Var
  cell: TBaseCell;
begin
  cell := GetCellByID(ID);
  if cell <> nil then
    begin
      Cell.SetValue(Value);   //cell handles if its being edited or not
      Cell.Display;
      Cell.PostProcess;
    end;
end;

function TContainer.GetValidCell(CUID: CellUID; var cell: TBaseCell): Boolean;
begin
	cell := GetCell(CUID);
	result := cell <> nil;
end;

function TContainer.GetValidInfoCell(CUID: CellUID; var cell: TObject): Boolean;
begin
  cell := nil;
	if (CUID.form < 0) and (CUID.FormID > 0) then               //minus indicates to use first formUID
		CUID.form := GetFormIndex(CUID.FormID);                   //gets the first one of type formUID

	if (CUID.form >= 0) and (CUID.form < docForm.count) then         //form index is in range
		if (CUID.Pg < docForm[CUID.form].frmPage.count) then           //page is in reange
      if docForm[CUID.form].frmPage[CUID.pg].PgInfo <> nil then    //page has some InfoCells
			  if (CUID.Num>=0) and (CUID.Num < docForm[CUID.form].frmPage[CUID.pg].PgInfo.Count) then  //and cell is in range
				  cell := docForm[CUID.form].frmPage[CUID.pg].PgInfo[CUID.num];      //then this is the InfoCell

  result := cell <> nil;
end;

procedure TContainer.ReviewReport;
var
  reviewer: TReviewer;
begin
  try
    Reviewer := TReviewer.Create(self);
    Reviewer.btnReviewClick(nil);
    Reviewer.Show;
  finally
//    Reviewer.free;    {don't free, user will close or free when quit
  end;
end;

procedure TContainer.SignDocWithLicFile(N: Integer);
begin
end;

procedure TContainer.SignDocWithRSA;
begin
end;

//gets the places user can affix/remove signatures
function TContainer.GetSignatureTypes: TStringList;
var
  n, f: Integer;
  docSigList: TStringList;
  formSigList: TStringList;
begin
  docSigList := TStringList.Create;
  formSigList := nil;
  
  try
    try
      docSigList.Sorted := True;
      docSigList.Duplicates := dupIgnore;

      for n := 0 to docForm.count-1 do
        begin
          formSigList := docForm[n].GetSignatureTypes;
          if formSigList <> nil then begin
            for f := 0 to formSigList.count-1 do
              docSigList.Add(formSigList[f]);
            formSigList.Free;
          end;
        end;
    except
      if assigned(formSigList) then
        formSigList.Free;
      FreeAndNil(docSigList);
    end;
  finally
    if (docSigList <> nil) and (docSigList.Count = 0) then
      FreeAndNil(docSigList);

    result := docSigList;
  end;
end;

//redraws the signature infoCell areas
procedure TContainer.UpdateSignature(const SigKind: String; SignIt, Setup: Boolean);
var
	f: Integer;
begin
	if docForm.count > 0 then
    for f := 0 to docForm.count-1 do                                //for all forms
      docForm[f].UpdateSignature(SigKind, SignIt, Setup);
end;

//### needs to be developed into FindFirst, FindNext, etc
function TContainer.GetFormIndex(formID: Integer): Integer;
begin
  result := docForm.GetFormIndexByOccurance(formID, 0);   //find first occurance of form
end;

//occurance is zero based
function TContainer.GetFormIndexByOccur(formID, Occur: Integer): Integer;
begin
  result := docForm.GetFormIndexByOccurance(formID, Occur);
end;

function TContainer.GetFormIndexByOccur2(formID, Occur, CID: Integer; AName: string): Integer;
begin
  result := docForm.GetFormIndexByOccurance2(formID, Occur, CID, AName);
end;

function TContainer.GetFormCountIndexByOccur2(formID, CID: Integer; AName: string): Integer;
begin
  result := docForm.GetFormCountIndexByOccurance2(formID, CID, AName);
end;

//occurance is zero based
function TContainer.GetFormByOccurance(formID, Occur: Integer; AutoLoad: Boolean): TDocForm;
var
  FormUID : TFormUID;
begin
  result := docForm.GetFormByOccurance(formID, Occur);
  if (result = nil) and autoLoad then
    begin
      FormUID := TFormUID.create;
      try
        FormUID.ID := formID;
        FormUID.Vers := 1;
        result := InsertFormUID(FormUID, True, -1);
      finally
        FormUID.Free;
      end;
    end;
end;

//occurance is zero based
function TContainer.GetFormByOccuranceByIdx(formID, Occur, Idx: Integer; AutoLoad: Boolean): TDocForm;
var
  FormUID : TFormUID;
begin
  result := docForm.GetFormByOccurance(formID, Occur);
  if (result = nil) and autoLoad then
    begin
      FormUID := TFormUID.create;
      try
        FormUID.ID := formID;
        FormUID.Vers := 1;
        result := InsertFormUID(FormUID, True, idx);
      finally
        FormUID.Free;
      end;
    end;
end;

//occurance is zero based
function TContainer.GetFormTypeByOccurance(fCatID, fKindID, Occur: Integer): TDocForm;
begin
  result := docForm.GetFormTypeByOccurance(fCatID, fKindID, Occur);
end;

function TContainer.GroupedCheckBoxes: Boolean;
begin
	result := False;
	if (docEditor <> nil) and (docEditor is TChkBoxEditor) then
		with docEditor as TChkBoxEditor do
			result := TChkBoxEditor(docEditor).HasMultiRowGroup;
end;

//make sure way here thru GroupedCheckBoxes being true
procedure TContainer.Skip2NextGroupRow(Shifted: Boolean);
var
	cellNum, curRow,curCol: Integer;
	cUID: cellUID;
	nCell: TBaseCell;
  hasCheck: Boolean;
begin
	with TChkBoxEditor(docEditor) do
		begin
      hasCheck := (length(TxStr)>0);
      if hasCheck then
        begin
          curCol := ChkBoxGpIndx.x;
          curRow := ChkBoxGpIndx.y;

          if shifted and (curRow = 1) then												//going up and at top
            cellNum := ChkBoxGroup.GetFirstCell - 1

          else if (not shifted) and (curRow = ChkBoxGroup.FRows) then  //going down and at bottom
            cellNum := ChkBoxGroup.GetLastCell + 1

          else if shifted then
            cellNum := ChkBoxGroup.GetCellAtIndex(curRow-1, curCol)  //move up a row

          else
            cellNum := ChkBoxGroup.GetCellAtIndex(curRow+1, 1);      //move down a row

          cUID := docActiveCell.UID;
          cUID.num := cellNum;

          if GetValidCell(cUID, nCell) then         //cell is valid one
            Switch2NewCell(nCell, False)          	//move to it
        end
			else if ShiftKeyDown then                 //else do regular tabbing
				MoveToNextCell(goPrev)
			else
				MoveToNextCell(goNext);
		end;
end;

procedure TContainer.MoveToNextCell(Direction: Integer);
var
  CanMove: Boolean;
  Cell, PrevCell: TBaseCell;
  NextCell: CellUID;
  EffectiveAge:TdlgUADEffectiveAge;
begin
  Cell := docActiveCell;
//  showUADDlg := appPref_AutoDisplayUADDlgs and not(appPref_UADNoConvert) and not(appPref_UADAutoConvert);
  PrevCell := docActiveCell;
  repeat
    CanMove := docForm.GoToNextCell(Cell.UID, Direction, NextCell);
    if CanMove then
      Cell := docForm[NextCell.Form].frmPage[NextCell.Pg].pgData[NextCell.Num];
  until not CanMove or not Assigned(Cell.Editor);

  if CanMove and Assigned(Cell) then
    begin
      Switch2NewCell(Cell, False);
      DisplayNonUADStdDlg(Self);

      if (appPref_AutoDisplayUADDlgs or IsUADAutoDlgCell(Self)) and Cell.FEmptyCell and
          not (appPref_UADAutoConvert) and
          not (appPref_UADNoConvert)  then //github 454: donot display when we are in uadautoconvert mode
        DisplayUADStdDlg(Self);
      // Perform all UAD cleanup processes
      if UADEnabled then //only call UADPostProcess when we're in UAD mode;
        UADPostProcess(Self, PrevCell, Cell);
    end
  else
    Beep;
end;

//move command coms through a message handler
procedure TContainer.MoveToCell(var Message: TCLKCellMove);   // message CLK_CELLMOVE;
begin
  if (Message.Direction = goCommentSection) then
    begin
      Switch2NewCell(TBaseCell(Message.Cell), False);
      if (docEditor is TWordProcessorEditor) then
        (docEditor as TWordProcessorEditor).MoveCaretToSection(Message.SectionID);
    end
  else if (Message.Direction = goDirect) then
    Switch2NewCell(TBaseCell(Message.Cell), False)
  else
    MoveToNextCell(Message.direction);
end;

/// summary: Invalidates the window and re-instances the active editor when
///          the document configuration has changed.
procedure TContainer.ConfigurationChanged;
begin
  Invalidate;
  PostMessage(Handle, CLK_CELLMOVE, goDirect, Integer(docActiveCell));
end;

procedure TContainer.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
	ShiftKeyDown,CntrlKeyDown: Boolean;
	k: Char;
  StatusMode: String;
begin
  if UADEnabled and (DocActiveCell <> nil) and (AnsiIndexText(IntToStr(DocActiveCell.FCellXID), UADCmntCellXID) >= 0) then
    if (Key = VK_RETURN) then
      begin
        if appPref_AutoDisplayUADDlgs and not appPref_UADAutoConvert then
          Key := VK_F8
        else
          Key := VK_TAB;
      end;
	K := Char(Key);                   //so we don't pass a constant to a var in KeyEditor
	docView.FocusOnDocument;
	ShiftKeyDown := ssShift in Shift;
	CntrlKeyDown := ssCtrl in Shift;

	if docForm.Count > 0 then
		case key of
			VK_TAB:
				begin
          If docEditor <> nil then
			      if not docEditor.CanAcceptChar(K) then
              if ActiveLayer = alStdEntry then
                begin
                  if ShiftKeyDown then
                    PostMessage(Handle, CLK_CELLMOVE, Word(goPrev), 0)
                  else
                    PostMessage(Handle, CLK_CELLMOVE, Word(goNext), 0);
                  Key := 0;
                end;
          Key := 0;
				end;
			VK_RETURN:
        If (docEditor <> nil) and (not docEditor.KeyForAutoRsponse(Key, Shift)) then
        begin
          if docEditor.CanAcceptChar(K) then
            docEditor.KeyEditor(K)

          else if ActiveLayer = alStdEntry then
            begin
              if GroupedCheckBoxes then
                Skip2NextGroupRow(ShiftKeyDown)
              else
                if ShiftKeyDown then
                  PostMessage(Handle, CLK_CELLMOVE, Word(goPrev), 0)
                else
                  PostMessage(Handle, CLK_CELLMOVE, Word(goNext), 0);
            end;
					Key := 0;
				end;
			VK_LEFT:
				begin
					If not CntrlKeyDown and (docEditor <> nil) and docEditor.CanMoveCaret(goLeft) then
						docEditor.MoveCaret(ShiftKeyDown, goLeft)

					else if ActiveLayer = alStdEntry then
						begin
							if ShiftKeyDown then
                PostMessage(Handle, CLK_CELLMOVE, Word(goRight), 0)
							else
                PostMessage(Handle, CLK_CELLMOVE, Word(goLeft), 0);
						end;
					Key := 0;
				end;
			VK_RIGHT:
				begin
					If not CntrlKeyDown and (docEditor <> nil) and docEditor.CanMoveCaret(goRight) then
						docEditor.MoveCaret(ShiftKeyDown, goRight)

					else if ActiveLayer = alStdEntry then
						begin
							if ShiftKeyDown then
                PostMessage(Handle, CLK_CELLMOVE, Word(goLeft), 0)
							else
                PostMessage(Handle, CLK_CELLMOVE, Word(goRight), 0);
						end;
					Key := 0;
				end;
			VK_UP:
        if (docEditor <> nil) and (not docEditor.KeyForAutoRsponse(key, Shift)) then
        begin
					If not CntrlKeyDown and (docEditor <> nil) and docEditor.CanMoveCaret(goUp) then
						docEditor.MoveCaret(ShiftKeyDown, goUp)

					else if ActiveLayer = alStdEntry then
						begin
							if ShiftKeyDown then
                PostMessage(Handle, CLK_CELLMOVE, Word(goDown), 0)
							else
                PostMessage(Handle, CLK_CELLMOVE, Word(goUp), 0);
						end;
					Key := 0;
				end;
			VK_DOWN:
				if (docEditor <> nil) and (not docEditor.KeyForAutoRsponse(Key, Shift)) then
        begin
					If not CntrlKeyDown and (docEditor <> nil) and docEditor.CanMoveCaret(goDown) then
						docEditor.MoveCaret(ShiftKeyDown, goDown)

					else if ActiveLayer = alStdEntry then
						begin
							if ShiftKeyDown then
                PostMessage(Handle, CLK_CELLMOVE, Word(goUp), 0)
							else
                PostMessage(Handle, CLK_CELLMOVE, Word(goDown), 0);
						end;
					Key := 0;
				end;
			VK_HOME:
				begin
					If (docEditor <> nil) and docEditor.CanMoveCaret(goHome) then
						docEditor.MoveCaret(ShiftKeyDown, goHome);
					key := 0;
				end;
			VK_END:
				begin
					If (docEditor <> nil) and docEditor.CanMoveCaret(goEnd) then
						docEditor.MoveCaret(ShiftKeyDown, goEnd);
					Key := 0;
				end;
			VK_DELETE:
				begin
					if docEditor <> nil then
						begin
							k := char(kDeleteKey);
						    docEditor.KeyEditor(k);
 							key := 0;
						end;
				end;
			VK_PRIOR:  //pageUp
				begin
          if ControlKeyDown then
					  docView.GoToPage(cPrevPage)
          else
            docView.ScrollFullScreen(goUp);
					key := 0;
				end;

			VK_NEXT:   //page down
				begin
          if ControlKeyDown then
					  docView.GoToPage(cNextPage)
          else
            docView.ScrollFullScreen(goDown);
					key := 0;
				end;

			VK_INSERT:
				begin
          KeyOverWriteMode := not KeyOverWriteMode;   //toggle the Insert mode for editor
          if KeyOverWriteMode then StatusMode := 'Overwrite Mode' else StatusMode := 'Insert Mode';
          if assigned(docStatus) then docStatus.Panels[1].text := StatusMode;
				end;

      VK_ESCAPE:
        begin
          //Pam: Needs to handle the case when docEditor is nil
          if (not Assigned(docEditor)) or docEditor.KeyForAutoRsponse(Key, Shift) then
            key := 0;
        end;

      VK_F8: //we want to pop up uad dialog through F8
        begin
          DisplayNonUADStdDlg(self);
          DisplayUADStdDlg(Self);   //always pop up dialog
        end;
    end; //case key of
end;

procedure TContainer.FormKeyPress(Sender: TObject; var Key: Char);
begin
	docView.SetFocus;
  if Assigned(docEditor) then
    begin
      // Characters other than carriage return and tab are accepted if:
      //  A: it is a non-UAD report
      //  B: it is a UAD report and the user is in specialist mode
      //  C: it is a UAD report, the user is NOT in specialist mode and the cell is NOT a UAD dialog cell
      if (Key <> #13) and (Key <> #9) then   //no returns or tab here
         //((not UADEnabled) or not appPref_AutoDisplayUADDlgs or (not DisplayUADStdDlg(Self, '', True))) then//(appPref_UADAutoConvert) or //github 237
         //(appPref_UADInterface > 2) or
         //(not DisplayUADStdDlg(Self, '', True))) then  //when passing True, no uad pop up
        begin
          if IsAppPrefSet(bUpperCase) then
            UpperCaseChar(Key);   //the editor performs uppercasing as well

          docEditor.KeyEditor(Key);  // returns Key = #0 when handled
        end;
		end;
end;

//this is called the first time a form is added to the doc
//it gets the first cell or last active cell and gives it an editor
procedure TContainer.SetupForInput(firstCell: Boolean);
var
	cell: TBaseCell;
begin
	if (docForm.Count > 0) then
	begin
		if firstCell or IsNullUID(docStartingCellUID) then
			cell := docForm.GetFirstInputCell     //do this for new containers
		else
			cell := GetCell(docStartingCellUID);    //do this for save ones

    if cell <> nil then
      begin
        ActiveLayer := alStdEntry;         //Make sure we can do std text entry
        if docActiveCell <> Cell then
		      Switch2NewCell(Cell, cNotClicked);
      end;
	end;
end;

//when a form is loaded/inserted this will determine if UAD compliance will get envoked
//many things happen silently - we don't ask.
procedure TContainer.SetupUADCompliance(AFormID: Integer; UADCompliance: Boolean=True);
begin
  if IsUADForm(AFormID) then                     //if this is a UAD form
    if UserUADLicensed(CurrentUser.OK2UseCustDBOrAWProduct(pidUADForms, (True or UADChkOverride))) then //and they are licensed for UAD
      if appPref_UADIsActive then                //and they want UAD active
        begin
          //auto-enable UAD
          if not UADEnabled then                   //and the doc is urrently NOT UAD Enabled
            begin
              if appPref_UADAskBeforeEnable and UADCompliance then   //and they want to be asked before enabling UAD
                UADEnabled := IsOKToEnableUAD      //ask
              else
                UADEnabled := True;                //just do it
            end;

          //append the PowerUser Forms
          if (UADEnabled and appPref_UADAppendSubjDet) and UADCompliance then //For Phoenix, no need to create new form
            begin
              if GetFormIndex(4385) = -1 then            //if Subject details not in the report
                GetFormByOccurance(4385, 0, True);       //add it
//              if GetFormIndex(982) = -1 then            //if Comp details not in the report
//                GetFormByOccurance(982, 0, True);       //add it
            end;
        end;
end;

//The report has been loaded, what do we do if it was a UAD report?
//this is called from Main when opening a report
procedure TContainer.CheckUADSettings(AsTemplate: Boolean=False);
var
  UADSubjWorksheet: TDocForm;
begin
  if FUADEnabled then  //the report was previously saved as UAD
    begin
      if not appPref_UADIsActive and UserUADLicensed(CurrentUser.OK2UseCustDBOrAWProduct(pidUADForms, (True or UADChkOverride))) then   //UAD off, need to turn on
        begin
          appPref_UADIsActive := True;
          SetUADServiceMenu(True);
        end
      else if not UserUADLicensed(CurrentUser.OK2UseCustDBOrAWProduct(pidUADForms, (True or UADChkOverride), True)) then //not licensed for UAD service
        begin
          ShowAlert(atWarnAlert, msgUADNotLicensed);
          UADEnabled := False;
          SetUADServiceMenu(False);
        end;
    end
  else if HasUADForm(self) then  //the report is non UAD, but has UAD forms
    begin
      if appPref_UADIsActive and UserUADLicensed(CurrentUser.OK2UseCustDBOrAWProduct(pidUADForms, (True or UADChkOverride), True)) then
        begin
          if appPref_UADAskBeforeEnable then
            begin
              if OK2Continue(msgOK2ApplyUAD) then
                UADEnabled := True;
            end
          else
            UADEnabled := True;
        end;
    end;

  //if its UADEnabled and PowerUser = true
  if UADEnabled and (appPref_UADInterface = cUADPowerUser) and (GetFormIndex(981) = -1) then
    begin
      UADSubjWorksheet := GetFormByOccurance(981, 0, AsTemplate);  //append the WorkSheet only IF its a template
      if assigned(UADSubjWorksheet) and AsTemplate then
        TransferReportDataToUADSubject(self, UADSubjWorksheet);
    end;
end;

procedure TContainer.LoadSupervisorUser(User: TUser);
var
  Supervisor: TLicensedUser;
begin
  Supervisor := TLicensedUser.create;
  try
    Supervisor.LoadUserLicFile(User.FLicName);    //load up this signer

  //load in user address (need to munge address
    LoadCellMunger(kSupervisorName, Supervisor.SWLicenseName);
    LoadCellMunger(kSupervisorCoName, Supervisor.SWLicenseCoName);
    LoadCellMunger(kSupervisorAddress, Supervisor.UserInfo.Address);
    LoadCellMunger(kSupervisorCity, Supervisor.UserInfo.City);
    LoadCellMunger(kSupervisorState, Supervisor.UserInfo.State);
    LoadCellMunger(kSupervisorZip, Supervisor.UserInfo.Zip);
    LoadCellMunger(kSupervisorPhone, Supervisor.UserInfo.Phone);
    LoadCellMunger(kSupervisorEMail, Supervisor.UserInfo.Email);

  //load in user appraisal lic info
    LoadCellMunger(kSuprCertNo, Supervisor.WorkLic.CertNo[0]);
    LoadCellMunger(kSuprLicNo, Supervisor.WorkLic.LicNo[0]);
    LoadCellMunger(kSuprExpDate, Supervisor.WorkLic.Expiration[0]);

  //appraiser license state is different - use munger to set Generic State
    LoadCellMunger(kSuprCertState, '');   //erase first
    LoadCellMunger(kSuprLicState, '');
    if Supervisor.WorkLic.LicenseType = cCertType then
      LoadCellMunger(kSuprCertState, Supervisor.WorkLic.State[0])
    else
      LoadCellMunger(kSuprLicState, Supervisor.WorkLic.State[0]);

  finally
    Supervisor.free;
  end;
end;

procedure TContainer.LoadLicensedUser(forceCOName: Boolean);
var
	f,p: Integer;
begin
//set the Co and the User name on page by page basis
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
			for p := 0 to docForm[f].frmPage.Count -1 do
        TDocPage(docForm[f].frmPage[p]).LoadLicensedUser(forceCOName);

//load in user address (need to munge address
  LoadCellMunger(kAppraiserName, CurrentUser.SWLicenseName);
  LoadCellMunger(kAppraiserCoName, CurrentUser.SWLicenseCoName);
  LoadCellMunger(kAppraiserAddress, CurrentUser.UserInfo.Address);
  LoadCellMunger(kAppraiserCity, CurrentUser.UserInfo.City);
  LoadCellMunger(kAppraiserState, CurrentUser.UserInfo.State);
  LoadCellMunger(kAppraiserZip, CurrentUser.UserInfo.Zip);
  LoadCellMunger(kAppraiserPhone, CurrentUser.UserInfo.Phone);
  LoadCellMunger(kAppraiserEMail, CurrentUser.UserInfo.Email);

//load in user appraisal lic info
  LoadCellMunger(kApprCertNo, CurrentUser.WorkLic.CertNo[0]);
  LoadCellMunger(kApprLicNo, CurrentUser.WorkLic.LicNo[0]);
  LoadCellMunger(kApprExpDate, CurrentUser.WorkLic.Expiration[0]);

//appraiser license state is different - use munger to set Generic State
  LoadCellMunger(kApprCertState, '');   //erase first
  LoadCellMunger(kApprLicState, '');
  if CurrentUser.WorkLic.LicenseType = cCertType then
    LoadCellMunger(kApprCertState, CurrentUser.WorkLic.State[0])
  else
    LoadCellMunger(kApprLicState, CurrentUser.WorkLic.State[0]);
  {munger will make it go to the generic state cell}
end;

//load the Co Name and User Name - used for configuring templates
procedure TContainer.SetupUserProfile(forceCOName: Boolean);
var
  LoadCoName: Boolean;
begin
  LoadCoName := forceCOName; {or CoNameLocked}

  //load the munger with user info
  if LoadCoName then
    LoadCellMunger(kAppraiserCoName, CurrentUser.SWLicenseCoName);
(*
  LoadCellMunger(kAppraiserName, CurrentUser.SWLicenseName);
  LoadCellMunger(kAppraiserAddress, CurrentUser.UserInfo.Address);
  LoadCellMunger(kAppraiserCity, CurrentUser.UserInfo.City);
  LoadCellMunger(kAppraiserState, CurrentUser.UserInfo.State);
  LoadCellMunger(kAppraiserZip, CurrentUser.UserInfo.Zip);
*)
  LoadLicensedUser(LoadCoName);
end;

//### NOTE: Could change if pages are added/deleted/rearranged
//If we change the way cells know about their neighbors, we can get rid of this
//CurCellID is used to navigate between other cells.
procedure TContainer.ResetCurCellID;
begin
  if assigned(docEditor) then docEditor.Update;
end;

//Used to remove reference to a cell after it is deleted
//When cell is deleted, it removes itself from its editor
procedure TContainer.RemoveCurCell;
begin
	docActiveCell := nil;                //nil out reference
	if docEditor <> nil then           //free the editor
		begin
			docEditor.Free;
			docEditor := nil;
      docView.FocusedCntl := nil;      //### double click is bypassing mouseup where =nil occurs
		end;
end;

procedure TContainer.LoadActiveCellEditor(clicked: Boolean);
var
  Editor: TEditor;
begin
  Editor := nil;
  if Assigned(docActiveCell) then
  begin
    try
      Editor := docActiveCell.EditorClass.Create(Self) as TEditor;
      Editor.LoadCell(docActiveCell, docActiveCell.UID);
      Editor.LoadCellRsps(docActiveCell, docActiveCell.UID);
      Editor.HilightCell;
      // 060211 JWyatt Add the following to ensure that settings for restricted
      //  UAD cells are set to their required settings. 080411 Before highlighting
      //  the cell contents in case the user selects overwrite/Select all mode.
      if Self.UADEnabled then
        SetUADCellFmt(Editor, docActiveCell);
      Editor.InitCaret(clicked);
      Editor.ActivateEditor;
      Editor.AutoRspOn := docAutoRspOn or docActiveCell.AllowRspTextOnly;
      Editor.OnBuildPopupMenu := BuildEditorPopupMenu;
      FTextOverflowed := Editor.TextOverflowed;
      //PAM - If it's UAD comment form and no text in the comment cell and UAD, set canedit to false so user cannot click on it
      //This will fix access violation issue when uad is on and the comment cell is empty when clicking
      if Self.UADEnabled and (docActiveCell.FCellID=1218) and (docActiveCell.UID.FormID=972) and (Editor.TxStr='') then
          Editor.FCanEdit := False;
      //PAM - when we have UAD enabled, for form #794,we need to unlock cell ID 958 so user can edit
      if Self.UADEnabled and (docActiveCell.FCellID=958) and (docActiveCell.UID.FormID=794) then
        Editor.FCanEdit := True;

    except
      FreeAndNil(Editor);
      raise;
    end;

    docActiveCell.SetEditState(True);
    SynchronizeFormsManager;
    RichardsCheckUI;
	end;
end;

procedure TContainer.UnloadActiveCellEditor;
var
  Editor: TEditor;
begin
  if (docEditor <> nil) then
    begin
      Editor := docEditor;
      docActiveCellChged := Editor.FModified;
      Editor.SaveChanges;
      docActiveCell.SetEditState(False);
      Editor.UnHilightCell;
      Editor.DeactivateEditor;
      Editor.UnLoadCell;
      docActiveCell.Display;
      FreeAndNil(Editor);
    end;
end;

(*
{ This code solves "loosing the font" issue when using auto-responses}
{ But it means the entire page will want to redraw and could take a lot}
{ of time and cause the delays in scrolling, etc.                    }
{ We need to find real cause of losing the font and size. }

procedure TContainer.UnloadActiveCellEditor;
var
  rectToRedraw: TRect;
begin
 if docEditor <> nil then
  begin
      docActiveCellChged := docEditor.FModified;
    docEditor.DeactivateEditor;        //no more blinking/text highlighting
   docActiveCell.SetEditState(False);  //tell cur cell to handle drawing
   docEditor.SaveChanges;           //saves to the current cell
      //docEditor.UnHilightCell;            //like its unhilighting
      rectToRedraw := docActiveCell.Cell2View;
   docEditor.UnLoadCell;
   docEditor.UnLoadCellRsps;

      docEditor.UnLoadCell;
   docActiveCell.Editor := nil;
      InvalidateRect(docView.Handle,@rectToRedraw,False);
  end;
end;
*)

Procedure TContainer.ProcessCurCell(PostProcess: Boolean);
begin
	if Assigned(docActiveCell) then
    begin
      StartProcessLists;
      if PostProcess then
        begin
          If docActiveCellChged then
            begin
              docActiveCell.PostProcess;      //let each cell type decide what to postProcess
//              FMunger.MungeCell(docActiveCell);   //JB- moved to Cell.ReplicateGlobal
            end;
        end
      else //Pre-Process (ie checkbox clicks need attention before clicking out
        begin
          If docActiveCellChged then
            docActiveCell.PreProcess;     //or preProcess
        end;

      ClearProcessLists;                  //clear any list of processed cells
    end;
end;

procedure TContainer.DebugRepLists;
var
  GStr, LStr: String;
begin
  Gstr := '0';
  LStr := '0';
  if assigned(FRepGlobalList) then
    GStr := IntToStr(FRepGlobalList.count);
  if assigned(FRepLocalList) then
    LStr := IntToStr(FRepLocalList.count);

  if assigned(docStatus) then
    docStatus.Panels[2].text := 'In use= '+ IntToStr(FProcessListCount) + ', Global = '+GStr + ' Local = '+LStr;
end;

function TContainer.CanProcessLocal(Cell: TBaseCell): Boolean;
begin
  if FRepLocalList = nil then
    FRepLocalList := TOBjectList.Create(False);    //False - do not own cells

  result := FRepLocalList.IndexOf(Cell) < 0;       //is it in list, no loops?
  if result then                                   //not in list
    FRepLocalList.add(cell);                       //add it for next inquiry - prevent loops

  result := result and IsAppPrefSet(bAutoTransfer);  //allow transfers
end;

function TContainer.CanProcessGlobal(Cell: TbaseCell): Boolean;
begin
  if FRepGlobalList = nil then
    FRepGlobalList := TOBjectList.Create(False);   //False - do not own cells

  result := FRepGlobalList.IndexOf(Cell) <0;       //is it in list, no loops?
  if result then                                   //not in list...
    FRepGlobalList.add(cell);                      //add it for next inquiry

//  if testSpecial then DebugRepLists;

  result := result and IsAppPrefSet(bAutoTransfer);
end;

function TContainer.CanProcessMath(Cell: TBaseCell): Boolean;
begin
  result := True;
end;

function TContainer.ReplicationInProgress: Boolean;
begin
  result := assigned(FRepGlobalList) or assigned(FRepLocalList);
end;

//StartProcess and ClearProcess need to be balanced in the same routine
procedure TContainer.StartProcessLists;
begin
  Inc(FProcessListCount);     //increment the count

//  if testSpecial then DebugRepLists;
end;

procedure TContainer.ClearProcessLists;
begin
  Dec(FProcessListCount);    //decrement the count

  if FProcessListCount = 0 then   //no one else is using it
    begin
      if Assigned(FRepLocalList) then
        FRepLocalList.Clear;
      if Assigned(FRepGlobalList) then
        FRepGlobalList.Clear;
    end;

//  if testSpecial then DebugRepLists;
end;

procedure TContainer.ShowCurCell;
var
	Pt: TPoint;
	View: TRect;
begin
	if docActiveCell <> nil then
		with docView do
			begin
        Pt := Point(0,0);
				View := docView.ClientRect;
				OffsetRect(View, HorzScrollBar.ScrollPos, VertScrollBar.ScrollPos);   //normalize to doc
				if not docActiveCell.InView(View, Pt) then      //each cell decides how to make itself visible
					MakePtVisible(Pt);    //if its not, cell returns Pt in doc coords so it can be made vis.
			end;
end;

//this call can get Cell Editor and FFT Editor mixed up
procedure TContainer.SaveCurCell;
begin
  //handle regular text entry
	if docActiveCell <> nil then
		if docEditor <> nil then
			if docEditor.Modified or docEditor.FormatModified then        //if there were changes
        begin
          docActiveCellChged := true;   //let ProcessCurCell know cell chged (JB-need a better way)
				  docEditor.SaveChanges;        //save anything in the editor
				  ProcessCurCell(True);         //do a postProcess
			  end
      else if docEditor.ResponsesModified then
        docEditor.SaveResponses;

  //handle annotation entry
  if assigned(docActiveItem) then
    if assigned(docEditor) then
      if docEditor.Modified or docEditor.FormatModified then
        docEditor.SaveChanges;        //save anything in the editor
end;

//Called by Cell.MouseDown to check if its a different cell being clicked
Procedure TContainer.MakeCurCell(Cell: TBaseCell);
var
  PrevCell: TBaseCell;
begin
  PrevCell := self.docActiveCell;
  if not Assigned(Cell.Editor) then
    Switch2NewCell(Cell, cClicked);
  // Perform all UAD cleanup processes
  UADPostProcess(Self, PrevCell, Cell);
end;

procedure TContainer.GoToPrevActiveCell;
var
  Cell: TBaseCell;
begin
  if not IsNullUID(docLastActCellUID) then
    begin
      Cell := GetCell(docLastActCellUID);
      if cell <> nil then
		    Switch2NewCell(Cell, cNotClicked);
    end;
end;

//JB- What is this?
procedure TContainer.CommitEdits;
var
  CurrentCell: TBaseCell;
  newCell: TBaseCell;
  newUID: CellUID;
begin
  if Assigned(docActiveCell) then
    begin
      CurrentCell := docActiveCell;
      if CurrentCell is TWordProcessorCell then      //fast fix for the exploding comment text bug:
        with CurrentCell.UID do                      //when we create PDF and active unsaved cell
          begin                                      // is World Processor cell
            newUID.FormID := FormID;                 //a line text occupyes whole page
            newUID.Form := Form;
            newUID.Occur := Occur;
            newUID.Pg := PG;
            newUID.Num := Num - 1;

            GetValidCell(newUID,newCell);
            Switch2NewCell(newCell,False);
          end
        else
          begin
            Switch2NewCell(nil, False);
            Switch2NewCell(CurrentCell, False);
          end;
    end;
end;

/// summary: Changes the active cell to the specified new cell.
/// remarks: Processing messages in this method will interfere with
///          click processing in dialog cells, causing dialogs to re-open
///          after being closed.  This behaviour occurs because the dialog editors
///          post a click message to the message queue when they are being loaded
///          in order to show the dialog after the entire cell group has
///          finished loading.  In summary, do not process messages here.
procedure TContainer.Switch2NewCell(newCell: TBaseCell; Clicked: Boolean);
var
	curFocus: TFocus;
	DC: HDC;
begin
 	DC := docView.Canvas.Handle;
	if docActiveCell <> nil then
		begin
			GetViewFocus(DC, curFocus);
			docActiveCell.FocusOnCell;
			UnloadActiveCellEditor;
      ProcessPriorSaleCells(Self, docActiveCell, UADEnabled);		//###JB
      ProcessSpecialCells(Self, docActiveCell, UADEnabled);		//###JB
			ProcessCurCell(True);
      docLastActCellUID := docActiveCell.UID;   //remember it
			docActiveCellChged := False;
			docActiveCell := nil;
      FreeAndNil(FShowCommentsForm);
			SetViewFocus(DC, curFocus);
      DoCellExit;
		end;

  if (NewCell <> nil) and (NewCell.EditorClass <> nil) then
		begin
			docActiveCellChged := False;
			docActiveCell := NewCell;									//this is the cell to edit
      if not Clicked then ShowCurCell;          //make sure its visible

			GetViewFocus(DC, curFocus);
			docActiveCell.FocusOnCell;
      ProcessGroupCellAdjs(Self, docLastActCellUID, UADEnabled);		//###JB
      LoadActiveCellEditor(clicked);            //load the editor for it.
			ProcessCurCell(False);
			SetViewFocus(DC, curFocus);
      DoCellEnter;
		end;

  //ProcessGroupCellAdjs(Self, docLastActCellUID, UADEnabled);		//###JB

end;

function TContainer.GetPageMinWidth: Integer;
var
	i, minWidth: Integer;
begin
	minWidth := docMinWidth;
	if docForm.count > 0 then
		for i := 0 to docForm.count-1 do
			minWidth := Max(minWidth, docForm.forms[i].frmSpecs.fFormWidth);
	result := minWidth;
end;

Procedure TContainer.SetModifiedFlag;
begin
	docDataChged := True;
  FModificationTime := Now;
  if Assigned(PageNavigator) then
    PageNavigatorUpdateTimer.Enabled := True;
end;

function TContainer.ReadContainerSpec(Stream: TStream; var numForms: Integer): Boolean;
var
	amt: Integer;
	DSpec: DocSpecRec;
  loWrd, hiWrd: Integer;
begin
	result := true;
	try
    //docProperty.ReadProperty(stream);     //we already red it in TMain.Open this file

		amt := SizeOf(DocSpecRec);           //now read doc specs
		Stream.Read(DSpec, amt);

		with DSpec do begin
			numForms := fNumForms;               //how many forms are in this file

      FLockCount := fNumLocks;
      if (FLockCount > 2) or (FLockCount < 0) then FLockCount := 0;   //####

      docUID := ffDocUID;                  //unique identifier
//      if docUID = 0 then                  //old files may have zero
//        docUID := GetUniqueID;            //so get a new ID

			docFont.Name :=  FFontName;
			docFont.Size :=  FFontSize;
			docFont.Color := FFontColor;
			docPref := FPrefFlags;
			docPageMgrWidth := FPageMgrWidth;
      FZoomScale := appPref_DisplayZoom;  //no processing yet, see if window is maximized in SetupContainer
//      FZoomScale := fScale;        //no processing yet, see if window is maximized in SetupContainer

			docView.HorzScrollBar.Position := FHScrollPos;
			docView.VertScrollBar.Position := FVScrollPos;

      //Set the last active cell (convert from Old CellUID to New
			docStartingCellUID.FormID :=	FActiveCell.FormID;                       //reset editor & cell
			docStartingCellUID.Form   :=	FActiveCell.Form;
      docStartingCellUID.Occur  := 0;
			docStartingCellUID.Pg     :=	FActiveCell.Pg;
			docStartingCellUID.Num    :=	FActiveCell.Num;

      //page numbering: Auto or Manual specs
      loWrd := NumXChg(FDispPgNums).LoWrd;
      if loWrd > 1 then loWrd := 0;           //clean up garbage, cannot be > 1
      hiWrd := NumXChg(FDispPgNums).HiWrd;
      if hiWrd > 1 then hiWrd := 0;           //clean up garbage, cannot be > 1

      docForm.FDisplayPgNums := (HiWrd = 0);  //set vars, no property - no processing
      docForm.FAutoPgNum  := (loWrd = 0);
      ManualStartPg := NumXChg(fPgNumbers).LoWrd;
		  ManualTotalPg := NumXChg(fPgNumbers).HiWrd;
		end;

    ReadDocSignatures(Stream);
    ReadDocDataItems(Stream);
    ReadDocCellAdjusters(Stream);
    ReadDocMungedText(Stream);

    ReadFutureData5(Stream);
    ReadFutureData6(Stream);
    ReadFutureData7(Stream);
    ReadFutureData8(Stream);
    ReadFutureData9(Stream);
    ReadFutureData10(Stream);
    ReadFutureData11(Stream);
    ReadFutureData12(Stream);
    ReadFutureData13(Stream);
    ReadFutureData14(Stream);
    ReadFutureData15(Stream);
    ReadFutureData16(Stream);
    ReadFutureData17(Stream);
    ReadFutureData18(Stream);
    ReadFutureData19(Stream);
    ReadFutureData20(Stream);
    ReadFutureData21(Stream);
    ReadFutureData22(Stream);
    ReadFutureData23(Stream);
    ReadFutureData24(Stream);
    ReadFutureData25(Stream);
    ReadFutureData26(Stream);
    ReadFutureData27(Stream);
    ReadFutureData28(Stream);
    ReadFutureData29(Stream);
    ReadFutureData30(Stream);

    ReadDocColors(Stream);       //skips the zero'ed data (for historical compatibility)
	except
		ShowNotice(errCannotReadSpec);
		result := False;
	end;
end;

function TContainer.ReadContainerSpec2(Stream: TStream; var numForms: Integer; bShowMessage:boolean=True): Boolean;
var
	amt: Integer;
	DSpec: DocSpecRec;
  loWrd, hiWrd: Integer;
begin
	result := true;
	try
    //docProperty.ReadProperty(stream);     //first read file property info

		amt := SizeOf(DocSpecRec);           //now read doc specs
		Stream.Read(DSpec, amt);

		with DSpec do begin
			numForms := fNumForms;               //how many forms are in this file

      FLockCount := fNumLocks;
      if (FLockCount > 2) or (FLockCount < 0) then FLockCount := 0;   //####

      docUID := ffDocUID;                  //unique identifier
//      if docUID = 0 then                  //old files may have zero
//        docUID := GetUniqueID;            //so get a new ID

			docFont.Name :=  FFontName;
			docFont.Size :=  FFontSize;
			docFont.Color := FFontColor;
			docPref := FPrefFlags;
			docPageMgrWidth := FPageMgrWidth;
      FZoomScale := appPref_DisplayZoom;  //no processing yet, see if window is maximized in SetupContainer
//      FZoomScale := fScale;        //no processing yet, see if window is maximized in SetupContainer

			docView.HorzScrollBar.Position := FHScrollPos;
			docView.VertScrollBar.Position := FVScrollPos;

      //Set the last active cell (convert from Old CellUID to New
			docStartingCellUID.FormID :=	FActiveCell.FormID;                       //reset editor & cell
			docStartingCellUID.Form   :=	FActiveCell.Form;
      docStartingCellUID.Occur  := 0;
			docStartingCellUID.Pg     :=	FActiveCell.Pg;
			docStartingCellUID.Num    :=	FActiveCell.Num;

      //page numbering: Auto or Manual specs
      loWrd := NumXChg(FDispPgNums).LoWrd;
      if loWrd > 1 then loWrd := 0;           //clean up garbage, cannot be > 1
      hiWrd := NumXChg(FDispPgNums).HiWrd;
      if hiWrd > 1 then hiWrd := 0;           //clean up garbage, cannot be > 1

      docForm.FDisplayPgNums := (HiWrd = 0);  //set vars, no property - no processing
      docForm.FAutoPgNum  := (loWrd = 0);
      ManualStartPg := NumXChg(fPgNumbers).LoWrd;
		  ManualTotalPg := NumXChg(fPgNumbers).HiWrd;
		end;
    try
      ReadDocSignatures2(Stream, bShowMessage);
      ReadDocDataItems(Stream);
      ReadDocCellAdjusters(Stream);
      ReadDocMungedText(Stream);
    except on E:Exception do
      result := False;
    end;
    ReadFutureData5(Stream);
    ReadFutureData6(Stream);
    ReadFutureData7(Stream);
    ReadFutureData8(Stream);
    ReadFutureData9(Stream);
    ReadFutureData10(Stream);
    ReadFutureData11(Stream);
    ReadFutureData12(Stream);
    ReadFutureData13(Stream);
    ReadFutureData14(Stream);
    ReadFutureData15(Stream);
    ReadFutureData16(Stream);
    ReadFutureData17(Stream);
    ReadFutureData18(Stream);
    ReadFutureData19(Stream);
    ReadFutureData20(Stream);
    ReadFutureData21(Stream);
    ReadFutureData22(Stream);
    ReadFutureData23(Stream);
    ReadFutureData24(Stream);
    ReadFutureData25(Stream);
    ReadFutureData26(Stream);
    ReadFutureData27(Stream);
    ReadFutureData28(Stream);
    ReadFutureData29(Stream);
    ReadFutureData30(Stream);

    ReadDocColors(Stream);       //skips the zero'ed data (for historical compatibility)
	except
    if bShowMessage then
		  ShowNotice(errCannotReadSpec);
		result := False;
	end;
end;

function TContainer.WriteContainerSpec(stream: TStream): Boolean;
var
	amt: Integer;
	DSpec: DocSpecRec;
begin
  //moved to DoSave function
  //docProperty.WriteProperty(stream);   //write property first,so others can tell what it is

	with DSpec do begin
		FNumForms := docForm.Count;        //number of forms in this file
    FNumLocks := FLockCount;           //lock count for this container
    FfDocUID := docUID;                //unique ID for this file (for tracking)

		FFontName := copy(docFont.Name, 1, cMax31Chars);
		FFontSize := docFont.Size;
		FFontColor := docFont.Color;
		FPrefFlags := docPref;
    FScale := ZoomFactor;      //do not use docView.ViewScale incase window is maximized

		FHScrollPos := 0;          //NOT USED docView.HorzScrollBar.DocPosition;
		FVScrollPos := 0;          //NOT USED docView.VertScrollBar.DocPosition;

    FActiveCell.FormID  := docActiveCell.UID.FormID;   		//remember the current cell
		FActiveCell.Form    := docActiveCell.UID.Form;         //convert form new cellUID to Old
		FActiveCell.Pg      := docActiveCell.UID.Pg;
		FActiveCell.Num     := docActiveCell.UID.Num;

		FPageMgrWidth := docPageMgrWidth;   	//width of goto list

    FNextSectionID := 1;   		 //ID for the version of the section following this rec

    {true = 1, but since file initially had zero & default is true, signify true with 0}
    NumXChg(fDispPgNums).LoWrd := Ord(not AutoPgNumber);
    NumXChg(fDispPgNums).HiWrd := Ord(not DisplayPgNums);
    NumXChg(fPgNumbers).LoWrd := ManualStartPg;
		NumXChg(fPgNumbers).HiWrd := ManualTotalPg;

(*
    fExtraC := 0;                      //### un-used extra long
    fExtra1 := 0;
		fExtra2 := 0;

    fDispPgNums
    fPgNumbers
*)
	end;

	amt := SizeOf(DocSpecRec);
	Stream.WriteBuffer(DSpec, amt);     //write doc spec

  WriteDocSignatures(Stream);
  WriteDocDataItems(Stream);
  WriteDocCellAdjusters(Stream);
  WriteDocMungedText(Stream);

  WriteFutureData5(Stream);
  WriteFutureData6(Stream);
  WriteFutureData7(Stream);
  WriteFutureData8(Stream);
  WriteFutureData9(Stream);
  WriteFutureData10(Stream);
  WriteFutureData11(Stream);
  WriteFutureData12(Stream);
  WriteFutureData13(Stream);
  WriteFutureData14(Stream);
  WriteFutureData15(Stream);
  WriteFutureData16(Stream);
  WriteFutureData17(Stream);
  WriteFutureData18(Stream);
  WriteFutureData19(Stream);
  WriteFutureData20(Stream);
  WriteFutureData21(Stream);
  WriteFutureData22(Stream);
  WriteFutureData23(Stream);
  WriteFutureData24(Stream);
  WriteFutureData25(Stream);
  WriteFutureData26(Stream);
  WriteFutureData27(Stream);
  WriteFutureData28(Stream);
  WriteFutureData29(Stream);
  WriteFutureData30(Stream);
 
  WriteDocColors(Stream);
	result := True;               //if we go to here we are fine
end;

(*
//write out this rec for each form
function TContainer.WriteFormSpec(stream: TFileStream; nForm: Integer): Boolean;
var
	i, amt, chk, nPage: Integer;
	FSpec: FormSpecRec;
begin
	FSpec.fFormUID := docForm[nForm].frmSpecs.fFormUID;				  {unique form identifer}
	FSpec.fFormVers := docForm[nForm].frmSpecs.fFormVers;				{revision no. of this form}
	FSpec.fFormName := copy(docForm[nForm].frmSpecs.fFormName, 1, cNameMaxChars);	{name of this form}
	FSpec.fNumPages:= docForm[nForm].frmSpecs.fNumPages;				{number of pages in form includes c-addms}
	FSpec.fFormFlags := docForm[nForm].frmSpecs.fFormFlags;			{32 flags to indiccate what data is in file}
	FSpec.fNextSectionID := 1;						 											{version id of the following page definition structure}

	for i := 1 to 20 do
		FSpec.ExtraSpace[i] := 0;																	//buffer for expanding the header}

	amt := SizeOf(FormSpecRec);
	stream.WriteBuffer(FSpec, amt);                      			//write the spec


	with docForm[nForm] do                                      // for this form
		for nPage := 0 to frmPage.Count-1 do											// and for each page...
			frmPage[nPage].WritePageData(stream);  								  // write the data to a file

	result := amt = chk;
end;
*)

//read this rec for each form in the countainer
function TContainer.ReadFormSpec(Stream: TStream; nForm, Version: Integer): Boolean;
var
	amt, PgErr, nPage: Integer;
	FSpec: FormSpecRec;
	formDesc: TFormDesc;
  AForm: TDocForm;
	fmUID: TFormUID;
begin
	result := True;                         //assume read is ok.
	try
		amt := SizeOf(FormSpecRec);
		Stream.Read(FSpec, amt);              //read the form spec

    //go get the form definition file that belongs to this data to display it
    fmUID := TFormUID.Create;             //create identifier object
		try
			fmUID.ID := FSpec.fFormUID;          // this is form ID
			fmUID.Vers := FSpec.fFormVers;       // its version number
			formDesc := ActiveFormsMgr.GetFormDefinition(fmUID);     //now go get it from cache or library

    //insert it (or placeholder) into container
			if formDesc <> nil then
				AForm := InsertFormDef(formDesc, True, -1)   //append it to the doc, expanded
			else  // No form available, just add the page data holder
				begin
          AForm := InsertForm(ActiveFormsMgr.GetFormPlaceHolder(FSpec.fFormUID, FSpec.fFormVers, FSpec.fNumPages), False, -1);
          showNotice('The form '+FSpec.fFormName + ' ID:'+IntToStr(FSpec.fFormUID)+ 'cannot be loaded. Please ensure you have access privileges to the form and that it is in the Forms Library.');
          result := False;
          exit;    //### We do not really want to exit
        end;

      Aform.Disabled := (FSpec.fLockCount <> 0);
		finally
			fmUID.Free;
		end;

    //now read the data into the form pages
    PgErr := -1;
    try
      //if file created with Form vs# = vs# of Form Def in Library then read normal
      if FSpec.fFormVers = AForm.frmInfo.fFormVers then
        begin
          with AForm do
            for nPage := 0 to frmPage.Count-1 do								 // read each page...
              begin
                inc(PgErr);                                      //if err, its this page
                frmPage[nPage].ReadPageData(stream, Version);  	 // read the data from the file
              end;
         // if FormLockCount > 0 then lock the cells
        end

      //if file created with Form vs# older than vs# of form in Library then try to convert to newer version
      else if FSpec.fFormVers < AForm.frmInfo.fFormVers then
        begin
          AForm.ConvertFormData(FSpec.fFormVers, Stream, Version);    //get conversion file, convert pages

          // if FormLockCount > 0 then lock the cells
        end

      //if file was created with Form vs# newer then vs# of form in Library, then skip the data
      else if FSpec.fFormVers > AForm.frmInfo.fFormVers then
        begin
          ShowNotice('The report was created using a newer version of the form '+FSpec.fFormName+'. The data will be skipped. Please update the Forms Library with the new version of the form.');
          //raise Exception.create('new file, older form');

          with AForm do
            for nPage := 0 to frmPage.Count-1 do											// for each page...
              begin
                inc(PgErr);
                frmPage[nPage].SkipPageData(stream, Version);  				// skip the data from the file
              end;
        end;
        FDocHasBookMarks := True;       //read in and added to GoTo Menu
    except
		 showNotice('There is a problem reading form #'+IntToStr(nForm+1)+', page #'+ IntToStr(PgErr+1)+ ' of '+FSpec.fFormName + '; ID:'+IntToStr(FSpec.fFormUID)+' V#'+IntToStr(FSpec.fFormVers));
		 result := False;
    end;

	except
		ShowNotice('There is a problem reading form name: '+FSpec.fFormName + ' ID:'+IntToStr(FSpec.fFormUID)+' V#'+IntToStr(FSpec.fFormVers));
		result := False;
	end;
end;


function TContainer.ReadFormSpec2(Stream: TStream; nForm, Version: Integer; bShowMessage:Boolean=True): Boolean;
var
	amt, PgErr, nPage: Integer;
	FSpec: FormSpecRec;
	formDesc: TFormDesc;
  AForm: TDocForm;
	fmUID: TFormUID;
begin
	result := True;                         //assume read is ok.
	try
		amt := SizeOf(FormSpecRec);
		Stream.Read(FSpec, amt);              //read the form spec

    //go get the form definition file that belongs to this data to display it
    fmUID := TFormUID.Create;             //create identifier object
		try
			fmUID.ID := FSpec.fFormUID;          // this is form ID
			fmUID.Vers := FSpec.fFormVers;       // its version number
			formDesc := ActiveFormsMgr.GetFormDefinition(fmUID);     //now go get it from cache or library

    //insert it (or placeholder) into container
			if formDesc <> nil then
				AForm := InsertFormDef2(formDesc, True, -1, bShowMessage)   //append it to the doc, expanded
			else  // No form available, just add the page data holder
				begin
          AForm := InsertForm2(ActiveFormsMgr.GetFormPlaceHolder(FSpec.fFormUID, FSpec.fFormVers, FSpec.fNumPages), False, -1, bShowMessage);
          if bShowMessage Then
            showNotice('The form '+FSpec.fFormName + ' ID:'+IntToStr(FSpec.fFormUID)+ 'cannot be loaded. Please ensure you have access privileges to the form and that it is in the Forms Library.');
          result := False;
          exit;    //### We do not really want to exit
        end;

      Aform.Disabled := (FSpec.fLockCount <> 0);
		finally
			fmUID.Free;
		end;

    //now read the data into the form pages
    PgErr := -1;
    try
      //if file created with Form vs# = vs# of Form Def in Library then read normal
      if FSpec.fFormVers = AForm.frmInfo.fFormVers then
        begin
          with AForm do
            for nPage := 0 to frmPage.Count-1 do								 // read each page...
              begin
                Application.ProcessMessages;
                //if escape key is hit, exit the loop
                if (GetKeyState(VK_Escape) AND 128) = 128 then
                  break;

                inc(PgErr);                                      //if err, its this page
                result := frmPage[nPage].ReadPageDataForImport(stream, Version, bShowMessage);  	 // read the data from the file
                if not result then
                  exit;
              end;
         // if FormLockCount > 0 then lock the cells
        end

      //if file created with Form vs# older than vs# of form in Library then try to convert to newer version
      else if FSpec.fFormVers < AForm.frmInfo.fFormVers then
        begin
          if AForm.ConvertFormData2(FSpec.fFormVers, Stream, Version, bShowMessage) then
            begin
              result := False;
              Exit;
            end   //get conversion file, convert pages

          // if FormLockCount > 0 then lock the cells
        end

      //if file was created with Form vs# newer then vs# of form in Library, then skip the data
      else if FSpec.fFormVers > AForm.frmInfo.fFormVers then
        begin
          if bShowMessage then
            ShowNotice('The report was created using a newer version of the form '+FSpec.fFormName+'. The data will be skipped. Please update the Forms Library with the new version of the form.')
          //raise Exception.create('new file, older form');
          else
          begin
            result := False;
            Exit;
          end;

          with AForm do
            for nPage := 0 to frmPage.Count-1 do											// for each page...
              begin
                inc(PgErr);
                frmPage[nPage].SkipPageData(stream, Version);  				// skip the data from the file
              end;
        end;
        FDocHasBookMarks := True;       //read in and added to GoTo Menu
    except
     if bShowMessage then
  		 showNotice('There is a problem reading form #'+IntToStr(nForm+1)+', page #'+ IntToStr(PgErr+1)+ ' of '+FSpec.fFormName + '; ID:'+IntToStr(FSpec.fFormUID)+' V#'+IntToStr(FSpec.fFormVers));
		 result := False;
    end;

	except
    if bshowMessage then
  		ShowNotice('There is a problem reading form name: '+FSpec.fFormName + ' ID:'+IntToStr(FSpec.fFormUID)+' V#'+IntToStr(FSpec.fFormVers));
		result := False;
	end;
end;
//invoked by the auto save timer
procedure TContainer.AutoSave(Sender: TObject);
begin
  if docDataChged then                                 //if something changed then save
    begin
      if docIsNew then
        begin
          Show;       //bring it to the top
          MessageBeep(MB_ICONEXCLAMATION);
        end;
      if assigned(docStatus) then docStatus.Panels[1].Text := 'Autosave in Progress';
      docAutoSave.Enabled := False;                    //disable so it does not continue
      FAutoSaving := True;                             //do not show progress bar
      Self.Save;
      FAutoSaving := False;

      ResetAutoSave;              //resume timing and reset interval

      if assigned(docStatus) then docStatus.Panels[1].Text := '';
    end;
end;

//reset from user response in app preferences
procedure TContainer.ResetAutoSave;
begin
	if docAutoSave = nil then
		docAutoSave := TTimer.Create(self);
	if docAutoSave <> nil then
		begin
			docAutoSave.Enabled := appPref_AutoSave;						//trun off/on
			docAutoSave.Interval := appPref_AutoSaveInterval;
			docAutoSave.OnTimer := AutoSave;
		end;
end;

function TContainer.DefaultFileName: String;
begin
  case appPref_DefFileNameType of
    fnUtitled:
      Result := docFileName;           //previously set to Untitled #N
    fnAddress:
      begin
        Result := GetCellTextByID(46);
//        Result := StripUnwantedCharForFileName(Result);//Ticket #1194 {Ticket #1226 ROLL BACK}
      end;
    fnFileNo:
      Result := GetCellTextByID(2);
    fnBorrower:
      Result := GetCellTextByID(45);
    fnInvoice:
      Result := GetCellTextByID(1255);     //added Oct 2006 for saving file as Invoice#
  else
    Result := docFileName;
  end;
  //fileNo or address were selected, but not entered
  if length(result) = 0 then
    Result := docFileName;
end;

{function TContainer.DoSave(fileStream: TFileStream): Boolean;
var
  memStream: TMemorystream;
begin
  result := True;
  try
    if WriteGenericIDHeader(fileStream, cDATAFile) then
      begin
        docProperty.WriteProperty(fileStream);
        memStream := TMemoryStream.Create;
        SaveContainer(memStream);
        if CompressAndEncryptStream(fileStream, memStream) then
          result := true ;
       end;
  except
    on E: Exception do
      begin
        ShowAlert(atStopAlert, errErrorOnWrite + ' Error: '+ E.Message);
        result := False;
      end;
  end;
  ResetAutoSave;
end;    }

function TContainer.DoSave(fileStream: TFileStream): Boolean;
var
  memStream, encrMemStream: TMemoryStream;
begin
  result := false;
  if docUID = docIDNonRecordable then    //what's new
    begin
      WriteGenericIDHeader(fileStream, cNEWSFile);
      docProperty.WriteProperty(fileStream);
      result := SaveContainer(fileStream);
      ResetAutoSave;
      exit;
    end;
  if WriteGenericIDHeader(fileStream, cDATAFile) then
    begin
      docProperty.WriteProperty(fileStream);
      memStream := TMemoryStream.Create;
      //encrMemStream := TMemorystream.Create;
      try
        try
          SaveContainer(memstream);
          memStream.Position := 0;
          {if CompressAndEncryptStream(memStream, encrMemStream) then
            result := true;  }
          result := EncryptStream_AES_ECB(memStream, StreamEncryptionPasswordDC);
          //memStream.Position := 0;
          memStream.SaveToStream(fileStream);
          ResetAutoSave;
        except
          result := false;
        end;
      finally
        memStream.Free;
        //encrMemStream.Free;
      end;
    end;
    if not Result then
      ShowAlert(atStopAlert, errErrorOnWrite);
  end;



function TContainer.Save: Boolean;
const
  cProblem = 'A problem was encountered during the save process.';
var
	saveOK: Boolean;
	docStream: TFileStream;
  TMPfPath: String;
  BAKfPath, BAK2fPath, BAKFileName: String;
begin
	saveOK := False;
  if docIsNew then
     saveOK := Self.SaveAs
  else
    begin
      PushMouseCursor(crHourglass);
      try
        SaveCurCell;            //Process changes in editor

        TmpfPath := GetFileTempName(docFileName);                            //get a temp filename
        TmpfPath := IncludeTrailingPathDelimiter(docFilePath) + tmpfPath;    //put in same place as docFile
        if CreateNewFile(TmpfPath, docStream)then			                 //create tmp file, open stream
          begin
            try
              docProperty.LoadPropertiesFromDoc;            //any new properties?
              docProperty.LastModified := Today;            //set today's date
              saveOK := doSave(docStream);
            finally
              docStream.Free;
            end;
          end;

         if saveOK then    //github #497: only do the backup if the flag is set
           begin
//             if appPref_SaveBackup then  //Ticket #1141: if bakup option is on, do backup
               begin
                 BAKfPath := ChangeFileExt(docFullPath,'.bak');   //create a .bak filename
                 if appPref_SaveBackup then
                   begin
                     if FileExists(BAKfPath) then  //if file exists
                       begin
                         if not DeleteFile(BAKfPath) then    //delete it
                            ShowNotice(cProblem + 'The backup file ' + ExtractFileName(BAKfPath) +
                                       ' cannot be deleted.');
                       end;
                   end;
                    if FileOperator.Rename(docFullPath, BAKfPath) then
                      begin
                        if FileOperator.Rename(TMPfPath, docFullPath) then
                          begin
                            docDataChged := False;
                            //Delete the backup if the user elected not to save backups
                            //Ticket #1141 : if the backup option is OFF don't even care to delete backup
                           // if not appPref_SaveBackup then
                           //   DeleteFile(BAKfPath)

                            //else move it to the backup folder
                                if ForceDirectories(appPref_DirReportBackups) then
                                  begin
                                    BAKFileName := ChangeFileExt(docFileName,'.bak');
                                    BAK2fPath := IncludeTrailingPathDelimiter(appPref_DirReportBackups) + BAKFileName;
                                    if FileExists(BAK2fPath) then  //Ticket #1141
                                      DeleteFile(BAK2fPath);                    //delete any previous backups for this file
                                    //if appPref_SaveBackup then //dont need this check here
                                    FileOperator.Move(BAKfPath, BAK2fPath);   //now move new file into the backup folder
                                   end;
                          end
                        else
                          ShowNotice(cProblem + 'Your original file is now ' + ExtractFileName(BAKfPath) +
                                     '. The new verison is named ' + ExtractFileName(tmpfPath) + '.');
                      end
                    else
                      ShowNotice(cProblem + 'The file ' + ExtractFileName(docFullPath) +
                                ' cannot be renamed to' + ExtractFileName(BAKfPath) + '.');
                  end;
          end;
      finally
        PopMouseCursor;
        if FileExists(TmpfPath) then  //if temp file exists, clean it up
          DeleteFile(TmpfPath);

      end;
  end;
	result := saveOK;
end;

function TContainer.SaveAs(toDropBox: Boolean): Boolean;
var
  Saved: Boolean;
  prefDir: String;
begin
	docSaveDialog.Title := 'Save "'+ docFileName + '" Report As';
  if docIsnew then
    docSaveDialog.FileName := DefaultFileName
  else
    docSaveDialog.Filename := docFileName;
	docSaveDialog.DefaultExt := 'clk';
   if toDropBox then
    prefDir := appPref_DirDropboxReports
   else
    prefDir := appPref_DirReports;
  ///< This is what John Wyatt use in canadian version to deal with temp files from e-mail >///
  ///< Version 7.2.2 05510 Jeferson Check to see if this was opened from email - stored >///
  ///< in the temporary internet folder. If so, default to the standard report folder >///
  if Pos('TEMPORARY INTERNET FILES', Uppercase(docFilePath)) > 0 then
      docSaveDialog.InitialDir := VerifyInitialDir(prefDir, prefDir)
  else
    if toDropbox then
      docSaveDialog.InitialDir := VerifyInitialDir(prefDir, docFilePath)   // dropbox reports is the first choice
    else
      docSaveDialog.InitialDir := VerifyInitialDir(docFilePath, prefDir);  //current place is preferable

	docSaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
	docSaveDialog.Filter := cSaveFileFilter;
	docSaveDialog.FilterIndex := 1;

  if docIsNew then
	  docSaveDialog.FileName := DefaultFileName
  else
    docSaveDialog.FileName := docFileName;

	if docSaveDialog.Execute then
    begin
      Saved := SaveAs(docSaveDialog.FileName);
		  appPref_DirLastSave := ExtractFilePath(docSaveDialog.FileName);

      if Saved then
        begin
          docFileName := ExtractFileName(docSaveDialog.FileName);
          docFilePath := ExtractFilePath(docSaveDialog.FileName);
          docFullPath := docSaveDialog.FileName;
          Main.UpdateMRUMenus(docFullPath);
          Caption := docFileName;
          docIsNew := False;
          docDataChged := False;
        end
		end
  else
    Saved := False;

  Result := Saved;
end;

function TContainer.SaveAs(const FileName: String): Boolean;
var
	Stream: TFileStream;
begin
  Result := False;
  Stream := nil;
  PushMouseCursor(crHourGlass);
  try
    if CreateNewFile(FileName, Stream) then
      begin
        if docUID <> docIDNonRecordable then    //keep special docUID (-1) for what's nrw report
          docUID := GetUniqueID;
        docProperty.LoadPropertiesFromDoc;
        docProperty.CreateDate := Today;
        docProperty.LastModified := Today;
        Recorded := False;

        if not docIsNew then begin
          docData.DeleteData(ddMSEstimateData);         //remove the BradfordSoftware Swift Estimator marker if there
          docData.DeleteData(ddAWMSEstimateData);       //remove the AppraisalWorld Swift Estimator marker if there
//          docData.DeleteData(ddRELSOrderInfo);        //comment out - no need to remove this docData
//          docData.DeleteData(ddRELSValidationUserComment);
//          docData.DeleteData(ddAWAppraisalOrder);
//          docData.DeleteData(ddAMCOrderInfo);
        end;

        SaveCurCell;
        Result := DoSave(Stream);
      end
    else
      Result := False;
  finally
    Stream.Free;
    PopMouseCursor;
    if not Result then
      DeleteFile(FileName);
  end;
end;

procedure TContainer.DeleteValidationForms;
var
  FormIdx: Integer;
  ValidationCommentFormUID: Integer;
begin
  ValidationCommentFormUID := AMCQualityChkFormUIDEn;
  if (ValidationCommentFormUID <> AMCQualityChkFormUIDAlt) and
     (GetFormIndex(AMCQualityChkFormUIDAlt) >= 0) then
    ValidationCommentFormUID := AMCQualityChkFormUIDAlt;
  repeat
    //if this report has prior commentary addendums then delete them
    FormIdx := GetFormIndexByOccur(ValidationCommentFormUID, 0);
    if (FormIdx >= 0) then
      DeleteForm(FormIdx);
  until FormIdx < 0;
end;

function TContainer.SaveAsTemplate: Boolean;
var
	saveIt: Boolean;
	docStream: TFileStream;
begin
	docSaveDialog.Title := msgSaveAsTemplate;
	if not docIsNew then
		docSaveDialog.FileName := GetNameOnly(docFileName);
	docSaveDialog.DefaultExt := 'cft';
  docSaveDialog.InitialDir := VerifyInitialDir(appPref_DirTemplates, appPref_DirLastSave);
	docSaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
	docSaveDialog.Filter := cSaveFileFilter;
	docSaveDialog.FilterIndex := 2;

	saveIt := False;
	if docSaveDialog.Execute then
		begin
			if CreateNewFile(docSaveDialog.FileName, docStream) then
				begin
          try
            docProperty.LoadPropertiesFromDoc;   //get the latest properties
            docProperty.CreateDate := Today;     //reset dates in case its a real Save As
            docproperty.LastModified := Today;   //dates normally set at doc create time
            docData.DeleteData(ddMSEstimateData);  //remove the BradfordSoftware Swift Estimator marker if there
            docData.DeleteData(ddAWMSEstimateData);  //remove the AppraisalWorld Swift Estimator marker if there
            docData.DeleteData(ddRELSOrderInfo);   //remove RELS Order Info
            docData.DeleteData(ddRELSValidationUserComment); //remove RELS commentary XML data
            docData.DeleteData(ddAMCOrderInfo);    //remove AMC Order Info
            {docData.ClearData - except sketcher data}
            SaveCurCell;                         //Process changes in editor
            // Remove any commentary forms from the report
            DeleteValidationForms;
            saveIt := doSave(docStream);
					finally
						docStream.Free;
            if saveIt then
              begin
                AppTemplates.Append(docSaveDialog.FileName);  //remember template for popup
                Main.BuildTempFilePopup;                      //update popmenu
              end;
					end;
				end
			else
				ShowNotice(errCannotCreateTemplate);
	end;
	result := saveIt;
end;

function TContainer.SaveFormatChanges: Boolean;
var
	f: Integer;
begin
  result := True;
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
      result := docForm[f].SaveFormatChanges;
end;

procedure TContainer.SetCellValue(aCell:TBaseCell);
var
  aGLA:Integer;
begin
  if aCell = nil then exit;
  
  if trim(aCell.Text) <> '' then
    begin
      aGLA := GetValidInteger(aCell.Text);
      aCell.SetValue(aGLA);
    end;
end;

procedure TContainer.SetGLAValues;
var
  aCell:TBaseCell;
begin
  aCell := GetCellByID(232); //GLA cellID for 340
  SetCellValue(aCell);

  aCell := GetCellByID(1004); //GLA cellID on sales grid
  SetCellValue(aCell);

  aCell := GetCellByID(1002); //GLA cell id on sales grid of 1025 form
  SetCellValue(aCell);

  aCell := GetCellByID(2249); //GLA cell id on rental grid of 1025 form
  SetCellValue(aCell);
end;

procedure TContainer.ImportText(Const TextFilename: String; isUnSystFormat: Boolean = false);
const
  actNone       = 0;
  actBroadcast  = 1;
var
	ImportF: TextFile;
	Str,aErrMsg: String;
	frm: TDocForm;
  frm2Broadcast: TDocForm;
  mergeData, firstForm, broadcastIt: Boolean;
  cmdID, frmID, InsID, ActID,OvrID: Integer;
  f: Integer;

  function LoadForm(FUID: Integer;ResetIndex:Boolean=False):TDocForm;
  var
    fID: TFormUID;
  begin
    fid := TformUID.Create;
    try
      fid.ID := FUID;
      result := InsertBlankUID(fID, True, -1);
      if ResetIndex then
        result.ResetImportIndexes;
    finally
      fID.free;
    end;
  end;

begin
  if FileExists(TextFilename) then
		try
      PushMouseCursor(crHourglass);
			AssignFile(ImportF, TextFilename);
			Reset(importF);
      try
        frm := nil;
        frm2Broadcast := nil;
        mergeData := False;
        firstForm := True;
        broadcastIt := False;
        cmdID := 0;
        frmID := 0;
        InsID := 0;
        ActID := 0;
        OvrID := 0;

        while not EOF(importF) do
          begin
            if not EOLN(importF) then          //hack because readLn does not read skips empty lines
              begin
                Read(importF, str);            //read the next string (this should be a Parser)
                Readln(importF);               //go to next line
              end
            else begin
              Readln(importF);
              str := '';
            end;

            if POS('CMD.', str)> 0 then           //check for commands
              begin
                frm := nil;                       //starting new form ???
                cmdID := 0;
                frmID := 0;
                InsID := 0;
                ActID := 0;
                OvrID := 0;
                if ParseCommand(str, CmdID, FrmID, InsID, ActID, OvrID) then  //Ticket #1284
                  case CmdID of
                    cLoadCmd:
                      begin
                        frm := LoadForm(FrmID);    //Load it
                        mergeData := False;        //signal no merge
                      end;
                    cMergeCmd:
                      begin
                        mergeData := True;
                        frm := docForm.GetFormByOccurance(FrmID, InsID-1); //occur is zero based
                        if frm = nil then
                          begin
                            frm := LoadForm(FrmID);    //nothng to merge, so load the form
                            mergeData := False;
                          end;
                      end;
                    cLoadOrderCmd:
                      begin
                        frm := LoadForm(FrmID);    //Load it
                        mergeData := False;        //signal no merge
                      end;
                    cImportCmd:
                      begin
                        frm := docForm.GetFormByOccurance(FrmID, 0); //occur is zero based
                        firstForm := False;
                        mergeData := False;
                      end;
                    cUploadCmd://PAM: Ticket #1284, set up new command Upload to keep the original Load/Merge as is for Data Master
                      begin
                        mergeData := True;
                        if InsID > 0 then
                          InsID := InsID - 1;
                        frm := GetFormByOccurance(FrmID, InsID, True);
                        if frm = nil then
                          begin
                            frm := LoadForm(FrmID,True);    //nothng to merge, so load the form
                            mergeData := False;
                          end
                        else
                          frm.ResetImportIndexes;
                      end;
                  end;
                  //trigger to catch the first form identified, we broadcast it
                  //this is for ClickNOTES to populate other forms
                  if firstForm then
                    begin
                      frm2Broadcast := frm;
                      broadcastIt := (actID = actBroadcast);
                      firstForm := False;
                    end;
              end

            else if (frm <> nil) and (frm.FormID <> 981) then        //else pass the string to the form
              begin
                // 113011 JWyatt Replace any line feed entity codes with the line feed character
                //  so comment text appears as it was entered.
                str := StringReplace(str, '&#10;', #10, [rfReplaceAll]);

                if isUnSystFormat then  //Set mergeData to true to keep contents some common cells like page name, comp No for comps and comp photos
                  frm.SetImportTextUnSystem(str, True, TextFilename,False)
                else
                begin
                  if CmdID = cLoadOrderCmd then
                    frm.SetImportText(str, mergeData, True)   //do cell post proccessing
                  else if CmdID = cUploadCmd then
                    begin
                      try
                        frm.SetImportText2(str, mergeData, True, OvrID=1);
                      except on E:Exception do
                        begin
                           aErrMsg := Format('We''re expieriencing some errors during importing this text: "%s" in Form #: %d.  Error: %s.  Please check your import text file.',
                                      [str,frm.FormID,e.Message]);
                           ShowAlert(atStopAlert,aErrMsg);
                           exit;
                        end;
                     end;   
                    end
                  else
                    frm.SetImportText(str, mergeData, False);   //let the form place the text properly
                 end;

              end;

          end; //while loop
          SetGLAValues; //hacking: have to call setvalue again for GLA to have the formatting to include ","
          if cmdid =  cUploadCmd then //do this for Upload mode only
            begin
              for f := 0 to docForm.Count - 1 do
                if assigned(docForm[f]) and docForm[f].MainForm then
                  begin
                    BroadcastFormContext(docForm[f]);
                  end;
             end;
          //when done importing, do we broadcast new data?
          if broadcastIt and (frm2Broadcast <> nil) then
            BroadcastPageContext(frm2Broadcast.frmPage[0]);

        except
          ShowNotice('There is a problem reading import file, "'+ TextFilename + '".');
        end;
    finally
      CloseFile(importF);
      docView.Invalidate;   //redraw the screen.
      PopMouseCursor;
		end
  else
    ShowNotice('The import file, "'+ TextFilename + '", cannot be found.');
end;


//move this main
procedure TContainer.ImportFromFile(fileCmd: Integer);
begin
	docOpenDialog.InitialDir := VerifyInitialDir(appPref_DirLastOpen, '');
	docOpenDialog.DefaultExt := 'txt';
	docOpenDialog.Filter := 'Text Files(.txt)|*.txt';
	docOpenDialog.Options := [ofExtensionDifferent, ofFileMustExist, ofEnableSizing];
	if docOpenDialog.execute then
    begin
      case fileCmd of
        cmdFileImport: ImportText(docOpenDialog.Filename);
        cmdFileUSystemImport: ImportText(docOpenDialog.Filename, true);
      end;
      appPref_DirLastOpen := ExtractFilePath(docOpenDialog.FileName);
    end;
end;

function TContainer.ExportToFile(fileName: String; exportMode: Integer): Boolean;
var
	ExportF: TextFile;
	nForm, nPage: Integer;
	FormStr: String;
begin
  result := True;
  try
    ReWrite(ExportF, FileName);      //create a new file
    try
      for nForm := 0 to docForm.count-1 do         // for each form do...
        with docForm[nForm] do                     // for this form
        begin
          case exportMode of
            cLoadCmd:
              FormStr := 'CMD.LOAD.F'+IntToStr(frmSpecs.fFormUID);      //id the form so we can load it when importing
            cMergeCmd:
              FormStr := 'CMD.MERGE.F'+IntToStr(frmSpecs.fFormUID);
            cImportCmd:
              FormStr := 'CMD.POPIN.F'+IntToStr(frmSpecs.fFormUID)
          else
            FormStr := 'CMD.LOAD.F'+IntToStr(frmSpecs.fFormUID);
          end;
          WriteLn(ExportF, FormStr);

          for nPage := 0 to frmPage.Count-1 do		 		// and for each page...
            frmPage[nPage].WritePageText(exportF);  // write the text to a file
        end;
    except
      showNotice(errCannotExport);
      result := False;
    end;
  finally
    CloseFile(ExportF);                            //close it
  end;
end;

procedure TContainer.ExportToXSites;
var
  PreviousFormat: TFileFormat;
begin
  PreviousFormat := FileFormat;
  docSaveDialog.Title := 'Export "'+ ExtractFileName(docFileName) + '" As';
  docSaveDialog.DefaultExt := 'clk';
  docSaveDialog.InitialDir := VerifyInitialDir(docFilePath, appPref_DirReports);
  docSaveDialog.Options := [ofOverwritePrompt, ofEnableSizing];
  docSaveDialog.Filter := cExportXSitesFilter;

  if docIsNew then
    docSaveDialog.FileName := ChangeFileExt(ExtractFileName(DefaultFileName), '') + '_XSites'
  else
    docSaveDialog.Filename := ChangeFileExt(ExtractFileName(docFileName), '') + '_XSites';

  if docSaveDialog.Execute then
    try
      FileFormat := ffClickFORMS6;
      SaveAs(docSaveDialog.FileName);
      appPref_DirLastSave := ExtractFilePath(docSaveDialog.FileName);
    finally
      FileFormat := PreviousFormat;
    end;
end;

function TContainer.SaveContainer(stream: TStream): Boolean;
var
	n: Integer;
	saveOK : Boolean;
begin
	saveOK := False;
  if (docForm.count > 15) and not FAutoSaving then
    DisplayProgressBar('Saving Report Progress', docForm.TotalPages);
	try
		WriteContainerSpec(stream);             // write the doc spec, prefs, etc
    for n := 0 to docForm.count-1 do        // for each form
      docForm[n].WriteFormData(Stream);     //used to be WriteFormSpec(stream, nForm)
    saveOK := True;
  finally
    RemoveProgressBar;
    result := SaveOK;
  end;
end;

function TContainer.LoadContainer(stream: TStream; Version: Integer): Boolean;
var
	nForm, NumForms: Integer;
begin
	result := False;    //readOK
  PushMouseCursor(crHourglass);
	if assigned(stream) then
		try
			result := ReadContainerSpec(stream, numForms);

      if (numForms > 15) then
        DisplayProgressBar('Reading Report Progress', numForms);

      //--------------------------
      //eventually put in UDocForms
      //for nForms := 1 to NumForms do
      //  Create the form
      //  read the form def
      //  read the form data
      //--------------------------
      IncrementProgressBar; // take the lead
			for nForm := 0 to NumForms-1 do     //now read each form description
        begin
          result := ReadFormSpec(stream, nForm, Version);
          IncrementProgressBar;
          if not result then Exit;
        end;

			docForm.RenumberPages;  						// renumber all pages in list
      docForm.SetupTableContentPages;     // index the table of content pages
			BuildContentsTable;                 // build the table of contents
      DisplayPageCount;                   // Show the current page count in status bar
      UpdateToolbarButtons;
      docView.Refresh;
      SchemaVersion.Refresh;              //reads Version info - what for??

     // if appPref_ImageAutoOptimization then     not optimaze images on opening
       // OptimizeAllImages;    //optimize all images to 100 pixel

      Dispatch(DM_LOAD_COMPLETE, DMS_DOCUMENT, nil);   //sends msg that load is complete
    finally
      RemoveProgressBar;
      PopMouseCursor;
		end;
end;

{ not used any more
//github 71: Automatically optimize all images in the container base on the settings
procedure TContainer.OptimizeAllImages(ResetOptimized:Boolean=False);
var
  mf: TMetafile;
  imgSize: double; //megapixels
  imgEditor: TImageEditor;
  origHigh, origMed, origLow: Boolean;
  origUseCellSize: Boolean;
begin
  //PAM: try to reduce image size by using TImageEditor object.
  imgEditor := TImageEditor.Create(nil);
  try
    try
      imgEditor.RunInBackground := True;    //github 306, turn this flag on
      imgEditor.Doc := self;  //causes the images to load
      imgEditor.ResetOptimized := ResetOptimized;  //github 306, when we load from file set to true
      //save the existing settings in image editor
      origHigh := imgEditor.rdoHighQuality.Checked;
      origMed  := imgEditor.rdoMedQuality.Checked;
      origLow  := imgEditor.rdoLowQuality.Checked;
      origUseCellSize := imgEditor.ckbUseCellSize.Checked;

      case appPref_ImageQuality of
        1: imgEditor.rdoHighQualityClick(imgEditor.rdoHighQuality);
        2: imgEditor.rdoMedQualityClick(imgEditor.rdoMedQuality);
        3: imgEditor.rdoLowQualityClick(imgEditor.rdoLowQuality);
      end;
      imgEditor.ckbUseCellSize.Checked := appPref_ImageUseCellSize;
      imgEditor.btnOptimizeAll.Click;
      imgEditor.btnSave.Click;
    except
      ShowAlert(atWarnAlert, 'A problem was encountered while optimizing the images.');
    end;
  finally
    //We're done.  Put back the original settings.
    imgEditor.rdoHighQuality.Checked := origHigh;
    imgEditor.rdoMedQuality.Checked  := origMed;
    imgEditor.rdoLowQuality.Checked  := origLow;
    FreeAndNil(imgEditor); //get rid of the object to free memory
  end;
end;    }

//CorelLoic Mismo XML delivery at present is not part of common AMC Workflow delibery
//so it does not have frame interface, just a warning 'Do you want...?'
function TContainer.OptimizeReportImages(optDPI: Integer; formList: BooleanArray): Integer;
var
  nImgs: Integer;
  f, p, c: Integer;
  origMemSize, optMemsize: integer;
  cell: TBaseCell;
  frmSelected: Boolean;
begin
  nImgs := ImagesToOptimize(optDPI, formList);
  if nImgs = 0 then
    exit;
   result := 0;
   for f := 0 to docForm.count-1 do
   begin
    if not assigned(formList) then
      frmSelected := true
    else
      frmSelected := formList[f];
    if frmSelected then
      for p := 0 to docForm[f].frmPage.count-1 do
        if assigned(docForm[f].frmPage[p].PgData) then
          for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
            begin
              cell := docForm[f].frmPage[p].PgData[c];
              if CellImageCanOptimized(cell,optDPI) then
                with TGraphicCell(cell) do
                begin
                  origMemSize := 0;
                  optMemSize := 0;
                  if OptimizeCellImage(optDPI, origMemSize, optMemSize) then
                    inc(result, origMemSize - optMemSize);
                end;
            end;
          next;
      next;
   end;
end;


function TContainer.LoadContainerForImport(stream: TFileStream; Version: Integer; bshowMessage:Boolean=True): Boolean;
var
	nForm, NumForms: Integer;
  encrMemstream, memStream: TMemoryStream;
begin
	result := False;    //readOK
  if stream.Handle >= 0 then
    begin
      docProperty.ReadProperty(stream);
      encrMemStream := TMemoryStream.Create;
      memStream := TMemoryStream.Create;
      try
        try
          encrMemstream.CopyFrom(stream, stream.Size - stream.Position);
          encrMemstream.Position := 0;
          case GetFileEncryptType(stream)of
                0: memStream.CopyFrom(encrMemStream,0);   //not encrypted
                1: if not DeCompressAndDecryptStream(encrMemStream,memStream) then //old encyption: EasyCompression
                    begin
                      ShowAlert(atStopAlert, errCannotOpenFile);
                      exit;
                    end;
                2: if DecryptStream_AES_ECB(encrMemstream, StreamEncryptionPasswordDC) then
                      memstream.CopyFrom(encrMemstream,0)
                    else
                      begin
                        ShowAlert(atStopAlert, errCannotOpenFile);
                        exit;
                      end;
               end;
          memStream.Position := 0;
          try
            result := ReadContainerSpec2(memStream, numForms, bShowMessage);
          except on E:Exception
            do result := False;
          end;
          for nForm := 0 to NumForms-1 do     //now read each form description
            begin
              Application.ProcessMessages;
              if (GetKeyState(VK_Escape) AND 128) = 128 then
                break;
              try
                result := ReadFormSpec2(memStream, nForm, Version, bShowMessage);
              except on E:Exception
                do result := False;
              end;
              if not result then break;
            end;
          if not result then exit;
          docForm.RenumberPages;  						// renumber all pages in list
          docForm.SetupTableContentPages;     // index the table of content pages
          BuildContentsTable;                 // build the table of contents
          DisplayPageCount;                   // Show the current page count in status bar
          UpdateToolbarButtons;
          docView.Refresh;
          SchemaVersion.Refresh;              //reads Version info - what for??
          Dispatch(DM_LOAD_COMPLETE, DMS_DOCUMENT, nil);   //sends msg that load is complete
        except on E:Exception do
  	      result := False;
        end;
      finally
        RemoveProgressBar;
        PopMouseCursor;
        encrMemStream.Free;
        memStream.Free;
      end;
    end;
end;


procedure TContainer.InsertDocForm(ADocForm: TDocForm; Index: Integer);
var
	n,nPgs : integer;
  fUID: TFormUID;
  formDesc: TFormDesc;
  newForm: TDocForm;
begin
  if assigned(ADocForm) then
    begin
      fUID := TFormUID.Create(ADocForm.FormID);
      formDesc := ActiveFormsMgr.GetFormDefinition(fUID);   // find it first
      newForm := InsertForm(formDesc, True, -1{Index});    	//append the form definition
      nPgs := newForm.GetNumPages;
      for n := 0 to nPgs-1 do     // add the view controls (Title, DisplayPanel, Toggle)
        begin
          newForm.frmPage[n].Assign(ADocForm.frmPage[n]);
        end;
      fUID.Free;
    end;
end;

function TContainer.MergeContainer(stream: TFileStream; Populate, MergeAllForms: Boolean; Version: Integer): Boolean;
var
  tmpDoc: TContainer;
  tmpForm: TDocForm;
  n, numForms: Integer;
  formKind: Integer;
  encrMemStream, memStream: TMemoryStream;
begin
	result := True;    //readOK
  tmpDoc := TContainer.CreateMinimized(nil);
  PushMouseCursor(crHourglass);
  try
    if stream.Handle >= 0 then
      begin
        tmpDoc.docProperty.ReadProperty(stream);
        memStream := TMemoryStream.Create;
        encrMemStream := TMemoryStream.Create;
        try
          try
            encrMemStream.CopyFrom(stream, stream.Size - Stream.Position);
            encrMemstream.Position := 0;
            case GetFileEncryptType(stream)of
                0: memStream.CopyFrom(encrMemStream,0);   //not encrypted
                1: if not DeCompressAndDecryptStream(encrMemStream,memStream) then //old encyption: EasyCompression
                    begin
                      ShowAlert(atStopAlert, errCannotOpenFile);
                      exit;
                    end;
                2: if DecryptStream_AES_ECB(encrMemstream, StreamEncryptionPasswordDC) then
                      memstream.CopyFrom(encrMemstream,0)
                    else
                      begin
                        ShowAlert(atStopAlert, errCannotOpenFile);
                        exit;
                      end;
               end;
            memStream.Position := 0;
            result := tmpDoc.ReadContainerSpec(memStream, numForms);

            if (numForms > 15) then
              DisplayProgressBar('Reading Report Progress', numForms);

            for n := 0 to numForms-1 do     //read each form
              begin
                result := tmpDoc.ReadFormSpec(memStream, n, Version);
                //if not result then Exit;
              end;

            numForms := tmpDoc.docForm.count;
            for n := 0 to numForms-1 do
            begin
              tmpForm := tmpDoc.docForm[n];
              formKind := tmpForm.frmInfo.fFormKindID;
              if ((tmpForm.FormID = AMCQualityChkFormUIDEn) or
                     (tmpForm.FormID = AMCQualityChkFormUIDAlt)) then
                tmpDoc.docData.DeleteData(ddAMCValidationUserComment)
              else
                begin
                  if MergeAllForms then
                    InsertDocForm(tmpForm, -1)
                  {do not merge in Invoices and Orders from previous appraisals}
                  else if {(formKind <> fkInvoice) and} (formKind <> fkOrder) then
                    InsertDocForm(tmpForm, -1);
                  if Populate then
                    PopulateFormContext(tmpForm);
                end;
            end;

            if (tmpDoc.docSignatures.Count > 0) then
              ShowAlert(atInfoAlert, msgAppendWithoutSignatures);

            Dispatch(DM_LOAD_COMPLETE, DMS_DOCUMENT, nil);          // notify that we're merged
            Dispatch(DM_CONFIGURATION_CHANGED, DMS_DOCUMENT, nil);  // reset the configuration
          except
            ShowNotice('There is a problem merging the document.');
          end;
        finally
          encrMemStream.Free;
          memStream.Free;
        end;
      end;
  finally
    RemoveProgressBar;
    PopMouseCursor;
    tmpDoc.Free;
  end;
end;

procedure TContainer.InstallBookMarkMenuItems;
var
  f: Integer;
begin
  if assigned(docForm) then
    begin
      for f := 0 to docForm.count-1 do
        docForm[f].InstallBookMarkMenuItems;
      FDocHasBookMarks := True;
    end;
end;

procedure TContainer.RemoveBookMarkMenuItems;
var
  f: Integer;
begin
  if assigned(docForm) then              //docForm nay =nil when closing
    begin
      for f := 0 to docForm.count-1 do
        docForm[f].RemoveBookMarkMenuItems;
      FDocHasBookMarks := False;
    end;
end;

procedure TContainer.DoIdleEvents;
begin
  if not Locked then
    begin
      if (docEditor <> nil) then
        docEditor.IdleEditor;

      // IdleEditor can sometimes free the editor
      if (docEditor <> nil) then
      begin
        if ((not FTextOverflowed) or UADOverflowCheck) and docEditor.TextOverflowed and CanLinkComments then
          // Was: if not FTextOverflowed and docEditor.TextOverflowed and CanLinkComments then
          begin
            FTextOverflowed := True;
            HandleTextOverflow;
          end;
      end;
      UADOverflowCheck := False;  // make sure the UAD overflow check flag is false
    end;
end;


//=======================================================
// Debug Routines and Form Modifying routines (Rsp and Cell IDs)
procedure TContainer.ClearDocText;
var
	f: Integer;
begin
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
      docForm[f].ClearFormText;
end;

procedure TContainer.ClearDocSketches;
var
  skCells: cellUIDArray;
  cntr: Integer;
  curCell: TBaseCell;
begin
  setlength(skCells,0);
  skCells := GetCellsByID(cidSketchImage);
  if length(skCells) = 0 then
    exit;
  for cntr := low(skCells) to high(skCells) do
    begin
      curCell := GetCell(skCells[cntr]);
      if assigned(curCell) and (curCell is TSketchCell) then
        with TGraphicCell(curCell) do
          begin
            Clear;  //erase image
            if assigned(FMetaData) then
              begin    //clear MetaData
                FreeAndNil(FMetaData);
              end;
          end;
    end;
end;


procedure TContainer.DebugSetCellIDs;
var
  CellIDList: TFormCellID;
begin
  try
    CellIDList := TFormCellID.Create(application);
    CellIDList.show;
  except
    ShowNotice('There is an error displaying the cell ID list');
  end;
end;

procedure TContainer.DebugSetRspIDs;
var
  RspIDList: TFormRspID;
begin
  try
    RspIDList := TFormRspID.Create(application);
    RspIDList.show;
  except
    ShowNotice('There is an error displaying the cell response ID list');
  end;
end;

procedure TContainer.DebugShowCellAttribute(Value: Integer);
var
	f,p: Integer;
begin
	if docForm.count > 0 then
		for f := 0 to docForm.count-1 do
			for p := 0 to docForm[f].frmPage.Count -1 do
				with TDocPage(docForm[f].frmPage[p]) do
					begin
            DebugDisplayCellAttribute(value);
						InvalidatePage;
					end;
end;

procedure TContainer.SetupCellJustMenu(JustM, LeftM, CntrM, RightM: TMenuItem);
var
  format: ITextFormat;
begin
	//menus are disabled before coming in here
  if Supports(docEditor, ITextFormat, format) then
		begin
			JustM.enabled := format.CanFormatText;
			LeftM.checked := (format.TextJustification = tjJustLeft);
			CntrM.checked := (format.TextJustification = tjJustMid);
			RightM.checked := (format.TextJustification = tjJustRight);
		end;
end;

procedure TContainer.SetupCellStyleMenu(StyleM, BoldM, ItalicM, UnderLine: TMenuItem);
var
  format: ITextFormat;                         ///< Add Under Line May/05/2010 was miss in 7.2.1 >///
begin
	//menus are disabled before coming in here
  if Supports(docEditor, ITextFormat, format) then
		begin
      StyleM.enabled := format.CanFormatText;
      BoldM.enabled := format.CanFormatText;
      ItalicM.enabled := format.CanFormatText;
      UnderLine.enabled := format.CanFormatText;
      BoldM.checked := (format.Font.StyleBits and tsBold = tsBold);
      ItalicM.checked := (format.Font.StyleBits and tsItalic = tsItalic);
      UnderLine.checked := (format.Font.StyleBits and tsUnderLine = tsUnderline);
		end;
end;

procedure TContainer.SetupCellFontSizMenu(FSizM, smallerM, curSizM, largerM: TMenuItem);
var
  format: ITextFormat;
begin
	//menus are disabled before coming in here
  if Supports(docEditor, ITextFormat, format) then
		begin
			FSizM.enabled := format.CanFormatText;
      smallerM.enabled := format.CanFormatText and (format.Font.Size > format.Font.MinSize);
      curSizM.enabled := format.CanFormatText;
      largerM.enabled := format.CanFormatText and (format.Font.Size < format.Font.MaxSize);
			smallerM.caption := IntToStr(format.Font.Size - 1);
			smallerM.Tag := format.Font.Size - 1;
			curSizM.caption := IntToStr(format.Font.Size);
			curSizM.tag := format.Font.Size;
			largerM.caption := IntToStr(format.Font.Size + 1);
			largerM.Tag := format.Font.Size + 1;
		end;
end;

procedure TContainer.SetupCellEditRspMenu(EditRspMenu: TMenuItem);
begin
	if docEditor <> nil then
		if (docEditor is TTextEditor) then    //we have text cell
			begin
				EditRspMenu.Enabled := not docEditor.RspsVisible and docEditor.CanEdit; //active only if not already up
				if (docEditor is TMLEditor) or (docEditor is TWordProcessorEditor) then
					EditRspMenu.Caption := 'Edit Comments'
				else
					EditRspMenu.Caption := 'Edit Responses';
			end;
end;

procedure TContainer.SetupCellShowRspMenu(ShowRspMenu: TMenuItem);
begin
	if (docEditor is TTextEditor) then    //we have text cell
		begin
			ShowRspMenu.enabled := not docEditor.RspsVisible and docEditor.CanEdit; //active only if not already up
			if (docEditor is TMLEditor) or (docEditor is TWordProcessorEditor) then
				ShowRspMenu.Caption := 'Show Comments'
			else
				ShowRspMenu.Caption := 'Show Responses';
		end;
end;

procedure TContainer.SetupCellSaveRspMenu(SaveRspMenu: TMenuItem);
begin
	if (docEditor is TTextEditor) then    //we have text cell
		begin
			SaveRspMenu.enabled := docEditor.HasContents;
			if (docEditor is TMLEditor) or (docEditor is TWordProcessorEditor) then
				SaveRspMenu.Caption := 'Save Comment'
			else
				SaveRspMenu.Caption := 'Save as Response';
		end;
end;

procedure TContainer.SetViewPageListMenu(FmMgrMenu: TMenuItem);
begin
	FmMgrMenu.Enabled := True;
	if IsBitSet(docPref, bShowPageMgr) then
		FmMgrMenu.Caption := 'Hide Forms Manager'
	else
		FmMgrMenu.caption := 'Show Forms Manager';
end;

procedure TContainer.ShowCellResponses;
var
	cell: TBaseCell;
begin
	if (docForm.count > 0) then
		if docActiveCell <> nil then
			begin
				cell := docActiveCell;
				if (cell is TTextCell) then
					begin
						TSLEditor(Cell.Editor).AutoRspOn := True;        //fake editor into AutoRsp
					end
				else if (Cell.Editor is TTextEditor) then
					begin
            if not Assigned(FShowCommentsForm) then
						  FShowCommentsForm := TShowCmts.Create(self);

            FShowCommentsForm.LoadCommentGroup(Cell.Editor as TTextEditor);
						FShowCommentsForm.Show;       //it floats on top
					end;
			end;
end;

procedure TContainer.EditCellResponses;
var
	cell: TBaseCell;
begin
	if (docForm.count > 0) then
		if docActiveCell <> nil then
      if not IsBitSet(TBaseCell(docActiveCell).CellPref, bNoEditRsps) then
        begin
          cell := docActiveCell;
          if (cell is TTextCell) then
            begin
              EditRsps := TEditRsps.Create(self);
              try
                EditRsps.RspItems := TSLEditor(Cell.Editor).FRsps.Items;   						//load them
                if (EditRsps.ShowModal = mrOK) then                   									//edit them
                  if EditRsps.Modified then                                           	//if changed
                    begin
                      TSLEditor(Cell.Editor).FRsps.UpdateItems := EditRsps.RspItems; 		//save them
                   //   Cell.Modified := True;  //tell doc we have changed
                    end;
              finally
                FreeAndNil(EditRsps);
              end;
            end
          else if (Cell is TMLnTextCell) or (Cell is TWordProcessorCell) then
            begin
              EditCmts := TEditCmts.Create(nil);
              try
                EditCmts.LoadCommentGroup(Cell.FResponseID);
                If (EditCmts.ShowModal = mrOK) then                   //edit them
                  if EditCmts.Modified then
                    EditCmts.SaveCommentGroup;
              finally
                FreeAndNil(EditCmts);
              end;
            end;
        end
      else
        ShowAlert(atWarnAlert, msgNoEditRsps);
end;

procedure TContainer.SaveCellResponses;
begin
	if (docForm.count > 0) then
		if docActiveCell <> nil then
      if not IsBitSet(TBaseCell(docActiveCell).CellPref, bNoEditRsps) then
        begin
          if (docActiveCell is TTextCell) then
            TSLEditor(docActiveCell.Editor).SaveToRspList(nil)      //Single line rsps
          else if (docActiveCell is TMLnTextCell) then
            TMLEditor(docActiveCell.Editor).SaveToRspList(nil)      //multi-line rsps
          else if (docActiveCell is TWordProcessorCell) then
            (docActiveCell.Editor as TWordProcessorEditor).SaveToRspList(nil);
        end
      else
        ShowAlert(atWarnAlert, msgNoEditRsps);
end;

procedure TContainer.SetCellPreferences;
var
  CPref: TCellPref;
begin
	if (docEditor <> nil) and (ActiveLayer = alStdEntry) then
		begin
			CPref := TCellPref.Create(self, docEditor);  //Application
			try
				if CPref.ShowModal = mrOK then
					begin
						CPref.SaveChanges;
            // 060211 JWyatt Add the following to ensure that settings for restricted
            //  UAD cells are reset to their required settings.
            if Self.UADEnabled then
              SetUADCellFmt(docEditor, docActiveCell);
					end;
			finally
				FreeAndNil(CPref);
			end;
		end;
end;

procedure TContainer.SaveCellImageToFile;
begin
  if assigned(docEditor) and (ActiveLayer = alStdEntry) then
    TGraphicEditor(docEditor).SaveImageToFile(nil);
end;

procedure TContainer.SetAllCellsTextSize(value: Integer);
var
  f: Integer;
  format: ITextFormat;
begin
  if docForm.count > 0 then
    begin
      for f := 0 to docForm.count-1 do
        docForm[f].SetAllCellsTextSize(Value);

      if Supports(docEditor, ITextFormat, format) then
				format.Font.Size := value;
    end
end;

procedure TContainer.SetAllCellsFontStyle(fStyle: TFontStyles);
var
  f: Integer;
  format: ITextFormat;
begin
  if docForm.count > 0 then
    begin
      for f := 0 to docForm.count-1 do
        docForm[f].SetAllCellsFontStyle(fStyle);

      if Supports(docEditor, ITextFormat, format) then
        format.Font.Assign(docFont);
   end
end;

procedure TContainer.SetGlobalCellFormating(doIt: Boolean);
var
  f: Integer;
begin
  try
    if doIt then
      if docForm.count > 0 then
        begin
          for f := 0 to docForm.count-1 do
            docForm[f].SetGlobalCellFormating(doIt);
        end;
  except
    ShowNotice('A problem was encountered while trying to set the new formats.');
  end;
end;

procedure TContainer.EditFontSize(FontSiz: Integer);
var
  format: ITextFormat;
begin
	if Supports(docEditor, ITextFormat, format) then
    begin
      if (docActiveCell <> nil) or (docActiveItem <> nil) then
        if (FontSiz = 1) or (FontSiz = -1) then
          format.Font.Size := format.Font.Size + fontSiz
        else
          format.Font.Size := fontSiz;
    end;
end;

/// summary: Toggles showing the page navigator.
procedure TContainer.ShowPageNavigator;
var
  Navigator: TPageNavigator;
begin
  Navigator := PageNavigator as TPageNavigator;
  if not Assigned(Navigator) then
    begin
      Navigator := TPageNavigator.Create(Self);
      Navigator.Name := TPageNavigator.ClassName;
      Navigator.Align := alClient;
      Navigator.AutoScroll := True;
      Navigator.DoubleBuffered := True;
      Navigator.GradientStartColor := clSkyBlue;
      Navigator.GradientEndColor := clSilver;
      Navigator.Parent := Self;
      Navigator.CloseOnClick := True;
      Navigator.FreeOnClose := True;
      Navigator.Document := Self;
      Navigator.Show;
    end
  else if Navigator.Visible then  // don't close the navigator while its still loading
    Navigator.Close;
end;

function TContainer.IsCompGridDataChanged: Boolean; //ticket #750
var
  f,p,c: Integer;
  aCell: TBaseCell;
  CompCol: TCompColumn;

begin
  result := False;

  for f := 0 to docForm.count-1 do
    for p := 0 to docForm[f].frmPage.count-1 do
      if assigned(docForm[f].frmPage[p].PgData) then  //does page have cells?
      for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
        begin
          aCell := docForm[f].frmPage[p].PgData[c];
          case aCell.FCellID of
            925..1032,
            1041..1043,1052,1500..1502,
            1304,2146, //for 1075
            2354,2242..2274,1219-1221:  //for renting 362
            begin
              if aCell.FSaved then
                begin
                  Result := true;
                  Exit;
                end;
            end;
          end;
        end;
end;


procedure TContainer.HandleCompsDBPostProcess;
var
  CompDB: TCompsDBList;
  msg: String;
  i: Integer;
  CompID: Integer;
  aComp: String;
  FDocCompTable, FDocListTable: TCompMgr2;
  sl1, sl2:TStringList;
  NotMatchSubject, NotInDBSubject, NotMatchComps, NotInDBComps, NotMatchListings, NotInDBListings: String;
  SubjectNotmatch, SubjectNotInDB: Boolean;
  CompsNotMatch, CompsNotInDB: Boolean;
  ListingsNotMatch, ListingsNotInDB: Boolean;
  SaveOK: Boolean;
  aCompList, aListingList, aList: String;
  ContinueOK: boolean;
  aCount: Integer;
  idx: Integer;
  IsModified: Boolean;
begin
//  if not ReleaseVersion then exit;  //don't go on if not in release version
  //exclude what's new forms;
  idx := GetFormIndex(712);
  if idx <> -1 then exit;
  idx := GetFormIndex(741);
  if idx <> -1 then exit;
  idx := GetFormIndex(952);
  if idx <> -1 then exit;
  idx := GetFormIndex(713);
  if idx <> -1 then exit;
  idx := GetFormIndex(4039);
  if idx <> -1 then exit;

  try
    if (not appPref_AutoSaveSubject and not appPref_AutoSaveComps) then exit;
//    and (not appPref_ConfirmSubjectSaving and not appPref_ConfirmCompsSaving) then exit;


    CompDB := TCompsDBList.Create(nil);
    try
      sl1 := TStringList.Create;
      sl2 := TStringList.Create;
      //Build sales comp grid structure
      FDocCompTable := TCompMgr2.Create(True);
      FDocCompTable.BuildGrid(self, gtSales);

      //Build Listing comp grid structure
      FDocListTable := TCompMgr2.Create(True);
      FDocListTable.BuildGrid(self, gtListing);

      isModified := IsCompGridDataChanged;  //ticket #750: use isModified to drive the logic

      if not isModified then exit;
      //Only move on if we have cells in the grid
      if (FDocCompTable.Count > 0) or (FDocListTable.Count > 0) then
      begin
        aCount := FDocCompTable.Count + FDocListTable.Count;
        DisplayProgressBar('Saving Comps to Database - Please Wait', aCount);

        compDB.LoadFieldToCellIDMap;
        compDB.OnRecordsMenuClick(nil);

        SetProgressBarNote('Validating Comps with Comp Consistency - Please Wait');

        ValidateCompsWithUADConsistency(NotMatchSubject, NotInDBSubject, NotMatchComps, NotInDBComps, NotMatchListings, NotInDBListings);

        //Handle Subject saving
        SubjectNotMatch := length(NotMatchSubject) > 0;
        SubjectNotInDB  := length(NotInDBSubject) > 0;
        if appPref_ConfirmSubjectSaving then
          begin
            if SubjectNotMatch then
              msg := 'Subject is already in your Comparables Database but there are differences in the Descriptions. '+
                     'Would you still like to save the Subject to the database now?'
            else if SubjectNotInDB then
              msg   := 'Subject not found in the Database.  '+
                       'Would you like to save Subject to the Comparables database now?'
            else if appPref_ConfirmSubjectSaving then
              msg := 'Do you want to save your Subject to the Comparables Database now? ';

            if (msg <> '') then
              begin
                SaveOK := False;
                msg := msg + #13#10+#13#10+ 'Note: You should only save your comps to the database when you have completed your report.';
                if ok2Continue2(msg, False, 520) then
                SaveOK := True;
              end;
          end
        else
          SaveOK := appPref_AutoSaveSubject;

        if SaveOK then
          begin
            SetProgressBarNote('Saving Subject to Comps Database - Please Wait');
            IncrementProgressBar;
            CompDB.ImportSubject(0); //0=saving
          end;
        //make sure you clear the message the the list before you do the checking
        msg := '';
        aList := '';
        ContinueOK := True;
        //Handle comps saving of not match comps/listings
        CompsNotMatch := length(NotMatchComps) > 0;
        ListingsNotMatch := length(NotMatchListings) > 0;

        if CompsNotMatch then
          begin
            aCompList := NotMatchComps;
          end;
        if ListingsNotMatch then
          begin
            aListingList := NotMatchListings;
          end;
        aList := aCompList + aListingList;

        if pos(',', aList) > 0 then
          msg := Format('%s are already in your Comparables Database but there are differences in the Descriptions. '+
                        'Would you still like to save this comparable to the database now?',[aList])
        else if aList<>'' then
          msg := Format('%s is already in your Comparables Database but there are differences in the Descriptions. '+
                        'Would you still like to save this comparable to the database now?',[aList])

        else  //aList := '';
           SaveOK := False;

        if appPref_ConfirmCompsSaving then
          begin
            if msg <> '' then
              msg := msg + #13#10+#13#10+ 'Note: You should only save your comps to the database when you have completed your report.';

              if msg <> '' then
                begin
                  ContinueOK := ok2Continue2(msg, False, 540);
                  if ContinueOK then
                    //SaveOK := length(aCompList) > 0;
                    SaveOK := length(aList) > 0;
                end;
           end
         else
           SaveOK := appPref_AutoSaveComps;
         if SaveOK and (length(aList) > 0) then  //handle save if comps not in or not match
           begin
             //handle the save of individually
             aCompList := trim(aCompList + aListingList);
             while length(aCompList) > 0 do
               begin
                 aComp := popStr(aCompList,',');
                 if length(aComp) > 0 then
                   if POS('COMP',UpperCase(aComp)) > 0 then
                     begin
                       CompID := GetFirstIntValue(aComp);
                       SetProgressBarNote(Format('Saving Comp: %d',[CompID]));
                       IncrementProgressBar;
                       CompDB.ImportComparable(CompID, tcSales, 0);
                     end
                   else if POS('LISTING',UpperCase(aComp)) > 0 then
                     begin
                       CompID := GetFirstIntValue(aComp);
                       SetProgressBarNote(Format('Saving Listing: %d',[CompID]));
                       IncrementProgressBar;
                       CompDB.ImportComparable(CompID, tcListing, 0);
                     end;
               end;
           end;  //end of dosave on Comp/listing individually

       //Handle saving of not in DB comps/listings
       msg := '';
       CompsNotInDB  := length(NotInDBComps) > 0;
       ListingsNotInDB  := length(NotInDBListings) > 0;

       if CompsNotInDB then
          aCompList := NotInDBComps
       else
          aCompList := '';

       if ListingsNotInDB then
         aListingList := NotInDBListings
       else
         aListingList := '';


     //  aList := aCompList + aListingList;
      //ticket # 1178: when combine both comps and listings we need a , separator between the two
      //This is why the listing 1 is always not being saved through auto save routine.
       aList := aCompList + ','+ aListingList;

       if length(aList) > 0 then
         msg   := Format('%s not found in the Database.  '+
                         'Would you like to save %s to the Comparables database now?',[aList, aList]);


       if appPref_ConfirmCompsSaving and ContinueOK then
         begin
           if msg <> '' then
             begin
               msg := msg + #13#10+#13#10+ 'Note: You should only save your comps to the database when you have completed your report.';
               ContinueOK := Ok2Continue2(msg, False, 540);
               if ContinueOK then
                 begin
                   SaveOK := (length(aCompList) > 0) or (length(aListingList) > 0);
                   msg := '';
                 end;
             end;
         end
      else if ContinueOK then
         SaveOK := appPref_AutoSaveComps;

      //handle the save of individually
     //  aList := aCompList + aListingList;
      //ticket # 1178: when combine both comps and listings we need a , separator between the two
      //This is why the listing 1 is always not being saved through auto save routine.
      aCompList := trim(aCompList + ','+  aListingList);
      if SaveOK and (length(aCompList) > 0) then
        begin
          while length(aCompList) > 0 do
            begin
              aComp := popStr(aCompList,',');
              if length(aComp) > 0 then
                if POS('COMP',UpperCase(aComp)) > 0 then
                  begin
                    CompID := GetFirstIntValue(aComp);
                    SetProgressBarNote(Format('Saving Comp: %d',[CompID]));
                    IncrementProgressBar;
                    CompDB.ImportComparable(CompID, tcSales, 0);
                  end
                else if POS('LISTING',UpperCase(aComp)) > 0 then
                  begin
                    CompID := GetFirstIntValue(aComp);
                    SetProgressBarNote(Format('Saving Listing: %d',[CompID]));
                    IncrementProgressBar;
                    CompDB.ImportComparable(CompID, tcListing, 0);
                  end;
            end;
        end  //end of dosave on Comp/listing individually

       else //Handle all match record
         begin
           //if they are all match
           //Only move on if we have cells in the grid
           if (FDocCompTable.Count > 0) or (FDocListTable.Count > 0)  then
             begin
               for i:=1 to FDocCompTable.Count - 1 do
                 begin
                   if not FDocCompTable.Comp[i].IsEmpty then
                   if CompDB.CompsInDB(i, gtSales) then
                      sl1.Add(IntToStr(i));  //store comp # that not in the table
                 end;
               aCompList := sl1.CommaText;

                 //go through list comp
               for i:=1 to FDocListTable.Count - 1 do
                 begin
                   if not FDocListTable.Comp[i].IsEmpty then
                     if CompDB.CompsInDB(i, gtListing) then
                       sl2.Add(IntToStr(i));  //store listing # that not in the table
                 end;

             end;
             aListingList := sl2.CommaText;
             if not ContinueOK then
               msg := ''
             else if not SaveOK then
               begin
                 msg := 'Do you want to save your comps to the comparables database now?';
                 msg := msg + #13#10+#13#10+ 'Note: You should only save your comps to the database when you have completed your report.';
               end;
             if msg <> '' then
               begin
                 if appPref_ConfirmCompsSaving then
                   SaveOK := ok2Continue2(msg, False)
                 else
                   SaveOK := appPref_AutoSaveComps;
               end;
             if SaveOK then
               begin
                 if length(aCompList) > 0 then
                   begin
                     SetProgressBarNote('Saving all Comparables...');
                     IncrementProgressBar;
                     CompDB.ImportAllCompsMenuClick(nil);
                   end;
                 if length(aListingList) > 0 then
                   begin
                     SetProgressBarNote('Saving all Listings...');
                     IncrementProgressBar;
                     CompDB.ImportAllListingsMenuClick(nil);
                   end;
               end;
           end;
       end;
    finally
      sl1.Free;
      sl2.Free;
      if assigned(FDocCompTable) then
        FDocCompTable.Free;
      if assigned(FDocListTable) then
        FDocListTable.Free;
      CompDB.Free;
      RefreshCompList(-1);
    end;
  except ; end;  //let the process continue
end;

//bring up UAD consistency dialog off screen
//walk through the grid, if it's in error color, record the comp #
//base on the saving setting to do the save
function TContainer.ValidateCompsWithUADConsistency(var NotMatchSubject, NotInDBSubject, NotMatchComps, NotInDBComps, NotMatchListings, NotInDBListings:String):Boolean;
var
  uCon:TUADConsistency;
  row: Integer;
  modalResult: TModalResult;
  aName: String;
  NMSubject, NMSale, NMList:TStringList;
  NDSubject, NDSale, NDList: TStringList;
begin
  result := False;
  try
    uCon := TUADConsistency.Create(nil);
    NMSubject := TStringList.Create;
    NDSubject := TStringList.Create;
    NMSale := TStringList.Create;
    NMList := TStringList.Create;
    NDSale := TStringList.Create;
    NDList := TStringList.Create;
    try
      uCon.doc := self;
      uCon.RunInBkGround := True;
      UCon.BorderStyle :=  bsNone;
      UCon.Width  := 0;
      uCon.Height := 0;
      uCon.left   := -2000;
      uCon.Visible := False;

      UCon.ShowModal;
      for row := 1 to uCon.tGrid.Rows do
        begin
          aName := uCon.tGrid.Cell[cType,row];
          if (CompareText(uCon.tGrid.Cell[cUAD, row], '--') = 0) then  //not in DB
            begin
              if pos('SUB', UpperCase(aName)) > 0 then  //it's a sales
                NDSubject.Add(aName)
              else if pos('COMP', UpperCase(aName)) > 0 then
                NDSale.Add(aName)
              else if pos('LIST', UpperCase(aName)) > 0 then
                NDList.Add(aName);
            end
          else if (CompareText(uCon.tGrid.Cell[cUAD, row], 'X') = 0) then //not match
            begin
              if pos('SUB', UpperCase(aName)) > 0 then  //it's a sales
                NMSubject.Add(aName)
              else if pos('COMP', UpperCase(aName)) > 0 then
                NMSale.Add(aName)
              else if pos('LIST', UpperCase(aName)) > 0 then
                NMList.Add(aName);
            end;
        end;
        NotMatchSubject  := NMSubject.commaText;
        NotMatchComps    := NMSale.commaText;
        NotMatchListings := NMList.commaText;

        NotInDBSubject   := NDSubject.commaText;
        NotInDBComps     := NDSale.commaText;
        NotInDBListings  := NDList.CommaText;

        result := (NMSubject.count > 0) or (NMSale.count > 0) or (NMList.Count > 0)
                or (NDSubject.Count > 0) or (NDSale.Count > 0) or (NDList.Count > 0);
      UCon.ModalResult := mrCancel;
      UCon.Close;
    finally
      UCon.Free;
      NMSubject.Free;
      NDSubject.Free;
      NMSale.Free;
      NMList.Free;
      NDSale.Free;
      NDList.Free;
    end;
  except ; end;
end;



procedure TContainer.FileCmdHandler(FileCmd: Integer);
var
  msg:String;
  cList:TStringList;   //list to hold the subject/comps/listing changes
begin
  // make sure that the current contents are saved prior to the UADPostProcess call
  RefreshCurCell(Self);
  // Perform all UAD cleanup processes
  UADPostProcess(Self, docActiveCell, docActiveCell);
	case FileCmd of
		cmdFileClose:
			Close;
		cmdFileSave:
			Save;
		cmdFileSaveAs:
			SaveAs;
    cmdFileSavetoDropbox:
      SaveAs(true); // default false
		cmdFileSaveAsTmp:
			SaveAsTemplate;
		cmdFileImport:
			ImportFromFile(cmdFileImport);
    cmdFileUSystemImport:
      ImportFromFile(cmdFileUSystemImport);
    cmdFilePrint:             //= 42;
      PrintReport;
    cmdFileCreatePDF:         //  = 43;
      CreateReportPDF(2);     //2= opt to AutoLaunch
    cmdFileCreateUADXML:
      DeliverAppraisal(Self);
//      ExportToUADXML(Self);  // 030912 JWyatt Old method with no XML validation
    cmdFileProperty:
      docProperty.EditProperty('');
    cmdExportXSites:
      ExportToXSites;
	end;
end;

function TContainer.CanPaste: Boolean;
begin
   Result := False;
  //check with editor if can paste
  if assigned(docEditor) then
    result := docEditor.CanPaste;

  //check if its a file we can paste
  if not result and ClipBoardHasFile then
    try
      result := ClipboardHasFileOfType(dfUAARSale);
    except
    end;
end;

procedure TContainer.EditCmdHandler(EditCmd: Integer);
var
  format: ITextFormat;
begin
  if EditCmd = cmdFindReplace then
    FindAndReplace

  else //handle regular editing operations
    if docEditor <> nil then
      if (docActiveCell <> nil) or (docActiveItem <> nil) then
      begin
        case EditCmd of
          cmdUndo:
            docEditor.UndoEdit;
          cmdCut:
            docEditor.CutEdit;
          cmdCopy:
            docEditor.CopyEdit;
          cmdPaste:
            docEditor.PasteEdit;
          cmdClear:
            docEditor.ClearEdit;
          cmdSelectAll:
            docEditor.SelectAll;
          cmdTxLeft:
            if Supports(docEditor, ITextFormat, format) then
              format.TextJustification := tjJustLeft;
          cmdTxCenter:
            if Supports(docEditor, ITextFormat, format) then
              format.TextJustification := tjJustMid;
          cmdTxRight:
            if Supports(docEditor, ITextFormat, format) then
              format.TextJustification := tjJustRight;
          cmdTxPlain:
            if Supports(docEditor, ITextFormat, format) then
              format.Font.StyleBits := tsPlain;
          cmdTxBold:
            if Supports(docEditor, ITextFormat, format) then
              format.Font.StyleBits := format.Font.StyleBits xor tsBold;
          cmdTxItalic:
            if Supports(docEditor, ITextFormat, format) then
              format.Font.StyleBits := format.Font.StyleBits xor tsItalic;
          cmdTxUnderLine:
            if Supports(docEditor, ITextFormat, format) then
              format.Font.StyleBits := format.Font.StyleBits xor tsUnderLine;
        end;
      end;
end;

procedure TContainer.ViewCmdHandler(ViewCmd: Integer);
begin
	case ViewCmd of
		cmdExpandForms:
			docView.ExpandAllPages;
		cmdCollapseForms:
			docView.CollapseAllPages;
      
		cmdViewNormal:
			SetDisplayNormal;
		cmdViewFit2Scr:
			SetDisplayFit2Screen;
		cmdDisplayScale:
			SetDisplayScale;

		cmdTogglePageMgr:
			TogglePageMgrDisplay;
	end;

	docView.SetFocus;
end;

procedure TContainer.FormCmdHandler(FormCmd: Integer);
begin
  case formCmd of
		cmdArrangeForms:
			ArrangeForms;
		cmdDeleteForms:
			DeleteForms;
    {cmdDeleteSketches:
      DeleteDocSketches; }
    cmdFormSaveFormat:
      begin
      (*  //Saving Form Format changes has been removed for Vista compatibility
        SaveCurCell;                        //see if cur cell fromat has changed
        Self.SaveFormatChanges;             //Save the format changes to the FormsMgr TFormDesc object
        ActiveFormsMgr.SaveFormDefinitions; //save the changes now, so user has assoc with changes they made
      *)
      end;
  end;
end;

procedure TContainer.GoToCmdHandler(sender: TObject);
var
	n: Integer;
begin
	n := 0;
	if sender is TComponent then
		n := TComponent(Sender).tag;

	if n = -1 then             //prev page
		docView.GotoPage(cPrevPage)

	else if n = -2 then        //next page
		docView.GotoPage(cNextPage)

  else if n = -3 then
    GoToPrevActiveCell

  else if n = -4 then
    ShowPageNavigator

	else begin
		docView.GoToBookMark(n);  //go to a bookmark (Pg index and offset)
	end;
end;

Procedure TContainer.CellCmdHandler(CellCmd: Integer);
begin
	case cellCmd of
		cmdCellAutoRsp:
			docAutoRspOn := not docAutoRspOn;
		cmdCellEditRsp:
			EditCellResponses;
		cmdCellShowRsp:
			ShowCellResponses;
		cmdCellSaveRsp:
			SaveCellResponses;
		cmdCellPref:
			SetCellPreferences;
    cmdCellAutoAdj:
      LaunchAdjustmentEditor(self);
    CmdCellSaveImage:
      SaveCellImageToFile;
    cmdCellUADDlg:
      begin
        DisplayNonUADStdDlg(self);
        DisplayUADStdDlg(Self);  //this is F8, always pop up UAD
      end;
  end;
end;

Procedure TContainer.DebugCmdHandler(DebugCmd: Integer);

  function OK2Do: Boolean;
  begin
    if ReleaseVersion then
      result := OK2Continue('This operation will delete the data on the forms. Please use blank forms when invoking these functions. Do you want to continue?')
    else
      result := True;
  end;

begin
  case debugCmd of
    dbugShowCellNum,
    dbugShowMathID,
    dbugShowCellID,
    dbugShowXMLID,
    dbugShowRspID,
    dbugShowSample,
    dbugShowContext,
    dbugShowLocContxt,
    dbugSpecial:
      if OK2Do then
        DebugShowCellAttribute(debugCmd);
		dbugClearPage:
      if OK2Do then
			  ClearDocText;
	  dbugSetRspIDs:
      DebugSetRspIDs;
	  dbugSetCellIDs:
      DebugSetCellIDs;
    dbugDataLogOn: begin end;
    dbugFindCell:
      FindCellByAttribute(self);
  end;
end;


(*
The following code aborts a print job if the user presses Esc.
Note that you should set KeyPreview to True to ensure that the OnKeyDown event handler of Form1 is called.

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if (Key=VK_ESCAPE) and Printer.Printing then
	begin
	Printer.Abort;
	MessageDlg('Printing aborted', mtInformation, [mbOK],0);
	end;
end;
*)

//To Collate:  CollateCopies > 0 and PgSpec[n].Copies = 1
//To Print normal: CollateCopies = 0;  PgSpec[n].Copies = num copies
//We have WinPrint which used the Window's Print Dialog and our Own Print Dialog
//Note: Make changes in both places
procedure TContainer.DoWinPrint(CollateCopies: Integer; PgSpec: Array of PagePrintSpecRec);
var
  n, f, p: Integer;
  needsNewPage: Boolean;
  hdlDC: HDC;
  DCPixels,POY,POX,PW,PH: Integer;
  viewR, printR: TRect;
  PrOrg: TPoint;
  PrScale: Integer;
begin
	if docForm.count > 0 then                 // do we have anything to print
	begin
		if docActiveCell <> nil then
			if docEditor <> nil then
				docEditor.SaveChanges;           	 //save the editor stuff to cell for printing     with Printer do

    with Printer do
    begin
      Title := docFileName;          //Windows print mgr title

      needsNewPage := False;
      BeginDoc;

      hdlDC := Printer.Canvas.Handle;
      DCPixels := GetDeviceCaps(hdlDC, LogPixelsX);			//assume square pixels on printer
      PW := GetDeviceCaps(hdlDC, HorzRes);
      PH := GetDeviceCaps(hdlDC, VertRes);
//      PW := GetDeviceCaps(hdlDC, PhysicalWidth);
//      PH := GetDeviceCaps(hdlDC, PhysicalHeight);
      POY := GetDeviceCaps(hdlDC, PhysicalOffsetY);
      POX := GetDeviceCaps(hdlDC, PhysicalOffsetX);
      viewR := Rect(0,0,PW,PH);
      printR := Bounds(POX, POY, PW-POX-POX, PH-POY-POY);

      SetMapMode(hdlDC, MM_TEXT);                                 //make sure we are 1 for 1

//      for m := 1 to CollateCopies do
//        begin
          n := 0;
          for f := 0 to docForm.count-1 do                            //loop on forms, pages
            for p := 0 to docForm[f].frmPage.Count -1 do
              With docForm[f].frmPage[p] do
              begin
                if PgSpec[n].OK2Print then {and (PgSpec[n].PrIndex = PrIndex) }
                  begin
                    PrScale := DCPixels;
                    GetPagePrintFactors(printR, PrOrg, PrScale);
                    SetViewportOrgEx(hdlDC, -PrOrg.x, -PrOrg.y, nil);

               //   for c := 1 to 1PgSpec[n].Copies do
               //     begin
                      if needsNewPage then NewPage;      								//do we need a new page
                      SetViewportOrgEx(hdlDC, -PrOrg.x, -PrOrg.y, nil);
                      PrintFormPage(self, Printer.Canvas, viewR, docForm[f].frmPage[p], 72, PrScale);
                      needsNewPage := True;              //we need a new page now
              //      end;
                  end;
                inc(n);
              end;
//        end;  //collate copies

      EndDoc;
    end; // w/printer
  end;  //count > 0
end;


//Use PgSpec so we can pass in Fax, Print or PDF page list
//NOTE: PrIndex is NOT the printer.PrinterIndex, it is printer number when using multi-printers
//The printer driver has been pre-selected before getting to here.
procedure TContainer.DoPrintReport(PrIndex: Integer; PgSpec: Array of PagePrintSpecRec);
var
  n, f, p, c: Integer;
  needsNewPage: Boolean;
  hdlDC: HDC;
  DCPixels,POY,POX,PW,PH: Integer;
  viewR, printR: TRect;
  PrOrg: TPoint;
  PrScale: Integer;
begin
	if docForm.count > 0 then                 // do we have anything to print
	begin
    if assigned(docEditor) then
      docEditor.SaveChanges;

//		if docActiveCell <> nil then
//			if docEditor <> nil then
//				docEditor.SaveChanges;           	  //save the editor stuff to cell for printing     with Printer do

    With Printer do
    begin
      Title := docFileName;          //Windows print mgr title

      needsNewPage := False;
      BeginDoc;

      hdlDC := Printer.Canvas.Handle;
      DCPixels := GetDeviceCaps(hdlDC, LogPixelsX);			//assume square pixels on printer
      PW := GetDeviceCaps(hdlDC, HorzRes);
      PH := GetDeviceCaps(hdlDC, VertRes);
//      PW := GetDeviceCaps(hdlDC, PhysicalWidth);
//      PH := GetDeviceCaps(hdlDC, PhysicalHeight);
      POY := GetDeviceCaps(hdlDC, PhysicalOffsetY);
      POX := GetDeviceCaps(hdlDC, PhysicalOffsetX);
      viewR := Rect(0,0,PW,PH);
//      printR := Bounds(POX, POY, PW-POX-POX, PH-POY-POY);
      printR := Bounds(POX, POY, PW, PH);
      SetMapMode(hdlDC, MM_TEXT);                                 //make sure we are 1 for 1

      n := 0;
      for f := 0 to docForm.count-1 do                            //loop on forms, pages
        for p := 0 to docForm[f].frmPage.Count -1 do
          With docForm[f].frmPage[p] do
          begin
            if PgSpec[n].OK2Print and (PgSpec[n].PrIndex = PrIndex) then
            begin
              PrScale := DCPixels;
              ViewR := GetPagePrintFactors(printR, PrOrg, PrScale);
              SetViewportOrgEx(hdlDC, -PrOrg.x, -PrOrg.y, nil);

              for c := 1 to PgSpec[n].Copies do
                begin
                  if needsNewPage then NewPage;      								//do we need a new page
                  SetViewportOrgEx(hdlDC, -PrOrg.x, -PrOrg.y, nil);
                  PrintFormPage(self, Printer.Canvas, viewR, docForm[f].frmPage[p], 72, PrScale);
                  needsNewPage := True;              //we need a new page now
                end;
            end;
            inc(n);
          end;
      EndDoc;
    end; // w/printer
  end;  //count > 0
end;

//returns the PDF file name so we can auto attach to email
// !!! THIS CODE NEARLY DUPLICATES THE CODE BELOW IN TContainer.DoCreateWPDF_2 !!!
// (fix a bug in one of them and you should fix it in both)
function TContainer.DoCreateWPDF(PgSpec: Array of PagePrintSpecRec): String;
var
  n, f, p: Integer;
  viewR: TRect;
  w,h: Integer;
  dcResolX, dcResolY: Integer;
begin
  result := '';
  PushMouseCursor(crHourglass);
  try
    if docForm.count > 0 then                 // do we have anything to print
    begin
      // save the editor
      CommitEdits;

      // get resolution
      Printer.Refresh;
      WPDFprinting := true;
      WPPDFPrinter.BeginDoc;                  //start it
      dcResolX := GetDeviceCaps(WPPDFPrinter.ReferenceDC, LOGPIXELSX);
      dcResolY := GetDeviceCaps(WPPDFPrinter.ReferenceDC, LOGPIXELSY);
      result := WPPDFPrinter.Filename;        //return the file
      try
        n := 0;
        for f := 0 to docForm.count-1 do                            //loop on forms, pages
          for p := 0 to docForm[f].frmPage.Count -1 do
            With docForm[f].frmPage[p] do
              begin
                if PgSpec[n].OK2Print then
                  begin
                    w := MulDiv(pgDesc.PgWidth, dcResolX, cNormScale);
                    h := MulDiv(pgDesc.PgHeight, dcResolY, cNormScale);
                    viewR := Rect(0, 0, w, h);
                    WPPDFPrinter.StartPage(w, h, dcResolX, dcResolY, 0);
                    SetMapMode(WPPDFPrinter.Canvas.Handle, MM_ANISOTROPIC);
                    PrintFormPage(Self, WPPDFPrinter.Canvas, viewR, docForm[f].frmPage[p], cNormScale, dcResolX);
                    WPPDFPrinter.EndPage;
                  end;
                inc(n);
              end;
      finally
        WPPDFPrinter.EndDoc;
      end;
    end;
  finally
    PopMouseCursor;
    WPDFPrinting := false;
  end;
end;

//returns the PDF file name so we can send it with a RELS order
// !!! THIS CODE NEARLY DUPLICATES THE CODE ABOVE IN TContainer.DoCreateWPDF !!!
// (fix a bug in one of them and you should fix it in both)
function TContainer.DoCreateWPDF_2(PgList: BooleanArray): String;
var
  n, f, p: Integer;
  viewR: TRect;
  w,h: Integer;
  dcResolX, dcResolY: Integer;
  pdfPage: Boolean;
begin
  result := '';
  PushMouseCursor(crHourglass);
  try
    if docForm.count > 0 then                 // do we have anything to print
    begin
      // save the editor
      CommitEdits;

      // get resolution
      Printer.Refresh;
      WPDFPrinting := true;
      WPPDFPrinter.BeginDoc;                  //start it
      dcResolX := GetDeviceCaps(WPPDFPrinter.ReferenceDC, LOGPIXELSX);
      dcResolY := GetDeviceCaps(WPPDFPrinter.ReferenceDC, LOGPIXELSY);
      result := WPPDFPrinter.Filename;        //return the file
      try
        n := 0;
        for f := 0 to docForm.count-1 do                            //loop on forms, pages
          for p := 0 to docForm[f].frmPage.Count -1 do
            With docForm[f].frmPage[p] do
              begin
                if assigned(PgList) then
                  pdfPage := PgList[n]
                else
                  pdfPage := IsBitSet(FPgFlags, bPgInPDFList);

                if pdfPage then
                  begin
                    w := MulDiv(pgDesc.PgWidth, dcResolX, cNormScale);
                    h := MulDiv(pgDesc.PgHeight, dcResolY, cNormScale);
                    viewR := Rect(0, 0, w, h);
                    WPPDFPrinter.StartPage(w, h, dcResolX, dcResolY, 0);
                    SetMapMode(WPPDFPrinter.Canvas.Handle, MM_ANISOTROPIC);
                    PrintFormPage(Self, WPPDFPrinter.Canvas, viewR, docForm[f].frmPage[p], cNormScale, dcResolX);
                    WPPDFPrinter.EndPage;
                  end;
                inc(n);
              end;
      finally
        WPPDFPrinter.EndDoc;
      end;
    end;
  finally
    PopMouseCursor;
    WPDFPrinting := false;
  end;
end;

procedure TContainer.PrintReport;
  procedure DualPrint;
  var
    PrConfig: TTwoPrint;
  begin
    PrConfig := TTwoPrint.Create(Self);             //create the print dialog
    try
      try
        PrConfig.ShowModal;                         //display the print dialog
      except
        ShowNotice('There is a problem printing. Please check the print driver and printer connection.');
        raise;
      end;
    finally
      PrConfig.free;                                //free the print dialog
    end;
  end;

  procedure NormalPrint;
  var
    WinPrint: TWinPrint;
  begin
    WinPrint := TWinPrint.Create(self);
    try
      try
        WinPrint.Execute;
      except
        ShowNotice('There is a problem printing. Please check the print driver and printer connection.');
        raise;
      end;
    finally
      WinPrint.Free;
    end;
  end;

begin
  if docForm.TotalPages > 0 then                     //make sure there are pages to print
  begin
    if UseDualPrinting then  //use dual printing
      DualPrint
    else //use normal printing when its standard application
      NormalPrint;
  end;
end;

function TContainer.CreateReportPDFEx(fName: String; showPDF, showPref, encryptPDF: Boolean; PgList: BooleanArray): String;
var
  Ok2Continue: Boolean;
  PDFPref: TWPDFConfigEx;
begin
  Ok2Continue := True;
  PDFPref := TWPDFConfigEx.Create(self);
  try
    PDFPref.FileName := fName;
    PDFPref.AssignPgList(PgList);
    PDFPref.AutoLaunch := showPDF;

    if showPref then
      Ok2Continue := PDFPref.showModal = mrOk   //user wants to set preference
    else
      begin
        PDFPref.cbxEncrypt.Checked := encryptPDF;    //we set encryption is not showing Dialog
        PDFPref.GetConfiguration;         //get the default settings
      end;
      
    if OK2Continue then
      begin
        PDFPref.Hide;
        try
          result := DoCreateWPDF_2(PDFPref.PgList);         //return file that was created
        except
          ShowNotice('There is a problem creating the PDF file. Make sure a file by the same name is not in use and you have enough hard disk space.')
        end;
      end;
  finally
    WPDFConfigEx.Free;
  end;
end;

function TContainer.CreateReportPDF(Options:Integer): String;
var
	APDFConfig:   TCreatePDF;
  WPDFConfig: TWPDFConfig2;
begin
  result := '';    //return the path of the file

{$WARNINGS OFF}

  //use Built-in WPDF Driver
  if appPref_DefaultPDFOption = pdfBuiltInWriter then
    begin
      WPDFConfig := TWPDFConfig2.create(self);
      try
        WPDFConfig.ShowAdvanced := appPref_WPDFShowAdvanced;
        WPDFConfig.Options := Options;
        if WPDFConfig.showModal = mrOK then
          begin
            WPDFConfig.Hide;
            try
              result := DoCreateWPDF(WPDFConfig.PgSpec);  //return file that was created
            except
              ShowNotice('There is a problem creating the PDF file. Make sure a file by the same name is not in use and you have enough hard disk space.')
            end;
          end;
      finally
        WPDFConfig.Free;
      end;
    end

  //use Adobe Acrobat PDF driver
  else
    begin
      APDFConfig := TCreatePDF.Create(Self);    //create the print dialog
      try
        APDFConfig.ShowModal;
      finally
        APDFConfig.free;                          //free the print dialog
      end;
    end;
{$WARNINGS ON}
end;

//pt must be in doc coordinates
procedure TContainer.MakePtVisible(Pt: TPoint);
begin
	docView.ScrollPtInView(Pt.x, Pt.y);   //make point visible
  SynchronizeFormsManager;              //sync with FormsMgr
end;

procedure TContainer.PageMgrShowSelectedPage;
var
	i, py, px: integer;
begin
  if PageMgr.count = 0 then Exit;   //cannot do anything

	i := PageMgr.ItemIndex;
	if i = -1 then   //nothing selected
    begin          //so select the first page
      i := 0;
      PageMgr.ItemIndex := i;
    end;

	if TPageBase(DocView.PageList[i]).PgCollapsed then
		docView.TogglePageView(i, cOpenPage);

	py := TPageBase(DocView.PageList[i]).PgOrg.y;
	px := DocView.HorzScrollBar.Position;
	if ControlKeyDown then
		docView.ScrollPt2Top(0,PY)       //normal mode, auto scroll
	else
		docView.ScrollPt2Top(PX,PY);      //don't auto scroll to left

  PageMgr.Invalidate;      //repaint the focus rect's
  PageMgr.Refresh;         //repaint the focus rect's
end;

//Note: Need to use MouseDown instead of click for BeginDrag
procedure TContainer.PageMgrMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if PageMgr.Count > 0 then
    begin
      PageMgr.ItemIndex := PageMgr.ItemAtPos(Point(x,y), True); //Ticket #1526
      If Button = mbLeft then
        begin
          PageMgrShowSelectedPage;
          PageMgr.BeginDrag(False, 5);      //system call, move 5 pixels before drag begins
        end;
    end;
end;

procedure TContainer.PageMgrMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Activate;
end;

procedure TContainer.PageMgrStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  DragForm: TDragPageIndex;
  AForm: TDocForm;
  FormUID: TFormUID;
begin
  if (PageMgr.ItemIndex > -1) then
    begin
      AForm := TDocForm(TDocPage(TPageBase(DocView.PageList[PageMgr.ItemIndex]).FDataParent).FParentForm);

      FormUID := TFormUID.Create;
      FormUID.ID   := AForm.frmSpecs.fFormUID;
      FormUID.Vers := AForm.frmSpecs.fFormVers;

      DragForm := TDragPageIndex.Create;
      DragForm.SrcPageIndex := PageMgr.ItemIndex;
      DragForm.SrcFormIndex := docForm.IndexOf(AForm);
//The below if for future to drag from one PageMgr to another PageMgr
      DragForm.SrcForm := AForm;
      DragForm.SrcList := PageMgr;
      DragForm.SrcFormId  := FormUID;

      DragObject := DragForm;
    end;
end;

procedure TContainer.PageMgrDragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
var
  InsertLn: TRect;

  function GetInsertLine(X,Y: Integer): TRect;
  var
    AForm: TDocForm;
    pCount,N,NTop,NBot,NMid: Integer;
    NRect, NBR: TRect;
  begin
    N:=PageMgr.ItemAtPos(Point(x,y), False);
    if N = -1 then
      N := 0;
    if (N >= PageMgr.count) and (PageMgr.count>0) then   //JDB Compensate for empty container
      N := PageMgr.count -1;

    AForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
    pCount := AForm.frmPage.Count;

    NTop := GetPageIndexInPageMgrList(AForm.frmPage[0]);
    NRect := PageMgr.ItemRect(NTop);
    if pCount > 1 then
      begin
        NBot := GetPageIndexInPageMgrList(AForm.frmPage[pCount-1]);
        NBR := PageMgr.ItemRect(NBot);
        NRect.Bottom := NBR.Bottom;
      end;
    NMid := (NRect.Top + NRect.Bottom) div 2;
    if Y >= NMid then
      result := Rect(NRect.Left, NRect.Bottom, NRect.Right, NRect.Bottom)
    else
      result := Rect(NRect.Left, NRect.Top, NRect.Right, NRect.Top);
  end;

  procedure DrawInsertLine(Ln: TRect; Erase: Boolean);
  begin
    if erase then
      PageMgr.Canvas.Pen.Color := PageMgr.Color
    else
      PageMgr.Canvas.Pen.Color:=clBlack;
    PageMgr.Canvas.Pen.Width:=2;
    PageMgr.Canvas.MoveTo(Ln.Left, Ln.Bottom);
    PageMgr.Canvas.LineTo(Ln.Right, Ln.Bottom);
  end;

begin
	Accept := False;
	if (not Locked) then
    if (source is TDragFormObject) then     //are we dragging a Form?
      begin
        if TDragFormObject(source).theDoc <> Self then
          Accept := True;
      end
    else if (source is TDragPageIndex) and (Sender = PageMgr) then   //are we dragging a page in PageMgr
      begin
        Accept := True;
      end;

  if (Accept) and (PageMgr.Count > 0) then      //if we can accept it, lets indicate where
    case State of
      dsDragEnter:    //start the indicator
        begin
          InsertLn := GetInsertLine(X,Y);
          DrawInsertLine(InsertLn, False);
          LastInsertIndicator := InsertLn;
        end;
      dsDragMove:     //just moving around
        begin
          InsertLn := GetInsertLine(X,Y);
          if not EqualRect(InsertLn, LastInsertIndicator) then
            begin
              DrawInsertLine(LastInsertIndicator, True);
              DrawInsertLine(InsertLn, False);
              LastInsertIndicator := InsertLn;
            end;
        end;
      dsDragLeave:    //remove the indiactor
        begin
          DrawInsertLine(LastInsertIndicator, True);
        end;
    end;
end;

procedure TContainer.PageMgrDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  AForm : TDocForm;
  N, DestFormIndex: Integer;
 formIdx: Integer;


  function CheckDocForm(SourceA :TDocForm):Boolean;
  var
    i : Integer;
    BForm : TDocForm;
  begin
     Result := false;
     for i := 0 to PageMgr.Count-1 do
       begin
         BForm := TDocForm(TDocPage(TPageBase(DocView.PageList[i]).FDataParent).FParentForm);
         if SourceA = BForm then
            Result := true;
       end;
  end;

  function GetDestinationIndex(Inserting: Boolean): Integer;
  var
    fIndex, pCount: Integer;
    NTop, NBot, NMid: Integer;
    NRect, NBRect: TRect;
  begin
    AForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
    fIndex := docForm.IndexOf(AForm);
    pCount := AForm.frmPage.Count;

    NTop := GetPageIndexInPageMgrList(AForm.frmPage[0]);
    NRect := PageMgr.ItemRect(NTop);
    if pCount > 1 then
      begin
        NBot := GetPageIndexInPageMgrList(AForm.frmPage[pCount-1]);
        NBRect := PageMgr.ItemRect(NBot);
        NRect.Bottom := NBRect.Bottom;
      end;
    NMid := (NRect.Top + NRect.Bottom) div 2;
    if Y >= NMid then
      begin
        result := fIndex;
        if Inserting then     //if inserting add 1
          result := min(fIndex + 1,docForm.count - 1);    //make sure we don't go past end
      end
    else
      result := fIndex;
  end;
begin
  if (not Locked) then
    if (source is TDragFormObject) then
      with Source as TDragFormObject do
        begin
          if FForm <> nil then
            try
              N := PageMgr.ItemAtPos(Point(X, Y), False);     //where should we palce it
              if (N > -1) and (N < PageMgr.Count) then
                DestFormIndex := GetDestinationIndex(True)
              else
                DestFormIndex := -1;  //just put at the end

              if (HasData or Assigned(theDoc)) and Assigned(theForm) and (theForm is TDocForm) then
                if ((theForm as TDocForm).GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
                  AddLiveWordProcessorPage((FForm as TFormUID), (theForm as TDocForm), not ShiftKeyDown, DestFormIndex)
                else
                  AddLiveForm((FForm as TFormUID), (theForm as TDocForm), not ShiftKeyDown, DestFormIndex)
              else
                begin
                  AForm := InsertFormUID((FForm as TFormUID), not ShiftKeyDown, DestFormIndex);  //expand if SHIFT key is NOT Down
                  DestFormIndex := docForm.IndexOf(AForm);
                  if (DestFormIndex > 0) and PromptLinkWordProcessorPages(docForm[DestFormIndex - 1], AForm) then
                    LinkWordProcessorPages(docForm[DestFormIndex - 1], AForm);
                end;
            finally
              FForm.Free;
            end;
        end

    else if (source is TDragPageIndex) then
      with Source as TDragPageIndex do
        begin
          N := PageMgr.ItemAtPos(Point(X, Y), False);   //this is the place we want to move it to
          if (N > -1) and (N < PageMgr.Count)and (SrcList = PageMgr ) then
             begin
                DestFormIndex := GetDestinationIndex(False);
                if SrcFormIndex <> DestFormIndex then
                   MoveForm(SrcFormIndex, DestFormIndex);
             end
          else
            begin     //Here is where insert a new FormDoc from another Form Manager 1/11/2010 Jeferson.
            try
              if not CheckDocForm(SrcForm) then       //Check if already has the Form. if drag from the same PageMgr
               begin
                  if (SrcForm.GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
                    begin
                      N := PageMgr.ItemAtPos(Point(X, Y), False);
                      if (N > -1) and (N < PageMgr.Count) then
                        formidx := GetDestinationIndex(True)
                      else
                        formidx := -1;
                      AddLiveWordProcessorPage((srcFormId as TFormUID), (srcForm as TDocForm), not ShiftKeyDown, formIdx);
                    end
                   else
                    begin
                     N := PageMgr.ItemAtPos(Point(X, Y), False);
                     if (N > -1) and (N < PageMgr.Count) then
                       formidx := GetDestinationIndex(True)
                     else
                       formidx := -1;
                     AddLiveForm((srcFormId as TFormUID), (srcForm as TDocForm), not ShiftKeyDown, formIdx);
                    end;
               end;
            except
             ShowNotice('There is a problem dragging from the Forms Manager.');
            end;
            end;
        end;
end;

/// summary: Updates the page navigator once changes to the document are complete.
procedure TContainer.PageNavigatorUpdateTimerTimer(Sender: TObject);
var
  Timeout: TDateTime;
begin
  Timeout := EncodeTime(0, 0, 0, 250);
  if (Now > FModificationTime + Timeout) then
    begin
      PageNavigatorUpdateTimer.Enabled := False;
      UpdatePageNavigator;
    end;
end;

procedure TContainer.DragOverDoc(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
	Accept := False;
	if (not Locked) then
    if (source is TDragFormObject) then
      if TDragFormObject(source).theDoc <> Self then
        Accept := True;
end;

procedure TContainer.DragDropOnDoc(Sender, Source: TObject; X, Y: Integer);
var
  AForm: TDocForm;
  AFormIndex: Integer;
begin
  if (not Locked) then
    if (source is TDragFormObject) then
      with Source as TDragFormObject do
        begin
          if FForm <> nil then
            try
              if (HasData or Assigned(theDoc)) and Assigned(theForm) and (theForm is TDocForm) then
                if ((theForm as TDocForm).GetCellByID(CWordProcessorCellID) is TWordProcessorCell) then
                  AddLiveWordProcessorPage((FForm as TFormUID), (theForm as TDocForm), not ShiftKeyDown, -1)
                else
                  AddLiveForm((FForm as TFormUID), (theForm as TDocForm), not ShiftKeyDown, -1)
              else
                begin
                  AForm := InsertFormUID((FForm as TFormUID), not ShiftKeyDown, -1);  //expand if SHIFT key is NOT Down
                  AFormIndex := docForm.IndexOf(AForm);
                  if (AFormIndex > 0) and PromptLinkWordProcessorPages(docForm[AFormIndex - 1], AForm) then
                    LinkWordProcessorPages(docForm[AFormIndex - 1], AForm);
                end;
            finally
              FForm.Free;
            end;
        end;
end;

procedure TContainer.DragFromDoc(Sender: TObject; var DragObject: TDragObject);
var
	FormUID: TFormUID;
	DragForm: TDragFormObject;
	dForm: TDocForm;
begin
	if (sender is TDocPage) then
		with sender as TDocPage do
			begin
				dForm := TDocForm(FParentForm);
				with dForm.frmSpecs do
					begin
						FormUID := TFormUID.Create;      //create identifier object
						FormUID.ID := fFormUID;          // this is form ID
						FormUID.Vers := fFormVers;       // its version number

						DragForm := TDragFormObject.Create;
						DragForm.FForm := FormUID;
						DragForm.hasData := dForm.HasData;		//do we have data in this form.
						DragForm.theForm := dForm;			 			//this is the docForm containing data
						DragForm.theDoc := self;		 		 			//ref so we know if we are draging onto ourselves

						DragObject := DragForm;          //send it off
					end;
			end;
end;

procedure TContainer.DisplayProgressBar(const Title: String; MaxValue: Integer);
begin
  if docProgress <> nil then
    docProgress.Free;
  docProgress := TProgress.Create(self, 0, MaxValue, 0, Title);
end;

procedure TContainer.SetProgressBarNote(Const Note: String);
begin
  if docProgress <> nil then
    docProgress.SetProgressNote(Note);
end;

procedure TContainer.IncrementProgressBar;
begin
  if docProgress <> nil then
    if (docProgress.StatusBar.Position <> docProgress.StatusBar.Max) then
      docProgress.IncrementProgress;
end;

procedure TContainer.RemoveProgressBar;
begin
  if docProgress <> nil then
    begin
      docProgress.Hide;
      docProgress.Free;
      docProgress := nil;
    end;
end;

procedure TContainer.SetDisplayScale;
var
	Zoomer: TDisplayZoom;
begin
	Zoomer := TDisplayZoom.Create(self, docView);  //Application
  try
	  Zoomer.ShowModal;
    FZoomScale := docView.ViewScale;
    PageMgr.Refresh;              //view has changed - update FormMgr
  finally
	  Zoomer.free;
  end;
	if docEditor <> nil then
		docEditor.ResetScale;
end;

procedure TContainer.SetDisplayNormal;
begin
	Self.WindowState := wsNormal;
	docView.ViewScale := ZoomFactor;   //reset what the user originally set as zoom factor
	if docEditor <> nil then
		docEditor.ResetScale;
end;

procedure TContainer.SetDisplayFit2Screen;
Var
	CW, dW: Integer;
begin
	Self.WindowState := wsMaximized;
	CW := self.width;       //container width

  if IsBitSet(docPref, bShowPageMgr) then
    DW := CW - (PageMgr.Width + cMarginWidth + cSplitterWidth + cSmallBorder + 29)
  else
    DW := CW - (cMarginWidth + cSplitterWidth + cSmallBorder + 29);  //29=scrollbar width

  //sets ViewScale directly, ZoomFactor remains unchanged, in case we go back to normal window size
	docView.ViewScale := muldiv(100, DW, muldiv(100, cPageWidthLetter, cNormScale));
	if docEditor <> nil then
		docEditor.ResetScale;
end;

procedure TContainer.ThesaurusLookUpWord;
var
  oldWord, newWord: String;
begin
  if (docForm.count > 0) and (docEditor <> nil) and (docEditor is TTextEditor) then
      begin
        oldWord := TTextEditor(docEditor).SelectedText;
        newWord := main.Thesaurus.LookupWord(oldWord);     //do its stuff

        if (length(NewWord)>0) and (compareText(newWord, oldWord) <> 0) then
          TTextEditor(docEditor).InputString(newWord);
      end
  else
    beep;
end;

procedure TContainer.DoSpellCheckWord;
var
  Speller: TCellSpeller;  //NOTE: Addict owns Speller and will free it
begin
  if not Locked and (docForm.count > 0) and (docEditor <> nil) and docEditor.CanEdit then
    begin
      Speller := TCellSpeller.Create;
      try
        main.addictSpell.EndMessage := emAlways;    //emNever;
        Speller.Initialize(docActiveCell);
        main.addictSpell.CheckParser(Speller, ctAll);
      except
        ShowNotice('A problem was encountered while spell checking.');
      end;
    end
  else
    beep;
end;

function TContainer.AllowCellSpellCheck(Cell: TBaseCell): Boolean;
var
  Noncheck: set of 1..255;
begin
  nonCheck := [1,2,3,4,5,6,10,11,12,13,17,18,21,24,25,26,27,28,32,35,36,52,53,54,66,67,68,78,83,103];
  result := False;
  if Assigned(Cell) and Assigned(Cell.EditorClass) and Cell.CanEdit then
    result := Cell.EditorClass.InheritsFrom(TTextEditor) and
              (Cell.FSubType <> cKindCalc) and not
              (Cell.FContextID in nonCheck);
end;

procedure TContainer.DoSpellCheckPage;
var
  Speller: TCellSpeller;  //NOTE: Addict owns Speller and will free it
  PageCells: TDataCellList;
  c, NCells: Integer;
  CUID: CellUID;
begin
  CUID := docActiveCell.UID;             //this identifies the page to check
  if not Locked and (docForm.count > 0) and            //we have pages
     (docForm[CUID.form].frmPage[CUID.pg].PgData <> nil) then  //and pages have data
    begin
      PageCells := docForm[CUID.form].frmPage[CUID.pg].PgData;
      NCells := PageCells.Count -1;
      try
        main.addictSpell.EndMessage := emExceptCancel;  //want Finished message
        main.addictSpell.StartSequenceCheck;            //tell addict tp spell multiples

        for c := 0 to NCells do
          if AllowCellSpellCheck(PageCells[c]) then
            begin
              Speller := TCellSpeller.Create;         //create the page checker
              Speller.Initialize(PageCells[c]);       //needs to know about doc'page
              main.addictSpell.CheckParser(Speller, ctAll);  //spell check
            end;
      finally
        main.addictSpell.StopSequenceCheck;        // we are done
      end;
    end;
end;

procedure TContainer.DoSpellCheckReport;
var
  f,p,c,NCells: Integer;   //NOTE: Addict owns Speller and will free it
  Speller: TCellSpeller;
  PageCells: TDataCellList;
begin
  if not Locked and (docForm.count > 0) then                     //we have forms to check
    try
      main.addictSpell.EndMessage := emExceptCancel;  //want Finished message
      main.addictSpell.StartSequenceCheck;            //tell addict tp spell multiples

      for f := 0 to docForm.count-1 do     				        //iterate on forms
        begin
          for p := 0 to docForm[f].frmPage.Count-1 do     //iterate on Forms's pages
            if docForm[f].frmPage[p].PgData <> nil then   //page has cells
              begin
                PageCells := docForm[f].frmPage[p].PgData;
                NCells := PageCells.Count -1;

                for c := 0 to NCells do
                  if AllowCellSpellCheck(PageCells[c]) then
                    begin
                      Speller := TCellSpeller.Create;         //create the cell checker
                      Speller.Initialize(PageCells[c]);
                      main.addictSpell.CheckParser(Speller, ctAll);   //spell check
                    end;
              end;
        end;
    finally
      main.addictSpell.StopSequenceCheck;         // we are done
    end;
end;

//This is used to set the spelling menu items
function TContainer.CanSpellCheck(JustWord: Boolean): Boolean;
begin
  result := (docForm.count>0);
  if justWord then
    if(docEditor <> nil) then  //make sure we have an editor
      result := result and docEditor.CanSpellCheck and (not Locked)
    else
      result := False;         //otherwise no checking
end;

procedure TContainer.SpellCheck(section: Integer);
begin
  case section of
    cmdToolSpellWord:   DoSpellCheckWord;

    cmdToolSpellPage:   DoSpellCheckPage;

    cmdToolSpellReport: DoSpellCheckReport;
  end;
end;

procedure TContainer.LoadUserLogo;
var
  f:Integer;
begin
  f := 0;
  if (docForm <> nil) then
    while (f < docForm.count) do
      begin
        docForm[f].LoadUserLogo;
        inc(f);
      end;
end;

// this dialog calls DoFindNReplace from UFindAndReplace
procedure TContainer.FindAndReplace;
begin
	if (docForm.count > 0) then
    begin
		  if FindNReplace = nil then
        FindNReplace := TFindNReplace.Create(self);
      FindNReplace.Show;
    end;
end;

//github #537: this is for FindNReplace routine to work properly
//Each time we bring up Find and Replace dialog, always call this routine to move the active cell to the top
procedure TContainer.SetActiveCell;
var
  form: TDocForm;
  page: TDocPage;
  cell: TBaseCell;
  f, p, c: Integer;
begin
  docActiveCell := nil;
  for f := 0 to docForm.Count - 1 do  // iterate on forms
    begin
      form := docForm[f];
      for p := 0 to form.frmPage.Count - 1 do  // iterate on form pages
        begin
          page := form.frmPage[p];
          for c := 0 to page.PgData.Count - 1 do  // iterate on page cells
            begin
              cell := (page.pgData[c] as TBaseCell);
              if assigned(cell) then
                begin
                  docActiveCell := cell;
                  Exit;
                end;
            end;
        end;
    end;
end;


// these are calls that can be used for search n replace
// StringReplace(SearchText, FStr, RStr, [rfIgnoreCase])
// StringReplace(SearchText, FStr, RStr, [rfIgnoreCase, rfReplaceAll]);
function TContainer.DoFindNReplace(var curCUID: cellUID; var SIndex: Integer;
    FStr, RStr: String; MatchWord: Boolean; Direction: Integer; findFirst: Boolean): Integer;
var
  form: TDocForm;
  page: TDocPage;
  cell: TBaseCell;
	SearchText: String;
	N, f,p,c, zf,zp,zc: Integer;
  stopLooking, saveSelectFlag: Boolean;
  nFinds: Integer; //YF 06.24.02
  switchCell: Boolean;
begin
  saveSelectFlag := IsAppPrefSet(bAutoSelect);
  try
    SetAppPref(bAutoSelect, False);
    stopLooking := False;
    FStr := UpperCase(FStr);
    nFinds := 0; 
    zf := curCUID.form;  //this is where we are starting
    zp := curCUID.Pg;
    zc := curCUID.Num;
    if not Locked and (docForm.Count > 0) and (Length(FStr) > 0) then
      for f := zf to docForm.Count - 1 do  // iterate on forms
        begin
          form := docForm[f];
          for p := zp to form.frmPage.Count - 1 do  // iterate on form pages
            begin
              page := form.frmPage[p];
              for c := zc to page.PgData.Count - 1 do  // iterate on page cells
                begin
                  cell := (page.pgData[c] as TBaseCell);
                  // 112911 JWyatt Move the cell.CanEdit test to the replace sequence
                  //  so that "Find" still works for non-editable cells
                  //  Was: if cell.HasData and cell.CanEdit then
                  if cell.HasData then
                    repeat
                      curCUID := cell.UID;
                      SearchText := cell.GetText;
                      if matchWord and not findFirst then
                        begin
                          if CompareText(SearchText, FStr) <> 0 then
                            begin
                              N:=0;
                            end
                          else
                            N:=1;
                        end
                      else
                        begin
                          Delete(SearchText, 1, SIndex);  // delete previously searched
                          N := Pos(FStr, UpperCase(SearchText));
                          if matchWord and findFirst then
                            if CompareText(SearchText, FStr) <> 0 then
                              N:= 0;
                        end;

                      if (N > 0) then
                        begin
                          Inc(nFinds);
                          N := N + SIndex;
                          SIndex := N + Length(FStr);
                          switchCell := True;
                          //if findFirst and matchWord and (CompareText(SearchText,FStr) <> 0) then
                          //   switchCell := False;
                          if (docActiveCell <> cell) then
                            Switch2NewCell(cell, False);

                          if (docEditor is TTextEditor) then
                            begin
                              if matchWord and (CompareText(FStr, SearchText) =0) then
                                TTextEditor(docEditor).SelectText(1, Length(FStr))
                              else
                                TTextEditor(docEditor).SelectText(N, Length(FStr));
                              if (Length(RStr) > 0) then
                                if cell.CanEdit then
                                  begin
                                    TTextEditor(docEditor).InputString(RStr);
                                    docEditor.SaveChanges;
                                  end
                                else
                                  Dec(nFinds);
                            end;

                          if findFirst then
                            stopLooking := True;
                        end;
                    until stopLooking or (N = 0);

                  SIndex := 0;
                  if stopLooking then
                    break;
                end;  // loop on cells

              zc := 0;  //starting new page, reset cell start
              if stopLooking then
                break;
            end;  // pages loop

          zp := 0;  // starting new form, reset page start
          if stopLooking then
            break;
        end;  // forms loop
  finally
    SetAppPref(bAutoSelect, saveSelectFlag);
  end;

  Result := nFinds;
end;

//the splitter can never go to zero or we lose it, a delphi bug i think
procedure TContainer.docSplitterMoved(Sender: TObject);
begin
	docPageMgrWidth := max(1, docSplitter.left);
  if docPageMgrWidth <= 1 then
    docPref := ClrBit(docPref, bShowPageMgr)
  else
    docPref := SetBit(docPref, bShowPageMgr);
end;

procedure TContainer.SetAutoRsp(Value: Boolean);
begin
	if FDocAutoRspOn <> Value then
		docEditor.AutoRspOn := value;
	FDocAutoRspOn := Value;
end;

procedure TContainer.SetDocUID(Value: Int64);
begin
  FDocUID := Value;
  if assigned(docProperty) then
    docProperty.DocKey := Value;
end;

procedure TContainer.SetZoomScale(Value: Integer);
begin
  FZoomScale := Value;                //save it for reference
  docView.ViewScale := Value;         //do it
  PageMgr.Refresh;
  if Assigned(docEditor) then
    docEditor.ResetScale;
end;

function TContainer.GetLocked: Boolean;
begin
  Result := inherited GetLocked or FReadOnly;
end;

procedure TContainer.SetDataModified(value: Boolean);
begin
  docDataChged := Value;
  if Value then
    begin
      FModificationTime := Now;
      if Assigned(PageNavigator) then
        PageNavigatorUpdateTimer.Enabled := True;
    end;
end;

/// summary: Processes queued document notification messages.
procedure TContainer.DocumentNotificationProc(var Message: TWMDocumentNotification);
begin
  try
    Message.NotificationData.NotifyProc(Message.NotificationData.NotifyInstance,
                                        Message.NotificationData.Msg,
                                        Message.NotificationData.Data);
  except
  end;

  try
    Dispose(Message.NotificationData);
  except
  end;

  Message.NotificationData := nil;
  Message.Result := 0;
end;

procedure TContainer.RichardsCheckUI;
begin
  if false {Main.PleaseDisplayCellIDInTheStatusBar} then
  begin
    if docActiveCell <> nil then
      begin
        with TDocPage(docActiveCell.FParentPage) do
          begin
           docStatus.Panels[2].text := 'Cell ID = ' + IntToStr(docActiveCell.fCellID) +
               '; Sequence Number = ' + IntToStr(docActiveCell.GetCellIndex + 1) +
               '; Form ' + TdocForm(FParentForm).frmInfo.fFormName + ' (' +
               IntToStr(TdocForm(FParentForm).FormID) + ') page ' + IntToStr(FPageNum) +
               '; Cell class = ' + docActiveCell.ClassName;
          end;
      end
    else
       docStatus.Panels[2].text := '';
  end;
end;

procedure TContainer.SynchronizeFormsManager;
begin
  if assigned(docActiveCell) then
    PageMgr.ItemIndex := docView.PageList.IndexOf(TDocPage(docActiveCell.FParentPage).pgDisplay);     //    FPgNum is the visible page number, not necessarily the index

  PageMgr.Refresh;       //  check to see what forms are visible in the viewport
end;

procedure TContainer.SetSignatureLock(Value: Boolean);
begin
  if Value then
    begin
      SaveCurCell;
      LockReport;
    end
  else
    UnlockReport;

  Dispatch(DM_RELOAD_EDITOR, DMS_DOCUMENT, nil);
  UpdateFormMgrButtons;
  UpdateToolbarButtons;
end;

{***************************************}
{  This is code for FreeText Items      }
{  If there is a rewite, these should   }
{  be consolidated into Layer class.    }
{***************************************}

procedure TContainer.SelectMarkupTool(MarkupTool: Integer; IsActive: Boolean);
begin
  case MarkupTool of
    alToolSelect:      //the Selector Tool (Arrow)
      begin
        if IsActive then
          begin
            ActiveLayer := alAnnotate;
            ActiveTool := alToolSelect;
            {Screen.Cursor := crHand set in UPgView}
          end
        else
          begin
            ActiveLayer := alStdEntry;
            ActiveTool := alToolNone;
          end;
      end;
    alToolText:        //the FreeText Tool (Text)
      begin
        if IsActive then
          begin
            ActiveLayer := alAnnotate;
            ActiveTool := alToolText;
            {Screen.Cursor := crIBeam set in UPgView}
          end
        else
          begin
            ActiveLayer := alStdEntry;
            ActiveTool := alToolNone;
          end;
      end;
  end;
end;

procedure TContainer.MarkupCmdHandler(MarkupCmd: Integer; IsActive: Boolean);
begin
  if ActiveLayer = alAnnotate then
    if ActiveTool <> MarkupCmd then
      begin
        SelectMarkupTool(ActiveTool, False);          //deactive previous
        SelectMarkupTool(MarkupCmd, IsActive);        //activate new
      end
    else
      SelectMarkupTool(MarkupCmd, False)              //just deactivate
  else
    SelectMarkupTool(MarkupCmd, IsActive);            //activate new
end;

procedure TContainer.SetActiveEditor(value: TEditor);
begin
  case FActiveLayer of
    alAnnotate: FMarkupEditor := Value;
  end;
end;

function TContainer.GetActiveEditor: TEditor;
begin
  case FActiveLayer of
    alStdEntry:
      if Assigned(docActiveCell) then
        Result := docActiveCell.Editor as TEditor
      else
        Result := nil;
    alAnnotate:   result := FMarkupEditor;
    alTabletInk:  result := nil;
  else
    result := nil;
  end;
end;

procedure TContainer.SetActiveLayerMenus(const Value: Integer);
var
  CanEnable: Boolean;
  IsStdEntry: Boolean;
  DocHasForms: Boolean;
  DocNotLocked: Boolean;
begin
  DocHasForms := (docForm.count > 0);
  DocNotLocked := not Locked;
  IsStdEntry := (Value = alStdEntry);
  CanEnable := IsStdEntry and DocHasForms and DocNotLocked;

  main.tbtnMapLabel.Enabled := CanEnable;
  main.tbtnLabelLib.Enabled := CanEnable;
  main.tbtnFileNew.Enabled := IsStdEntry;     //CanEnable;
  main.tbtnFileOpen.Enabled := IsStdEntry;    //CanEnable;
  main.tbtnStartTemps.Enabled := IsStdEntry;  //CanEnable;
end;

procedure TContainer.SetActiveToolMenus(const value: Integer);
var
  NotSelectorTool: Boolean;
begin
  if value = alToolSelect then
    Main.ToolSelectCmd.ImageIndex := 46           //selected look
  else if value = alToolText then
    Main.ToolFreeTextCmd.ImageIndex := 36         //turn it green (on)
  else if value = alToolNone then
    begin
      Main.ToolSelectCmd.ImageIndex := 45;        //hand - unselected look
      Main.ToolSelectCmd.Checked := False;
      Main.ToolFreeTextCmd.ImageIndex := 35;      //text - unslected look
      Main.ToolFreeTextCmd.Checked := False;

      if (Screen.Cursor <> crHourglass) then
        Screen.Cursor := crDefault;
    end;

  NotSelectorTool := not (Value = alToolSelect);

  main.EditCutCmd.Enabled   := NotSelectorTool;
  main.EditCopyCmd.Enabled  := NotSelectorTool;
  main.EditPasteCmd.Enabled := NotSelectorTool;
  main.EditTxIncreaseCmd.Enabled := NotSelectorTool;
  main.EditTxDecreaseCmd.Enabled := NotSelectorTool;
  main.EditTxBoldCmd.Enabled     := NotSelectorTool;
  main.EditTxItalicCmd.Enabled   := NotSelectorTool;
end;

procedure TContainer.SetActiveTool(const value: Integer);
var
  f: Integer;
begin
  FActiveTool := value;
  for f := 0 to docForm.count-1 do
    docForm[f].ActiveTool := Value;

  SetActiveToolMenus(value);
end;

procedure TContainer.SetActiveLayer(const value: Integer);
var
  f: Integer;
begin
  //we're in Annotation Layer and moving to another layer
  if (FActiveLayer = alAnnotate) and (FActiveLayer <> value) then
    Switch2NewItem(nil, False);     //finalize the Annotation Item

  //we're in Standard Entry Layer and move to another layer
  if (FActiveLayer = alStdEntry) and (FActiveLayer <> value) then
    Switch2NewCell(nil, False);  //finalize the Active Cell

  FActiveLayer := Value;

  for f := 0 to docForm.count-1 do
    docForm[f].ActiveLayer := Value;

  SetActiveLayerMenus(Value);

  if value = alStdEntry then      //set default tool for new layer
    ActiveTool := alToolStdText;
end;

Procedure TContainer.MakeItemActive(Item: TMarkupItem);
begin
	if docActiveItem <> Item then
		Switch2NewItem(Item, cClicked);
end;

procedure TContainer.UnloadActiveItemEditor;
begin
	if assigned(docEditor) then
		begin
			docActiveCellChged := docEditor.FModified;
//reversed save & deactivate
      docEditor.UnHilightCell;
			docEditor.SaveChanges;        			//saves to the current cell
			docActiveItem.SetEditState(False);  //tell cur cell to handle drawing
			docEditor.UnLoadCell;
			docEditor.DeactivateEditor;      		//no more blinking/text highlighting
			docActiveItem.Editor := nil;

      docActiveItem := nil;
		end;
end;

procedure TContainer.LoadActiveItemEditor(clicked: Boolean);
begin
	if docActiveItem <> nil then
		begin
			docEditor := TEditor(docActiveItem.GetEditor);    //get editor for this cell
			if assigned(docEditor) then
			begin
				docActiveItem.Editor := docEditor;  			//ref the editor from the Item
				docEditor.LoadItem(docActiveItem);  		  //load item specs
				docActiveItem.SetEditState(True);   			//tell cell that editor will take over
				docEditor.InitCaret(clicked);
				docEditor.ActivateEditor;       					//now activate it - open for business
			end;
	  end;
end;

procedure TContainer.Switch2NewItem(newItem: TMarkupItem; clicked: Boolean);
var
	curFocus: TFocus;
	DC: HDC;
begin
	DC := docView.Canvas.Handle;
	if assigned(docActiveItem) then
		begin
			GetViewFocus(DC, curFocus);
			docActiveItem.FocusOnItem;
			UnloadActiveItemEditor;
			docActiveItem := nil;
      FreeAndNil(FMarkupEditor);               //not used, free it
			SetViewFocus(DC, curFocus);
		end;

	if assigned(newItem) then
		begin
			docActiveItem := NewItem;									//this is the cell to edit
//    ShowCurCell;                						  //make sure its visible
			GetViewFocus(DC, curFocus);
			docActiveItem.FocusOnItem;
      LoadActiveItemEditor(clicked);            //load the editor for it.
			SetViewFocus(DC, curFocus);
		end;
end;


{Routines for handling color properties of TContainer}
function TContainer.GetPenColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clBlack
	else
		result := docColors[cFormLnColor];		//appPref_FormFrameColor;
end;

function TContainer.GetInfoCellColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clWhite
	else
		result := docColors[cFormLnColor];		//appPref_FormFrameColor;
end;

function TContainer.GetFormFontColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clBlack
	else
		result := docColors[cFormTxColor];		//appPref_FormTextColor;
end;

function TContainer.GetDataFontColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clBlack
	 else
		result := docFont.Color;		//appPref_InputFontColor;
end;

function TContainer.GetMarkupFontColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clBlack
	 else
		result := docColors[cFreeTxColor];
end;

function TContainer.GetBrushColor(isPrinting: Boolean): TColor;
begin
	if isPrinting then
		result := clBlack
	else
		result := docColors[cFormLnColor];	//colorFormFrame1;
end;

function TContainer.GetDocPref(Index: Integer): Boolean;
begin
  result := IsBitSet(docPref, Index);
end;

procedure TContainer.SetDocPref(Index: Integer; Value: Boolean);
begin
  if value then
    docPref := ClrBit(docPref, Index)
  else
    docPref := SetBit(docPref, Index);
end;


//Write and Read Doc Colors have 10 longs that can be used for other things.
function TContainer.WriteDocColors(Stream: TStream): Boolean;
var
  i: Integer;
  amt: LongInt;
  zeroOut: TColorRec;
begin
  for i := 1 to cMaxNumColors do zeroOut[i] := 0;

  amt := SizeOf(TColorRec);
  Stream.WriteBuffer(zeroOut, amt);  //History: used to write docColors
  result := True;
end;

function TContainer.ReadDocColors(Stream: TStream): Boolean;
var
  amt: LongInt;
begin
  amt := SizeOf(TColorRec);            //here for history, used to read docColors
  Stream.Seek(amt, soFromCurrent);     //just skip
  result := true;
end;

function TContainer.ReadDocSignatures(Stream: TStream): Boolean;
begin
  result := True;
  docSignatures.ReadFromStream(Stream);
end;

function TContainer.ReadDocSignatures2(Stream: TStream; bShowMessage:Boolean): Boolean;
begin
  result := True;
  docSignatures.ReadFromStream2(Stream, bShowMessage);
end;


function TContainer.WriteDocSignatures(Stream: TStream): Boolean;
begin
  result := True;
  docSignatures.WriteToStream(Stream);
end;

function TContainer.ReadDocDataItems(Stream: TStream): Boolean;
begin
  result := True;
  docData.ReadFromStream(Stream);
end;

function TContainer.WriteDocDataItems(Stream: TStream): Boolean;
begin
  result := True;
  docData.WriteToStream(Stream);
end;

function TContainer.ReadDocCellAdjusters(Stream: TStream): Boolean;
begin
  result := True;
  docCellAdjusters.ReadFromStream(Stream);
end;

function TContainer.WriteDocCellAdjusters(Stream: TStream): Boolean;
begin
  result := True;
  docCellAdjusters.WriteToStream(Stream);
end;

function TContainer.ReadDocMungedText(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;      //not used

  if Assigned(FMunger) then
    FMunger.LoadFromStream(Stream)
  else begin //skip
    dataSize := ReadLongFromStream(Stream);
    result := datasize > 0;      //to avoid warning
  end;
end;

function TContainer.WriteDocMungedText(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;

  if Assigned(FMunger) then
    FMunger.SaveToStream(Stream)
  else begin  //set 0
    dataSize := 0;
    WriteLongToStream(dataSize, Stream);
  end;
end;


{**********************************************************************}
{  These are the future data read/write routines. Use these as data is }
{ added to the doc file.                                               }
{**********************************************************************}


function TContainer.ReadFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData5(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData6(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData7(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData8(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData9(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData10(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData11(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData12(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData13(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData14(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData15(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData16(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData16(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData17(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData17(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData18(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData18(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData19(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData19(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData20(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData20(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData21(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData21(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData22(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData22(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData23(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData23(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData24(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData24(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData25(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData25(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData26(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData26(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData27(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData27(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData28(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData28(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData29(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData29(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

function TContainer.ReadFutureData30(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData30(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;

{function TContainer.ReadFutureData31(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  dataSize := ReadLongFromStream(Stream);
  result := datasize > 0;      //just to avoid warning
end;

function TContainer.WriteFutureData31(Stream: TStream): Boolean;
var
  dataSize: LongInt;
begin
  result := True;
  dataSize := 0;
  WriteLongToStream(dataSize, Stream);
end;         }

function TContainer.GetAutoPgNumbers: Boolean;
begin
  result := docForm.AutoNumberPages;
end;

procedure TContainer.SetAutoPgNumbers(const Value: Boolean);
begin
  docForm.AutoNumberPages := Value;     //pass the value on
  BuildContentsTable;                   //rebuild some TofC
  docView.Invalidate;                   //redisplay it
end;

function TContainer.GetDisplayPgNums: Boolean;
begin
  result := docForm.DisplayPgNumbers;
end;

procedure TContainer.SetDisplayPgNums(const Value: Boolean);
begin
  docForm.DisplayPgNumbers := value;
end;

function TContainer.GetManualStartPg: Integer;
begin
  result := docForm.StartPageNumber;
end;

function TContainer.GetManualTotalPg: Integer;
begin
  result := docform.TotalPageNumber;
end;

procedure TContainer.SetManualStartPg(const Value: Integer);
begin
  docForm.StartPageNumber := Value;
end;

procedure TContainer.SetManualTotalPg(const Value: Integer);
begin
  docform.TotalPageNumber := value;
end;

procedure TContainer.PageMgrDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  VISUAL_MARGIN = 20;
var
  origCl: TColor;
  formID: LongInt;
  dPage: TDocPage;
  TopY, BottomY : Integer;
begin
  formID := 0;
  PageMgr.Canvas.FillRect(Rect);
  if Index >= 0 then
    begin
      dPage := GetPageByPageMgrIndex(Index);
      if assigned(dPage) then
        formID := dPage.GetPageOwnerID;

      //Bold the page names to indicate they are the ones currently on screen

      if assigned(docView) then //sometimes called on doc.destroy & PageList is already freed.
        with TPageBase(docView.PageList[Index]).PgView do
          begin
            TopY := docView.Doc2Client(TopLeft).Y;
            BottomY := docView.Doc2Client(BottomRight).Y;

            if ((TopY >= VISUAL_MARGIN) and (TopY <= (docView.Height - VISUAL_MARGIN))) or
               ((BottomY >= VISUAL_MARGIN) and (BottomY <= (docView.Height - VISUAL_MARGIN))) or
               ((TopY < VISUAL_MARGIN) and (BottomY > (docView.Height - VISUAL_MARGIN))) then
              begin
                PageMgr.Canvas.Font.Style := PageMgr.Canvas.Font.Style + [fsBold];
              end;
           end;
      origCl := PageMgr.Canvas.Font.Color;
      if ActiveFormsMgr.IsArchivedForm(formID) then
        PageMgr.Canvas.Font.Color := clRed;

      PageMgr.Canvas.TextOut(Rect.Left + 2, Rect.Top, PageMgr.Items[Index]);
      PageMgr.Canvas.Font.Color := origCl;
      PageMgr.Canvas.Font.Style := [];
    end;
end;

function TContainer.GetFreezeCanvas : Boolean;
begin
  Result := FFreezeCanvasCounter > 0;
end;

procedure TContainer.SetFreezeCanvas(Value : Boolean);
begin
  if Value then
    begin
      Inc(FFreezeCanvasCounter);
      if FFreezeCanvasCounter = 1 then
        LockWindowUpdate(Self.Handle);
    end
  else if FFreezeCanvasCounter > 0 then
    begin
      Dec(FFreezeCanvasCounter);
      if FFreezeCanvasCounter = 0 then
        begin
          LockWindowUpdate(0);
        end;
    end;
end;

{function TContainer.DocHasLargeImages(var count: Integer): Boolean;
var
  f,p,c: Integer;
  aCell: TBaseCell;
  imgSize: Integer;
begin
  result := False;
  count := 0;
  for f := 0 to docForm.count-1 do
    for p := 0 to docForm[f].frmPage.count-1 do
      if assigned(docForm[f].frmPage[p].PgData) then  //does page have cells?
      for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
        begin
          aCell := docForm[f].frmPage[p].PgData[c];
          if aCell is TGraphicCell then
            if TGraphicCell(aCell).FImage.HasDib then    //do not include metafiles
              begin
                imgSize := TGraphicCell(aCell).FImage.ImageFileSize;
                imgSize := Round(imgSize/1000);         //round to integer K
                if imgSize > appPref_ImageSizeThreshold then
                  begin
                    result := True;
                    inc(count);
                  end;
              end;
        end;
end; }

function TContainer.DocNeedsReviewing: Boolean;
begin
  result := False;
  if appPref_AppraiserAutoRunReviewer then     //wants to auto-review
    if not docHasBeenReviewed then             //not previously reviewed
      begin
        ReviewReport;
        docHasBeenReviewed := True;            //don't do this again
        result := True;                        //don't close the window
      end;
end;

{function TContainer.DocNeedsImageOptimization: Boolean;
var
  msg: String;
  count: Integer;
begin
  result := False;
  if appPref_CheckForLargeImages and DocHasLargeImages(count) then
    begin
      msg := 'The report contains '+ IntToStr(count) + ' images with a size greater than ' +
             IntToStr(appPref_ImageSizeThreshold) + 'K. Do you want to reduce their size?';

      result := OK2Continue(msg);
      if result then
        LaunchImageEditor(self);
    end;
end; }

function TContainer.FormCount : Integer;
begin
  if docForm = nil then
    Result := 0
  else
    Result := docForm.Count;
end;

procedure TContainer.SelectForm(AnIndex : Integer);
begin
  SelectSheet(FirstPageOfForm(AnIndex));
end;

procedure TContainer.SelectSheet(AnIndex : Integer);
var
  y, x : Integer;
begin                                                       //so select the first page
  if PageMgr.ItemIndex <> AnIndex then
    PageMgr.ItemIndex := AnIndex;

  if TPageBase(DocView.PageList[AnIndex]).PgCollapsed then
    docView.TogglePageView(AnIndex, cOpenPage);

  y := TPageBase(DocView.PageList[AnIndex]).PgOrg.y;
  x := DocView.HorzScrollBar.Position;
  if ControlKeyDown then
    docView.ScrollPt2Top(0, Y)                          //normal mode, auto scroll
  else
    docView.ScrollPt2Top(X, Y);                         //don't auto scroll to left

  PageMgr.Refresh;
end;

function TContainer.FirstPageOfForm(AFormIndex : Integer): Integer;
var
  FormCounter, PageCounter : Integer;
begin
  Result := 0;
  for FormCounter := 0 to FormCount - 1 do
    begin
      if FormCounter = AFormIndex then
        Exit;     //  Result has the correct value

      for PageCounter := 0 to docForm[FormCounter].frmPage.Count - 1 do
        Inc(Result);
    end;
  Result := -1;   //  form index not found
end;

{ Forms Mgr Popup Menu Click}

procedure TContainer.FormManagerPopupPopup(Sender : TObject);
var
  formIdx: Integer;
  thisForm: TDocForm;
  shortName: String;
begin
  FMPopCopyFormNameMItem.Visible := False;
  
  with PageMgr do
    begin
      if ItemIndex = -1 then   //something needs to be selected
        begin
          FMPopCopyFormNameMItem.Enabled := False;

          FMPopDuplicateMItem.Enabled := False;
          FMPopDeleteMItem.Enabled := False;
          FMPopMoveToTopMItem.Enabled := False;
          FMPopMoveUpMItem.Enabled := False;
          FMPopMoveDownMItem.Enabled := False;
          FMPopMoveToBottomMItem.Enabled := False;
        end
      else if count > 0 then   //make sure we have form pages
        begin
          thisForm := TDocForm(TDocPage(TPageBase(DocView.PageList[ItemIndex]).FDataParent).FParentForm);
          formIdx := docForm.IndexOf(thisForm);     // get the forms index
          shortName := thisForm.frmInfo.fFormName;

          FMPopDeleteMItem.Enabled := True;
          FMPopDeleteMItem.Caption := 'Delete ' + shortName;
          FMPopDuplicateMItem.Enabled := True;
          FMPopDuplicateMItem.Caption := 'Add another ' + shortName;
          FMPopCopyFormNameMItem.Enabled := True;

          if formIdx = 0 then
            begin
              FMPopMoveToTopMItem.Enabled := False;
              FMPopMoveUpMItem.Enabled := False;
              FMPopMoveDownMItem.Enabled := True;
              FMPopMoveToBottomMItem.Enabled := True;
            end
          else if formIdx = docForm.Count - 1 then
            begin
              FMPopMoveToTopMItem.Enabled := True;
              FMPopMoveUpMItem.Enabled := True;
              FMPopMoveDownMItem.Enabled := False;
              FMPopMoveToBottomMItem.Enabled := False;
            end
          else
            begin
              FMPopMoveToTopMItem.Enabled := True;
              FMPopMoveUpMItem.Enabled := True;
              FMPopMoveDownMItem.Enabled := True;
              FMPopMoveToBottomMItem.Enabled := True;
            end;
        end;
    end;
end;

procedure TContainer.FMPopupExecuteClick(Sender: TObject);
var
  thisForm: TDocForm;
  NewForm: TDocForm;
  N, formIdx: Integer;
  FormUID: TFormUID;
begin
  N := PageMgr.ItemIndex;
  if N > -1 then  //somethng has to be selected
    case (Sender as TMenuItem).tag of

      1:  {Add another similar form}
        begin
          thisForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
          formIdx := docForm.IndexOf(thisForm);     // get the forms index
          FormUID := TFormUID.Create;
          try
            FormUID.ID := thisForm.frmSpecs.fFormUID;       // this is form ID
            FormUID.Vers := thisForm.frmSpecs.fFormVers;    // its version number
            NewForm := InsertFormUID(FormUID, True, formIdx+1);        // insert after formIdx
            if  PromptLinkWordProcessorPages(thisForm, NewForm) then
              LinkWordProcessorPages(thisForm, NewForm);
            docForm.RenumberPages;                          //renumber the pages
            docForm.ReConfigMultiInstances;
            BuildContentsTable;                             //rebuild the table of contents
            UpdateTableCells;                               //update text in cells associated by tables
            ResetCurCellID;                                 //reset the cur cell UID
          finally
            FormUID.Free;  
          end;
        end;

      2:  {Move to Top}
        begin
          thisForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
          formIdx := docForm.IndexOf(thisForm);     // get the forms index
          MoveForm(formIdx, 0);
        end;

      3:  {Move Up}
        begin
          MoveFormsUpDownClick(tbtnUp);
        end;

      4:  {Move Down}
        begin
          MoveFormsUpDownClick(tbtnDown);
        end;

      5:  {Move To Bottom}
        begin
          thisForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
          formIdx := docForm.IndexOf(thisForm);       // get the forms index
          MoveForm(formIdx, docForm.count-1);
        end;

      6:  {Delete form}
        begin
          DeleteFormClick(Sender)
        end;

      7:  {copy form name}
        begin
          ThisForm := TDocForm(TDocPage(TPageBase(DocView.PageList[N]).FDataParent).FParentForm);
          Clipboard.AsText := ThisForm.frmInfo.fFormName;
        end;
    end;
end;

{function TContainer.GetAreaSketchCell: TSketchCell;       do not used
var
  frmIndex: Integer;
  form: TDocForm;
  sketchCell: TSketchCell;
  // skTyp: integer;
begin
  result := nil;
  if docForm.Count = 0 then
    exit;
  for frmIndex := 0 to docForm.count-1 do     			//run thru docforms
      begin
        form := docForm[frmIndex];
        if ((form.FormID > 200) and (form.FormID < 206)) or
          (form.FormID = 385) or
          (form.FormID = 4182)
          then//cSkFormLegalUID then //All sketch programs load sketches only on legal size Sketch page
          begin
            sketchCell := TSketchCell(form.GetCellByID(cidSketchImage));
            if assigned(sketchCell) then
              begin
             /*
                if (SketchCell.GetMetaData>1) and
                  (SketchCell.GetMetaData<9) and (SketchCell.GetMetaData<>3) then
                  skTyp := SketchCell.FMetaData.FUID
                  else
                  skTyp := -1;
              */
                result := sketchCell;
                break;
              end;
          end;
      end;
end;         }
{ not used
function TContainer.GetSketchCell(mdSketchType: integer; var SkTyp: integer): TSketchCell;
var
  frmIndex: Integer;
  form: TDocForm;
  sketchCell: TSketchCell;
begin
  result := nil;
  if docForm.Count = 0 then
    exit;
  for frmIndex := 0 to docForm.count-1 do     			//run thru docforms
      begin
        form := docForm[frmIndex];
        if form.FormID = cSkFormLegalUID then //All sketch programs load sketches only on legal size Sketch page
          begin
            sketchCell := TSketchCell(form.GetCellByID(cidSketchImage));
            skTyp := SketchCell.FMetaData.FUID;
            if assigned(sketchCell) and SketchCell.HasMetaData(mdSketchType) then
              begin
                result := sketchCell;
                break;
              end;
          end;
      end;
end;           }

 { not used
procedure Tcontainer.DeleteDocSketches;
var
  frmIndex: Integer;
  form: TDocForm;
  moveCurCell: Boolean;
  formDeleted: Boolean;
begin
  if not (docData.HasData('ApexSketch') or docData.HasData('WinSketch') or docData.HasData('RAPIDSKETCH'))   then
    exit;
  moveCurCell := False;
  formDeleted := False;
  //delete sketch forms
  if (docForm.count > 0) and WarnOK2Continue('Are you sure you want to delete all sketches from your report?') then
    for frmIndex := 0 to docForm.count-1 do     			//run thru docforms
      begin
        form := docForm[frmIndex];
        if form.FormID = cSkFormLegalUID then  //all sketch programs load sketch only into legal size page
          begin
            if not moveCurCell then  //check if we are removing the cur cell's form
              moveCurCell := docActiveCell.UID.form = frmIndex;
            formDeleted := True;
            docForm[frmIndex].Free;        //free the form
            docForm[frmIndex] := nil;
          end;
      end;
  //delete sketch data
      if docData.HasData('ApexSketch') then
        docData.DeleteData('ApexSketch')
      else if docData.HasData('WinSketch') then
              docData.DeleteData('WinSketch')
            else if docData.HasData('RAPIDSKETCH') then
                    docData.DeleteData('RAPIDSKETCH');
  //rearrange report
  if formDeleted then     //we really delete something
    begin
     docForm.Pack;
      docView.ResequencePages;
      docForm.RenumberPages;              //renumber the pages
      BuildContentsTable;                 //rebuild table of contents
      docForm.ReConfigMultiInstances;     //redo the instance settings
      BuildPageMgrList;
      DisplayPageCount;

      if moveCurCell then
        RemoveCurCell         //form has been deleted, remove editor/curcell
      else
        ResetCurCellID;       //form is still there, just reset IDs
    end;
end;            }

{wrote the new function
function TContainer.GetReportGeocodes: string;
const
  cidLocMapCellID = 1158;
var
  mapCell: TBaseCell;
  mapState: String;
  xmlresult: IXMLDOMDocument3;
  resultRootNode: IXMLDOMNode;
  index: Integer;
  mapUIDs: cellUIDArray;
 begin
  result := '';
  xmlResult := CoDomDocument60.Create;
  xmlResult.setProperty('SelectionLanguage','XPath');
  xmlResult.documentElement := xmlResult.createElement(tagGeocodes);
  resultRootNode := xmlResult.documentElement;

  mapUIDs := GetCellsByID(cidLocMapCellID);

  for index := 0 to length(mapUIDs) - 1 do
    begin
      mapCell := GetCell(mapUIDs[index]);
      if not (mapCell is TMapLocCell) then
        continue;
      mapState := TMapLocCell(mapCell).BingMapsData;
      if length(mapState) = 0 then
        continue;
      AddMapDataGeocodes(xmlResult,mapState);
    end;
  result := xmlResult.xml;
 end;       }

 //the new function get geocode for ENV from grid rather than from map cell' map state XML
function TContainer.GetReportGeocodes: string;
  procedure AddGeocodeElement(comp: TCompColumn; compType: string; var geoCodes: IXMLDOMDocument3);
  var
    newElem: IXMLDOMNode;
    attr: IXMLDOMAttribute;
    geoCell: TGeocodedGridCell;
  begin
    geoCell := comp.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
    if not (assigned(geoCell) and (abs(geoCell.Latitude) > 0) and (abs(geoCell.Longitude) > 0)) then
      exit;
    newElem := geoCodes.CreateNode(NODE_ELEMENT,tagGeocode,'');
    addAttribute(newElem, tagCompType, compType);
    addNode(newElem, tagLatitude, floattostr(geoCell.Latitude));
    addNode(newElem,tagLongitude, floattostr(geoCell.Longitude));
    addNode(newElem, tagProvider, 'Microsoft');
    geoCodes.documentElement.appendChild(newElem);
  end;

var
  CompCol: TCompColumn;
  GeoCodedCell: TGeocodedGridCell;
  aDocCompTable, aDocListTable, aDocRentalTable: TCompMgr2;
  xmlresult: IXMLDOMDocument3;
  resultRootNode: IXMLDOMNode;
  curGridType: integer;
  compNo: integer;
  subjComp: TCompColumn;
  cntr: Integer;
begin
  result := '';
  subjComp := nil;
  xmlResult := CoDomDocument60.Create;
  xmlResult.setProperty('SelectionLanguage','XPath');
  xmlResult.documentElement := xmlResult.createElement(tagGeocodes);
  resultRootNode := xmlResult.documentElement;
  try
    //Build Sales compGridStructure
    aDocCompTable := TCompMgr2.Create(True);
    aDocCompTable.BuildGrid(self, gtSales);

    //Listing comp grid structure
    aDocListTable := TCompMgr2.Create(True);
    aDocListTable.BuildGrid(self, gtListing);

    //Build Rental comp grid structure
    aDocRentalTable := TCompMgr2.Create(True);
    aDocRentalTable.BuildGrid(self, gtRental);
   //add subject
  //if assigned(aDocCompTable) then //grid exists even does not have any columns
  if aDocCompTable.Count > 0 then
    subjComp := aDocCompTable.Comp[0]
  //else if assigned(aDocListTable) then
  else if aDocListTable.Count > 0 then
    subjComp := aDocListTable.Comp[0]
  //else if assigned(aDocRentalTable) then
  else if aDocRentalTable.Count > 0 then
    subjComp := aDocRentalTable.Comp[0];
  if assigned(subjcomp) then
    AddGeocodeElement(subjcomp, 'subject0', xmlResult)
  else
    exit;

  if assigned(aDocCompTable) then
    for cntr := 1 to aDocCompTable.Count - 1 do
      AddGeocodeElement(aDocCompTable.Comp[cntr], 'sales' + IntToStr(cntr), xmlResult);

  if assigned(aDocListTable) then
    for cntr := 1 to aDocListTable.Count - 1 do
      AddGeocodeElement(aDocListTable.Comp[cntr], 'listing' + IntTostr(cntr), xmlResult);

   if assigned(aDocRentalTable) then
    for cntr := 1 to aDocRentalTable.Count - 1 do
      AddGeocodeElement(aDocRentalTable.Comp[cntr], 'rental' + IntToStr(cntr), xmlResult);

  result := xmlResult.xml;
  
  finally
    if assigned(ADoccompTable) then
      aDocCompTable.Free;
    if assigned(ADocListTable) then
      aDocListTable.Free;
    if assigned(ADocRentalTable) then
      aDocRentalTable.Free;
  end;
end;

function TContainer.GetDocSketchType(var cell: TBaseCell): Integer;
var
  skCells: cellUIDArray;
  cntr: Integer;
  curCell: TBaseCell;
begin
  result := -1;
  cell := nil;
  setlength(skCells,0);
  skCells := GetCellsByID(cidSketchImage);
  if length(skCells) = 0 then
    exit;
  for cntr := low(skCells) to high(skCells) do
    begin
      curCell := GetCell(skCells[cntr]);
      if assigned(curCell) and (curCell is TSketchCell) then
        begin
          result := curCell.GetMetaData;
          if result >= 0 then
            begin
              cell := curCell;
              break;
            end;
        end;
    end;
 //for very old reports where skketch data file was part of doc data
 if result < 0 then
  begin
    if docData.HasData('AREASKETCH') then
      begin
        result := mdAreaSketchData;
        exit;
      end;
    if docData.HasData('APEXSKETCH') then
      begin
        result := mdApexSketchdata;
        exit;
      end;
     if docData.HasData('WINSKETCH') then
      begin
        result := mdWinSketchData;
        exit;
      end;
     if docData.HasData('RAPIDKETCH') then
      begin
        result := mdRapidSketchData;
        exit;
      end;
     //PhoenixSketch have been added in 2012 and cannot be in doc data
  end;
end;


//# Special Paste data from Redstone
procedure TContainer.PasteRedstoneForms;
var
  doc: TContainer;
  filePath, srcFile, srcFile2, srcFile3, srcFile4: String;
  tag: integer;
  clpbrdTx: WideString; //ticket #1171: Pam make it widestring
  sl, sl2, sl3,sl4 : TStringList;
  ExportF,ExportF2, ExportF3, ExportF4: TextFile;
  idx, idx2, idx3,i, f: Integer;
  lastChar: String;
  overrideData, goOn: Boolean;
  isOverride: Boolean;
  aOption: Integer;
  aCount,formIdx: Integer;
  mainFormID, formCertID: Integer;
  //Return True if we found at least one of the main form exists in the container and the main address is not EMPTY
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
            340, 349, 345, 347, 355, 4131, 4136, 4195, 4215, 4230, 4220, 4218:
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


function GetClipBoardDataAsString(Format: Word): WideString;
  var
    Data: THandle;
  begin
     Data := GetClipboardData(Format);
     try
      if Data <> 0 then
        Result := PChar(GlobalLock(Data))
      else
        Result := '';
     finally
        if Data <> 0 then GlobalUnlock(Data);
     end;
  end;
begin
  doc := Main.ActiveContainer;
  if assigned(doc) then
   begin
    doc.docCellAdjusters.Path := appPref_AutoAdjListPath;   //set the autoAdj pref
    doc.SetupUserProfile(true);
     ClipBoard.Open;
     try
     if IsClipboardFormatAvailable(CF_RedStoneData) then  //#Header
       begin
//          filePath  := VerifyInitialDir(appPref_DirLastSave, appPref_DirReports);
          filePath  := GetTempFolderPath;  //pam: use temp folder to store files
          lastChar  := copy(filePath, length(filePath), length(filePath));
          if pos('\',lastChar) = 0 then  //we need to add one
            filePath := filePath + '\' ;
          if not DirectoryExists(filePath) then
            begin
              ShowNotice(Format('Invalid File Path: %s.  Please check your Report File Path again.',[filePath]));
              exit;
            end;
          //check
          srcFile   := filePath + 'tmp_data.txt';
          srcFile2  := filePath + 'tmp_data_All.txt';
          srcFile3  := filePath + 'tmp_chartdata.txt';  //github #786
          srcFile4  := filePath + 'tmp_mapdata.txt';    //github #786
          //Remove the file before put in a new one
          if FileExists(srcFile) then
            DeleteFile(srcFile);
          if FileExists(srcFile2) then
            DeleteFile(srcFile2);
          if FileExists(srcFile3) then
            DeleteFile(srcFile3);
          if FileExists(srcFile4) then
            DeleteFile(srcFile4);

          AssignFile(ExportF, srcFile);
          AssignFile(ExportF2, srcFile2);
          AssignFile(ExportF3, srcFile3);
          AssignFile(ExportF4, srcFile4);
          try
            clpbrdTx := GetClipBoardDataAsString(CF_RedStoneData);
            sl  := TStringList.Create;
            sl2 := TStringList.Create;
            sl3 := TStringList.Create;
            sl4 := TStringList.Create;
            try
              sl.Text := clpBrdTx;
              idx := sl.IndexOf('CMD.LOAD.ALL');   //locate the separator between Redstone forms and all data forms
              idx2 := sl.Indexof('CMD.LOAD.CHARTDATA');
              idx3 := sl.IndexOf('CMD.LOAD.MAPDATA');
              ReWrite(ExportF);
              Rewrite(ExportF2);
              Rewrite(ExportF3);
              Rewrite(ExportF4);


              Write(ExportF, clpbrdTx);
              clpbrdTx := '';
              sl2.Clear;
              aCount := sl.Count;
              if idx2 = -1 then  //this is backward compatible to handle old version
                begin
                  for i:= idx+1 to aCount -1 do
                    sl2.Add(sl[i]);
                  clpbrdTx := sl2.Text;
//                  ReWrite(ExportF2);
                  Write(ExportF2, clpbrdTx);
                end
              else  //this means we have chart data
                begin
                  for i:= idx+1 to idx2-1 do
                    sl2.Add(sl[i]);
                  clpbrdTx := sl2.Text;
//                  ReWrite(ExportF2);
                  Write(ExportF2, clpbrdTx);
                  //handle chart data
                  if idx2 <> -1 then //we have chart data
                    begin
                      for i:= idx2 to idx3 -1 do
                        sl3.add(sl[i]);
                      clpbrdTx := sl3.text;
//                      Rewrite(ExportF3);
                      Write(ExportF3, clpbrdTx);
                    end;
                  //handle chart data
                  if idx3 <> -1 then //we have chart data
                    begin
                      for i:= idx3 to aCount -1 do
                        sl4.add(sl[i]);
                    clpbrdTx := sl4.text;
//                    Rewrite(ExportF4);
                    Write(ExportF4, clpbrdTx);
                    end;
                end;

            finally
              sl.Free;
              sl2.Free;
              sl3.Free;
              sl4.Free;
            end;
          finally
            CloseFile(ExportF);
            CloseFile(ExportF2);
            CloseFile(ExportF3);
            CloseFile(ExportF4);
            goOn := True;
            mainFormID := GetMainFormID(self);
            //if MainFormExist(self, mainFormID) then
            if MainFormID > 0 then
              begin
                aOption:= WhichOption123Ex(isOverride, 'Overwrite', 'Don''t Overwrite', 'Cancel',
                //github #198
                'Would you like to overwrite the existing data in your report with the new data from Redstone? ', 100, False);
                if aOption = mrYes then
                  OverrideData := True
                else if aOption = mrNo then  //user pick no button, so no override, only fill in EMPTY cell
                  OverrideData := False
                else  //user picks cancel button
                  goOn := False;  //cancel
              end;


            if goOn then
              begin
                //if the container has form# 4195, then load chart data
                if (GetFormIndex(mainFormID) <> -1) then
                  begin
                    ImportRedstoneChartData(srcFile3, OverrideData); //github #786
                    ImportRedstoneMapData(MainFormID, srcFile4, OverrideData); //github #786
                  end;
                    FormCertID := GetFormCertID(MainFormID); //Ticket #966: use the main form id to get the cert form for that form id
                    if formCertID > 0 then
                      begin
                        if not assigned(GetFormByOccurance(formCertID,0,false)) then
                        begin
                          formIdx := GetFormIndex(MainFormID);  //Tickt #966
                          if formIdx <> -1 then
                            formIdx := FormIdx +1;  //make sure we add after the 1004
                          InsertBlankUID(TFormUID.Create(FormCertID), true, formIdx, False);
                        end;
                      end;
                  ImportFromRedStone(srcFile, OverrideData);// the main line to import RedStone Data
                  ImportRedStoneData(self, srcFile2, OverrideData);
                end;
                //Ticket # 1532 do not populate context id here.
                //We only import data to the cell.
               // for i := 0 to doc.docForm.Count - 1 do
               //   PopulateFormContext(doc.docForm[i]); //need this to populate the header info
               BroadcastFormContext(GetFormByOccurance(FormCertID, 0, false));  //certificate page
             end;
            // delete file after
//            DeleteFile(srcFile);
//            DeleteFile(srcFile2);
//            DeleteFile(srcFile3);
//            DeleteFile(srcFile4);
       end
      else
        MessageDlg('There is no Redstone Data on the Clipboard', mtInformation, [mbOK], 0);
     finally
       Clipboard.Close;
     end;
   end;
end;

//# special paste data from RedStone Software - Jeferson. 03/07/2015
procedure TContainer.ImportFromRedStone(Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false);
const
  actNone       = 0;
  actBroadcast  = 1;
var
	ImportF: TextFile;
	Str: String;
	frm: TDocForm;
  frm2Broadcast: TDocForm;
  mergeData, firstForm, broadcastIt: Boolean;
  cmdID, frmID, InsID, ActID, OvrID: Integer;
  image: String;
  i,f, idx : integer;

  function LoadForm(FUID: Integer):TDocForm;
	var
    fID: TFormUID;
  begin
    fid := TformUID.Create;
    try
      fid.ID := FUID;
      result := InsertBlankUID(fID, True, -1);
    finally
      fID.free;
    end;
  end;

begin
  if FileExists(TextFilename) then
		try
			AssignFile(ImportF, TextFilename);
			Reset(importF);
      try
        frm := nil;
        frm2Broadcast := nil;
        mergeData := False;
        firstForm := True;
        broadcastIt := False;
        cmdID := 0;
        frmID := 0;
        InsID := 0;
        ActID := 0;
        OvrID := 0;

        while not EOF(importF) do
          begin
            if not EOLN(importF) then          //hack because readLn does not read skips empty lines
              begin
                Read(importF, str);            //read the next string (this should be a Parser)
                Readln(importF);               //go to next line
              end
            else begin
              Readln(importF);
              str := '';
            end;
            if POS('CMD.LOAD.ALL', str) > 0 then exit; //we are done
            if POS('CMD.', str)> 0 then           //check for commands
              begin
                frm := nil;                       //starting new form ???
                cmdID := 0;
                frmID := 0;
                InsID := 0;
                ActID := 0;
                OvrID := 0;
                //new command parser for ClickNOTES
                if ParseCommand(str, CmdID, FrmID, InsID, ActID, OvrID) then  //We just need to pass OvrID but using anywhere here
                  case CmdID of
                    cLoadCmd:
                      begin
                        mergeData := True;        //signal no merge
                        if GetFormIndex(FrmID) = -1 then  //not found
                          begin
                            frm := LoadForm(FrmID);    //Load it
                          end
                        else
                          begin
                            Idx := GetFormIndexByOccur(FrmID, 0);
                            //github #194: only delete the form is we are in overridedata mode
                            if (Idx >= 0) and overrideData then  //if override, delete the form and load in new one
                              begin
                                //DeleteForm(Idx);  //donot delete the form
                                frm := LoadForm(FrmID);    //Load it
                              end;
                          end;
                        mergeData := False;
                      end;
                    cMergeCmd:
                      begin
                        mergeData := True;
                        //frm := docForm.GetFormByOccurance(FrmID, InsID-1); //occur is zero based
                        frm := docForm.GetFormByOccurance(FrmID, InsID); //occur is zero based
                        if frm = nil then
                          begin
                            frm := LoadForm(FrmID);    //nothng to merge, so load the form
                            mergeData := False;
                          end;
                      end;
                    cLoadOrderCmd:
                      begin
                        frm := LoadForm(FrmID);    //Load it
                        mergeData := False;        //signal no merge
                      end;
                    cImportCmd:
                      begin
                        frm := docForm.GetFormByOccurance(FrmID, 0); //occur is zero based
                        firstForm := False;
                        mergeData := False;
                      end;
                  end;
                  //trigger to catch the first form identified, we broadcast it
                  //this is for ClickNOTES to populate other forms
                  if firstForm then
                    begin
                      frm2Broadcast := frm;
                      broadcastIt := (actID = actBroadcast);
                      firstForm := False;
                    end;
              end

            else if (frm <> nil) and (frm.FormID <> 981) then        //else pass the string to the form
              begin
                // 113011 JWyatt Replace any line feed entity codes with the line feed character
                //  so comment text appears as it was entered.
                str := StringReplace(str, '&#10;', #10, [rfReplaceAll]);

                //// special code to Import Image ////
                if (Pos('ImageCell', str) > 0) then
                  begin
                   //# special unwrap to get image base64
                   i:=Pos('{',str);
                   f:=Pos('}',str);
                   if (i>0) and (f>i) then
                   image := Copy(str,i+length('{'),f-i-length('}'));
                   frm.SetImportImage(image, mergeData, False); //# set image on cell.
                  end

                else
                 begin
                   if isUnSystFormat then  //Set mergeData to true to keep contents some common cells like page name, comp No for comps and comp photos
                     frm.SetImportTextUnSystem(str, True, TextFilename,False)
                   else
                     begin
                      if CmdID = cLoadOrderCmd then
                        frm.SetImportText(str, mergeData, True)   //do cell post proccessing
                      else
                        frm.SetImportText(str, mergeData, False);   //let the form place the text properly
                     end;
                 end;
              end;

          end; //while loop

          //Pam: When done importing, we need to populate the header from existing one to RedStone header
//          for f := 0 to docForm.Count - 1 do
//            PopulateFormContext(docForm[f]);

        except

          ShowNotice('There is a problem reading import file, "'+ TextFilename + '".');
        end;
    finally
      CloseFile(importF);
      docView.Invalidate;   //redraw the screen.
		end
  else
    ShowNotice('The import file, "'+ TextFilename + '", cannot be found.');
end;

function TContainer.GetFormIndexByFormID(aFormID: Integer):Integer;
var
  f: Integer;
begin
  result := -1;
  for f := 0 to docForm.Count - 1 do
    if docForm[f].FormID = aFormID then
      begin
        result := f;
        break;
      end;
end;

//github #786: this is designed for IQ Express
procedure TContainer.ImportRedStoneChartData(Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false);
var
  ImportF: TextFile;
  Str: String;
  frm: TDocForm;
  cmdID, frmID, SeqNo: Integer;
  image: String;
  i,f, idx : integer;
  aStream : TMemoryStream;
  JPGImg : TJPEGImage;
  imagedata: String;

  function LoadForm(FUID: Integer):TDocForm;
  var
    fID: TFormUID;
  begin
    fid := TformUID.Create;
    try
      fid.ID := FUID;
      result := InsertBlankUID(fID, True, -1);
    finally
      fID.free;
    end;
  end;

begin
  if FileExists(TextFilename) then
  try
    AssignFile(ImportF, TextFilename);
    Reset(importF);
    try
      frm := nil;
      cmdID := 0;
      frmID := 0;
      seqNo := 0;

      while not EOF(importF) do
        begin
          if not EOLN(importF) then          //hack because readLn does not read skips empty lines
            begin
              Read(importF, str);            //read the next string (this should be a Parser)
              Readln(importF);               //go to next line
            end
            else begin
              Readln(importF);
              str := '';
            end;
            if POS('CMD.', str)> 0 then           //check for commands
              begin
                frm := nil;                       //starting new form ???
                popStr(str,'CMD.FORMID=');
                frmID := GetValidInteger(popStr(str, ','));
                popStr(str,'SEQNO=');
                SeqNo := GetValidInteger(str);
                if GetFormIndex(frmID) = -1 then  //ticket 982: original form = 4215, new form = 4230
                  begin
                    if frmID = 4215 then //without chaning the logic in Redstone, if redstone push down 4215 but no 4215 in the container, can be 4230
                      begin
                        frmID := 4230;
                        case seqNo of
                          108: seqNo := 159;
                          109: seqNo := 160;
                        end;
                        frm := docForm.GetFormByOccurance(FrmID, 0);
                      end;
                  end
                  //                  frm := LoadForm(FrmID)    //Load it
                else
                 frm := docForm.GetFormByOccurance(FrmID, 0);
              end;
            if (frm <> nil)  then        //else pass the string to the form
              begin
                popStr(str,'ImageCell{'); //mark as the beginning of the image
                image := popStr(str,'}.EndImageCell'); //mark as the end of the image
                if image <> '' then
                  begin
                    imagedata := Base64Decode(image);   //decode
                    JPGImg := TJPEGImage.Create;
                    LoadJPEGFromByteArray(imagedata,JPGImg); //convert str into jpeg
                    if not JPGImg.Empty then
                      frm.SetCellJPEG(1,SeqNo, JPGImg);
                  end;
              end

          end; //while loop
        except

          ShowNotice('There is a problem reading import file, "'+ TextFilename + '".');
        end;
    finally
      CloseFile(importF);
      docView.Invalidate;   //redraw the screen.
    end
  else
    ShowNotice('The import file, "'+ TextFilename + '", cannot be found.');
end;
                                   
//github #786: this is designed for IQ Express
procedure TContainer.ImportRedStoneMapData(MainFormID:Integer; Const TextFilename: String; OverrideData: Boolean; isUnSystFormat: Boolean = false);
var
  ImportF: TextFile;
  Str: String;
  frm: TDocForm;
  cmdID, frmID, SeqNo: Integer;
  image: String;
  i,f, idx : integer;
  aStream : TMemoryStream;
  JPGImg : TJPEGImage;
  imagedata: String;
  cellValue: String;

  function LoadForm(FUID: Integer; idx:integer=-1):TDocForm;
  var
    fID: TFormUID;
  begin
    fid := TformUID.Create;
    try
      fid.ID := FUID;
      result := InsertBlankUID(fID, True, idx+1);
    finally
      fID.free;
    end;
  end;

begin
  if FileExists(TextFilename) then
  try
    AssignFile(ImportF, TextFilename);
    Reset(importF);
    try
      frm := nil;
      cmdID := 0;
      frmID := 0;
      seqNo := 0;

      while not EOF(importF) do
        begin
          if not EOLN(importF) then          //hack because readLn does not read skips empty lines
            begin
              Read(importF, str);            //read the next string (this should be a Parser)
              Readln(importF);               //go to next line
            end
            else begin
              Readln(importF);
              str := '';
            end;
            if (POS('CMD.', str)> 0) and (pos('CMD.FORMID=',str) >0) then           //check for commands
              begin
               // frm := nil;                       //starting new form ???
                popStr(str,'CMD.FORMID=');
                frmID := GetValidInteger(popStr(str, ','));
                popStr(str,'SEQNO=');
                SeqNo := GetValidInteger(str);
                if GetFormIndex(frmID) = -1 then
                  begin
                    idx := GetFormIndex(MainFormID);
                    frm := LoadForm(FrmID,idx);    //Load it
                  end
                else
                 frm := docForm.GetFormByOccurance(FrmID, 0);
              end;
            if (frm <> nil)  then        //else pass the string to the form
              begin
                if pos('ImageCell', str) > 0 then
                  begin
                    popStr(str,'ImageCell{'); //mark as the beginning of the image
                    image := popStr(str,'}.EndImageCell'); //mark as the end of the image
                    if image <> '' then
                      begin
                        imagedata := Base64Decode(image);   //decode
                        JPGImg := TJPEGImage.Create;
                        LoadJPEGFromByteArray(imagedata,JPGImg); //convert str into jpeg
                        if not JPGImg.Empty then
                          frm.SetCellJPEG(1,SeqNo, JPGImg);
                      end;
                  end;
              end;
                if pos('CMD.SALESCOUNT:', str) > 0 then
                begin
                 popStr(str,'CMD.SALESCOUNT:FORMID=');
                 frmID := GetValidInteger(popStr(str,','));
                 seqNo := GetValidInteger(popStr(str, ','));
                 popStr(str, 'COUNT=');
                 cellValue := trim(str);
                 frm := docForm.GetFormByOccurance(FrmID, 0);
                 if assigned(frm) then
                   frm.SetCellText(1, seqNo, cellValue);
                end;

                if pos('CMD.LISTINGCOUNT:', str) > 0 then
                begin
                 popStr(str,'CMD.LISTINGCOUNT:FORMID=');
                 frmID := GetValidInteger(popStr(str,','));
                 seqNo := GetValidInteger(popStr(str, ','));
                 popStr(str, 'COUNT=');
                 cellValue := trim(str);
                 if assigned(frm) then
                   frm.SetCellText(1, seqNo, cellValue);
                end;

          end; //while loop
        except

          ShowNotice('There is a problem reading import file, "'+ TextFilename + '".');
        end;
    finally
      CloseFile(importF);
      docView.Invalidate;   //redraw the screen.
    end
  else
    ShowNotice('The import file, "'+ TextFilename + '", cannot be found.');
end;

function TContainer.ImagesToOptimize(prefDPI: Integer; formList: BooleanArray): Integer;
var
  f,p,c: Integer;
  cell: TBaseCell;
  frmSelected: Boolean;
begin
  result := 0;
  for f := 0 to docForm.count-1 do
    begin
      if not assigned(formList) then
        frmSelected := true
      else
        frmSelected := formList[f];
      if frmSelected then
        for p := 0 to docForm[f].frmPage.count-1 do
          if assigned(docForm[f].frmPage[p].PgData) then
            for c := 0 to docForm[f].frmPage[p].PgData.count-1 do
              if CellImageCanOptimized(docForm[f].frmPage[p].PgData[c], prefDPI) then
                inc(result);
            next;
        next;
  end;
end;

function TContainer.ClearGeoCode:Boolean;
var
  i:Integer;
  CompCol: TCompColumn;
  GeoCodedCell: TGeocodedGridCell;
  aDocCompTable, aDocListTable, aDocRentalTable: TCompMgr2;
begin
  result := False;
  try
    aDocCompTable := TCompMgr2.Create(True);
    aDocCompTable.BuildGrid(self, gtSales);

    //Build Listing comp grid structure
    aDocListTable := TCompMgr2.Create(True);
    aDocListTable.BuildGrid(self, gtListing);

    //Build Listing comp grid structure
    aDocRentalTable := TCompMgr2.Create(True);
    aDocRentalTable.BuildGrid(self, gtRental);

  for i:= 0 to aDocCompTable.Count -1 do
    begin
      CompCol := aDocCompTable.Comp[i];    //Grid comp column
      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
      GeocodedCell.Latitude  := 0;
      GeoCodedCell.Longitude := 0;
    end;

  for i:= 0 to aDocListTable.Count -1 do
    begin
      CompCol := aDocListTable.Comp[i];    //Grid comp column
      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
      GeocodedCell.Latitude  := 0;
      GeoCodedCell.Longitude := 0;
    end;

  for i:= 0 to aDocRentalTable.Count -1 do
    begin
      CompCol := aDocRentalTable.Comp[i];    //Grid comp column
      GeocodedCell := CompCol.GetCellByID(CGeocodedGridCellID) as TGeocodedGridCell;
      GeocodedCell.Latitude  := 0;
      GeoCodedCell.Longitude := 0;
    end;

 finally
   aDocCompTable.Free;
   aDocListTable.Free;
   aDocRentalTable.Free;
 end;
end;

initialization
  //set our clipboard format for RedStone data
  CF_RedStoneData := RegisterClipboardFormat('CF_RedStoneData');       //RedStone data


end.
