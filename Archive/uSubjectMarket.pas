unit uSubjectMarket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzTabs, uContainer,UCC_TrendAnalyzer, TeEngine,
  Series, TeeProcs, Chart, TSGrid, Grids_ts, osAdvDbGrid, Mask, RzEdit,
  ComCtrls, StdCtrls, ExtCtrls, uMath, uForm, uBase;

type
  TSubjectMarket = class(TForm)
    LeftPanel: TPanel;
    panelTopInfo: TPanel;
    lblEffDateTitle: TLabel;
    lblTrendLine: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    chkPendingIsSettled: TCheckBox;
    chkActiveListingOnly: TCheckBox;
    edtPercent: TEdit;
    UpDnPercent: TUpDown;
    edtEffectiveDate: TRzDateTimeEdit;
    Panel1: TPanel;
    ts1004MCActivityGrid: TtsGrid;
    ScrollBox: TScrollBox;
    panelTrends: TPanel;
    Label2: TLabel;
    tsGrid1: TtsGrid;
    ChartSalesPricePerSqft: TChart;
    LineSeries1: TLineSeries;
    Series10: TLineSeries;
    chartSaleListUnits: TChart;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series16: TLineSeries;
    Series17: TLineSeries;
    chartSaleListRatio: TChart;
    Series9: TLineSeries;
    Series11: TLineSeries;
    cbxSaleDOMShowTrend: TCheckBox;
    cbxListDOMShowTrend: TCheckBox;
    cbxSaleTotalShowTrend: TCheckBox;
    cbxListTotalShowTrend: TCheckBox;
    Splitter1: TSplitter;
    rbtnLast6Mos: TRadioButton;
    rbtnNoTrends: TRadioButton;
    panelTrendIncators: TPanel;
    Label4: TLabel;
    panelTotalSales: TPanel;
    rbSaleTIncrease: TRadioButton;
    rbSaleTStable: TRadioButton;
    rbSaleTDecline: TRadioButton;
    panelMonthsSupply: TPanel;
    rbSupplyIncrease: TRadioButton;
    rbSupplyStable: TRadioButton;
    rbSupplyDecline: TRadioButton;
    panelTotalListings: TPanel;
    rbListTIncrease: TRadioButton;
    rbListTStable: TRadioButton;
    rbListTDecline: TRadioButton;
    panelAbsorption: TPanel;
    rbAbsorptionIncrease: TRadioButton;
    rbAbsorptionStable: TRadioButton;
    rbAbsorptionDecline: TRadioButton;
    panelSalePrice: TPanel;
    rbSalePIncrease: TRadioButton;
    rbSalePStable: TRadioButton;
    rbSalePDecline: TRadioButton;
    panelSalesDOM: TPanel;
    rbSaleDomIncrease: TRadioButton;
    rbSaleDomStable: TRadioButton;
    rbSaleDomDecline: TRadioButton;
    panelListingsPrice: TPanel;
    rbListPIncrease: TRadioButton;
    rbListPStable: TRadioButton;
    rbListPDecline: TRadioButton;
    panelListingsDOM: TPanel;
    rbListDomIncrease: TRadioButton;
    rbListDomStable: TRadioButton;
    rbListDomDecline: TRadioButton;
    panelSaleListRatio: TPanel;
    rbSLRatioIncrease: TRadioButton;
    rbSLRatioStable: TRadioButton;
    rbSLRatioDecline: TRadioButton;
    PanelPriceSqft: TPanel;
    rbSalesPSqFtIncrease: TRadioButton;
    rbSalesPSqFtStable: TRadioButton;
    rbSalesPSqFtDecline: TRadioButton;
    btnPopulate1004MC: TButton;
    Image1: TImage;
    procedure chkPendingIsSettledClick(Sender: TObject);
    procedure rbtnLast12MosClick(Sender: TObject);
    procedure rbtnLast6MosClick(Sender: TObject);
    procedure rbtnLast3MosClick(Sender: TObject);
    procedure chkActiveListingOnlyClick(Sender: TObject);
    procedure edtEffectiveDateExit(Sender: TObject);
    procedure btnPopulate1004MCClick(Sender: TObject);
    procedure rbtnNoTrendsClick(Sender: TObject);
  private
    { Private declarations }
    FDoc: TContainer;
    EffectiveDate: TDateTime;
    FErrMsg: String;
    EffectiveDateStr: String;
    FTrendAnalyzer: TTrendAnalyzer;       //owned by Main Analysis Unit
    FActiveListingOnly: Boolean;          //use active listings only in Listing DOM calculation
    FPendingSaleIsSettled: Boolean;
    FTrendingCompleted: Boolean;
    FMarketGrid: TosAdvDBGrid;
    procedure LoadDataToAnalyzer(ATrendAnalyzer: TTrendAnalyzer);
    procedure DoTrendAnalysis;
    procedure DisplayAnalyzerDataInTrendGrid(ATrendAnalyzer: TTrendAnalyzer);
    procedure DisplayAnalyzerDataInTrendRateChange(ATrendAnalyzer: TTrendAnalyzer);
    procedure DisplayAnalyzerDataInTrendStatus(ATrendAnalyzer: TTrendAnalyzer);
    procedure DisplayAnalyzerDataInTrendCharts(ATrendAnalyzer: TTrendAnalyzer);
    procedure DisplayAnalyzerDataIn1004MCGrid(ATrendAnalyzer: TTrendAnalyzer);
    procedure SetTrendStatus(stableLevel, percentChg: Real; rbIncrease, rbStable, rbDecline: TRadioButton);
    procedure DrawSaleTotalTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure DrawListTotalTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure DrawSalePriceTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure DrawListPriceTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure DrawSaleDOMTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure DrawListDOMTrendLine(drawIt: Boolean; ATrendInterval: Integer);
    procedure SetTrendLineInterval(const Value: Integer);
    procedure SetTrendGridRowTitles;
    procedure PopulateF8025_MarketTrends(doc: TContainer);
    procedure populateTrendChart(doc: TContainer; var thisForm: TDocForm; aChartType: Integer; cellNo: Integer);
    procedure write1004MCData(doc: TContainer);

  public
    { Public declarations }
    FMarketData: TComponent;
    procedure SaveTrendChartToFile(const aChartType: Integer; var fileName: String);
    procedure PopulateF850_1004MC(doc: TContainer);
    procedure PerformTrendAnalysis;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitTool(ADoc: TComponent);
    procedure LoadToolData;

    property TrendAnalyzer:TTrendAnalyzer read FTrendAnalyzer write FTrendAnalyzer;
    property MarketGrid: TosAdvDbGrid read FMarketGrid write FMarketGrid;
  end;


