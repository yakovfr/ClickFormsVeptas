unit UCompFilter;
{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{ This unit is the dialog called from Market Data }
{ Allow user to filter by proximity, sales date, GLA, Bsmt, Beds, stories in +/- %}


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMarketData, StdCtrls, Mask, RzEdit, RzSpnEdt, RzBckgnd, math,
  ExtCtrls, uSubject,osSortLib,Grids_ts, TSGrid, osAdvDbGrid, uForms, uGlobals,
  uRegression, uAdjustments;

type
  TCompFilter = class(TAdvancedForm)
    PanelTitleFilters: TPanel;
    lblFeatureName: TLabel;
    lblMin: TLabel;
    lblMax: TLabel;
    lblSubject: TLabel;
    RzSeparator_1: TRzSeparator;
    Label5: TLabel;
    PanelProx: TPanel;
    stxProx: TLabel;
    RzSeparator_7: TRzSeparator;
    lblMileRad: TLabel;
    PanelSaleDate: TPanel;
    lblSDate: TLabel;
    lblDays: TLabel;
    RzSeparator_12: TRzSeparator;
    PanelGLA: TPanel;
    lblGLA: TLabel;
    lblGLASqft: TLabel;
    RzSeparator_17: TRzSeparator;
    edtMinGLA: TEdit;
    edtMaxGLA: TEdit;
    PanelBGLA: TPanel;
    lblBSMT: TLabel;
    lblBsmtSqft: TLabel;
    RzSeparator_22: TRzSeparator;
    edtMinBGLA: TEdit;
    edtSubBGLA: TEdit;
    edtMaxBGLA: TEdit;
    PanelSite: TPanel;
    lblSite: TLabel;
    lblSiteSqft: TLabel;
    RzSeparator_27: TRzSeparator;
    edtMinSite: TEdit;
    edtSubSite: TEdit;
    edtMaxSite: TEdit;
    PanelAge: TPanel;
    lblAge: TLabel;
    lblAgeYrs: TLabel;
    RzSeparator_32: TRzSeparator;
    edtMinAge: TEdit;
    edtSubAge: TEdit;
    edtMaxAge: TEdit;
    PanelStories: TPanel;
    lblStory: TLabel;
    lblStoryP: TLabel;
    RzSeparator3: TRzSeparator;
    edtSubStories: TEdit;
    edtMinStory: TEdit;
    edtMaxStory: TEdit;
    PanelBeds: TPanel;
    lblBeds: TLabel;
    lblBedsRm: TLabel;
    RzSeparator_37: TRzSeparator;
    edtMinBeds: TEdit;
    edtSubBed: TEdit;
    edtMaxBeds: TEdit;
    PanelFirepl: TPanel;
    lblFire: TLabel;
    lblFireP: TLabel;
    RzSeparator_47: TRzSeparator;
    edtMinFirePl: TEdit;
    edtSubFirePl: TEdit;
    edtMaxFirePl: TEdit;
    PanelCars: TPanel;
    lblGarage: TLabel;
    lblGarageCar: TLabel;
    RzSeparator_52: TRzSeparator;
    edtMinCars: TEdit;
    edtSubCar: TEdit;
    edtMaxCars: TEdit;
    PanelPool: TPanel;
    lblPool: TLabel;
    lblPoolP: TLabel;
    RzSeparator_57: TRzSeparator;
    edtSubPool: TEdit;
    edtMinPool: TEdit;
    edtMaxPool: TEdit;
    chkUseProx: TCheckBox;
    chkUseSaledate: TCheckBox;
    chkUseGLA: TCheckBox;
    chkUseBsmt: TCheckBox;
    chkUseSiteArea: TCheckBox;
    chkUseAge: TCheckBox;
    chkUseStories: TCheckBox;
    chkUseBed: TCheckBox;
    ChkUseFirePl: TCheckBox;
    chkUseGarage: TCheckBox;
    chkUsePool: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    cbGLA: TComboBox;
    cbBsmt: TComboBox;
    cbSite: TComboBox;
    cbAge: TComboBox;
    cbStories: TComboBox;
    cbBedRm: TComboBox;
    cbFirePl: TComboBox;
    cbGarage: TComboBox;
    cbPool: TComboBox;
    cbProx: TComboBox;
    cbSaleDate: TComboBox;
    edtSubGLA: TEdit;
    bottomPanel: TPanel;
    btnUseDefaultFilters: TButton;
    btnApplyFilters: TButton;
    lblSales: TLabel;
    lblListings: TLabel;
    lblTotalSalesCount: TLabel;
    lblTotalListCount: TLabel;
    lblSalesExc: TLabel;
    lblListExc: TLabel;
    lblExcludedSalesCount: TLabel;
    lblExcludedListCount: TLabel;
    lblSalesleft: TLabel;
    lblListLeft: TLabel;
    lblFinalSalesCount: TLabel;
    lblFinalListCount: TLabel;
    btnReset: TButton;
    edtMaxProx: TEdit;
    Label1: TLabel;
    edtEffectiveDate: TEdit;
    edtMaxSaleDate: TEdit;
    Label2: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label21: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure RateChange(Sender: TObject);
    procedure btnApplyFiltersClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnUseDefaultFiltersClick(Sender: TObject);
    procedure UseFilterEvent(Sender: TObject);
    procedure OnEnterTextEvent(Sender: TObject);
    procedure OnComboSelect(Sender: TObject);

  private
    { Private declarations }
    FMinDist, FMaxDist: Double;
    FMinSaleMonths, FMaxSaleMonths: Integer;

    FMinGLA, FMaxGLA: Integer;
    FMinBGLA, FMaxBGLA: Integer;
    FMinSite, FMaxSite: Integer;
    FMinAge, FMaxAge: Integer;
    FMinStory, FMaxStory: Integer;
    FMinBedRms, FMaxBedRms: Integer;
    FMinFirePl, FMaxFirePl: Integer;
    FMinCars, FMaxCars: Integer;
    FMinPool, FMaxPool: Integer;


    FSubjProx, FSubjSaleDate, FSubjGLA,FSubjBGLA, FSubjSite, FSubjAge, FSubjStory:Integer;
    FSubjBeds, FSubjFirePl, FSubjGarage, FSubjPool: Integer;

    FDistLo, FDistHi: Double;
    FSaleDateLo, FSaleDateHi: Integer;
    FGLALo, FGLAHi: Integer;
    FBGLALo, FBGLAHi: Integer;
    FSiteLo, FSiteHi: Integer;
    FAgeLo, FAgeHi: Integer;
    FStoriesLo, FStoriesHi: Integer;
    FBedsLo, FBedsHi: Integer;
    FFirePlLo, FFirePlHi: Integer;
    FGarageLo, FGarageHi: Integer;
    FPoolLo, FPoolHi: Integer;

    FWtDist,FWtSDate: Integer;
    FWtGLA,FWtBGLA,FWtSite,FWtAge,FWtBeds,FWtBaths,FWtFirePl,FWtCars,FWtPool,FWtStory:Integer;

    FDataModified: Boolean;
    FOriginalText: String;
    procedure CalcRanges;
    procedure LoadSubjectData;
    procedure LoadMinMaxData;
    procedure CalcRanking;
    function ApplyFilters:Boolean;
    function FilterComps:Boolean;
    function IsInFilterRangeLargeNum(op:String; SubjValue: Integer; AValue, MinValue, MaxValue: Double): Boolean;
    function IsInFilterRangeSmallNum(op:String; SubjValue: Integer; AValue, MinValue, MaxValue: Double): Boolean;
    procedure DisplaySummaryCounts;
    procedure WritePref;
    procedure LoadPref;
    procedure ClearFilters;
    procedure CopyGridData;

  public
    { Public declarations }
//    FMarketData: TMarketData;
    FSubject: TSubject;
    FRegression: TRegression;
    FAdjustments: TAdjustments;
    FFilterApplied: Boolean;
    FMarketGrid: TosAdvDBGrid;
    FAnalysis: TComponent;
    FMarketFeature: TComponent;
    FBuildReport: TComponent;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadToolData;
    procedure InitTool;
  end;

var
  CompFilter: TCompFilter;

implementation
uses
  UCC_MLS_Globals, uUtil1,DateUtils,TSCommon, iniFiles, uStatus, uMarketFeature,
  uServiceAnalysis, uBuildReport;

const
  //use tag # to drive the logic
  cProximity = 1;
  cSaleDate  = 2;
  cGLA       = 3;
  cBsmt      = 4;
  cSiteArea  = 5;
  cAge       = 6;
  cStories   = 7;
  cBeds      = 8;
  cFirePl    = 9;
  cCars      = 10;
  cPool      = 11;

  colorLiteBlue = clGradientInactiveCaption;

  Default_Row_Height = 18;

{$R *.dfm}

constructor TCompFilter.Create(AOwner: TComponent);
begin
  inherited;
  FFilterApplied := False;
end;

destructor TCompFilter.Destroy;
begin
  inherited;
end;


procedure TCompFilter.btnCloseClick(Sender: TObject);
begin
  if FRegression <> nil then
   TRegression(FRegression).LoadToolData;
  if assigned(FAdjustments) then
   begin
     TAdjustments(FAdjustments).FImportMLS := True;
     TAdjustments(FAdjustments).InitialAdjustments(True);
   end;

  if btnUseDefaultFilters.Enabled then
    begin
      if Ok2Continue('Would you like to save as default filter settings?') then
        btnUseDefaultFilters.Click;
    end;
  ClearFilters;
  Close;
end;



procedure TCompFilter.InitTool;
begin
  FDataModified := False;
  self.Height := BottomPanel.Top + BottomPanel.Height + 40;
  FMaxDist := 0; FWtDist  := 0; FDistHi := 0;
  FMinSaleMonths := 0; FMaxSaleMonths := 0; FWtSDate := 0; FSaleDateLo := 0; FSaleDateHi := 0;

  FMinGLA := 0;  FMaxGLA  := 0; FWtGLA  := 0; FGLALo  := 0; FGLAHi  := 0;
  FMinBGLA := 0; FMaxBGLA := 0; FWtBGLA := 0; FBGLALo := 0; FBGLAHi := 0;
  FMinSite := 0; FMaxSite := 0; FWtSite := 0; FSiteLo := 0; FSiteHi := 0;
  FMinAge  := 0; FMaxAge  := 0; FWtAge  := 0; FAgeLo  := 0; FAgeHi  := 0;
  FMinStory  := 0; FMaxStory := 0; FWtStory := 0; FStoriesLo  := 0; FStoriesHi  := 0;
  FMinBedRms := 0; FMaxBedRms := 0; FWtBeds := 0; FBedsLo := 0; FBedsHi := 0;
  FMinFirePl := 0; FMaxFirePl := 0; FWtFirePl := 0; FFirePlLo := 0; FFirePlHi := 0;
  FMinCars := 0; FMaxCars := 0; FWtCars := 0; FGarageLo := 0; FGarageHi := 0;
  FMinPool := 0; FMaxPool := 0; FWtPool := 0; FPoolLo := 0; FPoolHi := 0;
  btnApplyFilters.Enabled := chkUseProx.Checked or chkUseSaleDate.Checked or
  chkUseGLA.Checked or chkUseBsmt.Checked or chkUseStories.Checked or
  chkUseBed.Checked or chkUseFirePl.Checked or chkUseGarage.Checked or chkUsePool.Checked;
  btnReset.Enabled := btnApplyFilters.Enabled;
  btnUseDefaultFilters.Enabled := False;
  FMarketFeature := TAnalysis(FAnalysis).MarketFeature;
end;


procedure TCompFilter.LoadPref;
var
  PrefFile: TMemIniFile;
  IniFilePath: String;
  i, NumTools: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);  //create the INI writer
  cbProx.Text := ''; cbSaleDate.Text := ''; cbGLA.Text := '';
  cbBsmt.Text := ''; cbSite.Text := ''; cbAge.Text := '';
  cbStories.Text := ''; cbBedRm.Text := ''; cbFirePl.Text := ''; cbGarage.Text := '';
  cbPool.Text := '';
  chkUseProx.Checked := False; chkUseSaleDate.Checked := False;
  chkUseGLA.Checked  := False; chkUseBsmt.Checked     := False;
  chkUseSiteArea.Checked := False; chkUseAge.Checked  := False;
  chkUseStories.Checked  := False; chkUseFirePl.Checked := False;
  ChkUseGarage.Checked   := False; chkUsePool.Checked   := False;
  Try
    with PrefFile do
    begin
      //Proximity
      chkUseProx.Checked := ReadBool('MLS', 'UseProx', True);
      cbProx.Text        := ReadString('MLS', 'Proximity', '1.0');
      if chkUseProx.Checked and (cbProx.Text <> '') then
        RateChange(cbProx);
      //Sales Date
      chkUseSaleDate.Checked := ReadBool('MLS', 'UseSalesDate', True);
      cbSaleDate.Text        := ReadString('MLS', 'SalesDate', '6');
      if chkUseSaleDate.Checked and (cbSaleDate.Text <> '') then
        RateChange(cbSaleDate);
      //GLA
      chkUseGLA.Checked := ReadBool('MLS', 'UseGLA', False);
      cbGLA.Text        := ReadString('MLS', 'GLA', '');
      if chkUseGLA.Checked and (cbGLA.Text <> '') then
        RateChange(cbGLA);
      //BGLA
      chkUseBsmt.Checked := ReadBool('MLS', 'UseBsmt', False);
      cbBsmt.Text        := ReadString('MLS', 'BGLA', '');
      if chkUseBsmt.Checked and (cbBsmt.Text <> '') then
        RateChange(cbBsmt);
      //Site Area
      chkUseSiteArea.Checked := ReadBool('MLS', 'UseSiteArea', False);
      cbSite.Text        := ReadString('MLS', 'SiteArea', '');
      if chkUseSiteArea.Checked and (cbSite.Text <> '') then
        RateChange(cbSite);
      //Actual Age
      chkUseAge.Checked := ReadBool('MLS', 'UseAge', False);
      cbAge.Text        := ReadString('MLS', 'Age', '');
      if chkUseAge.Checked and (cbAge.Text <> '') then
        RateChange(cbAge);
      //Stories
      chkUseStories.Checked := ReadBool('MLS', 'UseStories', False);
      cbStories.Text        := ReadString('MLS', 'Stories', '');
      if chkUseStories.Checked and (cbStories.Text <> '') then
        RateChange(cbStories);
      //Beds
      chkUseBed.Checked := ReadBool('MLS', 'UseBed', False);
      cbBedRm.Text        := ReadString('MLS', 'Beds', '');
      if chkUseBed.Checked and (cbBedRm.Text <> '') then
        RateChange(cbBedRm);
      //Fire Place
      chkUseFirePl.Checked := ReadBool('MLS', 'UseFirePl', False);
      cbFirePl.Text        := ReadString('MLS', 'FirePl', '');
      if chkUseFirePl.Checked and (cbFirePl.Text <> '') then
        RateChange(cbFirePl);
      //Cars
      chkUseGarage.Checked := ReadBool('MLS', 'UseGarage', False);
      cbGarage.Text        := ReadString('MLS', 'Garage', '');
      if chkUseGarage.Checked and (cbGarage.Text <> '') then
        RateChange(cbGarage);
      //Pool
      chkUsePool.Checked := ReadBool('MLS', 'UsePool', False);
      cbPool.Text        := ReadString('MLS', 'Pool', '');
      if chkUsePool.Checked and (cbPool.Text <> '') then
        RateChange(cbPool);
    end;
  finally
    PrefFile.Free;
  end;
