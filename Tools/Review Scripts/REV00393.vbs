'REV00393.vbs AI XSites Reviewer Script

Dim cmpNo
Dim cmpPg
Dim cmpBase
Dim cmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 31
cmpOffset = 32

Sub ReviewForm
  ReviewSVM
  AddTitle ""
  ReviewSV
  AddTitle ""
  ReviewSV1
  ReviewSV2
  ReviewSV3
End Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewSV1
 for pageCmpNo = 1 to 1
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSVComp1 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSV2
 for pageCmpNo = 2 to 2
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSVComp2 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSV3
 for pageCmpNo = 3 to 3
    cmpNo = GetCmpNo(pageCmpNo)
   ReviewSVComp3 cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
next
end Sub

Sub ReviewSVM
   AddTitle String(5, "=") + "AI FORMS EXTRA SITES " + IDAISVM + String(5, "=")
   Require IDAICLIENT, 1, 2
   Require IDADDRESS, 1, 4
   Require IDFilenum, 1, 5
   OnlyOneCheckOfThree 1, 6, 7, 8, IDAISVMCK, XXXXX
   If isChecked(1, 8) Then
      Require IDAIALTMED, 1, 9
   End If
End Sub

Sub ReviewSV
   AddTitle String(5, "=") + "AI FORMS EXTRA SITES " + IDAISV + String(5, "=")
   Require IDSUBADD, 1, 11
   Require IDSUBCITY, 1, 12
   Require IDSUBSALES, 1, 13
   Require IDAISUBPP, 1, 15
   Require IDSUBLOC, 1, 16
   Require IDAISUBSS, 1, 17
   Require IDAISUBSV, 1, 18 
   Require IDAISUBSI, 1, 19  
End Sub

Sub ReviewSVComp1(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 31) Then
     Require IDCOMP + IDCOMPADD, 1, 31
     Require IDCOMP + IDCITY, 1, 32
     Require IDCOMP + IDCOMPPROX, 1, 33
     Require IDCOMP + IDAIDATASOURCECOMP, 1, 34
     Require IDCOMP + IDAIVERCOMP, 1, 35
     Require IDCOMP + IDAICOMPSALES, 1, 36   
     Require IDCOMP + IDAICOMPPP, 1, 37
     Require IDCOMP + IDAICOMPDATE, 1, 38
     Require IDCOMP + IDAICOMPLOC, 1, 40     
     Require IDCOMP + IDAICOMPSS, 1, 42
     Require IDCOMP + IDAICOMPSV, 1, 44  
     Require IDCOMP + IDAICOMPSI, 1, 46
     Require IDCOMP + IDAIIVCOMP, 1, 61
   End If
End Sub

Sub ReviewSVComp2(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 63) Then
     Require IDCOMP + IDCOMPADD, 1, 63
     Require IDCOMP + IDCITY, 1, 64   
     Require IDCOMP + IDCOMPPROX, 1, 65
     Require IDCOMP + IDAIDATASOURCECOMP, 1, 66
     Require IDCOMP + IDAIVERCOMP, 1, 67
     Require IDCOMP + IDAICOMPSALES, 1, 68
     Require IDCOMP + IDAICOMPPP, 1, 69
     Require IDCOMP + IDAICOMPDATE, 1, 70
     Require IDCOMP + IDAICOMPLOC, 1, 72
     Require IDCOMP + IDAICOMPSS, 1, 74
     Require IDCOMP + IDAICOMPSI, 1, 76     
     Require IDCOMP + IDAICOMPSV, 1, 78
     Require IDCOMP + IDAIIVCOMP, 1, 93
   End If
End Sub

Sub ReviewSVComp3(cmpNo,cmpPg,clBase)
   IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
   If hasText(1, 95) Then
     Require IDCOMP + IDCOMPADD, 1, 95
     Require IDCOMP + IDCITY, 1, 96
     Require IDCOMP + IDCOMPPROX, 1, 97
     Require IDCOMP + IDAIDATASOURCECOMP, 1, 98
     Require IDCOMP + IDAIVERCOMP, 1, 99
     Require IDCOMP + IDAICOMPSALES, 1, 100
     Require IDCOMP + IDAICOMPPP, 1, 101
     Require IDCOMP + IDAICOMPDATE, 1, 102
     Require IDCOMP + IDAICOMPLOC, 1, 104
     Require IDCOMP + IDAICOMPSS, 1, 106      
     Require IDCOMP + IDAICOMPSV, 1, 108       
     Require IDCOMP + IDAICOMPSI, 1, 110   
     Require IDCOMP + IDAIIVCOMP, 1, 125
   End If
     Require IDAISITECOMMENTS, 1, 126     
     Require IDAISITERECON, 1, 127
End Sub







