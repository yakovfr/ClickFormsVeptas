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
'Subject checking
 If hasText(1,16) Then
   'PCV #1: Is the Sales Concessions for comps 1-? Blank.
    'FN_CONC = "SALES CONCESSION OF THE SUBJECT: " & REQUIRED_DATA_MISSING
    'Require FN_CONC, 1, 29
   'PCV #2: Is the Location for the Subject in the Comparable Sales grid blank?
   CSU_LC_LOCAT = "**LOCATION OF THE SUBJECT: " & REQUIRED_DATA_MISSING
   Require CSU_LC_LOCAT, 1, 30
   'PCV #3: Is the Site for the Subject in the Comparable Sales grid blank?
   CSU_ST_SITSIZE = "**SITE OF THE SUBJECT: " & REQUIRED_DATA_MISSING
   Require CSU_ST_SITSIZE, 1, 31
  'PCV #4: Is the View for the Subject in the Comparable Sales grid blank?
   CSU_ST_SITEVW = "**VIEW OF THE SUBJECT: " & REQUIRED_DATA_MISSING
   Require CSU_ST_SITEVW, 1, 32
  'PCV #5: Is the Design and Appeal for the Subject in the Comparable Sales grid blank?
   CSU_DA_DESAPL = "**DESIGN AND APPEAL OF THE SUBJECT: " & REQUIRED_DATA_MISSING
   Require CSU_DA_DESAPL, 1, 33
  'PCv #6: Is the Quality of Construction for the Subject in the Comparable Sales grid blank?
   CSU_DA_CONSTQL = "**QUALITY CONSTRUCTION OF THE SUBJECT: " & REQUIRED_DATA_MISSING
   Require CSU_DA_CONSTQL, 1, 34
  'PCV #7: Is the Age for the Subject in the Comparable Sales grid blank?
  CSU_AG_AGYRBLT = "**AGE OF THE SUBJECT: " & REQUIRED_DATA_MISSING
  Require CSU_AG_AGYRBLT, 1, 35
  'PCv #8: Is the Condition for the Subject in the Comparable Sales grid blank?
  CSU_AG_COND = "**CONDITION OF THE SUBJECT: " & REQUIRED_DATA_MISSING
  Require CSU_AG_COND, 1, 36
  'PCV #9: Is the Basement & Finished Rooms for the Subject in the Comparable Sales grid blank?
  'CSU_BM_BSM = "**BASEMENT & FINISHED ROOMS OF THE SUBJECT: " & REQUIRED_DATA_MISSING
  'Require CSU_BM_BSM, 1, 42
  'PCV #10: Is the Functional Utility for the Subject in the Comparable Sales grid blank?
  CSU_FU_FUNCTUT = "**FUNCTIONAL UTILITY OF THE SUBJECT: " & REQUIRED_DATA_MISSING
  Require CSU_FU_FUNCTUT, 1, 43
  'PCV #11: Is the Heating/Cooling for the Subject in the Comparable Sales grid blank?
  CSU_HC_HTCOOL = "**HEATING/COOLING OF THE SUBJECT: " & REQUIRED_DATA_MISSING
  Require CSU_HC_HTCOOL, 1, 44
  'PCV #12: Is the Garage/Carport for the Subject in the Comparable Sales grid blank?
  CSU_CR_GARPRK = "**GARAGE/CARPORT OF THE SUBJECT: "  & REQUIRED_DATA_MISSING
  Require CSU_CR_GARPRK, 1, 45
  'PCV #13: Is the Porch, Patio, etc for Subject, comps 1-? Blank.
  PF_PORPAT = "**PORCH, PATIO, ETC OF SUBJECT:"  & REQUIRED_DATA_MISSING
  Require PF_PORPAT, 1, 47
End If

 Require "RECOMMENDED INSPECTIONS COMMENTS: Missing", 1, 248
 if hasText(1, 52) then
   Require "COMP 1 DOM: Missing", 1, 249
 end if
 if hasText(1, 109) then
   Require "COMP 2 DOM: Missing", 1, 250
 end if
 if hasText(1, 166) then
   Require "COMP 3 DOM: Missing", 1, 251
 end if
 if hasText(1, 52) or hasText(1, 109) or hasText(1, 166) then  
   Require "COMP DOM COMMENTS: Missing", 1, 252
 end if
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
