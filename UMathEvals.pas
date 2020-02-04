unit UMathEvals;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmVacantLand      = 9;
  fmVacLandXCmps    = 10;
  fmNonLenderVacantLand = 767;
  fmNonLenderLandXCmps = 768;
  LoanEval          = 49;
  RestrictBR        = 70;
  RestrcitHH        = 71;
  fmSummary         = 72;
  fmSummary07       = 74; //update to the previous summary
  fmSumryXCmps      = 76;
  PropEval          = 73;
  fmREValue1        = 153;
  fmReValue1XCmps   = 929;
  fmREValue2        = 156;
  fmReValue2XCmps   =930;
  fmUpdateValue     = 708;  //this from is exactly the same as #680 so use same math
  fmReCertValue     = 680;
  fmREOAddendum     = 683;
  fmREO2008         = 794;
  fmREO2008XLists   = 834;
  fmConstLoan       = 687;
  fmDeskSumXComps   = 615;
  fmRelsLand        = 889;
  fmShortFormAppraisal = 950;      //Short Form Appraisal
  fmShortFormXComps = 942;         //Short Form Appraisal
  fmTaxAppealAppraisal = 926;      //Tax Appeal Appraisal
  fmTaxAppealXComps = 958;         //Tax Appeal Appraisal extra comps
  fmDesktopSummary  = 613;         //Desktop Summary Appraisal Report
  fmRelsLand4028    = 4028;
  fmLenderAppraisal = 4157;
  fmLandLetterMain  = 4352;
  fmLandLetterXComp = 4353;


  function ProcessForm0009Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0010Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0049Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0070Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0071Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0072Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0073Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0076Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0153Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0929Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0156Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0930Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0680Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0683Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0687Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0074Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0767Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0794Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0834Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0615Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0889Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0950Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0926Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0942Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0958Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0613Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4028Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4157Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4352Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4353Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


(*
//Vacant land

	function CertPageAddress: Integer;							{Concat address for cert page}
		var
			Str: Str255;
	begin
		Str := GetCellString(CurWPtr, mc(1, 6));						{get address}

		TempStr := GetCellString(CurWPtr, mc(1, 7));				{get City}
		Str := Concat(Str, '; ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 9));				{get St}
		Str := Concat(Str, ', ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 10));				{get Zip}
		Str := Concat(Str, ' ', TempStr);

		CertPageAddress := Result2Cell(Str, mc(4, 1));
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
		Str2Cell(mc(4, 4), MacAppUser.User[N].CertNo);
		Str2Cell(mc(4, 5), MacAppUser.User[N].LicNo);
		Str2Cell(mc(4, 6), MacAppUser.State);
		Str2Cell(mc(4, 7), MacAppUser.User[N].ExpDate);

		FillInAppraiserInfo := 0;
	end;

	function InspectProperty: Integer;
		var
			DNC: Integer;
	begin
		with docPeek(CurWPtr)^.docCurCell do
			begin
				if (CurCell.Pg = 1) & (CurCell.Num = 264) then
					begin
						DNC := Result2Cell('X', mc(4, 14));		{set the checkmark}
						DNC := Result2Cell(' ', mc(4, 15));
					end
				else if (CurCell.Pg = 1) & (CurCell.Num = 265) then
					begin
						DNC := Result2Cell(' ', mc(4, 14));		{set the checkmark}
						DNC := Result2Cell('X', mc(4, 15));
					end
				else if (CurCell.Pg = 4) & (CurCell.Num = 14) then
					begin
						DNC := Result2Cell('X', mc(1, 264));		{set the checkmark}
						DNC := Result2Cell(' ', mc(1, 265));
					end
				else if (CurCell.Pg = 4) & (CurCell.Num = 15) then
					begin
						DNC := Result2Cell(' ', mc(1, 264));		{set the checkmark}
						DNC := Result2Cell('X', mc(1, 265));
					end;
			end;
		InspectProperty := 0;
	end;
*)

(*
//Loan Valuations

	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;


	function SumRooms: Integer;
	begin
		Val[1] := Sum4Cells(MC(1, 122), MC(1, 132), MC(1, 142), MC(0, 0));
		Val[2] := Sum4Cells(MC(0, 0), MC(1, 117), MC(1, 118), MC(1, 119));
		Val[3] := Sum4Cells(MC(1, 120), MC(1, 121), MC(1, 127), MC(1, 128));
		Val[4] := Sum4Cells(MC(1, 129), MC(1, 130), MC(1, 131), MC(1, 137));
		Val[5] := Sum4Cells(MC(1, 138), MC(1, 139), MC(1, 140), MC(1, 141));
		CellResult := Val[1] + Val[2] + val[3] + val[4] + val[5];
		CellParm := GetCellParm(CurWPtr, MC(1, 147));
		SumRooms := Result2Cell(FormatNumber(CellResult, CellParm), MC(1, 147));
	end;

	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					1: 
						Cmd := SumFourCells(MC(1, 123), MC(1, 133), MC(1, 143), MC(0, 0), MC(1, 149));	{Sum Baths}
					2: 
						Cmd := SumFourCells(MC(1, 122), MC(1, 132), MC(1, 142), MC(0, 0), MC(1, 148));	{Sum bedrms}
					3:
						Cmd := SumRooms;		{sum all rooms}
					4: 
						begin
							ProcessCurCellInfo(CurWPtr, 3);	{clicked in bedrooms, so sum beds, & Rms}
							ProcessCurCellInfo(CurWPtr, 2);
							Cmd := 0;
						end;
					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin
		case CompNum of
			1:
				ProcessCurCellInfo(WPtr, 0);
			2: 
				ProcessCurCellInfo(WPtr, 0);
			3: 
				ProcessCurCellInfo(WPtr, 0);
			4: 
				ProcessCurCellInfo(WPtr, 0);
			5: 
				ProcessCurCellInfo(WPtr, 0);
			6: 
				ProcessCurCellInfo(WPtr, 0);
		end;
	end;

	procedure DocMathInitalization (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
				ProcessCurCellInfo(WPtr, 0);		{comp1}
				ProcessCurCellInfo(WPtr, 0);		{comp2 }
				ProcessCurCellInfo(WPtr, 0);		{comp3 }
			end;
		if doPref(hasComps456) then
			begin
				ProcessCurCellInfo(WPtr, 0);		{comp4}
				ProcessCurCellInfo(WPtr, 0);		{comp5}
				ProcessCurCellInfo(WPtr, 0);		{comp6}
			end;
	end;

	procedure DocAdjustmentCalcs (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
				ProcessCurCellInfo(WPtr, 0);		{comp1 sqft adj}
				ProcessCurCellInfo(WPtr, 0);		{comp2 sqft adj}
				ProcessCurCellInfo(WPtr, 0);		{comp3 sqft adj}
			end;
		if doPref(hasComps456) then
			begin
				ProcessCurCellInfo(WPtr, 0);		{comp4 sqft adj}
				ProcessCurCellInfo(WPtr, 0);		{comp5 sqft adj}
				ProcessCurCellInfo(WPtr, 0);		{comp6 sqft adj}
			end;
	end;
*)


(*
//Property Evaluation

	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;

	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(1, 193));
		Val[2] := GetCellValue(CurWPtr, MC(1, 240));
		Val[3] := GetCellValue(CurWPtr, MC(1, 287));

		Val[4] := GetCellValue(CurWPtr, MC(4, 77));
		Val[5] := GetCellValue(CurWPtr, MC(4, 124));
		Val[6] := GetCellValue(CurWPtr, MC(4, 171));

		N := 0;
		for i := 1 to 6 do
			if val[i] <> 0 then
				N := N + 1;
		if N = 0 then
			CellResult := 0
		else
			CellResult := (Val[1] + val[2] + val[3] + Val[4] + val[5] + val[6]) / N;

		Result2InfoCell(1, 3, Num2Longint(CellResult));
		Result2InfoCell(4, 3, Num2Longint(CellResult));

		InfoSalesAverage := 0;
	end;

	function SumAdjustmentsC1: Integer;
	begin
		C1NetAdj := 0;
		C1GrsAdj := 0;
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 106));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 108));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 110));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 112));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 114));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 116));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 118));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 120));
		SetAdjValues(C1NetAdj, C1GrsAdj, MC(1, 122));

		CellResult := C1NetAdj;
		CellParm := GetCellParm(CurWPtr, MC(1, 125));
		SumAdjustmentsC1 := Result2Cell(FormatNumber(CellResult, CellParm), MC(1, 125));
	end;


	function SumAdjustmentsC2: Integer;
	begin
		C2NetAdj := 0;
		C2GrsAdj := 0;
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 133));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 135));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 137));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 139));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 141));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 143));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 145));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 147));
		SetAdjValues(C2NetAdj, C2GrsAdj, MC(1, 149));

		CellResult := C2NetAdj;
		CellParm := GetCellParm(CurWPtr, MC(1, 152));
		SumAdjustmentsC2 := Result2Cell(FormatNumber(CellResult, CellParm), MC(1, 152));
	end;

	function SumAdjustmentsC3: Integer;
	begin
		C3NetAdj := 0;
		C3GrsAdj := 0;
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 160));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 162));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 164));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 166));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 168));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 170));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 172));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 174));
		SetAdjValues(C3NetAdj, C3GrsAdj, MC(1, 176));

		CellResult := C3NetAdj;
		CellParm := GetCellParm(CurWPtr, MC(1, 179));
		SumAdjustmentsC3 := Result2Cell(FormatNumber(CellResult, CellParm), MC(1, 179));
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
{page 1}
					1: 
						Cmd := TransA2B(MC(1, 3), MC(1, 83));		{address}
					2: 
						Cmd := TransA2B(mc(1, 5), mc(1, 84));		{City}
					3: 
						Cmd := SiteDimension(mc(1, 55), mc(1, 56));		{Site dimensions}
					4: 
						Cmd := TransA2B(mc(1, 75), mc(1, 93));		{age}

					16: 
						Cmd := DivideAB(mc(1, 86), mc(1, 95), mc(1, 88));			{subPrice/Area}
					17: 
						Cmd := DivideAB(mc(1, 103), mc(1, 117), mc(1, 104));		{C1Price/Area}
					18: 
						Cmd := DivideAB(mc(1, 130), mc(1, 144), mc(1, 131));	{C2Price/Area}
					19: 
						Cmd := DivideAB(mc(1, 157), mc(1, 171), mc(1, 158));	{C3Price/Area}


					23: 
						Cmd := SumAB(mc(1, 103), mc(1, 125), mc(1, 126));			{C1 Adj Price}
					24: 
						Cmd := SumAB(mc(1, 130), mc(1, 152), mc(1, 153));			{C2 Adj Price}
					25: 
						Cmd := SumAB(mc(1, 157), mc(1, 179), mc(1, 180));			{C3 Adj Price}

					29: 
						Cmd := SetCheckMark(mc(1, 125), mc(1, 123), mc(1, 124));	{C1 adj chk boxes}
					30: 
						Cmd := SetCheckMark(mc(1, 152), mc(1, 150), mc(1, 151));	{C2 adj chk boxes}
					31: 
						Cmd := SetCheckMark(mc(1, 179), mc(1, 177), mc(1, 178));	{C3 adj chk boxes}


					41:
						Cmd := SumAdjustmentsC1;
					42: 
						Cmd := SumAdjustmentsC2;
					43: 
						Cmd := SumAdjustmentsC3;


					47: 				{sub sqft adj}
						begin
							ProcessCurCellInfo(CurWPtr, 16);					{sub price/area}
							ProcessCurCellInfo(CurWPtr, 69);					{C1 sqft adj}
							ProcessCurCellInfo(CurWPtr, 70);					{C2 sqft adj}
							ProcessCurCellInfo(CurWPtr, 71);					{C3 sqft adj}
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


					57: 				{Net Adj C1}
						begin
							ProcessCurCellInfo(CurWPtr, 23);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 29);			{Chk Box}
							cmd := 0;
						end;
					58: 				{Net Adj C2}
						begin
							ProcessCurCellInfo(CurWPtr, 24);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 30);			{Chk Box}
							cmd := 0;
						end;
					59: 				{Net Adj C3}
						begin
							ProcessCurCellInfo(CurWPtr, 25);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 31);			{Chk Box}
							cmd := 0;
						end;

					63: 				{Sale Price C1}
						begin
							ProcessCurCellInfo(CurWPtr, 23);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 17);			{price/sqft}
							cmd := 0;
						end;
					64: 				{Sale Price C2}
						begin
							ProcessCurCellInfo(CurWPtr, 24);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 18);			{price/sqft}
							cmd := 0;
						end;
					65: 				{Sale Price C3}
						begin
							ProcessCurCellInfo(CurWPtr, 25);			{sale - netAdj = adjPrice}
							ProcessCurCellInfo(CurWPtr, 19);			{price/sqft}
							cmd := 0;
						end;

					69: 
						cmd := SqFtAdjust(mc(1, 95), mc(1, 117), mc(1, 118));		{C1 sqft Adj}
					70: 
						cmd := SqFtAdjust(mc(1, 95), mc(1, 144), mc(1, 145));		{C2 sqft Adj}
					71: 
						cmd := SqFtAdjust(mc(1, 95), mc(1, 171), mc(1, 172));		{C3 sqft Adj}


					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin
		case CompNum of
			1: 
				ProcessCurCellInfo(WPtr, 41);
			2: 
				ProcessCurCellInfo(WPtr, 42);
			3: 
				ProcessCurCellInfo(WPtr, 43);
		end;
	end;

