unit UCellAutoAdjust;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2012 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids_ts, TSGrid, ExtCtrls,ComCtrls, Contnrs,
  UGlobals, UUtil1, UBase, UFileUtils,UGridMgr, UForms, UUtil2{, ActnList, ExtActns};

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
    constructor Create(AOwner: TCellAdjustList);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream; vers: Integer);
    function GetAdjustment(SubVal, CmpVal,CmpPrice: Double): Double; virtual;
    function CalcAdjustment(const SubVal, CmpVal,CmpPrice: String;
      CellXID: Integer; IsUAD: Boolean=False): String; virtual;
    procedure AdjustPair(ADoc: TComponent; SCell, CCell, ACell,PCell: CellUID); virtual;
    function GetAdjustValue(ADoc: TComponent; SCell,CCell,PCell: CellUID; var bValidValue: Boolean): Double;
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
  TAutoCellAdjustEditor = class(TAdvancedForm)
    Panel1: TPanel;
    AutoAdjGrid: TtsGrid;
    btnOk: TButton;
    btnCancel: TButton;
    cbxSaveDefault: TCheckBox;
    cmbxSelectList: TComboBox;
    StatusBar1: TStatusBar;
    btnSaveList: TButton;
    cbxSumRoomAdj: TCheckBox;
    btnDelete: TButton;
    cbxAdjustbyDay: TCheckBox;
    procedure btnOkClick(Sender: TObject);
    procedure cmbxSelectListChange(Sender: TObject);
    procedure btnSaveListClick(Sender: TObject);
    procedure AutoAdjGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AutoAdjGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure AutoAdjGridKeyPress(Sender: TObject; var Key: Char);
    procedure sbxSumRoomAdjClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbxAdjustbyDayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCancelClick(Sender: TObject);
  private
    FNeedDocSave: Boolean;
    FListModified: Boolean;
    FAdjList: TCellAdjustList;
    FDoc: TComponent;
    procedure InitGridCombos;
    procedure AdjustDPISettings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadDocumentList;
    procedure InitialAdjustments(IsUAD: Boolean);
    procedure LoadAvaliableLists;
    procedure LoadAdjustmentFile(AListName: String);
  end;

// This is the routine called to startup the editor
  procedure LaunchAdjustmentEditor(AOwner: TComponent);
  procedure AdjustAllComparables(ADoc: TObject);
  procedure AdjustThisComparable(ADoc: TObject; Index: Integer);

  function IsRoomAdjKind(adjID: Integer): Boolean;
  function IsDateOfSaleAdjKind(adjID: Integer): Boolean;
  function IsSiteAreaAdjKind(adjID: Integer): Boolean;
  function IsBathroomAdjKind(adjID: Integer): Boolean;
  function IsRmsBelowAdjKind(adjID: Integer): Boolean;
  function IsAreaBelowAdjKind(adjID: Integer): Boolean;
  function IsCarStorageAdjKind(adjID: Integer): Boolean;
  function isRoomAdjSumOnly(doc: TComponent): Boolean;
  procedure DoRoomAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);
  function IsRoomAdjustmentsActive(AdjList: TCellAdjustList): Boolean;
  procedure DoBsmtAreaAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);
  function IsAdjRowActive(ADoc: TObject; adjID: Integer): Boolean;
  procedure DoRoomsBelowGradeAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);

  //for invoking from cells outside of the grid, for example subject sale date cell
  procedure PerformThisAdjustment(ADoc: TComponent; adjID: Integer);
  function FindAdjustmentIndex(adjList: TCellAdjustList; searchRec: Integer): Integer;
  function GetAdjustmentType(cellID: Integer): Integer;
implementation

{$R *.DFM}

Uses
  DateUtils, StrUtils,
  UContainer, UCell, UStatus, UFileGlobals, UMath, UUADUtils, UMain;

Const
  sNoListSelected = '- No Adjustment List Selected -';

// When the adjustment values are changed, this routine is
// called to recalc all the
procedure AdjustAllComparables(ADoc: TObject);
var
  doc: TContainer;
  Grid: TCompMgr2;
  adjList: TCellAdjustList;
  i,cmp,N,K: Integer;
  SCell, CCell, ACell, PCell: CellUID;
