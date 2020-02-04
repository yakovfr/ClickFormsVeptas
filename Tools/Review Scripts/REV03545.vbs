'FM03545.vbs - FNAM1004XListings
' Created.
' 03/28/2013: Add more rules
' When a sale or listing is greater than or less than 20% of the subject's GLA, show warning.
' 03/25/2013: Add more rules
' Comment out the checking of Fireplace, pool and additional items
' Make sure subject address line 2 city, state, zip matches with city, state, and zip cell values
' Make sure Subject Listing Price is bracketed by Comp. sales price
' Make sure Subject Listing Price is bracketed by Comp. gross adjustment %
' Make sure Subjecg GLA is bracketed by Comp. GLA
' Make sure Subject condition is matched or bracketed by comparable condition.

' 01/14/2013: Add Sales Concession to Subject and 3 Comps
' 01/17/2013: Put the report name in the header and remove report name from each section header
' 01/22/2013: Fix ValidateSalesComp to replace onlyonecheckoftwo with real check the cell #  for comp1 net adjust check: 88-41=47,...

Sub ReviewForm
  ReviewHeader
  AddTitle ""
  ReviewListingComparison
  AddTitle ""
End Sub

Sub ReviewHeader
  AddTitle String(5,"=") + " EXTRA COMPARABLE LISTINGS HEADER " + String(5,"=")
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

