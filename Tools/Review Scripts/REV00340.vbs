'FM0340.vbs - 1004 URAR
' 05/11/2015:
' Add rule: FRE1095": Critical warning - Trigger is Subject Highest and Best Use is not Yes
'
' 04/23/2015: Add rule to check if Settle date is AFTER Effective date.
' 12/04/2014: Add more FANNIE MAE RULES:
' FNM0083: The sales contract was not analyzed.
' 04/08/2014: Add more rules:
' Only do the check of date/price sale/transfer for the subject if subject of my research is checked
' Do the same check of date/price sale/transfer for the comp if comp of my research is checked
' 08/29/2013: Remove the Contract Date checking.
' 05/15/2013: Fix Divide by 0 issue.  Check if Subject GLA has value before doing the math.
' 04/26/2013: Add rule to check the consistency of quality condition in page 2 cell 27 and page 1 cell 219.
' 04/25/2013: For Amenities: Add an additional checking when these cell values: 182,184,186,188,190,192,194 is None treat them like EMPTY string do not enforce check box required rule. (Do the same checking for cell value 175 and 180)
' 04/01/2013: Add more rules
' Show warning if contract date is BEFORE effective date
' Show warning if settled date is BEFORE contract date
' 03/28/2013: Add more rules
' When a sale or listing is greater than or less than 20% of the subject's GLA, show warning.
' 02/04/2014: Fix the checking of garage count should use getvalue to check for > 0 instead of gettext to check for not empty when 0 is entered
' If purchase transaction type is checked, do the contract checking else skip
Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewContract
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewSalesSubject
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewIncomeApproach
  AddTitle ""
  ReviewPud
  AddTitle ""
End Sub


Sub ReviewSubject

AddTitle String(5, "=") + "FNMA 1004 " + IDSUBJECT + String(5, "=")

  ValidateStandardSubjectBlock 1, 3

End Sub


Sub ReviewContract

  AddTitle String(5, "=") + "FNMA 1004 " + ID_CONTRACT_BLOCK + String(5, "=")

  If not isChecked(1, 33) and not isChecked(1, 34) Then
    ValidateStandardContractBlock 1, 41
    'IsContractDateBEFOREEffectiveDate 1,45,2,263     'pass in contract date(1,45) and effective date(2,263)
    If hasText(1, 44) Then
      num = GetValue(1, 44)
      If num > GetValue(2, 262) Then
        AddRec IDCONTRACTFNMA1, 1, 44
      Else
        If num < GetValue(2, 262) Then
          AddRec IDCONTRACTFNMA2, 1, 44
        End If
      End If
    End If
  Else
    If hasText(1, 44) Then
      Require IDCONTRACTFNMA, 1, 32
    End If
  End If

  If GetCellUADError(1, 43) Then
    AddRec IDCONTRACTUADERROR, 1, 43
  End If

  'only warn if this is a purchase transaction
  If isChecked(1, 32) then
    OnlyOneCheckOfTwo 1, 49, 50, ID_CONTRACT_ASSISTANCE_NONE_CHECKED, ID_CONTRACT_ASSISTANCE_MANY_CHECKED
    CheckAndComment 1, 49, 51, ID_CONTRACT_ASSISTANCE_COMMENT_REQUIRED, ""
    If GetCellUADError(1, 51) Then
      AddRec ID_CONTRACT_ASSISTANCE_UADERROR, 1, 51
    End If
  End If	

End Sub


Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 1004 " + IDNeigh + String(5, "=")

  ValidateStandardNeighborhoodBlock2005 1, 52

  If hasText(2, 262) Then
    num = GetValue(2, 262) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGE, 1,71
      End If
  End If

  If hasText(2, 262) Then
    num = GetValue(2, 262) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGE, 1,70
      End If
  End If

  Require IDNEIGHBOUND, 1, 82
  Require IDNEIGHDES, 1, 83
  Require IDNEIGHCOND, 1, 84

End Sub



Sub ReviewSite

  AddTitle String(5, "=") + "FNMA 1004 " + IDSITE + String(5, "=")

  ValidateStandardSiteBlock 1, 85

  If hasText(1, 86) Then
    ValuesMustMatch 1, 86, 2, 22, IDSITECOMPARE
  End If
  If GetCellUADError(1, 86) Then
    AddRec IDSUBSITEUADERROR, 1, 86
  End If

  If hasText(1, 88) Then
    ValuesMustMatch 1, 88, 2, 23, IDVIEWCOMPARE
  End If
  If GetCellUADError(1, 88) Then
    AddRec IDSUBVIEWUADERROR, 1, 88
  End If

End Sub



