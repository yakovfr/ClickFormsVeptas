unit UMath;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses
 UGlobals, UContainer, UCell, DateUtils;

type
  TMathProc = function(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

function ProcessMultipleCmds(Processor: TMathProc; doc: TContainer; CX: CellUID; const Cmds: array of Integer): Integer;

function MC(formID, pageIdx, cellIdx: Integer): CellUID;
function MCX(cx: CellUID; cellIdx: Integer): CellUID;
function MCPX(cx: CellUID; pageIdx, cellIdx: Integer): CellUID;
function MCFX(formIdx, pageIdx, cellIdx: Integer): CellUID;
function GetCellString(doc: TContainer; CellA: CellUID): string;
function GetCellValue(doc: TContainer; CellA: CellUID): Double;
function GetCellDate(doc: TContainer; CellA: CellUID): TDateTime;
function GetCellID(doc: TContainer; CellA: CellUID): Integer;
function GetCellMathID(doc: Tcontainer; CellA: CellUID): Integer;
function CellHasData(doc: TContainer; CellA: CellUID): Boolean;
function CellHasWord(doc: TContainer; CellA: CellUID; Word: String): Boolean;
function CellIsChecked(doc: TContainer; cellA: CellUID): Boolean;
function CellIsNonZero(doc: TContainer; CellA: CellUID): Boolean;

function Result2CellIndex(S: string; doc: TContainer; formIdx, pageIdx, cellIdx: Integer): Integer;

//use this call when inserting into report
procedure SetCellData(doc: TContainer; CellA: CellUID; S: string);
procedure SetCellDataNM(doc: TContainer; CellA: CellUID; S: String); //(NM) Replication, but no Math
procedure SetCellDataNP(doc: TContainer; CellA: CellUID; S: string); //(NP) No Processing

//use these calls in context of math, replication etc.
function SetCellString(doc: TContainer; CellA: CellUID; S: string): Integer;
procedure SetAreaUADData(doc: TContainer; CellA: CellUID; S: string);
function SetCellComment(doc: TContainer; CellA: CellUID; Cmt: string): Integer;
function SetCellValue(doc: TContainer; CellA: CellUID; Value: Double): Integer;
function SetCellChkMark(doc: TContainer; CellA: CellUID; Chk: Boolean): Integer;
function SetCellDate(doc: TContainer; CellA: CellUID; ADate: TDateTime): Integer;
function ClearCheckMark(doc: TContainer; CellA: CellUID): Integer;
function EraseCell(doc: TContainer; CellA: CellUID): Integer;

function SetInfoCellString(doc: TContainer; CellA: CellUID; S: string): Integer;
function SetInfoCellValue(doc: TContainer; CellA: CellUID; Value: Double): Integer;

//for setting dynamic titles & page name & pre-configuring Xcomp pages
function SetPageTitleBarName(doc: TContainer; CX: CellUID): Integer;
function SetXXXPageTitle(doc: TContainer; CX: CellUID; const T1, T2: string; C1, C2, C3, R1: Integer): Integer;
function SetXXXPageTitleBarName(doc: TContainer; CX: CellUID; const Name: string; C1, C2, C3: Integer): Integer;
function ConfigXXXInstance(doc: TContainer; CX: CellUID; C1, C2, C3: Integer; BaseFormHasComps: Boolean = True): Integer;
function ConfigPhotoXXXInstance(doc: TContainer; CX: CellUID; C1, C2, C3: Integer): Integer;

function DoCommand(doc: TContainer; FormID, Cmd: Integer; Cell: TBaseCell): Integer;
//  function DoCellCommand(doc: TConatiner; Cell: TBaseCell): Integer;
//	function Result2Cell(doc TContainer; CellA: CellUID; S: String): Integer;

function TransA2B(doc: TContainer; CellA, CellB: CellUID): Integer;
function TransA2FormB(doc: TContainer; CellA, CellB: CellUID): Integer;
function TransA2FormBC(doc: TContainer; CellA, CellB, CellC: CellUID): Integer;
function TransVal2FormB(doc: TContainer; Value: Double; CellB: CellUID): Integer;
function MultAB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
function MultABC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
function MultAByVal(doc: TContainer; CellA, CellR: CellUID; MultVal: Double): Integer;
function MultABByVal(doc: TContainer; CellA, CellB, CellR: CellUID; MultVal: Double): Integer;
function MultAByOptionalB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
function MultABDivC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
function MultABDivVal(doc: TContainer; CellA, CellB, CellR: CellUID; Val: Double; RoundIt: Boolean): Integer;
function MultPercentAB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
function DivideAB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
function DivideAByBC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
function DivideAByVal(doc: TContainer; CellA, CellR: CellUID; Value: Double): Integer;
function DivideABPercent(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
function PercentAOfB(doc: Tcontainer; CellA, CellB, CellR: CellUID): Integer;
function SubtAB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
function SubtABDivCPercent(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
function SubtABCD(doc: TContainer; CellA, CellB, CellC, CellD, cellR: CellUID): Integer;
function SumAB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
function SumABC(doc: TContainer; CellA, CellB, CellC, cellR: CellUID): Integer;
function RoundUpA(doc: TContainer; CellA, CellR: CellUID; RndVal: Double): Integer;
function RoundByVal(doc: TContainer; CellA, CellR: CellUID; RndVal: Double): Integer;
function RoundTo(const value: double; const decimals: integer): double;
function PickValueAOrB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;

//these are absolute calls, DO NOT USE (eventually convert & remove)
function SumFourCells(doc: TContainer; F, P, C1, C2, C3, C4, CR: Integer): Integer;
function SumFiveCells(doc: TContainer; F, P, C1, C2, C3, C4, C5, CR: Integer): Integer;
function SumEightCells(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, CR: Integer): Integer;
function SumTenCells(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer;
function SumTenDup(doc: TContainer; F1, F2, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer;
function SumTwentyCells(doc: TContainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, CR: Integer): Integer;

function Get4CellSum(doc: Tcontainer; F, P, C1, C2, C3, C4: Integer): Double;
function Get10CellSum(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10: Integer): Double;

//these are relative routines (use these)
function Get4CellSumR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4: Integer): Double;
function Get8CellSumR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8: Integer): Double;
function Get10CellSumR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10: Integer): Double;
function SumFourCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, CR: Integer): Integer;
function SumSixCellsR(doc: TContainer; CX: CEllUID; C1, C2, C3, C4, C5, C6, CR: Integer): Integer;
function SumEightCellsR(doc: TContainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, CR: Integer): Integer; //relative
function SumTenCellsR(doc: TContainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer; //relative
function Sum12CellsR(doc: TContainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, CR: Integer): Integer; //relative

function AvgFourCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, CR: Integer): Integer;
function AvgFiveCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, CR: Integer): Integer;
function AvgCellsR(doc: Tcontainer; CX: CellUID; C: array of Integer; CR: Integer): Integer;

function SiteDimension(doc: TContainer; CellA, CellR: CellUID): Integer;
function YearToAge(doc: TContainer; CellA, CellR: CellUID; Processor: TMathProc): Integer;
//added by Pam: 0/11/2016 for github #179
function YearToAge2(doc: TContainer; CellA, CellR: CellUID; Processor: TMathProc): Integer;
function BroadcastLenderAddress(doc: TContainer; CellA: CellUID): Integer;
procedure GetNetGrosAdjs(doc: TContainer; CellA: CellUID; var Net, Gross: Double);
function GetCompIDStr(doc: TContainer; var CX: CellUID; U1, U2, U3: Integer): string;
function CalcWeightedAvg(doc: TContainer; const AssocFIDs: array of Integer): Integer;

//New Base math functions with dynamic cell lists
function GetArraySum(doc: TContainer; CX: CellUID; const CellIDs: array of Integer): Double;
function SumGLAArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer; CR, SqM, SqF: Integer): Integer;
function SumCellArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer; CR: Integer): Integer;
function FactorSumCellArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer; CR: Integer; const CellFactors: array of Real): Integer;
function DivideAB_R(doc: TContainer; CX: CellUID; NumeratorID, DenominatorID, CR: Integer): Integer;
function RoundByValR(doc: TContainer; CX: CellUID; C1, CR: Integer; RndVal: Double): Integer;


