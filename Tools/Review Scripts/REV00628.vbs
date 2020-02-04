'FM00628.vbs Rels Desk Review Short Form Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   OnlyOneCheckOfTWO 1, 5, 6,"REVIEW TYPE : None Selected", "REVIEW TYPE: more than one checked"

   Require "LENDER/CLIENT NAME: Missing", 1, 7
   Require "BORROWER NAME: Missing", 1, 9
   Require "SUBJECT ADDRESS: Missing", 1, 10
   Require "SUBJECT CITY: Missing", 1, 11
   Require "SUBJECT STATE: Missing", 1, 12

   Require "APPRAISER NAME: Missing", 1, 20

   OnlyOneCheckOfThree 1, 23, 24, 25, "LEGAL : None Selected", "LEGAL: more than one checked"
   OnlyOneCheckOfThree 1, 26, 27, 28, "CENSUS: None Selected", "CENSUS: more than one checked"
   OnlyOneCheckOfThree 1, 29, 30, 31, "NEIGHBORHOOD: None Selected", "NEIGHBORHOOD: more than one checked"
   OnlyOneCheckOfThree 1, 32, 33, 34, "SITE: None Selected", "SITE: more than one checked"
   OnlyOneCheckOfThree 1, 35, 36, 37, "IMPROVEMENTS: None Selected", "IMPROVEMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 38, 39, 40, "SUBJECT UNIT: None Selected", "SUBJECT UNIT: more than one checked"
   OnlyOneCheckOfThree 1, 41, 42, 43, "CONTRACT ANALYZED: None Selected", "CONTRACT ANALYZED: more than one checked"
   OnlyOneCheckOfThree 1, 44, 45, 46, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"

   Require "DESCRIPTION COMMENTS: Missing", 1, 47

   OnlyOneCheckOfThree 1, 48, 49, 50, "PHYSICAL DEP: None Selected", "PHYSICAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 51, 52, 53, "FUNCTIONAL DEP: None Selected", "FUNCTIONAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 54, 55, 56, "EXTERNAL DEP: None Selected", "EXTERNAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 57, 58, 59, "LAND-TO-IMPROVEMENT: None Selected", "LAND-TO-IMPROVEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 60, 61, 62, "ADJUSTMENTS/CALCS: None Selected", "ADJUSTMENTS/CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 63, 64, 65, "COMMENTS: None Selected", "COMMENTS: more than one checked"

   Require "COST ANALYSIS COMMENTS: Missing", 1, 66

   OnlyOneCheckOfThree 1, 67, 68, 69, "DOC NUMBERS: None Selected", "DOC NUMBERS: more than one checked"
   OnlyOneCheckOfThree 1, 70, 71, 72, "LOC ADJUSTMENTS: None Selected", "LOC ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 73, 74, 75, "SITE/VIEW ADJUSTMENTS: None Selected", "SITE/VIEW ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 76, 77, 78, "QUALITY/DESIGN ADJUSTMENTS: None Selected", "QUALITY/DESIGN ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 79, 80, 81, "CONDITION ADJUSTMENTS: None Selected", "CONDITION ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 82, 83, 84, "ROOM COUNT/GLA ADJUSTMENTS: None Selected", "ROOM COUNT/GLA ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 85, 86, 87, "AMENITIES ADJUSTMENTS: None Selected", "AMENITIES ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 88, 89, 90, "MATHS CALCS: None Selected", "MATHS CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 91, 92, 93, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 94, 95, 96, "NET ADJ RATIO: None Selected", "NET ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 103, 104, 105, "GROSS ADJ RATIO: None Selected", "GROSS ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 112, 113, 114, "COMP DATA SECTION: None Selected", "COMP DATA SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 115, 116, 117, "INCOME APPROACH: None Selected", "INCOME APPROACH: more than one checked"
   OnlyOneCheckOfThree 1, 118, 119, 120, "CONDO ADDENDA: None Selected", "CONDO ADDENDA: more than one checked"

   Require "MARKET ANALYSIS COMMENTS: Missing", 1, 121

   OnlyOneCheckOfThree 1, 122, 123, 124, "PLAT MAP: None Selected", "PLAT MAP: more than one checked"
   OnlyOneCheckOfThree 1, 125, 126, 127, "BUILDING SKETCH: None Selected", "BUILDING SKETCH: more than one checked"
   OnlyOneCheckOfThree 1, 128, 129, 130, "COMP MAP: None Selected", "COMP MAP: more than one checked"
   OnlyOneCheckOfThree 1, 131, 132, 133, "PHOTO PAGES: None Selected", "PHOTO PAGES: more than one checked"
   OnlyOneCheckOfThree 1, 134, 135, 136, "STMNT LIMITING COND: None Selected", "STMNT LIMITING COND: more than one checked"
   OnlyOneCheckOfThree 1, 137, 138, 139, "PURCHASE AGREEMENT: None Selected", "PURCHASE AGREEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 140, 141, 142, "ORIGINAL SIGNATURE: None Selected", "ORIGINAL SIGNATURE: more than one checked"
   OnlyOneCheckOfThree 1, 143, 144, 145, "1004D: None Selected", "1004D: more than one checked"
   OnlyOneCheckOfThree 1, 146, 147, 148, "COPY OF PERMIT: None Selected", "COPY OF PERMIT: more than one checked"
   OnlyOneCheckOfThree 1, 149, 150, 151, "NO UNITS NOT COMPELTE: None Selected", "NO UNITS NOT COMPELTE: more than one checked"
   OnlyOneCheckOfThree 1, 152, 153, 154, "PRESALE REQUIREMENT NOT MET: None Selected", "PRESALE REQUIREMENT NOT MET: more than one checked"
   OnlyOneCheckOfThree 1, 155, 156, 157, "SALES FROM PROJECT NEEDED: None Selected", "SALES FROM PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 158, 159, 160, "SALES OUTSIDE PROJECT NEEDED: None Selected", "SALES OUTSIDE PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 161, 162, 163, "ADDENDUM A: None Selected", "ADDENDUM A: more than one checked"
   OnlyOneCheckOfThree 1, 164, 165, 166, "ADDENDUM B: None Selected", "ADDENDUM B: more than one checked"
   OnlyOneCheckOfThree 1, 167, 168, 169, "RENTAL SURVEY: None Selected", "RENTAL SURVEY: more than one checked"
   OnlyOneCheckOfThree 1, 170, 171, 172, "OPERATING INCOME STMNT: None Selected", "OPERATING INCOME STMNT: more than one checked"

   Require "ADDENDA/CONDOMINIUM COMMENTS: Missing", 1, 173

   OnlyOneCheckOfThree 1, 174, 175, 176, "REVIEWERS SUMMARY: None Selected", "REVIEWERS SUMMARY: more than one checked"
   Require "SUMMARY COMMENTS: Missing", 1, 177
   Require "APPRAISED VALUE: Missing", 1, 179
   Require "REVIEWERS VALUE: Missing", 1, 180

   OnlyOneCheckOfTWO 2, 5, 6,"SCOPE : None Selected", "SCOPE: more than one checked"

   Require "REVIEWER NAME: Missing", 2,7
   Require "DATE OF REVIEW: Missing", 2, 12


End Sub