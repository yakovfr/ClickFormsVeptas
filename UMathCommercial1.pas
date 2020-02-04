unit UMathCommercial1;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 2004-2006 by Bradford Technologies, Inc. }


{ This unit handles the math for the UCIAR - SP Appraisal Report }
interface

uses
  UGlobals, UContainer;

const
  fmUCIAR_EP_Page1 = 255;
  fmUCIAR_EP_Page2 = 256;
  fmUCIAR_EP_Page3 = 257;
  fmUCIAR_EP_Page4 = 258;
  fmUCIAR_EP_Page5 = 259;
  fmUCIAR_EP_Page6 = 260;
  fmUCIAR_EP_Page7 = 261;
  fmUCIAR_EP_Page8 = 262;
  fmUCIAR_EP_Page9 = 263;
  fmUCIAR_EP_Page10 = 264;
  fmUCIAR_EP_Page11 = 265;
  fmUCIAR_EP_Page12 = 266;
  fmUCIAR_EP_Page13 = 267;
  fmUCIAR_EP_Page14 = 268;
  fmUCIAR_EP_Page15 = 269;
  fmUCIAR_EP_Page16 = 270;
  fmUCIAR_EP_Page17 = 271;
  fmUCIAR_EP_Page18 = 272;
  fmUCIAR_EP_Page19 = 273;
  fmUCIAR_EP_Page20 = 274;
  fmUCIAR_EP_Page21 = 275;
  fmUCIAR_EP_Page22 = 276;
  fmUCIAR_EP_Page23 = 277;
  fmUCIAR_EP_Page24 = 278;
  fmUCIAR_EP_Page25 = 279;
  fmUCIAR_EP_Page26 = 280;
  fmUCIAR_EP_Page27 = 281;
  fmUCIAR_EP_Page28 = 282;
  fmUCIAR_EP_Page29 = 283;

