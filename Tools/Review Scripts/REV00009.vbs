'FM00009.vbs Land Appraisal Report Review Script
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 3
   Require "BORROWER NAME: Missing", 1, 6
   Require "SUBJECT CENSUS: Missing", 1, 7
   Require "SUBJECT MAP REF: Missing", 1, 8
   Require "SUBJECT ADDRESS: Missing", 1, 9
   Require "SUBJECT CITY: Missing", 1, 10
   Require "SUBJECT COUNTY: Missing", 1, 11
   Require "SUBJECT STATE: Missing", 1, 12
   Require "SUBJECT ZIP: Missing", 1, 13
   Require "SUBJECT LEGAL DESC: Missing", 1, 14

   OnlyOneCheckofThree 1, 18,19,20, "PROPERTY RIGHTS APPRAISED: None Selected", "PROPERTY RIGHTS APRAISED: More than one selected"
   Require "SUBJECT TAXES: Missing", 1, 21
   Require "LENDER/CLIENT NAME: Missing", 1, 24
   Require "APPRAISER NAME: Missing", 1, 27
   Require "APPRAISER INSTRUCTIONS: Missing", 1, 28

   OnlyOneCheckOfThree 1, 30, 31, 32, "NBRHD LOCATION: None Selected", "NBRHD LOCATION: more than one checked"
   OnlyOneCheckOfThree 1, 33, 34, 35, "NBRHD BUILT_UP: None Selected", "NBRHD BUILT_UP: more than one checked"
   OnlyOneCheckOfFour 1, 36, 37, 38, 39, "NBRHD GROWTH: None Selected", "NBRHD GROWTH: more than one checked"
   OnlyOneCheckOfThree 1, 40, 41, 42, "NBRHD VALUES: None Selected", "NBRHD VALUES: more than one checked"
   OnlyOneCheckOfThree 1, 43, 44, 45, "NBRHD SUPP/DEM: None Selected", "NBRHD SUPP/DEM: more than one checked"
   OnlyOneCheckOfThree 1, 46, 47, 48, "NBRHD MKT TIME: None Selected", "NBRHD MKT TIME: more than one checked"

   OnlyOneCheckOfThree 1, 58, 59, 60, "LAND USE CHANGE: None Selected", "LAND USE CHANGE: more than one checked"
   OnlyOneCheckofTwo 1, 63, 64, "PRED OCCUPANCY: None Selected", "PRED OCCUPANCY: more than one selected"

   OnlyOneCheckOfFour 1, 72,73,74,75, "NBRHD EMP STABILITY: None Selected", "NBRHD EMP STABILITY: more than one checked"
   OnlyOneCheckOfFour 1, 76,77,78,79, "NBRHD CONV TO EMP: None Selected", "NBRHD CONV TO EMP: more than one checked"
   OnlyOneCheckOfFour 1, 80,81,82,83, "NBRHD CONV TO SHOPPING: None Selected", "NBRHD CONV TO SHOPPING: more than one checked"
   OnlyOneCheckOfFour 1, 84,85,86,87, "NBRHD CONV TO SCHOOLS: None Selected", "NBRHD CONV TO SCHOOLS: more than one checked"
   OnlyOneCheckOfFour 1, 88,89,90,91, "NBRHD PUB TRANS: None Selected", "NBRHD PUB TRANS: more than one checked"
   OnlyOneCheckOfFour 1, 92,93,94,95, "NBRHD REC FACIL: None Selected", "NBRHD REC FACIL: more than one checked"
   OnlyOneCheckOfFour 1, 96,97,98,99, "NBRHD GROWTH : None Selected", "NBRHD GROWTH : more than one checked"
   OnlyOneCheckOfFour 1, 100,101,102,103, "NBRHD ADEQ OF UTILS: None Selected", "NBRHD ADEQ OF UTILS: more than one checked"
   OnlyOneCheckOfFour 1, 104,105,106,107, "NBRHD PROP COMPAT : None Selected", "NBRHD PROP COMP: more than one checked"
   OnlyOneCheckOfFour 1, 108,109,110,111, "NBRHD POL/FIRE PROT: None Selected", "NBRHD POL/FIRE POP: more than one checked"
   OnlyOneCheckOfFour 1, 112,113,114,115, "NBRHD APPEARANCE: None Selected", "NBRHD APPEARANCE: more than one checked"
   OnlyOneCheckOfFour 1, 116,117,118,119, "NBRHD APPEAL: None Selected", "NBRHD APPEAL: more than one checked"

   OnlyOneCheckofTwo 1, 125, 126, "PRES IMPROVEMENTS: None Selected", "PRES IMPROVEMENTS: more than one selected"
   OnlyOneCheckofTwo 1, 127, 128, "ZONING COMPLIANCE: None Selected", "ZONING COMPLIANCE: more than one selected"
   OnlyOneCheckofTwo 1, 139, 140, "STREET ACCESS: None Selected", "STREET ACCESS: more than one selected"

   OnlyOneCheckofTwo 1, 153, 154, "FLOOD: None Selected", "ZONING COMPLIANCE: more than one selected"


   Require "APPRAISER: Missing", 1, 264
   Require "SIGNATURE DATE: Missing", 1, 265
   'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 1, 265

   OnlyOneCheckOfTwo 1, 271, 272,"","SUP APPRAISER INSPECTED: Both Did and Did Not Selected"


End Sub