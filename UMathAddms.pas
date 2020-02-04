unit UMathAddms;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  Energy          = 651;
  Financial       = 654;
  CostApprG       = 660;
  IncomeApprG     = 661;
  fmSalesGrid1    = 662;
  fmSalesGrid2    = 663;
  fmSqFtFHA2Page  = 664;
  SqFtAreaList    = 705;
  fmSqFtFHA1Page  = 706;
  fmListCompAnalysis = 730;
  fmListCompAnalysis2 = 733;
  fmCostToCure = 729;
  fmVALiquidAddendum = 693;
  fmVALiquidAddendum2 = 947;
  fmGreenPoint2000 = 787;
  fmGreenPoint2000XComps = 781;
  fmRepairAndMaintenanceAddendum = 890;
  fmSolidifiDesktopSummaryAppraisal = 4211;    //github #871
  fmSolidifiDesktopSummaryXComps = 4091;      //github #711
  fmSolidifiDesktopAppraisalQuantitative = 4261; //may 2018; new Slidifi form
  fmMPRAddendum = 948;
  fmMPRRepairsRequired = 953;
  fmWellsFargoRVSDesktop = 954;
  fmProbateResidentialComps = 4126;
  fmProbateResidentialXComps = 4127;
  fmDesktopRestrictedAppraisal = 298;
  fmGPResidential = 4275;
  fmGPResidentialXC = 4276;
  fmSolidifiQTXComps = 4277; //Ticket #1427
  fmSolidifiFlexMain = 4309; //Ticket #1522
  fmSolidifiFlexXComp = 4310; //Ticket #1522
  fmGPCondoMain = 4289;  //Ticket #1579
  fmGPCondoXComp = 4293; //Ticket #1579
  PhotoGPXComp = 4284;   //Ticket #1579
  PhotoGPXListing = 4282;   //Ticket #1579
  fmExhitBitLetter4206 = 4206;
  fmCostToCure4344 = 4344;
  fmValuationSalesXComp = 4354;
  fmClassValuationDesktop = 4360;
  fmClassValuationXComp = 4361;


  function ProcessForm0651Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0654Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0660Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0661Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0662Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0663Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0664Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0705Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0730Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0733Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0729Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0693Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0787Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0781Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0890Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer; //github #871
  function ProcessForm4211Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4261Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4091Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0947Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0948Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0953Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0954Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4126Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4127Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0298Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4275Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4276Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //Ticket #1579
  function ProcessForm4289Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4293Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //Ticket #1579
  function ProcessForm4309Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //ticket #1522
  function ProcessForm4310Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //ticket #1522
  function ProcessForm4284Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4282Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function F4261C1Adjustments(doc: TContainer; CX: CellUID): Integer;
  function F4261C2Adjustments(doc: TContainer; CX: CellUID): Integer;
  function F4261C3Adjustments(doc: TContainer; CX: CellUID): Integer;
  function ProcessForm4277Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm4206Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4344Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4354Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm4360Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4361Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

(*
//Energy

	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
{Page 1 math}
					1: 
						Cmd := MinAB(mc(2, 6), mc(2, 7), mc(2, 8));
					2: 
						Cmd := MinAB(mc(2, 14), mc(2, 15), mc(2, 16));
					3: 
						Cmd := MinAB(mc(2, 22), mc(2, 23), mc(2, 24));
					4: 
						Cmd := SumABC(mc(2, 8), mc(2, 16), mc(2, 24), mc(2, 25));
					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin
		case CompNum of
			1: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
			2: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
			3: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
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
	end; *)

(*
//Financial
	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;

	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					1: 
						Cmd := PercentAOfB(mc(1, 14), mc(1, 13), mc(1, 15));			{Subject}
					2: 
						Cmd := PercentAOfB(mc(1, 31), mc(1, 30), mc(1, 32));			{C1}
					3: 
						Cmd := PercentAOfB(mc(1, 48), mc(1, 47), mc(1, 49));			{C2}
					4: 
						Cmd := PercentAOfB(mc(1, 65), mc(1, 64), mc(1, 66));			{C3}
					5: 
						Cmd := PercentAOfB(mc(2, 14), mc(2, 13), mc(2, 15));			{Subject}
					6: 
						Cmd := PercentAOfB(mc(2, 32), mc(2, 31), mc(2, 33));			{C1#}
					7: 
						Cmd := PercentAOfB(mc(2, 50), mc(2, 49), mc(2, 51));			{C2#}
					8: 
						Cmd := PercentAOfB(mc(2, 68), mc(2, 67), mc(2, 69));			{C3#}
					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin
		case CompNum of
			1: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
			2: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
			3: 
				begin
					ProcessCurCellInfo(WPtr, 0);
				end;
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

function InfoSiteTotalRatio(doc: TContainer; CX: CellUID; SiteC, TotalC, InfoC: Integer): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, SiteC));   //est site value
  v2 := GetCellValue(doc, mcx(cx, TotalC));  //total by cost approach
  if (V1 <> 0) and (V2 <> 0) then
    begin
      VR := (V1 / V2) * 100;
      SetInfoCellValue(doc, mcx(cx,InfoC), VR);
    end;
  result := 0;
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


//Sales Comparison Approach Grid 1 Generic (short grid)
function F0662C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 30;
  TotalAdj  = 66;
  FinalAmt  = 67;
  PlusChk   = 64;
  NegChk    = 65;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,32), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,34), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,36), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,38), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,40), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,42), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,43), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,47), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,49), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);

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

function F0662C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 72;
  TotalAdj  = 108;
  FinalAmt  = 109;
  PlusChk   = 106;
  NegChk    = 107;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,80), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,82), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,84), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,99), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,101), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,103), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);

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

function F0662C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 114;
  TotalAdj  = 150;
  FinalAmt  = 151;
  PlusChk   = 148;
  NegChk    = 149;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,135), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);

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

//Sales Comparsion Grid 2 (Generic - Long grid)
function F0663C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 38;
  TotalAdj  = 92;
  FinalAmt  = 93;
  PlusChk   = 90;
  NegChk    = 91;
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
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
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

function F0663C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 98;
  TotalAdj  = 152;
  FinalAmt  = 153 ;
  PlusChk   = 150;
  NegChk    = 151;
  InfoNet   = 5;
  InfoGross = 6;
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
  GetNetGrosAdjs(doc, mcx(cx,137), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,143), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);

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

function F0663C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 158;
  TotalAdj  = 212;
  FinalAmt  = 213;
  PlusChk   = 210;
  NegChk    = 211;
  InfoNet   = 7;
  InfoGross = 8;
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
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
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

function F0664EffectAgeDepr(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,214));  {exp age}
  V2 := GetCellValue(doc, mcx(cx,215));  {eff age}
  VR := 0;
  if V1 + V2 <> 0 then
    VR := (V2 / (V1+V2)) * 100;
  result := SetCellValue(doc, mcx(cx,216), VR);
end;

function F0664DeprCosts(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,213));
  V2 := GetCellValue(doc, mcx(cx,217));
  V3 := GetCellValue(doc, mcx(cx,220));
  VR := V1 - V2 - V3;
  result := SetCellValue(doc, mcx(cx,221), VR);
end;

function F0664Process4Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0664Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0664Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0664Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0664Math(doc, C4, CX);
  result := 0;
end;


function F0664SignedValue(doc: TContainer; CX: CellUID; minus, value: Integer): Double;
var
  V1: Double;
  minusSign: String;
begin
  V1 := GetCellValue(doc, mcx(cx,value));
  if V1 <> 0 then
    begin
      minusSign := GetCellString(doc, mcx(cx,minus));
      minusSign := UpperCase(minusSign);
      if (compareText(minusSign, '-')=0) or (compareText(minusSign, 'X')=0) then
        V1 := -V1;
    end;
  result := V1;
end;

