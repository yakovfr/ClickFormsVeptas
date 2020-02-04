'FM00032.vbs Operating Income Statement Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   Require "BORROWER NAME: Missing", 1, 5
   Require "SUBJECT ADDRESS: Missing", 1, 6
   Require "SUBJECT CITY: Missing", 1, 7
   Require "SUBJECT COUNTY: Missing", 1, 8

   OnlyOneCheckofTwo 1, 9, 10, "", "UNIT 1 RENTED: Both Yes and No selected"
   OnlyOneCheckofTwo 1, 14, 15, "", "UNIT 2 RENTED: Both Yes and No selected"
   OnlyOneCheckofTwo 1, 19, 20, "", "UNIT 3 RENTED: Both Yes and No selected"
   OnlyOneCheckofTwo 1, 24, 25, "", "UNIT 4 RENTED: Both Yes and No selected"

   OnlyOneCheckofTwo 1, 31, 32, "", "ELECTRICITY: Both Owner and Tenant selected"
   OnlyOneCheckofTwo 1, 33, 34, "", "GAS: Both Owner and Tenant selected"
   OnlyOneCheckofTwo 1, 35, 36, "", "FUEL OIL: Both Owner and Tenant selected"
   OnlyOneCheckofTwo 1, 37, 38, "", "FUEL(OTHER): Both Owner and Tenant selected"
   OnlyOneCheckofTwo 1, 39, 40, "", "WATER/SEWER: Both Owner and Tenant selected"
   OnlyOneCheckofTwo 1, 41, 42, "", "TRASH: Both Owner and Tenant selected"


   Require "APPRAISER NAME: Missing", 2, 69
   Require "DATE: Missing", 2, 70


End Sub