//New Base math functions with dynamic cell lists
function AddCells(ADoc: TContainer; ATemplateCellUID: CellUID; const AddCellIDs, SubtractCellIDs: array of Integer): Double; overload;
function AddCells(ADoc: TContainer; ATemplateCellUID: CellUID; const AddCellIDs: array of Integer): Double; overload;
function AddAndSubtractAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const AddCellIDs, SubtractCellIDs: array of Integer): Integer;
function AddAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const AddCellIDs: array of Integer): Integer;

function MultiplyCells(ADoc: TContainer; ATemplateCellUID: CellUID; const CellIDs: array of Integer): Double; overload;
function MultiplyAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const CellIDs: array of Integer): Integer; overload;

function GetPercentAndStoreCell(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID, PrincipalID, PercentCellID: Integer): Integer;
function DeductLossAndStoreCell(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID, IncomeCellID, LossPercentCellID: Integer): Integer;



function SalesGridAdjustment(doc: TContainer; CX: CellUID; SalesAmtID,
          TotalAdjID, FinalAmtID, PosChkID, NegChkID, NetInfoID, GrossInfoID: Integer;
          const AdjCIDs: array of Integer; hasAddress: Boolean = true): Integer;


function LandUseSum(doc: TContainer; CX: CellUID; InfoID: Integer;
          const CIDs: Array of Integer): Integer;

//github #78 :  include forecast values
function SalesGridAdjustmentWithForecast(doc: TContainer; CX: CellUID; SalesAmtID,
  TotalAdjID, FinalAmtID, PosChkID, NegChkID, NetInfoID, GrossInfoID: Integer; const curForecastID,
  forecastID1, forecastID2, forecastID3: Integer; const AdjCIDs: array of Integer;
  cAddr1, cAddr2, cAddr3:Integer): Integer;
          

var
 SumOfWeightedValues: Double;                 //for doing weighted avg over may forms
 SumOfWeights: Double;

implementation

uses
 Math, SysUtils,
 UUtil1, UUtil2, UEditor, UMathMgr, UInfoCell, UPage, UAppraisalIDs;


function ProcessMultipleCmds(Processor: TMathProc; doc: TContainer; CX: CellUID; const Cmds: array of Integer): Integer;
var
  len,i: Integer;
begin
  len := length(Cmds);
  if (len > 0) and assigned(Processor) then
    for i := 0 to len -1 do
      Processor(doc, Cmds[i], CX);

  result := 0;
end;



//goes to first form with ID = formID

function MC(formID, pageIdx, cellIdx: Integer): CellUID;
begin
 result.num := cellIdx - 1;                    //zero based, but humans start at 1
 result.pg := pageIdx - 1;                     //zero based...
 result.form := -1;                            //-1 so we don't use index. Use UID instead
 result.occur := 0;                            // zero based, get the first one
 result.formID := formID;                      //form ID
end;

//use a predefined CUID, but increment the cell index

function MCX(cx: CellUID; cellIdx: Integer): CellUID;
begin
 result := cx;
 result.num := cellIdx - 1;                    //zero based, but humans start at 1
 //	result.pg := cx.pg;
 //  result.Occur := cx.Occur;
 //	result.form := cx.form;
 //	result.formID := cx.formID;         //### should this be zero???
end;

//id cell on same form, but different page

function MCPX(cx: CellUID; pageIdx, cellIdx: Integer): CellUID;
begin
 result := cx;
 result.num := cellIdx - 1;                    //zero based, but humans start at 1
 result.pg := pageIdx - 1;                     //zero based...
end;

function MCFX(formIdx, pageIdx, cellIdx: Integer): CellUID;
begin
 result.num := cellIdx - 1;                    //zero based, but humans start at 1
 result.pg := pageIdx - 1;                     //zero based...
 result.Occur := 0;
 result.form := formIdx;                       //zero based set at run time
 result.formID := 0;
end;

function GetCellString(doc: TContainer; CellA: CellUID): string;
var
 theCell: TBaseCell;
begin
 result := '';
 if doc.GetValidCell(CellA, theCell) then
   result := theCell.GetText;
end;

function GetCellValue(doc: TContainer; CellA: CellUID): Double;
var
 theCell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, theCell) then
   result := theCell.GetRealValue;
end;

function GetCellDate(doc: TContainer; CellA: CellUID): TDateTime;
var
 theCell: TBaseCell;
 dateStr: string;
 mo, dy, yr: Integer;
begin
 result := 0;
 if doc.GetValidCell(CellA, theCell) then
 begin
   dateStr := theCell.GetText;
   if length(dateStr) > 0 then
   begin
     if ParseDateStr(dateStr, mo, dy, yr) then
       result := EncodeDate(yr, mo, dy);
   end;
 end;
end;

function GetCellID(doc: TContainer; CellA: CellUID): Integer;
var
 theCell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, theCell) then
   result := theCell.FCellID;
end;

function GetCellMathID(doc: TContainer; CellA: CellUID): Integer;
var
 theCell: TBaseCell;
begin
  result := 0;
  if doc.GetValidCell(CellA, theCell) then
    result := theCell.GetMathCmd;
end;

function CellHasData(doc: TContainer; CellA: CellUID): Boolean;
var
  theCell: TBaseCell;
begin
  result := False;
  if doc.GetValidCell(CellA, theCell) then
    result := Length(theCell.GetText) > 0;
end;

function CellHasWord(doc: TContainer; CellA: CellUID; Word: String): Boolean;
var
  theCell: TBaseCell;
begin
  result := False;
  if doc.GetValidCell(CellA, theCell) then
    result := POS(Uppercase(Word), UpperCase(theCell.GetText))> 0;
end;

function CellIsChecked(doc: TContainer; cellA: CellUID): Boolean;
var
  theCell: TBaseCell;
begin
  result := False;
  if doc.GetValidCell(CellA, theCell) then
    result := (CompareStr(theCell.GetText, 'X') = 0);
end;

function CellIsNonZero(doc: TContainer; CellA: CellUID): Boolean;
var
 theCell: TBaseCell;
begin
 result := False;
 if doc.GetValidCell(CellA, theCell) then
   result := (theCell.GetRealValue <> 0);
end;

//When posting data into a report, use this call, not SetCellString or
//SetCellValue. These last two need to be bracketed by Release Replication Lists calls
//This call does not because the brackets are in Cell.PostProcess
procedure SetCellData(doc: TContainer; CellA: CellUID; S: string);
var
  cell: TBaseCell;
begin
  if doc.GetValidCell(CellA, cell) and
    not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then
  begin
    if IsAppPrefSet(bUpperCase) then
      S := UpperCase(S);

    S := Cell.Format(S);                        //do format
    Cell.SetText(S);                            //set it
    Cell.Display;                               //display it
    Cell.PostProcess;                           //do any math
  end;
end;

//set data, but do not math, just transfers
procedure SetCellDataNM(doc: TContainer; CellA: CellUID; S: String);
var
  cell: TBaseCell;
begin
  if doc.GetValidCell(CellA, cell) and
    not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then
  begin
    if IsAppPrefSet(bUpperCase) then
      S := UpperCase(S);

    S := Cell.Format(S);                        //do format
    Cell.SetText(S);                            //set it
    Cell.Display;                               //display it

    //do replication - but no math
    doc.StartProcessLists;
    cell.ReplicateLocal(True);
    cell.ReplicateGlobal;                       //replicate it
    doc.ClearProcessLists;
  end;
end;

//set data and do nothing else
procedure SetCellDataNP(doc: TContainer; CellA: CellUID; S: string);
var
  cell: TBaseCell;
begin
  if doc.GetValidCell(CellA, cell) and
    not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then
  begin
    if IsAppPrefSet(bUpperCase) then
      S := UpperCase(S);
    S := Cell.Format(S);                        //do format
    if Cell.ClassNameIs('TChkBoxCell') then
      Cell.DoSetText(S)
    else
      Cell.SetText(S);                          //set it
    Cell.Display;                               //display it
  end;
end;

function SetCellString(doc: TContainer; CellA: CellUID; S: string): Integer;
var
  cell: TBaseCell;