begin
  if (ADoc <> nil) then
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtSales);          //now we have grid with all comps
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
                if (not IsRoomAdjKind(FKindID)) and (not IsAreaBelowAdjKind(FKindID)) and (FKindID <> aaRmsBelow) then
                  if FActive then                     //it its active
                    if Grid.GetAdjustmentPair(cmp, AdjKind, SCell, CCell, ACell,PCell) then
                      AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
    //for listings
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := doc.docCellAdjusters;
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
end;

procedure AdjustThisComparable(ADoc: TObject; Index: Integer);
var
  doc: TContainer;
  Grid: TcompMgr2;
  adjList: TCellAdjustList;
  i,N,K: Integer;
  SCell, CCell, ACell,PCell: CellUID;
begin
  if (ADoc <> nil) then
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtSales);          //now we have grid with all comps
        //grid.ClearCompAdjColumn(index);
        K := Grid.count;                        //how many comps, k includes subject=0
        if (index >-1) and (Index < K) then
          begin
            DoRoomAdjustment(index, doc, grid, adjList);
            DoBsmtAreaAdjustment(index, doc, Grid, AdjList);
            DoRoomsBelowGradeAdjustment(index,doc, Grid,AdjList);
            N := AdjList.count;                     //how many adjustment items
            for i := 0 to N-1 do                    //run thur the adj items
              with AdjList.Adjuster[i] do
                if (not IsRoomAdjKind(FKindID)) and (not IsAreaBelowAdjKind(FKindID)) and (FKindID <> aaRmsBelow) then
                  if FActive then //it its active
                    if Grid.GetAdjustmentPair(Index, AdjKind, SCell, CCell, ACell,PCell) then
                      AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
    //for listings
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtListing);          //now we have grid with all comps
        //grid.ClearCompAdjColumn(index);
        K := Grid.count;                        //how many comps, k includes subject=0
        if (index >-1) and (Index < K) then
          begin
            DoRoomAdjustment(index, doc, grid, adjList);
            DoBsmtAreaAdjustment(index, doc, Grid, AdjList);
            DoRoomsBelowGradeAdjustment(index,doc, Grid,AdjList);
            N := AdjList.count;                     //how many adjustment items
            for i := 0 to N-1 do                    //run thur the adj items
              with AdjList.Adjuster[i] do
                if (not IsRoomAdjKind(FKindID)) and (not IsAreaBelowAdjKind(FKindID)) and (FKindID <> aaRmsBelow) then
                  if FActive then  //it its active
                    if Grid.GetAdjustmentPair(Index, AdjKind, SCell, CCell, ACell,PCell) then
                      AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
    //for Renting
    begin
      doc := TContainer(ADoc);
      Grid := TCompMgr2.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtRental);          //now we have grid with all comps
        //grid.ClearCompAdjColumn(index);
        K := Grid.count;                        //how many comps, k includes subject=0
        if (index >-1) and (Index < K) then
          begin
            DoRoomAdjustment(index, doc, grid, adjList);
            DoBsmtAreaAdjustment(index, doc, Grid, AdjList);
            DoRoomsBelowGradeAdjustment(index,doc, Grid,AdjList);
            N := AdjList.count;                     //how many adjustment items
            for i := 0 to N-1 do                    //run thur the adj items
              with AdjList.Adjuster[i] do
                if (not IsRoomAdjKind(FKindID)) and (not IsAreaBelowAdjKind(FKindID)) and (FKindID <> aaRmsBelow) then
                  if FActive then  //it its active
                    if Grid.GetAdjustmentPair(Index, AdjKind, SCell, CCell, ACell,PCell) then
                      AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;


end;

// the owner is the TContainer. This could be called without
// a container and be simple list editor.
procedure LaunchAdjustmentEditor(AOwner: TComponent);
var
  AdjEditor: TAutoCellAdjustEditor;
begin
  AdjEditor := TAutoCellAdjustEditor.Create(AOwner);
  try
