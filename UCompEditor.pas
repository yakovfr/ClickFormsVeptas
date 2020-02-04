unit UCompEditor;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids_ts, TSGrid, ComCtrls, Contnrs, Menus,
  UGridMgr, UMxArrays, UForms, IniFiles;

type
  TCompEditor = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    CmbxComp: TComboBox;
    cmbxSort: TComboBox;
    Label1: TLabel;
    CompGrid: TtsGrid;
    btnRefresh: TButton;
    rdoMode: TRadioGroup;
    procedure btnOkClick(Sender: TObject);
    procedure CompGridColMoved(Sender: TObject; ToDisplayCol,
      Count: Integer; ByUser: Boolean);
    procedure cmbxSortChange(Sender: TObject);
    procedure CmbxCompChange(Sender: TObject);
    procedure CompGridComboInit(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure CompGridComboGetValue(Sender: TObject; Combo: TtsComboGrid;
      GridDataCol, GridDataRow, ComboDataRow: Integer; var Value: Variant);
    procedure btnCancelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure CompGridCellEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure rdoModeClick(Sender: TObject);
    procedure rdoModeEnter(Sender: TObject);
    procedure CompGridHeadingClick(Sender: TObject; DataCol: Integer);
    procedure CompGridPaintCell(Sender: TObject; DataCol, DataRow: Integer;
      ARect: TRect; State: TtsPaintCellState; var Cancel: Boolean);
  private
    FDoc: TComponent;
    FGrid: TCompMgr2; //TGridMgr;
    FGridKind: Integer;
    FNeedsSwapping: Boolean;
    FSortOption: Integer;
    FCompStore: Array of TCompData;
    FModified: Boolean;
    FirstTime: Boolean;
    FCurrentMode:Integer;
    FActionOn:Boolean;
    procedure ReloadGrid;
    procedure LoadPref;
    procedure WritePref;
    procedure DoSetView;
    function GetGrossAdjustment(c: Integer):Double;
    function SaveGridDataToForms_Extend:Boolean;
    function SaveGridDataToForms_Basic:Boolean;
    procedure SetCellForComp(c, aCellID: Integer; aCellValue:String);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckCompUniformity;
    procedure LoadGridToComps;
    procedure LoadGridToComps2;
    procedure AddCompColumn;
    procedure SwapComps(Cmp1, Cmp2: Integer);
    procedure StoreComp(AComp: Integer);
    function GetSortValue(Col, Row: Integer): Double;
    function GetSortValue2(Col, Row: Integer): Double;
    procedure SortColumnsBy(dataType: Integer; reverseSort: Boolean);
    procedure SortColumnsBy2(dataType: Integer; reverseSort: Boolean);
    procedure SetOriginalOrder;
    function GetUserCompSelection(option, DataCol: Integer; var includePhoto: Boolean): Integer;
    function GetCompSelection(DataCol: Integer): Integer;

    procedure DisplayClearAll(DataCol: Integer);
    procedure DisplayClearAdjs(DataCol: Integer);
    procedure DisplayCopySubj(DataCol: Integer);
    procedure DisplayCopyDesc(DataCol: Integer; var actionText: String);
    procedure DisplayCopyAll(DataCol: Integer; var actionText: String);

    procedure ResetActionFlag(AComp: Integer);
    procedure CompClearAll(AComp: Integer);
    procedure CompClearAdjs(AComp: Integer);
    procedure CompCopySubj(AComp: Integer);
    procedure CompCopyDesc(AComp: Integer);
    procedure CompCopyTextOnly(AComp: Integer);
    procedure CompCopyAll(AComp: Integer);
  end;

var
  CompEditor: TCompEditor;

implementation

{$R *.DFM}


uses
  Math,
  UGlobals, UContainer, UStatus, UUtil1, UCompEditorUtil, UMain, UUtil2,UWinUtils;

const
  cpOrigSortOrder   = 0;
  cpSortByAdjPrice  = 1;
  cpSortByNetAdj    = 2;
  cpSortByDate      = 3;
  cpSortByGLA       = 4;
  cpSortByProx      = 5;
//  cpSortByWtAvg     = 6;

  rowAddr1  = 3;
  rowAddr2  = 4;
  rowProx   = 5;
  rowPrice  = 6;
  rowDate   = 7;
  rowGLA    = 8;
  rowNet    = 9;
  rowAdj    = 10;

  MaxRows  = 10;

//  MaxRows2 = 35;
  MaxRows2 = 38;

  row2Addr1      = 3;
  row2Addr2      = 4;
  row2Prox       = 5;
  row2Price      = 6;
  row2DataSrc    = 7;
  row2VerSrc     = 8;
  row2ValueAdj   = 9;
  row2SaleFin    = 10;
  row2Concess    = 11;
  row2Date       = 12;
  row2Loc        = 13;
  row2Leasehold  = 14;
  row2Site       = 15;
  row2View       = 16;
  row2Design     = 17;
  row2Quaility   = 18;
  row2Age        = 19;
  row2Cond       = 20;
  row2Rooms      = 21;
  row2Bedrooms   = 22;
  row2Bathrooms  = 23;
  row2GLA        = 24;
  row2BsmtArea   = 25;
  row2BsmtRooms  = 26;
  row2FuncUtil   = 27;
  row2HeatCool   = 28;
  row2EngEff     = 29;
  row2Garage     = 30;
  row2Porch      = 31;
  row2Other1     = 32;
  row2Other2     = 33;
  row2Other3     = 34;
  row2Net        = 35;
  row2Adj        = 36;
  row2NetPercent = 37;
  row2GrsPercent = 38;
//  rowWt    = 11;

{ actions that will be performed on comps }
  actNone         = 1;    //'No Action';
  actClear        = 2;    //'Clear Everything';
  actAdjs         = 3;    //'Clear Adjustments Only';
  actCopySubDesc  = 4;    //'Copy Subject Desc';
  actCopyCmpDesc  = 5;    //'Copy Desc From Comp';
  actCopyCmpText  = 6;    //'Copy comp text only
  actCopyCmpAll   = 7;    // copy the comp text and photo

//Compeditor mode
  mtBasic        = 0;
  mtExtend       = 1;
  mtTextEditOnly = 2;

  combo_rowHeight = 15;
type
  TValueIndex = class(TObject)
    FValue: Double;
    FIndex: Integer;
    Constructor Create(AValue: Double; AIndex: Integer);
  end;

  Function CompareAscending(Item1, Item2: Pointer): Integer;
  var
    Val1, val2: Double;
  begin
    Val1 := TValueIndex(Item1).FValue;
    Val2 := TValueIndex(Item2).FValue;
    result := 0;    //default equal
    if Val1 < val2  then
      result := -1
    else if val1 > val2 then
      result := 1;
  end;

  Function CompareDesending(Item1, Item2: Pointer): Integer;
  var
    Val1, val2: Double;
  begin
    Val1 := TValueIndex(Item1).FValue;
    Val2 := TValueIndex(Item2).FValue;
    result := 0;    //default equal
    if Val1 > val2  then
      result := -1
    else if val1 < val2 then
      result := 1;
  end;

var
  RowLabel: array[1..MaxRows] of String = ('Action','Property Photo', 'Address', 'City', 'Proximity',
    'Sales Price', 'Sales Date', 'Gross Liv. Area', 'Net Adjustment','Adj. Sales Price');
  RowLabel2: array[1..MaxRows2] of String = ('Action','Property Photo','Address','City','Proximity',
    'Sales Price','Data Source(s)','Ver. Source(s)','VALUE ADJUSTMENTS','Sale or Financing','Concessions',
    'Sales Date','Location','Leasehold/Fee Simp.','Site','View','Design (Style)','Const. Quailty','Actual Age',
    'Condition','Total Rooms','Bedrooms','Bathrooms','Gross Liv. Area','Bsmt & Finished','Bsmt Rooms',
    'Func. Utility','Heating/Cooling','Energy Eff. Items','Garage/Carport','Porch/Patio/Deck',
    'Other Item1','Other Item2','Other Item3','Net Adjustment','Adj. Sales Price', 'Net Adj', 'Gross Adj');

{ TValueIndex }

Constructor TValueIndex.Create(AValue: Double; AIndex: Integer);
begin
  inherited Create;
  FValue := AValue;
  FIndex := AIndex;
end;



{ TCompEditor }

constructor TCompEditor.Create(AOwner: TComponent);
begin
//  inherited;
  inherited Create(AOwner);
  SettingsName := CFormSettings_CompEditor;
  FModified := False;   //set to false when first come in
  FirstTime := True;
  FActionOn := False;
  FCurrentMode := -1;
  CompGrid.Enabled := False;
//  FDoc := AOwner;               //AOwner = TContainer
  FDoc := Main.ActiveContainer;
  FGridKind := 1;               {gtSales = 1}
  FGrid := TCompMgr2.Create(True);
  FGrid.BuildGrid(FDoc, FGridKind);

  FNeedsSwapping := False;
  FSortOption := cpOrigSortOrder;

  CompGrid.Col[1].Color := $00EBC194; //$00B4C8B4;
  CompGrid.Col[1].HeadingColor := $00EBC194;  //$00B4C8B4;
  CompGrid.Col[2].Color := $00A0FEFA;
  CompGrid.Col[2].HeadingColor := $00A0FEFA;
  CompGrid.RowColor[1] := $00A0FEFA;
  LoadPref;
  DoSetView;
  ReloadGrid;
  FirstTime := False;
end;

destructor TCompEditor.Destroy;
var
  i: integer;
begin
  if assigned(FGrid) then
    FGrid.Free;

  for i := 0 to length(FCompStore)-1 do
    if Assigned(FCompStore[i]) then
      FCompStore[i].Free;
  FCompStore := nil;

  for i := 2 to CompGrid.Cols do              //subject is #2
    if CompGrid.CellData[i,2] <> nil then
      TBitmap(CompGrid.CellData[i,2]).Free;   //free the photo

  inherited;
end;

procedure TCompEditor.DoSetView;
var
  col,row:Integer;
begin
  case rdoMode.ItemIndex of
    mtBasic,mtExtend:
      begin
        for col := 2 to CompGrid.Cols do  //set readonly for basic user
          for row := 3 to CompGrid.Rows do
            CompGrid.CellReadOnly[Col,row] := roOn;
        cmbxSort.Enabled := True;
        CompGrid.RowHeight[1] := Combo_RowHeight;
        CompGrid.ColMoving := True;
        statusBar1.SimpleText := 'To Reorder Comps: Click on a comp and drag it to it''s new position.';
        btnRefresh.Caption := 'Refresh';
       end;
    mtTextEditOnly:
      begin
        for col := 2 to CompGrid.Cols do  //set readonly for basic user
          for row := 3 to CompGrid.Rows do
            CompGrid.cellReadOnly[col,row] := roOff;
        cmbxSort.Enabled := False;
        CompGrid.RowHeight[1] := 0;
        CompGrid.ColMoving := False;
        StatusBar1.SimpleText := '';
        btnRefresh.Caption := 'Undo';
      end;
  end;
end;

procedure TCompEditor.CheckCompUniformity;
begin
  //check if all the tables are the same
end;

procedure TCompEditor.AddCompColumn;
var
  N: Integer;
begin
  with CompGrid do
    begin
      Cols := Cols + 1;     //add a comp column
      N := Cols;
      Col[N].Heading := 'Comp '+IntToStr(N-2);  //0=titles; 1=subject
      case appPref_CompEditorMode of
        mtBasic,mtExtend:
          begin
            Col[N].ReadOnly    := True;
            CellReadOnly[N, 1] := roOff;
            CellButtonType[N, 1] := btCombo;
          end;
        mtTextEditOnly:
          begin
            Col[N].ReadOnly    := False;
//            CellReadOnly[N, 1] := roOff;
//            CellButtonType[N, 1] := btNone;
          end;
      end;
    end;
end;


procedure TCompEditor.CompGridComboInit(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
begin
  if (DataCol > 2) and (DataRow = 1) then
    begin
      //Set the number of rows displayed to 5 and the return value column to 1
      Combo.DropDownRows := 6;
      Combo.ValueCol := 1;

      //Set AutoSearch on so user input or drop down causes automatic positioning
      Combo.AutoSearch := asTop;

      //Set the number of columns displayed to 2
      Combo.DropDownCols := 1;
      Combo.Grid.Cols := 1;
      Combo.Grid.HeadingOn := False;
      Combo.Grid.RowBarOn := False;
      Combo.Grid.Rows := 6;

      //preset the values at start
      Combo.Grid.StoreData := True;
      Combo.Grid.Cell[1,1] := 'No Action';
      Combo.Grid.Cell[1,2] := 'Clear Everything';
      Combo.Grid.Cell[1,3] := 'Clear Adjustments Only';
      Combo.Grid.Cell[1,4] := 'Copy Subject desc.';
      Combo.Grid.Cell[1,5] := 'Copy desc from...';
      Combo.Grid.Cell[1,6] := 'Copy all from...';
    end;
end;

procedure TCompEditor.CompGridComboGetValue(Sender: TObject;
  Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
  var Value: Variant);
var
  actionText: String;
begin
  actionText := '';
  case ComboDataRow of
    actNone:        ResetActionFlag(GridDataCol);
    actClear:       DisplayClearAll(GridDataCol);
    actAdjs:        DisplayClearAdjs(GridDataCol);
    actCopySubDesc: DisplayCopySubj(GridDataCol);
    actCopyCmpDesc: DisplayCopyDesc(GridDataCol, actionText);
    actCopyCmpText: DisplayCopyAll(GridDataCol, actionText);
  end;
  if length(actionText)>0 then
    Value := actiontext;
end;

procedure TCompEditor.LoadGridToComps;
var
  c,i: Integer;
  bMap: TBitMap;
begin
  i := 2;
  CompGrid.ReadOnlyButton := True;   //make sure all buttons are visible
  for c := 0 to FGrid.Count-1 do
    begin
      if c > 3 then         //always have 3 comps,
        AddCompColumn;      //add more if needed
      bMap := FGrid.Comp[c].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
      CompGrid.cell[c+i,2] := BitmapToVariant(bMap);
      CompGrid.CellData[c+i,2] := bMap;

      CompGrid.Cell[c+i,rowAddr1] := FGrid.Comp[c].GetCellTextByID(925);  //Address1
      CompGrid.Cell[c+i,rowAddr2] := FGrid.Comp[c].GetCellTextByID(926);  //Address2
      CompGrid.Cell[c+i,rowProx] := FGrid.Comp[c].GetCellTextByID(929);  //proximity
      CompGrid.Cell[c+i,rowPrice] := FGrid.Comp[c].GetCellTextByID(947);  //sale price
      CompGrid.Cell[c+i,rowDate] := FGrid.Comp[c].GetCellTextByID(960);  //sale date
      CompGrid.Cell[c+i,rowGLA] := FGrid.Comp[c].GetCellTextByID(1004); //GLA
      CompGrid.Cell[c+i,rowNet] := FGrid.Comp[c].NetAdjustment;         //net adj
      CompGrid.Cell[c+i,rowAdj] := FGrid.Comp[c].AdjSalePrice;         //adj sales price

      if c = 0 then
        CompGrid.RowColor[rowAdj] := $00A0FEFA
      else
        CompGrid.RowColor[rowAdj] := clWindow;
    end;
end;

function SetAdjText(CompDesc, CompAdj:String):String;
var
  adj: Double;
begin
  result := CompDesc;
  adj := GetStrValue(CompAdj);
  if adj <> 0 then
    result := Format('%s  [%s]',[CompDesc, CompAdj])

end;


function TCompEditor.GetGrossAdjustment(c: Integer):Double;
var
  adj1, adj2, adj3, adj4, adj5, adj6, adj7, adj8, adj9, adj10: Double;
  adj11, adj12, adj13, adj14, adj15, adj16, adj17, adj18, adj19, adj20: Double;
  adj21, adj22, adj23, adj24, adj25: Double;
begin
  adj1  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(957)));
  adj2  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(959)));
  adj3  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(961)));
  adj4  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(963)));
  adj5  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(965)));
  adj6  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(977)));
  adj7  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(985)));
  adj8  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(987)));
  adj9  := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(995)));

  adj10 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(997)));
  adj11 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(999)));
  adj12 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1044)));
  adj13 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1045)));
  adj14 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1005)));
  adj15 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1007)));
  adj16 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1009)));
  adj17 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1011)));
  adj18 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1013)));
  adj19 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1015)));
  adj20 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1017)));

  adj21 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1019)));
  adj22 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1021)));
  adj23 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(1023)));
  adj24 := abs(GetStrValue(FGrid.Comp[c].GetCellTextByID(927)));

  result := adj1 + adj2 + adj3 + adj4 + adj5 +adj6 + adj7 + adj8 + adj9 + adj10 +
            adj11 + adj12 + adj13 + adj14 + adj15 +adj16 + adj17 + adj18 + adj19 + adj20 +
            adj21 + adj22 + adj23 + adj24;

