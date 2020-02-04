unit UMathFNMA;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }

interface

uses
  UGlobals, UContainer;

const
  fm704FormWQ = 13;           //second mortage
  fm704Form = 14;             //identical copy of second mortage w/o qualifier
  fm704XCmps = 15;            //second mortgage extra comps
  fm2005_1025Listings = 869;
  fm2005_1073A = 892;
  fm1095Form = 36;
  fm2055FMac = 93;            //Freddie Mac form
  fm2055FMae = 37;            //Fannie Mae form
  fm2055XCmps = 38;
  fm2065Form = 39;
  fm2065XCmps = 40;
  fm2075Form = 41;
  fm2095Form = 42;
  fm2070Form = 43;
  LoanVal = 49;
  PropEval = 50;
  fmFNMA_BPO = 166;
  fmFMAC_BPOXCmps = 171;
  fmFMAC_BPOXLists = 172;
  fmFMAC_BPOXSales = 173;
  fm2055_1073Listings = 888;


  function ProcessForm0013Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0015Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0036Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0037Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0038Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0039Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0040Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0041Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0042Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0043Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0166Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0171Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0172Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0173Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0869Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0892Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0888Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;



// Second Mortgage Calcs
function F0013C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
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

function F0013C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
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

function F0013C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
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

// Second Mortgage Extra Comps
function F0015C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 37;
  TotalAdj  = 71;
  FinalAmt  = 72;
  PlusChk   = 69;
  NegChk    = 70;
  InfoNet   = 4;
  InfoGross = 5;
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
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);

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

function F0015C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 77;
  TotalAdj  = 111;
  FinalAmt  = 112;
  PlusChk   = 109;
  NegChk    = 110;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,88), NetAdj, GrsAdj);
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

function F0015C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 117;
  TotalAdj  = 151;
  FinalAmt  = 152;
  PlusChk   = 149;
  NegChk    = 150;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);

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

(*
//FNMA 2055


	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(1, 182));
		Val[2] := GetCellValue(CurWPtr, MC(1, 228));
		Val[3] := GetCellValue(CurWPtr, MC(1, 274));

		Val[4] := GetCellValue(CurWPtr, MC(4, 77));
		Val[5] := GetCellValue(CurWPtr, MC(4, 123));
		Val[6] := GetCellValue(CurWPtr, MC(4, 169));

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

	function CertPageAddress: Integer;							{Concat address for cert page}
		var
			Str: Str255;
	begin
		Str := '';

		Str := GetCellString(CurWPtr, mc(1, 5));					{get City}

		TempStr := GetCellString(CurWPtr, mc(1, 6));				{get St}
		Str := Concat(Str, ', ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 7));				{get Zip}
		Str := Concat(Str, ' ', TempStr);

		CertPageAddress := Result2Cell(Str, mc(3, 11));
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
		if length(MacAppUser.User[N].CertNo) > 0 then
			Str2Cell(mc(3, 6), MacAppUser.User[N].CertNo)
		else
			Str2Cell(mc(3, 7), MacAppUser.User[N].LicNo);
		Str2Cell(mc(3, 8), MacAppUser.State);
		Str2Cell(mc(3, 9), MacAppUser.User[N].ExpDate);

		FillInAppraiserInfo := 0;
	end;

	function FillReviewerInfo: Integer;
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
		N := GetUserNameIndex(GetCellString(CurWPtr, mc(3, 17)));
		if n > 0 then
			begin
				if length(MacAppUser.User[N].CertNo) > 0 then
					Str2Cell(mc(3, 21), MacAppUser.User[N].CertNo)			{this is on cert page}
				else
					Str2Cell(mc(3, 22), MacAppUser.User[N].LicNo);
				Str2Cell(mc(3, 23), MacAppUser.State);
				Str2Cell(mc(3, 24), MacAppUser.User[N].ExpDate);
			end;
		FillReviewerInfo := 0;
	end;

	function Location: Integer;
	begin
		if IsChecked(CurWPtr, mc(1, 30)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 31)) then
			Location := Result2Cell('Suburban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 32)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else
			Location := 0;
	end;

	function CheckBoxRating (cell1, cell2, cell3, cell4, cell5, cellR: CellID): Integer;
		var
			ratingStr: Str255;
	begin
		ratingStr := '';

		if IsChecked(CurWPtr, cell1) then
			ratingStr := 'Excellent';

		if IsChecked(CurWPtr, cell2) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Good');
			end;

		if IsChecked(CurWPtr, cell3) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Average');
			end;

		if IsChecked(CurWPtr, cell4) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Fair');
			end;

		if IsChecked(CurWPtr, cell5) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Poor');
			end;

		CheckBoxRating := Result2Cell(ratingStr, cellR);
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of


					14:
						cmd := DivideAB(mc(1, 118), mc(1, 129), mc(1, 119));		{sub sales/sqft}

					15: 
						Cmd := SetCheckMark(mc(1, 181), mc(1, 179), mc(1, 180));		{C1 checks}
					16:
						Cmd := SetCheckMark(mc(1, 227), mc(1, 225), mc(1, 226));		{C2 checks}
					17: 
						Cmd := SetCheckMark(mc(1, 273), mc(1, 271), mc(1, 272));		{C3 checks}
					18: 
						Cmd := SetCheckMark(mc(4, 76), mc(4, 74), mc(4, 75));		{C4 checks}
					19: 
						Cmd := SetCheckMark(mc(4, 122), mc(4, 120), mc(4, 121));		{C5 checks}
					20: 
						Cmd := SetCheckMark(mc(4, 168), mc(4, 166), mc(4, 167));		{C6 checks}

					52:
						Cmd := FillReviewerInfo;

					53:
						Cmd := Location;
					54:
						cmd := SiteDimension(mc(1, 61), mc(1, 62));

					55:  																	{chg Sub sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 39);							{Éset sqft adj for all}
							ProcessCurCellInfo(CurWPtr, 14);							{Éset price/sqft}
							Cmd := 0;
						end;
					56:  																	{chg c1 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 33);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 8);							{Éset price/sqft}
							Cmd := 0;
						end;
					57:  																	{chg c2 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 34);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 9);							{Éset price/sqft}
							Cmd := 0;
						end;
					58:  																	{chg c3 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 35);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 10);							{Éset price/sqft}
							Cmd := 0;
						end;
					59:  																	{chg c4 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 36);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 11);							{Éset price/sqft}
							Cmd := 0;
						end;
					60:  																	{chg c5 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 37);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 12);							{Éset price/sqft}
							Cmd := 0;
						end;
					61:  																	{chg c6 sqft}
						begin
							ProcessCurCellInfo(CurWPtr, 38);							{Éset sqft adj}
							ProcessCurCellInfo(CurWPtr, 13);							{Éset price/sqft}
							Cmd := 0;
						end;



					63: 
						Cmd := TransA2B(mc(1, 4), mc(1, 116));				{transfer address to grid }
					64: 
						Cmd := TransA2B(mc(1, 4), mc(3, 10));				{transfer address to cert page }
					65: 
						Cmd := TransA2B(mc(1, 5), mc(1, 117));				{transfer city to grid }
					66: 
						Cmd := CertPageAddress;								{concat city, state, zip}
					67: 
						Cmd := TransA2B(mc(1, 23), mc(1, 118));			{transfer sales price to grid }


					100: 				{AppraisalAmts}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 285), cxSubApprValue);
							Cmd := UpdatePublicTable(kAppraisalAmt, GetCellString(CurWPtr, mc(1, 285)));		{Public Value Amts}
						end;
					101: 				{kAppraisalDate}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 286), cxSubApprDate);
							Cmd := UpdatePublicTable(kAppraisalDate, GetCellString(CurWPtr, mc(1, 286)));		{make public}
						end;
					102: 				{kAppraiserName}
						begin
							Cmd := FillInAppraiserInfo;		{load all fields that pertain to appraiser}
							Cmd := UpdatePublicTable(kAppraiserName, GetCellString(CurWPtr, mc(3, 2)));
						end;
					103: 				{kAddress}
						begin
							ProcessCurCellInfo(CurWPtr, 63);
							ProcessCurCellInfo(CurWPtr, 64);
							Cmd := Broadcast2Context(CurWPtr, mc(1, 4), cxPropAddress);
							Cmd := UpdatePublicTable(kAddress, GetCellString(CurWPtr, mc(1, 4)));
						end;
					104: 				{kCityStZip - this happens automatically}
						begin
						end;
					105: 				{kFileNo}
						begin
							Cmd := UpdatePublicTable(kFileNo, GetCellString(CurWPtr, mc(1, 2)));
						end;
					106: 				{kLegalDesc }
						begin
							Cmd := UpdatePublicTable(kLegalDesc, GetCellString(CurWPtr, mc(1, 8)));
						end;
					107: 				{kOwner}
						begin
							Cmd := UpdatePublicTable(kOwner, GetCellString(CurWPtr, mc(1, 18)));
						end;
					108: 				{kBorrower}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 14), cxBorrower);				{load in to borrower}
							Cmd := UpdatePublicTable(kBorrower, GetCellString(CurWPtr, mc(1, 14)));
						end;
					109: 				{City}
						begin
							ProcessCurCellInfo(CurWPtr, 65);		{trans city to grid}
							ProcessCurCellInfo(CurWPtr, 66);		{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 5), cxCity);
							Cmd := UpdatePublicTable(kCity, GetCellString(CurWPtr, mc(1, 5)));
						end;
					110: 				{County}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 9), cxCounty);
							Cmd := UpdatePublicTable(kCounty, GetCellString(CurWPtr, mc(1, 9)));
						end;
					112: 				{State}
						begin
							ProcessCurCellInfo(CurWPtr, 66);		{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 6), cxState);
							Cmd := UpdatePublicTable(kState, GetCellString(CurWPtr, mc(1, 6)));
						end;
					113: 				{Zip Code}
						begin
							ProcessCurCellInfo(CurWPtr, 66);			{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 7), cxZipCode);
							Cmd := UpdatePublicTable(kZip, GetCellString(CurWPtr, mc(1, 7)));
						end;
					114: 				{Lender}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 16), cxLenderClient);}
							Cmd := UpdatePublicTable(kLenderCoName, GetCellString(CurWPtr, mc(3, 15)));
						end;
					115: 				{Lender Address}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 18), cxLenderAddress);}
							Cmd := UpdatePublicTable(kLenderAddress, GetCellString(CurWPtr, mc(3, 15)));
						end;
					116: 				{Comp1Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 139), 201);
							Cmd := UpdatePublicTable(kComp1Addr1, GetCellString(CurWPtr, mc(1, 139)));
						end;
					117:  				{Comp1Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 140), 202);
							Cmd := UpdatePublicTable(kComp1Addr2, GetCellString(CurWPtr, mc(1, 140)));
						end;
					118:  				{Comp2Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 185), 301);
							Cmd := UpdatePublicTable(kComp2Addr1, GetCellString(CurWPtr, mc(1, 185)));
						end;
					119:  				{Comp2Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 186), 302);
							Cmd := UpdatePublicTable(kComp2Addr2, GetCellString(CurWPtr, mc(1, 186)));
						end;
					120:  				{Comp3Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 231), 401);
							Cmd := UpdatePublicTable(kComp3Addr1, GetCellString(CurWPtr, mc(1, 231)));
						end;
					121:  				{Comp3Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 232), 402);
							Cmd := UpdatePublicTable(kComp3Addr2, GetCellString(CurWPtr, mc(1, 232)));
						end;
					122:  				{Comp4Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 34), 501);
							Cmd := UpdatePublicTable(kComp4Addr1, GetCellString(CurWPtr, mc(4, 34)));
						end;
					123:  				{Comp4Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 35), 502);
							Cmd := UpdatePublicTable(kComp4Addr2, GetCellString(CurWPtr, mc(4, 35)));
						end;
					124:  				{Comp5Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 80), 601);
							Cmd := UpdatePublicTable(kComp5Addr1, GetCellString(CurWPtr, mc(4, 80)));
						end;
					125:  				{Comp5Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 81), 602);
							Cmd := UpdatePublicTable(kComp5Addr2, GetCellString(CurWPtr, mc(4, 81)));
						end;
					126:  				{Comp6Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 126), 701);
							Cmd := UpdatePublicTable(kComp6Addr1, GetCellString(CurWPtr, mc(4, 126)));
						end;
					127:  				{Comp6Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 127), 702);
							Cmd := UpdatePublicTable(kComp6Addr2, GetCellString(CurWPtr, mc(4, 127)));
						end;

					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

