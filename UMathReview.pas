unit UMathReview;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2005 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmReviewXRents  = 135;
  fmReview1032    = 138;   //Review 1032 (2002)
  fmRev1032XSales = 139;   //Revire 1032 (2002) Extra Sales
  fmReviewField   = 335;   //residential field review
  frmShortRevXComps = 176;  // Resedential Review Short Form Sales Comparison

  function ProcessForm0135Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0138Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0139Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0335Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0176Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

uses
  UMath;


//Review 1032 (2002) Adjustments
function F0138C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 39;
  TotalAdj  = 80;
  FinalAmt  = 81;
  PlusChk   = 78;
  NegChk    = 79;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,36));   //get the address
  if length(addr) = 0 then
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;

  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);

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

function F0138C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 85;
  TotalAdj  = 126;
  FinalAmt  = 127;
  PlusChk   = 124;
  NegChk    = 125;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;   //github 197
begin
  addr := GetCellString(doc, mcx(cx,82));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);

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

function F0138C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 131;
  TotalAdj  = 172;
  FinalAmt  = 173;
  PlusChk   = 170;
  NegChk    = 171;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr:String;
begin
  addr := GetCellString(doc, mcx(cx,128));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);

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

//Review 1032 (2002) Extra Sales Adjustments
function F0139C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 41;
  TotalAdj  = 82;
  FinalAmt  = 83;
  PlusChk   = 80;
  NegChk    = 81;
  InfoNet   = 4;
  InfoGross = 5;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,38));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,62), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,63), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,79), NetAdj, GrsAdj);

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

function F0139C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 88;
  TotalAdj  = 129;
  FinalAmt  = 130;
  PlusChk   = 127;
  NegChk    = 128;
  InfoNet   = 6;
  InfoGross = 7;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,85));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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

function F0139C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 135;
  TotalAdj  = 176;
  FinalAmt  = 177;
  PlusChk   = 174;
  NegChk    = 175;
  InfoNet   = 8;
  InfoGross = 9;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,132));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,140), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,142), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,144), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,146), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,148), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,150), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,154), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,156), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,171), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,173), NetAdj, GrsAdj);

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

//Small Income Extra Rentals for Review
function ProcessForm0135Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS', 'ADDENDUM',49,100,151, 2);
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 49,100,151);
        3:
          cmd := ConfigXXXInstance(doc, cx, 49,100,151);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

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

function F0335C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 39;
  TotalAdj  = 80;
  FinalAmt  = 81;
  PlusChk   = 78;
  NegChk    = 79;
  InfoNet   = 3;
  InfoGross = 4;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,36));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,44), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,46), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,48), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,50), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,52), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,54), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,56), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,58), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,60), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,61), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,65), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,67), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,69), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,71), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,73), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,75), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,77), NetAdj, GrsAdj);

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
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;


function F0335C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 85;
  TotalAdj  = 126;
  FinalAmt  = 127;
  PlusChk   = 124;
  NegChk    = 125;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,82));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
  NetAdj := 0;
  GrsAdj := 0;
  GetNetGrosAdjs(doc, mcx(cx,90), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,92), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,94), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,96), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,98), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,100), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,102), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,104), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,106), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,107), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,111), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,113), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,115), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,117), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,119), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,121), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,123), NetAdj, GrsAdj);

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
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;


function F0335C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 131;
  TotalAdj  = 172;
  FinalAmt  = 173;
  PlusChk   = 170;
  NegChk    = 171;
  InfoNet   = 7;
  InfoGross = 8;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,128));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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
  GetNetGrosAdjs(doc, mcx(cx,152), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,153), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,157), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,159), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,161), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,163), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,165), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,167), NetAdj, GrsAdj);
  GetNetGrosAdjs(doc, mcx(cx,169), NetAdj, GrsAdj);

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
  end;
  SetInfoCellValue(doc, mcx(cx,infoNet), NetPct);
  SetInfoCellValue(doc, mcx(cx,infoGross), GrsPct);      //set the info cells

  result := SetCellValue(doc, mcx(cx,FinalAmt), saleValue+ NetAdj);  //set final adj price
end;



