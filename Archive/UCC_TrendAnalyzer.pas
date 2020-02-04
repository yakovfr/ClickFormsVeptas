unit UCC_TrendAnalyzer;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted 1998-2015 by Bradford Technologies, Inc.}

{ this unit is for performing the same analysis as is required for the 1004MC}
{ it creates arrays of sales and listing in various time periods and determines}
{ the min, max, average, median of each and then performs market analysis to }
{ plot trends of the market.}

{ Period and Timeline Structure }
{ The most recent period will be the last one in the list of periods}
{ The End date of a period will be the most recent, The Begin date will be the }
{ start of the period: for instance Begin Date 1/1/15, End Date would be 1/31/15}

{ NOTE: Since a property can be a sale in one period and a listing in a another}
{       period, the dataPts in the sales and listing lists are clones of the }
{       actual dataPts stored in the TrendAnalyzer Object}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Contnrs;


const
  //Listing Status
  lsUnknown   = 0;
  lsSold      = 1;
  lsActive    = 2;
  lsPending   = 3;
  lsExpired   = 4;
  lsWithDrwn  = 5;

//  ckSale    = 1;
//  ckList    = 2;

  //number of periods
  tp12MonthPeriods    = 1;
  tpQuarterPeriods    = 2;
  tp1004MCPeriods     = 3;

  //trend IDs
  ttSalePrice         = 1;
  ttListPrice         = 2;
  ttTotalSales        = 3;
  ttTotalListings     = 4;
  ttPricePerSqft      = 5;   //only for sales
  ttAbsorptionRate    = 6;
  ttMonthsSupply      = 7;
  ttSalesDOM          = 8;
  ttListingDOM        = 9;
  ttSaleToListRatio   = 10;

  //trend period interval
  tdNone              = 0;
  tdLast3Months       = 1;
  tdLast6Months       = 2;
  tdLast12Months      = 3;

