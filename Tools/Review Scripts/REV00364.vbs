'FM00364.vbs 1025 - 2000A Extra Comps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 65
cmpOffset = 83

Sub ReviewForm
   ReviewSalesComparison  
   ReviewSalesApproach
   ReviewSalesApproach2
   ReviewSalesApproach3
   AddTitle ""
end Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewSalesApproach
 for pageCmpNo = 1 to 1
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSalesApproach2
 for pageCmpNo = 2 to 2
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSalesComp2 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSalesApproach3
 for pageCmpNo = 3 to 3
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSalesComp3 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSalesComparison
   AddTitle String(5, "=") + "FNMA 1025/2000A Extra Comparables" + String(5, "=")
   Require IDFILENUM, 1, 3
   Require IDBorrower, 1, 6
   Require IDAddress, 1, 7
   Require IDCity, 1, 8
   Require IDCounty, 1, 9
   Require IDState, 1, 10
   Require IDZip, 1, 11
   Require IDLender, 1, 12
   Require IDLenderAdd, 1, 13
   Require IDSUBADD, 1, 14
   Require IDSUBCITY, 1, 15
   Require IDSUBGMR1, 1, 18
   Require IDSUBGRM1, 1, 19   
   Require IDSUBPRICEUNIT, 1, 20
   Require IDSUBPRICEROOM, 1, 21
   Require IDSUBPRICEBED, 1, 22
   OnlyOneCheckOfTwo 1, 23, 24, IDRENTCONTROLSUB, "SUBJECT RENT CONTROL: Both Yes and No are Checked"
   Require IDSUBLOC, 1, 30
   Require IDSUBLEASEHOLD, 1, 31
   Require IDSUBSITE, 1, 32
   Require IDSUBVIEW, 1, 33
   Require IDSUBDESIGN, 1, 34
   Require IDSUBQUAL, 1, 35
   Require IDSUBAGE, 1, 36
   Require IDSUBCOND, 1, 37
   Require IDSUBGBA2, 1, 38
   Require IDUNIT1TOTALSUB, 1, 39 
   Require IDUNIT1BEDSUB, 1, 40
   Require IDUNIT1BATHSUB, 1, 41
   Require IDUNIT2TOTALSUB, 1, 42 
   Require IDUNIT2BEDSUB, 1, 43
   Require IDUNIT2BATHSUB, 1, 44
   Require IDUNIT3TOTALSUB, 1, 45
   Require IDUNIT3BEDSUB, 1, 46
   Require IDUNIT3BATHSUB, 1, 47
   Require IDUNIT4TOTALSUB, 1, 48
   Require IDUNIT4BEDSUB, 1, 49
   Require IDUNIT4BATHSUB, 1, 50
   Require IDBASEDESCRENTSUB, 1, 51
   If not ((GetText(1, 51) = "0sf") or (GetText(1, 51) = "0sqm")) Then
     Require IDBASEFINRENTSUB, 1, 52
   End If
   Require IDSUBFUNC, 1, 53
   Require IDSUBHEAT, 1, 54
   Require IDSUBENERGY, 1, 55
   Require IDPARKRENTSUB, 1, 56
   Require IDSUBPORCH, 1, 57
   Require IDDATEPSTSUB, 1, 313
   Require IDPRICEPSTSUB, 1, 314
   Require IDDATASOURCESUB, 1, 315
   Require IDDATASOURCEDATESUB, 1, 316
   Require IDSUMMARYSALES, 1, 332
End Sub


Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 60) Then
     Require IDCOMP + IDCOMPADD, 1, 65
     Require IDCOMP + IDCOMPCITY, 1, 66
     Require IDCOMP + IDCOMPPROX, 1, 67
     Require IDCOMP + IDCOMPSALES, 1, 68
     Require IDCOMP + IDCOMPPRICEGBA, 1, 69
     Require IDCOMP + IDCOMPGMR, 1, 70
     Require IDCOMP + IDCOMPGRM, 1, 71
     Require IDCOMP + IDCOMPPRICEUNIT, 1, 72
     Require IDCOMP + IDCOMPPRICEROOM, 1, 73
     Require IDCOMP + IDCOMPPRICEBED, 1, 74
     OnlyOneCheckOfTwo 1, 75, 76, IDCOMP + IDRENTCONTROLCOMP, IDCOMP + "RENT CONTROL: Both Yes and No are Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 77
     Require IDCOMP + IDCOMPVER, 1, 78
     Require IDCOMP + IDCOMPSF, 1, 79
     Require IDCOMP + IDCOMPCONC, 1, 81
     Require IDCOMP + IDCOMPDOS, 1, 83
     Require IDCOMP + IDCOMPLOC, 1, 85
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 87
     Require IDCOMP + IDCOMPSITE, 1, 89
     Require IDCOMP + IDCOMPVIEW, 1, 91
     Require IDCOMP + IDCOMPDESIGN, 1, 93
     Require IDCOMP + IDCOMPQUAL, 1, 95
     Require IDCOMP + IDCOMPAGE, 1, 97
     Require IDCOMP + IDCOMPCOND, 1, 99
     Require IDCOMP + IDCOMPGBA, 1, 101
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 104
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 105
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 106
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 108
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 109
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 110
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 112
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 113
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 114
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 116
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 117
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 118
     Require IDCOMP + IDBASEDESCRENTCOMP, 1, 120
     If not ((GetText(1, 120) = "0sf") or (GetText(1, 120) = "0sqm")) Then
       Require IDCOMP + IDBASEFINRENTCOMP, 1, 122
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 124
     Require IDCOMP + IDCOMPHEAT, 1, 126
     Require IDCOMP + IDCOMPENERGY, 1, 128
     Require IDCOMP + IDPARKRENTCOMP, 1, 130
     Require IDCOMP + IDCOMPPORCH, 1, 132
     Require IDCOMP + IDDATEPSTCOMP, 1, 318
     Require IDCOMP + IDPRICEPSTCOMP, 1, 319
     Require IDCOMP + IDDATASOURCECOMP, 1, 320
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 321
   End If
