'REV00345.vbs Condo Reviewer Script
' 05/11/2015:
' Add RULE # FRE1093: Condominium Zoning - Triggers if the Site Zoning Compliance Type is Legal Nonconforming and the Site Zoning Permit Rebuild to Current Density Indicator is "No"
' Add RULE # FRE1095 : Critical warning - Trigger is Subject Highest and Best Use is not Yes
' 06/17/2014: Fix PCV #26: Make sure subject sales price is bracketed by  comp. sales price.
' 04/08/2014: Add more rules:
' Only do the check of date/price sale/transfer for the subject if subject of my research is checked
' Do the same check of date/price sale/transfer for the comp if comp of my research is checked
' Only warn if tax amount > 0 and per year/per month check box is not checked.
' 05/15/2013: Fix Divide by 0 issue.  Check if Subject GLA has value before doing the math.
' 04/26/2013: Add rule to check the consistency of quality condition in page 3 cell 32 and page 2 cell 88.
' 04/01/2013: Add more rules
' Show warning if contract date is BEFORE effective date
' Show warning if settled date is BEFORE contract date
' 03/28/2013: Add more rules
' When a sale or listing is greater than or less than 20% of the subject's GLA, show warning.
'09/17/2014 Move "is subject GLA in comps range" in Grid Review
'09/22/2014 Move chack is subject quality and condition match comps to grid Review

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
 ReviewProjectAnalysis
 AddTitle ""
 ReviewSubjectUnit
 AddTitle ""
 ReviewPriorSales
 AddTitle ""
 ReviewSalesSubject
 AddTitle ""
 ReviewIncomeApproach
 AddTitle ""
 ReviewReconciliation
 AddTitle ""
End Sub

Sub ReviewSubject
 
   AddTitle String(5, "=") + "FNMA 1073 " + IDSUBJECT + String(5, "=")

   Require IDFILENUM, 1, 3
   Require IDADDRESS, 1, 6
   If IsUAD Then
     Require IDUNITS_UAD, 1, 7
   Else
     Require IDUNITS, 1, 7
   End IF
   Require IDCity, 1, 8
   Require IDState, 1, 9
   Require IDZip, 1, 10
   Require IDBorrower, 1, 11
   Require IDOWNERPUB, 1, 12
   Require IDCounty, 1, 13
   Require IDLegal, 1, 14
   Require IDAPN2, 1, 15
   Require IDTaxYear, 1, 16
   If GetCellUADError(1, 16) Then
     AddRec IDTAXYEARUADERROR, 1, 16
   End If
   Require IDReTaxes, 1, 17
   Require IDProjName2, 1, 18
   Require IDPhase, 1, 19
   Require IDMapref, 1, 20
   Require IDCensus, 1, 21
   OnlyOneCheckOfThree 1, 22, 23, 24, IDOccNoCheck, IDOccChk
   Require IDSpecial, 1, 25
   
   If not isnegativecomment(1, 26) Then 
     If GetValue(1, 26) > 0 Then
       OnlyOneCheckOfTwo 1, 27, 28, ID_HOA_PERIOD_NONE_CHECKED, ID_HOA_PERIOD_MANY_CHECKED 
     End If 
   End If

   OnlyOneCheckOfThree 1, 29, 30, 31, ID_PROPERTY_RIGHTS_NONE_CHECKED, ID_PROPERTY_RIGHTS_MANY_CHECKED

   If isChecked(1, 31) Then
       Require IDOTHERDATA, 1, 32
   End If

   OnlyOneCheckOfThree 1, 33, 34, 35, ID_ASSIGNMENT_TYPE_NONE_CHECKED, ID_ASSIGNMENT_TYPE_MANY_CHECKED

   If isChecked(1, 35) Then
     Require IDOTHERDATA2, 1, 36
   End If

   Require IDLender, 1, 37
   Require IDLenderAdd, 1, 38

   OnlyOneCheckOfTwo 1, 39, 40, ID_SUBJECT_FOR_SALE_NONE_CHECKED, ID_SUBJECT_FOR_SALE_MANY_CHECKED
   Require ID_SUBJECT_BLOCK_DATA_SOURCE_REQUIRED, 1, 41
   If IsUAD and HasText(1, 41) Then
     ContractStr = UCase(GetText(1, 41))
     If InStr(ContractStr, "SUBJECT PROPERTY WAS OFFERED FOR SALE") > 0 Then
       If (InStr(ContractStr, ";MLS") = 0) and (InStr(ContractStr, "NOT LISTED ON MLS") = 0) Then
         AddRec ID_SUBJECT_BLOCK_DATA_SOURCE_NOTMLS, 1, 41
       End If
     End If
   End If
  If GetCellUADError(1, 41) Then
    AddRec ID_SUBJECT_BLOCK_DATA_SOURCE_UADERROR, 1, 41
  End If
 
  '****************************
  '****************************   FANNIE MAE RULES ADDED 12/04/2014
if isUAD then 
  'RULE #: FNM0083:
  if isChecked(1, 43) then 'DID NOT ANALYZED is checked
    if GetText(1, 44) = "" then
	  AddRec FNMCONTRACTNOTANALYZE, 1, 44
	end if
  end if
  
  'RULE # FNM0084: There was no comment on market conditions, even though one or more negative housing trends were indicated(declining, over supply, over 6 mos)
  if GetText(1, 85) = "" then
    count = GetCheck(1, 64) +  GetCheck(1, 67) + GetCheck(1, 70)
    if count > 0 then 'one or more negative trends
	  AddRec FNMMARKETCONDITION, 1, 85
    end if
  end if

 'RULE # FNM0085: Handled inside the exe
 'RULE # FNM0086: Research of prior sale was not performed
 
  
  'RULE # FNM0087: Research of prior sale was not performed
  'pop up error even we have comment
  if isChecked(1, 43) then
    AddRec FNNOREARCHPRIORSALE, 1, 43
  end if
  
  'RULE # FRE1093: Condominium Zoning - Triggers if the Site Zoning Compliance Type is Legal Nonconforming and the Site Zoning Permit Rebuild to Current Density Indicator is "No"
  Legal_Nonconforming = "Site Zoning is Legal Nonconforming.  Please ensure that this mortgage is eligible for sale to Freddie mac."
  if isChecked(1, 93) and isChecked(1, 95) then
    if isUAD then
      AddRec "*"&Legal_Nonconforming, 1, 93  'show critical warning
 	else
      AddRec Legal_Nonconforming, 1, 93
	end if
  end if
     
  
  'RULE # FNM0097: Illegal zoning compliance has been indicated in appraisal.
  if isChecked(1, 97) then
    AddRec FNMILLEGALZONING, 1, 97
  end if
  
  
 'RULE # FNM0099: Present use is indicated as not highest and best use.
 'if not isChecked(1, 99) then
 '  AddRec FNMBESTUSE, 1, 99
 'end if
 
 'RULE # FNM0176: The appraisal indicates that the subject property has legal nonconforming zoning
 ' Show ERROR when both legal Non Conforming and 'No' for Do the zoning regulations 
 if isChecked(1, 93) and isChecked(1, 95) then
   AddRec FNMNONCONFORM, 1, 93
 end if

end if 'end of isUAD



  
End Sub


