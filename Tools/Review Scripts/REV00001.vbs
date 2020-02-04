'FM00001.vbs URAR Reviewer Script
01/30/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 2
cmpBase = 61
cmpOffset = 60

Function GetAdjString(n)
  Select Case n
    case	1 GetAdjString = IDSALESORFIN
    case	2 GetAdjString = IDCONCESSIONS
    case	3 GetAdjString = IDDATEOFSALE
    case	4 GetAdjString = IDLOC
    case	5 GetAdjString = IDLEASE
    case	6 GetAdjString = IDGRIDSITE
    case	7 GetAdjString = IDGRIDVIEW
    case	8 GetAdjString = IDGRIDDESIGN
    case	9 GetAdjString = IDQUAL
    case	10 GetAdjString = IDGRIDAGE
    case	11 GetAdjString = IDCONDITION
    case	12 GetAdjString = IDABOVEGRADE
    case	13 GetAdjString = IDROOMCOUNT
    case	14 GetAdjString = IDGRIDGLA
    case	15 GetAdjString = IDGRIDBASEMENT
    case	16 GetAdjString = IDBELOW
    case	17 GetAdjString = IDFUNC
    case	18 GetAdjString = IDHEAT
    case	19 GetAdjString = IDENERGY
    case	20 GetAdjString = IDGARAGE
    case	21 GetAdjString = IDPORCH
    case	22 GetAdjString = IDFIRE
    case	23 GetAdjString = IDFENCE
    case	24 GetAdjString = IDOTHER
  end Select
end function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9,10,11 GetAdjCell = 8 + (n - 1)*2
    case 12  GetAdjCell = 29
    case 13,14,15,16,17,18,19,20,21,22,23,24   GetAdjCell = 9 + (n-1)*2
  end Select
end Function

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewNeighbAnalysis
  AddTitle ""
  ReviewPud
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewRoomList
  AddTitle ""
  ReviewInterior
  AddTitle ""
  ReviewImprovComments
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewSalesApproach
  AddTitle ""
  ReviewIncomeApproach
  AddTitle ""
  ReviewSalesComments
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
end Sub

Sub ReviewSubject
  AddTitle String(5, "=") + "FNMA 1004 " + IDSUBJECT + String(5, "=")
  if not hasText(1,3) then  AddRec IDFilenum,1,3
  if not hasText(1,6) then  AddRec IDAddress,1,6
	if not hasText(1,7) then  AddRec IDCity,1,7
 	if not hasText(1,8) then  AddRec IDState,1,8
	if not hasText(1, 9) then AddRec IDZip,1,9
	if not hasText(1, 10) then AddRec IDLegal,1,10
	if not hasText(1, 11) then AddRec IDCounty,1,11
	if not hasText(1, 12) then AddRec IDAPN,1,12
	if not hasText(1, 13) then AddRec IDTaxYear,1,13
	if not hasText(1, 14) then AddRec IDReTaxes,1,14
	if not hasText(1, 15) then AddRec IDSpecial,1,15
	if not hasText(1, 16) then AddRec IDBorrower,1,16
	if not hasText(1, 17) then AddRec IDCurOwn,1,17

  checked = GetCheck(1,18) + GetCheck(1,19) + GetCheck(1,20)
  if checked = 0 then AddRec IDOccNoCheck,1,18
  if checked > 1 then AddRec IDOccChk,1,18

  checked1 = GetCheck(1,21) + GetCheck(1,22)
  checked2 = GetCheck(1,23) + GetCheck(1,24)
  if isChecked(1,23) and (checked1 = 0) then  AddRec IDPudChk,1,23
  if (checked2 > 0) and (not hasText(1, 25)) then AddRec IDHOA,1,25
  if (checked1 = 0) and (checked2 = 0) then  AddRec IDPropNoChk,1,21

  if checked2 > 1 then AddRec IDPropChk,1,21		

	if not hasText(1, 26) then AddRec IDProjName,1,26
	if not hasText(1, 27) then AddRec IDMapref,1,27
	if not hasText(1, 28) then AddRec IDCensus,1,28

	if not hasText(1, 29) then
	  AddRec IDSalesPrice,1,29
	else
	 		price = GetValue(1, 29)/1000
	    if (price > GetValue(1, 62)) or (price < GetValue(1, 61)) and not isnegativecomment(1, 29) then
	      AddRec IDSubSalesRng,1,61
      end if
  end if
  if StrComp(GetText(2,33),GetText(1,29)) <> 0 then AddRec IDSalesPriceComp,1,29
  if not hasText(1, 30) then AddRec IDDate,1,30
	if not hasText(1, 31) then AddRec IDLoan,1,31
	if not hasText(1, 32) then AddRec IDLender,1,32
	if not hasText(1, 33) then AddRec IDLenderAdd,1,33