end;


procedure TCompEditor.LoadGridToComps2;
var
  c,i: Integer;
  bMap: TBitMap;
  NetPercent, GrossPercent: Double;
  StrSale, StrNet, StrGross: String;
  SalesPrice, NetAdj, GrossAdj: Double;
begin
  i := 2;
  CompGrid.ReadOnlyButton := True;   //make sure all buttons are visible
  for c := 0 to FGrid.Count-1 do
    begin
      if c > 3 then         //always have 3 comps,
        AddCompColumn;      //add more if needed

      bMap := FGrid.Comp[c].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
      CompGrid.cell[c+i,2] := BitmapToVariant(bMap);
      CompGrid.CellData[c+i,2] := bMap;

      CompGrid.Cell[c+i,row2Addr1] := FGrid.Comp[c].GetCellTextByID(925);  //Address1
      CompGrid.Cell[c+i,row2Addr2] := FGrid.Comp[c].GetCellTextByID(926);  //Address2
      CompGrid.Cell[c+i,row2Prox] := FGrid.Comp[c].GetCellTextByID(929);  //Proximity
      CompGrid.Cell[c+i,row2Price] := FGrid.Comp[c].GetCellTextByID(947);  //Sale Price
      CompGrid.Cell[c+i,row2Date] := FGrid.Comp[c].GetCellTextByID(960);  //Sale Date
      CompGrid.Cell[c+i,row2DataSrc] := FGrid.Comp[c].GetCellTextByID(930);  //Data Sourc(s)
      CompGrid.Cell[c+i,row2VerSrc] := FGrid.Comp[c].GetCellTextByID(931);  //Verification source(s)
      if c = 0 then
      begin
        CompGrid.Cell[c+i, row2ValueAdj] := 'DESCRIPTION';
        CompGrid.RowColor[row2ValueAdj] := $00A0FEFA;
      end
      else
        CompGrid.Cell[c+i, row2ValueAdj] := 'DESCRIPTION [Adj. +/-]';
      CompGrid.Cell[c+i,row2SaleFin] := SetAdjText(FGrid.Comp[c].GetCellTextByID(956),FGrid.Comp[c].GetCellTextByID(957));
      CompGrid.Cell[c+i,row2Concess] := SetAdjText(FGrid.Comp[c].GetCellTextByID(958),FGrid.Comp[c].GetCellTextByID(959));  //Concessions
      CompGrid.Cell[c+i,row2Loc] := SetAdjText(FGrid.Comp[c].GetCellTextByID(962),FGrid.Comp[c].GetCellTextByID(963));  //Location
      CompGrid.Cell[c+i,row2Leasehold] := SetAdjText(FGrid.Comp[c].GetCellTextByID(964),FGrid.Comp[c].GetCellTextByID(965));  //rowLeasehold
      CompGrid.Cell[c+i,row2Site] := SetAdjText(FGrid.Comp[c].GetCellTextByID(976),FGrid.Comp[c].GetCellTextByID(977));  //Site
      CompGrid.Cell[c+i,row2View] := SetAdjText(FGrid.Comp[c].GetCellTextByID(984),FGrid.Comp[c].GetCellTextByID(985));  //View
      CompGrid.Cell[c+i,row2Design] := SetAdjText(FGrid.Comp[c].GetCellTextByID(986),FGrid.Comp[c].GetCellTextByID(987));  //Design (Style)
      CompGrid.Cell[c+i,row2Quaility] :=SetAdjText( FGrid.Comp[c].GetCellTextByID(994),FGrid.Comp[c].GetCellTextByID(995));  //Construction Quailty
      CompGrid.Cell[c+i,row2Age] := SetAdjText(FGrid.Comp[c].GetCellTextByID(996),FGrid.Comp[c].GetCellTextByID(997));  //Actual Age
      CompGrid.Cell[c+i,row2Cond] := SetAdjText(FGrid.Comp[c].GetCellTextByID(998),FGrid.Comp[c].GetCellTextByID(999));  //Condition
      CompGrid.Cell[c+i,row2Rooms] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1041),FGrid.Comp[c].GetCellTextByID(1045)); //Total Rooms
      CompGrid.Cell[c+i,row2Bedrooms] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1042),FGrid.Comp[c].GetCellTextByID(1045)); //Bedrooms
      CompGrid.Cell[c+i,row2Bathrooms] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1043),FGrid.Comp[c].GetCellTextByID(1045)); //Bathrooms
      CompGrid.Cell[c+i,row2GLA] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1004),FGrid.Comp[c].GetCellTextByID(1005)); //GLA
      CompGrid.Cell[c+i,row2BsmtArea] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1006),FGrid.Comp[c].GetCellTextByID(1007)); //Basement & Finished
      CompGrid.Cell[c+i,row2BsmtRooms] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1008),FGrid.Comp[c].GetCellTextByID(1009)); //Rooms Below Grade
      CompGrid.Cell[c+i,row2FuncUtil] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1010),FGrid.Comp[c].GetCellTextByID(1011)); //Functional Utility
      CompGrid.Cell[c+i,row2HeatCool] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1012),FGrid.Comp[c].GetCellTextByID(1013)); //Heating/Cooling
      CompGrid.Cell[c+i,row2EngEff] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1014),FGrid.Comp[c].GetCellTextByID(1015)); //Energy Efficient Items
      CompGrid.Cell[c+i,row2Garage] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1016),FGrid.Comp[c].GetCellTextByID(1017)); //Garage/Carport
      CompGrid.Cell[c+i,row2Porch] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1018),FGrid.Comp[c].GetCellTextByID(1019)); //Porch/Patio/Deck
      CompGrid.Cell[c+i,row2Other1] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1020),FGrid.Comp[c].GetCellTextByID(1021)); //Other1
      CompGrid.Cell[c+i,row2Other2] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1022),FGrid.Comp[c].GetCellTextByID(1023)); //Other2
      CompGrid.Cell[c+i,row2Other3] := SetAdjText(FGrid.Comp[c].GetCellTextByID(1032),FGrid.Comp[c].GetCellTextByID(927)); //Other3
      CompGrid.Cell[c+i,row2Net] := FGrid.Comp[c].NetAdjustment;         //net adj
      CompGrid.Cell[c+i,row2Adj] := FGrid.Comp[c].AdjSalePrice;         //adj sales price
