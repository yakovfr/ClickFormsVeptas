unit UMathCommercial2;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2004-2006 by Bradford Technologies, Inc. }

{ This unit handles the math for the UCIAR - EP Appraisal Report }


interface

uses
   UGlobals, UContainer;

const
   fmUCIAR_SP_Page1 = 241;
   fmUCIAR_SP_Page2 = 242;
   fmUCIAR_SP_Page3 = 243;
   fmUCIAR_SP_Page4 = 244;
   fmUCIAR_SP_Page5 = 245;
   fmUCIAR_SP_Page6 = 246;
   fmUCIAR_SP_Page7 = 247;
   fmUCIAR_SP_Page8 = 248;
   fmUCIAR_SP_Page9 = 249;
   fmUCIAR_SP_Page10 = 250;
   fmUCIAR_SP_Page11 = 251;
   fmUCIAR_SP_Page12 = 252;

function ProcessForm0242Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0244Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0245Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0246Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0247Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0248Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0251Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0252Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;

implementation

uses
   UMath, UCell;


function MultABCOptD(Doc: TContainer; CellA, CellB, CellC, CellD, CellR: CellUID): Integer;
var
 V1, V2, V3, V4, VR: Double;
begin
 result := 0;
 if CellHasData(Doc, CellA) and CellHasData(Doc, CellB) and CellHasData(Doc, CellC) then
 begin
  V1 := GetCellValue(Doc, CellA);
  V2 := GetCellValue(Doc, CellB);
  V3 := GetCellValue(Doc, CellC);
  V4 := GetCellValue(Doc, CellD);
  if V4 = 0 then V4 := 1.0;
  VR := V1 * V2 * V3 * V4;
  result := SetCellValue(Doc, CellR, VR);
 end
 else if CellHasData(Doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(Doc, CellR, VR);
 end;
end;
   
//calc functional depr
function F0245CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,53));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,50));    //new cost
  V3 := GetCellValue(doc, mcx(cx,52));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,54), VR);
    end;
end;

//calc external depr
function F0245CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,55));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,50));    //new cost
  V3 := GetCellValue(doc, mcx(cx,52));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,54));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,56), VR);
    end;
end;