const
  pMLS    = 1;
  p1004MC = 2;
  cMonthlyTrend   = 1;
  cAbsorption     = 2;
  cSupply         = 3;
  cPriceTrend     = 4;
  cPriceSqft      = 5;
  cDOM            = 6;
  cPriceRatio     = 7;
  cAdjustment     = 8;

implementation

{$R *.dfm}
  uses
    UCC_MLS_Globals, UUtil1, DateUtils, uStatus, uGlobals, uMain,
    UServiceAnalysis, uMarketData;

constructor TSubjectMarket.Create(AOwner: TComponent);
begin
  inherited;
//  btnDebug.Visible := not ReleaseVersion;
  FTrendAnalyzer := TTrendAnalyzer.Create;
  InitTool(AOwner);
end;

destructor TSubjectMarket.Destroy;
begin
  if assigned(FTrendAnalyzer) then
    FreeAndNil(FTrendAnalyzer);
  inherited;
end;


procedure TSubjectMarket.InitTool(ADoc: TComponent);
begin
  if not assigned(ADoc) then
    FDoc := TContainer(Main.ActiveContainer)
  else
    FDoc := TContainer(ADoc);
  FPendingSaleIsSettled := chkPendingIsSettled.Checked;
  FActiveListingOnly   := True;     //chkActiveListingOnly.Checked;

  FPendingSaleIsSettled := chkPendingIsSettled.Checked;
  FActiveListingOnly   := True;     //chkActiveListingOnly.Checked;
//  FTrendAnalyzer.TrendInterval := GetTrendLineInterval;   //what is the default

  FTrendingCompleted := False;    //set to true when analysis completes
  FErrMsg := '';
  EffectiveDateStr := FDoc.GetCellTextByID(1132);
  if EffectiveDateStr = '' then
    EffectiveDateStr := DateToStr(Date);
  EffectiveDate := StrToDate(EffectiveDateStr);  
  edtEffectiveDate.Text := EffectiveDateStr;
  LoadToolData;
end;

procedure TSubjectMarket.LoadToolData;
begin
  SetTrendGridRowTitles;
  case FTrendAnalyzer.TrendInterval of
    tdLast6Months  : rbtnLast6Mos.Checked := True;
    tdNone         : rbtnNoTrends.Checked := True;
    else
      rbtnLast6Mos.Checked := True;
  end;
  PerformTrendAnalysis;
end;



procedure TSubjectMarket.LoadDataToAnalyzer(ATrendAnalyzer: TTrendAnalyzer);
var
  r, numComps, numDays: Integer;
  aStatus: String;
  dataPt: TDataPt;
  hasDOM, hasStatusDate, hasContractDate, hasSaleDate: Boolean;
  aSoldDate, aStatusDate, aListDate: TDateTime;
  ok2Add: Boolean;
  zeroListDates, zeroSaleDates: Integer;
  aStr: String;
  aListPrice: Integer;
  PendingSaleIsSettled: Boolean;  //TODO
  ListPriceCur: String;
