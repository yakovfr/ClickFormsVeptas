unit UMathResid2;

{  ClickForms Application                 }
{  Bradford Technologies, Inc.            }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmTestURAR1004B       = 200;
  fmTestURAR1004D       = 54;
  fmTestFNMA1025        = 64;
  fmTestFNMA1025XLists  = 77;
  fmTestFNMA1025XComps  = 145;
  fmTestFNMA1025XRents  = 146;

  fmTestFNMA1073        = 56;
  fmTestFNMA1075        = 57;
  fmTestFNMA1073XComp   = 60;
  fmTestFNMA2000        = 63;
  fmTestFNMA2000XComps  = 143;
  fmTestFNMA2000A       = 62;
  fnTestFNMA2000AXComps = 69;

  fmTestURAR1004        = 52;
  fmTestFNMA2055        = 55;
  fmTestURARXComps      = 58;
  fmTestFNMA1004C       = 147;

  fmPrivateReport       = 297;

  function ProcessForm0052Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0055Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0058Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0147Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0056Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0057Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0060Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0063Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0143Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0062Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
  function ProcessForm0069Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;

  function ProcessForm0200Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0054Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0064Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0077Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0145Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0146Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0297Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;

  
function ProcessForm0200Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

function ProcessForm0054Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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

function F0145CompsC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 52;
  TotalAdj  = 106;
  FinalAmt  = 107;
  PlusChk   = 104;
  NegChk    = 105;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,74), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,76), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,81), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
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

function F0145CompsC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 116;
  TotalAdj  = 170;
  FinalAmt  = 171;
  PlusChk   = 168;
  NegChk    = 169;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,141), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);

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

function F0145CompsC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 180;
  TotalAdj  = 234;
  FinalAmt  = 235;
  PlusChk   = 232;
  NegChk    = 233;
  InfoNet   = 8;
  InfoGross = 9;
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
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,202), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,204), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,225), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,227), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,229), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,231), NetAdj, GrsAdj);

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

function F0064CompsC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 42;
  TotalAdj  = 96;
  FinalAmt  = 97;
  PlusChk   = 94;
  NegChk    = 95;
  InfoNet   = 4;
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
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,66), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,83), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,85), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,87), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,89), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,91), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);

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

function F0064CompsC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 105;
  TotalAdj  = 159;
  FinalAmt  = 160;
  PlusChk   = 157;
  NegChk    = 158;
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
  GetNetGrosAdjs(doc, mcx(cx,125), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,127), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);

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

function F0064CompsC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 168;
  TotalAdj  = 222;
  FinalAmt  = 223;
  PlusChk   = 220;
  NegChk    = 221;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,179), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,181), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,188), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,192), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,197), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);

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

function F0064RentsC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 120;  //monthly rent
  TotalAdj  = 159;
  FinalAmt  = 160;
  PlusChk   = 157;
  NegChk    = 158;
  InfoNet   = 2;
  InfoGross = 3;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,129), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,131), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,133), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);

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

function F0064RentsC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 164;  //monthly rent
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
  GetNetGrosAdjs(doc, mcx(cx,166), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,175), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,177), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,186), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,190), NetAdj, GrsAdj);
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

function F0064RentsC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 208;  //monthly rent
  TotalAdj  = 247;
  FinalAmt  = 248;
  PlusChk   = 245;
  NegChk    = 246;
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
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,226), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,230), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,244), NetAdj, GrsAdj);

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

function F0064SalePerUnit(doc: TContainer; CX: CellUID; CS, TR1,TR2,TR3,TR4, CR: Integer): Integer;
var
  nUnits: Integer;
  SV, VR: Double;
begin
  result := 0;
  nUnits := 0;
  if GetCellValue(doc,mcx(CX,TR1)) > 0 then
    inc(nUnits);
  if GetCellValue(doc,mcx(CX,TR2)) > 0 then
    inc(nUnits);
  if GetCellValue(doc,mcx(CX,TR3)) > 0 then
    inc(nUnits);
  if GetCellValue(doc,mcx(CX,TR4)) > 0 then
    inc(nUnits);

  SV := GetCellValue(doc, mcx(cx,CS));
  if (SV <> 0) and (nUnits > 0) then
    begin
      VR := SV / nUnits;
      result := SetCellValue(doc, mcx(cx,CR), VR);
    end;
end;

function F0064SalePerRoom(doc: TContainer; CX: CellUID; CS, U1,U2,U3,U4, CR: Integer): Integer;
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


function F0146RentsC1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 46;  //monthly rent
  TotalAdj  = 85;
  FinalAmt  = 86;
  PlusChk   = 83;
  NegChk    = 84;
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
  GetNetGrosAdjs(doc, mcx(cx,55), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,57), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,59), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,68), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,72), NetAdj, GrsAdj);
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

function F0146RentsC2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 91;  //monthly rent
  TotalAdj  = 130;
  FinalAmt  = 131;
  PlusChk   = 128;
  NegChk    = 129;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,93), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,95), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,97), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,105), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,109), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
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

function F0146RentsC3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 136;  //monthly rent
  TotalAdj  = 175;
  FinalAmt  = 176;
  PlusChk   = 173;
  NegChk    = 174;
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
  GetNetGrosAdjs(doc, mcx(cx,145), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,147), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,149), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,162), NetAdj, GrsAdj);
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

function F0064AnnualVacancy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,292));
  V2 := GetCellValue(doc, mcx(cx,296));
  VR := V1 * V2 * 0.12;   {.01 * 12 months}
  result := SetCellValue(doc, mcx(cx,297), VR);
end;

