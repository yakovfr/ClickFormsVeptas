'REV00007.vbs Condo Reviewer Script
01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning


Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 2
cmpBase = 64
cmpOffset = 66

Function GetAdjString(adj)
	Select case adj
		case	1:  GetAdjString = IDSALESORFIN
		case	2:  GetAdjString = IDCONCESSIONS
		case	3:  GetAdjString = IDDATEOFSALE
		case	4:  GetAdjString = IDLOC
		case	5:  GetAdjString = IDLEASE
		case	6:  GetAdjString = IDGRIDHOA
		case	7:  GetAdjString = IDGRIDELE
		case	8:  GetAdjString = IDRECADJ
		case	9:  GetAdjString = IDPRJADJ
		case	10:  GetAdjString = IDGRIDFLR
		case	11:  GetAdjString = IDGRIDVIEW
		case	12:  GetAdjString = IDGRIDDESIGN
		case	13:  GetAdjString = IDQUAL
		case	14:  GetAdjString = IDGRIDAGE
		case	15:  GetAdjString = IDCONDITION
		case	16:  GetAdjString = IDABOVEGRADE
		case	17:  GetAdjString = IDROOMCOUNT
		case	18:  GetAdjString = IDGRIDGLA
		case	19:  GetAdjString = IDGRIDBASEMENT
		case	20:  GetAdjString = IDBELOW
		case	21:  GetAdjString = IDFUNC
		case	22:  GetAdjString = IDHEAT
		case	23:  GetAdjString = IDENERGY
		case	24:  GetAdjString = IDGARAGE
		case	25:  GetAdjString = IDPORCH
		case	26:  GetAdjString = IDFIRE
		case	27:  GetAdjString = IDOTHER
	end Select
end Function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 GetAdjCell = 8 + (n - 1)*2
    case 16 GetAdjCell = 37
    case 17,18,18,20,21,22,23,24,25,26,27   GetAdjCell = 9 + (n-1)*2
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
  ReviewSubjectUnit
  AddTitle ""
  ReviewComments
  AddTitle ""
  ReviewProjectAnalysis
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
  ReviewReconciliation
  AddTitle ""

End Sub


Sub ReviewSubject
 
    AddTitle String(5, "=") + "FNMA Condo 94 " + IDSUBJECT + String(5, "=")
    
    If Not hasText(1, 3) Then AddRec IDFILENUM, 1, 3
    If Not hasText(1, 6) Then AddRec IDADDRESS, 1, 6
    If Not hasText(1, 7) Then AddRec IDCITY, 1, 7
    If Not hasText(1, 8) Then AddRec IDSTATE, 1, 8
    If Not hasText(1, 9) Then AddRec IDZIP, 1, 9
    If Not hasText(1, 10) Then AddRec IDLEGAL, 1, 10
    If Not hasText(1, 11) Then AddRec IDCOUNTY, 1, 11
    If Not hasText(1, 12) Then AddRec IDUNITS, 1, 12
    If Not hasText(1, 13) Then AddRec IDAPN, 1, 13
    If Not hasText(1, 14) Then AddRec IDTAXYEAR, 1, 14
    If Not hasText(1, 15) Then AddRec IDRETAXES, 1, 15
    If Not hasText(1, 16) Then AddRec IDSPECIAL, 1, 16
    If Not hasText(1, 20) Then AddRec IDBORROWER, 1, 20
    If Not hasText(1, 21) Then AddRec IDCUROWN, 1, 21
    
    checked = GetCheck(1, 22) + GetCheck(1, 23) + GetCheck(1, 24)
    If checked = 0 Then AddRec IDOCCNOCHECK, 1, 22
    If checked > 1 Then AddRec IDOccMoreCheck, 1, 22
 
    'Property Rights Appraised
    
    checked = GetCheck(1, 25) + GetCheck(1, 26)
    If checked = 0 Then AddRec IDPROPNOCHK, 1, 22
    If checked > 1 Then AddRec IDPROPCHK, 1, 22
    
    If Not hasText(1, 27) Then AddRec IDHOA, 1, 24
    If Not hasText(1, 17) Then AddRec IDPROJNAME, 1, 14
    If Not hasText(1, 18) Then AddRec IDMAPREF, 1, 0
    If Not hasText(1, 19) Then AddRec IDCENSUS, 1, 0
    
    If Not hasText(1, 28) Then
        AddRec IDSALESPRICE, 1, 28
    Else
        price = GetValue(1, 28) / 1000
        If (price > GetValue(1, 60)) Or (price < GetValue(1, 59)) Then
            AddRec IDSUBSALESRNG, 1, 28
        End If        
        If GetText(2, 34) <> GetText(1, 28) Then
            AddRec IDSALESPRICECOMP, 1, 28
        End If
    End If
    
    If Not hasText(1, 29) Then AddRec IDDATE, 1, 29
    If Not hasText(1, 30) Then AddRec IDLOAN, 1, 30
    If Not hasText(1, 31) Then AddRec IDLENDER, 1, 31
    If Not hasText(1, 32) Then AddRec IDLENDERADD, 1, 32
    
