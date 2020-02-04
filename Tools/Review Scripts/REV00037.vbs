'REVB00037.vbs 2055 Reviewer Script
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 139
cmpOffset = 47

Function GetAdjString(adj)
	Select Case adj
		Case 1: GetAdjString = IDSALESORFIN
		Case 2: GetAdjString = IDCONCESSIONS
		Case 3: GetAdjString = IDDATEOFSALE
		Case 4: GetAdjString = IDLOC
		Case 5: GetAdjString = IDGRIDSITE
		Case 6: GetAdjString = IDGRIDVIEW
		Case 7: GetAdjString = IDGRIDDESIGN
		Case 8: GetAdjString = IDGRIDAGE
		Case 9: GetAdjString = IDCONDITION
		Case 10: GetAdjString = IDROOMCOUNT
		Case 11: GetAdjString = IDGRIDGLA
		Case 12: GetAdjString = IDGRIDBASEMENT
		Case 13: GetAdjString = IDBELOW
		Case 14: GetAdjString = IDGARAGE
		Case 15, 16: GetAdjString = IDOTHER
	End Select
End Function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9 GetAdjCell = 7 + (n - 1)*2
    case 10,11,12,13,14,15,16   GetAdjCell = 9 + (n-1)*2
  end Select
end Function

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
  ReviewPUD
  AddTitle ""
  ReviewCondominum
  AddTitle ""
  ReviewCertification
  AddTitle ""
End Sub

Sub ReviewSubject
  AddTitle String(5, "=") + "FNMA 2055 " + IDSUBJECT + String(5, "=")

  If Not hasText(1, 2) Then AddRec IDFILENUM, 1, 2
  If Not hasText(1, 4) Then AddRec IDAddress, 1, 4
  If Not hasText(1, 5) Then AddRec IDCITY, 1, 5
  If Not hasText(1, 6) Then AddRec IDSTATE, 1, 6
  If Not hasText(1, 7) Then AddRec IDZIP, 1, 7
  If Not hasText(1, 8) Then AddRec IDLEGAL, 1, 8
  If Not hasText(1, 9) Then AddRec IDCOUNTY, 1, 9
  If Not hasText(1, 10) Then AddRec IDAPN, 1, 10
  If Not hasText(1, 11) Then AddRec IDTAXYEAR, 1, 11
  If Not hasText(1, 12) Then AddRec IDRETAXES, 1, 12
  If Not hasText(1, 13) Then AddRec IDSPECIAL, 1, 13
  If Not hasText(1, 14) Then AddRec IDBORROWER, 1, 14
  If Not hasText(1, 15) Then AddRec IDCUROWN, 1, 15
  
  checked = GetCheck(1, 16) + GetCheck(1, 17) + GetCheck(1, 18)
  If checked = 0 Then AddRec IDOCCNOCHECK, 1, 16
  If checked > 1 Then AddRec IDOccMoreCheck, 1, 16

  checked1 = GetCheck(1, 26) + GetCheck(1, 27)
  checked2 = GetCheck(1, 20) + GetCheck(1, 21)
  If isChecked(1, 20) And (checked1 = 0) Then AddRec IDPudCheck, 1, 20
  If (checked2 > 0) And (Not hasText(1, 22)) Then AddRec IDHOA, 1, 22
  If (checked1 = 0) And (checked2 = 0) Then AddRec IDPROPNOCHK, 1, 20
  If checked2 > 1 Then AddRec IDPROPCHK, 1, 20

  If Not hasText(1, 19) Then AddRec IDPROJNAME, 1, 19
  If Not hasText(1, 28) Then AddRec IDMAPREF, 1, 28     
  If Not hasText(1, 29) Then AddRec IDCENSUS, 1, 29   

  If Not hasText(1, 23) Then
  	AddRec IDSALESPRICE, 1, 23
  Else
  		price = GetValue(1, 23) / 1000
        If (price > GetValue(1, 50)) Or (price < GetValue(1, 49)) Then
          AddRec IDSUBSALESRNG, 1, 49
      	End If
  End If

  If StrComp(GetText(1, 118), GetText(1, 23)) Then AddRec IDSALESPRICECOMP, 1, 23
  If Not hasText(1, 24) Then AddRec IDDATE, 1, 24
  If Not hasText(1, 25) Then AddRec IDLOAN, 1, 25
