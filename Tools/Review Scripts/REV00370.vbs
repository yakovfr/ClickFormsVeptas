'REV00370.vbs AI Residential Summary Reviewer Script

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewREID
  AddTitle ""
  ReviewSPH
  AddTitle ""
  ReviewRC
  AddTitle ""
  ReviewAP
  AddTitle ""
  ReviewSW
  AddTitle ""
End Sub

Sub ReviewSubject
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAISAR + String(5, "=") 
   Require IDFilenum, 1, 3
   Require IDCERTCOMPANYAPPR, 1, 4
   Require IDCERTCOMPANYADDAPPR, 1, 5
   Require IDCERTPHONEAPPR, 1, 6
   Require IDCERTNAMEAPPR, 1, 9
   OnlyOneCheckOfFive 1, 10, 11, 12, 13, 14, IDAIMEMBER, XXXXX   
   
   If hasText(1, 17) Then 
      Require IDAICOAPP, 1, 17
      OnlyOneCheckOfFive 1, 18, 19, 20, 21, 22, IDAIMEMBER2, XXXXX
   End If
   
   Require IDAICLIENT, 1, 25
   Require IDAICONTACT, 1, 26
   Require IDAICLADD, 1, 27
   Require IDAICLPH, 1, 28
End Sub


Sub ReviewREID
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAIRE + String(5, "=") 
   Require IDADDRESS, 1, 31
   Require IDCITY, 1, 32
   Require IDCOUNTY, 1, 33
   Require IDSTATE, 1, 34
   Require IDZIP, 1, 35
   Require IDLEGAL, 1, 36
   Require IDAPN3, 1, 37
   Require IDRETAXES, 1, 38
   Require IDTAXYEAR, 1, 39
End Sub

Sub ReviewSPH
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAIPH + String(5, "=") 
   Require IDAIOWN, 1, 40
   Require IDAIDECS, 1, 41
   Require IDAIDECA, 1, 42
End Sub

Sub ReviewRC
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAIRC + String(5, "=") 
   Require IDSALEVALUE, 1, 43
   Require IDINDVALCOST, 1, 44
   Require IDINVALINCOME, 1, 45
   Require IDAIFINAL, 1, 46
   Require IDAIFINALOPDATE, 1, 47
   Require IDAIFINALOP, 1, 48
End Sub

Sub ReviewAP
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAIAP + String(5, "=")
   Require IDAICLIENT, 2, 2
   Require IDADDRESS, 2, 4
   Require IDFilenum, 2, 5
   Require IDAIIU, 2, 6
   Require IDAIIU2, 2, 7
   Require IDAITYPE, 2, 8
   Require IDAIDATEVAL, 2, 9
   OnlyOneCheckOfThree 2, 10, 11, 12, IDAIINTAPPR, XXXXX
   
   If isChecked(2, 12) Then 
     Require COMMENT_FOR_OTHER_REQUIRED, 2, 13
   End If
   
   Require IDAIHYPO, 2, 14
   Require IDAIEXTASSUM, 2, 15
End Sub

Sub ReviewSW
   AddTitle String(5, "=") + "AI FORMS RESIDENTIAL SUMMARY: " + IDAISW + String(5, "=")
   OnlyOneCheckOfThree 2, 16, 17, 18, IDAIISA, XXXXX
   If isChecked(2, 17) or isChecked(2, 18) Then 
     Require IDAIDATEOF2, 2, 19
   End If

   If isChecked(2, 19) Then 
     Require IDAIDATEOF, 2, 20
   End If

   OnlyOneCheckOfThree 2, 21, 22, 23, IDAIISCO, XXXXX
   If isChecked(2, 22) or isChecked(2, 23) Then 
     Require IDAIDATEOF2, 2, 24
   End If
   If isChecked(2, 24) Then 
     Require IDAIDATEOF, 2, 25
   End If

   OnlyOneCheckOfThree 2, 26, 27, 28, IDAIISLAM, XXXXX
   If isChecked(2, 28) Then 
     Require COMMENT_FOR_OTHER_REQUIRED, 2, 29
   End If

   OnlyOneCheckOfSeven 2, 30, 31, 32, 33, 34, 35, 36, IDAIDS, XXXXX
   If isChecked(2, 36) Then 
     Require COMMENT_FOR_OTHER_REQUIRED, 2, 37
   End If
   
   OnlyOneCheckOfThree 2, 38, 39, 40, IDAIAVDC, XXXXX
   OnlyOneCheckOfThree 2, 41, 42, 43, IDAIAVDS, XXXXX
   OnlyOneCheckOfThree 2, 44, 45, 46, IDAIAVDI, XXXXX 

   Require IDAISCOPECOMM, 2, 47
   OnlyOneCheckOfTwo 2, 48, 49, IDAISIGRPA, XXXXX
   If isChecked(2, 49) Then 
     Require IDAIDISCLOSE, 2, 50
   End If
End Sub