//calculate net and gross percentage
      StrSale  := FGrid.Comp[c].GetCellTextByID(947);
      StrNet   := FGrid.Comp[c].NetAdjustment;

      SalesPrice := GetStrValue(StrSale);
      NetAdj     := GetStrValue(StrNet);
      GrossAdj := GetGrossAdjustment(c);

      if (SalesPrice <> 0) and (c > 0) then
        begin
          NetPercent := (NetAdj/SalesPrice)  * 100;
          CompGrid.Cell[c+i, row2NetPercent] := Format('%.1f %%',[NetPercent]);

          GrossPercent := (GrossAdj/SalesPrice)  * 100;
          CompGrid.Cell[c+i, row2GrsPercent] := Format('%.1f %%',[GrossPercent]);
        end;

    end;
end;


procedure TCompEditor.StoreComp(AComp: Integer);
var
  CompData: TCompData;
begin
  if FCompStore[AComp-1] = nil then
    begin
      CompData := TCompData.Create;
      try
        CompData.LoadFromComp(FGrid.Comp[AComp]);
        FCompStore[AComp-1] := CompData;
      except
        if Assigned(CompData) then CompData.Free;
        FCompStore[AComp-1] := nil;
      end;
    end
  else
    ShowNotice('Comp data was previously saved to same comp.');
