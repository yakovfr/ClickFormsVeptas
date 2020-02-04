'FM00763.vbs Non-Lender XRentals Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 48
cmpOffset = 37

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
   AddTitle String(5, "=") + "Non-Lender Extra Rentals" + String(5, "=")
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
   Require IDSUBCURRENT, 1, 16
   Require IDSUBRENTGBA, 1, 17
   OnlyOneCheckOfTwo 1, 18, 19, IDRENTCONTROLSUB, XXXXX
   Require IDSUBRENTDATA, 1, 20
   Require IDSUBRENTLEASE, 1, 21
   Require IDSUBLOC, 1, 22
   Require IDSUBAGE, 1, 23
   Require IDSUBCOND, 1, 24
   Require IDSUBGBA2, 1, 25
   Require IDUNIT1TOTALSUB, 1, 26 
   Require IDUNIT1BEDSUB, 1, 27
   Require IDUNIT1BATHSUB, 1,28
   Require IDUNIT1SQFTSUB, 1, 29
   Require IDUNIT2TOTALSUB, 1, 30 
   Require IDUNIT2BEDSUB, 1, 31
   Require IDUNIT2BATHSUB, 1, 32
   Require IDUNIT2SQFTSUB, 1, 33
   Require IDUNIT3TOTALSUB, 1, 34
   Require IDUNIT3BEDSUB, 1, 35
   Require IDUNIT3BATHSUB, 1, 36
   Require IDUNIT3SQFTSUB, 1, 37
   Require IDUNIT4TOTALSUB, 1, 38
   Require IDUNIT4BEDSUB, 1, 39
   Require IDUNIT4BATHSUB, 1, 40
   Require IDUNIT4SQFTSUB, 1, 41
   Require IDUTILSUB, 1, 42
   Require IDANALYSISRENT, 1, 158
End Sub

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 48) Then
     Require IDCOMP + IDCOMPADD, 1, 48
     Require IDCOMP + IDCOMPCITY, 1, 49
     Require IDCOMP + IDCOMPPROX, 1, 50
     Require IDCOMP + IDCOMPCURRENT, 1, 51
     Require IDCOMP + IDCOMPRENTGBA, 1, 52
     OnlyOneCheckOfTwo 1, 53, 54, IDCOMP + IDRENTCONTROLCOMP, XXXXX
     Require IDCOMP + IDCOMPARABLERENTDATA, 1, 55
     Require IDCOMP + IDCOMPARABLERENTLEASE, 1, 56
     Require IDCOMP + IDCOMPLOC, 1, 57
     Require IDCOMP + IDCOMPAGE, 1, 58
     Require IDCOMP + IDCOMPCOND, 1, 59
     Require IDCOMP + IDCOMPGBA, 1, 60
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 61
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 62
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 63
     Require IDCOMP + IDUNIT1SQFTCOMP, 1, 64
     Require IDCOMP + IDUNIT1MORENTCOMP, 1, 65
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 66
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 67
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 68
     Require IDCOMP + IDUNIT2SQFTCOMP, 1, 69
     Require IDCOMP + IDUNIT2MORENTCOMP, 1, 70
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 71
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 72
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 73
     Require IDCOMP + IDUNIT3SQFTCOMP, 1, 74
     Require IDCOMP + IDUNIT3MORENTCOMP, 1, 75
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 76
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 77
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 78
     Require IDCOMP + IDUNIT4SQFTCOMP, 1, 79
     Require IDCOMP + IDUNIT4MORENTCOMP, 1, 80
     Require IDCOMP + IDUTILCOMP, 1, 81
   End If
End Sub

