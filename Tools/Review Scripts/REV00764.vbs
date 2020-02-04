'FM00764.vbs Non-Lender URAR Reviewer Script

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
 
AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDSUBJECT + String(5, "=")
   Require IDFilenum, 1, 3
   Require IDAddress, 1, 6
   Require IDCity, 1, 7
   Require IDState, 1, 8
   Require IDZip, 1, 9
   Require IDOWNERPUB,1, 10
   Require "INTENDED USER: Missing", 1, 11
   Require IDCounty, 1, 12
   Require IDLegal, 1, 13
   Require IDAPN2, 1, 14
   Require IDTaxYear, 1, 15
   Require IDReTaxes, 1, 16
   Require IDProjName, 1, 17
   Require IDMapref, 1, 18
   Require IDCensus, 1, 19
   OnlyOneCheckOfThree 1, 20, 21, 22, IDOccNoCheck, IDOccChk
   Require IDSpecial, 1, 23
   

   If not isnegativecomment(1, 25) Then 
     OnlyOneCheckOfTwo 1, 26, 27, ID_HOA_PERIOD_NONE_CHECKED, ID_HOA_PERIOD_MANY_CHECKED
   End If

   OnlyOneCheckOfThree 1, 28, 29, 30, ID_PROPERTY_RIGHTS_NONE_CHECKED, ID_PROPERTY_RIGHTS_MANY_CHECKED


   Require "INTENDED USE: Missing", 1, 32
   Require IDLender, 1, 33
   Require IDLenderAdd, 1, 34
   OnlyOneCheckOfTwo 1, 35, 36, ID_SUBJECT_FOR_SALE_NONE_CHECKED, ID_SUBJECT_FOR_SALE_MANY_CHECKED
   Require ID_SUBJECT_BLOCK_DATA_SOURCE_REQUIRED, 1, 37

End Sub


Sub ReviewContract

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + ID_CONTRACT_BLOCK + String(5, "=")   

  ValidateStandardContractBlock 1, 38


End Sub


Sub ReviewNeighborhood

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDNeigh + String(5, "=") 

ValidateStandardNeighborhoodBlock2005 1, 49

If hasText(2, 262) Then
  num = GetValue(2, 262) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE, 1,68
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE, 1,67
    End If
End If

Require IDNEIGHBOUND, 1, 79
Require IDNEIGHDES, 1, 80
Require IDNEIGHCOND, 1, 81

End Sub



Sub ReviewSite

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDSITE + String(5, "=")

ValidateStandardSiteBlock 1, 82

If hasText(1, 83) Then ValuesMustMatch 1, 83, 2, 22, IDSITECOMPARE

If hasText(1, 85) Then ValuesMustMatch 1, 85, 2, 23, IDVIEWCOMPARE

End Sub