end Sub

Sub ReviewNeighborhood
  AddTitle String(5, "=") + "FNMA 1004 " + IDNeigh + String(5, "=")
  checked = GetCheck(1,36) + GetCheck(1,37) + GetCheck(1,38)
  if checked = 0 then AddRec IDLocNoChk,1,36
	if checked > 1 then AddRec IDLocChk,1,36
  checked = GetCheck(1,40) + GetCheck(1,41) + GetCheck(1,42)
  if checked = 0 then AddRec IDBuiltNoChk,1,40
  if checked > 1 then AddRec IDBuiltChk,1,40
	sum = GetValue(1, 67) + GetValue(1, 68) + GetValue(1, 69) + GetValue(1, 70) + GetValue(1, 72)
  	if sum <> 100 then	AddRec IDLandUse,1,67

	result = 100 - sum		
	if isChecked(1, 40) then		'	BuiltUp over 75%
    		if result >= 25 then	AddRec IDOver75,1,40
	end if

	if isChecked(1, 41) then
    		if(result > 75) or (result < 25) then	AddRec ID2575,1,41
  	end if

  	if isChecked(1, 42) then
    		if result <= 75 then	AddRec IDUnder25,1,42
  	end if

  checked = GetCheck(1,43) + GetCheck(1,44) + GetCheck(1,45)
  if checked = 0 then	AddRec IDGrowthNoChk,1,43
  if checked > 1 then	AddRec IDGrowthChk,1,43

  checked = GetCheck(1,46) + GetCheck(1,47) + GetCheck(1,48)
  if checked = 0 then AddRec IDPrpValNoChk,1,46
	if checked > 1 then AddRec IDPrpValChk,1,46

  checked = GetCheck(1,49) + GetCheck(1,50) + GetCheck(1,51)
  if checked = 0 then AddRec IDDemandNoChk,1,49
	if checked > 1 then AddRec IDDemandChk,1,49

  checked = GetCheck(1,52) + GetCheck(1,53) + GetCheck(1,54)
  if checked = 0 then AddRec IDMarketNoChk,1,52
	if checked > 1 then AddRec IDMarketChk,1,52
  if isChecked(1,52) and (isChecked(1,48) or isChecked(1,51)) then AddRec IDMarketUnder,1,52
  if isChecked(1,54) and (isChecked(1,46) or isChecked(1,49)) then AddRec IDMarketOver,1,52		

  nChecks = GetCheck(1,38) + GetCheck(1,42) + GetCheck(1,45) + GetCheck(1,48) + GetCheck(1,51) + Getcheck(1,54)
  if nChecks > 0 then AddRec IDRComment,1,38

  if hasText(1, 70) then
		if (not hasText(2, 23)) and (not hasText(2, 24)) then AddRec IDComLand,1,70
  end if

  checked = GetCheck(1,73) + GetCheck(1,74) + GetCheck(1,75)
  if checked = 0 then AddRec IDLandNoChk,1,73
	if checked > 1 then AddRec IDLandChk,1,73
  if (isChecked(1,74) or isChecked(1,75)) and (not hasText(1,76)) then AddRec IDLandChange,1,73

  checked = GetCheck(1,55) + GetCheck(1,57)
  if checked = 0 then AddRec IDOCCUPANCY,1,55
	if checked > 1 then AddRec IDOCCUPANCYCK,1,55

  checked = GetCheck(1,59) + GetCheck(1,60)
  if checked = 0 then AddRec IDOccVaN,1,59
	if checked > 1 then AddRec IDOccVacChk,1,59

  if not hasText(1, 61) then AddRec IDLowPrice,1,61
  if not hasText(1, 62) then AddRec IDHighPrice,1,62
  if hasText(1, 61) and hasText(1, 62) and  (GetValue(1, 62) < GetValue(1, 61)) then AddRec IDPriceCK,1,61
  if not hasText(1, 63) then AddRec IDPredPrice,1,63
  num = GetValue(1, 63)
	if (num > GetValue(1, 62)) or (num < GetValue(1, 61)) then AddRec IDPriceRange,1,61

  if not hasText(1, 64) then AddRec IDLowAge,1,64
  if not hasText(1, 65) then AddRec IDHighAge,1,65
  if hasText(1, 64) and hasText(1, 65) and  (GetValue(1, 65) < GetValue(1, 64)) then AddRec IDAgeCK,1,64
  if not hasText(1, 66) then AddRec IDPredAge,1,66
  num = GetValue(1, 66)
	if (num > GetValue(1, 65)) or (num < GetValue(1, 64)) then AddRec IDAgeRange,1,65

