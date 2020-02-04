'FM00366.vbs 2090 and 2095 Extra Comps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 58
cmpOffset = 77

Sub ReviewForm
     ReviewSalesComparison  
     ReviewSalesApproach
     ReviewSalesApproach2
     ReviewSalesApproach3
   AddTitle ""
End Sub

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
   AddTitle String(5, "=") + "FNMA 2090/2095 EXTRA COMPARABLES " + String(5, "=")
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
     Require IDSUBPRPERSHARE, 1, 19
     Require IDSUBLOC, 1, 25
     Require IDSUBPRJSIZENUM, 1, 26
     Require IDSUBVIEW, 1, 27
     Require IDSUBFLOORLOC, 1, 28
     Require IDSUBMOMAINFEE, 1, 29
     Require IDSUBPRJAMEN, 1, 30
     Require IDSUBFACILITIES, 1, 31
     Require IDSUBPRJSECUR, 1, 32
     Require IDSUBFEATURES, 1, 33
     Require IDSUBDESIGN, 1, 34
     Require IDSUBQUAL, 1, 35
     Require IDSUBAGE, 1, 36
     Require IDSUBCOND, 1, 37
     Require IDSUBREMODEL, 1, 38
     Require IDSUBKITCHBATH, 1, 39
     Require IDSUBROOMS, 1, 40
     Require IDSUBBED, 1, 41
     Require IDSUBBATHS, 1, 42
     Require IDSUBGLA, 1, 43
     Require IDSUBBASE, 1, 44
     If not ((GetText(1, 44) = "0sf") or (GetText(1, 44) = "0sqm")) Then
       Require IDSUBBASEPER, 1, 45
     End If
     Require IDSUBFUNC, 1, 46
     Require IDSUBHEAT, 1, 47
     Require IDSUBENERGY, 1, 48
     Require IDSUBGARAGE, 1, 49
     Require IDSUBPORCH, 1, 50
     Require IDDATEPSTSUB, 1, 288
     Require IDPRICEPSTSUB, 1, 289
     Require IDDATASOURCESUB, 1, 290
     Require IDDATASOURCEDATESUB, 1, 291 
     Require IDANALYSIS2, 1, 307
     Require IDSUMMARYSALES, 1, 308