begin
  result := 0;
  if doc.GetValidCell(CellA, cell) and not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then //YF 06.06.02 and Transfer allowed into the cell
  begin
    if IsAppPrefSet(bUpperCase) then
      S := UpperCase(S);
    cell.SetText(S);                            //set it
    Cell.CheckTextOverflow;
    Cell.Display;                               //display it
    cell.ReplicateLocal(True);
    cell.ReplicateGlobal;                       //replicate it

    result := Cell.GetMathCmd;                  //do any other math specific to this cell
  end;
end;

procedure SetAreaUADData(doc: TContainer; CellA: CellUID; S: string);
const
  cSqFt = 'sf';
  cAcres = 'ac';
  cAcre = 43560;
var
  cell: TBaseCell;
  AreaStr: String;
  EndIdx: Integer;
begin
  if doc.GetValidCell(CellA, cell) then
    begin
      Cell.GSEDataPoint['67'] := S;
      Cell.GSEDataPoint['976'] := S;
      EndIdx := 0;
//      if Pos(cAcres, S) > 0 then
      if Pos(cAcres, S) = 0 then
        begin
          AreaStr := GetFirstNumInStr(S, False, EndIdx);
          if Trim(AreaStr) <> '' then
            AreaStr := Format('%-.0n', [StrToFloat(AreaStr) * cAcre]) + ' ' + cSqFt;
        end
      else
        begin
          AreaStr := GetFirstNumInStr(S, True, EndIdx);
          if Trim(AreaStr) <> '' then
            AreaStr := Format('%-.2n', [StrToFloat(AreaStr) / cAcre]) + ' ' + cAcres;
        end;
      Cell.GSEDataPoint['67-1'] := AreaStr;
    end;
end;

function SetCellValue(doc: TContainer; CellA: CellUID; Value: Double): Integer;
var
 cell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, cell) and
   not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then //YF 06.06.02 and Transfer allowed into the cell
 begin
   cell.SetValue(Value);                       //format it and set it
   Cell.CheckTextOverflow;
   Cell.Display;                               //display it
   cell.ReplicateLocal(True);
   cell.ReplicateGlobal;                       //replicate it

   result := Cell.GetMathCmd;                  //do any other math specific to this cell
 end;
end;

//Needs the editor to format line breaks to the cell for

function SetCellComment(doc: TContainer; CellA: CellUID; Cmt: string): Integer;
var
 Cell: TBaseCell;
 MLEditor: TMLEditor;
begin
 result := 0;
 if doc.GetValidCell(CellA, cell) and not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then //YF 06.06.02 and Transfer allowed into the cell
   if Cell.FIsActive and (Cell.Editor <> nil) and (Cell.Editor is TTextEditor) then
   begin
     (CEll.Editor as TTextEditor).Text := Cmt;
   end
    else begin
     MLEditor := TMLEditor.create(doc);
     try
       ClearLF(Cmt);                           //strip any LF chars before displaying
       ClearNULLs(Cmt);
       Cell.SetText(Cmt);                      //set it
       MLEditor.LoadCell(cell, CellA);         //does calcWrap
       MLEditor.CalcTextWrap;
       MLEditor.CheckTextOverFlow;
       MLEditor.Modified := True;
       MLEditor.SaveChanges;                   //save the text to the cell
       Cell.Display;
     finally
       if MLEditor <> nil then
         MLEditor.Free;
     end;
   end;
end;

function SetCellChkMark(doc: TContainer; CellA: CellUID; chk: Boolean): Integer;
var
 cell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, cell) and
   not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then //YF 06.06.02 and Transfer allowed into the cell
   with Cell as TChkBoxCell do
   begin
     TChkBoxCell(cell).SetCheckMark(chk);      //set checkmark
     Cell.Display;                             //display it
     cell.ReplicateLocal(True);
     cell.ReplicateGlobal;                     //replicate it

     result := Cell.GetMathCmd;                //do any other math specific to this cell
   end;
end;

//not used any more
function ClearCheckMark(doc: TContainer; CellA: CellUID): Integer;
var
 cell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, cell) and
   not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then //YF 06.06.02 and Transfer allowed into the cell
   with Cell as TChkBoxCell do
   begin
     TChkBoxCell(cell).ClearCheckMark;    //clear checkmark
     Cell.Display;                        //display it
     cell.ReplicateLocal(True);
     cell.ReplicateGlobal;                //replicate it

     result := Cell.GetMathCmd;           //do any other math specific to this cell
   end;
end;

function SetCellDate(doc: TContainer; CellA: CellUID; ADate: TDateTime): Integer;
var
 cell: TBaseCell;
begin
 result := 0;
 if (ADate <> 0) and doc.GetValidCell(CellA, cell) and
   not IsBitSetUAD(cell.FCellPref, bNoTransferInto) then
 begin
   TDateCell(Cell).SetDate(ADate);
   Cell.Display;                               //display it
   cell.ReplicateLocal(True);
   cell.ReplicateGlobal;                       //replicate it
   result := Cell.GetMathCmd;                  //do any other math specific to this cell
 end;
end;

function EraseCell(doc: TContainer; CellA: CellUID): Integer;
var
 cell: TBaseCell;
begin
 result := 0;
 if doc.GetValidCell(CellA, cell) then
 begin
   Cell.EraseCell;
   cell.ReplicateLocal(True);
   cell.ReplicateGlobal;                       //replicate it
   result := Cell.GetMathCmd;                  //do any other math specific to this cell
 end;
end;

function SetInfoCellString(doc: TContainer; CellA: CellUID; S: string): Integer;
var
 ICell: TInfoCell;
begin
 if doc.GetValidInfoCell(CellA, TObject(ICell)) then
 begin
   ICell.Text := S;
   ICell.Display;
 end;
 result := 0;
end;

function SetInfoCellValue(doc: TContainer; CellA: CellUID; Value: Double): Integer;
var
 ICell: TInfoCell;
begin
 if doc.GetValidInfoCell(CellA, TObject(ICell)) then
 begin
   ICell.Value := Value;
   ICell.Display;
 end;
 result := 0;
end;

function SetXXXPageTitle(doc: TContainer; CX: CellUID; const T1, T2: string; C1, C2, C3, R1: Integer): Integer;
var
 CT, CS: string;
begin
 CT := GetCompIDStr(doc, cx, C1, C2, C3);
 CS := T1 + ' ' + CT;
 cx := mcx(cx, R1);
 result := SetCellString(doc, cx, CS);
end;

function SetPageTitleBarName(doc: TContainer; CX: CellUID): Integer;
var
 Cell: TBaseCell;
begin
 Cell := doc.GetCell(cx);
 if assigned(cell) then
 begin
   if Trim(Cell.GetText) <> '' then
     TDocPage(Cell.ParentDataPage).PgTitleName := Cell.GetText;
   Cell.ParentViewPage.PgTitle.Redraw;
 end;
 result := 0;
end;

function SetXXXPageTitleBarName(doc: TContainer; CX: CellUID; const Name: string; C1, C2, C3: Integer): Integer;
var
 CS: string;
 Cell: TBaseCell;
begin
 CS := GetCompIDStr(doc, cx, C1, C2, C3);
 if length(CS) = 0 then
   CS := Name + ' Undefined'
 else
   CS := Name + ' ' + CS;
 cell := doc.GetCell(cx);
 TDocPage(Cell.ParentDataPage).PgTitleName := CS;
 Cell.ParentViewPage.PgTitle.Redraw;
 result := 0;
end;

//called by UFormConfig

function ConfigXXXInstance(doc: TContainer; CX: CellUID; C1, C2, C3: Integer; BaseFormHasComps: Boolean): Integer;
var
 N: Integer;
begin
 if BaseFormHasComps then
  N := (CX.Occur + 1) * 3 + 1
 else
  N := CX.Occur * 3 + 1;
 SetCellData(doc, mcx(cx, C1), IntToStr(N));
 SetCellData(doc, mcx(cx, C2), IntToStr(N + 1));
 SetCellData(doc, mcx(cx, C3), IntToStr(N + 2));
 result := 0;
end;

function ConfigPhotoXXXInstance(doc: TContainer; CX: CellUID; C1, C2, C3: Integer): Integer;
var
 N: Integer;
begin
 N := CX.Occur * 3 + 1;
 SetCellData(doc, mcx(cx, C1), IntToStr(N));
 SetCellData(doc, mcx(cx, C2), IntToStr(N + 1));
 SetCellData(doc, mcx(cx, C3), IntToStr(N + 2));
 result := 0;