function F0664SumAdjustments1(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := GetCellValue(doc, mcx(cx,88));		{basic cost}
  VR := VR + F0664SignedValue(doc, cx, 93,94);
  VR := VR + F0664SignedValue(doc, cx, 99,100);
  VR := VR + F0664SignedValue(doc, cx, 105,106);
  VR := VR + F0664SignedValue(doc, cx, 111,112);
  VR := VR + F0664SignedValue(doc, cx, 117,118);
  VR := VR + F0664SignedValue(doc, cx, 123,124);
  VR := VR + F0664SignedValue(doc, cx, 129,130);
  VR := VR + F0664SignedValue(doc, cx, 135,136);
  VR := VR + F0664SignedValue(doc, cx, 141,142);
  VR := VR + F0664SignedValue(doc, cx, 147,148);
  VR := VR + F0664SignedValue(doc, cx, 153,154);
  result := SetCellValue(doc, mcx(cx,155), VR);
end;

function F0664SumAdjustments2(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := GetCellValue(doc, mcx(cx,155));		{basic cost}
  VR := VR + F0664SignedValue(doc, cx, 160,161);
  VR := VR + F0664SignedValue(doc, cx, 166,167);
  VR := VR + F0664SignedValue(doc, cx, 172,173);
  VR := VR + F0664SignedValue(doc, cx, 180,181);
  VR := VR + F0664SignedValue(doc, cx, 186,187);
  VR := VR + F0664SignedValue(doc, cx, 192,193);
  result := SetCellValue(doc, mcx(cx,194), VR);
end;

function F0664SumAdjustments3(doc: TContainer; CX: CellUID): Integer;
var
  VR: Double;
begin
  VR := 0;		{basic cost}
  VR := VR + F0664SignedValue(doc, cx, 199,200);
  VR := VR + F0664SignedValue(doc, cx, 205,206);
  result := SetCellValue(doc, mcx(cx,207), VR);
end;

function F0705Process6Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5,C6: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0705Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0705Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0705Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0705Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0705Math(doc, C5, CX);
  if C6 > 0 then ProcessForm0705Math(doc, C6, CX);
  result := 0;
end;


function F0705MultABC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
var
	V1, V2, V3, VR: Double;
begin
	result := 0;
	if CellHasData(doc, CellA) and CellHasData(doc, CellB) then
		begin
			V1 := GetCellValue(doc, CellA);
			V2 := GetCellValue(doc, CellB);
      V3 := 1.0;
      if CellHasData(doc, CellC) then
			  V3 := GetCellValue(doc, CellC);
			VR := V1 * V2 * V3;
			result := SetCellValue(doc, CellR, VR);
		end;
end;

procedure F0705ParseAreas(doc: TContainer; CX: CellUID; C1: Integer; var LV1,LV2,LV3,BV,GV,OV: Double);
var
  VX: Double;
  cell: TBaseCell;

  procedure UnCheckLivingAreas;
  begin
    if CellIsChecked(doc, mcx(cx,C1+4)) then
      if doc.GetValidCell(mcx(cx,C1+4), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
    if CellIsChecked(doc, mcx(cx,C1+5)) then
      if doc.GetValidCell(mcx(cx,C1+5), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
    if CellIsChecked(doc, mcx(cx,C1+6)) then
      if doc.GetValidCell(mcx(cx,C1+6), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
  end;

  procedure UnCheckMainAreas;
  begin
    if CellIsChecked(doc, mcx(cx,C1)) then   //living
      begin
        if doc.GetValidCell(mcx(cx,C1), cell) then
          begin
            cell.SetText('');          //set checkmark
            Cell.Display;               //display it
          end;
        UnCheckLivingAreas;
      end;
    if CellIsChecked(doc, mcx(cx,C1+1)) then    //basement
      if doc.GetValidCell(mcx(cx,C1+1), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
    if CellIsChecked(doc, mcx(cx,C1+2)) then    //garage
      if doc.GetValidCell(mcx(cx,C1+2), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
    if CellIsChecked(doc, mcx(cx,C1+3)) then    //other
      if doc.GetValidCell(mcx(cx,C1+3), cell) then
        begin
          cell.SetText('');          //set checkmark
          Cell.Display;               //display it
        end;
  end;

begin
  if CellHasData(doc, mcx(cx,C1-1)) then              //row has to have area value
    begin
      VX := GetCellValue(doc, mcx(cx,C1-1));          //get the area value
      if CellIsChecked(doc, mcx(cx,C1)) then             //living
        begin
          if CellIsChecked(doc, mcx(cx,C1+4)) then        //level 1
            begin
              LV1 := LV1 + VX;
            end
          else if CellIsChecked(doc, mcx(cx,C1+5)) then   //level 2
            begin
              LV2 := LV2 + VX;
            end
          else if CellIsChecked(doc, mcx(cx,C1+6)) then   //level 3
            begin
              LV3 := LV3 + VX;
            end
          else
            begin
              if doc.GetValidCell(mcx(cx,C1+4), cell) then
                begin
                  cell.SetText('X');          //set checkmark
                  Cell.Display;               //display it
                end;
              LV1 := LV1 + VX;
            end;
        end
      else if CellIsChecked(doc, mcx(cx,C1+1)) then      //basement
        begin
          BV := BV + VX;
          UnCheckLivingAreas;
        end
      else if CellIsChecked(doc, mcx(cx,C1+2)) then      //garage
        begin
          GV := GV + VX;
          UnCheckLivingAreas;
        end
      else if CellIsChecked(doc, mcx(cx,C1+3)) then      //other
        begin
          OV := OV + VX;
          UnCheckLivingAreas;
        end
      else   //nothing is checked
        begin
          if doc.GetValidCell(mcx(cx,C1), cell) then   //set living
            begin
              cell.SetText('X');          //set checkmark
              Cell.Display;                //display it
            end;
          if doc.GetValidCell(mcx(cx,C1+4), cell) then  //set first level
            begin
              cell.SetText('X');          //set checkmark
              Cell.Display;                //display it
            end;
          LV1 := LV1 + VX;
        end;
    end
  else  //the area has been erased, not not there anymore so uncheck boxes
    begin
      UnCheckMainAreas;
      UnCheckLivingAreas;
    end;
end;

function F0703CalcAreas(doc: TContainer; CX: CellUID): Integer;
var
  LV1,LV2,LV3,BV,GV,OV,GBA: Double;
begin
  LV1 := 0;
  LV2 := 0;
  LV3 := 0;
  BV := 0;
  GV := 0;
  OV := 0;

  F0705ParseAreas(doc, cx, 31, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 42, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 53, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 64, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 75, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 86, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 97, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 108, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 119, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 130, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 141, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 152, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 163, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 174, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 185, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 196, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 207, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 218, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 229, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 240, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 251, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 262, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 273, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 284, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 295, LV1,LV2,LV3,BV,GV,OV);
  F0705ParseAreas(doc, cx, 306, LV1,LV2,LV3,BV,GV,OV);

  SetCellValue(doc, mcx(cx,13), LV1+LV2+LV3);     //total living area
  SetCellValue(doc, mcx(cx,15), BV);              //basement
  SetCellValue(doc, mcx(cx,17), LV1);             //level 1
  SetCellValue(doc, mcx(cx,19), LV2);             //level 2
  SetCellValue(doc, mcx(cx,21), LV3);             //level 3
  SetCellValue(doc, mcx(cx,23), GV);              //garage
  SetCellValue(doc, mcx(cx,25), OV);              //other

  result := 27; //Execute the Gross Building Area percentages
end;


//Listings Comparison Analysis
function F0730C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 47,100,101,98,99,1,2,
            [52,54,56,58,60,62,64,66,68,70,71,75,77,79,81,83,85,87,89,91,93,95,97]);
end;

function F0730C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 106,159,160,157,158,3,4,
            [111,113,115,117,119,121,123,125,127,129,130,134,136,138,140,142,144,146,148,150,152,154,156]);
end;

function F0730C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
   result := SalesGridAdjustment(doc, CX, 165,218,219,216,217,5,6,
            [170,172,174,176,178,180,182,184,186,188,189,193,195,197,199,201,203,205,207,209,211,213,215]);
   //remove cellSeq 190 by Jeferson on 11/18/09         
end;

//Listings Comparison Analysis #2
function F0733C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 48,104,105,102,103,1,2,
            [54,56,58,60,62,64,66,68,70,72,74,75,79,81,83,85,87,89,91,93,95,97,99,101]);
end;

function F0733C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 110,166,167,164,165,3,4,
            [116,118,120,122,124,126,128,130,132,134,136,137,141,143,145,147,149,151,153,155,157,159,161,163]);
end;

function F0733C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 172,228,229,226,227,5,6,
            [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225]);
end;

//Green Point 2000
function F0787C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 37,92,93,90,91,4,5,
            [42,44,46,48,50,52,54,56,58,60,62,63,67,69,71,73,75,77,79,81,83,85,87,89]);
end;

function F0787C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 97,152,153,150,151,6,7,
            [102,104,106,108,110,112,114,116,118,120,122,123,127,129,131,133,135,137,139,141,143,145,147,149]);
end;

function F0787C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 157,212,213,210,211,8,9,
            [162,164,166,168,170,172,174,176,178,180,182,183,187,189,191,193,195,197,199,201,203,205,207,209]);
end;


//Green Point 2000 XComps
function F0781C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 38,93,94,91,92,4,5,
            [43,45,47,49,51,53,55,57,59,61,63,64,68,70,72,74,76,78,80,82,84,86,88,90]);
end;

function F0781C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 99,154,155,152,153,6,7,
            [104,106,108,110,112,114,116,118,120,122,124,125,129,131,133,135,137,139,141,143,145,147,149,151]);
end;

function F0781C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 160,215,216,213,214,8,9,
            [165,167,169,171,173,175,177,179,181,183,185,186,190,192,194,196,198,200,202,204,206,208,210,212]);
end;

function F4126C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 50;
  TotalAdj  = 105;
  FinalAmt  = 106;
  PlusChk   = 103;
  NegChk    = 104;
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
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
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

function F4126C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 110;
  TotalAdj  = 165;
  FinalAmt  = 166;
  PlusChk   = 163;
  NegChk    = 164;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
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

function F4126C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 170;
  TotalAdj  = 225;
  FinalAmt  = 226;
  PlusChk   = 223;
  NegChk    = 224;
  InfoNet   = 5;
  InfoGross = 6;
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

function F4127C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 52;
  TotalAdj  = 107;
  FinalAmt  = 108;
  PlusChk   = 105;
  NegChk    = 106;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);

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

function F4127C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 113;
  TotalAdj  = 168;
  FinalAmt  = 169;
  PlusChk   = 166;
  NegChk    = 167;
  InfoNet   = 3;
  InfoGross = 4;
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
  GetNetGrosAdjs(doc, mcx(cx,139), NetAdj, GrsAdj);
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

function F4127C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 174;
  TotalAdj  = 229;
  FinalAmt  = 230;
  PlusChk   = 227;
  NegChk    = 228;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,197), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,199), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
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


//Energy Addendum
function ProcessForm0651Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: begin end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Financial Addendum
function ProcessForm0654Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: begin end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Cost Approach Generic
function ProcessForm0660Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: begin end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Income Approach Generic
function ProcessForm0661Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: begin end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Sales Comparison Approach  (short grid)
function ProcessForm0662Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'SALES COMPARABLES', 'ADDENDUM',26,68,110, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Sales Comps', 26,68,110);
        3:
          cmd := ConfigXXXInstance(doc, cx, 26,68,110);

    //Comp1 calcs
        4:   //sales price changed
          cmd := F0662C1Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F0662C1Adjustments(doc, cx);       //sum of adjs

    //Comp2 calcs
        7:   //sales price changed
          cmd := F0662C2Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0662C2Adjustments(doc, cx);       //sum of adjs

    //Comp3 calcs
        10:   //sales price changed
          cmd := F0662C3Adjustments(doc, cx);     //redo the adjustments
        11:
          cmd := F0662C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := CalcWeightedAvg(doc, [662]);   //calc wtAvg of main and xcomps forms
        13:
          begin
            F0662C1Adjustments(doc, cx);       //sum of adjs
            F0662C2Adjustments(doc, cx);       //sum of adjs
            F0662C3Adjustments(doc, cx);       //sum of adjs
            Cmd := 0;
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
          ProcessForm0662Math(doc, 5, CX);
          ProcessForm0662Math(doc, 8, CX);
          ProcessForm0662Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0662Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

//Sales Comparison Generic (longer grid)
function ProcessForm0663Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'SALES COMPARABLES', 'ADDENDUM',34,94,154, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Sale Comps', 34,94,154);
        3:
          cmd := ConfigXXXInstance(doc, cx, 34,94,154);
//Comp1 calcs
        4:   //sales price changed
          begin
            ProcessForm0663Math(doc, 6, CX);        //calc new price/sqft
            cmd := F0663C1Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0663C1Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,64), mcx(cx,39));     //price/sqft

//Comp2 calcs
        7:   //sales price changed
          begin
            ProcessForm0663Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0663C2Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0663C2Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,98), mcx(cx,124), mcx(cx,99));     //price/sqft

//Comp3 calcs
        10:   //sales price changed
          begin
            ProcessForm0663Math(doc, 12, CX);     //calc new price/sqft
            cmd := F0663C3Adjustments(doc, cx);     //redo the adjustments
          end;
        11:
          cmd := F0663C3Adjustments(doc, cx);       //sum of adjs
        12:
          cmd := DivideAB(doc, mcx(cx,158), mcx(cx,184), mcx(cx,159));     //price/sqft

        13:
          cmd := DivideAB(doc, mcx(cx,8), mcx(cx,21), mcx(cx,9));     //Subj price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [663]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0663C1Adjustments(doc, cx);       //sum of adjs
            F0663C2Adjustments(doc, cx);       //sum of adjs
            F0663C3Adjustments(doc, cx);       //sum of adjs
            Cmd := 0;
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
          ProcessForm0663Math(doc, 5, CX);
          ProcessForm0663Math(doc, 8, CX);
          ProcessForm0663Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0663Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//Sqft Cost Analysis
