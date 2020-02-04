unit UMathResid3;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2008 by Bradford Technologies, Inc. }
{  This is unit for the Appraisal Institute forms }


interface

uses
  UGlobals, UContainer;

const
  fmAI_SiteValuation                = 374;
  fmAI_MarketAnalysis               = 372;
  fmAI_Improvements                 = 373;
  fmAI_CostApproach                 = 376;
  fmAI_IncomeApproach               = 377;
  fmAI_SalesApproach                = 378;
  fmAI_XComps                       = 391;
  fmAI_XRental                      = 392;
  fmAI_XSites                       = 393;
  fmAI_PhotoComps                   = 388;
  fmAI_PhotoSites                   = 389;
  fmAI_PhotoRentals                 = 390;
  fmAI_Map                          = 383;
  fmAI_Exhibit                      = 384;
  fmAI_Comments                     = 382;
  fmAI_LandSummary                  = 848;
  fmAI_LandMktAnalysis              = 1303;
  fmAI_LandSiteVal                  = 1304;
  fmAI_RestrictedUse                = 847;
  fmAI_ResUseMktAnalysis            = 1307;
  fmAI_ResUseImpAnalysis            = 1308;
  fmAI_ResUseSiteEval               = 1309;
  fmAI_ResUseCostApproach           = 1310;
  fmAI_ResUseIncomeApproach         = 1311;
  fmAI_ResUseSalesComp              = 1312;
  fmAI_ResidentialSummary           = 846;
  fmAI_SumMktAnalysis               = 1315;
  fmAI_SumImpAnalysis               = 1316;
  fmAI_SumSiteEval                  = 1317;
  fmAI_SumCostApproach              = 1318;
  fmAI_SumIncomeApproach            = 1319;
  fmAI_SumSalesComp                 = 1320;
  fmAI_ResSumXComps                 = 939;
  fmAI_ResSumXRental                = 940;
  fmAI_ResSumXSites                 = 941;
  fmAI_LiquidValue                  = 921;

  fmAI_CostApproach_1323            = 1323;     //Ticket #1342: AI math
  fmAI_AIRestricted_1321            = 1321;     //Ticket #1342: AI math
  fmAI_AIResidential_1322           = 1322;     //Ticket #1342: AI math
  fmAI_CostApproach_1324            = 1324;     //Ticket #1342: AI math
  fmAI_AILandSummary_1325           = 1325;     //Ticket #1342: AI math
  fmAI_ExtraComp_1328               = 1328;     //Ticket #1342: mimic form 941 with more cells in transfer section


  function ProcessForm0374Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0373Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0376Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0372Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0377Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0378Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0382Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0383Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0384Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0391Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0392Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0393Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0388Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0389Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0390Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0848Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1303Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1304Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0847Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1307Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1308Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1309Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1310Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1311Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1312Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0846Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1315Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1316Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1317Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1318Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1319Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1320Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0939Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0940Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0941Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0921Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //Ticket #1342 Add new maths for new AI forms
  function ProcessForm1323Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1321Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1322Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1324Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1325Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1328Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


//calc functional depr
function CalcDeprLessPhy(doc: TContainer; CX: CellUID; V1, V2, V3: Double): Double;
var
  VR: double;
begin
  result := 0;
//  V1 = funct depr percent
//  V2 = new cost
//  V3 = Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := VR;
    end;
end;


function F0374C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 34;
  AcrePrice = 35;
  TotalAdj  = 58;
  FinalAmt  = 59;
  PlusChk   = 56;
  NegChk    = 57;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,37), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,39), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,41), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,43), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,45), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,47), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,49), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0846SiteValuationC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0846SiteValuationC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0846SiteValuationC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1317SiteValuationC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1317SiteValuationC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1317SiteValuationC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0374C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 65;
  AcrePrice = 66;
  TotalAdj  = 89;
  FinalAmt  = 90;
  PlusChk   = 87;
  NegChk    = 88;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,80), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,82), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,84), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,86), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0374C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 96;
  AcrePrice = 97;
  TotalAdj  = 120;
  FinalAmt  = 121;
  PlusChk   = 118;
  NegChk    = 119;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;


function F0377C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 45,74,75,72,73,2,3,
            [47,49,51,53,55,57,59,61,63,65,67,69,71]);
end;

function F0846IncomeAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 46,77,78,75,76,1,2,
            [48,50,52,54,56,58,60,62,64,66,68,70,72,74]);
end;

function F0940IncomeAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 48,79,80,77,78,1,2,
            [50,52,54,56,58,60,62,64,66,68,70,72,74,76]);
end;

function F0847IncomeAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 46,77,78,75,76,1,2,
            [48,50,52,54,56,58,60,62,64,66,68,70,72,74]);
end;

function F0377C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 90,119,120,117,118,4,5,
            [92,94,96,98,100,102,104,106,108,110,112,114,116]);
end;

function F0846IncomeAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 93,124,125,122,123,3,4,
            [95,97,99,101,103,105,107,109,111,113,115,117,119,121]);
end;

function F0940IncomeAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 96,127,128,125,126,3,4,
            [98,100,102,104,106,108,110,112,114,116,118,120,122,124]);
end;

function F0847IncomeAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 93,124,125,122,123,3,4,
            [95,97,99,101,103,105,107,109,111,113,115,117,119,121]);
end;

function F0377C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 135,164,165,162,163,6,7,
            [137,139,141,143,145,147,149,151,153,155,157,159,161]);
end;

function F0846IncomeAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 140,171,172,169,170,5,6,
            [142,144,146,148,150,152,154,156,158,160,162,164,166,168]);
end;

function F0940IncomeAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 144,175,176,173,174,5,6,
            [146,148,150,152,154,156,158,160,162,164,166,168,170,172]);
end;

function F0847IncomeAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 140,171,172,169,170,5,6,
            [142,144,146,148,150,152,154,156,158,160,162,164,166,168]);
end;

function F0378C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 45,100,101,98,99,3,4,
            [53,55,57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97]);
end;

function F0846SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 50,104,105,102,103,1,2,
            [57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F0847SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 50,104,105,102,103,1,2,
            [57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F0939SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 52,106,107,104,105,1,2,
            [59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,103]);
end;

function F1328SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 52,106,107,104,105,1,2,
            [59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,103]);
end;


function F1309SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 35,59,60,57,58,1,2,
            [38,40,42,44,46,48,50,52,54,56]);
end;

function F1312SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 50,104,105,102,103,1,2,
            [57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F0378C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 106,161,162,159,160,5,6,
            [114,116,118,120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158]);
end;

function F0846SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 113,167,168,165,166,3,4,
            [120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164]);
end;

function F0847SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 113,167,168,165,166,3,4,
            [120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164]);
end;

function F0939SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 116,170,171,168,169,3,4,
            [123,125,127,129,131,133,135,137,139,141,143,145,147,149,151,153,155,157,159,161,163,165,167]);
end;

function F1328SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 116,170,171,168,169,3,4,
            [123,125,127,129,131,133,135,137,139,141,143,145,147,149,151,153,155,157,159,161,163,165,167]);
end;


function F1309SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 66,90,91,88,89,3,4,
            [69,71,73,75,77,79,81,83,85,87]);
end;

function F1312SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 113,167,168,165,166,3,4,
            [120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164]);
end;

function F0378C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 167,222,223,220,221,7,8,
            [175,177,179,181,183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219]);
end;

function F0846SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 176,230,231,228,229,5,6,
            [183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227]);
end;

function F0847SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 176,230,231,228,229,5,6,
            [183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227]);
end;

function F0939SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 180,234,235,232,233,5,6,
            [187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227,229,231]);
end;

function F1328SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 180,234,235,232,233,5,6,
            [187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227,229,231]);
end;


function F1309SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 97,121,122,119,120,5,6,
            [100,102,104,106,108,110,112,114,116,118]);
end;

function F1312SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 176,230,231,228,229,5,6,
            [183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227]);
end;

function F0391C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 47,102,103,100,101,3,4,
           [55,57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99]);
end;

function F0391C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 109,164,165,162,163,5,6,
            [117,119,121,123,125,127,129,131,133,135,137,139,141,143,145,147,149,151,153,155,157,159,161]);
end;

function F0391C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
   result := SalesGridAdjustment(doc, CX, 171,226,227,224,225,7,8,
             [179,181,183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223]);
end;

function F0392C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 47,76,77,74,75,2,3,
           [49,51,53,55,57,59,61,63,65,67,69,71,73]);
end;

function F0392C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 93,122,123,120,121,4,5,
            [95,97,99,101,103,105,107,109,111,113,115,117,119]);
end;

function F0392C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
   result := SalesGridAdjustment(doc, CX, 139,168,169,166,167,6,7,
             [141,143,145,147,149,151,153,155,157,159,161,163,165]);
end;