Sub ReviewContract

  AddTitle String(5, "=") + "FNMA 1073 " + ID_CONTRACT_BLOCK + String(5, "=")

 
   
  If (not isChecked(1, 34)) and (not isChecked(1, 35)) Then
    ValidateStandardContractBlock 1, 42
    IsContractDateBEFOREEffectiveDate 1,46,3,269     'pass in contract date(1,46) and effective date(3,269) 
    If hasText(1, 45) Then
      num = GetValue(1, 45)
      If num > GetValue(3, 268) Then
        AddRec IDCONTRACTFNMA1, 1, 45
      Else
        If num < GetValue(3, 268) Then
          AddRec IDCONTRACTFNMA2, 1, 45
        End If
      End If
    End If
  Else
    If hasText(1, 45) Then
      Require IDCONTRACTFNMA, 1, 33
    End If
  End If

  If GetCellUADError(1, 44) Then
    AddRec IDCONTRACTUADERROR, 1, 44
  End If

  OnlyOneCheckOfTwo 1, 50, 51, ID_CONTRACT_ASSISTANCE_NONE_CHECKED, ID_CONTRACT_ASSISTANCE_MANY_CHECKED
  CheckAndComment 1, 50, 52, ID_CONTRACT_ASSISTANCE_COMMENT_REQUIRED, ""
  If GetCellUADError(1, 52) Then
    AddRec ID_CONTRACT_ASSISTANCE_UADERROR, 1, 52
  End If
  
 'PCV #1: If Growth Rate - Rapid is checked, is Property Values - Declining checked?
 NBHPROPVAL_DECL = "**GROWTH RATE IS RAPID BUT PROPERTY VALUES SHOWN AS 'DECLINING'."
 If isChecked(1,59) and isChecked(1,64) Then
   AddRec NBHPROPVAL_DECL,1,59
 End If
 
'PCV #2: If Growth Rate - Rapid is checked, is Demand/Supply - Oversupply checked?
NBHDEMSUP_OVRSUP = "**GROWTH RATE IS RAPID BUT DEMAND/SUPPLY SHOWN AS 'OVERSUPPLY'."
If isChecked(1,59) and isChecked(1,67) Then
      AddRec NBHDEMSUP_OVRSUP,1,59
End If

'PCV #3: If Growth Rate - Rapid is checked, Marketing Time - Over 6 mos. checked?
NBHMKTTIME_OVR6 = "**GROWTH RATE IS RAPID BUT MARKETING TIME SHOWN AS 'OVER 6 MONTHS'."
If isChecked(1,59) and isChecked(1,70) Then
    AddRec NBHMKTTIME_OVR6,1,59
End If

'PCV #4: If Property Values - Increasing is checked, is Growth Rate - Slow checked?
NBHGRWRT_SLOW = "**PROPERTY VALUES INCREASING BUT GROWTH RATE SHOWN AS 'SLOW'."
If isChecked(1,62) and isChecked(1,61) Then
   AddRec NBHGRWRT_SLOW, 1,62
End If

'PCV #5: If Property Values - Increasing is checked, is Demand/Supply - Oversupply checked?
NBHDEMSUP_OVRSUP = "**PROPERTY VALUES INCREASING BUT DEMAND/SUPPLY SHOWN AS 'OVERSUPPLY'."
If isChecked(1,62) and isChecked(1,67) Then
  AddRec NBHDEMSUP_OVRSUP, 1,66
End If

'PCV #6: If Property Values - Increasing is checked, is Marketing Time - Over 6 mos. checked?
NBHMKTTIME_OVR6_INCR ="** PROPERTY VALUES INCREASING BUT MARKETING TIME SHOWN AS 'OVER 6 MONTHS'."
If isChecked(1,62) and isChecked(1,70) Then
   AddRec NBHMKTTIME_OVR6_INCR,1,62
End If

'PCV #7: If Demand/Supply - Shortage is checked, is Growth Rate - Slow checked?
NBHDEMSUP_SHRTG_OVR6 = "**DEMAND/SUPPLY IN SHORTAGE BUT MARKETING TIME SHOWN AS 'OVER 6 MONTHS'."
If isChecked(1,65) and IsChecked(1,61) Then
   AddRec NBHDEMSUP_SHRTG, 1, 65
End If

'PCV #8: If Marketing Time - Under 3 mos. is checked, is Property Values - Declining checked? 
NBHMKTTIME_UND3_DECSUP = "**MARKETING TIME UNDER 3 MONTHS BUT PROPERTY VALUES SHOWN AS 'DECLINING'."	
If isChecked(1,64) and isChecked(1,68) Then
   AddRec NBHMKTTIME_UND3_DECSUP, 1, 64
End If


'PCV #9: If Demand/Supply - Shortage is checked, is Property Values - Declining checked?
NBHPROPVAL_DECL_SHRTG = "**DEMAND/SUPPLY IN SHORTAGE BUT PROPERTY VALUES SHOWN AS 'DECLINING'."
If isChecked(1, 66) and isChecked(1,64) Then
    AddRec NBHPROPVAL_DECL_SHRTG, 1, 66
End If

'PCV #10: If Demand/Supply - Shortage is checked, is Marketing Time - Over 6 mos. checked?
NBHDEMSUP_SHRTG_OVR6 = "**DEMAND/SUPPLY IN SHORTAGE BUT MARKETING TIME SHOWN AS 'OVER 6 MONTHS'."
If isChecked(1,65) and isChecked(1,70) Then
    AddRec NBHDEMSUP_SHRTG_OVR6, 1, 65
End If

'PCV #11: If Marketing Time - Under 3 mos. is checked, is Growth Rate - Slow checked? 
NBHMKTTIME_UND3_SLOW = "**MARKETING TIME UNDER 3 MONTHS BUT GROWTH RATE SHOWN AS 'SLOW'."
If isChecked(1,68) and isChecked(1,61) Then
    AddRec NBHMKTTIME_UND3_SLOW, 1, 68
End If

'PCV #12: If Marketing Time - Under 3 mos. is checked, is Demand/Supply - Oversupply checked? 
NBHMKTTIME_UND3_OVRSUP = "**MARKETING TIME UNDER 3 MONTHS BUT SUPPLY/DEMAND SHOWN AS 'OVERSUPPLY'. "
If IsChecked(1,68) and isChecked(1,67) Then
   AddRec NBHMKTTIME_UND3_OVRSUP, 1, 68
End If

'PCV #13: Is the Predominant Price below the Single Family Price-Low range?
SFHPRICEPRED_PRICELOW = "**PREDOMINANT PRICE IS BELOW THE LOW RANGE."
If hasText(1,73) and hasText(1,71) Then  
   num = GetValue(1,73)
   lnum = GetValue(1,71)
   if num < lnum Then
      AddRec SFHPRICEPRED_PRICELOW, 1, 71
   End If
End If

'PCV #14: Is the Predominant Price above the Single Family Price-High range?
SFHPRICEPRED_PRICEHIGH = "**PREDOMINANT PRICE IS ABOVE THE HIGH RANGE."
If hasText(1,73) and hasText(1,72) Then  
   num = GetValue(1,73)
   hnum = GetValue(1,72)
   if hnum < num Then
      AddRec SFHPRICEPRED_PRICEHIGH, 1, 72
   End If
End If

'PCV #15: Is the Predominant Age below the Single Family Age-Low range?
SFHAGEPRED_AGELOW = "**PREDOMINANT AGE IS BELOW THE LOW RANGE."
If hasText(1,76) and hasText(1,74) Then  
   num = GetValue(1,76)
   lnum = GetValue(1,74)
   if num < lnum Then
      AddRec SFHAGEPRED_AGELOW, 1,76
   End If
End If

'PCV #16: Is the Predominant Age Above the Single Family Age-High range?
SFHAGEPRED_AGEHIGH = "**PREDOMINANT AGE IS ABOVE THE HIGH RANGE."
If hasText(1,76) and hasText(1,75) Then 
   num = GetValue(1,76)
   hnum = GetValue(1,75)
   if num > hnum Then
      Require SFHAGEPRED_AGEHIGH, 1, 76
   End If
End If

'PCV #18: Is the Effective Age below the Neighborhood Low range
GDSEFFECTAGE_AGELOW = "**EFFECTIVE AGE IS BELOW INDICATED NEIGHBORHOOD LOW."
If hasText(1,145) and hasText(1,74) Then  
   if GetValue(1,145) < GetValue(1,74) Then
      AddRec GDSEFFECTAGE_AGELOW, 1, 74
   End If
End If