End Sub

Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 2055 " + IDNEIGH + String(5, "=")

  checked = GetCheck(1, 30) + GetCheck(1, 31) + GetCheck(1, 32)
  If checked = 0 Then AddRec IDLOCNOCHK, 1, 30
  If checked > 1 Then AddRec IDLOCCHK, 1, 30

  checked = GetCheck(1, 33) + GetCheck(1, 34) + GetCheck(1, 35)
  If checked = 0 Then AddRec IDBUILTNOCHK, 1, 33
  If checked > 1 Then AddRec IDBUILTCHK, 1, 33

  checked = GetCheck(1, 36) + GetCheck(1, 37) + GetCheck(1, 38)
  If checked = 0 Then AddRec IDGROWTHNOCHK, 1, 36
  If checked > 1 Then AddRec IDGROWTHCHK, 1, 36

  If isChecked(1, 39) Then AddRec IDPropValueInc, 1, 39
  
  checked = GetCheck(1, 39) + GetCheck(1, 40) + GetCheck(1, 41)
  If checked = 0 Then AddRec IDPRPVALNOCHK, 1, 39
  If checked > 1 Then AddRec IDPRPVALCHK, 1, 39

  checked = GetCheck(1, 42) + GetCheck(1, 43) + GetCheck(1, 44)
  If checked = 0 Then AddRec IDDEMANDNOCHK, 1, 42
  If checked > 1 Then AddRec IDDEMANDCHK, 1, 42

  checked = GetCheck(1, 45) + GetCheck(1, 46) + GetCheck(1, 47)
  If checked = 0 Then AddRec IDMARKETNOCHK, 1, 45
  If checked > 1 Then AddRec IDMARKETCHK, 1, 45

  checked = GetCheck(1, 39) + GetCheck(1, 42)
  If isChecked(1, 45) And checked Then AddRec IDMARKETOVER, 1, 45

  checked = GetCheck(1, 41) + GetCheck(1, 44)
  If isChecked(1, 47) And checked Then AddRec IDMARKETUNDER, 1, 47

  checked = GetCheck(1, 32) + GetCheck(1, 35) + GetCheck(1, 38) + GetCheck(1, 41) + GetCheck(1, 44) + GetCheck(1, 47)
  If checked > 0 Then AddRec IDRCOMMENT, 1, 32

  If Not hasText(1, 49) Then AddRec IDLOWPRICE, 1, 49
  If Not hasText(1, 50) Then AddRec IDHIGHPRICE, 1, 50

  If GetValue(1, 50) < GetValue(1, 49) Then AddRec IDPRICECK, 1, 49

  If Not hasText(1, 51) Then AddRec IDPREDPRICE, 1, 51

  If (GetValue(1, 51) > GetValue(1, 50)) Or (GetValue(1, 51) < GetValue(1, 49)) Then AddRec IDPRICERANGE, 1, 51

  If Not hasText(1, 52) Then AddRec IDLOWAGE, 1, 52
  If Not hasText(1, 53) Then AddRec IDHIGHAGE, 1, 53

  If GetValue(1, 53) < GetValue(1, 52) Then AddRec IDAGECK, 1, 52

  If Not hasText(1, 54) Then AddRec IDPREDAGE, 1, 54

  If (GetValue(1, 54) > GetValue(1, 53)) Or (GetValue(1, 54) < GetValue(1, 52)) Then AddRec IDAGERANGE, 1, 54

  If Not hasText(1, 48) Then AddRec IDNEIGHCHAR, 1, 48