function F0393C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 36;
  AcrePrice = 37;
  TotalAdj  = 60;
  FinalAmt  = 61;
  PlusChk   = 58;
  NegChk    = 59;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,39), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,41), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,43), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,45), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,47), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,49), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0393C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 68;
  AcrePrice = 69;
  TotalAdj  = 92;
  FinalAmt  = 93;
  PlusChk   = 90;
  NegChk    = 91;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0393C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 100;
  AcrePrice = 101;
  TotalAdj  = 124;
  FinalAmt  = 125;
  PlusChk   = 122;
  NegChk    = 123;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0941C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
  AcrePrice = 38;
  TotalAdj  = 61;
  FinalAmt  = 62;
  PlusChk   = 59;
  NegChk    = 60;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0941C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 69;
  AcrePrice = 70;
  TotalAdj  = 93;
  FinalAmt  = 94;
  PlusChk   = 91;
  NegChk    = 92;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,80), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,82), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,84), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,86), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,88), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0941C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 101;
  AcrePrice = 102;
  TotalAdj  = 125;
  FinalAmt  = 126;
  PlusChk   = 123;
  NegChk    = 124;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0848C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0848C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0848C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1304C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1304C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1304C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F1311C1IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 46;
  TotalAdj  = 77;
  FinalAmt  = 78;
  PlusChk   = 75;
  NegChk    = 76;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1311C2IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 93;
  TotalAdj  = 124;
  FinalAmt  = 125;
  PlusChk   = 122;
  NegChk    = 123;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1311C3IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 140;
  TotalAdj  = 171;
  FinalAmt  = 172;
  PlusChk   = 169;
  NegChk    = 170;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0940C1IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 48;
  TotalAdj  = 79;
  FinalAmt  = 80;
  PlusChk   = 77;
  NegChk    = 78;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0940C2IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 96;
  TotalAdj  = 127;
  FinalAmt  = 128;
  PlusChk   = 125;
  NegChk    = 126;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0940C3IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 144;
  TotalAdj  = 175;
  FinalAmt  = 176;
  PlusChk   = 173;
  NegChk    = 174;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C1SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C2SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C3SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C1IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 46;
  TotalAdj  = 77;
  FinalAmt  = 78;
  PlusChk   = 75;
  NegChk    = 76;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C2IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 93;
  TotalAdj  = 124;
  FinalAmt  = 125;
  PlusChk   = 122;
  NegChk    = 123;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F0847C3IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 140;
  TotalAdj  = 171;
  FinalAmt  = 172;
  PlusChk   = 169;
  NegChk    = 170;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1309C1SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1309C2SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1309C3SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;
(*
function F1312C1SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  AcrePrice = 36;
  TotalAdj  = 59;
  FinalAmt  = 60;
  PlusChk   = 57;
  NegChk    = 58;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;


function F1312C2SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 90;
  FinalAmt  = 91;
  PlusChk   = 88;
  NegChk    = 89;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1312C3SiteAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  AcrePrice = 98;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
    saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
    saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;
*)


//calc functional depr
function F0376CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,32));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,33), VR);
    end;
end;

//calc functional depr
function F0846CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,32));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,33), VR);
    end;
end;

//calc functional depr
function F0847CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,32));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,33), VR);
    end;
end;

//calc external depr
function F0376CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,34));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,33));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,35), VR);
    end;
end;

//calc external depr
function F0846CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,34));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,33));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,35), VR);
    end;
end;

//calc external depr
function F0847CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,34));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,29));    //new cost
  V3 := GetCellValue(doc, mcx(cx,31));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,33));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,35), VR);
    end;
end;

function F1319C1IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 46;
  TotalAdj  = 77;
  FinalAmt  = 78;
  PlusChk   = 75;
  NegChk    = 76;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1319C2IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 93;
  TotalAdj  = 124;
  FinalAmt  = 125;
  PlusChk   = 122;
  NegChk    = 123;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents

  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;

function F1319C3IncomeAdjs(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 140;
  TotalAdj  = 171;
  FinalAmt  = 172;
  PlusChk   = 169;
  NegChk    = 170;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), (saleValue + NetAdj));  //set final adj price
end;



function ProcessForm0372Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
         2:
            Cmd := SiteDimension(doc, CX, MCX(cx,47));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0373Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            cmd := SumABC(doc, mcx(cx,79), mcx(CX,90), mcx(CX,102), mcx(cx,107));
         2:
            cmd := SumABC(doc, mcx(cx,80), mcx(cx,91), mcx(cx,103), mcx(cx,108));
         3:
            cmd := SumABC(doc, mcx(cx,83), mcx(cx,94), mcx(cx,106), mcx(cx,109));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0374Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F0374C1Adjustments(doc, cx);
        2:
          Cmd := F0374C2Adjustments(doc, cx);
        3:
          Cmd := F0374C3Adjustments(doc, cx);
        4:
          Cmd := CalcWeightedAvg(doc, [846,847,848,374,393]);   //calc wtAvg of main and xcomps forms
        5:
          Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,16), mcx(CX,14));
        6:
          Cmd := DivideAB(doc, mcx(cx,34), mcx(CX,40), mcx(CX,35));
        7:
          Cmd := DivideAB(doc, mcx(cx,65), mcx(CX,71), mcx(CX,66));
        8:
          Cmd := DivideAB(doc, mcx(cx,96), mcx(CX,102), mcx(CX,97));
        9:
          Cmd := ProcessMultipleCmds(ProcessForm0374Math, doc, CX,[1,6]);
       10:
          Cmd := ProcessMultipleCmds(ProcessForm0374Math, doc, CX,[2,7]);
       11:
          Cmd := ProcessMultipleCmds(ProcessForm0374Math, doc, CX,[3,8]);
       12:
          begin                              //Math ID 12 is for Weighted Average
            F0374C1Adjustments(doc, cx);     //sum of adjs
            F0374C2Adjustments(doc, cx);     //sum of adjs
            F0374C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0374Math(doc, 1, CX);
          ProcessForm0374Math(doc, 2, CX);
          ProcessForm0374Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0374Math(doc, 12, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0376Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
         2:
            cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
         3:
            cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
         4:
            cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
         5:
            cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
         6:
            cmd := SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);
         8:
            Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,30),mcx(cx,31));         //phy dep precent entered
         9:
            cmd := F0376CalcDeprLessPhy(doc, cx);                                 //funct depr entered
         10:
            cmd := F0376CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
         11:
            cmd := SumABC(doc, mcx(cx,31), mcx(cx,33), mcx(cx,35), mcx(cx,36));   //sum depr
         12:
            cmd := SubtAB(doc, MCX(cx,29), mcx(cx,36), mcx(cx,37));     //depr value of improvements
         13:
            cmd := SumCellArray(doc, cx, [37,38,40,42,44,45], 46);
         14:
            cmd := RoundByValR(doc, cx, 46, 49, 500);
         15:
            cmd := ProcessMultipleCmds(ProcessForm0376Math, doc, CX,[8,9,10,12]);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0377Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            cmd := SubtABCD(doc, mcx(cx,38), mcx(cx,40), mcx(cx,42), mcx(cx,44), mcx(CX,45));
         2,3:
            Cmd := F0377C1Adjustments(doc, cx);
         4:
            cmd := SubtABCD(doc, mcx(cx,83), mcx(cx,85), mcx(cx,87), mcx(cx,89), mcx(CX,90));
         5,6:
            Cmd := F0377C2Adjustments(doc, cx);
         7:
            cmd := SubtABCD(doc, mcx(cx,128), mcx(cx,130), mcx(cx,132), mcx(cx,134), mcx(CX,135));
         8,9:
            Cmd := F0377C3Adjustments(doc, cx);
         10:
            cmd := MultAB(doc, mcx(cx,193), mcx(CX,194), mcx(CX,195));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0378Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            Cmd := DivideABPercent(doc, mcx(cx,9), mcx(CX,8), mcx(CX,10));
         2:
            Cmd := DivideAB(doc, mcx(cx,9), mcx(CX,26), mcx(CX,13));
         3:
            Cmd := ProcessMultipleCmds(ProcessForm0378Math, doc, CX,[2,1]);
         4:
            Cmd := DivideABPercent(doc, mcx(cx,45), mcx(CX,44), mcx(CX,46));
         5:
            Cmd := DivideAB(doc, mcx(cx,45), mcx(CX,76), mcx(CX,49));
         6:
            Cmd := ProcessMultipleCmds(ProcessForm0378Math, doc, CX,[5,4,7]);
         7:
            Cmd := F0378C1Adjustments(doc, cx);
         9:
            Cmd := DivideABPercent(doc, mcx(cx,106), mcx(CX,105), mcx(CX,107));
         10:
            Cmd := DivideAB(doc, mcx(CX,106), mcx(CX,137), mcx(CX,110));
         11:
            Cmd := ProcessMultipleCmds(ProcessForm0378Math, doc, CX,[10,9,12]);
         12:
            Cmd := F0378C2Adjustments(doc, cx);
         14:
            Cmd := DivideABPercent(doc, mcx(CX,167), mcx(CX,166), mcx(CX,168));
         15:
            Cmd := DivideAB(doc, mcx(CX,167), mcx(CX,198), mcx(CX,171));
         16:
            Cmd := ProcessMultipleCmds(ProcessForm0378Math, doc, CX,[15,14,17]);
         17:
            Cmd := F0378C3Adjustments(doc, cx);
         18:
            Cmd := CalcWeightedAvg(doc, [846,847,378,391]);   //calc wtAvg of main and xcomps forms
         19:
          begin                              //Math ID 18 is for Weighted Average
            F0378C1Adjustments(doc, cx);     //sum of adjs
            F0378C2Adjustments(doc, cx);     //sum of adjs
            F0378C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0378Math(doc, 1, CX);
          ProcessForm0378Math(doc, 2, CX);
          ProcessForm0378Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0378Math(doc, 19, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0391Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,11));
         2:
            Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,27), mcx(CX,14));
         3:
            Cmd := ProcessMultipleCmds(ProcessForm0391Math, doc, CX,[2,1]);
         4:
            Cmd := DivideABPercent(doc, mcx(cx,47), mcx(CX,46), mcx(CX,48));
         5:
            Cmd := DivideAB(doc, mcx(CX,47), mcx(CX,78), mcx(CX,51));
         6:
            Cmd := ProcessMultipleCmds(ProcessForm0391Math, doc, CX,[5,4,7]);
         7:
            Cmd := F0391C1Adjustments(doc, cx);
         9:
            Cmd := DivideABPercent(doc, mcx(cx,109), mcx(CX,108), mcx(CX,110));
         10:
            Cmd := DivideAB(doc, mcx(CX,109), mcx(CX,140), mcx(CX,113));
         11:
            Cmd := ProcessMultipleCmds(ProcessForm0391Math, doc, CX,[10,9,12]);
         12:
            Cmd := F0391C2Adjustments(doc, cx);
         14:
            Cmd := DivideABPercent(doc, mcx(CX,171), mcx(CX,170), mcx(CX,172));
         15:
            Cmd := DivideAB(doc, mcx(CX,171), mcx(CX,202), mcx(CX,175));
         16:
            Cmd := ProcessMultipleCmds(ProcessForm0391Math, doc, CX,[15,14,17]);
         17:
            Cmd := F0391C3Adjustments(doc, cx);

        //dynamic form name
         20:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 42,104,166);
         19:
            cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 42,104,166, 2);
         21:
            cmd := ConfigXXXInstance(doc, cx, 42,104,166);

        //calc wtAvg of main and xcomps forms
         22:
            Cmd := CalcWeightedAvg(doc, [846,847,378,391]);
         23:
          begin                              //Math ID 23 is for Weighted Average
            F0391C1Adjustments(doc, cx);     //sum of adjs
            F0391C2Adjustments(doc, cx);     //sum of adjs
            F0391C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0391Math(doc, 1, CX);
          ProcessForm0391Math(doc, 2, CX);
          ProcessForm0391Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0391Math(doc, 23, CX);
        end;
    end;
  result := 0;
