unit uMarketFeature;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{ This unit is one of the module for Service >> Analysis }
{ Market Feature to base on the Market dataset to draw the chart for each characteristic}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, TeeProcs, Chart, StdCtrls, ExtCtrls, uContainer,
  osAdvDbGrid, uGlobals,UCompFilter, Grids_ts, TSGrid, UMarketData, USubject,
  uRegression, uSubjectMarket, uCompSelection, uAdjustments;

type
  TMarketFeature = class(TForm)
    Splitter1: TSplitter;
    Panel1: TPanel;
    TopPanel: TPanel;
    SalePanel: TPanel;
    ScrollBox1: TScrollBox;
    chartPanel: TPanel;
    lblSPriceM: TLabel;
    lblSPriceP: TLabel;
    lblsp: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Shape2: TShape;
    Label1: TLabel;
    Label66: TLabel;
    Shape3: TShape;
    lblSPriceMin: TLabel;
    lblSPricePred: TLabel;
    lblSPriceMax: TLabel;
    Label2: TLabel;
    lblSGLAMin: TLabel;
    Label4: TLabel;
    lblSGLAPred: TLabel;
    Label9: TLabel;
    lblSGLAMax: TLabel;
    lblSAgeMin: TLabel;
    lblSAgePred: TLabel;
    lblSAgeMax: TLabel;
    lblSBGLAMin: TLabel;
    lblSBGLAPred: TLabel;
    lblSBGLAMax: TLabel;
    lblSBedMin: TLabel;
    lblSBedPred: TLabel;
    lblSBedMax: TLabel;
    lblSBathMin: TLabel;
    lblSBathPred: TLabel;
    lblSBathMax: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    chartSaleAge: TChart;
    Series1: TBarSeries;
    Series15: TBarSeries;
    chartSalePrice: TChart;
    Series2: TBarSeries;
    chartSaleBeds: TChart;
    Series3: TBarSeries;
    Series16: TBarSeries;
    chartSaleGLA: TChart;
    Series4: TBarSeries;
    Series11: TBarSeries;
    chartSaleBaths: TChart;
    Series5: TBarSeries;
    Series17: TBarSeries;
    chartSaleBsmt: TChart;
    Series9: TBarSeries;
    Series13: TBarSeries;
    Image1: TImage;
    LeftPanel: TPanel;
    CompFilterpanel: TPanel;
    MarketGrid: TosAdvDbGrid;
    Splitter2: TSplitter;
    Label3: TLabel;
  private
    { Private declarations }
    FDoc: TContainer;
    //sales ranges
    FSSiteLo: Integer;
    FSSiteHi: Integer;
    FSSitePred: Integer;
    FSDateLo: String;
    FSDateHi: String;
    FSPriceLo: Integer;
    FSPriceHi: Integer;
    FSPricePred: Integer;
    FSGLALo: Integer;
    FSGLAHi: Integer;
    FSGLAPred: Integer;
    FSAgeLo: Integer;
    FSAgeHi: Integer;
    FSAgePred: Integer;
    FSSaleCount: Integer;
    FSBedsLo: Integer;
    FSBedsHi: Integer;
    FSBedsPred: Integer;
    FSBathsLo: Double;
    FSBathsHi: Double;
    FSBathsPred: Double;
    FSBGLALo: Integer;
    FSBGLAHi: Integer;
    FSBGLAPred: Integer;
    FSBFGLALo: Integer;
    FSBFGLAHi: Integer;
    FSBFGLAPred: Integer;
    FSCarsLo: Integer;
    FSCarsHi: Integer;
    FSCarsPred: Integer;
    FSFireplLo: Integer;
    FSFireplHi: Integer;
    FSFireplPred: Integer;
    

