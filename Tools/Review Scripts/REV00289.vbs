'FM00289.vbs High Dollar Residential Addendum Review Script
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   Require IDAddress, 1, 6
   Require "SUBJECT CITY: Missing", 1, 7
   Require "SUBJECT STATE: Missing", 1, 8
   Require "SUBJECT ZIP: Missing", 1, 9

   Require "MARKET TIME COMMENTS: Missing", 1, 10

   Require "SALES IN PRIOR 12 MONTHS: Missing", 1,17
   Require "EXPIRED LISTING IN PRIOR 12 MONTHS: Missing", 1,18
   Require "ACTIVE LISTINGS: Missing", 1,19

   Require "APPRAISER: Missing", 1, 25
   Require "SIGNATURE DATE: Missing", 1, 26
   'Show warning if signaturedate not = today's date 
    IsSignatureDateNOTToday 1, 26

   if not hastext(1, 27) and not hastext(1, 29) then
	Require "APPRAISER LICENSE NUMBER: Missing", 1, 27
   end if

   if hastext(1, 27) then require "CERTIFICATION STATE: Missing", 1, 28
   if hastext(1, 29) then require "LICENSE STATE: Missing", 1, 30

   OnlyOneCheckOfTwo 1, 37, 38,"","SUP APPRAISER INSPECTED: Both Did and Did Not Selected"

   if hastext(1, 31) then
   	Require "SUP APPRAISER SIGNATURE DATE: Missing", 1, 32
              'Show warning if signaturedate not = today's date 
              IsSignatureDateNOTToday 1, 32

	if not hastext(1, 33) and not hastext(1, 35) then
	   Require "SUP APPRAISER CERT NUMBER: Missing", 1, 33
        end if

   	if hastext(1, 33) then require "CERTIFICATION STATE: Missing", 1, 34
   	if hastext(1, 35) then require "LICENSE STATE: Missing", 1, 36
  	OnlyOneCheckOfTwo 1, 37, 38,"SUP APPRAISER INSPECTED: No Selection Made","SUP APPRAISER INSPECTED: Both Did and Did Not Selected"
   End If


End Sub