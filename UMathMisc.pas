unit UMathMisc;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2011 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer;

const
  fmInvoice1    = 220;
  fmInvoiceStd  = 221;
  fmInvoiceRip  = 223;
  fmInvoice2    = 235;
  fmInvoice5    = 237;
  fmInvoice6    = 225;
  fmInvoice7    = 227;
  fmInvoice08   = 294;
  fmInvoice9    = 285;
  fmInvoice10   = 988;
  fmInvoice11   = 989;
  fmInvoiceAI   = 292;
  fmQuickStart2 = 709;
  fmQuickStart3 = 716;
  fmStatement   = 966;
  fmStatemtLogo = 967;

  //invoices with logos
  fmInvoice1Logo = 433;
  fmInvoice2Logo = 434;
  fmInvoice3Logo = 435;
  fmInvoice4Logo = 436;
  fmInvoice5Logo = 437;
  fmInvoice6Logo = 438;
  fmInvoice7Logo = 439;
  fmInvoice8Logo = 440;
  fmInvoice9Logo = 441;

  fmRELSOrder    = 626;
  fmRELSMktCond  = 826;
  
  fmStLinkDeskTop = 975;     //StreetLink Desktop
  fmStLinkDTopXC  = 977;     //extra comps
  fmStLinkDTopXL  = 978;     //extra listrings
  fmStLinkLiqAsst = 970;     //StreetLink Liquid Assest
  fmStLinkLiqAXC  = 973;     //extra comps
  fmStLinkLiqAXL  = 974;     //extra listings

  //Wells Fargo
  frmWellsFargo_4022 = 4022;
  frmWellsFargo_4023 = 4023;
  frmWellsFargo_4024 = 4024;
  frmWellsFargo_4025 = 4025;
  frmWellsFargo_4026 = 4026;
  frmWellsFargo_4027 = 4027;
  frmWellsFargo_4035 = 4035;

  //Chase
  frmChase_4031 = 4031;

  //ACE
  frmACE_4088 = 4088;
  frmACE_4089 = 4089;

  //PROTECK
  frmProTeck_4076 = 4076;
  frmProTeck_4099 = 4099;
  frmProTeck_4249 = 4249;
  frmProTeck_4264 = 4264; //PAM - Ticket #1331 - add math for new form: 4264
  frmProTeck_4265 = 4265; //PAM - Ticket #1331 - add math for new form: 4265

  frmProTeck_4270 = 4270; //PAM - Ticket #1400 - add math for new form: 4270

  //QSAR
  frmQSAR_4160    = 4160; //PAM - Ticket #1332 - add math for new form: 4160

  //Apple Appraisal Surevalue
  frmApple_4096 = 4096;
  frmApple_4132 = 4132;
  frmApple_4133 = 4133;
  frmArivs_4136 = 4136;
  frmArivs_4137 = 4137;
  frmArivs_4138 = 4138;
  fmValuation_4151 = 4151;
  fmValXComp_4152  = 4152;
  fmValXList_4153  = 4153;

  //Clear Capital
  frmClearCapital_4140 = 4140;
  frmClearCapital_4220 = 4220;  //ticket #1085
  frmClearCapital_4220Cert = 4221;  //ticket #1085


  frmCommercial_4125 = 4125;

  //Derek AS-IS FORMS
  frmASIS1004_4187  = 4187;
  frmASIS1025_4200  = 4200;
  frmASIS1073_4201  = 4201;
  frmASIS2090_4202  = 4202;

  //Derek AS-IS REPAIR FORMS
  frmASIS1004R_4188 = 4188;
  frmASIS1025R_4199 = 4199;
  frmASIS1073R_4197 = 4197;
  frmASIS2090R_4198 = 4198;



  //IQ Express
  frmIQExp_4195     = 4195;
  frmIQExpCert_4196 = 4196;
  frmIQExp_4204     = 4204;
  //Drew
  frmIQWav_4215     = 4215;    //Ticket #966
  frmIQWavCert_4216 = 4216;    //Ticket #966

  frmWaivValuation_4230 = 4230;  //Ticket #1113

  //Limited Appraisal
  frmLimitedApp_4087 = 4087;  //github #831
  frmLimitedAppXComp_4205 = 4205;  //github #831

  frmAppNation_4174 = 4174;  //github #843
  frmAppNationXComp_4208 = 4208;  //github #843


  //Mileage Chart
  frmMileage_4092 = 4092;

  //Josh Walitt's form
  frmInterLink_4250 = 4250;  //Ticket #1249
  frmInterLink_4252 = 4252;  //Ticket #1249

  //RedStone
  fmRStone8022    = 8022;
  GAtt = 'ga';                     //Attached Garage
  GDet = 'gd';                     //Detached Garage
  GBin = 'gbi';                    //Built-In Garage
  GGar = 'g';                      //Garage Parking
  GCov = 'cv';                     //Covered Parking
  GOpn = 'op';                     //Open Parking


  function ProcessForm0220Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0221Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0223Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0227Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0988Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;  //### move down
  function ProcessForm0225Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0235Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0237Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0285Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0292Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0294Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0709Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0716Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0966Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //invoices with logos
  function ProcessForm0433Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0434Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0435Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0436Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0437Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0438Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0439Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0440Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0441Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0626Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0826Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0944Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0975Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0977Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0978Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0970Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0973Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0974Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //Wells Fargo Forms
  function ProcessForm04022Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04023Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04024Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04025Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04026Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04027Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04035Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //Chase Forms
  function ProcessForm04031Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  // Valuation Link ACE Forms
  function ProcessForm4088Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4089Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //Proteck Forms
  function ProcessForm04076Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04099Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04249Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04264Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04265Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04270Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //QSAR Forms
  function ProcessForm04160Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //Apple appraisal surevalue report
  function ProcessForm04096Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04132Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04133Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04137Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04138Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //github 246: Apple valuation report
  function ProcessForm4151Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4152Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4153Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


  // Mileage Chart
  function ProcessForm04092Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //Clear Capital
  function ProcessForm04140Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04220Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //Commercial
  function ProcessForm04125Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //github #783: Derek forms
  function ProcessForm04187Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04188Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04200Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04199Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04201Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04197Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04202Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04198Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //github #831
  function ProcessForm04087Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04205Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  //github #843
  function ProcessForm04174Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04208Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //github #1113
  function ProcessForm04230Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;


  //Ticket #1249: Josh Walitt's forms

  function ProcessForm04250Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm04252Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;



implementation

uses
	Dialogs, SysUtils, DateUtils, Math,UUADUtils,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings;


function F0223SumAmounts(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get10CellSumR(doc,CX, 25,29,33,37,41,45,49,53,57,61);
  V2 := Get8CellSumR(doc, CX, 65,69,73,77,81,85,0,0);
  VR := V1 + V2 + GetCellValue(doc, mcx(cx,86));

  result := SetCellValue(doc, mcx(cx,87), VR);
end;

function F0227SumAmounts(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get10CellSumR(doc,CX, 31,35,39,43,47,51,55,59,63,67);
  V2 := Get8CellSumR(doc, CX, 71,75,79,83,87,91,0,0);
  VR := V1 + V2;  // + GetCellValue(doc, mcx(cx,92));

  result := SetCellValue(doc, mcx(cx,92), VR);
end;

function F0988SumAmounts(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  V1 := Get10CellSumR(doc,CX, 27,31,35,39,43,47,51,55,59,63);
  V2 := Get8CellSumR(doc, CX, 67,71,75,79,83,87,0,0);
  VR := V1 + V2;  // + GetCellValue(doc, mcx(cx,88));

  result := SetCellValue(doc, mcx(cx,88), VR);
end;

function F00235Total(doc: TContainer; CX: CellUID; C1,C2,C3,C4, CR: Integer): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,C1));
  V2 := GetCellValue(doc, mcx(cx,C2));
  V3 := GetCellValue(doc, mcx(cx,C3));
  V4 := GetCellValue(doc, mcx(cx,C4));
  VR := V1 + V2 + -V3 - V4;

  result := SetCellValue(doc, mcx(cx,CR), VR);
end;

function ProcessForm0220Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumSixCellsR(doc, cx, 16,18,20,22,24,26, 27);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0221Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumFourCellsR(doc, cx, 12,14,16,0, 17);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0223Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0223SumAmounts(doc, cx);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0227Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0227SumAmounts(doc, cx);
        2:
          cmd := MultPercentAB(doc, mcx(cx,92), mcx(cx,94), mcx(cx,95));
        3:
          cmd := SumABC(doc, mcx(cx,92), mcx(cx,93), mcx(cx,95), mcx(cx,96));
        4:
          begin
            ProcessForm0227Math(doc, 2, cx);
            ProcessForm0227Math(doc, 3, cx);
            cmd := 0;
          end;
        5:
          cmd := TransA2B(doc,mcx(cx,27),mcx(cx,104));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

// 101311 JWyatt Rally fixed address invoices. Math is identical for 988 & 989.
function ProcessForm0988Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := F0988SumAmounts(doc, cx);
        2:
          cmd := MultPercentAB(doc, mcx(cx,88), mcx(cx,90), mcx(cx,91));
        3:
          cmd := SumABC(doc, mcx(cx,88), mcx(cx,89), mcx(cx,91), mcx(cx,92));
        4:
          begin
            ProcessForm0988Math(doc, 2, cx);
            ProcessForm0988Math(doc, 3, cx);
            cmd := 0;
          end;
        5:
          cmd := TransA2B(doc,mcx(cx,23),mcx(cx,100));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0225Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumTenCellsR(doc, cx, 35,37,39,41,43,45,47,49,51,0, 52);
        2:
          Cmd := SumFourCellsR(doc,cx, 56,60,64,0, 65);
        3:
          Cmd := SubtAB(doc,mcx(cx,52), mcx(cx,65), mcx(cx,66));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0235Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumTenCellsR(doc, cx, 23,25,27,29,31,33,35,37,39,0, 40);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0237Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumFourCellsR(doc, cx, 19,21,23,0, 24);
        2:
          cmd := MultPercentAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));
        3:
          cmd := F00235Total(doc, cx, 24,26,27,28, 29);
        4: begin
            ProcessForm0235Math(doc, 2, CX);
            cmd := F00235Total(doc, cx, 24,26,27,28, 29);
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0285Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumFourCellsR(doc, cx, 18,20,22,24, 25);
        2:
          cmd := MultPercentAB(doc, mcx(cx,25), mcx(cx,26), mcx(cx,27));
        3:
          cmd := SumAB(doc, mcx(cx,25), mcx(cx,27), mcx(cx,28));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0292Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := SumTenCellsR(doc, cx, 16,18,20,22,24,26,28,30,32,0, 33);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0294Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumSixCellsR(doc,CX,16,18,20,22,24,26, 27);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0709Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumEightCellsR(doc, cx, 75,77,79,81,83,85,87,0, 88);
        2:
          cmd := MultPercentAB(doc, mcx(cx,88), mcx(cx,90), mcx(cx,91));
        3:
          cmd := SumABC(doc, mcx(cx,88), mcx(cx,89), mcx(cx,91), mcx(cx,92));
        4: begin
            ProcessForm0709Math(doc, 2, CX);
            ProcessForm0709Math(doc, 3, cx);
            ProcessForm0709Math(doc, 5, cx);
            ProcessForm0709Math(doc, 6, cx);
            ProcessForm0709Math(doc, 7, cx);
            cmd := 0;
          end;
        5:
          cmd := MultPercentAB(doc, mcx(cx,88), mcx(cx,95), mcx(cx,96));
        6:
          cmd := MultPercentAB(doc, mcx(cx,88), mcx(cx,99), mcx(cx,100));
        7:
          cmd := MultPercentAB(doc, mcx(cx,88), mcx(cx,103), mcx(cx,104));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0716Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [77,79,81,83], 84);
        2:
          cmd := SumCellArray(doc, cx, [86,88,90], 91);
        3:
          cmd := SumCellArray(doc, cx, [84,91], 92);
        4:
          cmd := ProcessMultipleCmds(ProcessForm0716Math, doc, cx, [8]);
        5:
          cmd := MultPercentAB(doc, mcx(cx,84), mcx(cx,99), mcx(cx,100));  //split-1
        6:
          cmd := MultPercentAB(doc, mcx(cx,84), mcx(cx,103), mcx(cx,104)); //split-2
        7:
          cmd := MultPercentAB(doc, mcx(cx,84), mcx(cx,107), mcx(cx,108));//split-3
        8:
          cmd := MultPercentAB(doc, mcx(cx,91), mcx(cx,94), mcx(cx,95));
        9:
          cmd := ProcessMultipleCmds(ProcessForm0716Math, doc, cx, [3,5,6,7]);
        10:
          cmd := SumCellArray(doc, cx, [92,93,95], 96);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0966Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [16,18,20,22,24,26], 27);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0433Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [17,19,21,23,25,27], 28);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0434Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [24,26,28,30,32,34,36,38,40], 41);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0435Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74, 78, 82, 86, 87], 88);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0436Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [13, 15, 17], 18);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0437Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumFourCellsR(doc, cx, 20,22,24,0, 25);
        2:
          cmd := MultPercentAB(doc, mcx(cx,25), mcx(cx,26), mcx(cx,27));
        3:
          cmd := F00235Total(doc, cx, 25,27,28,29, 30);
        4: begin
            ProcessForm0437Math(doc, 2, CX);
            cmd := F00235Total(doc, cx, 25,27,28,29, 30);
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0438Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumTenCellsR(doc, cx, 36,38,40,42,44,46,48,50,52,0, 53);
        2:
          Cmd := SumFourCellsR(doc,cx, 57,61,65,0, 66);
        3:
          Cmd := SubtAB(doc,mcx(cx,53), mcx(cx,66), mcx(cx,67));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0439Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92], 93);
        2:
          cmd := MultPercentAB(doc, mcx(cx,93), mcx(cx,95), mcx(cx,96));
        3:
          cmd := SumABC(doc, mcx(cx,93), mcx(cx,94), mcx(cx,96), mcx(cx,97));
        4:
          Cmd := ProcessMultipleCmds(ProcessForm0439Math, doc, CX,[2,3]);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0440Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [17,19,21,23,25,27], 28);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0441Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [19,21,23,25], 26);
        2:
          cmd := MultPercentAB(doc, mcx(cx,26), mcx(cx,27), mcx(cx,28));
        3:
          cmd := SumAB(doc, mcx(cx,26), mcx(cx,28), mcx(cx,29));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0626Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [30,32,34,36,38], 39);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0826Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := DivideAB(doc, mcx(CX,31), mcx(cx,32), mcx(cx,33));
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function ProcessForm0944Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, cx, [27,29,31,33,35], 36);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlink desktop valuation
function ProcessForm0975Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := DivideAB(doc, mcx(cx,62), mcx(cx,73), mcx(cx,63));       //Subj price/sqft
        2:
          cmd := DivideAB(doc, mcx(cx,83), mcx(cx,108), mcx(cx,84));      //C1 price/sqft
        3:
          cmd := DivideAB(doc, mcx(cx,126), mcx(cx,151), mcx(cx,127));    //C2 price/sqft
        4:
          cmd := DivideAB(doc, mcx(cx,169), mcx(cx,194), mcx(cx,170));    //C3 price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,18), mcx(cx,8));         //Subj price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,29), mcx(cx,50), mcx(cx,30));       //L1 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,68), mcx(cx,89), mcx(cx,69));       //L2 price/sqft
        8:
          cmd := DivideAB(doc, mcx(cx,107), mcx(cx,128), mcx(cx,108));    //L3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlink Desktop Valuation XComps
function ProcessForm0977Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 34,78,122);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 34,78,122, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 34,78,122);
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));       //Subj price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,63), mcx(cx,39));       //C1 price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,82), mcx(cx,107), mcx(cx,83));      //C2 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,126), mcx(cx,151), mcx(cx,127));    //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlink Desktop Valuation Xtra Listings
function ProcessForm0978Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 34,74,114);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 34,74,114, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 34,74,114);
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,27), mcx(cx,17));     //Subj price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,59), mcx(cx,39));     //C1 price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,78), mcx(cx,99), mcx(cx,79));     //C2 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,118), mcx(cx,139), mcx(cx,119));     //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlinks Liquid Assets Valuation
function ProcessForm0970Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := DivideAB(doc, mcx(cx,119), mcx(cx,130), mcx(cx,120));    //Subj price/sqft
        2:
          cmd := DivideAB(doc, mcx(cx,141), mcx(cx,166), mcx(cx,142));    //C1 price/sqft
        3:
          cmd := DivideAB(doc, mcx(cx,184), mcx(cx,209), mcx(cx,185));    //C2 price/sqft
        4:
          cmd := DivideAB(doc, mcx(cx,227), mcx(cx,252), mcx(cx,228));    //C3 price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,18), mcx(cx,8));         //Subj price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,29), mcx(cx,50), mcx(cx,30));       //L1 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,68), mcx(cx,89), mcx(cx,69));       //L2 price/sqft
        8:
          cmd := DivideAB(doc, mcx(cx,107), mcx(cx,128), mcx(cx,108));    //L3 price/sqft
        9:
          cmd := SiteDimension(doc, mcx(cx,64), mcx(cx,65));              //calc site dimensions
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlinks Liquid Assets Xtra Comps
function ProcessForm0973Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,77,121);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 33,77,121, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 33,77,121);
        4:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,25), mcx(cx,15));     //Subj price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,37), mcx(cx,62), mcx(cx,38));     //C1 price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,81), mcx(cx,106), mcx(cx,82));     //C2 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,125), mcx(cx,150), mcx(cx,126));     //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//Streetlinks Liquid Assets Xtra Listings
function ProcessForm0974Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 33,73,113);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 33,73,113, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 33,73,113);
        4:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,25), mcx(cx,15));     //Subj price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,37), mcx(cx,58), mcx(cx,38));     //C1 price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,77), mcx(cx,98), mcx(cx,78));     //C2 price/sqft
        7:
          cmd := DivideAB(doc, mcx(cx,117), mcx(cx,138), mcx(cx,118));     //C3 price/sqft
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//*****************************  STARTS WELLS FARGO FORMS
function F04022C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,51,106,107,104,105,1,2,
    [56,58,60,62,64,66,68,70,72,74,76,77,81,83,85,87,89,91,93,95,97,99,101,103],length(addr)> 0);
end;

function F04022C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,109));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,112,167,168,165,166,3,4,
    [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr)> 0);
end;

function F04022C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197 , 346
begin
  addr := GetCellString(doc, mcx(cx,170));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,173,228,229,226,227,5,6,
    [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225],length(addr)> 0);
end;

