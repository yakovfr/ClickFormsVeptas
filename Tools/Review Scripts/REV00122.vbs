'REV00122.vbs Comparable Rent XComps Review Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 39
cmpOffset = 48

Sub ReviewForm()
  ReviewCompRentData
  ReviewRentApproach
  ReviewRentApproach2
  ReviewRentApproach3
  AddTitle ""	
End Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewRentApproach
 for pageCmpNo = 1 to 1
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewRentComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewRentApproach2
 for pageCmpNo = 2 to 2
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewRentComp2 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewRentApproach3
 for pageCmpNo = 3 to 3
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewRentComp3 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewCompRentData
   AddTitle String(5, "=") + "Comparable Rent XComps" + String(5, "=")	
   Require IDFilenum, 1, 2
   Require IDBORROWER, 1, 6
   Require IDSUBADD, 1, 7
   Require "SUBJ CITY NAME: Missing", 1, 8
   Require "SUBJ COUNTY NAME: Missing", 1, 9
   Require "SUBJ STATE: Missing", 1, 10
   Require "SUBJ ZIP: Missing", 1, 11
   Require IDLender, 1, 12
   Require IDLenderAdd, 1, 13
   
   Require IDSUBADD, 1, 14
   Require IDSUBCITY, 1, 15
   Require IDSUBLOC, 1, 24
   Require IDSUBVIEW, 1, 25
   Require IDSUBDESIGN, 1, 26
   Require "SUBJECT APPEAL: Missing", 1, 27
   Require IDSUBAGE, 1, 28
   Require IDSUBCOND, 1, 29
   Require "**SUBJECT ROOM COUNT: Missing", 1, 30
   Require IDSUBBED, 1, 31
   Require IDSUBBATHS, 1, 32
   Require IDSUBGLA, 1, 33
End Sub

Sub ReviewRentComp(cmpNo, cmpPg, clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 39) Then
   	Require IDCOMP + IDCOMPADD, 1, 39
   	Require IDCOMP + IDCOMPCITY, 1, 40
   	Require IDCOMP + IDCOMPPROX, 1, 41
   	Require IDCOMP +  "COMP LEASE BEGINS: Missing date", 1, 43
   	Require IDCOMP +  "COMP LEASE ENDS: Missing date", 1, 44
   	Require IDCOMP +  IDCOMPCURRENT, 1, 45
   	Require IDCOMP + IDCOMPRENTDATA, 1, 49
   	Require IDCOMP + IDCOMPLOC, 1, 55
   	Require IDCOMP + IDCOMPVIEW, 1, 57
   	Require IDCOMP + IDCOMPDESIGN, 1, 59
   	Require IDCOMP + "COMP APPEAL: Missing", 1, 61
  	Require IDCOMP + IDCOMPAGE, 1, 63
  	Require IDCOMP + IDCOMPCOND, 1, 65
   	Require IDCOMP + "**COMP ROOM COUNT: Missing", 1, 68
   	Require IDCOMP + IDCOMPBED, 1, 69
   	Require IDCOMP + IDCOMPBATHS, 1, 70
   	Require IDCOMP + IDCOMPGLA, 1, 72
   End If
End Sub

Sub ReviewRentComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 87) Then
   	Require IDCOMP + IDCOMP + IDCOMPADD, 1, 87
   	Require IDCOMP + IDCOMPCITY, 1, 88
   	Require IDCOMP + IDCOMPPROX, 1, 89
   	Require IDCOMP + "COMP LEASE BEGINS: Missing date", 1, 91
   	Require IDCOMP + "COMP LEASE ENDS: Missing date", 1, 92
   	Require IDCOMP + IDCOMPCURRENT, 1, 93
   	Require IDCOMP + IDCOMPRENTDATA, 1, 97
   	Require IDCOMP + IDCOMPLOC, 1, 103
   	Require IDCOMP + IDCOMPVIEW, 1, 105
   	Require IDCOMP + IDCOMPDESIGN, 1, 107
   	Require IDCOMP + "COMP APPEAL: Missing", 1, 109
   	Require IDCOMP + IDCOMPAGE, 1, 111
   	Require IDCOMP + IDCOMPCOND, 1, 113
   	Require IDCOMP + "**COMP ROOM COUNT: Missing", 1, 116
   	Require IDCOMP + IDCOMPBED, 1, 117
   	Require IDCOMP + IDCOMPBATHS, 1, 118
   	Require IDCOMP + IDCOMPGLA, 1, 120
   End If
End Sub

Sub ReviewRentComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 123) Then
   	Require IDCOMP + IDCOMPADD, 1, 135
   	Require IDCOMP + IDCOMPCITY, 1, 136
   	Require IDCOMP + IDCOMPPROX, 1, 137
   	Require IDCOMP + "COMP LEASE BEGINS: Missing date", 1, 139
   	Require IDCOMP + "COMP LEASE ENDS: Missing date", 1, 140
   	Require IDCOMP + IDCOMPCURRENT, 1, 141
   	Require IDCOMP + IDCOMPRENTDATA, 1, 145
   	Require IDCOMP + IDCOMPLOC, 1, 151
   	Require IDCOMP + IDCOMPVIEW, 1, 153
   	Require IDCOMP + IDCOMPDESIGN, 1, 155
   	Require IDCOMP + "COMP APPEAL: Missing", 1, 157
   	Require IDCOMP + IDCOMPAGE, 1, 159
   	Require IDCOMP + IDCOMPCOND, 1, 161
   	Require IDCOMP + "**COMP  ROOM COUNT: Missing", 1, 164
   	Require IDCOMP + IDCOMPBED, 1, 165
   	Require IDCOMP + IDCOMPBATHS, 1, 166
   	Require IDCOMP + IDCOMPGLA, 1, 168
    End If
End Sub