unit UMathResid1;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }

                           
interface

uses
  UGlobals, UContainer;

const
  fmURARForm    = 1;
  fmURARXCmps   = 2;
  CondoForm     = 7;
  CondoXCmps    = 8;
  fmMobileForm  = 11;
  fmMobileXCmps = 12;
  Condo465A     = 44;
  Condo465B     = 45;
  fmPUD1Form    = 46;
  fmPUD2Form    = 47;
  fmMgfHm70B    = 121;
  fmMgfHmOld    = 279;
  fmOneUntDsk   = 1033; //github 668


  function ProcessForm0001Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0002Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0007Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0008Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0011Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0012Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0044Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0045Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0046Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0047Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0121Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0279Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm1033Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;    //github 668

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

 (*
 	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(2, 118));
		Val[2] := GetCellValue(CurWPtr, MC(2, 178));
		Val[3] := GetCellValue(CurWPtr, MC(2, 238));

		Val[4] := GetCellValue(CurWPtr, MC(3, 99));
		Val[5] := GetCellValue(CurWPtr, MC(3, 159));
		Val[6] := GetCellValue(CurWPtr, MC(3, 219));

		N := 0;
		for i := 1 to 6 do
			if val[i] <> 0 then
				N := N + 1;
		if N = 0 then
			CellResult := 0
		else
			CellResult := (Val[1] + val[2] + val[3] + Val[4] + val[5] + val[6]) / N;

		Result2InfoCell(2, 4, Num2Longint(CellResult));
		Result2InfoCell(3, 3, Num2Longint(CellResult));

		InfoSalesAverage := 0;
	end;
(*
//URAR MATH



	function InspectProperty: Integer;
		var
			DNC: Integer;
			Str1: Str5;
			Str2: Str5;
	begin
		with docPeek(CurWPtr)^.docCurCell do
			begin
				if (CurCell.Pg = 2) & (CurCell.Num = 271) then
					begin
						Str1 := GetCellString(CurWPtr, mc(2, 271));
						Str2 := ' ';

						DNC := Result2Cell(Str1, mc(5, 14));		{set the checkmark}
						DNC := Result2Cell(Str2, mc(5, 15));
					end
				else if (CurCell.Pg = 2) & (CurCell.Num = 272) then
					begin
						Str1 := ' ';
						Str2 := GetCellString(CurWPtr, mc(2, 272));

						DNC := Result2Cell(Str1, mc(5, 14));		{set the checkmark}
						DNC := Result2Cell(Str2, mc(5, 15));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 14) then
					begin
						Str1 := GetCellString(CurWPtr, mc(5, 14));
						Str2 := ' ';
						DNC := Result2Cell(Str1, mc(2, 271));		{set the checkmark}
						DNC := Result2Cell(Str2, mc(2, 272));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 15) then
					begin
						Str1 := ' ';
						Str2 := GetCellString(CurWPtr, mc(5, 15));
						DNC := Result2Cell(Str1, mc(2, 271));		{set the checkmark}
						DNC := Result2Cell(Str2, mc(2, 272));
					end;
			end;
		InspectProperty := 0;
	end;

	function xInspectProperty: Integer;
		var
			DNC: Integer;
	begin
		with docPeek(CurWPtr)^.docCurCell do
			begin
				if (CurCell.Pg = 2) & (CurCell.Num = 271) then
					begin
						DNC := Result2Cell('X', mc(5, 14));		{set the checkmark}
						DNC := Result2Cell(' ', mc(5, 15));
					end
				else if (CurCell.Pg = 2) & (CurCell.Num = 272) then
					begin
						DNC := Result2Cell(' ', mc(5, 14));		{set the checkmark}
						DNC := Result2Cell('X', mc(5, 15));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 14) then
					begin
						DNC := Result2Cell('X', mc(2, 271));		{set the checkmark}
						DNC := Result2Cell(' ', mc(2, 272));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 15) then
					begin
						DNC := Result2Cell(' ', mc(2, 271));		{set the checkmark}
						DNC := Result2Cell('X', mc(2, 272));
					end;
			end;
		xInspectProperty := 0;
	end;

	function FillInAppraiserInfo: Integer;
		var
			N: Integer;
		procedure Str2Cell (Cell: CellID; Str: Str255);
		begin
			if BitTst(@AppPref, useUpperCase) then
				UprString(Str, False);
			SetCellStr(CurWPtr, Cell, Str);
			DisplayCellStr(CurWPtr, Cell, Str);
		end;
	begin
		N := AppLicenseeIndex;
		Str2Cell(mc(5, 4), MacAppUser.User[N].CertNo);
		Str2Cell(mc(5, 5), MacAppUser.User[N].LicNo);
		Str2Cell(mc(5, 6), MacAppUser.State);
		Str2Cell(mc(5, 7), MacAppUser.User[N].ExpDate);

		Str2Cell(mc(2, 267), MacAppUser.User[N].CertNo);
		Str2Cell(mc(2, 269), MacAppUser.User[N].LicNo);
		if Length(MacAppUser.User[N].CertNo) > 0 then
			begin
				Str2Cell(mc(2, 268), MacAppUser.State);
				Str2Cell(mc(2, 270), ' ');
			end
		else if Length(MacAppUser.User[N].LicNo) > 0 then
			begin
				Str2Cell(mc(2, 268), ' ');
				Str2Cell(mc(2, 270), MacAppUser.State);
			end;

		FillInAppraiserInfo := 0;
	end;

	function FillInReviewerInfo: Integer;
	begin
		FillInReviewerInfo := 0;
	end;


*)

{**********************************}
{       URAR Report Math           }
{**********************************}
function F0001InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get4CellSumR(doc, CX, 67, 68, 69, 70);
  V1 := V1 + GetCellValue(doc, MCX(CX,72));
  result := SetInfoCellValue(doc, mcx(cx,2), V1);
end;

function F0001InfoSiteTotalRatio(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, 5));   //est site value
  v2 := GetCellValue(doc, mcx(cx, 28));  //total by cost approach
  if (V1 <> 0) and (V2 <> 0) then
    begin
      VR := (V1 / V2) * 100;
      SetInfoCellValue(doc, mcx(cx,2), VR);
    end;
  result := 0;
end;