*)
 //=============================================================
(*
//FNMA 2065
	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;


	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(1, 182));
		Val[2] := GetCellValue(CurWPtr, MC(1, 228));
		Val[3] := GetCellValue(CurWPtr, MC(1, 274));

		Val[4] := GetCellValue(CurWPtr, MC(4, 77));
		Val[5] := GetCellValue(CurWPtr, MC(4, 123));
		Val[6] := GetCellValue(CurWPtr, MC(4, 169));

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

	function CertPageAddress: Integer;							{Concat address for cert page}
		var
			Str: Str255;
	begin
		Str := '';

		Str := GetCellString(CurWPtr, mc(1, 5));					{get City}

		TempStr := GetCellString(CurWPtr, mc(1, 6));				{get St}
		Str := Concat(Str, ', ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 7));				{get Zip}
		Str := Concat(Str, ' ', TempStr);

		CertPageAddress := Result2Cell(Str, mc(3, 11));
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
		if length(MacAppUser.User[N].CertNo) > 0 then
			Str2Cell(mc(3, 6), MacAppUser.User[N].CertNo)
		else
			Str2Cell(mc(3, 7), MacAppUser.User[N].LicNo);
		Str2Cell(mc(3, 8), MacAppUser.State);
		Str2Cell(mc(3, 9), MacAppUser.User[N].ExpDate);

		FillInAppraiserInfo := 0;
	end;

	function FillReviewerInfo: Integer;
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
		N := GetUserNameIndex(GetCellString(CurWPtr, mc(3, 17)));
		if n > 0 then
			begin
				if length(MacAppUser.User[N].CertNo) > 0 then
					Str2Cell(mc(3, 21), MacAppUser.User[N].CertNo)			{this is on cert page}
				else
					Str2Cell(mc(3, 22), MacAppUser.User[N].LicNo);
				Str2Cell(mc(3, 23), MacAppUser.State);
				Str2Cell(mc(3, 24), MacAppUser.User[N].ExpDate);
			end;
		FillReviewerInfo := 0;
	end;

	function Location: Integer;
	begin
		if IsChecked(CurWPtr, mc(1, 30)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 31)) then
			Location := Result2Cell('Suburban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 32)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else
			Location := 0;
	end;

	function CheckBoxRating (cell1, cell2, cell3, cell4, cell5, cellR: CellID): Integer;
		var
			ratingStr: Str255;
	begin
		ratingStr := '';

		if IsChecked(CurWPtr, cell1) then
			ratingStr := 'Excellent';

		if IsChecked(CurWPtr, cell2) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Good');
			end;

		if IsChecked(CurWPtr, cell3) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Average');
			end;

		if IsChecked(CurWPtr, cell4) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Fair');
			end;

		if IsChecked(CurWPtr, cell5) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Poor');
			end;

		CheckBoxRating := Result2Cell(ratingStr, cellR);
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					8: 
						cmd := DivideAB(mc(1, 142), mc(1, 167), mc(1, 143));		{c1 sales/sqft}
					9: 
						cmd := DivideAB(mc(1, 187), mc(1, 212), mc(1, 188));		{c2 sales/sqft}
					10: 
						cmd := DivideAB(mc(1, 232), mc(1, 257), mc(1, 233));		{c3 sales/sqft}
					11: 
						cmd := DivideAB(mc(4, 37), mc(4, 62), mc(4, 38));				{c4 sales/sqft}
					12: 
						cmd := DivideAB(mc(4, 82), mc(4, 107), mc(4, 83));			{c5 sales/sqft}
					13: 
						cmd := DivideAB(mc(4, 127), mc(4, 152), mc(4, 128));		{c6 sales/sqft}
					14: 
						cmd := DivideAB(mc(1, 118), mc(1, 129), mc(1, 119));		{sub sales/sqft}

					52: 
						Cmd := FillReviewerInfo;

					53: 
						Cmd := Location;
					54: 
						cmd := SiteDimension(mc(1, 61), mc(1, 62));


					63: 
						Cmd := TransA2B(mc(1, 4), mc(1, 116));				{transfer address to grid }
					64: 
						Cmd := TransA2B(mc(1, 4), mc(3, 10));				{transfer address to cert page }
					65: 
						Cmd := TransA2B(mc(1, 5), mc(1, 117));				{transfer city to grid }
					66: 
						Cmd := CertPageAddress;								{concat city, state, zip}
					67: 
						Cmd := TransA2B(mc(1, 23), mc(1, 118));			{transfer sales price to grid }


					100: 				{AppraisalAmts}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 285), cxSubApprValue);
							Cmd := UpdatePublicTable(kAppraisalAmt, GetCellString(CurWPtr, mc(1, 285)));		{Public Value Amts}
						end;
					101: 				{kAppraisalDate}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 286), cxSubApprDate);
							Cmd := UpdatePublicTable(kAppraisalDate, GetCellString(CurWPtr, mc(1, 286)));		{make public}
						end;
					102: 				{kAppraiserName}
						begin
							Cmd := FillInAppraiserInfo;		{load all fields that pertain to appraiser}
							Cmd := UpdatePublicTable(kAppraiserName, GetCellString(CurWPtr, mc(3, 2)));
						end;
					103: 				{kAddress}
						begin
							ProcessCurCellInfo(CurWPtr, 63);
							ProcessCurCellInfo(CurWPtr, 64);
							Cmd := Broadcast2Context(CurWPtr, mc(1, 4), cxPropAddress);
							Cmd := UpdatePublicTable(kAddress, GetCellString(CurWPtr, mc(1, 4)));
						end;
					104: 				{kCityStZip - this happens automatically}
						begin
						end;
					105: 				{kFileNo}
						begin
							Cmd := UpdatePublicTable(kFileNo, GetCellString(CurWPtr, mc(1, 2)));
						end;
					106: 				{kLegalDesc }
						begin
							Cmd := UpdatePublicTable(kLegalDesc, GetCellString(CurWPtr, mc(1, 8)));
						end;
					107: 				{kOwner}
						begin
							Cmd := UpdatePublicTable(kOwner, GetCellString(CurWPtr, mc(1, 18)));
						end;
					108: 				{kBorrower}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 14), cxBorrower);				{load in to borrower}
							Cmd := UpdatePublicTable(kBorrower, GetCellString(CurWPtr, mc(1, 14)));
						end;
					109: 				{City}
						begin
							ProcessCurCellInfo(CurWPtr, 65);		{trans city to grid}
							ProcessCurCellInfo(CurWPtr, 66);		{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 5), cxCity);
							Cmd := UpdatePublicTable(kCity, GetCellString(CurWPtr, mc(1, 5)));
						end;
					110: 				{County}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 9), cxCounty);
							Cmd := UpdatePublicTable(kCounty, GetCellString(CurWPtr, mc(1, 9)));
						end;
					112: 				{State}
						begin
							ProcessCurCellInfo(CurWPtr, 66);		{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 6), cxState);
							Cmd := UpdatePublicTable(kState, GetCellString(CurWPtr, mc(1, 6)));
						end;
					113: 				{Zip Code}
						begin
							ProcessCurCellInfo(CurWPtr, 66);			{cert page address}
							Cmd := Broadcast2Context(CurWPtr, mc(1, 7), cxZipCode);
							Cmd := UpdatePublicTable(kZip, GetCellString(CurWPtr, mc(1, 7)));
						end;
					114: 				{Lender}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 16), cxLenderClient);}
							Cmd := UpdatePublicTable(kLenderCoName, GetCellString(CurWPtr, mc(3, 15)));
						end;
					115: 				{Lender Address}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 18), cxLenderAddress);}
							Cmd := UpdatePublicTable(kLenderAddress, GetCellString(CurWPtr, mc(3, 15)));
						end;
					116: 				{Comp1Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 139), 201);
							Cmd := UpdatePublicTable(kComp1Addr1, GetCellString(CurWPtr, mc(1, 139)));
						end;
					117:  				{Comp1Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 140), 202);
							Cmd := UpdatePublicTable(kComp1Addr2, GetCellString(CurWPtr, mc(1, 140)));
						end;
					118:  				{Comp2Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 184), 301);
							Cmd := UpdatePublicTable(kComp2Addr1, GetCellString(CurWPtr, mc(1, 185)));
						end;
					119:  				{Comp2Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 185), 302);
							Cmd := UpdatePublicTable(kComp2Addr2, GetCellString(CurWPtr, mc(1, 186)));
						end;
					120:  				{Comp3Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 229), 401);
							Cmd := UpdatePublicTable(kComp3Addr1, GetCellString(CurWPtr, mc(1, 231)));
						end;
					121:  				{Comp3Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 230), 402);
							Cmd := UpdatePublicTable(kComp3Addr2, GetCellString(CurWPtr, mc(1, 232)));
						end;
					122:  				{Comp4Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 34), 501);
							Cmd := UpdatePublicTable(kComp4Addr1, GetCellString(CurWPtr, mc(4, 34)));
						end;
					123:  				{Comp4Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 35), 502);
							Cmd := UpdatePublicTable(kComp4Addr2, GetCellString(CurWPtr, mc(4, 35)));
						end;
					124:  				{Comp5Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 79), 601);
							Cmd := UpdatePublicTable(kComp5Addr1, GetCellString(CurWPtr, mc(4, 80)));
						end;
					125:  				{Comp5Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 80), 602);
							Cmd := UpdatePublicTable(kComp5Addr2, GetCellString(CurWPtr, mc(4, 81)));
						end;
					126:  				{Comp6Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 124), 701);
							Cmd := UpdatePublicTable(kComp6Addr1, GetCellString(CurWPtr, mc(4, 126)));
						end;
					127:  				{Comp6Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(4, 125), 702);
							Cmd := UpdatePublicTable(kComp6Addr2, GetCellString(CurWPtr, mc(4, 127)));
						end;

					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;


	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin

		if false then {*** there are no adjustments}

			case CompNum of
				1: 
					ProcessCurCellInfo(WPtr, 1);
				2: 
					ProcessCurCellInfo(WPtr, 2);
				3: 
					ProcessCurCellInfo(WPtr, 3);
				4: 
					ProcessCurCellInfo(WPtr, 4);
				5: 
					ProcessCurCellInfo(WPtr, 5);
				6: 
					ProcessCurCellInfo(WPtr, 6);
			end;
	end;

	procedure DocMathInitalization (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
{ProcessCurCellInfo(WPtr, 1);		{comp1}
{ProcessCurCellInfo(WPtr, 2);		{comp2 }
{ProcessCurCellInfo(WPtr, 3);		{comp3 }
			end;
		if doPref(hasComps456) then
			begin
{ProcessCurCellInfo(WPtr, 4);		{comp4}
{ProcessCurCellInfo(WPtr, 5);		{comp5}
{ProcessCurCellInfo(WPtr, 6);		{comp6}
			end;
	end;

	procedure DocAdjustmentCalcs (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
{ProcessCurCellInfo(WPtr, 33);		{comp1 sqft adj}
{ProcessCurCellInfo(WPtr, 34);		{comp2 sqft adj}
{ProcessCurCellInfo(WPtr, 35);		{comp3 sqft adj}
			end;
		if doPref(hasComps456) then
			begin
{ProcessCurCellInfo(WPtr, 36);		{comp4 sqft adj}
{ProcessCurCellInfo(WPtr, 37);		{comp5 sqft adj}
{ProcessCurCellInfo(WPtr, 38);		{comp6 sqft adj}
			end;
	end; *)

(*
//FNMA 2075
	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;


{form specific}


	function SpecialLandUse: Integer;
	begin
		Val[1] := Sum4Cells(MC(1, 74), MC(1, 75), MC(1, 76), MC(1, 77));
		Val[2] := Sum4Cells(MC(1, 78), MC(1, 79), MC(1, 80), MC(1, 81));

		CellResult := Val[1] + Val[2];
		Result2InfoCell(1, 2, Num2Longint(CellResult));

		SpecialLandUse := 0;
	end;

	function InfoSalesAverage: Integer;
		var
			i, N: Integer;
	begin
		Val[1] := GetCellValue(CurWPtr, MC(2, 126));
		Val[2] := GetCellValue(CurWPtr, MC(2, 192));
		Val[3] := GetCellValue(CurWPtr, MC(2, 258));

		Val[4] := GetCellValue(CurWPtr, MC(3, 107));
		Val[5] := GetCellValue(CurWPtr, MC(3, 173));
		Val[6] := GetCellValue(CurWPtr, MC(3, 239));

		N := 0;
		for i := 1 to 6 do
			if val[i] <> 0 then
				N := N + 1;
		if N = 0 then
			CellResult := 0
		else
			CellResult := (Val[1] + val[2] + val[3] + Val[4] + val[5] + val[6]) / N;

		Result2InfoCell(2, 9, Num2Longint(CellResult));
		Result2InfoCell(3, 9, Num2Longint(CellResult));

		InfoSalesAverage := 0;
	end;

	function AddressUnit: Integer;
		var
			UnitNum: Str255;
			Address: Str255;
	begin
		UnitNum := GetCellString(CurWPtr, mc(1, 9));
		Address := GetCellString(CurWPtr, mc(1, 3));
		Address := Concat(Address, ', #', UnitNum);
		AddressUnit := Result2Cell(Address, mc(2, 29));
	end;

	function GetAddressUnitStr: Str255;
		var
			UnitNum: Str255;
			Address: Str255;
	begin
		GetAddressUnitStr := '';
		UnitNum := GetCellString(CurWPtr, mc(1, 9));
		Address := GetCellString(CurWPtr, mc(1, 3));
		if (Length(UnitNum) > 0) | (Length(Address) > 0) then
			GetAddressUnitStr := Concat(Address, ' #', UnitNum);
	end;

	function SumRooms: Integer;
	begin
		Val[1] := Sum6Cells(mc(1, 199), mc(1, 200), mc(1, 201), mc(1, 202), mc(1, 203), mc(1, 204));
		Val[2] := Sum6Cells(mc(1, 211), mc(1, 212), mc(1, 213), mc(1, 214), mc(1, 215), mc(1, 216));
		Val[3] := Sum6Cells(mc(1, 224), mc(1, 225), mc(1, 226), mc(1, 227), mc(1, 228), mc(1, 229));
		Val[4] := Sum4Cells(mc(1, 205), mc(1, 217), mc(1, 230), mc(0, 0));
		CellResult := Val[1] + Val[2] + val[3] + val[4];
		CellParm := GetCellParm(CurWPtr, MC(1, 235));
		SumRooms := Result2Cell(FormatNumber(CellResult, CellParm), MC(1, 235));
	end;

	function CertPageAddress: Integer;							{Concat address for cert page}
		var
			Str: Str255;
	begin
		Str := '';
		TempStr := GetCellString(CurWPtr, mc(1, 3));				{get address}
		Str := Concat(Str, ' ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 9));				{get unit}
		Str := Concat(Str, ' Unit #', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 4));				{get City}
		Str := Concat(Str, '  ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 5));				{get St}
		Str := Concat(Str, ', ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 6));				{get Zip}
		Str := Concat(Str, ' ', TempStr);

		CertPageAddress := Result2Cell(Str, mc(5, 1));
	end;

	function FillReviewerInfo: Integer;
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
		N := GetUserNameIndex(GetCellString(CurWPtr, mc(2, 294)));
		if n > 0 then
			begin
				Str2Cell(mc(5, 10), MacAppUser.User[N].CertNo);			{this is on cert page}
				Str2Cell(mc(5, 11), MacAppUser.User[N].LicNo);
				Str2Cell(mc(5, 12), MacAppUser.State);
				Str2Cell(mc(5, 13), MacAppUser.User[N].ExpDate);

				Str2Cell(mc(2, 296), MacAppUser.User[N].CertNo);
				Str2Cell(mc(2, 298), MacAppUser.User[N].LicNo);
				if Length(MacAppUser.User[N].CertNo) > 0 then
					begin
						Str2Cell(mc(2, 297), MacAppUser.State);
						Str2Cell(mc(2, 299), ' ');
					end
				else if Length(MacAppUser.User[N].LicNo) > 0 then
					begin
						Str2Cell(mc(2, 297), ' ');
						Str2Cell(mc(2, 299), MacAppUser.State);
					end;
			end;
		FillReviewerInfo := 0;
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

		Str2Cell(mc(2, 288), MacAppUser.User[N].CertNo);
		Str2Cell(mc(2, 290), MacAppUser.User[N].LicNo);
		if Length(MacAppUser.User[N].CertNo) > 0 then
			begin
				Str2Cell(mc(2, 289), MacAppUser.State);
				Str2Cell(mc(2, 291), ' ');
			end
		else if Length(MacAppUser.User[N].LicNo) > 0 then
			begin
				Str2Cell(mc(2, 289), ' ');
				Str2Cell(mc(2, 291), MacAppUser.State);
			end;

		FillInAppraiserInfo := 0;
	end;

	function InspectProperty: Integer;
		var
			DNC: Integer;
	begin
		with docPeek(CurWPtr)^.docCurCell do
			begin
				if (CurCell.Pg = 2) & (CurCell.Num = 292) then
					begin
						DNC := Result2Cell('X', mc(5, 14));		{set the checkmark}
						DNC := Result2Cell(' ', mc(5, 15));
					end
				else if (CurCell.Pg = 2) & (CurCell.Num = 293) then
					begin
						DNC := Result2Cell(' ', mc(5, 14));		{set the checkmark}
						DNC := Result2Cell('X', mc(5, 15));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 14) then
					begin
						DNC := Result2Cell('X', mc(2, 292));		{set the checkmark}
						DNC := Result2Cell(' ', mc(2, 293));
					end
				else if (CurCell.Pg = 5) & (CurCell.Num = 15) then
					begin
						DNC := Result2Cell(' ', mc(2, 292));		{set the checkmark}
						DNC := Result2Cell('X', mc(2, 293));
					end;
			end;
		InspectProperty := 0;
	end;

	function Location: Integer;
	begin
		if IsChecked(CurWPtr, mc(1, 32)) then
			Location := Result2Cell('Urban', mc(2, 35))

		else if IsChecked(CurWPtr, mc(1, 33)) then
			Location := Result2Cell('Suburban', mc(2, 35))

		else if IsChecked(CurWPtr, mc(1, 34)) then
			Location := Result2Cell('Urban', mc(2, 35))

		else
			Location := 0;
	end;

	function LeaseholdSimple: Integer;
	begin
		if IsChecked(CurWPtr, mc(1, 22)) then
			LeaseholdSimple := Result2Cell('Fee Simple', mc(2, 36))

		else if IsChecked(CurWPtr, mc(1, 23)) then
			LeaseholdSimple := Result2Cell('Leasehold', mc(2, 36))

		else
			LeaseholdSimple := 0;
	end;

	function ProjectType: Integer;
		var
			str: Str255;
	begin
		if IsChecked(CurWPtr, mc(1, 167)) then
			ProjectType := Result2Cell('Pri Residence', mc(2, 40))

		else if IsChecked(CurWPtr, mc(1, 168)) then
			ProjectType := Result2Cell('Recreation', mc(2, 40))

		else if IsChecked(CurWPtr, mc(1, 169)) then
			ProjectType := Result2Cell('Townhouse', mc(2, 40))

		else if IsChecked(CurWPtr, mc(1, 170)) then
			ProjectType := Result2Cell('Garden', mc(2, 40))

		else if IsChecked(CurWPtr, mc(1, 171)) then
			ProjectType := Result2Cell('Midrise', mc(2, 40))

		else if IsChecked(CurWPtr, mc(1, 172)) then
			ProjectType := Result2Cell('Highrise', mc(2, 40))

		else
			ProjectType := 0;
	end;

	function ProjectTypeOther: Integer;
	begin
		ProjectTypeOther := TransA2B(mc(1, 174), mc(2, 40));
	end;

	function CellHasText (WPtr: WindowPtr; CellA: CEllID; var cellStr: Str255): Boolean;
	begin
		cellStr := GetCellString(WPtr, CellA);
		CellHasText := length(CellStr) > 0;
	end;

	function NoCarStorage: Integer;
		var
			DNC: Integer;
	begin
		NoCarStorage := 0;
		if IsChecked(CurWPtr, mc(1, 273)) then
			begin
				DNC := Result2Cell('', mc(1, 274));
				DNC := Result2Cell('', mc(1, 275));
				DNC := Result2Cell('', mc(1, 276));
				DNC := Result2Cell('', mc(1, 277));
				DNC := Result2Cell('', mc(1, 278));
				DNC := Result2Cell('', mc(1, 279));

				NoCarStorage := Result2Cell('None', mc(2, 56));			{transfer 'None'}
			end;
	end;

	function HasGarageStorage: Integer;
		var
			tmpStr, kindStr: Str255;
			DNC: Integer;
			NCars: LongInt;
	begin
		tmpStr := '';

		if CellHasText(CurWPtr, mc(1, 275), kindStr) then				{Garage}
			begin
				DNC := Result2Cell('', mc(1, 273));
				DNC := Result2Cell('X', mc(1, 274));

				tmpStr := GetCellString(CurWPtr, mc(1, 275));				{number of cars}
				StringToNum(tmpStr, NCars);
				if NCars >= 1 then
					tmpStr := Concat(tmpStr, ' Car Garage');
			end;

		HasGarageStorage := Result2Cell(tmpStr, mc(2, 56))		{transfer '#Cars & Kind'}
	end;

	function HasOpenCarStorage: Integer;
		var
			tmpStr, kindStr: Str255;
			DNC: Integer;
			NCars: LongInt;
	begin
		tmpStr := '';
		if CellHasText(CurWPtr, mc(1, 277), kindStr) then
			begin
				DNC := Result2Cell('', mc(1, 273));			{zero out none}
				DNC := Result2Cell('X', mc(1, 276));

				tmpStr := GetCellString(CurWPtr, mc(1, 277));				{number of cars}
				StringToNum(tmpStr, NCars);
				if NCars >= 1 then
					tmpStr := Concat(tmpStr, ' Car Open');
			end;

		HasOpenCarStorage := Result2Cell(tmpStr, mc(2, 56))		{transfer '#Cars & Kind'}
	end;

	function Fireplaces: Integer;
		var
			cellStr: Str255;
			DNC: Integer;
	begin
		cellStr := GetCellString(CurWPtr, mc(1, 258));
		if Length(cellStr) > 0 then
			begin
				DNC := Result2Cell('X', mc(1, 259));
				cellStr := concat(cellStr, 'Fpl(s)');
				Fireplaces := Result2Cell(cellStr, mc(2, 58));
			end
		else
			begin
				DNC := Result2Cell('', mc(1, 259));
				Fireplaces := 0;
			end;
	end;

	function UtilitiesList: Integer;
		var
			DNC: Integer;
	begin
		if IsChecked(CurWPtr, mc(2, 8)) then
			begin
				DNC := Result2Cell('', mc(2, 9));
				DNC := Result2Cell('', mc(2, 10));
				DNC := Result2Cell('', mc(2, 11));
				DNC := Result2Cell('', mc(2, 12));
				DNC := Result2Cell('', mc(2, 13));
				DNC := Result2Cell('', mc(2, 14));
			end;
		UtilitiesList := 0;
	end;

	function TransferAge: integer;
		var
			ActAge, EffAge: Str255;
	begin
		ActAge := GetCellString(CurWPtr, mc(1, 139));
		if (length(ActAge) > 0) then
			ActAge := Concat('A(', ActAge, ')');

		EffAge := GetCellString(CurWPtr, mc(1, 140));

		if (length(EffAge) > 0) then
			begin
				ActAge := concat(ActAge, '/E(');
				if (length(EffAge) > 0) then
					ActAge := concat(ActAge, EffAge);
				ActAge := concat(ActAge, ')');
			end;

		TransferAge := Result2Cell(ActAge, mc(2, 45));
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					1: 
						begin
							Cmd := CertPageAddress;
							Cmd := AddressUnit;										{Transfer unit-address to grid}
						end;
					2: 
						Cmd := TransA2B(mc(1, 14), mc(2, 30));					{Project Name to grid}
					3: 
						Cmd := DivideAB(mc(1, 143), mc(1, 161), mc(1, 144));
					4: 
						Cmd := TransA2B(mc(1, 25), mc(2, 31));					{Sale price to grid}
					5: 
						Cmd := TransA2B(mc(1, 238), mc(2, 50));				{Living area}
					6: 
						Cmd := SumFourCells(MC(1, 209), MC(1, 221), MC(1, 234), MC(0, 0), MC(1, 238));		{Sum sqft}
					7: 
						Cmd := SpecialLandUse;
					8: 
						Cmd := SumFourCells(MC(1, 206), MC(1, 218), MC(1, 231), MC(0, 0), MC(1, 237));		{Sum Baths}
					9: 
						Cmd := SumFourCells(MC(1, 205), MC(1, 217), MC(1, 230), MC(0, 0), MC(1, 236));		{Sum Bedrms}
					10: 
						Cmd := SumRooms;
					11: 
						begin		{rooms & bedrooms}
							ProcessCurCellInfo(CurWPtr, 9);
							ProcessCurCellInfo(CurWPtr, 10);
							Cmd := 0;
						end;
					12: 
						begin
							ProcessCurCellInfo(CurWPtr, 5);		{trans area}
							ProcessCurCellInfo(CurWPtr, 41);	{charge/sqft/year}
							Cmd := 0;
						end;
					13: 
						Cmd := InfoAdjPercentage(mc(2, 64), 1, 3, 4);		{C1 Net Gross Adjs}
					14: 
						Cmd := InfoAdjPercentage(mc(2, 130), 2, 5, 6);		{C2 Net Gross Adjs}
					15: 
						Cmd := InfoAdjPercentage(mc(2, 196), 3, 7, 8);		{C3 Net Gross Adjs}
					16: 
						Cmd := InfoSalesAverage;
					17: 
						Cmd := SumAdjustments1;
					18: 
						Cmd := SumAdjustments2;
					19: 
						Cmd := SumAdjustments3;
					20: 
						begin
							Cmd := SetCheckMark(mc(2, 125), mc(2, 123), mc(2, 124));		{adj1- checkboxes}
							ProcessCurCellInfo(CurWPtr, 13);
							ProcessCurCellInfo(CurWPtr, 23);
							Cmd := 0;
						end;
					21: 
						begin
							Cmd := SetCheckMark(mc(2, 191), mc(2, 189), mc(2, 190));		{adj2- checkboxes}
							ProcessCurCellInfo(CurWPtr, 14);
							ProcessCurCellInfo(CurWPtr, 24);
							Cmd := 0;
						end;
					22: 
						begin
							Cmd := SetCheckMark(mc(2, 257), mc(2, 255), mc(2, 256));		{adj3- checkboxes}
							ProcessCurCellInfo(CurWPtr, 15);
							ProcessCurCellInfo(CurWPtr, 25);
							Cmd := 0;
						end;
					23: 
						Cmd := SumAB(mc(2, 64), mc(2, 125), mc(2, 126));		{1:sales - adj = value}
					24: 
						Cmd := SumAB(mc(2, 130), mc(2, 191), mc(2, 192));		{2:sales - adj = value}
					25: 
						Cmd := SumAB(mc(2, 196), mc(2, 257), mc(2, 258));		{3:sales - adj = value}

					26: 
						Cmd := SqFtAdjust(mc(2, 50), mc(2, 103), mc(2, 104));		{1: sqft ajd}
					27: 
						Cmd := SqFtAdjust(mc(2, 50), mc(2, 169), mc(2, 170));		{2: sqft ajd}
					28: 
						Cmd := SqFtAdjust(mc(2, 50), mc(2, 235), mc(2, 236));		{3: sqft ajd}

					29: 
						Cmd := DivideAB(mc(2, 64), mc(2, 103), mc(2, 65));		{1: price/sqft}
					30: 
						Cmd := DivideAB(mc(2, 130), mc(2, 169), mc(2, 131));	{2: price/sqft}
					31: 
						Cmd := DivideAB(mc(2, 196), mc(2, 235), mc(2, 197));	{3: price/sqft}
					32: 
						Cmd := DivideAB(mc(2, 31), mc(2, 50), mc(2, 32));		{Sub: price/sqft}

					33: 
						begin
							ProcessCurCellInfo(CurWPtr, 23);							{1: enter sales P}
							ProcessCurCellInfo(CurWPtr, 29);							{p/sqft}
							ProcessCurCellInfo(CurWPtr, 13);							{net/gross}
							Cmd := 0;
						end;
					34: 
						begin
							ProcessCurCellInfo(CurWPtr, 24);							{2: enter sales P}
							ProcessCurCellInfo(CurWPtr, 30);
							ProcessCurCellInfo(CurWPtr, 14);
							Cmd := 0;
						end;
					35: 
						begin
							ProcessCurCellInfo(CurWPtr, 25);							{3: enter sales P}
							ProcessCurCellInfo(CurWPtr, 31);
							ProcessCurCellInfo(CurWPtr, 15);
							Cmd := 0;
						end;

					36: 
						begin
							ProcessCurCellInfo(CurWPtr, 32);							{Sub: enter sqft}
							ProcessCurCellInfo(CurWPtr, 26);
							ProcessCurCellInfo(CurWPtr, 27);
							ProcessCurCellInfo(CurWPtr, 28);
							Cmd := 0;
						end;
					37: 
						begin
							ProcessCurCellInfo(CurWPtr, 26);							{1: enter sqft}
							ProcessCurCellInfo(CurWPtr, 29);
							Cmd := 0;
						end;
					38: 
						begin
							ProcessCurCellInfo(CurWPtr, 27);							{2: enter sqft}
							ProcessCurCellInfo(CurWPtr, 30);
							Cmd := 0;
						end;
					39: 
						begin
							ProcessCurCellInfo(CurWPtr, 28);							{3: enter sqft}
							ProcessCurCellInfo(CurWPtr, 31);
							Cmd := 0;
						end;


					40: 
						Cmd := MultAByVal(mc(2, 2), mc(2, 3), 12.0);			{charge/year}
					41: 
						Cmd := DivideAB(mc(2, 3), mc(1, 238), mc(2, 4));		{charge/sqft/year}

					42: 
						Cmd := TransA2B(mc(1, 235), mc(2, 47));		{trans total rooms}
					43: 
						Cmd := TransA2B(mc(1, 236), mc(2, 48));		{trans bedrooms}
					44: 
						Cmd := TransA2B(mc(1, 237), mc(2, 49));		{trans baths}


					45: 
						Cmd := TransferAge;
					46: 
						Cmd := 0;
					47: 
						Cmd := 0;

					48: 
						Cmd := MultAB(mc(2, 274), mc(2, 275), mc(2, 276));					{gross rent multi}

{Page 3 math}
					49: 
						Cmd := SumAdjustments4;
					50: 
						Cmd := SumAdjustments5;
					51: 
						Cmd := SumAdjustments6;
					52: 
						Cmd := SumAB(mc(3, 45), mc(3, 106), mc(3, 107));		{4:sales + adj = value}
					53: 
						Cmd := SumAB(mc(3, 111), mc(3, 172), mc(3, 173));		{5:sales + adj = value}
					54: 
						Cmd := SumAB(mc(3, 177), mc(3, 238), mc(3, 239));		{6:sales + adj = value}

					55: 
						Cmd := SqFtAdjust(mc(3, 31), mc(3, 84), mc(3, 85));			{4: sqft ajd}
					56: 
						Cmd := SqFtAdjust(mc(3, 31), mc(3, 150), mc(3, 151));		{5: sqft ajd}
					57: 
						Cmd := SqFtAdjust(mc(3, 31), mc(3, 216), mc(3, 217));		{6: sqft ajd}

					58: 
						Cmd := DivideAB(mc(3, 12), mc(3, 31), mc(3, 13));		{Sub: price/sqft}
					59: 
						Cmd := DivideAB(mc(3, 45), mc(3, 84), mc(3, 46));		{4: price/sqft}
					60: 
						Cmd := DivideAB(mc(3, 111), mc(3, 150), mc(3, 112));	{5: price/sqft}
					61: 
						Cmd := DivideAB(mc(3, 177), mc(3, 216), mc(3, 178));	{6: price/sqft}
					62: 
						Cmd := SetCheckMark(mc(3, 106), mc(3, 104), mc(3, 105));		{adj4- checkboxes}
					63: 
						Cmd := SetCheckMark(mc(3, 172), mc(3, 170), mc(3, 171));		{adj5- checkboxes}
					64: 
						Cmd := SetCheckMark(mc(3, 238), mc(3, 236), mc(3, 237));		{adj6- checkboxes}
					65: 
						Cmd := InfoAdjPercentage(mc(3, 45), 4, 3, 4);		{C4 Net Gross Adjs}
					66: 
						Cmd := InfoAdjPercentage(mc(3, 111), 5, 5, 6);		{C5 Net Gross Adjs}
					67: 
						Cmd := InfoAdjPercentage(mc(3, 177), 6, 7, 8);		{C6 Net Gross Adjs}

					68: 												{Price changed}
						begin
							ProcessCurCellInfo(CurWPtr, 52);		{C4 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 59);		{p/sqft}
							ProcessCurCellInfo(CurWPtr, 65);		{net/gross%}
							Cmd := 0;
						end;
					69: 
						begin
							ProcessCurCellInfo(CurWPtr, 53);		{C5 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 60);		{p/sqft}
							ProcessCurCellInfo(CurWPtr, 66);		{net/gross%}
							Cmd := 0;
						end;
					70: 
						begin
							ProcessCurCellInfo(CurWPtr, 54);		{C6 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 61);		{p/sqft}
							ProcessCurCellInfo(CurWPtr, 67);		{net/gross%}
							Cmd := 0;
						end;

					71: 												{Adj Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 52);		{C4 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 62);		{checkboxes}
							ProcessCurCellInfo(CurWPtr, 65);		{net/gross%}
							Cmd := 0;
						end;
					72: 												{Adj Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 53);		{C5 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 63);		{checkboxes}
							ProcessCurCellInfo(CurWPtr, 66);		{net/gross%}
							Cmd := 0;
						end;
					73: 												{Adj Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 54);		{C6 sp - adj= net}
							ProcessCurCellInfo(CurWPtr, 64);		{checkboxes}
							ProcessCurCellInfo(CurWPtr, 67);		{net/gross%}
							Cmd := 0;
						end;
					74: 												{sqft Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 55);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 59);		{p/sqft}
							Cmd := 0;
						end;
					75: 												{sqft Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 56);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 60);		{p/sqft}
							Cmd := 0;
						end;
					76: 												{sqft Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 57);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 61);		{p/sqft}
							Cmd := 0;
						end;
					77: 												{sub sqft Changed}
						begin
							ProcessCurCellInfo(CurWPtr, 55);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 56);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 57);		{subsqft-csqft=-adj}
							ProcessCurCellInfo(CurWPtr, 58);		{sub p/sqft}
							Cmd := 0;
						end;
					78: 
						Cmd := Location;					{set location on grid}
					79: 
						Cmd := LeaseHoldSimple;		{set leasehold/fee simple}
					80: 
						Cmd := TransA2B(mc(1, 24), mc(2, 37));		{trans HOA Mo Assessment}
					81: 
						Cmd := ProjectType;
					82: 
						Cmd := ProjectTypeOther;
					83: 
						Cmd := TransA2B(mc(1, 125), mc(2, 42));		{trans View}
					84: 
						Cmd := TransferAge;		{trans age & effective age}
					85: 
						Cmd := NoCarStorage;
					86: 
						Cmd := HasGarageStorage;
					87: 
						Cmd := Fireplaces;
					88: 
						Cmd := UtilitiesList;
					89: 
						Cmd := HasOpenCarStorage;

					95: 
						Cmd := FillReviewerInfo;
					96: 
						Cmd := FillInAppraiserInfo;
					97: 
						Cmd := InspectProperty;			{toggle checkboxes}


					100: 				{AppraisalAmts}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 285), cxSubApprValue);
							Cmd := UpdatePublicTable(kAppraisalAmt, GetCellString(CurWPtr, mc(2, 285)));		{Public Value Amts}
						end;
					101: 				{kAppraisalDate}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 284), cxSubApprDate);
							Cmd := UpdatePublicTable(kAppraisalDate, GetCellString(CurWPtr, mc(2, 284)));		{make public}
						end;
					102: 				{kAppraiserName}
						begin
							Cmd := FillInAppraiserInfo;		{load all fields that pertain to appraiser}
							Cmd := UpdatePublicTable(kAppraiserName, GetCellString(CurWPtr, mc(2, 286)));
						end;
					103: 				{kAddress}
						begin
							ProcessCurCellInfo(CurWPtr, 1);		{combine unit/address & concat for cert page}
							Cmd := BroadcastStr2Context(CurWPtr, GetAddressUnitStr, cxPropAddress);
							Cmd := UpdatePublicTable(kAddress, GetAddressUnitStr);
						end;
					104: 				{kCityStZip - this happens automatically}
						begin
						end;
					105: 				{kFileNo}
						begin
							Cmd := UpdatePublicTable(kFileNo, GetCellString(CurWPtr, mc(1, 2)));
						end;
					106: 				{kLegalDesc }
						begin
							Cmd := UpdatePublicTable(kLegalDesc, GetCellString(CurWPtr, mc(1, 7)));
						end;
					107: 				{kOwner}
						begin
							Cmd := UpdatePublicTable(kOwner, GetCellString(CurWPtr, mc(1, 18)));
						end;
					108: 				{kBorrower}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 17), cxBorrower);
							Cmd := UpdatePublicTable(kBorrower, GetCellString(CurWPtr, mc(1, 17)));
						end;
					109: 				{City}
						begin
							Cmd := CertPageAddress;
							Cmd := Broadcast2Context(CurWPtr, mc(1, 4), cxCity);
							Cmd := UpdatePublicTable(kCity, GetCellString(CurWPtr, mc(1, 4)));
						end;
					110: 				{County}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 8), cxCounty);
							Cmd := UpdatePublicTable(kCounty, GetCellString(CurWPtr, mc(1, 8)));
						end;
					112: 				{State}
						begin
							Cmd := CertPageAddress;
							Cmd := Broadcast2Context(CurWPtr, mc(1, 5), cxState);
							Cmd := UpdatePublicTable(kState, GetCellString(CurWPtr, mc(1, 5)));
						end;
					113: 				{Zip Code}
						begin
							Cmd := CertPageAddress;
							Cmd := Broadcast2Context(CurWPtr, mc(1, 6), cxZipCode);
							Cmd := UpdatePublicTable(kZip, GetCellString(CurWPtr, mc(1, 6)));
						end;
					114: 				{Lender}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 28), cxLenderClient);
							Cmd := UpdatePublicTable(kLenderCoName, GetCellString(CurWPtr, mc(1, 28)));
						end;
					115: 				{Lender Address}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 29), cxLenderAddress);
							Cmd := UpdatePublicTable(kLenderAddress, GetCellString(CurWPtr, mc(1, 29)));
						end;
					116: 				{Comp1Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 61), 201);
							Cmd := UpdatePublicTable(kComp1Addr1, GetCellString(CurWPtr, mc(2, 61)));
						end;
					117:  				{Comp1Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 62), 202);
							Cmd := UpdatePublicTable(kComp1Addr2, GetCellString(CurWPtr, mc(2, 62)));
						end;
					118:  				{Comp2Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 127), 301);
							Cmd := UpdatePublicTable(kComp2Addr1, GetCellString(CurWPtr, mc(2, 127)));
						end;
					119:  				{Comp2Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 128), 302);
							Cmd := UpdatePublicTable(kComp2Addr2, GetCellString(CurWPtr, mc(2, 128)));
						end;
					120:  				{Comp3Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 193), 401);
							Cmd := UpdatePublicTable(kComp3Addr1, GetCellString(CurWPtr, mc(2, 193)));
						end;
					121:  				{Comp3Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(2, 194), 402);
							Cmd := UpdatePublicTable(kComp3Addr2, GetCellString(CurWPtr, mc(2, 194)));
						end;
					122:  				{Comp4Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 42), 501);
							Cmd := UpdatePublicTable(kComp4Addr1, GetCellString(CurWPtr, mc(3, 42)));
						end;
					123:  				{Comp4Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 43), 502);
							Cmd := UpdatePublicTable(kComp4Addr2, GetCellString(CurWPtr, mc(3, 43)));
						end;
					124:  				{Comp5Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 108), 601);
							Cmd := UpdatePublicTable(kComp5Addr1, GetCellString(CurWPtr, mc(3, 108)));
						end;
					125:  				{Comp5Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 109), 602);
							Cmd := UpdatePublicTable(kComp5Addr2, GetCellString(CurWPtr, mc(3, 109)));
						end;
					126:  				{Comp6Addr1}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 174), 701);
							Cmd := UpdatePublicTable(kComp6Addr1, GetCellString(CurWPtr, mc(3, 174)));
						end;
					127:  				{Comp6Addr2}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(3, 175), 702);
							Cmd := UpdatePublicTable(kComp6Addr2, GetCellString(CurWPtr, mc(3, 175)));
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
				ProcessCurCellInfo(WPtr, 17);
			2: 
				ProcessCurCellInfo(WPtr, 18);
			3: 
				ProcessCurCellInfo(WPtr, 19);
			4: 
				ProcessCurCellInfo(WPtr, 49);
			5: 
				ProcessCurCellInfo(WPtr, 50);
			6: 
				ProcessCurCellInfo(WPtr, 51);
		end;
	end;

	procedure DocMathInitalization (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
				ProcessCurCellInfo(WPtr, 17);		{comp1}
				ProcessCurCellInfo(WPtr, 18);		{comp2}
				ProcessCurCellInfo(WPtr, 19);		{comp3}
			end;
		if doPref(hasComps456) then
			begin
				ProcessCurCellInfo(WPtr, 49);		{comp4}
				ProcessCurCellInfo(WPtr, 50);		{comp5}
				ProcessCurCellInfo(WPtr, 51);		{comp6}
			end;

		ProcessCurCellInfo(WPtr, 16);			{InfoSalesAverage}
		ProcessCurCellInfo(WPtr, 7);			{InfoSumLandUse}
	end;

	procedure DocAdjustmentCalcs (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
				ProcessCurCellInfo(WPtr, 26);		{comp1 sqft adj}
				ProcessCurCellInfo(WPtr, 27);		{comp2 sqft adj}
				ProcessCurCellInfo(WPtr, 28);		{comp3 sqft adj}
			end;
		if doPref(hasComps456) then
			begin
				ProcessCurCellInfo(WPtr, 55);		{comp4 sqft adj}
				ProcessCurCellInfo(WPtr, 56);		{comp5 sqft adj}
				ProcessCurCellInfo(WPtr, 57);		{comp6 sqft adj}
			end;
	end; *)

(*
//FNMA 2095

*)

(*
//FMAC 2070
	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
	end;

	function CertPageAddress: Integer;							{Concat address for cert page}
		var
			Str: Str255;
	begin
		Str := '';

		Str := GetCellString(CurWPtr, mc(1, 5));					{get City}

		TempStr := GetCellString(CurWPtr, mc(1, 6));				{get St}
		Str := Concat(Str, ', ', TempStr);

		TempStr := GetCellString(CurWPtr, mc(1, 7));				{get Zip}
		Str := Concat(Str, ' ', TempStr);

		CertPageAddress := Result2Cell(Str, mc(3, 11));
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
		if length(MacAppUser.User[N].CertNo) > 0 then
			Str2Cell(mc(1, 147), MacAppUser.User[N].CertNo)
		else
			Str2Cell(mc(1, 147), MacAppUser.User[N].LicNo);
		Str2Cell(mc(1, 148), MacAppUser.State);
{Str2Cell(mc(3, 9), MacAppUser.User[N].ExpDate);}

		FillInAppraiserInfo := 0;
	end;

	function FillReviewerInfo: Integer;
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
		N := GetUserNameIndex(GetCellString(CurWPtr, mc(1, 151)));
		if n > 0 then
			begin
				if length(MacAppUser.User[N].CertNo) > 0 then
					Str2Cell(mc(1, 154), MacAppUser.User[N].CertNo)			{this is on cert page}
				else
					Str2Cell(mc(1, 154), MacAppUser.User[N].LicNo);
				Str2Cell(mc(1, 155), MacAppUser.State);
{Str2Cell(mc(3, 24), MacAppUser.User[N].ExpDate);}
			end;
		FillReviewerInfo := 0;
	end;

	function Location: Integer;
	begin
		if IsChecked(CurWPtr, mc(1, 30)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 31)) then
			Location := Result2Cell('Suburban', mc(1, 120))

		else if IsChecked(CurWPtr, mc(1, 32)) then
			Location := Result2Cell('Urban', mc(1, 120))

		else
			Location := 0;
	end;

	function CheckBoxRating (cell1, cell2, cell3, cell4, cell5, cellR: CellID): Integer;
		var
			ratingStr: Str255;
	begin
		ratingStr := '';

		if IsChecked(CurWPtr, cell1) then
			ratingStr := 'Excellent';

		if IsChecked(CurWPtr, cell2) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Good');
			end;

		if IsChecked(CurWPtr, cell3) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Average');
			end;

		if IsChecked(CurWPtr, cell4) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Fair');
			end;

		if IsChecked(CurWPtr, cell5) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Poor');
			end;

		CheckBoxRating := Result2Cell(ratingStr, cellR);
	end;


	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					1: 
						Cmd := FillReviewerInfo;

					100: 				{AppraisalAmts}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(1, 285), cxSubApprValue);}
{Cmd := UpdatePublicTable(kAppraisalAmt, GetCellString(CurWPtr, mc(1, 285)));		{Public Value Amts}
							Cmd := 0;
						end;
					101: 				{kAppraisalDate}
						begin
							Cmd := Broadcast2Context(CurWPtr, mc(1, 146), cxSubApprDate);
							Cmd := UpdatePublicTable(kAppraisalDate, GetCellString(CurWPtr, mc(1, 146)));		{make public}
						end;
					102: 				{kAppraiserName}
						begin
							Cmd := FillInAppraiserInfo;		{load all fields that pertain to appraiser}
							Cmd := UpdatePublicTable(kAppraiserName, GetCellString(CurWPtr, mc(1, 144)));
						end;
					103: 				{kAddress}
						begin
{    Cmd := Broadcast2Context(CurWPtr, mc(1, 3), cxPropAddress);}
							Cmd := UpdatePublicTable(kAddress, GetCellString(CurWPtr, mc(1, 3)));
						end;
					104: 				{kCityStZip - this happens automatically}
						begin
						end;
					105: 				{kFileNo}
						begin
							Cmd := UpdatePublicTable(kFileNo, GetCellString(CurWPtr, mc(1, 2)));
						end;
					106: 				{kLegalDesc }
						begin
							Cmd := UpdatePublicTable(kLegalDesc, GetCellString(CurWPtr, mc(1, 7)));
						end;
					107: 				{kOwner}
						begin
							Cmd := UpdatePublicTable(kOwner, GetCellString(CurWPtr, mc(1, 14)));
						end;
					108: 				{kBorrower}
						begin
{    Cmd := Broadcast2Context(CurWPtr, mc(1, 13), cxBorrower);				{load in to borrower}
							Cmd := UpdatePublicTable(kBorrower, GetCellString(CurWPtr, mc(1, 13)));
						end;
					109: 				{City}
						begin
{ Cmd := Broadcast2Context ( CurWPtr , mc ( 1 , 4 ) , cxCity );}
							Cmd := UpdatePublicTable(kCity, GetCellString(CurWPtr, mc(1, 4)));
						end;
					110: 				{County}
						begin
{    Cmd := Broadcast2Context(CurWPtr, mc(1, 8), cxCounty);}
							Cmd := UpdatePublicTable(kCounty, GetCellString(CurWPtr, mc(1, 8)));
						end;
					112: 				{State}
						begin
{    Cmd := Broadcast2Context(CurWPtr, mc(1, 5), cxState);}
							Cmd := UpdatePublicTable(kState, GetCellString(CurWPtr, mc(1, 5)));
						end;
					113: 				{Zip Code}
						begin
{    Cmd := Broadcast2Context(CurWPtr, mc(1, 6), cxZipCode);}
							Cmd := UpdatePublicTable(kZip, GetCellString(CurWPtr, mc(1, 6)));
						end;
					114: 				{Lender}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 16), cxLenderClient);}
							Cmd := UpdatePublicTable(kLenderCoName, GetCellString(CurWPtr, mc(1, 27)));
						end;
					115: 				{Lender Address}
						begin
{Cmd := Broadcast2Context(CurWPtr, mc(2, 18), cxLenderAddress);}
							Cmd := UpdatePublicTable(kLenderAddress, GetCellString(CurWPtr, mc(1, 28)));
						end;

					otherwise
						Cmd := 0;
				end;
			until Cmd = 0;
	end;

	procedure ReCalcGridComp (WPtr: WindowPtr; CompNum: Integer);
	begin
{    case CompNum of}
{1:}
{    ProcessCurCellInfo(WPtr, 1);}
{2:}
{    ProcessCurCellInfo(WPtr, 2);}
{3:}
{    ProcessCurCellInfo(WPtr, 3);}
{4:}
{    ProcessCurCellInfo(WPtr, 4);}
{5:}
{    ProcessCurCellInfo(WPtr, 5);}
{6:}
{    ProcessCurCellInfo(WPtr, 6);}
{    end;}
	end;

	procedure DocMathInitalization (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
{ProcessCurCellInfo(WPtr, 1);		{comp1}
{ProcessCurCellInfo(WPtr, 2);		{comp2 }
{ProcessCurCellInfo(WPtr, 3);		{comp3 }
			end;
		if doPref(hasComps456) then
			begin
{ProcessCurCellInfo(WPtr, 4);		{comp4}
{ProcessCurCellInfo(WPtr, 5);		{comp5}
{ProcessCurCellInfo(WPtr, 6);		{comp6}
			end;
	end;

	procedure DocAdjustmentCalcs (WPtr: WindowPtr);
	begin
		if doPref(hasComps123) then
			begin
{ProcessCurCellInfo(WPtr, 33);		{comp1 sqft adj}
{ProcessCurCellInfo(WPtr, 34);		{comp2 sqft adj}
{ProcessCurCellInfo(WPtr, 35);		{comp3 sqft adj}
			end;
		if doPref(hasComps456) then
			begin
{ProcessCurCellInfo(WPtr, 36);		{comp4 sqft adj}
{ProcessCurCellInfo(WPtr, 37);		{comp5 sqft adj}
{ProcessCurCellInfo(WPtr, 38);		{comp6 sqft adj}
			end;
	end; *)
// FNMA 2055
(*
	function CheckBoxRating (cell1, cell2, cell3, cell4, cell5, cellR: CellID): Integer;
		var
			ratingStr: Str255;
	begin
		ratingStr := '';

		if IsChecked(CurWPtr, cell1) then
			ratingStr := 'Excellent';

		if IsChecked(CurWPtr, cell2) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Good');
			end;

		if IsChecked(CurWPtr, cell3) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Average');
			end;

		if IsChecked(CurWPtr, cell4) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Fair');
			end;

		if IsChecked(CurWPtr, cell5) then
			begin
				if length(ratingStr) > 0 then
					ratingStr := Concat(ratingStr, '/');
				ratingStr := concat(ratingStr, 'Poor');
			end;

		CheckBoxRating := Result2Cell(ratingStr, cellR);
	end;
*)

//1073 LISTING
function F0888C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 59,120,121,118,119,1,2,
            [64,66,68,70,72,74,76,78,80,82,84,86,88,90,91,95,97,99,101,103,105,107,109,111,113,115,117]);
end;

function F0888C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 128,189,190,187,188,3,4,
            [133,135,137,139,141,143,145,147,149,151,153,155,157,159,160,164,166,168,170,172,174,176,178,180,182,184,186]);
end;

function F0888C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 197,258,259,256,257,5,6,
            [202,204,206,208,210,212,214,216,218,220,222,224,226,228,229,233,235,237,239,241,243,245,247,249,251,253,255]);
end;

function F0037Location(doc: TContainer; CX: CellUID): Integer;
var
  LocStr: String;
begin
  LocStr := '';
  result := 0;
  if CellIsChecked(doc, mcx(cx, 30)) then
    LocStr := 'Urban'

  else if CellIsChecked(doc, mcx(cx, 31)) then
    LocStr := 'Suburban'

  else if CellIsChecked(doc, mcx(cx, 32)) then
    LocStr := 'Rural';

  if Length(LocStr) > 0 then
    result := SetCellString(doc, mcx(cx,120), LocStr);
end;

function F0037C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 142;
  TotalAdj  = 182;
  FinalAmt  = 183;
  PlusChk   = 180;
  NegChk    = 181;
  InfoNet   = 4;
  InfoGross = 5;
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

function F0037C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 189;
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

function F0037C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 236;
  TotalAdj  = 276;
  FinalAmt  = 277;
  PlusChk   = 274;
  NegChk    = 275;
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
  GetNetGrosAdjs(doc, mcx(cx,257), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,261), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,263), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,265), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,267), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,269), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,271), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,273), NetAdj, GrsAdj);

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

// 2055 Extra Comparables
function F0038C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 41;
  TotalAdj  = 81;
  FinalAmt  = 82;
  PlusChk   = 79;
  NegChk    = 80;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,45), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,47), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,49), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,53), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,70), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,78), NetAdj, GrsAdj);

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