function ProcessForm0664Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := MultABC(doc, mcx(cx,85), mcx(cx,86), mcx(cx,87), mcx(cx,88));    //basic cost
        2:
          Cmd := MultAB(doc, mcx(cx,90), mcx(cx,91), mcx(cx,94));
        3:
          Cmd := MultAB(doc, mcx(cx,96), mcx(cx,97), mcx(cx,100));
        4:
          Cmd := MultAB(doc, mcx(cx,102), mcx(cx,103), mcx(cx,106));
        5:
          Cmd := MultAB(doc, mcx(cx,108), mcx(cx,109), mcx(cx,112));
        6:
          Cmd := MultAB(doc, mcx(cx,114), mcx(cx,115), mcx(cx,118));
        7:
          Cmd := MultAB(doc, mcx(cx,120), mcx(cx,121), mcx(cx,124));
        8:
          Cmd := MultAB(doc, mcx(cx,126), mcx(cx,127), mcx(cx,130));
        9:
          Cmd := MultAB(doc, mcx(cx,132), mcx(cx,133), mcx(cx,136));
        10:
          Cmd := MultAB(doc, mcx(cx,138), mcx(cx,139), mcx(cx,142));
        11:
          Cmd := MultAB(doc, mcx(cx,144), mcx(cx,145), mcx(cx,148));
        12:
          Cmd := MultAB(doc, mcx(cx,150), mcx(cx,151), mcx(cx,154));
        13:
          cmd := F0664SumAdjustments1(doc, cx);
        14:
          Cmd := MultABC(doc, mcx(cx,156), mcx(cx,157), mcx(cx,158), mcx(cx,161));
        15:
          Cmd := MultAB(doc, mcx(cx,163), mcx(cx,164), mcx(cx,167));
        16:
          Cmd := MultAB(doc, mcx(cx,169), mcx(cx,170), mcx(cx,173));
        17:
          Cmd := MultAB(doc, mcx(cx,177), mcx(cx,178), mcx(cx,181));
        18:
          Cmd := MultAB(doc, mcx(cx,183), mcx(cx,184), mcx(cx,187));
        19:
          Cmd := MultAB(doc, mcx(cx,189), mcx(cx,190), mcx(cx,193));
        20:
          cmd := F0664SumAdjustments2(doc, cx);
        21:
          cmd := MultAB(doc, mcx(cx,196), mcx(cx,197), mcx(cx,200));
        22:
          cmd := MultAB(doc, mcx(cx,202), mcx(cx,203), mcx(cx,206));
        23:
          cmd := F0664SumAdjustments3(doc, cx);
        24:
          cmd := SumAB(doc, mcx(cx,194), mcx(cx,207), mcx(cx,208));
        25:
          cmd := MultAB(doc, mcx(cx,208), mcx(cx,212), mcx(cx,213));
        26:
          cmd := MultAB(doc, mcx(cx,209), mcx(cx,210), mcx(cx,212));
        27:
          cmd := F0664EffectAgeDepr(doc, cx);
        28:
          cmd := MultPercentAB(doc, mcx(cx,213), mcx(cx,216), mcx(cx,217));
        29:
          cmd := F0664Process4Cmds(doc, CX, 27,28,0,0);
        30:
          cmd := F0664DeprCosts(doc, cx);
        31:
          cmd := SumFourCellsR(doc, cx, 221,222,224,226, 227);
        32:
          cmd := SumABC(doc, mcx(cx,20), mcx(cx,21), mcx(cx,22), mcx(cx,23));

        40: Cmd := MultAB(doc, mcx(cx,6), mcx(cx,7), mcx(cx,8));
        41: Cmd := MultAB(doc, mcx(cx,13), mcx(cx,14), mcx(cx,15));
        42: Cmd := MultAB(doc, mcx(cx,20), mcx(cx,21), mcx(cx,22));
        43: Cmd := MultAB(doc, mcx(cx,27), mcx(cx,28), mcx(cx,29));
        44: Cmd := MultAB(doc, mcx(cx,34), mcx(cx,35), mcx(cx,36));
        45: Cmd := MultAB(doc, mcx(cx,41), mcx(cx,42), mcx(cx,43));
        46: Cmd := MultAB(doc, mcx(cx,48), mcx(cx,49), mcx(cx,50));
        47: Cmd := MultAB(doc, mcx(cx,55), mcx(cx,56), mcx(cx,57));
        48: Cmd := MultAB(doc, mcx(cx,62), mcx(cx,63), mcx(cx,64));
        49: Cmd := MultAB(doc, mcx(cx,69), mcx(cx,70), mcx(cx,71));

        50: Cmd := MultPercentAB(doc, mcx(cx,8), mcx(cx,10), mcx(cx,11));
        51: Cmd := MultPercentAB(doc, mcx(cx,15), mcx(cx,17), mcx(cx,18));
        52: Cmd := MultPercentAB(doc, mcx(cx,22), mcx(cx,24), mcx(cx,25));
        53: Cmd := MultPercentAB(doc, mcx(cx,29), mcx(cx,31), mcx(cx,32));
        54: Cmd := MultPercentAB(doc, mcx(cx,36), mcx(cx,38), mcx(cx,39));
        55: Cmd := MultPercentAB(doc, mcx(cx,43), mcx(cx,45), mcx(cx,46));
        56: Cmd := MultPercentAB(doc, mcx(cx,50), mcx(cx,52), mcx(cx,53));
        57: Cmd := MultPercentAB(doc, mcx(cx,57), mcx(cx,59), mcx(cx,60));
        58: Cmd := MultPercentAB(doc, mcx(cx,64), mcx(cx,66), mcx(cx,67));
        59: Cmd := MultPercentAB(doc, mcx(cx,71), mcx(cx,73), mcx(cx,74));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0705Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
var
  GBA,GLA: Double;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := F0705MultABC(doc, mcx(cx,27),mcx(cx,28),mcx(cx,29), mcx(cx,30));
        2: Cmd := F0705MultABC(doc, mcx(cx,38),mcx(cx,39),mcx(cx,40), mcx(cx,41));
        3: Cmd := F0705MultABC(doc, mcx(cx,49),mcx(cx,50),mcx(cx,51), mcx(cx,52));
        4: Cmd := F0705MultABC(doc, mcx(cx,60),mcx(cx,61),mcx(cx,62), mcx(cx,63));
        5: Cmd := F0705MultABC(doc, mcx(cx,71),mcx(cx,72),mcx(cx,73), mcx(cx,74));
        6: Cmd := F0705MultABC(doc, mcx(cx,82),mcx(cx,83),mcx(cx,84), mcx(cx,85));
        7: Cmd := F0705MultABC(doc, mcx(cx,93),mcx(cx,94),mcx(cx,95), mcx(cx,96));
        8: Cmd := F0705MultABC(doc, mcx(cx,104),mcx(cx,105),mcx(cx,106), mcx(cx,107));
        9: Cmd := F0705MultABC(doc, mcx(cx,115),mcx(cx,116),mcx(cx,117), mcx(cx,118));
        10: Cmd := F0705MultABC(doc, mcx(cx,126),mcx(cx,127),mcx(cx,128), mcx(cx,129));
        11: Cmd := F0705MultABC(doc, mcx(cx,137),mcx(cx,138),mcx(cx,139), mcx(cx,140));
        12: Cmd := F0705MultABC(doc, mcx(cx,148),mcx(cx,149),mcx(cx,150), mcx(cx,151));
        13: Cmd := F0705MultABC(doc, mcx(cx,159),mcx(cx,160),mcx(cx,161), mcx(cx,162));
        14: Cmd := F0705MultABC(doc, mcx(cx,170),mcx(cx,171),mcx(cx,172), mcx(cx,173));
        15: Cmd := F0705MultABC(doc, mcx(cx,181),mcx(cx,182),mcx(cx,183), mcx(cx,184));
        16: Cmd := F0705MultABC(doc, mcx(cx,192),mcx(cx,193),mcx(cx,194), mcx(cx,195));
        17: Cmd := F0705MultABC(doc, mcx(cx,203),mcx(cx,204),mcx(cx,205), mcx(cx,206));
        18: Cmd := F0705MultABC(doc, mcx(cx,214),mcx(cx,215),mcx(cx,216), mcx(cx,217));
        19: Cmd := F0705MultABC(doc, mcx(cx,225),mcx(cx,226),mcx(cx,227), mcx(cx,228));
        20: Cmd := F0705MultABC(doc, mcx(cx,236),mcx(cx,237),mcx(cx,238), mcx(cx,239));
        21: Cmd := F0705MultABC(doc, mcx(cx,247),mcx(cx,248),mcx(cx,249), mcx(cx,250));
        22: Cmd := F0705MultABC(doc, mcx(cx,258),mcx(cx,259),mcx(cx,260), mcx(cx,261));
        23: Cmd := F0705MultABC(doc, mcx(cx,269),mcx(cx,270),mcx(cx,271), mcx(cx,272));
        24: Cmd := F0705MultABC(doc, mcx(cx,280),mcx(cx,281),mcx(cx,282), mcx(cx,283));
        25: Cmd := F0705MultABC(doc, mcx(cx,291),mcx(cx,292),mcx(cx,293), mcx(cx,294));
        26: Cmd := F0705MultABC(doc, mcx(cx,302),mcx(cx,303),mcx(cx,304), mcx(cx,305));
        27: Cmd := F0705Process6Cmds(doc,cx, 30,31,32,33,34,35);
        30: Cmd := PercentAOfB(doc, mcx(cx,15),mcx(cx,14), mcx(cx,16));
        31: Cmd := PercentAOfB(doc, mcx(cx,17),mcx(cx,14), mcx(cx,18));
        32: Cmd := PercentAOfB(doc, mcx(cx,19),mcx(cx,14), mcx(cx,20));
        33: Cmd := PercentAOfB(doc, mcx(cx,21),mcx(cx,14), mcx(cx,22));
        34: Cmd := PercentAOfB(doc, mcx(cx,23),mcx(cx,14), mcx(cx,24));
        35: Cmd := PercentAOfB(doc, mcx(cx,25),mcx(cx,14), mcx(cx,26));

        41: Cmd := F0703CalcAreas(doc, cx);
        42: Cmd := F0703CalcAreas(doc, cx);
        43: Cmd := F0703CalcAreas(doc, cx);
        44: Cmd := F0703CalcAreas(doc, cx);
        45: Cmd := F0703CalcAreas(doc, cx);
        46: Cmd := F0703CalcAreas(doc, cx);
        47: Cmd := F0703CalcAreas(doc, cx);
        48: Cmd := F0703CalcAreas(doc, cx);
        49: Cmd := F0703CalcAreas(doc, cx);
        50: Cmd := F0703CalcAreas(doc, cx);
        51: Cmd := F0703CalcAreas(doc, cx);
        52: Cmd := F0703CalcAreas(doc, cx);
        53: Cmd := F0703CalcAreas(doc, cx);
        54: Cmd := F0703CalcAreas(doc, cx);
        55: Cmd := F0703CalcAreas(doc, cx);
        56: Cmd := F0703CalcAreas(doc, cx);
        57: Cmd := F0703CalcAreas(doc, cx);
        58: Cmd := F0703CalcAreas(doc, cx);
        59: Cmd := F0703CalcAreas(doc, cx);
        60: Cmd := F0703CalcAreas(doc, cx);
        61: Cmd := F0703CalcAreas(doc, cx);
        62: Cmd := F0703CalcAreas(doc, cx);
        63: Cmd := F0703CalcAreas(doc, cx);
        64: Cmd := F0703CalcAreas(doc, cx);
        65: Cmd := F0703CalcAreas(doc, cx);
        66: Cmd := F0703CalcAreas(doc, cx);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  //Ticket #1472: after we calculate LV1, LV2, LV3, GV, OV, BV values, we need to sum up to get GBA area
  GLA := GetCellValue(doc, MCX(cx, 17)) + GetCellValue(doc, MCX(cx, 19)) +  GetCellValue(doc, MCX(cx, 21));
  SetCellValue(doc, mcx(cx,13), GLA);
  GBA := GetCellValue(doc, MCX(cx, 15))+ GetCellValue(doc, MCX(cx, 17)) + GetCellValue(doc, MCX(cx, 19)) +
         GetCellValue(doc, MCX(cx, 21)) + GetCellValue(doc, MCX(cx, 23)) + GetCellValue(doc, MCX(cx, 25));
  SetCellValue(doc, mcx(cx,14), GBA);
  result := 0;