//Sum total rooms
function F0001SumTotalRooms(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get4CellSumR(doc, CX, 191, 192, 193, 194);
  VR := VR + Get4CellSumR(doc, CX, 195, 196, 197, 0);
  VR := VR + Get4CellSumR(doc, CX, 203, 204, 205, 206);
  VR := VR + Get4CellSumR(doc, CX, 207, 208, 209, 0);
  VR := VR + Get4CellSumR(doc, CX, 216, 217, 218, 219);
  VR := VR + Get4CellSumR(doc, CX, 220, 221, 222, 0);
  result := SetCellValue(doc, MCX(cx, 227), VR);
end;

function F0001FeeSimpleLeaseHold(doc: TContainer; CX: CellUID): Integer;
var
  tStr: String;
begin
  tStr := '';
  if CellIsChecked(doc, mcx(cx, 21)) then
    tStr := 'Fee Simple'
  else if CellIsChecked(doc, mcx(cx,22)) then
    tStr := 'Leasehold';
  result := SetCellString(doc, MCFX(CX.form, 2, 38), tStr);
end;

function F0001Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: String;
  V1: Integer;
begin
  if CellIsChecked(doc, mcx(cx,260)) then
    begin
      V1 := Trunc(GetCellValue(doc, mcx(cx, 259)));
      if (V1 = 0) then
        tmpStr := 'Fireplace'
      else
        begin
          tmpStr := IntToStr(V1);
          tmpStr := Concat(tmpStr, ' Fireplace');
        end;
      if V1 > 1 then
        tmpStr := concat(tmpStr, 's');

      result := SetCellString(doc, MCFX(CX.form, 2, 57), tmpStr);  //transfer to grid
    end
  else  //not checked, did they type in # of fireplaces?
    begin
      V1 := Trunc(GetCellValue(doc, mcx(cx, 259)));
      if (V1 >= 1) then
        begin
          tmpStr := IntToStr(V1);
          tmpStr := Concat(tmpStr, ' Fireplace');
          if V1 > 1 then
            tmpStr := concat(tmpStr, 's');
          SetCellChkMark(doc, mcx(cx,260), True);   {set the checkmark}
        end

      else //no number, so get the text if any
        tmpStr := GetCellString(doc, mcx(CX, 259));	{no number, just transfer}

      result := SetCellString(doc, MCFX(CX.form, 2, 57), tmpStr); //transfer to grid
    end;
end;

function F0001FencePool(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: string;
begin
  result := 0;
  tmpStr := '';
  if CellIsChecked(doc, mcx(CX, 268)) then
    tmpStr := 'Fence';
  if CellIsChecked(doc, mcx(CX, 270)) then
    if length(tmpStr) > 0 then
      tmpStr := Concat(tmpStr, ',', 'Pool')
    else
      tmpStr := 'Pool';

  if length(tmpStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,2,58), tmpStr); //transfer to grid
end;

function F0001PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: string;
begin
  result := 0;
  tmpStr := '';
  if CellIsChecked(doc, mcx(CX, 262)) then
    tmpStr := 'Patio';
  if CellIsChecked(doc, mcx(CX, 264)) then
    if length(tmpStr) > 0 then
      tmpStr := Concat(tmpStr, ',', 'Deck')
    else
      tmpStr := 'Deck';
  if CellIsChecked(doc, mcx(CX, 266)) then
    if length(tmpStr) > 0 then
      tmpStr := Concat(tmpStr, ',', 'Porch')
    else
      tmpStr := 'Porch';

  if length(tmpStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,2,56), tmpStr); //transfer to grid
end;

function F0001NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  result := 0;
  if CellIsChecked(doc, mcx(CX, 274)) then
    begin
      SetCellString(doc, MCX(CX, 275), '');
      SetCellString(doc, MCX(CX, 276), '');
      SetCellString(doc, MCX(CX, 277), '');
      SetCellString(doc, MCX(CX, 278), '');
      SetCellString(doc, MCX(CX, 279), '');
      SetCellString(doc, MCX(CX, 280), '');
      result := SetCellString(doc, MCFX(CX.form,2,55), 'None'); //transfer to grid
    end;
end;

function F0001CarGarage(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr, NCarStr, resultStr: string;
  NCars: Integer;
begin
  result := 0;
  NCars := Trunc(GetCellValue(doc, mcx(CX, 275)));
  if NCars > 0 then begin
    NCarStr := IntToStr(NCars);
    resultStr := '';
    if CellHasData(doc, mcx(cx,276)) then
      begin
        tmpStr := GetCellString(doc, mcx(cx,276));
        if compareText(tmpStr, 'yes')=0 then
          resultStr := Concat(NCarStr, ' Car Gar. Att.');
      end

    else if CellHasData(doc, mcx(cx,277)) then
      begin
        tmpStr := GetCellString(doc, mcx(cx,277));
        if compareText(tmpStr, 'yes')=0 then
          resultStr := Concat(NCarStr, ' Car Gar. Detch.');
      end

    else if CellHasData(doc, mcx(cx,278)) then
      begin
        tmpStr := GetCellString(doc, mcx(cx,278));
        if compareText(tmpStr, 'yes')=0 then
          resultStr := Concat(NCarStr, ' Car Gar. Blt-In');
      end

    else if CellHasData(doc, mcx(cx,279)) then
      begin
        tmpStr := GetCellString(doc, mcx(cx,279));
        if compareText(tmpStr, 'yes')=0 then
          resultStr := Concat(NCarStr, ' Car Carport');
      end

    else if CellHasData(doc, mcx(cx,280)) then
      begin
        tmpStr := GetCellString(doc, mcx(cx,280));
        if compareText(tmpStr, 'yes')=0 then
          resultStr := Concat(NCarStr, ' Car Driveway');
      end;

    if length(resultStr)=0 then
      resultStr := Concat(NCarStr, ' Car');

    if CellIsChecked(doc, MCX(cx,274)) Then
      SetCellChkMark(doc, MCX(cx,274), False);    //make sure we uncheck None for cars

    result := SetCellString(doc, MCFX(CX.form,2,55), resultStr); //transfer to grid
  end;
end;

function F0001HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  heatStr, coolStr: string;
begin
  heatStr := GetCellString(doc, mcx(cx, 239));			{Heat type}
  if Length(heatStr) = 0 then
    heatStr := 'None';

  coolStr := GetCellString(doc, mcx(cx, 242));			{cool type}
  if EquivStr(coolStr, 'None', 'No', 'xx') then				{if none get other}
    begin
      coolStr := GetCellString(doc, mcx(cx, 243));
      if EquivStr(coolStr, 'None', 'No', 'xx') then
        coolStr := 'None';
    end;

  coolStr := Concat(heatStr, '/', coolStr);

  result := SetCellString(doc, MCFX(CX.form,2,53), coolStr); //transfer to grid
end;

function F0001BaseNSqFt(doc: TContainer; CX: CellUID): string;
var
  S1, S2: string;
begin
  result := '';
  S1 := GetCellString(doc, mcx(cx, 157));			{bsmt sqft}
  S2 := GetCellString(doc, mcx(cx, 152));			{bsmt descript}
  if GoodNumber(S1) then
    begin
      result := S1;
      if appPref_AppraiserAddBsmtSFSuffix then
        result := S1+' sf';
      if EquivStr(S2,'Full','Partial','xx') then
        result := S2 + '/' + result;
    end;
end;

//When they type in basement description...
function F0001BsmtDescript(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: string;
begin
  result := 0;
  tmpStr := GetCellString(doc, cx);
  if EquivStr(tmpStr, 'None', 'no', 'N/A') then
    begin
      SetCellString(doc, MCX(cx,157), 'N/A');
      SetCellString(doc, MCX(cx,158), 'N/A');
      SetCellString(doc, MCX(cx,159), 'N/A');
      SetCellString(doc, MCX(cx,160), 'N/A');
      SetCellString(doc, MCX(cx,161), 'N/A');
      SetCellString(doc, MCX(cx,162), 'N/A');
    end
  else
    begin
      tmpStr := F0001BaseNSqFt(doc, cx);
      if not EmptyStr(tmpStr) then
        result := SetCellString(doc, MCFX(CX.form,2,50), tmpStr); //transfer to grid
    end;
end;

//Local context will transfer actual value
function F0001BsmtSqFeet(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  tmpStr: string;
  V1: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx, 157));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 2,9), 'Bsmt.');			{trans Base. to cost appraoach}
      SetCellValue(doc, MCPX(CX, 2,10), V1);

      tmpStr := F0001BaseNSqFt(doc, cx);                   //trans to grid
      if Length(tmpStr) > 0 then
        result := SetCellString(doc, MCPX(CX,2,50), tmpStr); 	{transfer to grid}
    end;
end;

function F0001NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 253), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 254), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 255), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 256), False);    //floor
      SetCellChkMark(doc, mcx(CX, 257), False);    //heated
      SetCellChkMark(doc, mcx(CX, 258), False);    //finished
    end;
  result := 0;
end;