end;



function ProcessForm0392Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
            cmd := SubtABCD(doc, mcx(cx,40), mcx(cx,42), mcx(cx,44), mcx(cx,46), mcx(CX,47));
         2,3:
            Cmd := F0392C1Adjustments(doc, cx);
         4:
            cmd := SubtABCD(doc, mcx(cx,86), mcx(cx,88), mcx(cx,90), mcx(cx,92), mcx(CX,93));
         5,6:
            Cmd := F0392C2Adjustments(doc, cx);
         7:
            cmd := SubtABCD(doc, mcx(cx,132), mcx(cx,134), mcx(cx,136), mcx(cx,138), mcx(CX,139));
         8,9:
            Cmd := F0392C3Adjustments(doc, cx);

           //dynamic form name
         11:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 32,78,124);
         10:
            cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS','', 32,78,124, 2);
         12:
            cmd := ConfigXXXInstance(doc, cx, 32,78,124);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;






function ProcessForm0393Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F0393C1Adjustments(doc, cx);
        2:
          Cmd := F0393C2Adjustments(doc, cx);
        3:
          Cmd := F0393C3Adjustments(doc, cx);
        4:
          Cmd := CalcWeightedAvg(doc, [846,847,848,374,393]);   //calc wtAvg of main and xcomps forms
        5:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(CX,17), mcx(CX,15));
        6:
          Cmd := DivideAB(doc, mcx(CX,36), mcx(CX,42), mcx(CX,37));
        7:
          Cmd := DivideAB(doc, mcx(cx,68), mcx(CX,74), mcx(CX,69));
        8:
          Cmd := DivideAB(doc, mcx(cx,100), mcx(CX,106), mcx(CX,101));
        9:
          Cmd := ProcessMultipleCmds(ProcessForm0393Math, doc, CX,[1,6]);
        10:
          Cmd := ProcessMultipleCmds(ProcessForm0393Math, doc, CX,[2,7]);
        11:
          Cmd := ProcessMultipleCmds(ProcessForm0393Math, doc, CX,[3,8]);
               //dynamic form name
        13:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Sites', 30,62,94);
        12:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA SITES','', 30,62,94, 2);
        14:
          cmd := ConfigXXXInstance(doc, cx, 30,62,94);


        15:
          begin                              //Math ID 15 is for Weighted Average
            F0393C1Adjustments(doc, cx);     //sum of adjs
            F0393C2Adjustments(doc, cx);     //sum of adjs
            F0393C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0393Math(doc, 1, CX);
          ProcessForm0393Math(doc, 2, CX);
          ProcessForm0393Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0393Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0388Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
           //dynamic form name
         1:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Comparables', 7,11,15);
         2:
            cmd := SetXXXPageTitle(doc, cx, 'COMPARABLES','PHOTO COMPARABLES',7,11,15, 2);
         3:
            cmd := ConfigPhotoXXXInstance(doc, cx, 7,11,15);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0389Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
           //dynamic form name
         1:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Sites', 7,11,15);
         2:
            cmd := SetXXXPageTitle(doc, cx, 'SITES','PHOTO SITES',7,11,15, 2);
         3:
            cmd := ConfigPhotoXXXInstance(doc, cx, 7,11,15);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm0390Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
           //dynamic form name
         1:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Rentals', 7,11,15);
         2:
            cmd := SetXXXPageTitle(doc, cx, 'RENTALS','PHOTO RENTALS',7,11,15, 2);
         3:
            cmd := ConfigPhotoXXXInstance(doc, cx, 7,11,15);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0383Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0384Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0382Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0848Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F0848C1Adjustments(doc, cx);
        2:
          Cmd := F0848C2Adjustments(doc, cx);
        3:
          Cmd := F0848C3Adjustments(doc, cx);
        4:
          Cmd := CalcWeightedAvg(doc, [848,374,393]);   //calc wtAvg of main and xcomps forms
        5:
          Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6:
          Cmd := DivideAB(doc, mcx(CX,35), mcx(CX,41), mcx(CX,36));
        7:
          Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8:
          Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9:
          Cmd := ProcessMultipleCmds(ProcessForm0848Math, doc, CX,[1,6]);
        10:
          Cmd := ProcessMultipleCmds(ProcessForm0848Math, doc, CX,[2,7]);
        11:
          Cmd := ProcessMultipleCmds(ProcessForm0848Math, doc, CX,[3,8]);
        12:
          Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
        13:
          Cmd := SiteDimension(doc, CX, MCX(cx,47));
        14:
          begin                              //Math ID 14 is for Weighted Average
            F0848C1Adjustments(doc, cx);     //sum of adjs
            F0848C2Adjustments(doc, cx);     //sum of adjs
            F0848C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0848Math(doc, 1, CX);
          ProcessForm0848Math(doc, 2, CX);
          ProcessForm0848Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0848Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0847Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Site Evaluation -----------------------------------------------------------------------
        1: Cmd := F0847C1SiteAdjs(doc, cx);
        2: Cmd := F0847C2SiteAdjs(doc, cx);
        3: Cmd := F0847C3SiteAdjs(doc, cx);
        4: Cmd := CalcWeightedAvg(doc, [847,374,393]);
        5: Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6: Cmd := DivideAB(doc, mcx(CX,35), mcx(CX,41), mcx(CX,36));
        7: Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8: Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[1,6]);
       10: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[2,7]);
       11: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[3,8]);
       //Market Area Analysis -------------------------------------------------------------------
       12: Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
       //Improvements Analysis ------------------------------------------------------------------
       13: Cmd := SiteDimension(doc, CX, MCX(cx,47));
       14: Cmd := SumABC(doc, mcx(cx,78), mcx(CX,89), mcx(CX,101), mcx(cx,106));
       15: Cmd := SumABC(doc, mcx(cx,79), mcx(cx,90), mcx(cx,102), mcx(cx,107));
       16: Cmd := SumABC(doc, mcx(cx,82), mcx(cx,93), mcx(cx,105), mcx(cx,108));
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22: Cmd := SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
       25: Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,30),mcx(cx,31));         //phy dep precent entered
       26: Cmd := F0847CalcDeprLessPhy(doc, cx);                                 //funct depr entered
       27: Cmd := F0847CalcDeprLessPhyNFunct(doc, cx);                           //external depr entered
       29:
         begin
           Cmd := SumABC(doc, mcx(cx,31), mcx(cx,33), mcx(cx,35), mcx(cx,36));   //sum depr
           SetCellValue(doc, mcx(cx,37), (-1 * GetCellValue(doc, mcx(cx,36))));  //set negative in accum
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,36), mcx(cx,38));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [38,39,41,43,45,46], 47);                //indictaed value
       32:
         begin
           RoundByValR(doc, cx, 47, 50, 500);                             //cost approach value
           Cmd := CalcWeightedAvg(doc, [847,940,1311]);   //calc wtAvg of main and xcomps forms
         end;
       23: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[25,26,27,30]);
       //Income Approach ------------------------------------------------------------------------
       33: Cmd := SubtABCD(doc, mcx(cx,39), mcx(cx,41), mcx(cx,43), mcx(cx,45), mcx(CX,46));
       34,35: Cmd := F0847IncomeAppC1Adjustments(doc, cx);
       36: Cmd := SubtABCD(doc, mcx(cx,86), mcx(cx,88), mcx(cx,90), mcx(cx,92), mcx(CX,93));
       37,38: Cmd := F0847IncomeAppC2Adjustments(doc, cx);
       39: Cmd := SubtABCD(doc, mcx(cx,133), mcx(cx,135), mcx(cx,137), mcx(cx,139), mcx(CX,140));
       40,41: Cmd := F0847IncomeAppC3Adjustments(doc, cx);
       42: Cmd := MultAB(doc, mcx(cx,200), mcx(CX,201), mcx(CX,202));
       //Sales Comparison Approach----------------------------------------------------------------
       43: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,12));
       44: Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,28), mcx(CX,15));
       45: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[44,43,61]);
       46: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,49), mcx(CX,52));
       47: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,80), mcx(cx,55));     //price/sqft
       48: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[47,46,49,62]);
       49: Cmd := F0847SalesCompAppC1Adjustments(doc, cx);
       51: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,112), mcx(CX,115));
       52: Cmd := DivideAB(doc, mcx(cx,113), mcx(cx,143), mcx(cx,118));     //price/sqft
       53: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[52,51,54,63]);
       54: Cmd := F0847SalesCompAppC2Adjustments(doc, cx);
       56: Cmd := DivideABPercent(doc, mcx(CX,176), mcx(CX,175), mcx(CX,178));
       57: Cmd := DivideAB(doc, mcx(cx,176), mcx(cx,206), mcx(cx,181));     //price/sqft
       58: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[57,56,59,64]);
       59: Cmd := F0847SalesCompAppC3Adjustments(doc, cx);
       61: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,8), mcx(CX,11));
       62: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,48), mcx(CX,51));
       63: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,111), mcx(CX,114));
       64: Cmd := DivideABPercent(doc, mcx(cx,176), mcx(CX,174), mcx(CX,177));
       60: Cmd := CalcWeightedAvg(doc, [846,847,378,391]);   //calc wtAvg of main and xcomps forms
       65:
          begin                               //Math ID 32 is for Weighted Average
            F0847SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
            F0847SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
            F0847SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0847Math(doc, 1, CX);
          ProcessForm0847Math(doc, 2, CX);
          ProcessForm0847Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
         CX.pg := 7;
         ProcessForm0847Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm1303Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        12:
          Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
        13:
          Cmd := SiteDimension(doc, CX, MCX(cx,47));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm1304Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F1304C1Adjustments(doc, cx);
        2:
          Cmd := F1304C2Adjustments(doc, cx);
        3:
          Cmd := F1304C3Adjustments(doc, cx);
        4:
          Cmd := CalcWeightedAvg(doc, [941,1304,1309,1317]);   //calc wtAvg of main and xcomps forms
        5:
          Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6:
          Cmd := DivideAB(doc, mcx(CX,35), mcx(CX,41), mcx(CX,36));
        7:
          Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8:
          Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9:
          Cmd := ProcessMultipleCmds(ProcessForm1304Math, doc, CX,[1,6]);
        10:
          Cmd := ProcessMultipleCmds(ProcessForm1304Math, doc, CX,[2,7]);
        11:
          Cmd := ProcessMultipleCmds(ProcessForm1304Math, doc, CX,[3,8]);
        14:
          begin                              //Math ID 14 is for Weighted Average
            F1304C1Adjustments(doc, cx);     //sum of adjs
            F1304C2Adjustments(doc, cx);     //sum of adjs
            F1304C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1304Math(doc, 1, CX);
          ProcessForm1304Math(doc, 2, CX);
          ProcessForm1304Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm1304Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm1307Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        12:
          Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
        13:
          Cmd := SiteDimension(doc, CX, MCX(cx,47));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm1308Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       14: Cmd := SumABC(doc, mcx(cx,78), mcx(CX,89), mcx(CX,101), mcx(cx,106));
       15: Cmd := SumABC(doc, mcx(cx,79), mcx(cx,90), mcx(cx,102), mcx(cx,107));
       16: Cmd := SumABC(doc, mcx(cx,82), mcx(cx,93), mcx(cx,105), mcx(cx,108));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm1309Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Site Evaluation -----------------------------------------------------------------------
        1: Cmd := F1309C1SiteAdjs(doc, cx);
        2: Cmd := F1309C2SiteAdjs(doc, cx);
        3: Cmd := F1309C3SiteAdjs(doc, cx);
        4: Cmd := CalcWeightedAvg(doc, [941,1304,1309,1317]);
        5: Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6: Cmd := DivideAB(doc, mcx(CX,35), mcx(CX,41), mcx(CX,36));
        7: Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8: Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9: Cmd := ProcessMultipleCmds(ProcessForm1309Math, doc, CX,[1,6]);
       10: Cmd := ProcessMultipleCmds(ProcessForm1309Math, doc, CX,[2,7]);
       11: Cmd := ProcessMultipleCmds(ProcessForm1309Math, doc, CX,[3,8]);
       65:
          begin                               //Math ID 65 is for Weighted Average
            F1309SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
            F1309SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
            F1309SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1309Math(doc, 1, CX);
          ProcessForm1309Math(doc, 2, CX);
          ProcessForm1309Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
         ProcessForm1309Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm1310Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22: Cmd := SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
       25: Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,30), mcx(cx,31));         //phy dep precent entered
       26: Cmd := F0847CalcDeprLessPhy(doc, cx);                                 //funct depr entered
       27: Cmd := F0847CalcDeprLessPhyNFunct(doc, cx);                           //external depr entered
       29:
         begin
           Cmd := SumABC(doc, mcx(cx,31), mcx(cx,33), mcx(cx,35), mcx(cx,36));   //sum depr
           SetCellValue(doc, mcx(cx,37), (-1 * GetCellValue(doc, mcx(cx,36))));  //set negative in accum
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,36), mcx(cx,38));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [38,40,42,44,45], 46);                   //indictaed value
       32: Cmd := RoundByValR(doc, cx, 46, 49, 500);                             //cost approach value
       23: Cmd := ProcessMultipleCmds(ProcessForm1310Math, doc, CX,[25,26,27,30]);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function ProcessForm1311Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       34: Cmd := F1311C1IncomeAdjs(doc, cx);
       37: Cmd := F1311C2IncomeAdjs(doc, cx);
       40: Cmd := F1311C3IncomeAdjs(doc, cx);
       //Income Approach ------------------------------------------------------------------------
       33: Cmd := SubtABCD(doc, mcx(cx,39), mcx(cx,41), mcx(cx,43), mcx(cx,45), mcx(CX,46));
       35: Cmd := ProcessMultipleCmds(ProcessForm1311Math, doc, CX,[34]);
       36: Cmd := SubtABCD(doc, mcx(cx,86), mcx(cx,88), mcx(cx,90), mcx(cx,92), mcx(CX,93));
       38: Cmd := ProcessMultipleCmds(ProcessForm1311Math, doc, CX,[37]);
       39: Cmd := SubtABCD(doc, mcx(cx,133), mcx(cx,135), mcx(cx,137), mcx(cx,139), mcx(CX,140));
       41: Cmd := ProcessMultipleCmds(ProcessForm1311Math, doc, CX,[40]);
       42: Cmd := CalcWeightedAvg(doc, [940,1311,1319]);
       43: Cmd := MultAB(doc, mcx(cx,200), mcx(CX,201), mcx(CX,202));
       65:
          begin                               //Math ID 65 is for Weighted Average
            F1311C1IncomeAdjs(doc, cx);     //sum of adjs
            F1311C2IncomeAdjs(doc, cx);     //sum of adjs
            F1311C3IncomeAdjs(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1311Math(doc, 34, CX);
          ProcessForm1311Math(doc, 37, CX);
          ProcessForm1311Math(doc, 40, CX);
        end;
      WeightedAvergeID:
        begin
         ProcessForm1311Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm1312Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//        1: Cmd := F1312C1SiteAdjs(doc, cx);     //this is wrong.  We should use math id 49,54,59 for adjustment
//        2: Cmd := F1312C2SiteAdjs(doc, cx);
//        3: Cmd := F1312C3SiteAdjs(doc, cx);
       //Sales Comparison Approach----------------------------------------------------------------
       43: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,12));
       44: Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,28), mcx(CX,15));
       45: Cmd := ProcessMultipleCmds(ProcessForm1312Math, doc, CX,[44,43,61]);
       46: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,49), mcx(CX,52));
       47: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,80), mcx(cx,55));     //price/sqft
       48: Cmd := ProcessMultipleCmds(ProcessForm1312Math, doc, CX,[47,46,49,62]);
       49: Cmd := F1312SalesCompAppC1Adjustments(doc, cx);
       51: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,112), mcx(CX,115));
       52: Cmd := DivideAB(doc, mcx(cx,113), mcx(cx,143), mcx(cx,118));     //price/sqft
       53: Cmd := ProcessMultipleCmds(ProcessForm1312Math, doc, CX,[52,51,54,63]);
       54: Cmd := F1312SalesCompAppC2Adjustments(doc, cx);
       56: Cmd := DivideABPercent(doc, mcx(CX,176), mcx(CX,175), mcx(CX,178));
       57: Cmd := DivideAB(doc, mcx(cx,176), mcx(cx,206), mcx(cx,181));     //price/sqft
       58: Cmd := ProcessMultipleCmds(ProcessForm1312Math, doc, CX,[57,56,59,64]);
       59: Cmd := F1312SalesCompAppC3Adjustments(doc, cx);
       61: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,8), mcx(CX,11));
       62: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,48), mcx(CX,51));
       63: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,111), mcx(CX,114));
       64: Cmd := DivideABPercent(doc, mcx(cx,176), mcx(CX,174), mcx(CX,177));

       60: Cmd := CalcWeightedAvg(doc, [939,1312,1320]);   //calc wtAvg of main and xcomps forms
       65:
          begin                               //Math ID 65 is for Weighted Average
            F1312SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
            F1312SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
            F1312SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
