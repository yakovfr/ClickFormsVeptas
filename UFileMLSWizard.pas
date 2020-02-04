unit UFileMLSWizard;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc.}

{This is MLS Form to MLS Import Wizard tha allow you to costumize yor MLS }

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  UGridMgr,
  Controls,
  UContainer,
  Forms,
  Dialogs,
  RzButton,
  StdCtrls,
  jpeg,
  ExtCtrls,
  Grids,
  Buttons,
  Menus,
  ActnList,
  UForms,
  Gauges,
  UFileWizardUtils,
  UFileImportUtils,
  UUtil1,
  Grids_ts,
  ComCtrls,
  RzBHints,
  TSGrid,
  StrUtils,
  uCell;

type

 TGridColumnList = class(TObject) // W'll store all Row and Fields of Row
   DataField : TStringList;
 end;


 TIds = class(TObject) // Hold the SubjIds and CompIds when remove map from teh Grid.
  subjId : Integer;
  compId : Integer;
 end;


  TFileMLSWizard = class(TAdvancedForm)
    Notebook: TNotebook;
    Label4: TLabel;
    EditPath: TEdit;
    RzBSelect: TRzBitBtn;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    tsGrid1: TtsGrid;
    ListBox: TListBox;
    NumRec: TLabel;
    Label2: TLabel;
    TotalRec: TLabel;
    ActionList: TActionList;
    PopupFunction: TPopupMenu;
    Sum1: TMenuItem;
    Fx: TRzMenuButton;
    concatenation1: TMenuItem;
    Clear: TAction;
    Clear1: TMenuItem;
    OperationExec: TAction;
    Average1: TMenuItem;
    SpeedArrow: TSpeedButton;
    CalcAge: TMenuItem;
    NoteOptions: TNotebook;
    Label9: TLabel;
    Delimiters: TRadioGroup;
    SG1: TStringGrid;
    LRecords: TLabel;
    EditOther: TEdit;
    Label1: TLabel;
    SpeedButton3: TSpeedButton;
    Panel1: TPanel;
    tsGridRecords: TtsGrid;
    CheckOverwrite: TCheckBox;
    Label6: TLabel;
    ComboQualifier: TComboBox;
    Label8: TLabel;
    Label11: TLabel;
    BackPrev: TRzBitBtn;
    EditMappName2: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    LabMLSPathName: TLabel;
    Sub1: TMenuItem;
    Mult1: TMenuItem;
    CombMapping: TComboBox;
    RzBitBtn2: TRzBitBtn;
    N1: TMenuItem;
    Label14: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    FontDialog: TFontDialog;
    CheckBoxEditMap: TCheckBox;
    Panel2: TPanel;
    BPreview: TRzBitBtn;
    BSave: TRzBitBtn;
    BSaveAs: TRzBitBtn;
    BBack: TRzBitBtn;
    BNext: TRzBitBtn;
    BCancel: TRzBitBtn;
    Panel3: TPanel;
    Image1: TImage;
    chkUADConvert: TCheckBox;
    procedure CmdOperation(Tag : Integer);
    procedure RzBSelectClick(Sender: TObject);
    procedure EditPathChange(Sender: TObject);
    procedure Delimiters_tmpClick(Sender: TObject);
    procedure BNext_tmpClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure tsGrid1CellEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure tsGrid1ClickCell(Sender: TObject; DataColDown, DataRowDown,
      DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure ClearExecute(Sender: TObject);
    procedure OperationExecExecute(Sender: TObject);
    procedure tsGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SpeedArrowClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BCancel_tmpClick(Sender: TObject);
    procedure BBack_tmpClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure tsGrid1CellChanged(Sender: TObject; OldCol, NewCol, OldRow,
      NewRow: Integer);
    procedure CombMappingChange(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure BPreview_tmpClick(Sender: TObject);
    procedure BSave_tmpClick(Sender: TObject);
    procedure tsGrid1Enter(Sender: TObject);
    procedure BSaveAs_tmpClick(Sender: TObject);
    procedure tsGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tsGrid1DblClick(Sender: TObject);
    procedure tsGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox12DblClick(Sender: TObject);
    procedure ListBox12DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tsGrid1RowChanged(Sender: TObject; OldRow, NewRow: Integer);
    procedure BPreviewClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BSaveAsClick(Sender: TObject);
    procedure BBackClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure tsGridRecordsComboDropDown(Sender: TObject;
      Combo: TtsComboGrid; DataCol, DataRow: Integer);
    procedure chkUADConvertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    DocCompTable    : TCompMgr2;
    DocListingTable : TCompMgr2;
    Doc             : TContainer;
    G_CurrentRow    : Integer;     // Hold value of row has been select.
    indexGridColumn : Integer;     // Hold value of GridColum has beem selected.
    G_ColumnID      : Integer;     // use to create GridColum
    G_FieldQuant    : Integer;
    GridMousePosX   : Integer;     // Get Mouse position over the Grid.
    GridMousePosY   : Integer;     // Get Mouse position over the Grid.
    DataFile        : TStringList; // Hold the MLS at the First Time.
    FieldList       : TStringList; // Hold the row of mls with all fields
    clfFldList      : TStringList; // Hold the TClfFldObject ( CF Avaliable cell )
    GridChange      : Boolean;     // If some thing change in the Grid.
    Delimiter       : String;      // Hold number of field has been select.
    TextQualifier   : String;
    G_strField      : String;      // Hold value of each Field when do a Parse
    ImportMap_Path  : String;      // Hold the path of Map.
    MappName        : String;      // Hold the Map Name.

    function SetUADConvert(doc: TContainer; compCol: TCompColumn; cell:TBaseCell; s: String):String;
    procedure writePref;
  protected
    function ConcatStrings(const S: array of String; FieldName:String): String; //github 248: pass in FieldName
    procedure SaveSettings;
    procedure LoadSettings;
    procedure AdjustDPISettings;
  public
    { Public declarations }
    GridColumn : array of TGridColumnList; // MLS Rows

    //Step 1
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateGridSG1;
    procedure StepsNavagitor( StepIndex : Integer; Preview : Integer );
    Procedure ButtonControl( PageIndex : Integer; Preview : Integer  );

    //Step 2
    function  ConfigUserMapPath(const fName: String): String;
    procedure UpdatetsGrid;
    procedure SetMap;
    procedure LoadUserMaps;
    function  OpenMapping(MappPath : string):Boolean;
    procedure Navigator(direction : string);

    //Step 3
    procedure CellEdit(Column,Row : integer; CellValue : String);
    procedure AddClickFormField;
    procedure ColorLineMappinng(Row : Integer);
    procedure ColorCurrentLine(Column : Integer);
    Procedure SelectRow(Column,Row : Integer);
    Function  SelectOrderDialog(FldList : TStringList; TypOper : Integer) : String;
    procedure StampOpField( Fld : String;  Stamp : Boolean  );
    procedure ItalicStamps;
    procedure RemoveFieldHasbeenMap( Id : Integer);

    //Step 4
    procedure TransferSubjectField(clfFldList: TStringList);
    procedure TransferComField( clfFldList: TStringList; cmp: CompID);
    procedure HSpecCells(CompCol: TCompColumn;value: String;flag: Integer);
    procedure PostValue( SubId,CompId : Integer; Value : String );
    procedure SaveMapping(Path : String);

    //Operation Function
    function BuildOperation(FuncType : integer; Row : Integer):  String;
    function GetSelectedRow: TStringList;
    function FuncEqual(Row : Integer ) : String;
    function FuncConcat(OpFilelds, FieldName : String ): String; //github 248: pass in FieldName
    function FuncMath(OpFilelds : String ; FuncType : Integer ) : String;
    Function FuncDateAge(Data : String) : String;
    procedure ClearOperation(Row : Integer);
    procedure Removemapping(Row : Integer);
    procedure UnselectRows;
  end;

  procedure ImportWizard(ADoc: TContainer);

var
  FileMLSWizard   : TFileMLSWizard;

implementation

uses
 Math,UCellAutoAdjust,UGlobals,UBase,ULicUser,
 Types,UForm,UPage,{UCell,}UMain,UStatus,UUtil3,
 UFileMLSWizardSelOrder, UUtil2, UMath, UUADUtils, uServices, UCustomerServices,
 UUADObject,IniFiles;

{$R *.dfm}

const

  C_strNone=       'None';
  C_strSubject=    'Subject';
  C_strComp=       'Comp';
  C_strListing=    'Listing';

  C_Err=           0;
  C_Warning=       1;
  C_Success=       2;

  errProblem=       'A problem was encountered: ';
  C_ErrMsg=         '#Value';
  MLSEncryptKey=    1024;

  // Grid Column
  C_ColNo=          1;
  C_ColName=        2;
  C_Coltext1=       3;
  C_ColData=        4;
  C_ColText2=       5;
  C_ColOper=        6;  // Unvisible.
  C_ColGoTo=        8;
  C_ColResult=      7;
  C_ColDest=        9;
  C_ColdIndex=      10; // Unvisible.
  C_ColMath=        11; // Unvisible.
  C_ColSel=         12; // Unvisible.
  C_ColCompIds=     13; // Unvisible.
  C_ColSubjeIds=    14; // Unvisible.

  C_selfldstyle : TFontStyles = [fsItalic];

  // navegator
  C_R=            'Right';
  C_L=            'Left';

  // Operation
  C_Oequal=       1;
  C_OConcat=      2;
  C_Osum=         3;
  C_OSub=         4;
  C_OMult=        5;
  C_ODivi=        6;
  C_OAver=        7;
  C_OCAge=        8;

  // Operation Strings
  C_StrGoTo=      ' ->';
  C_Strequal=     'Equ';
  C_StrConcat=    'Mer';
  C_StrSum=       'Sum';
  C_StrSub=       'Sub';
  C_StrMult=      'Mul';
  C_StrDivi=      'Div';
  C_StrAver=      'Ave';
  C_StrCAge=      'Age';



procedure ImportWizard(ADoc: TContainer);
var
  FileMLSWizard: TFileMLSWizard;
begin
  FileMLSWizard  := TFileMLSWizard.Create(ADoc);
  try
    FileMLSWizard.ShowModal;
  Finally
    FileMLSWizard.Free;
  end;
end;

constructor TFileMLSWizard.Create(AOwner: TComponent);
begin
  inherited;

  AdjustDPISettings;

  Doc := Main.ActiveContainer;
  DocCompTable := TCompMgr2.Create(True);
  DocCompTable.BuildGrid(Doc, gtSales);
  DocListingTable := TcompMgr2.Create(True);
  DocListingTable.BuildGrid(Doc,gtListing);
  // Set Variable
  //--------------------
  GridChange := False;
  G_CurrentRow := -1;
  //--------------------
  BBack.Visible := False;
  Notebook.PageIndex := 0;
  NoteOptions.PageIndex := 1;
  LoadSettings;
end;

destructor TFileMLSWizard.Destroy;
begin
  SaveSettings;
  if assigned(DocCompTable) then
    DocCompTable.Free;
  if assigned(DocListingTable) then
    DocListingTable.Free;
  inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////// Function and procedures /////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.AdjustDPISettings;
begin
  Constraints.MaxHeight := 0;
  Constraints.MaxWidth := 0;
  Constraints.MinHeight := 0;
  Constraints.MinWidth := 0;

  bSave.Left := BPreview.Left + BPreview.Width + 150;
  bSaveAs.Left := bSave.Left + bSave.Width;
  bBack.Left := bSaveAs.Left + bSaveAs.Width;
  bNext.Left := bBack.Left + bBack.Width;
  bCancel.Left := bNext.Left + bNext.Width;

  EditPath.Left := 15;
  EditPath.Width := NoteBook.width - (rzBSelect.Width + 50);
  rzBSelect.Left := EditPath.Left + EditPath.Width + 5;
end;

procedure TFileMLSWizard.HSpecCells(CompCol: TCompColumn;value: String;flag: Integer);
begin
  case flag of
    -1: //Street Photo
      begin
        if not FileExists(value) then
          begin
            ShowNotice(Format(errCantFindFile,[ExtractFileName(value)]));
            exit;
          end;
        compCol.Photo.Cell.SetText(value);
      end;
  end;
end;
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.PostValue(SubId,CompId : Integer; Value : String );
var
  i : integer;
begin
  if SubId <> 0 then
   begin
    for i := 0 To clfFldList.Count -1 do
      begin
       if  TClfFldObject(clfFldList.Objects[i]).sbjCellID = SubId then
        begin
         TClfFldObject(clfFldList.Objects[i]).Value := Value;
         TClfFldObject(clfFldList.Objects[i]).bHandled := True;
        end;
      end;
   end;
 if CompId <> 0 then
   begin
    for i := 0 To clfFldList.Count -1 do
      begin
       if  TClfFldObject(clfFldList.Objects[i]).cmpCellID = CompId then
        begin
         TClfFldObject(clfFldList.Objects[i]).Value := Value;
         TClfFldObject(clfFldList.Objects[i]).bHandled := True;
        end;
      end;
   end;
end;
{--------------------------------------------------------------------------------------}

function TFileMLSWizard.SetUADConvert(doc: TContainer; CompCol: TCompColumn; cell:TBaseCell; s: String):String;
var
  aUADObject: TUADObject;
  aMsg: String;
begin
  result := s;
  if length(s) = 0 then exit;
  if not assigned(doc) then exit;
  if not assigned(cell) then exit;
  aUADObject := TUADObject.Create(doc);
  try
    try
      //github 274: need to bring in the overwrite flag

      result := aUADObject.TranslateToUADFormat(CompCol, cell.FCellID, s, CheckOverwrite.checked);
    except on E:Exception do
      begin
        aMsg := Format('cellid = %d, value = %s  ==>%s',[cell.FCellID, s, e.message]);
        shownotice(aMsg);
      end;
    end;
  finally
    if assigned(aUADObject) then
      FreeAndNil(aUADObject);
  end;
end;

procedure TFileMLSWizard.TransferSubjectField(clfFldList: TStringList);
var
  fld: Integer;
  sbjClID, cmpClID, curClID: Integer;
  val: String;
  cell: TBaseCell;
  flag: Integer;
  compCol: TCompColumn;
  IsSubjCell, UADIsOK: Boolean;
  source : AnsiString;
  aStr: String;
begin
  CompCol := DocCompTable.Comp[0];
  for fld := 0 to clfFldList.Count - 1 do
    begin
      sbjClID := TClfFldObject(clfFldList.Objects[fld]).sbjCellID;
      cmpClID := TClfFldObject(clfFldList.Objects[fld]).cmpCellID;
      val := TClfFldObject(clfFldList.Objects[fld]).Value;
      flag := TClfFldObject(clfFldList.Objects[fld]).flag;
      if sbjClID > 0 then
        if flag < 0 then   //not text cell
          HSpecCells(CompCol,val,flag)
        else
          begin
            cell := TContainer(Doc).GetCellByID(sbjClID);
            curClID := sbjClID;
            IsSubjCell := True;
            if not assigned(cell) then
              if cmpClID > 0 then
                begin
                  cell := TContainer(Doc).GetCellByID(cmpClID);
                  curClID := cmpClID;
                  IsSubjCell := False;
                end;
            //Github #371: if EMPTY Porch do not set to None
            //if assigned(cell) then
            //  if (Cell.FCellID = 1018) and (length(val) = 0) then
            //        Cell.Text := 'None'; //github 371
              if cell = nil then continue;  //github #499: if the cell is nil move on to the next entry, do not try to set the text value
              if length(val) > 0 then        //we have something to import
                if  CheckOverwrite.Checked or not cell.HasData then
                  begin
                     //if calc fields remove any space from string - Jeferson -----
                    source := IntToStr(cmpClID);
                    if AnsiMatchStr(source, ['1043','1042','1041']) then // cell ids - no space
                      val := StringReplace(val, ' ', '', [rfReplaceAll]);
                    //-----------------------------------------------------------
                    UADIsOK := IsUADDataOK(Doc, CompCol, curClID, val, IsSubjCell);
                    //cell.SetText(HandleFldFlag(cell.GetText,val,flag));
                    //TContainer(Doc).SetCellTextByID(curClID,HandleTextFldFlag(cell.GetText,val,flag));
                    //  SetCellString(TContainer(Doc), cell.UID, StripBegEndQuotes(HandleTextFldFlag(cell.GetText,val,flag)));
                    //github 248: do UADConvert if the flag is on

//                    if cell = nil then continue;  //github #499: if the cell is nil move on to the next entry, do not try to set the text value

                    aStr := StripBegEndQuotes(HandleTextFldFlag(cell.GetText,val,flag));
                    SetCellString(TContainer(Doc), cell.UID, aStr);
                    if appPref_MLSImportAutoUADConvert then  //github 248
                      cell.Text := SetUADConvert(TContainer(Doc), CompCol, cell, aStr);
                    cell.HasValidationError := (not UADIsOK);
                    // 110711 JWyatt Process the math to calculate net/gross & price per square foot
                    cell.ProcessMath;
                    cell.Display; //refresh
                  end;
          end;
    end;
    //transfer address to photo pages
    if assigned(compCol.Photo.Cell) then
      compCol.FPhoto.AssignAddress;
end;
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.TransferComField(clfFldList: TStringList;cmp: CompID);
var
  cell: TBaseCell;
  compCol: TCompColumn;
  fld: Integer;
  cmpClID: Integer;
  val: String;
  existText: String;
  flag: Integer;
  UADIsOK: Boolean;
  clAddr: TBaseCell;
  source : AnsiString;
  aString, aStr: String;
begin
   if cmp.cType = comp then
    CompCol := DocCompTable.Comp[cmp.cNo]
  else
    if cmp.cType = listing then
      compCol := DocListingTable.Comp[cmp.cNo]
    else
      exit;
  for fld := 0 to  clfFldList.Count - 1 do
    begin
      cmpClID := TClfFldObject(clfFldList.Objects[fld]).cmpCellID;
      val := TClfFldObject(clfFldList.Objects[fld]).Value;
      flag := TClfFldObject(clfFldList.Objects[fld]).flag;
      if cmpClID > 0 then
        if flag < 0 then   //not text cell
          HSpecCells(CompCol,val,flag)
        else
          begin
            existText := CompCol.GetCellTextByID(cmpClID);
            if length(val) > 0 then        //we have something to import
              if CheckOverwrite.Checked or (length(existText) = 0) then
                begin
                  //if calc fields remove any space from string - Jeferson -----
                    source := IntToStr(cmpClID);
                    if AnsiMatchStr(source, ['1043','1042','1041']) then // cell ids - no space
                      val := StringReplace(val, ' ', '', [rfReplaceAll]);
                  //-----------------------------------------------------------
                  UADIsOK := IsUADDataOK(Doc, CompCol, cmpClID, val);
                  //CompCol.SetCellTextByID(cmpClID,HandleTextFldFlag(existText,val,flag));
                  cell := CompCol.GetCellByID(cmpClID);
                  if Assigned(cell) then
                    begin
                      //github 248: do UADConvert if the flag is on
                      aStr := StripBegEndQuotes(HandleTextFldFlag(existText,val,flag));
                      SetCellString(TContainer(Doc), cell.UID, aStr);
                      if appPref_MLSImportAutoUADConvert then //github 248
                        begin
                          cell.Text := SetUADConvert(TContainer(Doc), CompCol, cell, aStr);
                        end;
                      cell.HasValidationError := (not UADIsOK);
                      // 110711 JWyatt Process the math to calculate net/gross & price per square foot
                      cell.ProcessMath;
                      cell.Display;
                    end;
                end;
            end;
      end;
  //Sometime comp Price field is at the end of the import list.
  //So we have to repeat the adjustment calculations to secure % adjustment
  //if cmp.cType = comp then
    //AdjustThisComparable(Doc,cmp.cNo);
  cell := compCol.GetCellByID(947); //sale price; invoke adjustment
  if assigned(cell) then
    cell.ProcessMath;

  // This is a final address check to see if a unit number is required and if it has
  //  been set through the import. Generally, MLS import does not include the unit
  //  so we want to flag the address field (orange) to alert the appraiser.
  if Doc.UADEnabled then
    begin
      clAddr := CompCol.GetCellByID(925);
      if (GetUADUnitCell(Doc) <> nil) and
         (Pos('2141=', clAddr.GSEData) = 0) then
        begin
          clAddr := CompCol.GetCellByID(926);
          clAddr.HasValidationError := True;
        end;
    end;

  if assigned(compCol.Photo.Cell) then  //transfer address to photo pages
    compCol.FPhoto.AssignAddress;
end;
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.Removemapping(Row : Integer);
var

 ObjIds  : TIds;

  function HasField(FieldName : String) :Boolean;
   var i : integer;
   begin
    result := True;
    for i := 0 To ListBox.Count -1 do
     begin
      if  FieldName = ListBox.Items.Strings[i] then
       begin
        result := False;
        exit;
       end;
     end;
   end;

begin
  if tsGrid1.Cell[C_ColDest,Row] <> '' then
   begin
   if  HasField(tsGrid1.Cell[C_ColDest,Row]) then
    begin
     ObjIds := TIds.Create;
     ObjIds.compId := tsGrid1.Cell[C_ColCompIds,Row];
     ObjIds.subjId := tsGrid1.Cell[C_ColSubjeIds,Row];
     ListBox.Items.AddObject(tsGrid1.Cell[C_ColDest,Row],ObjIds);
    end;
   GridChange := True;
   tsGrid1.Cell[C_ColGoTo,Row]:=     '';
   tsGrid1.Cell[C_ColDest,Row]:=     '';
   tsGrid1.Cell[C_ColDIndex,Row]:=   '';
   //tsGrid1.Cell[C_ColSel,Row]:=    '';
   tsGrid1.Cell[C_ColCompIds,Row]:=  '';
   tsGrid1.Cell[C_ColSubjeIds,Row]:= '';
   StampOpField(tsGrid1.Cell[C_colOper,Row],False);
   ItalicStamps;
   UpdatetsGrid;
  end;
end;
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.ClearOperation(Row : Integer);
begin
   StampOpField(tsGrid1.Cell[C_colOper,Row],False);
   tsGrid1.Cell[C_colOper,Row]:=   '';
   tsGrid1.Cell[C_colMath,Row]:=   '';
   tsGrid1.Cell[C_colResult,Row]:= '';
   if tsGrid1.Cell[C_ColDest,Row] <> '' then
     begin
      Removemapping(Row);
     end;
    ColorCurrentLine(Row);
   UpdatetsGrid;
end;
{--------------------------------------------------------------------------------------}
procedure TFileMLSWizard.UnselectRows;
var
 row : integer;
begin
 For row := 0 To  tsGrid1.Rows - 1 do
  begin
    if tsGrid1.RowSelected[row+1] then
     begin
       tsGrid1.RowSelected[row+1] := false;
     end;
  end;
end;
{--------------------------------------------------------------------------------------}
function TFileMLSWizard.GetSelectedRow : TStringList;
var
 irows : integer;
begin
  result := TStringList.Create;
  For irows := 0 To tsGrid1.rows - 1 do
   begin
    if tsGrid1.RowSelected[irows+1] then
      begin
        result.Add(inttostr(irows+1));
      end;
   end;
end;
{--------------------------------------------------------------------------------------}
function TFileMLSWizard.BuildOperation(FuncType : integer; Row : Integer):  String;
var
 tmp : TStringList;
begin
 tmp :=  GetSelectedRow;
 try
   try
     if tmp.Count > 0  then
     begin
      if FuncType = C_OConcat then
       begin
        Result := SelectOrderDialog(tmp,C_OConcat);
       end
      else
        Result := tmp.DelimitedText;
     end;
  except
   result := C_ErrMsg;
  end;
 finally
  FreeAndNil(tmp);
 end;
end;
{--------------------------------------------------------------------------------------}
function TFileMLSWizard.FuncEqual(Row : Integer ) : String;
begin
    result := tsGrid1.Cell[C_ColText1,Row]+tsGrid1.Cell[C_ColData,Row]+tsGrid1.Cell[C_Coltext2,Row];
end;
{--------------------------------------------------------------------------------------}
function TFileMLSWizard.FuncConcat(OpFilelds, FieldName : String ): String; //github 248: pass in FieldName
var
 Quant,Param1,Param2 : integer;
 strField,value      : string;
begin
 try
  Param1 := GetNumChar('(',OpFilelds)+1;
  Param2 := GetNumChar(')',OpFilelds)-Param1;
  OpFilelds := Copy(OpFilelds,Param1,Param2);
  value := '';
  Quant := length(OpFilelds);
  while Quant <> 0 do
   begin
     OpFilelds := Trim(OpFilelds);
     if OpFilelds <> '' then
        Quant := GetField2(OpFilelds,',')
     else
        Quant := 0;

     if Quant > 0 then
        strField := Copy(OpFilelds, 1, quant - 1)
     else
        strField := OpFilelds;

     strField := Trim(strField);
     if strField <> '' then
      begin
         if strField[1] = '"' then
           begin
            Delete(strField, 1, 1);
            if strField <> '' then
              if strField[Length(strField)] = '"' then
                Delete(strField, Length(strField), 1)
              else
                begin
                 result := C_ErrMsg;
                 exit;
                end;

             value := value + strfield;
           end
         else
           begin
             value := ConcatStrings([
               value,
                 tsGrid1.Cell[C_ColText1,strtoint(strField)] +
                 tsGrid1.Cell[C_ColData,strtoint(strField)] +
                 tsGrid1.Cell[C_ColText2,strtoint(strField)]], FieldName); //github 248: pass in FieldName
           end;
      end;
     result := value;
     if Quant > 0 then
       begin
         Delete(OpFilelds, 1, Quant);
       end;
   end;
 except
  result := C_ErrMsg;
 end;
end;
{--------------------------------------------------------------------------------------}
function TFileMLSWizard.FuncMath(OpFilelds : String ; FuncType : Integer ) : String;
var
 Quant,Param1,Param2   : Integer;
 NExp,Param3,i         : Integer;
 strField,Text1,Text2  : String;
 Expression,Ex,Dig     : String;
 value                 : Double;
 QuantField            : Integer;

 function CalcExpress(Value : Double ; Dig : String; Ex : String) : Double;
   begin
     Result := 0;
     if Ex = '+' then
        result:= value + strtofloat(dig);
     if Ex = '-' then
        result := abs(value-strtoint(dig));
     if Ex = '*' then
        result := value * strtoint(dig);
     if Ex = '/' then
        result := value / strtoint(dig);
   end;

begin
  NExp        := length(OpFilelds);
  Expression  := OpFilelds;
  Param1      := GetNumChar('(',OpFilelds)+1;
  Param2      := GetNumChar(')',OpFilelds)-Param1;
  Param3      := GetNumChar(')',OpFilelds);
  OpFilelds   := Copy(OpFilelds,Param1,Param2);
  value       := 0;
  QuantField  := 0;
  Quant       := length(OpFilelds);
  while Quant <> 0 do
   begin
    OpFilelds := Trim(OpFilelds);
     if OpFilelds <> '' then
        Quant := GetField2(OpFilelds,',')
     else
        Quant := 0;

     if Quant > 0 then
        strField := Copy(OpFilelds, 1, quant - 1)
     else
        strField := OpFilelds;
     if strField <> '' then
      begin
         if strField[1] = '"' then
           begin
            Delete(strField, 1, 1);
            if strField <> '' then
              if strField[Length(strField)] = '"' then
                Delete(strField, Length(strField), 1)
              else
                begin
                 result := C_ErrMsg;
                 exit;
                end;
             //Text := Text +strfield;
             Text1 :=  tsGrid1.Cell[C_ColText1,strtoint(strField)];
             Text2 :=  tsGrid1.Cell[C_ColText2,strtoint(strField)];
             Dec(QuantField);
           end
         else
           begin
            case FuncType of
             C_Osum :
                begin
                 if tsGrid1.Cell[C_ColData,strtoint(strField)] <> '' then
                  value := value + tsGrid1.Cell[C_ColData,strtoint(strField)]
                 else
                  value := value + 0;
                 Text1 :=  tsGrid1.Cell[C_ColText1,strtoint(strField)];
                 Text2 :=  tsGrid1.Cell[C_ColText2,strtoint(strField)];
                end;
             C_OSub :
                begin
                 if tsGrid1.Cell[C_ColData,strtoint(strField)] <> '' then
                  value := Abs(tsGrid1.Cell[C_ColData,strtoint(strField)]- value)
                 else
                  value := Abs(0- value);
                 Text1 :=  tsGrid1.Cell[C_ColText1,strtoint(strField)];
                 Text2 :=  tsGrid1.Cell[C_ColText2,strtoint(strField)];
                end;
             C_OAver :
                begin
                 if tsGrid1.Cell[C_ColData,strtoint(strField)] <> '' then
                  value := value + tsGrid1.Cell[C_ColData,strtoint(strField)]
                 else
                  value := value + 0;
                 Text1 :=  tsGrid1.Cell[C_ColText1,strtoint(strField)];
                 Text2 :=  tsGrid1.Cell[C_ColText2,strtoint(strField)];
                end;
             C_OMult :
               begin
                 if value = 0 then
                  begin
                   if tsGrid1.Cell[C_ColData,strtoint(strField)] <> '' then
                    value := tsGrid1.Cell[C_ColData,strtoint(strField)]
                   else
                    value := 0;
                  end
                 else
                  value := value * tsGrid1.Cell[C_ColData,strtoint(strField)];
                 Text1 :=  tsGrid1.Cell[C_ColText1,strtoint(strField)];
                 Text2 :=  tsGrid1.Cell[C_ColText2,strtoint(strField)];
               end;
            end;
           end;
      end;
     inc(QuantField);
     if Quant > 0 then
       begin
         Delete(OpFilelds, 1, Quant);
       end;
   end;
   Expression := Copy(Expression,Param3+1,NExp);
   if Expression <> '' then
    if Expression[1] <> '' then
     begin
       NExp := length(Expression);
       For  i := 1 to NExp do
        begin
         if Expression[i] in ['+','-','/','*','%'] then
           begin
            Ex := Expression[i];
           end;
         if Expression[i] in ['0'..'9','.'] then
          begin
            dig := dig + Expression[i];
          end;
        end;
     end;
   case FuncType of
     C_Osum :
        begin
         if Ex <> '' then
          begin
            value := CalcExpress(value,dig,Ex);
            result := Text1+FloatToStr(value)+Text2;
           end
          else
           result := Text1+FloatToStr(value)+Text2;
        end;
     C_OSub :
        begin
          if Ex <> '' then
           begin
             value := CalcExpress(value,dig,Ex);
             result := Text1+FloatToStr(value)+Text2;
           end
          else
           result := Text1+FloatToStr(value)+Text2;
        end;
     C_OAver :
        begin
         if Ex <> '' then
           begin
             value := CalcExpress(value,dig,Ex);
             result := Text1+FloatToStr(value)+Text2;
           end
          else
           result := Text1+FloatToStr(value/QuantField)+Text2;
        end;
     C_OMult :
        begin
         if Ex <> '' then
           begin
             value := CalcExpress(value,dig,Ex);
             result := Text1+FloatToStr(value)+Text2;
           end
          else
           result := Text1+FloatToStr(value)+Text2;
        end;
   end;
end;
{--------------------------------------------------------------------------------------}
Function TFileMLSWizard.FuncDateAge(Data : String) : String;
var
Quant,Param1,Param2 : integer;
size : Integer;
value,strField : string;
Date1,Date2 : TDateTime;
D1,D2,M1,M2,A1,A2 : Word;
myDate : TDateTime;
myYear, myMonth, myDay : Word;
begin
  try
   Param1 := GetNumChar('(',Data)+1;
   Param2 := GetNumChar(')',Data)-Param1;
   Data := Copy(Data,Param1,Param2);
   Quant := length(Data);
   while Quant <> 0 do
   begin
     Data := Trim(Data);
     if Data <> '' then
        Quant := GetField2(Data,',')
     else
        Quant := 0;

     if Quant > 0 then
        strField := Copy(Data, 1, quant - 1)
     else
        strField := Data;

     strField := Trim(strField);
     if strField <> '' then
      begin
         if strField[1] = '"' then
           begin
            Delete(strField, 1, 1);
            if strField <> '' then
              if strField[Length(strField)] = '"' then
                Delete(strField, Length(strField), 1)
              else
                begin
                 result := C_ErrMsg;
                 exit;
                end;
             result  := result + strfield;
           end
         else
           begin
             value := tsGrid1.Cell[C_ColData,strtoint( strField)];
             size := length(value);
             case size of
              4 :
               begin
                value := tsGrid1.Cell[C_ColData,strtoint(strField)];
                myDate := Date;
                DecodeDate(myDate,myYear,myMonth,myDay);
                result := tsGrid1.Cell[C_ColText1,strtoint( strField)]+
                          InttoStr((myYear-strtoint(value)))+
                          tsGrid1.Cell[C_ColText2,strtoint( strField)];
               end
              else
               begin
                strtodate(tsGrid1.Cell[C_ColData,strtoint( strField)]);
                Date1 := strtodate(tsGrid1.Cell[C_ColData,strtoint( strField)]);
                Date2 := Date;
                DecodeDate(Date1,A1,M1,D1);
                DecodeDate(Date2,A2,M2,D2);
                result := tsGrid1.Cell[C_ColText1,strtoint( strField)]+
                          IntToStr(A2-A1)+
                          tsGrid1.Cell[C_ColText2,strtoint( strField)];
               end;
             end;
           end;
      end;
     if Quant > 0 then
       begin
         Delete(Data, 1, Quant);
       end;
    end;
  except
    result := C_ErrMsg;
    abort;
  end;
end;
{--------------------------------------------------------------------------------------}
////////////////////////////////////////////////////////////////////////////////////////
procedure TFileMLSWizard.StampOpField( Fld : String; Stamp : Boolean );
var
  OpFields : String;
  Param1,Param2,PosComma : Integer;
begin
 if Stamp = true then
  begin
   OpFields := Fld;
   Param1   := GetNumChar('(',OpFields)+1;
   Param2   := GetNumChar(')',OpFields)-Param1;
   OpFields := Copy(OpFields,Param1,Param2);
   repeat
     PosComma := Pos(',',OpFields);
     if PosComma > 0 then
       fld  := Copy(OpFields,1,PosComma-1)
      else
       Fld := OpFields;

      Fld := Trim(Fld);
      if Fld <> '' then
        tsGrid1.Cell[C_ColSel,StrToInt(Fld)] := 'X';
      if PosComma > 0 then
        begin
         Delete(OpFields,1,PosComma);
        end;
   Until PosComma = 0;
  end;

 if Stamp = False then
  begin
   OpFields := Fld;
   Param1   := GetNumChar('(',OpFields)+1;
   Param2   := GetNumChar(')',OpFields)-Param1;
   OpFields := Copy(OpFields,Param1,Param2);
   repeat
     PosComma := Pos(',',OpFields);
     if PosComma > 0 then
       fld  := Copy(OpFields,1,PosComma-1)
     else
       Fld := OpFields;

     Fld := Trim(Fld);
     if Fld <> '' then
      tsGrid1.Cell[C_ColSel,StrToInt(Fld)] := '';
     if PosComma > 0 then
       begin
         Delete(OpFields,1,PosComma);
        end;
   Until PosComma = 0;
  end;
ItalicStamps;
end;

Function TFileMLSWizard.SelectOrderDialog(FldList : TStringList; TypOper : Integer) : String;
var
 DialogOrder : TFileMLSWizardSelOrder;
 i : Integer;
begin
 Result := '';
 DialogOrder := TFileMLSWizardSelOrder.Create(self);
 try
   for i := 0 to FldList.Count -1 do
     begin
      DialogOrder.ListBox1.Items.Add(FldList.Strings[i]);
      DialogOrder.ListBox2.Items.Add(tsGrid1.Cell[C_ColName,StrToInt(FldList.Strings[i])]);
      DialogOrder.ListBox3.Items.Add(tsGrid1.Cell[C_ColText1,StrToInt(FldList.Strings[i])]+''+
                                     tsGrid1.Cell[C_ColData,StrToInt(FldList.Strings[i])]+''+
                                     tsGrid1.Cell[C_ColText2,StrToInt(FldList.Strings[i])] );
     end;
 if tsGrid1.Cell[C_ColOper,G_CurrentRow] <> '' then
    DialogOrder.HasPreviewOp := True
 else
    DialogOrder.HasPreviewOp := False;
 case TypOper of
  C_Oequal  : DialogOrder.GroupBox.Caption := 'Equal - MLS Field Name';
  C_OConcat : DialogOrder.GroupBox.Caption := 'Merge - MLS Field Name';
  C_Osum    : DialogOrder.GroupBox.Caption := 'Sum - MLS Field Name';
  C_OSub    : DialogOrder.GroupBox.Caption := 'Subtract - MLS Field Name';
  C_OMult   : DialogOrder.GroupBox.Caption := 'Multiplication - MLS Field Name';
  C_OAver   : DialogOrder.GroupBox.Caption := 'Average - MLS Field Name';
 end;
 DialogOrder.ShowModal;
 finally
  if DialogOrder.OkCancel = True then
     Result := DialogOrder.ListBox1.Items.DelimitedText
  else
     Result := DialogOrder.SaveOriginalSeq;
  FreeAndNil(DialogOrder);
 end;
end;

Procedure TFileMLSWizard.ButtonControl( PageIndex : Integer; Preview : Integer );
begin
  case PageIndex of
   0 : begin
        BPreview.Visible:=   False;
        BSave.Visible:=      False;
        BSaveAs.Visible:=    False;
        BBack.Visible:=      False;
        BNext.Enabled:=      True;
        BNext.Caption:=      'Next';
        BCancel.Visible:=    True;
       end;
   1 : begin
        BPreview.Visible:=   False;
        BSave.Visible:=      False;
        BSaveAs.Visible:=    False;
        BBack.Visible:=      True;
        BNext.Visible:=      True;
        BNext.Caption:=      'Next';
        BCancel.Visible:=    True;
       end;
   2 : begin
        BackPrev.Visible:=   False;
        BPreview.Visible:=   True;
        BSave.Visible:=      True;
        if GridChange = False then
          BSave.Enabled:=    False
         else
          BSave.Enabled:=    True;
        BSaveAs.Visible:=    True;
        BBack.Visible:=      True;
        BNext.Visible:=      True;
        BNext.Enabled:=      True;
        BCancel.Visible:=    True;
        BNext.Caption:=      'Next';
       end;
   3 : begin
       if Preview = 0 then
        begin
         BackPrev.Visible:=  False;
         BPreview.Visible:=  False;
         BSave.Visible:=     False;
         BSaveAs.Visible:=   False;
         BBack.Visible:=     True;
         BNext.Visible:=     True;
         BCancel.Visible:=   True;
         BNext.Caption:=     'Import';
        end;
       if Preview = 1 then
        begin
         BackPrev.Visible:=   True;
         BPreview.Visible:=   False;
         BSave.Visible:=      False;
         BSaveAs.Visible:=    False;
         BBack.Visible:=      False;
         BNext.Visible:=      False;
         BCancel.Visible:=    False;
        end;
       end;
   end;
end;

function TFileMLSWizard.ConfigUserMapPath(const fName: String): String;
begin
  result := IncludeTrailingPathDelimiter(appPref_DirMyClickFORMS) +
            dirUserImportMaps + '\' + fName + '.txt';
end;

procedure TFileMLSWizard.LoadUserMaps;
var
  folder: String;
  List: TStrings;
  i : Integer;
begin
  CombMapping.Text := GetNameOnly(appPref_DefaultWizardImportMLSMapFile);

  if not fileexists(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+appPref_DefaultWizardImportMLSMapFile) then
   begin
    appPref_DefaultWizardImportMLSMapFile := '';
    CombMapping.Text := '';
   end;
    //now find other map options
    if FindLocalSubFolder(appPref_DirMyClickFORMS, dirUserImportMaps, folder, True) then
     begin
       List := GetFilesInFolder(folder, 'txt', True);
       try
        CombMapping.Items.Assign(List);
         if (length(CombMapping.Text)=0) and (List.count > 0) then
           CombMapping.ItemIndex := 0
         else
          begin
            for i:=0 to List.Count - 1 do
             begin
              if appPref_DefaultWizardImportMLSMapFile = List.Text then
               CombMapping.ItemIndex := i;
             end;
          end;
       finally
         List.free;
       end;
     end;

  if length(combMapping.Text)>0 then
   ImportMap_Path := ConfigUserMapPath(combMapping.Text);
end;

procedure TFileMLSWizard.SaveMapping(Path : String);
var
 i,size : integer;
 Mapp : String;
 FileMapp  : TextFile;
 fileStream: TFileStream;

 Function CreateMappFile(const fileName: String; var stream: TFileStream): Boolean;
  begin
   try
    stream := TFileStream.Create(fileName, fmCreate);
	  result := true;
	 except
	 	showNotice('Could not create the file: '+ filename);
	 	result := false;
	 end;
	end;

begin
  Mapp :=  '';
  if CreateMappFile(Path,fileStream) then
   begin
     try
      size := length(Mapp);
      fileStream.WriteBuffer(Pointer(Mapp)^, size);
     finally
      fileStream.free;
     end;
   end;

   For i := 0 To tsGrid1.Rows do
    begin
     if (tsGrid1.Cell[C_ColDest,i]<> '') or (tsGrid1.Cell[C_ColSel,i]<>'') then
      begin
       AssignFile(Filemapp,Path);
       Append(FileMapp);
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColNo,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColName,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColOper,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColDest,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColMath,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColCompIds,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColSubjeIds,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColText1,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColText2,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColSel,i],MLSEncryptKey),';');
       Write(FileMapp,EncryptString(tsGrid1.Cell[C_ColGoTo,i],MLSEncryptKey),';');
       //No Encrypt Debug Only.
       {Write(FileMapp,tsGrid1.Cell[C_ColNo,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColName,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColOper,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColDest,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColMath,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColCompIds,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColSubjeIds,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColText1,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColText2,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColSel,i],';');
       Write(FileMapp,tsGrid1.Cell[C_ColGoTo,i],';');}
       writeln(FileMapp);
       CloseFile(FileMapp);
      end;
    end;
 appPref_DefaultWizardImportMLSMapFile := EditMappName2.Text+'.Txt';
 LoadUserMaps;
 GridChange    := False;
 BSave.Enabled := False;