function F0001EffNActAge(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr, effStr: string;
begin
  result := 0;
  tmpStr := GetCellString(doc, mcx(cx, 141));
  if Length(tmpStr) > 0 then
    tmpStr := Concat(tmpStr, 'a');

  effStr := GetCellString(doc, mcx(cx, 142));
  if Length(effStr) > 0 then
    effStr := Concat(effStr, 'e');

  if (Length(tmpStr) > 0) or (Length(effStr) > 0) then
    begin
      if (Length(tmpStr) > 0) and (Length(effStr) > 0) then
        tmpStr := Concat(tmpStr, '/', effStr)
      else if Length(effStr) > 0 then
        tmpStr := effStr;

      result := setCellString(doc, MCFX(CX.form,2, 44), tmpStr);	{trans act Age & eff Age}
    end;
end;

function F0001AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
begin
  result := 0;
  S1 := GetCellString(doc, MCFX(CX.form,1,142));   //eff age
  S2 := GetCellString(doc, MCFX(CX.form,2,30));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      result := SetCellValue(doc, MCFX(CX.form,2, 19), VR);
    end;
end;

function F0001Deprication(doc: TContainer; CX: CellUID): Integer;
//var
//  V1,V2,V3,VR, CostNew: double;
//  lastCmd: Integer;
begin
(*
  V1 := GetCellValue(doc, mcx(cx, 18));		{Phy Depr percent}
  V2 := GetCellValue(doc, mcx(cx, 20));		{Funt Depr percent}
  V3 := GetCellValue(doc, mcx(cx, 22));		{Ext Depr percent}
  CostNew := GetCellValue(CurWPtr, mcx(cx, 16));

  if Val[1] <> 0 then
    begin
      Val[4] := CostNew * (Val[1] / 100);				{phy depr}
      CellResult := Val[4];
      CellParm := GetCellParm(CurWPtr, mcx(cx, 18));
      lastCmd := Result2Cell(FormatNumber(CellResult, CellParm), MC(2, 18));
    end;

  if Val[2] <> 0 then
    begin
      Val[5] := (CostNew - Val[4]) * (Val[2] / 100);			{funct depr}
      CellResult := Val[5];
      CellParm := GetCellParm(CurWPtr, mcx(cx, 20));
      lastCmd := Result2Cell(FormatNumber(CellResult, CellParm), MC(2, 20));
    end;

  if Val[3] <> 0 then
    begin
      Val[6] := (CostNew - Val[4] - Val[5]) * (Val[3] / 100); 	{ext depr}
      CellResult := Val[6];
      CellParm := GetCellParm(CurWPtr, mcx(cx, 22));
      lastCmd := Result2Cell(FormatNumber(CellResult, CellParm), MC(2, 22));
    end;

  Depreciation := 115;		{Sum the depreciations}
*)
  result := 28;
end;

function F0001CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,21));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,18));    //new cost
  V3 := GetCellValue(doc, mcx(cx,20));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,22), VR);
    end;
end;

//calc external depr
function F0001CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,23));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,18));    //new cost
  V3 := GetCellValue(doc, mcx(cx,20));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,22));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,24), VR);
    end;
end;

//Function depr percent
function F0001CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,22));    //funct depr
  V2 := GetCellValue(doc, mcx(cx,18));    //new cost
  V3 := GetCellValue(doc, mcx(cx,20));    //Phy Depr
  if (V2-V3) > 0 then
    begin
      VR := V1/(V2-V3)*100;
      result := SetCellValue(doc, mcx(cx,21), VR);
    end;
end;

function F0001CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,24));    //extrn depr
  V2 := GetCellValue(doc, mcx(cx,18));    //new cost
  V3 := GetCellValue(doc, mcx(cx,20));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,22));    //Funct Depr
  if V3 < 0 then V3 := 0;
  if V4 < 0 then V4 := 0;
  if (V2-V3-V4)>0 then
    begin
      VR := (V1/(V2-V3-V4))*100;
      result := SetCellValue(doc, mcx(cx,23), VR);
    end;
end;

function F0001C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 64;
  TotalAdj  = 119;
  FinalAmt  = 120;
  PlusChk   = 117;
  NegChk    = 118;
  InfoNet   = 5;
  InfoGross = 6;
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
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx,TotalAdj), NetAdj);           //set sum of Adj
  if (NetAdj>=0) then
    SetCellChkMark(doc, mcx(cx,PlusChk), True)          //toggle the checkmarks3
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

function F0001C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 124;
  TotalAdj  = 179;
  FinalAmt  = 180;
  PlusChk   = 177;
  NegChk    = 178;
  InfoNet   = 7;
  InfoGross = 8;
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
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
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

function F0001C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 184;
  TotalAdj  = 239;
  FinalAmt  = 240;
  PlusChk   = 237;
  NegChk    = 238;
  InfoNet   = 9;
  InfoGross = 10;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);

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


{**********************************}
{  URAR EXtra Comparables Math     }
{**********************************}
function F0002C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 48;
  TotalAdj  = 103;
  FinalAmt  = 104;
  PlusChk   = 101;
  NegChk    = 102;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);

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

function F0002C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 109;
  TotalAdj  = 164;
  FinalAmt  = 165;
  PlusChk   = 162;
  NegChk    = 163;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);
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

function F0002C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 170;
  TotalAdj  = 225;
  FinalAmt  = 226;
  PlusChk   = 223;
  NegChk    = 224;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);

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

{**********************************}
{  Condo/PUD94 Report              }
{**********************************}

//transfer address & unit to comps subj address
function F0007AddressUnit(doc: TContainer; CX: CellUID): Integer;
Var
  S1,S2,SR: String;
begin
  SR := '';
  S1 := GetCellString(doc, mcx(cx,6));
  S2 := GetCellString(doc, mcx(cx,12));
  if (length(S1)>0) and (length(S2)>0) then
    SR := S1 + ', '+ S2
  else if (length(S1)>0) then
    SR := S1
  else if (length(S2)>0) then
    SR := S2;
  result := SetCellString(doc, MCFX(CX.form, 2, 32), SR);
end;

function F0007InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := Get8CellSumR(doc, CX, 77,78,79,80,81,82,83,84);
  result := SetInfoCellValue(doc, mcx(cx,2), V1);
end;

function F0007FeeSimpleLeaseHold(doc: TContainer; CX: CellUID): Integer;
var
  tStr: String;
begin
  if CellIsChecked(doc, mcx(cx, 25)) then
    tStr := 'Fee Simple'
  else if CellIsChecked(doc, mcx(cx,26)) then
    tStr := 'Leasehold';
  result := SetCellString(doc, MCFX(CX.form, 2, 39), tStr);
end;

//Sum total rooms
function F0007SumTotalRooms(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := Get4CellSumR(doc, CX, 202,203,204,205);
  VR := VR + Get4CellSumR(doc, CX, 206,207,208, 0);
  VR := VR + Get4CellSumR(doc, CX, 214,215,216,217);
  VR := VR + Get4CellSumR(doc, CX, 218,219,220, 0);
  VR := VR + Get4CellSumR(doc, CX, 227,228,229,230);
  VR := VR + Get4CellSumR(doc, CX, 231,232,233, 0);
  result := SetCellValue(doc, MCX(cx, 238), VR);
end;

function F0007EffNActAge(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr, effStr: string;
begin
  result := 0;
  tmpStr := GetCellString(doc, mcx(cx, 142));
  if Length(tmpStr) > 0 then
    tmpStr := Concat(tmpStr, 'a');

  effStr := GetCellString(doc, mcx(cx, 143));
  if Length(effStr) > 0 then
    effStr := Concat(effStr, 'e');

  if (Length(tmpStr) > 0) or (Length(effStr) > 0) then
    begin
      if (Length(tmpStr) > 0) and (Length(effStr) > 0) then
        tmpStr := Concat(tmpStr, '/', effStr)
      else if Length(effStr) > 0 then
        tmpStr := effStr;

      result := setCellString(doc, MCFX(CX.form,2, 48), tmpStr);	{trans act Age & eff Age}
    end;
end;

function F0007Location(doc: TContainer; CX: CellUID): Integer;
var
  LocStr: String;
begin
  LocStr := '';
  result := 0;
  if CellIsChecked(doc, mcx(cx, 35)) then
    LocStr := 'Urban'

  else if CellIsChecked(doc, mcx(cx, 36)) then
    LocStr := 'Suburban'

  else if CellIsChecked(doc, mcx(cx, 37)) then
    LocStr := 'Rural';

  if Length(LocStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,2,38), LocStr);
end;

function F0007ProjectType(doc: TContainer; CX: CellUID): Integer;
var
  PrjStr: String;
begin
  PrjStr := '';
  result := 0;
  if CellIsChecked(doc, mcx(cx, 170)) then
    PrjStr := 'Pri Residence'

  else if CellIsChecked(doc, mcx(cx, 171)) then
    PrjStr := 'Recreation'

  else if CellIsChecked(doc, mcx(cx, 172)) then
    PrjStr := 'Townhouse'

  else if CellIsChecked(doc, mcx(cx, 173)) then
    PrjStr := 'Garden'

  else if CellIsChecked(doc, mcx(cx, 174)) then
    PrjStr := 'Midrise'

  else if CellIsChecked(doc, mcx(cx, 175)) then
    PrjStr := 'Highrise'

  else if CellIsChecked(doc, mcx(cx, 176)) then   //other
    PrjStr := GetCellString(doc, cx);

  if Length(PrjStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,2,43), PrjStr);