begin
  if FMarketGrid = nil then exit;
  ATrendAnalyzer.DataPts.Clear;        //start fresh each time
  NumComps := FMarketGrid.Rows;
  if numComps = 0 then exit;
  numComps := numComps - 1;

  zeroSaleDates := 0;        //count unusable propertues that have zero dates
  zeroListDates := 0;
  for r := 1 to numComps do
    begin
      Ok2Add := False;
      if (FMarketGrid.Cell[_Include, r] = 0) then
        continue;
      ListPriceCur := FMarketGrid.Cell[_ListingPriceCurrent, r];
      if GetValidInteger(ListPriceCur) = 0 then
        ListPriceCur := FMarketGrid.Cell[_ListingPriceOriginal, r];
      if //(FMarketGrid.Cell[_Include, r] = 1) and
         (GetValidInteger(ListPriceCur) > 0) then
        begin
          //LIST DATE -0 check if we ahve one
          if FMarketGrid.Cell[_ListingDateCurrent, r] <> '' then
            aListDate := StrToDate(FMarketGrid.Cell[_ListingDateCurrent, r])
          else
            aListDate := 0;
        end;
         //LIST PRICE: check if we have one
        if GetValidInteger(ListPriceCur)  > 0 then
          aListPrice := GetValidInteger(ListPriceCur)
        else
          aListPrice := 0;

         ok2Add := (aListDate <> 0) and (aListPrice <> 0);   //can we use this property
         if not ok2Add then
           inc(zeroListDates);   //count the incomplete listings
      if ok2Add then
        begin
          dataPt := TDataPt.Create;
          dataPt.TestID     := r;

          dataPt.ListDate   := aListDate;    //Current or original list date
          dataPt.ListPrice  := aListPrice;   //Current or original list price
          dataPt.DOM        := StrToIntDef(Trim(FMarketGrid.Cell[_DOM, r]), 0);
          dataPt.GLA        := StrToIntDef(Trim(FMarketGrid.Cell[_GLA, r]), 0);
          dataPt.Beds       := StrToIntDef(Trim(FMarketGrid.Cell[_BedRoomTotal,r]),0);

          hasDOM          := Trim(FMarketGrid.Cell[_DOM, r]) <> '';
          hasContractDate := trim(FMarketGrid.Cell[_ContractDate, r]) <> '';
          hasStatusDate   := trim(FMarketGrid.Cell[_ListingStatusDate, r]) <> '';
          hasSaleDate     := trim(FMarketGrid.Cell[_SalesDate, r]) <> '';

          if hasStatusDate then
            aStatusDate   := StrToDateTime(FMarketGrid.Cell[_ListingStatusDate, r])
          else
           aStatusDate   := EffectiveDate;  //if no status date use effective date
          aStatus := FMarketGrid.Cell[_ListingStatus, r]; //This is listing status: 'Sold', "Active', 'Pending'
          //handle sold listings
          if POS('SOLD', UpperCase(aStatus)) > 0 then
            begin
              dataPt.Status       := lsSold;

              //For SOLD, always use sales date
              aSoldDate := 0;
              if PendingSaleIsSettled then  //for pending as sales use contract date
                begin
                  if hasContractDate then
                    aSoldDate := StrToDateTime(FMarketGrid.Cell[_ContractDate, r])
                  else if hasSaleDate then
                    aSoldDate  := StrToDateTime(FMarketGrid.Cell[_SalesDate, r]);
                end
              else  //always use sales date when it's not pending as settled
                if hasSaleDate then
                  aSoldDate  := StrToDateTime(FMarketGrid.Cell[_SalesDate, r]);
              dataPt.StatDate     := aSoldDate;
              dataPt.Price        := StrToIntDef(FMarketGrid.Cell[_SalesPrice, r], 0);

              numDays := DaysBetween(dataPt.StatDate, dataPt.ListDate);
              if dataPt.DOM <> numDays then
                dataPt.DOM := numDays;
              //is this a good sales dataPt to use
              if aSoldDate = 0 then
                begin
                  ok2Add := False;
                  Inc(zeroSaleDates);
                end;
            end
          //handle active listings
          else if (POS('ACTIVE', UpperCase(aStatus)) > 0) or (POS('OPEN', UpperCase(aStatus)) > 0) or
          (POS('LIST', UpperCase(aStatus)) > 0) then
            begin
              dataPt.Status   := lsActive;
              dataPt.StatDate := EffectiveDate;    //its active on effective date
              dataPt.Price    := aListPrice;

              numDays := DaysBetween(dataPt.StatDate, dataPt.ListDate);
              if not hasDOM or (dataPt.DOM <> numDays) then
                dataPt.DOM := numDays;
            end
          //handle pending listings
          else if (POS('PEND', UpperCase(aStatus)) > 0) or (POS('ESCROW', UpperCase(aStatus)) > 0)
               or (POS('CONT', UpperCase(aStatus)) > 0) then
            begin
              dataPt.Status   := lsPending;
              dataPt.StatDate := EffectiveDate;    //still active on effective date
              dataPt.Price    := aListPrice;

              //calc the DOM if not one
              if not hasDOM then //use Status Date
                begin
                  dataPt.StatDate := aStatusDate;
                  dataPt.DOM := DaysBetween(dataPt.StatDate, dataPt.ListDate);
                end;
            end
          //handle expired listings
          else if POS('EXPIRE', UpperCase(aStatus)) > 0 then
            begin
              dataPt.Price    := aListPrice;
              dataPt.Status   := lsExpired;

              //calc status date if not one
              if not hasStatusDate and hasDOM then
                dataPt.StatDate := incDay(dataPt.ListDate, dataPt.DOM);

              //calc the DOM if not one
              if not hasDOM and hasStatusDate then //use Status Date
                begin
                  dataPt.StatDate := aStatusDate;
                  dataPt.DOM := DaysBetween(dataPt.StatDate, dataPt.ListDate);
                end;
            end
          //handle withdrawn listings
          else if POS('WITHDRAW', UpperCase(aStatus)) > 0 then
            begin
              dataPt.Price    := StrToIntDef(FMarketGrid.Cell[_ListingPriceCurrent,r], 0);
              dataPt.Status   := lsWithDrwn;

              //calc status date if not one
              if not hasStatusDate and hasDOM then
                dataPt.StatDate := incDay(dataPt.ListDate, dataPt.DOM);

              //calc the DOM if not one
              if not hasDOM and hasStatusDate then //use Status Date
                begin
                  dataPt.StatDate := aStatusDate;
                  dataPt.DOM := DaysBetween(dataPt.StatDate, dataPt.ListDate);
                end;
            end
          //handle unknown properties
          else
            begin
              dataPt.Price    := aListPrice;
              dataPt.Status   := lsUnknown;

              //calc status date if not one
              if not hasStatusDate and hasDOM then
                dataPt.StatDate := incDay(dataPt.ListDate, dataPt.DOM);

              //calc the DOM if not one
              if not hasDOM and hasStatusDate then //use Status Date
                begin
                  dataPt.StatDate := aStatusDate;
                  dataPt.DOM := DaysBetween(dataPt.StatDate, dataPt.ListDate);
                end;
            end;

         //--------- IMPORTANT - override Add and do this calc when the pt is added to list
         //calc the Price/GLA
         if dataPt.GLA > 0 then
           dataPt.PricePerGLA := dataPt.Price/dataPt.GLA;
         //calc the sales to list ratio for ths data pt. (listings will be = 1.00)
         if dataPt.ListPrice > 0 then
           dataPt.Sale2ListRatio := dataPt.Price/dataPt.ListPrice;
        //-----------
        //now either add or free the dataPoint
        if OK2Add then
          ATrendAnalyzer.DataPts.Add(dataPt)
        else
          dataPt.Free;
      end;
    end;
    if zeroSaleDates > 0 then
      begin
        FErrMsg := Format('WARNING: '+#13#10+
                          'There are %d properties with Sales Date or Listing Date set as ZERO values. '+
                          'These properties are excluded from the Trends Analysis. '+#13#10+
                          'You may correct the ZERO dates through MLS Review screen on the Market Data tab.',[zeroSaleDates]);
      end
      //github 334
    else if zeroListDates > 0 then   //this could be a listing date
      begin
        FErrMsg := Format('WARNING: '+#13#10+
                          'There are %d properties with Sales Date or Listing Date set as ZERO values. '+
                          'These properties are excluded from the Trends Analysis. '+#13#10+
                          'You may correct the ZERO dates through MLS Review screen on the Market Data tab.',[zeroListDates]);
      end
      else
        FErrMsg := '';
