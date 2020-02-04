unit UEditorDialog;

{  ClickForms
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ This editor dialog help is specifically for UAD compliance of data}

interface

uses
  ActnList,
  AD3LiveAutoSpell,
  Classes,
  Controls,
  Menus,
  StdCtrls,
  Types,
  UCell,
  UClasses,
  UContainer,
  UEditor,
  UForms,
  UGlobals,
  UMessages,
  UWordProcessor,
  Dialogs;
type
  /// summary: A type of form for editing cell data.
  TDialogEditorFormClass = class of TDialogEditorForm;

  /// summary: A helper class for working with dialog editors.
  TDialogEditorHelper = class
  private  // internal
    class procedure BuildDialogCellGroupList(const Cell: TBaseCell; const List: TCellList);
    class function GetDialogDataSource(const Cell: TBaseCell; const List: TCellList): TBaseCell;
    class function GetDialogDataSourceXID(const DialogID: String): Integer;
    class function GetDialogID(const XID: Integer; const UID: CellUID): String;
    class procedure LoadCellGroup(const List: TCellList; const Document: TContainer);
    class procedure UnloadCellGroup(const List: TCellList);
  public  // external
    class function FindCell(const XID: Integer; const UID: CellUID; const Document: TContainer): TBaseCell;
    class function FindGridColumnCell(const XID: Integer; const FromCell: TGridCell): TBaseCell;
    class function FindPageCell(const XID: Integer; const FromCell: TBaseCell): TBaseCell;
    class function GetEditorClass(const Cell: TBaseCell; const DefaultEditorClass: TCellEditorClass): TCellEditorClass;
    class procedure ValidateDialogGroup(const Cell: TBaseCell);
    class function GetDialogClass(const Cell: TBaseCell): TDialogEditorFormClass;
    class procedure SetDlgGrpFontSize(Cell: TBaseCell; const FontSize: Integer);
    class procedure SetDlgGrpFontJust(Cell: TBaseCell; const Justification: Integer);
    class procedure SetDlgGrpFontStyle(Cell: TBaseCell; theStyle: Integer);
  end;

  /// summary: A form for editing cell data in a dialog.
  TDialogEditorForm = class(TVistaAdvancedForm)
  private
    FActionCopy: TAction;
    FActionCut: TAction;
    FActionDelete: TAction;
    FActionPaste: TAction;
    FActionSaveComment: TAction;
    FActionSelectAll: TAction;
    FActionUndo: TAction;
    FActionList: TActionList;
    FDataPointList: TStringList;
    FMemoPopupMenu: TPopupMenu;
    FSpellChecker: TAddictAutoLiveSpell;
    procedure AttachPopupMenus(const Control: TWinControl);
    procedure AttachSpellChecker(const Control: TWinControl);
    procedure BuildMenus;
    function GetDataPoint(Name: String): String;
    procedure SetDataPoint(Name: String; Value: String);
    function GetGSEData: String;
    procedure OnCopyExecute(Sender: TObject);
    procedure OnCopyUpdate(Sender: TObject);
    procedure OnCutExecute(Sender: TObject);
    procedure OnCutUpdate(Sender: TObject);
    procedure OnDeleteExecute(Sender: TObject);
    procedure OnDeleteUpdate(Sender: TObject);
    procedure OnInsertComment(Sender: TObject);
    procedure OnPasteExecute(Sender: TObject);
    procedure OnPasteUpdate(Sender: TObject);
    procedure OnSaveCommentExecute(Sender: TObject);
    procedure OnSaveCommentUpdate(Sender: TObject);
    procedure OnSelectAllExecute(Sender: TObject);
    procedure OnSelectAllUpdate(Sender: TObject);
    procedure OnUndoExecute(Sender: TObject);
    procedure OnUndoUpdate(Sender: TObject);
  protected
    FCell: TBaseCell;
    procedure BroadcastContextProperty(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const PropertyName: String; const PropertyValue: String; const ContextIDs: array of Integer);
    property DataPoint[index: String]: String read GetDataPoint write SetDataPoint;
    function DataPointExists(const Name: String): Boolean;
    procedure DeleteDataPoint(const Name: String);
    property GSEData: String read GetGSEData;
    procedure LoadForm; virtual; abstract;
    procedure SaveForm; virtual; abstract;
    procedure SetEditorCheckmark(const Checked: Boolean; Cell: TBaseCell = nil; const EnforceGroup: Boolean = True);
    procedure SetEditorText(const Text: String; Cell: TBaseCell = nil);
    procedure ShowHelp(const HelpFileName: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; virtual; abstract;
    function GetOverflowText: String; virtual; abstract;
    procedure LoadCell(const Cell: TBaseCell);
    procedure SaveCell;
  end;

  /// summary: Interface to dialog editor methods.
  IDialogEditor = interface
    ['{3E10BA86-F7C8-4036-BF36-CE2CA24E6EA3}']
    /// summary: Checks for text overflow and links carry-over comments.
    procedure CheckTextOverflow;
    /// summary: Clears the editor and dialog of content.
    procedure Clear;
    /// summary: Shows a dialog for editing the data in the cell.
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for checkbox cells that use a dialog for cell editing.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TChkBoxDialogEditor = class(TChkBoxEditor, IDialogEditor)
  private
    FActivator: Boolean;
    FDataSourceCell: TBaseCell;
    FDialogGroupCellList: TCellList;
  protected
    FCell: TChkBoxCell;
    FDialog: TDialogEditorForm;
    FDoc: TContainer;
  public
    constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure UnloadCell; override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanCut: Boolean; override;
    function CanCopy: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
    function CanUndo: Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;

    // IDialogEditor
    procedure CheckTextOverflow;
    procedure Clear;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for grid cells that use a dialog for cell editing.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TGridCellDialogEditor = class(TGridCellEditor, IDialogEditor)
  private
    FActivator: Boolean;
    FDataSourceCell: TBaseCell;
    FDialogGroupCellList: TCellList;
  protected
    FCell: TTextBaseCell;
    FDialog: TDialogEditorForm;
    FDoc: TContainer;
  public
    constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure UnloadCell; override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanCut: Boolean; override;
    function CanCopy: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
    function CanUndo: Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    function CanLinkComments: Boolean; override;
    procedure LinkComments; override;

    // IDialogEditor
    procedure CheckTextOverflow;
    procedure Clear;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for the construction quality grid cell.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TQualityGridCellDialogEditor = class(TPositiveWholeNumericGridEditor)
  protected
    FDialog: TDialogEditorForm;
    function HasValidNumber: Boolean; override;
  public
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    procedure SetClickCaret(ClickPt: TPoint); override;
    function CanLinkComments: Boolean; override;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for the property condition grid cell.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TConditionGridCellDialogEditor = class(TPositiveWholeNumericGridEditor)
  protected
    FDialog: TDialogEditorForm;
    function HasValidNumber: Boolean; override;
  public
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    procedure SetClickCaret(ClickPt: TPoint); override;
    function CanLinkComments: Boolean; override;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for single-line cells that use a dialog for cell editing.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TSLDialogEditor = class(TSLEditor, IDialogEditor)
  private
    FActivator: Boolean;
    FDataSourceCell: TBaseCell;
    FDialogGroupCellList: TCellList;
  protected
    FCell: TTextBaseCell;
    FDialog: TDialogEditorForm;
    FDoc: TContainer;
  public
    constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure UnloadCell; override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanCut: Boolean; override;
    function CanCopy: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
    function CanUndo: Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    function CanLinkComments: Boolean; override;
    procedure LinkComments; override;

    // IDialogEditor
    procedure CheckTextOverflow;
    procedure Clear;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for multi-line cells that use a dialog for cell editing.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TMLDialogEditor = class(TMLEditor, IDialogEditor)
  private
    FActivator: Boolean;
    FDataSourceCell: TBaseCell;
    FDialogGroupCellList: TCellList;
  protected
    FCell: TTextBaseCell;
    FDialog: TDialogEditorForm;
    FDoc: TContainer;
  public
    constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure UnloadCell; override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanCut: Boolean; override;
    function CanCopy: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
    function CanUndo: Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    function CanLinkComments: Boolean; override;
    procedure LinkComments; override;

    // IDialogEditor
    procedure CheckTextOverflow;
    procedure Clear;
    function ShowDialog: TModalResult;
  end;

  /// summary: An editor for word processor cells that use a dialog for cell editing.
  /// remarks: Developed to meet the Uniform Appraisal Dataset (UAD) requirements of the GSEs.
  TWordProcessorDialogEditor = class(TWordProcessorEditor, IDialogEditor)
  private
    FActivator: Boolean;
    FDataSourceCell: TBaseCell;
    FDialogGroupCellList: TCellList;
    procedure PaintTo(DC: THandle; X, Y: Integer);
  protected
    FCell: TWordProcessorCell;
    FDialog: TDialogEditorForm;
    FDoc: TContainer;
    FWPControl: TWordProcessorControl;
    procedure InitializePaintPages;
    procedure Paint;
  public
    constructor Create(AOwner: TAppraisalReport); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure LoadCell(Cell: TBaseCell; CUID: CellUID); override;
    procedure UnloadCell; override;
    procedure ActivateEditor; override;
    function HasActiveCellOnPage(Page: TObject): Boolean; override;
    procedure DrawCurCell; override;
    procedure KeyEditor(var Key: Char); override;
    procedure ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState); override;
    procedure ClearEdit; override;
    function CanAcceptChar(Key: Char): Boolean; override;
    function CanCut: Boolean; override;
    function CanCopy: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanSpellCheck: Boolean; override;
    function CanUndo: Boolean; override;
    function CanMoveCaret(Direction: integer): Boolean; override;
    function CanLinkComments: Boolean; override;
    procedure LinkComments; override;

    // IDialogEditor
    procedure CheckTextOverflow;
    procedure Clear;
    function ShowDialog: TModalResult;
  end;

implementation

uses
  Windows,
  AD3RichEdit,
  Clipbrd,
  Forms,
  Graphics,
  Math,
  Messages,
  MSXML6_TLB,
  SysUtils,
  StrUtils,
  UBase,
  UForm,
  UFormRichHelp,
  UMain,
  UPage,
  UStdCmtsEdit,
  UStdRspUtil,
  UStrings,
  UUADConfiguration,
  UUtil1,
  WPCTRMemo,
  WPRTEDefs,
  WPRTEPaint;