function ProcessForm0242Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           1 : Cmd := AddAndStoreCells(doc, CX, 118, [100, 104, 108, 112, 116]); //  Gross Square Feet
           2 : Cmd := AddAndStoreCells(doc, CX, 119, [101, 105, 109, 113, 117]); //  Net Square Feet
           3 : cmd := SumCellArray(doc, cx, [78,79,80], 77);
           4 : cmd := SumCellArray(doc, cx, [82,83,84], 81);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0244Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           14, 15 : Cmd := AddAndStoreCells(doc, CX, 13, [10, 12]);

           //              Comparable Site Analysis Comparable #1
           2 : Cmd := AddAndStoreCells(doc, CX, 107, [89, 91, 93, 95, 96, 97, 98, 99, 100, 102, 104, 106]);
           1, 3 : Cmd := SumAB(doc, mcx(cx,87), mcx(cx,107), mcx(cx,108));    //AddAndSubtractAndStoreCells(doc, CX, 108, [87], [107]);

           //              Comparable Site Analysis Comparable #2
           5 : Cmd := AddAndStoreCells(doc, CX, 128, [113, 115, 117, 119, 120, 121, 122, 123, 124, 125, 126, 127]);
           4, 6 : Cmd := SumAB(doc, mcx(cx,111), mcx(cx,128), mcx(cx,129));    //AddAndSubtractAndStoreCells(doc, CX, 129, [111], [128]);

           //              Comparable Site Analysis Comparable #3
           8 : Cmd := AddAndStoreCells(doc, CX, 149, [134, 136, 138, 140, 141, 142, 143, 144, 145, 146, 147, 148]);
           7, 9 : Cmd := SumAB(doc, mcx(cx,132), mcx(cx,149), mcx(cx,150));    //AddAndSubtractAndStoreCells(doc, CX, 150, [132], [149]);

           //              Estimated Site Value
           10, 11 : Cmd := MultiplyAndStoreCells(doc, CX, 155, [153, 154]);

           //              Estimated Excess Land Value
           12, 13 : Cmd := MultiplyAndStoreCells(doc, CX, 159, [157, 158]);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0245Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           //              Cost Approach
           1 : Cmd := MultABCOptD(doc, mcx(cx,8), mcx(CX,9), mcx(CX,10), mcx(CX,12), mcx(CX,13));
           2 : Cmd := MultABCOptD(doc, mcx(cx,15), mcx(CX,16), mcx(CX,17), mcx(CX,18), mcx(CX,19));
           3 : Cmd := MultABCOptD(doc, mcx(cx,21), mcx(CX,22), mcx(CX,23), mcx(CX,24), mcx(CX,25));
           4 : Cmd := MultABCOptD(doc, mcx(cx,27), mcx(CX,28), mcx(CX,29), mcx(CX,30), mcx(CX,31));
           5 : Cmd := MultABCOptD(doc, mcx(cx,33), mcx(CX,34), mcx(CX,35), mcx(CX,36), mcx(CX,37));
           6 : Cmd := MultABCOptD(doc, mcx(cx,39), mcx(CX,40), mcx(CX,41), mcx(CX,42), mcx(CX,43));
           7 : Cmd := SumCellArray(doc, CX, [13, 19, 25, 31, 37, 43], 46);
           8 : cmd := ProcessMultipleCmds(ProcessForm0245Math, doc, CX,[9,19]);
           9 : cmd := SumCellArray(doc, cx, [46,47,49], 50);
           10: cmd := ProcessMultipleCmds(ProcessForm0245Math, doc, CX,[11,13,15,17]);
           11: Cmd := MultPercentAB(doc, mcx(cx,50), mcx(cx,51),mcx(cx,52));         //phy dep precent entered
           13: cmd := F0245CalcDeprLessPhy(doc, cx);                                 //funct depr entered
           15: cmd := F0245CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
           19: Cmd := MultPercentAB(doc, mcx(cx,46), mcx(cx,48),mcx(cx,49));
           12: cmd := SumCellArray(doc, cx, [52,54,56], 57);
           17: cmd := SubtAB(doc, MCX(cx,50), mcx(cx,57), mcx(cx,58));
           18: cmd := SumCellArray(doc, cx, [58,59], 60);

           //              Income Approach/Rental Comparable Building Analysis

           20 : Cmd := AddAndStoreCells(doc, CX, 150, [148, 149]); //  Subject
           21 : Cmd := AddAndStoreCells(doc, CX, 152, [150, 151]);
           22 : Cmd := AddAndStoreCells(doc, CX, 160, [158, 159]); //  Comparable #1
           23 : Cmd := AddAndStoreCells(doc, CX, 162, [160, 161]);
           24 : Cmd := AddAndStoreCells(doc, CX, 170, [168, 169]); //  Comparable #2
           25 : Cmd := AddAndStoreCells(doc, CX, 172, [170, 171]);
           26 : Cmd := AddAndStoreCells(doc, CX, 180, [178, 179]); //  Comparable #3
           27 : Cmd := AddAndStoreCells(doc, CX, 182, [180, 181]);

           //add with cell in Pg6 and place result on pg6
           31: Cmd :=  SumAB(doc, mcx(cx,152), MC(246,1,14), MC(246,1,15));
           32: Cmd :=  SumAB(doc, mcx(cx,162), MC(246,1,22), MC(246,1,23));
           33: Cmd :=  SumAB(doc, mcx(cx,172), MC(246,1,30), MC(246,1,31));
           34: Cmd :=  SumAB(doc, mcx(cx,182), MC(246,1,38), MC(246,1,39));

           //Rent Per Sq Ft Calcs
           35: Cmd := DivideAB(doc, mcx(cx,83), mcx(CX,147), mcx(CX,148));
           36: Cmd := DivideAB(doc, mcx(cx,102), mcx(CX,157), mcx(CX,158));
           37: Cmd := DivideAB(doc, mcx(cx,120), mcx(CX,167), mcx(CX,168));
           38: Cmd := DivideAB(doc, mcx(cx,138), mcx(CX,177), mcx(CX,178));

           //cost approach ctd.
           39: cmd := SumCellArray(doc, cx, [62,63,64,65], 66);
           40: cmd := SubtAB(doc, MCX(cx,66), mcx(cx,67), mcx(cx,68));
           41: cmd := RoundByValR(doc, cx, 68, 69, 500);

       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0246Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           1 : Cmd := AddAndStoreCells(doc, CX, 14, [5, 6, 7, 9, 11, 13]); //  Subject
           2 : Cmd := AddAndStoreCells(doc, CX, 22, [16, 17, 18, 19, 20, 21]); //  Comparable #1
           3 : Cmd := AddAndStoreCells(doc, CX, 30, [24, 25, 26, 27, 28, 29]); //  Comparable #2
           4 : Cmd := AddAndStoreCells(doc, CX, 38, [32, 33, 34, 35, 36, 37]); //  Comparable #3

           //add with cell in Pg5 and place result on this page
           9:  Cmd :=  SumAB(doc, mcx(cx,14), MC(245,1,152), mcx(cx,15));
           10: Cmd :=  SumAB(doc, mcx(cx,22), MC(245,1,162), mcx(cx,23));
           11: Cmd :=  SumAB(doc, mcx(cx,30), MC(245,1,172), mcx(cx,31));
           12: Cmd :=  SumAB(doc, mcx(cx,38), MC(245,1,182), mcx(cx,39));

           //              Income and Expense History and Forecast
           13: Cmd := AddAndSubtractAndStoreCells(doc, CX, 107, [95, 104], [101]);
           14: Cmd := AddAndSubtractAndStoreCells(doc, CX, 109, [94, 97, 99, 106], [103]);
           15: Cmd := AddAndStoreCells(doc, CX, 135, [110, 113, 116, 119, 122, 125, 129, 132]);
           16: cmd := ProcessMultipleCmds(ProcessForm0246Math, doc, CX,[30,31]);
           19: cmd := ProcessMultipleCmds(ProcessForm0246Math, doc, CX,[30,31]);
           17: Cmd := AddAndStoreCells(doc, CX, 137, [112, 115, 118, 121, 124, 127, 131, 134]);
           18: Cmd := AddAndSubtractAndStoreCells(doc, CX, 141, [109], [137]);

           //              Direct Capitalization
           23: Cmd := DivideAB_R(doc, CX, 146, 147, 148);
           24: Cmd := DivideAB_R(doc, CX, 158, 159, 160);
           25: Cmd := MultiplyAndStoreCells(doc, CX, 153, [151, 152]);
           26 : Cmd := AddAndStoreCells(doc, CX, 157, [153, 156]);
           27: Cmd := MultiplyAndStoreCells(doc, CX, 156, [154, 155]);
           28: Cmd := MultPercentAB(doc, mcx(cx,100), mcx(cx,95),mcx(cx,101));
           29: cmd := ProcessMultipleCmds(ProcessForm0246Math, doc, CX,[13,28]);
           30: Cmd := AddAndSubtractAndStoreCells(doc, CX, 138, [107], [135]);
           31: Cmd := DivideABPercent(doc, mcx(cx,135), mcx(cx,107),mcx(cx,140));
       else
        Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;


