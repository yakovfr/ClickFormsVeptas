unit UMathIncome;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmSmIncome94    = 18;
  fmSmIncXLists   = 19;
  fmSmIncXRents   = 20;
  fmSmIncXCmps    = 21;
  fmIncome71A     = 148;    //22; old version
  fmIncome71A04   = 160;   //April 2004 update to the 71A - same math as the 1998 71A
  fmInc71AXCmps   = 23;
  fmInc71AXRents  = 24;
  fmInc71AXCosts  = 25;
  fmIncome71B     = 26;
  fmInc71BXCmps   = 27;
  fmInc71BXRents  = 28;
  fmCompRent      = 29;
  fmCompRentXComp = 122;
  fmOperIncome    = 32;
  fmCoOpForm      = 33;    //CoOp Request FNMA 1074
  fm1075Form      = 34;    //CoOp Report FNMA 1075
  fm1075XCmps     = 35;    //CoOp Report XComps FNMA 1075
//  fmReviewXRents  = 135;
//  fmReview1032    = 138;   //Review 1032 (2002)
//  fmRev1032XSales = 139;   //Revire 1032 (2002) Extra Sales

  function ProcessForm0018Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0019Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0020Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0021Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0148Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0023Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0024Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0025Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0026Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0027Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0028Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0029Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0122Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0032Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0033Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0034Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0035Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

//  function ProcessForm0135Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0138Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0139Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


// Income 71A

function F0148Process6Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0148Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0148Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0148Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0148Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0148Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0148Math(doc, C6, CX);
  result := 0;
end;

function F0148SumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc, CX, 28,29,30,31,32,33,35,0);
  result := SetInfoCellValue(doc, mcx(cx,2), V1);
end;

function F0148SumEstimatedCostsNew(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get10CellSumR(doc,cx, 71,74,77,80,83,86,89,91,93,95);
  V2 := Get10CellSumR(doc,cx, 97,99,101,103,105,107,109,111,113,115);
  VR := V1 + V2 + GetCellValue(doc, MCX(CX,117));
  result := SetCellValue(doc, MCX(cx, 118), VR);
end;

function F0148RentPerUnit(doc: TContainer; CX: CellUID; CUnit, CFur, CUnFur, CRent: Integer): Integer;
var
  V1,V2,V3, VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, CUnit));
  V2 := GetCellValue(doc, mcx(cx, CFur));
  V3 := GetCellValue(doc, mcx(cx, CUnFur));
  VR := V1 * (V2 + V3);
  result := SetCellValue(doc, MCX(cx, CRent), VR);
end;

function F0148UnitsPerAcre(doc: TContainer; CUnit, CSqft, CUAcre: CellUID): Integer;
var
  V1,V2, VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, CUnit);
  V2 := GetCellValue(doc, CSqft);
  if V2 <> 0 then
    begin
      VR := V1 / (V2 / 43560.0);
      result := SetCellValue(doc, CUAcre, VR);
    end;
end;

//used by F1048 & F0023: 71A & 71A XComps
function F71AExpensePercent(doc: TContainer; GrossC, NetC, PercentC: CellUID): Integer;
var
  VGross, VNet, VR: Double;
begin
  result := 0;
  VGross := GetCellValue(doc, GrossC);
  VNet := GetCellValue(doc, NetC);
  if VGross <> 0 then
    begin
      VR := ((VGross - VNet) / VGross) * 100;
      result := SetCellValue(doc, PercentC, VR);
    end;
end;

function F0148TaxRate(doc: TContainer; CTax, CPercent, CValue, CRate: CellUID): Integer;
var
  V1,V2,V3,V4, VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, CTax);
  V2 := GetCellValue(doc, CPercent);
  V3 := GetCellValue(doc, CValue);
  if V2 = 0 then V2 := 1 else V2 := (V2/100);
  V4 := (V2 * V3);  //calc percent of total
  if V4 <> 0 then
    begin
      VR := V1 / V4;
      result := SetCellValue(doc, CRate, VR);
    end;
end;

function F0148SumActualExps(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get10CellSumR(doc,cx, 7,10,15,19,22,25,28,31,34,37);
  VR := VR + Get10CellSumR(doc,cx, 40,43,46,49,52,55,58,61,64,67);
  VR := VR + Get10CellSumR(doc,cx, 70,73,76,80,83,87,90,94,98,102);
  VR := VR + Get10CellSumR(doc,cx, 106,110,113,116,119,122,125,129,133,136);
  VR := VR + Get8CellSumR(doc,cx, 139,142,145,149,153,0,0,0);
  result := SetCellValue(doc, mcx(cx,156), VR);
end;

function F0148SumForcastExps(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get10CellSumR(doc,cx, 8,11,16,20,23,26,29,32,35,38);
  VR := VR + Get10CellSumR(doc,cx, 41,44,47,50,53,56,59,62,65,68);
  VR := VR + Get10CellSumR(doc,cx, 71,74,77,81,84,88,91,95,99,103);
  VR := VR + Get10CellSumR(doc,cx, 107,111,114,117,120,123,126,130,134,137);
  VR := VR + Get8CellSumR(doc,cx, 140,143,146,150,154,0,0,0);
  result := SetCellValue(doc, mcx(cx,157), VR);
end;

//71A Schedule - Vacancy
function F0148RentSchedule(doc: TContainer; CellA, CellB, CellC, CellD, CellR: CellUID): Integer;
var
 V1, V2, V3, V4, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 V4 := GetCellValue(doc, CellD);
 VR := ((V1 - V2) * (V3 + V4));
 result := SetCellValue(doc, cellR, VR);
end;


// 71A function used by 71A and 71A XComps
// Function PricePerUnitNRm (Pg, Price, U1, U2, U3, U4, R1, R2, R3, R4, PPUnit, PPRoom: Integer): Integer;
function F71APricePerUnitNRm(doc: TContainer; CX: CellUID; Price, U1,U2,U3,U4,U5, R1,R2,R3,R4,R5, PPUnit, PPRoom: Integer): Integer;
var
  VP: Double;
  V1,V2,V3,V4,V5,VTU,VPPU: Double;
  V6,V7,V8,V9,V10,VTR,VPPR: Double;
begin
  VP := GetCellValue(doc, mcx(cx,Price));

  V1 := GetCellValue(doc, mcx(cx,U1));
  V2 := GetCellValue(doc, mcx(cx,U2));
  V3 := GetCellValue(doc, mcx(cx,U3));
  V4 := GetCellValue(doc, mcx(cx,U4));
  V5 := GetCellValue(doc, mcx(cx,U5));
  VTU := V1 + V2 + V3 + V4 + V5;

  if VTU <> 0 then
    begin
      VPPU := VP / VTU;   //price per total units
      SetCellValue(doc, mcx(cx,PPUnit), VPPU);
    end;

  V6 := GetCellValue(doc, mcx(cx,R1)) * Max(1, V1);
  V7 := GetCellValue(doc, mcx(cx,R2)) * Max(1, V2);
  V8 := GetCellValue(doc, mcx(cx,R3)) * Max(1, V3);
  V9 := GetCellValue(doc, mcx(cx,R4)) * Max(1, V4);
  V10 := GetCellValue(doc, mcx(cx,R5)) * Max(1, V5);
  VTR := V6 + V7 + V8 + V9 + V10;

  If VTR <> 0 then
    begin
      VPPR := VP / VTR;   //price per total rooms
      SetCellValue(doc, mcx(cx,PPRoom), VPPR);
    end;
  result := 0;
end;

//71 XComps
function F0023Process6Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0023Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0023Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0023Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0023Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0023Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0023Math(doc, C6, CX);
  result := 0;
end;


//Income 71B

function F0026Process6Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0026Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0026Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0026Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0026Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0026Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0026Math(doc, C6, CX);
  result := 0;
end;

function F0026Process10Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6,C7,C8,C9,C10: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0026Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0026Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0026Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0026Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0026Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0026Math(doc, C6, CX);
  if C7 > 0 then ProcessForm0026Math(doc, C7, CX);
  if C8 > 0 then ProcessForm0026Math(doc, C8, CX);
  if C9 > 0 then ProcessForm0026Math(doc, C9, CX);
  if C10 > 0 then ProcessForm0026Math(doc, C10, CX);
  result := 0;
end;

function F0026InfoSumLandUse(doc: TContainer; CX: CellUID):Integer;
var
  VR: Double;
begin
  VR := Get4CellSumR(doc, CX, 51, 52, 53, 54);
  VR := VR + GetCellValue(doc, MCX(CX,55));
  result := SetInfoCellValue(doc, mcx(cx,2), VR);
end;

function F0026LeaseHold(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
var
	V1, V2, VR: Double;
begin
  result := 0;
  if CellHasData(doc, CellB) then
    begin
	    V1 := GetCellValue(doc, CellA);
	    V2 := GetCellValue(doc, CellB);
	    VR := V1 - V2;
	    result := SetCellValue(doc, cellR, VR);
    end;
end;

function F0026RentPerUnit(doc: TContainer; CX: CellUID; CUnit, CFur, CUnFur, CRent: Integer): Integer;
var
  V1,V2,v3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,CUnit));
  V2 := GetCellValue(doc, mcx(cx,CFur));
  V3 := GetCellValue(doc, mcx(cx,CUnFur));
  VR := V1 * (V2 + V3);
  result := SetCellValue(doc, mcx(cx,CRent), VR);
end;

function F0026RentPerSqftNRoom (doc: TContainer; CX: CellUID; CRm, CSqft, CRent, CRtsq, CRtRm: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,CRent));
  if V1 > 0 then
    begin
      V2 := GetCellValue(doc, mcx(cx,CRm));
      if V2 > 0 then
        begin
          VR := V1 / V2;
          result := SetCellValue(doc, mcx(cx,CRtRm), VR);
        end;

      V2 := GetCellValue(doc, mcx(cx,CSqft));
      if V2 > 0 then
        begin
          VR := V1 / V2;
          result := SetCellValue(doc, mcx(cx,CRtsq), VR);
        end;
    end;
end;

function F0026RentPerSqftNRoom2(doc: TContainer; CX: CellUID; CUnits, CRm, CSqft, CRent, CRtSq, CRtRm: Integer): Integer;
Var
  V1,V2,V3,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,CRent));    //
  if V1 <> 0 then
    begin
      V2 := GetCellValue(doc, mcx(cx,CRm));
      if V2 <> 0 then
        begin
          VR := V1 / V2;
          result := SetCellValue(doc, mcx(cx,CRtRm), VR);
        end;

      V2 := GetCellValue(doc, mcx(cx,CSqft));
      V3 := GetCellValue(doc, mcx(cx,CUnits));
      if V3 = 0 then V3 := 1;
      if (V2 <> 0) then
        begin
          VR := V1 / (V3 * V2);
          result := SetCellValue(doc, mcx(cx,CRtSq), VR);
        end;
    end;
end;

function F0026RepoCostNew(doc: TContainer; CX: CellUID; CLen, CWid, CArea, CStories, CTotalArea, CPriceSqFt, CellR: Integer): Integer;
var
  V1,V2,V3,V4,V5,V6,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,CLen));
  V2 := GetCellValue(doc, mcx(cx,CWid));
  V3 := V1 * V2;		{CArea}
  SetCellValue(doc, mcx(cx,CArea), V3);

  V4 := GetCellValue(doc, mcx(cx,CStories));
  V5 := V4 * V3;		{CTotalArea}
  SetCellValue(doc, mcx(cx,CTotalArea), V5);

  V6 := GetCellValue(doc, mcx(cx,CPriceSqFt));
  VR := V6 * V5;
  result := SetCellValue(doc, mcx(cx,CellR), VR);
end;

//sum the subject sqft * units for transfer to page 3
function F0026PricePerSqftSub(doc: TContainer; CX: CellUID; CellR: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  result := 0;
  V1 := 0;
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,303)) * GetCellValue(doc, mcpx(cx,2,308)); 	{sqft/unit * unit}
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,318)) * GetCellValue(doc, mcpx(cx,2,323));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,333)) * GetCellValue(doc, mcpx(cx,2,338));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,348)) * GetCellValue(doc, mcpx(cx,2,353));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,363)) * GetCellValue(doc, mcpx(cx,2,368));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,378)) * GetCellValue(doc, mcpx(cx,2,383));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,393)) * GetCellValue(doc, mcpx(cx,2,398));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,408)) * GetCellValue(doc, mcpx(cx,2,413));
  V1 := V1 + GetCellValue(doc,mcpx(cx,2,423)) * GetCellValue(doc, mcpx(cx,2,428));

  V2 := GetCellValue(doc,mcpx(cx,3,47));       //subj sale price
  if V1 <> 0 then
    begin
      VR := V2/V1;
      result := SetCellValue(doc, cellR, VR);
    end;
end;


function F0026PricePerSqft(doc: TContainer; CX: CellUID; CellPrice, CellR, CellSq1, CellSq2, cellSq3, CellSq4: Integer): Integer;
var
  V1,V2,V3,V4,V5,V6,Vr: Double;
begin
  result := 0;
  V1 := GetCellValue(doc,mcpx(cx,2,CellSq1));
  V2 := GetCellValue(doc,mcpx(cx,2,CellSq2));
  V3 := GetCellValue(doc,mcpx(cx,2,CellSq3));
  V4 := GetCellValue(doc,mcpx(cx,2,CellSq4));
  V5 := V1 + V2 + V3 + V4;

  V6 := GetCellValue(doc,mcpx(cx,2,CellPrice));
  if (V6 <> 0) and (V5 <> 0) then
    begin
      VR := V6 / V5;
      result := SetCellValue(doc, mcx(cx,CellR), VR);
    end;
end;


function F0026RentSchedule(doc: TContainer; CellA, CellB, CellC, CellD, CellR: CellUID): Integer;
var
 V1, V2, V3, V4, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 V4 := GetCellValue(doc, CellD);
 VR := ((V1 - V2) * (V3 + V4));
 result := SetCellValue(doc, cellR, VR);
end;




function F0026SumActualExpenses(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := Get10CellSumR(doc,cx, 256,258,260,262,264,266,268,270,272,274);
  V2 := Get10CellSumR(doc,cx, 276,278,280,282,284,286,288,291,293,295);
  V3 := Get4CellSumR(doc,cx, 297,299,302,0);

  VR := V1 + V2 + V3;
  result := SetCellValue(doc, mcx(cx,304), VR);
end;

function F0026SumForcastedExpenses(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := Get10CellSumR(doc,cx, 257,259,261,263,265,267,269,271,273,275);
  V2 := Get10CellSumR(doc,cx, 277,279,281,283,285,287,289,292,294,296);
  V3 := Get4CellSumR(doc,cx, 298,300,303,0);

  VR := V1 + V2 + V3;
  result := SetCellValue(doc,  mcx(cx,305), VR);
end;

///	function PricePerUnitNRm (Pg, Price, U1, U2, U3, U4, R1, R2, R3, R4, PPUnit, PPRoom: Integer): Integer;
function F0026PricePerUnitNRm(doc: TContainer; CX: CellUID; Price, U1, U2, U3, U4, R1, R2, R3, R4, PPUnit, PPRoom: Integer): Integer;
var
  VP: Double;
  V1,V2,V3,V4,VTU,VPPU: Double;
  V5,V6,V7,V8,VTR,VPPR: Double;
begin
  VP := GetCellValue(doc, mcx(cx,Price));

  V1 := GetCellValue(doc, mcx(cx,U1));
  V2 := GetCellValue(doc, mcx(cx,U2));
  V3 := GetCellValue(doc, mcx(cx,U3));
  V4 := GetCellValue(doc, mcx(cx,U4));
  VTU := V1 + V2 + V3 + V4;

  if VTU <> 0 then
    begin
      VPPU := VP / VTU;   //price per total units
      SetCellValue(doc, mcx(cx,PPUnit), VPPU);
    end;

  V5 := GetCellValue(doc, mcx(cx,R1)) * Max(1, V1);
  V6 := GetCellValue(doc, mcx(cx,R2)) * Max(1, V2);
  V7 := GetCellValue(doc, mcx(cx,R3)) * Max(1, V3);
  V8 := GetCellValue(doc, mcx(cx,R4)) * Max(1, V4);
  VTR := V5 + V6 + V7 + V8;

  If VTR <> 0 then
    begin
      VPPR := VP / VTR;   //price per total rooms
      SetCellValue(doc, mcx(cx,PPRoom), VPPR);
    end;
  result := 0;
end;

function F0026ExpensePercent(doc: TContainer; GrossC, NetC, PercentC: CellUID): Integer;
var
  VGross, VNet, VR: Double;
begin
  VGross := GetCellValue(doc, GrossC);
  VNet := GetCellValue(doc, NetC);

  VR := 0;
  if VGross <> 0 then
    VR := ((VGross - VNet) / VGross) * 100;

  result := SetCellValue(doc, PercentC, VR);
end;

//71B Income Xtra Comps
function F0027Process6Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0027Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0027Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0027Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0027Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0027Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0027Math(doc, C6, CX);
  result := 0;
end;

(*
//Small Income94

	function TotalRmsInLevel (N: Integer; CellR: CellID): Integer;
		var
			i: Integer;
	begin
		CellResult := 0.0;
		for i := 0 to 5 do
			CellResult := CellResult + GetCellValue(CurWPtr, MC(2, N + i));
		CellParm := GetCellParm(CurWPtr, CellR);
		TotalRmsInLevel := Result2Cell(FormatNumber(CellResult, CellParm), CellR);
	end;

	function AgeLifeDepr: Integer;		{*****NOT USED ANYMORE ******}
	begin
		AgeLifeDepr := 0;
		Val[5] := GetAvgValue(mc(2, 10));			{Effective life}
		Val[6] := GetAvgValue(mc(2, 187));		{Est Remaining econ life}
		if (Val[5] <> 0) & (Val[6] <> 0) then
			begin
				CellResult := (Val[5] / (Val[5] + Val[6])) * 100.0;
				CellParm := GetCellParm(CurWPtr, MC(2, 215));
				AgeLifeDepr := Result2Cell(FormatNumber(CellResult, CellParm), MC(2, 215));
			end;
	end;


	function SubjectSalesP: Integer;
		var
			DNC: Integer;
			ExtVal: Extended;
	begin
		DNC := DivideAB(MC(4, 4), MC(4, 20), MC(4, 5));						{set sales/GBA}
		DNC := DivideAB(MC(4, 4), MC(4, 6), MC(4, 7));						{set sales/rent}
		ExtVal := Sum4Cells(MC(4, 21), MC(4, 26), MC(4, 31), MC(4, 36));	{set sales/unit}
		DNC := DivideAByVal(MC(4, 4), MC(4, 8), ExtVal);
		ExtVal := Sum4Cells(MC(4, 22), MC(4, 27), MC(4, 32), MC(4, 37));	{set sales/rms}
		DNC := DivideAByVal(MC(4, 4), MC(4, 9), ExtVal);
		SubjectSalesP := 0;
	end;

	function SubSalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 21), MC(4, 26), MC(4, 31), MC(4, 36));	{set sales/unit}
		SubSalePerUnit := DivideAByVal(MC(4, 4), MC(4, 8), ExtVal);
	end;
	function SubSalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 22), MC(4, 27), MC(4, 32), MC(4, 37));	{set sales/rms}
		SubSalePerRoom := DivideAByVal(MC(4, 4), MC(4, 9), ExtVal);
	end;

	function C1SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 88), MC(4, 94), MC(4, 100), MC(4, 106));		{set sales/unit}
		C1SalePerUnit := DivideAByVal(MC(4, 54), MC(4, 58), ExtVal);
	end;
	function C1SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 89), MC(4, 95), MC(4, 101), MC(4, 107));		{set sales/rms}
		C1SalePerRoom := DivideAByVal(MC(4, 54), MC(4, 59), ExtVal);
	end;

	function C2SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 169), MC(4, 175), MC(4, 181), MC(4, 187));	{set sales/unit}
		C2SalePerUnit := DivideAByVal(MC(4, 135), MC(4, 139), ExtVal);
	end;
	function C2SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 170), MC(4, 176), MC(4, 182), MC(4, 188));	{set sales/rms}
		C2SalePerRoom := DivideAByVal(MC(4, 135), MC(4, 140), ExtVal);
	end;

	function C3SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 250), MC(4, 256), MC(4, 262), MC(4, 268));	{set sales/unit}
		C3SalePerUnit := DivideAByVal(MC(4, 216), MC(4, 220), ExtVal);
	end;
	function C3SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(MC(4, 251), MC(4, 257), MC(4, 263), MC(4, 269));	{set sales/rms}
		C3SalePerRoom := DivideAByVal(MC(4, 216), MC(4, 221), ExtVal);
	end;

	function C4SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 96), mc(7, 102), mc(7, 108), mc(7, 114));		{set sales/unit}
		C4SalePerUnit := DivideAByVal(mc(7, 62), mc(7, 66), ExtVal);
	end;
	function C4SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 97), mc(7, 103), mc(7, 109), mc(7, 115));		{set sales/rms}
		C4SalePerRoom := DivideAByVal(mc(7, 62), mc(7, 67), ExtVal);
	end;

	function C5SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 177), mc(7, 183), mc(7, 189), mc(7, 195));		{set sales/unit}
		C5SalePerUnit := DivideAByVal(mc(7, 143), mc(7, 147), ExtVal);
	end;
	function C5SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 178), mc(7, 184), mc(7, 189), mc(7, 195));		{set sales/rms}
		C5SalePerRoom := DivideAByVal(mc(7, 143), mc(7, 148), ExtVal);
	end;

	function C6SalePerUnit: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 258), mc(7, 264), mc(7, 270), mc(7, 276));		{set sales/unit}
		C6SalePerUnit := DivideAByVal(mc(7, 224), mc(7, 228), ExtVal);
	end;
	function C6SalePerRoom: Integer;
		var
			ExtVal: Extended;
	begin
		ExtVal := Sum4Cells(mc(7, 259), mc(7, 265), mc(7, 271), mc(7, 277));		{set sales/rms}
		C6SalePerRoom := DivideAByVal(mc(7, 224), mc(7, 229), ExtVal);
	end;

	function SpecialSumLandUse: Integer;
	begin
		Val[1] := Sum4Cells(MC(1, 92), MC(1, 93), MC(1, 94), MC(1, 95));
		Val[2] := GetCellValue(CurWPtr, MC(1, 97));

		CellResult := Val[1] + Val[2];
		Result2InfoCell(1, 2, Num2Longint(CellResult));

		SpecialSumLandUse := 0;
	end;

	function FillReviewerInfo: Integer;
	end;

	function FillInAppraiserInfo: Integer;
	end;

	function InspectProperty: Integer;
	end;

	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
{Page 2 math}
					1: 
						Cmd := SumFourCells(MC(2, 52), MC(2, 66), MC(2, 80), MC(2, 94), MC(2, 101));	{Sum Baths}
					2: 
						Cmd := MultAB(MC(2, 55), MC(2, 43), MC(2, 56));		{level 1sqft}
					3: 
						Cmd := MultAB(MC(2, 69), MC(2, 57), MC(2, 70));		{level 2 sqft}
					4: 
						Cmd := MultAB(MC(2, 83), MC(2, 71), MC(2, 84));		{level 3 sqft}
					5: 
						Cmd := MultAB(MC(2, 97), MC(2, 85), MC(2, 98));		{level 4 sqft}
					6: 
						Cmd := SumFourCells(MC(2, 56), MC(2, 70), MC(2, 84), MC(2, 98), MC(2, 102));		{sum sqft}
					7: 
						Cmd := SumRooms;		{sum all rooms}
					8: 
						Cmd := SumFourCells(MC(2, 51), MC(2, 65), MC(2, 79), MC(2, 93), MC(2, 100));	{sum bedrooms}
					9: 
						Cmd := MultAB(MC(2, 157), MC(2, 158), MC(2, 159));	{1st sqft @}
					10: 
						Cmd := MultAB(MC(2, 160), MC(2, 161), MC(2, 162));	{2st sqft @}
					11: 
						Cmd := MultAB(MC(2, 163), MC(2, 164), MC(2, 165));	{3st sqft @}
					12: 
						Cmd := MultAB(MC(2, 166), MC(2, 167), MC(2, 168));	{4st sqft @}
					52: 
						Cmd := MultAB(MC(2, 169), MC(2, 170), MC(2, 171));	{5st sqft @}
					13: 
						Cmd := TotalEstNewCost;		{sum all costs}
					14: 
						Cmd := ValueByCostApprch;		{sum site Imp, site val, depr imp}
					15: 
						Cmd := SumFourCells(mc(2, 188), mc(2, 190), mc(2, 192), mc(0, 0), mc(2, 193));	{sum Deprs}
					16: 
						Cmd := NewCostLessDepr;		{subtract new cost & depr}
					17: 
						Cmd := Depreciation;				{calc all 3 depreciations}