End Sub                                    

Sub ReviewNeighborhood
  AddTitle String(5, "=") + "FNMA Condo 94 " + IDNEIGH + String(5, "=")
  
  checked = GetCheck(1, 35) + GetCheck(1, 36) + GetCheck(1, 37)
  If checked = 0 Then AddRec IDLOCNOCHK, 1, 35
  If checked > 1 Then AddRec IDLOCCHK, 1, 35

  checked = GetCheck(1, 38) + GetCheck(1, 39) + GetCheck(1, 40)
  If checked = 0 Then AddRec IDBUILTNOCHK, 1, 38
  If checked > 1 Then AddRec IDBUILTCHK, 1, 38

  checked = GetCheck(1, 41) + GetCheck(1, 42) + GetCheck(1, 43)
  If checked = 0 Then AddRec IDGROWTHNOCHK, 1, 41
  If checked > 1 Then AddRec IDGROWTHCHK, 1, 41

  If isChecked(1, 44) Then AddRec IDPropValueInc, 1, 44
  checked = GetCheck(1, 44) + GetCheck(1, 45) + GetCheck(1, 46)
  If checked = 0 Then AddRec IDPRPVALNOCHK, 1, 44
  If checked > 1 Then AddRec IDPRPVALCHK, 1, 44

  checked = GetCheck(1, 47) + GetCheck(1, 48) + GetCheck(1, 49)
  If checked = 0 Then AddRec IDDEMANDNOCHK, 1, 47
  If checked > 1 Then AddRec IDDEMANDCHK, 1, 47

  checked = GetCheck(1, 50) + GetCheck(1, 51) + GetCheck(1, 52)
  If checked = 0 Then AddRec IDMARKETNOCHK, 1, 50
  If checked > 1 Then AddRec IDMARKETCHK, 1, 50

  checked = GetCheck(1, 44) + GetCheck(1, 47)
  If isChecked(1, 50) And checked Then AddRec IDMARKETOVER, 1, 50

  checked = GetCheck(1, 46) + GetCheck(1, 49)
  If isChecked(1, 52) And checked Then AddRec IDMARKETUNDER, 1, 52

  checked = GetCheck(1, 37) + GetCheck(1, 40) + GetCheck(1, 43) + GetCheck(1, 46) + GetCheck(1, 49) + GetCheck(1, 52)
  If checked > 0 Then AddRec IDRCOMMENT, 1, 37
    
  checked = GetCheck(1, 53) + GetCheck(1, 55)
  If checked = 0 Then AddRec IDOCCUPANCY, 1, 53
  If checked > 1 Then AddRec IDOCCUPANCYCK, 1, 53
    
  checked = GetCheck(1, 57) + GetCheck(1, 58)
  If checked = 0 Then AddRec IDOCCVAN, 1, 57
  If checked > 1 Then AddRec IDOCCVACCHK, 1, 57

  If Not hasText(1, 59) Then AddRec IDLOWPRICE, 1, 59
  If Not hasText(1, 60) Then AddRec IDHIGHPRICE, 1, 60

  If GetValue(1, 60) < GetValue(1, 59) Then AddRec IDPrice, 1, 59

  If Not hasText(1, 61) Then AddRec IDPREDPRICE, 1, 61

  If (GetValue(1, 61) > GetValue(1, 60)) Or (GetValue(1, 61) < GetValue(1, 59)) Then AddRec IDPRICERANGE, 1, 61

  If Not hasText(1, 62) Then AddRec IDLOWAGE, 1, 62
  If Not hasText(1, 63) Then AddRec IDHIGHAGE, 1, 63

  If GetValue(1, 63) < GetValue(1, 62) Then AddRec IDAGE, 1, 62

  If Not hasText(1, 64) Then AddRec IDPREDAGE, 1, 64

  If (GetValue(1, 64) > GetValue(1, 63)) Or (GetValue(1, 64) < GetValue(1, 62)) Then AddRec IDAGERANGE, 1, 64

  If Not hasText(1, 71) Then AddRec IDLOWPRICEC, 1, 71
  If Not hasText(1, 72) Then AddRec IDHIGHPRICEC, 1, 72

  If GetValue(1, 72) < GetValue(1, 71) Then AddRec IDPRICECKC, 1, 71

  If Not hasText(1, 73) Then AddRec IDPREDPRICEC, 1, 73

  If (GetValue(1, 73) > GetValue(1, 72)) Or (GetValue(1, 73) < GetValue(1, 71)) Then AddRec IDPRICERANGEC, 1, 73

  If Not hasText(1, 74) Then AddRec IDLOWAGEC, 1, 74
  If Not hasText(1, 75) Then AddRec IDHIGHAGEC, 1, 75

  If GetValue(1, 75) < GetValue(1, 74) Then AddRec IDAGECKC, 1, 74

  If Not hasText(1, 76) Then AddRec IDPREDAGEC, 1, 76

  If (GetValue(1, 76) > GetValue(1, 75)) Or (GetValue(1, 76) < GetValue(1, 74)) Then AddRec IDAGERANGEC, 1, 64

  sum = GetValue(1, 74) + GetValue(1, 75) + GetValue(1, 76) + GetValue(1, 77) + GetValue(1, 78) + _
  GetValue(1, 79) + GetValue(1, 80) + GetValue(1, 81)
  
  result = 100 - sum
  
  If isChecked(1, 35) And (result >= 25) Then AddRec IDOVER75, 1, 74
  If isChecked(1, 35) And (result >= 25) Then AddRec IDOVER75, 1, 74
  If isChecked(1, 36) And (result > 75 Or result < 25) Then AddRec ID2575, 1, 74
  If isChecked(1, 37) And (result <= 75) Then AddRec IDUNDER25, 1, 74
  
  If Not hasText(1, 89) Then AddRec IDNEIGHCHAR, 1, 89

  If Not hasText(1, 87) Then AddRec IDNEIGHMARKET, 1, 87
            
  If Not hasText(1, 88) Then AddRec IDNEIGHCOND, 1, 0
