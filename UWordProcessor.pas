unit UWordProcessor;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

interface

uses
  ActnList,
  Classes,
  Controls,
  Dialogs,
  Graphics,
  StdCtrls,
  Types,
  UCell,
  UClasses,
  UEditor,
  UFonts,
  UGlobals,
  WPCTRRich,
  WPRTEDefs,
  WPRTEPaint;

type
  // forward declarations
  TWordProcessorCell = class;
  TWordProcessorEditor = class;

  // TWordProcessorEngine
  TWordProcessorEngine = class(TWPRTFEnginePaint)
    public
      property DisplayOnlyOnePage: Boolean read FDisplayOnlyOnePage write FDisplayOnlyOnePage;
      property DisplayOnlyPage: Integer read FDisplayOnlyPage write FDisplayOnlyPage;
  end;

  // TWordProcessorControl
  TSetBoundsEvent = procedure (var ALeft, ATop, AWidth, AHeight: Integer) of object;
  TWordProcessorControl = class(TWPRichText)
    private
      FOnSetBounds: TSetBoundsEvent;
    private
      function GetDisplayOnlyOnePage: Boolean;
      procedure SetDisplayOnlyOnePage(const Value: Boolean);
      function GetDisplayOnlyPage: Integer;
      procedure SetDisplayOnlyPage(const Value: Integer);
      function GetLineCount: Integer;
    protected
      procedure KeyPress(var Key: Char); override;
      procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    public
      destructor Destroy; override;
      procedure InitializePaintPages;
      procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    public
      property DisplayOnlyOnePage: Boolean read GetDisplayOnlyOnePage write SetDisplayOnlyOnePage;
      property DisplayOnlyPage: Integer read GetDisplayOnlyPage write SetDisplayOnlyPage;
      property LineCount: Integer read GetLineCount;
      property OnSetBounds: TSetBoundsEvent read FOnSetBounds write FOnSetBounds;
  end;

  // TWordProcessorFont
  TWordProcessorFont = class(TCellFont)
    public
      constructor Create;
  end;

  // TWordProcessorCellList
  TWordProcessorCellList = class(TCellList)
    private
      FUpdating: Boolean;
    private
      procedure BubbleSort(const StartIndex: Integer);
    protected
      function Get(Index: Integer): TWordProcessorCell;
      procedure Put(Index: Integer; Item: TWordProcessorCell);
      procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    public
      function Extract(Item: TWordProcessorCell): TWordProcessorCell;
      function First: TWordProcessorCell;
      function Last: TWordProcessorCell;
      procedure Sort;
      property Items[Index: Integer]: TWordProcessorCell read Get write Put; default;
  end;

  // TWordProcessorCell
  TWordProcessorCell = class(TDataBoundCell)
    private
      FAutoExpanding: Boolean;
      FControl: TWordProcessorControl;
      FMainEditor: TWordProcessorEditor;
      FRTFData: TWPRTFDataCollection;
      FRTFProps: TWPRTFProps;
    private
      //function CheckWordWrap(TestStr: String): LineStarts;
      function FontToCharAttr(const Font: TFont): Cardinal;
      function GetDataLink(Index: Integer): TWordProcessorCell;
      function GetDisplayPageNumber: Integer;
      procedure SetDisplayPageNumber(const PageNo: Integer);
      function GetPageCount: Integer;
      function GetRichText: String;
      procedure SetRichText(const Value: String);
      procedure RichTextChanged(Sender: TObject);
      function GetRTFData: TWPRTFDataCollection;
    protected
      procedure Loaded; override;
      function GetDataCell: TWordProcessorCell;
      procedure AttachDataLink; override;
      procedure DetachDataLink; override;
      function GetEditorClass: TCellEditorClass; override;
      procedure InitializePaintPages;
      procedure InternalMergeDocument(const ForeignDataCell: TWordProcessorCell; const InsertPageNo: Integer);
      procedure InputString(const Text: String);
      procedure InputStringRich(const Text: String);
      procedure InputStringPlain(const Text: String);
      procedure PropertiesChanged; override;
      procedure PaintTo(DC: THandle; X, Y: Integer);
      procedure TransferDataSource(const NewDataCell: TDataBoundCell); override;
    public
      constructor Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject); override;
      destructor Destroy; override;
      procedure Assign(Source: TBaseCell); override;
      procedure PopulateDataLinkList(var List: TWordProcessorCellList);
      procedure DoSetText(const Str: String); override;
      function FilterString(const Text: String): String;
      procedure DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean); override;
      procedure DragDrop(Sender, Source: TObject; X,Y: Integer); override;
      procedure SetCellSampleEntry; override;
      procedure MergeDocument(const ForeignDataCell: TWordProcessorCell; const InsertPageNo: Integer);
      procedure CopyPage(const Source: TWordProcessorCell; const InsertPageNo: Integer);
      procedure DeletePage;
      procedure InsertMissingPages;
      procedure RemoveExtraPages;
      function AppendSection(const Header: String; const Body: String): Integer;
      procedure DeleteSection(const SectionID: Integer);
      function FindFirstSectionPar(const SectionID: Integer): TParagraph;
      procedure RewriteSection(const SectionID: Integer; const Header: String; const Body: String);
      function Format(value: String): String; override;
      procedure MungeText; override;
      procedure PostProcess; override;
      procedure ReadCellData(stream: TStream; Version: Integer); override;
      procedure WriteCellData(stream: TStream); override;
      procedure SetFontStyle(fStyle: TFontStyles);  override;
    public
      property AutoExpanding: Boolean read FAutoExpanding write FAutoExpanding;
      property DataCell: TWordProcessorCell read GetDataCell;
      property DataLinks[Index: Integer]: TWordProcessorCell read GetDataLink;
      property DisplayPageNumber: Integer read GetDisplayPageNumber write SetDisplayPageNumber;
      property PageCount: Integer read GetPageCount;
      property RichText: String read GetRichText write SetRichText;
      property RTFData: TWPRTFDataCollection read GetRTFData;
      property MainEditor: TWordProcessorEditor read FMainEditor write FMainEditor;
  end;

  // TWordProcessorEditor
  TWordProcessorEditor = class(TTextEditor)
    private
      FActionList: TActionList;
      FCell: TWordProcessorCell;
      FFont: TWordProcessorFont;
      FResponseList: TListBox;
    private
      procedure HideResponses;
      procedure ShowResponses;
      procedure OnActPasteTextExecute(Sender: TObject);
      procedure OnActPasteTextUpdate(Sender: TObject);
      procedure OnActSaveResponseExecute(Sender: TObject);
      procedure OnActSaveResponseUpdate(Sender: TObject);
      procedure OnActMenuFontExecute(Sender: TObject);
      procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
      procedure OnResponseClick(Sender: TObject);
      procedure OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure OnResponseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure OnFontChanged(Sender: TObject);
      procedure OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure OnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure OnSetBounds(var ALeft, ATop, AWidth, AHeight: Integer);
      procedure OnTextChanged(Sender: TObject);
      function MakeAscii(const Ch: Char): Char;
      procedure MakeColoredText(const Color: TColor);
      procedure MakeUniformText(const Font: TFont);
      procedure MakeUpperCaseText;
      procedure ReverseSelection;
    protected
      FControl: TWordProcessorControl;
    public
      constructor Create(AOwner: TAppraisalReport); override;
      destructor  Destroy; override;
      procedure   LoadCell(Cell: TBaseCell; cUID:CellUID); override;
      procedure   UnLoadCell; override;
      procedure   LoadLinkedEditor(const LinkedCell: TWordProcessorCell);
      procedure   ActivateEditor; override;
      procedure   IdleEditor; override;
      procedure   PositionEditor;
      procedure   ScrollCaretIntoView;
      function    MoveCaretToSection(const SectionID: Integer): Boolean;
      procedure   ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
      procedure   KeyEditor(var Key: Char); override;
      procedure   InputStringRich(const Text: String);
      procedure   InputStringPlain(const Text: String);
      function    CanClear: Boolean; override;
      procedure   ClearEdit; override;
      function    CanUndo: Boolean; override;
      procedure   ClearUndo; override;
      procedure   UndoEdit; override;
      function    CanCut: Boolean; override;
      procedure   CutEdit; override;
      function    CanCopy: Boolean; override;
      procedure   CopyEdit; override;
      function    CanPaste: Boolean; override;
      procedure   PasteEdit; override;
      function    CanSelectAll: Boolean; override;
      procedure   SelectAll; override;
      function    CanSpellCheck: Boolean; override;
      procedure   LoadCellRsps(Cell: TBaseCell; cUID:CellUID); override;
      procedure   SaveToRspList(Sender: TObject); override;
      procedure   SetAutoRsp(Value: Boolean); override;
      procedure   UnLoadCellRsps; override;
      procedure   BuildPopUpMenu; override;
      procedure   InitCaret(Clicked: Boolean); override;
      function    HasActiveCellOnPage(Page: TObject): Boolean; override;
      function    HasContents: Boolean; override;
      function    HasSelection: Boolean; override;
      procedure   ResetScale; override;
      function    TextOverflowed: Boolean; override;
      function    CanLinkComments: Boolean; override;

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
      function  CanFormatText: Boolean; override;
      function  GetFont: TCellFont; override;
      function  GetTextJustification: Integer; override;
      procedure SetTextJustification(const Value: Integer); override;
  end;

implementation

uses
  Windows,
  Clipbrd,
  DBConsts,
  Forms,
  IdCoderMIME,
  Math,
  Menus,
  SysUtils,
  UBase,
  UContainer,
  UDebugTools,
  UDrag,
  UDocView,
  UEditorDialog,
  UForm,
  UMain,
  UPage,
  UStatus,
  UStdCmtsEdit,
  UStdRspUtil,
  UUADUtils,
  UUtil1,
  WPCTRMemo;

const
  // action names
  CActionPaste = 'EditPasteCmd';
  CActionPasteText = 'ActionPasteText';
  CActionSaveComment = 'ActionSaveComment';
  CActionFontMenu = 'ActionFontMenu';

  // cell properties
  CPropertyRichTextMIME = 'RichTextMIME';
  CPropertyDisplayPageNumber = 'DisplayPageNumber';