*)




//Vacant land Comps 1,2,3
function F0009InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get4CellSumR(doc, CX, 49, 50, 51, 52);
  V2 := Get4CellSumR(doc, CX, 53, 54, 55, 56);
  VR := V1 + V2;
  result := SetInfoCellValue(doc, mcx(cx,10), VR);
end;


function F0009C1Adjustments(doc: TContainer; CX: CellUID): Integer;
const
  SalesAmt  = 178;
  AcrePrice = 179;
  TotalAdj  = 201;
  FinalAmt  = 202;
  PlusChk   = 199;
  NegChk    = 200;
  InfoNet   = 4;
  InfoGross = 5;
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

function F0009C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 206;
  AcrePrice = 207;
  TotalAdj  = 229;
  FinalAmt  = 230;
  PlusChk   = 227;
  NegChk    = 228;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,210), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);

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

function F0009C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 234;
  AcrePrice = 235;
  TotalAdj  = 257;
  FinalAmt  = 258;
  PlusChk   = 255;
  NegChk    = 256;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

//Non-Lender Vacant Land
function F0767InfoSumLandUse(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get4CellSumR(doc, CX, 49, 50, 51, 52);
  V2 := Get4CellSumR(doc, CX, 53, 54, 55, 56);
  VR := V1 + V2;
  result := SetInfoCellValue(doc, mcx(cx,10), VR);
end;

function F0767C1Adjustments(doc: TContainer; CX: CellUID): Integer;
const
  SalesAmt  = 180;
  AcrePrice = 181;
  TotalAdj  = 203;
  FinalAmt  = 204;
  PlusChk   = 201;
  NegChk    = 202;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,184), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);

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

function F0767C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 208;
  AcrePrice = 209;
  TotalAdj  = 231;
  FinalAmt  = 232;
  PlusChk   = 229;
  NegChk    = 230;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,212), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,214), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);

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

function F0767C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 236;
  AcrePrice = 237;
  TotalAdj  = 259;
  FinalAmt  = 260;
  PlusChk   = 257;
  NegChk    = 258;
  InfoNet   = 8;
  InfoGross = 9;
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

//Vacant land Extra Comps
function F0010C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
  AcrePrice = 38;
  TotalAdj  = 60;
  FinalAmt  = 61;
  PlusChk   = 58;
  NegChk    = 59;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F0010C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 89;
  FinalAmt  = 90;
  PlusChk   = 87;
  NegChk    = 88;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F0010C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 95;
  AcrePrice = 96;
  TotalAdj  = 118;
  FinalAmt  = 119;
  PlusChk   = 116;
  NegChk    = 117;
  InfoNet   = 8;
  InfoGross = 9;
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

{*********************************}
{   Re-Certification of  Value    }
{*********************************}
function F0680C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 131;
  TotalAdj  = 165;
  FinalAmt  = 166;
  PlusChk   = 163;
  NegChk    = 164;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);

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

