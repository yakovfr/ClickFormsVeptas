unit UAdjustments;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{  This unit is derived from the original UCellAutoAdjust unit, instead of getting subject, comps }
{   from the container, will walk through the grid with subject comps to get the value, calculate }
{   the adjustments then display adjustment values back to the grid. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids_ts, TSGrid, ExtCtrls,ComCtrls, Contnrs,
  UGlobals, UUtil1, UBase, UFileUtils,UGridMgr, UForms, UUtil2,
  uCompGlobal{, ActnList, ExtActns};

const
  aaDate      = 960;     //these are the CellIDs for auto calc cells
  aaSite      = 976;
  aaConstQuality = 994;
  aaAge       = 996;
  aaCondition = 998;
  aaTotalRms  = 1041;
  aaBedrooms  = 1042;
  aaBaths     = 1043;
  aaGBArea    = 1002;
  aaGLArea    = 1004;
  aaBasement  = 1006;
  aaBsmtFinArea = 1006;
  aaRmsBelow  = 1008;
  aaGarages   = 1016;
  aaPorches   = 1018;
  aaFireplaces= 1020;
  aaPools     = 1022;
  aaOther     = 1032;

  //TotBedRoomsAdjCellID = 1044;
  nRoomAdjRecs = 5;
  nRoomAdjTypes = 3;
  //col 1: TotalRoomCellID, col 2: BedRoomCellID, col 3: BathroomCellID
  //col 4: TotalRommAdjustmentCellID, col 5: BedRoomAdjustmentCellID,
  //col 6: BathRoomAdjustmentCellID, col 7: RoomSumAdjustmentCellID.
  //for the 1st record cellID = type of adjustment
  RoomAdjCellIDs : Array [1..nRoomAdjRecs,1..7] of Integer =
                  ( (1041,1042,1043,1044,1044,1045,1045),
                    (1047,1048,1049,0,0,0,1051),
                    (2335,2336,2337,0,0,0,2338),
                    (2339,2340,2341,0,0,0,2342),
                    (2343,2344,2345,0,0,0,2346));

  colAdjId = 1;
  colAdjActive = 2;
  colAdjType = 3;
  colAdjRate = 4;
  colAdjMode = 5;
  colAdjUnits = 6;
  colAdjMindiff = 7;
  colUseReg     = 8;
  colRegAdj     = 9;

  rowAdjSaleDate = 1;
  rowAdjSite = 2;
  rowAdjConstQuality = 3;
  rowAdjAge = 4;
  rowAdjCondition = 5;
  rowAdjTtRooms = 6;
  rowAdjBdRooms = 7;
  rowAdjBhRooms = 8;
  rowAdjGLA = 9;
  rowAdjGBA = 10;
  rowAdjBasement = 11;
  rowAdjBsmtFinArea = 12;
  rowAdjRoomsBelow = 13;
  rowAdjGarages = 14;
  rowAdjPorches = 15;
  rowAdjFireplaces = 16;
  rowAdjPools = 17;
  rowAdjOther = 18;

  adjModeAbs = 1;
  adjModePercents = 2;
  adjCalcModes: Array [1..2] of String = ('$ per Unit','% of Price per Unit');
  adjSiteSqft = 1;
  adjSiteAcres = 2;
  adjSiteUnits: Array [1..2] of String = ('SqFt','Acres');

 {cAutoAdjVersion = 1;}      //original 14 adjustments
 {cAutoAdjVersion = 2;}      //added Building GLA adjustment, inserted at #7
 {cAutoAdjVersion = 4;}      //added CalcMode Field: for now $ value or % Sale Price
 {cAutoAdjVersion = 5;}      //added finished basement GLA boolean flag
  cAutoAdjVersion = 6;       //added finished basement GLA, construction quality & condition rows

  defaultAdjName = 'DefaultAdl.lst';

  nExcepRoomAdjForms = 7;
  SumOnlyRoomAdjForms: Array[1..nExcepRoomAdjForms] of Integer = (349,360,364,737,762,18,21);

  
   cBaseNeighborhoodValue = 1;
   cGLA                   = 2;
   cSiteArea              = 3;
   cBsmtArea              = 4;
   cBsmtFinArea           = 5;
   cYearBuilt             = 6;
   cSalesDate             = 7;

type
  AdjustDescr = record
    adjID: Integer;
    adjType: String;
    strUnit: String;
  end;

const
  MaxAdjustments = 19;
  AvailAdjustments: Array [1..MaxAdjustments] of AdjustDescr =
              ((adjID: aaDate; adjType: 'Date of Sale'; strUnit: 'Months'),  //1
                (adjID: aaSite; adjType: 'Site Area'; strUnit: 'SqFt'),   //2
                (adjID: aaConstQuality; adjType: 'Construction Quality'; strUnit: 'Q#'),   //3
                (adjID: aaAge; adjType: 'Actual Age'; strUnit: 'Years'),     //4
                (adjID: aaCondition; adjType: 'Condition'; strUnit: 'C#'),     //5
                (adjID: aaTotalRms; adjType: 'Total Rooms'; strUnit: 'Rooms'), //6
                (adjID: aaBedrooms; adjType: 'Bedrooms'; strUnit: 'Rooms'),   //7
                (adjID: aaBaths; adjType: 'Bathrooms'; strUnit: 'Rooms'),     //8
                (adjID: aaGLArea; adjType: 'Gross Living Area'; strUnit: 'SqFt'), //9
                (adjID: aaGBArea; adjType: 'Gross Building Area'; strUnit: 'SqFt'), //10
                (adjID: aaBasement; adjType: 'Basement Area'; strUnit: 'SqFt'),     //11
                (adjID: aaBsmtFinArea; adjType: 'Bsmt Finished Area'; strUnit: 'SqFt'),    //12
                //the same cell (ID: 1008) hase 2 diffrent adjustment items
                (adjID: aaRmsBelow; adjType: 'Rooms Below Grade'; strUnit: 'Rooms'), //13
                (adjID: aaRmsBelow; adjType: 'Baths Below Grade'; strUnit: 'Rooms'), //14
                (adjID: aaGarages; adjType: 'Car Storage'; strUnit: 'Cars'),         //15
                (adjID: aaPorches; adjType: 'Porches, Decks'; strUnit: 'Prch, Deck'), //16
                (adjID: aaFireplaces; adjType: 'Fireplaces'; strUnit: 'Fireplaces'),  //17
                (adjID: aaPools; adjType: 'Pools'; strUnit: 'Pools'),                 //18
                (adjID: aaOther; adjType: 'Other'; strUnit: 'Number'));               //19


type
  TCellAdjustList = class;          //froward declaration

  // Individual cell auto adjustmeent item
  // The key is the KindID value which associates it with a cell ID
  TCellAdjustItem = class(TObject)
    FOwner: TCellAdjustList;
    FKindID: Integer;              // ID for sync'ing with cells
    FName: string;                 // Descriptive name
    FActive: Boolean;              // Auto Adjustment is active
    FFactor: Double;               // Value to multiply difference
    FLimit: Double;                // Difference threshold on adjustment
    FUnits: string;                // ID of Units (not used for now)
    FCalcMode: Integer;             //$ value or % of Sale Price
    FUseReg: Boolean;              //use regression factor value
    FRegFactor: Double;            //regression factor value
    constructor Create(AOwner: TCellAdjustList);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream; vers: Integer);
    function GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double; virtual;
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; virtual;
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); virtual;
    function GetAdjustValue(ADoc: TComponent; SStr, CStr, PStr:String; XID: Integer; var bValidValue: Boolean): Double;
    property AdjKind: Integer read FKindID write FKindID;
  end;

  TCellAdjustQuality = class(TCellAdjustItem)
    function GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double; override;
  end;

  TCellAdjustAge = class(TCellAdjustItem)
    function GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double; override;
  end;

  TCellAdjustCondition = class(TCellAdjustItem)
    function GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double; override;
  end;

  TCellAdjustRooms = class(TCellAdjustItem)
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); override;  //chg source cell
  end;

  TCellAdjustDate  = class(TCellAdjustItem)
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; override;
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); override;  //chg source cell
  end;

  TCellAdjustSite  = class(TCellAdjustItem)
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; override;   //chg Acres to sqft
  end;

  // The object list that holds all the individual cell adjustment items
  // This is the guy that saves to the report, save the list and loads to editor
  TCellAdjustList = class(TObjectList)
  private
    FListPath: String;     //name of list so we can compare to available lists
    function Get(Index: Integer): TCellAdjustItem;
    procedure Put(Index: Integer; const Value: TCellAdjustItem);
    procedure SetPath(const Value: String);
  public
    FRoomSumAdj: Boolean;
    FAdjustDateByDay: boolean;
    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
    procedure ReadFromStreamVers1(Stream: TStream);
    procedure ReadFromStreamVers2_5(Stream: TStream; vers: Integer);
    procedure ReadFromStreamVers(Stream: TStream;vers: Integer);
    procedure SaveToFile(const FileName: String);
    procedure LoadFromFile(const FileName: String);
    procedure ReadFromGrid(AGrid: TTsGrid);
    procedure WriteToGrid(AGrid: TTsGrid; IsUAD: Boolean);
    procedure Assign(Source: TCellAdjustList);
    procedure Save;
    procedure SaveAs;
    function AdjustmentIsActive(AKind: Integer; var index: Integer): Boolean;
    function GetItemIndexByName(itemName: String): Integer;
    property Adjuster[Index: Integer]: TCellAdjustItem read Get write Put; default;
    property Path: String read FListPath write SetPath;
  end;

  // This is the editor for the adjustment lists
  TAdjustments = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    LeftPanel: TPanel;
    topPanel: TPanel;
    btnApply: TButton;
    cbxSaveDefault: TCheckBox;
    cmbxSelectList: TComboBox;
    btnSaveList: TButton;
    cbxSumRoomAdj: TCheckBox;
    btnDelete: TButton;
    cbxAdjustbyDay: TCheckBox;
    AdjGrid: TtsGrid;
    Splitter1: TSplitter;
    MktImage: TImage;
    procedure btnApplyClick(Sender: TObject);
    procedure cmbxSelectListChange(Sender: TObject);
    procedure btnSaveListClick(Sender: TObject);
    procedure AdjGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdjGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure AdjGridKeyPress(Sender: TObject; var Key: Char);
    procedure sbxSumRoomAdjClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbxAdjustbyDayClick(Sender: TObject);
  private
    FNeedDocSave: Boolean;
    FListModified: Boolean;
    FAdjList: TCellAdjustList;
    FDoc: TComponent;
    FCompGrid: TtsGrid;
    FAdjItem:  TCellAdjustItem;
    procedure InitGridCombos;
    function GetRegressionMostLikelyValue(i:Integer):String;
    procedure CalcAdjustmentForAllComps(i: Integer; aFactor: Double;AdjItem: TCellAdjustItem);
    function getCompRowbyAdjustItem(AdjItem: TCellAdjustItem):Integer;

  public
    FRegression : TComponent;
    FCompSelection: TComponent;
    FImportMLS  : Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadDocumentList;
    procedure InitialAdjustments(IsUAD: Boolean);
    procedure LoadAvaliableLists;
    procedure LoadAdjustmentFile(AListName: String);
    procedure InitTool(ADoc: TComponent);
    procedure ReAdjustAllComparables(ADoc: TObject);
  end;


  function IsRoomAdjKind(adjID: Integer): Boolean;
  function IsDateOfSaleAdjKind(adjID: Integer): Boolean;
  function IsSiteAreaAdjKind(adjID: Integer): Boolean;
  function IsBathroomAdjKind(adjID: Integer): Boolean;
  function IsRmsBelowAdjKind(adjID: Integer): Boolean;
  function IsAreaBelowAdjKind(adjID: Integer): Boolean;
  function IsCarStorageAdjKind(adjID: Integer): Boolean;
  function isRoomAdjSumOnly(doc: TComponent): Boolean;
  function DoRoomAdjustment(SStr, CStr, PStr: String; doc: TComponent; AdjList: TCellAdjustList):String;
  function IsRoomAdjustmentsActive(AdjList: TCellAdjustList): Boolean;
  function DoBsmtAreaAdjustment(SStr, CStr, PStr: String; doc: TComponent; AdjList:TCellAdjustList):String;
  function IsAdjRowActive(ADoc: TObject; adjID: Integer): Boolean;
  function DoRoomsBelowGradeAdjustment(SStr, CStr, PStr: String; doc: TComponent; AdjList: TCellAdjustList):String;

  //for invoking from cells outside of the grid, for example subject sale date cell
  function FindAdjustmentIndex(adjList: TCellAdjustList; searchRec: Integer): Integer;
  function GetAdjustmentType(cellID: Integer): Integer;