end;



function GetStringValue(aStr:String; useZero:Boolean=True):String;
begin
  result := aStr;
  if aStr <> '' then
    result := Format('%d',[GetValidInteger(aStr)]);
  if not useZero and (GetValidInteger(aStr) =0) then
    result := '1';  //this is for stories;
end;

procedure TCompFilter.LoadSubjectData;
begin
  with FSubject do
    begin
      edtSubGLA.Text   := SubjectGrid.Cell[cSubject, _fGLA];
      edtSubBGLA.Text  := GetStringValue(SubjectGrid.Cell[cSubject, _fBasmtGLA]);
      edtSubSite.Text  := GetStringValue(SubjectGrid.Cell[cSubject, _fSiteArea]);
      edtSubAge.Text   := SubjectGrid.Cell[cSubject, _fActualAge];
      edtSubStories.Text := GetStringValue(SubjectGrid.Cell[cSubject, _fStories],False);
      edtSubBed.Text   := SubjectGrid.Cell[cSubject, _fBedRoom];
      edtSubFirePl.Text:= GetStringValue(SubjectGrid.Cell[cSubject, _fFireplace]);
      edtSubCar.Text   := GetStringValue(SubjectGrid.Cell[cSubject, _fGarage]);
      edtSubPool.Text  := GetStringValue(SubjectGrid.Cell[cSubject, _fPool]);
    end;
    edtEffectiveDate.Text := FSubject.EffectiveDate;
