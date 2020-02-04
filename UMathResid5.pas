unit UMathResid5;

{  ClickForms Application                }
{  Bradford Technologies, Inc.           }
{  All Rights Reserved                   }
{  Source Code Copyrighted © 1998-2018 by Bradford Technologies, Inc. }


interface

uses
  UGlobals, UContainer, Classes;

const
  fm2005_1004             = 340;    //URAR
  fmNonLender_1004        = 736;    //URAR Non-Lender
  fmNonLender_1004XComp   = 761;    //URAR Non-Lender XComps
  fm2005_1004p_4218       = 4218;   //URAR Bifurcated Main
  fm2005_1004p_4219Cert   = 4219;   //URAR Bifircated Cert
  fm2019_70H_4365         = 4365;   //URAR FMAC 70H
  fm2019_70H_4366Cert     = 4366;

  fmNonLender_MobileHome = 4085;   //URAR Non-Lender Mobile Home

  fm2005_1004XComp  = 363;         //URAR,Manufactured Home,2055,2000Review Xtra Comps
  fm2005_1004XList  = 3545;        //URAR,Manufactured Home,2055,2000Review Xtra Listings
  fm2005_1004Cert   = 341;         //URAR Certification
  fm2005_1004C      = 342;         //Manufactured Home
  fm2005_1004CCert  = 343;         //Manufactured Home Certification
  fm2005_1004CXComp = 365;         //Manufactured Home XComps
  fm2005_1004D      = 344;         //Appraisal Update/Completion
  fm2005_1025       = 349;         //Small Income Property
  fm2005_1025_Ext   = 4371;        //1025 Exterior
  fmNonLenderSmInc  = 737;         //Non-Lender Small Income
  fmNonLenderSmIncXComp = 762;     //Non-Lender Small Income XComps
  fm2005_1025XComp  = 364;         //Small Income Property Xtra Comps
  fmNonLenderXRentals   = 763;     //Non-Lender XRentals
  fm2005_1025XRent  = 362;         //Small Income Property XTra Rentals
  fm2005_1025Cert   = 350;         //Small Income Property Certification
  fm2005_1025ExtCert = 4372;       //1025 ext cert 
  fm2005_1073       = 345;         //Condo
  fmNonLenderCondo  = 735;         //Condo Non-Lender
  fmNonLenderCondoXComp = 760;     //Condo Non-Lender XComps
  fm2005_1073XComp  = 367;         //Condo, Ext-Inspection Condo Xtra Comps
  fm2005_1073Listings = 888;       // 1073 Listing
  fm2005_1073Cert   = 346;         //Condo Certificatio
  fm2005_2090       = 351;         //CoOp Interest
  fm2005_2090XComp  = 366;         //CoOp, Ext Inspection CoOp Interest Xtra Comps
  fm2005_2090Cert   = 352;         //CoOp Interest Certification
  fm2005_2055       = 355;         //Exterior Inspection Residential
  fm2005_2055Cert   = 356;         //Exterior Inspection Residential Certification
  fm2005_1075       = 347;         //Exterior Inspection Condo Unit
  fm2005_1075Cert   = 348;         //Exterior Inspection Condo Unit Certification
  fm2005_2095       = 353;         //Exterior Inspection CoOp
  fm2005_2095Cert   = 354;         //Exterior Inspection CoOp Certification
  fm2005_2000       = 357;         //Review One Unit Residential
  fm2005_2000Inst   = 358;         //Review One Unit Residential Instructions
  fm2005_2000Cert   = 359;         //Review One Unit Residential Certification
  fm2005_2000A      = 360;         //Review 2-4 Unit Residential
  fm2005_2000AInst  = 361;         //Review 2-4 Unit Residential Instructions
  fmNonLender_2055XComp = 765;     //Exterior Only Residential Non-Lender XComps
  fmNonLender_2055  = 764;         //Exterior Only Residential Non-Lender
  fmAppOrder        = 610;         //Appraisal Order
  fmMarketCondAddend = 835;        //Market Conditions Addendum
  fmMarketCondAddendNew = 850;     //Market ConditionsAddendum new Revision
  fmCommIndustrial  = 949;         //Commercial and Industrial Appraisal
  frm2000XComp      = 4150;        //XComp for FNMA2000   //github #196: add new form constant 4150

  fmTIC_4247  = 4247;         //Tony's TIC form
  fmTIC_4248XComp = 4248;     //Tony's TIC xcomp page

  fmNonLender_4313Listing = 4313;  //Ticket #1525

  GAtt = 'ga';                     //Attached Garage
  GDet = 'gd';                     //Detached Garage
  GBin = 'gbi';                    //Built-In Garage
  GGar = 'g';                      //Garage Parking
  GCov = 'cv';                     //Covered Parking
  GOpn = 'op';                     //Open Parking

  function ProcessForm0340Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0341Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0342Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0343Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0344Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0345Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0346Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0347Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0348Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0349Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0350Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0351Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0352Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0353Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0354Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0355Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0356Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0357Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0358Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
//  function ProcessForm0359Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;   //NO MATH
  function ProcessForm0360Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0361Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0362Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0363Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm3545Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0364Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0365Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0366Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0367Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;

  function ProcessForm0610Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0736Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0735Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0737Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0764Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0835Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0850Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm0949Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //Non Lender Mobile Home
  function ProcessForm4085Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4150Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  //Ticket #1192: Copy 4247 math from 735
  function ProcessForm4247Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
  function ProcessForm4313Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer; //Ticket #1525



implementation

uses
	Dialogs, SysUtils, Math,
	UUtil1, UStatus, UBase, UForm, UPage, UCell, UMath, UStrings, UUADUtils, UUtil2;


{ NEW FANNIE MAE FORMS - 2005}

{ Generic Routines}

  // 042911 JWyatt Added document UAD detection check to a number of process
  //  functions to prevent the YearToAge and FxxxxBsmt2Grid functions from
  //  firing when in UAD mode. Updating of the associated fields is controlled
  //  by the UAD dialogs. Also, 2 instances where an incorrect process was
  //  referenced are corrected.

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


{ URAR }

function F0340AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, Cmd, MCPX(CX,3,28));
    end;
end;

function F0340Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, Cmd, MCPX(CX,2,32));
    end;

  result := 0;
end;

function F0340UADBsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  TotSqFt, FinPct: Integer;
  Cmd: Integer;
  GridCX: CellUID;
  Bsmt, bsmtSqft, bsmtFin: String;
begin
  result := 0;
  S1 := GetCellString(doc, mcx(cx, 144));			{bsmt total sqft}
  S1 := StringReplace(S1, ',', '', [rfReplaceAll]);
  S2 := GetCellString(doc, mcx(cx, 145));			{bsmt finished sqft}
  Bsmt := GetCellString(doc, MCPX(CX,2,32)); //Ticket #1439: get bsmt cell value 1006 on the grid
  if pos('sf', Bsmt) > 0 then
    begin
      bsmtSqft := popStr(Bsmt, 'sf');
      if pos('sf', Bsmt) > 0 then
        bsmtFin := popStr(Bsmt, 'sf');   //get bsmt finish
    end;
  S3 := '';
  if GetValidInteger(S1) = 0 then  //if no basement, set to 0sf and exit
    begin
      S3 := '0sf';
      exit;
    end;

  if GoodNumber(S1) then
    begin
      TotSqFt := StrToIntDef(S1, 0);
      S3 := S1 + 'sf';

      if GetValidInteger(bsmtFin) > 0 then   //Ticket #1439: if bsmt finish for the subject on the grid exist use it else use fin %
        begin
          S3 := S3 + bsmtFin + 'sf';
        end
      else
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
      ProcessForm0340Math(doc, Cmd, MCPX(CX,2,32));
    end;

  result := 0;
end;

function F0340Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 144));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 3,18), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 3,19), V1);
      ProcessForm0340Math(doc, Cmd, MCPX(CX, 3,19));
    end;
  result := 0;
end;

function F0340BsmtFinsihed(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
begin
  S1 := GetCellString(doc, mcx(cx,145));
  if length(S1)>0 then
    S1 := S1 + '% Finished';
  result := SetCellString(doc, MCPX(cx,2,33), S1);
end;

function F0340NoCarGarage(doc: TContainer; CX: CellUID): Integer;
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
      SetCellString(doc, MCPX(CX,2,37), '');     //transfer to grid
    end;
  result := 0;
end;

function F0340CarStorage(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, Cmd, MCPX(CX,2,37));
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

function F0340UADCarStorage(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, Cmd, MCPX(CX,2,37));
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
          F0340NoCarGarage(doc, cx);
          cmd := SetCellString(doc, MCPX(CX,2,37), ''); //transfer to grid
          ProcessForm0340Math(doc, Cmd, MCPX(CX,2,37));
        end;
    end;
  result := 0;
end;

function F0340UADGridCarStorage(doc: TContainer; CX: CellUID): Integer;
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

function F0340UADDesignStyle(doc: TContainer; CX: CellUID): Integer;
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

function F0340UADGridDesignStyle(doc: TContainer; CX: CellUID): Integer;
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

function F0340NoAttic(doc: TContainer; CX: CellUID): Integer;
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

function F0340HeatingCooling(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, cmd, MCPX(CX,2,35));
    end;
  result := 0;
end;

function F0340Fireplaces(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, cmd, MCPX(CX,2,40));
    end
  else if not CellIsChecked(doc, mcx(cx,181)) then
    if doc.UADEnabled then
      begin
        SetCellValue(doc, MCX(CX,182), 0);              //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces'); //heading
        Cmd := SetCellString(doc, MCPX(CX, 2,40), '0');    //cell result
        ProcessForm0340Math(doc, cmd, MCPX(CX,2,40));
      end
    else
      begin
        if GetCellValue(doc, mcx(cx, 182)) > 0 then
          SetCellString(doc, MCX(CX,182), '');               //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), '');           //heading
        cmd := SetCellString(doc, MCPX(CX, 2,40), '');     //cell result
        ProcessForm0340Math(doc, cmd, MCPX(CX,2,40));
      end;
  result := 0;
end;

function F0340Pools(doc: TContainer; CX: CellUID): Integer;
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
      ProcessForm0340Math(doc, cmd, MCPX(CX, 2,42));
    end

  else if not CellIsChecked(doc, mcx(cx,185)) then
    if doc.UADEnabled then
      begin
        SetCellString(doc, MCX(CX,186), 'None');            //pool desc
        SetCellString(doc, MCPX(CX, 2,41), 'Pool');         //heading
        cmd := SetCellString(doc, MCPX(CX,2,42), '');   //cell result
        ProcessForm0340Math(doc, cmd, MCPX(CX,2,42));
      end
    else if CellHasWord(doc, MCPX(CX,2,41), 'Pool') then
      begin
        SetCellString(doc, MCX(CX,186), '');                //pool desc
        SetCellString(doc, MCPX(CX, 2,41), '');             //heading
        cmd := SetCellString(doc, MCPX(CX,2,42), '');       //cell result
        ProcessForm0340Math(doc, cmd, MCPX(CX,2,42));
      end;
  result := 0;
end;

function F0340PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if doc.UADEnabled then
    case doc.docActiveCell.UID.Num of
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
     ProcessForm0340Math(doc, cmd, MCPX(CX,2,38));
  result := 0;
end;

function F0340Woodstove(doc: TContainer; CX: CellUID): Integer;
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

function F0340Fence(doc: TContainer; CX: CellUID): Integer;
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

function F0340OtherAmenity(doc: TContainer; CX: CellUID): Integer;
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

function F0340CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0340CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0340CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0340CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0340C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;   //github 197, 346
begin
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,103,104,101,102,2,3,
      [53,55,57,59,61,63,65,67,69,71,73,74,78,80,82,84,86,88,90,92,94,96,98,100],length(addr) > 0);
end;

function F0340C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 108,163,164,161,162,4,5,
    [113,115,117,119,121,123,125,127,129,131,133,134,138,140,142,144,146,148,150,152,154,156,158,160], length(addr) > 0);
end;

function F0340C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  addr := GetCellString(doc, mcx(cx,165));   //get the address
  //if addr <> '' then  //github 197: skip if no address
  result := SalesGridAdjustment(doc, CX, 168,223,224,221,222,6,7,
    [173,175,177,179,181,183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214,216,218,220], length(addr) > 0);
end;



{ Non-Lender 1004 }

function F0736AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  Cmd: Integer;
begin
  result := 0;
  S1 := GetCellString(doc, MCPX(CX,1,136));   //eff age
  S2 := GetCellString(doc, MCPX(CX,3,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      Cmd := SetCellValue(doc, MCPX(CX,3,28), VR);
      ProcessForm0736Math(doc, Cmd, MCPX(CX,3,28));
    end;
end;

function F0736Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  Cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx, 141));			{bsmt sqft}
  S2 := '';
  if CellIsChecked(doc, mcx(cx, 139)) then    {bsmt descript}
    S2 := 'Full'
  else if CellIsChecked(doc, mcx(cx,140)) then
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
      ProcessForm0736Math(doc, Cmd, MCPX(CX,2,32));
    end;

  result := 0;
end;

function F0736Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 141));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 3,18), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 3,19), V1);
      ProcessForm0736Math(doc, Cmd, MCPX(CX, 3,19));
    end;
  result := 0;
end;

function F0736NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 137)) or CellIsChecked(doc, mcx(cx,138)) then
    begin
      SetCellString(doc, Mcx(cx,141), '');
      SetCellString(doc, Mcx(cx,142), '');
      SetCellString(doc, MCPX(CX,2,32), '');      //erase grid
      SetCellString(doc, MCPX(CX, 3,19), '');     //erase cost
    end;
  result := 0;
end;

function F0736NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 192)) then
    begin
      SetCellChkMark(doc, Mcx(cx,193), False);
      SetCellChkMark(doc, Mcx(cx,196), False);
      SetCellChkMark(doc, Mcx(cx,198), False);
      SetCellString(doc, MCX(CX, 194), '');
      SetCellString(doc, MCX(CX, 197), '');
      SetCellString(doc, MCX(CX, 199), '');
      SetCellChkMark(doc, Mcx(cx,200), False);
      SetCellChkMark(doc, Mcx(cx,201), False);
      SetCellChkMark(doc, Mcx(cx,202), False);
      SetCellString(doc, MCPX(CX,2,37), '');     //transfer to grid
    end;
  result := 0;
end;

function F0736CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 200)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,201)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,202)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,197)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,197));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,199)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,199));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,192)) Then
    SetCellChkMark(doc, MCX(cx,192), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm0736Math(doc, Cmd, MCPX(CX,2,37));
    end;
  result := 0;
end;

function F0736NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 165), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 162), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 166), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 163), False);    //floor
      SetCellChkMark(doc, mcx(CX, 167), False);    //heated
      SetCellChkMark(doc, mcx(CX, 164), False);    //finished
    end;
  result := 0;
end;

function F0736HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 168)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,169)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,170)) then     //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,172));   //other source


  S2 := '';
  if CellIsChecked(doc, mcx(cx, 174)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,175)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,177));   //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,2,35), S1);   //transfer to grid
      ProcessForm0736Math(doc, cmd, MCPX(CX,2,35));
    end;
  result := 0;
end;

function F0736Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 179)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,178), True);              //set the checkmark
      SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces');   //heading
      Cmd := SetCellString(doc, MCPX(CX,2,40), S1);        //cell result
      ProcessForm0736Math(doc, cmd, MCPX(CX,2,40));
    end

  else if not CellIsChecked(doc, mcx(cx,178)) then
    begin
      if GetCellValue(doc, mcx(cx, 179)) > 0 then
        SetCellString(doc, MCX(CX,179), '');               //firepace count
      SetCellString(doc, MCPX(CX, 2, 39), '');             //heading
      Cmd := SetCellString(doc, MCPX(CX, 2,40), '');      //cell result
      ProcessForm0736Math(doc, cmd, MCPX(CX,2,40));
    end;
  result := 0;
end;

function F0736Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if CellIsChecked(doc, mcx(cx,182)) then
    begin
      S1 := GetCellString(doc, mcx(cx,183));
      S1 := 'Pool/' + S1;
      SetCellString(doc, MCPX(CX, 2,41), 'Pool');         //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), S1);   //result
      ProcessForm0736Math(doc, cmd, MCPX(CX, 2,42));
    end

  else if not CellIsChecked(doc, mcx(cx,182)) and CellHasWord(doc, MCPX(CX,2,41), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,183), '');                      //pool desc
      SetCellString(doc, MCPX(CX, 2,41), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,2,42), '');   //result
      ProcessForm0736Math(doc, cmd, MCPX(CX,2,42));
    end;

  result := 0;
end;

function F0736PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 180)) then
    begin
      S1 := 'Patio/Deck';
    end;

  //add in the porch
  if CellIsChecked(doc, mcx(CX, 188)) then
    begin
      if length(S1) > 0 then
        S1 := Concat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,38), S1); //transfer to grid
      ProcessForm0736Math(doc, cmd, MCPX(CX,2,38));
    end;
  result := 0;
end;

function F0736CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0736CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0736CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0736CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0736C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  Addr:String;
begin
//github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,103,104,101,102,2,3,
    [53,55,57,59,61,63,65,67,69,71,73,74,78,80,82,84,86,88,90,92,94,96,98,100],length(addr) > 0);
end;

function F0736C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 108,163,164,161,162,4,5,
    [113,115,117,119,121,123,125,127,129,131,133,134,138,140,142,144,146,148,150,152,154,156,158,160],length(addr) > 0);
end;

function F0736C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,165));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 168,223,224,221,222,6,7,
    [173,175,177,179,181,183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214,216,218,220], length(addr) > 0);
end;


{ Manufactured Homes 1004C }

function F0342NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 26)) or CellIsChecked(doc, mcx(cx,27)) or
     CellIsChecked(doc, mcx(cx, 28)) or CellIsChecked(doc, mcx(cx,29)) then
    begin
      SetCellChkMark(doc, Mcx(cx,30), False);
      SetCellChkMark(doc, Mcx(cx,31), False);
      SetCellString(doc, MCX(cx,32), '');
      SetCellString(doc, MCX(cx,33), '');
      SetCellString(doc, MCX(CX, 156), '');    //cost
      SetCellString(doc, MCX(CX, 157), '');    //cost
      SetCellString(doc, MCPX(CX,3,32), '');   //Grid
    end;
  result := 0;
end;

function F0342Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
begin
  result := 0;
  V1 := GetCellValue(doc, mcx(cx, 32));    //basement area
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCX(CX, 156), 'Bsmt.');			{trans Base. to cost appraoach}
      result := SetCellValue(doc, MCX(CX, 157), V1);
    end;
end;

function F0342Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx, 32));			{bsmt sqft}
  S2 := '';
  if CellIsChecked(doc, mcx(cx, 30)) then    {bsmt descript}
    S2 := 'Full'
  else if CellIsChecked(doc, mcx(cx,31)) then
    S2 := 'Partial';

  if (length(S2)>0) then
    begin
      SetCellChkMark(doc, mcx(cx,26), false);
      SetCellChkMark(doc, mcx(cx,27), false);
      SetCellChkMark(doc, mcx(cx,28), false);
      SetCellChkMark(doc, mcx(cx,29), false);
    end;

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
      cmd := SetCellString(doc, MCPX(CX,3,32), S3); //transfer to grid
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,32));
    end;
  result := 0;
end;

function F0342AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
begin
  result := 0;
  S1 := GetCellString(doc, MCX(CX,25));     //eff age
  S2 := GetCellString(doc, MCX(CX,200));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      result := SetCellValue(doc, MCX(CX, 167), VR);
    end;
end;

function F0342NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 54), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 55), False);    //floor
      SetCellChkMark(doc, mcx(CX, 56), False);    //finished
      SetCellChkMark(doc, mcx(CX, 57), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 58), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 59), False);    //heated
    end;
  result := 0;
end;

function F0342HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 60)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,61)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,62)) then    //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,64));       //other source

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 66)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,67)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,69));       //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,35), S1); //transfer to grid
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,35));
    end;
  result := 0;
end;

function F0342Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 71)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,70), True);                //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 39), 'Fireplaces');    //heading
      Cmd := SetCellString(doc, MCPX(CX,3,40), S1);       //result
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,40));
    end

  else if not CellIsChecked(doc, mcx(cx,70)) then
    begin
      if GetCellValue(doc, mcx(cx, 71)) > 0 then
        SetCellString(doc, MCX(CX,71), '');             //firepace count
      SetCellString(doc, MCPX(CX, 3, 39), '');          //heading
      Cmd := SetCellString(doc, MCPX(CX,3,40), '');   //result
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,40));
    end;
  result := 0;
end;

function F0342PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 72)) then
    begin
      S1 := 'Patio/Deck';
    end;

  if CellIsChecked(doc, mcx(CX, 80)) then
    begin
      if length(S1) > 0 then
        S1 := Concat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

      cmd := SetCellString(doc, MCPX(CX,3,38), S1); //transfer to grid
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,38));
  result := 0;
end;

function F0342Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if CellIsChecked(doc, mcx(cx,74)) then
    begin
      S1 := GetCellString(doc, mcx(cx,75));
      S1 := 'Pool/' + S1;
      SetCellString(doc, MCPX(CX, 3, 41), 'Pool');         //heading
      cmd := SetCellString(doc, MCPX(CX, 3, 42), S1);   //result
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,42));
    end

  else if not CellIsChecked(doc, mcx(cx,74)) and CellHasWord(doc, MCPX(CX,3,41), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,75), '');                      //pool desc
      SetCellString(doc, MCPX(CX, 3,41), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 3,42), '');   //result
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,42));
    end;

  result := 0;
end;

function F0342NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 84)) then
    begin
      SetCellChkMark(doc, Mcx(cx,85), False);
      SetCellChkMark(doc, Mcx(cx,88), False);
      SetCellChkMark(doc, Mcx(cx,90), False);
      SetCellString(doc, MCX(CX, 86), '');
      SetCellString(doc, MCX(CX, 89), '');
      SetCellString(doc, MCX(CX, 91), '');
      SetCellChkMark(doc, Mcx(cx,92), False);
      SetCellChkMark(doc, Mcx(cx,93), False);
      SetCellChkMark(doc, Mcx(cx,94), False);
      SetCellString(doc, MCPX(CX,3,37), ''); //transfer to grid
    end;
  result := 0;
end;

function F0342CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 92)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,93)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,94)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,89)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,89));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,91)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,91));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,84)) Then
    SetCellChkMark(doc, MCX(cx,84), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,37), S3); //transfer to grid
      ProcessForm0342Math(doc, cmd, MCPX(CX,3,37));
    end;
  result := 0;
end;

function F0342ValueAfterDepr(doc: TContainer; CX: CellUID): Integer;
var
  V1,P1,F1,E1,D1,D2,S1,VR: Double;
begin
  V1 := GetCellValue(doc, mcx(cx,166));
  P1 := GetCellValue(doc, mcx(cx,168)); //physical depr
  F1 := GetCellValue(doc, mcx(cx,169)); //funcitonal depr
  E1 := GetCellValue(doc, mcx(cx,170)); //external depr
  D1 := GetCellValue(doc, mcx(cx,171)); //delivery
  D2 := GetCellValue(doc, mcx(cx,172)); //other depr
  S1 := GetCellValue(doc, mcx(cx,173)); //site value

  VR := V1 -P1-F1-E1 + D1+D2 + S1;
  result := SetCellvalue(doc, MCX(CX,174), VR);
end;

function F0342C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,105,106,103,104,2,3,
    [55,57,59,61,63,65,67,69,71,73,75,76,80,82,84,86,88,90,92,94,96,98,100,102],length(addr) > 0);
end;

function F0342C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,107));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 110,167,168,165,166,4,5,
    [117,119,121,123,125,127,129,131,133,135,137,138,142,144,146,148,150,152,154,156,158,160,162,164],length(addr) > 0);
end;

function F0342C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,169));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 172,229,230,227,228,6,7,
    [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226],length(addr) > 0);
end;

{ Condo 1073 }

function F0345HOATransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,3,CR), VR);           //transfer to grid
  ProcessForm0345Math(doc, cmd, MCPX(CX,3,CR));          //do any math on it

result := 0;
end;

function F0345UnitChargeTransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,2,CR), VR);           //transfer to grid
  ProcessForm0345Math(doc, cmd, MCPX(CX,2,CR));          //do any math on it

result := 0;
end;

function F0345HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
//F1: String;
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,45));   //heating type

// remove the fuel
//  F1 := GetCellString(doc, mcx(cx,46));   //fuel
//  if length(F1)>0 then
//    S1 := S1 +'/'+ F1;                    //type/fuel

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 47)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,48)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,50));       //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,40), S1); //transfer to grid
      ProcessForm0345Math(doc, cmd, MCPX(CX,3,40));
    end;
  result := 0;
end;

function F0345Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 55 then
      begin
        if (not CellIsChecked(doc, mcx(cx,56))) then
          SetCellValue(doc, MCX(CX,57), 0);
      end
    else if doc.docActiveCell.UID.Num = 56 then
      if GetCellValue(doc, MCX(CX,57)) = 0 then
        SetCellChkMark(doc, mcx(cx,56), False)
      else if GetCellString(doc, MCX(CX,57)) <> '' then
        SetCellChkMark(doc, mcx(cx,56), True);

  V1 := Trunc(GetCellValue(doc, mcx(cx, 57)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces');        //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), S1);          //result
      ProcessForm0345Math(doc, cmd, MCPX(CX,3,45));
    end
  else if not CellIsChecked(doc, mcx(cx,56)) then
    if doc.UADEnabled then
      begin
        SetCellValue(doc, MCX(CX,57), 0);              //firepace count
        SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces'); //heading
        Cmd := SetCellString(doc, MCPX(CX, 3,45), '0');    //cell result
        ProcessForm0345Math(doc, cmd, MCPX(CX,3,45));
      end
    else
    begin
      if GetCellValue(doc, mcx(cx, 57)) > 0 then
        SetCellString(doc, MCX(CX,57), '');                //firepace count
      SetCellString(doc, MCPX(CX, 3, 44), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), '');     //result
      ProcessForm0345Math(doc, cmd, MCPX(CX,3,45));
    end;

  result := 0;
end;

function F0345PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
//Ticket #1129:  if porch none is checked, set porch to EMPTY, abbreviate porch as Pch, patio as Pat  Deck as Dck
  if CellIsChecked(doc, mcx(CX, 60)) then
    begin
      S1 := 'Dck/Pat';
    end;

  if CellIsChecked(doc, mcx(CX, 62)) then
    begin
      if length(S1) > 0 then
        S1 := Concat(S1, ',', 'Porch/Bal')
      else
        S1 := 'Porch/Bal';
    end;

      cmd := SetCellString(doc, MCPX(CX,3,43), S1); //transfer to grid
      ProcessForm0345Math(doc, cmd, MCPX(CX,3,43));
  result := 0;
end;

function F0345Woodstove(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 57 then
      begin
        if (not CellIsChecked(doc, mcx(cx,58))) then
          SetCellValue(doc, MCX(CX,59), 0);
      end
    else if doc.docActiveCell.UID.Num = 58 then
      if GetCellValue(doc, MCX(CX,59)) = 0 then
        SetCellChkMark(doc, mcx(cx,58), False)
      else if GetCellString(doc, MCX(CX,59)) <> '' then
        SetCellChkMark(doc, mcx(cx,58), True);
  result := 0;
end;

function F0345OtherAmenity(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 63 then
      begin
        if (not CellIsChecked(doc, mcx(cx,64))) then
          SetCellString(doc, MCX(CX,65), 'None');
      end
    else if doc.docActiveCell.UID.Num = 64 then
      if Uppercase(GetCellString(doc, MCX(CX,65))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,64), False);
          SetCellString(doc, MCX(CX,65), 'None');
        end
      else if GetCellString(doc, MCX(CX,65)) <> '' then
        SetCellChkMark(doc, mcx(cx,64), True);
  result := 0;
end;

function F0345NoCarGarage(doc: TContainer; CX: CellUID): Integer;
var
  ClrStr: String;
begin
  if CellIsChecked(doc, mcx(CX, 72)) then
    begin
      if doc.UADEnabled then
        ClrStr := '0'
      else
        ClrStr := '';
      SetCellChkMark(doc, Mcx(cx,73), False);
      SetCellChkMark(doc, Mcx(cx,74), False);
      SetCellChkMark(doc, Mcx(cx,75), False);
      SetCellString(doc, MCX(CX, 76), ClrStr);
      SetCellChkMark(doc, Mcx(cx,77), False);
      SetCellChkMark(doc, Mcx(cx,78), False);
      SetCellString(doc, MCX(CX, 79), ClrStr);
      SetCellString(doc, MCPX(CX,3,42), ''); //transfer to grid
    end;
  result := 0;
end;

procedure GetUADGridCarSpaces(theStr: String; var AttQty, DetQty, BinQty: Integer);
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
          if Copy(theStr, 1, 1) = GGar then
            begin
              AttQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 2, Length(theStr));
            end
          else if Copy(theStr, 1, 2) = GCov then
            begin
              DetQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 3, Length(theStr));
            end
          else if Copy(theStr, 1, 2) = GOpn then
            begin
              BinQty := StrToInt(AStrNum);
              theStr := Copy(theStr, 3, Length(theStr));
            end
          else
            theStr := '';
        end
      else
        theStr := '';
    end;