'PCV #19: Is the Effective Age Above the Neighborhood High range
GDSEFFECTAGE_AGEHIGH = "**EFFECTIVE AGE IS ABOVE INDICATED NEIGHBORHOOD HIGH."
If (hasText(1,145)) and (hasText(1,75)) Then  
   num = GetValue(1,145)
   hnum = GetValue(1,75)
   if hnum < num Then
      AddRec GDSEFFECTAGE_AGEHIGH, 1, 75
   End If
End If


End Sub

Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 1073 " + IDNeigh + String(5, "=")

  ValidateStandardNeighborhoodBlock107310751004c 1, 53

  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num > GetValue(1, 72) Then
        AddRec IDTOBERANGEC, 1,72
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num < GetValue(1, 71) Then
        AddRec IDTOBERANGEC, 1,71
      End If
  End If

  sum = GetValue(1, 77) + GetValue(1, 78) + GetValue(1, 79) + GetValue(1, 80) + GetValue(1, 82)

  If sum <> 100 Then
    AddRec IDLandUse, 1, 77
  End If

 'PCV #21: Are the Neighborhood Boundries reported accurately?
 NBHBOUNDARIES_1 = "VERIFY THAT THE NEIGHBORHOOD BOUNDARIES & CHARACTERISTICS ARE ACCURATELY REPORTED."
 If hasText (1,83) Then
   AddRec NBHBOUNDARIES_1, 1, 83
 End If

 'PCV #22: Are the Neighborhood Description reported accurately?
 NBHFACTORS_1 = "VERIFY THAT THE FACTORS THAT AFFECT THE MARKETABILITY OF PROPERTIES IN THE NEIGHBORHOOD ACCURATELY REPORTED."
 If hasText(1,84) Then
   AddRec NBHFACTORS_1, 1, 84
 End If

  
   Require IDNEIGHBOUND, 1, 83
   Require IDNEIGHDES, 1, 84
   Require IDNEIGHCOND, 1, 85

End Sub


Sub ReviewSite

  AddTitle String(5, "=") + "FNMA 1073 " + IDPRoSite + String(5, "=")

  Require IDTOPOGRAPHY, 1, 86
  Require IDSITEAREA, 1, 87
  If GetCellUADError(1, 87) Then
    AddRec IDSUBSITEUADERROR, 1, 87
  End If
  Require IDDENSITY, 1, 88
  Require IDVIEW, 1, 89
  If GetCellUADError(1, 89) Then
    AddRec IDSUBVIEWUADERROR, 1, 89
  End If
  Require IDZONINGCLAS, 1, 90
  Require ID_ZONING_DESCRIPTION_REQUIRED, 1, 91

 'PCV #23: Is the Zoning Classification residential?
 SITZONCLASS = "**VERIFY THAT THE FOLLOWING ZONING IS A RESIDENTIAL CLASSIFICATION."
If not hasText(1,90) or not hasText(1,91) Then
   AddRec SITZONCLASS, 1, 90
 End If

'PCV #24: If an Off-Site Improvement is private, is it verified?
OSISTREET_PRIV = "AT LEAST ONE OFF-SITE IMPROVEMENT IS SHOWN AS PRIVATE. "
If not isChecked(1,116)  and not isChecked(1,119) Then
   AddRec OSISTREET_PRIV,1,116
End If

'PCV #25: If FEMA Special Flood Hazard Area has been checked 'YES', has it been verified?
SITFLDHAZ_YES = "**FEMA SPECIAL FLOOD HAZARD AREA IS CHECKED 'YES', BUT FEMA INFO ARE EMPTY."
noErr = False
If isChecked(1,120) Then
   If hasText(1,122) or hasText(1,123) or hasText(1,124) Then
      noErr = True
   End If
   If not noErr Then
       AddRec SITFLDHAZ_YES,1,120
   End If
End If


  OnlyOneCheckOfFour 1, 92, 93, 96, 97, IDZONINGCOM, "ZONING: Multiple Zoning Statuses Checked"
  If isChecked(1, 93) Then
    OnlyOneCheckOfTwo 1, 94, 95, IDNONCOFORM, "REBUILDING PERMITTED: Both Yes and No Checked"
  End If

  If isChecked(1, 97) Then
    Require IDILLEGAL, 1, 98
  End If

  ValidateSiteBlock 1, 99
  
 'PCV #26: If the Highest and Best Use of the Subject is not checked "Present Use" STOP
 SITHBNO_DESC = "**THE HIGHEST AND BEST USE OF THE SUBJECT PROPERTY AS UNOIRVED DESCRIPTION: " & REQUIRED_DATA_MISSING
If isChecked(1,100) and not hasText(1,101) Then 
       AddRec SITHBNO_DESC,1,101
 End If


End Sub

Sub ReviewImprovements

  AddTitle String(5, "=") + "FNMA 1073 " + IDIMPROVM2 + String(5, "=")

  Require IDDATASOURCE, 1, 131

  OnlyOneCheckOfSix 1, 132, 133, 134, 135, 136, 137, ID_PROJECT_DESCRIPTION_NONE_CHECKED, ID_PROJECT_DESCRIPTION_MANY_CHECKED
  CheckAndComment 1, 137, 138, "", ""

  Require IDSTORIES, 1, 139
  Require IDELEVATOR, 1, 140
  OnlyOneCheckOfThree 1, 141, 142, 143, IDEXISTING, "EXISTING/PROPOSED: Multiple Statuses Checked"

  Require IDYRBLT, 1, 144
  Require IDEFFAGE, 1, 145
  Require IDEXT, 1, 146
  Require IDROOFSUF, 1, 147
  Require IDTOTPARK, 1, 148
  Require IDRATIO, 1, 149
  Require IDTYPE, 1, 150
  Require IDGUEST, 1, 151

  If (hasText(1, 158) or hasText(1, 159) or hasText(1, 160) or hasText(1, 161) or hasText(1, 162) or hasText(1, 163)) Then
  'Project Completed
      Require IDUNITS, 1, 159
      Require IDUNITSALE, 1, 160
      Require IDUNITSOLD, 1, 161
      Require IDUNITRENT, 1, 162
      If (hasText(1, 164) or hasText(1, 165) or hasText(1, 166) or hasText(1, 167) or hasText(1, 168) or hasText(1, 169)) Then
        AddRec IDPROJPLN, 1, 158        'data in both Completed and Incomplete
      End If
  Else
      If (hasText(1, 164) or hasText(1, 165) or hasText(1, 166) or hasText(1, 167) or hasText(1, 168) or hasText(1, 169)) Then
      'Project Incomplete
          Require IDUNITS, 1, 165
          Require IDUNITSALE, 1, 166
          Require IDUNITSOLD, 1, 167
          Require IDUNITRENT, 1, 168
      End If
  End If

  'Subject Phase
  Require IDSUBNUMPHASES, 1, 152
  Require IDSUBNUMUNITS, 1, 153
  Require IDSUBUNITSALE, 1, 154
  Require IDSUBUNITSOLD, 1, 155
  Require IDSUBUNITRENT, 1, 156
  Require IDSUBOWNEROCC, 1, 157

  'If Proj Completed
  Require IDPCNUMPHASES, 1, 158
  Require IDPCNUMUNITS, 1, 159
  Require IDPCUNITSSALE, 1, 160
  Require IDPCUNITSSOLD, 1, 161
  Require IDPCUNITSRENTED, 1, 162
  Require IDPCOWNEROCC, 1, 163

  'If Proj Incomplete
  Require IDPIPLANNED, 1, 164
  Require IDPIPLANNEDUNITS, 1, 165
  Require IDPIUNITESSALE, 1, 166
  Require IDPIUNITSSOLD, 1, 167
  Require IDPIUNITSRENT, 1, 168
  Require IDPIOWNEROCC, 1, 169

  OnlyOneCheckOfThree 1, 170, 171, 172, IDOCCUPANCY, IDOCCUPANCYCK

  OnlyOneCheckOfTwo 1, 173, 174, IDHOANOCHK, IDHOACHK

  OnlyOneCheckOfThree 1, 175, 176, 177, IDMNGNOCHK, IDMNGCHK

  If isChecked(1, 177) Then
    Require IDMGTGRPNAME, 1, 178
  End If

  OnlyOneCheckOfTwo 1, 179, 180, ID_PROJECT_SINGLE_ENTITY_10_PERCENT_NONE_CHECKED, ID_PROJECT_SINGLE_ENTITY_10_PERCENT_MANY_CHECKED

  If isChecked(1, 179) Then
    Require ID_PROJECT_SINGLE_ENTITY_10_PERCENT_NONE_CHECKED_DESC, 1, 181
  End If

  OnlyOneCheckOfTwo 1, 182, 183, IDCONNOCHK, IDCONCHK

  If isChecked(1, 182) Then
    Require IDCONVERUSEANDDATE, 1, 184
  End If

  OnlyOneCheckOfTwo 1, 185, 186, IDCOMELEMENTSUNITS, "PUD COMM ELEM COMPLETE: Both Yes and No are Checked"

  If isChecked(1, 186) Then
    Require IDCOMELEMENTSUNITSNO, 1, 187
  End If

  OnlyOneCheckOfTwo 1, 188, 189, ID_PROJECT_CONTAINS_COMMERCIAL_NONE_CHECKED, ID_PROJECT_CONTAINS_COMMERCIAL_MANY_CHECKED

  If isChecked(1, 188) Then
    Require IDCOMSPACENO, 1, 190
  End If
  If GetCellUADError(1, 190) Then
    AddRec IDCOMSPACEUADERROR, 1, 190
  End If

  Require IDFILENUM, 2, 2
  Require IDCONQUAL, 2, 5
  Require IDCOMELEREC, 2, 6

  OnlyOneCheckOfTwo 2, 7, 8, IDLEASEDHOA, "PUD COMM ELEM LEASED: Bothe Yes and No are Checked"

  If isChecked(2, 7) Then
     Require IDLEASEDHOAYES, 2, 9
  End If

  OnlyOneCheckOfTwo 2, 10, 11, IDGROUNDRENT, "PUD SUBJECT TO GROUND RENT: Both Yes and No are Checked"

  If isChecked(2, 10) Then
      Require IDGROUNDRENTYES, 2, 12
  End If

  If isChecked(2, 10) Then
      Require IDGROUNDRENTYES2, 2, 13
  End If

  OnlyOneCheckOfTwo 2, 14, 15, IDPARKFAC, "PUD PARKING ADEQUACY: Both Yes and No are Checked"

  If isChecked(2, 15) Then
      Require IDPARKFACNO, 2, 16
  End If