const
  // 5/31/11 JWyatt Quality and condition grid constanta
  cQualChr = 'Q';
  cQualXID = '4517=';
  cQualDlgIdx = 7;
  cCondChr = 'C';
  cCondXID = '4518=';
  cCondDlgIdx = 7;

// --- TDialogEditorHelper -------------------------------------

/// summary: Builds a list of cells belonging to the same dialog group as the
///          specified cell and returns the data source cell of the group.
class procedure TDialogEditorHelper.BuildDialogCellGroupList(const Cell: TBaseCell; const List: TCellList);
const
  CXPath = '/UniformAppraisalDataSet/Cells/Cell/Mismo26GSE[@DialogID-ref="%s"]';
var
  Attribute: IXMLDOMAttribute;
  CellConfiguration: IXMLDOMElement;
  DialogID: String;
  Document: TContainer;
  GrouppedCell: TBaseCell;
  Index: Integer;
  NodeList: IXMLDOMNodeList;
  UID: CellUID;
  XID: Integer;
  XPath: String;
begin
  Document := Cell.ParentPage.ParentForm.ParentDocument as TContainer;
  DialogID := GetDialogID(Cell.FCellXID, Cell.UID);
  XPath := Format(CXPath, [DialogID]);
  NodeList := TUADConfiguration.Database.selectNodes(XPath);
  for Index := 0 to NodeList.length - 1 do
    begin
      // gather attributes of the cell from the database
      FillChar(UID, SizeOf(UID), #0);
      CellConfiguration := NodeList.item[Index].parentNode as IXMLDOMElement;
      XID := StrToInt(CellConfiguration.getAttribute('XID'));
      Attribute := CellConfiguration.getAttributeNode('FormID');
      if Assigned(Attribute) then
        UID.FormID := StrToInt(Attribute.text);
      UID.Form := Cell.UID.Form;
      Attribute := CellConfiguration.getAttributeNode('Page');
      if Assigned(Attribute) then
        UID.Pg := StrToInt(Attribute.text)
      else
        UID.Pg := -1;
      Attribute := CellConfiguration.getAttributeNode('Cell');
      if Assigned(Attribute) then
        UID.Num := StrToInt(Attribute.text)
      else
        UID.Num := -1;

      // find the cell
      if (UID.FormID > 0) then
        GrouppedCell := FindCell(XID, UID, Document)
      else if (Cell is TGridCell) then
        GrouppedCell := FindGridColumnCell(XID, Cell as TGridCell)
      else
        GrouppedCell := FindPageCell(XID, Cell);

      // add to list
      if Assigned(GrouppedCell) then
        List.Add(GrouppedCell);
    end;
end;

/// summary: Gets the editor dialog class for the specified dialog ID.
class function TDialogEditorHelper.GetDialogClass(const Cell: TBaseCell): TDialogEditorFormClass;
var
  DialogClassName: IXMLDOMNode;
  DialogConfiguration: IXMLDOMElement;
  DialogID: String;
begin
  Result := nil;
  DialogID := GetDialogID(Cell.FCellXID, Cell.UID);
  DialogConfiguration := TUADConfiguration.Dialog(DialogID);
  if Assigned(DialogConfiguration) then
    begin
      DialogClassName := DialogConfiguration.selectSingleNode('DialogClassName');
      if Assigned(DialogClassName) then
        Result := TDialogEditorFormClass(GetClass(DialogClassName.text));
    end;
end;

/// summary: Sets the font size for all cells in a dialog group.
class procedure TDialogEditorHelper.SetDlgGrpFontSize(Cell: TBaseCell; const FontSize: Integer);
var
  DialogCellList: TCellList;
  Index: Integer;
begin
  DialogCellList := TCellList.Create;
  try
    // initialize
    BuildDialogCellGroupList(Cell, DialogCellList);
    // flag cells
    for Index := 0 to DialogCellList.Count - 1 do
      if DialogCellList[Index].ClassName <> 'TChkBoxCell' then
        DialogCellList[Index].SetTextSize(FontSize);
  finally
    FreeAndNil(DialogCellList);
  end;
end;

/// summary: Sets the cell justiification for all cells in a dialog group.
class procedure TDialogEditorHelper.SetDlgGrpFontJust(Cell: TBaseCell; const Justification: Integer);
var
  DialogCellList: TCellList;
  Index: Integer;
begin
  DialogCellList := TCellList.Create;
  try
    // initialize
    BuildDialogCellGroupList(Cell, DialogCellList);
    // flag cells
    for Index := 0 to DialogCellList.Count - 1 do
      if DialogCellList[Index].ClassName <> 'TChkBoxCell' then
        DialogCellList[Index].SetTextJust(Justification);
  finally
    FreeAndNil(DialogCellList);
  end;
end;


/// summary: Sets the font size for all cells in a dialog group.
class procedure TDialogEditorHelper.SetDlgGrpFontStyle(Cell: TBaseCell; theStyle: Integer);
var
  DialogCellList: TCellList;
  Index: Integer;
begin
  DialogCellList := TCellList.Create;
  try
    // initialize
    BuildDialogCellGroupList(Cell, DialogCellList);
    // flag cells
    for Index := 0 to DialogCellList.Count - 1 do
      if DialogCellList[Index].ClassName <> 'TChkBoxCell' then
      begin
        DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxBold, False);
        DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxItalic, False);
        DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxUnderline, False);
        case theStyle of
          1: DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxBold, True);
          2: DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxItalic, True);
          3:
            begin
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxBold, True);
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxItalic, True);
            end;
          4: DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxUnderline, True);
          5:
            begin
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxBold, True);
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxUnderline, True);
            end;
          6:
            begin
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxItalic, True);
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxUnderline, True);
            end;
          7:
            begin
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxBold, True);
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxItalic, True);
              DialogCellList[Index].FCellPref := SetBit2Flag(DialogCellList[Index].FCellPref, bTxUnderline, True);
            end;
        end;
        DialogCellList[Index].Display;
      end;
  finally
    FreeAndNil(DialogCellList);
  end;
end;

/// summary: Gets the data source of the dialog group cell list.
class function TDialogEditorHelper.GetDialogDataSource(const Cell: TBaseCell; const List: TCellList): TBaseCell;
var
  DataSource: TBaseCell;
  DialogID: String;
  Index: Integer;
  XID: Integer;
begin
  DataSource := Cell;
  DialogID := GetDialogID(Cell.FCellXID, Cell.UID);
  XID := GetDialogDataSourceXID(DialogID);
  if (XID > 0) then
    for Index := 0 to List.Count - 1 do
      if (List[Index].FCellXID = XID) then
          DataSource := List[Index];
  Result := DataSource;
end;

/// summary: Gets the XID of the data source cell of the dialog.
class function TDialogEditorHelper.GetDialogDataSourceXID(const DialogID: String): Integer;
var
  DataSource: IXMLDOMNode;
  DialogConfiguration: IXMLDOMElement;
begin
  Result := 0;
  DialogConfiguration := TUADConfiguration.Dialog(DialogID);
  if Assigned(DialogConfiguration) then
    begin
      DataSource := DialogConfiguration.selectSingleNode('DataSource/@XID');
      if Assigned(DataSource) then
        Result := StrToInt(DataSource.text);
    end;
end;

/// summary: Gets the editor dialog class defined in the UAD database for the specified cell.
class function TDialogEditorHelper.GetDialogID(const XID: Integer; const UID: CellUID): String;
const
  CAttribute_DialogIDReference = 'DialogID-ref';
var
  Configuration: IXMLDOMElement;
  DialogIDReference: IXMLDOMAttribute;
begin
  Result := '';
  Configuration := TUADConfiguration.Cell(XID, UID);
  Configuration := TUADConfiguration.Mismo(Configuration, True);
  if Assigned(Configuration) then
    begin
      DialogIDReference := Configuration.getAttributeNode(CAttribute_DialogIDReference);
      if Assigned(DialogIDReference) then
        Result := DialogIDReference.text;
    end;
end;

/// summary: Loads editors on grouped dialog cells.
class procedure TDialogEditorHelper.LoadCellGroup(const List: TCellList; const Document: TContainer);
var
  Cell: TBaseCell;
  Editor: TEditor;
  Index: Integer;
begin
  for Index := 0 to List.Count - 1 do
    begin
      Cell := List[Index];
      if not Assigned(Cell.Editor) then
        begin
          Editor := Cell.EditorClass.Create(Document) as TEditor;
          Editor.LoadCell(Cell, Cell.UID);
          Editor.HilightCell;
        end;
    end;
end;

/// summary: Unloads editors on grouped dialog cells.
class procedure TDialogEditorHelper.UnloadCellGroup(const List: TCellList);
var
  Index: Integer;
begin
  for Index := 0 to List.Count - 1 do
    List[Index].Editor.Free;
end;

/// summary: Finds a cell matching the specified XID and partial UID.
class function TDialogEditorHelper.FindCell(const XID: Integer; const UID: CellUID; const Document: TContainer): TBaseCell;
var
  Cell: TBaseCell;
  Form: TDocForm;
  Page: TDocPage;
begin
  if (UID.FormID > 0) then
    begin
      // find closest matching cell using the UID
      if (UID.Form > -1) then
        begin
          Form := Document.docForm[UID.Form];
          if (UID.Pg > -1) then
            begin
              Page := Form.frmPage[UID.Pg];
              if (UID.Num > -1) then
                Cell := Page.pgData[UID.Num]
              else
                Cell := Page.GetCellByXID(XID);
            end
          else
            Cell := Form.GetCellByXID(XID);
        end
      else
        Cell := nil;
    end
  else
    Cell := nil;

  Result := Cell;
end;

/// summary: Finds the grid cell in the same column as FromCell with the specified XID.
class function TDialogEditorHelper.FindGridColumnCell(const XID: Integer; const FromCell: TGridCell): TBaseCell;
var
  Coordinates: TPoint;
  Index: Integer;
  Page: TDocPage;
  Sequence: Integer;
  Table: TCellTable;
  TableIndex: Integer;