End Sub

Sub ReviewSite

    AddTitle String(5, "=") + "FNMA Condo 94 " + IDSite + String(5, "=")
     
    If Not hasText(1, 92) Then AddRec IDZONINGCLAS, 1, 92
  
    If isChecked(1, 94) Then AddRec IDNONCOFORM, 1, 94
   
    If isChecked(1, 95) Then AddRec IDILLEGAL, 1, 95
  
    If isChecked(1, 96) Then AddRec IDNOZONE, 1, 96
  
    checked = GetCheck(1, 93) + GetCheck(1, 94) + GetCheck(1, 95) + GetCheck(1, 96)
    If checked > 1 Then AddRec IDZONINGNOCHK, 1, 93
    If checked = 0 Then AddRec IDZONINGCOM, 1, 93
  
    If isChecked(1, 98) Then AddRec IDOTHERUSE, 1, 98
    
    checked = GetCheck(1, 97) + GetCheck(1, 98)
    If checked > 1 Then AddRec IDHIGHBESTCK, 1, 97
    If checked = 0 Then AddRec IDHIGHNOCK, 1, 97
    
    If hasText(1, 101) Then
      If isChecked(1, 100) Then AddRec IDELECCK, 1, 100
      AddRec IDELECCOMM, 1, 100
    Else
        If Not isChecked(1, 100) Then AddRec IDELECNOCK, 1, 100
    End If
      
    If hasText(1, 103) Then
        If isChecked(1, 102) Then AddRec IDGASCK, 1, 102
        AddRec IDGASCOMM, 1, 102
    Else
        If Not isChecked(1, 102) Then AddRec IDGASNOCK, 1, 102
    End If
    
    If hasText(1, 105) Then
        If isChecked(1, 104) Then AddRec IDWATERCK, 1, 104
        AddRec IDWATERCOMM, 1, 104
    Else
        If Not isChecked(1, 104) Then AddRec IDWATERNOCK, 1, 104
    End If

    If hasText(1, 107) Then
        If isChecked(1, 106) Then AddRec IDSANCK, 1, 106
        AddRec IDSANCOMM, 1, 106
    Else
        If Not isChecked(1, 106) Then AddRec IDSANNOCK, 1, 106
    End If
    
    If hasText(1, 109) Then
        If isChecked(1, 108) Then AddRec IDSTORMCK, 1, 108
        AddRec IDSTORMCOMM, 1, 108
    Else
        If Not isChecked(1, 108) Then AddRec IDSTORMNOCK, 1, 108
    End If
    
    If Not hasText(1, 110) Then AddRec IDSTREETTYPE, 1, 110
    If isChecked(1, 112) Then AddRec IDSTREETPRIV, 1, 112
    checked = GetCheck(1, 111) + GetCheck(1, 112)
    If checked > 1 Then AddRec IDSTREETCK, 1, 111
    If checked = 0 Then AddRec IDSTREETNOCK, 1, 111
    
    If Not hasText(1, 113) Then AddRec IDCURBTYPE, 1, 113
    If isChecked(1, 115) Then AddRec IDCURBPRIV, 1, 115
    checked = GetCheck(1, 114) + GetCheck(1, 115)
    If checked > 1 Then AddRec IDCURBCK, 1, 114
    If checked = 0 Then AddRec IDCURBNOCHK, 1, 114
    
    If Not hasText(1, 116) Then AddRec IDSIDETYPE, 1, 116
    If isChecked(1, 118) Then AddRec IDSIDEPRIV, 1, 118
    checked = GetCheck(1, 117) + GetCheck(1, 118)
    If checked > 1 Then AddRec IDSIDECK, 1, 117
    If checked = 0 Then AddRec IDSIDENOCK, 1, 117
    
    If Not hasText(1, 119) Then AddRec IDLIGHTTYPE, 1, 119
    If isChecked(1, 121) Then AddRec IDLIGHTPRIV, 1, 121
    checked = GetCheck(1, 120) + GetCheck(1, 121)
    If checked > 1 Then AddRec IDLIGHTCK, 1, 120
    If checked = 0 Then AddRec IDLIGHTNOCK, 1, 120
     
    If Not hasText(1, 125) Then AddRec IDTOPOGRAPHY, 1, 125
    If Not hasText(1, 126) Then AddRec IDSIZE, 1, 126
    If Not hasText(1, 127) Then AddRec IDDENSITY, 1, 127
    If Not hasText(1, 129) Then AddRec IDDRAINAGE, 1, 129
    If Not hasText(1, 128) Then
        AddRec IDVIEW, 1, 128
    Else
        If GetText(2, 45) <> GetText(1, 128) Then
            AddRec IDSITECOMPARE, 1, 128
        End If
    End If
    If Not hasText(1, 127) Then AddRec IDEASEMENTS, 1, 127
    
    checked = GetCheck(1, 131) + GetCheck(1, 132)
    If checked > 1 Then AddRec IDFEMACK, 1, 131
    If checked = 0 Then AddRec IDFEMANOCK, 1, 131
    
    If isChecked(1, 131) Then
        If Not hasText(1, 133) Then AddRec IDFEMAZONE, 1, 133
        If Not hasText(1, 134) Then AddRec IDFEMADATE, 1, 134
        If Not hasText(1, 135) Then AddRec IDFEMAMAP, 1, 135
    End If
    
    If Not hasText(1, 136) Then AddRec IDSITECOMMENTS, 1, 136
        
