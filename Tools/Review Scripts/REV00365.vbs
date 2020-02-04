'FM00365.vbs 1004c Extra Comps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 49
cmpOffset = 63

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
   AddTitle String(5, "=") + "FNMA 1004C Extra Comparables" + String(5, "=")
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
   Require IDSUBLOC, 1, 23
   Require IDSUBLEASEHOLD, 1, 24
   Require IDSUBSITE, 1, 25
   Require IDSUBVIEW, 1, 26
   Require IDSUBDESIGN, 1, 27
   Require IDSUBQUAL, 1, 28
   Require IDSUBAGE, 1, 29
   Require IDSUBCOND, 1, 30
   Require IDSUBROOMS, 1, 31
   Require IDSUBBED, 1, 32
   Require IDSUBBATHS, 1, 33
   Require IDSUBGLA, 1, 34
   Require IDSUBBASE, 1, 35
   If not ((GetText(1, 35) = "0sf") or (GetText(1, 35) = "0sqm")) Then
     Require IDSUBBASEPER, 1, 36
   End If
   Require IDSUBFUNC, 1, 37
   Require IDSUBHEAT, 1, 38
   Require IDSUBENERGY, 1, 39
   Require IDSUBGARAGE, 1, 40
   Require IDSUBPORCH, 1, 41
   Require IDDATEPSTSUB, 1, 237
   Require IDPRICEPSTSUB, 1, 238
   Require IDDATASOURCESUB, 1, 239
   Require IDDATASOURCEDATESUB, 1, 240
   Require IDANALYSIS2, 1, 256
   Require IDSUMMARYSALES, 1, 257
