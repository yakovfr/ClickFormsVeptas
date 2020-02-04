'FM00530.vbs Manufactured Home Inspection Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   Require "BORROWER NAME: Missing", 1, 5
   Require "SUBJECT ADDRESS: Missing", 1, 6
   Require "SUBJECT CITY: Missing", 1, 7
   Require "SUBJECT COUNTY: Missing", 1, 8
   Require "SUBJECT STATE: Missing", 1, 9
   Require "SUBJECT ZIP: Missing", 1, 10

   Require "LENDER/CLIENT NAME: Missing", 1, 11
   Require "HUD TAG NUMBERS: Missing", 1, 13
   Require "MANUFACTURE DATE: Missing", 1, 14
   Require "SERIAL NUMBERS: Missing", 1, 15
   Require "MANUFACTURER: Missing", 1, 16

   OnlyOneCheckofTwo 1, 17, 18, "", "PERMANENTLY AFFIXED CONC: more than one selected"
   OnlyOneCheckofTwo 1, 21, 22, "", "PERMANENTLY AFFIXED POST: more than one selected"
   OnlyOneCheckofFour 1, 25, 26, 27, 28, "", "NOT PERMANENTLY AFFIXED: more than one selected"

   OnlyOneCheckofTwo 1, 19, 20, "", "FOOTINGS: more than one selected"
   OnlyOneCheckofTwo 1, 23, 24, "", "FOOTINGS: more than one selected"

   OnlyOneCheckofTwo 1, 30, 31, "CONVERTED TO REAL: No Selection Made", "CONVERTED TO REAL: more than one selected"
   OnlyOneCheckofFour 1, 33, 34, 35, 36, "FOUNDATION DES BY ENGINEER: No Selection Made", "FOUNDATION DES BY ENGINEER: more than one selected"
   OnlyOneCheckofThree 1, 37,38,39, "FOUNDATION SUITABLE: None Selected", "FOUNDATION SUITABLE: More than one selected"
   OnlyOneCheckofThree 1, 40,41,42, "POSTS AND PIERS: None Selected", "POSTS AND PIERS: More than one selected"
   OnlyOneCheckofTwo 1, 43, 44, "FOUNDATION TYPICAL: No Selection Made", "FOUNDATION TYPICAL: more than one selected"
   OnlyOneCheckofTwo 1, 45, 46, "WHEELS/AXELS REMOVED: No Selection Made", "WHEELS/AXELS REMOVED: more than one selected"
   OnlyOneCheckofTwo 1, 47, 48, "SUBJECT IS DOUBLEWIDE: No Selection Made", "SUBJECT IS DOUBLEWIDE: more than one selected"
   OnlyOneCheckofThree 1, 49,50,51, "MEETS ZONING: None Selected", "MEETS ZONING: More than one selected"
   OnlyOneCheckofTwo 1, 52, 53, "ACCEPTABLE CHAR: No Selection Made", "ACCEPTABLE CHAR: more than one selected"
   OnlyOneCheckofTwo 1, 54, 55, "CONST TYPICAL: No Selection Made", "CONST TYPICAL: more than one selected"
   
   Require "COMMENTS: Missing", 1, 56
   Require "COMMENTS: Missing", 1, 57
   Require "COMMENTS: Missing", 1, 58
   Require "COMMENTS: Missing", 1, 59
   Require "COMMENTS: Missing", 1, 62
   
   if not hastext(1,60) and not hasText(1,61) then require "CERT OR LICENSE: Missing", 1, 60



End Sub