End Sub


Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 58) Then
     Require IDCOMP + IDCOMPADD, 1, 58
     Require IDCOMP + IDCOMPUNITNO, 1, 59
     Require IDCOMP + IDCOMPNAME, 1, 60
     Require IDCOMP + IDCOMPPROX, 1, 61
     Require IDCOMP + IDCOMPSALES, 1, 62
     Require IDCOMP + IDCOMPPRGLA, 1, 63
     Require IDCOMP + IDCOMPPRPERSHARE, 1, 64
     Require IDCOMP + IDCOMPSOURCE, 1, 65
     Require IDCOMP + IDCOMPVER, 1, 66
     Require IDCOMP + IDCOMPSF, 1, 67
     Require IDCOMP + IDCOMPCONC, 1, 69
     Require IDCOMP + IDCOMPDOS, 1, 71
     Require IDCOMP + IDCOMPLOC, 1, 73
     Require IDCOMP + IDCOMPPRJSIZENUM, 1, 75
     Require IDCOMP + IDCOMPVIEW, 1, 77
     Require IDCOMP + IDCOMPFLOORLOC, 1, 79
     Require IDCOMP + IDCOMPMOMAINFEE, 1, 81
     Require IDCOMP + IDCOMPPRJAMEN, 1, 83
     Require IDCOMP + IDCOMPFACILITIES, 1, 85
     Require IDCOMP + IDCOMPPRJSECUR, 1, 87
     Require IDCOMP + IDCOMPFEATURES, 1, 89
     Require IDCOMP + IDCOMPDESIGN, 1, 91
     Require IDCOMP + IDCOMPQUAL, 1, 93
     Require IDCOMP + IDCOMPAGE, 1, 95
     Require IDCOMP + IDCOMPCOND, 1, 97
     Require IDCOMP + IDCOMPREMODEL, 1, 99
     Require IDCOMP + IDCOMPKITCHBATH, 1, 101
     Require IDCOMP + IDCOMPROOMS, 1, 104
     Require IDCOMP + IDCOMPBED, 1, 105
     Require IDCOMP + IDCOMPBATHS, 1, 106
     Require IDCOMP + IDCOMPGLA, 1, 108
     Require IDCOMP + IDCOMPBASE, 1, 110
     If not ((GetText(1, 110) = "0sf") or (GetText(1, 110) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 112
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 114
     Require IDCOMP + IDCOMPHEAT, 1, 116
     Require IDCOMP + IDCOMPENERGY, 1, 118
     Require IDCOMP + IDCOMPGARAGE, 1, 120
     Require IDCOMP + IDCOMPPORCH, 1, 122
     Require IDCOMP + IDDATEPSTCOMP, 1, 293
     Require IDCOMP + IDPRICEPSTCOMP, 1, 294
     Require IDCOMP + IDDATASOURCECOMP, 1, 295
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 296   
   End If
End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 135) Then
     Require IDCOMP + IDCOMPADD, 1, 135
     Require IDCOMP + IDCOMPUNITNO, 1, 136
     Require IDCOMP + IDCOMPNAME, 1, 137
     Require IDCOMP + IDCOMPPROX, 1, 138
     Require IDCOMP + IDCOMPSALES, 1, 139
     Require IDCOMP + IDCOMPPRGLA, 1, 140
     Require IDCOMP + IDCOMPPRPERSHARE, 1, 141
     Require IDCOMP + IDCOMPSOURCE, 1, 142
     Require IDCOMP + IDCOMPVER, 1, 143
     Require IDCOMP + IDCOMPSF, 1, 144
     Require IDCOMP + IDCOMPCONC, 1, 146
     Require IDCOMP + IDCOMPDOS, 1, 148
     Require IDCOMP + IDCOMPLOC, 1, 150
     Require IDCOMP + IDCOMPPRJSIZENUM, 1, 152
     Require IDCOMP + IDCOMPVIEW, 1, 154
     Require IDCOMP + IDCOMPFLOORLOC, 1, 156
     Require IDCOMP + IDCOMPMOMAINFEE, 1, 158
     Require IDCOMP + IDCOMPPRJAMEN, 1, 160
     Require IDCOMP + IDCOMPFACILITIES, 1, 162
     Require IDCOMP + IDCOMPPRJSECUR, 1, 164
     Require IDCOMP + IDCOMPFEATURES, 1, 166
     Require IDCOMP + IDCOMPDESIGN, 1, 168
     Require IDCOMP + IDCOMPQUAL, 1, 170
     Require IDCOMP + IDCOMPAGE, 1, 172
     Require IDCOMP + IDCOMPCOND, 1, 174
     Require IDCOMP + IDCOMPREMODEL, 1, 176
     Require IDCOMP + IDCOMPKITCHBATH, 1, 178
     Require IDCOMP + IDCOMPROOMS, 1, 181
     Require IDCOMP + IDCOMPBED, 1, 182
     Require IDCOMP + IDCOMPBATHS, 1, 183
     Require IDCOMP + IDCOMPGLA, 1, 185
     Require IDCOMP + IDCOMPBASE, 1, 187
     If not ((GetText(1, 187) = "0sf") or (GetText(1, 187) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 189
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 191
     Require IDCOMP + IDCOMPHEAT, 1, 193
     Require IDCOMP + IDCOMPENERGY, 1, 195
     Require IDCOMP + IDCOMPGARAGE, 1, 197
     Require IDCOMP + IDCOMPPORCH, 1, 199
     Require IDCOMP + IDDATEPSTCOMP, 1, 298
     Require IDCOMP + IDPRICEPSTCOMP, 1, 299
     Require IDCOMP + IDDATASOURCECOMP, 1, 300
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 301
   End If
End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 212) Then
     Require IDCOMP + IDCOMPADD, 1, 212
     Require IDCOMP + IDCOMPUNITNO, 1, 213
     Require IDCOMP + IDCOMPNAME, 1, 214
     Require IDCOMP + IDCOMPPROX, 1, 215
     Require IDCOMP + IDCOMPSALES, 1, 216
     Require IDCOMP + IDCOMPPRGLA, 1, 217
     Require IDCOMP + IDCOMPPRPERSHARE, 1, 218
     Require IDCOMP + IDCOMPSOURCE, 1, 219
     Require IDCOMP + IDCOMPVER, 1, 220
     Require IDCOMP + IDCOMPSF, 1, 221
     Require IDCOMP + IDCOMPCONC, 1, 223
     Require IDCOMP + IDCOMPDOS, 1, 225
     Require IDCOMP + IDCOMPLOC, 1, 227
     Require IDCOMP + IDCOMPPRJSIZENUM, 1, 229
     Require IDCOMP + IDCOMPVIEW, 1, 231
     Require IDCOMP + IDCOMPFLOORLOC, 1, 233
     Require IDCOMP + IDCOMPMOMAINFEE, 1, 235
     Require IDCOMP + IDCOMPPRJAMEN, 1, 237
     Require IDCOMP + IDCOMPFACILITIES, 1, 239
     Require IDCOMP + IDCOMPPRJSECUR, 1, 241
     Require IDCOMP + IDCOMPFEATURES, 1, 243
     Require IDCOMP + IDCOMPDESIGN, 1, 245
     Require IDCOMP + IDCOMPQUAL, 1, 247
     Require IDCOMP + IDCOMPAGE, 1, 249
     Require IDCOMP + IDCOMPCOND, 1, 251
     Require IDCOMP + IDCOMPREMODEL, 1, 253
     Require IDCOMP + IDCOMPKITCHBATH, 1, 255
     Require IDCOMP + IDCOMPROOMS, 1, 258
     Require IDCOMP + IDCOMPBED, 1, 259
     Require IDCOMP + IDCOMPBATHS, 1, 260
     Require IDCOMP + IDCOMPGLA, 1, 262
     Require IDCOMP + IDCOMPBASE, 1, 264
     If not ((GetText(1, 264) = "0sf") or (GetText(1, 264) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 266
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 268
     Require IDCOMP + IDCOMPHEAT, 1, 270
     Require IDCOMP + IDCOMPENERGY, 1, 272
     Require IDCOMP + IDCOMPGARAGE, 1, 274
     Require IDCOMP + IDCOMPPORCH, 1, 276
     Require IDCOMP + IDDATEPSTCOMP, 1, 303
     Require IDCOMP + IDPRICEPSTCOMP, 1, 304
     Require IDCOMP + IDDATASOURCECOMP, 1, 305
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 306
   End If
End Sub