//1025 2-4 2004 Verison
function ProcessForm0064Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1,2:
          cmd := F0064RentsC1Adjustments(doc,CX);
        4,5:
          cmd := F0064RentsC2Adjustments(doc,CX);
        7,8:
          cmd := F0064RentsC3Adjustments(doc,CX);
            
        10:  //C1 sale price
          begin
            ProcessForm0064Math(doc, 25, CX);   //sale per rent
            ProcessForm0064Math(doc, 29, CX);   //sale per units
            ProcessForm0064Math(doc, 33, CX);   //sale per rooms
            ProcessForm0064Math(doc, 54, CX);   //sale per sqft
            ProcessForm0064Math(doc, 51, CX);   //sale per bedrooms
            cmd := ProcessForm0064Math(doc, 11, CX);   //adjustments
          end;
        11:
          cmd := F0064CompsC1Adjustments(doc,CX);
        12:
          begin   //show C1
            ProcessForm0064Math(doc, 57, CX);
            ProcessForm0064Math(doc, 58, CX);
            ProcessForm0064Math(doc, 59, CX);
            ProcessForm0064Math(doc, 60, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
        13:  //C2 sale price
          begin
            ProcessForm0064Math(doc, 26, CX);   //sale per rent
            ProcessForm0064Math(doc, 30, CX);   //sale per units
            ProcessForm0064Math(doc, 34, CX);   //sale per rooms
            ProcessForm0064Math(doc, 55, CX);   //sale per sqft
            ProcessForm0064Math(doc, 52, CX);   //sale per bedrooms
            cmd := ProcessForm0064Math(doc, 14, CX);   //adjustments
          end;
        14:
          cmd := F0064CompsC2Adjustments(doc,CX);
        15:
          begin   //show C2
            ProcessForm0064Math(doc, 61, CX);
            ProcessForm0064Math(doc, 62, CX);
            ProcessForm0064Math(doc, 63, CX);
            ProcessForm0064Math(doc, 64, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
        16:  //C3 sale price
          begin
            ProcessForm0064Math(doc, 27, CX);   //sale per rent
            ProcessForm0064Math(doc, 31, CX);   //sale per units
            ProcessForm0064Math(doc, 35, CX);   //sale per rooms
            ProcessForm0064Math(doc, 56, CX);   //sale per sqft
            ProcessForm0064Math(doc, 53, CX);   //sale per sqft
            cmd := ProcessForm0064Math(doc, 17, CX);   //adjustments
          end;
        17:
          cmd := F0064CompsC3Adjustments(doc,CX);
        18:
          begin  //show C3
            ProcessForm0064Math(doc, 65, CX);
            ProcessForm0064Math(doc, 66, CX);
            ProcessForm0064Math(doc, 67, CX);
            ProcessForm0064Math(doc, 68, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
        //sale per rent (rent multiplier)
        24:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,9), mcx(cx,10));    //sub rent chged
        25:
          cmd := DivideAB(doc, mcx(cx,42), mcx(cx,44), mcx(cx,45));    //C1 rent chged
        26:
          cmd := DivideAB(doc, mcx(cx,105), mcx(cx,107), mcx(cx,108));    //C2 rent chged
        27:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,170), mcx(cx,171));    //C3 rent chged
        //sales per unit
        28:
          cmd := F0064SalePerUnit(doc, cx, 7, 20,23,26,29, 11);  //sub units chged
        29:
          cmd := F0064SalePerUnit(doc, cx, 42, 68,72,76,80, 46);  //C1 units chged
        30:
          cmd := F0064SalePerUnit(doc, cx, 105, 131,135,139,143, 109);  //C2 units chged
        31:
          cmd := F0064SalePerUnit(doc, cx, 168, 194,198,202,206, 172);  //C3 units chged
        //sales per room
        32:
          cmd := F0064SalePerRoom(doc, cx, 7, 20,23,26,29, 12);  //sub rooms chged
        33:
          cmd := F0064SalePerRoom(doc, cx, 42, 68,72,76,80, 47);  //C1 rooms chged
        34:
          cmd := F0064SalePerRoom(doc, cx, 105, 131,135,139,143, 110);  //C2 rooms chged
        35:
          cmd := F0064SalePerRoom(doc, cx, 168, 194,198,202,206, 173);  //C3 rooms chged
        //sqft changed
        36:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,19), mcx(cx,8));   //sub sqft chged
        37:                //C1 sqft chged
          begin
            ProcessForm0064Math(doc, 54, CX);
            ProcessForm0064Math(doc, 57, CX);
            cmd := 0;
          end;
        38:  //C2 sqft chged
          begin
            ProcessForm0064Math(doc, 55, CX);
            ProcessForm0064Math(doc, 61, CX);
            cmd := 0;
          end;
        39:   //C3 sqft chged
          begin
            ProcessForm0064Math(doc, 56, CX);
            ProcessForm0064Math(doc, 65, CX);
            cmd := 0;
          end;
        //bedrooms canged
        40:
          cmd := F0064SalePerRoom(doc, cx, 7, 21,24,27,30, 13);  //sub bedrooms chged
        41: //C1 bedrooms chged
          begin
            ProcessForm0064Math(doc, 51, CX);
            ProcessForm0064Math(doc, 60, CX);
            cmd := 0;
          end;
        42: //C2 bedrooms chged
          begin
            ProcessForm0064Math(doc, 52, CX);
            ProcessForm0064Math(doc, 64, CX);
            cmd := 0;
          end;
        43: //C3 bedrooms chged
          begin
            ProcessForm0064Math(doc, 53, CX);
            ProcessForm0064Math(doc, 68, CX);
            cmd := 0;
          end;
        //total rooms chged
        46:              //sub rooms chged
          begin
            ProcessForm0064Math(doc, 28, CX);
            ProcessForm0064Math(doc, 32, CX);
            cmd := 0;
          end;
        47:              //C1 rooms chged
          begin
            ProcessForm0064Math(doc, 29, CX);
            ProcessForm0064Math(doc, 33, CX);
            ProcessForm0064Math(doc, 58, CX);
            ProcessForm0064Math(doc, 59, CX);
            cmd := 0;
          end;
        48:              //C2 rooms chged
          begin
            ProcessForm0064Math(doc, 30, CX);
            ProcessForm0064Math(doc, 34, CX);
            ProcessForm0064Math(doc, 62, CX);
            ProcessForm0064Math(doc, 63, CX);
            cmd := 0;
          end;
        49:              //C3 rooms chged
          begin
            ProcessForm0064Math(doc, 31, CX);
            ProcessForm0064Math(doc, 35, CX);
            ProcessForm0064Math(doc, 66, CX);
            ProcessForm0064Math(doc, 67, CX);
            cmd := 0;
          end;
        50:
          begin
            CX.Pg := 2; //comps on Page 3
            F0064CompsC1Adjustments(doc,CX);
            F0064CompsC2Adjustments(doc,CX);
            F0064CompsC3Adjustments(doc,CX);
            cmd := 0;
          end;
        51: //C1 sale Price per bedroom
          cmd := F0064SalePerRoom(doc, cx, 42, 69,73,77,81, 48);  //C1 bedrooms chged
        52:  //C2 sale Price per bedroom
          cmd := F0064SalePerRoom(doc, cx, 105, 132,136,140,144, 111);  //C2 bedrooms chged
        53: //C3 sale Price per bedroom
          cmd := F0064SalePerRoom(doc, cx, 168, 195,199,203,207, 174);  //C3 bedrooms chged
        54:  //C1 sale Price per GBA
          cmd := DivideAB(doc, mcx(cx,42), mcx(cx,65), mcx(cx,43));    //sub sqft chged
        55:  //C2 sale Price per GBA
          cmd := DivideAB(doc, mcx(cx,105), mcx(cx,128), mcx(cx,106));   //C2 sqft chged
        56:  //C3 sale Price per GBA
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,191), mcx(cx,169));   //C3 sqft chged
        57: //C1 Ajusted price per GBA
          cmd := DivideAB(doc,mcx(CX,97),mcx(CX,65),mcx(CX,98));
        58:  //C1 Ajusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 97, 68,72,76,80, 99);
        59: //C1 Ajusted price per room
            cmd := F0064SalePerRoom(doc, cx, 97, 68,72,76,80, 100);
        60: //C1 Ajusted price per bedroom
            cmd := F0064SalePerRoom(doc, cx, 97, 69,73,77,81, 101);
        61: //C2 Ajusted price per GBA
          cmd := DivideAB(doc,mcx(CX,160),mcx(CX,128),mcx(CX,161));
        62: //C2 Ajusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 160, 131,135,139,143, 162);
        63:  //C2 Ajusted price per room
            cmd := F0064SalePerRoom(doc, cx, 160, 131,135,139,143, 163);
        64: //C2 Ajusted price per bedroom
            cmd := F0064SalePerRoom(doc, cx, 160, 132,136,140,144, 164);
        65: //C3 Ajusted price per GBA
            cmd := DivideAB(doc,mcx(CX,223),mcx(CX,191),mcx(CX,224));
        66: //C3 Ajusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 223, 194,198,202,206, 225);
        67: //C3 Ajusted price per room
            cmd := F0064SalePerRoom(doc, cx, 223, 194,198,202,206, 226);
        68: //C3 Ajusted price per bedroom
            cmd := F0064SalePerRoom(doc, cx, 223, 195,199,203,207, 227);

        //actual and estimated rents
        69:
          Cmd := SumSixCellsR(doc, cx, 254,262,270,278,287,0, 291);  //est rents
        70:
          Cmd := SumSixCellsR(doc, cx, 257,265,273,281,290,0, 292);  //act rents
        71:
          cmd := SumAB(Doc, mcx(cx,242), mcx(cx,244), mcx(cx,249));   //sum total gross rent
        72:
          begin
            ProcessForm0064Math(doc, 71, CX);   //total gross rent
            cmd := F0064AnnualVacancy(doc, cx); //calc annual vacancy
          end;
        73:
          cmd := F0064AnnualVacancy(doc, cx);   //calc annual vacancy

        //values per units
        74:
          Cmd := MultAB(doc, mcx(cx,228), mcx(cx,229), mcx(cx,230));
        75:
          Cmd := MultAB(doc, mcx(cx,231), mcx(cx,232), mcx(cx,233));
        76:
          Cmd := MultAB(doc, mcx(cx,234), mcx(cx,235), mcx(cx,236));
        77:
          Cmd := MultAB(doc, mcx(cx,237), mcx(cx,238), mcx(cx,239));

        78:
          Cmd := MultAB(doc, mcx(cx,241), mcx(cx,242), mcx(cx,243));

        80:
          Cmd := PickValueAOrB(doc, mcx(cx,252), mcx(cx,253), mcx(cx,254));
        81:
          Cmd := PickValueAOrB(doc, mcx(cx,260), mcx(cx,261), mcx(cx,262));
        82:
          Cmd := PickValueAOrB(doc, mcx(cx,268), mcx(cx,269), mcx(cx,270));
        83:
          Cmd := PickValueAOrB(doc, mcx(cx,276), mcx(cx,277), mcx(cx,278));
        84:
          Cmd := PickValueAOrB(doc, mcx(cx,285), mcx(cx,286), mcx(cx,287));

        85:
          Cmd := PickValueAOrB(doc, mcx(cx,255), mcx(cx,256), mcx(cx,257));
        86:
          Cmd := PickValueAOrB(doc, mcx(cx,263), mcx(cx,264), mcx(cx,265));
        87:
          Cmd := PickValueAOrB(doc, mcx(cx,271), mcx(cx,272), mcx(cx,273));
        88:
          Cmd := PickValueAOrB(doc, mcx(cx,279), mcx(cx,280), mcx(cx,281));
        89:
          Cmd := PickValueAOrB(doc, mcx(cx,288), mcx(cx,289), mcx(cx,290));
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of
      -2:
        begin
          ProcessForm0064Math(doc, 50, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0145Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 48,112,176);
        2:
           Cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 48,112,176, 2);

         5:  //C1 sale price
          begin
            ProcessForm0145Math(doc, 20, CX);   //sale per rent
            ProcessForm0145Math(doc, 24, CX);   //sale per units
            ProcessForm0145Math(doc, 46, CX);   //sale per sqft
            ProcessForm0145Math(doc, 32, CX);   //sale per rooms
            ProcessForm0145Math(doc, 49, CX);   //sale per bedrooms
            cmd := ProcessForm0145Math(doc, 6, CX);   //adjustments
          end;
        6:
          cmd := F0145CompsC1Adjustments(doc,CX);
        7:
          begin    //show C1
            ProcessForm0145Math(doc, 52, CX);
            ProcessForm0145Math(doc, 53, CX);
            ProcessForm0145Math(doc, 54, CX);
            ProcessForm0145Math(doc, 55, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
        8:  //C2 sale price
          begin
            ProcessForm0145Math(doc, 21, CX);   //sale per rent
            ProcessForm0145Math(doc, 25, CX);   //sale per units
            ProcessForm0145Math(doc, 47, CX);     //sale per sqft
            ProcessForm0145Math(doc, 33, CX);    //sale per rooms
            ProcessForm0145Math(doc, 50, CX);   //sale per bedrooms
            cmd := ProcessForm0145Math(doc, 9, CX);   //adjustments
          end;
        9:
          cmd := F0145CompsC2Adjustments(doc,CX);
        10:
          begin   //show C2
            ProcessForm0145Math(doc, 56, CX);
            ProcessForm0145Math(doc, 57, CX);
            ProcessForm0145Math(doc, 58, CX);
            ProcessForm0145Math(doc, 59, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
        11:  //C3 sale price
          begin
            ProcessForm0145Math(doc, 28, CX);   //sale per rent
            ProcessForm0145Math(doc, 32, CX);   //sale per units
            ProcessForm0145Math(doc, 48, CX);   //sale per sqft
            ProcessForm0145Math(doc, 34, CX);   //sale per rooms
            ProcessForm0145Math(doc, 51, CX);   //sale per bedrooms
            cmd := ProcessForm0145Math(doc, 12, CX);   //adjustments
          end;
        12:
          cmd := F0145CompsC3Adjustments(doc,CX);
        13:
          begin  //show C3
            ProcessForm0145Math(doc, 60, CX);
            ProcessForm0145Math(doc, 61, CX);
            ProcessForm0145Math(doc, 62, CX);
            ProcessForm0145Math(doc, 63, CX);
            cmd := CalcWeightedAvg(doc,[64,145]);
          end;
         //sale per rent (rent multiplier)
        19:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,18), mcx(cx,19));    //sub rent chged
        20:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,54), mcx(cx,55));    //C1 rent chged
        21:
          cmd := DivideAB(doc, mcx(cx,116), mcx(cx,118), mcx(cx,119));    //C2 rent chged
        22:
          cmd := DivideAB(doc, mcx(cx,180), mcx(cx,182), mcx(cx,183));    //C3 rent chged
        //sale per unit
        23:
          cmd := F0064SalePerUnit(doc, cx, 16, 29,32,35,38, 20);  //sub units chged
        24:
          cmd := F0064SalePerUnit(doc, cx, 52, 78,82,86,90, 56);  //C1 units chged
        25:
          cmd := F0064SalePerUnit(doc, cx, 116, 142,146,150,154, 120);  //C2 units chged
        26:
          cmd := F0064SalePerUnit(doc, cx, 180, 206,210,2142,218, 184);  //C3 units chged
        //sales per sqft
        27:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,28), mcx(cx,17));   //sub sqft chged
        28:   //C1 sqft chged
          begin
            ProcessForm0145Math(doc, 46, CX);
            ProcessForm0145Math(doc, 52, CX);
            cmd := 0;
          end;
        29:  //C2 sqft chged
           begin
            ProcessForm0145Math(doc, 47, CX);
            ProcessForm0145Math(doc, 56, CX);
            cmd := 0;
          end;
        30: //C3 sqft chged
           begin
            ProcessForm0145Math(doc, 48, CX);
            ProcessForm0145Math(doc, 60, CX);
            cmd := 0;
          end;
        //sales per room
        31:
          cmd := F0064SalePerRoom(doc, cx, 16, 20,23,26,29, 21);  //sub rooms chged
        32:
          cmd := F0064SalePerRoom(doc, cx, 52, 78,82,86,90, 57);  //C1 rooms chged
        33:
          cmd := F0064SalePerRoom(doc, cx, 116, 142,146,150,154, 121);  //C2 rooms chged
        34:
          cmd := F0064SalePerRoom(doc, cx, 180, 206,210,214,218, 185);  //C3 rooms chged
        //sales per bedrooms
        35:
          cmd := F0064SalePerRoom(doc, cx, 16, 30,33,36,39, 22);  //sub bedrooms chged
        36: //C1 bedrooms chged
          begin
            ProcessForm0145Math(doc, 49, CX);
            ProcessForm0145Math(doc, 55, CX);
            cmd := 0;
          end;
        37: //C2 bedrooms chged
          begin
            ProcessForm0145Math(doc, 50, CX);
            ProcessForm0145Math(doc, 59, CX);
            cmd := 0;
          end;
        38: //C3 bedrooms chged
          begin
            ProcessForm0145Math(doc, 51, CX);
            ProcessForm0145Math(doc, 63, CX);
            cmd := 0;
          end;
         //total rooms chged
        41:              //sub rooms chged
          begin
            ProcessForm0145Math(doc, 23, CX);
            ProcessForm0145Math(doc, 31, CX);
            cmd := 0;
          end;
        42:              //C1 rooms chged
          begin
            ProcessForm0145Math(doc, 24, CX);
            ProcessForm0145Math(doc, 32, CX);
            ProcessForm0145Math(doc, 53, CX);
            ProcessForm0145Math(doc, 54, CX);
            cmd := 0;
          end;
        43:              //C2 rooms chged
          begin
            ProcessForm0145Math(doc, 25, CX);
            ProcessForm0145Math(doc, 33, CX);
            ProcessForm0145Math(doc, 57, CX);
            ProcessForm0145Math(doc, 58, CX);
            cmd := 0;
          end;
        44:              //C3 rooms chged
          begin
            ProcessForm0145Math(doc, 26, CX);
            ProcessForm0145Math(doc, 34, CX);
            ProcessForm0145Math(doc, 61, CX);
            ProcessForm0145Math(doc, 62, CX);
            cmd := 0;
          end;
        45:
          begin
            F0145CompsC1Adjustments(doc,CX);
            F0145CompsC2Adjustments(doc,CX);
            F0145CompsC3Adjustments(doc,CX);
            cmd := 0;
          end;
        46:  //C1 Sales Prive per GBA
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,75), mcx(cx,53));    //C1 sqft chged
        47:  //C2 Sales Prive per GBA
          cmd := DivideAB(doc, mcx(cx,116), mcx(cx,139), mcx(cx,117));   //C2 sqft chged
        48:  //C3 Sales Prive per GBA
          cmd := DivideAB(doc, mcx(cx,180), mcx(cx,203), mcx(cx,181));   //C3 sqft chged
        49: //C1 Sales Prive per bedrooms
          cmd := F0064SalePerRoom(doc, cx, 52, 79,83,87,91, 58);  //C1 bedrooms chged
        50: //C2 Sales Prive per bedrroms
          cmd := F0064SalePerRoom(doc, cx, 116, 143,147,151,155, 122);  //C2 bedrooms chged
        51: //C3 Sales Prive per bedrooms
          cmd := F0064SalePerRoom(doc, cx, 180, 207,211,215,219, 186);  //C3 bedrooms chged
        52: //C1 Adjusted price per GBA
          cmd := DivideAB(doc,mcx(CX,107),mcx(CX,75),mcx(CX,108));
        53: //C1 Adjusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 107, 78,82,86,90, 109);
        54: //C1 Adjusted price per rooms
            cmd := F0064SalePerRoom(doc, cx, 107, 78,82,86,90, 110);
        55:  //C1 Adjusted price per bedrooms
            cmd := F0064SalePerRoom(doc, cx, 107, 79,83,87,91, 111);
        56: //C2 Adjusted price per GBA
          cmd := DivideAB(doc,mcx(CX,171),mcx(CX,139),mcx(CX,172));
        57: //C2 Adjusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 171, 142,146,150,154, 173);
        58: //C2 Adjusted price per rooms
            cmd := F0064SalePerRoom(doc, cx, 171, 142,146,150,154, 174);
        59: //C2 Adjusted price per bedrooms
            cmd := F0064SalePerRoom(doc, cx, 171, 143,147,151,155, 175);
        60: //C3 Adjusted price per GBA
            cmd := DivideAB(doc,mcx(CX,235),mcx(CX,203),mcx(CX,236));
        61: //C3 Adjusted price per unit
            cmd := F0064SalePerUnit(doc, cx, 235, 206,210,214,218, 237);
        62: //C3 Adjusted price per rooms
            cmd := F0064SalePerRoom(doc, cx, 235, 206,210,214,218, 238);
        63: //C3 Adjusted price per bedrooms
            cmd := F0064SalePerRoom(doc, cx, 235, 207,211,215,219, 239);

        64:
          cmd := ConfigXXXInstance(doc, cx, 48,112,176);

        65:
          Cmd := MultAB(doc, mcx(cx,240), mcx(cx,241), mcx(cx,242));
        66:
          Cmd := MultAB(doc, mcx(cx,243), mcx(cx,244), mcx(cx,245));
        67:
          Cmd := MultAB(doc, mcx(cx,246), mcx(cx,247), mcx(cx,248));
        68:
          Cmd := MultAB(doc, mcx(cx,249), mcx(cx,250), mcx(cx,251));

      else
        Cmd := 0;
      end;
    until Cmd = 0
   else
    case Cmd of
      -2:
        begin
          ProcessForm0145Math(doc, 45, CX);
        end;
    end;
  result := 0;
