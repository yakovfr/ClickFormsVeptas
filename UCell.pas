unit UCell;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
{$IFDEF LOG_CELL_MAPPING}
  XLSReadWriteII2,
{$ENDIF}
  Windows,
  Classes,
  Controls,
  Graphics,
  UBase,
  UClasses,
  UClassesComplex,
  UCellMetaData,
  UFileGlobals,
  UGlobals,
  UGraphics,
  UInterfaces,
  UMessages,
  UPgAnnotation,
  UPgView;

const
  cCellUserPreferencesFile  = 'CellPreferences.INI';
  cCellCaptionPreference    = 'Caption';
  cCellPromptCaptionPreference = 'PromptForCaption';
  CELL_PGNUM_XID = 2010;
  CELL_PGTOTAL_XID = 2010;

  // cell properties
  CPropertyBingMapsData       = 'BingMapsData';
  CPropertyDataSource         = 'DataSource';
  CPropertyGSEData            = 'GSEData';
  CPropertyInstanceID         = 'InstanceID';
  CPropertyLatitude           = 'Latitude';
  CPropertyLongitude          = 'Longitude';
  CPropertyLinkedCommentCell  = 'LinkedCommentCell';
  CPropertyLinkedCommentSection = 'LinkedCommentSection';
  CPropertyMergedInstanceID   = 'MergedInstanceID';
  CPropertyMergedDataSource   = 'MergedDataSource';

  SPARK_BLANK_CHAR = '~!@';

Type
  // forward declarations
  TBaseCell = class;

  // cell instance identifier (persistent)
  TCellInstanceID = TGUID;

  // TCellList
  TCellList = class(TList)
    protected
      function Get(Index: Integer): TBaseCell;
      procedure Put(Index: Integer; Item: TBaseCell);
    public
      function Extract(Item: TBaseCell): TBaseCell;
      function First: TBaseCell;
      function Last: TBaseCell;
      property Items[Index: Integer]: TBaseCell read Get write Put; default;
  end;

  // TDataCellList used by TDocPage
  TDataCellList = class(TCellList)
    public
      destructor Destroy; override;
      property DataCell[Index: Integer]: TBaseCell read Get write Put; default;
  end;

// This is the baseCell that is created from the FormCellItem object
{TBaseCell}

	TBaseCell = class(TAppraisalCell)
    private
      FEditor: TCellEditor;
      FHasDialog: Boolean;
      FProperties: TStringList;
      FValidationError: Boolean;
      FValue: Double;
      FTag: Integer;
    function GetAllowRspTextOnly: Boolean;
    protected
      FEditorClass: TCellEditorClass;
    private
      function GetCellUID: CellUID;
      procedure SetEditor(const AEditor: TCellEditor);
      function GetInstanceID: TCellInstanceID;
      function GetGSEData: String;
      procedure SetGSEData(const Value: String);
      function GetGSEDataPoint(index: String): String;
      procedure SetGSEDataPoint(index: String; const Value: String);
      function GetUserPreference(Preference: String): String;
      procedure SetUserPreference(Preference: String; Value: String);
      function GetProperty(Name: String): String;
      procedure SetProperty(Name: String; Value: String);
      function GetPropertiesText: String;
      procedure SetPropertiesText(const Text: String);
      procedure OnPropertiesChanged(Sender: TObject);
      procedure SetValidationError(const Value: Boolean);
    protected
      function GetBackground: TColor; virtual;
      function GetEditorClass: TCellEditorClass; virtual;
      function GetDisabled: Boolean; override;
      procedure SetDisabled(const Value: Boolean); override;
      procedure Loaded; virtual;
      procedure ReloadEditor; virtual;
      property Properties[index: String]: String read GetProperty write SetProperty;
      procedure PropertiesChanged; virtual;
      procedure BroadcastContextProperty(const Data: PBroadcastContextPropertyData); virtual;
      procedure BroadcastLocalContextProperty(const Data: PBroadcastContextPropertyData);
    public
       FSaved: Boolean;  //Ticket #750: set up a new flag for save comps db to use
		FFrame: TRect;
		FType: Integer;
		FSubType: Integer;
		FGroup: Integer;
		FCellPref: LongInt;         //holds the prefs 31 flag bit
		FCellFormat: LongInt;       //holds the formatting bits

		FCellID: LongInt;           //Cell predefined ID, uniquely identifies cell type
    FCellXID: LongInt;          //Cell's XML ID- unique ID to MISMO XPath
		FMathID: Integer;
		FContextID: LongInt;        //all cells w/this context within report are same
    FLocalCTxID: LongInt;       //all cells with this context WITHIN the form are same
    FRspKindID: LongInt;        //Rsp Kind (residential) that RspID belongs to
		FResponseID: LongInt;       //Global Rsp ID within Rsp Kind type
    FCellKindID: LongInt;       //NOt Used: Cell Kind (Appraisal, insurance)that CellID belongs to

//		FValue: Double;							// every cell can have a value associated with it
//		FText: String;              // every call has some text
		FTxRect: TRect;               // usually the text rect = the frame
		FTxSize: Integer;
		FTxJust: Integer;
		FTxStyle: TFontStyles;
    FFontName: TFontName;        //expose FontName to change font titles/text on forms

		FIsActive: Boolean;					// cell is the currently active cell (only one at a time)
		FEmptyCell: Boolean;
		FWhiteCell: Boolean;      	// cell may be empty, but still draw as if it has something  (checkboxes)
		FManualEntry: Boolean;
		FClipped: Boolean;

		FModified: Boolean;
    FMaxLength: Integer;
    FMinLength: Integer;

		constructor Create (AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); reintroduce; virtual;
		destructor Destroy; override;
		procedure Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer); override;
		procedure Notify(const Msg: TDocumentMessageID; const Data: Pointer); override;
		function HasData: Boolean; virtual;
		procedure ConfigurationChanged; virtual;
    function CanEdit: Boolean;
		procedure Assign(source: TBaseCell); virtual;
		procedure AssignContent(Source: TBaseCell); virtual;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
		procedure Display; virtual;
		procedure EraseCell; virtual;
		procedure FocusOnCell; virtual;
		procedure FocusOn(View: TRect);
		procedure FocusOnWindow;
		procedure FocusOnDocument;
		function Caret2View(Pt: TPoint): TPoint;
		function Doc2View(Pt: TPoint): TPoint; override;
		function Cell2View: TRect;
		function Cell2ClientRect(R: TRect): TRect;
		procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer); override;
		procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer); override;
    procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
    procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);override;

    //for debugging
		procedure SetCellSampleEntry; virtual;
		procedure Clear; virtual;
		procedure SetCellNumber(ID: Integer); virtual;
    procedure DisplayCellID(ASequenceID: Integer = -1); virtual;
    procedure DisplayCellXID; virtual;
    procedure DisplayCellMathID(ASequenceID: Integer = -1); virtual;
    procedure DisplayCellLocalContext(ASequenceID : Integer = -1); virtual;
    procedure DisplayCellGlobalContext(ASequenceID : Integer = -1); virtual;
    procedure DisplayCellRspIDs; virtual;
    procedure DebugSpecial; virtual;

		procedure SetModified(Value: Boolean);
    procedure SetFormatModifiedFlag;                 //one way flag
    procedure CheckTextOverflow; virtual;
    procedure SetTextSize(Value: Integer); virtual;
    procedure SetTextJust(value: Integer); virtual;
    procedure SetFontStyle(fStyle: TFontStyles); virtual;
    procedure DeleteProperty(const Name: String);
    function PropertyExists(const Name: String): Boolean;
    procedure DoSetText(const Str: String); virtual;
		procedure SetText(const Str: String); override;
		procedure SetValue(Value: Double); override;
		procedure LoadData(const data: String);                                 
    procedure LoadStreamData(Stream: TStream; Amt: LongInt; processIt: Boolean); virtual;
    procedure LoadContent(const Str: String; processIt: Boolean); virtual;  //for converter
    procedure LoadContent2(const Str: String; processIt:Boolean); virtual;  //for converter
		function GetText: String; virtual;
		function GetRealValue: Double; virtual;
		function GetIntValue: Integer; virtual;
		function GetMathCmd: Integer;
		function GetFormatedString(Value: Double): String;
    function Format(value: String): String; virtual;

    function HasMetaData(metaType: Integer): Boolean; virtual;
    function GetMetaData: integer; virtual;
		procedure SetEditState(editorActive: Boolean); virtual;
		procedure ProcessMath; virtual;
    procedure ReplicateLocal(start: Boolean); virtual;         //for similar cell in form
		procedure ReplicateGlobal; virtual;                        //start with global context
		procedure PreProcess; virtual;

		procedure PostProcess; virtual;
    procedure MungeText; virtual;

		function GetGroupTable: TGroupTable; virtual;
		function GetCellIndex: Integer;
		function InView(View: TRect; Var Pt: TPoint): Boolean; virtual;
		function DisplayIsOpen(openIt: Boolean): Boolean;

		procedure WriteCellData(stream: TStream); virtual;
		procedure WriteCellData6(stream: TStream);
		procedure WriteCellData7(stream: TStream);
		procedure ReadCellData(stream: TStream; Version: Integer); virtual;
		procedure ExportToTextFile(var stream: TextFile); virtual;    //for exporting text only
		procedure ImportFromTextFile(var stream: TextFile); virtual;
		procedure EncodeCellPrefs(var specRec: CellSpecRec);
		procedure DecodeCellPrefs(var specRec: CellSpecRec);

		property Modified: Boolean read FModified write SetModified;
		property Kind: Integer read FSubType write FSubType;
		property Editor: TCellEditor read FEditor write SetEditor;
		property HasDialog: Boolean read FHasDialog;
		property BackGround: TColor read GetBackground;
		property CellValue: Double read FValue write FValue;
		property TextSize: Integer read FTxSize write SetTextSize;    //FTxSize;
		property TextJust: Integer read FTxJust write SetTextJust;
    property CellPref: Longint read FCellPref write FCellPref;
    property AllowRspTextOnly: Boolean read GetAllowRspTextOnly;
