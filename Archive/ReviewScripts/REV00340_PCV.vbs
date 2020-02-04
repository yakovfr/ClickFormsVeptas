'FM0340.vbs - 1004 URAR
' 12/04/2014: Add Fannie Mae rules
' 11/04/2014 Add more PCV rules:
'PCV Rules #25: Assignment Type is Refinance Transaction but Data has been added to the Contract section of the report.  Remove all information from the Contract section of the report.
'PCV Rules #26: Assignment Type is Refinance Transaction but "Did" or "Did Not" analyze contract Box is checked.  Remove check box and all other information from the Contract section of the report.
'PCV Rules #27: Assignment Type is Purchase Transaction but "Did Not" analyze the contract Box is checked.  Provide required comments: robust explanation for the steps taken and reason why the analysis was not ' ' 'performed.  If not an error, submit an over-ride request.
'PCV Rules #28: Assignment Type is Purchase but Date of Contract is more than 1 year prior to Inspection.   If correct submit an over-ride request.
'PCV Rules #29: Assignment Type is Purchase but Date of Contract Blank.  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.
'PCV Rules #30: Assignment Type is Purchase but Date of Contract "N/A".  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.
'PCV Rules #31: Assignment Type is Purchase and Contract Price is Above OMV.  Comments Required.  See Engagement Letter for specific requirements. 
'PCV Rules #33: Assignment Type is Purchase and Financial Assistance; "Yes" Box Checked but Comment Field is Blank.  Comment Required: Fully disclose total dollar amount and describe Financial Assistance (loan charges, sale concessions, gift or down payment assistance, etc.) to be paid by any party on behalf of the borrower.
'PCV Rules #35: Assignment Type is Purchase but Box checked "No" for Is the Seller the owner of pubic record, indicating that the seller is not the Owner of Public record.  Comment required providing steps taken and reason found for the discrepancy.  (Ex: "Transfer to GSA has not yet been recorded", "Seller's Interposal transfer to be recorded concurrent with Title Deed".) yes, but need to uppdate message displayed to user.
'PCV Rules #36: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Garage/Carport has Sq.Ft reported, but Garage/Carport Cost per Square Foot is Blank.  Provide Cost per Square Foot.
'PCV Rules #37: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Basement Area has Sq.Ft reported, but Other Area Cost per Square Foot is Blank.  Provide Basement Cost per Square Foot.
'PCV Rules #38: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Depreciated cost of Improvements is Blank.  Provide Depreciated Cost of Improvements.
'PCV Rules #39: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Adverse External "Yes" is Checked in the Site Section of the Report but External Depreciation is blank.  Provide amount of External Depreciation allocated to the Dwelling.   If recent Sales are lower than depreciated Cost to build New , consider adding for External Obsolescence due to Market conditions.
'PCV Rules #40:Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Functional Obsolescence is Blank.   Provide amount of Functional Depreciation, if any noted on the SCA Grid.
'PCV Rules #41:Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Actual Age is more than 5 but percent Physical Depreciation is blank.  Provide percent Physical Depreciation
'PCV Rules #42: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Percent Physical Depreciation is more than "0" but amount of Physical Depreciation is blank.  Provide amount of Physical Depreciation
'PCV Rules #43: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Dwelling Sq.Ft. doesn't match GLA in Improvement section of the report.  Provide consistent Dwelling Sq.Ft.
'PCV Rules #44: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Estimated Economic Life is Blank.  Hud and VA reports require the Estimate.
'PCV Rules #45: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Effective date of cost data field is blank.  Provide Date
'PCV Rules #46: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Improvement Section reports Garage or Carport but Sq.Ft. is not entered.  Provide Sq.Ft. of Garage or Carport.
'PCV Rules #47: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Indicated Value field is Blank.  Provide Indicated Value by Cost Approach
'PCV Rules #48: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Quality rating from Cost Service is blank.  Provide Cost Service quality rating.
'PCV Rules #49:Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Support for the Opinion of Site Value is blank.   Comments Required, provide support (Sales, Listings but analysis of market conditions, offsites, view, frontage or any factor affecting value of the site)
'PCV Rules #50: One with Accessory Unit box has been checked.  Appraiser MUST Inspect, measure, provide photos of the entire Accessory Unit.  Sales Comparison App requires analysis if its Appeal and Marketability.  Comparable Saless with Accessory Unit may be required, see Engagement Letter.
'PCV Rules #51: Additional Features field is "N/A".  Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state "No Additional Features"
'PCV Rules #52:Additional Features field is blank.  Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state "No Additional Features"
'PCV Rules #53:Assignment Type is Refi.  Check All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.
'PCV Rules #54: Assignment Type is Purchase.  Report All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.  If included in Contract of Sale, Value must be estimated and addressed in the Sales Comparable Approach.
'PCV Rules #55: Attic "Stairs", "Finished" and "Heated" boxes are all checked.  If attic is valued as additional living area, permits must be verified, comments to address Quality, conformity and market acceptance are needed.
'PCV Rules #56: Basement type, Multiple boxes checked.  If not an error Comment Required; Description of mixed basement types.  
'PCV Rules #57: Number of Bath(s) field does not match number of baths in Sales Comp Grid, Correction is required.
'PCV Rules #58: Number of Bath(s) field is not whole numbers to one decimal point.  Bath count must be in UAD format.  Full or 3/4 baths are each counted as one bath, only half baths are counted after the period.  1/4 baths are not counted.  Provide number of whole, and partial baths in required format.
'PCV Rules #59: Number of Bedrooms field does not match number of bedrooms in Sales Comp Grid, Correction is required.
'PCV Rules #60: Subject condition rating is C4 or C5 Significant repairs, deterioration that affects value needs to be Photographed. If there are Items that need significant repairs so that the value is affected; Photographs are required.
'PCV Rule #61: Does the Property Conform to the Neighborhood: No' is checked, Describe the condition(s) that affect conformance (ex: additions, func utility issues, Design(style), current condition, outbuildings etc.)  Photos may be needed.
'PCV Rules # 64: Additional Features:  Energy efficiency etc. "Typical" or "Average" are not accepted. Must be Specific.  Comments are required to Specifically address Energy Efficient, Green Building,  Unique Structural features etc.  If there are none, then Comment is needed that there are no additional or energy efficient features.  Sales Comparison Approach will need to accurately reflect the subject and all comparables in this regard.
'PCV Rules #65: Improvement Type  is Proposed.  See engagement letter for specific requirements.
'PCV Rules #66: Multiple Foundation Type boxes are checked.  Check one Box. If not an error Comment required including whether there are apparent additions.
'PCV Rules #67: Sq.Ft. GLA field does not match GLA in Sales Comp Grid, Correction is required.
'PCV Rules #68: Square Feet of Gross Living Area Above Grade is less than 400 sq. ft.   If correct submit an over-ride request.
'PCV Rules #69: Square Feet of Gross Living Area Above Grade is "0".  Provide GLA above grade, if none, submit over-ride request.
'PCV Rules #70: Cooling Type multiple boxes checked, Check one Box, or Comment required, explain multiple cooling types.
'PCV Rules #71: Heating type (FWA/HWBB/Radiant/Other) multiple boxes checked.  Check one Box or  Comment required, explain multiple heating types.
'PCV Rules #72: Physical deficiencies or adverse conditions "Yes" Box is checked, if there are Items that negatively affect Health and Safety, or need repairs such that the value is affected; Photographs are required.
'PCV Rules #73: General Description; Type is "Proposed", see engagement letter for specific requirements.
'PCV Rules #74: Year Built gives age Above the High Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built
'PCV Rules #75: Year Built gives age Below the Low Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built
'PCV Rules #77: One-Unit Housing Age, Low is above the Pred. Age.  Correct so that Pred. is within the range.
'PCV Rules #79: Built-Up under 25% is indicated but Location is not Rural.  Comment Required, support these findings.
'PCV Rules #81: Rapid Growth rate reported but Declining Property Values checked, Comment Required , support these findings.
'PCV Rules #82: Marketing Time is Over 6 Mos. but Property Values not Declining.  Comment required, support these findings.
'PCV Rules #83: Marketing Time is under 3 Mos. but Property Values Declining.  Comment required, support these findings.
'PCV Rules #84: Marketing Time is under 3 Mos. but Over Supply is checked.  Comment required, support these findings.
'PCV Rules #88: OMV is higher than Neighborhood Pred Price.  If significantly higher, Reconciliation Comments should describe the factors that cause subject value to be higher.  Is the subject on a larger lot,  in a favorable location, renovated or upgraded?
'PCV Rules #89: OMV is lower than Neighborhood Pred Price.  If significantly lower, Reconciliation Comments should describe the factors that cause subject value to be lower.  Is the subject in a poor location, in poor condition, an under improvement?
'PCV Rules #96: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased neither Box is checked.  
'PCV Rules #97: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased both boxes are checked. Check One Box.
'PCV Rules #98: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased "Yes" box is checked and Comment field is blank.  Provide required comments.
'PCV Rules #99: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion neither Box is checked.  Check one Box
'PCV Rules #100: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion both boxes are checked.  Check one Box
'PCV Rules #101: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion "Yes" box is checked and Comment field is blank.  Provide required comments.
'PCV Rules #102: PUD Information Section,  Developer/builder in control of the HOA is "Yes" but Data Source(s) is Blank.  Provide Data Source(s).
'PCV Rules #103: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Data Source(s) for Multi-Unit Dwellings is Blank.  Provide Data Source(s) for Multi-Unit Dwellings
'PCV Rules #104:PUD checked in Subject Section, but PUD Information Section, "Is Developer/builder in control of the HOA", Both Boxes checked.  Check one Box
'PCV Rules #105: PUD checked in Subject Section, but PUD Information Section, "Is Developer/builder in control of the HOA", Neither Box checked.  Check one Box
'PCV Rules #106: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Legal Name of Project is Blank.  Provide Legal Name of Project
'PCV Rules #107: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units neither Box is checked.  Check one Box
'PCV Rules #108: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units both boxes are checked.  Check one Box
'PCV Rules #109: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units "Yes" box is checked and Comment field is blank.  Provide required comments.
'PCV Rules #110: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number For Sale is Blank.  Provide Number For Sale
'PCV Rules #111: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Phases is Blank.  Provide Number of Phases
'PCV Rules #112:PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Units is Blank.  Provide Number of Units
'PCV Rules #113: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Rented is Blank.  Provide Number Rented
'PCV Rules #114: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Sold is Blank.  Provide Number Sold
'PCV Rules #115: PUD checked  in Subject Section, but PUD Information Section Unit type(s) (Detached/Attached) neither box is checked.
'PCV Rules #116: Reconciliation has "as-is" box checked, but Comments have been added to the narrative field below.  Correction required, no comments are allowed in the field when "as-is" box is checked.
'PCV Rules #118: OMV does not match the value indicated by the Sales Comparison Approach.   Correction required, if not an error submit an over-ride request.
'PCV Rules #119: Appraisal is made "Subject to Completion" box is checked, but "Existing" box is checked in the Improvements Section.  If construction underway is not New Construction, "Subject to... alterations" should be checked.  If New construction, correct Improvement Section box checked to "Proposed" or "Under Const".
'PCV Rules #120: Subject to Repairs or Alterations box has been checked but comments field is "N/A".  Comments required, describe conditions needing completion.
'PCV Rules #121: Subject to Required Inspections box has been checked.  Photos of conditioned items or deficiencies are required.
'PCV Rules #122: "AS-IS" box is not checked.  Review Engagement letter and Special instructions before submitting to PCV Murcor.   Photos of conditioned items or deficiencies cited are Required.





'  04/08/2014: Add more rules:
' Only do the check of date/price sale/transfer for the subject if subject of my research is checked
' Do the same check of date/price sale/transfer for the comp if comp of my research is checked
' 08/29/2013: Remove the Contract Date checking.
' 05/15/2013: Fix Divide by 0 issue.  Check if Subject GLA has value before doing the math.
' 04/26/2013: Add rule to check the consistency of quality condition in page 2 cell 27 and page 1 cell 219.
' 04/25/2013: For Amenities: Add an additional checking when these cell values: 182,184,186,188,190,192,194 is None treat them like EMPTY string do not enforce check box required rule. (Do the same checking for ' ' 'cell value 175 and 180)
' 04/01/2013: Add more rules
' Show warning if contract date is BEFORE effective date
' Show warning if settled date is BEFORE contract date
' 03/28/2013: Add more rules
' When a sale or listing is greater than or less than 20% of the subject's GLA, show warning.
' 02/04/2014: Fix the checking of garage count should use getvalue to check for > 0 instead of gettext to check for not empty when 0 is entered
' If purchase transaction type is checked, do the contract checking else skip
' 09/15/2014 Move check is Subject GLA in comps range to review grid
' 09/22/2014 Move check is Subject condition match any of comps to review grid
Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewContract
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewSalesSubject
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewIncomeApproach
  AddTitle ""
  ReviewPud
  AddTitle ""