End Sub

Sub ReviewSite
  AddTitle String(5, "=") + "FNMA 2055 " + IDSite + String(5, "=")

  If Not hasText(1, 61) Then AddRec IDDIMEN, 1, 61

  If Not hasText(1, 62) Then
    AddRec IDSITEAREA, 1, 62
  Else
    If StrComp(GetText(1, 121),GetText(1, 62),vbTextCompare) <> 0 Then AddRec IDSITECOMPARE, 1, 62
  End If

  If Not hasText(1, 79) Then AddRec IDSHAPE, 1, 63
  If Not hasText(1, 64) Then AddRec IDZONINGCLAS, 1, 64
  If isChecked(1, 66) Then AddRec IDNONCOFORM, 1, 66
  If isChecked(1, 67) Then AddRec IDILLEGAL, 1, 67
  If isChecked(1, 68) Then AddRec IDNOZONE, 1, 68

  checked = GetCheck(1, 65) + GetCheck(1, 66) + GetCheck(1, 67) + GetCheck(1, 68)
   If checked > 1 Then AddRec IDZONINGNOCHK, 1, 65
   If checked = 0 Then AddRec IDZONINGCOM, 1, 65

  If isChecked(1, 70) Then AddRec IDOTHERUSE, 1, 70

  checked = GetCheck(1, 69) + GetCheck(1, 70)
  If checked > 1 Then AddRec IDHIGHBESTCK, 1, 69
  If checked = 0 Then AddRec IDHIGHNOCK, 1, 69

  If hasText(1, 72) Then
    If isChecked(1, 71) Then AddRec IDELECCK, 1, 71
    AddRec IDELECCOMM, 1, 71
  Else
    If Not isChecked(1, 71) Then AddRec IDELECNOCK, 1, 71
  End If

  If hasText(1, 74) Then
    If isChecked(1, 73) Then AddRec IDGASCK, 1, 73
    AddRec IDGASCOMM, 1, 73
  Else
    If Not isChecked(1, 73) Then AddRec IDGASNOCK, 1, 73
  End If

  If hasText(1, 76) Then
    If isChecked(1, 75) Then AddRec IDWATERCK, 1, 75
    AddRec IDWATERCOMM, 1, 75
  Else
    If Not isChecked(1, 75) Then AddRec IDWATERNOCK, 1, 75
  End If

  If hasText(1, 78) Then
    If isChecked(1, 77) Then AddRec IDSANCK, 1, 77
    AddRec IDSANCOMM, 1, 77
  Else
    If Not isChecked(1, 77) Then AddRec IDSANNOCK, 1, 77
  End If

  If Not hasText(1, 79) Then AddRec IDSTREETTYPE, 1, 79

  checked = GetCheck(1, 80) + GetCheck(1, 81)
  If checked > 1 Then AddRec IDSTREETCK, 1, 80
  If checked = 0 Then AddRec IDSTREETNOCK, 1, 80

End Sub

Sub ReviewImprovements
  AddTitle String(5, "=") + "FNMA 2055 " + IDIMPROV + String(5, "=")

  checked = GetCheck(1, 87) + GetCheck(1, 88) + GetCheck(1, 89) + GetCheck(1, 90) _
  + GetCheck(1, 91) + GetCheck(1, 92) + GetCheck(1, 93) + GetCheck(1, 94)
  If hasText(1, 95) Then checked = checked + 1
  If checked = 0 Then AddRec IDDATASOURCE, 1, 87

  If Not hasText(1, 96) Then AddRec IDSTORIES, 1, 96
  If Not hasText(1, 97) Then AddRec IDTYPE, 1, 97
  If Not hasText(1, 98) Then AddRec IDEXT, 1, 98
  If Not hasText(1, 99) Then AddRec IDROOFSUF, 1, 99

  checked = GetCheck(1, 100) + GetCheck(1, 101)
  If checked > 1 Then AddRec IDMANUCK, 1, 100
  If checked = 0 Then AddRec IDMANUNOCK, 1, 100

  checked = GetCheck(1, 102) + GetCheck(1, 103)
  If checked > 1 Then AddRec IDCONFRMCHK, 1, 102
  If checked = 0 Then AddRec IDCONFRMNOCHK, 1, 102

  If isChecked(1, 104) Then AddRec IDPHYS, 1, 81

  checked = GetCheck(1, 104) + GetCheck(1, 105)
  If checked > 1 Then AddRec IDPHYSCHK, 1, 104
  If checked = 0 Then AddRec IDPHYSNOCHK, 1, 104