{Page 3 math}
					18: 
						Cmd := SumFourCells(MC(3, 196), MC(3, 206), MC(3, 216), MC(3, 226), MC(3, 236));	{sum units}
					19: 
						Cmd := SumFourCells(MC(3, 199), MC(3, 209), MC(3, 219), MC(3, 229), MC(3, 237));	{sum vacancys}
					20: 
						Cmd := SumFourCells(MC(3, 202), MC(3, 212), MC(3, 222), MC(3, 232), MC(3, 238));	{sum Act Rents}
					21: 
						Cmd := SumFourCells(MC(3, 205), MC(3, 215), MC(3, 225), MC(3, 235), MC(3, 239));	{sum Est Rents}
					22: 
						begin
							Cmd := AnnualVacancy(mc(3, 239), mc(3, 244), mc(3, 245));	{percent vacancy}
							Cmd := SumAB(MC(3, 239), MC(3, 241), MC(3, 246));		{total gross est rents}
						end;
					23: 
						Cmd := SumRents(mc(3, 196), MC(3, 200), MC(3, 201), MC(3, 202));	{sum 1st act rents}
					24: 
						Cmd := SumRents(mc(3, 206), MC(3, 210), MC(3, 211), MC(3, 212));		{sum 2st act rents}
					25: 
						Cmd := SumRents(mc(3, 216), MC(3, 220), MC(3, 221), MC(3, 222));		{sum 3st act rents}
					26: 
						Cmd := SumRents(mc(3, 226), MC(3, 230), MC(3, 231), MC(3, 232));		{sum 4st act rents}
					27: 
						Cmd := SumRents(mc(3, 196), MC(3, 203), MC(3, 204), MC(3, 205));		{sum 1st est rents}
					28: 
						Cmd := SumRents(mc(3, 206), MC(3, 213), MC(3, 214), MC(3, 215));		{sum 2st est rents}
					29: 
						Cmd := SumRents(mc(3, 216), MC(3, 223), MC(3, 224), MC(3, 225));		{sum 3st est rents}
					30: 
						Cmd := SumRents(mc(3, 226), MC(3, 233), MC(3, 234), MC(3, 235));		{sum 4st est rents}

{Page 4 math}
					31: 
						Cmd := SumAdjustments1;		{sum comps 1 adjustments}
					32: 
						Cmd := SumAdjustments2;		{sum comps 2 adjustments}
					33: 
						Cmd := SumAdjustments3;		{sum comps 3 adjustments}
					34: 
						Cmd := SubjectSalesP;			{when sales Price changes}
					35: 
						begin								{when Comp1 Price changes}
							ProcessCurCellInfo(WPtr, 38);
							ProcessCurCellInfo(WPtr, 46);
							ProcessCurCellInfo(WPtr, 59);
							ProcessCurCellInfo(WPtr, 60);
							ProcessCurCellInfo(WPtr, 131);
							Cmd := 0;
						end;
					36: 
						begin								{when Comp2 Price changes}
							ProcessCurCellInfo(WPtr, 39);
							ProcessCurCellInfo(WPtr, 47);
							ProcessCurCellInfo(WPtr, 61);
							ProcessCurCellInfo(WPtr, 62);
							ProcessCurCellInfo(WPtr, 132);
							Cmd := 0;
						end;
					37: 
						begin								{when Comp3 Price changes}
							ProcessCurCellInfo(WPtr, 40);
							ProcessCurCellInfo(WPtr, 48);
							ProcessCurCellInfo(WPtr, 63);
							ProcessCurCellInfo(WPtr, 64);
							ProcessCurCellInfo(WPtr, 133);
							Cmd := 0;
						end;
					38: 								{when C1 adj chged}
						begin
							ProcessCurCellInfo(WPtr, 118);
							Cmd := SetCheckMark(mc(4, 128), mc(4, 126), mc(4, 127));
							Cmd := SumAB(MC(4, 54), MC(4, 128), MC(4, 129));		{get adjusted value}
						end;
					39:  								{when C2 adj chged}
						begin
							ProcessCurCellInfo(WPtr, 119);
							Cmd := SetCheckMark(mc(4, 209), mc(4, 207), mc(4, 208));
							Cmd := SumAB(MC(4, 135), MC(4, 209), MC(4, 210));	{get adjusted value}
						end;
					40:  								{when C3 adj chged}
						begin
							ProcessCurCellInfo(WPtr, 120);
							Cmd := SetCheckMark(mc(4, 290), mc(4, 288), mc(4, 289));
							Cmd := SumAB(MC(4, 216), MC(4, 290), MC(4, 291));	{get adjusted value}
						end;
					41: 
						begin
							ProcessCurCellInfo(WPtr, 114);
							ProcessCurCellInfo(WPtr, 115);
							ProcessCurCellInfo(WPtr, 116);
							ProcessCurCellInfo(WPtr, 130);			{chged Sub sqft}
							Cmd := 0;
						end;
					42: 
						begin											{chged c1 sqft}
							ProcessCurCellInfo(WPtr, 114);			{make adj}
							ProcessCurCellInfo(WPtr, 131);			{price/GBA}
							Cmd := 0;
						end;
					43: 
						begin											{chged c2 sqft}
							ProcessCurCellInfo(WPtr, 115);			{Make adj}
							ProcessCurCellInfo(WPtr, 132);			{price/GBA}
							Cmd := 0;
						end;
					44: 
						begin											{chged c3 sqft}
							ProcessCurCellInfo(WPtr, 116);			{Make adj}
							ProcessCurCellInfo(WPtr, 133);			{price/GBA}
							Cmd := 0;
						end;
					45: 
						begin
							Cmd := TransA2B(MC(4, 6), MC(4, 306));
							Cmd := DivideAB(MC(4, 4), MC(4, 6), MC(4, 7));				{chged Sub Rent}
						end;
					46: 
						Cmd := DivideAB(MC(4, 54), MC(4, 56), MC(4, 57));			{chged Comp1 Rent}
					47: 
						Cmd := DivideAB(MC(4, 135), MC(4, 137), MC(4, 138));		{chged Comp2 Rent}
					48: 
						Cmd := DivideAB(MC(4, 216), MC(4, 218), MC(4, 219));		{chged Comp3 Rent}
					49: 
						Cmd := TransA2B(MC(4, 7), MC(4, 307));						{dup the gross rent}
					50: 
						Cmd := MultAB(MC(4, 306), MC(4, 307), MC(4, 308));			{rent x Rent Mutliplier}
					51: 
						Cmd := TransA2B(MC(4, 308), MC(4, 311));			{income apprch:trans 2 recon}
					53: 
						Cmd := TransA2B(MC(2, 196), MC(4, 312));			{cost apprch: trans 2 recon}
					54: 
						Cmd := TransA2B(MC(1, 26), MC(4, 4));				{trans sales price}
					55: 
						Cmd := TransA2B(MC(3, 246), MC(4, 6));			{trans gross rents}
					56: 
						Cmd := TransA2B(MC(2, 102), MC(4, 20));			{trans  GBA}
					57: 
						Cmd := SubSalePerUnit;			{Subj salesP/units}
					58: 
						Cmd := SubSalePerRoom;		{Subj salesP/rooms}
					59: 
						Cmd := C1SalePerUnit;			{Comp1 salesP/units}
					60: 
						Cmd := C1SalePerRoom;			{Comp1 salesP/rooms}
					61: 
						Cmd := C2SalePerUnit;			{Comp2 salesP/units}
					62: 
						Cmd := C2SalePerRoom;			{Comp2 salesP/rooms}
					63: 
						Cmd := C3SalePerUnit;			{Comp3 salesP/units}
					64: 
						Cmd := C3SalePerRoom;			{Comp3 salesP/rooms}

{transfers & calc on improvements on page 2}
					65: 
						begin
							ProcessCurCellInfo(WPtr, 2);						{1-do units * sqft calc}
							Cmd := TransA2B(MC(2, 43), MC(3, 196));		{then transfer}
						end;
					66: 
						begin
							ProcessCurCellInfo(WPtr, 3);						{2-do units * sqft calc}
							Cmd := TransA2B(MC(2, 57), MC(3, 206));		{then transfer}
						end;
					67: 
						begin
							ProcessCurCellInfo(WPtr, 4);						{3-do units * sqft calc}
							Cmd := TransA2B(MC(2, 71), MC(3, 216));		{then transfer}
						end;
					68: 
						begin
							ProcessCurCellInfo(WPtr, 5);						{4-do units * sqft calc}
							Cmd := TransA2B(MC(2, 85), MC(3, 226));		{then transfer}
						end;
					69: 
						begin
							ProcessCurCellInfo(WPtr, 8);						{1-do sum of bedrooms}
							ProcessCurCellInfo(WPtr, 110);					{level 1 rm total & all rooms}
							Cmd := TransA2B(MC(2, 51), MC(3, 18));		{then transfer}
						end;
					70: 
						begin
							ProcessCurCellInfo(WPtr, 8);						{2-do sum of bedrooms}
							ProcessCurCellInfo(WPtr, 111);					{level 2 rm total & all rooms}
							Cmd := TransA2B(MC(2, 65), MC(3, 22));		{then transfer}
						end;
					71: 
						begin
							ProcessCurCellInfo(WPtr, 8);						{3-do sum of bedrooms}
							ProcessCurCellInfo(WPtr, 112);					{level 3 rm total & all rooms}
							Cmd := TransA2B(MC(2, 79), MC(3, 26));		{then transfer}
						end;
					72: 
						begin
							ProcessCurCellInfo(WPtr, 8);						{4-do sum of bedrooms}
							ProcessCurCellInfo(WPtr, 113);					{level 4 rm total & all rooms}
							Cmd := TransA2B(MC(2, 93), MC(3, 30));		{then transfer}
						end;
					73: 
						begin
							ProcessCurCellInfo(WPtr, 1);						{1-do sum of baths}
							Cmd := TransA2B(MC(2, 52), MC(3, 19));		{then transfer}
						end;
					74: 
						begin
							ProcessCurCellInfo(WPtr, 1);						{2-do sum of baths}
							Cmd := TransA2B(MC(2, 66), MC(3, 23));		{then transfer}
						end;
					75: 
						begin
							ProcessCurCellInfo(WPtr, 1);						{3-do sum of baths}
							Cmd := TransA2B(MC(2, 80), MC(3, 27));		{then transfer}
						end;
					76: 
						begin
							ProcessCurCellInfo(WPtr, 1);						{4-do sum of baths}
							Cmd := TransA2B(MC(2, 94), MC(3, 31));		{then transfer}
						end;
					77: 
						begin
							ProcessCurCellInfo(WPtr, 2);						{1-do sqft * units calc}
							Cmd := TransA2B(MC(2, 55), MC(3, 20));		{then transfer sqft}
						end;
					78: 
						begin
							ProcessCurCellInfo(WPtr, 3);						{2-do sqft * units calc}
							Cmd := TransA2B(MC(2, 69), MC(3, 24));		{then transfer sqft}
						end;
					79: 
						begin
							ProcessCurCellInfo(WPtr, 4);						{3-do sqft * units calc}
							Cmd := TransA2B(MC(2, 83), MC(3, 28));		{then transfer sqft}
						end;
					80: 
						begin
							ProcessCurCellInfo(WPtr, 5);						{4-do sqft * units calc}
							Cmd := TransA2B(MC(2, 97), MC(3, 32));		{then transfer sqft}
						end;
					81: 
						begin
							ProcessCurCellInfo(WPtr, 19);					{sum the vacs}
							Cmd := TransA2B(MC(3, 199), MC(4, 25));		{transfer vac 1}
						end;
					82: 
						begin
							ProcessCurCellInfo(WPtr, 19);					{sum the vacs}
							Cmd := TransA2B(MC(3, 209), MC(4, 30));		{transfer vac 2}
						end;
					83: 
						begin
							ProcessCurCellInfo(WPtr, 19);					{sum the vacs}
							Cmd := TransA2B(MC(3, 219), MC(4, 35));		{transfer vac 3}
						end;
					84: 
						begin
							ProcessCurCellInfo(WPtr, 19);					{sum the vacs}
							Cmd := TransA2B(MC(3, 229), MC(4, 40));		{transfer vac 4}
						end;
					85: 
						begin
							ProcessCurCellInfo(WPtr, 18);					{sum the units}
							ProcessCurCellInfo(WPtr, 23);					{sum the act rents}
							ProcessCurCellInfo(WPtr, 27);					{sum the est rents}
							Cmd := TransA2B(MC(3, 196), MC(4, 21));		{transfer unit 1}
						end;
					86: 
						begin
							ProcessCurCellInfo(WPtr, 18);					{sum the units}
							ProcessCurCellInfo(WPtr, 24);					{sum the act rents}
							ProcessCurCellInfo(WPtr, 28);					{sum the est rents}
							Cmd := TransA2B(MC(3, 206), MC(4, 26));		{transfer unit 2}
						end;
					87: 
						begin
							ProcessCurCellInfo(WPtr, 18);					{sum the units}
							ProcessCurCellInfo(WPtr, 25);					{sum the act rents}
							ProcessCurCellInfo(WPtr, 29);					{sum the est rents}
							Cmd := TransA2B(MC(3, 216), MC(4, 31));		{transfer unit 3}
						end;
					88: 
						begin
							ProcessCurCellInfo(WPtr, 18);					{sum the units}
							ProcessCurCellInfo(WPtr, 26);					{sum the act rents}
							ProcessCurCellInfo(WPtr, 30);					{sum the est rents}
							Cmd := TransA2B(MC(3, 226), MC(4, 36));		{transfer unit 4}
						end;
					89: 
						Cmd := SumAdjustments4;		{comps 4 adj}
					90: 
						Cmd := SumAdjustments5;		{comps 5 adj}
					91: 
						Cmd := SumAdjustments6;		{comps 6 adj}
					92: 
						Cmd := SumAB(mc(7, 62), mc(7, 136), mc(7, 137));		{4: sales + adj = net}
					93: 
						Cmd := SumAB(mc(7, 143), mc(7, 217), mc(7, 218));		{5: sales + adj = net}
					94: 
						Cmd := SumAB(mc(7, 224), mc(7, 298), mc(7, 299));		{6: sales + adj = net}
					95: 
						Cmd := DivideAB(mc(7, 62), mc(7, 92), mc(7, 63));			{4: sales/GBA}
					96: 
						Cmd := DivideAB(mc(7, 143), mc(7, 173), mc(7, 144));		{5: sales/GBA}
					97: 
						Cmd := DivideAB(mc(7, 224), mc(7, 254), mc(7, 225));		{6: sales/GBA}
					98: 
						Cmd := DivideAB(mc(7, 62), mc(7, 64), mc(7, 65));			{4: sales/mo rent = gross rent multiplier}
					99: 
						Cmd := DivideAB(mc(7, 143), mc(7, 145), mc(7, 146));		{5: sales/mo rent = gross rent multiplier}
					100: 
						Cmd := DivideAB(mc(7, 224), mc(7, 226), mc(7, 227));		{6: sales/mo rent = gross rent multiplier}

					101: 
						Cmd := C4SalePerUnit;				{C4 salesP/units}
					102: 
						Cmd := C4SalePerRoom;				{C4 salesP/rooms}
					103: 
						Cmd := C5SalePerUnit;				{C5 salesP/units}
					104: 
						Cmd := C5SalePerRoom;				{C5 salesP/rooms}
					105: 
						Cmd := C6SalePerUnit;				{C6 salesP/units}
					106: 
						Cmd := C6SalePerRoom;				{C6 salesP/rooms}

					107: 
						Cmd := SetCheckMark(mc(7, 136), mc(7, 134), mc(7, 135));		{adj4- checkboxes}
					108: 
						Cmd := SetCheckMark(mc(7, 217), mc(7, 215), mc(7, 216));		{adj5- checkboxes}
					109: 
						Cmd := SetCheckMark(mc(7, 298), mc(7, 296), mc(7, 297));		{adj6- checkboxes}
					110: 
						begin
							ProcessCurCellInfo(WPtr, 7);						{sum the rooms}
							Cmd := TotalRmsInLevel(46, MC(3, 17));		{total rms in level 1}
						end;
					111: 
						begin
							ProcessCurCellInfo(WPtr, 7);						{sum the rooms}
							Cmd := TotalRmsInLevel(60, MC(3, 21));		{total rms in level 2}
						end;
					112: 
						begin
							ProcessCurCellInfo(WPtr, 7);						{sum the rooms}
							Cmd := TotalRmsInLevel(74, MC(3, 25));		{total rms in level 3}
						end;
					113: 
						begin
							ProcessCurCellInfo(WPtr, 7);						{sum the rooms}
							Cmd := TotalRmsInLevel(88, MC(3, 29));		{total rms in level 4}
						end;
					114: 
						Cmd := SqFtAdjust(mc(4, 20), mc(4, 84), mc(4, 85));		{Comp1 sqft adj}
					115: 
						Cmd := SqFtAdjust(mc(4, 20), mc(4, 165), mc(4, 166));	{Comp2 sqft adj}
					116: 
						Cmd := SqFtAdjust(mc(4, 20), mc(4, 246), mc(4, 247));	{Comp3 sqft adj}
					117: 
						Cmd := SpecialSumLandUse;
					118: 
						Cmd := InfoAdjPercentage(mc(4, 54), 1, 4, 5);		{C1 Net Gross Adjs}
					119: 
						Cmd := InfoAdjPercentage(mc(4, 135), 2, 6, 7);		{C2 Net Gross Adjs}
					120: 
						Cmd := InfoAdjPercentage(mc(4, 216), 3, 8, 9);		{C3 Net Gross Adjs}
					121: 
						Cmd := InfoSalesAverage;
					122: 
						Cmd := AnnualVacancy(mc(3, 239), mc(3, 244), mc(3, 245));
					123: 
						Cmd := SiteDimension(mc(1, 159), mc(1, 160));

					124: 
						Cmd := LeaseholdSimple;
					125: 
						Cmd := TRansA2B(mc(1, 75), mc(2, 5));
					126: 
						Cmd := Location;

					127: 
						Cmd := InfoAdjPercentage(mc(7, 62), 4, 4, 5);		{C4 Net Gross Adjs}
					128: 
						Cmd := InfoAdjPercentage(mc(7, 143), 5, 6, 7);		{C5 Net Gross Adjs}
					129: 
						Cmd := InfoAdjPercentage(mc(7, 224), 6, 8, 9);		{C6 Net Gross Adjs}
					130: 
						Cmd := DivideAB(MC(4, 4), MC(4, 20), MC(4, 5));				{chged Sub sqft}
					131: 
						Cmd := DivideAB(MC(4, 54), MC(4, 84), MC(4, 55));			{C1 set sales/GBA}
					132: 
						Cmd := DivideAB(MC(4, 135), MC(4, 165), MC(4, 136));		{C2 set sales/GBA}
					133: 
						Cmd := DivideAB(MC(4, 216), MC(4, 246), MC(4, 217));		{C3 set sales/GBA}

					134: 						{c4 chged adj value}
						begin
							ProcessCurCellInfo(WPtr, 92);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 107);			{checkmark}
							ProcessCurCellInfo(WPtr, 127);			{info adj percentages}
							Cmd := 0;
						end;
					135: 						{c5 chged adj value}
						begin
							ProcessCurCellInfo(WPtr, 93);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 108);			{checkmark}
							ProcessCurCellInfo(WPtr, 128);			{info adj percentages}
							Cmd := 0;
						end;
					136: 						{c6 chged adj value}
						begin
							ProcessCurCellInfo(WPtr, 94);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 109);			{checkmark}
							ProcessCurCellInfo(WPtr, 129);			{info adj percentages}
							Cmd := 0;
						end;

					137: 
						Cmd := SetAddressCityStZip(mc(1, 3), mc(1, 4), mc(1, 5), mc(1, 6), mc(9, 1));


					138: 						{C4 sale price chged}
						begin
							ProcessCurCellInfo(WPtr, 92);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 95);			{salesP/GBA}
							ProcessCurCellInfo(WPtr, 98);			{Gross Rent Multi}
							ProcessCurCellInfo(WPtr, 101);			{salesP/Unit}
							ProcessCurCellInfo(WPtr, 102);			{salesP/Room}
							ProcessCurCellInfo(WPtr, 127);			{info adj percentages}
							Cmd := 0;
						end;
					139: 						{C5 sale price chged}
						begin
							ProcessCurCellInfo(WPtr, 93);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 96);			{salesP/GBA}
							ProcessCurCellInfo(WPtr, 99);			{Gross Rent Multi}
							ProcessCurCellInfo(WPtr, 103);			{salesP/Unit}
							ProcessCurCellInfo(WPtr, 104);			{salesP/Room}
							ProcessCurCellInfo(WPtr, 128);			{info adj percentages}
							Cmd := 0;
						end;
					140: 						{C6 sale price chged}
						begin
							ProcessCurCellInfo(WPtr, 94);			{sales + adj = net}
							ProcessCurCellInfo(WPtr, 97);			{salesP/GBA}
							ProcessCurCellInfo(WPtr, 100);			{Gross Rent Multi}
							ProcessCurCellInfo(WPtr, 105);			{salesP/Unit}
							ProcessCurCellInfo(WPtr, 106);			{salesP/Room}
							ProcessCurCellInfo(WPtr, 129);			{info adj percentages}
							Cmd := 0;
						end;

					141: 					{subj sqft chged}
						begin
							ProcessCurCellInfo(WPtr, 149);			{C4 sqft adj}
							ProcessCurCellInfo(WPtr, 150);			{C5 sqft adj}
							ProcessCurCellInfo(WPtr, 151);			{C6 sqft adj}
							Cmd := 0;
						end;
					142: 
						begin					{C4 sqft Chged}
							ProcessCurCellInfo(WPtr, 95);			{sales P/GBA}
							ProcessCurCellInfo(WPtr, 149);			{sqft adj}
							Cmd := 0;
						end;
					143:
						begin					{C5 sqft Chged}
							ProcessCurCellInfo(WPtr, 96);			{sales P/GBA}
							ProcessCurCellInfo(WPtr, 150);			{sqft adj}
							Cmd := 0;
						end;
					144:
						begin					{C6 sqft Chged}
							ProcessCurCellInfo(WPtr, 97);			{sales P/GBA}
							ProcessCurCellInfo(WPtr, 151);			{sqft adj}
							Cmd := 0;
						end;

					145:
						Cmd := FillReviewerInfo;
					146:
						Cmd := AtticNone;
					147:
						Cmd := CarStorageNone;
					148:
						Cmd := TRansA2B(mc(1, 26), mc(4, 4));		{transfer sales price}

					149:
						Cmd := SqFtAdjust(mc(7, 28), mc(7, 92), mc(7, 93));			{C4 sqft adj}
					150:
						Cmd := SqFtAdjust(mc(7, 28), mc(7, 173), mc(7, 174));		{C5 sqft adj}
					151:
						Cmd := SqFtAdjust(mc(7, 28), mc(7, 254), mc(7, 255));		{C6 sqft adj}


					189:
						Cmd := TransA2B(mc(1, 78), mc(4, 18));		{trans Age}
					190:
						Cmd := TransA2B(mc(1, 200), mc(4, 15));	{trans view}
					191:
						Cmd := TransA2B(mc(2, 6), mc(4, 16));		{trans design}

					192:
						Cmd := TransA2B(mc(2, 99), mc(1, 110));		{rooms to listing}
					193:
						Cmd := TransA2B(mc(2, 100), mc(1, 111));		{bedrooms}
					194:
						Cmd := TransA2B(mc(2, 101), mc(1, 112));		{bathrooms}
					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