function F0680C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 170;
  TotalAdj  = 204;
  FinalAmt  = 205;
  PlusChk   = 202;
  NegChk    = 203;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,180), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,197), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,199), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);

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

function F0680C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 209;
  TotalAdj  = 243;
  FinalAmt  = 244;
  PlusChk   = 241;
  NegChk    = 242;
  InfoNet   = 9;
  InfoGross = 10;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,220), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,228), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);

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


//Summary Report
function F0072C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 99;
  TotalAdj  = 138;
  FinalAmt  = 139;
  PlusChk   = 136;
  NegChk    = 137;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);

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

function F0072C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 143;
  TotalAdj  = 182;
  FinalAmt  = 183;
  PlusChk   = 180;
  NegChk    = 181;
  InfoNet   = 3;
  InfoGross = 4;
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
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);

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

function F0072C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 187;
  TotalAdj  = 226;
  FinalAmt  = 227;
  PlusChk   = 224;
  NegChk    = 225;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,206), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);

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

//Summary Report 2007 Update
function F0074C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 97;
  TotalAdj  = 136;
  FinalAmt  = 137;
  PlusChk   = 134;
  NegChk    = 135;
  InfoNet   = 1;
  InfoGross = 2;
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
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);

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

function F0074C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 141;
  TotalAdj  = 180;
  FinalAmt  = 181;
  PlusChk   = 178;
  NegChk    = 179;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,160), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
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

function F0074C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 185;
  TotalAdj  = 224;
  FinalAmt  = 225;
  PlusChk   = 222;
  NegChk    = 223;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,194), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,196), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);

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



//Summary XComps
function F0076C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 39;
  TotalAdj  = 78;
  FinalAmt  = 79;
  PlusChk   = 76;
  NegChk    = 77;
  InfoNet   = 4;
  InfoGross = 5;
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
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);

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

function F0076C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 84;
  TotalAdj  = 123;
  FinalAmt  = 124;
  PlusChk   = 121;
  NegChk    = 122;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);

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

function F0076C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 129;
  TotalAdj  = 168;
  FinalAmt  = 169;
  PlusChk   = 166;
  NegChk    = 167;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
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

// Real Estate Evaluation Report (long 3 pages)
function F0153C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 81;
  TotalAdj  = 103;
  FinalAmt  = 104;
  PlusChk   = 101;
  NegChk    = 102;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F0153C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 108;
  TotalAdj  = 130;
  FinalAmt  = 131;
  PlusChk   = 128;
  NegChk    = 129;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);

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

function F0153C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 135;
  TotalAdj  = 157;
  FinalAmt  = 158;
  PlusChk   = 155;
  NegChk    = 156;
  InfoNet   = 10;
  InfoGross = 11;
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


//calc functional depr
function F0153CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(CX,63));    //funct depr percent
  V2 := GetCellValue(doc, mcx(CX,60));    //new cost
  V3 := GetCellValue(doc, mcx(CX,62));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(CX,64), VR);
    end;
end;

//calc external depr
function F0153CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(CX,65));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(CX,60));    //new cost
  V3 := GetCellValue(doc, mcx(CX,62));    //Phy Depr
  V4 := GetCellValue(doc, mcx(CX,64));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(CX,66), VR);
    end;
end;

// Real Estate Evaluation Report XComps (long 3 pages)
function F0929C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 34;
  TotalAdj  = 56;
  FinalAmt  = 57;
  PlusChk   = 54;
  NegChk    = 55;
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

function F0929C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 62;
  TotalAdj  = 84;
  FinalAmt  = 85;
  PlusChk   = 82;
  NegChk    = 83;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
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

function F0929C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 90;
  TotalAdj  = 112;
  FinalAmt  = 113;
  PlusChk   = 110;
  NegChk    = 111;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);

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

function F0930C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 35;
  TotalAdj  = 57;
  FinalAmt  = 58;
  PlusChk   = 55;
  NegChk    = 56;
  InfoNet   = 3;
  InfoGross = 4;
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

function F0930C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 63;
  TotalAdj  = 85;
  FinalAmt  = 86;
  PlusChk   = 83;
  NegChk    = 84;
  InfoNet   = 5;
  InfoGross = 6;
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

function F0930C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 91;
  TotalAdj  = 113;
  FinalAmt  = 114;
  PlusChk   = 111;
  NegChk    = 112;
  InfoNet   = 7;
  InfoGross = 8;
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
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);

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

function SubtAddABC(doc: TContainer; CellA, CellB, CellC, cellR: CellUID): Integer;
var
 V1, V2, V3, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 VR := (V1 - V2) + V3;
 result := SetCellValue(doc, cellR, VR);
end;





//Real Estate Evaluation (Short 1 pager)
function F0156C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 105;
  TotalAdj  = 127;
  FinalAmt  = 128;
  PlusChk   = 125;
  NegChk    = 126;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;

function F0156C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 132;
  TotalAdj  = 154;
  FinalAmt  = 155;
  PlusChk   = 152;
  NegChk    = 153;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);

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

function F0156C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 159;
  TotalAdj  = 181;
  FinalAmt  = 182;
  PlusChk   = 179;
  NegChk    = 180;
  InfoNet   = 9;
  InfoGross = 10;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);

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


//Construction Loan Inspection Functions
function FO687Sum1(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 14,15,16,17,18,19,20,21);
  value := value + Get8CellSumR(doc, cx, 22,23,24,25,26,27,28,29);
  value := value + Get8CellSumR(doc, cx, 30,31,32,33,34,35,36,37);
  value := value + Get8CellSumR(doc, cx, 38,39,40,0, 0,0,0,0);

  result := SetCellValue(doc, mcx(cx,41), Value);
end;
function FO687Sum2(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 43,44,45,46, 47,48,49,50);
  value := value + Get8CellSumR(doc, cx, 51,52,53,54, 55,56,57,58);
  value := value + Get8CellSumR(doc, cx, 59,60,61,62, 63,64,65,66);
  value := value + Get8CellSumR(doc, cx, 67,68,69,0, 0,0,0,0);

  result := SetCellValue(doc, mcx(cx,70), Value);
end;
function FO687Sum3(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 72,73,74,75, 76,77,78,79);
  value := value + Get8CellSumR(doc, cx, 80,81,82,83, 84,85,86,87);
  value := value + Get8CellSumR(doc, cx, 88,89,90,91, 92,93,94,95);
  value := value + Get8CellSumR(doc, cx, 96,97,98,0, 0,0,0,0);
  
  result := SetCellValue(doc, mcx(cx,99), Value);
end;
function FO687Sum4(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 101,102,103,104, 105,106,107,108);
  value := value + Get8CellSumR(doc, cx, 109,110,111,112, 113,114,115,116);
  value := value + Get8CellSumR(doc, cx, 117,118,119,120, 121,122,123,124);
  value := value + Get8CellSumR(doc, cx, 125,126,127,0, 0,0,0,0);

  result := SetCellValue(doc, mcx(cx,128), Value);
end;
function FO687Sum5(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 130,131,132,133, 134,135,136,137);
  value := value + Get8CellSumR(doc, cx, 138,139,140,141, 142,143,144,145);
  value := value + Get8CellSumR(doc, cx, 146,147,148,149, 150,151,152,153);
  value := value + Get8CellSumR(doc, cx, 154,155,156,0, 0,0,0,0);

  result := SetCellValue(doc, mcx(cx,157), Value);
end;

function FO687Sum6(doc: TContainer; CX: CellUID) : Integer;
var
  value: Double;
begin
  value := Get8CellSumR(doc, cx, 159,160,161,162, 163,164,165,166);
  value := value + Get8CellSumR(doc, cx, 167,168,169,170, 171,172,173,174);
  value := value + Get8CellSumR(doc, cx, 175,176,177,178, 179,180,181,182);
  value := value + Get8CellSumR(doc, cx, 183,184,185,0, 0,0,0,0);
  
  result := SetCellValue(doc, mcx(cx,186), Value);
end;

//REO 2008
function F0794C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 57,107,108,105,106,6,7,
            [67,69,71,73,75,77,79,81,82,86,88,90,92,94,96,98,100,102,104]);
end;