Sub ReviewImprovements
Dim Text1, QTYdw, QTYga, QTYgd, QTYgbi, QTYcp, QtyTmp, ItemLoc

  AddTitle String(5, "=") + "FNMA 1004 " + IDIMPROV + String(5, "=")

  OnlyOneCheckOfTwo 1, 128, 129, INUNITS2, INUNITS2
  Require IDSTORIES, 1, 130
  OnlyOneCheckOfThree 1, 131, 132, 133, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 1, 134, 135, 136, IDEXISTING2, IDEXISTING2
  Require IDDESIGN, 1, 137
  Require IDYRBLT, 1, 138
  Require IDEFFAGE, 1, 139
  OnlyOneCheckOfFour 1, 140, 141, 142, 143, IDFOUNDATIONNOCHK, IDFOUNDATIONCHK

  If isChecked(1, 142) Then
   Require IDBASEAREA, 1, 144
   Require IDBASEFIN, 1, 145
  ' Require IDBASEOUTSIDE2, 1, 146
  ' Require IDSUMP2, 1, 147
  End If

  If isChecked(1, 143) Then
   Require IDBASEAREA, 1, 144
   Require IDBASEFIN, 1, 145
  ' Require IDBASEOUTSIDE2, 1, 146
  ' Require IDSUMP2, 1, 147
  End If

  If hasText(1, 144) and (GetText(1, 144) <> "0") Then
   OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
   Require IDBASEFIN, 1, 145
  End If

  If hasText(1, 145) and (GetText(1, 145) <> "0") Then
   OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
   Require IDBASEAREA, 1, 144
  End If

  Require IDFOUNDATION2, 1, 152
  Require IDEXT, 1, 153
  Require IDROOFSUF, 1, 154
  Require IDGUTTER, 1, 155
  Require IDWINDOWTYPE, 1, 156
  Require IDFLOOR, 1, 159
  Require IDWALLS, 1, 160
  Require IDTRIM, 1, 161
  Require IDBATHFLOOR, 1, 162
  Require IDWAINSCOT, 1, 163

  ' Attic
  checked = GetCheck(1, 168) + GetCheck(1, 165) + GetCheck(1, 169) + GetCheck(1, 166) + GetCheck(1, 170) + GetCheck(1, 167)
  If isChecked(1, 164) Then    '  No Attic
    If checked > 0 Then AddRec IDATTICNONE, 1, 164
  Else
    If checked = 0 Then AddRec IDATTICNOCK, 1, 164
  End If

  '  No Doors
  OnlyOneCheckOfFour 1, 171, 172, 173, 174, IDHEATTYPE2, XXXXX
  If isChecked(1, 174) Then
    Require IDHEATOTHER, 1, 175
  Else
    If hasText(1,175) and uCase(GetText(1,175)) <> IDNONE then
      Require IDHEATOTHER2, 1, 175
    End If
  End If

  Require IDHEATFUEL, 1, 176
  OnlyOneCheckOfThree 1, 177, 178, 179, IDCOOLCOND2, XXXXX

  If isChecked(1, 179) Then
    Require IDCOOLOTHER, 1, 180
  Else
    If hasText(1,180) and uCase(GetText(1,180)) <> IDNONE then
      Require IDCOOLOTHER2, 1, 179
    End If
  End If

  OnlyOneCheckOfSeven 1, 181, 183, 185, 187, 189, 191, 193, IDAMENITIES, XXXXXX

  If isChecked(1, 181) Then
    If IsUAD Then
      If (not hasText(1, 182)) or (GetValue(1, 182) <= 0) Then
        AddRec IDFIREPLACE2, 1, 182
      End If
    Else
      Require IDFIREPLACE2, 1, 182
    End If
  Else
    If IsUAD and ((not hasText(1, 182)) or (GetValue(1, 182) <> 0)) then
      AddRec IDFIREPLACENONE, 1, 182
    End If
  End If

  If hasText(1, 182) Then
    If IsUAD Then
      If GetValue(1, 182) > 0 Then
        Require IDFIREPLACE2CK, 1, 181
      End If
    Else
      Require IDFIREPLACE2CK, 1, 181
    End If
  End If

  If isChecked(1, 183) Then
    If IsUAD Then
      If (not hasText(1, 184)) or (uCase(GetText(1, 184)) = IDNONE) Then
        AddRec IDPATDECK2, 1, 184
      End If
    Else
      Require IDPATDECK2, 1, 184
    End If
  Else
    If IsUAD and (uCase(GetText(1, 184)) <> IDNONE) then
      AddRec IDPATDECKNONE, 1, 184
    End If
  End If

  If hasText(1, 184) Then
    If IsUAD Then
      If uCase(GetText(1, 184)) <> IDNONE Then
        Require IDPATDECKCK, 1, 183
      End If
    Else
      Require IDPATDECKCK, 1, 183
    End If
  End If

  If isChecked(1, 185) Then
    If IsUAD Then
      If (not hasText(1, 186)) or (uCase(GetText(1, 186)) = IDNONE) Then
        AddRec IDPOOL2, 1, 186
      End If
    Else
      Require IDPOOL2, 1, 186
    End If
  Else
    If IsUAD and (uCase(GetText(1, 186)) <> IDNONE) then
      AddRec IDPOOLNONE, 1, 186
    End If
  End If

  If hasText(1, 186) Then
    If IsUAD Then
      If uCase(GetText(1, 186)) <> IDNONE Then
        Require IDPOOL2CK, 1, 185
      End If
    Else
      Require IDPOOL2CK, 1, 185
    End If
  End If

  If isChecked(1, 187) Then
    If IsUAD Then
      If (GetValue(1, 188) <= 0) Then
        AddRec IDSTOVES2, 1, 188
      End If
    Else
      Require IDSTOVES2, 1, 188
    End If
  Else
    If IsUAD and ((not hasText(1, 188)) or (GetValue(1, 188) <> 0)) then
      AddRec IDSTOVESNONE, 1, 188
    End If
  End If

  If hasText(1, 188) Then
    If IsUAD Then
      If GetValue(1, 188) > 0 Then
        Require IDSTOVES2CK, 1, 187
      End If
    Else
      Require IDSTOVES2CK, 1, 187
    End If
  End If

  If isChecked(1, 189) Then
    If IsUAD Then
      If (not hasText(1, 190)) or (uCase(GetText(1, 190)) = IDNONE) Then
        AddRec IDFENCE2, 1, 190
      End If
    Else
      Require IDFENCE2, 1, 190
    End If
  Else
    If IsUAD and (uCase(GetText(1, 190)) <> IDNONE) then
      AddRec IDFENCE2NONE, 1, 190
    End If
  End If

  If hasText(1, 190) Then
    If IsUAD Then
      If uCase(GetText(1, 190)) <> IDNONE Then
        Require IDFENCE2CK, 1, 189
      End If
    Else
      Require IDFENCE2CK, 1, 189
    End If
  End If

  If isChecked(1, 191) Then
    If IsUAD Then
      If (not hasText(1, 192)) or (uCase(GetText(1, 192)) = IDNONE) Then
        AddRec IDPORCH2, 1, 192
      End If
    Else
      Require IDPORCH2, 1, 192
    End If
  Else
    If IsUAD and (uCase(GetText(1, 192)) <> IDNONE) then
      AddRec IDPORCH2NONE, 1, 192
    End If
  End If

  If hasText(1, 192) Then
    If IsUAD Then
      If uCase(GetText(1, 192)) <> IDNONE Then
        Require IDPORCH2CK, 1, 191
      End If
    Else
      Require IDPORCH2CK, 1, 191
    End If
  End If

  If isChecked(1, 193) Then
    If IsUAD Then
      If (not hasText(1, 194)) or (uCase(GetText(1, 194)) = IDNONE) Then
        AddRec IDOTHER2, 1, 194
      End If
    Else
      Require IDOTHER2, 1, 194
    End If
  Else
    If IsUAD and (uCase(GetText(1, 194)) <> IDNONE) then
      AddRec IDOTHERNONE, 1, 194
    End If
  End If

  If hasText(1, 194) Then
    If IsUAD Then
      If uCase(GetText(1, 194)) <> IDNONE Then
        Require IDOTHER2CK, 1, 193
      End If
    Else
      Require IDOTHER2CK, 1, 193
    End If
  End If

  checked = GetTextCheck(1, 196) + GetTextCheck(1, 199) + GetTextCheck(1, 201) + GetTextCheck(1, 203) + GetTextCheck(1, 204) + GetTextCheck(1, 205)
  if isChecked(1, 195) then
    if checked > 0 then AddRec IDCARNONE,1,195
  else
    if checked = 0 then AddRec IDCARERROR,1,195
  end if

  If isChecked(1, 196) Then
    Require IDDRIVE, 1, 197
    Require IDDRIVE2, 1, 198
  End If

  If isChecked(1, 199) Then
    Require IDGARNUM, 1, 200
  End If

  If isChecked(1, 201) Then
    Require IDCARNUM, 1, 202
  End If

  If (hasText(1, 197) and (GetValue(1, 197) > 0)) or hasText(1, 198) Then
    Require IDDRIVE1, 1, 196
  End If

  If hasText(1, 200) and (GetValue(1, 200) > 0) Then
    Require IDGARNUM2, 1, 199
  End If

  If hasText(1, 202) and (GetValue(1, 202) > 0) Then
    Require IDCARNUM2, 1, 201
  End If

  If (not IsUAD) and (isChecked(1, 199) or isChecked(1, 201)) Then
    OnlyOneCheckOfThree 1, 203, 204, 205, IDCARERROR2, XXXXX
  End If

  If IsUAD and hasText(2, 37) Then
    QTYdw = 0
    QTYga = 0
    QTYgd = 0
    QTYgbi = 0
    QTYcp = 0
    Text1 = GetText(2, 37)
    'If (GetText(1, 200) <> "") Then  
    If (GetValue(1, 200) > 0) Then
      If isChecked(1, 203) Then
        ItemLoc = InStr(1, Text1, "ga")
        if (ItemLoc = 0) Then
          AddRec IDSUBATTGARAGEMISMATCH, 1, 203
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYga = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 204) Then
        ItemLoc = InStr(1, Text1, "gd")
        if (ItemLoc = 0) Then
          AddRec IDSUBDETGARAGEMISMATCH, 1, 204
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgd = CInt(QTYTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 205) Then
        ItemLoc = InStr(1, Text1, "gbi")
        if (ItemLoc = 0) Then
          AddRec IDSUBBINGARAGEMISMATCH, 1, 205
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgbi = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 3))
        End If
      End If
      If GetValue(1, 200) <> QTYga + QTYgd + QTYgbi Then
        AddRec IDSUBGARAGEQTY, 1, 200
      End If
    End If
    'If (GetText(1, 197) = "") Then  'should check for number not text
    If (GetValue(1, 197) > 0) Then  
      If isChecked(1, 196) and (InStr(1, Text1, GetText(1, 197) + "dw") = 0) Then
        AddRec IDSUBDRIVEWAYMISMATCH, 1, 197
      End If
    End If
    'If (GetText(1, 202) <> "") Then
    If (GetValue(1, 202) > 0) Then
      If isChecked(1, 201) and (InStr(1, Text1, GetText(1, 202) + "cp") = 0) Then
        AddRec IDSUBCARPORTMISMATCH, 1, 202
      End If
    End If
  End If

  OnlyOneCheckOfSeven 1, 206, 207, 208, 209, 210, 211, 212, IDAPPLIANCE, XXXXXX

  If isChecked(1, 212) Then
    Require IDAPPOTHER, 1, 213
  End If

  Require IDROOMCNT, 1, 214
  If GetCellUADError(1, 214) Then
    AddRec IDSUBROOMSUADERROR, 1, 214
  End If
  Require IDBEDCNT, 1, 215
  If GetCellUADError(1, 215) Then
    AddRec IDSUBBEDUADERROR, 1, 215
  End If
  Require IDBATHCNT, 1, 216
  If GetCellUADError(1, 216) Then
    AddRec IDSUBBATHSUADERROR, 1, 216
  End If
  Require IDGLA, 1, 217
  Require IDADD, 1, 218
  Require IDCOND, 1, 219
  If GetCellUADError(1, 219) Then
    AddRec IDCONDUADERROR, 1, 219
  End If

  OnlyOneCheckOfTwo 1, 220, 221, IDADVERSE2, XXXXX

  If isChecked(1, 220) Then
    Require IDADVERSE, 1, 222
  End If

  OnlyOneCheckOfTwo 1, 223, 224, IDCONFORM2, XXXXX

  If isChecked(1, 224) Then
    Require IDCONFORM, 1, 225
  End If

