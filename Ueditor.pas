unit UEditor;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

Uses
  Windows,
  Classes,
  Comctrls,
  Controls,
  Graphics,
  Menus,
  StdCtrls,
  UBase,
  UCell,
  UClasses,
  UFonts,
  UGlobals,
  UGraphics,
  UGridMgr,
  UMapUtils,
  UPgAnnotation,
  UPgView,
  Types,
  UStdRspUtil;

Const
	kLnsPerPage = 84;                // number of lines on a letter page
	kLnHeight = 12;                  //this is height in pixels of a line
	kCaretHeight = 11;

Type
  TEditor = class;
  TBuildPopupMenuEvent = procedure(const Sender: TEditor; const Menu: TPopupMenu) of object;

  // editors that support text editing
  ITextEditor = interface(IInterface)
    ['{9988f991-49ff-49bd-bc39-e288ea6af020}']
    function GetAnsiText: String;
    function GetSelectedText: String;
    function GetText: String;
    procedure SetText(const Value: String);
    procedure InputString(const Text: String);
    function GetCaretPosition: Integer;
    procedure SetCaretPosition(const Value: Integer);
    procedure SelectText(const Start: Integer; const Length: Integer);
    property AnsiText: String read GetAnsiText;
    property SelectedText: String read GetSelectedText;
    property Text: String read GetText write SetText;
    property CaretPosition: Integer read GetCaretPosition write SetCaretPosition;
  end;

  // editors that support text formatting
  ITextFormat = interface(IInterface)
    ['{67bf7cf2-4514-4359-af1a-164ebcb43f38}']
    function CanFormatText: Boolean;
    function GetFont: TCellFont;
    function GetTextJustification: Integer;
    procedure SetTextJustification(const Value: Integer);
    property Font: TCellFont read GetFont;
    property TextJustification: Integer read GetTextJustification write SetTextJustification;
  end;

	TEditor = class(TCellEditor)
  private
    FOnBuildPopupMenu: TBuildPopupMenuEvent;
  private
    procedure ResetCanEdit;
  public
		FActive: Boolean;         //the editor is active
		FCanSelect: Boolean;      //allows mouse to hilight
    FCanEdit: Boolean;        //some cells cannot be edited (company, licensee, etc)
		FModified: Boolean;       //cell has been modified
    FUpperCase: Boolean;      //is all text in upper case
		FLastBlink: DWORD;				//LongInt;
		FFrame: TRect;

		FDoc: TAppraisalReport;   //ref to doc
		FDocView: TObject;				//ref to the docView
		FCanvas: TCanvas;         //ref to the docView's canvas
    TxStr: String;            //chg to FTxStr or FText

		FPage: TObject;           //ref to data page cell is on
		FCell: TBaseCell;         //ref to the cell being edited
    FItem: TMarkupItem;       //ref to the MarkupItem being edited
		FCellUID: CellUID;        //index for tabbing, etc
    FCellPrefs: LongInt;      //cell preferences
    FCellFormat: LongInt;     //cell formats
    FCellStatus: Integer;     //status flags of the cell
		FCellFmtChged: Boolean;   //Cell format has been modified
    FCellRspChged: Boolean;   //Cell responses have been modified

		FCellActive: Boolean;
    FAllowRspsOnly: Boolean;  //Allow only Rsps in the cell - force standardization
		FAutoRspOn: Boolean;
		FRspsVisible: Boolean;
    FMovingRspSelection: Boolean;
		FRsps: TRspHelper;
    FPopupMenu: TPopupMenu;   //each editor can have a popup menu

		constructor Create(AOwner: TAppraisalReport); override;     // Owner is always the Doc
    procedure BeforeDestruction; override;
		destructor Destroy; override;

		procedure IdleEditor; virtual;
		procedure KeyEditor(var Key: Char); virtual;
		procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); virtual;
    procedure DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); virtual;
    procedure RightClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); virtual;
		procedure ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
		procedure ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure BuildPopUpMenu; virtual;
    procedure SetPopupPoint(var Pt: TPoint); virtual;
    procedure AddPopupEditCmds; virtual;
    procedure ShowPopupMenu(Pt: TPoint); virtual;                  
		procedure ActivateEditor; virtual;
		procedure DeactivateEditor; virtual;
		Function GetModifiedState: Boolean; virtual;
    function GetRspChged: Boolean; virtual;
    function KeyForAutoRsponse(var Key: Word; Shift: TShiftState): Boolean; virtual;

		procedure InitCaret(Clicked: Boolean); virtual;
    procedure LoadItem(Item: TMarkupItem); virtual;
		procedure LoadCell(Cell: TBaseCell; cUID:CellUID); virtual;
		procedure LoadCellRsps(Cell: TBaseCell; cUID:CellUID); virtual;
    procedure Reload; override;
		procedure UnLoadCell; virtual;
		procedure UnLoadCellRsps; virtual;
		procedure HilightCell; virtual;
		procedure UnHilightCell; virtual;
		procedure FocusOnCell; virtual;
		procedure FocusOn(View: TRect); virtual;
		procedure FocusOnWindow; virtual;
    function CellInView(View: TRect; vuScale: Integer): Boolean;
		procedure DrawCurCell; virtual;
		procedure DisplayCurCell; virtual;
		procedure ClearUndo; virtual;
		procedure UndoEdit; virtual;
		procedure CutEdit; virtual;
		procedure CopyEdit; virtual;
		procedure PasteEdit; virtual;
		procedure ClearEdit; virtual;
    procedure SelectAll; virtual;
    procedure Update; virtual;    //when the report changes, use this to update the editor
    function TextOverflowed: Boolean; virtual;
		function CanCopy: Boolean; virtual;
		function CanCut: Boolean; virtual;
		function CanPaste: Boolean; virtual;
		function CanClear: Boolean; virtual;
		function CanSelectAll: Boolean; virtual;
    function CanSpellCheck: Boolean; virtual;
		function CanUndo: Boolean; virtual;
		function HasContents: Boolean; virtual;
    function HasSelection: Boolean; virtual;
		procedure SaveChanges; virtual;
    procedure SaveResponses; virtual;
		procedure SaveToRspList(Sender: TObject); virtual;
		procedure ResetScale; virtual;
    function GetValue: Double; virtual;
    function GetTextColor(overflowed: Boolean): TColor; virtual;
		Procedure SetFormat(format: LongInt); virtual;
  	procedure SetPreferences(prefs: Longint); virtual;
		procedure SetAutoRsp(value: Boolean); virtual;
		function GetDocScale: Integer;
		procedure MoveCaret(Shifted: Boolean; Direction: integer); virtual;
		function CanMoveCaret(Direction: integer): Boolean; virtual;
		function CanAcceptChar(Key: Char): Boolean; virtual;            //checks if it can take the char use it to move
		function HasActiveCellOnPage(Page: TObject): Boolean; virtual;

    property CanEdit: Boolean read FCanEdit write FCanEdit;
    property FormatModified: Boolean read FCellFmtChged write FCellFmtChged;
    property ResponsesModified: Boolean read GetRspChged write FCellRspChged;
		property Modified: Boolean read GetModifiedState write FModified;   //cell was modified
		property ActiveCell: TBaseCell read FCell write FCell;
		property Scale: Integer read GetDocScale;
		property AutoRspOn: Boolean read FAutoRspOn write SetAutoRsp;
		property RspsVisible: Boolean read FRspsVisible write FRspsVisible;
    property AllowRspsOnly: Boolean read FAllowRspsOnly write FAllowRspsOnly;
    property OnBuildPopupMenu: TBuildPopupMenuEvent read FOnBuildPopupMenu write FOnBuildPopupMenu;
	end;

  // abstract class
  TTextEditor = class(TEditor, ITextEditor, ITextFormat)
    public
      function CanLinkComments: Boolean; virtual;
      procedure LinkComments; virtual;

    public
      // ITextEditor
      function GetAnsiText: String; virtual; abstract;
      function GetSelectedText: String; virtual; abstract;
      function GetText: String; virtual; abstract;
      procedure SetText(const Value: String); virtual; abstract;
      procedure InputString(const Text: String); virtual; abstract;
      function GetCaretPosition: Integer; virtual; abstract;
      procedure SetCaretPosition(const Value: Integer); virtual; abstract;
      procedure SelectText(const Start: Integer; const Length: Integer); virtual; abstract;

      // ITextFormat
      function CanFormatText: Boolean; virtual; abstract;
      function GetFont: TCellFont; virtual; abstract;
      function GetTextJustification: Integer; virtual; abstract;
      procedure SetTextJustification(const Value: Integer); virtual; abstract;
    public
      property AnsiText: String read GetAnsiText;
      property SelectedText: String read GetSelectedText;
      property Text: String read GetText write SetText;
      property CaretPosition: Integer read GetCaretPosition write SetCaretPosition;
      property Font: TCellFont read GetFont;
      property TextJustification: Integer read GetTextJustification write SetTextJustification;
  end;

{ CheckBox Editor }

	TChkBoxEditor = class(TEditor, ITextFormat)
    private
      FFont: TCellFont;
    private
      procedure OnFontChanged(Sender: TObject);
    public
		UndoText: String;
		TxRect: TRect;
		ChkBoxGroup: TGroupTable;     //this is the group of checkboxes
		ChkBoxGpIndx: TPoint;         //this is the cells index in the group array 		constructor Create(AOwner: TComponent);

  	constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
		procedure IdleEditor; override;
		procedure KeyEditor(var Key: Char); override;
		procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
		procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
		procedure UnloadCell; override;
		procedure DrawCurCell; override;
		procedure SaveChanges; override;
		procedure HilightCell; override;
		procedure UnHilightCell; override;
		procedure ProcessCheckMark;
		procedure DeleteCheckMark;
		procedure DeleteGroupData;
		procedure InsertCheckMark(Key: Char);
    // 052611 JWyatt Add the AllowOverride option to enable/disable use of
    //  Control Key functionality
    //	 Was:	procedure GroupEnforce(Key: Char);
		procedure GroupEnforce(Key: Char; const AllowOverride: Boolean = True);
		procedure GroupRipple(Key: Char);
		procedure SetGroupState;
		function HasMultiRowGroup: Boolean;
		function CanAcceptChar(Key: Char): Boolean; override;
    // 052611 JWyatt Add the AllowOverride option to enable/disable use of
    //  Control Key functionality
    //	 Was:	procedure SetCheckMark(const Checked: Boolean; const EnforceGroup: Boolean = True);
    procedure SetCheckMark(const Checked: Boolean; const EnforceGroup: Boolean = True;
      const AllowOverride: Boolean = True);
    function ToggleX: Char;

    // ITextFormat
    public
      function CanFormatText: Boolean;
      function GetFont: TCellFont;
      function GetTextJustification: Integer;
      procedure SetTextJustification(const Value: Integer);
	end;


