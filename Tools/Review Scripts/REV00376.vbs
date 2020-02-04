'REV00376.vbs AI Cost Approach Reviewer Script

Sub ReviewForm
   ReviewCOST1
   AddTitle ""
   ReviewCOST2
   AddTitle ""
End Sub

Sub ReviewCOST1
   AddTitle String(5, "=") + "AI FORMS " + IDAICOSTTITLE + String(5, "=") 
   Require IDAICLIENT, 1, 2
   Require IDADDRESS, 1, 4
   Require IDFilenum, 1, 5
   OnlyOneCheckOfTwo 1, 6, 7, IDAICOSTDEF, XXXXX
End Sub

Sub ReviewCOST2
   AddTitle String(5, "=") + "AI FORMS " + IDAICOSTTITLE2 + String(5, "=") 
   Require IDAICOSTAG, 1, 10
   Require IDAICOSTTECN, 1, 29
   Require IDAIDEPPP, 1, 30
   Require IDAIDEPP, 1, 31
   Require IDAIDEPFP, 1, 32
   Require IDAIDEPF, 1, 33
   Require IDAIDEPEP, 1, 34
   Require IDAIDEPE, 1, 35
   Require IDAIDEPTOTAL, 1, 36
   Require IDAIDEPVOF, 1, 37
   Require IDAIDCOSTSITE, 1, 38
   Require IDAIDCOSTOPIN, 1, 45
   Require IDAIDCOSTIND, 1, 46
   Require IDAIDCOSTCOM, 1, 47
   Require IDAIDCOSTREC, 1, 48
   Require IDAIDCOSTINDCA, 1, 49
End Sub