function F0794C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 114,164,165,162,163,8,9,
            [124,126,128,130,132,134,136,138,139,143,145,147,149,151,153,155,157,159,161]);
end;

function F0794C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 171,221,222,219,220,10,11,
            [181,183,185,187,189,191,193,195,196,200,202,204,206,208,210,212,214,216,218]);
end;


//REO 2008 - XListings
function F0834C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 54,104,105,102,103,4,5,
            [64,66,68,70,72,74,76,78,79,83,85,87,89,91,93,95,97,99,101]);
end;

function F0834C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 112,162,163,160,161,6,7,
            [122,124,126,128,130,132,134,136,137,141,143,145,147,149,151,153,155,157,159]);
end;

function F0834C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 170,220,221,218,219,8,9,
            [180,182,184,186,188,190,192,194,195,199,201,203,205,207,209,211,213,215,217]);
end;

function XferFeeSimpleLeaseHold(doc: TContainer; FeeCX, LHCX, CellR: CellUID): Integer;
var
  S1: String;
begin
  S1 := '';
  if CellIsChecked(doc, FeeCX) then
    S1 := 'Fee Simple'
  else if CellIsChecked(doc, LHCX) then
    S1 := 'Leasehold';
  SetCellString(doc, CellR, S1);

  result := 0;    //usualy a transfer to 2nd page, don't process
end;

/// summary: Calculates site dimensions indicating acres or square feet on a checkbox.
/// remarks: Made for the RELS Land Appraisal form (#889).
function F0889SiteDimension(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  tmpStr, acreStr, sqftStr: string;
  N: Integer;
  VX, VAcre: Double;
  V: array of Double;
begin
  result := 0;
  tmpStr := GetCellString(doc, cellA);
  if length(tmpStr) > 0 then
    begin
      SetLength(V, 4);                            //we will handle up to 4 numbers
      N := ParseStr(tmpStr, V);
      if N > 0 then
        begin
          VX := V[0];
          case N of
           1: VX := V[0];
           2: VX := V[0] * V[1];
           3: VX := GetTriangleArea(V[0], V[1], V[2]);
           4: VX := ((V[0] + V[2]) / 2) * ((V[1] + V[3]) / 2);
          end;

          VAcre := VX / 43560.0;                    //convert to acers
          AcreStr := Format('%.2n', [VAcre]);
          sqftStr := Format('%.0n', [VX]);

          if VAcre > 1.0 then
            begin
              tmpStr := AcreStr;                    //Concat(AcreStr, ' Ac')
              ClearCheckMark(doc, MCX(CellR, 123));
              SetCellChkMark(doc, MCX(CellR, 122), True);
            end
          else
            begin
              tmpStr := sqftStr;                    //Concat(sqftStr, ' SqFt');
              ClearCheckMark(doc, MCX(CellR, 122));
              SetCellChkMark(doc, MCX(CellR, 123), True);
            end;

          if N > 3 then
            tmpStr := Concat('Appx: ', tmpStr);

          result := SetCellString(doc, CellR, tmpStr);
          V := nil;                                 //release the array
        end
      else
        result := 0;                              //no values, return no processing

      Finalize(V);                                //release dynamic array
    end;
end;



//Vacant Land
function ProcessForm0009Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        2:
          cmd := F0009C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd  := ProcessMultipleCmds(ProcessForm0009Math, doc, CX,[2, 21]);
        4:
          Cmd  := ProcessMultipleCmds(ProcessForm0009Math, doc, CX,[5, 22]);
//Comp2 calcs
        5:
          cmd := F0009C2Adjustments(doc, cx);       //sum of adjs
        6:
          Cmd  := ProcessMultipleCmds(ProcessForm0009Math, doc, CX,[8, 23]);
//Comp3 calcs
        8:
          cmd := F0009C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := 0;   //DivideAB(doc, mcx(cx,137), mcx(cx,163), mcx(cx,138));     //price/sqft

        10:
          cmd := 0; //DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft

        11:
          cmd := CalcWeightedAvg(doc, [9, 4028, 10]);  //works with old and new Land XCOmp
        12:
          begin
            F0009C1Adjustments(doc, cx);       //sum of adjs
            F0009C2Adjustments(doc, cx);       //sum of adjs
            F0009C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
        13:
          cmd := SiteDimension(doc, mcx(cx,121), mcx(cx,122));
        14:
          cmd := F0009InfoSumLandUse(doc, CX);   //put sum of land use in Info cell

        20:
          cmd := DivideAB(doc, mcx(cx,158), mcx(cx,164),mcx(cx,160));         //sub price/sqft
        21:
          Cmd := DivideAB(doc, mcx(cx, 178), mcx(cx, 185), mcx(cx, 179));	 	{comp1Price/Area}
        22:
          Cmd := DivideAB(doc, mcx(cx, 206), mcx(cx, 213), mcx(cx, 207));		{comp2Price/Area}
        23:
          Cmd := DivideAB(doc, mcx(cx, 234), mcx(cx, 241), mcx(cx, 235));  	{comp3Price/Area}

      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0009Math(doc, 2, CX);
          ProcessForm0009Math(doc, 5, CX);
          ProcessForm0009Math(doc, 8, CX);
          ProcessForm0009Math(doc, 14, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0009Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;

//Non-Lender Vacant Land
function ProcessForm0767Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        2:
          cmd := F0767C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd  := ProcessMultipleCmds(ProcessForm0767Math, doc, CX,[2, 21]);
        4:
          Cmd  := ProcessMultipleCmds(ProcessForm0767Math, doc, CX,[5, 22]);
//Comp2 calcs
        5:
          cmd := F0767C2Adjustments(doc, cx);       //sum of adjs
        6:
          Cmd  := ProcessMultipleCmds(ProcessForm0767Math, doc, CX,[8, 23]);
//Comp3 calcs
        8:
          cmd := F0767C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := 0;   //DivideAB(doc, mcx(cx,137), mcx(cx,163), mcx(cx,138));     //price/sqft

        10:
          cmd := 0; //DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft

        11:
          cmd := CalcWeightedAvg(doc, [767, 768, 769]);   //calc wtAvg of main and xcomps forms
        12:
          begin
            F0767C1Adjustments(doc, cx);       //sum of adjs
            F0767C2Adjustments(doc, cx);       //sum of adjs
            F0767C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
        13:
          cmd := SiteDimension(doc, mcx(cx,121), mcx(cx,122));
        14:
          cmd := F0767InfoSumLandUse(doc, CX);   //put sum of land use in Info cell

        20:
          cmd := DivideAB(doc, mcx(cx,160), mcx(cx,166),mcx(cx,162));         //sub price/sqft
        21:
          Cmd := DivideAB(doc, mcx(cx, 180), mcx(cx, 187), mcx(cx, 181));	 	{comp1Price/Area}
        22:
          Cmd := DivideAB(doc, mcx(cx, 208), mcx(cx, 215), mcx(cx, 209));		{comp2Price/Area}
        23:
          Cmd := DivideAB(doc, mcx(cx, 236), mcx(cx, 243), mcx(cx, 237));  	{comp3Price/Area}

      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0767Math(doc, 2, CX);
          ProcessForm0767Math(doc, 5, CX);
          ProcessForm0767Math(doc, 8, CX);
          ProcessForm0767Math(doc, 14, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0767Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;


//Vacant Land Extra Comparables
function ProcessForm0010Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        10:
          cmd := ConfigXXXInstance(doc, cx, 33,62,91);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,62,91);

        3:
          Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[5, 21]);

        4:
          Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[8, 22]);

        6:
          Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[11, 23]);
//Comp1 calcs
        5:
          cmd := F0010C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        8:
          cmd := F0010C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := 0;   //DivideAB(doc, mcx(cx,89), mcx(cx,115), mcx(cx,90));     //price/sqft