end;

//cmp1,cmp2 are 1 based and correspond to the FGrid.Comps since comp0 is subject.
//comp1 is being written into comp2 slot so we have to store comp2 into a storage array
//as we run thur reordering, the comps in storage will be written to the grid and
//the storage will be emptied. So it does not really swap, it inserts and stores.
procedure TCompEditor.SwapComps(Cmp1, Cmp2: Integer);
var
  n: Integer;
begin
  StoreComp(cmp2);                                //save comp2 into FCompStore[cmp2-1]

  n := CompGrid.Col[cmp2+2].Tag;                  //skip 1st 2 columns
  CompGrid.Col[cmp2+2].Tag := n + 1;              //+1 in the tag indicates it's in storage

  if (CompGrid.Col[cmp1+2].Tag mod 10) > 0 then   //if previously saved, use saved data
    begin
      if assigned(FCompStore[cmp1-1]) then
        FCompStore[cmp1-1].SaveToComp(FGrid.Comp[Cmp2]);
    end
  else
    begin
      FGrid.Comp[Cmp2].AssignData(FGrid.Comp[Cmp1]);          //transfer comp1 into comp2
    end;
end;

procedure TCompEditor.btnOkClick(Sender: TObject);
var
  n, i, nn, action: Integer;
  doc: TContainer;
begin
   writePref;  
  if FNeedsSwapping then
    begin
      PushMouseCursor(crHourglass);
      try
        for n := 3 to CompGrid.Cols do                  //n = displayCol
          if CompGrid.DataColnr[n] <> n then            //if display <> data
            SwapComps(CompGrid.DataColnr[n]-2, n-2);    //put data into display column order
      finally
        PopMousecursor;
      end;
    end;
  for n := 3 to CompGrid.Cols do
    begin
      nn := CompGrid.DataColnr[n];
      action := CompGrid.col[nn].tag div 10;    //tag = +20,30,40 depending on selection
      case action of
        actClear:         CompClearAll(n-2);
        actAdjs:          CompClearAdjs(n-2);
        actCopySubDesc:   CompCopySubj(n-2);
        actCopyCmpDesc:   CompCopyDesc(n-2);
        actCopyCmpText:   CompCopyTextOnly(n-2);
        actCopyCmpAll:    CompCopyAll(n-2);
      end;
    end;

    if FModified and (appPref_CompEditorMode=mtTextEditOnly) then
      begin
        if CompGrid.Rows = MaxRows2 then
          SaveGridDataToForms_Extend
        else if CompGrid.Rows = MaxRows then
          SaveGridDataToForms_Basic;
      end;
  //update the net & gross precents
  doc := TContainer(FDoc);
  for i := 0 to doc.docForm.count-1 do
    begin
      doc.docForm[i].ProcessMathCmd(UpdateNetGrossID);   //-1
    end;
  Close;