end;


procedure TSubjectMarket.PerformTrendAnalysis;
begin
  DoTrendAnalysis;
  FTrendingCompleted     := True;                        //trend analysis completed on latest data
end;


procedure TSubjectMarket.DoTrendAnalysis;
const
    image_Idx_4 = 11;
var
  aInterval: Integer;
  aTrendAnalyzer: TTrendAnalyzer;
begin
  try
    LoadDataToAnalyzer(TrendAnalyzer);

    //if no sales or no listings no need to analyze
    if TrendAnalyzer.EmptySalesListingPrice then
      begin
        ShowAlert(atWarnAlert, 'There are not any sale or listing prices available for trend analysis.');
        exit;
      end;
    if edtEffectiveDate.Text = '' then
      edtEffectiveDate.Text := EffectiveDateStr;
    TrendAnalyzer.TrendStartDate     := StrToDateDef(edtEffectiveDate.Text, Date);                 //set start date
    TrendAnalyzer.PeriodType         := tp1004MCPeriods;               //set periods in trend
    TrendAnalyzer.PendingAsSold      := chkPendingIsSettled.checked;   //set the pending usage flag
    TrendAnalyzer.ActiveListingOnly  := True;   //chkActiveListingOnly.checked;  //set the active listing only for DOM calc

    TrendAnalyzer.Analyze;                                //1004MC analysis
    DisplayAnalyzerDataIn1004MCGrid(TrendAnalyzer);       //display in 1004MC grid

    //now switch to 12 month periods
    aTrendAnalyzer := TrendAnalyzer;
    TrendAnalyzer.PeriodType := tp12MonthPeriods;
    TrendAnalyzer.Analyze;                               //12 month period analysis
    TrendAnalyzer.CalcAllTrendLines;                     //calc the trends
    TrendAnalyzer.CalcPeriodTimeAdjustments;             //calc the time adjustments

    DisplayAnalyzerDataInTrendGrid(TrendAnalyzer);       //display the 12 month results
    DisplayAnalyzerDataInTrendRateChange(TrendAnalyzer);
    DisplayAnalyzerDataInTrendStatus(TrendAnalyzer);
    DisplayAnalyzerDataInTrendCharts(TrendAnalyzer);
    TrendAnalyzer := aTrendAnalyzer;
  finally
  end;
end;

procedure TSubjectMarket.SetTrendGridRowTitles;
begin
  FTrendAnalyzer.TrendInterval := tdLast6Months;
end;


procedure TSubjectMarket.DisplayAnalyzerDataInTrendGrid(ATrendAnalyzer: TTrendAnalyzer);
var
  i, numPs, col: Integer;
  APeriod: TTimePeriod;
begin
  //loop through the Time Period list and set the data from those periods into the chart
(*
  numPs := ATrendAnalyzer.Periods.Count -1;

  for i:= 0 to numPs do
    begin
      APeriod := ATrendAnalyzer.Periods[i];
      col := i+2;

      TrendGrid.Cell[col, 1] := Format('%d',[APeriod.Sales.Count]);
      TrendGrid.Cell[col, 2] := Format('%f',[APeriod.AbsorptionRate]);
      TrendGrid.Cell[col, 3] := Format('%d',[APeriod.Listings.Count]);
      TrendGrid.Cell[col, 4] := Format('%f',[APeriod.MonthsSupply]);

      TrendGrid.Cell[col, 5] := Format('%d',[APeriod.Sales.MedianPrice]);
      TrendGrid.Cell[col, 6] := Format('%d',[APeriod.Sales.MedianDOM]);
      TrendGrid.Cell[col, 7] := Format('%d',[APeriod.Listings.MedianPrice]);
      TrendGrid.Cell[col, 8] := Format('%d',[APeriod.Listings.MedianDOM]);
      TrendGrid.Cell[col, 9] := Format('%-8.2f',[APeriod.Sales.MedianSaleToListRatio]);

      TrendGrid.Cell[col, 10] := Format('%-8.2f',[APeriod.Sales.MedianPrPerGLA]);
//leave this OUT for DEMO
//      TrendGrid.Cell[col, 11] := Format('%-8.2f',[APeriod.Sales.AvgTimeAdjPercent]);
    end;
*)
end;

procedure TSubjectMarket.DisplayAnalyzerDataInTrendRateChange(ATrendAnalyzer: TTrendAnalyzer);
var
  TLInterval, col: Integer;
begin
  //get the desired trend line period
(*
  TLInterval := ATrendAnalyzer.TrendInterval;
  if TLInterval = tdNone then
    TLInterval := tdLast12Months;   //default to this

  col := 14;
  TrendGrid.Cell[col, 1]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttTotalSales, TLInterval);
  TrendGrid.Cell[col, 2]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttAbsorptionRate, TLInterval);
  TrendGrid.Cell[col, 3]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttTotalListings, TLInterval);
  TrendGrid.Cell[col, 4]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttMonthsSupply, TLInterval);
  TrendGrid.Cell[col, 5]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttSalePrice, TLInterval);
  TrendGrid.Cell[col, 6]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttSalesDOM, TLInterval);
  TrendGrid.Cell[col, 7]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttListPrice, TLInterval);
  TrendGrid.Cell[col, 8]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttListingDOM, TLInterval);
  TrendGrid.Cell[col, 9]   := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttSaleToListRatio, TLInterval);
  TrendGrid.Cell[col, 10]  := ATrendAnalyzer.Trends.GetTrendRateOfChangeStrByID(ttPricePerSqft, TLInterval);

  col := 15;
  TrendGrid.Cell[col, 1]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttTotalSales, TLInterval);
  TrendGrid.Cell[col, 2]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttAbsorptionRate, TLInterval);
  TrendGrid.Cell[col, 3]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttTotalListings, TLInterval);
  TrendGrid.Cell[col, 4]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttMonthsSupply, TLInterval);
  TrendGrid.Cell[col, 5]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttSalePrice, TLInterval);
  TrendGrid.Cell[col, 6]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttSalesDOM, TLInterval);
  TrendGrid.Cell[col, 7]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttListPrice, TLInterval);
  TrendGrid.Cell[col, 8]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttListingDOM, TLInterval);
  TrendGrid.Cell[col, 9]   := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttSaleToListRatio, TLInterval);
  TrendGrid.Cell[col, 10]  := ATrendAnalyzer.Trends.GetTrendPercentChangeStrByID(ttPricePerSqft, TLInterval);