type
  ArrayOf12Reals = array[1..12] of Real;

  TDataPt = class(TObject)
  private
    FTestID: Integer;
    FStatus: Integer;        //status of listing (sold, active, pending, withdrawn, etc)
    FStatDate: TDateTime;    //if sold then sold date. otherwise its status date
    FPrice: Integer;         //if sold, then sold price. Otherwise its listing price on status date
    FListDate: TDateTime;    //original listing date (or status date)
    FListPrice: Integer;     //original listing price
    FStoLRatio: Real;        //sales to list ratio - only for sold and pending
    FDOM: Integer;           //sale date - list date  or statusDate - list date
    FBeds: Integer;          //
    FGLA: Integer;           //gross living area
    FPrPerGLA: Real;         //price depends on status (sale or listing)
    FPrPerBed: Real;
  public
    procedure Assign(Source: TDataPt);
    property TestID: Integer read FTestID write FTestID;
    property Status: Integer read FStatus write FStatus;
    property StatDate: TDateTime read FStatDate write FStatDate;
    property Price: Integer read FPrice write FPrice;
    property ListDate: TDateTime read FListDate write FListDate;      //original listing date (status date)
    property ListPrice: Integer read FListPrice write FListPrice;     //original listing price
    property Sale2ListRatio: Real read FStoLRatio write FStoLRatio;   //sales to list ratio
    property DOM: Integer read FDOM write FDOM;
    property GLA: Integer read FGLA write FGLA;
    property Beds: Integer read FBeds write FBeds;
    property PricePerGLA: Real read FPrPerGLA write FPrPerGLA;
    property PricePerBed: Real read FPrPerBed write FPrPerBed;
  end;

  TDataPtList = class(TObjectList)
  private
    FMinGLA: Integer;
    FMaxGLA: Integer;
    FAvgGLA: Integer;
    FMedGLA: Integer;
    FMinPrice: Integer;
    FMaxPrice: Integer;
    FAvgPrice: Integer;
    FMedPrice: Integer;
    FMinDOM: Integer;
    FMaxDOM: Integer;
    FAvgDOM: Integer;
    FMedDOM: Integer;
    FMinPrPerGLA: Real;
    FMaxPrPerGLA: Real;
    FAvgPrPerGLA: Real;
    FMedPrPerGLA: Real;
    FMinS2LRatio: Real;
    FMaxS2LRatio: Real;
    FAvgS2LRatio: Real;
    FMedS2LRatio: Real;
    FMedTimeAdjPcnt: Real;
    FAvgTimeAdjPcnt: Real;
    procedure AnalyzeGLA;
    procedure AnalyzePrice;
    procedure AnalyzeDOM;
    procedure AnalyzePrPerGLA;
    procedure AnalyzeS2LRatio;
    function SumGLA: Integer;
    function SumPrice: Integer;
    function SumDOM: Integer;
    function SumPrPerGLA: Real;
    function SumSale2ListRatio: Real;
    function GetDataPt(Index: Integer): TDataPt;
    procedure SetDataPt(Index: Integer; const Value: TDataPt);
    function CalcMedianDOM: Integer;
    function CalcMedianPrice: Integer;
    function CalcMedianPrPerGLA: Real;
    function CalcMedianGLA: Integer;
    function CalcMedianS2LRatio: Real;
  public
    procedure Analyze;
    procedure QuickSortOnGLA(startLo, startHi: Integer);
    procedure QuickSortOnPrice(startLo, startHi: Integer);
    procedure QuickSortOnDOM(startLo, startHi: Integer);
    procedure QuickSortOnPricePerGLA(startLo, startHi: Integer);
    procedure QuickSortOnS2LRatio(startLo, startHi: Integer);
    property MinGLA: Integer read FMinGLA write FMinGLA;
    property MaxGLA: Integer read FMaxGLA write FMaxGLA;
    property AvgGLA: Integer read FAvgGLA write FAvgGLA;
    property MedianGLA: Integer read FMedGLA write FMedGLA;
    property MinPrice: Integer read FMinPrice write FMinPrice;
    property MaxPrice: Integer read FMaxPrice write FMaxPrice;
    property AvgPrice: Integer read FAvgPrice write FAvgPrice;
    property MedianPrice: Integer read FMedPrice write FMedPrice;
    property MinDOM: Integer read FMinDOM write FMinDOM;
    property MaxDOM: Integer read FMaxDOM write FMaxDOM;
    property AvgDOM: Integer read FAvgDOM write FAvgDOM;
    property MedianDOM: Integer read FMedDOM write FMedDOM;
    property MinPrPerGLA: Real read FMinPrPerGLA write FMinPrPerGLA;
    property MaxPrPerGLA: Real read FMaxPrPerGLA write FMaxPrPerGLA;
    property AvgPrPerGLA: Real read FAvgPrPerGLA write FAvgPrPerGLA;
    property MedianPrPerGLA: Real read FMedPrPerGLA write FMedPrPerGLA;
    property MinSaleToListRatio: Real read FMinS2LRatio write FMinS2LRatio;
    property MaxSaleToListRatio: Real read FMaxS2LRatio write FMaxS2LRatio;
    property AvgSaleToListRatio: Real read FAvgS2LRatio write FAvgS2LRatio;
    property MedianSaleToListRatio: Real read FMedS2LRatio write FMedS2LRatio;
    property MedianTimeAdjPercent: Real read FMedTimeAdjPcnt write FMedTimeAdjPcnt;
    property AvgTimeAdjPercent: Real read FAvgTimeAdjPcnt write FAvgTimeAdjPcnt;
    property DataPt[Index: Integer]: TDataPt read GetDataPt write SetDataPt; default;
  end;

  TSales = Class(TDataPtList);

  TListings = class(TDataPtList);

  TTimePeriod = class(TObject)
  private
    FMoInPeriod: Integer;      //Months in this period
    FBeginDate: TDateTime;
    FEndDate: TDateTime;
    FAbsorbRate: Real;         //absorption Rate (sales/months in period)
    FMosSupply: Real;          //Months supply (active listing/absorption rate)
    FSales: TSales;
    FListings: TListings;
  public
    Constructor Create;
    Destructor Destroy; override;
    procedure Analyze;
    property BeginDate: TDateTime read FBeginDate write FBeginDate;
    property EndDate: TDateTime read FEndDate write FEndDate;
    property Sales: TSales read FSales write FSales;
    property Listings: TListings read FListings write FListings;
    property MonthsInPeriod: Integer read FMoInPeriod write FMoInPeriod;
    property AbsorptionRate: Real read FAbsorbRate write FAbsorbRate;
    property MonthsSupply: Real read FMosSupply write FMosSupply;
  end;

  TTimePeriodList = class(TObjectList)
  private
    function GetTimePeriod(Index: Integer): TTimePeriod;
    procedure SetTimePeriod(Index: Integer; const Value: TTimePeriod);
  public
    procedure Analyze;
    property Period[Index: Integer]: TTimePeriod read GetTimePeriod write SetTimePeriod; default;
  end;

  TTrendLine = class(TObject)
    TrendID: Integer;      //trend type identifier (total sales, sale price, etc)
    PeriodTyp: Integer;    //3 mos, 6 mos, 12 mos
    X1, X2: Integer;       //end points of the trend line (x1,y1) (x2,y2)
    Y1, y2: Real;
    AConst: Real;           //y-intercept of the line
    Velocity: Real;         //slope of the line or rate of change
    X1Act, X2Act: Real;     //actual end point values
    PctChgActual: Real;     //actual percent change between start and end of trend interval
    X1Trend, X2Trend: Real; //caluclated end point values
    PctChgTrend: Real;      //calculated change between start and end of trend interval
  end;

  TTrendLineList = class(TObjectList)
  private
    function GetTrendLine(Index: Integer): TTrendLine;
    procedure SetTrendLine(Index: Integer; const Value: TTrendLine);
  public
    function GetTrendLineByID(ATendID, ATrendPeriod: Integer): TTrendLine;
    function GetTrendVelocityByID(ATendID, ATrendPeriod: Integer): Real;
    function GetTrendPercentChangeByID(ATendID, ATrendPeriod: Integer): Real;
    function GetTrendRateOfChangeStrByID(ATendID, ATrendPeriod: Integer): String;
    function GetTrendPercentChangeStrByID(ATendID, ATrendPeriod: Integer): String;
    property Trend[Index: Integer]: TTrendLine read GetTrendLine write SetTrendLine; default;
  end;

  TTrendAnalyzer = class(TObject)
  private
    FDataPts: TDataPtList;
    FPeriods: TTimePeriodList;
    FTrends: TTrendLineList;
    FPeriodType: Integer;    //12mo, quarterly, 1004MC periods
    FStartDate: TDateTime;
    FTrendInterval: Integer;    //last 3mos, last 6mos, last 12mos
    FHas12PeriodData: Boolean;
    FPendingAsSold: Boolean;
    FActiveListingOnly: Boolean;
    procedure Build1004MCPeriodList;
    procedure Build12MonthPeriodList;
    procedure Build4QuarterPeriodList;
    procedure BuildTimePeriodList;
    procedure LoadSalesAndListingsToPeriods;
    procedure AddSalesToTimePeriods(ADataPt: TDataPt);
    procedure AddListingsToTimePeriods(ADataPt: TDataPt);
    function CalcTrendLine(ATrendID, ATrendPeriod: Integer; const Y: ArrayOf12Reals): TTrendLine;
    procedure CalcTotalSalesTrendLines;
    procedure CalcTotalListingsTrendLines;
    procedure CalcSalePriceTrendLines;
    procedure CalcListingPriceTrendLines;
    procedure CalcListingDOMTrendLines;
    procedure CalcSalesDOMTrendLines;
    procedure CalcSalePricePerSqftTrendLines;
    procedure CalcAbsorptionRateTrendLines;
    procedure CalcMonthsSupplyTrendLines;
    procedure CalcSaleToListRatioTrendLines;
  public
    Constructor Create;
    Destructor Destroy; override;
    procedure Analyze;
    procedure CalcAllTrendLines;
    procedure CalcPeriodTimeAdjustments;
    function EmptySalesListingPrice: Boolean;
    property PendingAsSold: Boolean read FPendingAsSold write FPendingAsSold;
    property ActiveListingOnly: Boolean read FActiveListingOnly write FActiveListingOnly;
    property Has12PeriodData: Boolean read FHas12PeriodData write FHas12PeriodData;
    property TrendStartDate: TDateTime read FStartDate write FStartDate;
    property TrendInterval: Integer read FTrendInterval write FTrendInterval;
    property PeriodType: Integer read FPeriodType write FPeriodType;
    property DataPts: TDataPtList read FDataPts write FDataPts;
    property Periods: TTimePeriodList read FPeriods write FPeriods;
    property Trends: TTrendLineList read FTrends write FTrends;
  end;


