unit UMathInspection;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmMfgHm1004C   = 119;
  fmPropInspect1 = 699;
  fmpropInspect2 = 707;   //inspection w/comments
  fmpropInspect3 = 714;
  fmQuickStart   = 700;
  fmHomeFocusXComps = 718;
  fmGreenLink = 161;
  fmConstructionDisbursement7Stage = 934;
  fmConstructionDisbursement5Stage = 937;

  DimensionList4273 = 4273;  //Ticket #1404

  function ProcessForm0119Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0699Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0700Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0714Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0718Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0161Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0934Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0937Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm4273Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
  SysUtils,
  UMath;

function F0699SumTotalRooms(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get4CellSumR(doc, CX, 130,131,132,133);
  VR := VR + Get4CellSumR(doc, CX, 134,135,136, 0);
  VR := VR + Get4CellSumR(doc, CX, 142,143,144,145);
  VR := VR + Get4CellSumR(doc, CX, 146,147,148, 0);
  VR := VR + Get4CellSumR(doc, CX, 155,156,157,158);
  VR := VR + Get4CellSumR(doc, CX, 159,160,161, 0);
  result := SetCellValue(doc, MCX(cx, 166), VR);
end;

function CalcDimension(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
  tmpStr, acreStr, sqftStr: String;
  V1, V2, VX, VAcre: Double;
begin
  V1 := GetCellValue(doc, cellA);
  V2 := GetCellValue(doc, cellB);
  VX := V1 * V2;
  VAcre := VX / 43560.0;        //convert to acers
  AcreStr := Format('%.2n Ac',[VAcre]);
  sqftStr := Format('%.0n SqFt',[VX]);
  if VAcre > 1.0 then
    tmpStr := AcreStr   //Concat(AcreStr, ' Ac')
  else
    tmpStr := sqftStr;  //Concat(sqftStr, ' SqFt');

  result := SetCellString(doc, CellR, tmpStr);
end;

function F0199CostMultiplier(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, cellA);
  V2 := GetCellValue(doc, cellB);
  
  VR := V1;
  if V2 <> 0 then VR := V1 * V2;
  result := SetCellValue(doc, CellR, VR);
end;

function F0199SubTotalOne(doc: TContainer; CX: CellUID; C1,C2,C3,C4, CR: Integer):Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  V2 := GetCellValue(doc, mcx(cx,C2));
  V3 := GetCellValue(doc, mcx(cx,C3));
  V4 := GetCellValue(doc, mcx(cx,C4));

  VR := V1 - V2 - V3 - V4;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function F0199SubTotalTwo(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6, CR: Integer):Integer;
var
  V1,V2,V3,V4,V5,V6,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  V2 := GetCellValue(doc, mcx(cx,C2));
  V3 := GetCellValue(doc, mcx(cx,C3));
  V4 := GetCellValue(doc, mcx(cx,C4));
  V5 := GetCellValue(doc, mcx(cx,C5));
  V6 := GetCellValue(doc, mcx(cx,C6));

  VR := V1 + V2 + V3 + V4 + V5 + V6;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function ProcessForm0119Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := MultAB(doc, mcx(cx,82), mcx(cx,83), mcx(cx,84));
        2:
          cmd := MultAB(doc, mcx(cx,86), mcx(cx,87), mcx(cx,88));
        3:
          cmd := MultAB(doc, mcx(cx,90), mcx(cx,91), mcx(cx,92));
        4:
          cmd := MultAB(doc, mcx(cx,119), mcx(cx,120), mcx(cx,121));
        5:
          cmd := MultAB(doc, mcx(cx,122), mcx(cx,123), mcx(cx,124));
        6:
          cmd := MultAB(doc, mcx(cx,125), mcx(cx,126), mcx(cx,127));
        7:
          cmd := MultAB(doc, mcx(cx,128), mcx(cx,129), mcx(cx,130));
        8:
          cmd := SumFourCellsR(doc, cx, 121,124,127,130, 131);
        9:
          cmd := SumTenCellsR(doc, cx, 84,88,92,94,96,98,100,102,104,0, 105);
        10:
          cmd := F0199CostMultiplier(doc, mcx(cx,105), mcx(cx,106), mcx(cx,107));
        11:
          cmd := F0199SubTotalOne(doc, cx, 107,108,109,110, 111);
        12:
          cmd := F0199SubTotalTwo(doc, cx, 111,112,113,114,115,116, 117);
        13:
          cmd := RoundByVal(doc, mcx(cx,117), mcx(cx,118), 100);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0699Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumFourCellsR(doc, CX, 140,152,165,0, 169);    //sum sqft
        2:
          begin
            ProcessForm0699Math(doc, 4, CX);
            cmd := SumFourCellsR(doc, CX, 136,148,161,0, 167);    //sum bedrooms;
          end;
        3:
          cmd := SumFourCellsR(doc, CX, 137,149,162,0, 168);    //sum baths
        4:
          cmd := F0699SumTotalRooms(doc, CX);
        5:
          cmd := CalcDimension(doc, mcx(cx,61), mcx(cx,62), mcx(cx,63));
        6:
          cmd := SumSixCellsR(doc, CX, 208,209,210,211,212,0, 207);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm0700Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumEightCellsR(doc, CX, 72,74,76,78,80,82,84,0, 85);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0714Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SiteDimension(doc, mcx(cx,34), mcx(cx,35));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm0718Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
           //dynamic form name
         1:
            cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comparables', 25,38,51);
         2:
            cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPS','', 25,38,51, 2);
         3:
            cmd := ConfigXXXInstance(doc, cx, 25,38,51);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0161Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,114), mcx(cx,115));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