end;

//Identical to F0001Fireplaces for URAR
function F0007Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: String;
  V1: Integer;
begin
  if CellIsChecked(doc, mcx(cx,262)) then
    begin
      V1 := Trunc(GetCellValue(doc, mcx(cx, 261)));
      if (V1 = 0) then
        tmpStr := 'Fireplace'
      else
        begin
          tmpStr := IntToStr(V1);
          tmpStr := Concat(tmpStr, ' Fireplace');
        end;
      if V1 > 1 then
        tmpStr := concat(tmpStr, 's');

      result := SetCellString(doc, MCFX(CX.form, 2, 61), tmpStr);  //transfer to grid
    end
  else  //not checked, did they type in # of fireplaces?
    begin
      V1 := Trunc(GetCellValue(doc, mcx(cx, 261)));
      if (V1 >= 1) then
        begin
          tmpStr := IntToStr(V1);
          tmpStr := Concat(tmpStr, ' Fireplace');
          if V1 > 1 then
            tmpStr := concat(tmpStr, 's');
          SetCellChkMark(doc, mcx(cx,262), True);   {set the checkmark}
        end

      else //no number, so get the text if any
        tmpStr := GetCellString(doc, mcx(CX, 261));	{no number, just transfer}

      result := SetCellString(doc, MCFX(CX.form, 2, 61), tmpStr); //transfer to grid
    end;
end;

function F0007NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  result := 0;
  if CellIsChecked(doc, mcx(cx,276)) then
    begin
      EraseCell(doc, mcx(cx,277));
      EraseCell(doc, mcx(cx,278));
      EraseCell(doc, mcx(cx,279));
      EraseCell(doc, mcx(cx,280));
      EraseCell(doc, mcx(cx,281));
      EraseCell(doc, mcx(cx,282));
      result := SetCellString(doc, MCFX(CX.form, 2, 59), 'None');			{transfer 'None'}
    end;
end;

function F0007HasGarageStorage(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: String;
  NCars: LongInt;
begin
  tmpStr := '';
  if CellHasData(doc, mcx(cx,278)) then				{Garage}
    begin
      SetCellChkMark(doc, mcx(cx,276), False);  //erase None checkbox
      SetCellChkMark(doc, mcx(cx,277), True);   //set garage chkbox

      NCars := Trunc(GetCellValue(doc, mcx(cx,278)));				{number of cars}
      if NCars > 0 then
        tmpStr := IntToStr(NCars) + ' Car Garage'   //#cars Garage
      else
        tmpStr := GetCellString(doc, mcx(cx,278));   //who knows what they typed
    end;
  result := SetCellString(doc, MCFX(CX.form, 2, 59), tmpStr);	{transfer '#Cars & Kind'}
end;

function F0007HasOpenStorage(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: String;
  NCars: LongInt;
begin
  tmpStr := '';
  if CellHasData(doc, mcx(cx,280)) then				{open storage}
    begin
      SetCellChkMark(doc, mcx(cx,276), False);  //erase None checkbox
      SetCellChkMark(doc, mcx(cx,279), True);   //set garage chkbox

      NCars := Trunc(GetCellValue(doc, mcx(cx,280)));	 {number of cars}
      if NCars > 0 then
        tmpStr := IntToStr(NCars) + ' Car Open'   //#cars Open Space
      else
        tmpStr := GetCellString(doc, mcx(cx,280));   //who knows what they typed
    end;
  result := SetCellString(doc, MCFX(CX.form, 2, 59), tmpStr);	{transfer '#Cars & Kind'}
end;

//Identical to URAR
function F0007HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  heatStr, coolStr: string;
begin
  heatStr := GetCellString(doc, mcx(cx, 248));			{Heat type}
  if Length(heatStr) = 0 then
    heatStr := 'None';

  coolStr := GetCellString(doc, mcx(cx, 251));			{cool type}
  if EquivStr(coolStr, 'None', 'No', 'xx') then				{if none get other}
    begin
      coolStr := GetCellString(doc, mcx(cx, 252));
      if EquivStr(coolStr, 'None', 'No', 'xx') then
        coolStr := 'None';
    end;

  coolStr := Concat(heatStr, '/', coolStr);

  result := SetCellString(doc, MCFX(CX.form,2,57), coolStr); //transfer to grid
end;

function F0007PatioBalcony(doc: TContainer; CX: CellUID): Integer;
var
  tmpStr: string;
begin
  result := 0;
  tmpStr := '';
  if CellIsChecked(doc, mcx(CX, 264)) then
    tmpStr := 'Patio';
  if CellIsChecked(doc, mcx(CX, 266)) then
    if length(tmpStr) > 0 then
      tmpStr := Concat(tmpStr, ',', 'Balcony')
    else
      tmpStr := 'Balcony';

  if length(tmpStr) > 0 then
    result := SetCellString(doc, MCFX(CX.form,2,60), tmpStr); //transfer to grid
end;

function F0007UtilityList(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx,11)) then
    begin
      SetCellChkMark(doc, mcx(cx,12), False);
      SetCellChkMark(doc, mcx(cx,13), False);
      SetCellChkMark(doc, mcx(cx,14), False);
      SetCellChkMark(doc, mcx(cx,15), False);
      SetCellChkMark(doc, mcx(cx,16), False);
      SetCellChkMark(doc, mcx(cx,17), False);
    end;
  result := 0;
end;

function F0007C1Adjustments(doc: TContainer; CX: CellUID): Integer;
const
  SalesAmt  = 67;
  TotalAdj  = 128;
  FinalAmt  = 129;
  PlusChk   = 126;
  NegChk    = 127;
  InfoNet   = 4;
  InfoGross = 5;
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
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
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

function F0007C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 133;
  TotalAdj  = 194;
  FinalAmt  = 195;
  PlusChk   = 192;
  NegChk    = 193;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);

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

function F0007C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 199;
  TotalAdj  = 260;
  FinalAmt  = 261;
  PlusChk   = 258;
  NegChk    = 259;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,206), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,208), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,233), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,237), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,239), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,241), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,243), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,245), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,247), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,249), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,251), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,253), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,255), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,257), NetAdj, GrsAdj);

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

{**********************************}
{  Condo/PUD94 EXtra Comps         }
{**********************************}
function F0008C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 50;
  TotalAdj  = 111;
  FinalAmt  = 112;
  PlusChk   = 109;
  NegChk    = 110;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,84), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,88), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);

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