//    FMarketGrid: TosAdvDBGrid;
    procedure InitRanges;
    procedure BuildPriceChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries: TBarSeries; AColor: TColor);
    procedure BuildGLAChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
    procedure BuildAgeChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
    procedure BuildBedroomChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
    procedure BuildBathChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
    procedure BuildBsmtAreaChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
    procedure ShowMinMaxPred;
    procedure BuildMarketCharacteristics;

  public
    { Public declarations }
    FCompFilter: TCompFilter;
    FMarketData: TMarketData;
    FRegression: TRegression;
    FSubject: TSubject;
    FSubjectMarket: TSubjectMarket;
    FCompSelection: TCompSelection;
    FAdjustments: TAdjustments;
    FAnalysis: TComponent;
    FBuildReport: TComponent;
    constructor Create(AOwner: TComponent);       override;
    destructor Destroy;   override;
    procedure InitTool(ADoc: TComponent);
    procedure LoadTooldata;
    function LoadCompFilterModule(doc:TComponent):TCompFilter;
    procedure ReFreshOtherModules;
    procedure SaveFeatureChartToFile(const aChartType: Integer; var fileName: String);


    property SaleCount: Integer read FSSaleCount write FSSaleCount;
    property SDateLo: String read FSDateLo write FSDateLo;
    property SDateHi: String read FSDateHi write FSDateHi;
    property SPriceLo: Integer read FSPriceLo write FSPriceLo;
    property SPriceHi: Integer read FSPriceHi write FSPriceHi;
    property SPricePred: Integer read FSPricePred write FSPricePred;
    property SGLALo: Integer read FSGLALo write FSGLALo;
    property SGLAHi: Integer read FSGLAHi write FSGLAHi;
    property SGLAPred: Integer read FSGLAPred write FSGLAPred;
    property SSiteLo: Integer read FSSiteLo write FSSiteLo;
    property SSiteHi: Integer read FSSiteHi write FSSiteHi;
    property SSitePred: Integer read FSSitePred write FSSitePred;
    property SBGLALo: Integer read FSBGLALo write FSBGLALo;
    property SBGLAHi: Integer read FSBGLAHi write FSBGLAHi;
    property SBFGLALo: Integer read FSBFGLALo write FSBFGLALo;
    property SBFGLAHi: Integer read FSBFGLAHi write FSBFGLAHi;
    property SAgeLo: Integer read FSAgeLo write FSAgeLo;
    property SAgeHi: Integer read FSAgeHi write FSAgeHi;
    property SAgePred: Integer read FSAgePred write FSAgePred;
    property SBedsLo: Integer read FSBedsLo write FSBedsLo;
    property SBedsHi: Integer read FSBedsHi write FSBedsHi;
    property SBedsPred: Integer read FSBedsPred write FSBedsPred;

    property SBathsLo: Double read FSBathsLo write FSBathsLo;
    property SBathsHi: Double read FSBathsHi write FSBathsHi;
    property SCarsLo: Integer read FSCarsLo write FSCarsLo;
    property SCarsHi: Integer read FSCarsHi write FSCarsHi;
    property SFireplLo: Integer read FSFireplLo write FSFireplLo;
    property SFireplHi: Integer read FSFireplHi write FSFireplHi;

//    property MarketGrid: TosAdvDbGrid read FMarketGrid write FMarketGrid;

  end;

var
  MarketFeature: TMarketFeature;

const
//type of comps for _CompTyp - put in central globals
  typSale       = 'Sale';
  typListing    = 'Listing';
  gSale         = 1;
  gList         = 2;


//Identifiers for saving chart as EMF file

 chSalesPrice = 1;
 chListPrice  = 2;
 chSalesAge   = 3;
 chListAge    = 4;
 chSalesGLA   = 5;
 chListGLA    = 6;
 chSalesBeds  = 7;
 chListBeds   = 8;



implementation
uses
  uWindowsInfo, UCC_Utils_Chart,UStatus, UServiceAnalysis_Globals, UCC_MLS_Globals,
  uUtil1, UCC_Globals, UServiceAnalysis, UBuildReport;