End Sub


Sub ReviewSalesSubject
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, num, num2, num3, num4, num5, _
    text1, text2, text3, text4

  AddTitle String(5, "=") + "FNMA 1004 " + IDSALESAPP + String(5, "=")

  Require IDFILENUM, 2, 2
  Require IDPROPCOMP, 2, 5
  Require IDPROPCOMPFROM, 2, 6
  Require IDPROPCOMPTO, 2, 7
  Require IDSALECOMP, 2, 8
  Require IDSALECOMPFROM, 2, 9
  Require IDSALECOMPTO, 2, 10

  'Show warning if Settle date BEFORE contract date
  IsSettledDateBEFOREContractDate 2,56
  IsSettledDateBEFOREContractDate 2,116
  IsSettledDateBEFOREContractDate 2,176
  
  'Show error if Settle date is AFTER Effective date
  if not isUAD then
    IsSettledDateAFTEREffectiveDate 2, 19, 2, 263 'Subject  
  end if
  IsSettledDateAFTEREffectiveDate 2, 56, 2, 263  'Comp #1
  IsSettledDateAFTEREffectiveDate 2, 116, 2, 263 'Comp #2 
  IsSettledDateAFTEREffectiveDate 2, 176, 2, 263 'Comp #3 
  

  If hasText(2, 262) Then
    num = GetValue(2, 262)
    num2 = GetValue(2, 48)
    num3 = GetValue(2, 108)
    num4 = GetValue(2, 168)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        AddRec IDTOBERANGE2, 2, 48
      End If
    End If
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE2, 2, 48
      End If
    End If
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE2, 2, 108
      End If
    End If
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE2, 2, 108
      End If
    End If
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE2, 2, 168
      End If
    End If
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE2, 2, 168
      End If
    End If

    num2 = GetValue(2, 104)
    num3 = GetValue(2, 164)
    num4 = GetValue(2, 224)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        AddRec IDTOBERANGE3, 2, 104
      End If
    End If
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE3, 2, 104
      End If
    End If
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE3, 2, 164
      End If
    End If
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE3, 2, 164
      End If
    End If
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE3, 2, 224
      End If
    End If
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE3, 2, 224
      End If
    End If
  End If

  Require IDSUBADD, 2, 11
  Require IDSUBCITY, 2, 12

  If hasText(2, 12) Then
    text1 = Replace(UCase(GetText(2, 12)), " ", "")
    text2 = Replace(UCase(GetText(1, 7)), " ", "")
    text3 = Replace(UCase(GetText(1, 8)), " ", "")
    text4 = Replace(UCase(GetText(1, 9)), " ", "")
    If not text1 = text2 + IDCOMMA + text3 + text4 Then
      AddRec IDADDMATCH, 2, 12
    End If
    If GetCellUADError(2, 11) or GetCellUADError(2, 12) Then
      AddRec IDADDRESSUADERROR, 2, 11
    End If
  End If

  If not isChecked(1, 33) Then
    Require IDSUBSALES, 2, 13
    Require IDSUBPRGLA, 2, 14
  End If
  If not IsUAD then
    Require IDSUBSOURCE, 2, 15
    Require IDSUBVERSOURCE, 2, 16
   ' Require IDSUBSF, 2, 17	'issue 1279
    'Require IDSUBCONC, 2, 18
    'Require IDSUBDOS, 2, 19
  End If

  Require IDSUBLOC, 2, 20
  If GetCellUADError(2, 20) Then
    AddRec IDSUBLOCUADERROR, 2, 20
  End If
  Require IDSUBLEASEHOLD, 2, 21
  Require IDSUBSITE, 2, 22
  If GetCellUADError(2, 22) Then
    AddRec IDSUBSITEUADERROR, 2, 22
  End If
  Require IDSUBVIEW, 2, 23
  If GetCellUADError(2, 23) Then
    AddRec IDSUBVIEWUADERROR, 2, 23
  End If
  Require IDSUBDESIGN, 2, 24
  Require IDSUBQUAL, 2, 25
  If GetCellUADError(2, 25) Then
    AddRec IDSUBQUALUADERROR, 2, 25
  End If
  Require IDSUBAGE, 2, 26
  If GetCellUADError(2, 26) Then
    AddRec IDSUBAGEUADERROR, 2, 26
  End If
  Require IDSUBCOND, 2, 27
  ' Check Quality Condition between p1 cell 219 and p2 cell 27 make sure they are the same
  CheckQualityCondition 1, 219, 2, 27
  If GetCellUADError(2, 27) Then
    AddRec IDSUBCONDUADERROR, 2, 27
  End If
  Require IDSUBROOMS, 2, 28
  If GetCellUADError(2, 28) Then
    AddRec IDSUBROOMSUADERROR, 2, 28
  End If
  Require IDSUBBED, 2, 29
  If GetCellUADError(2, 29) Then
    AddRec IDSUBBEDUADERROR, 2, 29
  End If
  Require IDSUBBATHS, 2, 30
  If GetCellUADError(2, 30) Then
    AddRec IDSUBBATHSUADERROR, 2, 30
  End If
  Require IDSUBGLA, 2, 31
  Require IDSUBBASE, 2, 32
  If GetCellUADError(2, 32) Then
    AddRec IDSUBBASEUADERROR, 2, 32
  End If
  If not ((GetText(2, 32) = "0sf") or (GetText(2, 32) = "0sqm")) Then
    Require IDSUBBASEPER, 2, 33
  End IF
  If GetCellUADError(2, 33) Then
    AddRec IDSUBBASEPERUADERROR, 2, 33
  End If
  Require IDSUBFUNC, 2, 34
  Require IDSUBHEAT, 2, 35
  Require IDSUBENERGY, 2, 36
  If not IsEnergyEfficientOK(2, 36) then
    AddRec IDSUBENERGYBAD, 2, 36
  End If
  Require IDSUBGARAGE, 2, 37
  If IsUAD and hasText(2, 37) Then
    Text1 = GetText(2, 37)
    num = InStr(1, Text1, "ga")
    num2 = InStr(1, Text1, "gd")
    num3 = InStr(1, Text1, "gbi")
    num4 = InStr(1, Text1, "cp")
    num5 = InStr(1, Text1, "dw")
    If not NumOrderIsOK(num, num2, num3, num4, num5) Then
      AddRec IDSUBRESIDFORMAT, 2, 37
    End If
  End If
  Require IDSUBPORCH, 2, 38

  GridIndex = 0
  For FldCntr = 45 to 165 Step 60
    GridIndex = GridIndex + 1
    If (GetText(2, (FldCntr)) <> "") or (GetText(2, (FldCntr+1)) <> "") then
      Require FormCompNumErrStr(IDCOMP1ADD, 0, GridIndex), 2, (FldCntr)
      Require FormCompNumErrStr(IDCOMP1ADD2, 0, GridIndex), 2, (FldCntr+1)
      If GetCellUADError(2, (FldCntr)) or GetCellUADError(2, (FldCntr+1)) Then
        AddRec FormCompNumErrStr(IDCOMP1ADDRUADERROR, 0, GridIndex), 2, (FldCntr)
      End If
      Require FormCompNumErrStr(IDCOMP1PROX, 0, GridIndex), 2, (FldCntr+2)
      Require FormCompNumErrStr(IDCOMP1SALES, 0, GridIndex), 2, (FldCntr+3)

      ' Check comp one-unit housing & comp sales ranges
      If hasText(2, (FldCntr+3)) Then
        num2 = GetValue(2, (FldCntr+3))
        num = num2 / 1000
        If num < GetValue(1, 70) Then
          AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 2, (FldCntr+3)
        Else
          If num > GetValue(1, 71) Then
            AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 2, (FldCntr+3)
          End If
        End If
        If num2 < GetValue(2,9) Then
          AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 2, (FldCntr+3)
        Else
          If num2 > GetValue(2,10) Then
            AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 2, (FldCntr+3)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1PRGLA, 0, GridIndex), 2, (FldCntr+3)
      Require FormCompNumErrStr(IDCOMP1SOURCE, 0, GridIndex), 2, (FldCntr+5)
      If GetCellUADError(2, (FldCntr+5)) Then
        AddRec FormCompNumErrStr(IDCOMP1DATASRCUADERROR, 0, GridIndex), 2, (FldCntr+5)
      End If
      Require FormCompNumErrStr(IDCOMP1VER, 0, GridIndex), 2, (FldCntr+6)
      Require FormCompNumErrStr(IDCOMP1SF, 0, GridIndex), 2, (FldCntr+7)
      If GetCellUADError(2, (FldCntr+7)) Then
        AddRec FormCompNumErrStr(IDCOMP1SFUADERROR, 0, GridIndex), 2, (FldCntr+7)
      End If
      Require FormCompNumErrStr(IDCOMP1CONC, 0, GridIndex), 2, (FldCntr+9)
      If GetCellUADError(2, (FldCntr+9)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONCUADERROR, 0, GridIndex), 2, (FldCntr+9)
      End If
      Require FormCompNumErrStr(IDCOMP1DOS, 0, GridIndex), 2, (FldCntr+11)
      If GetCellUADError(2, (FldCntr+11)) Then
        AddRec FormCompNumErrStr(IDCOMP1DOSUADERROR, 0, GridIndex), 2, (FldCntr+11)
      End If
      Require FormCompNumErrStr(IDCOMP1LOC, 0, GridIndex), 2, (FldCntr+13)
      If GetCellUADError(2, (FldCntr+13)) Then
        AddRec FormCompNumErrStr(IDCOMP1LOCUADERROR, 0, GridIndex), 2, (FldCntr+13)
      End If
      Require FormCompNumErrStr(IDCOMP1LEASEHOLD, 0, GridIndex), 2, (FldCntr+15)
      
      Require FormCompNumErrStr(IDCOMP1SITE, 0, GridIndex), 2, (FldCntr+17)
      ' Check if the comp's Site Area is 20% more than the subject Site Area
      If hasText(2, 22) and hasText(2, (FldCntr+17)) then  'we have subject & comp SiteArea
        cSiteArea = GetValue(2, (FldCntr+17))
        sSiteArea = GetValue(2, 22)

        If sSiteArea > 0 then
          num = (cSiteArea - sSiteArea)/sSiteArea
          If (Abs(num) > 0.20) and (cSiteArea > sSiteArea)then
            AddRec FormCompNumErrStr(IDCOMPSA20RANGE1G, 0, GridIndex), 2, (FldCntr+17)
          End If
          If (ABs(num) > 0.20) and (cSiteArea < sSiteArea) then
            AddRec FormCompNumErrStr(IDCOMPSA20RANGE1L, 0, GridIndex), 2, (FldCntr+17)
          End If
        End If
      End If
      
      Require FormCompNumErrStr(IDCOMP1VIEW, 0, GridIndex), 2, (FldCntr+19)
      If GetCellUADError(2, (FldCntr+19)) Then
        AddRec FormCompNumErrStr(IDCOMP1VIEWUADERROR, 0, GridIndex), 2, (FldCntr+19)
      End If
      Require FormCompNumErrStr(IDCOMP1DESIGN, 0, GridIndex), 2, (FldCntr+21)
      Require FormCompNumErrStr(IDCOMP1QUAL, 0, GridIndex), 2, (FldCntr+23)
      If GetCellUADError(2, (FldCntr+23)) Then
        AddRec FormCompNumErrStr(IDCOMP1QUALUADERROR, 0, GridIndex), 2, (FldCntr+23)
      End If
      Require FormCompNumErrStr(IDCOMP1AGE, 0, GridIndex), 2, (FldCntr+25)
      If GetCellUADError(2, (FldCntr+25)) Then
        AddRec FormCompNumErrStr(IDCOMP1AGEUADERROR, 0, GridIndex), 2, (FldCntr+25)
      End If
      Require FormCompNumErrStr(IDCOMP1COND, 0, GridIndex), 2, (FldCntr+27)
      If GetCellUADError(2, (FldCntr+27)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONDUADERROR, 0, GridIndex), 2, (FldCntr+27)
      End If
      Require FormCompNumErrStr(IDCOMP1ROOMS, 0, GridIndex), 2, (FldCntr+30)
      If GetCellUADError(2, (FldCntr+30)) Then
        AddRec FormCompNumErrStr(IDCOMP1ROOMSUADERROR, 0, GridIndex), 2, (FldCntr+30)
      End If
      Require FormCompNumErrStr(IDCOMP1BED, 0, GridIndex), 2, (FldCntr+31)
      If GetCellUADError(2, (FldCntr+31)) Then
        AddRec FormCompNumErrStr(IDCOMP1BEDUADERROR, 0, GridIndex), 2, (FldCntr+31)
      End If
      Require FormCompNumErrStr(IDCOMP1BATHS, 0, GridIndex), 2, (FldCntr+32)
      If GetCellUADError(2, (FldCntr+32)) Then
        AddRec FormCompNumErrStr(IDCOMP1BATHSUADERROR, 0, GridIndex), 2, (FldCntr+32)
      End If

      Require FormCompNumErrStr(IDCOMP1GLA, 0, GridIndex), 2, (FldCntr+34)
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(2, 31) and hasText(2, (FldCntr+34)) then  'we have subject & comp GLA
        cGLA = GetValue(2, (FldCntr+34))
        sGLA = GetValue(2, 31)

        If sGLA > 0 then
          num = (cGLA - sGLA)/sGLA
          If (Abs(num) > 0.20) and (cGLA > sGLA)then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1G, 0, GridIndex), 2, (FldCntr+34)
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1L, 0, GridIndex), 2, (FldCntr+34)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1BASE, 0, GridIndex), 2, (FldCntr+36)
      If GetCellUADError(2, (FldCntr+36)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEUADERROR, 0, GridIndex), 2, (FldCntr+36)
      End If

      If not ((GetText(2, (FldCntr+36)) = "0sf") or (GetText(2, (FldCntr+36)) = "0sqm")) Then
        Require FormCompNumErrStr(IDCOMP1BASEPER, 0, GridIndex), 2, (FldCntr+38)
      End If
      If GetCellUADError(2, (FldCntr+38)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEPERUADERROR, 0, GridIndex), 2, (FldCntr+38)
      End If
      Require FormCompNumErrStr(IDCOMP1FUNC, 0, GridIndex), 2, (FldCntr+40)
      Require FormCompNumErrStr(IDCOMP1HEAT, 0, GridIndex), 2, (FldCntr+42)
      Require FormCompNumErrStr(IDCOMP1ENERGY, 0, GridIndex), 2, (FldCntr+44)
      If not IsEnergyEfficientOK(2, (FldCntr+44)) then
        AddRec FormCompNumErrStr(IDCOMP1ENERGYBAD, 0, GridIndex), 2, (FldCntr+44)
      End If
      Require FormCompNumErrStr(IDCOMP1GARAGE, 0, GridIndex), 2, (FldCntr+46)
      If IsUAD and hasText(2, (FldCntr+46)) Then
        Text1 = GetText(2, (FldCntr+46))
        num = InStr(1, Text1, "ga")
        num2 = InStr(1, Text1, "gd")
        num3 = InStr(1, Text1, "gbi")
        num4 = InStr(1, Text1, "cp")
        num5 = InStr(1, Text1, "dw")
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDCOMP1RESIDFORMAT, 0, GridIndex), 2, (FldCntr+46)
        End If
      End If
      Require FormCompNumErrStr(IDCOMP1PORCH, 0, GridIndex), 2, (FldCntr+48)

      If hasText(2, (FldCntr+59)) Then
        num = GetValue(2, (FldCntr+59)) / 1000
          If num < GetValue(1, 70) Then
            AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 2, (FldCntr+59)
          Else
            If num > GetValue(1, 71) Then
              AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 2, (FldCntr+59)
            End If
          End If
      End If
    End If
  Next

  OnlyOneCheckOfTwo 2, 225, 226, IDRESEARCH2, XXXXX

  If isChecked(2, 226) Then
    Require IDRESEARCH, 2, 227
  End If

  OnlyOneCheckOfTwo 2, 228, 229, IDRESEARCHSUB2, XXXXX
  Require IDRESEARCHSUB3, 2, 230
  OnlyOneCheckOfTwo 2, 231, 232, IDRESEARCHCOMP2, XXXXX
  Require IDRESEARCHCOMP3, 2, 233
  'Only check if I did check box is checked for the subject
  If isChecked(2, 228)  Then	 
    If Not hasText(2, 234) Then
      AddRec IDDATEPSTSUB, 2, 234
    Else
      If IsUAD and (not IsDateOK(2, 234)) then
        AddRec IDDATEPSTFMTSUBJ, 2, 234
      End If
    End If
    If GetCellUADError(2, 234) Then
      AddRec IDDATEPSTSUBUADERROR, 2, 234
    End If
  End if 'end of isChecked
  
  'Check for the subject
  'Only check if I did check box is checked for the Subject
  If isChecked(2, 228)  Then	 
    Require IDPRICEPSTSUB, 2, 235
    Require IDDATASOURCESUB, 2, 236
    Require IDDATASOURCEDATESUB, 2, 237
    If GetCellUADError(2, 237) Then
      AddRec IDDATASRCDATESUBUADERROR, 2, 237
    End If
  End If

  
  'Check for the comps only
  GridIndex = 0
  CompAddrList = Array(45,105,165)
  For FldCntr = 238 to 246 Step 4
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    If (GetText(2, CompAddrSeq) <> "") or (GetText(2, (CompAddrSeq+1)) <> "") then
      'Only check if I did check box is checked
	  If IsChecked(2, 231)  Then 'this is for the comp
	    Require FormCompNumErrStr(IDDATEPSTCOMP1, 0, GridIndex), 2, (FldCntr)
  	    If GetCellUADError(2, (FldCntr)) Then
          AddRec FormCompNumErrStr(IDDATEPSTCOMP1UADERROR, 0, GridIndex), 2, (FldCntr)
        End If
	    Require FormCompNumErrStr(IDPRICEPSTCOMP1, 0, GridIndex), 2, (FldCntr+1)
        Require FormCompNumErrStr(IDDATASOURCECOMP1, 0, GridIndex), 2, (FldCntr+2)
        Require FormCompNumErrStr(IDDATASOURCEDATECOMP1, 0, GridIndex), 2, (FldCntr+3)
 
   	    If GetCellUADError(2, (FldCntr+3)) Then
          AddRec FormCompNumErrStr(IDDATASRCDATECOMP1UADERROR, 0, GridIndex), 2, (FldCntr+3)
        End If
	  End If 
    End If
  Next

  Require IDANALYSIS2, 2, 250
  Require IDSUMMARYSALES, 2, 251

  If Not hasText(2, 252) Then
    AddRec IDTOBE, 2, 252
  End If

