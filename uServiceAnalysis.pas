unit uServiceAnalysis;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2017 by Bradford Technologies, Inc. }
{ This unit is the main unit of Service >> Analysis }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, uSubject, UMarketData, {uContainer,} uSubjectMarket,uRegression,
  uAdjustments, uCompSelection, uMarketFeature, AdvGlowButton, AdvPanel,uForms, uutil1,
  StdCtrls,osAdvDbGrid,Grids_ts, TSGrid, uBuildReport;

type
  TAnalysis = class(TAdvancedForm)
    StatusBar1: TStatusBar;
    ScrollBox: TScrollBox;
    RegressionPanel: TPanel; //panel to hold regression data
    MktDataPanel: TPanel;    //panel to hold market data
    SubjectMktPanel: TPanel; //panel to hold subject market data
    MktFeaturePanel: TPanel; //panel to hold market feature data
    CompSelectionPanel: TPanel;
    SubjectPanel: TPanel;
    AdjustmentPanel: TPanel;
    Panel1: TPanel;
    btnCancel: TButton;
    BuildReportPanel: TPanel;  //panel to hold comp selection data
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    //FDoc: TContainer;
    FDoc: TComponent;
    FSubject: TSubject;
    FMarketData:TMarketData;
    FMarketFeature: TMarketFeature;
    FSubjectMarket: TSubjectMarket;
    FRegression: TRegression;
    FAdjustments: TAdjustments;
    FCompSelection: TCompSelection;
    FMarketGrid: TosAdvDBGrid;
    FSubjectGrid: TtsGrid;
    FBuildReport: TBuildReport;
    procedure SetupConfiguration;
  public
    { Public declarations }
    FClose: Boolean;
    procedure InitTool;
    function LoadSubjectDataModule(doc: TComponent): TSubject;
    function LoadMarketDataModule(doc: TComponent): TMarketData;
    function LoadSubjectMarketModule(doc: TComponent): TSubjectMarket;
    function LoadRegressionModule(doc: TComponent):TRegression;
    function LoadAdjustmentModule(doc: TComponent):TAdjustments;
    function LoadCompSelectionModule(doc: TComponent):TCompSelection;
    function LoadMarketFeatureModule(doc: TComponent):TMarketFeature;
    function LoadReportModule(doc: TComponent):TBuildReport;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property doc: TComponent read FDoc write FDoc;
    property MarketData: TMarketdata read FMarketdata write FMarketdata;
    property SubjectMarket: TSubjectMarket read FSubjectMarket write FSubjectMarket;
    property MarketGrid: TosAdvDBGrid read FMarketGrid write FMarketGrid;
    property MarketFeature: TMarketFeature read FMarketFeature write FMarketFeature;
    property Regression: TRegression read FRegression write FRegression;
    property CompSelection: TCompSelection read FCompSelection write FCompSelection;
    property Adjustments: TAdjustments read FAdjustments write FAdjustments;
    property BuildReport: TBuildReport read FBuildReport write FBuildReport;
  end;

var
  Analysis: TAnalysis;

  procedure LoadAnalysisService(doc:TComponent);

implementation

uses UMain, uGlobals, uContainer;

const
   //Setup the width of each panel
   wSubject       = 350;
   wMktData       = 1100;
   wMktFeature    = 1500;
   wSubjectMkt    = 1100;
   wRegression    = 1200;
   wAdjustment    = 900;
   wCompSelection = 2100;
   wReport        = 800;

{$R *.dfm}
constructor TAnalysis.Create(AOwner: TComponent);
begin
//  inherited;
  inherited Create(AOwner);
end;

destructor TAnalysis.Destroy;
begin
  inherited;
end;

procedure TAnalysis.SetupConfiguration;
var
  aWidth: Integer;