End Sub


Sub ReviewProjectAnalysis

  AddTitle String(5, "=") + "FNMA 1073 " + IDANALYSIS + String(5, "=")
  OnlyOneCheckOfTwo 2, 17, 18, IDANALYZEBUDGET, "PUD BUDGET ANALYZED: Both Yes and No are Checked"
  Require IDANALYZEBUDGETRESULTS, 2, 19

  OnlyOneCheckOfTwo 2, 20, 21, IDFACFEES, "PUD OTHER FEES: Bothe Yes and No are Checked"
  If isChecked(2, 20) Then
      Require IDFACFEESYES, 2, 22
  End If

  OnlyOneCheckOfThree 2, 23, 24, 25, IDUNITCHARGE, "PUD UNIT CHARGES: More than one is checked"
  If isChecked(2, 23) Then
      Require IDUNITCHARGEHILO, 2, 26
  End If
  If isChecked(2, 25) Then
      Require IDUNITCHARGEHILO, 2, 26
  End If

  OnlyOneCheckOfTwo 2, 27, 28, IDUNUSUALCHAR, "PUD UNUSUAL CHAR: Both Yes and No are Checked"
  If isChecked(2, 27) Then
      Require IDUNUSUALCHARYES, 2, 29
  End If

End Sub


Sub ReviewSubjectUnit
Dim Text1, QTYg, QTYcv, QTYop, ItemLoc

  AddTitle String(5, "=") + "FNMA 1073 " + IDROOMLIST2 + String(5, "=")

  Require IDUNITCHR, 2, 30
  Require IDPERYR, 2, 31
  Require IDCHARGEPERSQFTGLA, 2, 32

  OnlyOneCheckOfNine 2, 33, 34, 35, 36, 37, 38, 39, 40, 41, IDUTLNOCHK, XXXXX

  If isChecked(2, 41) Then
    Require IDMONTHLYOTHER, 2, 42
  End If

  Require IDFLOOR, 2, 43
  Require IDLEVELS, 2, 44
  Require IDHEATTYPE, 2, 45
  Require IDHEATFUEL, 2, 46
  OnlyOneCheckOfThree 2, 47, 48, 49, IDCOOLCOND2, XXXXX

  If isChecked(2, 49) Then
   Require IDCOOLOTHER, 2, 50
  End If

  Require IDFLOORING, 2, 51
  Require IDWALLS, 2, 52
  Require IDTRIMFINISHCONDO, 2, 53
  Require IDWAINSCOT, 2, 54
  Require IDDOORSCONDO, 2, 55

  'Amenities
  OnlyOneCheckOfFive 2, 56, 58, 60, 62, 64, IDAMENITIES, XXXXX

  If isChecked(2, 56) Then
    If IsUAD Then
      If (not hasText(2, 57)) or (GetValue(2, 57) <= 0) Then
        AddRec IDFIREPLACE2, 2, 57
      End If
    Else
      Require IDFIREPLACE2, 2, 57
    End If
  Else
    If IsUAD and ((not hasText(2, 57)) or (GetValue(2, 57) <> 0)) then
      AddRec IDFIREPLACENONE, 2, 57
    End If
  End If

  If hasText(2, 57) Then
    If IsUAD Then
      If GetValue(2, 57) > 0 Then
        Require IDFIREPLACE2CK, 2, 56
      End If
    Else
      Require IDFIREPLACE2CK, 2, 56
    End If
  End If

  If isChecked(2, 58) Then
    If IsUAD Then
      If (GetValue(2, 59) <= 0) Then
        AddRec IDSTOVES2, 2, 59
      End If
    Else
      Require IDSTOVES2, 2, 59
    End If
  Else
    If IsUAD and ((not hasText(2, 59)) or (GetValue(2, 59) <> 0)) then
      AddRec IDSTOVESNONE, 2, 59
    End If
  End If

  If hasText(2, 59) Then
    If IsUAD Then
      If GetValue(2, 59) > 0 Then
        Require IDSTOVES2CK, 2, 58
      End If
    Else
      Require IDSTOVES2CK, 2, 58
    End If
  End If

  If isChecked(2, 60) Then
    If IsUAD Then
      If (not hasText(2, 61)) or (GetText(2, 61) = "None") Then
        AddRec IDPATDECK2, 2, 61
      End If
    Else
      Require IDPATDECK2, 2, 61
    End If
  Else
    If IsUAD and (GetText(2, 61) <> "None") then
      AddRec IDPATDECKNONE, 2, 61
    End If
  End If

  If hasText(2, 61) Then
    If IsUAD Then
      If GetText(2, 61) <> "None" Then
        Require IDPATDECKCK, 2, 60
      End If
    Else
      Require IDPATDECKCK, 2, 60
    End If
  End If

  If isChecked(2, 62) Then
    If IsUAD Then
      If (not hasText(2, 63)) or (GetText(2, 63) = "None") Then
        AddRec IDPORCH2, 2, 63
      End If
    Else
      Require IDPORCH2, 2, 63
    End If
  Else
    If IsUAD and (GetText(2, 63) <> "None") then
      AddRec IDPORCH2NONE, 2, 63
    End If
  End If

  If hasText(2, 63) Then
    If IsUAD Then
      If GetText(2, 63) <> "None" Then
        Require IDPORCH2CK, 2, 62
      End If
    Else
      Require IDPORCH2CK, 2, 62
    End If
  End If

  If isChecked(2, 64) Then
    If IsUAD Then
      If (not hasText(2, 65)) or (GetText(2, 65) = "None") Then
        AddRec IDOTHER2, 2, 65
      End If
    Else
      Require IDOTHER2, 2, 65
    End If
  Else
    If IsUAD and (GetText(2, 65) <> "None") then
      AddRec IDOTHERNONE, 2, 65
    End If
  End If

  If hasText(2, 65) Then
    If IsUAD Then
      If GetText(2, 65) <> "None" Then
        Require IDOTHER2CK, 2, 64
      End If
    Else
      Require IDOTHER2CK, 2, 64
    End If
  End If

  OnlyOneCheckOfSix 2, 66, 67, 68, 69, 70, 71, IDAPPLIANCE, XXXXX

  checked = GetTextCheck(2, 73) + GetTextCheck(2, 74) + GetTextCheck(2, 75) + GetTextCheck(2, 77) + GetTextCheck(2, 78)
  if isChecked(2, 72) then
    if checked > 0 then AddRec IDCARNONE, 2, 72
  else
    if checked = 0 then AddRec IDCARERROR, 2, 72
  end if

  If isChecked(2, 73) Then
    Require IDGARNOCARS, 2, 76
  End If
  If IsUAD and hasText(3, 42) Then
    QTYg = 0
    QTYcv = 0
    QTYop = 0
    Text1 = GetText(3, 42)
    If (GetText(2, 76) <> "") Then
      If isChecked(2, 73) Then
        ItemLoc = InStr(1, Text1, "g")
        if (ItemLoc = 0) Then
          AddRec IDSUBGARAGEMISMATCH, 2, 73
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYg = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 1))
        End If
      End If
      If isChecked(2, 74) Then
        ItemLoc = InStr(1, Text1, "cv")
        if (ItemLoc = 0) Then
          AddRec IDSUBCARSTORAGECOVEREDMISMATCH, 2, 74
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYcv = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 2))
        End If
      End If
      If isChecked(2, 75) Then
        ItemLoc = InStr(1, Text1, "op")
        if (ItemLoc = 0) Then
          AddRec IDSUBCARSTORAGEOPENMISMATCH, 2, 75
        Else
          QtyTmp = Left(Text1, (ItemLoc - 1))
          If IsNumeric(QtyTmp) Then
            QTYop = CInt(QtyTmp)
          End If
          Text1 = Mid(Text1, (ItemLoc + 3))
        End If
      End If
      If GetValue(2, 76) <> QTYg + QTYcv + QTYop Then
        AddRec IDSUBCARSTORAGEQTY, 2, 76
      End If
    End If
  End If

  If isChecked(2, 73) Then
   OnlyOneCheckOfTwo 2, 77, 78, IDGARASSIGNOWN, XXXXX
  End If

  If isChecked(2, 77) Then
    Require IDGARSPACENO, 2, 79
  End If


  If isChecked(2, 78) Then
    Require IDGARSPACENO, 2, 79
  End If

  Require IDROOMCNT, 2, 80
  If GetCellUADError(2, 80) Then
    AddRec IDSUBROOMSUADERROR, 2, 80
  End If
  Require IDBEDCNT, 2, 81
  If GetCellUADError(2, 81) Then
    AddRec IDSUBBEDUADERROR, 2, 81
  End If
  Require IDBATHCNT, 2, 82
  If GetCellUADError(2, 82) Then
    AddRec IDSUBBATHSUADERROR, 2, 82
  End If

  Require IDGLA, 2, 83

  OnlyOneCheckOfTwo 2, 84, 85, IDHEATCOOLMETER, "HEAT/COOL SEP METERED: Both Yes and No are Checked"

  If isChecked(2, 85) Then
    Require IDHEATCOOLMETERCOM, 2, 86
  End If

  Require IDADDFEACONDo, 2, 87
  Require IDCONDITIONCONDO, 2, 88
  If GetCellUADError(2, 88) Then
    AddRec IDCONDUADERROR, 2, 88
  End If
  OnlyOneCheckOfTwo 2, 89, 90, IDADVERSE2, "PUD ADVERSE COND: Both Yes and No are Checked"

  If isChecked(2, 89) Then
    Require IDADVERSE, 2, 91
  End If

  OnlyOneCheckOfTwo 2, 92, 93, IDCONFORM2, "PUD CONFORMS TO NBHRD: Both Yes and No are Checked"

  If isChecked(2, 93) Then
    Require IDCONFORM, 2, 94
  End If