end;

function ProcessForm0077Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 37,58,79);
        2,3,4:
          Cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 37,58,79, 2);
        5:
          Cmd := ConfigXXXInstance(doc, cx, 37,58,79);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0146Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 42,87,132);
        2,3,4:
           Cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS','', 42,87,132, 2);

        5,6:
          cmd := F0146RentsC1Adjustments(doc,CX);
        8,9:
          cmd := F0146RentsC2Adjustments(doc,CX);
        11,12:
          cmd := F0146RentsC3Adjustments(doc,CX);

        14:
          Cmd := ConfigXXXInstance(doc, cx, 42,87,132);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
    
  result := 0;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0062Process5Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0062Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0062Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0062Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0062Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0062Math(doc, C5, CX);
  result := 0;
end;

function F0062C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 51;
   TotalAdj = 105;
   FinalAmt = 106;
   PlusChk = 103;
   NegChk = 104;
   InfoNet = 4;
   InfoGross = 5;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 65), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 67), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 69), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 71), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 73), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 75), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 84), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 88), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 92), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 94), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 96), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 98), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 100), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 102), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0062C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 114;
   TotalAdj = 168;
   FinalAmt = 169;
   PlusChk = 166;
   NegChk = 167;
   InfoNet = 6;
   InfoGross = 7;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 124), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 126), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 128), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 130), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 132), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 134), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 136), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 138), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 139), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 143), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 147), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 151), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 155), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 157), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 159), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 161), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 163), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 165), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0062C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 177;
   TotalAdj = 231;
   FinalAmt = 232;
   PlusChk = 229;
   NegChk = 230;
   InfoNet = 8;
   InfoGross = 9;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 187), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 189), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 191), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 193), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 195), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 197), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 199), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 201), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 202), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 206), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 210), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 214), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 218), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 220), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 222), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 224), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 226), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 228), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0069Process5Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4,C5: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0069Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0069Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0069Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0069Math(doc, C4, CX);
  if C5 > 0 then ProcessForm0069Math(doc, C5, CX);
  result := 0;