end;

procedure TFileMLSWizard.RemoveFieldHasbeenMap( Id : Integer);
var
 i : integer;
begin
   for i := 0 To ListBox.Count -1 do
    begin
     if Id = TIds(ListBox.Items.Objects[i]).subjId then
      begin
       ListBox.Items.Delete(i);
       break;
      end;
     if Id = TIds(ListBox.Items.Objects[i]).compId then
      begin
       ListBox.Items.Delete(i);
       Break;
      end;
    end;
end;

function TFileMLSWizard.OpenMapping(MappPath : string):Boolean;
var
 i,PosComma,Row,Col : integer;
 MappFile : TStringList;
 MField,SField : String;
begin
 try
  MappFile := TStringList.Create;
  MappFile.LoadFromFile(MappPath);

  // Clean rows before load map
  for i := 0 To tsGrid1.Rows -1 do
   begin
     ClearOperation(i);
   end;


  for i := 0 To MappFile.Count -1 do
   begin
     MField := MappFile[i];
     Col := 0;
     PosComma := Pos(';',MField);
     row := StrToInt(DecryptString(Copy(MField,1,PosComma-1),MLSEncryptKey));
     repeat
       PosComma := Pos(';',MField);
       if PosComma > 0 then
        sField := DecryptString(Copy(MField,1,PosComma-1),MLSEncryptKey)
       else
        sField := DecryptString(MField,MLSEncryptKey);

        case Col of
         0 : begin
              ColorLineMappinng(Row);
             end;
         1 : begin
           if tsGrid1.Cell[C_ColName,Row] <> SField then
              begin
               result := False;
               exit;
              end;
             end;
         2 : begin
              tsGrid1.Cell[C_ColOper,Row]:= SField;
             end;
         3:  begin
              tsGrid1.Cell[C_ColDest,Row]:= SField;
             end;
         4:  begin
              tsGrid1.Cell[C_ColMath,Row]:= SField;
             end;
         5:  begin
              tsGrid1.Cell[C_ColCompIds,Row] := SField;
              if (sField <> '0') and (SField <> '') then
               RemoveFieldHasbeenMap(StrToInt(SField));
             end;
         6:  begin
              tsGrid1.Cell[C_ColSubjeIds,Row] := SField;
              if (SField <> '0') and (SField <> '') then
               RemoveFieldHasbeenMap(StrToInt(SField));
             end;
         7:  begin
              tsGrid1.Cell[C_ColText1,Row]:= SField;
             end;
         8:  begin
              tsGrid1.Cell[C_ColText2,Row]:= SField;
             end;
         9:  begin
              tsGrid1.Cell[C_ColSel,Row]:= SField;
             end;
         10: begin
              tsGrid1.Cell[C_ColGoTo,Row]:= SField;
             end;
        end;
       if PosComma > 0 then
         begin
          Delete(MField,1,PosComma);
          Col := Col + 1;
         end;
     Until PosComma = 0;
   end;
 ItalicStamps;
 except
  Result := false;
  exit;
 end;
 result := True;