function F0008C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 117;
  TotalAdj  = 178;
  FinalAmt  = 179;
  PlusChk   = 176;
  NegChk    = 177;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);

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

function F0008C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 184;
  TotalAdj  = 245;
  FinalAmt  = 246;
  PlusChk   = 243;
  NegChk    = 244;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);

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

//Vacant Land calcs Comp1
function F0011C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 34;
  TotalAdj  = 75;
  FinalAmt  = 76;
  PlusChk   = 73;
  NegChk    = 74;
  InfoNet   = 4;
  InfoGross = 5;
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
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
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

//Vacant Land calcs Comp2
function F0011C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 80;
  TotalAdj  = 121;
  FinalAmt  = 122;
  PlusChk   = 119;
  NegChk    = 120;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
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

//Vacant Land calcs Comp3
function F0011C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 126;
  TotalAdj  = 167;
  FinalAmt  = 168;
  PlusChk   = 165;
  NegChk    = 166;
  InfoNet   = 8;
  InfoGross = 9;
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
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
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

//Vacant Land Extra Comp1
function F0012C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 44;
  TotalAdj  = 85;
  FinalAmt  = 86;
  PlusChk   = 83;
  NegChk    = 84;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,47), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,49), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
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

//Vacant Land Extra Comp2
function F0012C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 91;
  TotalAdj  = 132;
  FinalAmt  = 133;
  PlusChk   = 130;
  NegChk    = 131;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
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

//Vacant Land Extra Comp3
function F0012C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 138;
  TotalAdj  = 179;
  FinalAmt  = 180;
  PlusChk   = 177;
  NegChk    = 178;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
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

//Condo465B
function F0045SumAllPg1Expenses(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,V5,VR: Double;
begin
  V1 := Get8CellSumR(doc, cx, 14,15,17,19,20,22,23,27);
  V2 := Get8CellSumR(doc, cx, 28,29,30,32,33,34,35,36);
  V3 := Get8CellSumR(doc, cx, 37,38,39,40,41,42,44,46);
  V4 := Get8CellSumR(doc, cx, 47,48,49,50,54,55,56,57);
  V5 := Get4CellSumR(doc, cx, 58,60,0,0);
  VR := V1+V2+V3+V4+V5;
  result := SetCellValue(doc, mcx(cx,61), VR);  //total expenses
end;

function F0045SumAllPg2Expenses(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,V5,V6,VR: Double;
begin
  V1 := Get8CellSumR(doc, cx, 11,12,14,16,17,19,20,24);
  V2 := Get8CellSumR(doc, cx, 25,26,27,29,30,31,32,33);
  V3 := Get8CellSumR(doc, cx, 34,35,36,37,38,39,41,42);
  V4 := Get8CellSumR(doc, cx, 43,44,46,47,48,49,51,52);
  V5 := Get8CellSumR(doc, cx, 53,54,55,56,57,58,59,60);
  V6 := GetCellValue(doc, mcx(cx,62));
  VR := V1+V2+V3+V4+V5+V6;
  result := SetCellValue(doc, mcx(cx,63), VR);  //total expenses
end;

function F0121SubtractSum(doc: TContainer; CX: CellUID; C1,C2,C3,C4, CR: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  V2 := Get4CellSumR(doc, cx, C2,C3,C4,0);
  VR := V1 - V2;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function F0279SumDepr(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,52));
  V2 := GetCellValue(doc, mcx(cx,55));
  V3 := GetCellValue(doc, mcx(cx,58));
  VR := V1 - V2 - V3;
  result := SetCellValue(doc, mcx(cx,59), VR);
end;

function F0279C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, cx, 93,136,137,134,135,4,5,
            [98,100,102,104,106,107,111,113,115,117,119,121,123,125,127,129,131,133]);
end;

function F0279C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, cx, 141,184,185,182,183,6,7,
            [146,148,150,152,154,155,159,161,163,165,167,169,171,173,175,177,179,181]);
end;

function F0279C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, cx, 189,232,233,230,231,8,9,
            [194,196,198,200,202,203,207,209,211,213,215,217,219,221,223,225,227,229]);
end;

//github #668
function F1033C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,41));   //get the address
  result := SalesGridAdjustment(doc, cx, 44,99,100,97,98,2,3,
            [49,51,53,55,57,59,61,63,65,67,69,70,74,76,78,80,82,84,86,88,90,92,94,96],length(addr) > 0);
end;

function F1033C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,101));   //get the address
  result := SalesGridAdjustment(doc, cx, 104,159,160,157,158,4,5,
            [109,111,113,115,117,119,121,123,125,127,129,130,134,136,138,140,142,144,146,148,150,152,154,156], length(addr) > 0);
end;

function F1033C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
   addr := GetCellString(doc, mcx(cx,161));   //get the address
  result := SalesGridAdjustment(doc, cx, 164,219,220,217,218,6,7,
            [169,171,173,175,177,179,181,183,185,187,189,190,194,196,198,200,202,204,206,208,210,212,214,216], length(addr) > 0);
end;


//URAR form
function ProcessForm0001Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0001FeeSimpleLeaseHold(doc, CX);
        2:
          cmd := F0001Fireplaces(doc, CX);
        3:
          Cmd := F0001PatioDeckPorch(doc, CX);
        4:
          Cmd := F0001FencePool(doc, CX);
        5:
          Cmd := F0001NoCarGarage(doc, CX);
        6:
          Cmd := F0001CarGarage(doc, CX);
        7:
          Cmd := SiteDimension(doc, CX, MCX(cx,86));
        8:
          cmd := F0001HeatingCooling(doc, CX);
        9:
          cmd := F0001BsmtDescript(doc, CX);
        10:
          cmd := F0001BsmtSqFeet(doc, CX);
        11:
          cmd := SetCellChkMark(doc, mcx(CX, 252), False);    //make sure no Attic is not checked
        12:
          cmd := F0001NoAttic(doc, mcx(CX, 252));   //uncheck all attic options
        13:
          cmd := F0001EffNActAge(doc, CX);
        14:
          cmd := F0001AgeLifeDepr(doc, CX);   //enter econ life
        15:
          begin
            ProcessForm0001Math(doc, 13, CX);            //enter eff age
            cmd := ProcessForm0001Math(doc, 14, CX);
          end;
        16:
          cmd := F0001SumTotalRooms(doc, CX);
        17:
          begin
            ProcessForm0001Math(doc, 16, CX);
            cmd := SumFourCellsR(doc, CX, 197,209,222,0, 228);  //sum bedrooms
          end;
        18:
          cmd := SumFourCellsR(doc, CX, 198,210,223,0, 229);    //sum baths
        19:
          cmd := SumFourCellsR(doc, CX, 201,213,226,0, 230);    //sum sqft
        20:
          cmd := F0001InfoSumLandUse(doc, CX);   //put sum of land use in Info cell
        21:
          cmd := MultAB(doc, MCX(CX,6), MCX(CX,7), MCX(CX,8));    //mult dwelling
        22:
          cmd := MultAB(doc, MCX(CX,10), MCX(CX,11), MCX(CX,12));  //mult basement
        23:
          cmd := MultAB(doc, MCX(CX,15), MCX(CX,16), MCX(CX,17));  //mult garage
        24:
          cmd := SumFourCellsR(doc, cx, 8,12,14,17, 18);    //sum sqft
        25:
          cmd := SubtAB(doc, MCX(cx,18), mcx(cx,25), mcx(cx,26)); //subt depr.
        26:
          cmd := SumFourCellsR(doc, CX, 5,26,27,0, 28);   //sum all cost values
        27:
          cmd := F0001Deprication(doc, CX);          //total cost new
        28:
          Cmd := MultPercentAB(doc, MCPX(cx,2,19), MCPX(cx,2,18),MCPX(cx,2,20)) ; //phy dep precent entered
        29:
          Cmd := F0001CalcDeprLessPhy(doc, CX);        //funct dep precent entered
        30:
          Cmd := F0001CalcDeprLessPhyNFunct(doc, CX);  //external dep precent entered
        31:
          cmd := F0001CalcPctLessPhy(doc, cx);         //funct entered, calc percent
        32:
          cmd := F0001CalcPctLessPhyNFnct(doc, cx);    //extrn entered, calc percent
        33:
          cmd := SumFourCellsR(doc, CX, 20,22,24,0, 25);   //sum depr values

        34:  //phy dep amount entered
          begin
            CX.Pg := 1;   //make sure we are on 2nd page (zero based)
            PercentAOfB(doc, mcx(cx,20), mcx(cx,18), mcx(cx,19));    //recalc phy percent
            F0001CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0001CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0001Math(doc, 33, CX); //sum the deprs
          end;
        35:  //funct dep amount entered
          begin
            CX.Pg := 1;   //make sure we are on 2nd page (zero based)
            F0001CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0001CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0001Math(doc, 33, CX);  //sum the deprs
          end;
        36:  //extrn dep amount entered
          begin
            CX.Pg := 1;   //make sure we are on 2nd page (zero based)
            F0001CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0001Math(doc, 33, CX);  //sum the deprs
          end;
        37:
          cmd := F0001InfoSiteTotalRatio(doc, cx);
        38:
          cmd := MultAB(doc, mcx(cx,256), mcx(cx,257), mcx(cx,258));    //calc income approach
        39:
          cmd := DivideAB(doc, mcx(cx,33), mcx(cx,49), mcx(cx,34));     //sub price/sqft