end;

procedure TCompEditor.SetCellForComp(c, aCellID: Integer; aCellValue:String); //Ticket #733
var
  cValue,aValue: String;
begin
  if aCellID = 0 then exit;
  if pos('[',aCellValue) > 0 then
    begin
      cValue := popStr(aCellValue, '[');
      aValue := popStr(aCellValue, ']');
      FGrid.Comp[c].SetCellTextByID(aCellID,trim(cValue));
      FGrid.Comp[c].SetCellTextByID(aCellID+1, trim(aValue));
    end
  else
    begin
      FGrid.Comp[c].SetCellTextByID(aCellID,aCellValue);
      FGrid.Comp[c].SetCellTextByID(aCellID+1, '');   //Empty CellValue;
    end;
end;

function TCompEditor.SaveGridDataToForms_Extend:Boolean;
var
  i: Integer;
  CompCol: TCompColumn;
begin
  result := False;
  PushMouseCursor(crHourglass);
  try
    for i:= 0 to FGrid.Count - 1 do
      begin
        CompCol := FGrid.Comp[i];    //Grid comp column
        CompCol.SetCellTextByID(925, CompGrid.Cell[i+2, row2Addr1]);   //Address1
        CompCol.SetCellTextByID(926, CompGrid.Cell[i+2, row2Addr2]);   //Address2
        CompCol.SetCellTextByID(929, CompGrid.Cell[i+2, row2Prox]);    //Proximity
        CompCol.SetCellTextByID(947, CompGrid.Cell[i+2, row2Price]);   //Sales Price
        CompCol.SetCellTextByID(960, CompGrid.Cell[i+2, row2Date]);    //Sale Date
        SetCellForComp(i,1004,CompGrid.Cell[i+2,row2GLA]); //GLA
        CompCol.SetCellTextByID(930, CompGrid.Cell[i+2, row2DataSrc]); //Data Source
        CompCol.SetCellTextByID(931, CompGrid.Cell[i+2, row2VerSrc]);  //Verification Source
        SetCellForComp(i,956,CompGrid.Cell[i+2,row2SaleFin]); //Sales Finance
        SetCellForComp(i,958,CompGrid.Cell[i+2,row2Concess]); //Concession
        SetCellForComp(i,962,CompGrid.Cell[i+2,row2Loc]); //Location
        SetCellForComp(i,964,CompGrid.Cell[i+2,row2Leasehold]); //LeaseHold
        SetCellForComp(i,976,CompGrid.Cell[i+2,row2Site]); //Site
        SetCellForComp(i,984,CompGrid.Cell[i+2,row2View]); //VIew
        SetCellForComp(i,986,CompGrid.Cell[i+2,row2Design]); //Design
        SetCellForComp(i,994,CompGrid.Cell[i+2,row2Quaility]); //Quality
        SetCellForComp(i,996,CompGrid.Cell[i+2,row2Age]); //Age
        SetCellForComp(i,998,CompGrid.Cell[i+2,row2Cond]); //Condition

        SetCellForComp(i,1041,CompGrid.Cell[i+2,row2Rooms]); //Room
        SetCellForComp(i,1042,CompGrid.Cell[i+2,row2Bedrooms]); //BedRoom
        SetCellForComp(i,1043,CompGrid.Cell[i+2,row2Bathrooms]); //bath
        SetCellForComp(i,1006,CompGrid.Cell[i+2,row2BsmtArea]); //Bsmt
        SetCellForComp(i,1008,CompGrid.Cell[i+2,row2BsmtRooms]); //Bsmt room
        SetCellForComp(i,1010,CompGrid.Cell[i+2,row2FuncUtil]); //Func Util
        SetCellForComp(i,1012,CompGrid.Cell[i+2,row2HeatCool]); //Heating/Cooling
        SetCellForComp(i,1014,CompGrid.Cell[i+2,row2EngEff]); //Energy
        SetCellForComp(i,1016,CompGrid.Cell[i+2,row2Garage]); //garage
        SetCellForComp(i,1018,CompGrid.Cell[i+2,row2Porch]); //Porch
        SetCellForComp(i,1020,CompGrid.Cell[i+2,row2Other1]); //Other 1
        SetCellForComp(i,1022,CompGrid.Cell[i+2,row2Other2]); //Other 2
        SetCellForComp(i,1032,CompGrid.Cell[i+2,row2Other3]); //Other 3
        result := True;
      end;
    finally
      PopMousecursor
    end;
end;


function TCompEditor.SaveGridDataToForms_Basic:Boolean;
var
  i: Integer;
  CompCol: TCompColumn;
begin
  result := False;
  PushMouseCursor(crHourglass);
  try
    for i:= 0 to FGrid.Count - 1 do
      begin

        CompCol := FGrid.Comp[i];    //Grid comp column
        CompCol.SetCellTextByID(925, CompGrid.Cell[i+2, rowAddr1]);   //Address1
        CompCol.SetCellTextByID(926, CompGrid.Cell[i+2, rowAddr2]);   //Address2
        CompCol.SetCellTextByID(929, CompGrid.Cell[i+2, rowProx]);    //Proximity
        CompCol.SetCellTextByID(947, CompGrid.Cell[i+2, rowPrice]);   //Sales Price
        CompCol.SetCellTextByID(960, CompGrid.Cell[i+2, rowDate]);    //Sale Date
        SetCellForComp(i,1004,CompGrid.Cell[i+2,rowGLA]); //GLA
        result := True;
      end;
    finally
      PopMousecursor
    end;
end;

procedure TCompEditor.CompGridColMoved(Sender: TObject; ToDisplayCol,
  Count: Integer; ByUser: Boolean);
begin
  if appPref_CompEditorMode = mtTextEditOnly then
    FNeedsSwapping := False
  else
    FNeedsSwapping := True;
end;

function TCompEditor.GetSortValue(Col, Row: Integer): Double;
begin
  result := 0;
  case Row of
    rowPrice: result := GetStrValue(CompGrid.Cell[Col,rowPrice]);
    rowDate:  result := Double(GetValidDate(CompGrid.Cell[Col,rowDate]));
    rowGLA:   result := GetStrValue(CompGrid.Cell[Col,rowGLA]);
    rowNet:   result := GetStrValue(CompGrid.Cell[Col,rowNet]);
    rowProx:  result := GetStrValue(CompGrid.Cell[Col,rowProx]);
    rowAdj:   result := GetStrValue(CompGrid.Cell[Col,rowAdj]);
  end;
