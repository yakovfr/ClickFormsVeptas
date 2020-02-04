unit UMathERC;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  ERCRpt91          = 80;
  ERCCondo91        = 81;
  ERCBkr91          = 82;
  fmERCMkt91        = 83;
  fmERC_Rpt94       = 84;
  fmERC_Rpt94XComps = 89;
  ERCBkr96          = 85;
  ERCHInsp          = 86;
  fmERC_Rpt03       = 95;  //same as 87, except for text
  fmERC_Rpt01       = 87;  //2001 version
  fmERC01XLists     = 78;
  fmERC01XComps     = 79;
  fmERC_Rpt10       = 916;    //main form updated 2010
  fmERC10XLists     = 917;    //extra listings
  fmERC10XComps     = 918;    //extra comps

  function ProcessForm0081Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0083Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0084Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0085Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0087Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0089Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0079Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0078Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0916Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0917Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0918Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;



implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;




{****************************}
{      ERC2001 Report        }
{****************************}

function F0087ProcessFourCmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0087Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0087Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0087Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0087Math(doc, C4, CX);
  result := 0;
end;


function F0087C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
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
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0087C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 100;
  TotalAdj  = 156;
  FinalAmt  = 157;
  PlusChk   = 154;
  NegChk    = 155;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0087C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 163;
  TotalAdj  = 219;
  FinalAmt  = 220;
  PlusChk   = 217;
  NegChk    = 218;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,180), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,197), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,199), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,203), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0087PresentLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc, cx, 51,52,53,54,55,57,0,0);
  SetInfoCellValue(doc, mcx(cx, 1), V1);
  result := 0;
end;

Function RoomCount(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc,cx, 96,97,98,99,100,102,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 105,106,107,108,109,111,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 115,116,117,118,119,121,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 125,126,127,128,129,131,0,0);
  result := SetCellValue(doc, mcx(cx,150), V1);
end;


Function F0087SiteAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    116: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    117: if CellIsChecked(doc, cx) then S1 := 'Good';
    118: if CellIsChecked(doc, cx) then S1 := 'Average';
    119: if CellIsChecked(doc, cx) then S1 := 'Fair';
    120: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,39), S1);
end;

Function F0916SiteAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    137: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    138: if CellIsChecked(doc, cx) then S1 := 'Good';
    139: if CellIsChecked(doc, cx) then S1 := 'Average';
    140: if CellIsChecked(doc, cx) then S1 := 'Fair';
    141: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,14), S1);
end;

Function F0087NeighborhoodAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    68: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    69: if CellIsChecked(doc, cx) then S1 := 'Good';
    70: if CellIsChecked(doc, cx) then S1 := 'Average';
    71: if CellIsChecked(doc, cx) then S1 := 'Fair';
    72: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,37), S1);
end;

Function F0916NeighborhoodAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    88: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    89: if CellIsChecked(doc, cx) then S1 := 'Good';
    90: if CellIsChecked(doc, cx) then S1 := 'Average';
    91: if CellIsChecked(doc, cx) then S1 := 'Fair';
    92: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,12), S1);
end;

Function F0087ExteriorAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
begin
  case CX.Num+1 of
    162: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    163: if CellIsChecked(doc, cx) then S1 := 'Good';
    164: if CellIsChecked(doc, cx) then S1 := 'Average';
    165: if CellIsChecked(doc, cx) then S1 := 'Fair';
    166: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  S2 := GetCellString(doc, mcx(cx,27));   //get the design
  if (length(S1)>0) and (length(S2)>0) then
    S1 := S2 + '/' + S1
  else if length(S2)>0 then
    S1 := S2;

  result := SetCellString(doc, MCPX(cx,4,40), S1);
end;

Function F0916ExteriorAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
begin
  case CX.Num+1 of
    172: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    173: if CellIsChecked(doc, cx) then S1 := 'Good';
    174: if CellIsChecked(doc, cx) then S1 := 'Average';
    175: if CellIsChecked(doc, cx) then S1 := 'Fair';
    176: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  S2 := GetCellString(doc, mcx(cx,17));   //get the design
  if (length(S1)>0) and (length(S2)>0) then
    S1 := S2 + '/' + S1
  else if length(S2)>0 then
    S1 := S2;

  result := SetCellString(doc, MCPX(cx,6,15), S1);
end;



Function F0087QualityConstruction(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    167: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    168: if CellIsChecked(doc, cx) then S1 := 'Good';
    169: if CellIsChecked(doc, cx) then S1 := 'Average';
    170: if CellIsChecked(doc, cx) then S1 := 'Fair';
    171: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,41), S1);
end;

Function F0916QualityConstruction(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    177: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    178: if CellIsChecked(doc, cx) then S1 := 'Good';
    179: if CellIsChecked(doc, cx) then S1 := 'Average';
    180: if CellIsChecked(doc, cx) then S1 := 'Fair';
    181: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,16), S1);
end;


Function F0087Condition(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    172: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    173: if CellIsChecked(doc, cx) then S1 := 'Good';
    174: if CellIsChecked(doc, cx) then S1 := 'Average';
    175: if CellIsChecked(doc, cx) then S1 := 'Fair';
    176: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,43), S1);
end;