//Comp1 calcs
        40:   //sales price changed
          begin
            ProcessForm0001Math(doc, 42, CX);       //calc new price/sqft
            Cmd := F0001C1Adjustments(doc, cx);     //redo the adjustments
          end;
        41:
          cmd := F0001C1Adjustments(doc, cx);       //sum of adjs
        42:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,95), mcx(cx,65));     //price/sqft

//Comp2 calcs
        43:   //sales price changed
          begin
            ProcessForm0001Math(doc, 45, CX);     //calc new price/sqft
            Cmd := F0001C2Adjustments(doc, cx);   //redo the adjustments
          end;
        44:
          cmd := F0001C2Adjustments(doc, cx);     //sum of adjs
        45:
          cmd := DivideAB(doc, mcx(cx,124), mcx(cx,155), mcx(cx,125));     //price/sqft

//Comp3 calcs
        46:   //sales price changed
          begin
            ProcessForm0001Math(doc, 48, CX);     //calc new price/sqft
            Cmd := F0001C3Adjustments(doc, cx);   //redo the adjustments
          end;
        47:
          cmd := F0001C3Adjustments(doc, cx);     //sum of adjs
        48:
          cmd := DivideAB(doc, mcx(cx,184), mcx(cx,215), mcx(cx,185));     //price/sqft

        49:
          cmd := TransA2B(doc, CX, mcx(CX, 266));   //transfer sales to final value
        50:
          cmd := CalcWeightedAvg(doc, [1,2]);   //calc wtAvg of main and xcomps forms
        51:
          begin
            F0001C1Adjustments(doc, cx);     //sum of adjs
            F0001C2Adjustments(doc, cx);     //sum of adjs
            F0001C3Adjustments(doc, cx);     //sum of adjs
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
          CX.pg := 0;    //math is on page 1
          ProcessForm0001Math(doc, 20, CX);
          CX.pg := 1;    //math is on page 2
          ProcessForm0001Math(doc, 41, CX);
          ProcessForm0001Math(doc, 44, CX);
          ProcessForm0001Math(doc, 47, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0001Math(doc, 51, CX);
        end;
    end;

  result := 0;
end;

//URAR Extra Comps
function ProcessForm0002Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0002Math(doc, 3, CX);       //calc new price/sqft
            Cmd := F0002C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0002C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0002Math(doc, 6, CX);     //calc new price/sqft
            Cmd := F0002C2Adjustments(doc, cx);   //redo the adjustments
          end;
        5:
          cmd := F0002C2Adjustments(doc, cx);     //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,109), mcx(cx,140), mcx(cx,110));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0002Math(doc, 9, CX);     //calc new price/sqft
            Cmd := F0002C3Adjustments(doc, cx);   //redo the adjustments
          end;
        8:
          cmd := F0002C3Adjustments(doc, cx);     //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,170), mcx(cx,201), mcx(cx,171));     //price/sqft
//Subject
        10:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,32), mcx(cx,17));     //Subj price/sqft
//dynamic form name
        11:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 44,105,166, 2);
        12:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 44,105,166);
        13:
          cmd := ConfigXXXInstance(doc, cx, 44,105,166);
        14:
          cmd := CalcWeightedAvg(doc, [1,2]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0002C1Adjustments(doc, cx);
            F0002C2Adjustments(doc, cx);     //sum of adjs
            F0002C3Adjustments(doc, cx);
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
          ProcessForm0002Math(doc, 2, CX);
          ProcessForm0002Math(doc, 5, CX);
          ProcessForm0002Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0002Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Condo94
function ProcessForm0007Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0007AddressUnit(doc, CX);
        2:
          cmd := F0007FeeSimpleLeaseHold(doc, CX);
        3:
          cmd := F0007InfoSumLandUse(doc, CX);   //put sum of land use in Info cell
        4:
          cmd := F0007SumTotalRooms(doc, CX);
        5:
          begin
            ProcessForm0007Math(doc, 4, CX);                    //sum all rooms
            cmd := SumFourCellsR(doc, CX, 208,220,233,0, 239);  //sum bedrooms
          end;
        6:
          cmd := SumFourCellsR(doc, CX, 209,221,234,0, 240);    //sum baths
        7:
          cmd := SumFourCellsR(doc, CX, 212,224,237,0, 241);    //sum sqft
        8:
          cmd := DivideAB(doc, mcx(cx,146), mcx(cx,164), mcx(cx,147));  //ratio park/units
        9:
          cmd := F0007EffNActAge(doc, cx);
        10:
          cmd := F0007Location(doc, cx);
        11:
          cmd := F0007ProjectType(doc, cx);
        12:
          cmd := F0007Fireplaces(doc, cx);
        13:
          cmd := F0007NoCarStorage(doc, cx);
        14:
          cmd := F0007HasGarageStorage(doc, cx);
        15:
          cmd := F0007HasOpenStorage(doc, cx);
        16:
          cmd := F0007HeatingCooling(doc, cx);
        17:
          cmd := F0007PatioBalcony(doc, cx);
        18:
          cmd := F0007UtilityList(doc, cx);
        19:
          cmd := MultAByVal(doc, mcx(cx,5), mcx(cx,6), 12.0);  //unit$/yr
        20:
          cmd := DivideAB(doc, MCFX(CX.form,2,6), MCFX(CX.form,1,241), MCFX(CX.form,2,7));
        21:
          cmd := MultAB(doc, mcx(cx,277), mcx(cx,278), mcx(cx,279));  //income appr
        22:
          cmd := DivideAB(doc, mcx(cx,34), mcx(cx,53), mcx(cx,35));     //Subj price/sqft
//Comp1 calcs
        23:   //sales price changed
          begin
            ProcessForm0007Math(doc, 25, CX);       //calc new price/sqft
            Cmd := F0007C1Adjustments(doc, cx);     //redo the adjustments
          end;
        24:
          cmd := F0007C1Adjustments(doc, cx);       //sum of adjs
        25:
          cmd := DivideAB(doc, mcx(cx,67), mcx(cx,106), mcx(cx,68));     //price/sqft

//Comp2 calcs
        26:   //sales price changed
          begin
            ProcessForm0007Math(doc, 28, CX);     //calc new price/sqft
            Cmd := F0007C2Adjustments(doc, cx);   //redo the adjustments
          end;
        27:
          cmd := F0007C2Adjustments(doc, cx);     //sum of adjs
        28:
          cmd := DivideAB(doc, mcx(cx,133), mcx(cx,172), mcx(cx,134));     //price/sqft

//Comp3 calcs
        29:   //sales price changed
          begin
            ProcessForm0007Math(doc, 31, CX);     //calc new price/sqft
            Cmd := F0007C3Adjustments(doc, cx);   //redo the adjustments
          end;
        30:
          cmd := F0007C3Adjustments(doc, cx);     //sum of adjs
        31:
          cmd := DivideAB(doc, mcx(cx,199), mcx(cx,238), mcx(cx,200));     //price/sqft

        32:
          cmd := TransA2B(doc, CX, mcx(CX,288));    //transfer sales to final value
        33:
          cmd := CalcWeightedAvg(doc, [7,8]);   //calc wtAvg of main and xcomps forms
        34:
          begin
            F0007C1Adjustments(doc, cx);       //sum of adjs
            F0007C2Adjustments(doc, cx);     //sum of adjs
            F0007C3Adjustments(doc, cx);     //sum of adjs
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
          ProcessForm0007Math(doc, 3, CX);
          CX.pg := 1;    //math is on page 2
          ProcessForm0007Math(doc, 24, CX);
          ProcessForm0007Math(doc, 27, CX);
          ProcessForm0007Math(doc, 30, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0007Math(doc, 34, CX);
        end;
    end;

  result := 0;
end;

//Condo94 XComnps
function ProcessForm0008Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0008Math(doc, 3, CX);       //calc new price/sqft
            Cmd := F0008C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0008C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,50), mcx(cx,89), mcx(cx,51));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0008Math(doc, 6, CX);     //calc new price/sqft
            Cmd := F0008C2Adjustments(doc, cx);   //redo the adjustments
          end;
        5:
          cmd := F0008C2Adjustments(doc, cx);     //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,117), mcx(cx,156), mcx(cx,118));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0008Math(doc, 9, CX);     //calc new price/sqft
            Cmd := F0008C3Adjustments(doc, cx);   //redo the adjustments
          end;
        8:
          cmd := F0008C3Adjustments(doc, cx);     //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,184), mcx(cx,223), mcx(cx,185));     //price/sqft
