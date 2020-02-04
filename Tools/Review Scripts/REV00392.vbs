'REV00392.vbs AI XRentals Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 33
cmpOffset = 46

Sub ReviewForm
  ReviewINCOME
  AddTitle ""
  ReviewINCOME1
  ReviewINCOME2
  ReviewINCOME3
End Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewINCOME1
 for pageCmpNo = 1 to 1
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewINCOMEA1 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewINCOME2
 for pageCmpNo = 2 to 2
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewINCOMEA2 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewINCOME3
 for pageCmpNo = 3 to 3
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewINCOMEA3 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewINCOME

   AddTitle String(5, "=") + "AI FORMS " + "EXTRA RENTALS" + String(5, "=")

   Require IDAICLIENT, 1, 3
   Require IDADDRESS, 1, 5
   Require IDFilenum, 1, 6

   Require IDSUBADD, 1, 7
   Require IDSUBCITY, 1, 8
   Require IDAILEASESUB, 1, 9
   Require IDAILEASEDATESUB, 1, 10
   Require IDAIRENTPERSUB, 1, 12
   Require IDAIRENTCONCSUB, 1, 13
   Require IDAILESSUTILSUB, 1, 14
   Require IDAILESSSUB, 1, 16
   Require IDSUBLOC, 1, 17
   Require IDAISITEVIEWSUB, 1, 18
   Require IDAIQUALSUB, 1, 19
   Require IDAIAGESUB, 1, 20
   Require IDAIAGBEDSUB, 1, 21
   Require IDAIAGBATHSUB, 1, 22
   Require IDAIINCGLASUB, 1, 23
   Require IDAIBGGLASUB, 1, 24
   Require IDAIOTHERLIVSUB, 1, 25
   Require IDAIHEATCOOLSUB, 1, 26
   Require IDAICARSTORSUB, 1, 27
  
End Sub



Sub ReviewINCOMEA1(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  
If hasText(1, 33) Then
   Require IDCOMP + IDCOMPADD, 1, 33
   Require IDCOMP + IDCOMPCITY, 1, 34
   Require IDCOMP + IDCOMPPROX, 1, 35
   Require IDCOMP + IDAIDATASOURCECOMP, 1, 36
   Require IDCOMP + IDAIVERCOMP, 1, 37
   Require IDCOMP + IDAILEASECOMP, 1, 38
   Require IDCOMP + IDAILEASEDATECOMP, 1, 39
   Require IDCOMP + IDAIRENTPERCOMP, 1, 40
   Require IDCOMP + IDAIRENTCONCCOMP, 1, 41
   Require IDCOMP + IDAILESSUTILCOMP, 1, 43
   Require IDCOMP + IDAILESSCOMP, 1, 45
   Require IDCOMP + IDCOMPLOC, 1, 48
   Require IDCOMP + IDAISITEVIEWCOMP, 1, 50
   Require IDCOMP + IDAIQUALCOMP, 1, 52
   Require IDCOMP + IDAIAGECOMP, 1, 54
   Require IDCOMP + IDAIAGBEDCOMP, 1, 56
   Require IDCOMP + IDAIAGBATHCOMP, 1, 58
   Require IDCOMP + IDAIINCGLACOMP, 1, 60
   Require IDCOMP + IDAIBGGLACOMP, 1, 62
   Require IDCOMP + IDAIOTHERLIVCOMP, 1, 64
   Require IDCOMP + IDAIHEATCOOLCOMP, 1, 66
   Require IDCOMP + IDAICARSTORCOMP, 1, 68
   Require IDCOMP + IDAIIMRCOMP, 1, 77
End If
End Sub

Sub ReviewINCOMEA2(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

If hasText(1, 79) Then
   Require IDCOMP + IDCOMPADD, 1, 79
   Require IDCOMP + IDCOMPCITY, 1, 80
   Require IDCOMP + IDCOMPPROX, 1, 81
   Require IDCOMP + IDAIDATASOURCECOMP, 1, 82
   Require IDCOMP + IDAIVERCOMP, 1, 83
   Require IDCOMP + IDAILEASECOMP, 1, 84
   Require IDCOMP + IDAILEASEDATECOMP, 1, 85
   Require IDCOMP + IDAIRENTPERCOMP, 1, 86
   Require IDCOMP + IDAIRENTCONCCOMP, 1, 87
   Require IDCOMP + IDAILESSUTILCOMP, 1, 89
   Require IDCOMP + IDAILESSCOMP, 1, 91
   Require IDCOMP + IDCOMPLOC, 1, 94
   Require IDCOMP + IDAISITEVIEWCOMP, 1, 96
   Require IDCOMP + IDAIQUALCOMP, 1, 98
   Require IDCOMP + IDAIAGECOMP, 1, 100
   Require IDCOMP + IDAIAGBEDCOMP, 1, 102
   Require IDCOMP + IDAIAGBATHCOMP, 1, 104
   Require IDCOMP + IDAIINCGLACOMP, 1, 106
   Require IDCOMP + IDAIBGGLACOMP, 1, 108
   Require IDCOMP + IDAIOTHERLIVCOMP, 1, 110
   Require IDCOMP + IDAIHEATCOOLCOMP, 1, 112
   Require IDCOMP + IDAICARSTORCOMP, 1, 114
   Require IDCOMP + IDAIIMRCOMP, 1, 123
End If

End Sub

Sub ReviewINCOMEA3(cmpNo,cmpPg,clBase)


   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  
If hasText(1, 125) Then
   Require IDCOMP + IDCOMPADD, 1, 125
   Require IDCOMP + IDCOMPCITY, 1, 126
   Require IDCOMP + IDCOMPPROX, 1, 127
   Require IDCOMP + IDAIDATASOURCECOMP, 1, 128
   Require IDCOMP + IDAIVERCOMP, 1, 129
   Require IDCOMP + IDAILEASECOMP, 1, 130
   Require IDCOMP + IDAILEASEDATECOMP, 1, 131
   Require IDCOMP + IDAIRENTPERCOMP, 1, 132
   Require IDCOMP + IDAIRENTCONCCOMP, 1, 133
   Require IDCOMP + IDAILESSUTILCOMP, 1, 135
   Require IDCOMP + IDAILESSCOMP, 1, 137
   Require IDCOMP + IDCOMPLOC, 1, 140
   Require IDCOMP + IDAISITEVIEWCOMP, 1, 142
   Require IDCOMP + IDAIQUALCOMP, 1, 144
   Require IDCOMP + IDAIAGECOMP, 1, 146
   Require IDCOMP + IDAIAGBEDCOMP, 1, 148
   Require IDCOMP + IDAIAGBATHCOMP, 1, 150
   Require IDCOMP + IDAIINCGLACOMP, 1, 152
   Require IDCOMP + IDAIBGGLACOMP, 1, 154
   Require IDCOMP + IDAIOTHERLIVCOMP, 1, 156
   Require IDCOMP + IDAIHEATCOOLCOMP, 1, 158
   Require IDCOMP + IDAICARSTORCOMP, 1, 160
   Require IDCOMP + IDAIIMRCOMP, 1, 169
End If

   Require IDAIRENTCOMPANA, 1, 170

end Sub