/// summary: Provides math for the construction disbursement 7 stage inspection report (934).
function ProcessForm0934Math(Doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          if CellIsChecked(Doc, MCX(CX, CX.Num + 1)) then
            Cmd := SetCellValue(Doc, MCX(CX, CX.Num + 2), 100)
          else
            Cmd := SetCellString(Doc, MCX(CX, CX.Num + 2), '');

        2: Cmd := AvgCellsR(Doc, CX, [18, 21, 24, 27, 31, 34, 37, 41, 44, 47, 50, 54, 57, 60, 64, 67, 70, 74, 77, 80, 83, 86, 89, 93], 95);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

/// summary: Provides math for the construction disbursement 5 stage inspection report (937).
function ProcessForm0937Math(Doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          if CellIsChecked(Doc, MCX(CX, CX.Num + 1)) then
            Cmd := SetCellValue(Doc, MCX(CX, CX.Num + 2), 100)
          else
            Cmd := SetCellString(Doc, MCX(CX, CX.Num + 2), '');

        2: Cmd := AvgCellsR(Doc, CX, [18, 21, 24, 27, 31, 34, 37, 41, 44, 47, 50, 53, 56, 59, 62, 66, 69, 72, 75, 78, 81, 84, 87, 90, 94], 96);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//********************* Ticket #1404: Math of form #4273 starts from here ******************************//
//This will recalculate the GLA total on top for those with living check box checked only
function CalcGLASum(doc: TContainer; cx: CellUID; aCell:Integer):Double;
var
 Width, Height, Factor: Double;
 Living: String;
begin
  result := 0;
  Living := GetCellString(doc, MCX(cx, aCell+4));
  if CompareText('X', trim(Living)) <> 0 then  Exit;

  Width  := GetCellValue(doc, MCX(cx, aCell));     //width
  Height := GetCellValue(doc, MCX(cx, aCell+1));  //Height
  Factor := GetCellValue(doc, MCX(cx, aCell+2));  //factor
  if (Width <> 0) and (Height <> 0) and (Factor <> 0) then
    result := Width * Height * Factor;
end;

//Keep sum up the GLA total for each row when living check box is checked
function CalcGLATotal(doc: Tcontainer; cx: CellUID): Double;
const
  idLevel1 = 15;
  idLevel2 = 16;
  idLevel3 = 17;

var
  Sum1, Sum2, Sum3, Sum4, Sum5: Double;
begin
 result := 0;
 //Sum up the first 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 20);
 Sum2 := CalcGLASum(doc, cx, 31);
 Sum3 := CalcGLASum(doc, cx, 42);
 Sum4 := CalcGLASum(doc, cx, 53);
 Sum5 := CalcGLASum(doc, cx, 64);
 result := Sum1 + Sum2 + Sum3 + Sum4 + Sum5;

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 75);
 Sum2 := CalcGLASum(doc, cx, 86);
 Sum3 := CalcGLASum(doc, cx, 97);
 Sum4 := CalcGLASum(doc, cx, 108);
 Sum5 := CalcGLASum(doc, cx, 119);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 130);
 Sum2 := CalcGLASum(doc, cx, 141);
 Sum3 := CalcGLASum(doc, cx, 152);
 Sum4 := CalcGLASum(doc, cx, 163);
 Sum5 := CalcGLASum(doc, cx, 174);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 185);
 Sum2 := CalcGLASum(doc, cx, 196);
 Sum3 := CalcGLASum(doc, cx, 207);
 Sum4 := CalcGLASum(doc, cx, 218);
 Sum5 := CalcGLASum(doc, cx, 229);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 240);
 Sum2 := CalcGLASum(doc, cx, 251);
 Sum3 := CalcGLASum(doc, cx, 262);
 Sum4 := CalcGLASum(doc, cx, 273);
 Sum5 := CalcGLASum(doc, cx, 284);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 295);
 Sum2 := CalcGLASum(doc, cx, 306);
 Sum3 := CalcGLASum(doc, cx, 317);
 Sum4 := CalcGLASum(doc, cx, 328);
 Sum5 := CalcGLASum(doc, cx, 339);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);

 //Sum up the next 5 rows only when living checkbox is checked
 Sum1 := CalcGLASum(doc, cx, 350);
 Sum2 := CalcGLASum(doc, cx, 361);
 Sum3 := CalcGLASum(doc, cx, 372);
 Sum4 := CalcGLASum(doc, cx, 383);
 Sum5 := CalcGLASum(doc, cx, 394);
 result := result + (Sum1 + Sum2 + Sum3 + Sum4 + Sum5);   //This is the final
