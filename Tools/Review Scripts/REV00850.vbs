'FM00850.vbs SUMMARY APPRAISAL REPORT Reviewer Script

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

  if GetCheck(1,70) then Require "No Comments on Foreclosures", 1,72

  Require "No Comments on Data Sources", 1,73
  Require "No Summary Neighborhood Comments", 1,74

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
    Require "No Comments on CONDO Foreclosures", 1,102
    Require "No General CONDO Comments on the impact to the Subject", 1,103
  end if
  
  
End Sub