end;

function DoCommand(doc: TContainer; FormID, Cmd: Integer; Cell: TBaseCell): Integer;
begin
 ProcessCurCellMath(doc, FormID, Cmd, Cell);
 result := 0;
end;

function TransA2B(doc: TContainer; CellA, CellB: CellUID): Integer;
begin
 result := SetCellString(doc, CellB, GetCellString(doc, CellA));
end;

function TransA2FormB(doc: TContainer; CellA, CellB: CellUID): Integer;
var
 cmd: Integer;
 BCell: TBaseCell;
begin
 cmd := SetCellString(doc, CellB, GetCellString(doc, CellA));

 if (Cmd > 0) and (CellA.formID <> cellB.formID) then //if transfer to different form
 begin
   BCell := doc.GetCell(CellB);
   ProcessCurCellMath(doc, cellB.formID, Cmd, BCell);
 end;
 result := 0;
end;

function TransA2FormBC(doc: TContainer; CellA, CellB, CellC: CellUID): Integer;
var
 cmd: Integer;
 BCell, CCell: TBaseCell;
begin
 cmd := SetCellString(doc, CellB, GetCellString(doc, CellA)); //cmd from B
 if (Cmd > 0) and (CellA.formID <> cellB.formID) then //if transfer to different form
 begin
   BCell := doc.GetCell(CellB);
   ProcessCurCellMath(doc, cellB.formID, Cmd, BCell);
 end;

 cmd := SetCellString(doc, CellC, GetCellString(doc, CellA)); //cmd from c
 if (Cmd > 0) and (CellA.formID <> cellC.formID) then //if transfer to different form
 begin
   CCell := doc.GetCell(CellC);
   ProcessCurCellMath(doc, cellC.formID, Cmd, CCell);
 end;

 result := 0;
end;

function TransVal2FormB(doc: TContainer; Value: Double; CellB: CellUID): Integer;
var
 cmd: Integer;
 BCell: TBaseCell;
begin
 cmd := SetCellValue(doc, CellB, Value);       //cmd from B
 if (Cmd > 0) then                             //if transfer to different form
 begin
   BCell := doc.GetCell(CellB);
   ProcessCurCellMath(doc, cellB.formID, Cmd, BCell);
 end;
 result := 0;
end;

function MultAB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 result := 0;
 if CellHasData(doc, CellA) and CellHasData(doc, CellB) then
 begin
   V1 := GetCellValue(doc, CellA);
   V2 := GetCellValue(doc, CellB);
   VR := V1 * V2;
   result := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(doc, CellR, VR);
 end;
end;

function MultABC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
var
 V1, V2, V3, VR: Double;
begin
 result := 0;
 if CellHasData(doc, CellA) and CellHasData(doc, CellB) and CellHasData(doc, CellC) then
 begin
   V1 := GetCellValue(doc, CellA);
   V2 := GetCellValue(doc, CellB);
   V3 := GetCellValue(doc, CellC);
   VR := V1 * V2 * V3;
   result := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(doc, CellR, VR);
 end;
end;

function MultAByVal(doc: TContainer; CellA, CellR: CellUID; MultVal: Double): Integer;
var
 V1: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V1 := V1 * MultVal;
 result := SetCellValue(doc, CellR, V1);
end;

function MultABByVal(doc: TContainer; CellA, CellB, CellR: CellUID; MultVal: Double): Integer;
var
  V1, V2, VR: Double;
begin
  V1 := GetCellValue(doc, CellA);
  V2 := GetCellValue(doc, CellB);
  VR := V1 * V2 * MultVal;
  result := SetCellValue(doc, CellR, VR);
end;

function MultAByOptionalB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
  V1, V2, VR: Double;
begin
  V1 := GetCellValue(doc, CellA);
  V2 := GetCellValue(doc, CellB);
  if V2 = 0 then V2 := 1.0;
  VR := V1 * V2;
  result := SetCellValue(doc, CellR, VR);
end;

function MultABDivC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
var
 V1, V2, V3, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 VR := 0;
 if V3 <> 0 then
   VR := (V1 * V2) / V3;
 result := SetCellValue(doc, CellR, VR);
end;

function MultABDivVal(doc: TContainer; CellA, CellB, CellR: CellUID; Val: Double; RoundIt: Boolean): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 VR := 0;
 if Val <> 0 then
   if RoundIt then
     VR := V1 * Round(V2 / Val)
   else
     VR := (V1 * V2) / Val;
 result := SetCellValue(doc, CellR, VR);
end;