begin
  TableIndex := FromCell.GetCoordinates(Coordinates);
  Page := FromCell.ParentPage as TDocPage;
  Table := Page.pgDesc.PgCellTables[TableIndex];
  Result := nil;

  Index := 0;
  repeat
    Sequence := Table.Grid[Index, Coordinates.Y] - 1;
    if (Sequence > -1) and (Page.pgData[Sequence].FCellXID = XID) then
        Result := Page.pgData[Sequence];
    Index := Index + 1;
  until (Index >= Table.TableRows) or (Result <> nil);
end;

/// summary: Finds the cell on the same page as FromCell with the specified XID.
class function TDialogEditorHelper.FindPageCell(const XID: Integer; const FromCell: TBaseCell): TBaseCell;
var
  Page: TDocPage;
begin
  Page := FromCell.ParentPage as TDocPage;
  Result := Page.GetCellByXID(XID);
end;

/// summary: Gets the editor class for the specified cell.
class function TDialogEditorHelper.GetEditorClass(const Cell: TBaseCell; const DefaultEditorClass: TCellEditorClass): TCellEditorClass;
var
  Configuration: IXMLDOMElement;
  EditorClassName: IXMLDOMNode;
  EditorClass: TCellEditorClass;
  IsUAD: Boolean;
begin
  EditorClass := nil;
  IsUAD := (Cell.ParentPage.ParentForm.ParentDocument as TContainer).UADEnabled;
  Configuration := TUADConfiguration.Cell(Cell.FCellXID, Cell.UID);
  Configuration := TUADConfiguration.Mismo(Configuration, IsUAD);
  if Assigned(Configuration) then
    begin
      EditorClassName := Configuration.selectSingleNode('./@EditorClass');
      if Assigned(EditorClassName) then
        EditorClass := UEditor.GetEditorClass(EditorClassName.text);
    end;
  if not Assigned(EditorClass) then
    Result := DefaultEditorClass
  else
    Result := EditorClass;
end;

/// summary: Validates the data of cells in a dialog group and sets the
///          HasValidationError flag on each cell within the group.
class procedure TDialogEditorHelper.ValidateDialogGroup(const Cell: TBaseCell);
var
  DialogCellList: TCellList;
  HasGSEData: Boolean;
  Index: Integer;
  IsFilled: Boolean;
  IsPartlyFilled: Boolean;
  Valid: Boolean;
  ValidStr: String;
begin
  DialogCellList := TCellList.Create;
  try
    // initialize
    BuildDialogCellGroupList(Cell, DialogCellList);

    // perform validation
    HasGSEData := False;      // only one cell must have GSE data for the group to have data
    IsFilled := True;         // all cells must be filled for the group to be filled
    IsPartlyFilled := False;  // only some cells must be filled for the group to be partly filled

    ValidStr := Cell.GSEDataPoint['Valid'];
    if ValidStr = 'Y' then
      Valid := True
    else if ValidStr = 'N' then
      Valid := False
    else
      begin
        for Index := 0 to DialogCellList.Count - 1 do
          begin
            HasGSEData := HasGSEData or DialogCellList[Index].PropertyExists(CPropertyGSEData);
            IsPartlyFilled := IsPartlyFilled or (DialogCellList[Index].FWhiteCell or not DialogCellList[Index].FEmptyCell);
            IsFilled := IsFilled and (DialogCellList[Index].FWhiteCell or not DialogCellList[Index].FEmptyCell);
          end;

        Valid := ((HasGSEData and IsFilled) or (not HasGSEData and not IsPartlyFilled));  // completely filled or completely empty
      end;

    // flag cells
    for Index := 0 to DialogCellList.Count - 1 do
      DialogCellList[Index].HasValidationError := not Valid;
  finally
    FreeAndNil(DialogCellList);
  end;
end;

// --- TEditorDialog -------------------------------------------

/// summary: Initializes a new instance of TEditorDialog.
constructor TDialogEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  FDataPointList := TStringList.Create;
  FActionList := TActionList.Create(Self);
  FActionCopy := TAction.Create(Self);
  FActionCut := TAction.Create(Self);
  FActionDelete := TAction.Create(Self);
  FActionPaste := TAction.Create(Self);
  FActionSaveComment := TAction.Create(Self);
  FActionSelectAll := TAction.Create(Self);
  FActionUndo := TAction.Create(Self);
  FMemoPopupMenu := TPopupMenu.Create(Self);
  FSpellChecker := TAddictAutoLiveSpell.Create(Self);

  // initialize
  FActionCopy.Caption := '&Copy';
  FActionCopy.ShortCut := ShortCut(Ord('C'), [ssCtrl]);
  FActionCopy.OnExecute := OnCopyExecute;
  FActionCopy.OnUpdate := OnCopyUpdate;
  FActionCut.Caption := 'Cu&t';
  FActionCut.ShortCut := ShortCut(Ord('X'), [ssCtrl]);
  FActionCut.OnExecute := OnCutExecute;
  FActionCut.OnUpdate := OnCutUpdate;
  FActionDelete.Caption := '&Delete';
  FActionDelete.ShortCut := ShortCut(VK_DELETE, [ssCtrl]);
  FActionDelete.OnExecute := OnDeleteExecute;
  FActionDelete.OnUpdate := OnDeleteUpdate;
  FActionPaste.Caption := '&Paste';
  FActionPaste.ShortCut := ShortCut(Ord('V'), [ssCtrl]);
  FActionPaste.OnExecute := OnPasteExecute;
  FActionPaste.OnUpdate := OnPasteUpdate;
  FActionSaveComment.Caption := 'Save as Comment';
  FActionSaveComment.OnExecute := OnSaveCommentExecute;
  FActionSaveComment.OnUpdate := OnSaveCommentUpdate;
  FActionSelectAll.Caption := '&Se&lect All';
  FActionSelectAll.ShortCut := ShortCut(Ord('A'), [ssCtrl]);
  FActionSelectAll.OnExecute := OnSelectAllExecute;
  FActionSelectAll.OnUpdate := OnSelectAllUpdate;
  FActionUndo.Caption := '&Undo';
  FActionUndo.ShortCut := ShortCut(Ord('Z'), [ssCtrl]);
  FActionUndo.OnExecute := OnUndoExecute;
  FActionUndo.OnUpdate := OnUndoUpdate;
  AttachPopupMenus(Self);

  if Assigned(Main) then
    begin
      FSpellChecker.ConfigFilename := Main.AddictSpell.ConfigFilename;
      FSpellChecker.ConfigID := Main.AddictSpell.ConfigID;
      FSpellChecker.ConfigDictionaryDir.Assign(Main.AddictSpell.ConfigDictionaryDir);
      FSpellChecker.SuggestionsLearningDict := Main.AddictSpell.SuggestionsLearningDict;
      AttachSpellChecker(Self);
    end;
end;

/// summary: Frees memory and releases resources.
destructor TDialogEditorForm.Destroy;
begin
  FreeAndNil(FDataPointList);
  inherited;
end;

/// summary: Recursively attaches popup menus to memo controls.
procedure TDialogEditorForm.AttachPopupMenus(const Control: TWinControl);
var
  ChildControl: TWinControl;
  Index: Integer;
begin
  for Index := 0 to Control.ControlCount - 1 do
    begin
      if (Control.Controls[Index] is TAddictRichEdit) then
        (Control.Controls[Index] as TAddictRichEdit).PopupMenu := FMemoPopupMenu;

      if (Control.Controls[Index] is TWinControl) then
        begin
          ChildControl := Control.Controls[Index] as TWinControl;
          if (ChildControl.ControlCount > 0) then
            AttachPopupMenus(ChildControl);
        end;
    end;
end;

procedure TDialogEditorForm.AttachSpellChecker(const Control: TWinControl);
var
  ChildControl: TWinControl;
  Index: Integer;
begin
  for Index := 0 to Control.ControlCount - 1 do
    begin
      if (Control.Controls[Index] is TAddictRichEdit) then
        (Control.Controls[Index] as TAddictRichEdit).AddictSpell := FSpellChecker;

      if (Control.Controls[Index] is TWinControl) then
        begin
          ChildControl := Control.Controls[Index] as TWinControl;
          if (ChildControl.ControlCount > 0) then
            AttachSpellChecker(ChildControl);
        end;
    end;
end;

/// summary: Builds popup menus.
procedure TDialogEditorForm.BuildMenus;
  procedure AddActionItem(const PopupMenu: TPopupMenu; const Action: TAction);
  var
    Item: TMenuItem;
  begin
    Item := TMenuItem.Create(PopupMenu);
    Item.Action := Action;
    PopupMenu.Items.Add(Item);
  end;

  procedure AddLineItem(const PopupMenu: TPopupMenu);
  var
    Item: TMenuItem;
  begin
    Item := TMenuItem.Create(PopupMenu);
    Item.Caption := '-';
    PopupMenu.Items.Add(Item);
  end;

var
  CommentGroup: TCommentGroup;
  Index: Integer;
begin
  // standard actions
  FMemoPopupMenu.Items.Clear;

  if appPref_AddEditM2Popups then     //these are user preferences
    begin
      if IsBitSet(appPref_AddEM2PUpPref, bAddEMUndo) then
        AddActionItem(FMemoPopupMenu, FActionUndo);
      if IsBitSet(appPref_AddEM2PUpPref, bAddEMCut) then
        AddActionItem(FMemoPopupMenu, FActionCut);
      if IsBitSet(appPref_AddEM2PUpPref, bAddEMCopy) then
        AddActionItem(FMemoPopupMenu, FActionCopy);
      if IsBitSet(appPref_AddEM2PUpPref, bAddEMPaste) then
        AddActionItem(FMemoPopupMenu, FActionPaste);
      if IsBitSet(appPref_AddEM2PUpPref, bAddEMClear) then
        AddActionItem(FMemoPopupMenu, FActionDelete);

      AddActionItem(FMemoPopupMenu, FActionSelectAll);     //only in Dialogs, not in reg cells
      AddLineItem(FMemoPopupMenu);
    end;
  //always add Save as Comment
  AddActionItem(FMemoPopupMenu, FActionSaveComment);       //reg cells hide this if no text
  AddLineItem(FMemoPopupMenu);

  // saved comment responses
  Index := FMemoPopupMenu.Items.Count;
  CommentGroup := AppComments[FCell.FResponseID];
  CommentGroup.BulidPopupCommentMenu(FMemoPopupMenu);
  for Index := Max(Index, 0) to FMemoPopupMenu.Items.Count - 1 do
    FMemoPopupMenu.Items[Index].OnClick := OnInsertComment;