function ProcessForm04022Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3:     cmd := ConfigXXXInstance(doc, cx, 47,108,169, False);            //Set comparable
        4:     cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));        //Subj Sales price/GLA
        7:     cmd := DivideAB(doc, mcx(cx,51), mcx(cx,82), mcx(cx,52));        //comp1 Sales price/GLA
        10:    cmd := DivideAB(doc, mcx(cx,112), mcx(cx,143), mcx(cx,113));     //comp2 Sales price/GLA
        13:    cmd := DivideAB(doc, mcx(cx,173), mcx(cx,204), mcx(cx,174));     //comp3 Sales price/GLA
        6:     Cmd := F04022C1Adjustments(doc, cx);    //Comp1 adjustment
        9:     Cmd := F04022C2Adjustments(doc, cx);    //Comp2 adjustment
        12:    Cmd := F04022C3Adjustments(doc, cx);    //Comp3 adjustment
        5:     cmd := ProcessMultipleCmds(ProcessForm04022Math, doc, CX,[7,6]);   //C1 sales price
        8:     cmd := ProcessMultipleCmds(ProcessForm04022Math, doc, CX,[10,9]);  //C2 sales price
        11:    cmd := ProcessMultipleCmds(ProcessForm04022Math, doc, CX,[13,12]); //C3 sales price
        14:    cmd := CalcWeightedAvg(doc, [frmWellsFargo_4022]);   //calc wtAvg of main form
        46:
          begin //no recursion
            F04022C1Adjustments(doc, cx);
            F04022C2Adjustments(doc, cx);
            F04022C3Adjustments(doc, cx);
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
          ProcessForm04022Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04022Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function F04023C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197,346
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,51,108,109,106,107,1,2,
    [58,60,62,64,66,68,70,72,74,76,78,79,83,85,87,89,91,93,95,97,99,101,103,105],length(addr)> 0);
end;

function F04023C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,111));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,114,171,172,169,170,3,4,
    [121,123,125,127,129,131,133,135,137,139,141,142,146,148,150,152,154,156,158,160,162,164,166,168],length(addr)> 0);
end;

function F04023C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,174));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,177,234,235,232,233,5,6,
    [184,186,188,190,192,194,196,198,200,202,204,205,209,211,213,215,217,219,221,223,225,227,229,231],length(addr)> 0);
end;

function ProcessForm04023Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3:     cmd := ConfigXXXInstance(doc, cx, 47,110,173, False);            //Set comparable
        4:     cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));        //Subj Sales price/GLA
        7:     cmd := DivideAB(doc, mcx(cx,51), mcx(cx,84), mcx(cx,52));        //comp1 Sales price/GLA
        10:    cmd := DivideAB(doc, mcx(cx,114), mcx(cx,147), mcx(cx,115));     //comp2 Sales price/GLA
        13:    cmd := DivideAB(doc, mcx(cx,177), mcx(cx,210), mcx(cx,178));     //comp3 Sales price/GLA

        6:     Cmd := F04023C1Adjustments(doc, cx);    //Comp1 adjustment
        9:     Cmd := F04023C2Adjustments(doc, cx);    //Comp2 adjustment
        12:    Cmd := F04023C3Adjustments(doc, cx);    //Comp3 adjustment

        5:     cmd := ProcessMultipleCmds(ProcessForm04023Math, doc, CX,[7,6]);   //C1 sales price
        8:     cmd := ProcessMultipleCmds(ProcessForm04023Math, doc, CX,[10,9]);  //C2 sales price
        11:    cmd := ProcessMultipleCmds(ProcessForm04023Math, doc, CX,[13,12]); //C3 sales price
        14:    cmd := CalcWeightedAvg(doc, [frmWellsFargo_4023]);   //calc wtAvg of main form
        46:
          begin //no recursion
            F04023C1Adjustments(doc, cx);
            F04023C2Adjustments(doc, cx);
            F04023C3Adjustments(doc, cx);
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
          ProcessForm04023Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04023Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function F04024C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,53));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 58,119,120,117,118,1,2,
    [63,65,67,69,71,73,75,77,79,81,83,85,87,89,90,94,96,98,100,102,104,106,108,110,112,114,116],length(addr)> 0);
end;

function F04024C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,122));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 127,188,189,186,187,3,4,
    [132,134,136,138,140,142,144,146,148,150,152,154,156,158,159,163,165,167,169,171,173,175,177,179,181,183,185],length(addr)> 0);
end;

function F04024C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,191));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 196,257,258,255,256,5,6,
  [201,203,205,207,209,211,213,215,217,219,221,223,225,227,228,232,234,236,238,240,242,244,246,248,250,252,254],length(addr)> 0);
end;


function ProcessForm04024Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3:     cmd := ConfigXXXInstance(doc, cx, 52,121,190, False);            //Set comparable
        4:     cmd := DivideAB(doc, mcx(cx,17), mcx(cx,38), mcx(cx,18));        //Subj Sales price/GLA
        7:     cmd := DivideAB(doc, mcx(cx,58), mcx(cx,95), mcx(cx,59));        //comp1 Sales price/GLA
        10:    cmd := DivideAB(doc, mcx(cx,127), mcx(cx,164), mcx(cx,128));     //comp2 Sales price/GLA
        13:    cmd := DivideAB(doc, mcx(cx,196), mcx(cx,233), mcx(cx,197));     //comp3 Sales price/GLA

        6:     Cmd := F04024C1Adjustments(doc, cx);    //Comp1 adjustment
        9:     Cmd := F04024C2Adjustments(doc, cx);    //Comp2 adjustment
        12:    Cmd := F04024C3Adjustments(doc, cx);    //Comp3 adjustment

        5:     cmd := ProcessMultipleCmds(ProcessForm04024Math, doc, CX,[7,6]);   //C1 sales price
        8:     cmd := ProcessMultipleCmds(ProcessForm04024Math, doc, CX,[10,9]);  //C2 sales price
        11:    cmd := ProcessMultipleCmds(ProcessForm04024Math, doc, CX,[13,12]); //C3 sales price

        14:    cmd := CalcWeightedAvg(doc, [frmWellsFargo_4024]);   //calc wtAvg of main form
        46:
          begin //no recursion
            F04024C1Adjustments(doc, cx);
            F04024C2Adjustments(doc, cx);
            F04024C3Adjustments(doc, cx);
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
          ProcessForm04024Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04024Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;

function F04025C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,41));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,46,84,85,82,83,1,2,
    [49,51,53,55,57,59,61,63,65,67,69,71,73,75,77,79,81],length(addr)> 0);
end;

function F04025C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,87));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 92,130,131,128,129,3,4,
    [95,97,99,101,103,105,107,109,111,113,115,117,119,121,123,125,127],length(addr)> 0);
end;

function F04025C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,133));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 138,176,177,174,175,5,6,
                               [141,143,145,147,149,151,153,155,157,159,161,163,165,167,169,171,173],length(addr)> 0);
end;




function ProcessForm04025Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:     cmd := ConfigXXXInstance(doc, cx, 40,86,132, False);            //Set comparable
        //Comp 1 adjustment
        3,6:   cmd := F04025C1Adjustments(doc, cx);
        //Comp 2 adjustment
        4,7:   cmd := F04025C2Adjustments(doc, cx);
        //Comp 3 adjustment
        5,8:   cmd := F04025C3Adjustments(doc, cx);
        //Calculate weighted average
          9:   cmd := CalcWeightedAvg(doc, [frmWellsFargo_4025]);
          46: begin
                 F04025C1Adjustments(doc, cx);
                 F04025C2Adjustments(doc, cx);
                 F04025C3Adjustments(doc, cx);
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
          ProcessForm04022Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //page1
          ProcessForm04025Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function F04026C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197,346
begin
  addr := GetCellString(doc, mcx(cx,57));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 61,131,132,129,130,1,2,
    [67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,102,106,108,110,112,114,116,118,120,122,124,126,128],length(addr)> 0);
end;

function F04026C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197 ,346
begin
  addr := GetCellString(doc, mcx(cx,134));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 138,208,209,206,207,3,4,
    [144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,176,178,179,183,185,187,189,191,193,195,197,199,201,203,205],length(addr)> 0);
end;

function F04026C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,211));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 215,285,286,283,284,5,6,
    [221,223,225,227,229,231,233,235,237,239,241,243,245,247,249,251,253,255,256,260,262,264,266,268,270,272,274,276,278,280,282],length(addr)> 0);
end;


function ProcessForm04026Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3:     cmd := ConfigXXXInstance(doc, cx, 56,133,210, False);             //Set comparable
        4:     cmd := DivideAB(doc, mcx(cx,16), mcx(cx,42), mcx(cx,17));         //Subj Sales price/GLA
        7:     cmd := DivideAB(doc, mcx(cx,61), mcx(cx,107), mcx(cx,62));        //comp1 Sales price/GLA
        10:    cmd := DivideAB(doc, mcx(cx,138), mcx(cx,184), mcx(cx,139));      //comp2 Sales price/GLA
        13:    cmd := DivideAB(doc, mcx(cx,215), mcx(cx,261), mcx(cx,216));      //comp3 Sales price/GLA

        6:     Cmd := F04026C1Adjustments(doc, cx);    //Comp1 adjustment
        9:     Cmd := F04026C2Adjustments(doc, cx);    //Comp2 adjustment
        12:    Cmd := F04026C3Adjustments(doc, cx);    //Comp3 adjustment

        5:     cmd := ProcessMultipleCmds(ProcessForm04026Math, doc, CX,[7,6]);   //C1 sales price
        8:     cmd := ProcessMultipleCmds(ProcessForm04026Math, doc, CX,[10,9]);  //C2 sales price
        11:    cmd := ProcessMultipleCmds(ProcessForm04026Math, doc, CX,[13,12]); //C3 sales price

        14:    cmd := CalcWeightedAvg(doc, [frmWellsFargo_4026]);   //calc wtAvg of main form
        46:
          begin //no recursion
            F04026C1Adjustments(doc, cx);
            F04026C2Adjustments(doc, cx);
            F04026C3Adjustments(doc, cx);
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
          ProcessForm04026Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04026Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;

function F04027C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197,346
begin
  addr := GetCellString(doc, mcx(cx,64));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 67,141,142,139,140,3,4,
    [79,81,83,85,87,89,91,93,95,97,99,101,102,106,110,114,118,120,122,124,126,128,130,132,134,136,138],length(addr)> 0);
end;

function F04027C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197 , 346
begin
  addr := GetCellString(doc, mcx(cx,147));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 150,224,225,222,223,5,6,
    [162,164,166,168,170,172,174,176,178,180,182,184,185,189,193,197,201,203,205,207,209,211,213,215,217,219,221],length(addr)> 0);
end;

function F04027C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,230));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 233,307,308,305,306,7,8,
    [245,247,249,251,253,255,257,259,261,263,265,267,268,272,276,280,284,286,288,290,292,294,296,298,300,302,304],length(addr)> 0);
end;

function IncomeSalePerUnitNRoom(doc: TContainer; CX: CellUID; CS, U1,U2,U3,U4, CRU, CRR: Integer): Integer;
var
  SV,UV,VR: Double;
begin
  result := 0;
  SV := GetCellValue(doc, mcx(cx,CS));

  //get number of units to calc $/unit
  UV := 0;
  if (GetCellValue(doc, mcx(cx,U1)) > 0) then UV := UV + 1;
  if (GetCellValue(doc, mcx(cx,U2)) > 0) then UV := UV + 1;
  if (GetCellValue(doc, mcx(cx,U3)) > 0) then UV := UV + 1;
  if (GetCellValue(doc, mcx(cx,U4)) > 0) then UV := UV + 1;
  if (SV <> 0) and (UV <> 0) then
    begin
      VR := SV / UV;
      result := SetCellValue(doc, mcx(cx,CRU), VR);
    end;

  //get number of rooms to calc $/room
  UV := Get4CellSumR(doc, CX, U1,U2,U3,U4);
  if (SV <> 0) and (UV <> 0) then
    begin
      VR := SV / UV;
      result := SetCellValue(doc, mcx(cx,CRR), VR);
    end;
end;

function IncomeSalePerBedRoom(doc: TContainer; CX: CellUID; CS, U1,U2,U3,U4, CR: Integer): Integer;
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

function SumSubjectUnitsNRooms(doc: TContainer; CX: CellUID; U1,U2,U3,U4, CRU, CRR: Integer): Integer;
var
  VU,VR: Double;
begin
  result := 0;

  //get number of units to calc $/unit
  VU := 0;
  if (GetCellValue(doc, mcx(cx,U1)) > 0) then VU := VU + 1;
  if (GetCellValue(doc, mcx(cx,U2)) > 0) then VU := VU + 1;
  if (GetCellValue(doc, mcx(cx,U3)) > 0) then VU := VU + 1;
  if (GetCellValue(doc, mcx(cx,U4)) > 0) then VU := VU + 1;
  if (VU <> 0) then
    result := SetCellValue(doc, mcx(cx,CRU), VU);

  //get number of rooms to calc $/room
  VR := Get4CellSumR(doc, CX, U1,U2,U3,U4);
  if (VR <> 0) then
    result := SetCellValue(doc, mcx(cx,CRR), VR);
end;

function SumSubjectBedRooms(doc: TContainer; CX: CellUID; U1,U2,U3,U4, CR: Integer): Integer;
var
  VR: Double;
begin
  result := 0;
  VR := Get4CellSumR(doc, CX, U1,U2,U3,U4);
  if (VR <> 0) then
    result := SetCellValue(doc, mcx(cx,CR), VR);
end;



function ProcessForm04027Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //GLA math ID
        3:      cmd := ConfigXXXInstance(doc, cx, 63,146,229, False);             //Set comparable
        9:      cmd := DivideAB(doc, mcx(cx,15), mcx(cx,37), mcx(cx,16));         //Subj Sales price/GLA
        10:     cmd := DivideAB(doc, mcx(cx,67), mcx(cx,100), mcx(cx,68));        //comp1 Sales price/GLA
        11:     cmd := DivideAB(doc, mcx(cx,150), mcx(cx,183), mcx(cx,151));      //comp2 Sales price/GLA
        12:     cmd := DivideAB(doc, mcx(cx,233), mcx(cx,266), mcx(cx,234));      //comp3 Sales price/GLA
        //Adjustment math ID
        13:     Cmd := F04027C1Adjustments(doc, cx);    //Comp1 adjustment
        14:     Cmd := F04027C2Adjustments(doc, cx);    //Comp2 adjustment
        15:     Cmd := F04027C3Adjustments(doc, cx);    //Comp3 adjustment
        //Sales Price
        5:     cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[10,13,17,34]);   //process C1
        6:     cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[11,14,18,35]);   //process C2
        7:     cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[12,15,19,36]);   //process C3
        28:    cmd := CalcWeightedAvg(doc, [frmWellsFargo_4027]);   //calc wtAvg of main form
    //sale per rent (rent multiplier)
        16:    cmd := DivideAB(doc, mcx(cx,15), mcx(cx,17), mcx(cx,18));       //sub rent chged
        17:    cmd := DivideAB(doc, mcx(cx,67), mcx(cx,69), mcx(cx,70));       //C1 rent chged
        18:    cmd := DivideAB(doc, mcx(cx,150), mcx(cx,152), mcx(cx,153));    //C2 rent chged
        19:    cmd := DivideAB(doc, mcx(cx,233), mcx(cx,235), mcx(cx,236));    //C3 rent chged

      //adj sales prices
        34: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[28,58,91]);   //C1
        35: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[28,59,92]);   //C2
        36: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[28,60,93]);   //C3


      //adj sales price per bedroom
        91: cmd := IncomeSalePerBedRoom(doc, cx, 67, 104,108,112,116, 73);  //C1 rooms chged
        92: cmd := IncomeSalePerBedRoom(doc, cx, 150, 187,191,195,199, 156);  //C2 rooms chged
        93: cmd := IncomeSalePerBedRoom(doc, cx, 233, 270,274,278,282, 239);  //C3 rooms chged


      //adj sales price per unit and total rooms
        58: cmd := IncomeSalePerUnitNRoom(doc, cx, 142, 103,107,111,115, 143,144);   //C1 units chged
        59: cmd := IncomeSalePerUnitNRoom(doc, cx, 225, 186,190,194,198, 226,227);  //C2 units chged
        60: cmd := IncomeSalePerUnitNRoom(doc, cx, 308, 269,273,277,281, 309,310);  //C3 units chged

        46:
          begin //no recursion
            F04027C1Adjustments(doc, cx);
            F04027C2Adjustments(doc, cx);
            F04027C3Adjustments(doc, cx);
            cmd := 0;
          end;
        20:   Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[115,117]); //sub units chged
     //sales per bedroom
        24:   Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[116,118]); //sub rooms chged
        115:  cmd := IncomeSalePerUnitNRoom(doc, cx, 15, 38,41,44,47, 19,20);  //sub units chged
        117:  cmd := SumSubjectUnitsNRooms(doc, cx, 38,41,44,47,0,0);
        116:  cmd := IncomeSalePerBedRoom(doc, cx, 15, 39,42,45,48,21);  //sub rooms chged
        118:  cmd := SumSubjectBedRooms(doc, cx, 39,42,45,48, 0);
      //calc $/unit & rooms for C1:
        37: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[61,62]);   //C1 units
        61: cmd := IncomeSalePerUnitNRoom(doc, cx, 67, 103,107,111,115, 71,72);  //C1 units chged
        62: cmd := IncomeSalePerUnitNRoom(doc, cx, 142, 103,107,111,115, 143,144);   //C1 units chged
        40: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[63,64]); //C1 bedrooms
        63: cmd := IncomeSalePerBedRoom(doc, cx, 67, 104,108,112,116, 73);  //C1 rooms chged

        64: cmd := IncomeSalePerBedRoom(doc, cx, 142, 104,108,112,116, 145);  //C1 rooms chged
      //calc $/unit & rooms for C2:
        38: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[71,72]);   //C2 units
        71: cmd := IncomeSalePerUnitNRoom(doc, cx, 150, 186,190,194,198, 154,155);  //C2 units chged
        72: cmd := IncomeSalePerUnitNRoom(doc, cx, 225, 186,190,194,198, 226,227);   //C2 units chged
        41: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[73,74]); //C2 bedrooms
        73: cmd := IncomeSalePerBedRoom(doc, cx, 150, 187,191,195,199, 156);  //C2 rooms chged
      //adj sales price per bedroom
        74: cmd := IncomeSalePerBedRoom(doc, cx, 225, 187,191,195,199, 228);  //C2 rooms chged

      //calc $/unit & rooms for C3:
        39: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[81,82]);   //C3 units
        81: cmd := IncomeSalePerUnitNRoom(doc, cx, 233, 269,273,277,281, 237,238);  //C3 units chged
        82: cmd := IncomeSalePerUnitNRoom(doc, cx, 308, 269,273,277,281, 309,310);   //C3 units chged
        42: Cmd := ProcessMultipleCmds(ProcessForm04027Math, doc, CX,[83,84]); //C3 bedrooms
        83: cmd := IncomeSalePerBedRoom(doc, cx, 233, 270,275,279,283, 239);  //C3 rooms chged
      //adj sales price per bedroom
        84: cmd := IncomeSalePerBedRoom(doc, cx, 308, 270,275,279,283, 311);  //C3 rooms chged
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04027Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04027Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function ProcessForm04035Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //GLA math ID
        1:     cmd := DivideAB(doc, mcx(cx,50), mcx(cx,67), mcx(cx,51));         //Subj Page 1 Sales price/GLA
        2:     cmd := DivideAB(doc, mcx(cx,82), mcx(cx,105), mcx(cx,83));        //comp1 Sales price/GLA
        3:     cmd := DivideAB(doc, mcx(cx,131), mcx(cx,154), mcx(cx,132));      //comp2 Sales price/GLA
        4:     cmd := DivideAB(doc, mcx(cx,180), mcx(cx,203), mcx(cx,181));      //comp3 Sales price/GLA
        5:     cmd := DivideAB(doc, mcx(cx,7), mcx(cx,24), mcx(cx,8));           //Subject Page 2 Sales price/GLA
        6:     cmd := DivideAB(doc, mcx(cx,39), mcx(cx,62), mcx(cx,40));         //comp3 Sales price/GLA
        7:     cmd := DivideAB(doc, mcx(cx,88), mcx(cx,111), mcx(cx,89));        //comp3 Sales price/GLA
        8:     cmd := DivideAB(doc, mcx(cx,137), mcx(cx,160), mcx(cx,138));      //comp3 Sales price/GLA
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;