function MultPercentAB(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 VR := (V1 * V2) / 100;
 result := SetCellValue(doc, CellR, VR);
end;

function PercentAOfB(doc: Tcontainer; CellA, CellB, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
 cmd: Integer;
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

function DivideAB(doc: Tcontainer; CellA, CellB, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 result := 0;
 if V2 <> 0 then
 begin
   VR := (V1 / V2);
   result := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(doc, CellR, VR);
 end;
end;

function DivideAByBC(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB) * GetCellValue(doc, CellC);
 result := 0;
 if V2 <> 0 then
 begin
   VR := V1 / V2;
   result := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(doc, CellR, VR);
 end;
end;

function DivideAByVal(doc: TContainer; CellA, CellR: CellUID; Value: Double): Integer;
var
 V1, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 result := 0;
 if value <> 0 then
 begin
   VR := V1 / value;
   result := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   result := SetCellValue(doc, CellR, VR);
 end;
end;

function DivideABPercent(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
 V1, V2, VR: Double;
 cmd: Integer;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 cmd := 0;
 if V2 <> 0 then
 begin
   VR := (V1 / (V2 / 100));
   cmd := SetCellValue(doc, CellR, VR);
 end
 else if CellHasData(doc, CellR) then
 begin
   VR := 0.0;
   cmd := SetCellValue(doc, CellR, VR);
 end;
 result := cmd;
end;
(*
function DivideAByPercent(doc: TContainer; CellA, CellB, CellR:CellUID): Integer;
var
V1, V2, VR: Double;
cmd: Integer;
begin
V1 := GetCellValue(doc, CellA);
V2 := GetCellValue(doc, CellB);
cmd := 0;
if V2 > 0 then
 begin
  VR := (V1 / (V2 / 100));
  cmd := SetCellValue(doc, CellR, VR);
 end;
result := cmd;
end;
*)

function Get4CellSum(doc: Tcontainer; F, P, C1, C2, C3, C4: Integer): Double;
var
 V1, V2, V3, V4: Double;
begin
 V1 := 0;
 V2 := 0;
 V3 := 0;
 V4 := 0;
 if C1 > 0 then
   V1 := GetCellValue(doc, MC(F, P, C1));
 if C2 > 0 then
   V2 := GetCellValue(doc, MC(F, P, C2));
 if C3 > 0 then
   V3 := GetCellValue(doc, MC(F, P, C3));
 if C4 > 0 then
   V4 := GetCellValue(doc, MC(F, P, C4));
 result := V1 + V2 + V3 + V4;
end;

function Get4CellSumR(doc: Tcontainer; cx: CellUID; C1, C2, C3, C4: Integer): Double;
var
 V1, V2, V3, V4: Double;
begin
 V1 := 0;
 V2 := 0;
 V3 := 0;
 V4 := 0;
 if C1 > 0 then
   V1 := GetCellValue(doc, MCX(cx, C1));
 if C2 > 0 then
   V2 := GetCellValue(doc, MCX(cx, C2));
 if C3 > 0 then
   V3 := GetCellValue(doc, MCX(cx, C3));
 if C4 > 0 then
   V4 := GetCellValue(doc, MCX(cx, C4));
 result := V1 + V2 + V3 + V4;
end;

function Get8CellSumR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8: Integer): Double;
begin
 result := Get4CellSumR(doc, cx, C1, C2, C3, C4) + Get4CellSumR(doc, cx, C5, C6, C7, C8);
end;

function Get10CellSumR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10: Integer): Double;
begin
 result := Get8CellSumR(doc, cx, C1, C2, C3, C4, C5, C6, C7, C8) + Get4CellSumR(doc, cx, C9, C10, 0, 0);
end;

function Get10CellSum(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10: Integer): Double;
var
 V1, V2, V3, V4, V5, V6, V7, V8, V9, V10: Double;
begin
 V1 := 0;
 V2 := 0;
 V3 := 0;
 V4 := 0;
 V5 := 0;
 V6 := 0;
 V7 := 0;
 V8 := 0;
 V9 := 0;
 V10 := 0;
 if C1 > 0 then
   V1 := GetCellValue(doc, MC(F, P, C1));
 if C2 > 0 then
   V2 := GetCellValue(doc, MC(F, P, C2));
 if C3 > 0 then
   V3 := GetCellValue(doc, MC(F, P, C3));
 if C4 > 0 then
   V4 := GetCellValue(doc, MC(F, P, C4));
 if C5 > 0 then
   V5 := GetCellValue(doc, MC(F, P, C5));
 if C6 > 0 then
   V6 := GetCellValue(doc, MC(F, P, C6));
 if C7 > 0 then
   V7 := GetCellValue(doc, MC(F, P, C7));
 if C8 > 0 then
   V8 := GetCellValue(doc, MC(F, P, C8));
 if C9 > 0 then
   V9 := GetCellValue(doc, MC(F, P, C9));
 if C10 > 0 then
   V10 := GetCellValue(doc, MC(F, P, C10));
 result := V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9 + V10;
end;

function SubtAB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 VR := V1 - V2;
 result := SetCellValue(doc, cellR, VR);
end;

function SubtABDivCPercent(doc: TContainer; CellA, CellB, CellC, CellR: CellUID): Integer;
var
 V1, V2, V3, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 VR := 0;
 if V3 <> 0 then
   VR := ((V1 - V2) / V3) * 100;
 result := SetCellValue(doc, cellR, VR);
end;

function SubtABCD(doc: TContainer; CellA, CellB, CellC, CellD, cellR: CellUID): Integer;    //for the income approach
var
 V1, V2, V3, V4, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 V4 := GetCellValue(doc, CellD);
 VR := V1 - V2 -V3 - V4;
 result := SetCellValue(doc, cellR, VR);
end;

function SumAB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 VR := V1 + V2;
 result := SetCellValue(doc, cellR, VR);
end;

function SumABC(doc: TContainer; CellA, CellB, CellC, cellR: CellUID): Integer;
var
 V1, V2, V3, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 V3 := GetCellValue(doc, CellC);
 VR := V1 + V2 + V3;
 result := SetCellValue(doc, cellR, VR);
end;

function RoundUpA(doc: TContainer; CellA, CellR: CellUID; RndVal: Double): Integer;
var
 V1, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 VR := RoundUp(V1, rndVal);
 result := SetCellValue(doc, cellR, VR);
end;

function RoundByVal(doc: TContainer; CellA, CellR: CellUID; RndVal: Double): Integer;
var
 V1, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 VR := RoundVal(V1, rndVal);
 result := SetCellValue(doc, cellR, VR);
end;

function RoundTo(const value: double; const decimals: integer): double;
var
  multiplier: integer;
  number: double;
  whole: integer;
begin
  multiplier := Trunc(Power(10, decimals));
  number := value * multiplier;
  whole := Trunc(number);

  if (number - whole >= 0.5) then
    number := whole + 1
  else
    number := whole;

  result := number / multiplier;
end;

function PickValueAOrB(doc: TContainer; CellA, CellB, cellR: CellUID): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := GetCellValue(doc, CellA);
 V2 := GetCellValue(doc, CellB);
 VR := 0;
 if V1 <> 0 then
   VR := V1
 else if V2 <> 0 then
   VR := V2;
 result := SetCellValue(doc, cellR, VR);
end;

function SumFourCells(doc: TContainer; F, P, C1, C2, C3, C4, CR: Integer): Integer;
var
 VR: Double;
begin
 VR := Get4CellSum(doc, F, P, C1, C2, C3, C4);
 result := SetCellValue(doc, mc(f, p, CR), VR);
end;

function SumFiveCells(doc: TContainer; F, P, C1, C2, C3, C4, C5, CR: Integer): Integer;
var
 V1, VR: Double;
begin
 V1 := Get4CellSum(doc, F, P, C1, C2, C3, C4);
 VR := V1 + GetCellValue(doc, mc(F, P, C5));
 result := SetCellValue(doc, mc(f, p, CR), VR);
end;

function SumEightCells(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, CR: Integer): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := Get4CellSum(doc, F, P, C1, C2, C3, C4);
 V2 := Get4CellSum(doc, F, P, C5, C6, C7, C8);
 VR := V1 + V2;
 result := SetCellValue(doc, MC(F, P, CR), VR);
end;

function SumFourCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, CR: Integer): Integer;
var
 VR: Double;
begin
 VR := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function SumSixCellsR(doc: TContainer; CX: CEllUID; C1, C2, C3, C4, C5, C6, CR: Integer): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 V2 := Get4CellSumR(doc, cx, C5, C6, 0, 0);
 VR := V1 + V2;
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function SumEightCellsR(doc: TContainer; cx: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, CR: Integer): Integer;
var
 V1, V2, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 V2 := Get4CellSumR(doc, cx, C5, C6, C7, C8);
 VR := V1 + V2;
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function SumTenCellsR(doc: TContainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer; //relative
var
 V1, V2, V3, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 V2 := Get4CellSumR(doc, cx, C5, C6, C7, C8);
 V3 := Get4CellSumR(doc, cx, C9, C10, 0, 0);
 VR := V1 + V2 + V3;
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function Sum12CellsR(doc: TContainer; CX: CellUID; C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, CR: Integer): Integer; //relative
var
 V1, V2, V3, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 V2 := Get4CellSumR(doc, cx, C5, C6, C7, C8);
 V3 := Get4CellSumR(doc, cx, C9, C10, C11, C12);
 VR := V1 + V2 + V3;
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function AvgFourCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, CR: Integer): Integer;
var
 V1, N, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4);
 N := 0;
  if CellHasData(doc, mcx(cx,C1)) then N := N+1;
  if CellHasData(doc, mcx(cx,C2)) then N := N+1;
  if CellHasData(doc, mcx(cx,C3)) then N := N+1;
  if CellHasData(doc, mcx(cx,C4)) then N := N+1;
  VR := 0;
  If N > 0 then VR := V1/N;
 result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function AvgFiveCellsR(doc: Tcontainer; CX: CellUID; C1, C2, C3, C4, C5, CR: Integer): Integer;
var
 V1, N, VR: Double;
begin
 V1 := Get4CellSumR(doc, cx, C1, C2, C3, C4) + GetCellValue(doc, mcx(cx, c5));
 N := 0;
  if CellHasData(doc, mcx(cx,C1)) then N := N+1;
  if CellHasData(doc, mcx(cx,C2)) then N := N+1;
  if CellHasData(doc, mcx(cx,C3)) then N := N+1;
  if CellHasData(doc, mcx(cx,C4)) then N := N+1;
  if CellHasData(doc, mcx(cx,C5)) then N := N+1;
  VR := 0;
  If N > 0 then VR := V1/N;
  result := SetCellValue(doc, MCX(cx, CR), VR);
end;

/// summary: Gets the average value for an array of cells.
/// remarks: Cells containing an invalid or empty value are handled as zeros.
function AvgCellsR(Doc: Tcontainer; CX: CellUID; C: array of Integer; CR: Integer): Integer;
var
  Index: Integer;
  N: Integer;
  V: Double;
  VR: Double;
begin
  V := 0;
  N := Length(C);

  for Index := 0 to N - 1 do
    V := V + GetCellValue(Doc, MCX(CX, C[Index]));

  if (N > 0) then
    VR := V / N
  else
    VR := 0;

  Result := SetCellValue(Doc, MCX(cx, CR), VR);
end;