Sub ReviewListingComparison
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, CellSeq, CellSeq2

  AddTitle String(5, "=") + " EXTRA COMPARABLE LISTINGS" + String(5, "=")
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
    If GetCellUADError(1, 14) or GetCellUADError(1, 15) Then
      AddRec IDADDRESSUADERROR, 1, 14
    End If
  End If

  Require IDSUBLISTPR, 1, 16
  Require IDSUBLISTPRGLA, 1, 17
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

  'Make sure Subject condition is matched or bracketed by comparable condition.
  'At least one comp the same condition of the subject?
  'Following commented 7/18/2013: This does not work - comps on other forms may have a matching condition
  'AG_COND123 = "AT LEAST ONE COMP SHOULD BE IN THE SAME CONDITION AS THE SUBJECT. " & _
  '             "You may need to expand your parameters to include at least one comp " & _
  '             "in your report in similar condition."
  'If hasText(1,30) Then
  '  If hasText(1,76) and strComp(GetText(1,30), GetText(1,70)) <> 0 Then
  '    If hasText(1,137)  and (strComp(GetText(1,30), GetText(1,137)) <> 0) Then
  '      If hasText(1,198)  and (strComp(GetText(1,30), GetText(1,198)) <> 0) Then
  '        AddRec AG_COND123, 1, 30
  '      End If
  '    End If
  '  End If
  'End If

  'Make sure subject GLA is bracketed by  comp. gla.
  'is subject in the range of min and max?
  'Following commented 7/18/2013: This does not work - comps on other forms may have a matching GLAs
  'gSub = GetValue(1,34)
  'gComp1 = GetValue(1,83)
  'gComp2 = GetValue(1,144)
  'gComp3 = GetValue(1,205)
  'min=minof3(gComp1,gComp2,gComp3)
  'max=maxof3(gComp1,gComp2,gComp3)
  'GSU_SF_GLA = "THE SUBJECT'S GLA IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
  'If gSub < min or gSub > max Then  'out of range
  '  AddRec GSU_SF_GLA, 1, 34
  'End If

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
    Require FormCompNumErrStr(IDLIST1ID, 1, FldCntr), 1, FldCntr
    CellSeq = (FldCntr+1)
    CellSeq2 = (FldCntr+2)
    If (GetText(1, CellSeq) <> "") or (GetText(1, CellSeq2) <> "") then
      Require FormCompNumErrStr(IDLIST1ADD, 1, FldCntr), 1, CellSeq
      Require FormCompNumErrStr(IDLIST1ADD2, 1, FldCntr), 1, CellSeq2
      If GetCellUADError(1, CellSeq) or GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDLIST1ADDRUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1PROX, 1, FldCntr), 1, (FldCntr+3)
      Require FormCompNumErrStr(IDLIST1PR, 1, FldCntr), 1, (FldCntr+4)
      Require FormCompNumErrStr(IDLIST1PRGLA, 1, FldCntr), 1, (FldCntr+5)
      CellSeq = (FldCntr+6)
      Require FormCompNumErrStr(IDLIST1SOURCE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1DATASRCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1VER, 1, FldCntr), 1, (FldCntr+7)
      CellSeq = (FldCntr+8)
      Require FormCompNumErrStr(IDLIST1SF, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1SFUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+10)
      Require FormCompNumErrStr(IDLIST1CONC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1CONCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+12)
      Require FormCompNumErrStr(IDLIST1DOS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1DOSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+14)
      Require FormCompNumErrStr(IDLIST1LOC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1LOCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1LEASEHOLD, 1, FldCntr), 1, (FldCntr+16)
      CellSeq = (FldCntr+18)  
      
      Require FormCompNumErrStr(IDLIST1SITE, 1, FldCntr), 1, CellSeq
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(1, 25) and hasText(1, CellSeq) then  'we have subject & comp GLA
        cSiteArea = GetValue(1, CellSeq)
        sSiteArea = GetValue(1, 25)

        If sSiteArea > 0 then
          num = (cSiteArea - sSiteArea)/sSiteArea
          If (Abs(num) > 0.20) and (cSiteArea > sSiteArea)then
            AddRec FormCompNumErrStr(IDLISTSA20RANGE1G, 1, FldCntr), 1, CellSeq
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDLISTSA20RANGE1L, 1, FldCntr), 1, CellSeq
          End If
        End If
      End If

      CellSeq = (FldCntr+20)
      Require FormCompNumErrStr(IDLIST1VIEW, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1VIEWUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1DESIGN, 1, FldCntr), 1, (FldCntr+22)
      CellSeq = (FldCntr+24)
      Require FormCompNumErrStr(IDLIST1QUAL, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1QUALUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+26)
      Require FormCompNumErrStr(IDLIST1AGE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1AGEUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+28)
      Require FormCompNumErrStr(IDLIST1COND, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1CONDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+31)
      Require FormCompNumErrStr(IDLIST1ROOMS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1ROOMSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+32)
      Require FormCompNumErrStr(IDLIST1BED, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BEDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+33)
      Require FormCompNumErrStr(IDLIST1BATHS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BATHSUADERROR, 1, FldCntr), 1, CellSeq
      End If

      CellSeq = (FldCntr+35)
      Require FormCompNumErrStr(IDLIST1GLA, 1, FldCntr), 1, CellSeq
      ' ////// Check if the comp's GLA is 20% more than the subject GLA
      If hasText(1, 34) and hasText(1, CellSeq) then  'we have subject GLA and comp exists
        cGLA = GetValue(1, CellSeq)
        sGLA = GetValue(1, 34)
        num = (cGLA - sGLA)/sGLA
        If (Abs(num) > 0.20) and (cGLA > sGLA)then
          AddRec FormCompNumErrStr(IDLISTGLA20RANGE1G, 1, FldCntr), 1, CellSeq
        End If
        If (ABs(num) > 0.20) and (cGLA < sGLA) then
          AddRec FormCompNumErrStr(IDLISTGLA20RANGE1L, 1, FldCntr), 1, CellSeq
        End If
      End If

      CellSeq = (FldCntr+37)
      Require FormCompNumErrStr(IDLIST1BASE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BASEUADERROR, 1, FldCntr), 1, CellSeq
      End If

      CellSeq2 = (FldCntr+39)
      If not ((GetText(1, CellSeq) = "0sf") or (GetText(1, CellSeq) = "0sqm")) Then
        Require FormCompNumErrStr(IDLIST1BASEPER, 1, FldCntr), 1, CellSeq2
      End If
      If GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDLIST1BASEPERUADERROR, 1, FldCntr), 1, CellSeq2
      End If
      Require FormCompNumErrStr(IDLIST1FUNC, 1, FldCntr), 1, (FldCntr+41)
      Require FormCompNumErrStr(IDLIST1HEAT, 1, FldCntr), 1, (FldCntr+43)
      Require FormCompNumErrStr(IDLIST1ENERGY, 1, FldCntr), 1, (FldCntr+45)
      CellSeq = (FldCntr+45)
      Require FormCompNumErrStr(IDLIST1ENERGY, 1, FldCntr), 1, CellSeq
      If not IsEnergyEfficientOK(1, CellSeq) then
        AddRec FormCompNumErrStr(IDLIST1ENERGYBAD, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1GARAGE, 1, FldCntr), 1, (FldCntr+47)
      If IsUAD and hasText(1, (FldCntr+47)) Then
        Text1 = GetText(1, (FldCntr+47))
        num = InStr(1, Text1, "ga")
        num2 = InStr(1, Text1, "gd")
        num3 = InStr(1, Text1, "gbi")
        num4 = InStr(1, Text1, "cp")
        num5 = InStr(1, Text1, "dw")
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDLIST1RESIDFORMAT, 1, FldCntr), 1, (FldCntr+47)
        End If
      End If
      Require FormCompNumErrStr(IDLIST1PORCH, 1, FldCntr), 1, (FldCntr+49)
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
      Require FormCompNumErrStr(IDDATEPSTLIST1, 1, FldCntr), 1, (FldCntr+1)
      If GetCellUADError(1, (FldCntr+1)) Then
        AddRec FormCompNumErrStr(IDDATEPSTLIST1UADERROR, 1, FldCntr), 1, (FldCntr+1)
      End If
      Require FormCompNumErrStr(IDPRICEPSTLIST1, 1, FldCntr), 1, (FldCntr+2)
      Require FormCompNumErrStr(IDDATASOURCELIST1, 1, FldCntr), 1, (FldCntr+3)
      CellSeq = (FldCntr+4)
      Require FormCompNumErrStr(IDDATASOURCEDATELIST1, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDDATASRCDATELIST1UADERROR, 1, FldCntr), 1, CellSeq
      End If
    End If
  Next

  Require IDSUMMARYLIST, 1, 250

End Sub