end Sub

Sub ReviewNeighbAnalysis
  AddTitle String(5, "=") + "FNMA 1004 " + IDNeighComm + String(5, "=")

	if not hasText(1, 77) then AddRec IDNEIGHCHAR,1,77
    if not hasText(1, 78) then AddRec IDNEIGHMARKET, 1,78
	if not hasText(1, 79) then AddRec IDNEIGHCOND, 1,79
end Sub

Sub ReviewPUD
  AddTitle String(5, "=") + "FNMA 1004 " + IDPUD + String(5, "=")

	checked = GetCheck(1,80) + GetCheck(1,81)
 	if checked = 0 then
		if isChecked(1, 23)then
			AddRec IDPUDDEV, 1, 80
		end if
	end if
	if checked > 0 then
	  	if not isChecked(1, 23) then
			AddRec IDPUDDEVBADCHK, 1,23
		end if
	end if
	if checked > 1  then AddString IDPUDCHECKED, 1,80

	if not hasText(1, 82)then
		if isChecked(1, 23) then
			AddRec IDPUDUNIT, 1,82
		end if
	 else
		 if not isChecked(1, 23)then
		 	AddRec IDPUDUNITBAD, 1,23
		 end if
	end if

	if not hasText(1, 83) then
    	if isChecked(1, 23) then
			AddRec IDPUDSUBUNIT,1,83
		end if
	 else
		  if not isChecked(1, 23) then
			AddRec IDPUDSUBBAD, 1,23
		end if
	end if

	if not hasText(1, 84)then
    	if isChecked(1, 23) then
			AddRec IDPUDELE, 1,84
		end if
	 else
		  if  not isChecked(1, 23) then
		  	AddRec IDPUDELEBAD, 1,23
		   end if
	 end if
end Sub