end;

function TCompEditor.GetSortValue2(Col, Row: Integer): Double;
begin
  result := 0;
  case Row of
    row2Price: result := GetStrValue(CompGrid.Cell[Col,row2Price]);
    row2Date:  result := Double(GetValidDate(CompGrid.Cell[Col,row2Date]));
    row2GLA:   result := GetStrValue(CompGrid.Cell[Col,row2GLA]);
    row2Net:   result := GetStrValue(CompGrid.Cell[Col,row2Net]);
    row2Prox:  result := GetStrValue(CompGrid.Cell[Col,row2Prox]);
    row2Adj:   result := GetStrValue(CompGrid.Cell[Col,row2Adj]);

 (*   rowAdj: begin   //sort by absolute min between sub and comp
      SubPrice := GetStrValue(CompGrid.Cell[2,rowPrice]);
      CmpPrice := GetStrValue(CompGrid.Cell[Col,rowAdj]);
      result := Abs(SubPrice - CmpPrice);
    end;     *)
  end;
end;

procedure TCompEditor.SortColumnsBy(DataType: Integer; reverseSort: Boolean);
var
  i: Integer;
  List: TObjectList;
begin
  List := TObjectList.Create(True);
  try
    //create the list to sort
    for i := 3 to CompGrid.Cols do
      case DataType of
        cpSortByAdjPrice: List.Add( TValueIndex.Create(GetSortValue(i,rowAdj), i));
        cpSortByNetAdj:   List.Add( TValueIndex.Create(GetSortValue(i,rowNet), i));
        cpSortByDate:     List.Add( TValueIndex.Create(GetSortValue(i,rowDate), i));
        cpSortByGLA:      List.Add( TValueIndex.Create(GetSortValue(i,rowGLA), i));
        cpSortByProx:     List.Add( TValueIndex.Create(GetSortValue(i,rowProx), i));
      end;

    if reverseSort then
      case DataType of
        cpSortByDate:  List.Sort(CompareAscending);
      else
        List.Sort(CompareDesending);
      end
    else
      case DataType of
        cpSortByDate:  List.Sort(CompareDesending);
      else
        List.Sort(CompareAscending);
      end;

    //set columns according to sort
    CompGrid.BeginUpdate;
    for i := 0 to List.Count-1 do
      CompGrid.DisplayColnr[TValueIndex(List.Items[i]).FIndex] := i+3;
    FNeedsSwapping := True;
    CompGrid.EndUpdate;
  finally
    List.Free;
  end;
end;

procedure TCompEditor.SortColumnsBy2(DataType: Integer; reverseSort: Boolean);
var
  i: Integer;
  List: TObjectList;
begin
  List := TObjectList.Create(True);
  try
    //create the list to sort
    for i := 3 to CompGrid.Cols do
      case DataType of
        cpSortByAdjPrice: List.Add( TValueIndex.Create(GetSortValue2(i,row2Adj), i));
        cpSortByNetAdj:   List.Add( TValueIndex.Create(GetSortValue2(i,row2Net), i));
        cpSortByDate:     List.Add( TValueIndex.Create(GetSortValue2(i,row2Date), i));
        cpSortByGLA:      List.Add( TValueIndex.Create(GetSortValue2(i,row2GLA), i));
        cpSortByProx:     List.Add( TValueIndex.Create(GetSortValue2(i,row2Prox), i));
      end;

    if reverseSort then
      case DataType of
        cpSortByDate:  List.Sort(CompareAscending);
      else
        List.Sort(CompareDesending);
      end
    else
      case DataType of
        cpSortByDate:  List.Sort(CompareDesending);
      else
        List.Sort(CompareAscending);
      end;

    //set columns according to sort
    CompGrid.BeginUpdate;
    for i := 0 to List.Count-1 do
      CompGrid.DisplayColnr[TValueIndex(List.Items[i]).FIndex] := i+3;
    FNeedsSwapping := True;
    CompGrid.EndUpdate;
  finally
    List.Free;
  end;
end;

procedure TCompEditor.SetOriginalOrder;
var
  n: integer;
begin
  for n := 3 to CompGrid.Cols do
    CompGrid.DisplayColnr[n] := n;
  FNeedsSwapping := False;
end;

procedure TCompEditor.cmbxSortChange(Sender: TObject);
begin
  if appPref_CompEditorMode=mtBasic then
    begin
        if (cmbxSort.ItemIndex <> FSortOption) then
          case cmbxSort.ItemIndex of
            cpOrigSortOrder:  SetOriginalOrder;
            cpSortByAdjPrice: SortColumnsBy(cpSortByAdjPrice, ControlKeyDown);
            cpSortByNetAdj:   SortColumnsBy(cpSortByNetAdj, ControlKeyDown);
            cpSortByDate:     SortColumnsBy(cpSortByDate, ControlKeyDown);
            cpSortByGLA:      SortColumnsBy(cpSortByGLA, ControlKeyDown);
            cpSortByProx:     SortColumnsBy(cpSortByProx, ControlKeyDown);
          end;
        FSortOption := cmbxSort.ItemIndex;
    end
  else if appPref_CompEditorMode=mtExtend then
    begin
      if (cmbxSort.ItemIndex <> FSortOption) then
        case cmbxSort.ItemIndex of
          cpOrigSortOrder:  SetOriginalOrder;
          cpSortByAdjPrice: SortColumnsBy2(cpSortByAdjPrice, ControlKeyDown);
          cpSortByNetAdj:   SortColumnsBy2(cpSortByNetAdj, ControlKeyDown);
          cpSortByDate:     SortColumnsBy2(cpSortByDate, ControlKeyDown);
          cpSortByGLA:      SortColumnsBy2(cpSortByGLA, ControlKeyDown);
          cpSortByProx:     SortColumnsBy2(cpSortByProx, ControlKeyDown);
        end;
      FSortOption := cmbxSort.ItemIndex;
    end;
end;

//the type of grid has changed
procedure TCompEditor.CmbxCompChange(Sender: TObject);
begin
  // Build a differnt kind of grid
end;

procedure TCompEditor.ResetActionFlag(AComp: Integer);
var
  newTag: Integer;
begin
  newTag := CompGrid.Col[AComp].tag mod 10;      //flags are 20,30,40; keep 1's digit if set
  CompGrid.Col[AComp].tag := newTag;
end;

function TCompEditor.GetUserCompSelection(option, DataCol: Integer; var includePhoto: Boolean): Integer;
var
  Selector: TCompSelector;
