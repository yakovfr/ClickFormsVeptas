unit UMathUAD;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }

{ this unit handles all the math for the UAD Worksheets}

interface

uses
  UGlobals, UContainer;

const
  fmUADWorksheet1 = 981;     //UAD worksheet - subject & comps
  fmUADXCompsWrk1 = 983;     //UAD worksheet - xtra comps

  fmUADSubDetails = 981;     //UAD Subject Details
  fmUADCmpDetails = 982;     //UAD Comp Grid deatils

//new  function ProcessForm0981Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//new  function ProcessForm0983Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0981Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0982Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0983Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, DateUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

(*-------------------------New Worksheet------------------------------
// summary: Calculates site dimensions indicating acres or square feet on a checkbox.
function F0981SiteDimension(doc: TContainer; CellA, CellR, CellCk1, CellCk2: CellUID): Integer;
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
              ClearCheckMark(doc, CellCk1);
              SetCellChkMark(doc, CellCk2, True);
            end
          else
            begin
              tmpStr := sqftStr;                    //Concat(sqftStr, ' SqFt');
              ClearCheckMark(doc, CellCk2);
              SetCellChkMark(doc, CellCk1, True);
            end;

          result := SetCellString(doc, CellR, tmpStr);
          V := nil;                                 //release the array
        end
      else
        result := 0;                              //no values, return no processing

      Finalize(V);                                //release dynamic array
    end;
end;

function F0981YearToAge(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  YrStr: String;
  Year, Age: Integer;
begin
  YrStr := GetCellString(doc, CellA);
  Year := GetValidInteger(YrStr);
  if Year > 0 then
    begin
      Age := CurrentYear - Year;
      SetCellString(doc, CellR, IntToStr(Age));
    end;
    result := 0;     //no more processing (avoid looping)
end;

function F0981AgeToYear(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  AgeStr: String;
  Year, Age: Integer;
begin
  AgeStr := GetCellString(doc, CellA);
  Age := GetValidInteger(AgeStr);
  if Age > 0 then
    begin
      Year := CurrentYear - Age;
      SetCellString(doc, CellR, IntToStr(Year));
    end;
    result := 0;     //no more processing (avoid looping)
end;

function F0981NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 206)) then
    begin
      EraseCell(doc, mcx(cx,207));
      SetCellString(doc, MCX(CX, 208), '0');
      EraseCell(doc, mcx(cx,209));
      EraseCell(doc, mcx(cx,210));
      SetCellString(doc, MCX(CX, 211), '0');
      EraseCell(doc, mcx(cx,212));
      SetCellString(doc, MCX(CX, 213), '0');
      EraseCell(doc, mcx(cx,214));
      EraseCell(doc, mcx(cx,215));
      EraseCell(doc, mcx(cx,216));
    end;
  result := 0;
end;

function F0981NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx,167)) then
    begin
      SetCellChkMark(doc, mcx(CX, 168), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 169), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 170), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 171), False);    //floor
      SetCellChkMark(doc, mcx(CX, 172), False);    //heated
      SetCellChkMark(doc, mcx(CX, 173), False);    //finished
    end;
  result := 0;
end;

function F0981NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx,152)) then
    begin
      SetCellValue(doc, mcx(cx,156), 0);   //bsmt = 0sf
      EraseCell(doc, mcx(cx,153));
      EraseCell(doc, mcx(cx,154));
      EraseCell(doc, mcx(cx,155));
      EraseCell(doc, mcx(cx,157));   //%
      EraseCell(doc, mcx(cx,158));   //finished
      EraseCell(doc, mcx(cx,159));   //access
      EraseCell(doc, mcx(cx,160));
      EraseCell(doc, mcx(cx,161));
      EraseCell(doc, mcx(cx,162));   //rooms
      EraseCell(doc, mcx(cx,163));
      EraseCell(doc, mcx(cx,164));
      EraseCell(doc, mcx(cx,165));
      EraseCell(doc, mcx(cx,166));
    end;
  result := 0;
end;

function F0981NoUpdating(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx,217)) then
    begin
      EraseCell(doc, mcx(cx,221));
      EraseCell(doc, mcx(cx,222));
      EraseCell(doc, mcx(cx,223));
      EraseCell(doc, mcx(cx,224));
    end;
  result := 0;
end;