Sub ReviewSite
  AddTitle String(5, "=") + "FNMA 1004 " + IDSITE + String(5, "=")

 	if not hasText(1, 85) then AddRec IDDIMEN, 1,85
	if not hasText(1, 86) then
    AddRec IDSITEAREA,1,86
	else
  	if strComp(GetText(2,39), GetText(1, 86)) <> 0 then
		  AddRec IDSITECOMPARE,1,86
    end if
  end if

	  checked = GetCheck(1, 87) + GetCheck(1, 88)
	  if checked = 0 then AddRec IDCORNERNOCK,1,87
		if checked > 1 then AddRec IDCORNERCK,1,87

	  if not hasText(1, 89) then AddRec IDZONINGCLAS,1,89

    checked = GetCheck(1,90) + GetCheck(1,91) + GetCheck(1,92) + GetCheck(1,93)
    if isChecked(1, 91) then AddRec IDNONCOFORM,1,91
		if isChecked(1, 92) then AddRec IDILLEGAL,1,92
		if isChecked(1, 93) then AddRec IDNOZONE,1,93
		if checked = 0 then AddRec IDZONINGCOM, 1,90
  	if checked > 1 then AddRec IDZONINGNOCHK,1,90

	  checked = GetCheck(1,94) + GetCheck(1,95)
		if isChecked(1, 95) then
	  	if not hasText(1, 96) then
	  	  AddRec IDOTHERUSE,1,96
		  end if
    end if
	  if checked = 0 then AddRec IDHIGHNOCK,1,94
  	if checked > 1 then AddRec IDHIGHBESTCK,1,94

    if hasText(1, 98) then
      if isChecked(1,97) then
	  	  AddRec IDELECCK,1,97
	    end if
		  AddRec IDELECCOMM,1,98	'	but it does have a comment  ????????????
  	else
	    if not isChecked(1,97) then
	  	  AddRec IDELECNOCK,1,97
      end if
    end if

    if hasText(1, 100) then
      if isChecked(1,99) then
	  	  AddRec IDGASCK,1,99
	    end if
		  AddRec IDGASCOMM,1,100	'	but it does have a comment  ????????????
  	else
	    if not isChecked(1,99) then
	  	  AddRec IDGASNOCK,1,99
      end if
    end if

    if hasText(1, 102) then
      if isChecked(1,101) then
	  	  AddRec IDWATERCK,1,101
	    end if
		  AddRec IDWATERCOMM,1,102
  	else
	    if not isChecked(1,101) then
	  	  AddRec IDWATERNOCK,1,101
      end if
    end if

    if hasText(1, 104) then
      if isChecked(1,103) then
	  	  AddRec IDSANCK,1,103
	    end if
		  AddRec IDSANCOMM,1,104
  	else
	    if not isChecked(1,103) then
	  	  AddRec IDSANNOCK,1,103
      end if
    end if

    if hasText(1, 106) then
      if isChecked(1,105) then
	  	  AddRec IDSTORMCK,1,105
	    end if
		  AddRec IDSTORMCOMM,1,106
  	else
	    if not isChecked(1,105) then
	  	  AddRec IDSTORMNOCK,1,105
      end if
    end if


	if not hasText(1, 107) then AddRec IDSTREETTYPE,1,107
  checked = GetCheck(1,108) + GetCheck(1,109)
	if isChecked(1, 109) then AddRec IDSTREETPRIV, 1,109
	if checked = 0 then AddRec IDSTREETNOCK,1,108
	if checked > 1 then AddRec IDCURBTYPE,1,108

	checked = GetCheck(1,111) + GetCheck(1,112)
	if isChecked(1, 112) then AddRec IDCURBNOCHK,1,112
	if checked = 0 then AddRec IDCURBCK,1,111
	if checked > 1 then AddRec IDSIDETYPE,1,111

	if not hasText(1, 113) then AddRec IDSIDEPRIV, 1,113
	checked = GetCheck(1,114) + GetCheck(1,115)
	if isChecked(1, 115) then AddRec IDSIDENOCK,1,114
	if checked = 0 then AddRec IDSIDECK,1,114
	if checked > 1 then AddRec IDSTREETCK,1,114

	if not hasText(1, 116) then AddRec IDLIGHTTYPE,1,116
	checked = GetCheck(1,117) + GetCheck(1,118)
	if isChecked(1, 118) then AddRec IDLIGHTPRIV,1,117
	if checked = 0 then AddRec IDLIGHTNOCK,1,117
	if checked > 1 then AddRec IDLIGHTCK,1,117

	if not hasText(1, 122) then AddRec IDTOPOGRAPHY,1,122
	if not hasText(1, 123) then AddRec IDSIZE,1,123
	if not hasText(1, 124) then AddRec IDSHAPE,1,124
	if not hasText(1, 125) then AddRec IDDRAINAGE,1,125
	if not hasText(1, 126) then
    AddRec IDVIEW,1,126
	else
	  if strComp(GetText(2,40),GetText(1, 126)) <> 0 then AddRec IDVIEWCOMPARE,1,126
  end if
  if not hasText(1, 127) then AddRec IDLANDSCAPING,1,127
	if not hasText(1, 128) then AddRec IDDRVSURFACE,1,128
	if not hasText(1, 129) then AddRec IDEASEMENTS,1,129

	if isChecked(1, 130) then
	  if not hasText(1, 132) then AddRec IDFEMAZONE,1,132
		if not hasText(1, 133) then AddRec IDFEMADATE,1,133
		if not hasText(1, 134) then AddRec IDFEMAMAP,1,134
  end if
	checked = GetCheck(1,130) + GetCheck(1,131)
	if checked = 0 then AddRec IDFEMANOCK,1,130
	if checked > 1 then AddRec IDFEMACK,1,130

	if not hasText(1, 135) then AddRec IDSITECOMMENTS,1,135

