'REV00737.vbs Non-Lender SMALL INCOME Reviewer Script

Sub ReviewForm()

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
  ReviewCompRentData
  AddTitle ""
  ReviewSubRentSched
  AddTitle ""
  ReviewPriorSales
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
  ReviewIncomeApproach
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewPud
  AddTitle ""
End Sub

Sub ReviewSubject

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDSUBJECT + String(5, "=")
  
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

  AddTitle String(5, "=") + "Non-Lender Small Income " + ID_CONTRACT_BLOCK + String(5, "=")

  ValidateStandardContractBlock 1, 38

End Sub

Sub ReviewNeighborhood

  AddTitle String(5, "=") + "Non-Lender Small Income  " + IDNeigh + String(5, "=")

  ValidateStandardNeighborhoodBlock2005 1, 49

  If hasText(3, 334) Then
    num = GetValue(3, 334) / 1000
      If num > GetValue(1, 68) Then
        AddRec IDTOBERANGEMULTI, 1,68
      End If
  End If

  If hasText(3, 334) Then
     num = GetValue(3, 334) / 1000
       If num < GetValue(1, 67) Then
         AddRec IDTOBERANGEMULTI, 1,67
       End If
  End If

  Require IDNEIGHBOUND, 1, 79
  Require IDNEIGHDES, 1, 80
  Require IDNEIGHCOND, 1, 81

End Sub

Sub ReviewSite

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDSite + String(5, "=")
  
  ValidateStandardSiteBlock 1, 82

End Sub

Sub ReviewImprovements

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDIMPROV + String(5, "=")

  OnlyOneCheckOfThree 1, 125, 126, 127, INUNITS2, INUNITS2
  Require IDACCESSORY, 1, 128
  Require IDSTORIES, 1, 129
  Require IDNOBLGS, 1, 130
  OnlyOneCheckOfThree 1, 131, 132, 133, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 1, 134, 135, 136, IDEXISTING2, IDEXISTING2
  Require IDDESIGN, 1, 137
  Require IDYRBLT, 1, 138
  Require IDEFFAGE, 1, 139
  OnlyOneCheckOfFour 1, 140, 141, 142, 143, IDFOUNDATIONNOCHK, IDFOUNDATIONCHK

  If isChecked(1, 142) Then
    Require IDBASEAREA, 1, 142
    Require IDBASEFIN, 1, 143
    Require IDBASEOUTSIDE2, 1, 146
    Require IDSUMP2, 1, 147
  End If

  If isChecked(1, 143) Then
    Require IDBASEAREA, 1, 144
    Require IDBASEFIN, 1, 145
    Require IDBASEOUTSIDE2, 1, 146
    Require IDSUMP2, 1, 147
  End If

  If hasText(1, 144) Then
    OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
    Require IDBASEFIN, 1, 145
  End If

  If hasText(1, 145) Then
    OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
    Require IDBASEAREA, 1, 144
  End If

  Require IDFOUNDATION2, 1, 152
  Require IDEXT, 1, 153
  Require IDROOFSUF, 1, 154
  Require IDGUTTER, 1, 155
  Require IDWINDOWTYPE, 1, 156
  Require IDFLOOR, 1, 157
  Require IDWALLS, 1, 158
  Require IDTRIM, 1, 159
  Require IDBATHFLOOR, 1, 160
  Require IDWAINSCOT, 1, 161

' Attic
  checked = GetCheck(1, 165) + GetCheck(1, 166) + GetCheck(1, 167) + GetCheck(1, 168) + GetCheck(1, 169) + GetCheck(1, 170)
    If isChecked(1, 164) Then    '  No Attic
      If checked > 0 Then AddRec IDATTICNONE, 1, 164
    Else
      If checked = 0 Then AddRec IDATTICNOCK, 1, 164
    End If

