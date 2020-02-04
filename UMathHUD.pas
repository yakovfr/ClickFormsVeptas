unit UMathHUD;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  HUD889    = 99;

  function ProcessForm00XXMath(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;



implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

(*
//HUD 889 something
	var
		VCRowDesc: Handle;
		VCSummary: Handle;

	procedure InitFormSpecificVars;
	begin
		{do not have form specific vars}
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



	procedure LoadVCRsrc (N: integer);
	begin
	end;

	function VCTextTransfer (WPtr: WindowPtr): Integer;
	begin
		if IsChecked(WPtr, mc(2, 2)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 3)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 4)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 5)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 6)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 7)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 8)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 9)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 10)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 11)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 12)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 13)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 14)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 16)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 18)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 20)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 22)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 24)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 26)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 30)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(2, 32)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 2)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 4)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 6)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 10)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 12)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 14)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 16)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 18)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 20)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 22)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 24)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 26)) then
			LoadVCRsrc(1);
		if IsChecked(WPtr, mc(3, 28)) then
			LoadVCRsrc(1);

		VCTextTransfer := 0;
	end;

	procedure ProcessCurCellInfo (WPtr: WindowPtr; Cmd: Integer);
	begin
		CurWPtr := WPtr;
		if Cmd > 0 then
			repeat
				case Cmd of
					1: 
						begin
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

function ProcessForm00XXMath(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

end.