End Sub


Sub ReviewSubject

AddTitle String(5, "=") + "FNMA 1004 " + IDSUBJECT + String(5, "=")

  ValidateStandardSubjectBlock 1, 3

End Sub


Sub ReviewContract

  AddTitle String(5, "=") + "FNMA 1004 " + ID_CONTRACT_BLOCK + String(5, "=")

   
'PCV Rules #25: Assignment Type is Refinance Transaction but Data has been added to the Contract section of the report.  Remove all information from the Contract section of the report.
  if isChecked(1, 33) then
    if (GetText(1, 44) <>"") or (GetText(1, 45) <> "") or (GetText(1, 48)<>"") or (GetText(1, 51)<>"") or isChecked(1, 46) or isChecked(1, 47) or isChecked(1, 49) or isChecked(1, 50) then
       AddRec "** Assignment Type is Refinance Transaction but Data has been added to the Contract section of the report.  Remove all information from the Contract section of the report.", 1, 44 	   
    end if
  end if 

 'PCV Rules #26: Assignment Type is Refinance Transaction but "Did" or "Did Not" analyze contract Box is checked.  Remove check box and all other information from the Contract section of the report.
  if isChecked(1, 33) then
     if isChecked(1, 41) or isChecked(1, 42) then
	   AddRec "** Assignment Type is Refinance Transaction but 'Did' or 'Did Not' analyze contract Box is checked.  Remove check box and all other information from the Contract section of the report.", 1, 41
	 end if
  end if  
 

 'PCV Rules #27: Assignment Type is Purchase Transaction but "Did Not" analyze the contract Box is checked.  Provide required comments: robust explanation for the steps taken and reason why the analysis was not performed.  If not an error, submit an over-ride request.
  if isChecked(1, 32) then
    if isChecked(1, 42) then
	  AddRec "** Assignment Type is Purchase Transaction but 'Did Not' analyze the contract Box is checked.  Provide required comments: robust explanation for the steps taken and reason why the analysis was not performed.  If not an error, submit an over-ride request.", 1, 42
	end if
  end if
 

 'PCV Rules #28: Assignment Type is Purchase but Date of Contract is more than 1 year prior to Inspection.   If correct submit an over-ride request.
  if isChecked(1, 32) then
    ContDate = GetText(1, 45)
	InspDate = GetText(2, 263)
	if isDate(ContDate) and isDate(InspDate) then
	  if (DateDiff("d", ContDate, InspDate) > 365) then
	    AddRec "** Assignment Type is Purchase but Date of Contract is more than 1 year prior to Inspection.   If correct submit an over-ride request.", 1, 45
	  end if
	end if
  end if
  
 'PCV Rules #29: Assignment Type is Purchase but Date of Contract Blank.  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.
 if isChecked(1, 32) then
  if GetText(1, 45) = "" then
    AddRec "** Assignment Type is Purchase but Date of Contract Blank.  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.", 1, 45
  end if
 end if
  
'PCV Rules #30: Assignment Type is Purchase but Date of Contract "N/A".  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.
 if isChecked(1, 32) then
  if GetText(1, 45) = "N/A" then
    AddRec "** Assignment Type is Purchase but Date of Contract 'N/A'.  Provide Date of Contract from review of the most recent revision or Addendum to the Sale Contract.", 1, 45
  end if
 end if

'PCV Rules #31: Assignment Type is Purchase and Contract Price is Above OMV.  Comments Required.  See Engagement Letter for specific requirements.
 if isChecked(1, 32) then
   cPrice = GetValue(1, 44)
   mPrice = GetValue(2, 262)
   if cPrice > mPrice then
     AddRec "Assignment Type is Purchase and Contract Price is Above OMV.  Comments Required.  See Engagement Letter for specific requirements.", 1, 44  
   end if
 end if
 
 
 
 
 
 'PCV Rules #33: Assignment Type is Purchase and Financial Assistance; "Yes" Box Checked but Comment Field is Blank.  Comment Required: Fully disclose total dollar amount and describe Financial Assistance (loan charges, sale concessions, gift or down payment assistance, etc.) to be paid by any party on behalf of the borrower.
 if isChecked(1, 32) and isChecked(1, 49) then
    comment = GetText(1, 51)
    if len(comment) = 0 then
	   AddRec "** Assignment Type is Purchase and Financial Assistance; 'Yes' Box Checked but Comment Field is Blank.  Comment Required: Fully disclose total dollar amount and describe Financial Assistance (loan 'charges, sale concessions, gift or down payment assistance, etc.) to be paid by any party on behalf of the borrower. ", 1, 51
	end if
 end if
 
 'PCV Rules #35: Assignment Type is Purchase but Box checked "No" for Is the Seller the owner of pubic record, indicating that the seller is not the Owner of Public record.  Comment required providing steps taken and reason found for the discrepancy.  (Ex: "Transfer to GSA has not yet been recorded", "Seller's Interposal transfer to be recorded concurrent with Title Deed".) yes, but need to uppdate message displayed to user.
  if isChecked(1, 32) and isChecked(1, 47)  then
    if getText(1, 51) = "" then
      AddRec "Assignment Type is Purchase but Box checked 'No' for Is the Seller the owner of pubic record, indicating that the seller is not the Owner of Public record.  Comment required providing steps taken and reason found for the discrepancy.  (Ex: 'Transfer to GSA has not yet been recorded', 'Seller''s Interposal transfer to be recorded concurrent with Title Deed'.) ", 1, 51
	end if 
  end if
 
  
  If not isChecked(1, 33) and not isChecked(1, 34) Then
    ValidateStandardContractBlock 1, 41
    'IsContractDateBEFOREEffectiveDate 1,45,2,263     'pass in contract date(1,45) and effective date(2,263)
    If hasText(1, 44) Then
      num = GetValue(1, 44)
      If num > GetValue(2, 262) Then
        AddRec IDCONTRACTFNMA1, 1, 44
      Else
        If num < GetValue(2, 262) Then
          AddRec IDCONTRACTFNMA2, 1, 44
        End If
      End If
    End If
  Else
    If hasText(1, 44) Then
      Require IDCONTRACTFNMA, 1, 32
    End If
  End If

  If GetCellUADError(1, 43) Then
    AddRec IDCONTRACTUADERROR, 1, 43
  End If

  'only warn if this is a purchase transaction
  If isChecked(1, 32) then
    OnlyOneCheckOfTwo 1, 49, 50, ID_CONTRACT_ASSISTANCE_NONE_CHECKED, ID_CONTRACT_ASSISTANCE_MANY_CHECKED
    CheckAndComment 1, 49, 51, ID_CONTRACT_ASSISTANCE_COMMENT_REQUIRED, ""
    If GetCellUADError(1, 51) Then
      AddRec ID_CONTRACT_ASSISTANCE_UADERROR, 1, 51
    End If
  End If	
'PCV Rules #54: Assignment Type is Purchase.  Report All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.  If included in Contract of Sale, Value must be estimated and addressed in the Sales Comparable Approach.
if isChecked(1, 32) then
'  if not isChecked(1, 206) and not isCHecked(1, 207) and not isChecked(1, 208) and not isChecked(1, 209) and not isChecked(1, 210) and not isChecked(1, 211) and not isChecked(1, 212) or ((GetValue(1, 44) = 0) and GetText(1, 45) = "") then
     AddRec "Assignment Type is Purchase.  Report All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.  If included in Contract of Sale, Value must be estimated and addressed in the Sales Comparable Approach.", 1, 51  
'  end if   
end if

'PCV Rules #79: Built-Up under 25% is indicated but Location is not Rural.  Comment Required, support these findings.
if isChecked(1, 57) and not isChecked(1, 54) then
  AddRec "Built-Up under 25% is indicated but Location is not Rural.  Comment Required, support these findings.", 1, 54
end if

'PCV Rules #81: Rapid Growth rate reported but Declining Property Values checked, Comment Required , support these findings.
if isChecked(1, 58) then
  if isChecked(1, 63) then
    AddRec "Property Values Declining but Rapid Growth Rate is reported, supporting comments needed.", 1, 63
  end if
end if

'PCV Rules #82: Marketing Time is Over 6 Mos. but Property Values not Declining.  Comment required, support these findings.
if isChecked(1, 69) and not isChecked(1, 63) then
  AddRec "Marketing Time is Over 6 Mos. but Property Values not Declining.  Comment required, support these findings.", 1, 63
end if

'PCV Rules #83: Marketing Time is under 3 Mos. but Property Values Declining.  Comment required, support these findings.
if isChecked(1, 67) then
  if isChecked(1, 63) then
    AddRec "Marketing Time is under 3 Mos. but Property Values Declining.  Comment required, support these findings.", 1, 63
  end if 
end if

'PCV Rules #84: Marketing Time is under 3 Mos. but Over Supply is checked.  Comment required, support these findings.
if isChecked(1, 67) and isChecked(1, 66) then
  AddRec "Marketing Time is under 3 Mos. but Over Supply is checked.  Comment required, support these findings.", 1, 66
end if





End Sub


Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 1004 " + IDNeigh + String(5, "=")

  ValidateStandardNeighborhoodBlock2005 1, 52

'PCV Rules #88: OMV is higher than Neighborhood Pred Price.  If significantly higher, Reconciliation Comments should describe the factors that cause subject value to be higher.  Is the subject on a larger lot,  in a favorable location, renovated or upgraded?
pValue = GetValue(1, 72)
oValue = GetValue(2, 262)
if oValue > pValue then
  AddRec "OMV is higher than Neighborhood Pred Price.  If significantly higher, Reconciliation Comments should describe the factors that cause subject value to be higher.  Is the subject on a larger lot,  in a favorable location, renovated or upgraded?", 2, 262
end if

'PCV Rules #89: OMV is lower than Neighborhood Pred Price.  If significantly lower, Reconciliation Comments should describe the factors that cause subject value to be lower.  Is the subject in a poor location, in poor condition, an under improvement?
pValue = GetValue(1, 72)
oValue = GetValue(2, 262)
if oValue < pValue  then
  AddRec "OMV is lower than Neighborhood Pred Price.  If significantly lower, Reconciliation Comments should describe the factors that cause subject value to be lower.  Is the subject in a poor location, in poor condition, an under improvement?", 2, 256
end if



  If hasText(2, 262) Then
    num = GetValue(2, 262) / 1000
      If num > GetValue(1, 71) Then
        AddRec IDTOBERANGE, 1,71
      End If
  End If

  If hasText(2, 262) Then
    num = GetValue(2, 262) / 1000
      If num < GetValue(1, 70) Then
        AddRec IDTOBERANGE, 1,70
      End If
  End If

  Require IDNEIGHBOUND, 1, 82
  Require IDNEIGHDES, 1, 83
  Require IDNEIGHCOND, 1, 84

End Sub



Sub ReviewSite

  AddTitle String(5, "=") + "FNMA 1004 " + IDSITE + String(5, "=")

  ValidateStandardSiteBlock 1, 85

  If hasText(1, 86) Then
    ValuesMustMatch 1, 86, 2, 22, IDSITECOMPARE
  End If
  If GetCellUADError(1, 86) Then
    AddRec IDSUBSITEUADERROR, 1, 86
  End If

  If hasText(1, 88) Then
    ValuesMustMatch 1, 88, 2, 23, IDVIEWCOMPARE
  End If
  If GetCellUADError(1, 88) Then
    AddRec IDSUBVIEWUADERROR, 1, 88
  End If

End Sub