'  No Doors
  OnlyOneCheckOfFour 1, 171, 172, 173, 174, IDHEATTYPE2, XXXXX

  If isChecked(1, 174) Then
   Require IDHEATOTHER, 1, 175
  End If
  
  Require IDHEATFUEL, 1, 176
  '  No Heating Condition
  '  No Cooling Condition

  OnlyOneCheckOfThree 1, 177, 178, 179, IDCOOLCOND2, XXXXX

  If isChecked(1, 179) Then
   Require IDCOOLOTHER, 1, 180
  End If

  'Amenities
  OnlyOneCheckOfSeven 1, 181, 183, 185, 187, 189, 191, 193, IDAMENITIES, XXXXXX 
 
  If isChecked(1, 181) Then
    Require IDFIREPLACE2, 1, 182
  End If

  If isChecked(1, 183) Then
    Require IDPATDECK, 1, 184
  End If

  If isChecked(1, 185) Then
    Require IDPOOL2, 1, 186
  End If

  If isChecked(1, 189) Then
    Require IDSTOVES2, 1, 190
  End If

  If isChecked(1, 191) Then
    Require IDFENCE2, 1, 192
  End If

  If isChecked(1, 193) Then
    Require IDPORCH2, 1, 194
  End If

  If isChecked(1, 187) Then
    Require IDOTHER2, 1, 188
  End If

  If hastext(1, 182) Then
    Require IDFIREPLACE2CK, 1, 181
  End If

  If hastext(1, 184) Then
    Require IDPATDECKCK, 1, 183
  End If

  If hastext(1, 186) Then
    Require IDPOOL2CK, 1, 185
  End If

  If isChecked(1, 190) Then
    Require IDSTOVES2CK, 1, 189
  End If

  If isChecked(1, 192) Then
    Require IDFENCE2CK, 1, 191
  End If

  If isChecked(1, 194) Then
    Require IDPORCH2CK, 1, 193
  End If

  If isChecked(1, 188) Then
    Require IDOTHER2CK, 1, 187
  End If

  checked = GetTextCheck(1, 196) + GetTextCheck(1, 199) + GetTextCheck(1, 201) + GetTextCheck(1, 203) + GetTextCheck(1, 204) + GetTextCheck(1, 205)
    if isChecked(1, 195) then
      if checked > 0 then AddRec IDCARNONE,1,195
    else
      if checked = 0 then AddRec IDCARERROR,1,195
    end if

  If isChecked(1, 196) Then
    Require IDDRIVE, 1, 197
  End If

  If isChecked(1, 196) Then
    Require IDDRIVE2, 1, 198
  End If

  If isChecked(1, 199) Then
    Require IDGARNUM, 1, 200
  End If

  If isChecked(1, 201) Then
    Require IDCARNUM, 1, 202
  End If

  If hasText(1, 200) Then
    Require IDGARNUM2, 1, 199
  End If

  If hasText(1, 202) Then
    Require IDCARNUM2, 1, 201
  End If

  If isChecked(1, 199) Then
    OnlyOneCheckOfThree 1, 203, 204, 205, IDCARERROR2, XXXXX
  End If

  OnlyOneCheckOfSix 1, 206, 207, 208, 209, 210, 211, IDAPPLIANCE, XXXXXX

  If hasText(1, 211) Then
    Require IDAPPOTHER, 1, 212
  End If

  'Room Count
  Require IDUNIT1TOTAL, 1, 213
  Require IDUNIT1BED, 1, 214
  Require IDUNIT1BATH, 1, 215
  Require IDUNIT1SQFT, 1, 216
  Require IDUNIT2TOTAL, 1, 217
  Require IDUNIT2BED, 1, 218
  Require IDUNIT2BATH, 1, 219
  Require IDUNIT2SQFT, 1, 220
  
  If isChecked(1, 126) or isChecked(1, 127) then 
    Require IDUNIT3TOTAL, 1, 221
    Require IDUNIT3BED, 1, 222
    Require IDUNIT3BATH, 1, 223
    Require IDUNIT3SQFT, 1, 224
  End If

  If isChecked(1, 127) then
    Require IDUNIT4TOTAL, 1, 225
    Require IDUNIT4BED, 1, 226
    Require IDUNIT4BATH, 1, 227
    Require IDUNIT4SQFT, 1, 228
  End If 
 
  Require IDADDFEATURESMULTI, 1, 229
  Require IDCONDITIONMULTI, 1, 230


  Require IDFILENUM, 2, 2
  OnlyOneCheckOfTwo 2, 5, 6, IDADVERSE2, XXXXX

  If isChecked(2, 6) Then
    Require IDADVERSE, 2, 7
  End If

  OnlyOneCheckOfTwo 2, 8, 9, IDCONFORM2, XXXXX

  If isChecked(2, 9) Then
    Require IDCONFORM, 1, 10
  End If

  OnlyOneCheckOfTwo 2, 11, 12, IDRENTCONTROLMULTI, XXXXX

  If isChecked(2, 11) Then
    Require IDRENTCONTROLYESMULTI, 2, 13
  End If

End Sub