// --- TWordProcessorControl --------------------------------------------------

procedure TWordProcessorControl.KeyPress(var Key: Char);
begin
  if IsAppPrefSet(bUppercase) then
    Key := UpCase(Key);

  inherited;
end;

procedure TWordProcessorControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  MouseKeeper: THandle;
begin
  // get mouse capture when holding the left mouse button
  MouseKeeper := GetCapture;
  if (ssLeft in Shift) and (MouseKeeper = 0) then
    SetCapture(Handle)
  else if not (ssLeft in Shift) and (MouseKeeper = Handle) then
    ReleaseCapture;

  // ensure coordinates are within the word processor page area
  X := Max(X, 0);
  Y := Max(Y, 0);

  inherited;
end;

procedure TWordProcessorControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if Assigned(FOnSetBounds) then
    FOnSetBounds(ALeft, ATop, AWidth, AHeight);

  inherited;
end;

destructor TWordProcessorControl.Destroy;
begin
  Parent := nil;     // fix defect in WPTools6; crashes without this
  PopupMenu := nil;  // fix defect in WPTools6; crashes without this
  inherited;
end;

/// summary: Initializes the paint pages in the RTF memo.
///          Use this method to repair incorrect memo page counts.
procedure TWordProcessorControl.InitializePaintPages;
begin
  FMemo.Cursor.RTFEngine := FMemo;
  FMemo.DisplayedText := RTFData.Get(wpIsBody, wpraOnAllPages);
  FMemo.Cursor.RTFData := FMemo.DisplayedText;
  FMemo.InitializePaintPages;
end;

function TWordProcessorControl.GetDisplayOnlyOnePage: Boolean;
begin
  Result := TWordProcessorEngine(Memo).DisplayOnlyOnePage;  // "unsafe" type-cast, but I know what I'm doing
end;

procedure TWordProcessorControl.SetDisplayOnlyOnePage(const Value: Boolean);
begin
  TWordProcessorEngine(Memo).DisplayOnlyOnePage := Value;  // "unsafe" type-cast, but I know what I'm doing
end;

function TWordProcessorControl.GetDisplayOnlyPage: Integer;
begin
  Result := TWordProcessorEngine(Memo).DisplayOnlyPage;  // "unsafe" type-cast, but I know what I'm doing
end;

procedure TWordProcessorControl.SetDisplayOnlyPage(const Value: Integer);
begin
  TWordProcessorEngine(Memo).DisplayOnlyPage := Value;  // "unsafe" type-cast, but I know what I'm doing
end;

function TWordProcessorControl.GetLineCount: Integer;
var
  Paragraph: TParagraph;
  LineCount: Integer;
begin
  LineCount := 0;

  if ActiveText <> nil then
    Paragraph := ActiveText.FirstPar
  else
    Paragraph := FirstPar;

  while (Paragraph <> nil) do
  begin
    LineCount := LineCount + Paragraph.LineCount;
    Paragraph := Paragraph.next;
  end;

  Result := LineCount;
end;

// --- TWordProcessorFont -----------------------------------------------------

constructor TWordProcessorFont.Create;
begin
  inherited;
  FMaxSize := 96;
end;

// --- TWordProcessorCellList -------------------------------------------------

procedure TWordProcessorCellList.BubbleSort(const StartIndex: Integer);
var
  Index: Integer;
begin
  for Index := Max(StartIndex, 1) to Count - 1 do
    if (Items[Index - 1].DisplayPageNumber > Items[Index].DisplayPageNumber) then
      begin
        Exchange(Index, Index - 1);
        BubbleSort(1);
      end
end;

function TWordProcessorCellList.Get(Index: Integer): TWordProcessorCell;
begin
  Result := TObject(inherited Get(Index)) as TWordProcessorCell;
end;

procedure TWordProcessorCellList.Put(Index: Integer; Item: TWordProcessorCell);
begin
  inherited Put(Index, Item);
end;

procedure TWordProcessorCellList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if not FUpdating then
    begin
      Sort;
      inherited;
    end;
end;

function TWordProcessorCellList.Extract(Item: TWordProcessorCell): TWordProcessorCell;
begin
  Result := TObject(inherited Extract(Item)) as TWordProcessorCell;
end;

function TWordProcessorCellList.First: TWordProcessorCell;
begin
  Result := TObject(inherited First) as TWordProcessorCell;
end;

function TWordProcessorCellList.Last: TWordProcessorCell;
begin
  Result := TObject(inherited Last) as TWordProcessorCell;
end;

procedure TWordProcessorCellList.Sort;
begin
  FUpdating := True;
  try
    BubbleSort(1);
  finally
    FUpdating := False;
  end;
end;

// --- TWordProcessorCell -----------------------------------------------------

{  unlike TMLnTextCell TWordProcessCell doesnot use LineStarts
borrowed from TMLnTextCell for saving the cell with backwards compatibility
function TWordProcessorCell.CheckWordWrap(TestStr: String): LineStarts;
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
    font.Assign((FParentPage.FParentForm.FParentDoc as TContainer).docFont);
    font.Height := -MulDiv(FTxSize, docView.PixScale, cNormScale);
    font.Style := FTxStyle;
    SelectObject(memDC,font.Handle);
    regTextWidth := MulDiv(FFrame.right - FFrame.Left, docView.PixScale, cNormScale);
    indent := 0;

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
    if length(remStr) > 0 then    //last line wo CR
      BreakUpByTextWidth(memDC,remStr,strOffset,regTextWidth,indent,result);
  finally
    DeleteDC(memDC);
    font.Free;
  end;
end;        }

/// summary: Converts a font to a character attribute value.
function TWordProcessorCell.FontToCharAttr(const Font: TFont): Cardinal;
begin
  FControl.AttrHelper.Clear;
  FControl.AttrHelper.SetFontName(Font.Name);
  FControl.AttrHelper.SetFontSize(Font.Size);
  FControl.AttrHelper.SetFontStyle(Font.Style);
  FControl.AttrHelper.SetFontCharSet(Font.Charset);
  FControl.AttrHelper.SetColor(Font.Color);
  Result := FControl.AttrHelper.CharAttr;
end;

function TWordProcessorCell.GetDataLink(Index: Integer): TWordProcessorCell;
begin
  Result := inherited GetDataLink(Index) as TWordProcessorCell;
end;

function TWordProcessorCell.GetDisplayPageNumber: Integer;
begin
  Result := StrToIntDef(Properties[CPropertyDisplayPageNumber], 1);
end;

procedure TWordProcessorCell.SetDisplayPageNumber(const PageNo: Integer);
var
  Page: TDocPage;
begin
  Page := ParentPage as TDocPage;

  if (PageNo = 1) then
    Page.SetPgTitleName(Page.pgDesc.PgName)
  else if (PageNo < MaxInt) then
    Page.SetPgTitleName(Page.pgDesc.PgName + ' Page ' + IntToStr(PageNo));

  Properties[CPropertyDisplayPageNumber] := IntToStr(PageNo);

  if Assigned(Editor) then  // reload editor
    (Editor as TEditor).LoadCell(Self, UID);
end;

function TWordProcessorCell.GetPageCount: Integer;
begin
  Result := DataCell.FControl.PageCount;
end;

function TWordProcessorCell.GetRichText: String;
begin
  Result := FControl.AsString;
end;

procedure TWordProcessorCell.SetRichText(const Value: String);
begin
  FControl.AsString := Value;
end;

procedure TWordProcessorCell.RichTextChanged(Sender: TObject);
begin
  FControl.ReformatAll(True, True);
  FText := StringReplace(FControl.AsAnsiString, Char(kReturnKey), '', [rfReplaceAll]);
  FEmptyCell := Length(FText) = 0;
end;

function TWordProcessorCell.GetRTFData: TWPRTFDataCollection;
begin
  Result := DataCell.FRTFData;
end;

procedure TWordProcessorCell.Loaded;
begin
  inherited;
  FControl.ReformatAll(True, True);
end;

function TWordProcessorCell.GetDataCell: TWordProcessorCell;
begin
  Result := inherited GetDataCell as TWordProcessorCell;
end;

procedure TWordProcessorCell.AttachDataLink;
begin
  inherited;
  if (DataCell <> Self) then
    begin
      Text := '';
      FControl.RemoveRTFData;
      FControl.SetRTFData(DataCell.FRTFData);
    end;

  if Assigned(DataCell.FMainEditor) then
    DataCell.FMainEditor.LoadLinkedEditor(Self);
end;

procedure TWordProcessorCell.DetachDataLink;
begin
  // free resources
  Editor.Free;

  // detatch
  inherited;

  // assign default data source
  FControl.RemoveRTFData;
  FControl.SetRTFData(FRTFData);
  RichTextChanged(FControl);
end;

function TWordProcessorCell.GetEditorClass: TCellEditorClass;
begin
  if (FParentPage.FParentForm.FParentDoc as TContainer).UADEnabled then
    Result := TDialogEditorHelper.GetEditorClass(Self, TWordProcessorEditor)
  else
    Result := TWordProcessorEditor;
end;

/// summary: Initializes the paint pages of all linked cells.
///          Use this method to repair incorrect memo page counts.
procedure TWordProcessorCell.InitializePaintPages;
var
  Index: Integer;
begin
  for Index := 0 to DataCell.DataLinkCount - 1 do
    DataCell.DataLinks[Index].FControl.InitializePaintPages;
end;

/// summary: Merges the document and cells linked with the specified foreign cell into a single document.
/// remarks: This is a lengthy procedure, but I couldn't find any logical place to sub it.
procedure TWordProcessorCell.InternalMergeDocument(const ForeignDataCell: TWordProcessorCell; const InsertPageNo: Integer);
var
  Index: Integer;
  List: TWordProcessorCellList;
  PageCount: Integer;
  PageStart: TParagraph;
  PageEnd: TParagraph;
  Text: String;
