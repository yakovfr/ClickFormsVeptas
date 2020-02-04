'REV00374.vbs AI Site Valuation Reviewer Script

Sub ReviewForm
   ReviewSVM
   AddTitle ""
   ReviewSV
   AddTitle ""
End Sub

Sub ReviewSVM
   AddTitle String(5, "=") + "AI FORMS " + IDAISVM + String(5, "=")
   Require IDAICLIENT, 1, 2
   Require IDADDRESS, 1, 4
   Require IDFilenum, 1, 5
   OnlyOneCheckOfThree 1, 6, 7, 8, IDAISVMCK, XXXXX
   If isChecked(1, 8) Then
      Require IDAIALTMED, 1, 9
   End If
End Sub

Sub ReviewSV
   AddTitle String(5, "=") + "AI FORMS " + IDAISV + String(5, "=")
   Require IDSUBADD, 1, 10
   Require IDSUBCITY, 1, 11
   Require IDSUBSALES, 1, 12
   Require IDAISUBPP, 1, 14
   Require IDSUBLOC, 1, 15
   Require IDAISUBSS, 1, 16
   Require IDAISUBSV, 1, 17 
   Require IDAISUBSI, 1, 18  

   Require IDCOMP1ADD, 1, 29
   Require IDCOMP1CITY, 1, 30
   Require IDCOMP1PROX, 1, 31
   Require IDAIDATASOURCECOMP1, 1, 32
   Require IDAIVERCOMP1, 1, 33
   Require IDAICOMP1SALES, 1, 34   
   Require IDAICOMP1PP, 1, 35
   Require IDAICOMP1DATE, 1, 36
   Require IDAICOMP1LOC, 1, 38     
   Require IDAICOMP1SS, 1, 40
   Require IDAICOMP1SV, 1, 42  
   Require IDAICOMP1SI, 1, 44
   Require IDAIIVCOMP1, 1, 59

   Require IDCOMP2ADD, 1, 60
   Require IDCOMP2CITY, 1, 61   
   Require IDCOMP2PROX, 1, 62
   Require IDAIDATASOURCECOMP2, 1, 63
   Require IDAIVERCOMP2, 1, 64
   Require IDAICOMP2SALES, 1, 65
   Require IDAICOMP2PP, 1, 66
   Require IDAICOMP2DATE, 1, 67
   Require IDAICOMP2LOC, 1, 69
   Require IDAICOMP2SS, 1, 71 
   Require IDAICOMP2SI, 1, 73     
   Require IDAICOMP2SV, 1, 75
   Require IDAIIVCOMP2, 1, 90

   Require IDCOMP3ADD, 1, 91
   Require IDCOMP3CITY, 1, 92
   Require IDCOMP3PROX, 1, 93
   Require IDAIDATASOURCECOMP3, 1, 94
   Require IDAIVERCOMP3, 1, 95
   Require IDAICOMP3SALES, 1, 96
   Require IDAICOMP3PP, 1, 97
   Require IDAICOMP3DATE, 1, 98
   Require IDAICOMP3LOC, 1, 100
   Require IDAICOMP3SS, 1, 102       
   Require IDAICOMP3SV, 1, 104       
   Require IDAICOMP3SI, 1, 106   
   Require IDAIIVCOMP3, 1, 121
 
   Require IDAISITECOMMENTS, 1, 122     
   Require IDAISITERECON, 1, 123   

End Sub