Sub ReviewImprovements

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDIMPROV + String(5, "=")

  OnlyOneCheckOfsix 1, 125, 126, 127, 128, 129, 130, IDSOURCECOOPCK, XXXXXX

  If isChecked(1, 130) Then
    Require ID2055OTHERIMPROVE, 1, 131 
  End If 

  Require ID2055DATASOURCEGLA, 1, 133
  OnlyOneCheckOfTwo 1, 133, 134, INUNITS2, INUNITS2
  Require IDSTORIES, 1, 135
  OnlyOneCheckOfThree 1, 136, 137, 138, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 1, 139, 140, 141, IDEXISTING2, IDEXISTING2
  Require IDDESIGN, 1, 142
  Require IDYRBLT, 1, 143
  Require IDEFFAGE, 1, 144
  OnlyOneCheckOfFour 1, 145, 146, 147, 148, IDFOUNDATIONNOCHK, IDFOUNDATIONCHK

  If isChecked(1, 147) Then
    Require ID2055FULLBASEFIN, 1, 148
  End If

  If isChecked(1, 149) Then
    Require ID2055PARTBASEFIN, 1, 150
  End If

  Require IDEXT, 1, 151
  Require IDROOFSUF, 1, 152
  Require IDGUTTER, 1, 153
  Require IDWINDOWTYPE, 1, 154

  OnlyOneCheckOfFour 1, 155, 156, 157, 158, IDHEATTYPE2, XXXXX

  If isChecked(1, 158) Then
    Require IDHEATOTHER, 1, 159
  End If

  Require IDHEATFUEL, 1, 160
  OnlyOneCheckOfThree 1, 161, 162, 163, IDCOOLCOND2, XXXXX

  If isChecked(1, 163) Then
    Require IDCOOLOTHER, 1, 164
  End If

  OnlyOneCheckOfSeven 1, 165, 167, 169, 171, 173, 175, 177, IDAMENITIES, XXXXXX

  If isChecked(1, 165) Then
    Require IDFIREPLACE2, 1, 166
   End If

  If isChecked(1, 167) Then
    Require IDSTOVES2, 1, 168
  End If

  If isChecked(1, 169) Then
    Require IDPATDECK, 1, 170
  End If

  If isChecked(1, 171) Then
    Require IDPORCH2, 1, 172
  End If

  If isChecked(1, 173) Then
    Require IDPOOL2, 1, 174
  End If

  If isChecked(1, 175) Then
   Require IDFENCE2, 1, 176
  End If

  If isChecked(1, 177) Then
   Require IDOTHER2, 1, 178
  End If

  If hasText(1, 166) Then
   Require IDFIREPLACE2CK, 1, 165
  End If

  If hasText(1, 168) Then
   Require IDSTOVES2CK, 1, 167
  End If

  If hasText(1, 170) Then
   Require IDPATDECKCK, 1, 169
  End If

  If hasText(1, 172) Then
   Require IDPORCH2CK, 1, 171
  End If

  If hasText(1, 174) Then
   Require IDPOOL2CK, 1, 173
  End If

  If hasText(1, 176) Then
   Require IDFENCE2CK, 1, 175
  End If

  If hasText(1, 178) Then
   Require IDOTHER2CK, 1, 177
   End If

  checked = GetTextCheck(1, 180) + GetTextCheck(1, 183) + GetTextCheck(1, 185) + GetTextCheck(1, 187) + GetTextCheck(1, 188) + GetTextCheck(1, 189)
    if isChecked(1, 179) then
      if checked > 0 then AddRec IDCARNONE,1,179
    else
      if checked = 0 then AddRec IDCARERROR,1,179
    end if

  If isChecked(1, 180) Then
    Require IDDRIVE, 1, 181
  End If

  If isChecked(1, 180) Then
    Require IDDRIVE2, 1, 182
  End If

  If isChecked(1, 183) Then
    Require IDGARNUM, 1, 184
  End If

  If isChecked(1, 185) Then
    Require IDCARNUM, 1, 186
  End If

  If hasText(1, 184) Then
    Require IDGARNUM2, 1, 183
  End If

  If hasText(1, 186) Then
    Require IDCARNUM2, 1, 185
  End If

  If isChecked(1, 183) Then
    OnlyOneCheckOfThree 1, 187, 188, 189, IDCARERROR2, XXXXX
  End If


  Require IDROOMCNT, 1, 198
  Require IDBEDCNT, 1, 199
  Require IDBATHCNT, 1, 200
  Require IDGLA, 1, 201
  Require IDADD, 1, 202
  Require IDCOND, 1, 203
  OnlyOneCheckOfTwo 1, 204, 205, IDADVERSE2, XXXXX

  If isChecked(1, 204) Then
    Require IDADVERSE, 1, 206
  End If

  OnlyOneCheckOfTwo 1, 207, 208, IDCONFORM2, XXXXX

  If isChecked(1, 208) Then
    Require IDCONFORM, 1, 209
  End If

End Sub


Sub ReviewSalesSubject

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDSALESAPP + String(5, "=")
   
Require IDFILENUM, 2, 2
Require IDPROPCOMP, 2, 5
Require IDPROPCOMPFROM, 2, 6
Require IDPROPCOMPTO, 2, 7
Require IDSALECOMP, 2, 8
Require IDSALECOMPFROM, 2, 9
Require IDSALECOMPTO, 2, 10

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE2, 2, 48
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE2, 2, 108
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE2, 2, 168
      End If
    End If
End If

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
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE2, 2, 108
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE2, 2, 168
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE3, 2, 104
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE3, 2, 164
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE3, 2, 224
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        AddRec IDTOBERANGE3, 2, 104
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE3, 2, 164
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE3, 2, 224
      End If
    End If
End If

Require IDSUBADD, 2, 11
Require IDSUBCITY, 2, 12

If hasText(2, 12) Then
text1 = GetText(2, 12)
text2 = GetText(1, 7)
text3 = GetText(1, 8)
text4 = GetText(1, 9)
  If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
    AddRec IDADDMATCH, 2, 12
  End If
End If

If not isChecked(1, 33) Then
  Require IDSUBSALES, 2, 13
  Require IDSUBPRGLA, 2, 14
End If