begin
  // find insertion point and add page break
  PageStart := FControl.FirstPar;
  while Assigned(PageStart) and (PageStart.pagenr < InsertPageNo - 1) do
    PageStart := PageStart.NextPar;

  if Assigned(PageStart) and Assigned(PageStart.PrevPar) then
    begin
      FControl.TextCursor.MoveTo(PageStart.PrevPar);
      PageStart := FControl.InsertPar;
      PageStart.IsNewPage := True;
    end
  else if not Assigned(PageStart) then
    begin
      PageStart := FControl.FastAppendParagraph;
      PageStart.IsNewPage := True;
    end;

  // insert rich text
  Text := ForeignDataCell.FControl.Text;
  FControl.HideSelection;
  FControl.TextCursor.MoveTo(PageStart);
  FControl.SelectionAsString := Text;

  // add page break at the end
  PageEnd := FControl.TextCursor.active_paragraph;
  if Assigned(PageEnd) and Assigned(PageEnd.NextPar) then
    PageEnd.NextPar.IsNewPage := True;

  // assimilate cells
  PageCount := ForeignDataCell.PageCount;
  List := TWordProcessorCellList.Create;
  try
    PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      if (List[Index].DisplayPageNumber >= InsertPageNo) then
        List[Index].DisplayPageNumber := List[Index].DisplayPageNumber + PageCount;

    ForeignDataCell.PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      begin
        List[Index].DisplayPageNumber := List[Index].DisplayPageNumber + InsertPageNo - 1;
        List[Index].DataSource := InstanceID;
      end;
  finally
    FreeAndNil(List);
  end;

  // reformat text and insert any missing pages
  (FParentPage.FParentForm.FParentDoc as TContainer).DocView.Invalidate;
  RichTextChanged(FControl);
  Modified := True;

  if DataCell.AutoExpanding then
    InsertMissingPages;
end;

procedure TWordProcessorCell.InputString(const Text: String);
begin
  InputStringPlain(Text);
end;

procedure TWordProcessorCell.InputStringRich(const Text: String);
var
  Str: String;
begin
  Str := FilterString(Text);

  if IsAppPrefSet(bUppercase) then
    Str := UpperCase(Str);

  FControl.InputString(Str);
  RichTextChanged(FControl);
  Modified := True;
end;

procedure TWordProcessorCell.InputStringPlain(const Text: String);
var
  Str: String;
begin
  Str := FilterString(Text);

  if IsAppPrefSet(bUppercase) then
    Str := UpperCase(Str);

  FControl.ApplyFont((ParentPage.ParentForm.ParentDocument as TContainer).docFont);
  FControl.InputString(Str);
  RichTextChanged(FControl);
  Modified := True;
end;

procedure TWordProcessorCell.PropertiesChanged;
begin
  inherited;
  FControl.Name := SysUtils.Format('Form%dOccurance%dDisplayPage%d', [UID.FormID, UID.Occur + 1, DisplayPageNumber]);
  FControl.Memo.Name := SysUtils.Format('Form%dOccurance%dDisplayPage%dPaintEngine', [UID.FormID, UID.Occur + 1, DisplayPageNumber]);
end;

{ This procedure duplicates TWPCustomRtfEdit.PaintTo, but fixes a nasty memory leak. }
{ TWPCustomRtfEdit.PaintTo fails to release the off-screen bitmap used for double-buffering. }
procedure TWordProcessorCell.PaintTo(DC: THandle; X, Y: Integer);
var
  PaintMode: TWPPaintDesktopModes;
  Canvas: TCanvas;
  Bitmap: Graphics.TBitmap;
  Box: TRect;
begin
  Bitmap := nil;
  Canvas := nil;
  try
    Bitmap := Graphics.TBitmap.Create;
    Canvas := TCanvas.Create;
    Canvas.Handle := DC;
    PaintMode := [wpDrawFocusOptional, wpDontUseDoubleBuffer];
    Bitmap.Width := FControl.Width;
    Bitmap.Height := FControl.Height;

    Box := Rect(0, 0, Bitmap.Width, Bitmap.Height);
    //FControl.Memo.PaintDesktop(Bitmap.Canvas, Bitmap.Width, Bitmap.Height, PaintMode);  // zooming is ignored
    FControl.PrintPageOnCanvas(Bitmap.Canvas, box, DisplayPageNumber - 1, [ppmIgnoreSelection, ppmStretchWidth, ppmStretchHeight], FControl.Zooming);
    Canvas.Draw(X, Y, Bitmap);
  finally
    Canvas.Handle := 0;
    FreeAndNil(Canvas);
    FreeAndNil(Bitmap);
  end;
end;

procedure TWordProcessorCell.TransferDataSource(const NewDataCell: TDataBoundCell);
var
  NewCell: TWordProcessorCell;
  OldCell: TWordProcessorCell;
  Text: String;
begin
  NewCell := NewDataCell as TWordProcessorCell;
  OldCell := DataCell;

  Text := OldCell.RichText;
  OldCell.FMainEditor.Free;
  inherited;

  NewCell.RichText := Text;
  NewCell.RichTextChanged(NewCell.FControl);
  NewCell.InitializePaintPages;
end;

constructor TWordProcessorCell.Create(AParent: TAppraisalPage; AViewParent: TObject; CellDef: TObject);
const
  CTwipsPerInch = 1440;
var
  CaretPixelWidth: Integer;
begin
  FControl := TWordProcessorControl.CreateDynamic;
  FRTFData := TWPRTFDataCollection.Create(WPRTFDataClass);
  FRTFProps := TWPRTFProps.Create;
  FRTFData.RTFProps := FRTFProps;
  inherited;

  // remove page margins and set defaults
  CaretPixelWidth := GetSystemMetrics(SM_CXBORDER);
  FRTFData.DefaultFont.Assign((ParentPage.ParentForm.ParentDocument as TContainer).docFont);
  FRTFData.FormatOptionsEx2 := [wpfUseKerning];
  FRTFData.Header.DefaultPageWidth := WPInchToTwips((FFrame.Right - FFrame.Left) / cNormScale) - MulDiv(CaretPixelWidth, CTwipsPerInch, Screen.PixelsPerInch);
  FRTFData.Header.DefaultPageHeight := WPInchToTwips((FFrame.Bottom - FFrame.Top) / cNormScale);
  FRTFData.Header.DefaultLeftMargin := 0;
  FRTFData.Header.DefaultRightMargin := 0;
  FRTFData.Header.DefaultTopMargin := 0;
  FRTFData.Header.DefaultBottomMargin := 0;
  FRTFData.Header.Clear;

  // construct
  FControl.Ctl3D := False;
  FControl.AllowMultiView := True;
  FControl.EditBoxModes := [wpemLimitTextHeight];
  FControl.EditOptions := [wpNoHorzScrolling, wpNoVertScrolling, wpNoAutoScroll];
  FControl.LayoutMode := wplayNormal;
  FControl.Name := SysUtils.Format('DisplayPage%d', [DisplayPageNumber]);
  FControl.Memo.Name := SysUtils.Format('DisplayPage%dPaintEngine', [DisplayPageNumber]);
  FControl.ScrollBars := ssNone;
  FControl.SpellCheckStrategie := wpspCheckInInit;
  FControl.ViewOptions := [wpDontDrawSectionMarker];
  FControl.XBetween := 0;
  FControl.XOffset := 0;
  FControl.YBetween := 0;
  FControl.YOffset := 0;
  FControl.OnChange := RichTextChanged;
  FControl.RemoveRTFData;
  FControl.SetRTFData(FRTFData);
  FControl.RTFData.UpdateReformatMode;  // this helps match caret size to current font size
  RichTextChanged(FControl);
end;

destructor TWordProcessorCell.Destroy;
begin
  FControl.RemoveRTFData;
  if Assigned(FRTFData) then
    FRTFData.RTFProps := nil;

  FreeAndNil(FRTFProps);
  FreeAndNil(FRTFData);
  FreeAndNil(FControl);
  inherited;
end;

procedure TWordProcessorCell.Assign(Source: TBaseCell);
begin
  inherited;
  FControl.Assign((Source as TWordProcessorCell).FControl);
  RichTextChanged(FControl);
end;

procedure TWordProcessorCell.PopulateDataLinkList(var List: TWordProcessorCellList);
var
  Index: Integer;
begin
  List.Clear;
  List.Add(DataCell);
  for Index := 0 to DataCell.DataLinkCount - 1 do
    List.Add(DataCell.DataLinks[Index]);
end;

procedure TWordProcessorCell.DoSetText(const Str: String);
begin
  inherited;
  FControl.Clear;
  FControl.Header.Clear;

  if IsAppPrefSet(bUppercase) then
    InputString(UpperCase(Str))
  else
    InputString(Str)
end;

function TWordProcessorCell.FilterString(const Text: String): String;
begin
  // strip carriage returns; only accept linefeeds (otherwise we get double spacing)
  Result := StringReplace(Text, Char(kReturnKey), '', [rfReplaceAll]);
end;

procedure TWordProcessorCell.DrawZoom(canvas: TCanvas; xDoc, xDC: Integer; isPrinting: Boolean);
var
  Box: TRect;
  SavedDC: HDC;
  ViewportOrigin: TPoint;
  WindowOrigin: TPoint;