//    property Format: LongInt;
    property UID: CellUID read GetCellUID;
    property InstanceID: TCellInstanceID read GetInstanceID;
    property GSEData: String read GetGSEData write SetGSEData;
    property GSEDataPoint[index: String]: String read GetGSEDataPoint write SetGSEDataPoint;
    property EditorClass: TCellEditorClass read GetEditorClass;
    property UserPreference[index: String]: String read GetUserPreference write SetUserPreference;
    property PropertiesText: String read GetPropertiesText write SetPropertiesText;
    property HasValidationError: Boolean read FValidationError write SetValidationError;
    property Tag: Integer read FTag write FTag default 0;
	end;
  PTBaseCell = ^TBaseCell;

  /// summary: Base class for text cells supporting carry-over comments
  TTextBaseCell = class(TBaseCell)
  private
    function GetLinkedCommentCell: TCellInstanceID;
    procedure SetLinkedCommentCell(const Value: TCellInstanceID);
    function GetLinkedCommentSection: Integer;
    procedure SetLinkedCommentSection(const Value: Integer);
    function GetHasLinkedComments: Boolean;
    procedure ConvertCellText; //github 67: handle unit conversion
  public
    procedure GoToLinkedComments;
    property HasLinkedComments: Boolean read GetHasLinkedComments;
    property LinkedCommentCell: TCellInstanceID read GetLinkedCommentCell write SetLinkedCommentCell;
    property LinkedCommentSection: Integer read GetLinkedCommentSection write SetLinkedCommentSection;
  end;

  // TDataBoundCell
  TDataBoundCell = class(TTextBaseCell)
    private
      FAttaching: Boolean;
      FDataCell: TDataBoundCell;
      FDataLinks: TCellList;
    private
      function GetDataLinkCount: Integer;
      function FindCellDataSourceInstance: TDataBoundCell;
    protected
      procedure Loaded; override;
      function GetDataCell: TDataBoundCell;
      function GetDataLink(Index: Integer): TDataBoundCell;
      procedure AttachDataLink; virtual;
      procedure DetachDataLink; virtual;
      function GetDataSource: TCellInstanceID;
      procedure SetDataSource(const Value: TCellInstanceID); virtual;
      procedure PropertiesChanged; override;
      procedure TransferDataSource(const NewDataCell: TDataBoundCell); virtual;
    public
      constructor Create (AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
      destructor Destroy; override;
      procedure BeforeDestruction; override;
      procedure Assign(Source: TBaseCell); override;
      function HasData: Boolean; override;
    public
      property DataCell: TDataBoundCell read GetDataCell;
      property DataSource: TCellInstanceID read GetDataSource write SetDataSource;
      property DataLinkCount: Integer read GetDataLinkCount;
      property DataLinks[Index: Integer]: TDataBoundCell read GetDataLink;
  end;

{ TPgNumCell}
	TPgNumCell = class(TBaseCell)
    constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
	end;

{ TPgTotalCell}
	TPgTotalCell = class(TBaseCell)
    constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
	end;

//Table of Contents Description (TC)
{ TTCDescCell}
	TTCDescCell = class(TBaseCell)
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
	end;

//Table of Contents Page# cell
{ TTCPageCell }
	TTCPageCell = class(TBaseCell)
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
	end;

{ TTextCell }
	TTextCell = class(TTextBaseCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
		FTxMask: LongInt;        //###not used yet, FFormat is used
		constructor Create (AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); reintroduce; override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
		procedure SetCellSampleEntry; override;
		function InView(View: TRect; Var Pt: TPoint): Boolean; override;
    procedure Assign(source: TBaseCell); override;
    function Format(value: String): String; override;
    procedure MungeText; override;
		procedure PostProcess; override;
		procedure ReadCellData(stream: TStream; Version: Integer); override;
    procedure ReadMlnCellData(stream: TStream); //YF 03.25.03 Used when we replace MlnCell in the new revision
    procedure SetFontStyle(fStyle: TFontStyles);  override;
    procedure PreProcessUAD;

	end;

{ TInvisibleCell }
	TInvisibleCell = class(TBaseCell)    //invisible cell, can not be displayed, printed, does not have user input. Only can to transfer text to and from the normal cells
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
    procedure Display; override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
		function InView(View: TRect; Var Pt: TPoint): Boolean; override;
    procedure PostProcess; override;
	end;

{ TGridCell }
  TGridCell = class(TTextCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
      function GetCoordinates(out Coordinates: TPoint): Integer;
    procedure ProcessMath; override;               //handle the adjustments
  end;

{ TCompanyCell }
  TCompanyCell = class(TTextCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
		constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
    procedure LoadCurrentUserCompanyName;
    procedure ReadCellData(stream: TStream; Version: Integer); override;
    procedure SetCellSampleEntry; override;
  end;


{ TLicenseeCell}
	TLicenseCell = class(TTextCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
		constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
    procedure LoadCurrentUser;
    procedure ReadCellData(stream: TStream; Version: Integer); override;
    procedure SetCellSampleEntry; override;
	end;

{ TGenericSignerCell }
	TSignerCell = class(TTextCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
    procedure SetCellSampleEntry; override;
	end;



{TDateCell}
	TDateCell = class(TTextCell)
		procedure SetCellSampleEntry; override;
		procedure SetText(const Str: String); override;
    procedure DoSetDate(DateVal: TDateTime);
		procedure SetDate(DateVal: TDateTime);
    procedure LoadContent(const Str: String; processIt: Boolean); override;
	end;

{TChkBoxCell}
	TChkBoxCell = class(TBaseCell)
    protected
      function GetBackground: TColor; override;
      function GetEditorClass: TCellEditorClass; override;
    public
		FChecked: Boolean;
		constructor Create (AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); reintroduce; override;
		destructor Destroy; override;
		procedure AssignContent(Source: TBaseCell); override;
    procedure DrawGroup(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    function HasData: Boolean; override;
		procedure SetCellSampleEntry; override;
    procedure SetCellNumber(ID: Integer); override;
    procedure Display; override;
    procedure DisplayCellID(ASequenceID : Integer = -1); override;
    procedure DisplayCellXID; override;
    procedure DisplayCellMathID(ASequenceID : Integer = -1); override;
    procedure DisplayCellLocalContext(ASequenceID : Integer = -1); override;
    procedure DisplayCellGlobalContext(ASequenceID : Integer = -1); override;
		procedure SetText(const Str: String); override;
    procedure DoSetText(const Str: String); override;
    procedure CheckTextOverflow; override;
    procedure LoadContent(const Str: String; processIt: Boolean); override;
		function GetGroupTable: TGroupTable; override;
		procedure ToggleGroupMarks(GroupHasMark: Boolean);
    procedure SetGroupBackground;
		procedure SetCheckMark(Check: Boolean);
    procedure ClearCheckMark;
		procedure WriteCellData(stream: TStream); override;
		procedure ReadCellData(stream: TStream; Version: Integer); override;
	end;


	TextLine = record                //index into Text string of chars that make up a line
		retChIdx: Integer;						 //holds the return char's index
		fstChIdx: Integer;             //allows us to skip returns, linefeeds, etc
		lstChIdx: Integer;             //if zeros then lines have no characters
	end;
	LineStarts = array of TextLine;

{TMLnTextCell}
	TMLnTextCell = class(TTextBaseCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
		FMaxLines: Integer;
		FTxIndent: Integer;
		FTxLines: LineStarts;
		constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); reintroduce; override;
		destructor Destroy; override;
		procedure Assign(source: TBaseCell); override;
    function  CheckWordWrap(testStr: String): LineStarts;
    procedure DoSetText(const Str: String); override;
		procedure FillCell(Canvas: TCanvas; fillColor: TColor);
    procedure SetText(const Str: String); override;
    procedure SetCellSampleEntry; override;
    procedure EraseCell; override;
    procedure Clear; override;
    procedure DisplayCellRspIDs; override;
    procedure DisplayCellID(ASequenceID : Integer = -1); override;
    procedure DisplayCellXID; override;
    procedure DisplayCellMathID(ASequenceID : Integer = -1); override;
    procedure SetCellNumber(ID: Integer); override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
    procedure CheckTextOverflow; override;
    procedure LoadContent(const Str: String; processIt: Boolean); override;
		function InView(View: TRect; Var Pt: TPoint): Boolean; override;
		procedure WriteCellData(stream: TStream); override;
		procedure ReadCellData(stream: TStream; Version: Integer); override;
    procedure ReadTextCellData(stream: TStream);
    procedure PostProcess; override;
	end;

{ TGraphicCell }
	TGraphicCell = class(TBaseCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
    FImage: TCFImage;
		FPicDest: TRect;				//image is StretchDrawn in this rect
		FPicScale: Integer;     //scale of the image (not same as doc scale)
    FBitRect: TRect;        //the bitmap image rect
    FLabels: TMarkupList;   //Labels to markup the image (map arrows)
    FMetaData: TMetaData;   //TMetaData holds cell MetaData assoc with FImage (sketch data, etc)
		constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); reintroduce; virtual;
		destructor Destroy; override;
		procedure Assign(source: TBaseCell); override;
    procedure AssignImage(Source: TCFImage); virtual;
    procedure AssignLabels(Source: TMarkupList); virtual;
    procedure AssignMetaData(Source: TMetaData); virtual;
    procedure SetText(const Str: String); override;   //set the path to image file
    procedure Clear; override;
    procedure DisplayCellID(ASequenceID: Integer = -1); override;
    procedure DisplayCellXID; override;
    procedure ClearAnnotation;
    function AddAnnotation(AType: Integer; X,Y: Integer; AName: String; AColor: TColor; AAngle, ARefID, ACatID: Integer): TPageItem;
    procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
    procedure DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);override;
    procedure DragDropImage(Sender, Source: TObject; X,Y: Integer);
    procedure DragDropLabel(Sender, Source: TObject; X,Y: Integer);
    procedure FocusOnCell; override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
		function GetEditorViewPort: TRect; virtual;
    function HasMetaData(metaType: Integer): Boolean; override;
    function GetMetaData: integer; override;
    procedure LoadOldSketchData(Value: HENHMETAFILE);
    procedure LoadStreamData(Stream: TStream; Amt: LongInt; processIt: Boolean); override;
    function HasData: Boolean; override;
    function HasImage: Boolean;
    procedure SaveToFile(const fileName: String);
    procedure LoadFromFile(const fileName: String);
		procedure WriteCellData(stream: TStream); override;
		procedure ReadCellData(stream: TStream; Version: Integer); override;
    procedure ReadCellDataV1(Stream: TStream; Version: Integer);  //version 1 read
    procedure ReadCellDataV2(Stream: TStream; Version: Integer);  //version 2 read
    function OptimizeCellImage(optDPI: integer; var origSize: Integer; var optSize: Integer): Boolean;
    class function CalculateImageSizeFromCellFrame(const Frame: TRect): TSize;
	end;

{ TPhotoCell }
  //Photos have frames and image is inset
	TPhotoCell = class(TGraphicCell)
    constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
    procedure Assign(source: TBaseCell); override;
    procedure AssignImage(Source: TCFImage); override;
		function GetEditorViewPort: TRect; override;
		procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
		procedure DrawPicFrame(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
	end;

{ TSketchCell }
  TSketchCell = class(TPhotoCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
  end;

{ TAdvertisementCell }
  TAdvertisementCell = class(TPhotoCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
  end;

{ TMapLocCell }
  TMapLocCell = class(TPhotoCell)
    private
      function GetBingMapsData: String;
      procedure SetBingMapsData(const Value: String);
    protected
      function GetEditorClass: TCellEditorClass; override;
    public
      property BingMapsData: String read GetBingMapsData write SetBingMapsData;
  end;

{ TMapPlatCell }
  TMapPlatCell = class(TPhotoCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
  end;

{ TMapFloodCell }
  TMapFloodCell = class(TPhotoCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
  end;

{ TDeedPlotCell }
  TDeedPlotCell = class(TPhotoCell)
    protected
      function GetEditorClass: TCellEditorClass; override;
  end;

  /// summary: A grid cell geocoded with a latitude and longitude.
  TGeocodedGridCell = class(TGridCell)
  private
    function GetLatitude: Double;
    procedure SetLatitude(const Value: Double);
    function GetLongitude: Double;
    procedure SetLongitude(const Value: Double);
  public
    procedure ClearCoordinates;
    property Latitude: Double read GetLatitude write SetLatitude;
    property Longitude: Double read GetLongitude write SetLongitude;
  end;

{ Utility Functions }
  function CellContainerObj(cell: TBaseCell):TObject;   //returns the Container as TObject
  function ConstructCell(cType, cSubType: Integer; AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject): TBaseCell;
  function ConstructCell2(cType, cSubType: Integer; AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject; bShowMessage: Boolean=True): TBaseCell;
  procedure SkipCellData(AParent: TAppraisalPage; AViewParent: TObject; Stream: TStream; Version: Integer);    //generic skip rountine
  function GetCellTypeFromStream(stream: TStream): Integer;
  function CellImageCanOptimized(cell: TBaseCell; prefOptDPI: Integer): Boolean;

{$IFDEF LOG_CELL_MAPPING}
var
   CELL_MAPPING_FILE_NAME : string = 'Global-Sequence Cell ID Cross-Reference.xls';
   CellMappingSpreadsheet : TXLSReadWriteII2 = nil;
   CellMappingNextCell : TPoint; //cannot seem to initialize this to an "empty" point
   CellMappingSheetIndex : Integer = 0;

{$ENDIF}
implementation


uses
  DBConsts,
  Forms,
  IdCoderMIME,
  IniFiles,
  MSXML6_TLB,
  StdCtrls,
  SysUtils,
  UContainer,
  UDocView,
  UDrag,
  UEditor,
  UEditorDialog,
  {UGSEComments,}
  UExceptions,
  UFileUtils,
  UForm,
  ULicUser,
  UMain,
  UMathMgr,
  UPage,
  UPaths,
  UStatus,
  UUADConfiguration,
  UUtil1,
  UWordProcessor,
  UUADUtils,
  UStrings,
  UAWSI_Utils,
  UUADObject,
  UUtil2;


{Utility Functions}

//Get page the cell belongs to
function CellPage(cell: TBaseCell):TDocPage;
begin
	result := TDocPage(cell.FParentPage);
end;

//Get the form the cell belongs to
function CellForm(cell: TBaseCell):TDocForm;
begin
  try
    result := TDocForm(CellPage(cell).FParentForm);
  except
    result := nil;
  end;
end;

//Get the container the cell belongs to
function CellContainer(cell: TBaseCell):TContainer;
begin
	result := TContainer(CellForm(cell).FParentDoc);
end;

//Exposed function with just object result
function CellContainerObj(cell: TBaseCell):TObject;
begin
  result := CellContainer(Cell);
end;

//bottleneck routine used to create cells from Form Def file
function ConstructCell(cType, cSubType: Integer; AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject): TBaseCell;
begin
  result := nil;
  case cType of
    cSingleLn:
      case cSubType of
        cKindTx:
          result := TTextCell.Create(AParent, AViewParent, cellDef);
        cKindCalc:   //number formatting is done in Text Cell
          result := TTextCell.Create(AParent, AViewParent, cellDef);
        cKindDate:
          result := TDateCell.Create(AParent, AViewParent, cellDef);
        cKindLic:
          result := TLicenseCell.Create(AParent, AViewParent, cellDef);
        cKindCo:
          result := TCompanyCell.Create(AParent, AViewParent, cellDef);
        cKindPgNum:
          result := TPgNumCell.Create(AParent, AViewParent, cellDef);
        cKindPgTotal:
          result := TPgTotalCell.Create(AParent, AViewParent, cellDef);
        cKindTCDesc:
          result := TTCDescCell.Create(AParent, AViewParent, cellDef);
        cKindTCPage:
          result := TTCPageCell.Create(AParent, AViewParent, cellDef);
        cKindExtraSignature:
          result := TSignerCell.Create(AParent, AViewParent, cellDef);
        cKindLabel:
          result := TAdvertisementCell.Create(AParent, AViewParent, cellDef);
      else
        result := TTextCell.Create(AParent, AViewParent, cellDef);
      end;

    cMultiLn:
      begin
        if cellDef = nil then
          result := TMLnTextCell.Create(AParent, AViewParent, cellDef)
        else
          case (cellDef as TCellDesc).CCellID of
            CWordProcessorCellID:
              begin
                result := TWordProcessorCell.Create(AParent, AViewParent, cellDef);
                (result as TWordProcessorCell).AutoExpanding := True;
              end;
          else
            result := TMLnTextCell.Create(AParent, AViewParent, cellDef);
          end;
      end;

    cChkBox:
      begin
        result := TChkBoxCell.Create(AParent, AViewParent, cellDef);
      end;

    cMemo:  //Invisible cell uses CMeno ID until form designer is updated
      begin
        result := TInvisibleCell.Create(AParent, AViewParent, cellDef);
      end;

    cGraphic:
      begin
        case cSubType of
          cKindSkch:
            result := TSketchCell.Create(AParent, AViewParent, cellDef);
          cKindMapLoc:
            result := TMapLocCell.Create(AParent, AViewParent, cellDef);
          cKindPhoto:
            result := TPhotoCell.Create(AParent, AViewParent, cellDef);
          cKindMapPlat:
            result := TMapPlatCell.Create(AParent, AViewParent, cellDef);
          cKindMapFlood:
            result := TMapFloodCell.Create(AParent, AViewParent, cellDef);
          cKindMapDeed:    //not used yet, reserved for deed plotter
            result := TDeedPlotCell.Create(AParent, AViewParent, cellDef);
        else
          result := TPhotoCell.Create(AParent, AViewParent, cellDef);
        end;
      end;
    cGridCell:
      begin
        if cellDef = nil then
          result := TGridCell.Create(AParent, AViewParent, cellDef)
        else
          case (cellDef as TCellDesc).CCellID of
            CGeocodedGridCellID:
              result := TGeocodedGridCell.Create(AParent, AViewParent, cellDef);
          else
            result := TGridCell.Create(AParent, AViewParent, cellDef);
          end;
      end;
    else
      ShowNotice('Tried to create unknown cell type: '+ IntToStr(cType) +' - '+IntToStr(cSubType));
  end; //case of cell type
end;

//bottleneck routine used to create cells from Form Def file
function ConstructCell2(cType, cSubType: Integer; AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject; bShowMessage: Boolean=True): TBaseCell;
begin
  result := nil;
  case cType of
    cSingleLn:
      case cSubType of
        cKindTx:
          result := TTextCell.Create(AParent, AViewParent, cellDef);
        cKindCalc:   //number formatting is done in Text Cell
          result := TTextCell.Create(AParent, AViewParent, cellDef);
        cKindDate:
          result := TDateCell.Create(AParent, AViewParent, cellDef);
        cKindLic:
          result := TLicenseCell.Create(AParent, AViewParent, cellDef);
        cKindCo:
          result := TCompanyCell.Create(AParent, AViewParent, cellDef);
        cKindPgNum:
          result := TPgNumCell.Create(AParent, AViewParent, cellDef);
        cKindPgTotal:
          result := TPgTotalCell.Create(AParent, AViewParent, cellDef);
        cKindTCDesc:
          result := TTCDescCell.Create(AParent, AViewParent, cellDef);
        cKindTCPage:
          result := TTCPageCell.Create(AParent, AViewParent, cellDef);
        cKindExtraSignature:
          result := TSignerCell.Create(AParent, AViewParent, cellDef);
        cKindLabel:
          result := TAdvertisementCell.Create(AParent, AViewParent, cellDef);
      else
        result := TTextCell.Create(AParent, AViewParent, cellDef);
      end;

    cMultiLn:
      begin
        if cellDef = nil then
          result := TMLnTextCell.Create(AParent, AViewParent, cellDef)
        else
          case (cellDef as TCellDesc).CCellID of
            CWordProcessorCellID:
              begin
                result := TWordProcessorCell.Create(AParent, AViewParent, cellDef);
                (result as TWordProcessorCell).AutoExpanding := True;
              end;
          else
            result := TMLnTextCell.Create(AParent, AViewParent, cellDef);
          end;
      end;

    cChkBox:
      begin
        result := TChkBoxCell.Create(AParent, AViewParent, cellDef);
      end;

    cMemo:  //Invisible cell uses CMeno ID until form designer is updated
      begin
        result := TInvisibleCell.Create(AParent, AViewParent, cellDef);
      end;

    cGraphic:
      begin
        case cSubType of
          cKindSkch:
            result := TSketchCell.Create(AParent, AViewParent, cellDef);
          cKindMapLoc:
            result := TMapLocCell.Create(AParent, AViewParent, cellDef);
          cKindPhoto:
            result := TPhotoCell.Create(AParent, AViewParent, cellDef);
          cKindMapPlat:
            result := TMapPlatCell.Create(AParent, AViewParent, cellDef);
          cKindMapFlood:
            result := TMapFloodCell.Create(AParent, AViewParent, cellDef);
          cKindMapDeed:    //not used yet, reserved for deed plotter
            result := TDeedPlotCell.Create(AParent, AViewParent, cellDef);
        else
          result := TPhotoCell.Create(AParent, AViewParent, cellDef);
        end;
      end;
    cGridCell:
      begin
        if cellDef = nil then
          result := TGridCell.Create(AParent, AViewParent, cellDef)
        else
          case (cellDef as TCellDesc).CCellID of
            CGeocodedGridCellID:
              result := TGeocodedGridCell.Create(AParent, AViewParent, cellDef);
          else
            result := TGridCell.Create(AParent, AViewParent, cellDef);
          end;
      end;
    else
    begin
      if bShowMessage then
        ShowNotice('Tried to create unknown cell type: '+ IntToStr(cType) +' - '+IntToStr(cSubType));
    end;
  end; //case of cell type
end;


//when compatibility issues occur with form versions, we skip data to continue reading
procedure SkipCellData(AParent: TAppraisalPage; AViewParent: TObject; Stream: TStream; Version: Integer);
var
	amt: LongInt;
  cType, cSubType: Integer;
	specRec: CellSpecRec;
  cell: TBaseCell;
begin
  //read the identifier header
	amt := SizeOf(CellSpecRec);         //Read the Cell State, Pref, and Format
	stream.Read(specRec, amt);

  //see what type of cell wrote the data
  cType := HiWord(specRec.fWhoIsCell);
  cSubType := LoWord(specRec.fWhoIsCell);

  //reconstruct the cell
  Cell := ConstructCell(cType, cSubType, AParent, AViewParent, nil);
  try
    Stream.Seek(-SizeOf(CellSpecRec), soFromCurrent);   //backup
    Cell.FParentPage := AParent;  
    Cell.ReadCellData(Stream, Version);                 //read/skip cell's data
  finally
    Cell.Free;                                          //free it
  end;
end;

function GetCellTypeFromStream(stream: TStream): Integer;
var
  specRec: CellSpecRec;
begin
  try
    stream.Read(specRec, sizeof(specRec));
    result := HiWord(specRec.fWhoIsCell);
    Stream.Seek(-SizeOf(CellSpecRec), soFromCurrent);
  except
    result := -1;
  end;
end;

function CellImageCanOptimized(cell: TBaseCell; prefOptDPI: Integer): Boolean;
begin
  result := False;

  if not (Cell is TPhotoCell) then exit;    //has to be image cell
  if {(cell is TDeedPlotCell) or      //not map or skercher; cell in Exhibit page is TPhotoCell, it will pass
        (cell is TMapFloodCell) or     //on 10/22/2018 Jorge decided to optimize maps too
        (cell is TMapLocCell) or
        (cell is TMapPlatCell) or   }
        (cell is TSketchCell) then exit;
  with TGraphicCell(cell).FImage do
    begin
      if not assigned(FDIB.DibBitmap) then exit;   //not metafile
      //if FImgOptimized then exit;  //already optimized
      if imageDPI <= 1.1 * prefOptDPI then exit; //nothing to optimize or too small gain
    end;
  result := true;
end;

{********************************************}
{                                            }
{                  TCellList                 }
{                                            }
{********************************************}

function TCellList.Get(Index: Integer): TBaseCell;
begin
  Result := TObject(inherited Get(Index)) as TBaseCell;
end;

procedure TCellList.Put(Index: Integer; Item: TBaseCell);
begin
  inherited Put(Index, Item);
end;

function TCellList.Extract(Item: TBaseCell): TBaseCell;
begin
  Result := TObject(inherited Extract(Item)) as TBaseCell;
end;

function TCellList.First: TBaseCell;
begin
  Result := TObject(inherited First) as TBaseCell;
end;

function TCellList.Last: TBaseCell;
begin
  Result := TObject(inherited Last) as TBaseCell;
end;

{********************************************}
{                                            }
{               TDataCellList                }
{                                            }
{********************************************}

destructor TDataCellList.Destroy;
begin
  while (Count > 0) do
    Extract(First).Free;

  inherited;
end;

{********************************************}
{																						 }
{ 							TBaseCell										 }
{																						 }
{********************************************}

/// summary: Indicates that the cell is disabled when the cell has a dialog.
function TBaseCell.GetDisabled: Boolean;
begin
  Result := inherited GetDisabled;
end;

/// summary: Saves and reloads the editor when disabling the cell.
procedure TBaseCell.SetDisabled(const Value: Boolean);
var
  Edit: TEditor;
begin
  if Assigned(FEditor) and (FEditor is TEditor) then
    begin
      Edit := FEditor as TEditor;
      Edit.SaveChanges;
      inherited;
      Edit.LoadCell(Self, UID);
    end
  else
    begin
      inherited;
      Display;
    end;
end;

/// summary: Initializes cells that have dialogs.
procedure TBaseCell.Loaded;
begin
  // do nothing
end;

/// summary: Reloads the cell editor with data from the cell.
procedure TBaseCell.ReloadEditor;
begin
  if Assigned(FEditor) then
    FEditor.Reload;
end;

function TBaseCell.GetCellUID: CellUID;
var
  document: TContainer;
  form: TDocForm;
  page: TDocPage;
  CUID: CellUID;
begin
  CUID := NullUID;

  // populate record
  if Assigned(Self) then
    begin
      page := FParentPage as TDocPage;
      if Assigned(page) then
        begin
          form := page.FParentForm as TDocForm;
          if Assigned(form) then
            begin
              document := form.FParentDoc as TContainer;
              if
                Assigned(document) and
                Assigned(form.frmInfo) and
                Assigned(document.docForm) and
                Assigned(form.frmPage) and
                Assigned(page.pgData)
              then
                begin
                  CUID.FormID := form.frmInfo.fFormUID;
                  CUID.Form := document.docForm.IndexOf(form);
                  CUID.Occur := form.FInstance;
                  CUID.Pg := form.frmPage.IndexOf(page);
                  CUID.Num := page.pgData.IndexOf(Self);
                end;
            end;
        end;
    end;

  Result := CUID;
end;

procedure TBaseCell.SetEditor(const AEditor: TCellEditor);
begin
  if Assigned(AEditor) and (AEditor <> FEditor) then
    begin
      if Assigned(FEditor) then
        raise Exception.Create('Another editor is already active on this cell')
      else
        FEditor := AEditor;
    end
  else
    FEditor := AEditor;
end;

function TBaseCell.GetInstanceID: TCellInstanceID;
var
  GUID: TGUID;
begin
  if (FProperties.Values[CPropertyInstanceID] <> '') then
    try
      Result := StringToGuid(FProperties.Values[CPropertyInstanceID]);
    except
      CreateGUID(GUID);
      FProperties.Values[CPropertyInstanceID] := GuidToString(GUID);
      Result := GUID;
    end
  else
    begin
      CreateGUID(GUID);
      FProperties.Values[CPropertyInstanceID] := GuidToString(GUID);
      Result := GUID;
    end;
end;

/// summary: Gets the GSEData associated with the cell.
function TBaseCell.GetGSEData: String;
begin
  Result := FProperties.Values[CPropertyGSEData];
end;

/// summary: Sets the GSEData associated with the cell.
procedure TBaseCell.SetGSEData(const Value: String);
begin
  if (Value <> FProperties.Values[CPropertyGSEData]) then
    FProperties.Values[CPropertyGSEData] := Value;
end;

//this gets a specific data point in the GSE Points list
//have to put into String list to Get/Set the points
function TBaseCell.GetGSEDataPoint(index: String): String;
var
  DataPts: TStringList;
begin
  DataPts := TStringList.Create;
  try
    DataPts.commaText := FProperties.Values[CPropertyGSEData];
    result := DataPts.Values[index];
  finally
    DataPts.free;
  end;
end;

//this sets a specific data point in the GSE points list
//have to put into String list to Get/Set the points
procedure TBaseCell.SetGSEDataPoint(index: String; const Value: String);
var
  DataPts: TStringList;
begin
  DataPts := TStringList.Create;
  try
    DataPts.CommaText := FProperties.Values[CPropertyGSEData];
    DataPts.Values[index] := Value;
    FProperties.Values[CPropertyGSEData] := DataPts.CommaText;
  finally
    DataPts.free;
  end;
end;

function TBaseCell.GetUserPreference(Preference: String): String;
var
  ID: String;
  INIFile: TINIFile;
begin
  INIFile := TINIFile.Create(TCFFilePaths.Preferences + CCellUserPreferencesFile);
  try
    if (FCellID <> 0) then
      ID := IntToStr(FCellID)
    else
      ID := IntToStr(UID.FormID) + ':' + IntToStr(UID.Pg) + ',' + IntToStr(UID.Num);

    Result := INIFile.ReadString(ID, Preference, '');
  finally
    FreeAndNil(INIFile);
  end;
end;

procedure TBaseCell.SetUserPreference(Preference: String; Value: String);
var
  ID: String;
  INIFile: TINIFile;
begin
  INIFile := TINIFile.Create(TCFFilePaths.Preferences + CCellUserPreferencesFile);
  try
    if (FCellID <> 0) then
      ID := IntToStr(FCellID)
    else
      ID := IntToStr(UID.FormID) + ':' + IntToStr(UID.Pg) + ',' + IntToStr(UID.Num);

    INIFile.WriteString(ID, Preference, Value);
  finally
    FreeAndNil(INIFile);
  end;
end;

function TBaseCell.GetProperty(Name: String): String;
begin
  Result := FProperties.Values[Name];
end;

procedure TBaseCell.SetProperty(Name: String; Value: String);
begin
  if (FProperties.Values[Name] <> Value) then
    FProperties.Values[Name] := Value;
end;

function TBaseCell.GetPropertiesText: String;
begin
  Result := FProperties.Text;
end;

procedure TBaseCell.SetPropertiesText(const Text: String);
begin
  if (Text <> FProperties.Text) then
    begin
      FProperties.Text := Text;
      PropertiesChanged;
    end;
end;

procedure TBaseCell.OnPropertiesChanged(Sender: TObject);
begin
  PropertiesChanged;
end;

// summary: Sets a flag indicating whether the cell has failed a validation check
procedure TBaseCell.SetValidationError(const Value: Boolean);
begin
  if (Value <> FValidationError) then
    begin
      FValidationError := Value;
      if Assigned(Editor) then
        (Editor as TEditor).DrawCurCell
      else
        Display;
    end;
end;

function TBaseCell.GetAllowRspTextOnly: Boolean;
begin
  result := IsBitSet(FCellPref, bSelRspOnly);
end;

function TBaseCell.GetBackground: TColor;
var
  IsWorksheet: Boolean;
  IsUAD: Boolean;
begin
  // 062411 JWyatt Perform a final length check in case it's a UAD report
  // 062711 JWyatt Do not perform length checks for date fields as these are
  //  handled specially in the UADDateFormErr function.
  // 063011 JWyatt Check the skip flag and do not check lengths for skipped cells
  //  such as those hidden cells on the 1073 & 1075.
  // 070511 JWyatt Revert to using the cell's class name and if it's invisible
  //  then skip it as older reports do not have bCelSkipped set.
  IsUAD := CellContainer(Self).UADEnabled;
	IsWorksheet := IsUADWorksheet(self);
	if (not IsWorksheet) and
     (not ClassNameIs('TInvisibleCell')) and
     (EditorClass.ClassName <> 'TDateSLEditor') and
     (EditorClass.ClassName <> 'TDateGridEditor') then
        //set flag directly; don't do any drawing within this routine.
        FValidationError := (not IsUADCellTextValid(Self, CellContainer(Self))) or
                            (not IsUADLengthOK(CellContainer(Self), Self.GetText, FMinLength, FMaxLength, EditorClass.ClassName)) or
                            (not IsUADSpecialCellChkOK(CellContainer(Self), Self));

  if DebugMode and FModified and not Assigned(FEditor) then
    Result := clSilver
  else if ParentPage.ParentForm.ParentDocument.Locked then
    Result := colorLockedCell
  else if IsBitSet(FCellPref, bCelDispOnly) then
    Result := CellContainer(Self).docColors[cFilledColor]
  else if Assigned(FEditor) then
    Result := CellContainer(Self).docColors[cHiliteColor]
  else if HasValidationError then
    Result := CellContainer(Self).docColors[cInvalidCellColor]
  else if HasData then
    Result := CellContainer(Self).docColors[cFilledColor]
  else if IsUAD and (not IsWorksheet) and appPref_UseUADCellColorForFilledCells and (FEditorClass <> nil) then
    Result := CellContainer(Self).docColors[cUADCellColor]
  else if IsUAD and (not IsWorksheet) and (FEditorClass <> nil) then
    Result := CellContainer(Self).docColors[cUADCellColor]
  else
    Result := CellContainer(Self).docColors[cEmptyCellColor];
end;

function TBaseCell.GetEditorClass: TCellEditorClass;
begin
  if (FEditorClass <> nil) then
    Result := FEditorClass
  else
    Result := TEditor;
end;

procedure TBaseCell.PropertiesChanged;
begin
  // validate dialog data
  if CellContainer(Self).UADEnabled then
    TDialogEditorHelper.ValidateDialogGroup(Self);
end;

/// summary: Broadcasts contextual property data to the cell.
procedure TBaseCell.BroadcastContextProperty(const Data: PBroadcastContextPropertyData);
var
  HasContext: Boolean;
  Index: Integer;
begin
  HasContext := False;
  if (FContextID > 0) then
    begin
      for Index := 0 to Length(Data^.ContextIDs) - 1 do
        HasContext := HasContext or (Data^.ContextIDs[Index] = FContextID);
      if HasContext and (Data^.Name <> CPropertyInstanceID) then
        begin
          if (Data^.Value = '') then
            DeleteProperty(Data^.Name)
          else
            FProperties.Values[Data^.Name] := Data^.Value;
        end;
    end;
end;

/// summary: Broadcasts local contextual property data to the cell.
procedure TBaseCell.BroadcastLocalContextProperty(const Data: PBroadcastContextPropertyData);
var
  HasContext: Boolean;
  Index: Integer;
begin
  HasContext := False;
  if (FLocalCTxID > 0) then
    begin
      for Index := 0 to Length(Data^.ContextIDs) - 1 do
        HasContext := HasContext or (Data^.ContextIDs[Index] = FLocalCTxID);
      if HasContext and (Data^.Name <> CPropertyInstanceID) then
        FProperties.Values[Data^.Name] := Data^.Value;
    end;
end;

constructor TBaseCell.Create(AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject);
var
  GUID: TGUID;
begin
  // construct
  FProperties := TStringList.Create;

  //create basic cell to read data for skipping saving data when forms are missing
  if cellDef = nil then
    inherited Create(AViewParent, Rect(0,0,0,0))

  //when the cellDef is available, create a full fetaured cell
  else
		with cellDef as TCellDesc do
		begin
			inherited Create(AViewParent, CRect);               //setup the PageItem (owner and bounds)

			FParentPage 	:= AParent;
			ParentViewPage := TPageArea(AViewParent).ParentViewPage;    //PgBody's owner is the Page

			FFrame 			:= CRect;
			FType 			:= HiWord(CTypes);
			FSubType 		:= LoWord(CTypes);
			FCellID 		:= CCellID;           //unique cell ID;
      FCellXID    := CCellXID;          //unique XML ID for mismo XPaths
			FCellPref 	:= CPref;
			FCellFormat := CFormat;
			FGroup 			:= HiWord(CGroups);
//		FGRoup2			:= LoWord(CGroups);		//For future use
			FMathID 		:= CMathID;
			FContextID 	:= CContextID;
      FLocalCTxID := CLocalConTxID;
			FResponseID := CResponseID;
//      FRspTableID := CRspTable;         //future use


			FText := '';
			FTxRect := FFrame;             //### do we need FTxRect
			FTxSize := CSize;
			FTxJust := GetCellPrefJust(FCellPref);			//CTxJust;
			FTxStyle := GetCellPrefStyle(FCellPref);		//CTxStyle;

			FModified 		:= False;
			FEditor				:= Nil;

			FCellStatus 	:= 0;             //### hold the booleans below in Ststus eventually
			FIsActive 		:= False;
			FEmptyCell 		:= True;
			FWhiteCell 		:= False;
			FManualEntry 	:= False;
			FClipped 			:= False;

			if length(CDefaultTx) > 0 then        //set the default text
			begin
      	FText := CDefaultTx;
				FWhiteCell := True;
				FEmptyCell := False;
			end;

      CreateGUID(GUID);
      FProperties.Values[CPropertyInstanceID] := GuidToString(GUID);
      FProperties.OnChange := OnPropertiesChanged;
		end;
end;

destructor TBaseCell.Destroy;
begin
	if FIsActive then               //first unplug ourselves
    if Assigned(Editor) then         //make sure we have an editor
		  (Editor as TEditor).UnloadCell; //remove any ref editor has of this cell

  FreeAndNil(FProperties);
	inherited Destroy;
end;

/// summary: Dispatches an event message up the document hierarchy until the
///          specified scope has been reached, and then queues the message for
//           delivery to the objects within the scope.
procedure TBaseCell.Dispatch(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const Data: Pointer);
var
  Notification: PNotificationMessageData;
begin
  if (Scope <> DMS_CELL) then
    begin
      // forward message to parent
      ParentPage.Dispatch(Msg, Scope, Data)
    end
  else
    begin
      // add to message queue
      New(Notification);
      Notification.Msg := Msg;
      Notification.Scope := Scope;
      Notification.Data := Data;
      Notification.NotifyProc := @TBaseCell.Notify;
      Notification.NotifyInstance := Self;
      PostMessage(ParentPage.ParentForm.ParentDocument.Handle, WM_DOCUMENT_NOTIFICATION, 0, Integer(Notification));
    end;
end;

/// summary: Notifies the object and child objects of event messages received.
procedure TBaseCell.Notify(const Msg: TDocumentMessageID; const Data: Pointer);
begin
  // process message
  case Msg of
    DM_CONFIGURATION_CHANGED:
      begin
        ConfigurationChanged;
        Display;
      end;
    DM_LOAD_COMPLETE: Loaded;
    DM_RELOAD_EDITOR: ReloadEditor;
    DM_BROADCAST_CONTEXT_PROPERTY: BroadcastContextProperty(PBroadcastContextPropertyData(Data));
    DM_BROADCAST_LOCAL_CONTEXT_PROPERTY: BroadcastLocalContextProperty(PBroadcastContextPropertyData(Data));
  end;
end;

function TBaseCell.HasData: Boolean;
begin
	result := not FEmptyCell;
end;

/// summary: Reconfigures the cell when the document configuration has changed.
procedure TBaseCell.ConfigurationChanged;
var
  IntVal: Integer;
const
  CAttributeDialogID = 'DialogID-ref';
  CAttributeEditorClass = 'EditorClass';
  CAttributeEnabled = 'Enabled';
  CAttributeMinLength = 'MinLength';
  CAttributeMaxLength = 'MaxLength';
  CAttributeDefValue = 'DefaultValue';
  CAttributeDefDecimal = 'DefaultDecimals';
  CAttributeLocCtxID = 'LocalContextID';
  CAttributeCtxID = 'ContextID';
  CAttributeMathID = 'MathID';
  CAttributeXmlID = 'XMLID';
var
  AttributeDialogID: IXMLDOMAttribute;
  AttributeEditorClass: IXMLDOMAttribute;
  AttributeEnabled: IXMLDOMAttribute;
  AttributeMinLength: IXMLDOMAttribute;
  AttributeMaxLength: IXMLDOMAttribute;
  AttributeDefValue: IXMLDOMAttribute;
  AttributeDefDecimal: IXMLDOMAttribute;
  AttributeLocCtxID: IXMLDOMAttribute;
  AttributeCtxID: IXMLDOMAttribute;
  AttributeMathID: IXMLDOMAttribute;
  AttributeXMLID: IXMLDOMAttribute;
  Configuration: IXMLDOMElement;
  IsUAD: Boolean;
begin
  // 110811 JWyatt Perform configuration operations ONLY for UAD cells. Potential UAD cells
  //  on non-UAD forms (ex. comparable grid on the REO2008) cannot be UAD enabled
  //  until these forms become part of the FNMA set.
  if IsUADCell(self) then
    begin
      // get cell configuration from UAD database
      IsUAD := CellContainer(Self).UADEnabled;
      Configuration := TUADConfiguration.Cell(FCellXID, UID);
      Configuration := TUADConfiguration.Mismo(Configuration, IsUAD);
      if Assigned(Configuration) then
        begin
          AttributeDialogID := Configuration.getAttributeNode(CAttributeDialogID);
          AttributeEditorClass := Configuration.getAttributeNode(CAttributeEditorClass);
          AttributeEnabled := Configuration.getAttributeNode(CAttributeEnabled);
          AttributeMinLength := Configuration.getAttributeNode(CAttributeMinLength);
          AttributeMaxLength := Configuration.getAttributeNode(CAttributeMaxLength);
          AttributeDefValue := Configuration.getAttributeNode(CAttributeDefValue);
          AttributeDefDecimal := Configuration.getAttributeNode(CAttributeDefDecimal);
          AttributeLocCtxID := Configuration.getAttributeNode(CAttributeLocCtxID);
          AttributeCtxID := Configuration.getAttributeNode(CAttributeCtxID);
          AttributeMathID := Configuration.getAttributeNode(CAttributeMathID);
          AttributeXmlID := Configuration.getAttributeNode(CAttributeXmlID);

          if (AttributeDefDecimal <> nil) and CellContainer(Self).docIsNew then
            begin
               IntVal := StrToIntDef(AttributeDefDecimal.text, 0);
               case IntVal of
                 1: FCellFormat := SetBit(FCellFormat, bRnd1P1);   //round to 0.1
                 2: FCellFormat := SetBit(FCellFormat, bRnd1P2);   //round to 0.01
                 3: FCellFormat := SetBit(FCellFormat, bRnd1P3);   //round to 0.001
                 4: FCellFormat := SetBit(FCellFormat, bRnd1P4);   //round to 0.0001
                 5: FCellFormat := SetBit(FCellFormat, bRnd1P5);   //round to 0.00001
                end;
            end;

          if (AttributeDefValue <> nil) and (FText = '') and (appPref_UADAutoZeroOrNone and CellContainer(Self).docIsNew) then
            SetText(AttributeDefValue.Text);

          if (AttributeLocCtxID <> nil) then
            if IsValidInteger(AttributeLocCtxID.Text, IntVal) then
              FLocalCTxID := IntVal;

          if (AttributeCtxID <> nil) then
            if IsValidInteger(AttributeCtxID.Text, IntVal) then
              FContextID := IntVal;

          if (AttributeXmlID <> nil) then
            if IsValidInteger(AttributeXmlID.Text, IntVal) then
              FCellXID := IntVal;

          if (AttributeMathID <> nil) then
            if IsValidInteger(AttributeMathID.Text, IntVal) then
              FMathID := IntVal;

          if AttributeMaxLength <> nil then
            FMaxLength := StrToInt(AttributeMaxLength.text)
          else
            FMaxLength := -1;  // 061711 Changed from zero per JBradford

          if AttributeMinLength <> nil then
            FMinLength := StrToIntDef(AttributeMinLength.text, -1)
          else
            FMinLength := -1;  // 061711 Set to minus 1 per JBradford

          // set the dialog flag and validate the dialog cell group
          if Assigned(AttributeDialogID) and not IsBitSet(FCellStatus, bDisabled) then
            TDialogEditorHelper.ValidateDialogGroup(Self)
          else
            HasValidationError := False;

          // enable or disable the cell
          if Assigned(AttributeEnabled) then
            if SameText(AttributeEnabled.value, 'false') then
              begin
                Text := '';
                FEmptyCell := False;
                Disabled := True;
              end
            else
              begin
                if Text = '' then
                  FEmptyCell := True;
                Disabled := False;
              end;

          // summary set the editor class
          if Assigned(AttributeEditorClass) then
            FEditorClass := UEditor.GetEditorClass(AttributeEditorClass.text)
          else
            FEditorClass := nil;
        end;
    end;
end;

function TBaseCell.CanEdit: Boolean;
begin
  Result := True;
  Result := Result and not CellContainer(Self).Locked;
  Result := Result and not Disabled;
  Result := Result and not IsBitSet(FCellPref, bCelDispOnly);
end;

procedure TBaseCell.Assign(source: TBaseCell);
begin
  if (Source is TBaseCell) then
    begin
      // copy cell formatting
      FCellPref := source.FCellPref;
      FCellFormat := source.FCellFormat;
      FTxSize := abs(source.FTxSize);  //don't transfer the minus sign, its added at each cell
      FTxJust := source.FTxJust;
      FTxStyle := source.FTxStyle;
      FManualEntry := source.FManualEntry;
      FClipped := source.FClipped;
      AssignContent(source);
    end;
end;

//Note: Formating info is not assigned here
procedure TBaseCell.AssignContent(Source: TBaseCell);
var
  InstanceIDString: String;
  Longitude, Latitude: String;
begin
  if (Source is TBaseCell) then
    begin
      // copy cell text
      SetText(source.FText);
      FCellStatus := source.FCellStatus;
      CheckTextOverflow;   //set overflow flag by this cell rather than copy from source
      FEmptyCell := source.FEmptyCell;
      FWhiteCell := source.FWhiteCell;
      FValidationError := source.FValidationError;

      // copy cell properties, except the instance ID
      InstanceIDString := FProperties.Values[CPropertyInstanceID];
      Latitude := FProperties.Values[CPropertyLatitude];
      Longitude := FProperties.Values[CPropertyLongitude];
      FProperties.Text := source.FProperties.Text;
      FProperties.Values[CPropertyInstanceID] := InstanceIDString;
      if Length(Latitude) > 0 then
        FProperties.Values[CPropertyLatitude] := Latitude;
      if Length(Longitude) > 0 then
        FProperties.Values[CPropertyLongitude] := Longitude;

      // process changes
      PropertiesChanged;
      ProcessMath;
      Display;

      // refresh the cell editor
      Dispatch(DM_RELOAD_EDITOR, DMS_CELL, nil);
    end;
end;

procedure TBaseCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	sBox: TRect;
begin
  saveFont.Assign(Canvas.Font);
  Canvas.Refresh;
	if Length(FText) > 0 then
		begin
      Canvas.Font.Assign(CellContainer(Self).docFont);
			Canvas.Font.Color := CellContainer(Self).GetDataFontColor(isPrinting);
      Canvas.Font.Size := Muldiv(FtxSize, xDC, Canvas.Font.PixelsPerInch);
      CheckTextOverflow;
      sBox := FFrame;
      if IsBitSet(FCellStatus, bOverflow) and appPref_AutoFitTextToCell and not IsBitSet(FCellPref, bNotAutoFitTextTocell) then    //application and cell preference
        if CellFontToFitInBox(Canvas, FText, ScaleRect(sBox, xDoc, xDC)) then
          begin
            FtxSize := MulDiv(Canvas.Font.Size, Canvas.Font.PixelsPerInch, xDC);  //unscale, FTxSize keeps unscaled font
            CheckTextOverflow;
          end;
			if not isPrinting then begin                  //do the hilighting
				Canvas.Brush.color := BackGround;
				Canvas.Brush.Style := bsSolid;
				Canvas.FillRect(ScaleRect(FFrame, xDoc, xDC));
        if IsBitSet(FCellStatus, bOverflow) then
          Canvas.Font.Color := colorOverflowTx;
			end;

			//Canvas.Font.Height := -MulDiv(FTxSize, xDC, xDoc);
      //051512 Version 7.7.0.7 Was: Canvas.Font.Style := GetCellPrefStyle(FCellPref); //FTxStyle;
			Canvas.Font.Style := FTxStyle;
			Canvas.Brush.Style := bsClear; 				//make text trasnparent so we don't erase stuff
      canvas.Font.Name  := FFontName;       //set font name

			//sBox := FFrame;
			sBox.Left := sBox.Left+1;				//+1 since editor insets 1 pixel
			sBox := ScaleRect(sBox, xDoc, xDC);
			DrawString(Canvas, sBox, FText, FTxJust, isPrinting);
		end
	else if not isPrinting then    //empty cell hilighting
		begin
			Canvas.Brush.color := BackGround;
			Canvas.Brush.Style := bsSolid;
			Canvas.FillRect(ScaleRect(FFrame, xDoc, xDC));
		end;
  Canvas.Font.Assign(saveFont);
end;

//used to redisplay a cell after contents have been altered
procedure TBaseCell.Display;
var
	canvas: TCanvas;
	curFocus: TFocus;
begin
	if DisplayIsOpen(False) then begin
		canvas := CellContainer(Self).docView.Canvas;
		GetViewFocus(canvas.Handle, curFocus);
		FocusOnCell;
		DrawZoom(Canvas, cNormScale, docScale, false);
		SetViewFocus(Canvas.Handle, curFocus);
	end;
end;

procedure TBaseCell.EraseCell;
begin
	if (length(FText) > 0) or FWhiteCell then       		//are we really being modified?
		Modified := true;

	FWhiteCell := False;
	FEmptyCell := True;
	FText := '';
	FValue := 0;																//set here when empty string

	Display;                                    //now show it
end;

procedure TBaseCell.FocusOnCell;
var
  Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
			CellContainer(Self).docView.SetViewOrg(Pt);
			SetClip(Canvas.Handle, Cell2View);      //convert cell to View coords and use as clip
		end;
end;

//View coordinates cannot be scaled
procedure TBaseCell.FocusOn(View: TRect);
var Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
			CellContainer(Self).docView.SetViewOrg(Pt);
			view := Cell2ClientRect(View);		//get client coords
			SetClip(Canvas.Handle, View);     //clip to it
		end;
end;

procedure TBaseCell.FocusOnWindow;
begin
	CellContainer(Self).docView.FocusOnWindow;
end;

procedure TBaseCell.FocusOnDocument;
begin
	CellContainer(Self).docView.FocusOnDocument;    //set origins to scrollpositions
//	with ParentViewPage do
//		SetViewPortOrgEx(Canvas.Handle, PgOrg.x, PgOrg.y, nil);
end;

function TBaseCell.Caret2View(Pt: TPoint): TPoint;
begin
	result.x := Pt.x + cMarginWidth + ParentViewPage.PgOrg.x;
	result.y := Pt.y + cTitleHeight + ParentViewPage.PgOrg.y;
end;

//used for mouseUp, mouseDown (quick way to get to view, no scaling)
function TBaseCell.Doc2View(Pt: TPoint): TPoint;
begin
	Pt := ParentViewPage.Doc2Page(Pt);           //normalize to page coords
	result.x := Pt.x - cMarginWidth;             //do specific to body
	result.y := Pt.y - cTitleHeight;
end;

function TBaseCell.Cell2View: TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(FFrame.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(FFrame.bottomRight));
end;

function TBaseCell.Cell2ClientRect(R: TRect): TRect;
begin
	result.topLeft := TDocView(ParentViewPage.Owner).Doc2Client(Area2Doc(R.topLeft));
	result.bottomRight := TDocView(ParentViewPage.owner).Doc2Client(Area2Doc(R.bottomRight));
end;

procedure TBaseCell.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	curFocus: TFocus;
begin
	CellContainer(Self).MakeCurCell(Self);     //switch active to this cell if need be

	GetViewFocus(docCanvas.Handle, curFocus);
	FocusOnCell;
	if (Editor <> nil) then
    begin
      //PAM: handle comment cell in UAD comment form, only do clickEditor whtn we can edit the cell
      if (self.UID.FormID = 972) and (self.FCellID=1218) then
      begin
        if (TEditor(Editor).FCanEdit) then
  		    TEditor(Editor).ClickEditor(Point(x,y), Button, Shift);      //now process the click
      end
      else
		    TEditor(Editor).ClickEditor(Point(x,y), Button, Shift);       //now process the click
    end;
	SetViewFocus(docCanvas.handle, curFocus);
end;

procedure TBaseCell.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt: TPoint;
	curFocus: TFocus;
begin
	GetViewFocus(docCanvas.Handle, curFocus);
	FocusOnCell;
	Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords

	if Editor <> nil then
		TEditor(Editor).ClickMouseUp(sender, Button, Shift, Pt.x, Pt.y);    //tell it click is over.

	SetViewFocus(docCanvas.handle, curFocus);
end;

procedure TBaseCell.MouseMove(Sender: TObject; Shift: TShiftState; X, Y, Scale: Integer);
var
	Pt: TPoint;
	curFocus: TFocus;
begin
	GetViewFocus(docCanvas.Handle, curFocus);
	FocusOnCell;
	Pt := Doc2View(Point(X,Y));      //no scaling, just offsets, need in view coords

	if Editor <> nil then
		TEditor(Editor).ClickMouseMove(Sender, Shift, Pt.X, Pt.Y);      //see if we're dragging or selecting

	SetViewFocus(docCanvas.handle, curFocus);
end;

//this was so that we can drop Cell ID and RspID into a cell
//this was for designing forms within ClickFORMS
//this is better done in the Forms Designer
procedure TBaseCell.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
  if Source is TDragRspID then
    with source as TDragRspID do
      begin
        FRspKindID := KindID;
		    FResponseID := ID;
        DisplayCellRspIDs;
        Display;
      end
  else if source is TDragCellID then
    with source as TDragCellID do
      begin
        FCellKindID := KindID;
		    FCellID := ID;
        DisplayCellRspIDs;
        Display;
      end
  else
    inherited;
end;

procedure TBaseCell.DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if source is TDragRspID then
    accept := True
  else if source is TDragCellID then
    accept := True
  else
    inherited;
end;

procedure TBaseCell.SetEditState(editorActive: Boolean);
begin
	FIsActive := editorActive;
end;

function TBaseCell.HasMetaData(metaType: Integer): Boolean;
begin
  result:= False;  //reg cells do not have meta data, cell that do (graphic) override this function
end;

function TBaseCell.GetMetaData: integer;
begin
  result:= -1;
end;

procedure TBaseCell.SetCellNumber(ID: Integer);
begin
  SetText(IntToStr(ID));
end;

//used to create MISMO Mapping Spreadheet
procedure TBaseCell.DisplayCellID(ASequenceID : Integer);
//var
//  ThisCellID : Integer;
begin
  SetText(IntToStr(FCellID));
(*
{$IFDEF LOG_CELL_MAPPING}
  if Self is TPgNumCell then
     ThisCellID := -2
  else if not Self.CanEdit then
     ThisCellID := -1
  else
     ThisCellID := Self.FCellID;

  with CellMappingNextCell do
  begin
    if CellMappingSpreadsheet <> nil then           // e.g. they are not displaying CellID
      begin
         CellMappingSpreadsheet.Sheets[CellMappingSheetIndex].AsString[X, Y] :=
             SysUtils.Format('%d=%d', [ASequenceID, ThisCellID]);
         Inc(Y);                                     //  set for next row
      end;
  end;
{$ENDIF}
*)
end;

procedure TBaseCell.DisplayCellXID;
begin
  SetText(IntToStr(FCellXID));
end;

procedure TBaseCell.DisplayCellMathID;
begin
  if FMathID <> 0 then
	  SetText(IntToStr(FMathID));
end;

procedure TBaseCell.DisplayCellLocalContext;
begin
  if FLocalCTxID <> 0 then
	  SetText(IntToStr(FLocalCTxID));
end;

procedure TBaseCell.DisplayCellGlobalContext(ASequenceID : Integer);
begin
  if FContextID <> 0 then
	  DoSetText(IntToStr(FContextID));
end;

procedure TBaseCell.DebugSpecial;
begin
  if (FLocalCTxID <> 0) and (FContextID <> 0) then
    SetText(IntToStr(FContextID) + ','+IntToStr(FLocalCTxID))
  else if FLocalCTxID <> 0 then
    SetText(IntToStr(FLocalCTxID));
end;

procedure TBaseCell.DisplayCellRspIDs;
begin
  if FResponseID <> 0 then
	  SetText(IntToStr(FResponseID));
end;

procedure TBaseCell.SetCellSampleEntry;
begin
	SetText('Sample');
end;

procedure TBaseCell.Clear;
begin
	SetText('');
end;

procedure TBaseCell.DoSetText(const Str: String);
begin
  FText := Str;

  if IsAppPrefSet(bUpperCase) then
    FText := UpperCase(FText);

  if length(Str) > 0 then        //use set value to set Fvalue when a number (this is a kludge)
    begin
      FWhiteCell := True;
      FEmptyCell := False;
    end
  else
    begin
      FWhiteCell := False;
      FEmptyCell := True;
      FValue := 0;				//set here when empty string
    end;
//  Modified := true;                //tell everyone we have changed
end;

procedure TBaseCell.SetText(const Str: String);
var
  OriginalText: String;
begin
  OriginalText := FText;

  //update the editor if its active
  If (FEditor <> nil) and (FEditor is TTextEditor) then
    (FEditor as TTextEditor).Text := Str;

  DoSetText(str);          //now set the text

  Modified := Modified or (FText <> OriginalText);        //tell everyone we have changed

  // validate dialog data
  if Modified then
    if CellContainer(Self).UADEnabled then
      TDialogEditorHelper.ValidateDialogGroup(Self);
end;

procedure TBaseCell.CheckTextOverflow;
var
  Box: TRect;
  Canvas: TCanvas;
  Overflowed: Boolean;
  SavedFont: TFont;
begin
  SavedFont := TFont.Create;
  try
    Canvas := CellContainer(Self).docView.Canvas;
    SavedFont.Assign(Canvas.Font);
    try
      Canvas.Font.Assign(CellContainer(Self).docFont);
      Canvas.Font.Height := -MulDiv(FTxSize, docScale, cNormScale);
      Box := FTxRect;
      Box.Left := Box.Left + 1;   //editor offset
      Overflowed := (not TextFitsInBox(Canvas, Text, ScaleRect(Box, cNormScale, docScale)));
      FCellStatus := SetBit2Flag(FCellStatus, bOverflow, overflowed);
    finally
      Canvas.Font.Assign(SavedFont);
    end;
  finally
    FreeAndNil(SavedFont);
  end;
end;

procedure TBaseCell.SetTextSize(Value: Integer);  //this is generic
var
  format: ITextFormat;
begin
  FTxSize := Value;
  If FIsActive and Supports(FEditor, ITextFormat, format) then
    format.Font.Size := Value
  else if length(Text) > 0 then begin
    CheckTextOverflow;
    Display;
  end;
end;

procedure TBaseCell.SetTextJust(value: Integer);
var
  format: ITextFormat;
begin
  FTxJust := Value;
  If FIsActive and Supports(FEditor, ITextFormat, format) then
    format.TextJustification := Value
  else
    Display;
end;

procedure TBaseCell.SetFontStyle(fStyle: TFontStyles);
begin
end;

/// summary: Deletes the specified property.
procedure TBaseCell.DeleteProperty(const Name: String);
begin
  if (FProperties.IndexOfName(Name) > -1) then
    FProperties.Delete(FProperties.IndexOfName(Name));
end;

/// summary: Indicates whether a given property exists.
function TBaseCell.PropertyExists(const Name: String): Boolean;
begin
  Result := (FProperties.IndexOfName(Name) > -1);
end;

procedure TBaseCell.LoadStreamData(Stream: TStream; Amt: LongInt; processIt: Boolean);
begin
end;

procedure TBaseCell.LoadContent(const Str: String; processIt: Boolean);
begin
  SetText(Str);
  Display;
  if processIt then PostProcess;
end;

procedure TBaseCell.LoadContent2(const Str: String; processIt: Boolean); //Pam: Make numeric value to show format
var
  aValue:Double;
  aStr:String;
begin
  if CompareText(str,SPARK_BLANK_CHAR) = 0 then
     SetText('')
  else
    LoadContent(Str,ProcessIt);  //we have text, set it first
    
  if self.FSubType = cKindCalc then //handle calculated cell to set format
    begin
      if length(str) > 0 then  //we have some text here
        begin
          if IsValidNumber(str,aValue) then   //only do this for numbers
            SetValue(aValue)
          else //if other than number set the text as is
            begin
              if pos('sf', Str) > 0 then
                begin
                  aStr := str;
                  aStr := popStr(astr, ' sf');
                  if IsValidNumber(aStr,aValue) then
                    begin
                      SetValue(aValue);
                      FText := FText + ' sf';
                    end;
                end
              else if CompareText(str,SPARK_BLANK_CHAR) = 0 then  //clear text
                SetText('')
              else
                SetText(Str);
            end;
        end
      else //it's EMPTY value
        SetText(Str);
    end;
end;


procedure TBaseCell.LoadData(const data: String);
begin
	SetText(data);
	Display;
  PostProcess;
end;

procedure TBaseCell.SetModified(Value: Boolean);
begin
  if (FModified <> Value) then
    begin
      FModified := Value;                           //set cell's flag
      TDocPage(FParentPage).DataModified := Value;  //signal doc we've changed
      if DebugMode then
        Display;
    end;
    if Value then
      FSaved := Value;  //ticket #750: turn on FSave for the save to comps db 
end;

procedure TBaseCell.SetFormatModifiedFlag;    //(Value: Boolean);
begin
  TDocPage(FParentPage).FormatModified := True;   //tell page->forms->container the docPref changed
end;

function TBaseCell.GetText: String;
begin
	result := FText;
end;

function TBaseCell.GetFormatedString(Value: Double): String;
begin
	result := FormatValue(value, FCellFormat);
end;

function TBaseCell.Format(Value: String): String;
begin
  result := Value;
end;

procedure TBaseCell.SetValue(Value: Double);
var
  strValue: String;
begin
	FValue := Value;              				  //remember the value
  strValue := GetFormatedString(value);   //how does cellwant it Formatted
  SetText(strValue);                      //let set text handle it
end;

function TBaseCell.GetRealValue: Double;
begin
  result := GetStrValue(FText);
end;

function TBaseCell.GetIntValue: Integer;
var
	E: Integer;
begin
	Val(FText, Result, E);
	if E <> 0 then Result := 0;      	//there was error so return to zero
end;

function TBaseCell.GetMathCmd: Integer;
begin
	result := FMathID;
end;

procedure TBaseCell.ProcessMath;
var
	doc: TContainer;
	FormUID: Integer;
begin
	if FMathID > 0 then
		begin
			doc := CellContainer(Self);
			FormUID := CellForm(self).frmInfo.fFormUID;
      if (IsAppPrefSet(bAutoCalc) and IsBitSet(FCellPref, bCelCalc)) then
			  ProcessCurCellMath(doc, FormUID, FMathID, self);
		end;
end;

procedure TBaseCell.ReplicateLocal(start: Boolean);
var
  form: TDocForm;
  doc: TContainer; //YF 06.06.02
  LocContxID: Integer;
begin
  if (FLocalCTxID > 0) or ((FLocalCTxID < 0) and Start) then
  begin
    LocContxID := abs(FLocalCTxID);
    doc :=  CellContainer(Self);
    if doc.CanProcessLocal(self) and IsBitSet(FCellPref, bCelTrans) then
      begin
        if (LocContxID = 41) and not appPref_AppraiserGRMTransfer then  //#1348: only transfer GRM if checked
          exit
        else
          begin
            form := CellForm(Self);
            form.BroadcastLocalCellContext(LocContxID, Self);
          end;
      end;
  end;
end;

procedure TBaseCell.ReplicateGlobal;
var
	doc: TContainer;
begin
 	if FContextID > 0 then
  begin
    doc := CellContainer(Self);
    if doc.CanProcessGlobal(Self) and IsBitSet(FCellPref, bCelTrans) then
//    if doc.CanProcessGlobal(Self) and IsBitSetUAD(FCellPref, bCelTrans) then
      begin
        doc.BroadcastCellContext(FContextID, Self);    //tell doc to replicate our data
        MungeText;
      end;
  end;
end;

procedure TBaseCell.PreProcess;
begin
// do nothing, let cells decid
end;



procedure TBaseCell.PostProcess;
begin
// do nothing, let cells decide
end;

procedure TBaseCell.MungeText;
begin
//do nothing, let cells decide
end;

function TBaseCell.GetGroupTable: TGroupTable;
begin
	result := nil;
end;

function TBaseCell.GetCellIndex: Integer;
begin
	result := TDocPage(FParentPage).pgData.IndexOf(self); //whats our index in list
end;

//View is in doc coordinates
function TBaseCell.InView(View: TRect; Var Pt: TPoint): Boolean;
begin
	Pt.x := (FFrame.left + FFrame.right) div 2;
	Pt.y := (FFrame.top + FFrame.bottom) div 2;
	Pt := Area2Doc(Pt);                       //normalize
	result := PtInRect(View, Pt);             //is it visible
end;

function TBaseCell.DisplayIsOpen(openIt: Boolean): Boolean;
begin
  result := ParentViewPage.DisplayIsOpen(openIt);
end;

//### put the flags stuff here
//SpecRec is saved with the file.
procedure TBaseCell.EncodeCellPrefs(var specRec: CellSpecRec);
begin
	//convert from integers to bit flags
	FCellPref := SetBit2Flag(FCellPref, bTxJustLeft, FTxJust = tjJustLeft);
	FCellPref := SetBit2Flag(FCellPref, bTxJustCntr, FTxJust = tjJustMid);
	FCellPref := SetBit2Flag(FCellPref, bTxJustRight, FTxJust = tjJustRight);
	FCellPref := SetBit2Flag(FCellPref, bTxJustFull, FTxJust = tjJustFull);
	FCellPref := SetBit2Flag(FCellPref, bTxJustOffset, FTxJust = tjJustOffLeft);

	FCellPref := SetBit2Flag(FCellPref, bTxPlain, FTxStyle = []);
	FCellPref := SetBit2Flag(FCellPref, bTxBold, fsBold in FTxStyle);
	FCellPref := SetBit2Flag(FCellPref, bTxItalic, fsItalic in FTxStyle);

	FCellStatus := SetBit2Flag(FCellStatus, bEmptyCell, FEmptyCell);
	FCellStatus := SetBit2Flag(FCellStatus, bWhiteCell, FWhiteCell);
	FCellStatus := SetBit2Flag(FCellStatus, bManEntry, FManualEntry);
	FCellStatus := SetBit2Flag(FCellStatus, bValidationError, FValidationError);

	//now save all the stuff
	NumXChg(specRec.fWhoIsCell).HiWrd := FType;           //remeber this incase form def is lost
	NumXChg(specRec.fWhoIsCell).LoWrd := FSubType;        //if form def lost, read 1st long to reconstruct cell
	specRec.fPref := FCellPref;
	specRec.fFormat := FCellFormat;
	specRec.fStatus := FCellStatus;
	specRec.fSize := Abs(FTxSize);
	specRec.fBkGrdColor := Background;
end;

procedure TBaseCell.DecodeCellPrefs(var specRec: CellSpecRec);
begin
	FCellPref := specRec.fPref;
	FCellFormat := specRec.fFormat;
	FCellStatus := specRec.fStatus;

	FEmptyCell := IsBitSet(FCellStatus, bEmptyCell);
	FWhiteCell := IsBitSet(FCellStatus, bWhiteCell);
	FManualEntry := IsBitSet(FCellStatus, bManEntry);
	FValidationError := IsBitSet(FCellStatus, bValidationError);

	FTxSize := specRec.fSize;

	FTxJust := GetCellPrefJust(FCellPref);
	FTxStyle := GetCellPrefStyle(FCellPref);
end;

procedure TBaseCell.ReadCellData(stream: TStream; Version: Integer);
var
	TextLen, amt: Integer;
	specRec: CellSpecRec;
	S: String;
begin
	amt := SizeOf(CellSpecRec);              //Read the Cell State, Pref, and Format
	stream.Read(specRec, amt);
	DecodeCellPrefs(specRec);

  // read text and extended properties
  stream.Read(TextLen, sizeof(TextLen));
  SetString(S, nil, TextLen);
  stream.Read(Pointer(S)^, TextLen);

  // separate text from extended properties
  // text followed by a double null provides compatibility with "a la mode" software
  if (Pos(#0#0, S) > 0) then
    TextLen := Pos(#0#0, S) - 1
  else
    TextLen := Length(S);

  FText := Copy(S, 0, TextLen);
  S := Copy(S, TextLen + 3, Length(S));
  if (S <> '') then
    FProperties.CommaText := S;
end;

procedure TBaseCell.WriteCellData(stream: TStream);
begin
  case CellContainer(Self).FileFormat of
    ffClickFORMS6:
      WriteCellData6(stream);
    ffClickFORMS7:
      WriteCellData7(stream);
  else
    WriteCellData7(stream);
  end;
end;

procedure TBaseCell.WriteCellData6(stream: TStream);
var
	TextLen, amt: Longint;
	specRec: CellSpecRec;
	Str: String;
begin
	EncodeCellPrefs(specRec);           //Write the Cell State, Pref, and Format
	amt := SizeOf(CellSpecRec);
	stream.WriteBuffer(specRec, amt);

  // write text and extended properties
  str := FText;
  TextLen := Length(str);
  stream.WriteBuffer(TextLen, sizeof(TextLen));
  stream.WriteBuffer(Pointer(str)^, TextLen);

	FModified := False;                         	//reset the flag
end;

procedure TBaseCell.WriteCellData7(stream: TStream);
var
	TextLen, amt: Longint;
	specRec: CellSpecRec;
	Str: String;
begin
	EncodeCellPrefs(specRec);           //Write the Cell State, Pref, and Format
	amt := SizeOf(CellSpecRec);
	stream.WriteBuffer(specRec, amt);

  // write text and extended properties
  // text followed by a double null provides compatibility with "a la mode" software
  str := FText + #0#0 + FProperties.CommaText;
  TextLen := Length(str);
  stream.WriteBuffer(TextLen, sizeof(TextLen));
  stream.WriteBuffer(Pointer(str)^, TextLen);

	Modified := False;                         	//reset the flag
end;

procedure TBaseCell.ExportToTextFile(var stream: TextFile);
begin
   // 113011 Enable the following to produce a Datamaster compatible import file
{  if TestVersion and (GSEData <> '') then
	  WriteLn(stream, StringReplace(GetText, #10, '&#10;', [rfReplaceAll]) + #9 + 'GSE=' + GSEData)
  else}
    // 113011 Get the text and change any line feed characters to their entity equivalents
    //  for later importing and conversion. Otherwise all comments will not be restored.
  	WriteLn(stream, StringReplace(GetText, #10, '&#10;', [rfReplaceAll]));
end;

procedure TBaseCell.ImportFromTextFile(var stream: TextFile);
var
	str: String;
begin
	ReadLn(stream, str);
	SetText(str);
end;

{********************************************}
{                                            }
{               TDataBoundCell               }
{                                            }
{********************************************}

function TDataBoundCell.GetDataLinkCount: Integer;
begin
  Result := FDataLinks.Count;
end;

/// summary: Finds the data source cell instance.
function TDataBoundCell.FindCellDataSourceInstance: TDataBoundCell;
  function FindCellMergeInstance(const Instance: String; const Document: TContainer): TBaseCell;
  var
    Form: Integer;
    Page: Integer;
    Cell: Integer;
  begin
    Result := nil;
    if Assigned(Document.docForm) then
      for Form := 0 to Document.docForm.Count - 1 do
        if Assigned(Document.docForm[Form].frmPage) then
          for Page := 0 to Document.docForm[Form].frmPage.Count - 1 do
           if Assigned(Document.docForm[Form].frmPage[Page].pgData) then
             for Cell := 0 to Document.docForm[Form].frmPage[Page].pgData.Count - 1 do
               if (Instance = Document.docForm[Form].frmPage[Page].pgData[Cell].Properties[CPropertyMergedInstanceID]) then
                 begin
                   Result := Document.docForm[Form].frmPage[Page].pgData[Cell];
                   Exit;
                 end;
  end;
var
  Cell: TBaseCell;
begin
  if PropertyExists(CPropertyMergedDataSource) then
    begin
      Cell := FindCellMergeInstance(Properties[CPropertyDataSource], CellContainer(Self));
      if Assigned(Cell) then
        begin
          DataSource := Cell.InstanceID;
          DeleteProperty(CPropertyMergedDataSource);
        end;
    end
  else
    Cell := CellContainer(Self).FindCellInstance(DataSource);

  if (Cell is TDataBoundCell) then
    Result := Cell as TDataBoundCell
  else
    Result := nil;
end;

procedure TDataBoundCell.Loaded;
begin
  inherited;
  AttachDataLink;

  if not Assigned(FDataCell) then
    DataSource := GUID_NULL;
end;

function TDataBoundCell.GetDataCell: TDataBoundCell;
begin
  if Assigned(FDataCell) then
    Result := FDataCell
  else
    Result := Self;
end;

function TDataBoundCell.GetDataLink(Index: Integer): TDataBoundCell;
begin
  Result := FDataLinks[Index] as TDataBoundCell;
end;

procedure TDataBoundCell.AttachDataLink;
var
  Cell: TDataBoundCell;
begin
  DetachDataLink;
  if not FAttaching then
    try
      FAttaching := True;

      if not IsEqualGUID(DataSource, GUID_NULL) then
        begin
          Cell := FindCellDataSourceInstance;
          if (Cell = Self) then
            Cell := nil;
        end
      else
        Cell := nil;

      if Assigned(Cell) then
        try
          FDataCell := Cell;
          FDataCell.FDataLinks.Add(Self);
        except
          DetachDataLink;
        end;
    finally
      FAttaching := False;
    end;
end;

procedure TDataBoundCell.DetachDataLink;
begin
  if Assigned(FDataCell) then
    begin
      FDataCell.FDataLinks.Remove(Self);
      FDataCell := nil;
    end;
end;

function TDataBoundCell.GetDataSource: TCellInstanceID;
begin
  if (Properties[CPropertyDataSource] <> '') then
    try
      Result := StringToGuid(Properties[CPropertyDataSource]);
    except
      Result := GUID_NULL;
    end
  else
    Result := GUID_NULL;
end;

procedure TDataBoundCell.SetDataSource(const Value: TCellInstanceID);
begin
  if IsEqualGuid(Value, InstanceID) then
    raise Exception.Create(SCircularDataLink);

  if IsEqualGuid(Value, GUID_NULL) then
    DeleteProperty(CPropertyDataSource)
  else
    Properties[CPropertyDataSource] := GuidToString(Value);
end;

procedure TDataBoundCell.PropertiesChanged;
begin
  if not FAttaching and not IsEqualGUID(DataSource, DataCell.InstanceID) then
    if not (IsEqualGUID(DataSource, GUID_NULL) and (DataCell = Self)) then
      begin
        DetachDataLink;
        if not IsEqualGUID(DataSource, GUID_NULL) then
          AttachDataLink;
      end;

  inherited;
end;

procedure TDataBoundCell.TransferDataSource(const NewDataCell: TDataBoundCell);
var
  OldDataCell: TDataBoundCell;
begin
  OldDataCell := DataCell;
  NewDataCell.DataSource := GUID_NULL;
  OldDataCell.DataSource := NewDataCell.InstanceID;
  OldDataCell.Modified := True;
  NewDataCell.Modified := True;

  while (OldDataCell.FDataLinks.Count > 0) do
    (OldDataCell.FDataLinks.Items[0] as TDataBoundCell).DataSource := NewDataCell.InstanceID;
end;

constructor TDataBoundCell.Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject);
begin
  FDataLinks := TCellList.Create;
  inherited;
end;

destructor TDataBoundCell.Destroy;
begin
  FreeAndNil(FDataLinks);
  inherited;
end;

procedure TDataBoundCell.BeforeDestruction;
begin
  if (DataCell = Self) and (DataCell.FDataLinks.Count > 0) then
    TransferDataSource(DataCell.FDataLinks.First as TDataBoundCell);

  DetachDataLink;
end;

/// summary: Configures the cell for linking to its data source after merging.
procedure TDataBoundCell.Assign(Source: TBaseCell);
var
  SourceCell: TDataBoundCell;
begin
  inherited;
  SourceCell := (Source as TDataBoundCell);
  if not Assigned(SourceCell.FDataCell) then
    Properties[CPropertyMergedInstanceID] := GuidToString(Source.InstanceID)
  else
    Properties[CPropertyMergedDataSource] := CPropertyMergedInstanceID;
end;

function TDataBoundCell.HasData;
begin
  if (DataCell = Self) then
    Result := inherited HasData
  else
    Result := DataCell.HasData;
end;

{********************************************}
{                                            }
{             TTextBaseCell                  }
{                                            }
{********************************************}

/// summary: Gets the instance ID of the linked carry-over comments cell.
function TTextBaseCell.GetLinkedCommentCell: TCellInstanceID;
begin
  if (Properties[CPropertyLinkedCommentCell] <> '') then
    try
      Result := StringToGuid(Properties[CPropertyLinkedCommentCell]);
    except
      Result := GUID_NULL;
    end
  else
    Result := GUID_NULL;
end;

/// summary: Sets the instance ID of the linked carry-over comments cell.
procedure TTextBaseCell.SetLinkedCommentCell(const Value: TCellInstanceID);
var
  BaseCell: TBaseCell;
begin
  if not IsEqualGUID(LinkedCommentCell, Value) then
    begin
      if IsEqualGUID(Value, GUID_NULL) then
        begin
          BaseCell := CellContainer(Self).FindCellInstance(LinkedCommentCell);
          if (BaseCell is TWordProcessorCell) then
            (BaseCell as TWordProcessorCell).DeleteSection(LinkedCommentSection);

          DeleteProperty(CPropertyLinkedCommentCell);
          DeleteProperty(CPropertyLinkedCommentSection);
        end
      else
        Properties[CPropertyLinkedCommentCell] := GuidToString(Value);

      Modified := true;
    end;
end;

/// summary: Gets the section number for linked comments in the comments addenda.
function TTextBaseCell.GetLinkedCommentSection: Integer;
begin
  Result := StrToIntDef(Properties[CPropertyLinkedCommentSection], -1);
end;

/// summary: Sets the section number for linked comments in the comments addenda.
procedure TTextBaseCell.SetLinkedCommentSection(const Value: Integer);
begin
  Properties[CPropertyLinkedCommentSection] := IntToStr(Value);
  Modified := True;
end;

/// summary: Indicates whether the cell has linked comments.
function TTextBaseCell.GetHasLinkedComments: Boolean;
begin
  Result := PropertyExists(CPropertyLinkedCommentCell);
end;

//github 67
procedure TTextBaseCell.ConvertCellText;
const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;

var
  SiteArea: Double;
  EndIdx, PosItem: Integer;
  goOn: Boolean;
  aCell: TBaseCell;
  aStr: String;
begin
  text := FText;
  case FCellID of
    67, 86:   //cellid 67 for 1004, 86 for 2090
      begin
        if not IsAppPrefSet(bCalcCellEquation) then exit; //only convert site area when the calc setting is set
        //github 277
        if CellContainer(Self).UADEnabled then
          goOn := True
        else
          begin
            case UID.FormID of
              349, 342, 364, 365, 869: goOn := true;
              else
                goOn := False;
            end;
          end;
        if not goOn then exit;

        if (length(FText) > 0) and (getValidInteger(FText) > 0) then //Ticket #1324: roll back the change to not to do any formatting in site area.  No comma 
          begin
              SiteArea := StrToFloat(GetFirstNumInStr(StringReplace(FText, ',', '', [rfReplaceAll]), False, EndIdx));
              if (SiteArea > 0) and (FText <> '') then
              begin
                PosItem := Pos('ACRE', Uppercase(FText));
                if PosItem = 0 then
                  PosItem := Pos('AC', Uppercase(FText));
                if (PosItem > 0) then
                  FText := Trim(SysUtils.Format('%-20.2f',[SiteArea])) + ' ' + cAcres
                else
                  // assume square feet
                  begin
                    if SiteArea >= cAcre then
                      FText := Trim(SysUtils.Format('%-20.2f', [SiteArea / cAcre])) + ' ' + cAcres
                    else
                      FText := Trim(SysUtils.Format('%-20.0f', [SiteArea])) + ' ' + cSqFt;
                  end;
                Text := StringReplace(FText, ',', '', [rfReplaceAll]);
                Display;   //refresh
                aCell := cellContainer(self).GetCellByID(976);
                if assigned(aCell) and not IsBitSetUAD(acell.FCellPref, bNoTransferInto) then //pam: github #530: only transfer is user setting transfer in is SET
                  CellContainer(Self).SetCellTextByID(976, Text); //populate to cell 976 on the grid
              end;
          end;
     end;
  end;
end;

/// summary: Naviagtes the user to the linked comments cell.
procedure TTextBaseCell.GoToLinkedComments;
var
  Command: Longword;
  CommentCell: TBaseCell;
  Document: TContainer;
begin
  Document := CellContainer(Self);
  if Assigned(Document) then
    begin
      CommentCell := Document.FindCellInstance(LinkedCommentCell);
      if Assigned(CommentCell) then
        begin
          Command := goCommentSection or (LinkedCommentSection shl 16);
          PostMessage(Document.Handle, CLK_CELLMOVE, Command, Integer(CommentCell));
        end
      else
        begin  // invalid link
          DeleteProperty(CPropertyLinkedCommentSection);
          LinkedCommentCell := GUID_NULL;
        end;
    end;
end;

{********************************************}
{																						 }
{ 							TTextCell										 }
{																						 }
{********************************************}

function TTextCell.GetEditorClass: TCellEditorClass;
begin
  if (FEditorClass <> nil) then
    Result := FEditorClass
  else
    Result := TSLEditor;
end;

constructor TTextCell.Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject);
begin
	inherited Create(AParent, AViewParent, cellDef);

  FTxMask := FCellFormat;
(*
	with cellDef as TCellDesc do
		begin
			FTxMask := CFormat;
		end;
*)
end;

procedure TTextCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
	if not FIsActive or isPrinting then     //editor will draw the cell text when it is active
		inherited DrawZoom(canvas, xDoc, xDC, isPrinting);

	if IsBitSet(FCellPref, bUnderLnCell) then   //but always do the underlining
		with Canvas do
		begin
			Pen.color := CellContainer(Self).GetPenColor(isPrinting);        //do the underlines
			Pen.Style := psSolid;
			Pen.Width := xDC div xDoc div 2;
			MoveTo(MulDiv(FFrame.Left, xDC,xDoc), MulDiv(FFrame.Bottom, xDC,xDoc));
			LineTo(MulDiv(FFrame.Right, xDC,xDoc), MulDiv(FFrame.Bottom, xDC,xDoc));
		end;
end;

procedure TTextCell.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
  inherited;

  if Source is TDragID then
    with source as TDragID do
      if Length(IDName)>0 then
        begin
          SetText(IDName);
          Display;
        end;
end;

procedure TTextCell.SetCellSampleEntry;
begin
	FWhiteCell := True;
	FEmptyCell := False;
  case FSubType of
    cKindTx:
      FText := 'Text';
    cKindCalc:
      begin
        FText := FormatValue(1, FCellFormat);
        if IsBitSet(FCellFormat, bAddComma) then
          Insert(',',FText, pos('1', FText));
      end;
  end;
end;

function TTextCell.InView(View: TRect; Var Pt: TPoint): Boolean;
begin
	with FTxRect do
		case FTxJust of
			tjJustLeft:
					Pt := Point(Left, Bottom);
			tjJustMid:
					Pt := Point((Left + Right) div 2, Bottom);
			tjJustRight:
					Pt := Point(Right, Bottom);
		end;

//	Pt := ScalePt(Pt, cNormScale, docScale);     //scalr to view dimensions
	Pt := Area2Doc(pt);                          //normalize
	result := PtInRect(View, Pt);                //is it visible
end;

procedure TTextCell.Assign(source: TBaseCell);
begin
  inherited Assign(Source);

  if FIsActive and Assigned(FEditor) and (FEditor is TTextEditor) then  //if dest cell is being edited
    (FEditor as TTextEditor).Text := FText;  //save to the editor
end;

function TTextCell.Format(value: String): String;
var
  numValue: Double;
begin
  result := value;
  if (FSubType = cKindCalc) and (length(value) > 0) then
    if IsValidNumber(value, numValue) then
      result := GetFormatedString(numValue);
end;

procedure TTextCell.MungeText;
begin
  if (FContextID > 0) then
    CellContainer(Self).Munger.MungeCell(Self);
end;

procedure TTextCell.PreProcessUAD;   //github 237
var
  aCellTxt: String;
  UADObject: TUADObject;
begin
  if FText = '' then exit;
  UADObject := TUADObject.Create(CellContainer(self));
  try
    aCellTxt := PrefetchUADObject(FCellID, FText); //make it consistent with Redstone push down format
    Text := UADObject.TranslateToUADFormat(nil, FCellID, aCellTxt); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;


procedure TTextCell.PostProcess;
begin
  CellContainer(Self).StartProcessLists;
  try
	  ReplicateLocal(True);       //handle context replication first
    ReplicateGlobal;            //publish outside the form
//    if (self.FCellID <> 1016) and not appPref_UADAutoConvert then //skip math process if in uadconvert and gridcellid =1016
	    ProcessMath;                //do any math assoc. with this cell
//    MungeText;                  //do any munging of the cell text to other cells
    ConvertCellText; //github 67
//    if CellContainer(Self).UADEnabled and appPref_UADAutoConvert then //github 237
//      PreProcessUAD;
    Display;
  except
    on E:Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
  CellContainer(Self).ClearProcessLists;
end;

//This is here because we locked some cells, and they needed to be unlocked
//but since the cell in the file remembers these settings, we have to undo them
//here. In future, decide what cell will remember and what the form def will contribute
procedure TTextCell.ReadCellData(stream: TStream; Version: Integer);
begin
  inherited ReadCellData(stream, Version);

  FCellPref := ClrBit(FCellPref, bCelDispOnly);
  FCellPref := ClrBit(FCellPref, bNoChgToCPref);
  FCellPref := ClrBit(FCellPref, bCannotEdit);
end;

//YF 03.25.03 Use when we replace MlnCell in the new revision
procedure TTextCell.ReadMlnCellData(stream: TStream);
var
	amt, Siz: Integer;
begin
	ReadCellData(stream, 1);   //read text and stuff

	amt := SizeOf(Integer);
	stream.Read(siz, amt);					//read the size value of following data
  stream.Seek(siz,soFromCurrent	)

end;

procedure TTextCell.SetFontStyle(fStyle: TFontStyles); 
begin
  FTxStyle := fStyle;
end;
{***********************************************}
{                                               }
{      TInvisibleCell - Invisible Cell          }
{ Hack used to handle table that is on two pages}
{                                               }
{***********************************************}

function TInvisibleCell.GetEditorClass: TCellEditorClass;
begin
  Result := nil;
end;

procedure TInvisibleCell.Display;
begin
end;

procedure TInvisibleCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
end;

procedure TInvisibleCell.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
end;

function TInvisibleCell.InView(View: TRect; Var Pt: TPoint): Boolean;
begin
  result := False;
end;

procedure TInvisibleCell.PostProcess;
begin
  CellContainer(Self).StartProcessLists;
  try
	  ReplicateLocal(True);       //handlde context replication first
    ReplicateGlobal;            //publish outside the form
	  ProcessMath;                //do any math assoc. with this cell
//    MungeText;                  //do any munging of the cell text to other cells
  except
    on E:Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
  CellContainer(Self).ClearProcessLists;
end;

{***********************************************}
{                                               }
{      TChkBoxCell - Check Box Cell         		}
{                                               }
{***********************************************}

function TChkBoxCell.GetBackground: TColor;
var
  HasGroupEditor: Boolean;
  Index: Integer;
  Row: Integer;
  Table: TGroupTable;
  IsWorksheet, IsUAD: Boolean;
begin
  HasGroupEditor := False;
  Table := GetGroupTable;
  if Assigned(Table) then
    begin
      Row := Table.GetCellTableIndex(CellPage(Self).pgData.IndexOf(Self)).Y;  // row = subgroup (a completely undocumented factoid until now)
      for Index := 1 to Table.FCols do
        HasGroupEditor := HasGroupEditor or Assigned(CellPage(Self).pgData[Table.GetCellAtIndex(Row, Index)].Editor);
    end;

  IsUAD := CellContainer(Self).UADEnabled;
	IsWorksheet := IsUADWorksheet(self);
	if (not IsWorksheet) then
    //set flag directly; don't do any drawing within this routine.
    FValidationError := (not IsUADSpecialCellChkOK(CellContainer(Self), Self));

  if DebugMode and Modified and not Assigned(FEditor) then
    Result := clSilver		//###-JB
  else if ParentPage.ParentForm.ParentDocument.Locked then
    Result := colorLockedCell
  else if IsBitSet(FCellPref, bCelDispOnly) then
    Result := CellContainer(Self).docColors[cFilledColor]
  else if Assigned(FEditor) then
    Result := CellContainer(Self).docColors[cHiliteColor]
  else if HasValidationError then
    Result := CellContainer(Self).docColors[cInvalidCellColor]
  else if HasGroupEditor then
    Result := CellContainer(Self).docColors[cFilledColor]
  else if HasData then
    Result := CellContainer(Self).docColors[cFilledColor]
  else if IsUAD and (not IsWorksheet) and appPref_UseUADCellColorForFilledCells and (FEditorClass <> nil) then
    Result := CellContainer(Self).docColors[cUADCellColor]
  else if IsUAD and (not IsWorksheet) and (FEditorClass <> nil) then
    Result := CellContainer(Self).docColors[cUADCellColor]
  else
    Result := CellContainer(Self).docColors[cEmptyCellColor];
end;

function TChkBoxCell.GetEditorClass: TCellEditorClass;
begin
  if (FEditorClass <> nil) then
    Result := FEditorClass
  else
    Result := TChkBoxEditor;
end;

constructor TChkBoxCell.Create(AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject);
begin
	inherited Create(AParent, AViewParent, cellDef);
end;

destructor TChkBoxCell.Destroy;
begin
	inherited;
end;

procedure TChkBoxCell.AssignContent(Source: TBaseCell);
var
  InstanceIDString: String;
begin
  if (Source is TChkBoxCell) then
    begin
      // copy cell text
      FText := source.FText;
      FChecked := TChkBoxCell(source).FChecked;
      FCellStatus := source.FCellStatus;
      FEmptyCell := source.FEmptyCell;
      FWhiteCell := source.FWhiteCell;
      FValidationError := source.FValidationError;
      FModified := False;

      // copy cell properties, except the instance ID
      InstanceIDString := Properties[CPropertyInstanceID];
      PropertiesText := source.PropertiesText;
      Properties[CPropertyInstanceID] := InstanceIDString;

      // process changes
      PropertiesChanged;
      ProcessMath;
      Display;

      // refresh the cell editor
      Dispatch(DM_RELOAD_EDITOR, DMS_CELL, nil);
    end;
end;

procedure TChkBoxCell.DrawGroup(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  Index: Integer;
  Focus: TFocus;
  Table: TGroupTable;
begin
  Table := GetGroupTable;
  if Assigned(Table) then
    begin
      GetViewFocus(canvas.Handle, Focus);
      try
        for Index := 0 to Length(Table.FCells) - 1 do
          begin
            (ParentPage as TDocPage).pgData[Table.FCells[Index] - 1].FocusOnCell;
            (ParentPage as TDocPage).pgData[Table.FCells[Index] - 1].DrawZoom(canvas, xDoc, xDC, isPrinting);
          end;
      finally
        SetViewFocus(canvas.Handle, Focus);
      end;
    end;
end;

procedure TChkBoxCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	FormatFlags: Integer;
	sBox: TRect;
begin
	//frame the check box
	sBox := ScaleRect(FFrame, xDoc, xDC);
	if isPrinting then
		begin
			Canvas.Pen.color := clBlack;                		 //do the underlines
			Canvas.Pen.Style := psSolid;
			Canvas.Pen.Width := xDC div xDoc div 2;
			canvas.Brush.Style := bsClear;                   //make sure we are clear
			Canvas.Rectangle(sBox.left, sBox.top, sBox.right, sBox.bottom);
		end
	else
		begin
			Canvas.Brush.Color := CellContainer(Self).GetBrushColor(isPrinting);	//colorFormFrame1;
			Canvas.Brush.Style := bsSolid;
			Canvas.FrameRect(sBox);
		end;
	canvas.Brush.Style := bsClear;
        Canvas.Font.Name := FFontName;

	if not FIsActive or isPrinting then				//if not editing this cell...
	begin
		InflateRect(sBox, -1,-1);           //setup for inside

		Canvas.Brush.color := Background;
		if not isPrinting then
			Canvas.FillRect(sBox);           //fill the background

    Canvas.Font.Assign(CellContainer(Self).docFont);
		Canvas.Font.Color := CellContainer(Self).GetDataFontColor(isPrinting);
    if not isPrinting and IsBitSet(FCellStatus, bOverflow) then
      Canvas.Font.Color := colorOverflowTx;
		Canvas.Font.Height := -MulDiv(FTxSize, xDC, xDoc);
		Canvas.Font.Style := FTxStyle;
		Canvas.Brush.Style := bsClear;

		InflateRect(sBox, 1,1);           //setup for inside

//		sBox.bottom := sBox.Bottom + muldiv(2, docScale, cNormScale);       //hack to make X appear centered

		FormatFlags := DT_BOTTOM + DT_SINGLELINE + DT_CENTER + DT_NOPREFIX;
    if TestVersion then FormatFlags := FormatFlags + DT_NOCLIP;         //don't clip checkbox

		DrawText(Canvas.handle, PCHar(FText), length(FText), sBox, FormatFlags);
	end;
end;

function TChkBoxCell.HasData: Boolean;
var
  HasData: Boolean;
  Index: Integer;
  Row: Integer;
  Table: TGroupTable;
begin
  HasData := not FEmptyCell;
  Table := GetGroupTable;
  if Assigned(Table) then
    begin
      Row := Table.GetCellTableIndex(CellPage(Self).pgData.IndexOf(Self)).Y;  // row = subgroup (a completely undocumented factoid until now)
      for Index := 1 to Table.FCols do
        HasData := HasData or not CellPage(Self).pgData[Table.GetCellAtIndex(Row, Index)].FEmptyCell;
    end;
  Result := HasData;
end;

procedure TChkBoxCell.CheckTextOverflow;
begin
  FCellStatus := SetBit2Flag(FCellStatus, bOverflow, False);      //incase the editor sets it
end;

procedure TChkBoxCell.SetCellSampleEntry;
begin
  DoSetText('X');
end;

procedure TChkBoxCell.ToggleGroupMarks(GroupHasMark: Boolean);
var
	i,j,k,curRow,curCol: Integer;
	Group: TGroupTable;
	CIndx: TPoint;
	chkBox:TChkBoxCell;
	cellPage: TDocPage;
	curFocus: TFocus;
begin
	if FGroup > 0 then //cell is part of group, so toggle the group
		begin
			cellPage := TDocPage(FParentPage);
			Group := GetGroupTable;
      if Group = nil then
          begin
            raise Exception.Create('Unable to find the group for CheckBox ' + IntToStr(fCellID) + ' (' + IntToStr(Self.FGroup) + ' on page ' +
                      cellPage.PgTitleName + ' of form ' + TDocForm(cellPage.FParentForm).frmInfo.fFormName +
                      ' (' + IntToStr(TDocForm(cellPage.FParentForm).FormID) + ')');
          end;
			CIndx := Group.GetCellTableIndex(GetCellIndex);
			curRow := CIndx.y;
			curCol := CIndx.x;
			GetViewFocus(docCanvas.Handle, curFocus);
			with Group do
				for i := 1 to FCols do
					if i <> curCol then begin          //don't mess with ourselves
            j := i + (curRow -1) * FCols -1;                //the array index
						k := FCells[j];                                	//get the cell index
						if K <= 0 then
              Beep
            else
              begin
                chkBox := TChkBoxCell(cellPage.PgData[k-1]);    //get the cell
                chkBox.FText := '';
                chkBox.FEmptyCell := True;             //get rid of all text
                chkBox.FWhiteCell := GroupHasMark;     //no data so no white cells
                chkBox.FocusOnCell;
                ChkBox.DrawZoom(docCanvas, cNormScale, docScale, false);
					    end;
					end;
			SetViewFocus(docCanvas.handle, curFocus);
		end;
end;

procedure TChkBoxCell.SetGroupBackground;
var
	i,j,k,curRow{,curCol}: Integer;
	Group: TGroupTable;
	CIndx: TPoint;
	chkBox:TChkBoxCell;
	cellPage: TDocPage;
  GroupHasMark: Boolean;
begin
	if FGroup > 0 then //cell is part of group, so toggle the group
		begin
			cellPage := TDocPage(FParentPage);
			Group := GetGroupTable;
			CIndx := Group.GetCellTableIndex(GetCellIndex);
			curRow := CIndx.y;
//			curCol := CIndx.x;
      GroupHasMark := False;
			with Group do
        begin
          //do we have a mark
          for i := 1 to FCols do
            begin
              j := i + (curRow -1) * FCols -1;                //the array index
              k := FCells[j];                                	//get the cell index
              chkBox := TChkBoxCell(cellPage.PgData[k-1]);    //get the cell
              if chkBox.HasData then GroupHasMark := True;
            end;
          //set the appropriate background
          for i := 1 to FCols do
            begin
              j := i + (curRow -1) * FCols -1;                //the array index
              k := FCells[j];                                	//get the cell index
              chkBox := TChkBoxCell(cellPage.PgData[k-1]);    //get the cell
              chkBox.FEmptyCell := not chkBox.FChecked;       //get rid of all text
              chkBox.FWhiteCell := GroupHasMark;     //no data so no white cells
            end;
        end;
		end;
end;

procedure TChkBoxCell.DoSetText(const Str: String);
begin
  inherited;
  FChecked := length(Str) > 0;
end;

procedure TChkBoxCell.SetText(const Str: String);
begin
  if not FIsActive then      //editor is not handling grouping, so we do it
    ToggleGroupMarks(Length(Str) > 0);
  if (Editor is TChkBoxEditor) then
    (Editor as TChkBoxEditor).TxStr := Str;

  inherited SetText(Str);
end;

procedure TChkBoxCell.SetCellNumber(ID: Integer);
begin
  DoSetText(IntToStr(ID));
end;

procedure TChkBoxCell.Display;
begin
  if (GetGroupTable <> nil) and DisplayIsOpen(False) then
    DrawGroup(CellContainer(Self).docView.Canvas, cNormScale, docScale, False)
  else
    inherited;
end;

procedure TChkBoxCell.DisplayCellID(ASequenceID : Integer = -1);
begin
  DoSetText(IntToStr(FCellID));
end;

procedure TChkBoxCell.DisplayCellXID;
begin
  DoSetText(IntToStr(FCellXID));
end;

procedure TChkBoxCell.DisplayCellMathID(ASequenceID : Integer = -1);
begin
  DoSetText(IntToStr(FMathID));
end;

procedure TChkBoxCell.DisplayCellLocalContext(ASequenceID : Integer = -1);
begin
  if FLocalCTxID <> 0 then
	  DoSetText(IntToStr(FLocalCTxID));
end;

procedure TChkBoxCell.DisplayCellGlobalContext(ASequenceID : Integer = -1);
begin
  if FContextID <> 0 then
	  DoSetText(IntToStr(FContextID));
end;

procedure TChkBoxCell.LoadContent(const Str: String; processIt: Boolean);
begin
  DoSetText(Str);
  Modified := True;
  SetGroupBackground;

  if processIt then PostProcess;
end;

function TChkBoxCell.GetGroupTable: TGroupTable;
begin
	result := nil;
	if FGroup > 0 then
		if TDocPage(FParentPage).PgDesc.PgCellGroups <> nil then
			result := TDocPage(FParentPage).PgDesc.PgCellGroups.GetGroupTable(FGroup);
end;

//same as set text except it's done with boolean;
procedure TChkBoxCell.SetCheckMark(Check: Boolean);
begin
	if check then
		SetText('X')
	else
		SetText('');
end;

procedure TChkBoxCell.ClearCheckMark;
begin
	DoSetText('');
  Modified := true;
end;

procedure TChkBoxCell.WriteCellData(stream: TStream);
begin
	FCellStatus := SetBit2Flag(FCellStatus, bChecked, FChecked);

	inherited WriteCellData(stream);
end;

procedure TChkBoxCell.ReadCellData(stream: TStream; Version: Integer);
begin
	inherited ReadCellData(stream, Version);

	FChecked := IsBitSet(FCellStatus, bChecked);
end;




{***********************************************}
{                                               }
{      TMLnTextCell - MultiLine Text Cell    		}
{                                               }
{***********************************************}


function TMLnTextCell.GetEditorClass: TCellEditorClass;
begin
  if (FEditorClass <> nil) then
    Result := FEditorClass
  else
    Result := TMLEditor;
end;

constructor TMLnTextCell.Create(AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject);
begin
	inherited Create(AParent, AViewParent, cellDef);

  if assigned(cellDef) then
    with cellDef as TCellDesc do
      begin
        FMaxLines := LoWord(CTxLines);
        FTxIndent := HiWord(CTxLines);
        FText := '';

        SetLength(FTxLines, 1);							//allocate 1 line, zero'ed for now (creates new array!)
        FTxLines[0].fstChIdx := 0;          //first char index = 1, 0 = no chars yet
        FTxLines[0].lstChIdx := 0;
      end;
end;

destructor TMLnTextCell.Destroy;
begin
	inherited;

  Finalize(FTxLines);    //dispose of dynamic line array
end;

procedure TMLnTextCell.Assign(source: TBaseCell);
var
  len: Integer;
begin
	inherited Assign(source);

	if source is TMLnTextCell then
		begin
			FMaxLines := TMLnTextCell(Source).FMaxLines;
			FTxIndent := TMLnTextCell(Source).FTxIndent;
      len := length(TMLnTextCell(Source).FTxLines);
			FTxLines := Copy(TMLnTextCell(Source).FTxLines, 0, Len);    //used to be 1..len
		end;
end;

function TMlnTextCell.CheckWordWrap(testStr: String): LineStarts;
  function SetLine(retInd, fstInd, lstInd: Integer): TextLine;
  begin
    result.retChIdx := retInd;
    result.fstChIdx := fstInd;
    result.lstChIdx := lstInd;
  end;

  function GetLastFitSpace(str: String; lstFitChar: Integer): Integer;
  const
    space = ' ';
  begin
    result := lstFitChar;
    while (str[result] <> space) and (result > 0) do
      dec(result);
    if result = 0 then
      result := lstFitChar; //str does not content space
  end;

  procedure BreakUpByTextWidth(dc: HDC; txt: String; offset: Integer; txtWidth: Integer; flineIndent: Integer; var lines: LineStarts);
  var
    lnTextWidth: Integer;
    lstCharToFit, lstSpaceToFit: Integer;
    txtSize: TSize;
    fullOffset: Integer;
    remStr: String;
  begin
    if length(txt) = 0 then
      exit;
    lines[high(lines)].fstChIdx := offset + 1;
    if high(lines) = 0 then
      lnTextWidth := txtWidth - flineIndent
    else
      lnTextWidth := txtWidth;
    remStr := txt;
    GetTextExtentExPoint(dc,PChar(remStr),length(remStr),lnTextWidth,PInteger(@lstCharToFit),nil,txtSize);
    fullOffset := offset;
    while lstCharToFit < length(remStr) do
      begin
        lstSpaceToFit := GetLastFitSpace(remStr,lstCharToFit);
        lines[high(lines)].lstChIdx := lstSpaceToFit + fullOffset;
        setlength(lines,length(lines) + 1);
        lines[high(lines)] := SetLine(0,lstSpaceToFit + fullOffset + 1,0);
        inc(fullOffset,lstSpaceToFit);
        remStr := Copy(remStr,lstSpaceToFit + 1,length(remStr));
        GetTextExtentExPoint(dc,PChar(remStr),length(remStr),txtWidth,PInteger(@lstCharToFit),nil,txtSize);
      end;
    lines[high(lines)].lstChIdx := lstCharToFit + fullOffSet;  //the remainder of text fit to text width
  end;

const
  delim = #$0d;
var
  memDC: HDC;
  font: TFont;
  docView: TDocView;
  indent, regTextWidth: Integer; //pixels
  CRPos: Integer;
  curStr, remStr: String;
  strOffset: Integer;
begin
  setLength(result,0);
  if length(testStr) = 0 then
    exit;
  docView := TDocView(ParentViewPage.Owner);
  memDC := CreateCompatibleDC(docView.Canvas.Handle);
  font := TFont.Create;
  if memDC = 0 then  //something wrong
    exit;
  try
    font.Assign(CellContainer(self).docFont);
    font.Height := -MulDiv(FTxSize, docView.PixScale, cNormScale);
    font.Style := FTxStyle;
    SelectObject(memDC,font.Handle);
    regTextWidth := MulDiv(FFrame.right - FFrame.Left, docView.PixScale, cNormScale);
    indent := MulDiv(FTxIndent,  docView.PixScale, cNormScale);
    font.Name := FFontName;

    remStr := testStr;
    strOffset := 0;
    setlength(result,1); // test string is not empty, there is at least 1 line
    result[high(result)] := SetLine(0,0,0);
    CRPos := Pos(delim,remStr);
    while CRPos > 0 do
      begin
        curStr := Copy(remStr,1,CRPos - 1);
        BreakUpByTextWidth(memDC,curStr,strOffset,regTextWidth,indent,result);
        setlength(result,length(result) + 1);
        result[high(result)] := SetLine(strOffset + CRPos,0,0);
        remStr := Copy(remStr,CRPos + 1,length(remStr));
        inc(strOffSet,CRPos);
        CRPos := Pos(delim,remStr);
      end;
    if (length(remStr) > 0) and (regTextWidth > 0) then    //last line wo CR
      BreakUpByTextWidth(memDC,remStr,strOffset,regTextWidth,indent,result);
  finally
    DeleteDC(memDC);
    font.Free;
  end;
end;

procedure TMLnTextCell.CheckTextOverflow;
var
  MLEditor: TMLEditor;
begin
  MLEditor := nil;
  if (Length(Text)> 0) and (Editor = nil) then
    try
      MLEditor := TMLEditor.create(CellContainer(self));
      MLEditor.LoadCell(self, nullUID);
      MLEditor.CalcTextWrap;
      MLEditor.Modified := True;
      MLEditor.SaveChanges;
    finally
      MLEditor.Free;
    end;

  FCellStatus := SetBit2Flag(FCellStatus, bOverflow, (FMaxLines < Length(FTxLines)));
end;

procedure TMLnTextCell.DoSetText(const Str: String);
begin
  inherited;
  FTxLines := CheckWordWrap(Str);
end;

procedure TMLnTextCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	numLns, i, L, T: Integer;
	R, zR: TRect;
  FormatFlags: Integer;
begin
	if not FIsActive or isPrinting then   // or IntersectRect(IR, FFrame, Canvas.ClipRect) then
		begin
			with FFrame do
				begin
          Canvas.Font.Assign(CellContainer(Self).docFont);
					Canvas.Font.Color := CellContainer(Self).GetDataFontColor(isPrinting);
          if not isPrinting and IsBitSet(FCellStatus, bOverflow) then
            Canvas.Font.Color := colorOverflowTx;
					Canvas.Font.Height := -MulDiv(FTxSize, xDC, xDoc);
					Canvas.Font.Style := FTxStyle;
				  FormatFlags := DT_BOTTOM + DT_SINGLELINE+DT_LEFT + DT_NOPREFIX {+ DT_NOCLIP};
					numLns := Length(FTxLines);                 //how many lines of text are there

					Canvas.Brush.color := BackGround;
					if isPrinting then
						Canvas.Brush.Style := bsClear;            //no background is printing

					L := Left + FTxIndent;
					T := Top;
					R := Rect(L, T, Right, T + kLnHeight - 1);         //first line
					for i := 0 to FMaxLines-1 do
						begin
							zR := scaleRect(R, xDoc, xDC);
							if not isPrinting then
								Canvas.FillRect(zR);                    //need to erase

							Inc(R.Left);														 	//text is inset 1 pix by editor
							zR := scaleRect(R, xDoc, xDC);

							if i < numLns then                        //but maybe not draw
								with FTxLines[i] do
									if fstChIdx > 0 then                  //check for empty lines
                    if isPrinting then
                      AdjustDrawString(canvas.Handle,zR,StrPtrOffset(FText, fstChIdx-1), lstChIdx-fstChIdx+1, 0)
                    else
										  DrawText(canvas.handle, StrPtrOffset(FText, fstChIdx-1), lstChIdx-fstChIdx+1, zR, FormatFlags);
							R.Left := Left;                 					//incase we indented
							R.top := R.top+kLnHeight;                 //offset the line
							R.bottom := R.bottom+kLnHeight;
						end;
				end;
		end;
end;

procedure TMLnTextCell.FillCell(Canvas: TCanvas; fillColor: TColor);
var
	nLns, y, j: Integer;
	tmpR: TRect;
begin
	with FFrame do
		begin
			Canvas.Brush.Color := fillColor;

			nLns := (Bottom - Top) div kLnHeight +1;             //FMaxLines
			y := top;
			SetRect(tmpR, Left + FTxIndent, top, right, y + kLnHeight-1);
			Canvas.FillRect(tmpR);
			y := y + 12;
			for j := 2 to nLns do
			begin
				SetRect(tmpR, Left, y, right, y + kLnHeight-1);
				Canvas.FillRect(tmpR);
				y := y + 12;
			end;
		end;
end;

procedure TMLnTextCell.LoadContent(const Str: String; processIt: Boolean);
var
  MLEditor: TMLEditor;
begin
  inherited LoadContent(Str, processIt);

  If not FIsActive or (FEditor = nil) then
  begin
    MLEditor := TMLEditor.create(CellContainer(self));
    try  //need to get line starts for text wrap
  //    ClearLF(FText);                     //strip any LF chars before editing
  //    ClearNULLs(FText);
      MLEditor.LoadCell(Self, NullUID);     //does calcWrap
      MLEditor.CalcTextWrap;
      MLEditor.Modified := True;
      MLEditor.SaveChanges;									//save the text to the cell
    finally
      MLEditor.Free;
    end;
  end;
end;

procedure TMLnTextCell.SetText(const Str: String);
var
  OriginalText: String;
begin
  OriginalText := FText;

  If FIsActive and (FEditor <> nil) and (FEditor is TTextEditor) then
    (FEditor as TTextEditor).Text := Str
  else
    DoSetText(Str);

  Modified := Modified or (FText <> OriginalText);        //tell everyone we have changed
end;

(*
  //update the editor if its active
  If FIsActive and (FEditor <> nil) then
    TEditor(FEditor).UpdateText(Str, False);

  DoSetText(str);          //now set the text
  Modified := True;        //tell everyone we have changed

*)
procedure TMLnTextCell.SetCellSampleEntry;
begin
  LoadContent('Comment', False);
end;

procedure TMLnTextCell.EraseCell;
begin
  Clear;
  Display;
end;

procedure TMLnTextCell.Clear;
begin
  if FIsActive and (FEditor <> nil) and (FEditor is TTextEditor) then
    (FEditor as TTextEditor).Text := ''
  else begin
    SetLength(FTxLines, 1);							//allocate 1 line, zero'ed for now (creates new array!)
    FTxLines[0].fstChIdx := 0;          //first char index = 1, 0 = no chars yet
    FTxLines[0].lstChIdx := 0;
    SetText('');                        //erase the text
  end;
end;

procedure TMLnTextCell.DisplayCellID(ASequenceID: Integer);
begin
  LoadContent(IntToStr(FCellID), False);
end;

procedure TMLnTextCell.DisplayCellXID;
begin
  LoadContent(IntToStr(FCellXID), False);
end;

procedure TMLnTextCell.DisplayCellMathID(ASequenceID: Integer);
begin
  LoadContent(IntToStr(FMathID), False);
end;

procedure TMLnTextCell.DisplayCellRspIDs;
begin
  if FResponseID <> 0 then
    LoadContent(IntToStr(FResponseID), False);
end;

procedure TMLnTextCell.SetCellNumber(ID: Integer);
begin
  LoadContent(IntToStr(ID), False);
end;

function TMLnTextCell.InView(View: TRect; Var Pt: TPoint): Boolean;
var
  cellR, unionR: TRect;
begin
  cellR.TopLeft := Area2Doc(FTxRect.TopLeft);
  cellR.BottomRight := Area2Doc(FTxRect.BottomRight);
  result := IntersectRect(unionR, View, CellR);

  //cell is not in view so find pt to bring into view
  if not result then
    begin
	    Pt := Point(FTxRect.Left + FTxIndent, FTxRect.Top + kLnHeight);
	    Pt := Area2Doc(pt);                          //normalize
	    result := PtInRect(View, Pt);                //is it visible
   end;
//  result := true;  //#### testing only
end;

procedure TMLnTextCell.WriteCellData(stream: TStream);
var
	amt, siz: LongInt;
	TxLns: LineStarts;
begin
	inherited WriteCellData(stream);  //write text and stuff

	amt := SizeOf(LongInt);
	siz := Length(FTxLines) * SizeOf(TextLine);
	stream.WriteBuffer(siz, amt);		 //write the size of the lineStart array

	TxLns := FTxLines;
	stream.WriteBuffer(Pointer(TxLns)^, siz);    	//write the line starts
end;

procedure TMLnTextCell.ReadCellData(stream: TStream; Version: Integer);
var
	amt, Siz, Len: LongInt;
	TxLns: LineStarts;
begin
	inherited ReadCellData(stream, Version);   //read text and stuff

	amt := SizeOf(LongInt);
	stream.Read(siz, amt);					//read the size value of following data

	Len := Siz div SizeOf(textline);
	SetLength(TxLns, Len);
	stream.ReadBuffer(Pointer(TxLns)^, Siz);    //read the line starts

  if Length(TxLns) > 0 then      //FTxLines is initied to 1 rec, in early files, this was 0
	FTxLines := CheckWordWrap(FText);  //so when reading old files, make sure we don't replace with 0
end;

//YF 03.25.03 Used when we replace the text cell in the new revision
procedure TMLnTextCell.ReadTextCellData(stream: TStream);
begin
  inherited ReadCellData(stream, 1);   //read text and stuff
end;

procedure TMLnTextCell.PostProcess;
begin
  CellContainer(Self).StartProcessLists;
  try
	ReplicateLocal(True);       //handle context replication first
    ReplicateGlobal;            //publish outside the form
  except
    on E:Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
  CellContainer(Self).ClearProcessLists;
end;

{********************************************}
{																						 }
{ 						TGraphicCell									 }
{																						 }
{********************************************}

function TGraphicCell.GetEditorClass: TCellEditorClass;
begin
  Result := TGraphicEditor;
end;

constructor TGraphicCell.Create(AParent: TAppraisalPage; AViewParent: TObject; cellDef: TObject);
begin
  // always init members _prior_ to calling inherited
  FImage := TCFImage.Create;        //ClickFORM image object
  FImage.ViewPort := Bounds;        //this is where image is drawn
	FPicScale := 100;
  FPicDest := Bounds;
  FLabels := nil;                   //no image labels yet
  FMetaData := nil;                 //no cell metadata yet
	inherited Create(AParent, AViewParent, cellDef);
end;

destructor TGraphicCell.Destroy;
begin
  // always release resources _after_ calling inherited
	inherited Destroy;
  FreeAndNil(FImage);
  FreeAndNil(Flabels);
  FreeAndNil(FMetaData);
end;

procedure TGraphicCell.Assign(source: TBaseCell);
begin
	inherited Assign(source);

  AssignImage(TGraphicCell(source).FImage);
  AssignLabels(TGraphicCell(Source).FLabels);
  AssignMetadata(TGraphicCell(Source).FMetaData);

//  FImage.Assign(TGraphicCell(source).FImage);
//  FImage.ViewPort := FFrame;

  FPicScale := TGraphicCell(source).FPicScale;
//      FPicDest := TGraphicCell(source).FPicDest;     //should not come from source

  FWhiteCell := TGraphicCell(source).FWhiteCell;     //set the flags
  FEmptyCell := TGraphicCell(source).FEmptyCell;

  Modified := true;
end;

//used for transfering photos by grid manager
procedure TGraphicCell.AssignImage(Source: TCFImage);
begin
  if assigned(Source) then
    begin
      FImage.Assign(Source);
      FImage.ViewPort := FFrame;

      Modified := True;
    end;
end;

procedure TGraphicCell.AssignLabels(Source: TMarkupList);
var
  viewParent: TObject;
begin
  if assigned(Source) then
    begin
      if assigned(FLabels) then
        FLabels.Free;

      viewParent := CellPage(Self).PgDisplay.PgBody;
      FLabels := TMapLabelList.CreateList(viewParent, FFrame);
      FLabels.Assign(Source);

      Modified := True;
    end;
end;

procedure TGraphicCell.AssignMetaData(Source: TMetaData);
begin
  if assigned(Source) then
    begin
      if assigned(FMetaData) then
        FMetaData.Free;
      FMetaData := Source.CreateClone;

      Modified := True;
    end;
end;

procedure TGraphicCell.ClearAnnotation;
begin
  if assigned(FLabels) then
    begin
      FreeAndNil(FLabels);
      Modified := True;
    end;
end;

function TGraphicCell.AddAnnotation(AType: Integer; X,Y: Integer; AName: String; AColor: TColor; AAngle, ARefID, ACatID: Integer): TPageItem;
var
  R: TRect;
  viewParent: TObject;
begin
  viewParent := CellPage(Self).PgDisplay.PgBody;

  if not assigned(FLabels) then
    FLabels := TMapLabelList.CreateList(viewParent, FFrame);   {Self.Bounds}

  Result := TMapLabelList(FLabels).CreateNewMapLabel(AType, Point(X,Y), AName, AColor, AAngle, ARefID, ACatID);

  //makes sure it has been created inbounds
  if assigned(Result) then
    begin
      R := Result.Bounds;
      EnsureRectAInB(R, Bounds);
      Result.Bounds := R;
    end;

  Modified := true;
end;

procedure TGraphicCell.Clear;
begin
  inherited;

  FImage.Clear;
  FWhiteCell := False;     //set the flags
  FEmptyCell := True;

  Modified := true;
end;

procedure TGraphicCell.DisplayCellID(ASequenceID: Integer = -1);
begin
  FImage.Clear;
  FWhiteCell := True;     //set the flags
  FEmptyCell := True;
//  Background := CellContainer(Self).docColors[cEmptyCellColor];
//  SetText(IntToStr(FCellID));
end;

procedure TGraphicCell.DisplayCellXID;
begin
  //same issue as DisplayCellID
end;

//this is the path to a photo to load; in future it could be graphic caption
//we need a DoSetGraphic (like DoSetText) so we don't switch current cells on user
//This so we can easily import images by reading path in import file
procedure TGraphicCell.SetText(const Str: String);
begin
  if FileExists(Str) then
    begin
      If FIsActive and (FEditor <> nil) then
        TGraphicEditor(FEditor).LoadImageFile(Str)
      else
        begin
          CellContainer(Self).Switch2NewCell(self, true);      //make the cell active
          TGraphicEditor(FEditor).LoadImageFile(Str);
          Modified := True;
        end;
    end
    else
      FText := Str;
end;

function TGraphicCell.HasData: Boolean;
begin
  result := FImage.HasGraphic;
end;

function TGraphicCell.HasImage: Boolean;
begin
  result := FImage.HasGraphic;
end;

procedure TGraphicCell.SaveToFile(const fileName: String);
begin
  FImage.SaveToFileWithDefaultExt(fileName);
end;

procedure TGraphicCell.LoadFromFile(const fileName: String);
begin
  if FileExists(fileName) then
    try
      If FIsActive and (FEditor <> nil) then
        TGraphicEditor(FEditor).LoadImageFile(fileName)
      else
        begin
          FImage.LoadImageFromFile(fileName);
          Display;
        end;
    except
      ShowNotice('There is a problem loading image "' + fileName + '"');
    end;
end;

//### I don't think this is used anymore
function TGraphicCell.GetEditorViewPort: TRect;
begin
	result := FFrame;           //image is displayed in the full frame (came from cell)
end;

function TGraphicCell.HasMetaData(metaType: Integer): Boolean;
begin
  result:= False;

  if assigned(FMetaData) then
    result := (FMetaData.FUID = metaType);
end;

function TGraphicCell.GetMetaData: integer;
begin
  result:= -1;
  if assigned(FMetaData) then
    result := FMetaData.FUID;
end;


procedure TGraphicCell.FocusOnCell;
var
  Pt: TPoint;
begin
	with ParentViewPage do
		begin
			//now set view origin at cell's page
			Pt.x := PgOrg.x + cMarginWidth;
			Pt.y := PgOrg.y + cTitleHeight;
			CellContainer(Self).docView.SetViewOrg(Pt);
//			SetClip(Canvas.Handle, Cell2View);      //Keep the system CLIP
		end;
end;

procedure TGraphicCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	box: TRect;
begin
	if FEmptyCell then
		if not isPrinting then
			begin
				Box := ScaleRect(FFrame, xDoc, xDC);
				Canvas.Brush.Color := Background;
				Canvas.FillRect(Box);
			end
		else
	else  //not empty
    FImage.DrawZoom(canvas, xDoc, xDC, isPrinting);

  if assigned(FLabels) then
    FLabels.DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

procedure TGraphicCell.DragDropImage(Sender, Source: TObject; X,Y: Integer);
begin
  if source is TDragImage then
    with Source as TDragImage do
      begin
        if not FIsActive then
          CellContainer(Self).Switch2NewCell(self, true);      //make the cell active

        if assigned(ImageCell) then
          Self.Assign(ImageCell)                  //assign the source to editor
        else if FileExists(ImageFilePath) then
          begin
            //if appPref_ImageAutoOptimization then
              //TGraphicEditor(FEditor).FOptimized := False;

            TGraphicEditor(FEditor).LoadImageFile(ImageFilePath);
          end;
      end;
end;

procedure TGraphicCell.DragDropLabel(Sender, Source: TObject; X,Y: Integer);
var
  pt: TPoint;
begin
  if source is TDragLabel then
    with source as TDragLabel do
      begin
        pt := ScalePt(Point(X,Y), DocScale, cNormScale);  //reverse scale the point to position properly
        AddAnnotation(FLabelType, pt.X,pt.Y, FLabelText, FLabelColor, FLabelAngle,FLabelID,FLabelCatID);

        //if map geoCode then...
        
        if not FIsActive then
          CellContainer(Self).Switch2NewCell(self, true);  //make the cell active & Display

        Display;  
      end;
end;

procedure TGraphicCell.DragDrop(Sender, Source: TObject; X,Y: Integer);
begin
	if source is TDragImage then
    DragDropImage(Sender, Source, X,Y)

  else if source is TDragLabel then
    DragDropLabel(Sender, Source, X,Y)

  else
    inherited;
end;

procedure TGraphicCell.DragOver(Sender, Source: TObject; X,Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if source is TDragImage then
    accept := True
  else if source is TDragLabel then
    accept := True
  else
    inherited;
end;

procedure TGraphicCell.LoadOldSketchData(Value: HENHMETAFILE);
begin
  try
    if FImage.LoadWindowsMetaFile(Value) then
      begin
        //frorce these settings
        FCellPref := SetBit(FCellPref, bImgFit);
        FCellPref := ClrBit(FCellPref, bImgCntr);
        FCellPref := ClrBit(FCellPref, bImgKpAsp);
        //github 71
        FCellPref := ClrBit(FCellPref, bImgOptimized);  //clear optimize setting to 0

        {FImage.CalcDisplay(bFit, bCntr, bRatio, FPicScale);}
        FImage.CalcDisplay(True, False, False, FPicScale);  //was false,false,true

        FEmptyCell := False;
        FWhiteCell := True;
        FManualEntry := False;

        Modified := True;             //tell everyone we have changed
      end;
  finally
  end;
end;

//reads image block from a stream; implemented for reading old report images
procedure TGraphicCell.LoadStreamData(Stream: TStream; Amt: LongInt; processIt: Boolean);
var
  bFit,bCntr,bRatio: Boolean;
begin
  if FImage.LoadImageFromStream(Stream, Amt) then
    begin
      bFit := IsBitSet(FCellPref, bImgFit);
      bCntr := IsBitSet(FCellPref, bImgCntr);
      bRatio := IsBitSet(FCellPref, bImgKpAsp);
      FImage.CalcDisplay(bFit, bCntr, bRatio, FPicScale);

      FEmptyCell := False;
		  FWhiteCell := True;
		  FManualEntry := False;

      Modified := True;             //tell everyone we have changed
    end;
end;

//streams out to report file
procedure TGraphicCell.WriteCellData(stream: TStream);
var
	amt, hasGraphic: Integer;
begin
  //before TBasicCell will write prefences in cell set Optimization cell flag
  FCellPref := SetBit2Flag(FCellPref,bImgOptimized,FImage.FImgOptimized);
  //FCellPref := SetBit2Flag(FCellPref,bImgModified,FImage.FImgModified);
  inherited;

	amt := SizeOf(Integer);
	stream.WriteBuffer(FPicScale, amt);		 			    //write the image scale factor

	amt := SizeOf(TRect);
	stream.WriteBuffer(FPicDest, amt);		 			    //write the image loc rect

  amt := SizeOf(Integer);
  hasGraphic := Integer(FImage.hasGraphic);
  stream.WriteBuffer(hasGraphic, amt);		 		    //write whether we have an image

  if HasGraphic > 0 then
    FImage.SaveToStream(stream);

  //Report Version 2 section - addition of cell annotations & sketch data
  //Cell Annotations - map arrows
  if assigned(FLabels) and (FLabels.Count > 0) then
    begin
      WriteLongToStream(FLabels.Count, Stream);   //write the number of labels attached to this cell
      FLabels.WriteToStream(Stream);              //write each label to the stream
    end
  else
    WriteLongToStream(0, Stream);                 //write zero Labels attached to this cell

  //Cell MetaData associated with image - GeoBounds, Sketch data, etc
  if assigned(FMetaData) then
    begin
      WriteLongToStream(1, Stream);               //write 1 data object attached to this cell
      WriteLongToStream(FMetaData.UID, Stream);   //write MetaData unique identifier
      FMetaData.WriteToStream(Stream);
    end
  else
    WriteLongToStream(0, Stream);                 //write zero data attached to this cell
end;

procedure TGraphicCell.ReadCellDataV1(Stream: TStream; Version: Integer);
var
	amt, hasGraphic: Integer;
  Ok,bFit,bCntr,bRatio: Boolean;
begin
	amt := SizeOf(Integer);
	stream.Read(FPicScale, amt);		 		//read the image scale factor

	amt := SizeOf(TRect);
	stream.Read(FPicDest, amt);		 		  //read the image loc rect

	amt := SizeOf(Integer);
	stream.Read(hasGraphic, amt);		 		//read if we wrote an image out

  Ok := False;
  if hasGraphic = 1 then              //if so, read the image
    Ok := FImage.LoadFromStream(stream);
  FImage.FImgOptimized := IsBitSet(FCellPref,bImgOptimized);
  //FImage.FImgModified := IsBitSet(FCellPref,bImgModified);
  if OK then begin                    //calc the display
	  bFit := IsBitSet(FCellPref, bImgFit);
	  bCntr := IsBitSet(FCellPref, bImgCntr);
	  bRatio := IsBitSet(FCellPref, bImgKpAsp);
    FImage.CalcDisplay(bFit, bCntr, bRatio, FPicScale);

  end;

  if (not OK) or (FImage.FImgTyp = cfi_UNDEF) then
    begin
      FEmptyCell := True;
		  FWhiteCell := False;
		  FManualEntry := False;
    end;
end;

procedure TGraphicCell.ReadCellDataV2(Stream: TStream; Version: Integer);
var
  LabelCount, DataCount: Integer;
begin
  ReadCellDataV1(Stream, Version);            //read version 1 graphic cell data

  //read the cell annotations
  LabelCount := ReadLongFromStream(Stream);   //read the Label count
  if LabelCount > 0 then
    begin
      FLabels := TMarkUpList.CreateList(CellPage(Self).PgDisplay.PgBody, FFrame);
      FLabels.ReadFromStream(Stream);
    end;

  //read the cell Meta Data
  DataCount := ReadLongFromStream(Stream);   //read the Data count
  if DataCount > 0 then
    begin
      FMetaData := CreateMetaData(Stream);   //read metaData UID and create TMetaData to read contents
      If assigned(FMetaData) then
        FMetaData.ReadFromStream(Stream);    //now read the data
    end;
end;

procedure TGraphicCell.ReadCellData(stream: TStream; Version: Integer);
begin
	inherited;

  case Version of
    1: ReadCellDataV1(Stream, Version);
    2: ReadCellDataV2(Stream, Version);
  end;
end;

function TGraphicCell.OptimizeCellImage(optDPI: integer; var origSize: Integer; var optSize: Integer): Boolean;
var
  imgType: string;
  optStream: TMemoryStream;
begin
  result := false;
  if CellImageCanOptimized(self, optDPI) then
    with FImage do
    begin
      imgType := FImgTyp;
      origSize := ImageSize;
      optStream := TImageStream.Create;
      try
        if FImage.OptimizeImage(optDPI, optStream, imgType) then
        begin
          FImage.Clear;
          optStream.Seek(0, soFromBeginning);
          FImage.LoadImageFromStream(optStream,optStream.size);
          FImage.FImgTyp := imgType;  //can be changed while creating optimized stream
          Modified := True;
          FImage.FImgOptimized := true;
          optSize := ImageSize;
          result := true;
        end;
      finally
        if assigned(optStream) then
          optStream.Free;
      end;
    end;
end;

/// summary: Calculates the size of an image for a TGraphicCell with the specified frame.
class function TGraphicCell.CalculateImageSizeFromCellFrame(const Frame: TRect): TSize;
var
  ImageSize: TSize;
  ImageRect: TRect;
begin
  // this formula is used to get the image dimensions.
  ImageRect := Frame;                                                   // cell frame @ 72 dpi
  InflateRect(ImageRect, -3, -3);                                       // 3 pixel inset @ 72 dpi
  ImageRect := ScaleRect(ImageRect, cNormScale, Screen.PixelsPerInch);  // scale to 96 dpi
  InflateRect(ImageRect, -1, -1);                                       // 1 pixel inset @ 96 dpi
  ImageSize.cx := ImageRect.Right - ImageRect.Left;                     // width @ 96 dpi
  ImageSize.cy := ImageRect.Bottom - ImageRect.Top;                     // height @ 96 dpi
  Result := ImageSize;
end;

{ TPhotoCell }

constructor TPhotoCell.Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject);
var
  R: TRect;
begin
  inherited Create(AParent, AViewParent, CellDef);

	R := FFrame;           			//image is displayed in the full frame (came from cell)
	InflateRect(R, -4, -4);     //editor will scale
  FImage.viewPort := R;
end;

procedure TPhotoCell.Assign(source: TBaseCell);
begin
  inherited;

  FImage.viewPort := GetEditorViewPort;    //make sure image is in a frame
end;

procedure TPhotoCell.AssignImage(Source: TCFImage);
begin
  inherited;

  if assigned(Source) then
    begin
      FImage.ViewPort := GetEditorViewPort;

      FWhiteCell := False;
      FEmptyCell := True;
      if FImage.HasGraphic then
        begin
          FWhiteCell := True;
          FEmptyCell := False;
        end;

      Modified := true;
    end;
end;

function TPhotoCell.GetEditorViewPort: TRect;
begin
	result := FFrame;           			//image is displayed in the full frame (came from cell)
	InflateRect(result, -4, -4);      //editor will scale
end;

procedure TPhotoCell.DrawPicFrame(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var Box: TRect;
begin
	with Canvas do
	begin
		Box := ScaleRect(FFrame, xDoc, xDC);
		if IsBitSet(FCellPref, bCelPrFrame) then begin
			Pen.Color := clBlack;
			if isPrinting then
				Pen.Width := MulDiv(MulDiv(2, xDC, xDoc),2,3)   //make it 2/3 as wide
			else
				Pen.Width := MulDiv(2, xDC, xDoc);
			MoveTo(box.Left, box.top);
			LineTo(box.right, box.top);
			LineTo(box.right, box.bottom);
			LineTo(box.left, box.bottom);
			LineTo(box.left, box.top);
		end;
		Box := FFrame;
		InflateRect(Box, -3, -3);
		Box := ScaleRect(Box, xDoc, xDC);
		Brush.Color := clBlack;
		FrameRect(Box);               //always one pix wide
	end;
end;

procedure TPhotoCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	scaledPicDest, scaledPicView: TRect;
begin
	if IsBitSet(FCellPref, bCelPrFrame) then
    DrawPicFrame(canvas, xDoc, xDC, isPrinting);

	scaledPicDest := ScaleRect(FPicDest, xDoc, xDC);
  scaledPicView := FFrame;
	InflateRect(scaledPicView, -3, -3);
	scaledPicView := ScaleRect(scaledPicView, xDoc, xDC);
	InflateRect(scaledPicView, -1, -1);          //one pix inside scaled rect

  if isPrinting and not FEmptyCell then        //always print current contents
    begin
      FImage.DrawZoom(Canvas, xDoc, xDC, isPrinting);
    end

  else if not isPrinting and not FIsActive then   //if FIsActive then editor draws photo
    begin
      if FEmptyCell then     //just paint blue background
        begin
          Canvas.Brush.Color := Background;
          Canvas.FillRect(scaledPicView);
        end
      else begin            //check if pic covers entire frame
        if not RectACoversB(scaledPicDest, scaledPicView) then
          begin
            Canvas.Brush.Color := Background;
            Canvas.FillRect(scaledPicView);
          end;
        FImage.DrawZoom(Canvas, xDoc, xDC, isPrinting);
      end;
    end;
        
  if assigned(FLabels) then
    begin
      FLabels.DrawZoom(Canvas, xDoc, xDC, isPrinting);
    end;

  //else editor displays when FIsActive
  //and if isEmpty don't print blue background
end;

(*
function TPhotoCell.GetEditor: TObject;
var
	doc: TContainer;
begin
	doc := CellContainer(Self);
	result := TPhotoEditor.Create(doc);
end;
*)
{ TPgNumCell }

constructor TPgNumCell.Create(AParent: TAppraisalPage; AViewParent, CellDef: TObject);
begin
  inherited;
  //due to bug in designer force this here
  FCellXID := CELL_PGNUM_XID;
  FCellPref := SetBit(FCellPref, bCelDispOnly);
  FCellPref := SetBit(FCellPref, bCelSkip);
end;

procedure TPgNumCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  FText := '';
  if CellContainer(self).DisplayPgNums and CellPage(self).CountThisPage then
	  FText := IntToStr(TDocPage(FParentPage).GetPageNumber);
	FWhiteCell := True;
	FEmptyCell := False;
	inherited DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

{ TPgTotalCell }

constructor TPgTotalCell.Create(AParent: TAppraisalPage; AViewParent, CellDef: TObject);
begin
  inherited;

  //due to bug in designer force this here
  FCellXID := CELL_PGTOTAL_XID;
  FCellPref := SetBit(FCellPref, bCelDispOnly);
  FCellPref := SetBit(FCellPref, bCelSkip);
end;

procedure TPgTotalCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
begin
  FText := '';
  if  CellContainer(self).DisplayPgNums and CellPage(self).CountThisPage then
	  FText := IntToStr(TDocPage(FParentPage).GetTotalPgCount);
	FWhiteCell := True;
	FEmptyCell := False;
	inherited DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

{ TTCDescCell }

procedure TTCDescCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	doc: TContainer;
  IdxOffset: LongInt;
begin
	doc := CellContainer(Self);
  IdxOffset := CellPage(Self).PgTableContentsOffset;
	FText := doc.GetTableContentsDesc(FResponseID + IdxOffset);

	FWhiteCell := True;
	FEmptyCell := False;

	inherited DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

{ TTCPageCell }

procedure TTCPageCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
	doc: TContainer;
  IdxOffset: LongInt;
begin
	doc := CellContainer(Self);
  IdxOffset := CellPage(Self).PgTableContentsOffset;
	FText := doc.GetTableContentsPage(FResponseID + IdxOffset);

	FWhiteCell := True;
	FEmptyCell := False;

	inherited DrawZoom(canvas, xDoc, xDC, isPrinting);
end;

{ TDateCell }

procedure TDateCell.SetCellSampleEntry;
begin
	if IsBitSet(FCellFormat, bDateMY) then
		FText := '12/00'

	else if IsBitSet(FCellFormat, bDateMDY) then
		FText := '12/12/00'

	else if IsBitSet(FCellFormat, bDateMD4Y) then
		FText := '12/12/2000'

	else if IsBitSet(FCellFormat, bDateShort) then
		FText := 'Dec 12, 2000'
	else if IsBitSet(FCellFormat, bDateLong) then
 		FText := 'December 12, 2000';

	FEmptyCell := False;
end;

procedure TDateCell.SetText(const Str: String);
var
	newDateStr: String;
	Date: TDateTime;
begin
	if (Length(Str)>0) and IsValidDate(Str, Date) then
		begin
			newDateStr := FormatDate(Date, FCellFormat);  //format to cell specs
			if length(newDateStr) = 0 then
				newDateStr := Str;                //lost date in formatting, use default
			CellValue := date;
			inherited SetText(newDateStr);
			if newDateStr <> Str then           //if its changed,
				Display;                         	//redisplay it
		end
	else
		begin
			CellValue := 0;
			inherited SetText(Str);
		end;
end;

procedure TDateCell.LoadContent(const Str: String; processIt: Boolean);
begin
  inherited SetText(str);   //bypass DateCells's SetText and error checking
  if processIt then PostProcess;
end;

//Editor is only one who calls DoSetDate
procedure TDateCell.DoSetDate(DateVal: TDateTime);
var DateStr: String;
begin
	FValue := DateVal;
	DateStr := FormatDate(DateVal, FCellFormat);
	DoSetText(DateStr);
  Modified := True;
end;

//Math is only one who calls SetDate, need to account for active editor
procedure TDateCell.SetDate(DateVal: TDateTime);
var DateStr: String;
begin
	FValue := DateVal;
	DateStr := FormatDate(DateVal, FCellFormat);
	Inherited SetText(DateStr);   //by pass TDate's SetText
//  Modified := True;
end;


{ TCompanyCell}

function TCompanyCell.GetEditorClass: TCellEditorClass;
begin
  Result := TCompanyNameEdtor;
end;

constructor TCompanyCell.Create(AParent: TAppraisalPage; AViewParent, CellDef: TObject);
begin
  inherited;

  LoadCurrentUserCompanyName;
end;

//Necessary to handle forms created without company lockout
procedure TCompanyCell.ReadCellData(stream: TStream; Version: Integer);
begin
  inherited;

  if CurrentUser.SWLicenseCoNameLocked then
    begin
    FCellPref := SetBit(FCellPref, bCelDispOnly);
    FCellPref := SetBit(FCellPref, bNoChgToCPref);
    FCellPref := SetBit(FCellPref, bNoEditRsps);
    end
  else
    begin
      FCellPref := ClrBit(FCellPref, bCelDispOnly);
      FCellPref := ClrBit(FCellPref, bNoChgToCPref);
      FCellPref := ClrBit(FCellPref, bNoEditRsps);
    end;
end;

procedure TCompanyCell.LoadCurrentUserCompanyName;
begin
  if CurrentUser.SWLicenseCoNameLocked then {or (LicensedUsers.Count > 1)}
    begin
      FCellPref := SetBit(FCellPref, bCelDispOnly);
      FCellPref := SetBit(FCellPref, bNoChgToCPref);
      FCellPref := SetBit(FCellPref, bNoEditRsps);
    end
  else
    begin
      FCellPref := ClrBit(FCellPref, bCelDispOnly);
      FCellPref := ClrBit(FCellPref, bNoChgToCPref);
      FCellPref := ClrBit(FCellPref, bNoEditRsps);
    end;

  DoSetText(CurrentUser.SWLicenseCoName);
  If FIsActive and (FEditor <> nil) and (FEditor is TTextEditor) then
    begin
      (FEditor as TTextEditor).TxStr := CurrentUser.SWLicenseCoName;  // FORCE IT
      (FEditor as TTextEditor).FCellPrefs := FCellPref;   //let editor know we changed
      (FEditor as TTextEditor).DisplayCurCell;
    end;
end;

procedure TCompanyCell.SetCellSampleEntry;
begin
  SetText('Bradford Technologies, Inc.');
end;

{ TLicenseCell }

function TLicenseCell.GetEditorClass: TCellEditorClass;
begin
  Result := TLicenseeEditor;
end;

constructor TLicenseCell.Create(AParent: TAppraisalPage; AViewParent, CellDef: TObject);
begin
  inherited;

  FCellPref := SetBit(FCellPref, bCelDispOnly);
  FCellPref := SetBit(FCellPref, bNoChgToCPref);
  FCellPref := SetBit(FCellPref, bNoEditRsps);
  DoSetText(CurrentUser.SWLicenseName);
end;

procedure TLicenseCell.LoadCurrentUser;
begin
  FCellPref := SetBit(FCellPref, bCelDispOnly);
  FCellPref := SetBit(FCellPref, bNoChgToCPref);
  FCellPref := SetBit(FCellPref, bNoEditRsps);

  DoSetText(CurrentUser.SWLicenseName);
  If FIsActive and (FEditor <> nil) and (FEditor is TTextEditor) then
    begin
    (FEditor as TTextEditor).TxStr := CurrentUser.SWLicenseName;  // FORCE IT
    (FEditor as TTextEditor).DisplayCurCell;
//     AWMemberShipLevel := GetAWSIMemberShipLevel;
    end;
end;

procedure TLicenseCell.ReadCellData(stream: TStream; Version: Integer);
begin
  inherited;

  FCellPref := SetBit(FCellPref, bCelDispOnly);
  FCellPref := SetBit(FCellPref, bNoChgToCPref);
  FCellPref := SetBit(FCellPref, bNoEditRsps);
end;

procedure TLicenseCell.SetCellSampleEntry;
begin
  SetText('Software Evaluator');
end;

{ TSignerCell }

function TSignerCell.GetEditorClass: TCellEditorClass;
begin
  Result := TSignerEditor;
end;

procedure TSignerCell.SetCellSampleEntry;
begin
  SetText('Additional Signer');
end;

{ TSketchCell }

function TSketchCell.GetEditorClass: TCellEditorClass;
begin
  Result := TSketchEditor;
end;

{TAdvertisementCell}

function TAdvertisementCell.GetEditorClass: TCellEditorClass;
begin
  Result := TAdvertisementCellEditor;
end;

{ TMapLocCell }

/// summary: gets the bing map state data.
function TMapLocCell.GetBingMapsData: String;
begin
  Result := TIdDecoderMIME.DecodeString(Properties[CPropertyBingMapsData]);
end;

/// summary: sets the bing map state data.
procedure TMapLocCell.SetBingMapsData(const Value: String);
begin
  Properties[CPropertyBingMapsData] := TIdEncoderMIME.EncodeString(Value);
end;

function TMapLocCell.GetEditorClass: TCellEditorClass;
begin
  Result := TMapLocEditor;
end;

{ TMapPlatCell }

function TMapPlatCell.GetEditorClass: TCellEditorClass;
begin
  Result := TMapPlatEditor;
end;

{ TMapFloodCell }

function TMapFloodCell.GetEditorClass: TCellEditorClass;
begin
  Result := TMapFloodEditor;
end;

{ TDeedPlotCell }

function TDeedPlotCell.GetEditorClass: TCellEditorClass;
begin
  Result := TDeedPlotEditor;
end;

{ TGridCell }

function TGridCell.GetEditorClass: TCellEditorClass;
begin
  if (FEditorClass <> nil) then
    Result := FEditorClass
  else
    Result := TGridCellEditor;
end;

/// summary: Gets the grid coordinates of the cell and returns the page table index.
function TGridCell.GetCoordinates(out Coordinates: TPoint): Integer;
var
  Index: Integer;
  Page: TDocPage;
  Tables: TTableList;
  CUID: CellUID;
begin
  if not (ParentPage is TDocPage) then
    raise EArgumentException.Create('Cell.ParentPage');

  CUID := UID;
  Page := ParentPage as TDocPage;
  Tables := Page.pgDesc.PgCellTables;
  Result := -1;

  for Index := 0 to Tables.Count - 1 do
    begin
      Coordinates := Tables[Index].CoordOf(CUID.Num + 1);
      if not CompareMem(@Coordinates, @NullCoordinates, SizeOf(Coordinates)) then
        begin
          Result := Index;
          Break;
        end;
    end;
end;

procedure TGridCell.ProcessMath;
var
  GridEditor: TGridCellEditor;
begin
  inherited;

  If (FEditor = nil) then
    begin
      GridEditor := TGridCellEditor.create(CellContainer(self));
      try
        GridEditor.LoadCell(self, UID);
        GridEditor.PostProcess;
        GridEditor.ReplicateToPhotos;
      finally
        GridEditor.Free;
      end;
    end;
end;

// *** TGeocodedGridCell *****************************************************

/// summary: Gets the latitude coordinate of the property address.
function TGeocodedGridCell.GetLatitude: Double;
begin
  Result := StrToFloatDef(Properties[CPropertyLatitude], 0);
end;

/// summary: Sets the latitude coordinate of the property address.
procedure TGeocodedGridCell.SetLatitude(const Value: Double);
begin
  if (Value <> Latitude) then
    Properties[CPropertyLatitude] := FloatToStr(Value);
end;

/// summary: Gets the longitude coordinate of the property address.
function TGeocodedGridCell.GetLongitude: Double;
begin
  Result := StrToFloatDef(Properties[CPropertyLongitude], 0);
end;

/// summary: Sets the longitude coordinate of the property address.
procedure TGeocodedGridCell.SetLongitude(const Value: Double);
begin
  if (Value <> Longitude) then
    Properties[CPropertyLongitude] := FloatToStr(Value);
end;

/// summary: Clears the latitude and longitude coordinate values.
procedure TGeocodedGridCell.ClearCoordinates;
begin
  DeleteProperty(CPropertyLatitude);
  DeleteProperty(CPropertyLongitude);
end;

// *** Unit ******************************************************************


initialization

{$IFDEF LOG_CELL_MAPPING}
  CELL_MAPPING_FILE_NAME := SysUtils.IncludeTrailingPathDelimiter(UWinUtils.GetWindowsTempDirectory) +
      CELL_MAPPING_FILE_NAME;
{$ENDIF}



(*
procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);

var
  Found: boolean;
  i,SelSt: Integer;
  TmpStr: string;
begin
  { first, process the keystroke to obtain the current string }
  { This code requires all items in list to be uppercase}
  if Key in ['a'..'z'] then Dec(Key,32); {Force Uppercase only!}
  with (Sender as TComboBox) do
  begin
    SelSt := SelStart;
    if (Key = Chr(vk_Back)) and (SelLength <> 0) then
     TmpStr := Copy(Text,1,SelStart)+Copy(Text,SelLength+SelStart+1,255)

    else if Key = Chr(vk_Back) then {SelLength = 0}
     TmpStr := Copy(Text,1,SelStart-1)+Copy(Text,SelStart+1,255)
    else {Key in ['A'..'Z', etc]}
     TmpStr := Copy(Text,1,SelStart)+Key+Copy(Text,SelLength+SelStart+1,255);
    if TmpStr = '' then Exit;
    { update SelSt to the current insertion point }

    if (Key = Chr(vk_Back)) and (SelSt > 0) then Dec(SelSt)

    else if Key <> Chr(vk_Back) then Inc(SelSt);
    Key := #0; { indicate that key was handled }
    if SelSt = 0 then
    begin
      Text:= '';
      Exit;
    end;

   {Now that TmpStr is the currently typed string, see if we can locate a match }

    Found := False;
    for i := 1 to Items.Count do
      if Copy(Items[i-1],1,Length(TmpStr)) = TmpStr then
      begin
        Text := Items[i-1]; { update to the match that was found }
        ItemIndex := i-1;
        Found := True;
        Break;
      end;
    if Found then { select the untyped end of the string }
    begin
      SelStart := SelSt;
      SelLength := Length(Text)-SelSt;

    end
    else Beep;
  end;
end;
*)

end.