End Sub

Sub ReviewImprovements
    AddTitle String(5, "=") + "FNMA Condo 94 " + IDIMPROVM + String(5, "=")
    If Not hasText(1, 137) Then AddRec IDSTORIES, 1, 137
    If Not hasText(1, 138) Then AddRec IDELEVATOR, 1, 138
    If Not hasText(1, 139) Then AddRec IDEXISTING, 1, 139
    If Not hasText(1, 140) Then AddRec IDCONVER, 1, 140
    If Not hasText(1, 141) Then AddRec IDDATEOFCON, 1, 141
    If Not hasText(1, 142) Then
        AddRec IDAGE, 1, 142
    Else
        age = GetValue(1, 143)
        If (age > GetValue(1, 63)) Or (age < GetValue(1, 62)) Then
            AddRec IDSUBAGERANGE, 1, 143
        End If
        If GetText(2, 48) <> GetText(1, 142) Then AddRec IDAGECMP, 1, 142
    End If
    If Not hasText(1, 143) Then AddRec IDEFFAGE, 1, 143
    If Not hasText(1, 144) Then AddRec IDEXT, 1, 144
    If Not hasText(1, 145) Then AddRec IDROOFSUF, 1, 145
    If Not hasText(1, 146) Then AddRec IDTOTPARK, 1, 146
    If Not hasText(1, 147) Then AddRec IDRATIO, 1, 147
    If Not hasText(1, 148) Then AddRec IDTYPE, 1, 148
    If Not hasText(1, 149) Then AddRec IDGUEST, 1, 149
    checked = 0
    If hasText(1, 149) Then
        error = 0
        checked = checked + 1
        If hasText(1, 158) Then error = error + 1
        If hasText(1, 159) Then error = error + 1
        If hasText(1, 160) Then error = error + 1
        If hasText(1, 161) Then error = error + 1
        If hasText(1, 162) Then error = error + 1
        If hasText(1, 163) Then error = error + 1
        If error > 0 Then
            AddRec IDPROJPLN, 1, 158
        Else
            If Not hasText(1, 153) Then AddRec IDUNITS, 1, 153
            If Not hasText(1, 154) Then AddRec IDUNITSALE, 1, 154
            If Not hasText(1, 155) Then AddRec IDUNITSOLD, 1, 155
            If Not hasText(1, 156) Then AddRec IDUNITRENT, 1, 156
            If Not hasText(1, 157) Then AddRec IDDATASOURCE, 1, 157
        End If
    End If
    error = 0
    If hasText(1, 155) And checked = 0 Then
        checked = checked + 1
        If hasText(1, 152) Then error = error + 1
        If hasText(1, 153) Then error = error + 1
        If hasText(1, 154) Then error = error + 1
        If hasText(1, 155) Then error = error + 1
        If hasText(1, 156) Then error = error + 1
        If hasText(1, 157) Then error = error + 1
        If error > 0 Then
            AddRec IDPROJPLN, 1, 152
        Else
            If Not hasText(1, 159) Then AddRec IDUNITS, 1, 159
            If Not hasText(1, 160) Then AddRec IDUNITSALE, 1, 160
            If Not hasText(1, 161) Then AddRec IDUNITSOLD, 1, 161
            If Not hasText(1, 162) Then AddRec IDUNITRENT, 1, 162
            If Not hasText(1, 163) Then AddRec IDDATASOURCE, 1, 163
        End If
    End If
    If Not checked Then AddRec IDPHASES, 1, 152
    If Not hasText(1, 164) Then AddRec IDUNITS, 1, 164
    If Not hasText(1, 165) Then AddRec IDUNITSCOMPL, 1, 165
    If Not hasText(1, 166) Then AddRec IDUNITSALE, 1, 166
    If Not hasText(1, 167) Then AddRec IDUNITSOLD, 1, 167
    If Not hasText(1, 168) Then AddRec IDUNITRENT, 1, 168
    If Not hasText(1, 169) Then AddRec IDDATASOURCE, 1, 169

    checked = GetCheck(1, 170) + GetCheck(1, 171) + GetCheck(1, 172) + _
    GetCheck(1, 173) + GetCheck(1, 174) + GetCheck(1, 175) + GetCheck(1, 176)
    If checked > 1 Then AddRec IDPRJTPECHK, 1, 131
    If checked = 0 Then AddRec IDPROJTYPE, 1, 131

    If Not hasText(1, 175) Then AddRec IDCOND, 1, 0
   
    checked = GetCheck(1, 179) + GetCheck(1, 180)
    If checked > 1 Then AddRec IDHEATCHK, 1, 179
    If checked = 0 Then AddRec IDHEATNOCHK, 1, 179
    
    If isChecked(1, 180) And Not hasText(1, 181) Then AddRec IDHEATCOOL, 1, 180

    If Not hasText(1, 182) Then AddRec IDCMMELE, 1, 182
    
    checked = GetCheck(1, 183) + GetCheck(1, 184)
    If checked > 1 Then AddRec IDCMMELECHK, 1, 183
    If checked = 0 Then AddRec ICCMMELENO, 1, 183
    
    checked = GetCheck(1, 185) + GetCheck(1, 186)
    If checked > 1 Then AddRec IDHOACHK, 1, 185
    If checked = 0 Then AddRec IDHOANOCHK, 1, 185
    
    If isChecked(1, 187) Then AddRec IDCMMELECOM, 1, 187
    
    checked = GetCheck(1, 188) + GetCheck(1, 189)
    If checked > 1 Then AddRec IDCMMELECHK, 1, 188
    If checked = 0 Then AddRec ICCMMELENO, 1, 188
   