{ Single Line Editor }

	TSLEditor = class(TTextEditor)
    protected
      FFont: TCellFont;
      FTxJust: Integer;
    private
      procedure OnFontChanged(Sender: TObject);
      procedure OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    protected
      procedure BuildResponseMenu;
    public
    TxSize: Integer;
		TxStyle: TFontStyles;
		numChs: Integer;
		SelBeg: Integer;
		SelEnd: Integer;
		SelBegPt: TPoint;
		SelEndPt: TPoint;
		FCaretOn: Boolean;
		FLastBlink: LongInt;
    TxValue: Double;
		TxCaret: TPoint;
		TxRect: TRect;
		UndoBeg: Integer;
		UndoEnd: Integer;
		UndoText: String;
		FListRsps: TListBox;
    FFirstRspInsert: Boolean;    //we need to know if this is first insert

		constructor Create(AOwner: TAppraisalReport); override;
		destructor Destroy; override;

		procedure InitCaret(Clicked: Boolean); override;
		procedure LoadCell(Cell: TbaseCell; cUID:CellUID); override;
		procedure LoadCellRsps(Cell: TbaseCell; cUID:CellUID); override;
		procedure UnloadCell; override;
		procedure UnLoadCellRsps; override;
		procedure SelectedMenuRsp(Sender: TObject);
    function KeyForAutoRsponse(var Key: Word; Shift: TShiftState): Boolean; override;
    procedure SetPopupPoint(var Pt: TPoint); override;
    procedure BuildPopupMenu; override;
		procedure ShowListRsps(Pt: TPoint);
    procedure HideListRsps; virtual;
		procedure ListRspsClick(Sender: TObject);
    procedure ListRspsKeyDown(Sender: Tobject;var Key: Word; Shift: TShiftState);
    procedure InsertRspItem(Rsp: String; Index, Mode: Integer); virtual;
    procedure SelectListRspsItem;
    procedure SelectOnlyListRspsItems(Ch: Char);
    procedure AutoSelectRspItem; virtual;
    procedure CycleRspItem;
  	procedure UnHilightCell; override;
		Procedure IdleEditor;  override;
		Procedure KeyEditor(var Key: Char); override;
		Procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
		procedure ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
		procedure ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
		Procedure EraseCaret;
		Procedure BlinkCaret;
		Procedure ShowCaret;
		procedure MoveCaret(shifted: Boolean; Direction: integer); override;
		function CanMoveCaret(Direction: integer): Boolean; override;
    procedure CalcCaretPos; virtual;
		Procedure SetCaret; virtual;
		Procedure SetClickCaret(ClickPt: TPoint); virtual;
		Procedure DrawCurCell; override;
		procedure DisplayCurCell; override;
    function TextOverflowed: Boolean; override;
		Procedure InvertText(S, F: TPoint);
		Procedure ReInvertText; virtual;
		Function Get1LineWidth (NChars: Integer): Integer;
		Function GetClickPosition (Ln, dx: Integer; var Ch: Integer): Integer;  virtual;
		Procedure SaveSelection(Start, count: Integer);
		Procedure SetCurTxParm;
    Procedure SetFormat(format: LongInt); override;
		procedure SetAutoRsp(value: Boolean); override;
		Procedure DeleteLnSel;
		Procedure DeleteLnChar;
		procedure DeleteForwardLnChar; virtual;
    procedure InputChar(Ch: Char); virtual;
		procedure ClearUndo; override;
		Procedure UndoEdit; override;
		procedure CutEdit; override;
		procedure CopyEdit; override;
		procedure PasteEdit; override;
		procedure PasteText (theText: string); virtual;
		procedure ClearEdit; override;
		procedure SelectAll; override;
		function CanCopy: Boolean; override;
		function CanCut: Boolean; override;
		function CanPaste: Boolean; override;
		function CanClear: Boolean; override;
		function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
		function CanUndo: Boolean; override;
		function CanAcceptChar(Key: Char): Boolean; override;
		function HasContents: Boolean; override;
    function HasSelection: Boolean; override;
		procedure SaveChanges; override;
		procedure SaveToRspList(Sender: TObject); override;

    property TxFormat: Longint read FCellFormat write FCellFormat;


    // ITextEditor
    public
      function  GetAnsiText: String; override;
      function  GetSelectedText: String; override;
      function  GetText: String; override;
      procedure SetText(const Value: String); override;
      procedure InputString(const Text: String); override;
      function  GetCaretPosition: Integer; override;
      procedure SetCaretPosition(const Value: Integer); override;
      procedure SelectText(const Start: Integer; const Length: Integer); override;

    // ITextFormat
    public
      function CanFormatText: Boolean; override;
      function GetFont: TCellFont; override;
      function GetTextJustification: Integer; override;
      procedure SetTextJustification(const Value: Integer);  override;
	end;

  /// summary: A single line text editor for entering dates.
  TDateSLEditor = class(TSLEditor)
  protected
    procedure EnforcePreferences; virtual;
  public
    procedure AutoSelectRspItem; override;
    procedure KeyEditor(var Key: Char); override;
    procedure SaveChanges; override;
  end;

  /// summary: A numeric single line text editor.
  /// remarks: For some reason bCelNumOnly is not implemented anywhere.
  ///          This class does the job without observing any cell preference.
  TNumericSLEditor = class(TSLEditor)
  protected
    procedure EnforcePreferences; virtual;
    function FilterText(const Text: String): String; virtual;
    function HasValidNumber: Boolean; virtual;
  public
    procedure AutoSelectRspItem; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    procedure KeyEditor(var Key: Char); override;
    procedure InputChar(Ch: Char); override;
    procedure InputString(const Text: String); override;
    procedure SetText(const Value: String); override;
  end;

  /// summary: A positive numeric single line text editor with no preset decimal places.
  TPositiveNumericSLEditor = class(TNumericSLEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A numeric single line text editor with two decimal places.
  TDollarsNumericSLEditor = class(TNumericSLEditor)
  protected
    procedure EnforcePreferences; override;
    function HasValidNumber: Boolean; override;
  end;

  /// summary: A positive numeric single line text editor with two decimal places.
  TPositiveDollarsNumericSLEditor = class(TDollarsNumericSLEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A whole number single line text editor.
  TWholeNumericSLEditor = class(TNumericSLEditor)
  protected
    procedure EnforcePreferences; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A positive whole number single line text editor.
  TPositiveWholeNumericSLEditor = class(TWholeNumericSLEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A positive whole percentage single line text editor.
  TPositiveWholePercentNumericSLEditor = class(TPositiveWholeNumericSLEditor)
  protected
    function HasValidNumber: Boolean; override;
  end;

  /// summary: A positive whole number single line text editor.
  /// remarks: The maximum value for this editor is 99,999.
  TPositiveWholeTenThousandsNumericSLEditor = class(TPositiveWholeNumericSLEditor)
  protected
    function HasValidNumber: Boolean; override;
  end;

  { TGridCellEditor }

  TGridCellEditor = class(TSLEditor)
    {FGrid: TGridMgr;}
    FGrid: TCompMgr2;
    FGridType: Integer;
    destructor Destroy; override;
    procedure LoadCell(Cell: TbaseCell; cUID:CellUID); override;
    procedure LoadTableGrid(forceIt: Boolean);
    function CanAcceptChar(Key: Char): Boolean; override;
    procedure BuildPopupMenu; override;
    procedure Update; override;
    procedure ReplicateToPhotos;
    procedure PostProcess;
    function AllowPreProcessing: Boolean;
    procedure PreProcess;
    procedure PreProcessMultiply;
    procedure PreProcessAddition;
    procedure PreProcessAssignment(IsUAD: Boolean=False);
    procedure PreProcessAdjustment(IsUAD: Boolean=False); //github 96
    procedure PreProcessUAD;
    procedure KeyEditor(var Key: Char); override;
    procedure SaveChanges; override;
    procedure SwapComparable(Sender: TObject);
    procedure CopyComparableDescrOnly(Sender: TObject);
    procedure CopyComparableWithAdj(Sender: TObject);
    procedure PasteComparable(Sender: TObject);
    procedure ClearComparable(Sender: TObject);
    procedure ClearAdjustments(Sender: TObject);
    procedure PropagateCompField(Sender: Tobject);
    function CanPropogateCompField(var CompNo: integer; var fldValue: String): Boolean;
    procedure SaveCompSubject(Sender: TObject);
    procedure SaveAllComps(Sender: TObject);
    procedure SaveAllListings(Sender: TObject);
    procedure SaveOneComp(Sender: TObject);
    procedure ValidateCompDB(Sender: TObject);
    procedure PreProcessSpecialCell(cell: TBaseCell; Str:String);


  end;

  /// summary: A single line text editor for entering dates.
  TDateGridEditor = class(TGridCellEditor)
  protected
    procedure EnforcePreferences; virtual;
  public
    procedure AutoSelectRspItem; override;
    procedure KeyEditor(var Key: Char); override;
    procedure SaveChanges; override;
  end;

  /// summary: A numeric grid text editor.
  /// remarks: For some reason bCelNumOnly is not implemented anywhere.
  ///          This class does the job without observing any cell preference.
  TNumericGridEditor = class(TGridCellEditor)
  protected
    procedure EnforcePreferences; virtual;
    function FilterText(const Text: String): String; virtual;
    function HasValidNumber: Boolean; virtual;
  public
    procedure AutoSelectRspItem; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    procedure KeyEditor(var Key: Char); override;
    procedure InputChar(Ch: Char); override;
    procedure InputString(const Text: String); override;
    procedure SetText(const Value: String); override;
  end;

  /// summary: A numeric grid text editor with two decimal places.
  TDollarsNumericGridEditor = class(TNumericGridEditor)
  protected
    procedure EnforcePreferences; override;
    function HasValidNumber: Boolean; override;
  end;

  /// summary: A positive numeric grid text editor with two decimal places.
  TPositiveDollarsNumericGridEditor = class(TDollarsNumericGridEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A positive numeric grid text editor with two decimal places and $ prefix.
  TPositiveDollarsFormattedGridEditor = class(TPositiveDollarsNumericGridEditor)
  protected
  public
    function CanAcceptChar(Key: Char): Boolean; override;
    procedure SaveChanges; override;
  end;

  /// summary: A whole number grid text editor.
  TWholeNumericGridEditor = class(TNumericGridEditor)
  protected
    procedure EnforcePreferences; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A positive whole number grid text editor.
  TPositiveWholeNumericGridEditor = class(TWholeNumericGridEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  /// summary: A positive whole number grid text editor.
  /// remarks: The maximum value for this editor is 99,999.
  TPositiveWholeTenThousandsNumericGridEditor = class(TPositiveWholeNumericGridEditor)
  protected
    function HasValidNumber: Boolean; override;
  public
    function CanAcceptChar(Key: Char): Boolean; override;
  end;

  { Multi-Line Editor }

	TMLEditor = class(TSLEditor)
    private
      procedure OnFontChanged(Sender: TObject);
      procedure OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    public
		NumLns: Integer;
		MaxLns: Integer;
		CurLn: Integer;
		TxLine: LineStarts;
		TxIndent: Integer;
		constructor Create(AOwner: TAppraisalReport); override;
		procedure InitCaret(Clicked: Boolean); override;
		procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
		procedure LoadCellRsps(Cell: TBaseCell; cUID:CellUID); override;
		procedure InsertComment(Cmt: String; ReplaceTx: Boolean);
		procedure SelectedMenuCmt(Sender: TObject);
    procedure BuildPopUpMenu; override;
    procedure SetPopupPoint(var Pt: TPoint); override;
    procedure InsertRspItem(Rsp: String; Index, Mode: Integer); override;
		Procedure KeyEditor(var Key: Char); override;
		Procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
		procedure ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
		procedure ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;

    procedure CalcCaretPos; override;
		procedure SetCaret; override;
		Procedure SetClickCaret(ClickPt: TPoint); override;
		Procedure DrawCurCell; override;
    procedure CheckTextOverFlow;
    function TextOverflowed: Boolean; override;
		procedure DisplayCurCell; override;
		Procedure DisplayCom(LnIdx: Integer);
		Procedure CalcTextWrap;
		Function InsertHardLn (LnIdx, charIdx, retIdx: Integer): Integer;
		Procedure DeleteHardLn (LnIdx: Integer);
		Function Pixel2Char(chStart, chLen, PixelPos: Integer; var LeftSide: Boolean): Integer;
		Function GetClickPosition(Ln, dx: Integer; var Ch: Integer): Integer;  override;
		Function TextWidth(chStart, chLast: Integer): Integer;
		Function GetLineWidth (LnIdx, ChPos: Integer): Integer;
		Function GetNumLines: Integer;
		Function GetCurLine(chPos: Integer): Integer;
		Procedure FindWord(chStart, chEnd, chPos: Integer; var fstChWrd, lstChWrd: Integer);
		Procedure DeleteComSel;
		Procedure DeleteComChar;
		procedure DeleteForwardLnChar; override;
    procedure InputChar(Ch: Char); override;
		Procedure UndoEdit; override;
		Procedure CutEdit; override;
		Procedure PasteText (theText: string);override;
		Procedure ClearEdit; override;
		Procedure SelectAll; override;
		Procedure SaveChanges; override;
		procedure SaveToRspList(Sender: TObject); override;
		Procedure ReInvertText; override;
		procedure MoveCaret(shifted: Boolean; Direction: integer); override;
		function CanMoveCaret(Direction: integer): Boolean; override;
		Function CanAcceptChar(Key: Char): Boolean; override;
    procedure SetTextJustification(const Value: Integer); override;

    // ITextEditor
    public
      procedure SetText(const Value: String); override;
      procedure InputString(const Text: String); override;
      procedure SelectText(const Start: Integer; const Length: Integer); override;
	end;

  {FreeText Editor}
  TFreeTxEditor = class(TSLEditor)
    procedure IdleEditor; override;
    function HasActiveCellOnPage(Page: TObject): Boolean; override;
    procedure LoadItem(Item: TMarkupItem); override;
    procedure UnLoadCell; override;
    procedure RightClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyEditor(var Key: Char); override;
    procedure DrawCurCell; override;
    procedure SaveChanges; override;
    procedure ReplaceLnSel(S: String);
    procedure InsertLnText(S: string);
    procedure UnHilightCell; override;
    Procedure PasteText (theText: string);override;
  end;

{ TGraphicEditor }

	TGraphicEditor = class(TEditor)
    private
      FPreviousImageChangedEvent: TNotifyEvent;
    private
      procedure OnImageChanged(Sender: TObject);
      procedure OptimizeImage;
    public
		FCanUndo: Boolean;			    //can we do an undo?
    FEditImage: TCFImage;       //just ref to cells TCFImage
    FUndoImage: TCFImage;       //copy of image object for undoing
		FEditPicDest: TRect;
		FEditScale: Integer;
		FViewPort: TRect;
    FSrcRect: TRect;
		FCenter: Boolean;              //center the image
		FStretch: Boolean;             //make it fit in cell frame
		FAspRatio: Boolean;            //keep the aspect ratio
		FPrFrame: Boolean;             //print the frame
    FActiveLabel: TPageControl;    //active label during mouseDown to mouseUp only
    //use instead TCFImage.FOptimized
    //FOptimized: Boolean;            //Optimize the image
		constructor Create(AOwner: TAppraisalReport); override;
		destructor Destroy; override;
		procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
		procedure Unloadcell;override;
		procedure HilightCell; override;
		procedure UnHilightCell; override;
		procedure ResetView(bStretch, bCntr, bAspRatio: Boolean; xScale: Integer);
		Procedure DrawCurCell; override;
		procedure DisplayCurCell; override;
		procedure KeyEditor(var Key: Char); override;
		procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
    procedure PerformGraphicModification; virtual;
    function LoadImageFile(imageFile: String): Boolean;
    function LoadImageStream(Stream: TStream): Boolean;
    function LoadGraphicImage(Image: TGraphic): Boolean;
    function LoadEMFplusImage(Image: TGraphic): Boolean;
    procedure BuildPopUpMenu; override;
    procedure SetPopupPoint(var Pt: TPoint); override;
    procedure ShowAnnotationPopupMenu(Pt: TPoint);
    procedure SaveImageToFile(Sender: TObject);
    procedure GetImageFromFile(Sender: TObject);
    procedure GetImageFromTwain(Sender: TObject);
    procedure SelectTwainSources(Sender: TObject);
		function CanAcceptChar(Key: Char): Boolean; override;    //checks if it can take the char use it to move
    procedure SaveUndo;
    function HasContents: Boolean; override;
    function HasActiveAnnotation: Boolean;
    procedure ClearUndo; override;
		Procedure UndoEdit; override;
		procedure CutEdit; override;
		procedure CopyEdit; override;
		procedure PasteEdit; override;
		procedure ClearEdit; override;
    procedure ClearAnnotation(Sender: TObject); virtual;
    procedure ClearAllAnnotations(Sender: TObject);
		procedure SaveChanges; override;
		function CanCopy: Boolean; override;
		function CanCut: Boolean; override;
		function CanPaste: Boolean; override;
		function CanClear: Boolean; override;
		function CanUndo: Boolean; override;
	end;

  { TCompanyNameEdtor }

  TCompanyNameEdtor = class(TSLEditor)
    procedure InsertRspItem(Rsp: String; Index, Mode: Integer); override;
  end;


  { TSignerEditor }

  TSignerEditor = class(TSLEditor)
    procedure LoadCellRsps(Cell: TBaseCell; cUID:CellUID); override;
    procedure BuildPopUpMenu; override;
    procedure SetPopupPoint(var Pt: TPoint); override;
    procedure AddPopupEditCmds; override;
    procedure InsertRspItem(Rsp: String; Index, Mode: Integer); override;
    function CanFormatText: Boolean; override;
  end;

  { TLicenseeEditor }
  TLicenseeEditor = class(TSignerEditor)
		procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
//    procedure LoadCellRsps(Cell: TBaseCell; cUID:CellUID); override;
    procedure InsertRspItem(Rsp: String; Index, Mode: Integer); override;
  end;



{ TImageToolEditor }
  TImageToolEditor = class(TGraphicEditor)
    FToolUID: Integer;
    FServiceUID: Integer;
    constructor Create(AOwner: TAppraisalReport); override;
    procedure DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClearEdit; override;
    procedure LaunchMapService(Sender: TObject);
    property ImageTool: Integer read FToolUID write FToolUID;
  end;


{ TSketchEditor }

	TSketchEditor = class(TImageToolEditor)
//    constructor Create(AOwner: TComponent); override;
    procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
    procedure KeyEditor(var Key: Char);  override;
    procedure ClearEdit;  override;
  end;

{ TAdvertisementCellEditor }

	TAdvertisementCellEditor = class(TGraphicEditor)
    procedure DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure LoadURLToCell;
  end;

{ TMapEditor }

  TMapEditor = class(TImageToolEditor)    //assumes maps are geocoded. Flood is not.
    FMapGeoCoded: Boolean;
    FMapGeoBounds: TGeoRect;
    function GeoCodeToMapPixelPt(GeoPt: TGeoPoint): TPoint;
    function MapPixelPtToGeoCode(Pt: TPoint): TGeoPoint;
  public
    procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
    procedure SaveChanges; override;
    procedure ClearGeoData;
    procedure LoadMapGeoCodeBounds(MapBounds: TGeoRect);
    function GetMapLabelPlacement(GeoPt: TGeoPoint): TPoint;
    function GetMapLabelOrientation(Pt: TPoint): Integer;
    property MapGeoCoded: Boolean read FMapGeoCoded write FMapGeoCoded;
    property MapGeoBounds: TGeoRect read FMapGeoBounds write FMapGeoBounds;
  end;


  { TMapFloodEditor }

	TMapFloodEditor = class(TImageToolEditor)
    FMapPtMovable: Boolean;    //is it moveable or not
    FSubjectPt: TPoint;        //original point
    FQueryStr: String;         //original query string
    FCreatedOn: TDateTime;     //date map created - only movable for 24 hours
  public
    procedure LoadCell(Cell: TBaseCell; cUID:CellUID); override;
    procedure SaveChanges; override;
    procedure ClearGeoData;
    function GetMapLabelPlacement(GeoPt: TPoint): TPoint;
    procedure BuildPopUpMenu; override;
    procedure PerformGraphicModification; override;
    property MapSubjMovable: Boolean read FMapPtMovable write FMapPtMovable;
    property MapSubjPoint: TPoint read FSubjectPt write FSubjectPt;
    property MapQueryStr: string read FQueryStr write FQueryStr;        //used to store the query string for respotting
    property MapCreatedOn: TDateTime read FCreatedOn write FCreatedOn;  //stores the date the map was created for the first time
  end;

  { TMapLocEditor }

	TMapLocEditor = class(TMapEditor)
    constructor Create(AOwner: TAppraisalReport); override;
    procedure BuildPopUpMenu; override;
    procedure BroadcastProximity(ARefID, ACatID: Integer; ProxStr: String);
    procedure PerformGraphicModification; override;
    procedure ClearAnnotation(Sender: TObject); override;
  end;

{ TMapPlatEditor }
	TMapPlatEditor = class(TMapEditor);

  { TDeedPlotEditor }
	TDeedPlotEditor = class(TImageToolEditor);

function GetEditorClass(const ClassName: String): TCellEditorClass;
procedure RegisterEditor(const CellEditorClass: TCellEditorClass);
procedure UnRegisterEditor(const CellEditorClass: TCellEditorClass);

implementation

Uses
  Clipbrd,
  DateUtils,
  Dll96v1,
  DXExEdtr,
  Forms,
  Math,
  Messages,
  StrUtils,
  SysUtils,
  UCellAutoAdjust,
  UCellMetaData,
  UContainer,
  UDocView,
  UForm,
  UImageView,
  UInsertSelect,
  ULicUser,
  ULinkCommentsForm,
  UMain,
  UPage,
  UPortFloodInsights,
  UServices,
  UStatus,
  UStdCmtsEdit,
  UStrings,
  UTools,
  UUtil1,
  UUtil3,
  UWebUtils,
  UWindowsInfo,
  UWordProcessor,
  UUADUtils,
  UListComps2,
  uUADConsistency,
  UUtil2,
  uListCompsUtils,
  UUADObject;

//These are the forms that cannot allows preprocessing with the grid adjustment
//columns becuase input is restricted to (+,=,-) characters. They have to be treated
//especially, becuase they are normally part of pre-processing math or replication
const
  NoPreProcessInTheseGridForms:  array [0..5] of Integer = (970,973,974,975,977,978);

var
  GEditorClassList: TStringList;

//*****************************************************
// Misc Routines for Text Editors


function IsValidWordChar(ch: Char): Boolean;
const
	Alpha = ['A'..'Z', 'a'..'z', '_'];
	AlphaPeriod = Alpha + ['.'];
begin
	result := ch in Alpha;
end;

function ValidWordBreakChar(ch: Char): Boolean;
const
	WrdBreakChars = [char(kLFKey), char(kReturnKey), char(kSpaceKey)];		//linefeed, return, space
begin
	result := ch in WrdBreakChars;
end;

(*
	A := SelBeg;
	i := A;
	while ValidCh(Text, numChs, i - 1) do
		i := i - 1;
	SelBeg := i;
	i := A;
	while ValidCh(CurText, numChs, i) do
		i := i + 1;
	SelEnd := i;
*) Procedure GetWordBoundary(Str: String; chStart, chEnd, caretPos: Integer; var fstChWrd, lstChWrd: Integer);
var
	n: Integer;
begin
	if (chStart > 0) and (caretPos >= 0) and (caretPos <= chEnd) then
		begin
			n := caretPos;
			fstChWrd := n+1;
			while (n >= chStart) and not ValidWordBreakChar(Str[n]) do      //find first break on left
				begin
					fstChWrd := n;       	 //first character of word
					dec(n);                //move back until we find a space
				end;

			n := caretPos;
			lstChWrd := n;
			while (n <= chEnd) and not ValidWordBreakChar(Str[n]) do     //find first break on right
				begin
					lstChWrd := n;         //last character of word
					inc(n);                //move forward until we find a space
				end;
		end;
end;

Function GetTextWidth(Canvas: TCanvas; Str: String; chStart, chLast: Integer): Integer;
var
	strWidth: TSize;
begin
	GetTextExtentPoint32(Canvas.Handle, StrPtrOffset(Str, chStart-1), chLast-chStart+1, strWidth);
	result := strWidth.cx;
end;

procedure MakePtValid(Box: TRect; MaxLns: Integer; var P: TPoint; var Ln: Integer; scale: Integer);
begin
	Box := scaleRect(Box, cNormScale, scale);
	with P, Box do
		begin
			if y > bottom then
				y := bottom;
			if y < Top then
				y := top;
			if x < Left then
				x := left;
			if x > right then
				x := right;

      Ln := Trunc((y - Top) / ((kLnHeight * Scale)/ cNormScale));
			if Ln >= MaxLns then
				Ln := MaxLns-1;
		end;
end;

function ValidCh (Tx: String; MaxCh, N: Integer): Boolean;
begin
	if (N < 0) or (N >= MaxCh) then
		ValidCh := false
	else
		ValidCh := True;		//(CharsHandle(Tx)^^[N] in ['*', '0'..'9', 'A'..'Z', 'a'..'z']);
end;

procedure RankPts (var A, B: TPoint);
	var
		S: TPoint;
begin
	S := B;
	if S.y = A.y then
		begin
			B.x := Max(S.x, A.x);
			A.x := Min(S.x, A.x);
		end
	else if A.y > B.y then
		begin
			B := A;
			A := S;
		end;
end;
 //******************************************************************



{ TEditor is Base Class of our Editors}


constructor TEditor.Create(AOwner: TAppraisalReport);
begin
	inherited;

	FDoc := nil;
	FPage := nil;
	FCell := nil;
	FCanvas := nil;
	FCanSelect := False;           //toggle for mouseMove
  FCanEdit := True;              //lock out editing cell
  FUpperCase := IsAppPrefSet(bUppercase); //can we have all caps
	FActive := False;
	FModified := False;
	FLastBlink := GetTickCount;
	FFrame := Rect(0,0,0,0);

  TxStr := '';
	FAutoRspOn := False;
	FRspsVisible := False;
	FRsps := nil;

	if  AOwner <> nil then
		if AOwner is TContainer then
			begin
				FDoc := AOwner;                  						 // the document container
        FDocView := TContainer(FDoc).docView;        //assign the docView
        FCanvas := TDocView(FDocView).Canvas;        //assign the canvas to draw on
			end;
end;

procedure TEditor.BeforeDestruction;
begin
  UnLoadCellRsps;
  UnLoadCell;
  inherited;
end;

destructor TEditor.Destroy;
begin
  FreeAndNil(FPopupMenu);
  inherited Destroy;
end;

procedure TEditor.ActivateEditor;
begin
	FActive := True;
end;

procedure TEditor.DeactivateEditor;
begin
	FActive := False;
end;

//### not called by anyone
Function TEditor.GetModifiedState;
begin
	result := FModified;
end;

function TEditor.GetRspChged: Boolean;
begin
  result := False;
  if assigned(FRsps) then
	  result := FRsps.Modified;
end;

function TEditor.KeyForAutoRsponse(var Key: Word; Shift: TShiftState): Boolean;
begin
  result := FAutoRspOn and FRspsVisible and Assigned(FRsps) and FRsps.HasResponses;
  if (not result) and (key = VK_ESCAPE) then   //pass on the excape
    result := true;
end;

procedure TEditor.IdleEditor;
begin
//	If FActive then
//		begin
//		end;
//	BlinkCaret;
end;

procedure TEditor.KeyEditor(var Key: Char);
begin
//	if FActive then
//		begin
//		end;
end;

procedure TEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
	if FActive then
		FCanSelect := True;
end;

procedure TEditor.DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
end;

procedure TEditor.RightClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  // 091611 JWyatt Add popup menu capability for UAD grid cells to allow comp copying, etc.
  //	Was: if not AutoRspOn and FCanEdit then    //make sure editing is allowed
	if not AutoRspOn and (FCanEdit or (ClassName = 'TGridCellDialogEditor')) then    //make sure editing is allowed
    ShowPopupMenu(clickPt);
end;

procedure TEditor.ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if FActive then
		FCanSelect := False;           //no more selecting
end;

procedure TEditor.ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TEditor.BuildPopUpMenu;
begin
  AddPopupEditCmds;
  if Assigned(FOnBuildPopupMenu) then
    FOnBuildPopupMenu(Self, FPopupMenu);
end;

procedure TEditor.SetPopupPoint(var Pt: TPoint);
begin
end;

procedure TEditor.AddPopupEditCmds;
var
	MI: TMenuItem;
  insertIdx: Integer;
begin
  if assigned(FPopupMenu) then
  begin
    if appPref_AddEditM2Popups then
      begin
        insertIdx := -1;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMUndo) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.EditUndoCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMCut) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.EditCutCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.EditCopyCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.EditPasteCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMClear) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.EditClearCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        if IsBitSet(appPref_AddEM2PUpPref, bAddEMCellPref) then
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Action := Main.CellPrefCmd;
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

        //Add pop up menu for Comps DB
        //if IsBitSet(appPref_AddEM2PUpPref, bAddEMCellPref) then
        if insertIdx > -1 then  //we have added some menu items
          begin
            MI := TMenuItem.Create(FPopupMenu);
            MI.Caption := '-';
            inc(insertIdx);
            FPopupMenu.Items.Insert(insertIdx, MI);
          end;

      end;
    end;
end;

procedure TEditor.ShowPopupMenu(Pt: TPoint);
begin
  FreeAndNil(FPopupMenu);
  FPopupMenu := TPopupMenu.Create(nil);

  BuildPopupMenu;
  SetPopupPoint(Pt);
  FPopupMenu.Popup(Pt.x, Pt.y);
end;

procedure TEditor.InitCaret(Clicked: Boolean);
begin
	//do nothing
end;

procedure TEditor.LoadItem(Item: TMarkupItem);
begin
  if assigned(Item) then
    begin
      FItem := Item;
      FPage := Item.FParentPage;
      FFrame := Item.Bounds;
      FCanEdit := not TContainer(FDoc).OnlyRead;
      FActive := True;							//the editor is now ready
      FCellActive := True;          //tell the container the Item is active
    end;
end;

procedure TEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
try
  UnloadCell;
  if Cell <> nil then
    begin
      FCell := Cell;
      FCellUID := cUID;
      FCellStatus := Cell.FCellStatus;
      FCellPrefs := Cell.FCellPref;
      FPage := Cell.FParentPage;
      FFrame := Cell.FFrame;
      ResetCanEdit;

      FActive := True;							//the editor is now ready
      FCellActive := True;          //tell the container the cell is active
      FCellFmtChged := False;
      FAllowRspsOnly := IsBitSet(FCellPrefs, bSelRspOnly);

      FCell.Editor := Self;         //set the owner
    end;
except on E:Exception do
//shownotice('TEditor.LoadCell: '+e.Message);
end;
end;

procedure TEditor.LoadCellRsps(Cell: TBaseCell; cUID:CellUID);
begin
  UnLoadCellRsps;
end;

procedure TEditor.Reload;
begin
  if Assigned(FCell) then
    LoadCell(FCell, FCell.UID);
end;

procedure TEditor.UnloadCell;
begin
 try
  if Assigned(FCell) then
    FCell.Editor := nil;

	FPage := nil;
	FCell := nil;
	FCellUID := nullUID;
	FActive := False;
	FCellActive := False;
 except on E:Exception do
//   shownotice('TEditor.UnloadCell: '+e.Message);
 end;
end;

procedure TEditor.UnLoadCellRsps;
begin
end;

procedure TEditor.HilightCell;
var
  focus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, focus);
  try
    FCell.FocusOnCell;
    DrawCurCell;
  finally
    SetViewFocus(FCanvas.Handle, focus);
  end;
end;

procedure TEditor.UnHilightCell;
var
	curFocus: TFocus;
begin
	with TBaseCell(FCell) do
	begin
		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;
    DrawCurCell;
		SetViewFocus(FCanvas.handle, curFocus);
	end;
end;

procedure TEditor.FocusOnCell;        //just for cleaner code
begin
  if assigned(FCell) then             //eventually merge FCell & FItem
	  TBaseCell(FCell).FocusOnCell
  else if assigned(FItem) then
    TMarkupItem(FItem).FocusOnItem;
end;

procedure TEditor.FocusOn(View: TRect);
begin
  if assigned(FCell) then             //eventually merge FCell & FItem
	  TBaseCell(FCell).FocusOn(View)
  else if assigned(FItem) then
    TMarkupItem(FItem).FocusOn(View);
end;

procedure TEditor.FocusOnWindow;
begin
  if assigned(FCell) then            //eventually merge FCell & FItem
  	TBaseCell(FCell).FocusOnWindow
  else if assigned(FItem) then
    TMarkupItem(FItem).FocusOnWindow;
end;

function TEditor.CellInView(View: TRect; vuScale: Integer): Boolean;
var
  scaledCell: TRect;
begin
  scaledCell := ScaleRect(FFrame, cNormScale, VuScale);
  result := IntersectRect(View, View, scaledCell);
end;

function TEditor.GetDocScale: Integer;
begin
	result := TDocView(FDocView).pixScale;
end;

procedure TEditor.ResetScale;
begin
end;

Procedure TEditor.DisplayCurCell;         //used when redisplaying window
begin                                     //cell override to add hilighting, etc.
	DrawCurCell;
end;

procedure TEditor.DrawCurCell;           //editor uses this to redraw its edits
begin
end;

procedure TEditor.ClearEdit;
begin
end;

procedure TEditor.CopyEdit;
begin
end;

procedure TEditor.CutEdit;
begin
end;

procedure TEditor.PasteEdit;
begin
end;

procedure TEditor.UndoEdit;
begin
end;

procedure TEditor.ClearUndo;
begin
end;

procedure TEditor.SaveChanges;
begin
  if assigned(FCell) then
    begin
		  FCell.FCellPref := FCellPrefs;          //holds the prefs 31 flag bit
		  FCell.FCellFormat := FCellFormat;       //holds the formatting bits

      if FModified then
        FCell.Modified := True;
      if FCellFmtChged then
        FCell.SetFormatModifiedFlag;
      FCellFmtChged := False;
    end;
end;

procedure TEditor.SaveResponses;
begin
  if assigned(FRsps) then
	  if FRsps.Modified then       //Save the responses if modified
		  FRsps.SaveItems;
end;

procedure TEditor.SaveToRspList(Sender: TObject);
begin
end;

procedure TEditor.SelectAll;
begin
end;

procedure TEditor.Update;
begin
end;

function TEditor.TextOverflowed: Boolean;
begin
  result := false;
end;

function  TEditor.CanCopy: Boolean;
begin
	result := False;
end;

function  TEditor.CanCut: Boolean;
begin
	result := False;
end;

function  TEditor.CanPaste: Boolean;
begin
	result := False;
end;

function  TEditor.CanClear: Boolean;
begin
	result := False;
end;

function  TEditor.CanSelectAll: Boolean;
begin
	result := False;
end;

function TEditor.CanSpellCheck: Boolean;
begin
	result := False;
end;

function  TEditor.CanUndo: Boolean;
begin
	result := False;
end;

function TEditor.HasContents: Boolean;
begin
  result := False;
end;

function TEditor.HasSelection: Boolean;
begin
  result := False;
end;

function TEditor.GetValue: Double;
///Var
//  E: Integer;
begin
  result := GetStrValue(TxStr);
//  Val(TxStr, result, E);
//  if E <> 0 then result := 0;      	//there was error so return to zero
end;

function TEditor.GetTextColor(overflowed: Boolean): TColor;
begin
  result := colorUserText;
  if overflowed then
    result := colorOverflowTx;
end;

Procedure TEditor.SetFormat(format: LongInt);
begin
  if FCellFormat <> format then
    begin
      FCellFormat := format;
      FCellFmtChged := True;
    end;
end;

procedure TEditor.SetPreferences(prefs: Longint);
begin
  if FCellPrefs <> prefs then
    begin
      FCellPrefs := prefs;
      FCellFmtChged := True;
    end;
end;

procedure TEditor.SetAutoRsp(value: Boolean);
begin
	FAutoRspOn := value;
end;

procedure TEditor.MoveCaret(Shifted: Boolean; Direction: integer);
begin
end;

function TEditor.CanMoveCaret(Direction: integer): Boolean;
begin
	result := False;
end;

function TEditor.CanAcceptChar(Key: Char): Boolean;
begin
	result := Key in [#08,#32..#255];  			//all visible + backspace, delete=$87
end;

function TEditor.HasActiveCellOnPage(Page: TObject): Boolean;
begin
	result := False;
	if (FCell <> nil) then
		result := (FCell.FParentPage = Page);
end;

procedure TEditor.ResetCanEdit;
begin
  FCanEdit := False;
  if assigned(FCell) and assigned(FDoc) then
    FCanEdit := not IsBitSet(FCell.FCellPref, bCelDispOnly)    //is the cell editable?
                and not FCell.Disabled                         //cell is disabled
                and not FDoc.Locked                            //signature locked
                and not TContainer(FDoc).OnlyRead;             //file is Read Only
end;

{***********************************************}
{                                               }
{      TSLEditor - Single Line Editor      			}
{                                               }
{***********************************************}

procedure TSLEditor.OnFontChanged(Sender: TObject);
var
  focus: TFocus;
begin
  FCellFmtChged := True;
  FModified := True;

  GetViewFocus(FCanvas.Handle, focus);
  try
    FocusOnCell;
    DisplayCurCell;
  finally
    SetViewFocus(FCanvas.handle, focus);
  end;
end;

procedure TSLEditor.OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  (FDoc as TContainer).OnKeyDown(Sender, Key, Shift);
  ListRspsKeyDown(Sender, Key, Shift);
end;

procedure TSLEditor.BuildResponseMenu;
var
	i: Integer;
	MI: TMenuItem;
begin
  if Assigned(FPopupMenu) then
    begin
      if (Length(TxStr) > 0) then
        begin
          MI := TMenuItem.Create(FPopupMenu);      //Save as comment
          MI.caption := 'Save as Response';
          MI.OnClick := SaveToRspList;
          FPopupMenu.Items.Add(MI);

          MI := TMenuItem.Create(FPopupMenu);       //divider
          MI.caption := '-';
          FPopupMenu.Items.Add(MI);
        end;

      i := FPopupMenu.Items.Count;
      TRspHelper(FRsps).BuildPopupRspMenu(FPopupMenu);   //and rebuild
      for i := Max(i, 0) to FPopupMenu.Items.Count - 1 do
        FPopupMenu.Items[i].OnClick := SelectedMenuRsp;
    end;
end;

// DOC: Selbeg and SelEnd are zero based numbers that indicate the caret position
//or the selection range. (ie selbeg=0 and selend=4 means ABCD are selected; selbeg
// = 1 and selend =1 neans the caret is between A and B.
//  A B C D
// 0 1 2 3 4
//
constructor TSLEditor.Create(AOwner: TAppraisalReport);
begin
  FFont := TCellFont.Create;
	inherited Create(AOwner);

	FCaretOn := False;                          //no caret at start
  FFont.Assign((FDoc as TContainer).docFont);

	numChs := 0;
	SelBeg := 0;
	SelEnd := 0;
	TxCaret := Point(0, 0);
	TxRect := Rect(0, 0, 0, 0);
	FTxJust := tjJustLeft;
	SelBegPt := Point(0, 0);
	SelEndPt := Point(0, 0);
	UndoBeg := 0;
	UndoEnd := 0;
	UndoText := '';

	FListRsps := nil;
  FFirstRspInsert := True;
end;

destructor TSLEditor.Destroy;
begin
  FreeAndNil(FFont);
	inherited Destroy;
end;

procedure TSLEditor.InitCaret(Clicked: Boolean);
begin
	if NumChs > 0 then
		if not Clicked and IsAppPrefSet(bAutoSelect) and not FCell.Disabled then
			begin
				SelBeg := 0;
				SelEnd := numChs;
				SelBegPt := Point(Get1LineWidth(SelBeg), 1);
				SelEndPt := Point(Get1LineWidth(SelEnd), 1);
//              FocusOnCurTxRgn(Window);		{because caret & highlighting can go out of box}
				InvertText(SelBegPt, SelEndPt);
//              FocusOnDocument(Window);
        CalcCaretPos;
			end
		else
			begin
				SetCaret;
				SelBegPt := Point(TxCaret.x, 1);
				SelEndPt := Point(TxCaret.x, 1);
			end
	else    // numChs = 0
		begin
			SetCaret;
			SelBegPt := Point(TxCaret.x, 1);
			SelEndPt := Point(TxCaret.x, 1);
		end;
end;

procedure TSLEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
	inherited LoadCell(cell, cUID);

	with TBaseCell(FCell) do
	begin
		TxStr := Text;       //this is a copy of the text to edit

	  SelBeg := Length(TxStr);                	//set the editor vars
		SelEnd := SelBeg;
		NumChs := SelBeg;

    TxValue := Value;
		TxRect := FFrame;                       //the text rect = the frame
    TxRect.Left := TxRect.Left +1;
    FFont.Size := FTxSize;
		FFont.Style := GetCellPrefStyle(FCellPref);
    FFont.OnChange := OnFontChanged;
    Self.FTxJust := FCell.FTxJust;
    TxFormat := FCellFormat;
		saveFont.Assign(FCanvas.Font);            //### redo this
	end;
end;

procedure TSLEditor.LoadCellRsps(Cell: TBaseCell; cUID:CellUID);
var
  container: TContainer;
begin
  inherited;
  try
    container := (FDoc as TContainer);
    FRsps := CreateRspHelper(Cell.FResponseID, cUID);
    FListRsps := TRspHelper(FRsps).BuildStdRspListBox(FDoc);
    FListRsps.OnClick := ListRspsClick;
    FListRsps.OnKeyDown := OnResponseKeyDown;
    FListRsps.OnKeyPress := Container.OnKeyPress;
  except
  end;
end;

procedure TSLEditor.SelectedMenuRsp(Sender: TObject);
begin
	with Sender as TMenuItem do
    if not (tag < 0) then
      InsertRspItem(Caption, Tag, Ord(ShiftKeyDown));
end;

function TSLEditor.KeyForAutoRsponse(var Key: Word; Shift: TShiftState): Boolean;
begin
  result := inherited KeyForAutoRsponse(Key, Shift);
  if result and assigned(FListRsps) and (FListRsps.count > 0) then
    if FListRsps.Visible and not FListRsps.Focused then
      begin
//        FListRsps.Visible := True;
        FListRsps.SetFocus;
        ListRspsKeyDown(nil, key, shift);
      end
    else if Key = VK_ESCAPE then
      ListRspsKeyDown(nil, key, shift)
  else
    TContainer(FDoc).docView.SetFocus;
end;

procedure TSLEditor.SetPopupPoint(var Pt: TPoint);
begin
  //ignore the mouse pt coming in, and put at bottom left
  Pt := FCell.Area2Doc(point(TxRect.left, TxRect.bottom));
  Pt := TDocView(FDocView).Doc2Client(Pt);
  Pt :=  TDocView(FDocView).ClientToScreen(Pt);
end;

procedure TSLEditor.BuildPopUpMenu;
begin
  inherited;
  // 062811 JWyatt Add check for UAD cells that are not controlled by a dialog
  //  and can have a responses.
  // 063011 JWyatt Restore IsUADRspCell check so response list is not doubled.
  if (ClassType = TSLEditor) or
     (ClassType = TDateSLEditor) or
     (ClassType = TCompanyNameEdtor) or
     IsUADRspCell(ClassType.ClassName) then
    BuildResponseMenu;
end;

procedure TSLEditor.ShowListRsps(Pt: TPoint);
var
	docVu: TDocView;
	W: Integer;
begin
	if assigned(FListRsps) then
    if FListRsps.Items.Count > 0 then      //only show lists with rsps in it
      begin
        //ignore the pt coming in, and put at bottom left
        Pt := FCell.Area2Doc(point(TxRect.left, TxRect.bottom));
        docVu :=  TContainer(FDoc).docView;
        Pt := docVu.Doc2Client(Pt);
        FListRsps.Left := Pt.x-2;
        FListRsps.Top := Pt.y;
        W := TxRect.right-TxRect.Left+2 + 16;		//32=scrollbar width
        FListRsps.Width := muldiv(max(72, W), scale, cNormScale);
        FListRsps.Visible := True;               //finally show it
        docVu.ScrollInView(FListRsps);           //make sure everyone is in view
        RspsVisible := True;
        FMovingRspSelection := False;           //arrowKeys fire Click event, so don't
        FFirstRspInsert := True;
        FListRsps.SetFocus;
	end;
end;

procedure TSLEditor.HideListRsps;
begin
  if Assigned(FListRsps) then
    begin
      FListRsps.Visible := False;

      if RspsVisible then
        TContainer(FDoc).docView.SetFocus;      //Reset Control focus to docView.
      RspsVisible := False;
    end;
end;

procedure TSLEditor.InsertRspItem(Rsp: String; Index, Mode: Integer);
var
	curFocus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, curFocus);
  FocusOnCell;
  if SelBeg <> SelEnd then
    InvertText(selBegPt, selEndPt)
  else EraseCaret;

  if (mode = 0) or FFirstRspInsert or FAllowRspsOnly then  //ie only One Rsp
    begin
      SelBeg := 0;     			//selectAll;
      SelEnd := numChs;
      InputString(Rsp);    //replace
      FFirstRspInsert := False;
    end
  else
    begin
      if length(TxStr) > 0 then   //add the divider
        Rsp := '/' + Rsp;
      InputString(Rsp);
    end;

  SelBeg := numChs;     //place caret at end
  SelEnd := numChs;

  SetCaret;
  FModified := True;

  SetViewFocus(FCanvas.handle, curFocus);

	TContainer(FDoc).docView.SetFocus;      //Reset Control focus to docView.
end;

//must be focused
procedure TSLEditor.SelectListRspsItem;
var
	S: String;
	index: Integer;
begin
  S := TxStr;
  index := FListRsps.Perform(LB_FINDSTRING, -1, LParam(S));
  if index <> LB_ERR then begin
    FListRsps.ItemIndex := index;
    TxStr := FListRsps.Items[index];
    SelBeg := length(S);
    SelEnd := length(TxStr);
    numChs := SelEnd;
    SelBegPt := Point(Get1LineWidth(SelBeg), 1);
    SelEndPt := Point(Get1LineWidth(SelEnd), 1);
    FocusOnCell;
    DrawCurCell;
		if SelBeg <> SelEnd then
			ReInvertText;
  end;
end;

procedure TSLEditor.SelectOnlyListRspsItems(ch: char);
var
  Input, S, origTxStr: String;
  index: Integer;
begin
  if FUpperCase then
    Input := UpperCase(Ch)
  else
    Input := Ch;

  origTxStr := TxStr;      //save this in case no match, revert

  EraseCaret;
  if (SelBeg <> SelEnd) then
    UndoText := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    UndoText := Copy(TxStr, SelBeg + 1, Length(Input));
  UndoBeg := SelBeg;
  UndoEnd := UndoBeg + Length(Input);

  if (SelBeg <> SelEnd) then
    Delete(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    Delete(TxStr, SelBeg + 1, Length(Input));

  Insert(Input, TxStr, SelBeg + 1);

  S := TxStr;
  index := FListRsps.Perform(LB_FINDSTRING, -1, LParam(S));
  if index <> LB_ERR then
    begin
      FListRsps.ItemIndex := index;
      TxStr := FListRsps.Items[index];
      SelBeg := length(S);
      SelEnd := length(TxStr);
      numChs := SelEnd;
      SelBegPt := Point(Get1LineWidth(SelBeg), 1);
      SelEndPt := Point(Get1LineWidth(SelEnd), 1);

      FocusOnCell;
      DrawCurCell;
      if SelBeg <> SelEnd then
        ReInvertText;
      FModified := True;
    end
  else  //nothing changed, just reset & redraw
    begin
      TxStr := origTxStr;
      DrawCurCell;
    end;
end;

//type ahead when rsp list is not displayed
//must be already focused
procedure TSLEditor.AutoSelectRspItem;
var
	S,S2: String;
	index: Integer;
begin
  S := TxStr;
  index := FRsps.FindFirstMatch(S);
  if index > -1 then
    begin
      S2 := FRsps.GetRspItem(index);
      if FUpperCase then S2 := Uppercase(S2);
//      Delete(S2, 1, Length(S));
//      TxStr := S + S2;
      TxStr := S2;     //keep the text case of the response
      SelBeg := length(S);
      SelEnd := length(TxStr);
      numChs := SelEnd;
      SelBegPt := Point(Get1LineWidth(SelBeg), 1);
      SelEndPt := Point(Get1LineWidth(SelEnd), 1);

      DrawCurCell;
      if SelBeg <> SelEnd then
        ReInvertText
    end;
end;

procedure TSLEditor.CycleRspItem;
var
  S: String;
	index: Integer;
begin
  index := FRsps.CycleResponses;
  if index > -1 then
    begin
      S := FRsps.GetRspItem(index);
      InsertRspItem(S, 0, Ord(ShiftKeyDown));
    end;
end;

procedure TSLEditor.ListRspsClick(Sender: TObject);
var
  rsp: String;
  N: Integer;
begin
  if not FMovingRspSelection then
    begin
      if (FListRsps.Items.Count > 0) and (FListRsps.ItemIndex > -1) then
        begin
          N := FListRsps.ItemIndex;
          rsp := FListRsps.Items.Strings[N];
          if not ShiftKeyDown then HideListRsps;
          InsertRspItem(Rsp, N, Ord(ShiftKeyDown));    //now insert. (hide then insert for focus isues
        end;

      if AutoRspOn and (not ShiftKeyDown) then
        PostMessage(TContainer(FDoc).Handle, CLK_CELLMOVE, Word(goNext), 0);
    end;
  FMovingRspSelection := False;   //reset it
end;

procedure TSLEditor.ListRspsKeyDown(Sender: Tobject; var Key: Word; Shift: TShiftState);
var
  K: Integer;

  procedure SelectNInsert(N: Integer);
  var Rsp: String;
  begin
    if (FListRsps.Items.Count > -1)and (N < FListRsps.Items.Count) then
      begin
        FListRsps.ItemIndex := N;             //hilight text
        Rsp := FListRsps.Items.Strings[N];    //Get it
        InsertRspItem(Rsp, N, Ord(ShiftKeyDown));
      end;
  end;

  procedure MoveSelection(Up: Boolean);
  var
    N: Integer;
  begin
    N := FListRsps.ItemIndex;
    if Up then dec(N) else inc(N);
    if N < 0 then
      N := 0
    else if N > FListRsps.count-1 then
      N := FListRsps.count-1;
    if N <> FListRsps.ItemIndex then
      FListRsps.ItemIndex := N;
    FMovingRspSelection := True;
  end;

begin
  case key of
    VK_INSERT,
    VK_RETURN:
      if ssCtrl in Shift then
        begin
          K := FListRsps.ItemIndex;
          SelectNInsert(CycleForward(K, 0, FListRsps.Count-1));
        end
      else
        begin
          FMovingRspSelection := False;
          ListRspsClick(sender);
        end;
    VK_UP:
      MoveSelection(True);
    VK_DOWN:
      MoveSelection(False);
    VK_ESCAPE:
      begin
        HideListRsps;
      end;
(*
  else if (ssCtrl in Shift) and ((Key > 47) and (Key < 58)) then
    begin
      K := Key - 48;    //convert to 0..9
      if K = 0 then K := 10;
      SelectNInsert(K);
    end
*)
  end;

  Key := 0; //no more processing (not working)
end;

procedure TSLEditor.UnloadCell;
begin
	TxStr := '';
  FFont.OnChange := nil;

	inherited Unloadcell;
end;

procedure TSLEditor.UnLoadCellRsps;
begin
  inherited;
  FreeAndNil(FRsps);
  FreeAndNil(FListRsps);
  FAutoRspOn := False;
end;

procedure TSLEditor.UnHilightCell;
var
	curFocus: TFocus;
begin
	with TBaseCell(FCell) do
	begin
		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;
    DrawCurCell;
		SetViewFocus(FCanvas.handle, curFocus);
	end;
end;

//### Historical: Mac had set/restore font params
//Its not used here, but should be
procedure TSLEditor.SetCurTxParm;
begin
(*	SetPort(Window);
	TextFont(docDisplayPref.FontNum);
	TextSize(CurFSize);
	TextFace(CurStyle);
*)
end;

Procedure TSLEditor.SetTextJustification(const Value: Integer);
var
	curFocus: TFocus;
begin
	if FTxJust <> Value then
	begin
		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;
		FTxJust := Value;                   //set justification

		if SelBeg <> SelEnd then
			InvertText(selBegPt, selEndPt)
		else EraseCaret;

		if numChs > 0 then
			DrawCurCell;

		if SelBeg <> SelEnd then
			ReInvertText
		else SetCaret;

//		FModified := True;
    FCellFmtChged := True;
		SetViewFocus(FCanvas.handle, curFocus);
	end;
end;

//changes format for dates and cells with numbers
//called from Cell Preferences dialog
//does the same PreProcess in TGridEditor
Procedure TSLEditor.SetFormat(format: LongInt);
var
	str: String;
	curFocus: TFocus;
  cellValue: Double;
//  cellDate: TDateTime;
begin
	if format <> TxFormat then
	begin
    TxFormat := Format;
		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;
		if SelBeg <> SelEnd then
			InvertText(selBegPt, selEndPt)
		else EraseCaret;

    Str := TxStr;                    //current text

		if (FCell is TDateCell) then                 //format the dates
      begin
        if (TxValue = 0) then
          IsValidDate(Str, TDateTime(TxValue));          //get date value
        str := FormatDate(TxValue, Format);      //new formatted date
      end

    else if IsValidNumber(Str, CellValue) then   //format number if its a number
      begin
        if CellValue <> TxValue then      //str value <> current stored value
          TxValue := CellValue;           //its changed so remember it
        str := FormatValue(TxValue, Format);
      end;

		SelBeg := 0;     			//selectAll;
		SelEnd := numChs;
		InputString(str);          //replace with new format

		SelBeg := numChs;           //place caret at end
		SelEnd := numChs;
		SetCaret;

		FModified := True;
    FCellFmtChged := True;

		SetViewFocus(FCanvas.handle, curFocus);
	end;
end;

//doc menu cmd sets this value
procedure TSLEditor.SetAutoRsp(value: Boolean);
begin
	value := value and FCanEdit;
	if FAutoRspOn <> value then       	//need to do something
		if value then                   	//need to show it
			ShowListRsps(Point(0,0))    	  //show responses
		else
      HideListRsps;

  FAutoRspOn := Value;
end;

Function TSLEditor.GetTextJustification: Integer;
begin
	result := FTxJust;
end;

function TSLEditor.TextOverflowed;
begin
  result := (not TextFitsInBox(FCanvas, TxStr, ScaleRect(TxRect, cNormScale, Scale)));
end;

//finds the end point of the text relative to the TxRect and justification
//normally pass SelBeg for NChars
function TSLEditor.Get1LineWidth (NChars: Integer): Integer;
var
	strWidth, strLen: TSize;
	R: TRect;
begin
	strWidth.cx := 0;
	if NChars > 0 then
		GetTextExtentPoint32(FCanvas.Handle, PChar(TxStr), NChars, strWidth); 		//get the length
	R := ScaleRect(TxRect, cNormScale, scale);
	with R do
		case FTxJust of
			tjJustLeft:
				result := Left + strWidth.cx;
			tjJustMid:
				begin
					GetTextExtentPoint32(FCanvas.Handle, PChar(TxStr), length(TxStr), strLen);
					result := (Left + Right - strLen.cx) div 2 + strWidth.cx;
				end;
			tjJustRight:
				begin
					GetTextExtentPoint32(FCanvas.Handle, PChar(TxStr), length(TxStr), strLen);
					result := Right - strLen.cx + strWidth.cx;
				end;
			else
				result := Left + strWidth.cx;
		end;
end;

//pass in dx an x position in the string, returns the new placement
//and the nearest character. new placement because you cannot put the
//caret on a character
function TSLEditor.GetClickPosition (Ln, dx: Integer; var Ch: Integer): Integer;
var
	i, x, chCount : Integer;
	strWidth: TSize;
	ChExtent: Array of Integer;     //char extents array
begin
	result := dx;
	if length(TxStr) > 0 then
		begin
			SetLength(ChExtent, Length(TxStr));       //
	    FCanvas.Font.Assign(FFont);
	    FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);
			GetTextExtentExPoint(FCanvas.handle, PChar(TxStr), Length(TxStr), 2000, PInteger(@chCount), PInteger(ChExtent), strWidth);
      x := 0;
			with ScaleRect(TxRect, cNormScale, scale) do                //get the text starting point
				case FTxJust of
					tjJustLeft:
						x := Left;
					tjJustMid:
						x := (Left + Right - strWidth.cx) div 2;
					tjJustRight:
						x := Right - strWidth.cx;
				end;

			if dx < X + ChExtent[0] div 2 then
				begin
					ch := 0;
					result := X;
				end
			else if dx >= X + ChExtent[chCount-1] then
				begin
					ch := numChs;
					result := X + ChExtent[chCount-1];
				end
			else
				begin
					i := 0;                 //start + text extent + half next char < dx
					while (X + ChExtent[i] + ((ChExtent[i+1]-ChExtent[i]) div 2) < dx) and (i < chCount - 1) do
						i := i + 1;
					result := X + ChExtent[i];           //this is the new point.x
					Ch := i+1;                           //this is the char closest to X
				end;
		end;
end;

procedure TSLEditor.CalcCaretPos;
begin
  EraseCaret;
	TxCaret.x := Get1LineWidth(SelBeg);
	TxCaret.y := MulDiv(TxRect.Bottom - 1, scale, cNormScale);
end;

procedure TSLEditor.SetCaret;
begin
  CalcCaretPos;
	ShowCaret;           //show in changed position
end;

procedure TSLEditor.SaveSelection(Start, count: Integer);
begin
	UndoText := Copy(TxStr, start, count);
end;

procedure TSLEditor.DeleteLnSel;
begin
	if (NumChs > 0) and (SelBeg <> SelEnd) then
		begin
			UndoText := Copy(TxStr, SelBeg+1, SelEnd-SelBeg);  {save what we are deleting}
			UndoBeg := SelBeg;
			UndoEnd := UndoBeg;
//			UndoEnd := SelEnd;
			Delete(TxStr, SelBeg+1, SelEnd-SelBeg);
			SelBeg := UndoBeg;
			SelEnd := SelBeg;
			NumChs := Length(TxStr);
			DrawCurCell;
		end;
end;

procedure TSLEditor.DeleteForwardLnChar;
begin
	if (NumChs > 0) and (SelBeg < numChs) then
		begin
			EraseCaret;
			UndoText := Copy(TxStr, SelBeg+1, 1);					{save what we are deleting}
			UndoBeg := SelBeg;
			UndoEnd := UndoEnd;
//			UndoEnd := UndoBeg+1;
			Delete(TxStr, SelBeg+1, 1);
			NumChs := Length(TxStr);
			DrawCurCell;
		end;
end;

procedure TSLEditor.DeleteLnChar;
begin
	if (NumChs > 0) and (SelBeg > 0) then
		begin
			EraseCaret;
			UndoText := Copy(TxStr, SelBeg, 1);					{save what we are deleting}
			UndoBeg := SelBeg-1;
			UnDoEnd := UnDoBeg;
//			UndoEnd := UndoBeg+1;
			Delete(TxStr, SelBeg, 1);
			SelBeg := UndoBeg;
			SelEnd := SelBeg;
			NumChs := Length(TxStr);
			DrawCurCell;
		end;
end;

procedure TSLEditor.InputChar(Ch: Char);
var
  Input: String;
begin
  if FUpperCase then
    Input := UpperCase(Ch)
  else
    Input := Ch;

  EraseCaret;
  if (SelBeg <> SelEnd) then
    UndoText := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    UndoText := Copy(TxStr, SelBeg + 1, Length(Input));
  UndoBeg := SelBeg;
  UndoEnd := UndoBeg + Length(Input);

  if (SelBeg <> SelEnd) then
    Delete(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    Delete(TxStr, SelBeg + 1, Length(Input));
  Insert(Input, TxStr, SelBeg + 1);

  FModified := True;
  NumChs := Length(TxStr);
  SelBeg := SelBeg + Length(Input);
  SelEnd := SelBeg;

  DrawCurCell;
end;

procedure TSLEditor.KeyEditor(var Key: Char);
var
	OKey: Integer;
	Pt: TPoint;
	curFocus: TFocus;
begin
 	if FActive and FCanEdit and CanAcceptChar(Key) and TBaseCell(FCell).DisplayIsOpen(True) then
	begin
		Pt := TBaseCell(FCell).Caret2View(TxCaret);				//special to convert view pt to doc
		TContainer(FDoc).MakePtVisible(Pt);              //make it visible

		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;

		UndoText := '';
		undoBeg := 0;
		undoEnd := 0;

		OKey := ord(Key);
    //delete keys
		if (OKey = kBkSpace) or (OKey = kClearKey) or (OKey = kDeleteKey) then			{control chars}
			begin
				if SelBeg <> SelEnd then
					DeleteLnSel
				else if (OKey = kDeleteKey) then
					DeleteForwardLnChar
				else
					DeleteLnChar;
			end

    //shortcut response keys
		else if (OKey = VK_RETURN) and ControlKeyDown then
      begin
        CycleRspItem;
      end

    //special handling for standardized responses
    else if AllowRspsOnly then
      SelectOnlyListRspsItems(key)

    //regular text entry
    else
			begin
        InputChar(Key);

        if RspsVisible then
          SelectListRspsItem           //select by "type ahead" from list

        else if IsAppPrefSet(bAutoComplete) then
          AutoSelectRspItem;
			end;
		SetCaret;

		SetViewFocus(FCanvas.handle, curFocus);
		FModified := True;
	end;

	Key := #0;            //we handled the key
end;

procedure TSLEditor.ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	A: Integer;
begin
	inherited;							//toggle off the FCanSelect;

	if SelBeg <> SelEnd then
		begin
			A := SelBeg;									//the selection anchor
			SelBeg := Min(A, SelEnd);    	//figure out low to high
			SelEnd := Max(A, SelEnd);
			RankPts(SelBegPt, SelEndPt);
		end
end;

procedure TSLEditor.ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	Pt, newPt: TPoint;
	Ln: Integer;
begin
	if FActive and FCanSelect and (ssLeft in Shift) then    //just clicked
		begin
			if FCaretOn then   			//make sure caret is off
				EraseCaret;

			Pt := Point(X, Y);
			MakePtValid(TxRect, 1, Pt, Ln, Scale);    				//place pt in rect, even when it goes outside
			NewPt := Point(GetClickPosition(1, Pt.x, SelEnd), 1);     //align on char boundries

			if not EqualPts(NewPt, SelEndPt) then
				begin
					if (SelEndPt.x > NewPt.x) then
						InvertText(NewPt, SelEndPt)
					else if (SelEndPt.x < NewPt.x) then
						InvertText(SelEndPt, NewPt);
					SelEndPt := NewPt;
				end;
		end;
end;

procedure TSLEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
	A, B, fstWrd, lstWrd: Integer;
begin
	//Note: No focus since Cell mousedown does it
  if (Button = mbRight) then
    RightClickEditor(ClickPt, Button, Shift)

	else if numChs > 0 then
		begin
			FCanvas.Font.Assign(FFont);						//set font params
      FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);


			if SelBeg <> SelEnd then
				InvertText(SelBegPt, SelEndPt)			//unHilite previous}
			else if SelBeg = SelEnd then          //just erase the caret
				EraseCaret;

			If ssDouble in Shift then 			//this is a double click, so selbeg=selEnd
				begin
					GetWordBoundary(TxStr, 1, length(TxStr), SelBeg, fstWrd, lstWrd);   //### rework - confusing
					SelBeg := fstWrd-1;     //Sel's are zero based
					SelEnd := lstWrd;
					A := Get1LineWidth(SelBeg);
					B := GetTextWidth(FCanvas, TxStr, fstWrd, lstWrd);
					SelBegPt := Point(A, 1);
					SelEndPt := Point(SelBegPt.x + B, 1);
					InvertText(SelBegPt, SelEndPt);
				end
			else                         //this is a single click
				begin
					SetClickCaret(ClickPt);
				end;
			ClearUndo;			//clear, onto something else
		end;
end;

procedure TSLEditor.SetClickCaret(ClickPt: TPoint);
var
	C: Integer;
begin
	C := GetClickPosition(1, ClickPt.x, SelBeg);					//set the caret}
	TxCaret.x := C;
	TxCaret.y := MulDiv(TxRect.Bottom - 1, scale, cNormScale);
	SelEnd := SelBeg;

	ShowCaret;              	//redisplay the caret

	FCanSelect := True;     	//we clicked, we can start selecting text
	SelBegPt := Point(C, 1);
	SelEndPt := SelBegPt;
end;

procedure TSLEditor.MoveCaret(shifted: Boolean; Direction: integer);
var
	curFocus: TFocus;
begin
	if numChs > 0 then
		begin
			GetViewFocus(FCanvas.Handle, curFocus);
			FocusOnCell;
			if (SelBeg <> SelEnd) then
				InvertText(SelBegPt, SelEndPt)
			else
				EraseCaret;

      case direction of
        goleft:
          begin
            if SelBeg > 0 then SelBeg := Selbeg-1;
            if not shifted then SelEnd := SelBeg;
          end;
        goRight:
          begin
            if SelEnd < numChs then SelEnd := SelEnd+1;
            if not shifted then SelBeg := SelEnd;
          end;
        goHome:
          begin
            SelBeg := 0;
            if not shifted then SelEnd := SelBeg;
          end;
        goEnd:
          begin
            SelEnd := numChs;
            if not shifted then SelBeg := SelEnd;
          end;
      end;

			if shifted then
				begin
          SelBegPt := Point(Get1LineWidth(SelBeg), 1);
				  SelEndPt := Point(Get1LineWidth(SelEnd), 1);
          InvertText(SelBegPt, SelEndPt);
				end
			else
				begin
          SetCaret;
//          ShowCaret;
        end;
			SetViewFocus(FCanvas.handle, curFocus);

			ClearUndo;			//clear, onto something else
		end;
end;

function TSLEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  result := False;
  // 062411 JWyatt Add a check for a nil FCell in case there is no active cell
  //  Was: if (NumChs > 0) and not FCell.Disabled then
  if (NumChs > 0) and ((FCell = nil) or (not FCell.Disabled)) then
    if (direction = goLeft) or (direction = goHome) then
      result := ((SelBeg > 0) or (Selbeg <> SelEnd))
    else if (direction = goRight) or (direction = goEnd) then
      result := (SelBeg < NumChs);
end;

procedure TSLEditor.EraseCaret;
var
  pt: TPoint;
	curFocus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, curFocus);
  try
    FocusOnCell;
    if (SelBeg = SelEnd) and FCaretOn then
      begin
        FCanvas.Pen.Width := 1;
        FCanvas.Pen.Mode := pmNot;			//	PenMode(PatXOR);