Sub ReviewImprovements
Dim Text1, QTYdw, QTYga, QTYgd, QTYgbi, QTYcp, QtyTmp, ItemLoc

  AddTitle String(5, "=") + "FNMA 1004 " + IDIMPROV + String(5, "=")

  OnlyOneCheckOfTwo 1, 128, 129, INUNITS2, INUNITS2
  'PCV Rules #50: One with Accessory Unit box has been checked.  Appraiser MUST Inspect, measure, provide photos of the entire Accessory Unit.  Sales Comparison App requires analysis if its Appeal and Marketability.  Comparable Saless with Accessory Unit may be required, see Engagement Letter.
  if isChecked(1, 129) then
    AddRec "One with Accessory Unit box has been checked.  Appraiser MUST Inspect, measure, provide photos of the entire Accessory Unit.  Sales Comparison App requires analysis if its Appeal and Marketability.  Comparable Saless with Accessory Unit may be required, see Engagement Letter.", 1, 129
  end if
  
  Require IDSTORIES, 1, 130
  OnlyOneCheckOfThree 1, 131, 132, 133, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 1, 134, 135, 136, IDEXISTING2, IDEXISTING2
  'PCV Rules #65: Improvement Type  is Proposed.  See engagement letter for specific requirements.
  if isChecked(1, 135) then
    AddRec "Improvement Type  is Proposed.  See engagement letter for specific requirements.", 1, 135
  end if
  
  'PCV Rules #119: Appraisal is made "Subject to Completion" box is checked, but "Existing" box is checked in the Improvements Section.  If construction underway is not New Construction, "Subject to... alterations" should be checked.  If New construction, correct Improvement Section box checked to "Proposed" or "Under Const".
  if isChecked(2, 258) then
    if isChecked(1, 134) then
	  AddRec "** Appraisal is made 'Subject to Completion' box is checked, but 'Existing' box is checked in the Improvements Section.  If construction underway is not New Construction, 'Subject to... alterations' should be checked.  If New construction, correct Improvement Section box checked to 'Proposed' or 'Under Const'.", 1, 134
	end if
  end if  
  
  'PCV Rules #73: General Description; Type is "Proposed", see engagement letter for specific requirements.
  if isChecked(1, 135) then
    AddRec "** General Description; Type is 'Proposed', see engagement letter for specific requirements.", 1, 135
  end if
  
  Require IDDESIGN, 1, 137
  Require IDYRBLT, 1, 138
  Require IDEFFAGE, 1, 139
 
 'PCV Rules #74: Year Built gives age Above the High Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built
  yearBlt = GetValue(1, 138)
  age = Year(date) - yearBlt
  highAge = GetValue(1, 74)
  
  if age > highAge then
    AddRec "** Year Built gives age Above the High Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built", 1, 138
  end if

  
 'PCV Rules #75: Year Built gives age Below the Low Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built
  yearBlt = GetValue(1, 138)
  age = Year(date) - yearBlt
  lowAge = GetValue(1, 73)
  
  if age < lowAge then
    AddRec "** Year Built gives age Below the Low Nbhd. Age on Page 1.  Correct so that Range brackets subject Year Built", 1, 138
  end if
  
  'PCV Rules #77: One-Unit Housing Age, Low is above the Pred. Age.  Correct so that Pred. is within the range.
  lowAge = GetValue(1, 73)
  predAge = GetValue(1, 75)
  if lowAge > predAge then
    AddRec "** One-Unit Housing Age, Low is above the Pred. Age.  Correct so that Pred. is within the range.", 1, 73
  end if
  
  'PCV Rules #78: One-Unit Housing Age, High is below the Pred. Age.  Correct so that Pred. is within the range.
  highAge = GetValue(1, 74)
  predAge = GetValue(1, 75)
  if highAge < predAge then
    AddRec "** One-Unit Housing Age, High is below the Pred. Age.  Correct so that Pred. is within the range.", 1, 74
  end if
  
  'PCV #22: Is the Effective Age below the Neighborhood Low range
  GDSEFFECTAGE_AGELOW = "EFFECTIVE AGE IS BELOW INDICATED NEIGHBORHOOD LOW."
  If hasText(1,139) and hasText(1,73) Then  
    If GetValue(1,139) < GetValue(1,73) Then
		AddRec GDSEFFECTAGE_AGELOW, 1, 139
	End If
  End If
  
  'PCV #23: Is the Effective Age Above the Neighborhood High range
  GDSEFFECTAGE_AGEHIGH = "EFFECTIVE AGE IS ABOVE INDICATED NEIGHBORHOOD HIGH."
  If (hasText(1,139)) and (hasText(1,74)) Then  
	num = GetValue(1,139)
	hnum = GetValue(1,74)
	If hnum < num Then
      AddRec GDSEFFECTAGE_AGEHIGH, 1, 139
	End If
  End If
  


  OnlyOneCheckOfFour 1, 140, 141, 142, 143, IDFOUNDATIONNOCHK, IDFOUNDATIONCHK
  'PCV Rules #66: Multiple Foundation Type boxes are checked.  Check one Box. If not an error Comment required including whether there are apparent additions.
  if isChecked(1, 140) and isChecked(1, 141) then
    AddRec "Multiple Foundation Type boxes are checked.  Check one Box. If not an error Comment required including whether there are apparent additions.", 1, 140
  end if   
  
  If isChecked(1, 142) Then
   Require IDBASEAREA, 1, 144
   Require IDBASEFIN, 1, 145
  ' Require IDBASEOUTSIDE2, 1, 146
  ' Require IDSUMP2, 1, 147
  End If

 'PCV Rules #56: Basement type, Multiple boxes checked.  If not an error Comment Required; Description of mixed basement types.  
if isChecked(1, 142) and isChecked(1, 143) then
  AddRec "Basement type, Multiple boxes checked.  If not an error Comment Required; Description of mixed basement types.", 1, 142
end if

  
  If isChecked(1, 143) Then
   Require IDBASEAREA, 1, 144
   Require IDBASEFIN, 1, 145
  ' Require IDBASEOUTSIDE2, 1, 146
  ' Require IDSUMP2, 1, 147
  End If

  If hasText(1, 144) and (GetText(1, 144) <> "0") Then
   OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
   Require IDBASEFIN, 1, 145
  End If

  If hasText(1, 145) and (GetText(1, 145) <> "0") Then
   OnlyOneCheckOfTwo 1, 142, 143, IDBASEFULLPART, IDBASEFULLPART
   Require IDBASEAREA, 1, 144
  End If

  Require IDFOUNDATION2, 1, 152
  Require IDEXT, 1, 153
  Require IDROOFSUF, 1, 154
  Require IDGUTTER, 1, 155
  Require IDWINDOWTYPE, 1, 156
  Require IDFLOOR, 1, 159
  Require IDWALLS, 1, 160
  Require IDTRIM, 1, 161
  Require IDBATHFLOOR, 1, 162
  Require IDWAINSCOT, 1, 163

  ' Attic
  checked = GetCheck(1, 168) + GetCheck(1, 165) + GetCheck(1, 169) + GetCheck(1, 166) + GetCheck(1, 170) + GetCheck(1, 167)
  If isChecked(1, 164) Then    '  No Attic
    If checked > 0 Then AddRec IDATTICNONE, 1, 164
  Else
    If checked = 0 Then AddRec IDATTICNOCK, 1, 164
  End If

   
 'PCV Rules #71: Heating type (FWA/HWBB/Radiant/Other) multiple boxes checked.  Check one Box or  Comment required, explain multiple heating types.
  Heating = "Heating type (FWA/HWBB/Radiant/Other) multiple boxes checked.  Check one Box or  Comment required, explain multiple heating types."
  count = GetCheck(1, 171) + GetCheck(1, 172) + GetCheck(1, 173) + GetCheck(1, 174)
  if count > 1 then
    AddRec Heating, 1, 171
  end if

  
  '  No Doors
  OnlyOneCheckOfFour 1, 171, 172, 173, 174, IDHEATTYPE2, XXXXX
  If isChecked(1, 174) Then
    Require IDHEATOTHER, 1, 175
  Else
    If hasText(1,175) and uCase(GetText(1,175)) <> IDNONE then
      Require IDHEATOTHER2, 1, 175
    End If
  End If

  Require IDHEATFUEL, 1, 176
  'OnlyOneCheckOfThree 1, 177, 178, 179, IDCOOLCOND2, XXXXX
  
  'PCV Rules #70: Cooling Type multiple boxes checked, Check one Box, or Comment required, explain multiple cooling types.
  Cooling = "Cooling Type multiple boxes checked, Check one Box, or Comment required, explain multiple cooling types." 
  count = GetCheck(1, 177) + GetCheck(1, 178) + GetCheck(1, 179)
  if count > 1 then
    AddRec Cooling, 1, 177
  end if

  If isChecked(1, 179) Then
    Require IDCOOLOTHER, 1, 180
  Else
    If hasText(1,180) and uCase(GetText(1,180)) <> IDNONE then
      Require IDCOOLOTHER2, 1, 179
    End If
  End If

  OnlyOneCheckOfSeven 1, 181, 183, 185, 187, 189, 191, 193, IDAMENITIES, XXXXXX

  If isChecked(1, 181) Then
    If IsUAD Then
      If (not hasText(1, 182)) or (GetValue(1, 182) <= 0) Then
        AddRec IDFIREPLACE2, 1, 182
      End If
    Else
      Require IDFIREPLACE2, 1, 182
    End If
  Else
    If IsUAD and ((not hasText(1, 182)) or (GetValue(1, 182) <> 0)) then
      AddRec IDFIREPLACENONE, 1, 182
    End If
  End If

  If hasText(1, 182) Then
    If IsUAD Then
      If GetValue(1, 182) > 0 Then
        Require IDFIREPLACE2CK, 1, 181
      End If
    Else
      Require IDFIREPLACE2CK, 1, 181
    End If
  End If

  If isChecked(1, 183) Then
    If IsUAD Then
      If (not hasText(1, 184)) or (uCase(GetText(1, 184)) = IDNONE) Then
        AddRec IDPATDECK2, 1, 184
      End If
    Else
      Require IDPATDECK2, 1, 184
    End If
  Else
    If IsUAD and (uCase(GetText(1, 184)) <> IDNONE) then
      AddRec IDPATDECKNONE, 1, 184
    End If
  End If

  If hasText(1, 184) Then
    If IsUAD Then
      If uCase(GetText(1, 184)) <> IDNONE Then
        Require IDPATDECKCK, 1, 183
      End If
    Else
      Require IDPATDECKCK, 1, 183
    End If
  End If

  If isChecked(1, 185) Then
    If IsUAD Then
      If (not hasText(1, 186)) or (uCase(GetText(1, 186)) = IDNONE) Then
        AddRec IDPOOL2, 1, 186
      End If
    Else
      Require IDPOOL2, 1, 186
    End If
  Else
    If IsUAD and (uCase(GetText(1, 186)) <> IDNONE) then
      AddRec IDPOOLNONE, 1, 186
    End If
  End If

  If hasText(1, 186) Then
    If IsUAD Then
      If uCase(GetText(1, 186)) <> IDNONE Then
        Require IDPOOL2CK, 1, 185
      End If
    Else
      Require IDPOOL2CK, 1, 185
    End If
  End If

  If isChecked(1, 187) Then
    If IsUAD Then
      If (GetValue(1, 188) <= 0) Then
        AddRec IDSTOVES2, 1, 188
      End If
    Else
      Require IDSTOVES2, 1, 188
    End If
  Else
    If IsUAD and ((not hasText(1, 188)) or (GetValue(1, 188) <> 0)) then
      AddRec IDSTOVESNONE, 1, 188
    End If
  End If

  If hasText(1, 188) Then
    If IsUAD Then
      If GetValue(1, 188) > 0 Then
        Require IDSTOVES2CK, 1, 187
      End If
    Else
      Require IDSTOVES2CK, 1, 187
    End If
  End If

  If isChecked(1, 189) Then
    If IsUAD Then
      If (not hasText(1, 190)) or (uCase(GetText(1, 190)) = IDNONE) Then
        AddRec IDFENCE2, 1, 190
      End If
    Else
      Require IDFENCE2, 1, 190
    End If
  Else
    If IsUAD and (uCase(GetText(1, 190)) <> IDNONE) then
      AddRec IDFENCE2NONE, 1, 190
    End If
  End If

  If hasText(1, 190) Then
    If IsUAD Then
      If uCase(GetText(1, 190)) <> IDNONE Then
        Require IDFENCE2CK, 1, 189
      End If
    Else
      Require IDFENCE2CK, 1, 189
    End If
  End If

  If isChecked(1, 191) Then
    If IsUAD Then
      If (not hasText(1, 192)) or (uCase(GetText(1, 192)) = IDNONE) Then
        AddRec IDPORCH2, 1, 192
      End If
    Else
      Require IDPORCH2, 1, 192
    End If
  Else
    If IsUAD and (uCase(GetText(1, 192)) <> IDNONE) then
      AddRec IDPORCH2NONE, 1, 192
    End If
  End If

  If hasText(1, 192) Then
    If IsUAD Then
      If uCase(GetText(1, 192)) <> IDNONE Then
        Require IDPORCH2CK, 1, 191
      End If
    Else
      Require IDPORCH2CK, 1, 191
    End If
  End If

  If isChecked(1, 193) Then
    If IsUAD Then
      If (not hasText(1, 194)) or (uCase(GetText(1, 194)) = IDNONE) Then
        AddRec IDOTHER2, 1, 194
      End If
    Else
      Require IDOTHER2, 1, 194
    End If
  Else
    If IsUAD and (uCase(GetText(1, 194)) <> IDNONE) then
      AddRec IDOTHERNONE, 1, 194
    End If
  End If

  If hasText(1, 194) Then
    If IsUAD Then
      If uCase(GetText(1, 194)) <> IDNONE Then
        Require IDOTHER2CK, 1, 193
      End If
    Else
      Require IDOTHER2CK, 1, 193
    End If
  End If

  checked = GetTextCheck(1, 196) + GetTextCheck(1, 199) + GetTextCheck(1, 201) + GetTextCheck(1, 203) + GetTextCheck(1, 204) + GetTextCheck(1, 205)
  if isChecked(1, 195) then
    if checked > 0 then AddRec IDCARNONE,1,195
  else
    if checked = 0 then AddRec IDCARERROR,1,195
  end if

  If isChecked(1, 196) Then
    Require IDDRIVE, 1, 197
    Require IDDRIVE2, 1, 198
  End If

  If isChecked(1, 199) Then
    Require IDGARNUM, 1, 200
  End If

  If isChecked(1, 201) Then
    Require IDCARNUM, 1, 202
  End If

  If (hasText(1, 197) and (GetValue(1, 197) > 0)) or hasText(1, 198) Then
    Require IDDRIVE1, 1, 196
  End If

  If hasText(1, 200) and (GetValue(1, 200) > 0) Then
    Require IDGARNUM2, 1, 199
  End If

  If hasText(1, 202) and (GetValue(1, 202) > 0) Then
    Require IDCARNUM2, 1, 201
  End If

  If (not IsUAD) and (isChecked(1, 199) or isChecked(1, 201)) Then
    OnlyOneCheckOfThree 1, 203, 204, 205, IDCARERROR2, XXXXX
  End If

  If IsUAD and hasText(2, 37) Then
    QTYdw = 0
    QTYga = 0
    QTYgd = 0
    QTYgbi = 0
    QTYcp = 0
    Text1 = GetText(2, 37)
    'If (GetText(1, 200) <> "") Then  
    If (GetValue(1, 200) > 0) Then
      If isChecked(1, 203) Then
        ItemLoc = InStr(1, Text1, "ga")
        if (ItemLoc = 0) Then
          AddRec IDSUBATTGARAGEMISMATCH, 1, 203
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYga = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 204) Then
        ItemLoc = InStr(1, Text1, "gd")
        if (ItemLoc = 0) Then
          AddRec IDSUBDETGARAGEMISMATCH, 1, 204
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgd = CInt(QTYTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(1, 205) Then
        ItemLoc = InStr(1, Text1, "gbi")
        if (ItemLoc = 0) Then
          AddRec IDSUBBINGARAGEMISMATCH, 1, 205
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYgbi = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 3))
        End If
      End If
      If GetValue(1, 200) <> QTYga + QTYgd + QTYgbi Then
        AddRec IDSUBGARAGEQTY, 1, 200
      End If
    End If
    'If (GetText(1, 197) = "") Then  'should check for number not text
    If (GetValue(1, 197) > 0) Then  
      If isChecked(1, 196) and (InStr(1, Text1, GetText(1, 197) + "dw") = 0) Then
        AddRec IDSUBDRIVEWAYMISMATCH, 1, 197
      End If
    End If
    'If (GetText(1, 202) <> "") Then
    If (GetValue(1, 202) > 0) Then
      If isChecked(1, 201) and (InStr(1, Text1, GetText(1, 202) + "cp") = 0) Then
        AddRec IDSUBCARPORTMISMATCH, 1, 202
      End If
    End If
  End If

  OnlyOneCheckOfSeven 1, 206, 207, 208, 209, 210, 211, 212, IDAPPLIANCE, XXXXXX

 'PCV Rules #53:Assignment Type is Refi.  Check All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.
 if isChecked(1, 33) then
    AddRec "Assignment Type is Refi.  Check All Appliances that are affixed to the wall, ceiling, floor or cabinetry.  Any appliance not attached is considered removable  Personal Property.", 1, 206
 end if 
 
  If isChecked(1, 212) Then
    Require IDAPPOTHER, 1, 213
  End If

 'PCV #24: If 'Attic - Finished' is indicated, is the Attic in the Room List and GLA? 
  ATTFINISHED = "ATTIC 'FINISHED' IS INDICATED, BUT ROOM LIST AND GLA ARE BLANK"
  If isChecked(1,167) Then
	If (GetValue(1,214)=0) or (GetValue(1,215)=0) or (GetValue(1,216)=0) or (GetValue(1,217)=0) Then
      AddRec ATTFINISHED, 1,214
	End If
  End If
 
  Require IDROOMCNT, 1, 214
  If GetCellUADError(1, 214) Then
    AddRec IDSUBROOMSUADERROR, 1, 214
  End If

 Require IDBEDCNT, 1, 215
  If GetCellUADError(1, 215) Then
    AddRec IDSUBBEDUADERROR, 1, 215
  End If

  'PCV Rules #59: Number of Bedrooms field does not match number of bedrooms in Sales Comp Grid, Correction is required.
  bed1 = GetValue(1, 215)
  bed2 = GetValue(2, 29)
  if bed1 <> bed2 then
    AddRec "** Number of Bedrooms field does not match number of bedrooms in Sales Comp Grid, Correction is required.", 1, 215
  end if

