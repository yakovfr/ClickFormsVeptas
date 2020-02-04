'REV00391.vbs AI XComps Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 43
cmpOffset = 62

Sub ReviewForm
  ReviewSALES
  AddTitle ""
  ReviewSALES1
  ReviewSALES2
  ReviewSALES3
End Sub


function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function


Sub ReviewSALES1
 for pageCmpNo = 1 to 1
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSALESA1 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub


Sub ReviewSALES2
 for pageCmpNo = 2 to 2
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSALESA2 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub


Sub ReviewSALES3
 for pageCmpNo = 3 to 3
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSALESA3 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub


Sub ReviewSALES

   AddTitle String(5, "=") + "AI FORMS " + "EXTRA COMPARABLES" + String(5, "=")

   Require IDAICLIENT, 1, 3
   Require IDADDRESS, 1, 5
   Require IDFilenum, 1, 6
   Require IDSUBADD, 1, 7
   Require IDSUBCITY, 1, 8
   Require IDAIFINALLISTSCASUB, 1, 9  
   Require IDAISPSCASUB, 1, 10
   Require IDAISLPSCASUB, 1, 11
   Require IDAICDSCASUB, 1, 12
   Require IDAIDOMSCASUB, 1, 13
   Require IDSUBPRGLA, 1, 14
   Require IDAIFTSCASUB, 1, 15
   Require IDAICONSCASUB, 1, 16
   Require IDAICONDATESCASUB, 1, 17
   Require IDSUBLOC, 1, 18
   Require IDAISUBSS, 1, 19
   Require IDAISITEVIEWSAPPSCASUB, 1, 20
   Require IDAIDESIGNAPPSCASUB, 1, 21
   Require IDSUBQUAL, 1, 22
   Require IDAIAGESCASUB, 1, 23
   Require IDSUBCOND, 1, 24
   Require IDAIAGBEDSUB, 1, 25
   Require IDAIAGBATHSUB, 1, 26
   Require IDAIINCGLASUB, 1, 27
   Require IDAIBGGLASUB, 1, 28
   Require IDAIBGFSCASUB, 1, 29
   Require IDAIOTHERLIVSUB, 1, 30
   Require IDSUBFUNC, 1, 33
   Require IDSUBHEAT, 1, 34
   Require IDAICARSTORSUB, 1, 35
  
End Sub



Sub ReviewSALESA1(cmpNo,cmpPg,clBase)

   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  
   If hasText(1, 43) Then
      Require IDCOMP + IDCOMPADD, 1, 43
      Require IDCOMP + IDCOMPCITY, 1, 44
      Require IDCOMP + IDCOMPPROX, 1, 45
      Require IDCOMP + IDAIFINALLISTSCACOMP, 1, 46  
      Require IDCOMP + IDAISPSCACOMP, 1, 47
      Require IDCOMP + IDAISLPSCACOMP, 1, 48
      Require IDCOMP + IDAICDSCACOMP, 1, 49
      Require IDCOMP + IDAIDOMSCACOMP, 1, 50
      Require IDCOMP + IDCOMPPRGLA, 1, 51
      Require IDCOMP + IDAIDATASOURCECOMP, 1, 52
      Require IDCOMP + IDAIVERCOMP, 1, 53
      Require IDCOMP + IDAIFTSCACOMP, 1, 54
      Require IDCOMP + IDAICONSCACOMP, 1, 56
      Require IDCOMP + IDAICONDATESCACOMP, 1, 58
      Require IDCOMP + IDCOMPLOC, 1, 60
      Require IDCOMP + IDAICOMPSS, 1, 62
      Require IDCOMP + IDAISITEVIEWSAPPSCACOMP, 1, 64
      Require IDCOMP + IDAIDESIGNAPPSCACOMP, 1, 66
      Require IDCOMP + IDCOMPQUAL, 1, 68
      Require IDCOMP + IDAIAGESCACOMP, 1, 70
      Require IDCOMP + IDCOMPCOND, 1, 72
      Require IDCOMP + IDAIAGBEDCOMP, 1, 74
      Require IDCOMP + IDAIAGBATHCOMP, 1, 76
      Require IDCOMP + IDAIINCGLACOMP, 1, 78
      Require IDCOMP + IDAIBGGLACOMP, 1, 80
      Require IDCOMP + IDAIBGFSCACOMP, 1, 82
      Require IDCOMP + IDAIOTHERLIVCOMP, 1, 84
      Require IDCOMP + IDCOMPFUNC, 1, 88
      Require IDCOMP + IDCOMPHEAT, 1, 90
      Require IDCOMP + IDAICARSTORCOMP, 1, 92
      Require IDCOMP + IDAIASPSCACOMP, 1, 103
   End If

End Sub