Function F0916Condition(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    182: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    183: if CellIsChecked(doc, cx) then S1 := 'Good';
    184: if CellIsChecked(doc, cx) then S1 := 'Average';
    185: if CellIsChecked(doc, cx) then S1 := 'Fair';
    186: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,18), S1);
end;

Function F0087InteriorAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    177: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    178: if CellIsChecked(doc, cx) then S1 := 'Good';
    179: if CellIsChecked(doc, cx) then S1 := 'Average';
    180: if CellIsChecked(doc, cx) then S1 := 'Fair';
    181: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,44), S1);
end;

Function F0916InteriorAppeal(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    187: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    188: if CellIsChecked(doc, cx) then S1 := 'Good';
    189: if CellIsChecked(doc, cx) then S1 := 'Average';
    190: if CellIsChecked(doc, cx) then S1 := 'Fair';
    191: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,19), S1);
end;

Function F0087FunctionalUtil(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    182: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    183: if CellIsChecked(doc, cx) then S1 := 'Good';
    184: if CellIsChecked(doc, cx) then S1 := 'Average';
    185: if CellIsChecked(doc, cx) then S1 := 'Fair';
    186: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,4,51), S1);
end;

Function F0087NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, cx) then
    begin
      EraseCell(doc, mcx(cx,16));
      EraseCell(doc, mcx(cx,17));
      EraseCell(doc, mcx(cx,18));
      EraseCell(doc, mcx(cx,19));
      EraseCell(doc, mcx(cx,20));
      EraseCell(doc, mcx(cx,21));
      EraseCell(doc, mcx(cx,22));
      EraseCell(doc, mcx(cx,23));
    end;
  result := EraseCell(doc, mcpx(cx,4,53));
end;

Function F0087CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1: Double;
begin
  result := 0;

  //adjust only on garages
  V1 := GetArraySum(doc, cx, [59,60,61]);
  if V1 > 0 then
    S1 := IntToStr(Trunc(V1)) + ' Car Garage';
  if length(S1) > 0 then
    result := SetCellString(doc, MCPX(cx,6,28), S1);
end;

Function F0087HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
begin
  S1 := GetCellString(doc, mcx(cx,83));   //get the heating type
  S2 := GetCellString(doc, mcx(cx,84));   //get the fuel type
  S1 := S1 +' '+ S2;
  if CellIsChecked(doc, mcx(cx,85)) then S2 := 'Central';

  if (length(S1)>0) and (length(S2)>0) then
    S1 := S1 + '/' + S2
  else if length(S2)>0 then
    S1 := S2;

  result := SetCellString(doc, MCPX(cx,4,52), S1);
end;

Function F0087Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  S1 := GetCellString(doc, cx);
  if length(S1)>0 then
    S1 := S1 + ' Fireplace(s)';
  result := SetCellString(doc, MCPX(cx,4,54), S1);
end;

function F0087CityStateZip(doc: TContainer; CX: CellUID; City, State, Zip: Integer): Integer;
var
  S1,S2,S3: String;
begin
  S1 := GetCellString(doc, mcx(cx,City));
  S2 := GetCellString(doc, mcx(cx,State));
  S3 := GetCellString(doc, mcx(cx,Zip));
  if (length(S1)>0) and (length(S2)>0) then
    S1 := S1 + ', ' + S2 + ' '+ S3
  else
    S1 := S1 + S2 + S3;
  result := SetCellString(doc, MCPX(cx,4,32), S1);
end;

Function F0087FinishedBasement(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  S1 := GetCellString(doc, cx);
  if length(S1)>0 then
    S1 := S1 + ' Finished';
  result := SetCellString(doc, MCPX(cx,4,50), S1);
end;

{*********************************}
{    ERC 2010          }
{*********************************}

Function F0916RoomCount(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc,cx, 98,99,100,101,102,104,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 107,108,109,110,111,113,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 117,118,119,120,121,123,0,0);
  V1 := V1 + Get8CellSumR(doc,cx, 127,128,129,130,131,133,0,0);
  result := SetCellValue(doc, mcx(cx,152), V1);
end;

Function F0916OwnerUnitPercent(doc: Tcontainer; CellA, CellB, CellR: CellUID): Integer;
var
  V1,V2,Vr: Double;
  cmd : Integer;
begin
  V1 := GetCellValue(doc, CellA);
  V2 := GetCellValue(doc, CellB);
 cmd := 0;
 if V2 <> 0 then
 begin
   VR := (V1 / V2) * 100;
   cmd := SetCellValue(doc, CellR, VR);
 end;
 result := cmd;
end;

function F0916PresentLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc, cx, 72,73,74,75,76,78,0,0);
  SetInfoCellValue(doc, mcx(cx, 1), V1);
  result := 0;
end;

Function F0916Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  S1 := GetCellString(doc, mcx(cx,85));
  if length(S1)>0 then
    S1 := S1 + ' Fireplace(s)';
  result := SetCellString(doc, MCPX(cx,6,29), S1);
end;

Function F0916FinishedBasement(doc: TContainer; CX: CellUID): Integer; //Ticket #1375: set finsh % and Finished if not there then populate to other forms with context id = 406
var
  S1: String;
  aPercent: Double;
  cell: TBaseCell;
  f, p, c: Integer;