begin
  SubjectPanel.visible := not appPref_BasicAnalysis;
  MktDataPanel.visible := True;
  MktFeaturePanel.visible := not appPref_BasicAnalysis;
  SubjectMktPanel.visible := not appPref_BasicAnalysis;
  RegressionPanel.visible := not appPref_BasicAnalysis;
  AdjustmentPanel.visible := not appPref_BasicAnalysis;
  CompSelectionPanel.visible := not appPref_BasicAnalysis;
  BuildReportPanel.visible   := not appPref_BasicAnalysis;

  SubjectPanel.Width       := wSubject;
  if appPref_BasicAnalysis then
    begin
      MktDataPanel.Width := width;
      MktDataPanel.align := alClient;
      self.Caption       := 'MLS Import Wizard';
    end
  else
    begin
      MktDataPanel.Width := wMktData;
      self.Caption       := 'Analysis';
    end;

  MktFeaturePanel.width    := wMktFeature;
  SubjectMktPanel.width    := wSubjectMkt;
  RegressionPanel.width    := wRegression;
  AdjustmentPanel.width    := wAdjustment;
  CompSelectionPanel.width := wCompSelection;
  BuildReportpanel.width   := wReport;

  ScrollBox.Align := alNone;
  if appPref_BasicAnalysis then
    aWidth := mktDataPanel.width
  else
    aWidth := SubjectPanel.Width +
              MktDataPanel.Width +
              MktFeaturePanel.Width +
              SubjectMktPanel.Width +
              RegressionPanel.Width +
              AdjustmentPanel.Width +
              CompSelectionPanel.Width +
              BuildReportPanel.Width;

  ScrollBox.Width := aWidth;

  ScrollBox.AutoScroll := True;
  ScrollBox.AutoSize   := True;
  ScrollBox.Align      := alNone;
  ScrollBox.HorzScrollBar.Tracking := True;  //NOTE: this boolean should always set to True so we can show the scrollbar movement
  //width of ScrollBox = sum of all the panels' width

  ScrollBox.HorzScrollBar.Range     := ScrollBox.Width;
  ScrollBox.HorzScrollBar.Position  := 0;
  ScrollBox.Align  := alClient;
  WindowState := wsMaximized;
end;


//procedure LoadRedstoneAnalysis(AOwner:Tcomponent);
procedure LoadAnalysisService(doc:TComponent);
var
  Analysis:TAnalysis;
  aForm: TAdvancedForm;
begin
  aForm := FindFormByName('Analysis');
  if assigned(aForm) then
    FreeAndNil(aForm);
  Analysis := TAnalysis.Create(Application);
  try
    if assigned(doc) then
      Analysis.doc := doc
    else
      Analysis.doc := Main.NewEmptyContainer;
    Analysis.InitTool;
    Analysis.Show;
  finally
  end;
end;


procedure TAnalysis.InitTool;
begin
  SetupConfiguration;
  //Load individual module into seperate panel
  if not assigned(FSubject) and not appPref_BasicAnalysis then
    FSubject         := LoadSubjectDataModule(FDoc);
  if not assigned(FMarketData) then
    FMarketData      := LoadMarketDataModule(FDoc);
  if not assigned(FMarketFeature) and not appPref_BasicAnalysis then
    FMarketFeature := LoadMarketFeatureModule(FDoc);
  if not assigned(FSubjectMarket) and not appPref_BasicAnalysis then
    FSubjectMarket := LoadSubjectMarketModule(FDoc);
  if not assigned(FRegression) and not appPref_BasicAnalysis then
    FRegression := LoadRegressionModule(FDoc);
  if not assigned(FAdjustments) and not appPref_BasicAnalysis then
    FAdjustments := LoadAdjustmentModule(FDoc);
  if not assigned(FCompSelection) and not appPref_BasicAnalysis then
    FCompSelection := LoadCompSelectionModule(FDoc);
  if not assigned(FBuildReport) and not appPref_BasicAnalysis then
    FBuildReport := LoadReportModule(FDoc);
end;

function TAnalysis.LoadSubjectDataModule(doc: TComponent): TSubject;
begin
  result := TSubject.Create(TContainer(doc));
  try
    result.Parent := SubjectPanel;
    result.Parent.Width := wSubject;
    result.Align  := alClient;
    result.BorderStyle := bsNone;
    result.Visible := True;
    result.InitTool(TContainer(doc));
    Subject := result;
    FSubjectGrid := result.SubjectGrid;
  except
  end;
end;



function TAnalysis.LoadMarketDataModule(doc: TComponent): TMarketData;
var
  aDoc:TContainer;
begin
  aDoc := TContainer(doc);
  result := TMarketData.Create(aDoc);
  try
    result.Parent       := MktDataPanel;
    result.Parent.Width := wMktData;
    MarketGrid          := result.Grid;
    result.Align        := alClient;
    result.BorderStyle  := bsNone;
    result.Visible      := True;
    result.InitTool(aDoc);
    FMarketData           := result;
    if not appPref_BasicAnalysis  then
      begin
        if not assigned(Subject) then
          LoadSubjectDataModule(doc);

        if not assigned(MarketFeature) then
          LoadMarketFeatureModule(doc);

        if not assigned(SubjectMarket)  then
          LoadSubjectMarketModule(doc);

        if not assigned(Regression) then
          LoadRegressionModule(doc);

        if not assigned(CompSelection)  then
          LoadCompSelectionModule(doc);

        if not assigned(Adjustments)  then
          LoadAdjustmentModule(doc);

       // if not assigned(BuildReport)  then
       //   LoadReportModule(doc);

      end;
    result.FMarketFeature := MarketFeature;
    result.FSubjectMarket := SubjectMarket;
    result.FRegression    := Regression;
    result.FCompSelection := CompSelection;
    result.FSubject       := Subject;
    result.FAnalysis      := self;
    result.FAdjustments   := Adjustments;
    if not appPref_BasicAnalysis and (TCompSelection(result.FCompSelection) <> nil) then
      TCompSelection(result.FCompSelection).FMarketData := result;
    result.LoadToolData;
  except
  end;
