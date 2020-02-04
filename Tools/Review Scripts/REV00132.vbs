'FM00132.vbs Rels Res Appraisal Review Short Form Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2

   Require "LENDER/CLIENT NAME: Missing", 1, 5
   Require "BORROWER NAME: Missing", 1, 8
   Require "SUBJECT ADDRESS: Missing", 1, 9

   Require "APPRAISER NAME: Missing", 1, 17

   OnlyOneCheckOfThree 1, 20, 21, 22, "LEGAL : None Selected", "LEGAL: more than one checked"
   OnlyOneCheckOfThree 1, 23, 24, 25, "CENSUS: None Selected", "CENSUS: more than one checked"
   OnlyOneCheckOfThree 1, 26, 27, 28, "NEIGHBORHOOD: None Selected", "NEIGHBORHOOD: more than one checked"
   OnlyOneCheckOfThree 1, 29, 30, 31, "SITE: None Selected", "SITE: more than one checked"
   OnlyOneCheckOfThree 1, 32, 33, 34, "IMPROVEMENTS: None Selected", "IMPROVEMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 35, 36, 37, "SUBJECT UNIT: None Selected", "SUBJECT UNIT: more than one checked"
   OnlyOneCheckOfThree 1, 38, 39, 40, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"

   Require "DESCRIPTION COMMENTS: Missing", 1, 41

   OnlyOneCheckOfThree 1, 42, 43, 44, "PHYSICAL DEP: None Selected", "PHYSICAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 45, 46, 47, "FUNCTIONAL DEP: None Selected", "FUNCTIONAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 48, 49, 50, "EXTERNAL DEP: None Selected", "EXTERNAL DEP: more than one checked"
   OnlyOneCheckOfThree 1, 51, 52, 53, "LAND-TO-IMPROVEMENT: None Selected", "LAND-TO-IMPROVEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 54, 55, 56, "ADJUSTMENTS/CALCS: None Selected", "ADJUSTMENTS/CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 57, 58, 59, "COMMENTS: None Selected", "COMMENTS: more than one checked"

   Require "COST ANALYSIS COMMENTS: Missing", 1, 60

   OnlyOneCheckOfThree 1, 61, 62, 63, "DOC NUMBERS: None Selected", "DOC NUMBERS: more than one checked"
   OnlyOneCheckOfThree 1, 64, 65, 66, "LOC ADJUSTMENTS: None Selected", "LOC ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 67, 68, 69, "SITE/VIEW ADJUSTMENTS: None Selected", "SITE/VIEW ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 70, 71, 72, "QUALITY/DESIGN ADJUSTMENTS: None Selected", "QUALITY/DESIGN ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 73, 74, 75, "CONDITION ADJUSTMENTS: None Selected", "CONDITION ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 76, 77, 78, "ROOM COUNT/GLA ADJUSTMENTS: None Selected", "ROOM COUNT/GLA ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 79, 80, 81, "AMENITIES ADJUSTMENTS: None Selected", "AMENITIES ADJUSTMENTS: more than one checked"
   OnlyOneCheckOfThree 1, 82, 83, 84, "MATHS CALCS: None Selected", "MATHS CALCS: more than one checked"
   OnlyOneCheckOfThree 1, 85, 86, 87, "COMMENT SECTION: None Selected", "COMMENT SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 88, 89, 90, "NET ADJ RATIO: None Selected", "NET ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 97, 98, 99, "GROSS ADJ RATIO: None Selected", "GROSS ADJ RATIO: more than one checked"
   OnlyOneCheckOfThree 1, 106, 107, 108, "COMP DATA SECTION: None Selected", "COMP DATA SECTION: more than one checked"
   OnlyOneCheckOfThree 1, 109, 110, 111, "INCOME APPROACH: None Selected", "INCOME APPROACH: more than one checked"
   OnlyOneCheckOfThree 1, 112, 113, 114, "CONDO ADDENDA: None Selected", "CONDO ADDENDA: more than one checked"

   Require "MARKET ANALYSIS COMMENTS: Missing", 1, 115

   OnlyOneCheckOfThree 1, 116, 117, 118, "PLAT MAP: None Selected", "PLAT MAP: more than one checked"
   OnlyOneCheckOfThree 1, 119, 120, 121, "BUILDING SKETCH: None Selected", "BUILDING SKETCH: more than one checked"
   OnlyOneCheckOfThree 1, 122, 123, 124, "COMP MAP: None Selected", "COMP MAP: more than one checked"
   OnlyOneCheckOfThree 1, 125, 126, 127, "PHOTO PAGES: None Selected", "PHOTO PAGES: more than one checked"
   OnlyOneCheckOfThree 1, 128, 129, 130, "STMNT LIMITING COND: None Selected", "STMNT LIMITING COND: more than one checked"
   OnlyOneCheckOfThree 1, 131, 132, 133, "PURCHASE AGREEMENT: None Selected", "PURCHASE AGREEMENT: more than one checked"
   OnlyOneCheckOfThree 1, 134, 135, 136, "ORIGINAL SIGNATURE: None Selected", "ORIGINAL SIGNATURE: more than one checked"
   OnlyOneCheckOfThree 1, 137, 138, 139, "1004D: None Selected", "1004D: more than one checked"
   OnlyOneCheckOfThree 1, 140, 141, 142, "COPY OF PERMIT: None Selected", "COPY OF PERMIT: more than one checked"
   OnlyOneCheckOfThree 1, 143, 144, 145, "NO UNITS NOT COMPELTE: None Selected", "NO UNITS NOT COMPELTE: more than one checked"
   OnlyOneCheckOfThree 1, 146, 147, 148, "PRESALE REQUIREMENT NOT MET: None Selected", "PRESALE REQUIREMENT NOT MET: more than one checked"
   OnlyOneCheckOfThree 1, 149, 150, 151, "SALES FROM PROJECT NEEDED: None Selected", "SALES FROM PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 152, 153, 154, "SALES OUTSIDE PROJECT NEEDED: None Selected", "SALES OUTSIDE PROJECT NEEDED: more than one checked"
   OnlyOneCheckOfThree 1, 155, 156, 157, "ADDENDUM A: None Selected", "ADDENDUM A: more than one checked"
   OnlyOneCheckOfThree 1, 158, 159, 160, "ADDENDUM B: None Selected", "ADDENDUM B: more than one checked"
   OnlyOneCheckOfThree 1, 161, 162, 163, "RENTAL SURVEY: None Selected", "RENTAL SURVEY: more than one checked"
   OnlyOneCheckOfThree 1, 164, 165, 168, "OPERATING INCOME STMNT: None Selected", "OPERATING INCOME STMNT: more than one checked"

   Require "ADDENDA/CONDOMINIUM COMMENTS: Missing", 1, 167

   OnlyOneCheckOfThree 1, 168, 169, 170, "REVIEWERS SUMMARY: None Selected", "REVIEWERS SUMMARY: more than one checked"
   OnlyOneCheckOfFour 1, 171, 172, 173, 174, "REVIEWERS CONDITION: None Selected", "REVIEWERS CONDITION: more than one checked"
   
   If isChecked(1,174) then Require "REVISE ITEMS: None Selected",1,175

   Require "SUMMARY COMMENTS: Missing", 1, 176
   OnlyOneCheckOfTWO 1, 177, 178,"FIELD INSPECTION MADE: None Selected", "FIELD INSPECTION MADE: more than one checked"

   Require "APPRAISED VALUE: Missing", 1, 180
   Require "REVIEWERS VALUE: Missing", 1, 181


   Require "REVIEWER NAME: Missing", 1,182


End Sub