//			Pt := ScalePt(TxCaret, 1,1);		//cNormScale, Scale);
        Pt := TxCaret;
        FCanvas.MoveTo(Pt.x - 1, Pt.y);
        FCanvas.LineTo(Pt.x - 1, Pt.y-mulDiv(kCaretHeight, Scale, cNormScale));
        FCanvas.Pen.Mode := pmCopy;
        FCaretOn := False;
      end;
  finally
    SetViewFocus(FCanvas.Handle, curFocus);
  end;
end;

procedure TSLEditor.BlinkCaret;
var
	pt: TPoint;
	curFocus: TFocus;
begin
  // 062411 JWyatt Add a check for a nil FCell in case there is no active cell
  //  Was: if FActive and not FCell.Disabled then
	if FActive and ((FCell = nil) or (not FCell.Disabled))then
		if (SelBeg = SelEnd) and not FCanSelect then
			if (Int64(GetTickCount) - FLastBlink >= Int64(GetCaretBlinkTime)) then
				begin
					GetViewFocus(FCanvas.Handle, curFocus);
					FocusOnCell;
					FCanvas.Pen.Width := 1;
					FCanvas.Pen.Color := clBlack;
					FCanvas.Pen.Mode := pmNot;			//	PenMode(PatXOR);
//					Pt := ScalePt(TxCaret, 1,1);	//cNormScale, Scale);
					Pt := TxCaret;
					FCanvas.MoveTo(Pt.x - 1, Pt.y);
					FCanvas.LineTo(Pt.x - 1, Pt.y-mulDiv(kCaretHeight, Scale, cNormScale));
					FCanvas.Pen.Mode := pmCopy;
					FLastBlink := GetTickCount;
					FCaretOn := not FCaretOn;
					SetViewFocus(FCanvas.handle, curFocus);
				end;
end;

procedure TSLEditor.ShowCaret;
var
  focus: TFocus;
  pt: TPoint;
begin
  GetViewFocus(FCanvas.Handle, focus);
  try
    FocusOnCell;
    // 062411 JWyatt Add a check for a nil FCell in case there is no active cell
    //  Was: if FActive and not FCell.Disabled then
    if FActive and ((FCell = nil) or (not FCell.Disabled)) then
      if (SelBeg = SelEnd) then
        begin
          FCanvas.Pen.Width := 1;
          FCanvas.Pen.Mode := pmNot;			//	PenMode(PatXOR);
          Pt := TxCaret;
          FCanvas.MoveTo(Pt.x - 1, Pt.y);
          FCanvas.LineTo(Pt.x - 1, Pt.y-mulDiv(kCaretHeight, Scale, cNormScale));
          FCanvas.Pen.Mode := pmCopy;
          FLastBlink := GetTickCount;
          FCaretOn := True;
        end;
  finally
    SetViewFocus(FCanvas.Handle, focus);
  end;
end;

procedure TSLEditor.IdleEditor;
begin
	If FActive and not TBaseCell(FCell).ParentViewPage.PgCollapsed then
		BlinkCaret;
end;

//this Draw and Display need to be pre-focused
procedure TSLEditor.DisplayCurCell;
begin
	inherited;

	if SelBeg <> SelEnd then     //do the hilighting
		ReInvertText
	 else
		SetCaret;
end;

procedure TSLEditor.DrawCurCell;
var
	sBox: TRect;
  overflowed: Boolean;
  curFocus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, curFocus);
  try
    FocusOnCell;
    FCanvas.Font.Assign(FFont);
    FCanvas.Font.size := MulDiv(FCanvas.Font.Size, scale, Fcanvas.Font.PixelsPerInch);
    overflowed := TextOverflowed;
    if overflowed and appPref_AutoFitTextToCell and not IsBitSet(FCellPrefs, bnotAutoFitTextTocell) then
      if CellFontToFitInBox(FCanvas, TxStr, ScaleRect(TxRect, cNormScale, scale)) then
        begin
          FFont.Size := MulDiv(FCanvas.Font.Size, Fcanvas.Font.PixelsPerInch, scale);  //unscale font: FFont stores unscaled font
          overflowed := TextOverflowed;
        end;
    FCellStatus := SetBit2Flag(FCellStatus, bOverflow, overflowed);

    FCanvas.Font.Color := GetTextColor(overflowed);
    FCanvas.Brush.color := FCell.Background;
    FCanvas.Brush.Style := bsSolid;
    FCanvas.FillRect(ScaleRect(FFrame, cNormScale, scale));
    sBox := ScaleRect(TxRect, cNormScale, scale);
    DrawString(FCanvas, sBox, TxStr, FTxJust, FALSE);  //false = Clip
    FCaretOn := False;
  finally
    SetViewFocus(FCanvas.Handle, curFocus);
  end;
end;

procedure TSLEditor.InvertText(S, F: TPoint);
var
  focus: TFocus;
	R: TRect;
	i, lnH: Integer;
begin
  GetViewFocus(FCanvas.Handle, focus);
  try
    FocusOnCell;
    with ScaleRect(TxRect, cNormScale, scale) do
      begin
        lnH := mulDiv(kLnHeight, scale, cNormScale);
        R.Top := Top + mulDiv(kLnHeight*(S.y-1), scale, cNormScale);
        R.Left := S.x;
        if S.y <> F.y then						// is there more than one line
          for i := S.y to F.y - 1 do
            begin
              R.Bottom := R.Top + lnH - 1;
              R.Right := Right;
              InvertRect(FCanvas.handle, R);
              R.Left := Left;
              R.Top := Top + mulDiv(kLnHeight*i, scale, cNormScale);
            end;
        R.Bottom := R.Top + lnH - 1;
        R.Right := F.x;
        InvertRect(FCanvas.handle, R);
      end;
  finally
    SetViewFocus(FCanvas.Handle, focus);
  end;
end;

procedure TSLEditor.ClearEdit;
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	if (SelEnd - SelBeg) > 0 then
		begin
			DeleteLnSel;          //delete and setup Undo
			SetCaret;

			FModified := True;
		end;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TSLEditor.CopyEdit;
var
	Count: Integer;
begin
	SetLength(UndoText, 0);                                  //not sure if this is thing to do?
	undoBeg := 0;
	undoEnd := 0;

	count := SelEnd - SelBeg;
	if count > 0 then
		begin
			ClipBoard.AsText := Copy(TxStr, SelBeg+1, Count);    //copy to clipboard
		end;
end;

procedure TSLEditor.CutEdit;
var
	Count: Integer;
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	count := SelEnd - SelBeg;
	if count > 0 then
		begin
			ClipBoard.AsText := Copy(TxStr, SelBeg+1, Count);    //copy to clipboard
			DeleteLnSel;                                        //delete and setup Undo
			SetCaret;
		end;
	FModified := True;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TSLEditor.PasteEdit;
var
	clpbrdTx: String;
begin
	if ClipBoard.HasFormat(CF_Text) then
		begin
			clpbrdTx := ClipBoard.AsText;          //get the clipboard text
			PasteText(clpbrdTx);                   //paste it in
		end
	else
		Beep;
end;

procedure TSLEditor.PasteText(theText: string);
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	ClearCR(theText);                     //NO returns in single line cell
	ClearLF(theText);
  ClearTabs(theText);
  InputString(theText);
	SetCaret;

	FModified := True;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TSLEditor.ClearUndo;
begin
	UndoBeg := 0;
	UndoEnd := 0;
	UndoText := '';
end;

procedure TSLEditor.UndoEdit;
var
	redoText: String;
	redoBeg, redoEnd: Integer;
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;

	EraseCaret;
  redoBeg := 0;
  redoEnd := 0;
	if undoBeg <> undoEnd then
		begin
			redoText := Copy(TxStr, undoBeg+1, undoEnd-undoBeg);        //save it for redo
			Delete(TxStr, undoBeg+1, undoEnd-undoBeg);                  //delete it
			redoBeg := undoBeg;                                          //equal, so we can insert on redo
			redoEnd := redoBeg;
			SelBeg := UndoBeg;
			SelEnd := SelBeg;
		end;

	if Length(UndoText) > 0 then                                     //do we have undo text?
		begin
			Insert(undoText, TxStr, undoBeg+1);                           //insert the previous undo text
			redoBeg := undoBeg;
			redoEnd := undoBeg+length(undoText);
			SelBeg := redoEnd;                                           //set caret at end
			SelEnd := SelBeg;
		end;

	undoText := redoText;                    //reset the undo's so we can redo
	undoBeg := redoBeg;
	undoEnd := redoEnd;

	FModified := True;
	NumChs := Length(TxStr);
	DrawCurCell;
	SetCaret;

	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TSLEditor.ReInvertText;
var
	A,B: Integer;
begin
	A := Get1LineWidth(SelBeg);
	B := GetTextWidth(FCanvas, TxStr, SelBeg+1, SelEnd);
	SelBegPt := Point(A, 1);
	SelEndPt := Point(SelBegPt.x + B, 1);
	InvertText(SelBegPt, SelEndPt);
end;

procedure TSLEditor.SelectAll;
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	if numChs > 0 then
		begin
			if SelBeg <> SelEnd then
				InvertText(SelBegPt, SelEndPt)
			else
				EraseCaret;

			SelBeg := 0;     		//Sel's are zero based
			SelEnd := numChs;
			ReInvertText;
		end;
	SetViewFocus(FCanvas.handle, curFocus);
end;

function TSLEditor.CanCopy: Boolean;
begin
	result := selBeg <> selEnd;
end;

function TSLEditor.CanCut: Boolean;
begin
	result := (selBeg <> selEnd) and FCanEdit;
end;

function TSLEditor.CanPaste: Boolean;
begin
	result := ClipBoard.HasFormat(CF_Text) and FCanEdit and not FAllowRspsOnly;
end;

function TSLEditor.CanClear: Boolean;
begin
	result := (selBeg <> selEnd) and FCanEdit;
end;

function TSLEditor.CanSelectAll: Boolean;
begin
  if assigned(FCell) then  //Pam: Needs to handle the case when FCell is nil
   	result := (length(TxStr) > 0) and not FCell.Disabled
  else
    result := (length(TxStr) > 0);
end;

function TSLEditor.CanSpellCheck: Boolean;
begin
  result := (length(TxStr) > 0) and not FAllowRspsOnly;    //dont spell check standardized words
end;

function TSLEditor.CanUndo: Boolean;
begin
	result := (UndoBeg <> UndoEnd) or (Length(UndoText) > 0);
end;

function TSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  result := inherited CanAcceptChar(key);
  if not result then    //if cannot accept, then test for Cntl-Enter
    if (Ord(Key)=VK_RETURN) and ControlKeyDown then
      result := True;
end;

function TSLEditor.CanFormatText: Boolean;
begin
  result := not FDoc.Locked;	//FCanEdit;
end;

function TSLEditor.GetFont: TCellFont;
begin
  Result := FFont;
end;

function TSLEditor.HasContents: Boolean;
begin
	result := length(TxStr) > 0;
end;

function TSLEditor.HasSelection: Boolean;
begin
	result := (selBeg <> selEnd);
end;



procedure TSLEditor.SaveChanges;
var
	Value: Double;
	cell: TBaseCell;
begin
  //encode the integers into bits in editor's CellPrefs
try
  FCellPrefs := SetBit2Flag(FCellPrefs, bTxJustLeft, FTxJust = tjJustLeft);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxJustCntr, FTxJust = tjJustMid);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxJustRight, FTxJust = tjJustRight);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxJustFull, FTxJust = tjJustFull);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxJustOffset, FTxJust = tjJustOffLeft);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxPlain, FFont.Style = []);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxBold, fsBold in FFont.Style);
	FCellPrefs := SetBit2Flag(FCellPrefs, bTxItalic, fsItalic in FFont.Style);
  FCellPrefs := SetBit2Flag(FCellPrefs, bTxUnderline, fsUnderline in FFont.Style);

	if FModified or FCellFmtChged then
		begin
      //save the cell contents if modified or reformatted
      cell := TBaseCell(FCell);
      cell.FCellPref := FCellPrefs;          //holds the prefs 31 flag bit
      cell.FCellFormat := FCellFormat;       //holds the formatting bits
      cell.FTxSize 	:= FFont.Size;           //save the changes to cell
      cell.FTxStyle := FFont.Style;
      cell.FTxJust 	:= FTxJust;
      cell.FCellStatus := FCellStatus;

 			if cell.Kind = cKindCalc then
				if (length(TxStr) > 0) and IsValidNumber(TxStr, Value) then      //set the value
					cell.SetValue(Value)
				else
          begin
					  Cell.DoSetText(TxStr)            //set a blank
          end
			else if cell.kind = cKindDate then
				if (length(TxStr) > 0) and IsValidDate(TxStr, TDateTime(value)) then
					begin
//            TxStr := FormatDate(DateVal, Cell.FCellFormat);
//            UpdateText(TxStr);
            TDateCell(cell).DoSetDate(value);
          end
				else begin
          Cell.CellValue := 0;
					Cell.DoSetText(TxStr);
        end
			else
					Cell.DoSetText(TxStr);						      //set text

      Cell.Modified := FModified or FCellFmtChged;       //set cell flag
			FModified := False;               //editor if fresh again
		end;

//did responses change
  if FRsps <> nil then
	  if FRsps.Modified then       //Save the responses if modified
		  FRsps.SaveItems;

  if FCellFmtChged then
    FCell.SetFormatModifiedFlag;
  FCellFmtChged := False;
except
end;
  ClearUndo;                     //we're committed to cell, no more undo's
end;



//saves the current text to local FRsps, not to AppRespones, thats late
procedure TSLEditor.SaveToRspList(Sender: TObject);
var
	RspStr: String;
begin
	if Length(TxStr) > 0 then
		begin
			RspStr := TxStr;                                    //copy the whole thing
			if SelBeg <> SelEnd then
				RspStr := copy(TxStr, selBeg+1, selEnd-SelBeg);   //or just the selected
			FRsps.AddRspItem(RspStr);                          //append it to rsp list

			if RspsVisible then
				begin
					FListRsps.Items.Add(RspStr);
				end;
		end;
end;

function TSLEditor.GetAnsiText: String;
begin
  Result := TxStr;
end;

function TSLEditor.GetSelectedText: String;
begin
  if (SelBeg <> SelEnd) then
    Result := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else
    Result := '';
end;

function TSLEditor.GetText: String;
begin
  Result := TxStr;
end;

procedure TSLEditor.SetText(const Value: String);
var
  curFocus: TFocus;
begin
  if FCanEdit then
    begin
      GetViewFocus(FCanvas.Handle, curFocus);
      try
        FocusOnCell;

        if SelBeg <> SelEnd then
          InvertText(SelBegPt, SelEndPt)
        else
          EraseCaret;

        UndoText := TxStr;
        UndoBeg := 0;
        UndoEnd := length(TxStr);

        TxStr := Value;
        SelBeg := Length(TxStr);
        SelEnd := SelBeg;
        NumChs := SelBeg;
        TxValue := 0;

        DrawCurCell;
        SetCaret;
      finally
        FModified := True;
        SetViewFocus(FCanvas.handle, curFocus);
      end;
  end;
end;

procedure TSLEditor.InputString(const Text: String);
var
  Input: String;
begin
  if FCanEdit then
    begin
      if FUpperCase then
        Input := UpperCase(Text)
      else
        Input := Text;

      UndoText := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg);
      UndoBeg := SelBeg;
      UndoEnd := UndoBeg + Length(Input);

      Delete(TxStr, SelBeg + 1, SelEnd - SelBeg);
      Insert(Input, TxStr, SelBeg + 1);

      FModified := True;
      NumChs := Length(TxStr);
      SelBeg := SelBeg + Length(Input);
      SelEnd := SelBeg;
      SetCaret;

      DrawCurCell;
    end;
end;

function TSLEditor.GetCaretPosition: Integer;
begin
  Result := SelEnd;
end;

procedure TSLEditor.SetCaretPosition(const Value: Integer);
var
  curFocus: TFocus;
begin
  if (NumChs > 0) then
    begin
      GetViewFocus(FCanvas.Handle, curFocus);
      try
        FocusOnCell;
        if (SelBeg <> SelEnd) then
          InvertText(SelBegPt, SelEndPt)
        else
          EraseCaret;

        if (Value < 0) then
          begin
            SelBeg := NumChs;
            SelEnd := SelBeg;
          end
        else
          begin
            SelBeg := Value;
            if (SelBeg > NumChs) then
              SelBeg := NumChs;
            SelEnd := SelBeg;
          end;
        SetCaret;
      finally
        SetViewFocus(FCanvas.Handle, curFocus);
      end;
    end;
end;

procedure TSLEditor.SelectText(const Start: Integer; const Length: Integer);
var
  curFocus: TFocus;
begin
  if (NumChs > 0) then
    begin
      GetViewFocus(FCanvas.Handle, curFocus);
      try
        FocusOnCell;
        if (SelBeg <> SelEnd) then
          InvertText(SelBegPt, SelEndPt)
        else
          EraseCaret;

        SelBeg := Start - 1;  // selection indexes are are zero based
        SelEnd := SelBeg + Length;
        ReInvertText;
      finally
        SetViewFocus(FCanvas.Handle, curFocus);
      end;
    end;
end;

// --- TDateSLEditor ----------------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TDateSLEditor.EnforcePreferences;
begin
  {FCellPrefs := SetBit2Flag(FCellPrefs, bCelDateOnly, True);
  FCellFormat := SetBit2Flag(FCellFormat, bDateMDY, True);}
end;

/// summary: Selects the closest matching auto-response item and enters it into the editor.
/// remarks: Disabled for numeric entry.
procedure TDateSLEditor.AutoSelectRspItem;
begin
  // do nothing
end;

/// summary: Processes input from the keyboard.
procedure TDateSLEditor.KeyEditor(var Key: Char);
begin
  {EnforcePreferences;}
  inherited;
end;

/// summary: Converts cell text to the standardized date format (mm/dd/yyyy).
procedure TDateSLEditor.SaveChanges;
var
  DateText: String;
  DateValue: TDateTime;
begin
  // parse and format date
  DateText := Text;
  if (DateText <> '') then
    begin
      if (DateText = '0') then
        Text := ''
      else
        begin
          if (FDoc As TContainer).UADEnabled then
            FCell.HasValidationError := UADDateFormatErr(FCell.FCellXID, CUADDateFormat, DateText)
          else
            FCell.HasValidationError := TextToDateEx(DateText, DateValue);  // dxExEdtr.pas
          Text := DateText;
        end;
    end
  else
    FCell.HasValidationError := False;

  inherited;
end;

// --- TNumericSLEditor -------------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TNumericSLEditor.EnforcePreferences;
begin
//  FCellPrefs := SetBit2Flag(FCellPrefs, bCelNumOnly, True);
//  FCellPrefs := SetBit2Flag(FCellPrefs, bCelFormat, True);
end;

/// summary: Filters a string for valid input characters and stops when
///          an invalid character is found.
function TNumericSLEditor.FilterText(const Text: String): String;
var
  Index: Integer;
begin
  Result := '';
  for Index := 1 to Length(Text) do
    begin
      if CanAcceptChar(Text[Index]) then
        Result := Result + Text[Index]
      else
        Break;
    end;
end;

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TNumericSLEditor.HasValidNumber: Boolean;
begin
  Result := True;
end;

