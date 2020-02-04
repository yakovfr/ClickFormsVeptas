unit uReviewRules;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  XmlDom, XmlIntf, XmlDoc, StrUtils, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids_ts, TSGrid, osAdvDbGrid, Contnrs,RzShellDialogs, RzLine,CheckLst,
  DCSystem, DCScript, UGlobals, UContainer, UForm, UPage, UAMC_XMLUtils, {UAMC_RequestOverride, }
  Buttons, ShellAPI, UEditor, UForms, UCell, {UGSELogin,} VMSUpdater_TLB, UAMC_Globals, UGridMgr,
  AWSI_Server_Access, uBase, UUtil1, UUtil2;

type
  SubjectRec = record     //structure for handling the different grid views
    cell_48: String;     //property state
    cell_960: String;    //Sale Date smm/dd;cmm/dd
    cell_2098: String;   //appraiser State of license
    cell_2099: String;   //supervisor state
    cell_1132: String;   //Effective Date

  end;

  var
    FSubjectRec: SubjectRec;
    FDoc: TContainer;

    function AddErrRecord(FDoc: TContainer; RuleNo:Integer; f: Integer; cCellUID: CellUID; CompID:Integer;GridKind:Integer=gtSales):String;
    function ProcessRules(FDoc: TContainer; ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer):String;
    function ProcessRules2(ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer;CompColumn: TCompColumn; gridKind:Integer=gtSales):String;
    function ProcessFormRules(f, CompID:Integer; CurCell:TBaseCell; FDoc:TContainer):String;

    function ReviewItems(RuleNum, f, Col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;

implementation

const
   FNM0093 = 1;
   FNM0094 = 2;
   FNM0085 = 3;
   FNM0100 = 4;   //Check for Valid UAD Date format checking mm/dd/yyyy




function RemoveComma(aStr:String):String;
begin
  aStr := StringReplace(aStr, ',', '', [rfReplaceAll]);
end;

function AddErrRecord(FDoc: TContainer; RuleNo:Integer; f: Integer; cCellUID: CellUID; CompID:Integer;GridKind:Integer=gtSales):String;
var
  Msg, CompName: String;
begin
  Msg := '';
  case GridKind of
    gtSales: CompName := 'COMP';
    gtListing: CompName := 'LISTING';
    gtRental: CompName := 'RENT';
  end;
  if FDoc.UADEnabled then
   begin
     case RuleNo of
       FNM0093: Msg := '* Appraiser license state does not match subject property state.';
       FNM0094: Msg := '* Supervisor license state does not match subject property state.';
       FNM0085: ;  //skip here.  We already done.
       //Make this a critical warning instead
       //FNM0100: Msg := '** Invalid Date format.  Please enter the date in "mm/dd/yyyy" format.';
       FNM0100: Msg := '* Invalid Date format.  Please enter the date in "mm/dd/yyyy" format.';
       else
        Msg := Format('** %s',[Msg]);
     end;
   end
  else begin
    case RuleNo of
      FNM0100: Msg := 'Invalid Date format.  Please enter the date in "mm/dd/yyyy" format.';
    end;
  end;
  result := Msg;
end;

//this routine deal with sales date UAD in this format: smm/yy;cmm/yy
//the Sep can be s or c
function ConvertMonthDayYear(aDateStr:String;Sep:String):String;//aDateStr = smm/yy;cmm/yy
var
  aMonth, aYear, aStr:String;
begin
  result := '';
  if (POS(';',aDateStr) > 0) and (POS(Sep,aDateStr)>0) then
  begin
    aStr := popStr(aDateStr, ';');
    if (aStr <> '') and (pos('/',aStr) > 0) then
     aMonth := popStr(aStr, '/');
     if POS('s',aMonth) > 0 then
       aMonth := copy(aMonth, 2, 2);  //copy the last 2
     aYear := aStr;
     result := Format('%s/01/%s',[aMonth, aYear]); //put back date format and add 01 for the day
  end;
end;

function ProcessRules2(ruleNum: Integer; Value1, MainValue: String;
                          f: Integer; CurCell: TBaseCell; CompID:Integer; CompColumn: TCompColumn; GridKind:Integer=gtSales):String;
var
  adj, addr: String;
  Num1, Num2, Num3, diff: Double;
  aDateTime, aDateTime2: TDateTime;
  year,month,day, dow: word;
begin
  result := '';
end;

function ProcessRules(FDoc: TContainer; ruleNum: Integer; Value1, MainValue: String; f: Integer; CurCell: TBaseCell; CompID:Integer):String;
var
  aDateTime, aDateTime2: TDateTime;
  isSale: Boolean;
  mm, dd, yy, SaleDate : String;
  formID: Integer;
begin
  result := '';
  aDateTime := 0;
  case ruleNum of
    FNM0093,
    FNM0094:
      begin
        if CompareText(Value1, MainValue) <> 0 then
         result := AddErrRecord(FDoc, RuleNum, f, curCell.UID, CompID);
      end;
    FNM0100:
      begin
         if Value1 <> '' then
           begin
             formID := curCell.UID.FormID;
             //only against with main form and extra form
             case formID of
               340, 341, 363, 349, 346, 348, 350, 356, 869, 364, 345, 888, 367, 347, 355, 3545, 4218, 4365:  //added 1004P
                 begin
                   if not isValidDateTime(Value1, aDateTime) then
                     result := AddErrRecord(FDoc, RuleNum, f, curCell.UID, CompID);
                 end;
             end;
           end;
      end;
  end;
end;




function GetCellID(RuleNum: Integer; CompColumn: TCompColumn; var SubjectCellValue:String):Integer;
begin    //return the cell id and the subject value for that cell
  result := 0;
end;



function ReviewItems(RuleNum, f, col: Integer; CompColumn: TCompColumn;GridKind:Integer=gtSales):String;
var
  Value1, Value2: String;
  CurCell: TBaseCell;
  cellID: Integer;
  SubjectCellValue: String;
begin
    result := '';
    CellID := GetCellID(RuleNum, CompColumn, SubjectCellValue);
    curCell := CompColumn.GetCellByID(CellID);
    if assigned(CurCell) then
      Value1 := CurCell.Text;
    Value2 := SubjectCellValue;
    result := ProcessRules2(ruleNum,Value1, Value2, f, CurCell, Col, CompColumn, GridKind);
end;

function ProcessFormRules(f, CompID:Integer; CurCell:TBaseCell; FDoc:TContainer):String;
var
  Value1, Value2: String;
  ruleNum: Integer;
  aDateTime: TDateTime;
begin
  result := '';
  case CurCell.FCellID of
      48: FSubjectRec.cell_48 := CurCell.Text;
    2098: begin //appraiser state
            RuleNum := FNM0093;
            Value1 := CurCell.Text;
            Value2 := FSubjectRec.cell_48;
            if (Value1 <>'') and (Value2 <> '') then
              result := ProcessRules(FDoc, ruleNum, Value1, Value2, f, CurCell, CompID);
          end;
    2099: begin //supervisor state
            RuleNum := FNM0094;
            Value1 := CurCell.Text;
            Value2 := FSubjectRec.cell_48;
            if (Value1 <>'') and (Value2 <> '') then
              result := ProcessRules(FDoc, ruleNum, Value1, Value2, f, CurCell, CompID);
          end;
(*
    Donot check valid date here, check in review script, since the FText sometimes
    gives us mm/dd/yyyy even the real text is 07/10/2015
    934, 2074, 1132, 2081, 5, 17, 6, 28:   //check for valid date format
          begin
            if CurCell.FCellID = 1132 then //effective date
              FSubjectRec.cell_1132 := CurCell.Text;
            RuleNum := FNM0100;
            Value1 := CurCell.Text;
            Value2 := CurCell.Text;
            result := ProcessRules(FDoc, ruleNum, Value1, Value2, f, CurCell, CompID);
          end;
*)

  end;
end;



end.