end;

function ProcessForm0730Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Listings Comparison Analysis', 43,102,161);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'LISTINGS COMPARISON ANALYSIS','', 43,102,161, 2);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 43,102,161);

        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,29), mcx(cx,17));     //Subj price/sqft
        5:
          Cmd := ProcessMultipleCmds(ProcessForm0730Math, doc, CX,[7,6]);
        6:
          Cmd := F0730C1Adjustments(doc, cx);
        7:
          cmd := DivideAB(doc, mcx(cx,47), mcx(cx,76), mcx(cx,48));     //price/sqft
        8:
          Cmd := ProcessMultipleCmds(ProcessForm0730Math, doc, CX,[10,9]);
        9:
          Cmd := F0730C2Adjustments(doc, cx);
        10:
          cmd := DivideAB(doc, mcx(cx,106), mcx(cx,135), mcx(cx,107));     //price/sqft
        11:
          Cmd := ProcessMultipleCmds(ProcessForm0730Math, doc, CX,[13,12]);
        12:
          Cmd := F0730C3Adjustments(doc, cx);
        13:
          cmd := DivideAB(doc, mcx(cx,165), mcx(cx,194), mcx(cx,166));     //price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [730]);   //calc wtAvg
        15:
          begin
            F0730C1Adjustments(doc, cx);
            F0730C2Adjustments(doc, cx);     //sum of adjs
            F0730C3Adjustments(doc, cx);
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
          ProcessForm0730Math(doc, 6, CX);
          ProcessForm0730Math(doc, 9, CX);
          ProcessForm0730Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0730Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0733Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Listings Comparison Analysis', 44,106,168);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'LISTINGS COMPARISON ANALYSIS','', 44,106,168, 2);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 44,106,168);
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,30), mcx(cx,17));     //Subj price/sqft
        5:
          Cmd := ProcessMultipleCmds(ProcessForm0733Math, doc, CX,[7,6]);
        6:
          Cmd := F0733C1Adjustments(doc, cx);
        7:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,80), mcx(cx,49));     //price/sqft
        8:
          Cmd := ProcessMultipleCmds(ProcessForm0733Math, doc, CX,[10,9]);
        9:
          Cmd := F0733C2Adjustments(doc, cx);
        10:
          cmd := DivideAB(doc, mcx(cx,110), mcx(cx,142), mcx(cx,111));     //price/sqft
        11:
          Cmd := ProcessMultipleCmds(ProcessForm0733Math, doc, CX,[13,12]);
        12:
          Cmd := F0733C3Adjustments(doc, cx);
        13:
          cmd := DivideAB(doc, mcx(cx,172), mcx(cx,204), mcx(cx,173));     //price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [733]);   //calc wtAvg
        15:
          begin
            F0733C1Adjustments(doc, cx);
            F0733C2Adjustments(doc, cx);     //sum of adjs
            F0733C3Adjustments(doc, cx);
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
          ProcessForm0733Math(doc, 6, CX);
          ProcessForm0733Math(doc, 9, CX);
          ProcessForm0733Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0733Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;


function ProcessForm0729Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumCellArray(doc, CX, [14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62], 63);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm4344Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumCellArray(doc, CX, [14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50], 51);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


/// summary: Provides math for the VA Liquidation Appraisal Addendum (693).
/// remarks: Replaced by the VA Liquidation Appraisal Addendum (947).
function ProcessForm0693Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumCellArray(doc, CX, [35,39,43,47,51], 53);
        2:
          Cmd := SumCellArray(doc, CX, [36,40,44,48,52], 54);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm0787Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := ProcessMultipleCmds(ProcessForm0787Math, doc, CX,[2,3]); //C1 sales price
        2:
          Cmd := F0787C1Adjustments(doc, cx);
        3:
          cmd := DivideAB(doc, mcx(cx,37), mcx(cx,68), mcx(cx,38));     //C1 price/sqft
        4:
          cmd := ProcessMultipleCmds(ProcessForm0787Math, doc, CX,[5,6]); //C2 sales price
        5:
          Cmd := F0787C2Adjustments(doc, cx);
        6:
          cmd := DivideAB(doc, mcx(cx,97), mcx(cx,128), mcx(cx,98));  //C2 price/sqft          
        7:
          cmd := ProcessMultipleCmds(ProcessForm0787Math, doc, CX,[8,9]); //C3 sales price
        8:
          Cmd := F0787C3Adjustments(doc, cx);
        9:
          cmd := DivideAB(doc, mcx(cx,157), mcx(cx,188), mcx(cx,158));  //C3 price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,22), mcx(cx,8));     //Subj price/sqft
        14:
          Cmd := CalcWeightedAvg(doc, [787,781]);   //calc wtAvg of main and xcomps forms
        15:
          begin                              //Math ID 15 is for Weighted Average
            F0787C1Adjustments(doc, cx);     //sum of adjs
            F0787C2Adjustments(doc, cx);     //sum of adjs
            F0787C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          CX.pg := 2;    //math is on page 3
          ProcessForm0787Math(doc, 2, CX);
          ProcessForm0787Math(doc, 5, CX);
          ProcessForm0787Math(doc, 8, CX);
        end;
      -2:
        begin
           CX.pg := 2;    //math is on page 3
          ProcessForm0787Math(doc, 15, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0781Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := ProcessMultipleCmds(ProcessForm0781Math, doc, CX,[2,3]); //C1 sales price
        2:
          Cmd := F0781C1Adjustments(doc, cx);
        3:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,69), mcx(cx,39));     //C1 price/sqft
        4:
          cmd := ProcessMultipleCmds(ProcessForm0781Math, doc, CX,[5,6]); //C2 sales price
        5:
          Cmd := F0781C2Adjustments(doc, cx);
        6:
          cmd := DivideAB(doc, mcx(cx,99), mcx(cx,130), mcx(cx,100));  //C2 price/sqft
        7:
          cmd := ProcessMultipleCmds(ProcessForm0781Math, doc, CX,[8,9]); //C3 sales price
        8:
          Cmd := F0781C3Adjustments(doc, cx);
        9:
          cmd := DivideAB(doc, mcx(cx,160), mcx(cx,191), mcx(cx,161));  //C3 price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,22), mcx(cx,8));     //Subj price/sqft
        11:
          cmd := SetXXXPageTitleBarName(doc, cx, 'GP 2000 Extra Comps', 34,95,156);
        14:
          Cmd := CalcWeightedAvg(doc, [787,781]);   //calc wtAvg of main and xcomps forms
        15:
          cmd := ConfigXXXInstance(doc, cx, 34,95,156);
        16:
          begin                              //Math ID 16 is for Weighted Average
            F0781C1Adjustments(doc, cx);     //sum of adjs
            F0781C2Adjustments(doc, cx);     //sum of adjs
            F0781C3Adjustments(doc, cx);     //sum of adjs
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -1:
        begin
          ProcessForm0781Math(doc, 2, CX);
          ProcessForm0781Math(doc, 5, CX);
          ProcessForm0781Math(doc, 8, CX);
        end;
      -2:
        begin
          ProcessForm0781Math(doc, 16, CX);
        end;
    end;
  result := 0;
end;

/// summary: Processes math for the Repair and Maintenance Addendum (890).
function ProcessForm0890Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := SumCellArray(doc, CX, [14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40], 43);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

/// summary: Processes math for the Solidifi Desktop Summary Appraisal (4211).
function ProcessForm4211Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //github #871
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := DivideAB_R(doc, CX, 61, 68, 62);  //github 374 updated form 05/24/2016
        2: Cmd := DivideAB_R(doc, CX, 81, 89, 82);
        3: Cmd := DivideAB_R(doc, CX, 105, 113, 106);
        4: Cmd := DivideAB_R(doc, CX, 129, 137, 130);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

function ProcessForm4261Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //github #871
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        9:
          Cmd := F4261C1Adjustments(doc, cx);
        10:
          Cmd := F4261C2Adjustments(doc, cx);
        11:
          Cmd := F4261C3Adjustments(doc, cx);
        12:
          Cmd := ProcessMultipleCmds(ProcessForm4261Math, doc, CX,[21,9]); //C1 sales price
        13:
          Cmd := ProcessMultipleCmds(ProcessForm4261Math, doc, CX,[22,10]); //C2 sales price
        14:
          Cmd := ProcessMultipleCmds(ProcessForm4261Math, doc, CX,[23,11]); //C1 sales price
        15:
          Cmd := CalcWeightedAvg(doc, [4261]);   //calc wtAvg of main form
        20:
          Cmd := DivideAB(doc, mcx(cx,59), mcx(cx,68), mcx(cx,60));     //Subj price/sqft
        21:
          Cmd := DivideAB(doc, mcx(cx,81), mcx(cx,98), mcx(cx,82));     //Comp1 price/sqft
        22:
          Cmd := DivideAB(doc, mcx(cx,120), mcx(cx,137), mcx(cx,121));     //Comp2 price/sqft
        23:
          Cmd := DivideAB(doc, mcx(cx,159), mcx(cx,176), mcx(cx,160));     //Comp3 price/sqft
        24:
          begin //refresh adjustment, no recursion
            F4261C1Adjustments(doc, cx);
            F4261C2Adjustments(doc, cx);
            F4261C3Adjustments(doc, cx);
            cmd := 0;
          end;
        25:  //none property damage
          begin
            if CellIsChecked(doc, mcx(cx,12)) then
              begin
                SetCellChkMark(doc, mcx(CX, 13), False);   //doors
                SetCellChkMark(doc, mcx(CX, 14), False);   //siding
                SetCellChkMark(doc, mcx(CX, 15), False);   //foundation
                SetCellChkMark(doc, mcx(CX, 16), False);   //roof
                SetCellChkMark(doc, mcx(CX, 17), False);   //windows
                SetCellChkMark(doc, mcx(CX, 18), False);   //driveway
                SetCellChkMark(doc, mcx(CX, 19), False);    //other
              end;
              Cmd := 0;
            end;
          26:  //property damage
            Cmd := SetCellChkMark(doc, mcx(CX, 12), False);
          27:  //none adverse neighborhood attributes
          begin
            if CellIsChecked(doc, mcx(cx,37)) then
              begin
                SetCellChkMark(doc, mcx(CX, 38), False);   //power lines
                SetCellChkMark(doc, mcx(CX, 39), False);   //boarded
                SetCellChkMark(doc, mcx(CX, 40), False);   //odors
                SetCellChkMark(doc, mcx(CX, 41), False);   //vacant
                SetCellChkMark(doc, mcx(CX, 42), False);   //highway
                SetCellChkMark(doc, mcx(CX, 43), False);   //airport
                SetCellChkMark(doc, mcx(CX, 44), False);    //railroad
                SetCellChkMark(doc, mcx(CX, 45), False);    //streets
                SetCellChkMark(doc, mcx(CX, 46), False);    //industrial
                SetCellChkMark(doc, mcx(CX, 47), False);    //other
              end;
              Cmd := 0;
            end;
          28:   //adverse neighborhood attributes
            Cmd := SetCellChkMark(doc, mcx(CX, 37), False);
           29:  //none beneficial neighborhood attributes
          begin
            if CellIsChecked(doc, mcx(cx,50)) then
              begin
                SetCellChkMark(doc, mcx(CX, 51), False);   //golf
                SetCellChkMark(doc, mcx(CX, 52), False);   //park, pools
                SetCellChkMark(doc, mcx(CX, 53), False);   //watefront
                SetCellChkMark(doc, mcx(CX, 54), False);    //other
              end;
              Cmd := 0;
            end;
          30:   //beneficiale neighborhood attributes
            Cmd := SetCellChkMark(doc, mcx(CX, 50), False);
           31:  //none garages or carports
          begin
            if CellIsChecked(doc, mcx(cx,81)) then
              begin
                SetCellChkMark(doc, mcx(CX, 85), False);   //one car
                SetCellChkMark(doc, mcx(CX, 86), False);   //2 cars
                SetCellChkMark(doc, mcx(CX, 87), False);   //3 cars
              end;
              Cmd := 0;
            end;
          32:   //# of cars
            if CellIsChecked(doc, mcx(cx, 81)) then  //Ticket #1511: check if the None check box is checked, clear it.
             cmd := SetCellChkMark(doc, mcx(CX, 81), False)
            else
              cmd := 0;
       else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of
      WeightedAvergeID: //-2, Average Sale Price
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm4261Math(doc, 24, CX);
        end;
      end;
  result := 0;