function F0981DOMUnknown(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    SetCellString(doc, mcx(cx,49), 'Unk')
  else
    EraseCell(doc, mcx(cx,49));

  result := 0;
end;

function F0981CalcDOM(doc: TContainer; CX, CXDate1, CXDate2, CXDate3, CXDate4: CellUID): Integer;
var
  DOM: Integer;
  TestDate, StartDate, LastDate: TDateTime;
begin
  DOM := 0;
  testDate := GetCellDate(doc, CXDate1);  //get the original date
  if testDate <> 0 then
    begin
      StartDate := testDate;              //set the start date

      testDate := GetCellDate(doc, CXDate2);
      if testDate <> 0 then
        LastDate := testDate;

      testDate := GetCellDate(doc, CXDate3);
      if testDate <> 0 then
        LastDate := testDate;

      testDate := GetCellDate(doc, CXDate4);
      if testDate <> 0 then
        LastDate := testDate;

      if (StartDate <> 0) and (lastDate <> 0) then
        DOM := DaysBetween(LastDate, StartDate);

      result := SetCellValue(doc, mcx(cx,49), DOM);
    end
  else
    result := 0;
end;

function F0981TransferContract(doc: TContainer; CX, TypeCell, DateCell, PriceCell: CellUID): Integer;
begin
  if CompareText(GetCellString(doc, TypeCell), 'Contract') = 0 then
    begin
      TransA2B(doc, PriceCell, mcx(cx,66));
      TransA2B(doc, DateCell, mcx(cx,67));
    end;
  result := 0;
end;

function F0981SetCurrentDateAndPrice(doc: TContainer; CX: CellUID): Integer;
var
  OrgCX: CellUID;
  lastPrice: String;
begin
  OrgCX := CX;
  if CompareText(GetCellString(doc, CX), 'Current') = 0 then
    begin
      CX.num := OrgCX.num + 1;                //inc to next cell
      result := SetCellDate(doc, CX, Now);    //set todays date

      CX.num := OrgCX.num - 1;                //get last price
      lastPrice := GetCellString(doc, CX);

      CX.num := OrgCX.num +2;                 //set as current price
      SetCellString(doc, cx, lastPrice);
    end
  else
    result := 0;
end;

function F0981C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 68,147,148,145,146,4,5,
            [72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,107,112,114,115,121,123,125,129,131,133,135,137,139,141,143,145]);
end;

function F0981C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 159,238,239,236,237,6,7,
            [163,165,167,169,171,173,175,177,179,181,183,185,187,189,191,193,195,197,198,203,205,206,212,214,216,220,222,224,226,228,230,232,234,236]);
end;

function F0981C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 250,329,330,327,328,8,9,
            [254,256,258,260,262,264,266,268,270,272,274,276,278,280,282,284,286,288,289,294,296,297,303,305,307,311,313,315,317,319,321,323,325,327]);
end;


function F0983C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 65,143,144,141,142,4,5,
            [68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,103,108,110,111,117,119,121,125,127,129,131,133,135,137,139,141]);
end;

function F0983C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 156,235,236,233,234,6,7,
            [156,158,160,162,164,166,168,170,172,174,176,178,180,182,184,186,188,190,191,196,198,199,205,207,209,213,215,217,219,221,223,225,227,229]);
end;

function F0983C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 248,327,328,325,326,8,9,
            [244,246,248,250,252,254,256,258,260,262,264,266,268,270,272,274,276,278,279,284,286,287,293,295,297,301,303,305,307,309,311,313,315,317]);
end;

{-----------------------------------------------------------------------------}
{                      Start of Main Math Routines for UAD                    }
{-----------------------------------------------------------------------------}