Sub ReviewCompRentData

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDCOMPRENTDATA + String(5, "=")

  Require IDSUBADD, 2, 14


  If hasText(2, 15) Then
    text1 = GetText(2, 15)
    text2 = GetText(1, 7)
    text3 = GetText(1, 8)
    text4 = GetText(1, 9)
    If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
      AddRec IDADDMATCH, 2, 15
    End If
  End If

  Require IDSUBCURRENT, 2, 16
  Require IDSUBRENTGBA, 2, 17
  OnlyOneCheckOfTwo 2, 18, 19, IDRENTCONTROLSUB, XXXXX
  Require IDSUBRENTDATA, 2, 20
  Require IDSUBRENTLEASE, 2, 21
  Require IDSUBLOC, 2, 22
  Require IDSUBAGE, 2, 23
  Require IDSUBCOND, 2, 24
  Require IDSUBGBA2, 2, 25
  Require IDUNIT1TOTALSUB, 2, 26 
  Require IDUNIT1BEDSUB, 2, 27
  Require IDUNIT1BATHSUB, 2, 28
  Require IDUNIT1SQFTSUB, 2, 29
  Require IDUNIT2TOTALSUB, 2, 30 
  Require IDUNIT2BEDSUB, 2, 31
  Require IDUNIT2BATHSUB, 2, 32
  Require IDUNIT2SQFTSUB, 2, 33
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALSUB, 2, 34
    Require IDUNIT3BEDSUB, 2, 35
    Require IDUNIT3BATHSUB, 2, 36
    Require IDUNIT3SQFTSUB, 2, 37
  End If

  If isChecked(1, 127) then
    Require IDUNIT4TOTALSUB, 2, 38
    Require IDUNIT4BEDSUB, 2, 39
    Require IDUNIT4BATHSUB, 2, 40
    Require IDUNIT4SQFTSUB, 2, 41
  End If

  Require IDUTILSUB, 2, 42
  Require IDCOMP1ADD, 2, 47
  Require IDCOMP1PROX, 2, 49
  Require IDCOMP1CURRENT, 2, 50
  Require IDCOMP1RENTGBA, 2, 51
  OnlyOneCheckOfTwo 2, 52, 53, IDRENTCONTROLCOMP1, XXXXX
  Require IDCOMP1RENTDATA, 2, 54
  Require IDCOMP1RENTLEASE, 2, 55
  Require IDCOMP1LOC, 2, 56
  Require IDCOMP1AGE, 2, 57
  Require IDCOMP1COND, 2, 58
  Require IDCOMP1GBA, 2, 59
  Require IDUNIT1TOTALCOMP1, 2, 60
  Require IDUNIT1BEDCOMP1, 2, 61
  Require IDUNIT1BATHCOMP1, 2, 62
  Require IDUNIT1SQFTCOMP1, 2, 63
  Require IDUNIT1MORENTCOMP1, 2, 64
  Require IDUNIT2TOTALCOMP1, 2, 65
  Require IDUNIT2BEDCOMP1, 2, 66
  Require IDUNIT2BATHCOMP1, 2, 67
  Require IDUNIT2SQFTCOMP1, 2, 68
  Require IDUNIT2MORENTCOMP1, 2, 69
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP1, 2, 70
    Require IDUNIT3BEDCOMP1, 2, 71
    Require IDUNIT3BATHCOMP1, 2, 72
    Require IDUNIT3SQFTCOMP1, 2, 73
    Require IDUNIT3MORENTCOMP1, 2, 74
  End If  

  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP1, 2, 75
    Require IDUNIT4BEDCOMP1, 2, 76
    Require IDUNIT4BATHCOMP1, 2, 77
    Require IDUNIT4SQFTCOMP1, 2, 78
    Require IDUNIT4MORENTCOMP1, 2, 79
  End If

  Require IDUTILCOMP1, 2, 80
  Require IDCOMP2ADD, 2, 83
  Require IDCOMP2PROX, 2, 85
  Require IDCOMP2CURRENT, 2, 86
  Require IDCOMP2RENTGBA, 2, 87
  OnlyOneCheckOfTwo 2, 88, 89, IDRENTCONTROLCOMP2, XXXXX
  Require IDCOMP2RENTDATA, 2, 90
  Require IDCOMP2RENTLEASE, 2, 91
  Require IDCOMP2LOC, 2, 92
  Require IDCOMP2AGE, 2, 93
  Require IDCOMP2COND, 2, 94
  Require IDCOMP2GBA, 2, 95
  Require IDUNIT1TOTALCOMP2, 2, 96
  Require IDUNIT1BEDCOMP2, 2, 97
  Require IDUNIT1BATHCOMP2, 2, 98
  Require IDUNIT1SQFTCOMP2, 2, 99
  Require IDUNIT1MORENTCOMP2, 2, 100
  Require IDUNIT2TOTALCOMP2, 2, 101
  Require IDUNIT2BEDCOMP2, 2, 102
  Require IDUNIT2BATHCOMP2, 2, 103
  Require IDUNIT2SQFTCOMP2, 2, 104
  Require IDUNIT2MORENTCOMP2, 2, 105
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP2, 2, 106
    Require IDUNIT3BEDCOMP2, 2, 107
    Require IDUNIT3BATHCOMP2, 2, 108
    Require IDUNIT3SQFTCOMP2, 2, 109
    Require IDUNIT3MORENTCOMP2, 2, 110
  End If

  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP2, 2, 111
    Require IDUNIT4BEDCOMP2, 2, 112
    Require IDUNIT4BATHCOMP2, 2, 113
    Require IDUNIT4SQFTCOMP2, 2, 114
    Require IDUNIT4MORENTCOMP2, 2, 115
  End If 
 
  Require IDUTILCOMP2, 2, 116
  Require IDCOMP3ADD, 2, 119
  Require IDCOMP3PROX, 2, 121
  Require IDCOMP3CURRENT, 2, 122
  Require IDCOMP3RENTGBA, 2, 123
  OnlyOneCheckOfTwo 2, 124, 125, IDRENTCONTROLCOMP3, XXXXX
  Require IDCOMP3RENTDATA, 2, 126
  Require IDCOMP3RENTLEASE, 2, 127
  Require IDCOMP3LOC, 2, 128
  Require IDCOMP3AGE, 2, 129
  Require IDCOMP3COND, 2, 130
  Require IDCOMP3GBA, 2, 131
  Require IDUNIT1TOTALCOMP3, 2, 132
  Require IDUNIT1BEDCOMP3, 2, 133
  Require IDUNIT1BATHCOMP3, 2, 134
  Require IDUNIT1SQFTCOMP3, 2, 135
  Require IDUNIT1MORENTCOMP3, 2, 136
  Require IDUNIT2TOTALCOMP3, 2, 137
  Require IDUNIT2BEDCOMP3, 2, 138
  Require IDUNIT2BATHCOMP3, 2, 139
  Require IDUNIT2SQFTCOMP3, 2, 140
  Require IDUNIT2MORENTCOMP3, 2, 141
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP3, 2, 142
    Require IDUNIT3BEDCOMP3, 2, 143
    Require IDUNIT3BATHCOMP3, 2, 144
    Require IDUNIT3SQFTCOMP3, 2, 145
    Require IDUNIT3MORENTCOMP3, 2, 146
  End If  

  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP3, 2, 147
    Require IDUNIT4BEDCOMP3, 2, 148
    Require IDUNIT4BATHCOMP3, 2, 149
    Require IDUNIT4SQFTCOMP3, 2, 150
    Require IDUNIT4MORENTCOMP3, 2, 151
  End If  

  Require IDUTILCOMP3, 2, 152
  Require IDANALYSISRENT, 2, 155