end Sub

Sub ReviewImprovements
  AddTitle String(5, "=") + "FNMA 1004 " + IDIMPROV + String(5, "=")
	if not hasText(1, 136) then AddRec INUNITS,1,136
	if not hasText(1, 137) then AddRec IDSTORIES,1,137
	if not hasText(1, 138) then AddRec IDTYPE,1,138
	if not hasText(1, 139) then AddRec IDDESIGN,1,139
	if not hasText(1, 140) then AddRec IDEXISTING,1,140
	if not hasText(1, 141) then
	  AddRec IDAGE,1,141
	else
	  age = GetValue(1, 141)
	  if (age > GetValue(1, 65)) or (age < GetValue(1, 64)) then AddRec IDSUBAGERANGE,1,141
  end if
	if strComp(GetText(2,41), GetText(1, 139)) <> 0 then AddRec IDAGECMP,1,139
	if not hasText(1, 142) then  AddRec IDEFFAGE,1,142
	if not hasText(1, 143) then AddRec IDFOUNDATION,1,143
	if not hasText(1, 144) then AddRec IDEXT,1,144
	if not hasText(1, 145) then AddRec IDROOFSUF,1,145
	if not hasText(1, 146) then AddRec IDGUTTER,1,146
	if not hasText(1, 147) then AddRec IDWINDOWTYPE,1,147
	if not hasText(1, 148) then AddRec IDSTORMSCR,1,148
	if not hasText(1, 149) then AddRec IDMANU,1,149
	if not hasText(1, 150) then AddRec IDSLAB,1,150
	if not hasText(1, 151) then AddRec IDCRAWL,1,151
 	if not hasText(1, 152) then AddRec IDBASEMENT,1,152
	if not hasText(1, 153) then AddRec IDSUMP,1,153
	if not hasText(1, 154) then AddRec IDDAMPNESS,1,154
	if not hasText(1, 155) then AddRec IDSETTLEMENT,1,155
  if not hasText(1, 156) then AddRec IDINFEST,1,156
	if not hasText(1, 157) then AddRec IDBASEAREA,1,157
	if not hasText(1, 158) then AddRec IDBASEFIN,1,158
	if not hasText(1, 159) then AddRec IDBASECEILING,1,159
	if not hasText(1, 160)  then AddRec IDBASEWALLS,1,160
	if not hasText(1, 161) then AddRec IDBASEFLOOR,1,161
	if not hasText(1, 162) then AddRec IDBASEOUTSIDE,1,162

end Sub

Sub ReviewRoomList
  AddTitle String(5, "=") + "FNMA 1004 " + IDROOMLIST + String(5, "=")
	if not hasText(1, 227) then
    AddRec IDROOMCNT,1,227
	else
	  if strComp(GetText(2,46), GetText(1, 227)) <> 0 then AddRec IDROOMCMP,1,227
  end if

	if not hasText(1, 228) then
	  AddRec IDBEDCNT,1,228
	else
		if strComp(GetText(2, 47), GetText(1, 228)) <> 0 then AddRec IDBEDCMP,1,228
  end if

	if not hasText(1, 229) then
    AddRec IDBATHCNT, 1,229
	else
		if strComp(GetText(2, 48), GetText(1, 229)) <> 0 then AddRec IDBATHCMP,1,229
  end if

  if not hasText(1, 230) then
    AddRec IDGLA,1,230
	else
		if strComp(GetText(2, 49), GetText(1, 230)) <> 0 then AddRec IDGLACMP,1,230
  end if

end Sub