end;

/// summary: Gets the value associated with a data point.
function TDialogEditorForm.GetDataPoint(Name: String): String;
begin
  Result := FDataPointList.Values[Name];
end;

/// summary: Sets a data point and associated value.
procedure TDialogEditorForm.SetDataPoint(Name: String; Value: String);
begin
  FDataPointList.Values[Name] := Value;
end;

/// summary: Gets the data points array as a GSE data string.
function TDialogEditorForm.GetGSEData: String;
begin
  Result := FDataPointList.CommaText;
end;

/// summary: Copies the selected text to the clipboard.
procedure TDialogEditorForm.OnCopyExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.CopyToClipboard;
    end;
end;

/// summary: Updates the copy action.
procedure TDialogEditorForm.OnCopyUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := (Edit.SelLength > 0);
    end;
end;

/// summary: Cuts the selected text to the clipboard.
procedure TDialogEditorForm.OnCutExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.CutToClipboard;
    end;
end;

/// summary: Updates the cut action.
procedure TDialogEditorForm.OnCutUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := (Edit.SelLength > 0);
    end;
end;

/// summary: Deletes the selected text.
procedure TDialogEditorForm.OnDeleteExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.ClearSelection;
    end;
end;

/// summary: Updates the delete action.
procedure TDialogEditorForm.OnDeleteUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := (Edit.SelLength > 0);
    end;
end;

/// summary: Inserts text from a saved comment response into the memo.
procedure TDialogEditorForm.OnInsertComment(Sender: TObject);
var
  Edit: TAddictRichEdit;
  Index: Integer;
  Item: TMenuItem;
  Text: String;
begin
  if (Sender is TMenuItem) and (ActiveControl is TAddictRichEdit) then
    begin
      Item := Sender as TMenuItem;
      Edit := ActiveControl as TAddictRichEdit;
      Text := AppComments[FCell.FResponseID].GetComment(Item.Tag);
      for Index := 1 to Length(Text) do
        SendMessage(Edit.Handle, WM_CHAR, Integer(Text[Index]), 0);
    end;
end;

/// summary: Pastes text from the clipboard.
procedure TDialogEditorForm.OnPasteExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.PasteFromClipboard;
    end;
end;

/// summary: Updates the paste action.
procedure TDialogEditorForm.OnPasteUpdate(Sender: TObject);
var
  Action: TAction;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Action := Sender as TAction;
      Action.Enabled := Clipboard.HasFormat(CF_TEXT);
    end;
end;

/// summary: Saves text to the saved comments list.
procedure TDialogEditorForm.OnSaveCommentExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
  EditCommentsForm: TEditCmts;
  ModalResult: TModalResult;
  Text: String;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Text := Edit.SelText;
      if (Text = '') then
        Text := Edit.Text;

      EditCommentsForm := TEditCmts.Create(Self);
      try
        EditCommentsForm.LoadCommentGroup(FCell.FResponseID);
        EditCommentsForm.LoadCurComment(Text);
        ModalResult := EditCommentsForm.ShowModal;
        if (ModalResult = mrOK) and (EditCommentsForm.Modified) then
          EditCommentsForm.SaveCommentGroup;
      finally
        FreeAndNil(EditCommentsForm);
      end;
    end;
  BuildMenus;
end;

/// summary: Updates the save comment action.
procedure TDialogEditorForm.OnSaveCommentUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := (Edit.Text <> '');
    end;
end;

/// summary: Selects all the text.
procedure TDialogEditorForm.OnSelectAllExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.SelectAll;
    end;
end;

/// summary: Updates the select all action.
procedure TDialogEditorForm.OnSelectAllUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := (Edit.Text <> '');
    end;
end;

/// summary: Undoes the most recent edit.
procedure TDialogEditorForm.OnUndoExecute(Sender: TObject);
var
  Edit: TAddictRichEdit;
