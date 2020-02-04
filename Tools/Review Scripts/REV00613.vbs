'FM00613.vbs SUMMARY APPRAISAL REPORT Reviewer Script

Sub ReviewForm

AddTitle String(5, "=") + "FNMA 1004 " + IDSUBJECT + String(5, "=")

'  File numbers
   Require IDFilenum, 1, 2

' Intended Use
  OnlyOneCheckOfFive 1, 5, 6, 7, 8, 9, "No Intended Use Selected", "Too Many Intended Uses Checked"
  if isChecked(1, 9) Then Require "Other Intended Use Not Described", 1, 10
  
  if not isChecked(1, 11) and not isChecked(1,12) and not isChecked(1,13) and not isChecked(1,14) then Require "At least one datasource must be checked", 1, 11

' Other DataSource Description
  if isChecked(1, 14) Then Require "Other Data Source Not Described", 1, 15

' CLient, Borrower and Address Info
   Require "Client Name Not Entered", 1, 16
   Require "Borrower/Applicant Name Not Entered", 1, 18
   Require "Address Not Entered", 1, 20
   Require "City Not Entered", 1, 22
   Require "State Not Entered", 1, 23
   Require "Zip Code NOt Entered", 1, 24
   Require "County Not Entered", 1, 27

' Property Type
  OnlyOneCheckOfFive 1, 28, 29, 30, 31, 32, "No Property Type Selected", "Too Many Property Types Checked"
  if isChecked(1, 32) Then Require "Other Intended Use Not Described", 1, 33
    
' Market Area  and Comparables
  OnlyOneCheckOfThree 1, 34, 35, 36, "No Value Trend Selected", "Too Many Value Trends Selected"  
  OnlyOneCheckOfThree 1, 41, 42, 43, "No Marketing Time Range Selected", "Too Many Marketing Time Ranges Selected"  
  OnlyOneCheckOfTwo 1, 44, 45, "No H&B Use Indicator Selected", "Too Many H&B Use Indicators Selected"  
  if isChecked(1, 45) Then Require "Other H&B Use Not Described", 1, 46

' Price Range
  Require IDLowPrice, 1, 37
  Require IDHighPrice, 1, 38
  If hasText(1, 37) and hasText(1, 38) and (GetValue(1, 38) < GetValue(1, 37)) Then AddRec IDPriceCK, 1, 37
' Age Range
  Require IDLowAge, 1, 39
  Require IDHighAge, 1, 40
  If hasText(1, 39) and hasText(1, 40) and (GetValue(1, 40) < GetValue(1, 39)) Then AddRec IDAgeCK, 1, 39

  Require "Address in Grid", 1, 47
  Require "Address Line 2 in Grid", 1, 48
  Require "Zip Code in Grid", 1, 49
  Require "Data Sources in Grid", 1, 50

  OnlyOneCheckOfThree 1, 79, 80, 81, "No Comp 1 Comparative Selected", "Too Many Comp 1 Comparative Selected"  
  OnlyOneCheckOfThree 1, 99, 100, 101, "No Comp 2 Comparative Selected", "Too Many Comp 2 Comparative Selected"  
  OnlyOneCheckOfThree 1, 119, 120, 121, "No Comp 3 Comparative Selected", "Too Many Comp 3 Comparative Selected"  

  OnlyOneCheckOfTwo 1, 124, 125, "No Current Listing Indicator Selected", "Too Many Current Listing Indicators Selected"  
  Require "DataSource for Current Listing", 1, 126

  OnlyOneCheckOfTwo 1, 130, 131, "No 12 Month Listing Indicator Selected", "Too Many 12 Month Listing Indicators Selected"  
  Require "DataSource for 12 Month Listing History", 1, 132

  OnlyOneCheckOfTwo 1, 141, 142, "No 36 Month Transfer Indicator Selected", "Too Many 36 Month Transfer Indicators Selected"  
  Require "DataSource for 36 Month Transfer History", 1, 143

  Require "No Estimated Value Provided", 1, 160
  Require "No Value As-Of Date Provided", 1, 161
  OnlyOneCheckOfThree 1, 162, 163, 164, "No Inspection Type Selected", "Too Many Inspection Types Selected"  
  
  Require "No Appraiser Sign Date Provided", 2, 10
  Require "No Effective Date Provided", 2, 11

  if not hastext(2,12) and not hasText(2, 13) and not hasText(2,14) then Require "No Appraiser Name Provided", 2, 13

  Require "No Appraiser State Provided", 2, 16
  Require "No Appraiser License Expiration Date Provided", 2, 17

  Require "No Address in Certification Provided", 2, 18
  Require "No City, State and Zip in Certification Provided", 2, 19
  Require "No Appraised Value in Certification Provided", 2, 20
  Require "No Appraiser State Provided", 2, 16
  Require "No Client Name in Certificatino Provided", 2, 22


End Sub