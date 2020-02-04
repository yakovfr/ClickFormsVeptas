'FM00850_PCV.vbs SUMMARY APPRAISAL REPORT Reviewer Script
' 12/17/2014: New PCV Rules
'PCVAC-1: Are Foreclosure Sales a Factor, Both Boxes Checked.  Check one Box
'PCVAC-2: Are Foreclosure Sales a Factor, Neither Box Checked.  Check one Box
'PCVAC-3: Cite Data Source(s) field is blank.  Provide required Data Source(s)
'PCVAC-4: Explain in Detail field is blank.  Provide required comments
'PCVAC-5: Seller Paid Fin Asst Prevalent, both Boxes Checked.  Check one Box
'PCVAC-6: Seller Paid Fin Asst Prevalent, neither Box Checked.  Check one Box
'PCVAC-8: Appraiser Name is "N/A". Provide Appraiser Name.
'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name.
'PCVAC-10: Address of Property Appraised Number and Street is "N/A".  Provide Number and Street of Subject Property.
'PCVAC-11: Address of Property Appraised Number and Street is Blank.  Provide Number and Street of Subject Property.
' 11/03/2014
' PCV Rules #4 (ERROR): Are forclosure sales a factor - Are Foreclosures a Factor, "Yes" box is checked but Comments Field is Blank.  Provide Required comments.
'PCV Rules #13 (Warning): The total number of comparable sales reported is under 20, too small to be significant.  Provide narrative support and additional research data that supports the Market Trends in the report.


Sub ReviewForm

dim performcondo '2780

AddTitle String(5, "=") + "FNMA 1004MC " + IDSUBJECT + String(5, "=")

   'Header Information
   Require IDFilenum, 1, 2
   Require "Borrower/Applicant Name Not Entered", 1, 9
   Require "Address Not Entered", 1, 5
   Require "City Not Entered", 1, 6
   Require "State Not Entered", 1, 7
   Require "Zip Code NOt Entered", 1, 8

   
   Require "No Comp Sales Prior 7-12 Months Entered",1,10
   Require "No Comp Sales Prior 4-6 Months Entered",1,11
   Require "No Comp Sales Prior -3 Months Entered",1,12
   Require "No Absorption Rate Prior 7-12 Months Entered",1,16
   Require "No Absorption Rate Prior 4-6 Months Entered",1,17
   Require "No Absorption Rate Current-3 Months Entered",1,18
   Require "No Median Comp Sale Price Prior 7-12 Months Entered",1,34
   Require "No Median Comp Sale Price Prior 4-6 Months Entered",1,35
   Require "No Median Comp Sale Price Current-3 Months Entered",1,36
   Require "No Median Comp Sale DOM Prior 7-12 Months Entered",1,40
   Require "No Median Comp Sale DOM Prior 4-6 Months Entered",1,41
   Require "No Median Comp Sale DOM Current-3 Months Entered",1,42
   Require "No Median Sale/List Ratio Prior 7-12 Months Entered",1,58
   Require "No Median Sale/List Ratio Prior 4-6 Months Entered",1,59
   Require "No Median Sale/List Ratio Current-3 Months Entered",1,60

   Require "No Active Listings Current-3 Months Entered",1,24
   Require "No Months of Supply Current-3 Months Entered",1,30
   Require "No Median List Price Current-3 Months Entered",1,48
   Require "No Median Listings DOM Current-3 Months Entered",1,54

   Require "No Active Listings 7-12 Months (use 'N/A' instead of blank)",1,22
   Require "No Active Listings 4-6 Months (use 'N/A' instead of blank)",1,23

   Require "No Months of Supply 7-12 Months (use 'N/A' instead of blank)",1,28
   Require "No Months of Supply 4-6 Months (use 'N/A' instead of blank)",1,29

   Require "No Median List Price 7-12 Months (use 'N/A' instead of blank)",1,46
   Require "No Median List Price 4-6 Months (use 'N/A' instead of blank)",1,47

   Require "No Median Listings DOM 7-12 Months (use 'N/A' instead of blank)",1,52
   Require "No Median Listings DOM 4-6 Months (use 'N/A' instead of blank)",1,52

  OnlyOneCheckOfThree 1, 13, 14, 15, "No Trend Selected for Total Comparable Sales", "Too Many Trends Selected for Total Comparable Sales"  
  OnlyOneCheckOfThree 1, 19, 20, 21, "No Trend Selected for Absorption Rate", "Too Many Trends Selected for Absorption Rates"  

  if (not isNegativeComment(1,22)) and (not isNegativeComment(1,23)) then
    OnlyOneCheckOfThree 1, 25, 26, 27, "No Trend Selected for Total Active Listings", "Too Many Trends Selected for Total Active Listings"  
  end if
  if (not isNegativeComment(1,28)) and (not isNegativeComment(1,29)) then
    OnlyOneCheckOfThree 1, 31, 32, 33, "No Trend Selected for Months of Supply", "Too Many Trends Selected for Months of Supply"  
  end if
 
  OnlyOneCheckOfThree 1, 37, 38, 39, "No Trend Selected for Median Comp Sale Price", "Too Many Trends Selected for Median Comp Sale Price"  
  OnlyOneCheckOfThree 1, 43, 44, 45, "No Trend Selected for Median DOM", "Too Many Trends Selected for Median DOM"  


  if (not isNegativeComment(1,46)) and (not isNegativeComment(1,47)) then
    OnlyOneCheckOfThree 1, 49, 50, 51, "No Trend Selected for Median Comp List Price", "Too Many Trends Selected for Median Comp List Price"  
  end if
  if (not isNegativeComment(1,52)) and (not isNegativeComment(1,53)) then
    OnlyOneCheckOfThree 1, 55, 56, 57, "No Trend Selected for Median Listings DOM", "Too Many Trends Selected for Median Listings DOM"  
  end if

  OnlyOneCheckOfThree 1, 61, 62, 63, "No Trend Selected for Median Sale/List Price Ratio", "Too Many Trends Selected for Median Sale/List Price Ratio"  
  
  
  OnlyOneCheckOfThree 1, 66, 67, 68, "No Trend Selected for Seller Financing", "Too Many Trends Selected for Seller Financing"  
  OnlyOneCheckOfTwo 1, 64, 65, "No Prevalence of Seller Financing Selected", "Too Many Prevalence of Seller Financing Selected"  
 
  Require "No Comments on Seller Concession Trends", 1, 69

  OnlyOneCheckOfTwo 1, 70, 71, "No Indicator Selected for REO being a Mkt Factor", "Too Many Indicators Selected for REO being a Mkt Factor"

 'PCV Rules #4 (ERROR): Are forclosure sales a factor - Are Foreclosures a Factor, "Yes" box is checked but Comments Field is Blank.  Provide Required comments.
  if GetCheck(1,70) then Require "** Are Foreclosures a Factor, YES box is checked but Comments Field is Blank.  Provide Required comments", 1,72

  Require "No Comments on Data Sources", 1,73
  Require "No Summary Neighborhood Comments", 1,74