end;

/// summary: Processes math for the Solidifi Desktop Summary X Comps (4091).
function ProcessForm4091Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
         1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 36,61,86);  //github 374 updated form 5/24/2016
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 36,61,86, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 36,61,86);
        4:    Cmd := DivideAB_R(doc, CX, 21, 28, 22);
        5, 8: Cmd := DivideAB_R(doc, CX, 42, 50, 43);
        6, 9: Cmd := DivideAB_R(doc, CX, 67, 75, 68);
        7, 10: Cmd := DivideAB_R(doc, CX, 92, 100, 93);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

/// summary: Provides math for the VA Liquidation Appraisal Addendum (947).
/// remarks: Replaces the VA Liquidation Appraisal Addendum (693).
function ProcessForm0947Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := SumCellArray(Doc, CX, [35, 39, 43, 47, 51, 55, 59, 63, 67, 71], 73);
        2: Cmd := SumCellArray(Doc, CX, [36, 40, 44, 48, 52, 56, 60, 64, 68, 72], 74);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

/// summary: Provides math for the Minimum Property Requirements (MPR) Addendum (948).
function ProcessForm0948Math(Doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := SumCellArray(Doc, CX, [17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93, 97], 99);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

/// summary: Provides math for the Minimum Property Requirements (MPR) Required Repairs Addendum (953).
function ProcessForm0953Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := SumCellArray(Doc, CX, [14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34], 35);
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

/// summary: Provides math for the Wells Fargo RVS Desktop summary appraisal (954).
function ProcessForm0954Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd > 0) then
    repeat
      case Cmd of
        1: Cmd := DivideAB(Doc, MCX(CX, 67),  MCX(CX, 84),  MCX(CX, 68));
        2: Cmd := DivideAB(Doc, MCX(CX, 99),  MCX(CX, 116), MCX(CX, 100));
        3: Cmd := DivideAB(Doc, MCX(CX, 132), MCX(CX, 149), MCX(CX, 133));
        4: Cmd := DivideAB(Doc, MCX(CX, 165), MCX(CX, 182), MCX(CX, 166));
        5: Cmd := DivideAB(Doc, MCX(CX, 7),   MCX(CX, 24),  MCX(CX, 8));
        6: Cmd := DivideAB(Doc, MCX(CX, 39),  MCX(CX, 56),  MCX(CX, 40));
        7: Cmd := DivideAB(Doc, MCX(CX, 72),  MCX(CX, 89),  MCX(CX, 73));
        8: Cmd := DivideAB(Doc, MCX(CX, 105), MCX(CX, 122), MCX(CX, 106));
      else
        Cmd := 0;
      end;
    until (Cmd = 0);
  Result := 0;
end;

function ProcessForm4126Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
 if Cmd > 0 then
    repeat
      case Cmd of
//GLA
        4:
          Cmd := DivideAB_R(doc, CX, 15, 33, 16);
        7:
          Cmd := DivideAB_R(doc, CX, 50, 81, 51);
        10:
          Cmd := DivideAB_R(doc, CX, 110, 141, 111);
        13:
          Cmd := DivideAB_R(doc, CX, 170, 201, 171);

//Comp1 calcs
        5:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4126Math,doc,CX,[7,6]);    //GLA, redo the adjustments
        6:
          cmd := F4126C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        8:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4126Math,doc,CX,[10,9]);    //GLA, redo the adjustments
        9:
          cmd := F4126C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        11:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4126Math,doc,CX,[13,12]);    //GLA, redo the adjustments
        12:
          cmd := F4126C3Adjustments(doc, cx);       //sum of adjs

//all together
        15:
          begin //no recursion
            F4126C1Adjustments(doc, cx);
            F4126C2Adjustments(doc, cx);
            F4126C3Adjustments(doc, cx);
            cmd := 0;
          end;

        14:
          cmd := CalcWeightedAvg(doc, [4126, 4127]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
 else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 0;    //math is on page 2 (zero based)
          ProcessForm4126Math(doc, 15, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 2 (zero based)
          ProcessForm4126Math(doc, 15, CX);
        end;
    end;
 Result := 0;
end;

function ProcessForm4127Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 48,109,170);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 48,109,170, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,109,170);
      //GLA
        4:
          Cmd := DivideAB_R(doc, CX, 16, 34, 17);
        7:
          Cmd := DivideAB_R(doc, CX, 52, 83, 53);
        10:
          Cmd := DivideAB_R(doc, CX, 113, 144, 114);
        13:
          Cmd := DivideAB_R(doc, CX, 174, 205, 175);

        //Comp1 calcs
        5:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4127Math,doc,CX,[7,6]);    //GLA, redo the adjustments
        6:
          cmd := F4127C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        8:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4127Math,doc,CX,[10,9]);    //GLA, redo the adjustments
        9:
          cmd := F4127C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        11:   //sales price changed
          cmd := ProcessMultipleCmds(ProcessForm4127Math,doc,CX,[13,12]);    //GLA, redo the adjustments
        12:
          cmd := F4127C3Adjustments(doc, cx);       //sum of adjs

//all together
        15:
          begin //no recursion
            F4127C1Adjustments(doc, cx);
            F4127C2Adjustments(doc, cx);
            F4127C3Adjustments(doc, cx);
            cmd := 0;
          end;

        14:
          cmd := CalcWeightedAvg(doc, [4126, 4127]);   //calc wtAvg of main and xcomps forms
   else
        Cmd := 0;
      end;
    until Cmd = 0
 else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 0;    //math is on page 2 (zero based)
          ProcessForm4127Math(doc, 15, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 2 (zero based)
          ProcessForm4127Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0298Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  result := 0;
  if Cmd > 0 then
    repeat
      case Cmd of
        5: cmd := DivideAB(doc, mcx(cx,64), mcx(cx,75), mcx(cx,65));     //Comp1 price/sqft
        6: cmd := DivideAB(doc, mcx(cx,87), mcx(cx,98), mcx(cx,88));     //Comp2 price/sqft
        7: cmd := DivideAB(doc, mcx(cx,110), mcx(cx,121), mcx(cx,111));     //Comp3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0
end;

function F4261C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,77));   //get the address
  result := SalesGridAdjustment(doc, CX, 81,114,115,112,113,2,3,
      [84, 86, 88,90, 92, 93,97,99, 101, 103,105, 107, 109, 111],length(addr) > 0);
end;

function F4261C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,116));   //get the address
  result := SalesGridAdjustment(doc, CX, 120,153,154,151,152,4,5,
      [123, 125, 127,129, 131, 132,136,138, 140, 142,144, 146, 148, 150],length(addr) > 0);
end;

function F4261C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,155));   //get the address
  result := SalesGridAdjustment(doc, CX, 159,192,193,190,191,6,7,
      [162, 164, 166,168, 170, 171,175,177, 179, 181,183, 185, 187, 189],length(addr) > 0);
end;

//PAM: Ticket #: start math 4275
function F4275AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  Cmd: Integer;
begin
  result := 0;
  S1 := GetCellString(doc, MCPX(CX,1,175));   //eff age
  S2 := GetCellString(doc, MCPX(CX,3,25));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      Cmd := SetCellValue(doc, MCPX(CX,3,53), VR);
      ProcessForm4275Math(doc, Cmd, MCPX(CX,3,53));
    end;
end;

function F4275C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 110,169,170,167,168,1,2,
      [115,117,119,121,123,125,127,129,131,133,135,136,140,142,144,146,148,150,152,154,156,158,160,162,164,166],True);
end;

function F4275C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 174,233,234,231,232,3,4,
      [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226,228,230], True);
end;

function F4275C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 238,297,298,295,296,5,6,
      [243,245,247,249,251,253,255,257,259,261,263,264,268,270,272,274,276,278,280,282,284,286,288,290,292,294], True);
end;



function F4275Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 194));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 3,30), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 3,31), V1);
      ProcessForm4275Math(doc, Cmd, MCPX(CX, 3,31));
    end;
  result := 0;
end;


function F4275Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  Cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx, 194));			{bsmt sqft}
  S2 := '';
  if (GetCellValue(doc, mcx(cx, 195)) = 0) or (GetCellValue(doc, mcx(cx, 195)) = 100) then
    S2 := 'Full'
  else
    S2 := 'Partial';

  if GoodNumber(S1) then
    begin
      S3 := S1;
      if appPref_AppraiserAddBsmtSFSuffix then
        S3 := S1+' sf';

      if length(S2)>0 then
        S3 := S2 + '/' + S3;
    end;

  if length(S3)>0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,90), S3); //transfer to grid
      ProcessForm4275Math(doc, Cmd, MCPX(CX,2,90));
    end;

  result := 0;
end;


function F4275SumCost(doc:TContainer; cx: CellUID; C1,C2,C3,C4,C5,C6,C7,CR:Integer):Integer;              //sum costs
var
  V1, V2, VR: Double;
begin
  result := 0;
  V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
  V2 := Get4CellSumR(doc, cx, C5, C6, C7, 0);
  VR := V1 + V2;
  if VR > 0 then
    SetCellValue(doc, MCPX(cx, 3, CR), VR);
end;

