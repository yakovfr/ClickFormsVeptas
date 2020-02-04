unit uRegression;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                    }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc.}

{ NOTE: the property set used in regression is composed of the sales }
{ that are 'included' in the market property set. Any sale excluded in}
{ market will not be part of the regression set. Any sales in regression}
{ can be excluded from the regression set by setting FRgsIncluded to }
{ false. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, UForms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, TSGrid, Series, BubbleCh,
  TeEngine, TeeProcs, Chart, Contnrs, Grids_ts, osAdvDbGrid,
  UContainer, TPMath, Mask, RzEdit, UStatus, Menus, TrkBar, Graphics,
  osSortLib;

type
  TRegressionChartData = record
    Title: string[50];
    NumPoints: integer;
    BottomAxisMin: real;
    BottomAxisMax: real;
    Increm: real;
    LeftAxisMin: real;
    LeftAxisMax: real;
    Point1X: real;
    Point1Y: real;
    Point2X: real;
    Point2Y: real;
    XPoints: TStringlist;
    YPoints: TStringlist;
    BitMp: TBitmap;
    SubjPredValue : String;
  end;

  TBellChartData = record
    Title: string[50];
    NumPoints: integer;
    BottomAxisMin: real;
    BottomAxisMax: real;
    Increm: real;
    LeftAxisMin: real;
    LeftAxisMax: real;
    XPoints: TStringlist;
    YPoints: TStringlist;
  end;

  TUndoRegress = class(TObject)
     AddressRow : TStringList;
   end;

  TRegression = class(TAdvancedForm)
    PopupMenu1: TPopupMenu;
    ExcludeSaleswithinRectangle1: TMenuItem;
    N1: TMenuItem;
    Cancel1: TMenuItem;
    PopupMenu2: TPopupMenu;
    UndoSelection1: TMenuItem;
    SaveDialog: TSaveDialog;
    LeftPanel: TPanel;
    panelGridHeader: TPanel;
    Splitter1: TSplitter;
    PageControl: TPageControl;
    TabRegression: TTabSheet;
    tabSalesGrid: TTabSheet;
    SalesDataGrid: TosAdvDbGrid;
    btnRegression: TBitBtn;
    Label2: TLabel;
    lblIndicatedVaue: TLabel;
    SalesTopPanel: TPanel;
    btnSelectAll: TButton;
    lblNumProp: TLabel;
    nProp: TLabel;
    Label1: TLabel;
    nSelect: TLabel;
    btnGrid: TBitBtn;
    btnExport: TBitBtn;
    RegressionPanel: TPanel;
    Chart1: TChart;
    sBtnZoomIn: TSpeedButton;
    sBtnZoomOut: TSpeedButton;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    Series3: TPointSeries;
    tsGrid_Adj_Component: TtsGrid;
    tsGridModel: TtsGrid;
    Image1: TImage;
    procedure btnRegressionClick(Sender: TObject);
    procedure tsGrid_Adj_ComponentClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure Chart1ClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure IncludeAllClick(Sender: TObject);
    procedure SalesDataGridClickCell(Sender: TObject; DataColDown,
      DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
      UpPos: TtsClickPosition);
    procedure Chart1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sBtnZoomInClick(Sender: TObject);
    procedure sBtnZoomOutClick(Sender: TObject);
    procedure ExcludeSaleswithinRectangle1Click(Sender: TObject);
    procedure Cancel1Click(Sender: TObject);
    procedure UndoSelection1Click(Sender: TObject);
    procedure SalesDataGridShowEditor(Sender: TObject; DataCol,
      DataRow: Integer; var Cancel: Boolean);
    procedure chartBellCurveGetAxisLabel(Sender: TChartAxis;
      Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
    procedure btnExportClick(Sender: TObject);
    procedure tsGridModelComboDropDown(Sender: TObject;
      Combo: TtsComboGrid; DataCol, DataRow: Integer);
    procedure SalesDataGridSorting(Sender: TObject; DataCol: Integer;
      var Cancel: Boolean);
    procedure SalesDataGridRowChanged(Sender: TObject; OldRow,
      NewRow: Integer);
    procedure btnGridClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure SalesDataGridExit(Sender: TObject);
  private
    FDoc: TContainer;
//    FAppraisal: TAppraisal;
    FIndicatedValue: Double;
    FSampleSize: Integer;
    FStdErr: Double;
    {------------------------------------------------------}
    delimiter : String;      // This variable will not be necessary
    strField  : string;      // when we move the code to CC.
    DataFile  : TStringList; // Just for test to load example Data.
    FieldList : TStringList;
    {-------------------------------------------------------}
    CompData : TosAdvDbGrid;  // This Grid Hold selected property.
    N : integer;              // Number of observations ( selected property's)
    NVar : integer;           // Number of independent variables (Components)
    XX : PMatrix;             // Independent Variable (hold all components values from selected property's)
    YY : PVector;             // Dependent Variable (hold all sales price from selected property's)
    Ycalc : PVector;          // Computed Y Values (hold and cal predict values from selected property's)
    B : PVector;              // Fitted parameters
    V : PMatrix;              // Variance-covariance
    Test : TRegTest;          // Statistical test
    Tc : Float;               // Critical t value
    Fc : Float;               // Critical F value
    Lb : Integer;             // Index first parameters
    SR : Float;               // Residual standard deviation
    SB : Float;               // Standard deviations of parameters
    FRegressionChartData: TRegressionChartData; // Chart data
    ffields : array of integer;
    fcomponents : array of integer;
    fDateCalc : integer;
    thisPct : real;
    fldblankcount : integer;
    totalfields : integer;
    chmousedown: boolean;
    chRect: TRect;
    stx,sty,ex,ey: integer;
    minvx, minvy, maxvx, maxvy: real;
    zoomValue : integer;
    Seq : Integer;
    UndoSeq:   array of TUndoRegress;
    FSetAdjustmentValue : boolean;
    /// Bell chart
    FBellChartData: TBellChartData; // Chart data
    XLabel,YLabel: Real;

    FRegressed: Boolean;              //Set to True after we process regression (may not be needed)
    FDataLoaded: Boolean;             //Set to True when we open an exiistng report
    FDataModified: Boolean;
    FGridSorted: Boolean;
    FMarketGrid: TosAdvDBGrid;
    FEffectiveDate: String;
    FNeedSaleRegresUpdate: Boolean;
    FLastRegressionPath: String;
    {------------------------------------------------------------------------------}
    procedure GetDelimiterfromFile(sfile : String); // will not be necessary in CC
    {-------------------------------------------------------------------}
    procedure BuildAdjComponentGrid;
    procedure BuildConfGrid;
    procedure BuildModelGrid;
    procedure ComparisonFilter;
    procedure GetSelectedComponents;
    procedure LoadCompData;
    procedure CheckComponentsValidation;
    procedure CleanRegression;
    procedure LoadXXYY;
    procedure ProcessRegression;
    procedure CalcComponentsValue;
//    function RatePValueSignificance(PValue: float): String;
    procedure CalcSubjectIndicatedValue;
    procedure GetPredictedValue;
    procedure AnalyseAdjComponents;
    procedure CreateXYChart;
    procedure BuildChart;
    procedure FillAdjustFactors;
    procedure LoadDataSource;
    procedure SaveRegression;
    function getrow(i: string): integer;
    function getrow2(i: string): integer;   //### never used
    function GetUnits(aName:String):String;
    procedure WriteResults(N, NVar: integer; Y, Ycalc : PVector; B: PVector; V: PMatrix; Test: TRegTest; Tc, Fc: Float);
    procedure RunAutoRegressionPath1;
    procedure RunRegression;
    procedure RunRegressionProcess;
    procedure SelectAllProperties;
    procedure RemoveNonAccurateOutlier(PcntAccuracy: Integer);
    procedure RemoveNonSimilarOutlier(PcntSimilar: Integer);
    procedure RemoveOverUnderPricedOutlier(PcntRange: Integer);
    procedure UpdateAdjustmentValues;
    procedure SetIndicatedValue(const Value: Double);
    procedure CleanRectangle;
    procedure WriteDebugComparables;
    procedure AdjustDPISettings;
    procedure DrawBellCurveChart;
    procedure ResetSalesDataGridCheckBox(aMin,aMax:Real);
    procedure DoExportSalesGridData;
    procedure HighlightClickedRows;
    procedure SaveSettingsToIni;
    procedure LoadSettingsFromIni;
    procedure GridSortCompare(Sender: TObject; String1,
                              String2: String; var compareResult: Integer);
    procedure ShowHideGrid(bShowGrid:Boolean);
  public
    FAdjustments: TComponent;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitTool(ADoc: TComponent);
    procedure LoadToolData;
    procedure SaveToolData;
    procedure LeaveToolQuery(var CanLeave: Boolean);
    procedure SwitchToolQuery(nextToolIndex: Integer; var CanSwitch: Boolean);


    function ProcessCompleted: Boolean;
    procedure LoadRegressionDataSource;
    procedure TransferRegressionDataToWorksheet;             //### move to UCC_FormFill_Worksheets
    procedure LoadComponentsOfValueToAdjusterMgr;
    property Doc: TContainer read FDoc write FDoc;
//    property Appraisal: TAppraisal read FAppraisal write FAppraisal;
    property SampleSize: Integer read FSampleSize write FSampleSize;
    property StdErr: Double read FStdErr write FStdErr;
    property IndicatedValue: Double read FIndicatedValue write SetIndicatedValue;
//    property Regressed: Boolean read FRegressed write FRegressed;
    property SetAdjustmentValue: Boolean read FSetAdjustmentValue write FSetAdjustmentValue;
    property DataModified: Boolean read FDataModified write FDataModified;
    property MarketGrid: TosAdvDbGrid read FMarketGrid write FMarketGrid;

  end;

  function GetConfidence(parType: Integer; parValue: float): String;
  function GetCOV(N:Integer; vPrice,vEstPrice: PVector; var cov: Float): boolean;
  function GetCOD(N:Integer; vPrice,vEstPrice: PVector; var cod: Float): boolean;


//  procedure LoadSalesRegression(doc: TContainer);

implementation

uses
  Clipbrd, Math,
  UGlobals, UWindowsInfo, UCC_Utils, UUtil1, UForm, UCC_AdjustmentBase,
  UCC_Globals, UCC_RegressionUtils, UCC_RegressionPropDetails,
  UCC_Utils_Chart, UCC_Progress, IniFiles, uUtil2,UCC_MLS_Globals, uAdjustments;

{$R *.dfm}

const
  Alpha = 0.05;           // Significance level
  ConsTerm = True;
  ConfLevels: Array[0..4] of String   = ('Undefined', 'Poor', 'Acceptable', 'Good', 'Very Good');
  SampleLevels: Array[0..5] of String = ('Very Good', 'Good' , 'Average', 'Low', 'Very Low','');

  {regression parameters}
  regParamR2        = 1;
  regParamR2Adj     = 2;
  regParamCOV       = 3;
  regParamCOD       = 4;
  regParamStdError  = 5;

  {components id}
   cBaseNeighborhoodValue = 1;
   cGLA                   = 2;
 //  cTotalBath             = 3;
   cSiteArea              = 3;
 //  cGarage                = 5;
 //  cCarport               = 6;
   cBsmtArea              = 4;
   cBsmtFinArea           = 5;
   cYearBuilt             = 6;
 //  cFireplace             = 10;
 //  cPool                  = 11;
 //  cSpa                   = 12;
   cSalesDate             = 7;

  {Fields Id on Grid - components}      // This will be flexible in future version.
   fID            = 1;                  // index to Tappraisal.comp.sales
   fInRegess      = 2;                  // Include for Regression Calculation
   fPredAcc       = 3;
   fPredValue     = 4;
// fRank          = 5;
   fAddress       = 5;
   fSalesPrice    = 6;
   fSalesDate     = 7;
   fYearBuilt     = 8;
   fGLA           = 9;
   fSiteArea      = 10;
   fTotalBath     = 11;
   fGarage        = 12;
   fCarport       = 13;
   fFireplace     = 14;
   fPool          = 15;
   fSpa           = 16;
   fBedroom       = 17;
   fBsmtArea      = 18;
   fBsmtFinArea   = 19;
   fMLS_ID        = 20;
   fUnit          = 21;
   fCity          = 22;
   fState         = 23;
   fZipCode       = 24;
   fDistance      = 25;
   fDiff          = 26;  ///### Hold Positive and Negative values. innvisible column.
   fDiffPos       = 27;  ///### Hold Positive values only to be sort.
   fPredAccuOrig  = 28;  ///### Hold the original Predicted Accuracy value for trackbar to use
   fIndex         = 29;  //index between the grid and Tappraisal.comps.sales
  {-----------------}
    //Column name of tsGridModel

    cSampleSize    = 1;
    cRSquared      = 2;
    cAdjSquared    = 3;
    cCOV           = 4;
    cCOD           = 5;
    cStandardError = 6;

   //Column name of tsGridConf
   cDataQuality   = 1;
   cSubjToData    = 2;
   cModelOutput   = 3;
   cModelAccuracy = 4;
   cIncluded      = 5;

   Comma = ',';

   //For Bell Chart settings
   //Bell chart X-Axis setting
//   XINTERVAL = 0.25;
   XINTERVAL = 0.2;
   XMAX      = 1.0;
   XMIN      = -1.0;
   XSTART    = 0;
   XMID      = 1;

   //Bell chart Y-Axis setting
   YINTERVAL = 0.1;
   YMAX      = 1.1;
   YMIN      = 0;
   YSTART    = 0;

   TRB_INTERVAL = 0.1; //trackbar interval;

   XAXIS_MAX = 40;

function GetConfidence(parType: Integer; parValue: float): String;
begin
  result := ConfLevels[0];
  if parValue = 0 then exit;
    case parType of
      regParamR2,regParamR2Adj:
        begin
          if (parValue >= 0.88) and (parValue <= 1.0) then      //0.88 to 1.0 is Very Good
            result := confLevels[4]
          else if (parValue >= 0.78) and (parValue < 0.88) then  //0.78 to 0.88 is Good
            result := confLevels[3]
          else if (parValue >= 0.675) and (parValue < 0.78) then  //0.675 to 0.78 is Acceptable
            result := confLevels[2]
          else if (parValue > 0) and (parValue < 0.675) then      //0.675 to 0.0 is Poor
            result := confLevels[1]
          else
            result := confLevels[0]                              //its undefined
        end;
     regParamCov,regParamCod,regParamStdError:
      begin
        if (parValue >= 0) and (parValue <= 0.075) then         //0 to 0.075 is Very Good
          result := confLevels[4]
        else if (parValue > 0.075) and (parValue <= 0.1) then   //0.075 to 0.1 is Good
          result := confLevels[3]
        else if (parValue > 0.1) and (parValue <= 0.15) then    //0.1 to 0.15 is Acceptable
          result := confLevels[2]
        else if (parValue > 0.15) then
          result := confLevels[1]                              //0.16 and above is Poor
        else if (parValue < 0.0) then
          result := confLevels[0]                              //less than 0 = undefined
      end;
   end;
 end;

function GetCOV(N:Integer; vPrice,vEstPrice: PVector; var cov: Float): boolean;
var
  ind: Integer;
  vPrRatio: PVector;
  avrRatio: Float;
  theStdDev: Float;
begin
  result := false;
  dimVector(vPrRatio,N);
  try
    try
      for ind := 1 to N do
        if vEstPrice^[ind] = 0 then
          exit
        else
          vPrRatio^[ind] := vPrice^[ind]/vEstPrice^[ind];
      avrRatio := tpmath.mean(vPrRatio,1,N);
      if avrRatio = 0 then
        exit;
      theStdDev := stDev(vPrRatio,1,N,avrRatio);
      cov := 100 * theStdDev/avrRatio;
      result := true;
    except
      result := false;
    end;
  finally
    DelVector(vPrRatio,N);
  end;
end;

function GetCOD(N:Integer; vPrice,vEstPrice: PVector; var cod: Float): boolean;
var
  ind: Integer;
  vect: PVector;
  medn: Float;
begin
  result := false;
  dimVector(vect,N);
  try
    try
      for ind := 1 to N do
        if vEstPrice^[ind] = 0 then
          exit
        else
          vect^[ind] := vPrice^[ind]/vEstPrice^[ind];
      medn := median(vect ,1,N,false);
      if medn = 0 then
        exit;
      for ind  := 1 to N do
        vect^[ind] := abs(vect^[ind] -  medn);
      cod := 100 *  tpmath.mean(vect,1,N)/medn;
      result := true;
    except
      result := False;
    end;
  finally
    delVector(vect,N);
  end;
end;



{ TFRegression }

constructor TRegression.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CompData := TosAdvDbGrid.Create(nil);
end;

destructor TRegression.Destroy;
begin
  if assigned(CompData) then
    FreeAndNil(CompData);
  inherited;
end;


procedure TRegression.InitTool(ADoc: TComponent);
begin
  //hack when using TabSheet to eliminate the white Not sure if we need anymore
//  tsGridModel.Color   := RGBToColor(251, 254, 241);

  PanelGridHeader.parentBackground := False;
  PanelGridHeader.Brush.Color := clBtnFace;

  RegressionPanel.parentBackground := False;
  RegressionPanel.Brush.Color := clBtnFace;

  SalesTopPanel.parentBackground := False;
  SalesTopPanel.Brush.Color := clBtnFace;

  FDoc := TContainer(ADoc);

  FEffectiveDate := FDoc.GetCellTextByID(1132);
  if FEffectiveDate = '' then
    FEffectiveDate := DateToStr(Date);

  chmousedown := False;
  zoomValue := Chart1.AnimatedZoomSteps;

  SalesDataGrid.Col[fPredAccuOrig].Visible := False;        //holds difference between act & predicted price
  SalesDataGrid.Col[fIndex].Visible := False;        //holds abs diff between act and predicted price

  {Create a Object Grid to hold the selected properties}
  {BTW - CompData is a John Bigger Hack - lets eventually get rid of it}
//  CompData := TosAdvDbGrid.Create(nil);
  CompData.StoreData := True;
  CompData.Parent := self;
  CompData.Visible := False;
  CompData.SendToBack;

  BuildAdjComponentGrid;
  BuildConfGrid;
  BuildModelGrid;
  CreateXYChart;
  //create a listener and broadcasters for data changes

  FDataModified := False;
  FRegressed    := False;
  FGridSorted   := False;
end;

procedure TRegression.ShowHideGrid(bShowGrid:Boolean);
begin
  if bShowGrid then
    begin
      btnGrid.Caption         := 'Hide Grid';
      tabSalesGrid.TabVisible := True;
      PageControl.ActivePage  := tabSalesGrid;
      btnRegression.Enabled   := False;
    end
  else
    begin
      btnGrid.Caption         := 'Show Grid';
      tabSalesGrid.TabVisible := False;
      PageControl.ActivePage  := tabRegression;
      btnRegression.Enabled   := True;
      btnRegression.Click;
    end;
end;

procedure TRegression.RunRegressionProcess;
begin
  //do the initial regression attempts after the window shows
//  if IsNonZeroNumber(lblIndicatedVaue.Caption) AND (not FNeedSaleRegresUpdate) then  //regression has been run
//    begin
//      If not ControlKeyDown then    //backdoor to keep regression from running, needed when (< 10 properties selected)
//        begin
//          if (CompareText(FLastRegressionPath, 'Path1') = 0) or FDataLoaded then
//            RunAutoRegressionPath1
//          else
//            RunRegression;            //reset to previous state
//          DrawBellCurveChart;
//          FSetAdjustmentValue := False;      //don't change the adjustment values - may have been previously changed
//        end;
//    end
//  else  //this is first time
    begin
      RunAutoRegressionPath1;    //hone in on good stats
      FSetAdjustmentValue := True;
      FRegressed := FIndicatedValue > 0;
    end;

  FDataModified := True;
end;

procedure TRegression.BuildChart;
var
  f: integer;
  x,y : string;
begin
  chart1.Series[0].Clear;
  chart1.Series[1].Clear;
  chart1.Series[2].Clear;

  {Draw Line}
  chart1.Series[0].AddXY(FRegressionChartData.Point1X, FRegressionChartData.Point1Y);
  chart1.Series[0].AddXY(FRegressionChartData.Point2X, FRegressionChartData.Point2Y);

  {Draw the scratter plot}
  if assigned(FRegressionChartData.XPoints) then
   if length(FRegressionChartData.XPoints.Text) > 0 then
    begin
      for f := 0 to FRegressionChartData.NumPoints - 1 do
        begin
          x := FRegressionChartData.XPoints[f];
          y := FRegressionChartData.YPoints[f];
          {Draw dots properties}
          chart1.Series[1].AddXY(strtofloattry(FRegressionChartData.XPoints[f]), strtofloattry(FRegressionChartData.YPoints[f]));
        end;
    end;

  {Draw subject triangle}
//  chart1.Series[2].AddXY(strtofloattry(IndicatorVaue.Caption),strtofloattry(IndicatorVaue.Caption));
  chart1.Series[2].AddXY(IndicatedValue, IndicatedValue);
  chart1.Series[2].Title := 'subject'
end;

procedure TRegression.WriteResults(N, NVar: integer; Y, Ycalc : PVector; B: PVector; V: PMatrix; Test: TRegTest; Tc, Fc: Float);
var
   i : integer;
   Sr : Float;    { Residual standard deviation ###- this var is also in main obj}
   SB : Float;    { Standard deviations of parameters ###- this var is also in main obj}
   Lb : Integer;  { Index of first parameter }
   mysqr : extended;
   xr2,xr2a : real;
   AMin, AMax, AMinY, AMaxY: extended;
   PAcc, PValue, SValue, xCOV, xCOD: float;
   Ratio,diff,diffPos : float;
   NbrHdPriceMed : String;  //### STD_DEV
   SalesPrMean: Real;
begin
 {------------------------------Model Grid Results-----------------------------------------------------------}
  with Test do
    begin
      SR := Sqrt(Vr);       //Std Deviation
      mysqr := SR/n;

      SalesPrMean := tpmath.mean(YY,1,N);
      StdErr := (SR / SalesPrMean) * 100;
      tsGridModel.Cell[2,cStandardError] := formatfloat('###,###,##0.00', StdErr) + '%';
(*
      NbrHdPriceMed :=  FloatToStr(tpmath.mean(YY,1,N));
      tsGridModel.Cell[2,5] := formatfloat('###,###,##0.00',(Sr/strtofloattry(NbrHdPriceMed))*100) + '%';
      StdErr := (Sr/strtofloattry(NbrHdPriceMed))*100;
*)
      mysqr := StdErr/mysqr;
      tsGridModel.Cell[2,cRSquared] := formatfloat('###,###,##0.00',R2*100) + '%';
      xr2 := r2*100;
      tsGridModel.Cell[2,cAdjSquared] := formatfloat('###,###,##0.00',R2a*100) + '%';
      xr2a := R2a*100;
    end;

    if not GetCov(N,Y,YCalc, xCov) then
      tsGridModel.Cell[2,cCOV] := 'error'
    else
      tsGridModel.Cell[2,cCOV] := formatfloat('###,###,###.00',xCOV) + '%';

    if not GetCod(N,Y,YCalc, xCOD) then
      tsGridModel.Cell[2,cCOD] := 'error'
    else
      tsGridModel.Cell[2,cCOD] := formatfloat('###,###,###.00',xCOD) + '%';

  with tsGridModel do
    begin
      if CompareText(Cell[2,cRSquared],'error') = 0 then
        tsGridModel.Cell[3,cRSquared] :=  ConfLevels[0]
      else
        tsGridModel.Cell[3,cRSquared] := getConfidence(regParamR2,strtofloattry(tsGridModel.Cell[2,cRSquared])/100);

      if CompareText(Cell[2,cAdjSquared],'error') = 0 then
        tsGridModel.Cell[3,cAdjSquared] :=  ConfLevels[0]
      else
        tsGridModel.Cell[3,cAdjSquared] := getConfidence(regParamR2Adj,strtofloattry(tsGridModel.Cell[2,cAdjSquared])/100);

      if CompareText(Cell[2,cCOV],'error') = 0 then
        tsGridModel.Cell[3,cCOV] :=  ConfLevels[0]
      else
        tsGridModel.Cell[3,cCOV] := getConfidence(regParamCov,strtofloattry(tsGridModel.Cell[2,cCOV])/100);

      if CompareText(Cell[2,cCOD],'error') = 0 then
        tsGridModel.Cell[3,cCOD] :=  ConfLevels[0]
      else
        tsGridModel.Cell[3,cCOD] := getConfidence(regParamCod,strtofloattry(tsGridModel.Cell[2,cCOD])/100);

      if CompareText(Cell[2,cStandardError],'error') = 0 then
        tsGridModel.Cell[3,cStandardError] :=  ConfLevels[0]
      else
        tsGridModel.Cell[3,cStandardError] := GetConfidence(regParamStdError, StdErr/100);
    end;
  {---------------------------------------- end model grid ---------------------------------------------------}

  {------------------------------------- Start setting Chart -------------------------------------------------}
  if ConsTerm then Lb := 0 else Lb := 1;
   AMin := 999999999;
   AMax := -999999999;
   AMinY := 999999999;
   AMaxY := -999999999;

  Pacc := 0.0;
  for I := 1 to N do
    begin
        if Y^[I] < AMin then AMin := Y^[I];
        if Y^[I]> AMax then AMax := Y^[I];
        if Ycalc^[I]< AMin then AMin := Ycalc^[I];
        if Ycalc^[I]> AMax then AMax := Ycalc^[I];
        if Ycalc^[I]< AMinY then AMinY := Ycalc^[I];
        if Ycalc^[I]> AMaxY then AMaxY := Ycalc^[I];

        try
        if i=1 then
          Pacc := Y^[i]/Ycalc^[I]
        else
          Pacc := pacc + ((Y^[i]/Ycalc^[I])*(Y^[i]/Ycalc^[I]));
        except
          pacc := 1;
        end;
    end;
  if assigned(FRegressionChartData.XPoints) then
    FRegressionChartData.XPoints.Clear;
  if assigned(FRegressionChartData.YPoints) then
    FRegressionChartData.YPoints.Clear;

  AMin := round(AMin);
  AMax := round(AMax);

  if AMin>0 then
    begin
      chart1.BottomAxis.SetMinMax(AMin*0.9, AMax*1.1);
      chart1.LeftAxis.SetMinMax(AMin*0.9, AMax*1.1);
    end
  else
    begin
      chart1.BottomAxis.SetMinMax(AMin*1.1, AMax*1.1);
      chart1.LeftAxis.SetMinMax(AMin*1.1, AMax*1.1);
    end;

  chart1.BottomAxis.Increment := Round(AMax/10);

  FRegressionChartData.Increm         := chart1.BottomAxis.Increment;
  FRegressionChartData.BottomAxisMin  := chart1.BottomAxis.Minimum;
  FRegressionChartData.BottomAxisMax  := chart1.BottomAxis.Maximum;
  FRegressionChartData.LeftAxisMin    := chart1.LeftAxis.Minimum;
  FRegressionChartData.LeftAxisMax    := chart1.LeftAxis.Maximum;
  FRegressionChartData.Point1X := AMinY;
  FRegressionChartData.Point1Y := AMinY;
  FRegressionChartData.Point2X := AMaxY;
  FRegressionChartData.Point2Y := AMaxY;
  FRegressionChartData.NumPoints := N;

  {calculate the Predicted Accuracy for each comp}
  if N=0 then N := 1;
  for I := 1 to N do
    begin
      if assigned(FRegressionChartData.XPoints) then
        FRegressionChartData.XPoints.Add(floattostrtry2(Y^[I]));
      if assigned(FRegressionChartData.YPoints) then
        FRegressionChartData.YPoints.Add(floattostrtry2(round(Ycalc^[I])) + '.' + CompData.cell[fID,I]+'999');
      //FRegressionChartData.YPoints.Add(floattostrtry2(round(Ycalc^[I])) + '.' + stripnumbers2(CompData.cell[fMLS_ID,i]) + '1');

      PValue := Round(Ycalc^[I]);                               //predicted price
      SValue := strtofloattry(CompData.cell[fSalesPrice,i]);    //sales price
      if SValue <> 0 then
        begin
          PAcc := Round((PValue/SValue)*10000)/100;
          diff := ((PValue - SValue)/SValue)*100;               //get precent
          diff := Round(diff/0.01)*0.01;                        //round to 2 dec places
          diffPos := (abs(PValue - SValue)/SValue)*100;         //get positive percent
          diffPos := Round(diffPos/0.01)*0.01;                  //round to 2 dec places
        end
      else
        begin
          PAcc := 0;
          diff := 100;
          diffPos := 100;
        end;

      CompData.cell[fPredValue, i]  := PValue;
      CompData.cell[fPredAcc, i]    := PAcc;
      CompData.Cell[fDiff, i]       := diff;
      CompData.Cell[fDiffPos, i]    := diffPos;
(*
      CompData.cell[fPredValue, i] := Round(Ycalc^[I]);  //formatfloat('###,###,###', Ycalc^[I]);
      try
        pacc := strtofloattry(CompData.cell[fPredValue,i])/strtofloattry(CompData.cell[fSalesPrice,i]);
      except
        pacc := 1;
      end;
      CompData.cell[fPredAcc, i] := pacc*100;   //formatfloat('#,###.00', pacc*100); //+ '%';

      // Calculate the Difference   ####  Adding Zero at front Make the Grid Sort correct !!!!
      diff := (strtofloattry(CompData.cell[fPredValue,i]) - strtofloattry(CompData.cell[fSalesPrice,i])) / strtofloattry(CompData.cell[fSalesPrice,i]);
      CompData.Cell[fDiff, i] := diff;    // formatfloat('0#.## ',(diff * 100));

      diffPos := abs(strtofloattry(CompData.cell[fPredValue,i]) - strtofloattry(CompData.cell[fSalesPrice,i])) / strtofloattry(CompData.cell[fSalesPrice,i]);
      CompData.Cell[fDiffPos, i] := diffPos;  // formatfloat('0#.## ',(diffPos * 100));
*)
    end;
end;

procedure TRegression.GetDelimiterfromFile(sfile : String);
begin
  if (FileExists(sfile)) then
    begin
     {Read delimiter from file}
     delimiter := CheckDelim(sfile);
    end;
end;

//this is the one in installer
//code this like in Comp Selection
procedure TRegression.LoadDataSource;
var
  x,i : integer;
  sales : real;
begin
  SalesDataGrid.rows := 0;
  i :=0;
  for x := 1 to FMarketGrid.Rows do
    begin
      if (FMarketGrid.Cell[_Include, x] = 1)  and (FMarketGrid.Cell[_CompType, x] = 'Sale') then
        begin
        sales :=  strtofloattry(FMarketGrid.Cell[_SalesPrice,x]);
        if sales <= 0 then
          FMarketGrid.Cell[_Include, x] := 0    //make sure its flagged as not included
        else  // if have sales price include in Regression.
          begin
          inc(i);
          SalesDataGrid.Rows              := i;
          SalesDataGrid.Cell[fID,i]       := i;   //row count, used to assoc chart points and grid
          SalesDataGrid.Cell[fIndex,i]    := x;   //index so we can save correctly back to Appraisal.Comps
          SalesDataGrid.Cell[fInRegess,i] := 1;   //included
//            SalesDataGrid.Cell[fPredAcc,i]     := GetFirstValue(Appraisal.Comps.Sale[x].PredictedAccuracy);
//            SalesDataGrid.Cell[fPredValue,i]   := GetFirstIntValue(Appraisal.Comps.Sale[x].PredictedValue);
          SalesDataGrid.Cell[fAddress,i]     := FMarketGrid.cell[_StreetAdress, x];
          SalesDataGrid.Cell[fSalesPrice,i]  := FMarketGrid.cell[_SalesPrice, x];
          SalesDataGrid.Cell[fSalesDate,i]   := FMarketGrid.cell[_SalesDate, x];
          SalesDataGrid.Cell[fYearBuilt,i]   := FMarketGrid.cell[_YearBuilt, x];
          SalesDataGrid.Cell[fGLA,i]         := FMarketGrid.cell[_GLA, x];

          SalesDataGrid.Cell[fSiteArea,i]    := FMarketGrid.cell[_SiteArea,x];
          SalesDataGrid.Cell[fBedroom,i]     := FMarketGrid.cell[_BedRoomTotal,x];
          SalesDataGrid.Cell[fTotalBath,i]   := FMarketGrid.cell[_BathTotal,x];   //could be 2.5
          SalesDataGrid.Cell[fBsmtArea,i]    := FMarketGrid.cell[_BasementGLA,x];
          SalesDataGrid.Cell[fBsmtFinArea,i] := FMarketGrid.cell[_BasementFGLA,x];
          SalesDataGrid.Cell[fGarage,i]      := FMarketGrid.cell[_GarageSpace,x];
          SalesDataGrid.Cell[fCarport,i]     := FMarketGrid.cell[_CarportSpace,x];
          SalesDataGrid.Cell[fFireplace,i]   := FMarketGrid.cell[_FireplaceQTY,x];
          SalesDataGrid.Cell[fPool,i]        := FMarketGrid.cell[_PoolQTY,x];
          SalesDataGrid.Cell[fSpa,i]         := FMarketGrid.cell[_SpaQTY,x];

          SalesDataGrid.Cell[fMLS_ID,i]      := FMarketGrid.cell[_MLSNUmber,x];
          SalesDataGrid.Cell[fUnit,i]        := FMarketGrid.cell[_UnitNumber,x];
          SalesDataGrid.Cell[fCity,i]        := FMarketGrid.cell[_City,x];
          SalesDataGrid.Cell[fState,i]       := FMarketGrid.cell[_State,x];
          SalesDataGrid.Cell[fZipCode,i]     := FMarketGrid.cell[_ZipCode,x];
          SalesDataGrid.Cell[fDistance,i]    := FMarketGrid.cell[_Proximity,x];
          SalesDataGrid.Cell[fPredAccuOrig,i] := SalesDataGrid.Cell[fPredAcc,i];
        end;
      end;
    end;
    nProp.Caption := IntToStr(i);
    SalesDataGrid.SortOnCol(fPredAcc, stDescending, True);
(*
  for x := 0 to Appraisal.Comps.SalesCount - 1 do
    begin
      if not Appraisal.Comps.Sale[x].FMktIncluded then  //github 524: controlled by MKTIncluded flag
        Continue;
      if (Appraisal.Comps.Sale[x].FCompKind = ckSale) then          //only want sales
      begin
        sales :=  strtofloattry(Appraisal.Comps.Sale[x].SalePrice);
        if sales <= 0 then
          Appraisal.Comps.Sale[x].UsedInRegression := False    //make sure its flagged as not included
        else  // if have sales price include in Regression.
          begin
            inc(i);
            SalesDataGrid.Rows              := i;
            SalesDataGrid.Cell[fID,i]       := i;   //row count, used to assoc chart points and grid
            SalesDataGrid.Cell[fIndex,i]    := x;   //index so we can save correctly back to Appraisal.Comps
            //Load values, not strings so sorting works properly
            if Appraisal.Comps.Sale[x].UsedInRegression then
              SalesDataGrid.Cell[fInRegess,i] := 1
            else
              SalesDataGrid.Cell[fInRegess,i] := 0;

            SalesDataGrid.Cell[fPredAcc,i]     := GetFirstValue(Appraisal.Comps.Sale[x].PredictedAccuracy);
            SalesDataGrid.Cell[fPredValue,i]   := GetFirstIntValue(Appraisal.Comps.Sale[x].PredictedValue);
  //          SalesDataGrid.Cell[fRank,i]        := Appraisal.Comps.Comp[x].Rank;
            SalesDataGrid.Cell[fAddress,i]     := Appraisal.Comps.Sale[x].Location.Address;
            SalesDataGrid.Cell[fSalesPrice,i]  := GetFirstIntValue(Appraisal.Comps.Sale[x].SalePrice);
            SalesDataGrid.Cell[fSalesDate,i]   := Appraisal.Comps.Sale[x].SaleDate;
            SalesDataGrid.Cell[fYearBuilt,i]   := GetFirstIntValue(Appraisal.Comps.Sale[x].YearBuilt);
            SalesDataGrid.Cell[fGLA,i]         := GetFirstIntValue(Appraisal.Comps.Sale[x].GLA);
            SalesDataGrid.Cell[fSiteArea,i]    := GetFirstIntValue(Appraisal.Comps.Sale[x].SiteArea);
            SalesDataGrid.Cell[fBedroom,i]     := GetFirstIntValue(Appraisal.Comps.Sale[x].BedroomCount);
            SalesDataGrid.Cell[fTotalBath,i]   := GetFirstValue(Appraisal.Comps.Sale[x].TotalBathCount);   //could be 2.5
            SalesDataGrid.Cell[fBsmtArea,i]    := GetFirstIntValue(Appraisal.Comps.Sale[x].BasementGLA);
            SalesDataGrid.Cell[fBsmtFinArea,i] := GetFirstIntValue(Appraisal.Comps.Sale[x].BasementFinGLA);
            SalesDataGrid.Cell[fGarage,i]      := GetFirstIntValue(Appraisal.Comps.Sale[x].GarageCarCount);
            SalesDataGrid.Cell[fCarport,i]     := GetFirstIntValue(Appraisal.Comps.Sale[x].CarportCarCount);
            SalesDataGrid.Cell[fFireplace,i]   := GetFirstIntValue(Appraisal.Comps.Sale[x].FireplacesCount);
            SalesDataGrid.Cell[fPool,i]        := GetFirstIntValue(Appraisal.Comps.Sale[x].PoolCount);
            SalesDataGrid.Cell[fSpa,i]         := GetFirstIntValue(Appraisal.Comps.Sale[x].SpaCount);
            SalesDataGrid.Cell[fMLS_ID,i]      := Appraisal.Comps.Sale[x].MLSID;
            SalesDataGrid.Cell[fUnit,i]        := Appraisal.Comps.Sale[x].Location.UnitNo;
            SalesDataGrid.Cell[fCity,i]        := Appraisal.Comps.Sale[x].Location.City;
            SalesDataGrid.Cell[fState,i]       := Appraisal.Comps.Sale[x].Location.State;
            SalesDataGrid.Cell[fZipCode,i]     := Appraisal.Comps.Sale[x].Location.Zip;
            SalesDataGrid.Cell[fDistance,i]    := GetFirstValue(Appraisal.Comps.Sale[x].FProximity);
            SalesDataGrid.Cell[fPredAccuOrig,i] := SalesDataGrid.Cell[fPredAcc,i];
          end;
      end;
    end;
  nProp.Caption := IntToStr(i);

  HighlightClickedRows;
  //sort by predict accuracy
//  SalesDataGrid.SortOnCol(fPredAcc, stDescending, True);
*)
end;

procedure TRegression.createXYChart;
begin
  FRegressionChartData.XPoints := TStringlist.Create;
  FRegressionChartData.YPoints := TStringlist.Create;
end;

procedure TRegression.BuildModelGrid;
var
  f : integer;
begin
  with tsGridModel.Col[3].Combo.comboGrid do
    begin
      rows := high(ConfLevels) + 1;
      for f:=0 to high(ConfLevels) do
        Cell[1,f+ 1] := ConfLevels[f];
    end;
end;

procedure TRegression.BuildConfGrid;
begin
//  tsGridConf.Cell[1,cDataQuality]   := 'Quality of Data';
//  tsGridConf.Cell[1,cSubjToData]    := 'Comparison of Subject to Data';
//  tsGridConf.Cell[1,cModelOutput]   := 'Overall Agreement with Model Output';
//  tsGridConf.Cell[1,cModelAccuracy] := 'Overall Agreement with Model Accurancy';
end;

// Build Component Grid Adding Component Name and ID.
procedure TRegression.BuildAdjComponentGrid;
var
  i : Integer;
begin
  tsGrid_Adj_Component.Rows  := cSalesDate;
  tsGrid_Adj_Component.Cell[1,1] := 'Base Market Value';

  tsGrid_Adj_Component.Cell[1,cGLA] := 'GLA';
  tsGrid_Adj_Component.Cell[6,cGLA] := fGLA;

//  tsGrid_Adj_Component.Cell[1,cTotalBath] := 'Bathroom'; //github 474
//  tsGrid_Adj_Component.Cell[6,cTotalBath] := fTotalBath;

  tsGrid_Adj_Component.Cell[1,cSiteArea] := 'Site Area';
  tsGrid_Adj_Component.Cell[6,cSiteArea] := fSiteArea;

//  tsGrid_Adj_Component.Cell[1,cGarage] := 'Garage';
//  tsGrid_Adj_Component.Cell[6,cGarage] := fGarage;

//  tsGrid_Adj_Component.Cell[1,cCarport] := 'Carport';
//  tsGrid_Adj_Component.Cell[6,cGarage] := fCarport;

  tsGrid_Adj_Component.Cell[1,cBsmtArea] := 'Basement Area';
  tsGrid_Adj_Component.Cell[6,cBsmtArea] := fBsmtArea;

  tsGrid_Adj_Component.Cell[1,cBsmtFinArea] := 'Basement Finished';
  tsGrid_Adj_Component.Cell[6,cBsmtFinArea] := fBsmtFinArea;

  tsGrid_Adj_Component.Cell[1,cYearBuilt] := 'YearBuilt';
  tsGrid_Adj_Component.Cell[6,cYearBuilt] := fYearBuilt;

//  tsGrid_Adj_Component.Cell[1,cFirePlace] := 'Fireplaces';
//  tsGrid_Adj_Component.Cell[6,cFirePlace] := fFireplace;

//  tsGrid_Adj_Component.Cell[1,cPool] := 'Pool';
//  tsGrid_Adj_Component.Cell[6,cPool] := fPool;

//  tsGrid_Adj_Component.Cell[1,cSpa] := 'Spa';
//  tsGrid_Adj_Component.Cell[6,cSpa] := fSpa;

  tsGrid_Adj_Component.Cell[1,cSalesDate] := 'Sales Date (per day)';
  tsGrid_Adj_Component.Cell[6,cSalesDate] := fSalesDate;

  if GetValidInteger(lblIndicatedVaue.Caption) = 0 then      //### need processMgr to indicate if its new or not
    begin
      for i := 1 to tsGrid_Adj_Component.Rows do
        tsGrid_Adj_Component.Cell[5,i] := 1; //checked
    end
(*
  if Appraisal.Regression.IndicatedValue = '' then      //### need processMgr to indicate if its new or not
    begin
      for i := 1 to tsGrid_Adj_Component.Rows do
        tsGrid_Adj_Component.Cell[5,i] := 1; //checked
    end
  else
    begin
      tsGrid_Adj_Component.Cell[5,1]  := Appraisal.Regression.Components.AdjBaseValue.Used;
      tsGrid_Adj_Component.Cell[5,2]  := Appraisal.Regression.Components.AdjGLA.Used;
      tsGrid_Adj_Component.Cell[5,3]  := Appraisal.Regression.Components.AdjBaths.Used;
      tsGrid_Adj_Component.Cell[5,4]  := Appraisal.Regression.Components.AdjSite.Used;
      tsGrid_Adj_Component.Cell[5,5]  := Appraisal.Regression.Components.AdjGarage.Used;
      tsGrid_Adj_Component.Cell[5,6]  := Appraisal.Regression.Components.AdjCarport.Used;
      tsGrid_Adj_Component.Cell[5,7]  := Appraisal.Regression.Components.AdjBSArea.Used;
      tsGrid_Adj_Component.Cell[5,8]  := Appraisal.Regression.Components.AdjBsFin.Used;
      tsGrid_Adj_Component.Cell[5,9]  := Appraisal.Regression.Components.AdjAge.Used;
      tsGrid_Adj_Component.Cell[5,10] := Appraisal.Regression.Components.AdjFireplace.Used;
      tsGrid_Adj_Component.Cell[5,11] := Appraisal.Regression.Components.AdjPool.Used;
      tsGrid_Adj_Component.Cell[5,12] := Appraisal.Regression.Components.AdjSpa.Used;
      tsGrid_Adj_Component.Cell[5,13] := Appraisal.Regression.Components.AdjDate.Used;
    end;
*)
end;

procedure TRegression.HighlightClickedRows;
var
  i, count: integer;
begin
  count := 0;
  SalesDataGrid.BeginUpdate;
  try
    for i := 1 to SalesDataGrid.Rows do
      if SalesDataGrid.Cell[fInRegess, i] = 0 then
        SalesDataGrid.RowColor[i] := colorLiteBlue
      else if (SalesDataGrid.Cell[fInRegess, i] = 1) then
        begin
          SalesDataGrid.RowColor[i] := clWhite;
          inc(count);
        end
      else
        SalesDataGrid.RowColor[i] := clWhite;
  finally
    SalesDataGrid.EndUpdate;
  end;
  nSelect.Caption := Format('%d',[count]);
end;

procedure TRegression.AnalyseAdjComponents;
var
  i : integer;
  value : real;
begin
  for i := 2 to tsGrid_Adj_Component.Rows do
    begin
     if tsGrid_Adj_Component.Cell[5,i] = 0 then
       tsGrid_Adj_Component.RowColor[i] := clWhite;
    end;

  for i := 2 to tsGrid_Adj_Component.Rows do
    begin
      value := strtofloattry(tsGrid_Adj_Component.Cell[2,i]);
      if value <> 0 then
        begin
          //check for negative values of only included (=1) components
          if (tsGrid_Adj_Component.Cell[5,i] = 1) and (value < 0) then
            begin
              if (i <> cYearBuilt) and (i <> cSalesDate) then
                tsGrid_Adj_Component.RowColor[i] := clYellow
            end
          //highlight yearbuilt if value is positive
          else if (i = cYearBuilt) and (value > 0) then
            tsGrid_Adj_Component.RowColor[i] := clYellow
          else
            tsGrid_Adj_Component.RowColor[i] := clWhite;
        end;
    end;
end;

procedure TRegression.GetSelectedComponents;
var
  i : integer;
begin
  NVar   := 0;
  if tsGrid_Adj_Component.Cell[5,2] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fGLA;
   end;
  if tsGrid_Adj_Component.Cell[5,3] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fTotalBath;
   end;
  if tsGrid_Adj_Component.Cell[5,4] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fSiteArea;
   end;
  if tsGrid_Adj_Component.Cell[5,5] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fGarage;
   end;
  if tsGrid_Adj_Component.Cell[5,6] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fCarport;
   end;
  if tsGrid_Adj_Component.Cell[5,7] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fBsmtArea;
   end;
  if tsGrid_Adj_Component.Cell[5,8] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fBsmtFinArea;
   end;
  if tsGrid_Adj_Component.Cell[5,9] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fYearBuilt;
   end;
  if tsGrid_Adj_Component.Cell[5,10] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fFireplace;
   end;
  if tsGrid_Adj_Component.Cell[5,11] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fPool;
   end;
  if tsGrid_Adj_Component.Cell[5,12] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fSpa;
   end;
  if tsGrid_Adj_Component.Cell[5,13] = 1 then
   begin
     NVar := NVar + 1;
     SetLength(ffields,NVar);
     ffields[NVar-1] := fSalesDate;
   end;

  thispct := 1.0;  // I need check if will be necessary
end;

procedure TRegression.ComparisonFilter;
begin
//  no more filter for now.
end;

// Transfer values from CompData to display Grid
procedure TRegression.GetPredictedValue;
var
  i,x : integer;
  IDTxt : String;
  address : string;
begin
  for i := 0 to CompData.Rows do
    begin
      IDTxt := CompData.Cell[fID,i];
      for x := 0 to SalesDataGrid.Rows do  //loop until we find the right row
        begin
          if UpperCase(SalesDataGrid.Cell[fID,x]) = UpperCase(IDTxt) then
            begin
              SalesDataGrid.Cell[fPredValue,x]    := CompData.Cell[fPredValue, i];
              SalesDataGrid.Cell[fPredAcc,x]      := CompData.Cell[fPredAcc, i];

              SalesDataGrid.Cell[fdiff,x]         := CompData.Cell[fDiff, i];          //###
              SalesDataGrid.Cell[fdiffPos,x]      := CompData.Cell[fDiffPos, i];    //###

              //remember the original predicted accuracy
              SalesDataGrid.Cell[fPredAccuOrig,x] := SalesDataGrid.Cell[fPredAcc,x];
              break;
            end;
        end;
    end;
end;
// Build virtual grid to hold all selected properties only.
procedure TRegression.LoadCompData;
var
  row,col, sampleCount: Integer;
  inclfield : Boolean;
begin
  CompData.Rows := 0;
  CompData.Cols := SalesDataGrid.Cols;
  sampleCount := 0;
  for row := 1 to SalesDataGrid.Rows do
    begin
      if SalesDataGrid.Cell[fInRegess,row] = 1 then		//checkbox is checked - use this comp
        begin
          sampleCount := sampleCount + 1;
          CompData.Rows := sampleCount;
          //transfer the data row
          for col := 1 to SalesDataGrid.Cols do
            begin
              CompData.Cell[col,sampleCount] := SalesDataGrid.Cell[col,row];
            end;
        end;
    end;

//  Sample size
  if sampleCount > 80 then
  begin
    tsGridModel.cell[2,1] := inttostr(sampleCount);
    tsGridModel.cell[3,1] := 'Very Good';
  end
  else if sampleCount > 45 then
  begin
    tsGridModel.cell[2,1] := inttostr(sampleCount);
    tsGridModel.cell[3,1] := 'Good';
  end
  else if sampleCount > 25 then
  begin
    tsGridModel.cell[2,1] := inttostr(sampleCount);
    tsGridModel.cell[3,1] := 'Acceptable';
  end
  else if sampleCount > 15 then
  begin
    tsGridModel.cell[2,1] := inttostr(sampleCount);
    tsGridModel.cell[3,1] := 'Low';
  end
  else {if sampleCount is 20 or below then}
  begin
    tsGridModel.cell[2,1] := inttostr(sampleCount);
    tsGridModel.cell[3,1] := 'Very Low';
  end;
  SampleSize := sampleCount;    //remember this
end;

// This function check if the component has sufficient data to be count in Regression.
procedure TRegression.CheckComponentsValidation;
var
  col,row,inclcount,f,t,totalcomp : integer;
  tempvalue1,tempvalue2 : string;
  inclfield: boolean;
begin
  inclcount := 0;
  for col := 0 to NVar - 1 do
    begin
      tempvalue1 :=  floattostrtry(CompData.cell[ffields[col],1]);
      inclfield := False;
      for row := 2 to N - 1 do
        begin
          tempvalue2 := floattostrtry(CompData.cell[ffields[col],row]);
            if tempvalue1 <> tempvalue2 then
              begin
                inclfield:= true;
                break;
              end;
        end;
      if (inclfield=false) and (ffields[col]<>fSalesDate) then
        ffields[col] := - 1000
      else
        inclcount := inclcount + 1;
    end;
    //Create components with sufficent data.
    setlength(fcomponents,inclcount);
    t := 0;
    for f := 0 to NVar-1 do
      begin
        if ffields[f] <> -1000 then
          begin
            fcomponents[t] := ffields[f];
            t := t + 1;
          end;
      end;
   NVar := t; // pass the total of Good Components.

   // NVar := Length(fcomponents);
end;

//Reset all data and clean stuff.
procedure TRegression.CleanRegression;
var
  i,x,row : Integer;
begin
  if Assigned(XX) then
    DelMatrix(XX,N,NVAR);
  if Assigned(YY) then
    DelVector(YY,N);
  if Assigned(B) then
    DelVector(B,N);
  if Assigned(V) then
    DelMatrix(V,Nvar,Nvar);
  if Assigned(Ycalc) then
    DelVector(Ycalc,N);

  N :=     0;
  NVar :=  0;
  Tc :=    0;
  Fc :=    0;
  Lb :=    0;
  Sr :=    0;
  SB :=    0;

  for i := 0 to tsGrid_Adj_Component.Rows do
    begin
      tsGrid_Adj_Component.Cell[0,i] := '';
      tsGrid_Adj_Component.Cell[2,i] := '';
      tsGrid_Adj_Component.Cell[4,i] := '';
      tsGrid_Adj_Component.Cell[3,i] := '';
    end;

  for i := 1 to SalesDataGrid.Rows do
    begin
      SalesDataGrid.Cell[fPredAcc,i] := '';
      SalesDataGrid.Cell[fPredValue,i] := '';
    end;

  if assigned(CompData) then //Avoid to get error when CompData is nil
    for i := 1 to CompData.Rows do
      begin
        for x:= 1 to CompData.Cols do
          CompData.Cell[x,i] := '';
      end;

  if assigned(FRegressionChartData.XPoints) then
    FRegressionChartData.XPoints.Clear;
  if assigned(FRegressionChartData.YPoints) then
    FRegressionChartData.YPoints.Clear;

  chart1.Series[0].Clear;
  chart1.Series[1].Clear;
  chart1.Series[2].Clear;

end;

// Load Components data into XX and YY Array.
procedure TRegression.LoadXXYY;
var
  i,row,col : integer;
  tempValue : string;
  valuationDate : string;
  value : real;
begin
  fldblankcount := 0;
  totalfields   := 0;
  {see if has more than one components built}
  if NVar > 0 then
    begin
      {run through all the selected property}
      for row := 1 to N do
        begin
          {get components value of the property}
          for col := 0 to NVar-1 do
            begin
              tempValue := CompData.Cell[fcomponents[col],row];

              {special handle Sales Date}
              if fcomponents[col] = fSalesDate then
                begin
                  valuationDate := FEffectiveDate;
                  tempvalue := floattostrtry2(GetDate(valuationDate) - GetDate(tempValue));
                  if fDateCalc = 1 then
                    begin
                      tempValue := floattostrtry2(strtofloattry(tempvalue)/15.2);
                      tempValue := dofmtfield(tempValue,'0.5',false,false);
                    end;
                  if fDateCalc = 2 then
                    begin
                      tempValue := inttostrtry(round(strtofloattry(tempValue)/30.4));
                    end;
                end;
              {special handle for numeric fields}
              if (fcomponents[col] = fGarage) or (fcomponents[col] = fCarport) or (fcomponents[col] = fFireplace) or
                 (fcomponents[col] = fPool) or (fcomponents[col] = fSpa) then
                  begin
                    if isNumeric(stripnumbers(tempValue)) then
                      tempValue := stripnumbers(tempValue);
                  end;

              {------------------------------------}
              totalfields := totalfields + 1;
              if tempValue <> '' then
                 fldblankcount := fldblankcount + 1;
              {------------------------------------}

              {special handle Sales Price}
              if fcomponents[col] <> fSalesPrice then
                begin
                  if not isnumeric(tempValue) then
                    begin
                      tempValue := '0';
                    end;
                end;
              {special handle YearBuilt}
              if fcomponents[col] = fYearBuilt then
                begin
                  if strToInt(tempValue) > 300 then
                    tempvalue := floatToStr( yearof(getdate(CompData.cell[fSalesDate,row]))- strtofloattry(CompData.cell[fcomponents[col],row]));
                end;

              value := strtofloattry(tempvalue);

              {post component value}
              XX^[row, col+1] := value;

              CompData.Cell[fcomponents[col],row] := FloatToStr(value);
            end;

          {post sales price only}
          YY^[row] := CompData.Cell[fSalesPrice,row];
        end;
    end;
end;
(*
function TSalesRegression.RatePValueSignificance(PValue: float): String;
begin
  if 0.01 > PValue then
    result := 'Very High'

  else if 0.05 > PValue then
    result := 'High'

  else if 0.15 > PValue then
    result := 'Moderate'

  else if 0.30 > PValue then
    result := 'Low'

  else
    result := 'Very Low';
end;
*)
procedure TRegression.CalcComponentsValue;
var
  i,count,adjcount,f : Integer;
  tempval1, tempval2: real;
  vLow,vAvarege,vHigh,vSignif : String;
  tStat, pValue,rangeTC: float;

  function RoundValue(value: Double): String;
  begin
    if abs(value) > 50 then		//if number is > 50, remove the decimal places
      result := FormatValue2(Value, bRnd1, True)      //round to whole #
    else
      result := FormatValue2(Value, bRnd1P2, True);   //2 dec places
  end;

begin
//init the components that will trasnfer to the grid, assume worst
(*
  Appraisal.Regression.Components.AdjGLA.Status       := 'Excluded';
  Appraisal.Regression.Components.AdjBaths.Status     := 'Excluded';
  Appraisal.Regression.Components.AdjSite.Status      := 'Excluded';
  Appraisal.Regression.Components.AdjGarage.Status    := 'Excluded';
  Appraisal.Regression.Components.AdjCarport.Status   := 'Excluded';
  Appraisal.Regression.Components.AdjBSArea.Status    := 'Excluded';
  Appraisal.Regression.Components.AdjBsFin.Status     := 'Excluded';
  Appraisal.Regression.Components.AdjAge.Status       := 'Excluded';
  Appraisal.Regression.Components.AdjFireplace.Status := 'Excluded';
  Appraisal.Regression.Components.AdjPool.Status      := 'Excluded';
  Appraisal.Regression.Components.AdjSpa.Status       := 'Excluded';
  Appraisal.Regression.Components.AdjDate.Status      := 'Excluded';

  Appraisal.Regression.Components.AdjGLA.Average      := '0';
  Appraisal.Regression.Components.AdjGLA.High         := '0';
  Appraisal.Regression.Components.AdjGLA.Low          := '0';
  Appraisal.Regression.Components.AdjGLA.Sign         := '0';

  Appraisal.Regression.Components.AdjBaths.Average    := '0';
  Appraisal.Regression.Components.AdjBaths.High       := '0';
  Appraisal.Regression.Components.AdjBaths.Low        := '0';
  Appraisal.Regression.Components.AdjBaths.Sign       := '0';

  Appraisal.Regression.Components.AdjSite.Average     := '0';
  Appraisal.Regression.Components.AdjSite.High        := '0';
  Appraisal.Regression.Components.AdjSite.Low         := '0';
  Appraisal.Regression.Components.AdjSite.Sign        := '0';

  Appraisal.Regression.Components.AdjGarage.Average   := '0';
  Appraisal.Regression.Components.AdjGarage.High      := '0';
  Appraisal.Regression.Components.AdjGarage.Low       := '0';
  Appraisal.Regression.Components.AdjGarage.Sign      := '0';

  Appraisal.Regression.Components.AdjCarport.Average  := '0';
  Appraisal.Regression.Components.AdjCarport.High     := '0';
  Appraisal.Regression.Components.AdjCarport.Low      := '0';
  Appraisal.Regression.Components.AdjCarport.Sign     := '0';

  Appraisal.Regression.Components.AdjBSArea.Average   := '0';
  Appraisal.Regression.Components.AdjBSArea.High      := '0';
  Appraisal.Regression.Components.AdjBSArea.Low       := '0';
  Appraisal.Regression.Components.AdjBSArea.Sign      := '0';

  Appraisal.Regression.Components.AdjBsFin.Average    := '0';
  Appraisal.Regression.Components.AdjBsFin.High       := '0';
  Appraisal.Regression.Components.AdjBsFin.Low        := '0';
  Appraisal.Regression.Components.AdjBsFin.Sign       := '0';

  Appraisal.Regression.Components.AdjAge.Average      := '0';
  Appraisal.Regression.Components.AdjAge.High         := '0';
  Appraisal.Regression.Components.AdjAge.Low          := '0';
  Appraisal.Regression.Components.AdjAge.Sign         := '0';

  Appraisal.Regression.Components.AdjFireplace.Average:= '0';
  Appraisal.Regression.Components.AdjFireplace.High   := '0';
  Appraisal.Regression.Components.AdjFireplace.Low    := '0';
  Appraisal.Regression.Components.AdjFireplace.Sign   := '0';

  Appraisal.Regression.Components.AdjPool.Average     := '0';
  Appraisal.Regression.Components.AdjPool.High        := '0';
  Appraisal.Regression.Components.AdjPool.Low         := '0';
  Appraisal.Regression.Components.AdjPool.Sign        := '0';

  Appraisal.Regression.Components.AdjSpa.Average      := '0';
  Appraisal.Regression.Components.AdjSpa.High         := '0';
  Appraisal.Regression.Components.AdjSpa.Low          := '0';
  Appraisal.Regression.Components.AdjSpa.Sign         := '0';

  Appraisal.Regression.Components.AdjDate.Average     := '0';
  Appraisal.Regression.Components.AdjDate.High        := '0';
  Appraisal.Regression.Components.AdjDate.Low         := '0';
  Appraisal.Regression.Components.AdjDate.Sign        := '0';
*)
  count := 0;
  if count = 0 then
    Lb := 0
  else
    Lb := 1;

  for f := 0 to NVar do
    begin
      if (count=0) or ((count>0) and (f>0)) then
        begin
          adjcount := 1;
          //this is crazy code!!
          if f > 0 then
            begin
              if fcomponents[f-1] = fGLA then         adjcount  := cGLA;
              //if fcomponents[f-1] = fTotalBath then   adjcount  := cTotalBath;
              if fcomponents[f-1] = fSiteArea then    adjcount  := cSiteArea;
              //if fcomponents[f-1] = fGarage then      adjcount  := cGarage;
              //if fcomponents[f-1] = fCarport then     adjcount  := cCarport;
              if fcomponents[f-1] = fBsmtArea then    adjcount  := cBsmtArea;
              if fcomponents[f-1] = fBsmtFinArea then adjcount  := cBsmtFinArea;
              if fcomponents[f-1] = fYearBuilt then   adjcount  := cYearBuilt;
              //if fcomponents[f-1] = fFireplace then   adjcount  := cFireplace;
              //if fcomponents[f-1] = fPool then        adjcount  := cPool;
              //if fcomponents[f-1] = fSpa then         adjcount  := cSpa;
              if fcomponents[f-1] = fSalesDate then   adjcount  := cSalesDate;
            end;

          SB := Sqrt(V^[f]^[f]);
          tStat := B^[f]/SB;
          pValue := pStudent(Test.Nu2,tStat);

          //for probable value range use confident level 30% rather than 5%, close to what JB used
          rangeTc := InvStudent(Test.Nu2,1 - 0.5 * 0.3);

          //get rid of the weird numbers and fractions
          vLow     := RoundValue(B^[f] - rangeTc * SB);         //formatfloat('###,###,###.00',B^[f] - SB);
          vAvarege := RoundValue(B^[f]);                        //formatfloat('###,####.##',B^[f]);
          vHigh    := RoundValue(B^[f] + rangeTc * SB);         //formatfloat('###,###,###.00',B^[f] + SB);
          vSignif  := FormatFloat('#0.00000', pValue);          //cannot use RoundValue for this one


          if f <> 0 then
            tsGrid_Adj_Component.Cell[0,adjcount] := IntToStr(fcomponents[f-1])
          else
            tsGrid_Adj_Component.Cell[0,adjcount] := -2;

          tsGrid_Adj_Component.Cell[2,adjcount] := vAvarege;
          tsGrid_Adj_Component.Cell[3,adjcount] := vLow + '   to   ' + vHigh;
          tsGrid_Adj_Component.Cell[4,adjcount] := vSignif;

//          tsGrid_Adj_Component.Cell[2,adjcount] := formatfloat('$###,####.##',B^[f]);
//          tsGrid_Adj_Component.Cell[3,adjcount] := formatfloat('$###,###,###.00',B^[f] -rangeTc * SB) + ' to ' + formatfloat('$###,###,###.00',B^[f] + rangeTc * SB);
//          tsGrid_Adj_Component.Cell[4,adjcount] := formatfloat('#0.00000',pValue);
        end;

        //get rid of the weird numbers and fractions
        vLow     := RoundValue(B^[f] - rangeTc * SB);         //formatfloat('###,###,###.00',B^[f] - SB);
        vAvarege := RoundValue(B^[f]);                        //formatfloat('###,####.##',B^[f]);
        vHigh    := RoundValue(B^[f] + rangeTc * SB);         //formatfloat('###,###,###.00',B^[f] + SB);
        vSignif  := FormatFloat('#0.00000', pValue);          //cannot use RoundValue for this one
        if adjcount = cBaseNeighborhoodValue then
          begin
//            Appraisal.Regression.Components.AdjBaseValue.Average := vAvarege;
//            Appraisal.Regression.Components.AdjBaseValue.High    := vHigh;
//            Appraisal.Regression.Components.AdjBaseValue.Low     := vLow;
//            Appraisal.Regression.Components.AdjBaseValue.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjBaseValue.Status  := 'Acceptable';
          end;

        if adjcount = cGLA then
          begin
//            Appraisal.Regression.Components.AdjGLA.Average := vAvarege;
//            Appraisal.Regression.Components.AdjGLA.High    := vHigh;
//            Appraisal.Regression.Components.AdjGLA.Low     := vLow;
//            Appraisal.Regression.Components.AdjGLA.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjGLA.Status  := PValueSignificance(pValue);
          end;

//        if adjcount = cTotalBath then
//          begin
//            Appraisal.Regression.Components.AdjBaths.Average := vAvarege;
//            Appraisal.Regression.Components.AdjBaths.High    := vHigh;
//            Appraisal.Regression.Components.AdjBaths.Low     := vLow;
//            Appraisal.Regression.Components.AdjBaths.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjBaths.Status  := PValueSignificance(pValue);
//          end;

        if adjcount = cSiteArea then
          begin
//            Appraisal.Regression.Components.AdjSite.Average := vAvarege;
//            Appraisal.Regression.Components.AdjSite.High    := vHigh;
//            Appraisal.Regression.Components.AdjSite.Low     := vLow;
//            Appraisal.Regression.Components.AdjSite.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjSite.Status  := PValueSignificance(pValue);
          end;

//        if adjcount = cGarage then
//          begin
//            Appraisal.Regression.Components.AdjGarage.Average := vAvarege;
//            Appraisal.Regression.Components.AdjGarage.High    := vHigh;
//            Appraisal.Regression.Components.AdjGarage.Low     := vLow;
//            Appraisal.Regression.Components.AdjGarage.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjGarage.Status  := PValueSignificance(pValue);
//          end;

//        if adjcount = cCarport then
//          begin
//            Appraisal.Regression.Components.AdjCarport.Average := vAvarege;
//            Appraisal.Regression.Components.AdjCarport.High    := vHigh;
//            Appraisal.Regression.Components.AdjCarport.Low     := vLow;
//            Appraisal.Regression.Components.AdjCarport.Sign    := vSignif;
//            Appraisal.Regression.Components.AdjCarport.Status  := PValueSignificance(pValue);
//          end;

        if adjcount = cBsmtArea then
          begin
//            Appraisal.Regression.Components.AdjBSArea.Average  := vAvarege;
//            Appraisal.Regression.Components.AdjBSArea.High     := vHigh;
//            Appraisal.Regression.Components.AdjBSArea.Low      := vLow;
//            Appraisal.Regression.Components.AdjBSArea.Sign     := vSignif;
//            Appraisal.Regression.Components.AdjBSArea.Status  := PValueSignificance(pValue);
          end;

//        if adjcount = cBsmtFinArea then
//          begin
//            Appraisal.Regression.Components.AdjBsFin.Average   := vAvarege;
//            Appraisal.Regression.Components.AdjBsFin.High      := vHigh;
//            Appraisal.Regression.Components.AdjBsFin.Low       := vLow;
//            Appraisal.Regression.Components.AdjBsFin.Sign      := vSignif;
//            Appraisal.Regression.Components.AdjBsFin.Status    := PValueSignificance(pValue);
//          end;

        if adjcount = cYearBuilt then
          begin
//            Appraisal.Regression.Components.AdjAge.Average     := vAvarege;
//            Appraisal.Regression.Components.AdjAge.High        := vHigh;
//            Appraisal.Regression.Components.AdjAge.Low         := vLow;
//            Appraisal.Regression.Components.AdjAge.Sign        := vSignif;
//            Appraisal.Regression.Components.AdjAge.Status      := PValueSignificance(pValue);
          end;

//        if adjcount = cFireplace then
//          begin
//            Appraisal.Regression.Components.AdjFireplace.Average    := vAvarege;
//            Appraisal.Regression.Components.AdjFireplace.High       := vHigh;
//            Appraisal.Regression.Components.AdjFireplace.Low        := vLow;
//            Appraisal.Regression.Components.AdjFireplace.Sign       := vSignif;
//            Appraisal.Regression.Components.AdjFireplace.Status     := PValueSignificance(pValue);
//          end;

//        if adjcount = cPool then
//          begin
//            Appraisal.Regression.Components.AdjPool.Average    := vAvarege;
//            Appraisal.Regression.Components.AdjPool.High       := vHigh;
//            Appraisal.Regression.Components.AdjPool.Low        := vLow;
//            Appraisal.Regression.Components.AdjPool.Sign       := vSignif;
//            Appraisal.Regression.Components.AdjPool.Status     := PValueSignificance(pValue);
//          end;

//        if adjcount = cSpa then
//          begin
//            Appraisal.Regression.Components.AdjSpa.Average     := vAvarege;
//            Appraisal.Regression.Components.AdjSpa.High        := vHigh;
//            Appraisal.Regression.Components.AdjSpa.Low         := vLow;
//            Appraisal.Regression.Components.AdjSpa.Sign        := vSignif;
//            Appraisal.Regression.Components.AdjSpa.Status      := PValueSignificance(pValue);
//          end;

        if adjcount = cSalesDate then
          begin
//            Appraisal.Regression.Components.AdjDate.Average    := vAvarege;
//            Appraisal.Regression.Components.AdjDate.High       := vHigh;
//            Appraisal.Regression.Components.AdjDate.Low        := vLow;
//            Appraisal.Regression.Components.AdjDate.Sign       := vSignif;
//            Appraisal.Regression.Components.AdjDate.Status     := PValueSignificance(pValue);
          end;
    end; //for loop
    {Clean first row of components}
    tsGrid_Adj_Component.Cell[3,1] := '';
    tsGrid_Adj_Component.Cell[4,1] := '';
    tsGrid_Adj_Component.Cell[5,1] := '';
    tsGrid_Adj_Component.CellColor[3,1] := clSilver;
    tsGrid_Adj_Component.CellColor[4,1] := clSilver;
    tsGrid_Adj_Component.CellControlType[5,1] := ctText;
    tsGrid_Adj_Component.CellColor[5,1] := clSilver;
	//deselecte when insufficient, but do not say "Excluded"
    for i := 2 to tsGrid_Adj_Component.Rows do
      begin
      //(* -- code deselects the item when insufficient
      (*
        if (tsGrid_Adj_Component.Cell[2,i] = '') then
          begin
            tsGrid_Adj_Component.Cell[2,i] := 'Insufficient Data';
            tsGrid_Adj_Component.RowColor[i] := clWhite;
            tsGrid_Adj_Component.Cell[5,i] := 0;
          end
        else if tsGrid_Adj_Component.Cell[5,i] = 0 then
          begin
            tsGrid_Adj_Component.Cell[2,i] := 'Excluded';
            tsGrid_Adj_Component.RowColor[i] := clWhite;
          end;
       *)
        if tsGrid_Adj_Component.Cell[5,i] = 0 then
          begin
            tsGrid_Adj_Component.Cell[2,i] := 'Excluded';
            tsGrid_Adj_Component.RowColor[i] := clWhite;
          end;
        if (tsGrid_Adj_Component.Cell[5,i] = 1) and (tsGrid_Adj_Component.Cell[2,i] = '') then
          begin
            tsGrid_Adj_Component.Cell[2,i] := 'Insufficient Data';
            tsGrid_Adj_Component.RowColor[i] := clWhite;
          end;
      end;

//  tsGridConf.Cell[2,cDataQuality] := formatfloat('####.00%',(fldblankcount/totalfields)* 100 );
//  tsGridConf.Cell[2,cDataQuality] := 'Acceptable';

//  if (fldblankcount/totalfields)* 100 < 90 then
//    tsGridConf.cell[2,cDataQuality] := 'Low';

//  if (fldblankcount/totalfields)* 100 < 70 then
//    tsGridConf.cell[2,cDataQuality] := 'Very Low';
end;

// Subject value calculation
procedure TRegression.CalcSubjectIndicatedValue;
var
  i,f,componentId : Integer;
  substories, subsf,subbr,subba,subgar,subcar,subfp,subsite, subpool, subspa: real;
  subsiteviews, subsiteamenities, subhoa, subbasement, subbasementpf: real;
  subcondition, subflooring, subappliances: real;
  subwindows, subfeatures, subpatios: real;
  subfencing, subutilities: real;
  subsubdivision, subschool, subconstruction: real;
  subunits, subroofing, subaddgla: real;
  subflood, subzoning, subdesign, subbldgs: real;
  subBsmtGLA, subjBsmtFGLA, subAge: Real;
  subjectValue, featureValue,featureFactor : real;
  effYear,D,M : Word;
  subYb: integer;
begin
  //get data values from Subject Object}
  //get the age of the property, relative to the effective appraisal date
//  DecodeDate(StrToDate(Appraisal.Recon.EffectiveDate), effYear, M, D);
  DecodeDate(StrToDateDef(FEffectiveDate, Date), effYear, M, D);
  subYb :=  StrToIntDef(FDoc.GetCellTextByID(151),0);
  if (subyb = 0) then                                          //might be zero for 'New'
    subYb := YearOf(Date);

  subAge        := effYear - subYb;
  subsf         := StrToFloatDef(FDoc.GetCellTextByID(1004),0);
  subsite       := StrToFloatDef(FDoc.GetCellTextByID(976), 0);
  subBsmtGLA    := StrToFloatDef(FDoc.GetCellTextByID(200), 0);
  subjBsmtFGLA  := StrToFloatDef(FDoc.GetCellTextByID(201), 0);
  subfp         := StrToFloatDef(FDoc.GetCellTextByID(321), 0);
  subgar        := StrToFloatDef(FDoc.GetCellTextByID(2030), 0);
  subcar        := StrToFloatDef(FDoc.GetCellTextByID(355), 0);
  subbr         := StrToFloatDef(FDoc.GetCellTextByID(230), 0);
  subba         := StrToFloatDef(FDoc.GetCellTextByID(231), 0);
  subpool       := StrToFloatDef(FDoc.GetCellTextByID(240), 0);
//  subspa        := StrToFloatDef(FDoc.GetCellTextByID(201), 0);


(*
  subjBsmtFGLA  := StrToFloatDef(Appraisal.Subject.BasementFinGLA, 0);
  subfp         := StrToFloatDef(Appraisal.Subject.FireplacesCount,0);
  subgar        := StrToFloatDef(Appraisal.Subject.GarageCarCount,0);
  subcar        := StrToFloatDef(Appraisal.Subject.CarportCarCount,0);
  subbr         := StrToFloatDef(Appraisal.Subject.BedroomCount,0);
  subba         := StrToFloatDef(Appraisal.Subject.TotalBathCount,0);
  subpool       := StrToFloatDef(Appraisal.Subject.PoolCount,0);
  subspa        := StrToFloatDef(Appraisal.Subject.SpaCount,0);
*)
  //calculate the subject's value based on components of value
  //subject's starting value = neighborhood base value
  subjectValue := StrToFloatTry(tsGrid_Adj_Component.cell[2,1]);

  //add in the other factors: multiply the subject characteristics times the component values
  for f := 2 to tsGrid_Adj_Component.rows - 1 do
    begin
      if tsGrid_Adj_Component.Cell[5,2] = 1 then     //was this feature included in calculation
        begin
          componentId   := tsGrid_Adj_Component.cell[6,f];
          featureFactor := strtofloattry(tsGrid_Adj_Component.cell[2,f]);
        end;
      case componentId of
          fGLA:           featureValue := subsf;
          fBsmtArea:      featureValue := subBsmtGLA;
          fBsmtFinArea:   featureValue := subjBsmtFGLA;
          fSiteArea:      featureValue := subsite;
          fYearBuilt:     featureValue := subAge;
          fTotalBath:     featureValue := subba;
          fGarage:        featureValue := subgar;
          fCarport:       featureValue := subcar;
          fFireplace:     featureValue := subfp;
          fPool:          featureValue := subpool;
          fSpa:           featureValue := subspa;
      end;
      subjectValue := subjectValue + (featureValue * featureFactor);
    end;

  IndicatedValue := Round(subjectValue);  //no decimals
  FRegressionChartData.SubjPredValue := FormatFloat('$ ###,###,### ',subjectValue);
end;

procedure TRegression.FillAdjustFactors;
begin
 //what goes here
end;

procedure TRegression.ProcessRegression;
var
  i,j,row,col : integer;
  sl : TStringList;
  tempval : string;
  Mx,Mn,Me : float;
begin
  {load all selected data to a virtual regression grid}
  LoadCompData;

  N  := CompData.Rows;
  if N < 10 then
    begin
//    ShowAlert(atWarnAlert, 'The number of properties must be at least 10 to perform regression.');
      Abort;
    end;

  {get all selected components}
  getSelectedComponents;
  {validate selected components}
  CheckComponentsValidation;
  {build regression array interface}
  DimMatrix(XX,N,NVAR);
  DimVector(YY,N);
  DimVector(Ycalc,N);
  DimVector(B,NVar);
  DimMatrix(V,NVar,NVar);
  {load components w/ data}
  LoadXXYY;

 /////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////
 ///////////////////////         Start Regression      ///////////////////////
 /////////////////////////////////////////////////////////////////////////////

 (*
   Write XX and YY data into a text file for debub and test.


  sl := TStringList.Create;
  for row := 1 to N-1 do
    begin
      tempval := '';
      for col := 1 to NVar do
        begin
          tempval := tempval + floattostrtry2(XX^[row,col]);
          tempval := tempval + chr(9);
        end;
      tempval := tempval + floattostrtry2(YY^[row]);
      sl.Add(tempval);
    end;
   sl.SaveToFile('c:\RegXXYY.txt');  *)

 (**************************************)
  try
    MulFit(XX,YY,1,N,NVAR,ConsTerm,{ 1.0E-2,}B,V);
    {Compute predicted Y value}

    for i := 1 to N do
      begin
       if ConsTerm then
         Ycalc^[i] := B^[0]
       else
         Ycalc^[i] := 0.0;

       for j := 1 to NVAR do
         begin
           Ycalc^[i] := Ycalc^[i] + B^[j] * XX^[i]^[j];
         end;
     end;

    if ConsTerm then
      Lb := 0
    else
      Lb := 1;

    RegTest(YY,Ycalc,1,N,V,Lb,NVar,Test);
    Tc := InvStudent(Test.Nu2,1 - 0.5 * Alpha);
    Fc := InvSnedecor(Test.Nu1,Test.Nu2,1 - Alpha);

  except on E:Exception do
    ShowAlert(atStopAlert, 'There was a problem during the calculation. '+ FriendlyErrorMsg(E.Message));
  end;

  try
    WriteResults(N, NVar, YY, Ycalc, B, V, Test, Tc, Fc);

  except on E:Exception do
    ShowAlert(atStopAlert, 'There was a problem writing the calculation results. '+ FriendlyErrorMsg(E.Message));
  end;
 /////////////////////////////////////////////////////////////////////////////
 ////////////////////////         End Regression     /////////////////////////
 /////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////

  GetPredictedValue;
  CalcComponentsValue;
  CalcSubjectIndicatedValue;
  AnalyseAdjComponents; 
  BuildChart;
end;

procedure TRegression.RunRegression;
begin
  CleanRegression;
  ProcessRegression;
  HighlightClickedRows;
  FSetAdjustmentValue := True;

//  Appraisal.Regression.LastRegressionPath := 'Path0';
end;

procedure TRegression.RunAutoRegressionPath1;
begin
//  LoadRegression;       //loads regression data & any previous regression info
///  SelectAllProperties;  //github 540: per Neil, we should not do this since the comp selection is now before the regression
  SelectAllProperties;   //github #589: need to include all properties when we run the auto regression process
  HighlightClickedRows;
  IncludeAllClick(self);
  RunRegression;
  RemoveNonAccurateOutlier(20);   //remove the outlires
  RunRegression;                  //run regression
  RemoveNonAccurateOutlier(20);   //remove any new outliers
  RunRegression;                  //run again
//RemoveNonSimilarOutlier(50);
//RunRegression;
//  DrawBellCurveChart;
//  Appraisal.Regression.LastRegressionPath := 'Path1';
end;

procedure TRegression.btnRegressionClick(Sender: TObject);
begin
  if ControlKeyDown then
    RunAutoRegressionPath1
  else
    begin
      RunRegression;
//      DrawBellCurveChart;  //draw bell chart
    end;

//  Appraisal.Control.NeedSaleRegresUpdate := False;       //signal Control Mgr regression done.
//  Appraisal.Recon.ValBySalesRegression := Appraisal.Regression.IndicatedValue;

  FRegressed := FIndicatedValue > 0;

  if FAdjustments <> nil then
    begin
      TAdjustments(FAdjustments).FImportMLS := True;
      TAdjustments(FAdjustments).InitialAdjustments(True);
    end;


//  FDataModified := True;
end;

procedure TRegression.tsGrid_Adj_ComponentClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
begin
  FDataModified := True;
  if DataColDown = 5 then
    AnalyseAdjComponents;
end;

function TRegression.getrow2(i: string): integer;
var
  f: integer;
  s: string;
begin
  result  := -9;
  i := copy(i,1,length(i)-1);
  for f := 1 to CompData.rows- 1 do
    begin
      if STRIPNUMBERS2(CompData.cell[fMLS_ID,f])=i then
        begin
          result := f;
          break;
          exit;
        end;
    end;
end;

function TRegression.GetRow(i: string): integer;
var
  f: integer;
begin
  result  := -9;
  for f := 1 to SalesDataGrid.rows do
    if SalesDataGrid.cell[fID,f] = i then
      begin
        result := f;
        break;
      end;
end;

procedure TRegression.Chart1ClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  row,i,id,f: integer;
  b: string;
  yv,vi: real;
  index : integer;
begin
(*
  try
    chmousedown := False;
   // If 0 get subject info
   if Series.Title = 'subject' then
     begin
     //This should get the info off the Grid so it matches what the user sees
        Application.CreateForm(TFProperty,FProperty);
        try
          FProperty.Panel1.Caption        := Appraisal.Subject.Location.Address  + ' ' + Appraisal.Subject.Location.City + ', ' + Appraisal.Subject.Location.State + ' ' + Appraisal.Subject.Location.Zip;
          FProperty.saledatelbl.caption   := Appraisal.Subject.SaleDate;
          FProperty.predvallbl.Caption    := '';
          FProperty.predratiolbl.caption  := '';
          //FProperty.simscorelbl.caption := SalesDataGrid.cell[FScore,f];
          FProperty.salepricelbl.caption  := Appraisal.Subject.SalePrice;
          FProperty.glalbl.caption        := Appraisal.Subject.GLA;
          FProperty.sitearealbl.caption   := Appraisal.Subject.SiteArea;
          FProperty.yblbl.caption         := Appraisal.Subject.YearBuilt;
          FProperty. brlbl.caption        := Appraisal.Subject.BedroomCount;
          FProperty.balbl.caption         := Appraisal.Subject.TotalBathCount;
          FProperty.poollbl.caption       := Appraisal.Subject.PoolCount + ', ' +  Appraisal.Subject.SpaCount;
          FProperty.fplbl.caption         := Appraisal.Subject.FireplacesCount;
          FProperty.basementlbl.caption   := Appraisal.Subject.BasementGLA + '/'+  Appraisal.Subject.BasementFinPercent;
          FProperty.cslbl.Caption         := Appraisal.Subject.GarageCarCount + ', ' +  Appraisal.Subject.CarportCarCount;
          Fproperty.btnExcluded.Enabled   := False;

          if FProperty.ShowModal = mrOk then
            begin
            end;
        finally
          FProperty.free;
        end;
     end
   else
     begin
        yv := chart1.series[1].YValue[ValueIndex];
        b := floattostr(yv);
        i := pos('.',b);
        b := copy(b,i+1,length(b));
        id :=  StrToInt(stringreplace(b,'999','',[rfReplaceAll]));
        row := getRow(IntToStr(id));

        Application.CreateForm(TFProperty,FProperty);
        try
          Fproperty.btnExcluded.Enabled   := True;
          FProperty.Panel1.Caption        := SalesDataGrid.cell[FAddress,row] + ' ' + SalesDataGrid.cell[fCity,row] + ', ' + SalesDataGrid.cell[fState,row] + ' ' + SalesDataGrid.cell[fZipCode,row];
          FProperty.saledatelbl.caption   := SalesDataGrid.cell[fSalesDate,row];
          FProperty.predvallbl.Caption    := formatfloat('$###,###,###' ,strtofloattry(SalesDataGrid.cell[fPredValue,row]));
          FProperty.predratiolbl.caption  := SalesDataGrid.cell[fPredAcc,row];
//          FProperty.lblRank.caption       := IntToStr(SalesDataGrid.cell[fRank,row]);
          FProperty.salepricelbl.caption  := Formatfloat('$###,###,###' ,strtofloattry(SalesDataGrid.cell[fSalesPrice,row]));
          FProperty.glalbl.caption        := SalesDataGrid.cell[fGLA,row];
          FProperty.sitearealbl.caption   := SalesDataGrid.cell[fSiteArea,row];
          FProperty.yblbl.caption         := SalesDataGrid.cell[fYearBuilt,row];
          FProperty. brlbl.caption        := SalesDataGrid.cell[FBedroom,row];
          FProperty.balbl.caption         := SalesDataGrid.cell[fTotalBath,row];
          FProperty.poollbl.caption       := SalesDataGrid.cell[fPool,row] + ', ' +  SalesDataGrid.cell[fSpa,row];
          FProperty.fplbl.caption         := SalesDataGrid.cell[fFireplace,row];
          FProperty.basementlbl.caption   := SalesDataGrid.cell[fBsmtArea,row] + '/'+  SalesDataGrid.cell[fBsmtFinArea,row];
          FProperty.cslbl.Caption         := SalesDataGrid.cell[fGarage,row] + ', ' +  SalesDataGrid.cell[fCarport,row];

          //display the information
          if FProperty.ShowModal = mrOk then
            begin
              SalesDataGrid.Cell[fInRegess, row] := 0;
              btnRegression.Click;
            end;
        finally
          FProperty.free;
        end;
     end;
  except
  end;
*)
end;

procedure TRegression.IncludeAllClick(Sender: TObject);
begin
  SelectAllProperties;
  HighlightClickedRows;
  //Since the Predict Accuracy list is sorted in ascending order, we use the first item as position1 and last as position2
//  SetTrkbarRange(FPreAccuracyList);
end;

procedure TRegression.SelectAllProperties;
var
  i,count: integer;
begin
  count := 0;
  for i := 1 to SalesDataGrid.Rows do
    begin
      SalesDataGrid.Cell[fInRegess,i] := 1;  //github 483: this is a mistake, we only need to know how many are included to show on the label.
   //   if SalesDataGrid.CellCheckBoxState[fInRegess,i] = cbChecked then
        count := count + 1;
    end;
  nSelect.Caption := IntToStr(Count);
end;

//disables the editor and allows the check box setting in OnCellClick
procedure TRegression.SalesDataGridShowEditor(Sender: TObject;
  DataCol, DataRow: Integer; var Cancel: Boolean);
begin
  Cancel := True;
end;

procedure TRegression.SalesDataGridClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
var
  i: Integer;
  checked: Boolean;
begin
  //clicking in the include/exclude checkbox column
  if (DataColDown = fInRegess) then
    begin
      if SalesDataGrid.Cell[fInRegess, DataRowDown] = 1 then
        SalesDataGrid.Cell[fInRegess, DataRowDown] := 0
      else
        SalesDataGrid.Cell[fInRegess, DataRowDown] := 1;

      checked := (SalesDataGrid.Cell[fInRegess, DataRowDown] = 1);
      if ShiftKeyDown then
        for i := DataRowDown + 1 to SalesDataGrid.Rows do
          begin
            if checked then
              SalesDataGrid.Cell[fInRegess,i] := 1
            else
              SalesDataGrid.Cell[fInRegess,i] := 0;
          end;

       HighlightClickedRows;
       //StatusBroadcaster.DataModified := True;      //let adjustments know data has changed
       FDataModified := True;   //github 483
    end;
end;

procedure TRegression.LoadRegressionDataSource;
begin
  try
    LoadDataSource;

//    tsGridConf.Cell[2,cDataQuality]   := Appraisal.Regression.DataQuality;
//    tsGridConf.Cell[2,cSubjToData]    := Appraisal.Regression.SubjToData;
//    tsGridConf.Cell[2,cModelOutput]   := Appraisal.Regression.ModelOutput;
//    tsGridConf.Cell[2,cModelAccuracy] := Appraisal.Regression.ModelAccuracy;
  except ; end; //ignore error and keep going
end;

procedure TRegression.SaveRegression;
var
  TempImage: TBitMap;
  i,qty,saleIndex : Integer;
  Address : String;
//  Prop : TProperty;
  vPred,vAcc,vDiff : String;
//  AppraisalComps: TComparableList;
begin
(*
  try
    //save chart 1 - scatter plot
    TempImage := TBitmap.Create;
    try
      GetBitmapOfChart(Chart1, TempImage);
      if Assigned(TempImage) then
         Appraisal.Regression.ScatterPlotChart.Assign(TempImage);
    finally
      TempImage.Free;
    end;

    //save chart 2 - accuracy distribution
    TempImage := TBitmap.Create;
    try
      GetBitmapOfChart(chartBellCurve, TempImage);
      if Assigned(TempImage) then
         Appraisal.Regression.AccuracyDistChart.Assign(TempImage);
    finally
      TempImage.Free;
    end;

    Appraisal.Regression.DataQuality        := tsGridConf.Cell[2,cDataQuality];	//### should hold as a property
    Appraisal.Regression.SubjToData         := tsGridConf.Cell[2,cSubjToData];
    Appraisal.Regression.ModelOutput        := tsGridConf.Cell[2,cModelOutput];
    Appraisal.Regression.ModelAccuracy      := tsGridConf.Cell[2,cModelAccuracy];

    Appraisal.Regression.SampleSize         := tsGridModel.Cell[2,cSampleSize]; //IntToStr(SampleSize);
    Appraisal.Regression.SampleSizeConf     := tsGridModel.Cell[3,cSampleSize];
    Appraisal.Regression.RSquared           := tsGridModel.Cell[2,cRSquared];
    Appraisal.Regression.RSquaredConf       := tsGridModel.Cell[3,cRSquared];
    Appraisal.Regression.AdjSquared         := tsGridModel.Cell[2,cAdjSquared];
    Appraisal.Regression.AdjSquaredConf     := tsGridModel.Cell[3,cAdjSquared];
    Appraisal.Regression.COV                := tsGridModel.Cell[2,cCOV];
    Appraisal.Regression.COVConf            := tsGridModel.Cell[3,cCOV];
    Appraisal.Regression.COD                := tsGridModel.Cell[2,cCOD];
    Appraisal.Regression.CODConf            := tsGridModel.Cell[3,cCOD];
    Appraisal.Regression.StandardError      := FormatValue2(StdErr, bRnd1P2, True);
    Appraisal.Regression.StandardErrorConf  := tsGridModel.Cell[3,cStandardError];
    Appraisal.Regression.IndicatedValue     := FloatToStr(IndicatedValue);

  //  Appraisal.Regression.Comments           := AnalysisComments.Text;

    //setting these values is very messy - we need to rewrite and put all these into an array
    //set all names because some components may have been excluded and names will be missing in CalcComponents
    Appraisal.Regression.Components.AdjBaseValue.Name := 'Neighborhood Base Value';
    Appraisal.Regression.Components.AdjGLA.Name       := 'Gross Living Area';
    Appraisal.Regression.Components.AdjBaths.Name     := 'Bathroom'; //github 474
    Appraisal.Regression.Components.AdjSite.Name      := 'Site Area';
    Appraisal.Regression.Components.AdjGarage.Name    := 'Garage Car Spaces';
    Appraisal.Regression.Components.AdjCarport.Name   := 'Carport Car Spaces';
    Appraisal.Regression.Components.AdjBSArea.Name    := 'Basement Area';
    Appraisal.Regression.Components.AdjBsFin.Name     := 'Basement Finished Area';
    Appraisal.Regression.Components.AdjAge.Name       := 'Year Built';
    Appraisal.Regression.Components.AdjFireplace.Name := 'Fireplace(s)';
    Appraisal.Regression.Components.AdjPool.Name      := 'Pool';
    Appraisal.Regression.Components.AdjSpa.Name       := 'Spa';
    Appraisal.Regression.Components.AdjDate.Name      := 'Sale Date';

    //did the user exclude the components
    Appraisal.Regression.Components.AdjGLA.Used     := tsGrid_Adj_Component.Cell[5,2];
    Appraisal.Regression.Components.AdjBaths.Used   := tsGrid_Adj_Component.Cell[5,3];
    Appraisal.Regression.Components.AdjSite.Used    := tsGrid_Adj_Component.Cell[5,4];
    Appraisal.Regression.Components.AdjGarage.Used  := tsGrid_Adj_Component.Cell[5,5];
    Appraisal.Regression.Components.AdjCarport.Used := tsGrid_Adj_Component.Cell[5,6];
    Appraisal.Regression.Components.AdjBSArea.Used  := tsGrid_Adj_Component.Cell[5,7];
    Appraisal.Regression.Components.AdjBsFin.Used   := tsGrid_Adj_Component.Cell[5,8];
    Appraisal.Regression.Components.AdjAge.Used     := tsGrid_Adj_Component.Cell[5,9];
    Appraisal.Regression.Components.AdjFireplace.Used := tsGrid_Adj_Component.Cell[5,10];
    Appraisal.Regression.Components.AdjPool.Used    := tsGrid_Adj_Component.Cell[5,11];
    Appraisal.Regression.Components.AdjSpa.Used     := tsGrid_Adj_Component.Cell[5,12];
    Appraisal.Regression.Components.AdjDate.Used    := tsGrid_Adj_Component.Cell[5,13];

    //this is what we will show in the report
    if not (Appraisal.Regression.Components.AdjGLA.Used = 1) then
      Appraisal.Regression.Components.AdjGLA.Status     := 'Excluded';
    if not (Appraisal.Regression.Components.AdjBaths.Used = 1) then
      Appraisal.Regression.Components.AdjBaths.Status   := 'Excluded';
    if not (Appraisal.Regression.Components.AdjSite.Used = 1) then
      Appraisal.Regression.Components.AdjSite.Status    := 'Excluded';
    if not (Appraisal.Regression.Components.AdjGarage.Used = 1) then
      Appraisal.Regression.Components.AdjGarage.Status  := 'Excluded';
    if not (Appraisal.Regression.Components.AdjCarport.Used = 1) then
      Appraisal.Regression.Components.AdjCarport.Status := 'Excluded';
    if not (Appraisal.Regression.Components.AdjBSArea.Used = 1) then
      Appraisal.Regression.Components.AdjBSArea.Status  := 'Excluded';
    if not (Appraisal.Regression.Components.AdjBsFin.Used = 1) then
      Appraisal.Regression.Components.AdjBsFin.Status   := 'Excluded';
    if not (Appraisal.Regression.Components.AdjAge.Used = 1) then
      Appraisal.Regression.Components.AdjAge.Status     := 'Excluded';
    if not (Appraisal.Regression.Components.AdjFireplace.Used = 1) then
      Appraisal.Regression.Components.AdjFireplace.Status := 'Excluded';
    if not (Appraisal.Regression.Components.AdjPool.Used = 1) then
      Appraisal.Regression.Components.AdjPool.Status    := 'Excluded';
    if not (Appraisal.Regression.Components.AdjSpa.Used = 1) then
      Appraisal.Regression.Components.AdjSpa.Status     := 'Excluded';
    if not (Appraisal.Regression.Components.AdjDate.Used = 1) then
      Appraisal.Regression.Components.AdjDate.Status    := 'Excluded';

    AppraisalComps := Appraisal.Comps;
    for i := 1 to SalesDataGrid.Rows do
      begin
        saleIndex := SalesDataGrid.Cell[fIndex,i];         //index CRITICAL to identify the correct sale
        if saleIndex >= 0 then
          begin
            Prop := AppraisalComps.Sale[saleIndex];
            if assigned(Prop) then
              begin
                Prop.UsedInRegression       := (SalesDataGrid.Cell[fInRegess,i] = 1);
                Prop.PredictedValue         := SalesDataGrid.Cell[fPredValue,i];
                Prop.PredictedAccuracy      := SalesDataGrid.Cell[fPredAcc,i];
                Prop.PredictedDifference    := SalesDataGrid.Cell[fDiff,i];
              end;
          end;
      end;
  except on E:Exception do
//    ShowMessage('SaveRegression error: '+e.Message);
  end;
*)
end;

procedure TRegression.UpdateAdjustmentValues;
begin
  LoadComponentsOfValueToAdjusterMgr;
end;

function TRegression.ProcessCompleted: Boolean;
begin
//  Appraisal.Control.NeedSaleRegresUpdate := False;       //signal Control Mgr regression done.

//  Appraisal.Recon.ValBySalesRegression := Appraisal.Regression.IndicatedValue;

//  result := Appraisal.Regression.IndicatedValue <> '';   //we have final indicated value
end;

procedure TRegression.LoadComponentsOfValueToAdjusterMgr;
var
  i: Integer;

  function GetRoundedValue(value: String): Double;
  var
    testValue: Double;
  begin
    testValue := GetFirstValue(value);
    if abs(testValue) > 50 then
      result := Round(testValue)
    else
      result := Round(testValue/0.01)*0.01;      //max of 2 decimal palces
  end;
begin
//### - in future TComponents needs to be rewritten as a list
(*
  with Appraisal.Regression.Components do
    begin
      i := rowAdjSaleDate - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjDate.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := Appraisal.Regression.Components.AdjDate.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjDate.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjDate.Sign;
      if (AdjDate.Used = 1) and (AdjDate.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(Appraisal.Regression.Components.AdjDate.Average);
        end;

      i := rowAdjSite - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjSite.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := Appraisal.Regression.Components.AdjSite.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjSite.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjSite.Sign;
      if (AdjSite.Used = 1) and (AdjSite.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(Appraisal.Regression.Components.AdjSite.Average);
        end;

      i := rowAdjAge - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjAge.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := Appraisal.Regression.Components.AdjAge.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjAge.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjAge.Sign;
      if (AdjAge.Used = 1) and (AdjAge.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(Appraisal.Regression.Components.AdjAge.Average);
        end;

      i := rowAdjGLA - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjGLA.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := Appraisal.Regression.Components.AdjGLA.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjGLA.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjGLA.Sign;
      if (AdjGLA.Used = 1) and (AdjGLA.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(Appraisal.Regression.Components.AdjGLA.Average);
        end;

      i := rowAdjBhRooms - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjBaths.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjBaths.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjBaths.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjBaths.Sign;
      if (AdjBaths.Used = 1) and (AdjBaths.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjBaths.Average);
        end;

      i := rowAdjGarages - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjGarage.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjGarage.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjGarage.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjGarage.Sign;
      if (AdjGarage.Used = 1) and (AdjGarage.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjGarage.Average);
        end;

      i := rowAdjBsmtGLA - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjBSArea.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjBSArea.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjBSArea.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjBSArea.Sign;
      if (AdjBSArea.Used = 1) and (AdjBSArea.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjBSArea.Average);
        end;

      i := rowAdjBsmtFLA - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjBsFin.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjBsFin.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjBsFin.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjBsFin.Sign;
      if (AdjBsFin.Used = 1) and (AdjBsFin.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjBsFin.Average);
        end;

      i := rowAdjFireplaces - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjFireplace.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjFireplace.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjFireplace.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjFireplace.Sign;
      if (AdjFireplace.Used = 1) and (AdjFireplace.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjFireplace.Average);
        end;

      i := rowAdjPools - 1;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLow     := AdjPool.Low;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngLikey   := AdjPool.Average;
      Appraisal.AdjusterMgr.Adjuster[i].RgsRngHi      := AdjPool.High;
      Appraisal.AdjusterMgr.Adjuster[i].RgsPScore     := AdjPool.Sign;
      if (AdjPool.Used = 1) and (AdjPool.Average <> '') then
        begin
//          Appraisal.AdjusterMgr.Adjuster[i].Active    := True;
//          Appraisal.AdjusterMgr.Adjuster[i].UseRegression := True;
//          Appraisal.AdjusterMgr.Adjuster[i].Factor    := GetRoundedValue(AdjPool.Average);
        end;
    end;
*)
end;

procedure TRegression.SetIndicatedValue(const Value: Double);
begin
  FIndicatedValue := Value;

  lblIndicatedVaue.caption := FormatValue2(value, bRnd1, True);
end;

procedure TRegression.Chart1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sp,pp: real;
begin
  if (Button=mbRight) then exit;

  CleanRectangle;

  chmousedown := True;

  sp := chart1.Series[0].XScreenToValue(x);
  pp := chart1.Series[0].YScreenToValue(y);
  chrect.Top := y;
  chrect.Bottom := y;
  chrect.left := x;
  chrect.Right := x;
  stx := x;
  ex := x;
  sty := y;
  ey := y;
  minvx := sp;
  minvy := pp;
end;

procedure TRegression.Chart1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i,x0,y0,x1,y1: integer;
  vr: TRect;
begin

if chmousedown then
  begin
    chart1.Canvas.Pen.Mode := pmNotXOR;
    chart1.canvas.pen.width := 1;
    chart1.canvas.pen.style := psDash;
    chart1.canvas.pen.color := clBlue;
    chart1.canvas.Brush.style := bsClear;
    ex := x;
    ey := y;
    vr := Rect(stx,sty,ex,ey);
    Chart1.Canvas.Rectangle(chRect.Left,chRect.Top,chRect.Right,chRect.Bottom);
    chrect := normalizerect(vr);
    Chart1.Canvas.Rectangle(chRect.Left,chRect.Top,chRect.Right,chRect.Bottom);
  end;
end;

procedure TRegression.Chart1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sp, pp: real;
  realpt: TPoint;
  posx, posy: integer;
begin
  if (Button=mbRight) and (UndoSelection1.enabled = true) then
    begin
      GetCursorPos(realpt);
      posx := realpt.x;
      posy := realpt.y;
      popupmenu2.Popup(posx,posy);
      exit;
    end;

  if chmousedown then
    begin
      chmousedown := false;
      GetCursorPos(realpt);
      posx := realpt.x;
      posy := realpt.y;
      sp := chart1.Series[0].XScreenToValue(x);
      pp := chart1.Series[0].YScreenToValue(y);
      maxvx := sp;
      maxvy := pp;
      popupmenu1.Popup(posx,posy);
    end;
    
  CleanRectangle;
end;

procedure TRegression.sBtnZoomInClick(Sender: TObject);
begin
  Chart1.Zoomed := True;
  Chart1.ZoomPercent(115);
end;

procedure TRegression.sBtnZoomOutClick(Sender: TObject);
begin
  Chart1.Zoomed := True;
  Chart1.ZoomPercent(85);
end;

procedure TRegression.CleanRectangle;
begin
  chmousedown := False;
  chart1.Canvas.Pen.Mode := pmNotXOR;
  chart1.canvas.pen.width := 1;
  chart1.canvas.pen.style := psDash;
  chart1.canvas.pen.color := clBlue;
  chart1.canvas.Brush.style := bsClear;
  chart1.canvas.Rectangle(chRect.Left,chRect.Top,chRect.Right,chRect.Bottom);
  Chart1.Refresh;
end;

procedure TRegression.ExcludeSalesWithinRectangle1Click(Sender: TObject);
var
  f : integer;
  lx,ly,hx,hy: real;
  salepr,saleest: real;
begin
  UndoSelection1.enabled := true;
  if minvx > maxvx then
    begin
      lx := maxvx;
      hx := minvx;
    end
  else
    begin
      lx := minvx;
      hx := maxvx;
    end;
  if minvy > maxvy then
    begin
      ly := maxvy;
      hy := minvy;
    end
  else
    begin
      ly := minvy;
      hy := maxvy;
    end;

  Seq := Seq + 1;
  Setlength(UndoSeq,Seq);
  UndoSeq[Seq-1]:= TUndoRegress.Create;
  UndoSeq[Seq-1].AddressRow :=  TStringList.Create;

  for f := 1 to SalesDataGrid.Rows do
    begin
      if SalesDataGrid.Cell[fInRegess,f] = 1 then             //comp selected
        begin
          //values in SalesDataGrid are already numbers
          salePr := SalesDataGrid.Cell[fSalesPrice,f];  //strtofloattry(SalesDataGrid.Cell[fSalesPrice,f]);
          saleEst := SalesDataGrid.Cell[fPredValue,f];  //strtofloattry();
          if (salePr >= lx) and (salepr <= hx) and (saleEst >= ly) and (saleEst <= hy) then
             begin
               SalesDataGrid.Cell[fInRegess,f] := 0;
               UndoSeq[Seq-1].AddressRow.Add(Inttostr(f));
             end;
        end;
    end;
  RunRegression;
  DrawBellCurveChart;
end;

procedure TRegression.Cancel1Click(Sender: TObject);
begin
  CleanRectangle;
end;

//YOU NEED TO PUT COMMENTS IN HERE - ITS VERY CONFUSING!
procedure TRegression.UndoSelection1Click(Sender: TObject);
var
 f,x: integer;
 SeqSeach : String;
 UndoNum : Integer;
begin
  UndoNum := Seq-1;
  for f := UndoNum downto 0 do
    begin
      if Assigned(UndoSeq[f]) then
        begin
          for x := 0 to UndoSeq[f].AddressRow.Count - 1 do
            begin
              seqSeach := UndoSeq[f].AddressRow[x];
              if SalesDataGrid.cell[fInRegess, StrToInt(seqSeach)] = 0 then
                begin
                  SalesDataGrid.cell[fInRegess, StrToInt(seqSeach)]:= 1;
                end;
            end;
          if Assigned(UndoSeq[f]) then
            FreeandNil(UndoSeq[f]);
          Seq := Seq-1;
          break;
       end;
    end;

  RunRegression;
  DrawBellCurveChart;

  if Seq = 0 then
    UndoSelection1.enabled := false;
end;

procedure TRegression.WriteDebugComparables;
var
  fPath: String;
begin
//  fPath := Appraisal.Control.TutorialFolderPath + 'RegressionComps_TestData.data';
  if FileExists(fPath) then
    DeleteFile(fPath);
//  Appraisal.Comps.WriteToFile(fPath);
end;

procedure TRegression.AdjustDPISettings;
begin
end;

//Not Used in Redstone
procedure TRegression.TransferRegressionDataToWorksheet;
var
  thisForm: TDocForm;
  rangeStr: String;
  i,n,iCount,displayedCount,r: Integer;
  PercentDiff: Double;
begin
end;

//////////////   Bell Chart codes

procedure TRegression.DrawBellCurveChart;
var
  ChartMaker: TBellCurveChart;
  AccRatio: Double;
  n, rCount: Integer;
  countIt: Boolean;
begin
  rCount := SalesDataGrid.rows;
  ChartMaker := TBellCurveChart.Create(rCount);
  try
    try
      ChartMaker.AllowZero := True;
      ChartMaker.ShowBarTitle := True;
      ChartMaker.BarCount := 40;

      for n := 1 to rCount do
        if SalesDataGrid.Cell[fInRegess, n] = 1 then
          begin
            AccRatio := SalesDataGrid.Cell[fPredAcc, n];

            if (AccRatio > 100) then
              AccRatio := 200 - AccRatio
            else
              AccRatio := -AccRatio;

            AccRatio := AccRatio / 100;
            ChartMaker.Add(AccRatio);
          end;

      ChartMaker.DoCalcs;
//      ChartMaker.SetChartSeries(Series4, clBlue);
    except
      ShowAlert(AtWarnAlert, 'The Accuracy histogram could not be created.');
    end;
  finally
    ChartMaker.Free;
  end;
end;

procedure TRegression.ResetSalesDataGridCheckBox(aMin, aMax: Real);
var i:integer;
    aFloat: Real;
begin
  for i := 1 to SalesDataGrid.Rows do
    begin
      aFloat := StrToFloattry(SalesDataGrid.Cell[fPredAccuOrig,i]);     //use the original predicted accuracy value, so we always have value
      if (aFloat >= aMin) and (aFloat <= aMax) then
          SalesDataGrid.Cell[fInRegess,i] := 1 //have include Y/N checked if it's in range.
      else
          SalesDataGrid.Cell[fInRegess,i] := 0
    end;
end;

procedure TRegression.chartBellCurveGetAxisLabel(Sender: TChartAxis;
  Series: TChartSeries; ValueIndex: Integer; var LabelText: String);
var
  aLabelValue:Double;
begin
  //Fix the label to make the right hand side of X axis same as the left hand side
(*
  if Sender = chartBellCurve.BottomAxis then
    begin
      aLabelValue := StrToFloatTry(LabelText);
      aLabelValue := ((aLabelValue/10)/2);
      if (aLabelValue >= 1) and (aLabelValue <= 2) then
        begin
         //ignore the one that's less than the middle point
          aLabelValue := 2 - aLabelValue;
          LabelText := Format('%f',[aLabelValue]);
        end
      else if aLabelValue > 0 then  //make the left hand side of the middle point show ()
        begin
          LabelText := Format('-%f',[aLabelValue]);
        end;
    end;
*)
end;

procedure TRegression.DoExportSalesGridData;
var expPath,ExportFileName,FileNo, Msg: String;
begin
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  FileNo  := FDoc.GetCellTextByID(2);
  expPath := IncludeTrailingPathDelimiter(appPref_DirExports);
  SaveDialog.InitialDir := expPath;
  SaveDialog.DefaultExt := 'csv';
  if FileNo = '' then  //do not include file # if empty
    ExportFileName := Format('%sFileNo_Regression.csv',[expPath])
  else
    ExportFileName := Format('%sFileNo_%s_Regression.csv',[expPath,FileNo]);
  SaveDialog.FileName := ExportFileName;
  if SaveDialog.Execute then
    begin
      ExportFileName := SaveDialog.FileName;
      SalesDataGrid.ExportCSV(ExportFilename);
      if FileExists(ExportFileName) then
      begin
         Msg := Format('Sales Data export successfully to File: %s%s.',[#13#10,ExportFileName]);
         ShowNotice(Msg);
      end
      else
        ShowNotice('There was a problem in exporting sales data.');
    end;
end;

procedure TRegression.btnExportClick(Sender: TObject);
begin
  DoExportSalesGridData;
end;

procedure TRegression.tsGridModelComboDropDown(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
var f:Integer;
begin
  //For sample size we need to load the drop down values differently
  if DataRow = cSampleSize then
    begin
      combo.rows := high(SampleLevels) + 1;
      for f := 0 to high(SampleLevels) do
        combo.cell[1, f+1] := SampleLevels[f]
    end
  else
    begin
      combo.rows := high(ConfLevels) + 1;
      for f := 0 to high(ConfLevels) do
        combo.cell[1, f+1] := ConfLevels[f];
    end;
end;

procedure TRegression.RemoveNonAccurateOutlier(PcntAccuracy: Integer);
var
  i, iCount, curExcludedCount, newExcludedCount: Integer;
  Acc: Double;
begin
  iCount := SalesDataGrid.Rows;

  curExcludedCount := 0;
  for i := 1 to iCount do
    if (SalesDataGrid.Cell[fInRegess, i] <> 1) then
      curExcludedCount := curExcludedCount + 1;

  newExcludedCount := 0;
  for i := 1 to iCount do
    if (SalesDataGrid.Cell[fInRegess, i] = 1) then
      begin
        Acc := Abs(StrToFloat(SalesDataGrid.Cell[fPredAcc, i]) - 100);
        if Acc > PcntAccuracy then
          if iCount - curExcludedCount - newExcludedCount > 12 then
            begin
              SalesDataGrid.Cell[fInRegess, i] := 0;
              newExcludedCount := newExcludedCount + 1;
            end;
      end;
end;

procedure TRegression.RemoveNonSimilarOutlier(PcntSimilar: Integer);
begin
end;

procedure TRegression.RemoveOverUnderPricedOutlier(PcntRange: Integer);
begin
end;

procedure TRegression.LoadToolData;
begin
  LoadSettingsFromIni;
  LoadRegressionDataSource;
  btnSelectAll.Click;
  RunRegressionProcess;
  HighlightClickedRows;

  tabSalesGrid.TabVisible := False;
  //FDataModified := True;
  //    FDataLoaded := True;
end;

procedure TRegression.SaveToolData;
begin
  SaveSettingsToIni;
(*
  try
    if FDataModified then
      begin
        FDataStatus.DataModified := FDataModified;
        SaveSettingsToIni;
        SaveRegression;
        UpdateAdjustmentValues;
        Appraisal.Control.AdjustmentsShown := False;

        Appraisal.Control.NeedSaleRegresUpdate := False;       //signal Control Mgr regression done.
        Appraisal.Recon.ValBySalesRegression := Appraisal.Regression.IndicatedValue;

//NOTE - LETS DISCUSS
//Need to comment these 2 lines out, the report listener is listening to FDataStatus.DataModified and FDataStatus.DataLoaded.
// the FDataStatus.DataModified is set to True each time we make a change, so we don't want to set this flag here.
//        FDataStatus.DataModified := FDataModified;
//        FDataModified := False;
     end;
  except
//   ShowAlert(atWarnAlert, 'There was a problem saving the regression Components of Value to the Adjustment Manager.');
  end;
*)
end;

function TRegression.GetUnits(aName:String):String;
begin
  result := '';
  aName := UpperCase(aName);
  if POS('GROSS', aName) > 0 then
    result :='$/sqft'
  else if POS('BATH', aName) > 0 then
    result := '$/rooms'
  else if POS('SITE', aName) > 0 then
    result := '$/sqft'
  else if POS('GARAGE', aName) > 0 then
    result := '$/cars'
  else if POS('DATE', aName) > 0 then
    result := '$/days'
  else if POS('POOL', aName) > 0 then
    result := '$/pool'
  else if POS('YEAR', aName) > 0 then
    result := '$/years'
  else if POS('BASEMENT', aName) > 0 then
    result := '$/sqft'
  else if POS('FIRE', aName) > 0 then
    result := '$/FirePl';
end;


procedure TRegression.LeaveToolQuery(var CanLeave: Boolean);
begin
//if regression has changed or never been saved then
  SaveToolData;
end;

procedure TRegression.SwitchToolQuery(nextToolIndex: Integer; var CanSwitch: Boolean);
begin
//if regression has changed or never been saved then
  SaveToolData;
end;

//These two rountines are used to correctly highlght rows after user sorting
procedure TRegression.SalesDataGridSorting(Sender: TObject;
  DataCol: Integer; var Cancel: Boolean);
begin
  FGridSorted := True;
  case DataCol of
    fAddress: SalesDataGrid.OnSortCompare := GridSortCompare;   //attach the special compare
  end;
end;
procedure TRegression.GridSortCompare(Sender: TObject; String1,
  String2: String; var compareResult: Integer);
var
  street1, street2: String;
begin
  street1 := GetStreetNameOnly(String1);
  street2 := GetStreetNameOnly(String2);
  compareResult := CompareText(street1, street2);

  if compareResult > 0 then
    compareResult := 1
  else if compareResult < 0 then
    compareResult := -1;
  //if compareResult = 0 then do not change
end;

procedure TRegression.SalesDataGridRowChanged(Sender: TObject;
  OldRow, NewRow: Integer);
begin
  if FGridSorted then
    begin
      HighlightClickedRows;
      FGridSorted := False;
    end;
end;

//github #211
procedure TRegression.LoadSettingsFromIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
(*
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
  With PrefFile do
    begin
    end;
  finally
    PrefFile.Free;
  end;
*)
end;

procedure TRegression.SaveSettingsToIni;
var
  PrefFile: TMemIniFile;
  IniFilePath : String;
begin
(*
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);                   //create the INI writer
  try
  finally
    FreeandNil(PrefFile);
  end;
*)
end;


procedure TRegression.btnGridClick(Sender: TObject);
begin
  if pos('Show', btnGrid.Caption) > 0 then
    ShowHideGrid(True)
  else
    ShowHideGrid(False);
end;

procedure TRegression.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
     0: btnRegression.Click;
  end;
end;

procedure TRegression.SalesDataGridExit(Sender: TObject);
begin
  if FDataModified then
    begin
      btnRegression.Enabled := True;
      btnRegression.Click;
    end;
    
end;

end.


(*
 How to export out the regression gris

  SalesDataGrid.ExportCSV(Appraisal.Control.TutorialFolderPath + 'RegressionSales.csv');

*)