function SumTenCells(doc: Tcontainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer;
var
 VR: Double;
begin
 VR := Get10CellSum(doc, F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10);
 result := SetCellValue(doc, MC(F, P, CR), VR);
end;

function SumTenDup(doc: TContainer; F1, F2, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CR: Integer): Integer;
var
 VR, VR1, VR2: Double;
begin
 VR1 := Get10CellSum(doc, F1, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10);
 VR2 := Get10CellSum(doc, F2, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10);
 VR := VR1 + VR2;
 result := SetCellValue(doc, MC(F1, P, CR), VR); //place in first page cell
end;

function SumTwentyCells(doc: TContainer; F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, CR: Integer): Integer;
var
 V101, V102, VR: Double;
begin
 V101 := Get10CellSum(doc, F, P, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10);
 v102 := Get10CellSum(doc, F, P, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20);
 VR := V101 + V102;
 result := SetCellValue(doc, MC(F, P, CR), VR);
end;

function TransStr(Str: string; CellA: CellUID): Integer;
begin
 //	SetCellStr(CurWPtr, CellA, Str);
 //	DisplayCellStr(CurWPtr, CellA, Str);
 //	TransStr := GetCellCmdID(CurWPtr, CellA);
 result := 0;
end;

function TransValue(CellA, CellR: CellUID): Integer;
begin
 //	CellResult := GetCellValue(CurWPtr, CellA);
 //	CellParm := GetCellParm(CurWPtr, CellR);
 //	TransValue := Result2Cell(FormatNumber(CellResult, CellParm), CellR);
 result := 0;
end;

function Result2Cell(doc: TContainer; CUID: CellUID; S: string): Integer;
var
 cell: TBaseCell;
begin
  cell := doc.GetCell(CUID);                    //get the cell
  cell.SetText(S);                              //set the text
  cell.Display;                                 //now display it

  result := 0;
end;

function Result2CellIndex(S: string; doc: TContainer; formIdx, pageIdx, cellIdx: Integer): Integer;
var
  CUID: CellUID;
begin
  CUID.formID := 0;                             //so there is no mistake
  CUID.occur := 0;
  CUID.form := formIdx;
  CUID.pg := pageIdx;
  CUID.num := cellIdx;
  result := Result2Cell(doc, CUID, S);
end;

function SiteDimension(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  tmpStr, acreStr, sqftStr: string;
  N: Integer;
  VX, VAcre: Double;
  V: array of Double;
  acreLbl, sqftLbl: string;
begin
  result := 0;
  //if doc.UADEnabled then    //let's always use ac and sf
    begin
      acreLbl := 'ac';
      sqftLbl := 'sf';
    end;
  {else
    begin
      acreLbl := 'Ac';
      sqftLbl := 'SqFt';
    end;   }
  tmpStr := GetCellString(doc, cellA);
  VAcre := 0;  AcreStr := '';
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
          if vx > 43560 then  //Ticket #1123: check to prevent NAN shows up in the result.
            begin
              VAcre := VX / 43560.0;                    //convert to acers
              if appPref_AppraiserAddSiteSuffix or doc.UADEnabled then
                AcreStr := Format('%.2n ' + acreLbl, [VAcre])
              else
                AcreStr := Format('%.2n', [VAcre]);
            end;
          if appPref_AppraiserAddSiteSuffix or doc.UADEnabled then
            sqftStr := Format('%.0n ' + sqftLbl, [VX])
          else
            sqftStr := Format('%.0n', [VX]);

          if VAcre > 1.0 then
            tmpStr := AcreStr                       //Concat(AcreStr, ' Ac')
          else
            tmpStr := sqftStr;                      //Concat(sqftStr, ' SqFt');

          if (N > 3) and (not doc.UADEnabled) then
            tmpStr := Concat('Appx: ', tmpStr);

          if doc.UADEnabled then
            begin
              tmpStr := StringReplace(tmpStr, ',', '', [rfReplaceAll]);
              SetAreaUADData(doc, CellR, tmpStr);
            end;  

          result := SetCellString(doc, CellR, tmpStr);
          V := nil;                                 //release the array
        end
      else
        result := 0;                              //no values, return no processing

      Finalize(V);                                //release dynamic array
    end;
end;

function YearToAge(doc: TContainer; CellA, CellR: CellUID; Processor: TMathProc): Integer;
var
  YrStr: String;
  Year, Age: Integer;
begin
  YrStr := GetCellString(doc, CellA);
  Year := GetValidInteger(YrStr);
  if Year > 0 then
    begin
      if appPref_AppraiserDoYear2AgeCalc then
        Age := CurrentYear - Year
      else
        Age := Year;  //no conversion!

      if (not doc.UADEnabled) and appPref_AppraiserDoYear2AgeCalc and appPref_AppraiserAddYrSuffix then
        result := SetCellString(doc, CellR, IntToStr(Age) + ' yrs')
      else
        if doc.UADEnabled and (YrStr[1] = '~') then
          result := SetCellString(doc, CellR, '~' + IntToStr(Age))
      else
        result := SetCellString(doc, CellR, IntToStr(Age));

      if assigned(Processor) then
        begin
          Processor(doc, result, CellR);
          result := 0;
        end;
    end
  else
    result := 0;
end;

//github #179: use effectice date to do the calculation if empty use current date
function YearToAge2(doc: TContainer; CellA, CellR: CellUID; Processor: TMathProc): Integer;
var
  YrStr: String;
  Year, Age: Integer;
  aYear: Integer;
  EffectiveDate: String;
begin
  EffectiveDate := TContainer(doc).GetCellTextByID(1132);
  if EffectiveDate <> '' then
    aYear := YearOf(StrToDate(EffEctiveDate))
  else
    aYear := CurrentYear;
  YrStr := GetCellString(doc, CellA);
  Year := GetValidInteger(YrStr);
  if Year > 0 then
    begin
      if appPref_AppraiserDoYear2AgeCalc then
        Age := aYear - Year
      else
        Age := Year;  //no conversion!

      if (not doc.UADEnabled) and appPref_AppraiserDoYear2AgeCalc and appPref_AppraiserAddYrSuffix then
        result := SetCellString(doc, CellR, IntToStr(Age) + ' yrs')
      else
        if doc.UADEnabled and (YrStr[1] = '~') then
          result := SetCellString(doc, CellR, '~' + IntToStr(Age))
      else
        result := SetCellString(doc, CellR, IntToStr(Age));

      if assigned(Processor) then
        begin
          Processor(doc, result, CellR);
          result := 0;
        end;
    end
  else
    result := 0;
end;


//this is not used anymore. Cell Munger handles the parse & broadcast

function BroadcastLenderAddress(doc: TContainer; CellA: CellUID): Integer;
var
 S, Address, CityStZip: string;
begin
 S := GetCellString(doc, CellA);
 Trim(S);
 ParseFullAddress(S, Address, CityStZip);
 if length(CityStZip) > 0 then                 //if we have city, parsing worked
 begin
   doc.SetMungedValue(kLenderAddress, Address);
   doc.SetMungedValue(kLenderCityStZip, CityStZip);
   doc.StartProcessLists;
   doc.BroadcastCellContext(kLenderAddress, Address);
   doc.BroadcastCellContext(kLenderCityStZip, CityStZip);
   doc.ClearProcessLists;
 end;
 result := 0;
end;

//calcs running total of net and gross
//this is used by every comp when calculating the adjustments
procedure GetNetGrosAdjs(doc: TContainer; CellA: CellUID; var Net, Gross: Double);
var
 V1: Double;
begin
 V1 := GetCellValue(doc, cellA);
 Net := Net + V1;
 Gross := Gross + abs(V1);
end;

//Generic way of concatenating comps IDs from cells
//used for creating titles such as "Sales Comps 4-5-6"
function GetCompIDStr(doc: TContainer; var CX: CellUID; U1, U2, U3: Integer): string;
var
 C1, C2, C3: string;
begin
 C1 := GetCellString(doc, mcx(cx, U1));
 C2 := GetCellString(doc, mcx(cx, U2));
 C3 := GetCellString(doc, mcx(cx, U3));
 result := SeparateStrs(C1, C2, C3, '-');
end;

function CalcWeightedAvg(doc: TContainer; const AssocFIDs: array of Integer): Integer;
var
  i, z, n, nForms: Integer;
  wtAvg: Double;
begin
  //initialize
  SumOfWeightedValues := 0;
  SumOfWeights := 0;
  nForms := length(AssocFIDs);

  //sum the weighted values
  //the math calaulates the globals SumOfWeightedValues &  SumOfWeights
  z := doc.docForm.Count - 1;
  for i := 0 to z do
    for n := 0 to nForms-1 do
      if (doc.docForm[i].FormID = AssocFIDs[n]) then
        doc.docForm[i].ProcessMathCmd(WeightedAvergeID);

  //calc the weighted average
  wtAvg := 0;
  if SumOfWeights <> 0 then
    wtAvg := SumOfWeightedValues / SumOfWeights;
    //wtAvgStr := FloatToStrF(wtAvg, ffNumber, 15, 0);

  //display the weighted average
  z := doc.docForm.Count - 1;
  for i := 0 to z do
    for n := 0 to nForms-1 do
      if (doc.docForm[i].FormID = AssocFIDs[n]) then
        doc.docForm[i].UpdateInfoCell(icAvgBox, -1, wtAvg, '' {wtAvgStr});

 result := 0;
end;

function GetArraySum(doc: TContainer; CX: CellUID; const CellIDs: array of Integer): Double;
var
 i, len: Integer;
begin
  Result := 0.0;
  len := length(CellIDs);
  if len > 0 then
    for i := 0 to len -1 do
      Result := Result + GetCellValue(doc, mcx(cx, CellIDs[i]));
end;

function SumGLAArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer;
  CR, SqM, SqF: Integer): Integer;
// 091809 JWyatt: This function is similar to SumCellArray in that it summs the GLA
//  amounts for each floor listed in the CellIDs array. The difference is that it
//  appends the MeasType to the amount. The result is, for example, "1200 Sq Ft"
//  instead of just "1200". Formatting is used to limit the MeasVal so that it
//  fits into the available spaces on the forms.
var
  MeasVal, MeasType: String;
begin
  MeasVal := Trim(Format('%-8.0n', [GetArraySum(doc, CX, CellIds)]));
  MeasType := Trim(GetCellString(doc, mcx(CX, SqM)));
  if MeasType = '' then
    begin
      MeasType := Trim(GetCellString(doc, mcx(CX, SqF)));
      if MeasType <> '' then
        MeasType := ' SqFt';
    end
  else
    MeasType := ' SqM';
  SetCellString(doc, mcx(CX, CR), MeasVal + MeasType);
  result := 0;
end;

function SumCellArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer; CR: Integer): Integer;
var
  VR: Double;