//    if AdjEditor.showModal= mrOK then    //github 178: make it not modal form
//      AdjustAllComparables(TContainer(AOwner));  //github 178: move this to formclosequery
      AdjEditor.Show;
  finally
//    FreeAndNil(AdjEditor);    //github 178: since we set the parent of the form is TConatiner, and do a show, should not free and nil the object
  end;
end;


{ TAutoCellAdjustEditor }

constructor TAutoCellAdjustEditor.Create(AOwner: TComponent);
begin
 // inherited;
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

destructor TAutoCellAdjustEditor.Destroy;
begin
  if assigned(FAdjList) then
    FAdjList.Free;

  inherited;
end;

procedure TAutoCellAdjustEditor.LoadDocumentList;
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
    FAdjList.Assign(TContainer(Owner).docCellAdjusters);

  //if there were any, load and give user feedback
  if FAdjList.count > 0 then
    begin
      FAdjList.WriteToGrid(AutoAdjGrid, TContainer(Owner).UADEnabled);         //display what came in
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

procedure TAutoCellAdjustEditor.LoadAvaliableLists;
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

procedure TAutoCellAdjustEditor.LoadAdjustmentFile(AListName: String);
var
  folder, filePath: String;
begin
  if FindLocalSubFolder(appPref_DirLists, dirAdjustments, folder, True) then
    begin
      filePath := IncludeTrailingPathDelimiter(folder) + AListName + '.lst';
      FAdjList.Path := filePath;
      FAdjList.WriteToGrid(AutoAdjGrid, TContainer(Owner).UADEnabled);
      cbxSumRoomAdj.Checked := FAdjList.FRoomSumAdj or IsRoomAdjSumOnly(Owner);
      cbxAdjustbyDay.Checked := FAdjList.FAdjustDateByDay;
      FListModified := False;
      FNeedDocSave := True;

      //check / uncheck the checkbox
      cbxSaveDefault.checked := (compareText(filePath, appPref_AutoAdjListPath)= 0);
    end;
end;

procedure TAutoCellAdjustEditor.btnOkClick(Sender: TObject);
begin
  FAdjList.ReadFromGrid(AutoAdjGrid);                     //get the changes
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
      TContainer(Owner).docCellAdjusters.Assign(FAdjList);      //save to the report
      TContainer(Owner).docDataChged := FListModified or FNeedDocSave;        //make sure its saved
    end;
  Close;  //github 178: we need to close the form
end;

procedure TAutoCellAdjustEditor.btnSaveListClick(Sender: TObject);
var
  listName: String;
begin
  FAdjList.ReadFromGrid(AutoAdjGrid);      //get the changes
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

procedure TAutoCellAdjustEditor.cmbxSelectListChange(Sender: TObject);
begin
	if cmbxSelectList.ItemIndex <> -1 then
		LoadAdjustmentFile(cmbxSelectList.Text);
end;

//Fix DPI issues
procedure TAutoCellAdjustEditor.AdjustDPISettings;
begin
   btnSaveList.left := cbxAdjustbyDay.left + cbxAdjustbyDay.width + 5;
   btnDelete.Left := btnSaveList.left + btnSaveList.Width + 10;
   btnOk.left := btnSaveList.Left;
   btnCancel.Left := btnDelete.left;
   self.width := btnDelete.Left + btnDelete.width + 80;
   self.height := Panel1.height + AutoAdjGrid.height + StatusBar1.height + 50;
   self.Constraints.minWidth := self.width;
   self.Constraints.minHeight := self.height;
end;

procedure TAutoCellAdjustEditor.InitialAdjustments(IsUAD: Boolean);
var
  i: Integer;