*)
end;

procedure TSubjectMarket.DisplayAnalyzerDataInTrendStatus(ATrendAnalyzer: TTrendAnalyzer);
var
  TLInterval: Integer;
  percentChg: Real;
  stableLevel: Real;
begin
  //get the desired trend line period
  TLInterval := ATrendAnalyzer.TrendInterval;
  if TLInterval = tdNone then
    TLInterval := tdLast12Months;   //default to this

  stableLevel := StrToFloatTry(edtPercent.text);    //dividing line between stable and increasing/declining

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttTotalSales, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSaleTIncrease, rbSaleTStable, rbSaleTDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttAbsorptionRate, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbAbsorptionIncrease, rbAbsorptionStable, rbAbsorptionDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttTotalListings, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbListTIncrease, rbListTStable, rbListTDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttMonthsSupply, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSupplyIncrease, rbSupplyStable, rbSupplyDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttSalePrice, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSalePIncrease, rbSalePStable, rbSalePDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttSalesDOM, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSaleDomIncrease, rbSaleDomStable, rbSaleDomDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttListPrice, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbListPIncrease, rbListPStable, rbListPDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttListingDOM, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbListDomIncrease, rbListDomStable, rbListDomDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttSaleToListRatio, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSLRatioIncrease, rbSLRatioStable, rbSLRatioDecline);

  percentChg   := ATrendAnalyzer.Trends.GetTrendPercentChangeByID(ttPricePerSqft, TLInterval);
  SetTrendStatus(stableLevel, percentChg, rbSalesPSqFtIncrease, rbSalesPSqFtStable, rbSalesPSqFtDecline);
end;

procedure TSubjectMarket.DisplayAnalyzerDataIn1004MCGrid(ATrendAnalyzer: TTrendAnalyzer);
var
  i, numPs, col: Integer;
  APeriod: TTimePeriod;
begin
  //loop through the Time Period list and set the data from those periods into the chart
  numPs := ATrendAnalyzer.Periods.Count -1;

  for i:= 0 to numPs do
    begin
      APeriod := ATrendAnalyzer.Periods[i];
      col := i+2;

      ts1004MCActivityGrid.Cell[col, 1] := Format('%d',[APeriod.Sales.Count]);
      ts1004MCActivityGrid.Cell[col, 2] := Format('%f',[APeriod.AbsorptionRate]);
      ts1004MCActivityGrid.Cell[col, 3] := Format('%d',[APeriod.Listings.Count]);
      ts1004MCActivityGrid.Cell[col, 4] := Format('%f',[APeriod.MonthsSupply]);

      ts1004MCActivityGrid.Cell[col, 5] := Format('%d',[APeriod.Sales.MedianPrice]);
      ts1004MCActivityGrid.Cell[col, 6] := Format('%d',[APeriod.Sales.MedianDOM]);
      ts1004MCActivityGrid.Cell[col, 7] := Format('%d',[APeriod.Listings.MedianPrice]);
      ts1004MCActivityGrid.Cell[col, 8] := Format('%d',[APeriod.Listings.MedianDOM]);
      ts1004MCActivityGrid.Cell[col, 9] := Format('%-8.2f',[APeriod.Sales.MedianSaleToListRatio]);

      ts1004MCActivityGrid.Cell[col, 10] := Format('%-8.2f',[APeriod.Sales.MedianPrPerGLA]);
    end;
  ts1004MCActivityGrid.Refresh;
end;


procedure TSubjectMarket.DisplayAnalyzerDataInTrendCharts(ATrendAnalyzer: TTrendAnalyzer);
var
  month: String;
  p, numPs: Integer;
  APeriod: TTimePeriod;
  ATrendLine: TTrendLine;
  ATrendInterval: Integer;
  curMedSalePrice, salePInPercent, AdjPercent: Real;
begin
  chartSaleListUnits.Series[0].Clear;   //sales
  chartSaleListUnits.Series[1].Clear;   //listings
  chartSaleListUnits.Series[2].Clear;   //sales trend
  chartSaleListUnits.Series[3].Clear;   //listings trend


  chartSaleListRatio.Series[0].Clear;
  chartSaleListRatio.Series[1].Clear;   //trend

  ChartSalesPricePerSqft.Series[0].Clear;
  ChartSalesPricePerSqft.Series[1].Clear;   //trend

  numPs := ATrendAnalyzer.Periods.Count;
  if numPs = 0 then
   DoTrendAnalysis;
  curMedSalePrice := FTrendAnalyzer.Periods[numPs-1].Sales.MedianPrice;   //for time adj chart
  for p := 0 to numPs-1 do
    begin
      APeriod := ATrendAnalyzer.Periods[p];
      month   := IntToStr(numPs-p);

      //total sales and listings
      chartSaleListUnits.series[0].AddY(APeriod.Sales.Count, month, clRed);
      chartSaleListUnits.series[1].AddY(APeriod.Listings.Count, month, clBlue);


      chartSaleListRatio.series[0].AddY(APeriod.Sales.MedianSaleToListRatio * 100, month, clRed);

      ChartSalesPricePerSqft.Series[0].AddY(APeriod.Sales.MedianPrPerGLA, month, clRed);

      AdjPercent := RoundTo(APeriod.Sales.MedianTimeAdjPercent, 0);
//      ChartTimeAdjFactor.Series[0].AddY(AdjPercent, month, clBlue);
//      if curMedSalePrice <> 0 then begin
//        salePInPercent := ((APeriod.Sales.MedianPrice - curMedSalePrice)/curMedSalePrice)*100;
//        ChartTimeAdjFactor.series[1].AddY(salePInPercent, month, clRed);
//      end;
    end;

 //time adjustment percentage chart - draw the base line on the