*)

(*
//Operating Income Statement

	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;

	function SumCurRents (CellA, CellB, CellC, CellD, CellR: CellID): Integer;
	begin
		CellResult := Sum4Cells(CellA, CellB, CellC, CellD);
		CellParm := GetCellParm(CurWPtr, CellR);
		SumCurRents := Result2Cell(FormatNumber(CellResult, CellParm), CellR);
	end;

	function SumMktRents (CellA, CellB, CellC, CellD, CellR: CellID): Integer;
	begin
		CellResult := Sum4Cells(CellA, CellB, CellC, CellD);
		CellParm := GetCellParm(CurWPtr, CellR);
		SumMktRents := Result2Cell(FormatNumber(CellResult, CellParm), CellR);
	end;

	function SumAppraiserExpenses: Integer;
	begin
		val[1] := Sum4Cells(mc(1, 45), mc(1, 46), mc(1, 47), mc(1, 49));
		val[2] := Sum4Cells(mc(1, 50), mc(1, 51), mc(1, 52), mc(1, 53));
		val[3] := Sum4Cells(mc(1, 54), mc(1, 55), mc(1, 56), mc(1, 57));
		val[4] := Sum4Cells(mc(1, 58), mc(1, 59), mc(1, 61), mc(1, 63));
		val[5] := Sum4Cells(mc(1, 65), mc(1, 67), mc(1, 69), mc(1, 71));
		val[6] := Sum4Cells(mc(1, 73), mc(1, 75), mc(1, 77), mc(0, 0));
		CellResult := val[1] + val[2] + val[3] + val[4] + val[5] + val[6];
		CellParm := GetCellParm(CurWPtr, mc(1, 78));
		SumAppraiserExpenses := Result2Cell(FormatNumber(CellResult, CellParm), mc(1, 78));
	end;

	function SumLenderExpenses: Integer;
	begin
		val[1] := Sum4Cells(mc(1, 85), mc(1, 86), mc(1, 87), mc(1, 88));
		val[2] := Sum4Cells(mc(1, 89), mc(1, 90), mc(1, 91), mc(1, 92));
		val[3] := Sum4Cells(mc(1, 93), mc(1, 94), mc(1, 95), mc(1, 96));
		val[4] := Sum4Cells(mc(1, 97), mc(1, 98), mc(1, 99), mc(1, 100));
		val[5] := Sum4Cells(mc(1, 101), mc(1, 102), mc(1, 103), mc(1, 104));
		val[6] := Sum4Cells(mc(1, 105), mc(1, 106), mc(1, 107), mc(0, 0));
		CellResult := val[1] + val[2] + val[3] + val[4] + val[5] + val[6];
		CellParm := GetCellParm(CurWPtr, mc(1, 108));
		SumLenderExpenses := Result2Cell(FormatNumber(CellResult, CellParm), mc(1, 108));
	end;

	function SumApprReplaceReserves: Integer;
	begin
		val[1] := Sum4Cells(mc(2, 4), mc(2, 9), mc(2, 14), mc(2, 19));
		val[2] := Sum4Cells(mc(2, 24), mc(2, 29), mc(2, 34), mc(2, 39));
		val[3] := Sum4Cells(mc(2, 43), mc(2, 48), mc(2, 53), mc(0, 0));
		CellResult := val[1] + val[2] + val[3];
		CellParm := GetCellParm(CurWPtr, mc(2, 55));
		SumApprReplaceReserves := Result2Cell(FormatNumber(CellResult, CellParm), mc(2, 55));
	end;

	function SumLendrReplaceReserves: Integer;
	begin
		val[1] := Sum4Cells(mc(2, 5), mc(2, 10), mc(2, 15), mc(2, 20));
		val[2] := Sum4Cells(mc(2, 25), mc(2, 30), mc(2, 35), mc(2, 40));
		val[3] := Sum4Cells(mc(2, 44), mc(2, 49), mc(2, 54), mc(0, 0));
		CellResult := val[1] + val[2] + val[3];
		CellParm := GetCellParm(CurWPtr, mc(2, 56));
		SumLendrReplaceReserves := Result2Cell(FormatNumber(CellResult, CellParm), mc(2, 56));
	end;

	function CostLifeUnits (CostCell, LifeCell, UnitCell, RCell: CellID): Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, CostCell);
		val[2] := GetCellValue(CurWPtr, LifeCell);
		val[3] := GetCellValue(CurWPtr, UnitCell);
		CellResult := 0;
		if val[2] <> 0 then
			CellResult := val[1] * val[3] / val[2];
		CellParm := GetCellParm(CurWPtr, RCell);
		CostLifeUnits := Result2Cell(FormatNumber(CellResult, CellParm), RCell);
	end;

	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
{Page 1 math}
					1: 
						Cmd := SumCurRents(MC(1, 8), MC(1, 13), MC(1, 18), MC(1, 23), MC(1, 25));
					2: 
						Cmd := SumMktRents(MC(1, 9), MC(1, 14), MC(1, 19), MC(1, 24), MC(1, 26));
					3: 
						Cmd := SumAB(MC(1, 39), MC(1, 40), mc(1, 41));
					4: 
						Cmd := SumAB(MC(1, 79), MC(1, 80), mc(1, 81));
					5: 
						begin
							Cmd := PercentAOfB(MC(1, 42), MC(1, 41), mc(1, 43));	{vacancy percentage of Total}
							Cmd := SubtAB(MC(1, 41), MC(1, 42), mc(1, 44));		{less vacancy}
						end;
					6: 
						begin
							Cmd := PercentAOfB(MC(1, 82), MC(1, 81), mc(1, 83));	{vacancy percentage of Total}
							Cmd := SubtAB(MC(1, 81), MC(1, 82), mc(1, 84));		{less vacancy}
						end;
					7: 
						Cmd := SumAppraiserExpenses;
					8: 
						Cmd := SumLenderExpenses;
					9: 
						Cmd := TransA2B(mc(1, 44), mc(2, 57));		{trans Eff Gross Income}
					10: 
						Cmd := TransA2B(mc(1, 78), mc(2, 58));		{trans Operating Expense}
					11: 
						Cmd := TransA2B(mc(2, 55), mc(1, 59));		{trans Replacement Reserves  2 expenses}
					12: 
						Cmd := TransA2B(mc(2, 56), mc(1, 98));		{trans Replacement Reserves  2 expenses}
					13: 
						Cmd := SubtAB(mc(2, 57), mc(2, 58), mc(2, 59));		{Gross Inc - Operat Expenses}
					14: 
						Cmd := DivideAByVal(mc(2, 59), mc(2, 60), 12.0);		{divide oper income by 12}
					15: 
						Cmd := TransA2B(mc(2, 60), mc(2, 61));		{trans monthly inc 2 next line}
					16: 
						Cmd := SubtAB(mc(2, 61), mc(2, 62), mc(2, 63));		{mo income - Housing exp = net cash}
					17: 
						Cmd := SumApprReplaceReserves;
					18: 
						Cmd := SumLendrReplaceReserves;
					19: 
						Cmd := CostLifeUnits(mc(2, 1), mc(2, 2), mc(2, 3), mc(2, 4));
					20: 
						Cmd := CostLifeUnits(mc(2, 6), mc(2, 7), mc(2, 8), mc(2, 9));
					21: 
						Cmd := CostLifeUnits(mc(2, 11), mc(2, 12), mc(2, 13), mc(2, 14));
					22: 
						Cmd := CostLifeUnits(mc(2, 16), mc(2, 17), mc(2, 18), mc(2, 19));
					23: 
						Cmd := CostLifeUnits(mc(2, 21), mc(2, 22), mc(2, 23), mc(2, 24));
					24: 
						Cmd := CostLifeUnits(mc(2, 26), mc(2, 27), mc(2, 28), mc(2, 29));
					25: 
						Cmd := CostLifeUnits(mc(2, 31), mc(2, 32), mc(2, 33), mc(2, 34));
					26: 
						Cmd := CostLifeUnits(mc(2, 36), mc(2, 37), mc(2, 38), mc(2, 39));
					27: 
						Cmd := CostLifeUnits(mc(2, 46), mc(2, 47), mc(2, 45), mc(2, 48));
					28: 
						Cmd := CostLifeUnits(mc(2, 51), mc(2, 52), mc(2, 50), mc(2, 53));
					29: 
						cmd := DivideAB(mc(2, 41), mc(2, 42), mc(2, 43));
					30: 
						begin
							Cmd := MultPercent(mc(1, 41), mc(1, 43), mc(1, 42));		{ignore cmd}
							Cmd := SubtAB(MC(1, 41), MC(1, 42), mc(1, 44));			{less vacancy}
						end;
					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

*) 
//F0029 Comparabe Rent

{*** Specific math functions ***}

function F0029AdjMonthlyRent(doc: TContainer; cx: CellUID; CellI, CellA, CellB, CellR: Integer): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, CellI));
  V2 := GetCellValue(doc, mcx(cx, CellA));
  V3 := GetCellValue(doc, mcx(cx, CellB));
  VR := V1 -V2 - V3;
  if VR <> 0 then
    result := SetCellValue(doc, mcx(cx,CellR), VR)
  else if (VR = 0) and (GetCellString(doc, mcx(cx,CellI))<> '') then  //Only show values if not 0
    result := SetCellValue(doc, mcx(cx,CellR), VR)
  else if VR = 0 then //else show empty string
   result := SetCellString(doc, mcx(cx,CellR), '');
end;

function F0029C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 38;
  TotalAdj  = 74;
  FinalAmt  = 75;
  PlusChk   = 72;
  NegChk    = 73;
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
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);

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

function F0029C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 85;
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
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
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

function F0029C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 132;
  TotalAdj  = 168;
  FinalAmt  = 169;
  PlusChk   = 166;
  NegChk    = 167;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);

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

////////////////////////////////////////////////////////////////////////////////
//
// Comparables Rent XComps           UID 122
//
////////////////////////////////////////////////////////////////////////////////
function F0122AdjMonthlyRent(doc: TContainer; cx: CellUID; CellI, CellA, CellB, CellR: Integer): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, CellI));
  V2 := GetCellValue(doc, mcx(cx, CellA));
  V3 := GetCellValue(doc, mcx(cx, CellB));
  VR := V1 -V2 - V3;
  if VR <> 0 then
    result := SetCellValue(doc, mcx(cx,CellR), VR)
  else if (VR = 0) and (GetCellString(doc, mcx(cx,CellI))<> '') then  //Only show values if not 0
    result := SetCellValue(doc, mcx(cx,CellR), VR)
  else if VR = 0 then //else show empty string
   result := SetCellString(doc, mcx(cx,CellR), '');
end;

function F0122C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 48;
  TotalAdj  = 84;
  FinalAmt  = 85;
  PlusChk   = 82;
  NegChk    = 83;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);

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

function F0122C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 96;
  TotalAdj  = 132;
  FinalAmt  = 133;
  PlusChk   = 130;
  NegChk    = 131;
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
  GetNetGrosAdjs(doc, mcx(cx,104),  NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);

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

function F0122C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 144;
  TotalAdj  = 180;
  FinalAmt  = 181;
  PlusChk   = 178;
  NegChk    = 179;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152),  NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);

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


{*****************************}
{  CoOp Appraisal FNMA 1075   }
{*****************************}

(*
Coop math from MAC
	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;

	function InfoSumLandUse: Integer;
	begin
		Val[1] := Sum4Cells(MC(1, 69), MC(1, 70), MC(1, 71), MC(1, 72));
		Val[2] := Sum4Cells(MC(1, 73), MC(1, 74), MC(1, 75), MC(1, 76));
		CellResult := Val[1] + Val[2];
		Result2InfoCell(1, 2, Num2Longint(CellResult));
		InfoSumLandUse := 0;
	end;

	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(3, 105));
		Val[2] := GetCellValue(CurWPtr, MC(3, 174));
		Val[3] := GetCellValue(CurWPtr, MC(3, 243));

		Val[4] := GetCellValue(CurWPtr, MC(4, 113));
		Val[5] := GetCellValue(CurWPtr, MC(4, 182));
		Val[6] := GetCellValue(CurWPtr, MC(4, 251));

		N := 0;
		for i := 1 to 6 do
			if val[i] <> 0 then
				N := N + 1;
		if N = 0 then
			CellResult := 0
		else
			CellResult := (Val[1] + val[2] + val[3] + Val[4] + val[5] + val[6]) / N;

		Result2InfoCell(3, 9, Num2Longint(CellResult));
		Result2InfoCell(4, 9, Num2Longint(CellResult));

		InfoSalesAverage := 0;
	end;

	function GarageEntry: Integer;
	begin
		GarageEntry := 0;
	end;

	function HeatingEntry: Integer;
	begin
		HeatingEntry := 0;
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
{page 1}
					1: 
						Cmd := TransA2B(MC(1, 3), MC(3, 2));		{address}
					2: 
						Cmd := TransA2B(mc(1, 4), mc(3, 3));		{City}
					3: 
						Cmd := TransA2B(mc(1, 10), mc(3, 4));		{Project}
					4: 
						Cmd := TransA2B(mc(1, 20), mc(3, 5));		{Sales Price}
					5: 
						Cmd := InfoSumLandUse;
					6: 
						Cmd := DivideAB(mc(1, 138), mc(1, 129), mc(1, 139));	{parking ratio}
					7: 
						Cmd := TransA2B(mc(1, 120), mc(3, 10));	{view}
					8: 
						Cmd := GarageEntry;
					9: 
						Cmd := HeatingEntry;

{page 2}
					10: 
						Cmd := MultAByVal(mc(2, 4), mc(2, 5), 12.0);		{monthly Maintenance Fee (Unit charge)}

{page 3}
					11: 
						cmd := InfoSalesAverage;

					16: 
						Cmd := DivideAB(mc(3, 5), mc(3, 25), mc(3, 6));			{subPrice/Area}
					17: 
						Cmd := DivideAB(mc(3, 41), mc(3, 82), mc(3, 42));		{C1Price/Area}
					18: 
						Cmd := DivideAB(mc(3, 110), mc(3, 151), mc(3, 111));	{C2Price/Area}
					19: 
						Cmd := DivideAB(mc(3, 179), mc(3, 220), mc(3, 180));	{C3Price/Area}
					20: 
						Cmd := DivideAB(mc(4, 49), mc(4, 90), mc(4, 50));		{C4Price/Area}
					21: 
						Cmd := DivideAB(mc(4, 118), mc(4, 159), mc(4, 119));	{C5Price/Area}
					22: 
						Cmd := DivideAB(mc(4, 187), mc(4, 228), mc(4, 188));	{C6Price/Area}

					23: 
						Cmd := SumAB(mc(3, 41), mc(3, 104), mc(3, 105));			{C1 Adj Price}
					24: 
						Cmd := SumAB(mc(3, 110), mc(3, 173), mc(3, 174));			{C2 Adj Price}
					25: 
						Cmd := SumAB(mc(3, 179), mc(3, 242), mc(3, 243));			{C3 Adj Price}
					26: 
						Cmd := SumAB(mc(4, 49), mc(4, 112), mc(4, 113));				{C4 Adj Price}
					27: 
						Cmd := SumAB(mc(4, 118), mc(4, 181), mc(4, 182));			{C5 Adj Price}
					28: 
						Cmd := SumAB(mc(4, 187), mc(4, 250), mc(4, 251));			{C6 Adj Price}

					29: 
						Cmd := SetCheckMark(mc(3, 104), mc(3, 102), mc(3, 103));	{C1 adj chk boxes}
					30: 
						Cmd := SetCheckMark(mc(3, 173), mc(3, 171), mc(3, 172));	{C2 adj chk boxes}
					31: 
						Cmd := SetCheckMark(mc(3, 242), mc(3, 240), mc(3, 241));	{C3 adj chk boxes}
					32: 
						Cmd := SetCheckMark(mc(4, 112), mc(4, 110), mc(4, 111));		{C4 adj chk boxes}
					33: 
						Cmd := SetCheckMark(mc(4, 181), mc(4, 179), mc(4, 180));	{C5 adj chk boxes}
					34: 
						Cmd := SetCheckMark(mc(4, 250), mc(4, 248), mc(4, 249));	{C6 adj chk boxes}

					35: 
						Cmd := InfoAdjPercentage(mc(3, 41), 1, 2, 3);				{C1 Net Gross Adjs}
					36: 
						Cmd := InfoAdjPercentage(mc(3, 110), 2, 4, 5);				{C2 Net Gross Adjs}
					37: 
						Cmd := InfoAdjPercentage(mc(3, 179), 3, 6, 7);			{C3 Net Gross Adjs}
					38: 
						Cmd := InfoAdjPercentage(mc(4, 49), 4, 2, 3);				{C4 Net Gross Adjs}
					39: 
						Cmd := InfoAdjPercentage(mc(4, 118), 5, 4, 5);				{C5 Net Gross Adjs}
					40: 
						Cmd := InfoAdjPercentage(mc(4, 187), 6, 6, 7);				{C6 Net Gross Adjs}


					41: 
						Cmd := SumAdjustmentsC1;
					42: 
						Cmd := SumAdjustmentsC2;
					43: 
						Cmd := SumAdjustmentsC3;
					44: 
						Cmd := SumAdjustmentsC4;
					45: 
						Cmd := SumAdjustmentsC5;
					46: 
						Cmd := SumAdjustmentsC6;


					47: 				{sub sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 16);					{sub price/area}
							ProcessCurCellInfo(CurWPtr, 69);					{C1 sqft adj}
							ProcessCurCellInfo(CurWPtr, 70);					{C2 sqft adj}
							ProcessCurCellInfo(CurWPtr, 71);					{C3 sqft adj}
							ProcessCurCellInfo(CurWPtr, 72);					{C4 sqft adj}
							ProcessCurCellInfo(CurWPtr, 73);					{C5 sqft adj}
							ProcessCurCellInfo(CurWPtr, 74);					{C6 sqft adj}
							cmd := 0;
						end;

					48: 				{C1 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 69);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 17);			{price/sqft}
							cmd := 0;
						end;

					49: 				{C2 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 70);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 18);			{price/sqft}
							cmd := 0;
						end;

					50: 				{C3 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 71);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 19);			{price/sqft}
							cmd := 0;
						end;

					51: 				{C4 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 72);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 20);			{price/sqft}
							cmd := 0;
						end;

					52: 				{C5 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 73);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 21);			{price/sqft}
							cmd := 0;
						end;

					53: 				{C6 sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 74);			{sqft adj}
							ProcessCurCellInfo(CurWPtr, 22);			{price/sqft}
							cmd := 0;
						end;

					57: 				{Net Adj C1}
						begin
							ProcessCurCellInfo(CurWPtr, 23);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 35);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 29);			{Chk Box}
							cmd := 0;
						end;
					58: 				{Net Adj C2}
						begin
							ProcessCurCellInfo(CurWPtr, 24);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 36);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 30);			{Chk Box}
							cmd := 0;
						end;
					59: 				{Net Adj C3}
						begin
							ProcessCurCellInfo(CurWPtr, 25);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 37);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 31);			{Chk Box}
							cmd := 0;
						end;
					60: 				{Net Adj C4}
						begin
							ProcessCurCellInfo(CurWPtr, 26);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 38);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 32);			{Chk Box}
							cmd := 0;
						end;
					61: 				{Net Adj C5}
						begin
							ProcessCurCellInfo(CurWPtr, 27);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 39);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 33);			{Chk Box}
							cmd := 0;
						end;
					62: 				{Net Adj C6}
						begin
							ProcessCurCellInfo(CurWPtr, 28);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 40);			{Gross Net %}
							ProcessCurCellInfo(CurWPtr, 34);			{Chk Box}
							cmd := 0;
						end;

					63: 				{Sale Price C1}
						begin
							ProcessCurCellInfo(CurWPtr, 23);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 17);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 35);			{Gross net adj}
							cmd := 0;
						end;
					64: 				{Sale Price C2}
						begin
							ProcessCurCellInfo(CurWPtr, 24);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 18);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 36);			{Gross net adj}
							cmd := 0;
						end;
					65: 				{Sale Price C3}
						begin
							ProcessCurCellInfo(CurWPtr, 25);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 19);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 37);			{Gross net adj}
							cmd := 0;
						end;
					66: 				{Sale Price C4}
						begin
							ProcessCurCellInfo(CurWPtr, 26);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 20);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 38);			{Gross net adj}
							cmd := 0;
						end;
					67: 				{Sale Price C5}
						begin
							ProcessCurCellInfo(CurWPtr, 27);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 21);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 39);			{Gross net adj}
							cmd := 0;
						end;
					68: 				{Sale Price C6}
						begin
							ProcessCurCellInfo(CurWPtr, 28);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 22);			{price/sqft}
							ProcessCurCellInfo(CurWPtr, 40);			{Gross net adj}
							cmd := 0;
						end;

					69: 
						cmd := SqFtAdjust(mc(3, 25), mc(3, 82), mc(3, 83));			{C1 sqft Adj}
					70: 
						cmd := SqFtAdjust(mc(3, 25), mc(3, 151), mc(3, 152));		{C2 sqft Adj}
					71: 
						cmd := SqFtAdjust(mc(3, 25), mc(3, 220), mc(3, 221));		{C3 sqft Adj}
					72: 
						cmd := SqFtAdjust(mc(3, 25), mc(4, 90), mc(4, 91));			{C4 sqft Adj}
					73: 
						cmd := SqFtAdjust(mc(3, 25), mc(4, 159), mc(4, 160));		{C5 sqft Adj}
					74: 
						cmd := SqFtAdjust(mc(3, 25), mc(4, 228), mc(4, 229));		{C6 sqft Adj}


					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