begin
  with AutoAdjGrid do
    begin
      rows := MaxAdjustments;
      for i:= 1 to MaxAdjustments do
        begin
          Cell[colAdjID,i] := AvailAdjustments[i].adjID;
          Cell[colAdjActive,i] := cbUnchecked;
          Cell[colAdjType,i] := AvailAdjustments[i].adjType;
          Cell[colAdjRate,i] := 0;
          Cell[colAdjMode,i] :=  Col[colAdjMode].Combo.ComboGrid.Cell[1,adjModeAbs];
          Cell[colAdjUnits,i] := AvailAdjustments[i].strUnit;
          cell[colAdjMindiff,i] := 0;
        end;
    end;
    (*begin
      rows := 15;
      i := 1;
      Cell[1,i] := aaDate;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Date of Sale';
      Cell[4,i] := 0;
      Cell[5,i] := 'Months';
      cell[6,i] := 0;

      inc(i);  //i=2
      Cell[1,i] := aaSite;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Site Area';
      Cell[4,i] := 0;
      Cell[5,i] := 'Sqft';
      cell[6,i] := 0;

      inc(i);   //i=3
      Cell[1,i] := aaAge;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Actual Age';
      Cell[4,i] := 0;
      Cell[5,i] := 'Years';
      cell[6,i] := 0;

      inc(i);    //i=4
      Cell[1,i] := aaTotalRms;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Total Rooms';
      Cell[4,i] := 0;
      Cell[5,i] := 'Rooms';
      cell[6,i] := 0;

      inc(i);     //i=5
      Cell[1,i] := aaBedrooms;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Bedrooms';
      Cell[4,i] := 0;
      Cell[5,i] := 'Rooms';
      cell[6,i] := 0;

      inc(i);     //i=6
      Cell[1,i] := aaBaths;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Bathrooms';
      Cell[4,i] := 0;
      Cell[5,i] := 'Rooms';
      cell[6,i] := 0;

      inc(i);     //i=7
      Cell[1,i] := aaGLArea;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Gross Living Area';
      Cell[4,i] := 0;
      Cell[5,i] := 'Sqft';
      cell[6,i] := 0;
//inserted here
//--------------
      inc(i);     //i=8
      Cell[1,i] := aaGBArea;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Gross Building Area';
      Cell[4,i] := 0;
      Cell[5,i] := 'Sqft';
      cell[6,i] := 0;
//---------------
      inc(i);     //i=9
      Cell[1,i] := aaBasement;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Basement Area' / 'Bsmt Finished Area';
      Cell[4,i] := 0;
      Cell[5,i] := 'Sqft';
      cell[6,i] := 0;

      inc(i);     //i=10
      Cell[1,i] := aaRmsBelow;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Rms Below Grade';
      Cell[4,i] := 0;
      Cell[5,i] := 'Rooms';
      cell[6,i] := 0;

      inc(i);     //i=11
      Cell[1,i] := aaGarages;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Car Storage';
      Cell[4,i] := 0;
      Cell[5,i] := 'Cars';
      cell[6,i] := 0;

      inc(i);     //i=12
      Cell[1,i] := aaProches;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Porches,Decks';
      Cell[4,i] := 0;
      Cell[5,i] := 'Porch,Deck';
      cell[6,i] := 0;

      inc(i);     //i=13
      Cell[1,i] := aaFireplaces;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Fireplaces';
      Cell[4,i] := 0;
      Cell[5,i] := 'Fireplaces';
      cell[6,i] := 0;

      inc(i);     //i=14
      Cell[1,i] := aaPools;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Pools';
      Cell[4,i] := 0;
      Cell[5,i] := 'Pools';
      cell[6,i] := 0;

      inc(i);     //i=15
      Cell[1,i] := aaOther;
      Cell[2,i] := cbUnchecked;
      Cell[3,i] := 'Other';
      Cell[4,i] := 0;
      Cell[5,i] := 'Number';
      cell[6,i] := 0;
    end; *)

end;

//Handles key events
procedure TAutoCellAdjustEditor.AutoAdjGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  FListModified := True;
end;

