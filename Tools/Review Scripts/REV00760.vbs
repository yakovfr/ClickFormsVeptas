'FM00760.vbs Non-Lender Condo Extra Comps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 54
cmpOffset = 69

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
   AddTitle String(5, "=") + "Non-Lender Condo Extra Comparables" + String(5, "=")
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
   Require IDSUBUNITNO, 1, 15
   Require IDSUBNAME, 1, 16
   Require IDSUBPHASE, 1, 17
   Require IDSUBLOC, 1, 25
   Require IDSUBLEASEHOLD, 1, 26
   Require IDSUBHOA, 1, 27
   Require IDSUBCOMELE, 1, 28
   Require IDSUBRECFAC, 1, 29
   Require IDSUBFLOORLOC, 1, 30
   Require IDSUBVIEW, 1, 31
   Require IDSUBDESIGN, 1, 32
   Require IDSUBQUAL, 1, 33
   Require IDSUBAGE, 1, 34
   Require IDSUBCOND, 1, 35
   Require IDSUBROOMS, 1, 36
   Require IDSUBBED, 1, 37
   Require IDSUBBATHS, 1, 38
   Require IDSUBGLA, 1, 39
   Require IDSUBBASE, 1, 40
   Require IDSUBBASEPER, 1, 41
   Require IDSUBFUNC, 1, 42
   Require IDSUBHEAT, 1, 43
   Require IDSUBENERGY, 1, 44
   Require IDSUBGARAGE, 1, 45
   Require IDSUBPORCH, 1, 46
   Require IDDATEPSTSUB, 1, 260
   Require IDPRICEPSTSUB, 1, 261
   Require IDDATASOURCESUB, 1, 262
   Require IDDATASOURCEDATESUB, 1, 263
   Require IDSUMMARYSALES, 1, 279
End Sub


Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 54) Then
     Require IDCOMP + IDCOMPADD, 1, 54
     Require IDCOMP + IDCOMPUNITNO, 1, 55
     Require IDCOMP + IDCOMPNAME, 1, 56
     Require IDCOMP + IDCOMPPHASE, 1, 57
     Require IDCOMP + IDCOMPPROX, 1, 58
     Require IDCOMP + IDCOMPSALES, 1, 59
     Require IDCOMP + IDCOMPPRGLA, 1, 60
     Require IDCOMP + IDCOMPSOURCE, 1, 61
     Require IDCOMP + IDCOMPVER, 1, 62
     Require IDCOMP + IDCOMPSF, 1, 63
     Require IDCOMP + IDCOMPCONC, 1, 65
     Require IDCOMP + IDCOMPDOS, 1, 67
     Require IDCOMP + IDCOMPLOC, 1, 69
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 71
     Require IDCOMP + IDCOMPHOA, 1, 73
     Require IDCOMP + IDCOMPCOMELE, 1, 75
     Require IDCOMP + IDCOMPRECFAC, 1, 77
     Require IDCOMP + IDCOMPFLOORLOC, 1, 79
     Require IDCOMP + IDCOMPVIEW, 1, 81
     Require IDCOMP + IDCOMPDESIGN, 1, 83
     Require IDCOMP + IDCOMPQUAL, 1, 85
     Require IDCOMP + IDCOMPAGE, 1, 87
     Require IDCOMP + IDCOMPCOND, 1, 89
     Require IDCOMP + IDCOMPROOMS, 1, 92
     Require IDCOMP + IDCOMPBED, 1, 93
     Require IDCOMP + IDCOMPBATHS, 1, 94
     Require IDCOMP + IDCOMPGLA, 1, 96
     Require IDCOMP + IDCOMPBASE, 1, 98
     Require IDCOMP + IDCOMPBASEPER, 1, 100
     Require IDCOMP + IDCOMPFUNC, 1, 102
     Require IDCOMP + IDCOMPHEAT, 1, 104
     Require IDCOMP + IDCOMPENERGY, 1, 106
     Require IDCOMP + IDCOMPGARAGE, 1, 108
     Require IDCOMP + IDCOMPPORCH, 1, 110
     Require IDCOMP + IDDATEPSTCOMP, 1, 265
     Require IDCOMP + IDPRICEPSTCOMP, 1, 266
     Require IDCOMP + IDDATASOURCECOMP, 1, 267
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 268
   End If
