unit UMathCustom;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2006 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmTB10002   = 10002;      //Tony Blackburn
  fmTB10003   = 10003;      //tony blackburn - same as FannieMae 2000
  fmTB10005   = 10005;      //tony blackburn - same as fannieMae 2000A
  fmBB10007   = 10007;      //Bill Baughn - private party appr report
  fmEBank     = 10008;      //ebank
  fmEBankXComps = 10009;    //ebank x comps


  function ProcessForm10002Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm10007Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm10008Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm10009Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

implementation

Uses
  UMath;


{Special Cost Approach - eBank}

function F10008Depreciation(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,188));    //Phys
  V2 := GetCellValue(doc, mcx(cx,189));    //Funct
  V3 := GetCellValue(doc, mcx(cx,190));    //Ext
  V4 := GetCellValue(doc, mcx(cx,185));    //New Cost
  if (V4) > 0 then
    begin
      VR := ((V4)*(V1/100)) + (((V4)-((V4)*(V1/100)))*(V2/100)) + (((V4)-((V4)*(V1/100))-(((V4)-((V4)*(V1/100)))*(V2/100)))*(V3/100));
      result := SetCellValue(doc, mcx(cx,191), VR);
    end;
end;

{Adjustments for eBank}

function F10008C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 162,178,179,176,177,0,0,
            [165,167,169,171,173,175]);
end;

function F10008C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 184,200,201,198,199,0,0,
            [187,189,191,193,195,197]);
end;

function F10008C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 206,222,223,220,221,0,0,
            [209,211,213,215,217,219]);
end;


function F10009C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 30,46,47,44,45,0,0,
            [33,35,37,39,41,43]);
end;

function F10009C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 52,69,70,67,68,0,0,
            [56,58,60,62,64,66]);
end;

function F10009C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 76,92,93,90,91,0,0,
            [79,81,83,85,87,89]);
end;





function F10002C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
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
begin
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


function F10002C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
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
begin
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


function F10002C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
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
begin
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


function ProcessForm10002Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//Comp1 calcs
        1:   //sales price changed
          begin
            ProcessForm10002Math(doc, 3, CX);        //calc new price/sqft
            cmd := F10002C1Adjustments(doc, cx);     //redo the adjustments
          end;
        2:
          cmd := F10002C1Adjustments(doc, cx);       //sum of adjs
        3:
          cmd := DivideAB(doc, mcx(cx,39), mcx(cx,66), mcx(cx,40));     //price/sqft

//Comp2 calcs
        4:   //sales price changed
          begin
            ProcessForm10002Math(doc, 6, CX);     //calc new price/sqft
            cmd := F10002C2Adjustments(doc, cx);     //redo the adjustments
          end;
        5:
          cmd := F10002C2Adjustments(doc, cx);       //sum of adjs
        6:
          cmd := DivideAB(doc, mcx(cx,85), mcx(cx,112), mcx(cx,86));     //price/sqft

//Comp3 calcs
        7:   //sales price changed
          begin
            ProcessForm10002Math(doc, 9, CX);     //calc new price/sqft
            cmd := F10002C3Adjustments(doc, cx);     //redo the adjustments
          end;
        8:
          cmd := F10002C3Adjustments(doc, cx);       //sum of adjs
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

function ProcessForm10007Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := SumCellArray(doc, CX, [99,108,117], 121);
        2:
          Cmd := SumCellArray(doc, CX, [91,92,93,94,95,96,               //level 1
                                        100,101,102,103,104,105,         //level 2
                                        109,110,111,112,113,114], 118);  //level 3
        3:
          cmd := SumCellArray(doc, CX, [97,106,115], 120);
        4:
          cmd := SumCellArray(doc, CX, [96,105,114], 119);
        5:
          cmd := ProcessMultipleCmds(ProcessForm10007Math, doc, CX, [4,2]);
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



{EBank Forms}

function ProcessForm10008Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [113,115,117,119,121], 122);
        2:
          cmd := SumCellArray(doc, cx, [176,177,178,179], 180);
        3:
          cmd := SumCellArray(doc, cx, [182,183,184], 185);
        6,7,8:
          cmd := F10008Depreciation(doc, cx);
        4:
          cmd := ProcessMultipleCmds(ProcessForm10008Math, doc, CX,[6,7,8,9]);
        9:
          cmd := SubtAB(doc, MCX(cx,185), mcx(cx,191), mcx(cx,192));
        10,11,12:
          cmd := SumCellArray(doc, cx, [192,193,194], 195);
        16,13,14:
          Cmd := F10008C1Adjustments(doc, cx);
        20,17,18:
          Cmd := F10008C2Adjustments(doc, cx);
        24,21,22:
          Cmd := F10008C3Adjustments(doc, cx);
        25:
          cmd := TransA2B(doc, mcx(cx,224), mcx(cx,235));
        26:
          cmd := TransA2B(doc, mcx(cx,180), mcpx(cx,2,233));
        27:
          cmd := TransA2B(doc, mcx(cx,195), mcpx(cx,2,234));
        28:
          cmd := SumCellArray(doc, cx, [128,135,142,149,156,163,170], 173);
        29:
          cmd := SumCellArray(doc, cx, [129,136,143,150,157,164,171], 174);
        30:
          cmd := SumCellArray(doc, cx, [130,137,144,151,158,165,172], 175);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


function ProcessForm10009Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1,2,4:
          Cmd := F10009C1Adjustments(doc, cx);
        5,6,8:
          Cmd := F10009C2Adjustments(doc, cx);
        9,10,12:
          Cmd := F10009C3Adjustments(doc, CX);
        //dynamic form name
        14:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 25,48,71, 2);
        15:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 25,48,71);
        16:
          cmd := ConfigXXXInstance(doc, cx, 25,48,71);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


end.