procedure TAutoCellAdjustEditor.AutoAdjGridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ((Key in [#08,#13,'0'..'9','.','-','+']) or (Ord(Key) = VK_DELETE)) then
    key := #0;
end;


//handles checking the activate checkboxes
procedure TAutoCellAdjustEditor.AutoAdjGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
begin
  if DataColDown = colAdjActive then
    begin
      FListModified := True;

      //toggle Total Rooms and Bedrooms - only one field for adjustment
      if (DataRowDown = rowAdjTtRooms) and (AutoAdjGrid.Cell[colAdjActive,rowAdjTtRooms] = cbChecked) then
        if AutoAdjGrid.Cell[colAdjActive,rowAdjBdRooms] = cbChecked then AutoAdjGrid.Cell[colAdjActive,5] := cbUnChecked;
      if (DataRowDown = rowAdjBdRooms) and (AutoAdjGrid.Cell[colAdjActive,rowAdjBdRooms] = cbChecked) then
        if AutoAdjGrid.Cell[colAdjActive,rowAdjTtRooms] = cbChecked then AutoAdjGrid.Cell[colAdjActive,rowAdjTtRooms] := cbUnChecked;
    end;
end;

procedure TAutoCellAdjustEditor.InitGridCombos;
begin
  with autoAdjGrid.Col[colAdjMode].Combo.ComboGrid do
    begin
      DropDownCols := 1;
      DropDownRows := length(adjCalcModes);
      Cell[1,adjModeAbs] := adjCalcModes[adjModeAbs];
      Cell[1,adjModePercents] := adjCalcModes[adjModePercents];
    end;

  autoAdjGrid.CellReadOnly[colAdjUnits,rowAdjsite] := roOff;
  autoAdjGrid.CellButtonType[colAdjUnits,rowAdjsite] := btCombo;
  autoAdjGrid.AssignCellCombo(colAdjUnits,rowAdjsite);
  autoAdjGrid.CellCombo[colAdjUnits,rowAdjsite].DropDownStyle := ddDropDownList;
  with autoAdjGrid.CellCombo[colAdjUnits,rowAdjsite].ComboGrid do
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
        if PosDate > 0 then
          try
            sMo := Copy(s_c_Date, Succ(PosDate), 2);
            sYr := Copy(s_c_Date, (PosDate + 4), 2);
            if (Trim(sMo) <> '') and (Trim(sYr) <> '') then
              Result := StrToDate(sMo + '/01/' + sYr);
          except
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

function TCellAdjustItem.GetAdjustValue(ADoc: TComponent; SCell,CCell,PCell: CellUID; var bValidValue: Boolean): Double;
var
  SStr, CStr, PStr,adjStr: String;
  doc: TContainer;
begin
  SStr := '';
  CStr := '';
  result := 0;
  doc := TContainer(ADoc);
  SStr := GetCellString(doc, SCell);
  CStr := GetCellString(doc, CCell);
  PStr := GetCellString(doc, PCell);
  if (length(SStr) > 0) and (length(CStr) > 0) then
    begin
      adjStr := CalcAdjustment(SStr, CStr, PStr, doc.GetCell(CCell).FCellXID, doc.UADEnabled);
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
          Result := Result + (StrToInt(HalfBaths) * 0.5);
      end;
  end;

  {picked out as separate function  DoRoomsBelowGradeAdjustment
  function CalcRmsBelow(Rooms: String; IsUAD: Boolean): Double;
  var
    PosRR, PosBR, PosO, PosBA: Integer;
    bathStr, aTemp: String;
    bath: Double;
    rr, br, ba, o, fba, hba: String;
    fBath, hBath: Double;
  begin
    if (Rooms = '0') or (Trim(Rooms) = '') then
      Result := 0
    else if IsUAD then
      begin
        Result := 0;
        // Room counts are specified at 1 digit maximum so
        //  we can simply retrieve one character
        PosRR := Pos('rr', Rooms);
        PosBR := Pos('br', Rooms);
        PosO  := Pos('o', Rooms);
//        PosBA := Pos('ba', Rooms);  //github 177
        if PosRR > 0 then
          Result := Result + StrToIntDef(Copy(Rooms, Pred(PosRR), 1), 0);
        if PosBR > 0 then
          Result := Result + StrToIntDef(Copy(Rooms, Pred(PosBR), 1), 0);
        if PosO > 0 then
          Result := Result + StrToIntDef(Copy(Rooms, Pred(PosO), 1), 0);
        //github 177: hold off for now
(*
        if posBA > 0 then //we have below grade bath room
          begin
            aTemp := Rooms;
            rr  := popStr(aTemp, 'rr');
            br  := popStr(aTemp, 'br');
            ba  := popStr(aTemp, 'ba'); //looking for 'ba'
            o   := popStr(aTemp, 'o');
            fBa := popStr(ba,'.');
            hBa := ba;

            fBath := GetStrValue(fba);
            hBath := GetStrValue(hba);
            Result := Result + fbath + hBath;
          end;
*)
      end
    else
      Result := GetValidInteger(Rooms);
  end;                 }

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
                  Result := StrToIntDef(AStrNum, 0);
                  theStr := Copy(theStr, (Pos(Str1, theStr) + Length(Str1)), Length(theStr));
                end
              else if (Length(theStr) > 0) and (Length(Str2) > 0) and (Copy(theStr, 1, Length(Str2)) = Str2) then
                begin
                  Result := Result + StrToIntDef(AStrNum, 0);
                  theStr := Copy(theStr, (Pos(Str2, theStr) + Length(Str2)), Length(theStr));
                end
              else if (Length(theStr) > 0) and (Length(Str3) > 0) and (Copy(theStr, 1, Length(Str3)) = Str3) then
                begin
                  Result := Result + StrToIntDef(AStrNum, 0);
                  theStr := Copy(theStr, (Pos(Str3, theStr) + Length(Str3)), Length(theStr));
                  theStr := '';
                end
              else if (Length(theStr) > 0) and (Length(Str4) > 0) and (Copy(theStr, 1, Length(Str4)) = Str4) then
                begin
                  Result := Result + StrToIntDef(AStrNum, 0);
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

(*
{OLD Way }
  N := ReadLongFromStream(Stream);    //read how many items we have
//  if N > 0 then ShowNotice('adjustment list = '+ IntToStr(N));    //###Debug

  for i := 0 to N-1 do                //read each item
    begin
      {need to create the right sub class}
      KindID := ReadLongFromStream(Stream);       //read the object kind
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
        CellAdjust.LoadFromStream(Stream);
      finally
        Add(CellAdjust);
      end;
    end;
*)
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

          CellAdjust.FKindID  := Source.Adjuster[i].FKindID;
          CellAdjust.FActive  := Source.Adjuster[i].FActive;
          CellAdjust.FName    := Source.Adjuster[i].FName;
          CellAdjust.FFactor  := Source.Adjuster[i].FFactor;
          CellAdjust.FUnits   := Source.Adjuster[i].FUnits;
          CellAdjust.FLimit   := Source.Adjuster[i].FLimit;
          CellAdjust.FCalcMode := Source.Adjuster[i].FCalcMode;
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

procedure TAutoCellAdjustEditor.sbxSumRoomAdjClick(Sender: TObject);
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

//Today we used the function only for updating sales date adjustment
procedure PerformThisAdjustment(ADoc: TComponent; adjID: Integer);
var
  doc: TContainer;
  Grid: TGridMgr;
  adjList: TCellAdjustList;
  i,cmp,K: Integer;
  SCell, CCell, ACell, PCell: CellUID;
begin
  if (ADoc <> nil) then
    begin
      doc := TContainer(ADoc);
      Grid := TGridMgr.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtSales);     //now we have grid with all comps
        K := Grid.count;                  //how many comps, k includes subject=0
        for cmp := 1 to K-1 do            //make adj to all the comps
          begin
            i := FindAdjustmentIndex(adjList,adjID);
            if (i >= 0) and (i < adjList.Count) then
              with AdjList.Adjuster[i] do
                if FActive then                     //it its active
                  if Grid.GetAdjustmentPair(cmp, AdjKind, SCell, CCell, ACell,PCell) then
                    AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
    //for listings
    begin
      doc := TContainer(ADoc);
      Grid := TGridMgr.Create(True);
      AdjList := doc.docCellAdjusters;
      try
        Grid.BuildGrid(doc, gtListing);     //now we have grid with all comps
        K := Grid.count;                  //how many comps, k includes subject=0
        for cmp := 1 to K-1 do            //make adj to all the comps
          begin
            i := FindAdjustmentIndex(adjList,adjID);
            if (i >= 0) and (i < adjList.Count) then
              with AdjList.Adjuster[i] do
                if FActive then                     //it its active
                  if Grid.GetAdjustmentPair(cmp, AdjKind, SCell, CCell, ACell,PCell) then
                    AdjustPair(doc, SCell, CCell, ACell,PCell);
          end;
      finally
        Grid.Free;
      end;
    end;
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

procedure DoRoomAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);
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
              if not grid.GetAdjustmentCell(0,RoomAdjCellIDs[rec][adj],SCell) then
                continue;
              //comp value cell
              if not grid.GetAdjustmentCell(cmpID,RoomAdjCellIDs[rec][adj],CCell) then
                continue;
              //price cell
              grid.GetAdjustmentCell(cmpID,947,PCell);

              adjValue := adjItem.GetAdjustValue(doc,SCell,CCell,PCell,bAdjValid);
              sumAdjValue := sumAdjValue + adjValue;
              //bSumAdjValid := bSumAdjValid and bAdjValid;
              if RoomAdjCellIDs[rec][adj + nRoomAdjTypes] > 0 then
                if grid.GetAdjustmentCell(cmpID,RoomAdjCellIDs[rec][adj + nRoomAdjTypes],AdjCell)then
                  if TContainer(doc).GetValidCell(AdjCell,curCell) then
                    if not adjList.FRoomSumAdj and bAdjValid
                          and not (Tcontainer(doc).UADEnabled and (adjValue = 0)) then //leave adjustment blank for UAD report
                      begin
                        //Fix to use the adjustment value to set the text on the adjustment cell
                        //curCell.LoadData(curCell.GetFormatedString(adjValue));
                        adjStrValue := FormatValue(adjValue, curCell.FCellFormat);
                        curCell.LoadData(adjStrValue);
                      end
                    else
                      curCell.SetText('');
               bSumAdjValid := bSumAdjValid or bAdjValid;
            end;
        end;
        if adjList.FRoomSumAdj then
          if grid.GetAdjustmentCell(cmpId,RoomAdjCellIDs[rec][7],SumAdjCell) then
            if TContainer(doc).GetValidCell(SumAdjCell,curCell) then
              if bSumAdjValid
                    and not (Tcontainer(doc).UADEnabled and (sumAdjValue = 0)) then //leave adjustment blank for UAD report
                curCell.LoadData(curCell.GetFormatedString(sumAdjValue))
              else
                curCell.LoadData('');
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


procedure DoRoomsBelowGradeAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);
const
  zeroRoomsBelowStr = '0rr0br0.0ba0o';