End Sub

Sub ReviewPriorSales
Dim GridIndex, FldCntr, CompAddrList, CompAddrSeq, num, num2, num3, num4

  AddTitle String(5, "=") + "FNMA 1073 " + IDPRIORSALES + String(5, "=")

  OnlyOneCheckOfTwo 2, 95, 96, IDRESEARCH2, "SALES/TRANSFER HISTORY RESEARCHED: Both Yes and No are Checked"

  If isChecked(2, 96) Then
   Require IDRESEARCH, 2, 97
  End If

  OnlyOneCheckOfTwo 2, 98, 99, IDRESEARCHSUB2, "SUBJECT RESEARCH RESULTS: Both Did and Did Not are Checked"
  Require IDRESEARCHSUB3, 2, 100
  OnlyOneCheckOfTwo 2, 101, 102, IDRESEARCHCOMP2, "COMP RESEARCH RESULTS: Both Did and Did Not are Checked"
  Require IDRESEARCHCOMP3, 2, 103
  'Only do the check if I did check box is checked for the SUBJECT
  If isChecked(2, 98) Then
    If Not hasText(2, 104) Then
      AddRec IDDATEPSTSUB, 2, 104
    Else
      If IsUAD and (not IsDateOK(2, 104)) then
        AddRec IDDATEPSTFMTSUBJ, 2, 104
      End If
    End If
    If GetCellUADError(2, 104) Then
      AddRec IDDATEPSTSUBUADERROR, 2, 104
    End If

    Require IDPRICEPSTSUB, 2, 105
    Require IDDATASOURCESUB, 2, 106
    Require IDDATASOURCEDATESUB, 2, 107
    If GetCellUADError(2, 107) Then
      AddRec IDDATASRCDATESUBUADERROR, 2, 107
    End If
  End If 'end of ischecked
  GridIndex = 0
  CompAddrList = Array(50,118,186)
  For FldCntr = 108 to 116 Step 4
    CompAddrSeq = CompAddrList(GridIndex)
    GridIndex = GridIndex + 1
    If (GetText(3, CompAddrSeq) <> "") or (GetText(3, (CompAddrSeq+1)) <> "") then
      If isChecked(2, 101) Then 'Only check if my research check box is checked for COMPS
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
      End If 'end of ischecked
	End If
  Next

  Require IDANALYSIS2, 2, 120

End Sub