end;

function F0069C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 51;
   TotalAdj = 105;
   FinalAmt = 106;
   PlusChk = 103;
   NegChk = 104;
   InfoNet = 4;
   InfoGross = 5;
var
   NetAdj, GrsAdj : Double;
   saleValue,  NetPct,  GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 65), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 67), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 69), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 71), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 73), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 75), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 84), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 88), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 92), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 94), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 96), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 98), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 100), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 102), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0069C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 115;
   TotalAdj = 169;
   FinalAmt = 170;
   PlusChk = 167;
   NegChk = 168;
   InfoNet = 6;
   InfoGross = 7;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct,  GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 125), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 127), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 129), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 131), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 133), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 135), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 137), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 139), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 140), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 144), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 148), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 158), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 160), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 162), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 164), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 166), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0069C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 179;
   TotalAdj = 233;
   FinalAmt = 234;
   PlusChk = 231;
   NegChk = 232;
   InfoNet = 8;
   InfoGross = 9;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 189), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 191), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 193), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 195), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 197), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 199), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 201), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 203), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 204), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 208), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 212), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 216), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 220), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 222), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 224), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 226), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 228), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 230), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0143C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 41;
   TotalAdj = 85;
   FinalAmt = 86;
   PlusChk = 83;
   NegChk = 84;
   InfoNet = 2;
   InfoGross = 3;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 46), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 48), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 50), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 52), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 54), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 56), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 58), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 64), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 68), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 70), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 72), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 74), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 78), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 82), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;
   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0143C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 91;
   TotalAdj = 135;
   FinalAmt = 136;
   PlusChk = 133;
   NegChk = 134;
   InfoNet = 4;
   InfoGross = 5;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 96), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 98), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 100), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 102), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 104), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 106), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 108), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 111), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 113), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 114), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 118), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 120), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 122), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 124), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 126), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 128), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 130), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 132), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0143C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
  SalesAmt = 141;
  TotalAdj = 185;
  FinalAmt = 186;
  PlusChk = 183;
  NegChk = 184;
  InfoNet = 6;
  InfoGross = 7;
var
  NetAdj, GrsAdj : Double;
  saleValue, NetPct, GrsPct : Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx, 146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 158), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 180), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx, 182), NetAdj, GrsAdj);

  SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
  if (NetAdj >= 0) then
    SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
  else
    SetCellChkMark(doc, mcx(cx, NegChk), True);

  saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
  if saleValue <> 0 then
  begin
    NetPct := (NetAdj / saleValue) * 100;
    GrsPct := (GrsAdj / saleValue) * 100;

    UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
    UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

    SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
    SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
  end;

  Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0056C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
  SalesAmt = 41;
  TotalAdj = 100;
  FinalAmt = 101;
  PlusChk = 98;
  NegChk = 99;
  InfoNet = 1;
  InfoGross = 2;
var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 47), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 49), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 51), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 53), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 55), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 57), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 59), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 65), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 67), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 69), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 71), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 74), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 78), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 81), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 85), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 87), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 89), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 91), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 93), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 95), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 97), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0056C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 106;
   TotalAdj = 165;
   FinalAmt = 166;
   PlusChk = 163;
   NegChk = 164;
   InfoNet = 3;
   InfoGross = 4;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 112), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 114), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 116), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 118), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 120), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 122), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 124), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 126), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 128), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 130), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 132), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 134), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 136), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 139), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 141), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 143), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 145), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 146), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 150), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 154), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 158), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 160), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 162), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0056C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 171;
   TotalAdj = 230;
   FinalAmt = 231;
   PlusChk = 228;
   NegChk = 229;
   InfoNet = 5;
   InfoGross = 6;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 177), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 179), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 181), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 183), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 185), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 187), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 189), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 191), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 193), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 195), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 197), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 199), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 201), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 204), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 206), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 208), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 210), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 211), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 215), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 217), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 219), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 221), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 223), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 225), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 227), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0060C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 51;
   TotalAdj = 110;
   FinalAmt = 111;
   PlusChk = 108;
   NegChk = 109;
   InfoNet = 2;
   InfoGross = 3;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 57), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 59), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 65), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 67), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 69), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 71), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 73), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 75), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 77), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 79), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 81), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 84), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 86), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 88), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 90), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 91), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 95), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 97), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 99), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 101), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 103), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 105), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 107), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0060C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 117;
   TotalAdj = 176;
   FinalAmt = 177;
   PlusChk = 174;
   NegChk = 175;
   InfoNet = 4;
   InfoGross = 5;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 123), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 125), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 127), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 129), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 131), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 133), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 135), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 137), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 139), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 141), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 143), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 145), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 147), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 150), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 154), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 157), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 161), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 163), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 165), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 167), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 169), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 171), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 173), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0060C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 183;
   TotalAdj = 242;
   FinalAmt = 243;
   PlusChk = 240;
   NegChk = 241;
   InfoNet = 6;
   InfoGross = 7;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 189), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 191), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 193), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 195), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 197), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 199), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 201), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 203), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 205), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 207), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 209), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 211), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 213), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 216), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 218), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 220), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 222), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 223), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 227), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 229), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 231), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 233), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 235), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 237), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 239), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0057C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 41;
   TotalAdj = 100;
   FinalAmt = 101;
   PlusChk = 98;
   NegChk = 99;
   InfoNet = 1;
   InfoGross = 2;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 47), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 49), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 51), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 53), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 55), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 57), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 59), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 65), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 67), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 69), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 71), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 74), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 78), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 81), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 85), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 87), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 89), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 91), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 93), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 95), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 97), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;
   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0057C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 106;
   TotalAdj = 165;
   FinalAmt = 166;
   PlusChk = 163;
   NegChk = 164;
   InfoNet = 3;
   InfoGross = 4;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 112), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 114), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 116), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 118), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 120), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 122), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 124), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 126), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 128), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 130), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 132), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 134), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 136), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 139), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 141), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 143), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 145), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 146), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 150), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 154), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 158), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 160), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 162), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0057C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 171;
   TotalAdj = 230;
   FinalAmt = 231;
   PlusChk = 228;
   NegChk = 229;
   InfoNet = 5;
   InfoGross = 6;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 177), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 179), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 181), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 183), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 185), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 187), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 189), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 191), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 193), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 195), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 197), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 199), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 201), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 204), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 206), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 208), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 210), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 215), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 217), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 219), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 221), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 223), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 225), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 227), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function F0063C1Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 41;
   TotalAdj = 85;
   FinalAmt = 86;
   PlusChk = 83;
   NegChk = 84;
   InfoNet = 2;
   InfoGross = 3;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 46), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 48), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 50), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 52), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 54), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 56), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 58), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 61), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 63), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 64), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 68), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 70), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 72), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 74), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 76), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 78), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 80), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 82), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;
   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0063C2Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 90;
   TotalAdj = 134;
   FinalAmt = 135;
   PlusChk = 132;
   NegChk = 133;
   InfoNet = 4;
   InfoGross = 5;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 95), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 97), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 99), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 101), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 103), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 105), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 107), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 110), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 112), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 113), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 117), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 119), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 121), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 123), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 125), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 127), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 129), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 131), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function F0063C3Adjustments(doc : TContainer; CX : CellUID) : Integer;
const
   SalesAmt = 139;
   TotalAdj = 183;
   FinalAmt = 184;
   PlusChk = 181;
   NegChk = 1842;
   InfoNet = 6;
   InfoGross = 7;

var
   NetAdj, GrsAdj : Double;
   saleValue, NetPct, GrsPct : Double;
begin
   NetAdj := 0;
   GrsAdj := 0;
   GetNetGrosAdjs(doc, mcx(cx, 144), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 146), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 148), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 150), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 152), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 154), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 156), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 159), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 161), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 162), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 166), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 168), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 170), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 172), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 174), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 176), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 178), NetAdj, GrsAdj);
   GetNetGrosAdjs(doc, mcx(cx, 180), NetAdj, GrsAdj);

   SetCellValue(doc, mcx(cx, TotalAdj), NetAdj); //set sum of Adj
   if (NetAdj >= 0) then
       SetCellChkMark(doc, mcx(cx, PlusChk), True) //toggle the checkmarks
   else
       SetCellChkMark(doc, mcx(cx, NegChk), True);

   saleValue := GetCellValue(doc, mcx(cx, salesAmt)); //calc the net/grs percents
   if saleValue <> 0 then
   begin
       NetPct := (NetAdj / saleValue) * 100;
       GrsPct := (GrsAdj / saleValue) * 100;

       UMath.SumOfWeightedValues := UMath.SumOfWeightedValues + (1 - GrsPct / 100) * (saleValue + NetAdj);
       UMath.SumOfWeights := UMath.SumOfWeights + (1 - GrsPct / 100);

       SetInfoCellValue(doc, mcx(cx, infoNet), NetPct);
       SetInfoCellValue(doc, mcx(cx, infoGross), GrsPct); //set the info cells
   end;

   Result := SetCellValue(doc, mcx(cx, FinalAmt), saleValue + NetAdj); //set final adj price
end;