End Sub

Sub ReviewSalesComparison
  AddTitle String(5, "=") + "FNMA 2055 " + IDSALESAPP + String(5, "=")  
  ReviewSalesSubject
  for pageCmpNo = 1 to 3
    cmpNo = GetCmpNo(pageCmpNo)
    ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
  next
end Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = pgCmpNo
end Function

Sub ReviewSalesSubject
    If Not hasText(1, 110) Then AddRec IDSALES, 1, 110
    If Not hasText(1, 111) Then AddRec IDSALESFRM, 1, 111
    If Not hasText(1, 112) Then AddRec IDSALESTO, 1, 112
    If Not hasText(1, 113) Then AddRec IDLISTINGS, 1, 113
    If Not hasText(1, 114) Then AddRec IDLISTFRM, 1, 114
    If Not hasText(1, 115) Then AddRec IDLISTTO, 1, 115
    If Not hasText(1, 116) Then AddRec IDSUBADD, 1, 116
    If Not hasText(1, 117) Then AddRec IDSUBCITY, 1, 117
    If Not hasText(1, 118) Then AddRec IDSUBSALES, 1, 118
    If Not hasText(1, 119) Then AddRec IDSUBPRGLA, 1, 119
    If Not hasText(1, 120) Then AddRec IDSUBLOC, 1, 120
    If Not hasText(1, 121) Then AddRec IDSUBSITE, 1, 121
    If Not hasText(1, 122) Then AddRec IDSUBVIEW, 1, 122
    If Not hasText(1, 123) Then AddRec IDSUBDESIGN, 1, 123
    If Not hasText(1, 124) Then AddRec IDSUBAGE, 1, 124
    If Not hasText(1, 125) Then AddRec IDSUBCOND, 1, 125
    If Not hasText(1, 126) Then AddRec IDSUBROOMS, 1, 126
    If Not hasText(1, 127) Then AddRec IDSUBBED, 1, 127
    If Not hasText(1, 128) Then AddRec IDSUBBATHS, 1, 128
    If Not hasText(1, 129) Then AddRec IDSUBGLA, 1, 129
    If Not hasText(1, 130) Then AddRec IDSUBBASE, 1, 130
    If Not hasText(1, 131) Then AddRec IDSUBBASE, 1, 131
    If Not hasText(1, 132) Then AddRec IDSUBGARAGE, 1, 132
    If Not hasText(1, 137) Then AddRec IDSUBPRIOR, 1, 137
    
    If Not hasText(1, 281) Then AddRec IDCOMMSALECMP, 1, 281    
    If Not hasText(1, 280) Then AddRec IDANALPRIOR, 1, 280
    
    checked = GetCheck(1, 282) + GetCheck(1, 283) + GetCheck(1, 284)
    If checked = 0 Then AddRec IDSTATUSNOCHK, 1, 282
    If checked > 1 Then AddRec IDSTATUSCHK, 1, 279
    
    If Not hasText(1, 285) Then AddRec IDCONDCOMM, 1, 285
    
    checked = GetCheck(1, 286) + GetCheck(1, 287)
    If checked = 0 Then AddRec IDINSPECTNOCK, 1, 286
    If checked > 1 Then AddRec IDINSPECTCHK, 1, 286

    If Not hasText(1, 289) Then AddRec IDASOF, 1, 289
        
    If Not hasText(1, 288) Then
        AddRec IDTOBE, 1, 288
    Else
        num = GetValue(1, 288) / 1000
        If (num > GetValue(1, 49)) Or (num < GetValue(1, 48)) Then _
            AddRec IDTOBERANGE, 1, 288
    End If
    