Sub ReviewSalesSubject
Dim GridIndex, FldCntr, num, num2, num3, num4, text1, text2, text3, text4, text5

  AddTitle String(5, "=") + "FNMA 1073 " + IDSALESAPP + String(5, "=")

  Require IDFILENUM, 3, 2
  Require IDPROPCOMP, 3, 5
  Require IDPROPCOMPFROM, 3, 6
  Require IDPROPCOMPTO, 3, 7
  Require IDSALECOMP, 3, 8
  Require IDSALECOMPFROM, 3, 9
  Require IDSALECOMPTO, 3, 10
 
  Require IDSUBADD, 3, 11
  Require IDSUBCITY, 3, 12

    'Show warning if Settle date BEFORE contract date
  IsSettledDateBEFOREContractDate 3,63
  IsSettledDateBEFOREContractDate 3,131
  IsSettledDateBEFOREContractDate 3,199
  
  'Show error if Settle date is AFTER Effective date
  if not isUAD then
    IsSettledDateAFTEREffectiveDate 3, 21, 3, 269 'Subject  
  end if
  IsSettledDateAFTEREffectiveDate 3, 63, 3, 269  'Comp #1
  IsSettledDateAFTEREffectiveDate 3, 131, 3, 269 'Comp #2 
  IsSettledDateAFTEREffectiveDate 3, 199, 3, 269 'Comp #3 

  If hasText(3, 12) Then
    text1 = Replace(UCase(GetText(3, 12)), " ", "")
    text2 = Replace(UCase(GetText(1, 7)), " ", "")
    text3 = Replace(UCase(GetText(1, 8)), " ", "")
    text4 = Replace(UCase(GetText(1, 9)), " ", "")
    text5 = Replace(UCase(GetText(1, 10)), " ", "")
    If not text1 = text2 + IDCOMMA + text3 + IDCOMMA + text4 + text5 Then
      AddRec IDADDMATCH, 3, 12
    End If
    If GetCellUADError(3, 11) or GetCellUADError(3, 12) Then
      AddRec IDADDRESSUADERROR, 3, 11
    End If
  End If

  Require IDSUBNAME, 3, 13
  Require IDSUBPHASE, 3, 14

  If not isChecked(1, 34) Then
    Require IDSUBSALES, 3, 15
    Require IDSUBPRGLA, 3, 16
  End If


  
  Require IDSUBLOC, 3, 22
  If GetCellUADError(3, 22) Then
    AddRec IDSUBLOCUADERROR, 3, 22
  End If
  Require IDSUBLEASEHOLD, 3, 23
  Require IDSUBHOA, 3, 24
  Require IDSUBCOMELE, 3, 25
  Require IDSUBRECFAC, 3, 26
  Require IDSUBFLOORLOC, 3, 27
  Require IDSUBVIEW, 3, 28
  If GetCellUADError(3, 28) Then
    AddRec IDSUBVIEWUADERROR, 3, 28
  End If
  Require IDSUBDESIGN, 3, 29
  Require IDSUBQUAL, 3, 30
  If GetCellUADError(3, 30) Then
    AddRec IDSUBQUALUADERROR, 3, 30
  End If
  Require IDSUBAGE, 3, 31
  If GetCellUADError(3, 31) Then
    AddRec IDSUBAGEUADERROR, 3, 31
  End If

'PCV #27: Is the Actual Age below the Neighborhood Low range
SFHAGELOW = "**ACTUAL AGE IS BELOW INDICATED NEIGHBORHOOD LOW."
If hasText(3,31) then
   num = GetValue(3,31)
   If hasText(1,74) Then
      lnum = GetValue(1,74)
      If num < lnum Then
         AddRec SFHAGELOW,3,31
      End If
   End If
End If

  Require IDSUBCOND, 3, 32
  'Check Quality Condition between p1 cell 219 and p2 cell 27 make sure they are the same
  CheckQualityCondition 2, 88, 3, 32
  If GetCellUADError(3, 32) Then
    AddRec IDSUCONDUADERROR, 3, 32
  End If
  
'PCV #28: Is the Actual Age Above the Neighborhood High range
SFHAGEHIGH = "**ACTUAL AGE IS ABOVE INDICATED NEIGHBORHOOD HIGH."
If hasText(3,31) then
   num = GetValue(3,31)
   If hasText(1,75) Then
      hnum = GetValue(1,75)
      If num > hnum Then
         AddRec SFHAGEHIGH, 3,31
      End If
   End If
End If

'PCV #29: Make sure Subject condition is matched or bracketed by comparable condition.
'GSU_AG_COND = "**THE SUBJECT'S CONDITION IS NOT MATCHED BY THE COMPARABLES PRESENTED."
'isMatch = False
'If strComp(GetText(3,32), GetText(3,85)) = 0 Then   
'   isMatch = True
'End If
'   isMatch = True
'End If
'If strComp(GetText(3,32), GetText(3,219)) = 0 Then   
'   isMatch = True
'End If
'If not isMatch Then
'   AddRec  GSU_AG_COND, 3,32
'ENd If

'PCV #30: Is at least one comp the same condition of the subject?
'AG_COND123 = "**AT LEAST ONE COMP SHOULD BE IN THE SAME CONDITION AS THE SUBJECT. YOU MAY NEED TO EXPAND YOUR PARAMETERS TO INCLUDE AT LEAST ONE COMP IN YOUR REPORT IN SIMILAR CONDITION."
If hasText(3,32) Then 
'   If hasText(3,85) and strComp(GetText(3,32), GetText(3,85)) <> 0 Then
'       If hasText(3,153)  and (strComp(GetText(3,32), GetText(3,153)) <> 0) Then
'          If hasText(3,221)  and (strComp(GetText(3,32), GetText(3,221)) <> 0) Then
'             AddRec AG_COND123, 3,32
'          End If
'       End If
'   End If
End If

  Require IDSUBROOMS, 3, 33


  If GetCellUADError(3, 33) Then
    AddRec IDSUBROOMSUADERROR, 3, 33
  End If
  Require IDSUBBED, 3, 34
  If GetCellUADError(3, 34) Then
    AddRec IDSUBBEDUADERROR, 3, 34
  End If
  Require IDSUBBATHS, 3, 35
  If GetCellUADError(3, 35) Then
    AddRec IDSUBBATHSUADERROR, 3, 35
  End If
  Require IDSUBGLA, 3, 36
  Require IDSUBBASE, 3, 37
  If GetCellUADError(3, 37) Then
    AddRec IDSUBBASEUADERROR, 3, 37
  End If
  If not ((GetText(3, 37) = "0sf") or (GetText(3, 37) = "0sqm")) Then
    Require IDSUBBASEPER, 3, 38
  End If
  If GetCellUADError(3, 38) Then
    AddRec IDSUBBASEPERUADERROR, 3, 38
  End If
  Require IDSUBFUNC, 3, 39
  Require IDSUBHEAT, 3, 40
  Require IDSUBENERGY, 3, 41
  If not IsEnergyEfficientOK(3, 41) then
    AddRec IDSUBENERGYBAD, 3, 41
  End If
  Require IDSUBGARAGE, 3, 42
  If IsUAD and hasText(3, 42) Then
    Text1 = GetText(3, 42)
    num = InStr(1, Text1, "g")
    num2 = InStr(1, Text1, "cv")
    num3 = InStr(1, Text1, "op")
    num4 = 0
    num5 = 0
    If not NumOrderIsOK(num, num2, num3, num4, num5) Then
      AddRec IDSUBCONDOFORMAT, 3, 42
    End If
  End If
  Require IDSUBPORCH, 3, 43

' ////// Check if the comp's GLA is 20% more than the subject GLA
'PCV #31:  Compare Comp1 GLA with Subject GLA
IDCOMPGLA20RANGE1G  = " COMP 1 GLA HAS A VARIANCE OF MORE THAN 20% TO THAT OF THE SUBJECT."
IDCOMPGLA20RANGE1L   = " COMP 1 GLA HAS A VARIANCE OF LESS THAN 20% TO THAT OF THE SUBJECT."
If hasText(3,36)  and hasText(3,50) then  'we have subject GLA and comp1 exists
  if hasText(3,92) then 'we have comp GLA
    cGLA = GetValue(3,92)
    sGLA = GetValue(3,36)
    num = (cGLA - sGLA)/cGLA
    if (Abs(num) > 0.20) and (cGLA > sGLA)then
      AddRec IDCOMPGLA20RANGE1G, 3,92
    end if
    if (ABs(num) > 0.20) and (cGLA < sGLA) then
      AddRec IDCOMPGLA20RANGE1L, 3,92
    end If 
  end If
end If