implementation

{$R *.DFM}

Uses
  DateUtils, StrUtils,
  UContainer, UCell, UStatus, UFileGlobals, UMath, UUADUtils, UMain, uRegression,
  UCompSelection;

Const
  sNoListSelected = '- No Adjustment List Selected -';


{ TAutoCellAdjustEditor }

constructor TAdjustments.Create(AOwner: TComponent);
begin
  FImportMLS := False;
  inherited Create(AOwner);    //github 178
  FDoc := Main.ActiveContainer;

  FNeedDocSave := False;
  FListModified := False;
  InitGridCombos;
  LoadAvaliableLists;     //whats available (previous files)
  LoadDocumentList;       //load the containers adj list

  if isRoomAdjSumOnly(AOwner) then
    begin
      cbxSumRoomAdj.Checked := True;
      cbxSumRoomAdj.Enabled := False; //it always checked, user can not change the state
    end;
  // Make the checkbox invisible for UAD reports - this feature is ignored
  cbxAdjustbyDay.Visible := (not TContainer(Owner).UADEnabled);
end;

destructor TAdjustments.Destroy;
begin
  if assigned(FAdjList) then
    FAdjList.Free;

  inherited;
end;

procedure TAdjustments.LoadDocumentList;
var
  n: Integer;
  lName: String;
  isDefault: Boolean;
begin
  // Initialize the grid to its default settings
  InitialAdjustments(TContainer(Owner).UADEnabled);                  //initial the settings
  //load the adjustments from the doc
  FAdjList := TCellAdjustList.Create(True);
  if owner <> nil then
    FAdjList.Assign(TCellAdjustList(TContainer(Owner).docCellAdjusters));

  //if there were any, load and give user feedback
  if FAdjList.count > 0 then
    begin
      FAdjList.WriteToGrid(AdjGrid, TContainer(Owner).UADEnabled);         //display what came in
      cbxSumRoomAdj.Checked := FAdjList.FRoomSumAdj;
      cbxAdjustbyDay.Checked := FAdjList.FAdjustDateByDay;
      //a path is there is the default was loaded
      lName := GetNameOnly(FAdjList.FListPath); //was there a name
      if length(lName)>0 then
        begin
          n := cmbxSelectList.Items.IndexOf(lName);
          if n > -1 then
            cmbxSelectList.Text := lName;     //### maybe should load here

          isDefault := (length(FAdjList.FListPath)>0) and (comparetext(FAdjList.FListPath, appPref_AutoAdjListPath)=0);
          cbxSaveDefault.checked := isDefault;
        end;
    end;
  if isRoomAdjSumOnly(Owner) then
    FAdjList.FRoomSumAdj := True;
end;

procedure TAdjustments.LoadAvaliableLists;
var
  folderPath: String;
  list: TStrings;
begin
  if FindLocalSubFolder(appPref_DirLists, dirAdjustments, folderPath, True) then
    begin
	    cmbxSelectList.ItemIndex := -1;
      cmbxSelectList.Text := sNoListSelected;   //'- No Adjustment List Selected -';
      List := GetListsInFolder(folderPath,'*.lst');
      try
        cmbxSelectList.Items.Assign(List);
      finally
        List.free;
      end;
    end;
end;

procedure TAdjustments.LoadAdjustmentFile(AListName: String);
var
  folder, filePath: String;
begin
  if FindLocalSubFolder(appPref_DirLists, dirAdjustments, folder, True) then
    begin
      filePath := IncludeTrailingPathDelimiter(folder) + AListName + '.lst';
      FAdjList.Path := filePath;
      FAdjList.WriteToGrid(AdjGrid, TContainer(Owner).UADEnabled);
      cbxSumRoomAdj.Checked := FAdjList.FRoomSumAdj or IsRoomAdjSumOnly(Owner);
      cbxAdjustbyDay.Checked := FAdjList.FAdjustDateByDay;
      FListModified := False;
      FNeedDocSave := True;

      //check / uncheck the checkbox
      cbxSaveDefault.checked := (compareText(filePath, appPref_AutoAdjListPath)= 0);
    end;
end;

procedure TAdjustments.btnApplyClick(Sender: TObject);
begin
  FAdjList.ReadFromGrid(AdjGrid);                     //get the changes
  FAdjList.FRoomSumAdj := cbxSumRoomAdj.Checked;
  FAdjList.FAdjustDateByDay := cbxAdjustbyDay.Checked;
  if FListModified then
    begin
      if length(FAdjList.Path) > 0 then
        begin
          if OK2Continue('Do you want to save the adjustment changes to preference file '+GetNameOnly(FAdjList.Path)+' ?') then
            FAdjList.Save;
        end;
    end;

  if cbxSaveDefault.Checked then
    begin
      if (length(FAdjList.Path) = 0) then
        begin
          ShowNotice('Please specify a name for the default list of adjustments so they can be used in new reports.');
          FAdjList.SaveAs;
        end;
      if length(FAdjList.FListPath) > 0 then             //if user did not cancel
        appPref_AutoAdjListPath := FAdjList.FListPath;   //make the path the default
    end;

  //save to doc here incase we gave list a name, doc will keep during session
  if Owner <> nil then
    begin
      TCellAdjustList(TContainer(Owner).docCellAdjusters).Assign(FAdjList);      //save to the report
      TContainer(Owner).docDataChged := FListModified or FNeedDocSave;        //make sure its saved
    end;
  ReAdjustAllComparables(TContainer(FDoc));
end;

procedure TAdjustments.btnSaveListClick(Sender: TObject);
var
  listName: String;
begin
  FAdjList.ReadFromGrid(AdjGrid);      //get the changes
  FAdjList.FRoomSumAdj := cbxSumRoomAdj.Checked;
  FAdjList.FAdjustDateByDay := cbxAdjustbyDay.Checked;
  FAdjList.SaveAs;                         //do a save as
  FListModified := False;
  FNeedDocSave := True;

  //display in selection list
  listName := GetNameOnly(FAdjList.FListPath);
  if cmbxSelectList.Items.IndexOf(listName) < 0 then
    cmbxSelectList.Items.add(listName);
  cmbxSelectList.text := listName;
end;

procedure TAdjustments.cmbxSelectListChange(Sender: TObject);
begin
  if cmbxSelectList.ItemIndex <> -1 then
    begin
      LoadAdjustmentFile(cmbxSelectList.Text);
      InitialAdjustments(TContainer(FDoc).UADEnabled);
    end;
end;


function TAdjustments.GetRegressionMostLikelyValue(i:Integer):String;
var
  aRegression: TRegression;
begin
  result := '';
  aRegression := TRegression(FRegression);
  if aRegression = nil then exit;

  case i of
    rowAdjSaleDate:  result := aRegression.tsGrid_Adj_Component.Cell[2, cSalesDate];
    rowAdjSite:      result := aRegression.tsGrid_Adj_Component.Cell[2,cSiteArea];
    rowAdjGLA:       result := aRegression.tsGrid_Adj_Component.Cell[2,cGLA];
    rowAdjBasement:  result := aRegression.tsGrid_Adj_Component.Cell[2,cBsmtArea];
    rowAdjAge:  result := aRegression.tsGrid_Adj_Component.Cell[2,cYearBuilt];
  end;
  if pos('insuf', LowerCase(result)) > 0 then
    result := '';