'PCV Rules #57: Number of Bath(s) field does not match number of baths in Sales Comp Grid, Correction is required.
bath1 = GetValue(1, 216)
bath2 = GetValue(2, 30)
if bath1 <> bath2 then
  AddRec "** Number of Bath(s) field does not match number of baths in Sales Comp Grid, Correction is required.", 1, 216
end if

'PCV Rules #58: Number of Bath(s) field is not whole numbers to one decimal point.  Bath count must be in UAD format.  Full or 3/4 baths are each counted as one bath, only half baths are counted after the period.  1/4 baths are not counted.  Provide number of whole, and partial baths in required format.
bath1 = GetText(1, 216)
bath2 = GetText(2, 30)
Decimal1 = InStr(bath1,".") > 0
Decimal2 = Instr(bath2, ".") > 0
if not Decimal1 or not Decimal2 then
  AddRec "Number of Bath(s) field is not whole numbers to one decimal point.  Bath count must be in UAD format.  Full or 3/4 baths are each counted as one bath, only half baths are counted after the period.", 1, 216
end if

   
  Require IDBATHCNT, 1, 216
  If GetCellUADError(1, 216) Then
    AddRec IDSUBBATHSUADERROR, 1, 216
  End If
  Require IDGLA, 1, 217
  Require IDADD, 1, 218
 
'PCV Rules #51: Additional Features field is "N/A".  Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state "No Additional Features"
AdditionFeature = GetText(1, 218)
uAdditionFeature = UCase(AdditionFeature)
if InStr(uAdditionFeature, "N/A") > 0 then
  AddRec "** Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state 'No Additional Feature'.", 1, 218 
end if

'PCV Rules #52: Additional Features field is blank.  Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state "No Additional Features"
if GetText(1, 218) = "" then
 AddRec "** Additional Features field is blank.  Provide Additional features. Complete descriptions of Energy Efficient fixtures, Green built features and the like are required. If none are present, state 'No Additional Features'", 1, 218
end if

'PCV Rules #67: Sq.Ft. GLA field does not match GLA in Sales Comp Grid, Correction is required.
gla1 = GetValue(1, 217)
gla2 = GetValue(2, 31)
if gla1 <> gla2 then
  AddRec "** Sq.Ft. GLA field does not match GLA in Sales Comp Grid, Correction is required.", 1, 217
end if

'PCV Rules #68: Square Feet of Gross Living Area Above Grade is less than 400 sq. ft.   If correct submit an over-ride request.
gla1 = GetValue(1, 217)
gla2 = GetValue(2, 31)
'if (gla1 > 0) and (gla2 - gla1 <= 400) then
if gla1 <= 400 then
  AddRec "** Square Feet of Gross Living Area Above Grade is less than 400 sq. ft.  If correct submit an over-ride request.", 1, 217
end if

'PCV Rules #69: Square Feet of Gross Living Area Above Grade is "0".  Provide GLA above grade, if none, submit over-ride request.
gla1 = GetValue(1, 217)
if gla1 = 0 then
  AddRec "** Square Feet of Gross Living Area Above Grade is '0'.  Provide GLA above grade, if none, submit over-ride request.", 1, 217
end if






'PCV Rules #55: Attic "Stairs", "Finished" and "Heated" boxes are all checked.  If attic is valued as additional living area, permits must be verified, comments to address Quality, conformity and market acceptance are needed.
if isChecked(1, 167) and isChecked(1, 168) and isChecked(1, 170) then
  if GetText(1, 218) = "" then
    AddRec "Attic 'Stairs', 'Finished' and 'Heated' boxes are all checked.  If attic is valued as additional living area, permits must be verified, comments to address Quality, conformity and market acceptance are needed.", 1, 218
  end if
end if

'PCV Rules # 64: Additional Features:  Energy efficiency etc. "Typical" or "Average" are not accepted. Must be Specific.  Comments are required to Specifically address Energy Efficient, Green Building,  Unique Structural features etc.  If there are none, then Comment is needed that there are no additional or energy efficient features.  Sales Comparison Approach will need to accurately reflect the subject and all comparables in this regard.
AdditionFeature = GetText(1, 218)
if (InStr(AdditionFeature, "Typical") > 0) or (InStr(AdditionFeature, "Average") > 0) then
  Addrec "Additional Features:  Energy efficiency etc. 'Typical' or 'Average' are not accepted. Must be Specific.  Comments are required to Specifically address Energy Efficient, Green Building,  Unique Structural features etc.  If there are none, then Comment is needed that there are no additional or energy efficient features.  Sales Comparison Approach will need to accurately reflect the subject and all comparables in this regard.", 1, 218
end if


 


 Require IDCOND, 1, 219
  If GetCellUADError(1, 219) Then
    AddRec IDCONDUADERROR, 1, 219
  End If
'PCV Rules #60: Subject condition rating is C4 or C5 Significant repairs, deterioration that affects value needs to be Photographed. If there are Items that need significant repairs so that the value is affected; Photographs are required.
'if GetText(1, 219) = "" then
  cond = GetText(2, 27)
  if (InStr(Cond, "C4") > 0) or (InStr(Cond, "C5") > 0) or (InStr(Cond, "C6") > 0) then
    AddRec "Subject condition rating is C4 or C5 Significant repairs, deterioration that affects value needs to be Photographed. If there are Items that need significant repairs so that the value is affected; Photographs are required.", 1, 219
  end if
'end if


  OnlyOneCheckOfTwo 1, 220, 221, IDADVERSE2, XXXXX

  If isChecked(1, 220) Then
    Require IDADVERSE, 1, 222
  End If

 'PCV Rules #72: Physical deficiencies or adverse conditions "Yes" Box is checked, if there are Items that negatively affect Health and Safety, or need repairs such that the value is affected; Photographs are required.
  if isChecked(1, 220) then
    AddRec "Physical deficiencies or adverse conditions 'Yes' Box is checked, if there are Items that negatively affect Health and Safety, or need repairs such that the value is affected; Photographs are required.", 1, 220
  end if  
  
  OnlyOneCheckOfTwo 1, 223, 224, IDCONFORM2, XXXXX

  If isChecked(1, 224) Then
    Require IDCONFORM, 1, 225
  End If

'PCV Rule #61: Does the Property Conform to the Neighborhood: No' is checked, Describe the condition(s) that affect conformance (ex: additions, func utility issues, Design(style), current condition, outbuildings etc.)  Photos may be needed.
if isChecked(1, 224) then
  if GetText(1, 225) = "" then
    AddRec "Does the Property Conform to the Neighborhood: 'No' is checked, Describe the condition(s) that affect conformance (ex: additions, func utility issues, Design(style), current condition, outbuildings etc.)  Photos may be needed.", 1, 225
  end if
end if

  
  
  
End Sub


Sub ReviewSalesSubject
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, num, num2, num3, num4, num5, _
    text1, text2, text3, text4

  AddTitle String(5, "=") + "FNMA 1004 " + IDSALESAPP + String(5, "=")

  Require IDFILENUM, 2, 2
  Require IDPROPCOMP, 2, 5
  Require IDPROPCOMPFROM, 2, 6
  Require IDPROPCOMPTO, 2, 7
  Require IDSALECOMP, 2, 8
  Require IDSALECOMPFROM, 2, 9
  Require IDSALECOMPTO, 2, 10

    'Show warning if Settle date BEFORE contract date
  IsSettledDateBEFOREContractDate 2,56
  IsSettledDateBEFOREContractDate 2,116
  IsSettledDateBEFOREContractDate 2,176
  
  'Show error if Settle date is AFTER Effective date
  if not isUAD then
    IsSettledDateAFTEREffectiveDate 2, 19, 2, 263 'Subject  
  end if
  IsSettledDateAFTEREffectiveDate 2, 56, 2, 263  'Comp #1
  IsSettledDateAFTEREffectiveDate 2, 116, 2, 263 'Comp #2 
  IsSettledDateAFTEREffectiveDate 2, 176, 2, 263 'Comp #3 
  