end;

function CalcFactor(aWidth,aHeight,AreaTotal:Double):Double;
begin
  result := 1; //default factor to 1
  if (AreaTotal = 0) or (aWidth = 0) or (aHeight = 0) then exit;
    result := AreaTotal/(aWidth * aHeight);
end;


function SumUpAreaTotal(doc: TContainer; cx: CellUID; w, h, f, Area, Living, bsmt, Gar, Other, lvl1, lvl2, lvl3:Integer; var SumGLA:Double):Integer;
const
  idBsmt   = 14;
  idLevel1 = 15;
  idLevel2 = 16;
  idLevel3 = 17;
  idGarage = 18;
  idOther  = 19;
var
  VR, V1, V2, V3, ASum, AreaTotal, Factor: Double;
begin
  result := 0; V1:=0; V2:=0; V3:=0;
  V1 := GetCellValue(doc, MCX(cx, w));
  V2 := GetCellValue(doc, MCX(cx, h));
  V3 := GetCellValue(doc, MCX(cx, f));
  if V3 <> 0 then
    begin
      VR := V1 * V2 * V3;
      result := SetCellValue(doc, MCX(cx, Area), VR);
    end
  else
    begin
      AreaTotal := GetCellValue(doc, MCX(cx, Area));
      if AreaTotal <> 0 then
        begin
          V3 := CalcFactor(V1,V2, AreaTotal);
          VR := V1 * V2 * V3;
          SetCellValue(doc, MCX(cx, f), V3);
        end;
     end;

  //Set the area total based on the check box checked
  if CompareText(GetCellString(doc, MCX(cx, Living)),'X') = 0 then //this is GLA
    begin //check for which level
      if CompareText(GetCellString(doc, MCX(cx, lvl1)), 'X') = 0 then //level 1
        SetCellValue(doc, MCX(cx,idLevel1), VR)
      else if CompareText(GetCellString(doc, MCX(cx, lvl2)), 'X') = 0 then //level 2
        SetCellValue(doc, MCX(cx, idLevel2), VR)
      else if CompareText(GetCellString(doc, MCX(cx, lvl3)), 'X') = 0 then //level 3
        SetCellValue(doc, MCX(cx, idLevel3), VR)
    end
  else if CompareText(GetCellString(doc, MCX(cx, Gar)), 'X') = 0 then //garage
    SetCellValue(doc, MCX(cx, idGarage), VR)
  else if CompareText(GetCellString(doc, MCX(cx, Bsmt)), 'X') = 0 then //bsmt
    SetCellValue(doc, MCX(cx, idBsmt), VR)
  else if CompareText(GetCellString(doc, MCX(cx, Other)), 'X') = 0 then //other
    SetCellValue(doc, MCX(cx, idOther), VR);

  SumGLA := CalcGLATotal(doc, cx);  //Sum up the GLA total in the end
end;


function ProcessForm4273Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  idGLA = 13;
var
  SumGLA: Double;