End Sub


Sub ReviewSubRentSched

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDSUBRENTSCHED + String(5, "=")
  
  Require IDUNIT1LEASEBEGIN, 2, 156
  Require IDUNIT1LEASEEND, 2, 157
  Require IDUNIT1RENTUNFURNA, 2, 158
  Require IDUNIT1RENTFURNA, 2, 159
  Require IDUNIT1TOTALRENTA, 2, 160
  Require IDUNIT1RENTUNFURNO, 2, 161
  Require IDUNIT1RENTFURNO, 2, 162
  Require IDUNIT1TOTALRENTO, 2, 163
  Require IDUNIT2LEASEBEGIN, 2, 164
  Require IDUNIT2LEASEEND, 2, 165
  Require IDUNIT2RENTUNFURNA, 2, 166
  Require IDUNIT2RENTFURNA, 2, 167
  Require IDUNIT2TOTALRENTA, 2, 168
  Require IDUNIT2RENTUNFURNO, 2, 169
  Require IDUNIT2RENTFURNO, 2, 170
  Require IDUNIT2TOTALRENTO, 2, 171
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3LEASEBEGIN, 2, 172
    Require IDUNIT3LEASEEND, 2, 173
    Require IDUNIT3RENTUNFURNA, 2, 174
    Require IDUNIT3RENTFURNA, 2, 175
    Require IDUNIT3TOTALRENTA, 2, 176
    Require IDUNIT3RENTUNFURNO, 2, 177
    Require IDUNIT3RENTFURNO, 2, 178
    Require IDUNIT3TOTALRENTO, 2, 179
  End If

  If isChecked(1, 127) then
    Require IDUNIT4LEASEBEGIN, 2, 180
    Require IDUNIT4LEASEEND, 2, 181
    Require IDUNIT4RENTUNFURNA, 2, 182
    Require IDUNIT4RENTFURNA, 2, 183
    Require IDUNIT4TOTALRENTA, 2, 184
    Require IDUNIT4RENTUNFURNO, 2, 185
    Require IDUNIT4RENTFURNO, 2, 186
    Require IDUNIT4TOTALRENTO, 2, 187
  End If  

  Require IDCOMMENTLEASE, 2, 188
  Require IDTOTALACTUALRENT, 2, 189
  Require IDOTHERINCOMEACTUAL, 2, 190
  Require IDTOTALACTUALINCOME, 2, 191
  Require IDTOTALGROSSRENT, 2, 192
  Require IDOTHERINCOMEOPINION, 2, 193
  Require IDTOTALESTINCOME, 2, 194
  OnlyOneCheckOfEIGHT 2, 195, 196, 197, 198, 199, 200, 201, 202, IDUTILINCLUDED, XXXXX

  If isChecked(2, 202) Then
    Require IDOTHERUTILRENTDESC, 2, 203 
  End If

  Require IDRENTCOMMENT, 2, 204

End Sub