//*****************************  ENDS WELLS FARGO FORMS

//*****************************  STARTS CHASE FORMS
function ProcessForm04031Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAB(doc, mcx(cx,60), mcx(cx,71), mcx(cx,62));        //Subj Sales price/GLA
        2: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,99), mcx(cx,90));        //comp1 Sales price/GLA
        3: cmd := DivideAB(doc, mcx(cx,116), mcx(cx,127), mcx(cx,118));     //comp2 Sales price/GLA
        4: cmd := DivideAB(doc, mcx(cx,144), mcx(cx,155), mcx(cx,146));     //comp3 Sales price/GLA
        5: cmd := DivideAB(doc, mcx(cx,11), mcx(cx,22), mcx(cx,13));        //Subj (page 2) Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,39), mcx(cx,50), mcx(cx,41));        //comp4 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,67), mcx(cx,78), mcx(cx,69));        //comp5 Sales price/GLA
        8: cmd := DivideAB(doc, mcx(cx,95), mcx(cx,106), mcx(cx,97));       //comp6 Sales price/GLA
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//*****************************  ENDS CHASE FORMS

//*****************************  STARTS VALUATION LINK ACE FORMS
//ACE math routines
//###HANDLE - this is generic - describe better and put in UMath unit
function CalcDisc(doc: TContainer; CellA, CellB, CellR: CellUID): Integer;
var
  V1,V2,VR: Double;
begin
  VR := 0;
  result := SetCellValue(doc, CellR, VR);
  if CellHasData(doc, CellA) and CellHasData(doc, CellB) then
    begin
      V1 := GetCellValue(doc, CellA);
      V2 := GetCellValue(doc, CellB);

      if V2 > 0 then
        begin
          V2 := V2 - 1.0;     //get the delta
          VR := V1 * V2;
          result := SetCellValue(doc, CellR, VR);
        end;
    end;
end;

//ACE Desktop: Adjustments
function F4088C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 107, 146, 147, 144, 145, 1, 2,
            [112, 114, 116, 118, 120, 122, 124, 125, 129, 131, 133, 135, 137, 139, 141, 143]);
end;

function F4088C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 151, 190, 191, 188, 189, 3, 4,
            [156, 158, 160, 162, 164, 166, 168, 169, 173, 175, 177, 179, 181, 183, 185, 187]);
end;

function F4088C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 195, 234, 235, 232, 233, 5, 6,
            [200, 202, 204, 206, 208, 210, 212, 213, 217, 219, 221, 223, 225, 227, 229, 231]);
end;

function F4088L1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 39, 75, 76, 73, 74, 4, 5,
            [44, 46, 48, 50, 52, 53, 58, 60, 62, 64, 66, 68, 70, 72]);
end;

function F4088L2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 83, 119, 120, 117, 118, 6, 7,
            [88, 90, 92, 94, 96, 97, 102, 104, 106, 108, 110, 112, 114, 116]);
end;

function F4088L3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 127, 163, 164, 161, 162, 8, 9,
            [132, 134, 136, 138, 140, 141, 146, 148, 150, 152, 154, 156, 158, 160]);
end;

// VALUATION LINK ACE Desktop Form. 3 sales & 3 Listing combined
function ProcessForm4088Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
var
  AvgCellUID: CellUID;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [70,5]);
        2:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [71,6]);        //comp1 cur list price * S/L ratio
        3:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [72,7]);        //comp2 cur list price * S/L ratio
        4:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [73,8]);        //comp2 cur list price * S/L ratio

        70: cmd := CalcDisc(doc, mcx(cx, 8), mcx(cx, 9), mcx(cx, 10));
        71: cmd := CalcDisc(doc, mcx(cx, 36), mcx(cx, 37), mcx(cx, 38));
        72: cmd := CalcDisc(doc, mcx(cx, 80), mcx(cx, 81), mcx(cx, 82));
        73: cmd := CalcDisc(doc, mcx(cx, 124), mcx(cx, 125), mcx(cx, 126));

        5: cmd := SumAB(doc, mcx(cx, 8), mcx(cx, 10), mcx(cx, 11));    //Subject forcasted price
        6: cmd := SumAB(doc, mcx(cx, 36), mcx(cx, 38), mcx(cx, 39));    //Comp1 forcasted price
        7: cmd := SumAB(doc, mcx(cx, 80), mcx(cx, 82), mcx(cx, 83));   //Comp2 forcasted price
        8: cmd := SumAB(doc, mcx(cx, 124), mcx(cx, 126), mcx(cx, 127));  //Comp3 forcasted price

       10:  cmd := DivideAB(doc, mcx(cx,11), mcx(cx,24), mcx(cx,12));        //Subj price/sqft
       11:  cmd := DivideAB(doc, mcx(cx,39), mcx(cx,59), mcx(cx,40));        //Comp1 price/sqft
       12:  cmd := DivideAB(doc, mcx(cx,83), mcx(cx,103), mcx(cx,84));       //Comp2 price/sqft
       13:  cmd := DivideAB(doc, mcx(cx,127), mcx(cx,147), mcx(cx,128));     //Comp3 price/sqft

       14:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [11,34]);   //Comp1 sales price changed
       15:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [12,35]);   //Comp2 sales price changed
       16:  cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX, [13,36]);   //Comp3 sales price changed

       17:  cmd := LandUseSum(doc, CX, 10, [73,74,75,76,78]);

       20: cmd := DivideAB(doc, mcx(cx,81), mcx(cx,95), mcx(cx,82));      //Subj Sales price/GLA, 81: salesprice, 95:GLA, 82: Price/SQF
       21: cmd := DivideAB(doc, mcx(cx,107), mcx(cx,130), mcx(cx,108));   //comp1 Sales price/GLA 107: salesPrice, 130: GLA, 108: price/SQF
       22: cmd := DivideAB(doc, mcx(cx,151), mcx(cx,174), mcx(cx,152));   //comp2 Sales price/GLA 151: salesprice, 174: GLA, 152: price/SQF
       23: cmd := DivideAB(doc, mcx(cx,195), mcx(cx,218), mcx(cx,196));   //comp3 Sales price/GLA 195: salesprice, 218: GLA, 196: price/SQF
       //Handle the adjustments for the sales grid
       24: cmd := F4088C1Adjustments(doc, cx);       //sum of adjs
       25: cmd := F4088C2Adjustments(doc, cx);
       26: cmd := F4088C3Adjustments(doc, cx);

       27: cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX,[21,24]); //C1 sales price
       28: cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX,[22,25]); //C2 sales price
       29: cmd := ProcessMultipleCmds(ProcessForm4088Math, doc, CX,[23,26]); //C3 sales price

       //Handle the adjustments for the listing grid
       34: cmd := F4088L1Adjustments(doc, cx);       //sum of adjs
       35: cmd := F4088L2Adjustments(doc, cx);       //sum of adjs
       36: cmd := F4088L3Adjustments(doc, cx);       //sum of adjs

       30,37: cmd := CalcWeightedAvg(doc, [frmACE_4088,frmACE_4089]);   //calc wtAvg of main and xcomps forms
       46:
         begin
           AvgCellUID := cx;
           AvgCellUID.Pg := 0;
           F4088C1Adjustments(doc, AvgCellUID);
           F4088C2Adjustments(doc, AvgCellUID);
           F4088C3Adjustments(doc, AvgCellUID);
           AvgCellUID.Pg := 1;
           F4088L1Adjustments(doc, AvgCellUID);
           F4088L2Adjustments(doc, AvgCellUID);
           F4088L3Adjustments(doc, AvgCellUID);
           cmd := 0;
         end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID, WeightedAvergeID:
        ProcessForm4088Math(doc, 46, CX);
    end;

  result := 0;
end;

//VALUATION LINK ACE XComps
function F4089C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 36,75,76,73,74,1,2,
            [41,43,45,47,49,51,53,54,58,60,62,64,66,68,70,72]);
end;

function F4089C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 81,120,121,118,119,3,4,
            [86,88,90,92,94,96,98,99,103,105,107,109,111,113,115,117]);
end;

function F4089C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 126,165,166,163,164,5,6,
            [131,133,135,137,139,141,143,144,148,150,152,154,156,158,160,162]);
end;

function ProcessForm4089Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        32:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 32,77,122);
        31:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 32,77,122, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 32,77,122);

        //Subject
        20:
          cmd := DivideAB(doc, mcx(cx,9), mcx(cx,23), mcx(cx,10));     //Subj price/sqft

        //Comp1 calcs
        27:   //sales price changed
          begin
            ProcessForm4089Math(doc, 21, CX);        //calc new price/sqft
            Cmd := F4089C1Adjustments(doc, cx);     //redo the adjustments
          end;
        24:
          cmd := F4089C1Adjustments(doc, cx);       //sum of adjs
        21:
          cmd := DivideAB(doc, mcx(cx,36), mcx(cx,59), mcx(cx,37));     //price/sqft

        //Comp2 calcs
        28:   //sales price changed
          begin
            ProcessForm4089Math(doc, 22, CX);     //calc new price/sqft
            Cmd := F4089C2Adjustments(doc, cx);   //redo the adjustments
          end;
        25:
          cmd := F4089C2Adjustments(doc, cx);     //sum of adjs
        22:
          cmd := DivideAB(doc, mcx(cx,81), mcx(cx,104), mcx(cx,82));     //price/sqft

        //Comp3 calcs
        29:   //sales price changed
          begin
            ProcessForm4089Math(doc, 23, CX);     //calc new price/sqft
            Cmd := F4089C3Adjustments(doc, cx);   //redo the adjustments
          end;
        26:
          cmd := F4089C3Adjustments(doc, cx);     //sum of adjs
        23:
          cmd := DivideAB(doc, mcx(cx,126), mcx(cx,149), mcx(cx,127));     //price/sqft

        30:
          cmd := CalcWeightedAvg(doc, [frmACE_4088,frmACE_4089]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F4089C1Adjustments(doc, cx);
            F4089C2Adjustments(doc, cx);     //sum of adjs
            F4089C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0

  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID, WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4089Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//*****************************  ENDS VALUATION LINK ACE FORMS

//*****************************  STARTS PROTECK FORMS
function ProcessForm04076Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAB(doc, mcx(cx,75), mcx(cx,87), mcx(cx,77));        //Subj Sales price/GLA
        2: cmd := DivideAB(doc, mcx(cx,105), mcx(cx,117), mcx(cx,107));     //comp1 Sales price/GLA
        3: cmd := DivideAB(doc, mcx(cx,135), mcx(cx,147), mcx(cx,137));     //comp2 Sales price/GLA
        4: cmd := DivideAB(doc, mcx(cx,165), mcx(cx,177), mcx(cx,167));     //comp3 Sales price/GLA
        5: cmd := DivideAB(doc, mcx(cx,12), mcx(cx,24), mcx(cx,14));        //Subj (page 2) Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,42), mcx(cx,54), mcx(cx,44));        //comp4 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,72), mcx(cx,84), mcx(cx,74));        //comp5 Sales price/GLA
        8: cmd := DivideAB(doc, mcx(cx,102), mcx(cx,114), mcx(cx,104));     //comp6 Sales price/GLA
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function F4099C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,97));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 103,143,144,141,142,1,2,
            [106,108,110,112,114,116,118,120,121,126,128,130,132,134,136,138,140],length(addr)> 0);
end;

function F4099C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197
begin
  addr := GetCellString(doc, mcx(cx,145));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 151,191,192,189,190,3,4,
    [154,156,158,160,162,164,166,168,169,174,176,178,180,182,184,186,188],length(addr)> 0);
end;

function F4099C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,193));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 199,239,240,237,238,5,6,
    [202,204,206,208,210,212,214,216,217,222,224,226,228,230,232,234,236],length(addr)> 0);
end;

function F4099C4Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,34));   //PAM: Ticket #1331 - need to include page #2
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 40, 80, 81, 78, 79, 1,2,
    [43, 45, 47, 49, 51, 53, 55, 57, 58, 63, 65, 67, 69, 71, 73, 75, 77],length(addr)> 0);
end;

function F4099C5Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,82));   //PAM: Ticket #1331 - need to include page #2
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 88, 128, 129, 126, 127, 3, 4,
    [91, 93, 95, 97, 99, 101, 103, 105, 106, 111, 113, 115,117, 119, 121, 123, 125],length(addr)> 0);
end;

function F4099C6Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,130));   //PAM: Ticket #1331 - need to include page #2
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 136, 176, 177, 174, 175, 5, 6,
    [139, 141, 143, 145, 147, 149, 151, 153, 154, 159, 161, 163, 165, 167, 169, 171, 173],length(addr)> 0);
end;

function ProcessForm04099Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        20: cmd := DivideAB(doc, mcx(cx,73), mcx(cx,87), mcx(cx,74));        //Subj Sales price/GLA

        5: cmd := DivideAB(doc, mcx(cx,103), mcx(cx,127), mcx(cx,104));     //comp1 Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,151), mcx(cx,175), mcx(cx,152));     //comp2 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,199), mcx(cx,223), mcx(cx,200));     //comp3 Sales price/GLA

        24: Cmd := F4099C1Adjustments(doc, cx);
        25: Cmd := F4099C2Adjustments(doc, cx);
        26: Cmd := F4099C3Adjustments(doc, cx);

        21: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[5,24]); //C1 sales price
        22: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[6,25]); //C2 sales price
        23: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[7,26]); //C2 sales price

        //Math calculation for page 2
        27: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,64), mcx(cx,41));        //comp4 Sales price/GLA
        28: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,112), mcx(cx,89));       //comp5 Sales price/GLA
        29: cmd := DivideAB(doc, mcx(cx,136), mcx(cx,160), mcx(cx,137));     //comp6 Sales price/GLA

        32: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[27,36]); //C4 sales price
        33: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[28,38]);        //comp5 Sales price
        34: cmd := ProcessMultipleCmds(ProcessForm04099Math, doc, CX,[29,40]);      //comp6 Sales price
        36: Cmd := F4099C4Adjustments(doc, cx);
        38: Cmd := F4099C5Adjustments(doc, cx);
        40: Cmd := F4099C6Adjustments(doc, cx);

        30: cmd := CalcWeightedAvg(doc, [4099]);  //page 1
        37,39,41: cmd := CalcWeightedAvg(doc, [4099]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
    else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4099C1Adjustments(doc, cx);
              F4099C2Adjustments(doc, cx);
              F4099C3Adjustments(doc, cx);

              cx.Pg := 1;  //math on page 2, 0 based
              F4099C4Adjustments(doc, cx);
              F4099C5Adjustments(doc, cx);
              F4099C6Adjustments(doc, cx);

              cmd := 0;
            end;
    end;
  result := 0;
end;

///STARTS 4264 PAM - Ticket #1331: add new math routine for form #4264
function F4264C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,97));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 103,143,144,141,142,1,2,
            [106,108,110,112,114,116,118,120,121,126,128,130,132,134,136,138,140],length(addr)> 0);
end;

function F4264C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197
begin
  addr := GetCellString(doc, mcx(cx,145));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 151,191,192,189,190,3,4,
    [154,156,158,160,162,164,166,168,169,174,176,178,180,182,184,186,188],length(addr)> 0);
end;

function F4264C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,193));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 199,239,240,237,238,5,6,
    [202,204,206,208,210,212,214,216,217,222,224,226,228,230,232,234,236],length(addr)> 0);
end;

function F4264C4Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,34));   //get the address
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 40, 80, 81, 78, 79, 1,2,
    [43, 45, 47, 49, 51, 53, 55, 57, 58, 63, 65, 67, 69, 71, 73, 75, 77],length(addr)> 0);
end;

function F4264C5Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,82));   //get the address
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 88, 128, 129, 126, 127, 3, 4,
    [91, 93, 95, 97, 99, 101, 103, 105, 106, 111, 113, 115,117, 119, 121, 123, 125],length(addr)> 0);
end;

function F4264C6Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,130));   //get the address
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 136, 176, 177, 174, 175, 5, 6,
    [139, 141, 143, 145, 147, 149, 151, 153, 154, 159, 161, 163, 165, 167, 169, 171, 173],length(addr)> 0);
end;