end;

function F0345CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  UADCell: TBaseCell;
  S1, S2, S3: string;
  cmd: Integer;
  GarChkd, CovChkd, OpnChkd, GridMatch: Boolean;
  GarGridQty, CovGridQty, OpnGridQty, ChkdQty, GridQty, CarQty: Integer;
  OwTxt, CarQtyStr, GridQtyStr, GarGridQtyStr, CovGridQtyStr, OpnGridQtyStr: String;
  UnitQty, RemainQty: Integer;
begin
  S1 := '';
  S2 := '';
  S3 := '';
  if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
    begin
      ChkdQty := 0;
      GarChkd := False;
      GridQtyStr := GetCellString(doc, MCPX(CX,3,42));   //grid data
      CarQty := Round(GetCellValue(doc, mcx(cx,76)));
      CarQtyStr := IntToStr(CarQty);
      if CellIsChecked(doc, mcx(cx, 73)) then
        begin
          ChkdQty := Succ(ChkdQty);
          GarChkd := True;
        end;
      CovChkd := False;
      if CellIsChecked(doc, mcx(cx, 74)) then
        begin
          ChkdQty := Succ(ChkdQty);
          CovChkd := True;
        end;
      OpnChkd := False;
      if CellIsChecked(doc, mcx(cx, 75)) then
        begin
          ChkdQty := Succ(ChkdQty);
          OpnChkd := True;
        end;
      if CarQty > 0 then
        begin
          if ChkdQty <= 1 then
            begin
              if GarChkd then
                begin
                  S1 := GGar;
                  ClearCheckMark(doc, MCX(cx,74));    //make sure the Covered checkbox is unchecked
                  ClearCheckMark(doc, MCX(cx,75));    //make sure the Open checkbox is unchecked
                end
              else if CovChkd then
                begin
                  S1 := GCov;
                  ClearCheckMark(doc, MCX(cx,75));    //make sure the Open checkbox is unchecked
                end
              else if OpnChkd then
                S1 := GOpn
              else
                begin
                  S1 := GGar;
                  SetCellChkMark(doc, MCX(cx,73), True);     //make sure the Garage checkbox is checked
                end;
              S3 := CarQtyStr + S1;
            end
          else
            begin
              // If there's not enough cars declared to cover the number of checked boxes then we
              //  must uncheck one, or more of the boxes.
              if CarQty < ChkdQty then
                begin
                  RemainQty := CarQty;
                  if GarChkd then
                    RemainQty := Pred(RemainQty);
                  if RemainQty = 0 then
                    begin
                      ClearCheckMark(doc, MCX(cx,74));    //make sure the Covered checkbox is unchecked
                      ClearCheckMark(doc, MCX(cx,75));    //make sure the Open checkbox is unchecked
                    end
                  else if CovChkd then
                    RemainQty := Pred(RemainQty);
                  if RemainQty = 0 then
                    ClearCheckMark(doc, MCX(cx,75));    //make sure the Open checkbox is unchecked
                end;
              GarGridQty := 0;
              CovGridQty := 0;
              OpnGridQty := 0;
              if Length(GridQtyStr) > 0 then
                GetUADGridCarSpaces(GridQtyStr, GarGridQty, CovGridQty, OpnGridQty);
              GarGridQtyStr := IntToStr(GarGridQty);
              CovGridQtyStr := IntToStr(CovGridQty);
              OpnGridQtyStr := IntToStr(OpnGridQty);
              GridQty := GarGridQty + CovGridQty + OpnGridQty;
              GridMatch := (CarQty = GridQty);
              if GridMatch then
                GridMatch := (((GarGridQty > 0) and GarChkd) or ((GarGridQty = 0) and (not GarChkd)));
              if GridMatch then
                GridMatch := (((CovGridQty > 0) and CovChkd) or ((CovGridQty = 0) and (not CovChkd)));
              if GridMatch then
                GridMatch := (((OpnGridQty > 0) and OpnChkd) or ((OpnGridQty = 0) and (not OpnChkd)));
              // If the grid matches the checkbox states and the garage quantity equal the total
              //  of the grid quantites then we want to preserve the grid text format.
              if GridMatch then
                begin
                  if GarGridQty > 0 then
                    S3 := S3 + GarGridQtyStr + GGar;
                  if CovGridQty > 0 then
                    S3 := S3 + CovGridQtyStr + GCov;
                  if OpnGridQty > 0 then
                    S3 := S3 + OpnGridQtyStr + GOpn;
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
                  if ChkdQty > CarQty then
                    begin
                      UnitQty := 1;
                      RemainQty := 0;
                    end
                  else
                    begin
                      UnitQty := CarQty div ChkdQty;
                      RemainQty := CarQty mod ChkdQty;
                    end;
                  if GarChkd then
                    begin
                      S3 := S3 + IntToStr(UnitQty + RemainQty) + GGar;
                      CarQty := CarQty - UnitQty - RemainQty;
                      RemainQty := 0;
                    end;
                  if (CarQty > 0) then
                    begin
                      if CovChkd then
                        begin
                          S3 := S3 + IntToStr(UnitQty + RemainQty) + GCov;
                          CarQty := CarQty - UnitQty - RemainQty;
                          RemainQty := 0;
                        end;
                    end;
                  if (CarQty > 0) then
                    begin
                      if OpnChkd then
                        S3 := S3 + IntToStr(UnitQty + RemainQty) + GOpn;
                    end;
                end;
            end;
        end
      else
        begin
          if GarChkd then
            S3 := S3 + GGar;
          if CovChkd then
            S3 := S3 + GCov;
          if OpnChkd then
            S3 := S3 + GOpn;
        end;

      if CellIsChecked(doc, mcx(cx,77)) then
        begin
          UADCell := doc.GetCell(mcx(CX,77));
          if assigned(UADCell) and (UADCell.Tag > 0) then
            S2 := ';' + IntToStr(UADCell.Tag) + 'a'
          else
            S2 := ';1a';
        end;
      if CellIsChecked(doc, mcx(cx,78)) then
        begin
          UADCell := doc.GetCell(mcx(CX,78));
          if assigned(UADCell) and (UADCell.Tag > 0) then
            OwTxt := IntToStr(UADCell.Tag) + 'ow'
          else
            OwTxt := '1ow';
          if not CellIsChecked(doc, mcx(cx,77)) then
            S2 := ';' + OwTxt
          else
            S2 := S2 + ' ' + OwTxt;
        end;
      S3 := S3 + S2;
      // now get any "Other" description
      UADCell := doc.GetCell(mcx(CX,79));
      if assigned(UADCell) and (Trim(UADCell.GSEData) <> '') then
        S3 := S3 + ';' + Trim(UADCell.GSEData);

      if length(S3) > 0 then
        begin
          cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
          ProcessForm0345Math(doc, Cmd, MCPX(CX,3,42));
          if CellIsChecked(doc, MCX(cx,72)) Then
            SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars
        end
      else
        begin
          if (not GarChkd) and (not CovChkd) and (not OpnChkd) then
            begin
              SetCellChkMark(doc, MCX(cx,72), True);       //make sure we check None for cars
              F0345NoCarGarage(doc, cx);
              cmd := SetCellString(doc, MCPX(CX,3,42), ('None' + S2)); //transfer to grid
              ProcessForm0345Math(doc, Cmd, MCPX(CX,3,42));
            end
          else
            if CellIsChecked(doc, MCX(cx,72)) Then
              SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars
        end;
    end
  else
    begin
      if CellIsChecked(doc, mcx(cx, 73)) then
        S1 := 'Garage'
      else if CellIsChecked(doc, mcx(cx,74)) then
        S1 := 'Covered'
      else if CellIsChecked(doc, mcx(cx,75)) then
        S1 := 'Open';

      if Length(S1) > 0 then
        if GetCellValue(doc, mcx(CX, 76)) > 0 then
          begin
            S2 := GetCellString(doc, mcx(cx,76));
            S3 := S2 + ' Car ' + S1;
          end
        else
          S3 := 'Car ' + S1;

      //Github #132: if none of the check box in 73, 74, 75 checked but we have # cars not EMPTY
      if CellIsChecked(doc, MCX(cx,72)) then
        begin
          if (length(S3) > 0) or (GetCellValue(doc, mcx(CX, 76)) > 0) then //we have car #
            SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars
        end;
//      if (length(S3)>0) and CellIsChecked(doc, MCX(cx,72)) Then
//        SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars

      if length(S3) > 0 then
        begin
          cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
          ProcessForm0345Math(doc, cmd, MCPX(CX,3,42));
        end;
    end;
  result := 0;
end;

function F0345UADGridCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  TmpCell: TBaseCell;
  S1, S2, S3: string;
  cmd, PosIdx, CarNum, TotCarNum, EndIdx: Integer;
begin
  TotCarNum := 0;
  S1 := Trim(GetCellString(doc, MCPX(cx,3,42)));   //Grid text
  if S1 <> 'None' then
    begin
      TmpCell := doc.GetCell(MCPX(cx,2,72));
      TmpCell.DoSetText(' ');

      PosIdx := Pos(';', S1);
      if PosIdx > 0 then
        begin
          S2 := Copy(S1, Succ(PosIdx), Length(S1));
          S1 := Copy(S1, 1, Pred(PosIdx));
        end
      else
        S2 := '';

      TmpCell := doc.GetCell(MCPX(cx,2,73));
      TmpCell.Tag := 0;
      PosIdx := Pos('g', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := CarNum;
          S1 := Copy(S1, Succ(PosIdx), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,74));
      TmpCell.Tag := 0;
      PosIdx := Pos('cv', S1);
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

      TmpCell := doc.GetCell(MCPX(cx,2,75));
      TmpCell.Tag := 0;
      PosIdx := Pos('op', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := TotCarNum + CarNum;
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,77));
      TmpCell.Tag := 0;
      PosIdx := Pos('a ', S2);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S2, 1, Pred(PosIdx));
        if S3 <> '' then
         TmpCell.Tag := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
        S2 := Copy(S2, (PosIdx+2), Length(S2));
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,78));
      TmpCell.Tag := 0;
      PosIdx := Pos('ow', S2);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S2, 1, Pred(PosIdx));
        if S3 <> '' then
         TmpCell.Tag := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
       end
      else
       TmpCell.DoSetText(' ');
    end
  else
    begin
      SetCellChkMark(doc, MCPX(CX,2,73), False);      //Garage
      SetCellChkMark(doc, MCPX(CX,2,74), False);      //Covered
      SetCellChkMark(doc, MCPX(CX,2,75), False);      //Open
      SetCellChkMark(doc, MCPX(CX,2,77), False);      //Assigned
      SetCellChkMark(doc, MCPX(CX,2,78), False);      //Owned
      SetCellString(doc, MCPX(CX,2,79), '');          //Parking Space #
      SetCellChkMark(doc, MCPX(CX,2,72), True);       //None
    end;

  cmd := SetCellString(doc, MCPX(CX,2,76), IntToStr(TotCarNum)); // save the number of cars
  result := 0;
end;

function F0345UADDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  PosSC, cmd: Integer;
begin
  if CellIsChecked(doc, MCPX(CX,1,132)) then
    S1 := CondoAttachType[0]
  else if CellIsChecked(doc, MCPX(cx,1,133)) then
    S1 := CondoAttachType[1]
  else if CellIsChecked(doc, MCPX(cx,1,134)) then
    S1 := CondoAttachType[2]
  else if CellIsChecked(doc, MCPX(cx,1,135)) then
    S1 := CondoAttachType[3]
  else if CellIsChecked(doc, MCPX(cx,1,136)) then
    S1 := CondoAttachType[4]
  else if CellIsChecked(doc, MCPX(cx,1,137)) then
    S1 := CondoAttachType[5]
  else
    S1 := '';
  S1 := S1 + GetCellString(doc, MCPX(CX,2,44));   //Levels

  if Length(S1) > 0 then
    if CellIsChecked(doc, MCPX(cx,1,137)) then
      S1 := S1 + 'L;' + GetCellString(doc, MCPX(cx,1,138))   //Design (Style) description
    else
      begin
        S2 := GetCellString(doc, MCPX(cx,3,29));
        PosSC := Pos(';', S2);
        if PosSC > 0 then
          S2 := Copy(S2, Succ(PosSC), Length(S2))
        else
          S2 := '';
        S1 := S1 + 'L;' + S2;   //Design (Style) description from the grid
      end;
  if length(S1) > 0 then
    cmd := SetCellString(doc, MCPX(CX,3,29), S1); //transfer to grid
  result := 0;
end;

function F0345UADGridDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd, PosIdx: Integer;
  IsOther: Boolean;
begin
  IsOther := False;
  S1 := GetCellString(doc, MCPX(cx,3,29));   //Grid text
  PosIdx := Pos(CondoAttachType[0], S1);
  if PosIdx = 1 then
   SetCellChkMark(doc, MCPX(CX,1,132), True)       //Detached type
  else
   begin
    PosIdx := Pos(CondoAttachType[1], S1);
    if PosIdx = 1 then
     SetCellChkMark(doc, MCPX(CX,1,133), True)   //Row or Townhouse type
    else
     begin
      PosIdx := Pos(CondoAttachType[2], S1);
      if PosIdx = 1 then
       SetCellChkMark(doc, MCPX(CX,1,134), True)   //Garden type
      else
       begin
        PosIdx := Pos(CondoAttachType[3], S1);
        if PosIdx = 1 then
         SetCellChkMark(doc, MCPX(CX,1,135), True)   //Mid-Rise type
        else
         begin
          PosIdx := Pos(CondoAttachType[4], S1);
          if PosIdx = 1 then
           SetCellChkMark(doc, MCPX(CX,1,136), True)   //High-Rise type
          else
           begin
            PosIdx := Pos(CondoAttachType[5], S1);
            if PosIdx = 1 then
             begin
               IsOther := True;
               SetCellChkMark(doc, MCPX(CX,1,137), True)   //Other type
             end;
           end;
         end;
       end;
     end;
   end;

  // if we found an attachment type strip it from the text
  if PosIdx = 1 then
    if IsOther then
      S1 := Copy(S1, 2, Length(S1))
    else
      S1 := Copy(S1, 3, Length(S1));

  if Length(S1) > 0 then
    begin
      PosIdx := Pos('L;', S1);
      if PosIdx > 0 then
        begin
          //only transfer the levels or description if they changed - otherwise
          // math for these cells will re-fire and may cause unwanted results
          S2 := Copy(S1, (PosIdx+2), Length(S1));
          if GetCellString(doc, MCPX(CX,1,138)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,138), S2); //transfer description
          S2 := Copy(S1, 1, Pred(PosIdx));
          if GetCellString(doc, MCPX(CX,2,44)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,2,44), S2); //transfer stories
        end
      else // no type so just put everything in the Design (Style) description field
        cmd := SetCellString(doc, MCPX(CX,1,138), S1);
    end;
  result := 0;
end;

function F0345C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,50));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 55,116,117,114,115,2,3,
    [60,62,64,66,68,70,72,74,76,78,80,82,84,86,87,91,93,95,97,99,101,103,105,107,109,111,113],length(addr) > 0);
end;

function F0345C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,118));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 123,184,185,182,183,4,5,
    [128,130,132,134,136,138,140,142,144,146,148,150,152,154,155,159,161,163,165,167,169,171,173,175,177,179,181],length(addr) > 0);
end;

function F0345C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,186));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 191,252,253,250,251,6,7,
    [196,198,200,202,204,206,208,210,212,214,216,218,220,222,223,227,229,231,233,235,237,239,241,243,245,247,249],length(addr) > 0);
end;


{ Non-Lender Condo }

function F0735HOATransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,3,CR), VR);           //transfer to grid
  ProcessForm0735Math(doc, cmd, MCPX(CX,3,CR));          //do any math on it

result := 0;
end;

function F0735UnitChargeTransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,2,CR), VR);           //transfer to grid
  ProcessForm0735Math(doc, cmd, MCPX(CX,2,CR));          //do any math on it

result := 0;
end;

function F0735HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
//F1: String;
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,45));   //heating type

// remove the fuel
//  F1 := GetCellString(doc, mcx(cx,46));   //fuel
//  if length(F1)>0 then
//    S1 := S1 +'/'+ F1;                    //type/fuel

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 47)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,48)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,50));       //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,40), S1); //transfer to grid
      ProcessForm0735Math(doc, cmd, MCPX(CX,3,40));
    end;
  result := 0;
end;

function F0735Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 57)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,56), True);                    //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces');        //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), S1);          //result
      ProcessForm0735Math(doc, cmd, MCPX(CX,3,45));
    end

  else if not CellIsChecked(doc, mcx(cx,56)) then
    begin
      if GetCellValue(doc, mcx(cx, 57)) > 0 then
        SetCellString(doc, MCX(CX,57), '');                //firepace count
      SetCellString(doc, MCPX(CX, 3, 44), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), '');     //result
      ProcessForm0735Math(doc, cmd, MCPX(CX,3,45));
    end;
  result := 0;
end;

function F0735PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  Cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 60)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 62)) then
    begin
      if length(S1) > 0 then
        S1 := Concat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,43), S1); //transfer to grid
      ProcessForm0735Math(doc, cmd, MCPX(CX,3,43));
    end;
  result := 0;
end;

function F0735NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 72)) then
    begin
      SetCellChkMark(doc, Mcx(cx,73), False);
      SetCellChkMark(doc, Mcx(cx,74), False);
      SetCellChkMark(doc, Mcx(cx,75), False);
      SetCellString(doc, MCX(CX, 76), '');
      SetCellChkMark(doc, Mcx(cx,77), False);
      SetCellChkMark(doc, Mcx(cx,78), False);
      SetCellString(doc, MCX(CX, 79), '');
      SetCellString(doc, MCPX(CX,3,42), ''); //transfer to grid
    end;
  result := 0;
end;

function F0735CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3,S4,S5,S6: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 73)) then
    S1 := 'Garage'
  else if CellIsChecked(doc, mcx(cx,74)) then
    S1 := 'Carport'
  else if CellIsChecked(doc, mcx(cx,75)) then
    S1 := 'Open';

  if GetCellValue(doc, mcx(CX, 76)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,76));
      S3 := S2 + ' Car ' + S1;
    end;

  S4 := '';
  if CellIsChecked(doc, mcx(cx, 77)) then
    S4 := 'Assigned'
  else if CellIsChecked(doc, mcx(cx,78)) then
    S4 := 'Owned';

  if GetCellValue(doc, mcx(cx,79)) > 0 then
    begin
      S5 := GetCellString(doc, mcx(cx,79));
      S6 := S5 + ' ' + S4 + ' Spaces';
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,72)) Then
    SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
      ProcessForm0735Math(doc, cmd, MCPX(CX,3,42));
    end;
  result := 0;
end;

function F0735C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,50));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 55,116,117,114,115,2,3,
    [60,62,64,66,68,70,72,74,76,78,80,82,84,86,87,91,93,95,97,99,101,103,105,107,109,111,113],length(addr) > 0);
end;

function F0735C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,118));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 123,184,185,182,183,4,5,
    [128,130,132,134,136,138,140,142,144,146,148,150,152,154,155,159,161,163,165,167,169,171,173,175,177,179,181],length(addr) > 0);
end;

function F0735C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,186));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 191,252,253,250,251,6,7,
    [196,198,200,202,204,206,208,210,212,214,216,218,220,222,223,227,229,231,233,235,237,239,241,243,245,247,249],length(addr) > 0);
end;


{ Condo 1075 Exterior Only}

//never do math this way. The page is hardcode which is NOT the way to do this
function F0347HOATransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //centeral air
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //individual
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,3,CR), VR);           //transfer to grid
  ProcessForm0345Math(doc, cmd, MCPX(CX,3,CR));          //do any math on it

  result := 0;
end;

function F0347UnitChargeTransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;                       
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12.0;
    end;

  cmd := SetCellValue(doc, MCPX(CX,2,CR), VR);           //transfer to grid
  ProcessForm0347Math(doc, cmd, MCPX(CX,2,CR));          //do any math on it

result := 0;
end;

function F0347HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,53));   //heating type
  S2 := '';
  if CellIsChecked(doc, mcx(cx, 55)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,56)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,58));       //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,40), S1); //transfer to grid
      ProcessForm0347Math(doc, cmd, MCPX(CX,3,40));
    end;
  result := 0;
end;

function F0347Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 58 then
      begin
        if (not CellIsChecked(doc, mcx(cx,59))) then
          SetCellValue(doc, MCX(CX,60), 0);
      end
    else if doc.docActiveCell.UID.Num = 59 then
      if GetCellValue(doc, MCX(CX,60)) = 0 then
        SetCellChkMark(doc, mcx(cx,59), False)              
      else if GetCellString(doc, MCX(CX,60)) <> '' then
        SetCellChkMark(doc, mcx(cx,59), True);              

  V1 := Trunc(GetCellValue(doc, mcx(cx, 60)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces');        //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), S1);          //result
      ProcessForm0347Math(doc, cmd, MCPX(CX,3,45));
    end
  else if not CellIsChecked(doc, mcx(cx,59)) then
    if doc.UADEnabled then
      begin
        SetCellValue(doc, MCX(CX,60), 0);              //firepace count
        SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces'); //heading
        Cmd := SetCellString(doc, MCPX(CX, 3,45), '0');    //cell result
        ProcessForm0347Math(doc, cmd, MCPX(CX,3,45));
      end
    else
      begin
        if GetCellValue(doc, mcx(cx, 60)) > 0 then
          SetCellString(doc, MCX(CX,60), '');                //firepace count
        SetCellString(doc, MCPX(CX, 3, 44), '');             //heading
        cmd := SetCellString(doc, MCPX(CX,3,45), '');     //result
        ProcessForm0347Math(doc, cmd, MCPX(CX,3,45));
      end;
  result := 0;
end;

function F0347PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  if doc.UADEnabled then
    case doc.docActiveCell.UID.Num of
      62:
        if (not CellIsChecked(doc, mcx(cx,63))) then
          SetCellString(doc, MCX(CX,64), 'None');
      63:
        if Uppercase(GetCellString(doc, MCX(CX,64))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,63), False);
            SetCellString(doc, MCX(CX,64), 'None');
          end
        else if GetCellString(doc, MCX(CX,64)) <> '' then
          SetCellChkMark(doc, mcx(cx,63), True);
      64:
        if (not CellIsChecked(doc, mcx(cx,65))) then
          SetCellString(doc, MCX(CX,66), 'None');
      65:
        if Uppercase(GetCellString(doc, MCX(CX,66))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,65), False);
            SetCellString(doc, MCX(CX,66), 'None');
          end
        else if GetCellString(doc, MCX(CX,66)) <> '' then
          SetCellChkMark(doc, mcx(cx,65), True);
    end;

  S1 := '';
  //set the porch
//Ticket #1129:  if porch none is checked, set porch to EMPTY, abbreviate porch as Pch, patio as Pat  Deck as Dck
  S1:= '';
  //set the porch
  if CellIsChecked(doc, mcx(CX, 63)) then
    begin
      S1 := 'Dck/Pat';   //need to shorten up so all fourt Pat/Deck,Porch/Bal fit in one cell
    end;

  if CellIsChecked(doc, mcx(CX, 65)) then
    begin
      if Length(S1) > 0 then
        S1 := concat(S1, ',', 'Porch/Bal')
      else
        S1 := 'Porch/Bal';
    end;

      cmd := SetCellString(doc, MCPX(CX,3,43), S1); //transfer to grid
      ProcessForm0345Math(doc, cmd, MCPX(CX,3,43));
  result := 0;
end;