begin
  Box := FFrame;
  Box := ScaleRect(Box, xDoc, xDC);

  Canvas.Refresh;
  if isPrinting then
    begin
      SavedDC := SaveDC(Canvas.Handle);
      try
        GetWindowOrgEx(Canvas.Handle, WindowOrigin);
        GetViewportOrgEx(Canvas.Handle, ViewportOrigin);
        SetWindowOrgEx(Canvas.Handle, 0, 0, nil);
        SetViewportOrgEx(Canvas.Handle, 0, 0, nil);
        Box.Left := Box.Left + WindowOrigin.X + ViewportOrigin.X;
        Box.Right := Box.Right + WindowOrigin.X + ViewportOrigin.X;
        Box.Top := Box.Top + WindowOrigin.Y + ViewportOrigin.Y;
        Box.Bottom := Box.Bottom + WindowOrigin.X + ViewportOrigin.Y;
        FControl.PaperColor := clWhite;
        FControl.PrintPageOnCanvas(Canvas, Box, DisplayPageNumber - 1, [ppmIgnoreSelection, ppmStretchWidth, ppmStretchHeight], 100);
      finally
        RestoreDC(Canvas.Handle, SavedDC);
        Canvas.Refresh;
      end;
    end
  else if not Assigned(Editor) then
    begin
      SavedDC := SaveDC(Canvas.Handle);
      try
        FControl.Zooming := muldiv(100, xDC, Screen.PixelsPerInch);
        FControl.Left := box.Left;
        FControl.Top := box.Top;
        FControl.Width := box.Right - box.Left;
        FControl.Height := box.Bottom - box.Top;
        FControl.PaperColor := Background;
        PaintTo(Canvas.Handle, box.Left, box.Top);
      finally
        RestoreDC(Canvas.Handle, SavedDC);
        Canvas.Refresh;
      end;
    end;
end;

procedure TWordProcessorCell.DragDrop(Sender, Source: TObject; X,Y: Integer);
var
  drag: TDragID;
begin
  inherited;
  if (Source is TDragID) then
    begin
      drag := Source as TDragID;
      if (Length(drag.IDName) > 0) then
        begin
          Text := drag.IDName;
          Display;
        end;
    end;
end;

procedure TWordProcessorCell.SetCellSampleEntry;
var
  Str: String;
begin
  FWhiteCell := True;
  FEmptyCell := False;

  case FSubType of
    cKindTx:
      Str := 'RichText';
    cKindCalc:
      begin
        Str := FormatValue(1, FCellFormat);
        if IsBitSet(FCellFormat, bAddComma) then
          Insert(',',Str, pos('1', Str));
      end;
  else
    Str := '';
  end;

  Text := Str;
end;

/// summary: Merges the document and cells linked with the specified foreign cell into a single document.
procedure TWordProcessorCell.MergeDocument(const ForeignDataCell: TWordProcessorCell; const InsertPageNo: Integer);
begin
  DataCell.InternalMergeDocument(ForeignDataCell.DataCell, InsertPageNo);
end;

procedure TWordProcessorCell.CopyPage(const Source: TWordProcessorCell; const InsertPageNo: Integer);
var
  PageStart: TParagraph;
  PageEnd: TParagraph;
  Text: String;
begin
  // find page start
  PageStart := FControl.FirstPar;
  while Assigned(PageStart) and (PageStart.pagenr < InsertPageNo - 1) do
    PageStart := PageStart.NextPar;

  if Assigned(PageStart) and Assigned(PageStart.PrevPar) then
    begin
      FControl.TextCursor.MoveTo(PageStart.PrevPar);
      PageStart := FControl.InsertPar;
      PageStart.IsNewPage := True;
    end
  else if not Assigned(PageStart) then
    begin
      PageStart := FControl.FastAppendParagraph;
      PageStart.IsNewPage := True;
    end;

  // copy rich text
  Text := Source.FControl.GetPagesAsString(Source.DisplayPageNumber - 1, Source.DisplayPageNumber - 1, 'WPTOOLS');
  FControl.HideSelection;
  FControl.TextCursor.MoveTo(PageStart);
  FControl.SelectionAsString := Text;

  // manual page break at end
  PageEnd := FControl.TextCursor.active_paragraph;
  if Assigned(PageEnd) and Assigned(PageEnd.NextPar) then
    PageEnd.NextPar.IsNewPage := True;

  // reformat text and insert new pages
  (FParentPage.FParentForm.FParentDoc as TContainer).DocView.Invalidate;
  RichTextChanged(FControl);
  Modified := True;

  if DataCell.AutoExpanding then
    InsertMissingPages;
end;

procedure TWordProcessorCell.DeletePage;
var
  Index: Integer;
  PageNo: Integer;
begin
  // initialize
  PageNo := DisplayPageNumber - 1;

  // delete page data
  FControl.Memo.DeletePage(PageNo);
  RichTextChanged(FControl);
  Modified := True;

  // renumber pages
  for Index := 0 to DataCell.DataLinkCount - 1 do
    if (DataCell.DataLinks[Index].DisplayPageNumber - 1 > PageNo) then
      DataCell.DataLinks[Index].DisplayPageNumber := DataCell.DataLinks[Index].DisplayPageNumber - 1;
  DisplayPageNumber := MaxInt;

  // this code may destroy Self; exit immediately when finished
  if DataCell.AutoExpanding then
    begin
      RemoveExtraPages;
      Exit;
    end;
end;

procedure TWordProcessorCell.InsertMissingPages;
var
  Cell: TWordProcessorCell;
  Cursor: TCursor;
  Doc: TContainer;
  Form: TDocForm;
  FormUID: TFormUID;
  Index: Integer;
  LastFormIndex: Integer;
  List: TWordProcessorCellList;
  PageNo: Integer;
  ReformatNeeded: Boolean;
begin
  List := nil;
  Cursor := Screen.Cursor;
  try
    ReformatNeeded := False;
    Doc := ParentPage.ParentForm.ParentDocument as TContainer;
    LastFormIndex := Doc.docForm.IndexOf(DataCell.ParentPage.ParentForm as TDocForm);
    List := TWordProcessorCellList.Create;
    PopulateDataLinkList(List);

    // insert missing or new pages
    if (FControl.PageCount > 0) then
      for PageNo := 1 to FControl.PageCount do
        begin
          Form := nil;
          for Index := 0 to List.Count - 1 do
            if (List[Index].DisplayPageNumber = PageNo) then
              begin
                Form := List[Index].ParentPage.ParentForm as TDocForm;
                Break;
              end;

          if not Assigned(Form) then
            begin
              Screen.Cursor := crHourglass;
              FormUID := TFormUID.Create(UID.FormID);
              try
                Form := Doc.InsertFormUID(FormUID, True, LastFormIndex + 1);
                Cell := Form.GetCell(UID.Pg + 1, UID.Num + 1) as TWordProcessorCell;
                Cell.DisplayPageNumber := PageNo;
                Cell.DataSource := DataCell.InstanceID;
                Cell.Disabled := Disabled;
                ReformatNeeded := True;
              finally
                FreeAndNil(FormUID);
              end;
            end;

          LastFormIndex := Doc.docForm.IndexOf(Form);
        end;

    if ReformatNeeded then
      FControl.ReformatAll(True, True);
  finally
    Screen.Cursor := Cursor;
    FreeAndNil(List);
  end;
end;

procedure TWordProcessorCell.RemoveExtraPages;
var
  DeletedCell: TWordProcessorCell;
  NewActiveCell: TWordProcessorCell;
  Doc: TContainer;
  Index: Integer;
  CellList: TWordProcessorCellList;
  DeleteList: TWordProcessorCellList;
  StayList: TWordProcessorCellList;
begin
  Doc := (ParentPage.ParentForm.ParentDocument as TContainer);
  CellList := nil;
  DeleteList := nil;
  StayList := nil;
  try
    CellList := TWordProcessorCellList.Create;
    DeleteList := TWordProcessorCellList.Create;
    StayList := TWordProcessorCellList.Create;

    // queue pages for deletion
    PopulateDataLinkList(CellList);
    for Index := 0 to CellList.Count - 1 do
      if (CellList.Items[Index].DisplayPageNumber > FControl.PageCount) then
        DeleteList.Add(CellList.Items[Index])
      else
        StayList.Add(CellList.Items[Index]);

    // if the active cell is being deleted then activate the cell on the prior page
    if (DeleteList.IndexOf(Doc.docActiveCell) <> -1) then
      begin
        NewActiveCell := Doc.docActiveCell as TWordProcessorCell;
        for Index := StayList.Count - 1 downto 0 do
          if (StayList[Index].DisplayPageNumber < NewActiveCell.DisplayPageNumber) then
            NewActiveCell := StayList[Index];
        if (NewActiveCell <> Doc.docActiveCell) then
          PostMessage(Doc.Handle, CLK_CELLMOVE, Word(goDirect), Integer(NewActiveCell));
      end;

    // delete the pages
    while (DeleteList.Count > 0) do
      begin
        DeletedCell := DeleteList.First;
        Doc.DeleteForm(Doc.docForm.IndexOf(DeletedCell.ParentPage.ParentForm as TDocForm));
        DeleteList.Remove(DeletedCell);
        CellList.Remove(DeletedCell);
      end;
  finally
    FreeAndNil(StayList);
    FreeAndNil(DeleteList);
    FreeAndNil(CellList);
  end;
end;

/// summary: Appends a new section with a bolded header.
function TWordProcessorCell.AppendSection(const Header: String; const Body: String): Integer;
var
  Paragraph, ExistPar: TParagraph;
  FoundPar: Boolean;
  theText: String;
  SectionID: Integer;
begin
  // start new section off the last paragraph
  if (FControl.FirstPar = FControl.LastPar) and (FControl.LastPar.CharCount = 0) then
    begin
      Paragraph := FControl.LastPar;
    end
  else
    begin
      // find insertion point and add page break
      FoundPar := False;
      SectionID := -1;
      repeat
        SectionID := Succ(SectionID);
        ExistPar := FindFirstSectionPar(SectionID);
        if Assigned(ExistPar) then
          begin
            theText := ExistPar.GetText();
            if theText = Header then
              begin
                FoundPar := True;
                Paragraph := ExistPar;
              end;
          end;
      until FoundPar or (not Assigned(ExistPar));
      // We didn't find an existing paragraph section so see if there is
      //  one that was previously used and abandoned. If we find one let's
      //  use it.
      if not FoundPar then
        begin
          // find insertion point and add page break
          FoundPar := False;
          SectionID := -1;
          repeat
            SectionID := Succ(SectionID);
            ExistPar := FindFirstSectionPar(SectionID);
            if Assigned(ExistPar) then
              begin
                if ExistPar.GetText() = '' then
                  begin
                    FoundPar := True;
                    Paragraph := ExistPar;
                  end;
              end;
          until FoundPar or (not Assigned(ExistPar));
        end;

      if not FoundPar then
        begin
          Paragraph := FControl.LastPar.AppendNewPar;
          Paragraph.StartNewSection;
        end;
    end;
  Result := Paragraph.SectionID;
  RewriteSection(Result, Header, Body);