function F0038C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 89;
  TotalAdj  = 129;
  FinalAmt  = 130;
  PlusChk   = 127;
  NegChk    = 128;
  InfoNet   = 6;
  InfoGross = 7;
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
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);

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

function F0038C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 137;
  TotalAdj  = 177;
  FinalAmt  = 178;
  PlusChk   = 175;
  NegChk    = 176;
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
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);

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


//FNMA 2095 Comp Calculations
function F0042C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 45;
  TotalAdj  = 109;
  FinalAmt  = 110;
  PlusChk   = 107;
  NegChk    = 108;
  InfoNet   = 3;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,51), NetAdj, GrsAdj);
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

function F0042C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 115;
  TotalAdj  = 179;
  FinalAmt  = 180;
  PlusChk   = 177;
  NegChk    = 178;
  InfoNet   = 6;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,151), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
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

function F0042C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 185;
  TotalAdj  = 249;
  FinalAmt  = 250;
  PlusChk   = 247;
  NegChk    = 248;
  InfoNet   = 7;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,224), NetAdj, GrsAdj);
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

{***********************}
{   FNMA BPO            }
{***********************}
function F0166L1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 95;
  TotalAdj  = 154;
  FinalAmt  = 155;
  PlusChk   = 152;
  NegChk    = 153;
  InfoNet   = 3;
  InfoGross = 4;
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
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
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