function ProcessForm0056Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        //  Comparable 1 calcs
        1:                                 //sales price changed
           begin
               ProcessForm0056Math(doc, 3, CX);         //calc new price/sqft
               Cmd := F0056C1Adjustments(doc, cx);      //redo the adjustments
           end;
        2: cmd := F0056C1Adjustments(doc, cx); //any individual adjustment

        //  Comparable 2 calcs
        4:                                 //sales price changed
           begin
               ProcessForm0056Math(doc, 6, CX); //calc new price/sqft
               Cmd := F0056C2Adjustments(doc, cx); //redo the adjustments
           end;
        5: cmd := F0056C2Adjustments(doc, cx); //any individual adjustment

        //  Comparable 3 calcs
        7:                                 //sales price changed
           begin
               ProcessForm0056Math(doc, 9, CX); //calc new price/sqft
               Cmd := F0056C3Adjustments(doc, cx); //redo the adjustments
           end;
        8: cmd := F0056C3Adjustments(doc, cx); //any individual adjustment

        10:  Cmd := DivideAB(doc, mcx(cx,41), mcx(cx,86), mcx(cx,42));       //C1 price/sqft
        11:  Cmd := DivideAB(doc, mcx(cx,106), mcx(cx,151), mcx(cx,107));    //C2 price/sqft
        12:  Cmd := DivideAB(doc, mcx(cx,171), mcx(cx,216), mcx(cx,172));    //C3 price/sqft
        13:  Cmd := DivideAB(doc, mcx(cx,8), mcx(cx,29), mcx(cx,9));         //subj price/sqft

        14:
          begin
            F0056C1Adjustments(doc, cx);
            F0056C2Adjustments(doc, cx);     //sum of adjs
            F0056C3Adjustments(doc, cx);
            cmd := 0;
          end;

        15: Cmd := CalcWeightedAvg(doc, [56,60]);   //calc wtAvg of main and xcomps forms

      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 2;    //math is on page 3
          ProcessForm0056Math(doc, 14, CX);
        end;
      end;

   Result := 0;
end;

function ProcessForm0060Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 46,112,178);
        2:
           Cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 46,112,178, 2);

        5: Cmd := DivideAB(doc, mcx(cx,17), mcx(cx,38), mcx(cx,18));  //Subj price/sqft

        //  Comparable 1 calcs
        6 :                                           //c1 sales price changed
          begin
            ProcessForm0060Math(doc, 9, CX);         //calc new price/sqft
            Cmd := F0060C1Adjustments(doc, cx);      //redo the adjustments
          end;
        7: cmd := F0060C1Adjustments(doc, cx);       //any individual adjustment
        9: Cmd := DivideAB(doc, mcx(cx,51), mcx(cx,96), mcx(cx,52));  //C1 price/sqft

        //  Comparable 2 calcs
        10 :                                          //sales price changed
           begin
               ProcessForm0060Math(doc, 13, CX);      //calc new price/sqft
               Cmd := F0060C2Adjustments(doc, cx);    //redo the adjustments
           end;
        11: cmd := F0060C2Adjustments(doc, cx);      //any individual adjustment
        13: Cmd := DivideAB(doc, mcx(cx,117), mcx(cx,162), mcx(cx,118));  //C2 price/sqft

        //  Comparable 3 calcs
        14 :                                          //sales price changed
           begin
               ProcessForm0060Math(doc, 17, CX);      //calc new price/sqft
               Cmd := F0060C3Adjustments(doc, cx);    //redo the adjustments
           end;
        15 : cmd := F0060C3Adjustments(doc, cx);      //any individual adjustment
        17: Cmd := DivideAB(doc, mcx(cx,183), mcx(cx,228), mcx(cx,184));  //C2 price/sqft

        19:
          Cmd := CalcWeightedAvg(doc, [56,60]);   //calc wtAvg of main and xcomps forms
        //page configuration
        20: Cmd := ConfigXXXInstance(doc, cx, 46,112,178);
        //wt avg
        21:
          begin
            F0060C1Adjustments(doc, cx);
            F0060C2Adjustments(doc, cx);     //sum of adjs
            F0060C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0060Math(doc, 21, CX);
        end;
      end;

   Result := 0;
end;

function ProcessForm0057Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := DivideAB(doc, mcx(cx,8), mcx(cx,29), mcx(cx,9));   //subj price/sqft

        //  Comparable 1 calcs
        3 :                                                     //sales price changed
          begin
            ProcessForm0057Math(doc, 6, CX);                 //calc new price/sqft
            Cmd := F0057C1Adjustments(doc, cx);              //redo the adjustments
          end;
        4: cmd := F0057C1Adjustments(doc, cx);                  //any individual adjustment
        6: Cmd := DivideAB(doc, mcx(cx,41), mcx(cx,86), mcx(cx,42));  //C1 price/sqft

        //  Comparable 2 calcs
        7 :                                                     //sales price changed
          begin
            ProcessForm0057Math(doc, 10, CX);                 //calc new price/sqft
            Cmd := F0057C2Adjustments(doc, cx);               //redo the adjustments
          end;
        8 : cmd := F0057C2Adjustments(doc, cx);                  //any individual adjustment
        10: Cmd := DivideAB(doc, mcx(cx,106), mcx(cx,151), mcx(cx,107));  //C2 price/sqft

        //  Comparable 3 calcs
        11 :                                                      //sales price changed
          begin
            ProcessForm0057Math(doc, 14, CX);                     //calc new price/sqft
            Cmd := F0057C3Adjustments(doc, cx);                 //redo the adjustments
          end;
        12 : cmd := F0057C3Adjustments(doc, cx);                  //any individual adjustment
        14: Cmd := DivideAB(doc, mcx(cx,171), mcx(cx,216), mcx(cx,172));   //C3 price/sqft


        //wt avg
        15:
          begin
            F0057C1Adjustments(doc, cx);
            F0057C2Adjustments(doc, cx);     //sum of adjs
            F0057C3Adjustments(doc, cx);
            cmd := 0;
          end;
        16:
          Cmd := CalcWeightedAvg(doc, [57,60]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 2;    //math is on page 3
          ProcessForm0057Math(doc, 15, CX);
        end;
    end;

   Result := 0;
end;

//2000 One-Unit Review Form
function ProcessForm0063Math(doc: TContainer; Cmd: Integer; CX: CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        1,2:
          Cmd := DivideAB(doc, mcx(cx,17), mcx(cx,29), mcx(cx,18));     //subj price/sqft

        //  Comparable 1 calcs
        3:                                                              //sales price changed
          begin
            ProcessForm0063Math(doc, 6, CX);                            //calc new price/sqft
            Cmd := F0063C1Adjustments(doc, cx);                         //redo the adjustments
          end;
        4: cmd := F0063C1Adjustments(doc, cx);                          //any individual adjustment
        6: Cmd := DivideAB(doc, mcx(cx,41), mcx(cx,69), mcx(cx,42));     //C1 price/sqft

        //  Comparable 2 calcs
        7:                                                              //sales price changed
          begin
            ProcessForm0063Math(doc, 10, CX);                           //calc new price/sqft
            Cmd := F0063C2Adjustments(doc, cx);                         //redo the adjustments
          end;
        8: cmd := F0063C2Adjustments(doc, cx); //any individual adjustment
        10: Cmd := DivideAB(doc, mcx(cx,90), mcx(cx,118), mcx(cx,91));    //C2 price/sqft

        //  Comparable 3 calcs
        11 :                                                            //sales price changed
          begin
            ProcessForm0063Math(doc, 14, CX);                           //calc new price/sqft
            Cmd := F0063C3Adjustments(doc, cx);                         //redo the adjustments
          end;
        12: cmd := F0063C3Adjustments(doc, cx);                         //any individual adjustment
        14: Cmd := DivideAB(doc, mcx(cx,139), mcx(cx,167), mcx(cx,140));    //C3 price/sqft

        5,9,13:
          Cmd := CalcWeightedAvg(doc, [63,143]);   //calc wtAvg of main and xcomps forms

        //wt avg
        15:
          begin
            F0063C1Adjustments(doc, cx);
            F0063C2Adjustments(doc, cx);     //sum of adjs
            F0063C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0063Math(doc, 15, CX);
        end;
    end;

   Result := 0;
end;

//2000 One Unit Review XComps
function ProcessForm0143Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 37,87,137);
        2,3,4:
          Cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 37,87,137, 2);
        5:
          Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,28), mcx(cx,17));                 //subj Price/Sqft
          
           //  Comparable 1 calcs
        6:                                                                    //sales price changed
          begin
            ProcessForm0143Math(doc, 9, CX);                                  //calc new price/sqft
            Cmd := F0143C1Adjustments(doc, cx);                               //redo the adjustments
          end;
        7:
          cmd := F0143C1Adjustments(doc, cx);                                 //any individual adjustment
        9:
          Cmd := DivideAB(doc, mcx(cx,41), mcx(cx,69), mcx(cx,42));           //C1 Price/Sqft

        //  Comparable 2 calcs
        10:                                                                   //sales price changed
          begin
            ProcessForm0143Math(doc, 13, CX);                                 //calc new price/sqft
            Cmd := F0143C2Adjustments(doc, cx);                               //redo the adjustments
          end;
        11:
          cmd := F0143C2Adjustments(doc, cx);                                 //any individual adjustment
        13:
          Cmd := DivideAB(doc, mcx(cx,91), mcx(cx,119), mcx(cx,92));          //C2 Price/Sqft

        //  Comparable 3 calcs
        14:                                                                   //sales price changed
          begin
            ProcessForm0143Math(doc, 17, CX);                                 //calc new price/sqft
            Cmd := F0143C3Adjustments(doc, cx);                               //redo the adjustments
          end;
        15:
          cmd := F0143C3Adjustments(doc, cx);                                 //any individual adjustment
        17:
          Cmd := DivideAB(doc, mcx(cx,141), mcx(cx,169), mcx(cx,142));        //c3 Price/Sqft


        8,12,16:
          Cmd := CalcWeightedAvg(doc, [63,143]);                               //calc wtAvg of main and xcomps forms

        //page configuration
        20: Cmd := ConfigXXXInstance(doc, cx, 37,87,137);
        //wt avg
        21:
          begin
            F0143C1Adjustments(doc, cx);
            F0143C2Adjustments(doc, cx);     //sum of adjs
            F0143C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0143Math(doc, 21, CX);
        end;
      end;

   Result := 0;