begin
  result := 0;
  S1 := GetCellString(doc, mcx(cx,73));
  aPercent := GetStrValue(S1);
  if aPercent <> 0 then
    begin
      if (pos('%', S1) > 0) and (pos('FINISHED', UpperCase(S1)) > 0) then
        S1 := S1
      else if (pos('%', S1) = 0) and (pos('FINISHED', UpperCase(S1)) = 0) then
        S1 := Format('%s%% Finished',[trim(S1)])
      else if (pos('%', S1) = 0) then
        begin
          if pos('.', S1) > 0 then
            S1 := Format('%.2f%% Finished',[aPercent])  //we need to show decimal
          else
            S1 := Format('%d%% Finished',[GetValidInteger(S1)])
        end
      else if pos('FINISHED', UpperCase(S1)) = 0 then
        S1 := S1 + ' Finished';
      SetCellString(doc, mcx(cx, 73), S1);
      result := SetCellString(doc, MCPX(cx,6,25), S1);

      for f := 0 to doc.docForm.Count - 1 do
        if Assigned(doc.docForm[f].frmPage) then
          for p := 0 to doc.docForm[f].frmPage.Count - 1 do
            if Assigned(doc.docForm[f].frmPage[p].pgData) then
              for c := 0 to doc.docForm[f].frmPage[p].pgData.Count - 1 do
                 begin
                   cell := doc.docForm[f].frmPage[p].pgData[c];
                   if assigned(cell) and (cell.FContextID = 406) then
                       cell.Text := S1;
                 end;
    end;
end;

Function F0916BasementArea(doc: TContainer; CX: CellUID): Integer;   //Ticket #1375, set basement area and add sf if not there then populate to other forms with the same context id
var
  bsmt: String;
  cell: TBaseCell;
  f, p, c: Integer;
begin
  result := 0;
  bsmt := GetCellString(doc, mcpx(cx, 3, 72));
  if GetValidInteger(bsmt) > 0 then
    begin
      if pos('sf', lowercase(bsmt)) = 0 then
        bsmt := bsmt+' sf';
      SetCellString(doc, MCPX(cx, 3, 72), bsmt);
      SetCellString(doc, MCPX(cx, 5, 19),bsmt);
      result := SetCellString(doc, MCPX(cx, 6, 24), bsmt);

      for f := 0 to doc.docForm.Count - 1 do
        if Assigned(doc.docForm[f].frmPage) then
          for p := 0 to doc.docForm[f].frmPage.Count - 1 do
            if Assigned(doc.docForm[f].frmPage[p].pgData) then
              for c := 0 to doc.docForm[f].frmPage[p].pgData.Count - 1 do
                 begin
                   cell := doc.docForm[f].frmPage[p].pgData[c];
                   if assigned(cell) and (cell.FContextID = 405) then
                       cell.Text := bsmt;
                 end;
    end;
end;


Function F0916HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
begin
  S1 := GetCellString(doc, mcx(cx,54));   //get the heating type
  S2 := GetCellString(doc, mcx(cx,55));   //get the fuel type
  S1 := S1 +' '+ S2;
  if CellIsChecked(doc, mcx(cx,56)) then S2 := 'Central';

  if (length(S1)>0) and (length(S2)>0) then
    S1 := S1 + '/' + S2
  else if length(S2)>0 then
    S1 := S2;

  result := SetCellString(doc, MCPX(cx,6,27), S1);
end;

Function F0916CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1: Double;
begin
  result := 0;

  //adjust only on garages
  V1 := GetArraySum(doc, cx, [59,60,61]);
  if V1 > 0 then
    S1 := IntToStr(Trunc(V1)) + ' Car Garage';
  if length(S1) > 0 then
    result := SetCellString(doc, MCPX(cx,6,28), S1);
{
  if GetCellValue(doc, mcx(cx,200)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,200));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,202)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,202));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,195)) Then
    SetCellChkMark(doc, MCX(cx,195), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm0340Math(doc, Cmd, MCPX(CX,2,37));
    end;
  result := 0;
}
end;

Function F0916FunctionalUtil(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  case CX.Num+1 of
    192: if CellIsChecked(doc, cx) then S1 := 'Excellent';
    193: if CellIsChecked(doc, cx) then S1 := 'Good';
    194: if CellIsChecked(doc, cx) then S1 := 'Average';
    195: if CellIsChecked(doc, cx) then S1 := 'Fair';
    196: if CellIsChecked(doc, cx) then S1 := 'Poor';
  else
    S1 := '';
  end;
  result := SetCellString(doc, MCPX(cx,6,26), S1);
end;



{*********************************}
{    ERC 2001 Extra Comps         }
{*********************************}

function F0079ProcessFourCmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0079Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0079Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0079Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0079Math(doc, C4, CX);
  result := 0;
end;

function F0079C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 49;
  TotalAdj  = 105;
  FinalAmt  = 106;
  PlusChk   = 103;
  NegChk    = 104;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0079C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 113;
  TotalAdj  = 169;
  FinalAmt  = 170;
  PlusChk   = 167;
  NegChk    = 168;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0079C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 177;
  TotalAdj  = 233;
  FinalAmt  = 234;
  PlusChk   = 231;
  NegChk    = 232;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,225), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,227), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,229), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;



//ERC Market Analysis Addendum Comps
function F0083C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  TotalAdj  = 91;
  FinalAmt  = 92;
  PlusChk   = 89;
  NegChk    = 90;
  InfoNet   = 0;
  InfoGross = 0;
