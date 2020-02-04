'REVB00355.vbs 2055 Reviewer Script
' 0203/2015: Add new rule:
'RULE #FNM0179: The appraisal indicates the subject property has a C6 condition rating. If the loan is not a DU Refi Plus or Refi Plus 'loan, the property is not eligible for delivery to Fannie Mae.
' 04/08/2014: Add more rules:
' Only do the check of date/price sale/transfer for the subject if subject of my research is checked
' Do the same check of date/price sale/transfer for the comp if comp of my research is checked
' Use GetValue function to check on cell 187 page 1 for # of cars. this will fix the issue when we have 0 in it.


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

  AddTitle String(5, "=") + "FNMA 2055 " + IDSUBJECT + String(5, "=")

  ValidateStandardSubjectBlock 1, 3
  
  '****************************
  '****************************   FANNIE MAE RULES ADDED 12/04/2014
 if isUAD then
  'RULE #: FNM0083:
  if isChecked(1, 42) then 'DID NOT ANALYZED is checked
    if GetText(1, 43) = "" then
	  AddRec FNMCONTRACTNOTANALYZE, 1, 43
	end if
  end if
  
  'RULE # FNM0084: There was no comment on market conditions, even though one or more negative housing trends were indicated(declining, over supply, over 6 mos)
  if GetText(1, 84) = "" then
    count = GetCheck(1, 63) +  GetCheck(1, 66) + GetCheck(1, 69)
    if count > 0 then 'one or more negative trends
	  AddRec FNMMARKETCONDITION, 1, 84
    end if
  end if
  
  'RULE # FNM0086: Research of prior sale was not performed
  'pop up error even we have comment
  if isChecked(2, 226) then
    AddRec FNNOREARCHPRIORSALE, 2, 226
  end if


 'RULE # FNM0087: Research of prior sale was not performed
 'pop up error even we have comment
  if isChecked(1, 42) then
    AddRec FNNOREARCHPRIORSALE, 1, 42
  end if
 
  'RULE # FNM0096: Illegal zoning compliance has been indicated in appraisal.
  if isChecked(1, 94) then
    AddRec FNMILLEGALZONING, 1, 94
  end if

'RULE # FNM0098: Present use is indicated as not highest and best use.
' This rule is replace with FRE1095 in Script header
' if not isChecked(1, 96) then
'   AddRec FNMBESTUSE, 1, 96
' end if
  

 'RULE # FNM0176: Only apply for 1073 and 1075
  
 'RULE #FNM0179: The appraisal indicates the subject property has a C6 condition rating. If the loan is not a DU Refi Plus or Refi Plus 'loan, the property is not eligible for delivery to Fannie Mae.
condition = uCase(GetText(2, 27))
if trim(condition) = "C6" then
  AddRec FNMConditionC6, 2, 27
end if
  
end if 'end of isUAD 

End Sub

Sub ReviewContract

  AddTitle String(5, "=") + "FNMA 2055 " + ID_CONTRACT_BLOCK + String(5, "=")

  If not isChecked(1, 33) and not isChecked(1, 34) Then
    ValidateStandardContractBlock 1, 41
    IsContractDateBEFOREEffectiveDate 1, 45, 2, 263     'pass in contract date(1,45) and effective date(2,263)
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

  OnlyOneCheckOfTwo 1, 49, 50, ID_CONTRACT_ASSISTANCE_NONE_CHECKED, ID_CONTRACT_ASSISTANCE_MANY_CHECKED
  CheckAndComment 1, 49, 51, ID_CONTRACT_ASSISTANCE_COMMENT_REQUIRED, ""
  If GetCellUADError(1, 51) Then
    AddRec ID_CONTRACT_ASSISTANCE_UADERROR, 1, 51
  End If

