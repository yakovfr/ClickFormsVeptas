'REV00379.vbs AI Limiting Conditions Reviewer Script

Sub ReviewForm
  ReviewSTATE
  AddTitle ""
  ReviewVALUEDEF
  AddTitle ""
  ReviewAPPRCERT
  AddTitle ""
  ReviewAPPRCERTADD
  AddTitle ""
End Sub

Sub ReviewSTATE
   AddTitle String(5, "=") + "AI FORMS: " + IDAISTATE + String(5, "=") 
   Require IDAICLIENT, 1, 2
   Require IDADDRESS, 1, 4
   Require IDFilenum, 1, 5
   Require IDAIPAGES, 1, 6
End Sub

Sub ReviewVALUEDEF
   AddTitle String(5, "=") + "AI FORMS: " + IDAIVALUEDEF + String(5, "=") 
   OnlyOneCheckOfTwo 1, 8, 9, IDAIVALUEDEFCK, XXXXX
End Sub

Sub ReviewAPPRCERT
   AddTitle String(5, "=") + "AI FORMS: " + IDAIAPPRCERT + String(5, "=") 
   Require IDAICLIENT, 2, 2
   Require IDADDRESS, 2, 4
   Require IDFilenum, 2, 5
   OnlyOneCheckOfTwo 2, 6, 7, IDAISCOPENAME, XXXXX

   If isChecked(2, 7) Then 
     Require IDAISCOPENAMECK, 2, 8
   End If

   OnlyOneCheckOfThree 2, 9, 10, 11, IDAIISA, XXXXX
   OnlyOneCheckOfThree 2, 12, 13, 14, IDAIISCO, XXXXX
End Sub

Sub ReviewAPPRCERTADD
   AddTitle String(5, "=") + "AI FORMS: " + IDAIAPPRCERTADD + String(5, "=") 
   OnlyOneCheckOfTwo 2, 16, 17, IDAIMEMBERCK, XXXXX
   Require IDAICERTAPPRNAME, 2, 20
   Require IDAIREPORTDATE, 2, 21

   If hasText(2, 23) Then
     Require IDAICERTAPPRCERT, 2, 22
   End If 

   If hasText(2, 25) Then
     Require IDAICERTAPPRLICNO, 2, 24
   End If 

   If hasText(2, 22) Then
     Require IDAICERTAPPRCERTSTATE, 2, 23
   End If 

   If hasText(2, 24) Then
     Require IDAICERTAPPRLICSTATE, 2, 25
   End If

   Require IDAICERTAPPREXPIRE, 2, 26 

   If isChecked(2, 13) or isChecked(2, 14) Then
      OnlyOneCheckOfTwo 2, 18, 19, IDAIMEMBERCK2, XXXXX
      Require IDAICERTAPPRCONAME, 2, 27
      Require IDAIREPORTDATE, 2, 28
        If hasText(2, 30) Then
          Require IDAICERTAPPRCOCERT, 2, 29
        End If 
        If hasText(2, 32) Then
          Require IDAICERTAPPRCOLICNO, 2, 31
        End If 
        If hasText(2, 29) Then
          Require IDAICERTAPPRCOCERTSTATE, 2, 30
        End If 
        If hasText(2, 31) Then
          Require IDAICERTAPPRCOLICSTATE, 2, 32
        End If
      Require IDAICERTAPPRCOEXPIRE, 2, 33
   End If
End Sub