'Is at least one comp the same condition of the subject?
If hasText(2,27) Then 
   If hasText(2,72) and strComp(GetText(2,27), GetText(2,72)) <> 0 Then
       If hasText(2,132)  and (strComp(GetText(2,27), GetText(2,132)) <> 0) Then
          If hasText(2,192)  and (strComp(GetText(2,27), GetText(2,192)) <> 0) Then
             AddRec AG_COND123, 2,27
          End If
       End If
   End If
End If

  'Show warning if Settle date BEFORE contract date
  IsSettledDateBEFOREContractDate 2,56
  IsSettledDateBEFOREContractDate 2,116
  IsSettledDateBEFOREContractDate 2,176


  Require IDSUBADD, 2, 11
  Require IDSUBCITY, 2, 12

  If hasText(2, 12) Then
    text1 = Replace(UCase(GetText(2, 12)), " ", "")
    text2 = Replace(UCase(GetText(1, 7)), " ", "")
    text3 = Replace(UCase(GetText(1, 8)), " ", "")
    text4 = Replace(UCase(GetText(1, 9)), " ", "")
    If not text1 = text2 + IDCOMMA + text3 + text4 Then
      AddRec IDADDMATCH, 2, 12
    End If
    If GetCellUADError(2, 11) or GetCellUADError(2, 12) Then
      AddRec IDADDRESSUADERROR, 2, 11
    End If
  End If

  If not isChecked(1, 33) Then
    Require IDSUBSALES, 2, 13
    Require IDSUBPRGLA, 2, 14
  End If
  If not IsUAD then
    Require IDSUBSOURCE, 2, 15
    Require IDSUBVERSOURCE, 2, 16
    Require IDSUBSF, 2, 17
    Require IDSUBCONC, 2, 18
    Require IDSUBDOS, 2, 19
  End If

  Require IDSUBLOC, 2, 20
  If GetCellUADError(2, 20) Then
    AddRec IDSUBLOCUADERROR, 2, 20
  End If
  Require IDSUBLEASEHOLD, 2, 21
  Require IDSUBSITE, 2, 22
  If GetCellUADError(2, 22) Then
    AddRec IDSUBSITEUADERROR, 2, 22
  End If
  Require IDSUBVIEW, 2, 23
  If GetCellUADError(2, 23) Then
    AddRec IDSUBVIEWUADERROR, 2, 23
  End If
  Require IDSUBDESIGN, 2, 24
  Require IDSUBQUAL, 2, 25
  If GetCellUADError(2, 25) Then
    AddRec IDSUBQUALUADERROR, 2, 25
  End If
  Require IDSUBAGE, 2, 26
  If GetCellUADError(2, 26) Then
    AddRec IDSUBAGEUADERROR, 2, 26
  End If
  
'PCV #28: Is the Actual Age below the Neighborhood Low range
SFHAGELOW = "**ACTUAL AGE IS BELOW INDICATED NEIGHBORHOOD LOW."
If hasText(2,26) then
   num = GetValue(2,26)
   If hasText(1,73) Then
      lnum = GetValue(1,73)
      If num < lnum Then
         AddRec SFHAGELOW,2,26
      End If
   End If
End If

'PCV #29: Is the Actual Age Above the Neighborhood High range
SFHAGEHIGH = "**ACTUAL AGE IS ABOVE INDICATED NEIGHBORHOOD HIGH."
If hasText(2,26) then
   num = GetValue(2,26)
   If hasText(1,74) Then
      hnum = GetValue(1,74)
      If num > hnum Then
         AddRec SFHAGEHIGH, 2,26
      End If
   End If
End If

 
  
  Require IDSUBCOND, 2, 27
  'Check Quality Condition between p1 cell 219 and p2 cell 27 make sure they are the same
  CheckQualityCondition 1, 219, 2, 27
  If GetCellUADError(2, 27) Then
    AddRec IDSUBCONDUADERROR, 2, 27
  End If
  Require IDSUBROOMS, 2, 28
  If GetCellUADError(2, 28) Then
    AddRec IDSUBROOMSUADERROR, 2, 28
  End If
  Require IDSUBBED, 2, 29
  If GetCellUADError(2, 29) Then
    AddRec IDSUBBEDUADERROR, 2, 29
  End If
  Require IDSUBBATHS, 2, 30
  If GetCellUADError(2, 30) Then
    AddRec IDSUBBATHSUADERROR, 2, 30
  End If
  Require IDSUBGLA, 2, 31
  Require IDSUBBASE, 2, 32
  If GetCellUADError(2, 32) Then
    AddRec IDSUBBASEUADERROR, 2, 32
  End If
  If not ((GetText(2, 32) = "0sf") and (GetText(2, 32) = "0sqm")) Then
    Require IDSUBBASEPER, 2, 33
  End IF
  If GetCellUADError(2, 33) Then
    AddRec IDSUBBASEPERUADERROR, 2, 33
  End If
  Require IDSUBFUNC, 2, 34
  Require IDSUBHEAT, 2, 35
  Require IDSUBENERGY, 2, 36
  If not IsEnergyEfficientOK(2, 36) then
    AddRec IDSUBENERGYBAD, 2, 36
  End If
  Require IDSUBGARAGE, 2, 37
  If IsUAD and hasText(2, 37) Then
    Text1 = GetText(2, 37)
    num = InStr(1, Text1, "ga")
    num2 = InStr(1, Text1, "gd")
    num3 = InStr(1, Text1, "gbi")
    num4 = InStr(1, Text1, "cp")
    num5 = InStr(1, Text1, "dw")
    If not NumOrderIsOK(num, num2, num3, num4, num5) Then
      AddRec IDSUBRESIDFORMAT, 2, 37
    End If
  End If
  Require IDSUBPORCH, 2, 38

  
  GridIndex = 0
  For FldCntr = 45 to 165 Step 60
    GridIndex = GridIndex + 1
    If (GetText(2, (FldCntr)) <> "") or (GetText(2, (FldCntr+1)) <> "") then
      Require FormCompNumErrStr(IDCOMP1ADD, 0, GridIndex), 2, (FldCntr)
      Require FormCompNumErrStr(IDCOMP1ADD2, 0, GridIndex), 2, (FldCntr+1)
      If GetCellUADError(2, (FldCntr)) or GetCellUADError(2, (FldCntr+1)) Then
        AddRec FormCompNumErrStr(IDCOMP1ADDRUADERROR, 0, GridIndex), 2, (FldCntr)
      End If
      Require FormCompNumErrStr(IDCOMP1PROX, 0, GridIndex), 2, (FldCntr+2)
      Require FormCompNumErrStr(IDCOMP1SALES, 0, GridIndex), 2, (FldCntr+3)

      ' Check comp one-unit housing & comp sales ranges
      If hasText(2, (FldCntr+3)) Then
        num2 = GetValue(2, (FldCntr+3))
        num = num2 / 1000
        If num < GetValue(1, 70) Then
          AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 2, (FldCntr+3)
        Else
          If num > GetValue(1, 71) Then
            AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 2, (FldCntr+3)
          End If
        End If
        If num2 < GetValue(2,9) Then
          AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 2, (FldCntr+3)
        Else
          If num2 > GetValue(2,10) Then
            AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 2, (FldCntr+3)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1PRGLA, 0, GridIndex), 2, (FldCntr+3)
      Require FormCompNumErrStr(IDCOMP1SOURCE, 0, GridIndex), 2, (FldCntr+5)
      If GetCellUADError(2, (FldCntr+5)) Then
        AddRec FormCompNumErrStr(IDCOMP1DATASRCUADERROR, 0, GridIndex), 2, (FldCntr+5)
      End If
      Require FormCompNumErrStr(IDCOMP1VER, 0, GridIndex), 2, (FldCntr+6)
      Require FormCompNumErrStr(IDCOMP1SF, 0, GridIndex), 2, (FldCntr+7)
      If GetCellUADError(2, (FldCntr+7)) Then
        AddRec FormCompNumErrStr(IDCOMP1SFUADERROR, 0, GridIndex), 2, (FldCntr+7)
      End If
      Require FormCompNumErrStr(IDCOMP1CONC, 0, GridIndex), 2, (FldCntr+9)
      If GetCellUADError(2, (FldCntr+9)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONCUADERROR, 0, GridIndex), 2, (FldCntr+9)
      End If
      Require FormCompNumErrStr(IDCOMP1DOS, 0, GridIndex), 2, (FldCntr+11)
      If GetCellUADError(2, (FldCntr+11)) Then
        AddRec FormCompNumErrStr(IDCOMP1DOSUADERROR, 0, GridIndex), 2, (FldCntr+11)
      End If
      Require FormCompNumErrStr(IDCOMP1LOC, 0, GridIndex), 2, (FldCntr+13)
      If GetCellUADError(2, (FldCntr+13)) Then
        AddRec FormCompNumErrStr(IDCOMP1LOCUADERROR, 0, GridIndex), 2, (FldCntr+13)
      End If
      Require FormCompNumErrStr(IDCOMP1LEASEHOLD, 0, GridIndex), 2, (FldCntr+15)
      
      Require FormCompNumErrStr(IDCOMP1SITE, 0, GridIndex), 2, (FldCntr+17)
      ' Check if the comp's Site Area is 20% more than the subject Site Area
      If hasText(2, 22) and hasText(2, (FldCntr+17)) then  'we have subject & comp SiteArea
        cSiteArea = GetValue(2, (FldCntr+17))
        sSiteArea = GetValue(2, 22)

        If sSiteArea > 0 then
          num = (cSiteArea - sSiteArea)/sSiteArea
          If (Abs(num) > 0.20) and (cSiteArea > sSiteArea)then
            AddRec FormCompNumErrStr(IDCOMPSA20RANGE1G, 0, GridIndex), 2, (FldCntr+17)
          End If
          If (ABs(num) > 0.20) and (cSiteArea < sSiteArea) then
            AddRec FormCompNumErrStr(IDCOMPSA20RANGE1L, 0, GridIndex), 2, (FldCntr+17)
          End If
        End If
      End If
      
      Require FormCompNumErrStr(IDCOMP1VIEW, 0, GridIndex), 2, (FldCntr+19)
      If GetCellUADError(2, (FldCntr+19)) Then
        AddRec FormCompNumErrStr(IDCOMP1VIEWUADERROR, 0, GridIndex), 2, (FldCntr+19)
      End If
      Require FormCompNumErrStr(IDCOMP1DESIGN, 0, GridIndex), 2, (FldCntr+21)
      Require FormCompNumErrStr(IDCOMP1QUAL, 0, GridIndex), 2, (FldCntr+23)
      If GetCellUADError(2, (FldCntr+23)) Then
        AddRec FormCompNumErrStr(IDCOMP1QUALUADERROR, 0, GridIndex), 2, (FldCntr+23)
      End If
      Require FormCompNumErrStr(IDCOMP1AGE, 0, GridIndex), 2, (FldCntr+25)
      If GetCellUADError(2, (FldCntr+25)) Then
        AddRec FormCompNumErrStr(IDCOMP1AGEUADERROR, 0, GridIndex), 2, (FldCntr+25)
      End If
      Require FormCompNumErrStr(IDCOMP1COND, 0, GridIndex), 2, (FldCntr+27)
      If GetCellUADError(2, (FldCntr+27)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONDUADERROR, 0, GridIndex), 2, (FldCntr+27)
      End If
      Require FormCompNumErrStr(IDCOMP1ROOMS, 0, GridIndex), 2, (FldCntr+30)
      If GetCellUADError(2, (FldCntr+30)) Then
        AddRec FormCompNumErrStr(IDCOMP1ROOMSUADERROR, 0, GridIndex), 2, (FldCntr+30)
      End If
      Require FormCompNumErrStr(IDCOMP1BED, 0, GridIndex), 2, (FldCntr+31)
      If GetCellUADError(2, (FldCntr+31)) Then
        AddRec FormCompNumErrStr(IDCOMP1BEDUADERROR, 0, GridIndex), 2, (FldCntr+31)
      End If
      Require FormCompNumErrStr(IDCOMP1BATHS, 0, GridIndex), 2, (FldCntr+32)
      If GetCellUADError(2, (FldCntr+32)) Then
        AddRec FormCompNumErrStr(IDCOMP1BATHSUADERROR, 0, GridIndex), 2, (FldCntr+32)
      End If

      Require FormCompNumErrStr(IDCOMP1GLA, 0, GridIndex), 2, (FldCntr+34)
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(2, 31) and hasText(2, (FldCntr+34)) then  'we have subject & comp GLA
        cGLA = GetValue(2, (FldCntr+34))
        sGLA = GetValue(2, 31)

        If sGLA > 0 then
          num = (cGLA - sGLA)/sGLA
          If (Abs(num) > 0.20) and (cGLA > sGLA)then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1G, 0, GridIndex), 2, (FldCntr+34)
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1L, 0, GridIndex), 2, (FldCntr+34)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1BASE, 0, GridIndex), 2, (FldCntr+36)
      If GetCellUADError(2, (FldCntr+36)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEUADERROR, 0, GridIndex), 2, (FldCntr+36)
      End If

      If not ((GetText(2, (FldCntr+36)) = "0sf") or (GetText(2, (FldCntr+36)) = "0sqm")) Then
        Require FormCompNumErrStr(IDCOMP1BASEPER, 0, GridIndex), 2, (FldCntr+38)
      End If
      If GetCellUADError(2, (FldCntr+38)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEPERUADERROR, 0, GridIndex), 2, (FldCntr+38)
      End If
      Require FormCompNumErrStr(IDCOMP1FUNC, 0, GridIndex), 2, (FldCntr+40)
      Require FormCompNumErrStr(IDCOMP1HEAT, 0, GridIndex), 2, (FldCntr+42)
      Require FormCompNumErrStr(IDCOMP1ENERGY, 0, GridIndex), 2, (FldCntr+44)
      If not IsEnergyEfficientOK(2, (FldCntr+44)) then
        AddRec FormCompNumErrStr(IDCOMP1ENERGYBAD, 0, GridIndex), 2, (FldCntr+44)
      End If
      Require FormCompNumErrStr(IDCOMP1GARAGE, 0, GridIndex), 2, (FldCntr+46)
      If IsUAD and hasText(2, (FldCntr+46)) Then
        Text1 = GetText(2, (FldCntr+46))
        num = InStr(1, Text1, "ga")
        num2 = InStr(1, Text1, "gd")
        num3 = InStr(1, Text1, "gbi")
        num4 = InStr(1, Text1, "cp")
        num5 = InStr(1, Text1, "dw")
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDCOMP1RESIDFORMAT, 0, GridIndex), 2, (FldCntr+46)
        End If
      End If
      Require FormCompNumErrStr(IDCOMP1PORCH, 0, GridIndex), 2, (FldCntr+48)

 
	  
      If hasText(2, (FldCntr+59)) Then
        num = GetValue(2, (FldCntr+59)) / 1000
          If num < GetValue(1, 70) Then
            AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 2, (FldCntr+59)
          Else
            If num > GetValue(1, 71) Then
              AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 2, (FldCntr+59)
            End If
          End If
      End If
    End If
  Next

  
  'PCV #28: MARKET VALUE: Value is not within the Sales Price of the Comparables.