/// summary: Selects the closest matching auto-response item and enters it into the editor.
/// remarks: Disabled for numeric entry.
procedure TNumericSLEditor.AutoSelectRspItem;
begin
  // do nothing
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TNumericSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  // backspace, comma, numbers 0 - 9, delete
  // 062411 JWyatt Add the SelEnd check to the plus/minus test.
  //  The SelBeg test alone introduces a problem where the cell
  //  can be is blanked after exiting and re-entering..very
  //  strange behavior.
  //   Was: if (Key in [#43, #45]) and (SelBeg = 0) then
  Result := Key in [#8, #43..#45, #48..#57, #127];
  if not Result then
    begin
      // only one decimal point allowed
      if (Key = #46) and (Pos('.', Text) = 0) then
        Result := True;
    end;
end;

/// summary: Processes input from the keyboard.
procedure TNumericSLEditor.KeyEditor(var Key: Char);
begin
  {EnforcePreferences;}
  inherited;
end;

/// summary: Inputs a character into the editor.
/// remarks: Enforces the number is always within valid range.
procedure TNumericSLEditor.InputChar(Ch: Char);
begin
  if (Ch = '.') and (Pos(Ch, Text) > 0) then
    // do nothing - prohibit two decimals in number
  else
    inherited;

  if not HasValidNumber then
    UndoEdit;
end;

/// summary: Inputs a string of text from the cursor insertion point.
/// remarks: Filters text for numeric input.
procedure TNumericSLEditor.InputString(const Text: String);
begin
  {EnforcePreferences;}
  inherited InputString(FilterText(Text));
  if not HasValidNumber then
    UndoEdit;
end;

/// summary: Sets the text of the editor.
/// remarks: Filters text for numeric input and enforces the number is always
///          within valid range.
procedure TNumericSLEditor.SetText(const Value: String);
begin
  {EnforcePreferences;}
  inherited SetText(FilterText(Value));
  if not HasValidNumber then
    UndoEdit;
end;

// --- TPositiveNumericSLEditor ----------------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveNumericSLEditor.HasValidNumber: Boolean;
begin
  Result := inherited HasValidNumber;
  Result := Result and (GetValue >= 0);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveNumericSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

// --- TDollarsNumericSLEditor ------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TDollarsNumericSLEditor.EnforcePreferences;
begin
//  inherited;
//  FCell.FCellFormat := SetBit(FCell.FCellFormat, bRnd1P2);
//  FCell.FCellFormat := SetBit2Flag(FCell.FCellFormat, bDisplayZero, True);
//  FCell.FCellFormat := SetBit2Flag(FCell.FCellFormat, bAddComma, True);
end;

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TDollarsNumericSLEditor.HasValidNumber: Boolean;
var
  Index: Integer;
begin
  Index := Pos('.', Text);
  Result := (Index = 0) or (Length(Text) <= Index + 2);
end;

// --- TPositiveDollarsNumericSLEditor ----------------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveDollarsNumericSLEditor.HasValidNumber: Boolean;
begin
  Result := inherited HasValidNumber;
  Result := Result and (GetValue >= 0);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveDollarsNumericSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

// --- TWholeNumericSLEditor --------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TWholeNumericSLEditor.EnforcePreferences;
begin
//  inherited;
//  FCellFormat := SetBit(FCellFormat, bRnd1);
//  FCellFormat := SetBit2Flag(FCellFormat, bDisplayZero, True);
//  FCellFormat := SetBit2Flag(FCellFormat, bAddComma, False);
//  FCellFormat := SetBit2Flag(FCellFormat, bAddPlus, False);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TWholeNumericSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  // 083111 JWyatt Following removed to allow entry of a decimal point - formatting on exit
  // Result := Result and not (Key = #46);  // not decimal
end;

// --- TPositiveWholeNumericSLEditor ------------------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveWholeNumericSLEditor.HasValidNumber: Boolean;
begin
  Result := inherited HasValidNumber;
  Result := Result and (GetValue >= 0);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveWholeNumericSLEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

// --- TPositiveWholePercentNumericSLEditor -----------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveWholePercentNumericSLEditor.HasValidNumber: Boolean;
var
  Value: Double;
begin
  Value := GetValue;
  Result := (Value >= 0) and (Value <= 100);
end;

// --- TPositiveWholeTenThousandsNumericSLEditor ------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveWholeTenThousandsNumericSLEditor.HasValidNumber: Boolean;
var
  Value: Double;
begin
  Value := GetValue;
  Result := (Value >= 0) and (Value <= 99999);
end;

{***********************************************}
{                                               }
{              TMLEditor 						}
{                                               }
{***********************************************}

procedure TMLEditor.OnFontChanged(Sender: TObject);
var
  focus: TFocus;
begin
  FCellFmtChged := True;
  FModified := True;
  
  GetViewFocus(FCanvas.Handle, focus);
  try
    FocusOnCell;
    CalcTextWrap;
    DisplayCurCell;
  finally
    SetViewFocus(FCanvas.handle, focus);
  end;
end;

procedure TMLEditor.OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  (FDoc as TContainer).OnKeyDown(Sender, Key, Shift);
  ListRspsKeyDown(Sender, Key, Shift);
end;

constructor TMLEditor.Create(AOwner: TAppraisalReport);
begin
	inherited Create(AOwner);

	NumLns := 0;      //will be set when the cell is loaded
	MaxLns := 0;
	CurLn := 0;       //index to lines, zero based
	TxIndent := 0;
end;

procedure TMLEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
	with TContainer(FDoc) do
		if cell <> nil then
		begin
			MaxLns := TMLnTextCell(cell).FMaxLines;          //max lines this cell can have
			TxIndent := TMLnTextCell(cell).FTxIndent;      	 //are we indented
      TxLine := copy(TMLnTextCell(cell).FTxLines, 0, length(TMLnTextCell(cell).FTxLines));   //### Refs FTxLines (no copy)
      NumLns := GetNumLines;
		end;

	inherited LoadCell(cell, cUID);
  FFont.OnChange := OnFontChanged;
end;

procedure TMLEditor.LoadCellRsps(Cell: TBaseCell; cUID:CellUID);
var
  group: TCommentGroup;
  container: TContainer;
begin
  inherited;
  FreeAndNil(FListRsps);
  container := (FDoc as TContainer);
  group := AppComments[FCell.FResponseID];
  if Assigned(group) then
    begin
      FListRsps := group.BuildCommenmtListBox(FDoc);
      FListRsps.OnClick := ListRspsClick;
      FListRsps.OnKeyDown := OnResponseKeyDown;
      FListRsps.OnKeyPress := Container.OnKeyPress;
    end;
end;

procedure TMLEditor.InsertComment(Cmt: String; ReplaceTx: Boolean);
var
	curFocus: TFocus;
begin
	ClearLF(Cmt);                         //strip any LF chars before displaying

	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;

	if SelBeg <> SelEnd then
		InvertText(SelBegPt, SelEndPt)			//unHilite previous
	else if SelBeg = SelEnd then          //or just erase the caret
		EraseCaret;

	if ReplaceTx then
		begin
			SelBeg := 0;                      //select all
			SelEnd := numChs;
			InputString(Cmt);               //replace with selected comment
		end
	else
		InputString(Cmt);                 //just insert text

	FModified := True;
  SetCaret;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.SelectedMenuCmt(Sender: TObject);
var
	S: String;
	replace: Boolean;
begin
	with Sender as TMenuItem do         	//dont care if main or submenu
    if Tag > -1 then
      begin
        S := AppComments[FCell.FResponseID].GetComment(Tag);  	//menu tag is index of comment to insert
        Replace := (numChs > 0) and ControlKeyDown;
        if not replace and (SelBeg <> 0) then
          S := ' ' + S;   //add a space to front of text so its spaced out
        InsertComment(S, Replace);
      end;

	TContainer(FDoc).docView.SetFocus;      //Reset Control focus to docView.
end;

procedure TMLEditor.BuildPopUpMenu;
var
	i: Integer;
	MI: TMenuItem;
  CmtGroup: TCommentGroup;
begin
  inherited;
  CmtGroup := AppComments[FCell.FResponseID];
  if Assigned(CmtGroup) then
    begin
      if (Length(TxStr) > 0) then
        begin
          MI := TMenuItem.Create(FPopupMenu);      //Save as comment
          MI.Caption := 'Save as Comment';
          MI.OnClick := SaveToRspList;
          FPopupMenu.Items.Add(MI);

          MI := TMenuItem.Create(FPopupMenu);       //divider
          MI.Caption := '-';
          FPopupMenu.Items.Add(MI);
        end;

        i := FPopupMenu.Items.Count;
        CmtGroup.BulidPopupCommentMenu(FPopupMenu);  //with latest list
        for i := Max(i, 0) to FPopupMenu.Items.Count - 1 do
          FPopupMenu.Items[i].OnClick := SelectedMenuCmt;
    end;
end;

procedure TMLEditor.SetPopupPoint(var Pt: TPoint);
begin
  Pt := FCell.Area2Doc(scalePt(Pt, scale, cNormScale));
  Pt := TDocView(FDocView).Doc2Client(Pt);
  Pt :=  TDocView(FDocView).ClientToScreen(Pt);
end;

procedure TMLEditor.InsertRspItem(Rsp: String; Index, Mode: Integer);
var
	S: String;
	replace: Boolean;
begin
  if index >  -1 then
    begin
      S := AppComments[FCell.FResponseID].GetComment(Index);  	//index of comment to insert
      Replace := (numChs > 0) and ControlKeyDown;
      if not replace and (SelBeg <> 0) then
        S := ' ' + S;   //add a space to front of text so its spaced out
      InsertComment(S, Replace);
    end;

	TContainer(FDoc).docView.SetFocus;      //Reset Control focus to docView.
end;

//expands the number of lines and inserts newLn at position LnIdx (0 based)
function TMLEditor.InsertHardLn (LnIdx, charIdx, retIdx: Integer): Integer;
var
	i: Integer;
begin
	result := curLn;

	i := length(TxLine);
	if (LnIdx > 0) {and (i < MaxLns)} then   //add as many lines as we need  (may be pasting in)
	begin
		inc(i);
		SetLength(TxLine, i);        					//add an empty slot at end
		numLns := length(TxLine);							//reset the line counter

		if LnIdx < (numLns -1)then               //if inserting in middle...
			for i := numLns-1 downto LnIdx do   	 //shift all the slots down  (index is 0 based)
				TxLine[i] := TxLine[i-1];

		TxLine[LnIdx-1].lstChIdx := charIdx;    	//terminate prev line at this index, may be 0 for no chars on line

		TxLine[LnIdx].retChIdx := retIdx;         //ch index where return is located, may be 0 if no return
		TxLine[LnIdx].fstChIdx := 0;      			 	//new line starting here
		TxLine[LnIdx].lstChIdx := 0;

		result := LnIdx;           							//index to current line index
	end;
end;

//delete the line Ln (1 based)
procedure TMLEditor.DeleteHardLn (LnIdx: Integer);
var
	n, Z: integer;
begin
	Z := Length(TxLine);
	if (LnIdx > 0) and (LnIdx < Z-1) then 	//cannot delete the last line
		for n := LnIdx to Z-1 do           		//shift all up if we are not last line
			TxLine[n] := TxLine[n+1];

	Setlength(TxLine, Z-1);           			//set new count for TxLine
	numLns := length(TxLine);								//reset the line counter
end;

function FindNextCharPos(S: PChar; Ch: Char; startPos: Integer): Integer;
var
	strOffset, FoundStr: PChar;
begin
	Result := 0;
	if (S <> nil) and (ch <> #0) and (startPos < Int64(StrLen(S))) then
	begin
		strOffset := PChar(Cardinal(S) + Cardinal(startPos));
		FoundStr := StrPos(strOffset, PChar(ch));
		if FoundStr <> nil then
			Result := (Cardinal(Length(S)) - StrLen(FoundStr)) + 1
		else
			Result := 0;
	end;
end; // this method will recalc all the line starts for the text

//procedure CalcTextWrap(TxStr: String; TxRect: TRect; TxIndent: Integer; var TxLine: LineStarts);
procedure TMLEditor.CalcTextWrap;
var
	RemainerFits, LeftSide, trailingSpaces: Boolean;
	ChrIndex, StartLnChr, LastLnChr, BreakChr, LstNonSpaceChr: Integer;
	TLen, LnLen, LineId, RightSide, LeftSideOffset: Integer;
	fstChWrd, lstChWrd: Integer;
	LnStarted : Boolean;
begin
  FCanvas.Font.Assign(FFont);
	FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);

	numLns := 1;
	numChs := Length(TxStr);             //reset to one
 	SetLength(TxLine, 1);

// A. find all hard lines made with Return
	LineId := 0;
	LnStarted := False;

	TxLine[LineId].fstChIdx := 0;           //init first line, no chars yet
	TxLine[LineId].lstChIdx := 0;
	if numChs > 0 then
		begin
			for chrIndex := 1 to length(TxStr) do
				if (TxStr[ChrIndex] = chr(kReturnKey)) then    //need new line
					begin
						if lineID < MaxLns then                   //if we can have another line
						begin
							inc(LineID);
							if not LnStarted then
								InsertHardLn(lineID, 0, chrIndex)     //blank line, no chars
							else
								InsertHardLn(lineID, chrIndex-1, chrIndex);     //terminate before return
							LnStarted := False;
						end;
					end
				else                                          //reg char, add to cur line
					begin
						if not LnStarted then
							begin
								TxLine[LineId].fstChIdx := chrIndex;  //set the first index once
								LnStarted := True;
							end;
						TxLine[lineId].lstChIdx := chrIndex;      //set the last char index
					end;

//  B. Find all word wrap soft lines

			numLns := GetNumLines;
			LeftSideOffset := TxRect.Left + TxIndent;						//is it indented
			RightSide := MulDiv(TxRect.right, scale, cNormScale);
			LineId := 0;
			while (LineId < numLns) do
				begin
					LeftSideOffset := MulDiv(LeftSideOffset, scale, cNormScale);
					StartLnChr := TxLine[LineId].fstChIdx;                     											//char indexes
					LastLnChr := TxLine[LineId].lstChIdx;
          // trim trailing spaces
          LstNonSpaceChr := LastLnChr;
          while LstNonSpaceChr > StartLnChr do
            if  ValidWordBreakChar(TxStr[LstNonSpaceChr]) then
              dec(LstNonSpaceChr)
            else
              break;
          If LastLnChr > StartLnChr then         //skip if line if empty (last=first char)
            if LeftSideOffset + TextWidth(StartLnChr-1, LstNonSpaceChr-1) > RightSide then 		//line is too long}
              begin
                trailingSpaces := False;																			//does a line end in 1 or more spaces}
                remainerFits := False;																				//lets assume that it does not fit
                repeat                                                        //break this line into little lines
                  TLen := LastLnChr - StartLnChr +1;
                  LnLen := RightSide - LeftSideOffset;
                  ChrIndex := Pixel2Char(StartLnChr-1, TLen, LnLen, LeftSide);   	//find char at edge
                  chrIndex := chrIndex + StartLnChr-1;                           	//relative to Text beginning
                  FindWord(StartLnChr, LastLnChr, ChrIndex, fstChWrd, lstChWrd); //the word at edge
                  if fstChWrd = StartLnChr then					// Encountered continous string of chars
                    begin
                      if not LeftSide and (ChrIndex > StartLnChr) then
                        ChrIndex := ChrIndex - 1;				 //make sure we're on left
                      BreakChr := ChrIndex;							 //this char goes on next line
                    end
                  else 												 //Able to break on a word, find the word
                    begin
                      BreakChr := fstChWrd;
                (*
                //added special code in FindWord and reoved this code
                //to handle crash if too many spaces at the end of line
                
                      if TxStr[breakChr] = char(kSpaceKey) then      //check special case where break is a space
                        begin
                          spChr := breakChr;
                          while (spChr <= LastLnChr) and (TxStr[spChr] = char(kSpaceKey)) do   //find a first non-space char
                            spChr := spChr + 1;

                          BreakChr := spChr;
                          if (BreakChr = LastLnChr) then        //did not find any
                            begin
                              trailingSpaces := True;           //signal no need for another line
                              RemainerFits := True;
                            end;
                        end;
                *)
                    end;

                  if not trailingSpaces then
                    begin
                      Inc(LineID);
                      InsertHardLn(LineId, BreakChr-1, 0);   // note that numLns gets reset here
                      TxLine[lineID].fstChIdx := BreakChr;   //set the new line
                      TxLine[lineID].lstChIdx := LastLnChr;
                      StartLnChr := BreakChr;
                      LeftSideOffset := MulDiv(TxRect.Left, scale, cNormScale);
                      RemainerFits := LeftSideOffset + TextWidth(StartLnChr, LastLnChr) <= RightSide;
                    end;

                until RemainerFits;
              end;  														//if line too long

					inc(LineId);
					LeftSideOffset := TxRect.Left;     	//un-indent
				end;	{while}
		end;	//if numChs > 0)
end;
Function TMLEditor.TextWidth(chStart, chLast: Integer): Integer;
var
	strWidth: TSize;
begin
  GetTextExtentExPoint(FCanvas.Handle, StrPtrOffset(TxStr, chStart), chLast-chStart+1, 0,nil,nil, strWidth);
	result := strWidth.cx;
end;

Function TMLEditor.Pixel2Char(chStart, chLen, PixelPos: Integer; var LeftSide: Boolean): Integer;
var
	chCount, x: Integer;								//count of characters up to one that hits PixelPos
	strWidth, chrWidth: TSize;        	//total szie of text
	ChExtent: Array of Integer;     		//char extents totaling up to chIndex
begin
	SetLength(ChExtent, chLen);
//	GetTextExtentExPoint(FDCHdl, StrPtrOffset(TxStr, chStart), chLen, PixelPos, PInteger(@chCount), PInteger(ChExtent), strWidth);
	GetTextExtentExPoint(FCanvas.handle, StrPtrOffset(TxStr, chStart), chLen, PixelPos, PInteger(@chCount), PInteger(ChExtent), strWidth);

	if PixelPos = chExtent[chCount-1] then			//char falls right at edge
		begin
			if ChCount < chLen then                	//there are more chars
				begin
					result := chCount+1;                  //send back the one on the right
//					testStr := TxStr[chstart+chcount+1];
					leftside := True;
				end
			else                                   	//char is at end of string
				begin
					result := chCount;
//					testStr := TxStr[chStart+chcount];
					leftSide := False;                  //put caret on left of char
				end;
		end
	else if (PixelPos > chExtent[chCount-1]) then     //a full char could not fit
		begin
			if (chCount < chLen) then                     //pixel is on a char
				begin
//          GetTextExtentPoint32(FDCHdl, StrPtrOffset(TxStr, chStart+chCount+1), 1, chrWidth);
					GetTextExtentPoint32(FCanvas.handle, StrPtrOffset(TxStr, chStart+chCount+1), 1, chrWidth);
					x := chExtent[chCount-1] + chrWidth.cx div 2;
					if PixelPos <= x then
						Leftside := True
					else
						LeftSide := False;
//					testStr := TxStr[chstart+chcount+1];
					result := chCount + 1;
				end
			else     // chCount = chLen (cannot be >) so nearest char is last char
				begin
					result := chCount;
//					testStr := TxStr[chstart+chcount];
					LeftSide := False;
				end;
		end
	else   // this case should never happen
		begin
			result := chCount;
			LeftSide := True;
		end;
end;
(*
function IsValidWordChar(ch: Char): Boolean;
const
	Alpha = ['A'..'Z', 'a'..'z', '_'];
	AlphaPeriod := Alpha + '.';
var
	I: Integer;
begin
	result := ch in Alpha;
end;
*)
Procedure TMLEditor.FindWord(chStart, chEnd, chPos: Integer; var fstChWrd, lstChWrd: Integer);
var
	n: Integer;
begin
	if (chStart > 0) and (chPos > 0) and (chPos <= chEnd) then
		begin
			//search to the left for word break
			n := chPos;
			fstChWrd := n;

      //if the last char on the first unfitted line is a space. Let's find the first non space char
      while n < chEnd do
        if  ValidWordBreakChar(TxStr[n]) then
          inc(n)
        else
          break;

			while (n >= chStart) and not ValidWordBreakChar(TxStr[n]) do      //find first break on left
				begin
					fstChWrd := n;         //first character of word
					dec(n);                //move back until we find a space
				end;
      //search to the right for word break
			n := chPos;
			lstChWrd := n;
			while (n <= chEnd) and not ValidWordBreakChar(TxStr[n]) do     //find first break on right
				begin
					lstChWrd := n;         //last character of word
					inc(n);                //move forward until we find a space
				end;
		end;
end;

Function TMLEditor.GetLineWidth (LnIdx, ChPos: Integer): Integer;
var
	S, W: Integer;
	strWidth: TSize;
begin
	strWidth.cx := 0;
	if (ChPos > 0) and (TxLine[LnIdx].fstChIdx <> 0) then       //we have chars in the line
		begin
			S := TxLine[LnIdx].fstChIdx -1;       //zero based
			if ChPos > S then
				GetTextExtentPoint32(FCanvas.Handle, StrPtrOffset(TxStr, S), ChPos-S, strWidth);
		end;
	W := mulDiv(TxRect.Left, scale, cNormScale);
	if LnIdx = 0 then                 //LnIdx is zero based
		W := W + MulDiv(TxIndent, scale, cNormScale);
	result := W + strWidth.cx;
end;
(*
//what is first char index for line Ln.
Function TMLEditor.GetNextIndex(Ln: Integer); Integer;
begin
	if Ln > 0 then
		result := TxLine[Ln-1].lstChIdx;
	else
		result := 1;
end;
*)
Function TMLEditor.GetNumLines: Integer;
begin
	result := Length(TxLine);       	//how big is the array
end;

//ChPos is zero based, it generally equals SelBeg
Function TMLEditor.GetCurLine(chPos: Integer): Integer;
var
	i: Integer;
	foundit: Boolean;
begin
  numLns := GetNumLines;            //set the global numLns.
  if (numLns <> 0) then
    begin
      i := 0;
      repeat
        with TxLine[i] do
          begin
            foundIt := (chPos = 0);         //its the first line

            if fstChIdx > 0 then                                          //check inside the line
              foundIt := (fstChIdx-1 <= ChPos) and (ChPos <= lstChIdx)    //-1 cause chPos is 0 based
                                                                          //chPos can be on right of last char
            else if retChIdx > 0 then 	 				//we have a hard return
              foundIt := (retChIdx = chPos);    //no additional chars so chPos has to = return
          end;
        inc(i);                     //inc to next line
      until foundIt or (i = numLns);
      result := i-1;       //dec cause auto inc'ed; curLn is 0 based
    end
  else
    Result := 0;
end;

procedure TMLEditor.DisplayCurCell;
begin
	DisplayCom(0);

	if SelBeg <> SelEnd then     //if we were hilighted, rehilight
		ReInvertText
	else
		SetCaret;
end;

procedure TMLEditor.DrawCurCell;
begin
	DisplayCom(0);		//display the full cell. called by Page when painting
end;

procedure TMLEditor.CheckTextOverFlow;
var
  Overflowed: Boolean;
begin
  overFlowed := MaxLns < Length(TxLine);
  FCellStatus := SetBit2Flag(FCellStatus, bOverflow, overflowed);
end;

function TMLEditor.TextOverflowed: Boolean;
begin
  result := MaxLns < Length(TxLine);
end;

Procedure TMLEditor.DisplayCom(LnIdx: Integer);
var
  FormatFlags: Integer;
  i: Integer;
  Indent: Integer;
  CellFrame, TextFrame, zR: TRect;
  Overflowed: Boolean;
  curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
  try
    FocusOnCell;
    if LnIdx < 0 then            //make sure we don't try to draw a line above cell
      LnIdx := 0;

  FCanvas.Font.Assign(FFont);
  FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);

  //we need to redraw if TextOverFlow has been eliminated, check it here
  overflowed := TextOverflowed;
  if overflowed or (not overflowed and IsBitSet(FCellStatus, bOverflow)) then LnIdx := 0;    //redraw all lines
  FCellStatus := SetBit2Flag(FCellStatus, bOverflow, overflowed);
  FCanvas.Font.Color := GetTextColor(overflowed);
  FCanvas.Brush.color := FCell.Background;
  FCanvas.Brush.Style := bsSolid;
  FormatFlags := DT_BOTTOM + DT_SINGLELINE + DT_LEFT + DT_NOPREFIX {+ DT_NOCLIP};

  if (LnIdx >= 0) and (LnIdx < MaxLns) then   	//draw from this line down
    begin
      if (LnIdx = 0) then
        Indent := TxIndent
      else
        Indent := 0;

      CellFrame.Left := FFrame.Left + Indent;
      CellFrame.Top := FFrame.Top + LnIdx * kLnHeight;
      CellFrame.Right := FFrame.Right;
      CellFrame.Bottom := CellFrame.Top + kLnHeight - 1;
      TextFrame.Left := TxRect.Left + Indent;
      TextFrame.Top := TxRect.Top + LnIdx * kLnHeight;
      TextFrame.Right := TxRect.Right;
      TextFrame.Bottom := TextFrame.Top + kLnHeight - 1;

      for i := LnIdx to MaxLns-1 do
        begin
          zR := ScaleRect(CellFrame, cNormScale, scale);
          FCanvas.Brush.Style := bsSolid;
          FCanvas.FillRect(zR); //need to erase

          zR := ScaleRect(TextFrame, cNormScale, scale);
          if i < numLns then                        //but maybe not draw
            with TxLine[i] do
              if fstChIdx > 0 then                  //check for empty lines
                DrawText(FCanvas.handle, StrPtrOffset(TxStr, fstChIdx-1), lstChIdx-fstChIdx+1, zR, FormatFlags);

          CellFrame.Left := FFrame.Left;
          CellFrame.Top := CellFrame.Top + kLnHeight;
          CellFrame.Bottom := CellFrame.Bottom + kLnHeight;
          TextFrame.Left := TxRect.Left;
          TextFrame.Top := TextFrame.Top + kLnHeight;
          TextFrame.Bottom := TextFrame.Bottom + kLnHeight;
        end;
    end;
    FCaretOn := False;
  finally
    SetViewFocus(FCanvas.Handle, curFocus);
  end;
end;

procedure TMLEditor.InitCaret(Clicked: Boolean);
begin
	if NumChs > 0 {and not clicked} then
		begin
			//place caret at end of text
			CurLn := 0;
			SelBeg := 0;
			SelEnd := 0;
			SetCaret;
			SelBegPt := Point(TxCaret.x, 1);
			SelEndPt := Point(TxCaret.x, 1);
		end
	else       //no text in cell, place caret at beginning
		begin
			CurLn := 0;
			SelBeg := 0;
			SelEnd := 0;
			SetCaret;
			SelBegPt := Point(TxCaret.x, 1);
			SelEndPt := Point(TxCaret.x, 1);
		end;
end;

Procedure TMLEditor.DeleteComSel;
begin
	UndoText := Copy(TxStr, SelBeg+1, SelEnd-SelBeg);  //save what we are deleting}
	UndoBeg := SelBeg;
	UndoEnd := UndoBeg;
	Delete(TxStr, SelBeg+1, SelEnd-SelBeg);            //delete it
	SelBeg := UndoBeg;
	SelEnd := SelBeg;
	CalcTextWrap;                                   //recalc
	curLn := GetCurLine(SelBeg);
	DisplayCom(CurLn);                              //display from curLn down
end;

//forward delete
procedure TMLEditor.DeleteForwardLnChar;
var
	OldCurLn: Integer;
begin
	if (NumChs > 0) and (SelBeg < numChs) then
		begin
			EraseCaret;
			UndoText := Copy(TxStr, SelBeg+1, 1);					{save what we are deleting}
			UndoBeg := SelBeg;
			UndoEnd := UndoBeg;
			Delete(TxStr, SelBeg+1, 1);
			NumChs := Length(TxStr);
			OldCurLn := curLn;								//save line we were on}
			CalcTextWrap;
			DisplayCom(OldCurLn - 2);         //redisplay
		end;
end;

//backward delete
Procedure TMLEditor.DeleteComChar;
var
	OldCurLn: Integer;
begin
	if (NumChs > 0) and (SelBeg > 0) then
		begin
			EraseCaret;
			UndoText := Copy(TxStr, SelBeg, 1);  //save what we are deleting: 1 char}
			UndoBeg := SelBeg-1;
			UndoEnd := UndoBeg;
			Delete(TxStr, SelBeg, 1);              //delete from string
			SelBeg := UndoBeg;
			SelEnd := SelBeg;
			NumChs := Length(TxStr);               //this is what we have left, now display

			//Deleted from middle
			if SelBeg < numChs then
				begin
					OldCurLn := curLn;								//save line we were on}
					CalcTextWrap;
					DisplayCom(OldCurLn - 2);         //redisplay
				end

			//Deleted from EOText
			else
				begin
        (*
					if TxLine[curLn].lstChIdx > 0 then       //deleted the last char in the line
						begin
							dec(TxLine[curLn].lstChIdx);
							if TxLine[curLn].fstChIdx > TxLine[curLn].lstChIdx then    //all chars are gone
								if TxLine[curLn].lstChIdx = TxLine[curLn].retChIdx then  //has a hard return
									begin
										TxLine[curLn].fstChIdx := 0;       	 //hard, so leave until they delete the return
										TxLine[curLn].lstChIdx := 0;
									end
								else                                    //else delete soft line
									DeleteHardLn(curLn);
						end
					else if TxLine[curLn].lstChIdx = 0 then  //last char previously deleted, delete line holder
						DeleteHardLn(curLn);
          *)
          CalcTextWrap;
					curLn := GetCurLine(SelBeg);      //get the cur line
					DisplayCom(curLn);
				end;
		end;
end;

procedure TMLEditor.InputChar(Ch: Char);
var
  Input: String;
begin
  if FUpperCase then
    Input := UpperCase(Ch)
  else
    Input := Ch;

  EraseCaret;
  if (SelBeg <> SelEnd) then
    UndoText := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    UndoText := Copy(TxStr, SelBeg + 1, Length(Input));
  UndoBeg := SelBeg;
  UndoEnd := UndoBeg + Length(Input);

  if (SelBeg <> SelEnd) then
    Delete(TxStr, SelBeg + 1, SelEnd - SelBeg)
  else if KeyOverWriteMode then
    Delete(TxStr, SelBeg + 1, Length(Input));
  Insert(Input, TxStr, SelBeg + 1);

  FModified := True;
  NumChs := Length(TxStr);
  SelBeg := SelBeg + Length(Input);
  SelEnd := SelBeg;

  CalcTextWrap;
  DisplayCom(0);
end;

procedure TMLEditor.KeyEditor(var Key: Char);
var
	OKey: Integer;
	Pt: TPoint;
	curFocus: TFocus;
begin
	if FActive and FCanEdit and CanAcceptChar(Key) and TBaseCell(FCell).DisplayIsOpen(True) then
	begin
		Pt := TBaseCell(FCell).Caret2View(TxCaret);				//special to convert view pt to doc
		TContainer(FDoc).MakePtVisible(Pt);                  //make it visible

		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;                                         //now focus

		UndoText := '';
		undoBeg := 0;
		undoEnd := 0;

		OKey := ord(Key);
		if (OKey = kBkSpace) or (OKey = kClearKey) or (OKey = kDeleteKey) then			{control chars}
			begin										{multi line entry}
				if SelBeg <> SelEnd then
					DeleteComSel
				else if (OKey = kDeleteKey) then
					DeleteForwardLnChar
				else
					DeleteComChar;
			end

		else
      InputChar(Key);

		SetCaret;

		SetViewFocus(FCanvas.handle, curFocus);
		FModified := True;
	end;

	Key := #0;            //we handled the key
end;

procedure TMLEditor.CalcCaretPos;
var
  y: Integer;
  textRight, cellRight: Integer;
begin
  //Let's keep the caret always visible even if text is going out of line limit.
  //It can happen if we have space at the end of line
  EraseCaret;
  CurLn := GetCurLine(SelBeg);
  textRight := GetLineWidth(CurLn, SelBeg);
  cellRight := mulDiv(TxRect.Right, scale, cNormScale);
	if textRight > cellRight then
    TxCaret.X := cellRight
  else
    txCaret.X := textRight+1;
	y := MulDiv(TxRect.top, scale, cNormScale);
	TxCaret.y := y - 2 + MulDiv(kLnHeight*(CurLn+1), scale, cNormScale);
end;

procedure TMLEditor.SetCaret;
begin
  CalcCaretPos;
  ShowCaret;           //show in changed position
end;

procedure TMLEditor.SetClickCaret(ClickPt: TPoint);
var
	C, y, Ln: Integer;
begin
	MakePtValid(TxRect, numLns, ClickPt, Ln, scale);       //find the line
	C := GetClickPosition(Ln, ClickPt.x, SelBeg);          //find the char & pixel position
	y := MulDiv(TxRect.top, scale, cNormScale);
	TxCaret := Point(C, y -2 + MulDiv(kLnHeight*(Ln+1),scale, cNormScale));
	SelEnd := SelBeg;
	curLn := Ln;

	ShowCaret;                   //redisplay where new click is

	FCanSelect := True;          //get ready to select if user drag
	SelBegPt := Point(C, CurLn+1);
	SelEndPt := SelBegPt;
end;

Procedure TMLEditor.UndoEdit;
var
	redoText: String;
	redoBeg, redoEnd: Integer;
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOncell;
	EraseCaret;
  redoBeg := 0;
  redoEnd := 0;
	if undoBeg <> undoEnd then
		begin
			redoText := Copy(TxStr, undoBeg+1, undoEnd-undoBeg);        //save it for redo
			Delete(TxStr, undoBeg+1, undoEnd-undoBeg);                  //delete it
			redoBeg := undoBeg;                                        //equal, so we can insert on redo
			redoEnd := redoBeg;
			SelBeg := UndoBeg;
			SelEnd := SelBeg;
		end;

	if Length(UndoText) > 0 then                                     //do we have undo text?
		begin
			Insert(undoText, TxStr, undoBeg+1);                           //insert the previous undo text
			redoBeg := undoBeg;
			redoEnd := undoBeg+length(undoText);
			SelBeg := redoEnd;                                           //set caret at end
			SelEnd := SelBeg;
		end;

	undoText := redoText;                    //reset the undo's so we can redo
	undoBeg := redoBeg;
	undoEnd := redoEnd;

	FModified := True;
	CalcTextWrap;                   //just redo entire wordwrap
	DisplayCom(0);                  //and display it
	SetCaret;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.CutEdit;
var
	Count: Integer;
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	count := SelEnd - SelBeg;
	if count > 0 then
		begin
			ClipBoard.AsText := Copy(TxStr, SelBeg+1, Count);    //copy to clipboard
			DeleteComSel;                                        //delete and setup Undo
			SetCaret;
		end;
	FModified := True;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.PasteText(theText: string);
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOncell;
	ClearLF(theText);
  ClearTabs(theText);
  InputString(theText);
	SetCaret;

	FModified := True;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.ClearEdit;
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	if (SelEnd - SelBeg) > 0 then
		begin
			DeleteComSel;          //delete and setup Undo
			SetCaret;
			FModified := True;
		end;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.ReInvertText;
//var
//	A,B: Integer;
begin
	SelBegPt.x := GetLineWidth (SelBegPt.y-1, SelBeg);
	SelEndPt.x := GetLineWidth (SelEndPt.y-1, SelEnd);
//	A := Get1LineWidth(SelBeg);
//	B := GetTextWidth(FCanvas, Text, SelBeg+1, SelEnd);
//	SelBegPt := Point(A, 1);
//	SelEndPt := Point(SelBegPt.x + B, 1);
	InvertText(SelBegPt, SelEndPt);
end;

procedure TMLEditor.SelectAll;
var
	Ln: Integer;
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	if numChs > 0 then
		begin
			if SelBeg <> SelEnd then
				InvertText(SelBegPt, SelEndPt)			//unHilite previous}
			else if SelBeg = SelEnd then          //or just erase the caret
				EraseCaret;

			SelBeg := 0;                          //select all
			SelEnd := numChs;

			SelBegPt := Point(GetLineWidth(0,0),1);
//			Ln := GetCurLine(numChs);             //this is not curline, its line with last char in it
      Ln := GetNumLines-1;      //needs to be zero based
			SelEndPt := Point(GetLineWidth(Ln,numChs), Ln+1);

			InvertText(SelBegPt, SelEndPt);
		end;
	SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TMLEditor.SaveChanges;
var
	cell: TMLnTextCell;
begin
	if FModified  or FCellFmtChged then
		begin
			cell := TMLnTextCell(FCell);
			cell.DoSetText(TxStr);				    //set text
      cell.Modified := FModified;
      cell.FTxLines := copy(TxLine,0,length(TXLine));
    end;

  inherited SaveChanges;       //save prefs and formats
  ClearUndo;                   //clear the undos
(*
			cell.FTxSize 	:= TxSize;          //save the format
			cell.FTxJust 	:= TxJust;
			cell.FTxStyle := TxStyle;
      cell.FCellStatus := FCellStatus;  //save the status

			FModified := False;
		end;
*)
end;

procedure TMLEditor.SaveToRspList(Sender: TObject);
var
	CmtStr: String;
begin
	if Length(TxStr) > 0 then
		begin
			CmtStr := TxStr;                                    //copy the whole thing
			if SelBeg <> SelEnd then
				CmtStr := copy(TxStr, selBeg+1, selEnd-SelBeg);   //or just the selected

			EditCmts := TEditCmts.Create(FDoc);
      try
        EditCmts.LoadCommentGroup(FCell.FResponseID);  								 //load them all
			  EditCmts.LoadCurComment(CmtStr);                   //load the current comment
			  if (EditCmts.ShowModal = mrOK) then                //edit them
				  if EditCmts.Modified then
					  EditCmts.SaveCommentGroup;
      finally
        FreeAndNil(EditCmts);
			end;
		end;
end;

procedure TMLEditor.ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	inherited;    //do what TSLEditor does
end;

procedure TMLEditor.ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
	Pt, newPt: TPoint;
	Ln: Integer;
begin
	if FActive and FCanSelect and (ssLeft in Shift) then
	begin
		if FCaretOn then
			EraseCaret;

		Pt := Point(X, Y);
		MakePtValid(TxRect, numLns, Pt, Ln, scale);    //place pt in rect, even when it goes outside
//		TContainer(FDoc).MakePtVisible(Pt);                 //now make sure we can see it
		NewPt := Point(GetClickPosition(Ln, Pt.x, SelEnd), Ln+1);     //align on char boundries

		if not EqualPts(NewPt, SelEndPt) then
			begin
				if (SelEndPt.y = NewPt.y) then			{select on same line}
					begin
						if (SelEndPt.x > NewPt.x) then
							InvertText(NewPt, SelEndPt)
						else if (SelEndPt.x < NewPt.x) then
							InvertText(SelEndPt, NewPt);
					end
				else if (SelEndPt.y > NewPt.y) then		{select to line above}
					InvertText(NewPt, SelEndPt)
				else if (SelEndPt.y < NewPt.y) then		{select to line below}
					InvertText(SelEndPt, NewPt);
				SelEndPt := NewPt;
			end;
	end;
end;


(*
function ValidCh (Tx: Handle; maxCh, minCh, N: Integer): Boolean;
begin
	if (N < minCh) | (N >= MaxCh) then
		ValidCh := false
	else
		ValidCh := (CharsHandle(Tx)^^[N] in ['*', '0'..'9', 'A'..'Z', 'a'..'z', '.']);
end; *)


Function TMLEditor.GetClickPosition(Ln, dx: Integer; var Ch: Integer): Integer;
var
	i, S, L, X, txLen, chCount: Integer;
	strWidth: TSize;
	ChExtent: Array of Integer;     //char extents array
begin
	S := TxLine[Ln].fstChIdx;         //first char index in line Ln
	L := TxLine[Ln].lstChIdx;         //last char index
	X := TxRect.Left;
	if Ln = 0 then
		X := X + TxIndent;
	X := MulDiv(X, scale, cNormScale);

  txLen := 0;
	if S > 0 then                  //make sure we have chars on the line
    txLen := L-S+1;              //YF 03.14.03

  if (S > 0) and (txLen > 0) then
    begin
			SetLength(ChExtent, txLen);
	    FCanvas.Font.Assign(FFont);
	    FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);
			GetTextExtentExPoint(FCanvas.handle, StrPtrOffset(TxStr, S-1), txLen, 2000, PInteger(@chCount), PInteger(ChExtent), strWidth);

			if dx < X + ChExtent[0] div 2 then
				begin
					ch := S-1;
					result := X;
				end
			else if dx >= X + ChExtent[chCount-1] then
				begin
					ch := L;
					result := X + ChExtent[chCount-1];
				end
			else
				begin
					i := 0;                 //start + text extent + half next char < dx
					while (X + ChExtent[i] + ((ChExtent[i+1]-ChExtent[i]) div 2) < dx) and (i < chCount - 1) do
						i := i + 1;
					result := X + ChExtent[i];           //this is the new point.x
					Ch := S+i;                           //this is the char closest to X
				end;
		end

	else        //don't have any chars, put at beginning of line
		begin     //this has to be hard Return empty line, so SelBeg is index of Ret.
			result := X;
			ch := TxLine[Ln].retChIdx;
		end;