function F4275NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, MCPX(CX,2,49)) then
    begin
      SetCellString(doc, MCPX(CX,2,51), '');
      SetCellString(doc, MCPX(CX,2,53), '');
      SetCellString(doc, MCPX(CX,2,55), '');
      SetCellString(doc, MCPX(CX,2,57), '');
      SetCellString(doc, MCPX(CX,2,59), '');
      SetCellString(doc, MCPX(CX,2,61), '');

      SetCellString(doc, MCPX(CX,2,52), '');
      SetCellString(doc, MCPX(CX,2,54), '');
      SetCellString(doc, MCPX(CX,2,56), '');
      SetCellString(doc, MCPX(CX,2,58), '');
      SetCellString(doc, MCPX(CX,2,60), '');
      SetCellString(doc, MCPX(CX,2,50), '');
      SetCellString(doc, MCPX(CX,2,95), '');
    end;
  result := 0;
end;

function F4275FinishBsmt(doc: TContainer; CX: CellUID): Integer;
var
  aInt: Integer;
  aFin: String;
begin
  aInt := Round(getCellValue(doc, MCX(CX, 195)));
  if aInt > 0 then
    begin
      aFin := Format('%d %%',[aInt]);
      SetCellString(doc, MCPX(cx, 2, 90), aFin);
    end;
end;

function F4275CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S, S1, S2, S3, S4, S5: string;
  cmd: Integer;
  ga,gd,gb,cp,dw,gar:Integer;
  gaDesc, gdDesc, gbDesc, cpDesc, dwDesc: String;
begin
  S1 := ''; S2 := ''; S3 := ''; S4 := ''; S5 := '';
  gar := 0;
  ga := Round(getCellValue(doc, MCPX(cx,2,51)));
  gd := Round(getCellValue(doc, MCPX(cx,2,53)));
  gb := Round(getCellValue(doc, MCPX(cx,2,55)));
  //calculate the total of garages
  gar := ga + gd + gb;
  SetCellValue(doc, MCPX(cx, 2, 50), gar);

  cp := Round(getCellValue(doc, MCPX(cx,2,57)));
  dw := Round(getCellValue(doc, MCPX(cx,2,59)));

  gaDesc := trim(getCellString(doc, MCPX(cx,2,52)));
  gdDesc := trim(getCellString(doc, MCPX(cx,2,54)));
  gbDesc := trim(getCellString(doc, MCPX(cx,2,56)));
  cpDesc := trim(getCellString(doc, MCPX(cx,2,58)));
  dwDesc := trim(getCellString(doc, MCPX(cx,2,60)));

  //Garage attached
  if ga > 0 then
    begin
      if gaDesc <> '' then
        if pos('ga', lowerCase(gaDesc)) > 0 then
          S1 := Format('%d%s',[ga, gaDesc])
        else
          S1 := Format('%d %s ',[ga, gaDesc])
      else
        S1 := Format('%dga',[ga]);
    end;

  //Garage detached
  if gd > 0 then
    begin
      if gdDesc <> '' then
        if pos('gd', lowerCase(gdDesc)) > 0 then
          S2 := Format('%d%s',[gd, gdDesc])
        else
          S2 := Format('%d%s ',[gd, gdDesc])
      else
        S2 := Format('%dgd',[gd]);
    end;

  //Garage Built in
  if gd > 0 then
    begin
      if gbDesc <> '' then
        if pos('gb', lowerCase(gbDesc)) > 0 then
          S3 := Format('%d%s',[gb, gbDesc])
        else
          S3 := Format('%d%s ',[gb, gbDesc])
      else
        S3 := Format('%dgb',[gb]);
    end;

  //Carport
  if cp > 0 then
    begin
      if cpDesc <> '' then
        if pos('cp', lowerCase(cpDesc)) > 0 then
          S4 := Format('%d%s',[cp, cpDesc])
        else
          S4 := Format('%d%s ',[cp, cpDesc])
      else
        S4 := Format('%dcp',[cp]);
    end;

  //Drive way
  if dw > 0 then
    begin
      if dwDesc <> '' then
        if pos('dw', lowerCase(dwDesc)) > 0 then
          S5 := Format('%d%s',[dw, dwDesc])
        else
          S5 := Format('%d%s ',[dw, dwDesc])
      else
        S5 := Format('%ddw',[dw]);
    end;

  S1 := trim(S1);
  if S1 <> '' then
    S := S1;
  S2 := trim(S2);
  if S2 <> '' then
    if S <> '' then
      S := trim(S) + S2
    else
      S:= S2;
  S3 := trim(S3);
  if S3 <> '' then
    if S <> '' then
      S := trim(S) + S3
    else
      S := S3;
  S4 := trim(S4);
  if S4 <> '' then
    if S <> '' then
      S := trim(S) + S4
    else
      S := S4;
  S5 := trim(S5);
  if S5 <> '' then
    if S <> '' then
      S := trim(S) + S5
    else
      S := S5;

  if S <> '' then
    SetCellString(doc, MCPX(cx, 2, 95), S);
  result := 0;
end;

function F4275CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,55));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,52));    //new cost
  V3 := GetCellValue(doc, mcx(cx,54));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,56), VR);
    end;
end;

//calc external depr
function F4275CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,57));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,52));    //new cost
  V3 := GetCellValue(doc, mcx(cx,54));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,56));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,58), VR);
    end;
end;

//Function depr percent
function F4275CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,56));    //funct depr
  V2 := GetCellValue(doc, mcx(cx,52));    //new cost
  V3 := GetCellValue(doc, mcx(cx,54));    //Phy Depr
  if (V2-V3) > 0 then
    begin
      VR := V1/(V2-V3)*100;
      result := SetCellValue(doc, mcx(cx,55), VR);
    end;
end;

//external depr percent
function F4275CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,58));    //extrn depr
  V2 := GetCellValue(doc, mcx(cx,52));    //new cost
  V3 := GetCellValue(doc, mcx(cx,54));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,56));    //Funct Depr
  if V3 < 0 then V3 := 0;
  if V4 < 0 then V4 := 0;
  if (V2-V3-V4)>0 then
    begin
      VR := (V1/(V2-V3-V4))*100;
      result := SetCellValue(doc, mcx(cx,57), VR);
    end;
end;

function ProcessForm4275Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,41), mcx(cx,42), MCPX(CX, 2,77));
        2:  begin
              Cmd := SiteDimension(doc, CX, MCX(cx,94));
              SetCellString(doc, mcpx(cx, 2, 80), GetCellString(doc, mcpx(cx, 1, 94)));
            end;
        4:  Cmd := F4275AgeLifeDepr(doc, CX);
        //page 2
        5:  Cmd := F4275Bsmt2Cost(doc, CX);            //for cost approach
        6:  Cmd := F4275Bsmt2Grid(doc, CX);  //for grid
        16: Cmd := ProcessMultipleCmds(ProcessForm4275Math, doc, CX,[5,6]);
        17: Cmd := LandUseSum(doc, CX, 1, [82,83,84,85,87]);
        20: cmd := DivideAB(doc, mcx(cx,71), mcx(cx,89), mcx(cx,72));      //Subj price/sqft
        21: cmd := DivideAB(doc, mcx(cx,110), mcx(cx,141), mcx(cx,111));   //C1 price/sqft
        22: cmd := DivideAB(doc, mcx(cx,174), mcx(cx,205), mcx(cx,175));   //C2 price/sqft
        23: cmd := DivideAB(doc, mcx(cx,238), mcx(cx,269), mcx(cx,239));   //C3 price/sqft
        24: Cmd := F4275C1Adjustments(doc, cx);
        25: Cmd := F4275C2Adjustments(doc, cx);
        26: Cmd := F4275C3Adjustments(doc, cx);
        27: cmd := ProcessMultipleCmds(ProcessForm4275Math, doc, CX,[21,24]); //C1 sales price
        28: cmd := ProcessMultipleCmds(ProcessForm4275Math, doc, CX,[22,25]); //C2 sales price
        29: cmd := ProcessMultipleCmds(ProcessForm4275Math, doc, CX,[23,26]); //C3 sales price
        30: cmd := CalcWeightedAvg(doc, [4275,4276]);   //calc wtAvg of main and xcomps forms
        66:
          begin //no recursion
            F4275C1Adjustments(doc, cx);
            F4275C2Adjustments(doc, cx);
            F4275C3Adjustments(doc, cx);
            cmd := 0;
          end;
        //Handle page 3 Cost approach
        31: cmd := MultAB(doc, mcpx(cx,3,27), mcpx(cx,3,28), mcpx(cx,3,29));   //dwelling
        32:
        begin
          cmd := MultAB(doc, mcpx(cx,3,31), mcpx(cx,3,32), mcpx(cx,3,33));   //bsmt
        end;
        33: cmd := MultAB(doc, mcpx(cx,3,35), mcpx(cx,3,36), mcpx(cx,3,37));   //3sqft *$
        43: cmd := MultAB(doc, mcpx(cx,3,39), mcpx(cx,3,40), mcpx(cx,3,41));   //4sqft *$
        44: cmd := MultAB(doc, mcpx(cx,3,43), mcpx(cx,3,44), mcpx(cx,3,45));   //5sqft *$
        46: cmd := MultAB(doc, mcpx(cx,3,48), mcpx(cx,3,49), mcpx(cx,3,50));   //garageft *$
        34: begin
              cmd := F4275SumCost(doc, cx, 29,33,37,41,45,47,50,52);             //sum costs
              Cmd :=ProcessForm4275Math(doc, 36, CX);
            end;
        35:
          if appPref_AppraiserCostApproachIncludeOpinionValue then
            //cmd := SumABC(doc, mcx(cx,26), mcx(cx,60), mcx(cx,61), mcx(cx, 65)) //sum site & improvements
            cmd := F4275SumCost(doc,cx, 26, 60, 61, 63, 64,0,0,65)
          else
            cmd := F4275SumCost(doc, cx, 0, 60,61,63,64,0,0,65);
        36: Cmd := MultPercentAB(doc, mcx(cx,52), mcx(cx,53),mcx(cx,54));         //phy dep precent entered
        37: cmd := F4275CalcDeprLessPhy(doc, cx);           //funct depr entered
        38: cmd := F4275CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        39:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,54), mcx(cx,52), mcx(cx,53));    //recalc phy percent
            F4275CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F4275CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm4275Math(doc, 63, CX); //sum the deprs
          end;
        40:
          begin //functional depr entered directly
            F4275CalcPctLessPhy(doc, cx);            //recalc the new precent
            F4275CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm4275Math(doc, 63, CX);  //sum the deprs
          end;
        41:
          begin
            F4275CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm4275Math(doc, 63, CX);  //sum the deprs
          end;
        42: cmd := SubtAB(doc, MCX(cx,52), mcx(cx,59), mcx(cx,60));     //subt depr from cost
        63: cmd := SumABC(doc, mcx(cx,54), mcx(cx,56), mcx(cx,58), mcx(cx,59));   //sum depr
        64: cmd := InfoSiteTotalRatio(doc, cx,28,66, 1);
        51: cmd := TransA2B(doc, mcpx(cx,3,6), mcpx(cx,4,13));  //trans sales
        53:
          begin
           ProcessForm4275Math(doc, 64, CX);
           cmd := TransA2B(doc, mcpx(cx,3,66), MCPX(cx,4,14));  //trans cost
          end;
        54: Cmd := F4275CarStorage(doc, CX);
        55: Cmd := F4275NoCarGarage(doc, CX);     //clears out cells when no garage
        56: Cmd := F4275Bsmt2Grid(doc, CX);
        //Page 4
        45: cmd := MultAB(doc, mcpx(cx,4,6), mcpx(cx,4,7), mcpx(cx,4,8));   //Market rent $ * multiplier
        52: cmd := TransA2B(doc, mcpx(cx,4,8), mcpx(cx,4,15));  //trans income
        59: cmd := SubtAB(doc, MCX(cx,52), mcx(cx,59), mcx(cx,60));     //subt depr from cost

      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm4275Math(doc, 66, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm4275Math(doc, 66, CX);
        end;
    end;
  result := 0;
end;

function F4276C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 56,115,116,113,114,1,2,
    [61,63,65,67,69,71,73,75,77,79,81,82,86,88,90,92,94,96,98,100,102,104,106,108,110,112], true);