end;

procedure TFileMLSWizard.StepsNavagitor( StepIndex : Integer; Preview : Integer );
var
 line,i,rw,row,col,SelFld : integer;
 RowMapping : Integer;
 curComp: CompID;
 PosComma : Integer;
 CellId,ColIds: String;
 AddrFld,Address, aState: String;
 rsp : Integer;
 UADObject: TUADObject;
begin

   case StepIndex of
    0:
     begin
       /////////////////////////////////////////////////////////////
       // build Columns and tsGrid of MLS to be Mapping or Edit  ///
       /////////////////////////////////////////////////////////////
       Try
        /////////////////
        //Get MLS Data //
        /////////////////
        Application.ProcessMessages;
        DataFile := TStringList.Create;
        DataFile := DataFileToStrList(EditPath.Text,delimiter,TextQualifier); ////call Yakov code to load StringList.
        // Parse the fisrt Line (Headers)to Know How many Columns
        tsGrid1.Rows  := ParseRecord(DataFile[0],0,delimiter,TextQualifier).Count;
        TotalRec.Caption    := inttostr(DataFile.Count-1);
        // Create a Column Grid and load fields lines into the Object.
        for line := 0 To DataFile.Count -1 do
         begin
           G_strField:=  DataFile[line];
           G_ColumnId:=  G_ColumnId + 1;         // Parse every line to extract fields
           setlength(GridColumn,G_ColumnId);
           GridColumn[G_ColumnId-1]:=            TGridColumnList.Create;
           Gridcolumn[G_ColumnId-1].DataField:=  ParseRecord(G_strField,line,delimiter,TextQualifier);
         end;
        //////////////////////////////////////////
        // Build the tsGrid and Data Records   ///
        //////////////////////////////////////////
        for line := 0 to tsGrid1.Rows-1 do
         begin
          try
           tsGrid1.Cell[C_ColNo,line+1]:=    inttostr(line+1);
           tsGrid1.Cell[C_ColName,line+1]:=  GridColumn[0].DataField[line];
           tsGrid1.Cell[C_ColData,line+1]:=  GridColumn[1].DataField[line];
          except
          end;
         end;
        // Set ClickForms Fields.
        SetMap;
        // Set pre-defind map.
        LoadUserMaps;
        LabMLSPathName.Caption := EditPath.Text;
        ButtonControl(1,0);
        G_CurrentRow := 1;
        SelectRow(2,1);
        Notebook.PageIndex  := 1;
       Finally
        FreeAndNil(DataFile);
       end;
     end;

    1:
     begin
     //////////////////////////////////////////////////////////////
     // Open MLS File and Mappind File and see if is Compatible  //
     //////////////////////////////////////////////////////////////
      if (length(ImportMap_Path) > 0) then
       begin
        if not OpenMapping(ImportMap_Path) then
         begin
          ShowNotice('The Data File and the selected Data Source type or Custom Mapping File do not match. Please verify that they do.');
          BNext.Enabled := false;
          exit;
         end;
         UpdatetsGrid;
         ButtonControl(2,0);
         EditMappName2.Text  := CombMapping.Text;
         if CheckBoxEditMap.Checked then
          Notebook.PageIndex  := 2
         else
          StepsNavagitor(2,0);
       end;
     end;

    2:
     begin
     ///////////////////////////////////////////////////////////
     // Build the TsGridRecords the last Step of MLS Import   //
     ///////////////////////////////////////////////////////////

     //////////////////////////////////////////////
     // Get a quant of FieldNames is mapping  /////
     //////////////////////////////////////////////
     RowMapping :=0;                             //
     for i:= 0 to tsGrid1.Rows do                //
      begin                                      //
       if tsGrid1.Cell[C_ColDest,i] <> '' then     //
         begin                                   //
           RowMapping := RowMapping+1;           //
         end;                                    //
      end;                                       //
      if RowMapping = 0 then                     //
       begin                                     //
        ShowNotice('There is no field mapped.'); //
        ButtonControl(2,0);                      //
        exit;                                    //
       end;                                      //
     //////////////////////////////////////////////
     Application.ProcessMessages;
     // Check if Map needs be save
     if (GridChange = True) and (Preview <> 1) then
      begin
       rsp := WantToSave('Save changes to '+ EditMappName2.Text +' before import?');
        if rsp = 6 then
          SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+EditMappName2.Text+'.txt');
        if rsp = 2 then
          exit;
      end;

     if Preview = 0 then
       begin
        if (DocCompTable.Count + DocListingTable.Count) > 0 then
          begin
            tsGridRecords.Col[1].Width := 80;
            ButtonControl(3,0);
            CheckOverwrite.Visible := True;
           ///////////////////////////////////////////////////
           // Read and add how many Comps and List we have  //
           ///////////////////////////////////////////////////
           with tsGridRecords.Col[1].Combo.ComboGrid do     //
            begin                                           //
              Cols := 1;                                    //
              Rows := 2;                                    //
              if DocCompTable.Count > 0  then              //
                Rows := Rows + (DocCompTable.Count - 1);   //
              if DocListingTable.Count > 0 then            //
                Rows := Rows + (DocListingTable.Count - 1);//
              Cell[1,1] := strNone;                         //
              Cell[1,2] := strSubject;                      //
              for i := 1 to (DocCompTable.Count - 1) do    //
              begin                                         //
                rw := 2 + i;                                //
                Cell[1,rw] := strComp + IntToStr(i);        //
              end;                                          //
              for i := 1 to (DocListingTable.Count - 1) do //
              begin                                         //
                rw := 2 + (DocCompTable.Count - 1) + i;    //
                Cell[1,rw] := strListing  + IntToStr(i);    //
              end;                                          //
            end;                                            //
          end;                                              //
       end;                                                 //
       ///////////////////////////////////////////////////////
       //  if Preview Button hide stuff                   ////
       ///////////////////////////////////////////////////////
      if Preview = 1 then
        begin
          tsGridRecords.Col[1].Width := 0;
          ButtonControl(3,1);
          CheckOverwrite.Visible := False;
        end;

         /////////////////
         // Build Grid  //
         /////////////////
         tsGridRecords.Cols  := RowMapping+1;
         tsGridRecords.Rows  := High(GridColumn);
          /////////////////////////////////////////////////////
          //  Set columns and Headers                        //
          /////////////////////////////////////////////////////
          SelFld := 0;
          for i := 0 to tsGrid1.Rows do
            begin
            if tsGrid1.Cell[C_ColDest,i] <> '' then
             begin
               selfld := selfld + 1;
               if (selfld < RowMapping) or (selfld = RowMapping) then
                begin
                 tsGridRecords.Col[selfld + 1].ReadOnly  := True;
                 tsGridRecords.Col[selfld + 1].Heading   := tsGrid1.Cell[C_ColDest,i];
                 ColIds := tsGrid1.Cell[C_ColSubjeIds,i]+','+tsGrid1.Cell[C_ColCompIds,i];
                 tsGridRecords.Col[selfld + 1].FieldName :=  ColIds;
                 ////////////////////////////////////////////////////////////////
                 // Set each line of Header with Data value from Result Column //
                 ////////////////////////////////////////////////////////////////
                 indexGridColumn := -1;
                 for row := 0 to High(GridColumn) do
                  begin
                   Navigator(C_R);
                   tsGridRecords.Cell[selfld+1,row+1]:= tsGrid1.Cell[C_ColResult,i];
                  end;
                end;
             end;
             Application.ProcessMessages;
            end;
           ///////////////////////////////////////////////////////////////////////
           Notebook.PageIndex  := 3;
     end;
    3:
     begin
      //////////////////////////////////////////////////////
      // Import Selected MLS Records to ClickForm Report ///
      //////////////////////////////////////////////////////
      try
       for i := 1 to tsGridRecords.Rows do
        begin
           Address := '';
           curComp := GetCompNo(tsGridRecords.Cell[1,i]);

           if curComp.cType  = none then
              continue;
            /////////////////////
            // Import Subject ///
            /////////////////////
           if curComp.cType = subject then
             begin
                for col := 1 to tsGridRecords.Cols do
                 begin
                  CellId := tsGridRecords.Col[col].FieldName;
                  PosComma := Pos(',', CellId);
                  CellId   := Copy(CellId, 1, PosComma - 1);
                  if CellId <> '' then
                   begin
                    //github #439
                    if cellID = '48' then
                      begin
                        aState := tsGridRecords.Cell[col,i];
                        if length(aState) > 2 then
                          begin
                            UADObject := TUADObject.Create(TContainer(Doc));
                            try
                              aState := UADObject.translateState(aState);
                              PostValue(StrToInt(CellId),0,aState);
                            finally
                              UADObject.Free;
                            end;
                          end
                        else
                          PostValue(StrToInt(CellId),0,tsGridRecords.Cell[col,i]);
                      end
                    else
                      PostValue(StrToInt(CellId),0,tsGridRecords.Cell[col,i]);
                   end;
                 end;
               TransferSubjectField(clfFldList);  
             end;
            //////////////////
            // Import Comp ///
            //////////////////
           if curComp.cType = comp then
             begin
               for col := 1 to tsGridRecords.Cols do
                 begin
                  cellId   := tsGridRecords.Col[col].FieldName;
                  PosComma := Pos(',', CellId);
                  Addrfld := Copy(CellId, 1, PosComma - 1);

                  if (Addrfld = '47') then
                   begin
                    Address := tsGridRecords.Cell[col,i] + ', ' + ParseCityStateZip3(Address, cmdGetState) + ' ' + ParseCityStateZip3(Address, cmdGetZip);
                    PostValue(0,926,Address);
                   end
                  else if (Addrfld = '48') then
                   begin
                    Address := ParseCityStateZip3(Address, cmdGetCity) + ', ' + tsGridRecords.Cell[col,i] + ' ' + ParseCityStateZip3(Address, cmdGetZip);
                    PostValue(0,926,Address);
                   end
                  else if (Addrfld = '49') then
                   begin
                    Address := ParseCityStateZip3(Address, cmdGetCity) + ', ' + ParseCityStateZip3(Address, cmdGetState) + ' ' + tsGridRecords.Cell[col,i];
                    PostValue(0,926,Address);
                   end
                  else
                   begin
                    PosComma := Pos(',',CellId);
                    Delete(CellId,1,PosComma);
                    if CellId <> '' then
                     begin
                      PostValue(0,StrToInt(CellId),tsGridRecords.Cell[col,i]);
                     end;
                   end;
                 end;
                TransferComField(clfFldList,curComp);
             end;
            /////////////////////
            // Import Listing ///
            ////////////////////
           if curComp.cType = listing then
             begin
              for col := 1 to tsGridRecords.Cols do
                begin
                  cellId   := tsGridRecords.Col[col].FieldName;
                  PosComma := Pos(',', CellId);
                  Addrfld := Copy(CellId, 1, PosComma - 1);

                  if (Addrfld = '47') then
                   begin
                    Address := tsGridRecords.Cell[col,i] + ', ' + ParseCityStateZip3(Address, cmdGetState) + ' ' + ParseCityStateZip3(Address, cmdGetZip);
                    PostValue(0,926,Address);
                   end
                  else if (Addrfld = '48') then
                   begin
                    Address := ParseCityStateZip3(Address, cmdGetCity) + ', ' + tsGridRecords.Cell[col,i] + ' ' + ParseCityStateZip3(Address, cmdGetZip);
                    PostValue(0,926,Address);
                   end
                  else if (Addrfld = '49') then
                   begin
                    Address := ParseCityStateZip3(Address, cmdGetCity) + ', ' + ParseCityStateZip3(Address, cmdGetState) + ' ' + tsGridRecords.Cell[col,i];
                    PostValue(0,926,Address);
                   end
                  else
                   begin
                    PosComma := Pos(',',CellId);
                    Delete(CellId,1,PosComma);
                    if CellId <> '' then
                     begin
                      PostValue(0,StrToInt(CellId),tsGridRecords.Cell[col,i]);
                     end;
                   end;
                 end;
                TransferComField(clfFldList,curComp);
             end;

        end;
      finally
       for i := 0 to clfFldList.Count - 1 do
         clfFldList.Objects[i].Free;
       clfFldList.Free;
       Close;
      end;
     end;
   end;