End Sub


Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 2055 " + IDNeigh + String(5, "=")

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

  AddTitle String(5, "=") + "FNMA 2055 " + IDSITE + String(5, "=")
  
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

  AddTitle String(5, "=") + "FNMA 2055 " + IDIMPROV + String(5, "=")
  
  OnlyOneCheckOfsix 1, 128, 129, 130, 131, 132, 133, IDSOURCECOOPCK, XXXXXX

  If isChecked(1, 133) Then
    Require ID2055OTHERIMPROVE, 1, 134
  End If 

  Require ID2055DATASOURCEGLA, 1, 135
  OnlyOneCheckOfTwo 1, 136, 137, INUNITS2, INUNITS2
  Require IDSTORIES, 1, 138
  OnlyOneCheckOfThree 1, 139, 140, 141, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 1, 142, 143, 144, IDEXISTING2, IDEXISTING2
  Require IDDESIGN, 1, 145
  Require IDYRBLT, 1, 146
  Require IDEFFAGE, 1, 147
  OnlyOneCheckOfTwo 1, 148, 149, IDFOUNDATIONNOCHK, ""
  OnlyOneCheckOfTwo 1, 150, 152,"","BASEMENT: More than one check box has been checked"

'  If isChecked(1, 150) Then
'    Require ID2055FULLBASEFIN, 1, 151
'  End If