end;

function F4276C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 121,180,181,178,179,3,4,
    [126,128,130,132,134,136,138,140,142,144,146,147,151,153,155,157,159,161,163,165,167,169,171,173,175,177], true);
end;

function F4276C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 186,245,246,243,244,5,6,
    [191,193,195,197,199,201,203,205,207,209,211,212,216,218,220,222,224,226,228,230,232,234,236,238,240,242], true);
end;

function ProcessForm4276Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 52,117,182);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 52,117,182, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 52,117,182);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm4276Math(doc, 21, CX);        //calc new price/sqft
            Cmd := F4276C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F4276C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,56), mcx(cx,87), mcx(cx,57));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm4276Math(doc, 22, CX);     //calc new price/sqft
            Cmd := F4276C2Adjustments(doc, cx);   //redo the adjustments
          end;
        25:
          cmd := F4276C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,121), mcx(cx,152), mcx(cx,122));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm4276Math(doc, 23, CX);     //calc new price/sqft
            Cmd := F4276C3Adjustments(doc, cx);   //redo the adjustments
          end;
        26:
          cmd := F4276C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,186), mcx(cx,217), mcx(cx,187));     //price/sqft

        14:
          {cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main and xcomps forms
          cmd := CalcWeightedAvg(doc, [340,363,355]);   //calc wtAvg of main and xcomps forms       }
          //1004(ID340) and 2055(id355) has the same XComps(ID363)
          // NonLender Resedential XComps(ID761, mainFormID 736), NonLender  Extrior only XComps(ID764, main form ID 764)
          //use math for 1004 XComp (ID 363)
          cmd := CalcWeightedAvg(doc, [4275,4276]);
        32:
          begin
            F4276C1Adjustments(doc, cx);
            F4276C2Adjustments(doc, cx);     //sum of adjs
            F4276C3Adjustments(doc, cx);
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
          CX.pg := 0;    //math is on page 1
          ProcessForm4276Math(doc, 6, CX);
          ProcessForm4276Math(doc, 25, CX);
          ProcessForm4276Math(doc, 26, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4276Math(doc, 32, CX);
        end;
    end;

  result := 0;
end;



//Ticket #1427: Solidifi XComps
function F4277C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 40,73,74,71,72,1,2,
    [43,45,47,49,51,52,56,58,60,62,64,66,68,70], True);
end;

function F4277C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 80,113,114,111,112,3,4,
    [83,85,87,89,91,92,96,98,100,102,104,106,108,110], True);
end;

function F4277C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 120,153,154,151,152,5,6,
    [123,125,127,129,131,132,136,138,140,142,144,146,148,150], True);
end;

function ProcessForm4277Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps',35,75,115);
        2: cmd := SetXXXPageTitle(doc, cx,'EXTRA COMPARABLES','',35,75,115, 2);
        3: cmd := ConfigXXXInstance(doc,cx,35,75,115);

        //Subject
        20:cmd := DivideAB(doc, mcx(cx,17), mcx(cx,26), mcx(cx,18));     //Subj price/sqft

        //Comp1 calcs
        9:  cmd := F4277C1Adjustments(doc, cx);       //sum of adjs
        12:   //sales price changed
          begin
            ProcessForm4277Math(doc, 21, CX);        //calc new price/sqft
            Cmd := F4277C1Adjustments(doc, cx);     //redo the adjustments
          end;
        21: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,57), mcx(cx,41));     //price/sqft

        //Comp2 calcs
        10:  cmd := F4277C2Adjustments(doc, cx);     //sum of adjs
        13:   //sales price changed
          begin
            ProcessForm4277Math(doc, 22, CX);     //calc new price/sqft
            Cmd := F4277C2Adjustments(doc, cx);   //redo the adjustments
          end;
        22: cmd := DivideAB(doc, mcx(cx,80), mcx(cx,97), mcx(cx,81));     //price/sqft

        //Comp3 calcs
        11: cmd := F4277C3Adjustments(doc, cx);     //sum of adjs
        14:   //sales price changed
          begin
            ProcessForm4277Math(doc, 23, CX);     //calc new price/sqft
            Cmd := F4277C3Adjustments(doc, cx);   //redo the adjustments
          end;
        23: cmd := DivideAB(doc, mcx(cx,120), mcx(cx,137), mcx(cx,121));     //price/sqft

        //calc wtAvg of main and xcomps forms
        15: cmd := CalcWeightedAvg(doc, [4277,4261]);

        //recalculate adjustments
        35:
          begin
            F4277C1Adjustments(doc, cx);
            F4277C2Adjustments(doc, cx);     //sum of adjs
            F4277C3Adjustments(doc, cx);
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
          ProcessForm4277Math(doc, 9, CX);
          ProcessForm4277Math(doc, 10, CX);
          ProcessForm4277Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4277Math(doc, 35, CX);
        end;
    end;

  result := 0;
end;

function F4309C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 87,133,134,131,132,2,3,
      [91,93,95,97,99,101,103,105,107,108,112,114,116,118,120,122,124,126,128,130],True);
end;

function F4309C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 138,184,185,182,183,4,5,
      [142,144,146,148,150,152,154,156,158,159,163,165,167,169,171,173,175,177,179,181],True);
end;

function F4309C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 189,235,236,233,234,6,7,
      [193,195,197,199,201,203,205,207,209,210,214,216,218,220,222,224,226,228,230,232],True);
end;

function ProcessForm4309Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAB(doc, mcx(cx,57), mcx(cx,72), mcx(cx,58));      //Subj price/sqft
        2: cmd := DivideAB(doc, mcx(cx,87), mcx(cx,113), mcx(cx,88));     //C1 price/sqft
        3: cmd := DivideAB(doc, mcx(cx,138), mcx(cx,164), mcx(cx,139));   //C2 price/sqft
        4: cmd := DivideAB(doc, mcx(cx,189), mcx(cx,215), mcx(cx,190));   //C3 price/sqft
        5: Cmd := F4309C1Adjustments(doc, cx);  //C1 adjustments
        6: Cmd := F4309C2Adjustments(doc, cx);  //C2 adjustments
        7: Cmd := F4309C3Adjustments(doc, cx);  //C3 adjustments
        8: cmd := ProcessMultipleCmds(ProcessForm4309Math, doc, CX,[2,5]); //C1 sales price
        9: cmd := ProcessMultipleCmds(ProcessForm4309Math, doc, CX,[3,6]); //C2 sales price
       10: cmd := ProcessMultipleCmds(ProcessForm4309Math, doc, CX,[4,7]); //C3 sales price
       11: cmd := CalcWeightedAvg(doc, [4309,4310]);  //calc wtAvg of main and xcomps forms
       35: //use math id 35(not on the form) that's given from UpdateNetGrossID and WeightedAvergeID to recalculate adjustments.
          begin //no recursion
            F4309C1Adjustments(doc, cx);
            F4309C2Adjustments(doc, cx);
            F4309C3Adjustments(doc, cx);
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
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm4309Math(doc, 35, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm4309Math(doc, 35, CX);
        end;
    end;
  result := 0;
end;


function F4310C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 38,84,85,82,83,2,3,
      [42,44,46,48,50,52,54,56,58,59,63,65,67,69,71,73,75,77,79,81],True);
end;

function F4310C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 90,136,137,134,135,4,5,
      [94,96,98,100,102,104,106,108,110,111,115,117,119,121,123,125,127,129,131,133],True);
end;

function F4310C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 142,188,189,186,187,6,7,
      [146,148,150,152,154,156,158,160,162,163,167,169,171,173,175,177,179,181,183,185],True);
end;


function ProcessForm4310Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        33: begin
              cmd := ConfigXXXInstance(doc,cx,34,86,138);   //this mathid is set through UFormConfig
              //cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 34,86,138, 213);
            end;
         1: cmd := SetXXXPageTitleBarName(doc, cx, 'Solidifi FLEX', 34,86,138);


        2: cmd := DivideAB(doc, mcx(cx,7), mcx(cx,22), mcx(cx,8));        //Subj price/sqft
        3: cmd := DivideAB(doc, mcx(cx,38), mcx(cx,64), mcx(cx,39));      //C1 price/sqft
        4: cmd := DivideAB(doc, mcx(cx,90), mcx(cx,116), mcx(cx,91));     //C2 price/sqft
        5: cmd := DivideAB(doc, mcx(cx,142), mcx(cx,168), mcx(cx,143));   //C3 price/sqft
        6: Cmd := F4310C1Adjustments(doc, cx);  //C1 adjustments
        7: Cmd := F4310C2Adjustments(doc, cx);  //C2 adjustments
        8: Cmd := F4310C3Adjustments(doc, cx);  //C3 adjustments
        9: cmd := ProcessMultipleCmds(ProcessForm4310Math, doc, CX,[3,6]); //C1 sales price
       10: cmd := ProcessMultipleCmds(ProcessForm4310Math, doc, CX,[4,7]); //C2 sales price
       11: cmd := ProcessMultipleCmds(ProcessForm4310Math, doc, CX,[5,8]); //C3 sales price
        //calc wtAvg of main and xcomps forms
       12: cmd := CalcWeightedAvg(doc, [4310,4309]);


       //recalculate adjustments
       35:
         begin
           F4310C1Adjustments(doc, cx);
           F4310C2Adjustments(doc, cx);     //sum of adjs
           F4310C3Adjustments(doc, cx);
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
          CX.pg := 0;    //math is on page 1
          ProcessForm4310Math(doc, 35, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4310Math(doc, 35, CX);
        end;
    end;
  result := 0;
end;

function F4289NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, MCPX(CX,3,49)) then
    begin
      SetCellString(doc, MCPX(CX,3,51), '');
      SetCellString(doc, MCPX(CX,3,53), '');
      SetCellString(doc, MCPX(CX,3,55), '');
      SetCellString(doc, MCPX(CX,3,57), '');
      SetCellString(doc, MCPX(CX,3,59), '');
      SetCellString(doc, MCPX(CX,3,61), '');

      SetCellString(doc, MCPX(CX,3,52), '');
      SetCellString(doc, MCPX(CX,3,54), '');
      SetCellString(doc, MCPX(CX,3,56), '');
      SetCellString(doc, MCPX(CX,3,58), '');
      SetCellString(doc, MCPX(CX,3,60), '');
      SetCellString(doc, MCPX(CX,3,50), '');
    end;
  result := 0;
end;