function F0166L2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 159;
  TotalAdj  = 218;
  FinalAmt  = 219;
  PlusChk   = 216;
  NegChk    = 217;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
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

function F0166L3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 223;
  TotalAdj  = 282;
  FinalAmt  = 283;
  PlusChk   = 280;
  NegChk    = 281;
  InfoNet   = 7;
  InfoGross = 8;
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
  GetNetGrosAdjs(doc, mcx(cx,249), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,253), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,255), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,257), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,259), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,261), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,263), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,265), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,267), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,269), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,271), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,273), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,275), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,277), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,279), NetAdj, GrsAdj);

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

//FNMA BPO Comps
function F0166C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 59;
  TotalAdj  = 118;
  FinalAmt  = 119;
  PlusChk   = 116;
  NegChk    = 117;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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

function F0166C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 123;
  TotalAdj  = 182;
  FinalAmt  = 183;
  PlusChk   = 180;
  NegChk    = 181;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
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

function F0166C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 187;
  TotalAdj  = 246;
  FinalAmt  = 247;
  PlusChk   = 244;
  NegChk    = 245;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
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
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
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
  GetNetGrosAdjs(doc, mcx(cx,239), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,241), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,243), NetAdj, GrsAdj);

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

function F0869C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  Result := SalesGridAdjustment(doc, CX, 57, 125, 126, 123, 124, 1, 2,
            [63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 84, 88, 92, 96, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122]);
