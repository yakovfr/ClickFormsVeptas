'FM00888.vbs 1073 Extra Listings Reviewer Script

Sub ReviewForm
  ReviewHeader
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
end Sub

Sub ReviewHeader
  AddTitle String(5,"=") + " EXTRA LISTINGS HEADING " + String(5,"=")
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
Dim CompAddrList, CompAddrSeq, CellSeq, CellSeq2

  AddTitle String(5, "=") + "FNMA 1073 EXTRA LISTINGS" + String(5, "=")

  Require IDSUBADD, 1, 14
  Require IDSUBUNITNO, 1, 15
  If GetCellUADError(1, 14) or GetCellUADError(1, 15) Then
    AddRec IDADDRESSUADERROR, 1, 14
  End If

  Require IDSUBNAME, 1, 16
  Require IDSUBPHASE, 1, 17
  Require IDSUBLISTPR, 1, 18
  Require IDSUBLISTPRGLA, 1, 19
  If not IsUAD then
    Require IDSUBSOURCE, 1, 20
    Require IDSUBVERSOURCE, 1, 21
    'Require IDSUBSF, 1, 22	'issue 1279
    'Require IDSUBCONC, 1, 23
    'Require IDSUBDOS, 1, 24
  End If
  Require IDSUBLOC, 1, 25
  If GetCellUADError(1, 25) Then
    AddRec IDSUBLOCUADERROR, 1, 25
  End If
  Require IDSUBLEASEHOLD, 1, 26
  Require IDSUBHOA, 1, 27
  Require IDSUBCOMELE, 1, 28
  Require IDSUBRECFAC, 1, 29
  Require IDSUBFLOORLOC, 1, 30
  Require IDSUBVIEW, 1, 31
  If GetCellUADError(1, 31) Then
    AddRec IDSUBVIEWUADERROR, 1, 31
  End If
  Require IDSUBDESIGN, 1, 32
  Require IDSUBQUAL, 1, 33
  If GetCellUADError(1, 33) Then
    AddRec IDSUBQUALUADERROR, 1, 33
  End If
  Require IDSUBAGE, 1, 34
  If GetCellUADError(1, 34) Then
    AddRec IDSUBAGEUADERROR, 1, 34
  End If
  Require IDSUBCOND, 1, 35
  If GetCellUADError(1, 35) Then
    AddRec IDSUBCONDUADERROR, 1, 35
  End If
  Require IDSUBROOMS, 1, 36
  If GetCellUADError(1, 36) Then
    AddRec IDSUBROOMSUADERROR, 1, 36
  End If
  Require IDSUBBED, 1, 37
  If GetCellUADError(1, 37) Then
    AddRec IDSUBBEDUADERROR, 1, 37
  End If
  Require IDSUBBATHS, 1, 38
  If GetCellUADError(1, 38) Then
    AddRec IDSUBBATHSUADERROR, 1, 38
  End If
  Require IDSUBGLA, 1, 39
  Require IDSUBBASE, 1, 40
  If GetCellUADError(1, 40) Then
    AddRec IDSUBBASEUADERROR, 1, 40
  End If
  If not ((GetText(1, 40) = "0sf") or (GetText(1, 40) = "0sqm")) Then
    Require IDSUBBASEPER, 1, 41
  End If
  If GetCellUADError(1, 41) Then
    AddRec IDSUBBASEPERUADERROR, 1, 41
  End If
  Require IDSUBFUNC, 1, 42
  Require IDSUBHEAT, 1, 43
  Require IDSUBENERGY, 1, 44
  Require IDSUBGARAGE, 1, 45
  If IsUAD and hasText(1, 45) Then
    Text1 = GetText(1, 45)
    num = InStr(1, Text1, "g")
    num2 = InStr(1, Text1, "cv")
    num3 = InStr(1, Text1, "op")
    num4 = 0
    num5 = 0
    If not NumOrderIsOK(num, num2, num3, num4, num5) Then
      AddRec IDSUBCONDOFORMAT, 1, 45
    End If
  End If
  Require IDSUBPORCH, 1, 46

  Require IDDATEPSTSUB, 1, 260
  If GetCellUADError(1, 260) Then
    AddRec IDDATEPSTSUBUADERROR, 1, 260
  End If
  Require IDPRICEPSTSUB, 1, 261
  Require IDDATASOURCESUB, 1, 262
  Require IDDATASOURCEDATESUB, 1, 263
  If GetCellUADError(1, 263) Then
    AddRec IDDATASRCDATESUBUADERROR, 1, 263
  End If

  For FldCntr = 53 to 191 Step 69
    Require FormCompNumErrStr(IDCOMP1ID, 1, FldCntr), 1, FldCntr
    CellSeq = (FldCntr+1)
    CellSeq2 = (FldCntr+2)
    If (GetText(1, CellSeq) <> "") or (GetText(1, CellSeq2) <> "") then
      Require FormCompNumErrStr(IDLIST1ADD, 1, FldCntr), 1, CellSeq
      Require FormCompNumErrStr(IDLIST1UNITNO, 1, FldCntr), 1, CellSeq2
      If GetCellUADError(1, CellSeq) or GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDLIST1ADDRUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1NAME, 1, FldCntr), 1, (FldCntr+3)
      Require FormCompNumErrStr(IDLIST1PHASE, 1, FldCntr), 1, (FldCntr+4)
      Require FormCompNumErrStr(IDLIST1PROX, 1, FldCntr), 1, (FldCntr+5)
      Require FormCompNumErrStr(IDLIST1SALES, 1, FldCntr), 1, (FldCntr+6)
      Require FormCompNumErrStr(IDLIST1PRGLA, 1, FldCntr), 1, (FldCntr+7)
      CellSeq = (FldCntr+8)
      Require FormCompNumErrStr(IDLIST1SOURCE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1DATASRCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1VER, 1, FldCntr), 1, (FldCntr+9)
      CellSeq = (FldCntr+10)
      Require FormCompNumErrStr(IDLIST1SF, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1SFUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+12)
      Require FormCompNumErrStr(IDLIST1CONC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1CONCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+14)
      Require FormCompNumErrStr(IDLIST1DOS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1DOSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+16)
      Require FormCompNumErrStr(IDLIST1LOC, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1LOCUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1LEASEHOLD, 1, FldCntr), 1, (FldCntr+18)
      Require FormCompNumErrStr(IDLIST1HOA, 1, FldCntr), 1, (FldCntr+20)
      Require FormCompNumErrStr(IDLIST1COMELE, 1, FldCntr), 1, (FldCntr+22)
      Require FormCompNumErrStr(IDLIST1RECFAC, 1, FldCntr), 1, (FldCntr+24)
      Require FormCompNumErrStr(IDLIST1FLOORLOC, 1, FldCntr), 1, (FldCntr+26)
      CellSeq = (FldCntr+28)
      Require FormCompNumErrStr(IDLIST1VIEW, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1VIEWUADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1DESIGN, 1, FldCntr), 1, (FldCntr+30)
      CellSeq = (FldCntr+32)
      Require FormCompNumErrStr(IDLIST1QUAL, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1QUALUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+34)
      Require FormCompNumErrStr(IDLIST1AGE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1AGEUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+36)
      Require FormCompNumErrStr(IDLIST1COND, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1CONDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+39)
      Require FormCompNumErrStr(IDLIST1ROOMS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1ROOMSUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+40)
      Require FormCompNumErrStr(IDLIST1BED, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BEDUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq = (FldCntr+41)
      Require FormCompNumErrStr(IDLIST1BATHS, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BATHSUADERROR, 1, FldCntr), 1, CellSeq
      End If

      CellSeq = (FldCntr+43)
      Require FormCompNumErrStr(IDCOMP1GLA, 1, FldCntr), 1, CellSeq
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(1, 39) and hasText(1, CellSeq) then  'we have subject & comp GLA
        cGLA = GetValue(1, CellSeq)
        sGLA = GetValue(1, 39)

        If sGLA > 0 then
          num = (cGLA - sGLA)/sGLA
          If (Abs(num) > 0.20) and (cGLA > sGLA)then
            AddRec FormCompNumErrStr(IDLISTGLA20RANGE1G, 1, FldCntr), 1, CellSeq
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDLISTGLA20RANGE1L, 1, FldCntr), 1, CellSeq
          End If
        End If
      End If

      CellSeq = (FldCntr+45)
      Require FormCompNumErrStr(IDLIST1BASE, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDLIST1BASEUADERROR, 1, FldCntr), 1, CellSeq
      End If
      CellSeq2 = (FldCntr+47)
      If not ((GetText(1, CellSeq) = "0sf") or (GetText(1, CellSeq) = "0sqm")) Then
        Require FormCompNumErrStr(IDLIST1BASEPER, 1, FldCntr), 1, CellSeq2
      End If
      If GetCellUADError(1, CellSeq2) Then
        AddRec FormCompNumErrStr(IDLIST1BASEPERUADERROR, 1, FldCntr), 1, CellSeq2
      End If
      Require FormCompNumErrStr(IDLIST1FUNC, 1, FldCntr), 1, (FldCntr+49)
      Require FormCompNumErrStr(IDLIST1HEAT, 1, FldCntr), 1, (FldCntr+51)
      CellSeq = (FldCntr+53)
      Require FormCompNumErrStr(IDLIST1ENERGY, 1, FldCntr), 1, CellSeq
      If not IsEnergyEfficientOK(1, CellSeq) then
        AddRec FormCompNumErrStr(IDLIST1ENERGYBAD, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDLIST1GARAGE, 1, FldCntr), 1, (FldCntr+55)
      If IsUAD and hasText(1, (FldCntr+55)) Then
        Text1 = GetText(1, (FldCntr+55))
        num = InStr(1, Text1, "g")
        num2 = InStr(1, Text1, "cv")
        num3 = InStr(1, Text1, "op")
        num4 = 0
        num5 = 0
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDLIST1CONDOFORMAT, 1, FldCntr), 1, (FldCntr+55)
        End If
      End If
      Require FormCompNumErrStr(IDLIST1PORCH, 1, FldCntr), 1, (FldCntr+57)
    End If
  Next

  GridIndex = 0
  CompAddrList = Array(54,123,192)
  For FldCntr = 264 to 274 Step 5
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    If (GetText(1, CompAddrSeq) <> "") or (GetText(1, (CompAddrSeq+1)) <> "") then
      CellSeq = (FldCntr+1)
      Require FormCompNumErrStr(IDDATEPSTLIST1, 1, FldCntr), 1, CellSeq
      If GetCellUADError(1, CellSeq) Then
        AddRec FormCompNumErrStr(IDDATEPSTLIST1UADERROR, 1, FldCntr), 1, CellSeq
      End If
      Require FormCompNumErrStr(IDPRICEPSTLIST1, 1, FldCntr), 1, (FldCntr+2)
      Require FormCompNumErrStr(IDDATASOURCELIST1, 1, FldCntr), 1, (FldCntr+3)
      CellSeq = (FldCntr+4)
      Require FormCompNumErrStr(IDDATASOURCEDATELIST1, 1, FldCntr), 1, CellSeq
      If GetCellUADError(2, CellSeq) Then
        AddRec FormCompNumErrStr(IDDATASRCDATELIST1UADERROR, 1, FldCntr), 1, CellSeq
      End If
    End If
  Next

  Require IDSUMMARYSALES, 1, 279
End Sub