End Sub

Sub ReviewSubjectUnit
    AddTitle String(5, "=") + "FNMA Condo 94 " + IDROOMLIST + String(5, "=")    
    If Not hasText(1, 238) Then
        AddRec IDROOMCNT, 1, 238
    Else
        If GetText(2, 50) <> GetText(1, 238) Then AddRec IDROOMCMP, 1, 238
    End If
    If Not hasText(1, 239) Then
        AddRec IDBEDCNT, 1, 239
    Else
        If GetText(2, 51) <> GetText(1, 239) Then AddRec IDBEDCMP, 1, 239
    End If
    If Not hasText(1, 237) Then
        AddRec IDBATHCNT, 1, 240
    Else
        If GetText(2, 52) <> GetText(1, 240) Then AddRec IDBATHCMP, 1, 240
    End If
    If Not hasText(1, 241) Then
        AddRec IDGLA, 1, 241
    Else
        If GetText(2, 53) <> GetText(1, 241) Then AddRec IDGLACMP, 1, 241
    End If
    
    If Not hasText(1, 242) Then AddRec IDFLOOR, 1, 242
    If Not hasText(1, 243) Then AddRec IDLEVELS, 1, 243
    If Not hasText(1, 244) Then AddRec IDFLOORING, 1, 244
    If Not hasText(1, 245) Then AddRec IDWALLS, 1, 245
    If Not hasText(1, 246) Then AddRec IDBATHFLOOR, 1, 246
    If Not hasText(1, 247) Then AddRec IDWAINSCOT, 1, 247
    If Not hasText(1, 248) Then AddRec IDHEATTYPE, 1, 248
    If Not hasText(1, 249) Then AddRec IDHEATFUEL, 1, 249
    If Not hasText(1, 250) Then AddRec IDHEATCOND, 1, 250
    If Not hasText(1, 253) Then AddRec IDCOOLCOND, 1, 253
    If Not hasText(1, 261) Then AddRec IDFIREPLACE, 1, 261
    
    checked = GetCheck(1, 277) + GetCheck(1, 279) + GetCheck(1, 276)
    If checked > 1 Then AddRec IDCARGAR2, 1, 276
    If checked = 0 Then AddRec IDCARERROR, 1, 276
        
    If isChecked(1, 277) And Not hasText(1, 278) Then
        AddRec IDNUMOFCARS, 1, 277
    End If
    If isChecked(1, 279) And Not hasText(1, 280) Then
        AddRec IDNUMOFCARS, 1, 279
    End If
    
    If isChecked(1, 276) And checked > 1 Then AddRec IDCARNONE, 1, 276
   