end;

function PricePerUnit(doc: TContainer; CX: CellUID; CP, CU1,CU2,CU3,CU4, CR: Integer): Integer;
var
  VP,V1,V2,V3,V4,VT,VR: Double;
begin
  VR := 0;
  VP := GetCellValue(doc, mcx(cx,CP));
  if GetCellValue(doc, mcx(cx,CU1)) = 0 then V1 := 0 else V1 := 1;
  if GetCellValue(doc, mcx(cx,CU2)) = 0 then V2 := 0 else V2 := 1;
  if GetCellValue(doc, mcx(cx,CU3)) = 0 then V3 := 0 else V3 := 1;
  if GetCellValue(doc, mcx(cx,CU4)) = 0 then V4 := 0 else V4 := 1;
  VT := V1 + V2 + V3 + V4;
  if VT <> 0 then VR := VP / VT;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function PricePerRoom(doc: TContainer; CX: CellUID; CP, CU1,CU2,CU3,CU4, CR: Integer): Integer;
var
  VP,V1,V2,V3,V4,VT,VR: Double;
begin
  VR := 0;
  VP := GetCellValue(doc, mcx(cx,CP));
  V1 := GetCellValue(doc, mcx(cx,CU1));
  V2 := GetCellValue(doc, mcx(cx,CU2));
  V3 := GetCellValue(doc, mcx(cx,CU3));
  V4 := GetCellValue(doc, mcx(cx,CU4));
  VT := V1 + V2 + V3 + V4;
  if VT <> 0 then VR := VP / VT;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

//2000A 2-4 Unit Review Form
function ProcessForm0062Math(doc : TContainer; Cmd : Integer; CX : CellUID) : Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
      //subject
        1:
          Cmd := F0062Process5Cmds(doc,cx, 2,29,30,4,0);                 //price
        2:
          Cmd := DivideAB(doc, mcx(cx,17), mcx(cx,28), mcx(cx,18));      //price/GBA
        3:
          Cmd := F0062Process5Cmds(doc,cx, 29,30,0,0,0);                 //units
        4:
          Cmd := PricePerRoom(doc, cx, 17, 30,33,36,39, 23);            //price per bedroom                   //rooms

      //Comp1
        5:
          Cmd := F0062Process5Cmds(doc,cx, 6,31,32,33,34);              //price
        6:
          Cmd := F0062C1Adjustments(doc, cx);                          //adjustment
        7:
          Cmd := F0062Process5Cmds(doc,cx, 34,35,0,0,0);               //price/GBA
        8:
          Cmd := F0062Process5Cmds(doc,cx, 31,32,36,37,0);             //units
        9:
          Cmd := F0062Process5Cmds(doc,cx, 33,37,0,0,0);               //rooms
        10:
          Cmd := F0062Process5Cmds(doc,cx, 35,36,37,38,27);            //adg price

      //comp2
        11:
          Cmd := F0062Process5Cmds(doc,cx, 12,41,42,43,44);            //price
        12:
          Cmd := F0062C2Adjustments(doc, cx);                          //adjustment
        13:
          Cmd := F0062Process5Cmds(doc,cx, 44,45,0,0,0);               //price/GBA
        14:
          Cmd := F0062Process5Cmds(doc,cx, 41,42,46,47,0);             //units
        15:
          Cmd := F0062Process5Cmds(doc,cx, 43,47,0,0,0);               //rooms
        16:
          Cmd := F0062Process5Cmds(doc,cx, 45,46,47,48,27);            //adg price

      //Comp3
        17:
          Cmd := F0062Process5Cmds(doc,cx, 18,51,52,53,54);            //price
        18:
          Cmd := F0062C3Adjustments(doc, cx);                          //adjustment
        19:
          Cmd := F0062Process5Cmds(doc,cx, 54,55,0,0,0);               //price/GBA
        20:
          Cmd := F0062Process5Cmds(doc,cx, 51,52,56,57,0);             //units
        21:
          Cmd := F0062Process5Cmds(doc,cx, 53,57,0,0,0);               //rooms
        22:
          Cmd := F0062Process5Cmds(doc,cx, 55,56,57,58,27);            //adg price

      //Values per unit...
        23:
          Cmd := MultAB(doc, mcx(cx,237), mcx(cx,238), mcx(cx,239));
        24:
          Cmd := MultAB(doc, mcx(cx,240), mcx(cx,241), mcx(cx,242));
        25:
          Cmd := MultAB(doc, mcx(cx,243), mcx(cx,244), mcx(cx,245));
        26:
          Cmd := MultAB(doc, mcx(cx,246), mcx(cx,247), mcx(cx,248));

        27:
          Cmd := CalcWeightedAvg(doc, [62,69]);                          //wt avg
        28:
          begin
            F0062C1Adjustments(doc, cx);
            F0062C2Adjustments(doc, cx);     //sum of adjs
            F0062C3Adjustments(doc, cx);
            cmd := 0;
          end;

      //subj
        29:
          Cmd := PricePerUnit(doc, cx, 17, 29,32,35,38, 21);        //price per unit
        30:
          Cmd := PricePerRoom(doc, cx, 17, 29,32,35,38, 22);        //price per rooms


      //comp1
        31:
          Cmd := PricePerUnit(doc, cx, 51, 77,81,85,89, 55);        //price per unit
        32:
          Cmd := PricePerRoom(doc, cx, 51, 77,81,85,89, 56);        //price per rooms
        33:
          cmd := PricePerRoom(doc, cx, 51, 78,82,86,90, 57);        //price per bedroom
        34:
          Cmd := DivideAB(doc, mcx(cx,51), mcx(cx,74), mcx(cx,52));   //price per GBA
        35:
          cmd := DivideAB(doc, mcx(cx,106), mcx(cx,74), mcx(cx,107)); //adj price per GBA
        36:
          Cmd := PricePerUnit(doc, cx, 106, 77,81,85,89, 108);        //adj price per unit
        37:
          Cmd := PricePerRoom(doc, cx, 106, 77,81,85,89, 109);        //adj price per rooms
        38:
          cmd := PricePerRoom(doc, cx, 106, 78,82,86,90, 110);        //adj price per bedroom

      //comp2
        41:
          Cmd := PricePerUnit(doc, cx, 114, 140,144,148,152, 118);        //price per unit
        42:
          Cmd := PricePerRoom(doc, cx, 114, 140,144,148,152, 119);        //price per rooms
        43:
          cmd := PricePerRoom(doc, cx, 114, 141,145,149,153, 120);        //price per bedroom
        44:
          Cmd := DivideAB(doc, mcx(cx,114), mcx(cx,137), mcx(cx,115)); //price per BGA
        45:
          cmd := DivideAB(doc, mcx(cx,169), mcx(cx,137), mcx(cx,170)); //adj price per GBA
        46:
          Cmd := PricePerUnit(doc, cx, 169, 140,144,148,152, 171);        //adj price per unit
        47:
          Cmd := PricePerRoom(doc, cx, 169, 140,144,148,152, 172);        //adj price per rooms
        48:
          cmd := PricePerRoom(doc, cx, 169, 141,145,149,153, 173);        //adj price per bedroom

        //comp3
        51:
          Cmd := PricePerUnit(doc, cx, 177, 203,207,208,209, 55);        //price per unit
        52:
          Cmd := PricePerRoom(doc, cx, 177, 203,207,208,209, 56);        //price per rooms
        53:
          cmd := PricePerRoom(doc, cx, 177, 204,208,212,216, 57);        //price per bedroom
        54:
          Cmd := DivideAB(doc, mcx(cx,177), mcx(cx,200), mcx(cx,178));  //price per BGA
        55:
          cmd := DivideAB(doc, mcx(cx,232), mcx(cx,200), mcx(cx,233)); //adj price per GBA
        56:
          Cmd := PricePerUnit(doc, cx, 232, 203,207,208,209, 234);        //adj price per unit
        57:
          Cmd := PricePerRoom(doc, cx, 232, 203,207,208,209, 235);        //adj price per rooms
        58:
          cmd := PricePerRoom(doc, cx, 232, 204,208,212,216, 236);        //adj price per bedroom
       else
        Cmd := 0;
       end;

   until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0062Math(doc, 28, CX);
        end;
      end;

   Result := 0;
end;