function ProcessForm04264Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        20: cmd := DivideAB(doc, mcx(cx,73), mcx(cx,87), mcx(cx,74));        //Subj Sales price/GLA

        5: cmd := DivideAB(doc, mcx(cx,103), mcx(cx,127), mcx(cx,104));     //comp1 Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,151), mcx(cx,175), mcx(cx,152));     //comp2 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,199), mcx(cx,223), mcx(cx,200));     //comp3 Sales price/GLA

        24: Cmd := F4264C1Adjustments(doc, cx);
        25: Cmd := F4264C2Adjustments(doc, cx);
        26: Cmd := F4264C3Adjustments(doc, cx);

        21: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[5,24]); //C1 sales price
        22: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[6,25]); //C2 sales price
        23: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[7,26]); //C2 sales price

        //Math calculation for page 2
        27: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,64), mcx(cx,41));        //comp4 Sales price/GLA
        28: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,112), mcx(cx,89));       //comp5 Sales price/GLA
        29: cmd := DivideAB(doc, mcx(cx,136), mcx(cx,160), mcx(cx,137));     //comp6 Sales price/GLA

        32: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[27,36]); //C4 sales price
        33: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[28,38]);        //comp5 Sales price
        34: cmd := ProcessMultipleCmds(ProcessForm04264Math, doc, CX,[29,40]);      //comp6 Sales price
        36: Cmd := F4264C4Adjustments(doc, cx);
        38: Cmd := F4264C5Adjustments(doc, cx);
        40: Cmd := F4264C6Adjustments(doc, cx);

        30: cmd := CalcWeightedAvg(doc, [4264]);  //page 1
        37,39,41: cmd := CalcWeightedAvg(doc, [4264]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
    else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4264C1Adjustments(doc, cx);
              F4264C2Adjustments(doc, cx);
              F4264C3Adjustments(doc, cx);

              cx.Pg := 1;  //math on page 2, 0 based
              F4264C4Adjustments(doc, cx);
              F4264C5Adjustments(doc, cx);
              F4264C6Adjustments(doc, cx);

              cmd := 0;
            end;
    end;
  result := 0;
end;


///STARTS 4249
function F4249C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,97));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 103,143,144,141,142,1,2,
            [106,108,110,112,114,116,118,120,121,126,128,130,132,134,136,138,140],length(addr)> 0);
end;

function F4249C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197
begin
  addr := GetCellString(doc, mcx(cx,145));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 151,191,192,189,190,3,4,
    [154,156,158,160,162,164,166,168,169,174,176,178,180,182,184,186,188],length(addr)> 0);
end;

function F4249C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,193));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 199,239,240,237,238,5,6,
    [202,204,206,208,210,212,214,216,217,222,224,226,228,230,232,234,236],length(addr)> 0);
end;

function F4249C4Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,34));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 40, 80, 81, 78, 79, 1,2,
    [43, 45, 47, 49, 51, 53, 55, 57, 58, 63, 65, 67, 69, 71, 73, 75, 77],length(addr)> 0);
end;

function F4249C5Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,82));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 88, 128, 129, 126, 127, 3, 4,
    [91, 93, 95, 97, 99, 101, 103, 105, 106, 111, 113, 115,117, 119, 121, 123, 125],length(addr)> 0);
end;

function F4249C6Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,130));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 136, 176, 177, 174, 175, 5, 6,
    [139, 141, 143, 145, 147, 149, 151, 153, 154, 159, 161, 163, 165, 167, 169, 171, 173],length(addr)> 0);
end;



function ProcessForm04249Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        20: cmd := DivideAB(doc, mcx(cx,73), mcx(cx,87), mcx(cx,74));        //Subj Sales price/GLA

        5: cmd := DivideAB(doc, mcx(cx,103), mcx(cx,127), mcx(cx,104));     //comp1 Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,151), mcx(cx,175), mcx(cx,152));     //comp2 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,199), mcx(cx,223), mcx(cx,200));     //comp3 Sales price/GLA

        24: Cmd := F4249C1Adjustments(doc, cx);
        25: Cmd := F4249C2Adjustments(doc, cx);
        26: Cmd := F4249C3Adjustments(doc, cx);

        21: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[5,24]); //C1 sales price
        22: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[6,25]); //C2 sales price
        23: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[7,26]); //C2 sales price

        //Math calculation for page 2
        27: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,64), mcx(cx,41));        //comp4 Sales price/GLA
        28: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,112), mcx(cx,89));       //comp5 Sales price/GLA
        29: cmd := DivideAB(doc, mcx(cx,136), mcx(cx,160), mcx(cx,137));     //comp6 Sales price/GLA

        32: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[27,36]); //C4 sales price
        33: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[28,38]);        //comp5 Sales price
        34: cmd := ProcessMultipleCmds(ProcessForm04249Math, doc, CX,[29,40]);      //comp6 Sales price
        36: Cmd := F4249C4Adjustments(doc, cx);
        38: Cmd := F4249C5Adjustments(doc, cx);
        40: Cmd := F4249C6Adjustments(doc, cx);

        30: cmd := CalcWeightedAvg(doc, [4249]);  //page 1
        37,39,41: cmd := CalcWeightedAvg(doc, [4249]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
    else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4249C1Adjustments(doc, cx);
              F4249C2Adjustments(doc, cx);
              F4249C3Adjustments(doc, cx);

              cx.Pg := 1;  //math on page 2, 0 based
              F4249C4Adjustments(doc, cx);
              F4249C5Adjustments(doc, cx);
              F4249C6Adjustments(doc, cx);

              cmd := 0;
            end;
    end;
  result := 0;
end;


///STARTS 4265 PAM - Ticket #1331: add new math routine for form #4265
function F4265C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,97));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 103,143,144,141,142,1,2,
            [106,108,110,112,114,116,118,120,121,126,128,130,132,134,136,138,140],length(addr)> 0);
end;

function F4265C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197
begin
  addr := GetCellString(doc, mcx(cx,145));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 151,191,192,189,190,3,4,
    [154,156,158,160,162,164,166,168,169,174,176,178,180,182,184,186,188],length(addr)> 0);
end;

function F4265C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,193));   //get the address
  if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 199,239,240,237,238,5,6,
    [202,204,206,208,210,212,214,216,217,222,224,226,228,230,232,234,236],length(addr)> 0);
end;

function F4265C4Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,34));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 40, 80, 81, 78, 79, 1,2,
    [43, 45, 47, 49, 51, 53, 55, 57, 58, 63, 65, 67, 69, 71, 73, 75, 77],length(addr)> 0);
end;

function F4265C5Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,82));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 88, 128, 129, 126, 127, 3, 4,
    [91, 93, 95, 97, 99, 101, 103, 105, 106, 111, 113, 115,117, 119, 121, 123, 125],length(addr)> 0);
end;

function F4265C6Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcpx(cx,2,130));   //PAM - Ticket #1331 need to include page #
  if addr <> '' then
  result := SalesGridAdjustment(doc, CX, 136, 176, 177, 174, 175, 5, 6,
    [139, 141, 143, 145, 147, 149, 151, 153, 154, 159, 161, 163, 165, 167, 169, 171, 173],length(addr)> 0);
end;



function ProcessForm04265Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        20: cmd := DivideAB(doc, mcx(cx,73), mcx(cx,87), mcx(cx,74));        //Subj Sales price/GLA

        5: cmd := DivideAB(doc, mcx(cx,103), mcx(cx,127), mcx(cx,104));     //comp1 Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,151), mcx(cx,175), mcx(cx,152));     //comp2 Sales price/GLA
        7: cmd := DivideAB(doc, mcx(cx,199), mcx(cx,223), mcx(cx,200));     //comp3 Sales price/GLA

        24: Cmd := F4265C1Adjustments(doc, cx);
        25: Cmd := F4265C2Adjustments(doc, cx);
        26: Cmd := F4265C3Adjustments(doc, cx);

        21: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[5,24]); //C1 sales price
        22: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[6,25]); //C2 sales price
        23: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[7,26]); //C2 sales price

        //Math calculation for page 2
        27: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,64), mcx(cx,41));        //comp4 Sales price/GLA
        28: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,112), mcx(cx,89));       //comp5 Sales price/GLA
        29: cmd := DivideAB(doc, mcx(cx,136), mcx(cx,160), mcx(cx,137));     //comp6 Sales price/GLA

        32: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[27,36]); //C4 sales price
        33: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[28,38]);        //comp5 Sales price
        34: cmd := ProcessMultipleCmds(ProcessForm04265Math, doc, CX,[29,40]);      //comp6 Sales price
        36: Cmd := F4265C4Adjustments(doc, cx);
        38: Cmd := F4265C5Adjustments(doc, cx);
        40: Cmd := F4265C6Adjustments(doc, cx);

        30: cmd := CalcWeightedAvg(doc, [4265]);  //page 1
        37,39,41: cmd := CalcWeightedAvg(doc, [4265]);   //calc wtAvg of main and xcomps forms
      else
        Cmd := 0;
      end;
    until Cmd = 0
    else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4265C1Adjustments(doc, cx);
              F4265C2Adjustments(doc, cx);
              F4265C3Adjustments(doc, cx);

              cx.Pg := 1;  //math on page 2, 0 based
              F4265C4Adjustments(doc, cx);
              F4265C5Adjustments(doc, cx);
              F4265C6Adjustments(doc, cx);

              cmd := 0;
            end;
    end;
  result := 0;
end;

///STARTS 4270 PAM - Ticket #1400: add new math routine for form #4270
function F4270C1Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 58,129,130,127,128,3,4,
            [63,65,67,69,71,73,75,77,79,81,83,85,86,90,94,98,102,106,108,110,112,
             114,116,118,120,122,124,126],True);
end;

function F4270C2Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX,135,206,207,204,205,5,6,
            [140,142,144,146,148,150,152,154,156,158,160,162,163,167,171,175,179,
             183,185,187,189,191,193,195,197,199,201,203],True);
end;

function F4270C3Adjustments(doc: TContainer; CX: CellUID): Integer;
begin
  result := SalesGridAdjustment(doc, CX, 212,283,284,281,282,7,8,
            [217,219,221,223,225,227,229,231,233,235,237,239,240,244,248,252,256,
             260,262,264,266,268,270,272,274,276,278,280],True);
end;


function ProcessForm04270Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        1: cmd := DivideAB(doc, mcx(cx,15), mcx(cx,25), mcx(cx,16));        //Subj Sales price/GLA

        2: cmd := DivideAB(doc, mcx(cx,58), mcx(cx,84), mcx(cx,59));        //comp1 Sales price/GLA
        5: cmd := DivideAB(doc, mcx(cx,135), mcx(cx,161), mcx(cx,136));     //comp2 Sales price/GLA
        6: cmd := DivideAB(doc, mcx(cx,212), mcx(cx,238), mcx(cx,213));     //comp3 Sales price/GLA

        4: Cmd := F4270C1Adjustments(doc, cx);
        7: Cmd := F4270C2Adjustments(doc, cx);
       10: Cmd := F4270C3Adjustments(doc, cx);

        3: cmd := ConfigXXXInstance(doc, cx,54,131,208, False);   //pass False to start with 1

        11: cmd := CalcWeightedAvg(doc, [4270]);  //page 1
      else
        Cmd := 0;
      end;
    until Cmd = 0
    else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4270C1Adjustments(doc, cx);
              F4270C2Adjustments(doc, cx);
              F4270C3Adjustments(doc, cx);
              cmd := 0;
            end;
    end;
  result := 0;
end;

//*****************************  ENDS PROTECK FORMS

//*****************************  BEGINS QSAR FORMS

function ProcessForm04160Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Ticket #1332: Math calculation for page 1
        1: cmd := DivideAB(doc, mcx(cx,55), mcx(cx,65), mcx(cx,56));        //Subj Sales price/GLA

        2: cmd := DivideAB(doc, mcx(cx,76), mcx(cx,87), mcx(cx,77));        //comp1 Sales price/GLA
        3: cmd := DivideAB(doc, mcx(cx,101), mcx(cx,112), mcx(cx,102));     //comp2 Sales price/GLA
        4: cmd := DivideAB(doc, mcx(cx,126), mcx(cx,137), mcx(cx,127));     //comp3 Sales price/GLA

      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//*****************************  ENDS QSAR FORMS

function ProcessForm04096Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := DivideAB(doc, mcx(cx,50), mcx(cx,58), mcx(cx,51));     //Subj price/sqft
        2:
          cmd := DivideAB(doc, mcx(cx,66), mcx(cx,75), mcx(cx,67));     //C1 price/sqft
        3:
          cmd := DivideAB(doc, mcx(cx,86), mcx(cx,95), mcx(cx,87));  //C2 price/sqft
        4:
          cmd := DivideAB(doc, mcx(cx,106), mcx(cx,115), mcx(cx,107));  //C3 price/sqft
        else
          cmd := 0
        end
    until cmd = 0;

    result := 0;
end;

function ProcessForm04132Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 30,49,68);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 30,49,68, 2);
        3: cmd := ConfigXXXInstance(doc, cx, 30,49,68);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function ProcessForm04133Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
var
  aListingNo: String;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: begin
             aListingNo := GetCellString(doc, MCFX(CX.form,1,30));
             aListingNo := trim(aListingNo);
             if pos('1', aListingNo) > 0 then  //if listing # is 1, 2, 3, the title should not have EXTRA wording
               cmd := SetXXXPageTitleBarName(doc, cx, 'Listings', 30,49,68)
             else
               cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 30,49,68);
           end;
        2: begin
             aListingNo := GetCellString(doc, MCFX(CX.form,1,30));
             aListingNo := trim(aListingNo);
             if pos('1', aListingNo) > 0 then  //if listing # is 1, 2, 3, the title should not have EXTRA wording
               cmd := SetXXXPageTitle(doc, cx, 'LISTINGS','', 30,49,68, 2)
             else
               cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 30,49,68, 2);
           end;
        3: cmd := ConfigXXXInstance(doc, cx, 30,49,68, False);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function ProcessForm04092Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          cmd := SumCellArray(doc, CX, [4,7,10,13,16,19,22, 25,28,31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,79,82],83);
        2:
          cmd := 0
      else
          cmd := 0
        end
    until cmd = 0;

    result := 0;
end;

function ProcessForm04137Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 30,49,68);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 30,49,68, 2);
        3: cmd := ConfigXXXInstance(doc, cx, 30,49,68);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function ProcessForm04138Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
var
  aListingNo: String;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: begin
             aListingNo := GetCellString(doc, MCFX(CX.form,1,30));
             aListingNo := trim(aListingNo);
             if pos('1', aListingNo) > 0 then  //if listing # is 1, 2, 3, the title should not have EXTRA wording
               cmd := SetXXXPageTitleBarName(doc, cx, 'Listings', 30,49,68)
             else
               cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 30,49,68);
           end;
        2: begin
             aListingNo := GetCellString(doc, MCFX(CX.form,1,30));
             aListingNo := trim(aListingNo);
             if pos('1', aListingNo) > 0 then  //if listing # is 1, 2, 3, the title should not have EXTRA wording
               cmd := SetXXXPageTitle(doc, cx, 'LISTINGS','', 30,49,68, 2)
             else
               cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 30,49,68, 2);
           end;
        3: cmd := ConfigXXXInstance(doc, cx, 30,49,68, False);
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;


//Start Clear Capital
function F4140C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,98));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 104,144,145,142,143,1,2,
    [107,109,111,113,115,117,119,121,122,127,129,131,133,135,137,139,141],length(addr) > 0);
end;

function F4140C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,146));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 152,192,193,190,191,3,4,
    [155,157,159,161,163,165,167,169,170,175,177,179,181,183,185,187,189],length(addr) > 0);
end;

function F4140C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,194));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 200,240,241,238,239,5,6,
    [203,205,207,209,211,213,215,217,218,223,225,227,229,231,233,235,237],length(addr) > 0);
end;

function F4140C4Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,34));   //get the address
  result := SalesGridAdjustment(doc, CX, 40, 80, 81, 78, 79, 1,2,
    [43, 45, 47, 49, 51, 53, 55, 57, 58, 63, 65, 67, 69, 71, 73, 75, 77],length(addr) > 0);
end;

function F4140C5Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,82));   //get the address
  result := SalesGridAdjustment(doc, CX, 88, 128, 129, 126, 127, 3, 4,
    [91, 93, 95, 97, 99, 101, 103, 105, 106, 111, 113, 115,117, 119, 121, 123, 125],length(addr) > 0);
end;

function F4140C6Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,130));   //get the address
  result := SalesGridAdjustment(doc, CX, 136, 176, 177, 174, 175, 5, 6,
    [139, 141, 143, 145, 147, 149, 151, 153, 154, 159, 161, 163, 165, 167, 169, 171, 173],length(addr) > 0);
end;


function ProcessForm04140Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        5:  cmd := DivideAB(doc, mcx(cx,104), mcx(cx,128), mcx(cx,105));     //comp1 Sales price/GLA
        6:  cmd := DivideAB(doc, mcx(cx,152), mcx(cx,176), mcx(cx,153));     //comp2 Sales price/GLA
        7:  cmd := DivideAB(doc, mcx(cx,200), mcx(cx,224), mcx(cx,201));     //comp3 Sales price/GLA
        20: cmd := DivideAB(doc, mcx(cx,74), mcx(cx,88), mcx(cx,75));        //Subj Sales price/GLA

        21: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[5,24]); //C1 sales price
        22: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[6,25]); //C2 sales price
        23: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[7,26]); //C2 sales price

        24: Cmd := F4140C1Adjustments(doc, cx);
        25: Cmd := F4140C2Adjustments(doc, cx);
        26: Cmd := F4140C3Adjustments(doc, cx);

        30: Cmd := CalcWeightedAvg(doc, [4140]);

        //Math calculation for page 2
        27: cmd := DivideAB(doc, mcx(cx,40), mcx(cx,64), mcx(cx,41));        //comp4 Sales price/GLA
        28: cmd := DivideAB(doc, mcx(cx,88), mcx(cx,112), mcx(cx,89));       //comp5 Sales price/GLA
        29: cmd := DivideAB(doc, mcx(cx,136), mcx(cx,160), mcx(cx,137));     //comp6 Sales price/GLA

        32: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[27,36]); //C4 sales price
        33: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[28,38]);        //comp5 Sales price
        34: cmd := ProcessMultipleCmds(ProcessForm04140Math, doc, CX,[29,40]);      //comp6 Sales price
        36: Cmd := F4140C4Adjustments(doc, cx);
        38: Cmd := F4140C5Adjustments(doc, cx);
        40: Cmd := F4140C6Adjustments(doc, cx);
      else
         cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of
          WeightedAvergeID:
            begin
              cx.Pg := 0; //math on page 1, 0 based
              F4140C1Adjustments(doc, cx);
              F4140C2Adjustments(doc, cx);
              F4140C3Adjustments(doc, cx);

              cx.Pg := 1;  //math on page 2, 0 based
              F4140C4Adjustments(doc, cx);
              F4140C5Adjustments(doc, cx);
              F4140C6Adjustments(doc, cx);

              cmd := 0;
            end;
        end;
  result := 0;