end;

/// summary: Deletes all paragraphs belonging to a section, but preserves the section.
procedure TWordProcessorCell.DeleteSection(const SectionID: Integer);
var
  Paragraph: TParagraph;
begin
  Paragraph := FindFirstSectionPar(SectionID);
  if Assigned(Paragraph) then
    begin
      Paragraph.ClearText(True);
      Paragraph := Paragraph.NextPar;
      // Ver 7.6.9 Was: while Assigned(Paragraph) and (Paragraph.SectionID = SectionID) do
      if Assigned(Paragraph) and ((Paragraph.SectionID = SectionID) or ((Paragraph.SectionID = 0) and (Length(Paragraph.ANSIText) > cUADHeadingMaxLen))) then
        Paragraph := Paragraph.DeleteParagraph;
    end;

  // reformat text and remove extra pages
  FControl.CPPosition := 0;
  FControl.ReformatAll(True, True);
  RichTextChanged(FControl);
  Modified := True;
  if DataCell.AutoExpanding then
    RemoveExtraPages;
end;

/// summary: Finds the first paragraph of the specified section.
function TWordProcessorCell.FindFirstSectionPar(const SectionID: Integer): TParagraph;
  function RecursiveFindFirstSectionPar(const SectionID: Integer; Paragraph: TParagraph): TParagraph;
  begin
    Result := nil;
    while Assigned(Paragraph) do
      begin
        if (Paragraph.SectionID = SectionID) then
          begin
            Result := Paragraph;
            Break;
          end
        else if Assigned(Paragraph.ChildPar) then
          begin
            Result := RecursiveFindFirstSectionPar(SectionID, Paragraph.ChildPar);
            if Assigned(Result) then
              Break;
          end;
        Paragraph := Paragraph.NextPar;
      end;
  end;
begin
  Result := RecursiveFindFirstSectionPar(SectionID, FControl.FirstPar);
end;

/// summary: Rewrites the bolded header and body of a section.
procedure TWordProcessorCell.RewriteSection(const SectionID: Integer; const Header: String; const Body: String);
var
  Document: TContainer;
  Font: TFont;
  Paragraph: TParagraph;
  Str: String;
begin
  Font := TFont.Create;
  try
    DeleteSection(SectionID);
    Paragraph := FindFirstSectionPar(SectionID);
    Document := (ParentPage.ParentForm.ParentDocument as TContainer);

    // add bolded header
    Font.Assign(Document.docFont);
    Font.Style := Font.Style + [fsBold];
    Paragraph.LoadedCharAttr := FontToCharAttr(Font);
    Str := FilterString(Header);
    if IsAppPrefSet(bUppercase) then
      Str := UpperCase(Str);
    Paragraph.Append(Str);

    // add body
    Paragraph := Paragraph.AppendChild;
    Font.Assign(Document.docFont);
    Paragraph.LoadedCharAttr := FontToCharAttr(Font);
    // The subject condition overflow text cannot contain the condition code
    //  and the kitchen and bathroom statuses. These need to be stripped from
    //  the overall comment so they are not saved and displayed on the comment
    //  page. All other overflow comments are saved and displayed as-is.
    if Document.UADEnabled and (Header = 'SUBJECT CONDITION') then
      Str := FilterString(StripUADSubjCond(Body, Document.UADEnabled) + sLineBreak)
    else
      Str := FilterString(Body + sLineBreak);
    if IsAppPrefSet(bUppercase) then
      Str := UpperCase(Str);
    Paragraph.Append(Str);

    // reformat text and insert new pages
    RichTextChanged(FControl);
    Modified := True;
    if DataCell.AutoExpanding then
      InsertMissingPages;
  finally
    FreeAndNil(Font);
  end;
end;

function TWordProcessorCell.Format(value: String): String;
var
  numValue: Double;
begin
  result := value;
  if (FSubType = cKindCalc) and (length(value) > 0) then
    if IsValidNumber(value, numValue) then
      result := GetFormatedString(numValue);
end;

procedure TWordProcessorCell.MungeText;
begin
  if (FContextID > 0) then
    (ParentPage.ParentForm.ParentDocument as TContainer).Munger.MungeCell(Self);
end;

procedure TWordProcessorCell.PostProcess;
begin
  (ParentPage.ParentForm.ParentDocument as TContainer).StartProcessLists;
  try
    ReplicateLocal(True);       // handlde context replication first
    ReplicateGlobal;            // publish outside the form
    ProcessMath;                // do any math assoc. with this cell
  except
    on E:Exception do
      ShowAlert(atWarnAlert, E.Message);
  end;
  (ParentPage.ParentForm.ParentDocument as TContainer).ClearProcessLists;
end;

procedure TWordProcessorCell.ReadCellData(stream: TStream; Version: Integer);
var
  Size: LongInt;
begin
  inherited;

  // skip over TMlnTextCell data (we share the same cell type)
  stream.Read(Size, SizeOf(Size));
  stream.Seek(Size, soFromCurrent);

  // init control
  if (Properties[CPropertyRichTextMIME] <> '') then
    FControl.AsString := TIdDecoderMIME.DecodeString(Properties[CPropertyRichTextMIME])
  else
    FControl.InputString(Text);
  RichTextChanged(FControl);

  // we don't want to slow down the system accessing the string list with all this data
  Properties[CPropertyRichTextMIME] := '';
end;

procedure TWordProcessorCell.WriteCellData(stream: TStream);
var
  Size: LongInt;
  Lines: LineStarts;
  CurValidErr: Boolean;
begin
  //capture the current cell validation error
  CurValidErr := DataCell.HasValidationError;
  // refresh text store on the master page
  if (DataCell = Self) then
    begin
      RichTextChanged(FControl);
      Properties[CPropertyRichTextMIME] := TIdEncoderMIME.EncodeString(FControl.AsString);
    end
  else
    begin
      FText := '';
      Properties[CPropertyRichTextMIME] := '';
    end;

  inherited;

  // write empty TMlnTextCell data (we share the same cell type)
  //Lines := CheckWordWrap(FText);
  Size := Length(Lines) * SizeOf(TextLine);
  stream.WriteBuffer(Size, SizeOf(Size));
  stream.WriteBuffer(Pointer(Lines)^, Size);

  // we don't want to slow down the system accessing the string list with all this data
  Properties[CPropertyRichTextMIME] := '';
  //reset the validation error so cells are reported based on their original declaration
  DataCell.HasValidationError := CurValidErr;
end;

procedure TWordProcessorCell.SetFontStyle(fStyle: TFontStyles);
begin
  FTxStyle := fStyle;
end;

// --- TWordProcessorEditor ---------------------------------------------------

procedure TWordProcessorEditor.HideResponses;
begin
  if Assigned(FResponseList) then
    begin
      FResponseList.Visible := False;
      FRspsVisible := False;
      FAutoRspOn := False;
      if FControl.Visible then
        FControl.SetFocus;
    end;
end;

procedure TWordProcessorEditor.ShowResponses;
begin
  if Assigned(FResponseList) then
    begin
      FResponseList.Top := FControl.Top + FControl.CPYPos + 10;
      FResponseList.Left := FControl.Left + FControl.CPXPos + 10;
      FResponseList.Left := FResponseList.Left - Max((FResponseList.Left + FResponseList.Width) - (FControl.Left + FControl.Width), 0);
      FResponseList.Visible := True;
      FResponseList.SetFocus;
      FResponseList.BringToFront;
      (FDocView as TDocView).ScrollInView(FResponseList);
      FMovingRspSelection := False;
      FRspsVisible := True;
    end;
end;

procedure TWordProcessorEditor.OnActPasteTextExecute(Sender: TObject);
var
  EndPar: TParagraph;
  EndPos: Integer;
  StartPar: TParagraph;
  StartPos: Integer;
begin
  if ClipBoard.HasFormat(CF_Text) then
    begin
      if FControl.TextCursor.SelectText then
        begin
          if FControl.TextCursor.block_reverse then
            ReverseSelection;

          StartPar := FControl.TextCursor.block_s_par;
          StartPos := FControl.TextCursor.block_s_posinpar;
        end
      else
        begin
          StartPar := FControl.TextCursor.active_paragraph;
          StartPos := FControl.TextCursor.active_posinpar;
        end;

      InputString(ClipBoard.AsText);

      EndPar := FControl.TextCursor.active_paragraph;
      EndPos := FControl.TextCursor.active_posinpar;
      FControl.TextCursor.SelectFromHere(StartPar, StartPos);
      FControl.TextCursor.SelectToHere(EndPar, EndPos);

      MakeColoredText(clBlack);
      MakeUniformText((FDoc as TContainer).docFont);
      if IsAppPrefSet(bUppercase) then
        MakeUpperCaseText;

      FControl.HideSelection;
      OnTextChanged(FControl);
    end;
end;

procedure TWordProcessorEditor.OnActMenuFontExecute(Sender: TObject);
var
 FontDialog : TFontDialog;
begin
  FontDialog := TFontDialog.Create(nil);
  try
   FontDialog.Font.Assign(Font);
   if FontDialog.Execute then
    FFont.Assign(FontDialog.Font);
 finally
  FontDialog.Free
 end;
end;


procedure TWordProcessorEditor.OnActPasteTextUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := ClipBoard.HasFormat(CF_Text);
end;

procedure TWordProcessorEditor.OnActSaveResponseExecute(Sender: TObject);
begin
  SaveToRspList(nil);
end;

procedure TWordProcessorEditor.OnActSaveResponseUpdate(Sender: TObject);
begin
  (Sender as TCustomAction).Enabled := (Length(FControl.AsANSIString) > 0);
end;

procedure TWordProcessorEditor.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
  CPadding = 25;
var
  Client: TRect;
  Pt: TPoint;
  Doc: TContainer;
  DocView: TDocView;
  Zoom: Integer;