var
  NetAdj,GrsAdj: Double;
  saleValue{, NetPct, GrsPct}: Double;
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
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,88), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents
(*
  NetPct := 0;
  GrsPct := 0;
  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells
*)
  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0083C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  TotalAdj  = 153;
  FinalAmt  = 154;
  PlusChk   = 151;
  NegChk    = 152;
  InfoNet   = 0;
  InfoGross = 0;
var
  NetAdj,GrsAdj: Double;
  saleValue{, NetPct, GrsPct}: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents
(*
  NetPct := 0;
  GrsPct := 0;
  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells
*)
  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0083C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 159;
  TotalAdj  = 215;
  FinalAmt  = 216;
  PlusChk   = 213;
  NegChk    = 214;
  InfoNet   = 0;
  InfoGross = 0;
var
  NetAdj,GrsAdj: Double;
  saleValue{, NetPct, GrsPct}: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,206), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,208), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx,NegChk), True);

  saleValue := GetCellValue(doc, mcx(cx,salesAmt));      //calc the net/grs percents
(*
  NetPct := 0;
  GrsPct := 0;
  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells
*)
  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

//ERC Report 94 Comp Adjustments
function F0084C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 38;
  TotalAdj  = 101;
  FinalAmt  = 102;
  PlusChk   = 99;
  NegChk    = 100;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0084C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 108;
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
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0084C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 178;
  TotalAdj  = 241;
  FinalAmt  = 242;
  PlusChk   = 239;
  NegChk    = 240;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,225), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,227), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,229), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,231), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,233), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,235), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,237), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

{*********************************}
{    ERC 1994 Extra Comps         }
{*********************************}

function F0089ProcessFourCmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0089Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0089Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0089Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0089Math(doc, C4, CX);
  result := 0;
end;

function F0089C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 52;
  TotalAdj  = 115;
  FinalAmt  = 116;
  PlusChk   = 113;
  NegChk    = 114;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0089C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 123;
  TotalAdj  = 186;
  FinalAmt  = 187;
  PlusChk   = 184;
  NegChk    = 185;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,180), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0089C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 194;
  TotalAdj  = 257;
  FinalAmt  = 258;
  PlusChk   = 255;
  NegChk    = 256;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,206), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,208), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,225), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,227), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,229), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,231), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,233), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,235), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,237), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,239), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,241), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,243), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,245), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,247), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,249), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,251), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,253), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,254), NetAdj, GrsAdj);

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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;


// 2010 ERC main form comp adjustments
function F0916C1Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
  addr: String;
begin
  //github #78
   curMath := (cmd = 12) or (cmd = 16) or (cmd = 20);
   curCell := (CX.Num = 98) or (CX.Num = 165) or (CX.Num = 232);
   addr := GetCellString(doc, mcx(cx,35));   //get the address
   if curMath  and curCell and (addr <> '') then
     result := SalesGridAdjustmentwithForecast(doc, CX, 42,100,101,97,98,3,4, 99, 99,  166, 233,
            [49,51,53,55,57,59,61,63,65,67,69,71,73,75,78,80,82,84,86,88,90,92,94,96,99], 35, 102, 169)
    else
    result := SalesGridAdjustment(doc, CX, 42,100,101,97,98,3,4,
            [49,51,53,55,57,59,61,63,65,67,69,71,73,75,78,80,82,84,86,88,90,92,94,96,99]);
end;

function F0916C2Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
  addr: String;
begin
  //github #78
   curMath := (cmd = 12) or (cmd = 16) or (cmd = 20);
   curCell := (CX.Num = 98) or (CX.Num = 165) or (CX.Num = 232);
   addr := GetCellString(doc, mcx(cx,102));   //get the address
   if curMath  and curCell and (addr <> '') then
     result := SalesGridAdjustmentwithForecast(doc, CX, 109,167,168,164,165,5,6, 166, 99, 166, 233,
            [116,118,120,122,124,126,128,130,132,134,136,138,140,142,145,147,149,151,153,155,157,159,161,163,166],
             35, 102, 169)
    else
      result := SalesGridAdjustment(doc, CX, 109,167,168,164,165,5,6,
             [116,118,120,122,124,126,128,130,132,134,136,138,140,142,145,147,149,151,153,155,157,159,161,163,166]);
end;

function F0916C3Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
  addr: String;
begin
  //github #78
   curMath := (cmd = 12) or (cmd = 16) or (cmd = 20);
   curCell := (CX.Num = 98) or (CX.Num = 165) or (CX.Num = 232);
   addr := GetCellString(doc, mcx(cx,169));   //get the address
   if curMath  and curCell and (addr <> '') then
     result := SalesGridAdjustmentwithForecast(doc, CX, 176,234,235,231,232,7,8, 233, 99, 166, 233,
            [183,185,187,189,191,193,195,197,199,201,203,205,207,209,212,214,216,218,220,222,224,226,228,230,233],
             35, 102, 165)
    else
      result := SalesGridAdjustment(doc, CX, 176,234,235,231,232,7,8,
                [183,185,187,189,191,193,195,197,199,201,203,205,207,209,212,214,216,218,220,222,224,226,228,230,233]);
end;