end;

Procedure TFileMLSWizard.SelectRow(Column,Row : Integer);
var
 i : Integer;
begin
 for i := 0 to tsGrid1.Rows -1 do
  begin
   if tsGrid1.Cell[C_ColDest,i+1] = '' then
    begin
     tsGrid1.CellColor[C_ColNo,i+1]:=     clWhite;
     tsGrid1.CellColor[C_ColName,i+1]:=   clBtnFace;
     tsGrid1.CellColor[C_ColText1,i+1]:=  clWhite;
     tsGrid1.CellColor[C_ColData,i+1]:=   clBtnFace;
     tsGrid1.CellColor[C_ColText2,i+1]:=  clWhite;
     tsGrid1.CellColor[C_ColOper,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColResult,i+1]:= clBtnFace;
     tsGrid1.CellColor[C_ColGoTo,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColDest,i+1]:=   clBtnFace;
    end
   else
    begin
     tsGrid1.CellColor[C_ColNo,i+1]:=     clWhite;
     tsGrid1.CellColor[C_ColName,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColText1,i+1]:=  clWhite;
     tsGrid1.CellColor[C_ColData,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColText2,i+1]:=  clWhite;
     tsGrid1.CellColor[C_ColOper,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColResult,i+1]:= clWhite;
     tsGrid1.CellColor[C_ColGoTo,i+1]:=   clWhite;
     tsGrid1.CellColor[C_ColDest,i+1]:=   clWhite;
    end;
    ColorCurrentLine(Column);
  end;