begin
  VR := GetArraySum(doc, CX, CellIds);
  result := SetCellValue(doc, MCX(cx, CR), VR);
end;

function FactorSumCellArray(doc: TContainer; CX: CellUID; const CellIDs: array of Integer;
  CR: Integer; const CellFactors: array of Real): Integer;
var
  i, len: Integer;
  VR: Double;
begin
  VR := 0.0;
  len := length(CellIDs);
  if len > 0 then
    for i := 0 to len -1 do
      VR := VR + (GetCellValue(doc, mcx(CX, CellIDs[i])) * CellFactors[i]);
  result := SetCellValue(doc, MCX(CX, CR), VR);
end;


function DivideAB_R(doc: TContainer; CX: CellUID; NumeratorID, DenominatorID, CR: Integer): Integer;
var
  VR: Double;
begin
  result := 0;
  VR := GetCellValue(doc, mcx(CX, DenominatorID));
  if VR <> 0 then
    begin
      VR := GetCellValue(doc, mcx(CX, NumeratorID)) / VR;
      result := SetCellValue(doc, MCX(cx, CR), VR);
    end
  else if CellHasData(doc, MCX(cx, CR)) then
    begin
      VR := 0.0;
      result := SetCellValue(doc, MCX(cx, CR), VR);
    end;
end;

function RoundByValR(doc: TContainer; CX: CellUID; C1, CR: Integer; RndVal: Double): Integer;
var
  V1, VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  VR := RoundVal(V1, rndVal);
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function SalesGridAdjustment(doc: TContainer; CX: CellUID; SalesAmtID,
  TotalAdjID, FinalAmtID, PosChkID, NegChkID, NetInfoID, GrossInfoID: Integer;
  const AdjCIDs: array of Integer; hasAddress: Boolean = true ): Integer;
var
  NetAdjustment, GrossAdjustment: Double;
  SalesValue, NetPercent, GrossPercent: Double;
  Counter: Integer;
begin
  Result := 0;
  NetAdjustment := 0;
  GrossAdjustment := 0;

  if not hasAddress then    //github  #346
    begin
      if (TotalAdjID <> 0)then
        SetCellstring(doc, MCX(CX, TotalAdjID), '');
      if (PosChkID <> 0) then
        ClearCheckMark(doc, MCX(CX, PosChkID));
      if (NegChkID <> 0) then
        ClearCheckMark(doc, MCX(CX, NegChkID));
      if NetInfoID <> 0 then
        SetInfoCellValue(doc, MCX(CX, NetInfoID),0);
      if GrossInfoID <> 0 then
        SetInfoCellValue(doc, MCX(CX, GrossInfoID), 0);
      if (FinalAmtID <> 0) then
        Result := SetCellString(doc, MCX(CX, FinalAmtID), '');
      exit;
    end;

  for Counter := Low(AdjCIDs) to High(AdjCIDs) do
    GetNetGrosAdjs(doc, MCX(CX, AdjCIDs[counter]), NetAdjustment, GrossAdjustment);

  //set sum of Adj
  if (TotalAdjID <> 0) then  //github 293
    SetCellValue(doc, MCX(CX, TotalAdjID), NetAdjustment);

  //toggle the checkmarks or clear if net = 0
  if (NetAdjustment > 0) and (PosChkID <> 0) then
    SetCellChkMark(doc, MCX(CX, PosChkID), True)

  else if (NetAdjustment < 0) and (NegChkID <> 0) then
    SetCellChkMark(doc, MCX(CX, NegChkID), True)

  else if (NegChkID <> 0) and (PosChkID <> 0) then begin
    ClearCheckMark(doc, MCX(CX, PosChkID));
    ClearCheckMark(doc, MCX(CX, NegChkID));
  end;

  //calc the net/grs percents
  if SalesAmtID <> 0 then
    SalesValue := GetCellValue(doc, MCX(CX, SalesAmtID))
  else
    SalesValue := 0;

  if SalesValue <> 0 then
    begin
      GrossPercent := (GrossAdjustment / SalesValue) * 100;

      UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrossPercent / 100) * (SalesValue + NetAdjustment);
      UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrossPercent / 100);

      if NetInfoID <> 0 then
      begin
        NetPercent := (NetAdjustment / SalesValue) * 100;
        SetInfoCellValue(doc, MCX(CX, NetInfoID), NetPercent);
      end;

      if GrossInfoID <> 0 then
        SetInfoCellValue(doc, MCX(CX, GrossInfoID), GrossPercent); //set the info cells
    end
  else
    begin
      SetInfoCellValue(doc, MCX(CX, GrossInfoID), 0); //set the info cells
      SetInfoCellValue(doc, MCX(CX, NetInfoID), 0);
    end;

 if (FinalAmtID <> 0) then  //github 293
   Result := SetCellValue(doc, MCX(CX, FinalAmtID), SalesValue + NetAdjustment); //set final adj price
end;


function AddCells(ADoc: TContainer; ATemplateCellUID: CellUID; const AddCellIDs: array of Integer): Double;
begin
 Result := AddCells(ADoc, ATemplateCellUID, AddCellIDs, []);
end;

function AddCells(ADoc: TContainer; ATemplateCellUID: CellUID; const AddCellIDs, SubtractCellIDs: array of Integer): Double;
var
 Counter: Integer;
begin
 Result := 0.0;

 for Counter := Low(AddCellIDs) to High(AddCellIDs) do
 begin
   ATemplateCellUID.Num := AddCellIDs[Counter] - 1; //  Num is an offset; ID is an index;
   Result := Result + GetCellValue(ADoc, ATemplateCellUID);
 end;
 for Counter := Low(SubtractCellIDs) to High(SubtractCellIDs) do
 begin
   ATemplateCellUID.Num := SubtractCellIDs[Counter] - 1; //  Num is an offset; ID is an index;
   Result := Result - GetCellValue(ADoc, ATemplateCellUID);
 end;
end;

function AddAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const AddCellIDs: array of Integer): Integer;
begin
 Result := AddAndSubtractAndStoreCells(ADoc, ATemplateCellUID, TargetCellID, AddCellIDs, []);
end;

function AddAndSubtractAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const AddCellIDs, SubtractCellIDs: array of Integer): Integer;
begin
 ATemplateCellUID.Num := TargetCellID - 1;     //  Num is an offset; ID is an index
 Result := SetCellValue(ADoc, ATemplateCellUID, AddCells(ADoc, ATemplateCellUID, AddCellIDs, SubtractCellIDs));