End Sub

Sub ReviewComments
  AddTitle String(5, "=") + "FNMA Condo 94 " + IDIMPROVCOMM + String(5, "=")    
    If Not hasText(1, 298) Then AddRec IDCOND, 1, 298
    If Not hasText(1, 299) Then AddRec IDADVERSE, 1, 299
 
End Sub

Sub ReviewProjectAnalysis

    AddTitle String(5, "=") + "FNMA Condo 94 " + IDANALYSIS + String(5, "=")    
    If Not hasText(2, 5) Then AddRec IDUNITCHR, 2, 5
    If Not hasText(2, 6) Then AddRec IDPERYR, 2, 6
    If Not hasText(2, 7) Then AddRec IDANNUAL, 2, 7
    
    checked = GetCheck(2, 8) + GetCheck(2, 9)
    If checked > 1 Then AddRec IDGRDCHK, 2, 8
    If checked = 0 Then AddRec IDGRDNOCHK, 2, 8
    
    If isChecked(2, 8) And Not hasText(2, 10) Then AddRec IDGRDRENT, 2, 8
    checked = GetCheck(2, 12) + GetCheck(2, 13) + GetCheck(2, 14) + _
    GetCheck(2, 15) + GetCheck(2, 16) + GetCheck(2, 17)
    If checked = 0 Then AddRec IDUTLNOCHK, 2, 8
    
    If isChecked(2, 11) And checked > 1 Then AddRec IDUTLNONE, 2, 11
   
    If Not hasText(2, 18) Then AddRec IDFEES, 2, 0
    
    checked = GetCheck(2, 19) + GetCheck(2, 20) + GetCheck(2, 21)
    If checked > 1 Then AddRec IDUNITRGNCHK, 2, 19
    If checked = 0 Then AddRec IDUNITRGNNO, 2, 9
    
    checked = GetCheck(2, 22) + GetCheck(2, 23) + GetCheck(2, 24)
    If checked > 1 Then AddRec IDBUDGETCHK, 2, 22
    If checked = 0 Then AddRec IDBUDGETNO, 2, 22
    
    checked = GetCheck(2, 25) + GetCheck(2, 26) + GetCheck(2, 27)
    If checked > 1 Then AddRec IDMNGNOCHK, 2, 25
    If checked = 0 Then AddRec IDMNGCHK, 2, 25
    
    checked = GetCheck(2, 29) + GetCheck(2, 30)
    If checked > 1 Then AddRec IDQLMANCHK, 2, 25
    If checked = 0 Then AddRec IDQLMANNO, 2, 25
    

    If Not hasText(2, 28) Then AddRec IDSPECIALCHR, 2, 28
        