function ProcessForm0247Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           //              Yield Capitalization
           24: Cmd := AddAndStoreCells(doc, CX, 21, [17]);
           25: Cmd := AddAndStoreCells(doc, CX, 22, [18]);

           //              Adjustment for Interest Appraised
           19 : Cmd := AddAndSubtractAndStoreCells(doc, CX, 23, [21], [22]);

           21 : Cmd := AddAndStoreCells(doc, CX, 27, [25, 26]);
           22 : Cmd := RoundByValR(doc, CX, 27, 28, 1000);

           //              Direct Sales Coparison Approach/Comparable Building Analysis
           1 : Cmd := AddAndStoreCells(doc, CX, 110, [97, 101, 103, 105, 107, 109]);
           3 : Cmd := AddAndStoreCells(doc, CX, 122, [112, 114, 116, 118, 121]);

           5, 6 : Cmd := AddAndStoreCells(doc, CX, 138, [125, 129, 131, 133, 135, 137]);
           8 : Cmd := AddAndStoreCells(doc, CX, 149, [140, 142, 144, 146, 148]);

           10, 11 : Cmd := AddAndStoreCells(doc, CX, 164, [151, 155, 157, 159, 161, 163]);
           13 : Cmd := AddAndStoreCells(doc, CX, 175, [166, 168, 170, 172, 174]);

           14, 15 : Cmd := AddAndStoreCells(doc, CX, 190, [177, 181, 183, 185, 187, 189]);
           17 : Cmd := AddAndStoreCells(doc, CX, 201, [192, 194, 196, 198, 200]);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0248Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           //              Fee Simple or Leased Fee Operating Data and Ratios: Comparable #1
           21, 22 : Cmd := DeductLossAndStoreCell(doc, CX, 11, 9, 10);
           1, 2 :
               begin
                   Cmd := AddAndSubtractAndStoreCells(doc, CX, 15, [11], [12]);
                   if Cmd <> 0 then
                       ProcessForm0251Math(doc, Cmd, CX); //  recursive; will not return until zero
                   Cmd := DivideAB_R(doc, CX, 12, 11, 14);
               end;

           //              Fee Simple or Leased Fee Operating Data and Ratios: Comparable #2
           23, 24 : Cmd := DeductLossAndStoreCell(doc, CX, 23, 21, 22);
           5, 6 :
               begin
                   Cmd := AddAndSubtractAndStoreCells(doc, CX, 27, [23], [24]);
                   if Cmd <> 0 then
                       ProcessForm0251Math(doc, Cmd, CX); //  recursive; will not return until zero
                   Cmd := DivideAB_R(doc, CX, 24, 23, 26);
               end;

           //              Fee Simple or Leased Fee Operating Data and Ratios: Comparable #3
           25, 26 : Cmd := DeductLossAndStoreCell(doc, CX, 35, 33, 34);
           9, 10 :
               begin
                   Cmd := AddAndSubtractAndStoreCells(doc, CX, 39, [35], [36]);
                   if Cmd <> 0 then
                       ProcessForm0251Math(doc, Cmd, CX); //  recursive; will not return until zero
                   Cmd := DivideAB_R(doc, CX, 36, 35, 38);
               end;

           13, 14 : Cmd := MultiplyAndStoreCells(doc, CX, 47, [45, 46]);
           15, 16 : Cmd := MultiplyAndStoreCells(doc, CX, 50, [48, 49]);

           17, 18, 19 : Cmd := AddAndStoreCells(doc, CX, 55, [52, 53, 54]);
           20 : Cmd := RoundByValR(doc, CX, 55, 56, 1000);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0251Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           2 : Cmd := AddAndStoreCells(doc, CX, 86, [80, 81, 82, 83, 85]);
           1, 3 : Cmd := AddAndSubtractAndStoreCells(doc, CX, 87, [78], [86]);
           4 : Cmd := AddAndSubtractAndStoreCells(doc, CX, 90, [87], [88, 89]);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0252Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           6:  Cmd := AddAndStoreCells(doc, CX, 62, [59, 60, 61]);
           2 : Cmd := AddAndStoreCells(doc, CX, 74, [64, 65, 66, 67, 68, 69, 71, 73]);
           1, 3 : Cmd := AddAndSubtractAndStoreCells(doc, CX, 75, [59], [74]);
           4 : Cmd := AddAndSubtractAndStoreCells(doc, CX, 79, [75], [76, 77, 78]);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

end.