function ProcessForm0335Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm0335Math(doc, 3, CX);        //calc new price/sqft
            cmd := F0335C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F0335C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,39), mcx(cx,66), mcx(cx,40));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm0335Math(doc, 6, CX);     //calc new price/sqft
            cmd := F0335C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F0335C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,85), mcx(cx,112), mcx(cx,86));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm0335Math(doc, 9, CX);     //calc new price/sqft
            cmd := F0335C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F0335C3Adjustments(doc, cx);       //sum of adjs
        9:
          cmd := DivideAB(doc, mcx(cx,131), mcx(cx,158), mcx(cx,132));     //price/sqft

        10:
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,28), mcx(cx,16));     //Subj price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function F0176C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
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
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,35));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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

function F0176C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
const
  SalesAmt  = 98;
  TotalAdj  = 152;
  FinalAmt  = 153;
  PlusChk   = 150;
  NegChk    = 151;
  InfoNet   = 5;
  InfoGross = 6;
var
  NetAdj,GrsAdj: Double;
  saleValue, NetPct, GrsPct: Double;
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,95));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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

function F0176C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
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
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,155));   //get the address
  if addr = '' then  //only calculate if we have address  //github 197
    begin
      SetCellstring(doc, MCX(CX, TotalAdj), '');
      ClearCheckMark(doc, MCX(CX, PlusChk));
      ClearCheckMark(doc, MCX(CX, NegChk));
      SetInfoCellValue(doc, MCX(CX, InfoNet),0);
      SetInfoCellValue(doc, MCX(CX, InfoGross), 0);
      Result := SetCellString(doc, MCX(CX, FinalAmt), '');
      exit;
    end;
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


function ProcessForm0176Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
const
  infoAvg = 2;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
         1:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',34,94,154, 2);
         2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 34,94,154);
         3:
          cmd := ConfigXXXInstance(doc, cx, 34,94,154,False);
         //Comp1 calcs
         4:   //sales price changed
          begin
            ProcessForm0176Math(doc, 6, CX);        //calc new price/sqft
            cmd := F0176C1Adjustments(doc, cx);     //redo the adjustments
          end;
         5:
          cmd := F0176C1Adjustments(doc, cx);       //sum of adjs
         6:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,64), mcx(cx,39));     //price/sqft
         7:
          begin
            ProcessForm0176Math(doc, 9, CX);        //calc new price/sqft
            cmd := F0176C2Adjustments(doc, cx);     //redo the adjustments
          end;
         8:
          cmd := F0176C2Adjustments(doc, cx);       //sum of adjs
         9:
          cmd := DivideAB(doc, mcx(cx,98), mcx(cx,124), mcx(cx,99));     //price/sqft
         10:
          begin
            ProcessForm0176Math(doc, 12, CX);        //calc new price/sqft
            cmd := F0176C3Adjustments(doc, cx);     //redo the adjustments
          end;
         11:
          cmd := F0176C3Adjustments(doc, cx);       //sum of adjs
         12:
          cmd := DivideAB(doc, mcx(cx,158), mcx(cx,184), mcx(cx,159));     //price/sqft
         13:
          cmd := DivideAB(doc, mcx(cx,8), mcx(cx,21), mcx(cx,9));     //Subj price/sqft
         14:
          cmd := CalcWeightedAvg(doc, [176]);   //calc wtAvg of main and xcomps forms
         15:
          cmd := DivideAB(doc, mcx(cx,8), mcx(cx,21), mcx(cx,9));     //Subj price/sqft
         else
          cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          begin
            F0176C1Adjustments(doc, cx);       //sum of adjs
            F0176C2Adjustments(doc, cx);       //sum of adjs
            F0176C3Adjustments(doc, cx);       //sum of adjs

            //in the 176 Form the average info cell not marked as Average cell (icAvgBox)
            // so it does not display the average in UMath:CalcWeightedAvg.
            if SumOfWeights <> 0 then      //the average info cell doesnot mark as Average cell (icAvgBox) in the forms
               SetInfoCellValue(doc, mcx(cx,infoAvg), SumOfWeightedValues / SumOfWeights);
          end;
        end;
    end;
  result := 0;
end;

end.