End Sub


Sub ReviewReconciliation
  AddTitle String(5, "=") + "FNMA 1004 " + IDRECON + String(5, "=")

  If Not hasText(2, 253) Then
    AddRec IDTOBE, 2, 253
  End If

  Require IDCOSTVALUEREC, 2, 254

  If isChecked(1, 21) Then
    Require IDINCOMEVALUE, 2, 255
  End If

  OnlyOneCheckOfFour 2, 257, 258, 259, 260, IDSTATUSNOCHK, IDSTATUSCHK

  If isChecked(2, 259) Then
    Require IDCONDCOMM, 2, 261
  End If

  If isChecked(2, 260) Then
    Require IDCONDCOMM, 2, 261
  End If

  If Not hasText(2, 262) Then
    AddRec IDTOBE, 2, 262
  End If

  Require IDASOF, 2, 263

End Sub


Sub ReviewCostApproach

  AddTitle String(5, "=") + "FNMA 1004 " + IDCOSTAPP + String(5, "=")

  Require IDOPINCOST, 3, 6 
  OnlyOneCheckOfTwo 3, 7, 8, IDREPCOST, XXXXX
  Require IDSOURCECOST, 3, 9  
  Require IDQUALITYCOST, 3, 10  
  Require IDEFFDATECOST, 3, 11
  Require IDCOMMCOST, 3, 12
  Require IDECONLIFECOST, 3, 13  
  Require IDOPINIONCOST, 3, 14
  Require IDDWELLSQFTCOST, 3, 15 
  Require IDDWELLAMTCOST, 3, 16
  Require IDDWELLAMTCALCCOST, 3, 17 
  Require IDGARCOSTSQFTCOST, 3, 24
  Require IDGARAMTCOST, 3, 25
  Require IDGARAMTCALCCOST, 3, 26 
  Require IDTECNCOST, 3, 27
  Require IDPHYSICALCOST, 3, 28 
  Require IDFUNCCOST, 3, 30
  Require IDEXTCOST, 3, 32
  Require IDDEPPHYSICALCOST, 3, 29 
  Require IDDEPFUNCOST, 3, 31
  Require IDDEPEXTCOST, 3, 33
  Require IDDEPTOTALCOST, 3, 34
  Require IDDEPCOSTOFIMPCOST, 3, 35
  Require IDASISCOST, 3, 36
  Require IDINDVALCOST, 3, 37

  If hasText(3, 37) Then
    num = GetValue(2, 254)
      If not num = GetValue(3, 37) Then
        AddRec IDCOSTNOTEQUAL, 3, 37
      End If
  End If