Require IDSUBLOC, 2, 20
Require IDSUBLEASEHOLD, 2, 21
Require IDSUBSITE, 2, 22
Require IDSUBVIEW, 2, 23
Require IDSUBDESIGN, 2, 24
Require IDSUBQUAL, 2, 25
Require IDSUBAGE, 2, 26
Require IDSUBCOND, 2, 27
Require IDSUBROOMS, 2, 28
Require IDSUBBED, 2, 29
Require IDSUBBATHS, 2, 30
Require IDSUBGLA, 2, 31
Require IDSUBBASE, 2, 32
Require IDSUBBASEPER, 2, 33
Require IDSUBFUNC, 2, 34
Require IDSUBHEAT, 2, 35
Require IDSUBENERGY, 2, 36
Require IDSUBGARAGE, 2, 37
Require IDSUBPORCH, 2, 38
Require IDCOMP1ADD, 2, 45
Require IDCOMP1CITY, 2, 46 
Require IDCOMP1PROX, 2, 47
Require IDCOMP1SALES, 2, 48
  
If hasText(2, 48) Then
  num = GetValue(2, 48) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE4, 2, 48
    End If
End If

If hasText(2, 48) Then
  num = GetValue(2, 48) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE4, 2, 48
    End If
End If

If hasText(2, 48) Then
  num = GetValue(2, 48)
    If num < GetValue(2,9) Then
      AddRec IDTOBERANGE10, 2, 48
    End If
End If

If hasText(2, 48) Then
  num = GetValue(2, 48)
    If num > GetValue(2,10) Then
      AddRec IDTOBERANGE10, 2, 48
    End If
End If

Require IDCOMP1PRGLA, 2, 49
Require IDCOMP1SOURCE, 2, 50
Require IDCOMP1VER, 2, 51
Require IDCOMP1SF, 2, 52
Require IDCOMP1CONC, 2, 54
Require IDCOMP1DOS, 2, 56
Require IDCOMP1LOC, 2, 58
Require IDCOMP1LEASEHOLD, 2, 60
Require IDCOMP1SITE, 2, 62
Require IDCOMP1VIEW, 2, 64
Require IDCOMP1DESIGN, 2, 66
Require IDCOMP1QUAL, 2, 68
Require IDCOMP1AGE, 2, 70
Require IDCOMP1COND, 2, 72
Require IDCOMP1ROOMS, 2, 75
Require IDCOMP1BED, 2, 76
Require IDCOMP1BATHS, 2, 77
Require IDCOMP1GLA, 2, 79
Require IDCOMP1BASE, 2,81
Require IDCOMP1BASEPER, 2, 83
Require IDCOMP1FUNC, 2, 85
Require IDCOMP1HEAT, 2, 87
Require IDCOMP1ENERGY, 2, 89
Require IDCOMP1GARAGE, 2, 91
Require IDCOMP1PORCH, 2, 93

If hasText(2, 104) Then
  num = GetValue(2, 104) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE5, 2, 104
    End If
End If

If hasText(2, 104) Then
  num = GetValue(2, 104) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE5, 2, 104
    End If
End If

Require IDCOMP2ADD, 2, 105
Require IDCOMP2CITY, 2, 106
Require IDCOMP2PROX, 2, 107
Require IDCOMP2SALES, 2, 108

If hasText(2, 108) Then
  num = GetValue(2, 108) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE6, 2, 108
    End If
End If

If hasText(2, 108) Then
  num = GetValue(2, 108) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE6, 2, 108
    End If
End If

If hasText(2, 108) Then
  num = GetValue(2, 108)
    If num < GetValue(2,9) Then
      AddRec IDTOBERANGE11, 2, 108
    End If
End If

If hasText(2, 108) Then
  num = GetValue(2, 108)
    If num > GetValue(2,10) Then
      AddRec IDTOBERANGE11, 2, 108
    End If
End If

Require IDCOMP2PRGLA, 2, 109
Require IDCOMP2SOURCE, 2, 110
Require IDCOMP2VER, 2, 111
Require IDCOMP2SF, 2, 112
Require IDCOMP2CONC, 2, 114
Require IDCOMP2DOS, 2, 116
Require IDCOMP2LOC, 2, 118
Require IDCOMP2LEASEHOLD, 2, 120 
Require IDCOMP2SITE, 2, 122
Require IDCOMP2VIEW, 2, 124
Require IDCOMP2DESIGN, 2, 126
Require IDCOMP2QUAL, 2, 128
Require IDCOMP2AGE, 2, 130
Require IDCOMP2COND, 2, 132
Require IDCOMP2ROOMS, 2, 135
Require IDCOMP2BED, 2, 136
Require IDCOMP2BATHS, 2, 137
Require IDCOMP2GLA, 2, 139
Require IDCOMP2BASE, 2, 141
Require IDCOMP2BASEPER, 2, 143
Require IDCOMP2FUNC, 2, 145
Require IDCOMP2HEAT, 2, 147
Require IDCOMP2ENERGY, 2, 149
Require IDCOMP2GARAGE, 2, 151
Require IDCOMP2PORCH, 2, 153

If hasText(2, 164) Then
  num = GetValue(2, 164) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE7, 2, 164
    End If