' Compare Comp2 GLA with Subject GLA
IDCOMPGLA20RANGE2G  = " COMP 2 GLA HAS A VARIANCE OF MORE THAN 20% TO THAT OF THE SUBJECT."
IDCOMPGLA20RANGE2L   = " COMP 2 GLA HAS A VARIANCE OF LESS THAN 20% TO THAT OF THE SUBJECT."
If hasText(3,36) and hasText(3,118) then  'we have subject GLA and comp2 exists
  if hasText(3,160) then 'we have comp2 GLA
    cGLA = GetValue(3,160)
    sGLA = GetValue(3,36)
    num = (cGLA - sGLA)/cGLA
    if (Abs(num) > 0.20) and (cGLA > sGLA)then
      AddRec IDCOMPGLA20RANGE2G, 3,160
    end if
    if (ABs(num) > 0.20) and (cGLA < sGLA) then
      AddRec IDCOMPGLA20RANGE2L, 3,160
    end If 
  end If
end If

' Compare Comp3 GLA with Subject GLA
IDCOMPGLA20RANGE3G  = " COMP 3 GLA HAS A VARIANCE OF MORE THAN 20% TO THAT OF THE SUBJECT."
IDCOMPGLA20RANGE3L   = " COMP 3 GLA HAS A VARIANCE OF LESS THAN 20% TO THAT OF THE SUBJECT."
If hasText(3,36) and hasText(3,186) then  'we have subject GLA and comp3 exists
  if hasText(3,228) then 'we have comp3 GLA
    cGLA = GetValue(3,228)
    sGLA = GetValue(3,36)
    num = (cGLA - sGLA)/cGLA
    if (Abs(num) > 0.20) and (cGLA > sGLA)then
      AddRec IDCOMPGLA20RANGE3G, 3,228
    end if
    if (ABs(num) > 0.20) and (cGLA < sGLA) then
      AddRec IDCOMPGLA20RANGE3L, 3,228
    end If 
  end If
end If

 

'PCV #32: Make sure subject GLA is bracketed by  comp. gla.
'gSub = GetValue(3,36)
'gComp1 = GetValue(3,92)
'gComp2 = GetValue(3,160)
'gComp3 = GetValue(3,228)

'min=minof3(gComp1,gComp2,gComp3)
'max=maxof3(gComp1,gComp2,gComp3)

'is subject in the range of min and max?
IDTOBERANGE10 = "Sales Price is not within the comparable sales range."
IDTOBERANGEC4 = "Sales Price is not within the Condominium housing range."
IDTOBERANGE3 = "MARKET VALUE: The indicated Value by Sales Comparison Approach is outside the range of your Sales Comparables."
IDTOBERANGE2 = "MARKET VALUE: Value is not within the Sales Price of the Comparables."
'GSU_SF_GLA = "THE SUBJECT'S GLA IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
'If gSub < min or gSub > max Then  'out of range
'  AddRec GSU_SF_GLA, 3,36
'End If

'PCV #26: Make sure subject sales price is bracketed by  comp. sales price.
gSub = GetValue(3,268)
gComp1 = GetValue(3,55)
gComp2 = GetValue(3,123)
gComp3 = GetValue(3,191)

min=minof3(gComp1,gComp2,gComp3)
max=maxof3(gComp1,gComp2,gComp3)

If gSub < min or gSub > max Then  'out of range
  AddRec IDTOBERANGE3, 3, 55