begin
  result := 0;
  Selector := TCompSelector.create(self);
  try
    Selector.LoadCompID(FGrid.Count-1, DataCol-2);   //dont count subj or first 2 dataCols
    if option = 1 then
      Selector.Description := 'Copy (duplicate) the Descriptions'
    else if option = 2 then
      begin
        Selector.Description := 'Copy (duplicate) the Entire Contents';
        Selector.ckbxPhoto.visible := True;
      end;
    if Selector.ShowModal = mrOK then
      result := Selector.SelectedComp;

    includePhoto := Selector.ckbxPhoto.checked;

    if result = DataCol-2 then
      begin
        ShowAlert(atStopAlert, 'You cannot copy from the same comparable. Please select another one.');
        result := 0;
      end;
  finally
    Selector.Free;
  end;
end;

function TCompEditor.GetCompSelection(DataCol: Integer): Integer;
var
  pfStr: String;
begin
  pfStr := CompGrid.Cell[DataCol,1];       //should be 'Copy from: xx'
  pfStr := Copy(pfStr, POS(':', pfStr)+1, length(pfStr));   //+1, skip ':'
  result := GetValidInteger(pfStr);
end;

procedure TCompEditor.DisplayClearAll(DataCol: Integer);
var
  n: Integer;
begin
  if CompGrid.CellData[DataCol,2] <> nil then      //clear image
    begin
      TBitmap(CompGrid.CellData[DataCol,2]).Free;
      CompGrid.Cell[DataCol,2] := BitmapToVariant(nil);
      CompGrid.CellData[DataCol,2] := Pointer(nil);
    end;

  for n := 3 to CompGrid.Rows do                   //clear text
    CompGrid.Cell[DataCol, n] := '';

  CompGrid.Col[DataCol].tag := CompGrid.Col[DataCol].tag + 20; //set flag to do real action on ok
end;

procedure TCompEditor.DisplayClearAdjs(DataCol: Integer);
var
  n: Integer;
begin
  for n := 8 to CompGrid.Rows do                   //clear text
    CompGrid.Cell[DataCol, n] := '';

  CompGrid.Col[DataCol].tag := CompGrid.Col[DataCol].tag + 30; //set flag to do real action on ok
end;

procedure TCompEditor.DisplayCopySubj(DataCol: Integer);
begin
  CompGrid.Cell[DataCol, 8] := CompGrid.Cell[2, 8];

  CompGrid.Col[DataCol].tag := CompGrid.Col[DataCol].tag + 40; //set flag to do real action on ok
end;

procedure TCompEditor.DisplayCopyDesc(DataCol: Integer; var actionText: String);
var
  copyFrom: Integer;
  dummy: Boolean;
begin
  copyFrom := GetUserCompSelection(1, DataCol, dummy);
  if copyFrom > 0 then
    begin
      CompGrid.Cell[DataCol, 8] := CompGrid.Cell[copyFrom + 2, 8];

      actionText := 'Copy desc from:'+IntToStr(copyFrom);
      CompGrid.Col[DataCol].tag := CompGrid.Col[DataCol].tag + 50; //set flag to do real action
    end;
end;

procedure TCompEditor.DisplayCopyAll(DataCol: Integer; var actionText: String);
var
  n, copyFrom: Integer;
  includePhoto: Boolean;
  copyBM: TBitMap;
begin
  copyFrom := GetUserCompSelection(2, DataCol, includePhoto);
  if copyFrom > 0 then
    begin
      if includePhoto then
        begin
          if CompGrid.CellData[DataCol,2] <> nil then       //clear image
            begin
              TBitmap(CompGrid.CellData[DataCol,2]).Free;
              CompGrid.Cell[DataCol,2] := BitmapToVariant(nil);
              CompGrid.CellData[DataCol,2] := Pointer(nil);
            end;
          if CompGrid.CellData[copyFrom+2,2] <> nil then       //from comp has image
            begin                                              //copy it to dataCol
              CopyBM := TBitmap.create;
              CopyBM.Assign(VariantToBitmap(CompGrid.Cell[copyFrom+2,2]));
              CompGrid.Cell[DataCol,2] := BitmapToVariant(copyBM);
              CompGrid.CellData[DataCol,2] := Pointer(copyBM);
            end;
        end;
      for n := 3 to CompGrid.Rows do
        CompGrid.Cell[DataCol, n] := CompGrid.Cell[copyFrom+2, n];

      actionText := 'Copy all from:'+IntToStr(copyFrom);
      CompGrid.Col[DataCol].tag := CompGrid.Col[DataCol].tag + 70; //set flag to do real action
    end;
end;


{*************************************************************}
{ These are the routines that do the actual data manulipation }
{*************************************************************}

procedure TCompEditor.CompClearAdjs(AComp: Integer);
begin
  try
    FGrid.ClearCompAdjColumn(AComp);
  except
    ShowNotice('A problem was encountered trying to clear all the cells.');
  end;
end;

procedure TCompEditor.CompClearAll(AComp: Integer);
begin
  FActionOn := True;
  try
    FGrid.ClearCompAllCells(AComp, True); //true = include photo
  except
    ShowNotice('A problem was encountered trying to clear comparable.');
  end;
end;

procedure TCompEditor.CompCopySubj(AComp: Integer);
begin
  FActionOn := True;
  try
    FGrid.AssignSubjDescToComp(AComp);
  except
    ShowNotice('A problem was encountered trying to copy the subject to the comparable.');
  end;
end;

procedure TCompEditor.CompCopyDesc(AComp: Integer);
var
  copyFrom: Integer;
begin
  FActionOn := True;
  try
    copyFrom := GetCompSelection(AComp+2);     //+2 convert to dataCol
    if copyFrom = 0 then
      begin
        ShowNotice('The "copy from" comparable was not specified for pasting into comp # '+ IntToStr(AComp));
        Exit;
      end;
    FGrid.AssignCompDescToComp(copyFrom, AComp);
  except
    ShowNotice('A problem was encountered trying to copy the comparable contents. Maybe the "Copy From" comparable was not specified.');
  end;
end;

procedure TCompEditor.CompCopyTextOnly(AComp: Integer);
var
  copyFrom: Integer;
begin
  FActionOn := True;
  try
    copyFrom := GetCompSelection(AComp+2);     //+2 convert to dataCol
    if copyFrom = 0 then
      begin
        ShowNotice('The "Copy from" comparable was not specified for pasting into comp # '+ IntToStr(AComp));
        Exit;
      end;

    FGrid.AssignCompToComp(copyFrom, AComp, False);
  except
    ShowNotice('A problem was encountered trying to copy the comparable contents. Maybe the "Copy From" comparable was not specified.');
  end;
end;

procedure TCompEditor.CompCopyAll(AComp: Integer);
var
  copyFrom: Integer;