End If

If hasText(2, 164) Then
  num = GetValue(2, 164) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE7, 2, 164
    End If
End If

Require IDCOMP3ADD, 2, 165
Require IDCOMP3CITY, 2, 166
Require IDCOMP3PROX, 2, 167
Require IDCOMP3SALES, 2, 168

If hasText(2, 168) Then
  num = GetValue(2, 168) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE8, 2, 168
    End If
End If

If hasText(2, 168) Then
  num = GetValue(2, 168) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE8, 2, 168
    End If
End If

If hasText(2, 168) Then
  num = GetValue(2, 168)
    If num < GetValue(2,9) Then
      AddRec IDTOBERANGE12, 2, 168
    End If
End If

If hasText(2, 168) Then
  num = GetValue(2, 168)
    If num > GetValue(2,10) Then
      AddRec IDTOBERANGE12, 2, 168
    End If
End If

Require IDCOMP3PRGLA, 2, 169
Require IDCOMP3SOURCE, 2, 170 
Require IDCOMP3VER, 2, 171
Require IDCOMP3SF, 2, 172
Require IDCOMP3CONC, 2, 174
Require IDCOMP3DOS, 2, 176
Require IDCOMP3LOC, 2, 178
Require IDCOMP3LEASEHOLD, 2, 180 
Require IDCOMP3SITE, 2, 182
Require IDCOMP3VIEW, 2, 184
Require IDCOMP3DESIGN, 2, 186
Require IDCOMP3QUAL, 2, 188
Require IDCOMP3AGE, 2, 190
Require IDCOMP3COND, 2, 192
Require IDCOMP3ROOMS, 2, 195
Require IDCOMP3BED, 2, 196
Require IDCOMP3BATHS, 2, 197
Require IDCOMP3GLA, 2, 199
Require IDCOMP3BASE, 2, 201
Require IDCOMP3BASEPER, 2, 203
Require IDCOMP3FUNC, 2, 205
Require IDCOMP3HEAT, 2, 207
Require IDCOMP3ENERGY, 2, 209
Require IDCOMP3GARAGE, 2, 211
Require IDCOMP3PORCH, 2, 213
  
If hasText(2, 224) Then
  num = GetValue(2, 224) / 1000
    If num > GetValue(1, 68) Then
      AddRec IDTOBERANGE9, 2, 224
    End If
End If

If hasText(2, 224) Then
  num = GetValue(2, 224) / 1000
    If num < GetValue(1, 67) Then
      AddRec IDTOBERANGE9, 2, 224
    End If
End If

OnlyOneCheckOfTwo 2, 225, 226, IDRESEARCH2, XXXXX

If isChecked(2, 226) Then
  Require IDRESEARCH, 2, 227
End If

OnlyOneCheckOfTwo 2, 228, 229, IDRESEARCHSUB2, XXXXX
Require IDRESEARCHSUB3, 2, 230
OnlyOneCheckOfTwo 2, 231, 232, IDRESEARCHCOMP2, XXXXX
Require IDRESEARCHCOMP3, 2, 233
Require IDDATEPSTSUB, 2, 234
Require IDPRICEPSTSUB, 2, 235
Require IDDATASOURCESUB, 2, 236
Require IDDATASOURCEDATESUB, 2, 237
Require IDDATEPSTCOMP1, 2, 238
Require IDPRICEPSTCOMP1, 2, 239
Require IDDATASOURCECOMP1, 2, 240
Require IDDATASOURCEDATECOMP1, 2, 241
Require IDDATEPSTCOMP2, 2, 242
Require IDPRICEPSTCOMP2, 2, 243
Require IDDATASOURCECOMP2, 2, 244
Require IDDATASOURCEDATECOMP2, 2, 245
Require IDDATEPSTCOMP3, 2, 246
Require IDPRICEPSTCOMP3, 2, 247
Require IDDATASOURCECOMP3, 2, 248
Require IDDATASOURCEDATECOMP3, 2, 249 
Require IDANALYSIS2, 2, 250
Require IDSUMMARYSALES, 2, 251

If Not hasText(2, 252) Then
  AddRec IDTOBE, 2, 252
End If

End Sub


Sub ReviewReconciliation
AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDRECON + String(5, "=")

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

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDCOSTAPP + String(5, "=")

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

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDINCOME + String(5, "=")

  Require IDINCOMERENT, 3, 38
  Require IDINCOMEGRM, 3, 39
  Require IDINCOMEVALUE, 2, 255
  Require IDINVALINCOME, 3, 40
  Require IDSUMMARYINCOME, 3, 41


End Sub


Sub ReviewPUD

AddTitle String(5, "=") + "Non-Lender Exterior Only Residential " + IDPUD + String(5, "=")

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