'  If isChecked(1, 152) Then
'    Require ID2055PARTBASEFIN, 1, 153
'  End If

  Require IDEXT, 1, 154
  Require IDROOFSUF, 1, 155
  Require IDGUTTER, 1, 156
  Require IDWINDOWTYPE, 1, 157

  OnlyOneCheckOfFour 1, 158, 159, 160, 161, IDHEATTYPE2, XXXXX

  If isChecked(1, 161) Then
    Require IDHEATOTHER, 1, 162
  Else
    If hasText(1,162) and uCase(GetText(1,162)) <> IDNONE then
      Require IDHEATOTHER2, 1, 162
    End If
  End If

  Require IDHEATFUEL, 1, 163
  OnlyOneCheckOfThree 1, 164, 165, 166, IDCOOLCOND2, XXXXX

  If isChecked(1, 166) Then
    Require IDCOOLOTHER, 1, 167
  Else
    If hasText(1,167) and uCase(GetText(1,167)) <> IDNONE then
      Require IDCOOLOTHER2, 1, 166
    End If
  End If

  OnlyOneCheckOfSeven 1, 168, 170, 172, 174, 176, 178, 180, IDAMENITIES, XXXXXX

  If isChecked(1, 168) Then
    If IsUAD Then
      If (not hasText(1, 169)) or (GetValue(1, 169) <= 0) Then
        AddRec IDFIREPLACE2, 1, 169
      End If
    Else
      Require IDFIREPLACE2, 1, 169
    End If
  Else
    If IsUAD and ((not hasText(1, 169)) or (GetValue(1, 169) <> 0)) then
      AddRec IDFIREPLACENONE, 1, 169
    End If
  End If

  If hasText(1, 169) Then
    If IsUAD Then
      If GetValue(1, 169) > 0 Then
        Require IDFIREPLACE2CK, 1, 168
      End If
    Else
      Require IDFIREPLACE2CK, 1, 168
    End If
  End If

  If isChecked(1, 170) Then
    If IsUAD Then
      If (GetValue(1, 171) <= 0) Then
        AddRec IDSTOVES2, 1, 171
      End If
    Else
      Require IDSTOVES2, 1, 171
    End If
  Else
    If IsUAD and ((not hasText(1, 171)) or (GetValue(1, 171) <> 0)) then
      AddRec IDSTOVESNONE, 1, 171
    End If
  End If

  If hasText(1, 171) Then
    If IsUAD Then
      If GetValue(1, 171) > 0 Then
        Require IDSTOVES2CK, 1, 170
      End If
    Else
      Require IDSTOVES2CK, 1, 170
    End If
  End If

  If isChecked(1, 172) Then
    If IsUAD Then
      If (not hasText(1, 173)) or (GetText(1, 173) = "None") Then
        AddRec IDPATDECK2, 1, 173
      End If
    Else
      Require IDPATDECK2, 1, 173
    End If
  Else
    If IsUAD and (GetText(1, 173) <> "None") then
      AddRec IDPATDECKNONE, 1, 173
    End If
  End If

  If hasText(1, 173) Then
    If IsUAD Then
      If GetText(1, 173) <> "None" Then
        Require IDPATDECKCK, 1, 172
      End If
    Else
      Require IDPATDECKCK, 1, 172
    End If
  End If

  If isChecked(1, 174) Then
    If IsUAD Then
      If (not hasText(1, 175)) or (GetText(1, 175) = "None") Then
        AddRec IDPORCH2, 1, 175
      End If
    Else
      Require IDPORCH2, 1, 175
    End If
  Else
    If IsUAD and (GetText(1, 175) <> "None") then
      AddRec IDPORCH2NONE, 1, 175
    End If
  End If

  If hasText(1, 175) Then
    If IsUAD Then
      If GetText(1, 175) <> "None" Then
        Require IDPORCH2CK, 1, 174
      End If
    Else
      Require IDPORCH2CK, 1, 174
    End If
  End If

  If isChecked(1, 176) Then
    If IsUAD Then
      If (not hasText(1, 177)) or (GetText(1, 177) = "None") Then
        AddRec IDPOOL2, 1, 177
      End If
    Else
      Require IDPOOL2, 1, 177
    End If
  Else
    If IsUAD and (GetText(1, 177) <> "None") then
      AddRec IDPOOLNONE, 1, 177
    End If
  End If

  If hasText(1, 177) Then
    If IsUAD Then
      If GetText(1, 177) <> "None" Then
        Require IDPOOL2CK, 1, 176
      End If
    Else
      Require IDPOOL2CK, 1, 176
    End If
  End If

  If isChecked(1, 178) Then
    If IsUAD Then
      If (not hasText(1, 179)) or (GetText(1, 179) = "None") Then
        AddRec IDFENCE2, 1, 179
      End If
    Else
      Require IDFENCE2, 1, 179
    End If
  Else
    If IsUAD and (GetText(1, 179) <> "None") then
      AddRec IDFENCE2NONE, 1, 179
    End If
  End If

  If hasText(1, 179) Then
    If IsUAD Then
      If GetText(1, 179) <> "None" Then
        Require IDFENCE2CK, 1, 178
      End If
    Else
      Require IDFENCE2CK, 1, 178
    End If
  End If

  If isChecked(1, 180) Then
    If IsUAD Then
      If (not hasText(1, 181)) or (GetText(1, 181) = "None") Then
        AddRec IDOTHER2, 1, 181
      End If
    Else
      Require IDOTHER2, 1, 181
    End If
  Else
    If IsUAD and (GetText(1, 181) <> "None") then
      AddRec IDOTHERNONE, 1, 181
    End If
  End If

  If hasText(1, 181) Then
    If IsUAD Then
      If GetText(1, 181) <> "None" Then
        Require IDOTHER2CK, 1, 180
      End If
    Else
      Require IDOTHER2CK, 1, 180
    End If
  End If

  checked = GetTextCheck(1, 183) + GetTextCheck(1, 186) + GetTextCheck(1, 188) + GetTextCheck(1, 190) + GetTextCheck(1, 191) + GetTextCheck(1, 192)
    if isChecked(1, 182) then
      if checked > 0 then AddRec IDCARNONE,1,182
    else
      if checked = 0 then AddRec IDCARERROR,1,182
    end if

  If isChecked(1, 183) Then
    Require IDDRIVE, 1, 184
    Require IDDRIVE2, 1, 185
  End If

  If isChecked(1, 186) Then
    Require IDGARNUM, 1, 187
  End If

  If isChecked(1, 188) Then
    Require IDCARNUM, 1, 189
  End If

  If (hasText(1, 184) and (GetValue(1, 184) > 0)) or hasText(1, 185) Then
    Require IDDRIVE1, 1, 183
  End If

  If hasText(1, 187) and (GetValue(1, 187) > 0) Then
    Require IDGARNUM2, 1, 186
  End If

  If hasText(1, 189) and (GetValue(1, 189) > 0) Then
    Require IDCARNUM2, 1, 188
  End If

  If (not IsUAD) and (isChecked(1, 186) or isChecked(1, 188)) Then
    OnlyOneCheckOfThree 1, 190, 191, 192, IDCARERROR2, XXXXX
  End If

  If IsUAD and hasText(2, 37) Then
    QTYdw = 0
    QTYga = 0
    QTYgd = 0
    QTYgbi = 0
    QTYcp = 0
    Text1 = GetText(2, 37)
    If (GetValue(1, 187) <> 0) Then   'Should do GetValue to check for number do not use GetText, it might have 0
      If isChecked(1, 190) Then
        ItemLoc = InStr(1, Text1, "ga")
        if (ItemLoc = 0) Then
          AddRec IDSUBATTGARAGEMISMATCH, 1, 190
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYga = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 191) Then
        ItemLoc = InStr(1, Text1, "gd")
        if (ItemLoc = 0) Then
          AddRec IDSUBDETGARAGEMISMATCH, 1, 191
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgd = CInt(QTYTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 192) Then
        ItemLoc = InStr(1, Text1, "gbi")
        if (ItemLoc = 0) Then
          AddRec IDSUBBINGARAGEMISMATCH, 1, 192
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgbi = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 3))
        End If
      End If
      If GetValue(1, 187) <> QTYga + QTYgd + QTYgbi Then
        AddRec IDSUBGARAGEQTY, 1, 187
      End If
    End If
    If (GetText(1, 184) <> "") Then
      If isChecked(1, 183) and (InStr(1, Text1, GetText(1, 184) + "dw") = 0) Then
        AddRec IDSUBDRIVEWAYMISMATCH, 1, 184
      End If
    End If
    If (GetText(1, 189) <> "") Then
      If isChecked(1, 188) and (InStr(1, Text1, GetText(1, 189) + "cp") = 0) Then
        AddRec IDSUBCARPORTMISMATCH, 1, 189
      End If
    End If
  End If

  Require IDROOMCNT, 1, 201
  If GetCellUADError(1, 201) Then
    AddRec IDSUBROOMSUADERROR, 1, 201
  End If
  Require IDBEDCNT, 1, 202
  If GetCellUADError(1, 202) Then
    AddRec IDSUBBEDUADERROR, 1, 202
  End If
  Require IDBATHCNT, 1, 203
  If GetCellUADError(1, 203) Then
    AddRec IDSUBBATHSUADERROR, 1, 203
  End If
  Require IDGLA, 1, 204
  Require IDADD, 1, 205
  Require IDCOND, 1, 206
  If GetCellUADError(1, 206) Then
    AddRec IDCONDUADERROR, 1, 206
  End If
  OnlyOneCheckOfTwo 1, 207, 208, IDADVERSE2, XXXXX

  If isChecked(1, 207) Then
    Require IDADVERSE, 1, 209
  End If

  OnlyOneCheckOfTwo 1, 210, 211, IDCONFORM2, XXXXX

  If isChecked(1, 211) Then
    Require IDCONFORM, 1, 212
  End If

End Sub


Sub ReviewSalesSubject
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, num, num2, num3, num4, num5, _
    text1, text2, text3, text4, CSOK

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
  End If
  If GetCellUADError(2, 11) or GetCellUADError(2, 12) Then
    AddRec IDADDRESSUADERROR, 2, 11
  End If

  If not isChecked(1, 33) Then
    Require IDSUBSALES, 2, 13
    Require IDSUBPRGLA, 2, 14
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
  CheckQualityCondition 1, 206, 2, 27
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

  'Only check if I did check box is checked for the SUBJECT
  If isChecked(2, 228) Then	 
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

    Require IDPRICEPSTSUB, 2, 235
    Require IDDATASOURCESUB, 2, 236
    Require IDDATASOURCEDATESUB, 2, 237
    If GetCellUADError(2, 237) Then
      AddRec IDDATASRCDATESUBUADERROR, 2, 237
    End If
  End If 
  GridIndex = 0
  CompAddrList = Array(45,105,165)
  For FldCntr = 238 to 246 Step 4
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    If (GetText(2, CompAddrSeq) <> "") or (GetText(2, (CompAddrSeq+1)) <> "") then
     'Only check if I did check box is checked for the COMPS
     If IsChecked(2,231)  Then
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

End Sub