end;

function MultiplyCells(ADoc: TContainer; ATemplateCellUID: CellUID; const CellIDs: array of Integer): Double;
var
 Counter: Integer;
 TotalValue, ThisValue: Double;
begin
 Result := 0.0;

 TotalValue := 1;
 for Counter := Low(CellIDs) to High(CellIDs) do
 begin
   ATemplateCellUID.Num := CellIDs[Counter] - 1; //  Num is an offset; ID is an index;

   ThisValue := GetCellValue(ADoc, ATemplateCellUID);

   //  if blank or non-numeric, do not treat as zero
   if (ThisValue <> 0.0) or
     (StrToIntDef(GetCellString(ADoc, ATemplateCellUID), MaxInt) <> MaxInt) then
   begin
     TotalValue := TotalValue * ThisValue;
   end;
   Result := TotalValue;                       //  only assign the value if we have at least one (1) cell
 end;
end;

function MultiplyAndStoreCells(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID: Integer; const CellIDs: array of Integer): Integer;
begin
 ATemplateCellUID.Num := TargetCellID - 1;     //  Num is an offset; ID is an index;
 Result := SetCellValue(ADoc, ATemplateCellUID, MultiplyCells(ADoc, ATemplateCellUID, CellIDs));
end;
(*
function RoundAndStoreCell(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID, SourceCellID, RoundingDigits: Integer): Integer;
var
 TargetCellUID: CellUID;
begin
 TargetCellUID := ATemplateCellUID;
 ATemplateCellUID.Num := SourceCellID - 1;     //  Num is an offset; ID is an index;
 TargetCellUID.Num := TargetCellID - 1;        //  Num is an offset; ID is an index;
 Result := SetCellValue(ADoc, TargetCellUID,
   RoundUp(GetCellValue(ADoc, ATemplateCellUID), RoundingDigits))
end;
*)
function GetPercentageCell(ADoc: TContainer; ATemplateCellUID: CellUID; PrincipalID, PercentCellID: Integer): Double;
var
 PercentageValue: Double;
begin
 ATemplateCellUID.Num := (PrincipalID - 1);    //  Num is an offset; ID is an index;
 Result := GetCellValue(ADoc, ATemplateCellUID);

 ATemplateCellUID.Num := (PercentCellID - 1);  //  Num is an offset; ID is an index;
 PercentageValue := GetCellValue(ADoc, ATemplateCellUID);
 PercentageValue := PercentageValue / 100;

 Result := Result * PercentageValue;           //  if Percent is zero (of blank), then zero result
end;

function GetPercentAndStoreCell(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID, PrincipalID, PercentCellID: Integer): Integer;
begin
 ATemplateCellUID.Num := TargetCellID - 1;     //  Num is an offset; ID is an index;
 Result := SetCellValue(ADoc, ATemplateCellUID,
   GetPercentageCell(ADoc, ATemplateCellUID, PrincipalID, PercentCellID));
end;

function DeductLossAndStoreCell(ADoc: TContainer; ATemplateCellUID: CellUID;
 TargetCellID, IncomeCellID, LossPercentCellID: Integer): Integer;
var
 TotalValue, PercentageValue: Double;
begin
 ATemplateCellUID.Num := (IncomeCellID - 1);   //  Num is an offset; ID is an index;
 TotalValue := GetCellValue(ADoc, ATemplateCellUID);

 ATemplateCellUID.Num := (LossPercentCellID - 1); //  Num is an offset; ID is an index;
 PercentageValue := GetCellValue(ADoc, ATemplateCellUID);
 if PercentageValue <> 0 then
 begin
   PercentageValue := PercentageValue / 100;
   TotalValue := TotalValue * (1 - PercentageValue);
 end;
 ATemplateCellUID.Num := (TargetCellID - 1);   //  Num is an offset; ID is an index;
 Result := SetCellValue(ADoc, ATemplateCellUID, TotalValue);
end;


function LandUseSum(doc: TContainer; CX: CellUID; InfoID: Integer;
          const CIDs: Array of Integer): Integer;
var
  V1: Double;
begin
  V1 := GetArraySum(doc, CX, CIDs);
  result := SetInfoCellValue(doc, mcx(cx,InfoID), V1);
end;

function SalesGridAdjustmentWithForecast(doc: TContainer; CX: CellUID; SalesAmtID,
  TotalAdjID, FinalAmtID, PosChkID, NegChkID, NetInfoID, GrossInfoID: Integer; const curForecastID,
  forecastID1, forecastID2, forecastID3: Integer; const AdjCIDs: array of Integer;
  cAddr1, cAddr2, cAddr3: Integer): Integer;
var
  NetAdjustment, GrossAdjustment: Double;
  SalesValue, NetPercent, GrossPercent: Double;
  Counter: Integer;
  forecastValue: Double;
  addr: String;
begin
  Result := 0;

  NetAdjustment := 0;
  GrossAdjustment := 0;

  if curForecastID = forecastID1 then
    begin
      forecastValue := GetCellValue(doc, MCX(CX, curForecastID));
      if forecastValue > 0 then
        begin
          addr := GetCellString(doc, mcx(cx,cAddr2));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID2), forecastValue);
          addr := GetCellString(doc, mcx(cx,cAddr3));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID3), forecastValue);
        end
    end
  else if curForecastID = forecastID2 then
    begin
      forecastValue := GetCellValue(doc, MCX(CX, curForecastID));
      if forecastValue > 0 then
        begin
          addr := GetCellString(doc, mcx(cx,cAddr1));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID1), forecastValue);
          addr := GetCellString(doc, mcx(cx,cAddr3));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID3), forecastValue);
        end
    end
  else if curForecastID = forecastID3 then
    begin
      forecastValue := GetCellValue(doc, MCX(CX, curForecastID));
      if forecastValue > 0 then
        begin
          addr := GetCellString(doc, mcx(cx,cAddr1));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID1), forecastValue);
          addr := GetCellString(doc, mcx(cx,cAddr2));   //get the address
          if addr <> '' then
            SetCellValue(doc, MCX(CX, forecastID2), forecastValue);
        end
    end;

  for Counter := Low(AdjCIDs) to High(AdjCIDs) do
    GetNetGrosAdjs(doc, MCX(CX, AdjCIDs[counter]), NetAdjustment, GrossAdjustment);

  //set sum of Adj
  if (TotalAdjID <> 0) then   //github 293
    SetCellValue(doc, MCX(CX, TotalAdjID), NetAdjustment);

  //toggle the checkmarks or clear if net = 0
  if (NetAdjustment > 0) and (PosChkID <> 0) then
    SetCellChkMark(doc, MCX(CX, PosChkID), True)

  else if (NetAdjustment < 0) and (NegChkID <> 0) then
    SetCellChkMark(doc, MCX(CX, NegChkID), True)

  else if (NegChkID <> 0) and (PosChkID <> 0) then begin
    ClearCheckMark(doc, MCX(CX, PosChkID));
    ClearCheckMark(doc, MCX(CX, NegChkID));
  end;

  //calc the net/grs percents
  if SalesAmtID <> 0 then
    SalesValue := GetCellValue(doc, MCX(CX, SalesAmtID))
  else
    SalesValue := 0;

  if SalesValue <> 0 then
    begin
      GrossPercent := (GrossAdjustment / SalesValue) * 100;

      UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrossPercent / 100) * (SalesValue + NetAdjustment);
      UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrossPercent / 100);

      if NetInfoID <> 0 then
      begin
        NetPercent := (NetAdjustment / SalesValue) * 100;
        SetInfoCellValue(doc, MCX(CX, NetInfoID), NetPercent);
      end;

      if GrossInfoID <> 0 then
        SetInfoCellValue(doc, MCX(CX, GrossInfoID), GrossPercent); //set the info cells
    end
  else
    begin
      SetInfoCellValue(doc, MCX(CX, GrossInfoID), 0); //set the info cells
      SetInfoCellValue(doc, MCX(CX, NetInfoID), 0);
    end;

 if (FinalAmtID <> 0) then //github 293
   Result := SetCellValue(doc, MCX(CX, FinalAmtID), SalesValue + NetAdjustment); //set final adj price
end;



end.