// 2010 Extra comps adjustments
function F0918C1Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
begin
  //github #78
  curMath := (cmd = 6) or (cmd = 9) or (cmd = 12);
  curCell := (CX.Num = 110) or (CX.Num = 178) or (CX.Num = 246);
  if curMath and curCell then
    result := SalesGridAdjustmentwithForecast(doc, CX, 54,112,113,109,110,3,4, 111, 111, 179, 247,
                [61,63,65,67,69,71,73,75,77,79,81,83,85,87,90,92,94,96,98,100,102,104,106,108,111],
                47, 115, 183)
    else
      result := SalesGridAdjustment(doc, CX, 54,112,113,109,110,3,4,
                [61,63,65,67,69,71,73,75,77,79,81,83,85,87,90,92,94,96,98,100,102,104,106,108,111]);
end;

function F0918C2Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
begin
  //github #78
  curMath := (cmd = 6) or (cmd = 9) or (cmd = 12);
  curCell := (CX.Num = 110) or (CX.Num = 178) or (CX.Num = 246);
  if curMath and curCell then
    result := SalesGridAdjustmentwithForecast(doc, CX, 122,180,181,177,178,5,6, 179, 111, 179, 247,
                [129,131,133,135,137,139,141,143,145,147,149,151,153,155,158,160,162,164,166,168,170,172,174,176,179],
                47, 115, 183)
  else
    result := SalesGridAdjustment(doc, CX, 122,180,181,177,178,5,6,
                [129,131,133,135,137,139,141,143,145,147,149,151,153,155,158,160,162,164,166,168,170,172,174,176,179]);
end;

function F0918C3Adjustments(doc: TContainer; CX: CellUID; cmd: Integer) : Integer;
var
  curMath, curCell: Boolean;
begin
  curMath := (cmd = 6) or (cmd = 9) or (cmd = 12);
  curCell := (CX.Num = 110) or (CX.Num = 178) or (CX.Num = 246);
  if curMath and curCell then
    result := SalesGridAdjustmentwithForecast(doc, CX, 190,248,249,245,246,7,8, 247, 111, 179, 247,
               [197,199,201,203,205,207,209,211,213,215,217,219,221,223,226,228,230,232,234,236,238,240,242,244,247],
               47, 115, 183)
  else
    result := SalesGridAdjustment(doc, CX, 190,248,249,245,246,7,8,
              [197,199,201,203,205,207,209,211,213,215,217,219,221,223,226,228,230,232,234,236,238,240,242,244,247]);
end;



//ERC Condo Addendum
function ProcessForm0081Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd :=0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//ERC Market Data Analysis Addendum
function ProcessForm0083Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := 0; //SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',31,93,155, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 31,93,155);
        3:
          cmd := ConfigXXXInstance(doc, cx, 31,93,155);

              //Comp1 calcs
        4:   //sales price changed
          Cmd := F0083C1Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F0083C1Adjustments(doc, cx);       //sum of adjs

              //Comp2 calcs
        7:   //sales price changed
          Cmd := F0083C2Adjustments(doc, cx);   //redo the adjustments
        8:
          cmd := F0083C2Adjustments(doc, cx);     //sum of adjs

              //Comp3 calcs
        10:   //sales price changed
          Cmd := F0083C3Adjustments(doc, cx);   //redo the adjustments
        11:
          cmd := F0083C3Adjustments(doc, cx);     //sum of adjs
        12:
          cmd := CalcWeightedAvg(doc, [83]);   //calc wtAvg of main and xcomps forms
        13:
          begin
            F0083C1Adjustments(doc, cx);
            F0083C2Adjustments(doc, cx);     //sum of adjs
            F0083C3Adjustments(doc, cx);     //sum of adjs
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0083Math(doc, 5, CX);
          ProcessForm0083Math(doc, 8, CX);
          ProcessForm0083Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0083Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

//ERC Report 94
function ProcessForm0084Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //Comp1 calcs
        1:   //sales price changed
          Cmd := F0084C1Adjustments(doc, cx);     //redo the adjustments
        2:
          cmd := F0084C1Adjustments(doc, cx);       //sum of adjs

        //Comp2 calcs
        3:   //sales price changed
          Cmd := F0084C2Adjustments(doc, cx);   //redo the adjustments
        4:
          cmd := F0084C2Adjustments(doc, cx);     //sum of adjs

        //Comp3 calcs
        5:   //sales price changed
          Cmd := F0084C3Adjustments(doc, cx);   //redo the adjustments
        6:
          cmd := F0084C3Adjustments(doc, cx);     //sum of adjs
        7:
          cmd := CalcWeightedAvg(doc, [84,89]);   //calc wtAvg of main and xcomps forms
        8:
          begin
            F0084C1Adjustments(doc, cx);     //sum of adjs
            F0084C2Adjustments(doc, cx);     //sum of adjs
            F0084C3Adjustments(doc, cx);     //sum of adjs
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 4;    //math is on page 5
          ProcessForm0084Math(doc, 2, CX);
          ProcessForm0084Math(doc, 4, CX);
          ProcessForm0084Math(doc, 6, CX);
        end;
      -2:
        begin
          CX.pg := 4;    //math is on page 5
          ProcessForm0084Math(doc, 8, CX);
        end;
    end;

  result := 0;
end;