function ProcessForm0255Math(Doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0257Math(Doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0258Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0260Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0261Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0262Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0263Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0264Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0265Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0266Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0270Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0271Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0272Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
function ProcessForm0273Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;

implementation

uses
  UMath, UCell;

function GetSiblingCell(CX : CellUID; ASiblingCellID : Integer) : CellUID;
begin
  Result := mcx(CX, ASiblingCellID);
end;


function MultABCOptD(ADoc: TContainer; CellA, CellB, CellC, CellD, CellR: CellUID): Integer;
var
 V1, V2, V3, V4, VR: Double;
begin
 result := 0;
 if CellHasData(ADoc, CellA) and CellHasData(ADoc, CellB) and CellHasData(ADoc, CellC) then
 begin
  V1 := GetCellValue(ADoc, CellA);
  V2 := GetCellValue(ADoc, CellB);
  V3 := GetCellValue(ADoc, CellC);
  V4 := GetCellValue(ADoc, CellD);
  if V4 = 0 then V4 := 1.0;
  VR := V1 * V2 * V3 * V4;
  result := SetCellValue(ADoc, CellR, VR);
 end
 else if CellHasData(ADoc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(ADoc, CellR, VR);
 end;
end;

function MultABCOptDEF(ADoc: TContainer; CellA, CellB, CellC, CellD, CellE, CellF, CellR: CellUID): Integer;
var
 V1, V2, V3, V4, V5, V6, VR: Double;
begin
 result := 0;
 if CellHasData(ADoc, CellA) and CellHasData(ADoc, CellB) and CellHasData(ADoc, CellC) then
 begin
  V1 := GetCellValue(ADoc, CellA);
  V2 := GetCellValue(ADoc, CellB);
  V3 := GetCellValue(ADoc, CellC);
  V4 := GetCellValue(ADoc, CellD);
  V5 := GetCellValue(ADoc, CellE);
  V6 := GetCellValue(ADoc, CellF);
  if V4 = 0 then V4 := 1.0;
  if V5 = 0 then V5 := 1.0;
  if V6 = 0 then V6 := 1.0;
  VR := V1 * V2 * V3 * V4 * V5 * V6;
  result := SetCellValue(ADoc, CellR, VR);
 end
 else if CellHasData(ADoc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(ADoc, CellR, VR);
 end;
end;


//calc functional depr
function F0261CalcDeprLessPhy(ADoc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(ADoc, mcx(cx,52));    //funct depr percent
  V2 := GetCellValue(ADoc, mcx(cx,49));    //new cost
  V3 := GetCellValue(ADoc, mcx(cx,51));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(ADoc, mcx(cx,53), VR);
    end;
end;

//calc external depr
function F0261CalcDeprLessPhyNFunct(ADoc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(ADoc, mcx(cx,54));    //extrn depr percent
  V2 := GetCellValue(ADoc, mcx(cx,49));    //new cost
  V3 := GetCellValue(ADoc, mcx(cx,51));    //Phy Depr
  V4 := GetCellValue(ADoc, mcx(cx,53));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(ADoc, mcx(cx,55), VR);
    end;
end;


function ProcessForm0255Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           1 : Cmd := DivideABPercent(doc, mcx(cx,57), mcx(CX,56), mcx(CX,58));
           2 : cmd := DivideABPercent(doc, mcx(cx,69), mcx(CX,68), mcx(CX,78));
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0257Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
   repeat
       case Cmd of
           1 : cmd := SumCellArray(doc, cx, [101,105,108], 97);
           2 : cmd := SumCellArray(doc, cx, [102,106,109], 98);
       else
           Cmd := 0;
       end;
   until Cmd = 0;

   Result := 0;
end;

function ProcessForm0258Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      1 : Cmd := AddAndStoreCells(ADoc, CX, 29, [11, 15, 19, 23, 27]); //  Gross Square Feet
      2 : Cmd := AddAndStoreCells(ADoc, CX, 30, [12, 16, 20, 24, 28]); //  Net Square Feet
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0260Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      5 :
        begin
          AddAndStoreCells(ADoc, CX, 102, [84, 86, 88, 90, 91, 92, 93, 94, 95, 97, 99, 101]); //  Individual Comparable 1 adjustments
          Cmd := 6;
        end;
      4, 6 : Cmd := AddAndStoreCells(ADoc, CX, 103, [82, 102]); //  Comparable 1 total adjustments
      9 :
        begin
          AddAndStoreCells(ADoc, CX, 122, [107, 109, 111, 113, 114, 115, 116, 117, 118, 119, 120, 121]); //  Individual Comparable 2 adjustments
          Cmd := 10;
        end;
      8, 10 : Cmd := AddAndStoreCells(ADoc, CX, 123, [105, 122]); //  Comparable 2 total adjustments
      13 :
        begin
          AddAndStoreCells(ADoc, CX, 142, [127, 129, 131, 133, 134, 135, 136, 137, 138, 139, 140, 141]); //  Individual Comparable 3 adjustments
          Cmd := 14;
        end;
      12, 14 : Cmd := AddAndStoreCells(ADoc, CX, 143, [125, 142]); //  Comparable 3 total adjustments

      18 : Cmd := MultiplyAndStoreCells(ADoc, CX, 149, [147, 148]); //  Summary of Site Value Indications: Estimated Site Value
      19 : Cmd := MultiplyAndStoreCells(ADoc, CX, 153, [151, 152]); //  Summary of Site Value Indications: Estimated Excess Land Value
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0261Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      1: cmd := MultABCOptD(ADoc, mcx(cx,7), mcx(CX,8), mcx(CX,9),mcx(CX,11), mcx(CX,12));
      2: cmd := MultABCOptD(ADoc, mcx(cx,14), mcx(CX,15), mcx(CX,16),mcx(CX,17), mcx(CX,18));
      3: Cmd := MultABCOptD(ADoc, mcx(cx,20), mcx(CX,21), mcx(CX,22),mcx(CX,23), mcx(CX,24));
      4: Cmd := MultABCOptD(ADoc, mcx(cx,26), mcx(CX,27), mcx(CX,28),mcx(CX,29), mcx(CX,30));
      5: Cmd := MultABCOptD(ADoc, mcx(cx,32), mcx(CX,33), mcx(CX,34),mcx(CX,35), mcx(CX,36));
      6: Cmd := MultABCOptD(ADoc, mcx(cx,38), mcx(CX,39), mcx(CX,40),mcx(CX,41), mcx(CX,42));
      7: Cmd := SumCellArray(ADoc, cx, [12, 18, 24, 30, 36, 42], 45);
      8: cmd := ProcessMultipleCmds(ProcessForm0261Math, ADoc, CX,[9,10]);
      9: cmd := SumCellArray(ADoc, cx, [45,46,48], 49);
      10: Cmd := MultPercentAB(ADoc, mcx(cx,45), mcx(cx,47),mcx(cx,48));
      11: cmd := ProcessMultipleCmds(ProcessForm0261Math, ADoc, CX,[12,13,14,18]);
      12: Cmd := MultPercentAB(ADoc, mcx(cx,49), mcx(cx,50),mcx(cx,51));         //phy dep precent entered
      13: cmd := F0261CalcDeprLessPhy(ADoc, cx);                                 //funct depr entered
      14: cmd := F0261CalcDeprLessPhyNFunct(ADoc, cx);     //external depr entered
      15: cmd := SumCellArray(ADoc, cx, [51,53,55], 56);
      18: cmd := SubtAB(ADoc, MCX(cx,49), mcx(cx,56), mcx(cx,57));
      19: cmd := SumCellArray(ADoc, cx, [57,58], 59);
      20: cmd := SumCellArray(ADoc, cx, [62,63,64,65], 66);
      21: cmd := SubtAB(ADoc, MCX(cx,66), mcx(cx,67), mcx(cx,68));
      22: cmd := RoundByValR(ADoc, cx, 68, 69, 500);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0262Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
     //  Comparable Building Rent Analysis - Subject
      2, 3 : Cmd := AddAndStoreCells(ADoc, CX, 87, [85, 86]);
      4, 5 : Cmd := AddAndStoreCells(ADoc, CX, 89, [87, 88]);
      6, 7 : Cmd := AddAndStoreCells(ADoc, CX, 99, [90, 91, 92, 94, 96, 98]);
      8 : Cmd := AddAndStoreCells(ADoc, CX, 100, [89, 99]);
      //  Comparable Building Rent Analysis - Comparable 1
      10, 11 : Cmd := AddAndStoreCells(ADoc, CX, 109, [107, 108]);
      12, 13 : Cmd := AddAndStoreCells(ADoc, CX, 111, [109, 110]);
      14, 15 : Cmd := AddAndStoreCells(ADoc, CX, 118, [112, 113, 114, 115, 116, 117]);
      16 : Cmd := AddAndStoreCells(ADoc, CX, 119, [111, 118]);
      //  Comparable Building Rent Analysis - Comparable 2
      18, 19 : Cmd := AddAndStoreCells(ADoc, CX, 128, [126, 127]);
      20, 21 : Cmd := AddAndStoreCells(ADoc, CX, 130, [128, 129]);
      22, 23 : Cmd := AddAndStoreCells(ADoc, CX, 137, [131, 132, 133, 134, 135, 136]);
      24 : Cmd := AddAndStoreCells(ADoc, CX, 138, [130, 137]);
      //  Comparable Building Rent Analysis - Comparable 3
      26, 27 : Cmd := AddAndStoreCells(ADoc, CX, 147, [145, 146]);
      28, 29 : Cmd := AddAndStoreCells(ADoc, CX, 149, [147, 148]);
      30, 31 : Cmd := AddAndStoreCells(ADoc, CX, 156, [150, 151, 152, 153, 154, 155]);
      32 : Cmd := AddAndStoreCells(ADoc, CX, 157, [149, 156]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0263Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      //  Summary of Subject Leases
      1 : Cmd := AddAndStoreCells(ADoc, CX, 134, [6, 15, 23, 31, 39, 47, 55, 63, 71, 79, 87, 95, 103, 111, 119, 127]);
      2 : Cmd := AddAndStoreCells(ADoc, CX, 135, [11, 19, 27, 35, 43, 51, 59, 67, 75, 83, 91, 99, 107, 115, 123, 131]);

      4 : Cmd := AddAndStoreCells(ADoc, CX, 170, [155, 159, 163, 167]);
      5, 6 : Cmd := GetPercentAndStoreCell(ADoc, CX, 177, 170, 176);
      7 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 183, [170, 180], [177]);
      9 : Cmd := AddAndStoreCells(ADoc, CX, 238, [186, 189, 192, 195, 198, 201, 204, 207, 210, 213, 216, 220, 224, 228, 232, 235]);


      8 : Cmd := AddAndStoreCells(ADoc, CX, 172, [157, 161, 165, 169]);
      13, 14, 15, 16 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 185, [172, 182], [179]);
      11 : Cmd := AddAndStoreCells(ADoc, CX, 240, [188, 191, 194, 197, 200, 203, 206, 209, 212, 215, 218, 222, 226, 230, 234, 237]);
      12, 17 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 244, [185], [240]);

      3: cmd := ProcessMultipleCmds(ProcessForm0263Math, ADoc, CX,[18,19]);
      10: cmd := ProcessMultipleCmds(ProcessForm0263Math, ADoc, CX,[18,19]);
      18: Cmd := DivideABPercent(ADoc, mcx(cx,238), mcx(cx,183),mcx(cx,243));
      19: Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 241, [183], [238]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0264Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      //  Summary of Income Approach Value Indications
      2, 3 : Cmd := AddAndStoreCells(ADoc, CX, 45, [43, 44]);
      4 : Cmd := RoundByValR(ADoc, CX, 45, 46, 1000);

      //  Direct Capitalization
      5, 6 : Cmd := DivideAB_R(ADoc, CX, 8, 9, 10);
      7, 8 : Cmd := MultiplyAndStoreCells(ADoc, CX, 15, [13, 14]);
      9, 10 : Cmd := MultiplyAndStoreCells(ADoc, CX, 18, [16, 17]);
      11, 12 : Cmd := DivideAB_R(ADoc, CX, 20, 21, 22);
      13 : Cmd := AddAndStoreCells(ADoc, CX, 19, [15, 18]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0265Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      //  Comparable Building Analysis -- Subject
      1, 2 : Cmd := AddAndStoreCells(ADoc, CX, 146, [91, 110, 118, 126, 134, 142]);
      4 : Cmd := AddAndStoreCells(ADoc, CX, 191, [154, 162, 170, 178, 187]);
      3, 5 : Cmd := AddAndStoreCells(ADoc, CX, 196, [146, 191]);
      //  Comparable Building Analysis -- Comparable 1
      6, 7 : Cmd := AddAndStoreCells(ADoc, CX, 147, [93, 111, 119, 127, 135, 143]);
      9 : Cmd := AddAndStoreCells(ADoc, CX, 192, [155, 163, 171, 179, 188]);
      8, 10 : Cmd := AddAndStoreCells(ADoc, CX, 197, [147, 192]);
      //  Comparable Building Analysis -- Comparable 2
      11, 12 : Cmd := AddAndStoreCells(ADoc, CX, 148, [95, 112, 120, 128, 136, 144]);
      14 : Cmd := AddAndStoreCells(ADoc, CX, 193, [156, 164, 172, 180, 189]);
      13, 15 : Cmd := AddAndStoreCells(ADoc, CX, 198, [148, 193]);
      //  Comparable Building Analysis -- Comparable 3
      16, 17 : Cmd := AddAndStoreCells(ADoc, CX, 149, [97, 113, 121, 129, 137, 145]);
      19 : Cmd := AddAndStoreCells(ADoc, CX, 194, [157, 165, 173, 181, 190]);
      18, 20 : Cmd := AddAndStoreCells(ADoc, CX, 199, [149, 194]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0266Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      //  Fee Simple Operating Data and Ratios - Comparable 1
      1, 2 : Cmd := DeductLossAndStoreCell(ADoc, CX, 9, 7, 8);
      3, 4 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 13, [9], [10]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 10, 9, 12);
        end;
      //  Fee Simple Operating Data and Ratios - Comparable 2
      7, 8 : Cmd := DeductLossAndStoreCell(ADoc, CX, 20, 18, 19);
      9, 10 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 24, [20], [21]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 21, 20, 23);
        end;
      //  Fee Simple Operating Data and Ratios - Comparable 3
      13, 14 : Cmd := DeductLossAndStoreCell(ADoc, CX, 31, 29, 30);
      15, 16 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 35, [31], [32]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 32, 31, 34);
        end;

      //  Leased Fee Operating Data and Ratios - Comparable 1
      19, 20 : Cmd := DeductLossAndStoreCell(ADoc, CX, 41, 39, 40);
      21, 22 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 45, [41], [42]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 42, 41, 44);
        end;
      //  Leased Fee Operating Data and Ratios - Comparable 2
      24, 25 : Cmd := DeductLossAndStoreCell(ADoc, CX, 51, 49, 50);
      26, 27 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 55, [51], [52]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 52, 51, 54);
        end;
      //  Leased Fee Operating Data and Ratios - Comparable 3
      29, 30 : Cmd := DeductLossAndStoreCell(ADoc, CX, 61, 59, 60);
      31, 32 :
        begin
          Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 65, [61], [62]);
          if Cmd <> 0 then
            ProcessForm0266Math(ADoc, Cmd, CX); //  recursive; will not return until zero
          Cmd := DivideAB_R(ADoc, CX, 62, 61, 64);
        end;

      34, 35 : Cmd := MultiplyAndStoreCells(ADoc, CX, 73, [71, 72]);
      37, 38 : Cmd := MultiplyAndStoreCells(ADoc, CX, 76, [74, 75]);

      41, 42, 43 : Cmd := AddAndStoreCells(ADoc, CX, 81, [78, 79, 80]);
      44 : Cmd := RoundByValR(ADoc, CX, 81, 82, 500);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0270Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      1 : Cmd := AddAndStoreCells(ADoc, CX, 438,
          [6, 15, 23, 31, 39, 47, 55, 63, 71, 79, 87, 95, 103, 111, 119, 127, 135, 143, 151, 159, 167, 175, 183, 191, 199, 207, 215, 223, 231, 239, 247, 255, 263, 271, 279, 287, 295, 303, 311, 319, 327, 335, 343, 351, 359, 367, 375, 383, 391, 399, 407, 415, 423, 431]);
      2 : Cmd := AddAndStoreCells(ADoc, CX, 439,
          [11, 19, 27, 35, 43, 51, 59, 67, 75, 83, 91, 99, 107, 115, 123, 131, 139, 147, 155, 163, 171, 179, 187, 195, 203, 211, 219, 227, 235, 243, 251, 259, 267, 275, 283, 291, 299, 307, 315, 323, 331, 339, 347, 355, 363, 371, 379, 387, 395, 403, 411, 419, 427, 435]);
      3 : Cmd := AddAndStoreCells(ADoc, CX, 440,
          [13, 21, 29, 37, 45, 53, 61, 69, 77, 85, 93, 101, 109, 117, 125, 133, 141, 149, 157, 165, 173, 181, 189, 197, 205, 213, 221, 229, 237, 245, 253, 261, 269, 277, 285, 293, 301, 309, 317, 325, 333, 341, 349, 357, 365, 373, 381, 389, 397, 405, 413, 421, 429, 437]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0271Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of

      1 : cmd := MultABCOptDEF(ADoc, mcx(cx,7), mcx(CX,8), mcx(CX,9), mcx(CX,11), mcx(CX,13), mcx(CX,15), mcx(CX,16));
      2 : cmd := MultABCOptDEF(ADoc, mcx(cx,18), mcx(CX,19), mcx(CX,20), mcx(CX,21), mcx(CX,22), mcx(CX,23), mcx(CX,24));
      3 : cmd := MultABCOptDEF(ADoc, mcx(cx,26), mcx(CX,27), mcx(CX,28), mcx(CX,29), mcx(CX,30), mcx(CX,31), mcx(CX,32));
      4 : cmd := MultABCOptDEF(ADoc, mcx(cx,34), mcx(CX,35), mcx(CX,36), mcx(CX,37), mcx(CX,38), mcx(CX,39), mcx(CX,40));
      5 : cmd := MultABCOptDEF(ADoc, mcx(cx,42), mcx(CX,43), mcx(CX,44), mcx(CX,45), mcx(CX,46), mcx(CX,47), mcx(CX,48));
      6 : cmd := MultABCOptDEF(ADoc, mcx(cx,50), mcx(CX,51), mcx(CX,52), mcx(CX,53), mcx(CX,54), mcx(CX,55), mcx(CX,56));
      7 : cmd := MultABCOptDEF(ADoc, mcx(cx,58), mcx(CX,59), mcx(CX,60), mcx(CX,61), mcx(CX,62), mcx(CX,63), mcx(CX,64));
      8 : cmd := MultABCOptDEF(ADoc, mcx(cx,66), mcx(CX,67), mcx(CX,68), mcx(CX,69), mcx(CX,70), mcx(CX,71), mcx(CX,72));
      9 : cmd := MultABCOptDEF(ADoc, mcx(cx,74), mcx(CX,75), mcx(CX,76), mcx(CX,77), mcx(CX,78), mcx(CX,79), mcx(CX,80));
      10 : cmd := MultABCOptDEF(ADoc, mcx(cx,82), mcx(CX,83), mcx(CX,84), mcx(CX,85), mcx(CX,86), mcx(CX,87), mcx(CX,88));
      11 : cmd := MultABCOptDEF(ADoc, mcx(cx,90), mcx(CX,91), mcx(CX,92), mcx(CX,93), mcx(CX,94), mcx(CX,95), mcx(CX,96));
      12 : cmd := MultABCOptDEF(ADoc, mcx(cx,98), mcx(CX,99), mcx(CX,100), mcx(CX,101), mcx(CX,102), mcx(CX,103), mcx(CX,104));
      13 : cmd := MultABCOptDEF(ADoc, mcx(cx,106), mcx(CX,107), mcx(CX,108), mcx(CX,109), mcx(CX,110), mcx(CX,111), mcx(CX,112));
      14 : cmd := MultABCOptDEF(ADoc, mcx(cx,114), mcx(CX,115), mcx(CX,116), mcx(CX,117), mcx(CX,118), mcx(CX,119), mcx(CX,120));
      15 : cmd := MultABCOptDEF(ADoc, mcx(cx,122), mcx(CX,123), mcx(CX,124), mcx(CX,125), mcx(CX,126), mcx(CX,127), mcx(CX,128));
      16 : cmd := MultABCOptDEF(ADoc, mcx(cx,130), mcx(CX,131), mcx(CX,132), mcx(CX,133), mcx(CX,134), mcx(CX,135), mcx(CX,136));
      17 : cmd := MultABCOptDEF(ADoc, mcx(cx,138), mcx(CX,139), mcx(CX,140), mcx(CX,141), mcx(CX,142), mcx(CX,143), mcx(CX,144));
      18 : cmd := MultABCOptDEF(ADoc, mcx(cx,146), mcx(CX,147), mcx(CX,148), mcx(CX,149), mcx(CX,150), mcx(CX,151), mcx(CX,152));
      19 : cmd := MultABCOptDEF(ADoc, mcx(cx,154), mcx(CX,155), mcx(CX,156), mcx(CX,157), mcx(CX,158), mcx(CX,159), mcx(CX,160));
      20 : cmd := MultABCOptDEF(ADoc, mcx(cx,162), mcx(CX,163), mcx(CX,164), mcx(CX,165), mcx(CX,166), mcx(CX,167), mcx(CX,168));
      21 : cmd := MultABCOptDEF(ADoc, mcx(cx,170), mcx(cx,171), mcx(cx,172), mcx(cx,173), mcx(cx,174), mcx(cx,175), mcx(cx,176));
      22 : cmd := MultABCOptDEF(ADoc, mcx(cx,178), mcx(cx,179), mcx(cx,180), mcx(cx,181), mcx(cx,182), mcx(cx,183), mcx(cx,184));
      23 : cmd := MultABCOptDEF(ADoc, mcx(cx,186), mcx(cx,187), mcx(cx,188), mcx(cx,189), mcx(cx,190), mcx(cx,191), mcx(cx,192));
      24 : cmd := MultABCOptDEF(ADoc, mcx(cx,194), mcx(cx,195), mcx(cx,196), mcx(cx,197), mcx(cx,198), mcx(cx,199), mcx(cx,200));
      25 : cmd := MultABCOptDEF(ADoc, mcx(cx,202), mcx(cx,203), mcx(cx,204), mcx(cx,205), mcx(cx,206), mcx(cx,207), mcx(cx,208));
      26 : cmd := MultABCOptDEF(ADoc, mcx(cx,210), mcx(cx,211), mcx(cx,212), mcx(cx,213), mcx(cx,214), mcx(cx,215), mcx(cx,216));
      27 : cmd := MultABCOptDEF(ADoc, mcx(cx,218), mcx(cx,219), mcx(cx,220), mcx(cx,221), mcx(cx,222), mcx(cx,223), mcx(cx,224));
      28 : cmd := MultABCOptDEF(ADoc, mcx(cx,226), mcx(cx,227), mcx(cx,228), mcx(cx,229), mcx(cx,230), mcx(cx,231), mcx(cx,232));
      29 : cmd := MultABCOptDEF(ADoc, mcx(cx,234), mcx(cx,235), mcx(cx,236), mcx(cx,237), mcx(cx,238), mcx(cx,239), mcx(cx,240));
      30 : cmd := MultABCOptDEF(ADoc, mcx(cx,242), mcx(cx,243), mcx(cx,244), mcx(cx,245), mcx(cx,246), mcx(cx,247), mcx(cx,248));
      31 : cmd := MultABCOptDEF(ADoc, mcx(cx,250), mcx(cx,251), mcx(cx,252), mcx(cx,253), mcx(cx,254), mcx(cx,255), mcx(cx,256));
      32 : cmd := MultABCOptDEF(ADoc, mcx(cx,258), mcx(CX,259), mcx(CX,260), mcx(CX,261), mcx(CX,262), mcx(CX,263), mcx(CX,264));
      33 : cmd := MultABCOptDEF(ADoc, mcx(cx,266), mcx(CX,267), mcx(CX,268), mcx(CX,269), mcx(CX,270), mcx(CX,271), mcx(CX,272));
      34 : cmd := MultABCOptDEF(ADoc, mcx(cx,274), mcx(CX,275), mcx(CX,276), mcx(CX,277), mcx(CX,278), mcx(CX,279), mcx(CX,280));

      35 : Cmd := AddAndStoreCells(ADoc, CX, 283,
          [16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128, 136, 144, 152,
          160, 168, 176, 184, 192, 200, 208, 216, 224, 232, 240, 248, 256, 264, 272, 280]);

      36 : Cmd := GetPercentAndStoreCell(ADoc, CX, 287, 285, 286);
      37 : Cmd := GetPercentAndStoreCell(ADoc, CX, 291, 289, 290);
      38 : Cmd := GetPercentAndStoreCell(ADoc, CX, 295, 293, 294);
      39 : Cmd := GetPercentAndStoreCell(ADoc, CX, 299, 297, 298);
      40 : Cmd := GetPercentAndStoreCell(ADoc, CX, 303, 301, 302);
      41 : Cmd := GetPercentAndStoreCell(ADoc, CX, 307, 305, 306);
      42 : Cmd := GetPercentAndStoreCell(ADoc, CX, 311, 309, 310);
      43 : Cmd := GetPercentAndStoreCell(ADoc, CX, 315, 313, 314);

      44 : Cmd := AddAndStoreCells(ADoc, CX, 316, [287, 291, 295, 299, 303, 307, 311, 315]);

      46 : Cmd := GetPercentAndStoreCell(ADoc, CX, 320, 318, 319);
      47 : Cmd := GetPercentAndStoreCell(ADoc, CX, 324, 322, 323);
      48 : Cmd := GetPercentAndStoreCell(ADoc, CX, 328, 326, 327);
      49 : Cmd := GetPercentAndStoreCell(ADoc, CX, 332, 330, 331);
      50 : Cmd := GetPercentAndStoreCell(ADoc, CX, 336, 334, 335);

      45 : Cmd := AddAndStoreCells(ADoc, CX, 337, [320, 324, 328, 332, 336]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0272Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      1, 3 : cmd := SubtAB(ADoc, mcx(cx,81), mcx(cx,89), mcx(CX,90));
      2 : Cmd := AddAndStoreCells(ADoc, CX, 89, [83, 84, 85, 86, 88]);
      4 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 93, [90], [91, 92]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

function ProcessForm0273Math(ADoc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  repeat
    case Cmd of
      1 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 62, [59, 61], [60]);
      3 : Cmd := AddAndStoreCells(ADoc, CX, 74, [64, 65, 66, 67, 68, 69, 71, 73]);
      2, 4 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 75, [62], [74]);
      5 : Cmd := AddAndSubtractAndStoreCells(ADoc, CX, 79, [75], [76, 77, 78]);
    else
      Cmd := 0;
    end;
  until Cmd = 0;

  Result := 0;
end;

end.