End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "  
   If hasText(1, 123) Then
     Require IDCOMP + IDCOMPADD, 1, 123
     Require IDCOMP + IDCOMPUNITNO, 1, 124
     Require IDCOMP + IDCOMPNAME, 1, 125
     Require IDCOMP + IDCOMPPHASE, 1, 126
     Require IDCOMP + IDCOMPPROX, 1, 127
     Require IDCOMP + IDCOMPSALES, 1, 128
     Require IDCOMP + IDCOMPPRGLA, 1, 129
     Require IDCOMP + IDCOMPSOURCE, 1, 130
     
     Require IDCOMP + IDCOMPVER, 1, 131
     Require IDCOMP + IDCOMPSF, 1, 132
     Require IDCOMP + IDCOMPCONC, 1, 134
     Require IDCOMP + IDCOMPDOS, 1, 136
     Require IDCOMP + IDCOMPLOC, 1, 138
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 140
     Require IDCOMP + IDCOMPHOA, 1, 142
     Require IDCOMP + IDCOMPCOMELE, 1, 144
     Require IDCOMP + IDCOMPRECFAC, 1, 146
     Require IDCOMP + IDCOMPFLOORLOC, 1, 148
     Require IDCOMP + IDCOMPVIEW, 1, 150
     Require IDCOMP + IDCOMPDESIGN, 1, 152
     Require IDCOMP + IDCOMPQUAL, 1, 154
     Require IDCOMP + IDCOMPAGE, 1, 156
     Require IDCOMP + IDCOMPCOND, 1, 158
     Require IDCOMP + IDCOMPROOMS, 1, 161
     Require IDCOMP + IDCOMPBED, 1, 162
     Require IDCOMP + IDCOMPBATHS, 1, 163
     Require IDCOMP + IDCOMPGLA, 1, 165
     Require IDCOMP + IDCOMPBASE, 1, 167
     Require IDCOMP + IDCOMPBASEPER, 1, 169
     Require IDCOMP + IDCOMPFUNC, 1, 171
     Require IDCOMP + IDCOMPHEAT, 1, 173
     Require IDCOMP + IDCOMPENERGY, 1, 175
     Require IDCOMP + IDCOMPGARAGE, 1, 177
     Require IDCOMP + IDCOMPPORCH, 1, 179
     Require IDCOMP + IDDATEPSTCOMP, 1, 270
     Require IDCOMP + IDPRICEPSTCOMP, 1, 271
     Require IDCOMP + IDDATASOURCECOMP, 1, 272
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 273
   End If
End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 192) Then
     Require IDCOMP + IDCOMPADD, 1, 192
     Require IDCOMP + IDCOMPUNITNO, 1, 193
     Require IDCOMP + IDCOMPNAME, 1, 194
     Require IDCOMP + IDCOMPPHASE, 1, 195
     Require IDCOMP + IDCOMPPROX, 1, 196
     Require IDCOMP + IDCOMPSALES, 1, 197
     Require IDCOMP + IDCOMPPRGLA, 1, 198
     Require IDCOMP + IDCOMPSOURCE, 1, 199
     Require IDCOMP + IDCOMPVER, 1, 200
     Require IDCOMP + IDCOMPSF, 1, 201
     Require IDCOMP + IDCOMPCONC, 1, 203
     Require IDCOMP + IDCOMPDOS, 1, 205
     Require IDCOMP + IDCOMPLOC, 1, 207
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 209
     Require IDCOMP + IDCOMPHOA, 1, 211
     Require IDCOMP + IDCOMPCOMELE, 1, 213
     Require IDCOMP + IDCOMPRECFAC, 1, 215
     Require IDCOMP + IDCOMPFLOORLOC, 1, 217
     Require IDCOMP + IDCOMPVIEW, 1, 219
     Require IDCOMP + IDCOMPDESIGN, 1, 221
     Require IDCOMP + IDCOMPQUAL, 1, 223
     Require IDCOMP + IDCOMPAGE, 1, 225
     Require IDCOMP + IDCOMPCOND, 1, 227
     Require IDCOMP + IDCOMPROOMS, 1, 230
     Require IDCOMP + IDCOMPBED, 1, 231
     Require IDCOMP + IDCOMPBATHS, 1, 232
     Require IDCOMP + IDCOMPGLA, 1, 234
     Require IDCOMP + IDCOMPBASE, 1, 236
     Require IDCOMP + IDCOMPBASEPER, 1, 238
     Require IDCOMP + IDCOMPFUNC, 1, 240
     Require IDCOMP + IDCOMPHEAT, 1, 242
     Require IDCOMP + IDCOMPENERGY, 1, 244
     Require IDCOMP + IDCOMPGARAGE, 1, 246
     Require IDCOMP + IDCOMPPORCH, 1, 248
     Require IDCOMP + IDDATEPSTCOMP, 1, 275
     Require IDCOMP + IDPRICEPSTCOMP, 1, 276
     Require IDCOMP + IDDATASOURCECOMP, 1, 277
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 278
   End If
End Sub
