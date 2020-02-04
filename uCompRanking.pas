unit uCompRanking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzTrkBar, RzBckgnd, ExtCtrls, Tracker2, UMarketData,
  math, osAdvDbGrid,osSortLib;

type
  TCompRanking = class(TForm)
    PanelTitleRating: TPanel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzSeparator1: TRzSeparator;
    RzSeparator2: TRzSeparator;
    PanelProx: TPanel;
    StaticText2: TLabel;
    RzSeparator7: TRzSeparator;
    RzSeparator6: TRzSeparator;
    cbxDistInclude: TCheckBox;
    tbProx: TRzTrackBar;
    PanelSaleDate: TPanel;
    lblDate: TLabel;
    RzSeparator12: TRzSeparator;
    RzSeparator11: TRzSeparator;
    cbxSDateInclude: TCheckBox;
    tbSaleDate: TRzTrackBar;
    PanelGLA: TPanel;
    Label15: TLabel;
    RzSeparator17: TRzSeparator;
    RzSeparator16: TRzSeparator;
    cbxGLAInclude: TCheckBox;
    tbGLA: TRzTrackBar;
    PanelBGLA: TPanel;
    Label17: TLabel;
    RzSeparator22: TRzSeparator;
    RzSeparator21: TRzSeparator;
    cbxBsmtInclude: TCheckBox;
    tbBGLA: TRzTrackBar;
    PanelSite: TPanel;
    Label19: TLabel;
    RzSeparator27: TRzSeparator;
    RzSeparator26: TRzSeparator;
    cbxSiteInclude: TCheckBox;
    tbSite: TRzTrackBar;
    PanelAge: TPanel;
    Label22: TLabel;
    RzSeparator32: TRzSeparator;
    RzSeparator31: TRzSeparator;
    cbxAgeInclude: TCheckBox;
    tbAge: TRzTrackBar;
    PanelStory: TPanel;
    Label4: TLabel;
    RzSeparator4: TRzSeparator;
    RzSeparator5: TRzSeparator;
    cbxStoryInclude: TCheckBox;
    tbStory: TRzTrackBar;
    PanelBeds: TPanel;
    Label24: TLabel;
    RzSeparator37: TRzSeparator;
    RzSeparator36: TRzSeparator;
    cbxBedRmInclude: TCheckBox;
    tbBeds: TRzTrackBar;
    PanelBaths: TPanel;
    Label26: TLabel;
    RzSeparator42: TRzSeparator;
    RzSeparator41: TRzSeparator;
    cbxBathInclude: TCheckBox;
    tbBaths: TRzTrackBar;
    PanelFireplace: TPanel;
    Label28: TLabel;
    RzSeparator47: TRzSeparator;
    RzSeparator46: TRzSeparator;
    cbxFirePlInclude: TCheckBox;
    tbFirePl: TRzTrackBar;
    PanelCars: TPanel;
    Label31: TLabel;
    RzSeparator52: TRzSeparator;
    RzSeparator51: TRzSeparator;
    cbxCarInclude: TCheckBox;
    tbCars: TRzTrackBar;
    PanelPool: TPanel;
    Label33: TLabel;
    RzSeparator57: TRzSeparator;
    RzSeparator56: TRzSeparator;
    cbxPoolInclude: TCheckBox;
    tbPool: TRzTrackBar;
    Panel1: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    SliderProx: TTrackBar2;
    SliderSalesDate: TTrackBar2;
    SliderGLA: TTrackBar2;
    procedure SliderChange(Sender:TObject);
    procedure SliderGLAChange(Sender: TObject);
  private
    { Private declarations }
    FWtDist: Double;
    FWtSDate: Double;
    FWtGLA: Integer;
    FMinGLA: Integer;
    FMaxGLA: Integer;
    procedure CalcRanges;
    procedure CalcRanking;
  public
    { Public declarations }
    FSubjGLA: Integer;
    FMarketData: TMarketData;
  end;

var
  CompRanking: TCompRanking;

implementation

{$R *.dfm}
uses
  UCC_MLS_Globals, uUtil1;