end;


procedure TAdjustments.InitialAdjustments(IsUAD: Boolean);
var
  i: Integer;
begin
  with AdjGrid do
    begin
      rows := MaxAdjustments;
      for i:= 1 to MaxAdjustments do
        begin
          Cell[colAdjID,i] := AvailAdjustments[i].adjID;
          if not FImportMLS then
            Cell[colAdjActive,i] := cbUnchecked;
          Cell[colAdjType,i] := AvailAdjustments[i].adjType;
          if not FImportMLS then
            Cell[colAdjRate,i] := 0;
          Cell[colAdjMode,i] :=  Col[colAdjMode].Combo.ComboGrid.Cell[1,adjModeAbs];
          Cell[colAdjUnits,i] := AvailAdjustments[i].strUnit;
          cell[colAdjMindiff,i] := 0;
          if assigned(TRegression(FRegression)) then
            begin
              Cell[colRegAdj, i] := GetRegressionMostLikelyValue(i);
              if GetStrValue(cell[colRegAdj, i]) <> 0 then
                cell[colUseReg, i] := cbChecked
              else
                cell[colUseReg, i] := cbUnchecked;
            end
          else
            begin
              Cell[colUseReg, i] := cbUnchecked;
              Cell[colRegAdj, i] := '';
            end;
        end;
    end;
end;

//Handles key events
procedure TAdjustments.AdjGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  FListModified := True;
end;

procedure TAdjustments.AdjGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ((Key in [#08,#13,'0'..'9','.','-','+']) or (Ord(Key) = VK_DELETE)) then
    key := #0;
end;


//handles checking the activate checkboxes
procedure TAdjustments.AdjGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if DataColDown = colAdjActive then
    begin
      FListModified := True;

      //toggle Total Rooms and Bedrooms - only one field for adjustment
      if (DataRowDown = rowAdjTtRooms) and (AdjGrid.Cell[colAdjActive,rowAdjTtRooms] = cbChecked) then
        if AdjGrid.Cell[colAdjActive,rowAdjBdRooms] = cbChecked then AdjGrid.Cell[colAdjActive,5] := cbUnChecked;
      if (DataRowDown = rowAdjBdRooms) and (AdjGrid.Cell[colAdjActive,rowAdjBdRooms] = cbChecked) then
        if AdjGrid.Cell[colAdjActive,rowAdjTtRooms] = cbChecked then AdjGrid.Cell[colAdjActive,rowAdjTtRooms] := cbUnChecked;
    end;
end;

procedure TAdjustments.InitGridCombos;
begin
  with AdjGrid.Col[colAdjMode].Combo.ComboGrid do
    begin
      DropDownCols := 1;
      DropDownRows := length(adjCalcModes);
      Cell[1,adjModeAbs] := adjCalcModes[adjModeAbs];
      Cell[1,adjModePercents] := adjCalcModes[adjModePercents];
    end;

  AdjGrid.CellReadOnly[colAdjUnits,rowAdjsite] := roOff;
  AdjGrid.CellButtonType[colAdjUnits,rowAdjsite] := btCombo;
  AdjGrid.AssignCellCombo(colAdjUnits,rowAdjsite);
  AdjGrid.CellCombo[colAdjUnits,rowAdjsite].DropDownStyle := ddDropDownList;
  with AdjGrid.CellCombo[colAdjUnits,rowAdjsite].ComboGrid do
    begin
      StoreData := True;
      DropDownCols := 1;
      DropDownRows := length(adjSiteUnits);
      Cols := 1;
      Rows := length(adjSiteUnits);
      Cell[1,adjSiteSqft] := adjSiteUnits[adjSiteSqft];
      Cell[1,adjSiteAcres] := adjSiteUnits[adjSiteAcres];
    end;

end;

{ TCellAdjustAge }
{have to override age, because its adj is opposite of others}
function TCellAdjustAge.GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double;
var
  VR: Double;
begin
  result := 0;
  if (FFactor <> 0) then  {and (SubVal <>0) and (CmpVal <>0)}
    begin
      If (CmpVal > YearCutOff) and (SubVal > YearCutOff) then
        VR := (CurrentYear - CmpVal) - (CurrentYear - SubVal)     //get the correct +/- for year built entries
      else
        VR := CmpVal - SubVal;
      if Abs(VR) > FLimit then
        case FCalcMode of
          adjModeAbs:
            result := VR * FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR * FFactor * CmpPrice / 100;
        end;
    end;
end;

{ TCellAdjustCondition }
{have to override age, because its adj is opposite of others}
function TCellAdjustCondition.GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double;
var
  VR: Double;
begin
  result := 0;
  if (FFactor <> 0) then
    begin
      VR := CmpVal - SubVal;
      if Abs(VR) > FLimit then
        case FCalcMode of
          adjModeAbs:
            result := VR * FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR * FFactor * CmpPrice / 100;
        end;
    end;
end;

{ TCellAdjustQuality }
{have to override age, because its adj is opposite of others}
function TCellAdjustQuality.GetAdjustment(SubVal, CmpVal, CmpPrice: Double): Double;
var
  VR: Double;
begin
  result := 0;
  if (FFactor <> 0) then
    begin
      VR := CmpVal - SubVal;
      if Abs(VR) > FLimit then
        case FCalcMode of
          adjModeAbs:
            result := VR * FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR * FFactor * CmpPrice / 100;
        end;
    end;
end;

{ TCellAdjustRooms }

procedure TCellAdjustRooms.AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID);
begin
  inherited AdjustPair(ADoc,SCell, CCell, ACell,PCell);
end;

{ TCellAdjustDate }

//need to switch SCell from grid to effective data somewhere in report
procedure TCellAdjustDate.AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID);
var
  Cell: TBaseCell;
begin
  Cell := TContainer(ADoc).GetCellByID(1132);
  SCell := cell.UID;
  inherited AdjustPair(ADoc,SCell, CCell, ACell,PCell);
end;

//adjust for dates - months
function TCellAdjustDate.CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
  CellXID: Integer; IsUAD: Boolean=False): String;
var
  effDate, saleDate: TDateTime;
  periods, sign: Double;
  mo, dy, yr: Integer;
  Price: Double;

   function CalcUADDate(s_c_Date: String): TDateTime;
  var
    PosDate: Integer;
    sMo, sYr: String;
  begin
    Result := 0;
    if s_c_Date <> 'Active' then
      begin
        PosDate := Pos('c', s_c_Date);
        if PosDate = 0 then
          PosDate := Pos('s', s_c_Date);
        if (PosDate > 0)  then
          begin
            try
              sMo := Copy(s_c_Date, Succ(PosDate), 2);
              sYr := Copy(s_c_Date, (PosDate + 4), 2);
              if (Trim(sMo) <> '') and (Trim(sYr) <> '') then
                Result := StrToDate(sMo + '/01/' + sYr);
            except  end;
          end
        else if s_c_Date <> '' then
          begin
            try
              result := strToDate(s_c_Date);
            except end;
          end;
      end;
  end;

begin
  result := '';
  try
    effDate := 0;
    if ParseDateStr(SubVal, mo, dy, yr) then
      effDate := EncodeDate(yr, mo, dy);

    saleDate := 0;
    if IsUAD and IsDateOfSaleAdjKind(CellXID) then
      saleDate := CalcUADDate(CmpVal)
    else
      if ParseDateStr(CmpVal, mo, dy, yr) then
        saleDate := EncodeDate(yr, mo, dy);
    Price := GetFirstValue(CmpPrice);
    if (effDate<>0) and (saleDate<>0) then
      begin
        sign := 1.0;
        periods := Round(MonthSpan(effDate, saleDate));
        if saleDate > effDate then Sign := -1.0;
        if (not IsUAD) and FOwner.FAdjustDateByDay and
           (Abs(periods) >= FLimit) and (FFactor <> 0) then
          case FCalcMode of
            adjModeAbs:
              result := Format('%.0n',[Abs(effDate-SaleDate) * (FFactor*12/365)* sign]);
            adjModePercents:
              if Price > 0 then
                 result := Format('%.0n',[Abs(effDate-SaleDate) * (FFactor*12/365)* sign * Price / 100])
          end
        else
          if (Abs(periods) > FLimit) and (FFactor <> 0) then
            case FCalcMode of
              adjModeAbs:
                result := Format('%.0n',[periods * FFactor* sign]);
              adjModePercents:
                if Price > 0 then
                  result := Format('%.0n',[periods * FFactor* sign * Price / 100]);
{JDB -Original Adjustment (Rounded the month and cause funcky adjustments
                  result := Format('%.0n',[periods * FFactor* sign * Price / 100]);}
            end;
      end;
  except
    result := '';
  end;
end;


{ TCellAdjustSite }

function TCellAdjustSite.CalcAdjustment(const SubVal, CmpVal,cmpPrice: String;
  CellXID: Integer; IsUAD: Boolean=False): String;
var
  V1, V2,Price: Double;
  IsUnitAcres: Boolean;

  function IsAcres(S: String): Boolean;
  begin
    S := Uppercase(S);
    result := (POS('AC',S)>0) or (POS('ACRE',S)>0);
  end;

begin
  try
    if CompareText(FUnits,adjSiteUnits[adjSiteAcres]) = 0 then
      isUnitAcres := True
    else
      isUnitAcres := False;

    V1 := GetFirstValue(subVal);
    if isUnitAcres then
      begin
        if not IsAcres(subVal) then
          V1 := V1 / 43560.0;       //convert to acres
      end
    else
      if IsAcres(subVal) then
        V1 := V1 * 43560.0;       //convert to sqft

    V2 := GetFirstValue(cmpVal);
    if isUnitAcres then
      begin
        if not IsAcres(cmpVal) then
          V2 := V2 / 43560.0;       //convert to acres
      end
    else
      if IsAcres(cmpVal) then
        V2 := V2 * 43560.0;       //convert to sqft

    Price := GetFirstValue(cmpPrice);
    result := Format('%.0n',[GetAdjustment(V1, V2,Price)]);
  except
    result := '';
  end;
end;



{ TCellAdjustItem }

constructor TCellAdjustItem.Create(AOwner: TCellAdjustList);
begin
  FOwner := AOwner;
end;

function TCellAdjustItem.GetAdjustValue(ADoc: TComponent; SStr,CStr,PStr: String; XID:Integer; var bValidValue: Boolean): Double;
var
  adjStr: String;
  doc: TContainer;
begin
  SStr := '';
  CStr := '';
  result := 0;
  doc := TContainer(ADoc);
//  SStr := GetCellString(doc, SCell);
//  CStr := GetCellString(doc, CCell);
//  PStr := GetCellString(doc, PCell);
  if (length(SStr) > 0) and (length(CStr) > 0) then
    begin
      adjStr := CalcAdjustment(SStr, CStr, PStr, XID, doc.UADEnabled);
      IsValidNumber(adjStr, result);
      bValidValue := True;
    end
  else
    bValidValue := False;
end;

procedure TCellAdjustItem.AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID);
var
  doc: TContainer;
  SStr, CStr, PStr,adjStr: String;
  cell: TBaseCell;
  adjVal: Double;
  realAdj: Boolean;

  {Moved it to procedure   DoRoomsBelowGradeAdjustment
  function GetCellContents: String;
  // This function's only purpose is to detect when the subject's basement is not
  //  blank and the room count cell is blank. If we're processing a UAD report
  //  then we need to assume that the total room count is zero and set the string
  //  accordingly. If not then automatic adjustments will not occur.
  var
    CellCur, CellPri: TBaseCell;
    UID: CellUID;
  begin
    Result := GetCellString(doc, SCell);
    if (ADoc as TContainer).UADEnabled then
      begin
        CellCur := doc.GetCell(SCell);
        if (CellCur <> nil) and (CellCur.FCellXID = 1008) and (Trim(CellCur.Text) = '') then
          begin
            UID := SCell;
            UID.Num := Pred(UID.Num);
            CellPri := doc.GetCell(UID);
            if Trim(CellPri.Text) <> '' then
              Result := '0';
          end;
      end;
  end;                 }

