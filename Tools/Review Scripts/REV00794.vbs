'FM00794.vbs Supplemental REO 2008

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewGrid
  AddTitle ""
 
  ReviewSignature
  AddTitle ""
End Sub

Sub ReviewSubject

   Require IDFilenum, 1, 2

   Require "SUBJECT ADDRESS: Missing", 1, 5
   Require "CITY: Missing", 1, 6
   Require "STATE: Missing", 1, 7
   Require "ZIP: Missing", 1, 8
   Require "LEGAL DESC: Missing", 1, 9
   Require "COUNTY: Missing", 1, 10

   OnlyOneCheckOfTwo 1, 11, 12, "CURRENTLY LISTED: None Selected", "CURRENTLY LISTED: more than one checked"
   if isChecked(1,10) then
      require "CURRENT LIST PRICE: Missing", 1, 13
      require "LISTING AGENT: Missing", 1, 14
      require "LISTING COMPANY INFO: Missing", 1, 15
   End If

End Sub


Sub ReviewGrid

 Require "RECOMMENDED INSPECTIONS COMMENTS: Missing", 1, 248
 Require "COMP 1 DOM: Missing", 1, 249
 Require "COMP 2 DOM: Missing", 1, 250
 Require "COMP 3 DOM: Missing", 1, 251

 Require "COMP DOM COMMENTS: Missing", 1, 252
   


End Sub

Sub ReviewSignature

  AddTitle String(5, "=") + IDSIGNATURE + String(5, "=")

     Require "APPRAISER NAME: Missing", 1,259
   Require "SIGNATURE DATE: Missing", 1,260

   'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 1, 260

   ' Show warning if Expiration date already today's date  
   IsExpirationDatePastToday 1, 265

   if hasText(1,266) then
     'Show warning if signaturedate not = today's date 
     IsSignatureDateNOTToday 1, 267

     ' Show warning if Expiration date already today's date  
     IsExpirationDatePastToday 1, 272
   end if
   
' Show hard stop if both state cell 1,136 and 1,138 are filled in. We can only have one or the other
  CheckDuplicateState 1,262,1,264
  CheckDuplicateState 1,267,1,271

 
 




End Sub