implementation

uses
  DateUtils, TPMath, Math;


{ TDataPt }

procedure TDataPt.Assign(Source: TDataPt);
begin
  FTestID     := Source.FTestID;
  FStatus     := Source.FStatus;
  FStatDate   := Source.FStatDate;
  FPrice      := Source.FPrice;
  FListDate   := Source.FListDate;
  FListPrice  := Source.FListPrice;
  FStoLRatio  := Source.FStoLRatio;
  FDOM        := Source.FDOM;
  FBeds       := Source.FBeds;
  FGLA        := Source.FGLA;
  FPrPerGLA   := Source.FPrPerGLA;
  FPrPerBed   := Source.FPrPerBed;
end;

{ TDataPtList }

function TDataPtList.GetDataPt(Index: Integer): TDataPt;
begin
  result := TDataPt(inherited Items[index]);
end;

procedure TDataPtList.SetDataPt(Index: Integer; const Value: TDataPt);
begin
  inherited Insert(Index, Value);
end;

//start = 0 to count-1
procedure TDataPtList.QuickSortOnGLA(startLo, startHi: Integer);
var
  Lo, Hi, pivotGLA: Integer;
begin
  repeat
    Lo := startLo;
    Hi := startHi;
    pivotGLA := DataPt[(Lo + Hi) div 2].GLA;
    repeat
      while DataPt[Lo].GLA < pivotGLA do Inc(Lo);
      while DataPt[Hi].GLA > pivotGLA do Dec(Hi);
      if Lo <= Hi then
        begin
          Exchange(Lo, Hi);
          Inc(Lo);
          Dec(Hi);
        end;
    until Lo > Hi;

    if startLo < Hi then QuickSortOnGLA(startLo, Hi);
    startLo := Lo;
  until Lo >= startHi;
end;

procedure TDataPtList.QuickSortOnPrice(startLo, startHi: Integer);
var
  Lo, Hi, pivotPrice: Integer;
begin
  repeat
    Lo := startLo;
    Hi := startHi;
    pivotPrice := DataPt[(Lo + Hi) div 2].Price;
    repeat
      while DataPt[Lo].Price < pivotPrice do Inc(Lo);
      while DataPt[Hi].Price > pivotPrice do Dec(Hi);
      if Lo <= Hi then
        begin
          Exchange(Lo, Hi);
          Inc(Lo);
          Dec(Hi);
        end;
    until Lo > Hi;

    if startLo < Hi then QuickSortOnPrice(startLo, Hi);
    startLo := Lo;
  until Lo >= startHi;
end;

procedure TDataPtList.QuickSortOnDOM(startLo, startHi: Integer);
var
  Lo, Hi, pivotDOM: Integer;
begin
  repeat
    Lo := startLo;
    Hi := startHi;
    pivotDOM := DataPt[(Lo + Hi) div 2].DOM;
    repeat
      while DataPt[Lo].DOM < pivotDOM do Inc(Lo);
      while DataPt[Hi].DOM > pivotDOM do Dec(Hi);
      if Lo <= Hi then
        begin
          Exchange(Lo, Hi);
          Inc(Lo);
          Dec(Hi);
        end;
    until Lo > Hi;

    if startLo < Hi then QuickSortOnDOM(startLo, Hi);
    startLo := Lo;
  until Lo >= startHi;
end;

procedure TDataPtList.QuickSortOnPricePerGLA(startLo, startHi: Integer);
var
  Lo, Hi: Integer;
  pivotPPGLA: Real;