*)

function F0034InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get4CellSumR(doc, CX, 71,72,73,74);
  V2 := Get4CellSumR(doc, CX, 75,76,77,78);
  VR := V1 + V2;
  result := SetInfoCellValue(doc, mcx(cx,2), VR);
end;


//---------------------------
// Small Income 94 - 4 pages
//---------------------------
function F0018MultProcessCmds(doc: TContainer; CX: CellUID; Cmd1,Cmd2,Cmd3,Cmd4,Cmd5,Cmd6: Integer): Integer;
begin
  if Cmd1 > 0 then
    ProcessForm0018Math(doc, Cmd1, CX);
  if Cmd2 > 0 then
    ProcessForm0018Math(doc, Cmd2, CX);
  if Cmd3 > 0 then
    ProcessForm0018Math(doc, Cmd3, CX);
  if Cmd4 > 0 then
    ProcessForm0018Math(doc, Cmd4, CX);
  if Cmd5 > 0 then
    ProcessForm0018Math(doc, Cmd5, CX);
  if Cmd6 > 0 then
    ProcessForm0018Math(doc, Cmd6, CX);

  result := 0;
end;

//transfers baths count to grid
function F0018TransBathCount(doc: TContainer; CX: CellUID; CUnit, CBath, PgR,CxR: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Max(1, GetCellValue(doc, mcx(cx,CUnit)));      //empty unit = 1
  V2 := GetCellValue(doc, mcx(cx,CBath));
  VR := V1 * V2;
  result := 0;
  if VR > 0 then
    result := SetCellValue(doc, MCPX(cx, PgR,CxR), VR);
end;

//transfer bedrooms to grid
function F0018TransBedRmCount(doc: TContainer; CX: CellUID; CUnit, CBRm, PgR,CxR: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Max(1, GetCellValue(doc, mcx(cx,CUnit)));      //empty unit = 1
  V2 := GetCellValue(doc, mcx(cx,CBRm));
  VR := V1 * V2;
  result := 0;
  if VR > 0 then
    result := SetCellValue(doc, MCPX(cx, PgR,CxR), VR);
end;

//transfer total room count
function F0018TransUnitRmCount(doc: TContainer; CX: CellUID; CUnit, R1,R2,R3,R4,R5,R6, PgR,CxR: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Max(1, GetCellValue(doc, mcx(cx,CUnit)));     //empty unit = 1
  V2 := Get8CellSumR(doc, cx, R1,R2,R3,R4,R5,R6,0,0);
  VR := V1 * V2;
  result := 0;
  if VR > 0 then
    result := SetCellValue(doc, MCPX(cx, PgR,CxR), VR);
end;

function F0018FeeSimpleLeaseHold(doc: TContainer; CX: CellUID): Integer;
var
  tStr: String;
begin
  if CellIsChecked(doc, mcx(cx, 24)) then
    tStr := 'Fee Simple'
  else if CellIsChecked(doc, mcx(cx,25)) then
    tStr := 'Leasehold';
  result := SetCellString(doc, MCFX(CX.form, 4, 16), tStr);
end;

function F0018InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get4CellSumR(doc, CX, 95,96,97,98);
  V1 := V1 + GetCellValue(doc, MCX(CX,100));
  result := SetInfoCellValue(doc, mcx(cx,2), V1);
end; function F0018Location(doc: TContainer; CX: CellUID): Integer;
var
  LocStr: String;
begin
  LocStr := '';
  result := 0;
  if CellIsChecked(doc, mcx(cx, 36)) then
    LocStr := 'Urban'

  else if CellIsChecked(doc, mcx(cx, 37)) then
    LocStr := 'Suburban'

  else if CellIsChecked(doc, mcx(cx, 38)) then
    LocStr := 'Rural';

  if Length(LocStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,4,15), LocStr);
end; //calc age and transfer to sales grid
function F0018YearBuilt(doc: TContainer; CX: CellUID): Integer;
begin
  result := 0;
end;

function F0018NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, cx) then
    begin
      SetCellChkMark(doc, mcx(cx,138), False);     {clear the checkmarks}
      SetCellChkMark(doc, mcx(cx,139), False);
      SetCellChkMark(doc, mcx(cx,140), False);
      SetCellChkMark(doc, mcx(cx,141), False);
      SetCellChkMark(doc, mcx(cx,142), False);
      SetCellChkMark(doc, mcx(cx,143), False);
      SetCellChkMark(doc, mcx(cx,144), False);
    end;
  result := 0;
end;

function F0018NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, cx) then
    begin
      SetCellChkMark(doc, mcx(cx,147), False);     {clear the checkmarks}
      SetCellChkMark(doc, mcx(cx,148), False);
      SetCellChkMark(doc, mcx(cx,149), False);
      SetCellChkMark(doc, mcx(cx,150), False);
      SetCellChkMark(doc, mcx(cx,151), False);
      SetCellChkMark(doc, mcx(cx,152), False);
      SetCellChkMark(doc, mcx(cx,153), False);
    end;
  result := 0;
end;

function F0018HeatNCooling(doc: TContainer; CX: CellUID): Integer;
var
  heatStr, coolStr: string;
begin
  heatStr := GetCellString(doc, mcx(cx, 118));			{Heat type}
  if Length(heatStr) = 0 then
    heatStr := 'None';

  coolStr := GetCellString(doc, mcx(cx, 123));			{cool type}
  if EquivStr(coolStr, 'None', 'No', 'xx') then				{if none get other}
    begin
      coolStr := GetCellString(doc, mcx(cx, 124));
      if EquivStr(coolStr, 'None', 'No', 'xx') then
        coolStr := 'None';
    end;

  coolStr := Concat(heatStr, '/', coolStr);

  result := SetCellString(doc, MCFX(CX.form,4,46), coolStr); //transfer to grid
end;

function F0018TotalEstnewCost(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get4CellSumR(doc, CX, 162,165,168,171);
  VR := VR+ Get4CellSumR(doc, CX,174,176,178,180);
  VR := VR+ Get4CellSumR(doc, CX,182,184,186,188);
  result := SetCellValue(doc, mcx(cx,189), VR);
end;

function F0018Depreciation(doc: TContainer; CX: CellUID): Integer;
begin
  result := 27;
end;

//calc Funct depr
function F0018CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,192));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,189));    //new cost
  V3 := GetCellValue(doc, mcx(cx,191));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,193), VR);
    end;
end;

//calc external depr
function F0018CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,194));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,189));    //new cost
  V3 := GetCellValue(doc, mcx(cx,191));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,193));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,195), VR);
    end;
end;

//Function depr percent
function F0018CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,193));    //funct depr
  V2 := GetCellValue(doc, mcx(cx,189));    //new cost
  V3 := GetCellValue(doc, mcx(cx,191));    //Phy Depr
  if (V2-V3) > 0 then
    begin
      VR := V1/(V2-V3)*100;
      SetCellValue(doc, mcx(cx,192), VR);
    end;
  result := 0;
end;

//calc external depr percent
function F0018CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,195));    //extrn depr
  V2 := GetCellValue(doc, mcx(cx,189));    //new cost
  V3 := GetCellValue(doc, mcx(cx,191));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,193));    //Funct Depr
  if V3 < 0 then V3 := 0;
  if V4 < 0 then V4 := 0;
  if (V2-V3-V4)>0 then
    begin
      VR := (V1/(V2-V3-V4))*100;
      result := SetCellValue(doc, mcx(cx,194), VR);
    end;
end;

function F0018AnnualVacancy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,242));
  V2 := GetCellValue(doc, mcx(cx,247));
  VR := V1 * V2 * 0.12;   {.01 * 12 months}
  result := SetCellValue(doc, mcx(cx,248), VR);
end;

function F0018SumRents(doc: TContainer; cx: CellUID; CellU, CellA, CellB, CellR: Integer): Integer;
var
  V1,V2,V3,VR: Double;
begin
  //V1 := GetCellValue(doc, mcx(cx, CellU));    //remove Units from calculation
  V1 := 1.0;
  V2 := GetCellValue(doc, mcx(cx, CellA));
  V3 := GetCellValue(doc, mcx(cx, CellB));
  VR := V1 * (V2 + V3);
  result := SetCellValue(doc, mcx(cx,CellR), VR);
end;

function F0018C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 57;
  TotalAdj  = 131;
  FinalAmt  = 132;
  PlusChk   = 129;
  NegChk    = 130;
  InfoNet   = 2;
  InfoGross = 3;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);

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

function F0018C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 138;
  TotalAdj  = 212;
  FinalAmt  = 213;
  PlusChk   = 210;
  NegChk    = 211;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,197), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,199), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,203), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);

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

function F0018C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 219;
  TotalAdj  = 293;
  FinalAmt  = 294;
  PlusChk   = 291;
  NegChk    = 292;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,244), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,246), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,248), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,250), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,251), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,252), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,258), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,264), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,270), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,276), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,278), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,280), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,282), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,284), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,286), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,288), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,290), NetAdj, GrsAdj);

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

function F0018SalePerUnit(doc: TContainer; CX: CellUID; CS, U1,U2,U3,U4, CR: Integer): Integer;
var
  SV,UV,VR: Double;
begin
  result := 0;
  SV := GetCellValue(doc, mcx(cx,CS));
  UV := Get4CellSumR(doc, CX, U1,U2,U3,U4);
  if (SV <> 0) and (UV <> 0) then
    begin
      VR := SV / UV;
      result := SetCellValue(doc, mcx(cx,CR), VR);
    end;
end;

function F0018SalePerRoom(doc: TContainer; CX: CellUID; CS, U1,U2,U3,U4, CR: Integer): Integer;
var
  SV,UV,VR: Double;
begin
  result := 0;
  SV := GetCellValue(doc, mcx(cx,CS));
  UV := Get4CellSumR(doc, CX, U1,U2,U3,U4);
  if (SV <> 0) and (UV <> 0) then
    begin
      VR := SV / UV;
      result := SetCellValue(doc, mcx(cx,CR), VR);
    end;
end;

function F0018SumTotalRooms(doc: TContainer; CX: CellUID): Integer;
var
  U1,U2,U3,U4: Double;
  V1,V2,V3,V4,VR: Double;
begin
  U1 := GetCellValue(doc, mcx(cx,46));
  if U1=0 then U1 := 1;
  U2 := GetCellValue(doc, mcx(cx,60));
  if U2=0 then U2 := 1;
  U3 := GetCellValue(doc, mcx(cx,74));
  if U3=0 then U3 := 1;
  U4 := GetCellValue(doc, mcx(cx,88));
  if U4=0 then U4 := 1;
  V1 := U1 * Get8CellSumR(doc, CX, 49,50,51,52,53,54,0,0);   //level 1
  V2 := U2 * Get8CellSumR(doc, CX, 63,64,65,66,67,68,0,0);   //level 2
  V3 := U3 * Get8CellSumR(doc, CX, 77,78,79,80,81,82,0,0);   //level 3
  V4 := U4 * Get8CellSumR(doc, CX, 91,92,93,94,95,96,0,0);   //level 4
  VR := V1+V2+V3+V4;

  result := SetCellValue(doc, MCX(cx, 102), VR);
end;

function F0018SumBedBathRooms(doc: TContainer; CX: CellUID; C1,C2,C3,C4, CR: Integer): Integer;
var
  U1,U2,U3,U4: Double;
  V1,V2,V3,V4,VR: Double;
begin
  U1 := GetCellValue(doc, mcx(cx,46));
  if U1=0 then U1 := 1;
  U2 := GetCellValue(doc, mcx(cx,60));
  if U2=0 then U2 := 1;
  U3 := GetCellValue(doc, mcx(cx,74));
  if U3=0 then U3 := 1;
  U4 := GetCellValue(doc, mcx(cx,88));
  if U4=0 then U4 := 1;
  V1 := U1 * GetCellValue(doc, mcx(cx,C1));
  V2 := U2 * GetCellValue(doc, mcx(cx,C2));
  V3 := U3 * GetCellValue(doc, mcx(cx,C3));
  V4 := U4 * GetCellValue(doc, mcx(cx,C4));
  VR := V1+V2+V3+V4;
  result := SetCellValue(doc, MCX(cx, cr), VR);
end;



//--------------------------------------
//Small Income Extra Comps 456-XXX
//--------------------------------------

function F0021Process4Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0021Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0021Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0021Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0021Math(doc, C4, CX);
  result := 0;
end;

function F0021C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 67;
  TotalAdj  = 141;
  FinalAmt  = 142;
  PlusChk   = 139;
  NegChk    = 140;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,80), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,82), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,84), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,86), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,88), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);

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

function F0021C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 149;
  TotalAdj  = 223;
  FinalAmt  = 224;
  PlusChk   = 221;
  NegChk    = 222;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,206), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,208), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);

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

function F0021C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 231;
  TotalAdj  = 305;
  FinalAmt  = 306;
  PlusChk   = 303;
  NegChk    = 304;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,244), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,246), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,248), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,250), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,252), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,254), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,256), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,258), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,260), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,262), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,263), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,264), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,270), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,276), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,282), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,288), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,290), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,292), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,294), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,296), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,298), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,300), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,302), NetAdj, GrsAdj);

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

//Operating Income Statement

function F0032MultAByValCurrent(doc: TContainer; CellA, CellR: CellUID; MultVal: Double): Integer;
var
 V1: Double;
begin
result := 0;
  if not appPref_AppraiserUseMarketRentInOIS then
    begin
      V1 := GetCellValue(doc, CellA);
   	  V1 := V1 * MultVal;
   	  result := SetCellValue(doc, CellR, V1);
   end;
end;

function F0032MultAByValMarket(doc: TContainer; CellA, CellR: CellUID; MultVal: Double): Integer;
var
 V1: Double;
begin
  result := 0;
  if appPref_AppraiserUseMarketRentInOIS then
    begin
   	  V1 := GetCellValue(doc, CellA);
   	  V1 := V1 * MultVal;
   	  result := SetCellValue(doc, CellR, V1);
    end;
end;

function F0032SumAppraiserExps(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR:Double;
begin
  V1 := Get8CellSumR(doc,cx, 49,50,51,53,54,55,56,57);
  V2 := Get8CellSumR(doc,cx, 58,59,60,61,62,63,65,67);
  V3 := Get8CellSumR(doc,cx, 69,71,73,75,77,79,81,0);
  VR := V1+V2+V3;
  result := SetCellValue(doc, mcx(cx,82), VR);
end;

function F0032SumLenderExps(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR:Double;
begin
  V1 := Get8CellSumR(doc,cx, 89,90,91,92,93,94,95,96);
  V2 := Get8CellSumR(doc,cx, 97,98,99,100,101,102,103,104);
  V3 := Get8CellSumR(doc,cx, 105,106,107,108,109,110,111,0);
  VR := V1+V2+V3;
  result := SetCellValue(doc, mcx(cx,112), VR);
end;

function F0032SumReplaceResAppr(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR:Double;
begin
  V1 := Get8CellSumR(doc,cx,8,13,18,23,28,33,38,43);
  V2 := Get4CellSumR(doc,cx,47,52,57,0);
  VR := V1+V2;
  result := SetCellValue(doc, mcx(cx,59), VR);
end;

function F0032SumReplaceResLender(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR:Double;
begin
  V1 := Get8CellSumR(doc,cx,9,14,19,24,29,34,39,44);
  V2 := Get4CellSumR(doc,cx,48,53,58,0);
  VR := V1+V2;
  result := SetCellValue(doc, mcx(cx,60), VR);
end;

//FNMA 1075 CoOp Report
function F0034C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 43;
  TotalAdj  = 106;
  FinalAmt  = 107;
  PlusChk   = 104;
  NegChk    = 105;
  InfoNet   = 2;
  InfoGross = 3;
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
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
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

function F0034C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 112;
  TotalAdj  = 175;
  FinalAmt  = 176;
  PlusChk   = 173;
  NegChk    = 174;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0034C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 181;
  TotalAdj  = 244;
  FinalAmt  = 245;
  PlusChk   = 242;
  NegChk    = 243;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
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

//FNMA 1075 XComps CoOp Report
function F0035C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 54;
  TotalAdj  = 117;
  FinalAmt  = 118;
  PlusChk   = 115;
  NegChk    = 116;
  InfoNet   = 2;
  InfoGross = 3;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);

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

function F0035C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 124;
  TotalAdj  = 187;
  FinalAmt  = 188;
  PlusChk   = 185;
  NegChk    = 186;
  InfoNet   = 8;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);

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

function F0035C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 194;
  TotalAdj  = 257;
  FinalAmt  = 258;
  PlusChk   = 255;
  NegChk    = 256;
  InfoNet   = 9;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,199), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,203), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,244), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,246), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,248), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,250), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,252), NetAdj, GrsAdj);
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



//Small Income 94
function ProcessForm0018Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0018FeeSimpleLeaseHold(doc, cx);
        2:
          cmd := F0018InfoSumLandUse(doc, cx);
        3:
          cmd := F0018Location(doc, cx);
        4:
          cmd := SiteDimension(doc, mcx(cx, 162), mcx(cx,163));
        5:
          cmd := F0018YearBuilt(doc, cx);
        6:
          cmd := F0018NoAttic(doc, cx);
        7:
          cmd := F0018NoCarStorage(doc, cx);
        8:
          cmd := F0018HeatNCooling(doc, cx);
        9:
          cmd := F0018SumBedBathRooms(doc, cx, 55,69,83,97, 104);    //sum the bathrooms
        10:
          cmd := F0018SumBedBathRooms(doc, cx, 54,68,82,96, 103);  //sum the bedrooms
        11:
          cmd := SumFourCellsR(doc, cx, 59,73,87,101, 105);    //sum the sqft GLA
        12:
          cmd := F0018SumTotalRooms(doc, cx);                 //sum total rooms

        13:  //process unit 1
          begin
            F0018MultProcessCmds(doc,cx, 9,10,12,91,95,99);
           // ProcessForm0018Math(doc, 9, CX);
           // ProcessForm0018Math(doc, 10, CX);
            cmd := MultAB(doc, mcx(cx,46), mcx(cx,58), mcx(cx,59));   //unit1 * sqft
          end;
        14:  //process unit 2
          begin
            F0018MultProcessCmds(doc,cx, 9,10,12,92,96,100);
         //   ProcessForm0018Math(doc, 9, CX);
         //   ProcessForm0018Math(doc, 10, CX);
            cmd := MultAB(doc, mcx(cx,60), mcx(cx,72), mcx(cx,73));   //unit2 * sqft
          end;
        15:  //process unit 3
          begin
            F0018MultProcessCmds(doc,cx, 9,10,12,93,97,101);
          //  ProcessForm0018Math(doc, 9, CX);
          //  ProcessForm0018Math(doc, 10, CX);
            cmd := MultAB(doc, mcx(cx,74), mcx(cx,86), mcx(cx,87));   //unit3 * sqft
          end;
        16:  //process unit 4
          begin
            F0018MultProcessCmds(doc,cx, 9,10,12,94,98,102);
          //  ProcessForm0018Math(doc, 9, CX);
          //  ProcessForm0018Math(doc, 10, CX);
            cmd := MultAB(doc, mcx(cx,88), mcx(cx,100), mcx(cx,101));  //unit4 * sqft
          end;
//new cost math
        17:
          cmd := MultAB(doc, mcx(cx,160), mcx(cx,161), mcx(cx,162));   //1sqft *$
        18:
          cmd := MultAB(doc, mcx(cx,163), mcx(cx,164), mcx(cx,165));   //2sqft *$
        19:
          cmd := MultAB(doc, mcx(cx,166), mcx(cx,167), mcx(cx,168));   //3sqft *$
        20:
          cmd := MultAB(doc, mcx(cx,169), mcx(cx,170), mcx(cx,171));   //4sqft *$
        21:
          cmd := MultAB(doc, mcx(cx,172), mcx(cx,173), mcx(cx,174));   //5sqft *$
        22:
          cmd := F0018TotalEstnewCost(doc, cx);    //sum the cost of new improvments
        23:
          cmd := SumFourCellsR(doc, cx, 159,197,198,0, 199);  //indicated value by cost appr
        24:
          cmd := 0;
        25:
          cmd := SubtAB(doc, mcx(cx,189), mcx(cx,196), mcx(cx,197));    //subt the depr form new cost
//depreciation
        26:
          cmd := F0018Depreciation(doc, cx);         //total cost new
        27:
          Cmd := MultPercentAB(doc, mcx(cx,189), mcx(cx,190),mcx(cx,191)) ; //phy dep precent entered
        28:
          Cmd := F0018CalcDeprLessPhy(doc, CX);        //funct dep precent entered
        29:
          Cmd := F0018CalcDeprLessPhyNFunct(doc, CX);  //external dep precent entered
        30:
          cmd := F0018CalcPctLessPhy(doc, cx);         //funct entered, calc percent
        31:
          cmd := F0018CalcPctLessPhyNFnct(doc, cx);    //extrn entered, calc percent
        32:
          cmd := SumFourCellsR(doc, cx, 191,193,195,0, 196);  //sum depreciation
        33:  //phy dep amount entered
          begin
            PercentAOfB(doc, mcx(cx,191), mcx(cx,189), mcx(cx,190));    //recalc phy percent
            F0018CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0018CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0018Math(doc, 32, CX); //sum the deprs
          end;
        34:  //funct dep amount entered
          begin
            F0018CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0018CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0018Math(doc, 32, CX);  //sum the deprs
          end;
        35:  //extrn dep amount entered
          begin
            F0018CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0018Math(doc, 32, CX);  //sum the deprs
          end;