//          ProcessForm1312Math(doc, 1, CX);
//          ProcessForm1312Math(doc, 2, CX);
//          ProcessForm1312Math(doc, 3, CX);
          ProcessForm1312Math(doc, 65, CX);   //ticket #1241
        end;
      WeightedAvergeID:
        begin
         ProcessForm1312Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0846Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        //Site Evaluation -----------------------------------------------------------------------
        1: Cmd := F0846SiteValuationC1Adjustments(doc, cx);
        2: Cmd := F0846SiteValuationC2Adjustments(doc, cx);
        3: Cmd := F0846SiteValuationC3Adjustments(doc, cx);
        4: Cmd := CalcWeightedAvg(doc, [846,374,378,391,393]);   //calc wtAvg of main and xcomps forms
        5: Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6: Cmd := DivideAB(doc, mcx(cx,35), mcx(CX,41), mcx(CX,36));
        7: Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8: Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[1,6]);
       10: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[2,7]);
       11: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[3,8]);
       //Market Area Analysis -------------------------------------------------------------------
       12: Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
       //Improvements Analysis ------------------------------------------------------------------
       13: Cmd := SiteDimension(doc, CX, MCX(cx,47));
       14: Cmd := SumABC(doc, mcx(cx,78), mcx(CX,89), mcx(CX,101), mcx(cx,106));
       15: Cmd := SumABC(doc, mcx(cx,79), mcx(cx,90), mcx(cx,102), mcx(cx,107));
       16: Cmd := SumABC(doc, mcx(cx,82), mcx(cx,93), mcx(cx,105), mcx(cx,108));
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22: Cmd := SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
       25: Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,30),mcx(cx,31));         //phy dep precent entered
       26: Cmd := F0847CalcDeprLessPhy(doc, cx);                                 //funct depr entered
       27: Cmd := F0847CalcDeprLessPhyNFunct(doc, cx);                           //external depr entered
       29:
         begin
           Cmd := SumABC(doc, mcx(cx,31), mcx(cx,33), mcx(cx,35), mcx(cx,36));   //sum depr
           SetCellValue(doc, mcx(cx,37), (-1 * GetCellValue(doc, mcx(cx,36))));  //set negative in accum
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,36), mcx(cx,38));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [38,39,41,43,45,46], 47);                //indictaed value
       32: Cmd := RoundByValR(doc, cx, 47, 50, 500);                             //cost approach value
       23: Cmd := ProcessMultipleCmds(ProcessForm0847Math, doc, CX,[25,26,27,30]);
      //Income Approach ------------------------------------------------------------------------
       33: Cmd := SubtABCD(doc, mcx(cx,39), mcx(cx,41), mcx(cx,43), mcx(cx,45), mcx(CX,46));
       34,35:
         begin
           F0846IncomeAppC1Adjustments(doc, cx);
           Cmd := CalcWeightedAvg(doc, [846,940,1319]);   //calc wtAvg of main and xcomps forms
         end;
       36: Cmd := SubtABCD(doc, mcx(cx,86), mcx(cx,88), mcx(cx,90), mcx(cx,92), mcx(CX,93));
       37,38:
         begin
           F0846IncomeAppC2Adjustments(doc, cx);
           Cmd := CalcWeightedAvg(doc, [846,940,1319]);   //calc wtAvg of main and xcomps forms
         end;
       39: Cmd := SubtABCD(doc, mcx(cx,133), mcx(cx,135), mcx(cx,137), mcx(cx,139), mcx(CX,140));
       40,41:
         begin
           F0846IncomeAppC3Adjustments(doc, cx);
           Cmd := CalcWeightedAvg(doc, [846,940,1319]);   //calc wtAvg of main and xcomps forms
         end;
       42: Cmd := MultAB(doc, mcx(cx,200), mcx(CX,201), mcx(CX,202));
      //Sales Comparison Approach----------------------------------------------------------------
       43: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,12));
       44: Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,28), mcx(CX,15));
       45: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[44,43,61]);
       46: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,49), mcx(CX,52));
       47: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,80), mcx(cx,55));     //price/sqft
       48: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[47,46,49,62]);
       49: Cmd := F0846SalesCompAppC1Adjustments(doc, cx);
       51: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,112), mcx(CX,115));
       52: Cmd := DivideAB(doc, mcx(cx,113), mcx(cx,143), mcx(cx,118));     //price/sqft
       53: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[52,51,54,63]);
       54: Cmd := F0846SalesCompAppC2Adjustments(doc, cx);
       56: Cmd := DivideABPercent(doc, mcx(CX,176), mcx(CX,175), mcx(CX,178));
       57: Cmd := DivideAB(doc, mcx(cx,176), mcx(cx,206), mcx(cx,181));     //price/sqft
       58: Cmd := ProcessMultipleCmds(ProcessForm0846Math, doc, CX,[57,56,59,64]);
       59: Cmd := F0846SalesCompAppC3Adjustments(doc, cx);
       61: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,8), mcx(CX,11));
       62: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,48), mcx(CX,51));
       63: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,111), mcx(CX,114));
       64: Cmd := DivideABPercent(doc, mcx(cx,176), mcx(CX,174), mcx(CX,177));
       60: Cmd := CalcWeightedAvg(doc, [846,847,378,391]);   //calc wtAvg of main and xcomps forms

       65:
          begin                              //Math ID 12 is for Weighted Average
            F0846SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
            F0846SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
            F0846SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0846Math(doc, 1, CX);
          ProcessForm0846Math(doc, 2, CX);
          ProcessForm0846Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 7;
          ProcessForm0846Math(doc, 65, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm1315Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        12:
          Cmd := LandUseSum(doc, CX, 2, [30,31,32,33,34,36]);
        13:
          Cmd := SiteDimension(doc, CX, MCX(cx,47));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm1316Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
       //Improvements Analysis ------------------------------------------------------------------
//       13: Cmd := SiteDimension(doc, CX, MCX(cx,47)); //Ticket #1342: no site dimension on the form
       14: Cmd := SumABC(doc, mcx(cx,78), mcx(CX,89), mcx(CX,101), mcx(cx,106));
       15: Cmd := SumABC(doc, mcx(cx,79), mcx(cx,90), mcx(cx,102), mcx(cx,107));
       16: Cmd := SumABC(doc, mcx(cx,82), mcx(cx,93), mcx(cx,105), mcx(cx,108));
      else
        Cmd := 0;             
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm1317Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        //Site Evaluation -----------------------------------------------------------------------
        1: Cmd := F1317SiteValuationC1Adjustments(doc, cx);
        2: Cmd := F1317SiteValuationC2Adjustments(doc, cx);
        3: Cmd := F1317SiteValuationC3Adjustments(doc, cx);
        4: Cmd := CalcWeightedAvg(doc, [941,1304,1309,1317]);   //calc wtAvg of main and xcomps forms
        5: Cmd := DivideAB(doc, mcx(cx,12), mcx(CX,17), mcx(CX,14));
        6: Cmd := DivideAB(doc, mcx(cx,35), mcx(CX,41), mcx(CX,36));
        7: Cmd := DivideAB(doc, mcx(cx,66), mcx(CX,72), mcx(CX,67));
        8: Cmd := DivideAB(doc, mcx(cx,97), mcx(CX,103), mcx(CX,98));
        9: Cmd := ProcessMultipleCmds(ProcessForm1317Math, doc, CX,[1,6]);
       10: Cmd := ProcessMultipleCmds(ProcessForm1317Math, doc, CX,[2,7]);
       11: Cmd := ProcessMultipleCmds(ProcessForm1317Math, doc, CX,[3,8]);
       65:
          begin                              //Math ID 65 is for Weighted Average
            F1317SiteValuationC1Adjustments(doc, cx);     //sum of adjs
            F1317SiteValuationC2Adjustments(doc, cx);     //sum of adjs
            F1317SiteValuationC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1317Math(doc, 1, CX);
          ProcessForm1317Math(doc, 2, CX);
          ProcessForm1317Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm1317Math(doc, 65, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm1318Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22: Cmd := SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
       25: Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,30), mcx(cx,31));         //phy dep precent entered
       26: Cmd := F0847CalcDeprLessPhy(doc, cx);                                 //funct depr entered
       27: Cmd := F0847CalcDeprLessPhyNFunct(doc, cx);                           //external depr entered
       29:
         begin
           Cmd := SumABC(doc, mcx(cx,31), mcx(cx,33), mcx(cx,35), mcx(cx,36));   //sum depr
           SetCellValue(doc, mcx(cx,37), (-1 * GetCellValue(doc, mcx(cx,36))));  //set negative in accum
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,36), mcx(cx,38));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [38,40,42,44,45], 46);                   //indictaed value
       32: Cmd := RoundByValR(doc, cx, 46, 49, 500);                             //cost approach value
       23: Cmd := ProcessMultipleCmds(ProcessForm1310Math, doc, CX,[25,26,27,30]);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;