end;

procedure TMLEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
	A, B, Ln, fstWrd, lstWrd: Integer;
	curFocus: TFocus;
begin
  if (Button = mbRight) then
    RightClickEditor(ClickPt, Button, Shift)  //for showing popUp

	else if numChs > 0 then
		begin
			GetViewFocus(FCanvas.Handle, curFocus);
			FocusOnCell;
			FCanvas.Font.Assign(FFont);						//set font params
      FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);

			if SelBeg <> SelEnd then
				InvertText(SelBegPt, SelEndPt)			//unHilite previous}
			else if SelBeg = SelEnd then          //just erase the caret
				EraseCaret;

			If ssDouble in shift then 			//this is a double click
				begin
					MakePtValid(TxRect, numLns, ClickPt, Ln, scale);            //find the line
					if (Ln < Length(TxLine)) and  (TxLine[ln].fstChIdx > 0) then  //the valid not empty line
						begin
							GetWordBoundary(TxStr, TxLine[ln].fstChIdx, TxLine[ln].lstChIdx, SelBeg, fstWrd, lstWrd);   //find the word
							SelBeg := fstWrd-1;     //Sel's are zero based
							SelEnd := lstWrd;
							A := GetLineWidth (Ln, SelBeg);
							B := GetTextWidth(FCanvas, TxStr, fstWrd, lstWrd);
							SelBegPt := Point(A, Ln+1);
							SelEndPt := Point(SelBegPt.x + B, Ln+1);
							InvertText(SelBegPt, SelEndPt);
						end;
				end
			else                         //this is a single click
				begin
					SetClickCaret(ClickPt);
				end;

			SetViewFocus(FCanvas.handle, curFocus);
			ClearUndo;			//clear, onto something else
		end;
end;

procedure TMLEditor.MoveCaret(shifted: Boolean; Direction: integer);
var
	curFocus: TFocus;
	y,x: Integer;
begin
	if numChs > 0 then
		begin
			GetViewFocus(FCanvas.Handle, curFocus);
			FocusOnCell;
			if (SelBeg <> SelEnd) then
				InvertText(SelBegPt, SelEndPt)
			else
				EraseCaret;

			case direction of
				goLeft:
					begin
						if TxLine[curLn].fstChIdx-1 = SelBeg then
							curLn := max(0, curLn-1)
						else if SelBeg > 0 then
							SelBeg := Selbeg-1;
						TxCaret.x := GetLineWidth(CurLn, SelBeg);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret.y := y - 2 + MulDiv(kLnHeight*(CurLn+1), scale, cNormScale);
						if not shifted then
              begin
                SelEnd := SelBeg;
                SelBegPt := Point(TxCaret.x, curLn+1);
                SelEndPt := SelBegPt;
              end;
            if shifted then SelBegPt := Point(TxCaret.x, curLn+1);
					end;
				goRight:
					begin
						if TxLine[curLn].lstChIdx+1 = SelEnd then
							curLn := min(maxLns-1, curLn+1)
						else if SelEnd < numChs then
							SelEnd := SelEnd+1;
						TxCaret.x := GetLineWidth(CurLn, SelEnd);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret.y := y - 2 + MulDiv(kLnHeight*(CurLn+1), scale, cNormScale);
						if not shifted then
              begin
                SelBeg := SelEnd;
                SelEndPt := Point(TxCaret.x, curLn+1);
                SelBegPt := SelBegPt;
              end;
            if shifted then SelEndPt := Point(TxCaret.x, curLn+1);
					end;
				goUp:
					if curLn > 0 then begin
						curLn := curLn-1;
		 				X := TxCaret.x;
						if (curLn = 0) and (X < TxRect.left + TxIndent) then
							X := TxRect.left + TxIndent;
            X := GetClickPosition(curLn, X, SelBeg);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret := Point(X, y -2 + MulDiv(kLnHeight*(curLn+1),scale, cNormScale));
						if not shifted then
              begin
                SelEnd := SelBeg;
                SelBegPt := Point(TxCaret.x, curLn+1);
                SelEndPt := SelBegPt;
              end;
            if shifted then SelBegPt := Point(TxCaret.x, curLn+1);
					end;
				goDown:
					if curLn < maxLns-1 then begin
						curLn := curLn+1;
						X := GetClickPosition(curLn, TxCaret.x, SelEnd);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret := Point(X, y -2 + MulDiv(kLnHeight*(curLn+1),scale, cNormScale));
						if not shifted then
              begin
                SelBeg := SelEnd;
                SelEndPt := Point(TxCaret.x, curLn+1);
                SelBegPt := SelBegPt;
              end;
            if shifted then SelEndPt := Point(TxCaret.x, curLn+1);
					end;
        goHome:
          begin
            SelBeg := TxLine[curLn].fstChIdx-1;
						TxCaret.x := GetLineWidth(CurLn, SelBeg);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret.y := y - 2 + MulDiv(kLnHeight*(CurLn+1), scale, cNormScale);
						if not shifted then
              begin
                SelEnd := SelBeg;
                SelBegPt := Point(TxCaret.x, curLn+1);
                SelEndPt := SelBegPt;
              end;
            if shifted then SelBegPt := Point(TxCaret.x, curLn+1);
          end;
        goEnd:
          begin
						SelEnd := TxLine[curLn].lstChIdx;
						TxCaret.x := GetLineWidth(CurLn, SelEnd);
						y := MulDiv(TxRect.top, scale, cNormScale);
						TxCaret.y := y - 2 + MulDiv(kLnHeight*(CurLn+1), scale, cNormScale);
						if not shifted then
              begin
                SelBeg := SelEnd;
                SelEndPt := Point(TxCaret.x, curLn+1);
                SelBegPt := SelBegPt;
              end;
            if shifted then SelEndPt := Point(TxCaret.x, curLn+1);
          end;
			end;

      if shifted then
        begin
          InvertText(SelBegPt, SelEndPt);
        end
      else
        begin
//          SetCaret;
			    ShowCaret;           //show in changed position
        end;

			SetViewFocus(FCanvas.handle, curFocus);

			ClearUndo;			//clear, onto something else
		end;
end;

function TMLEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
  if not FCell.Disabled then
    case direction of
      goLeft, goHome:
        result := (SelBeg > 0);
      goRight, goEnd:
        result := (SelBeg < NumChs);
      goUp:
        result := (curLn > 0);
      goDown:
        result := (curLn < min(maxLns, numLns)-1);
    end;
end;

Function TMLEditor.CanAcceptChar(Key: Char): Boolean;
begin
	result := Key in [#08, #27, #13, #32..#255];  	//all visible + backsp, clear, return, delete=$87
	if (key = #13) then
		result := (length(TxLine) < MaxLns);		     //can we take another line??
end;

Procedure TMLEditor.SetTextJustification(const Value: Integer);// always left alignment
begin
  FTxJust := tjJustLeft;
end;

procedure TMLEditor.SetText(const Value: String);
var
  curFocus: TFocus;
begin
  if FCanEdit then
    begin
      GetViewFocus(FCanvas.Handle, curFocus);
      try
        FocusOnCell;

        if SelBeg <> SelEnd then
          InvertText(SelBegPt, SelEndPt)
        else
          EraseCaret;

        UndoText := TxStr;
        UndoBeg := 0;
        UndoEnd := length(TxStr);

        TxStr := Value;
        ClearLF(TxStr);
        SelBeg := Length(TxStr);
        SelEnd := SelBeg;
        NumChs := Length(TxStr);

        CalcTextWrap;
        curLn := GetCurLine(SelBeg);

        DisplayCom(0);
        SetCaret;
      finally
        FModified := True;
        SetViewFocus(FCanvas.handle, curFocus);
      end;
    end;
end;

procedure TMLEditor.InputString(const Text: String);
var
  Input: String;
begin
  if FCanEdit then
    begin
      if FUpperCase then
        Input := UpperCase(Text)
      else
        Input := Text;

      UndoText := Copy(TxStr, SelBeg + 1, SelEnd - SelBeg);
      UndoBeg := SelBeg;
      UndoEnd := UndoBeg + Length(Input);

      Delete(TxStr, SelBeg + 1, SelEnd - SelBeg);
      Insert(Input, TxStr, SelBeg + 1);

      FModified := True;
      NumChs := Length(TxStr);
      SelBeg := SelBeg + Length(Input);
      SelEnd := SelBeg;
      CalcTextWrap;
      SetCaret;

      CurLn := GetCurLine(SelBeg);
      DisplayCom(0);
    end;
end;

procedure TMLEditor.SelectText(const Start: Integer; const Length: Integer);
var
  curFocus: TFocus;
  Line: Integer;
begin
  if (NumChs > 0) then
    begin
      GetViewFocus(FCanvas.Handle, curFocus);
      try
        FocusOnCell;
        if (SelBeg <> SelEnd) then
          InvertText(SelBegPt, SelEndPt)
        else
          EraseCaret;

        SelBeg := Start - 1;
        SelEnd := SelBeg + Length;

        Line := GetCurLine(SelBeg);
        SelBegPt := Point(GetLineWidth(Line, SelBeg), Line + 1);
        Line := GetCurLine(SelEnd);
        SelEndPt := Point(GetLineWidth(Line, SelEnd), Line + 1);

        InvertText(SelBegPt, SelEndPt);
      finally
        SetViewFocus(FCanvas.Handle, curFocus);
      end;
    end;
end;

{***********************************************}
{                                               }
{           TTextEditor - Text Editor           }
{                                               }
{***********************************************}

/// summary: Indicates whether the cell is configured to allow linked comments.
function TTextEditor.CanLinkComments: Boolean;
begin
  Result := True;
  Result := Result and (FDoc is TContainer);
//  Result := Result and (FCell is TTextBaseCell);
  Result := Result and (FCell is TMLnTextCell);      //only multiple cells can have carryover
  Result := Result and not FDoc.Locked;
  Result := Result and not FCell.Disabled;
  Result := Result and (FCell.FCellID <> CCommentsCellID);
  Result := Result and (FCell.FType <> cSignature);
  Result := Result and not IsBitSet(FCellPrefs, bCelNumOnly);
  Result := Result and not IsBitSet(FCellPrefs, bCelFormat);
  Result := Result and not IsBitSet(FCellPrefs, bCelDispOnly);
end;

/// summary: Links the cell to a comment addendum and appends the editor text to the addendum.
procedure TTextEditor.LinkComments;
var
  Body: String;
  Command: Longword;
  CommentCell: TWordProcessorCell;
  Form: TDocForm;
  Heading: String;
  Prompt: Boolean;
  PromptForm: TFormLinkComments;
  TextBaseCell: TTextBaseCell;
  ADoc: TContainer;
  SavedCanEdit: Boolean;
  SavedPosition: TPoint;
begin
  if not CanLinkComments then
    raise Exception.Create('Cell does not support comment linking.');

  if (FDoc as TContainer).UADEnabled and (AnsiIndexText(IntToStr(FCell.FCellXID), UADCmntCellXID) >= 0) then
    begin
      ADoc := (FDoc as TContainer);
      SavedCanEdit := FCanEdit;
      SavedPosition.X := ADoc.docView.HorzScrollBar.Position;
      SavedPosition.Y := ADoc.docView.VertScrollBar.Position;
      try
        FCanEdit := True;
        // Comment cells use line-feeds while dialog memo fields use carriage-returns & line-feeds
        Body := StringReplace(Text, #13, #10, [rfReplaceAll]);
        Heading := FCell.UserPreference[CCellCaptionPreference];
        if (Length(Body) > 0) then
          begin
            TextBaseCell := FCell as TTextBaseCell;
            if TextBaseCell.HasLinkedComments then
              begin
                CommentCell := ADoc.FindCellInstance(TextBaseCell.LinkedCommentCell) as TWordProcessorCell;
                if not Assigned(CommentCell) then
                  begin
                    TextBaseCell.LinkedCommentCell := GUID_NULL;
                    LinkComments;  // recursive
                  end
                else
                  CommentCell.RewriteSection(TextBaseCell.LinkedCommentSection, Heading, Body);
              end
            else
              begin
                Form := ADoc.GetFormByOccurance(CUADCommentAddendum, 0, True);
                if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
                  begin
                    CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
                    CommentCell.GSEData := ' ';  // suppress validation errors
                    CommentCell.Disabled := True;
                    TextBaseCell.LinkedCommentCell := CommentCell.InstanceID;
                    TextBaseCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
                  end;
              end;
            Text := FormUADLinkedCmntText(ADoc.UADEnabled, FCell.FCellXID, Body, Heading);
          end;
      finally
        FCanEdit := SavedCanEdit;
        ADoc.docView.HorzScrollBar.Position := SavedPosition.X;
        ADoc.docView.VertScrollBar.Position := SavedPosition.Y;
      end;
    end
  else
  begin
    PromptForm := TFormLinkComments.Create(nil);
    try
      // prompt for heading
      Prompt := not SameText(FCell.UserPreference[CCellPromptCaptionPreference], 'No');
      PromptForm.Heading := FCell.UserPreference[CCellCaptionPreference];
      if Prompt and (PromptForm.ShowModal = mrOK) then
        begin
          FCell.UserPreference[CCellCaptionPreference] := PromptForm.Heading;
          FCell.UserPreference[CCellPromptCaptionPreference] := PromptForm.Ask;
        end;

      // link comments
      if not Prompt or (PromptForm.ModalResult = mrOK) then
        begin
          Form := (FDoc as TContainer).GetFormByOccurance(appPref_DefaultCommentsForm, 0, True);
          if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
            begin
              // link the comment
              Body := Text;
              Heading := FCell.UserPreference[CCellCaptionPreference];
              CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
              TextBaseCell := FCell as TTextBaseCell;
              TextBaseCell.LinkedCommentCell := CommentCell.InstanceID;
              TextBaseCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
              Text := Format(msgCommentsReferenceText, [Heading]);

              // move to the comment text within the comment cell
              Command := goCommentSection or (TextBaseCell.LinkedCommentSection shl 16);
              PostMessage((FDoc as TContainer).Handle, CLK_CELLMOVE, Command, Integer(CommentCell));
            end;
        end;
    finally
      FreeAndNil(PromptForm);
    end;
  end;
end;

{***********************************************}
{                                               }
{      TChkBoxEditor - CheckBox Editor      		}
{                                               }
{***********************************************}


procedure TChkBoxEditor.OnFontChanged(Sender: TObject);
var
  focus: TFocus;
begin
  FCellFmtChged := True;
  FModified := True;

  GetViewFocus(FCanvas.Handle, focus);
  try
    FocusOnCell;
    DisplayCurCell;
  finally
    SetViewFocus(FCanvas.handle, focus);
  end;
end;

constructor TChkBoxEditor.Create(AOwner: TAppraisalReport);
begin
  FFont := TCellFont.Create;
	inherited Create(AOwner);

	TxStr := '';
	UndoText := '';
	ChkBoxGroup := nil;                 //reference to CurCells TGroupTable object
  FFont.Assign((FDoc as TContainer).docFont);
  FFont.OnChange := OnFontChanged;
end;

destructor TChkBoxEditor.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TChkBoxEditor.IdleEditor;
begin
//do nothing - no blinking
end;

function TChkBoxEditor.ToggleX: Char;
begin
  result := 'X';
	if (length(Trim(TxStr)) > 0) and (TxStr = 'X') then      //toggle off only on X, leave other chars alone
		result := #0

	else if length(Trim(TxStr)) = 0 then             //blank: toggle on
		result := 'X';
end;

procedure TChkBoxEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  ch: Char;
begin
  ch := ToggleX;
	KeyEditor(ch);                              //do the same as keying in an X
end;

procedure TChkBoxEditor.KeyEditor(var Key: Char);
var
	OKey: Integer;
	Pt: TPoint;
	curFocus: TFocus;
begin
	if FActive and FCanEdit and CanAcceptChar(Key) and TBaseCell(FCell).DisplayIsOpen(True) then          //cannot be FActive because???
		begin
		// Checkbox has no caret, so make sure box is visible
			Pt := RectCenter(ScaleRect(FFrame, cNormScale, scale));
			Pt := TBaseCell(FCell).Caret2View(Pt);						//special to convert view pt to doc

			TContainer(FDoc).MakePtVisible(Pt);             //make it visible
			GetViewFocus(FCanvas.Handle, curFocus);
			FocusOnCell;

			OKey := ord(Key);
      if(OKey = kEnterKey) or (OKey = kReturnKey) or (OKey = kSpaceKey)then
        Key := ToggleX;
        
			if (OKey = kBkSpace) or(OKey = kClearKey) or (OKey = kDeleteKey) then			{control chars}
				begin
					DeleteCheckMark;
				end
			else if (ChkBoxGroup = nil) then         //no grouping, this is a single chkbox
				begin
					InsertCheckMark(Key);
					ProcessCheckMark;                 	 //cell immediate preprocessing
				end
			else 																		 //there is checkbox grouping
				begin
					GroupEnforce(Key);
					InsertCheckMark(Key);
					ProcessCheckMark;            				//cell immediate processing
					if ShiftKeyDown then
						GroupRipple(Key);                 //ripple down the inserted key
				end;

      (FCell as TChkBoxCell).DrawGroup(FCanvas, cNormScale, scale, False);
			SetViewFocus(FCanvas.handle, curFocus);
			FModified := True;
		end;

	Key := #0;            //we handled the key
end;

procedure TChkBoxEditor.HilightCell;
begin
  if Assigned(ChkBoxGroup) then
    (FCell as TChkBoxCell).DrawGroup(FCanvas, cNormScale, scale, False);
  inherited;
end;

procedure TChkBoxEditor.UnHilightCell;
begin
  if Assigned(ChkBoxGroup) then
    (FCell as TChkBoxCell).DrawGroup(FCanvas, cNormScale, scale, False);
  inherited;
end;

procedure TChkBoxEditor.DrawCurCell;
var
	FormatFlags: Integer;
	sBox : TRect;
  curFocus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, curFocus);
  try
    FocusOnCell;
    sBox := ScaleRect(TxRect, cNormScale, scale);
    FCanvas.Brush.Color := TContainer(FDoc).GetPenColor(False);	//frame the check box
    FCanvas.FrameRect(sBox);
    InflateRect(sBox, -1,-1);           				//setup for inside
    FCanvas.Brush.color := FCell.Background;
//	FCanvas.Brush.color := TContainer(FDoc).docColors[cHiliteColor];		//appPref_CellHiliteColor;
    FCanvas.FillRect(sBox);

    if Length(TxStr) > 0 then
    begin
      FCanvas.Font.Assign(FFont);               //make sure we use right font
      FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);
      FCanvas.Brush.Style := bsClear;
//		sBox.bottom := sBox.Bottom + muldiv(2, Scale, cNormScale);       //hack to make X appear centered

      InflateRect(sBox, 1,1);           //setup for inside

      FormatFlags := DT_BOTTOM + DT_SINGLELINE + DT_CENTER + DT_NOPREFIX;
      DrawText(FCanvas.handle, PCHar(TxStr), length(TxStr), sBox, FormatFlags);
    end;
  finally
    SetViewFocus(FCanvas.Handle, curFocus);
  end;
end;

procedure TChkBoxEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
	Inherited LoadCell(Cell, cUID);

  if cell <> nil then
    begin
      TxStr := Cell.GetText;          //this is a copy of the text to edit
      TxRect := FFrame;
      FFont.Size := cell.FTxSize;
      FFont.Style := cell.FTxStyle;
      saveFont.Assign(FCanvas.Font);          //save prev font

      ChkBoxGpIndx := Point(0,0);
      ChkBoxGroup := TGroupTable(cell.GetGroupTable);              //group this checkbox belongs to
      if ChkBoxGroup <> nil then
        ChkBoxGpIndx := ChkBoxGroup.GetCellTableIndex(FCellUID.num);         //index of the cell in its group array
    end;
end;

procedure TChkBoxEditor.UnLoadCell;
begin
	TxStr := '';
	FreeAndNil(ChkBoxGroup);
	inherited UnLoadCell;
end;

procedure TChkBoxEditor.DeleteCheckMark;
begin
	undoText := TxStr;        //save the x
	TxStr := '';
	FModified := True;

	DrawCurCell;
end;

procedure TChkBoxEditor.InsertCheckMark(Key: Char);
begin
	UndoText := TxStr;
	if key = #0 then                  //this is the empty char, use #0 instead of #20 (space)
		TxStr := ''
	else
		TxStr := UpperCase(Key);         //checkboxes only hold uppercase chars
	FModified := True;

	DrawCurCell;
end;

procedure TChkBoxEditor.GroupRipple(Key: Char);
var
	i, k, col, row, curRow,curCol,lastRow: Integer;
	chkBoxPage: TDocPage;
	chkBox: TBaseCell;
	markIt, forceGroup: Boolean;
	curFocus: TFocus;
begin
  FCanvas.Font.Assign(FFont);
  FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);
	markIt := (key = 'X') or (key = 'x');
  forceGroup := not ControlKeyDown;
	chkBoxPage := TDocPage(TBaseCell(FCell).FParentPage);
	with chkBoxGroup do
		begin
			GetViewFocus(FCanvas.Handle, curFocus);
			curCol := ChkBoxGpIndx.x;
			curRow := ChkBoxGpIndx.y;
			lastRow := FRows;
			if curRow+1 <= lastRow then 									//there is something to ripple
				for row := curRow+1 to lastRow do           	//ripple thru trailing rows
					for col := 1 to FCols do                    //set all columns
						begin
							i := col + (Row -1) * FCols -1;         //the array index
							k := FCells[i];                         //get the cell index in page
							chkBox := TChkBoxCell(chkBoxPage.PgData[k-1]);     //get the cell
							chkBox.FocusOnCell;

							if markIt then
								begin
                  if forceGroup then
                    begin
                      chkBox.DoSetText('');
                      chkBox.FEmptyCell := True;
                    end;
(*
									if not ControlKeyDown then             //delete all row data first
										chkBox.Text := '';

									chkBox.FEmptyCell := True;             //got rid of all text
									chkBox.FWhiteCell := True;           	 //no data so no white cells
									chkBox.FBkGrdColor := clWhite;
*)
									if col = curCol then
										begin
                      chkBox.DoSetText('X');
										end;
									chkBox.FWhiteCell := True;           	 //no data so no white cells
								end
							else
								begin
									chkBox.doSetText('');
//									chkBox.FEmptyCell := True;             //got rid of all text
//									chkBox.FWhiteCell := False;            //no data so no white cells
//									chkBox.FBkGrdColor := TContainer(FDoc).docColors[cEmptyCColor];			//appPref_EmptyCellColor;
								end;
							chkBox.DrawZoom(FCanvas, cNormScale, scale, False);
						end;
			SetViewFocus(FCanvas.handle, curFocus);
		end; //with TGroupTable
end;

//Sets the state of the group when saving the checkbox data
procedure TChkBoxEditor.SetGroupState;
var
	i, j, k, row: Integer;
	chkBox: TChkBoxCell;
	chkBoxPage: TDocPage;
	GroupHasData: Boolean;
begin
	if chkBoxGroup <> nil then
  try
		with chkBoxGroup do
			begin
				chkBoxPage := TDocPage(TBaseCell(FCell).FParentPage);
				Row := ChkBoxGpIndx.y;
				GroupHasData := False;
				for i := 1 to FCols do                            //see if we have data
					begin
						j := i + (Row -1) * FCols -1;                  //the array index
						k := FCells[j];                                //get the cell index
						chkBox := TChkBoxCell(chkBoxPage.PgData[k-1]);     //get the cell
						if not chkBox.FEmptyCell then
							GroupHasData := True;                        //set HasData flag
					end;

				for i := 1 to FCols do
					begin
						j := i + (Row -1) * FCols -1;                  	 //the array index
						k := FCells[j];                               	 //get the cell index
						chkBox := TChkBoxCell(chkBoxPage.PgData[k-1]);   //get the cell
						chkBox.FWhiteCell := GroupHasData;            	 //all cells in group are white
					end;
			end;
  except
    ShowNotice(errChkBoxGrpOR);
  end;
end;

//deletes the data in the group of cells
procedure TChkBoxEditor.DeleteGroupData;
var
	i, j, k, row: Integer;
	chkBox: TChkBoxCell;
	chkBoxPage: TDocPage;
begin
	if chkBoxGroup <> nil then
		with chkBoxGroup do
			begin
				chkBoxPage := TDocPage(FPage);           //cell's parent page
				Row := ChkBoxGpIndx.y;
				for i := 1 to FCols do
					begin
						j := i + (Row -1) * FCols -1;                  //the array index
						k := FCells[j];                                //get the cell index
						chkBox := TChkBoxCell(chkBoxPage.PgData[k-1]);     //get the cell

						chkBox.Text := '';
						chkBox.FEmptyCell := True;             //get rid of all text
						chkBox.FWhiteCell := False;            //no data so no white cells

            TContainer(FDoc).StartProcessLists;
            chkBox.ReplicateLocal(True);           //new
            chkBox.ReplicateGlobal;
 //           chkBox.ProcessMath;     //###leave it out for now
            TContainer(FDoc).ClearProcessLists;
            // 063011 JWyatt Display the cell to ensure that the text is updated.
            chkBox.Display;
					end;
			end;
end;
 
// 052611 JWyatt Add the AllowOverride option to enable/disable use of
//  Control Key functionality
//  Was: procedure TChkBoxEditor.GroupEnforce(Key: Char);
procedure TChkBoxEditor.GroupEnforce(Key: Char; const AllowOverride: Boolean = True);
begin
	if (key = 'X') or (key = 'x') then          //we are inserting data
    // Was: if not ControlKeyDown then                //not overriding the group effect
		if (not AllowOverride) or (not ControlKeyDown) then  //not overriding the group effect
      DeleteGroupData;                      //delete the data
end;

//this is called upon leaving the editor
procedure TChkBoxEditor.SaveChanges;
begin
	if FModified or FCellFmtChged then
		begin
			TBaseCell(FCell).SetText(TxStr);        //save the checkmarks
			FModified := false;
		end;

	SetGroupState;     //we're leaving, set group state: if we have data, group has white cells

  inherited SaveChanges;     //save the prefs and formats
  ClearUndo;                 //committed to cell
end;

//saves immediately so cell can process the results
procedure TChkBoxEditor.ProcessCheckMark;
begin
	TBaseCell(FCell).DoSetText(TxStr);            //save the checkmark
  TbaseCell(FCell).FModified := FModified;      //it changed
	FModified := False;                           //we did our part, now forget it

  //Cell.PostProcess will do the same as below
  TContainer(FDoc).StartProcessLists;
	TBaseCell(FCell).ReplicateLocal(True);
	TBaseCell(FCell).ReplicateGlobal;
	TBaseCell(FCell).ProcessMath;
  TContainer(FDoc).ClearProcessLists;
end;

function TChkBoxEditor.HasMultiRowGroup: Boolean;
begin
	result := (ChkBoxGroup <> nil) and (ChkBoxGroup.FRows > 1);
end;