begin
  SStr := '';
  CStr := '';
  doc := TContainer(ADoc);
  //SStr := GetCellContents;
  SStr := GetCellString(doc, SCell);
  CStr := GetCellString(doc, CCell);
  PStr := GetCellString(doc, PCell);
  if (length(CStr)<>0) or (length(SStr)<>0) then //need at least 1 value to adjust
    begin
      realAdj := (length(CStr)>0) and (length(SStr)>0);
      if realAdj then
        adjStr := CalcAdjustment(SStr, CStr, PStr, doc.GetCell(CCell).FCellXID, doc.UADEnabled)
      else adjstr := '';
      Cell := doc.GetCell(ACell);
      if cell <> nil then
        if realAdj then  //real adj or adj needs updating
          begin
            if IsValidNumber(adjStr, adjVal) then
              adjStr := Cell.GetFormatedString(adjVal)
            else
              adjStr := '';
            if doc.UADEnabled then
              if CompareText(SStr,CStr) = 0 then
                adjStr := ''
              else
                if adjStr = '' then
                  adjstr := '0';
            Cell.LoadData(adjStr);
          end
        else
          Cell.LoadData(adjStr);
    end;
end;

function TCellAdjustItem.CalcAdjustment(const SubVal, CmpVal, CmpPrice: String;
  CellXID: Integer; IsUAD: Boolean=False): String;
var
  V1, V2, Price: Double;

  function CalcUADBaths(Baths: String): Double;
  var
    PosPer: Integer;
    HalfBaths: String;
  begin
    if (Baths = '0') or (Trim(Baths) = '') then
      Result := 0
    else
      begin
        PosPer := Pos('.', Baths);
        if PosPer > 0 then
          begin
            Result := StrToFloat(Copy(Baths, 1, Pred(PosPer)));
            HalfBaths := Copy(Baths, Succ(PosPer), Length(Baths));
          end
        else
          begin
            Result := StrToFloat(Baths);
            HalfBaths := '0';
          end;
        if Length(HalfBaths) > 0 then
          Result := Result + (GetValidInteger(HalfBaths) * 0.5);
      end;
  end;


  function CalcUADCarStorage(CarStorage: String): Double;
  const
    GAtt = 'ga';
    GDet = 'gd';
    GBin = 'gbi';
    CPrt = 'cp';
    Gar = 'g';
    Cvd = 'cv';
    Opn = 'op';
  var
    Cars: Integer;

    function SetParking(theStr, Str1, Str2, Str3, Str4: String): Integer;
    var
      Cntr: Integer;
      AStrNum: String;
    begin
      Result := 0;
      while theStr <> '' do
        begin
          AStrNum := GetFirstNumInStr(theStr, True, Cntr);
          if length(AStrNum) > 0 then                        //we have a numeric string
            begin
              theStr := Copy(theStr, Succ(Cntr), Length(theStr));
              if (Length(theStr) > 0) and (Length(Str1) > 0) and (Copy(theStr, 1, Length(Str1)) = Str1) then
                begin
                  Result := GetValidInteger(AStrNum);
                  theStr := Copy(theStr, (Pos(Str1, theStr) + Length(Str1)), Length(theStr));
                end
              else if (Length(theStr) > 0) and (Length(Str2) > 0) and (Copy(theStr, 1, Length(Str2)) = Str2) then
                begin
                  Result := Result + GetValidInteger(AStrNum);
                  theStr := Copy(theStr, (Pos(Str2, theStr) + Length(Str2)), Length(theStr));
                end
              else if (Length(theStr) > 0) and (Length(Str3) > 0) and (Copy(theStr, 1, Length(Str3)) = Str3) then
                begin
                  Result := Result + GetValidInteger(AStrNum);
                  theStr := Copy(theStr, (Pos(Str3, theStr) + Length(Str3)), Length(theStr));
                  theStr := '';
                end
              else if (Length(theStr) > 0) and (Length(Str4) > 0) and (Copy(theStr, 1, Length(Str4)) = Str4) then
                begin
                  Result := Result + GetValidInteger(AStrNum);
                  theStr := '';
                end
              else
                theStr := '';
            end
          else
            theStr := '';
        end;
    end;

  begin
    Result := 0;
    if (Uppercase(CarStorage) <> 'NONE') and (Trim(CarStorage) <> '') then
      begin
        Cars := Pos(GAtt, CarStorage) + Pos(GDet, CarStorage) + Pos(GBin, CarStorage);
        if Cars > 0 then // it's a 1004/2055 family form
          Result := SetParking(CarStorage, GAtt, GDet, GBin, CPrt)
        else
          begin
            Cars := Pos(Gar, CarStorage) + Pos(Cvd, CarStorage) + Pos(Opn, CarStorage);
            if Cars > 0 then // it's a 1073/1075 family form
              Result := SetParking(CarStorage, Gar, Cvd, Opn, '');
          end;
      end;
  end;

begin
  result := '';
  try
    {if isRmsBelowAdjKind(CellXID) then
      begin
        V1 := CalcRmsBelow(subVal, IsUAD);
        V2 := CalcRmsBelow(cmpVal, IsUAD);
      end
    else}if IsUAD then
      begin
        if isBathRoomAdjKind(CellXID) then
          begin
            V1 := CalcUADBaths(subVal);
            V2 := CalcUADBaths(cmpVal);
          end
        else if IsCarStorageAdjKind(CellXID) and (appPref_UADCarNDesignActive or (date >= StrToDate(CUADCarAndDesignEffDate))) then
          begin
            V1 := CalcUADCarStorage(subVal);
            V2 := CalcUADCarStorage(cmpVal);
          end
        else
          begin
            V1 := GetFirstValue(subVal);
            V2 := GetFirstValue(cmpVal);
          end
      end
    else
      begin
        V1 := GetFirstValue(subVal);
        V2 := GetFirstValue(cmpVal);
      end;
    Price := GetFirstValue(CmpPrice);
    if FFactor <> 0 then   //remove zeros
        result := Format('%.0n',[ GetAdjustment(V1, V2, Price) ]);
  except
    result := '';
  end;
end;

function TCellAdjustItem.GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double;
var
  VR: Double;
begin
  result := 0;
  if (FFactor <> 0) then  {and (SubVal <>0) and (CmpVal <>0)}
    begin
      VR := SubVal -CmpVal;
      if Abs(VR) > FLimit then
        case FCalcMode of
          adjModeAbs:
            result := VR * FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR * FFactor * CmpPrice / 100;
        end;
    end;
end;

procedure TCellAdjustItem.LoadFromStream(Stream: TStream; vers: Integer);
var
  calcMode: Integer;
begin
  FKindID := ReadLongFromStream(Stream);
  FName   := ReadStringFromStream(Stream);
  FActive := ReadBoolFromStream(Stream);
  FFactor := ReadDoubleFromStream(Stream);
  FLimit  := ReadDoubleFromStream(Stream);
  FUnits  := ReadStringFromStream(Stream);
  FCalcMode := adjModeAbs;
  if vers >= 3 then
    begin
      calcMode := ReadLongFromStream(Stream);
      if (calcMode >= Low(adjCalcModes)) and (calcMode >= high(adjCalcModes)) then
        FCalcMode := calcMode;
    end;
end;

procedure TCellAdjustItem.SaveToStream(Stream: TStream);
begin
  WriteLongToStream(FKindID, Stream);
  WriteStringToStream(FName, Stream);
  WriteBoolToStream(FActive, Stream);
  WriteDoubleToStream(FFactor, Stream);
  WriteDoubleToStream(FLimit, Stream);
  WriteStringToStream(FUnits, Stream);
  WriteLongToStream(FCalcMode,Stream);
end;


{ TCellAdjustList }