{$R *.dfm}


function TMarketFeature.LoadCompFilterModule(doc: TComponent): TCompFilter;
begin
  result := TCompFilter.Create(TContainer(doc));
  try
    result.Parent         := CompFilterPanel;
    result.Align          := alClient;
    result.BorderStyle    := bsNone;
    result.Visible        := True;
    result.FMarketGrid    := MarketGrid;
    result.FSubject       := FSubject;
    result.FAnalysis      := FAnalysis;
    FCompFilter           := result;
    result.InitTool;
    result.LoadToolData;
  except
  end;
end;


procedure TMarketFeature.ReFreshOtherModules;

begin
  if assigned(TAnalysis(FAnalysis)) then
    begin
      TAnalysis(FAnalysis).MarketGrid := MarketGrid;
      TAnalysis(FAnalysis).MarketGrid.Refresh;
    end;
  BuildMarketCharacteristics;

  if not assigned(FBuildReport) then
    FBuildReport := TAnalysis(FAnalysis).LoadReportModule(FDoc);
  if not assigned(FSubjectMarket) then
    FSubjectMarket := TAnalysis(FAnalysis).LoadSubjectMarketModule(FDoc);
  if not assigned(FRegression) then
    FRegression := TAnalysis(FAnalysis).LoadRegressionModule(FDoc);
  if not assigned(FCompSelection) then
   FCompSelection := TAnalysis(FAnalysis).LoadCompSelectionModule(FDoc);
  if not assigned(FAdjustments) then
   FAdjustments := TAnalysis(FAnalysis).LoadAdjustmentModule(FDoc);

   if assigned(FRegression) and (MarketGrid.Rows >= 10) then
    try TRegression(FRegression).LoadToolData;  except ; end;
   if assigned(FSubjectMarket) then
     begin
       try
         TSubjectMarket(FSubjectMarket).LoadToolData;
         TBuildReport(FBuildReport).FSubjectMarket := TSubjectMarket(FSubjectMarket);
       except ; end;
     end;
   if assigned(FCompSelection) then
     TCompSelection(FCompSelection).LoadToolData;
   if assigned(FAdjustments) then
     begin
        TAdjustments(FAdjustments).FImportMLS := True;
        TAdjustments(FAdjustments).FCompSelection := TCompSelection(FCompSelection);
        TAdjustments(FAdjustments).InitialAdjustments(True);
        TAdjustments(FAdjustments).btnApply.Click;
     end;
   if assigned(FBuildReport) then
     begin
       //TBuildReport(FBuildReport).FSubjectMarket := FSubjectMarket;
       TBuildReport(FBuildReport).FAdjustments   := FAdjustments;
       TBuildReport(FBuildReport).FMarketFeature := self;
     end;
end;


constructor TMarketFeature.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TMarketFeature.Destroy;
begin
  inherited;
end;


procedure TMarketFeature.InitTool(ADoc: TComponent);
begin
  PushMouseCursor(crHourGlass);
  try
    FDoc := TContainer(ADoc);
    InitRanges;

    Scrollbox1.Align  := alClient;
    SalePanel.Align   := alLeft;
  finally
    PopMouseCursor;
  end;
end;


procedure TMarketFeature.InitRanges;

begin
  FSDateLo    := '';
  FSDateHi    := '';
  FSPriceLo   := 0;
  FSPriceHi   := 0;
  FSPricePred := 0;
  FSGLALo     := 0;
  FSGLAHi     := 0;
  FSGLAPred   := 0;
  FSAgeLo     := 0;
  FSAgeHi     := 0;
  FSAgePred   := 0;
  FSSaleCount := 0;
  FSBedsLo    := 0;
  FSBedsHi    := 0;
  FSBedsPred  := 0;
  FSBathsLo   := 0;
  FSBathsHi   := 0;
  FSBathsPred := 0;

end;