begin
  SumGLA := 0;
  if Cmd > 0 then
    repeat
      case Cmd of  //math for 35 rows
        1: Cmd := SumUpAreaTotal(doc, cx, 20,21,22,23,24,25,26,27,28,29,30, SumGLA);
        2: Cmd := SumUpAreaTotal(doc, cx, 31,32,33,34,35,36,37,38,39,40,41, SumGLA);
        3: Cmd := SumUpAreaTotal(doc, cx, 42,43,44,45,46,47,48,49,50,51,52, SumGLA);
        4: Cmd := SumUpAreaTotal(doc, cx, 53,54,55,56,57,58,59,60,61,62,63, SumGLA);
        5: Cmd := SumUpAreaTotal(doc, cx, 64,65,66,67,68,69,70,71,72,73,74, SumGLA);
        6: Cmd := SumUpAreaTotal(doc, cx, 75,76,77,78,79,80,81,82,83,84,85, SumGLA);
        7: Cmd := SumUpAreaTotal(doc, cx, 86,87,88,89,90,91,92,93,94,95,96, SumGLA);
        8: Cmd := SumUpAreaTotal(doc, cx, 97,98,99,100,101,102,103,104,105,106,107, SumGLA);
        9: Cmd := SumUpAreaTotal(doc, cx, 108,109,110,111,112,113,114,115,116,117,118, SumGLA);
        10: Cmd := SumUpAreaTotal(doc, cx, 119,120,121,122,123,124,125,126,127,128,129, SumGLA);

        11: Cmd := SumUpAreaTotal(doc, cx, 130,131,132,133,134,135,136,137,138,139,140, SumGLA);
        12: Cmd := SumUpAreaTotal(doc, cx, 141,142,143,144,145,146,147,148,149,150,151, SumGLA);
        13: Cmd := SumUpAreaTotal(doc, cx, 152,153,154,155,156,157,158,159,160,161,162, SumGLA);
        14: Cmd := SumUpAreaTotal(doc, cx, 163,164,165,166,167,168,169,170,171,172,173, SumGLA);
        15: Cmd := SumUpAreaTotal(doc, cx, 174,175,176,177,178,179,180,181,182,183,184, SumGLA);
        16: Cmd := SumUpAreaTotal(doc, cx, 185,186,187,188,189,190,191,192,193,194,195, SumGLA);
        17: Cmd := SumUpAreaTotal(doc, cx, 196,197,198,199,200,201,202,203,204,205,206, SumGLA);
        18: Cmd := SumUpAreaTotal(doc, cx, 207,208,209,210,211,212,213,214,215,216,217, SumGLA);
        19: Cmd := SumUpAreaTotal(doc, cx, 218,219,220,221,222,223,224,225,226,227,228, SumGLA);
        20: Cmd := SumUpAreaTotal(doc, cx, 229,230,231,232,233,234,235,236,237,238,239, SumGLA);

        21: Cmd := SumUpAreaTotal(doc, cx, 240,241,242,243,244,245,246,247,248,249,250, SumGLA);
        22: Cmd := SumUpAreaTotal(doc, cx, 251,252,253,254,255,256,257,258,259,260,261, SumGLA);
        23: Cmd := SumUpAreaTotal(doc, cx, 262,263,264,265,266,267,268,269,270,271,272, SumGLA);
        24: Cmd := SumUpAreaTotal(doc, cx, 273,274,275,276,277,278,279,280,281,282,283, SumGLA);
        25: Cmd := SumUpAreaTotal(doc, cx, 284,285,286,287,288,289,290,291,292,293,294, SumGLA);
        26: Cmd := SumUpAreaTotal(doc, cx, 295,296,297,298,299,300,301,302,303,304,305, SumGLA);
        27: Cmd := SumUpAreaTotal(doc, cx, 306,307,308,309,310,311,312,313,314,315,316, SumGLA);
        28: Cmd := SumUpAreaTotal(doc, cx, 371,318,319,320,321,322,323,324,325,326,327, SumGLA);
        29: Cmd := SumUpAreaTotal(doc, cx, 328,329,330,331,332,333,334,335,336,337,338, SumGLA);
        30: Cmd := SumUpAreaTotal(doc, cx, 339,340,341,342,343,344,345,346,347,348,349, SumGLA);

        31: Cmd := SumUpAreaTotal(doc, cx, 350,351,352,353,354,355,356,357,358,359,360, SumGLA);
        32: Cmd := SumUpAreaTotal(doc, cx, 361,362,363,364,365,366,367,368,369,370,371, SumGLA);
        33: Cmd := SumUpAreaTotal(doc, cx, 372,373,374,375,376,377,378,379,380,381,382, SumGLA);
        34: Cmd := SumUpAreaTotal(doc, cx, 383,384,385,386,387,388,389,390,391,392,393, SumGLA);
        35: Cmd := SumUpAreaTotal(doc, cx, 394,395,396,397,398,399,400,401,402,403,404, SumGLA);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  if SumGLA > 0 then
    SetCellValue(doc, MCX(cx, idGLA), SumGLA);
  result := 0;
end;


end.