end;

//End Clear Capital

//*************  Start natg 4220 - Clear Capital  //ticket #1085

function F4220AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  Cmd: Integer;
begin
  result := 0;
  S1 := GetCellString(doc, MCPX(CX,1,139));   //eff age
  S2 := GetCellString(doc, MCPX(CX,3,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      Cmd := SetCellValue(doc, MCPX(CX,3,28), VR);
      ProcessForm04220Math(doc, Cmd, MCPX(CX,3,28));
    end;
end;


function F4220Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  Cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx, 144));			{bsmt sqft}
  S2 := '';
  if CellIsChecked(doc, mcx(cx, 142)) then    {bsmt descript}
    S2 := 'Full'
  else if CellIsChecked(doc, mcx(cx,143)) then
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
      cmd := SetCellString(doc, MCPX(CX,2,32), S3); //transfer to grid
      ProcessForm04220Math(doc, Cmd, MCPX(CX,2,32));
    end;

  result := 0;
end;

function F4220UADBsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  TotSqFt, FinPct: Integer;
  Cmd: Integer;
  GridCX: CellUID;
begin
  S1 := GetCellString(doc, mcx(cx, 144));			{bsmt total sqft}
  S1 := StringReplace(S1, ',', '', [rfReplaceAll]);
  S2 := GetCellString(doc, mcx(cx, 145));			{bsmt finished sqft}
  S3 := '';

  if GoodNumber(S1) then
    begin
      TotSqFt := StrToIntDef(S1, 0);
      S3 := S1 + 'sf';

      if GoodNumber(S2) and (TotSqFt > 0) then
        begin
          FinPct := StrToIntDef(S2, 0);
          S3 := S3 + IntToStr(Trunc(TotSqFt * (FinPct / 100))) + 'sf';
        end;
    end;

  if S3 = '0sf' then
    SetCellString(doc, MCPX(CX,2,33), '') //clear 2nd basement field
  else  
    if not CellIsChecked(doc, mcx(cx,146)) then
      S3 := S3 + 'in'
    else
      begin
        GridCX := CX;
        GridCX.Pg := Succ(CX.Pg);
        S1 := GetCellString(doc, mcx(GridCX, 32));			{grid bsmt sqft}
        if Length(S1) > 1 then
          begin
            S2 := Copy(S1, (Length(S1) - 1), 2);
            if (S2 = 'wo') or (S2 = 'wu') then
              S3 := S3 + S2;
          end;
      end;
  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,32), S3); //transfer to grid
      ProcessForm04220Math(doc, Cmd, MCPX(CX,2,32));
    end;

  result := 0;
end;

function F4220Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 144));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 3,18), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 3,19), V1);
      ProcessForm04220Math(doc, Cmd, MCPX(CX, 3,19));
    end;
  result := 0;
end;

function F4220BsmtFinsihed(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  S1 := GetCellString(doc, mcx(cx,145));
  if length(S1)>0 then
    S1 := S1 + '% Finished';
  result := SetCellString(doc, MCPX(cx,2,33), S1);
end;

function F4220NoCarGarage(doc: TContainer; CX: CellUID): Integer;
var
  ClrStr: String;
begin
  if CellIsChecked(doc, mcx(CX, 195)) then
    begin
      if doc.UADEnabled then
        ClrStr := '0'
      else
        ClrStr := '';
      SetCellChkMark(doc, Mcx(cx,196), False);
      SetCellChkMark(doc, Mcx(cx,199), False);
      SetCellChkMark(doc, Mcx(cx,201), False);
      SetCellString(doc, MCX(CX, 197), ClrStr);
      SetCellString(doc, MCX(CX, 198), '');
      SetCellString(doc, MCX(CX, 200), ClrStr);
      SetCellString(doc, MCX(CX, 202), ClrStr);
      SetCellChkMark(doc, Mcx(cx,203), False);
      SetCellChkMark(doc, Mcx(cx,204), False);
      SetCellChkMark(doc, Mcx(cx,205), False);
      SetCellString(doc, MCPX(CX,2,37), 'None');     //transfer to grid
    end;
  result := 0;
end;

function F4220CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 203)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,204)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,205)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,200)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,200));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,202)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,202));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,195)) Then
    SetCellChkMark(doc, MCX(cx,195), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm04220Math(doc, Cmd, MCPX(CX,2,37));
    end;
  result := 0;
end;

procedure GetUADGridGarageSpaces(theStr: String; var AttQty, DetQty, BinQty: Integer);
var
  AStrNum: String;
  Cntr: Integer;
begin
  while theStr <> '' do
    begin
      AStrNum := GetFirstNumInStr(theStr, True, Cntr);
      if length(AStrNum) > 0 then                        //we have a numeric string
        begin
          theStr := Copy(theStr, Succ(Cntr), Length(theStr));
          if Copy(theStr, 1, 2) = GAtt then
            begin
              AttQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 3, Length(theStr));
            end
          else if Copy(theStr, 1, 2) = GDet then
            begin
              DetQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 3, Length(theStr));
            end
          else if Copy(theStr, 1, 3) = GBin then
            begin
              BinQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 4, Length(theStr));
            end
          else
            theStr := '';
        end
      else
        theStr := '';
    end;
end;

function F4220UADCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
  AttChkd, DetChkd, BinChkd, GarChkd, CpChkd, DwChkd, GridMatch: Boolean;
  AttGridQty, DetGridQty, BinGridQty, ChkdQty, GridQty, GarQty: Integer;
  GarQtyStr, GridQtyStr, AttGridQtyStr, DetGridQtyStr, BinGridQtyStr: String;
  UnitQty, RemainQty: Integer;

begin
  case doc.docActiveCell.UID.Num of
    195:
      if (not CellIsChecked(doc, mcx(cx,196))) then
        SetCellValue(doc, MCX(CX,197), 0);
    196:
      if GetCellValue(doc, MCX(CX,197)) = 0 then
        SetCellChkMark(doc, mcx(cx,196), False)
      else
        SetCellChkMark(doc, mcx(cx,196), True);
    198:
      if (not CellIsChecked(doc, mcx(cx,199))) then
        SetCellValue(doc, MCX(CX,200), 0);
    199:
      if GetCellValue(doc, MCX(CX,200)) = 0 then
        SetCellChkMark(doc, mcx(cx,199), False)
      else
        SetCellChkMark(doc, mcx(cx,199), True);
    200:
      if (not CellIsChecked(doc, mcx(cx,201))) then
        SetCellValue(doc, MCX(CX,202), 0);
    201:
      if GetCellValue(doc, MCX(CX,202)) = 0 then
        SetCellChkMark(doc, mcx(cx,201), False)
      else
        SetCellChkMark(doc, mcx(cx,201), True);
  end;

  S1 := '';
  S3 := '';
  ChkdQty := 0;
  GarQty := Round(GetCellValue(doc, mcx(cx,200)));
  GarQtyStr := IntToStr(GarQty);
  if CellIsChecked(doc, mcx(cx, 203)) then
    begin
      ChkdQty := Succ(ChkdQty);
      AttChkd := True;
    end
  else
    AttChkd := False;
  if CellIsChecked(doc, mcx(cx, 204)) then
    begin
      ChkdQty := Succ(ChkdQty);
      DetChkd := True;
    end
  else
    DetChkd := False;
  if CellIsChecked(doc, mcx(cx, 205)) then
    begin
      ChkdQty := Succ(ChkdQty);
      BinChkd := True;
    end
  else
    BinChkd := False;
  if GarQty > 0 then
    begin
      SetCellChkMark(doc, MCX(cx,199), True);    //make sure the Garage checkbox is checked
      if ChkdQty <= 1 then
        begin
          if AttChkd then
            begin
              S1 := GAtt;
              ClearCheckMark(doc, MCX(cx,204));    //make sure the Detached checkbox is unchecked
              ClearCheckMark(doc, MCX(cx,205));    //make sure the Built-In checkbox is unchecked
            end
          else if DetChkd then
            begin
              S1 := GDet;
              ClearCheckMark(doc, MCX(cx,205));    //make sure the Built-In checkbox is unchecked
            end
          else if BinChkd then
            S1 := GBin
          else
            begin
              S1 := GAtt;
              SetCellChkMark(doc, MCX(cx,203), True);     //make sure the Attached checkbox is checked
            end;
          S3 := GarQtyStr + S1;
        end
      else
        begin
          // If there's not enough cars declared to cover the number of checked boxes then we
          //  must uncheck one, or more of the boxes.
          if GarQty < ChkdQty then
            begin
              RemainQty := GarQty;
              if AttChkd then
                RemainQty := Pred(RemainQty);
              if RemainQty = 0 then
                begin
                  ClearCheckMark(doc, MCX(cx,204));    //make sure the Detached checkbox is unchecked
                  ClearCheckMark(doc, MCX(cx,205));    //make sure the Built-In checkbox is unchecked
                end
              else if DetChkd then
                RemainQty := Pred(RemainQty);
              if RemainQty = 0 then
                ClearCheckMark(doc, MCX(cx,205));    //make sure the Built-In checkbox is unchecked
            end;
          AttGridQty := 0;
          DetGridQty := 0;
          BinGridQty := 0;
          GridQtyStr := GetCellString(doc, MCPX(CX,2,37));   //grid data
          if Length(GridQtyStr) > 0 then
            GetUADGridGarageSpaces(GridQtyStr, AttGridQty, DetGridQty, BinGridQty);
          AttGridQtyStr := IntToStr(AttGridQty);
          DetGridQtyStr := IntToStr(DetGridQty);
          BinGridQtyStr := IntToStr(BinGridQty);
          GridQty := AttGridQty + DetGridQty + BinGridQty;
          GridMatch := (GarQty = GridQty);
          if GridMatch then
            GridMatch := (((AttGridQty > 0) and AttChkd) or ((AttGridQty = 0) and (not AttChkd)));
          if GridMatch then
            GridMatch := (((DetGridQty > 0) and DetChkd) or ((DetGridQty = 0) and (not DetChkd)));
          if GridMatch then
            GridMatch := (((BinGridQty > 0) and BinChkd) or ((BinGridQty = 0) and (not BinChkd)));
          // If the grid matches the checkbox states and the garage quantity equal the total
          //  of the grid quantites then we want to preserve the grid text format.
          if GridMatch then
            begin
              if AttGridQty > 0 then
                S3 := S3 + AttGridQtyStr + GAtt;
              if DetGridQty > 0 then
                S3 := S3 + DetGridQtyStr + GDet;
              if BinGridQty > 0 then
                S3 := S3 + BinGridQtyStr + GBin;
            end
          else
            // If GridMatch is false then either the garage quantity does not equal the total
            //  of the grid quantites or one of the grid quantites does not match the corresponding
            //  checkbox state. In this case we have to make assumptions about how many spaces there
            //  are for each type of storage. We assign each the same quantity and the remainder to
            //  the first box checked. Example:
            //    Attached & Detached are checked and the garage # cars is 3.
            //    The grid text will be "2ga1gd..."
            begin
              if ChkdQty > GarQty then
                begin
                  UnitQty := 1;
                  RemainQty := 0;
                end
              else
                begin
                  UnitQty := GarQty div ChkdQty;
                  RemainQty := GarQty mod ChkdQty;
                end;
              if AttChkd then
                begin
                  S3 := S3 + IntToStr(UnitQty + RemainQty) + GAtt;
                  GarQty := GarQty - UnitQty - RemainQty;
                  RemainQty := 0;
                end;
              if (GarQty > 0) then
                begin
                  if DetChkd then
                    begin
                      S3 := S3 + IntToStr(UnitQty + RemainQty) + GDet;
                      GarQty := GarQty - UnitQty - RemainQty;
                      RemainQty := 0;
                    end;
                end;
              if (GarQty > 0) then
                begin
                  if BinChkd then
                    S3 := S3 + IntToStr(UnitQty + RemainQty) + GBin;
                end;
            end;
        end;
    end;
  if CellIsChecked(doc, mcx(cx,199)) then
    begin
      GarChkd := True;
      if length(S3) = 0 then
        S3 := 'ga';
    end
  else
    GarChkd := False;
  if CellIsChecked(doc, mcx(cx,201)) then
    begin
      CpChkd := True;
      if (GetCellValue(doc, mcx(cx,202)) > 0) then
        S2 := GetCellString(doc, mcx(cx,202));
      S3 := S3 + S2 + 'cp';
    end
  else
    CpChkd := False;
  if CellIsChecked(doc, mcx(cx,196)) then
    begin
      DwChkd := True;
      if (GetCellValue(doc, mcx(cx,197)) > 0) then
        S2 := GetCellString(doc, mcx(cx,197));
      S3 := S3 + S2 + 'dw';
    end
  else
    DwChkd := False;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,195)) Then
    SetCellChkMark(doc, MCX(cx,195), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm04220Math(doc, Cmd, MCPX(CX,2,37));
    end
  else
    begin //NOTE: this is wrong, we should check all 3 check boxes and also check all 3 # cars before set it to None
//      if (not DwChkd) and (not GarChkd) and (not CpChkd) then
      if (not DwChkd) and (not GarChkd) and (not CpChkd) and
         (GetCellValue(doc, mcx(cx,197))=0) and //# of driveway
         (GetCellValue(doc, mcx(cx,200))=0) and //# oF garage
         (GetCellValue(doc, mcx(cx,202))=0) then //#of carport
        begin
          SetCellChkMark(doc, MCX(cx,195), True);       //make sure we check None for cars
          F4220NoCarGarage(doc, cx);
          cmd := SetCellString(doc, MCPX(CX,2,37), 'None'); //transfer to grid
          ProcessForm04220Math(doc, Cmd, MCPX(CX,2,37));
        end;
    end;
  result := 0;
end;

function F4220UADGridCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  TmpCell: TBaseCell;
  S1, S3: string;
  cmd, PosIdx, CarNum, TotCarNum, EndIdx: Integer;
begin
  TotCarNum := 0;
  S1 := Trim(GetCellString(doc, MCPX(cx,2,37)));   //Grid text
  if S1 <> 'None' then
    begin
      TmpCell := doc.GetCell(MCPX(cx,1,195));
      TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,1,203));
      PosIdx := Pos('ga', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := CarNum;
          S1 := Copy(S1, (PosIdx+2), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,1,204));
      PosIdx := Pos('gd', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := TotCarNum + CarNum;
          S1 := Copy(S1, (PosIdx+2), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,1,205));
      PosIdx := Pos('gbi', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := TotCarNum + CarNum;
          S1 := Copy(S1, (PosIdx+3), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,1,199));
      if TotCarNum > 0 then
       TmpCell.DoSetText('X')
      else
       TmpCell.DoSetText(' ');
      SetCellString(doc, MCPX(CX,1,200), IntToStr(TotCarNum));         //Garage # of Cars

      TmpCell := doc.GetCell(MCPX(cx,1,201));
      CarNum := 0;
      PosIdx := Pos('cp', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          S1 := Copy(S1, (PosIdx+2), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');
      SetCellString(doc, MCPX(CX,1,202), IntToStr(CarNum));             //Carport # of Cars

      TmpCell := doc.GetCell(MCPX(cx,1,196));
      CarNum := 0;
      PosIdx := Pos('dw', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          S1 := Copy(S1, (PosIdx+2), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');
      SetCellString(doc, MCPX(CX,1,197), IntToStr(CarNum));             //Driveway # of Cars

    end
  else
    begin
      SetCellChkMark(doc, MCPX(CX,1,196), False);      //Driveway
      SetCellString(doc, MCPX(CX,1,197), '0');         //Driveway # of Cars
      SetCellString(doc, MCPX(CX,1,198), '');          //Parking Surface
      SetCellChkMark(doc, MCPX(CX,1,199), False);      //Garage
      SetCellString(doc, MCPX(CX,1,200), '0');         //Garage # of Cars
      SetCellChkMark(doc, MCPX(CX,1,201), False);      //Carport
      SetCellString(doc, MCPX(CX,1,202), '0');         //Carport # of Cars
      SetCellChkMark(doc, MCPX(CX,1,203), False);      //Attached
      SetCellChkMark(doc, MCPX(CX,1,204), False);      //Detached
      SetCellChkMark(doc, MCPX(CX,1,205), False);      //Built-in
      SetCellChkMark(doc, MCPX(CX,1,195), True);       //None
    end;

  result := 0;
end;

function F4220UADDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,130));   //Stories
  if CellIsChecked(doc, mcx(cx,131)) then
    begin
      S1 := ResidAttachType[0] + S1;
      ClearCheckMark(doc, MCX(cx,132));    //make sure the Attached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,133));    //make sure the Semi-Detached checkbox is unchecked
    end
  else if CellIsChecked(doc, mcx(cx,132)) then
    begin
      S1 := ResidAttachType[1] + S1;
      ClearCheckMark(doc, MCX(cx,131));    //make sure the Detached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,133));    //make sure the Semi-Detached checkbox is unchecked
    end
  else if CellIsChecked(doc, mcx(cx,133)) then
    begin
      S1 := ResidAttachType[2] + S1;
      ClearCheckMark(doc, MCX(cx,131));    //make sure the Detached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,132));    //make sure the Attached checkbox is unchecked
    end;
  if Length(S1) > 0 then
    S1 := S1 + ';' + GetCellString(doc, mcx(cx,137));   //Design (Style) description
  if length(S1) > 0 then
    cmd := SetCellString(doc, MCPX(CX,2,24), S1); //transfer to grid
  result := 0;
end;

function F4220UADGridDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd, PosIdx: Integer;
begin
  S1 := GetCellString(doc, MCX(cx,24));   //Grid text
  PosIdx := Pos(ResidAttachType[0], S1);
  if PosIdx = 1 then
    SetCellChkMark(doc, MCPX(CX,1,131), True)       //Detached type
  else
    begin
      PosIdx := Pos(ResidAttachType[1], S1);
      if PosIdx = 1 then
        SetCellChkMark(doc, MCPX(CX,1,132), True)   //Attached type
      else
        begin
          PosIdx := Pos(ResidAttachType[2], S1);
          if PosIdx = 1 then
            SetCellChkMark(doc, MCPX(CX,1,133), True)   //Semi-Detached type
        end;
    end;

  // if we found an attachment type strip it from the text
  if PosIdx = 1 then
    S1 := Copy(S1, 3, Length(S1));

  if Length(S1) > 0 then
    begin
      PosIdx := Pos(';', S1);
      if PosIdx > 0 then
        begin
          //only transfer the stories or description if they changed - otherwise
          // math for these cells will re-fire causing unwanted results ex. "2.50" --> "2"
          S2 := Copy(S1, 1, Pred(PosIdx));
          if GetCellString(doc, MCPX(CX,1,130)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,130), S2); //transfer stories
          S2 := Copy(S1, Succ(PosIdx), Length(S1));
          if GetCellString(doc, MCPX(CX,1,137)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,137), S2); //transfer description
        end
      else // no type so just put everything in the Design (Style) description field
        cmd := SetCellString(doc, MCPX(CX,1,137), S1);
    end;
  result := 0;