Sub ReviewSALESA2(cmpNo,cmpPg,clBase)

   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

   If hasText(1, 105) Then
      Require IDCOMP + IDCOMPADD, 1, 105
      Require IDCOMP + IDCOMPCITY, 1, 106
      Require IDCOMP + IDCOMPPROX, 1, 107
      Require IDCOMP + IDAIFINALLISTSCACOMP, 1, 108  
      Require IDCOMP + IDAISPSCACOMP, 1, 109
      Require IDCOMP + IDAISLPSCACOMP, 1, 110
      Require IDCOMP + IDAICDSCACOMP, 1, 111
      Require IDCOMP + IDAIDOMSCACOMP, 1, 112
      Require IDCOMP + IDCOMPPRGLA, 1, 113
      Require IDCOMP + IDAIDATASOURCECOMP, 1, 114
      Require IDCOMP + IDAIVERCOMP, 1, 115
      Require IDCOMP + IDAIFTSCACOMP, 1, 116
      Require IDCOMP + IDAICONSCACOMP, 1, 118
      Require IDCOMP + IDAICONDATESCACOMP, 1, 120
      Require IDCOMP + IDCOMPLOC, 1, 122
      Require IDCOMP + IDAICOMPSS, 1, 124
      Require IDCOMP + IDAISITEVIEWSAPPSCACOMP, 1, 126
      Require IDCOMP + IDAIDESIGNAPPSCACOMP, 1, 128
      Require IDCOMP + IDCOMPQUAL, 1, 130
      Require IDCOMP + IDAIAGESCACOMP, 1, 132
      Require IDCOMP + IDCOMPCOND, 1, 134
      Require IDCOMP + IDAIAGBEDCOMP, 1, 136
      Require IDCOMP + IDAIAGBATHCOMP, 1, 138
      Require IDCOMP + IDAIINCGLACOMP, 1, 140
      Require IDCOMP + IDAIBGGLACOMP, 1, 142
      Require IDCOMP + IDAIBGFSCACOMP, 1, 144
      Require IDCOMP + IDAIOTHERLIVCOMP, 1, 146
      Require IDCOMP + IDCOMPFUNC, 1, 150
      Require IDCOMP + IDCOMPHEAT, 1, 152
      Require IDCOMP + IDAICARSTORCOMP, 1, 154
      Require IDCOMP + IDAIASPSCACOMP, 1, 165
   End If

End Sub

Sub ReviewSALESA3(cmpNo,cmpPg,clBase)

   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  
   If hasText(1, 167) Then
      Require IDCOMP + IDCOMPADD, 1, 167
      Require IDCOMP + IDCOMPCITY, 1, 168
      Require IDCOMP + IDCOMPPROX, 1, 169
      Require IDCOMP + IDAIFINALLISTSCACOMP, 1, 170  
      Require IDCOMP + IDAISPSCACOMP, 1, 171
      Require IDCOMP + IDAISLPSCACOMP, 1, 172
      Require IDCOMP + IDAICDSCACOMP, 1, 173
      Require IDCOMP + IDAIDOMSCACOMP, 1, 174
      Require IDCOMP + IDCOMPPRGLA, 1, 175
      Require IDCOMP + IDAIDATASOURCECOMP, 1, 176
      Require IDCOMP + IDAIVERCOMP, 1, 177
      Require IDCOMP + IDAIFTSCACOMP, 1, 178
      Require IDCOMP + IDAICONSCACOMP, 1, 180
      Require IDCOMP + IDAICONDATESCACOMP, 1, 182
      Require IDCOMP + IDCOMPLOC, 1, 184
      Require IDCOMP + IDAICOMPSS, 1, 186
      Require IDCOMP + IDAISITEVIEWSAPPSCACOMP, 1, 188
      Require IDCOMP + IDAIDESIGNAPPSCACOMP, 1, 190
      Require IDCOMP + IDCOMPQUAL, 1, 192
      Require IDCOMP + IDAIAGESCACOMP, 1, 194
      Require IDCOMP + IDCOMPCOND, 1, 196
      Require IDCOMP + IDAIAGBEDCOMP, 1, 198
      Require IDCOMP + IDAIAGBATHCOMP, 1, 200
      Require IDCOMP + IDAIINCGLACOMP, 1, 202
      Require IDCOMP + IDAIBGGLACOMP, 1, 204
      Require IDCOMP + IDAIBGFSCACOMP, 1, 206
      Require IDCOMP + IDAIOTHERLIVCOMP, 1, 208
      Require IDCOMP + IDCOMPFUNC, 1, 212
      Require IDCOMP + IDCOMPHEAT, 1, 214
      Require IDCOMP + IDAICARSTORCOMP, 1, 216
      Require IDCOMP + IDAIASPSCACOMP, 1, 227
   End If
 
      Require IDAICOMMENTSSCA, 1, 228

End Sub