//Comp3 calcs
        11:
          cmd := F0010C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := 0;   //DivideAB(doc, mcx(cx,137), mcx(cx,163), mcx(cx,138));     //price/sqft

        13:
          cmd := 0;   //DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [10, 889, 9]);   //works with new and old Land forms
        15:
          begin
            F0010C1Adjustments(doc, cx);       //sum of adjs
            F0010C2Adjustments(doc, cx);       //sum of adjs
            F0010C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;

          20:  cmd := DivideAB(doc, mcx(cx,16), mcx(cx,22), mcx(cx,18));     //sub price/sqft
          21:  Cmd := DivideAB(doc, mcx(cx, 37), mcx(cx, 44), mcx(cx, 38));		{comp1Price/Area}
          22:  Cmd := DivideAB(doc, mcx(cx, 66), mcx(cx, 73), mcx(cx, 67));		{comp2Price/Area}
          23:  Cmd := DivideAB(doc, mcx(cx, 95), mcx(cx, 102), mcx(cx, 96));	{comp3Price/Area}

      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0010Math(doc, 5, CX);
          ProcessForm0010Math(doc, 8, CX);
          ProcessForm0010Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0010Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Loan Valuations
function ProcessForm0049Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//Restricted Report (BR Version)
function ProcessForm0070Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//Restricted Report (HH Version)
function ProcessForm0071Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//Summary Report
function ProcessForm0072Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Land Use
       12:
          Cmd := LandUseSum(doc, CX, 8, [59,60,61,62,64]);

//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0072Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0072C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0072C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,99), mcx(cx,124), mcx(cx,100));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0072Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0072C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0072C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,143), mcx(cx,168), mcx(cx,144));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0072Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0072C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0072C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,187), mcx(cx,212), mcx(cx,188));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,76), mcx(cx,88), mcx(cx,77));     //Subj price/sqft
        11:
          cmd := CalcWeightedAvg(doc, [72,76]);   //calc wtAvg of main and xcomps forms
        13:          //Special ID 13 for Wt Avg
          begin
            F0072C1Adjustments(doc, cx);       //sum of adjs
            F0072C2Adjustments(doc, cx);       //sum of adjs
            F0072C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0072Math(doc, 2, CX);
          ProcessForm0072Math(doc, 5, CX);
          ProcessForm0072Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0072Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

//Summary Appraisal Extra Comparables
function ProcessForm0076Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',35,80,125, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 35,80,125);
        3:
          cmd := ConfigXXXInstance(doc, cx, 35,80,125);

//Comp1 calcs
        4:   //sales price changed
          begin
            ProcessForm0076Math(doc, 6, CX);        //calc new price/sqft
            cmd := F0076C1Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0076C1Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,39), mcx(cx,64), mcx(cx,40));     //price/sqft

//Comp2 calcs
        7:   //sales price changed
          begin
            ProcessForm0076Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0076C2Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0076C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,84), mcx(cx,109), mcx(cx,85));     //price/sqft

//Comp3 calcs
        10:   //sales price changed
          begin
            ProcessForm0076Math(doc, 12, CX);     //calc new price/sqft
            cmd := F0076C3Adjustments(doc, cx);     //redo the adjustments
          end;
        11:
          cmd := F0076C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := DivideAB(doc, mcx(cx,129), mcx(cx,154), mcx(cx,130));     //price/sqft

        13:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,28), mcx(cx,17));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [72,74,76]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0076C1Adjustments(doc, cx);       //sum of adjs
            F0076C2Adjustments(doc, cx);       //sum of adjs
            F0076C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0076Math(doc, 5, CX);
          ProcessForm0076Math(doc, 8, CX);
          ProcessForm0076Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0076Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Property Evaluations
function ProcessForm0073Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//Real Estate Evaluation Report (long 3 pages)
function ProcessForm0153Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          cmd := F0153C1Adjustments(doc, cx);     //redo the adjustments
        2:
          cmd := F0153C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        4:   //sales price changed
          cmd := F0153C2Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F0153C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0153C3Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0153C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := CalcWeightedAvg(doc, [153, 929]);   //calc wtAvg of main and xcomps forms
       11:
          cmd := SumCellArray(doc, cx, [12,18,24,30,36,42,48,54], 55);
       12:
          Cmd := ProcessMultipleCmds(ProcessForm0153Math, doc, CX,[13,14,16]);
       13,14:
          cmd := SumCellArray(doc, cx, [55,56,59], 60);
       16:
          cmd := MultPercentAB(doc, mcx(CX,55), mcx(CX,58),mcx(CX,59));
       17:
          Cmd := MultPercentAB(doc, mcx(CX,60), mcx(CX,61),mcx(CX,62));         //phy dep precent entered
       19:
          cmd := F0153CalcDeprLessPhy(doc, cx);                                 //funct depr entered
       21:
          cmd := F0153CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
       18,20,22:
          cmd := SumCellArray(doc, cx, [62,64,66], 67);
       15,23:
          cmd := SubtAB(doc, MCX(cx,60), mcx(cx,67), mcx(cx,68));     //depr value of improvements
       24,25:
          cmd := SumCellArray(doc, cx, [68,69], 70);
       26:
          cmd := TransA2B(doc, mcx(cx,70), mcx(cx,74));
       27,28:
          cmd := SumCellArray(doc, cx, [73,74], 75);
       29,30,31,32:
          cmd := SumCellArray(doc, cx, [75,76,77,78], 79);
       33:
          cmd := RoundByValR(doc, cx, 79, 80, 500);
       34:
          cmd := SumCellArray(doc, cx, [75,79,83,87], 90);
       35,36,37:
          cmd := SubtAddABC(doc, MCX(cx,90), mcx(cx,93), mcx(CX,96), mcx(cx,99));
       39:
          cmd := SumCellArray(doc, cx, [102,105,108,111,114,117,120,123,126,129,132,136,140,144,148,152,156,159], 162);
       38,40:
          cmd := SubtAB(doc, MCX(cx,99), mcx(cx,162), mcx(cx,166));
       44:
          cmd := SumCellArray(doc, cx, [77,81,85,89], 92);
       63,45,46:
          cmd := SubtAddABC(doc, MCX(cx,92), mcx(cx,95), mcx(CX,98), mcx(cx,101));
       47,49:
          cmd := SubtAB(doc, MCX(cx,101), mcx(cx,165), mcx(cx,170));
       48:
          cmd := SumCellArray(doc, cx, [104,107,110,113,116,119,122,125,128,131,134,138,142,146,150,154,158,161], 165);
       64:
          cmd := TransA2B(doc, mcx(cx,177), mcx(cx,179));
       51:
          Cmd := DivideAB(doc, mcx(cx,178), mcx(CX,179), mcx(CX,180));
       53:
          Cmd := MultAB(doc, MCX(cx,183), mcx(cx,184), mcx(cx,185));
       54:
          Cmd := MultAB(doc, MCX(cx,186), mcx(cx,187), mcx(cx,188));
       55:
          cmd := SumCellArray(doc, cx, [185,188], 189);
       56:
          cmd := TransA2B(doc, mcx(cx,189), mcx(cx,191));
       57:
          Cmd := DivideAB(doc, mcx(cx,190), mcx(CX,191), mcx(CX,192));
       59,60:
          cmd := SumCellArray(doc, cx, [194,195], 196);
       61:
          cmd := RoundByValR(doc, cx, 196, 197, 500);

       10:
          begin
            F0153C1Adjustments(doc, cx);       //sum of adjs
            F0153C2Adjustments(doc, cx);       //sum of adjs
            F0153C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0153Math(doc, 2, CX);
          ProcessForm0153Math(doc, 5, CX);
          ProcessForm0153Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0153Math(doc, 10, CX);
        end;
    end;




  result := 0;
end;

function ProcessForm0929Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 30,58,86);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 30,58,86, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 30,58,86);
//Comp1 calcs
        5:   //sales price changed
          cmd := F0929C1Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0929C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        6:   //sales price changed
          cmd := F0929C2Adjustments(doc, cx);     //redo the adjustments
        9:
          cmd := F0929C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0929C3Adjustments(doc, cx);     //redo the adjustments
        10:
          cmd := F0929C3Adjustments(doc, cx);       //sum of adjs
        11:
          cmd := CalcWeightedAvg(doc, [153, 929]);   //calc wtAvg of main and xcomps forms
        12:
          begin
            F0929C1Adjustments(doc, cx);       //sum of adjs
            F0929C2Adjustments(doc, cx);       //sum of adjs
            F0929C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
   else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -2:     //calc average price
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0929Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;