begin
  repeat
    Lo := startLo;
    Hi := startHi;
    pivotPPGLA := DataPt[(Lo + Hi) div 2].FPrPerGLA;
    repeat
      while DataPt[Lo].FPrPerGLA < pivotPPGLA do Inc(Lo);
      while DataPt[Hi].FPrPerGLA > pivotPPGLA do Dec(Hi);
      if Lo <= Hi then
        begin
          Exchange(Lo, Hi);
          Inc(Lo);
          Dec(Hi);
        end;
    until Lo > Hi;

    if startLo < Hi then QuickSortOnPricePerGLA(startLo, Hi);
    startLo := Lo;
  until Lo >= startHi;
end;

procedure TDataPtList.QuickSortOnS2LRatio(startLo, startHi: Integer);
var
  Lo, Hi: Integer;
  pivotS2LRatio: Real;
begin
  repeat
    Lo := startLo;
    Hi := startHi;
    pivotS2LRatio := DataPt[(Lo + Hi) div 2].FStoLRatio;
    repeat
      while DataPt[Lo].FStoLRatio < pivotS2LRatio do Inc(Lo);
      while DataPt[Hi].FStoLRatio > pivotS2LRatio do Dec(Hi);
      if Lo <= Hi then
        begin
          Exchange(Lo, Hi);
          Inc(Lo);
          Dec(Hi);
        end;
    until Lo > Hi;

    if startLo < Hi then QuickSortOnS2LRatio(startLo, Hi);
    startLo := Lo;
  until Lo >= startHi;
end;

procedure TDataPtList.Analyze;
begin
  if count > 0 then
    begin
      AnalyzeGLA;
      AnalyzePrice;
      AnalyzeDOM;
      AnalyzeS2LRatio;
      AnalyzePrPerGLA;
    end;
end;

function TDataPtList.CalcMedianGLA: Integer;
var
  i: Integer;
  isEven: Boolean;
  num1, num2: Integer;
begin
  isEven := Count Mod 2 = 0;
  if isEven then
    begin
      i:= trunc(Count/2);
      num1 := DataPt[i-1].FGLA;
      num2 := DataPt[i].FGLA;
      FMedGLA := round((num1+num2)/2);
    end
  else
    begin
      i:= Round(Count/2);
      FMedGLA := DataPt[i].FGLA;
    end;
  result := FMedGLA;
end;

procedure TDataPtList.AnalyzeGLA;
var
  ASum: Integer;
//  debugStr: String;
//  j: Integer;
begin
(*  debugStr := '';
  for j := 0 to count -1 do
    debugStr := debugStr + IntToStr(DataPt[j].GLA) + ', ';
  showMessage(debugStr);
*)
  if count > 0 then
    begin
      QuickSortOnGLA(0, count-1);
      FMinGLA := DataPt[0].GLA;
      FMaxGLA := DataPt[count-1].GLA;
      ASum := SumGLA;
      FAvgGLA := Round(ASum/Count);
      FMedGLA := CalcMedianGLA;
    end;
(*
  debugStr := '';
  for j := 0 to count -1 do
    debugStr := debugStr + IntToStr(DataPt[j].GLA) + ', ';

  debugStr := debugStr + 'MED: ' + IntToStr(FMedGLA);
  showMessage(debugStr);
*)
end;

function TDataPtList.CalcMedianPrice: Integer;
var
  i: Integer;
  isEven: Boolean;
  num1, num2: Integer;
begin
  isEven := Count Mod 2 = 0;
  if isEven then
    begin
      i:= trunc(Count/2);
      num1 := DataPt[i-1].FPrice;
      num2 := DataPt[i].FPrice;
      FMedPrice := round((num1+num2)/2);
    end
  else
    begin
      i:= Round(Count/2);
      FMedPrice := DataPt[i].FPrice;
    end;
  result := FMedPrice;
end;

procedure TDataPtList.AnalyzePrice;
var
  ASum: Integer;
begin
  if count > 0 then
    begin
      QuickSortOnPrice(0, Count-1);
      FMinPrice := DataPt[0].Price;
      FMaxPrice := DataPt[count-1].Price;
      ASum := SumPrice;
      FAvgPrice := Round(ASum/Count);
      FMedPrice := CalcMedianPrice;
    end;
end;

function TDataPtList.CalcMedianDOM: Integer;
var
  i: Integer;
  isEven: Boolean;
  num1, num2: Integer;
begin
  isEven := Count Mod 2 = 0;
  if isEven then
    begin
      i:= trunc(Count/2);
      num1 := DataPt[i-1].FDOM;
      num2 := DataPt[i].FDOM;
      FMedDOM := round((num1+num2)/2);
    end
  else
    begin
      i:= Round(Count/2);
      FMedDOM := DataPt[i].FDOM;
    end;
  result := FMedDOM;
end;

procedure TDataPtList.AnalyzeDOM;
var
  ASum: Integer;
//i: Integer;
//  debugStr: String;
begin
  if count > 0 then
    begin
      QuickSortOnDOM(0, count-1);
      FMinDOM := DataPt[0].DOM;
      FMaxDOM := DataPt[count-1].DOM;
      ASum := SumDOM;
      FAvgDOM := Round(ASum/Count);
      FMedDOM := calcMedianDOM;
    end;
(*
  debugStr := '';
  for i := 0 to count -1 do
    debugStr := debugStr + IntToStr(DataPt[i].DOM) + ', ';

  debugStr := debugStr + 'MED: j=' + IntToStr(j) + ', ' + IntToStr(FMedDOM);
  showMessage('DOM:  ' + debugStr);
*)
end;

function TDataPtList.CalcMedianPrPerGLA: Real;
var
  i: Integer;
  isEven: Boolean;
  num1, num2: Real;