function TCellAdjustList.Get(Index: Integer): TCellAdjustItem;
begin
  result := TCellAdjustItem(Items[index]);
end;

procedure TCellAdjustList.Put(Index: Integer; const Value: TCellAdjustItem);
begin
  Items[index] := Value;
end;

procedure TCellAdjustList.SetPath(const Value: String);
var
  bOK: Boolean;
begin
  bOK := False;
  try
    if fileExists(Value) then
      begin
        FListPath := Value;
        LoadFromFile(FListPath);         //load in new
        bOK := True
      end;
  except
  end;
  if not bOK then
    begin
      Clear;
      FListPath := '';
    end;
end;


procedure TCellAdjustList.LoadFromFile(const FileName: String);
var
  fStream: TFileStream;
  GH: GenericIDHeader;
begin
  fStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      ReadGenericIDHeader(fStream, GH);
      ReadFromStream(fStream);
    except
      ShowNotice('Cannot read Auto Adjustments file "' + ExtractFileName(fileName) + '".');
    end;
  finally
    fStream.Free;
  end;
end;

procedure TCellAdjustList.ReadFromStreamVers(Stream: TStream; vers: Integer);
var
  i,N, KindID: Integer;
  CellAdjust: TCellAdjustItem;
begin
  N := ReadLongFromStream(Stream);
  FRoomSumAdj := False;
  FAdjustDatebyDay := False;
  if vers >= 3 then
    FRoomSumAdj := ReadBoolFromStream(Stream);
  for i := 0 to N-1 do                //read each item
    begin
      {need to create the right sub class}
      KindID := ReadLongFromStream(Stream);          //read the object kind
      Stream.Seek(-Sizeof(LongInt), soFromCurrent);  //back up to read whole object

      case KindID of
        aaDate:
          CellAdjust := TCellAdjustDate.Create(Self);
        aaSite:
          CellAdjust := TCellAdjustSite.Create(Self);
        aaConstQuality:
          CellAdjust := TCellAdjustQuality.Create(Self);
        aaAge:
          CellAdjust := TCellAdjustAge.Create(Self);
        aaCondition:
          CellAdjust := TCellAdjustCondition.Create(Self);
        aaTotalRms,
        aaBedrooms:
          CellAdjust := TCellAdjustRooms.Create(Self);
      else
        CellAdjust := TCellAdjustItem.Create(Self);
      end;
      {now read the object using the correct class}
      try
        CellAdjust.LoadFromStream(Stream,vers);
      finally
        Add(CellAdjust);
      end;
    end;
    if vers >= 4 then
      FAdjustDatebyDay := ReadBoolFromStream(Stream);
end;

procedure TCellAdjustList.ReadFromStreamVers1(Stream: TStream);
var
  CellAdjust: TCellAdjustItem;
begin
  ReadFromStreamVers(Stream,1);

  //add the Gross Building Area adjustment
  CellAdjust := TCellAdjustItem.Create(Self);
  CellAdjust.FKindID := aaGBArea;
  CellAdjust.FName   := 'Gross Building Area';
  CellAdjust.FActive := False;
  CellAdjust.FFactor := 0;
  CellAdjust.FLimit  := 0;
  CellAdjust.FUnits  := 'SqFt';
  CellAdjust.FCalcMode := adjModeAbs;
  Insert(7, CellAdjust);
end;

procedure TCellAdjustList.ReadFromStreamVers2_5(Stream: TStream; vers: Integer);
var
  CellAdjust: TCellAdjustItem;
begin
  ReadFromStreamVers(Stream,vers);

  if Count > 8 then  // make sure there is sufficient room to insert the 3 new rows
  begin
    //version 6 additions
    //add the Basement Finished Area adjustment
    CellAdjust := TCellAdjustItem.Create(Self);
    CellAdjust.FKindID := aaBsmtFinArea;
    CellAdjust.FName   := 'Bsmt Finished Area';
    CellAdjust.FActive := False;
    CellAdjust.FFactor := 0;
    CellAdjust.FLimit  := 0;
    CellAdjust.FUnits  := 'SqFt';
    CellAdjust.FCalcMode := adjModeAbs;
    Insert(9, CellAdjust);

    //add the Condition adjustment
    CellAdjust := TCellAdjustItem.Create(Self);
    CellAdjust.FKindID := aaCondition;
    CellAdjust.FName   := 'Condition';
    CellAdjust.FActive := False;
    CellAdjust.FFactor := 0;
    CellAdjust.FLimit  := 0;
    CellAdjust.FUnits  := 'C#';
    CellAdjust.FCalcMode := adjModeAbs;
    Insert(3, CellAdjust);

    //add the Construction Quality adjustment
    CellAdjust := TCellAdjustItem.Create(Self);
    CellAdjust.FKindID := aaConstQuality;
    CellAdjust.FName   := 'Construction Quality';
    CellAdjust.FActive := False;
    CellAdjust.FFactor := 0;
    CellAdjust.FLimit  := 0;
    CellAdjust.FUnits  := 'Q#';
    CellAdjust.FCalcMode := adjModeAbs;
    Insert(2, CellAdjust);
  end;
end;

procedure TCellAdjustList.ReadFromStream(Stream: TStream);
var
  version: Integer;
begin
  Clear;
  version := ReadLongFromStream(Stream);    //read how many items we have
  if (version = 14) then                    //this is original version =1
    begin
      Stream.seek(-sizeOf(LongInt), soFromCurrent);   //backup, vers1 did not have a versionID
      ReadFromStreamVers1(Stream);
    end
  else if ((version >= 2) and (version <= 5)) then    //versions 2-5
    ReadFromStreamVers2_5(stream, version)
  else
    ReadFromStreamVers(stream,version);              //versions 6+
end;

//this part is saved in the container or file
procedure TCellAdjustList.WriteToStream(Stream: TStream);
var
  i: Integer;
begin
  //added in 2.4.1
  WriteLongToStream(cAutoAdjVersion, stream); //write version #

  WriteLongToStream(Count, Stream);           //write how many items we have
  WriteBoolToStream(FRoomSumAdj,Stream);
  for i := 0 to count-1 do                    //write each item
    Adjuster[i].SaveToStream(Stream);
  WriteBoolToStream(FAdjustDatebyDay,Stream);
end;

procedure TCellAdjustList.SaveToFile(const FileName: String);
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create(FileName, fmCreate);
  try
    WriteGenericIDHeader(fStream, cLISTFile);
    WriteToStream(fStream);
  finally
    fStream.Free;
  end;
end;

procedure TCellAdjustList.Save;
begin
  try
    SaveToFile(Path);
  except
    ShowNotice('There is a problem saving the list of auto-adjustements.');
  end;
end;

procedure TCellAdjustList.SaveAs;
var
  fPath: String;
  fName: String;
  Ok: Boolean;
begin
  fName := '';
  if FindLocalSubFolder(appPref_DirLists, dirAdjustments, fPath, True) then
    fName := GetAName('Save List of Adjustments as...', '');

  if length(fName) > 0 then   //have name, try to save
    begin
      fPath := IncludeTrailingPathDelimiter(fPath) + fName + '.lst';
      OK := not FileExists(fPath);
      if not OK then
        Ok := OK2Continue('"'+fName+'" already exists. Do you want to overwrite this auto adjustment file?');

      if OK then
        begin
          FListPath := fPath;
          Save;
        end;
    end;
end;

//read the data from the editor grid
procedure TCellAdjustList.ReadFromGrid(AGrid: TTsGrid);
var
  i, Kind: Integer;
  CellAdjust: TCellAdjustItem;
begin
  Clear;    //remove previous adjustment item
  with AGrid do
    for i := 1 to Rows do
      begin
        kind := Cell[colAdjId,i];
        case kind of
          aaDate:
            CellAdjust := TCellAdjustDate.Create(Self);
          aaSite:
            CellAdjust := TCellAdjustSite.Create(Self);
          aaConstQuality:
            CellAdjust := TCellAdjustQuality.Create(Self);
          aaAge:
            CellAdjust := TCellAdjustAge.Create(Self);
          aaCondition:
            CellAdjust := TCellAdjustCondition.Create(Self);
          aaTotalRms,
          aaBedrooms:
            CellAdjust := TCellAdjustRooms.Create(Self);
        else
          CellAdjust := TCellAdjustItem.Create(Self);      //use default
        end;

        CellAdjust.FKindID  := Cell[colAdjId,i];
        CellAdjust.FActive  := (Cell[colAdjActive,i] = cbChecked);

        if CellAdjust.FActive then //turn off blank entries
          CellAdjust.FActive := (Length(Cell[colAdjRate,i])>0) and (Length(cell[colAdjMindiff,i])>0);

        //catch the blanks - no blanks - has conversion Null to Double problem
        if length(Cell[colAdjRate,i])=0 then Cell[colAdjRate,i] := '0';
        if length(Cell[colAdjMindiff,i])=0 then Cell[colAdjMinDiff,i] := '0';

        CellAdjust.FName    := Cell[colAdjType,i];
        CellAdjust.FFactor  := Cell[colAdjRate,i];
        CellAdjust.FUnits   := Cell[colAdjUnits,i];
        CellAdjust.FLimit   := Cell[colAdjMindiff,i];
        CellAdjust.FCalcMode := adjModeAbs;
        if CompareText(Cell[colAdjMode,i],AdjCalcModes[adjModePercents]) = 0 then
          CellAdjust.FCalcMode := adjModePercents;
        CellAdjust.FUseReg     := Cell[colUseReg, i];
        if cell[colRegAdj, i] <> '' then
          CellAdjust.FRegFactor  := GetStrValue(Cell[colRegAdj, i]);

        Add(CellAdjust);
      end;
end;

//write the cells adjust values to the editor grid
procedure TCellAdjustList.WriteToGrid(AGrid: TTsGrid; IsUAD: Boolean);
var
  i, GridIdx: Integer;
  FoundIdx: Boolean;
  BsmtFinDone: Boolean;