//Real Estate Evaluation Report (short 1 page)
function ProcessForm0156Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          cmd := F0156C1Adjustments(doc, cx);     //redo the adjustments
        2:
          cmd := F0156C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        4:   //sales price changed
          cmd := F0156C2Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F0156C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0156C3Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0156C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := CalcWeightedAvg(doc, [156, 930]);   //calc wtAvg of main and xcomps forms
        10:
          begin
            F0156C1Adjustments(doc, cx);       //sum of adjs
            F0156C2Adjustments(doc, cx);       //sum of adjs
            F0156C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0156Math(doc, 2, CX);
          ProcessForm0156Math(doc, 5, CX);
          ProcessForm0156Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0156Math(doc, 10, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0930Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 31,59,87);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 31,59,87, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 31,59,87);
//Comp1 calcs
        5:   //sales price changed
          cmd := F0930C1Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0930C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        6:   //sales price changed
          cmd := F0930C2Adjustments(doc, cx);     //redo the adjustments
        9:
          cmd := F0930C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0930C3Adjustments(doc, cx);     //redo the adjustments
        10:
          cmd := F0930C3Adjustments(doc, cx);       //sum of adjs
        11:
          cmd := CalcWeightedAvg(doc, [156, 930]);   //calc wtAvg of main and xcomps forms
        12:
          begin
            F0930C1Adjustments(doc, cx);       //sum of adjs
            F0930C2Adjustments(doc, cx);       //sum of adjs
            F0930C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
   else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -2:     //calc average price
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0930Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;

//Re-Certification of Value
function ProcessForm0680Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          cmd := F0680C1Adjustments(doc, cx);       //redo the adjustments
        2:
          cmd := F0680C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        4:   //sales price changed
          cmd := F0680C2Adjustments(doc, cx);       //redo the adjustments
        5:
          cmd := F0680C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0680C3Adjustments(doc, cx);       //redo the adjustments
        8:
          cmd := F0680C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := CalcWeightedAvg(doc, [cx.formID]);   //calc wtAvg of main and xcomps forms
        10:
          begin
            F0680C1Adjustments(doc, cx);       //sum of adjs
            F0680C2Adjustments(doc, cx);       //sum of adjs
            F0680C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0680Math(doc, 2, CX);
          ProcessForm0680Math(doc, 5, CX);
          ProcessForm0680Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0680Math(doc, 10, CX);
        end;
    end;

  result := 0;
end;

//REO Addendum
function ProcessForm0683Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumCellArray(doc, cx, [94,96,98,100,102,104,106,108,110,112,114], 115);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Construction Loan Inspection
function ProcessForm0687Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := FO687Sum1(doc, cx);
        2:
          Cmd := FO687Sum2(doc, cx);
        3:
          Cmd := FO687Sum3(doc, cx);
        4:
          Cmd := FO687Sum4(doc, cx);
        5:
          Cmd := FO687Sum5(doc, cx);
        6:
          Cmd := FO687Sum6(doc, cx);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Summary Report
function ProcessForm0074Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Land Use
       12:
          Cmd := LandUseSum(doc, CX, 8, [57,58,59,60,62]);

//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0074Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0074C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0074C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,97), mcx(cx,122), mcx(cx,98));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0074Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0074C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0074C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,141), mcx(cx,166), mcx(cx,142));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0074Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0074C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0074C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,185), mcx(cx,210), mcx(cx,186));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,74), mcx(cx,86), mcx(cx,75));     //Subj price/sqft
        11:
          cmd := CalcWeightedAvg(doc, [76,74]);   //calc wtAvg of main and xcomps forms
        13:          //Special ID 13 for Wt Avg
          begin
            F0074C1Adjustments(doc, cx);       //sum of adjs
            F0074C2Adjustments(doc, cx);       //sum of adjs
            F0074C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0074Math(doc, 2, CX);
          ProcessForm0074Math(doc, 5, CX);
          ProcessForm0074Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0074Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0794Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//subject
        1:
          cmd := DivideAB(doc, mcx(cx,20), mcx(cx,40), mcx(cx,23));     //Subj price/sqft
//Listing1 calcs
        2:   //lsiting price changed
          begin
            ProcessForm0794Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0794C1Adjustments(doc, cx);     //redo the adjustments
          end;
        3:
          cmd := DivideAB(doc, mcx(cx,57), mcx(cx,87), mcx(cx,60));     //price/sqft
        4:
          cmd := F0794C1Adjustments(doc, cx);       //sum of adjs

//Listing2 calcs
        5:   //Listing price changed
          begin
            ProcessForm0794Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0794C2Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := DivideAB(doc, mcx(cx,114), mcx(cx,144), mcx(cx,117));     //price/sqft
        7:
          cmd := F0794C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        8:   //sales price changed
          begin
            ProcessForm0794Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0794C3Adjustments(doc, cx);     //redo the adjustments
          end;
        9:
          cmd := DivideAB(doc, mcx(cx,171), mcx(cx,201), mcx(cx,174));     //price/sqft
        10:
          cmd := F0794C3Adjustments(doc, cx);       //sum of adjs

//Estimated Costs
       12:
          Cmd := SumCellArray(doc, CX, [224,226,228,230,232,234,236,238,240,242,244,246],247);

        11:
          cmd := CalcWeightedAvg(doc, [794,834]);   //calc wtAvg of main and xcomps forms

        13:          //Special ID 13 for Wt Avg
          begin
            F0794C1Adjustments(doc, cx);       //sum of adjs
            F0794C2Adjustments(doc, cx);       //sum of adjs
            F0794C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0794Math(doc, 4, CX);
          ProcessForm0794Math(doc, 7, CX);
          ProcessForm0794Math(doc, 10, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0794Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0834Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 48,106,164);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 48,106,164, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,106,164);
//Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,36), mcx(cx,19));     //Subj price/sqft
//Listing1 calcs
        5:   //listing price changed
          begin
            ProcessForm0834Math(doc, 7, CX);       //calc new price/sqft
            Cmd := F0834C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0834C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,54), mcx(cx,84), mcx(cx,57));     //price/sqft

//Linting2 calcs
        8:   //Listing price changed
          begin
            ProcessForm0834Math(doc, 9, CX);     //calc new price/sqft
            Cmd := F0834C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,142), mcx(cx,115));     //price/sqft
        10:
          cmd := F0834C2Adjustments(doc, cx);     //sum of adjs

//Listing3 calcs
        11:   //Listing price changed
          begin
            ProcessForm0834Math(doc, 12, CX);     //calc new price/sqft
            Cmd := F0834C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := DivideAB(doc, mcx(cx,170), mcx(cx,200), mcx(cx,173));     //price/sqft
        13:
          cmd := F0834C3Adjustments(doc, cx);     //sum of adjs

        14:
          cmd := CalcWeightedAvg(doc, [794,834]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0834C1Adjustments(doc, cx);
            F0834C2Adjustments(doc, cx);     //sum of adjs
            F0834C3Adjustments(doc, cx);
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
          ProcessForm0834Math(doc, 6, CX);
          ProcessForm0834Math(doc, 10, CX);
          ProcessForm0834Math(doc, 13, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0834Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0615Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,58,83);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPS','', 33,58,83, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 33,58,83);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
    
  result := 0;
end;

//Rels Land Form
function ProcessForm0889Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of

        1: cmd  := LandUseSum(doc,  CX,  2, [72,73,74,75,76,77]);
        2: cmd  := F0889SiteDimension(doc, mcx(cx,120), mcx(cx,121));
        3: cmd  := ProcessMultipleCmds(ProcessForm0889Math, doc, CX,[6, 21]);
        4: Cmd  := ProcessMultipleCmds(ProcessForm0889Math, doc, CX,[7, 22]);
        5: Cmd  := ProcessMultipleCmds(ProcessForm0889Math, doc, CX,[8, 23]);

        6: cmd :=  SalesGridAdjustment(doc, CX,43,81,82,79,80,2,3,
                   [46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78]);

        7: cmd := SalesGridAdjustment(doc, CX, 88,126,127,124,125,4,5,
                   [91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123]);

        8: cmd := SalesGridAdjustment(doc, CX, 133,171,172,169,170,6,7,
                   [136,138,140,142,144,146,148,150,152,154,156,158,160,162,164,166,168]);

        9:   cmd := CalcWeightedAvg(doc, [889, 4028, 10]);  //works with new and old Land XComps
        12:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,25), mcx(cx,26), MCPX(CX,2,23));

        20:  cmd := DivideAB(doc, mcx(cx,15), mcx(cx,25), mcx(cx,17));        //sub price/sqft
        21:  Cmd := DivideAB(doc, mcx(cx, 43), mcx(cx, 57), mcx(cx, 44));	  	{comp1Price/Area}
        22:  Cmd := DivideAB(doc, mcx(cx, 88), mcx(cx, 102), mcx(cx, 89));		{comp2Price/Area}
        23:  Cmd := DivideAB(doc, mcx(cx, 133), mcx(cx, 147), mcx(cx, 134));	{comp3Price/Area}

        50: begin
              SalesGridAdjustment(doc, CX,43,81,82,79,80,2,3,
              [46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78]);
              SalesGridAdjustment(doc, CX, 88,126,127,124,125,4,5,
              [91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123]);
              SalesGridAdjustment(doc, CX, 133,171,172,169,170,6,7,
              [136,138,140,142,144,146,148,150,152,154,156,158,160,162,164,166,168]);

              cmd := 0;
            end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 1;    //page2
          ProcessForm0889Math(doc, 50, CX);
        end;
    end;
  result := 0;