end;

//look for both grid to find min/max
procedure TCompFilter.CalcRanges;
const
  AMin = -1;
  AMax = 99999999;
var
  i, iCount: Integer;
  aDist: Double;
  aBedRm,aBath,aCar,aGLA,aSite,aFirePl,aBsmt,aAge,aPool,aStory: Integer;
  FSaleMonths: Integer;
  effDate, theSaleDate, theListDate: TDateTime;
begin
  effDate := StrToDateDef(FSubject.EffectiveDate, Date);

  //Set the min - max
  FMinDist      := AMax;
  FMaxDist      := -1;
  FMinSaleMonths:= AMax;
  FMaxSaleMonths:= -1;

  FMinGLA       := AMax;
  FMaxGLA       := -1;
  FMinBGLA      := AMax;
  FMAXBGLA      := -1;
  FMinSite      := AMax;
  FMaxSite      := -1;
  FMinAge       := AMax;
  FMaxAge       := -1;
  FMinStory     := AMax;
  FMaxStory     := -1;
  FMinBedRms    := AMax;
  FMaxBedRms    := -1;
  FMinFirePl    := AMax;
  FMAXFirePl    := -1;
  FMinCars      := AMax;
  FMaxcars      := -1;
  FMinPool      := AMax;
  FMaxPool      := -1;

  iCount := FMarketGrid.Rows;
  for i := 1 to iCount do
    begin
     //distance
      aDist := GetFirstValue(FMarketGrid.Cell[_Proximity,i]);
      If aDist > 0 then
        begin
          if aDist > FMaxDist then
            FMaxDist := aDist;
          if aDist <= FMinDist then
            FMinDist := aDist;
        end;

      //sale date
      if uUtil1.IsValidDateTime(FMarketGrid.Cell[_SalesDate,i], theSaleDate) then
        begin
          FSaleMonths := abs(MonthsBetween(EffDate, theSaleDate));
          if FSaleMonths > FMaxSaleMonths then
            FMaxSaleMonths := FSaleMonths;
          if FSaleMonths <= FMinSaleMonths then
            FMinSaleMonths := FSaleMonths;
        end;

      //GLA
      aGLA := GetFirstIntValue(FMarketGrid.Cell[_GLA,i]);
      if aGLA > 0 then
        begin
          if aGLA > FMaxGLA then
            FMaxGLA := aGLA;
          If (aGLA > 0) and (aGLA <= FMinGLA) then
            FMinGLA := aGLA;
        end;

      //BasementGLA
      aBsmt := GetFirstIntValue(FMarketGrid.Cell[_BasementGLA,i]);
      if aBsmt > 0 then
        begin
          if aBsmt > FMAXBGLA then
            FMaxBGLA := aBsmt;
          if (aBsmt > 0) and (aBsmt <= FMinBGLA) then
            FMinBGLA := aBsmt;
        end;

      //SiteArea
      aSite := GetFirstIntValue(FMarketGrid.Cell[_SiteArea,i]);
      if aSite > 0 then
        begin
          if aSite > FMaxSite then
            FMaxSite := aSite;
          If (aSite > 0) and (aSite <= FMinSite) then
            FMinSite := aSite;
        end;

      //ActualAge
      aAge := GetFirstIntValue(FMarketGrid.Cell[_Age,i]);
      if aAge >= 0 then
        begin
          if aAge > FMaxAge then
            FMaxAge := aAge;
          if (aAge <= FMinAge) then
            FMinAge := aAge;
        end;

      //Story
      aStory := GetFirstIntValue(FMarketGrid.Cell[_Stories,i]);
      if aStory >= 0 then
        begin
          if aStory > FMaxStory then
            FMaxStory := aStory;
          if (aStory <= FMinStory) then
            FMinStory := aStory;
        end;

      //BedroomCount
      aBedRm := GetFirstIntValue(FMarketGrid.Cell[_BedRoomTotal,i]);
      if aBedRm > 0 then
        begin
          if aBedRm > FMaxBedRms then
            FMaxBedRms := aBedRm;
          If (aBedRm > 0) and (aBedRm <= FMinBedRms) then
            FMinBedRms := aBedRm;
        end;

      //GarageCarCount
      aCar := GetFirstIntValue(FMarketGrid.Cell[_GarageSpace,i]);
      if aCar >= 0 then
        begin
          if aCar > FMaxcars then
            FMaxcars := aCar;
          if (aCar <= FMinCars) then
            FMinCars := aCar;
        end;

      //Fireplaces
      aFirePl := GetFirstIntValue(FMarketGrid.Cell[_FireplaceQTY,i]);
      if aFirePl > FMaxFirePl then
        FMaxFirePl := aFirePl;
      if (aFirePl <= FMinFirePl) then
        FMinFirePl := aFirePl;

      //Pools
      aPool := GetFirstIntValue(FMarketGrid.Cell[_PoolQTY,i]);
      if aPool > FMaxPool then
        FMaxPool := aPool;
      if (aPool <= FMinPool) then
        FMinPool := aPool;
  end;

  if FMinGLA  = AMax then FMinGLA  := 0;
  if FMaxGLA  = AMin then FMaxGLA  := 0;
  if FMinBGLA = AMax then FMinBGLA := 0;
  if FMaxBGLA = AMin then FMaxBGLA := 0;
  if FMinSite = AMax then FMinSite := 0;
  if FMaxSite = AMin then FMaxSite := 0;
  if FMinAge  = AMax then FMinAge  := 0;
  if FMaxAge  = AMin then FMaxAge  := 0;
  if FMinStory  = AMax then FMinStory  := 0;
  if FMaxStory  = AMin then FMaxStory  := 0;
  if FMinBedRms  = AMax then FMinBedRms  := 0;
  if FMaxBedRms  = AMin then FMaxBedRms  := 0;
  if FMinFirePl  = AMax then FMinFirePl  := 0;
  if FMaxFirePl  = AMin then FMaxFirePl  := 0;
  if FMinCars  = AMax then FMinCars  := 0;
  if FMaxCars  = AMin then FMaxCars  := 0;
  if FMinPool  = AMax then FMinPool  := 0;
  if FMaxPool  = AMin then FMaxPool  := 0;

  if FMaxDist = AMin then FMaxDist := 0;
  if FMinSaleMonths = AMax then FMinSaleMonths := 0;
  if FMaxSaleMonths = AMin then FMaxSaleMonths := 0;