//Page 3 Rental calcs
        36:
          cmd := SumFourCellsR(doc, cx, 199,209,219,229, 239);  //sum units
        37:
          cmd := SumFourCellsR(doc, cx, 202,212,222,232, 240);  //sum vacancies
        38:
          cmd := SumFourCellsR(doc, cx, 205,215,225,235, 241);  //sum act. rents
        39:
          cmd := SumFourCellsR(doc, cx, 208,218,228,238, 242);  //sum est. rents
        40:
          cmd := F0018SumRents(doc, cx, 199,203,204, 205);      //Sum 1 act rents
        41:
          cmd := F0018SumRents(doc, cx, 209,213,214, 215);      //Sum 2 act rents
        42:
          cmd := F0018SumRents(doc, cx, 219,223,224, 225);      //Sum 3 act rents
        43:
          cmd := F0018SumRents(doc, cx, 229,233,234, 235);      //Sum 4 act rents
        44:
          cmd := F0018SumRents(doc, cx, 199,206,207, 208);      //Sum 1 est rents
        45:
          cmd := F0018SumRents(doc, cx, 209,216,217, 218);      //Sum 2 est rents
        46:
          cmd := F0018SumRents(doc, cx, 219,226,227, 228);      //Sum 3 est rents
        47:
          cmd := F0018SumRents(doc, cx, 229,236,237, 238);      //Sum 4 est rents
        48:  //entered unit 1
          begin
            //remove units math from rents
            //ProcessForm0018Math(doc, 36, CX);  //sum the unit
            //ProcessForm0018Math(doc, 40, CX);}  //calc act rent
            //cmd := ProcessForm0018Math(doc, 44, CX);  //calc est rent
            cmd := 0;
          end;
        49:  //entered unit 2
          begin
            //remove units math from rents
            //ProcessForm0018Math(doc, 36, CX);  //sum the unit
            //ProcessForm0018Math(doc, 41, CX);  //calc act rent
            //cmd := ProcessForm0018Math(doc, 45, CX);  //calc est rent
            cmd := 0;
          end;
        50:  //entered unit 3
          begin
            //remove units math from rents
            //ProcessForm0018Math(doc, 36, CX);  //sum the unit
            //ProcessForm0018Math(doc, 42, CX);  //calc act rent
            //cmd := ProcessForm0018Math(doc, 46, CX);  //calc est rent
            cmd := 0;
          end;
        51:  //entered unit 4
          begin
            //remove units math from rents
            //ProcessForm0018Math(doc, 36, CX);  //sum the unit
            //ProcessForm0018Math(doc, 43, CX);  //calc act rent
            //cmd := ProcessForm0018Math(doc, 47, CX);  //calc est rent
            cmd := 0;
          end;
        52:
          cmd := SumAB(Doc, mcx(cx,242), mcx(cx,244), mcx(cx,249));   //sum total gross rent
        53:
          begin
            ProcessForm0018Math(doc, 52, CX);   //total gross rent
            cmd := F0018AnnualVacancy(doc, cx); //calc annual vacancy
          end;
        54:
          cmd := F0018AnnualVacancy(doc, cx);   //calc annual vacancy
//Page 4 math
    //Subj changed
        55:  //subj sale price
          begin
            ProcessForm0018Math(doc, 59, CX);   //sale per rent
            ProcessForm0018Math(doc, 63, CX);   //sale per units
            ProcessForm0018Math(doc, 67, CX);   //sale per rooms
            cmd := ProcessForm0018Math(doc, 71, CX);   //sale per sqft
          end;
        56:  //C1 sale price
          begin
            ProcessForm0018Math(doc, 60, CX);   //sale per rent
            ProcessForm0018Math(doc, 64, CX);   //sale per units
            ProcessForm0018Math(doc, 68, CX);   //sale per rooms
            ProcessForm0018Math(doc, 72, CX);   //sale per sqft
            cmd := ProcessForm0018Math(doc, 75, CX);   //adjustments
          end;
        57:  //C2 sale price
          begin
            ProcessForm0018Math(doc, 61, CX);   //sale per rent
            ProcessForm0018Math(doc, 65, CX);   //sale per units
            ProcessForm0018Math(doc, 69, CX);   //sale per rooms
            ProcessForm0018Math(doc, 73, CX);   //sale per sqft
            cmd := ProcessForm0018Math(doc, 76, CX);   //adjustments
          end;
        58:  //C3 sale price
          begin
            ProcessForm0018Math(doc, 62, CX);   //sale per rent
            ProcessForm0018Math(doc, 66, CX);   //sale per units
            ProcessForm0018Math(doc, 70, CX);   //sale per rooms
            ProcessForm0018Math(doc, 74, CX);   //sale per sqft
            cmd := ProcessForm0018Math(doc, 77, CX);   //adjustments
          end;
    //sale per rent (rent multiplier)
        59:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,9), mcx(cx,10));    //sub rent chged
        60:
          cmd := DivideAB(doc, mcx(cx,57), mcx(cx,59), mcx(cx,60));    //C1 rent chged
        61:
          cmd := DivideAB(doc, mcx(cx,138), mcx(cx,140), mcx(cx,141));    //C2 rent chged
        62:
          cmd := DivideAB(doc, mcx(cx,219), mcx(cx,221), mcx(cx,222));    //C3 rent chged
    //sales per unit
        63:
          cmd := F0018SalePerUnit(doc, cx, 7, 24,29,34,39, 11);  //sub units chged
        64:
          cmd := F0018SalePerUnit(doc, cx, 57, 91,97,103,109, 61);  //C1 units chged
        65:
          cmd := F0018SalePerUnit(doc, cx, 138, 172,178,184,190, 142);  //C2 units chged
        66:
          cmd := F0018SalePerUnit(doc, cx, 219, 253,259,265,271, 223);  //C3 units chged
     //sales per room
        67:
          cmd := F0018SalePerRoom(doc, cx, 7, 25,30,35,40, 12);  //sub rooms chged
        68:
          cmd := F0018SalePerRoom(doc, cx, 57, 92,98,104,110, 62);  //C1 rooms chged
        69:
          cmd := F0018SalePerRoom(doc, cx, 138, 173,179,185,191, 143);  //C2 rooms chged
        70:
          cmd := F0018SalePerRoom(doc, cx, 219, 254,260,266,272, 224);  //C3 rooms chged
     //sales per sqft
        71:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,23), mcx(cx,8));   //sub sqft chged
        72:
          cmd := DivideAB(doc, mcx(cx,57), mcx(cx,87), mcx(cx,58));    //sub sqft chged
        73:
          cmd := DivideAB(doc, mcx(cx,138), mcx(cx,168), mcx(cx,139));   //C2 sqft chged
        74:
          cmd := DivideAB(doc, mcx(cx,219), mcx(cx,249), mcx(cx,220));   //C3 sqft chged
     //Adjustments
        75:
          cmd := F0018C1Adjustments(doc, cx);
        76:
          cmd := F0018C2Adjustments(doc, cx);
        77:
          cmd := F0018C3Adjustments(doc, cx);
      //income approach
        78:
          cmd := MultAB(doc, mcx(cx,309), mcx(cx,310), mcx(cx,311));
        79:
          cmd := TransA2B(doc, CX, mcx(CX,323));    //transfer sales to final value
        80:
          Cmd := 0;   //BroadcastLenderAddress(doc, CX);
        81:
          cmd := CalcWeightedAvg(doc, [18,21]);   //calc wtAvg of main and xcomps forms
        82:
          begin
            F0018C1Adjustments(doc, cx);
            F0018C2Adjustments(doc, cx);
            F0018C3Adjustments(doc, cx);
            cmd := 0;
          end;
        //transfer baths to grid
        91: Cmd := F0018TransBathCount(doc, cx, 46,55, 3,22);
        92: Cmd := F0018TransBathCount(doc, cx, 60,69, 3,26);
        93: Cmd := F0018TransBathCount(doc, cx, 74,83, 3,30);
        94: Cmd := F0018TransBathCount(doc, cx, 88,97, 3,34);
        //transfer bedrooms to grid
        95: Cmd := F0018TransBedRmCount(doc, cx, 46,54, 3,21);
        96: Cmd := F0018TransBedRmCount(doc, cx, 60,68, 3,25);
        97: Cmd := F0018TransBedRmCount(doc, cx, 74,82, 3,29);
        98: Cmd := F0018TransBedRmCount(doc, cx, 88,96, 3,33);
        //transfer total room count
        99:  Cmd := F0018TransUnitRmCount(doc, cx, 46, 49,50,51,52,53,54, 3,20);
        100: Cmd := F0018TransUnitRmCount(doc, cx, 60, 63,64,65,66,67,68, 3,24);
        101: Cmd := F0018TransUnitRmCount(doc, cx, 74, 77,78,79,80,81,82, 3,28);
        102: Cmd := F0018TransUnitRmCount(doc, cx, 88, 91,92,93,94,95,96, 3,32);

        //process baths
        111: Cmd := F0018MultProcessCmds(doc, cx, 9,91,0,0,0,0);
        112: Cmd := F0018MultProcessCmds(doc, cx, 9,92,0,0,0,0);
        113: Cmd := F0018MultProcessCmds(doc, cx, 9,93,0,0,0,0);
        114: Cmd := F0018MultProcessCmds(doc, cx, 9,94,0,0,0,0);
        //process bedrooms
        115: Cmd := F0018MultProcessCmds(doc, cx, 10,12,95,0,0,0);
        116: Cmd := F0018MultProcessCmds(doc, cx, 10,12,96,0,0,0);
        117: Cmd := F0018MultProcessCmds(doc, cx, 10,12,97,0,0,0);
        118: Cmd := F0018MultProcessCmds(doc, cx, 10,12,98,0,0,0);

        119: Cmd := F0018MultProcessCmds(doc, cx, 12,99,0,0,0,0);
        120: Cmd := F0018MultProcessCmds(doc, cx, 12,100,0,0,0,0);
        121: Cmd := F0018MultProcessCmds(doc, cx, 12,101,0,0,0,0);
        122: Cmd := F0018MultProcessCmds(doc, cx, 12,102,0,0,0,0);

        else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0018Math(doc, 2, CX);
          CX.pg := 3;    //math is on page 4
          ProcessForm0018Math(doc, 75, CX);
          ProcessForm0018Math(doc, 76, CX);
          ProcessForm0018Math(doc, 77, CX);
        end;
      -2:
        begin
          CX.pg := 3;    //math is on page 4
          ProcessForm0018Math(doc, 82, CX);
        end;
    end;

  result := 0;
end;

// Small Income Extra Listings
function ProcessForm0019Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS ', 'ADDENDUM',25,40,55, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 25,40,55);
        3:
          cmd := ConfigXXXInstance(doc, cx, 25,40,55);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Small Income Extra Rentals
function ProcessForm0020Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS', 'ADDENDUM',57,108,159, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 57,108,159);
        3:
          cmd := ConfigXXXInstance(doc, cx, 57,108,159);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Small Income Extra Comps