end;

function F0950C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 138,175,176,173,174,3,4,
            [141,143,145,147,149,151,152,156,158,160,162,164,166,168,170,172]);
end;

function F0950C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 180,217,218,215,216,5,6,
            [183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214]);
end;

function F0950C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 222,259,260,257,258,7,8,
            [225,227,229,231,233,235,236,240,242,244,246,248,250,252,254,256]);
end;

function F0950SumLandUsePct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get4CellSumR(doc, CX, 47, 48, 49, 50);
  V2 := Get4CellSumR(doc, CX, 51, 52, 53, 0);
  VR := V1 + V2;
  result := SetCellValue(doc, mcx(CX,54), VR);
end;

function ProcessForm0950Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1, 2: cmd := F0950C1Adjustments(doc, cx);       //sum of comp1 adjs
        4, 5: cmd := F0950C2Adjustments(doc, cx);       //sum of comp2 adjs
        7, 8: cmd := F0950C2Adjustments(doc, cx);       //sum of comp2 adjs
        9:    cmd := CalcWeightedAvg(doc, [942,950]);       //calc wtAvg of main forms
        10:
          begin
            F0950C1Adjustments(doc, cx);       //sum of adjs
            F0950C2Adjustments(doc, cx);       //sum of adjs
            F0950C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
        14:
          cmd := F0950SumLandUsePct(doc, CX);   //put sum of land use in total cell
       else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0950Math(doc, 10, CX);
        end;
    end;

  result := 0;
end;


function F0926C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 143,180,181,178,179,3,4,
            [146,148,150,152,154,156,157,161,163,165,167,169,171,173,175,177]);
end;

function F0926C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 185,222,223,220,221,5,6,
            [188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219]);
end;

function F0926C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 227,264,265,262,263,7,8,
            [230,232,234,236,238,240,241,245,247,249,251,253,255,257,259,261]);
end;

function F0926SumLandUsePct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get4CellSumR(doc, CX, 47, 48, 49, 50);
  V2 := Get4CellSumR(doc, CX, 51, 52, 53, 0);
  VR := V1 + V2;
  result := SetCellValue(doc, mcx(CX,54), VR);
end;

function ProcessForm0926Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1, 2: cmd := F0926C1Adjustments(doc, cx);       //sum of comp1 adjs
        4, 5: cmd := F0926C2Adjustments(doc, cx);       //sum of comp2 adjs
        7, 8: cmd := F0926C2Adjustments(doc, cx);       //sum of comp2 adjs
        9:    cmd := CalcWeightedAvg(doc, [958,926]);       //calc wtAvg of main forms
        10:
          begin
            F0926C1Adjustments(doc, cx);       //sum of adjs
            F0926C2Adjustments(doc, cx);       //sum of adjs
            F0926C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
        14:
          cmd := F0926SumLandUsePct(doc, CX);   //put sum of land use in total cell
			  15:
          cmd := SumAB(doc, mcx(cx, 84), mcx(cx, 85), mcx(cx, 86));	// Tax amount
       else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0926Math(doc, 10, CX);
        end;
    end;

  result := 0;
end;


function F0942C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 44,81,82,79,80,3,4,
            [47,49,51,53,55,57,58,62,64,66,68,70,72,74,76,78]);
end;

function F0942C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 87,124,125,122,123,5,6,
            [90,92,94,96,98,100,101,105,107,109,111,113,115,117,119,121]);
end;

function F0942C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 130,167,168,165,166,7,8,
            [133,135,137,139,141,143,144,148,150,152,154,156,158,160,162,164]);
end;

function ProcessForm0942Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 40,83,126);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPS','', 40,83,126, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 40,83,126);
        5, 6: cmd := F0942C1Adjustments(doc, cx);       //sum of comp1 adjs
        8, 9: cmd := F0942C2Adjustments(doc, cx);       //sum of comp2 adjs
        11, 12: cmd := F0942C3Adjustments(doc, cx);       //sum of comp3 adjs
        14: cmd := CalcWeightedAvg(doc, [942,950]);       //calc wtAvg of main forms
        15:
          begin
            F0942C1Adjustments(doc, cx);       //sum of adjs
            F0942C2Adjustments(doc, cx);       //sum of adjs
            F0942C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
       else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0942Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function F0958C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 44,81,82,79,80,3,4,
            [47,49,51,53,55,57,58,62,64,66,68,70,72,74,76,78]);
end;

function F0958C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 87,124,125,122,123,5,6,
            [90,92,94,96,98,100,101,105,107,109,111,113,115,117,119,121]);
end;

function F0958C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 130,167,168,165,166,7,8,
            [133,135,137,139,141,143,144,148,150,152,154,156,158,160,162,164]);
end;

function ProcessForm0958Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 40,83,126);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPS','', 40,83,126, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 40,83,126);
        5, 6: cmd := F0958C1Adjustments(doc, cx);       //sum of comp1 adjs
        8, 9: cmd := F0958C2Adjustments(doc, cx);       //sum of comp2 adjs
        11, 12: cmd := F0958C3Adjustments(doc, cx);       //sum of comp3 adjs
        14: cmd := CalcWeightedAvg(doc, [958,926]);       //calc wtAvg of main forms
        15:
          begin
            F0958C1Adjustments(doc, cx);       //sum of adjs
            F0958C2Adjustments(doc, cx);       //sum of adjs
            F0958C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;
       else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0958Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Summary DeskTop  Appraisal Report  613
function ProcessForm0613Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := DivideAB_R(doc, CX, 51, 58, 52);
        2: Cmd := DivideAB_R(doc, CX, 67, 75, 68);
        3: Cmd := DivideAB_R(doc, CX, 87, 95, 88);
        4: Cmd := DivideAB_R(doc, CX, 107, 115, 108);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