var
  SCell, CCell, PCell, AdjCell: CellUID;
  roomsBelowIndex, bathsBelowIndex: Integer;
  SStr,CStr,PrStr: String;
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
  if not assigned(adjList) or (adjList.Count = 0) then
    exit;
  if not grid.GetAdjustmentPair(cmpID,aaRmsBelow,SCell,CCell,AdjCell,PCell) then
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
      SStr := GetCellString(TContainer(doc),SCell);
      if length(trim(SStr)) = 0 then   //do adjustment even subject rooms below empty
        begin
          bsmtStr := '';
          grid.GetSubject(aaBsmtFinArea,BsmtStr);
          if length(BsmtStr) > 0 then
            SStr := zeroRoomsBelowStr;
        end;
      CStr := GetCellString(TContainer(doc), CCell);
      if length(trim(CStr)) = 0 then   //do adjustment even comp rooms below empty
        begin
          bsmtStr := grid.Comp[cmpID].GetCellTextByID(aaBsmtFinArea);
          if length(BsmtStr) > 0 then
            CStr := zeroRoomsBelowStr;
        end;
      PrStr := GetCellString(TContainer(doc), PCell);
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
      if TContainer(doc).GetValidCell(AdjCell, curCell) then
        if isAdjActive then
          if (length(SStr) = 0) or (length(CStr) = 0) or (CompareText(CStr,SStr) = 0) then //(fullAdjustment = 0) then
            curCell.LoadData('')
           else
            curCell.LoadData(curCell.GetFormatedString(fullAdjustment));
    end;
 end;