function TChkBoxEditor.CanAcceptChar(Key: Char): Boolean;
begin
  result := Key in [#0, #08, #27, #32..#255];
  if not result and IsAppPrefSet(bUseEnterKeyAsX) and (Key in [#13]) then
    result := True;
end;

/// summary: Sets the check state of the editor.
// 052611 JWyatt Add the AllowOverride option to enable/disable use of
//  Control Key functionality
//  Was: procedure TChkBoxEditor.SetCheckMark(const Checked: Boolean; const EnforceGroup: Boolean = True);
procedure TChkBoxEditor.SetCheckMark(const Checked: Boolean; const EnforceGroup: Boolean = True;
  const AllowOverride: Boolean = True);
var
  Key: Char;
begin
  if Checked then
    Key := Char('X')
  else
    Key := #0;

  if EnforceGroup and (ChkBoxGroup <> nil) then
      GroupEnforce(Key, AllowOverride);

  InsertCheckMark(Key);
  ProcessCheckMark;
end;

function TChkBoxEditor.CanFormatText: Boolean;
begin
  Result := False;
end;

function TChkBoxEditor.GetFont: TCellFont;
begin
  Result := FFont;
end;

function TChkBoxEditor.GetTextJustification: Integer;
begin
  Result := tjJustMid;
end;

procedure TChkBoxEditor.SetTextJustification(const Value: Integer);
begin
  // do nothing  
end;



{******************************************}
{                                          }
{      TGraphicEditor - Graphic Editor     }
{                                          }
{******************************************}

procedure TGraphicEditor.OnImageChanged(Sender: TObject);
begin
  ResetView(FStretch, FCenter, FAspRatio, FEditScale);
end;

constructor TGraphicEditor.Create(AOwner: TAppraisalReport);
begin
	inherited;

  FUndoImage := nil;     //create when needed
  FCanUndo := False;
  FActiveLabel := nil;
  //FOptimized := False;
end;

destructor TGraphicEditor.Destroy;
begin
  if Assigned(FUndoImage) then
    FUndoImage.Free;

	inherited destroy;
end;

function TGraphicEditor.HasContents: Boolean;
begin
  result := FEditImage.HasGraphic;
end;

function TGraphicEditor.HasActiveAnnotation: Boolean;
begin
  result := Assigned(TGraphicCell(FCell).FLabels) and
            Assigned(TGraphicCell(FCell).FLabels.ActiveItem);
end;

procedure TGraphicEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
	inherited LoadCell(cell, cUID);

  FEditImage := TGraphicCell(cell).FImage;      //reference the cells image
 
  FPreviousImageChangedEvent := FEditImage.OnImageChanged;
  FEditImage.OnImageChanged := OnImageChanged;

  FViewPort := FEditImage.ViewPort;
  FSrcRect := FEditImage.SourceRect;

  FEditPicDest := TGraphicCell(cell).FPicDest;
	FEditScale := TGraphicCell(cell).FPicScale;
  FCellPrefs := TGraphicCell(cell).FCellPref;

	FStretch := IsBitSet(FCellPrefs, bImgFit);
	FCenter := IsBitSet(FCellPrefs, bImgCntr);
	FAspRatio := IsBitSet(FCellPrefs, bImgKpAsp);
	FPrFrame := IsBitSet(FCellPrefs, bCelPrFrame);
  //FOptimized := IsBitSet(FCellPrefs, bImgOptimized);

 	FCanUndo := False;

(*
	FStretch := IsBitSet(TGraphicCell(cell).FCellPref, bImgFit);
	FCenter := IsBitSet(TGraphicCell(cell).FCellPref, bImgCntr);
	FAspRatio := IsBitSet(TGraphicCell(cell).FCellPref, bImgKpAsp);
	FPrFrame := IsBitSet(TGraphicCell(cell).FCellPref, bCelPrFrame);

  if assigned(ImagePrefTool) then  //if the tool is visible, load it with ourselves
    ImagePrefTool.Editor := Self;
*)
end;

procedure TGraphicEditor.Unloadcell;
begin
  if Assigned(FEditImage) then
    FEditImage.OnImageChanged := FPreviousImageChangedEvent;

	inherited UnloadCell;
  FreeAndNil(FUndoImage);
end;

procedure TGraphicEditor.HilightCell;
Var
	R: TRect;
begin
	if not FEditImage.HasGraphic then
		inherited HilightCell
	else if FCanEdit then
		begin  //draw the dashed borders
			R := ScaleRect(FViewPort, cNormScale, scale);
			InflateRect(R,1,1);        //go out one pixel
			DrawDashBorder(FCanvas, R);
		end;
end;

procedure TGraphicEditor.UnHilightCell;
var
	R: TRect;
begin
	if not FEditImage.HasGraphic then
		inherited UnHilightCell
	else
		begin   //redraw the rectangle
			FCanvas.Pen.Width := 1;
			FCanvas.Brush.style := bsClear;
			R := FViewPort;
			R := ScaleRect(R, cNormScale, scale);
			InflateRect(R,1,1);        //go out one pixel
			FCanvas.Pen.Style := psSolid;
			FCanvas.pen.color := clblack;
			FCanvas.Rectangle(R.left, R.top, R.right, R.bottom);
		end;

  //leaving, unhilight the annotations
  if assigned(TGraphicCell(FCell).FLabels) then
    TGraphicCell(FCell).FLabels.Unhilight;
end;

procedure TGraphicEditor.KeyEditor(var Key: Char);
var
	OKey: Integer;
	Pt: TPoint;
	curFocus: TFocus;
begin
	if FActive and FCanEdit and CanAcceptChar(Key) and TBaseCell(FCell).DisplayIsOpen(True) then
	begin
		// photo has no caret, so make sure box is visible
		Pt := RectCenter(ScaleRect(FFrame, cNormScale, scale));
		Pt := TBaseCell(FCell).Caret2View(Pt);						//special to convert view pt to doc
		TContainer(FDoc).MakePtVisible(Pt);               //make it visible

		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;

		OKey := ord(Key);
		if (OKey = kBkSpace) or (OKey = kClearKey) or (OKey = kDeleteKey) then			{control chars}
	    ClearEdit;

		SetViewFocus(FCanvas.handle, curFocus);
		FModified := True;
	end;

	Key := #0;            //we handled the key
end;

//programmed load of an image
function TGraphicEditor.LoadImageStream(Stream: TStream): Boolean;
begin
  result := False;
  if FEditImage.HasGraphic then
    begin
      SaveUndo;
      FEditImage.Clear;
    end;
  if FEditImage.LoadImageFromStream(Stream, Stream.Size) then
    begin
      ResetView(FStretch, FCenter, FAspRatio, 100);
      FocusOnCell;
      DrawCurCell;
      FocusOnWindow;
      FModified := True;
      result := True;
    end;
end;

function TGraphicEditor.LoadGraphicImage(Image: TGraphic): Boolean;
begin
  result := False;
  if FEditImage.HasGraphic then
    begin
      SaveUndo;
      FEditImage.Clear;
    end;

  if FEditImage.LoadGraphicImage(Image) then
    begin
      ResetView(FStretch, FCenter, FAspRatio, 100);
      FocusOnCell;
      DrawCurCell;
      FocusOnWindow;
      FModified := True;
      result := True;
    end;
end;

function TGraphicEditor.LoadEMFplusImage(Image: TGraphic): Boolean;
begin
  result := False;
  if FEditImage.HasGraphic then
    begin
      SaveUndo;
      FEditImage.Clear;
    end;

  if FEditImage.LoadEMFplusImage(Image,cfi_EMFplus) then
    begin
      ResetView(FStretch, FCenter, FAspRatio, 100);
      FocusOnCell;
      DrawCurCell;
      FocusOnWindow;
      FModified := True;
      result := True;
    end;
end;

//called when user loads an image from a file
function TGraphicEditor.LoadImageFile(imageFile: String): Boolean;
var
	OK: Boolean;
  optStream: TImageStream;
  imgType: String;
begin
  Ok := True;
  if FEditImage.HasGraphic then         //we have prev image, replace??
    begin
      Ok := OK2Continue('Do you want to replace the current image with this new one?');
      if OK then
        begin
          SaveUndo;
          FEditImage.Clear;
        end;
    end;
   if Ok and FEditImage.LoadImageFromFile(imageFile) then
    begin
      //optimization
      OptimizeImage;
      {  moved code to TGraphicEditor.OptimazeImage procedure
      imgType := FEditImage.FImgTyp;
      if appPref_ImageAutoOptimization and CellImageCanOptimized(FCell,PreferableOptDPI) then
          begin
              optStream := TImageStream.Create;
              try
                if FEditImage.OptimizeImage(PreferableOptDPI, optStream, imgType) then
                  begin
                    FEditImage.Clear;
                    optStream.Seek(0, soFromBeginning);
                    FEditImage.LoadImageFromStream(optStream,optStream.size);
                    FEditImage.FImgTyp := imgType;  //can be changed while creating optimized stream
                    FModified := True;
                    FEditImage.FImgOptimized := true;
                   end;
              finally
                if assigned(optStream) then
                  optStream.Free;
              end;
            end;        }
            //display image
        ResetView(FStretch, FCenter, FAspRatio, 100);
        FocusOnCell;
        DrawCurCell;
        FocusOnWindow;
        FModified := True;

        result := Ok;
      end;
end;

procedure TGraphicEditor.DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
	imageFile: String;
  SelectSource: TSelectImageSource;
begin
  SelectSource := TSelectImageSource.Create(FDoc);
  try
    if SelectSource.ShowModal = mrOK then
      case SelectSource.Tag of
        1:
          if GetGraphicFileName(imageFile) then     //user selected an image from file
            LoadImageFile(imageFile);
        2:
          GetImageFromTwain(nil);
        3:
          SelectTwainSources(nil);
      end;
  finally
    SelectSource.Free;
  end;
end;

procedure TGraphicEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  SelectedLabel: TPageControl;
  Pt: TPoint;
begin
//###  ShowNotice('Cell ID = '+ IntToStr(FCell.FCellID));

  if FCanEdit and assigned(TGraphicCell(FCell).FLabels) then
    begin
      Pt := ScalePt(ClickPt, Scale, cNormScale);                //reverse scale to detect Item
      SelectedLabel := TGraphicCell(FCell).FLabels.GetSelected(Pt);    //select the clicked one

      //if we clicked on a label
      if assigned(SelectedLabel) then
        begin
          if SelectedLabel <> TGraphicCell(FCell).FLabels.ActiveItem then
            TGraphicCell(FCell).FLabels.Hilight(SelectedLabel);

          if ssRight in Shift then
            begin
              ShowAnnotationPopupMenu(Pt);
            end
          else
            begin
              FActiveLabel := SelectedLabel;
              FActiveLabel.MouseDown(Self, Button, Shift, Pt.x, Pt.y, Scale);
            end;
          EXIT;    //we are done
        end
      else
        begin
          FActiveLabel := nil;
          TGraphicCell(FCell).FLabels.UnHilight;
        end;
    end;

  if (ssRight in Shift) and FCanEdit then
    begin
      Pt := ScalePt(ClickPt, Scale, cNormScale);    //reverse scale
      ShowPopupMenu(Pt);
    end
  else if (ssDouble in Shift) and FCanEdit then         //now if double click, see if we can insert a pic
		begin
      DblClickEditor(ClickPt, Button, Shift);
    end
  else if ControlKeyDown then      //single click and moving image
    begin
      //change cursor to a hand
      //move the picture around
    end
  else
    begin  //possible dragStart
(*
    TImage(Sender).BeginDrag(False, 5);
 Image2Drag: TDragImage;
  N: Integer;
begin
  if sender is TImage then   //if we are the image that wants to drag
    begin
      N := FImages.IndexOfObject(sender);
      if N > -1 then
        begin
          Image2Drag := TDragImage.create;
          Image2Drag.ImageCell := nil;
          Image2Drag.IsThumbImage := True;
          Image2Drag.ImageFilePath := FImages.Strings[N];
          DragObject := Image2Drag;       //send it off
        end;
*)
    end;
end;

procedure TGraphicEditor.ClickMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
begin
  Pt := ScalePt(Point(X,Y), Scale, cNormScale);  //reverse scale
  if assigned(FActiveLabel) then
    FActiveLabel.MouseMove(Sender, Shift, Pt.X, Pt.Y, Scale);
end;

procedure TGraphicEditor.ClickMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if assigned(FActiveLabel) then
    begin
      FActiveLabel.MouseUp(Sender, Button, Shift, X, Y, Scale);     //let handle the click

      if TMarkupItem(FActiveLabel).Modified then    //do we need to do anything
        PerformGraphicModification;
    end;

  FActiveLabel := nil;    //done;
end;

procedure TGraphicEditor.PerformGraphicModification;
begin
  //do be subclassed my specific editors like LocMap, FloodMap
end;

//the Graphic editor cannot accept any characters
function TGraphicEditor.CanAcceptChar(Key: Char): Boolean;
begin
	result := Key in [{#08,} chr(kBkSpace), chr(kDeleteKey)];
end;

procedure TGraphicEditor.ResetView(bStretch, bCntr, bAspRatio: Boolean; xScale: Integer);
var
	srcR, destR : TRect;
begin
	FStretch := bStretch;
	FCenter := bCntr;
	FAspRatio := bAspRatio;
	FEditScale := xScale;

  if FEditImage.HasWMFPic then
    begin
      FEditPicDest := RectMunger(FViewPort, FEditImage.ImageRect, FStretch,FCenter,FAspRatio, FEditScale);
      FEditImage.SetDisplay(Rect(0,0,0,0), FEditPicDest);
    end
  else
    begin
      MungeAreas(FViewPort, FEditImage.ImageRect, FStretch,FCenter,FAspRatio, FEditScale, srcR,destR);
      FEditImage.SetDisplay(srcR, destR);
      FEditPicDest := destR;                //remember
    end;
end;

procedure TGraphicEditor.DisplayCurCell;
var
	curFocus: TFocus;
begin
	GetViewFocus(FCanvas.Handle, curFocus);
	FocusOnCell;
	DrawCurCell;
	SetViewFocus(FCanvas.handle, curFocus);
end;

Procedure TGraphicEditor.DrawCurCell;
Var
	View, R: TRect;
  FLabels: TMarkupList;
begin
	View := ScaleRect(FViewPort, cNormScale, scale);
	if FEditImage.HasGraphic then
		begin
			R := View;
			InflateRect(R,1,1);        		//go out one pixel
      if FCanEdit then
			  DrawDashBorder(FCanvas, R);

			FCanvas.Brush.Color :=  clWhite;           //erase the background
			FCanvas.Brush.style := bsSolid;
			FCanvas.Fillrect(View);

      FEditImage.DrawZoom(FCanvas, cNormScale, scale, False);
		end
	else
		begin
			FCanvas.Brush.Color := FCell.Background;
			FCanvas.Brush.style := bsSolid;
			FCanvas.Fillrect(View);
		end;

  FLabels := TGraphicCell(FCell).FLabels;
  if assigned(FLabels) then
    if ((FActiveLabel is TMarkupItem) and not Assigned((FActiveLabel as TMarkupItem).FGhost)) then
      FLabels.DrawZoomEx(FCanvas, cNormScale, scale, False, nil) // draw the active label when ghost is nil
    else
      FLabels.DrawZoomEx(FCanvas, cNormScale, scale, False, FActiveLabel);  // don't draw the active label
end;

Procedure TGraphicEditor.UndoEdit;
var
  tmpUndoImage: TCFImage;
begin
	begin
    tmpUndoImage := TCFImage.create;
    try
      tmpUndoImage.assign(FEditImage);        //copy current edit into temp
      FEditImage.assign(FUndoImage);          //copy current undo into edit
      FUndoImage.Assign(tmpUndoImage);        //copy temp into current undo
    finally
      tmpUndoImage.Free;                      //free the temp
      DisplayCurCell;
		  FModified := True;
    end;
  end;
end;

procedure TGraphicEditor.ClearUndo;
begin
  if assigned(FUndoImage) then
    FUndoImage.Clear;
  FCanUndo := False;
end;

procedure TGraphicEditor.SaveUndo;
begin
  if not assigned(FUndoImage) then
    FUndoImage := TCFImage.Create;

  FUndoImage.Assign(FEditImage);        //make a copy of the image
	FCanUndo := True;
end;

procedure TGraphicEditor.CutEdit;
begin
  if FEditImage.HasGraphic then
  begin
    CopyEdit;                           //copy to the clipboard
    SaveUndo;
    FEditImage.Clear;                   //clear image
    DisplayCurCell;
    FModified := True;
	end;
end;

procedure TGraphicEditor.CopyEdit;
begin
  if not FEditImage.CopyToClipBoard then
    ShowNotice(errCannotCopy);
end;

procedure TGraphicEditor.PasteEdit;
begin
  try
    if FEditImage.hasGraphic then
      SaveUndo;
    if not FEditImage.PasteFromClipboard then
      ShowNotice(errCannotPaste);
    OptimizeImage;
  finally
    DisplayCurCell;
    FModified := True;
  end;

//###  check this out
//    if StretchRatio then CalculateZoomFactorForStretchRatio;
end; 

procedure TGraphicEditor.ClearEdit;
begin
  if HasActiveAnnotation then
    ClearAnnotation(nil)

  else if FEditImage.HasGraphic then
  begin
    SaveUndo;
    FEditImage.Clear;                   //clear image
    DisplayCurCell;
    FModified := True;
    ClearAllAnnotations(nil);
	end;
  //FOptimized := false;
end;

procedure TGraphicEditor.ClearAnnotation(Sender: Tobject);
var
  actItem: TPageControl;
begin
  if assigned(TGraphicCell(FCell).FLabels) then
    begin
      actItem := TGraphicCell(FCell).FLabels.ActiveItem;
      if (actItem = FActiveLabel) then
        FActiveLabel := nil;
      TGraphicCell(FCell).FLabels.DeleteItem(actItem);

      //if no more labels, delete the FLabels list object
      if TGraphicCell(FCell).FLabels.Count = 0 then
        TGraphicCell(FCell).ClearAnnotation;           //Frees and Nils FLables

      DisplayCurCell;          //### should invalidate label rect
      FModified := True;
    end;
end;

procedure TGraphicEditor.ClearAllAnnotations(Sender: TObject);
begin
  if assigned(TGraphicCell(FCell).FLabels) then
    begin
      FActiveLabel := nil;
      TGraphicCell(FCell).FLabels.Clear;
      TGraphicCell(FCell).ClearAnnotation;  //Deletes (Free/Nil Flables)

      DisplayCurCell;          //### should invalidate label rect
      FModified := True;
    end;
end;

//save changes when moving to next cell
procedure TGraphicEditor.SaveChanges;
begin
 // FOptimized := IsBitSet(FCellPrefs, bImgOptimized);

  //save the cells preferences to the editor prefs
  FCellPrefs := SetBit2Flag(FCellPrefs, bImgFit, FStretch);
  FCellPrefs := SetBit2Flag(FCellPrefs, bImgCntr, FCenter);
  FCellPrefs := SetBit2Flag(FCellPrefs, bImgKpAsp, FAspRatio);
  FCellPrefs := SetBit2Flag(FCellPrefs, bCelPrFrame, FPrFrame);
  //FCellPrefs := SetBit2Flag(FCellPrefs, bImgOptimized, FOptimized);  //github 71

  //tell cell about changes
	if FModified or FCellFmtChged {or FOptimized} then
		with TGraphicCell(FCell) do
    begin
			FEmptyCell := not FEditImage.HasGraphic;
			FWhiteCell := not FEmptyCell;
      FPicScale := FEditScale;
      FPicDest := FEditPicDest;

      TGraphicCell(FCell).Modified := True;
		end;
  FModified := False;

  inherited SaveChanges;      //save prefs and formats to cell

  ClearUndo;                  //we're committed to cell, no more undo's
end;

function TGraphicEditor.CanClear: Boolean;
begin
	result := (FEditImage.HasGraphic) and FCanEdit;
end;

function TGraphicEditor.CanCopy: Boolean;
begin
	result := (FEditImage.HasGraphic);
end;

function TGraphicEditor.CanCut: Boolean;
begin
	result := (FEditImage.HasGraphic) and FCanEdit;
end;

function TGraphicEditor.CanPaste: Boolean;
begin
	result := ClipboardHasReadableImage and FCanEdit;
end;

function TGraphicEditor.CanUndo: Boolean;
begin
	result := FCanUndo;
end;

procedure TGraphicEditor.BuildPopUpMenu;
var
  deleteMarks, fromFileMI, fromTwainMI, fromPDFMI,
  saveAsMI, selectTwainMI, dividerMI,EditImgMI: TMenuItem;
begin
  inherited;
  EditImgMI := TMenuItem.Create(FPopupMenu);
  EditImgMI.Action := Main.ToolApps7Cmd;      //Image Editor
  EditImgMI.Enabled := FEditImage.HasGraphic and FCanEdit;
  FPopupMenu.Items.Add(EditImgMI);

  saveAsMI := TMenuItem.Create(FPopupMenu);
  saveAsMI.Action := Main.CellSaveImageAsCmd;
  saveAsMI.Enabled := FEditImage.HasGraphic;
  FPopupMenu.Items.Add(saveAsMI);

  fromPDFMI := TMenuItem.Create(FPopupMenu);
  fromPDFMI.Action := Main.InsertPDFCmd;
  Main.InsertPDFCmd.Enabled := FCanEdit;
  FPopupMenu.Items.Add(fromPDFMI);

  fromfileMI := TMenuItem.Create(FPopupMenu);
  fromFileMI.Action := Main.InsertFileImageCmd;
  // V6.9.9 modified 103009 JWyatt Added setting of the caption and accelerator
  //  key so that it matches the main menu.
  fromFileMI.Caption := Main.InsertFileImageMItem.Caption;
  fromFileMI.ShortCut := Main.InsertFileImageMItem.ShortCut;
  Main.InsertFileImageCmd.Enabled := FCanEdit;
  FPopupMenu.Items.Add(fromFileMI);

  fromTwainMI := TMenuItem.Create(FPopupMenu);
  fromTwainMI.Action := Main.InsertDeviceImageCmd;
  Main.InsertDeviceImageCmd.Enabled := FCanEdit;
  FPopupMenu.Items.Add(fromTwainMI);

  dividerMI := TMenuItem.Create(FPopupMenu);
  dividerMI.Caption := '-';
  FPopupMenu.Items.Add(dividerMI);

  //delete the Annotation if there are any
  if Assigned(TGraphicCell(FCell).FLabels) then
    begin
      deleteMarks := TMenuItem.Create(FPopupMenu);
      deleteMarks.Caption := 'Delete All Map Labels';
      deleteMarks.OnClick := ClearAllAnnotations;
      deleteMarks.Enabled := FCanEdit;
      FPopupMenu.Items.Add(deleteMarks);

      dividerMI := TMenuItem.Create(FPopupMenu);
      dividerMI.Caption := '-';
      FPopupMenu.Items.Add(dividerMI);
    end;

  selectTwainMi := TMenuItem.Create(FPopupMenu);
  selectTwainMi.Caption := 'Setup Device Source';  // Select Twain Source
  selectTwainMi.OnClick := SelectTwainSources;
  FPopupMenu.Items.Add(selectTwainMI);
end;

procedure TGraphicEditor.SetPopupPoint(var Pt: TPoint);
begin
  Pt := FCell.Area2Doc(point(Pt.x, Pt.y));
  Pt := TDocView(FDocView).Doc2Client(Pt);
  Pt :=  TDocView(FDocView).ClientToScreen(Pt);
end;

procedure TGraphicEditor.ShowAnnotationPopupMenu(Pt: TPoint);
var
  deleteMark: TMenuItem;
begin
  FreeAndNil(FPopupMenu);
  FPopupMenu := TPopupMenu.Create(nil);
  deleteMark := TMenuItem.Create(FPopupMenu);
  deleteMark.Caption := 'Delete Map Label';
  deleteMark.OnClick := ClearAnnotation;
  deleteMark.Enabled := True;
  FPopupMenu.Items.Add(deleteMark);

  SetPopupPoint(Pt);
  FPopupMenu.Popup(Pt.x, Pt.y);
end;

procedure TGraphicEditor.SaveImageToFile(Sender: TObject);
var
  ImageViewer: TImageViewer;
begin
  ImageViewer := TImageViewer.Create(nil);
  ImageViewer.LoadImageFromEditor(FEditImage);
  ImageViewer.Show;
end;

procedure TGraphicEditor.GetImageFromFile(Sender: TObject);  //YF 05.20.03
var
  imageFile: String;
begin
  if GetGraphicFileName(imageFile) then     //did user select an image
    LoadImageFile(imageFile);
end;

procedure TGraphicEditor.GetImageFromTwain(Sender: TObject); //YF 05.20.03
var
  resol: Integer;
  hPal : HPalette;
  hDIb: THandle;
  imgSize: Double;
begin
  if FEditImage.HasGraphic then         //we have prev image, replace??
    if OK2Continue('Do you want to replace the current image with this new one?') then
      begin
        SaveUndo;
        FEditImage.Clear;
      end
    else
      exit;

  Resol := GetDeviceRes(FCanvas.Handle);
  hPal := 0;
  hDib := 0;
  ScanTwainDib (TDocView(FDocView).Handle,//HWind: THandle;
                Resol,    //Resolution  : Integer;
                0,        //Dither      : Integer;
                0,        //reseverd       : Integer;
                hPal,     //hPal        : HPalette;
                @hDib,    //hDIB        : PDIB;
                0,        //v_object    : LongInt;
                nil);     //FCallBack   : TCallBackfunction) : Boolean;

  If GlobalSize(hDib) > 1 then
    with FEditImage do
      begin
        FDIB.DIBBitmap := GlobalLock(hDib);
        FImgTyp := cfi_DIB;
        FImgRect := Rect(0,0,FDIB.width, FDIB.Height);
        FImgBits := FDIB.Bits;
        FSrcR := FImgRect;
        imgSize := FDib.Width * FDib.Height; //Pixels
        if  imgSize > maxAllowedImageSize then
          begin
            ShowNotice('The image is ' + IntToStr(trunc(imgSize/1000000)) + ' Megapixels. '  +
                      'There is not enough memory to handle it. ' +
                      'Please reduce the image resolution (pixels per inch) and try importing again.');
            Clear;
            exit;
          end;
        
        ResetView(FStretch, FCenter, FAspRatio, 100);
        FocusOnCell;
        DrawCurCell;
        FocusOnWindow;
        FModified := True;

        SaveDibToStorage;
        //IMAGE_OPTIMAGER
        //if FStorage.Size > minFileSizeToReduce then     //on 1/24/2012 Decision turn off auto Optimization: customers claims deteriation  some images
        //  ReduceImageSize;
      end;
end;

procedure TGraphicEditor.SelectTwainSources(Sender: TObject);
begin
  if not SelectTwainSource(TContainer(FDoc).Handle) then
    ShowNotice('Cannot find any Twain device sources on your system.');
end;

procedure TGraphicEditor.OptimizeImage;
var
 imgType: String;
 optStream: TImageStream;
begin
  imgType := FEditImage.FImgTyp;
  if appPref_ImageAutoOptimization and CellImageCanOptimized(FCell,PreferableOptDPI) then
    begin
      optStream := TImageStream.Create;
      try
        if FEditImage.OptimizeImage(PreferableOptDPI, optStream, imgType) then
          begin
            FEditImage.Clear;
            optStream.Seek(0, soFromBeginning);
            FEditImage.LoadImageFromStream(optStream,optStream.size);
            FEditImage.FImgTyp := imgType;  //can be changed while creating optimized stream
            FModified := True;
            FEditImage.FImgOptimized := true;
          end;
      finally
        if assigned(optStream) then
          optStream.Free;
      end;
    end;
end;

{ TImageToolEditor }

constructor TImageToolEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;

  FToolUID := 0;        //No default tool
  FServiceUID := 0;     //no default service
end;

procedure TImageToolEditor.LaunchMapService(Sender: TObject);
begin
  if FServiceUID > 0 then
    LaunchService(FServiceUID, TContainer(FDoc), FCell);
end;

//FToolUID and FServiceUID are defaults
procedure TImageToolEditor.DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  If FCanEdit then
    if ssDouble in Shift then     //if double click, launch a tool or service
      if FToolUID > 0 then
        LaunchPlugInTool(ImageTool, TContainer(FDoc), FCell)
      else if FServiceUID > 0 then
        LaunchService(FServiceUID, TContainer(FDoc), FCell);
end;

//I had to add  this function to force KeyEditor to call TImageToolEditor.ClearEdit rather than TGraphic.ClearEdit
procedure TImageToolEditor.KeyEditor(var Key: Char);
begin
  inherited;
end;

procedure TImageToolEditor.ClearEdit;
begin
  inherited;
end;

{ TSketchEditor }
(*
constructor TSketchEditor.Create(AOwner: TComponent);
begin
  inherited;

  //set the default on double-clicking cell
  case appPref_DefaultSketcher of
    cAreaSketch: FToolUID := cmdToolAreaSketch;
    cWinSketch:  FToolUID := cmdToolWinSketch;
    cApex:       FToolUID := cmdToolApex;
  else
    FToolUID := cmdToolAreaSketch;
  end;

  //if doc already has sketch data, default to that tool
  if FCell.HasMetaData(mdAreaSketchData) then
    FToolUID := cmdToolAreaSketch
  else if TContainer(AOwner).docData.FindData('APEXSKETCH') <> nil then
    FToolUID := cmdToolApex
  else if TContainer(AOwner).docData.FindData('WINSKETCH') <> nil then
    FToolUID := cmdToolWinSketch
end;
*)
procedure TSketchEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
var
  SketchType: Integer;
  MainsketchCell: TBaseCell;  //Sketch cell with MetaData in it
begin
  inherited;

  //set the default on double-clicking cell
  case appPref_DefaultSketcher of
    cAreaSketch:  FToolUID := cmdToolAreaSketch;
    cWinSketch:   FToolUID := cmdToolWinSketch;
    cApex:        FToolUID := cmdToolApex;
    cRapidSketch: FToolUID := cmdToolRapidSketch;
    //cAreaSketchSE:FToolUID := cmdToolAreaSketchSE;
    cPhoenixSketcher: FToolUID := cmdToolPhoenixSketch;

  else
    FToolUID := cmdToolAreaSketch;
  end;

  //if doc already has sketch data, default to that tool
  //if FCell.getMetadata<>-1 then
  sketchType := TContainer(FDoc).GetDocSketchType(MainSketchcell);
  if sketchType >= 0 then
    FToolUID := mdSketchTool[sketchType]
   {begin
     case FCell.getMetadata of
     mdAreaSketchData: FToolUID := cmdToolAreaSketch;
     mdApexSketchdata: FToolUID := cmdToolApex;
     mdWinSketchData : FToolUID := cmdToolWinSketch;
     mdRapidSketchData: FToolUID := cmdToolRapidSketch;
     //mdAreaSketchSEData: FToolUID := cmdToolAreaSketchSE;
     mdPhoenixSketchData: FToolUID := cmdToolPhoenixSketch;
  end;
  end    }
  else
    if FCell.HasMetaData(mdAreaSketchData) then
      FToolUID := cmdToolAreaSketch
    else if TContainer(FDoc).docData.FindData('APEXSKETCH') <> nil then
      FToolUID := cmdToolApex
    else if TContainer(FDoc).docData.FindData('WINSKETCH') <> nil then
      FToolUID := cmdToolWinSketch
    else if TContainer(FDoc).docData.FindData('RAPIDKETCH') <> nil then
      FToolUID := cmdToolRapidSketch;


    if TContainer(FDoc).docData.FindData('APEXSKETCH') <> nil then
       begin
         FCell.Text := 'APEXSKETCH';
         TSketchCell(FCell).FMetaData := TSketchData.Create(mdApexSketchData,1,mdNameApexSketch); //create meta storage
         TSketchCell(FCell).FMetaData.FUID := mdApexSketchData;
         TSketchCell(FCell).FMetaData.FVersion := 1;
         TSketchCell(FCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(FCell).FMetaData.FData.CopyFrom(TContainer(FDoc).docData.FindData('APEXSKETCH'), 0);  //save to cells metaData
         TContainer(FDoc).docData.DeleteData('APEXSKETCH');
       end;
    if TContainer(FDoc).docData.FindData('WINSKETCH') <> nil then
        begin
         FCell.Text := 'WINSKETCH';
         TSketchCell(FCell).FMetaData := TSketchData.Create(mdWinSketchData,1,mdNameWinSketch); //create meta storage
         TSketchCell(FCell).FMetaData.FUID := mdWinSketchData;
         TSketchCell(FCell).FMetaData.FVersion := 1;
         TSketchCell(FCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(FCell).FMetaData.FData.CopyFrom(TContainer(FDoc).docData.FindData('WINSKETCH'), 0);  //save to cells metaData
         TContainer(FDoc).docData.DeleteData('WINSKETCH');
        end;
    if TContainer(FDoc).docData.FindData('RAPIDKETCH') <> nil then
        begin
         FCell.Text := 'RAPIDSKETCH';
         TSketchCell(FCell).FMetaData := TSketchData.Create(mdRapidSketchData,1,mdNameRapidSketch); //create meta storage
         TSketchCell(FCell).FMetaData.FUID := mdRapidSketchData;
         TSketchCell(FCell).FMetaData.FVersion := 1;
         TSketchCell(FCell).FMetaData.FData := TMemoryStream.Create;      //create new data storage
         TSketchCell(FCell).FMetaData.FData.CopyFrom(TContainer(FDoc).docData.FindData('RAPIDSKETCH'), 0);  //save to cells metaData
         TContainer(FDoc).docData.DeleteData('RAPIDSKETCH');
        end;
end;

//I had to add  this function to force KeyEditor to call TISketcherEditor.ClearEdit rather than TGraphic.ClearEdit
procedure TSketchEditor.KeyEditor(var Key: Char);
begin
  inherited;
end;

procedure TSketchEditor.ClearEdit;
var
  sketchCell: TSketchCell;
  xCell: TBaseCell;
  frmIndex: Integer;
  form: TDocForm;
  pgs, ID: integer;
  Dlg: TForm;
  skName: string;
  sktchFrmID: Integer;
begin
  sketchCell := TSketchCell(ActiveCell);
  skName :=ActiveCell.Text;
  sktchFrmID := sketchCell.UID.FormID;
//  if sketchCell.HasMetaData(mdAreaSketchData) then
  if (sketchCell.GetMetaData<>-1) or (sketchcell.text<>'') then
    begin
     try
      pgs := TContainer(FDoc).GetFormCountIndexByOccur2(sktchFrmID,cidSketchImage,sketchCell.Text);
      Dlg := CreateDeleteSketchDialog(pgs);
      ID := Dlg.ShowModal;
      if ID = mrNo then  //for multi page sketch user clicks button "delete only this page"
        begin
          inherited;   //delete image
          if sketchCell.GetMetaData<>-1 then
            begin
              if SketchCell.FMetaData.FData<>nil then
                  SketchCell.FMetaData.FData.Clear;     //delete meta data
              FreeAndNil(SketchCell.FMetaData);
            end;
            SketchCell.Text := '';
        end;
      if ID = mrYes then    //user press button "Yes" for single page sketch or "Delete All" for multi page one
        begin
          inherited;   //delete image
          frmIndex := TContainer(FDoc).GetFormIndexByOccur2(sktchFrmID, 0,cidSketchImage, sketchCell.Text);
          if frmIndex<>-1 then
            begin
               form := TContainer(FDoc).docForm[frmIndex];
               if form<>nil then
                 begin
                   xcell := form.GetCellByID(cidSketchImage);
                   skName := xCell.Text;
                   SketchCell := TSketchCell(xcell);
                   if SketchCell.FMetaData.FData<>nil then
                     SketchCell.FMetaData.FData.Clear;     //delete meta data
                   if SketchCell.FMetaData<>nil then
                     FreeAndNil(SketchCell.FMetaData);
                   TGraphicCell(xCell).FImage.Clear;
                   TGraphicCell(xCell).FWhiteCell := False;     //set the flags
                   TGraphicCell(xCell).FEmptyCell := True;
                 end;
            end;
          try
          repeat
            frmIndex := TContainer(FDoc).GetFormIndexByOccur2(sktchFrmID, 1,cidSketchImage, skname);
            if frmIndex<>-1 then
             begin
              form := TContainer(FDoc).docForm[frmIndex];
               if form<>nil then
                 begin
                   xcell := form.GetCellByID(cidSketchImage);
                   SketchCell := TSketchCell(xcell);
                   if SketchCell.FMetaData<>nil then
                    begin
                      SketchCell.FMetaData.FData.Clear;     //delete meta data
                      FreeAndNil(SketchCell.FMetaData);
                    end;
                   TContainer(FDoc).DeleteForm(frmIndex);
//                   TContainer(FDoc).Update;
                 end;
             end;
          until frmIndex = -1;
          except
          end;
        end;

      exit;
     except
     end;
    end
    else
    begin
      Dlg := CreateDeleteSketchDialog(1);
      ID := Dlg.ShowModal;
      case ID of
        6, 7:  //6: idYes, 7: idNo  2: idCancel  only idCancel will not delete the image
        begin
          inherited;   //delete image
          if SketchCell.FMetaData <> nil then
          begin
            SketchCell.FMetaData.FData.Clear;     //delete meta data
            FreeAndNil(SketchCell.FMetaData);
          end;
        end;
      end;
    end;
end;

{ TAdvertisementCellEditor }    //For What's New Advertisements

procedure TAdvertisementCellEditor.DblClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  If ssDouble in Shift then
    LoadURLToCell;
end;

procedure TAdvertisementCellEditor.LoadURLToCell;
var
  fLine, fPath: String;
  formIdx: Integer;
  theForm: TDocForm;
  FileContents: TStringList;
begin
  FPath := IncludeTrailingPathDelimiter(AppPref_DirHelp) + 'AdvertisementURL.txt';
  If FileExists(fPath) then
    begin
      try
        begin
          theForm := TDocForm(TDocPage(FCell.FParentPage).FParentForm);
          formIdx := TContainer(FDoc).docForm.IndexOf(theForm);
          FileContents := TStringList.Create;
          FileContents.LoadFromFile(fPath);
          If formIdx <= FileContents.Count-1 then
            begin
              fLine := FileContents[formIdx];
              LaunchURL(fLine);
            end
          else
            ShowNotice('There is no website for this advertisement.');
          FileContents.Free;
        end
      except
        ShowNotice('There was a problem launching the URL.');
      end;
    end;
end;

{ TMapEditor }

procedure TMapEditor.LoadMapGeoCodeBounds(MapBounds: TGeoRect);
begin
  FMapGeoCoded := True;
  FMapGeoBounds := MapBounds;
end;

function TMapEditor.GeoCodeToMapPixelPt(GeoPt: TGeoPoint): TPoint;
var
  mapPixRect: TRect;
begin
  mapPixRect := FEditPicDest;
  mapPixRect := OffsetRect2(mapPixRect, -FEditPicDest.left, -FEditPicDest.top);
  result := MapGeoPtToPixelPt(FMapGeoBounds, mapPixRect, GeoPt);
end;

function TMapEditor.MapPixelPtToGeoCode(Pt: TPoint): TGeoPoint;
var
  mapPixRect: TRect;
begin
  mapPixRect := FEditPicDest;
  mapPixRect := OffsetRect2(mapPixRect, -FEditPicDest.left, -FEditPicDest.top);
  result := MapPixelPtToGeoPt(FMapGeoBounds, mapPixRect, Pt);
end;

function TMapEditor.GetMapLabelPlacement(GeoPt: TGeoPoint): TPoint;
var
  Pt: TPoint;
begin
  Pt := GeoCodeToMapPixelPt(GeoPt);               //Pt relative to image origin
  Pt := Point(Pt.x + FEditPicDest.left, Pt.y + FEditPicDest.top);
  result := Pt;
end;

function TMapEditor.GetMapLabelOrientation(Pt: TPoint): Integer;
var
  mapPixRect: TRect;
  mapPixPt,origPt: TPoint;
begin
  mapPixRect := ScaleRect(FEditPicDest, cNormScale, Scale);
  mapPixPt := ScalePt(Pt, cNormScale, Scale);

  origPt := mapPixRect.topLeft;
  mapPixRect := OffsetRect2(mapPixRect, -origPt.X, -origPt.Y);
  mapPixPt := OffsetPt(mapPixPt, -origPt.X, -origPt.Y);

  result := MapLabelOrientation(mapPixPt, mapPixRect);
end;

procedure TMapEditor.ClearGeoData;
var
  GeoData: TMetaData;
begin
  FMapGeoCoded := False;

  //clear the geo metaData
  GeoData := TGraphicCell(FCell).FMetaData;      //does Cell have MetaData
  if assigned(GeoData) then
    if GeoData.ClassNameIs('TGeoData') then
      begin
        TGraphicCell(FCell).FMetaData.Free;
        TGraphicCell(FCell).FMetaData := nil;
      end;

  //clear any annotation (map labels)
  TGraphicCell(FCell).ClearAnnotation;
end;

procedure TMapEditor.LoadCell(Cell: TBaseCell; cUID: CellUID);
var
  GeoData: TMetaData;
begin
  inherited;

  GeoData := TGraphicCell(Cell).FMetaData;      //does Cell have MetaData

  if assigned(GeoData) then
    if GeoData.ClassNameIs('TGeoData') then
      begin
        MapGeoCoded := True;
        MapGeoBounds := TGeoData(GeoData).GeoBounds;
      end;
end;

procedure TMapEditor.SaveChanges;
begin
  //Give the cell its GeoMetaData
  if MapGeoCoded and FModified then
		with TGraphicCell(FCell) do
      begin
        if not assigned(FMetaData) then
          FMetaData := TGeoData.Create;

        TGeoData(FMetaData).GeoBounds := MapGeoBounds;
      end;

  inherited;     //continue with normal save
end;


{ TMapLocEditor }

constructor TMapLocEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;

  //set the default on double-clicking cell
  {case appPref_DefaultMapper of
    cBingMaps:    FServiceUID := cmdBingMaps;
//    cGeoLocator:  FToolUID := cmdToolGeoLocator;
    cMapPro:      FToolUID := cmdToolMapPro;
  else      }
    FServiceUID := cmdBingMaps;
  //end;
end;

procedure TMapLocEditor.ClearAnnotation(Sender: TObject);
var
  actItem: TPageControl;
  mapPtr: TMapPointer;
begin
 //erase the proximity if we delete it
  if assigned(TGraphicCell(FCell).FLabels) then
    begin
      actItem := TGraphicCell(FCell).FLabels.ActiveItem;
      if assigned(actItem) and actItem.ClassNameIs('TMapPtr1') then
        begin
          mapPtr := TMapPointer(actItem);
          BroadcastProximity(mapPtr.FRefID, mapPtr.FCatID, '');
        end;
    end;

  inherited;
end;

procedure TMapLocEditor.BuildPopUpMenu;
var
  fromWSMI: TMenuItem;
begin
  inherited;
  fromWSMI := TMenuItem.Create(FPopupMenu);
  fromWSMI.OnClick := LaunchMapService;
  fromWSMI.Caption := 'Insert Location Map from online map service';
  fromWSMI.Enabled := FCanEdit;
  FPopupMenu.Items.Insert(7, fromWSMI);
end;

//similar code is used in TGridCellEditor
//this is a lot of processing to set one cell, but its fast
procedure TMapLocEditor.BroadcastProximity(ARefID, ACatID: Integer; ProxStr: String);
var
  Grid: TGridMgr;
begin
  Grid := TGridMgr.Create(True);          //true = OwnsObjects
  try
    if ACatID = 0 then ACatID := lcCOMP;    //use comp grid to get to subject
    Grid.BuildGrid(FDoc, ACatID);
    if ARefID < Grid.Count then             //user may add Labels manually
      Grid.Comp[ARefID].SetCellTextByID(929, ProxStr);
  finally
    Grid.Free;
  end;
end;

//this is called is map or labels have been modified
procedure TMapLocEditor.PerformGraphicModification;
var
  SubMapPtr: TMapPointer;
  mapPtr: TMapPointer;
  MapLabels: TMapLabelList;
  Distance: Double;
  DistStr: String;
  N: Integer;
begin
  if MapGeoCoded then       //if we have GeoCodes...
    if assigned(FActiveLabel) and TMapPointer(FActiveLabel).Moved then
      begin
        MapLabels := TMapLabelList(TGraphicCell(FCell).FLabels);
        mapPtr := TMapPointer(FActiveLabel);

        mapPtr.GeoPoint := MapPixelPtToGeoCode(mapPtr.HotSpot);   //Calc new Lat/Long

        //subject moved - recalc all distances
        if (mapPtr.FRefID = 0) and (mapPtr.FCatID = lcSUBJ) then
          begin
            SubMapPtr := mapPtr;
            for N := 0 to MapLabels.count-1 do
              begin
                mapPtr := TMapPointer(MapLabels.Items[N]);
                // Version 7.2.7 081610 JWyatt: Add check and do not send proximity
                //  info if address is at 0 degrees latitude and longitude.
                if (mapPtr <> SubMapPtr) and
                   (not ((mapPtr.GeoPoint.Latitude = 0) and (mapPtr.GeoPoint.Longitude = 0))) then
                  begin
                    Distance := GetGreatCircleDistance(SubMapPtr.GeoPoint, mapPtr.GeoPoint);
                    DistStr := Trim(Format('%8.2f miles', [Distance])) + ' ' +
                          GetCompDirection(SubMapPtr.GeoPoint,mapPtr.GeoPoint);
                    BroadcastProximity(mapPtr.FRefID, mapPtr.FCatID, DistStr);
                  end;
              end;
          end

        //comp moved - recalc dist to subject
        else if (mapPtr.FCatID = lcCOMP) or (mapPtr.FCatID = lcRENT) or (mapPtr.FCatID = lcLIST) then
          begin
            SubMapPtr := MapLabels.SubjectLabel;
            //Distance := 0.0;
            // Version 7.2.7 081610 JWyatt: Add check and do not send proximity
            //  info if address is at 0 degrees latitude and longitude.
            if assigned(SubMapPtr) and assigned(mapPtr) and
               (not ((SubMapPtr.GeoPoint.Latitude = 0) and (SubMapPtr.GeoPoint.Longitude = 0))) then
              begin //make sure Subject has not been deleted
                Distance := GetGreatCircleDistance(SubMapPtr.GeoPoint, mapPtr.GeoPoint);
                DistStr := Trim(Format('%8.2f miles', [Distance])) + ' ' +
                          GetCompDirection(SubMapPtr.GeoPoint,mapPtr.GeoPoint);
                BroadcastProximity(mapPtr.FRefID, mapPtr.FCatID, DistStr);
            end ;
          end;
      end;
end;



{ TMapPlatEditor }
{ - no changes for PlatEditor - }

{ TMapFloodEditor }


procedure TMapFloodEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
var
  metaData: TMetaData;
begin
  inherited;

  metaData := TGraphicCell(Cell).FMetaData;      //does Cell have MetaData

  if assigned(metaData) then
    if metaData.ClassNameIs('TFloodData') then
      begin
        MapSubjMovable := True;
        MapSubjPoint := TFloodData(MetaData).SubjectPt;
        MapQueryStr := TFloodData(MetaData).QueryStr;
        MapCreatedOn := TFloodData(MetaData).CreatedOn;
      end;

  //set the default for double-clicking on a flood map
    FServiceUID := cmdFloodInsights;
end;

procedure TMapFloodEditor.SaveChanges;
begin
  //Give the cell its FloodMetaData
  if {FMapPtMovable and} FModified then
		with TGraphicCell(FCell) do
      begin
        if not assigned(FMetaData) then
          FMetaData := TFloodData.Create;

        TFloodData(FMetaData).SubjectPt := MapSubjPoint;
        TFloodData(FMetaData).CreatedOn := MapCreatedOn;
        TFloodData(FMetaData).QueryStr := MapQueryStr;
      end;

  inherited;     //continue with normal save
end;

procedure TMapFloodEditor.ClearGeoData;
var
  FloodData: TMetaData;
begin
  FMapPtMovable := False;

  //clear the flood metaData
  FloodData := TGraphicCell(FCell).FMetaData;      //does Cell have MetaData
  if assigned(FloodData) then
    if FloodData.ClassNameIs('FloodData') then
      begin
        TGraphicCell(FCell).FMetaData.Free;
        TGraphicCell(FCell).FMetaData := nil;
      end;

  //clear any annotation (map labels)
  ClearAllAnnotations(nil);
end;

function TMapFloodEditor.GetMapLabelPlacement(GeoPt: TPoint): TPoint;
begin
  GeoPt := Point(GeoPt.x + FEditPicDest.left, GeoPt.y + FEditPicDest.top);
  result := GeoPt;
end;

procedure TMapFloodEditor.PerformGraphicModification;
var
  mapPtr: TMapPointer;
  NewLocPt: TPoint;
  diffPt: TPoint;
  QStr: string;
  SessionExp: Boolean;
begin
  //When the label is moved - redo the flood cert.
  if MapSubjMovable then
    if assigned(FActiveLabel) and TMapPointer(FActiveLabel).Moved then
      begin
        mapPtr := TMapPointer(FActiveLabel);
        NewLocPt := mapPtr.HotSpot;

        //check the amount of movement
        diffPt := OffsetPt(FSubjectPt, NewLocPt.X, NewLocPt.Y);
        if (diffPt.x > 10) or (diffPt.y > 10) then
          if OK2Continue('The Subject location on the flood map was moved. Do you want to update the flood information?') then
            begin
              //check if the session is still active
              SessionExp := HoursBetween(Now, MapCreatedOn) > 12;
              if not SessionExp or WarnOK2Continue('You flood map service session may have expired. Do you want to try updating anyway?') then
                begin
                  if StrToIntDef(CurrentUser.UserCustUID,0) > 0 then
                    QStr := MapQueryStr + '&txtLocPtX=' + URLEncode(IntToStr(NewLocPt.X)) + '&txtLocPtY=' + URLEncode(IntToStr(NewLocPt.Y))
                  else
                    QStr := MapQueryStr + '&txtLocPtX=' + IntToStr(NewLocPt.X) + '&txtLocPtY=' + IntToStr(NewLocPt.Y);
                           //call the function to re-spot
                  RequestFloodMap(TContainer(FDoc), FCell, QStr, True);  //true = re-spot
                  Reload;
                end;
            end;
      end;
end;

procedure TMapFloodEditor.BuildPopUpMenu;
var
  fromWSMI: TMenuItem;
begin
  inherited;
      //add in Flood Map service
      fromWSMI := TMenuItem.Create(FPopupMenu);
      fromWSMI.Action := Main.ServiceFloodInsightCmd;
      fromWSMI.Caption := 'Insert Flood Map from online WebService';
      fromWSMI.Enabled := FCanEdit;
      FPopupMenu.Items.Insert(7, fromWSMI);
end;

{ TDeedPlotEditor }
(*
procedure TDeedPlotEditor.ClickEditor(ClickPt: TPoint;
  Button: TMouseButton; Shift: TShiftState);
begin
  If ssDouble in Shift then     //if double click, launch the image editor
    begin
//LaunchPlugInTool
    end
  else
    begin
    end;
end;
*)


{ TCompanyNameEdtor }



{ TSignerEditor }

procedure TSignerEditor.LoadCellRsps(Cell: TBaseCell; cUID: CellUID);
var
  i:Integer;
  names, userName: String;
begin
  UnLoadCellRsps;

  try
    names := '';
    if assigned(LicensedUsers) and (LicensedUsers.count > 0) then
      begin
        Names := '';
        for i := 0 to LicensedUsers.count-1 do
          begin
            userName :=  TUser(LicensedUsers.Items[i]).FLicName;
            Names := Names + userName + '|';
          end;
      end;

    FRsps := CreateRspHelper(Cell.FResponseID, cUID);
    FRsps.Items := Names;
    FListRsps := TRspHelper(FRsps).BuildStdRspListBox(FDoc);
    FListRsps.OnClick := ListRspsClick;
    FListRsps.OnKeyDown := OnResponseKeyDown;
    FListRsps.OnKeyPress := (FDoc as TContainer).OnKeyPress;
  except
  end;
end;

procedure TSignerEditor.BuildPopUpMenu;
var
  i: Integer;
  MI: TMenuItem;
begin
  inherited;
  FPopupMenu.AutoHotkeys := maManual;
  if FRsps.ItemCount = 0 then         //if its 0, (don't count ourselves)
    begin
      MI := TMenuItem.Create(FPopupMenu);
      MI.Caption := 'No Additional Users Found';
      FPopupMenu.Items.Add(MI);
    end
  else                                  //multiple users
    for i := 0 to FRsps.ItemCount-1 do
      begin
        MI := TMenuItem.Create(FPopupMenu);
        MI.Caption := FRsps.GetRspItem(i);
        MI.OnClick := SelectedMenuRsp;
        MI.Tag := i;    // + 1;   //this is critical
        FPopupMenu.Items.Add(MI);
      end;
end;

procedure TSignerEditor.SetPopupPoint(var Pt: TPoint);
begin
  //ignore the mouse pt coming in, and put at bottom left
  Pt := FCell.Area2Doc(point(TxRect.left, TxRect.bottom));
  Pt := TDocView(FDocView).Doc2Client(Pt);
  Pt := TDocView(FDocView).ClientToScreen(Pt);
end;

procedure TSignerEditor.AddPopupEditCmds;
begin
  //do not add any, override default
end;

function TSignerEditor.CanFormatText: Boolean;
begin
  Result := not FDoc.Locked;
end;

//this loads the supervisor or reviewer names & contact info
procedure TSignerEditor.InsertRspItem(Rsp: String; Index, Mode: Integer);
var
  User: TUser;
begin
  if (index > -1) and (index <= LicensedUsers.count-1) then
    begin
      User := TUser(LicensedUsers.Items[index]);      //checks without making current
      if User.LicFileExists then                      //make sure file is still there
        begin
          if User.IsRegistered then                   //can they use clickforms?
            TContainer(FDoc).LoadSupervisorUser(User) //load throughout doc
          else
            ShowAlert(atWarnAlert, User.FLicName + ' must register as a user before signing a report in ClickFORMS.');
        end;
    end;
end;

{ TCompanyNameEdtor }

procedure TCompanyNameEdtor.InsertRspItem(Rsp: String; Index, Mode: Integer);
begin
  if FCanEdit then
    inherited
  else
    ShowAlert(atWarnAlert, 'The Company Name cannot be changed.');
end;


{ TLicenseeEditor }


procedure TLicenseeEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  inherited;    //this handles the nornal

	if (Button = mbRight) and not AutoRspOn then  //note: we cannot use FCanEdit
	  if not TContainer(FDoc).Locked then         //cause this cell is already uneditable
      begin
        ShowPopupMenu(clickPt);
      end;
end;

procedure TLicenseeEditor.InsertRspItem(Rsp: String; Index, Mode: Integer);
var
  User: TUser;
  isRegistered: Boolean;
begin
  case Index of
    999:
      begin
      end;
  else
    if (index > -1) and (index <= LicensedUsers.count-1) then
      begin
        User := TUser(LicensedUsers.Items[index]);      //checks without making current
        if User.LicFileExists then                      //make sure file is still there
          begin
//	          if TContainer(FDoc).UADEnabled and (not UserUADLicensed(User.IsLicensedToUse(pidUADForms))) then
//              ShowAlert(atWarnAlert, User.FLicName + ' is not licensed for UAD and cannot sign this report.')
//            else
              begin
                isRegistered := User.IsRegistered;          //can they use clickforms?
                if isRegistered or (not isRegistered                    //not registered
                               ///PAM_REG and not LicensedUsers.HasRegisteredUser //and no one else is registered
                                and not AppUserHas2Reg) then            //and they are within 30 day eval period
                  begin
                    CurrentUser.Clear;                              //clear whats there
                    CurrentUser.LoadUserLicFile(User.FFileName);    //make new user the CurrentUser
                    TContainer(FDoc).LoadLicensedUser(True);        //load throughout doc
                  end
                else
                  ShowAlert(atWarnAlert, User.FLicName + ' must register as a user before signing a report in ClickFORMS.');
              end;
          end;
      end;
  end;
end;


{ TGridCellEditor }

destructor TGridCellEditor.Destroy;
begin
  if assigned(FGrid) then
    FGrid.Free;

  inherited;
end;

function TGridCellEditor.CanAcceptChar(Key: Char): Boolean;
begin
  result := inherited CanAcceptChar(Key);
  if not result then
    result := (Ord(Key) = VK_RETURN) and ControlKeyDown;   //Cntl-Enter is valid for preProcessing grid
end;

procedure TGridCellEditor.KeyEditor(var Key: Char);
begin
  if FActive and FCanEdit and CanAcceptChar(Key) and TBaseCell(FCell).DisplayIsOpen(True) then
    if (Ord(Key) = VK_RETURN)  and ControlKeyDown then
      begin
        PreProcess;
        Key := #0;            //we handled the key
      end
    else
      inherited;
end;

procedure TGridCellEditor.PreProcessAssignment(IsUAD: Boolean=False);
var
  n, CompID, CellID: Integer;
  CompIDStr, subjDesc, cmpDesc, cmpAdj: String;
  cell: TBaseCell;
  cellCoord: TPoint;
  cellCompID,CellNum: Integer;
  CUID: CellUID;
begin
  compID := -1;
  n := POS('=', TxStr);
  CompIDStr := Copy(TxStr, n+1, Length(TxStr)-n);
  if (CompIDStr = '') or (CompareText(UpperCase(CompIDStr), 'S')= 0) then
    compID := 0
  else
    IsValidInteger(compIDStr, compID);

  if CompID > -1 then
    begin
      LoadTableGrid(False);

      //where are we located in the grid
      cellCompID := FGrid.GetCellCompID(FCellUID, cellCoord);

      //Note: count will always be 1 > than actual comps because of subject
      if (cellCompID <> compID) and (compID < FGrid.count) then
        begin
          cellID := FCell.FCellID;  //common cell identifier so we can mix grids
          if compID = 0 then        //get desc text from subject column
            begin
              FGrid.GetSubject(cellID, subjDesc);
              Text := subjDesc;
            end
              //get desc text and adj from comp column
          else if FGrid.GetComparable(compID, cellID, cmpDesc, cmpAdj) then
            begin
              Text := cmpDesc;

              //put in the adj if cell is in desc column
              if cellCoord.x = 0 then
                begin
                  inc(cellCoord.x);
                  cellNum := FGrid.Comp[cellCompID].GetCellNumber(cellCoord);
                  if cellNum > 0 then  //could be -1 for no existent cell in grid
                    begin
                      CUID := FGrid.Comp[cellCompID].FCX;
                      CUID.num := cellNum-1;    //since zero based
                      cell := TContainer(FDoc).GetCell(CUID);
                      if cell <> nil then
                        begin
                          Cell.LoadData(cmpAdj);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

//github 96: quick adjustment to allow user to put in an adjustment % and get the sales price
//for that comp and multiply with the input adjustment factor to get the real adjustment
procedure TGridCellEditor.PreProcessAdjustment(IsUAD: Boolean=False);
var
  cellCoord: TPoint;
  cellCompID,CellNum: Integer;
  aSalesPriceStr:String;
  aSalesPrice, aFactor, adjustPrice: Double;
begin
  LoadTableGrid(False);

  //where are we located in the grid
  cellCompID := FGrid.GetCellCompID(FCellUID, cellCoord);

  aSalesPriceStr := FGrid.Comp[cellCompID].GetCellTextByID(947); //sales price cellid
  aSalesPrice := GetStrValue(aSalesPriceStr);
  aFactor := GetStrValue(TxStr);
  if pos('-', TxStr) > 0 then   //handle the negative adjustment
     aFactor := (-1) * aFactor;
  adjustPrice := aSalesPrice * (aFactor/100);
  Text := Format('%f',[adjustPrice]);
end;

procedure TGridCellEditor.PreProcessUAD;
var
  aCompID: Integer;
  aCellTxt, aCellTxt2: String;
  aCoord: TPoint;
  aComp: TCompColumn;
  aCellID: Integer;
  UADObject: TUADObject;
begin
  LoadTableGrid(False);
  UADObject := TUADObject.Create(TContainer(FDoc));
  try
    //where are we located in the grid
    aCompID := FGrid.GetCellCompID(FCellUID, aCoord);
    if aCompID < 0 then
      aCompID := 0;
    aComp := FGrid.Comp[aCompID];
    aCellID := aComp.GetCellIDByCoord(aCoord);
    if aCellID = 0 then
      aCellID := FCell.FCellID;
    aCellTxt := TxStr;
    aCellTxt2 := PrefetchUADObject(aCellID, aCellTxt); //make it consistent with Redstone push down format
    Text := UADObject.TranslateToUADFormat(aComp, aCellID, aCellTxt2); //pass to UADObject to do the translation
  finally
    UADObject.Free;
  end;
end;



procedure TGridCellEditor.PreProcessAddition;
var
  N,i: Integer;
  VR: Double;
  V: Array of Double;
begin
  SetLength(V,4);           //max of 4 values
  N := ParseStr(TxStr, V);
  if N > 1 then
    begin
      VR := 0;
      for i := 0 to N-1 do
        VR := VR + V[i];
      Text := Format('%.0n',[VR]);
      V := nil;
    end;
end;

procedure TGridCellEditor.PreProcessMultiply;
var
  N,i: Integer;
  VR: Double;
  V: Array of Double;
begin
  SetLength(V,4);           //max of 4 values
  N := ParseStr(TxStr, V);
  if N > 1 then
    begin
      VR := 1;
      for i := 0 to N-1 do
        VR := VR * V[i];
      Text := Format('%.0n',[VR]);
      V := nil;
    end;
end;



//this routine checks if the form grids allow for processing in the adjustment grid
//some grids only allow for (=, +, -) to be entered which interfers with std preprocessing
function TGridCellEditor.AllowPreProcessing: Boolean;
var
  n: integer;
  cellCoord: TPoint;
begin
 try
  result := True;
  LoadTableGrid(False);                       //if not already loaded, load it
  FGrid.GetCellCompID(FCellUID, cellCoord);   //get get the cellCoord
  n := 0;
  if (cellCoord.X = 1) then                   //we are in adj column
    repeat
      result := not (FCellUID.FormID = NoPreProcessInTheseGridForms[n]);  //if ture, cannot process
      n := n + 1;
    until not result or (n > length(NoPreProcessInTheseGridForms));
except on E:Exception do
//shownotice('TGridCellEditor.AllowPreProcessing:'+e.message);
end;
end;

//Takes text and converts it to meaningful info
// =, =1, =2, etc; for assigning text between grid columns
// N * M; multiplying the numbers and replacing with the result
procedure TGridCellEditor.PreProcess;
var
  Year: Double;
  SiteArea: Double;
  EndIdx, PosItem: Integer;
begin
try
  if AllowPreProcessing then                //do not allow preprocess on certain forms
    if length(TxStr) > 0 then               //we have text
      if POS('=', TxStr) > 0 then           //we have '=' sign
        begin
          //github 96: if we have both = and % do quick adjustment
          if pos('%', TxStr) > 0 then
            PreProcessAdjustment
          else
            PreProcessAssignment;
        end
      else if IsAppPrefSet(bCalcCellEquation) then {and }
        if (POS('*', TxStr) > 0)  or (POS(' x ', TxStr) >0) then    //we have '*' sign
          begin
            PreProcessMultiply;
          end
        else if (POS(' + ', TxStr) > 1) then   //NOTE: >1 has to be between chars
          begin
            PreProcessAddition;
          end
        else if ((FCell.FCellID = 996) or (FCell.FCellID = 2247)) and (length(TxStr) = 4) and HasValidNumber(txStr, Year) and (Year > YearCutOff) then
          begin
            Text := YearBuiltToAge(TxStr, ((not (FCell.ParentPage.ParentForm.ParentDocument as TContainer).UADEnabled) and appPref_AppraiserAddYrSuffix));
          end
        else if (FCell.FCellID = 1237) and appPref_AppraiserDoYear2AgeCalc and (length(TxStr) = 4) and HasValidNumber(txStr, Year) and (Year > YearCutOff) then
          begin //Ticket #1282: include cell id 1237 for form #29 to calculate years to age based on the config
            Text := YearBuiltToAge(TxStr, ((not (FCell.ParentPage.ParentForm.ParentDocument as TContainer).UADEnabled) and appPref_AppraiserAddYrSuffix));
          end
        //github 67
        else if (FCell.FCellID =976) and (length(TxStr) > 0) then
         // PreprocessSpecialCell(976, TxStr)
          PreprocessSpecialCell(FCell, TxStr)
        else if (FDoc As TContainer).UADEnabled and appPref_UADAutoConvert then
          PreprocessUAD;
  except
  on E:Exception do
//    shownotice('TGridCellEditor.Preprocess:'+e.message);
  end;
end;


procedure TGridCellEditor.PreprocessSpecialCell(cell: TBaseCell; str: String);
const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;

var
  Year: Double;
  SiteArea: Double;
  EndIdx, PosItem, CompID: Integer;
  cellCoord: TPoint;
  goOn: Boolean;
begin
  //github 277: if non uad we only do the conversion for form 1025 and 1004C
  if not appPref_UADAutoConvert then
    exit; //if AutoVonvert flag in UADPref dialog not checked donot do conersion
  if not (FDoc as TContainer).UADEnabled then
    case FCellUID.FormID of
      349, 342, 364, 365, 869:
        begin
          if cell.FCellID = 976 then
            goOn := True;
        end;
      else
        goOn := False;
    end
  else
    goOn := True;    //this is UAD enable, we want to move on.
  if not goOn then exit;

  if not assigned(FGrid) then exit;
  LoadTableGrid(false);
  CompID := FGrid.GetCellCompID(FCellUID, cellCoord);   //subj or comp?

  case cell.FCellID of
    976:
      begin
        SiteArea := GetStrValue(str);
        if Assigned(FCell) and (SiteArea > 0) and (TxStr <> '') then
          begin
            PosItem := Pos('ACRE', Uppercase(TxStr));
            if PosItem = 0 then
              PosItem := Pos('AC', Uppercase(TxStr));
            if (PosItem > 0) then
              Text := Trim(Format('%-20.2f', [SiteArea])) + ' ' + cAcres
            else
              // assume square feet
              begin
                if SiteArea >= cAcre then
                  TxStr := Trim(Format('%-20.2f', [SiteArea / cAcre])) + ' ' + cAcres
                else
                  TxStr := Trim(Format('%-20.0f', [SiteArea])) + ' ' + cSqFt;
              end;
            Text := StringReplace(TxStr, ',', '', [rfReplaceAll]);
            if (CompID = 0) and assigned(FDoc) then //for subject only
              TContainer(FDoc).SetCellTextByID(67, Text);
          end;
      end;
  end;
end;

//In grid cells, post processing is for doing auto adjustments
procedure TGridCellEditor.PostProcess;
var
  doc: TContainer;
  CompID, adjID: Integer;
  cellCoord: TPoint;
  SCell, CCell, ACell,PCell: CellUID;
  adjType: Integer;
begin
    try
      doc := TContainer(FDoc);

      adjType := GetAdjustmentType(FCell.FCellID);
      if (FGridType = gtSales) or (FGridType = gtListing) then    //added listings on 9.8.06
      if assigned(doc.docCellAdjusters) then
        if doc.docCellAdjusters.AdjustmentIsActive(adjType, adjID) then
          with doc.docCellAdjusters[adjID] do
              begin
                LoadTableGrid(false);

                CompID := FGrid.GetCellCompID(FCellUID, cellCoord);   //subj or comp?
                if compID > 0 then   //adj only this comp
                  begin
                    if isRoomAdjKind(adjType) then
                      DoRoomadjustment(compID,doc,FGrid,doc.DocCellAdjusters)
                    else if IsAreaBelowAdjKind(adjType) then
                            DoBsmtAreaAdjustment(compID, doc, FGrid, doc.DocCellAdjusters)
                         else if adjType = aaRmsBelow then
                                DoRoomsBelowGradeAdjustment(compID,doc, FGrid,doc.DocCellAdjusters)
                            else
                              if FGrid.GetAdjustmentPair(compID, AdjKind, SCell, CCell, ACell, PCell) then
                                AdjustPair(doc, SCell, CCell, ACell, PCell);
                  end
                else for compID := 1 to FGrid.count-1 do  //subj chged, adj all comps
                  begin
                    if isRoomAdjKind(adjType) then
                      DoRoomadjustment(compID,doc,FGrid,doc.DocCellAdjusters)
                    else if IsAreaBelowAdjKind(adjType) then
                            DoBsmtAreaAdjustment(compID, doc, FGrid, doc.DocCellAdjusters)
                          else if adjType = aaRmsBelow then
                                  DoRoomsBelowGradeAdjustment(compID,doc, FGrid,doc.DocCellAdjusters)
                              else
                                if FGrid.GetAdjustmentPair(compID, AdjKind, SCell, CCell, ACell, PCell) then
                                  AdjustPair(doc, FCellUID, CCell, ACell, PCell);
                  end;
              end;
     except on E:Exception do
    //    shownotice('TGridCellEditor.PostProcess:'+e.message);
     end;
end;

//this replicates the address to the Photo Cells
procedure TGRidCellEditor.ReplicateToPhotos;
var
  CompID: Integer;
  cellCoord: TPoint;
  cell: TBaseCell;
  AddrIndex: Integer;
begin
  LoadTableGrid(false);                                     //make sure we have a table
  CompID := FGrid.GetCellCompID(FCellUID, cellCoord);       //get comp ID and the cell coord
  // JWyatt Modified to use CellID values instead of cell coordinates
  //  as a grid may have address cells in rows 1 and 2 and not rows 0 and 1.
  if (CompID > -1) then
    begin
      cell := FGrid.Comp[CompID].GetCellByCoord(cellCoord);
      if cell <> nil then
        if (cell.FCellID = 925) or (cell.FCellID = 926) then
          begin
            if (cell.FCellID = 925) then
              AddrIndex := 0
            else
              AddrIndex := 1;
            cell := FGrid.Comp[compID].Photo.AddressCell[AddrIndex];       //get address cell
            if cell <> nil then
              Cell.LoadData(TxStr);
          end;
    end;
end;

procedure TGridCellEditor.SaveChanges;
begin
 try
  if FModified then
    begin
      PreProcess;    //before saving, do we have to pre-process  (addition, =1s, etc)
      inherited;     //now save as normal
//    now handled by PostProcess when switching cells
//    PostProcess;   //do we have any auto adjustments
      ReplicateToPhotos;     //replicate comp cells to other forms such as addresses to photo pgs
    end
  else
    inherited;
  except on E:Exception do
//    shownotice('TGridCellEditor.SaveChanges:'+e.message);
  end;

end;

procedure TGridCellEditor.LoadCell(Cell: TBaseCell; cUID: CellUID);
var
  PgTables: TTableList;
begin
  try
  inherited;

  //set the cell's table type
  FGridType := -1;
  PgTables := TDocPage(FCell.FParentPage).pgDesc.PgCellTables;
  if PgTables <> nil then
    FGridType := PgTables.GetCellTableType(FCellUID.Num+1);
  except on E:Exception do
//    shownotice('TGridCellEditor.LoadCell:'+e.message);
  end;

end;



procedure TGridCellEditor.LoadTableGrid(forceIt: Boolean);
begin
  try
  //make sure we deal with same table types
  if forceIt or (assigned(FGrid) and not (FGridType = FGrid.Kind)) then
    FreeAndNil(FGrid);

  //make sure we have a table
  if not assigned(FGrid) then
    begin
   //   FGrid := TGridMgr.Create(True);     //true = OwnsObjects
      FGrid := TCompMgr2.Create(True);      //true = OwnsObjects
      FGrid.BuildGrid(FDoc, FGridType);
    end;
  except on E:Exception do
//    shownotice('TGridCellEditor.LoadTableGrid:'+e.message);
  end;
end;

procedure TGridCellEditor.SwapComparable(Sender: TObject);
var
  Index1, Index2: Integer;
  Pt: TPoint;
begin
  Index1 := FGrid.GetCellCompID(FCellUID, Pt);
  Index2 := TmenuItem(Sender).Tag;
  FGrid.SwapComps(Index1, Index2, False);
  // 092011 JWyatt Refresh current UAD cell to update text
  //if (FDoc as TContainer).UADEnabled then		//### - we should probably always swap active cell
  (FDoc as TContainer).Switch2NewCell(FCell, True);
end;

procedure TGridCellEditor.CopyComparableDescrOnly(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
begin
  SaveChanges;
  Index := FGrid.GetCellCompID(FCellUID, Pt);
  If Index > -1 then
    FGrid.CopyCompToClipboard(Index, false);
end;

procedure TGridCellEditor.CopyComparableWithAdj(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
begin
  SaveChanges;
  Index := FGrid.GetCellCompID(FCellUID, Pt);
  If Index > -1 then
    FGrid.CopyCompToClipboard(Index, true);
end;

procedure TGridCellEditor.PasteComparable(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
begin
  SaveChanges;
  Index := FGrid.GetCellCompID(FCellUID, Pt);
  if Index > -1 then
    FGrid.PasteCompFromClipboard(Index);
  // 092011 JWyatt Refresh current UAD cell to update text
  if (FDoc as TContainer).UADEnabled then
    (FDoc as TContainer).Switch2NewCell(FCell, True);		//### this does not make sense
end;

procedure TGridCellEditor.ClearComparable(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
  Answer: Boolean;
begin
  SaveChanges;
  Index := FGrid.GetCellCompID(FCellUID, Pt);
  if (Index > -1) and WarnOK2Continue('Are you sure you want to clear all the cells in this comparable?') then
    begin
      Answer := False;
      if Assigned(FGrid.Comp[Index].Photo.Cell) then
        Answer := OK2Continue('Do you want to delete the associated photo?');
      FGrid.ClearCompAllCells(Index, Answer);
      //update the net and gross values
      TDocForm(TDocPage(FPage).FParentForm).ProcessMathCmd(UpdateNetGrossID);
      // 092011 JWyatt Refresh current UAD cell to update text
      if (FDoc as TContainer).UADEnabled then		//### this is does not make sense
        (FDoc as TContainer).Switch2NewCell(FCell, True);
    end;
end;

procedure TGridCellEditor.ClearAdjustments(Sender: TObject);
var
  Index: Integer;
  Pt: TPoint;
begin
  SaveChanges;
  Index := FGrid.GetCellCompID(FCellUID, Pt);
  if (Index > -1) then
    begin
      FGrid.ClearCompAdjColumn(Index);
      //update the net and gross values
      TDocForm(TDocPage(FPage).FParentForm).ProcessMathCmd(UpdateNetGrossID);
    end;
end;

procedure TGridCellEditor.BuildPopUpMenu;
var
  MI,subMItem: TMenuItem;
  Index: Integer;
  Pt2: TPoint;
  Name: String;
  i: Integer;
  compValue: String;
  compNo: integer;
  isSales,hasComp, isListing: Boolean;
  subjDesc, cmpDesc, cmpAdj: String;
begin
 try
  inherited;
  isSales := False;
  isListing := False;

  LoadTableGrid(False);                        //make sure we have a table
  Index := FGrid.GetCellCompID(FCellUID, Pt2); //where are we?
  Name := FGrid.GridName;
  if pos('SALE',UpperCase(Name)) > 0 then
    isSales := True
  else if pos('LIST',UpperCase(Name)) > 0 then
    isListing := True;

//### Disable Clear, cut, copy pop up

  MI := TMenuItem.Create(FPopupMenu);
  MI.caption := 'Copy '+ Name + ' (Description Only)';
  MI.OnClick := CopyComparableDescrOnly;
  FPopupMenu.Items.Add(MI);

  MI := TMenuItem.Create(FPopupMenu);
  MI.caption := 'Copy '+ Name + ' All';
  MI.OnClick := CopyComparableWithAdj;
  FPopupMenu.Items.Add(MI);

  MI := TMenuItem.Create(FPopupMenu);
  MI.caption := 'Paste '+ Name;
  MI.OnClick := PasteComparable;
  FPopupMenu.Items.Add(MI);

  MI := TMenuItem.Create(FPopupMenu);
  MI.caption := 'Clear '+ Name;
  MI.OnClick := ClearComparable;
  FPopupMenu.Items.Add(MI);

  MI := TMenuItem.Create(FPopupMenu);
  MI.caption := 'Swap '+ Name + ' with...';
  FPopupMenu.Items.Add(MI);

  for i := 1 to FGrid.Count-1 do
    if i <> Index then
      begin
        subMItem := TMenuItem.Create(MI);
        subMItem.Caption := Name + ' ' + IntToStr(i);
        subMItem.Tag := i;
        subMItem.OnClick := SwapComparable;
        MI.Add(subMItem);
      end;

  FGrid.GetSubject(925, subjDesc);
  hasComp := False;
  for i := 1 to FGrid.Count - 1 do
    begin
      if FGrid.GetComparable(i, 925, cmpDesc, cmpAdj) then
      begin
        hascomp := cmpDesc<>'';
        if hasComp then
          break;
      end;
    end;

  if (subjDesc <>'') or hasComp then
    begin
      //Create UAD Consistency popup
      MI := TMenuItem.Create(FPopupMenu);
      MI.caption := 'Check Comp Consistency';
      FPopupMenu.Items.Add(MI);
      MI.OnClick := ValidateCompDB;
    end;
  if subjDesc <> '' then
  begin
    //Create Save Comps Database popup
    MI := TMenuItem.Create(FPopupMenu);
    MI.caption := 'Save to Comps Database';
    //Add subject
    FPopupMenu.Items.Add(MI);

    subMItem := TMenuItem.Create(MI);
    subMItem.Caption := 'Subject';
    subMItem.Tag := 0;
    subMItem.OnClick := SaveCompSubject;
    MI.Add(subMItem);
  end;
  if hasComp then
    begin
      subMItem := TMenuItem.Create(MI);
      if isSales then
      begin
        subMItem.Caption := 'All Comps';
        subMItem.OnClick := SaveAllComps;
      end
      else if isListing then
      begin
        subMItem.Caption := 'All Listings';
        subMItem.OnClick := SaveAllListings;
      end;
      subMItem.Tag := 100;

      MI.Add(subMItem);
    end;

  //The name here can be sales or listing
  for i := 1 to FGrid.Count-1 do
    begin
      if not FGrid.Comp[i].IsEmpty then
      begin
        subMItem := TMenuItem.Create(MI);

        if isSales then
        begin
          subMItem.Caption := Format('Comp %d',[i]);
        end
        else if isListing then
        begin
          subMItem.Caption := Format('Listing %d',[i])
        end
        else continue;
        subMItem.Tag := i;
        subMItem.OnClick := SaveOneComp;
        subMItem.Name := Format('%s%d',[Name,i]);
        MI.Add(subMItem);
      end;
    end;

  MI := TMenuItem.Create(FPopupMenu);       //divider
  MI.caption := '-';
  FPopupMenu.Items.Add(MI);

  //copy subject or comp field value to all comps
  if CanPropogateCompField(compNo,compValue) then
    begin
      MI := TMenuItem.Create(FPopupMenu);
      MI.Caption := 'Copy Description To All from ';
      if compNo = 0 then
        MI.Caption := MI.Caption + 'Subject'
      else
        MI.Caption := MI.Caption + 'comp#' + IntTostr(compNo);
      MI.OnClick := PropagateCompField;
      MI.ShortCut  := TextToshortcut('Ctrl+=');
      FPopupMenu.Items.Add(MI);
    end;

  if (ClassType = TGridCellEditor) then
    BuildResponseMenu;
 except
//   FModified := False;
 end;
end;

procedure TGridCellEditor.Update;
begin
  if assigned(FGrid) then
    FreeAndNil(FGrid);
end;

function TGridCellEditor.CanPropogateCompField(var CompNo: integer; var fldValue: String): Boolean;
var
  cellCoord: TPoint;
begin
  result := false;
  LoadTableGrid(false);
  compNo := FGrid.GetCellCompID(FCellUID,cellCoord);
  if compNo < 0 then  //it can be subject column on at extra comparable page
    if (FCell.FContextID > 0) and (FGrid.Count > 0) then
      if FCell.FContextID = FGrid.Comp[0].GetCellByID(FCell.FCellID).FContextID then //only subject columns have contextID
        compNo := 0;
  if compNo < 0 then
    exit;
  if cellCoord.X > 0 then //adjustment cell
    exit;
  fldValue := FGrid.Comp[compNo].GetCellTextByID(Fcell.FCellID);
  if length(fldValue) = 0 then
    exit;
  result := true;
end;


procedure TGridCellEditor.PropagateCompField(Sender: Tobject);
var
  fieldValue: String;
  i: integer;
  needOverwrite: Boolean;
  compNo: integer;
  goOn: Boolean;
begin
  if not  CanPropogateCompField(compNo,fieldValue)  then
    exit;
  needOverwrite := false;
  for i := 0 to FGrid.Count - 1 do
    begin
      if i = compNo then
        continue;
      if length(FGrid.Comp[i].GetCellTextByID(FCell.FCellID)) > 0 then
      begin
        needOverwrite := true;
        break;
      end;
    end;
  if needOverwrite then
    if not Ok2Continue('This will copy the Description in the Selected Cell to All Comps in the report, and Replace the Current Contents. Do you want to proceed?') then
      exit;
  for i := 0 to FGrid.Count - 1 do
    begin
      if i = compNo then
        continue;
      if (length(FGrid.Comp[i].GetCellTextByID(cCompAddressCellID)) > 0) then    //skip empty comparable
        begin
          goOn := True;
          if (i = 0) then  //For subject, skip the 5 fields in Subject: Datasource, verf source, sale/finance, concess, date sales
            begin
              case FCell.FCellID of
                 930, 931, 956, 958, 960: goOn := False;
                else
                  goOn := True;
              end;
            end;

          if goOn then
            FGrid.Comp[i].SetCellTextByID(FCell.FCellID, fieldValue);
        end;
    end;
end;


// --- TDateGridEditor --------------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TDateGridEditor.EnforcePreferences;
begin
  {FCellPrefs := SetBit2Flag(FCellPrefs, bCelDateOnly, True);
  FCellFormat := SetBit2Flag(FCellFormat, bDateMDY, True);}
end;

/// summary: Selects the closest matching auto-response item and enters it into the editor.
/// remarks: Disabled for numeric entry.
procedure TDateGridEditor.AutoSelectRspItem;
begin
  // do nothing
end;

/// summary: Processes input from the keyboard.
procedure TDateGridEditor.KeyEditor(var Key: Char);
begin
  {EnforcePreferences;}
  inherited;
end;

/// summary: Converts cell text to the standardized date format (mm/dd/yyyy).
procedure TDateGridEditor.SaveChanges;
var
  DateText: String;
  DateValue: TDateTime;
begin
  inherited;
  // parse and format date
  DateText := Text;
  if (DateText <> '') then
    begin
      if (DateText = '0') then
        Text := ''
      else
        begin
          if (FDoc As TContainer).UADEnabled then
            FCell.HasValidationError := UADDateFormatErr(FCell.FCellXID, CUADDateFormat, DateText)
          else
            FCell.HasValidationError := TextToDateEx(DateText, DateValue);  // dxExEdtr.pas
          FCell.Text := DateText;
        end;
    end
  else
    FCell.HasValidationError := False;

//  inherited;
end;

// --- TNumericGridEditor -----------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TNumericGridEditor.EnforcePreferences;
begin
  {FCellPrefs := SetBit2Flag(FCellPrefs, bCelNumOnly, True);
  FCellPrefs := SetBit2Flag(FCellPrefs, bCelFormat, True);}
end;

/// summary: Filters a string for valid input characters and stops when
///          an invalid character is found.
function TNumericGridEditor.FilterText(const Text: String): String;
var
  Index: Integer;
begin
  Result := '';
  for Index := 1 to Length(Text) do
    begin
      if CanAcceptChar(Text[Index]) then
        Result := Result + Text[Index]
      else
        Break;
    end;
end;

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TNumericGridEditor.HasValidNumber: Boolean;
begin
  Result := True;
end;

/// summary: Selects the closest matching auto-response item and enters it into the editor.
/// remarks: Disabled for numeric entry.
procedure TNumericGridEditor.AutoSelectRspItem;
begin
  // do nothing
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TNumericGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  // 062311 JWyatt Add the minus symbol so negative are acceptable
  // backspace, plus, comma, minus, numbers 0 - 9, delete
  // 062411 JWyatt Remove minus symbol from the initial check array
  //  and add the SelEnd check to the plus/minus test. The SelBeg
  //  test alone introduces a problem where the cell can be blanked
  //  after exiting and re-entering..very strange behavior.
  //   Was: if (Key in [#43, #45]) and (SelBeg = 0) then
  Result := Key in [#8, #37, #35, #43..#45, #48..#57, #61, #127]; //github 96 add % key
  if not Result then
    begin
      // plus, minus
      // only one decimal point allowed
      if (Key = #46) and (Pos('.', Text) = 0) then
        Result := True;
    end;
end;

/// summary: Processes input from the keyboard.
procedure TNumericGridEditor.KeyEditor(var Key: Char);
begin
  {EnforcePreferences;}
  inherited;
end;

/// summary: Inputs a character into the editor.
/// remarks: Enforces the number is always within valid range.
procedure TNumericGridEditor.InputChar(Ch: Char);
begin
  if (Ch = '.') and (Pos(Ch, Text) > 0) then
    // do nothing - prohibit two decimals in number
  else
    inherited;

  if not HasValidNumber then
    UndoEdit;
end;

/// summary: Inputs a string of text from the cursor insertion point.
/// remarks: Filters text for numeric input.
procedure TNumericGridEditor.InputString(const Text: String);
begin
  {EnforcePreferences;}
  inherited InputString(FilterText(Text));
  if not HasValidNumber then
    UndoEdit;
end;

/// summary: Sets the text of the editor.
/// remarks: Filters text for numeric input and enforces the number is always
///          within valid range.
procedure TNumericGridEditor.SetText(const Value: String);
begin
  {EnforcePreferences;}
  inherited SetText(FilterText(Value));
  if not HasValidNumber then
    UndoEdit;
end;

// --- TDollarsNumericGridEditor ----------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TDollarsNumericGridEditor.EnforcePreferences;
begin
//  inherited;
//  FCellFormat := SetBit(FCellFormat, bRnd1P2);
//  FCellFormat := SetBit2Flag(FCellFormat, bDisplayZero, True);
//  FCellFormat := SetBit2Flag(FCellFormat, bAddComma, True);
end;

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TDollarsNumericGridEditor.HasValidNumber: Boolean;
var
  Index: Integer;
begin
  Index := Pos('.', Text);
  Result := (Index = 0) or (Length(Text) <= Index + 2);
end;

// --- TPositiveDollarsNumericGridEditor --------------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveDollarsNumericGridEditor.HasValidNumber: Boolean;
begin
  Result := inherited HasValidNumber;
  Result := Result and (GetValue >= 0);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveDollarsNumericGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

// --- TPositiveDollarsFormattedGridEditor --------------------------------------

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveDollarsFormattedGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result or (Key in [#36]);  // $ prefix allowed
end;

/// summary: Converts cell text to a number with preceding $ symbol
procedure TPositiveDollarsFormattedGridEditor.SaveChanges;
var
  ValText: String;
begin
  if FModified then
    begin
      inherited;     //now save as normal
      ValText := Text;
      if (Trim(Text) <> '') and (Pos('$', Text) = 0) and (Pos('=', Text) = 0) then
         FCell.Text := '$' + ValText;
    end
  else
    inherited;
end;

// --- TWholeNumericGridEditor ------------------------------------------------

/// summary: Resets preferences to their mandatory settings.
procedure TWholeNumericGridEditor.EnforcePreferences;
begin
//  inherited;
//  FCellFormat := SetBit(FCellFormat, bRnd1);
//  FCellFormat := SetBit2Flag(FCellFormat, bDisplayZero, True);
//  FCellFormat := SetBit2Flag(FCellFormat, bAddComma, True);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TWholeNumericGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  // 083111 JWyatt Following removed to allow entry of a decimal point - formatting on exit
  //  Result := Result and not (Key = #46);  // not decimal
end;

// --- TPositiveWholeNumericGridEditor ----------------------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveWholeNumericGridEditor.HasValidNumber: Boolean;
begin
  Result := inherited HasValidNumber;
  Result := Result and (GetValue >= 0);
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveWholeNumericGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

// --- TPositiveWholeTenThousandsNumericGridEditor ----------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TPositiveWholeTenThousandsNumericGridEditor.HasValidNumber: Boolean;
var
  Value: Double;
begin
  Result := inherited HasValidNumber;
  Value := GetValue;
  Result := Result and ((Value >= 0) and (Value <= 99999));
end;

/// summary: Indicates whether a key can be accepted as valid input.
/// remarks: Filters key strokes for numeric input.
function TPositiveWholeTenThousandsNumericGridEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := inherited CanAcceptChar(Key);
  Result := Result and not (Key in [#43, #45]);  // not plus or minus
end;

{ TFreeTxEditor }

procedure TFreeTxEditor.RightClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
begin
  //do nothing for now on right click
end;

procedure TFreeTxEditor.IdleEditor;
begin
  If FActive and not FItem.ParentViewPage.PgCollapsed then
    BlinkCaret;
end;

function TFreeTxEditor.HasActiveCellOnPage(Page: TObject): Boolean;
begin
	result := False;
	if (FItem <> nil) then
		result := (FItem.FParentPage = Page);
end;

procedure TFreeTxEditor.DrawCurCell;
var
	sBox: TRect;
begin
  //erase what was there
  FCanvas.Brush.color := clWhite;
	FCanvas.Brush.Style := bsSolid;
  FCanvas.FillRect(ScaleRect(FFrame, cNormScale, scale));

  FCanvas.Font.Assign(FFont);
  FCanvas.Font.Height := -MulDiv(FCanvas.Font.Size, scale, cNormScale);
  FCanvas.Font.Color := TContainer(FDoc).docColors[cFreeTxColor];

  //resize the text rect
  sBox := ScaleRect(FFrame, cNormScale, scale);
  FitTextInBox(FCanvas, TxStr, sBox);
  FFrame := ScaleRect(sBox, scale, cNormScale);

  if assigned(FItem) then  //check becuase we have bugs between FItem & FCell
    begin
      FFrame.Right := FFrame.Right + 1;         // inset text area one pixel
      FItem.Bounds := FFrame;
      TxRect := FFrame;
      TxRect.Left := TxRect.Left + 1;

      sBox := TxRect;
      sBox := ScaleRect(sBox, cNormScale, scale);
      SelectClipRgn(FCanvas.Handle, 0);
      DrawString(FCanvas, sBox, TxStr, tjJustLeft, False);
      FCaretOn := False;
    end;
end;

procedure TFreeTxEditor.SaveChanges;
begin
  if FModified and assigned(FItem) then
    begin
      TFreeText(FItem).FFontSize :=  FFont.Size;
      TFreeText(FItem).FFontStyle := FFont.Style;
      TFreeText(FItem).Text := TxStr;
      FItem.Modified := FModified;
      FModified := False;
    end;
end;

procedure TFreeTxEditor.UnLoadCell;
begin
  FItem := nil;

  inherited UnLoadCell;
end;

procedure TFreeTxEditor.UnHilightCell;
var
	curFocus: TFocus;
begin
  GetViewFocus(FCanvas.Handle, curFocus);
  FocusOnCell;
  DrawCurCell;    //redraw because Clip needs to be reconfigured
  SetViewFocus(FCanvas.handle, curFocus);
end;

procedure TFreeTxEditor.LoadItem(Item: TMarkupItem);
begin
  inherited LoadItem(Item);

  if assigned(Item) then
    with Item as TFreeText do
      begin
       TxStr := Text;                       //this is a copy of the text to edit
        SelBeg := Length(TxStr);             //set the editor vars
        SelEnd := SelBeg;
        NumChs := SelBeg;
        TxRect := Bounds;                       //the text rect = the frame
        TxRect.Left := TxRect.Left + 1;         //don't blink on edge
        FTxJust := tjJustLeft;                   //always left justified
        FFont.Size := FFontSize;
        FFont.Style := FFontStyle;
        FFont.OnChange := OnFontChanged;
      end;
end;

procedure TFreeTxEditor.ReplaceLnSel(S: String);
begin
  if FUpperCase then S := Uppercase(S);

	UndoText := Copy(TxStr, SelBeg+1, SelEnd-SelBeg);  {save what we are deleting}
	UndoBeg := SelBeg;
	UndoEnd := UndoBeg + Length(S);									{undo what is being inserted}
	Delete(TxStr, selBeg+1, SelEnd-SelBeg);
	Insert(S, TxStr, SelBeg+1);
	SelBeg := SelBeg + Length(S);
	SelEnd := SelBeg;
	NumChs := Length(TxStr);
	DrawCurCell;
end;

procedure TFreeTxEditor.InsertLnText(S: string);
begin
  if FUpperCase then S := Uppercase(S);

	EraseCaret;
	UndoText := '';
	UndoBeg := SelBeg;
	UndoEnd := SelBeg + Length(S);
  if KeyOverWriteMode then Delete(TxStr, SelBeg+1, Length(S));
	Insert(S, TxStr, SelBeg+1);
	SelBeg := UndoEnd;
	SelEnd := UndoEnd;
	numChs := Length(TxStr);
	DrawCurCell;
end;

procedure TFreeTxEditor.KeyEditor(var Key: Char);
var
	OKey: Integer;
	Pt: TPoint;
	curFocus: TFocus;
begin
if FActive and FCanEdit and CanAcceptChar(Key) then
	begin
		Pt := TBaseCell(FItem).Caret2View(TxCaret);		//special to convert view pt to doc
		TContainer(FDoc).MakePtVisible(Pt);           //make it visible

		GetViewFocus(FCanvas.Handle, curFocus);
		FocusOnCell;

		UndoText := '';
		undoBeg := 0;
		undoEnd := 0;

		OKey := ord(Key);
    //delete keys
		if (OKey = kBkSpace) or (OKey = kClearKey) or (OKey = kDeleteKey) then			{control chars}
			begin
				if SelBeg <> SelEnd then
					DeleteLnSel
				else if (OKey = kDeleteKey) then
					DeleteForwardLnChar
				else
					DeleteLnChar;
			end

    //regular text entry
    else
			begin
				if SelBeg <> SelEnd then
					ReplaceLnSel(Key)
				else
					InsertLnText(Key);
			end;
		SetCaret;

		SetViewFocus(FCanvas.handle, curFocus);
		FModified := True;
	end;

	Key := #0;            //we handled the key

end;

procedure TFreeTxEditor.PasteText(theText: string);
var
	curFocus: TFocus;
begin
  inherited;

  GetViewFocus(FCanvas.Handle, curFocus);
  FocusOnCell;
  DrawCurCell;    //redraw because Clip needs to be reconfigured
  SetViewFocus(FCanvas.handle, curFocus);
end;

// *** Unit *****************************************************************

/// summary: Initializes the unit.
procedure InitializeUnit;
begin
  if not Assigned(GEditorClassList) then
    GEditorClassList := TStringList.Create;
end;

/// summary: Gets the cell editor class type for the specified registered class name.
function GetEditorClass(const ClassName: String): TCellEditorClass;
var
  Index: Integer;
begin
  InitializeUnit;
  Index := GEditorClassList.IndexOf(ClassName);
  if (Index > -1) then
    Result := TCellEditorClass(GEditorClassList.Objects[Index])
  else
    Result := nil;
end;

/// summary: registers a cell editor.
procedure RegisterEditor(const CellEditorClass: TCellEditorClass);
begin
  InitializeUnit;
  GEditorClassList.AddObject(CellEditorClass.ClassName, Pointer(CellEditorClass));
end;

/// summary: unregisters a cell editor.
procedure UnRegisterEditor(const CellEditorClass: TCellEditorClass);
begin
  InitializeUnit;
  GEditorClassList.Delete(GEditorClassList.IndexOfObject(Pointer(CellEditorClass)));
end;


procedure TGridCellEditor.SaveCompSubject(Sender: TObject);
var
  compDB:TCompsDBList;
  DBCompsID: Integer;
begin
  try
    compDB := TCompsDBList.Create(nil, 1, 0);
    compDB.LoadFieldToCellIDMap;
    compDB.OnRecordsMenuClick(Sender);
    if not CompDB.dxDBGrid.DataSource.DataSet.Eof then
      DBCompsID := compDB.dxDBGrid.DataSource.DataSet.FieldByName('CompsID').AsInteger;
    //compDB.ImportSubjectMenuClick(Sender);
    compDB.ImportSubject(0);
    ShowNotice('The Subject has been saved to the Comps Database.');
    compDB.Close;   //this will do a closeDB
  finally
    compDB.Free;
    RefreshCompList(DBCompsID);
  end;
end;

procedure TGridCellEditor.SaveAllComps(Sender: TObject);
var
  compDB:TCompsDBList;
  DBCompsID: Integer;
begin
  try
    compDB := TCompsDBList.Create(nil, 1, 0);
    compDB.LoadFieldToCellIDMap;
    compDB.OnRecordsMenuClick(Sender);
    if not CompDB.dxDBGrid.DataSource.DataSet.Eof then
      DBCompsID := compDB.dxDBGrid.DataSource.DataSet.FieldByName('CompsID').AsInteger;
    compDB.ImportOption := 0; //0-saving
    compDB.ImportAllCompsMenuClick(Sender);
    ShowNotice('All Comps have been saved to the Comps Database.');
    compDB.Close;   //this will do a closeDB
  finally
    compDB.Free;
    refreshCompList(DBCompsID);
  end;
end;



procedure TGridCellEditor.SaveAllListings(Sender: TObject);
var
  compDB:TCompsDBList;
  DBCompsID: Integer;
begin
  try
    compDB := TCompsDBList.Create(nil, 1, 0);
    compDB.LoadFieldToCellIDMap;
    compDB.OnRecordsMenuClick(Sender);
    if not CompDB.dxDBGrid.DataSource.DataSet.Eof then
      DBCompsID := compDB.dxDBGrid.DataSource.DataSet.FieldByName('CompsID').AsInteger;
    compDB.ImportOption := 0; //0-saving
    compDB.ImportAllListingsMenuClick(Sender);
    ShowNotice('All Listings are saved to Comps Database.');
    compDB.Close;   //this will do a closeDB
  finally
    compDB.Free;
    refreshCompList(DBCompsID);
  end;
end;


procedure TGridCellEditor.ValidateCompDB(Sender: TObject);
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


procedure TGridCellEditor.SaveOneComp(Sender: TObject);
var
  compDB:TCompsDBList;
  msg,Name:String;
  CompID: Integer;
  DBCompsID: Integer;
begin
  try
    compDB := TCompsDBList.Create(nil,1,0);
    compDB.LoadFieldToCellIDMap;
    compDB.OnRecordsMenuClick(Sender);
      Name := TMenuItem(Sender).Name;
      COmpID := TMenuItem(Sender).Tag;
      if not CompDB.dxDBGrid.DataSource.DataSet.Eof then
        DBCompsID := compDB.dxDBGrid.DataSource.DataSet.FieldByName('CompsID').AsInteger;
      if pos('Listing',Name) > 0 then
      begin
        compDB.ImportOption := 0; //0-saving
        compDB.ImportListingMenuclick(Sender);
        msg := Format('Listing %d data has been saved to Comps Database.',[CompID]);
      end
      else
      begin
        compDB.ImportOption := 0; //0-saving
        compDB.ImportCompMenuClick(Sender);
        msg := Format('Comp %d data has been saved to Comps Database.',[CompID]);
      end;
      ShowNotice(msg);
    compDB.Close;   //this will do a closeDB
  finally
    compDB.Free;
    refreshCompList(DBCompsID);
  end;
end;



initialization
  RegisterEditor(TAdvertisementCellEditor);
  RegisterEditor(TChkBoxEditor);
  RegisterEditor(TCompanyNameEdtor);
  RegisterEditor(TDeedPlotEditor);
  RegisterEditor(TGraphicEditor);
  RegisterEditor(TGridCellEditor);
  RegisterEditor(TDateGridEditor);
  RegisterEditor(TNumericGridEditor);
  RegisterEditor(TDollarsNumericGridEditor);
  RegisterEditor(TPositiveDollarsNumericGridEditor);
  RegisterEditor(TPositiveDollarsFormattedGridEditor);
  RegisterEditor(TWholeNumericGridEditor);
  RegisterEditor(TPositiveWholeNumericGridEditor);
  RegisterEditor(TPositiveWholeTenThousandsNumericGridEditor);
  RegisterEditor(TImageToolEditor);
  RegisterEditor(TLicenseeEditor);
  RegisterEditor(TMapEditor);
  RegisterEditor(TMapFloodEditor);
  RegisterEditor(TMapLocEditor);
  RegisterEditor(TMapPlatEditor);
  RegisterEditor(TMLEditor);
  RegisterEditor(TSignerEditor);
  RegisterEditor(TSketchEditor);
  RegisterEditor(TSLEditor);
  RegisterEditor(TDateSLEditor);
  RegisterEditor(TNumericSLEditor);
  RegisterEditor(TPositiveNumericSLEditor);
  RegisterEditor(TDollarsNumericSLEditor);
  RegisterEditor(TPositiveDollarsNumericSLEditor);
  RegisterEditor(TWholeNumericSLEditor);
  RegisterEditor(TPositiveWholeNumericSLEditor);
  RegisterEditor(TPositiveWholePercentNumericSLEditor);
  RegisterEditor(TPositiveWholeTenThousandsNumericSLEditor);

finalization
  FreeAndNil(GEditorClassList);

end.