function F4289CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S, S1, S2, S3, S4, S5: string;
  cmd: Integer;
  ga,gd,gb,cp,dw,gar:Integer;
  gaDesc, gdDesc, gbDesc, cpDesc, dwDesc: String;
begin
  S1 := ''; S2 := ''; S3 := ''; S4 := ''; S5 := '';
  gar := 0;
  ga := Round(getCellValue(doc, MCPX(cx,3,51)));
  gd := Round(getCellValue(doc, MCPX(cx,3,53)));
  gb := Round(getCellValue(doc, MCPX(cx,3,55)));
  //calculate the total of garages
  gar := ga + gd + gb;
  SetCellValue(doc, MCPX(cx, 3, 50), gar);

  cp := Round(getCellValue(doc, MCPX(cx,3,57)));
  dw := Round(getCellValue(doc, MCPX(cx,3,59)));

  gaDesc := trim(getCellString(doc, MCPX(cx,3,52)));
  gdDesc := trim(getCellString(doc, MCPX(cx,3,54)));
  gbDesc := trim(getCellString(doc, MCPX(cx,3,56)));
  cpDesc := trim(getCellString(doc, MCPX(cx,3,58)));
  dwDesc := trim(getCellString(doc, MCPX(cx,3,60)));

  //Garage attached
  if ga > 0 then
    begin
      if gaDesc <> '' then
        if pos('ga', lowerCase(gaDesc)) > 0 then
          S1 := Format('%d%s',[ga, gaDesc])
        else
          S1 := Format('%d %s ',[ga, gaDesc])
      else
        S1 := Format('%dga',[ga]);
    end;

  //Garage detached
  if gd > 0 then
    begin
      if gdDesc <> '' then
        if pos('gd', lowerCase(gdDesc)) > 0 then
          S2 := Format('%d%s',[gd, gdDesc])
        else
          S2 := Format('%d%s ',[gd, gdDesc])
      else
        S2 := Format('%dgd',[gd]);
    end;

  //Garage Built in
  if gd > 0 then
    begin
      if gbDesc <> '' then
        if pos('gb', lowerCase(gbDesc)) > 0 then
          S3 := Format('%d%s',[gb, gbDesc])
        else
          S3 := Format('%d%s ',[gb, gbDesc])
      else
        S3 := Format('%dgb',[gb]);
    end;

  //Carport
  if cp > 0 then
    begin
      if cpDesc <> '' then
        if pos('cp', lowerCase(cpDesc)) > 0 then
          S4 := Format('%d%s',[cp, cpDesc])
        else
          S4 := Format('%d%s ',[cp, cpDesc])
      else
        S4 := Format('%dcp',[cp]);
    end;

  //Drive way
  if dw > 0 then
    begin
      if dwDesc <> '' then
        if pos('dw', lowerCase(dwDesc)) > 0 then
          S5 := Format('%d%s',[dw, dwDesc])
        else
          S5 := Format('%d%s ',[dw, dwDesc])
      else
        S5 := Format('%ddw',[dw]);
    end;

  S1 := trim(S1);
  if S1 <> '' then
    S := S1;
  S2 := trim(S2);
  if S2 <> '' then
    if S <> '' then
      S := trim(S) + S2
    else
      S:= S2;
  S3 := trim(S3);
  if S3 <> '' then
    if S <> '' then
      S := trim(S) + S3
    else
      S := S3;
  S4 := trim(S4);
  if S4 <> '' then
    if S <> '' then
      S := trim(S) + S4
    else
      S := S4;
  S5 := trim(S5);
  if S5 <> '' then
    if S <> '' then
      S := trim(S) + S5
    else
      S := S5;

//  if S <> '' then
//    SetCellString(doc, MCPX(cx, 3, 95), S);
  result := 0;
end;


function F4289C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 54,119,120,117,118,1,2,
      [59,61,63,65,67,69,71,73,75,77,79,81,83,85,86,90,92,94,96,98,100,102,104,106,108,110,112,114,116],True);
end;

function F4289C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 126,191,192,189,190,3,4,
      [131,133,135,137,139,141,143,145,147,149,151,153,155,157,158,162,164,166,168,170,172,174,176,178,180,182,184,186,188],True);
end;

function F4289C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 198,263,264,261,262,5,6,
      [203,205,207,209,211,213,215,217,219,221,223,225,227,229,230,234,236,238,240,242,244,246,248,250,252,254,256,258,260],True);
end;


function ProcessForm4289Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        5: cmd := DivideAB(doc, mcx(cx,10), mcx(cx,31), mcx(cx,11));      //Subj price/sqft
        6: cmd := DivideAB(doc, mcx(cx,54), mcx(cx,91), mcx(cx,55));   //C1 price/sqft
        7: cmd := DivideAB(doc, mcx(cx,126), mcx(cx,163), mcx(cx,127));   //C2 price/sqft
        8: cmd := DivideAB(doc, mcx(cx,198), mcx(cx,235), mcx(cx,199));   //C3 price/sqft
        9: Cmd := F4289C1Adjustments(doc, cx);
        10: Cmd := F4289C2Adjustments(doc, cx);
        11: Cmd := F4289C3Adjustments(doc, cx);
        13: cmd := ProcessMultipleCmds(ProcessForm4289Math, doc, CX,[6,9]); //C1 sales price
        14: cmd := ProcessMultipleCmds(ProcessForm4289Math, doc, CX,[7,10]); //C2 sales price
        15: cmd := ProcessMultipleCmds(ProcessForm4289Math, doc, CX,[8,11]); //C3 sales price
        16: cmd := CalcWeightedAvg(doc, [4289,4291]);   //calc wtAvg of main and xcomps forms
        17: cmd := MultAB(doc, mcx(cx,167), mcx(cx,168), mcx(cx,169));
        24: Cmd := LandUseSum(doc, CX, 1, [84,85,86,87,88]);
        84: Cmd := MultAB(doc, mcx(cx,74), mcx(cx,75), mcx(cx,76));
        66:
          begin //no recursion
            F4289C1Adjustments(doc, cx);
            F4289C2Adjustments(doc, cx);
            F4289C3Adjustments(doc, cx);
            cmd := 0;
          end;
        54: Cmd := F4289CarStorage(doc, CX);
        55: Cmd := F4289NoCarGarage(doc, CX);     //clears out cells when no garage
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 3;    //math is on page 4 (zero based)
          ProcessForm4289Math(doc, 66, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 3;    //math is on page 4 (zero based)
          ProcessForm4289Math(doc, 66, CX);
        end;
    end;
  result := 0;
end;

function F4293C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 64,129,130,127,128,1,2,
    [69,71,73,75,77,79,81,83,85,87,89,91,93,95,96,100,102,104,106,108,110,112,114,116,118,120,122,124,125], true);
end;

function F4293C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 137,202,203,200,201,3,4,
    [142,144,146,148,150,152,154,156,158,160,162,164,166,168,169,173,175,177,179,
     181,183,185,187,189,191,193,195,197,199], true);
end;

function F4293C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 210,275,276,273,274,5,6,
    [215,217,219,221,223,225,227,229,231,233,235,237,239,241,242,246,248,250,252,
     254,256,258,260,262,264,266,268,270,272], true);
end;


function ProcessForm4293Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 58,131,204);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 58,131,204, 2);
        3: cmd := ConfigXXXInstance(doc, cx, 58,131,204);
        //Subject
        4: cmd := DivideAB(doc, mcx(cx,19), mcx(cx,40), mcx(cx,20));     //Subj price/sqft
        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm4293Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F4293C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6: cmd := F4293C1Adjustments(doc, cx);       //sum of adjs
        7: cmd := DivideAB(doc, mcx(cx,64), mcx(cx,101), mcx(cx,65));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm4293Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F4293C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:  cmd := F4293C2Adjustments(doc, cx);     //sum of adjs
        10: cmd := DivideAB(doc, mcx(cx,137), mcx(cx,174), mcx(cx,138));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm4293Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F4293C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12: cmd := F4293C3Adjustments(doc, cx);     //sum of adjs
        13: cmd := DivideAB(doc, mcx(cx,210), mcx(cx,247), mcx(cx,211));     //price/sqft
        14: cmd := CalcWeightedAvg(doc, [4289,4293]);
        32:
          begin
            F4293C1Adjustments(doc, cx);
            F4293C2Adjustments(doc, cx);     //sum of adjs
            F4293C3Adjustments(doc, cx);
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
          CX.pg := 0;    //math is on page 1
          ProcessForm4293Math(doc, 6, CX);
          ProcessForm4293Math(doc, 9, CX);
          ProcessForm4293Math(doc, 12, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4293Math(doc, 32, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm4284Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'COMPARABLES', 'PHOTO ADDENDUM',14,18,22, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Comparables', 14,18,22);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 14, 18, 22);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm4282Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'Listings', 'PHOTO ADDENDUM',14,18,22, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Photo Listings', 14,18,22);
        3:
          cmd := ConfigPhotoXXXInstance(doc, cx, 14, 18, 22);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm4206Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := SetPageTitleBarName(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function F4354C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 41,75,76,73,74,1,2,
    [45,47,49,51,55,57,59,61,63,65,67,69,71], True);
end;

function F4354C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 82,116,117,114,115,3,4,
    [86,88,90,92,96,98,100,102,104,106,108,110,112], True);
end;

function F4354C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 123,157,158,155,156,5,6,
    [127,129,131,133,137,139,141,143,145,147,149,151,153], True);
end;


//math for Commercial Summary XComp
function ProcessForm4354Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps',36,77,118);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','',36,77,118, 2);
        3: cmd := ConfigXXXInstance(doc, cx,36,77,118);

        //Comp1 calcs
        5,6: cmd := F4354C1Adjustments(doc, cx);       //sum of adjs
        7,8: cmd := F4354C2Adjustments(doc, cx);   //redo the adjustments
        9,11:cmd := F4354C3Adjustments(doc, cx);     //sum of adjs
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm4361Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 29,47,65);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 29,47,65, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 29,47,65);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,17), mcx(cx,25), mcx(cx,18));     //Subj price/sqft

        //Comp1 calcs
        5,7:
          cmd := DivideAB(doc, mcx(cx,34), mcx(cx,43), mcx(cx,35));     //price/sqft

        //Comp2 calcs
        8,10:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,61), mcx(cx,53));     //price/sqft

        //Comp3 calcs
        11,13:
          cmd := DivideAB(doc, mcx(cx,70), mcx(cx,79), mcx(cx,71));     //price/sqft

        14:
          cmd := CalcWeightedAvg(doc, [4360,4361]);
        15:
          begin
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
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
        end;
    end;
  result := 0;
end;


function ProcessForm4360Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Subject
        20:
          cmd := DivideAB(doc, mcx(cx,74), mcx(cx,82), mcx(cx,75));     //Subj price/sqft

        //Comp1 calcs
        21,27:
          cmd := DivideAB(doc, mcx(cx,90), mcx(cx,99), mcx(cx,91));     //price/sqft

        //Comp2 calcs
        22,28:
          cmd := DivideAB(doc, mcx(cx,107), mcx(cx,116), mcx(cx,108));     //price/sqft

        //Comp3 calcs
        23,29:
          cmd := DivideAB(doc, mcx(cx,124), mcx(cx,133), mcx(cx,125));     //price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    cmd := 0;
  result := 0;
end;




end.