IDTOBERANGE2 = "MARKET VALUE: Value is not within the Sales Price of the Comparables."
IIDTOBERANGE3 = "MARKET VALUE: The indicated Value by Sales Comparison Approach is outside the range of your Sales Comparables."
If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
'        AddRec IDTOBERANGE2, 2, 48
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
 '       AddRec IDTOBERANGE2, 2, 108
      End If
    End If
End If

'PCV #30: The range of Indicated Values is greater than 20% suggesting either inadequate choice of comparables or analysis on the market grid.
If hasText(2,252) and (hasText(2,48) or hasText(2,108) or hasText(2,168)) Then
   Sale1 = GetValue(2,48) * 0.2 + GetValue(2,48)
   Sale2 = GetValue(2,108) * 0.2 + GetValue(2,108)
   Sale3 = GetValue(2, 168) * 0.2 + GetValue(2,168)
   SubIndValue = GetValue(2,252)
  is_exceed = false
  If (GetValue(2,48) > 0)  and (SubIndValue > Sale1) Then
       is_exceed = true
  End If
  If (GetValue(2,108) > 0) and (SubIndValue > Sale2) Then
       is_exceed = true
  End If
  If (GetValue(2,168) > 0) and (SubIndValue > Sale3) Then
       is_exceed = true
  End If
  If is_exceed Then
    AddRec SCMINDVALUE, 2, 252 
  End If 
End If


If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        'AddRec IDTOBERANGE2, 2, 168
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        'AddRec IDTOBERANGE2, 2, 48
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        'AddRec IDTOBERANGE2, 2, 108
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 48)
  num3 = GetValue(2, 108)
  num4 = GetValue(2, 168)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        'AddRec IDTOBERANGE2, 2, 168
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        'AddRec IDTOBERANGE3, 2, 104
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        'AddRec IDTOBERANGE3, 2, 164
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        'AddRec IDTOBERANGE3, 2, 224
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        'AddRec IDTOBERANGE3, 2, 104
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        'AddRec IDTOBERANGE3, 2, 164
      End If
    End If
End If

If hasText(2, 262) Then
  num = GetValue(2, 262)
  num2 = GetValue(2, 104)
  num3 = GetValue(2, 164)
  num4 = GetValue(2, 224)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        'AddRec IDTOBERANGE3, 2, 224
      End If
    End If
End If



  If hasText(2, 262) Then
    num = GetValue(2, 262)
    num2 = GetValue(2, 48)
    num3 = GetValue(2, 108)
    num4 = GetValue(2, 168)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        'AddRec IDTOBERANGE2, 2, 48
      End If
    End If
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        'AddRec IDTOBERANGE2, 2, 48
      End If
    End If
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        'AddRec IDTOBERANGE2, 2, 108
      End If
    End If
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        'AddRec IDTOBERANGE2, 2, 108
      End If
    End If
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        'AddRec IDTOBERANGE2, 2, 168
      End If
    End If
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        'AddRec IDTOBERANGE2, 2, 168
      End If
    End If

    num2 = GetValue(2, 104)
    num3 = GetValue(2, 164)
    num4 = GetValue(2, 224)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        'AddRec IDTOBERANGE3, 2, 104
      End If
    End If
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        'AddRec IDTOBERANGE3, 2, 104
      End If
    End If
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        'AddRec IDTOBERANGE3, 2, 164
      End If
    End If
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        'AddRec IDTOBERANGE3, 2, 164
      End If
    End If
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        'AddRec IDTOBERANGE3, 2, 224
      End If
    End If
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        'AddRec IDTOBERANGE3, 2, 224
      End If
    End If
  End If

  
  OnlyOneCheckOfTwo 2, 225, 226, IDRESEARCH2, XXXXX

  If isChecked(2, 226) Then
    Require IDRESEARCH, 2, 227
  End If

  OnlyOneCheckOfTwo 2, 228, 229, IDRESEARCHSUB2, XXXXX
  Require IDRESEARCHSUB3, 2, 230
  OnlyOneCheckOfTwo 2, 231, 232, IDRESEARCHCOMP2, XXXXX
  Require IDRESEARCHCOMP3, 2, 233
  'Only check if I did check box is checked for the subject
  If isChecked(2, 228)  Then	 
    If Not hasText(2, 234) Then
      AddRec IDDATEPSTSUB, 2, 234
    Else
      If IsUAD and (not IsDateOK(2, 234)) then
        AddRec IDDATEPSTFMTSUBJ, 2, 234
      End If
    End If
    If GetCellUADError(2, 234) Then
      AddRec IDDATEPSTSUBUADERROR, 2, 234
    End If
  End if 'end of isChecked
  
  'Check for the subject
  'Only check if I did check box is checked for the Subject
  If isChecked(2, 228)  Then	 
    Require IDPRICEPSTSUB, 2, 235
    Require IDDATASOURCESUB, 2, 236
    Require IDDATASOURCEDATESUB, 2, 237
    If GetCellUADError(2, 237) Then
      AddRec IDDATASRCDATESUBUADERROR, 2, 237
    End If
  End If

  
  'Check for the comps only
  GridIndex = 0
  CompAddrList = Array(45,105,165)
  For FldCntr = 238 to 246 Step 4
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    If (GetText(2, CompAddrSeq) <> "") or (GetText(2, (CompAddrSeq+1)) <> "") then
      'Only check if I did check box is checked
	  If IsChecked(2, 231)  Then 'this is for the comp
	    Require FormCompNumErrStr(IDDATEPSTCOMP1, 0, GridIndex), 2, (FldCntr)
  	    If GetCellUADError(2, (FldCntr)) Then
          AddRec FormCompNumErrStr(IDDATEPSTCOMP1UADERROR, 0, GridIndex), 2, (FldCntr)
        End If
	    Require FormCompNumErrStr(IDPRICEPSTCOMP1, 0, GridIndex), 2, (FldCntr+1)
        Require FormCompNumErrStr(IDDATASOURCECOMP1, 0, GridIndex), 2, (FldCntr+2)
        Require FormCompNumErrStr(IDDATASOURCEDATECOMP1, 0, GridIndex), 2, (FldCntr+3)
 
   	    If GetCellUADError(2, (FldCntr+3)) Then
          AddRec FormCompNumErrStr(IDDATASRCDATECOMP1UADERROR, 0, GridIndex), 2, (FldCntr+3)
        End If
	  End If 
    End If
  Next

  Require IDANALYSIS2, 2, 250
  Require IDSUMMARYSALES, 2, 251

  If Not hasText(2, 252) Then
    AddRec IDTOBE, 2, 252
  End If

End Sub


Sub ReviewReconciliation
  AddTitle String(5, "=") + "FNMA 1004 " + IDRECON + String(5, "=")

  If Not hasText(2, 253) Then
    AddRec IDTOBE, 2, 253
  End If
  
  'PCV Rules #118: OMV does not match the value indicated by the Sales Comparison Approach.   Correction required, if not an error submit an over-ride request.
  if GetValue(2, 253) <> GetValue(2, 262) then
	AddRec "** OMV does not match the value indicated by the Sales Comparison Approach.   Correction required, if not an error submit an over-ride request.", 2, 253
  end if   

  Require IDCOSTVALUEREC, 2, 254

  If isChecked(1, 21) Then
    Require IDINCOMEVALUE, 2, 255
  End If

  OnlyOneCheckOfFour 2, 257, 258, 259, 260, IDSTATUSNOCHK, IDSTATUSCHK
  
  'PCV Rules #116:  Reconciliation has "as-is" box checked, but Comments have been added to the narrative field below.  Correction required, no comments are allowed in the field when "as-is" box is checked.
  if isChecked(2, 257) then
    if GetText(2, 261)<>"" then
	  AddRec "Reconciliation has 'as-is' box checked, but Comments have been added to the narrative field below.  Correction required, no comments are allowed in the field when 'as-is' box is checked.", 2, 261
	end if
  end if

  'PCV Rules #122: "AS-IS" box is not checked.  Review Engagement letter and Special instructions before submitting to PCV Murcor.   Photos of conditioned items or deficiencies cited are Required.
  if not isChecked(2, 257) then
    AddRec "AS-IS box is not checked.  Review Engagement letter and Special instructions before submitting to PCV Murcor.   Photos of conditioned items or deficiencies cited are Required.", 2, 257
  end if

  
  'PCV Rules #120: Subject to Repairs or Alterations box has been checked but comments field is "N/A".  Comments required, describe conditions needing completion.
  If isChecked(2, 259) Then
    comment = GetText(2, 261)
	if inStr(UCase(comment), "N/A") <> 0 or comment = "" then
	  AddRec "** Subject to Repairs or Alterations box has been checked but comments field is 'N/A'.  Comments required, describe conditions needing completion.", 2, 261
    end If
  end if
 'Require IDCONDCOMM, 2, 261
 
 'PCV Rules #121: Subject to Required Inspections box has been checked.  Photos of conditioned items or deficiencies are required.
  If isChecked(2, 260) Then
    'Require IDCONDCOMM, 2, 261
    AddRec "ASubject to Required Inspections box has been checked.  Photos of conditioned items or deficiencies are required.", 2, 261 
  End If

  If Not hasText(2, 262) Then
    AddRec IDTOBE, 2, 262
  End If

  
'PCV #31: Make sure Est. Mkt. Value is bracketed by unadjusted comp. sale prices.
gSub = GetValue(2,262)
gComp1 = GetValue(2,48)
gComp2 = GetValue(2,108)
gComp3 = GetValue(2,168)

min = minof3(gComp1,gComp2,gComp3)
max = maxof3(gComp1,gComp2,gComp3)

'PCV #32: is subject in the range of min and max?
RECESTMKTVALUE = "MARKET VALUE OF THE SUBJECT IS NOT IN THE MARKET VALUES RANGE OF THE COMPS"
If (gSub < min) or (gSub > max) Then  'out of range
  AddRec RECESTMKTVALUE, 2, 262
End If
   

  Require IDASOF, 2, 263

End Sub