end;

function F4220NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 168), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 165), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 169), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 166), False);    //floor
      SetCellChkMark(doc, mcx(CX, 170), False);    //heated
      SetCellChkMark(doc, mcx(CX, 167), False);    //finished
    end;
  result := 0;
end;

function F4220HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 171)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,172)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,173)) then     //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,175));   //other source


  S2 := '';
  if CellIsChecked(doc, mcx(cx, 177)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,178)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,180));   //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,2,35), S1);   //transfer to grid
      ProcessForm04220Math(doc, cmd, MCPX(CX,2,35));
    end;
  result := 0;
end;

function F4220Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 180 then
      begin
        if (not CellIsChecked(doc, mcx(cx,181))) then
          SetCellValue(doc, MCX(CX,182), 0);
      end
    else if doc.docActiveCell.UID.Num = 181 then
      if GetCellValue(doc, MCX(CX,182)) = 0 then
        SetCellChkMark(doc, mcx(cx,181), False)              
      else if GetCellString(doc, MCX(CX,182)) <> '' then
        SetCellChkMark(doc, mcx(cx,181), True);              

  V1 := Trunc(GetCellValue(doc, mcx(cx, 182)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces');   //heading
      Cmd := SetCellString(doc, MCPX(CX,2,40), S1);        //cell result
      ProcessForm04220Math(doc, cmd, MCPX(CX,2,40));
    end
  else if not CellIsChecked(doc, mcx(cx,181)) then
    if doc.UADEnabled then
      begin
        SetCellValue(doc, MCX(CX,182), 0);              //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces'); //heading
        Cmd := SetCellString(doc, MCPX(CX, 2,40), '0');    //cell result
        ProcessForm04220Math(doc, cmd, MCPX(CX,2,40));
      end
    else
      begin
        if GetCellValue(doc, mcx(cx, 182)) > 0 then
          SetCellString(doc, MCX(CX,182), '');               //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), '');           //heading
        cmd := SetCellString(doc, MCPX(CX, 2,40), '');     //cell result
        ProcessForm04220Math(doc, cmd, MCPX(CX,2,40));
      end;
  result := 0;
end;

function F4220Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 184 then
      begin
        if (not CellIsChecked(doc, mcx(cx,185))) then
          SetCellString(doc, MCX(CX,186), 'None');
      end
    else if doc.docActiveCell.UID.Num = 185 then
      if Uppercase(GetCellString(doc, MCX(CX,186))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,185), False);
          SetCellString(doc, MCX(CX,186), 'None');
        end
      else if GetCellString(doc, MCX(CX,186)) <> '' then
        SetCellChkMark(doc, mcx(cx,185), True);              

  if CellIsChecked(doc, mcx(cx,185)) then
    begin
      S1 := GetCellString(doc, mcx(cx,186));
      if not doc.UADEnabled then
        S1 := 'Pool/' + S1
      else
        begin
          if Length(S1) = 0 then
            S1 := ''
          else if trim(S1) = 'None' then
            S1 := '';
        end;
      SetCellString(doc, MCPX(CX, 2,41), 'Pool');         //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), S1);      //cell result
      ProcessForm04220Math(doc, cmd, MCPX(CX, 2,42));
    end

  else if not CellIsChecked(doc, mcx(cx,185)) then
    if doc.UADEnabled then
      begin
        SetCellString(doc, MCX(CX,186), 'None');            //pool desc
        SetCellString(doc, MCPX(CX, 2,41), 'Pool');         //heading
        cmd := SetCellString(doc, MCPX(CX,2,42), '');   //cell result
        ProcessForm04220Math(doc, cmd, MCPX(CX,2,42));
      end
    else if CellHasWord(doc, MCPX(CX,2,41), 'Pool') then
      begin
        SetCellString(doc, MCX(CX,186), '');                //pool desc
        SetCellString(doc, MCPX(CX, 2,41), '');             //heading
        cmd := SetCellString(doc, MCPX(CX,2,42), '');       //cell result
        ProcessForm04220Math(doc, cmd, MCPX(CX,2,42));
      end;
  result := 0;
end;

function F4220PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  if doc.UADEnabled then
    case doc.docActiveCell.UID.Num of     //Ticket #1129
      182:
        if (not CellIsChecked(doc, mcx(cx,183))) then
          SetCellString(doc, MCX(CX,184), 'None');
      183:
        if Uppercase(GetCellString(doc, MCX(CX,184))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,183), False);
            SetCellString(doc, MCX(CX,184), 'None');
          end
        else if GetCellString(doc, MCX(CX,184)) <> '' then
          SetCellChkMark(doc, mcx(cx,183), True);
      190:
        if (not CellIsChecked(doc, mcx(cx,191))) then
          SetCellString(doc, MCX(CX,192), 'None');
      191:
        if Uppercase(GetCellString(doc, MCX(CX,192))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,191), False);
            SetCellString(doc, MCX(CX,192), 'None');
          end
        else if GetCellString(doc, MCX(CX,192)) <> '' then
          SetCellChkMark(doc, mcx(cx,191), True);
    end;
//Ticket #1129:  if porch none is checked, set porch to EMPTY, abbreviate porch as Pch, patio as Pat  Deck as Dck
  S1:= '';
  if CellIsChecked(doc, mcx(CX, 183)) then
    begin
      S1 := 'Patio/Deck';
    end;

  //set the porch
  if CellIsChecked(doc, mcx(CX, 191)) then
    begin
      if length(S1) > 0 then
        S1 := conCat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

     cmd := SetCellString(doc, MCPX(CX,2,38), S1); //transfer to grid
     ProcessForm04220Math(doc, cmd, MCPX(CX,2,38));
  result := 0;
end;

function F4220Woodstove(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 186 then
      begin
        if (not CellIsChecked(doc, mcx(cx,187))) then
          SetCellValue(doc, MCX(CX,188), 0);               
      end
    else if doc.docActiveCell.UID.Num = 187 then
      if GetCellValue(doc, MCX(CX,188)) = 0 then
        SetCellChkMark(doc, mcx(cx,187), False)
      else if GetCellString(doc, MCX(CX,188)) <> '' then
        SetCellChkMark(doc, mcx(cx,187), True);
  result := 0;
end;

function F4220Fence(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 188 then
      begin
        if (not CellIsChecked(doc, mcx(cx,189))) then
          SetCellString(doc, MCX(CX,190), 'None');
      end
    else if doc.docActiveCell.UID.Num = 189 then
      if Uppercase(GetCellString(doc, MCX(CX,190))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,189), False);
          SetCellString(doc, MCX(CX,190), 'None');
        end
      else if GetCellString(doc, MCX(CX,190)) <> '' then
        SetCellChkMark(doc, mcx(cx,189), True);
  result := 0;
end;

function F4220OtherAmenity(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 192 then
      begin
        if (not CellIsChecked(doc, mcx(cx,193))) then
          SetCellString(doc, MCX(CX,194), 'None');             
      end
    else if doc.docActiveCell.UID.Num = 193 then
      if Uppercase(GetCellString(doc, MCX(CX,194))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,193), False);
          SetCellString(doc, MCX(CX,194), 'None');
        end
      else if GetCellString(doc, MCX(CX,194)) <> '' then
        SetCellChkMark(doc, mcx(cx,193), True);              
  result := 0;
end;

function F4220CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3, VR: double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,30));    //funct depr percent
  V2 := GetCellValue(doc, mcx(cx,27));    //new cost
  V3 := GetCellValue(doc, mcx(cx,29));    //Phy Depr
  if (V2-V3)>0 then                       //phy depr cannot be larger
    begin
      VR := (V2-V3)*(V1/100);
      result := SetCellValue(doc, mcx(cx,31), VR);
    end;
end;

//calc external depr
function F4220CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,32));    //extrn depr percent
  V2 := GetCellValue(doc, mcx(cx,27));    //new cost
  V3 := GetCellValue(doc, mcx(cx,29));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,31));    //Funct Depr
  if (V2-V3-V4) > 0 then
    begin
      VR := (V2-V3-V4)*(V1/100);
      result := SetCellValue(doc, mcx(cx,33), VR);
    end;
end;

//Function depr percent
function F4220CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,31));    //funct depr
  V2 := GetCellValue(doc, mcx(cx,27));    //new cost
  V3 := GetCellValue(doc, mcx(cx,29));    //Phy Depr
  if (V2-V3) > 0 then
    begin
      VR := V1/(V2-V3)*100;
      result := SetCellValue(doc, mcx(cx,30), VR);
    end;
end;

//external depr percent
function F4220CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
var
  V1,V2,V3,V4,VR: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx,33));    //extrn depr
  V2 := GetCellValue(doc, mcx(cx,27));    //new cost
  V3 := GetCellValue(doc, mcx(cx,29));    //Phy Depr
  V4 := GetCellValue(doc, mcx(cx,31));    //Funct Depr
  if V3 < 0 then V3 := 0;
  if V4 < 0 then V4 := 0;
  if (V2-V3-V4)>0 then
    begin
      VR := (V1/(V2-V3-V4))*100;
      result := SetCellValue(doc, mcx(cx,32), VR);
    end;
end;




function F4220C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,103,104,101,102,2,3,
      [53,55,57,59,61,63,65,67,69,71,73,74,78,80,82,84,86,88,90,92,94,96,98,100],length(addr) > 0);
end;

function F4220C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 108,163,164,161,162,4,5,
    [113,115,117,119,121,123,125,127,129,131,133,134,138,140,142,144,146,148,150,152,154,156,158,160], length(addr) > 0);
end;

function F4220C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,165));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 168,223,224,221,222,6,7,
    [173,175,177,179,181,183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214,216,218,220], length(addr) > 0);
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


//Ticket #1085: Clear Capital
function ProcessForm04220Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX, 2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,86));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2,26), ProcessForm04220Math);
        4:  Cmd := F4220AgeLifeDepr(doc, CX);
        5:  Cmd := F4220Bsmt2Cost(doc, CX);            //for cost approach
        6:
          if not doc.UADEnabled then
            Cmd := F4220Bsmt2Grid(doc, CX)  //for grid
          else
            Cmd := F4220UADBsmt2Grid(doc, CX);         //for grid in UAD reports
        8:  Cmd := F4220NoCarGarage(doc, CX);          //clears out cells when no garage
        9:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADCarStorage(doc, CX)            //transfer std garage-carport-driveway to grid
          else
            Cmd := F4220CarStorage(doc, CX);        //transfer UAD garage-carport-driveway to grid
        10: Cmd := F4220NoAttic(doc, mcx(CX, 164));    //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 164), False);    //make sure no Attic is not checked
        12: Cmd := F4220HeatingCooling(doc, CX);      //transfer to grid
        13: Cmd := F4220Fireplaces(doc, cx);          //transfer to grid
        14: Cmd := F4220Pools(doc, CX);               //transfer to grid
        15: Cmd := F4220PatioDeckPorch(doc, CX);      //trasnfer to grid
        16: Cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[5,6]);
        17: Cmd := LandUseSum(doc, CX, 2, [76,77,78,79,81]);
        18:
          if not doc.UADEnabled then
            Cmd := F4220BsmtFinsihed(doc, CX)        //transfer the finished amt
          else
            Cmd := 0;
        19: Cmd := F4220Woodstove(doc, CX);
        20:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        21:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        22:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        23:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        24:
          Cmd := F4220C1Adjustments(doc, cx);
        25:
          Cmd := F4220C2Adjustments(doc, cx);
        26:
          Cmd := F4220C3Adjustments(doc, cx);
        27:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[21,24]); //C1 sales price
        28:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[22,25]); //C2 sales price
        29:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[23,26]); //C3 sales price
        30:  //main and extra comp
          cmd := CalcWeightedAvg(doc, [4220,363]);   //calc wtAvg of main and xcomps forms

        31:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        32:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        33:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        34:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        35:
          if appPref_AppraiserCostApproachIncludeOpinionValue then
            cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37)) //sum site & improvements
          else
            cmd := SumAB(doc,mcx(cx,35), mcx(cx,36), mcx(cx,37));
        36:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        37:
          cmd := F4220CalcDeprLessPhy(doc, cx);           //funct depr entered
        38:
          cmd := F4220CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        39:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F4220CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F4220CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm04220Math(doc, 43, CX); //sum the deprs
          end;
        40:
          begin //functional depr entered directly
            F4220CalcPctLessPhy(doc, cx);            //recalc the new precent
            F4220CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm04220Math(doc, 43, CX);  //sum the deprs
          end;
        41:
          begin
            F4220CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm04220Math(doc, 43, CX);  //sum the deprs
          end;
        42:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost
        43:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        44:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);
        45:
          cmd := MultAB(doc, mcx(cx,38), mcx(cx,39), mcx(cx,40));    //calc income approach

        46:
          begin //no recursion
            F4220C1Adjustments(doc, cx);
            F4220C2Adjustments(doc, cx);
            F4220C3Adjustments(doc, cx);
            cmd := 0;
          end;
        47: Cmd := F4220Fence(doc, CX);
        48: Cmd := F4220OtherAmenity(doc, CX);

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));  //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));  //trans income
        53:
          begin
           ProcessForm04220Math(doc, 44, CX);
           cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));  //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));  //indicated value
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADDesignStyle(doc, CX)       //transfer UAD design-style to grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADGridDesignStyle(doc, CX)    //transfer UAD design-style from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        92:
          if doc.UADEnabled then
            Cmd := F4220UADGridCarStorage(doc, CX)     //transfer UAD car storage from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04220Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04220Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;
//End Clear Capital

//Start Waiv Valuation
function F4230C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,36));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 39,70,71,68,69,6,7,
      [41, 43, 45, 47, 49, 51, 55, 57, 59, 61, 63, 65, 67],length(addr) > 0);
end;

function F4230C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,76));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 79,110,111,108,109,8,9,
    [81, 83, 85, 87, 89, 91, 95, 97, 99, 101, 103, 105, 107], length(addr) > 0);
end;

function F4230C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,116));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 119,150,151,148,149,10,11,
    [121, 123, 125, 127, 129, 131, 135, 137, 139, 141, 143, 145, 147], length(addr) > 0);
end;



function ProcessForm04230Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: Cmd := F4230C1Adjustments(doc, cx);
        4: Cmd := F4230C2Adjustments(doc, cx);
        5: Cmd := F4230C3Adjustments(doc, cx);
        6: cmd := CalcWeightedAvg(doc, [4230]);   //calc wtAvg of main and xcomps forms
        14:cmd := ProcessMultipleCmds(ProcessForm04230Math, doc, CX,[11,3]); //C1 sales price
        15:cmd := ProcessMultipleCmds(ProcessForm04230Math, doc, CX,[12,4]); //C2 sales price
        16:cmd := ProcessMultipleCmds(ProcessForm04230Math, doc, CX,[13,5]); //C2 sales price
        46:
          begin //no recursion
            F4230C1Adjustments(doc, cx);
            F4230C2Adjustments(doc, cx);
            F4230C3Adjustments(doc, cx);
            cmd := 0;
          end;
(*
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX, 2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,86));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2,26), ProcessForm04220Math);
        4:  Cmd := F4220AgeLifeDepr(doc, CX);
        5:  Cmd := F4220Bsmt2Cost(doc, CX);            //for cost approach
        6:
          if not doc.UADEnabled then
            Cmd := F4220Bsmt2Grid(doc, CX)  //for grid
          else
            Cmd := F4220UADBsmt2Grid(doc, CX);         //for grid in UAD reports
        8:  Cmd := F4220NoCarGarage(doc, CX);          //clears out cells when no garage
        9:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADCarStorage(doc, CX)            //transfer std garage-carport-driveway to grid
          else
            Cmd := F4220CarStorage(doc, CX);        //transfer UAD garage-carport-driveway to grid
        10: Cmd := F4220NoAttic(doc, mcx(CX, 164));    //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 164), False);    //make sure no Attic is not checked
        12: Cmd := F4220HeatingCooling(doc, CX);      //transfer to grid
        13: Cmd := F4220Fireplaces(doc, cx);          //transfer to grid
        14: Cmd := F4220Pools(doc, CX);               //transfer to grid
        15: Cmd := F4220PatioDeckPorch(doc, CX);      //trasnfer to grid
        16: Cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[5,6]);
        17: Cmd := LandUseSum(doc, CX, 2, [76,77,78,79,81]);
        18:
          if not doc.UADEnabled then
            Cmd := F4220BsmtFinsihed(doc, CX)        //transfer the finished amt
          else
            Cmd := 0;
        19: Cmd := F4220Woodstove(doc, CX);
        21:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        22:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        23:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        25:
          Cmd := F4220C2Adjustments(doc, cx);
        26:
          Cmd := F4220C3Adjustments(doc, cx);
        27:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[21,24]); //C1 sales price
        28:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[22,25]); //C2 sales price
        29:
          cmd := ProcessMultipleCmds(ProcessForm04220Math, doc, CX,[23,26]); //C3 sales price

        31:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        32:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        33:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        34:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        35:
          if appPref_AppraiserCostApproachIncludeOpinionValue then
            cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37)) //sum site & improvements
          else
            cmd := SumAB(doc,mcx(cx,35), mcx(cx,36), mcx(cx,37));
        36:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        37:
          cmd := F4220CalcDeprLessPhy(doc, cx);           //funct depr entered
        38:
          cmd := F4220CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        39:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F4220CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F4220CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm04220Math(doc, 43, CX); //sum the deprs
          end;
        40:
          begin //functional depr entered directly
            F4220CalcPctLessPhy(doc, cx);            //recalc the new precent
            F4220CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm04220Math(doc, 43, CX);  //sum the deprs
          end;
        41:
          begin
            F4220CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm04220Math(doc, 43, CX);  //sum the deprs
          end;
        42:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost
        43:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        44:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);
        45:
          cmd := MultAB(doc, mcx(cx,38), mcx(cx,39), mcx(cx,40));    //calc income approach

        46:
          begin //no recursion
            F4220C1Adjustments(doc, cx);
            F4220C2Adjustments(doc, cx);
            F4220C3Adjustments(doc, cx);
            cmd := 0;
          end;
        47: Cmd := F4220Fence(doc, CX);
        48: Cmd := F4220OtherAmenity(doc, CX);

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));  //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));  //trans income
        53:
          begin
           ProcessForm04220Math(doc, 44, CX);
           cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));  //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));  //indicated value
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADDesignStyle(doc, CX)       //transfer UAD design-style to grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F4220UADGridDesignStyle(doc, CX)    //transfer UAD design-style from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        92:
          if doc.UADEnabled then
            Cmd := F4220UADGridCarStorage(doc, CX)     //transfer UAD car storage from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