//ERC Brokers 96
function ProcessForm0085Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd :=0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//ERC Report 2001 Extra Comps
function ProcessForm0079Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',43,107,171, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 43,107,171);
        3:
          cmd := ConfigXXXInstance(doc, cx, 43,107,171);
  //C1 area
        4:
          cmd := DivideAB(doc, mcx(cx,49), mcx(cx,47), mcx(cx,48));  //sale/list ratio
        5:
          cmd := F0079ProcessFourCmds(doc, cx, 4,6,0,0);  //sale price chged
        6:
          cmd := F0079C1Adjustments(doc, cx);       //do all adjs
  //C2 area
        7:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,111), mcx(cx,112));  //sale/list ratio
        8:
          cmd := F0079ProcessFourCmds(doc, cx, 7,9,0,0);  //sale price chged
        9:
          cmd := F0079C2Adjustments(doc, cx);       //do all adjs
  //C3 area
        10:
          cmd := DivideAB(doc, mcx(cx,177), mcx(cx,175), mcx(cx,176));  //sale/list ratio
        11:
          cmd := F0079ProcessFourCmds(doc, cx, 10,12,0,0);  //sale price chged
        12:
          cmd := F0079C3Adjustments(doc, cx);       //do all adjs
        13:
          cmd := CalcWeightedAvg(doc, [95,79]);   //calc wtAvg of main and xcomps forms
        14:
          begin
            F0079C1Adjustments(doc, cx);       //do all adjs
            F0079C2Adjustments(doc, cx);       //do all adjs
            F0079C3Adjustments(doc, cx);       //do all adj
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0079Math(doc, 6, CX);
          ProcessForm0079Math(doc, 9, CX);
          ProcessForm0079Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0079Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

//ERC Report 2001 Extra Listings
function ProcessForm0078Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS', 'ADDENDUM',47,78,109, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listing', 47,78,109);
        3:
          cmd := ConfigXXXInstance(doc, cx, 47,78,109);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//ERC Report 2010 Extra Listings
function ProcessForm0917Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS', 'ADDENDUM',36,63,90, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listing', 36,63,90);
        3:
          cmd := ConfigXXXInstance(doc, cx, 36,63,90);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//ERC Report 2001
function ProcessForm0087Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
  //sales comparison
        1:
          cmd :=F0087PresentLandUse(doc, cx);
        2:
          cmd := SiteDimension(doc, mcx(cx,73), mcx(cx,74));
        3:
          cmd := RoomCount(doc, cx);
        4:
          cmd := SumFourCellsR(doc, cx, 100,109,119,129, 151);    //sum bedrooms
        5:
          cmd := SumFourCellsR(doc, cx, 101,110,120,130, 152);    //sum baths
        6:
          cmd := F0087ProcessFourCmds(doc, cx, 3,4,0,0);    //chged bed count
        7:
          cmd := F0087ProcessFourCmds(doc, cx, 3,5,0,0);    //chged bath count
        8:
          cmd := SumFourCellsR(doc, cx, 104,113,123,133, 153);  //sum GLA
  //C1 area
        10:
          cmd := DivideAB(doc, mcx(cx,37), mcx(cx,35), mcx(cx,36));  //sale/list ratio
        11:
          cmd := F0087ProcessFourCmds(doc, cx, 10,12,0,0);  //sale price chged
        12:
          cmd := F0087C1Adjustments(doc, cx);       //do all adjs
        13:
          cmd := 0; //sqft adj
  //C2 area
        14:
          cmd := DivideAB(doc, mcx(cx,100), mcx(cx,98), mcx(cx,99));  //sale/list ratio
        15:
          cmd := F0087ProcessFourCmds(doc, cx, 14,16,0,0);  //sale price chged
        16:
          cmd := F0087C2Adjustments(doc, cx);       //do all adjs
        17:
          cmd := 0; //sqft
  //C3 area
        18:
          cmd := DivideAB(doc, mcx(cx,163), mcx(cx,161), mcx(cx,162));  //sale/list ratio
        19:
          cmd := F0087ProcessFourCmds(doc, cx, 18,20,0,0);  //sale price chged
        20:
          cmd := F0087C3Adjustments(doc, cx);       //do all adjs
        21:
          cmd := 0; //sqft
  //All transfers
        22:
          cmd := F0087SiteAppeal(doc, cx);
        23:
          cmd := F0087NeighborhoodAppeal(doc, cx);
        24:
          cmd := F0087NoCarStorage(doc, cx);
        25:
          cmd := F0087CarStorage(doc, cx);
        26:
          cmd := F0087HeatingCooling(doc, cx);
        27:
          cmd := F0087Fireplaces(doc, cx);
        28:
          cmd := F0087FinishedBasement(doc, cx);
        29:
          cmd := F0087ExteriorAppeal(doc, cx);
        30:
          cmd := F0087QualityConstruction(doc, cx);
        31:
          cmd := F0087Condition(doc, cx);
        32:
          cmd := F0087InteriorAppeal(doc, cx);
        33:
          cmd := F0087FunctionalUtil(doc, cx);
        34:
          cmd := 0;   //TransA2B(doc, mcx(cx,9), mcpx(cx,4,31));   //transfer address to grid
        35:
          cmd := 0;   //F0087CityStateZip(doc, cx, 11,12,13);  {caused recursive loop}
        36:
          cmd := CalcWeightedAvg(doc, [CX.FormID,79]);   //calc wtAvg of main and xcomps forms
        37:
          begin
            F0087C1Adjustments(doc, cx);       //do all adjs
            F0087C2Adjustments(doc, cx);       //do all adjs
            F0087C3Adjustments(doc, cx);       //do all adjs
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 4;    //math is on page 5
          ProcessForm0087Math(doc, 12, CX);
          ProcessForm0087Math(doc, 16, CX);
          ProcessForm0087Math(doc, 20, CX);
        end;
      -2:
        begin
          CX.pg := 4;    //math is on page 5
          ProcessForm0087Math(doc, 37, CX);
        end;
    end;

  result := 0;