function ProcessForm4028Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
          1: cmd := ConfigXXXInstance(doc, cx, 32,78,124);

          3: Cmd := ProcessMultipleCmds(ProcessForm4028Math, doc, CX,[6, 21]);
          4: Cmd := ProcessMultipleCmds(ProcessForm4028Math, doc, CX,[7, 22]);
          5: Cmd := ProcessMultipleCmds(ProcessForm4028Math, doc, CX,[8, 23]);

          6:   cmd :=  SalesGridAdjustment(doc, CX,38,76,77,74,75,1,2,
                   [41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73]);

          7:   cmd := SalesGridAdjustment(doc, CX, 84,122,123,120,121,3,4,
                   [87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,117,119]);


          8:   cmd := SalesGridAdjustment(doc, CX, 130,168,169,166,167,5,6,
                   [133,135,137,139,141,143,145,147,149,151,153,155,157,159,161,163,165]);

          9:   cmd := CalcWeightedAvg(doc, [4028, 889, 9]);  //works with old and new Land forms
          20:  cmd := DivideAB(doc, mcx(cx,9), mcx(cx,19), mcx(cx,11));     //sub price/sqft
          21:  Cmd := DivideAB(doc, mcx(cx, 38), mcx(cx, 52), mcx(cx, 39));		{comp1Price/Area}
          22:  Cmd := DivideAB(doc, mcx(cx, 84), mcx(cx, 98), mcx(cx, 85));		{comp2Price/Area}
          23:  Cmd := DivideAB(doc, mcx(cx, 130), mcx(cx, 144), mcx(cx, 131));	{comp3Price/Area}

          50: begin
                   SalesGridAdjustment(doc, CX,38,76,77,74,75,1,2,
                   [41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73]);
                   SalesGridAdjustment(doc, CX, 84,122,123,120,121,3,4,
                   [87,89,91,93,95,97,99,101,103,105,107,109,111,113,115,117,119]);
                   SalesGridAdjustment(doc, CX,  130,168,169,166,167,5,6,
                   [133,135,137,139,141,143,145,147,149,151,153,155,157,159,161,163,165]);
               cmd := 0;
              end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //page1
          ProcessForm4028Math(doc, 50, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm4157Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
          1: Cmd := LandUseSum(doc, CX, 2, [72,73,74,75,77]);

          3: Cmd := ProcessMultipleCmds(ProcessForm4157Math, doc, CX,[6, 21]);
          4: Cmd := ProcessMultipleCmds(ProcessForm4157Math, doc, CX,[7, 22]);
          5: Cmd := ProcessMultipleCmds(ProcessForm4157Math, doc, CX,[8, 23]);

          6:   cmd :=  SalesGridAdjustment(doc, CX,43,81,82,79,80,2,3,     //Ticket #1186
                   [46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78]);

          7:   cmd := SalesGridAdjustment(doc, CX, 88,126,127,124,125,4,5, //Ticket #1186
                   [91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123]);


          8:   cmd := SalesGridAdjustment(doc, CX, 133,171,172,169,170,6,7,  //Ticket #1186
                   [136,138,140,142,144,146,148,150,152,154,156,158,160,162,164,166,168]);

          9:   cmd := CalcWeightedAvg(doc, [fmLenderAppraisal]);
          20:  cmd := DivideAB(doc, mcx(cx,15), mcx(cx,25), mcx(cx,17));     //sub price/sqft
          21:  Cmd := DivideAB(doc, mcx(cx, 43), mcx(cx, 57), mcx(cx, 44));		{comp1Price/Area}
          22:  Cmd := DivideAB(doc, mcx(cx, 88), mcx(cx, 102), mcx(cx, 89));		{comp2Price/Area}
          23:  Cmd := DivideAB(doc, mcx(cx, 133), mcx(cx, 147), mcx(cx, 134));	{comp3Price/Area}

          50: begin
                 //  SalesGridAdjustment(doc, CX,43,81,82,79,80,2,3,
                 //  [46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78]);
                 //  SalesGridAdjustment(doc, CX, 88,126,127,124,125,4,5,
                 //  [91,93,95,97,99,101,103,105,107,109,111,113,115,117,119,121,123]);
                 //  SalesGridAdjustment(doc, CX, 133,171,172,169,170,6,7,
                 //  [136,138,140,142,144,146,148,150,152,154,156,158,160,162,164,166,168]);
               cmd := 0;
              end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //page1
          ProcessForm4157Math(doc, 50, CX);
        end;
    end;
  result := 0;
end;

function F4352C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 30,53,54,51,52,4,5,
    [34,36,38,40,42,44,46,48,50],True);
end;

function F4352C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX,58,81,82,79,80,6,7,
    [62,64,66,68,70,72,74,76,78],True);
end;

function F4352C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX,86,109,110,107,108,8,9,
    [90,92,94,96,98,100,102,104,106],True);
end;

function ProcessForm4352Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
           //Page 2
           2: Cmd := F4352C1Adjustments(doc, cx);
           3: cmd := ProcessMultipleCmds(ProcessForm4352Math, doc, CX,[2, 21]);   //comp1
           4: cmd := ProcessMultipleCmds(ProcessForm4352Math, doc, CX,[5, 22]);   //comp2
           5: Cmd := F4352C2Adjustments(doc, cx);
           6: cmd := ProcessMultipleCmds(ProcessForm4352Math, doc, CX,[8, 23]);
           8: Cmd := F4352C3Adjustments(doc, cx);


          11: cmd := CalcWeightedAvg(doc, [4352, 4353,767, 768, 769]);   //calc wtAvg of main and xcomps forms

          12:
            begin
              F4352C1Adjustments(doc, cx);       //sum of adjs
              F4352C2Adjustments(doc, cx);       //sum of adjs
              F4352C3Adjustments(doc, cx);       //sum of adjs
              cmd := 0;
            end;

          //Page 1
          13: cmd := SiteDimension(doc, mcx(cx,121), mcx(cx,122));
          14: Cmd := LandUseSum(doc, CX, 2, [49,50,51,52,53,54,55,56]);
          //page 2
          20: cmd := DivideAB(doc, mcx(cx,10), mcx(cx,16),mcx(cx,12));         //sub price/sqft
          21: Cmd := DivideAB(doc, mcx(cx, 30), mcx(cx, 37), mcx(cx, 31));	 	{comp1Price/Area}
          22: Cmd := DivideAB(doc, mcx(cx, 58), mcx(cx, 65), mcx(cx, 59));		{comp2Price/Area}
          23: Cmd := DivideAB(doc, mcx(cx, 86), mcx(cx, 93), mcx(cx, 87));  	{comp3Price/Area}
      else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm4352Math(doc, 2, CX);
          ProcessForm4352Math(doc, 5, CX);
          ProcessForm4352Math(doc, 8, CX);
          ProcessForm4352Math(doc, 14, CX);
        end;
      -2:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm4352Math(doc, 12, CX);
        end;
    end;
  result := 0;
end;

//Vacant land Extra Comps
function F4353C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
  AcrePrice = 38;
  TotalAdj  = 60;
  FinalAmt  = 61;
  PlusChk   = 58;
  NegChk    = 59;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F4353C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 66;
  AcrePrice = 67;
  TotalAdj  = 89;
  FinalAmt  = 90;
  PlusChk   = 87;
  NegChk    = 88;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F4353C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 95;
  AcrePrice = 96;
  TotalAdj  = 118;
  FinalAmt  = 119;
  PlusChk   = 116;
  NegChk    = 117;
  InfoNet   = 8;
  InfoGross = 9;
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



function ProcessForm4353Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        10:  cmd := ConfigXXXInstance(doc, cx, 33,62,91);
        2:   cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,62,91);

        3:   Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[5, 21]);

        4:   Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[8, 22]);

        6:   Cmd := ProcessMultipleCmds(ProcessForm0010Math, doc, CX,[11, 23]);
//Comp1 calcs
        5:   cmd := F4353C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        8:   cmd := F4353C2Adjustments(doc, cx);       //sum of adjs
        9:   cmd := 0;   //DivideAB(doc, mcx(cx,89), mcx(cx,115), mcx(cx,90));     //price/sqft

//Comp3 calcs
        11:  cmd := F4353C3Adjustments(doc, cx);       //sum of adjs
        12:  cmd := 0;   //DivideAB(doc, mcx(cx,137), mcx(cx,163), mcx(cx,138));     //price/sqft

        13:  cmd := 0;   //DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft
        14:  cmd := CalcWeightedAvg(doc, [4353,10, 889, 9]);   //works with new and old Land forms
        15:
          begin
            F4353C1Adjustments(doc, cx);       //sum of adjs
            F4353C2Adjustments(doc, cx);       //sum of adjs
            F4353C3Adjustments(doc, cx);       //sum of adjs
            cmd := 0;
          end;

          20:  cmd := DivideAB(doc, mcx(cx,16), mcx(cx,22), mcx(cx,18));     //sub price/sqft
          21:  Cmd := DivideAB(doc, mcx(cx, 37), mcx(cx, 44), mcx(cx, 38));		{comp1Price/Area}
          22:  Cmd := DivideAB(doc, mcx(cx, 66), mcx(cx, 73), mcx(cx, 67));		{comp2Price/Area}
          23:  Cmd := DivideAB(doc, mcx(cx, 95), mcx(cx, 102), mcx(cx, 96));	{comp3Price/Area}

      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4353Math(doc, 5, CX);
          ProcessForm4353Math(doc, 8, CX);
          ProcessForm4353Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4353Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;


end.