end;

procedure TFileMLSWizard.ItalicStamps;
var
 row : integer;
begin
 for row := 0 to tsGrid1.Rows -1 do
  begin
   if tsGrid1.Cell[C_ColSel,Row+1] <> '' then
     begin
      tsGrid1.CellFont[C_ColName,row+1]:= FontDialog.Font;
     end
    else
     begin
      tsGrid1.CellFont[C_ColName,row+1]:= tsGrid1.Font;
     end;
  end;
end;

procedure TFileMLSWizard.ColorLineMappinng(Row : Integer);
begin
   tsGrid1.CellColor[C_ColNo,Row]:=     clWhite;
   tsGrid1.CellColor[C_ColName,Row]:=   clWhite;
   tsGrid1.CellColor[C_ColText1,Row]:=  clWhite;
   tsGrid1.CellColor[C_ColData,Row]:=   clWhite;
   tsGrid1.CellColor[C_ColText2,Row]:=  clWhite;
   tsGrid1.CellColor[C_ColOper,Row]:=   clWhite;
   tsGrid1.CellColor[C_ColResult,Row]:= clWhite;
   tsGrid1.CellColor[C_ColGoTo,Row]:=   clWhite;
   tsGrid1.CellColor[C_ColDest,Row]:=   clWhite;
   tsGrid1.SelectRows(Row,Row,false);
end;