begin
  // The BsmtFinDone variable is used when processing adjustment files prior
  //  to version 6. In these versions the Basement Area row was used for both
  //  total area and finished area (when the now removed checkbox was checked).
  BsmtFinDone := False;
  with AGrid do
    begin
      // Scan through each of the adjuster rows and find the match in the current
      //  list of available adjustments. When found, populate the grid cells with
      //  the values from the adjuster. Now, prior versions and any adjuster that
      //  does not have a comparable row or a misaligned row in the available list
      //  will NOT cause the display list to be incorrect.
      for i := 1 to Count do
        begin
          GridIdx := 0;
          FoundIdx := False;
          repeat
            GridIdx := Succ(GridIdx);
            if (Adjuster[i-1].FName = AvailAdjustments[GridIdx].adjType) then
              FoundIdx := True;
          until FoundIdx or (GridIdx = AGrid.Rows);
          if FoundIdx then
            begin
              if (not (BsmtFinDone and (GridIdx = rowAdjBsmtFinArea))) then
              begin
                if Adjuster[i-1].FActive then
                  Cell[colAdjActive,GridIdx] := cbChecked
                else
                  Cell[colAdjActive,GridIdx] := cbUnchecked;
                Cell[colAdjRate,GridIdx] := Adjuster[i-1].FFactor;
                Cell[colAdjMode,GridIdx] := Col[colAdjMode].Combo.ComboGrid.Cell[1,Adjuster[i-1].FCalcMode];
                Cell[colAdjUnits,GridIdx] := Adjuster[i-1].FUnits;
                Cell[colAdjMindiff,GridIdx] := Adjuster[i-1].FLimit;

                //leave it unchecked and EMPTY for regression value
                Cell[colUseReg,GridIdx] := cbUnChecked;
                Cell[colRegAdj,GridIdx] := '';

                // We need to capture when we've processed the basement finished area
                //  so it's not processed a 2nd time. This can occur when processing
                //  adjustment files prior to version 6.                                                  
                if (not BsmtFinDone) then
                  if (GridIdx = rowAdjBsmtFinArea) then
                    BsmtFinDone := True;
              end
            end;
      end;

      //need to toggle totalRooms, bedroom cells for now
      if (Cell[colAdjActive,rowAdjTtRooms]=cbChecked) and (Cell[colAdjActive,rowAdjBdRooms]=cbChecked) then
        Cell[colAdjActive,rowAdjTtRooms] := cbUnchecked;
    end;
end;

procedure TCellAdjustList.Assign(Source: TCellAdjustList);
var
  i: Integer;
  CellAdjust: TCellAdjustItem;
begin
  Clear;      //get rid of current items
  FListPath := '';

  if Source <> nil then
    begin
      FListPath := Source.FListPath;
      FRoomSumAdj := Source.FRoomSumAdj;
      for i := 0 to Source.count-1 do
        begin
          //create the right sub class
          case Source.Adjuster[i].FKindID of
            aaDate:
              CellAdjust := TCellAdjustDate.Create(Self);
            aaSite:
              CellAdjust := TCellAdjustSite.Create(Self);
            aaConstQuality:
              CellAdjust := TCellAdjustQuality.Create(Self);
            aaAge:
              CellAdjust := TCellAdjustAge.Create(Self);
            aaCondition:
              CellAdjust := TCellAdjustCondition.Create(Self);
            aaTotalRms,
            aaBedrooms:
              CellAdjust := TCellAdjustRooms.Create(Self);
          else
            CellAdjust := TCellAdjustItem.Create(Self);
          end;

          CellAdjust.FKindID    := Source.Adjuster[i].FKindID;
          CellAdjust.FActive    := Source.Adjuster[i].FActive;
          CellAdjust.FName      := Source.Adjuster[i].FName;
          CellAdjust.FFactor    := Source.Adjuster[i].FFactor;
          CellAdjust.FUnits     := Source.Adjuster[i].FUnits;
          CellAdjust.FLimit     := Source.Adjuster[i].FLimit;
          CellAdjust.FCalcMode  := Source.Adjuster[i].FCalcMode;
          CellAdjust.FUseReg    := Source.Adjuster[i].FUseReg;
          CellAdjust.FRegFactor := Source.Adjuster[i].FRegFactor;
          //hack for changing the name of Building Area
          if CellAdjust.FKindID = aaGBArea then
            CellAdjust.FName := 'Gross Building Area';

          Add(CellAdjust);
        end;
    end;
    FAdjustDatebyDay := Source.FAdjustDatebyDay;
end;

function TCellAdjustList.AdjustmentIsActive(AKind: Integer; var index: Integer): Boolean;
begin
  result := False;      //assume no active adj for adjKind
  index := 0;
  while (index <= count-1) and (not result) do
    with Adjuster[index] do
      begin
        result := (Adjuster[index].FKindID = AKind) and Adjuster[index].FActive;
        if result then
          exit
        else
          inc(index);
      end;
end;

function TCellAdjustList.GetItemIndexByName(itemName: String):Integer;
var
  cnt: Integer;
begin
  result := -1;
  for cnt := 0 to count - 1 do
    if CompareText(itemName, Adjuster[cnt].FName) = 0 then
      result := cnt;
end;

procedure TAdjustments.sbxSumRoomAdjClick(Sender: TObject);
begin
  FListModified := True;
end;

function IsRoomAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 1041) or (adjId = 1042) or (adjId = 1043) or
            (adjId = 4002) or (adjId = 4003) or (adjId = 4004);  // REO listings
end;

function IsDateOfSaleAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 960);  // sales & listings
end;

//github 314
function IsSiteAreaAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 976); //sales & listings
end;

function IsBathroomAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 1043) or  // sales & listings
            (adjId = 1245) or  // rentals
            (adjId = 4004);    // REO listings
end;

function IsRmsBelowAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 1008) or
            (adjId = 4007);    // REO listings
end;

function IsAreaBelowAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 1006) or
            (adjId = 4006);    // REO listings
end;

function IsCarStorageAdjKind(adjID: Integer): Boolean;
begin
  result := (adjId = 1016) or  // sales & listings
            (adjId = 1245) or  // rentals
            (adjId = 4004);    // REO listings
end;

function FindAdjustmentIndex(adjList: TCellAdjustList; searchRec: Integer): Integer;
var
  adjRec, nRecs: Integer;
begin
  result := -1;
  if not assigned(adjList) then
    exit;
  nRecs := adjList.Count;
  for adjRec := 0 to nRecs - 1 do
    if  adjList.Adjuster[adjRec].FKindID = searchRec then
      break;
  if adjRec <= nRecs then
    result := adjRec;
end;


function IsRoomAdjSumOnly(doc: TComponent): Boolean;
var
  exceptListInd: Integer;
  FormListIndex: Integer;
  cont: TContainer;
begin
  result := False;
  if assigned(doc) then
    //result := not assigned(TContainer(doc).GetCellByID(TotBedRoomsAdjCellID));
    begin
      cont := TContainer(doc);
      for exceptListInd := 1 to length(SumOnlyRoomAdjForms) do
        begin
          for FormListIndex := 0 to  cont.docForm.Count - 1 do
            if cont.docForm.Forms[FormListIndex].FormID = SumOnlyRoomAdjForms[exceptListInd] then
              begin
                result := True;
                break;
              end;
            if result then
              break;
          end;
      end;
end;

function DoRoomAdjustment(SStr, CStr, PStr: String; doc: TComponent; AdjList: TCellAdjustList):String;
var
  rec, lstInd,adj : Integer;
  SCell,CCell,PCell,AdjCell,SumAdjCell: CellUID;
  adjValue,sumAdjValue: Double;
  adjItem: TCellAdjustItem;
  curCell: TBaseCell;
  bAdjValid: Boolean;
  bSumAdjValid: Boolean;
  adjStrValue: String;
begin
  result := '';
  if not isRoomAdjustmentsActive(adjList) then
    exit;
  bSumAdjValid := False;
  for rec := 1 to length(RoomAdjCellIDs) do
    begin
      sumAdjValue := 0;
      for adj := 1 to nRoomAdjTypes do   //total, bed, and bath rooms
        begin
          lstInd := FindAdjustmentIndex(adjList,RoomAdjCellIDs[1][adj]);
          if lstInd < 0 then
            continue;      //never happens: unknown adjustment type
          adjItem := adjList[lstInd];
          if adjItem.FActive then
            begin
              //subject value cell
//              if not grid.GetAdjustmentCell(0,RoomAdjCellIDs[rec][adj],SCell) then
//                continue;
              //comp value cell
//              if not grid.GetAdjustmentCell(cmpID,RoomAdjCellIDs[rec][adj],CCell) then
//                continue;
              //price cell
//              grid.GetAdjustmentCell(cmpID,947,PCell);

              adjValue := adjItem.GetAdjustValue(doc,SStr,CStr,PStr,adjItem.FKindID, bAdjValid);
              sumAdjValue := sumAdjValue + adjValue;
              //bSumAdjValid := bSumAdjValid and bAdjValid;
              if RoomAdjCellIDs[rec][adj + nRoomAdjTypes] > 0 then
                //if grid.GetAdjustmentCell(cmpID,RoomAdjCellIDs[rec][adj + nRoomAdjTypes],AdjCell)then
                 // if TContainer(doc).GetValidCell(AdjCell,curCell) then
                    if not adjList.FRoomSumAdj and bAdjValid
                          and not (Tcontainer(doc).UADEnabled and (adjValue = 0)) then //leave adjustment blank for UAD report
                      begin
                        //Fix to use the adjustment value to set the text on the adjustment cell
                        //curCell.LoadData(curCell.GetFormatedString(adjValue));
                        adjStrValue := Format('%.0n',[adjValue]);
                        result := adjStrValue;
                        //curCell.LoadData(adjStrValue);
                      end
                    else
                      result := ''; //curCell.SetText('');
               bSumAdjValid := bSumAdjValid or bAdjValid;
            end;
        end;
        if adjList.FRoomSumAdj then
          //if grid.GetAdjustmentCell(cmpId,RoomAdjCellIDs[rec][7],SumAdjCell) then
            if TContainer(doc).GetValidCell(SumAdjCell,curCell) then
              if bSumAdjValid
                    and not (Tcontainer(doc).UADEnabled and (sumAdjValue = 0)) then //leave adjustment blank for UAD report
                result := Format('%.0n',[sumAdjValue])
                //curCell.LoadData(curCell.GetFormatedString(sumAdjValue))
              else
                result := '';
                //curCell.LoadData('');
    end;