end;


procedure TCompFilter.LoadMinMaxData;
begin
  CalcRanges;
  edtMaxProx.Text := Format('%.2f',[FMaxDist]);

  edtMaxSaleDate.Text := Format('%d',[FMaxSaleMonths]);

  edtMinGLA.Text  := Format('%d',[FMinGLA]);
  edtMaxGLA.Text  := Format('%d',[FMaxGLA]);
  edtMinBGLA.Text := Format('%d',[FMinBGLA]);
  edtMaxBGLA.Text := Format('%d',[FMaxBGLA]);
  edtMinSite.Text := Format('%d',[FMinSite]);
  edtMaxSite.Text := Format('%d',[FMaxSite]);
  edtMinAge.Text  := Format('%d',[FMinAge]);
  edtMaxAge.Text  := Format('%d',[FMaxAge]);
  edtMaxProx.Text := Format('%.2f',[FMaxDist]);
  if FMinStory = 0 then
    FMinStory := 1;   //can not have 0 stories;
  edtMinStory.Text := Format('%d',[FMinStory]);
  edtMaxStory.Text := Format('%d',[FMaxStory]);
  edtMinBeds.Text := Format('%d',[FMinBedRms]);
  edtMaxBeds.Text := Format('%d',[FMaxBedRms]);
  edtMinFirePl.Text := Format('%d',[FMinFirePl]);
  edtMaxFirePl.Text := Format('%d',[FMaxFirePl]);
  edtMinCars.Text := Format('%d',[FMinCars]);
  edtMaxCars.Text := Format('%d',[FMaxCars]);
  edtMinPool.Text := Format('%d',[FMinPool]);
  edtMaxPool.Text := Format('%d',[FMaxPool]);
end;


procedure TCompFilter.LoadToolData;
begin
  LoadSubjectData;
  LoadMinMaxData;
  LoadPref;
  btnApplyFilters.Click;
  DisplaySummaryCounts;
end;

procedure TCompFilter.RateChange(Sender: TObject);
var
  aTag, aPercent, aMonth: Integer;
  aMile: Double;
  aComboBox: TComboBox;