//subject
        10:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,35), mcx(cx,17));     //Subj price/sqft
//dynamic title setting
        11:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','ADDENDUM', 46,113,180, 2);   //43,104,165
        12:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Comparables', 46,113,180);
        13:
          cmd := ConfigXXXInstance(doc, cx, 46,113,180);
        14:
          cmd := CalcWeightedAvg(doc, [7,8]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0008C1Adjustments(doc, cx);     //sum of adjs
            F0008C2Adjustments(doc, cx);     //sum of adjs
            F0008C3Adjustments(doc, cx);     //sum of adjs
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
          ProcessForm0008Math(doc, 2, CX);
          ProcessForm0008Math(doc, 5, CX);
          ProcessForm0008Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0008Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Mobile Home
function ProcessForm0011Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0011Math(doc, 3, CX);     //calc new price/sqft
           cmd := F0011C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0011C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,34), mcx(cx,51), mcx(cx,35));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0011Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0011C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0011C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,80), mcx(cx,97), mcx(cx,81));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0011Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0011C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0011C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,126), mcx(cx,143), mcx(cx,127));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,17), mcx(cx,8));     //Subj price/sqft

        11:
          cmd := TransA2B(doc, CX, mcx(CX,187));    //transfer sales to final value
        12:
          Cmd := 0;   //BroadcastLenderAddress(doc, CX);
        13:
          cmd := CalcWeightedAvg(doc, [11,12]);   //calc wtAvg of main and xcomps forms
        15:
          Cmd := LandUseSum(doc, CX, 2, [56,57,58,59,60,61,62,63]);
        14:
          begin
            F0011C1Adjustments(doc, cx);       //sum of adjs
            F0011C2Adjustments(doc, cx);       //sum of adjs
            F0011C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0011Math(doc, 2, CX);
          ProcessForm0011Math(doc, 5, CX);
          ProcessForm0011Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0011Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

//Mobile Home Extra Comps
function ProcessForm0012Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', '',40,87,134, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 40,87,134);
        3:
          cmd := ConfigXXXInstance(doc, cx, 40,87,134);

//Comp1 calcs
        4:   //sales price changed
          begin
            ProcessForm0012Math(doc, 6, CX);     //calc new price/sqft
           cmd := F0012C1Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0012C1Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,44), mcx(cx,61), mcx(cx,45));     //price/sqft

//Comp2 calcs
        7:   //sales price changed
          begin
            ProcessForm0012Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0012C2Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0012C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,91), mcx(cx,108), mcx(cx,92));     //price/sqft

//Comp3 calcs
        10:   //sales price changed
          begin
            ProcessForm0012Math(doc, 12, CX);     //calc new price/sqft
            cmd := F0012C3Adjustments(doc, cx);     //redo the adjustments
          end;
        11:
          cmd := F0012C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := DivideAB(doc, mcx(cx,138), mcx(cx,155), mcx(cx,139));     //price/sqft

        13:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,26), mcx(cx,17));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [11,12]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0012C1Adjustments(doc, cx);       //sum of adjs
            F0012C2Adjustments(doc, cx);       //sum of adjs
            F0012C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0012Math(doc, 5, CX);
          ProcessForm0012Math(doc, 8, CX);
          ProcessForm0012Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0012Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Condo465a
function ProcessForm0044Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumEightCellsR(doc, CX, 13,25,37,49,61,73,85,97, 101);			{Dues}
        2:
          Cmd := SumEightCellsR(doc, CX, 14,26,38,50,62,74,86,98, 102);			{planned}
        3:
          Cmd := SumEightCellsR(doc, CX, 15,27,39,51,63,75,87,99, 103);			{sold}
        4:
          Cmd := SumEightCellsR(doc, CX, 16,28,40,52,64,76,88,100, 104);		{completed}
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Condo465b
function ProcessForm0045Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        {Page1}
        1:
          Cmd := SumFourCellsR(doc, CX, 24,25,26,0, 27);		{Utilities}
        2:
          Cmd := SumFourCellsR(doc, CX, 51,52,53,0, 54);		{Taxes}
        3:
          Cmd := SumEightCellsR(doc, CX, 65,69,73,77,81,85,89,0, 90);		{Replacements}
        4: 
          Cmd := SumAB(doc, mcx(cx,92), mcx(cx,93), mcx(cx,94));		{Condo Income}
        5:
          Cmd := F0045SumAllPg1Expenses(doc, cx);
        6:
          Cmd := SumAB(doc, mcx(cx,61), mcx(cx,90), mcx(cx,91));	{total annual expenses & replacment}
        7:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,63), mcx(cx,65));   {avg yeraly costs}
        8:
          cmd := DivideAB(doc, mcx(cx,68), mcx(cx,67), mcx(cx,69));
        9:
          cmd := DivideAB(doc, mcx(cx,72), mcx(cx,71), mcx(cx,73));
        10:
          cmd := DivideAB(doc, mcx(cx,76), mcx(cx,75), mcx(cx,77));
        11:
          cmd := DivideAB(doc, mcx(cx,80), mcx(cx,79), mcx(cx,81));
        12:
          cmd := DivideAB(doc, mcx(cx,84), mcx(cx,83), mcx(cx,85));
        13:
          cmd := DivideAB(doc, mcx(cx,88), mcx(cx,87), mcx(cx,89));

        {Page2}
        14:
          Cmd := MultABByVal(doc, mcx(cx,5), mcx(cx,6), mcx(cx,7),12.0);
        15:
          Cmd := SumAB(doc, mcx(cx,7), mcx(cx,9), mcx(cx,10));	{total Income}
        16:
          Cmd := SumABC(doc, mcx(cx,21), mcx(cx,22), mcx(cx,23), mcx(cx,24));		{Utilities-pg2}
        17:
          Cmd := SubtAB(doc,mcx(cx,10), mcx(cx,63), mcx(cx,64));	{total annual surplus/deficit}
        18:
          Cmd := F0045SumAllPg2Expenses(doc, cx);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