end;

//For room adjustment CellID and FKindID are not necessarily the same
//as was originally setup for auto adjustments
function GetAdjustmentType(cellID: Integer): Integer;
var
  row, col: Integer;
begin
  result := cellID;
  for row := 1 to length(RoomAdjCellIDs) do
    for col := 1 to nRoomAdjTypes do
      if RoomAdjCellIDs[row][col] = cellID then
        begin
          result := RoomAdjCellIDs[1][col];
          break;
        end;
end;

function isRoomAdjustmentsActive(AdjList: TCellAdjustList): Boolean;
var
  adj, lstInd: Integer;
  adjItem: TCellAdjustItem;
begin
  result := False;
  for adj := 1 to nRoomAdjTypes do   //total, bed, and bath rooms
    begin
      lstInd := FindAdjustmentIndex(adjList,RoomAdjCellIDs[1][adj]);
      if lstInd < 0 then
        continue;      //never happens: unknown adjustment type
      adjItem := adjList[lstInd];
      if adjItem.FActive then
        begin
          Result := True;
          break;
        end;
    end;
end;


function DoRoomsBelowGradeAdjustment(SStr, CStr, PStr:String; doc: TComponent; AdjList:TCellAdjustList):String;
const
  zeroRoomsBelowStr = '0rr0br0.0ba0o';
var
  SCell, CCell, PCell, AdjCell: CellUID;
  roomsBelowIndex, bathsBelowIndex: Integer;
  PrStr: String;
  BsmtStr: String;
  sbjRoomCnt, compRoomCnt: Integer;
  sbjBathCnt, compBathCnt: Double;
  adjIndex: Integer;
  adjItem: TCellAdjustItem;
  roomsAdjustment, bathsAdjustment, fullAdjustment: Double;
  curCell: TBaseCell;
  isAdjActive: Boolean;

//used only for UAD reports
//format uad string '%drr%dbr%d.%dba%do'
// where %d is # of rooms in the order: recriation, bedrooms, full bathrooms, half bathrooms, other
procedure ParseRoomsBelow( cellStr: String; var roomsCnt: Integer; var bathCnt: Double);
var
  rrPos, brPos, dotPos, baPos,oPos: Integer;
begin
  roomsCnt := 0;
  bathCnt := 0;
  if (length(trim(cellStr)) = 0) or (cellStr = '0') then
    exit;
  rrPos := Pos('rr', cellStr);
  brPos := PosEx('br', cellStr, rrPos);
  dotPos := PosEx('.', cellStr, brPos);
  baPos := PosEx('ba', cellStr, dotPos);
  oPos := PosEx('o', cellStr, baPos);
  if (rrPos = 0) or (brPos = 0) or (dotPos = 0) or (baPos = 0) or (oPos = 0) then
    exit;
  roomsCnt := StrToIntDef(Copy(cellStr,1,rrPos - 1),0) +  //recreation rooms
              StrToIntDef(copy(cellStr, rrPos + 2,brPos - (rrPos + 2)),0) +  //bed
              StrToIntDef(copy(cellStr, baPos + 2,oPos - (baPos + 2)),0); //other
  bathCnt := StrToIntDef(Copy(cellStr,brPos + 2, dotPos - (brPos + 2)),0) + //full bath
              0.5 * StrToIntDef(Copy(cellStr, dotPos + 1, baPos - (dotPos + 1)),0); //half bath

end;

begin
  result := '';
  if not assigned(adjList) or (adjList.Count = 0) then
    exit;
  if not TContainer(doc).UADEnabled then
    begin
      roomsBelowIndex := adjList.GetItemIndexByName('Rooms Below Grade');
      if roomsBelowIndex >= 0 then
        begin
          adjItem := adjList.Adjuster[roomsBelowIndex];
          if adjItem.FActive and (adjItem.FFactor > 0) then
            adjList.Adjuster[roomsBelowIndex].AdjustPair(doc,SCell,CCell,AdjCell,PCell);
        end;
    end
   else
    begin
      if length(trim(SStr)) = 0 then   //do adjustment even subject rooms below empty
        begin
          bsmtStr := '';
          //grid.GetSubject(aaBsmtFinArea,BsmtStr);
          //if length(BsmtStr) > 0 then
          //  SStr := zeroRoomsBelowStr;
        end;
      if length(trim(CStr)) = 0 then   //do adjustment even comp rooms below empty
        begin
//          bsmtStr := grid.Comp[cmpID].GetCellTextByID(aaBsmtFinArea);
//          if length(BsmtStr) > 0 then
//            CStr := zeroRoomsBelowStr;
        end;
//      PrStr := GetCellString(TContainer(doc), PCell);
      ParseRoomsBelow(SStr,sbjRoomCnt, sbjBathCnt);
      ParseRoomsBelow(CStr, compRoomCnt, compBathCnt);
      //rooms adjustment without bathrooms
      RoomsAdjustment := 0;
      adjIndex := adjList.GetItemIndexByName('Rooms below Grade');
      if adjIndex >= 0 then
        begin
          adjItem := adjList.Adjuster[adjIndex];
          if adjItem.FActive and (adjItem.FFactor > 0) then
            begin
              isAdjActive := true;
              RoomsAdjustment :=  adjItem.GetAdjustment(sbjRoomCnt,compRoomCnt,StrToFloatDef(PrStr,0));
            end;
        end;
      // only bathrooms adjustment
      BathsAdjustment := 0;
      adjIndex := adjList.GetItemIndexByName('Baths below Grade');
      if adjIndex >= 0 then
        begin
          adjItem := adjList.Adjuster[adjIndex];
          if adjItem.FActive and (adjItem.FFactor > 0) then
            begin
              isAdjActive := true;
              BathsAdjustment :=  adjItem.GetAdjustment(sbjBathCnt,compBathCnt,StrToFloatDef(PrStr,0));
            end;
        end;
      fullAdjustment := RoomsAdjustment + BathsAdjustment;
      result := Format('%.0n',[fullAdjustment]);
    end;
 end;

function DoBsmtAreaAdjustment(SStr, CStr, PStr:String; doc: TComponent; AdjList:TCellAdjustList):String;
var
  rec, lstInd, adj, AdjCellID : Integer;
  SCell, CCell, PCell, AdjCell, SumAdjCell: CellUID;
  adjValue, sumAdjValue: Double;
  adjItem: TCellAdjustItem;
  curCell: TBaseCell;
  bAdjValid: Boolean;
  bSumAdjValid: Boolean;
  SStrVal, CStrVal,  adjStr: String;
  realAdj: Boolean;

begin
  result := '';
  bSumAdjValid := False;
  bAdjValid := False;
  sumAdjValue := 0;
  adjValue := 0;
  AdjCellID := 0;
  SStrVal := ''; CStrVal := '';
  // Make sure there is an active adjList and it contains elements
  if assigned(adjList) and (adjList.Count > 0) then
    begin
      //subject FNMA1004 value cell
(*
      if grid.GetAdjustmentCell(0, 1006, SCell) then
        begin
          //comp FNMA1004 value cell
          if grid.GetAdjustmentCell(cmpID, 1006, CCell) then
            //adjustment cell ID
            AdjCellID := 1007;
          //REO forms
          if (SCell.FormID = 794) or (SCell.FormID = 834) then
            //current list price cell
            grid.GetAdjustmentCell(cmpID,1104,PCell)
          else
            //sale price cell
            grid.GetAdjustmentCell(cmpID,947,PCell);
        end;
*)

//      if (SCell.FormID > 0) and (CCell.FormID > 0) and (PCell.FormID > 0) then
        if (SStr <> '') and (CStr <> '') then
        begin
          // First check for basement total area adjustment
          //lstInd := FindAdjIdxByName(adjList, 'Basement Area');
          lstInd := adjList.GetItemIndexByName('Basement Area');
          if lstInd >= 0 then
            begin
              adjItem := adjList[lstInd];
              if adjItem.FActive then
                begin
                  bAdjValid := True;
                //github #200: Should exclude EMPTY cell but not 0
                //  realAdj := (GetFirstValue(CStr)>0) and (GetFirstValue(SStr)>0);
                  realAdj := (length(CStr) > 0) and (length(SStr) > 0);
                  if realAdj then
                    begin
                      if SStr <> '' then
                        SStrVal := IntToStr(GetFirstIntValue(SStr));
                      if CStr <> '' then
                        CStrVal := IntToStr(GetFirstIntValue(CStr));
                      adjStr := adjItem.CalcAdjustment(SStrVal, CStrVal, PStr, TContainer(doc).GetCell(CCell).FCellXID, TContainer(doc).UADEnabled);
                      if IsValidNumber(adjStr, adjValue) then
                        sumAdjValue := sumAdjValue + adjValue;
                      bSumAdjValid := True;
                    end;
                end;
            end;
          // Next check for basement finished area adjustment
          adjStr := '';
          adjValue := 0;
          //lstInd := FindAdjIdxByName(adjList, 'Bsmt Finished Area');
          lstInd := adjList.GetItemIndexByName('Bsmt Finished Area');
          if lstInd >= 0 then
            begin
              adjItem := adjList[lstInd];
              if adjItem.FActive then
                begin
                  bAdjValid := True;
                  //github #200: Should exclude EMPTY cell but not 0
                  //realAdj := (GetFirstValue(CStr)>0) and (GetFirstValue(SStr)>0);
                  realAdj := (length(CStr) > 0) and (length(SStr) > 0);
                  if realAdj then
                    begin
                      SStrVal := Format('%d',[GetSecondIntValue(SStr)]);
                      CStrVal := Format('%d',[GetSecondIntValue(CStr)]);
                      adjStr := adjItem.CalcAdjustment(SStrVal, CStrVal, PStr, TContainer(doc).GetCell(CCell).FCellXID, TContainer(doc).UADEnabled);
                      if IsValidNumber(adjStr, adjValue) then
                        sumAdjValue := sumAdjValue + adjValue;
                      bSumAdjValid := True;
                    end;
                end;
            end;

          if bAdjValid then
            begin
            //  if grid.GetAdjustmentCell(cmpID, AdjCellID, AdjCell) then
              //  if TContainer(doc).GetValidCell(AdjCell, curCell) then
                  if bSumAdjValid
                        and not (Tcontainer(doc).UADEnabled and (sumAdjValue = 0)) then //leave adjustment blank for UAD report
                    //curCell.LoadData(curCell.GetFormatedString(sumAdjValue))
                     result := Format('%.0n',[sumAdjValue])
                   else
                    if bSumAdjValid and (TContainer(doc).UADEnabled and (sumAdjValue = 0)) then
                      if CompareText(SStr,CStr) = 0 then
                        result := ''
                      //curCell.LoadData('0')
                      //    curCell.LoadData('')  //github #152 do not show 0
                      else
                        result := Format('%.0n',[sumAdjValue])
                       // curCell.LoadData('0')
                    else
                     // curCell.LoadData('');
                     result := Format('%.0n',[sumAdjValue]);
            end
        end;
    end;
