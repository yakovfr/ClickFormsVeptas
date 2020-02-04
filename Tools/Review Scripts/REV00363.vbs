'FM00363.vbs 1004 - 2055 - 2000 XComps Reviewer Script
' 04/08/2014: Add more rules:
' Only do the check of date/price sale/transfer for the subject if subject of my research is checked
' Do the same check of date/price sale/transfer for the comp if comp of my research is checked

Sub ReviewForm
  ReviewHeader
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
End Sub


Sub ReviewHeader
  AddTitle String(5,"=") + " EXTRA COMPARABLES HEADING " + String(5,"=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDADDRESS, 1, 7
  Require IDCITY, 1, 8
  Require IDCOUNTY, 1, 9
  Require IDSTATE, 1, 10
  Require IDZIP, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
End Sub

Sub ReviewSalesComparison
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, CellSeq, CellSeq2, _
    num, num2, num3, num4, num5, text1

  AddTitle String(5, "=") + "FNMA 1004/2055/2000 EXTRA COMPARABLES" + String(5, "=")
  Require IDSUBADD, 1, 14
  Require IDSUBCITY, 1, 15
  'Make sure subject address line 2: city, state zip matches with city, state, zip cell values
  If hasText(1, 15) Then
    text1 = Replace(UCase(GetText(1, 15)), " ", "")
    text2 = Replace(UCase(GetText(1, 8)), " ", "")
    text3 = Replace(UCase(GetText(1, 10)), " ", "")
    text4 = Replace(UCase(GetText(1, 11)), " ", "")
    If not text1 = text2 + IDCOMMA + text3 + text4 Then
      AddRec IDADDMATCH, 1, 15
    End If
  End If
  If GetCellUADError(1, 14) or GetCellUADError(1, 15) Then
    AddRec IDADDRESSUADERROR, 1, 14
  End If

  Require IDSUBSALES, 1, 16
  Require IDSUBPRGLA, 1, 17
  If not IsUAD then
    Require IDSUBSOURCE, 1, 18
    Require IDSUBVERSOURCE, 1, 19
    'Require IDSUBSF, 1, 20	'issue 1279
    'Require IDSUBCONC, 1, 21
    'Require IDSUBDOS, 1, 22
  End If
  Require IDSUBLOC, 1, 23
  If GetCellUADError(1, 23) Then
    AddRec IDSUBLOCUADERROR, 1, 23
  End If
  Require IDSUBLEASEHOLD, 1, 24
  Require IDSUBSITE, 1, 25
  If GetCellUADError(1, 25) Then
    AddRec IDSUBSITEUADERROR, 1, 25
  End If
  Require IDSUBVIEW, 1, 26
  If GetCellUADError(1, 26) Then
    AddRec IDSUBVIEWUADERROR, 1, 26
  End If
  Require IDSUBDESIGN, 1, 27
  Require IDSUBQUAL, 1, 28
  If GetCellUADError(1, 28) Then
    AddRec IDSUBQUALUADERROR, 1, 28
  End If
  Require IDSUBAGE, 1, 29
  If GetCellUADError(1, 29) Then
    AddRec IDSUBAGEUADERROR, 1, 29
  End If
  Require IDSUBCOND, 1, 30
  If GetCellUADError(1, 30) Then
    AddRec IDSUBCONDUADERROR, 1, 30
  End If
  Require IDSUBROOMS, 1, 31
  If GetCellUADError(1, 31) Then
    AddRec IDSUBROOMSUADERROR, 1, 31
  End If
  Require IDSUBBED, 1, 32
  If GetCellUADError(1, 32) Then
    AddRec IDSUBBEDUADERROR, 1, 32
  End If
  Require IDSUBBATHS, 1, 33
  If GetCellUADError(1, 33) Then
    AddRec IDSUBBATHSUADERROR, 1, 33
  End If
  Require IDSUBGLA, 1, 34
  Require IDSUBBASE, 1, 35
  If GetCellUADError(1, 35) Then
    AddRec IDSUBBASEUADERROR, 1, 35
  End If
  If not ((GetText(1, 35) = "0sf") or (GetText(1, 35) = "0sqm")) Then
    Require IDSUBBASEPER, 1, 36
  End If
  If GetCellUADError(1, 36) Then
    AddRec IDSUBBASEPERUADERROR, 1, 36
  End If
  Require IDSUBFUNC, 1, 37
  Require IDSUBHEAT, 1, 38
  Require IDSUBENERGY, 1, 39
  Require IDSUBGARAGE, 1, 40
  If IsUAD and hasText(1, 40) Then
    Text1 = GetText(1, 40)
    num = InStr(1, Text1, "ga")
    num2 = InStr(1, Text1, "gd")
    num3 = InStr(1, Text1, "gbi")
    num4 = InStr(1, Text1, "cp")
    num5 = InStr(1, Text1, "dw")
    If not NumOrderIsOK(num, num2, num3, num4, num5) Then
      AddRec IDSUBRESIDFORMAT, 1, 40
    End If
  End If
  Require IDSUBPORCH, 1, 41

  Require IDDATEPSTSUB, 1, 231
  If GetCellUADError(1, 231) Then
    AddRec IDDATEPSTSUBUADERROR, 1, 231
  End If
  Require IDPRICEPSTSUB, 1, 232
  Require IDDATASOURCESUB, 1, 233
  Require IDDATASOURCEDATESUB, 1, 234
  If GetCellUADError(1, 234) Then
    AddRec IDDATASRCDATESUBUADERROR, 1, 234
  End If

  For FldCntr = 48 to 170 Step 61
    Require FormCompNumErrStr(IDCOMP1ID, 1, FldCntr), 1, FldCntr
    CellSeq = (FldCntr+1)
    CellSeq2 = (FldCntr+2)
    If (GetText(1, CellSeq) <> "") or (GetText(1, CellSeq2) <> "") then
      Require FormCompNumErrStr(IDCOMP1ADD, 1, FldCntr), 1, CellSeq
      Require FormCompNumErrStr(IDCOMP1UNITNO, 1, FldCntr), 1, CellSeq2
      If GetCellUADError(1, CellSeq) or GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDCOMP1ADDRUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDCOMP1PROX, 1, FldCntr), 1, (FldCntr+3)
      Require FormCompNumErrStr(IDCOMP1SALES, 1, FldCntr), 1, (FldCntr+4)
      Require FormCompNumErrStr(IDCOMP1PRGLA, 1, FldCntr), 1, (FldCntr+5)
      Require FormCompNumErrStr(IDCOMP1SOURCE, 1, FldCntr), 1, (FldCntr+6)
      CellSeq = (FldCntr+6)
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1DATASRCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDCOMP1VER, 1, FldCntr), 1, (FldCntr+7)
      CellSeq = (FldCntr+8)
      Require FormCompNumErrStr(IDCOMP1SF, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1SFUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+10)
      Require FormCompNumErrStr(IDCOMP1CONC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1CONCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+12)
      Require FormCompNumErrStr(IDCOMP1DOS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1DOSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+14)
      Require FormCompNumErrStr(IDCOMP1LOC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1LOCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDCOMP1LEASEHOLD, 1, FldCntr), 1, (FldCntr+16)
      CellSeq = (FldCntr+18) 
      
      Require FormCompNumErrStr(IDCOMP1SITE, 1, FldCntr), 1, CellSeq
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(1, 25) and hasText(1, CellSeq) then  'we have subject & comp GLA
        cSiteArea = GetValue(1, CellSeq)
        sSiteArea = GetValue(1, 25)

        If sSiteArea > 0 then
          num = (cSiteArea - sSiteArea)/sSiteArea
          If (Abs(num) > 0.20) and (cSiteArea > sSiteArea)then
            AddRec FormCompNumErrStr(IDCOMPSITERANGE, 0, GridIndex), 1, (FldCntr+18)
          End If
          If (ABs(num) > 0.20) and (cSiteArea < sSiteArea) then
            AddRec FormCompNumErrStr(IDCOMPSITERANGE, 0, GridIndex), 1, (FldCntr+18)
          End If
        End If
      End If
      
      CellSeq = (FldCntr+20)
      Require FormCompNumErrStr(IDCOMP1VIEW, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1VIEWUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDCOMP1DESIGN, 1, FldCntr), 1, (FldCntr+22)
      CellSeq = (FldCntr+24)
      Require FormCompNumErrStr(IDCOMP1QUAL, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1QUALUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+26)
      Require FormCompNumErrStr(IDCOMP1AGE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1AGEUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+28)
      Require FormCompNumErrStr(IDCOMP1COND, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1CONDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+31)
      Require FormCompNumErrStr(IDCOMP1ROOMS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1ROOMSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+32)
      Require FormCompNumErrStr(IDCOMP1BED, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1BEDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+33)
      Require FormCompNumErrStr(IDCOMP1BATHS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1BATHSUADERROR, 1, FldCntr), 1, CellSeq
      End If

      CellSeq = (FldCntr+35)
      Require FormCompNumErrStr(IDCOMP1GLA, 1, FldCntr), 1, CellSeq
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(1, 34) and hasText(1, CellSeq) then  'we have subject & comp GLA
        cGLA = GetValue(1, CellSeq)
        sGLA = GetValue(1, 34)

        If sGLA > 0 then
          num = (cGLA - sGLA)/sGLA
          If (Abs(num) > 0.20) and (cGLA > sGLA)then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1G, 1, FldCntr), 1, CellSeq
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1L, 1, FldCntr), 1, CellSeq
          End If
        End If
      End If

      CellSeq = (FldCntr+37)
      Require FormCompNumErrStr(IDCOMP1BASE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEUADERROR, 1, FldCntr), 1, CellSeq
      End If

      CellSeq2 = (FldCntr+39)
      If not ((GetText(1, CellSeq) = "0sf") or (GetText(1, CellSeq) = "0sqm")) Then
        Require FormCompNumErrStr(IDCOMP1BASEPER, 1, FldCntr), 1, CellSeq2
      End If
      If GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEPERUADERROR, 1, FldCntr), 1, CellSeq2
      End If
      Require FormCompNumErrStr(IDCOMP1FUNC, 1, FldCntr), 1, (FldCntr+41)
      Require FormCompNumErrStr(IDCOMP1HEAT, 1, FldCntr), 1, (FldCntr+43)
      CellSeq = (FldCntr+45)
      Require FormCompNumErrStr(IDCOMP1ENERGY, 1, FldCntr), 1, CellSeq
      If not IsEnergyEfficientOK(1, CellSeq) then
        AddRec FormCompNumErrStr(IDCOMP1ENERGYBAD, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDCOMP1GARAGE, 1, FldCntr), 1, (FldCntr+47)
      If IsUAD and hasText(1, (FldCntr+47)) Then
        Text1 = GetText(1, (FldCntr+47))
        num = InStr(1, Text1, "ga")
        num2 = InStr(1, Text1, "gd")
        num3 = InStr(1, Text1, "gbi")
        num4 = InStr(1, Text1, "cp")
        num5 = InStr(1, Text1, "dw")
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDCOMP1RESIDFORMAT, 1, FldCntr), 1, (FldCntr+47)
        End If
      End If
      Require FormCompNumErrStr(IDCOMP1PORCH, 1, FldCntr), 1, (FldCntr+49)
    End If
  Next

  GridIndex = 0
  CompAddrList = Array(49,110,171)
  For FldCntr = 235 to 245 Step 5
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    Require FormCompNumErrStr(IDCOMP1ID, 1, FldCntr), 1, FldCntr
    If (GetText(1, CompAddrSeq) <> "") or (GetText(1, (CompAddrSeq+1)) <> "") then
      CellSeq = (FldCntr+1)
      Require FormCompNumErrStr(IDDATEPSTCOMP1, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDDATEPSTCOMP1UADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDPRICEPSTCOMP1, 1, FldCntr), 1, (FldCntr+2)
      Require FormCompNumErrStr(IDDATASOURCECOMP1, 1, FldCntr), 1, (FldCntr+3)
      CellSeq = (FldCntr+4)
      Require FormCompNumErrStr(IDDATASOURCEDATECOMP1, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDDATASRCDATECOMP1UADERROR, 1, FldCntr), 1, CellSeq
      End If
    End If  
  Next

  Require IDANALYSIS2, 1, 250
  Require IDSUMMARYSALES, 1, 251

End Sub



