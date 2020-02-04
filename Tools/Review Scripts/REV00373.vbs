'REV00373.vbs AI Improvements Analysis Reviewer Script

Sub ReviewForm
  ReviewIMPROV
  AddTitle ""
End Sub

Sub ReviewIMPROV
   AddTitle String(5, "=") + "AI FORMS " + IDAIIMPROV + String(5, "=") 
   Require IDAICLIENT, 1, 2
   Require IDADDRESS, 1, 4
   Require IDFilenum, 1, 5
   Require IDDESIGN, 1, 6
   Require IDUNITSNODES, 1, 7
   Require IDSTORIESDES, 1, 8
   Require IDCOMPAGE, 1, 9
   Require IDEFFAGE, 1, 10
   OnlyOneCheckOfThree 1, 11, 12, 13, IDEXPROCON, XXXXX
   OnlyOneCheckOfTwo 1, 14, 15, IDAIATTACHED, XXXXX
   OnlyOneCheckOfTwo 1, 16, 17, IDAIMFGMOD, XXXXX
   Require IDAIROOF, 1, 19
   Require IDAISIDE, 1, 20
   Require IDAIWINDOWS, 1, 21
   OnlyOneCheckOfFive 1, 22, 24, 26, 28, 30, IDAIPPD, XXXXX
   Require IDFLOORING, 1, 33
   Require IDWALLS, 1, 34
   
   If isChecked(1, 35) Then
     Require IDAIFPNO, 1, 36
   End If
   
   OnlyOneCheckOfSix 1, 37, 38, 39, 40, 41, 42, IDAIKITCHEN, XXXXX
   Require IDAICOUNTER, 1, 43
   OnlyOneCheckOfThree 1, 45, 47, 49, IDFOUNDATIONCK, XXXXX
   
   checked = GetCheck(1, 53) + GetCheck(1, 55) + GetCheck(1, 57) + GetCheck(1, 59)
   If isChecked(1, 52) Then    '  No Attic
     If checked > 0 Then AddRec IDATTICNONE, 1, 52
   Else
     If checked = 0 Then AddRec IDATTICNOCK, 1, 52
   End If
   
   Require IDAIMECH, 1, 61
   Require IDAIFUEL, 1, 62
   Require IDAIAC, 1, 63
   OnlyOneCheckOfFour 1, 64, 66, 68, 70, IDAICARSTORE, XXXXX
   Require IDCOMPBED, 1, 107
   Require IDCOMPBATHS, 1, 108
   Require IDCOMPGLA, 1, 109
   Require IDAIABOVEGRADE, 1, 110
   Require IDAIBELOWGRADE, 1, 145
   Require IDAIPHYSDEP, 1, 146
   Require IDAISTYLE, 1, 147
End Sub