function F0347Woodstove(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 60 then
      begin
        if (not CellIsChecked(doc, mcx(cx,61))) then
          SetCellValue(doc, MCX(CX,62), 0);
      end
    else if doc.docActiveCell.UID.Num = 61 then
      if GetCellValue(doc, MCX(CX,62)) = 0 then
        SetCellChkMark(doc, mcx(cx,61), False)
      else if GetCellString(doc, MCX(CX,62)) <> '' then
        SetCellChkMark(doc, mcx(cx,61), True);
  result := 0;
end;

function F0347OtherAmenity(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 66 then
      begin
        if (not CellIsChecked(doc, mcx(cx,67))) then
          SetCellString(doc, MCX(CX,68), 'None');
      end
    else if doc.docActiveCell.UID.Num = 67 then
      if Uppercase(GetCellString(doc, MCX(CX,68))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,67), False);
          SetCellString(doc, MCX(CX,68), 'None');
        end  
      else if GetCellString(doc, MCX(CX,68)) <> '' then
        SetCellChkMark(doc, mcx(cx,67), True);
  result := 0;
end;

function F0347NoCarGarage(doc: TContainer; CX: CellUID): Integer;
var
  ClrStr: String;
begin
  if CellIsChecked(doc, mcx(CX, 75)) then
    begin
      if doc.UADEnabled then
        ClrStr := '0'
      else
        ClrStr := '';
      SetCellChkMark(doc, Mcx(cx,76), False);
      SetCellChkMark(doc, Mcx(cx,77), False);
      SetCellChkMark(doc, Mcx(cx,78), False);
      SetCellString(doc, MCX(CX, 79), ClrStr);
      SetCellChkMark(doc, Mcx(cx,80), False);
      SetCellChkMark(doc, Mcx(cx,81), False);
      SetCellString(doc, MCX(CX, 82), ClrStr);
      SetCellString(doc, MCPX(CX,3,42), ''); //transfer to grid
    end;
  result := 0;
end;

function F0347CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  UADCell: TBaseCell;
  S1,S2,S3: string;
  cmd: Integer;
  GarChkd, CovChkd, OpnChkd, GridMatch: Boolean;
  GarGridQty, CovGridQty, OpnGridQty, ChkdQty, GridQty, CarQty: Integer;
  OwTxt, CarQtyStr, GridQtyStr, GarGridQtyStr, CovGridQtyStr, OpnGridQtyStr: String;
  UnitQty, RemainQty: Integer;
begin
  S1 := '';
  S3 := '';
  if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
    begin
      ChkdQty := 0;
      GarChkd := False;
      GridQtyStr := GetCellString(doc, MCPX(CX,3,42));   //grid data
      CarQty := Round(GetCellValue(doc, mcx(cx,79)));
      CarQtyStr := IntToStr(CarQty);
      if CellIsChecked(doc, mcx(cx, 76)) then
        begin
          ChkdQty := Succ(ChkdQty);
          GarChkd := True;
        end;
      CovChkd := False;
      if CellIsChecked(doc, mcx(cx, 77)) then
        begin
          ChkdQty := Succ(ChkdQty);
          CovChkd := True;
        end;
      OpnChkd := False;
      if CellIsChecked(doc, mcx(cx, 78)) then
        begin
          ChkdQty := Succ(ChkdQty);
          OpnChkd := True;
        end;
      if CarQty > 0 then
        begin
          if ChkdQty <= 1 then
            begin
              if GarChkd then
                begin
                  S1 := GGar;
                  ClearCheckMark(doc, MCX(cx,77));    //make sure the Covered checkbox is unchecked
                  ClearCheckMark(doc, MCX(cx,78));    //make sure the Open checkbox is unchecked
                end
              else if CovChkd then
                begin
                  S1 := GCov;
                  ClearCheckMark(doc, MCX(cx,78));    //make sure the Open checkbox is unchecked
                end
              else if OpnChkd then
                S1 := GOpn
              else
                begin
                  S1 := GGar;
                  SetCellChkMark(doc, MCX(cx,76), True);     //make sure the Garage checkbox is checked
                end;
              S3 := CarQtyStr + S1;
            end
          else
            begin
              // If there's not enough cars declared to cover the number of checked boxes then we
              //  must uncheck one, or more of the boxes.
              if CarQty < ChkdQty then
                begin
                  RemainQty := CarQty;
                  if GarChkd then
                    RemainQty := Pred(RemainQty);
                  if RemainQty = 0 then
                    begin
                      ClearCheckMark(doc, MCX(cx,77));    //make sure the Covered checkbox is unchecked
                      ClearCheckMark(doc, MCX(cx,78));    //make sure the Open checkbox is unchecked
                    end
                  else if CovChkd then
                    RemainQty := Pred(RemainQty);
                  if RemainQty = 0 then
                    ClearCheckMark(doc, MCX(cx,78));    //make sure the Open checkbox is unchecked
                end;
              GarGridQty := 0;
              CovGridQty := 0;
              OpnGridQty := 0;
              if Length(GridQtyStr) > 0 then
                GetUADGridCarSpaces(GridQtyStr, GarGridQty, CovGridQty, OpnGridQty);
              GarGridQtyStr := IntToStr(GarGridQty);
              CovGridQtyStr := IntToStr(CovGridQty);
              OpnGridQtyStr := IntToStr(OpnGridQty);
              GridQty := GarGridQty + CovGridQty + OpnGridQty;
              GridMatch := (CarQty = GridQty);
              if GridMatch then
                GridMatch := (((GarGridQty > 0) and GarChkd) or ((GarGridQty = 0) and (not GarChkd)));
              if GridMatch then
                GridMatch := (((CovGridQty > 0) and CovChkd) or ((CovGridQty = 0) and (not CovChkd)));
              if GridMatch then
                GridMatch := (((OpnGridQty > 0) and OpnChkd) or ((OpnGridQty = 0) and (not OpnChkd)));
              // If the grid matches the checkbox states and the garage quantity equal the total
              //  of the grid quantites then we want to preserve the grid text format.
              if GridMatch then
                begin
                  if GarGridQty > 0 then
                    S3 := S3 + GarGridQtyStr + GGar;
                  if CovGridQty > 0 then
                    S3 := S3 + CovGridQtyStr + GCov;
                  if OpnGridQty > 0 then
                    S3 := S3 + OpnGridQtyStr + GOpn;
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
                  if ChkdQty > CarQty then
                    begin
                      UnitQty := 1;
                      RemainQty := 0;
                    end
                  else
                    begin
                      UnitQty := CarQty div ChkdQty;
                      RemainQty := CarQty mod ChkdQty;
                    end;
                  if GarChkd then
                    begin
                      S3 := S3 + IntToStr(UnitQty + RemainQty) + GGar;
                      CarQty := CarQty - UnitQty - RemainQty;
                      RemainQty := 0;
                    end;
                  if (CarQty > 0) then
                    begin
                      if CovChkd then
                        begin
                          S3 := S3 + IntToStr(UnitQty + RemainQty) + GCov;
                          CarQty := CarQty - UnitQty - RemainQty;
                          RemainQty := 0;
                        end;
                    end;
                  if (CarQty > 0) then
                    begin
                      if OpnChkd then
                        S3 := S3 + IntToStr(UnitQty + RemainQty) + GOpn;
                    end;
                end;
            end;
        end
      else
        begin
          if GarChkd then
            S3 := S3 + GGar;
          if CovChkd then
            S3 := S3 + GCov;
          if OpnChkd then
            S3 := S3 + GOpn;
        end;
      if CellIsChecked(doc, mcx(cx,80)) then
        begin
          UADCell := doc.GetCell(mcx(CX,80));
          if assigned(UADCell) and (UADCell.Tag > 0) then
            S2 := ';' + IntToStr(UADCell.Tag) + 'a'
          else
            S2 := ';1a';
        end;
      if CellIsChecked(doc, mcx(cx,81)) then
        begin
          UADCell := doc.GetCell(mcx(CX,81));
          if assigned(UADCell) and (UADCell.Tag > 0) then
            OwTxt := IntToStr(UADCell.Tag) + 'ow'
          else
            OwTxt := '1ow';
          if not CellIsChecked(doc, mcx(cx,80)) then
            S2 := ';' + OwTxt
          else
            S2 := S2 + ' ' + OwTxt;
        end;
      S3 := S3 + S2;
      // now get any "Other" description
      UADCell := doc.GetCell(mcx(CX,82));
      if assigned(UADCell) and (Trim(UADCell.GSEData) <> '') then
        S3 := S3 + ';' + Trim(UADCell.GSEData);

      if length(S3) > 0 then
        begin
          cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
          ProcessForm0345Math(doc, Cmd, MCPX(CX,3,42));
          if CellIsChecked(doc, MCX(cx,75)) Then
            SetCellChkMark(doc, MCX(cx,75), False);    //make sure we uncheck None for cars
        end
      else
        begin
          if (not GarChkd) and (not CovChkd) and (not OpnChkd) then
            begin
              SetCellChkMark(doc, MCX(cx,75), True);       //make sure we check None for cars
              F0345NoCarGarage(doc, cx);
              cmd := SetCellString(doc, MCPX(CX,3,42), (S2)); //transfer to grid
              ProcessForm0345Math(doc, Cmd, MCPX(CX,3,42));
            end
          else
            if CellIsChecked(doc, MCX(cx,75)) Then
              SetCellChkMark(doc, MCX(cx,75), False);    //make sure we uncheck None for cars
        end;
    end
  else
    begin
      if CellIsChecked(doc, mcx(cx, 76)) then
        S1 := 'Garage'
      else if CellIsChecked(doc, mcx(cx,77)) then
        S1 := 'Covered'
      else if CellIsChecked(doc, mcx(cx,78)) then
        S1 := 'Open';

      if Length(S1) > 0 then
        if GetCellValue(doc, mcx(CX, 79)) > 0 then
          begin
            S2 := GetCellString(doc, mcx(cx,79));
            S3 := S2 + ' Car ' + S1;
          end
        else
          S3 := 'Car ' + S1;

      if (length(S3)>0) and CellIsChecked(doc, MCX(cx,75)) Then
        SetCellChkMark(doc, MCX(cx,75), False);    //make sure we uncheck None for cars

      if length(S3) > 0 then
        begin
          cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
          ProcessForm0347Math(doc, cmd, MCPX(CX,3,42));
        end;
    end;
  result := 0;
end;

function F0347UADGridCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  TmpCell: TBaseCell;
  S1, S2, S3: string;
  cmd, PosIdx, CarNum, TotCarNum, EndIdx: Integer;
begin
  TotCarNum := 0;
  S1 := Trim(GetCellString(doc, MCPX(cx,3,42)));   //Grid text
  if S1 <> 'None' then
    begin
      TmpCell := doc.GetCell(MCPX(cx,2,75));
      TmpCell.DoSetText(' ');

      PosIdx := Pos(';', S1);
      if PosIdx > 0 then
        begin
          S2 := Copy(S1, Succ(PosIdx), Length(S1));
          S1 := Copy(S1, 1, Pred(PosIdx));
        end
      else
        S2 := '';

      TmpCell := doc.GetCell(MCPX(cx,2,76));
      TmpCell.Tag := 0;
      PosIdx := Pos('g', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := CarNum;
          S1 := Copy(S1, Succ(PosIdx), Length(S1));
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,77));
      TmpCell.Tag := 0;
      PosIdx := Pos('cv', S1);
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

      TmpCell := doc.GetCell(MCPX(cx,2,78));
      TmpCell.Tag := 0;
      PosIdx := Pos('op', S1);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S1, 1, Pred(PosIdx));
        if S3 <> '' then
         begin
          CarNum := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
          TmpCell.Tag := CarNum;
          TotCarNum := TotCarNum + CarNum;
         end;
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,80));
      TmpCell.Tag := 0;
      PosIdx := Pos('a ', S2);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S2, 1, Pred(PosIdx));
        if S3 <> '' then
         TmpCell.Tag := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
        S2 := Copy(S2, (PosIdx+2), Length(S2));
       end
      else
       TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,2,81));
      TmpCell.Tag := 0;
      PosIdx := Pos('ow', S2);
      if PosIdx > 0 then
       begin
        TmpCell.DoSetText('X');
        S3 := Copy(S2, 1, Pred(PosIdx));
        if S3 <> '' then
         TmpCell.Tag := StrToInt(GetFirstNumInStr(S3, True, EndIdx));
       end
      else
       TmpCell.DoSetText(' ');
    end
  else
    begin
      SetCellChkMark(doc, MCPX(CX,2,76), False);      //Garage
      SetCellChkMark(doc, MCPX(CX,2,77), False);      //Covered
      SetCellChkMark(doc, MCPX(CX,2,78), False);      //Open
      SetCellChkMark(doc, MCPX(CX,2,80), False);      //Assigned
      SetCellChkMark(doc, MCPX(CX,2,81), False);      //Owned
      SetCellString(doc, MCPX(CX,2,82), '');          //Parking Space #
      SetCellChkMark(doc, MCPX(CX,2,75), True);       //None
    end;

  cmd := SetCellString(doc, MCPX(CX,2,79), IntToStr(TotCarNum)); // save the number of cars
  result := 0;
end;

function F0347UADDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  PosSC, cmd: Integer;
begin
  if CellIsChecked(doc, MCPX(CX,1,134)) then
    S1 := CondoAttachType[0]
  else if CellIsChecked(doc, MCPX(cx,1,135)) then
    S1 := CondoAttachType[1]
  else if CellIsChecked(doc, MCPX(cx,1,136)) then
    S1 := CondoAttachType[2]
  else if CellIsChecked(doc, MCPX(cx,1,137)) then
    S1 := CondoAttachType[3]
  else if CellIsChecked(doc, MCPX(cx,1,138)) then
    S1 := CondoAttachType[4]
  else if CellIsChecked(doc, MCPX(cx,1,139)) then
    S1 := CondoAttachType[5];
  S1 := S1 + GetCellString(doc, MCPX(CX,2,52));   //Levels

  if Length(S1) > 0 then
    if CellIsChecked(doc, MCPX(cx,1,139)) then
      S1 := S1 + 'L;' + GetCellString(doc, MCPX(cx,1,140))   //Design (Style) description
    else
      begin
        S2 := GetCellString(doc, MCPX(cx,3,29));
        PosSC := Pos(';', S2);
        if PosSC > 0 then
          S2 := Copy(S2, Succ(PosSC), Length(S2))
        else
          S2 := '';
        S1 := S1 + 'L;' + S2;   //Design (Style) description from the grid
      end;
  if length(S1) > 0 then
    cmd := SetCellString(doc, MCPX(CX,3,29), S1); //transfer to grid
  result := 0;
end;

function F0347UADGridDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd, PosIdx: Integer;
  IsOther: Boolean;
begin
  IsOther := False;
  S1 := GetCellString(doc, MCPX(cx,3,29));   //Grid text
  PosIdx := Pos(CondoAttachType[0], S1);
  if PosIdx = 1 then
   SetCellChkMark(doc, MCPX(CX,1,134), True)       //Detached type
  else
   begin
    PosIdx := Pos(CondoAttachType[1], S1);
    if PosIdx = 1 then
     SetCellChkMark(doc, MCPX(CX,1,135), True)   //Row or Townhouse type
    else
     begin
      PosIdx := Pos(CondoAttachType[2], S1);
      if PosIdx = 1 then
       SetCellChkMark(doc, MCPX(CX,1,136), True)   //Garden type
      else
       begin
        PosIdx := Pos(CondoAttachType[3], S1);
        if PosIdx = 1 then
         SetCellChkMark(doc, MCPX(CX,1,137), True)   //Mid-Rise type
        else
         begin
          PosIdx := Pos(CondoAttachType[4], S1);
          if PosIdx = 1 then
           SetCellChkMark(doc, MCPX(CX,1,138), True)   //High-Rise type
          else
           begin
            PosIdx := Pos(CondoAttachType[5], S1);
            if PosIdx = 1 then
             begin
               IsOther := True;
               SetCellChkMark(doc, MCPX(CX,1,139), True)   //Other type
             end;
           end;
         end;
       end;
     end;
   end;

  // if we found an attachment type strip it from the text
  if PosIdx = 1 then
    if IsOther then
      S1 := Copy(S1, 2, Length(S1))
    else
      S1 := Copy(S1, 3, Length(S1));

  if Length(S1) > 0 then
    begin
      PosIdx := Pos('L;', S1);
      if PosIdx > 0 then
        begin
          //only transfer the levels or description if they changed - otherwise
          // math for these cells will re-fire and may cause unwanted results
          S2 := Copy(S1, (PosIdx+2), Length(S1));
          if GetCellString(doc, MCPX(CX,1,140)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,140), S2); //transfer description
          S2 := Copy(S1, 1, Pred(PosIdx));
          if GetCellString(doc, MCPX(CX,2,52)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,2,52), S2); //transfer stories
        end
      else // no type so just put everything in the Design (Style) description field
        cmd := SetCellString(doc, MCPX(CX,1,140), S1);
    end;
  result := 0;
end;

function F0347C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,50));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 55,116,117,114,115,2,3,
    [60,62,64,66,68,70,72,74,76,78,80,82,84,86,87,91,93,95,97,99,101,103,105,107,109,111,113],length(addr) > 0);
end;

function F0347C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,118));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 123,184,185,182,183,4,5,
    [128,130,132,134,136,138,140,142,144,146,148,150,152,154,155,159,161,163,165,167,169,171,173,175,177,179,181],length(addr) > 0);
end;

function F0347C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,186));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 191,252,253,250,251,6,7,
    [196,198,200,202,204,206,208,210,212,214,216,218,220,222,223,227,229,231,233,235,237,239,241,243,245,247,249],length(addr) > 0);
end;


{ Small Income 1025 }
(*
function F0349HOATransfer(doc: TContainer; CX: CellUID; HOAID, MonthID, YearID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //centeral air
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //individual
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,3,CR), S1);           //transfer to grid
  ProcessForm0349Math(doc, cmd, MCPX(CX,3,CR));          //do any math on it

  result := 0;
end;
*)
function F0349AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  cmd: Integer;
begin
  S1 := GetCellString(doc, MCPX(CX,1,142));   //eff age
  S2 := GetCellString(doc, MCPX(CX,4,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      cmd := SetCellValue(doc, MCPX(CX,4,28), VR);
      ProcessForm0349Math(doc, cmd, MCPX(CX,4,28));
    end;
  result := 0;
end;

function F0349Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 147));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 4,18), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 4,19), V1);
      ProcessForm0349Math(doc, cmd, MCPX(CX,4,19));
    end;
  result := 0;
end;

function F0349Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx, 147));			{bsmt sqft}
  S2 := '';
  if CellIsChecked(doc, mcx(cx, 145)) then    {bsmt descript}
    S2 := 'Full'
  else if CellIsChecked(doc, mcx(cx,146)) then
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
      cmd := SetCellString(doc, MCPX(CX,3,48), S3); //transfer to grid
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,48));
    end;
  result := 0;
end;

function F0349NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 143)) or CellIsChecked(doc, mcx(cx,144)) then
    begin
      SetCellChkMark(doc, Mcx(cx,145), False);
      SetCellChkMark(doc, Mcx(cx,146), False);
      SetCellString(doc, Mcx(cx,147), '');
      SetCellString(doc, Mcx(cx,148), '');
    end;
  result := 0;
end;

function F0349NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 198)) then
    begin
      SetCellChkMark(doc, Mcx(cx,199), False);
      SetCellChkMark(doc, Mcx(cx,202), False);
      SetCellChkMark(doc, Mcx(cx,204), False);
      SetCellString(doc, MCX(CX, 200), '');
      SetCellString(doc, MCX(CX, 203), '');
      SetCellString(doc, MCX(CX, 205), '');
      SetCellChkMark(doc, Mcx(cx,206), False);
      SetCellChkMark(doc, Mcx(cx,207), False);
      SetCellChkMark(doc, Mcx(cx,208), False);
      SetCellString(doc, MCPX(CX,3,53), ''); //transfer to grid
    end;
  result := 0;
end;

function F0349CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 206)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,207)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,208)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,203)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,203));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,205)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,205));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,198)) Then
    SetCellChkMark(doc, MCX(cx,198), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,53), S3); //transfer to grid
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,53));
    end;
  result := 0;
end;

function F0349NoAttic(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, CX) then
    begin
      SetCellChkMark(doc, mcx(CX, 171), False);    //stairs
      SetCellChkMark(doc, mcx(CX, 168), False);    //drop stair
      SetCellChkMark(doc, mcx(CX, 172), False);    //scuttle
      SetCellChkMark(doc, mcx(CX, 169), False);    //floor
      SetCellChkMark(doc, mcx(CX, 173), False);    //heated
      SetCellChkMark(doc, mcx(CX, 170), False);    //finished
    end;
  result := 0;
end;

function F0349HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 174)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,175)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,176)) then     //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,178));   //other source


  S2 := '';
  if CellIsChecked(doc, mcx(cx, 180)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,181)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,183));   //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,51), S1); //transfer to grid
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,51));
    end;
  result := 0;
end;

function F0349Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 185)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,184), True);              //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 55), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 3,56), S1);   //result
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,56));
    end

  else if not CellIsChecked(doc, mcx(cx,184)) then
    begin
      if GetCellValue(doc, mcx(cx, 185)) > 0 then
        SetCellString(doc, MCX(CX,185), '');             //firepace count
      SetCellString(doc, MCPX(CX,3,55), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,3,56), '');   //result
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,56));
    end;
  result := 0;
end;

function F0349Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if CellIsChecked(doc, mcx(cx,188)) then
    begin
      S1 := GetCellString(doc, mcx(cx,189));
      S1 := 'Pool/' + S1;
      SetCellString(doc, MCPX(CX, 3, 57), 'Pool');      //heading
      cmd := SetCellString(doc, MCPX(CX, 3,58), S1);   //result
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,58));
    end

  else if not CellIsChecked(doc, mcx(cx,188)) and CellHasWord(doc, MCPX(CX,3,57), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,189), '');              //pool desc
      SetCellString(doc, MCPX(CX,3,57), '');            //heading
      cmd := SetCellString(doc, MCPX(CX,3,58), '');     //result
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,58));
    end;

  result := 0;
end;

function F0349PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 186)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 196)) then
    if length(S1) > 0 then
      S1 := Concat(S1, ',', 'Porch')
    else
      S1 := 'Porch';

  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,54), S1); //transfer to grid
      ProcessForm0349Math(doc, cmd, MCPX(CX,3,54));
    end;
  result := 0;
end;

function F0349CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0349CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0349CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0349CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0349C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,61));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 64,138,139,136,137,4,5,
    [76,78,80,82,84,86,88,90,92,94,96,98,99,103,107,111,115,117,119,121,123,125,127,129,131,133,135],length(addr) > 0);
end;

function F0349C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,143));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 146,220,221,218,219,6,7,
    [158,160,162,164,166,168,170,172,174,176,178,180,181,185,189,193,197,199,201,203,205,207,209,211,213,215,217],length(addr) > 0);
end;

function F0349C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,225));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 228,302,303,300,301,8,9,
    [240,242,244,246,248,250,252,254,256,258,260,262,263,267,271,275,279,281,283,285,287,289,291,293,295,297,299],length(addr) > 0);
end;



{ Non-Lender Small Income 1025 }

function F0737AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  cmd: Integer;
begin
  S1 := GetCellString(doc, MCPX(CX,1,139));   //eff age
  S2 := GetCellString(doc, MCPX(CX,4,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      cmd := SetCellValue(doc, MCPX(CX,4,28), VR);
      ProcessForm0737Math(doc, cmd, MCPX(CX,4,28));
    end;
  result := 0;
end;

function F0737Bsmt2Cost(doc: TContainer; CX: CellUID): Integer;		{transfer only if a number}
var
  V1: Double;
  cmd: Integer;
begin
  V1 := GetCellValue(doc, mcx(cx, 144));
  if (V1 <> 0) then
    begin
      SetCellString(doc, MCPX(CX, 4,18), 'Bsmt.');			{trans Base. to cost appraoach}
      Cmd := SetCellValue(doc, MCPX(CX, 4,19), V1);
      ProcessForm0737Math(doc, cmd, MCPX(CX,4,19));
    end;
  result := 0;
end;

function F0737Bsmt2Grid(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2, S3: string;
  cmd: Integer;
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
      cmd := SetCellString(doc, MCPX(CX,3,48), S3); //transfer to grid
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,48));
    end;
  result := 0;
end;

function F0737NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 140)) or CellIsChecked(doc, mcx(cx,141)) then
    begin
      SetCellChkMark(doc, Mcx(cx,142), False);
      SetCellChkMark(doc, Mcx(cx,143), False);
      SetCellString(doc, Mcx(cx,144), '');
      SetCellString(doc, Mcx(cx,145), '');
    end;
  result := 0;
end;

function F0737NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 195)) then
    begin
      SetCellChkMark(doc, Mcx(cx,196), False);
      SetCellChkMark(doc, Mcx(cx,199), False);
      SetCellChkMark(doc, Mcx(cx,201), False);
      SetCellString(doc, MCX(CX, 197), '');
      SetCellString(doc, MCX(CX, 200), '');
      SetCellString(doc, MCX(CX, 202), '');
      SetCellChkMark(doc, Mcx(cx,203), False);
      SetCellChkMark(doc, Mcx(cx,204), False);
      SetCellChkMark(doc, Mcx(cx,205), False);
      SetCellString(doc, MCPX(CX,3,53), ''); //transfer to grid
    end;
  result := 0;
end;

function F0737CarStorage(doc: TContainer; CX: CellUID): Integer;
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
      cmd := SetCellString(doc, MCPX(CX,3,53), S3); //transfer to grid
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,53));
    end;
  result := 0;
end;

function F0737NoAttic(doc: TContainer; CX: CellUID): Integer;
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

function F0737HeatingCooling(doc: TContainer; CX: CellUID): Integer;
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
      cmd := SetCellString(doc, MCPX(CX,3,51), S1); //transfer to grid
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,51));
    end;
  result := 0;
end;

function F0737Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 182)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,181), True);              //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 55), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 3,56), S1);   //result
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,56));
    end

  else if not CellIsChecked(doc, mcx(cx,181)) then
    begin
      if GetCellValue(doc, mcx(cx, 182)) > 0 then
        SetCellString(doc, MCX(CX,182), '');             //firepace count
      SetCellString(doc, MCPX(CX,3,55), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,3,56), '');   //result
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,56));
    end;
  result := 0;
end;

function F0737Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if CellIsChecked(doc, mcx(cx,185)) then
    begin
      S1 := GetCellString(doc, mcx(cx,186));
      S1 := 'Pool/' + S1;
      SetCellString(doc, MCPX(CX, 3, 57), 'Pool');      //heading
      cmd := SetCellString(doc, MCPX(CX, 3,58), S1);   //result
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,58));
    end

  else if not CellIsChecked(doc, mcx(cx,185)) and CellHasWord(doc, MCPX(CX,3,57), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,186), '');              //pool desc
      SetCellString(doc, MCPX(CX,3,57), '');            //heading
      cmd := SetCellString(doc, MCPX(CX,3,58), '');     //result
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,58));
    end;

  result := 0;
end;

function F0737PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 183)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 193)) then
    if length(S1) > 0 then
      S1 := Concat(S1, ',', 'Porch')
    else
      S1 := 'Porch';

  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,54), S1); //transfer to grid
      ProcessForm0737Math(doc, cmd, MCPX(CX,3,54));
    end;
  result := 0;
end;

function F0737CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0737CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0737CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0737CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0737C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,61));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 64,138,139,136,137,4,5,
    [76,78,80,82,84,86,88,90,92,94,96,98,99,103,107,111,115,117,119,121,123,125,127,129,131,133,135],length(addr) > 0);
end;

function F0737C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,143));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 146,220,221,218,219,6,7,
    [158,160,162,164,166,168,170,172,174,176,178,180,181,185,189,193,197,199,201,203,205,207,209,211,213,215,217],length(addr) > 0);
end;

function F0737C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,225));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 228,302,303,300,301,8,9,
    [240,242,244,246,248,250,252,254,256,258,260,262,263,267,271,275,279,281,283,285,287,289,291,293,295,297,299], length(addr) > 0);
end;


{ CoOp 2090 }

function F0351NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 53)) then
    begin
      SetCellChkMark(doc, Mcx(cx,54), False);
      SetCellChkMark(doc, Mcx(cx,56), False);
      SetCellString(doc, MCX(CX, 55), '');
      SetCellString(doc, MCX(CX, 57), '');
      SetCellChkMark(doc, Mcx(cx,58), False);
      SetCellChkMark(doc, Mcx(cx,59), False);
      SetCellString(doc, MCX(CX, 60), '');
      SetCellString(doc, MCPX(CX,3,46), ''); //transfer to grid
    end;
  result := 0;
end;

function F0351CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 58)) then
    S1 := 'Assigned'
  else if CellIsChecked(doc, mcx(cx,59)) then
    S1 := 'Owned';

  if GetCellValue(doc, mcx(cx,55)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,55));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,57)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,57));
      S3 := S2 + ' Car (Open) ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,53)) Then
    SetCellChkMark(doc, MCX(cx,53), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      Cmd := SetCellString(doc, MCPX(CX,3,46), S3); //transfer to grid
      ProcessForm0351Math(doc, cmd, MCPX(CX,3,46));
    end;
  result := 0;
end;

function F0351HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,26));          //heating type

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 28)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,29)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,31));        //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,44), S1); //transfer to grid
      ProcessForm0351Math(doc, cmd, MCPX(CX,3,44));
    end;
  result := 0;
end;

function F0351Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1: Integer;
  cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 38)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,37), True);               //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 48), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 3,49), S1);   //result
      ProcessForm0351Math(doc, cmd, MCPX(CX,3,49));
    end

  else if not CellIsChecked(doc, mcx(cx,37)) then
    begin
      if GetCellValue(doc, mcx(cx, 38)) > 0 then
        SetCellString(doc, MCX(CX,38), '');                //firepace count
      SetCellString(doc, MCPX(CX, 3, 48), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 3,49), '');   //result
      ProcessForm0351Math(doc, cmd, MCPX(CX,3,49));
    end;
  result := 0;
end;

function F0351PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 41)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 43)) then
    if length(S1) > 0 then
      S1 := Concat(S1, ',', 'Porch/Bal')
    else
      S1 := 'Porch/Bal';

      cmd := SetCellString(doc, MCPX(CX,3,47), S1); //transfer to grid
      ProcessForm0351Math(doc, cmd, MCPX(CX,3,47));
  result := 0;