end Sub

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
	price = GetValue(cmpPg, clBase + 3)
  	if price <= 0 then exit Sub
  	IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

	if price/1000 > GetValue(1, 50) or price/1000 < GetValue(1, 49)  then
    	AddRec IDCOMP + IDCOMPSALERANGE,cmpPg, clBase + 3
  	end if
  
	if hasText(cmpPg,clBase + 20) then
    	num = GetValue(cmpPg,clBase + 20)
		if num > GetValue(1, 53) or num < GetValue(1, 52) then
	    	AddRec IDCOMP + IDCOMPAGERANGE, cmpPage, clBase + 20
    	end if
  	end if
  	
	if hasText(cmpPg, clBase + 28) then
		valA = GetValue(1, 129)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 28)
      		if abs(valA - valB)/ valA > 0.25 then
        		AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 28
      		end if
    	end if
  	end if
  
        if hasText(cmpPg, clBase + 4) then
    	valA = GetValue(1, 119)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 4)
      		if abs(valA - valB)/ valA > 10 then
        		AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 4
      		end if
    	end if
  	end if
  	
End Sub



Sub ReviewPUD

    AddTitle String(5, "=") + "FNMA 2055 " + IDPUD + String(5, "=")  
    checked = GetCheck(2, 4) + GetCheck(2, 5)
    If checked = 0 And isChecked(1, 20) Then AddRec IDPUDDEV, 2, 4
    If checked > 1 And Not isChecked(1, 20) Then AddRec IDPUDCHECKED, 2, 4
 
    If isChecked(1, 20) Then
        If Not isChecked(1, 20) Then AddRec IDPUDDEVBADCHK1, 3
        If Not hasText(2, 6) Then AddRec IDPHASES, 2, 6
        If Not hasText(2, 7) Then AddRec IDUNITS, 2, 7
        If Not hasText(2, 10) Then AddRec IDUNITSALE, 2, 10
        If Not hasText(2, 8) Then AddRec IDUNITSOLD, 2, 8
        If Not hasText(2, 9) Then AddRec IDUNITRENT, 2, 9
        If Not hasText(2, 11) Then AddRec IDDATASOURCE, 2, 11
     
        checked = GetCheck(2, 12) + GetCheck(2, 13)
        If checked = 0 Then AddRec IDCONNOCHK, 2, 12
        If checked > 1 Then AddRec IDCONCHK, 2, 12
        
        If isChecked(2, 12) Then
            If Not hasText(2, 14) Then AddRec IDDATEOFCON, 2, 12
        End If
    
        checked = GetCheck(2, 15) + GetCheck(2, 16)
        If checked = 0 Then AddRec IDMULTINOCHK, 2, 15
        If checked > 1 Then AddRec IDMULTINOCHK, 2, 15
        
        If Not hasText(2, 17) Then AddRec IDDATASOURCE, 2, 17        
        If Not hasText(2, 23) Then AddRec IDCMMELE, 2, 23
        
        checked = GetCheck(2, 18) + GetCheck(2, 19)
        If checked = 0 Then AddRec ICCMMELENO, 2, 18
        If checked > 1 Then AddRec IDCMMELECHK, 2, 18
        
        checked = GetCheck(2, 21) + GetCheck(2, 22)
        If checked = 0 Then AddRec ICCMMELENO, 2, 21
        If checked > 1 Then AddRec IDCMMELECHK, 2, 21
    
        If isChecked(2, 21) Then AddRec IDCMMELECOM, 2, 21
    End If
End Sub

