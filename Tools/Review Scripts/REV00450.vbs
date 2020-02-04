'FM00450.vbs Compliance Inspection Report Review Script

Sub ReviewForm
  CheckRequireds	
End Sub


Sub CheckRequireds

   Require IDFilenum, 1, 2
   Require IDFilenum, 2, 2
   Require IDAddress, 1, 6


   OnlyOneCheckOfTwo 1, 18, 19,"","ITEM I-1: Both Was and Was Not Selected"
   OnlyOneCheckOfFive 1, 44, 45, 46, 47, 48,"","PART II - INSPECTION TYPE: More than one selected"
   OnlyOneCheckOfFour 1, 84, 85, 86, 87,"","PART II - INSPECTOR TYPE: More than one selected"
   OnlyOneCheckOfFour 1, 89, 90, 91, 92,"","PART III - 92800-B CONDITIONS: More than one selected"
   OnlyOneCheckOfThree 1, 95, 96, 97,"","PART III - INSPECTOR TYPE: More than one selected"



   OnlyOneCheckOfThree 1, 99, 103, 106,"","PART IV - ACCEPTANC TYPE: More than one selected"
   if isChecked(1,99) then OnlyOneCheckofThree 1, 100, 101, 102, "PART IV - NONCOMPLIANCE: No Sub-Cat selected", ""
   OnlyOneCheckOfThree 1, 108, 109, 110,"","PART IV - INSPECTOR TYPE: More than one selected"
 		

End Sub