'PCV Rules #13 (Warning): The total number of comparable sales reported is under 20, too small to be significant.  Provide narrative support and additional research data that supports the Market Trends in the report.
COMP_ERROR = "The total number of comparable sales reported is under 20, too small to be significant.  Provide narrative support and additional research data that supports the Market Trends in the report."
 if (GetValue(1, 12) <= 20) then
    AddRec COMP_ERROR, 1, 12
 end if
 
  
performcondo = false

  if hastext(1,75) then performcondo = true
  if (hastext(1,76)) or (hastext(1,77)) or (hastext(1,78)) then performcondo = true
  if (getCheck(1,79)) or (getCheck(1,80)) or (getCheck(1,81)) then performcondo = true
  if (hastext(1,82)) or (hastext(1,83)) or (hastext(1,84)) then performcondo = true
  if (getCheck(1,85)) or (getCheck(1,86)) or (getCheck(1,87)) then performcondo = true
  if (hastext(1,88)) or (hastext(1,89)) or (hastext(1,90)) then performcondo = true
  if (getCheck(1,91)) or (getCheck(1,92)) or (getCheck(1,93)) then performcondo = true
  if (hastext(1,94)) or (hastext(1,95)) or (hastext(1,96)) then performcondo = true
  if (getCheck(1,97)) or (getCheck(1,98)) or (getCheck(1,99)) then performcondo = true
  if (getCheck(1,100)) or (getCheck(1,101)) then performcondo = true
  if hastext(1,102) then performcondo = true
  if hastext(1,103) then performcondo = true

  
  