begin
  isEven := Count Mod 2 = 0;
  if isEven then
    begin
      i:= trunc(Count/2);
      num1 := DataPt[i-1].PricePerGLA;
      num2 := DataPt[i].PricePerGLA;
      FMedPrPerGLA := (num1+num2)/2;
    end
  else
    begin
      i:= Round(Count/2);
      FMedPrPerGLA := DataPt[i].PricePerGLA;
    end;
  result := FMedPrPerGLA;
end;

procedure TDataPtList.AnalyzePrPerGLA;
var
  ASum: Real;
begin
  if count > 0 then
    begin
      QuickSortOnPricePerGLA(0, count-1);
      FMinPrPerGLA := DataPt[0].PricePerGLA;
      FMaxPrPerGLA := DataPt[count-1].PricePerGLA;
      ASum := SumPrPerGLA;
      FAvgPrPerGLA := ASum/Count;
      FMedPrPerGLA := CalcMedianPrPerGLA;
    end;
end;

function TDataPtList.CalcMedianS2LRatio: Real;
var
  i: Integer;
  isEven: Boolean;
  num1, num2: real;
begin
  isEven := Count Mod 2 = 0;
  if isEven then
    begin
      i:= trunc(Count/2);
      num1 := DataPt[i-1].Sale2ListRatio;
      num2 := DataPt[i].Sale2ListRatio;
      FAvgS2LRatio := round((num1+num2)/2);
    end
  else
    begin
      i:= Round(Count/2);
      FAvgS2LRatio := DataPt[i].Sale2ListRatio;
    end;
  result := FAvgS2LRatio;
end;

procedure TDataPtList.AnalyzeS2LRatio;
var
  ASum: Real;
//  j: Integer;
begin
  if count > 0 then
    begin
      QuickSortOnS2LRatio(0, count-1);
      FMinS2LRatio  := DataPt[0].Sale2ListRatio;
      FMaxS2LRatio  := DataPt[count-1].Sale2ListRatio;
      ASum := SumSale2ListRatio;
      FAvgS2LRatio := ASum/Count;

//      j:= Round(Count/2);
//      FMedS2LRatio := DataPt[j].Sale2ListRatio;
      FMedS2LRatio := CalcMedianS2LRatio;
    end;
end;

function TDataPtList.SumGLA: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + DataPt[i].GLA;
end;

function TDataPtList.SumPrice: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + DataPt[i].Price;
end;

function TDataPtList.SumDOM: Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + DataPt[i].DOM;
end;

function TDataPtList.SumPrPerGLA: Real;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + DataPt[i].PricePerGLA;
end;

function TDataPtList.SumSale2ListRatio: Real;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + DataPt[i].Sale2ListRatio;
end;

{ TTimePeriod }

constructor TTimePeriod.Create;
begin
  inherited;
  
  FSales := TSales.Create(True);
  FListings := TListings.Create(True);
end;

destructor TTimePeriod.Destroy;
begin
  if assigned(FSales) then
    FSales.free;

  if assigned(FListings) then
    FListings.free;

  inherited;
end;

procedure TTimePeriod.Analyze;
begin
  Sales.Analyze;
  Listings.Analyze;

  //do calculations
  FAbsorbRate     := FSales.Count / FMoInPeriod;            //absorption Rate (sales/months in period)
  FMosSupply := 0;
  if FAbsorbRate > 0 then
    FMosSupply      := FListings.Count / FAbsorbRate;         //Months supply (active listing/absorption rate)
end;

{ TTimePeriodList }

function TTimePeriodList.GetTimePeriod(Index: Integer): TTimePeriod;
begin
  result := TTimePeriod(inherited Items[index]);
end;

procedure TTimePeriodList.SetTimePeriod(Index: Integer; const Value: TTimePeriod);
begin
  inherited Insert(Index, Value);
end;

procedure TTimePeriodList.Analyze;
var
  i: Integer;
begin
  for i := 0 to count -1 do
    Period[i].Analyze;
end;

{ TTrendAnalyzer }

constructor TTrendAnalyzer.Create;
begin
  inherited;

  FStartDate          := Now;
  FPendingAsSold      := False;
  FActiveListingOnly  := True;
  FHas12PeriodData    := False;
  FTrendInterval      := tdLast3Months;

  FDataPts := TDataPtList.Create(True);         //it owns the data points
  FPeriods := TTimePeriodList.Create(True);     //it owns the period objects
  FTrends  := TTrendLineList.Create(True);      //it owns the trend line objects
end;

destructor TTrendAnalyzer.Destroy;
begin
  if assigned(FDataPts) then
    FDataPts.free;

  if assigned(FPeriods) then
    FPeriods.free;

  if assigned(FTrends) then
    FTrends.free;

  inherited;
end;
//check
function TTrendAnalyzer.EmptySalesListingPrice: Boolean;
var
  i, dpCount, cnt: Integer;
begin
  result := False;
  cnt := 0;
  if FDataPts.Count = 0 then exit;
  dpCount := FDataPts.Count;
  for i:= 0 to FDataPts.Count - 1 do
    begin
      if FDataPts[i].FPrice = 0 then
        inc(cnt);
    end;
  if cnt = dpCount then
    result := True;
end;

procedure TTrendAnalyzer.BuildTimePeriodList;
begin
  if assigned(FPeriods) then
    FPeriods.Clear;

  case FPeriodType of
    tp12MonthPeriods:   Build12MonthPeriodList;
    tpQuarterPeriods:   Build4QuarterPeriodList;
    tp1004MCPeriods:    Build1004MCPeriodList;
  else
    Build1004MCPeriodList;
  end;
end;

