unit uCompSelection;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{ This unit is one of the module for Service >> Analysis }
{ Comp Selection module to bring in all the included market data for user to pick comps}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, uGAgisOnlineMap, cGAgisBingMap, VrControls,
  VrLeds, RzTrkBar, StdCtrls, RzBckgnd, Grids_ts, TSGrid, osAdvDbGrid, Contnrs,
  Buttons, ExtCtrls, uContainer, uForms, Grids, BaseGrid, AdvGrid, uStatus,uGlobals,
  uUADObject, uCell, uGridMgr, UUADUtils, uBase, uMath, uForm,UCC_TrendAnalyzer,
  ComCtrls, UCompGlobal;

type
  CompID = record

    cType: String;
    cNo: Integer;
  end;




  TValueIndex = class(TObject)
    FValue: Double;
    FIndex: Integer;
    Constructor Create(AValue: Double; AIndex: Integer);
  end;

  TCompSelection = class(TAdvancedForm)
    TopPanel: TPanel;
    btnStreetView: TButton;
    LeftPanel: TPanel;
    RightPanel: TPanel;
    MapTopPanel: TPanel;
    lblSales2: TLabel;
    lblListings2: TLabel;
    lblSalesOutCount: TLabel;
    lblListOutCount: TLabel;
    vrLedSubject: TVrLed;
    VrLedSale: TVrLed;
    VrLedList: TVrLed;
    VrLedExcl: TVrLed;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    VrLedActive: TVrLed;
    Label18: TLabel;
    btnExcludeOutliers: TButton;
    btnDefineBoundary: TButton;
    btnRefreshMap: TButton;
    BingMaps: TGAgisBingMap;
    btnTransfer: TButton;
    btnClose: TButton;
    lblSales: TLabel;
    lblTotalSalesCount: TLabel;
    CompGrid: TtsGrid;
    Label2: TLabel;
    cmbxSort: TComboBox;
    btnRefresh: TButton;
    MktImage: TImage;
    procedure CompGridComboInit(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure cmbxSortChange(Sender: TObject);
    procedure CompGridColMoved(Sender: TObject; ToDisplayCol,
      Count: Integer; ByUser: Boolean);
    procedure CompGridComboRollUp(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure btnRefreshClick(Sender: TObject);
    procedure BingMapsMapShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnStreetViewClick(Sender: TObject);
  private
    { Private declarations }
    FDoc: TContainer;
    FGridRowHolder: TStringList;
    FMarketGrid: TosAdvDBGrid;
    FSubjectGrid: TtsGrid;

    FSubjAddress: String;
    FSubjPrice: Integer;
    FSubjGLA: Integer;
    FSubjBGLA: Integer;
    FSubjSite: Integer;
    FSubjAge: Integer;
    FSubjBedRms: Integer;
    FSubjBaths: Integer;
    FSubjFirePl: Integer;
    FSubjCars: Integer;
    FSubjPool: Integer;
    FSubjStory: Integer;
    FSortOption: Integer;
    FNeedsSwapping: Boolean;
    FDocCompTable    : TCompMgr2;
    FDocListingTable : TCompMgr2;
    FUADObject      : TUADObject;
    FGrid: TCompMgr2; //TGridMgr;
    FMainFormID     : Integer;
    FCompCount      : Integer;
    FSubjectLat, FSubjectLon: Double;
//    FRadiusCircle: TGAgisCircle;

    procedure LoadSubjForRanking;
    procedure LoadCompDataToSalesGrid;
    procedure SetupCompGrid;
    procedure LoadSubjectDataToGrid;
    procedure AddCompColumn;
    procedure SortColumnsBy2(DataType: Integer; reverseSort: Boolean);
    procedure SetOriginalOrder;
    function GetSortValue2(Col, Row: Integer): Double;
    procedure ClearCompNoOnGrid;
    function EMPTYImportTo: Boolean;
    procedure FillInCompData(r,col:Integer);

    function GetPropType(grid: TtsGrid; aCol: Integer): Integer;
    procedure LoadIni;
    procedure WriteIni;
    procedure LoadCompFrontView(col: Integer);
    procedure LoadStreetViewForComps(col: Integer);
    procedure ResetCompHeading;
    function GetFullHalfBath(Grid: TosAdvDbgrid; row:Integer):String;

  public
    { Public declarations }
    FSubjectMarket  : TComponent;
    FAnalysis       : TComponent;
    FMarketData     : TComponent;
    FAdjustments    : TComponent;
    FBuildReport    : TComponent;
    procedure InitTool(ADoc: TComponent);
    procedure LoadToolData;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MarketGrid: TosAdvDbGrid read FMarketGrid write FMarketGrid;
    property SubjectGrid: TtsGrid read FSubjectGrid write FSubjectGrid;
  end;

var
  CompSelection: TCompSelection;

const
  pMLS    = 1;
  p1004MC = 2;

  strClear = 'Clear';




  cpOrigSortOrder    = 0;
  cpSortBySalePrice  = 1;
  cpSortByYearBuilt  = 2;
  cpSortByDate       = 3;
  cpSortByGLA        = 4;
  cpSortByProx       = 5;

  cpSortByComp       = 6;

  MapPanel_Width  = 400;
  MAX_ROWS = 70;
  MAX_COLS = 20;


implementation

{$R *.dfm}
uses
  uUtil1,UCC_MLS_Globals, UCC_Globals, uWindowsInfo, UMain, uSubjectMarket,
  UServiceAnalysis, uUtil2, UMarketData, IniFiles, UAdjustments, uGoogleStreetView,
  UProgress, uBuildReport;

function GetCompNo(strDest: String): CompID;
var

  strNum: String;
begin
  result.cType := strNone;  // default: none
  result.cNo := 0;
  if CompareText(strDest,strNone) = 0 then
    exit;
  if CompareText(strDest, strSubject) = 0 then
    begin
      result.cType := strSubject;
      exit;
    end;
  if Pos(UpperCase(strComp),UpperCase(strDest)) = 1 then
    begin
      result.cType := strComp;
      strNum := Copy(strDest,length(strComp) + 1, length(strDest));
      result.cNo := StrToIntDef(strNum,0);
      end
  else
    if Pos(UpperCase(strListing),UpperCase(strDest)) = 1 then
      begin
        result.cType := strListing;
        strNum := Copy(strDest,length(strListing) + 1, length(strDest));
        result.cNo := StrToIntDef(strNum,0);
      end;
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


Constructor TValueIndex.Create(AValue: Double; AIndex: Integer);
begin
  inherited Create;
  FValue := AValue;
  FIndex := AIndex;
end;


constructor TCompSelection.Create(AOwner: TComponent);
begin
  inherited;
//  if not assigned(FDoc) then
  FDoc := Main.ActiveContainer;

  FDocCompTable := TCompMgr2.Create(True);
  FDocCompTable.BuildGrid(Fdoc, gtSales);  //we only deal with sales comp from Redstone

  FDocListingTable := TCompMgr2.Create(True);
  FDocListingTable.BuildGrid(Fdoc, gtListing);  //we only deal with sales comp from Redstone


  FNeedsSwapping := False;
  FSortOption := cpOrigSortOrder;

  FGridRowHolder := TStringList.Create;
  FUADObject := TUADObject.Create(FDoc);
end;

destructor TCompSelection.Destroy;
begin
  if assigned(FGridRowHolder) then
    FreeAndNil(FGridRowHolder);
  if assigned(FDocCompTable) then
    FreeAndNil(FDocCompTable);
  if assigned(FUADObject) then
    FreeAndNil(FUADObject);
  inherited;
end;


procedure TCompSelection.InitTool(ADoc: TComponent);
begin
  FDoc := TContainer(ADoc);
  SetupCompGrid;
  LoadIni;
end;


procedure TCompSelection.LoadToolData;

begin
  if FMarketGrid.Rows = 0 then
    begin
      CompGrid.Cols := 0;
      Exit;
    end;
  LoadSubjectDataToGrid;
  LoadCompDataToSalesGrid;
end;

procedure TCompSelection.LoadSubjForRanking;
begin
  FSubjGLA    := GetFirstIntValue(FDoc.GetCellTextByID(232));
  FSubjBGLA   := GetFirstIntValue(FDoc.GetCellTextByID(200));
  FSubjSite   := GetFirstIntValue(FDoc.GetCellTextByID(67));
  FSubjAge    := GetFirstIntValue(FDoc.GetCellTextByID(996));
  FSubjBedRms := GetFirstIntValue(FDoc.GetCellTextByID(230));
  FSubjBaths  := GetFirstIntValue(FDoc.GetCellTextByID(231));
  FSubjFirePl := GetFirstIntValue(FDoc.GetCellTextByID(322));
  FSubjCars   := GetFirstIntValue(FDoc.GetCellTextByID(355));
  FSubjPool   := GetFirstIntValue(FDoc.GetCellTextByID(340));
  FSubjStory  := GetFirstIntValue(FDoc.GetCellTextByID(148));
  FSubjPrice  := GetFirstIntValue(FDoc.GetCellTextByID(947));
end;

procedure TCompSelection.AddCompColumn;
var
  N: Integer;
begin
  with CompGrid do
    begin
      N := CompGrid.Cols;
      CompGrid.Col[N].Heading := Format('%d',[N-2]);  //0=titles; 1=subject
      Col[N].ReadOnly := True;
      CellReadOnly[N, 1] := roOff;
      CellButtonType[N, 1] := btCombo;
      CompGrid.FixedRowCount := 0
    end;
end;



procedure TCompSelection.CompGridComboInit(Sender: TObject;

  Combo: TtsComboGrid; DataCol, DataRow: Integer);
var
 i : Integer;

 FldList  : TStringList;
 idx, compNo, aRow : Integer;
 aItem : String;
begin
  FldList := TStringList.Create;
  try
    for i:= 1 to CompGrid.Cols do
      begin
        if CompGrid.Cell[i, _fCompNo] <> '' then
          begin
            compNo := GetValidInteger(COmpGrid.Cell[i, _fCompNo]);
            if compNo > 0 then
              begin
                aItem := CompGrid.Cell[i, _fCompNo];
                FldList.Add(aItem);
              end;
          end;
      end;
  if (DataCol > 2) and (DataRow = _fCompNo) then
    begin
      //Set the number of rows displayed to 5 and the return value column to 1
      Combo.DropDownRows := 21;
      Combo.ValueCol := 1;

      //Set AutoSearch on so user input or drop down causes automatic positioning
      Combo.AutoSearch := asTop;

      //Set the number of columns displayed to 2
      Combo.DropDownCols := 1;
      Combo.Grid.Cols := 1;
      Combo.Grid.HeadingOn := False;
      Combo.Grid.RowBarOn := False;
      Combo.Grid.Rows := 21;

      //preset the values at start
      Combo.Grid.StoreData := True;
      aRow := 0;
      for i:= 1 to 20 do
        begin
          aItem := Format('Comp %d',[i]);
          idx := FldList.IndexOf(aItem);
          if idx = -1 then
            begin
              inc(aRow);
              Combo.Grid.Cell[1, aRow] := aItem;
            end;
        end;
      Combo.Grid.Cell[1,aRow +1] := 'Clear';
    end;
 finally
   FldList.Free;
 end;
end;

function TCompSelection.GetFullHalfBath(Grid:TOsAdvDBGrid; row:Integer):String;
var
  aFull, aHalf: Integer;
  FHBath: String;
begin
  result := '';
  aFull := GetValidInteger(trim(Grid.Cell[_BathFullCount, row]));
  aHalf := GetValidInteger(trim(Grid.Cell[_BathHalfCount, row]));
  if aHalf < 0 then aHalf := 0;
  if (aFull > 0) or (aHalf > 0) then
    FHBath := Format('%d.%d',[aFull, aHalf]);
  result := FHBath;
end;



procedure TCompSelection.FillInCompData(r,col:Integer);

var

  gridRow, saleCount, compNo, aRow: Integer;
  bsmtGLA, bsmtFGLA: Integer;
  CityStZip: String;
  rr,br,fba,hba: Integer;
begin
    CompGrid.Cell[col, _fStreet]    := FMarketGrid.Cell[_StreetAdress, r];

    if FMarketGrid.Cell[_City, r] <> '' then
      begin
        CityStZip := Format('%s,%s %s',[FMarketGrid.Cell[_City, r],
                     FMarketGrid.Cell[_State, r],
                     FMarketGrid.Cell[_ZipCode, r]]);
        CompGrid.Cell[col, _fCityStZip] := CityStZip;
      end;

    CompGrid.Cell[col, _fVerAdjustment] := 'DESCRIPTION [Adj +/-]';

    CompGrid.Cell[col, _fRank]      := FMarketGrid.Cell[_Rank, r];
    CompGrid.Cell[col, _fProximity] := FMarketGrid.Cell[_Proximity, r];
    CompGrid.Cell[col, _fSalePrice] := FMarketGrid.Cell[_SalesPrice, r];
    CompGrid.Cell[col, _fSaleDate]  := FMarketGrid.Cell[_SalesDate, r];
    CompGrid.Cell[col, _fYearBuilt] := FMarketGrid.Cell[_YearBuilt, r];
    CompGrid.Cell[col, _fGLA]       := FMarketGrid.Cell[_GLA, r];
    CompGrid.Cell[col, _fBedRoom]     := FMarketGrid.Cell[_BedRoomTotal, r];
   // CompGrid.Cell[col, _fFullHalfBath]:= FMarketGrid.Cell[_BathTotal, r];
    CompGrid.Cell[col, _fFullHalfBath]:= GetFullHalfBath(FMarketGrid, r);
    CompGrid.Cell[col, _fSiteArea]    := FMarketGrid.Cell[_SiteArea, r];
    if trim(FMarketGrid.Cell[_Design,r]) = '1,' then
      CompGrid.Cell[col, _fDesign] := ''
    else
      CompGrid.Cell[col, _fDesign]      := FMarketGrid.Cell[_Design, r];
    CompGrid.Cell[col, _fStories]     := FMarketGrid.Cell[_Stories, r];
    CompGrid.Cell[col, _fActualAge]   := FMarketGrid.Cell[_Age, r];
    bsmtGLA := GetValidInteger(FMarketGrid.Cell[_BasementGLA, r]);
    bsmtFGLA := GetValidInteger(FMarketGrid.Cell[_BasementFGLA, r]);
    if (bsmtGLA > 0) or (bsmtFGLA > 0) then
      CompGrid.Cell[col, _fBasmtGLA]  := Format('%dsf%dsf',[bsmtGLA, bsmtFGLA]);
    rr := GetValidInteger(FMarketGrid.Cell[_BasementRecroom, r]);
    br := GetValidInteger(FMarketGrid.Cell[_BasementBedRoom, r]);
    fba := GetValidInteger(FMarketGrid.Cell[_BasementFullBath, r]);
    hba := GetValidInteger(FMarketGrid.Cell[_BasementHalfBath, r]);
    if (rr > 0) or (br > 0) or (fba > 0) or (hba > 0) then
      CompGrid.Cell[col, _fBasmtRoom] := Format('%drr%dbr%d.%dba%do',[rr,br,fba,hba,0]);
    CompGrid.Cell[col, _fFirePlace]   := FMarketGrid.Cell[_FireplaceQTY, r];
    CompGrid.Cell[col, _fPool]        := FMarketGrid.Cell[_PoolQTY, r];
    CompGrid.Cell[col, _fGarage]      := FMarketGrid.Cell[_GarageSpace, r];
    CompGrid.Cell[col, _fAPN]         := FMarketGrid.Cell[_APN, r];
    CompGrid.Cell[col, _fTotalRoom]   := FMarketGrid.Cell[_RoomTotal, r];
    CompGrid.Cell[col, _fMLSNumber]   := FMarketGrid.Cell[_MLSNUmber, r];
    CompGrid.Cell[col, _fDOM]         := FMarketGrid.Cell[_DOM, r];
    CompGrid.Cell[col, _fCondition]   := FMarketGrid.Cell[_PropertyCondition, r];
    CompGrid.Cell[col, _fQuality]     := FMarketGrid.Cell[_PropertyQuality, r];
end;

procedure TCompSelection.LoadStreetViewForComps(col: Integer);
var
  bMap: TBitMap;
  Street, CityStZip, Addr: String;
  gStreetView: TGoogleStreetView;
begin
  bMap := TBitMap.Create;
  try
   try
    Street      := CompGrid.Cell[col,_fStreet];
    CityStZip   := CompGrid.Cell[col, _fCityStZip];
    Addr := Format('%s, %s',[Street, CityStZip]);
    gStreetView := TGoogleStreetView.Create(nil);
    gStreetView.FFullAddr := Addr;
    gStreetView.Left := 20000;
    gStreetView.ShowModal;
    if gStreetView.FModalResult = mrOK then
      begin
        bMap.Assign(gStreetView.FGoogleBitMap);
      end;
    if bMap <> nil then
      begin
        CompGrid.cell[col,_fPicture] := BitmapToVariant(bMap);
        CompGrid.CellData[col,_fPicture] := bMap;
      end;
   except on E:Exception do
   end;
  finally
   gStreetView.Free;
  end;
end;



procedure TCompSelection.LoadCompFrontView(col: Integer);
var
  bMap: TBitMap;
begin
  if assigned(FDocCompTable) then
    begin
      if (col-2) < FDocCompTable.Count then  //comp starts with column 3
        begin
          bMap := FDocCompTable.Comp[col-2].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
          if bMap <> nil then
            begin
              CompGrid.cell[col,_fPicture] := BitmapToVariant(bMap);
              CompGrid.CellData[col,_fPicture] := bMap;
            end;
        end;
    end;
end;


procedure TCompSelection.LoadCompDataToSalesGrid;
var
  r, gridRow, saleCount, compNo, col, aRow: Integer;
  bsmtGLA, bsmtFGLA: Integer;
  CityStZip: String;
begin
  saleCount := 0;
  for r:= 1 to FMarketGrid.Rows do
    begin
       if FMarketGrid.CellCheckBoxState[_Include, r] = cbChecked then
         inc(saleCount);
    end;
  if saleCount = 0 then exit;
  FCompCount := saleCount;
  if FCompCount > Max_cols then
    FCompCount := Max_cols;
  if saleCount <= 0 then exit;    //github #607
  CompGrid.BeginUpdate;
  try
    gridRow := 0; compNo := 0;
    col := 2;
    //Pick the top 20 rows from Market Data Grid
    for r := 1 to FMarketGrid.Rows do
      begin    //col, row
        if FMarketGrid.CellCheckBoxState[_Include, r] = cbUnChecked then
          continue;
        inc(col);
        inc(CompNo);
        //if CompNo > MAX_COLS + 4 then break;
        if CompNo > FCompCount then break;
        CompGrid.Cols := col;  //current column + field name column + subject col

        AddCompColumn;      //add more if needed
        FillInCompData(r,col);

//        LoadStreetViewForComps(col);

      end;

    Application.ProcessMessages;

  finally
    CompGrid.EndUpdate;
    lblTotalSalesCount.Caption := Format('%d',[CompGrid.Cols-2]);
  end;
end;


procedure TCompSelection.SetupCompGrid;
begin
  CompGrid.Rows := MAX_ROWS;

  CompGrid.Cols := cSubject;

  CompGrid.Rows := MAX_ROWS;
  CompGrid.Cols := cSubject;
  //Set up the header title
  CompGrid.Cell[cField, _fHeader]        := 'Features';
  CompGrid.Cell[cField, _fCompNo]        := 'Comp #';
  CompGrid.Cell[cSubject, _fHeader]      := 'Subject Values';
  CompGrid.Cell[cField, _fRank]          := 'Rank';
  CompGrid.Cell[cField, _fStreet]        := 'Address';
  CompGrid.Cell[cField, _fCityStZip]     := 'City';
  CompGrid.Cell[cField, _fProximity]     := 'Proximity';
  CompGrid.Cell[cField, _fVerAdjustment] := 'VALUE ADJUSTMENTS';
  CompGrid.Cell[cField, _fDataSource]    := 'Data Source(s)';
  CompGrid.Cell[cField, _fVerSource]     := 'Ver Source(s)';
  CompGrid.Cell[cField, _fSalePrice]     := 'Sales Price';
  CompGrid.Cell[cField, _fSaleDate]      := 'Sales Date';
  CompGrid.Cell[cField, _fLocation]      := 'Location';
  CompGrid.Cell[cField, _fView]          := 'View';
  CompGrid.Cell[cField, _fLeaseHold]     := 'LeaseHold/Fee Simple';
  CompGrid.Cell[cField, _fGLA]           := 'Gross Liv. Area';
  CompGrid.Cell[cField, _fSiteArea]      := 'Site Area';
  CompGrid.Cell[cField, _fActualAge]     := 'Actual Age';
  CompGrid.Cell[cField, _fYearBuilt]     := 'Year Built';

  CompGrid.Cell[cField, _fBedRoom]       := 'Beds';
  CompGrid.Cell[cField, _fFullHalfBath]  := 'Full/Half Baths';

  CompGrid.Cell[cField, _fDOM]           := 'DOM';
  CompGrid.Cell[cField, _fMLSNUmber]     := 'MLS #';
  CompGrid.Cell[cField, _fListingStatus] := 'Listing Status';

  CompGrid.Cell[cField, _fExpiredDate]   := 'Expiration Date';
  CompGrid.Cell[cField, _fContractDate]  := 'Contract Date';
  CompGrid.Cell[cField, _fWithdrawnDate] := 'Withrawn Date';
  CompGrid.Cell[cField, _fSaleConcession]:= 'Sales or Financing';
  CompGrid.Cell[cField, _fFinConcession] := 'Concessions';
  CompGrid.Cell[cField, _fTotalRoom]     := 'Total Rooms';
  CompGrid.Cell[cField, _fBasmtGLA]      := 'Basmt & Finished';
  CompGrid.Cell[cField, _fBasmtRoom]     := 'Bsmt Rooms';

  CompGrid.Cell[cField, _fFuntionUtil]   := 'Func Utility';
  CompGrid.Cell[cField, _fHeatingCooling]:= 'Heating/Cooling';
  CompGrid.Cell[cField, _fEnergy]        := 'Energy';
  CompGrid.Cell[cField, _fGarage]        := 'Garage/Carport';

  CompGrid.Cell[cField, _fDesign]        := 'Design(Style)';
  CompGrid.Cell[cField, _fQuality]       := 'Quality of Construction';
  CompGrid.Cell[cField, _fCondition]     := 'Condition';

  CompGrid.Cell[cField, _fStories]       := 'Stories';
  CompGrid.Cell[cField, _fAPN]           := 'APN #';

  CompGrid.Cell[cField, _fTaxAmt]        := 'Tax Amount';
  CompGrid.Cell[cField, _fTaxYear]       := 'Tax Year';
  CompGrid.Cell[cField, _fCensusTract]   := 'Census Tract';

  CompGrid.Cell[cField, _fHOAFee]        := 'HOA Fee';
  CompGrid.Cell[cField, _fPatio]         := 'Porch/Patio/Deck';
  CompGrid.Cell[cField, _fGarage]        := 'Garage';
  CompGrid.Cell[cField, _fFireplace]     := 'Fireplaces';
  CompGrid.Cell[cField, _fPool]          := 'Pool';
  CompGrid.Cell[cField, _fOther]         := 'Other Item3';

  CompGrid.Cell[cField, _fNet]           := 'Net Adjustment';
  CompGrid.Cell[cField, _fAdj]           := 'Adj. Sales Price';
  CompGrid.Cell[cField, _fPercent]       := 'Net Adj';
  CompGrid.Cell[cField, _fGrsPercent]    := 'Gross Adj';

  CompGrid.Cell[cField, _fOwner]         := 'Owner of Public Record';
  CompGrid.Cell[cField, _fLegalDesc]     := 'Legal Description';
  CompGrid.Cell[cField, _fNeighborhood]  := 'Neighborhood Name';
  CompGrid.Cell[cField, _fBorrower]      := 'Borrower';
  CompGrid.Cell[cField, _fLatitude]      := 'Latitude';
  CompGrid.Cell[cField, _fLongitude]     := 'Longitude';
  CompGrid.Cell[cField, _fVerAdjustment] := 'VALUE ADJUSTMENTS';
  //... more
  CompGrid.Cell[cField, _fReo]           := 'REO';
  CompGrid.Cell[cField, _fShortSale]     := 'Short Sale';
  CompGrid.Cell[cField, _fListPriceCur]  := 'List Price Current';
  CompGrid.Cell[cField, _fListPriceOrg]  := 'List Price Original';
  CompGrid.Cell[cField, _fSiteView]      := 'Site View';
  CompGrid.Cell[cField, _fCounty]        := 'County';
  CompGrid.Cell[cField, _fNeighborhoodName] := 'Neighborhood Name';
  CompGrid.Cell[cField, _fComment]       := 'Comments';
  CompGrid.Cell[cField, _fSiteShape]     := 'Site Shape';
  CompGrid.Cell[cField, _fPropType]      := 'Property Type';
  CompGrid.Cell[cField, _fSubdivision]   := 'Subdivision';


  CompGrid.RowColor[cField]              := $00A0FEFA;
  CompGrid.RowColor[_fVerAdjustment]     := $00A0FEFA;

  CompGrid.Cell[cSubject, _fVerAdjustment] := 'DESCRIPTION';
  CompGrid.RowColor[_fVerAdjustment]       := $00A0FEFA;
//  CompGrid.RowFont[_fVerAdjustment].Style  := [fsBold];


  CompGrid.Col[cField].Color          := rgb(204, 242, 255);
  CompGrid.Col[cField].HeadingColor   := rgb(204, 242, 255);  //$00B4C8B4;
  CompGrid.Col[cSubject].Color        := $00A0FEFA;
  CompGrid.Col[cSubject].HeadingColor := $00A0FEFA;
  CompGrid.RowColor[cField] := $00A0FEFA;


  CompGrid.FixedRowCount := 0;
end;

procedure TCompSelection.LoadSubjectDataToGrid;
var

  row: Integer;

  bMap: TBitMap;

  aSaleDate: String;

begin

  if getValidInteger(FDoc.GetCellTextByID(947)) > 0 then

    CompGrid.Cell[cSubject, _fSalePrice] := Format('$ %s',[FDoc.GetCellTextByID(947)]);

   aSaleDate := FDoc.GetCellTextByID(960);

   if aSaleDate = '' then

     aSaleDate := FDoc.GetCellTextByID(1132);

   if aSaleDate = '' then

     aSaleDate := DateToStr(Date);

  CompGrid.Cell[cSubject, _fSaleDate]  := aSaleDate;

  CompGrid.Cell[cSubject, _fStreet]    := FDoc.GetCellTextByID(925);

  CompGrid.Cell[cSubject, _fCityStZip] := FDoc.GetCellTextByID(926);

  CompGrid.Cell[cSubject, _fDataSource]:= FDoc.GetCellTextByID(930);

  CompGrid.Cell[cSubject, _fVerSource] := FDoc.GetCellTextByID(931);

  CompGrid.Cell[cSubject, _fGLA]       := Format('%s sf',[FDoc.GetCellTextByID(1004)]);

  CompGrid.Cell[cSubject, _fQuality]   := FDoc.GetCellTextByID(994);

  CompGrid.Cell[cSubject, _fCondition] := FDoc.GetCellTextByID(998);

  CompGrid.Cell[cSubject, _fSiteArea]  := FDoc.GetCellTextByID(976);

  CompGrid.Cell[cSubject, _fView]      := FDoc.GetCellTextByID(984);

  CompGrid.Cell[cSubject, _fLocation]  := FDoc.GetCellTextByID(962);

  CompGrid.Cell[cSubject, _fLeaseHold] := FDoc.GetCellTextByID(964);

  CompGrid.Cell[cSubject, _fDesign]    := FDoc.GetCellTextByID(149);

  CompGrid.Cell[cSubject, _fActualAge] := FDoc.GetCellTextByID(996);

  CompGrid.Cell[cSubject, _fYearBuilt] := FDoc.GetCellTextByID(151);

  CompGrid.Cell[cSubject, _fTotalRoom]  := FDoc.GetCellTextByID(1041);

  CompGrid.Cell[cSubject, _fBedRoom]    := FDoc.GetCellTextByID(1042);

  CompGrid.Cell[cSubject, _fFullHalfBath] := FDoc.GetCellTextByID(1043);

  CompGrid.Cell[cSubject, _fBasmtGLA]  := FDoc.GetCellTextByID(1006);

  CompGrid.Cell[cSubject, _fBasmtRoom]  := FDoc.GetCellTextByID(1008);

  CompGrid.Cell[cSubject, _fFuntionUtil]  := FDoc.GetCellTextByID(1010);

  CompGrid.Cell[cSubject, _fHeatingCooling]  := FDoc.GetCellTextByID(1012);

  CompGrid.Cell[cSubject, _fEnergy]  := FDoc.GetCellTextByID(1014);

  CompGrid.Cell[cSubject, _fGarage]  := FDoc.GetCellTextByID(1016);

  CompGrid.Cell[cSubject, _fPool]  := FDoc.GetCellTextByID(1022);

  CompGrid.Cell[cSubject, _fFireplace]  := FDoc.GetCellTextByID(1020);

  CompGrid.Cell[cSubject, _fPatio]  := FDoc.GetCellTextByID(1018);

  if getValidInteger(FDoc.GetCellTextByID(148)) > 0 then

    begin

      CompGrid.Cell[cSubject, _fStories] := Format('%d',[GetValidInteger(FDoc.GetCellTextByID(148))]);

    end;

  CompGrid.Cell[cSubject, _fAPN]     := FDoc.GetCellTextByID(60);

  if getValidInteger(FDoc.GetCellTextByID(368)) > 0 then

    CompGrid.Cell[cSubject, _fTaxAmt]  := Format('$ %s',[FDoc.GetCellTextByID(368)]);

  CompGrid.Cell[cSubject, _fTaxYear] := FDoc.GetCellTextByID(367);

  CompGrid.Cell[cSubject, _fCensusTract] := FDoc.GetCellTextByID(599);

  if getValidInteger(FDoc.GetCellTextByID(390)) > 0 then

    begin

      CompGrid.Cell[cSubject, _fHOAFee]  := FDoc.GetCellTextByID(390);

      if FDoc.GetCellTextByID(2043) = 'X' then

        CompGrid.Cell[cSubject, _fHOAFee] := Format('%s per Month',[FDoc.GetCellTextByID(390)])

      else if FDoc.GetCellTextByID(2042) = 'X'then

        CompGrid.Cell[cSubject, _fHOAFee] := Format('%s per Year',[FDoc.GetCellTextByID(390)])

    end;

  CompGrid.Cell[cSubject, _fOwner]   := FDoc.GetCellTextByID(58);

  CompGrid.Cell[cSubject, _fLegalDesc] := FDoc.GetCellTextByID(59);

  CompGrid.Cell[cSubject, _fNeighborhood] := FDoc.GetCellTextByID(595);

  CompGrid.Cell[cSubject, _fBorrower] := FDoc.GetCellTextByID(45);


  //Set subject column to lite yellow and READ ONLY

  CompGrid.Col[cSubject].Color   := RGBToColor(255, 255, 179);

  if assigned(FDocCompTable) then
    begin
      bMap := FDocCompTable.Comp[0].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
      if assigned(bMap) and not bMap.Empty then
        begin
          CompGrid.cell[cSubject,_fPicture] := BitmapToVariant(bMap);
          CompGrid.CellData[cSubject,_fPicture] := bMap;
        end
      else
        begin
          LoadStreetViewForComps(cSubject);
        end;
    end;
end;


procedure TCompSelection.SetOriginalOrder;

var
  n: integer;
begin
  for n := 3 to CompGrid.Cols do
    CompGrid.DisplayColnr[n] := n;
  FNeedsSwapping := False;
end;

procedure TCompSelection.cmbxSortChange(Sender: TObject);
begin
  if (cmbxSort.ItemIndex <> FSortOption) then
    case cmbxSort.ItemIndex of
      cpOrigSortOrder:  SetOriginalOrder;
      cpSortBySalePrice: SortColumnsBy2(cpSortBySalePrice, ControlKeyDown);
      cpSortByYearBuilt:   SortColumnsBy2(cpSortByYearBuilt, ControlKeyDown);
      cpSortByDate:     SortColumnsBy2(cpSortByDate, ControlKeyDown);
      cpSortByGLA:      SortColumnsBy2(cpSortByGLA, ControlKeyDown);
      cpSortByProx:     SortColumnsBy2(cpSortByProx, ControlKeyDown);
      cpSortByComp:     SortColumnsBy2(cpSortByComp, ControlKeyDown);
    end;
  FSortOption := cmbxSort.ItemIndex;
//  ClearCompNoOnGrid;
end;

procedure TCompSelection.ClearCompNoOnGrid;
var
  col: Integer;
begin
  for col := 2 to CompGrid.Cols do
    begin
      CompGrid.Cell[col, _fCompNo] := '';
    end;
end;

function TCompSelection.GetSortValue2(Col, Row: Integer): Double;
begin
  result := 0;
  case Row of
    _fSalePrice: result := GetStrValue(CompGrid.Cell[Col,_fSalePrice]);
    _fSaleDate:  result := Double(GetValidDate(CompGrid.Cell[Col,_fSaleDate]));
    _fGLA:       result := GetStrValue(CompGrid.Cell[Col,_fGLA]);
    _fYearBuilt: result := GetStrValue(CompGrid.Cell[Col,_fYearBuilt]);
    _fProximity: result := GetStrValue(CompGrid.Cell[Col,_fProximity]);
    _fCompNo:
      if CompGrid.Cell[Col,_fCompNo] <> '' then
        result := GetStrValue(CompGrid.Cell[Col,_fCompNo])
      else
        result := 9999;
//    row2Adj:   result := GetStrValue(CompGrid.Cell[Col,row2Adj]);

 (*   rowAdj: begin   //sort by absolute min between sub and comp
      SubPrice := GetStrValue(CompGrid.Cell[2,rowPrice]);
      CmpPrice := GetStrValue(CompGrid.Cell[Col,rowAdj]);
      result := Abs(SubPrice - CmpPrice);
    end;     *)
  end;
end;


procedure TCompSelection.SortColumnsBy2(DataType: Integer; reverseSort: Boolean);
var
  i: Integer;
  List: TObjectList;
begin
  List := TObjectList.Create(True);
  try
    //create the list to sort
    for i := 3 to CompGrid.Cols do
      case DataType of
        cpSortBySalePrice: List.Add( TValueIndex.Create(GetSortValue2(i,_fSalePrice), i));
        cpSortByYearBuilt: List.Add( TValueIndex.Create(GetSortValue2(i,_fYearBuilt), i));
        cpSortByDate:      List.Add( TValueIndex.Create(GetSortValue2(i,_fSaleDate), i));
        cpSortByGLA:       List.Add( TValueIndex.Create(GetSortValue2(i,_fGLA), i));
        cpSortByProx:      List.Add( TValueIndex.Create(GetSortValue2(i,_fProximity), i));
        cpSortByComp:      List.Add( TValueIndex.Create(GetSortValue2(i,_fCompNo), i));
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
    ResetCompHeading;
  end;
end;

procedure TCompSelection.ResetCompHeading;
var
  c, i:Integer;
begin
  i := 0;
  CompGrid.BeginUpdate;
  try
    for c:=3 to CompGrid.Cols do
      begin
        inc(i);
        CompGrid.Col[c].Heading := Format('%d',[i]);
      end;
  finally
    CompGrid.EndUpdate;
  end;
end;


procedure TCompSelection.CompGridColMoved(Sender: TObject; ToDisplayCol,
  Count: Integer; ByUser: Boolean);
begin
  FNeedsSwapping := True;
end;

function TCompSelection.EMPTYImportTo: Boolean;
var

  aCol: Integer;

  found: Boolean;

begin

  found := False;

  for aCol := 1 to CompGrid.Cols do

    begin

      if CompGrid.Cell[aCol, _fCompNo] <> '' then

        begin

          found := True;

          break;

        end;

    end;

  result := Found;

end;




(*
procedure TCompSelection.PopulateF8025_MarketTrends(doc: TContainer);
var
  thisForm: TDocForm;
begin
  thisForm := doc.GetFormByOccurance(8025, 0, True);
  if assigned(thisForm) then
    begin
      populateTrendChart(doc, thisForm, cMonthlyTrend, 12);
      populateTrendChart(doc, thisForm, cAbsorption, 14);
      populateTrendChart(doc, thisForm, cSupply, 16);
      populateTrendChart(doc, thisForm, cPriceTrend, 18);
    end;
end;

procedure TCompSelection.SaveTrendChartToFile(const aChartType: Integer; var fileName: String);
begin
  case aChartType of
    cMonthlyTrend:
      TSubjectMarket(FSubjectMarket).chartSaleListUnits.SaveToMetafileEnh(fileName);
    cPriceSqft:
      TSubjectMarket(FSubjectMarket).ChartSalesPricePerSqft.SaveToMetafileEnh(fileName);
    cPriceRatio:
      TSubjectMarket(FSubjectMarket).chartSaleListRatio.SaveToMetafileEnh(fileName);
  end;
end;


procedure TCompSelection.populateTrendChart(doc: TContainer; var thisForm: TDocForm; aChartType: Integer; cellNo: Integer);
const
  EMF_ChartName = 'TrendChart.Emf';
var
  aEMF_FileName, aChartName: String;
  aMetaFile: TMetaFile;
  aBitMap: TBitmap;
begin
  aChartName := Format('%d%s',[aChartType, EMF_ChartName]);
  aEMF_FileName := CreateTempFilePath(aChartName);       //put in TEMP
  SaveTrendChartToFile(aChartType, aEMF_FileName);
  aMetafile := TMetaFile.Create;
  aBitMap := TBitmap.Create;
  try
    aMetaFile.LoadFromFile(aEMF_FileName);
    with aBitMap do
      begin
        Height := aMetafile.Height;
        Width  := aMetafile.Width;
        Canvas.Draw(0, 0, aMetaFile);
        if assigned(aBitmap) and not aBitmap.Empty then
          thisForm.SetCellBitMap(1, cellNo, aBitmap);
      end;
  finally
    if fileExists(aEMF_FileName) then
      DeleteFile(aEMF_FileName);
    if assigned(aBitmap) then
      aBitmap.Free;
    if assigned(aMetaFile) then
      aMetaFile.Free;
  end;
end;
*)


procedure TCompSelection.CompGridComboRollUp(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
var
  c: Integer;
begin
  if DataRow = _fCompNo then
    begin
      if CompareText(CompGrid.Cell[DataCol, DataRow], strClear) = 0 then
        CompGrid.Cell[DataCol, DataRow] := '';
      if assigned(FBuildReport) then
        TBuildReport(FBuildReport).CompGrid := CompGrid;

      SortColumnsBy2(cpSortByComp, ControlKeyDown);

      if CompGrid.Cell[DataCol, DataRow] <> '' then
        begin
          for c:= 3 to CompGrid.Cols do
            CompGrid.Col[c].Heading := '';
           // CompGrid.Col[c].Heading := Format('%d',[c-2]);   //clear the header sequence #
        end;

    end;
end;


procedure TCompSelection.btnRefreshClick(Sender: TObject);
begin
  LoadToolData;
  if assigned(TAdjustments(FAdjustments)) then
    TAdjustments(FAdjustments).btnApply.click;
  btnStreetView.Click;
end;

procedure TCompSelection.BingMapsMapShow(Sender: TObject);
begin
//  RedrawMapCircles;
//  FMapExecuted := True;  //Set to true so next time we don't need to read the map
end;

function TCompSelection.GetPropType(grid: TtsGrid; aCol: Integer): Integer;
var
  propType: Integer;
begin
  propType := ckSale;
//  if Grid.Cell[aCol, _fCompType] = typListing then
//    propType := ckListing;
  result := propType;
end;


procedure TCompSelection.FormResize(Sender: TObject);
begin
//  btnTransfer.Left := btnRefresh.left + btnRefresh.width +20;
//  btnClose.Left    := topPanel.width - btnClose.width - 10;
end;

procedure TCompSelection.WriteIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer

  With PrefFile do
  begin
    WriteBool('Import', 'MLSUADAutoConvert', appPref_MLSImportAutoUADConvert);
    WriteBool('Import', 'MLSOverwriteData', appPref_MLSImportOverwriteData);
  end;
end;

procedure TCompSelection.LoadIni;
//var
//  PrefFile: TMemIniFile;
//  IniFilePath : String;
begin
(*
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  With PrefFile do
  begin
    appPref_MLSImportAutoUADConvert := ReadBool('Import', 'MLSUADAutoConvert', True);
    appPref_MLSImportOverwriteData := ReadBool('Import', 'MLSOverwriteData', True);
    chkUADConvert.Checked := appPref_MLSImportAutoUADConvert;
    chkOverwrite.Checked  := appPref_MLSImportOverwriteData;
  end;
*)
end;


procedure TCompSelection.btnStreetViewClick(Sender: TObject);
var
  col: Integer;
  progressBar: TProgress;
  bMap:TBitMap;
  min, max: Integer;
begin
  min := 0;
  max := CompGrid.Cols-1;
  ProgressBar := TProgress.Create(self, min, max, 0, 'Loading Google Street View ...');
  try
    if assigned(FDocCompTable) then
      begin
        bMap := FDocCompTable.Comp[0].Photo.ThumbnailImage;             //c=0:subj; c=1:comp1; c=2:comp2; etc
        try
          if assigned(bMap) and not bMap.Empty then
            begin
              CompGrid.cell[cSubject,_fPicture] := BitmapToVariant(bMap);
              CompGrid.CellData[cSubject,_fPicture] := bMap;
            end
          else
            begin
              ProgressBar.StatusNote.Caption := Format('Property: %s',[CompGrid.Cell[cSubject, _fStreet]]);
              LoadStreetViewForComps(cSubject);
              ProgressBar.IncrementProgress;
            end;
        finally
        end;
      end;


    for col := 3 to CompGrid.Cols do
      begin
        ProgressBar.StatusNote.Caption := Format('Property: %s',[CompGrid.Cell[col, _fStreet]]);
        LoadStreetViewForComps(col);
        ProgressBar.IncrementProgress;
      end;
    CompGrid.Refresh;
  finally
    ProgressBar.Free;
    if assigned(FBuildReport) then
      TBuildReport(FBuildReport).CompGrid := CompGrid;
  end;
end;

end.