procedure TMarketFeature.BuildMarketCharacteristics;
begin
  try
    InitRanges;
    BuildPriceChart(MarketGrid, _SalesPrice, _Include, _CompType, typSale, Series2, clRed);
    BuildGLAChart(MarketGrid, _GLA, _Include, _CompType, typSale, Series4, Series11, clRed);
    BuildAgeChart(MarketGrid, _YearBuilt, _Include, _CompType, typSale, Series1, Series15, clRed);
    BuildBedroomChart(MarketGrid, _BedRoomTotal, _Include, _CompType, typSale, Series3, Series16, clRed);
    BuildBathChart(MarketGrid, _BathTotal, _Include, _CompType, typSale, Series5, Series17, clRed);     //special
    BuildBsmtAreaChart(MarketGrid, _BasementGLA, _Include, _CompType, typSale, Series9, Series13, clRed);
//TODO:    if (Appraisal.Comps.SalesInMarketCount > 0) or (Appraisal.Comps.ListingsInMarketCount > 0) then
    ShowMinMaxPred;

//    BuildMarketSaleCounts(PropGridRef);
//    BuildMarketSaleDateRange(PropGridRef);

    //set internal and listener flags, so we can save corectly
//    FDataLoaded := True;
//    FDataModified := MarketListener.DataModified;    //charts have been modified

  except on E:Exception do
    ShowNotice('Error in trying to build Market Characteristics charts.'+e.message);
  end;
end;


procedure TMarketFeature.BuildPriceChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TIntegerRange;
begin
  ChartMaker := TItemPriceChart.Create(0);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.LoadValues(AGrid, ACol, inclCol, typCol, typStr);
      ChartMaker.DoCalcs;
      if ChartMaker.Count > 0 then
        begin
          ChartMaker.SetChartSeries(ASeries, AColor);
          //record the low/highs
          if CompareText(typStr, typSale) = 0 then
            begin
              ChartMaker.GetHighLowPredValues(FSPriceLo, FSPriceHi, FSPricePred, True);
            end;
        end;
    except  on E:Exception do
      ShowAlert(AtWarnAlert, 'The Sales Price histogram could not be created. Please ensure the year built values are correct.'+e.message);
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TMarketFeature.BuildGLAChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TIntegerRange;
begin
  ChartMaker := TItemAreaChart.Create(0);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.SubjectValue := GetValidInteger(FDoc.GetCellTextByID(1004));
      ChartMaker.LoadValues(AGrid, ACol, inclCol, typCol, typStr);
      ChartMaker.DoCalcs;
      //ChartMaker.SetChartSeries(ASeries, AColor);
      //ChartMaker.SetSubjectChartSeries(BSeries, colorSubjectBar);
      if ChartMaker.Count > 0 then
        begin
          ChartMaker.SetChartSeries2(ASeries, AColor, colorSubjectBar);

          //record the low/highs/pred
          if CompareText(typStr, typSale) = 0 then
            begin
              ChartMaker.GetHighLowPredValues(FSGLALo, FSGLAHi, FSGLAPred, False, True); //github #212
            end;
        end;
    except
      ShowAlert(AtWarnAlert, 'The Sales Price histogram could not be created. Please ensure the year built values are correct.');
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TMarketFeature.BuildAgeChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TItemAgeChart;
  n, YrBlt, SubYrBlt: Integer;
  Dy, Mo, EffectiveYear: Word;
  countIt: Boolean;
  aEffectiveDate: String;