procedure TTrendAnalyzer.Build1004MCPeriodList;
var
  APeriod: TTimePeriod;
  startDate, endDate: TDateTime;
begin
  //current to 3 months
  endDate   := TrendStartDate;
  startDate := incDay(incMonth(endDate,-3),1);

  APeriod := TTimePeriod.Create;
  APeriod.BeginDate := startDate;
  APeriod.EndDate   := endDate;
  APeriod.FMoInPeriod := Round(MonthSpan(endDate, startDate));
  Periods.Add(APeriod);

  //4-6 months
  endDate   := incMonth(TrendStartDate, - 3);
  startDate := incDay(incMonth(endDate,-3),1);

  APeriod := TTimePeriod.Create;
  APeriod.BeginDate := startDate;
  APeriod.EndDate   := endDate;
  APeriod.FMoInPeriod := Round(MonthSpan(endDate, startDate));
  Periods.Insert(0, APeriod);

  //12-7 momths
  endDate   := incMonth(TrendStartDate, - 6);
  startDate := incDay(incMonth(endDate,-6),1);

  APeriod := TTimePeriod.Create;
  APeriod.BeginDate := startDate;
  APeriod.EndDate   := endDate;
  APeriod.FMoInPeriod := Round(MonthSpan(endDate, startDate));
  Periods.Insert(0, APeriod);
end;

procedure TTrendAnalyzer.Build12MonthPeriodList;
var
  i: Integer;
  startDate, endDate: TDateTime;
  APeriod: TTimePeriod;
begin
  for i := 1 to 12 do
    begin
      endDate := incMonth(TrendStartDate, -(i-1)*1);
      startDate   := incDay(incMonth(endDate, -1), 1);

      APeriod := TTimePeriod.Create;
      APeriod.BeginDate := startDate;
      APeriod.EndDate   := endDate;
      APeriod.FMoInPeriod := Round(MonthSpan(endDate, startDate));
      Periods.Insert(0, APeriod);
    end;
end;

procedure TTrendAnalyzer.Build4QuarterPeriodList;
var
  i: Integer;
  startDate, endDate: TDateTime;
  APeriod: TTimePeriod;
begin
  for i := 1 to 4 do
    begin
      endDate := incMonth(TrendStartDate, -(i-1)*3);
      startDate := incDay(incMonth(endDate,-3),1);

      APeriod := TTimePeriod.Create;
      APeriod.BeginDate := startDate;
      APeriod.EndDate   := endDate;
      APeriod.FMoInPeriod := Round(MonthSpan(endDate, startDate));
      Periods.Insert(0, APeriod);
    end;
end;

procedure TTrendAnalyzer.CalcPeriodTimeAdjustments;
var
  curMedSalePrice: Integer;
  curAvgSalePrice: Integer;
  p, numPs: Integer;
begin
  numPs := Periods.Count;
  if numPs > 0 then
    begin
      curMedSalePrice := Periods[numPs-1].Sales.MedianPrice;
      curAvgSalePrice := Periods[numPs-1].Sales.AvgPrice;
      for p := 0 to numPs-1 do
        begin
          if curMedSalePrice > 0 then
            Periods[p].Sales.MedianTimeAdjPercent := ((curMedSalePrice - Periods[p].Sales.MedianPrice)/curMedSalePrice)* 100;
          if curAvgSalePrice > 0 then
            Periods[p].Sales.AvgTimeAdjPercent    := ((curAvgSalePrice - Periods[p].Sales.AvgPrice)/curAvgSalePrice)* 100;
        end;
    end;
end;

function TTrendAnalyzer.CalcTrendLine(ATrendID, ATrendPeriod: Integer; const Y: ArrayOf12Reals): TTrendLine;
const
  Alpha = 0.05;       { Significance level }
var
  XX, YY : PVector;   { Data }
  Ycalc  : PVector;   { Computed Y values }
  B      : PVector;   { Regression parameters }
  V      : PMatrix;   { Variance-covariance matrix }
//Test   : TRegTest;  { Statistical tests }
//Tc     : Float;     { Critical t value }
//Fc     : Float;     { Critical F value }
  I, N, Xn, X1, X2: Integer;
  VStart, VEnd: Real;
begin
  result := TTrendLine.Create;

  case ATrendPeriod of
    tdLast3Months:
      begin
        N   := 3;            //sample size
        X1  := 10;
        X2  := 12;
      end;
    tdLast6Months:
      begin
        N   := 6;
        X1  := 7;
        X2  := 12;
      end;
    tdLast12Months:
      begin
        N   := 12;
        X1  := 1;
        X2  := 12;
      end;
  else begin
      N := 12;
      X1  := 1;
      X2  := 12;
    end;
  end;

  //allocate space for vectors and matrix
  DimVector(XX, N);
  DimVector(YY, N);
  DimVector(Ycalc, N);
  DimVector(B, 1);
  DimMatrix(V, 1, 1);

  try
    Xn := X1;
    for I := 1 to N do
      begin
        XX^[I] := I;             //evenly spaced interval
        YY^[I] := Y[Xn];
        Xn := Xn + 1;
      end;

    LinFit(XX, YY, 1, N, B, V);         //Perform regression by standard method

    for I := 1 to N do
      Ycalc^[I] := B^[0] + B^[1] * XX^[I];   //Compute predicted Y values

    result.TrendID    := ATrendID;
    result.PeriodTyp  := ATrendPeriod;      //3 mos, 6 mos, 12 mos
    result.X1         := X1;
    result.Y1         := Ycalc^[1];
    result.Y2         := Ycalc^[N];
    result.X2         := X2;
    result.AConst     := B^[0];        //the line (y-intercept)
    result.Velocity   := B^[1];        //slope of the line