End Sub


Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "FNMA 1004 " + IDINCOME + String(5, "=")

  If isChecked(1, 21) Then
    Require IDINCOMERENT, 3, 38
    Require IDINCOMEGRM, 3, 39
    Require IDINCOMEVALUE, 2, 255
    Require IDINVALINCOME, 3, 40
    Require IDSUMMARYINCOME, 3, 41
  End If

End Sub


Sub ReviewPUD

  AddTitle String(5, "=") + "FNMA 1004 " + IDPUD + String(5, "=")

  If isChecked(1, 24) Then
    OnlyOneCheckOfTwo 3, 42, 43, IDCONTROLPUD, XXXXX
    OnlyOneCheckOfTwo 3, 44, 45, IDUNITTYPEPUD, XXXXX
  End If

  If isChecked(3, 42) and isChecked(3,45) Then
    Require IDLEGALPUD, 3, 46
    Require IDPHASES, 3, 47
    Require IDUNITS, 3, 48
    Require IDUNITSOLD, 3, 49
    Require IDUNITRENT, 3, 50
    Require IDUNITSALE, 3, 51
    Require IDDATASOURCE, 3, 52
    OnlyOneCheckOfTwo 3, 53, 54, IDCONVERSIONPUD, XXXXX

    If isChecked(3, 53) Then
   Require IDDATECONVERTPUD, 3, 55
    End If

    OnlyOneCheckOfTwo 3, 56, 57, IDMULTIPUD, XXXXX
    Require IDDATEDSPUD, 3, 58
    OnlyOneCheckOfTwo 3, 59, 60, IDCOMPLETEPUD, XXXXX
  
    If isChecked(3, 60) Then
   Require IDCOMPLETESTATUSPUD, 3, 61
    End If
  
    OnlyOneCheckOfTwo 3, 62, 63, IDHOACOMMONPUD, XXXXX
  
    If isChecked(3, 62) Then
   Require IDRENTALTERMSPUD, 3, 64
    End If
  
    Require IDELEMENTSPUD, 3, 65
  End If
  
  '****************************
  '****************************   FANNIE MAE RULES ADDED 12/04/2014
  'RULE #: FNM0083: The sales contract was not analyzed.
  if isChecked(1, 42) then 'DID NOT ANALYZED is checked
    if GetText(1, 43) = "" then 'no comment is provided
	  AddRec FNMCONTRACTNOTANALYZE, 1, 43
	end if
  end if
  
 
 if IsUAD then 
  'RULE # FNM0084: There was no comment on market conditions, even though one or more negative housing trends were indicated(declining, over supply, over 6 mos)
  if GetText(1, 84) = "" then
    count = GetCheck(1, 63) +  GetCheck(1, 66) + GetCheck(1, 69)
    if count > 0 then 'one or more negative trends
	  AddRec FNMMARKETCONDITION, 1, 84
	end if
  end if
  'RULE # FNM0085: Handled inside the exe
  'RULE # FNM0086: Research of prior sale was not performed
  'pop up error even we have comment
  if isChecked(2, 226) then
    AddRec FNNOREARCHPRIORSALE, 2, 226
  end if
  
  'RULE # FNM0093: Handled inside the exe
  'RULE # FNM0094: Handled inside the exe
  
  'RULE # FNM0096: Illegal zoning compliance has been indicated in appraisal.
  if isChecked(1, 94) then
    AddRec FNMILLEGALZONING, 1, 94
  end if
  
 'RULE # FNM0098: Present use is indicated as not highest and best use.
 'Replace Rule #FNM0098 with FRE1095" Subject Highest and Best Use
'if not isChecked(1, 96) then
 '  AddRec FNMBESTUSE, 1, 96
 'end if

 
 'RULE # FNM0176: Only apply for 1073 and 1075
  
 'RULE #FNM0179: The appraisal indicates the subject property has a C6 condition rating. If the loan is not a DU Refi Plus or Refi Plus 'loan, the property is not eligible for delivery to Fannie Mae.
condition = uCase(GetText(2, 27))
if trim(condition) = "C6" then
  AddRec FNMConditionC6, 2, 27
end if

end if  ' end of if isUAD

End Sub