//Ticket #1342: new math for Cost Approach 1323
function ProcessForm1323Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22:
         begin
           SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
           Cmd := ProcessMultipleCmds(ProcessForm1323Math, doc, CX, [29, 23, 32]);
         end;
       29:
         begin
           SumABC(doc, mcx(cx,30), mcx(cx,31), mcx(cx,32), mcx(cx,33));   //sum depr
           SetCellValue(doc, mcx(cx,34), (-1 * GetCellValue(doc, mcx(cx,33))));  //set negative in accum
           Cmd := SumAB(doc, mcx(cx,29), mcx(cx,34), mcx(cx,35));   //sum depr
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,33), mcx(cx,35));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [35,37,39,41,42], 43);         //indictaed value
       32: Cmd := RoundByValR(doc, cx, 43, 46, 500);                             //cost approach value
       23:
         begin
           SumCellArray(doc, cx, [35,37,39,41,42], 43);
           Cmd := RoundByValR(doc, cx, 43, 46, 500);
         end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

//Ticket #1342: new math for Cost Approach 1323
function ProcessForm1324Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       //Cost Approach  -------------------------------------------------------------------------
       17: Cmd := MultAB(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10));
       18: Cmd := MultAB(doc, mcx(cx,11), mcx(CX,12), mcx(CX,13));
       19: Cmd := MultAB(doc, mcx(cx,14), mcx(CX,15), mcx(CX,16));
       20: Cmd := MultAB(doc, mcx(cx,17), mcx(CX,18), mcx(CX,19));
       21: Cmd := MultAB(doc, mcx(cx,20), mcx(CX,21), mcx(CX,22));
       22:
         begin
           SumCellArray(doc, cx, [10,13,16,19,22,24,26,28], 29);          //total cost new
           Cmd := ProcessMultipleCmds(ProcessForm1323Math, doc, CX, [29, 23, 32]);
         end;
       29:
         begin
           SumABC(doc, mcx(cx,30), mcx(cx,31), mcx(cx,32), mcx(cx,33));   //sum depr
           SetCellValue(doc, mcx(cx,34), (-1 * GetCellValue(doc, mcx(cx,33))));  //set negative in accum
           Cmd := SumAB(doc, mcx(cx,29), mcx(cx,34), mcx(cx,35));   //sum depr
         end;
       30: Cmd := SubtAB(doc, MCX(cx,29), mcx(cx,33), mcx(cx,35));               //depr value of improvements
       31: Cmd := SumCellArray(doc, cx, [35,37,39,41,42], 43);         //indictaed value
       32: Cmd := RoundByValR(doc, cx, 43, 46, 500);                             //cost approach value
       23:
         begin
           SumCellArray(doc, cx, [35,37,39,41,42], 43);
           Cmd := RoundByValR(doc, cx, 43, 46, 500);
         end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;