end;

function F0351C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,54));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 58,128,129,126,127,2,3,
    [64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,99,103,105,107,109,111,113,115,117,119,121,123,125],length(addr) > 0);
end;

function F0351C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,130));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 134,204,205,202,203,4,5,
    [140,142,144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,175,179,181,183,185,187,189,191,193,195,197,199,201],length(addr) > 0);
end;

function F0351C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx, 206));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 210,280,281,278,279,6,7,
    [216,218,220,222,224,226,228,230,232,234,236,238,240,242,244,246,248,250,251,255,257,259,261,263,265,267,269,271,273,275,277],length(addr) > 0);
end;


{ 2095 }

function F0353TransUnits(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,132));
  if length(S1) > 0 then  S1 := '/'+ S1;

  if length(S1)> 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,23), S1); 	{transfer to grid}
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,23));
    end;
  result := 0;
end;

function F0353Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 43)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,42), True);               //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 48), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 3,49), S1);   //result
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,49));
    end

  else if not CellIsChecked(doc, mcx(cx,42)) then
    begin
      if GetCellValue(doc, mcx(cx, 43)) > 0 then
        SetCellString(doc, MCX(CX,43), '');                //firepace count
      SetCellString(doc, MCPX(CX, 3, 48), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 3,49), '');   //result
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,49));
    end;
  result := 0;
end;

function F0353PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 46)) then
    S1 := 'Patio/Deck/Balcony';
  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,47), S1); //transfer to grid
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,47));
    end;
  result := 0;
end;

function F0353HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,36));          //heating type

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 38)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,39)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,41));        //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,44), S1); //transfer to grid
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,44));
    end;
  result := 0;
end;

function F0353NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 55)) then
    begin
      SetCellChkMark(doc, Mcx(cx,56), False);
      SetCellChkMark(doc, Mcx(cx,57), False);
      SetCellChkMark(doc, Mcx(cx,58), False);
      SetCellChkMark(doc, Mcx(cx,60), False);
      SetCellString(doc, MCX(CX, 59), '');
      SetCellString(doc, MCX(CX, 61), '');
      SetCellString(doc, MCX(CX, 62), '');
      SetCellString(doc, MCPX(CX,3,46), ''); //transfer to grid
    end;
  result := 0;
end;

function F0353CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 56)) then
    S1 := 'Assigned'
  else if CellIsChecked(doc, mcx(cx,57)) then
    S1 := 'Owned';

  if GetCellValue(doc, mcx(cx,59)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,59));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,61)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,61));
      S3 := S2 + ' Open ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,55)) Then
    SetCellChkMark(doc, MCX(cx,53), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,46), S3); //transfer to grid
      ProcessForm0353Math(doc, cmd, MCPX(CX,3,46));
    end;
  result := 0;
end;

function F0353C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,54));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 58,128,129,126,127,2,3,
    [64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,99,103,105,107,109,111,113,115,117,119,121,123,125],length(addr) > 0);
end;

function F0353C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,130));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 134,204,205,202,203,4,5,
    [140,142,144,146,148,150,152,154,156,158,160,162,164,166,168,170,172,174,175,179,181,183,185,187,189,191,193,195,197,199,201],length(addr) > 0);
end;

function F0353C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,206));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 210,280,281,278,279,6,7,
    [216,218,220,222,224,226,228,230,232,234,236,238,240,242,244,246,248,250,251,255,257,259,261,263,265,267,269,271,273,275,277],length(addr) > 0);
end;


{ 2055 }

function F0355AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  cmd: Integer;
begin
  S1 := GetCellString(doc, MCPX(CX,1,147));   //eff age
  S2 := GetCellString(doc, MCPX(CX,3,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      cmd := SetCellValue(doc, MCPX(CX,3,28), VR);
      ProcessForm0355Math(doc, cmd, MCPX(CX,3,28));
    end;
  result := 0;
end;

function F0355NoBasement(doc: TContainer; CX: CellUID): Integer;
var
  UADCell: TBaseCell;
  GSEData: TStringList;
begin
  if CellIsChecked(doc, mcx(cx, 148)) or CellIsChecked(doc, mcx(cx,149)) then
    begin
      SetCellChkMark(doc, Mcx(cx,150), False);
      SetCellChkMark(doc, Mcx(cx,151), False);
      SetCellChkMark(doc, Mcx(cx,152), False);
      SetCellChkMark(doc, Mcx(cx,153), False);
      if not doc.UADEnabled then
        SetCellString(doc, MCPX(CX,2,32), 'None')
      else
        begin
          //set first basement cell
          UADCell := doc.GetCell(MCPX(CX,2,32));
          if assigned(UADCell) then
            begin
              UADCell.SetText('0sf');
              GSEData := TStringList.Create;
              try
                GSEData.Values['4426'] := '0';
                GSEData.Values['200'] := '0';
                GSEData.Values['208'] := 'N';
                UADCell.GSEData := GSEData.CommaText;
                UADCell.HasValidationError := False;
              finally
                GSEData.Free;
              end;
            end;

          //second basement cell
          UADCell := doc.GetCell(MCPX(CX,2,33));
          if assigned(UADCell) then
            begin
              UADCell.SetText('');
              UADCell.HasValidationError := False;
            end;
        end;
    end;
  result := 0;
end;

function F0355HasBasement(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 150)) then    {bsmt descript}
    S1 := 'Full'
  else if CellIsChecked(doc, mcx(cx,152)) then
    S1 := 'Partial';

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 151)) or CellIsChecked(doc, mcx(cx,153)) then
    S2 := 'Finished';

  if (length(S1)>0) and (length(S2)>0) then  //have two put add a '/'
    S1 := S1 + '/' + S2;

  if length(S1)=0 then    //if nothing in first, make it second
    S1 := S2;

  if length(S1)>0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,32), S1); //transfer to grid
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,32));
    end;
  result := 0;
end;

function F0355HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 158)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,159)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,160)) then     //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,162));   //other source


  S2 := '';
  if CellIsChecked(doc, mcx(cx, 164)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,165)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,167));   //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,2,35), S1); //transfer to grid
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,35));
    end;
  result := 0;
end;

function F0355Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 167 then
      begin
        if (not CellIsChecked(doc, mcx(cx,168))) then
          SetCellValue(doc, MCX(CX,169), 0);
      end
    else if doc.docActiveCell.UID.Num = 168 then
      if GetCellValue(doc, MCX(CX,169)) = 0 then
        SetCellChkMark(doc, mcx(cx,168), False)
      else if GetCellString(doc, MCX(CX,169)) <> '' then
        SetCellChkMark(doc, mcx(cx,168), True);

  V1 := Trunc(GetCellValue(doc, mcx(cx, 169)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 2,40), S1);       //result
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,40));
    end
  else if not CellIsChecked(doc, mcx(cx,168)) then
    if doc.UADEnabled then
      begin
        SetCellValue(doc, MCX(CX,169), 0);              //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces'); //heading
        Cmd := SetCellString(doc, MCPX(CX, 2,40), '0');    //cell result
        ProcessForm0355Math(doc, cmd, MCPX(CX,2,40));
      end
    else
      begin
        if GetCellValue(doc, mcx(cx, 169)) > 0 then
          SetCellString(doc, MCX(CX,169), '');               //firepace count
        SetCellString(doc, MCPX(CX, 2, 39), '');             //heading
        cmd := SetCellString(doc, MCPX(CX, 2,40), '');   //result
        ProcessForm0355Math(doc, cmd, MCPX(CX,2,40));
      end;
  result := 0;
end;
(*
function F0355PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
  aPorch, aPatio: String;
begin
  S1 := '';
//  if doc.UADEnabled then
    case doc.docActiveCell.UID.Num of
      172: if CellIsChecked(doc, mcx(cx, 172)) then
              S1 := 'Patio/Deck';
      174: if GetCellValue(doc, mcx(cx, 174)) > 0 then
             begin
               if length(S1) > 0 then
                 S1 := concat(S1, ',', 'Porch')
               else
                 S1 := 'Porch';
             end;
    end;
      cmd := SetCellString(doc, MCPX(CX,2,38), S1); //transfer to grid
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,38));
  result := 0;
end;
*)

function F0355PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if doc.UADEnabled then
    case doc.docActiveCell.UID.Num of
      172:
        if (not CellIsChecked(doc, mcx(cx,172))) then
          SetCellString(doc, MCX(CX,173), 'None');
      173:
        if Uppercase(GetCellString(doc, MCX(CX,173))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,172), False);
            SetCellString(doc, MCX(CX,173), 'None');
          end
        else if GetCellString(doc, MCX(CX,173)) <> '' then
          SetCellChkMark(doc, mcx(cx,172), True);
      174:
        if (not CellIsChecked(doc, mcx(cx,174))) then
          SetCellString(doc, MCX(CX,175), 'None');
      175:
        if Uppercase(GetCellString(doc, MCX(CX,175))) = 'NONE' then
          begin
            SetCellChkMark(doc, mcx(cx,174), False);
            SetCellString(doc, MCX(CX,175), 'None');
          end
        else if GetCellString(doc, MCX(CX,175)) <> '' then
          SetCellChkMark(doc, mcx(cx,174), True);
    end;
//Ticket #1129:  if porch none is checked, set porch to EMPTY, abbreviate porch as Pch, patio as Pat  Deck as Dck
  S1:= '';
  if CellIsChecked(doc, mcx(CX, 172)) then
    begin
      S1 := 'Patio/Deck';
    end;

  //set the porch
  if CellIsChecked(doc, mcx(CX, 174)) then
    begin
      if length(S1) > 0 then
        S1 := conCat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

     cmd := SetCellString(doc, MCPX(CX,2,38), S1); //transfer to grid
     ProcessForm0355Math(doc, cmd, MCPX(CX,2,38));
  result := 0;
end;

function F0355Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 175 then
      begin
        if (not CellIsChecked(doc, mcx(cx,176))) then
          SetCellString(doc, MCX(CX,177), 'None');
      end
    else if doc.docActiveCell.UID.Num = 176 then
      if Uppercase(GetCellString(doc, MCX(CX,177))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,176), False);
          SetCellString(doc, MCX(CX,177), 'None');
        end
      else if GetCellString(doc, MCX(CX,177)) <> '' then
        SetCellChkMark(doc, mcx(cx,176), True);              

  if CellIsChecked(doc, mcx(cx,176)) then
    begin
      S1 := GetCellString(doc, mcx(cx,177));
      if not doc.UADEnabled then
        S1 := 'Pool/' + S1
      else
        if Length(S1) = 0 then
          S1 := 'None';
      SetCellString(doc, MCPX(CX, 2,41), 'Pool');        //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), S1);      //result
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,42));
    end
  else if not CellIsChecked(doc, mcx(cx,176)) then
    if doc.UADEnabled then
      begin
        SetCellString(doc, MCX(CX,177), 'None');            //pool desc
        SetCellString(doc, MCPX(CX, 2,41), 'Pool');         //heading
        cmd := SetCellString(doc, MCPX(CX,2,42), 'None');   //cell result
        ProcessForm0355Math(doc, cmd, MCPX(CX,2,42));
      end
    else if CellHasWord(doc, MCPX(CX,2,41), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,177), '');                //pool desc
      SetCellString(doc, MCPX(CX, 2,41), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), '');      //result
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,42));
    end;
  result := 0;
end;

function F0355Woodstove(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 169 then
      begin
        if (not CellIsChecked(doc, mcx(cx,170))) then
          SetCellValue(doc, MCX(CX,171), 0);               
      end
    else if doc.docActiveCell.UID.Num = 170 then
      if GetCellValue(doc, MCX(CX,171)) = 0 then
        SetCellChkMark(doc, mcx(cx,170), False)
      else if GetCellString(doc, MCX(CX,171)) <> '' then
        SetCellChkMark(doc, mcx(cx,170), True);              
  result := 0;
end;

function F0355Fence(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 177 then
      begin
        if (not CellIsChecked(doc, mcx(cx,178))) then
          SetCellString(doc, MCX(CX,179), 'None');             
      end
    else if doc.docActiveCell.UID.Num = 178 then
      if Uppercase(GetCellString(doc, MCX(CX,179))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,178), False);
          SetCellString(doc, MCX(CX,179), 'None');             
        end
      else if GetCellString(doc, MCX(CX,179)) <> '' then
        SetCellChkMark(doc, mcx(cx,178), True);              
  result := 0;
end;

function F0355OtherAmenity(doc: TContainer; CX: CellUID): Integer;
begin
  if doc.UADEnabled then
    if doc.docActiveCell.UID.Num = 179 then
      begin
        if (not CellIsChecked(doc, mcx(cx,180))) then
          SetCellString(doc, MCX(CX,181), 'None');             
      end
    else if doc.docActiveCell.UID.Num = 180 then
      if Uppercase(GetCellString(doc, MCX(CX,181))) = 'NONE' then
        begin
          SetCellChkMark(doc, mcx(cx,180), False);
          SetCellString(doc, MCX(CX,181), 'None');             
        end
      else if GetCellString(doc, MCX(CX,181)) <> '' then
        SetCellChkMark(doc, mcx(cx,180), True);              
  result := 0;
end;

function F0355NoCarGarage(doc: TContainer; CX: CellUID): Integer;
var
  ClrStr: String;
begin
  if CellIsChecked(doc, mcx(CX, 182)) then
    begin
      if doc.UADEnabled then
        ClrStr := '0'
      else
        ClrStr := '';
      SetCellChkMark(doc, Mcx(cx,183), False);
      SetCellChkMark(doc, Mcx(cx,186), False);
      SetCellChkMark(doc, Mcx(cx,188), False);
      SetCellString(doc, MCX(CX, 184), ClrStr);
      SetCellString(doc, MCX(CX, 185), '');
      SetCellString(doc, MCX(CX, 187), ClrStr);
      SetCellString(doc, MCX(CX, 189), ClrStr);
      SetCellChkMark(doc, Mcx(cx,190), False);
      SetCellChkMark(doc, Mcx(cx,191), False);
      SetCellChkMark(doc, Mcx(cx,192), False);
      SetCellString(doc, MCPX(CX,2,37), ''); //transfer to grid
    end;
  result := 0;
end;

function F0355CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 190)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,191)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,192)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,187)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,187));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,189)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,189));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,182)) Then
    SetCellChkMark(doc, MCX(cx,182), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm0355Math(doc, cmd, MCPX(CX,2,37));
    end;
  result := 0;
end;

function F0355UADCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
  AttChkd, DetChkd, BinChkd, GarChkd, CpChkd, DwChkd, GridMatch: Boolean;
  AttGridQty, DetGridQty, BinGridQty, ChkdQty, GridQty, GarQty: Integer;
  GarQtyStr, GridQtyStr, AttGridQtyStr, DetGridQtyStr, BinGridQtyStr: String;
  UnitQty, RemainQty: Integer;
begin
  case doc.docActiveCell.UID.Num of
    182:
      if (not CellIsChecked(doc, mcx(cx,183))) then
        SetCellValue(doc, MCX(CX,184), 0);
    183:
      if GetCellValue(doc, MCX(CX,184)) = 0 then
        SetCellChkMark(doc, mcx(cx,183), False)
      else if GetCellString(doc, MCX(CX,184)) <> '' then
        SetCellChkMark(doc, mcx(cx,183), True);
    185:
      if (not CellIsChecked(doc, mcx(cx,186))) then
        SetCellValue(doc, MCX(CX,187), 0);
    186:
      if GetCellValue(doc, MCX(CX,187)) = 0 then
        SetCellChkMark(doc, mcx(cx,186), False)
      else if GetCellString(doc, MCX(CX,187)) <> '' then
        SetCellChkMark(doc, mcx(cx,186), True);
    187:
      if (not CellIsChecked(doc, mcx(cx,188))) then
        SetCellValue(doc, MCX(CX,189), 0);
    188:
      if GetCellValue(doc, MCX(CX,189)) = 0 then
        SetCellChkMark(doc, mcx(cx,188), False)
      else if GetCellString(doc, MCX(CX,189)) <> '' then
        SetCellChkMark(doc, mcx(cx,188), True);
  end;

  S1 := '';
  S3 := '';
  ChkdQty := 0;
  AttChkd := False;
  GarQty := Round(GetCellValue(doc, mcx(cx,187)));
  GarQtyStr := IntToStr(GarQty);
  if CellIsChecked(doc, mcx(cx, 190)) then
    begin
      ChkdQty := Succ(ChkdQty);
      AttChkd := True;
    end;
  DetChkd := False;
  if CellIsChecked(doc, mcx(cx, 191)) then
    begin
      ChkdQty := Succ(ChkdQty);
      DetChkd := True;
    end;
  BinChkd := False;
  if CellIsChecked(doc, mcx(cx, 192)) then
    begin
      ChkdQty := Succ(ChkdQty);
      BinChkd := True;
    end;
  if GarQty > 0 then
    begin
      SetCellChkMark(doc, MCX(cx,186), True);    //make sure the Garage checkbox is checked
      if ChkdQty <= 1 then
        begin
          if AttChkd then
            begin
              S1 := GAtt;
              ClearCheckMark(doc, MCX(cx,191));    //make sure the Detached checkbox is unchecked
              ClearCheckMark(doc, MCX(cx,192));    //make sure the Built-In checkbox is unchecked
            end
          else if DetChkd then
            begin
              S1 := GDet;
              ClearCheckMark(doc, MCX(cx,192));    //make sure the Built-In checkbox is unchecked
            end
          else if BinChkd then
            S1 := GBin
          else
            begin
              S1 := GAtt;
              SetCellChkMark(doc, MCX(cx,190), True);     //make sure the Attached checkbox is checked
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
                  ClearCheckMark(doc, MCX(cx,191));    //make sure the Detached checkbox is unchecked
                  ClearCheckMark(doc, MCX(cx,192));    //make sure the Built-In checkbox is unchecked
                end
              else if DetChkd then
                RemainQty := Pred(RemainQty);
              if RemainQty = 0 then
                ClearCheckMark(doc, MCX(cx,192));    //make sure the Built-In checkbox is unchecked
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
  if CellIsChecked(doc, mcx(cx,186)) then
    begin
      GarChkd := True;
      if length(S3) = 0 then
        S3 := 'ga';
    end    
  else
    GarChkd := False;
  if CellIsChecked(doc, mcx(cx,188)) then
    begin
      CpChkd := True;
      if (GetCellValue(doc, mcx(cx,189)) > 0) then
        S2 := GetCellString(doc, mcx(cx,189));
      S3 := S3 + S2 + 'cp';
    end
  else
    CpChkd := False;
  if CellIsChecked(doc, mcx(cx,183)) then
    begin
      DwChkd := True;
      if (GetCellValue(doc, mcx(cx,184)) > 0) then
        S2 := GetCellString(doc, mcx(cx,184));
      S3 := S3 + S2 + 'dw';
    end
  else
    DwChkd := False;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,182)) Then
    SetCellChkMark(doc, MCX(cx,182), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm0355Math(doc, Cmd, MCPX(CX,2,37));
    end
  else
    begin
      if (not DwChkd) and (not GarChkd) and (not CpChkd) then
        begin
          SetCellChkMark(doc, MCX(cx,182), True);       //make sure we check None for cars
          F0355NoCarGarage(doc, cx);
          cmd := SetCellString(doc, MCPX(CX,2,37), ''); //transfer to grid
          ProcessForm0355Math(doc, Cmd, MCPX(CX,2,37));
        end;
    end;
  result := 0;
end;

function F0355UADGridCarStorage(doc: TContainer; CX: CellUID): Integer;
var
  TmpCell: TBaseCell;
  S1, S3: string;
  cmd, PosIdx, CarNum, TotCarNum, EndIdx: Integer;
begin
  TotCarNum := 0;
  S1 := Trim(GetCellString(doc, MCPX(cx,2,37)));   //Grid text
  if S1 <> 'None' then
    begin
      TmpCell := doc.GetCell(MCPX(cx,1,182));
      TmpCell.DoSetText(' ');

      TmpCell := doc.GetCell(MCPX(cx,1,190));
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

      TmpCell := doc.GetCell(MCPX(cx,1,191));
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

      TmpCell := doc.GetCell(MCPX(cx,1,192));
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

      TmpCell := doc.GetCell(MCPX(cx,1,186));
      if TotCarNum > 0 then
       TmpCell.DoSetText('X')
      else
       TmpCell.DoSetText(' ');
      SetCellString(doc, MCPX(CX,1,187), IntToStr(TotCarNum));         //Garage # of Cars

      TmpCell := doc.GetCell(MCPX(cx,1,188));
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
      SetCellString(doc, MCPX(CX,1,189), IntToStr(CarNum));             //Carport # of Cars

      TmpCell := doc.GetCell(MCPX(cx,1,183));
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
      SetCellString(doc, MCPX(CX,1,184), IntToStr(CarNum));             //Driveway # of Cars

    end
  else
    begin
      SetCellChkMark(doc, MCPX(CX,1,183), False);      //Driveway
      SetCellString(doc, MCPX(CX,1,184), '0');         //Driveway # of Cars
      SetCellString(doc, MCPX(CX,1,185), '');          //Parking Surface
      SetCellChkMark(doc, MCPX(CX,1,186), False);      //Garage
      SetCellString(doc, MCPX(CX,1,187), '0');         //Garage # of Cars
      SetCellChkMark(doc, MCPX(CX,1,188), False);      //Carport
      SetCellString(doc, MCPX(CX,1,189), '0');         //Carport # of Cars
      SetCellChkMark(doc, MCPX(CX,1,190), False);      //Attached
      SetCellChkMark(doc, MCPX(CX,1,191), False);      //Detached
      SetCellChkMark(doc, MCPX(CX,1,192), False);      //Built-in
      SetCellChkMark(doc, MCPX(CX,1,182), True);       //None
    end;

  result := 0;
end;

function F0355UADDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,138));   //Stories
  if CellIsChecked(doc, mcx(cx,139)) then
    begin
      S1 := ResidAttachType[0] + S1;
      ClearCheckMark(doc, MCX(cx,140));    //make sure the Attached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,141));    //make sure the Semi-Detached checkbox is unchecked
    end
  else if CellIsChecked(doc, mcx(cx,140)) then
    begin
      S1 := ResidAttachType[1] + S1;
      ClearCheckMark(doc, MCX(cx,139));    //make sure the Detached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,142));    //make sure the Semi-Detached checkbox is unchecked
    end
  else if CellIsChecked(doc, mcx(cx,141)) then
    begin
      S1 := ResidAttachType[2] + S1;
      ClearCheckMark(doc, MCX(cx,139));    //make sure the Detached checkbox is unchecked
      ClearCheckMark(doc, MCX(cx,140));    //make sure the Attached checkbox is unchecked
    end;
  if Length(S1) > 0 then
    S1 := S1 + ';' + GetCellString(doc, mcx(cx,145));   //Design (Style) description
  if length(S1) > 0 then
    cmd := SetCellString(doc, MCPX(CX,2,24), S1); //transfer to grid
  result := 0;
end;

function F0355UADGridDesignStyle(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd, PosIdx: Integer;
begin
  S1 := GetCellString(doc, MCX(cx,24));   //Grid text
  PosIdx := Pos(ResidAttachType[0], S1);
  if PosIdx = 1 then
    SetCellChkMark(doc, MCPX(CX,1,139), True)       //Detached type
  else
    begin
      PosIdx := Pos(ResidAttachType[1], S1);
      if PosIdx = 1 then
        SetCellChkMark(doc, MCPX(CX,1,140), True)   //Attached type
      else
        begin
          PosIdx := Pos(ResidAttachType[2], S1);
          if PosIdx = 1 then
            SetCellChkMark(doc, MCPX(CX,1,141), True)   //Semi-Detached type
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
          if GetCellString(doc, MCPX(CX,1,138)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,138), S2); //transfer stories
          S2 := Copy(S1, Succ(PosIdx), Length(S1));
          if GetCellString(doc, MCPX(CX,1,145)) <> S2 then
            cmd := SetCellString(doc, MCPX(CX,1,145), S2); //transfer description
        end
      else // no type so just put everything in the Design (Style) description field
        cmd := SetCellString(doc, MCPX(CX,1,145), S1);
    end;
  result := 0;
end;

function F0355CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0355CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0355CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0355CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0355C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,103,104,101,102,2,3,
    [53,55,57,59,61,63,65,67,69,71,73,74,78,80,82,84,86,88,90,92,94,96,98,100],length(addr) > 0);
end;

function F0355C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 108,163,164,161,162,4,5,
    [113,115,117,119,121,123,125,127,129,131,133,134,138,140,142,144,146,148,150,152,154,156,158,160],length(addr) > 0);
end;

function F0355C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,165));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 168,223,224,221,222,6,7,
    [173,175,177,179,181,183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214,216,218,220],length(addr) > 0);
end;


{ Non-Lender 2055 }

function F0764AgeLifeDepr(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  V1,V2,VR: Double;
  cmd: Integer;
begin
  S1 := GetCellString(doc, MCPX(CX,1,144));   //eff age
  S2 := GetCellString(doc, MCPX(CX,3,13));    //Est Remaining econ life
  V1 := GetAvgValue(S1);
  V2 := GetAvgValue(S2);
  if (V1 >= 0) and (V2 <> 0) then  //>= 0 since we can enter 'New' for age
    begin
      VR := (V1 / (V1 + V2)) * 100.0;
      cmd := SetCellValue(doc, MCPX(CX,3,28), VR);
      ProcessForm0764Math(doc, cmd, MCPX(CX,3,28));
    end;
  result := 0;
end;

function F0764NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  // 022912 JWyatt disable per HJindal so form operates in a similar manner to FNMA1004
  {if CellIsChecked(doc, mcx(cx, 145)) or CellIsChecked(doc, mcx(cx,146)) then
    begin
      SetCellChkMark(doc, Mcx(cx,145), False);
      SetCellChkMark(doc, Mcx(cx,146), False);
      SetCellChkMark(doc, Mcx(cx,147), False);
      SetCellChkMark(doc, Mcx(cx,148), False);
      SetCellString(doc, MCPX(CX,2,32), 'None');
    end;}
  result := 0;
end;

function F0764HasBasement(doc: TContainer; CX: CellUID): Integer;
var
  S1, S2: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 147)) then    {bsmt descript}
    S1 := 'Full'
  else if CellIsChecked(doc, mcx(cx,149)) then
    S1 := 'Partial';

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 148)) or CellIsChecked(doc, mcx(cx,150)) then
    S2 := 'Finished';

  if (length(S1)>0) and (length(S2)>0) then  //have two put add a '/'
    S1 := S1 + '/' + S2;

  if length(S1)=0 then    //if nothing in first, make it second
    S1 := S2;

  if length(S1)>0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,32), S1); //transfer to grid
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,32));
    end;
  result := 0;
end;

function F0764HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2: String;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(cx, 155)) then        //FWA
    S1 := 'FWA'
  else if CellIsChecked(doc, mcx(cx,156)) then    //HWBB
    S1 := 'HWBB'
  else if CellIsChecked(doc, mcx(cx,157)) then     //radiant
    S1 := 'Radiant'
  else
    S1 := GetCellString(doc, mcx(cx,159));   //other source


  S2 := '';
  if CellIsChecked(doc, mcx(cx, 161)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,162)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,164));   //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,2,35), S1); //transfer to grid
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,35));
    end;
  result := 0;
end;

function F0764Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 166)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,165), True);              //set the checkmark
      SetCellString(doc, MCPX(CX, 2, 39), 'Fireplaces');   //heading
      cmd := SetCellString(doc, MCPX(CX, 2,40), S1);   //result
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,40));
    end

  else if not CellIsChecked(doc, mcx(cx,165)) then
    begin
      if GetCellValue(doc, mcx(cx, 166)) > 0 then
        SetCellString(doc, MCX(CX,166), '');               //firepace count
      SetCellString(doc, MCPX(CX, 2, 39), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 2,40), '');   //result
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,40));
    end;
  result := 0;