Sub ReviewInterior
  AddTitle String(5, "=") + "FNMA 1004 " + IDCAR + String(5, "=")
	if not hasText(1, 231) then AddRec IDFLOOR,1,231
	if not hasText(1, 232) then AddRec IDWALLS,1,232
	if not hasText(1, 233) then AddRec IDTRIM,1,233
	if not hasText(1, 234) then AddRec IDBATHFLOOR,1,234
	if not hasText(1, 235) then AddRec IDWAINSCOT,1,235
	if not hasText(1, 236)  then AddRec IDDOORS, 1,236
	if not hasText(1, 239) then AddRec IDHEATTYPE,1,239
	if not hasText(1, 240) then AddRec IDHEATFUEL,1,240
	if not hasText(1, 241) then AddRec IDHEATCOND,1,241
	if not hasText(1, 244) then AddRec IDCOOLCOND,1,244

	checked = GetCheck(1, 253) + GetCheck(1, 254) + GetCheck(1,255) + GetCheck(1, 256) + GetCheck(1, 257) + GetCheck(1, 258)
	if isChecked(1, 252) then
     if checked > 0 then AddRec IDATTICNONE, 1,252
  else
	  if checked = 0 then AddRec IDATTICNOCK,1,252
  end if

	if not hasText(1, 259) then AddRec IDFIREPLACE,1,259

  checked = GetTextCheck(1, 276)+ GetTextCheck(1, 277) + GetTextCheck(1, 278)
  if hasText(1, 275) then
    if checked <> 1 then AddRec IDCARGAR,1,275
  else
  	if checked > 0 then AddRec IDCARNOGAR,1,275
  end if
  checked = checked + GetTextCheck(1,275) + GetTextCheck(1, 279) + GetTextCheck(1, 280)
	if isChecked(1, 274) then
		if checked > 0 then AddRec IDCARNONE,1,274
  else
  	if checked = 0 then AddRec IDCARERROR,1,274
  end if

end Sub

Sub ReviewImprovComments
  AddTitle String(5, "=") + "FNMA 1004 " + IDIMPROVCOMM + String(5, "=")
	if not hasText(1, 281) then AddRec IDADD,1,281
	if not hasText(1, 282) then AddRec IDCOND,1,282
	if not hasText(1, 283) then AddRec IDADVERSE,1,283
end Sub

Sub ReviewCostApproach
  AddTitle String(5, "=") + "FNMA 1004 " + IDCOSTAPP + String(5, "=")
	if not hasText(2, 5) then AddRec IDCOSTSITE,2,5
  if not hasText(2, 18) then AddRec IDCOSTTOTAL,2,18
  if not hasText(2, 26) then AddRec IDCOSTVALUE,2,26
 	if not hasText(2, 27) then AddRec IDCOSTASIS,2,27
  if not hasText(2, 28) then AddRec IDCOSTINVAL,2,28
	if not hasText(2, 29)  then AddRec IDCOSTCOMM,2,29

end Sub

Sub ReviewSalesApproach
  ReviewSalesSubject
  for pageCmpNo = 1 to 3
    cmpNo = GetCmpNo(pageCmpNo)
    ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
  next
end Sub

Sub ReviewSalesSubject
  AddTitle String(5, "=") + "FNMA 1004 " + IDSALESAPP + String(5, "=")
	if not hasText(2, 31) then AddRec IDSUBADD,2,31
	if not hasText(2, 32) then AddRec IDSUBCITY,2,32
	if not hasText(2, 33) then AddRec IDSUBSALES,2,33
	if not hasText(2, 34) then AddRec IDSUBPRGLA,2,34
	if not hasText(2, 35) then AddRec IDSUBDATA,2,35
	if not hasText(2, 36) then AddRec IDSUBVER,2,36
	if not hasText(2, 37) then AddRec IDSUBLOC,2,37
	if not hasText(2, 38) then AddRec IDSUBLEASE,2,38
	if not hasText(2, 39) then AddRec IDSUBSITE,2,39
	if not hasText(2, 40) then AddRec IDSUBVIEW, 2,40
	if not hasText(2, 41) then AddRec IDSUBDESIGN,2,41
	if not hasText(2, 42) then AddRec IDSUBQUAL,2,42
	if not hasText(2, 44) then AddRec IDSUBAGE,2,44
	if not hasText(2, 45) then AddRec IDSUBCOND,2,45
	if not hasText(2, 46) then AddRec IDSUBROOMS,2,46
	if not hasText(2, 47) then AddRec IDSUBBED,2,47
	if not hasText(2, 48)  then AddRec IDSUBBATHS,2,48
	if not hasText(2, 49) then AddRec IDSUBGLA,2,49
	if not hasText(2, 50) then AddRec IDSUBBASE,2,50
	if not hasText(2, 51) then AddRec IDSUBBASE,2,51
	if not hasText(2, 52) then AddRec IDSUBFUNC,2,52
	if not hasText(2, 53) then AddRec IDSUBHEAT, 2,53
	if not hasText(2, 54) then AddRec IDSUBENERGY,2,54
	if not hasText(2, 55) then AddRec IDSUBGARAGE,2,55
	if not hasText(2, 56) then AddRec IDSUBPORCH,2,56
	if not hasText(2, 57) then AddRec IDSUBFIRE,2,57
	if not hasText(2, 58) then AddRec IDSUBFENCE,2,58
	if not hasText(2, 242) then AddRec IDSUBPRIOR,2,242

end Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = pgCmpNo
end Function

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
  price = GetValue(cmpPg, clBase + 3)
  if price <= 0 then exit Sub
  IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

	if price/1000 > GetValue(1, 62) or price/1000 < GetValue(1, 61)  then
    AddRec IDCOMP + IDCOMPSALERANGE,cmpPg, clBase + 3
  end if

  if hasText(cmpPg,clBase + 25) then
    num = GetValue(cmpPg,clBase + 25)
		if num > GetValue(1, 65) or num < GetValue(1, 64) then
	    AddRec IDCOMP + IDCOMPAGERANGE, cmpPage, clBase + 25
    end if
  end if

  if hasText(cmpPg, clBase + 34) then
	  valA = GetValue(2, 49)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 34)
      if abs(valA - valB)/ valA > 0.25 then
        AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 34
      end if
    end if
  end if

  if hasText(cmpPg, clBase + 4) then
    valA = GetValue(2, 34)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 4)
      if abs(valA - valB)/ valA > 10 then
        AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 4
      end if
    end if
  end if

  for i = 1 to 24
	  cmpCl = clBase + GetAdjCell(i)
    adjString = GetAdjString(i)
    adj = GetValue(cmpPg,cmpCl)
    if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  next

  netAdj = GetValue(cmpPg, clBase + 58)
  if abs(netAdj)/price > 0.15  then
    AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 58
  else
    AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 58
  end if

end Sub

Sub ReviewIncomeApproach
  AddTitle String(5, "=") + "FNMA 1004 " + IDINCOME + String(5, "=")
	if isChecked(1, 19) then
	  if not hasText(2, 256)  then AddRec IDINCOMERENT, 2,256
	  if not hasText(2, 257) then AddRec IDINCOMEGRM,2,257
	  if not hasText(2, 258) then AddRec IDINCOMEVALUE,2,258
  end if
end Sub

Sub ReviewSalesComments
	if not hasText(2, 241)  then AddRec IDCOMMSALECMP,2,241
	if not hasText(2, 254) then AddRec IDANALPRIOR, 2,254
	if not hasText(2, 255) then AddRec IDSALEVALUE,2,255
end Sub

Sub ReviewReconciliation
  AddTitle String(5, "=") + "FNMA 1004 " + IDRECON + String(5, "=")
  checked = GetCheck(2, 259) + GetCheck(2, 260) + GetCheck(2, 261)
	if checked = 0 then AddRec IDSTATUSNOCHK,2,259
	if checked > 1 then AddRec IDSTATUSCHK,2,259
	if not hasText(2, 262) then AddRec IDCONDCOMM,2,262
	if not hasText(2, 263) then AddRec IDFINALCOM,2,263
	if not hasText(2, 264) then AddRec IDFANNIEMAE,2,264
	if not hasText(2, 265) then AddRec IDASOF,2,265

	if not hasText(2, 266) then
	  AddRec IDTOBE, 2,266
	else
    valA = GetValue(2, 266)
    valB = GetValue(2, 28)
    if valA > 0 then
	if abs(valA - valB)/valA > 0.15  then AddRec IDTOBECOST, 2,266
		if valA/1000 > GetValue(1, 62) or valA < GetValue(1, 61)  then AddRec IDTOBERANGE,2,266    
    end if 
  end if

  'if not hasText(2, 268) then AddRec IDDATESIGNED,2,268
  'Show hard stop if no signature date
  IsSignatureDateEMPTY(2,268)
  'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 2,268


  checked = 0
  if hasText(2, 269) and  not hasText(2, 270) then AddRec IDCERTSTATE,2,270
	if hasText(2, 271) and not hasText(2, 272)  then AddRec IDLICSTATE,2,272
  if not hasText(2,269) and not hasText(2,271) then AddRec IDNOCERT, 2,269

end Sub  