//2000A Extra Comps 2-4 Unit Review Form
function ProcessForm0069Math(doc : TContainer; Cmd : Integer; CX : CellUID): Integer;
begin
  if cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 47,111,175);
        2:
          Cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 47,111,175, 2);

      //subject
        3:
          Cmd := F0069Process5Cmds(doc,cx, 32,33,4,6,0);                  //price
        4:
          Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));       //price/GBA
        5:
          Cmd := F0069Process5Cmds(doc,cx, 32,33,0,0,0);                  //units
        6:
          Cmd := PricePerRoom(doc, cx, 16, 29,32,35,38, 22);              //price per rooms                      //rooms


      //Comp1
        7:
          Cmd := F0069Process5Cmds(doc,cx, 8,41,42,43,44);            //price
        8:
          Cmd := F0069C1Adjustments(doc,cx);                          //adjustment
        9:
          Cmd := F0069Process5Cmds(doc,cx, 44,45,0,0,0);              //GBA
        10:
          Cmd := F0069Process5Cmds(doc,cx, 41,42,46,47,0);            //units
        11:
          Cmd := F0069Process5Cmds(doc,cx, 43,48,0,0,0);              //rooms
        12:
          Cmd := F0069Process5Cmds(doc,cx, 45,46,47,48,29);           //adj price

      //comp2
        13:
          Cmd := F0069Process5Cmds(doc,cx, 14,51,52,53,54);           //price
        14:
          Cmd := F0069C2Adjustments(doc, cx);                         //adjustment
        15:
          Cmd := F0069Process5Cmds(doc,cx, 54,55,0,0,0);              //GBA
        16:
          Cmd := F0069Process5Cmds(doc,cx, 51,52,56,57,0);            //units
        17:
          Cmd := F0069Process5Cmds(doc,cx, 53,58,0,0,0);              //rooms
        18:
          Cmd := F0069Process5Cmds(doc,cx, 55,56,57,58,29);           //adj price

      //Comp3
        19:
          Cmd := F0069Process5Cmds(doc,cx, 20,61,62,63,64);           //price
        20:
          Cmd := F0069C3Adjustments(doc, cx);                          //adjustment
        21:
          Cmd := F0069Process5Cmds(doc,cx, 64,65,0,0,0);               //GBA
        22:
          Cmd := F0069Process5Cmds(doc,cx, 61,62,66,67,0);             //units
        23:
          Cmd := F0069Process5Cmds(doc,cx, 63,68,0,0,0);               //rooms
        24:
          Cmd := F0069Process5Cmds(doc,cx, 65,66,67,68,29);            //adj price

      //values per units, etc
        25:
          Cmd := MultAB(doc, mcx(cx,239), mcx(cx,240), mcx(cx,241));
        26:
          Cmd := MultAB(doc, mcx(cx,242), mcx(cx,243), mcx(cx,244));
        27:
          Cmd := MultAB(doc, mcx(cx,245), mcx(cx,246), mcx(cx,247));
        28:
          Cmd := MultAB(doc, mcx(cx,248), mcx(cx,249), mcx(cx,250));

        29:
          cmd := CalcWeightedAvg(doc, [62,69]);                          //wt avg
        30:
          Cmd := ConfigXXXInstance(doc, cx, 47,111,175);
        31:
          begin
            F0069C1Adjustments(doc, cx);
            F0069C2Adjustments(doc, cx);     //sum of adjs
            F0069C3Adjustments(doc, cx);
            cmd := 0;
          end;

      //subject
        32:
          Cmd := PricePerUnit(doc, cx, 16, 28,31,34,37, 20);        //price per unit
        33:
          Cmd := PricePerRoom(doc, cx, 16, 28,31,34,37, 20);        //price per rooms


      //comp1
        41:
          Cmd := PricePerUnit(doc, cx, 51, 77,81,85,89, 55);        //price per unit
        42:
          Cmd := PricePerRoom(doc, cx, 51, 77,81,85,89, 56);        //price per rooms
        43:
          cmd := PricePerRoom(doc, cx, 51, 78,82,86,90, 57);        //price per bedroom
        44:
          Cmd := DivideAB(doc, mcx(cx,51), mcx(cx,74), mcx(cx,52));  //price per BGA
        45:
          cmd := DivideAB(doc, mcx(cx,106), mcx(cx,74), mcx(cx,107)); //adj price per GBA
        46:
          Cmd := PricePerUnit(doc, cx, 106, 77,81,85,89, 108);        //adj price per unit
        47:
          Cmd := PricePerRoom(doc, cx, 106, 77,81,85,89, 109);        //adj price per rooms
        48:
          cmd := PricePerRoom(doc, cx, 106, 78,82,86,90, 110);        //adj price per bedroom

      //comp2
        51:
          Cmd := PricePerUnit(doc, cx, 115, 141,145,149,153, 55);        //price per unit
        52:
          Cmd := PricePerRoom(doc, cx, 115, 141,145,149,153, 56);        //price per rooms
        53:
          cmd := PricePerRoom(doc, cx, 115, 142,146,150,154, 57);        //price per bedroom
        54:
          Cmd := DivideAB(doc, mcx(cx,115), mcx(cx,138), mcx(cx,116));    //price per BGA
        55:
          cmd := DivideAB(doc, mcx(cx,170), mcx(cx,138), mcx(cx,171));    //adj price per GBA
        56:
          Cmd := PricePerUnit(doc, cx, 170, 141,145,149,153, 172);        //adj price per unit
        57:
          Cmd := PricePerRoom(doc, cx, 170, 141,145,149,153, 173);        //adj price per rooms
        58:
          cmd := PricePerRoom(doc, cx, 170, 142,146,150,154, 174);        //adj price per bedroom

      //comp2
        61:
          Cmd := PricePerUnit(doc, cx, 179, 205,209,213,217, 183);        //price per unit
        62:
          Cmd := PricePerRoom(doc, cx, 179, 205,209,213,217, 184);        //price per rooms
        63:
          cmd := PricePerRoom(doc, cx, 179, 206,210,214,218, 185);        //price per bedroom
        64:
          Cmd := DivideAB(doc, mcx(cx,179), mcx(cx,202), mcx(cx,180));    //price per BGA
        65:
          cmd := DivideAB(doc, mcx(cx,234), mcx(cx,202), mcx(cx,235));    //adj price per GBA
        66:
          Cmd := PricePerUnit(doc, cx, 234, 205,209,213,217, 236);        //adj price per unit
        67:
          Cmd := PricePerRoom(doc, cx, 234, 205,209,213,217, 237);        //adj price per rooms
        68:
          cmd := PricePerRoom(doc, cx, 234, 206,210,214,218, 238);        //adj price per bedroom
       else
        Cmd := 0;
       end;

   until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0069Math(doc, 31, CX);
        end;
      end;

   Result := 0;
end;

////////////////////////////////////////////////////////////////////////////////
//
// URAR/2055 XComps           UID 58
//
////////////////////////////////////////////////////////////////////////////////
function F0058C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 41;
  TotalAdj  = 85;
  FinalAmt  = 86;
  PlusChk   = 83;
  NegChk    = 84;
  InfoNet   = 2;
  InfoGross = 3;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,64), NetAdj, GrsAdj);
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

function F0058C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 91;
  TotalAdj  = 135;
  FinalAmt  = 136;
  PlusChk   = 183;
  NegChk    = 184;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,120), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,122), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,126), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);

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

function F0058C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 141;
  TotalAdj  = 185;
  FinalAmt  = 186;
  PlusChk   = 183;
  NegChk    = 184;
  InfoNet   = 6;
  InfoGross = 7;
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
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,164), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,168), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,174), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,176), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,178), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,180), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,182), NetAdj, GrsAdj);

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

////////////////////////////////////////////////////////////////////////////////
//
// 104 URAR           UID 52
//
////////////////////////////////////////////////////////////////////////////////
function F0052C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 196;
  TotalAdj  = 240;
  FinalAmt  = 241;
  PlusChk   = 238;
  NegChk    = 239;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,203), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,216), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,218), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,223), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,225), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,227), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,229), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,231), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,233), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,235), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,237), NetAdj, GrsAdj);

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

function F0052C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 245;
  TotalAdj  = 289;
  FinalAmt  = 290;
  PlusChk   = 287;
  NegChk    = 288;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,250), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,252), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,254), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,256), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,258), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,260), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,262), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,265), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,267), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,268), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,272), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,274), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,276), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,278), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,280), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,282), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,284), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,286), NetAdj, GrsAdj);

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

function F0052C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 294;
  TotalAdj  = 338;
  FinalAmt  = 339;
  PlusChk   = 336;
  NegChk    = 337;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,299), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,301), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,303), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,305), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,307), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,309), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,311), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,314), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,316), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,317), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,321), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,323), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,325), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,327), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,329), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,331), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,333), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,335), NetAdj, GrsAdj);

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

////////////////////////////////////////////////////////////////////////////////
//
// FNMA 2055                UID 55
//
////////////////////////////////////////////////////////////////////////////////
function F0055C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 178;
  TotalAdj  = 222;
  FinalAmt  = 223;
  PlusChk   = 220;
  NegChk    = 221;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,183), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,185), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,187), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,189), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,191), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,193), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,195), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,198), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,200), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,201), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,205), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,207), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,209), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,211), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,213), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,215), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,217), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);

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

function F0055C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 227;
  TotalAdj  = 271;
  FinalAmt  = 272;
  PlusChk   = 269;
  NegChk    = 270;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,232), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,234), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,236), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,238), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,240), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,242), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,244), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,247), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,249), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,250), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,254), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,256), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,258), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,260), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,262), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,264), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,266), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,268), NetAdj, GrsAdj);

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

function F0055C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 276;
  TotalAdj  = 320;
  FinalAmt  = 321;
  PlusChk   = 318;
  NegChk    = 319;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,281), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,283), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,285), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,287), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,289), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,291), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,293), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,296), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,298), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,299), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,303), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,305), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,307), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,309), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,311), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,313), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,315), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,317), NetAdj, GrsAdj);

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


////////////////////////////////////////////////////////////////////////////////
//
// FNMA 1004C                UID 147
//
////////////////////////////////////////////////////////////////////////////////
function F0147C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 101;
  TotalAdj  = 145;
  FinalAmt  = 146;
  PlusChk   = 143;
  NegChk    = 144;
  InfoNet   = 1;
  InfoGross = 2;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,108), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,110), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,112), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,114), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,116), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,118), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,124), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,128), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,130), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,132), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,134), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,136), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,138), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);

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

function F0147C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 150;
  TotalAdj  = 194;
  FinalAmt  = 195;
  PlusChk   = 192;
  NegChk    = 193;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