function ProcessForm0021Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',61,143,225, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 61,143,225);
        3:
          cmd := ConfigXXXInstance(doc, cx, 61,143,225);

    //Subj changed
        4:  //subj sale price
          begin
            cmd := F0021Process4Cmds(doc, CX, 8,12,16,20);
          end;
        5:  //C1 sale price
          begin
            F0021Process4Cmds(doc, CX, 9,13,17,21);
            cmd := ProcessForm0021Math(doc, 24, CX);   //adjustments
          end;
        6:  //C2 sale price
          begin
            F0021Process4Cmds(doc, CX, 10,14,18,22);
            cmd := ProcessForm0021Math(doc, 25, CX);   //adjustments
          end;
        7:  //C3 sale price
          begin
            F0021Process4Cmds(doc, CX, 11,15,19,23);
            cmd := ProcessForm0021Math(doc, 26, CX);   //adjustments
          end;
    //sale per rent (rent multiplier)
        8:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,18), mcx(cx,19));    //sub rent chged
        9:
          cmd := DivideAB(doc, mcx(cx,67), mcx(cx,69), mcx(cx,70));    //C1 rent chged
        10:
          cmd := DivideAB(doc, mcx(cx,149), mcx(cx,151), mcx(cx,152));    //C2 rent chged
        11:
          cmd := DivideAB(doc, mcx(cx,231), mcx(cx,233), mcx(cx,234));    //C3 rent chged
    //sales per unit
        12:
          cmd := F0018SalePerUnit(doc, cx, 16, 33,38,43,48, 20);  //sub units chged
        13:
          cmd := F0018SalePerUnit(doc, cx, 67, 101,107,113,119, 71);  //C1 units chged
        14:
          cmd := F0018SalePerUnit(doc, cx, 149, 183,189,195,201, 153);  //C2 units chged
        15:
          cmd := F0018SalePerUnit(doc, cx, 231, 265,271,277,283, 235);  //C3 units chged
     //sales per room
        16:
          cmd := F0018SalePerRoom(doc, cx, 16, 34,39,44,49, 21);  //sub rooms chged
        17:
          cmd := F0018SalePerRoom(doc, cx, 67, 102,108,114,120, 72);  //C1 rooms chged
        18:
          cmd := F0018SalePerRoom(doc, cx, 149, 184,190,196,202, 154);  //C2 rooms chged
        19:
          cmd := F0018SalePerRoom(doc, cx, 231, 266,272,278,284, 236);  //C3 rooms chged
     //sales per sqft
        20:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,32), mcx(cx,17));   //sub sqft chged
        21:
          cmd := DivideAB(doc, mcx(cx,67), mcx(cx,97), mcx(cx,68));    //sub sqft chged
        22:
          cmd := DivideAB(doc, mcx(cx,149), mcx(cx,179), mcx(cx,150));   //C2 sqft chged
        23:
          cmd := DivideAB(doc, mcx(cx,231), mcx(cx,261), mcx(cx,232));   //C3 sqft chged
     //Adjustments
        24:
          cmd := F0021C1Adjustments(doc, cx);
        25:
          cmd := F0021C2Adjustments(doc, cx);
        26:
          cmd := F0021C3Adjustments(doc, cx);
        27:
          cmd := CalcWeightedAvg(doc, [18,21,2000]);   //calc wtAvg of main and xcomps forms
        28:
          begin
            F0021C1Adjustments(doc, cx);
            F0021C2Adjustments(doc, cx);
            F0021C3Adjustments(doc, cx);
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
          ProcessForm0021Math(doc, 24, CX);
          ProcessForm0021Math(doc, 25, CX);
          ProcessForm0021Math(doc, 26, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0021Math(doc, 28, CX);
        end;
    end;

  result := 0;
end;

//Income 71A ('98 version)
function ProcessForm0148Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0148SumLandUse(doc, CX);
        2:
          cmd := SiteDimension(doc, mcx(cx,4), mcx(cx,5));
        3:
          cmd := F0148UnitsPerAcre(doc, mcx(cx,81), mcx(cx,82), mcx(cx,83));
        4:
          cmd := DivideAB(doc, mcx(cx,127), mcx(cx,81), mcx(cx,132));   //parking ratio


      //special commands for rent schedule and vacancies
       204: Cmd := F0148RentSchedule(doc, mcx(cx,188), mcx(cx,194), mcx(cx,195), mcx(cx,196), mcx(cx,197));
       205: Cmd := F0148RentSchedule(doc, mcx(cx,203), mcx(cx,209), mcx(cx,210), mcx(cx,211), mcx(cx,212));
       206: Cmd := F0148RentSchedule(doc, mcx(cx,218), mcx(cx,224), mcx(cx,225), mcx(cx,226), mcx(cx,227));
       207: Cmd := F0148RentSchedule(doc, mcx(cx,233), mcx(cx,239), mcx(cx,240), mcx(cx,241), mcx(cx,242));
       208: Cmd := F0148RentSchedule(doc, mcx(cx,248), mcx(cx,254), mcx(cx,255), mcx(cx,256), mcx(cx,257));
       209: Cmd := F0148RentSchedule(doc, mcx(cx,263), mcx(cx,269), mcx(cx,270), mcx(cx,271), mcx(cx,272));
       210: Cmd := F0148RentSchedule(doc, mcx(cx,278), mcx(cx,284), mcx(cx,285), mcx(cx,286), mcx(cx,287));
       211: Cmd := F0148RentSchedule(doc, mcx(cx,293), mcx(cx,299), mcx(cx,300), mcx(cx,301), mcx(cx,302));
       212: Cmd := F0148RentSchedule(doc, mcx(cx,308), mcx(cx,314), mcx(cx,315), mcx(cx,316), mcx(cx,317));
       213: Cmd := F0148RentSchedule(doc, mcx(cx,323), mcx(cx,329), mcx(cx,330), mcx(cx,331), mcx(cx,332));
       214: Cmd := F0148RentSchedule(doc, mcx(cx,338), mcx(cx,344), mcx(cx,345), mcx(cx,346), mcx(cx,347));
       215: Cmd := F0148RentSchedule(doc, mcx(cx,353), mcx(cx,359), mcx(cx,360), mcx(cx,361), mcx(cx,362));

       216: Cmd := Sum12CellsR(doc, cx, 194,209,224,239,254,269,284,299,314,329,344,359, 370);


      //cost approach Pg4
        5:  cmd := MultAB(doc, mcx(cx,69), mcx(cx,70), mcx(cx,71));
        6:  cmd := MultAB(doc, mcx(cx,72), mcx(cx,73), mcx(cx,74));
        7:  cmd := MultAB(doc, mcx(cx,75), mcx(cx,76), mcx(cx,77));
        8:  cmd := MultAB(doc, mcx(cx,78), mcx(cx,79), mcx(cx,80));
        9:  cmd := MultAB(doc, mcx(cx,81), mcx(cx,82), mcx(cx,83));
        10: cmd := MultAB(doc, mcx(cx,84), mcx(cx,85), mcx(cx,86));
        11: cmd := MultAB(doc, mcx(cx,87), mcx(cx,88), mcx(cx,89));
        12: cmd := F0148SumEstimatedCostsNew(doc, cx);
        13: Cmd := SubtAB(doc, mcx(cx,118), mcx(cx,119), mcx(cx,120));
        14: Cmd := SumAB(doc, mcx(cx,120), mcx(cx,121), mcx(cx,122));
        15: Cmd := RoundByVal(doc, mcx(cx,122), mcx(cx,123), 1000);

      //rent/sqft Pg5
        16: Cmd := DivideAB(doc, mcx(cx,19), mcx(cx,18), mcx(cx,20));
        17: Cmd := DivideAB(doc, mcx(cx,25), mcx(cx,24), mcx(cx,26));
        18: Cmd := DivideAB(doc, mcx(cx,31), mcx(cx,30), mcx(cx,32));
        19: Cmd := DivideAB(doc, mcx(cx,37), mcx(cx,36), mcx(cx,38));
        20: Cmd := DivideAB(doc, mcx(cx,43), mcx(cx,42), mcx(cx,44));
        21: Cmd := DivideAB(doc, mcx(cx,49), mcx(cx,48), mcx(cx,50));
        22: Cmd := DivideAB(doc, mcx(cx,55), mcx(cx,54), mcx(cx,56));
        23: Cmd := DivideAB(doc, mcx(cx,61), mcx(cx,60), mcx(cx,62));
        24: Cmd := DivideAB(doc, mcx(cx,80), mcx(cx,79), mcx(cx,81));
        25: Cmd := DivideAB(doc, mcx(cx,86), mcx(cx,85), mcx(cx,87));
        26: Cmd := DivideAB(doc, mcx(cx,92), mcx(cx,91), mcx(cx,93));
        27: Cmd := DivideAB(doc, mcx(cx,98), mcx(cx,97), mcx(cx,99));
        28: Cmd := DivideAB(doc, mcx(cx,104), mcx(cx,103), mcx(cx,105));
        29: Cmd := DivideAB(doc, mcx(cx,110), mcx(cx,109), mcx(cx,111));
        30: Cmd := DivideAB(doc, mcx(cx,116), mcx(cx,115), mcx(cx,117));
        31: Cmd := DivideAB(doc, mcx(cx,122), mcx(cx,121), mcx(cx,123));
        32: Cmd := DivideAB(doc, mcx(cx,141), mcx(cx,140), mcx(cx,142));
        33: Cmd := DivideAB(doc, mcx(cx,147), mcx(cx,146), mcx(cx,148));
        34: Cmd := DivideAB(doc, mcx(cx,153), mcx(cx,152), mcx(cx,154));
        35: Cmd := DivideAB(doc, mcx(cx,159), mcx(cx,158), mcx(cx,160));
        36: Cmd := DivideAB(doc, mcx(cx,165), mcx(cx,164), mcx(cx,166));
        37: Cmd := DivideAB(doc, mcx(cx,171), mcx(cx,170), mcx(cx,172));
        38: Cmd := DivideAB(doc, mcx(cx,177), mcx(cx,176), mcx(cx,178));
        39: Cmd := DivideAB(doc, mcx(cx,183), mcx(cx,182), mcx(cx,184));

      //Rent Schedule  vertical summations
        40: Cmd := Sum12CellsR(doc, cx, 188,203,218,233,248,263,278,293,308,323,338,353, 368);
        41: Cmd := Sum12CellsR(doc, cx, 192,207,222,237,252,267,282,297,312,327,342,357, 369);
        42: cmd := F0148Process6Cmds(doc,cx, 204,216,0,0,0,0);
        43: Cmd := Sum12CellsR(doc, cx, 197,212,227,242,257,272,287,302,317,332,347,362, 371);
        44: Cmd := Sum12CellsR(doc, cx, 200,215,230,245,260,275,290,305,320,335,350,365, 372);
        45: Cmd := SumSixCellsR(doc, cx, 371,373,375,377,380,383, 385);
        46: Cmd := SumSixCellsR(doc, cx, 372,374,376,378,381,384, 386);
        47: Cmd := MultAByVal(doc, mcx(cx,385), mcx(cx,387), 12.0);
        48: Cmd := MultAByVal(doc, mcx(cx,386), mcx(cx,388), 12.0);

      //Rent Schedule  horizontal multiplications
      //calc total rooms
        49: Cmd := MultAB(doc, mcx(cx,188),mcx(cx,189), mcx(cx,192));
        50: Cmd := MultAB(doc, mcx(cx,203),mcx(cx,204), mcx(cx,207));
        51: Cmd := MultAB(doc, mcx(cx,218),mcx(cx,219), mcx(cx,222));
        52: Cmd := MultAB(doc, mcx(cx,233),mcx(cx,234), mcx(cx,237));
        53: Cmd := MultAB(doc, mcx(cx,248),mcx(cx,249), mcx(cx,252));
        54: Cmd := MultAB(doc, mcx(cx,263),mcx(cx,264), mcx(cx,267));
        55: Cmd := MultAB(doc, mcx(cx,278),mcx(cx,279), mcx(cx,282));
        56: Cmd := MultAB(doc, mcx(cx,293),mcx(cx,294), mcx(cx,297));
        57: Cmd := MultAB(doc, mcx(cx,308),mcx(cx,309), mcx(cx,312));
        58: Cmd := MultAB(doc, mcx(cx,323),mcx(cx,324), mcx(cx,327));
        59: Cmd := MultAB(doc, mcx(cx,338),mcx(cx,339), mcx(cx,342));
        60: Cmd := MultAB(doc, mcx(cx,353),mcx(cx,354), mcx(cx,357));
      //calc rent/room
        61: cmd := DivideAB(doc, mcx(cx,200), mcx(cx,192), mcx(cx,202));
        62: cmd := DivideAB(doc, mcx(cx,215), mcx(cx,207), mcx(cx,217));
        63: cmd := DivideAB(doc, mcx(cx,230), mcx(cx,222), mcx(cx,232));
        64: cmd := DivideAB(doc, mcx(cx,245), mcx(cx,237), mcx(cx,247));
        65: cmd := DivideAB(doc, mcx(cx,260), mcx(cx,252), mcx(cx,262));
        66: cmd := DivideAB(doc, mcx(cx,275), mcx(cx,267), mcx(cx,277));
        67: cmd := DivideAB(doc, mcx(cx,290), mcx(cx,282), mcx(cx,292));
        68: cmd := DivideAB(doc, mcx(cx,305), mcx(cx,297), mcx(cx,307));
        69: cmd := DivideAB(doc, mcx(cx,320), mcx(cx,312), mcx(cx,322));
        70: cmd := DivideAB(doc, mcx(cx,335), mcx(cx,327), mcx(cx,337));
        71: cmd := DivideAB(doc, mcx(cx,350), mcx(cx,342), mcx(cx,352));
        72: cmd := DivideAB(doc, mcx(cx,365), mcx(cx,357), mcx(cx,367));
      //calc rent/sqft
        73: cmd := DivideAByBC(doc, mcx(cx,200), mcx(cx,188), mcx(cx,193), mcx(cx,201));
        74: cmd := DivideAByBC(doc, mcx(cx,215), mcx(cx,203), mcx(cx,208), mcx(cx,216));
        75: cmd := DivideAByBC(doc, mcx(cx,230), mcx(cx,218), mcx(cx,223), mcx(cx,231));
        76: cmd := DivideAByBC(doc, mcx(cx,245), mcx(cx,233), mcx(cx,238), mcx(cx,246));
        77: cmd := DivideAByBC(doc, mcx(cx,260), mcx(cx,248), mcx(cx,253), mcx(cx,261));
        78: cmd := DivideAByBC(doc, mcx(cx,275), mcx(cx,263), mcx(cx,268), mcx(cx,276));
        79: cmd := DivideAByBC(doc, mcx(cx,290), mcx(cx,278), mcx(cx,283), mcx(cx,291));
        80: cmd := DivideAByBC(doc, mcx(cx,305), mcx(cx,293), mcx(cx,298), mcx(cx,306));
        81: cmd := DivideAByBC(doc, mcx(cx,320), mcx(cx,308), mcx(cx,313), mcx(cx,321));
        82: cmd := DivideAByBC(doc, mcx(cx,335), mcx(cx,323), mcx(cx,328), mcx(cx,336));
        83: cmd := DivideAByBC(doc, mcx(cx,350), mcx(cx,338), mcx(cx,343), mcx(cx,351));
        84: cmd := DivideAByBC(doc, mcx(cx,365), mcx(cx,353), mcx(cx,358), mcx(cx,366));
      //calc total scheduled rents
        85: cmd := F0148Process6Cmds(doc,cx, 204,0,0,0,0,0);
        86: cmd := F0148Process6Cmds(doc,cx, 205,0,0,0,0,0);
        87: cmd := F0148Process6Cmds(doc,cx, 206,0,0,0,0,0);
        88: cmd := F0148Process6Cmds(doc,cx, 207,0,0,0,0,0);
        89: cmd := F0148Process6Cmds(doc,cx, 208,0,0,0,0,0);
        90: cmd := F0148Process6Cmds(doc,cx, 209,0,0,0,0,0);
        91: cmd := F0148Process6Cmds(doc,cx, 210,0,0,0,0,0);
        92: cmd := F0148Process6Cmds(doc,cx, 211,0,0,0,0,0);
        93: cmd := F0148Process6Cmds(doc,cx, 212,0,0,0,0,0);
        94: cmd := F0148Process6Cmds(doc,cx, 213,0,0,0,0,0);
        95: cmd := F0148Process6Cmds(doc,cx, 214,0,0,0,0,0);
        96: cmd := F0148Process6Cmds(doc,cx, 215,0,0,0,0,0);
      //calc total economic rents
        97: cmd := F0148RentPerUnit(doc, cx, 188,198,199, 200);
        98: cmd := F0148RentPerUnit(doc, cx, 203,213,214, 215);
        99: cmd := F0148RentPerUnit(doc, cx, 218,228,229, 230);
        100: cmd := F0148RentPerUnit(doc, cx, 233,243,244, 245);
        101: cmd := F0148RentPerUnit(doc, cx, 248,258,259, 260);
        102: cmd := F0148RentPerUnit(doc, cx, 263,273,274, 275);
        103: cmd := F0148RentPerUnit(doc, cx, 278,288,289, 290);
        104: cmd := F0148RentPerUnit(doc, cx, 293,303,304, 305);
        105: cmd := F0148RentPerUnit(doc, cx, 308,318,319, 320);
        106: cmd := F0148RentPerUnit(doc, cx, 323,333,334, 335);
        107: cmd := F0148RentPerUnit(doc, cx, 338,348,349, 350);
        108: cmd := F0148RentPerUnit(doc, cx, 353,363,364, 365);

      //these are mathID for rent schedule (Units)
        109: cmd := F0148Process6Cmds(doc, cx, 204,40,49,0,0,0);
        110: cmd := F0148Process6Cmds(doc, cx, 205,40,50,0,0,0);
        111: cmd := F0148Process6Cmds(doc, cx, 206,40,51,0,0,0);
        112: cmd := F0148Process6Cmds(doc, cx, 207,40,52,0,0,0);
        113: cmd := F0148Process6Cmds(doc, cx, 208,40,53,0,0,0);
        114: cmd := F0148Process6Cmds(doc, cx, 209,40,54,0,0,0);
        115: cmd := F0148Process6Cmds(doc, cx, 210,40,55,0,0,0);
        116: cmd := F0148Process6Cmds(doc, cx, 211,40,56,0,0,0);
        117: cmd := F0148Process6Cmds(doc, cx, 212,40,57,0,0,0);
        118: cmd := F0148Process6Cmds(doc, cx, 213,40,58,0,0,0);
        119: cmd := F0148Process6Cmds(doc, cx, 214,40,59,0,0,0);
        120: cmd := F0148Process6Cmds(doc, cx, 215,40,60,0,0,0);
      //these are mathID for rent schedule (Rooms)
        121: cmd := F0148Process6Cmds(doc, cx, 41,61,0,0,0,0);
        122: cmd := F0148Process6Cmds(doc, cx, 41,62,0,0,0,0);
        123: cmd := F0148Process6Cmds(doc, cx, 41,63,0,0,0,0);
        124: cmd := F0148Process6Cmds(doc, cx, 41,64,0,0,0,0);
        125: cmd := F0148Process6Cmds(doc, cx, 41,65,0,0,0,0);
        126: cmd := F0148Process6Cmds(doc, cx, 41,66,0,0,0,0);
        127: cmd := F0148Process6Cmds(doc, cx, 41,67,0,0,0,0);
        128: cmd := F0148Process6Cmds(doc, cx, 41,68,0,0,0,0);
        129: cmd := F0148Process6Cmds(doc, cx, 41,69,0,0,0,0);
        130: cmd := F0148Process6Cmds(doc, cx, 41,70,0,0,0,0);
        131: cmd := F0148Process6Cmds(doc, cx, 41,71,0,0,0,0);
        132: cmd := F0148Process6Cmds(doc, cx, 41,72,0,0,0,0);
      //these are the mathIDs for rent schedule (Econ Rents)
        133: cmd := F0148Process6Cmds(doc, cx, 44,73,61,0,0,0);
        134: cmd := F0148Process6Cmds(doc, cx, 44,74,62,0,0,0);
        135: cmd := F0148Process6Cmds(doc, cx, 44,75,63,0,0,0);
        136: cmd := F0148Process6Cmds(doc, cx, 44,76,64,0,0,0);
        137: cmd := F0148Process6Cmds(doc, cx, 44,77,65,0,0,0);
        138: cmd := F0148Process6Cmds(doc, cx, 44,78,66,0,0,0);
        139: cmd := F0148Process6Cmds(doc, cx, 44,79,67,0,0,0);
        140: cmd := F0148Process6Cmds(doc, cx, 44,80,68,0,0,0);
        141: cmd := F0148Process6Cmds(doc, cx, 44,81,69,0,0,0);
        142: cmd := F0148Process6Cmds(doc, cx, 44,82,70,0,0,0);
        143: cmd := F0148Process6Cmds(doc, cx, 44,83,71,0,0,0);
        144: cmd := F0148Process6Cmds(doc, cx, 44,84,72,0,0,0);
        //145: cmd := F0148Process6Cmds(doc, cx, 44,85,0,0,0,0);

    //Page 6: Market approach Price per Units & Rooms
        150: Cmd := F71APricePerUnitNRm(doc,cx, 50, 28,32,36,40,44, 29,33,37,41,45, 61,62);            //Subj
        151: Cmd := F71APricePerUnitNRm(doc,cx, 108, 86,90,94,98,102, 87,91,95,99,103, 119,120);         //C1
        152: Cmd := F71APricePerUnitNRm(doc,cx, 167, 145,149,153,157,161, 146,150,154,158,162, 178,179); //C2
        153: Cmd := F71APricePerUnitNRm(doc,cx, 226, 204,208,212,216,220, 205,209,213,217,221, 237,238);  //C3

        154: Cmd := F0148Process6Cmds(doc,cx, 150,166,171,175,0, 0);       //Price Subj
        155: Cmd := F0148Process6Cmds(doc,cx, 151,167,172,176,0, 0);       //Price C1
        156: Cmd := F0148Process6Cmds(doc,cx, 152,168,173,177,0, 0);       //Price c2
        157: Cmd := F0148Process6Cmds(doc,cx, 153,169,174,178,0, 0);       //Price c3

        (*158: Cmd := F0148Process6Cmds(doc,cx, 171,179,183,0,0,0);   //Gross Annual Income Subj
        159: Cmd := F0148Process6Cmds(doc,cx, 172,180,184,0,0,0);   //Gross Annual Income C1
        160: Cmd := F0148Process6Cmds(doc,cx, 173,181,185,0,0,0);   //Gross Annual Income C2
        161: Cmd := F0148Process6Cmds(doc,cx, 174,182,186,0,0,0);   //Gross Annual Income C3*)

        158: Cmd := F0148Process6Cmds(doc,cx, 171,183,0,0,0,0);   //Gross Annual Income Subj
        159: Cmd := F0148Process6Cmds(doc,cx, 172,184,0,0,0,0);   //Gross Annual Income C1
        160: Cmd := F0148Process6Cmds(doc,cx, 173,185,0,0,0,0);   //Gross Annual Income C2
        161: Cmd := F0148Process6Cmds(doc,cx, 174,186,0,0,0,0);   //Gross Annual Income C3

        162: Cmd := F0148Process6Cmds(doc,cx, 175,183,0,0,0,0);   //net annual income
        163: Cmd := F0148Process6Cmds(doc,cx, 176,184,0,0,0,0);
        164: Cmd := F0148Process6Cmds(doc,cx, 177,185,0,0,0,0);
        165: Cmd := F0148Process6Cmds(doc,cx, 178,186,0,0,0,0);

        166: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,18), mcx(cx,63));       //price/GBA sub
        167: Cmd := DivideAB(doc, mcx(cx,108), mcx(cx,79), mcx(cx,121));     //price/GBA C1
        168: Cmd := DivideAB(doc, mcx(cx,167), mcx(cx,138), mcx(cx,180));    //price/GBA C2
        169: Cmd := DivideAB(doc, mcx(cx,226), mcx(cx,197), mcx(cx,239));    //price/GBA C3

    //page 3 units change
        170: Cmd := F0148Process6Cmds(doc,cx, 3,4,0,0,0,0);

        //gross annual income multiplier
        171: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,56), mcx(cx,57));       //Price/GAI Subject
        172: Cmd := DivideAB(doc, mcx(cx,108), mcx(cx,114), mcx(cx,115));     //Price/GAI C1
        173: Cmd := DivideAB(doc, mcx(cx,167), mcx(cx,173), mcx(cx,174));    //Price/GAI C2
        174: Cmd := DivideAB(doc, mcx(cx,226), mcx(cx,232), mcx(cx,233));    //Price/GAI C3

        //Net annual income / Price
        175: Cmd := DivideABPercent(doc, mcx(cx,58), mcx(cx,50), mcx(cx,60));       //NetInc/Price Subject
        176: Cmd := DivideABPercent(doc, mcx(cx,116), mcx(cx,108), mcx(cx,118));    //NetInc/Price C1
        177: Cmd := DivideABPercent(doc, mcx(cx,175), mcx(cx,167), mcx(cx,177));    //NetInc/Price C2
        178: Cmd := DivideABPercent(doc, mcx(cx,234), mcx(cx,226), mcx(cx,236));    //NetInc/Price C3

        //removed by jenny - 2.16.07 - the user calculates the net annual income
        (*//calc net income
        179: Cmd := SubtAB(doc, mcx(cx,56), mcx(cx,48), mcx(cx,58));     //GAI - Exp - Subj
        180: Cmd := SubtAB(doc, mcx(cx,114), mcx(cx,106), mcx(cx,116));  //GAI - Exp - C1
        181: Cmd := SubtAB(doc, mcx(cx,173), mcx(cx,165), mcx(cx,175));  //GAI - Exp - C2
        182: Cmd := SubtAB(doc, mcx(cx,232), mcx(cx,224), mcx(cx,234));  //GAI - Exp - C3 *)

        //expense percent
        183: Cmd := F71AExpensePercent(doc, mcx(cx,56), mcx(cx,58), mcx(cx,59));     //Exp percentage - Subj
        184: Cmd := F71AExpensePercent(doc, mcx(cx,114), mcx(cx,116), mcx(cx,117));  //Exp percentage - C1
        185: Cmd := F71AExpensePercent(doc, mcx(cx,173), mcx(cx,175), mcx(cx,176));  //Exp percentage - C2
        186: Cmd := F71AExpensePercent(doc, mcx(cx,232), mcx(cx,234), mcx(cx,235));  //Exp percentage - C3

        //Value Indicators
        187: Cmd := MultAB(doc, mcx(cx,242), mcx(cx,243), mcx(cx,244));   //Gross Multiplier
        188: Cmd := MultAB(doc, mcx(cx,245), mcx(cx,246), mcx(cx,247));   //value per unit
        189: Cmd := MultAB(doc, mcx(cx,248), mcx(cx,249), mcx(cx,250));   //value per room
        190: Cmd := MultAB(doc, mcx(cx,251), mcx(cx,252), mcx(cx,253));   //value per sqft
        191: Cmd := RoundByVal(doc, mcx(cx,256), mcx(cx,257), 1000);      //round to 1000's

       //page 7 Annual Expense
        192: Cmd := F0148TaxRate(doc, mcx(cx,20), mcx(cx,17), mcx(cx,14), mcx(cx,18));
        193: Cmd := F0148Process6Cmds(doc,cx, 192,195,0,0,0,0);  //forcasted tax
        194: Cmd := F0148SumActualExps(doc, cx);
        195: Cmd := F0148SumForcastExps(doc, cx);
        //income approach
        196: Cmd := F0148Process6Cmds(doc,cx, 197,198,199,0,0,0);  //total gross econ income
        197: Cmd := MultPercentAB(doc, mcx(cx,161), mcx(cx,160), mcx(cx,162));
        198: Cmd := MultPercentAB(doc, mcx(cx,164), mcx(cx,164), mcx(cx,165));
        199: Cmd := SubtAB(doc, mcx(cx,160), mcx(cx,162), mcx(cx,163));
        200: Cmd := SubtAB(doc, mcx(cx,163), mcx(cx,165), mcx(cx,166));
        201: Cmd := SubtAB(doc, mcx(cx,166), mcx(cx,169), mcx(cx,170));
        202: Cmd := MultPercentAB(doc, mcx(cx,167), mcx(cx,168),mcx(cx,169));
        203: Cmd := RoundByVal(doc, mcx(cx,172), mcx(cx,173), 1000);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Income 71A Extra Sales
function ProcessForm0023Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA SALES', 'ADDENDUM',75,135,195, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Sales', 75,135,195);
        3:
          cmd := ConfigXXXInstance(doc, cx, 75,135,195);

        10: Cmd := F71APricePerUnitNRm(doc,cx, 60, 38,42,46,50,54, 39,43,47,51,55, 71,72);            //Subj
        11: Cmd := F71APricePerUnitNRm(doc,cx, 119, 97,101,105,109,113, 98,102,106,110,114, 130,131);         //C1
        12: Cmd := F71APricePerUnitNRm(doc,cx, 179, 157,161,165,169,173, 158,162,166,170,174, 190,191); //C2
        13: Cmd := F71APricePerUnitNRm(doc,cx, 239, 217,221,225,229,233, 218,222,226,230,234, 250,251);  //C3

        14: Cmd := DivideAB(doc, mcx(cx,60), mcx(cx,28), mcx(cx,73));       //price/GBA sub
        15: Cmd := DivideAB(doc, mcx(cx,119), mcx(cx,90), mcx(cx,132));     //price/GBA C1
        16: Cmd := DivideAB(doc, mcx(cx,179), mcx(cx,150), mcx(cx,192));    //price/GBA C2
        17: Cmd := DivideAB(doc, mcx(cx,239), mcx(cx,210), mcx(cx,252));    //price/GBA C3

        (*//calc net income
        18: Cmd := SubtAB(doc, mcx(cx,66), mcx(cx,58), mcx(cx,68));     //GAI - Exp - Subj
        19: Cmd := SubtAB(doc, mcx(cx,125), mcx(cx,117), mcx(cx,127));  //GAI - Exp - C1
        20: Cmd := SubtAB(doc, mcx(cx,185), mcx(cx,177), mcx(cx,187));  //GAI - Exp - C2
        21: Cmd := SubtAB(doc, mcx(cx,245), mcx(cx,237), mcx(cx,247));  //GAI - Exp - C3  *)

        22: Cmd := F0023Process6Cmds(doc,cx, 10,14,34,38,0,0);       //Price Subj
        23: Cmd := F0023Process6Cmds(doc,cx, 11,15,35,39,0,0);       //Price C1
        24: Cmd := F0023Process6Cmds(doc,cx, 12,16,36,40,0,0);       //Price c2
        25: Cmd := F0023Process6Cmds(doc,cx, 13,17,37,41,0,0);       //Price c3

        (*26: Cmd := F0023Process6Cmds(doc,cx, 34,18,42,0,0,0);   //Gross Annual Income Subj
        27: Cmd := F0023Process6Cmds(doc,cx, 35,19,43,0,0,0);   //Gross Annual Income C1
        28: Cmd := F0023Process6Cmds(doc,cx, 36,20,44,0,0,0);   //Gross Annual Income C2
        29: Cmd := F0023Process6Cmds(doc,cx, 37,21,45,0,0,0);   //Gross Annual Income C3  *)

        26: Cmd := F0023Process6Cmds(doc,cx, 34,42,0,0,0,0);   //Gross Annual Income Subj
        27: Cmd := F0023Process6Cmds(doc,cx, 35,43,0,0,0,0);   //Gross Annual Income C1
        28: Cmd := F0023Process6Cmds(doc,cx, 36,44,0,0,0,0);   //Gross Annual Income C2
        29: Cmd := F0023Process6Cmds(doc,cx, 37,45,0,0,0,0);   //Gross Annual Income C3

        30: Cmd := F0023Process6Cmds(doc,cx, 38,42,0,0,0,0);   //net annual income
        31: Cmd := F0023Process6Cmds(doc,cx, 39,43,0,0,0,0);
        32: Cmd := F0023Process6Cmds(doc,cx, 40,44,0,0,0,0);
        33: Cmd := F0023Process6Cmds(doc,cx, 41,45,0,0,0,0);

        //gross annual income multiplier
        34: Cmd := DivideAB(doc, mcx(cx,60), mcx(cx,66), mcx(cx,67));       //Price/GAI Subject
        35: Cmd := DivideAB(doc, mcx(cx,119), mcx(cx,125), mcx(cx,126));    //Price/GAI C1
        36: Cmd := DivideAB(doc, mcx(cx,179), mcx(cx,185), mcx(cx,186));    //Price/GAI C2
        37: Cmd := DivideAB(doc, mcx(cx,239), mcx(cx,245), mcx(cx,246));    //Price/GAI C3

        //Net annual income / Price
        38: Cmd := DivideABPercent(doc, mcx(cx,68), mcx(cx,60), mcx(cx,70));       //NetInc/Price Subject
        39: Cmd := DivideABPercent(doc, mcx(cx,127), mcx(cx,119), mcx(cx,129));    //NetInc/Price C1
        40: Cmd := DivideABPercent(doc, mcx(cx,187), mcx(cx,179), mcx(cx,189));    //NetInc/Price C2
        41: Cmd := DivideABPercent(doc, mcx(cx,247), mcx(cx,239), mcx(cx,249));    //NetInc/Price C3

        //expense percent
        42: Cmd := F71AExpensePercent(doc, mcx(cx,66), mcx(cx,68), mcx(cx,69));     //Exp percentage - Subj
        43: Cmd := F71AExpensePercent(doc, mcx(cx,125), mcx(cx,127), mcx(cx,128));  //Exp percentage - C1
        44: Cmd := F71AExpensePercent(doc, mcx(cx,185), mcx(cx,187), mcx(cx,188));  //Exp percentage - C2
        45: Cmd := F71AExpensePercent(doc, mcx(cx,245), mcx(cx,247), mcx(cx,248));  //Exp percentage - C3
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Income 71A Extra Rentals
function ProcessForm0024Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS', 'ADDENDUM',14,76,138, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 14,76,138);
        3:
          cmd := ConfigXXXInstance(doc, cx, 14,76,138);

      //rent/sqft Pg5
        10: Cmd := DivideAB(doc, mcx(cx,30), mcx(cx,29), mcx(cx,31));
        11: Cmd := DivideAB(doc, mcx(cx,36), mcx(cx,35), mcx(cx,37));
        12: Cmd := DivideAB(doc, mcx(cx,42), mcx(cx,41), mcx(cx,43));
        13: Cmd := DivideAB(doc, mcx(cx,48), mcx(cx,47), mcx(cx,49));
        14: Cmd := DivideAB(doc, mcx(cx,54), mcx(cx,53), mcx(cx,55));
        15: Cmd := DivideAB(doc, mcx(cx,60), mcx(cx,59), mcx(cx,61));
        16: Cmd := DivideAB(doc, mcx(cx,66), mcx(cx,65), mcx(cx,67));
        17: Cmd := DivideAB(doc, mcx(cx,72), mcx(cx,71), mcx(cx,73));
        18: Cmd := DivideAB(doc, mcx(cx,92), mcx(cx,91), mcx(cx,93));
        19: Cmd := DivideAB(doc, mcx(cx,98), mcx(cx,97), mcx(cx,99));
        20: Cmd := DivideAB(doc, mcx(cx,104), mcx(cx,103), mcx(cx,105));
        21: Cmd := DivideAB(doc, mcx(cx,110), mcx(cx,109), mcx(cx,111));
        22: Cmd := DivideAB(doc, mcx(cx,116), mcx(cx,115), mcx(cx,117));
        23: Cmd := DivideAB(doc, mcx(cx,122), mcx(cx,121), mcx(cx,123));
        24: Cmd := DivideAB(doc, mcx(cx,128), mcx(cx,127), mcx(cx,129));
        25: Cmd := DivideAB(doc, mcx(cx,134), mcx(cx,133), mcx(cx,135));
        26: Cmd := DivideAB(doc, mcx(cx,154), mcx(cx,153), mcx(cx,155));
        27: Cmd := DivideAB(doc, mcx(cx,160), mcx(cx,159), mcx(cx,161));
        28: Cmd := DivideAB(doc, mcx(cx,166), mcx(cx,165), mcx(cx,167));
        29: Cmd := DivideAB(doc, mcx(cx,172), mcx(cx,171), mcx(cx,173));
        30: Cmd := DivideAB(doc, mcx(cx,178), mcx(cx,177), mcx(cx,179));
        31: Cmd := DivideAB(doc, mcx(cx,184), mcx(cx,183), mcx(cx,185));
        32: Cmd := DivideAB(doc, mcx(cx,190), mcx(cx,189), mcx(cx,191));
        33: Cmd := DivideAB(doc, mcx(cx,196), mcx(cx,195), mcx(cx,197));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Income 71A Extra Cost Comps
function ProcessForm0025Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COST COMPARABLES', 'ADDENDUM',14,37,57, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Cost Comps',14,37,57);
        3:
          cmd := ConfigXXXInstance(doc, cx, 14,37,57);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Income 71B
function ProcessForm0026Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      {page 1}
        1: cmd := F0026InfoSumLandUse(doc, CX);   //put sum of land use in Info cell
        2: cmd := SiteDimension(doc, mcx(cx,166), mcx(cx,167));

      {page 2}

        //special commands for rent schedule and vacancies
        169: Cmd := F0026RentSchedule(doc, mcx(cx,303), mcx(cx,309), mcx(cx,310), mcx(cx,311), mcx(cx,312));
        180: Cmd := F0026RentSchedule(doc, mcx(cx,318), mcx(cx,324), mcx(cx,325), mcx(cx,326), mcx(cx,327));
        181: Cmd := F0026RentSchedule(doc, mcx(cx,333), mcx(cx,339), mcx(cx,340), mcx(cx,341), mcx(cx,342));
        182: Cmd := F0026RentSchedule(doc, mcx(cx,348), mcx(cx,354), mcx(cx,355), mcx(cx,356), mcx(cx,357));
        183: Cmd := F0026RentSchedule(doc, mcx(cx,363), mcx(cx,369), mcx(cx,370), mcx(cx,371), mcx(cx,372));
        184: Cmd := F0026RentSchedule(doc, mcx(cx,378), mcx(cx,384), mcx(cx,385), mcx(cx,386), mcx(cx,387));
        185: Cmd := F0026RentSchedule(doc, mcx(cx,393), mcx(cx,399), mcx(cx,400), mcx(cx,401), mcx(cx,402));
        186: Cmd := F0026RentSchedule(doc, mcx(cx,408), mcx(cx,414), mcx(cx,415), mcx(cx,416), mcx(cx,417));
        187: Cmd := F0026RentSchedule(doc, mcx(cx,423), mcx(cx,429), mcx(cx,430), mcx(cx,431), mcx(cx,432));
        170: cmd := SumTenCellsR(doc, cx, 309,324,339,354,369,384,399,414,429,0, 440);  //vacancies
        171: cmd := MultAB(doc, mcx(cx,303),mcx(cx,304), mcx(cx,307));  //units x rooms = total rms
        172: cmd := MultAB(doc, mcx(cx,318),mcx(cx,319), mcx(cx,322));
        173: cmd := MultAB(doc, mcx(cx,333),mcx(cx,334), mcx(cx,337));
        174: cmd := MultAB(doc, mcx(cx,348),mcx(cx,349), mcx(cx,352));
        175: cmd := MultAB(doc, mcx(cx,363),mcx(cx,364), mcx(cx,367));
        176: cmd := MultAB(doc, mcx(cx,378),mcx(cx,379), mcx(cx,382));
        177: cmd := MultAB(doc, mcx(cx,393),mcx(cx,394), mcx(cx,397));
        178: cmd := MultAB(doc, mcx(cx,408),mcx(cx,409), mcx(cx,412));
        179: cmd := MultAB(doc, mcx(cx,423),mcx(cx,424), mcx(cx,427));

      	 3: cmd := SumTenCellsR(doc, cx, 303,318,333,348,363,378,393,408,423,0, 438);  //units
        4: cmd := SumTenCellsR(doc, cx, 307,322,337,352,367,382,397,412,427,0, 439);  //rooms
        5: Cmd := F0026Process10Cmds(doc,cx, 169,180,181,182,183,184,185,186,187,170);
        6: cmd := SumTenCellsR(doc, cx, 312,327,342,357,372,387,402,417,432,0, 441);  //total act rents
        7: cmd := SumTenCellsR(doc, cx, 315,330,345,360,375,390,405,420,435,0, 442);  //total forcast rents

        8: Cmd := F0026Process6Cmds(doc,cx, 171, 169, 0, 0, 0, 0);
        9: Cmd := F0026Process6Cmds(doc,cx, 172, 180, 0, 0, 0, 0);
        10: Cmd := F0026Process6Cmds(doc,cx, 173, 181, 0, 0, 0, 0);
        11: Cmd := F0026Process6Cmds(doc,cx, 174, 182, 0, 0, 0, 0);
        12: Cmd := F0026Process6Cmds(doc,cx, 175, 183, 0, 0, 0, 0);
        13: Cmd := F0026Process6Cmds(doc,cx, 176, 184, 0, 0, 0, 0);
        14: Cmd := F0026Process6Cmds(doc,cx, 177, 185, 0, 0, 0, 0);
        15: Cmd := F0026Process6Cmds(doc,cx, 178, 186, 0, 0, 0, 0);
        16: Cmd := F0026Process6Cmds(doc,cx, 179, 187, 0, 0, 0, 0);

        17: Cmd := F0026Process6Cmds(doc,cx, 169, 0, 0, 0, 0, 0);       {Act Rent per unit}
        18: Cmd := F0026Process6Cmds(doc,cx, 180, 0, 0, 0, 0, 0);
        19: Cmd := F0026Process6Cmds(doc,cx, 181, 0, 0, 0, 0, 0);
        20: Cmd := F0026Process6Cmds(doc,cx, 182, 0, 0, 0, 0, 0);
        21: Cmd := F0026Process6Cmds(doc,cx, 183, 0, 0, 0, 0, 0);
        22: Cmd := F0026Process6Cmds(doc,cx, 184, 0, 0, 0, 0, 0);
        23: Cmd := F0026Process6Cmds(doc,cx, 185, 0, 0, 0, 0, 0);
        24: Cmd := F0026Process6Cmds(doc,cx, 186, 0, 0, 0, 0, 0);
        25: Cmd := F0026Process6Cmds(doc,cx, 187, 0, 0, 0, 0, 0);

        26: Cmd := F0026RentPerUnit(doc,cx, 303,313,314, 315);		{Forcasted Rent per unit}
        27: Cmd := F0026RentPerUnit(doc,cx, 318,328,329, 330);
        28: Cmd := F0026RentPerUnit(doc,cx, 333,343,344, 345);
        29: Cmd := F0026RentPerUnit(doc,cx, 348,358,359, 360);
        30: Cmd := F0026RentPerUnit(doc,cx, 363,373,374, 375);
        31: Cmd := F0026RentPerUnit(doc,cx, 378,388,389, 390);
        32: Cmd := F0026RentPerUnit(doc,cx, 393,403,404, 405);
        33: Cmd := F0026RentPerUnit(doc,cx, 408,418,419, 420);
        34: Cmd := F0026RentPerUnit(doc,cx, 423,433,434, 435);

        35: Cmd := F0026RentPerSqftNRoom2(doc,cx, 303,307,308,315, 316,317);		{Rent per sqft & room}
        36: Cmd := F0026RentPerSqftNRoom2(doc,cx, 318,322,323,330, 331,332);
        37: Cmd := F0026RentPerSqftNRoom2(doc,cx, 333,337,338,345, 346,347);
        38: Cmd := F0026RentPerSqftNRoom2(doc,cx, 348,352,353,360, 361,362);
        39: Cmd := F0026RentPerSqftNRoom2(doc,cx, 363,367,368,375, 376,377);
        40: Cmd := F0026RentPerSqftNRoom2(doc,cx, 378,382,383,390, 391,392);
        41: Cmd := F0026RentPerSqftNRoom2(doc,cx, 393,397,398,405, 406,407);
        42: Cmd := F0026RentPerSqftNRoom2(doc,cx, 408,412,413,420, 421,422);
        43: Cmd := F0026RentPerSqftNRoom2(doc,cx, 423,427,428,435, 436,437);

        44: Cmd := DivideAB(doc, mcx(cx,97),mcx(cx,96), mcx(cx,99));     //land sales price/area
        45: Cmd := DivideAB(doc, mcx(cx,104),mcx(cx,103), mcx(cx,106));
        46: Cmd := DivideAB(doc, mcx(cx,111),mcx(cx,110), mcx(cx,113));

        47: cmd := MultAB(doc, mcx(cx,118),mcx(cx,119), mcx(cx,120));    //Reproduction Costs
        48: cmd := MultAB(doc, mcx(cx,120),mcx(cx,121), mcx(cx,122));
        49: cmd := MultAB(doc, mcx(cx,122),mcx(cx,123), mcx(cx,124));
        163: cmd := MultAB(doc, mcx(cx,125),mcx(cx,126), mcx(cx,127));
        164: cmd := MultAB(doc, mcx(cx,127),mcx(cx,128), mcx(cx,129));
        165: cmd := MultAB(doc, mcx(cx,129),mcx(cx,130), mcx(cx,131));
        166: cmd := MultAB(doc, mcx(cx,132),mcx(cx,133), mcx(cx,134));
        167: cmd := MultAB(doc, mcx(cx,134),mcx(cx,135), mcx(cx,136));
        168: cmd := MultAB(doc, mcx(cx,136),mcx(cx,137), mcx(cx,138));


        50: Cmd := SumSixCellsR(doc,cx, 124,131,138,140,141,142, 143);	{Total Est repo new}

        51: Cmd := SubtAB(doc, mcx(cx,143), mcx(cx,145), mcx(cx,146));  //less deprecaition
        52: Cmd := SumAB(doc, mcx(cx,146), mcx(cx,147), mcx(cx,148));   //plus est land value
        53: Cmd := F0026LeaseHold(doc, mcx(cx,148),mcx(cx,149), mcx(cx,150));   //leasehold calc

        54: Cmd := F0026RentPerSqftNRoom(doc,cx, 161,164,165, 166,167);	 {U1}
        55: Cmd := F0026RentPerSqftNRoom(doc,cx, 168,171,172, 173,174);
        56: Cmd := F0026RentPerSqftNRoom(doc,cx, 175,178,179, 180,181);
        57: Cmd := F0026RentPerSqftNRoom(doc,cx, 182,185,186, 187,188);

        58: Cmd := F0026RentPerSqftNRoom(doc,cx, 207,210,211, 212,213);   {U2}
        59: Cmd := F0026RentPerSqftNRoom(doc,cx, 214,217,218, 219,220);
        60: Cmd := F0026RentPerSqftNRoom(doc,cx, 221,224,225, 226,227);
        61: Cmd := F0026RentPerSqftNRoom(doc,cx, 228,231,232, 233,234);

        62: Cmd := F0026RentPerSqftNRoom(doc,cx, 253,256,257, 258,259);   {U3}
        63: Cmd := F0026RentPerSqftNRoom(doc,cx, 260,263,264, 265,266);
        64: Cmd := F0026RentPerSqftNRoom(doc,cx, 267,270,271, 272,273);
        65: Cmd := F0026RentPerSqftNRoom(doc,cx, 274,277,278, 279,280);

        66: Cmd := MultAByVal(doc, mcx(cx,441), MCPX(cx,3,57), 12.0);    //Gross Annual rents

        67: Cmd := F0026PricePerSqftSub(doc, cx, mcpx(cx,3,64));          //subject price/gross build area

        68: Cmd := TransA2B(doc, mcx(cx,148), mcpx(cx,4,6));          //transfer fee simple
        69: Cmd := TransA2B(doc, mcx(cx,150), mcpx(cx,4,6));          //transfer leasehold
        70: Cmd := F0026Process6Cmds(doc,cx, 53,68,0,0,0,0);

        71: Cmd := F0026Process6Cmds(doc,cx, 3, 8, 81, 169, 0, 0);        //units 1
        72: Cmd := F0026Process6Cmds(doc,cx, 3, 9, 82, 180, 0, 0);        //units 2
        73: Cmd := F0026Process6Cmds(doc,cx, 3, 10, 83, 181, 0, 0);       //units 3
        74: Cmd := F0026Process6Cmds(doc,cx, 3, 11, 84, 182, 0, 0);       //units 4
        75: Cmd := F0026Process6Cmds(doc,cx, 3, 12, 85, 183, 0, 0);       //units 5
        76: Cmd := F0026Process6Cmds(doc,cx, 3, 13, 86, 184, 0, 0);       //units 6
        77: Cmd := F0026Process6Cmds(doc,cx, 3, 14, 87, 185, 0, 0);       //units 7
        78: Cmd := F0026Process6Cmds(doc,cx, 3, 15, 88, 186, 0, 0);       //units 8
        79: Cmd := F0026Process6Cmds(doc,cx, 3, 16, 89, 187, 0, 0);       //units 9

        81: Cmd := F0026Process6Cmds(doc,cx, 4, 35, 0, 0, 0, 0);           //rooms 1
        82: Cmd := F0026Process6Cmds(doc,cx, 4, 36, 0, 0, 0, 0);           //rooms 2
        83: Cmd := F0026Process6Cmds(doc,cx, 4, 37, 0, 0, 0, 0);          //rooms 3
        84: Cmd := F0026Process6Cmds(doc,cx, 4, 38, 0, 0, 0, 0);          //rooms 4
        85: Cmd := F0026Process6Cmds(doc,cx, 4, 39, 0, 0, 0, 0);          //rooms 5
        86: Cmd := F0026Process6Cmds(doc,cx, 4, 40, 0, 0, 0, 0);          //rooms 6
        87: Cmd := F0026Process6Cmds(doc,cx, 4, 41, 0, 0, 0, 0);          //rooms 7
        88: Cmd := F0026Process6Cmds(doc,cx, 4, 42, 0, 0, 0, 0);          //rooms 8
        89: Cmd := F0026Process6Cmds(doc,cx, 4, 43, 0, 0, 0, 0);          //rooms 9

        91: Cmd := F0026Process6Cmds(doc,cx, 7, 35, 0, 0, 0, 0);          //forecasted rents 1
        92: Cmd := F0026Process6Cmds(doc,cx, 7, 36, 0, 0, 0, 0);          //forecasted rents 2
        93: Cmd := F0026Process6Cmds(doc,cx, 7, 37, 0, 0, 0, 0);          //forecasted rents 3
        94: Cmd := F0026Process6Cmds(doc,cx, 7, 38, 0, 0, 0, 0);          //forecasted rents 4
        95: Cmd := F0026Process6Cmds(doc,cx, 7, 39, 0, 0, 0, 0);          //forecasted rents 5
        96: Cmd := F0026Process6Cmds(doc,cx, 7, 40, 0, 0, 0, 0);          //forecasted rents 6
        97: Cmd := F0026Process6Cmds(doc,cx, 7, 41, 0, 0, 0, 0);          //forecasted rents 7
        98: Cmd := F0026Process6Cmds(doc,cx, 7, 42, 0, 0, 0, 0);          //forecasted rents 8
        99: Cmd := F0026Process6Cmds(doc,cx, 7, 43, 0, 0, 0, 0);          //forecasted rents 9

        101: Cmd := F0026Process6Cmds(doc,cx, 35, 67, 0, 0, 0, 0);          //sqft 1
        102: Cmd := F0026Process6Cmds(doc,cx, 36, 67, 0, 0, 0, 0);          //sqft 2
        103: Cmd := F0026Process6Cmds(doc,cx, 37, 67, 0, 0, 0, 0);          //sqft 3
        104: Cmd := F0026Process6Cmds(doc,cx, 38, 67, 0, 0, 0, 0);          //sqft 4
        105: Cmd := F0026Process6Cmds(doc,cx, 39, 67, 0, 0, 0, 0);          //sqft 5
        106: Cmd := F0026Process6Cmds(doc,cx, 40, 67, 0, 0, 0, 0);          //sqft 6
        107: Cmd := F0026Process6Cmds(doc,cx, 41, 67, 0, 0, 0, 0);          //sqft 7
        108: Cmd := F0026Process6Cmds(doc,cx, 42, 67, 0, 0, 0, 0);          //sqft 8
        109: Cmd := F0026Process6Cmds(doc,cx, 43, 67, 0, 0, 0, 0);          //sqft 9

        110: Cmd := F0026PricePerSqft(doc,cx, 103,120, 164,171,178,185);       //calc price/sqft comp 1
        111: Cmd := F0026PricePerSqft(doc,cx, 159,176, 210,217,224,231);       //calc price/sqft comp 2
        112: Cmd := F0026PricePerSqft(doc,cx, 215,232, 256,263,270,277);       //calc price/sqft comp 3

        113: Cmd := F0026Process6Cmds(doc,cx, 67, 127, 139, 143, 155, 0);        //Price Subj
        114: Cmd := F0026Process6Cmds(doc,cx, 110, 128, 140, 144, 156, 0);       //Price C1
        115: Cmd := F0026Process6Cmds(doc,cx, 111, 129, 141, 145, 157, 0);       //Price c2
        116: Cmd := F0026Process6Cmds(doc,cx, 112, 130, 142, 146, 158, 0);       //Price c3

        117: Cmd := F0026SumActualExpenses(doc, cx);                    //sum the actual expenses
        118: Cmd := F0026SumForcastedExpenses(doc, cx);                //sum the forcasted expenses
        119: Cmd := SumAB(doc, mcx(cx,235), mcx(cx,238), mcx(cx,239));  //Gross monthly income
        120: Cmd := MultAByVal(doc, mcx(cx,239), mcx(cx,240), 12.0);    //gross annual income

        121: Cmd := SubtAB(doc, mcx(cx,240), mcx(cx,242), mcx(cx,243));        //Effective gross income
        122: Cmd := MultPercentAB(doc, mcx(cx,241), mcx(cx,240), mcx(cx,242)); //less vacancies
        123: Cmd := F0026Process6Cmds(doc,cx, 121,122,0,0,0,0);                //chged gross annual forecast
        124: Cmd := SubtAB(doc, mcx(cx,243), mcx(cx,244), mcx(cx,245));        //net annual income
        125: Cmd := MultPercentAB(doc,mcx(cx,246), mcx(cx,247), mcx(cx,248));  //less depr on furnishings
        126: Cmd := SubtAB(doc, mcx(cx,245), mcx(cx,248), mcx(cx,249));        //Net from REAL property

        127: Cmd := DivideAB(doc,mcx(cx,47),mcx(cx,57),mcx(cx,58));      //Gross Annual Multiplier- Subject
        128: Cmd := DivideAB(doc,mcx(cx,103),mcx(cx,113),mcx(cx,114));   //Gross Annual Multiplier C1
        129: Cmd := DivideAB(doc,mcx(cx,159),mcx(cx,169),mcx(cx,170));   //Gross Annual Multiplier C2
        130: Cmd := DivideAB(doc,mcx(cx,215),mcx(cx,225),mcx(cx,226));   //Gross Annual Multiplier C3

        //jenny 2.9.07 - the user will enter the net income himself, so no need for these commands
        //131: Cmd := SubtAB(doc, mcx(cx,57), mcx(cx,45), mcx(cx,59));     //Net income - Subj
        //132: Cmd := SubtAB(doc, mcx(cx,113), mcx(cx,101), mcx(cx,115));  //Net income - C1
        //133: Cmd := SubtAB(doc, mcx(cx,169), mcx(cx,157), mcx(cx,171));  //Net income - C2
        //134: Cmd := SubtAB(doc, mcx(cx,225), mcx(cx,213), mcx(cx,227));  //Net income - C3

        135: Cmd := F0026ExpensePercent(doc, mcx(cx,57), mcx(cx,59), mcx(cx,60));     //Exp percentage - Subj
        136: Cmd := F0026ExpensePercent(doc, mcx(cx,113), mcx(cx,115), mcx(cx,116));  //Exp percentage - C1
        137: Cmd := F0026ExpensePercent(doc, mcx(cx,169), mcx(cx,171), mcx(cx,172));  //Exp percentage - C2
        138: Cmd := F0026ExpensePercent(doc, mcx(cx,225), mcx(cx,227), mcx(cx,228));  //Exp percentage - C3

        139: Cmd := F0026Process6Cmds(doc,cx, 159,135,0,0,0,0);   //net annual income
        140: Cmd := F0026Process6Cmds(doc,cx, 160,136,0,0,0,0);
        141: Cmd := F0026Process6Cmds(doc,cx, 161,137,0,0,0,0);
        142: Cmd := F0026Process6Cmds(doc,cx, 162,138,0,0,0,0);

        143: Cmd := F0026PricePerUnitNRm(doc,cx, 47, 29,33,37,41, 30,34,38,42, 62,63);            //Subj
        144: Cmd := F0026PricePerUnitNRm(doc,cx, 103, 85,89,93,97, 86,90,94,98, 118,119);         //C1
        145: Cmd := F0026PricePerUnitNRm(doc,cx, 159, 141,145,149,153, 142,146,150,154, 174,175); //C2
        146: Cmd := F0026PricePerUnitNRm(doc,cx, 215, 197,201,205,209, 198,202,206,210, 230,231);  //C3

        //147: Cmd := F0026Process6Cmds(doc,cx, 127,131,135,0,0,0);   //Gross Annual Income Subj
        //148: Cmd := F0026Process6Cmds(doc,cx, 128,132,136,0,0,0);   //Gross Annual Income C1
        //149: Cmd := F0026Process6Cmds(doc,cx, 129,133,137,0,0,0);   //Gross Annual Income C2
        //150: Cmd := F0026Process6Cmds(doc,cx, 130,134,138,0,0,0);   //Gross Annual Income C3

        147: Cmd := F0026Process6Cmds(doc,cx, 127,135,0,0,0,0);   //Gross Annual Income Subj
        148: Cmd := F0026Process6Cmds(doc,cx, 128,136,0,0,0,0);  //Gross Annual Income C1
        149: Cmd := F0026Process6Cmds(doc,cx, 129,137,0,0,0,0);   //Gross Annual Income C2
        150: Cmd := F0026Process6Cmds(doc,cx, 130,138,0,0,0,0);   //Gross Annual Income C3

        //util has only one cmd, could change
        //151: Cmd := F0026Process6Cmds(doc,cx, 131,0,0,0,0,0);   //Expense for Subj #45
        //152: Cmd := F0026Process6Cmds(doc,cx, 132,0,0,0,0,0);   //Expense for  C1
        //153: Cmd := F0026Process6Cmds(doc,cx, 133,0,0,0,0,0);   //Expense for  C2
        //154: Cmd := F0026Process6Cmds(doc,cx, 134,0,0,0,0,0);   //Expense for  C3

        155: Cmd := DivideAB(doc, mcx(cx,47),mcx(cx,20), mcx(cx,64));
        156: Cmd := DivideAB(doc, mcx(cx,103),mcx(cx,79), mcx(cx,120));
        157: Cmd := DivideAB(doc, mcx(cx,159),mcx(cx,135), mcx(cx,176));
        158: Cmd := DivideAB(doc, mcx(cx,215),mcx(cx,191), mcx(cx,232));

        159: Cmd := PercentAOfB(doc,mcx(cx,59), mcx(cx,47), mcx(cx,61));        //Cap Rate - Subj
        160: Cmd := PercentAOfB(doc,mcx(cx,115), mcx(cx,103), mcx(cx,117));     //Cap Rate - C1
        161: Cmd := PercentAOfB(doc,mcx(cx,171), mcx(cx,159), mcx(cx,173));     //Cap Rate - C2
        162: Cmd := PercentAOfB(doc,mcx(cx,227), mcx(cx,215), mcx(cx,229));     //Cap Rate - C3

     else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Income 71B Extra Comps
function ProcessForm0027Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',75,132,189, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 75,132,189);
        3:
          cmd := ConfigXXXInstance(doc, cx, 75,132,189);

        //when units & rooms change
        4: Cmd := F0026PricePerUnitNRm(doc,cx, 57, 39,43,47,51, 40,44,48,52, 72,73);              //Subj
        5: Cmd := F0026PricePerUnitNRm(doc,cx, 114, 96,100,104,108, 97,101,105,109, 129,130);     //C1
        6: Cmd := F0026PricePerUnitNRm(doc,cx, 171, 153,157,161,165, 154,158,162,166, 186,187);   //C2
        7: Cmd := F0026PricePerUnitNRm(doc,cx, 228, 210,214,218,222, 211,215,219,223, 243,244);  //C3

        (*//reduce to single cmd
        8: Cmd := F0027Process6Cmds(doc,cx, 24,0,0,0,0,0);   //Expense for Subj #45
        9: Cmd := F0027Process6Cmds(doc,cx, 25,0,0,0,0,0);   //Expense for  C1
        10: Cmd := F0027Process6Cmds(doc,cx, 26,0,0,0,0,0);   //Expense for  C2
        11: Cmd := F0027Process6Cmds(doc,cx, 27,0,0,0,0,0);   //Expense for  C3 *)

        12: Cmd := F0027Process6Cmds(doc,cx, 0, 32, 36, 40, 44, 0);        //Price Subj
        13: Cmd := F0027Process6Cmds(doc,cx, 0, 33, 37, 41, 45, 0);       //Price C1
        14: Cmd := F0027Process6Cmds(doc,cx, 0, 34, 38, 42, 46, 0);       //Price c2
        15: Cmd := F0027Process6Cmds(doc,cx, 0, 35, 39, 43, 47, 0);       //Price c3

        (*16: Cmd := F0027Process6Cmds(doc,cx, 32,24,28,0,0,0);   //Gross Annual Income Subj
        17: Cmd := F0027Process6Cmds(doc,cx, 33,25,29,0,0,0);   //Gross Annual Income C1
        18: Cmd := F0027Process6Cmds(doc,cx, 34,26,30,0,0,0);   //Gross Annual Income C2
        19: Cmd := F0027Process6Cmds(doc,cx, 35,27,31,0,0,0);   //Gross Annual Income C3 *)

        16: Cmd := F0027Process6Cmds(doc,cx, 32,28,0,0,0,0);   //Gross Annual Income Subj
        17: Cmd := F0027Process6Cmds(doc,cx, 33,29,0,0,0,0);   //Gross Annual Income C1
        18: Cmd := F0027Process6Cmds(doc,cx, 34,30,0,0,0,0);   //Gross Annual Income C2
        19: Cmd := F0027Process6Cmds(doc,cx, 35,31,0,0,0,0);   //Gross Annual Income C3

        20: Cmd := F0027Process6Cmds(doc,cx, 48,28,0,0,0,0);   //net annual income entered
        21: Cmd := F0027Process6Cmds(doc,cx, 49,29,0,0,0,0);
        22: Cmd := F0027Process6Cmds(doc,cx, 50,30,0,0,0,0);
        23: Cmd := F0027Process6Cmds(doc,cx, 51,31,0,0,0,0);

        //jenny 2.9.07 - the user will enter the net income himself, so no need for these commands
        (*24: Cmd := SubtAB(doc, mcx(cx,67), mcx(cx,55), mcx(cx,69));     //Net income - Subj
        //25: Cmd := SubtAB(doc, mcx(cx,124), mcx(cx,112), mcx(cx,126));  //Net income - C1
        //26: Cmd := SubtAB(doc, mcx(cx,181), mcx(cx,169), mcx(cx,183));  //Net income - C2
        //27: Cmd := SubtAB(doc, mcx(cx,238), mcx(cx,226), mcx(cx,240));  //Net income - C3*)

        28: Cmd := F0026ExpensePercent(doc, mcx(cx,67), mcx(cx,69), mcx(cx,70));    //Exp percentage - Subj
        29: Cmd := F0026ExpensePercent(doc, mcx(cx,124), mcx(cx,126), mcx(cx,127));  //Exp percentage - C1
        30: Cmd := F0026ExpensePercent(doc, mcx(cx,181), mcx(cx,183), mcx(cx,184));  //Exp percentage - C2
        31: Cmd := F0026ExpensePercent(doc, mcx(cx,238), mcx(cx,240), mcx(cx,241));  //Exp percentage - C3

        32: Cmd := DivideAB(doc,mcx(cx,57),mcx(cx,67),mcx(cx,68));      //Gross Annal Multiplier- Subject
        33: Cmd := DivideAB(doc,mcx(cx,114),mcx(cx,124),mcx(cx,125));   //Gross Annal Multiplier C1
        34: Cmd := DivideAB(doc,mcx(cx,171),mcx(cx,181),mcx(cx,182));   //Gross Annal Multiplier C2
        35: Cmd := DivideAB(doc,mcx(cx,228),mcx(cx,238),mcx(cx,239));   //Gross Annal Multiplier C3

        36: Cmd := PercentAOfB(doc,mcx(cx,69), mcx(cx,57), mcx(cx,71));        //Cap Rate - Subj
        37: Cmd := PercentAOfB(doc,mcx(cx,126), mcx(cx,114), mcx(cx,128));     //Cap Rate - C1
        38: Cmd := PercentAOfB(doc,mcx(cx,183), mcx(cx,171), mcx(cx,185));     //Cap Rate - C2
        39: Cmd := PercentAOfB(doc,mcx(cx,240), mcx(cx,228), mcx(cx,242));     //Cap Rate - C3

        40: Cmd := F0026PricePerUnitNRm(doc,cx, 57, 39,43,47,51, 40,44,48,52, 72,73);            //Subj
        41: Cmd := F0026PricePerUnitNRm(doc,cx, 114, 96,100,104,108, 97,101,105,109, 129,130);   //C1
        42: Cmd := F0026PricePerUnitNRm(doc,cx, 171, 153,157,161,165, 154,158,162,166, 186,187); //C2
        43: Cmd := F0026PricePerUnitNRm(doc,cx, 228, 210,214,218,222, 211,215,219,223, 243,244);  //C3

        44: Cmd := DivideAB(doc, mcx(cx,57),mcx(cx,30), mcx(cx,74));
        45: Cmd := DivideAB(doc, mcx(cx,114),mcx(cx,90), mcx(cx,131));
        46: Cmd := DivideAB(doc, mcx(cx,171),mcx(cx,147), mcx(cx,188));
        47: Cmd := DivideAB(doc, mcx(cx,228),mcx(cx,204), mcx(cx,245));

        48: Cmd := PercentAOfB(doc,mcx(cx,69), mcx(cx,57), mcx(cx,71));        //Cap Rate - Subj
        49: Cmd := PercentAOfB(doc,mcx(cx,126), mcx(cx,114), mcx(cx,128));     //Cap Rate - C1
        50: Cmd := PercentAOfB(doc,mcx(cx,183), mcx(cx,171), mcx(cx,185));     //Cap Rate - C2
        51: Cmd := PercentAOfB(doc,mcx(cx,240), mcx(cx,228), mcx(cx,242));     //Cap Rate - C3
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// Income 71B Extra Rentals
function ProcessForm0028Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS', 'ADDENDUM',14,61,108, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 14,61,108);
        3:
          cmd := ConfigXXXInstance(doc, cx, 14,61,108);

        4: Cmd := F0026RentPerSqftNRoom(doc,cx, 25,28,29, 30,31);	 {U1}
        5: Cmd := F0026RentPerSqftNRoom(doc,cx, 32,35,36, 37,38);
        6: Cmd := F0026RentPerSqftNRoom(doc,cx, 39,42,43, 44,45);
        7: Cmd := F0026RentPerSqftNRoom(doc,cx, 46,49,50, 51,52);

        8: Cmd := F0026RentPerSqftNRoom(doc,cx, 72,75,76, 77,78);   {U2}
        9: Cmd := F0026RentPerSqftNRoom(doc,cx, 79,82,83, 84,85);
        10: Cmd := F0026RentPerSqftNRoom(doc,cx, 86,89,90, 91,92);
        11: Cmd := F0026RentPerSqftNRoom(doc,cx, 93,96,97, 98,99);

        12: Cmd := F0026RentPerSqftNRoom(doc,cx, 119,122,123, 124,125);   {U3}
        13: Cmd := F0026RentPerSqftNRoom(doc,cx, 126,129,130, 131,132);
        14: Cmd := F0026RentPerSqftNRoom(doc,cx, 133,136,137, 138,139);
        15: Cmd := F0026RentPerSqftNRoom(doc,cx, 140,143,144, 145,146);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Comparable Rent Schedule
function ProcessForm0029Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
					1:
						Cmd := F0029AdjMonthlyRent(doc, cx, 9,10,11, 12);		{sub adj monthly rent}
					2:
						Cmd := F0029AdjMonthlyRent(doc, cx, 35,36,37, 38);		{c1 adj monthly rent}
					3:
						Cmd := F0029AdjMonthlyRent(doc, cx, 82,83,84, 85);		{c2 adj monthly rent}
					4:
						Cmd := F0029AdjMonthlyRent(doc, cx, 129,130,131, 132);	  {c3 adj monthly rent}
					5:
						Cmd := F0029C1Adjustments(doc, cx);
					6:
						Cmd := F0029C2Adjustments(doc, cx);
					7:
						Cmd := F0029C3Adjustments(doc, cx);
          8:
            cmd := CalcWeightedAvg(doc, [29,122]);   //calc wtAvg of main and xcomps forms
          9:
            begin
              F0029C1Adjustments(doc, cx);
              F0029C2Adjustments(doc, cx);
              F0029C3Adjustments(doc, cx);
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
          ProcessForm0029Math(doc, 5, CX);
          ProcessForm0029Math(doc, 6, CX);
          ProcessForm0029Math(doc, 7, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0029Math(doc, 9, CX);
        end;
    end;

  result := 0;
end;

//Comparable Rentals - XComps
function ProcessForm0122Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := F0122AdjMonthlyRent(doc,CX,18,19,20,21);
        2: Cmd := F0122AdjMonthlyRent(doc,CX,45,46,47,48);
        3: Cmd := F0122AdjMonthlyRent(doc,CX,93,94,95,96);
        4: Cmd := F0122AdjMonthlyRent(doc,CX,141,142,143,144);
        5: Cmd := F0122C1Adjustments(doc, CX);
        6: Cmd := F0122C2Adjustments(doc, CX);
        7: Cmd := F0122C3Adjustments(doc, CX);

        8: Cmd := CalcWeightedAvg(doc, [29,122]);   //calc wtAvg of main and xcomps forms

        9:
           Cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTAL COMPARABLES','', 38,86,134, 2);
        12:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rental Comps', 38,86,134);
        13:
          cmd := ConfigXXXInstance(doc, cx, 38,86,134);
        14:
          begin
            F0122C1Adjustments(doc, cx);
            F0122C2Adjustments(doc, cx);
            F0122C3Adjustments(doc, cx);
            cmd := 0;
          end;

      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0122Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

//Operating Income Statement
function ProcessForm0032Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd :=SumFourCellsR(doc,cx, 12,17,22,27, 29);      //Current rent
        2:
          cmd :=SumFourCellsR(doc,cx, 13,18,23,28, 30);      //market rent
        3:
          cmd := SumAB(doc, mcx(cx,43), mcx(cx,44), mcx(cx,45));    //total income
        4:
          Cmd := SumAB(doc, mcx(cx,83), mcx(cx,84), mcx(cx,85));     //total adj by lender
        5:
          Cmd := SubtAB(doc, mcx(cx,45), mcx(cx,46), mcx(cx,48));   //less vacancy
        6:
          Cmd := SubtAB(doc, mcx(cx,85), mcx(cx,86), mcx(cx,88));   //less vacancy lender
        7:
          begin
            PercentAOfB(doc, mcx(cx,46), mcx(cx,45), mcx(cx,47));  //calc percent vac
            Cmd := 5;                                              //then subtract
          end;
        8:
          begin
            MultPercentAB(doc, mcx(cx,47), mcx(cx,45), mcx(cx,46));  //calc vac from percent
            Cmd := 5;                                                //then subtract
          end;
        9:
          begin
            PercentAOfB(doc, mcx(cx,86), mcx(cx,85), mcx(cx,87));  //calc percent vac (lender)
            Cmd := 6;                                              //then subtract
          end;
        10:
          begin
            MultPercentAB(doc, mcx(cx,87), mcx(cx,85), mcx(cx,86));  //calc vac from percent (lender)
            Cmd := 6;                                                //then subtract
          end;
        11:
          cmd := F0032SumAppraiserExps(doc, cx);
        12:
          cmd := F0032SumLenderExps(doc, cx);

        //Page 2
        13:
          cmd := MultABDivC(doc, mcx(cx,5), mcx(cx,7), mcx(cx,6), mcx(cx,8));   //stoves
        14:
          cmd := MultABDivC(doc, mcx(cx,10), mcx(cx,12), mcx(cx,11), mcx(cx,13));   //refigrators
        15:
          cmd := MultABDivC(doc, mcx(cx,15), mcx(cx,17), mcx(cx,16), mcx(cx,18));   //
        16:
          cmd := MultABDivC(doc, mcx(cx,20), mcx(cx,22), mcx(cx,21), mcx(cx,23));   //
        17:
          cmd := MultABDivC(doc, mcx(cx,25), mcx(cx,27), mcx(cx,26), mcx(cx,28));   //
        18:
          cmd := MultABDivC(doc, mcx(cx,30), mcx(cx,32), mcx(cx,31), mcx(cx,33));   //
        19:
          cmd := MultABDivC(doc, mcx(cx,35), mcx(cx,37), mcx(cx,36), mcx(cx,38));   //
        20:
          cmd := MultABDivC(doc, mcx(cx,40), mcx(cx,42), mcx(cx,41), mcx(cx,43));   //
        21:
          Cmd := DivideAB(doc,mcx(cx,45), mcx(cx,46), mcx(cx,47));      //roof
        22:
          cmd := MultABDivC(doc, mcx(cx,49), mcx(cx,50), mcx(cx,51), mcx(cx,52));   //carpet units
        23:
          cmd := MultABDivC(doc, mcx(cx,54), mcx(cx,55), mcx(cx,56), mcx(cx,57));   //carpet public
        24:
          cmd := F0032SumReplaceResAppr(doc, cx);
        25:
          cmd := F0032SumReplaceResLender(doc, cx);

        26:
          cmd := SubtAB(doc,mcx(cx,61), mcx(cx,62), mcx(cx,63));    //operating inc
        27:
          cmd := DivideAByVal(doc, mcx(cx,63), mcx(cx,64), 12.0);   //monthly oper inc
        28:
          cmd := SubtAB(doc,mcx(cx,65), mcx(cx,66), mcx(cx,67));    //net cash
        29:
          cmd := F0032MultAByValCurrent(doc, mcx(cx,29), mcx(cx,43), 12.0);
        30:
          cmd := F0032MultAByValMarket(doc, mcx(cx,30), mcx(cx,43), 12.0);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FNMA 1074 CoOp Appraisal Request
function ProcessForm0033Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FNMA 1075 CoOp Appraisal Report
function ProcessForm0034Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0034Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0034C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0034C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,43), mcx(cx,84), mcx(cx,44));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0034Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0034C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0034C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,153), mcx(cx,113));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0034Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0034C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0034C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,181), mcx(cx,222), mcx(cx,182));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,27), mcx(cx,8));     //Subj price/sqft
        11:
          cmd := 0;   //BroadcastLenderAddress(doc, CX);
        12:
          cmd := CalcWeightedAvg(doc, [34,35]);   //calc wtAvg of main and xcomps forms
        13:
          begin
            F0034C1Adjustments(doc, cx);       //sum of adjs
            F0034C2Adjustments(doc, cx);       //sum of adjs
            F0034C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
        14:
          cmd := F0034InfoSumLandUse(doc, CX);   //put sum of land use in Info cell
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0034Math(doc, 14, CX);
          CX.pg := 2;    //math is on page 3
          ProcessForm0034Math(doc, 2, CX);
          ProcessForm0034Math(doc, 5, CX);
          ProcessForm0034Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 2;    //math is on page 1
          ProcessForm0034Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