function ProcessForm1319Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
       34: Cmd := F1319C1IncomeAdjs(doc, cx);
       37: Cmd := F1319C2IncomeAdjs(doc, cx);
       40: Cmd := F1319C3IncomeAdjs(doc, cx);
       //Income Approach ------------------------------------------------------------------------
       33: Cmd := SubtABCD(doc, mcx(cx,39), mcx(cx,41), mcx(cx,43), mcx(cx,45), mcx(CX,46));
       35: Cmd := ProcessMultipleCmds(ProcessForm1319Math, doc, CX,[34]);
       36: Cmd := SubtABCD(doc, mcx(cx,86), mcx(cx,88), mcx(cx,90), mcx(cx,92), mcx(CX,93));
       38: Cmd := ProcessMultipleCmds(ProcessForm1319Math, doc, CX,[37]);
       39: Cmd := SubtABCD(doc, mcx(cx,133), mcx(cx,135), mcx(cx,137), mcx(cx,139), mcx(CX,140));
       41: Cmd := ProcessMultipleCmds(ProcessForm1319Math, doc, CX,[40]);
       42: Cmd := CalcWeightedAvg(doc, [940,1311,1319]);
       43: Cmd := MultAB(doc, mcx(cx,200), mcx(CX,201), mcx(CX,202));
       65:
          begin                               //Math ID 65 is for Weighted Average
            F1319C1IncomeAdjs(doc, cx);     //sum of adjs
            F1319C2IncomeAdjs(doc, cx);     //sum of adjs
            F1319C3IncomeAdjs(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1319Math(doc, 34, CX);
          ProcessForm1319Math(doc, 37, CX);
          ProcessForm1319Math(doc, 40, CX);
        end;
      WeightedAvergeID:
        begin
         ProcessForm1319Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function F1320SalesCompAppC1Adjustments(doc: TContainer; CX: CellUID): Integer;    //Ticket #1342: use it's own form to reference cell
begin
  result := SalesGridAdjustment(doc, CX, 50,104,105,102,103,1,2,
            [57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F1320SalesCompAppC2Adjustments(doc: TContainer; CX: CellUID): Integer;  //Ticket #1342 use it's own form to reference
begin
  result := SalesGridAdjustment(doc, CX, 113,167,168,165,166,3,4,
            [120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164]);
end;
function F1320SalesCompAppC3Adjustments(doc: TContainer; CX: CellUID): Integer;   //Ticket #1342  use it's own form to reference 
begin
  result := SalesGridAdjustment(doc, CX, 176,230,231,228,229,5,6,
            [183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227]);
end;


function ProcessForm1320Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
      //Sales Comparison Approach----------------------------------------------------------------
       43: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,12));
       44: Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,28), mcx(CX,15));
       45: Cmd := ProcessMultipleCmds(ProcessForm1320Math, doc, CX,[44,43,61]);
       46: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,49), mcx(CX,52));
       47: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,80), mcx(cx,55));     //price/sqft
       48: Cmd := ProcessMultipleCmds(ProcessForm1320Math, doc, CX,[47,46,49,62]);
       49: Cmd := F1320SalesCompAppC1Adjustments(doc, cx);
       51: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,112), mcx(CX,115));
       52: Cmd := DivideAB(doc, mcx(cx,113), mcx(cx,143), mcx(cx,118));     //price/sqft
       53: Cmd := ProcessMultipleCmds(ProcessForm1320Math, doc, CX,[52,51,54,63]);
       54: Cmd := F1320SalesCompAppC2Adjustments(doc, cx);
       56: Cmd := DivideABPercent(doc, mcx(CX,176), mcx(CX,175), mcx(CX,178));
       57: Cmd := DivideAB(doc, mcx(cx,176), mcx(cx,206), mcx(cx,181));     //price/sqft
       58: Cmd := ProcessMultipleCmds(ProcessForm1320Math, doc, CX,[57,56,59,64]);
       59: Cmd := F1320SalesCompAppC3Adjustments(doc, cx);
       61: Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,8), mcx(CX,11));
       62: Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,48), mcx(CX,51));
       63: Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,111), mcx(CX,114));
       64: Cmd := DivideABPercent(doc, mcx(cx,176), mcx(CX,174), mcx(CX,177));
       60: Cmd := CalcWeightedAvg(doc, [939,1312,1320]);   //calc wtAvg of main and xcomps forms

       65:
          begin                              //Math ID 12 is for Weighted Average
            F1320SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
            F1320SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
            F1320SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1320Math(doc, 1, CX);
          ProcessForm1320Math(doc, 2, CX);
          ProcessForm1320Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm1320Math(doc, 65, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0939Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := F0939SalesCompAppC1Adjustments(doc, cx);
        2: Cmd := F0939SalesCompAppC2Adjustments(doc, cx);
        3: Cmd := F0939SalesCompAppC3Adjustments(doc, cx);
        //dynamic form name
        40:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 44,108,172);
        41:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 44,108,172, 2);
        42:
          cmd := ConfigXXXInstance(doc, cx, 44,108,172);

        //Sales Comparison Approach----------------------------------------------------------------
        43: Cmd := DivideABPercent(doc, mcx(cx,11), mcx(CX,10), mcx(CX,13));
        44: Cmd := DivideAB(doc, mcx(cx,11), mcx(CX,29), mcx(CX,16));
        45: Cmd := ProcessMultipleCmds(ProcessForm0939Math, doc, CX,[44,43,61]);
        46: Cmd := DivideABPercent(doc, mcx(cx,52), mcx(CX,51), mcx(CX,54));
        47: Cmd := DivideAB(doc, mcx(cx,52), mcx(cx,82), mcx(cx,57));     //price/sqft
        48: Cmd := ProcessMultipleCmds(ProcessForm0939Math, doc, CX,[47,46,49,62]);
        49: Cmd := F0939SalesCompAppC1Adjustments(doc, cx);
        51: Cmd := DivideABPercent(doc, mcx(cx,116), mcx(CX,115), mcx(CX,118));
        52: Cmd := DivideAB(doc, mcx(cx,116), mcx(cx,146), mcx(cx,121));     //price/sqft
        53: Cmd := ProcessMultipleCmds(ProcessForm0939Math, doc, CX,[52,51,54,63]);
        54: Cmd := F0939SalesCompAppC2Adjustments(doc, cx);
        56: Cmd := DivideABPercent(doc, mcx(CX,180), mcx(CX,179), mcx(CX,182));
        57: Cmd := DivideAB(doc, mcx(cx,180), mcx(cx,210), mcx(cx,185));     //price/sqft
        58: Cmd := ProcessMultipleCmds(ProcessForm0939Math, doc, CX,[57,56,59,64]);
        59: Cmd := F0939SalesCompAppC3Adjustments(doc, cx);
        61: Cmd := DivideABPercent(doc, mcx(cx,11), mcx(CX,9), mcx(CX,12));
        62: Cmd := DivideABPercent(doc, mcx(cx,52), mcx(CX,50), mcx(CX,53));
        63: Cmd := DivideABPercent(doc, mcx(cx,116), mcx(CX,114), mcx(CX,117));
        64: Cmd := DivideABPercent(doc, mcx(cx,180), mcx(CX,178), mcx(CX,181));
        60: Cmd := CalcWeightedAvg(doc, [939,1312,1320]);   //calc wtAvg of main and xcomps forms

        65:
           begin                              //Math ID 12 is for Weighted Average
             F0939SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
             F0939SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
             F0939SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
             Cmd := 0;
           end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0939Math(doc, 1, CX);
          ProcessForm0939Math(doc, 2, CX);
          ProcessForm0939Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;
          ProcessForm0939Math(doc, 65, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0940Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 33,81,129);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS','', 33,81,129, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 33,81,129);

      //Income Approach ------------------------------------------------------------------------
       34: Cmd := F0940C1IncomeAdjs(doc, cx);
       37: Cmd := F0940C2IncomeAdjs(doc, cx);
       40: Cmd := F0940C3IncomeAdjs(doc, cx);
       33: Cmd := SubtABCD(doc, mcx(cx,41), mcx(cx,43), mcx(cx,45), mcx(cx,47), mcx(CX,48));
       35: Cmd := F0940IncomeAppC1Adjustments(doc, cx);
       36: Cmd := SubtABCD(doc, mcx(cx,89), mcx(cx,91), mcx(cx,93), mcx(cx,95), mcx(CX,96));
       38: Cmd := F0940IncomeAppC2Adjustments(doc, cx);
       39: Cmd := SubtABCD(doc, mcx(cx,137), mcx(cx,139), mcx(cx,141), mcx(cx,143), mcx(CX,144));
       41: Cmd := F0940IncomeAppC3Adjustments(doc, cx);
       42: Cmd := CalcWeightedAvg(doc, [940,1311,1319]);
       65:
          begin                               //Math ID 65 is for Weighted Average
            F0940C1IncomeAdjs(doc, cx);     //sum of adjs
            F0940C2IncomeAdjs(doc, cx);     //sum of adjs
            F0940C3IncomeAdjs(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0940Math(doc, 34, CX);
          ProcessForm0940Math(doc, 37, CX);
          ProcessForm0940Math(doc, 40, CX);
        end;
      WeightedAvergeID:
        begin
         ProcessForm0940Math(doc, 65, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0941Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F0941C1Adjustments(doc, cx);
        2:
          Cmd := F0941C2Adjustments(doc, cx);
        3:
          Cmd := F0941C3Adjustments(doc, cx);
        4:
          Cmd := CalcWeightedAvg(doc, [941,1304,1309,1317]);   //calc wtAvg of main and xcomps forms
        5:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(CX,18), mcx(CX,15));
        6:
          Cmd := DivideAB(doc, mcx(CX,37), mcx(CX,43), mcx(CX,38));
        7:
          Cmd := DivideAB(doc, mcx(cx,69), mcx(CX,75), mcx(CX,70));
        8:
          Cmd := DivideAB(doc, mcx(cx,101), mcx(CX,107), mcx(CX,102));
        9:
          Cmd := ProcessMultipleCmds(ProcessForm0941Math, doc, CX,[1,6]);
        10:
          Cmd := ProcessMultipleCmds(ProcessForm0941Math, doc, CX,[2,7]);
        11:
          Cmd := ProcessMultipleCmds(ProcessForm0941Math, doc, CX,[3,8]);
               //dynamic form name
        13:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Sites', 31,63,95);
        12:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA SITES','', 31,63,95, 2);
        14:
          cmd := ConfigXXXInstance(doc, cx, 31,63,95);
        15:
          begin                              //Math ID 15 is for Weighted Average
            F0941C1Adjustments(doc, cx);     //sum of adjs
            F0941C2Adjustments(doc, cx);     //sum of adjs
            F0941C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0941Math(doc, 1, CX);
          ProcessForm0941Math(doc, 2, CX);
          ProcessForm0941Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          ProcessForm0941Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function F0921C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 50,104,105,102,103,3,4,
           [57,59,61,63,65,67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F0921C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 113,167,168,165,166,5,6,
            [120,122,124,126,128,130,132,134,136,138,140,142,144,146,148,150,152,154,156,158,160,162,164]);
end;

function F0921C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
   result := SalesGridAdjustment(doc, CX, 176,230,231,228,229,7,8,
             [183,185,187,189,191,193,195,197,199,201,203,205,207,209,211,213,215,217,219,221,223,225,227]);
end;

function ProcessForm0921Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         43:
            begin
              DivideABPercent(doc, mcx(cx,10), mcx(CX,8), mcx(CX,11));
              Cmd := DivideABPercent(doc, mcx(cx,10), mcx(CX,9), mcx(CX,12));
            end;
         44:
            Cmd := DivideAB(doc, mcx(cx,10), mcx(CX,28), mcx(CX,15));
         45:
            Cmd := ProcessMultipleCmds(ProcessForm0921Math, doc, CX,[44,43]);
         46:
            begin
              DivideABPercent(doc, mcx(cx,50), mcx(CX,48), mcx(CX,51));
              Cmd := DivideABPercent(doc, mcx(cx,50), mcx(CX,49), mcx(CX,52));
            end;
         47:
            Cmd := DivideAB(doc, mcx(CX,50), mcx(CX,80), mcx(CX,55));
         48:
            Cmd := ProcessMultipleCmds(ProcessForm0921Math, doc, CX,[47,46,49]);
         49:
            Cmd := F0921C1Adjustments(doc, cx);
         51:
            begin
              DivideABPercent(doc, mcx(cx,113), mcx(CX,111), mcx(CX,114));
              Cmd := DivideABPercent(doc, mcx(cx,113), mcx(CX,112), mcx(CX,115));
            end;
         52:
            Cmd := DivideAB(doc, mcx(CX,113), mcx(CX,143), mcx(CX,118));
         53:
            Cmd := ProcessMultipleCmds(ProcessForm0921Math, doc, CX,[52,51,54]);
         54:
            Cmd := F0921C2Adjustments(doc, cx);
         56:
            begin
              DivideABPercent(doc, mcx(CX,176), mcx(CX,174), mcx(CX,177));
              Cmd := DivideABPercent(doc, mcx(CX,176), mcx(CX,175), mcx(CX,178));
            end;
         57:
            Cmd := DivideAB(doc, mcx(CX,176), mcx(CX,206), mcx(CX,181));
         58:
            Cmd := ProcessMultipleCmds(ProcessForm0921Math, doc, CX,[57,56,59]);
         59:
            Cmd := F0921C3Adjustments(doc, cx);

         //calc wtAvg of main and xcomps forms
         60:
            Cmd := CalcWeightedAvg(doc, [378,391,921]);   //calc wtAvg of main and xcomps forms
         61:
          begin                              //Math ID 61 is for Weighted Average
            F0921C1Adjustments(doc, cx);     //sum of adjs
            F0921C2Adjustments(doc, cx);     //sum of adjs
            F0921C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm0921Math(doc, 49, CX);
          ProcessForm0921Math(doc, 54, CX);
          ProcessForm0921Math(doc, 59, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;
          ProcessForm0921Math(doc, 61, CX);
        end;
    end;
  result := 0;
end;


function LoadComment_AP(aMemberID: Integer; doc: TContainer; frm: TDocForm; cx:CellUID; CANCellNo:Integer): Integer;
const
  AI_CertForm_ID = 1326;
  //Appraiser Section math id
  ap_SRA  = 1;
  ap_MAI  = 2;
  ap_SRPA = 3;
  ap_GRS  = 4;
  ap_RRS  = 5;
  ap_CAN  = 6;
  ap_PRAC = 7;

  Can_CertComment  = 'completed the Standards and Ethics Education Requirements for Candidates of the Appraisal Institute.';
  Prac_CertComment = 'completed the continuing education program for Practicing Affiliates of the Appraisal Institute.';
  Des_CertComment  = 'completed the continuing education program for Designated Members of the Appraisal Institute.';
var
  CertComment: String;
  DesYesNo, aYesNo, cYesNo, pYesNo: String;
  i, APCellNo: Integer;
begin

  result := 0;
  APCellNo := 10;  //cell seqno of check box for first Destination check box
  for i:= 0 to 4 do
    begin
      DesYesNo := trim(GetCellString(doc, mcx(cx, APCellNo+i)));
      if DesYesNo = 'X' then
        break;  //if any of the 5 check box is checked
    end;

  cYesNo := trim(GetCellString(doc, mcx(cx,CANCellNo)));
  pYesNo := trim(GetCellString(doc, mcx(cx,CANCellNo+1)));


  if not assigned(frm) then exit;
  if frm.frmInfo.fFormUID <> AI_CertForm_ID then exit;    //we do this for form #1325 AI cert form only

  case aMemberID of
    ap_SRA..ap_RRS:
       begin
         aYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));  //check for the check box checked
         if aYesNo = 'X' then   //if any of the 1-5 checkbox checked, use Designation comment
           CertComment := Des_CertComment
         else //when all 1-5 unchecked, only set if can or prac checked
           begin
             CertComment := '';
             if trim(GetCellString(doc, mcx(cx, CANCellNo))) = 'X' then
                CertComment := Can_CertCOmment
             else if trim(GetCellString(doc, mcx(cx, CANCellNo+1)))= 'X' then
                CertComment := Prac_CertComment;
           end;
       end;
     ap_CAN: //if candidate check box checked, only set the comment if none of the 1-5 check box checked
       begin
         cYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));
         if (cYesNo = 'X') and (DesYesNo = '') then
           CertComment := Can_CertComment
         else
           CertComment := trim(frm.GetCellText(2, 18));   //load the existing comment
       end;
     ap_PRAC: //if practice check box checked, only set the comment if none of the 1-5 check box is checked
       begin
         pYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));
         if (pYesNo = 'X') and (DesYesNo = '') then
           CertComment := Prac_CertComment
         else
           CertComment := trim(frm.GetCellText(2, 18));  //load the existing comment
       end;
  end;
  if (DesYesNo='') and (cYesNo='') and (pYesNo='') then
    frm.SetCellText(2, 18, '')
  else
    frm.SetCellText(2, 18, CertComment);