Sub ReviewPriorSales

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDPRIORSALES + String(5, "=")

  OnlyOneCheckOfTwo 2, 205, 206, IDRESEARCH2, XXXXX

  If isChecked(2, 206) Then
    Require IDRESEARCH, 2, 207
  End If

  OnlyOneCheckOfTwo 2, 208, 209, IDRESEARCHSUB2, XXXXX
  Require IDRESEARCHSUB3, 2, 210
  OnlyOneCheckOfTwo 2, 211, 212, IDRESEARCHCOMP2, XXXXX
  Require IDRESEARCHCOMP3, 2, 213
  Require IDDATEPSTSUB, 2, 214
  Require IDPRICEPSTSUB, 2, 215
  Require IDDATASOURCESUB, 2, 216
  Require IDDATASOURCEDATESUB, 2, 217
  Require IDDATEPSTCOMP1, 2, 218
  Require IDPRICEPSTCOMP1, 2, 219
  Require IDDATASOURCECOMP1, 2, 220
  Require IDDATASOURCEDATECOMP1, 2, 221
  Require IDDATEPSTCOMP2, 2, 222
  Require IDPRICEPSTCOMP2, 2, 223
  Require IDDATASOURCECOMP2, 2, 224 
  Require IDDATASOURCEDATECOMP2, 2, 225
  Require IDDATEPSTCOMP3, 2, 226
  Require IDPRICEPSTCOMP3, 2, 227
  Require IDDATASOURCECOMP3, 2, 228
  Require IDDATASOURCEDATECOMP3, 2, 229 
  Require IDANALYSIS2, 2, 230

End Sub