End Sub

Sub ReviewSalesComparison
  AddTitle String(5, "=") + "FNMA Condo 94 " + IDSALESAPP + String(5, "=")
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
  If Not hasText(2, 32) Then AddRec IDSUBADD, 2, 32
  If Not hasText(2, 33) Then AddRec IDSUBNAME, 2, 33
  If Not hasText(2, 34) Then AddRec IDSUBSALES, 2, 34
  If Not hasText(2, 35) Then AddRec IDSUBPRGLA, 2, 35
  If Not hasText(2, 36) Then AddRec IDSUBDATA, 2, 36
  If Not hasText(2, 37) Then AddRec IDSUBVER, 2, 37
  If Not hasText(2, 38) Then AddRec IDSUBLOC, 2, 38
  If Not hasText(2, 39) Then AddRec IDSUBLEASE, 2, 39
  If Not hasText(2, 40) Then AddRec IDHOAMOA, 2, 40
  If Not hasText(2, 41) Then AddRec IDCOMMONEL, 2, 41
  If Not hasText(2, 42) Then AddRec IDRECFAL, 2, 42
  If Not hasText(2, 43) Then AddRec IDPROJSIZE, 2, 43
  If Not hasText(2, 44) Then AddRec IDSUBFLOOR, 2, 44
  If Not hasText(2, 45) Then AddRec IDSUBVIEW, 2, 45
  If Not hasText(2, 46) Then AddRec IDSUBDESIGN, 2, 46
  If Not hasText(2, 47) Then AddRec IDSUBQUAL, 2, 47
  If Not hasText(2, 48) Then AddRec IDSUBAGE, 2, 48
  If Not hasText(2, 49) Then AddRec IDSUBCOND, 2, 49
  If Not hasText(2, 50) Then AddRec IDSUBROOMS, 2, 50
  If Not hasText(2, 51) Then AddRec IDSUBBED, 2, 51
  If Not hasText(2, 52) Then AddRec IDSUBBATHS, 2, 52
  If Not hasText(2, 53) Then AddRec IDSUBGLA, 2, 53
  If Not hasText(2, 54) Then AddRec IDSUBBASE, 2, 54
  If Not hasText(2, 55) Then AddRec IDSUBBASE, 2, 55
  If Not hasText(2, 56) Then AddRec IDSUBFUNC, 2, 56
  If Not hasText(2, 57) Then AddRec IDSUBHEAT, 2, 57
  If Not hasText(2, 58) Then AddRec IDSUBENERGY, 2, 58
  If Not hasText(2, 59) Then AddRec IDSUBGARAGE, 2, 59
  If Not hasText(2, 60) Then AddRec IDSUBPORCH, 2, 60
  If Not hasText(2, 61) Then AddRec IDSUBFIRE, 2, 61
  If Not hasText(2, 263) Then AddRec IDSUBPRIOR, 2, 263