end;

function F0764PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 169)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 171)) then
    if length(S1) > 0 then
      S1 := Concat(S1, ',', 'Porch')
    else
      S1 := 'Porch';

      cmd := SetCellString(doc, MCPX(CX,2,38), S1); //transfer to grid
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,38));
  result := 0;
end;

function F0764Pools(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  cmd: Integer;
begin
  if CellIsChecked(doc, mcx(cx,173)) then
    begin
      S1 := GetCellString(doc, mcx(cx,174));
      S1 := 'Pool/' + S1;
      SetCellString(doc, MCPX(CX, 2,41), 'Pool');        //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), S1);      //result
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,42));
    end

  else if not CellIsChecked(doc, mcx(cx,173)) and CellHasWord(doc, MCPX(CX,2,41), 'Pool') then
    begin
      SetCellString(doc, MCX(CX,174), '');                //pool desc
      SetCellString(doc, MCPX(CX, 2,41), '');             //heading
      cmd := SetCellString(doc, MCPX(CX, 2,42), '');      //result
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,42));
    end;
  result := 0;
end;

function F0764NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 179)) then
    begin
      SetCellChkMark(doc, Mcx(cx,180), False);
      SetCellChkMark(doc, Mcx(cx,183), False);
      SetCellChkMark(doc, Mcx(cx,185), False);
      SetCellString(doc, MCX(CX, 181), '');
      SetCellString(doc, MCX(CX, 184), '');
      SetCellString(doc, MCX(CX, 186), '');
      SetCellChkMark(doc, Mcx(cx,187), False);
      SetCellChkMark(doc, Mcx(cx,188), False);
      SetCellChkMark(doc, Mcx(cx,189), False);
      SetCellString(doc, MCPX(CX,2,37), ''); //transfer to grid
    end;
  result := 0;
end;

function F0764CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 187)) then
    S1 := 'Att.'
  else if CellIsChecked(doc, mcx(cx,188)) then
    S1 := 'Det.'
  else if CellIsChecked(doc, mcx(cx,189)) then
    S1 := 'Blt-In';

  if GetCellValue(doc, mcx(cx,184)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,184));
      S3 := S2 + ' Car Gar. ' + S1;
    end

  else if GetCellValue(doc, mcx(cx,186)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,186));
      S3 := S2 + ' Car Carport ' + S1;
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,179)) Then
    SetCellChkMark(doc, MCX(cx,179), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,2,37), S3); //transfer to grid
      ProcessForm0764Math(doc, cmd, MCPX(CX,2,37));
    end;
  result := 0;
end;

function F0764CalcDeprLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0764CalcDeprLessPhyNFunct(doc: TContainer; CX: CellUID): Integer;
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
function F0764CalcPctLessPhy(doc: TContainer; CX: CellUID): Integer;
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
function F0764CalcPctLessPhyNFnct(doc: TContainer; CX: CellUID): Integer;
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

function F0764C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,45));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 48,103,104,101,102,2,3,
    [53,55,57,59,61,63,65,67,69,71,73,74,78,80,82,84,86,88,90,92,94,96,98,100],length(addr) > 0);
end;

function F0764C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,105));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 108,163,164,161,162,4,5,
    [113,115,117,119,121,123,125,127,129,131,133,134,138,140,142,144,146,148,150,152,154,156,158,160],length(addr) > 0);
end;

function F0764C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,165));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 168,223,224,221,222,6,7,
    [173,175,177,179,181,183,185,187,189,191,193,194,198,200,202,204,206,208,210,212,214,216,218,220],length(addr) > 0);
end;


{ One Unit Review }

function F0357C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,41));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 44,99,100,97,98,2,3,
    [49,51,53,55,57,59,61,63,65,67,69,70,74,76,78,80,82,84,86,88,90,92,94,96],length(addr) > 0);
end;

function F0357C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,101));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 104,159,160,157,158,4,5,
    [109,111,113,115,117,119,121,123,125,127,129,130,134,136,138,140,142,144,146,148,150,152,154,156],length(addr) > 0);
end;

function F0357C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,161));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 164,219,220,217,218,6,7,
    [169,171,173,175,177,179,181,183,185,187,189,190,194,196,198,200,202,204,206,208,210,212,214,216],length(addr) > 0);
end;


{ 2-4 Unit Review }

function F0360C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,55));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX,58,132,133,130,131,4,5,
    [70,72,74,76,78,80,82,84,86,88,90,92,93,97,101,105,109,111,113,115,117,119,121,123,125,127,129],length(addr) > 0);
end;

function F0360C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,137));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 140,214,215,212,213,6,7,
    [152,154,156,158,160,162,164,166,168,170,172,174,175,179,183,187,191,193,195,197,199,201,203,205,207,209,211],length(addr) > 0);
end;

function F0360C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,219));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 222,296,297,294,295,8,9,
    [234,236,238,240,242,244,246,248,250,252,254,256,257,261,265,269,273,275,277,279,281,283,285,287,289,291,293],length(addr) > 0);
end;



//UARA-2055-Review XComps
function F0363C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,49));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 52,107,108,105,106,1,2,
    [57,59,61,63,65,67,69,71,73,75,77,78,82,84,86,88,90,92,94,96,98,100,102,104], length(addr) > 0);
end;

function F0363C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,110));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 113,168,169,166,167,3,4,
    [118,120,122,124,126,128,130,132,134,136,138,139,143,145,147,149,151,153,155,157,159,161,163,165], length(addr) > 0);
end;

function F0363C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,171));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 174,229,230,227,228,5,6,
    [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226], length(addr) > 0);
end;

//github #196
function F4150C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,49));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 52,107,108,105,106,1,2,
    [57,59,61,63,65,67,69,71,73,75,77,78,82,84,86,88,90,92,94,96,98,100,102,104],length(addr) > 0);
end;

function F4150C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,110));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 113,168,169,166,167,3,4,
    [118,120,122,124,126,128,130,132,134,136,138,139,143,145,147,149,151,153,155,157,159,161,163,165],length(addr) > 0);
end;

function F4150C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,171));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 174,229,230,227,228,5,6,
    [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226],length(addr) > 0);
end;



//URAR-2055-Review XLists
function F3545C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,49));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 52,107,108,105,106,1,2,
    [57,59,61,63,65,67,69,71,73,75,77,78,82,84,86,88,90,92,94,96,98,100,102,104],length(addr) > 0);
end;

function F3545C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,110));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 113,168,169,166,167,3,4,
    [118,120,122,124,126,128,130,132,134,136,138,139,143,145,147,149,151,153,155,157,159,161,163,165],length(addr) > 0);
end;

function F3545C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,171));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 174,229,230,227,228,5,6,
    [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226],length(addr) > 0);
end;

//1025 Small Income XComps
function F0364Process4Cmds(doc: TContainer; CX: CellUID; C1,C2,C3,C4: Integer): Integer;
begin
  if C1 > 0 then ProcessForm0364Math(doc, C1, CX);
  if C2 > 0 then ProcessForm0364Math(doc, C2, CX);
  if C3 > 0 then ProcessForm0364Math(doc, C3, CX);
  if C4 > 0 then ProcessForm0364Math(doc, C4, CX);
  result := 0;
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

function F0364C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,65));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 68,142,143,140,141,3,4,
    [80,82,84,86,88,90,92,94,96,98,100,102,103,107,111,115,119,121,123,125,127,129,131,133,135,137,139],length(addr) > 0);
end;

function F0364C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,148));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 151,225,226,223,224,5,6,
    [163,165,167,169,171,173,175,177,179,181,183,185,186,190,194,198,202,204,206,208,210,212,214,216,218,220,222],length(addr) > 0);
end;

function F0364C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,231));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 234,308,309,306,307,7,8,
    [246,248,250,252,254,256,258,260,262,264,266,268,269,273,277,281,285,287,289,291,293,295,297,299,301,303,305],length(addr) > 0);
end;

//1004C Manufactured Home XTra Comps
function F0365C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,49));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 52,109,110,107,108,1,2,
    [59,61,63,65,67,69,71,73,75,77,79,80,84,86,88,90,92,94,96,98,100,102,104,106],length(addr) > 0);
end;

function F0365C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,112));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 115,172,173,170,171,3,4,
    [122,124,126,128,130,132,134,136,138,140,142,143,147,149,151,153,155,157,159,161,163,165,167,169],length(addr) > 0);
end;

function F0365C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,175));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 178,235,236,233,234,5,6,
    [185,187,189,191,193,195,197,199,201,203,205,206,210,212,214,216,218,220,222,224,226,228,230,232],length(addr) > 0);
end;

//2090 CoOp XComps
function F0366C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,58));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 62,132,133,130,131,1,2,
    [68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,103,107,109,111,113,115,117,119,121,123,125,127,129],length(addr) > 0);
end;

function F0366C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,135));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 139,209,210,207,208,3,4,
    [145,147,149,151,153,155,157,159,161,163,165,167,169,171,173,175,177,179,180,184,186,188,190,192,194,196,198,200,202,204,206],length(addr) > 0);
end;

function F0366C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,212));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 216,286,287,284,285,5,6,
            [222,224,226,228,230,232,234,236,238,240,242,244,246,248,250,252,254,256,257,261,263,265,267,269,271,273,275,277,279,281,283],length(addr) > 0);
end;

//1073 Condo XComps
function F0367C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,54));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 59,120,121,118,119,1,2,
    [64,66,68,70,72,74,76,78,80,82,84,86,88,90,91,95,97,99,101,103,105,107,109,111,113,115,117], length(addr) > 0);
end;

function F0367C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,123));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 128,189,190,187,188,3,4,
    [133,135,137,139,141,143,145,147,149,151,153,155,157,159,160,164,166,168,170,172,174,176,178,180,182,184,186],length(addr) > 0);
end;

function F0367C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,192));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 197,258,259,256,257,5,6,
    [202,204,206,208,210,212,214,216,218,220,222,224,226,228,229,233,235,237,239,241,243,245,247,249,251,253,255],length(addr) > 0);
end;
 {form 869 math is in UMathFNMA unit
function F0869C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,54));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 57,125,126,123,124,1,2,
    [63,65,67,69,71,73,75,77,79,81,83,84,88,92,96,100,102,104,106,108,110,112,114,116,118,120,122],length(addr) > 0);
end;

function F0869C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,128));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 131,199,200,197,198,3,4,
    [137,139,141,143,145,147,149,151,153,155,157,158,162,166,170,174,176,178,180,182,184,186,188,190,192,194,196],length(addr) > 0);
end;

function F0869C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,202));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 205,273,274,271,272,5,6,
    [211,213,215,217,219,221,223,225,227,229,231,232,236,240,244,248,250,252,254,256,258,260,262,264,266,268,270],length(addr) > 0);
end;  }

{  1004 URAR }

function ProcessForm0340Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX, 2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,86));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2,26), ProcessForm0340Math);
        4:  Cmd := F0340AgeLifeDepr(doc, CX);
        5:  Cmd := F0340Bsmt2Cost(doc, CX);            //for cost approach
        6:
          if not doc.UADEnabled then
            Cmd := F0340Bsmt2Grid(doc, CX)  //for grid
          else
            Cmd := F0340UADBsmt2Grid(doc, CX);         //for grid in UAD reports
        8:  Cmd := F0340NoCarGarage(doc, CX);          //clears out cells when no garage
        9:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0340UADCarStorage(doc, CX)            //transfer std garage-carport-driveway to grid
          else
            Cmd := F0340CarStorage(doc, CX);        //transfer UAD garage-carport-driveway to grid
        10: Cmd := F0340NoAttic(doc, mcx(CX, 164));    //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 164), False);    //make sure no Attic is not checked
        12: Cmd := F0340HeatingCooling(doc, CX);      //transfer to grid
        13: Cmd := F0340Fireplaces(doc, cx);          //transfer to grid
        14: Cmd := F0340Pools(doc, CX);               //transfer to grid
        15: Cmd := F0340PatioDeckPorch(doc, CX);      //trasnfer to grid
        16: Cmd := ProcessMultipleCmds(ProcessForm0340Math, doc, CX,[5,6]);
        17: Cmd := LandUseSum(doc, CX, 2, [76,77,78,79,81]);
        18:
          if not doc.UADEnabled then
            Cmd := F0340BsmtFinsihed(doc, CX)        //transfer the finished amt
          else
            Cmd := 0;
        19: Cmd := F0340Woodstove(doc, CX);
        20:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        21:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        22:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        23:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        24:
          Cmd := F0340C1Adjustments(doc, cx);
        25:
          Cmd := F0340C2Adjustments(doc, cx);
        26:
          Cmd := F0340C3Adjustments(doc, cx);
        27:
          cmd := ProcessMultipleCmds(ProcessForm0340Math, doc, CX,[21,24]); //C1 sales price
        28:
          cmd := ProcessMultipleCmds(ProcessForm0340Math, doc, CX,[22,25]); //C2 sales price
        29:
          cmd := ProcessMultipleCmds(ProcessForm0340Math, doc, CX,[23,26]); //C3 sales price
        30:
          cmd := CalcWeightedAvg(doc, [340,363,4218]);   //calc wtAvg of main and xcomps forms

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
          cmd := F0340CalcDeprLessPhy(doc, cx);           //funct depr entered
        38:
          cmd := F0340CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        39:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0340CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0340CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0340Math(doc, 43, CX); //sum the deprs
          end;
        40:
          begin //functional depr entered directly
            F0340CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0340CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0340Math(doc, 43, CX);  //sum the deprs
          end;
        41:
          begin
            F0340CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0340Math(doc, 43, CX);  //sum the deprs
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
            F0340C1Adjustments(doc, cx);
            F0340C2Adjustments(doc, cx);
            F0340C3Adjustments(doc, cx);
            cmd := 0;
          end;
        47: Cmd := F0340Fence(doc, CX);
        48: Cmd := F0340OtherAmenity(doc, CX);

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));  //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));  //trans income
        53:
          begin
           ProcessForm0340Math(doc, 44, CX);
           cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));  //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));  //indicated value
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0340UADDesignStyle(doc, CX)       //transfer UAD design-style to grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0340UADGridDesignStyle(doc, CX)    //transfer UAD design-style from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        92:
          if doc.UADEnabled then
            Cmd := F0340UADGridCarStorage(doc, CX)     //transfer UAD car storage from grid
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
          ProcessForm0340Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0340Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;


{ Non-Lender 1004 }

function ProcessForm0736Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX, 2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,83));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2,26), ProcessForm0736Math);  //github #179: use effdate
        4:  Cmd := F0736AgeLifeDepr(doc, CX);
        5:  Cmd := F0736Bsmt2Cost(doc, CX);            //for cost approach
        6:  Cmd := F0736Bsmt2Grid(doc, CX);            //for grid
        7:  Cmd := F0736NoBasement(doc, CX);           //toggle basement/no basement
        8:  Cmd := F0736NoCarGarage(doc, CX);          //clears out cells when no garage
        9:  Cmd := F0736CarStorage(doc, CX);           //transfer to  grid
        10: Cmd := F0736NoAttic(doc, mcx(CX, 161));    //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 161), False);    //make sure no Attic is not checked
        12: Cmd := F0736HeatingCooling(doc, CX);      //transfer to grid
        13: Cmd := F0736Fireplaces(doc, cx);          //transfer to grid
        14: Cmd := F0736Pools(doc, CX);               //transfer to grid
        15: Cmd := F0736PatioDeckPorch(doc, CX);      //trasnfer to grid
        16: Cmd := ProcessMultipleCmds(ProcessForm0736Math, doc, CX,[5,6]);
        17: Cmd := LandUseSum(doc, CX, 2, [73,74,75,76,78]);

        20:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        21:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        22:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        23:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        24:
          Cmd := F0736C1Adjustments(doc, cx);
        25:
          Cmd := F0736C2Adjustments(doc, cx);
        26:
          Cmd := F0736C3Adjustments(doc, cx);
        27:
          cmd := ProcessMultipleCmds(ProcessForm0736Math, doc, CX,[21,24]); //C1 sales price
        28:
          cmd := ProcessMultipleCmds(ProcessForm0736Math, doc, CX,[22,25]); //C2 sales price
        29:
          cmd := ProcessMultipleCmds(ProcessForm0736Math, doc, CX,[23,26]); //C3 sales price
        30:
          cmd := CalcWeightedAvg(doc, [736,761]);   //calc wtAvg of main and xcomps forms

        31:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        32:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        33:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        34:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        35:
          cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37));  //sum site & improvements
        36:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        37:
          cmd := F0736CalcDeprLessPhy(doc, cx);           //funct depr entered
        38:
          cmd := F0736CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        39:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0736CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0736CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0736Math(doc, 43, CX); //sum the deprs
          end;
        40:
          begin //functional depr entered directly
            F0736CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0736CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0736Math(doc, 43, CX);  //sum the deprs
          end;
        41:
          begin
            F0736CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0736Math(doc, 43, CX);  //sum the deprs
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
            F0736C1Adjustments(doc, cx);
            F0736C2Adjustments(doc, cx);
            F0736C3Adjustments(doc, cx);
            cmd := 0;
          end;

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));  //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));  //trans income
        53:
          begin
           ProcessForm0736Math(doc, 44, CX);
           cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));  //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));  //indicated value
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0736Math(doc, 46, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0736Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;



{  Non-Lender, 1004, 1004C, 2055, 2000  same as URAR Xtra Comps  }

function ProcessForm0363Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 48,109,170);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 48,109,170, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,109,170);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0363Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F0363C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0363C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,83), mcx(cx,53));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm0363Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0363C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0363C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,144), mcx(cx,114));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm0363Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F0363C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0363C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,174), mcx(cx,205), mcx(cx,175));     //price/sqft

        14:
          {cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main and xcomps forms
          cmd := CalcWeightedAvg(doc, [340,363,355]);   //calc wtAvg of main and xcomps forms       }
          //1004(ID340) and 2055(id355) has the same XComps(ID363)
          // NonLender Resedential XComps(ID761, mainFormID 736), NonLender  Extrior only XComps(ID764, main form ID 764)
          //use math for 1004 XComp (ID 363)
          cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765]);
        15:
          begin
            F0363C1Adjustments(doc, cx);
            F0363C2Adjustments(doc, cx);     //sum of adjs
            F0363C3Adjustments(doc, cx);
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
          ProcessForm0363Math(doc, 6, CX);
          ProcessForm0363Math(doc, 9, CX);
          ProcessForm0363Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0363Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

{  Non-Lender, 1004, 1004C, 2055, 2000  same as URAR Xtra Listings  }

function ProcessForm3545Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listing Comps', 48,109,170);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTING COMPS','', 48,109,170, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,109,170, False);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm3545Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F3545C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F3545C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,83), mcx(cx,53));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm3545Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F3545C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F3545C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,144), mcx(cx,114));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm3545Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F3545C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F3545C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,174), mcx(cx,205), mcx(cx,175));     //price/sqft

        14:
          //cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main, xcomps & xlists forms
          cmd := CalcWeightedAvg(doc, [3545]);   //calc wtAvg of lists forms
        15:
          begin
            F3545C1Adjustments(doc, cx);
            F3545C2Adjustments(doc, cx);     //sum of adjs
            F3545C3Adjustments(doc, cx);
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
          ProcessForm3545Math(doc, 6, CX);
          ProcessForm3545Math(doc, 9, CX);
          ProcessForm3545Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm3545Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

(*
###REMOVE THIS CODE - THERE IS NO MATH FOR THIS CERT PAGE
{  1004 URAR Certification  }
function ProcessForm0341Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;
*)

{  1004C Manufactured Home  }

function ProcessForm0342Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,32), mcx(cx,33), mcpx(cx,3,21));
        2:  cmd := SiteDimension(doc, CX, MCX(cx,94));
        3:  cmd := YearToAge2(doc, CX, MCPX(CX,3,26), ProcessForm0342Math); //github #179: use effdate
        //4:  cmd := F0342NoBasement(doc, CX);            //toggle basement/no basement
        5:
          if not doc.UADEnabled then
            cmd := F0342Bsmt2Grid(doc, CX)              //for grid
          else
            cmd := 0;
        6:  cmd := F0342Bsmt2Cost(doc, CX);            //transfer to cost approach
        7:  cmd := F0342AgeLifeDepr(doc, CX);           //calc phy depr.
        8:  cmd := F0342NoAttic(doc, CX);               //uncheck all Attic options
        9:  cmd := SetCellChkMark(doc, mcx(CX, 53), False);    //make sure no Attic is not checked
        10: cmd := F0342HeatingCooling(doc, CX);        //transfer to grid
        11: cmd := F0342Fireplaces(doc, cx);            //transfer to grid
        12: cmd := F0342PatioDeckPorch(doc, CX);        //trasnfer to grid
        13: Cmd := F0342Pools(doc, CX);                 //transfer to grid
        14: Cmd := F0342NoCarGarage(doc, CX);           //clears out cells when no garage
        15: Cmd := F0342CarStorage(doc, CX);            //car storage

        //cost approach area
        16:
          Cmd := MultAB(doc, mcx(cx,175), mcx(cx,176), mcx(cx,177));
        17:
          Cmd := MultAB(doc, mcx(cx,178), mcx(cx,179), mcx(cx,180));
        18:
          Cmd := MultAB(doc, mcx(cx,181), mcx(cx,182), mcx(cx,183));
        19:
          Cmd := MultAB(doc, mcx(cx,184), mcx(cx,185), mcx(cx,186));
        20:
          Cmd := SumFourCellsR(doc, CX, 177,180,183,186, 187);
        21:
          Cmd := MultAB(doc, mcx(cx,144), mcx(cx,145), mcx(cx,146));
        22:
          Cmd := MultAB(doc, mcx(cx,147), mcx(cx,148), mcx(cx,149));
        23:
          Cmd := MultAB(doc, mcx(cx,150), mcx(cx,151), mcx(cx,152));
        24:
          Cmd := MultAB(doc, mcx(cx,153), mcx(cx,154), mcx(cx,155));
        25:
          Cmd := MultAB(doc, mcx(cx,157), mcx(cx,158), mcx(cx,159));
        26:
          Cmd := SumEightCellsR(doc, CX, 146,149,152,155,159,161,163,0, 164);  //sum costs
        27:
          cmd := MultAByOptionalB(doc, mcx(cx,164), mcx(cx,165), mcx(cx,166));    //cost multiplier
        28:
          cmd := F0342ValueAfterDepr(doc, CX);   //indicated value = subtotal value minus depreciation
        29:
          Cmd := MultPercentAB(doc, mcx(cx,167), mcx(cx,166), mcx(cx,168));   //phy deprecaition
        30:
          Cmd := InfoSiteTotalRatio(doc, cx, 173,174,2);   //Info Cell site-value ratio
        31:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));       //subj Price/GLA
        32:
          Cmd := DivideAB(doc, mcx(cx,48), mcx(cx,81), mcx(cx,49));       //C1 Price/GLA
        33:
          Cmd := DivideAB(doc, mcx(cx,110), mcx(cx,143), mcx(cx,111));    //c2 Price/GLA
        34:
          Cmd := DivideAB(doc, mcx(cx,172), mcx(cx,205), mcx(cx,173));    //C3 Price/GLA
        35:
          Cmd := F0342C1Adjustments(doc, CX);
        36:
          Cmd := F0342C2Adjustments(doc, CX);
        37:
          Cmd := F0342C3Adjustments(doc, CX);
        38:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));       //subj Price/GLA
        39:
          Cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[32,35]); //multiple process C1
        40:
          Cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[33,36]); //multiple process C2
        41:
          Cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[34,37]); //multiple process C3
        42:
          Cmd := CalcWeightedAvg(doc, [342,365]);     //calc wtAvg of main and xcomps forms
        43:
          Cmd := MultAB(doc, mcx(cx,6), mcx(cx,7), mcx(cx,8));    //income approach
        44:
          Cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[5,6]); //basement sqft
        45:
          Cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[29,27]);
        46:
          cmd := TransA2B(doc, mcx(cx,258), mcx(cx,259));  //trans sales
        47:
          cmd := TransA2B(doc, mcpx(cx,4,8), mcpx(cx,3,261));  //trans income
        48:
          cmd := ProcessMultipleCmds(ProcessForm0342Math, doc, CX,[30,52]);
        49:
          cmd := TransA2B(doc, mcx(cx,259), mcx(cx,268));  //indicated value

        50:
          begin
            F0342C1Adjustments(doc, CX);
            F0342C2Adjustments(doc, CX);
            F0342C3Adjustments(doc, CX);
            cmd := 0;
          end;

        51:
          Cmd := LandUseSum(doc, CX, 2, [84,85,86,87,89]);
        52:
          cmd := TransA2B(doc, mcx(cx,174), mcpx(cx,3,260));  //trans cost
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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0342Math(doc, 50, CX);
        end;
    end;
  result := 0;
end;

(*
###REMOVE THIS CODE - THERE IS NO MATH FOR THIS CERT PAGE
{  1004C Manufactured Home Certification  }

function ProcessForm0343Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;
*)

{  1004D Appraisal Update/Completion  }

function ProcessForm0344Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

{  1025 Small Income Property  }

function ProcessForm0349Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX,3,28));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,86));
        //github #179: use eff date: note page 2 cell 23 and page 3, 33 need to have the same context id.
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2,23),ProcessForm0349Math);
        4:  Cmd := F0349AgeLifeDepr(doc, CX);
        5:  Cmd := F0349Bsmt2Cost(doc, CX);           //for cost approach
        6:  Cmd := F0349Bsmt2Grid(doc, CX);            //transfer to grid
        7:  Cmd := F0349NoBasement(doc, CX);           //toggle basement/no basement
        8:  Cmd := F0349NoCarGarage(doc, CX);          //clears car storage
        9:  Cmd := F0349CarStorage(doc, CX);
        10: Cmd := F0349NoAttic(doc, mcx(CX, 167));     //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 167), False);    //make sure No Attic is not checked
        12: Cmd := F0349HeatingCooling(doc, CX);        //transfer to grid
        13: Cmd := F0349Fireplaces(doc, cx);            //transfer to grid
        14: Cmd := F0349Pools(doc, CX);                 //transfer to grid
        15: Cmd := F0349PatioDeckPorch(doc, CX);        //trasnfer to grid

        16: Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,25), mcx(cx,17));   //sub rent/GBA
        17: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,59), mcx(cx,51));   //C1 rent/GBA
        18: Cmd := DivideAB(doc, mcx(cx,86), mcx(cx,95), mcx(cx,87));   //C2 rent/GBA
        19: Cmd := DivideAB(doc, mcx(cx,122), mcx(cx,131), mcx(cx,123));   //C3 rent/GBA

        20: Cmd := SumAB(doc, mcx(cx,158), mcx(cx,159), mcx(cx,160));  //unit 1 act rent
        21: Cmd := SumAB(doc, mcx(cx,166), mcx(cx,167), mcx(cx,168));  //unit 2 act rent
        22: Cmd := SumAB(doc, mcx(cx,174), mcx(cx,175), mcx(cx,176));  //unit 3 act rent
        23: Cmd := SumAB(doc, mcx(cx,182), mcx(cx,183), mcx(cx,184));  //unit 4 act rent

        24: Cmd := SumAB(doc, mcx(cx,161), mcx(cx,162), mcx(cx,163));  //unit 1 est rent
        25: Cmd := SumAB(doc, mcx(cx,169), mcx(cx,170), mcx(cx,171));  //unit 2 est rent
        26: Cmd := SumAB(doc, mcx(cx,177), mcx(cx,178), mcx(cx,179));  //unit 3 est rent
        27: Cmd := SumAB(doc, mcx(cx,185), mcx(cx,186), mcx(cx,187));  //unit 4 est rent

        28: Cmd := SumFourCellsR(doc, cx, 160,168,176,184, 189);        //sum act rents
        29: Cmd := SumAB(doc, mcx(cx,189), mcx(cx,190), mcx(cx,191));   //add other act rent

        30: Cmd := SumFourCellsR(doc, cx, 163,171,179,187, 192);        //sum est rents
        31: Cmd := SumAB(doc, mcx(cx,192), mcx(cx,193), mcx(cx,194));   //add other est rent

        32: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[5,6]); //basement areas

        33:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,15), mcx(cx,16));    //sub rent chged
        34:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[39,46,50,54]);   //process Sub
        35:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[40,47,51,55,43]);   //process C1
        36:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[41,48,52,56,44]);   //process C3
        37:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[42,49,53,57, 45]);  //process C3
        38:
          cmd := CalcWeightedAvg(doc, [349,364]);   //calc wtAvg of main and xcomps forms

        39:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,35), mcx(cx,14));       //Subj price/sqft
        40:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,97), mcx(cx,65));       //C1 price/sqft
        41:
          cmd := DivideAB(doc, mcx(cx,146), mcx(cx,179), mcx(cx,147));    //C2 price/sqft
        42:
          cmd := DivideAB(doc, mcx(cx,228), mcx(cx,261), mcx(cx,229));    //C3 price/sqft

        43:
          cmd := F0349C1Adjustments(doc, cx);       //C1 sum of adjs
        44:
          cmd := F0349C2Adjustments(doc, cx);       //C2 sum of adjs
        45:
          cmd := F0349C3Adjustments(doc, cx);       //C3 sum of adjs

    //sale per rent (rent multiplier)
        46:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,15), mcx(cx,16));    //sub rent chged
        47:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,66), mcx(cx,67));    //C1 rent chged
        48:
          cmd := DivideAB(doc, mcx(cx,146), mcx(cx,148), mcx(cx,149));    //C2 rent chged
        49:
          cmd := DivideAB(doc, mcx(cx,228), mcx(cx,230), mcx(cx,231));    //C3 rent chged
    //sales per unit and total rooms
        50:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[115,117]); //sub units chged