End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 148) Then
     Require IDCOMP + IDCOMPADD, 1, 148
     Require IDCOMP + IDCOMPCITY, 1, 149
     Require IDCOMP + IDCOMPPROX, 1, 150
     Require IDCOMP + IDCOMPSALES, 1, 151
     Require IDCOMP + IDCOMPPRICEGBA, 1, 152
     Require IDCOMP + IDCOMPGMR, 1, 153
     Require IDCOMP + IDCOMPGRM, 1, 154
     Require IDCOMP + IDCOMPPRICEUNIT, 1, 155
     Require IDCOMP + IDCOMPPRICEROOM, 1, 156
     Require IDCOMP + IDCOMPPRICEBED, 1, 157
     OnlyOneCheckOfTwo 1, 158, 159, IDCOMP + IDRENTCONTROLCOMP, IDCOMP + "RENT CONTROL: Both Yes and No are Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 160
     Require IDCOMP + IDCOMPVER, 1, 161
     Require IDCOMP + IDCOMPSF, 1, 162
     Require IDCOMP + IDCOMPCONC, 1, 164
     Require IDCOMP + IDCOMPDOS, 1, 166
     Require IDCOMP + IDCOMPLOC, 1, 168
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 170
     Require IDCOMP + IDCOMPSITE, 1, 172
     Require IDCOMP + IDCOMPVIEW, 1, 174
     Require IDCOMP + IDCOMPDESIGN, 1, 176
     Require IDCOMP + IDCOMPQUAL, 1, 178
     Require IDCOMP + IDCOMPAGE, 1, 180
     Require IDCOMP + IDCOMPCOND, 1, 182
     Require IDCOMP + IDCOMPGBA, 1, 184
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 187
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 188
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 189
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 191
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 192
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 193
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 195
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 196
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 197
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 199
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 200
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 201
     Require IDCOMP + IDBASEDESCRENTCOMP, 1, 203
     If not ((GetText(1, 203) = "0sf") or (GetText(1, 203) = "0sqm")) Then
       Require IDCOMP + IDBASEFINRENTCOMP, 1, 205
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 207
     Require IDCOMP + IDCOMPHEAT, 1, 209
     Require IDCOMP + IDCOMPENERGY, 1, 211
     Require IDCOMP + IDPARKRENTCOMP, 1, 213
     Require IDCOMP + IDCOMPPORCH, 1, 215
     Require IDCOMP + IDDATEPSTCOMP, 1, 323
     Require IDCOMP + IDPRICEPSTCOMP, 1, 324
     Require IDCOMP + IDDATASOURCECOMP, 1, 325
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 326
   End If
End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 231) Then
     Require IDCOMP + IDCOMPADD, 1, 231
     Require IDCOMP + IDCOMPCITY, 1, 232
     Require IDCOMP + IDCOMPPROX, 1, 233
     Require IDCOMP + IDCOMPSALES, 1, 234
     Require IDCOMP + IDCOMPPRICEGBA, 1, 235
     Require IDCOMP + IDCOMPGMR, 1, 236
     Require IDCOMP + IDCOMPGRM, 1, 237
     Require IDCOMP + IDCOMPPRICEUNIT, 1, 238
     Require IDCOMP + IDCOMPPRICEROOM, 1, 239
     Require IDCOMP + IDCOMPPRICEBED, 1, 240
     OnlyOneCheckOfTwo 1, 241, 242, IDCOMP + IDRENTCONTROLCOMP, IDCOMP + "RENT CONTROL: Both Yes and No are Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 243
     Require IDCOMP + IDCOMPVER, 1, 244
     Require IDCOMP + IDCOMPSF, 1, 245
     Require IDCOMP + IDCOMPCONC, 1, 247
     Require IDCOMP + IDCOMPDOS, 1, 249
     Require IDCOMP + IDCOMPLOC, 1, 251
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 253
     Require IDCOMP + IDCOMPSITE, 1, 255
     Require IDCOMP + IDCOMPVIEW, 1, 257
     Require IDCOMP + IDCOMPDESIGN, 1, 259
     Require IDCOMP + IDCOMPQUAL, 1, 261
     Require IDCOMP + IDCOMPAGE, 1, 263
     Require IDCOMP + IDCOMPCOND, 1, 265
     Require IDCOMP + IDCOMPGBA, 1, 267
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 270
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 271
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 272
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 274
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 275
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 276
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 278
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 279
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 280
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 282
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 283
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 284
     Require IDCOMP + IDBASEDESCRENTCOMP, 1, 286
     If not ((GetText(1, 286) = "0sf") or (GetText(1, 286) = "0sqm")) Then
       Require IDCOMP + IDBASEFINRENTCOMP, 1, 288
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 290
     Require IDCOMP + IDCOMPHEAT, 1, 292
     Require IDCOMP + IDCOMPENERGY, 1, 294
     Require IDCOMP + IDPARKRENTCOMP, 1, 296
     Require IDCOMP + IDCOMPPORCH, 1, 298
     Require IDCOMP + IDDATEPSTCOMP, 1, 328
     Require IDCOMP + IDPRICEPSTCOMP, 1, 329
     Require IDCOMP + IDDATASOURCECOMP, 1, 330
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 331 
   End If
End Sub