procedure TFileMLSWizard.ColorCurrentLine(Column : Integer);
begin
  if Column = C_ColOper then
   begin
    tsGrid1.CellColor[C_ColNo,G_CurrentRow]:=     clHighlight;
    tsGrid1.CellColor[C_ColName,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText1,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColData,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText2,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColOper,G_CurrentRow]:=   clwhite;
    tsGrid1.CellColor[C_ColResult,G_CurrentRow]:= clHighlight;
    tsGrid1.CellColor[C_ColGoTo,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColDest,G_CurrentRow]:=   clHighlight;
   end
  else if Column = C_ColData then
   begin
    tsGrid1.CellColor[C_ColNo,G_CurrentRow]:=     clHighlight;
    tsGrid1.CellColor[C_ColName,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText1,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColData,G_CurrentRow]:=   clWhite;
    tsGrid1.CellColor[C_ColText2,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColOper,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColResult,G_CurrentRow]:= clHighlight;
    tsGrid1.CellColor[C_ColGoTo,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColDest,G_CurrentRow]:=   clHighlight;
   end
  else if Column = C_ColText1 then
   begin
    tsGrid1.CellColor[C_ColNo,G_CurrentRow]:=     clHighlight;
    tsGrid1.CellColor[C_ColName,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText1,G_CurrentRow]:=  clWhite;
    tsGrid1.CellColor[C_ColData,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText2,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColOper,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColResult,G_CurrentRow]:= clHighlight;
    tsGrid1.CellColor[C_ColGoTo,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColDest,G_CurrentRow]:=   clHighlight;
    end
  else if Column = C_ColText2 then
   begin
    tsGrid1.CellColor[C_ColNo,G_CurrentRow]:=     clHighlight;
    tsGrid1.CellColor[C_ColName,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText1,G_CurrentRow]:=  clHighlight;
    tsGrid1.CellColor[C_ColData,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText2,G_CurrentRow]:=  clWhite;
    tsGrid1.CellColor[C_ColOper,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColResult,G_CurrentRow]:= clHighlight;
    tsGrid1.CellColor[C_ColGoTo,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColDest,G_CurrentRow]:=   clHighlight;
   end
  else
   begin
    tsGrid1.CellColor[C_ColNo,G_CurrentRow]:=     clHighlight;
    tsGrid1.CellColor[C_ColName,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText1,G_CurrentRow]:=  clHighlight;;
    tsGrid1.CellColor[C_ColData,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColText2,G_CurrentRow]:=  clHighlight;;
    tsGrid1.CellColor[C_ColOper,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColResult,G_CurrentRow]:= clHighlight;
    tsGrid1.CellColor[C_ColGoTo,G_CurrentRow]:=   clHighlight;
    tsGrid1.CellColor[C_ColDest,G_CurrentRow]:=   clHighlight;
    tsGrid1.SelectRows(G_CurrentRow,G_CurrentRow,True);
   end;
end;

procedure TFileMLSWizard.AddClickFormField;
var
 Sub,Com : String;
begin
if G_CurrentRow <> -1 then
 begin
 if (tsGrid1.Cell[C_ColDest,G_CurrentRow]= '') and (ListBox.ItemIndex <> -1) then
  begin
   GridChange := True;
   tsGrid1.Cell[C_ColDest,G_CurrentRow]:=   ListBox.Items.Strings[ListBox.ItemIndex];
   tsGrid1.Cell[C_ColDIndex,G_CurrentRow]:= ListBox.ItemIndex;
   tsGrid1.Cell[C_colGoTo,G_CurrentRow]:=   C_StrGoTo;
   sub:= IntToStr(TIds(ListBox.Items.Objects[ListBox.ItemIndex]).subjId);
   Com:= IntToStr(TIds(ListBox.Items.Objects[ListBox.ItemIndex]).compId);
   tsGrid1.Cell[C_ColCompIds,G_CurrentRow]:=  Com;
   tsGrid1.Cell[C_ColSubjeIds,G_CurrentRow]:= Sub;
   ListBox.Items.Delete(ListBox.ItemIndex);
   if tsGrid1.Cell[C_ColOper,G_CurrentRow] = '' then
    CmdOperation(C_Oequal);
   ColorLineMappinng(G_CurrentRow);
   StampOpField(tsGrid1.Cell[C_colOper,G_CurrentRow],True);
   ItalicStamps;
   UpdatetsGrid;
  end;
 end;
end;

procedure TFileMLSWizard.SetMap;
var
 clfFldFile,NewName: String;
 i,id : Integer;
 Seq : String;
 ObjIds          : TIds;                     // Hold Comp and Sub Ids from Grid.
begin
 clfFldFile := GetClickFormsMapFile;
 if not FileExists(clfFldFile) then
    begin
      ShowNotice('Can not find ' + ExtractFileName(clfFldFile));
      exit;
    end;
  clfFldList := TStringList.Create;
  clfFldList.Sorted := True;

  if not GetClfFldRecords(clfFldFile,clfFldList) then
    begin
      ShowNotice('There is an error in ' + ExtractFileName(clfFldFile));
      exit;
    end;

  G_FieldQuant := 0;

  for i := 0 to clfFldList.Count - 1 do
   begin
     id := 0;
     if TClfFldObject(clfFldList.Objects[i]).cmpCellID <> 0 then
      Id := TClfFldObject(clfFldList.Objects[i]).cmpCellID;
     if TClfFldObject(clfFldList.Objects[i]).sbjCellID <> 0 then
      Id := TClfFldObject(clfFldList.Objects[i]).sbjCellID ;

     if Id <> 0 then
      begin
       try
        NewName := '';
        Seq := '';
        if DoNotDisplayClFd(TClfFldObject(clfFldList.Objects[i]).sbjCellID) and
           DoNotDisplayClFd(TClfFldObject(clfFldList.Objects[i]).cmpCellID) then
           begin
            ObjIds := TIds.Create;
            ObjIds.subjId := TClfFldObject(clfFldList.Objects[i]).sbjCellID;
            ObjIds.compId := TClfFldObject(clfFldList.Objects[i]).cmpCellID;

             NewName := ChgNameToDisplay(TClfFldObject(clfFldList.Objects[i]).sbjCellID);
             if NewName = '' then
              NewName := ChgNameToDisplay(TClfFldObject(clfFldList.Objects[i]).cmpCellID);
             if Newname <> '' then
              begin
               TClfFldObject(clfFldList.Objects[i]).FieldName := NewName;
              end;

             Seq := CFtemplate(TClfFldObject(clfFldList.Objects[i]).sbjCellID);
             if Seq = '0' then
              Seq := CFtemplate(TClfFldObject(clfFldList.Objects[i]).cmpCellID);

             if Seq <> '0' then
              begin
               TClfFldObject(clfFldList.Objects[i]).FieldName := Seq+'-'+TClfFldObject(clfFldList.Objects[i]).FieldName;
               ListBox.Items.AddObject(TClfFldObject(clfFldList.Objects[i]).FieldName,ObjIds);
              end;
           end;
       except
        ShowNotice('There is an error in generate map.');
       end;
      end;
   end;
end;

Procedure TFileMLSWizard.CellEdit(Column,Row : Integer; CellValue : String);
begin
   GridColumn[indexGridColumn+1].DataField[Row-1] := cellValue;
   UpdatetsGrid;
end;

procedure TFileMLSWizard.Navigator(direction : string);
var
 line : integer;
begin
 // Move Right
 if direction = C_R then
  begin
   if(indexGridColumn < G_columnId-2) then
    begin
     indexGridColumn := indexGridColumn + 1;
     NumRec.Caption := inttostr(indexGridColumn+1);
    end;
  end;
 // Move Left
 if direction = C_L then
  begin
  if (indexGridColumn > 0) then
   begin
    indexGridColumn := indexGridColumn - 1;
    NumRec.Caption := inttostr(indexGridColumn+1);
   end;
  end;
 // Move Data
 if (direction = C_R) or (direction = C_L) then
  begin
    with tsGrid1 do
     begin
      for line := 0 to Rows-1 do
       begin
         try
          Cell[C_ColData,line+1] := GridColumn[indexGridColumn+1].DataField[line];
         except
         end;
       end;
        UpdatetsGrid;
     end;
  end;
end;

procedure TFileMLSWizard.UpdatetsGrid;
var
 iRows : integer;
 Output: String;
begin
   For iRows := 0 to tsGrid1.rows do
   try
    if tsGrid1.Cell[C_ColOper,iRows] <> '' then
     begin
       case tsGrid1.Cell[C_ColMath,iRows] of
        C_Oequal  : Output := FuncEqual(iRows);
        C_OConcat : Output := FuncConcat(tsGrid1.Cell[C_ColOper,iRows],tsGrid1.cell[C_ColName, iRows]);
        C_Osum    : Output := FuncMath(tsGrid1.Cell[C_ColOper,iRows],strtoint(tsGrid1.Cell[C_ColMath,iRows]));
        C_OAver   : Output := FuncMath(tsGrid1.Cell[C_ColOper,iRows],strtoint(tsGrid1.Cell[C_ColMath,iRows]));
        C_OSub    : Output := FuncMath(tsGrid1.Cell[C_ColOper,iRows],strtoint(tsGrid1.Cell[C_ColMath,iRows]));
        C_OMult   : Output := FuncMath(tsGrid1.Cell[C_ColOper,iRows],strtoint(tsGrid1.Cell[C_ColMath,iRows]));
        C_ODivi   : Output := FuncMath(tsGrid1.Cell[C_ColOper,iRows],strtoint(tsGrid1.Cell[C_ColMath,iRows]));
        C_OCAge   : Output := FuncDateAge(tsGrid1.Cell[C_ColOper,iRows]);
        else
          Output := tsGrid1.Cell[C_ColResult,iRows];
       end;

       // per jeff, strip out extra spaces at the bottleneck.
       // this means there is no allowable case for (intentional) extra spaces.
       // all spacing errors have been fixed, so this code is unnecessary.
       Output := Trim(Output);
       ClearRepeatingSpaces(Output);
       //github 248: PAM: the cellid 231 and 1043 is the combination of full and half bath
       //when we concatenate bath and bath partial to bath (231 or 1043), we have a space in between
       //To make it work, we need to replace the space in between the 2 fields with a '.'
       //so this will show x.x on the grid and same as importing to the cell 231 and 1043
       if pos('BATH', UpperCase(tsGrid1.cell[C_ColName, iRows])) > 0 then
         begin
           if pos('.', output) = 0 then  //if already has a . don't replace
             Output := StringReplace(Output, ' ', '.', [rfReplaceAll]);   //change space with %
         end;
       tsGrid1.Cell[C_ColResult,iRows] := Output;
     end;
    if GridChange = True then
     BSave.Enabled := True;
 except
  tsGrid1.Cell[C_ColResult,iRows]:= C_ErrMsg;
 end;
end;

procedure TFileMLSWizard.UpdateGridSG1;
var
 irows,Column  : integer;
begin
 Try
  Try
   Application.ProcessMessages;
   DataFile  := TStringList.Create;
   if Delimiters.ItemIndex = 0 then delimiter := chr(9); //Tab
   if Delimiters.ItemIndex = 1 then delimiter := ';';    //Semi-Comma
   if Delimiters.ItemIndex = 2 then delimiter := ',';    //Comma
   if Delimiters.ItemIndex = 3 then delimiter := ' ';    //Space
   if Delimiters.ItemIndex = 4 then delimiter := '|';    //Pipe
   if Delimiters.ItemIndex = 5 then delimiter := EditOther.Text;//Others
   TextQualifier := Trim(ComboQualifier.Text);
   DataFile:= DataFileToStrList(EditPath.Text,delimiter,TextQualifier); //call Yakov code to load StringList.
   SG1.RowCount     := DataFile.Count;
   SG1.ColCount     := GetColunQuant(DataFile[0],delimiter)+2;
   LRecords.Caption := inttostr(DataFile.Count-1);
   for irows := 0 to DataFile.Count -1 do
     begin
      try
       G_strField:=  DataFile[irows];
       FieldList:= TStringList.Create;
       FieldList:= ParseRecord(G_strField,irows,delimiter,TextQualifier);
       for column := 0  to FieldList.Count -1 do
        begin
         SG1.Cells[Column,irows]:= FieldList[Column];
        end
       finally
         FreeAndNil(FieldList);
       end;
     end;
  except
     on E: Exception do
      begin
        ShowAlert(atWarnAlert, errProblem + E.message);
        EditPath.Clear;
      end;
  end;
 Finally
   FreeAndNil(DataFile);
 end;
end;

procedure TFileMLSWizard.RzBSelectClick(Sender: TObject);
var
 OpenFile : TOpenDialog;
begin
 OpenFile            := TOpenDialog.Create(self);
 OpenFile.Title      := 'Select the Data File to Import';
 OpenFile.InitialDir := VerifyInitialDir(appPref_DirImportDataFiles, '');
 If OpenFile.Execute then
  begin
   appPref_DirImportDataFiles := ExtractFileDir(OpenFile.FileName);
   EditPath.Text := OpenFile.FileName;
  end;
end;