//PUD1
function ProcessForm0046Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumSixCellsR(doc, CX, 39,41,43,45,47,0, 48);
        2:
          Cmd := SumSixCellsR(doc, CX, 51,53,55,57,59,0, 60);
        3:
          Cmd := SumSixCellsR(doc, CX, 63,65,67,69,71,0, 72);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//PUD2
function ProcessForm0047Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumSixCellsR(doc, CX, 28,30,32,34,36,0, 37);
        2:
          Cmd := SumSixCellsR(doc, CX, 40,42,44,46,48,0, 49);
        3:
          Cmd := SumSixCellsR(doc, CX, 52,54,56,58,60,0, 61);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0121Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := MultAB(doc, mcx(cx,11), mcx(cx,12), mcx(cx,13));
        2:
          Cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));
        3:
          Cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));
        4:
          cmd := SumEightCellsR(doc,cx, 13,17,21,24,26,28,30,0, 31);
        5:
          cmd := MultAB(doc, mcx(cx,31),mcx(cx,32), mcx(cx,33));
        6:
          cmd := F0121SubtractSum(doc,cx, 33,34,35,36, 37);
        7:
          cmd := SumEightCellsR(doc,cx, 38,37,39,41,42,0,0,0, 43);
        8:
          cmd := RoundByVal(doc, mcx(cx,43), mcx(cx,44), 100);
        9:
          Cmd := MultAB(doc, mcx(cx,45), mcx(cx,46), mcx(cx,47));
        10:
          Cmd := MultAB(doc, mcx(cx,48), mcx(cx,49), mcx(cx,50));
        11:
          Cmd := MultAB(doc, mcx(cx,51), mcx(cx,52), mcx(cx,53));
        12:
          Cmd := MultAB(doc, mcx(cx,54), mcx(cx,55), mcx(cx,56));
        13:
          cmd := SumFourCellsR(doc,cx, 47,50,53,56, 57);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//manufactured home from david beccaria
function ProcessForm0279Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := MultABC(doc, mcx(cx,5), mcx(cx,6), mcx(cx,7), mcx(cx,8));
        2:
          cmd := MultABC(doc, mcx(cx,9), mcx(cx,10), mcx(cx,11), mcx(cx,12));
        3:
          cmd := MultABC(doc, mcx(cx,13), mcx(cx,14), mcx(cx,15), mcx(cx,16));
        4:
          cmd := MultABC(doc, mcx(cx,17), mcx(cx,18), mcx(cx,19), mcx(cx,20));
        5:
          cmd := SumCellArray(doc, cx, [8,12,16,20], 21);

        6:
          cmd := MultAB(doc, mcx(cx,23), mcx(cx,24), mcx(cx,25));
        7:
          cmd := MultAB(doc, mcx(cx,26), mcx(cx,27), mcx(cx,28));
        8:
          cmd := MultAB(doc, mcx(cx,29), mcx(cx,30), mcx(cx,31));
        9:
          cmd := MultAB(doc, mcx(cx,32), mcx(cx,33), mcx(cx,34));
        10:
          cmd := MultAB(doc, mcx(cx,35), mcx(cx,36), mcx(cx,37));
        11:
          cmd := MultAB(doc, mcx(cx,38), mcx(cx,39), mcx(cx,40));
        12:
          cmd := MultAB(doc, mcx(cx,41), mcx(cx,42), mcx(cx,43));
        13:
          cmd := MultAB(doc, mcx(cx,45), mcx(cx,46), mcx(cx,47));
        14:
          cmd := MultAB(doc, mcx(cx,49), mcx(cx,50), mcx(cx,51));
        15:
          cmd := SumCellArray(doc, cx, [25,28,31,34,37,40,43,47,51], 52);
        16:
          cmd := F0279SumDepr(doc, cx);
        17:
          cmd := MultPercentAB(doc, mcx(cx,54), mcx(cx,52), mcx(cx,55));  //phy depr
        18:
          cmd := SumAB(doc, mcx(cx,56), mcx(cx,57), mcx(cx,58));
        19:
          cmd := SumAB(doc, mcx(cx,59), mcx(cx,60), mcx(cx,61));
        20:
          cmd := ProcessMultipleCmds(ProcessForm0279Math, doc, cx, [16,17]);

        29:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,76), mcx(cx,65));

        30:
          cmd := ProcessMultipleCmds(ProcessForm0279Math, doc, cx, [31,32]);
        31:
          cmd := DivideAB(doc, mcx(cx,93), mcx(cx,112), mcx(cx,94));
        32:
          cmd := F0279C1Adjustments(doc, cx);

        33:
          cmd := ProcessMultipleCmds(ProcessForm0279Math, doc, cx, [34,35]);
        34:
          cmd := DivideAB(doc, mcx(cx,141), mcx(cx,160), mcx(cx,142));
        35:
          cmd := F0279C2Adjustments(doc, cx);

        36:
          cmd := ProcessMultipleCmds(ProcessForm0279Math, doc, cx, [37,38]);
        37:
          cmd := DivideAB(doc, mcx(cx,189), mcx(cx,208), mcx(cx,190));
        38:
          cmd := F0279C3Adjustments(doc, cx);
        39:
          cmd := CalcWeightedAvg(doc, [279,12]);   //calc wtAvg of main and xcomps forms
        40:
          cmd := MultAB(doc, mcx(cx,249), mcx(cx,250),mcx(cx,251));
        41:
          begin
            F0279C1Adjustments(doc, cx);
            F0279C2Adjustments(doc, cx);
            F0279C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 1
          ProcessForm0279Math(doc, 32, CX);
          ProcessForm0279Math(doc, 35, CX);
          ProcessForm0279Math(doc, 38, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 1
          ProcessForm0279Math(doc, 41, CX);
        end;
    end;

  result := 0;
end;

//one-unit residential appraisal desk review report
function ProcessForm1033Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3:
          cmd := DivideAB(doc, mcx(cx,9), mcx(cx,27), mcx(cx,10));

        7:
          cmd := ProcessMultipleCmds(ProcessForm1033Math, doc, cx, [4,10]);
        4:
          cmd := DivideAB(doc, mcx(cx,44), mcx(cx,75), mcx(cx,45));
        10:
          cmd := F1033C1Adjustments(doc, cx);

        8:
          cmd := ProcessMultipleCmds(ProcessForm1033Math, doc, cx, [5,11]);
        5:
          cmd := DivideAB(doc, mcx(cx,104), mcx(cx,135), mcx(cx,105));
        11:
          cmd := F1033C2Adjustments(doc, cx);

        9:
          cmd := ProcessMultipleCmds(ProcessForm1033Math, doc, cx, [6,12]);
        6:
          cmd := DivideAB(doc, mcx(cx,164), mcx(cx,195), mcx(cx,165));
        12:
          cmd := F1033C3Adjustments(doc, cx);

        13:
          cmd := CalcWeightedAvg(doc, [1033]);  //calc wtAvg of main
        14:
          begin
            F1033C1Adjustments(doc, cx);
            F1033C2Adjustments(doc, cx);
            F1033C3Adjustments(doc, cx);
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
          ProcessForm1033Math(doc, 10, CX);
          ProcessForm1033Math(doc, 11, CX);
          ProcessForm1033Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm1033Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

end.