const
  cProximity = 1;
  cSaleDate  = 2;
  cGLA       = 3;

//look for both grid to find min/max
procedure TCompRanking.CalcRanges;
const
  AMin = -1;
  AMax = 99999999;
var
  i, iCount: Integer;
  aDist: Double;
  aBedRm,aBath,aCar,aGLA,aSite,aFirePl,aBsmt,aAge,aPool,aStory: Integer;
  FSaleDays, FListDays: Integer;
  effDate, theSaleDate, theListDate: TDateTime;

  LMinDist, LMaxDist: Double;
  LMinSaleDays, LMaxSaleDays,
  LMinGLA, LMaxGLA,
  LMinBGLA, LMaxBGLA,
  LMinSite, LMaxSite,
  LMinAge, LMaxAge,
  LMinBedRms, LMaxBedRms,
  LMinBaths, LMaxBaths,
  LMinFirePl, LMaxFirePl,
  LMinCars, LMaxcars,
  LMinPool, LMaxPool,
  LMinStory, LMaxStory: Integer;
  LMinListDays, LMaxListDays: Integer;
begin
//  effDate := StrToDateDef(Appraisal.Recon.EffectiveDate, Date);

  //Set the min - max
(*
  FMinDist      := AMax;
  FMaxDist      := -1;
  FMinSaleDays  := AMax;
  FMaxSaleDays  := -1;
  FMinListDays  := AMax;  //github 509
  FMaxListDays  := -1;
*)
//FMinSalePrice := 99999999;
//FMaxSalePrice := -1;
  FMinGLA       := AMax;
  FMaxGLA       := -1;
(*
  FMinBGLA      := AMax;
  FMAXBGLA      := -1;
  FMinSite      := AMax;
  FMaxSite      := -1;
  FMinAge       := AMax;
  FMaxAge       := -1;
  FMinBedRms    := AMax;
  FMaxBedRms    := -1;
  FMinBaths     := AMax;
  FMaxBaths     := -1;
  FMinFirePl    := AMax;
  FMAXFirePl    := -1;
  FMinCars      := AMax;
  FMaxcars      := -1;
  FMinPool      := AMax;
  FMaxPool      := -1;
  FMinStory     := AMax;
  FMaxStory     := -1;

  //Set the min - max
  LMinDist      := AMax;
  LMaxDist      := -1;
  LMinSaleDays  := AMax;
  LMaxSaleDays  := -1;
  LMinListDays  := AMax;  //github 509
  LMaxListDays  := -1;    //github 509
//FMinSalePrice := 99999999;
//FMaxSalePrice := -1;
*)
  LMinGLA       := AMax;
  LMaxGLA       := -1;
(*
  LMinBGLA      := AMax;
  LMAXBGLA      := -1;
  LMinSite      := AMax;
  LMaxSite      := -1;
  LMinAge       := AMax;
  LMaxAge       := -1;
  LMinBedRms    := AMax;
  LMaxBedRms    := -1;
  LMinBaths     := AMax;
  LMaxBaths     := -1;
  LMinFirePl    := AMax;
  LMAXFirePl    := -1;
  LMinCars      := AMax;
  LMaxcars      := -1;
  LMinPool      := AMax;
  LMaxPool      := -1;
  LMinStory     := AMax;
  LMaxStory     := -1;
*)


  iCount := FMarketData.Grid.Rows;
  for i := 1 to iCount do
    begin
     //distance
(*
      aDist := GetFirstValue(FMarketData.Grid.Cell[_Dist,i]);
      If aDist > 0 then
        begin
          if aDist > FMaxDist then
            FMaxDist := aDist;
          if aDist <= FMinDist then
            FMinDist := aDist;
        end;

      //sale date
      if IsValidDateTime(PropGrid.Cell[_iSaleDate,i], theSaleDate) then
        begin
          FSaleDays := abs(DaysBetween(EffDate, theSaleDate));
          if FSaleDays > FMaxSaleDays then
            FMaxSaleDays := FSaleDays;
          if FSaleDays <= FMinSaleDays then
            FMinSaleDays := FSaleDays;
        end;
*)
      //GLA
      aGLA := GetFirstIntValue(FMarketData.Grid.Cell[_GLA,i]);
      if aGLA > 0 then
        begin
          if aGLA > FMaxGLA then
            FMaxGLA := aGLA;
          If (aGLA > 0) and (aGLA <= FMinGLA) then
            FMinGLA := aGLA;
        end;