begin
  if aGrid.Rows = 0 then exit;
  ChartMaker := TItemAgeChart.Create(AGrid.rows);
  try
    try
      //special for Age - need to use Year Built to calculate Age
      //use effective for reto appraisals. Noramlly Effective Yr should be the year for Today as well
      aEffectiveDate := FDoc.GetCellTextByID(1132);
      if aEffectiveDate = '' then
        aEffectiveDate := DateToStr(Date);
      DecodeDate(StrToDate(aEffectiveDate), EffectiveYear, Mo, Dy);

      SubYrBlt := StrToIntDef(FDoc.GetCellTextByID(151), 0);

      ChartMaker.AllowZero := True;
      ChartMaker.SubjectValue := EffectiveYear - SubYrBlt;
      for n := 1 to AGrid.rows do
        if IsValidYear(AGrid.Cell[ACol,n], YrBlt) and (AGrid.Cell[inclCol,n] = 1) then   //"=1" = include checked
          begin
            countIt := typStr = '';      //ttypeStr = Sales, Listing - used to seperate properties
            if not countIt then          //if there is one...
             // countIt := (CompareText(AGrid.Cell[typCol, n+1], typStr) = 0);  //countIt only if there is a match
              countIt := (CompareText(AGrid.Cell[typCol, n], typStr) = 0);  //github #493: Fix to include the last item
              if countIt then
                ChartMaker.Add(EffectiveYear - YrBlt);
          end;
      if ChartMaker.Count > 0 then
       begin
          ChartMaker.DoCalcs;
          //ChartMaker.SetChartSeries(ASeries, AColor);
          //ChartMaker.SetSubjectChartSeries(BSeries, colorSubjectBar);
          ChartMaker.SetChartSeries2(ASeries, AColor, colorSubjectBar);

          //record the low/highs
          if CompareText(typStr, typSale) = 0 then
            begin
              ChartMaker.GetHighLowPredValues(FSAgeLo, FSAgeHi, FSAgePred);
            end;
       end;
    except
      ShowAlert(AtWarnAlert, 'The Age histogram could not be created. Please ensure the year built values are correct.');
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TMarketFeature.BuildBedroomChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TIntegerRange;
begin
  ChartMaker := TItemCountChart.Create(0);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.SubjectValue := GetValidInteger(FDoc.GetCellTextByID(1042));
      ChartMaker.LoadValues(AGrid, ACol, inclCol, typCol, typStr);
      ChartMaker.DoCalcs;
      //ChartMaker.SetChartSeries(ASeries, AColor);
      //ChartMaker.SetSubjectChartSeries(BSeries, colorSubjectBar);
      if ChartMaker.Count > 0 then
        begin
          ChartMaker.SetChartSeries2(ASeries, AColor, colorSubjectBar);

          //record the low/highs/pred
          if CompareText(typStr, typSale) = 0 then
            begin
              ChartMaker.GetHighLowPredValues(FSBedsLo, FSBedsHi, FSBedsPred);
            end;
        end;
    except
      ShowAlert(AtWarnAlert, 'The Price histogram could not be created. Please ensure the year built values are correct.');
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TMarketFeature.BuildBathChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TDoubleRange;
begin
  ChartMaker := TBathCountChart.Create(0);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.SubjectValue := GetStrValue(FDoc.GetCellTextByID(1043));
      ChartMaker.LoadValues(AGrid, ACol, inclCol, typCol, typStr);
      ChartMaker.DoCalcs;
     // ChartMaker.SetChartSeries(ASeries, AColor);
     // ChartMaker.SetSubjectChartSeries(BSeries, colorSubjectBar);
      if ChartMaker.Count > 0 then
        begin
           ChartMaker.SetChartSeries2(ASeries, AColor, colorSubjectBar);

            //record the low/highs
            if CompareText(typStr, typSale) = 0 then
              ChartMaker.GetHighLowPredValues(FSBathsLo, FSBathsHi, FSBathsPred);
        end;
    except
      ShowAlert(AtWarnAlert, 'The Bath count histogram could not be created. Please ensure the values are correct.');
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TMarketFeature.BuildBsmtAreaChart(AGrid: TosAdvDbgrid; ACol, inclCol, typCol: Integer; typStr: String; ASeries, BSeries: TBarSeries; AColor: TColor);
var
  ChartMaker: TIntegerRange;