end;

function LoadComment_CP(aMemberID: Integer; doc: TContainer; frm: TDocForm; cx:CellUID; CANCellNo:Integer): Integer;
const
  AI_CertForm_ID = 1326;
  //Co-Appriaser Section math id
  cp_SRA  = 8;
  cp_MAI  = 9;
  cp_SRPA = 10;
  cp_GRS  = 11;
  cp_RRS  = 12;
  cp_CAN  = 13;
  cp_PRAC = 14;

  Can_CertComment  = 'completed the Standards and Ethics Education Requirements for Candidates of the Appraisal Institute.';
  Prac_CertComment = 'completed the continuing education program for Practicing Affiliates of the Appraisal Institute.';
  Des_CertComment  = 'completed the continuing education program for Designated Members of the Appraisal Institute.';
var
  CertComment: String;
  DesYesNo, aYesNo, cYesNo, pYesNo: String;
  i, CPCellNo: Integer;
begin
  result := 0;
  CPCellNo := 20;  //cell seqno of check box for first Destination check box
  for i:= 0 to 4 do
    begin
      DesYesNo := trim(GetCellString(doc, mcx(cx, CPCellNo+i)));
      if DesYesNo = 'X' then
        break;  //if any of the 5 check box is checked
    end;

  cYesNo := trim(GetCellString(doc, mcx(cx,CANCellNo)));
  pYesNo := trim(GetCellString(doc, mcx(cx,CANCellNo+1)));

  if not assigned(frm) then exit;
  if frm.frmInfo.fFormUID <> AI_CertForm_ID then exit;    //we do this for form #1325 AI cert form only

  case aMemberID of
    cp_SRA..cp_RRS:
       begin
         aYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));  //check for the check box checked
         if aYesNo = 'X' then   //if any of the 1-5 checkbox checked, use Designation comment
           CertComment := Des_CertComment
         else //when all 1-5 unchecked, only set if can or prac checked
           begin
             CertComment := '';
             if trim(GetCellString(doc, mcx(cx, CANCellNo))) = 'X' then
                CertComment := Can_CertCOmment
             else if trim(GetCellString(doc, mcx(cx, CANCellNo+1)))= 'X' then
                CertComment := Prac_CertComment;
           end;
       end;
     cp_CAN: //if candidate check box checked, only set the comment if none of the 1-5 check box checked
       begin
         cYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));
         if (cYesNo = 'X') and (DesYesNo = '') then
           CertComment := Can_CertComment
         else
           CertComment := trim(frm.GetCellText(2, 30));   //load the existing comment
       end;
     cp_PRAC: //if practice check box checked, only set the comment if none of the 1-5 check box is checked
       begin
         pYesNo := trim(GetCellString(doc, mcx(cx, cx.Num+1)));
         if (pYesNo = 'X') and (DesYesNo = '') then
           CertComment := Prac_CertComment
         else
           CertComment := trim(frm.GetCellText(2, 30));  //load the existing comment
       end;
  end;
  if (DesYesNo='') and (cYesNo='') and (pYesNo='') then
    frm.SetCellText(2, 30, '')
  else
    frm.SetCellText(2, 30, CertComment);
