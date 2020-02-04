'FM00683.vbs Supplemental REO Form Review Script
' 05/09/2013: 
' Show hard stop if both state cell 136 and 138 in State cerification area are filled in.
' 01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning
' Call: IsEffectiveDatePastSignatureDate2wks to check if effective date + 14 < signature date gives warning

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

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

   Require "VALUE DIFFERENCES COMMENTS: Missing", 1, 91
   Require "MARKET FACTOR COMMENTS: Missing", 1, 92
   Require "RECOMMENDED INSPECTIONS COMMENTS: Missing", 1, 116

   Require "COMP 1 DOM: Missing", 1, 117
   Require "COMP 2 DOM: Missing", 1, 118
   Require "COMP 3 DOM: Missing", 1, 119

   Require "COMP DOM COMMENTS: Missing", 1, 120
   
   require "AS-IS VALUE REASONABLE MKT: Missing", 1, 121
   require "AS-REPAIRED VALUE REASONABLE MKT: Missing", 1, 122

   require "AS-IS EST MKT TIME: Missing", 1, 123
   require "AS-IS VALUE EST MKT TIME: Missing", 1, 124

   require "AS-REPAIRED EST MKT TIME: Missing", 1, 125
   require "AS-REPAIRED VALUE EST MKT TIME: Missing", 1, 126


   Require "APPRAISER NAME: Missing", 1,127
   Require "SIGNATURE DATE: Missing", 1,128

   'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 1, 128

   ' Show warning if Expiration date already today's date  
   IsExpirationDatePastToday 1, 139

   if hasText(1,133) then
     'Show warning if signaturedate not = today's date 
     IsSignatureDateNOTToday 1, 134

     ' Show warning if Expiration date already today's date  
     IsExpirationDatePastToday 1, 140
   end if
   
' Show hard stop if both state cell 1,136 and 1,138 are filled in. We can only have one or the other
  CheckDuplicateState 1,130,1,132
  CheckDuplicateState 1,136,1,138

End Sub