//CoOp Appraisal Extra Comps
function ProcessForm0035Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',49,119,189, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 49,119,189);
        3:
          cmd := ConfigXXXInstance(doc, cx, 49,119,189);
//Comp1 calcs
        4:   //sales price changed
          begin
            ProcessForm0035Math(doc, 6, CX);        //calc new price/sqft
            cmd := F0035C1Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0035C1Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,54), mcx(cx,95), mcx(cx,55));     //price/sqft

//Comp2 calcs
        7:   //sales price changed
          begin
            ProcessForm0035Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0035C2Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0035C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,124), mcx(cx,165), mcx(cx,125));     //price/sqft

//Comp3 calcs
        10:   //sales price changed
          begin
            ProcessForm0035Math(doc, 12, CX);     //calc new price/sqft
            cmd := F0035C3Adjustments(doc, cx);     //redo the adjustments
          end;
        11:
          cmd := F0035C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := DivideAB(doc, mcx(cx,194), mcx(cx,235), mcx(cx,195));     //price/sqft

        13:
          cmd := DivideAB(doc, mcx(cx,17), mcx(cx,37), mcx(cx,18));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [34,35]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0035C1Adjustments(doc, cx);       //sum of adjs
            F0035C2Adjustments(doc, cx);       //sum of adjs
            F0035C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0035Math(doc, 5, CX);
          ProcessForm0035Math(doc, 8, CX);
          ProcessForm0035Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0035Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;