(*
      //BedroomCount
      aBedRm := GetFirstIntValue(PropGrid.Cell[_iBedRms,i]);
      if aBedRm > 0 then
        begin
          if aBedRm > FMaxBedRms then
            FMaxBedRms := aBedRm;
          If (aBedRm > 0) and (aBedRm <= FMinBedRms) then
            FMinBedRms := aBedRm;
        end;

      //TotalBathCount
      aBath := GetFirstIntValue(PropGrid.Cell[_iBathF,i]) + GetFirstIntValue(PropGrid.Cell[_iBathH,i]);
      if aBath > 0 then
        begin
          if aBath > FMaxBaths then
            FMaxBaths := aBath;
          If (aBath > 0) and (aBath <= FMinBaths) then
            FMinBaths := aBath;
        end;

      //ActualAge
      aAge := GetFirstIntValue(PropGrid.Cell[_iAge,i]);
      if aAge >= 0 then
        begin
          if aAge > FMaxAge then
            FMaxAge := aAge;
          if (aAge <= FMinAge) then
            FMinAge := aAge;
        end;

      //GarageCarCount
      aCar := GetFirstIntValue(PropGrid.Cell[_iGarage,i]);
      if aCar >= 0 then
        begin
          if aCar > FMaxcars then
            FMaxcars := aCar;
          if (aCar <= FMinCars) then
            FMinCars := aCar;
        end;

      //SiteArea
      aSite := GetFirstIntValue(PropGrid.Cell[_iSiteArea,i]);
      if aSite > 0 then
        begin
          if aSite > FMaxSite then
            FMaxSite := aSite;
          If (aSite > 0) and (aSite <= FMinSite) then
            FMinSite := aSite;
        end;

      //BasementGLA
      aBsmt := GetFirstIntValue(PropGrid.Cell[_iBsmtGLA,i]);
      if aBsmt > FMAXBGLA then
        FMaxBGLA := aBsmt;
      if (aBsmt <= FMinBGLA) then
        FMinBGLA := aBsmt;

      //Fireplaces
      aFirePl := GetFirstIntValue(PropGrid.Cell[_iFirePlace,i]);
      if aFirePl > FMaxFirePl then
        FMaxFirePl := aFirePl;
      if (aFirePl <= FMinFirePl) then
        FMinFirePl := aFirePl;

      //Pools
      aPool := GetFirstIntValue(PropGrid.Cell[_iPool,i]);
      if aPool > FMaxPool then
        FMaxPool := aPool;
      if (aPool <= FMinPool) then
        FMinPool := aPool;

      //Story
      aStory := GetFirstIntValue(PropGrid.Cell[_iStories,i]);
      if aStory > FMaxStory then
        FMaxStory := aStory;
      if (aStory <= FMinStory) then
        FMinStory := aStory;
    end;
*)
  end;
end;


procedure TCompRanking.CalcRanking;
const
  NearnessMaxScore = 500;
  SimilarMaxScore  = 1000;
var
  i, iCount: Integer;
  aDist,radDist: Double;
  aPrice,aSaleDays,aBedRm,aBath,aCar,aGLA,aSite,aFirePl,aBsmt,aAge,aPool,aStory: Integer;
  radSDays, radGLA, radBGLA, radSite, radAge, radBedRm, radBaths, radFirePl: Integer;
  radCars, radPool, radStory: Integer;
  theSaleDate: TDateTime;
  effDate: TDateTime;
  WtSum, WtNearSum: Integer;
  FSaleDays,FStyleRank, FXtraWeight: Integer;          //holds days between sales date & eff date
  FScore,FNearnessScore, FSimilarScore, FDistScore,FSaleDateScore,FDOMScore,FGLAScore,FBsmtScore: Double;
  FBedScore,FBathScore,FFirePlScore,FCarScore,FPoolScore,FStyleScore,FSiteScore: Double;
  FAgeScore, FStoryScore: Double;
  Skip: Boolean;