Sub ReviewCondominum
    AddTitle String(5, "=") + "FNMA 2055 " + IDCONDOMINUM + String(5, "=")
    
    checked = GetCheck(2, 24) + GetCheck(2, 25)
    If checked = 0 And isChecked(1, 21) Then AddRec IDCONDONOCHK, 2, 24
    If checked > 1 And Not isChecked(1, 21) Then AddRec IDCONDOCHK, 2, 24
    If checked > 1 Then AddRec IDCONDO, 2, 21
    If isChecked(1, 21) Then
        If Not hasText(2, 26) Then AddRec IDPHASES, 2, 26
        If Not hasText(2, 27) Then AddRec IDUNITS, 2, 26
        If Not hasText(2, 30) Then AddRec IDUNITSALE, 2, 30
        If Not hasText(2, 28) Then AddRec IDUNITSOLD, 2, 28
        If Not hasText(2, 29) Then AddRec IDUNITRENT, 2, 29
        If Not hasText(2, 30) Then AddRec IDDATASOURCE, 2, 30
        
        checked = GetCheck(2, 32) + GetCheck(2, 33)
        If checked = 0 Then AddRec IDCONNOCHK, 2, 15
        If checked > 1 Then AddRec IDCONCHK, 2, 15       
        If isChecked(2, 32) And Not hasText(2, 34) Then AddRec IDDATEOFCON, 2, 32
     
        checked = GetCheck(2, 35) + GetCheck(2, 36) + GetCheck(2, 37) + GetCheck(2, 38) + _
        GetCheck(2, 39) + GetCheck(2, 40) + GetCheck(2, 41)
        If checked = 0 Then AddRec IDPROJTYPE, 2, 15
        If checked > 1 Then AddRec IDPRJTPECHK, 2, 15
          
        If Not hasText(2, 42) Then AddRec IDCOND, 2, 0
        
        checked = GetCheck(2, 35) + GetCheck(2, 36) + GetCheck(2, 37) + GetCheck(2, 38) + _
        GetCheck(2, 39) + GetCheck(2, 40) + GetCheck(2, 41)
        If checked = 0 Then AddRec IDPROJTYPE, 2, 15
        If checked > 1 Then AddRec IDPRJTPECHK, 2, 15
        
        checked = GetCheck(2, 44) + GetCheck(2, 45)
        If checked = 0 Then AddRec ICCMMELENO, 2, 44
        If checked > 1 Then AddRec IDCMMELECHK, 2, 44
        
        If Not hasText(2, 49) Then AddRec IDCMMELE, 2, 49
    
        checked = GetCheck(2, 47) + GetCheck(2, 48)
        If checked = 0 Then AddRec ICCMMELENO, 2, 47
        If checked > 1 Then AddRec IDCMMELECHK, 2, 47
        If isChecked(2, 47) Then AddRec IDCMMELECOM, 2, 47
	end if
End Sub

Sub ReviewCertification
    AddTitle String(5, "=") + "FNMA 2055 " + IDAPPCERT + String(5, "=")
    
    If Not hasText(3, 16) Then AddRec IDASOF, 3, 16
    If Not hasText(3, 15) Then
        AddRec IDTOBE, 3, 15
    Else
        num = GetValue(3, 15) / 1000
        If (num > GetValue(1, 50)) Or (num < GetValue(1, 49)) Then AddRec IDTOBERANGE, 3, 15
    End If

    If Not hasText(3, 8) Then AddRec IDDATESIGNED, 3, 8 
    'Show warning if signaturedate not = today's date 
    IsSignatureDateNOTToday 3, 8
    
    If Not hasText(3, 9) And Not hasText(3, 11) Then AddRec IDCERTSTATE, 3, 9
    If Not hasText(3, 10) And Not hasText(3, 12) Then AddRec IDLICSTATE, 3, 10               
    If Not hasText(3, 9) And Not hasText(3, 10) Then AddRec IDNOCERT, 3, 9
End Sub