end sub  

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
	price = GetValue(cmpPg, clBase + 3)
  	if price <= 0 then exit Sub
  	IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

	if price/1000 > GetValue(1, 60) or price/1000 < GetValue(1, 59)  then
    	AddRec IDCOMP + IDCOMPSALERANGE,cmpPg, clBase + 3
  	end if
  
	if hasText(cmpPg,clBase + 34) then
    	num = GetValue(cmpPg,clBase + 34)
		if num > GetValue(1, 63) or num < GetValue(1, 62) then
	    	AddRec IDCOMP + IDCOMPAGERANGE, cmpPage, clBase + 34
    	end if
  	end if
  	
	if hasText(cmpPg, clBase + 42) then
		valA = GetValue(2, 53)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 42)
      		if abs(valA - valB)/ valA > 0.25 then
        		AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 42
      		end if
    	end if
  	end if
  
    if hasText(cmpPg, clBase + 4) then
    	valA = GetValue(2, 35)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 4)
      		if abs(valA - valB)/ valA > 10 then
        		AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 4
      		end if
    	end if
  	end if
  	
	for i = 1 to 27
		cmpCl = clBase + GetAdjCell(i)
    	adjString = GetAdjString(i)
    	adj = GetValue(cmpPg,cmpCl)
    	if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  	next
  
    netAdj = GetValue(cmpPg, clBase + 64)
  	if abs(netAdj)/price > 0.15  then
    	AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 64
  	else
    	AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 64
  	end if
    
End Sub

Sub ReviewReconciliation
    AddTitle String(5, "=") + "FNMA Condo 94 " + IDRECON + String(5, "=")
    If Not hasText(2, 276) Then AddRec IDSALEVALUE, 2, 276

    If isChecked(1, 23) Then
      If Not hasText(2, 277) Then AddRec IDINCOMERENT, 2, 277
      If Not hasText(2, 278) Then AddRec IDINCOMEGRM, 2, 278
      If Not hasText(2, 279) Then
        AddRec IDINCOMEVALUE, 2, 279
      Else
        num = GetValue(2, 279) / 1000
        If num > GetValue(1, 60) Or num < GetValue(1, 59) Then _
            AddRec IDSUBAGERANGE, 2, 279
      End If
    End If

    checked = GetCheck(2, 281) + GetCheck(2, 282) + GetCheck(2, 283)
    If checked > 1 Then AddRec IDSTATUSNOCHK, 2, 281
    If checked = 0 Then AddRec IDSTATUSCHK, 2, 281

    If Not hasText(2, 284) Then AddRec IDCONDCOMM, 2, 284
    If Not hasText(2, 285) Then AddRec IDFINALCOM, 2, 285
    If Not hasText(2, 286) Then AddRec IDFANNIEMAE, 2, 286
    If Not hasText(2, 287) Then AddRec IDASOF, 2, 287
    If Not hasText(2, 288) Then
        AddRec IDTOBE, 2, 288
    Else
        num = GetValue(2, 288) / 1000
        If num > GetValue(1, 60) Or num < GetValue(1, 59) Then _
            AddRec IDTOBERANGE, 2, 288
    End If

    If Not hasText(2, 290) Then AddRec IDDATESIGNED, 2, 290
    'Show warning if signaturedate not = today's date 
    IsSignatureDateNOTToday 2, 290
    checked = 0
    If hasText(2, 291) Then
        If Not hasText(2, 292) Then AddRec IDCERTSTATE, 2, 292
        checked = checked + 1
    End If

    If hasText(2, 293) Then
        If Not hasText(2, 294) Then AddRec IDLICSTATE, 2, 294
        checked = checked + 1
    End If

    If checked > 0 Then AddRec IDNOCERT, 2, 290
    
End Sub