begin
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,155), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,170), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,172), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);
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

function F0147C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 199;
  TotalAdj  = 243;
  FinalAmt  = 244;
  PlusChk   = 241;
  NegChk    = 242;
  InfoNet   = 5;
  InfoGross = 6;
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
  GetNetGrosAdjs(doc, mcx(cx,219), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,221), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,222), NetAdj, GrsAdj);
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


////////////////////////////////////////////////////////////////////////////////
//
// FORM Math Processors
//
////////////////////////////////////////////////////////////////////////////////
function ProcessForm0052Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //subj price/sqft
        1:
          cmd := DivideAB(doc, mcx(cx,172), mcx(cx,184), mcx(cx,173));

      //Comp1
        2:
        begin
          ProcessForm0052Math(doc, 5, CX);     //calc new price/sqft
          Cmd := F0052C1Adjustments(doc, cx);   //redo the adjustments
        end;
        3:
          Cmd := F0052C1Adjustments(doc, cx);   //redo the adjustments
        5:
          cmd := DivideAB(doc, mcx(cx,196), mcx(cx,224), mcx(cx,197));

      //Comp2
        6:
        begin
          ProcessForm0052Math(doc, 9, CX);     //calc new price/sqft
          Cmd := F0052C2Adjustments(doc, cx);   //redo the adjustments
        end;
        7:
          Cmd := F0052C2Adjustments(doc, cx);   //redo the adjustments
        9:
          cmd := DivideAB(doc, mcx(cx,245), mcx(cx,273), mcx(cx,246));

       //Comp3
        10:
        begin
          ProcessForm0052Math(doc, 13, CX);     //calc new price/sqft
          Cmd := F0052C3Adjustments(doc, cx);   //redo the adjustments
        end;
        11:
          Cmd := F0052C3Adjustments(doc, cx);   //redo the adjustments
        13:
          cmd := DivideAB(doc, mcx(cx,294), mcx(cx,322), mcx(cx,295));

        20:
          cmd := CalcWeightedAvg(doc, [52,58]);

        //wt avg
        21:
          begin
            F0052C1Adjustments(doc, cx);
            F0052C2Adjustments(doc, cx);     //sum of adjs
            F0052C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0052Math(doc, 21, CX);
        end;
      end;

  result := 0;
end;

function ProcessForm0055Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //subj price/sqft
        1: cmd := DivideAB(doc, mcx(cx,154), mcx(cx,166), mcx(cx,155));

      //Comp1
        2:
        begin
          ProcessForm0055Math(doc, 5, CX);     //calc new price/sqft
          Cmd := F0055C1Adjustments(doc, cx);   //redo the adjustments
        end;
        3:
          Cmd := F0055C1Adjustments(doc, cx);   //redo the adjustments
        5:
          cmd := DivideAB(doc, mcx(cx,178), mcx(cx,206), mcx(cx,179));

      //Comp2
        6:
        begin
          ProcessForm0055Math(doc, 9, CX);     //calc new price/sqft
          Cmd := F0055C2Adjustments(doc, cx);   //redo the adjustments
        end;
        7:
          Cmd := F0055C2Adjustments(doc, cx);   //redo the adjustments
        9:
          Cmd := DivideAB(doc, mcx(cx,227), mcx(cx,255), mcx(cx,228));

      //Comp3
        10:
        begin
          ProcessForm0055Math(doc, 13, CX);     //calc new price/sqft
          Cmd := F0055C3Adjustments(doc, cx);   //redo the adjustments
        end;
        11:
          Cmd := F0055C3Adjustments(doc, cx);   //redo the adjustments
        13:
          Cmd := DivideAB(doc, mcx(cx,276), mcx(cx,304), mcx(cx,277));

        20:
          Cmd := CalcWeightedAvg(doc, [55,58]);

        //wt avg
        21:
          begin
            F0055C1Adjustments(doc, cx);
            F0055C2Adjustments(doc, cx);     //sum of adjs
            F0055C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0055Math(doc, 21, CX);
        end;
      end;

  result := 0;
end;

function ProcessForm0058Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 37,87,137);
        2:
          Cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 37,87,137, 2);

        //subject
        3:
          Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,28), mcx(cx,17));


        //Comp 1
        4:
        begin
          ProcessForm0058Math(doc, 6, CX);     //calc new price/sqft
          Cmd := F0058C1Adjustments(doc, cx);   //redo the adjustments
        end;
        5:
          Cmd := F0058C1Adjustments(doc, cx);     //redo the adjustments
        6: cmd := DivideAB(doc, mcx(cx,41), mcx(cx,69), mcx(cx,42));

        //Comp 2
        7:
        begin
          ProcessForm0058Math(doc, 9, CX);       //calc new price/sqft
          Cmd := F0058C2Adjustments(doc, cx);     //redo the adjustments
        end;
        8:
          Cmd := F0058C2Adjustments(doc, cx);     //redo the adjustments
        9: cmd := DivideAB(doc, mcx(cx,91), mcx(cx,119), mcx(cx,92));

        //Comp 3
        10:
        begin
          ProcessForm0058Math(doc, 12, CX);       //calc new price/sqft
          Cmd := F0058C3Adjustments(doc, cx);     //redo the adjustments
        end;
        11:
          Cmd := F0058C3Adjustments(doc, cx);     //redo the adjustments
        12: cmd := DivideAB(doc, mcx(cx,141), mcx(cx,169), mcx(cx,142));


        13:
          cmd := CalcWeightedAvg(doc, [52,58]);

        //page configuration
        20: Cmd := ConfigXXXInstance(doc, cx, 37,87,137);
        //wt avg
        21:
          begin
            F0058C1Adjustments(doc, cx);
            F0058C2Adjustments(doc, cx);     //sum of adjs
            F0058C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0058Math(doc, 21, CX);
        end;
      end;

  result := 0;
end;

function F0147CostMultiplier(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := GetCellValue(doc, cellA);
  V2 := GetCellValue(doc, cellB);

  VR := V1;
  if V2 <> 0 then VR := V1 * V2;
  result := SetCellValue(doc, CellR, VR);
end;

function F0147SubTotalOne(doc: TContainer; CX: CellUID; C1,C2,C3,C4, CR: Integer):Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  V2 := GetCellValue(doc, mcx(cx,C2));
  V3 := GetCellValue(doc, mcx(cx,C3));
  V4 := GetCellValue(doc, mcx(cx,C4));

  VR := V1 - V2 - V3 - V4;
  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function ProcessForm0147Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
      //subject
        1:
          Cmd := DivideAB(doc, mcx(cx,77), mcx(cx,89), mcx(cx,78));

      //Comp1
        2:
        begin
          ProcessForm0147Math(doc, 4, CX);        //calc new price/sqft
          Cmd := F0147C1Adjustments(doc, cx);     //redo the adjustments
        end;
        3:
          Cmd := F0147C1Adjustments(doc, cx);     //redo the adjustments
        4:
          Cmd := DivideAB(doc, mcx(cx,101), mcx(cx,129), mcx(cx,102));

      //comp2
        5:
        begin
          ProcessForm0147Math(doc, 16, CX);       //calc new price/sqft
          Cmd := F0147C2Adjustments(doc, cx);     //redo the adjustments
        end;
        6:
          Cmd := F0147C2Adjustments(doc, cx);     //redo the adjustments
        7:
          Cmd := DivideAB(doc, mcx(cx,150), mcx(cx,178), mcx(cx,151));

      //Comp3
        8:
        begin
          ProcessForm0147Math(doc, 10, CX);       //calc new price/sqft
          Cmd := F0147C3Adjustments(doc, cx);     //redo the adjustments
        end;
        9:
          Cmd := F0147C3Adjustments(doc, cx);     //redo the adjustments
        10:
          Cmd := DivideAB(doc, mcx(cx,199), mcx(cx,227), mcx(cx,200));

        11:
          Cmd := CalcWeightedAvg(doc, [147]);

      //Cost approach
        15: Cmd := MultAB(doc, mcx(cx,8), mcx(cx,9), mcx(cx,10));
        16: Cmd := MultAB(doc, mcx(cx,11), mcx(cx,12), mcx(cx,13));
        17: Cmd := MultAB(doc, mcx(cx,14), mcx(cx,15), mcx(cx,16));
        18: Cmd := MultAB(doc, mcx(cx,17), mcx(cx,18), mcx(cx,19));
        19: Cmd := SumTenCellsR(doc, cx, 10,13,16,19,21,23,25,27,0,0, 28);
        20: Cmd := F0147CostMultiplier(doc, mcx(cx,28), mcx(cx,29), mcx(cx,30));
        21: Cmd := F0147SubTotalOne(doc, cx, 30,31,32,33, 34);
        22: Cmd := SumABC(doc, mcx(cx,34),mcx(cx,35),mcx(cx,36), mcx(cx,37));
        23: Cmd := 0;
        24: Cmd := MultAB(doc, mcx(cx,39), mcx(cx,40), mcx(cx,41));
        25: Cmd := MultAB(doc, mcx(cx,42), mcx(cx,43), mcx(cx,44));
        26: Cmd := MultAB(doc, mcx(cx,45), mcx(cx,46), mcx(cx,47));
        27: Cmd := MultAB(doc, mcx(cx,48), mcx(cx,49), mcx(cx,50));
        28: Cmd := SumFourCellsR(doc, cx, 41,44,47,50, 51);
        29:
          begin
            F0147C1Adjustments(doc, cx);
            F0147C2Adjustments(doc, cx);
            F0147C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 2
          ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm0297Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := 0;
        2:
          cmd := 0;
        3:
          cmd := 0;
        4:
          cmd := 0;
        5:
          cmd := 0;
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
        end;
    end;

  result := 0;
end;

end.