begin
  if (ssLeft in Shift) and (FControl.TextCursor.SelLength > 0)  then
    begin
      Doc := FDoc as TContainer;
      DocView := Doc.docView;

      Pt := Point(X + FControl.Left, Y + FControl.Top);
      Zoom := Doc.ZoomFactor div 100;

      Client := DocView.ClientRect;
      Client.Left := Client.Left + CPadding * Zoom;
      Client.Top := Client.Top + CPadding * Zoom;
      Client.Right := Client.Right - CPadding * Zoom;
      Client.Bottom := Client.Bottom - CPadding * Zoom;

      if (Pt.X < Client.Left) then
        DocView.ScrollPt2Top(DocView.HorzScrollBar.Position - DocView.HorzScrollBar.Increment, DocView.VertScrollBar.Position);
      if (Pt.Y < Client.Top) then
        DocView.ScrollPt2Top(DocView.HorzScrollBar.Position, DocView.VertScrollBar.Position - DocView.VertScrollBar.Increment);
      if (Pt.X > Client.Right) then
        DocView.ScrollPt2Top(DocView.HorzScrollBar.Position + DocView.HorzScrollBar.Increment, DocView.VertScrollBar.Position);
      if (Pt.Y > Client.Bottom) then
        DocView.ScrollPt2Top(DocView.HorzScrollBar.Position, DocView.VertScrollBar.Position + DocView.VertScrollBar.Increment);
    end;
end;

procedure TWordProcessorEditor.OnResponseClick(Sender: TObject);
var
  response: String;
begin
  if FCanEdit and not FMovingRspSelection then
    begin
      if (Sender is TMenuItem) then
        response := AppComments[FCell.FResponseID].GetComment((Sender as TMenuItem).Tag)
      else
        response := AppComments[FCell.FResponseID].GetComment(FResponseList.ItemIndex);

      if (FControl.CPPosition <> 0) then
        InputString(' ');

      InputString(response);

      if not ShiftKeyDown then
        begin
          HideResponses;
          if FAutoRspOn then
            PostMessage((FDoc as TContainer).Handle, CLK_CELLMOVE, Word(goNext), 0);
        end;
    end;
end;

procedure TWordProcessorEditor.OnResponseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  container: TContainer;
begin
  case Key of
    VK_INSERT, VK_RETURN:
      FResponseList.OnClick(Sender);

    VK_LEFT, VK_RIGHT, VK_TAB:
      begin
        container := (FDoc as TContainer);
        if Assigned(container.OnKeyDown) then
          container.OnKeyDown(Sender, Key, Shift);
      end;

    VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_HOME, VK_END:
      FMovingRspSelection := True;

    VK_ESCAPE:
      HideResponses;
  end;
end;

procedure TWordProcessorEditor.OnResponseKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  container: TContainer;
begin
  case Key of
    VK_LEFT, VK_RIGHT, VK_TAB:
      begin
        container := (FDoc as TContainer);
        if Assigned(container.OnKeyUp) then
          container.OnKeyUp(Sender, Key, Shift);
      end;

    VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_HOME, VK_END:
      FMovingRspSelection := False;
  end;
end;

procedure TWordProcessorEditor.OnFontChanged(Sender: TObject);
begin
  FCellFmtChged := True;
  FCell.DataCell.MainEditor.FModified := True;
  FControl.ApplyFont(FFont);
  FControl.Repaint;
end;

procedure TWordProcessorEditor.OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Direction: Integer;
  Doc: TContainer;
  NextCell: TBaseCell;
  NextCellUID: CellUID;
begin
  Doc := FDoc as TContainer;
  Direction := goNoWhere;

  case Key of
    VK_UP:
      if (FControl.CPLineNr = 0)  or not FCanEdit then
        Direction := goUp;
    VK_LEFT:
      if (FControl.CPPosition = 0) or not FCanEdit then
        Direction := goLeft;
    VK_DOWN:
      if (FControl.CPLineNr = FControl.LineCount - 1) or not FCanEdit then
        Direction := goDown;
    VK_RIGHT:
      if (FControl.CPPosition = FControl.ActiveText.TextLength) or not FCanEdit then
        Direction := goRight;
  end;

  // the next cell may not be on the same form as the active editor; so we handle navigation manually
  if Doc.docForm.GoToNextCell(FCell.UID, Direction, NextCellUID) then
    begin
      NextCell := Doc.docForm[NextCellUID.Form].frmPage[NextCellUID.Pg].pgData[NextCellUID.Num];
      PostMessage(Doc.Handle, CLK_CELLMOVE, Word(goDirect), Integer(NextCell));
    end;

  // keep cursor in view
  // we do this on keydown because sometimes the user holds down a key without releasing
  if (Key <> VK_SHIFT) and (Key <> VK_CONTROL) then
    ScrollCaretIntoView;
end;

procedure TWordProcessorEditor.OnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // keep cursor in view
  // we do this on keyup because the cursor position changes after keydown is processed
  if (Key <> VK_SHIFT) and (Key <> VK_CONTROL) then
    ScrollCaretIntoView;
end;

procedure TWordProcessorEditor.OnSetBounds(var ALeft, ATop, AWidth, AHeight: Integer);
var
  Position: TRect;
begin
  Position := FCell.Cell2View;
  ALeft := Position.Left;
  ATop := Position.Top;
end;

procedure TWordProcessorEditor.OnTextChanged(Sender: TObject);
begin
  FCell.DataCell.RichTextChanged(FControl);
  FCell.DataCell.MainEditor.FModified := True;
  TextOverflowed;

  if FCell.DataCell.AutoExpanding then
    FCell.DataCell.InsertMissingPages;
end;