end;

function F0869C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  Result := SalesGridAdjustment(doc, CX, 131, 199, 200, 197, 198, 3, 4,
            [137, 139, 141, 143, 145, 147, 149, 151, 153, 155, 157, 158, 162, 166, 170, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196]);
end;

function F0869C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  Result := SalesGridAdjustment(doc, CX, 205, 273, 274, 271, 272, 5, 6,
            [211, 213, 215, 217, 219, 221, 223, 225, 227, 229, 231, 232, 236, 240, 244, 248, 250, 252, 254, 256, 258, 260, 262, 264, 266, 268, 270]);
end;

//Second Mortgage 704
function ProcessForm0013Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          cmd := F0013C1Adjustments(doc, cx);       //redo the adjustments
        2:
          cmd := F0013C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        4:   //sales price changed
          cmd := F0013C2Adjustments(doc, cx);       //redo the adjustments
        5:
          cmd := F0013C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F0013C3Adjustments(doc, cx);       //redo the adjustments
        8:
          cmd := F0013C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := CalcWeightedAvg(doc, [cx.FormID,15]);   //calc wtAvg of main and xcomps forms
        10:
          begin
            F0013C1Adjustments(doc, cx);       //sum of adjs
            F0013C2Adjustments(doc, cx);       //sum of adjs
            F0013C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0013Math(doc, 2, CX);
          ProcessForm0013Math(doc, 5, CX);
          ProcessForm0013Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0013Math(doc, 10, CX);
        end;
    end;

  result := 0;