//  if FTrendAnalyzer.Periods.Count > 0 then begin
//    ChartTimeAdjFactor.Series[2].AddXY(0, 0);
//    ChartTimeAdjFactor.Series[2].AddXY(FTrendAnalyzer.Periods.Count-1, 0);
//  end;

  //add the trend lines to the charts
  ATrendInterval := ATrendAnalyzer.TrendInterval;
  if ATrendInterval > tdNone then begin  //don't try to display anything if None selected

    //total sales trend
    DrawSaleTotalTrendLine(cbxSaleTotalShowTrend.checked, ATrendInterval);

   //price per sqft trend
    ATrendLine := ATrendAnalyzer.Trends.GetTrendLineByID(ttPricePerSqft, ATrendInterval);
    if assigned(ATrendLine) then with ATrendLine do begin
      ChartSalesPricePerSqft.Series[1].AddXY(X1-1, Y1);
      ChartSalesPricePerSqft.Series[1].AddXY(X2-1, Y2);
    end;
   //sales to list ratio trend
    ATrendLine := ATrendAnalyzer.Trends.GetTrendLineByID(ttSaleToListRatio, ATrendInterval);
    if assigned(ATrendLine) then with ATrendLine do begin
      chartSaleListRatio.Series[1].AddXY(X1-1, Y1*100);
      chartSaleListRatio.Series[1].AddXY(X2-1, Y2*100);
    end;
  end;
end;

procedure TSubjectMarket.SetTrendStatus(stableLevel, percentChg: Real; rbIncrease, rbStable, rbDecline: TRadioButton);
begin
  if percentChg > stableLevel then
    rbIncrease.checked := True
  else if percentChg < (-1 * stableLevel) then
    rbDecline.checked := True
  else
    rbStable.checked := True;
end;

procedure TSubjectMarket.DrawSaleTotalTrendLine(drawIt: Boolean; ATrendInterval: Integer);
var
  ATrendLine: TTrendLine;
begin
  chartSaleListUnits.Series[2].Clear;

  if drawIt then begin
    ATrendLine := FTrendAnalyzer.Trends.GetTrendLineByID(ttTotalSales, ATrendInterval);
    if assigned(ATrendLine) then with ATrendLine do begin
      chartSaleListUnits.Series[2].AddXY(X1-1, Y1);
      chartSaleListUnits.Series[2].AddXY(X2-1, Y2);
    end;
  end;
end;

procedure TSubjectMarket.DrawListTotalTrendLine(drawIt: Boolean; ATrendInterval: Integer);
var
  ATrendLine: TTrendLine;
begin
  chartSaleListUnits.Series[3].Clear;

  if drawIt then begin
    ATrendLine := FTrendAnalyzer.Trends.GetTrendLineByID(ttTotalListings, ATrendInterval);
    if assigned(ATrendLine) then with ATrendLine do begin
      chartSaleListUnits.Series[3].AddXY(X1-1, Y1);
      chartSaleListUnits.Series[3].AddXY(X2-1, Y2);
    end;
  end;
end;

procedure TSubjectMarket.DrawSalePriceTrendLine(drawIt: Boolean; ATrendInterval: Integer);
begin
end;

procedure TSubjectMarket.DrawListPriceTrendLine(drawIt: Boolean; ATrendInterval: Integer);
begin
end;

procedure TSubjectMarket.DrawSaleDOMTrendLine(drawIt: Boolean; ATrendInterval: Integer);
begin
end;

procedure TSubjectMarket.DrawListDOMTrendLine(drawIt: Boolean; ATrendInterval: Integer);
begin
end;


procedure TSubjectMarket.chkPendingIsSettledClick(Sender: TObject);
begin
  if chkPendingIsSettled.Checked then
    FPendingSaleIsSettled := True
  else
    FPendingSaleIsSettled := False;

  PerformTrendAnalysis;
end;

procedure TSubjectMarket.SetTrendLineInterval(const Value: Integer);
begin
  FTrendAnalyzer.TrendInterval := Value;
  DoTrendAnalysis;
  DisplayAnalyzerDataInTrendRateChange(FTrendAnalyzer);
  DisplayAnalyzerDataInTrendStatus(FTrendAnalyzer);
  DisplayAnalyzerDataInTrendCharts(FTrendAnalyzer);
end;


procedure TSubjectMarket.rbtnLast12MosClick(Sender: TObject);
begin
  SetTrendLineInterval(tdLast12Months);
end;

procedure TSubjectMarket.rbtnLast6MosClick(Sender: TObject);
begin
  SetTrendLineInterval(tdLast6Months);
end;

procedure TSubjectMarket.rbtnLast3MosClick(Sender: TObject);
begin
  SetTrendLineInterval(tdLast3Months);
end;

procedure TSubjectMarket.chkActiveListingOnlyClick(Sender: TObject);
begin
  if chkActiveListingOnly.Checked then
    FActiveListingOnly := True
  else
    FActiveListingOnly := False;

  PerformTrendAnalysis;
end;

procedure TSubjectMarket.edtEffectiveDateExit(Sender: TObject);
begin
  performTrendAnalysis;
end;

procedure TSubjectMarket.btnPopulate1004MCClick(Sender: TObject);
begin
  if not assigned(FDoc) then
    FDoc := Main.ActiveContainer;
  PopulateF850_1004MC(FDoc);
//  PopulateF8025_MarketTrends(FDoc);
  write1004MCData(FDoc);
end;

procedure TSubjectMarket.PopulateF850_1004MC(doc: TContainer);
const
  CRLF = #13#10;
  fmMktCondAddend2 = 850;
var
  thisForm: TDocForm;
  col: Integer;
  slRatio: Integer;
  aComment, aComment1, aComment2, aComment3, aComment4, aComment5: String;
  aSalePrice1, aSalePrice2: Double;
  aSupply1, aSupply2: Double;
  aTotalSale1, aTotalSale2, aTotalSale3, aTotalSale: Integer;
  aDOM1, aDOM2: Integer;