function ProcessForm0981Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetCellChkMark(doc, mcx(cx,152), True);   //No Basement when foundation = slab/crawlspace
        2:
          cmd := F0981SiteDimension(doc, mcx(cx,76), mcx(cx,77), mcx(cx,78), mcx(cx,79));
        3:
          cmd := F0981NoCarStorage(doc, mcx(cx,206));
        4:
          cmd := F0981YearToAge(doc, mcx(cx,139), mcx(cx,140));
        5:
          cmd := F0981NoAttic(doc, mcx(cx,167));
        6:
          cmd := F0981AgeToYear(doc, mcx(cx,140), mcx(cx,139));
        7:
          cmd := ClearCheckMark(doc, mcx(CX, 167));    //make sure No Attic is not checked
        8:
          cmd := ClearCheckMark(doc, mcx(CX, 206));    //make sure No garage is not checked
        9:
          cmd := F0981DOMUnknown(doc, cx);
        10:
          cmd := F0981CalcDOM(doc, CX, mcx(cx,50), mcx(cx,53), mcx(cx,56), mcx(cx,59));
        11:
          cmd := MultPercentAB(doc, mcx(cx,156), mcx(cx,157), mcx(cx,158));   //basement percent finished
        12:
          cmd := F0981TransferContract(doc, CX, mcx(cx,52), mcx(cx,53), mcx(cx,54));
        13:
          cmd := F0981TransferContract(doc, CX, mcx(cx,55), mcx(cx,56), mcx(cx,57));
        14:
          cmd := F0981TransferContract(doc, CX, mcx(cx,58), mcx(cx,59), mcx(cx,60));
        15:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [10, 12]);   //DOM & Contract
        16:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [10, 13]);   //DOM & Contract
        17:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [10, 14]);   //DOM & Contract
        18:
          cmd := F0981SetCurrentDateAndPrice(doc, CX);
        19:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [18, 12]);   //Contract & Current date
        20:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [18, 13]);   //Contract & Current date
        21:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX, [18, 14]);   //Contract & Current date
        22:
          cmd := F0981NoBasement(doc, cx);
        23:
          cmd := F0981NoUpdating(doc, cx);

    //page 2
        24:
          Cmd := F0981C1Adjustments(doc, cx);
        25:
          Cmd := F0981C2Adjustments(doc, cx);
        26:
          Cmd := F0981C3Adjustments(doc, cx);
        27:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX,[32,24]); //C1 sales price
        28:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX,[33,25]); //C2 sales price
        29:
          cmd := ProcessMultipleCmds(ProcessForm0981Math, doc, CX,[34,26]); //C3 sales price
        30:
          cmd := CalcWeightedAvg(doc, [981, 983]);   //calc wtAvg of main and xcomps forms
        31:
          cmd := DivideAB(doc, mcx(cx,19), mcx(cx,37), mcx(cx,20));     //Subj price/sqft
        32:
          cmd := DivideAB(doc, mcx(cx,69), mcx(cx,113), mcx(cx,70));    //C1 price/sqft
        33:
          cmd := DivideAB(doc, mcx(cx,160), mcx(cx,204), mcx(cx,161));  //C2 price/sqft
        34:
          cmd := DivideAB(doc, mcx(cx,251), mcx(cx,295), mcx(cx,252));  //C3 price/sqft
        35:
          begin //no recursion, for calculating Wt Average
            F0981C1Adjustments(doc, cx);
            F0981C2Adjustments(doc, cx);
            F0981C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else //cmd < 0
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0981Math(doc, 35, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0981Math(doc, 35, CX);
        end;
    end;

  result := 0;
end;

//UAD Xtra Comparables
function ProcessForm0983Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'UAD XComps', 54,142,230);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 54,142,230, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 54,142,230);
        10:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,32), mcx(cx,15));         //Subj price/sqft
        11:
          cmd := DivideAB(doc, mcx(cx,65), mcx(cx,109), mcx(cx,66));        //C1 price/sqft
        12:
          cmd := DivideAB(doc, mcx(cx,153), mcx(cx,197), mcx(cx,154));      //C2 price/sqft
        13:
          cmd := DivideAB(doc, mcx(cx,241), mcx(cx,285), mcx(cx,242));      //C3 price/sqft
        14:
          cmd := ProcessMultipleCmds(ProcessForm0983Math, doc, CX,[11,24]); //C1 sales price
        15:
          cmd := ProcessMultipleCmds(ProcessForm0983Math, doc, CX,[12,25]); //C2 sales price
        16:
          cmd := ProcessMultipleCmds(ProcessForm0983Math, doc, CX,[13,26]); //C3 sales price
        17:
          cmd := CalcWeightedAvg(doc, [981, 983]);   //calc wtAvg of main and xcomps forms
        18:
          begin //no recursion, for calculating Wt Average
            F0983C1Adjustments(doc, cx);
            F0983C2Adjustments(doc, cx);
            F0983C3Adjustments(doc, cx);
            cmd := 0;
          end;
        24:
          Cmd := F0983C1Adjustments(doc, cx);
        25:
          Cmd := F0983C2Adjustments(doc, cx);
        26:
          Cmd := F0983C3Adjustments(doc, cx);
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else //cmd < 0
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm0983Math(doc, 18, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm0983Math(doc, 18, CX);
        end;
    end;

  result := 0;
end;
----------------------------New Worksheet end of code --------------------*)
/// summary: Calculates site dimensions indicating acres or square feet on a checkbox.
/// remarks: Made for the RELS Land Appraisal form (#889).
function F0891SiteDimension(doc: TContainer; CellA, CellR, CellCk1, CellCk2: CellUID): Integer;
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
              ClearCheckMark(doc, CellCk1);
              SetCellChkMark(doc, CellCk2, True);
            end
          else
            begin
              tmpStr := sqftStr;                    //Concat(sqftStr, ' SqFt');
              ClearCheckMark(doc, CellCk2);
              SetCellChkMark(doc, CellCk1, True);
            end;

          result := SetCellString(doc, CellR, tmpStr);
          V := nil;                                 //release the array
        end
      else
        result := 0;                              //no values, return no processing

      Finalize(V);                                //release dynamic array
    end;