end;

//Second Mortgage Extra Comps
function ProcessForm0015Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',33,73,113, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,73,113);
        3:
          cmd := ConfigXXXInstance(doc, cx, 33,73,113);

//Comp1 calcs
        4:    //sales price changed
          cmd := F0015C1Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F0015C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        7:   //sales price changed
          cmd := F0015C2Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F0015C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        10:   //sales price changed
          cmd := F0015C3Adjustments(doc, cx);     //redo the adjustments
        11:
          cmd := F0015C3Adjustments(doc, cx);     //sum of adjs
        12:
          if doc.GetFormIndex(13) <> -1 then     //decide which is main form 13 or 14
            cmd := CalcWeightedAvg(doc, [13,15])   //calc wtAvg of main and xcomps forms
          else
            cmd := CalcWeightedAvg(doc, [14,15]);
        13:
          begin
            F0015C1Adjustments(doc, cx);       //sum of adjs
            F0015C2Adjustments(doc, cx);       //sum of adjs
            F0015C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0015Math(doc, 5, CX);
          ProcessForm0015Math(doc, 8, CX);
          ProcessForm0015Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0015Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;

//FNMA 1095
function ProcessForm0036Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//FNMA 2055
function ProcessForm0037Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
              //Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0037Math(doc, 3, CX);       //calc new price/sqft
            Cmd := F0037C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0037C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,142), mcx(cx,168), mcx(cx,143));     //price/sqft

              //Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0037Math(doc, 6, CX);     //calc new price/sqft
            Cmd := F0037C2Adjustments(doc, cx);   //redo the adjustments
          end;
        5:
          cmd := F0037C2Adjustments(doc, cx);     //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,189), mcx(cx,215), mcx(cx,190));     //price/sqft

              //Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0037Math(doc, 9, CX);     //calc new price/sqft
            Cmd := F0037C3Adjustments(doc, cx);   //redo the adjustments
          end;
        8:
          cmd := F0037C3Adjustments(doc, cx);     //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,236), mcx(cx,262), mcx(cx,237));     //price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,118), mcx(cx,129), mcx(cx,119));     //subject price/sqft
        11:
          cmd := SiteDimension(doc, CX, MCX(cx,62));
        12:
          cmd := F0037Location(doc, cx);