begin
//  effDate := StrToDateDef(Appraisal.Recon.EffectiveDate, Date);

//  WtNearSum := FWtDist + FWtSDate;
//  WtSum :=  FWtGLA + FWtBGLA + FWtSite + FWtAge + FWtBeds + FWtBaths + FWtFirePl + FWtCars + FWtPool+ FWtStory;
  wtSum := FWtGLA;

  //do this once, find range
//  radDist   := abs(FMaxDist - FMinDist);
//  radSDays  := abs(FMaxSaleDays - FMinSaleDays);
  radGLA    := Max(abs(FMaxGLA - FSubjGLA), abs(FMinGLA - FSubjGLA));
(*
  radBGLA   := Max(abs(FMaxBGLA - FSubjBGLA), abs(FMinBGLA - FSubjBGLA));
  radSite   := Max(abs(FMaxSite - FSubjSite), abs(FMinSite - FSubjSite));
  radAge    := Max(abs(FMaxAge - FSubjAge), abs(FMinAge - FSubjAge));
  radBedRm  := Max(abs(FMaxBedRms - FSubjBedRms), abs(FMinBedRms - FSubjBedRms));
  radBaths  := Max(abs(FMaxBaths - FSubjBaths), abs(FMinBaths - FSubjBaths));
  radFirePl := Max(abs(FMaxFirePl - FSubjFirePl), abs(FMinFirePl - FSubjFirePl));
  radCars   := Max(abs(FMaxCars - FSubjCars), abs(FMinCars - FSubjCars));
  radPool   := Max(abs(FMaxPool - FSubjPool), abs(FMinPool - FSubjPool));
  radStory  := Max(abs(FMaxStory - FSubjStory), abs(FMinStory - FSubjStory));
*)
  iCount := FMarketData.Grid.Rows;
  skip := False;
  for i := 1 to iCount do
    begin
      //if FMarketData.Grid.CellCheckBoxState[_MKTInclude, i] = cbUnchecked then
      //  skip := True;
//      if (FMarketData.Grid.CellCheckBoxState[_Include, i] = cbChecked) {and not skip}  then
//      begin  //if included we always want to do the calculate ranking

        //distance
        (*
        FDistScore := 0;
        if cbxDistInclude.checked then begin
          aDist := GetFirstValue(PropGrid.cell[_iDist, i]) - FMinDist;   //ditto
          if radDist > 0 then
            FDistScore  := Round(((radDist - aDist)/radDist) * NearnessMaxScore);
        end;


        //sale date
        FSaleDateScore := 0;
        if cbxSDateInclude.checked then
          if pos(UpperCase(PropGrid.cell[_iCompTyp, i]), UpperCase(typSale)) >0 then begin                 //score only Sales
            FSaleDays := 0;
            if IsValidDateTime(PropGrid.Cell[_iSaleDate,i], theSaleDate) then
              FSaleDays := abs(DaysBetween(EffDate, theSaleDate));
            aSaleDays := FSaleDays - FMinSaleDays;
            if radSDays > 0 then
              FSaleDateScore := Round(((radSDays - aSaleDays)/radSDays) * NearnessMaxScore);
          end;
        *)
        //GLA
        FGLAScore := 0;
        if cbxGLAInclude.checked then begin
          aGLA := GetFirstIntValue(FMarketData.Grid.cell[_GLA, i]);
          aGLA := abs(FSubjGLA - aGLA);
          if radGLA > 0 then
            FGLAScore := Round(((radGLA - aGLA)/radGLA));
         end;