Sub ReviewCostApproach

  AddTitle String(5, "=") + "FNMA 1004 " + IDCOSTAPP + String(5, "=")

  Require IDOPINCOST, 3, 6 
  OnlyOneCheckOfTwo 3, 7, 8, IDREPCOST, XXXXX
  Require IDSOURCECOST, 3, 9  
  Require IDQUALITYCOST, 3, 10  
  Require IDEFFDATECOST, 3, 11
  Require IDCOMMCOST, 3, 12
  'PCV #33: Are the Cost Approach Comments completed?
  CSTCOMMENTS_1 = "COST APPROACH COMMENTS : " & REQUIRED_DATA_MISSING
  If not hasText(3,12) Then
     AddRec CSTCOMMENTS_1, 3, 12
  End If

  Require IDECONLIFECOST, 3, 13  
  'PCV #34: In the cost approach, there is a field called Estimated Remaining Economic Life. That number should be 30 years or more.
  ESTREMECONLIFE = "IN YOUR COST APPROACH, THE ESTIMATED ECONOMIC LIFE FOR THE SUBJECT IS ESTIMATED TO BE THAN 30 YRS. WHICH MAY INDICATE SEVERE"
  If hasText(3, 13) Then
	num = GetValue(3, 13)
	If num < 30 Then
      AddRec ESTREMECONLIFE, 3, 13
	End If
  End If

  Require IDOPINIONCOST, 3, 14
  Require IDDWELLSQFTCOST, 3, 15 
  Require IDDWELLAMTCOST, 3, 16
  Require IDDWELLAMTCALCCOST, 3, 17 
  'PCV #35: If there's basement square footage, is it in the Cost Approach?
  CSTOTHERSF_BLANK = "BASEMENT SQUARE FOOTAGE IS NOT USED IN COST APPROACH."
  If GetValue(1,144) > 0  Then
     Require CSTOTHERSF_BLANK,3,19
  End If  

  Require IDGARCOSTSQFTCOST, 3, 24
  Require IDGARAMTCOST, 3, 25
  Require IDGARAMTCALCCOST, 3, 26 
  Require IDTECNCOST, 3, 27
  Require IDPHYSICALCOST, 3, 28 
  Require IDFUNCCOST, 3, 30
  Require IDEXTCOST, 3, 32
  Require IDDEPPHYSICALCOST, 3, 29 
  Require IDDEPFUNCOST, 3, 31
  Require IDDEPEXTCOST, 3, 33
  Require IDDEPTOTALCOST, 3, 34
  Require IDDEPCOSTOFIMPCOST, 3, 35
  Require IDASISCOST, 3, 36
  'PCV #36: If Leasehold is checked, is the Site Value leasehold?
  SUBPRA_LEASEHOLD = "LEASEHOLD' RIGHTS ARE INDICATED. SITE VALUE SHOULD BE LEASEHOLD ONLY."
  If isChecked(1,29) and hasText(3, 36)  Then
    AddRec SUBPRA_Leasehold, 3, 36
  End If
  
  Require IDINDVALCOST, 3, 37

  If hasText(3, 37) Then
    num = GetValue(2, 254)
      If not num = GetValue(3, 37) Then
        AddRec IDCOSTNOTEQUAL, 3, 37
      End If
  End If
  


End Sub


Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "FNMA 1004 " + IDINCOME + String(5, "=")
  
  
  
  'PCV Rules #37: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Basement Area has Sq.Ft reported, but Other Area Cost per Square Foot is Blank.  Provide Basement Cost per Square Foot.
  if (GetValue(2, 254) > 0) then
    if (GetText(3, 18) <> "") and (GetText(3, 19) <> "") then
	  if GetText(3, 20) = "" then
	    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Basement Area has Sq.Ft reported, but Other Area Cost per Square Foot is Blank.  Provide Basement Cost per Square Foot.", 3, 20
	  end if
	end if
  end if
  
  'PCV Rules #40:Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Functional Obsolescence is Blank.   Provide amount of Functional Depreciation, if any noted on the SCA Grid.
  if GetValue(2, 254) > 0 then
    if (GetValue(3, 30) = 0) and (GetValue(3, 31) = 0) then
      AddRec "Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Functional Obsolescence is Blank.   Provide amount of Functional Depreciation, if any noted on the SCA Grid.", 3, 31
	end if	
  end if

'PCV Rules #41:Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Actual Age is more than 5 but percent Physical Depreciation is blank.  Provide percent Physical Depreciation
 if GetValue(2, 254) > 0 then
   if GetValue(2, 26) > 5 then
      if GetValue(3, 28) = 0 then
	    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Actual Age is more than 5 but percent Physical Depreciation is blank.  Provide percent Physical Depreciation", 3, 28
	  end if
   end if
 end if
 
 'PCV Rules #42: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Percent Physical Depreciation is more than "0" but amount of Physical Depreciation is blank.  Provide amount of Physical Depreciation
 if GetValue(2, 254) > 0 then
   if GetValue(3, 28) = 0 then
     if GetValue(3, 29) > 0 then
	   AddRec "Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Percent Physical Depreciation is more than '0' but amount of Physical Depreciation is blank.  Provide amount of Physical Depreciation.", 3, 29
	 end if
   end if
 end if
 
 'PCV Rules #43: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Dwelling Sq.Ft. doesn't ' match GLA in Improvement section of the report.  Provide consistent Dwelling Sq.Ft.
 if GetValue(2, 254) > 0 then   
   gla = GetValue(2, 31)
   dwelling = GetValue(3, 15)
   if gla <> dwelling then
     AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Dwelling Sq.Ft. doesn''t match GLA in Improvement section of the report.  Provide consistent Dwelling Sq.Ft.", 3, 15
   end if
 end if
 
 'PCV Rules #44: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Estimated Economic Life is Blank.  Hud and VA reports require the Estimate.
 if GetValue(2, 254) > 0 then
   if GetValue(3, 13) = 0 then
     AddRec "Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Estimated Economic Life is Blank.  Hud and VA reports require the Estimate.", 3, 13
   end if
 end if
 
'PCV Rules #45: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Effective date of cost data field is blank.  Provide Date
if GetValue(2, 254) > 0 then
  if GetText(3, 11) = "" then
    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Effective date of cost data field is blank.  Provide Date ", 3, 11
  end if
end if

'PCV Rules #36:Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Garage/Carport has Sq.Ft reported, but Garage/Carport Cost per Square Foot is Blank.  Provide Cost per Square Foot.
if GetValue(2, 254) > 0 then
  err1 = (GetValue(3, 24) <> 0) and (GetValue(3, 25) = 0) 
  err2 = (GetValue(3, 24) = 0) and (GetValue(3, 25) <> 0)
  err3 = (GetValue(3, 24) = 0) and (GetValue(3, 25) = 0)
  if err1 then 
      AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Garage/Carport has Sq.Ft reported, but Garage/Carport Cost per Square Foot is Blank.  Provide Cost per Square Foot.", 3, 25
  end if
  if err2 then
      AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Subject Garage/Carport Cost per Square Foot reported, but Garage/Carport Sq.Ft is Blank.  Provide Cost per Square Foot.", 3, 24
  end if
end if

'PCV Rules #46: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Improvement Section reports Garage or Carport but Sq.Ft. is not entered.  Provide Sq.Ft. of Garage or Carport.
if GetValue(2, 254) > 0 then
  err1 = GetCheck(1, 199) and (GetValue(1, 200) > 0) and (GetValue(3, 24) = 0 or GetValue(3, 25) = 0) 
  err2 = GetCheck(1, 201) and (GetValue(1, 202) > 0) and (GetValue(3, 24) = 0 or GetValue(3, 25) = 0)
  if err1 or err2 then
    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Improvement Section reports Garage or Carport but Sq.Ft. is not entered.  Provide Sq.Ft. of Garage or Carport.", 3, 24
   end if
end if


'PCV Rules #47: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Indicated Value field is Blank.  Provide Indicated Value by Cost Approach
if GetValue(2, 254) > 0 then
  if GetValue(3, 37) = 0 then
    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Indicated Value field is Blank.  Provide Indicated Value by Cost Approach.", 3, 37
  end if
end if 

'PCV Rules #48: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Quality rating from Cost Service is blank.  Provide Cost Service quality rating.
if GetValue(2, 254) > 0 then
  if GetText(3, 10) = "" then
    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Quality rating from Cost Service is blank.  Provide Cost Service quality rating.", 3, 10
  end if
end if

'PCV Rules #49: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Support for the Opinion of Site Value is blank.   Comments Required, provide support (Sales, Listings but analysis of market conditions, offsites, view, frontage or any factor affecting value of the site)
if GetValue(2, 254) > 0 then
  if GetValue(3, 14) = 0 then
    AddRec "Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Support for the Opinion of Site Value is blank.   Comments Required, provide support (Sales, Listings but analysis of market conditions, offsites, view, frontage or any factor affecting value of the site)", 3, 12
  end if
end if




   
 
  
  'PCV Rules #39: Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Adverse External "Yes" is Checked in the Site Section of the Report but External Depreciation is blank.  Provide amount of External Depreciation allocated to the Dwelling.   If recent Sales are lower than depreciated Cost to build New , consider adding for External Obsolescence due to Market conditions.
  if GetValue(2, 254) > 0 then
    if isChecked(1, 125) then
	  if GetText(3, 32) = "" then
	    AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report and Adverse External 'Yes' is Checked in the Site Section of the Report but External Depreciation is blank.  Provide amount of External Depreciation allocated to the Dwelling.   If recent Sales are lower than depreciated Cost to build New , consider adding for External Obsolescence due to Market conditions.", 3, 32
	  end if
	end if
  end if
  
  'PCV Rules #38: Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Depreciated cost of Improvements is Blank.  Provide Depreciated Cost of Improvements.
  if GetValue(2, 254) > 0 then
    if GetText(3, 35) = "" then
	  AddRec "** Value Indicated by Cost Approach is entered on Reconciliation Section of the report but Depreciated cost of Improvements is Blank.  Provide Depreciated Cost of Improvements.", 3, 35
	end if
  end if
  
  If isChecked(1, 21) Then
    Require IDINCOMERENT, 3, 38
    Require IDINCOMEGRM, 3, 39
    Require IDINCOMEVALUE, 2, 255
    Require IDINVALINCOME, 3, 40
    Require IDSUMMARYINCOME, 3, 41

  End If

End Sub


Sub ReviewPUD

  AddTitle String(5, "=") + "FNMA 1004 " + IDPUD + String(5, "=")

'PCV #37: Are both PUD HOA boxes blank?
PUDHOA_YN_BLANK = "**NEITHER PUD HOA (Y/N) BOX IS CHECKED."
IDUNITTYPEPUD = "UNIT TYPE(S): " & NO_CHECK_BOXES

'PCV #38: Are multiple PUD HOA boxes checked?
SUBPROJTYPE_PUD = "**MULTIPLE PUD HOA (Y/N) BOXES ARE CHECKED."
If (isChecked(3, 42)) and (isChecked(3,43))   then
   AddRec SUBPROJTYPE_PUD, 3,42
End If


'PCV #39: Are both project conversion boxes blank?
PUDEXTBLDG_YN_BLANK = "NEITHER PROJECT CONVERSION (Y/N) BOX IS CHECKED."
If (not isChecked(3,53)) and (not isChecked(3,54)) then
   AddRec PUDEXTBLDG_YN_BLANK, 3,53
End If

'PCV #40: Are multiple project conversion boxes checked? Should never get this, since CF will allow one check box is checked
PUDEXTBLDG_YESNO = "**MULTIPLE PROJECT CONVERSION (Y/N) BOXES ARE CHECKED."
If (isChecked(3,53)) and (isChecked(3,54)) then
   AddRec PUDEXTBLDG_YESNO, 3,53
End If


If (isChecked(3,53)) and (not hasText(3,55))  then
      AddRec PUDCONVRSN_DT, 3,55
End If



If isChecked(1, 24)   then
   OnlyOneCheckOfTwo 3, 42, 43, PUDHOA_YN_BLANK, XXXXX
   OnlyOneCheckOfTwo 3, 44, 45, IDUNITTYPEPUD, XXXXX
End If

  If isChecked(1, 24) Then
    OnlyOneCheckOfTwo 3, 42, 43, IDCONTROLPUD, XXXXX
    OnlyOneCheckOfTwo 3, 44, 45, IDUNITTYPEPUD, XXXXX
  End If
  
'PCV #41: PUD is not marked as project type, but there is data in the PUD section?
NONPUD = "PROJECT TYPE IS NOT MARKED AS PUD, BUT THERE IS DATA IN THE PUD SECTION."
If not isChecked(3,42) then
  If hasText(3,46) or hasText(3,47) or hasText(3,48) or hasText(3,49) or hasText(3,50) or hasText(3,51) or hasText(3,52) or isChecked(3,53) or isChecked(3,54) or hasText(3,55) or isChecked(3,56)  or isChecked(3,57) or hasText(3,58) or isChecked(3,59) or isChecked(3,60) or hasText(3,61) then
     AddRec NONPUD,3,43
  End If