//          cmd := IncomeSalePerUnitNRoom(doc, cx, 13, 31,34,37,40, 17,18);  //sub units chged
        51:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 64, 100,104,108,112, 68,69);  //C1 units chged
        52:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 146, 182,186,190,194, 150,151);  //C2 units chged
        53:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 228, 264,268,272,276, 232,233);  //C3 units chged
     //sales per bedroom
        54:
          Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[116,118]); //sub rooms chged
        55:
          cmd := IncomeSalePerBedRoom(doc, cx, 64, 101,105,109,113, 70);  //C1 rooms chged
        56:
          cmd := IncomeSalePerBedRoom(doc, cx, 146, 183,187,191,195, 152);  //C2 rooms chged
        57:
          cmd := IncomeSalePerBedRoom(doc, cx, 228, 265,269,273,277, 234);  //C3 rooms chged

      //adj sales price per unit and total rooms
        58:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 139, 100,104,108,112, 140,141);   //C1 units chged
        59:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 221, 182,186,190,194, 222,223);  //C2 units chged
        60:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 303, 264,268,272,276, 304,305);  //C3 units chged

      //adj sales price per bedroom
        61:
          cmd := IncomeSalePerBedRoom(doc, cx, 139, 101,105,109,113, 142);  //C1 rooms chged
        62:
          cmd := IncomeSalePerBedRoom(doc, cx, 221, 183,187,191,195, 224);  //C2 rooms chged
        63:
          cmd := IncomeSalePerBedRoom(doc, cx, 303, 265,269,273,277, 306);  //C3 rooms chged

      //adj sales prices
        64: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[38,58,61]);   //C1
        65: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[38,59,62]);   //C2
        66: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[38,60,63]);   //C3

      //calc $/unit & rooms
        67: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[51,58]); //C1 units
        68: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[52,59]); //C2 units
        69: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[53,60]); //C3 units

        70: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[55,61]); //C1 bedrooms
        71: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[56,62]); //C2 bedrooms
        72: Cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[57,63]);  //C3 bedrooms

        73:
          begin
            F0349C1Adjustments(doc, cx);
            F0349C2Adjustments(doc, cx);     //sum of adjs
            F0349C3Adjustments(doc, cx);
            cmd := 0;
          end;

        74: Cmd := LandUseSum(doc, CX, 2, [76,77,78,79,81]);

        80:
          Cmd := MultAB(doc, mcx(cx,307), mcx(cx,308), mcx(cx,309));  //value per unit
        81:
          Cmd := MultAB(doc, mcx(cx,310), mcx(cx,311), mcx(cx,312));  //value per room
        82:
          Cmd := MultAB(doc, mcx(cx,313), mcx(cx,314), mcx(cx,315));  //value per GBA
        83:
          Cmd := MultAB(doc, mcx(cx,316), mcx(cx,317), mcx(cx,318));  //value per Bedrooms

        84:
          Cmd := MultAB(doc, mcx(cx,321), mcx(cx,322), mcx(cx,323));  //Income approach

        91:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        92:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        93:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        94:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        95:
          cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37));  //sum site & improvements
        96:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        97:
          cmd := F0349CalcDeprLessPhy(doc, cx);           //funct depr entered
        98:
          cmd := F0349CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        99:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0349CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0349CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0349Math(doc, 103, CX); //sum the deprs
          end;
        100:
          begin //functional depr entered directly
            F0349CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0349CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0349Math(doc, 103, CX);  //sum the deprs
          end;
        101:
          begin
            F0349CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0349Math(doc, 103, CX);  //sum the deprs
          end;
        102:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost
        103:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        104:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);

        111:
          cmd := TransA2B(doc, mcx(cx,320), mcx(cx,325));  //trans sales
        112:
          cmd := TransA2B(doc, mcx(cx,323), mcx(cx,326));  //trans income
        113:
          cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[104,119]);
//          cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,3,322));  //trans cost
        114:
          cmd := TransA2B(doc, mcx(cx,325), MCX(cx,334));  //indicated cost

        115:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 13, 36,39,42,45, 17,18);  //sub units chged
        116:
          cmd := IncomeSalePerBedRoom(doc, cx, 13, 37,40,43,46, 19);  //sub rooms chged
        117:
          cmd := SumSubjectUnitsNRooms(doc, cx, 36,39,42,45, 308,311);
        118:
          cmd := SumSubjectBedRooms(doc, cx, 37,40,43,46, 317);
        119:
          cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,3,327));  //trans cost

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
          CX.pg := 2;    //math is on page 2
          ProcessForm0349Math(doc, 73, CX);
        end;
    end;

  result := 0;
end;

{  Non-Lender Small Income Property  }

function ProcessForm0737Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), MCPX(CX,3,28));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,83));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,33), ProcessForm0737Math); //github #179: use effdate
        4:  Cmd := F0737AgeLifeDepr(doc, CX);
        5:  Cmd := F0737Bsmt2Cost(doc, CX);           //for cost approach
        6:  Cmd := F0737Bsmt2Grid(doc, CX);            //transfer to grid
        7:  Cmd := F0737NoBasement(doc, CX);           //toggle basement/no basement
        8:  Cmd := F0737NoCarGarage(doc, CX);          //clears car storage
        9:  Cmd := F0737CarStorage(doc, CX);
        10: Cmd := F0737NoAttic(doc, mcx(CX, 164));     //uncheck all attic options
        11: Cmd := SetCellChkMark(doc, mcx(CX, 164), False);    //make sure No Attic is not checked
        12: Cmd := F0737HeatingCooling(doc, CX);        //transfer to grid
        13: Cmd := F0737Fireplaces(doc, cx);            //transfer to grid
        14: Cmd := F0737Pools(doc, CX);                 //transfer to grid
        15: Cmd := F0737PatioDeckPorch(doc, CX);        //trasnfer to grid

        16: Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,25), mcx(cx,17));   //sub rent/GBA
        17: Cmd := DivideAB(doc, mcx(cx,50), mcx(cx,59), mcx(cx,51));   //C1 rent/GBA
        18: Cmd := DivideAB(doc, mcx(cx,86), mcx(cx,95), mcx(cx,87));   //C2 rent/GBA
        19: Cmd := DivideAB(doc, mcx(cx,122), mcx(cx,131), mcx(cx,123));   //C3 rent/GBA

        20: Cmd := SumAB(doc, mcx(cx,158), mcx(cx,159), mcx(cx,160));  //unit 1 act rent
        21: Cmd := SumAB(doc, mcx(cx,166), mcx(cx,167), mcx(cx,168));  //unit 2 act rent
        22: Cmd := SumAB(doc, mcx(cx,174), mcx(cx,175), mcx(cx,176));  //unit 3 act rent
        23: Cmd := SumAB(doc, mcx(cx,182), mcx(cx,183), mcx(cx,184));  //unit 4 act rent

        24: Cmd := SumAB(doc, mcx(cx,161), mcx(cx,162), mcx(cx,163));  //unit 1 est rent
        25: Cmd := SumAB(doc, mcx(cx,169), mcx(cx,170), mcx(cx,171));  //unit 2 est rent
        26: Cmd := SumAB(doc, mcx(cx,177), mcx(cx,178), mcx(cx,179));  //unit 3 est rent
        27: Cmd := SumAB(doc, mcx(cx,185), mcx(cx,186), mcx(cx,187));  //unit 4 est rent

        28: Cmd := SumFourCellsR(doc, cx, 160,168,176,184, 189);        //sum act rents
        29: Cmd := SumAB(doc, mcx(cx,189), mcx(cx,190), mcx(cx,191));   //add other act rent

        30: Cmd := SumFourCellsR(doc, cx, 163,171,179,187, 192);        //sum est rents
        31: Cmd := SumAB(doc, mcx(cx,192), mcx(cx,193), mcx(cx,194));   //add other est rent

        32: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[5,6]); //basement areas

        33:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,15), mcx(cx,16));    //sub rent chged
        34:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[39,46,50,54]);   //process Sub
        35:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[40,47,51,55,43]);   //process C1
        36:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[41,48,52,56,44]);   //process C3
        37:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[42,49,53,57, 45]);  //process C3
        38:
          cmd := CalcWeightedAvg(doc, [737,762]);   //calc wtAvg of main and xcomps forms

        39:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,35), mcx(cx,14));       //Subj price/sqft
        40:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,97), mcx(cx,65));       //C1 price/sqft
        41:
          cmd := DivideAB(doc, mcx(cx,146), mcx(cx,179), mcx(cx,147));    //C2 price/sqft
        42:
          cmd := DivideAB(doc, mcx(cx,228), mcx(cx,261), mcx(cx,229));    //C3 price/sqft

        43:
          cmd := F0737C1Adjustments(doc, cx);       //C1 sum of adjs
        44:
          cmd := F0737C2Adjustments(doc, cx);       //C2 sum of adjs
        45:
          cmd := F0737C3Adjustments(doc, cx);       //C3 sum of adjs

    //sale per rent (rent multiplier)
        46:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,15), mcx(cx,16));    //sub rent chged
        47:
          cmd := DivideAB(doc, mcx(cx,64), mcx(cx,66), mcx(cx,67));    //C1 rent chged
        48:
          cmd := DivideAB(doc, mcx(cx,146), mcx(cx,148), mcx(cx,149));    //C2 rent chged
        49:
          cmd := DivideAB(doc, mcx(cx,228), mcx(cx,230), mcx(cx,231));    //C3 rent chged
    //sales per unit and total rooms
        50:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[115,117]); //sub units chged
//          cmd := IncomeSalePerUnitNRoom(doc, cx, 13, 31,34,37,40, 17,18);  //sub units chged
        51:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 64, 100,104,108,112, 68,69);  //C1 units chged
        52:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 146, 182,186,190,194, 150,151);  //C2 units chged
        53:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 228, 264,268,272,276, 232,233);  //C3 units chged
     //sales per bedroom
        54:
          Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[116,118]); //sub rooms chged
        55:
          cmd := IncomeSalePerBedRoom(doc, cx, 64, 101,105,109,113, 70);  //C1 rooms chged
        56:
          cmd := IncomeSalePerBedRoom(doc, cx, 146, 183,187,191,195, 152);  //C2 rooms chged
        57:
          cmd := IncomeSalePerBedRoom(doc, cx, 228, 265,269,273,277, 234);  //C3 rooms chged

      //adj sales price per unit and total rooms
        58:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 139, 100,104,108,112, 140,141);   //C1 units chged
        59:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 221, 182,186,190,194, 222,223);  //C2 units chged
        60:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 303, 264,268,272,276, 304,305);  //C3 units chged

      //adj sales price per bedroom
        61:
          cmd := IncomeSalePerBedRoom(doc, cx, 139, 101,105,109,113, 142);  //C1 rooms chged
        62:
          cmd := IncomeSalePerBedRoom(doc, cx, 221, 183,187,191,195, 224);  //C2 rooms chged
        63:
          cmd := IncomeSalePerBedRoom(doc, cx, 303, 265,269,273,277, 306);  //C3 rooms chged

      //adj sales prices
        64: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[38,58,61]);   //C1
        65: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[38,59,62]);   //C2
        66: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[38,60,63]);   //C3

      //calc $/unit & rooms
        67: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[51,58]); //C1 units
        68: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[52,59]); //C2 units
        69: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[53,60]); //C3 units

        70: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[55,61]); //C1 bedrooms
        71: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[56,62]); //C2 bedrooms
        72: Cmd := ProcessMultipleCmds(ProcessForm0737Math, doc, CX,[57,63]);  //C3 bedrooms

        73:
          begin
            F0737C1Adjustments(doc, cx);
            F0737C2Adjustments(doc, cx);     //sum of adjs
            F0737C3Adjustments(doc, cx);
            cmd := 0;
          end;

        74: Cmd := LandUseSum(doc, CX, 2, [73,74,75,76,78]);

        80:
          Cmd := MultAB(doc, mcx(cx,307), mcx(cx,308), mcx(cx,309));  //value per unit
        81:
          Cmd := MultAB(doc, mcx(cx,310), mcx(cx,311), mcx(cx,312));  //value per room
        82:
          Cmd := MultAB(doc, mcx(cx,313), mcx(cx,314), mcx(cx,315));  //value per GBA
        83:
          Cmd := MultAB(doc, mcx(cx,316), mcx(cx,317), mcx(cx,318));  //value per Bedrooms

        84:
          Cmd := MultAB(doc, mcx(cx,321), mcx(cx,322), mcx(cx,323));  //Income approach

        91:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        92:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        93:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        94:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        95:
          cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37));  //sum site & improvements
        96:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        97:
          cmd := F0737CalcDeprLessPhy(doc, cx);           //funct depr entered
        98:
          cmd := F0737CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        99:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0737CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0737CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0737Math(doc, 103, CX); //sum the deprs
          end;
        100:
          begin //functional depr entered directly
            F0737CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0737CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0349Math(doc, 103, CX);  //sum the deprs
          end;
        101:
          begin
            F0737CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0349Math(doc, 103, CX);  //sum the deprs
          end;
        102:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost
        103:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        104:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);

        111:
          cmd := TransA2B(doc, mcx(cx,320), mcx(cx,325));  //trans sales
        112:
          cmd := TransA2B(doc, mcx(cx,323), mcx(cx,326));  //trans income
        113:
          cmd := ProcessMultipleCmds(ProcessForm0349Math, doc, CX,[104,119]);
//          cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,3,322));  //trans cost
        114:
          cmd := TransA2B(doc, mcx(cx,325), MCX(cx,334));  //indicated cost

        115:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 13, 36,39,42,45, 17,18);  //sub units chged
        116:
          cmd := IncomeSalePerBedRoom(doc, cx, 13, 37,40,43,46, 19);  //sub rooms chged
        117:
          cmd := SumSubjectUnitsNRooms(doc, cx, 36,39,42,45, 308,311);
        118:
          cmd := SumSubjectBedRooms(doc, cx, 37,40,43,46, 317);
        119:
          cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,3,327));  //trans cost

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
          CX.pg := 2;    //math is on page 2
          ProcessForm0737Math(doc, 73, CX);
        end;
    end;

  result := 0;
end;



{  Non-Lender, 1025, 2000A same as Small Income Property Xtra Comps   }

function ProcessForm0364Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 64,147,230);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 64,147,230, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 64,147,230);

        4:
          Cmd := ProcessMultipleCmds(ProcessForm0364Math, doc, CX,[9,16,20,24]);    //process Sub
        5:
          cmd := ProcessMultipleCmds(ProcessForm0364Math, doc, CX,[10,13,17,21,25]);         //process C1
        6:
          Cmd := ProcessMultipleCmds(ProcessForm0364Math, doc, CX,[11,14,18,22,26]);         //process C3
        7:
          Cmd := ProcessMultipleCmds(ProcessForm0364Math, doc, CX,[12,15,19,23,27]);         //process C3
        8:
          cmd := CalcWeightedAvg(doc, [349,360,364, 737, 762]);   //calc wtAvg of main and xcomps forms

        9:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,38), mcx(cx,17));       //Subj price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,68), mcx(cx,101), mcx(cx,69));       //C1 price/sqft
        11:
          cmd := DivideAB(doc, mcx(cx,151), mcx(cx,184), mcx(cx,152));    //C2 price/sqft
        12:
          cmd := DivideAB(doc, mcx(cx,234), mcx(cx,267), mcx(cx,235));    //C3 price/sqft

        13:
          cmd := F0364C1Adjustments(doc, cx);       //C1 sum of adjs
        14:
          cmd := F0364C2Adjustments(doc, cx);       //C2 sum of adjs
        15:
          cmd := F0364C3Adjustments(doc, cx);       //C3 sum of adjs

    //sale per rent (rent multiplier)
        16:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,18), mcx(cx,19));    //sub rent chged
        17:
          cmd := DivideAB(doc, mcx(cx,68), mcx(cx,70), mcx(cx,71));    //C1 rent chged
        18:
          cmd := DivideAB(doc, mcx(cx,151), mcx(cx,153), mcx(cx,154));    //C2 rent chged
        19:
          cmd := DivideAB(doc, mcx(cx,234), mcx(cx,236), mcx(cx,237));    //C3 rent chged
    //sales per unit and total rooms
        20:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 16, 39,42,45,48, 20,21);  //sub units chged
        21:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 68, 104,108,112,116, 72,73);  //C1 units chged
        22:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 151, 187,191,195,199, 155,156);  //C2 units chged
        23:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 234, 270,274,278,282, 238,239);  //C3 units chged
     //sales per bedroom
        24:
          cmd := IncomeSalePerBedRoom(doc, cx, 16, 40,43,46,49, 22);  //sub rooms chged
        25:
          cmd := IncomeSalePerBedRoom(doc, cx, 68, 105,109,113,117, 74);  //C1 rooms chged
        26:
          cmd := IncomeSalePerBedRoom(doc, cx, 151, 188,192,196,200, 157);  //C2 rooms chged
        27:
          cmd := IncomeSalePerBedRoom(doc, cx, 234, 271,275,279,283, 240);  //C3 rooms chged

      //adj sales price per unit and total rooms
        28:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 143, 104,108,112,116, 144,145);  //C1 units chged
        29:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 226, 187,191,195,199, 227,228);  //C2 units chged
        30:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 309, 270,274,278,282, 310,311);  //C3 units chged

      //adj sales price per bedroom
        31:
          cmd := IncomeSalePerBedRoom(doc, cx, 143, 105,109,113,117, 146);  //C1 rooms chged
        32:
          cmd := IncomeSalePerBedRoom(doc, cx, 226, 188,192,196,200, 229);  //C2 rooms chged
        33:
          cmd := IncomeSalePerBedRoom(doc, cx, 309, 271,275,279,283, 312);  //C3 rooms chged

      //adj sales prices
        34: Cmd := F0364Process4Cmds(doc, CX, 8,28,31,0);   //C1
        35: Cmd := F0364Process4Cmds(doc, CX, 8,29,32,0);   //C2
        36: Cmd := F0364Process4Cmds(doc, CX, 8,30,33,0);   //C3

      //calc $/unit & rooms
        37: Cmd := F0364Process4Cmds(doc, CX, 21,28,0,0); //C1 units
        38: Cmd := F0364Process4Cmds(doc, CX, 22,29,0,0); //C2 units
        39: Cmd := F0364Process4Cmds(doc, CX, 23,30,0,0); //C3 units

        40: Cmd := F0364Process4Cmds(doc, CX, 25,31,0,0); //C1 bedrooms
        41: Cmd := F0364Process4Cmds(doc, CX, 26,32,0,0); //C2 bedrooms
        42: Cmd := F0364Process4Cmds(doc, CX, 27,33,0,0); //C3 bedrooms

        43:
          begin
            F0364C1Adjustments(doc, cx);
            F0364C2Adjustments(doc, cx);     //sum of adjs
            F0364C3Adjustments(doc, cx);
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
          ProcessForm0364Math(doc, 13, CX);
          ProcessForm0364Math(doc, 14, CX);
          ProcessForm0364Math(doc, 15, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0364Math(doc, 43, CX);
        end;
    end;

  result := 0;
end;

{  1025 Small Income Property XTra Rentals   }
function ProcessForm0362Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Rentals', 47,84,121);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA RENTALS','', 47,84,121, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 47,84,121);

        4: Cmd := DivideAB(doc, mcx(cx,16), mcx(cx,25), mcx(cx,17));
        5: Cmd := DivideAB(doc, mcx(cx,51), mcx(cx,60), mcx(cx,52));
        6: Cmd := DivideAB(doc, mcx(cx,88), mcx(cx,97), mcx(cx,89));
        7: Cmd := DivideAB(doc, mcx(cx,125), mcx(cx,134), mcx(cx,126));
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;

(*
//### REMOVE - NOT MATH FOR THIS FORM

{  1025 Small Income Property Certification   }

function ProcessForm0350Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

*)
{  1073 Condo  }

function ProcessForm0345Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,29), mcx(cx,30), MCPX(cx,3,23));
        2:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,31), ProcessForm0345Math);  //github #179: use effdate
        3:  Cmd := MultAByVal(doc, mcx(cx,30), mcx(cx,31), 12.0);     //annual unit charges
        4:  Cmd := DivideAB(doc, mcx(cx,31), mcx(cx,83), mcx(cx,32));   //annual unit charge/GLA

        5:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        6:
          Cmd := DivideAB(doc, mcx(cx,55), mcx(cx,92), mcx(cx,56));       //C1 Price/GLA
        7:
          Cmd := DivideAB(doc, mcx(cx,123), mcx(cx,160), mcx(cx,124));    //c2 Price/GLA
        8:
          Cmd := DivideAB(doc, mcx(cx,191), mcx(cx,228), mcx(cx,192));    //C3 Price/GLA
        9:
          Cmd := F0345C1Adjustments(doc, CX);
        10:
          Cmd := F0345C2Adjustments(doc, CX);
        11:
          Cmd := F0345C3Adjustments(doc, CX);
        12:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        13:
          Cmd := ProcessMultipleCmds(ProcessForm0345Math, doc, CX, [6,9]); //multiple process C1
        14:
          Cmd := ProcessMultipleCmds(ProcessForm0345Math, doc, CX, [7,10]); //multiple process C2
        15:
          Cmd := ProcessMultipleCmds(ProcessForm0345Math, doc, CX, [8,11]); //multiple process C3
        16:
          Cmd := CalcWeightedAvg(doc, [345,367]);   //calc wtAvg of main and xcomps forms
        17:
          Cmd := MultAB(doc, mcx(cx,256), mcx(cx,257), mcx(cx,258));    //income approach
        18:
          cmd := F0345HeatingCooling(doc, cx); //cooling/heating
        19:
          cmd := F0345Fireplaces(doc, cx); //fireplaces
        20:
          cmd := F0345PatioDeckPorch(doc, cx); //deck/patio
        21:
          cmd := F0345NoCarGarage(doc, cx); //no garage
        22:
          cmd := F0345CarStorage(doc, cx); //car storage count
        23:
          begin
            F0345C1Adjustments(doc, CX);
            F0345C2Adjustments(doc, CX);
            F0345C3Adjustments(doc, CX);
            cmd := 0;
          end;
        24:
          Cmd := LandUseSum(doc, CX, 2, [77,78,79,80,82]);
        25:
          cmd := TransA2B(doc, mcx(cx,255), mcx(cx,260));  //trans sales
        26:
          cmd := TransA2B(doc, mcx(cx,258), mcx(cx,261));  //trans income
        27:
          cmd := TransA2B(doc, mcx(cx,260), mcx(cx,268));  //indicated value
        28:
          cmd := ProcessMultipleCmds(ProcessForm0345Math, doc, CX, [29,30]);
        29:
          cmd := F0345HOATransfer(doc, CX, 26,27,28, 24);
        30:
          cmd := F0345UnitChargeTransfer(doc, CX, 26,27,28, 30);
        31:
          cmd := F0345Woodstove(doc, cx);
        32:
          cmd := F0345OtherAmenity(doc, cx);
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0345UADDesignStyle(doc, CX)       //transfer UAD design-style to grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0345UADGridDesignStyle(doc, CX)    //transfer UAD design-style from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid
        {92:
          if doc.UADEnabled then
            cmd := F0345UADGridCarStorage(doc, cx)       //car storage counts from grid
          else
            Cmd := 0;       //transfer UAD design-style to grid}
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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0345Math(doc, 23, CX);
        end;
    end;

  result := 0;
end;

{ Non-Lender Condo  }

function ProcessForm0735Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,29), mcx(cx,30), MCPX(cx,3,23));
        2:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,31), ProcessForm0735Math); //github #179:use effdate
        3:  Cmd := MultAByVal(doc, mcx(cx,30), mcx(cx,31), 12.0);     //annual unit charges
        4:  Cmd := DivideAB(doc, mcx(cx,31), mcx(cx,83), mcx(cx,32));   //annual unit charge/GLA

        5:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        6:
          Cmd := DivideAB(doc, mcx(cx,55), mcx(cx,92), mcx(cx,56));       //C1 Price/GLA
        7:
          Cmd := DivideAB(doc, mcx(cx,123), mcx(cx,160), mcx(cx,124));    //c2 Price/GLA
        8:
          Cmd := DivideAB(doc, mcx(cx,191), mcx(cx,228), mcx(cx,192));    //C3 Price/GLA
        9:
          Cmd := F0735C1Adjustments(doc, CX);
        10:
          Cmd := F0735C2Adjustments(doc, CX);
        11:
          Cmd := F0735C3Adjustments(doc, CX);
        12:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        13:
          Cmd := ProcessMultipleCmds(ProcessForm0735Math, doc, CX, [6,9]); //multiple process C1
        14:
          Cmd := ProcessMultipleCmds(ProcessForm0735Math, doc, CX, [7,10]); //multiple process C2
        15:
          Cmd := ProcessMultipleCmds(ProcessForm0735Math, doc, CX, [8,11]); //multiple process C3
        16:
          Cmd := CalcWeightedAvg(doc, [735,760]);   //calc wtAvg of main and xcomps forms
        17:
          Cmd := MultAB(doc, mcx(cx,256), mcx(cx,257), mcx(cx,258));    //income approach
        18:
          cmd := F0735HeatingCooling(doc, cx); //cooling/heating
        19:
          cmd := F0735Fireplaces(doc, cx); //fireplaces
        20:
          cmd := F0735PatioDeckPorch(doc, cx); //deck/patio
        21:
          cmd := F0735NoCarGarage(doc, cx); //no garage
        22:
          cmd := F0735CarStorage(doc, cx); //car storage count
        23:
          begin
            F0735C1Adjustments(doc, CX);
            F0735C2Adjustments(doc, CX);
            F0735C3Adjustments(doc, CX);
            cmd := 0;
          end;
        24:
          Cmd := LandUseSum(doc, CX, 2, [74,75,76,77,79]);
        25:
          cmd := TransA2B(doc, mcx(cx,255), mcx(cx,260));  //trans sales
        26:
          cmd := TransA2B(doc, mcx(cx,258), mcx(cx,261));  //trans income
        27:
          cmd := TransA2B(doc, mcx(cx,260), mcx(cx,268));  //indicated value
        28:
          cmd := ProcessMultipleCmds(ProcessForm0735Math, doc, CX, [29,30]);
        29:
          cmd := F0735HOATransfer(doc, CX, 26,27,28, 24);
        30:
          cmd := F0735UnitChargeTransfer(doc, CX, 26,27,28, 30);
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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0735Math(doc, 23, CX);
        end;
    end;

  result := 0;