begin
  try
    thisForm := doc.GetFormByOccurance(fmMktCondAddend2, 0, True);
    if not assigned(thisForm) then exit;
        //Prior 7-12 Months
        col := 2;
        thisForm.SetCellDataEx(1, 10, ts1004MCActivityGrid.Cell[col, 1]);
        thisForm.SetCellDataEx(1, 16, ts1004MCActivityGrid.Cell[col, 2]);
        thisForm.SetCellDataEx(1, 22, ts1004MCActivityGrid.Cell[col, 3]);
        thisForm.SetCellDataEx(1, 28, ts1004MCActivityGrid.Cell[col, 4]);

        thisForm.SetCellDataEx(1, 34, ts1004MCActivityGrid.Cell[col, 5]);
        thisForm.SetCellDataEx(1, 40, ts1004MCActivityGrid.Cell[col, 6]);
        thisForm.SetCellDataEx(1, 46, ts1004MCActivityGrid.Cell[col, 7]);
        thisForm.SetCellDataEx(1, 52, ts1004MCActivityGrid.Cell[col, 8]);
        slRatio := Round(StrToFloatDef(ts1004MCActivityGrid.Cell[col, 9], 0) * 100);
        thisForm.SetCellData(1, 58, Format('%d',[slRatio]));

        aTotalSale1 := StrToIntDef(ts1004MCActivityGrid.Cell[col, 1], 0);
        aSupply1    := StrToFloatDef(ts1004MCActivityGrid.Cell[col, 4], 0);
        aSalePrice1 := StrToFloatDef(ts1004MCActivityGrid.Cell[col, 5],0);
        aDOM1       := StrToIntDef(ts1004MCActivityGrid.Cell[col, 6], 0);

        //Prior 4-6 Months
        col := 3;
        thisForm.SetCellDataEx(1, 11, ts1004MCActivityGrid.Cell[col, 1]);
        thisForm.SetCellDataEx(1, 17, ts1004MCActivityGrid.Cell[col, 2]);
        thisForm.SetCellDataEx(1, 23, ts1004MCActivityGrid.Cell[col, 3]);
        thisForm.SetCellDataEx(1, 29, ts1004MCActivityGrid.Cell[col, 4]);

        thisForm.SetCellDataEx(1, 35, ts1004MCActivityGrid.Cell[col, 5]);
        thisForm.SetCellDataEx(1, 41, ts1004MCActivityGrid.Cell[col, 6]);
        thisForm.SetCellDataEx(1, 47, ts1004MCActivityGrid.Cell[col, 7]);
        thisForm.SetCellDataEx(1, 53, ts1004MCActivityGrid.Cell[col, 8]);
        slRatio := Round(StrToFloatDef(ts1004MCActivityGrid.Cell[col, 9], 0) * 100);
        thisForm.SetCellData(1, 59, Format('%d',[slRatio]));

        aTotalSale2 := StrToIntDef(ts1004MCActivityGrid.Cell[col, 1], 0);

        //Current - 3 Months
        col := 4;
        thisForm.SetCellDataEx(1, 12, ts1004MCActivityGrid.Cell[col, 1]);
        thisForm.SetCellDataEx(1, 18, ts1004MCActivityGrid.Cell[col, 2]);
        thisForm.SetCellDataEx(1, 24, ts1004MCActivityGrid.Cell[col, 3]);
        thisForm.SetCellDataEx(1, 30, ts1004MCActivityGrid.Cell[col, 4]);

        thisForm.SetCellDataEx(1, 36, ts1004MCActivityGrid.Cell[col, 5]);
        thisForm.SetCellDataEx(1, 42, ts1004MCActivityGrid.Cell[col, 6]);
        thisForm.SetCellDataEx(1, 48, ts1004MCActivityGrid.Cell[col, 7]);
        thisForm.SetCellDataEx(1, 54, ts1004MCActivityGrid.Cell[col, 8]);
        slRatio := Round(StrToFloatDef(ts1004MCActivityGrid.Cell[col, 9],0) * 100);
        thisForm.SetCellData(1, 60, Format('%d',[slRatio]));

        aTotalSale3 := StrToIntDef(ts1004MCActivityGrid.Cell[col, 1], 0);

        aSalePrice2 := StrToFloatDef(ts1004MCActivityGrid.Cell[col, 5],0);
        aSupply2 := StrToFloatDef(ts1004MCActivityGrid.Cell[col, 4], 0);
        aDOM2       := StrToIntDef(ts1004MCActivityGrid.Cell[col, 6], 0);

        aTotalSale := aTotalSale1 + aTotalSale2 + aTotalsale3;
        //Comment
        aComment1 := Format('There were a total of %d Comparable Settled Sales in the past 12 months.',
                           [aTotalSale]);

        aComment2 := Format('The Median Sales Price for the prior 7-12 months was $%s and '+
                     'for the current to prior 3 months is $%s.',
                     [formatfloat('###,###.##',aSalePrice1),formatfloat('###,###.##',aSalePrice2)]);

        aComment3 := Format('The Months Supply for the prior 7-12 months was %f and %f '+
                     'for the current to prior 3 month period.',[aSupply1, aSupply2]);

        aComment4 := Format('The Median Days on Market for the prior 7-12 months was %d '+
                     'and %d for the current to prior 3 month period.',[aDOM1, aDOM2]);

        aComment5 := 'The statistics above were generated from an exported MLS market search. ';

        aComment := aComment1 + CRLF+ aComment2 + CRLF+ aComment3 +CRLF + aComment4 + CRLF + aComment5;
        thisForm.SetCellComment(1, 74, aComment);


        //Overall Trends: Total Comp sales
        if rbSaleTIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 13, 'X');
          end
        else if rbSaleTStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 14, 'X');
          end
        else if rbSaleTDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 15, 'X');
          end;

        //Overall Trends: Absorption Rate
        if rbAbsorptionIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 19, 'X');
          end
        else if rbAbsorptionStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 20, 'X');
          end
        else if rbAbsorptionDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 21, 'X');
          end;

        //Overall Trends: Active Listings
        if rbListTDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 25, 'X');
          end
        else if rbListTStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 26, 'X');
          end
        else if rbListTIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 27, 'X');
          end;

        //Overall Trends: Supply
        if rbSupplyDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 31, 'X');
          end
        else if rbSupplyStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 32, 'X');
          end
        else if rbSupplyIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 33, 'X');
          end;

        //Overall Trends: Sales Price
        if rbSalePIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 37, 'X');
          end
        else if rbSalePStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 38, 'X');
          end
        else if rbSalePDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 39, 'X');
          end;

        //Overall Trends: Sales DOM
        if rbSaleDomDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 43, 'X');
          end
        else if rbSaleDomStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 44, 'X');
          end
        else if rbSaleDomIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 45, 'X');
          end;

        //Overall Trends: List Price
        if rbListPIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 49, 'X');
          end
        else if rbListPStable.Checked then
          begin
            thisForm.SetCellDataEx(1, 50, 'X');
          end
        else if rbListPDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 51, 'X');
          end;

         //Overall Trends: Listing DOM
         if rbListDomDecline.Checked then
          begin
            thisForm.SetCellDataEx(1, 55, 'X');
          end
          else if rbListDomStable.Checked then
            begin
              thisForm.SetCellDataEx(1, 56, 'X');
            end
          else if rbListDomIncrease.Checked then
            begin
              thisForm.SetCellDataEx(1, 57, 'X');
            end;

         //Overall Trends: S/L Ratio
         if rbSLRatioIncrease.Checked then
          begin
            thisForm.SetCellDataEx(1, 61, 'X');
          end
          else if rbSLRatioStable.Checked then
            begin
              thisForm.SetCellDataEx(1, 62, 'X');
            end
          else if rbSLRatioDecline.Checked then
            begin
              thisForm.SetCellDataEx(1, 62, 'X');
            end;
  except on E:Exception do
    ShowNotice('an error occurred while loading 1004 Market Condition.  Please try it again.');
  end;  //move on