end;


//ERC Report 94 XComps math
function ProcessForm0089Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',46,117,188, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 46,117,188);
        3:
          cmd := ConfigXXXInstance(doc, cx, 46,117,188);
  //C1 area
        4:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,50), mcx(cx,51));  //sale/list ratio
        5:
          cmd := F0089ProcessFourCmds(doc, cx, 4,6,0,0);  //sale price chged
        6:
          cmd := F0089C1Adjustments(doc, cx);       //do all adjs
  //C2 area
        7:
          cmd := DivideAB(doc, mcx(cx,123), mcx(cx,121), mcx(cx,122));  //sale/list ratio
        8:
          cmd := F0089ProcessFourCmds(doc, cx, 7,9,0,0);  //sale price chged
        9:
          cmd := F0089C2Adjustments(doc, cx);       //do all adjs
  //C3 area
        10:
          cmd := DivideAB(doc, mcx(cx,194), mcx(cx,192), mcx(cx,193));  //sale/list ratio
        11:
          cmd := F0089ProcessFourCmds(doc, cx, 10,12,0,0);  //sale price chged
        12:
          cmd := F0089C3Adjustments(doc, cx);       //do all adjs
        13:
          cmd := CalcWeightedAvg(doc, [84,89]);   //calc wtAvg of main and xcomps forms
        14:
          begin
            F0089C1Adjustments(doc, cx);       //do all adjs
            F0089C2Adjustments(doc, cx);       //do all adjs
            F0089C3Adjustments(doc, cx);       //do all adjs
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0089Math(doc, 6, CX);
          ProcessForm0089Math(doc, 9, CX);
          ProcessForm0089Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0089Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

function F0916PercentOwner(doc: TContainer; CX: CellUID):Integer;
var
  OTotal, OUnit, OPercnt: Double;  //cell 24, 25, 26
begin
  OTotal := GetCellValue(doc, mcx(cx,24));
  OUnit  := GetCellValue(doc, mcx(cx,25));
  if (OTotal <> 0) and (OUnit <> 0) then
    begin
      OPercnt := (OUnit/OTotal) * 100;
      SetCellValue(doc, mcx(cx, 26), OPercnt);
    end;
  result := 0;
end;