procedure TFileMLSWizard.EditPathChange(Sender: TObject);
begin
if (fileexists(EditPath.Text)) then
 begin
   UpdateGridSG1;
 end;
end;

procedure TFileMLSWizard.Delimiters_tmpClick(Sender: TObject);
begin
 if (fileexists(EditPath.Text))then
 begin
   UpdateGridSG1;
 end;
end;

procedure TFileMLSWizard.BNext_tmpClick(Sender: TObject);
begin
 if (fileexists(EditPath.Text)) then
  begin
   if (Notebook.PageIndex = 0) then
    begin
     StepsNavagitor(0,0);  //Step0-Select MLS
     exit;
    end;
   if (Notebook.PageIndex = 1) then
    begin
     StepsNavagitor(1,0);  //Step1-Select MLS MAP
     exit;
    end;
   if (Notebook.PageIndex = 2) then
    begin
     StepsNavagitor(2,0);  //Step2-Mapping MLS
     exit;
    end;
   if (Notebook.PageIndex = 3) then
    begin
     StepsNavagitor(3,0);  //Step3-Import MLS
     exit;
    end;
  end;
end;

procedure TFileMLSWizard.SpeedButton1Click(Sender: TObject);
begin
Navigator(C_R);
end;

procedure TFileMLSWizard.SpeedButton2Click(Sender: TObject);
begin
Navigator(C_L);
end;

procedure TFileMLSWizard.tsGrid1CellEdit(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
 if DataCol = C_ColData then
    cellEdit(DataCol,DataRow,tsGrid1.cell[DataCol,DataRow]);
 if (DataCol = C_Coltext1) or (DataCol = C_Coltext2) then
   begin
    SelectRow(DataCol,DataRow);
    tsGrid1.Cell[C_ColResult,DataRow]   := tsGrid1.Cell[C_ColText1,DataRow]+
                                         +tsGrid1.Cell[C_ColData,DataRow]+
                                         +tsGrid1.Cell[C_ColText2,DataRow];
   end;
 UpdatetsGrid;
end;

procedure TFileMLSWizard.tsGrid1ClickCell(Sender: TObject; DataColDown,
  DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
 if DataRowDown > 0 then
  begin
   G_CurrentRow := DataRowDown;
   SelectRow(DataColDown,DataRowDown);
  end;
end;

procedure TFileMLSWizard.CmdOperation(Tag : Integer);
var
 RowSel : String;
begin
  // not select set.
   if not tsGrid1.RowSelected[G_CurrentRow] Then
     tsGrid1.SelectRows(G_CurrentRow,G_CurrentRow,True);

  Case Tag of
    C_OEqual :
        begin
         try
          RowSel := BuildOperation(C_Oequal,G_CurrentRow);
          if RowSel <> '' then
           begin
            tsGrid1.Cell[C_colOper,G_CurrentRow] := C_Strequal+'('+RowSel+')';
            tsGrid1.Cell[C_colMath,G_CurrentRow] := C_Oequal;
            StampOpField(RowSel,True);
           end;
         finally
          UnSelectRows;
          UpdatetsGrid;
         end;
        end;
    C_OConcat :
        begin
         try
          RowSel := BuildOperation(C_OConcat,G_CurrentRow);
          if RowSel <> '' then
           begin
            tsGrid1.Cell[C_colOper,G_CurrentRow] := C_strConcat+'('+RowSel+')';
            tsGrid1.Cell[C_colMath,G_CurrentRow] := C_OConcat;
            StampOpField(RowSel,True);
           end;
         finally
          UnSelectRows;
          UpdatetsGrid;
         end;
        end;
    C_Osum :
        begin
         try
          RowSel := BuildOperation(C_Osum,G_CurrentRow);
          if RowSel <> '' then
           begin
            tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrSum+'('+RowSel+')';
            tsGrid1.Cell[C_colMath,G_CurrentRow] := C_Osum;
            StampOpField(RowSel,True);
           end;
         finally
          UnSelectRows;
          UpdatetsGrid;
         end;
        end;
    C_OSub :
        begin
         try
           RowSel := BuildOperation(C_OSub,G_CurrentRow);
           if RowSel <> '' then
            begin
             tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrSub+'('+RowSel+')';
             tsGrid1.Cell[C_colMath,G_CurrentRow] := C_OSub;
             StampOpField(RowSel,True);
            end;
          finally
           UnSelectRows;
           UpdatetsGrid;
          end;
        end;
    C_OMult :
        begin
          try
           RowSel := BuildOperation(C_OMult,G_CurrentRow);
           if RowSel <> '' then
            begin
             tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrMult+'('+RowSel+')';
             tsGrid1.Cell[C_colMath,G_CurrentRow] := C_OMult;
             StampOpField(RowSel,True);
            end;
          finally
           UnSelectRows;
           UpdatetsGrid;
          end;
        end;
    C_ODivi :
        begin
          try
           RowSel := BuildOperation(C_ODivi,G_CurrentRow);
           if RowSel <> '' then
            begin
             tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrDivi+'('+RowSel+')';
             tsGrid1.Cell[C_colMath,G_CurrentRow] := C_ODivi;
             StampOpField(RowSel,True);
            end;
          finally
           UnSelectRows;
           UpdatetsGrid;
          end;
        end;
    C_OAver :
        begin
          try
           RowSel := BuildOperation(C_OAver,G_CurrentRow);
           if RowSel <> '' then
            begin
             tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrAver+'('+RowSel+')';
             tsGrid1.Cell[C_colMath,G_CurrentRow] := C_OAver;
             StampOpField(RowSel,True);
            end;
          finally
           UnSelectRows;
           UpdatetsGrid;
          end;
        end;
    C_OCAge :
       begin
         try
           RowSel := BuildOperation(C_OAver,G_CurrentRow);
           if RowSel <> '' then
            begin
             tsGrid1.Cell[C_colOper,G_CurrentRow] := C_StrCAge+'('+RowSel+' '+')';
             tsGrid1.Cell[C_colMath,G_CurrentRow] := C_OCAge;
             StampOpField(RowSel,True);
            end;
          finally
           UnSelectRows;
           UpdatetsGrid;
          end;
       end;
   end;
end;

procedure TFileMLSWizard.ClearExecute(Sender: TObject);
begin
ClearOperation(G_CurrentRow);
end;

procedure TFileMLSWizard.OperationExecExecute(Sender: TObject);
begin
  CmdOperation((Sender as TMenuItem).Tag);
end;

procedure TFileMLSWizard.tsGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
 CellDest : TGridCoord;
begin
 try
  CellDest := tsGrid1.MouseCoord(X,Y);
  if (CellDest.X > 0) and (CellDest.Y > 0)then
   begin
    if ListBox.ItemIndex = -1 then
     begin
      exit
     end
    else
     begin
      if tsGrid1.Cell[C_ColDest,CellDest.Y] = '' then
       begin
        G_CurrentRow := CellDest.Y;
        AddClickFormField;
        if (G_CurrentRow+1 < tsGrid1.Rows) or (G_CurrentRow+1 = tsGrid1.Rows)then
         begin
          G_CurrentRow := G_CurrentRow+1;
          SelectRow(2,G_CurrentRow);
         end;
       end
      else
       ShowNotice('This MLS Field Name alredy has a destination ClikFORMS Cell.');
     end;
   end;
  except
    ShowNotice('Problem to Drag Over to the Row.');
  end;
end;

procedure TFileMLSWizard.ListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 Accept := (Source is TListBox);
end;

procedure TFileMLSWizard.SpeedArrowClick(Sender: TObject);
begin
 if ListBox.ItemIndex <> -1 then
  begin
   AddClickFormField;
   if (G_CurrentRow+1 < tsGrid1.Rows) or (G_CurrentRow+1 = tsGrid1.Rows)then
    begin
     G_CurrentRow := G_CurrentRow+1;
     SelectRow(2,G_CurrentRow);
    end;
  end;
end;

procedure TFileMLSWizard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  G_ColumnId := 0;
  CheckServiceAvailable(stMLS);
end;

procedure TFileMLSWizard.BCancel_tmpClick(Sender: TObject);
begin
 close;
end;

procedure TFileMLSWizard.BBack_tmpClick(Sender: TObject);
var
 i : integer;
begin
 case Notebook.PageIndex of
   3 : begin
        ButtonControl(2,0);
        Notebook.PageIndex := 2;
       end;
   2 : begin
        ButtonControl(1,0);
        Notebook.PageIndex := 1;
       end;
   1 : begin
        indexGridColumn := 0;
        G_ColumnID := 0;
        FreeAndNil(DataFile);
        for i := 0 to high(GridColumn) do
         begin
          FreeAndNil(GridColumn[i]);
         end;
        ListBox.Clear;
        ButtonControl(0,0);
        Notebook.PageIndex := 0;
       end;
  end;
end;

procedure TFileMLSWizard.ListBoxDblClick(Sender: TObject);
begin
 AddClickFormField;
 if (G_CurrentRow+1 < tsGrid1.Rows) or (G_CurrentRow+1 = tsGrid1.Rows)then
  begin
   G_CurrentRow := G_CurrentRow+1;
   SelectRow(2,G_CurrentRow);
 end;
end;

procedure TFileMLSWizard.SpeedButton3Click(Sender: TObject);
begin
 Removemapping(G_CurrentRow);
end;

procedure TFileMLSWizard.tsGrid1CellChanged(Sender: TObject; OldCol,
  NewCol, OldRow, NewRow: Integer);
begin
  SelectRow(NewCol,NewRow);
end;

procedure TFileMLSWizard.CombMappingChange(Sender: TObject);
begin
 ImportMap_Path := ConfigUserMapPath(CombMapping.Text);
 appPref_DefaultWizardImportMLSMapFile := combMapping.Text+'.Txt';
 if CombMapping.Text <> '' then
  BNext.Enabled := True
 else
  BNext.Enabled := False;
end;

procedure TFileMLSWizard.RzBitBtn2Click(Sender: TObject);
var
 ClickedOK: Boolean;
 rsp : Integer;

 function Hasmapename(Name : String) : Boolean;
  var i : integer;
  begin
   Result := False;
   for i := 0 to CombMapping.Items.Count -1 do
    begin
     if UpperCase(MappName) = UpperCase(CombMapping.Items.Strings[i]) then
      Result := True;
    end;
  end;

begin
  MappName := 'untitled';
  ClickedOK := InputQuery('Enter your Data Map file name. ', 'Map Name', MappName);
  if ClickedOK then
    begin
     if MappName = '' then exit;
     if Hasmapename(Mappname)then
      begin
       rsp:=  YesNoCancel('You already have this map name. Do you want overwrite?');
        if rsp = 6 then
         begin
          UpdatetsGrid;
          ButtonControl(2,0);
          Notebook.PageIndex  := 2;
          EditMappName2.Text  := MappName;
          exit;
         end;
        if (rsp = 7) or (rsp = 2) then
         begin
          exit;
         end;
      end
     else
      begin
       UpdatetsGrid;
       ButtonControl(2,0);
       Notebook.PageIndex  := 2;
       EditMappName2.Text  := MappName;
      end;
    end;
end;

procedure TFileMLSWizard.BPreview_tmpClick(Sender: TObject);
begin
  StepsNavagitor(2,1);
end;

procedure TFileMLSWizard.BSave_tmpClick(Sender: TObject);
begin
 SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+EditMappName2.Text+'.txt');
 ShowNotice('Saved Mapping Sucessfully');
end;

procedure TFileMLSWizard.tsGrid1Enter(Sender: TObject);
begin
 GridChange := True;
end;

procedure TFileMLSWizard.BSaveAs_tmpClick(Sender: TObject);
var

 ClickedOK: Boolean;
 NameAs   : String;
 rsp : Integer;

 function Hasmapename(Name : String) : Boolean;
  var i : integer;
  begin
   Result := False;
   for i := 0 to CombMapping.Items.Count -1 do
    begin
     if UpperCase(Name) = UpperCase(CombMapping.Items.Strings[i]) then
      Result := True;
    end;
  end;

begin
 ClickedOK := InputQuery('Enter your Data Map file name. ', 'Map Name', NameAs);
 if ClickedOK then
  begin
   if NameAs = '' then
    begin
     ShowAlert(3,'Map name can not be Blank');
     exit;
    end;
   if Hasmapename(NameAs)then
    begin
     rsp:=  YesNoCancel('You already have this map name. Do you want overwrite?');
     if rsp = 6 then
      begin
       MappName := NameAs;
       EditMappName2.Text := MappName;
       SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+NameAs+'.txt');
       ShowNotice('Saved Mapping Sucessfully');
      end;
     if (rsp = 7) or (rsp = 2) then
      begin
       exit;
      end;
    end
   else
    begin
     MappName := NameAs;
     EditMappName2.Text := MappName;
     SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+NameAs+'.txt');
     ShowNotice('Saved Mapping Sucessfully');
    end;
  end;