end;

function ProcessForm1321Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  AI_CertForm_ID = 1326;
  //Appraiser Section math id
  ap_SRA  = 1;
  ap_MAI  = 2;
  ap_SRPA = 3;
  ap_GRS  = 4;
  ap_RRS  = 5;
  ap_CAN  = 6;
  ap_PRAC = 7;
  //Co-Appriaser Section math id
  cp_SRA  = 8;
  cp_MAI  = 9;
  cp_SRPA = 10;
  cp_GRS  = 11;
  cp_RRS  = 12;
  cp_CAN  = 13;
  cp_PRAC = 14;

  ap_CandidateCellNo = 15;
  cp_CandidateCellNo = 25;
var
  frm: TDocForm;
begin
  if Cmd > 0 then
    begin
      frm := doc.GetFormByOccurance(AI_CertForm_ID, 0, True); //occur is zero based
      if assigned(frm) then
        begin
          repeat
            case Cmd of //Math id 1-7 is for Appraiser section, Math id 8-14 is for Co-Appraiser section
              1..7:  Cmd := LoadComment_AP(Cmd,doc, frm, cx, ap_CandidateCellNo);
              8..14: Cmd := LoadComment_CP(Cmd,doc, frm, cx, cp_CandidateCellNo);
            else
              Cmd := 0;
            end;
          until Cmd = 0;
        end;
    end;
  result := 0;
end;

function ProcessForm1322Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  AI_CertForm_ID = 1326;
  //Appraiser Section math id
  ap_SRA  = 1;
  ap_MAI  = 2;
  ap_SRPA = 3;
  ap_GRS  = 4;
  ap_RRS  = 5;
  ap_CAN  = 6;
  ap_PRAC = 7;
  //Co-Appriaser Section math id
  cp_SRA  = 8;
  cp_MAI  = 9;
  cp_SRPA = 10;
  cp_GRS  = 11;
  cp_RRS  = 12;
  cp_CAN  = 13;
  cp_PRAC = 14;

  ap_CandidateCellNo = 15;
  cp_CandidateCellNo = 25;
var
  frm: TDocForm;
begin
  if Cmd > 0 then
    begin
      frm := doc.GetFormByOccurance(AI_CertForm_ID, 0, True); //occur is zero based
      if assigned(frm) then
        begin
          repeat
            case Cmd of //Math id 1-7 is for Appraiser section, Math id 8-14 is for Co-Appraiser section
              1..7:  Cmd := LoadComment_AP(Cmd,doc, frm, cx, ap_CandidateCellNo);
              8..14: Cmd := LoadComment_CP(Cmd,doc, frm, cx, cp_CandidateCellNo);
            else
              Cmd := 0;
            end;
          until Cmd = 0;
        end;
    end;
  result := 0;
end;

function ProcessForm1325Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  AI_CertForm_ID = 1326;
  //Appraiser Section math id
  ap_SRA  = 1;
  ap_MAI  = 2;
  ap_SRPA = 3;
  ap_GRS  = 4;
  ap_RRS  = 5;
  ap_CAN  = 6;
  ap_PRAC = 7;
  //Co-Appriaser Section math id
  cp_SRA  = 8;
  cp_MAI  = 9;
  cp_SRPA = 10;
  cp_GRS  = 11;
  cp_RRS  = 12;
  cp_CAN  = 13;
  cp_PRAC = 14;

  ap_CandidateCellNo = 15;
  cp_CandidateCellNo = 25;
var
  frm: TDocForm;
begin
  if Cmd > 0 then
    begin
      frm := doc.GetFormByOccurance(AI_CertForm_ID, 0, True); //occur is zero based
      if assigned(frm) then
        begin
          repeat
            case Cmd of //Math id 1-7 is for Appraiser section, Math id 8-14 is for Co-Appraiser section
              1..7:  Cmd := LoadComment_AP(Cmd,doc, frm, cx, ap_CandidateCellNo);
              8..14: Cmd := LoadComment_CP(Cmd,doc, frm, cx, cp_CandidateCellNo);
            else
              Cmd := 0;
            end;
          until Cmd = 0;
        end;
    end;
  result := 0;
end;


function F1328C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
  AcrePrice = 38;
  TotalAdj  = 61;
  FinalAmt  = 62;
  PlusChk   = 59;
  NegChk    = 60;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  NetPct := 0;
  GrsPct := 0;

  if appPref_AppraiserUseLandPriceUnits then
  saleValue := GetCellValue(doc, mcx(cx,AcrePrice))
  else
  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents


  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    SumOfWeightedValues := SumOfWeightedValues + (1-GrsPct/100) * (saleValue+ NetAdj);
    SumOfWeights := SumOfWeights + (1-GrsPct/100);
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

//New math for form 1328: AI Extra comp mimic from math 939
function ProcessForm1328Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := F1328SalesCompAppC1Adjustments(doc, cx);
        2: Cmd := F1328SalesCompAppC2Adjustments(doc, cx);
        3: Cmd := F1328SalesCompAppC3Adjustments(doc, cx);
        //dynamic form name
        40:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 44,108,172);
        41:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 44,108,172, 2);
        42:
          cmd := ConfigXXXInstance(doc, cx, 44,108,172);

        //Sales Comparison Approach----------------------------------------------------------------
        43: Cmd := DivideABPercent(doc, mcx(cx,11), mcx(CX,10), mcx(CX,13));
        44: Cmd := DivideAB(doc, mcx(cx,11), mcx(CX,29), mcx(CX,16));
        45: Cmd := ProcessMultipleCmds(ProcessForm1328Math, doc, CX,[44,43,61]);
        46: Cmd := DivideABPercent(doc, mcx(cx,52), mcx(CX,51), mcx(CX,54));
        47: Cmd := DivideAB(doc, mcx(cx,52), mcx(cx,82), mcx(cx,57));     //price/sqft
        48: Cmd := ProcessMultipleCmds(ProcessForm1328Math, doc, CX,[47,46,49,62]);
        49: Cmd := F1328SalesCompAppC1Adjustments(doc, cx);
        51: Cmd := DivideABPercent(doc, mcx(cx,116), mcx(CX,115), mcx(CX,118));
        52: Cmd := DivideAB(doc, mcx(cx,116), mcx(cx,146), mcx(cx,121));     //price/sqft
        53: Cmd := ProcessMultipleCmds(ProcessForm1328Math, doc, CX,[52,51,54,63]);
        54: Cmd := F1328SalesCompAppC2Adjustments(doc, cx);
        56: Cmd := DivideABPercent(doc, mcx(CX,180), mcx(CX,179), mcx(CX,182));
        57: Cmd := DivideAB(doc, mcx(cx,180), mcx(cx,210), mcx(cx,185));     //price/sqft
        58: Cmd := ProcessMultipleCmds(ProcessForm1328Math, doc, CX,[57,56,59,64]);
        59: Cmd := F1328SalesCompAppC3Adjustments(doc, cx);
        61: Cmd := DivideABPercent(doc, mcx(cx,11), mcx(CX,9), mcx(CX,12));
        62: Cmd := DivideABPercent(doc, mcx(cx,52), mcx(CX,50), mcx(CX,53));
        63: Cmd := DivideABPercent(doc, mcx(cx,116), mcx(CX,114), mcx(CX,117));
        64: Cmd := DivideABPercent(doc, mcx(cx,180), mcx(CX,178), mcx(CX,181));
        60: Cmd := CalcWeightedAvg(doc, [1328,1312,1320]);   //calc wtAvg of main and xcomps forms

        65:
           begin                              //Math ID 12 is for Weighted Average
             F1328SalesCompAppC1Adjustments(doc, cx);     //sum of adjs
             F1328SalesCompAppC2Adjustments(doc, cx);     //sum of adjs
             F1328SalesCompAppC3Adjustments(doc, cx);     //sum of adjs
             Cmd := 0;
           end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          ProcessForm1328Math(doc, 1, CX);
          ProcessForm1328Math(doc, 2, CX);
          ProcessForm1328Math(doc, 3, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;
          ProcessForm1328Math(doc, 65, CX);
        end;
    end;
  result := 0;
end;

end.