Sub ReviewSalesComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 85) Then
     Require IDCOMP + IDCOMPADD, 1, 85
     Require IDCOMP + IDCOMPCITY, 1, 86
     Require IDCOMP + IDCOMPPROX, 1, 87
     Require IDCOMP + IDCOMPCURRENT, 1, 88
     Require IDCOMP + IDCOMPRENTGBA, 1, 89
     OnlyOneCheckOfTwo 1, 90, 91, IDCOMP + IDRENTCONTROLCOMP, XXXXX
     Require IDCOMP + IDCOMPARABLERENTDATA, 1, 92
     Require IDCOMP + IDCOMPARABLERENTLEASE, 1, 93
     Require IDCOMP + IDCOMPLOC, 1, 94
     Require IDCOMP + IDCOMPAGE, 1, 95
     Require IDCOMP + IDCOMPCOND, 1, 96
     Require IDCOMP + IDCOMPGBA, 1, 97
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 98
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 99
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 100
     Require IDCOMP + IDUNIT1SQFTCOMP, 1, 101
     Require IDCOMP + IDUNIT1MORENTCOMP, 1, 102
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 103
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 104
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 105
     Require IDCOMP + IDUNIT2SQFTCOMP, 1, 106
     Require IDCOMP + IDUNIT2MORENTCOMP, 1, 107
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 108
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 109
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 110
     Require IDCOMP + IDUNIT3SQFTCOMP, 1, 111
     Require IDCOMP + IDUNIT3MORENTCOMP, 1, 112
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 113
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 114
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 115
     Require IDCOMP + IDUNIT4SQFTCOMP, 1, 116
     Require IDCOMP + IDUNIT4MORENTCOMP, 1, 117
     Require IDCOMP + IDUTILCOMP, 1, 118
   End If
End Sub

Sub ReviewSalesComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 122) Then
     Require IDCOMP + IDCOMPADD, 1, 122
     Require IDCOMP + IDCOMPCITY, 1, 123
     Require IDCOMP + IDCOMPPROX, 1, 124
     Require IDCOMP + IDCOMPCURRENT, 1, 125
     Require IDCOMP + IDCOMPRENTGBA, 1, 126
     OnlyOneCheckOfTwo 1, 127, 128, IDCOMP + IDRENTCONTROLCOMP, XXXXX
     Require IDCOMP + IDCOMPARABLERENTDATA, 1, 129
     Require IDCOMP + IDCOMPARABLERENTLEASE, 1, 130
     Require IDCOMP + IDCOMPLOC, 1, 131
     Require IDCOMP + IDCOMPAGE, 1, 132
     Require IDCOMP + IDCOMPCOND, 1, 133
     Require IDCOMP + IDCOMPGBA, 1, 134
     Require IDCOMP + IDUNIT1TOTALCOMP, 1, 135
     Require IDCOMP + IDUNIT1BEDCOMP, 1, 136
     Require IDCOMP + IDUNIT1BATHCOMP, 1, 137
     Require IDCOMP + IDUNIT1SQFTCOMP, 1, 138
     Require IDCOMP + IDUNIT1MORENTCOMP, 1, 139
     Require IDCOMP + IDUNIT2TOTALCOMP, 1, 140
     Require IDCOMP + IDUNIT2BEDCOMP, 1, 141
     Require IDCOMP + IDUNIT2BATHCOMP, 1, 142
     Require IDCOMP + IDUNIT2SQFTCOMP, 1, 143
     Require IDCOMP + IDUNIT2MORENTCOMP, 1, 144
     Require IDCOMP + IDUNIT3TOTALCOMP, 1, 145
     Require IDCOMP + IDUNIT3BEDCOMP, 1, 146
     Require IDCOMP + IDUNIT3BATHCOMP, 1, 147
     Require IDCOMP + IDUNIT3SQFTCOMP, 1, 148
     Require IDCOMP + IDUNIT3MORENTCOMP, 1, 149
     Require IDCOMP + IDUNIT4TOTALCOMP, 1, 150
     Require IDCOMP + IDUNIT4BEDCOMP, 1, 151
     Require IDCOMP + IDUNIT4BATHCOMP, 1, 152
     Require IDCOMP + IDUNIT4SQFTCOMP, 1, 153
     Require IDCOMP + IDUNIT4MORENTCOMP, 1, 154
     Require IDCOMP + IDUTILCOMP, 1, 155
   End If
End Sub