End If 


 'PCV #42: If PUD is reported;  PUD Information on pg 3,  indicates  [No] and [Detached] on the first line. 
 PUDHOA_YES = "**YOU HAVE REPORTED THAT THE SUBJECT IS IN A PUD, FIRST TWO QUESTIONS OF PAGE 3 PUD SECTION MUST BE ANSWERED."
 If isChecked(1,24) Then
   If not isChecked(3,44) and not isChecked(3,45) Then 'if both checkboxes not check
     AddRec PUDHOA_YES,3,44
   End If
End If

 
  If isChecked(3, 42) and isChecked(3,45) Then
    Require IDLEGALPUD, 3, 46
    Require IDPHASES, 3, 47
    Require IDUNITS, 3, 48
    Require IDUNITSOLD, 3, 49
    Require IDUNITRENT, 3, 50
    Require IDUNITSALE, 3, 51
    Require IDDATASOURCE, 3, 52


    OnlyOneCheckOfTwo 3, 53, 54, IDCONVERSIONPUD, XXXXX

    If isChecked(3, 53) Then
   Require IDDATECONVERTPUD, 3, 55
    End If

    'OnlyOneCheckOfTwo 3, 56, 57, IDMULTIPUD, XXXXX
    Require IDDATEDSPUD, 3, 58
    OnlyOneCheckOfTwo 3, 59, 60, IDCOMPLETEPUD, XXXXX
	
    If isChecked(3, 60) Then
      Require IDCOMPLETESTATUSPUD, 3, 61
    End If
  
    OnlyOneCheckOfTwo 3, 62, 63, IDHOACOMMONPUD, XXXXX

    If isChecked(3, 62) Then
      Require IDRENTALTERMSPUD, 3, 64
    End If
  
    Require IDELEMENTSPUD, 3, 65
  End If

'PCV #43:  Does the unit # of sales exceeds the total # of units
PUDUNITSFORSALEGTPUDUNITS = "**THE NUMBER OF UNITS FOR SALE EXCEEDS THE TOTAL NUMBER OF UNITS."
If isChecked(3,42) then
   If hasText(3,51) and hasText(3,48) then
      num = GetValue(3,51)
      If num > GetValue(3,48) then
        AddRec PUDUNITSFORSALEGTPUDUNITS, 3, 51
      End If
   End If
End If

'PCV #44: Is the data sources field blank?
Require "DATA SOURCE IS BLANK", 3, 52

'PCV #45: Are both Project Multi-Dwelling boxes checked? Should never get this, since CF will allow one check box is checked
PUDMUTIDWLNG_YESNO = "**MULTIPLE PROJECT MULTI-DWELLING (Y/N) BOXES ARE CHECKED."
If isChecked(3,56)  then
  if isChecked(3,57) then
     AddRec PUDMUTIDWLNG_YESNO,3,56
  End If 
End If


  
'PCV #46: Are both Common Elements Completed (Y/N) boxes checked? Should never get this, since CF will allow one check box is checked
PUDCOMELEMNT_YESNO = "**MULTIPLE COMMON ELEMENTS COMPLETED (Y/N) BOXES ARE CHECKED."
If isChecked(3,59)  then
  If isChecked(3,60) then 	
     AddRec PUDCOMELEMNT_YESNO,3,59 
  End If
End If

'PCV #47: Are both Common Elements Lease (y/n) boxes checked? Should never get this, since CF will allow one check box is checked
PUDCOMELEMNTLEASE_YESNO = "**MULTIPLE COMMON ELEMENTS LEASED (Y/N) BOXES ARE CHECKED."
if not isChecked(3, 45) then
  If isChecked(3,62)  then
    If  isChecked(3,63) then
      AddRec PUDCOMELEMNTLEASE_YESNO,3,62
    End If 
  End If
end if

'****************  ONLY Apply for PUD
if isChecked(1, 24) then
  'PCV Rules #96: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased neither Box is checked.
  if isChecked(3, 42) and isChecked(3, 45) then
   if not isChecked(3, 62) and not isChecked(3, 63) then
    AddRec "**PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased neither Box is checked.", 3, 62  
   end if
  end if

  'PCV Rules #97: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased both boxes are checked. Check One Box.
  if isChecked(3, 45) and isChecked(3, 42) then
    if isChecked(3, 62) and isChecked(3, 63) then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased both boxes are checked. Check One Box.", 3, 62  
    end if
  end if

  'PCV Rules #98: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased "Yes" box is checked and Comment field is blank.  Provide required comments.
  if isChecked(3, 45) and isChecked(3, 42) then
    if isChecked(3, 62) and (GetText(3, 64) = "") then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Common Elements Leased 'Yes' box is checked and Comment field is blank.  Provide required comments.", 3, 64
    end if
  end if

  'PCV Rules #99: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion neither Box is checked.  Check one Box
  if isChecked(3, 45) and isChecked(3, 42) then
    if not isChecked(3, 53) and not isChecked(3, 54) then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion neither Box is checked.  Check one Box", 3, 53
    end if
  end if

  'PCV Rules #100: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion both boxes are checked.  Check one Box
  if isChecked(3, 45) and isChecked(3, 42) then
    if isChecked(3, 53) and isChecked(3, 54) then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion both boxes are checked.  Check one Box", 3, 53
    end if
  end if

  'PCV Rules #101: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion "Yes" box is checked and Comment field is blank.  Provide required comments.
  if isChecked(3, 45) and isChecked(3, 42) then
    if isChecked(3, 53) and GetText(3, 55) = "" then
       AddRec "PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Conversion 'Yes' box is checked and Comment field is blank.  Provide required comments.", 3, 55
    end if
  end if
 
  'PCV Rules #102: PUD Information Section,  Developer/builder in control of the HOA is "Yes" but Data Source(s) is Blank.  Provide  Data Source(s).
  if isChecked(3, 45) and isChecked(3, 42) then
    if GetText(3, 52) = "" then
      AddRec "** PUD Information Section,  Developer/builder in control of the HOA is 'Yes' but Data Source(s) is Blank.  Provide Data Source(s).", 3,52
    end if
  end if 

  'PCV Rules #103: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Data Source(s) for Multi-Unit Dwellings is Blank.  Provide Data Source(s) for Multi-Unit Dwellings
  if isChecked(3, 45) and isChecked(3, 42) then
    if GetText(3, 58) = "" then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Data Source(s) for Multi-Unit Dwellings is Blank.  Provide Data Source(s) for Multi-Unit Dwellings.", 3, 58
    end if
  end if

  'PCV Rules #104: PUD checked in Subject Section, but PUD Information Section, "Is Developer/builder in control of the HOA", Both  Boxes checked.  Check one Box
  if isChecked(1, 24) then
    if isChecked(3, 42) and isChecked(3, 43) then
      AddRec "** PUD checked in Subject Section, but PUD Information Section, 'Is Developer/builder in control of the HOA', Both Boxes checked.  Check one Box.", 3, 42
    end if
  end if

  'PCV Rules #105: PUD checked in Subject Section, but PUD Information Section, "Is Developer/builder in control of the HOA",  neither  Box checked.  Check one Box
  if isChecked(1, 24) then
    'if not isChecked(3, 42) or not isChecked(3, 43) then
     if not isChecked(3, 42) and not isChecked(3, 43) then    
	AddRec "** PUD checked in Subject Section, but PUD Information Section, 'Is Developer/builder in control of the HOA', Neither Box checked.  Check one Box", 3, 42
    end if
  end if

  'PCV Rules #106: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Legal Name of Project is Blank.  Provide Legal Name of Project
  if isChecked(3, 42) and isChecked(3, 45) then
    if GetText(1, 13) = "" then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Legal Name of Project is Blank.  Provide Legal Name of Project", 1, 13
    end if
  end if

  'PCV Rules #107: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units neither Box is checked.  Check one Box
  if isChecked(3, 42) and isChecked(3, 45) then
    if not isChecked(3, 56) and not isChecked(3, 57) then
      AddRec "**PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units neither Box is checked.  Check one Box", 3, 56
    end if
  end if

  'PCV Rules #108: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units both boxes are checked.  Check one Box
  if isChecked(3, 42) and isChecked(3, 45) then
    if isChecked(3, 56) and isChecked(3, 57) then
      AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units both boxes are checked.  Check one Box", 3, 56
    end if
  end if

  'PCV Rules #109: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units "Yes" box is checked and Comment field is blank.  Provide required comments.
  if isChecked(3, 42) and isChecked(3, 45) then
    if isChecked(3, 56) then
	  if GetText(3, 58) = "" then
	    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Multi-Dwelling Units ''Yes'' box is checked and Comment field is blank.  Provide required comments.", 3, 58
	  end if
	end if
  end if

'PCV Rules #110: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number For Sale is Blank.  Provide Number For Sale
if isChecked(3, 42) and isChecked(3, 45) then
  if GetValue(3, 51) = 0 then
    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number For Sale is Blank.  Provide Number For Sale", 3, 51
  end if
end if

'PCV Rules #111: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Phases is Blank.  Provide Number of Phases
if isChecked(3, 42) and isChecked(3, 45) then
  if GetValue(3, 47) = 0 then
    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Phases is Blank.  Provide Number of Phases.", 3, 47
  end if
end if

'PCV Rules #112:PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Units is Blank.  Provide Number of Units
if isChecked(3, 42) and isChecked(3, 45) then
  if GetValue(3, 48) = 0 then
    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number of Units is Blank.  Provide Number of Units.", 3, 48
  end if
end if

'PCV Rules #113: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Rented is Blank.  Provide Number Rented
if isChecked(3, 42) and isChecked(3, 45) then
  if GetValue(3, 50) = 0 then
    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Rented is Blank.  Provide Number Rented.", 3, 50
  end if
end if

'PCV Rules #114: PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Sold is Blank.  Provide Number Sold
if isChecked(3, 42) and isChecked(3, 45) then
  if GetValue(3, 49) = 0 then
    AddRec "** PUD Information Section Unit type(s) is Attached and Developer/builder is in control of the HOA but Number Sold is Blank.  Provide Number Sold.", 3, 49
  end if
end if

'PCV Rules #115: PUD checked  in Subject Section, but PUD Information Section Unit type(s) (Detached/Attached) neither box is checked.
if not isChecked(3, 44) and not isChecked(3, 45) then
  AddRec "** PUD checked  in Subject Section, but PUD Information Section Unit type(s) (Detached/Attached) neither box is checked.", 3, 44
end if

end if 'end if of PUD is checked

if isUAD then
   '****************************
  '****************************   FANNIE MAE RULES ADDED 12/04/2014
  'RULE #: FNM0083: The sales contract was not analyzed.
  if isChecked(1, 42) then 'DID NOT ANALYZED is checked
    if GetText(1, 43) = "" then 'no comment is provided
	  AddRec FNMCONTRACTNOTANALYZE, 1, 43
	end if
  end if
  
  'RULE # FNM0084: There was no comment on market conditions, even though one or more negative housing trends were indicated(declining, over supply, over 6 mos)
  if GetText(1, 84) = "" then
    count = GetCheck(1, 63) +  GetCheck(1, 66) + GetCheck(1, 69)
    if count > 0 then 'one or more negative trends
	  AddRec FNMMARKETCONDITION, 1, 84
	end if
  end if
  'RULE # FNM0085: Handled inside the exe
  'RULE # FNM0086: Research of prior sale was not performed
  'pop up error even we have comment
  if isChecked(2, 226) then
    AddRec FNNOREARCHPRIORSALE, 2, 226
  end if
  
  'RULE # FNM0093: Handled inside the exe
  'RULE # FNM0094: Handled inside the exe
  
  'RULE # FNM0096: Illegal zoning compliance has been indicated in appraisal.
  if isChecked(1, 94) then
    AddRec FNMILLEGALZONING, 1, 94
  end if
  
 'RULE # FNM0098: Present use is indicated as not highest and best use.
' if not isChecked(1, 96) then
'   AddRec FNMBESTUSE, 1, 96
' end if

'Replace Rule #FNM0098 with FRE1095" Subject Highest and Best Use
'NotBestUse = "Present use is indicated as not highest and best use. Please ensure that this mortgage is eligible for sale to Fannie Mae or Freddie Mac."
'if not isChecked(1, 96) or isChecked(1, 97) then
'  if isUAD then
'    AddRec "*" &NotBestUse, 1, 96
'  else
'    AddRec NotBestUse, 1, 96
'  end if
' end if
 

 'RULE # FNM0176: Only apply for 1073 and 1075
  
 'RULE #FNM0179: The appraisal indicates the subject property has a C6 condition rating. If the loan is not a DU Refi Plus or Refi Plus 'loan, the property is not eligible for delivery to Fannie Mae.
condition = uCase(GetText(2, 27))
if trim(condition) = "C6" then
  AddRec FNMConditionC6, 2, 27
end if

end if 'end of if isUAD
  
End Sub