begin
  ChartMaker := TItemAreaChart.Create(0);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.SubjectValue := GetValidInteger(FDoc.GetCellTextByID(200));
      ChartMaker.LoadValues(AGrid, ACol, inclCol, typCol, typStr);
      ChartMaker.DoCalcs;
      //ChartMaker.SetChartSeries(ASeries, AColor);
      //ChartMaker.SetSubjectChartSeries(BSeries, colorSubjectBar);
      if ChartMaker.Count > 0 then
        begin
          ChartMaker.SetChartSeries2(ASeries, AColor, colorSubjectBar);

          //record the low/highs
          if CompareText(typStr, typSale) = 0 then
            ChartMaker.GetHighLowPredValues(FSBGLALo, FSBGLAHi, FSBGLAPred, False, True);  //github #212
        end;
    except
      ShowAlert(AtWarnAlert, 'The Basement Area histogram could not be created. Please ensure the values are correct.');
    end;
  finally
    ChartMaker.Free;
  end;
end;


procedure TMarketFeature.ShowMinMaxPred;
begin
  lblSPriceMin.Caption := '$'+trim(FormatValue2(FSPriceLo, bRnd1, True));
  lblSpricePred.Caption:= '$'+trim(FormatValue2(FSPricePred, bRnd1, True));
  lblSPriceMax.Caption := '$'+trim(FormatValue2(FSPriceHi, bRnd1, True));

  lblSGLAMin.Caption := FormatValue2(FSGLALo, bRnd1, True);
  lblSGLAPred.Caption:= FormatValue2(FSGLAPred, bRnd1, True);
  lblSGLAMax.Caption := FormatValue2(FSGLAHi, bRnd1, True);

  lblSAgeMin.Caption := FormatValue2(FSAgeLo, bRnd1, True);
  lblSAgePred.Caption:= FormatValue2(FSAgePred, bRnd1, True);
  lblSAgeMax.Caption := FormatValue2(FSAgeHi, bRnd1, True);

  lblSBedMin.Caption := FormatValue2(FSBedsLo, bRnd1, True);
  lblSBedPred.Caption:= FormatValue2(FSBedsPred, bRnd1, True);
  lblSBedMax.Caption := FormatValue2(FSBedsHi, bRnd1, True);

  lblSBathMin.Caption := Format('%.1f',[FSBathsLo]);
  lblSBathPred.Caption:= Format('%.1f',[FSBathsPred]);
  lblSBathMax.Caption := Format('%.1f',[FSBathsHi]);
end;

procedure TMarketFeature.LoadTooldata;
var
  row, col: Integer;
begin
  if assigned(FMarketData) and (FMarketData.Grid.Rows > 0) then
   begin
      MarketGrid.Rows := FMarketData.Grid.Rows;
      for row:= 1 to FMarketData.Grid.Rows do
        for col := 1 to FMarketData.Grid.Cols do
        begin
          MarketGrid.cell[col, row] := FMarketData.Grid.cell[col, row];
        end;
      MarketGrid.Refresh;
   end;
  LoadCompFilterModule(FDoc);
  BuildMarketCharacteristics;
end;

procedure TMarketFeature.SaveFeatureChartToFile(const aChartType: Integer; var fileName: String);
begin
  case aChartType of
    chSalesPrice:
      chartSalePrice.SaveToMetafileEnh(fileName);
//    chListPrice:
//      chartListPrice.SaveToMetafileEnh(fileName);
    chSalesAge:
      chartSaleAge.SaveToMetafileEnh(fileName);
//    chListAge:
//      chartListAge.SaveToMetafileEnh(fileName);
    chSalesGLA:
      chartSaleGLA.SaveToMetafileEnh(fileName);
//    chListGLA:
//      chartListGLA.SaveToMetafileEnh(fileName);
    chSalesBeds:
      chartSaleBeds.SaveToMetafileEnh(fileName);
//    chLIstSite:
//      chartListSite.SaveToMetafileEnh(fileName);
  end;
end;





end.