*)
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04230Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04230Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


//End Waiv Valuation






//Start Commercial Summary
function F4125C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,35));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 39,73,74,71,72,1,2,
    [43,45,47,49,53,55,57,59,61,63,65,67,69],length(addr) > 0);
end;

function F4125C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,75));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,79,113,114,111,112,3,4,
    [83,85,87,89,93,95,97,99,101,103,105,107,109],length(addr) > 0);
end;

function F4125C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,115));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,119,153,154,151,152,5,6,
    [123,125,127,129,133,135,137,139,141,143,145,147,149],length(addr) > 0);
end;

function ProcessForm04125Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 2
        5,6: Cmd := F4125C1Adjustments(doc, cx);
        8,7: Cmd := F4125C2Adjustments(doc, cx);
        11,9: Cmd := F4125C3Adjustments(doc, cx);

      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

//End Commercial Summary

//
//github 246: Start Valuation Report 4151
function F4151C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197,346
begin
  addr := GetCellString(doc, mcx(cx,35));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 39,68,69,66,67,4,5,
            [41,43,45,47,49,51,53,54,57,59,61,63,65],length(addr) > 0);
end;

function F4151C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197,346
begin
  addr := GetCellString(doc, mcx(cx,70));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,74,103,104,101,102,6,7,
            [76,78,80,82,84,86,88,89,92,94,96,98,100],length(addr) > 0);  //github # 473
end;

function F4151C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,109,138,139,136,137,8,9,
            [111,113,115,117,119,121,123,124,127,129,131,133,135],length(addr) > 0);
end;

function ProcessForm4151Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //Math calculation for page 1
        8,1:  Cmd := F4151C1Adjustments(doc, cx);
        9,2:  Cmd := F4151C2Adjustments(doc, cx);
        10,3: Cmd := F4151C3Adjustments(doc, cx);

      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

function F4152C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,31));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 35,64,65,62,63,4,5,
            [37,39,41,43,45,47,49,50,53,55,57,59,61],length(addr) > 0);
end;

function F4152C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,67));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,71,100,101,98,99,6,7,
            [73,75,77,79,81,83,85,86,89,91,93,95,97],length(addr) > 0);
end;

function F4152C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,103));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,107,136,137,134,135,8,9,
            [109,111,113,115,117,119,121,122,125,127,129,131,133],length(addr) > 0);
end;

function ProcessForm4152Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 30,66,102);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 30,66,102, 2);
        3: cmd := ConfigXXXInstance(doc, cx, 30,66,102);
        4,7:
        begin
          cmd := F4152C1Adjustments(doc, cx);
        end; //comp4
        5,8:
        begin
         cmd := F4152C2Adjustments(doc, cx);
         end;  //comp5
        6,9:
        begin
        cmd := F4152C3Adjustments(doc, cx);
        end; //comp6
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function F4153C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,31));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 35,64,65,62,63,4,5,
            [37,39,41,43,45,47,49,50,53,55,57,59,61],length(addr) > 0);
end;

function F4153C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,67));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,71,100,101,98,99,6,7,
            [73,75,77,79,81,83,85,86,89,91,93,95,97],length(addr) > 0);
end;

function F4153C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,103));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,107,136,137,134,135,8,9,
            [109,111,113,115,117,119,121,122,125,127,129,131,133],length(addr) > 0);
end;


function ProcessForm4153Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1: cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listings', 30,66,102);
        2: cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTINGS','', 30,66,102, 2);
        3: cmd := ConfigXXXInstance(doc, cx, 30,66,102);
        4,7:
        begin
          cmd := F4153C1Adjustments(doc, cx);
        end; //listingx
        5,8:
        begin
         cmd := F4153C2Adjustments(doc, cx);
         end;  //listingx
        6,9:
        begin
        cmd := F4153C3Adjustments(doc, cx);
        end; //listingx
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

//**********  START Derek AS IS FORMS
//github #783
//Ticket #1142: info id for comp1 is 1,2
function F04187C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  result := SalesGridAdjustment(doc, CX, 51,106,107,104,105,1,2,
      [56,58,60,62,64,66,68,70,72,74,76,77,81,83,85,87,89,91,93,95,97,99,101,103],length(addr) > 0);
end;

//Ticket #1142: info id for comp1 is 3,4
function F04187C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,109));   //get the address
  result := SalesGridAdjustment(doc, CX, 112,167,168,165,166,3,4,
      [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr) > 0);
end;

//Ticket #1142: info id for comp1 is 5,6
function F04187C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,170));   //get the address
  result := SalesGridAdjustment(doc, CX, 173,228,229,226,227,5,6,
    [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225], length(addr) > 0);
end;


//Derek AS-IS Sales Comparison Approach
function ProcessForm04187Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 47,108,169, False);

        4:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));     //Subj price/sqft
        5:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04187Math, doc, CX,[7,6]); //C1 sales price
        6:  //comp1 adjustments
          Cmd := F04187C1Adjustments(doc, cx);
        7:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,51), mcx(cx,82), mcx(cx,52));     //C1 price/sqft
        8: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04187Math, doc, CX,[10,9]); //C2 sales price
        9: //comp2 adjustments
          Cmd := F04187C2Adjustments(doc, cx);
        10: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,143), mcx(cx,113));  //C2 price/sqft
        11: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04187Math, doc, CX,[13,12]); //C3 sales price
        12: //comp3 adjustments
          Cmd := F04187C3Adjustments(doc, cx);
        13: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,173), mcx(cx,204), mcx(cx,174));  //C3 price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [4187]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04187C1Adjustments(doc, cx);
            F04187C2Adjustments(doc, cx);
            F04187C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04187Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04187Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;

//Ticket #1142: change info id to match with the form
function F04188C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  result := SalesGridAdjustment(doc, CX, 51,106,107,104,105,1,2,
      [56,58,60,62,64,66,68,70,72,74,76,77,81,83,85,87,89,91,93,95,97,99,101,103],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04188C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,109));   //get the address
  result := SalesGridAdjustment(doc, CX, 112,167,168,165,166,3,4,
      [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04188C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,170));   //get the address
  result := SalesGridAdjustment(doc, CX, 173,228,229,226,227,5,6,
    [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225], length(addr) > 0);
end;


//Derek AS-IS Sales Comparison Approach
function ProcessForm04188Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 47,108,169, False);
        4:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));     //Subj price/sqft
        5:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04188Math, doc, CX,[7,6]); //C1 sales price
        6:  //comp1 adjustments
          Cmd := F04188C1Adjustments(doc, cx);
        7:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,51), mcx(cx,82), mcx(cx,52));     //C1 price/sqft
        8: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04188Math, doc, CX,[10,9]); //C2 sales price
        9: //comp2 adjustments
          Cmd := F04188C2Adjustments(doc, cx);
        10: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,143), mcx(cx,113));  //C2 price/sqft
        11: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04188Math, doc, CX,[13,12]); //C3 sales price
        12: //comp3 adjustments
          Cmd := F04188C3Adjustments(doc, cx);
        13: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,173), mcx(cx,204), mcx(cx,174));  //C3 price/sqft
        14:
          cmd := CalcWeightedAvg(doc, [4187]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04188C1Adjustments(doc, cx);
            F04188C2Adjustments(doc, cx);
            F04188C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04188Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04188Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;

//Ticket #1142: change info id to match with the form
function F04200C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,64));   //get the address
  result := SalesGridAdjustment(doc, CX, 67,141,142,139,140,3,4,
    [79,81,83,85,87,88,91,93,95,97,99,101,103,106,110,114,118,120,122,124,
     126,128,130,132,134,136,137],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04200C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,144));   //get the address
  result := SalesGridAdjustment(doc, CX, 147,221,222,219,220,5,6,
    [159,161,163,165,167,169,171,173,175,177,179,181,182,186,190,194,198,
     200,202,204,206,208,210,212,214,216,218],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04200C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,224));   //get the address
  result := SalesGridAdjustment(doc, CX, 227,301,302,299,300,7,8,
    [239,241,243,245,247,249,251,253,255,257,259,261,262,266,270,274,
     278,280,282,284,286,288,290,292,294,296,298],length(addr) > 0);
end;



function ProcessForm04200Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 63,143,223, False);
        34:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[39,46,50,54]);   //process Sub
          //sales per unit and total rooms
        39:cmd := DivideAB(doc, mcx(cx,15), mcx(cx,37), mcx(cx,16));       //Subj price/sqft
        //Subject
        46:Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,17), mcx(cx,18));   //sub rent/GBA
        50:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[115]); //sub units chged
         //sales per bedroom
        54:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[116]); //sub rooms chged
        //Comp1
        35:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[40,47,51,55,43]);   //process C1
        40:cmd := DivideAB(doc, mcx(cx,67), mcx(cx,100), mcx(cx,68));       //C1 price/sqft
        43:cmd := F04200C1Adjustments(doc, cx);       //C1 sum of adjs
        47:cmd := DivideAB(doc, mcx(cx,67), mcx(cx,69), mcx(cx,70));    //C1 rent chged
        51:cmd := IncomeSalePerUnitNRoom(doc, cx, 67, 103,107,111,115, 71,72);  //C1 units chged
        55:cmd := IncomeSalePerBedRoom(doc, cx, 67, 104,108,112,116, 73);  //C1 rooms chged
        67: Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[51]); //C1 units
        70: Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[55]); //C1 bedrooms

        //Comp2
        36:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[41,48,52,56,44]);   //process C3
        41:cmd := DivideAB(doc, mcx(cx,147), mcx(cx,180), mcx(cx,148));    //C2 price/sqft
        44:cmd := F04200C2Adjustments(doc, cx);       //C2 sum of adjs
        48:cmd := DivideAB(doc, mcx(cx,147), mcx(cx,149), mcx(cx,150));    //C2 rent chged
        52:Cmd := IncomeSalePerUnitNRoom(doc, cx, 147, 183,187,191,195, 151,152);  //C2 units chged
        56:cmd := IncomeSalePerBedRoom(doc, cx, 147, 184,188,192,196, 153);  //C2 rooms chged
        68:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[52]); //C2 units
        71:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[56]); //C2 bedrooms

        //Comp3
        37:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[42,49,53,57, 45]);  //process C3
        42:cmd := DivideAB(doc, mcx(cx,227), mcx(cx,260), mcx(cx,228));    //C3 price/sqft
        45:cmd := F04200C3Adjustments(doc, cx);       //C3 sum of adjs
        49:cmd := DivideAB(doc, mcx(cx,227), mcx(cx,229), mcx(cx,230));    //C3 rent chged
        53:cmd := IncomeSalePerUnitNRoom(doc, cx, 227, 263,267,271,275, 231,232);  //C3 units chged
        57:cmd := IncomeSalePerBedRoom(doc, cx, 227, 264,268,272,276, 233);  //C3 rooms chged
        69:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[53]); //C3 units
        72:Cmd := ProcessMultipleCmds(ProcessForm04200Math, doc, CX,[57]);  //C3 bedrooms


        73:
          begin
            F04200C1Adjustments(doc, cx);
            F04200C2Adjustments(doc, cx);     //sum of adjs
            F04200C3Adjustments(doc, cx);
            cmd := 0;
          end;
        115:cmd := IncomeSalePerUnitNRoom(doc, cx, 15,38,41,44,47, 19,20);  //sub units chged
        116:cmd := IncomeSalePerBedRoom(doc, cx, 15, 39,42,45,48, 21);  //sub rooms chged
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04200Math(doc, 73, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04200Math(doc, 73, CX);
        end;
    end;
  result := 0;
end;

//Ticket #1142: change info id to match with the form
function F04199C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,64));   //get the address
  result := SalesGridAdjustment(doc, CX, 67,141,142,139,140,3,4,
    [79,81,83,85,87,88,91,93,95,97,99,101,103,106,110,114,118,120,122,124,
     126,128,130,132,134,136,137],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04199C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,144));   //get the address
  result := SalesGridAdjustment(doc, CX, 147,221,222,219,220,5,6,
    [159,161,163,165,167,169,171,173,175,177,179,181,182,186,190,194,198,
     200,202,204,206,208,210,212,214,216,218],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04199C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,224));   //get the address
  result := SalesGridAdjustment(doc, CX, 227,301,302,299,300,7,8,
    [239,241,243,245,247,249,251,253,255,257,259,261,262,266,270,274,
     278,280,282,284,286,288,290,292,294,296,298],length(addr) > 0);
end;


function ProcessForm04199Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 63,143,223, False);
        34:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[39,46,50,54]);   //process Sub
          //sales per unit and total rooms
        39:cmd := DivideAB(doc, mcx(cx,15), mcx(cx,37), mcx(cx,16));       //Subj price/sqft
        //Subject
        46:Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,17), mcx(cx,18));   //sub rent/GBA
        50:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[115]); //sub units chged
         //sales per bedroom
        54:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[116]); //sub rooms chged
        //Comp1
        35:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[40,47,51,55,43]);   //process C1
        40:cmd := DivideAB(doc, mcx(cx,67), mcx(cx,100), mcx(cx,68));       //C1 price/sqft
        43:cmd := F04199C1Adjustments(doc, cx);       //C1 sum of adjs
        47:cmd := DivideAB(doc, mcx(cx,67), mcx(cx,69), mcx(cx,70));    //C1 rent chged
        51:cmd := IncomeSalePerUnitNRoom(doc, cx, 67, 103,107,111,115, 71,72);  //C1 units chged
        55:cmd := IncomeSalePerBedRoom(doc, cx, 67, 104,108,112,116, 73);  //C1 rooms chged
        67: Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[51]); //C1 units
        70: Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[55]); //C1 bedrooms

        //Comp2
        36:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[41,48,52,56,44]);   //process C3
        41:cmd := DivideAB(doc, mcx(cx,147), mcx(cx,180), mcx(cx,148));    //C2 price/sqft
        44:cmd := F04199C2Adjustments(doc, cx);       //C2 sum of adjs
        48:cmd := DivideAB(doc, mcx(cx,147), mcx(cx,149), mcx(cx,150));    //C2 rent chged
        52:Cmd := IncomeSalePerUnitNRoom(doc, cx, 147, 183,187,191,195, 151,152);  //C2 units chged
        56:cmd := IncomeSalePerBedRoom(doc, cx, 147, 184,188,192,196, 153);  //C2 rooms chged
        68:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[52]); //C2 units
        71:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[56]); //C2 bedrooms

        //Comp3
        37:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[42,49,53,57, 45]);  //process C3
        42:cmd := DivideAB(doc, mcx(cx,227), mcx(cx,260), mcx(cx,228));    //C3 price/sqft
        45:cmd := F04199C3Adjustments(doc, cx);       //C3 sum of adjs
        49:cmd := DivideAB(doc, mcx(cx,227), mcx(cx,229), mcx(cx,230));    //C3 rent chged
        53:cmd := IncomeSalePerUnitNRoom(doc, cx, 227, 263,267,271,275, 231,232);  //C3 units chged
        57:cmd := IncomeSalePerBedRoom(doc, cx, 227, 264,268,272,276, 233);  //C3 rooms chged
        69:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[53]); //C3 units
        72:Cmd := ProcessMultipleCmds(ProcessForm04199Math, doc, CX,[57]);  //C3 bedrooms


        73:
          begin
            F04199C1Adjustments(doc, cx);
            F04199C2Adjustments(doc, cx);     //sum of adjs
            F04199C3Adjustments(doc, cx);
            cmd := 0;
          end;
        115:cmd := IncomeSalePerUnitNRoom(doc, cx, 15,38,41,44,47, 19,20);  //sub units chged
        116:cmd := IncomeSalePerBedRoom(doc, cx, 15, 39,42,45,48, 21);  //sub rooms chged
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04199Math(doc, 73, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04199Math(doc, 73, CX);
        end;
    end;
  result := 0;
end;


//github #783
//Ticket #1142: change info id to match with the form
function F04201C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  result := SalesGridAdjustment(doc, CX, 51,106,107,104,105,1,2,
      [56,58,60,62,64,66,68,70,72,74,76,77,81,83,85,87,89,91,93,95,97,99,101,103],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04201C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,109));   //get the address
  result := SalesGridAdjustment(doc, CX, 112,167,168,165,166,3,4,
      [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04201C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,170));   //get the address
  result := SalesGridAdjustment(doc, CX, 173,228,229,226,227,5,6,
    [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225], length(addr) > 0);
end;