Sub ReviewSalesComparison

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDSALESAPP + String(5, "=")

  Require IDFILENUM, 3, 2
  Require IDPROPCOMP, 3, 5
  Require IDPROPCOMPFROM, 3, 6
  Require IDPROPCOMPTO, 3, 7
  Require IDSALECOMP, 3, 8
  Require IDSALECOMPFROM, 3, 9
  Require IDSALECOMPTO, 3, 10

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE2, 3, 64
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE2, 3, 146
        End If
      End If
  End If
 
  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE2, 3, 228
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num2 <= num3 and num2 <= num4 Then
        If num < num2 Then
          AddRec IDTOBERANGE2, 3, 64
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE2, 3, 146
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 64)
    num3 = GetValue(3, 146)
    num4 = GetValue(3, 228)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
          AddRec IDTOBERANGE2, 3, 228
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE3, 3, 139
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE3, 3, 221
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE3, 3, 303
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num2 <= num3 and num2 <= num4 Then
        If num < num2 Then
          AddRec IDTOBERANGE3, 3, 139
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE3, 3, 221
        End If
      End If
  End If

  If hasText(3, 334) Then
    num = GetValue(3, 334)
    num2 = GetValue(3, 139)
    num3 = GetValue(3, 221)
    num4 = GetValue(3, 303)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
          AddRec IDTOBERANGE3, 3, 303
        End If
      End If
  End If

  Require IDSUBADD, 3, 11

  If hasText(3, 12) Then
    text1 = GetText(3, 12)
    text2 = GetText(1, 7)
    text3 = GetText(1, 8)
    text4 = GetText(1, 9)
    If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
      AddRec IDADDMATCH, 3, 12
    End If
  End If
  
  If not isChecked(1, 33) Then
    Require IDSUBSALES, 3, 13
    Require IDSUBPRICEGBA1, 3, 14
  End If

  Require IDSUBGMR1, 3, 15
  Require IDSUBGRM1, 3, 16
  Require IDSUBPRICEUNIT, 3, 17
  Require IDSUBPRICEROOM, 3, 18
  Require IDSUBPRICEBED, 3, 19
  OnlyOneCheckOfTwo 3, 20, 21, IDRENTCONTROLSUB, XXXXX
  Require IDSUBLOC, 3, 27
  Require IDSUBLEASEHOLD, 3, 28
  Require IDSUBSITE, 3, 29
  Require IDSUBVIEW, 3, 30
  Require IDSUBDESIGN, 3, 31
  Require IDSUBQUAL, 3, 32
  Require IDSUBAGE, 3, 33
  Require IDSUBCOND, 3, 34
  Require IDSUBGBA2, 3, 35
  Require IDUNIT1TOTALSUB, 3, 36 
  Require IDUNIT1BEDSUB, 3, 37
  Require IDUNIT1BATHSUB, 3, 38
  Require IDUNIT2TOTALSUB, 3, 39 
  Require IDUNIT2BEDSUB, 3, 40
  Require IDUNIT2BATHSUB, 3, 41
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALSUB, 3, 42
    Require IDUNIT3BEDSUB, 3, 43
    Require IDUNIT3BATHSUB, 3, 44
  End If  

  If isChecked(1, 127) then
    Require IDUNIT4TOTALSUB, 3, 45
    Require IDUNIT4BEDSUB, 3, 46
    Require IDUNIT4BATHSUB, 3, 47
  End If  

  Require IDBASEDESCRENTSUB, 3, 48
  Require IDBASEFINRENTSUB, 3, 49
  Require IDSUBFUNC, 3, 50
  Require IDSUBHEAT, 3, 51
  Require IDSUBENERGY, 3, 52
  Require IDPARKRENTSUB, 3, 53
  Require IDSUBPORCH, 3, 54


  Require IDCOMP1ADD, 3, 61
  Require IDCOMP1PROX, 3, 62
  Require IDCOMP1SALES, 3, 63

  If hasText(3, 64) Then
    num = GetValue(3, 64) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI2, 3, 64
      End If
  End If

  If hasText(3, 64) Then
    num = GetValue(3, 64) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI2, 3, 64
      End If
  End If


  If hasText(3, 64) Then
    num = GetValue(3, 64)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE10, 3, 64
      End If
  End If

  If hasText(3, 64) Then
    num = GetValue(3, 64)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE10, 3, 64
      End If
  End If

  Require IDCOMP1PRICEGBA, 3, 65
  Require IDCOMP1GMR, 3, 66
  Require IDCOMP1GRM, 3, 67
  Require IDCOMP1PRICEUNIT, 3, 68
  Require IDCOMP1PRICEROOM, 3, 69
  Require IDCOMP1PRICEBED, 3, 70
  OnlyOneCheckOfTwo 3, 71, 72, IDRENTCONTROLCOMP1, XXXXX
  Require IDCOMP1SOURCE, 3, 73
  Require IDCOMP1VER, 3, 74
  Require IDCOMP1SF, 3, 75
  Require IDCOMP1CONC, 3, 77
  Require IDCOMP1DOS, 3, 79
  Require IDCOMP1LOC, 3, 81
  Require IDCOMP1LEASEHOLD, 3, 83
  Require IDCOMP1SITE, 3, 85
  Require IDCOMP1VIEW, 3, 87
  Require IDCOMP1DESIGN, 3, 89
  Require IDCOMP1QUAL, 3, 91
  Require IDCOMP1AGE, 3, 93
  Require IDCOMP1COND, 3, 95
  Require IDCOMP1GBA, 3, 97
  Require IDUNIT1TOTALCOMP1, 3, 100
  Require IDUNIT1BEDCOMP1, 3, 101
  Require IDUNIT1BATHCOMP1, 3, 102
  Require IDUNIT2TOTALCOMP1, 3, 104 
  Require IDUNIT2BEDCOMP1, 3, 105
  Require IDUNIT2BATHCOMP1, 3, 106
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP1, 3, 108
    Require IDUNIT3BEDCOMP1, 3, 109
    Require IDUNIT3BATHCOMP1, 3, 110
  End If
  
  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP1, 3, 112
    Require IDUNIT4BEDCOMP1, 3, 113
    Require IDUNIT4BATHCOMP1, 3, 114
  End If  

  Require IDBASEDESCRENTCOMP1, 3, 116
  Require IDBASEFINRENTCOMP1, 3, 118
  Require IDCOMP1FUNC, 3, 120
  Require IDCOMP1HEAT, 3, 122
  Require IDCOMP1ENERGY, 3, 124
  Require IDPARKRENTCOMP1, 3, 126
  Require IDCOMP1PORCH, 3, 128

  If hasText(3, 139) Then
    num = GetValue(3, 139) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI3, 3, 139
      End If
  End If

  If hasText(3, 139) Then
    num = GetValue(3, 139) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI3, 3, 139
      End If
  End If

  Require IDCOMP2ADD, 3, 143
  Require IDCOMP2PROX, 3, 145
  Require IDCOMP2SALES, 3, 146

  If hasText(3, 146) Then
    num = GetValue(3, 146) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI4, 3, 146
      End If
  End If

  If hasText(3, 146) Then
    num = GetValue(3, 146) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI4, 3, 146
      End If
  End If

  If hasText(3, 146) Then
    num = GetValue(3, 146)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE11, 3, 146
      End If
  End If

  If hasText(3, 146) Then
    num = GetValue(3, 146)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE11, 3, 146
      End If
  End If

  Require IDCOMP2PRICEGBA, 3, 147
  Require IDCOMP2GMR, 3, 148
  Require IDCOMP2GRM, 3, 149
  Require IDCOMP2PRICEUNIT, 3, 150
  Require IDCOMP2PRICEROOM, 3, 151
  Require IDCOMP2PRICEBED, 3, 152
  OnlyOneCheckOfTwo 3, 153, 154, IDRENTCONTROLCOMP1, XXXXX
  Require IDCOMP2SOURCE, 3, 155
  Require IDCOMP2VER, 3, 156
  Require IDCOMP2SF, 3, 157
  Require IDCOMP2CONC, 3, 159
  Require IDCOMP2DOS, 3, 161
  Require IDCOMP2LOC, 3, 163
  Require IDCOMP2LEASEHOLD, 3, 165
  Require IDCOMP2SITE, 3, 167
  Require IDCOMP2VIEW, 3, 169
  Require IDCOMP2DESIGN, 3, 171
  Require IDCOMP2QUAL, 3, 173
  Require IDCOMP2AGE, 3, 175
  Require IDCOMP2COND, 3, 177
  Require IDCOMP2GBA, 3, 179
  Require IDUNIT1TOTALCOMP2, 3, 182 
  Require IDUNIT1BEDCOMP2, 3, 183
  Require IDUNIT1BATHCOMP2, 3, 184
  Require IDUNIT2TOTALCOMP2, 3, 186 
  Require IDUNIT2BEDCOMP2, 3, 187
  Require IDUNIT2BATHCOMP2, 3, 188
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP2, 3, 190
    Require IDUNIT3BEDCOMP2, 3, 191
    Require IDUNIT3BATHCOMP2, 3, 192
  End If  

  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP2, 3, 194
    Require IDUNIT4BEDCOMP2, 3, 195
    Require IDUNIT4BATHCOMP2, 3, 196
  End If  

  Require IDBASEDESCRENTCOMP2, 3, 198
  Require IDBASEFINRENTCOMP2, 3, 200
  Require IDCOMP2FUNC, 3, 202
  Require IDCOMP2HEAT, 3, 204
  Require IDCOMP2ENERGY, 3, 206
  Require IDPARKRENTCOMP2, 3, 208
  Require IDCOMP2PORCH, 3, 210

  If hasText(3, 221) Then
    num = GetValue(3, 221) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI5, 3, 221
      End If
  End If

  If hasText(3, 221) Then
    num = GetValue(3, 221) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI5, 3, 221
      End If
  End If

  Require IDCOMP3ADD, 3, 225
  Require IDCOMP3PROX, 3, 227
  Require IDCOMP3SALES, 3, 228

  If hasText(3, 228) Then
    num = GetValue(3, 228) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI6, 3, 228
      End If
  End If

  If hasText(3, 228) Then
    num = GetValue(3, 228) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI6, 3, 228
      End If
  End If

  If hasText(3, 228) Then
    num = GetValue(3, 228)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE12, 3, 228
      End If
  End If

  If hasText(3, 228) Then
    num = GetValue(3, 228)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE12, 3, 228
      End If
  End If

  Require IDCOMP3PRICEGBA, 3, 229
  Require IDCOMP3GMR, 3, 230
  Require IDCOMP3GRM, 3, 231
  Require IDCOMP3PRICEUNIT, 3, 232
  Require IDCOMP3PRICEROOM, 3, 233
  Require IDCOMP3PRICEBED, 3, 234
  OnlyOneCheckOfTwo 3, 235, 236, IDRENTCONTROLCOMP3, XXXXX
  Require IDCOMP3SOURCE, 3, 237
  Require IDCOMP3VER, 3, 238
  Require IDCOMP3SF, 3, 239
  Require IDCOMP3CONC, 3, 241
  Require IDCOMP3DOS, 3, 243
  Require IDCOMP3LOC, 3, 245
  Require IDCOMP3LEASEHOLD, 3, 247
  Require IDCOMP3SITE, 3, 249
  Require IDCOMP3VIEW, 3, 251
  Require IDCOMP3DESIGN, 3, 253
  Require IDCOMP3QUAL, 3, 255
  Require IDCOMP3AGE, 3, 257
  Require IDCOMP3COND, 3, 259
  Require IDCOMP3GBA, 3, 261
  Require IDUNIT1TOTALCOMP3, 3, 264 
  Require IDUNIT1BEDCOMP3, 3, 265
  Require IDUNIT1BATHCOMP3, 3, 266
  Require IDUNIT2TOTALCOMP3, 3, 268 
  Require IDUNIT2BEDCOMP3, 3, 269
  Require IDUNIT2BATHCOMP3, 3, 270
  
  If isChecked(1, 126) or isChecked(1, 127) then
    Require IDUNIT3TOTALCOMP3, 3, 272
    Require IDUNIT3BEDCOMP3, 3, 273
    Require IDUNIT3BATHCOMP3, 3, 274
  End If  

  If isChecked(1, 127) then
    Require IDUNIT4TOTALCOMP3, 3, 276
    Require IDUNIT4BEDCOMP3, 3, 277
    Require IDUNIT4BATHCOMP3, 3, 278
  End If  

  Require IDBASEDESCRENTCOMP3, 3, 280
  Require IDBASEFINRENTCOMP3, 3, 282
  Require IDCOMP3FUNC, 3, 284
  Require IDCOMP3HEAT, 3, 286
  Require IDCOMP3ENERGY, 3, 288
  Require IDPARKRENTCOMP3, 3, 290
  Require IDCOMP3PORCH, 3, 292
  
  If hasText(3, 303) Then
    num = GetValue(3, 303) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGEMULTI7, 3, 303
      End If
  End If

  If hasText(3, 303) Then
    num = GetValue(3, 303) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGEMULTI7, 3, 303
      End If
  End If


  Require IDADJUNITCOMP1, 3, 140
  Require IDADJROOMCOMP1, 3, 141
  Require IDADJBEDCOMP1, 3, 142
  Require IDADJUNITCOMP2, 3, 222
  Require IDADJROOMCOMP2, 3, 223
  Require IDADJBEDCOMP2, 3, 224
  Require IDADJUNITCOMP3, 3, 304
  Require IDADJROOMCOMP3, 3, 305
  Require IDADJBEDCOMP3, 3, 306
  Require IDVALUNIT, 3, 307
  Require IDUNITRENT, 3, 308
  Require IDVALUNITTOTAL, 3, 309
  Require IDVALROOM, 3, 310
  Require IDROOMRENT, 3, 311
  Require IDVALROOMTOTAL, 3, 312
  Require IDVALGBA, 3, 313
  Require IDGBARENT, 3, 314
  Require IDVALGBATOTAL, 3, 315
  Require IDVALBED, 3, 316
  Require IDBEDRENT, 3, 317
  Require IDVALBEDTOTAL, 3, 318
  Require IDSUMMARYSALES, 3, 319

  If Not hasText(3, 320) Then
    AddRec IDTOBE, 3, 320
  End If