begin
  if (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Edit.Undo;
    end;
end;

/// summary: Updates the undo action.
procedure TDialogEditorForm.OnUndoUpdate(Sender: TObject);
var
  Action: TAction;
  Edit: TAddictRichEdit;
begin
  if (Sender is TAction) and (ActiveControl is TAddictRichEdit) then
    begin
      Edit := ActiveControl as TAddictRichEdit;
      Action := Sender as TAction;
      Action.Enabled := Edit.CanUndo;
    end;
end;

/// summary: Broadcasts context properties.
procedure TDialogEditorForm.BroadcastContextProperty(const Msg: TDocumentMessageID; const Scope: TDocumentMessageScope; const PropertyName: String; const PropertyValue: String; const ContextIDs: array of Integer);
var
  Index: Integer;
  PropertyData: PBroadcastContextPropertyData;
begin
  New(PropertyData);
  SetLength(PropertyData^.ContextIDs, Length(ContextIDs));
  for Index := 0 to Length(ContextIDs) - 1 do
    PropertyData^.ContextIDs[Index] := ContextIDs[Index];
  PropertyData^.Name := PropertyName;
  PropertyData^.Value := PropertyValue;
  FCell.Dispatch(Msg, Scope, PropertyData);
end;

/// summary: Indicates whether a given data point exists.
function TDialogEditorForm.DataPointExists(const Name: String): Boolean;
begin
  Result := (FDataPointList.IndexOfName(Name) > -1)
end;

/// summary: Deletes a data point and associated value.
procedure TDialogEditorForm.DeleteDataPoint(const Name: String);
var
  Index: Integer;
begin
  Index := FDataPointList.IndexOfName(Name);
  if (Index > -1) then
    FDataPointList.Delete(Index);
end;

/// summary: Sets or clears a checkmark in the cell editor.
procedure TDialogEditorForm.SetEditorCheckmark(const Checked: Boolean; Cell: TBaseCell = nil; const EnforceGroup: Boolean = True);
var
  ChkBoxEditor: TChkBoxEditor;
begin
  if not Assigned(Cell) and (FCell is TChkBoxCell) then
    Cell := FCell as TChkBoxCell;
  if (Cell is TChkBoxCell) and (Cell.Editor is TChkBoxEditor) then
    begin
      ChkBoxEditor := (Cell.Editor as TChkBoxDialogEditor);
      ChkBoxEditor.SetCheckMark(Checked, EnforceGroup);
    end;
end;

/// summary: Sets the display text in the cell editor.
procedure TDialogEditorForm.SetEditorText(const Text: String; Cell: TBaseCell = nil);
var
  TextEditor: ITextEditor;
begin
  if not Assigned(Cell) and (FCell is TTextBaseCell) then
    Cell := FCell;
  if (Cell is TTextBaseCell) and (Cell.Editor is TEditor) and Supports(Cell.Editor, ITextEditor, TextEditor) then
    TextEditor.Text := Text;
end;

/// summary: Shows help for the dialog.
procedure TDialogEditorForm.ShowHelp(const HelpFileName: String);
var
  HelpForm: TRichHelpForm;
begin
  HelpForm := TRichHelpForm.Create(Self);
  try
    HelpForm.LoadFormData('Uniform Appraisal DataSet', Caption);
    HelpForm.LoadHelpFile(HelpFileName);
    HelpForm.ShowModal;
  finally
    FreeAndNil(HelpForm);
  end;
end;

/// summary: Loads data from the cell into the form.
procedure TDialogEditorForm.LoadCell(const Cell: TBaseCell);
begin
  Clear;
  FCell := Cell;
  if Assigned(FCell) then
    begin
      BuildMenus;
      FDataPointList.CommaText := FCell.GSEData;
    end;
  LoadForm;
end;

/// summary: Saves data on the form into the cell.
procedure TDialogEditorForm.SaveCell;
var
  DialogGroupCellList: TCellList;
  Index: Integer;
begin
  DialogGroupCellList := TCellList.Create;
  try
    TDialogEditorHelper.BuildDialogCellGroupList(FCell, DialogGroupCellList);
    for Index := 0 to DialogGroupCellList.Count - 1 do
      (DialogGroupCellList[Index].Editor as TEditor).FCanEdit := True;
    FDataPointList.Clear;

    SaveForm;       //save form already sets the DataPts = GSEData

    for Index := 0 to DialogGroupCellList.Count - 1 do
      (DialogGroupCellList[Index].Editor as TEditor).FCanEdit := False;
    if Assigned(FCell) then
      FCell.GSEData := FDataPointList.CommaText;     //not sure why here?
  finally
    FreeAndNil(DialogGroupCellList);
  end;
end;

// --- TChkBoxDialogEditor -----------------------------------

/// summary: Initializes a new instance of TChkBoxDialogEditor.
constructor TChkBoxDialogEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;
  FDialogGroupCellList := TCellList.Create;
end;

/// summary: Frees memory and releases resources.
destructor TChkBoxDialogEditor.Destroy;
begin
  FreeAndNil(FDialogGroupCellList);
  inherited;
end;

/// summary: Unhighlights cells when finished editing.
procedure TChkBoxDialogEditor.BeforeDestruction;
var
  Index: Integer;
begin
  if FActivator then
    for Index := 0 to FDialogGroupCellList.Count - 1 do
      FDialogGroupCellList[Index].Display;
  inherited;
end;

/// summary: Creates the dialog and loads the cell into the form.
procedure TChkBoxDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCell := Cell as TChkBoxCell;
  FDoc := TEditor(Self).FDoc as TContainer;
  TDialogEditorHelper.BuildDialogCellGroupList(FCell, FDialogGroupCellList);
  FDataSourceCell := TDialogEditorHelper.GetDialogDataSource(FCell, FDialogGroupCellList);
  if Assigned(FDoc) and (FDoc.docActiveCell = FCell) then
    begin
      FActivator := True;
      TDialogEditorHelper.LoadCellGroup(FDialogGroupCellList, FDoc);
    end
  else
    FActivator := False;
end;

/// summary: Frees the dialog and unloads the cell.
procedure TChkBoxDialogEditor.UnloadCell;
begin
  inherited;
  if FActivator then
    TDialogEditorHelper.UnloadCellGroup(FDialogGroupCellList);
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TChkBoxDialogEditor.KeyEditor(var Key: Char);
var
  Editor: IDialogEditor;
begin
  // 120711 JWyatt Remove requirement for pressing the Return key for check boxes
  //  so the check mark is toggled immediately when the user presses X or the space bar.
  //  Was:  if (Key = #13) and Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.ShowDialog;
end;

/// summary: Shows the dialog when the editor is left-clicked.
procedure TChkBoxDialogEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Editor: IDialogEditor;
begin
  if (Button = mbLeft) then
    begin
      if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
        Editor.ShowDialog;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TChkBoxDialogEditor.ClearEdit;
var
  Editor: IDialogEditor;
begin
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TChkBoxDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (Key = #13);
end;

/// summary: Indicates that the user may not cut text.
function TChkBoxDialogEditor.CanCut: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not copy text.
function TChkBoxDialogEditor.CanCopy: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not paste text.
function TChkBoxDialogEditor.CanPaste: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not select all text.
function TChkBoxDialogEditor.CanSelectAll: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not use the spell checker.
function TChkBoxDialogEditor.CanSpellCheck: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not undo changes.
function TChkBoxDialogEditor.CanUndo: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not move the caret.
function TChkBoxDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
end;

/// summary: Checks for text overflow and links carry-over comments.
procedure TChkBoxDialogEditor.CheckTextOverflow;
begin
  // do nothing
end;

/// summary: Clears the editor and dialog of content.
procedure TChkBoxDialogEditor.Clear;
begin
  if Assigned(FDialog) then
    FDialog.Clear;

  inherited ClearEdit;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TChkBoxDialogEditor.ShowDialog: TModalResult;
var
  DialogEditor: IDialogEditor;
  DialogResult: TModalResult;
  Index: Integer;
  // 052611 JWyatt Add functionality to enforce UAD restrictions for one-of-many
  //  grouped check boxes by disabling use of Control Key functionality
  DlgEditFormClass: TDialogEditorFormClass;
begin
  if not FDoc.Locked and not IsBitSet(FCellStatus, bDisabled) and not Assigned(FDialog) then
    begin
      DlgEditFormClass := TDialogEditorHelper.GetDialogClass(FCell);
      if DlgEditFormClass <> nil then
        begin
          FDialog := DlgEditFormClass.Create(FDoc);
          // Was: FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
          try
            FDialog.LoadCell(FDataSourceCell);
            DialogResult := FDialog.ShowModal;
            if (DialogResult = mrOK) then
              begin
                for Index := 0 to FDialogGroupCellList.Count - 1 do
                  begin
                    FDialogGroupCellList[Index].FEmptyCell := False;
                    FDialogGroupCellList[Index].FWhiteCell := True;
                    FDialogGroupCellList[Index].HasValidationError := False;
                    if Supports(FDialogGroupCellList[Index].Editor, IDialogEditor, DialogEditor) then
                      DialogEditor.CheckTextOverflow;
                  end;
              end;
          finally
            FreeAndNil(FDialog);
          end;
        end
      else
        begin
          // Process grouped check boxes so we enforce UAD one-of-many restrictions
          if FCell.GetText = 'X' then
            TChkBoxDialogEditor(FCell.Editor).SetCheckMark(False, True, False)
          else
            TChkBoxDialogEditor(FCell.Editor).SetCheckMark(True, True, False);
          DialogResult := mrOK;
        end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TGridCellDialogEditor ---------------------------------

/// summary: Initializes a new instance of TSLDialogEditor.
constructor TGridCellDialogEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;
  FDialogGroupCellList := TCellList.Create;
end;

/// summary: Frees memory and releases resources.
destructor TGridCellDialogEditor.Destroy;
begin
  FreeAndNil(FDialogGroupCellList);
  inherited;
end;

/// summary: Unhighlights cells when finished editing.
procedure TGridCellDialogEditor.BeforeDestruction;
var
  Index: Integer;
begin
  if FActivator then
    for Index := 0 to FDialogGroupCellList.Count - 1 do
      FDialogGroupCellList[Index].Display;
  inherited;
end;

/// summary: Creates the dialog and loads the cell into the form.
procedure TGridCellDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCell := Cell as TTextBaseCell;
  FDoc := TEditor(Self).FDoc as TContainer;
  TDialogEditorHelper.BuildDialogCellGroupList(FCell, FDialogGroupCellList);
  FDataSourceCell := TDialogEditorHelper.GetDialogDataSource(FCell, FDialogGroupCellList);
  if Assigned(FDoc) and (FDoc.docActiveCell = FCell) then
    begin
      FActivator := True;
      TDialogEditorHelper.LoadCellGroup(FDialogGroupCellList, FDoc);
    end
  else
    FActivator := False;
end;

/// summary: Frees the dialog and unloads the cell.
procedure TGridCellDialogEditor.UnloadCell;
begin
  inherited;
  if FActivator then
    TDialogEditorHelper.UnloadCellGroup(FDialogGroupCellList);
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TGridCellDialogEditor.KeyEditor(var Key: Char);
var
  Editor: IDialogEditor;
begin
  if (Key = #13) and Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.ShowDialog;
end;

/// summary: Shows the dialog when the editor is left-clicked.
procedure TGridCellDialogEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Editor: IDialogEditor;
begin
  if (Button = mbLeft) then
    begin
      if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
        Editor.ShowDialog;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TGridCellDialogEditor.ClearEdit;
var
  Editor: IDialogEditor;
begin
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TGridCellDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (Key = #13);
end;

/// summary: Indicates that the user may not cut text.
function TGridCellDialogEditor.CanCut: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not copy text.
function TGridCellDialogEditor.CanCopy: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not paste text.
function TGridCellDialogEditor.CanPaste: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not select all text.
function TGridCellDialogEditor.CanSelectAll: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not use the spell checker.
function TGridCellDialogEditor.CanSpellCheck: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not undo changes.
function TGridCellDialogEditor.CanUndo: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not move the caret.
function TGridCellDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TGridCellDialogEditor.CanLinkComments: Boolean;
begin
  Result := False;
end;

/// summary: Links a comment addendum to the text cell and inserts CommentText onto the addendum.
procedure TGridCellDialogEditor.LinkComments;
var
  Body: String;
  CommentCell: TWordProcessorCell;
  Form: TDocForm;
  Heading: String;
  SavedCanEdit: Boolean;
  SavedPosition: TPoint;
begin
  if CanLinkComments then
    begin
      SavedCanEdit := FCanEdit;
      SavedPosition.X := FDoc.docView.HorzScrollBar.Position;
      SavedPosition.Y := FDoc.docView.VertScrollBar.Position;
      try
        FCanEdit := True;
        Body := StringReplace(FDialog.GetOverflowText, Char(kReturnKey), '', [rfReplaceAll]);
        Heading := FCell.UserPreference[CCellCaptionPreference];
        if (Length(Body) > 0) then
          begin
            if FCell.HasLinkedComments then
              begin
                CommentCell := FDoc.FindCellInstance(FCell.LinkedCommentCell) as TWordProcessorCell;
                CommentCell.RewriteSection(FCell.LinkedCommentSection, Heading, Body);
              end
            else
              begin
                Form := FDoc.GetFormByOccurance(CUADCommentAddendum, 0, True);
                if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
                  begin
                    CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
                    CommentCell.GSEData := ' ';  // suppress validation errors
                    CommentCell.Disabled := True;
                    FCell.LinkedCommentCell := CommentCell.InstanceID;
                    FCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
                  end;
              end;
          end;
      finally
        FCanEdit := SavedCanEdit;
        FDoc.docView.HorzScrollBar.Position := SavedPosition.X;
        FDoc.docView.VertScrollBar.Position := SavedPosition.Y;
      end;
    end;
end;

/// summary: Checks for text overflow and links carry-over comments.
procedure TGridCellDialogEditor.CheckTextOverflow;
var
  PreviousKind: Integer;
begin
  if Modified then
    begin
      if TextOverflowed and CanLinkComments then
        LinkComments
      else
        FCell.LinkedCommentCell := GUID_NULL;

      PreviousKind := FCell.Kind;
      try
        FCell.Kind := cKindTx;
        SaveChanges;
        FCell.PostProcess;
      finally
        FCell.Kind := PreviousKind;
      end;
    end;
end;

/// summary: Clears the editor and dialog of content.
procedure TGridCellDialogEditor.Clear;
begin
  if Assigned(FDialog) then
    FDialog.Clear;

  inherited ClearEdit;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TGridCellDialogEditor.ShowDialog: TModalResult;
var
  DialogEditor: IDialogEditor;
  DialogResult: TModalResult;
  Index: Integer;
begin
  if not FDoc.Locked and not IsBitSet(FCellStatus, bDisabled) and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FDataSourceCell);
        DialogResult := FDialog.ShowModal;
        if (DialogResult = mrOK) then
          begin
            for Index := 0 to FDialogGroupCellList.Count - 1 do
              begin
                FDialogGroupCellList[Index].FEmptyCell := False;
                FDialogGroupCellList[Index].FWhiteCell := True;
                FDialogGroupCellList[Index].HasValidationError := False;
                if Supports(FDialogGroupCellList[Index].Editor, IDialogEditor, DialogEditor) then
                  DialogEditor.CheckTextOverflow;
              end;
          end;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TQualityGridCellDialogEditor ------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TQualityGridCellDialogEditor.HasValidNumber: Boolean;
var
  Value: Double;
begin
  Value := GetValue;
  Result := (Value > 0) and (Value < 7);
end;

/// summary: Loads the cell into the editor.
procedure TQualityGridCellDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCanEdit := True;
  if (LeftStr(TxStr, 1) <> cQualChr) then
    TxStr := cQualChr;
  NumChs := Length(TxStr);
  SelBeg := NumChs;
  SelEnd := NumChs;
  SetCaret;
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TQualityGridCellDialogEditor.KeyEditor(var Key: Char);
begin
  if (Key = #13) then
    begin
      if ShowDialog = mrOk then
      begin
        CanAcceptChar(FCell.GSEData[cQualDlgIdx]);
        FCanEdit := True;
        FCell.SetText(cQualChr + FCell.GSEData[cQualDlgIdx]);
      end;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TQualityGridCellDialogEditor.ClearEdit;
begin
  inherited;
  if Assigned(FDialog) then
    FDialog.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TQualityGridCellDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (inherited CanAcceptChar(Key)) and ((Key > #48) and (Key < #55));
  if Result then
    begin
      TxStr := cQualChr + Key;
      FCell.GSEData := cQualXID + TxStr;
      FCell.HasValidationError := False;
    end;
  Result := Result or (Key = #13);
end;

function TQualityGridCellDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  if (SelEnd < 2) then
    Result := False
  else
    Result := inherited CanMoveCaret(Direction);
end;

procedure TQualityGridCellDialogEditor.SetClickCaret(ClickPt: TPoint);
begin
  inherited;
  if (SelEnd = 1) then
    MoveCaret(False, goRight);
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TQualityGridCellDialogEditor.CanLinkComments: Boolean;
begin
  Result := False;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TQualityGridCellDialogEditor.ShowDialog: TModalResult;
var
  DialogResult: TModalResult;
begin
  if FCanEdit and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FCell);
        DialogResult := FDialog.ShowModal;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TConditionGridCellDialogEditor ------------------------

/// summary: Indicates whether the number is valid for the cell.
/// remarks: Provide range checking against the cell value.
function TConditionGridCellDialogEditor.HasValidNumber: Boolean;
var
  Value: Double;
begin
  Value := GetValue;
  Result := (Value > 0) and (Value < 7);
end;

/// summary: Loads the cell into the editor.
procedure TConditionGridCellDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCanEdit := True;
  if (LeftStr(TxStr, 1) <> cCondChr) then
    TxStr := cCondChr;
  NumChs := Length(TxStr);
  SelBeg := NumChs;
  SelEnd := NumChs;
  SetCaret;
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TConditionGridCellDialogEditor.KeyEditor(var Key: Char);
begin
  if (Key = #13) then
    begin
      if ShowDialog = mrOk then
      begin
        CanAcceptChar(FCell.GSEData[cCondDlgIdx]);
        FCanEdit := True;
        FCell.SetText(cCondChr + FCell.GSEData[cCondDlgIdx]);
      end;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TConditionGridCellDialogEditor.ClearEdit;
begin
  inherited;
  if Assigned(FDialog) then
    FDialog.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TConditionGridCellDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (inherited CanAcceptChar(Key)) and ((Key > #48) and (Key < #55));
  if Result then
    begin
      TxStr := cCondChr + Key;
      FCell.GSEData := cCondXID + TxStr;
      FCell.HasValidationError := False;
    end;
  Result := Result or (Key = #13);
end;

function TConditionGridCellDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  if (SelEnd < 2) then
    Result := False
  else
    Result := inherited CanMoveCaret(Direction);
end;

procedure TConditionGridCellDialogEditor.SetClickCaret(ClickPt: TPoint);
begin
  inherited;
  if (SelEnd = 1) then
    MoveCaret(False, goRight);
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TConditionGridCellDialogEditor.CanLinkComments: Boolean;
begin
  Result := False;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TConditionGridCellDialogEditor.ShowDialog: TModalResult;
var
  DialogResult: TModalResult;
begin
  if FCanEdit and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FCell);
        DialogResult := FDialog.ShowModal;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TSLDialogEditor ---------------------------------------

/// summary: Initializes a new instance of TSLDialogEditor.
constructor TSLDialogEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;
  FDialogGroupCellList := TCellList.Create;
end;

/// summary: Frees memory and releases resources.
destructor TSLDialogEditor.Destroy;
begin
  FreeAndNil(FDialogGroupCellList);
  inherited;
end;

/// summary: Unhighlights cells when finished editing.
procedure TSLDialogEditor.BeforeDestruction;
var
  Index: Integer;
begin
  if FActivator then
    for Index := 0 to FDialogGroupCellList.Count - 1 do
      FDialogGroupCellList[Index].Display;
  inherited;
end;

/// summary: Creates the dialog and loads the cell into the form.
procedure TSLDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCell := Cell as TTextBaseCell;
  FDoc := TEditor(Self).FDoc as TContainer;
  TDialogEditorHelper.BuildDialogCellGroupList(FCell, FDialogGroupCellList);
  FDataSourceCell := TDialogEditorHelper.GetDialogDataSource(FCell, FDialogGroupCellList);
  if Assigned(FDoc) and (FDoc.docActiveCell = FCell) then
    begin
      FActivator := True;
      TDialogEditorHelper.LoadCellGroup(FDialogGroupCellList, FDoc);
    end
  else
    FActivator := False;
end;

/// summary: Frees the dialog and unloads the cell.
procedure TSLDialogEditor.UnloadCell;
begin
  inherited;
  if FActivator then
    TDialogEditorHelper.UnloadCellGroup(FDialogGroupCellList);
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TSLDialogEditor.KeyEditor(var Key: Char);
var
  Editor: IDialogEditor;
begin
  if (Key = #13) and Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.ShowDialog;
end;

/// summary: Shows the dialog when the editor is left-clicked.
procedure TSLDialogEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Editor: IDialogEditor;
begin
  if (Button = mbLeft) then
    begin
      if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
        Editor.ShowDialog;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TSLDialogEditor.ClearEdit;
var
  Editor: IDialogEditor;
begin
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TSLDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (Key = #13);
end;

/// summary: Indicates that the user may not cut text.
function TSLDialogEditor.CanCut: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not copy text.
function TSLDialogEditor.CanCopy: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not paste text.
function TSLDialogEditor.CanPaste: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not select all text.
function TSLDialogEditor.CanSelectAll: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not use the spell checker.
function TSLDialogEditor.CanSpellCheck: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not undo changes.
function TSLDialogEditor.CanUndo: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not move the caret.
function TSLDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TSLDialogEditor.CanLinkComments: Boolean;
begin
  Result := Assigned(FDialog);
  Result := Result and not FDoc.Locked;
  Result := Result and (FCell.FCellID <> CCommentsCellID);
  Result := Result and (FCell.FType <> cSignature);
  Result := Result and not IsBitSet(FCellPrefs, bCelNumOnly);
  Result := Result and not IsBitSet(FCellPrefs, bCelFormat);
  Result := Result and not IsBitSet(FCellPrefs, bCelDispOnly);
end;

/// summary: Links a comment addendum to the text cell and inserts CommentText onto the addendum.
procedure TSLDialogEditor.LinkComments;
var
  Body: String;
  CommentCell: TWordProcessorCell;
  Form: TDocForm;
  Heading: String;
  SavedCanEdit: Boolean;
  SavedPosition: TPoint;
begin
  if CanLinkComments then
    begin
      SavedCanEdit := FCanEdit;
      SavedPosition.X := FDoc.docView.HorzScrollBar.Position;
      SavedPosition.Y := FDoc.docView.VertScrollBar.Position;
      try
        FCanEdit := True;
        Body := StringReplace(FDialog.GetOverflowText, Char(kReturnKey), '', [rfReplaceAll]);
        Heading := FCell.UserPreference[CCellCaptionPreference];
        if (Length(Body) > 0) then
          begin
            if FCell.HasLinkedComments then
              begin
                CommentCell := FDoc.FindCellInstance(FCell.LinkedCommentCell) as TWordProcessorCell;
                CommentCell.RewriteSection(FCell.LinkedCommentSection, Heading, Body);
              end
            else
              begin
                Form := FDoc.GetFormByOccurance(CUADCommentAddendum, 0, True);
                if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
                  begin
                    CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
                    CommentCell.GSEData := ' ';  // suppress validation errors
                    CommentCell.Disabled := True;
                    FCell.LinkedCommentCell := CommentCell.InstanceID;
                    FCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
                  end;
              end;
          end;
      finally
        FCanEdit := SavedCanEdit;
        FDoc.docView.HorzScrollBar.Position := SavedPosition.X;
        FDoc.docView.VertScrollBar.Position := SavedPosition.Y;
      end;
    end;
end;

/// summary: Checks for text overflow and links carry-over comments.
//AND ALSO does context replication
procedure TSLDialogEditor.CheckTextOverflow;
var
  PreviousKind: Integer;
begin
  if Modified then
    begin
      if TextOverflowed and CanLinkComments then
        LinkComments
      else
        FCell.LinkedCommentCell := GUID_NULL;

      PreviousKind := FCell.Kind;
      try
        FCell.Kind := cKindTx;
        SaveChanges;
        FCell.PostProcess;
      finally
        FCell.Kind := PreviousKind;
      end;
    end;
end;

/// summary: Clears the editor and dialog of content.
procedure TSLDialogEditor.Clear;
begin
  if Assigned(FDialog) then
    FDialog.Clear;

  inherited ClearEdit;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TSLDialogEditor.ShowDialog: TModalResult;
var
  DialogEditor: IDialogEditor;
  DialogResult: TModalResult;
  Index: Integer;
begin
  if not FDoc.Locked and not IsBitSet(FCellStatus, bDisabled) and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FDataSourceCell);
        DialogResult := FDialog.ShowModal;
        if (DialogResult = mrOK) then
          begin
            for Index := 0 to FDialogGroupCellList.Count - 1 do
              begin
                FDialogGroupCellList[Index].FEmptyCell := False;
                FDialogGroupCellList[Index].FWhiteCell := True;
                FDialogGroupCellList[Index].HasValidationError := False;
                if Supports(FDialogGroupCellList[Index].Editor, IDialogEditor, DialogEditor) then
                  DialogEditor.CheckTextOverflow;
              end;
          end;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TMLDialogEditor ---------------------------------------

/// summary: Initializes a new instance of TMLDialogEditor.
constructor TMLDialogEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;
  FDialogGroupCellList := TCellList.Create;
end;

/// summary: Frees memory and releases resources.
destructor TMLDialogEditor.Destroy;
begin
  FreeAndNil(FDialogGroupCellList);
  inherited;
end;

/// summary: Unhighlights cells when finished editing.
procedure TMLDialogEditor.BeforeDestruction;
var
  Index: Integer;
begin
  if FActivator then
    for Index := 0 to FDialogGroupCellList.Count - 1 do
      FDialogGroupCellList[Index].Display;
  inherited;
end;

/// summary: Creates the dialog and loads the cell into the form.
procedure TMLDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;
  FCell := Cell as TTextBaseCell;
  FDoc := TEditor(Self).FDoc as TContainer;
  TDialogEditorHelper.BuildDialogCellGroupList(FCell, FDialogGroupCellList);
  FDataSourceCell := TDialogEditorHelper.GetDialogDataSource(FCell, FDialogGroupCellList);
  if Assigned(FDoc) and (FDoc.docActiveCell = FCell) then
    begin
      FActivator := True;
      TDialogEditorHelper.LoadCellGroup(FDialogGroupCellList, FDoc);
    end
  else
    FActivator := False;
end;

/// summary: Frees the dialog and unloads the cell.
procedure TMLDialogEditor.UnloadCell;
begin
  inherited;
  if FActivator then
    TDialogEditorHelper.UnloadCellGroup(FDialogGroupCellList);
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TMLDialogEditor.KeyEditor(var Key: Char);
var
  Editor: IDialogEditor;
begin
  if (Key = #13) and Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.ShowDialog;
end;

/// summary: Shows the dialog when the editor is left-clicked.
procedure TMLDialogEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Editor: IDialogEditor;
begin
  if (Button = mbLeft) then
    begin
      if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
        Editor.ShowDialog;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TMLDialogEditor.ClearEdit;
var
  Editor: IDialogEditor;
begin
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TMLDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (Key = #13);
end;

/// summary: Indicates that the user may not cut text.
function TMLDialogEditor.CanCut: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not copy text.
function TMLDialogEditor.CanCopy: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not paste text.
function TMLDialogEditor.CanPaste: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not select all text.
function TMLDialogEditor.CanSelectAll: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not use the spell checker.
function TMLDialogEditor.CanSpellCheck: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not undo changes.
function TMLDialogEditor.CanUndo: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not move the caret.
function TMLDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TMLDialogEditor.CanLinkComments: Boolean;
begin
  Result := Assigned(FDialog);
  Result := Result and not FDoc.Locked;
  Result := Result and (FCell.FCellID <> CCommentsCellID);
  Result := Result and (FCell.FType <> cSignature);
  Result := Result and not IsBitSet(FCellPrefs, bCelNumOnly);
  Result := Result and not IsBitSet(FCellPrefs, bCelFormat);
  Result := Result and not IsBitSet(FCellPrefs, bCelDispOnly);
end;

/// summary: Links a comment addendum to the text cell and inserts CommentText onto the addendum.
procedure TMLDialogEditor.LinkComments;
var
  Body: String;
  CommentCell: TWordProcessorCell;
  Form: TDocForm;
  Heading: String;
  SavedCanEdit: Boolean;
  SavedPosition: TPoint;
begin
  if CanLinkComments then
    begin
      SavedCanEdit := FCanEdit;
      SavedPosition.X := FDoc.docView.HorzScrollBar.Position;
      SavedPosition.Y := FDoc.docView.VertScrollBar.Position;
      try
        FCanEdit := True;
        Body := StringReplace(FDialog.GetOverflowText, Char(kReturnKey), '', [rfReplaceAll]);
        Heading := FCell.UserPreference[CCellCaptionPreference];
        if (Length(Body) > 0) then
          begin
            if FCell.HasLinkedComments then
              begin
                CommentCell := FDoc.FindCellInstance(FCell.LinkedCommentCell) as TWordProcessorCell;
                if not Assigned(CommentCell) then
                  begin
                    FCell.LinkedCommentCell := GUID_NULL;
                    LinkComments;  // recursive
                  end
                else
                  CommentCell.RewriteSection(FCell.LinkedCommentSection, Heading, Body);
              end
            else
              begin
                Form := FDoc.GetFormByOccurance(CUADCommentAddendum, 0, True);
                if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
                  begin
                    CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
                    CommentCell.GSEData := ' ';  // suppress validation errors
                    CommentCell.Disabled := True;
                    FCell.LinkedCommentCell := CommentCell.InstanceID;
                    FCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
                  end;
              end;
          end;
      finally
        FCanEdit := SavedCanEdit;
        FDoc.docView.HorzScrollBar.Position := SavedPosition.X;
        FDoc.docView.VertScrollBar.Position := SavedPosition.Y;
      end;
    end;
end;

/// summary: Checks for text overflow and links carry-over comments.
procedure TMLDialogEditor.CheckTextOverflow;
var
  PreviousKind: Integer;
begin
  if Modified then
    begin
      if TextOverflowed and CanLinkComments then
        LinkComments
      else
        FCell.LinkedCommentCell := GUID_NULL;

      PreviousKind := FCell.Kind;
      try
        FCell.Kind := cKindTx;
        SaveChanges;
        FCell.PostProcess;
      finally
        FCell.Kind := PreviousKind;
      end;
    end;
end;

/// summary: Clears the editor and dialog of content.
procedure TMLDialogEditor.Clear;
begin
  if Assigned(FDialog) then
    FDialog.Clear;

  inherited ClearEdit;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TMLDialogEditor.ShowDialog: TModalResult;
var
  DialogEditor: IDialogEditor;
  DialogResult: TModalResult;
  Index: Integer;
begin
  if not FDoc.Locked and not IsBitSet(FCellStatus, bDisabled) and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FDataSourceCell);
        DialogResult := FDialog.ShowModal;
        if (DialogResult = mrOK) then
          begin
            for Index := 0 to FDialogGroupCellList.Count - 1 do
              begin
                FDialogGroupCellList[Index].FEmptyCell := False;
                FDialogGroupCellList[Index].FWhiteCell := True;
                FDialogGroupCellList[Index].HasValidationError := False;
                if Supports(FDialogGroupCellList[Index].Editor, IDialogEditor, DialogEditor) then
                  DialogEditor.CheckTextOverflow;
              end;
          end;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

// --- TWordProcessorDialogEditor ----------------------------

/// summary: Paints the word processor control to the specified device context.
/// remarks: This procedure duplicates TWPCustomRtfEdit.PaintTo, but fixes a nasty memory leak.
///          TWPCustomRtfEdit.PaintTo fails to release the off-screen bitmap used for double-buffering.
procedure TWordProcessorDialogEditor.PaintTo(DC: THandle; X, Y: Integer);
var
  PaintMode: TWPPaintDesktopModes;
  Canvas: TCanvas;
  Bitmap: TBitmap;
  Box: TRect;
begin
  Bitmap := nil;
  Canvas := nil;
  try
    Bitmap := Graphics.TBitmap.Create;
    Canvas := TCanvas.Create;
    Canvas.Handle := DC;
    PaintMode := [wpDrawFocusOptional, wpDontUseDoubleBuffer];
    Bitmap.Width := FWPControl.Width;
    Bitmap.Height := FWPControl.Height;

    Box := Rect(0, 0, Bitmap.Width, Bitmap.Height);
    //FWPControl.Memo.PaintDesktop(Bitmap.Canvas, Bitmap.Width, Bitmap.Height, PaintMode);  // zooming is ignored
    FWPControl.PrintPageOnCanvas(Bitmap.Canvas, box, FCell.DisplayPageNumber - 1, [ppmIgnoreSelection, ppmStretchWidth, ppmStretchHeight], FWPControl.Zooming);
    Canvas.Draw(X, Y, Bitmap);
  finally
    Canvas.Handle := 0;
    FreeAndNil(Canvas);
    FreeAndNil(Bitmap);
  end;
end;

/// summary: Initializes the paint pages of all linked cell editors.
///          Use this method to repair incorrect memo page counts.
procedure TWordProcessorDialogEditor.InitializePaintPages;
var
  Index: Integer;
  List: TWordProcessorCellList;
begin
  List := TWordProcessorCellList.Create;
  try
    FCell.PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      if (List[Index].Editor is TWordProcessorDialogEditor) then
        (List[Index].Editor as TWordProcessorDialogEditor).FControl.InitializePaintPages;
  finally
    FreeAndNil(List);
  end;
end;

/// summary: Paints the editor.
procedure TWordProcessorDialogEditor.Paint;
var
  Origin: TPoint;
  Position: TRect;
  SavedDC: HDC;
begin
  // paint the editor
  FCanvas.Refresh;
  SavedDC := SaveDC(FCanvas.Handle);
  try
    Origin := FCell.ParentViewPage.PgOrg;
    Origin.X := Origin.X - FDoc.docView.HorzScrollBar.ScrollPos;
    Origin.Y := Origin.Y - FDoc.docView.VertScrollBar.ScrollPos;
    Origin.X := Origin.X + FCell.ParentViewPage.PgBody.Bounds.Left;
    Origin.Y := Origin.Y + FCell.ParentViewPage.PgBody.Bounds.Top;
    SetViewportOrgEx(FCanvas.Handle, Origin.X, Origin.Y, nil);

    Position := ScaleRect(FFrame, cNormScale, scale);
    FWPControl.Left := Position.Left;
    FWPControl.Top := Position.Top;
    FWPControl.Width := Position.Right - Position.Left;
    FWPControl.Height := Position.Bottom - Position.Top;
    FWPControl.PaperColor := FCell.Background;
    FWPControl.Zooming := FDoc.docView.ViewScale;
    PaintTo(FCanvas.Handle, FWPControl.Left, FWPControl.Top);
  finally
    RestoreDC(FCanvas.Handle, SavedDC);
    FCanvas.Refresh;
  end;
end;

/// summary: Initializes a new instance of TMLDialogEditor.
constructor TWordProcessorDialogEditor.Create(AOwner: TAppraisalReport);
begin
  inherited;
  FDialogGroupCellList := TCellList.Create;
end;

/// summary: Frees memory and releases resources.
destructor TWordProcessorDialogEditor.Destroy;
begin
  FreeAndNil(FDialogGroupCellList);
  inherited;
end;

/// summary: Unhighlights cells when finished editing.
procedure TWordProcessorDialogEditor.BeforeDestruction;
var
  Index: Integer;
begin
  if FActivator then
    for Index := 0 to FDialogGroupCellList.Count - 1 do
      FDialogGroupCellList[Index].Display;
  inherited;
end;

/// summary: Creates the dialog and loads the cell into the form.
procedure TWordProcessorDialogEditor.LoadCell(Cell: TBaseCell; cUID:CellUID);
begin
  inherited;

  // initialize
  FCell := Cell as TWordProcessorCell;
  FControl.Visible := False;
  FWPControl := TWordProcessorControl.CreateDynamic;
  FWPControl.Ctl3D := False;
  FWPControl.AllowMultiView := True;
  FWPControl.EditBoxModes := [wpemLimitTextHeight];
  FWPControl.EditOptions := [wpNoHorzScrolling, wpNoVertScrolling, wpNoAutoScroll];
  FWPControl.LayoutMode := wplayNormal;
  FWPControl.ScrollBars := ssNone;
  FWPControl.SpellCheckStrategie := wpspCheckInInit;
  FWPControl.ViewOptions := [wpDontDrawSectionMarker];
  FWPControl.XBetween := 0;
  FWPControl.XOffset := 0;
  FWPControl.YBetween := 0;
  FWPControl.YOffset := 0;
  FWPControl.RemoveRTFData;
  FWPControl.SetRTFData(FCell.RTFData);
  FWPControl.InitializePaintPages;
  FDoc := TEditor(Self).FDoc as TContainer;
  TDialogEditorHelper.BuildDialogCellGroupList(FCell, FDialogGroupCellList);
  FDataSourceCell := TDialogEditorHelper.GetDialogDataSource(FCell, FDialogGroupCellList);

  // activate dialog group cells
  if Assigned(FDoc) and (FDoc.docActiveCell = FCell) then
    begin
      FActivator := True;
      TDialogEditorHelper.LoadCellGroup(FDialogGroupCellList, FDoc);
    end
  else
    FActivator := False;
end;

/// summary: Frees the dialog and unloads the cell.
procedure TWordProcessorDialogEditor.UnloadCell;
begin
  inherited;
  if FActivator then
    TDialogEditorHelper.UnloadCellGroup(FDialogGroupCellList);
  if Assigned(FWPControl) then
    begin
      FWPControl.RemoveRTFData;
      FreeAndNil(FWPControl);
    end;
end;

/// summary: Activates the editor.
procedure TWordProcessorDialogEditor.ActivateEditor;
begin
  FActive := True;
end;

/// summary: Indicates whether the cell being edited is on the specified page.
function TWordProcessorDialogEditor.HasActiveCellOnPage(Page: TObject): Boolean;
var
  Index: Integer;
  List: TWordProcessorCellList;
begin
  Result := False;
  if (FCell <> nil) then
    begin
      List := TWordProcessorCellList.Create;
      try
        FCell.PopulateDataLinkList(List);
        for Index := 0 to List.Count - 1 do
          Result := Result or (List[Index].ParentPage = Page);
      finally
        FreeAndNil(List);
      end;
    end;
end;

/// summary: Draws the cell editor.
procedure TWordProcessorDialogEditor.DrawCurCell;
var
  Index: Integer;
  Intersection: TRect;
  List: TWordProcessorCellList;
begin
  List := TWordProcessorCellList.Create;
  try
    FCell.PopulateDataLinkList(List);
    for Index := 0 to List.Count - 1 do
      begin
        if IntersectRect(Intersection, List[Index].Cell2View, FDoc.docView.ClientRect) then
          if (List[Index].Editor is TWordProcessorDialogEditor) then
            (List[Index].Editor as TWordProcessorDialogEditor).Paint;
      end;
  finally
    FreeAndNil(List);
  end;
end;

/// summary: Shows the dialog when a key is typed into the editor.
procedure TWordProcessorDialogEditor.KeyEditor(var Key: Char);
var
  Editor: IDialogEditor;
begin
  if (Key = #13) and Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.ShowDialog;
end;

/// summary: Shows the dialog when the editor is left-clicked.
procedure TWordProcessorDialogEditor.ClickEditor(ClickPt: TPoint; Button: TMouseButton; Shift: TShiftState);
var
  Editor: IDialogEditor;
begin
  if (Button = mbLeft) then
    begin
      if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
        Editor.ShowDialog;
    end
  else
    inherited;
end;

/// summary: Clears the editor and dialog of content.
procedure TWordProcessorDialogEditor.ClearEdit;
var
  Editor: IDialogEditor;
begin
  if Supports(FDataSourceCell.Editor, IDialogEditor, Editor) then
    Editor.Clear;
end;

/// summary: Indicates whether the editor can process the specified key.
function TWordProcessorDialogEditor.CanAcceptChar(Key: Char): Boolean;
begin
  Result := (Key = #13);
end;

/// summary: Indicates that the user may not cut text.
function TWordProcessorDialogEditor.CanCut: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not copy text.
function TWordProcessorDialogEditor.CanCopy: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not paste text.
function TWordProcessorDialogEditor.CanPaste: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not select all text.
function TWordProcessorDialogEditor.CanSelectAll: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not use the spell checker.
function TWordProcessorDialogEditor.CanSpellCheck: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not undo changes.
function TWordProcessorDialogEditor.CanUndo: Boolean;
begin
  Result := False;
end;

/// summary: Indicates that the user may not move the caret.
function TWordProcessorDialogEditor.CanMoveCaret(Direction: integer): Boolean;
begin
  Result := False;
end;

/// summary: Indicates whether the cell is configured to allow linked comments.
function TWordProcessorDialogEditor.CanLinkComments: Boolean;
begin
  Result := Assigned(FDialog);
  Result := Result and not FDoc.Locked;
  Result := Result and not FCell.AutoExpanding;
  Result := Result and (FCell.FCellID <> CCommentsCellID);
  Result := Result and (FCell.FType <> cSignature);
  Result := Result and not IsBitSet(FCellPrefs, bCelNumOnly);
  Result := Result and not IsBitSet(FCellPrefs, bCelFormat);
  Result := Result and not IsBitSet(FCellPrefs, bCelDispOnly);
end;

/// summary: Links a comment addendum to the text cell and inserts CommentText onto the addendum.
procedure TWordProcessorDialogEditor.LinkComments;
var
  Body: String;
  CommentCell: TWordProcessorCell;
  Form: TDocForm;
  Heading: String;
  SavedCanEdit: Boolean;
  SavedPosition: TPoint;
begin
  if CanLinkComments then
    begin
      SavedCanEdit := FCanEdit;
      SavedPosition.X := FDoc.docView.HorzScrollBar.Position;
      SavedPosition.Y := FDoc.docView.VertScrollBar.Position;
      try
        FCanEdit := True;
        Body := StringReplace(FDialog.GetOverflowText, Char(kReturnKey), '', [rfReplaceAll]);
        Heading := FCell.UserPreference[CCellCaptionPreference];
        if (Length(Body) > 0) then
          begin
            if FCell.HasLinkedComments then
              begin
                CommentCell := FDoc.FindCellInstance(FCell.LinkedCommentCell) as TWordProcessorCell;
                CommentCell.RewriteSection(FCell.LinkedCommentSection, Heading, Body);
              end
            else
              begin
                Form := FDoc.GetFormByOccurance(CUADCommentAddendum, 0, True);
                if Assigned(Form) and (Form.GetCellByID(CCommentsCellID) is TWordProcessorCell) then
                  begin
                    CommentCell := Form.GetCellByID(CCommentsCellID) as TWordprocessorCell;
                    CommentCell.GSEData := ' ';  // suppress validation errors
                    CommentCell.Disabled := True;
                    FCell.LinkedCommentCell := CommentCell.InstanceID;
                    FCell.LinkedCommentSection := CommentCell.AppendSection(UpperCase(Heading), Body);
                  end;
              end;
          end;
      finally
        FCanEdit := SavedCanEdit;
        FDoc.docView.HorzScrollBar.Position := SavedPosition.X;
        FDoc.docView.VertScrollBar.Position := SavedPosition.Y;
      end;
    end;
end;

/// summary: Checks for text overflow and links carry-over comments.
procedure TWordProcessorDialogEditor.CheckTextOverflow;
var
  PreviousKind: Integer;
begin
  if Modified then
    begin
      if TextOverflowed and CanLinkComments then
        LinkComments
      else
        FCell.LinkedCommentCell := GUID_NULL;

      PreviousKind := FCell.Kind;
      try
        FCell.Kind := cKindTx;
        SaveChanges;
        FCell.PostProcess;
      finally
        FCell.Kind := PreviousKind;
      end;
    end;
end;

/// summary: Clears the editor and dialog of content.
procedure TWordProcessorDialogEditor.Clear;
begin
  if Assigned(FDialog) then
    FDialog.Clear;

  inherited ClearEdit;
end;

/// summary: Shows a dialog for editing the data in the cell.
function TWordProcessorDialogEditor.ShowDialog: TModalResult;
var
  DialogEditor: IDialogEditor;
  DialogResult: TModalResult;
  Index: Integer;
begin
  if not FDoc.Locked and not IsBitSet(FCellStatus, bDisabled) and not Assigned(FDialog) then
    begin
      FDialog := TDialogEditorHelper.GetDialogClass(FCell).Create(FDoc);
      try
        FDialog.LoadCell(FDataSourceCell);
        DialogResult := FDialog.ShowModal;
        if (DialogResult = mrOK) then
          begin
            for Index := 0 to FDialogGroupCellList.Count - 1 do
              begin
                FDialogGroupCellList[Index].FEmptyCell := False;
                FDialogGroupCellList[Index].FWhiteCell := True;
                FDialogGroupCellList[Index].HasValidationError := False;
                if Supports(FDialogGroupCellList[Index].Editor, IDialogEditor, DialogEditor) then
                  DialogEditor.CheckTextOverflow;
              end;
          end;
      finally
        FreeAndNil(FDialog);
      end;
    end
  else
    DialogResult := mrNone;

  Result := DialogResult;
end;

initialization
  RegisterEditor(TChkBoxDialogEditor);
  RegisterEditor(TGridCellDialogEditor);
  RegisterEditor(TMLDialogEditor);
  RegisterEditor(TSLDialogEditor);
  RegisterEditor(TWordProcessorDialogEditor);
  RegisterEditor(TQualityGridCellDialogEditor);
  RegisterEditor(TConditionGridCellDialogEditor);

end.