if performcondo = true then call DoCondo

  if not hastext(1,104) then Require "No Appraiser Name Provided", 1, 104
  if not hastext(1,106) then Require "No Appraiser Address Provided", 1, 106
  if not hastext(1,107) then Require "No Appraiser License/Cert # Provided", 1, 107

  Require "No Appraiser State Provided", 1, 108

 'PCV Rules #10: The Overall Trend for Median Sale Price doesn't support the One-Unit Housing Trend for Property Values in the Neighborhood Section of the Report.  
'Reconcile conflicting Data.
OVERALL_ERROR = "** The Overall Trend for Median Sale Price doesn't support the One-Unit Housing Trend for Property Values in the Neighborhood Section of the Report."
'only fire up when we have overall trend data
skipIt = (GetText(1, 76) = "") and (GetText(1, 77) = "") and (GetText(1, 78) = "")
if not skipIt then
  skipIt = (UCase(GetText(1, 76)) = "N/A") and (UCase(GetText(1, 77)) = "N/A") and (UCase(GetText(1, 78)) = "N/A")
end if
if not SkipIt then 
  if isChecked(1, 37) and not isChecked(1, 79) then
    AddRec OVERALL_ERROR, 1, 79
  end if  
  if isChecked(1, 38) and not isChecked(1, 80) then
    AddRec OVERALL_ERROR, 1, 80
  end if  
  if isChecked(1, 39) and not isChecked(1, 81) then
    AddRec OVERALL_ERROR, 1, 81
  end if
end if

 '########################### START PCV RULES  ############################################  
 'PCVAC-1: Are Foreclosure Sales a Factor, Both Boxes Checked.  Check one Box
 PCVAC1Msg = "** Are Foreclosure Sales a Factor, Both Boxes Checked.  Check one Box."
 if isChecked(1, 70) and isChecked(1, 71) then
   AddRec PCVAC1Msg, 1, 70
 end if
 
 'PCVAC-2: Are Foreclosure Sales a Factor, Neither Box Checked.  Check one Box
 PCVAC2Msg = "** Are Foreclosure Sales a Factor, Neither Box Checked.  Check one Box."
 if not isChecked(1, 70) and not isChecked(1, 71) then
   AddRec PCVAC2Msg, 1, 70
 end if

 'PCVAC-3: Cite Data Source(s) field is blank.  Provide required Data Source(s)
 PCVAC3MSg = "** Cite Data Source(s) field is blank.  Provide required Data Source(s)."
 if GetText(1, 73) = "" then
   AddRec PCVAC3Msg, 1, 73
 end if

'PCVAC-4: Explain in Detail field is blank.  Provide required comments
PCVAC4Msg = "** Explain in Detail field is blank.  Provide required comments." 
if GetText(1, 69) = "" then
  AddRec PCVAC4Msg, 1, 69
end if
 
'PCVAC-5: Seller Paid Fin Asst Prevalent, both Boxes Checked.  Check one Box
PCVAC5Msg = "** Seller Paid Fin Asst Prevalent, both Boxes Checked.  Check one Box." 
if isChecked(1, 64) and isChecked(1, 65) then
  AddRec PCVAC5Msg, 1, 64
end if

'PCVAC-6: Seller Paid Fin Asst Prevalent, neither Box Checked.  Check one Box
PCVAC6Msg = "** Seller Paid Fin Asst Prevalent, neither Box Checked.  Check one Box."
if not isChecked(1, 64) and not isChecked(1, 65) then
  AddRec PCVAC6Msg, 1, 64
end if

'PCVAC-8: Appraiser Name is "N/A". Provide Appraiser Name.
PCVAC8Msg = "** Appraiser Name is 'N/A'. Provide Appraiser Name."
apprName = GetText(1, 104)
if uCase(apprName) = "N/A" then
  AddRec PCVAC8Msg, 1, 104
end if

'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name.
PCVAC9Msg = "** 'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name."
if GetText(1, 104) = "" then
  AddRec PCVAC9Msg, 1, 104
end if

'PCVAC-10: Address of Property Appraised Number and Street is "N/A".  Provide Number and Street of Subject Property.
PCVAC10Msg = "** Address of Property Appraised Number and Street is 'N/A'.  Provide Number and Street of Subject Property."
addr = GetText(1, 5)
addr = Trim(UCase(addr))
if addr = "N/A" then
  AddRec PCVAC10Msg, 1, 5
end if