function TWordProcessorEditor.MakeAscii(const Ch: Char): Char;
begin
  if (Ch > #31) and (Ch < #127) then
    Result := Ch
  else
    Result := ' ';
end;

procedure TWordProcessorEditor.MakeColoredText(const Color: TColor);
begin
  FControl.CurrAttr.Color := FControl.CurrAttr.ColorToNr(Color);
end;

procedure TWordProcessorEditor.MakeUniformText(const Font: TFont);
begin
  FControl.ApplyFont(Font);
end;

procedure TWordProcessorEditor.MakeUpperCaseText;
var
  ActivePar: TParagraph;
  ActivePos: Integer;
  EndPar: TParagraph;
  EndPos: Integer;
  StartPar: TParagraph;
  StartPos: Integer;
  Length: Integer;
  Index: Integer;
begin
  ActivePar := FControl.TextCursor.active_paragraph;
  ActivePos := FControl.TextCursor.active_posinpar;

  if FControl.TextCursor.block_reverse then
    ReverseSelection;

  StartPar := FControl.TextCursor.block_s_par;
  StartPos := FControl.TextCursor.block_s_posinpar;
  EndPar := FControl.TextCursor.block_e_par;
  EndPos := FControl.TextCursor.block_e_posinpar;
  Length := FControl.TextCursor.SelLength;

  try
    FControl.HideSelection;
    FControl.TextCursor.MoveTo(StartPar, StartPos);

    for Index := 0 to Length - 1 do
      begin
        FControl.CPChar := UpCase(FControl.CPChar);
        FControl.TextCursor.MoveNext(1, False);
      end;
  finally
    FControl.TextCursor.MoveTo(ActivePar, ActivePos);
    FControl.TextCursor.SelectFromHere(StartPar, StartPos);
    FControl.TextCursor.SelectToHere(EndPar, EndPos);
  end;
end;

procedure TWordProcessorEditor.ReverseSelection;
var
  StartPar: TParagraph;
  StartPos: Integer;
  EndPar: TParagraph;
  EndPos: Integer;
begin
  if FControl.TextCursor.SelectText then
    begin
      StartPar := FControl.TextCursor.block_s_par;
      StartPos := FControl.TextCursor.block_s_posinpar;
      EndPar := FControl.TextCursor.block_e_par;
      EndPos := FControl.TextCursor.block_e_posinpar;
      FControl.TextCursor.SelectFromHere(EndPar, EndPos);
      FControl.TextCursor.SelectToHere(StartPar, StartPos);
    end
end;

constructor TWordProcessorEditor.Create(AOwner: TAppraisalReport);
begin
  FFont := TWordProcessorFont.Create;
	inherited Create(AOwner);
end;

destructor TWordProcessorEditor.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TWordProcessorEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
var
  Action: TAction;
  Focus: TFocus;
  Index: Integer;
begin
  inherited;
  GetViewFocus(FCanvas.Handle, Focus);
  try
    // initialize cell
    FCell := Cell as TWordProcessorCell;

    // construct
    FControl := TWordProcessorControl.Create(nil);
    FControl.SetRTFData((FCell as TWordProcessorCell).RTFData);
    FControl.Visible := False;
    FControl.Parent := (FDoc as TContainer).docView;
    FControl.Ctl3D := False;
    FControl.Cursor := crIBeam;
    FControl.AllowMultiView := True;
    FControl.EditBoxModes := [wpemLimitTextHeight];
    FControl.EditOptions := [wpActivateUndo, wpActivateRedo, wpNoAutoScroll, wpNoHorzScrolling, wpNoVertScrolling];
    FControl.ReadOnly := not FCanEdit;
    FControl.LayoutMode := wplayNormal;
    FControl.Name := Format('Form%dOccurance%dPage%dCell%dEditor', [FCell.UID.FormID, FCell.UID.Pg + 1, FCell.UID.Occur + 1, FCell.UID.Num + 1]);
    FControl.Memo.Name := Format('Form%dOccurance%dPage%dCell%dEditorPaintEngine', [FCell.UID.FormID, FCell.UID.Pg + 1, FCell.UID.Occur + 1, FCell.UID.Num + 1]);
    FControl.OnChange := OnTextChanged;
    FControl.OnKeyDown := OnKeyDown;
    FControl.OnKeyUp := OnKeyUp;
    FControl.OnMouseMove := OnMouseMove;
    FControl.OnSetBounds := OnSetBounds;
    FControl.PaperColor := FCell.Background;
    FControl.ScrollBars := ssNone;
    FControl.SpellCheckStrategie := wpspCheckInInit;
    FControl.ViewOptions := [wpDontDrawSectionMarker];
    FControl.XBetween := 0;
    FControl.XOffset := 0;
    FControl.YBetween := 0;
    FControl.YOffset := 0;
    FControl.DisplayOnlyOnePage := True;
    FControl.DisplayOnlyPage := (FCell as TWordProcessorCell).DisplayPageNumber;

    // load linked editors
    if not Assigned(FCell.DataCell.MainEditor) then
      begin
        FCell.DataCell.MainEditor := Self;
        FControl.RTFData.UpdateReformatMode;  // this helps match caret size to current font size
        if not Assigned(FCell.DataCell.Editor) then
          LoadLinkedEditor(FCell.DataCell);
        for Index := 0 to FCell.DataCell.DataLinkCount - 1 do
          if not Assigned(FCell.DataCell.DataLinks[Index].Editor) then
            LoadLinkedEditor(FCell.DataCell.DataLinks[Index]);
      end;

    // actions
    FActionList := TActionList.Create(nil);
    FActionList.Name := Format('%sActionList', [FControl.Name]);

    Action := TAction.Create(FActionList);
    Action.Name := CActionSaveComment;
    Action.Caption := 'Save as Comment';
    Action.OnExecute := OnActSaveResponseExecute;
    Action.OnUpdate := OnActSaveResponseUpdate;

    Action := TAction.Create(FActionList);
    Action.Name := CActionPasteText;
    Action.Caption := 'Paste Plain Text';
    Action.OnExecute := OnActPasteTextExecute;
    Action.OnUpdate := OnActPasteTextUpdate;
    Action.ShortCut := 24662; // TextToShortCut('Ctrl+Shift+V')

    Action := TAction.Create(FActionList);
    Action.Name := CActionFontMenu;
    Action.Caption := 'Font...';
    Action.OnExecute := OnActMenuFontExecute;
    Action.OnUpdate := nil;

   
    // build popup menu
    if FCanEdit then BuildPopupMenu;

    // editor font
    FFont.OnChange := OnFontChanged;

    // render
    ResetScale;
    FControl.Visible := True;
  finally
    SetViewFocus(FCanvas.Handle, Focus);
  end;
end;

procedure TWordProcessorEditor.UnLoadCell;
var
  Index: Integer;
begin
  inherited;

  // unload linked editors
  // Explicit: we are not freeing ourself because TContainer will do that later;
  //           the prior call to inherited removes ourself as the cell editor.
  if Assigned(FCell) then
    begin
      if (FCell.DataCell.MainEditor = Self) then
        begin
          FCell.DataCell.MainEditor := nil;
          FCell.DataCell.Editor.Free;
          FCell.DataCell.Display;
          for Index := 0 to FCell.DataCell.DataLinkCount - 1 do
            begin
              FCell.DataCell.DataLinks[Index].Editor.Free;
              FCell.DataCell.DataLinks[Index].Display;
            end;
        end;

      FCell := nil;
    end;

  FFont.OnChange := nil;
  FCellFmtChged := False;
  FModified := False;
  TxStr := '';

  FreeAndNil(FPopupMenu);
  FreeAndNil(FActionList);
  FreeAndNil(FControl);
end;

procedure TWordProcessorEditor.LoadLinkedEditor(const LinkedCell: TWordProcessorCell);
var
  Editor: TEditor;
begin
  Editor := LinkedCell.EditorClass.Create(FDoc) as TEditor;
  try
    Editor.LoadCell(LinkedCell, LinkedCell.UID);
  except
    FreeAndNil(Editor);
    raise;
  end;
end;

procedure TWordProcessorEditor.ActivateEditor;
begin
  inherited;
  FControl.SetFocus;
end;

procedure TWordProcessorEditor.IdleEditor;
begin
  inherited;

  // this code may destroy Self; exit immediately when finished
  if FCell.DataCell.AutoExpanding then
    begin
      FCell.DataCell.InsertMissingPages;
      FCell.DataCell.RemoveExtraPages;
      Exit;
    end;
end;

procedure TWordProcessorEditor.PositionEditor;
var
  Position: TRect;
begin
  Position := FCell.Cell2View;
  FControl.Left := Position.Left;
  FControl.Top := Position.Top;
  FControl.Width := Position.Right - Position.Left;
  FControl.Height := Position.Bottom - Position.Top;
end;

procedure TWordProcessorEditor.ScrollCaretIntoView;
var
  CaretPixelHeight: Integer;
  Index: Integer;
  Junk: Integer;
  Pt: TPoint;
  List: TWordProcessorCellList;
  Editor: TWordProcessorEditor;
begin
  List := TWordProcessorCellList.Create;
  try
    // find the editor containing the caret
    Editor := nil;
    FCell.PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      if ((List[Index].Editor as TWordProcessorEditor).FControl.CPXPos <> -1) then
        Editor := List[Index].Editor as TWordProcessorEditor;

    if Assigned(Editor) then
      begin
        // calculate caret position in doc coordinates
        Pt := Point(Editor.FControl.CPXPos, Editor.FControl.CPYPos);
        Pt := ScalePt(Pt, FCell.docScale, cNormScale);        // unzoom and convert to 72 dpi
        Pt.X := Pt.X + Editor.FCell.FFrame.Left;              // offset cell coordinates
        Pt.Y := Pt.Y + Editor.FCell.FFrame.Top;               // offset cell coordinates
        Pt := Editor.FCell.Area2Doc(Pt);                      // offset docview margins, scale to 96 dpi, and zoom

        // ensure the entire cursor is visible, not just the top of it
        Editor.FControl.Memo.GetCursorXYWH(Junk, Junk, Junk, CaretPixelHeight);
        (FDoc as TContainer).MakePtVisible(Pt);
        (FDoc as TContainer).MakePtVisible(Point(Pt.X, Pt.Y + CaretPixelHeight));
      end;
  finally
    FreeAndNil(List);
  end;
end;

/// summary: Moves the cursor to the first paragraph in the specified section.
function TWordProcessorEditor.MoveCaretToSection(const SectionID: Integer): Boolean;
var
  Paragraph: TParagraph;
begin
  Paragraph := FCell.FindFirstSectionPar(SectionID);
  if Assigned(Paragraph) then
    begin
      FControl.TextCursor.MoveTo(Paragraph);
      ScrollCaretIntoView;
      Result := True;
    end
  else
    Result := False;
end;

procedure TWordProcessorEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Frame: TRect;
begin
  Frame := ScaleRect(FFrame, cNormScale, scale);
  FControl.SetPositionXY(ClickPt.X - Frame.Left, ClickPt.Y - Frame.Top);
end;

procedure TWordProcessorEditor.KeyEditor(var Key: Char);
begin
  // The key is sent directly to the control and processed there
  Key := #0;
end;

procedure TWordProcessorEditor.InputStringRich(const Text: String);
var
  Str: String;
begin
  Str := FCell.FilterString(Text);

  if IsAppPrefSet(bUppercase) then
    Str := UpperCase(Str);

  FControl.InputString(Str);
  ScrollCaretIntoView;
  OnTextChanged(FControl);
end;

procedure TWordProcessorEditor.InputStringPlain(const Text: String);
var
  Str: String;
begin
  Str := FCell.FilterString(Text);

  if IsAppPrefSet(bUppercase) then
    Str := UpperCase(Str);

  Font.Assign((FDoc as TContainer).docFont);
  FControl.InputString(Str);
  ScrollCaretIntoView;
  OnTextChanged(FControl);
end;

function TWordProcessorEditor.CanClear: Boolean;
begin
  Result := (FControl.SelLength > 0) and FCanEdit;
end;

procedure TWordProcessorEditor.ClearEdit;
begin
  FControl.SelText := '';
  OnTextChanged(FControl);
end;

function TWordProcessorEditor.CanUndo: Boolean;
begin
  Result := (FControl.RTFData.UndoStack.Count > 0) and FCanEdit;
end;

procedure TWordProcessorEditor.ClearUndo;
begin
  FControl.UndoClear;
end;

procedure TWordProcessorEditor.UndoEdit;
begin
  FControl.Undo;
end;

function TWordProcessorEditor.CanCut: Boolean;
begin
  Result := (Length(FControl.SelText) > 0) and FCanEdit;
end;

procedure TWordProcessorEditor.CutEdit;
begin
  FControl.CutToClipboard;
  OnTextChanged(FControl);
end;

function TWordProcessorEditor.CanCopy: Boolean;
begin
  Result := (Length(FControl.SelText) > 0);
end;

procedure TWordProcessorEditor.CopyEdit;
begin
  FControl.CopyToClipboard;
end;

function TWordProcessorEditor.CanPaste: Boolean;
begin
  Result := ClipBoard.HasFormat(CF_Text) and FCanEdit;
end;

procedure TWordProcessorEditor.PasteEdit;
var
  EndPar: TParagraph;
  EndPos: Integer;
  StartPar: TParagraph;
  StartPos: Integer;
begin
  if FControl.TextCursor.SelectText then
    begin
      if FControl.TextCursor.block_reverse then
        ReverseSelection;

      StartPar := FControl.TextCursor.block_s_par;
      StartPos := FControl.TextCursor.block_s_posinpar;
    end
  else
    begin
      StartPar := FControl.TextCursor.active_paragraph;
      StartPos := FControl.TextCursor.active_posinpar;
    end;

  FControl.PasteFromClipboard;

  EndPar := FControl.TextCursor.active_paragraph;
  EndPos := FControl.TextCursor.active_posinpar;
  FControl.TextCursor.SelectFromHere(StartPar, StartPos);
  FControl.TextCursor.SelectToHere(EndPar, EndPos);

  MakeColoredText(clBlack);
  if IsAppPrefSet(bUppercase) then
    MakeUpperCaseText;

  FControl.HideSelection;
  OnTextChanged(FControl);
end;

function TWordProcessorEditor.CanSelectAll: Boolean;
begin
  Result := (Length(FControl.AsANSIString) > 0);
end;

procedure TWordProcessorEditor.SelectAll;
begin
  FControl.SelectAll;
end;

function TWordProcessorEditor.CanSpellCheck: Boolean;
begin
  Result := (Length(FControl.AsANSIString) > 0);
end;

procedure TWordProcessorEditor.LoadCellRsps(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FResponseList := AppComments[FCell.FResponseID].BuildCommenmtListBox(FDoc);
  if Assigned(FResponseList) then
    begin
      FResponseList.Visible := False;
      FResponseList.Parent := FControl.Parent;
      FResponseList.OnClick := OnResponseClick;
      FResponseList.OnKeyDown := OnResponseKeyDown;
      FResponseList.OnKeyUp := OnResponseKeyUp;
    end;
end;

procedure TWordProcessorEditor.SaveToRspList(Sender: TObject);
var
  response: String;
  form: TEditCmts;
begin
  if (Length(FControl.SelText) > 0) then
    response := FControl.SelText
  else
    response := AnsiText;

  form := TEditCmts.Create(FDoc);
  try
    form.LoadCommentGroup(FCell.FResponseID);
    form.LoadCurComment(response);
    if (form.ShowModal = mrOK) and form.Modified then
      form.SaveCommentGroup;
  finally
    FreeAndNil(form);
  end;

  BuildPopUpMenu;  // rebuild the popup menu
end;

procedure TWordProcessorEditor.SetAutoRsp(Value: Boolean);
begin
  if (FAutoRspOn <> value) then
  begin
    FAutoRspOn := Value;
    if Value then
      ShowResponses
    else
      HideResponses;
  end;
end;

procedure TWordProcessorEditor.UnLoadCellRsps;
begin
  inherited;
  FreeAndNil(FResponseList);
end;

procedure TWordProcessorEditor.BuildPopUpMenu;
var
  index: Integer;
  item: TMenuItem;
begin
  // recreate the popup menu here because TEditor.ShowPopupMenu is
  // never called when right clicking a windowed control
  FreeAndNil(FPopupMenu);
  FPopupMenu := TPopupMenu.Create(nil);
  FPopupMenu.Name := Format('%sPopupMenu', [FControl.Name]);
  FControl.PopupMenu := FPopupMenu;
  inherited;

  // delete the cell preferences menu item
  for index := FPopupMenu.Items.Count - 1 downto 0 do
    if (FPopupMenu.Items[index].Action = Main.CellPrefCmd) then
      FPopupMenu.Items.Delete(index);

  // add auto-responses
  if Assigned(AppComments[FCell.FResponseID]) then
    begin
      if appPref_AddEditM2Popups and IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste) then
        begin
          item := TMenuItem.Create(FPopupMenu);
          item.Action := FActionList.FindComponent(CActionPasteText) as TAction;
          for index := 0 to FPopupMenu.Items.Count - 1 do
            if Assigned(FPopupMenu.Items[index].Action) then
              if (FPopupMenu.Items[index].Action.Name = CActionPaste) then
                begin
                  FPopupMenu.Items.Insert(index + 1, item);
                  break;
                end;
        end;

      item := TMenuItem.Create(FPopupMenu);
      item.Action := FActionList.FindComponent(CActionFontMenu) as TAction;
      FPopupMenu.Items.Add(item);

      item := TMenuItem.Create(FPopupMenu);
      item.Caption := '-';
      FPopupMenu.Items.Add(item);

      item := TMenuItem.Create(FPopupMenu);
      item.Action := FActionList.FindComponent(CActionSaveComment) as TAction;
      FPopupMenu.Items.Add(item);

      item := TMenuItem.Create(FPopupMenu);
      item.Caption := '-';
      FPopupMenu.Items.Add(item);

      index := FPopupMenu.Items.Count - 1;
      AppComments[FCell.FResponseID].BulidPopupCommentMenu(FPopupMenu);
      for index := index to FPopupMenu.Items.Count - 1 do
        begin
          FPopupMenu.Items[index].OnClick := OnResponseClick;
          FPopupMenu.Items[index].Enabled := FCanEdit;
        end;
    end;
end;

procedure TWordProcessorEditor.InitCaret(Clicked: Boolean);
var
  Paragraph: TParagraph;
begin
  // position caret at the top of the activated cell page
  Paragraph := FControl.FirstPar;
  while (Paragraph.pagenr < FControl.DisplayOnlyPage - 1) and Assigned(Paragraph.NextPar) do
    Paragraph := Paragraph.NextPar;
  FControl.TextCursor.MoveTo(Paragraph);
end;

function TWordProcessorEditor.HasActiveCellOnPage(Page: TObject): Boolean;
begin
  // Since there is no notification when pages are added, moved, or deleted,
  // request repositioning for all linked editors across all pages (DrawCurCell)
  Result := True;
end;

function TWordProcessorEditor.HasContents: Boolean;
begin
  Result := (Length(FControl.AsANSIString) > 0);
end;

function TWordProcessorEditor.HasSelection: Boolean;
begin
  Result := (Length(FControl.SelText) > 0);
end;

procedure TWordProcessorEditor.ResetScale;
var
  Index: Integer;
  List: TWordProcessorCellList;
begin
  List := TWordProcessorCellList.Create;
  try
    // reset zoom scale on all linked editors
    FCell.PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      if Assigned(List[Index].Editor) then
        begin
          (List[Index].Editor as TWordProcessorEditor).FControl.Zooming := (FDocView as TDocView).ViewScale;
          (List[Index].Editor as TWordProcessorEditor).PositionEditor;
        end;
  finally
    FreeAndNil(List);
  end;
end;

function TWordProcessorEditor.TextOverflowed: Boolean;
var
  List: TWordProcessorCellList;
begin
  if FCell.DataCell.AutoExpanding then
    Result := False
  else
    begin
      List := TWordProcessorCellList.Create;
      try
        FCell.PopulateDataLinkList(List);
        Result := (FCell.DataCell.PageCount > List[List.Count - 1].DisplayPageNumber);
        FCellStatus := SetBit2Flag(FCellStatus, bOverflow, Result);
      finally
        FreeAndNil(List);
      end;
    end;
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TWordProcessorEditor.CanLinkComments: Boolean;
begin
  Result := (inherited CanLinkComments) and not FCell.DataCell.AutoExpanding;
end;

function TWordProcessorEditor.GetAnsiText: String;
begin
  // strip carriage returns for compatibility with the spell checker
  Result := StringReplace(FControl.AsAnsiString, Char(kReturnKey), '', [rfReplaceAll]);
end;

function TWordProcessorEditor.GetSelectedText: String;
begin
  Result := FControl.SelText;
end;

function TWordProcessorEditor.GetText: String;
begin
  Result := FControl.Text;
end;

procedure TWordProcessorEditor.SetText(const Value: String);
begin
  if FCanEdit then
    begin
      FControl.AsString := Value;
      OnTextChanged(FControl);
    end;
end;

procedure TWordProcessorEditor.InputString(const Text: String);
begin
  InputStringPlain(Text);
end;

function TWordProcessorEditor.GetCaretPosition: Integer;
var
  Index: Integer;
  Position: Integer;
  Text: String;
begin
  Text := AnsiText;
  Position := FControl.CPPosition;
  FControl.CPPosition := 0;

  if (Length(Text) > 0) then
    begin
      Index := 1;
      repeat
        while (MakeAscii(FControl.CPChar) <> MakeAscii(Text[Index])) and FControl.CPMoveNext do;
        if (FControl.CPPosition < Position) then
          begin
            FControl.CPMoveNext;
            Index := Index + 1;
          end;
      until (FControl.CPPosition >= Position);
      Result := Index;
    end
  else
    Result := 0;
end;

procedure TWordProcessorEditor.SetCaretPosition(const Value: Integer);
var
  Index: Integer;
  Text: String;
begin
  Text := AnsiText;
  FControl.CPPosition := 0;

  if (Value > Length(Text)) then
    FControl.CPPosition := MaxInt
  else
    for Index := 1 to Value do
      begin
        while (MakeAscii(FControl.CPChar) <> MakeAscii(Text[Index])) and FControl.CPMoveNext do;
        if (Index <> Value) then
          FControl.CPMoveNext;
      end;

  ScrollCaretIntoView;
end;

procedure TWordProcessorEditor.SelectText(const Start: Integer; const Length: Integer);
begin
  CaretPosition := Start;
  FControl.SelStart := FControl.CPPosition;
  FControl.SelLength := Length;
end;

function TWordProcessorEditor.CanFormatText: Boolean;
begin
  result := not FDoc.Locked;  //FCanEdit;
end;

function TWordProcessorEditor.GetFont: TCellFont;
begin
  FFont.OnChange := nil;
  try
    FFont.Assign(FControl.UpdateFontValues);
  finally
    FFont.OnChange := OnFontChanged;
  end;
  Result := FFont;
end;

function TWordProcessorEditor.GetTextJustification: Integer;
begin
  case FControl.CurrAttr.Alignment of
    paralLeft:
      Result := tjJustLeft;
    paralCenter:
      Result := tjJustMid;
    paralRight:
      Result := tjJustRight;
    paralBlock:
      Result := tjJustFull;
    else
      Result := tjJustLeft;
  end;
end;

procedure TWordProcessorEditor.SetTextJustification(const Value: Integer);
var
  alignment: TParAlign;
begin
  alignment := FControl.CurrAttr.Alignment;

  case Value of
    tjJustLeft:
      FControl.CurrAttr.Alignment := paralLeft;
    tjJustMid:
      FControl.CurrAttr.Alignment := paralCenter;
    tjJustRight:
      FControl.CurrAttr.Alignment := paralRight;
    tjJustFull:
      FControl.CurrAttr.Alignment := paralBlock;
  end;

  if (FControl.CurrAttr.Alignment <> alignment) then
    begin
      FCell.DataCell.MainEditor.FModified := True;
      FCell.DataCell.MainEditor.FCellFmtChged := True;
    end;
end;

// --- Unit -------------------------------------------------------------------

initialization
  RegisterEditor(TWordProcessorEditor);

end.