begin
  FActionOn := True;
  try
    copyFrom := GetCompSelection(AComp+2);     //+2 convert to dataCol
    if copyFrom = 0 then
      begin
        ShowNotice('The "Copy from" comparable was not specified for pasting into comp # '+ IntToStr(AComp));
        Exit;
      end;

    FGrid.AssignCompToComp(copyFrom, AComp, True);  //true: copy photo also
  except
    ShowNotice('A problem was encountered trying to copy the comparable contents. Maybe the "Copy From" comparable was not specified.');
  end;
end;

procedure TCompEditor.LoadPref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
  aMode:Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;

  PrefFile := TMemIniFile.Create(IniFilePath);           //create the INI reader

  With PrefFile do
  begin
    appPref_CompEditorMode := ReadInteger('Comps Editor','CompEditorMode', -1);
    appPref_CompEditorUseBasic := ReadBool('Comps Editor','CompEditorUseBasic', False);
    if appPref_CompEditorMode = -1 then  //NOTE: only for backward compatible
    begin
      if appPref_CompEditorUseBasic then
        appPref_CompEditorMode := mtBasic
      else
        appPref_CompEditorMode := mtExtend;
    end;
    rdoMode.ItemIndex := appPref_CompEditorMode;
    FCurrentMode := rdoMode.ItemIndex;
  end;
  PrefFile.free;
end;


procedure TCompEditor.WritePref;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  appPref_CompEditorMode := rdoMode.ItemIndex;
  With PrefFile do
  begin
    WriteInteger('Comps Editor', 'CompEditorMode', appPref_CompEditorMode);
    if appPref_CompEditorMode = mtExtend then
      appPref_CompEditorUseBasic := False
    else if appPref_CompEditorMode = mtBasic then
      appPref_CompEditorUseBasic := True
    else if appPref_CompEditorMode = mtTextEditOnly then
      begin
        if CompGrid.Rows > MaxRows then
          appPref_CompEditorUseBasic := False
        else
          appPref_COmpEditorUseBasic := True;
      end;
    WriteBool('Comps Editor', 'CompEditorUseBasic', appPref_CompEditorUseBasic);
    UpdateFile;      // do it now
  end;
  PrefFile.Free;
end;


procedure TCompEditor.ReloadGrid;
var
  Cntr,i: Integer;
  Doc: TContainer;
  aMode:Integer;
begin
  CompGrid.Cols := 5; //starts with 5 columns.
  CompGrid.ClearAll;
  if rdoMode.ItemIndex = mtTextEditOnly then
    begin
      if appPref_CompEditorUseBasic then
        aMode := mtBasic
      else
        aMode := mtExtend;
    end
  else if rdoMode.ItemIndex = mtExtend then
    aMode := mtExtend
  else
    aMode := mtBasic;

  if aMode = mtExtend then
    begin
      CompGrid.Rows := MaxRows2;
      Doc := TContainer(FDoc);
      for Cntr := 1 to MaxRows2 do
        case Cntr of
          row2Other1:
            begin
              CompGrid.Cell[1,Cntr] := Doc.GetCellTextByID(1500);
              if Trim(CompGrid.Cell[1,Cntr]) = '' then
                CompGrid.Cell[1,Cntr] := RowLabel2[Cntr];
            end;
          row2Other2:
            begin
              CompGrid.Cell[1,Cntr] := Doc.GetCellTextByID(1501);
              if Trim(CompGrid.Cell[1,Cntr]) = '' then
                CompGrid.Cell[1,Cntr] := RowLabel2[Cntr];
            end;
          row2Other3:
            begin
              CompGrid.Cell[1,Cntr] := Doc.GetCellTextByID(1502);
              if Trim(CompGrid.Cell[1,Cntr]) = '' then
                CompGrid.Cell[1,Cntr] := RowLabel2[Cntr];
            end;
          else
            CompGrid.Cell[1,Cntr] := RowLabel2[Cntr];
        end;
     end
  else
     begin
       CompGrid.Rows := MaxRows;
       for Cntr := 1 to MaxRows do
         begin
           CompGrid.RowColor[rowAdj] := clWindow;
           CompGrid.Cell[1,Cntr] := RowLabel[Cntr];
         end;
     end;

  if FGrid.Count > 0 then
    begin
      if aMode = mtBasic then
        LoadGridToComps
      else
        LoadGridToComps2;

      SetLength(FCompStore, FGrid.Count);     //don't include subj
      CheckCompUniformity;          //check if all the tables are the same
    end;
end;


procedure TCompEditor.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TCompEditor.btnRefreshClick(Sender: TObject);
begin
  ReloadGrid;
(*
  FModified := False;
  FNeedsSwapping := False;
  FirstTime := True;
//  DoSetView;
  rdoMode.Enabled := true;
*)
end;


procedure TCompEditor.CompGridCellEdit(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  ByUser := False;
  
  FModified := True;
end;


procedure TCompEditor.rdoModeClick(Sender: TObject);
var
  i: Integer;
  aMsg:String;
begin
  if FCurrentMode = rdoMode.ItemIndex then exit;
  if not rdoMode.Enabled then exit;
  if rdoMode.ItemIndex = mtTextEditOnly then
    begin
      if (cmbxSort.ItemIndex <> -1) or FNeedsSwapping or FActionOn then
        begin
          aMsg := 'Please complete your operation before changing to Text Edit Mode.';
          ShowNotice(aMsg);
          rdoMode.ItemIndex := FCurrentMode;  //set back to previous mode
          exit;
        end;
    end;

  FCurrentMode := rdoMode.ItemIndex;
  appPref_CompEditorMode := FCurrentMode;
  if appPref_CompEditorMode = mtTextEditOnly then
    rdoMode.Enabled := True
  else if (rdoMode.ItemIndex = mtTextEditOnly) and FModified then
    rdoMode.Enabled := FirstTime;
  CompGrid.Enabled := True;
  DoSetView;
  if FCurrentMode = mtBasic then
    appPref_CompEditorUseBasic := True
  else if FCurrentMode = mtExtend then
    appPref_CompEditorUseBasic := False;
  ReloadGrid;
end;

procedure TCompEditor.rdoModeEnter(Sender: TObject);
var
  aMsg:String;
begin
  FCurrentMode := appPref_CompEditorMode;
  if FModified and (rdoMode.ItemIndex = mtTextEditOnly) then
    begin
      aMsg := 'Please complete your text editing before changing mode.';
      ShowNotice(aMsg);
      rdoMode.Enabled := False;
    end;
end;

procedure TCompEditor.CompGridHeadingClick(Sender: TObject;
  DataCol: Integer);
begin
  showNotice('HadingClick');
end;

procedure TCompEditor.CompGridPaintCell(Sender: TObject; DataCol,
  DataRow: Integer; ARect: TRect; State: TtsPaintCellState;
  var Cancel: Boolean);
begin
   if rdoMode.ItemIndex = mtTextEditOnly then
     CompGrid.SelectionColor := clWindow
   else
     CompGrid.SelectionColor := clhighlight;
end;

end.