procedure DoBsmtAreaAdjustment(cmpID: Integer; doc: TComponent; Grid: TCompMgr2; AdjList: TCellAdjustList);
var
  rec, lstInd, adj, AdjCellID : Integer;
  SCell, CCell, PCell, AdjCell, SumAdjCell: CellUID;
  adjValue, sumAdjValue: Double;
  adjItem: TCellAdjustItem;
  curCell: TBaseCell;
  bAdjValid: Boolean;
  bSumAdjValid: Boolean;
  SStr, SStrVal, CStr, CStrVal, PStr, adjStr: String;
  realAdj: Boolean;

  {replaced with TCellAdjustList.GetItemIndexByName
  function FindAdjIdxByName(adjList: TCellAdjustList; searchName: String): Integer;
  var
    adjRec, nRecs: Integer;
  begin
    result := -1;
    if not assigned(adjList) then
      exit;
    nRecs := adjList.Count;
    adjRec := -1;
    repeat
      adjRec := Succ(adjRec);
      if  adjList.Adjuster[adjRec].FName = searchName then
        result := adjRec;
    until (result > -1) or (adjRec = Pred(nRecs));
  end;         }

begin
  bSumAdjValid := False;
  bAdjValid := False;
  sumAdjValue := 0;
  adjValue := 0;
  AdjCellID := 0;
  // Make sure there is an active adjList and it contains elements
  if assigned(adjList) and (adjList.Count > 0) then
    begin
      //subject FNMA1004 value cell
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
        SStr := GetCellString(TContainer(doc), SCell);
        CStr := GetCellString(TContainer(doc), CCell);
        PStr := GetCellString(TContainer(doc), PCell);

      if (SCell.FormID > 0) and (CCell.FormID > 0) and (PCell.FormID > 0) then
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
                      SStrVal := IntToStr(GetFirstIntValue(SStr));
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
                      SStrVal := IntToStr(GetSecondIntValue(SStr));
                      CStrVal := IntToStr(GetSecondIntValue(CStr));
                      adjStr := adjItem.CalcAdjustment(SStrVal, CStrVal, PStr, TContainer(doc).GetCell(CCell).FCellXID, TContainer(doc).UADEnabled);
                      if IsValidNumber(adjStr, adjValue) then
                        sumAdjValue := sumAdjValue + adjValue;
                      bSumAdjValid := True;
                    end;
                end;
            end;

          if bAdjValid then
            begin
              if grid.GetAdjustmentCell(cmpID, AdjCellID, AdjCell) then
                if TContainer(doc).GetValidCell(AdjCell, curCell) then
                  if bSumAdjValid
                        and not (Tcontainer(doc).UADEnabled and (sumAdjValue = 0)) then //leave adjustment blank for UAD report
                    curCell.LoadData(curCell.GetFormatedString(sumAdjValue))
                  else
                    if bSumAdjValid and (TContainer(doc).UADEnabled and (sumAdjValue = 0)) then
                      if CompareText(SStr,CStr) = 0 then
                      //curCell.LoadData('0')
                          curCell.LoadData('')  //github #152 do not show 0
                      else
                        curCell.LoadData('0')
                    else
                      curCell.LoadData('');
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

procedure TAutoCellAdjustEditor.btnDeleteClick(Sender: TObject);
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

procedure TAutoCellAdjustEditor.cbxAdjustbyDayClick(Sender: TObject);
begin
  FListModified := True;
end;

procedure TAutoCellAdjustEditor.FormShow(Sender: TObject);
begin
    AdjustDPISettings;
end;

//github 178: move the adjustAllComparables from the launch routine to formclosequery since the dialog is not modal.
procedure TAutoCellAdjustEditor.FormCloseQuery(Sender: TObject;  //when user close the form, we need to go through all adjustment calculation.
  var CanClose: Boolean);
begin
  canClose := True;
  if modalResult = mrOK then
    AdjustAllComparables(TContainer(FDoc));
end;

procedure TAutoCellAdjustEditor.btnCancelClick(Sender: TObject);
begin
  Close; //github 178
end;

end.