(*
        //BasementGLA
        FBsmtScore := 0;
        if cbxBsmtInclude.checked then begin
          aBsmt := GetFirstIntValue(PropGrid.cell[_iBsmtGLA, i]);
          aBsmt := abs(FSubjBGLA - aBsmt);
          if radBGLA > 0 then
            FBsmtScore := Round(((radBGLA - aBsmt)/radBGLA) * SimilarMaxScore);
        end;

        //SiteArea
        FSiteScore := 0;
        if cbxSiteInclude.checked then begin
          aSite := GetFirstIntValue(PropGrid.cell[_iSiteArea, i]);
          aSite := abs(FSubjSite - aSite);
          if radSite > 0 then
            FSiteScore :=  Round(((radSite - aSite)/radSite) * SimilarMaxScore);
        end;

        //ActualAge
        FAgeScore := 0;
        if cbxAgeInclude.checked then begin
          aAge := GetFirstIntValue(PropGrid.cell[_iAge, i]);
          aAge := abs(FSubjAge - aAge);
          if radAge > 0 then
            FAgeScore := Round(((radAge - aAge)/radAge) * SimilarMaxScore);
        end;

        //BedroomCount
        FBedScore := 0;
        if cbxBedRmInclude.checked then begin
          aBedRm := GetFirstIntValue(PropGrid.cell[_iBedRms, i]);
          aBedRm := abs(FSubjBedRms - aBedRm);
          if radBedRm > 0 then
            FBedScore := Round(((radBedRm - aBedRm)/radBedRm) * SimilarMaxScore);
        end;

        //TotalBathCount
        FBathScore := 0;
        if cbxBathInclude.checked then begin
          aBath := GetFirstIntValue(PropGrid.cell[_iBathF, i])+GetFirstIntValue(PropGrid.cell[_iBathH, i]);
          aBath := abs(FSubjBaths - aBath);
          if radBaths > 0 then
            FBathScore := Round(((radBaths - aBath)/radBaths) * SimilarMaxScore);
        end;

        //FireplacesCount
        FFirePlScore := 0;
        if cbxFirePlInclude.checked then begin
          aFirePl := GetFirstIntValue(PropGrid.cell[_iFirePlace, i]);
          aFirePl := abs(FSubjFirePl - aFirePl);
          if radFirePl > 0 then
            FFirePlScore := Round(((radFirePl - aFirePl)/radFirePl) * SimilarMaxScore);
        end;

        //GarageCarCount
        FCarScore := 0;
        if cbxCarInclude.checked then begin
          aCar := GetFirstIntValue(PropGrid.cell[_iGarage, i]);
          aCar := abs(FSubjCars - aCar);
          if radCars > 0 then
            FCarScore := Round(((radCars - aCar)/radCars) * SimilarMaxScore);
        end;

        FPoolScore := 0;
        if cbxPoolInclude.Checked then begin
          aPool := GetFirstIntValue(PropGrid.cell[_iPool, i]);
          aPool := abs(FSubjPool - aPool);
          if radPool > 0 then
            FPoolScore := Round(((radPool - aPool)/radPool) * SimilarMaxScore);
        end;

        FStoryScore := 0;
        if cbxStoryInclude.Checked then begin
          aStory := GetFirstIntValue(PropGrid.cell[_iStories, i]);
          aStory := abs(FSubjStory - aStory);
          if radStory > 0 then
            FStoryScore := Round(((radStory - aStory)/radStory) * SimilarMaxScore);
        end;

        //Style score
        FStyleScore := 0;

        FXtraWeight := GetFirstIntValue(PropGrid.cell[_iWeightAmt, i]);

        //rate the nearness of the sale to the subject
        FNearnessScore  := 0;
        if FWtDist > 0 then
          FNearnessScore := (FWtDist/WtNearSum) * FDistScore;
        if FWtSDate > 0 then
          FNearnessScore := FNearnessScore + (FWtSDate/WtNearSum) * FSaleDateScore;
*)
        //rate the similarity of the sale to the subject
        FSimilarScore   := 0;
        if FWtGLA > 0 then
          FSimilarScore := FSimilarScore + (FWtGLA/WtSum) * FGLAScore;
(*
        if FWtBGLA > 0 then
          FSimilarScore := FSimilarScore + (FWtBGLA/WtSum) * FBsmtScore;
        if FWtSite > 0 then
          FSimilarScore := FSimilarScore + (FWtSite/WtSum) * FSiteScore;
        if FWtAge > 0 then
          FSimilarScore := FSimilarScore + (FWtAge/WtSum) * FAgeScore;
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
        if FWtStory > 0 then
          FSimilarScore := FSimilarScore + (FWtStory/WtSum) * FStoryScore;
*)
        FScore := FNearnessScore + FSimilarScore; // + FXtraWeight;

        FMarketData.Grid.Cell[_Rank, i]  := Round(FScore);