End Sub

Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDINCOME + String(5, "=")
  
  Require IDINCOMERENT2, 3, 321
  Require IDINCOMEGRM2, 3, 322
  Require IDINCOMEVALUE2, 3, 323 
  Require IDSUMMARYINCOME, 3, 324

End Sub

Sub ReviewReconciliation

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDRECON + String(5, "=")

  If Not hasText(3, 325) Then
    AddRec IDTOBE, 3, 325
  End If

  Require IDINCOMEVALUE2, 3, 326
  Require IDCOSTVALUEREC, 3, 327
  OnlyOneCheckOfFour 3, 329, 330, 331, 332, IDSTATUSNOCHK, IDSTATUSCHK

  If isChecked(3, 331) Then
    Require IDCONDCOMM, 3, 333
  End If

  If isChecked(3, 332) Then
    Require IDCONDCOMM, 3, 333
  End If

  If Not hasText(3, 334) Then
    AddRec IDTOBE, 3, 334
  End If

  Require IDASOF, 3, 335

End Sub

Sub ReviewCostApproach

  AddTitle String(5, "=") + "Non-Lender Small Income " + IDCOSTAPP + String(5, "=")

  Require IDFILENUM, 4, 2
  Require IDOPINCOST, 4, 6 
  OnlyOneCheckOfTwo 4, 7, 8, IDREPCOST, XXXXX
  Require IDSOURCECOST, 4, 9  
  Require IDQUALITYCOST, 4, 10  
  Require IDEFFDATECOST, 4, 11
  Require IDCOMMCOST, 4, 12
  Require IDECONLIFECOST, 4, 13  
  Require IDOPINIONCOST, 4, 14
  Require IDDWELLSQFTCOST, 4, 15 
  Require IDDWELLAMTCOST, 4, 16
  Require IDDWELLAMTCALCCOST, 4, 17 
  Require IDGARCOSTSQFTCOST, 4, 24
  Require IDGARAMTCOST, 4, 25
  Require IDGARAMTCALCCOST, 4, 26 
  Require IDTECNCOST, 4, 27
  Require IDPHYSICALCOST, 4, 28 
  Require IDFUNCCOST, 4, 30
  Require IDEXTCOST, 4, 32
  Require IDDEPPHYSICALCOST, 4, 29 
  Require IDDEPFUNCOST, 4, 31
  Require IDDEPEXTCOST, 4, 33
  Require IDDEPTOTALCOST, 4, 34 
  Require IDDEPCOSTOFIMPCOST, 4, 35 
  Require IDASISCOST, 4, 36
  Require IDINDVALCOST, 4, 37 

  If hasText(4, 37) Then
    num = GetValue(3, 327)
      If not num = GetValue(4, 37) Then
        AddRec IDCOSTNOTEQUAL, 4, 37
      End If
  End If