'PCVAC-11: Address of Property Appraised Number and Street is Blank.  Provide Number and Street of Subject Property.
PCVAC11Msg = "** Address of Property Appraised Number and Street is Blank.  Provide Number and Street of Subject Property."
if GetText(1, 5) = "" then
  AddRec PCVAC11Msg, 1, 5
end if

'PCVAC-12: Address of Property City, State, Zip is "N/A".  Provide City, State, Zip of Subject Property.
PCVAC12Msg = "** Address of Property City, State, Zip is 'N/A'.  Provide City, State, Zip of Subject Property." 
City = GetText(1, 6)
City = Trim(UCase(City))

State = GetText(1, 7)
State = Trim(UCase(State))

Zip = GetText(1, 8)
Zip = Trim(UCase(Zip))

if (City = "N/A")  then
  AddRec PCVAC12Msg, 1, 6
elseif (State = "N/A") then
  AddRec PCVAC12Msg, 1, 7
elseif (Zip = "N/A") then
  AddRec PCVAC12Msg, 1, 8
end if

'PCVAC-13: Appraised Value is "N/A".  Provide Appraised Value
PCVAC13Msg = "Appraised Value is 'N/A'.  Provide Appraised Value"

 
 '########################### END PCV RULES    ############################################  
  
End Sub

Sub DoCondo

   Require "No CONDO/Project Name Entered",1,75

  OnlyOneCheckOfThree 1, 79, 80, 81, "No Trend Selected for CONDO Total Comparable Sales", "Too Many Trends Selected for CONDO Total Comparable Sales"  
  OnlyOneCheckOfThree 1, 85, 86, 87, "No Trend Selected for CONDO Absorption Rate", "Too Many Trends Selected for CONDO Absorption Rates"  

   Require "No CONDO Comp Sales Prior 7-12 Months Entered",1,76
   Require "No CONDO Comp Sales Prior 4-6 Months Entered",1,77
   Require "No CONDO Comp Sales Prior -3 Months Entered",1,78
   Require "No CONDO Absorption Rate Prior 7-12 Months Entered",1,82
   Require "No CONDO Absorption Rate Prior 4-6 Months Entered",1,83
   Require "No CONDO Absorption Rate Current-3 Months Entered",1,84

   Require "No CONDO Active Listings 7-12 Months (use 'N/A' instead of blank)",1,88
   Require "No CONDO Active Listings 4-6 Months (use 'N/A' instead of blank)",1,89

   Require "No CONDO Months of Supply 7-12 Months (use 'N/A' instead of blank)",1,94
   Require "No CONDO Months of Supply 4-6 Months (use 'N/A' instead of blank)",1,95



   Require "No CONDO Active Comp Listings Current-3 Months Entered",1,90
   Require "No CONDO Months of Supply Current-3 Months Entered",1,96

  if (not isNegativeComment(1,88)) and (not isNegativeComment(1,89)) then
    OnlyOneCheckOfThree 1, 91, 92, 93, "No Trend Selected for CONDO Total Active Listings", "Too Many Trends Selected for CONDO Total Active Listings"  
  end if
  if (not isNegativeComment(1,94)) and (not isNegativeComment(1,95)) then
    OnlyOneCheckOfThree 1, 97, 98, 99, "No Trend Selected for CONDO Months of Supply", "Too Many Trends Selected for CONDO Months of Supply"  
  end if

  OnlyOneCheckOfTwo 1, 100, 101, "No Indicator Selected for REO being a CONDO Mkt Factor", "Too Many Indicators Selected for REO being a CONDO Mkt Factor"

   if GetCheck(1,100) then 
    Require "YES box is checked but Comments Field is Blank.  Provide Required comments", 1,102
    Require "No General CONDO Comments on the impact to the Subject", 1,103
  end if
  
'PCV Rules #10: The Overall Trend for Median Sale Price doesn't support the One-Unit Housing Trend for Property Values in the Neighborhood Section of the Report.  
'Reconcile conflicting Data.
OVERALL_ERROR = "** The Overall Trend for Median Sale Price doesn't support the One-Unit Housing Trend for Property Values in the Neighborhood Section of the Report."
if isChecked(1, 37) and not isChecked(1, 79) then
  AddRec OVERALL_ERROR, 1, 79
end if  
if isChecked(1, 38) and not isChecked(1, 80) then
  AddRec OVERALL_ERROR, 1, 80
end if  
if isChecked(1, 39) and not isChecked(1, 81) then
  AddRec OVERALL_ERROR, 1, 81
end if

 
End Sub