end;
//################################   Start math 4247

function F4247HOATransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,3,CR), VR);           //transfer to grid
  ProcessForm4247Math(doc, cmd, MCPX(CX,3,CR));          //do any math on it

result := 0;
end;

function F4247UnitChargeTransfer(doc: TContainer; CX: CellUID; HOAID, YearID, MonthID, CR: Integer): Integer;
var
  V1, VR: Double;
  cmd: Integer;
begin
  VR := 0;
  V1 := GetCellValue(doc, mcx(cx,HOAID));
  if V1 <> 0 then
    begin
      if CellIsChecked(doc, mcx(cx, MonthID)) then       //monthly
        VR := V1
      else if CellIsChecked(doc, mcx(cx,YearID)) then    //yearly
        VR := V1 / 12;
    end;

  cmd := SetCellValue(doc, MCPX(CX,2,CR), VR);           //transfer to grid
  ProcessForm4247Math(doc, cmd, MCPX(CX,2,CR));          //do any math on it

result := 0;
end;


function F4247HeatingCooling(doc: TContainer; CX: CellUID): Integer;
var
//F1: String;
  S1,S2: String;
  cmd: Integer;
begin
  S1 := GetCellString(doc, mcx(cx,45));   //heating type

// remove the fuel
//  F1 := GetCellString(doc, mcx(cx,46));   //fuel
//  if length(F1)>0 then
//    S1 := S1 +'/'+ F1;                    //type/fuel

  S2 := '';
  if CellIsChecked(doc, mcx(cx, 47)) then        //centeral air
    S2 := 'Central'
  else if CellIsChecked(doc, mcx(cx,48)) then    //individual
    S2 := 'Individual'
  else
    S2 := GetCellString(doc, mcx(cx,50));       //other source

  if (length(S1) >0) or (length(S2) > 0) then
    begin
      if (length(S2) > 0) then
        S1 := S1 + '/' + S2;
      cmd := SetCellString(doc, MCPX(CX,3,40), S1); //transfer to grid
      ProcessForm4247Math(doc, cmd, MCPX(CX,3,40));
    end;
  result := 0;
end;

function F4247Fireplaces(doc: TContainer; CX: CellUID): Integer;
var
  S1: String;
  V1, Cmd: Integer;
begin
  V1 := Trunc(GetCellValue(doc, mcx(cx, 57)));
  if V1 > 0 then
    begin
      S1 := ' Fireplace';
      if V1 > 1 then S1 := ' Fireplaces';
      S1 := IntToStr(V1) + S1;

      SetCellChkMark(doc, mcx(cx,56), True);                    //set the checkmark
      SetCellString(doc, MCPX(CX, 3, 44), 'Fireplaces');        //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), S1);          //result
      ProcessForm4247Math(doc, cmd, MCPX(CX,3,45));
    end

  else if not CellIsChecked(doc, mcx(cx,56)) then
    begin
      if GetCellValue(doc, mcx(cx, 57)) > 0 then
        SetCellString(doc, MCX(CX,57), '');                //firepace count
      SetCellString(doc, MCPX(CX, 3, 44), '');             //heading
      cmd := SetCellString(doc, MCPX(CX,3,45), '');     //result
      ProcessForm4247Math(doc, cmd, MCPX(CX,3,45));
    end;
  result := 0;
end;

function F4247PatioDeckPorch(doc: TContainer; CX: CellUID): Integer;
var
  S1: string;
  Cmd: Integer;
begin
  S1 := '';
  if CellIsChecked(doc, mcx(CX, 60)) then
    S1 := 'Patio/Deck';
  if CellIsChecked(doc, mcx(CX, 62)) then
    begin
      if length(S1) > 0 then
        S1 := Concat(S1, ',', 'Porch')
      else
        S1 := 'Porch';
    end;

  if length(S1) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,43), S1); //transfer to grid
      ProcessForm4247Math(doc, cmd, MCPX(CX,3,43));
    end;
  result := 0;
end;

function F4247NoCarGarage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 72)) then
    begin
      SetCellChkMark(doc, Mcx(cx,73), False);
      SetCellChkMark(doc, Mcx(cx,74), False);
      SetCellChkMark(doc, Mcx(cx,75), False);
      SetCellString(doc, MCX(CX, 76), '');
      SetCellChkMark(doc, Mcx(cx,77), False);
      SetCellChkMark(doc, Mcx(cx,78), False);
      SetCellString(doc, MCX(CX, 79), '');
      SetCellString(doc, MCPX(CX,3,42), ''); //transfer to grid
    end;
  result := 0;
end;

function F4247CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  S1,S2,S3,S4,S5,S6: string;
  cmd: Integer;
begin
  S1 := '';
  S3 := '';
  if CellIsChecked(doc, mcx(cx, 73)) then
    S1 := 'Garage'
  else if CellIsChecked(doc, mcx(cx,74)) then
    S1 := 'Carport'
  else if CellIsChecked(doc, mcx(cx,75)) then
    S1 := 'Open';

  if GetCellValue(doc, mcx(CX, 76)) > 0 then
    begin
      S2 := GetCellString(doc, mcx(cx,76));
      S3 := S2 + ' Car ' + S1;
    end;

  S4 := '';
  if CellIsChecked(doc, mcx(cx, 77)) then
    S4 := 'Assigned'
  else if CellIsChecked(doc, mcx(cx,78)) then
    S4 := 'Owned';

  if GetCellValue(doc, mcx(cx,79)) > 0 then
    begin
      S5 := GetCellString(doc, mcx(cx,79));
      S6 := S5 + ' ' + S4 + ' Spaces';
    end;

  if (length(S3)>0) and CellIsChecked(doc, MCX(cx,72)) Then
    SetCellChkMark(doc, MCX(cx,72), False);    //make sure we uncheck None for cars

  if length(S3) > 0 then
    begin
      cmd := SetCellString(doc, MCPX(CX,3,42), S3); //transfer to grid
      ProcessForm4247Math(doc, cmd, MCPX(CX,3,42));
    end;
  result := 0;
end;



function F4247C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,50));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 55,116,117,114,115,2,3,
    [60,62,64,66,68,70,72,74,76,78,80,82,84,86,87,91,93,95,97,99,101,103,105,107,109,111,113],length(addr) > 0);
end;

function F4247C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,118));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 123,184,185,182,183,4,5,
    [128,130,132,134,136,138,140,142,144,146,148,150,152,154,155,159,161,163,165,167,169,171,173,175,177,179,181],length(addr) > 0);
end;

function F4247C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197,346: skip if no address
  addr := GetCellString(doc, mcx(cx,186));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 191,252,253,250,251,6,7,
    [196,198,200,202,204,206,208,210,212,214,216,218,220,222,223,227,229,231,233,235,237,239,241,243,245,247,249],length(addr) > 0);
end;



function ProcessForm4247Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,29), mcx(cx,30), MCPX(cx,3,23));
        2:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,31), ProcessForm4247Math); //github #179:use effdate
        3:  Cmd := MultAByVal(doc, mcx(cx,30), mcx(cx,31), 12.0);     //annual unit charges
        4:  Cmd := DivideAB(doc, mcx(cx,31), mcx(cx,83), mcx(cx,32));   //annual unit charge/GLA

        5:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        6:
          Cmd := DivideAB(doc, mcx(cx,55), mcx(cx,92), mcx(cx,56));       //C1 Price/GLA
        7:
          Cmd := DivideAB(doc, mcx(cx,123), mcx(cx,160), mcx(cx,124));    //c2 Price/GLA
        8:
          Cmd := DivideAB(doc, mcx(cx,191), mcx(cx,228), mcx(cx,192));    //C3 Price/GLA
        9:
          Cmd := F4247C1Adjustments(doc, CX);
        10:
          Cmd := F4247C2Adjustments(doc, CX);
        11:
          Cmd := F4247C3Adjustments(doc, CX);
        12:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        13:
          Cmd := ProcessMultipleCmds(ProcessForm4247Math, doc, CX, [6,9]); //multiple process C1
        14:
          Cmd := ProcessMultipleCmds(ProcessForm4247Math, doc, CX, [7,10]); //multiple process C2
        15:
          Cmd := ProcessMultipleCmds(ProcessForm4247Math, doc, CX, [8,11]); //multiple process C3
        16:
          Cmd := CalcWeightedAvg(doc, [4247,4248]);   //calc wtAvg of main and xcomps forms
        17:
          Cmd := MultAB(doc, mcx(cx,256), mcx(cx,257), mcx(cx,258));    //income approach
        18:
          cmd := F4247HeatingCooling(doc, cx); //cooling/heating
        19:
          cmd := F4247Fireplaces(doc, cx); //fireplaces
        20:
          cmd := F4247PatioDeckPorch(doc, cx); //deck/patio
        21:
          cmd := F4247NoCarGarage(doc, cx); //no garage
        22:
          cmd := F4247CarStorage(doc, cx); //car storage count
        23:
          begin
            F4247C1Adjustments(doc, CX);
            F4247C2Adjustments(doc, CX);
            F4247C3Adjustments(doc, CX);
            cmd := 0;
          end;
        24:
          Cmd := LandUseSum(doc, CX, 2, [74,75,76,77,79]);
        25:
          cmd := TransA2B(doc, mcx(cx,255), mcx(cx,260));  //trans sales
        26:
          cmd := TransA2B(doc, mcx(cx,258), mcx(cx,261));  //trans income
        27:
          cmd := TransA2B(doc, mcx(cx,260), mcx(cx,268));  //indicated value
        28:
          cmd := ProcessMultipleCmds(ProcessForm4247Math, doc, CX, [29,30]);
        29:
          cmd := F4247HOATransfer(doc, CX, 26,27,28, 24);
        30:
          cmd := F4247UnitChargeTransfer(doc, CX, 26,27,28, 30);
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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm4247Math(doc, 23, CX);
        end;
    end;

  result := 0;
end;

{  Non-Lender, 1073 , 1075 same as Condo Xtra Comps  }

function ProcessForm0367Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 53,122,191);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 53,122,191, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 53,122,191);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,18), mcx(cx,39), mcx(cx,19));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0367Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F0367C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0367C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,59), mcx(cx,96), mcx(cx,60));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm0367Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0367C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0367C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,128), mcx(cx,165), mcx(cx,129));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm0367Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F0367C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0367C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,197), mcx(cx,234), mcx(cx,198));     //price/sqft

        14:
          cmd := CalcWeightedAvg(doc, [345,347,367, 735, 760]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0367C1Adjustments(doc, cx);
            F0367C2Adjustments(doc, cx);     //sum of adjs
            F0367C3Adjustments(doc, cx);
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
          ProcessForm0367Math(doc, 6, CX);
          ProcessForm0367Math(doc, 9, CX);
          ProcessForm0367Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0367Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE  - NO MATH FOR THIS FORM

{  1073 Condo Certification   }

function ProcessForm0346Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;
*)
{  2090 CoOp Interest  }

function ProcessForm0351Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := YearToAge2(doc, mcx(cx,139), MCPX(CX,3,33), ProcessForm0351Math); //github @179
        2:  Cmd := MultAByVal(doc, mcx(cx,79), mcx(cx,80), 12.0);       //maintenace/year
        3:  Cmd := F0351NoCarGarage(doc, CX);          //clears out cells when no garage
        4:  Cmd := F0351CarStorage(doc, CX);           //transfer to  grid
        5:  Cmd := 0; //transfer #Units to grid
        6:  Cmd := F0351HeatingCooling(doc, CX);      //transfer to grid
        7:  Cmd := F0351Fireplaces(doc, cx);          //transfer to grid
        8:  Cmd := F0351PatioDeckPorch(doc, CX);      //trasnfer to grid
        9:  Cmd := DivideAB(doc, mcx(cx,80), mcx(cx,64), mcx(cx,81));   //maintenace/GLA

        10:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,40), mcx(cx,15));     //Subj price/sqft
        11:
          cmd := DivideAB(doc, mcx(cx,58), mcx(cx,104), mcx(cx,59));     //C1 price/sqft
        12:
          cmd := DivideAB(doc, mcx(cx,134), mcx(cx,180), mcx(cx,135));  //C2 price/sqft
        13:
          cmd := DivideAB(doc, mcx(cx,210), mcx(cx,256), mcx(cx,211));  //C3 price/sqft
        14:
          Cmd := F0351C1Adjustments(doc, cx);
        15:
          Cmd := F0351C2Adjustments(doc, cx);
        16:
          Cmd := F0351C3Adjustments(doc, cx);
        17:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,40), mcx(cx,15));     //Subj price/sqft
        18:
          cmd := ProcessMultipleCmds(ProcessForm0351Math, doc, CX, [11,14]); //C1 sales price
        19:
          cmd := ProcessMultipleCmds(ProcessForm0351Math, doc, CX, [12,15]); //C2 sales price
        20:
          cmd := ProcessMultipleCmds(ProcessForm0351Math, doc, CX, [13,16]); //C3 sales price
        21:
          cmd := CalcWeightedAvg(doc, [351,366]);
        22:
          begin
            F0351C1Adjustments(doc, cx);
            F0351C2Adjustments(doc, cx);
            F0351C3Adjustments(doc, cx);
            cmd := 0;     //cala all three sdjustments
          end;
        23:
          Cmd := LandUseSum(doc, CX, 2, [75,76,77,78,80]);

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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0351Math(doc, 22, CX);
        end;
    end;

  result := 0;
end;

{  2090, 2095 same as CoOp Interest Xtra Comps  }

function ProcessForm0366Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 57,134,211);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 57,134,211, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 57,134,211);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,17), mcx(cx,43), mcx(cx,18));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0366Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F0366C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0366C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,62), mcx(cx,108), mcx(cx,63));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm0366Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0366C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0366C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,139), mcx(cx,185), mcx(cx,140));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm0366Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F0366C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0366C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,216), mcx(cx,262), mcx(cx,217));     //price/sqft

        14:
          cmd := CalcWeightedAvg(doc, [351,353,366]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0366C1Adjustments(doc, cx);
            F0366C2Adjustments(doc, cx);     //sum of adjs
            F0366C3Adjustments(doc, cx);
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
          ProcessForm0366Math(doc, 6, CX);
          ProcessForm0366Math(doc, 9, CX);
          ProcessForm0366Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0366Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE  - NO MATH FOR THIS FORM

{  2090 CoOp Interest Certification  }

function ProcessForm0352Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;
*)

{  2055 Exterior Inspection Residential  }

function ProcessForm0355Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), mcpx(cx,2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,86));
        3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2, 26), ProcessForm0355Math); //github #179: use effdate
        4:  Cmd := F0355AgeLifeDepr(doc, CX);
       //Github #144: disable math calculation for math id #5 to make it works like 1004 form.
       // 5:  Cmd := F0355NoBasement(doc, CX);           //toggle basement/no basement
        6:
          if not doc.UADEnabled then
            Cmd := F0355HasBasement(doc, CX)          //transfer to grid
          else
            Cmd := 0;
        7:  Cmd := F0355HeatingCooling(doc, CX);      //transfer to grid
        8:  Cmd := F0355Fireplaces(doc, cx);          //transfer to grid
        9:  Cmd := F0355PatioDeckPorch(doc, CX);      //trasnfer to grid
        10: Cmd := F0355Pools(doc, CX);               //transfer to grid
        11: Cmd := F0355NoCarGarage(doc, CX);         //clears Car Storage
        12:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0355UADCarStorage(doc, CX)           //transfer UAD garage-carport-driveway to grid
          else
            Cmd := F0355CarStorage(doc, CX);               //transfer std garage-carport-driveway to grid
        13: Cmd := LandUseSum(doc, CX, 2, [76,77,78,79,81]);

        14:
          Cmd := CalcWeightedAvg(doc, [355,363]);   //calc wtAvg of main and xcomps forms
        15:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        16:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        17:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        18:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        19:
          Cmd := F0355C1Adjustments(doc, cx);
        20:
          Cmd := F0355C2Adjustments(doc, cx);
        21:
          Cmd := F0355C3Adjustments(doc, cx);
        22:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        23:
          cmd := ProcessMultipleCmds(ProcessForm0355Math, doc, CX, [16,19]); //C1 sales price
        24:
          cmd := ProcessMultipleCmds(ProcessForm0355Math, doc, CX, [17,20]); //C2 sales price
        25:
          cmd := ProcessMultipleCmds(ProcessForm0355Math, doc, CX, [18,21]); //C3 sales price

        26:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        27:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        28:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        29:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        30:
          cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37));  //sum site & improvements
        31:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        32:
          cmd := F0355CalcDeprLessPhy(doc, cx);           //funct depr entered
        33:
          cmd := F0355CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        34:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0355CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0355CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0355Math(doc, 43, CX); //sum the deprs
          end;
        35:
          begin //functional depr entered directly
            F0355CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0355CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0355Math(doc, 43, CX);  //sum the deprs
          end;
        36:
          begin
            F0355CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd :=ProcessForm0355Math(doc, 43, CX);  //sum the deprs
          end;
        37:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost

        43:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        44:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);
        45:
          cmd := MultAB(doc, mcx(cx,38), mcx(cx,39), mcx(cx,40));    //calc income approach

        46:
          begin
            F0355C1Adjustments(doc, cx);
            F0355C2Adjustments(doc, cx);
            F0355C3Adjustments(doc, cx);
            cmd := 0;
          end;
        47: Cmd := F0355Fence(doc, CX);
        48: Cmd := F0355OtherAmenity(doc, CX);
        49: Cmd := F0355Woodstove(doc, CX);

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));     //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));   //trans income
        53:
          begin
            ProcessForm0355Math(doc, 44, CX);
            cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));   //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));     //indicated value
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0355UADDesignStyle(doc, CX)         //transfer UAD design-style to grid
          else
            Cmd := 0;
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0355UADGridDesignStyle(doc, CX)      //transfer UAD design-style from grid
          else
            Cmd := 0;
        92:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            cmd := F0355UADGridCarStorage(doc, cx)      //transfer UAD car storage counts from grid
          else
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0355Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;

{  Non-Lender Exterior Inspection Residential  }

function ProcessForm0764Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,28), mcx(cx,29), mcpx(cx,2,21));
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,83));
		    3:  Cmd := YearToAge2(doc, CX, MCPX(CX,2, 26), ProcessForm0764Math); //github #179: use effdate
        4:  Cmd := F0764AgeLifeDepr(doc, CX);
        5:  Cmd := F0764NoBasement(doc, CX);           //toggle basement/no basement
        6:  Cmd := F0764HasBasement(doc, CX);          //transfer to grid
        7:  Cmd := F0764HeatingCooling(doc, CX);      //transfer to grid
        8:  Cmd := F0764Fireplaces(doc, cx);          //transfer to grid
        9:  Cmd := F0764PatioDeckPorch(doc, CX);      //trasnfer to grid
        10: Cmd := F0764Pools(doc, CX);               //transfer to grid
        11: Cmd := F0764NoCarGarage(doc, CX);         //clears Car Storage
        12: Cmd := F0764CarStorage(doc, CX);           //transfer to  grid
        13: Cmd := LandUseSum(doc, CX, 2, [73,74,75,76,78]);

        14:
          Cmd := CalcWeightedAvg(doc, [764,765]);   //calc wtAvg of main and xcomps forms
        15:
          cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        16:
          cmd := DivideAB(doc, mcx(cx,48), mcx(cx,79), mcx(cx,49));     //C1 price/sqft
        17:
          cmd := DivideAB(doc, mcx(cx,108), mcx(cx,139), mcx(cx,109));  //C2 price/sqft
        18:
          cmd := DivideAB(doc, mcx(cx,168), mcx(cx,199), mcx(cx,169));  //C3 price/sqft
        19:
          Cmd := F0764C1Adjustments(doc, cx);
        20:
          Cmd := F0764C2Adjustments(doc, cx);
        21:
          Cmd := F0764C3Adjustments(doc, cx);
        22:
          Cmd := DivideAB(doc, mcx(cx,13), mcx(cx,31), mcx(cx,14));     //Subj price/sqft
        23:
          cmd := ProcessMultipleCmds(ProcessForm0764Math, doc, CX, [16,19]); //C1 sales price
        24:
          cmd := ProcessMultipleCmds(ProcessForm0764Math, doc, CX, [17,20]); //C2 sales price
        25:
          cmd := ProcessMultipleCmds(ProcessForm0764Math, doc, CX, [18,21]); //C3 sales price

        26:
          cmd := MultAB(doc, mcx(cx,15), mcx(cx,16), mcx(cx,17));      //dwelling
        27:
          cmd := MultAB(doc, mcx(cx,19), mcx(cx,20), mcx(cx,21));      //other
        28:
          cmd := MultAB(doc, mcx(cx,24), mcx(cx,25), mcx(cx,26));      //garage
        29:
          cmd := SumFourCellsR(doc, cx, 17,21,23,26, 27);              //sum costs
        30:
          cmd := SumABC(doc, mcx(cx,14), mcx(cx,35), mcx(cx,36), mcx(cx, 37));  //sum site & improvements
        31:
          Cmd := MultPercentAB(doc, mcx(cx,27), mcx(cx,28),mcx(cx,29));         //phy dep precent entered
        32:
          cmd := F0764CalcDeprLessPhy(doc, cx);           //funct depr entered
        33:
          cmd := F0764CalcDeprLessPhyNFunct(doc, cx);     //external depr entered
        34:
          begin  //phy depr entered directly
            PercentAOfB(doc, mcx(cx,29), mcx(cx,27), mcx(cx,28));    //recalc phy percent
            F0764CalcDeprLessPhy(doc, cx);          //recalc funct based on its %
            F0764CalcDeprLessPhyNFunct(doc, cx);    //recalc exten based on its %
            Cmd :=ProcessForm0764Math(doc, 43, CX); //sum the deprs
          end;
        35:
          begin //functional depr entered directly
            F0764CalcPctLessPhy(doc, cx);            //recalc the new precent
            F0764CalcDeprLessPhyNFunct(doc, cx);     //recalc exten based on its %
            Cmd :=ProcessForm0764Math(doc, 43, CX);  //sum the deprs
          end;
        36:
          begin
            F0764CalcPctLessPhyNFnct(doc, cx);       //recalc the new percent
            Cmd := ProcessForm0764Math(doc, 43, CX);  //sum the deprs
          end;
        37:
          cmd := SubtAB(doc, MCX(cx,27), mcx(cx,34), mcx(cx,35));     //subt depr from cost

        43:
          cmd := SumABC(doc, mcx(cx,29), mcx(cx,31), mcx(cx,33), mcx(cx,34));   //sum depr
        44:
          cmd := InfoSiteTotalRatio(doc, cx, 14,37, 2);
        45:
          cmd := MultAB(doc, mcx(cx,38), mcx(cx,39), mcx(cx,40));    //calc income approach

        46:
          begin
            F0764C1Adjustments(doc, cx);
            F0764C2Adjustments(doc, cx);
            F0764C3Adjustments(doc, cx);
            cmd := 0;
          end;

        51:
          cmd := TransA2B(doc, mcx(cx,252), mcx(cx,253));     //trans sales
        52:
          cmd := TransA2B(doc, mcx(cx,40), mcpx(cx,2,255));   //trans income
        53:
          begin
            ProcessForm0764Math(doc, 44, CX);
            cmd := TransA2B(doc, mcx(cx,37), MCPX(cx,2,254));   //trans cost
          end;
        54:
          cmd := TransA2B(doc, mcx(cx,253), MCX(cx,262));     //indicated value
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
          CX.pg := 1;    //math is on page 2 (zero based)
          ProcessForm0764Math(doc, 46, CX);
        end;
    end;

  result := 0;
end;

{  Appraisal Order  610}

function F610LenderSameAsRequester(doc: TContainer; CX: CellUID): Integer;
var
  i,j: Integer;
begin
  if CellIsChecked(doc, mcx(cx, 50))   then
      for i:=14 to 24  do
         TransA2B(doc, mcx(cx, i), mcx(cx,i+37))
  else
        for j:=51 to 61  do
          SetCellString(doc, MCX(cx,j), '');
  result := 0;
end;

function F610LoanPurpose(doc: TContainer; CX: CellUID): Integer;
var
  tStr: String;
begin
  tStr := '';
  if CellIsChecked(doc, mcx(cx, 26)) then
    begin
      tStr := 'Purchase';
      SetCellChkMark(doc,  MCFX(doc.docForm.indexOf(doc.GetFormByOccurance(340,0,false)), 1, 32), True);
    end
  else if CellIsChecked(doc, mcx(cx,27)) then
    begin
      tStr := 'Refinance';
      SetCellChkMark(doc,  MCFX(doc.docForm.indexOf(doc.GetFormByOccurance(340,0,false)), 1, 33), True);
    end;
  result := SetCellString(doc, mcx(cx, 129), tStr);
end;


function F610OwnerOccupant(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 91)) then
    result := SetCellChkMark(doc,  MCFX(doc.docForm.indexOf(doc.GetFormByOccurance(340,0,false)), 1, 20), True)
  else if CellIsChecked(doc, mcx(cx,92)) then
    result := SetCellChkMark(doc,  MCFX(doc.docForm.indexOf(doc.GetFormByOccurance(340,0,false)), 1, 21), True)
  else if CellIsChecked(doc, mcx(cx,93)) then
    result := SetCellChkMark(doc,  MCFX(doc.docForm.indexOf(doc.GetFormByOccurance(340,0,false)), 1, 22), True)
  else
    result := 0;
end;

{  610 ???? }

function ProcessForm0610Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := F610LenderSameAsRequester(doc, CX);
        2:
          Cmd := F610OwnerOccupant(doc, CX);
        3:
          Cmd := F610LoanPurpose(doc, CX);
      else
        Cmd := 0;
      end;
    until Cmd = 0;
  result := 0;
end;

{  1075 Exterior Inspection Condo Unit  }