end;


function TAnalysis.LoadMarketFeatureModule(doc: TComponent): TMarketFeature;

begin
  result := TMarketFeature.Create(TContainer(doc));
  try
    result.Parent := MktFeaturePanel;
    result.Parent.Width := wMktFeature;
    result.Align := alClient;
    result.BorderStyle := bsNone;
    result.Visible := True;
    result.InitTool(TContainer(doc));
    result.FMarketData := FMarketData;
    TAnalysis(result.FAnalysis) := self;
    result.FSubjectMarket := SubjectMarket;
    result.FRegression    := Regression;
    result.FCompSelection := CompSelection;
    result.FAdjustments   := Adjustments;
//    result.MarketGrid := FMarketGrid;
    MarketFeature := result;
    if not assigned(Subject) then
      LoadSubjectDataModule(doc);
    if not assigned(BuildReport) then
      LoadReportModule(doc);
    result.FBuildReport := BuildReport;
    result.FSubject := Subject;
  except
  end;
end;



function TAnalysis.LoadSubjectMarketModule(doc: TComponent): TSubjectMarket;

begin
  result := TSubjectMarket.Create(TContainer(doc));
  try
    result.Parent := SubjectMktPanel;
    result.Parent.Width := wSubjectMkt;
    result.Align := alClient;
    result.BorderStyle := bsNone;
    result.Visible := True;
    result.MarketGrid := FMarketGrid;
//    result.FMarketData := FMarketData;
    result.InitTool(TContainer(doc));
    SubjectMarket := result;
  except
  end;
end;


function TAnalysis.LoadRegressionModule(doc: TComponent): TRegression;
begin
  result := TRegression.Create(TContainer(doc));
  try
    result.Parent := RegressionPanel;
    result.Parent.Width := wRegression;
    result.Align := alClient;
    result.BorderStyle := bsNone;
    result.Visible := True;
    result.InitTool(TContainer(doc));
    Regression := result;

    result.MarketGrid := FMarketGrid;

    if not appPref_BasicAnalysis  then
      begin
        if not assigned(Adjustments)  then
          LoadAdjustmentModule(doc);
      end;

    result.FAdjustments := Adjustments;
  except
  end;
end;

function TAnalysis.LoadAdjustmentModule(doc: TComponent): TAdjustments;
begin
  result := TAdjustments.Create(TContainer(doc));
  try
    result.Parent := AdjustmentPanel;
    result.Parent.Width := wAdjustment;
    result.Align := alClient;
    result.BorderStyle := bsNone;

    result.FRegression := FRegression;
    result.FCompSelection := FCompSelection;
    FAdjustments := result;

    result.Visible := True;
    result.InitTool(TContainer(doc))
  except
  end;
end;


function TAnalysis.LoadCompSelectionModule(doc: TComponent): TCompSelection;
begin
  result := TCompSelection.Create(TContainer(doc));
  try
    result.Parent         := CompSelectionPanel;
    result.Parent.Width   := wCompSelection;
    result.Align          := alClient;
    result.BorderStyle    := bsNone;
    result.Visible        := True;
    result.MarketGrid     := FMarketGrid;
    result.SubjectGrid    := FSubjectGrid;
    result.FSubjectMarket := FSubjectMarket;
    result.FMarketData    := FMarketData;
    result.FAdjustments   := FAdjustments;
    CompSelection         := result;
    if not assigned(BuildReport) then
      LoadReportModule(doc);
    result.FBuildReport := BuildReport;
    result.InitTool(TContainer(doc));
  except
  end;
end;


function TAnalysis.LoadReportModule(doc: TComponent): TBuildReport;
begin
  result := TBuildReport.Create(TContainer(doc));
  try
    result.Parent := BuildReportPanel;
    result.Parent.Width := wReport;
    result.Align := alClient;
    result.BorderStyle := bsNone;
    result.Visible := True;
    result.FAnalysis := self;
    result.FSubjectMarket := SubjectMarket;
    result.FAdjustments   := Adjustments;
    result.FCompSelection := CompSelection;
    if assigned(CompSelection) then
      result.CompGrid       := CompSelection.CompGrid;
    BuildReport := result;
  except
  end;
end;


procedure TAnalysis.FormShow(Sender: TObject);
begin
  FClose := False;
end;

procedure TAnalysis.FormDestroy(Sender: TObject);
begin
  FClose := True;
end;

procedure TAnalysis.FormClick(Sender: TObject);
begin
  FClose := True;
end;

procedure TAnalysis.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TAnalysis.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