End Sub

Sub ReviewPUD
  AddTitle String(5, "=") + "Non-Lender Small Income " + IDPUD + String(5, "=")

  If isChecked(1, 24) Then
    OnlyOneCheckOfTwo 4, 38, 39, IDCONTROLPUD, XXXXX
    OnlyOneCheckOfTwo 4, 40, 41, IDUNITTYPEPUD, XXXXX
  End If

  If isChecked(4, 38) and isChecked(4, 41) Then
   Require IDLEGALPUD, 4, 42
   Require IDPHASES, 4, 43
   Require IDUNITS, 4, 44
   Require IDUNITSOLD, 4, 45
   Require IDUNITRENT, 4, 46
   Require IDUNITSALE, 4, 47
   Require IDDATASOURCE, 4, 48
   OnlyOneCheckOfTwo 4, 49, 50, IDCONVERSIONPUD, XXXXX
    
    If isChecked(4, 49) Then
     Require IDDATECONVERTPUD, 4, 51
    End If
    
    OnlyOneCheckOfTwo 4, 52, 53, IDMULTIPUD, XXXXX
   Require IDDATEDSPUD, 4, 54
    OnlyOneCheckOfTwo 4, 55, 56, IDCOMPLETEPUD, XXXXX
    
    If isChecked(4, 56) Then
     Require IDCOMPLETESTATUSPUD, 4, 57
    End If
    
    OnlyOneCheckOfTwo 4, 58, 59, IDHOACOMMONPUD, XXXXX
      
    If isChecked(4, 58) Then
     Require IDRENTALTERMSPUD, 4, 60
    End If

   Require IDELEMENTSPUD, 4, 61
  End If   

End Sub
