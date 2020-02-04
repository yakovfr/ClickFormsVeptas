'FM00765.vbs Non-Lender Residential XComps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 49
cmpOffset = 61

Sub ReviewForm
ReviewSalesComparison  
ReviewSalesApproach
ReviewSalesApproach2
ReviewSalesApproach3
AddTitle ""
end Sub

AddTitle String(5, "=") + "Non-Lender Residential Exterior Extra Comparables" + String(5, "=")


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
   Require IDSUBBASEPER, 1, 36
   Require IDSUBFUNC, 1, 37
   Require IDSUBHEAT, 1, 38
   Require IDSUBENERGY, 1, 39
   Require IDSUBGARAGE, 1, 40
   Require IDSUBPORCH, 1, 41

   Require IDDATEPSTSUB, 1, 231
   Require IDPRICEPSTSUB, 1, 232
   Require IDDATASOURCESUB, 1, 233
   Require IDDATASOURCEDATESUB, 1, 234

   Require IDANALYSIS2, 1, 250
   Require IDSUMMARYSALES, 1, 251

End Sub


Sub ReviewSalesComp(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  


   If hasText(1, 49) Then
   Require IDCOMP + IDCOMPADD, 1, 49   
   Require IDCOMP + IDCOMPCITY, 1, 50 
   Require IDCOMP + IDCOMPPROX, 1, 51
   Require IDCOMP + IDCOMPSALES, 1, 52
   Require IDCOMP + IDCOMPPRGLA, 1, 53
   Require IDCOMP + IDCOMPSOURCE, 1, 54
   Require IDCOMP + IDCOMPVER, 1, 55
   Require IDCOMP + IDCOMPSF, 1, 56
   Require IDCOMP + IDCOMPCONC, 1, 58
   Require IDCOMP + IDCOMPDOS, 1, 60
   Require IDCOMP + IDCOMPLOC, 1, 62
   Require IDCOMP + IDCOMPLEASEHOLD, 1, 64
   Require IDCOMP + IDCOMPSITE, 1, 66
   Require IDCOMP + IDCOMPVIEW, 1, 68
   Require IDCOMP + IDCOMPDESIGN, 1, 70
   Require IDCOMP + IDCOMPQUAL, 1, 72
   Require IDCOMP + IDCOMPAGE, 1, 74
   Require IDCOMP + IDCOMPCOND, 1, 76
   Require IDCOMP + IDCOMPROOMS, 1, 79
   Require IDCOMP + IDCOMPBED, 1, 80
   Require IDCOMP + IDCOMPBATHS, 1, 81
   Require IDCOMP + IDCOMPGLA, 1, 83
   Require IDCOMP + IDCOMPBASE, 1,85
   Require IDCOMP + IDCOMPBASEPER, 1, 87
   Require IDCOMP + IDCOMPFUNC, 1, 89
   Require IDCOMP + IDCOMPHEAT, 1, 91
   Require IDCOMP + IDCOMPENERGY, 1, 93
   Require IDCOMP + IDCOMPGARAGE, 1, 95
   Require IDCOMP + IDCOMPPORCH, 1, 97    

   Require IDCOMP + IDDATEPSTCOMP, 1, 236
   Require IDCOMP + IDPRICEPSTCOMP, 1, 237
   Require IDCOMP + IDDATASOURCECOMP, 1, 238
   Require IDCOMP + IDDATASOURCEDATECOMP, 1, 239 

  End If

End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  


   If hasText(1, 110) Then
   Require IDCOMP + IDCOMPADD, 1, 110   
   Require IDCOMP + IDCOMPCITY, 1, 111 
   Require IDCOMP + IDCOMPPROX, 1, 112
   Require IDCOMP + IDCOMPSALES, 1, 113
   Require IDCOMP + IDCOMPPRGLA, 1, 114
   Require IDCOMP + IDCOMPSOURCE, 1, 115
   Require IDCOMP + IDCOMPVER, 1, 116
   Require IDCOMP + IDCOMPSF, 1, 117
   Require IDCOMP + IDCOMPCONC, 1, 119
   Require IDCOMP + IDCOMPDOS, 1, 121
   Require IDCOMP + IDCOMPLOC, 1, 123
   Require IDCOMP + IDCOMPLEASEHOLD, 1, 125
   Require IDCOMP + IDCOMPSITE, 1, 127
   Require IDCOMP + IDCOMPVIEW, 1, 129
   Require IDCOMP + IDCOMPDESIGN, 1, 131
   Require IDCOMP + IDCOMPQUAL, 1, 133
   Require IDCOMP + IDCOMPAGE, 1, 135
   Require IDCOMP + IDCOMPCOND, 1, 137
   Require IDCOMP + IDCOMPROOMS, 1, 140
   Require IDCOMP + IDCOMPBED, 1, 141
   Require IDCOMP + IDCOMPBATHS, 1, 142
   Require IDCOMP + IDCOMPGLA, 1, 144
   Require IDCOMP + IDCOMPBASE, 1,146
   Require IDCOMP + IDCOMPBASEPER, 1, 148
   Require IDCOMP + IDCOMPFUNC, 1, 150
   Require IDCOMP + IDCOMPHEAT, 1, 152
   Require IDCOMP + IDCOMPENERGY, 1, 154
   Require IDCOMP + IDCOMPGARAGE, 1, 156
   Require IDCOMP + IDCOMPPORCH, 1, 158
   Require IDCOMP + IDDATEPSTCOMP, 1, 241
   Require IDCOMP + IDPRICEPSTCOMP, 1, 242
   Require IDCOMP + IDDATASOURCECOMP, 1, 243 
   Require IDCOMP + IDDATASOURCEDATECOMP, 1, 244  
   End If

End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  

   If hasText(1, 171) Then
   Require IDCOMP + IDCOMPADD, 1, 171   
   Require IDCOMP + IDCOMPCITY, 1, 172 
   Require IDCOMP + IDCOMPPROX, 1, 173
   Require IDCOMP + IDCOMPSALES, 1, 174
   Require IDCOMP + IDCOMPPRGLA, 1, 175
   Require IDCOMP + IDCOMPSOURCE, 1, 176
   Require IDCOMP + IDCOMPVER, 1, 177
   Require IDCOMP + IDCOMPSF, 1, 178
   Require IDCOMP + IDCOMPCONC, 1, 180
   Require IDCOMP + IDCOMPDOS, 1, 182
   Require IDCOMP + IDCOMPLOC, 1, 184
   Require IDCOMP + IDCOMPLEASEHOLD, 1, 186 
   Require IDCOMP + IDCOMPSITE, 1, 188
   Require IDCOMP + IDCOMPVIEW, 1, 190
   Require IDCOMP + IDCOMPDESIGN, 1, 192
   Require IDCOMP + IDCOMPQUAL, 1, 194
   Require IDCOMP + IDCOMPAGE, 1, 196
   Require IDCOMP + IDCOMPCOND, 1, 198
   Require IDCOMP + IDCOMPROOMS, 1, 201
   Require IDCOMP + IDCOMPBED, 1, 202
   Require IDCOMP + IDCOMPBATHS, 1, 203
   Require IDCOMP + IDCOMPGLA, 1, 205
   Require IDCOMP + IDCOMPBASE, 1, 207
   Require IDCOMP + IDCOMPBASEPER, 1, 209
   Require IDCOMP + IDCOMPFUNC, 1, 211
   Require IDCOMP + IDCOMPHEAT, 1, 213
   Require IDCOMP + IDCOMPENERGY, 1, 215
   Require IDCOMP + IDCOMPGARAGE, 1, 217
   Require IDCOMP + IDCOMPPORCH, 1,  219
   Require IDCOMP + IDDATEPSTCOMP, 1, 246
   Require IDCOMP + IDPRICEPSTCOMP, 1, 247
   Require IDCOMP + IDDATASOURCECOMP, 1, 248
   Require IDCOMP + IDDATASOURCEDATECOMP, 1, 249
   End If

end Sub