function ProcessForm04201Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          begin
            cmd := ConfigXXXInstance(doc, cx, 47,108,169, False);
            cmd := 0;
          end;
        20:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));     //Subj price/sqft
        27:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04201Math, doc, CX,[21,24]); //C1 sales price
        24:  //comp1 adjustments
          Cmd := F04201C1Adjustments(doc, cx);
        21:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,51), mcx(cx,82), mcx(cx,52));     //C1 price/sqft
        28: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04201Math, doc, CX,[22,25]); //C2 sales price
        25: //comp2 adjustments
          Cmd := F04201C2Adjustments(doc, cx);
        22: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,143), mcx(cx,113));  //C2 price/sqft
        29: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04201Math, doc, CX,[23,26]); //C3 sales price
        26: //comp3 adjustments
          Cmd := F04201C3Adjustments(doc, cx);
        23: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,173), mcx(cx,204), mcx(cx,174));  //C3 price/sqft
        30:
          cmd := CalcWeightedAvg(doc, [4201]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04201C1Adjustments(doc, cx);
            F04201C2Adjustments(doc, cx);
            F04201C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04201Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04201Math(doc, 46, CX);
        end;
    end;
  result := 0;

end;



//github #783
//Ticket #1142: change info id to match with the form
function F04197C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,48));   //get the address
  result := SalesGridAdjustment(doc, CX, 51,106,107,104,105,1,2,
      [56,58,60,62,64,66,68,70,72,74,76,77,81,83,85,87,89,91,93,95,97,99,101,103],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04197C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,109));   //get the address
  result := SalesGridAdjustment(doc, CX, 112,167,168,165,166,3,4,
      [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04197C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,170));   //get the address
  result := SalesGridAdjustment(doc, CX, 173,228,229,226,227,5,6,
    [178,180,182,184,186,188,190,192,194,196,198,199,203,205,207,209,211,213,215,217,219,221,223,225], length(addr) > 0);
end;



function ProcessForm04197Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 47,108,169, False);
        20:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));     //Subj price/sqft
        27:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04197Math, doc, CX,[21,24]); //C1 sales price
        24:  //comp1 adjustments
          Cmd := F04197C1Adjustments(doc, cx);
        21:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,51), mcx(cx,82), mcx(cx,52));     //C1 price/sqft
        28: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04197Math, doc, CX,[22,25]); //C2 sales price
        25: //comp2 adjustments
          Cmd := F04197C2Adjustments(doc, cx);
        22: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,112), mcx(cx,143), mcx(cx,113));  //C2 price/sqft
        29: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04197Math, doc, CX,[23,26]); //C3 sales price
        26: //comp3 adjustments
          Cmd := F04197C3Adjustments(doc, cx);
        23: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,173), mcx(cx,204), mcx(cx,174));  //C3 price/sqft
        30:
          cmd := CalcWeightedAvg(doc, [4201]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04197C1Adjustments(doc, cx);
            F04197C2Adjustments(doc, cx);
            F04197C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04197Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04197Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function F04202C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,57));   //get the address
  result := SalesGridAdjustment(doc, CX, 61,131,132,129,130,1,2,
      [67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,102,106,108,110,112,
       114,116,118,120,122,124,126,128],length(addr) > 0);
end;

function F04202C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,134));   //get the address
  result := SalesGridAdjustment(doc, CX, 138,208,209,206,207,3,4,
      [144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,176,178,
       179,183,185,187,189,191,193,195,197,199,201,203,205],length(addr) > 0);
end;

function F04202C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,211));   //get the address
  result := SalesGridAdjustment(doc, CX, 215,285,286,283,284,5,6,
      [221,223,225,227,229,231,233,235,237,239,241,243,245,247,249,251,253,255,256,
       260,262,264,266,268,270,272,274,276,280,282],length(addr) > 0);
end;


function ProcessForm04202Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 56,133,210, False);
        10,17:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,42), mcx(cx,17));     //Subj price/sqft
        18:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04202Math, doc, CX,[11,14]); //C1 sales price
        14:  //comp1 adjustments
          Cmd := F04202C1Adjustments(doc, cx);
        11:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,61), mcx(cx,107), mcx(cx,62));     //C1 price/sqft
        19: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04202Math, doc, CX,[12,15]); //C2 sales price
        15: //comp2 adjustments
          Cmd := F04202C2Adjustments(doc, cx);
        12: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,138), mcx(cx,184), mcx(cx,139));  //C2 price/sqft
        20: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04202Math, doc, CX,[13,16]); //C3 sales price
        16: //comp3 adjustments
          Cmd := F04202C3Adjustments(doc, cx);
        13: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,215), mcx(cx,261), mcx(cx,216));  //C3 price/sqft
        21:
          cmd := CalcWeightedAvg(doc, [4202]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04202C1Adjustments(doc, cx);
            F04202C2Adjustments(doc, cx);
            F04202C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04202Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04202Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


//Ticket #1142: change info id to match with the form
function F04198C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,57));   //get the address
  result := SalesGridAdjustment(doc, CX, 61,131,132,129,130,1,2,
      [67,69,71,73,75,77,79,81,83,85,87,89,91,93,95,97,99,101,102,106,108,110,112,
       114,116,118,120,122,124,126,128],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04198C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,134));   //get the address
  result := SalesGridAdjustment(doc, CX, 138,208,209,206,207,3,4,
      [144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,176,178,
       179,183,185,187,189,191,193,195,197,199,201,203,205],length(addr) > 0);
end;

//Ticket #1142: change info id to match with the form
function F04198C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,211));   //get the address
  result := SalesGridAdjustment(doc, CX, 215,285,286,283,284,5,6,
      [221,223,225,227,229,231,233,235,237,239,241,243,245,247,249,251,253,255,256,
       260,262,264,266,268,270,272,274,276,280,282],length(addr) > 0);
end;


function ProcessForm04198Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx, 56,133,210, False);
        10,17:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,42), mcx(cx,17));     //Subj price/sqft
        18:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04198Math, doc, CX,[11,14]); //C1 sales price
        14:  //comp1 adjustments
          Cmd := F04202C1Adjustments(doc, cx);
        11:  //comp1 price/sqft
          cmd := DivideAB(doc, mcx(cx,61), mcx(cx,107), mcx(cx,62));     //C1 price/sqft
        19: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04198Math, doc, CX,[12,15]); //C2 sales price
        15: //comp2 adjustments
          Cmd := F04202C2Adjustments(doc, cx);
        12: //comp2 price/sqf
          cmd := DivideAB(doc, mcx(cx,138), mcx(cx,184), mcx(cx,139));  //C2 price/sqft
        20: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04198Math, doc, CX,[13,16]); //C3 sales price
        16: //comp3 adjustments
          Cmd := F04202C3Adjustments(doc, cx);
        13: //comp3 price/sqf
          cmd := DivideAB(doc, mcx(cx,215), mcx(cx,261), mcx(cx,216));  //C3 price/sqft
        21:
          cmd := CalcWeightedAvg(doc, [4202]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04198C1Adjustments(doc, cx);
            F04198C2Adjustments(doc, cx);
            F04198C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04198Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 1 (zero based)
          ProcessForm04198Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


//**********  END Derek AS IS FORMS
//github #783
function F04087C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,129));   //get the address
  result := SalesGridAdjustment(doc, CX, 132,166,167,164,165,5,6,
      [134,136,138,140,142,143,147,149,151,153,155,157,159,161,163],length(addr) > 0);
end;

function F04087C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,168));   //get the address
  result := SalesGridAdjustment(doc, CX, 171,205,206,203,204,7,8,
      [173,175,177,179,181,182,186,188,190,192,194,196,198,200,202],length(addr) > 0);
end;

function F04087C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,207));   //get the address
  result := SalesGridAdjustment(doc, CX, 210,244,245,242,243,9,10,
      [212,214,216,218,220,221,225,227,229,231,233,235,237,239,241],length(addr) > 0);
end;

(*
function ProcessForm04087Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  //Subject sales price
          cmd := DivideAB(doc, mcx(cx,15), mcx(cx,33), mcx(cx,16));     //Subj price/sqft
        2:  //comp1 adjustments
          Cmd := F04087C1Adjustments(doc, cx);
        5:  //comp2 adjustments
          Cmd := F04087C2Adjustments(doc, cx);
        8:  //comp3 adjustments
          Cmd := F04087C3Adjustments(doc, cx);
        9:
          cmd := CalcWeightedAvg(doc, [4087]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04087C1Adjustments(doc, cx);
            F04087C2Adjustments(doc, cx);
            F04087C3Adjustments(doc, cx);
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
          ProcessForm04087Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 0;    //math is on page 1 (zero based)
          ProcessForm04087Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;
 *)
//Second Mortgage Extra Comps
function ProcessForm04087Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
//        1:
//          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES', 'ADDENDUM',33,73,113, 2);
//        2:
//          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 33,73,113);
//        3:
//          cmd := ConfigXXXInstance(doc, cx, 33,73,113);

//Comp1 calcs
        1:    //sales price changed
          cmd := F04087C1Adjustments(doc, cx);     //redo the adjustments
        2:
          cmd := F04087C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        4:   //sales price changed
          cmd := F04087C2Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F04087C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        7:   //sales price changed
          cmd := F04087C3Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F04087C3Adjustments(doc, cx);     //sum of adjs
        9:
          cmd := CalcWeightedAvg(doc, [4087]);   //calc wtAvg of main and xcomps forms
        13:
          begin
            F04087C1Adjustments(doc, cx);       //sum of adjs
            F04087C2Adjustments(doc, cx);       //sum of adjs
            F04087C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm04087Math(doc, 2, CX);
          ProcessForm04087Math(doc, 5, CX);
          ProcessForm04087Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm04087Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;


function F04205C1Adjustments(doc: TContainer; CX: CellUID) : Integer;
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

function F04205C2Adjustments(doc: TContainer; CX: CellUID) : Integer;
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

function F04205C3Adjustments(doc: TContainer; CX: CellUID) : Integer;
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


//Second Mortgage Extra Comps
function ProcessForm04205Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
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
          cmd := F04205C1Adjustments(doc, cx);     //redo the adjustments
        5:
          cmd := F04205C1Adjustments(doc, cx);       //sum of adjs

//Comp2 calcs
        7:   //sales price changed
          cmd := F04205C2Adjustments(doc, cx);     //redo the adjustments
        8:
          cmd := F04205C2Adjustments(doc, cx);       //sum of adjs

//Comp3 calcs
        10:   //sales price changed
          cmd := F04205C3Adjustments(doc, cx);     //redo the adjustments
        11:
          cmd := F04205C3Adjustments(doc, cx);     //sum of adjs
        12:
          if doc.GetFormIndex(4087) <> -1 then     //decide which is main form 13 or 14
            cmd := CalcWeightedAvg(doc, [4087,4205])   //calc wtAvg of main and xcomps forms
          else
            cmd := CalcWeightedAvg(doc, [4205]);
        13:
          begin
            F04205C1Adjustments(doc, cx);       //sum of adjs
            F04205C2Adjustments(doc, cx);       //sum of adjs
            F04205C3Adjustments(doc, cx);       //sum of adjs
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
          ProcessForm04205Math(doc, 5, CX);
          ProcessForm04205Math(doc, 8, CX);
          ProcessForm04205Math(doc, 11, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm04205Math(doc, 13, CX);
        end;
    end;

  result := 0;
end;


function F04174C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,54));   //get the address
  result := SalesGridAdjustment(doc, CX, 57,127,128,125,126,3,4,
      [61,63,65,67,69,71,73,75,77,79,81,83,84,88,92,96,100,104,106,108,110,112,114,116,118,120,122,124],length(addr) > 0);
end;

function F04174C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,130));   //get the address
  result := SalesGridAdjustment(doc, CX, 133,203, 204, 201, 202,5,6,
      [137,139,141,143,145,147,149,151,153,155,157,159,160,164,168,172,176,180,182,184,186,188,190,192,194,196,198,200],length(addr) > 0);
end;

function F04174C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,206));   //get the address
  result := SalesGridAdjustment(doc, CX, 209,279,280,277,278,7,8,
    [213,215,217,219,221,223,225,227,229,231,233,235,236,240,244,248,252,256,258,260,262,264,266,268,270,272,274,276], length(addr) > 0);
end;



//github #843
function ProcessForm04174Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx,53,129,205, False);
        2:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04174Math, doc, CX,[4,3]); //C1 sales price
        4:  //comp1 adjustments
          Cmd := F04174C1Adjustments(doc, cx);
        5: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04174Math, doc, CX,[7,6]); //C2 sales price
        7: //comp2 adjustments
          Cmd := F04174C2Adjustments(doc, cx);
        8: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04174Math, doc, CX,[10,9]); //C3 sales price
        10: //comp3 adjustments
          Cmd := F04174C3Adjustments(doc, cx);
        11:
          cmd := CalcWeightedAvg(doc, [4174]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04174C1Adjustments(doc, cx);
            F04174C2Adjustments(doc, cx);
            F04174C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04174Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04174Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;


function F04208C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,55));   //get the address
  result := SalesGridAdjustment(doc, CX, 58,128,129,126,127,3,4,
      [62,64,66,68,70,72,74,76,78,80,82,84,85,89,93,97,101,105,107,109,111,113,115,117,119,121,123,125],length(addr) > 0);
end;

function F04208C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,131));   //get the address
  result := SalesGridAdjustment(doc, CX, 134,204, 205, 202, 203,5,6,
      [138,140,142,144,146,148,150,152,154,156,158,160,161,165,169,173,177,181,183,185,187,189,191,193,195,197,199,201],length(addr) > 0);
end;

function F04208C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,207));   //get the address
  result := SalesGridAdjustment(doc, CX, 210,280,281,278,279,7,8,
    [214,216,218,220,222,224,226,228,230,232,234,236,237,241,245,249,253,257,259,261,263,265,267,269,271,273,275,277], length(addr) > 0);
end;


//github #843
function ProcessForm04208Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        3: //github #791: calculate comp #
          cmd := ConfigXXXInstance(doc, cx,54,130,206, True);   //needs to pass True to start with 4
        2:  //comp1 sales price
          cmd := ProcessMultipleCmds(ProcessForm04208Math, doc, CX,[4,3]); //C1 sales price
        4:  //comp1 adjustments
          Cmd := F04208C1Adjustments(doc, cx);
        5: //comp2 sales price
          cmd := ProcessMultipleCmds(ProcessForm04208Math, doc, CX,[7,6]); //C2 sales price
        7: //comp2 adjustments
          Cmd := F04208C2Adjustments(doc, cx);
        8: //comp3 salesprice
          cmd := ProcessMultipleCmds(ProcessForm04208Math, doc, CX,[10,9]); //C3 sales price
        10: //comp3 adjustments
          Cmd := F04208C3Adjustments(doc, cx);
        11:
          cmd := CalcWeightedAvg(doc, [4208]);   //calc wtAvg of main and xcomps forms
        46:
          begin //no recursion
            F04208C1Adjustments(doc, cx);
            F04208C2Adjustments(doc, cx);
            F04208C3Adjustments(doc, cx);
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04208Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04208Math(doc, 46, CX);
        end;
    end;
  result := 0;
end;

// *************** START of Josh Walitt's forms

function F04250C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   
begin
  addr := GetCellString(doc, mcx(cx,137));   //get the address
  result := SalesGridAdjustment(doc, CX, 140,177,178,175,176,1,2,
      [143,145,147,149,151,153,154,158,160,162,164,166,168,170,172,174]);
end;

function F04250C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;  
begin
  addr := GetCellString(doc, mcx(cx,179));   //get the address
  result := SalesGridAdjustment(doc, CX, 182,219,220,217,218,3,4,
      [185,187,189,191,193,195,196,200,202,204,206,208,210,212,214,216]);
end;

function F04250C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;  
begin
  addr := GetCellString(doc, mcx(cx,221));   //get the address
  result := SalesGridAdjustment(doc, CX, 224,261,262,259,260,5,6,
            [227,229,231,233,235,237,238,242,244,246,248,250,252,254,256,258]);
end;




function ProcessForm04250Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function CalcLandUseSum(doc: TContainer; CX: CellUID; InfoID: Integer;
            const CIDs: Array of Integer): Integer;
  var
    V1: Double;
  begin
    V1 := GetArraySum(doc, CX, CIDs);
    result := SetInfoCellValue(doc, MCX(CX, InfoID),V1);
  end;

begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  cmd := ProcessMultipleCmds(ProcessForm04250Math, doc, CX,[2]); //C1 sales price
        2:  Cmd := F04250C1Adjustments(doc, cx);
        4:  cmd := ProcessMultipleCmds(ProcessForm04250Math, doc, CX,[5]); //C2 sales price
        5:  Cmd := F04250C2Adjustments(doc, cx);
        7:  cmd := ProcessMultipleCmds(ProcessForm04250Math, doc, CX,[8]); //C3 sales price
        8:  Cmd := F04250C3Adjustments(doc, cx);
        14: Cmd := CalcLandUseSum(doc, CX, 9, [49,50,51,52,53,54,55]);   //include info id 9 for the total %
        46:
          begin //no recursion
            F04250C1Adjustments(doc, cx);
            F04250C2Adjustments(doc, cx);
            F04250C3Adjustments(doc, cx);
            cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID,WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm04250Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;

function F04252C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,41));   //get the address
  result := SalesGridAdjustment(doc, CX,44,81,82,79,80,1,2,
      [47,49,51,53,55,57,58,62,64,66,68,70,72,74,76,78]);
end;

//XComp

function F04252C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,84));   //get the address
  result := SalesGridAdjustment(doc, CX,87,124,125,122,123,3,4,
      [90,92,94,96,98,100,101,105,107,109,111,113,115,117,119,121]);
end;

function F04252C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,127));   //get the address
  result := SalesGridAdjustment(doc, CX,130,167,168,165,166,5,6,
      [133,135,137,139,141,143,144,148,150,152,154,156,158,160,162,164]);
end;


function ProcessForm04252Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        6:  cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 40,83,126);
        3:  cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 40,83,126, 2);
        13: cmd := ConfigXXXInstance(doc, cx,  40,83,126);
        //Comp1 calcs
        1,2: Cmd := F04252C1Adjustments(doc, cx);
        //Comp2 calcs
        4,5: Cmd := F04252C2Adjustments(doc, cx);
        7,8: cmd := F04252C3Adjustments(doc, cx);
        15:
          begin
            F04252C1Adjustments(doc, cx);
            F04252C2Adjustments(doc, cx);     //sum of adjs
            F04252C3Adjustments(doc, cx);
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
          CX.pg := 0;   //page 1
          ProcessForm04252Math(doc, 2, CX);
          ProcessForm04252Math(doc, 5, CX);
          ProcessForm04252Math(doc, 8, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //page 1
          ProcessForm04252Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;


// *************** END of Josh Walitt's forms




end.