//        13:
//          cmd := TransA2B(doc, CX, mcx(CX, 266));
        14:
          cmd := CalcWeightedAvg(doc, [CX.formID,38]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0037C1Adjustments(doc, cx);     //sum of adjs
            F0037C2Adjustments(doc, cx);     //sum of adjs
            F0037C3Adjustments(doc, cx);     //sum of adjs
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
          ProcessForm0037Math(doc, 2, CX);
          ProcessForm0037Math(doc, 5, CX);
          ProcessForm0037Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0037Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//FNMA 2055 XComps
function ProcessForm0038Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0038Math(doc, 3, CX);     //calc new price/sqft
           cmd := F0038C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0038C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,41), mcx(cx,67), mcx(cx,42));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0038Math(doc, 6, CX);     //calc new price/sqft
           cmd := F0038C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0038C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,89), mcx(cx,115), mcx(cx,90));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0038Math(doc, 9, CX);     //calc new price/sqft
           cmd := F0038C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0038C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,137), mcx(cx,163), mcx(cx,138));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft

        11:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 37,85,133,2);
        12:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 37,85,133);
        13:
          cmd := ConfigXXXInstance(doc, cx, 37,85,133);
        14:
          cmd := CalcWeightedAvg(doc, [37,38]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0038C1Adjustments(doc, cx);       //sum of adjs
            F0038C2Adjustments(doc, cx);       //sum of adjs
            F0038C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0038Math(doc, 2, CX);
          ProcessForm0038Math(doc, 5, CX);
          ProcessForm0038Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0038Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//FNMA 2065
function ProcessForm0039Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAB(doc, mcx(cx,119), mcx(cx,130), mcx(cx,120));     //Subj price/sqft
        2: Cmd := DivideAB(doc, mcx(cx,143), mcx(cx,168), mcx(cx,144));     //C1 price/sqft
        3: Cmd := DivideAB(doc, mcx(cx,188), mcx(cx,213), mcx(cx,189));     //C2 price/sqft
        4: Cmd := DivideAB(doc, mcx(cx,233), mcx(cx,258), mcx(cx,234));     //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FNMA 2065 Extra Comps
function ProcessForm0040Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',37,83,129, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 37,83,129);
        3:
          cmd := ConfigXXXInstance(doc, cx, 37,83,129);     //called by FormConfigure

        4: cmd := DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));        //Subj price/sqft
        5: Cmd := DivideAB(doc, mcx(cx,41), mcx(cx,66), mcx(cx,42));        //C1 price/sqft
        6: Cmd := DivideAB(doc, mcx(cx,87), mcx(cx,112), mcx(cx,88));       //C2 price/sqft
        7: Cmd := DivideAB(doc, mcx(cx,133), mcx(cx,158), mcx(cx,134));     //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FNMA 2075
function ProcessForm0041Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

//FMAC 2095
function ProcessForm0042Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
              //Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0042Math(doc, 3, CX);       //calc new price/sqft
            Cmd := F0042C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0042C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,45), mcx(cx,89), mcx(cx,46));     //price/sqft

              //Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0042Math(doc, 6, CX);     //calc new price/sqft
            Cmd := F0042C2Adjustments(doc, cx);   //redo the adjustments
          end;
        5:
          cmd := F0042C2Adjustments(doc, cx);     //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,115), mcx(cx,159), mcx(cx,116));     //price/sqft

              //Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0042Math(doc, 9, CX);     //calc new price/sqft
            Cmd := F0042C3Adjustments(doc, cx);   //redo the adjustments
          end;
        8:
          cmd := F0042C3Adjustments(doc, cx);     //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,185), mcx(cx,229), mcx(cx,186));     //price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,8), mcx(cx,30), mcx(cx,9));     //subject price/sqft
        11:
          cmd := CalcWeightedAvg(doc, [42]);   //calc wtAvg of main and xcomps forms
        12:
          begin
            F0042C1Adjustments(doc, cx);       //sum of adjs
            F0042C2Adjustments(doc, cx);       //sum of adjs
            F0042C3Adjustments(doc, cx);       //sum of adjs
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
          CX.pg := 2;    //math is on page 3
          ProcessForm0042Math(doc, 2, CX);
          ProcessForm0042Math(doc, 5, CX);
          ProcessForm0042Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 2;    //math is on page 3
          ProcessForm0042Math(doc, 12, CX);
        end;
    end;

  result := 0;