End Sub

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 49) Then
     Require IDCOMP + IDCOMPADD, 1, 49
     Require IDCOMP + IDCOMPCITY, 1, 50 
     Require IDCOMP + IDCOMPPROX, 1, 51
     Require IDCOMP + IDCOMPSALES, 1, 52
     Require IDCOMP + IDCOMPPRGLA, 1, 53
     OnlyOneCheckOfTwo 1, 54, 55, IDCOMP + IDMFGHOMECOMP, IDCOMP + "IS MANUF HM: Both Yes and No Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 56
     Require IDCOMP + IDCOMPVER, 1, 57
     Require IDCOMP + IDCOMPSF, 1, 58
     Require IDCOMP + IDCOMPCONC, 1, 60
     Require IDCOMP + IDCOMPDOS, 1, 62
     Require IDCOMP + IDCOMPLOC, 1, 64
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 66
     Require IDCOMP + IDCOMPSITE, 1, 68
     Require IDCOMP + IDCOMPVIEW, 1, 70
     Require IDCOMP + IDCOMPDESIGN, 1, 72
     Require IDCOMP + IDCOMPQUAL, 1, 74
     Require IDCOMP + IDCOMPAGE, 1, 76
     Require IDCOMP + IDCOMPCOND, 1, 78
     Require IDCOMP + IDCOMPROOMS, 1, 81
     Require IDCOMP + IDCOMPBED, 1, 82
     Require IDCOMP + IDCOMPBATHS, 1, 83
     Require IDCOMP + IDCOMPGLA, 1, 85
     Require IDCOMP + IDCOMPBASE, 1, 87
     If not ((GetText(1, 87) = "0sf") or (GetText(1, 87) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 89
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 91
     Require IDCOMP + IDCOMPHEAT, 1, 93
     Require IDCOMP + IDCOMPENERGY, 1, 95
     Require IDCOMP + IDCOMPGARAGE, 1, 97
     Require IDCOMP + IDCOMPPORCH, 1, 99
     Require IDCOMP + IDDATEPSTCOMP, 1, 242
     Require IDCOMP + IDPRICEPSTCOMP, 1, 243
     Require IDCOMP + IDDATASOURCECOMP, 1, 244
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 245
   End If
End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 112) Then
     Require IDCOMP + IDCOMPADD, 1, 112
     Require IDCOMP + IDCOMPCITY, 1, 113
     Require IDCOMP + IDCOMPPROX, 1, 114
     Require IDCOMP + IDCOMPSALES, 1, 115
     Require IDCOMP + IDCOMPPRGLA, 1, 116
     OnlyOneCheckOfTwo 1, 117, 118, IDCOMP + IDMFGHOMECOMP, IDCOMP + "IS MANUF HM: Both Yes and No Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 119
     Require IDCOMP + IDCOMPVER, 1, 120
     Require IDCOMP + IDCOMPSF, 1, 121
     Require IDCOMP + IDCOMPCONC, 1, 123
     Require IDCOMP + IDCOMPDOS, 1, 125
     Require IDCOMP + IDCOMPLOC, 1, 127
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 129
     Require IDCOMP + IDCOMPSITE, 1, 131
     Require IDCOMP + IDCOMPVIEW, 1, 133
     Require IDCOMP + IDCOMPDESIGN, 1, 135
     Require IDCOMP + IDCOMPQUAL, 1, 137
     Require IDCOMP + IDCOMPAGE, 1, 139
     Require IDCOMP + IDCOMPCOND, 1, 141
     Require IDCOMP + IDCOMPROOMS, 1, 144
     Require IDCOMP + IDCOMPBED, 1, 145
     Require IDCOMP + IDCOMPBATHS, 1, 146
     Require IDCOMP + IDCOMPGLA, 1, 148
     Require IDCOMP + IDCOMPBASE, 1, 150
     If not ((GetText(1, 150) = "0sf") or (GetText(1, 150) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 152
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 154
     Require IDCOMP + IDCOMPHEAT, 1, 156
     Require IDCOMP + IDCOMPENERGY, 1, 158
     Require IDCOMP + IDCOMPGARAGE, 1, 160
     Require IDCOMP + IDCOMPPORCH, 1, 162   
     Require IDCOMP + IDDATEPSTCOMP, 1, 247
     Require IDCOMP + IDPRICEPSTCOMP, 1, 248
     Require IDCOMP + IDDATASOURCECOMP, 1, 249 
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 250
   End If
End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 175) Then
     Require IDCOMP + IDCOMPADD, 1, 175
     Require IDCOMP + IDCOMPCITY, 1, 176 
     Require IDCOMP + IDCOMPPROX, 1, 177
     Require IDCOMP + IDCOMPSALES, 1, 178
     Require IDCOMP + IDCOMPPRGLA, 1, 179
     OnlyOneCheckOfTwo 1, 180, 181, IDCOMP + IDMFGHOMECOMP, IDCOMP + "IS MANUF HM: Both Yes and No Checked"
     Require IDCOMP + IDCOMPSOURCE, 1, 182
     Require IDCOMP + IDCOMPVER, 1, 183
     Require IDCOMP + IDCOMPSF, 1, 184
     Require IDCOMP + IDCOMPCONC, 1, 186
     Require IDCOMP + IDCOMPDOS, 1, 188
     Require IDCOMP + IDCOMPLOC, 1, 190
     Require IDCOMP + IDCOMPLEASEHOLD, 1, 192
     Require IDCOMP + IDCOMPSITE, 1, 194
     Require IDCOMP + IDCOMPVIEW, 1, 196
     Require IDCOMP + IDCOMPDESIGN, 1, 198
     Require IDCOMP + IDCOMPQUAL, 1, 200
     Require IDCOMP + IDCOMPAGE, 1, 202
     Require IDCOMP + IDCOMPCOND, 1, 204
     Require IDCOMP + IDCOMPROOMS, 1, 207
     Require IDCOMP + IDCOMPBED, 1, 208
     Require IDCOMP + IDCOMPBATHS, 1, 209
     Require IDCOMP + IDCOMPGLA, 1, 211
     Require IDCOMP + IDCOMPBASE, 1, 213
     If not ((GetText(1, 213) = "0sf") or (GetText(1, 213) = "0sqm")) Then
       Require IDCOMP + IDCOMPBASEPER, 1, 215
     End If
     Require IDCOMP + IDCOMPFUNC, 1, 217
     Require IDCOMP + IDCOMPHEAT, 1, 219
     Require IDCOMP + IDCOMPENERGY, 1, 221
     Require IDCOMP + IDCOMPGARAGE, 1, 223
     Require IDCOMP + IDCOMPPORCH, 1, 225
     Require IDCOMP + IDDATEPSTCOMP, 1, 252
     Require IDCOMP + IDPRICEPSTCOMP, 1, 253
     Require IDCOMP + IDDATASOURCECOMP, 1, 254
     Require IDCOMP + IDDATASOURCEDATECOMP, 1, 255 
   End If
End Sub