function ProcessForm0347Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,31), mcx(cx,32), mcpx(cx,3,23));
        2:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,31), ProcessForm0347Math); //github #179: use effdate
        3:  Cmd := MultAByVal(doc, mcx(cx,30), mcx(cx,31), 12.0);       //annual unit charge
        4:  Cmd := DivideAB(doc, mcx(cx,31), mcx(cx,86), mcx(cx,32));   //annual unit change /GLA
        5:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        6:
          Cmd := DivideAB(doc, mcx(cx,55), mcx(cx,92), mcx(cx,56));       //C1 Price/GLA
        7:
          Cmd := DivideAB(doc, mcx(cx,123), mcx(cx,160), mcx(cx,124));    //c2 Price/GLA
        8:
          Cmd := DivideAB(doc, mcx(cx,191), mcx(cx,228), mcx(cx,192));    //C3 Price/GLA
        9:
          Cmd := F0347C1Adjustments(doc, CX);
        10:
          Cmd := F0347C2Adjustments(doc, CX);
        11:
          Cmd := F0347C3Adjustments(doc, CX);
        12:
          Cmd := DivideAB(doc, mcx(cx,15), mcx(cx,36), mcx(cx,16));       //subj Price/GLA
        13:
          Cmd := ProcessMultipleCmds(ProcessForm0347Math, doc, CX, [14,8]); //multiple process C1
        14:
          Cmd := ProcessMultipleCmds(ProcessForm0347Math, doc, CX, [15,9]); //multiple process C2
        15:
          Cmd := ProcessMultipleCmds(ProcessForm0347Math, doc, CX, [16,10]); //multiple process C3
        16:
          Cmd := CalcWeightedAvg(doc, [347,367]);   //calc wtAvg of main and xcomps forms
        17:
          Cmd := MultAB(doc, mcx(cx,256), mcx(cx,257), mcx(cx,258));    //income approach
        18:
          cmd := F0347HeatingCooling(doc, cx); //cooling/heating
        19:
          cmd := F0347Fireplaces(doc, cx); //fireplaces
        20:
          cmd := F0347PatioDeckPorch(doc, cx); //deck/patio
        21:
          cmd := F0347NoCarGarage(doc, cx); //no garage
        22:
          cmd := F0347CarStorage(doc, cx); //car storage count
        23:
          begin
            F0347C1Adjustments(doc, CX);
            F0347C2Adjustments(doc, CX);
            F0347C3Adjustments(doc, CX);
            cmd := 0;
          end;
        24:
          Cmd := LandUseSum(doc, CX, 2, [79,80,81,82,84]);
        25:
          Cmd := TransA2B(doc, mcx(cx,255), mcx(cx,260));  //trans sales
        26:
          cmd := TransA2B(doc, mcx(cx,258), mcx(cx,261));  //trans income
        27:
          Cmd := TransA2B(doc, mcx(cx,260), mcx(cx,268));  //indicated value
        28:
          cmd := ProcessMultipleCmds(ProcessForm0347Math, doc, CX, [29,30]);
        29:
          Cmd := F0347HOATransfer(doc, CX, 28,29,30, 24);
        30:
          cmd := F0347UnitChargeTransfer(doc, CX, 28,29,30, 30);
        31:
          cmd := F0347Woodstove(doc, cx);
        32:
          cmd := F0347OtherAmenity(doc, cx);
        90:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0347UADDesignStyle(doc, CX)        //transfer UAD design-style to grid
          else
            Cmd := 0;
        91:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            Cmd := F0347UADGridDesignStyle(doc, CX)    //transfer UAD design-style from grid
          else
            Cmd := 0;
        92:
          if doc.UADEnabled and Assigned(doc.docActiveCell) and IsUADCellActive(doc.docActiveCell.FCellXID) then
            cmd := F0347UADGridCarStorage(doc, cx)     //car storage counts from grid
          else
            Cmd := 0;
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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0347Math(doc, 23, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE - NO MATH FOR THSI FORM

{  1075 Exterior Inspection Condo Unit Certification  }

function ProcessForm0348Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;
*)

{  2095 Exterior Inspection CoOp  }

function ProcessForm0353Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := YearToAge2(doc, CX, MCPX(CX,3,33), ProcessForm0353Math); //github #179
        2:  cmd := F0353TransUnits(doc, CX);
        3:  Cmd := 0;   //transfer shares to grid
        4:  Cmd := MultAByVal(doc, mcx(cx,81), mcx(cx,82), 12.0);       //maintenace/year
        5:  Cmd := DivideAB(doc, mcx(cx,82), mcx(cx,66), mcx(cx, 83));  //maintenance/GLA
        6:  Cmd := F0353Fireplaces(doc, cx);          //transfer to grid
        7:  Cmd := F0353PatioDeckPorch(doc, CX);      //trasnfer to grid
        8:  Cmd := F0353HeatingCooling(doc, CX);      //transfer to grid
        9:  Cmd := F0353NoCarGarage(doc, CX);         //clears out car storage cells
        10: Cmd := F0353CarStorage(doc, CX);          //transfer to  grid
        11:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,40), mcx(cx,15));     //Subj price/sqft
        12:
          cmd := DivideAB(doc, mcx(cx,58), mcx(cx,104), mcx(cx,59));     //C1 price/sqft
        13:
          cmd := DivideAB(doc, mcx(cx,134), mcx(cx,180), mcx(cx,135));  //C2 price/sqft
        14:
          cmd := DivideAB(doc, mcx(cx,210), mcx(cx,256), mcx(cx,211));  //C3 price/sqft
        15:
          Cmd := F0353C1Adjustments(doc, cx);
        16:
          Cmd := F0353C2Adjustments(doc, cx);
        17:
          Cmd := F0353C3Adjustments(doc, cx);
        18:
          cmd := DivideAB(doc, mcx(cx,14), mcx(cx,40), mcx(cx,15));     //Subj price/sqft
        19:
          cmd := ProcessMultipleCmds(ProcessForm0353Math, doc, CX, [12,15]); //C1 sales price
        20:
          cmd := ProcessMultipleCmds(ProcessForm0353Math, doc, CX, [13,16]); //C2 sales price
        21:
          cmd := ProcessMultipleCmds(ProcessForm0353Math, doc, CX, [14,17]); //C3 sales price
        22:
          Cmd := CalcWeightedAvg(doc, [353,366]);   //calc wtAvg of main and xcomps forms
        23:
          begin
            F0353C1Adjustments(doc, cx);
            F0353C2Adjustments(doc, cx);
            F0353C3Adjustments(doc, cx);
            cmd := 0;
          end;
        24:
          Cmd := LandUseSum(doc, CX, 2, [75,76,77,78,80]);
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
          CX.pg := 2;    //math is on page 2
          ProcessForm0353Math(doc, 23, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE - NO MATH FOR THIS FORM

{  2095 Exterior Inspection CoOp Certification  }

function ProcessForm0354Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;
*)

{  2000 Review One Unit Residential  }

function ProcessForm0357Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:
          Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,16), mcx(cx,17), mcpx(cx,2,17));
        3:
          cmd := DivideAB(doc, mcx(cx,9), mcx(cx,27), mcx(cx,10));      //Subj price/sqft
        4:
          cmd := DivideAB(doc, mcx(cx,44), mcx(cx,75), mcx(cx,45));     //C1 price/sqft
        5:
          cmd := DivideAB(doc, mcx(cx,104), mcx(cx,135), mcx(cx,105));   //C2 price/sqft
        6:
          cmd := DivideAB(doc, mcx(cx,164), mcx(cx,195), mcx(cx,165));  //C3 price/sqft
        7:
          cmd := ProcessMultipleCmds(ProcessForm0357Math, doc, CX, [4,10]); //C1 sales price
        8:
          cmd := ProcessMultipleCmds(ProcessForm0357Math, doc, CX, [5,11]); //C2 sales price
        9:
          cmd := ProcessMultipleCmds(ProcessForm0357Math, doc, CX, [6,12]); //C3 sales price
        10:
          Cmd := F0357C1Adjustments(doc, cx);
        11:
          Cmd := F0357C2Adjustments(doc, cx);
        12:
          Cmd := F0357C3Adjustments(doc, cx);
        13:
          Cmd := CalcWeightedAvg(doc, [357,4150]);   //calc wtAvg of main and xcomps forms
        14:
          begin
            F0357C1Adjustments(doc, cx);
            F0357C2Adjustments(doc, cx);
            F0357C3Adjustments(doc, cx);
            Cmd := 0;
          end;
      else
        Cmd := 0;
      end;
    until Cmd = 0
  else
    case Cmd of //special processing (negative cmds)
      UpdateNetGrossID:
        begin
          CX.pg := 1;    //math is on page 2
          ProcessForm0357Math(doc, 14, CX);
        end;
      WeightedAvergeID:
        begin
          CX.pg := 1;    //math is on page 2(zero based)
          ProcessForm0357Math(doc, 14, CX);
        end;
    end;

  result := 0;
end;

{  2000 Review One Unit Residential Instructions  }

function ProcessForm0358Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE - NO MATH FOR THIS FORM

{  2000 Review One Unit Residential Certification  }

function ProcessForm0359Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;
*)

{  2000A Review 2-4 Unit Residential  }

function ProcessForm0360Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1:  Cmd := XferFeeSimpleLeaseHold(doc, mcx(cx,16), mcx(cx,17), MCPX(CX,3,22));
        4:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[9,16,20,24]);    //process Sub
        5:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[10,13,17,21,25]);       //process C1
        6:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[11,14,18,22,26]);       //process C3
        7:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[12,15,19,23,27]);       //process C3
        8:
          cmd := CalcWeightedAvg(doc, [360,364]);   //calc wtAvg of main and xcomps forms
        9:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,29), mcx(cx,8));       //Subj price/sqft
        10:
          cmd := DivideAB(doc, mcx(cx,58), mcx(cx,91), mcx(cx,59));       //C1 price/sqft
        11:
          cmd := DivideAB(doc, mcx(cx,140), mcx(cx,173), mcx(cx,141));    //C2 price/sqft
        12:
          cmd := DivideAB(doc, mcx(cx,222), mcx(cx,255), mcx(cx,223));    //C3 price/sqft

        13:
          cmd := F0360C1Adjustments(doc, cx);       //C1 sum of adjs
        14:
          cmd := F0360C2Adjustments(doc, cx);       //C2 sum of adjs
        15:
          cmd := F0360C3Adjustments(doc, cx);       //C3 sum of adjs

    //sale per rent (rent multiplier)
        16:
          cmd := DivideAB(doc, mcx(cx,7), mcx(cx,9), mcx(cx,10));    //sub rent chged
        17:
          cmd := DivideAB(doc, mcx(cx,58), mcx(cx,60), mcx(cx,61));    //C1 rent chged
        18:
          cmd := DivideAB(doc, mcx(cx,140), mcx(cx,142), mcx(cx,143));    //C2 rent chged
        19:
          cmd := DivideAB(doc, mcx(cx,222), mcx(cx,224), mcx(cx,225));    //C3 rent chged
    //sales per unit and total rooms
        20:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 7, 30,33,36,39, 11,12);  //sub units chged
        21:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 58, 94,98,102,106, 62,63);  //C1 units chged
        22:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 140, 176,180,184,188, 144,145);  //C2 units chged
        23:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 222, 258,262,266,270, 226,227);  //C3 units chged
     //sales per bedroom
        24:
          cmd := IncomeSalePerBedRoom(doc, cx, 7, 31,34,37,40, 13);  //sub rooms chged
        25:
          cmd := IncomeSalePerBedRoom(doc, cx, 58, 95,99,103,107, 64);  //C1 rooms chged
        26:
          cmd := IncomeSalePerBedRoom(doc, cx, 140, 177,181,185,189, 146);  //C2 rooms chged
        27:
          cmd := IncomeSalePerBedRoom(doc, cx, 222, 259,263,267,271, 228);  //C3 rooms chged

      //adj sales price per unit and total rooms
        28:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 133, 94,98,102,106, 134,135);  //C1 units chged
        29:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 215, 176,180,184,188, 216,217);  //C2 units chged
        30:
          cmd := IncomeSalePerUnitNRoom(doc, cx, 297, 258,262,266,270, 298,299);  //C3 units chged

      //adj sales price per bedroom
        31:
          cmd := IncomeSalePerBedRoom(doc, cx, 133, 95,99,103,107, 136);  //C1 rooms chged
        32:
         // cmd := IncomeSalePerBedRoom(doc, cx, 215, 177,181,185,1894, 218);  //C2 rooms chged
          cmd := IncomeSalePerBedRoom(doc, cx, 215, 177,181,185,189, 218);  //C2 rooms chged
        33:
          cmd := IncomeSalePerBedRoom(doc, cx, 297, 259,263,267,271, 300);  //C3 rooms chged

      //adj sales prices
        34: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[8,28,31]);   //C1
        35: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[8,29,32]);   //C2
        //36: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[8,30,33]);   //C3

      //calc $/unit & rooms
        37: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[21,28]); //C1 units
        38: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[22,29]); //C2 units
        39: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[23,30]); //C3 units

        40: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[25,31]); //C1 bedrooms
        41: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[26,32]); //C2 bedrooms
        42: Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[27,33]); //C3 bedrooms

        43:
          begin
            F0360C1Adjustments(doc, cx);
            F0360C2Adjustments(doc, cx);     //sum of adjs
            F0360C3Adjustments(doc, cx);
            cmd := 0;
          end;

        44:
          Cmd := MultAB(doc, mcx(cx,301), mcx(cx,302), mcx(cx,303));  //value per unit
        45:
          Cmd := MultAB(doc, mcx(cx,304), mcx(cx,305), mcx(cx,306));  //value per room
        46:
          Cmd := MultAB(doc, mcx(cx,307), mcx(cx,308), mcx(cx,309));  //value per GBA
        47:
          Cmd := MultAB(doc, mcx(cx,310), mcx(cx,311), mcx(cx,312));  //value per Bedrooms

        48:
          Cmd := MultAB(doc, mcx(cx,314), mcx(cx,315), mcx(cx,316));  //Income approach

        49:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[8,9,30,33]);
        50:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[10]);
        51:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[11]);
        52:
          Cmd := ProcessMultipleCmds(ProcessForm0360Math, doc, CX,[12]);

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
          CX.pg := 2;    //math is on page 3 (zero based)
          ProcessForm0360Math(doc, 43, CX);
        end;
    end;

  result := 0;
end;

{ Manufactured Home Xtra Comps}

function ProcessForm0365Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 48,111,174);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 48,111,174, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,111,174);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0365Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F0365C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F0365C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,85), mcx(cx,53));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm0365Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F0365C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F0365C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,115), mcx(cx,148), mcx(cx,116));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm0365Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F0365C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0365C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,178), mcx(cx,211), mcx(cx,179));     //price/sqft

        14:
          cmd := CalcWeightedAvg(doc, [342,365]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0365C1Adjustments(doc, cx);
            F0365C2Adjustments(doc, cx);     //sum of adjs
            F0365C3Adjustments(doc, cx);
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
          ProcessForm0365Math(doc, 6, CX);
          ProcessForm0365Math(doc, 9, CX);
          ProcessForm0365Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0365Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

{  2000A Review 2-4 Unit Residential Certification  }

function ProcessForm0361Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
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
        //  CX.pg := 1;    //math is on page 2
        //  ProcessForm0147Math(doc, 29, CX);
        end;
    end;

  result := 0;
end;

(*
//REMOVE - NO MATH FOR THIS FORM
{  2055 Exterior Inspection Residential Certification  }

function ProcessForm0356Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: Cmd := 0;
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;
*)

function ProcessForm0835Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAByVal(doc, mcx(cx, 10), mcx(cx, 16), 6);
        2: cmd := DivideAByVal(doc, mcx(cx, 11), mcx(cx, 17), 3);
        3: cmd := DivideAByVal(doc, mcx(cx, 12), mcx(cx, 18), 3);
        4: cmd := DivideAB(doc, mcx(cx, 22), mcx(cx, 16), mcx(cx, 28));
        5: cmd := DivideAB(doc, mcx(cx, 23), mcx(cx, 17), mcx(cx, 29));
        6: cmd := DivideAB(doc, mcx(cx, 24), mcx(cx, 18), mcx(cx, 30));
        7: cmd := DivideAB(doc, mcx(cx, 45), mcx(cx, 33), mcx(cx, 57));
        8: cmd := DivideAB(doc, mcx(cx, 46), mcx(cx, 34), mcx(cx, 58));
        9: cmd := DivideAB(doc, mcx(cx, 47), mcx(cx, 35), mcx(cx, 59));
        10: cmd := DivideAByVal(doc, mcx(cx, 76), mcx(cx, 82), 6);
        11: cmd := DivideAByVal(doc, mcx(cx, 77), mcx(cx, 83), 3);
        12: cmd := DivideAByVal(doc, mcx(cx, 78), mcx(cx, 84), 3);
        13: cmd := DivideAB(doc, mcx(cx, 88), mcx(cx, 82), mcx(cx, 94));
        14: cmd := DivideAB(doc, mcx(cx, 89), mcx(cx, 83), mcx(cx, 95));
        15: cmd := DivideAB(doc, mcx(cx, 90), mcx(cx, 84), mcx(cx, 96));
       else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function ProcessForm0850Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        1: cmd := DivideAByVal(doc, mcx(cx, 10), mcx(cx, 16), 6);
        2: cmd := DivideAByVal(doc, mcx(cx, 11), mcx(cx, 17), 3);
        3: cmd := DivideAByVal(doc, mcx(cx, 12), mcx(cx, 18), 3);
        4: cmd := DivideAB(doc, mcx(cx, 22), mcx(cx, 16), mcx(cx, 28));
        5: cmd := DivideAB(doc, mcx(cx, 23), mcx(cx, 17), mcx(cx, 29));
        6: cmd := DivideAB(doc, mcx(cx, 24), mcx(cx, 18), mcx(cx, 30));
        //7: cmd := DivideAB(doc, mcx(cx, 45), mcx(cx, 33), mcx(cx, 57));
        //8: cmd := DivideAB(doc, mcx(cx, 46), mcx(cx, 34), mcx(cx, 58));
        //9: cmd := DivideAB(doc, mcx(cx, 47), mcx(cx, 35), mcx(cx, 59));
        10: cmd := DivideAByVal(doc, mcx(cx, 76), mcx(cx, 82), 6);
        11: cmd := DivideAByVal(doc, mcx(cx, 77), mcx(cx, 83), 3);
        12: cmd := DivideAByVal(doc, mcx(cx, 78), mcx(cx, 84), 3);
        13: cmd := DivideAB(doc, mcx(cx, 88), mcx(cx, 82), mcx(cx, 94));
        14: cmd := DivideAB(doc, mcx(cx, 89), mcx(cx, 83), mcx(cx, 95));
        15: cmd := DivideAB(doc, mcx(cx, 90), mcx(cx, 84), mcx(cx, 96));
       else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

function F0949NoBasement(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(cx, 137)) or CellIsChecked(doc, mcx(cx,138)) then
    begin
      SetCellChkMark(doc, Mcx(cx,139), False);
      SetCellChkMark(doc, Mcx(cx,140), False);
      SetCellString(doc, Mcx(cx,141), '');
      SetCellString(doc, Mcx(cx,142), '');
    end;
  result := 0;
end;

function F0949Basement(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, 141));
  if CellIsChecked(doc, mcx(cx, 139)) or CellIsChecked(doc, mcx(cx,140)) or (V1 <> 0) then
    begin
      SetCellChkMark(doc, Mcx(cx,137), False);
      SetCellChkMark(doc, Mcx(cx,138), False);
    end;
  result := 0;
end;

function F0949NoCarStorage(doc: TContainer; CX: CellUID): Integer;
begin
  if CellIsChecked(doc, mcx(CX, 161)) then
    begin
      SetCellChkMark(doc, Mcx(cx,162), False);
      SetCellString(doc, MCX(CX, 163), '');
    end;
  result := 0;
end;

function F0949CarStorage(doc: TContainer; CX: CellUID): Integer;
var
  V1: Double;
begin
  V1 := GetCellValue(doc, mcx(cx, 163));
  if CellIsChecked(doc, mcx(CX, 162)) or (V1 <> 0) then
    begin
      SetCellChkMark(doc, Mcx(cx,161), False);
      SetCellChkMark(doc, Mcx(cx,162), True);
    end;  
  result := 0;
end;

function ProcessForm0949Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        2:  Cmd := SiteDimension(doc, CX, MCX(cx,83));
        6:  Cmd := F0949Basement(doc, CX);             //toggle foundation/basement
        7:  Cmd := F0949NoBasement(doc, CX);           //toggle basement/no basement
        8:  Cmd := F0949NoCarStorage(doc, CX);         //clears out cells when no storage
        9:  Cmd := F0949CarStorage(doc, CX);           //sets cells when storage
        16: Cmd := F0949Basement(doc, CX);
        17: Cmd := LandUseSum(doc, CX, 2, [73,74,75,76,78]);
        54:
          cmd := TransA2B(doc, mcx(cx,15), MCX(cx,26));  //indicated value
      else
        Cmd := 0;
      end;
    until Cmd = 0;

  result := 0;
end;

//Non Lender Mobile Home
function F4085C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,35));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
//  result := SalesGridAdjustment(doc, CX, 38,81,82,79,80,1,2,  //PAM ticket #1013
  result := SalesGridAdjustment(doc, CX, 38,81,82,79,80,4,5,
    [43, 45, 47, 49, 51, 52, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78],length(addr) > 0);
end;

function F4085C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,84));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
//  result := SalesGridAdjustment(doc, CX, 87, 130, 131, 128, 129, 3, 4,
  result := SalesGridAdjustment(doc, CX, 87, 130, 131, 128, 129, 6, 7,   //PAM: Ticket #1013
    [92, 94, 96, 98, 100, 101, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127],length(addr) > 0);
end;

function F4085C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,133));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
//  result := SalesGridAdjustment(doc, CX, 136, 179, 180, 177, 178, 5, 6, //PAM: Ticket #1013
  result := SalesGridAdjustment(doc, CX, 136, 179, 180, 177, 178, 8, 9,
    [141, 143, 145, 147, 149, 150, 154, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176],length(addr) > 0);
end;


function ProcessForm4085Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        2:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 34,83,132);
        1:
          begin
            cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 34,83,132, 2);
          end;
        3:
          cmd := ConfigXXXInstance(doc, cx, 34,83,132);

        //Subject
        29:
          cmd := DivideAB(doc, mcx(cx,8), mcx(cx,20), mcx(cx,9));     //Subj price/sqft

        //Comp1 calcs
        30:   //sales price changed
          begin
            ProcessForm4085Math(doc, 31, CX);        //calc new price/sqft
            Cmd := F4085C1Adjustments(doc, cx);     //redo the adjustments
          end;
        32:
          cmd := F4085C1Adjustments(doc, cx);       //sum of adjs
        31:
          cmd := DivideAB(doc, mcx(cx,38), mcx(cx,57), mcx(cx,39));     //price/sqft

        //Comp2 calcs
        33:   //sales price changed
          begin
            ProcessForm4085Math(doc, 34, CX);     //calc new price/sqft
            Cmd := F4085C2Adjustments(doc, cx);   //redo the adjustments
          end;
        35:
          cmd := F4085C2Adjustments(doc, cx);     //sum of adjs
        34:
          cmd := DivideAB(doc, mcx(cx,87), mcx(cx,106), mcx(cx,88));     //price/sqft

        //Comp3 calcs
        36:   //sales price changed
          begin
            ProcessForm4085Math(doc, 37, CX);     //calc new price/sqft
            Cmd := F4085C3Adjustments(doc, cx);   //redo the adjustments
          end;
        38:
          cmd := F4085C3Adjustments(doc, cx);     //sum of adjs
        37:
          cmd := DivideAB(doc, mcx(cx,136), mcx(cx,155), mcx(cx,137));     //price/sqft

        39:
         // cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main and xcomps forms
          cmd := CalcWeightedAvg(doc, [4085,279]);   //github #1013: calc wtAvg of main and xcomps forms
        40:
          begin
            F4085C1Adjustments(doc, cx);
            F4085C2Adjustments(doc, cx);     //sum of adjs
            F4085C3Adjustments(doc, cx);
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
          ProcessForm4085Math(doc, 32, CX);
          ProcessForm4085Math(doc, 35, CX);
          ProcessForm4085Math(doc, 38, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4085Math(doc, 40, CX);
        end;
    end;

  result := 0;
end;

function ProcessForm4150Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Comps', 48,109,170);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA COMPARABLES','', 48,109,170, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,109,170);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm0363Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F4150C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F4150C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,83), mcx(cx,53));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm4150Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F4150C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F4150C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,144), mcx(cx,114));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm4150Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F4150C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F0363C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,174), mcx(cx,205), mcx(cx,175));     //price/sqft

        14:
          //cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main and xcomps forms
          cmd := CalcWeightedAvg(doc, [4150,357]);   //calc wtAvg of main and xcomps forms
        15:
          begin
            F0363C1Adjustments(doc, cx);
            F0363C2Adjustments(doc, cx);     //sum of adjs
            F0363C3Adjustments(doc, cx);
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
          ProcessForm0363Math(doc, 6, CX);
          ProcessForm0363Math(doc, 9, CX);
          ProcessForm0363Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm0363Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;

//*******************   4313 math starts
//
function F4313C1Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,49));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 52,107,108,105,106,1,2,
    [57,59,61,63,65,67,69,71,73,75,77,78,82,84,86,88,90,92,94,96,98,100,102,104],length(addr) > 0);
end;

function F4313C2Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,110));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 113,168,169,166,167,3,4,
    [118,120,122,124,126,128,130,132,134,136,138,139,143,145,147,149,151,153,155,157,159,161,163,165],length(addr) > 0);
end;

function F4313C3Adjustments(doc: TContainer; CX: CellUID): Integer;
var
  addr: String;
begin
  //github 197, 346: skip if no address
  addr := GetCellString(doc, mcx(cx,171));   //get the address
  //if addr <> '' then  //only calculate if we have address  //github 197
  result := SalesGridAdjustment(doc, CX, 174,229,230,227,228,5,6,
    [179,181,183,185,187,189,191,193,195,197,199,200,204,206,208,210,212,214,216,218,220,222,224,226],length(addr) > 0);
end;


function ProcessForm4313Math(doc: TContainer; Cmd: Integer; CX: CellUID): Integer;
begin
  if Cmd > 0 then
    repeat
      case Cmd of
        //dynamic form name
        1:
          cmd := SetXXXPageTitleBarName(doc, cx, 'Extra Listing', 48,109,170);
        2:
          cmd := SetXXXPageTitle(doc, cx, 'EXTRA LISTING','', 48,109,170, 2);
        3:
          cmd := ConfigXXXInstance(doc, cx, 48,109,170, False);

        //Subject
        4:
          cmd := DivideAB(doc, mcx(cx,16), mcx(cx,34), mcx(cx,17));     //Subj price/sqft

        //Comp1 calcs
        5:   //sales price changed
          begin
            ProcessForm4313Math(doc, 7, CX);        //calc new price/sqft
            Cmd := F4313C1Adjustments(doc, cx);     //redo the adjustments
          end;
        6:
          cmd := F4313C1Adjustments(doc, cx);       //sum of adjs
        7:
          cmd := DivideAB(doc, mcx(cx,52), mcx(cx,83), mcx(cx,53));     //price/sqft

        //Comp2 calcs
        8:   //sales price changed
          begin
            ProcessForm4313Math(doc, 10, CX);     //calc new price/sqft
            Cmd := F4313C2Adjustments(doc, cx);   //redo the adjustments
          end;
        9:
          cmd := F4313C2Adjustments(doc, cx);     //sum of adjs
        10:
          cmd := DivideAB(doc, mcx(cx,113), mcx(cx,144), mcx(cx,114));     //price/sqft

        //Comp3 calcs
        11:   //sales price changed
          begin
            ProcessForm4313Math(doc, 13, CX);     //calc new price/sqft
            Cmd := F4313C3Adjustments(doc, cx);   //redo the adjustments
          end;
        12:
          cmd := F4313C3Adjustments(doc, cx);     //sum of adjs
        13:
          cmd := DivideAB(doc, mcx(cx,174), mcx(cx,205), mcx(cx,175));     //price/sqft

        14:
          //cmd := CalcWeightedAvg(doc, [340,357,355,363,736,761,764,765,3545]);   //calc wtAvg of main, xcomps & xlists forms
          cmd := CalcWeightedAvg(doc, [3545]);   //calc wtAvg of lists forms
        15:
          begin
            F4313C1Adjustments(doc, cx);
            F4313C2Adjustments(doc, cx);     //sum of adjs
            F4313C3Adjustments(doc, cx);
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
          ProcessForm4313Math(doc, 6, CX);
          ProcessForm4313Math(doc, 9, CX);
          ProcessForm4313Math(doc, 12, CX);
        end;
      -2:
        begin
          CX.pg := 0;    //math is on page 1
          ProcessForm4313Math(doc, 15, CX);
        end;
    end;

  result := 0;
end;


//*******************   4313 math ends
//


end.