//ERC Report 2010
function ProcessForm0916Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
  //sales comparison
        1: cmd := F0916PresentLandUse(doc, cx);
        2: cmd := SiteDimension(doc, mcx(cx,93), mcx(cx,94));
        3: cmd := F0916PercentOwner(doc, cx);
        4: cmd := SumFourCellsR(doc, cx, 102,111,121,131,152);                    //sum bedrooms
        5: cmd := SumFourCellsR(doc, cx, 103,112,122,132,153);                    //sum baths
        6: cmd := SumFourCellsR(doc, cx, 102,111,121,131, 152);     //Ticket #1398 Sum up 4 bed rooms and populate to cell 152                                                              //
        7: cmd := SumFourCellsR(doc, cx, 103, 112, 122, 132, 153); //Ticket #1398 Sum up 4 bath rooms and populate to cell 153                                                              //
        8: cmd := SumFourCellsR(doc, cx, 106,115,125,135,154);                    //sum GLA
        9: cmd := PercentAOfB(doc, mcx(cx,42), mcx(cx,40), mcx(cx,41));           //sale/list ratio
       10: cmd := PercentAOfB(doc, mcx(cx,42), mcx(cx,38), mcx(cx,39));           //sale/list ratio
       11: cmd := ProcessMultipleCmds(ProcessForm0916Math, doc, cx, [10,9,12]);   //sale price chged
       12: cmd := F0916C1Adjustments(doc, cx, cmd);
       13: cmd := PercentAOfB(doc, mcx(cx,109), mcx(cx,107), mcx(cx,108));        //sale/list ratio
       14: cmd := PercentAOfB(doc, mcx(cx,109), mcx(cx,105), mcx(cx,106));        //sale/list ratio
       15: cmd := ProcessMultipleCmds(ProcessForm0916Math, doc, cx, [14,13,16]);  //sale price chged
       16: cmd := F0916C2Adjustments(doc, cx, 16);                                    //do all adjs
       17: cmd := PercentAOfB(doc, mcx(cx,176), mcx(cx,174), mcx(cx,175));        //sale/list ratio
       18: cmd := PercentAOfB(doc, mcx(cx,176), mcx(cx,172), mcx(cx,173));        //sale/list ratio
       19: cmd := ProcessMultipleCmds(ProcessForm0916Math, doc, cx, [18,17,20]);  //sale price chged
       20: cmd := F0916C3Adjustments(doc, cx, 20);
       22: cmd := F0916SiteAppeal(doc, cx);
       23: cmd := F0916NeighborhoodAppeal(doc, cx);
       25: cmd := F0916CarStorage(doc, cx);
       26: cmd := F0916HeatingCooling(doc, cx);
       27: cmd := 0;    //F0916Fireplaces(doc, cx);
       28: cmd := F0916FinishedBasement(doc, cx);
       29: cmd := F0916ExteriorAppeal(doc, cx);
       30: cmd := F0916QualityConstruction(doc, cx);
       31: cmd := F0916Condition(doc, cx);
       32: cmd := F0916InteriorAppeal(doc, cx);
       33: cmd := F0916FunctionalUtil(doc, cx);
       34: cmd := F0916OwnerUnitPercent(doc,mcx(cx,25), mcx(cx,24), mcx(cx,26));
       35: cmd := YearToAge(doc, mcx(cx,7), mcx(cx,8), nil);
       36: cmd := CalcWeightedAvg(doc, [CX.FormID,918]);
       37: begin
            F0916C1Adjustments(doc, cx, 0);       //do all adjs
            F0916C2Adjustments(doc, cx, 0);       //do all adjs
            F0916C3Adjustments(doc, cx, 0);       //do all adjs
            cmd := 0;
           end;
        40: cmd := DivideAB(doc, mcx(cx,26), mcx(cx,25), mcx(cx,27));     //closed sales - absorbtion rate
        41: cmd := DivideAB(doc, mcx(cx,34), mcx(cx,33), mcx(cx,35));
        42: cmd := DivideAB(doc, mcx(cx,42), mcx(cx,41), mcx(cx,43));
        43: cmd := DivideAB(doc, mcx(cx,50), mcx(cx,49), mcx(cx,51));
        44: cmd := DivideAB(doc, mcx(cx,58), mcx(cx,57), mcx(cx,59));
        45: cmd := DivideAB(doc, mcx(cx,66), mcx(cx,65), mcx(cx,67));
        46: cmd := DivideAB(doc, mcx(cx,74), mcx(cx,73), mcx(cx,75));
        47: cmd := DivideAB(doc, mcx(cx,82), mcx(cx,81), mcx(cx,83));

        49: cmd := DivideAB(doc, mcx(cx,137), mcx(cx,136), mcx(cx,138));      //current listings - abdorption rate
        50: cmd := DivideAB(doc, mcx(cx,139), mcx(cx,138), mcx(cx,140));      //supply of inventory

        48: cmd := F0916BasementArea(doc, cx);

      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 5; //math is on page 6
          ProcessForm0916Math(doc, 12, CX);
          ProcessForm0916Math(doc, 16, CX);
          ProcessForm0916Math(doc, 20, CX);
        end;
      -2:
        begin
          CX.pg := 5;    //math is on page 6
          ProcessForm0916Math(doc, 37, CX);
        end;
    end;
  result := 0;
end;

//ERC Report 2010 Extra Comps
function ProcessForm0918Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',46,114,182, 2);
        2: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 46,114,182);
        3: cmd := ConfigXXXInstance(doc, cx, 46,114,182);

        4: cmd := PercentAOfB(doc, mcx(cx,54), mcx(cx,50), mcx(cx,51));             //sale/list ratio
        5: cmd := ProcessMultipleCmds(ProcessForm0918Math, doc, cx, [4,15,6]);      //sale price chged
        6: cmd := F0918C1Adjustments(doc, cx, cmd);                                      //do all adjs
        7: cmd := PercentAOfB(doc, mcx(cx,122), mcx(cx,118), mcx(cx,119));          //sale/list ratio
        8: cmd := ProcessMultipleCmds(ProcessForm0918Math, doc, cx, [7,16,9]);      //sale price chged
        9: cmd := F0918C2Adjustments(doc, cx, cmd);                                      //do all adjs
        10:cmd := PercentAOfB(doc, mcx(cx,190), mcx(cx,186), mcx(cx,187));          //sale/list ratio
        11:cmd := ProcessMultipleCmds(ProcessForm0918Math, doc, cx, [10,17,12]);    //sale price chged
        12:cmd := F0918C3Adjustments(doc, cx, cmd);                                      //do all adjs
        13:cmd := CalcWeightedAvg(doc, [916,918]);                         //calc wtAvg of main and xcomps forms
        15:cmd := PercentAOfB(doc, mcx(cx,54), mcx(cx,52), mcx(cx,53));             //sale/list ratio
        16:cmd := PercentAOfB(doc, mcx(cx,122), mcx(cx,120), mcx(cx,121));          //sale/list ratio
        17:cmd := PercentAOfB(doc, mcx(cx,190), mcx(cx,188), mcx(cx,189));          //sale/list ratio
        14:
          begin
            F0918C1Adjustments(doc, cx, 0);       //do all adjs
            F0918C2Adjustments(doc, cx, 0);       //do all adjs
            F0918C3Adjustments(doc, cx, 0);       //do all adj
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0918Math(doc, 6, CX);
          ProcessForm0918Math(doc, 9, CX);
          ProcessForm0918Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0918Math(doc, 14, CX);
        end;
    end;
  result := 0;
end;


end.