End If



  GridIndex = 0
  For FldCntr = 50 to 186 Step 68
    GridIndex = GridIndex + 1
    If (GetText(3, (FldCntr)) <> "") or (GetText(3, (FldCntr+1)) <> "") then
      Require FormCompNumErrStr(IDCOMP1ADD, 0, GridIndex), 3, (FldCntr)
      Require FormCompNumErrStr(IDCOMP1UNITNO, 0, GridIndex), 3, (FldCntr+1)
      If GetCellUADError(3, (FldCntr)) or GetCellUADError(3, (FldCntr+1)) Then
        AddRec FormCompNumErrStr(IDCOMP1ADDRUADERROR, 0, GridIndex), 3, (FldCntr)
      End If
      Require FormCompNumErrStr(IDCOMP1NAME, 0, GridIndex), 3, (FldCntr+2)
      Require FormCompNumErrStr(IDCOMP1PHASE, 0, GridIndex), 3, (FldCntr+3)
      Require FormCompNumErrStr(IDCOMP1PROX, 0, GridIndex), 3, (FldCntr+4)
      Require FormCompNumErrStr(IDCOMP1SALES, 0, GridIndex), 3, (FldCntr+5)

      ' Check comp one-unit housing & comp sales ranges
      If hasText(3, (FldCntr+5)) Then
        num2 = GetValue(3, (FldCntr+5))
        num = num2 / 1000
        If num < GetValue(1, 71) Then
          AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 3, (FldCntr+5)
        Else
          If num > GetValue(1, 72) Then
            AddRec FormCompNumErrStr(IDTOBERANGE4, 0, GridIndex), 3, (FldCntr+5)
          End If
        End If
        If num2 < GetValue(3,9) Then
          AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 3, (FldCntr+5)
        Else
          If num2 > GetValue(3,10) Then
            AddRec FormCompNumErrStr(IDTOBERANGE10, 0, GridIndex), 3, (FldCntr+5)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1PRGLA, 0, GridIndex), 3, (FldCntr+6)
      Require FormCompNumErrStr(IDCOMP1SOURCE, 0, GridIndex), 3, (FldCntr+7)
      If GetCellUADError(3, (FldCntr+7)) Then
        AddRec FormCompNumErrStr(IDCOMP1DATASRCUADERROR, 0, GridIndex), 3, (FldCntr+7)
      End If
      Require FormCompNumErrStr(IDCOMP1VER, 0, GridIndex), 3, (FldCntr+8)
      Require FormCompNumErrStr(IDCOMP1SF, 0, GridIndex), 3, (FldCntr+9)
      If GetCellUADError(3, (FldCntr+9)) Then
        AddRec FormCompNumErrStr(IDCOMP1SFUADERROR, 0, GridIndex), 3, (FldCntr+9)
      End If
      Require FormCompNumErrStr(IDCOMP1CONC, 0, GridIndex), 3, (FldCntr+11)
      If GetCellUADError(3, (FldCntr+11)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONCUADERROR, 0, GridIndex), 3, (FldCntr+11)
      End If
      Require FormCompNumErrStr(IDCOMP1DOS, 0, GridIndex), 3, (FldCntr+13)
      If GetCellUADError(3, (FldCntr+13)) Then
        AddRec FormCompNumErrStr(IDCOMP1DOSUADERROR, 0, GridIndex), 3, (FldCntr+13)
      End If
      Require FormCompNumErrStr(IDCOMP1LOC, 0, GridIndex), 3, (FldCntr+15)
      If GetCellUADError(3, (FldCntr+15)) Then
        AddRec FormCompNumErrStr(IDCOMP1LOCUADERROR, 0, GridIndex), 3, (FldCntr+15)
      End If
      Require FormCompNumErrStr(IDCOMP1LEASEHOLD, 0, GridIndex), 3, (FldCntr+17)
      Require FormCompNumErrStr(IDCOMP1HOA, 0, GridIndex), 3, (FldCntr+19)
      Require FormCompNumErrStr(IDCOMP1COMELE, 0, GridIndex), 3, (FldCntr+21)
      Require FormCompNumErrStr(IDCOMP1RECFAC, 0, GridIndex), 3, (FldCntr+23)
      Require FormCompNumErrStr(IDCOMP1FLOORLOC, 0, GridIndex), 3, (FldCntr+25)
      Require FormCompNumErrStr(IDCOMP1VIEW, 0, GridIndex), 3, (FldCntr+27)
      If GetCellUADError(3, (FldCntr+27)) Then
        AddRec FormCompNumErrStr(IDCOMP1VIEWUADERROR, 0, GridIndex), 3, (FldCntr+27)
      End If
      Require FormCompNumErrStr(IDCOMP1DESIGN, 0, GridIndex), 3, (FldCntr+29)
      Require FormCompNumErrStr(IDCOMP1QUAL, 0, GridIndex), 3, (FldCntr+31)
      If GetCellUADError(3, (FldCntr+31)) Then
        AddRec FormCompNumErrStr(IDCOMP1QUALUADERROR, 0, GridIndex), 3, (FldCntr+31)
      End If
      Require FormCompNumErrStr(IDCOMP1AGE, 0, GridIndex), 3, (FldCntr+33)
      If GetCellUADError(3, (FldCntr+33)) Then
        AddRec FormCompNumErrStr(IDCOMP1AGEUADERROR, 0, GridIndex), 3, (FldCntr+33)
      End If
      Require FormCompNumErrStr(IDCOMP1COND, 0, GridIndex), 3, (FldCntr+35)
      If GetCellUADError(3, (FldCntr+35)) Then
        AddRec FormCompNumErrStr(IDCOMP1CONDUADERROR, 0, GridIndex), 3, (FldCntr+35)
      End If
      Require FormCompNumErrStr(IDCOMP1ROOMS, 0, GridIndex), 3, (FldCntr+38)
      If GetCellUADError(3, (FldCntr+38)) Then
        AddRec FormCompNumErrStr(IDCOMP1ROOMSUADERROR, 0, GridIndex), 3, (FldCntr+38)
      End If
      Require FormCompNumErrStr(IDCOMP1BED, 0, GridIndex), 3, (FldCntr+39)
      If GetCellUADError(3, (FldCntr+39)) Then
        AddRec FormCompNumErrStr(IDCOMP1BEDUADERROR, 0, GridIndex), 3, (FldCntr+39)
      End If
      Require FormCompNumErrStr(IDCOMP1BATHS, 0, GridIndex), 3, (FldCntr+40)
      If GetCellUADError(3, (FldCntr+40)) Then
        AddRec FormCompNumErrStr(IDCOMP1BATHSUADERROR, 0, GridIndex), 3, (FldCntr+40)
      End If

      Require FormCompNumErrStr(IDCOMP1GLA, 0, GridIndex), 3, (FldCntr+42)
      ' Check if the comp's GLA is 20% more than the subject GLA
      If hasText(3, 36) and hasText(3, (FldCntr+42)) then  'we have subject & comp GLA
        cGLA = GetValue(3, (FldCntr+42))
        sGLA = GetValue(3, 36)

        If sGLA > 0 then
          num = (cGLA - sGLA)/sGLA
          If (Abs(num) > 0.20) and (cGLA > sGLA)then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1G, 0, GridIndex), 3, (FldCntr+42)
          End If
          If (ABs(num) > 0.20) and (cGLA < sGLA) then
            AddRec FormCompNumErrStr(IDCOMPGLA20RANGE1L, 0, GridIndex), 3, (FldCntr+42)
          End If
        End If
      End If

      Require FormCompNumErrStr(IDCOMP1BASE, 0, GridIndex), 3, (FldCntr+44)
      If GetCellUADError(3, (FldCntr+44)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEUADERROR, 0, GridIndex), 3, (FldCntr+44)
      End If

      If not ((GetText(3, (FldCntr+44)) = "0sf") or (GetText(3, (FldCntr+44)) = "0sqm")) Then
        Require FormCompNumErrStr(IDCOMP1BASEPER, 0, GridIndex), 3, (FldCntr+46)
      End If
      If GetCellUADError(3, (FldCntr+46)) Then
        AddRec FormCompNumErrStr(IDCOMP1BASEPERUADERROR, 0, GridIndex), 3, (FldCntr+46)
      End If
      Require FormCompNumErrStr(IDCOMP1FUNC, 0, GridIndex), 3, (FldCntr+48)
      Require FormCompNumErrStr(IDCOMP1HEAT, 0, GridIndex), 3, (FldCntr+50)
      Require FormCompNumErrStr(IDCOMP1ENERGY, 0, GridIndex), 3, (FldCntr+52)
      If not IsEnergyEfficientOK(3, (FldCntr+52)) then
        AddRec FormCompNumErrStr(IDCOMP1ENERGYBAD, 0, GridIndex), 3, (FldCntr+52)
      End If
      Require FormCompNumErrStr(IDCOMP1GARAGE, 0, GridIndex), 3, (FldCntr+54)
      If IsUAD and hasText(3, (FldCntr+54)) Then
        Text1 = GetText(3, (FldCntr+54))
        num = InStr(1, Text1, "g")
        num2 = InStr(1, Text1, "cv")
        num3 = InStr(1, Text1, "op")
        num4 = 0
        num5 = 0
        If not NumOrderIsOK(num, num2, num3, num4, num5) Then
          AddRec FormCompNumErrStr(IDCOMP1CONDOFORMAT, 0, GridIndex), 3, (FldCntr+54)
        End If
      End If
      Require FormCompNumErrStr(IDCOMP1PORCH, 0, GridIndex), 3, (FldCntr+56)
      If hasText(3, (FldCntr+67)) Then
        num = GetValue(3, (FldCntr+67)) / 1000
        If num < GetValue(1, 71) Then
          AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 3, (FldCntr+67)
        Else
          If num > GetValue(1, 72) Then
            AddRec FormCompNumErrStr(IDTOBERANGE5, 0, GridIndex), 3, (FldCntr+67)
          End If
        End If
      End If
    End If
  Next

  Require IDSUMMARYSALES, 3, 254

  If Not hasText(3, 255) Then
    AddRec IDTOBE, 3, 255
  End If

End Sub


Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "FNMA 1073 " + IDINCOME + String(5, "=")   
  
  Require IDINCOMERENT2, 3, 256
  Require IDINCOMEGRM2, 3, 257
  Require IDINCOMEVALUE2, 3, 258
  Require IDSUMMARYINCOME, 3, 259
  
'PCV #33: The range of Indicated Values is greater than 20% suggesting either inadequate choice of comparables or analysis on the market grid.
SCMINDVALUE = "THE RANGE OF INDICATED VALUES IS GREATER THAN 20% SUGGESTING EITHER POOR COMP SELECTION OR INADEQUATE ANALYSIS AND/OR POSSIBLY MISSED ADJUSTMENTS."
If hasText(3,260) and (hasText(3,55) or hasText(3,123) or hasText(3,191)) Then
   Sale1 = GetValue(3,55) * 0.2 + GetValue(3,55)
   Sale2 = GetValue(3,123) * 0.2 + GetValue(3,123)
   Sale3 = GetValue(3, 191) * 0.2 + GetValue(3,191)
   SubIndValue = GetValue(3,260)
  is_exceed = false
  If (GetValue(3,55) > 0)  and (SubIndValue > Sale1) Then
       is_exceed = true
  End If
  If (GetValue(3,123) > 0) and (SubIndValue > Sale2) Then
       is_exceed = true
  End If
  If (GetValue(3,191) > 0) and (SubIndValue > Sale3) Then
       is_exceed = true
  End If
  If is_exceed Then
    AddRec SCMINDVALUE, 3, 260 
  End If 
End If


End Sub


Sub ReviewReconciliation

  AddTitle String(5, "=") + "FNMA 1073 " + IDRECON + String(5, "=")

  If Not hasText(3, 260) Then
    AddRec IDTOBE, 3, 260
  End If

  Require IDINCOMEVALUE2, 3, 261
  OnlyOneCheckOfFour 3, 263, 264, 265, 266, IDSTATUSNOCHK, IDSTATUSCHK

  If isChecked(3, 265) Then
    Require IDCONDCOMM, 3, 267
  End If

  If isChecked(3, 266) Then
    Require IDCONDCOMM, 3, 267
  End If

  If Not hasText(3, 268) Then
    AddRec IDTOBE, 3, 268
  End If

  Require IDASOF, 3, 269

End Sub