end;

function IsAdjRowActive(ADoc: TObject; adjID: Integer): Boolean;
var
  doc: TContainer;
begin
  doc := TContainer(ADoc);
  // Use all rows for UAD reports. Use all rows except the basement finished area,
  //  property condition and property construction quality for non-UAD reports.
  result := doc.UADEnabled or (adjId < Pred(rowAdjBsmtFinArea));
end;

procedure TAdjustments.btnDeleteClick(Sender: TObject);
var
  fPath: String;
begin
  fPath := FAdjList.FListPath;
  if FileExists(fPath) then
    begin
      If OK2Continue('The file '+ '"'+GetNameOnly(fPath)+'" will be deleted. Are you sure?') then
        begin
          If DeleteFile(fPath) then
            begin
              LoadAvaliableLists;   //now re-init the list
              InitGridCombos;  	    // re-set the grid
              LoadDocumentList;     // load the containers adj list (when adjustments are "active" in report)
            end
          else
            ShowNotice(GetNameOnly(fPath)+' could not be deleted.');     //fails to delete
        end
      end
    else
     ShowNotice('The auto-adjustment file, "'+GetNameOnly(fPath)+'", was not found.'); //no adjustment selected
end;

procedure TAdjustments.cbxAdjustbyDayClick(Sender: TObject);
begin
  FListModified := True;
end;

procedure TAdjustments.InitTool(ADoc: TComponent);
begin
  FDoc := TContainer(ADoc);
end;


{

  rowAdjBhRooms = 8;

  rowAdjGBA = 10;
}


function TAdjustments.getCompRowbyAdjustItem(AdjItem: TCellAdjustItem):Integer;

var

  aCellID: Integer;

begin

  result  := 0;

  aCellID := AdjItem.FKindID;

  case aCellID of

    960:  result := _fSaleDate;

    976:  result := _fSiteArea;

    994:  result := _fQuality;

    996:  result := _fActualAge;

    998:  result := _fCondition;

    1004: result := _fGLA;

    1041: result := _fTotalRoom;

    1042: result := _fBedRoom;

    1043: result := _fFullHalfBath;

    1006: result := _fBasmtGLA;

    1008: result := _fBasmtRoom;

    1016: result := _fGarage;

    1018: result := _fPatio;

    1020: result := _fFireplace;

    1022: result := _fPool;

  end;

end;



procedure TAdjustments.CalcAdjustmentForAllComps(i: Integer; aFactor: Double;AdjItem: TCellAdjustItem);

function GetAdjustment(AdjItem: TCellAdjustItem; SubVal, CmpVal, cmpPrice: Double): Double;

var
  VR: Double;
begin
  result := 0;
  if not assigned(AdjItem) then exit;
  if (AdjItem.FFactor <> 0) then  {and (SubVal <>0) and (CmpVal <>0)}
    begin
      VR := SubVal - CmpVal;
      if Abs(VR) > AdjItem.FLimit then
      if AdjItem.FCalcMode = 0 then
        AdjItem.FCalcMode := adjModeAbs;
        case AdjItem.FCalcMode of
          adjModeAbs:
            result := VR *  AdjItem.FFactor;
          adjModePercents:
            if cmpPrice > 0 then
              result := VR *  AdjItem.FFactor * CmpPrice / 100;
        end;
    end;
end;


const

   cSubject = 2;


var

  row, Col: Integer;

  SValue, CValue, PValue, AdjValue,aNum: Double;

  SStr, CStr, PStr, adjStr: String;

  aCellValue: String;

  bValidValue: Boolean;

  doc: TContainer;
  
begin

  if (FDoc = nil) then  exit;

  doc := TContainer(FDoc);
  adjStr := '';
  row := getCompRowbyAdjustItem(AdjItem);

  try

    AdjItem.FFactor :=  aFactor;

    SStr := FCompGrid.Cell[cSubject, row];

    if (SStr = '') and  (row=_fSaleDate) then

      begin

        SStr := TContainer(FDoc).GetCellTextByID(1132);

        if SStr = '' then
          SStr := DateToStr(Date);             //use current date
      end;


    //SValue := GetStrValue(FCompGrid.Cell[cSubject, row]);

    for col := 3 to FCompGrid.Cols do

      begin

        CStr := FCompGrid.Cell[col, row];

        if pos('[', CStr) > 0 then

          CStr := popStr(CStr, '[');

        //CValue := GetStrValue(aCellValue);

        PStr := '';  //TODO

        PValue := 0; //TODO


        if (length(SStr) > 0) and (length(CStr) > 0) then

          begin
            case row of
              _fBasmtRoom:
                begin
                  try
                    if CStr <> '' then
                      adjStr := DoRoomsBelowGradeAdjustment(SStr, CStr, PStr, FDoc, FAdjList);
                  except on E:Exception do
                    adjStr := '';
                  end;
                end;
              _fBasmtGLA:
                begin
                  try
                    if CStr <> '' then
                      adjStr  := DoBsmtAreaAdjustment(SStr, CStr, PStr, FDoc, FAdjList);
                  except on E:Exception do
                    adjStr := '';
                  end;
                end
              else  if isRoomAdjustmentsActive(FAdjList) then
                begin
                  adjStr := DoRoomAdjustment(SStr, CStr, PStr, Fdoc,FAdjList);
                  if adjStr = '' then
                    adjStr := AdjItem.CalcAdjustment(SStr, CStr, PStr, AdjItem.FKindID, True);
                end
              else
                adjStr := AdjItem.CalcAdjustment(SStr, CStr, PStr, AdjItem.FKindID, True);
            end;
            IsValidNumber(adjStr, aNum);
            bValidValue := True;
          end
        else
          bValidValue := False;


        if bValidValue and (trim(adjStr) <> '') then

          FCompGrid.Cell[col, row] := Format('%s [%s]',[CStr,adjStr]);

      end;

  finally

  end;

end;


procedure TAdjustments.ReAdjustAllComparables(ADoc: TObject);

var
  doc: TContainer;
//  Grid: TCompMgr2;
  adjList: TCellAdjustList;
  i,cmp,N,K: Integer;
//  isActive, UseRegress: Boolean;
  Factor, RegFactor: Double;
  AdjItem: TCellAdjustItem;
begin
  if (ADoc <> nil) then
    begin
      doc := TContainer(ADoc);
      //Grid := TCompMgr2.Create(True);
      AdjList := TCellAdjustList(doc.docCellAdjusters);

      if not assigned(TCompSelection(FCompSelection)) then
        TCompSelection(FCompSelection).LoadToolData;
      FCompGrid := TCompSelection(FCompSelection).CompGrid;

      try
        //Grid.BuildGrid(doc, gtSales);          //now we have grid with all comps
        //K := Grid.count;                        //how many comps, k includes subject=0
        N := AdjList.count;                     //how many adjustment items
        for i := 0 to N-1 do                    //run through the adj items
          begin
            AdjItem := AdjList.Adjuster[i];
            if not assigned(AdjItem) then continue;
            if AdjItem.FActive then
              begin
                if AdjItem.FUseReg and (AdjItem.FRegFactor <> 0) then
                  Factor := AdjItem.FRegFactor
                else
                  Factor := AdjItem.FFactor;
                CalcAdjustmentForAllComps(i, Factor, AdjItem);
              end;
          end;
      finally
        //Grid.Free;
      end;
    end;
    //for listings
(*
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := TCellAdjustList(doc.docCellAdjusters);
      try
        Grid.BuildGrid(doc, gtListing);          //now we have grid with all comps
        K := Grid.count;                        //how many comps, k includes subject=0
        N := AdjList.count;                     //how many adjustment items
        for cmp := 1 to K-1 do            //make adj to all the comps
          begin
            //grid.ClearCompAdjColumn(cmp);
            DoRoomAdjustment(cmp, doc, Grid, AdjList);
            DoBsmtAreaAdjustment(cmp, doc, Grid, AdjList);
            DoRoomsBelowGradeAdjustment(cmp,doc, Grid,AdjList);
            for i := 0 to N-1 do                    //run thur the adj items
              with AdjList.Adjuster[i] do
                if (not IsRoomAdjKind(FKindID)) and (not IsAreaBelowAdjKind(FKindID)) and (FKindID<> aaRmsBelow) then
                  if FActive then                     //it its active
                    if Grid.GetAdjustmentPair(cmp, AdjKind, SCell, CCell, ACell,PCell) then
                      AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
*)
end;


end.