end;

//FMAC 2070
function ProcessForm0043Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := 0;   //BroadcastLenderAddress(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FNMA BPO
function ProcessForm0166Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //Listing Calcs
        1:     //subject sqft
          cmd := DivideAB(doc, mcx(cx,63), mcx(cx,79), mcx(cx,64));     //subject price/sqft

      //Listing 1 calcs
        2:   //sales price changed
          begin
            ProcessForm0166Math(doc, 4, CX);       //calc new price/sqft
            Cmd := F0166L1Adjustments(doc, cx);     //redo the adjustments
          end;
        3:
          cmd := F0166L1Adjustments(doc, cx);       //sum of adjs
        4:
          cmd := DivideAB(doc, mcx(cx,95), mcx(cx,126), mcx(cx,96));     //price/sqft

        //Listing 2 calcs
        5:   //sales price changed
          begin
            ProcessForm0166Math(doc, 7, CX);     //calc new price/sqft
            Cmd := F0166L2Adjustments(doc, cx);   //redo the adjustments
          end;
        6:
          cmd := F0166L2Adjustments(doc, cx);     //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,159), mcx(cx,190), mcx(cx,160));     //price/sqft

        //Listings 3 calcs
        8:   //sales price changed
          begin
            ProcessForm0166Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0166L3Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0166L3Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,223), mcx(cx,254), mcx(cx,224));     //price/sqft

      //Comp Calcs
        11:     //subject sqft
          cmd := DivideAB(doc, mcx(cx,27), mcx(cx,43), mcx(cx,28));     //subject price/sqft

      //Comps 1 calcs
        12:   //sales price changed
          begin
            ProcessForm0166Math(doc, 14, CX);       //calc new price/sqft
            Cmd := F0166C1Adjustments(doc, cx);     //redo the adjustments
          end;
        13:
          cmd := F0166C1Adjustments(doc, cx);       //sum of adjs
        14:
          cmd := DivideAB(doc, mcx(cx,59), mcx(cx,90), mcx(cx,60));     //price/sqft

        //Comps 2 calcs
        15:   //sales price changed
          begin
            ProcessForm0166Math(doc, 17, CX);     //calc new price/sqft
            Cmd := F0166C2Adjustments(doc, cx);   //redo the adjustments
          end;
        16:
          cmd := F0166C2Adjustments(doc, cx);     //sum of adjs
        17:
          cmd := DivideAB(doc, mcx(cx,123), mcx(cx,154), mcx(cx,124));     //price/sqft

        //Comps 3 calcs
        18:   //sales price changed
          begin
            ProcessForm0166Math(doc, 20, CX);     //calc new price/sqft
            Cmd := F0166C3Adjustments(doc, cx);   //redo the adjustments
          end;
        19:
          cmd := F0166C3Adjustments(doc, cx);     //sum of adjs
        20:
          cmd := DivideAB(doc, mcx(cx,187), mcx(cx,218), mcx(cx,188));     //price/sqft
        21:
          cmd := CalcWeightedAvg(doc, [21]);   //calc wtAvg of main and xcomps forms
        22:
          begin
            F0166C1Adjustments(doc, cx);       //sum of adjs
            F0166C2Adjustments(doc, cx);       //sum of adjs
            F0166C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm0166Math(doc, 3, CX);
          ProcessForm0166Math(doc, 6, CX);
          ProcessForm0166Math(doc, 9, CX);
          CX.pg := 1;    //math is on page 2
          ProcessForm0166Math(doc, 13, CX);
          ProcessForm0166Math(doc, 16, CX);
          ProcessForm0166Math(doc, 19, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0166Math(doc, 22, CX);
        end;
    end;

  result := 0;
end;

//FMAC BPO Extra Listings
function ProcessForm0171Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS', 'ADDENDUM',41,86,131, 2);
        2:
          cmd := SetXXXPageTitlebarName(doc, cx, 'Extra Listing', 41,86,131);
        3:
          cmd := ConfigXXXInstance(doc, cx, 41,86,131);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FMAC BPO Extra Comps
function ProcessForm0172Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',45,98,151, 2);   //###
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 45,98,151);
        3:                                            
          cmd := ConfigXXXInstance(doc, cx, 45,98,151);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//FMAC BPO Extra Closed Sales
function ProcessForm0173Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA CLOSED SALES', 'ADDENDUM',45,98,151, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Sales', 45,98,151);
        3:
          cmd := ConfigXXXInstance(doc, cx, 45,98,151);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

{ 1025 Small Income Property Listing }
function ProcessForm0869Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if (Cmd <> 0) then
    begin
      repeat
        case Cmd of
          1:  // page title bar
            Cmd := SetXXXPageTitleBarName(doc, CX, 'Listings', 53, 127, 201);
          2:  // page title
              Cmd := SetXXXPageTitle(doc, CX, 'LISTINGS', '', 53, 127, 201, 2);
          3:  // column headers
            Cmd := ConfigXXXInstance(doc, CX, 53, 127, 201, False);
          4:  // subject, dollars per square foot
            Cmd := DivideAB(doc, MCX(CX, 16), MCX(CX, 39), MCX(CX, 17));
          5:  // listing 1, dollars per square foot
            Cmd := DivideAB(doc, MCX(CX, 57), MCX(CX, 101), MCX(CX, 58));
          6:  // listing 2, dollars per square foot
            Cmd := DivideAB(doc, MCX(CX, 131), MCX(CX, 175), MCX(CX, 132));
          7:  // listing 3, dollars per square foot
            Cmd := DivideAB(doc, MCX(CX, 205), MCX(CX, 249), MCX(CX, 206));
          8:  // listing 1, calculate adjustments
            Cmd := F0869C1Adjustments(doc, CX);
          9:  // listing 2, calculate adjustments
            Cmd := F0869C2Adjustments(doc, CX);
          10:  // listing 3, calculate adjustments
            Cmd := F0869C3Adjustments(doc, CX);
          14:  // listing 1, dollars per square foot & calculate adjustments
            Cmd := ProcessMultipleCmds(ProcessForm0869Math, doc, CX, [5, 8]);
          15:  // listing 2, dollars per square foot & calculate adjustments
            Cmd := ProcessMultipleCmds(ProcessForm0869Math, doc, CX, [6, 9]);
          16:  // listing 3, dollars per square foot & calculate adjustments
            Cmd := ProcessMultipleCmds(ProcessForm0869Math, doc, CX, [7, 10]);
          17:  // calculate weighted average
            Cmd := CalcWeightedAvg(doc, [869]);
          WeightedAvergeID:  // CalcWeightedAvg callback
            begin
              CX.Pg := 0;
              F0869C1Adjustments(doc, cx);
              F0869C2Adjustments(doc, cx);
              F0869C3Adjustments(doc, cx);
              Cmd := 0;
            end;
          UpdateNetGrossID:  // toolbox conversion
            begin
              CX.Pg := 0;
              F0869C1Adjustments(doc, cx);
              F0869C2Adjustments(doc, cx);
              F0869C3Adjustments(doc, cx);
              Cmd := 0;
            end;
        else
          Cmd := 0;
        end;
      until (Cmd = 0);
    end;

  Result := 0;
end;

{ 1073A Analysis of Annual Income and Expenses - Operating Budget }
function ProcessForm0892Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  MonthsInYear = 12;
begin
  if (Cmd > 0) then
    begin
      repeat
        case Cmd of
          1:  // total expenses
            Cmd := SumCellArray(doc, CX, [14, 15, 17, 19, 20, 22, 23, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 45, 49, 50, 51, 52, 53, 55], 56);
          2:  // utilities
            Cmd := SumCellArray(doc, CX, [24, 25, 26], 27);
          3:  // other expenses
            Cmd := SumCellArray(doc, CX, [46, 47, 48], 49);
          4:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 59), MCX(CX, 60), MCX(CX, 61));
          5:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 63), MCX(CX, 64), MCX(CX, 65));
          6:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 67), MCX(CX, 68), MCX(CX, 69));
          7:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 71), MCX(CX, 72), MCX(CX, 73));
          8:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 75), MCX(CX, 76), MCX(CX, 77));
          9:  // replacement reserve
            Cmd := DivideAB(doc, MCX(CX, 79), MCX(CX, 80), MCX(CX, 81));
          10:  // total replacement reserves
            Cmd := SumCellArray(doc, CX, [61, 65, 69, 73, 77, 81], 82);
          11:  // total annual expenses and replacement reserves
            Cmd := SumCellArray(doc, CX, [56, 57, 82], 83);
          12:  // project annual income
            Cmd := SumCellArray(doc, CX, [84, 85], 86);
          13:  // calculate annual condo charges
            Cmd := MultABByVal(doc, MCPX(CX, 2, 6), MCPX(CX, 2, 7), MCPX(CX, 1, 84), MonthsInYear);
          14:  // calculate annual condo charges
            Cmd := MultABByVal(doc, MCPX(CX, 2, 6), MCPX(CX, 2, 7), MCPX(CX, 2, 8), MonthsInYear);
          15:  // condo charges
            Cmd := ProcessMultipleCmds(ProcessForm0892Math, doc, CX, [13, 14]);
          16:  // total income
            Cmd := SumCellArray(doc, CX, [8, 10], 11);
          17:  // utilities
            Cmd := SumCellArray(doc, CX, [22, 23, 24], 25);
          18:  // total expenses
            Cmd := SumCellArray(doc, CX, [12, 13, 15, 17, 18, 20, 21, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 44, 46, 47, 48, 49, 50, 51, 52, 54], 55);
          19:  // total annual net surplus
            Cmd := SubtAB(doc, MCX(CX, 11), MCX(CX, 55), MCX(CX, 56));
        else
          Cmd := 0;
        end;
      until (Cmd = 0);
    end;

  Result := 0;
end;

//FNMA 1073 Listing
function ProcessForm0888Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Listing', 53,122,191);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'LISTING','', 53,122,191, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 53,122,191,False);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,18), mcx(cx,39), mcx(cx,19));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0888Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F0888C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0888C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,59), mcx(cx,96), mcx(cx,60));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm0888Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0888C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0888C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,128), mcx(cx,165), mcx(cx,129));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm0888Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F0888C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0888C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,197), mcx(cx,234), mcx(cx,198));     //price/sqft

        14:
          cmd := CalcWeightedAvg(doc, [345,347,888, 735, 760, 367]);   //Ticket #1400, needs to include form #367.  calc wtAvg of main and xcomps forms
        15:
          begin
            F0888C1Adjustments(doc, cx);
            F0888C2Adjustments(doc, cx);     //sum of adjs
            F0888C3Adjustments(doc, cx);
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
          ProcessForm0888Math(doc, 6, CX);
          ProcessForm0888Math(doc, 9, CX);
          ProcessForm0888Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0888Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;


end.