end;

function F0981YearToAge(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  YrStr: String;
  Year, Age: Integer;
begin
  YrStr := GetCellString(doc, CellA);
  Year := GetValidInteger(YrStr);
  if Year > 0 then
    begin
      Age := CurrentYear - Year;
      SetCellString(doc, CellR, IntToStr(Age));
    end;
    result := 0;     //no more processing (avoid looping)
end;

function F0981AgeToYear(doc: TContainer; CellA, CellR: CellUID): Integer;
var
  AgeStr: String;
  Year, Age: Integer;
begin
  AgeStr := GetCellString(doc, CellA);
  Age := GetValidInteger(AgeStr);
  if Age > 0 then
    begin
      Year := CurrentYear - Age;
      SetCellString(doc, CellR, IntToStr(Year));
    end;
    result := 0;     //no more processing (avoid looping)
end;

function F0981NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, cx) then
    begin
      EraseCell(doc, mcx(cx,200));
      SetCellString(doc, MCX(CX, 201), '0');
      EraseCell(doc, mcx(cx,202));
      EraseCell(doc, mcx(cx,203));
      SetCellString(doc, MCX(CX, 204), '0');
      EraseCell(doc, mcx(cx,205));
      SetCellString(doc, MCX(CX, 206), '0');
      EraseCell(doc, mcx(cx,207));
      EraseCell(doc, mcx(cx,208));
      EraseCell(doc, mcx(cx,209));
    end;
  result := 0;
end;

function F0981NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 161), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 162), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 163), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 164), False);    //floor
      SetCellChkMark(doc, mcx(CX, 165), False);    //heated
      SetCellChkMark(doc, mcx(CX, 166), False);    //finished
    end;
  result := 0;
end;

function F0981DOMUnknown(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    SetCellString(doc, mcx(cx,49), 'Unk')
  else
    EraseCell(doc, mcx(cx,49));

  result := 0;
end;

function F0981CalcDOM(doc: TContainer; CX: CellUID): Integer;
begin
  result := 0;
end;

function F0981CalcBsmtArea(doc: TContainer; CX: CellUID): Integer;
begin
  if Trunc(GetCellValue(doc, mcx(cx,151))) = 0 then
    begin
      EraseCell(doc, mcx(cx,148));
      EraseCell(doc, mcx(cx,149));
      EraseCell(doc, mcx(cx,150));
      EraseCell(doc, mcx(cx,154));
      EraseCell(doc, mcx(cx,155));
      EraseCell(doc, mcx(cx,156));
      EraseCell(doc, mcx(cx,157));
      EraseCell(doc, mcx(cx,158));
      EraseCell(doc, mcx(cx,159));
      SetCellValue(doc, mcx(cx,152), 0)
    end;
  result := MultPercentAB(doc, mcx(cx,151), mcx(cx,152), mcx(cx,153))
end;

function ProcessForm0981Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetCellValue(doc, mcx(cx,151), 0);   //set bsm't area = 0 when foundation = slab/crawlspace
        2:
          cmd := F0891SiteDimension(doc, mcx(cx,76), mcx(cx,77), mcx(cx,78), mcx(cx,79));
        3:
          cmd := F0981NoCarStorage(doc, mcx(cx,199));
        4:
          cmd := F0981YearToAge(doc, mcx(cx,134), mcx(cx,135));
        5:
          cmd := F0981NoAttic(doc, mcx(cx,160));
        6:
          cmd := F0981AgeToYear(doc, mcx(cx,135), mcx(cx,134));
        7:
          cmd := ClearCheckMark(doc, mcx(CX, 160));    //make sure No Attic is not checked
        8:
          cmd := ClearCheckMark(doc, mcx(CX, 199));    //make sure No garage is not checked
        9:
          cmd := F0981DOMUnknown(doc, cx);
        10:
          cmd := F0981CalcDOM(doc, cx);                //to do
        11:
          cmd := F0981CalcBsmtArea(doc, cx);
        12:
          cmd := 0;   //transfer contract date/price to contract section
        13:
          cmd := 0;   //if view 1 Other skip to next cell
        14:
          cmd := 0;    //if view 2 Other skip to next cell
        15:
          cmd := 0;   //If Loc 1 Other skip to next cell
        16:
          cmd := 0;   //if Loc 2 Other skip to netx cell
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0982Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0983Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

end.