(*
//Review 1032 (2002)
function ProcessForm0138Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0138Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0138C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0138C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,39), mcx(cx,66), mcx(cx,40));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0138Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0138C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0138C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,85), mcx(cx,112), mcx(cx,86));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0138Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0138C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0138C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,131), mcx(cx,158), mcx(cx,132));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,28), mcx(cx,16));     //Subj price/sqft
        11:
          cmd := CalcWeightedAvg(doc, [138,139]);   //calc wtAvg of main and xcomps forms
        12:
          begin
            F0138C1Adjustments(doc, cx);       //sum of adjs
            F0138C2Adjustments(doc, cx);       //sum of adjs
            F0138C3Adjustments(doc, cx);       //sum of adjs
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
          CX.pg := 1;    //math is on page 2
          ProcessForm0138Math(doc, 2, CX);
          ProcessForm0138Math(doc, 5, CX);
          ProcessForm0138Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 1
          ProcessForm0138Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;

//Review 1032 (2002) Extra Sal\es
function ProcessForm0139Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA SALES', 'ADDENDUM',37,84,131, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Sales', 37,84,131);
        3:
          cmd := ConfigXXXInstance(doc, cx, 37,84,131);
//Comp1 calcs
        4:   //sales price changed
          begin
            ProcessForm0139Math(doc, 6, CX);        //calc new price/sqft
            cmd := F0139C1Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0139C1Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,41), mcx(cx,68), mcx(cx,42));     //price/sqft

//Comp2 calcs
        7:   //sales price changed
          begin
            ProcessForm0139Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0139C2Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0139C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,88), mcx(cx,115), mcx(cx,89));     //price/sqft

//Comp3 calcs
        10:   //sales price changed
          begin
            ProcessForm0139Math(doc, 12, CX);     //calc new price/sqft
            cmd := F0139C3Adjustments(doc, cx);     //redo the adjustments
          end;
        11:
          cmd := F0139C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := DivideAB(doc, mcx(cx,135), mcx(cx,162), mcx(cx,136));     //price/sqft

        13:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,29), mcx(cx,17));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [138,139]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0139C1Adjustments(doc, cx);       //sum of adjs
            F0139C2Adjustments(doc, cx);       //sum of adjs
            F0139C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0139Math(doc, 5, CX);
          ProcessForm0139Math(doc, 9, CX);
          ProcessForm0139Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0139Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;
*)
end.