begin
  if Sender is TComboBox then
    aComboBox := TComboBox(Sender);
    aTag := aComboBox.Tag;
  FDataModified := True;
  case aTag of
    cProximity:
      begin
        aMile := GetFirstValue(aComboBox.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) then
          begin
            FDistHi := GetStrValue(aComboBox.Text);
            FWtDist := Round(FDistHi);
          end
        else if aMile > 0 then
          begin
            FDistHi   := aMile;
            FMaxDist  := GetFirstValue(edtMaxProx.Text);
            FWtDist   := Round(FMaxDist);
          end;
        chkUseProx.Checked := aComboBox.Text <> '';
      end;

    cSaleDate:
      begin
        aMonth := GetValidInteger(aComboBox.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) then
          begin
            FSaleDateHi := GetValidInteger(aComboBox.Text);
            FWtSDate := Round(FSaleDateHi);
          end
        else if aMonth > 0 then
          begin
            //FSaleDateHi   := edtMaxS;
            FMaxSaleMonths:= GetValidInteger(edtMaxSaleDate.Text);
            FWtSDate   := Round(FMaxSaleMonths - FMinSaleMonths);
          end;
          chkUseSaleDate.Checked := aComboBox.Text <> '';
      end;

    cGLA:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjGLA := GetValidInteger(edtSubGLA.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FGLAHi := FSubjGLA;
            FGLALo := FSubjGLA;
            FWtGLA := FSubjGLA;
          end
        else if aPercent > 0 then
          begin
            FGLAHi   := Round(FSubjGLA + (aPercent/100)*FSubjGLA);
            FGLALo   := Round(FSubjGLA - (aPercent/100)*FSubjGLA);
            FMaxGLA  := Round(FMaxGLA + (aPercent/100) * FMaxGLA);
            FMinGLA  := Round(FMinGLA - (aPercent/100) * FMinGLA);
            FWtGLA   := Round(FMaxGLA - FMinGLA);
          end;
        chkUseGLA.Checked := aComboBox.Text <> '';
      end;
    cBsmt:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjBGLA := GetValidInteger(edtSubBGLA.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FBGLAHi := FSubjBGLA;
            FBGLALo := FSubjBGLA;
            FWtBGLA := FSubjBGLA;
          end
        else if aPercent > 0 then
          begin
            FBGLAHi   := Round(FSubjBGLA + (aPercent/100)*FSubjBGLA);
            FBGLALo   := Round(FSubjBGLA - (aPercent/100)*FSubjBGLA);
            FMaxBGLA  := Round(FMaxBGLA + (aPercent/100) * FMaxBGLA);
            FMinBGLA  := Round(FMinBGLA - (aPercent/100) * FMinBGLA);
            FWtBGLA   := Round(FMaxBGLA - FMinBGLA);
          end;
        chkUseBsmt.Checked := aComboBox.Text <> '';
      end;
    cSiteArea:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjSite := GetValidInteger(edtSubSite.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FSiteHi := FSubjSite;
            FSiteLo := FSubjSite;
            FWtSite := FSubjSite;
          end
        else if aPercent > 0 then
          begin
            FSiteHi   := Round(FSubjSite + (aPercent/100)*FSubjSite);
            FSiteLo   := Round(FSubjSite - (aPercent/100)*FSubjSite);
            FMaxSite  := Round(FMaxSite + (aPercent/100) * FMaxSite);
            FMinSite  := Round(FMinSite - (aPercent/100) * FMinSite);
            FWtSite   := Round(FMaxSite - FMinSite);
          end;
        chkUseSiteArea.Checked := aComboBox.Text <> '';
      end;
    cAge:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjAge := GetValidInteger(edtSubAge.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FAgeHi := FSubjAge;
            FAgeLo := FSubjAge;
            FWtAge := FSubjAge;
          end
        else if aPercent > 0 then
          begin
            FAgeHi   := Round(FSubjAge + (aPercent/100)*FSubjAge);
            FAgeLo   := Round(FSubjAge - (aPercent/100)*FSubjAge);
            FMaxAge  := Round(FMaxAge + (aPercent/100) * FMaxAge);
            FMinAge  := Round(FMinAge - (aPercent/100) * FMinAge);
            FWtAge   := Round(FMaxAge - FMinAge);
          end;
        chkUseAge.Checked := aComboBox.Text <> '';
      end;
    cStories:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjStory := GetValidInteger(edtSubStories.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FStoriesHi := FSubjStory;
            FStoriesLo := FSubjStory;
            FWtStory   := FSubjStory;
          end
        else if aPercent > 0 then
          begin
            FStoriesHi   := Round(FSubjStory + (aPercent/100)*FSubjStory);
            FStoriesLo   := Round(FSubjStory - (aPercent/100)*FSubjStory);
            FMaxStory    := Round(FMaxStory + (aPercent/100) * FMaxStory);
            FMinStory    := Round(FMinStory - (aPercent/100) * FMinStory);
            FWtStory     := Round(FMaxStory - FMinStory);
          end;
        chkUseStories.Checked := aComboBox.Text <> '';
      end;
    cBeds:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjBeds := GetValidInteger(edtSubBed.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FBedsHi := FSubjBeds;
            FBedsLo := FSubjBeds;
            FWtBeds := FSubjBeds;
          end
        else if aPercent > 0 then
          begin
            FBedsHi   := Round(FSubjBeds + (aPercent/100)*FSubjBeds);
            FBedsLo   := Round(FSubjBeds - (aPercent/100)*FSubjBeds);
            FMaxBedRms:= Round(FMaxBedRms + (aPercent/100) * FMaxBedRms);
            FMinBedRms:= Round(FMinBedRms - (aPercent/100) * FMinBedRms);
            FWtBeds   := Round(FMaxBedRms - FMinBedRms);
          end;
        chkUseBed.Checked := aComboBox.Text <> '';
      end;
    cFirePl:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjFirePl := GetValidInteger(edtSubFirePl.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FFirePlHi := FSubjFirePl;
            FFirePlLo := FSubjFirePl;
            FWtFirePl := FSubjFirePl;
          end
        else if aPercent > 0 then
          begin
            FFirePlHi   := Round(FSubjFirePl + (aPercent/100)*FSubjFirePl);
            FFirePlLo   := Round(FSubjFirePl - (aPercent/100)*FSubjFirePl);
            FMaxFirePl  := Round(FMaxFirePl + (aPercent/100) * FMaxFirePl);
            FMinFirePl  := Round(FMinFirePl - (aPercent/100) * FMinFirePl);
            FWtFirePl   := Round(FMaxFirePl - FMinFirePl);
          end;
        chkUseFirePl.Checked := aComboBox.Text <> '';
      end;
    cCars:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjGarage := GetValidInteger(edtSubCar.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FGarageHi := FSubjGarage;
            FGarageLo := FSubjGarage;
            FWtFirePl := FSubjGarage;
          end
        else if aPercent > 0 then
          begin
            FGarageHi := Round(FSubjGarage + (aPercent/100)*FSubjGarage);
            FGarageLo := Round(FSubjGarage - (aPercent/100)*FSubjGarage);
            FMaxCars  := Round(FMaxCars + (aPercent/100) * FMaxCars);
            FMinCars  := Round(FMinCars - (aPercent/100) * FMinCars);
            FWtCars   := Round(FMaxCars - FMinCars);
          end;
        chkUseGarage.Checked := aComboBox.Text <> '';
      end;
    cPool:
      begin
        aPercent := GetValidInteger(aComboBox.Text);
        FSubjPool := GetValidInteger(edtSubPool.Text);
        if (CompareText(aComboBox.Text,'Equal') = 0) or (aPercent = 0) then
          begin
            FPoolHi := FSubjPool;
            FPoolLo := FSubjPool;
            FWtPool := FSubjPool;
          end
        else if aPercent > 0 then
          begin
            FPoolHi := Round(FSubjPool + (aPercent/100)*FSubjPool);
            FPoolLo := Round(FSubjPool - (aPercent/100)*FSubjPool);
            FMaxPool:= Round(FMaxPool + (aPercent/100) * FMaxPool);
            FMinPool:= Round(FMinPool - (aPercent/100) * FMinPool);
            FWtPool := Round(FMaxPool - FMinPool);
          end;
        chkUsePool.Checked := aComboBox.Text <> '';
      end;
  end;
end;

procedure TCompFilter.CalcRanking;
const
  NearnessMaxScore = 500;
  SimilarMaxScore  = 1000;
var
  i, iCount: Integer;
  aDist,radDist, aDist2: Double;
  aPrice,aSaleMonths,aBedRm,aBath,aCar,aGLA,aSite,aFirePl,aBsmt,aAge,aPool,aStory: Integer;
  radSMonths, radGLA, radBGLA, radSite, radAge, radBedRm, radBaths, radFirePl: Integer;
  radCars, radPool, radStory: Integer;
  theSaleDate: TDateTime;
  effDate: TDateTime;
  WtSum, WtNearSum: Integer;
  FSaleMonths,FStyleRank, FXtraWeight: Integer;          //holds days between sales date & eff date
  FScore,FNearnessScore, FSimilarScore, FDistScore,FSaleDateScore,FDOMScore,FGLAScore,FBsmtScore: Double;
  FBedScore,FBathScore,FFirePlScore,FCarScore,FPoolScore,FStyleScore,FSiteScore: Double;
  FAgeScore, FStoryScore: Double;
  Skip: Boolean;
begin
  effDate := StrToDateDef(FSubject.EffectiveDate, Date);
  FSubjGLA := GetValidInteger(edtSubGLA.Text);
//  if FWtSDate = 0 then
//    FWtSDate := 1;
  WtNearSum := FWtDist + FWtSDate;

  //do this once, find range
  radDist   := abs(FMaxDist - FMinDist);
  radSMonths:= abs(FMaxSaleMonths - FMinSaleMonths);
  radGLA    := Max(abs(FMaxGLA - FSubjGLA), abs(FMinGLA - FSubjGLA));
  radBGLA   := Max(abs(FMaxBGLA - FSubjBGLA), abs(FMinBGLA - FSubjBGLA));
  radSite   := Max(abs(FMaxSite - FSubjSite), abs(FMinSite - FSubjSite));
  radAge    := Max(abs(FMaxAge - FSubjAge), abs(FMinAge - FSubjAge));
  radStory  := Max(abs(FMaxStory - FSubjStory), abs(FMinStory - FSubjStory));
  radBedRm  := Max(abs(FMaxBedRms - FSubjBeds), abs(FMinBedRms - FSubjBeds));
  radFirePl := Max(abs(FMaxFirePl - FSubjFirePl), abs(FMinFirePl - FSubjFirePl));
  radCars   := Max(abs(FMaxCars - FSubjGarage), abs(FMinCars - FSubjGarage));
  radPool   := Max(abs(FMaxPool - FSubjPool), abs(FMinPool - FSubjPool));

  iCount := FMarketGrid.Rows;
  skip := False;

  for i := 1 to iCount  do
    begin
        FMarketGrid.RowHeight[i] := 0;
        FMarketGrid.Cell[_Rank, i]  := '';
        if FMarketGrid.CellCheckBoxState[_Include, i] = cbUnchecked then
          begin
            FMarketGrid.RowHeight[i] := 0;
            FMarketGrid.Cell[_Rank, i]  := '';
            continue;
          end;
        //distance
        FDistScore := 0;
        FMarketGrid.Cell[_Rank, i]  := '';
        if chkUseProx.checked then
          begin
            aDist := GetFirstValue(FMarketGrid.cell[_Proximity, i]) - FMinDist;   //ditto
            if radDist > 0 then
              begin
                FDistScore  := Round(((radDist - aDist)/radDist) * NearnessMaxScore);
              end;
          end
        else FWtDist := 0;

        //sale date
        FSaleDateScore := 0;
        if chkUseSaleDate.checked then
          begin
          //if pos(UpperCase(FMarketGrid.cell[_CompType, i]), UpperCase(typSale)) >0 then begin                 //score only Sales
            FSaleMonths := 0;
            if UUtil1.IsValidDateTime(FMarketGrid.Cell[_SalesDate,i], theSaleDate) then
              FSaleMonths := abs(MonthsBetween(EffDate, theSaleDate));
            aSaleMonths := FSaleMonths - FMinSaleMonths;
            if radSMonths > 0 then
              FSaleDateScore := Round(((radSMonths - aSaleMonths)/radSMonths) * NearnessMaxScore);
          end;

        //GLA
        FGLAScore := 0;
        if chkUseGLA.checked then begin
          aGLA := GetFirstIntValue(FMarketGrid.cell[_GLA, i]);
          aGLA := abs(FSubjGLA - aGLA);
          if radGLA > 0 then
            FGLAScore := Round(((radGLA - aGLA)/radGLA)* SimilarMaxScore);
         end
        else FWtGLA := 0;

        //BasementGLA
        FBsmtScore := 0;
        if chkUseBsmt.checked then begin
          aBsmt := GetFirstIntValue(FMarketGrid.cell[_BasementGLA, i]);
          aBsmt := abs(FSubjBGLA - aBsmt);
          if radBGLA > 0 then
            FBsmtScore := Round(((radBGLA - aBsmt)/radBGLA) * SimilarMaxScore);
        end
        else FWtBGLA := 0;

        //SiteArea
        FSiteScore := 0;
        if chkUseSiteArea.checked then begin
          aSite := GetFirstIntValue(FMarketGrid.cell[_SiteArea, i]);
          aSite := abs(FSubjSite - aSite);
          if radSite > 0 then
            FSiteScore :=  Round(((radSite - aSite)/radSite) * SimilarMaxScore);
        end
        else  FWtSite := 0;

        //ActualAge
        FAgeScore := 0;
        if chkUseAge.checked then begin
          aAge := GetFirstIntValue(FMarketGrid.cell[_Age, i]);
          aAge := abs(FSubjAge - aAge);
          if radAge > 0 then
            FAgeScore := Round(((radAge - aAge)/radAge) * SimilarMaxScore);
        end
        else FWtAge := 0;

        FStoryScore := 0;
        if chkUseStories.Checked then begin
          aStory := GetFirstIntValue(FMarketGrid.cell[_Stories, i]);
          aStory := abs(FSubjStory - aStory);
          if radStory > 0 then
            FStoryScore := Round(((radStory - aStory)/radStory) * SimilarMaxScore);
        end
        else FWtStory := 0;

        //BedroomCount
        FBedScore := 0;
        if chkUseBed.Checked then begin
          aBedRm := GetFirstIntValue(FMarketGrid.cell[_BedRoomTotal, i]);
          aBedRm := abs(FSubjBeds - aBedRm);
          if radBedRm > 0 then
            FBedScore := Round(((radBedRm - aBedRm)/radBedRm) * SimilarMaxScore);
        end
        else FWtBeds := 0;

        //FireplacesCount
        FFirePlScore := 0;
        if chkUseFirePl.checked then begin
          aFirePl := GetFirstIntValue(FMarketGrid.cell[_FireplaceQTY, i]);
          aFirePl := abs(FSubjFirePl - aFirePl);
          if radFirePl > 0 then
            FFirePlScore := Round(((radFirePl - aFirePl)/radFirePl) * SimilarMaxScore);
        end
        else FWtFirePl := 0;

        //GarageCarCount
        FCarScore := 0;
        if ChkUseGarage.checked then begin
          aCar := GetFirstIntValue(FMarketGrid.cell[_GarageSpace, i]);
          aCar := abs(FSubjGarage - aCar);
          if radCars > 0 then
            FCarScore := Round(((radCars - aCar)/radCars) * SimilarMaxScore);
        end
        else FWtCars := 0;

        FPoolScore := 0;
        if ChkUsePool.Checked then begin
          aPool := GetFirstIntValue(FMarketGrid.cell[_PoolQTY, i]);
          aPool := abs(FSubjPool - aPool);
          if radPool > 0 then
            FPoolScore := Round(((radPool - aPool)/radPool) * SimilarMaxScore);
        end
        else FwtPool := 0;

        //rate the nearness of the sale to the subject
        FNearnessScore  := 0;
        if FWtDist > 0 then
          FNearnessScore := (FWtDist/WtNearSum) * FDistScore;
        if FWtSDate > 0 then
          FNearnessScore := FNearnessScore + (FWtSDate/WtNearSum) * FSaleDateScore;

        //rate the similarity of the sale to the subject
        WtSum :=  FWtGLA + FWtBGLA + FWtSite + FWtAge + FWtBeds + FWtBaths + FWtFirePl + FWtCars + FWtPool+ FWtStory;
        FSimilarScore   := 0;
        if FWtGLA > 0 then
          FSimilarScore := FSimilarScore + (FWtGLA/WtSum) * FGLAScore;
        if FWtBGLA > 0 then
          FSimilarScore := FSimilarScore + (FWtBGLA/WtSum) * FBsmtScore;
        if FWtSite > 0 then
          FSimilarScore := FSimilarScore + (FWtSite/WtSum) * FSiteScore;
        if FWtAge > 0 then
          FSimilarScore := FSimilarScore + (FWtAge/WtSum) * FAgeScore;
        if FWtStory > 0 then
          FSimilarScore := FSimilarScore + (FWtStory/WtSum) * FStoryScore;
        if FWtBeds > 0 then
          FSimilarScore := FSimilarScore + (FWtBeds/WtSum) * FBedScore;
        if FWtBaths > 0 then
          FSimilarScore := FSimilarScore + (FWtBaths/WtSum) * FBathScore;
        if FWtFirePl > 0 then
          FSimilarScore := FSimilarScore + (FWtFirePl/WtSum) * FFirePlScore;
        if FWtCars > 0 then
          FSimilarScore := FSimilarScore + (FWtCars/WtSum) * FCarScore;
        if FWtPool > 0 then
          FSimilarScore := FSimilarScore + (FWtPool/WtSum) * FPoolScore;

        FScore := FNearnessScore + FSimilarScore; // + FXtraWeight;
        if (FMarketGrid.CellCheckBoxState[_Include, i] = cbchecked) then
          begin
            FMarketGrid.RowHeight[i]    := Default_Row_Height;
            FMarketGrid.Cell[_Rank, i]  := Round(FScore);
            if trim(FMarketGrid.Cell[_Rank, i]) = '0' then
              FMarketGrid.Cell[_Rank, i] := '';
          end;
//        else
//          begin
//            FMarketGrid.RowHeight[i] := 0;   //hide the row
//            FMarketGrid.Cell[_Rank, i]  := '';
//          end;
  end;
end;

function TCompFilter.IsInFilterRangeSmallNum(op: String; SubjValue: Integer; AValue, MinValue, MaxValue: Double): Boolean;
begin
  result := True;        //assume is not filteded out
  if (aValue <> 0) or (SubjValue = 0) then
    begin
      if CompareText(op, 'Equal') = 0 then
        result := aValue = SubjValue
      else
        result := (AValue >= MinValue) and (AValue <= MaxValue);
    end;
end;


function TCompFilter.IsInFilterRangeLargeNum(op:String; SubjValue: Integer; AValue, MinValue, MaxValue: Double): Boolean;
begin
  result := True;        //assume is not filteded out
  if AValue <> 0 then
    begin
      if CompareText(op, 'Equal') = 0 then
        result := aValue = SubjValue
      else
        result := AValue <= MaxValue;
    end;
end;


function TCompFilter.FilterComps:Boolean;
var
  i, iCount: Integer;
  aDist: Double;
  theSaleDate, EffDate: TDateTime;
  aSaleMonths,aGLA,aBsmt,aSite,aAge,aBedRm,aBath,aFirePl,aCar,aPool,aStories: Integer;
begin
  EffDate := StrToDate(TSubject(FSubject).EffectiveDate);
  result  := False;
  //what are the filter settings
  iCount := FMarketGrid.Rows;
      for i := 1 to iCount do
        begin
          if chkUseProx.checked then
            begin
              aDist := GetFirstValue(FMarketGrid.cell[_Proximity, i]);
              if not IsInFilterRangeLargeNum(cbProx.Text, FSubjProx, aDist, 0, GetStrValue(cbProx.Text)) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                end;
            end
            else
              FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;

          //date of sale
          if chkUseSaleDate.Checked then
            if uUtil1.IsValidDateTime(FMarketGrid.cell[_SalesDate, i], theSaleDate) then
              begin
                aSaleMonths := abs(MonthsBetween(EffDate, theSaleDate));
                //FSubjSaleDate := GetValidInteger(cbSaleDate.Text);
                if not IsInFilterRangeLargeNum(cbSaleDate.Text, FSubjSaleDate, aSaleMonths, FMinSaleMonths,GetValidInteger(cbSaleDate.Text)) then
                  begin
                    FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                    Continue;
                  end
                 else
                   FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
              end
            else
              FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;

          //GLA
          if chkUseGLA.Checked then
            begin
              aGLA := GetFirstIntValue(FMarketGrid.cell[_GLA, i]);
              FSubjGLA := GetValidInteger(edtSubGLA.Text);
              if not IsInFilterRangeLargeNum(cbGLA.Text, FSubjGLA, aGLA, FGLALo, FGLAHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end
            else
              FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;

          //basement area
          if chkUseBsmt.Checked then
            begin
              aBsmt := GetFirstIntValue(FMarketGrid.cell[_BasementGLA, i]);
              FSubjBGLA := GetValidInteger(edtSubBGLA.Text);
              if not IsInFilterRangeLargeNum(cbBsmt.Text, FSubjBGLA, aBsmt, FBGLALo, FBGLAHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;

          //SiteArea
          if chkUseSiteArea.Checked then
            begin
              aSite := GetFirstIntValue(FMarketGrid.cell[_SiteArea, i]);
              FSubjSite := GetValidInteger(edtSubSite.Text);
              if not IsInFilterRangeLargeNum(cbSite.Text, FSubjSite, aSite, FSiteLo, FSiteHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;

          //ActualAge
          if chkUseAge.Checked then
            begin
              aAge := GetFirstIntValue(FMarketGrid.cell[_Age, i]);
              FSubjAge := GetValidInteger(edtSubAge.Text);
              if not IsInFilterRangeSmallNum(cbAge.Text, FSubjAge, aAge, FAgeLo, FAgeHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  if CompareText('Equal', cbAge.Text) = 0 then
                    begin
                      if aAge = FSubjAge then
                        FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked
                      else
                        FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                    end
                  else
                    FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                end;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;

          //Story Count
          if chkUseStories.Checked then
            begin
              aStories := GetFirstIntValue(FMarketGrid.cell[_Stories, i]);
              FSubjStory := GetValidInteger(edtSubStories.Text);
              if not IsInFilterRangeSmallNum(cbStories.Text, FSubjStory, aStories, FStoriesLo, FStoriesHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  if CompareText('Equal', cbStories.Text) = 0 then
                    begin
                      if aStories = FSubjStory then
                        FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked
                      else
                        FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                    end
                  else
                    FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                end;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;

          //BedroomCount
          if ChkUseBed.Checked then
            begin
              aBedRm := GetFirstIntValue(FMarketGrid.cell[_BedRoomTotal, i]);
              FSubjBeds := GetValidInteger(edtSubBed.Text);
              if not IsInFilterRangeSmallNum(cbBedRm.Text, FSubjBeds, aBedRm, FBedsLo,FBedsHi) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  if CompareText('Equal', cbBedRm.Text) = 0 then
                    begin
                      if aBedRm = FSubjBeds then
                        begin
                          FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                        end
                      else
                        begin
                          FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                        end;
                    end
                  else
                    begin
                      FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                    end;
                end;
            end
          else
            begin
              FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end;

          //FireplacesCount
          if chkUseFirePl.Checked then
            begin
              aFirePl := GetFirstIntValue(FMarketGrid.cell[_FireplaceQTY, i]);
              FSubjFirePl := GetValidInteger(edtSubFirePl.Text);
              if not IsInFilterRangeSmallNum(cbFirePl.Text, FSubjFirePl, aFirePl, FMinFirePl, FMaxFirePl) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end
          else
            begin
              FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
            end;
          //GarageCarCount
          if chkUseGarage.Checked then
            begin
              aCar := GetFirstIntValue(FMarketGrid.cell[_GarageSpace, i]);
              FSubjGarage := GetValidInteger(edtSubCar.Text);
              if not IsInFilterRangeSmallNum(cbGarage.Text, FSubjGarage, aCar, FMinCars, FMaxCars) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                end;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;

          //Pool Count
          if chkUsePool.Checked then
            begin
              aPool := GetFirstIntValue(FMarketGrid.cell[_PoolQTY, i]);
              FSubjPool := GetValidInteger(edtSubPool.Text);
              if not IsInFilterRangeSmallNum(cbPool.Text, FSubjPool, aPool, FMinPool, FMaxPool) then
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbUnChecked;
                  Continue;
                end
              else
                begin
                  FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
                end;
            end
          else
            FMarketGrid.CellCheckBoxState[_Include, i] := cbChecked;
       if FMarketGrid.CellCheckBoxState[_Include, i] = cbChecked then
         FMarketGrid.RowHeight[i] := Default_Row_Height
       else
         FMarketGrid.RowHeight[i] := 0;


       result := True;  //always return true
  end;
end;

procedure TCompFilter.DisplaySummaryCounts;
var
  i, numRows: Integer;
  TotalSalesCount, ExcludedSalesCount, FinalSalesCount: Integer;
  TotalListCount, ExcludedListCount, FinalListCount: Integer;
begin
  TotalSalesCount     := 0;
  ExcludedSalesCount  := 0;
  FinalSalesCount     := 0;
  TotalListCount      := 0;
  ExcludedListCount   := 0;
  FinalListCount      := 0;

  numRows := FMarketGrid.Rows;   //total
//  with FMarketData do
//    begin
      for i := 1 to numRows do
        begin
          //count the sales and listings
          if FMarketGrid.Cell[_CompType, i] = typSale then
            TotalSalesCount := TotalSalesCount + 1

          else if FMarketGrid.Cell[_CompType, i] = typListing then
            TotalListCount := TotalListCount + 1;

          //count how many are included and excluded
          if FMarketGrid.CellCheckBoxState[_Include, i] = cbUnChecked then
            begin
              if FMarketGrid.Cell[_CompType, i] = typSale then
                ExcludedSalesCount := ExcludedSalesCount + 1

              else if FMarketGrid.Cell[_CompType, i] = typListing then
                ExcludedListCount := ExcludedListCount + 1;
            end;
        end;
//    end;

  //calc the remaining counts
  FinalSalesCount := TotalSalesCount - ExcludedSalesCount;
  FinalListCount  := TotalListCount - ExcludedListCount;

  //show the results
  lblTotalSalesCount.caption    := IntToStr(TotalSalesCount);
  lblExcludedSalesCount.caption := IntToStr(ExcludedSalesCount);
  lblFinalSalesCount.caption    := IntToStr(FinalSalesCount);

  lblTotalListCount.caption     := IntToStr(TotalListCount);
  lblExcludedListCount.caption  := IntToStr(ExcludedListCount);
  lblFinalListCount.caption     := IntToStr(FinalListCount);
end;


function TCompFilter.ApplyFilters:Boolean;
begin
  result := FilterComps;
  DisplaySummaryCounts;
  FMarketGrid.CurrentDataRow := 1;  //set current row to the top
  FMarketGrid.SortOnCol(_Rank, stDescending, True);
  FMarketGrid.Update;
end;
procedure TCompFilter.CopyGridData;
var
  row, col: Integer;
begin
  TMarketFeature(FMarketFeature).MarketGrid.Rows := FMarketGrid.Rows;
  for row:= 1 to FMarketGrid.Rows do
    for col := 1 to FMarketGrid.Cols do
    begin
      TMarketFeature(FMarketFeature).MarketGrid.cell[col, row] := FMarketGrid.cell[col, row];
    end;
  TMarketFeature(FMarketFeature).MarketGrid.Refresh;
end;

procedure TCompFilter.btnApplyFiltersClick(Sender: TObject);
begin
  FFilterApplied := True;
  FMarketGrid.BeginUpdate;
  try
    if ApplyFilters then
      CalcRanking;
    CopyGridData;

    TMarketFeature(FMarketFeature).ReFreshOtherModules;
  finally
    FMarketGrid.EndUpdate;
    FMarketGrid.SortOnCol(_Rank, stDescending, True);
  end;
end;



procedure TCompFilter.ClearFilters;
begin
  chkUseProx.Checked := False;
  chkUseSaleDate.Checked := False;
  chkUseGLA.Checked  := False;
  chkUseSiteArea.Checked := False;
  chkUseBsmt.Checked := False;
  chkUseAge.Checked  := False;
  chkUseBed.Checked  := False;
  chkUseFirePl.Checked := False;
  chkUseGarage.Checked := False;
  chkUsePool.Checked := False;
  chkUseStories.Checked := False;
  chkUseBed.Checked := False;
  chkUseFirePl.Checked := False;
  chkUseGarage.Checked := False;
  chkUsePool.Checked := False;

  cbGLA.Text  := '';
  cbBsmt.Text := '';
  cbAge.Text  := '';
  cbSite.Text := '';
  cbBedRm.Text := '';
  cbFirePl.Text := '';
  cbGarage.Text := '';
  cbPool.Text  := '';
end;

procedure TCompFilter.btnResetClick(Sender: TObject);
var
  aRow: Integer;
begin
  chkUseProx.Checked := False;
  chkUseSaleDate.Checked := False;
  chkUseGLA.Checked  := False;
  chkUseSiteArea.Checked := False;
  chkUseBsmt.Checked := False;
  chkUseAge.Checked  := False;
  chkUseBed.Checked  := False;
  chkUseFirePl.Checked := False;
  chkUseGarage.Checked := False;
  chkUsePool.Checked := False;
  chkUseStories.Checked := False;
  chkUseBed.Checked := False;
  chkUseFirePl.Checked := False;
  chkUseGarage.Checked := False;
  chkUsePool.Checked := False;

  cbGLA.Text  := '';
  cbBsmt.Text := '';
  cbAge.Text  := '';
  cbSite.Text := '';
  cbBedRm.Text := '';
  cbFirePl.Text := '';
  cbGarage.Text := '';
  cbPool.Text  := '';

  for aRow := 1 to FMarketGrid.Rows do
    begin
      if FMarketGrid.cellCheckBoxState[_Include, aRow] = cbUnchecked then
        FMarketGrid.CellCheckBoxState[_Include, aRow] := cbChecked;
      FMarketGrid.Cell[_Rank, aRow] := '';
    end;
  FMarketGrid.BeginUpdate;
  try
    btnApplyFilters.click;
  finally
    FMarketGrid.EndUpdate;
    FMarketGrid.SortOnCol(_Rank, stDescending, True);
  end;
end;

procedure TCompFilter.btnUseDefaultFiltersClick(Sender: TObject);
begin
  WritePref;
  FDataModified := False;
  btnUseDefaultFilters.Enabled := False;
end;

procedure TCompFilter.WritePref;
var
  PrefFile: TMemIniFile;
  IniFilePath: String;
  i, NumTools: Integer;
begin
  IniFilePath := IncludeTrailingPathDelimiter(appPref_DirPref) + cClickFormsINI;
  PrefFile := TMemIniFile.Create(IniFilePath);  //create the INI writer
  Try
    with PrefFile do
    begin
      //Proximity
      WriteBool('MLS', 'UseProx', chkUseProx.Checked);
      WriteString('MLS', 'Proximity', cbProx.Text);
      //Sales Date
      WriteBool('MLS', 'UseSalesDate', chkUseSaleDate.Checked);
      WriteString('MLS', 'SalesDate', cbSaleDate.Text);
      //GLA
      WriteBool('MLS', 'UseGLA', chkUseGLA.Checked);
      WriteString('MLS', 'GLA', cbGLA.Text);
      //BGLA
      WriteBool('MLS', 'UseBsmt', chkUseBsmt.Checked);
      WriteString('MLS', 'BGLA', cbBsmt.Text);
      //Site Area
      WriteBool('MLS', 'UseSiteArea', chkUseSiteArea.Checked);
      WriteString('MLS', 'SiteArea', cbSite.Text);
      //Actual Age
      WriteBool('MLS', 'UseAge', chkUseAge.Checked);
      WriteString('MLS', 'Age', cbAge.Text);
      //Stories
      WriteBool('MLS', 'UseStories', chkUseStories.Checked);
      WriteString('MLS', 'Stories', cbStories.Text);
      //Beds
      WriteBool('MLS', 'UseBed', chkUseBed.Checked);
      WriteString('MLS', 'Beds', cbBedRm.Text);
      //Fire Place
      WriteBool('MLS', 'UseFirePl', chkUseFirePl.Checked);
      WriteString('MLS', 'FirePl', cbFirePl.Text);
      //Cars
      WriteBool('MLS', 'UseGarage', chkUseGarage.Checked);
      WriteString('MLS', 'Garage', cbGarage.Text);
      //Pool
      WriteBool('MLS', 'UsePool', chkUsePool.Checked);
      WriteString('MLS', 'Pool', cbPool.Text);
    end;
  finally
    PrefFile.UpdateFile;
    PrefFile.Free;
  end;
end;

procedure TCompFilter.UseFilterEvent(Sender: TObject);
begin
  FDataModified := True;
  btnUseDefaultFilters.Enabled := True;
end;

procedure TCompFilter.OnEnterTextEvent(Sender: TObject);
begin
  if Sender is TComboBox then
    FOriginalText := TComboBox(Sender).Text;
end;

procedure TCompFilter.OnComboSelect(Sender: TObject);
var
  aComboBox: TComboBox;
begin
  btnUseDefaultFilters.Enabled := True;
  if Sender is TComboBox then
    begin
      aComboBox := TComboBox(Sender);
      RateChange(aComboBox);
    end;
end;

end.