(*
        PropGrid.Cell[_iScoreDist,i]  := Round(FDistScore);
        PropGrid.Cell[_iScoreSDate,i] := Round(FSaleDateScore);
        PropGrid.Cell[_iScoreGLA,i]   := Round(FGLAScore);
        PropGrid.Cell[_iScoreBGLA,i]  := Round(FBsmtScore);
        PropGrid.Cell[_iScoreSite,i]  := Round(FSiteScore);
        PropGrid.Cell[_iScoreAge,i]   := Round(FNearnessScore);
        PropGrid.Cell[_iScoreBeds,i]  := Round(FBedScore);
        PropGrid.Cell[_iScoreBath,i]  := Round(FBathScore);
        PropGrid.Cell[_iScoreFlPl,i]  := Round(FFirePlScore);
        PropGrid.Cell[_iScoreCar,i]   := Round(FCarScore);
        PropGrid.Cell[_iScorePool,i]  := Round(FPoolScore);
        PropGrid.Cell[_iScoreStory,i] := Round(FStoryScore);

        PropGrid.Cell[_iScoreORank,i] := Round(FScore + FXtraWeight);   //IMPORTANT: remember the score here so we can increment with extra Wt.
*)
//    end
(*
  else  //if not included, set the scores to zero
    begin
      FMarketData.Grid.Cell[_Rank, i]  := 0;

      PropGrid.Cell[_iScoreDist,i]  := 0;
      PropGrid.Cell[_iScoreSDate,i] := 0;
      PropGrid.Cell[_iScoreGLA,i]   := 0;
      PropGrid.Cell[_iScoreBGLA,i]  := 0;
      PropGrid.Cell[_iScoreSite,i]  := 0;
      PropGrid.Cell[_iScoreAge,i]   := 0;
      PropGrid.Cell[_iScoreBeds,i]  := 0;
      PropGrid.Cell[_iScoreBath,i]  := 0;
      PropGrid.Cell[_iScoreFlPl,i]  := 0;
      PropGrid.Cell[_iScoreCar,i]   := 0;
      PropGrid.Cell[_iScorePool,i]  := 0;
      PropGrid.Cell[_iScoreStory,i] := 0;
      PropGrid.Cell[_iScoreORank,i] := 0;

    end;
*)
  end;

//  FRanked := True;    //a ranking has been performed
end;


procedure TCompRanking.SliderChange(Sender:TObject);
var
  index, Lweight,Hweight: Integer;
begin
  index    := (sender as TTrackBar2).Tag;
  Lweight  := (sender as TTrackBar2).PositionL;
  Hweight  := (sender as TTrackBar2).PositionU;
  case index of
//    cProximity:   FWtDist   := weight;
//    cSaleDate:    FWtSDate  := weight;
    cGLA: FWtGLA := Round(Hweight - Lweight);
(*
    cBGLA:        FWtBGLA   := weight;
    cSite:        FWtSite   := weight;
    cAge:         FWtAge    := weight;
    cBedrooms:    FWtBeds   := weight;
    cBaths:       FWtBaths  := weight;
    cFirePl:      FWtFirePl := weight;
    cCars:        FWtCars   := weight;
    cPool:        FWtPool   := weight;
    cStory:       FWtStory  := weight;
*)
  end;
  CalcRanges;
//  CalcRanking2;   //github 467: use seperate calcRanking for sales and listing
//  clearCompWts(Grid);   //github 494: when user slide left/right, clear the wts.
  CalcRanking;
  FMarketData.Grid.SortOnCol(_Rank, stDescending, True);
//  HighlightClickedRows(Grid);
//  FSaleModified := True;
end;



procedure TCompRanking.SliderGLAChange(Sender: TObject);
begin
  SliderChange(Sender);
end;

end.