end;

procedure TFileMLSWizard.tsGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 GridMousePosX := X;
 GridMousePosY := Y;
end;

procedure TFileMLSWizard.tsGrid1DblClick(Sender: TObject);
var
 Operation : String;
 Tmp : TStringList;

 Procedure ExtractOp( Formula : String );
  var
   OpFields,Fld : String;
   Param1,Param2,PosComma : Integer;
  begin
    tmp := TStringList.Create;
    OpFields := Formula;
    Param1   := GetNumChar('(',OpFields)+1;
    Param2   := GetNumChar(')',OpFields)-Param1;
    OpFields := Copy(OpFields,Param1,Param2);
    repeat
     PosComma := Pos(',',OpFields);
     if PosComma > 0 then
      fld  := Copy(OpFields,1,PosComma-1)
     else
      Fld := OpFields;
     tmp.Add(Fld);
     if PosComma > 0 then
      begin
       Delete(OpFields,1,PosComma);
      end;
    Until PosComma = 0;
   end;

begin
 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_Oequal) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_Oequal);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_Strequal+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
  end;

 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_OConcat) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_OConcat);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_StrConcat+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
    end;
 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_Osum) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_Osum);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_StrSum+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
    end;
 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_OSub) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_OSub);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_StrSub+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
    end;
 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_OMult) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_OMult);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_StrMult+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
    end;
 if (tsGrid1.Cell[C_ColMath,G_CurrentRow] <> '') and
    (tsGrid1.Cell[C_ColMath,G_CurrentRow] = C_OAver) then
    begin
     try
      Operation := tsGrid1.Cell[C_Coloper,G_CurrentRow];
      ExtractOp(Operation);
      Operation := SelectOrderDialog(tmp,C_OAver);
      if Operation <> '' then
       tsGrid1.Cell[C_ColOper,G_CurrentRow]:= C_StrAver+'('+Operation+')';
     finally
       FreeAndNil(Tmp);
     end;
    end;
  UpdatetsGrid;
end;

procedure TFileMLSWizard.tsGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept := (Source is TListBox);
end;

procedure TFileMLSWizard.ListBox12DblClick(Sender: TObject);
begin
AddClickFormField;
end;

procedure TFileMLSWizard.ListBox12DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
Accept := (Source is TListBox);
end;

procedure TFileMLSWizard.tsGrid1RowChanged(Sender: TObject; OldRow,
  NewRow: Integer);
var
 Column : TGridCoord;
begin
 G_CurrentRow := NewRow;
 Column := tsGrid1.MouseCoord(GridMousePosX,GridMousePosY);
 SelectRow(Column.X,NewRow);
end;

procedure TFileMLSWizard.BPreviewClick(Sender: TObject);
begin
 StepsNavagitor(2,1);
end;

procedure TFileMLSWizard.BSaveClick(Sender: TObject);
begin
 SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+EditMappName2.Text+'.txt');
 ShowNotice('Saved Mapping Sucessfully');
end;

procedure TFileMLSWizard.BSaveAsClick(Sender: TObject);
var

 ClickedOK: Boolean;
 NameAs   : String;
 rsp : Integer;

 function Hasmapename(Name : String) : Boolean;
  var i : integer;
  begin
   Result := False;
   for i := 0 to CombMapping.Items.Count -1 do
    begin
     if UpperCase(Name) = UpperCase(CombMapping.Items.Strings[i]) then
      Result := True;
    end;
  end;

begin
 ClickedOK := InputQuery('Enter your Data Map file name. ', 'Map Name', NameAs);
 if ClickedOK then
  begin
   if NameAs = '' then
    begin
     ShowAlert(3,'Map name can not be Blank');
     exit;
    end;
   if Hasmapename(NameAs)then
    begin
     rsp:=  YesNoCancel('You already have this map name. Do you want overwrite?');
     if rsp = 6 then
      begin
       MappName := NameAs;
       EditMappName2.Text := MappName;
       SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+NameAs+'.txt');
       ShowNotice('Saved Mapping Sucessfully');
      end;
     if (rsp = 7) or (rsp = 2) then
      begin
       exit;
      end;
    end
   else
    begin
     MappName := NameAs;
     EditMappName2.Text := MappName;
     SaveMapping(appPref_DirMyClickFORMS+'\'+dirUserImportMaps+'\'+NameAs+'.txt');
     ShowNotice('Saved Mapping Sucessfully');
    end;
  end;
end;

procedure TFileMLSWizard.BBackClick(Sender: TObject);
var
 i : integer;
begin
 case Notebook.PageIndex of
   3 : begin
        ButtonControl(2,0);
        Notebook.PageIndex := 2;
       end;
   2 : begin
        ButtonControl(1,0);
        Notebook.PageIndex := 1;
       end;
   1 : begin
        indexGridColumn := 0;
        G_ColumnID := 0;
        FreeAndNil(DataFile);
        for i := 0 to high(GridColumn) do
         begin
          FreeAndNil(GridColumn[i]);
         end;
        ListBox.Clear;
        ButtonControl(0,0);
        Notebook.PageIndex := 0;
       end;
  end;

end;

procedure TFileMLSWizard.BNextClick(Sender: TObject);
begin
if (fileexists(EditPath.Text)) then
  begin
   if (Notebook.PageIndex = 0) then
    begin
     StepsNavagitor(0,0);  //Step0-Select MLS
     exit;
    end;
   if (Notebook.PageIndex = 1) then
    begin
     StepsNavagitor(1,0);  //Step1-Select MLS MAP
     exit;
    end;
   if (Notebook.PageIndex = 2) then
    begin
     StepsNavagitor(2,0);  //Step2-Mapping MLS
     exit;
    end;
   if (Notebook.PageIndex = 3) then
    begin
     StepsNavagitor(3,0);  //Step3-Import MLS
     exit;
    end;
  end;
end;

procedure TFileMLSWizard.BCancelClick(Sender: TObject);
begin
close;
end;

procedure TFileMLSWizard.tsGridRecordsComboDropDown(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
var
 i,rowsId,listId,dpId : Integer;
 DropList : TStringList;
 FldList  : TStringList;
 index : Integer;
 sGrid,usedfldList : String;
begin
 FldList := TStringList.Create;
 DropList := TStringList.Create;
 Try
  // Generate a list with all field avaliable.
  with tsGridRecords.Col[1].Combo.ComboGrid do
   begin
    Cols := 1;
    Rows := 2;
    if DocCompTable.Count > 0  then
       Rows := Rows + (DocCompTable.Count - 1);
    if DocListingTable.Count > 0 then
       Rows := Rows + (DocListingTable.Count - 1);
    FldList.Add(strNone);
    if (DocCompTable.Count > 0) then
      FldList.Add(strSubject);
    for i := 1 to (DocCompTable.Count - 1) do
     begin
      FldList.Add(strComp + IntToStr(i))
     end;
    for i := 1 to (DocListingTable.Count - 1) do
     begin
      FldList.Add(strListing  + IntToStr(i))
     end;
   end;
  //Get fields been Selected from the Grid
  for rowsId := 0 To tsGridRecords.Rows -1 do
   begin
    if tsGridRecords.Cell[1,rowsId] <> '' then
     begin
      sGrid  := tsGridRecords.Cell[1,rowsId];
      if sGrid <> strNone then
         DropList.Add(sGrid);
     end;
   end;
  // Remove Fields has been selected from the Grid
  //FldList.Sorted := True;
  for dpid := 0 To DropList.Count-1 do
   begin
     usedfldList := DropList[dpid];
     index:= FldList.IndexOf(usedfldlist);
     FldList.Delete(index);
   end;
  // Generate new List into a Grid Combo
  //FldList.Sorted := False;
  with tsGridRecords.Col[1].Combo.ComboGrid do
   begin
    Rows := FldList.Count;
    for listId:= 0 To FldList.Count-1 do
     begin
       Cell[1,listId+1] := FldList[listId];
     end;
   end;
 finally
  FldList.Free;
  DropList.Free;
 end;
end;

/// summary: Concatinates an array of strings.
/// remarks: The strings are trimmed of leading and trailing spaces prior to concatination.
///          A space is inserted between the two strings if neither string is empty.
function TFileMLSWizard.ConcatStrings(const S: array of String; Fieldname:String): String;
var
  Concatinated: String;
  Index: Integer;
  Trimmed: String;
  op:String;
begin
  //github 248: Default SPACE in between the two string when concatenating the two
  //BUT if this is either heating or cooling, we need to concat with "/"
  op := ' ';
  FieldName := UpperCase(Fieldname);
  if (pos('HEAT', Fieldname) > 0) or (pos('COOL', Fieldname) > 0) then
    op := '/';

  // start with the first string
  if (Length(S) > 0) then
    Concatinated := Trim(S[0])
  else
    Concatinated := '';

  // concatinate the remaining strings
  for Index := 1 to Length(S) - 1 do
    begin
      Trimmed := Trim(S[Index]);
      if (Length(Concatinated) > 0) and (Length(Trimmed) > 0) then
        Concatinated := Concatinated + op + Trimmed //replace SPACE with '/' when it's heating or cooling
      else
        Concatinated := Concatinated + Trimmed;
    end;

  Result := Concatinated;
end;

/// summary: Loads configuration settings for the form.
procedure TFileMLSWizard.LoadSettings;
begin
  if (Length(appPref_DefaultWizardImportDelimiter) = 1) then
    begin
      case appPref_DefaultWizardImportDelimiter[1] of
        #9: Delimiters.ItemIndex := 0; // tab
        ';': Delimiters.ItemIndex := 1;
        ',': Delimiters.ItemIndex := 2;
        ' ': Delimiters.ItemIndex := 3;
        '|': Delimiters.ItemIndex := 4;
      else
        Delimiters.ItemIndex := 5;
        EditOther.Text := appPref_DefaultWizardImportDelimiter;
      end;
    end
  else
    begin
      Delimiters.ItemIndex := 5;
      EditOther.Text := appPref_DefaultWizardImportDelimiter;
    end;
  //github 248
  chkUADConvert.Checked := appPref_MLSImportAutoUADConvert;
end;

/// summary: Saves configuration settings for the form.
procedure TFileMLSWizard.SaveSettings;
begin
  case Delimiters.ItemIndex of
    0: appPref_DefaultWizardImportDelimiter := #9;  // tab
    1: appPref_DefaultWizardImportDelimiter := ';';
    2: appPref_DefaultWizardImportDelimiter := ',';
    3: appPref_DefaultWizardImportDelimiter := ' ';
    4: appPref_DefaultWizardImportDelimiter := '|';
  else
    appPref_DefaultWizardImportDelimiter := EditOther.Text;
  end;
  //github 248
  appPref_MLSImportAutoUADConvert := chkUADConvert.Checked;
end;




procedure TFileMLSWizard.chkUADConvertClick(Sender: TObject);
begin
  //github 248
  appPref_MLSImportAutoUADConvert := chkUADConvert.Checked;
end;

procedure TFileMLSWizard.FormShow(Sender: TObject);
begin
  //PAM: Disable the UAD convert feature until we open for GOLD membership
 // chkUADConvert.Visible := False;    //hide it completely
 // chkUADConvert.Enabled := False;    //let user sees it but could not click
 // chkUADConvert.checked := False;
 // appPref_MLSImportAutoUADConvert := False;
end;

procedure TFileMLSWizard.writePref;
var
  PrefFile: TMemIniFile;
  IniFilePath, iniFileName: String;
  i, NumTools: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);  //create the INI writer
  Try
    with PrefFile do
    begin
      WriteBool('Import', 'MLSUADAutoConvert', appPref_MLSImportAutoUADConvert);
    end;
  finally
    PrefFile.UpdateFile;
    PrefFile.Free;
  end;
end;

procedure TFileMLSWizard.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
    writePref;
    CanClose := True;
  end;
end.