end;

procedure TSubjectMarket.SaveTrendChartToFile(const aChartType: Integer; var fileName: String);
begin
  case aChartType of
    cMonthlyTrend:
      chartSaleListUnits.SaveToMetafileEnh(fileName);
    cPriceSqft:
      ChartSalesPricePerSqft.SaveToMetafileEnh(fileName);
    cPriceRatio:
      chartSaleListRatio.SaveToMetafileEnh(fileName);
  end;
end;


//#################################################################################//
//
//    Form 8025: Market Trends
//
//#################################################################################//
procedure TSubjectMarket.populateTrendChart(doc: TContainer; var thisForm: TDocForm; aChartType: Integer; cellNo: Integer);
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


procedure TSubjectMarket.PopulateF8025_MarketTrends(doc: TContainer);
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

procedure TSubjectMarket.write1004MCData(doc: TContainer);
 function GetSumFromSales(aSale, aSale1, aSale2: TSales): Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       result := aSale.Count + aSale1.Count + aSale2.Count;
   end;

 function GetMinPriceFromSales(aSale, aSale1, aSale2: TSales): Integer;
 var
   aMin, aMin1, aMin2: Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       begin
         aMin  := aSale.MinPrice;
         aMin1 := aSale1.MinPrice;
         aMin2 := aSale2.MinPrice;
         if (aMin <= aMin1) and (aMin <= aMin2) then
           result := aMin
         else if (aMin1 <= aMin) and (aMin1 <= aMin2) then
           result := aMin1
         else if (aMin2 <= aMin) and (aMin2 <= aMin1) then
           result := aMin2;
       end;
   end;

 function GetMaxPriceFromSales(aSale, aSale1, aSale2: TSales): Integer;
 var
   aMax, aMax1, aMax2: Integer;
   begin
     result := 0;
     if assigned(aSale) and assigned(aSale1) and assigned(aSale2) then
       begin
         aMax  := aSale.MaxPrice;
         aMax1 := aSale1.MaxPrice;
         aMax2 := aSale2.MaxPrice;
         if (aMax >= aMax1) and (aMax >= aMax2) then
           result := aMax
         else if (aMax1 >= aMax) and (aMax1 >= aMax2) then
           result := aMax1
         else if (aMax2 >= aMax) and (aMax2 >= aMax1) then
           result := aMax2;
       end;
   end;

var
  aSales, aSales1, aSales2: TSales;
  aSum, aMin, aMax, aCOunt: Integer;
  aSalesCount, aMinPrice, aMaxPrice: String;
  aList:TListings;
  FLPriceLo, FLPriceHi: Integer;
begin
  aSales  := TrendAnalyzer.Periods[0].Sales;
  aSales1 := TrendAnalyzer.Periods[1].Sales;
  aSales2 := TrendAnalyzer.Periods[2].Sales;
  aMin    := GetMinPriceFromSales(aSales, aSales1, aSales2);     //get the min out of the 3 periods
  aMax    := GetMaxPriceFromSales(aSales, aSales1, aSales2);     //get the max out of the 3 periods
  aSum    := GetSumFromSales(aSales, aSales1, aSales2);


  aSalesCount := Format('%d',[aSum]);
  aMinPrice   := Format('%d',[aMin]);
  aMaxPrice   := Format('%d',[aMax]);

  FDoc.SetCellTextByID(920, aSalesCount);
  FDoc.SetCellTextByID(921, aMinPrice);
  FDoc.SetCellTextByID(922, aMaxPrice);

  aList := TrendAnalyzer.Periods[2].Listings;
  if assigned(aList) then
    begin
      aCount      := aList.Count;  //use active listing count for the 0-3 months
      FLPriceLo   := aList.MinPrice;
      FLPriceHi   := aList.MaxPrice;
      FDoc.SetCellTextByID(1091, Format('%d',[aCount]));
      FDoc.SetCellTextByID(1092, Format('%d',[FLPriceLo]));
      FDoc.SetCellTextByID(1093, Format('%d',[FLPriceHi]));
    end;
end;






procedure TSubjectMarket.rbtnNoTrendsClick(Sender: TObject);
begin
  SetTrendLineInterval(tdNone);
end;

end.
