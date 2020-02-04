'FM00627.vbs Rels Enhanced Desk Review Form Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   Require "LENDER/CLIENT NAME: Missing", 1, 5
   Require "BORROWER NAME: Missing", 1, 7
   Require "SUBJECT ADDRESS: Missing", 1, 8
   Require "SUBJECT CITY: Missing", 1, 9
   Require "SUBJECT STATE: Missing", 1, 10

   Require "APPRAISER NAME: Missing", 1, 18

   OnlyOneCheckOfThree 1, 21, 22, 23, "LEGAL : None Selected", "LEGAL: more than one checked"
   OnlyOneCheckOfThree 1, 24, 25, 26, "CENSUS: None Selected", "CENSUS: more than one checked"
   OnlyOneCheckOfThree 1, 27, 28, 29, "NEIGHBORHOOD: None Selected", "NEIGHBORHOOD: more than one checked"
   OnlyOneCheckOfThree 1, 30, 31, 32, "SITE: None Selected", "SITE: more than one checked"
   OnlyOneCheckOfThree 1, 33, 34, 35, "IMPROVEMENTS: None Selected", "IMPROVEMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 36, 37, 38, "SUBJECT UNIT: None Selected", "SUBJECT UNIT: more than one checked"
   OnlyOneCheckOfThree 1, 39, 40, 41, "CONTRACT ANALYZED: None Selected", "CONTRACT ANALYZED: more than one checked"
   OnlyOneCheckOfThree 1, 42, 43, 44, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"

   Require "DESCRIPTION COMMENTS: Missing", 1, 45

   OnlyOneCheckOfThree 1, 46, 47, 48, "PHYSICAL DEP: None Selected", "PHYSICAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 49, 50, 51, "FUNCTIONAL DEP: None Selected", "FUNCTIONAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 52, 53, 54, "EXTERNAL DEP: None Selected", "EXTERNAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 55, 56, 57, "LAND-TO-IMPROVEMENT: None Selected", "LAND-TO-IMPROVEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 58, 59, 60, "ADJUSTMENTS/CALCS: None Selected", "ADJUSTMENTS/CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 61, 62, 62, "COMMENTS: None Selected", "COMMENTS: more than one checked"

   Require "COST ANALYSIS COMMENTS: Missing", 1, 64

   OnlyOneCheckOfThree 1, 65, 66, 67, "DOC NUMBERS: None Selected", "DOC NUMBERS: more than one checked"
   OnlyOneCheckOfThree 1, 68, 69, 70, "LOC ADJUSTMENTS: None Selected", "LOC ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 71, 72, 73, "SITE/VIEW ADJUSTMENTS: None Selected", "SITE/VIEW ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 74, 75, 76, "QUALITY/DESIGN ADJUSTMENTS: None Selected", "QUALITY/DESIGN ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 77, 78, 79, "CONDITION ADJUSTMENTS: None Selected", "CONDITION ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 80, 81, 82, "ROOM COUNT/GLA ADJUSTMENTS: None Selected", "ROOM COUNT/GLA ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 83, 84, 85, "AMENITIES ADJUSTMENTS: None Selected", "AMENITIES ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 86, 87, 88, "MATHS CALCS: None Selected", "MATHS CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 89, 90, 91, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 92, 93, 94, "NET ADJ RATIO: None Selected", "NET ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 101, 102, 103, "GROSS ADJ RATIO: None Selected", "GROSS ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 110, 111, 112, "COMP DATA SECTION: None Selected", "COMP DATA SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 113, 114, 115, "INCOME APPROACH: None Selected", "INCOME APPROACH: more than one checked"
   OnlyOneCheckOfThree 1, 116, 117, 118, "CONDO ADDENDA: None Selected", "CONDO ADDENDA: more than one checked"

   Require "MARKET ANALYSIS COMMENTS: Missing", 1, 119

   OnlyOneCheckOfThree 1, 120, 121, 122, "PLAT MAP: None Selected", "PLAT MAP: more than one checked"
   OnlyOneCheckOfThree 1, 123, 124, 125, "BUILDING SKETCH: None Selected", "BUILDING SKETCH: more than one checked"
   OnlyOneCheckOfThree 1, 126, 127, 128, "COMP MAP: None Selected", "COMP MAP: more than one checked"
   OnlyOneCheckOfThree 1, 129, 130, 131, "PHOTO PAGES: None Selected", "PHOTO PAGES: more than one checked"
   OnlyOneCheckOfThree 1, 132, 133, 134, "STMNT LIMITING COND: None Selected", "STMNT LIMITING COND: more than one checked"
   OnlyOneCheckOfThree 1, 135, 136, 137, "PURCHASE AGREEMENT: None Selected", "PURCHASE AGREEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 138, 139, 140, "ORIGINAL SIGNATURE: None Selected", "ORIGINAL SIGNATURE: more than one checked"
   OnlyOneCheckOfThree 1, 141, 142, 143, "1004D: None Selected", "1004D: more than one checked"
   OnlyOneCheckOfThree 1, 144, 145, 146, "COPY OF PERMIT: None Selected", "COPY OF PERMIT: more than one checked"
   OnlyOneCheckOfThree 1, 147, 148, 149, "NO UNITS NOT COMPELTE: None Selected", "NO UNITS NOT COMPELTE: more than one checked"
   OnlyOneCheckOfThree 1, 150, 151, 152, "PRESALE REQUIREMENT NOT MET: None Selected", "PRESALE REQUIREMENT NOT MET: more than one checked"
   OnlyOneCheckOfThree 1, 153, 154, 155, "SALES FROM PROJECT NEEDED: None Selected", "SALES FROM PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 156, 157, 158, "SALES OUTSIDE PROJECT NEEDED: None Selected", "SALES OUTSIDE PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 159, 160, 161, "ADDENDUM A: None Selected", "ADDENDUM A: more than one checked"
   OnlyOneCheckOfThree 1, 162, 163, 164, "ADDENDUM B: None Selected", "ADDENDUM B: more than one checked"
   OnlyOneCheckOfThree 1, 165, 166, 167, "RENTAL SURVEY: None Selected", "RENTAL SURVEY: more than one checked"
   OnlyOneCheckOfThree 1, 168, 169, 170, "OPERATING INCOME STMNT: None Selected", "OPERATING INCOME STMNT: more than one checked"

   Require "ADDENDA/CONDOMINIUM COMMENTS: Missing", 1, 171

   OnlyOneCheckOfThree 1, 172, 173, 174, "REVIEWERS SUMMARY: None Selected", "REVIEWERS SUMMARY: more than one checked"
   Require "SUMMARY COMMENTS: Missing", 1, 175
   Require "APPRAISED VALUE: Missing", 1, 177
   Require "REVIEWERS VALUE: Missing", 1, 178


   Require "REVIEWER NAME: Missing", 2,5
   Require "DATE OF REVIEW: Missing", 2, 10


End Sub