(*
    { Update variance-covariance matrix and compute statistical tests }
    RegTest(YY, Ycalc, 1, N, V, 0, 1, Test);

    { Compute Student's t and Snedecor's F }
    Tc := InvStudent(N - 2, 1 - 0.5 * Alpha);
    Fc := InvSnedecor(1, N - 2, 1 - Alpha);
*)

    //calc the percent change using actual values
    result.X1Act := Y[X1];     //remember values for commentary
    result.X2Act := Y[X2];

    if Y[X1] <> 0 then
      result.PctChgActual := (Y[X2] - Y[X1])/Y[X1] * 100
    else
      result.PctChgActual := Y[X2];

    //calc the percent change using the trend line values
//    VStart := B^[0] + B^[1] * X1;      //y = a + b*x
//    VEnd   := B^[0] + B^[1] * X2;

    VStart := result.Y1;   //remember values for commentary
    VEnd   := result.Y2;

    if VStart <> 0 then
      result.PctChgTrend := (VEnd - VStart)/VStart * 100
    else
      result.PctChgTrend := VEnd;

  finally
    DelVector(XX, N);
    DelVector(YY, N);
    DelVector(Ycalc, N);
    DelVector(B, 1);
    DelMatrix(V, 1, 1);
  end;
end;

procedure TTrendAnalyzer.CalcTotalSalesTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].Sales.Count;

  Trends.Add(CalcTrendLine(ttTotalSales, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttTotalSales, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttTotalSales, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcTotalListingsTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].Listings.Count;

  Trends.Add(CalcTrendLine(ttTotalListings, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttTotalListings, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttTotalListings, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcSalePriceTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].Sales.MedianPrice;

  Trends.Add(CalcTrendLine(ttSalePrice, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttSalePrice, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttSalePrice, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcAbsorptionRateTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].AbsorptionRate;

  Trends.Add(CalcTrendLine(ttAbsorptionRate, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttAbsorptionRate, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttAbsorptionRate, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcMonthsSupplyTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].MonthsSupply;

  Trends.Add(CalcTrendLine(ttMonthsSupply, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttMonthsSupply, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttMonthsSupply, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcListingPriceTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
   for i := 1 to 12 do
    YValue[i] := Periods[i-1].Listings.MedianPrice;

  Trends.Add(CalcTrendLine(ttListPrice, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttListPrice, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttListPrice, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcSalePricePerSqftTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
  for i := 1 to 12 do
    YValue[i] := Periods[i-1].Sales.MedianPrPerGLA;

  Trends.Add(CalcTrendLine(ttPricePerSqft, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttPricePerSqft, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttPricePerSqft, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcSalesDOMTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
  for i := 12 downto 1 do
    YValue[i] := Periods[i-1].Sales.MedianDOM;

  Trends.Add(CalcTrendLine(ttSalesDOM, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttSalesDOM, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttSalesDOM, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcListingDOMTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
  for i := 12 downto 1 do
    YValue[i] := Periods[i-1].Listings.MedianDOM;

  Trends.Add(CalcTrendLine(ttListingDOM, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttListingDOM, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttListingDOM, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcSaleToListRatioTrendLines;
var
  YValue: ArrayOf12Reals;
  i: Integer;
begin
  for i := 12 downto 1 do
    YValue[i] := Periods[i-1].Sales.MedianSaleToListRatio;

  Trends.Add(CalcTrendLine(ttSaleToListRatio, tdLast3Months, YValue));
  Trends.Add(CalcTrendLine(ttSaleToListRatio, tdLast6Months, YValue));
  Trends.Add(CalcTrendLine(ttSaleToListRatio, tdLast12Months, YValue));
end;

procedure TTrendAnalyzer.CalcAllTrendLines;
begin
  Trends.Clear;             //get rid of the previous results

  if FHas12PeriodData then
    begin
      CalcTotalSalesTrendLines;
      CalcTotalListingsTrendLines;
      CalcSalePriceTrendLines;
      CalcListingPriceTrendLines;
      CalcSalesDOMTrendLines;
      CalcListingDOMTrendLines;
      CalcSalePricePerSqftTrendLines;
      CalcAbsorptionRateTrendLines;
      CalcMonthsSupplyTrendLines;
      CalcSaleToListRatioTrendLines;
    end;
end;

procedure TTrendAnalyzer.Analyze;
begin
  Periods.Clear;     //delete any prevous periods from the list

  BuildTimePeriodList;
  LoadSalesAndListingsToPeriods;

  Periods.Analyze;   //perform analysis on sales and listings

  CalcPeriodTimeAdjustments;  //must be done AFTER periods.analyze

  //this flag to let TrendLines do calculations & display on chart
  FHas12PeriodData := (tp12MonthPeriods = FPeriodType);    //we analyzed 12 periods of data
end;

procedure TTrendAnalyzer.LoadSalesAndListingsToPeriods;
var
  i, numPts: Integer;
  ADataPt: TDataPt;
begin
  numPts := DataPts.count -1;
  for i := 0 to numPts do
    begin
      ADataPt := DataPts[i];

      //assign the sales to the sale list
      if ADataPt.Status = lsSold then
        AddSalesToTimePeriods(ADataPt);

      //assign the listings to the listing list, check for pending as sold
      if PendingAsSold and (ADataPt.Status = lsPending) then
        AddSalesToTimePeriods(ADataPt)
      else
        begin
          //For Active Listings Only: include active and sold
//          if ActiveListingOnly and ((ADataPt.Status = lsActive) or (ADataPt.Status = lsSold)) then
//            AddListingsToTimePeriods(ADataPt)
          //Include all 
//          else if not ActiveListingOnly then
            AddListingsToTimePeriods(ADataPt);
        end;
    end;
end;

procedure TTrendAnalyzer.AddSalesToTimePeriods(ADataPt: TDataPt);
var
  p, numPs: Integer;
  APeriod: TTimePeriod;
  ASale: TDataPt;
begin
  numPs := Periods.Count -1;
  for p := 0 to numPs do
    begin
      APeriod := Periods[p];
      if (APeriod.BeginDate <= ADataPt.StatDate) and (ADataPt.StatDate <= APeriod.EndDate) then
        begin
          ASale := TDataPt.Create;
          ASale.Assign(ADataPt);
          APeriod.Sales.Add(ASale);
          break;
        end;
    end;
end;

procedure TTrendAnalyzer.AddListingsToTimePeriods(ADataPt: TDataPt);
var
  p, numPs: Integer;
  APeriod: TTimePeriod;
  AListing: TDataPt;     //an active listing
begin
  numPs := Periods.Count -1;
  for p := 0 to numPs do
    begin
      APeriod := Periods[p];	//test the data EndDate in each period
      if (ADataPt.ListDate <= APeriod.EndDate) and (ADataPt.StatDate >= APeriod.EndDate) then
        begin  //found an active listing at this period's END boundary
          AListing := TDataPt.Create;
          AListing.Assign(ADataPt);
          AListing.DOM := DaysBetween(APeriod.EndDate, AListing.ListDate);
          APeriod.Listings.Add(AListing);
        end;
    end;
end;

{ TTrendLineList }

function TTrendLineList.GetTrendLine(Index: Integer): TTrendLine;
begin
  result := TTrendLine(inherited Items[index]);
end;

procedure TTrendLineList.SetTrendLine(Index: Integer; const Value: TTrendLine);
begin
  inherited Insert(Index, Value);
end;

function TTrendLineList.GetTrendLineByID(ATendID, ATrendPeriod: Integer): TTrendLine;
var
  t: Integer;
  ATrend: TTrendLine;
begin
  result := nil;
  for t := 0 to Count-1 do
    begin
      ATrend := Trend[t];
      if (ATrend.TrendID = ATendID) and (ATrend.PeriodTyp = ATrendPeriod) then
        begin
          result := ATrend;
          break;
        end;
    end;
end;

function TTrendLineList.GetTrendVelocityByID(ATendID, ATrendPeriod: Integer): Real;
var
  ATrendLine: TTrendLine;
begin
  result := 0;
  ATrendLine := GetTrendLineByID(ATendID, ATrendPeriod);
  if assigned(ATrendLine) then
    result := ATrendLine.Velocity;
end;

function TTrendLineList.GetTrendPercentChangeByID(ATendID, ATrendPeriod: Integer): Real;
var
  ATrendLine: TTrendLine;
begin
  result := 0;
  ATrendLine := GetTrendLineByID(ATendID, ATrendPeriod);
  if assigned(ATrendLine) then
    result := ATrendLine.PctChgTrend;    //could use Actual percent change
end;

function TTrendLineList.GetTrendRateOfChangeStrByID(ATendID, ATrendPeriod: Integer): String;
var
  velocity: Real;
  changeStr: String;
(*
  function SignOfStr(AChange: Real): String;
  begin
    case Sign(AChange) of
      1:  result := '+ ';
      0:  result := '';
      -1: result := '';
    end;
  end;
*)
begin
  changeStr := '';

  velocity := GetTrendVelocityByID(ATendID, ATrendPeriod);
  case ATendID of
    ttSalePrice:
      changeStr := FloatToStr(RoundTo(velocity, 0)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 0)) +
    ttListPrice:
      changeStr := FloatToStr(RoundTo(velocity, 0)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 0)) +
    ttTotalSales:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 1)) +
    ttTotalListings:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 1)) +
    ttPricePerSqft:
      changeStr := FloatToStr(RoundTo(velocity, -2)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 2)) +
    ttAbsorptionRate:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 2)) +
    ttMonthsSupply:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 1)) +
    ttSalesDOM:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 0)) +
    ttListingDOM:
      changeStr := FloatToStr(RoundTo(velocity, -1)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 0)) +
    ttSaleToListRatio:
      changeStr := FloatToStr(RoundTo(velocity, -2)) + '/mo';   //FloatToStr(velocity);  //SignOfStr(RoundTo(velocity, 2)) +
  end;

  result := changeStr;
end;

function TTrendLineList.GetTrendPercentChangeStrByID(ATendID, ATrendPeriod: Integer): String;
var
  Percent: Real;
  percentStr: String;

  function GetSpecialRounding(APercent: Real): Real;
  begin
    if abs(APercent) > 25 then
      result := RoundTo(Percent, 0)
    else
      result := RoundTo(Percent, -1);
  end;

begin
  percentStr := '';

  Percent := GetTrendPercentChangeByID(ATendID, ATrendPeriod);
  case ATendID of
    ttSalePrice:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttListPrice:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttTotalSales:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttTotalListings:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttPricePerSqft:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttAbsorptionRate:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttMonthsSupply:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttSalesDOM:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttListingDOM:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
    ttSaleToListRatio:
      percentStr := FloatToStr(GetSpecialRounding(Percent)) + '%';
  end;

  result := percentStr;
end;

end.





