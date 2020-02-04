'REV00018.vbs SMALL INCOME Reviewer Script
' 11/10/2014: Fix car/garage error
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 4
cmpBase = 52
cmpOffset = 81

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
    case	12 GetAdjString = IDGRIDGBA
    case	13 GetAdjString = IDABOVEGRADE
    case	14 GetAdjString = IDABOVEGRADE
    case	15,16,17,18 GetAdjString = IDROOMCOUNT
    case	19 GetAdjString = IDGRIDBASEMENT
    case	20 GetAdjString = IDFUNC
    case	21 GetAdjString = IDHEAT
    case	22 GetAdjString = IDGRIDPARK
    case	23 GetAdjString = IDGRIDAMN
    case	24 GetAdjString = IDGRIDFEE
    case	25 GetAdjString = IDOTHER
  end Select
end function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9,10,11,12 GetAdjCell = 14 + (n - 1)*2
    case 13  GetAdjCell = 37
    case 14,15,16,17,18  GetAdjCell = 38 + (n - 15)*6
    case 19,20,21,22,23,24,25  GetAdjCell = 28 + (n-1)*2
  end Select
end Function


Sub ReviewForm()
  ReviewSubject
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewSalesComparison
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
End Sub

Sub ReviewSubject
    AddTitle String(5, "=") + "FNMA 1025 " + IDSUBJECT + String(5, "=")
    If Not hasText(1, 3) Then AddRec IDFILENUM, 1, 3
    If Not hasText(1, 6) Then AddRec IDADDRESS, 1, 6
    If Not hasText(1, 7) Then AddRec IDCITY, 1, 7
    If Not hasText(1, 8) Then AddRec IDSTATE, 1, 8
    If Not hasText(1, 9) Then AddRec IDZIP, 1, 9
    If Not hasText(1, 10) Then AddRec IDLEGAL, 1, 10
    If Not hasText(1, 11) Then AddRec IDCOUNTY, 1, 11
    If Not hasText(1, 12) Then AddRec IDAPN, 1, 12
    If Not hasText(1, 13) Then AddRec IDTAXYEAR, 1, 13
    If Not hasText(1, 14) Then AddRec IDRETAXES, 1, 14
    If Not hasText(1, 15) Then AddRec IDSPECIAL, 1, 15
    If Not hasText(1, 16) Then AddRec IDPROJNAME, 1, 16
    If Not hasText(1, 17) Then AddRec IDMAPREF, 1, 17
    If Not hasText(1, 18) Then AddRec IDCENSUS, 1, 18
    If Not hasText(1, 19) Then AddRec IDBORROWER, 1, 19
    If Not hasText(1, 20) Then AddRec IDCUROWN, 1, 20
    
    checked = GetCheck(1, 21) + GetCheck(1, 22) + GetCheck(1, 23)
    If checked = 0 Then AddRec IDOCCNOCHECK, 1, 21
    If checked > 1 Then AddRec IDOCCCHK, 1, 21
   
 '//Property Rights Appraised
    checked1 = 0
    checked = GetCheck(1, 24) + GetCheck(1, 25) + GetCheck(1, 26)
    If checked = 0 Then AddRec IDPROPNOCHK, 1, 24
    If checked > 1 Then AddRec IDOCCCHK, 1, 24
    
    If isChecked(1, 26) Then
        If (checked > 1) Then AddRec IDPUDCHK, 1, 26
        If Not hasText(1, 28) Then AddRec IDHOA, 1, 28
        checked1 = checked1 + 1
    End If
    
    If isChecked(1, 27) Then
        If Not hasText(1, 28) Then AddRec IDHOA, 1, 28
        checked1 = checked1 + 1
    End If
    

    If checked > 1 And checked1 > 1 Then AddRec IDPROPCHK, 1, 26
                
    If Not hasText(1, 29) Then
        AddRec IDSALESPRICE, 1, 29
    Else
        price = GetValue(1, 29) / 1000
        If (price > GetValue(1, 61)) Or price < GetValue(1, 60) Then _
            AddRec IDSUBSALESRNG, 1, 29
        
        If GetText(4, 7) <> GetText(1, 29) Then AddRec IDSALESPRICECOMP, 1, 29
    End If
    If Not hasText(1, 30) Then AddRec IDDATE, 1, 30
    If Not hasText(1, 31) Then AddRec IDLOAN, 1, 31
    If Not hasText(1, 32) Then AddRec IDLENDER, 1, 32
    If Not hasText(1, 33) Then AddRec IDLENDERADD, 1, 33
End Sub

Sub ReviewNeighborhood
    AddTitle String(5, "=") + "FNMA 1025 " + IDNEIGH + String(5, "=")
    checked = GetCheck(1, 36) + GetCheck(1, 37) + GetCheck(1, 38)
    If checked = 0 Then AddRec IDLOCNOCHK, 1, 36
    If checked > 1 Then AddRec IDLOCCHK, 1, 36

    sum = GetValue(1, 95) + GetValue(1, 96) + GetValue(1, 97) + GetValue(1, 98) + GetValue(1, 100)
    'sum = 100 - sum
    
    checked = GetCheck(1, 39) + GetCheck(1, 40) + GetCheck(1, 41)
    If checked = 0 Then AddRec IDBUILTNOCHK, 1, 39
    If checked > 1 Then AddRec IDBUILTCHK, 1, 39
    
    If isChecked(1, 39) And sum >= 25 Then AddRec IDOVER75, 1, 39
    If isChecked(1, 40) And (sum > 75 Or sum < 25) Then AddRec ID2575, 1, 40
    If isChecked(1, 41) And sum <= 75 Then AddRec IDUNDER25, 1, 41

    checked = GetCheck(1, 42) + GetCheck(1, 43) + GetCheck(1, 44)
    If checked = 0 Then AddRec IDGROWTHNOCHK, 1, 42
    If checked > 1 Then AddRec IDGROWTHCHK, 1, 42

    checked = GetCheck(1, 45) + GetCheck(1, 46) + GetCheck(1, 47)
    If checked = 0 Then AddRec IDPRPVALNOCHK, 1, 45
    If checked > 1 Then AddRec IDPRPVALCHK, 1, 45

    If isChecked(1, 42) Then AddRec IDPRPINC, 1, 42
    
    checked = GetCheck(1, 48) + GetCheck(1, 49) + GetCheck(1, 50)
    If checked = 0 Then AddRec IDDEMANDNOCHK, 1, 48
    If checked > 1 Then AddRec IDDEMANDCHK, 1, 48
 
    checked = GetCheck(1, 51) + GetCheck(1, 52) + GetCheck(1, 53)
    If checked = 0 Then AddRec IDMARKETNOCHK, 1, 51
    If checked > 1 Then AddRec IDMARKETCHK, 1, 51
    
    If isChecked(1, 51) And (isChecked(1, 47) Or isChecked(1, 50)) Then AddRec IDMarketUnder, 1, 51
   
    If isChecked(1, 50) And (isChecked(1, 45) Or isChecked(1, 48)) Then AddRec IDMarketOver, 1, 50
       
    If isChecked(1, 38) Or isChecked(1, 41) Or isChecked(1, 44) Or isChecked(1, 47) Or isChecked(1, 50) Or isChecked(1, 53) Then
        AddRec IDRCOMMENT, 1, 38
    End If
    
    If sum <> 100 Then AddRec IDLANDUSE, 1, 95

    If hasText(1, 98) And (Not hasText(2, 194)) And (Not hasText(2, 195)) Then
        AddRec IDCOMLAND, 1, 98
    End If

    checked = GetCheck(1, 102) + GetCheck(1, 103)
   
    If checked And Not hasText(1, 104) Then AddRec IDLANDCHANGE, 1, 104
    
    checked = checked + GetCheck(1, 101)
    If checked = 0 Then AddRec IDLANDNOCHK, 1, 51
    If checked > 1 Then AddRec IDLANDCHK, 1, 51
    
    checked = GetCheck(1, 54) + GetCheck(1, 56)
    If checked = 0 Then AddRec IDOCCUPANCY, 1, 54
    If checked > 1 Then AddRec IDOCCUPANCYCK, 1, 54

    checked = GetCheck(1, 58) + GetCheck(1, 59)
    If checked = 0 Then AddRec IDOCCVAN, 1, 58
    If checked > 1 Then AddRec IDOCCVACCHK, 1, 58
    checked = 0
    
    If Not hasText(1, 60) Then
        AddRec IDLOWPRICE, 1, 60
    Else
         checked = checked + 1
    End If
    If Not hasText(1, 61) Then
        AddRec IDHIGHPRICE, 1, 0
    Else
         checked = checked + 1
    End If
    If (checked = 2) Then
        If (GetValue(1, 61)) < GetValue(1, 60) Then AddRec IDPRICECK, 1, 60
    end if
    If Not hasText(1, 62) Then AddRec IDPREDPRICE, 1, 62

    If (GetValue(1, 62) > GetValue(1, 61)) Or (GetValue(1, 62) < GetValue(1, 60)) Then _
        AddRec IDPRICERANGE, 1, 61
   
    checked = 0
    If Not hasText(1, 63) Then
        AddRec IDLOWAGE, 1, 63
    Else
         checked = checked + 1
    End If
    
    If Not hasText(1, 64) Then
        AddRec IDHIGHAGE, 1, 64
    Else
         checked = checked + 1
    End If
    If (checked = 2) Then
        If (GetValue(1, 64)) < GetValue(1, 63) Then AddRec IDAGECK, 1, 63
    end if
    If Not hasText(1, 65) Then AddRec IDPREDAGE, 1, 65

    If (GetValue(1, 65) > GetValue(1, 64)) Or (GetValue(1, 65) < GetValue(1, 63)) Then _
        AddRec IDAGERANGE, 1, 64

    checked = GetCheck(1, 66) + GetCheck(1, 68) + GetCheck(1, 70) + GetCheck(1, 71)
    If checked = 0 Then AddRec IDOCCUPANCY, 1, 64
    If checked > 1 Then AddRec IDOCCUPANCYCK, 1, 64

    If Not hasText(1, 72) Then
        AddRec IDLOWPRICE, 1, 72
    Else
        checked = checked + 1
    End If
    
    If Not hasText(1, 73) Then
        AddRec IDHIGHPRICE, 1, 73
    Else
        checked = checked + 1
    End If
    
    If (checked = 2) Then
        If (GetValue(1, 73)) < GetValue(1, 72) Then AddRec IDPRICECK, 1, 72
    end if
    If Not hasText(1, 74) Then AddRec IDPREDPRICE, 1, 74

    If (GetValue(1, 74) > GetValue(1, 73)) Or GetValue(1, 74) < GetValue(1, 72) Then _
        AddRec IDPRICERANGE, 1, 73

    If Not hasText(1, 75) Then
        AddRec IDLOWAGE, 1, 75
    Else
         checked = checked + 1
    End If
    
    If Not hasText(1, 76) Then
        AddRec IDHIGHAGE, 1, 76
    Else
        checked = checked + 1
    End If
    
    If (checked = 2) Then
        If (GetValue(1, 76)) < GetValue(1, 75) Then AddRec IDAGECK, 1, 75
    end if 
    If Not hasText(1, 77) Then AddRec IDPREDAGE, 1, 77

    If (GetValue(1, 77) > GetValue(1, 76)) Or (GetValue(1, 77) < GetValue(1, 75)) Then _
        AddRec IDAGERANGE, 1, 76
    
    If Not hasText(1, 77) Then AddRec IDTYPE, 1, 77
        
    If Not hasText(1, 79) Then AddRec IDSTORIES, 1, 79
    
    If Not hasText(1, 80) Then AddRec INUNITS, 1, 80
        
    If Not hasText(1, 78) Then AddRec IDAGE, 1, 0
        
    If Not hasText(1, 82) Or Not hasText(1, 83) Then AddRec IDTYPRENT, 1, 82
    
    checked = GetCheck(1, 84) + GetCheck(1, 85) + GetCheck(1, 86)
    If checked = 0 Then AddRec IDTYPRENTRNG, 1, 84
    If checked > 1 Then AddRec IDTYPRENTCHK, 1, 84

    If Not hasText(1, 87) Then AddRec IDESTNIEGH, 1, 87
        
    checked = GetCheck(1, 88) + GetCheck(1, 89) + GetCheck(1, 90)
    If checked = 0 Then AddRec IDESTNIEGHNOCHK, 1, 88
    If checked > 1 Then AddRec IDESTNIEGHCHK, 1, 88

    checked = GetCheck(1, 91) + GetCheck(1, 92) + GetCheck(1, 93)
    If checked = 0 Then AddRec IDRENTCTRLNOCHK, 1, 91
    If checked > 1 Then AddRec IDRENTCTRLCHK, 1, 91
    
    If Not hasText(1, 94) And (isChecked(1, 91) Or isChecked(1, 93)) Then AddRec IDRENTCTRL, 1, 94
    

    If Not hasText(1, 105) Then AddRec IDNEIGHCHAR, 1, 105
    If Not hasText(1, 106) Then AddRec IDNEIGHMARKET, 1, 106
    If Not hasText(1, 107) Then AddRec IDADDRESS, 1, 107
    If Not hasText(1, 108) Then AddRec IDCITY, 1, 108
    If Not hasText(1, 109) Then AddRec IDLISTING, 1, 109
    If Not hasText(1, 110) Then AddRec IDGBA, 1, 110
    If Not hasText(1, 111) Then AddRec IDSUBDATA, 1, 111
    If Not hasText(1, 112) Then AddRec IDUNITS, 1, 112
    If Not hasText(1, 113) Then AddRec IDSUBROOMS, 1, 113
    If Not hasText(1, 114) Then AddRec IDSUBBED, 1, 114
    If Not hasText(1, 115) Then AddRec IDSUBBATHS, 1, 115
    If Not hasText(1, 116) Then AddRec IDYEAR, 1, 116
    If Not hasText(1, 117) Then AddRec IDDAYON, 1, 117
    If Not hasText(1, 160) Then AddRec IDCOMPLIST, 1, 160
    If Not hasText(1, 161) Then AddRec IDNEIGHCOND, 1, 161

End Sub

Sub ReviewSite
    AddTitle String(5, "=") + "FNMA 1025 " + IDSite + String(5, "=")    
    If Not hasText(1, 162) Then AddRec IDDIMEN, 1, 162
    If Not hasText(1, 163) Then
        AddRec IDSITEAREA, 1, 163
    Else

        'If GetText(4, 17) <> GetText(1, 163) Then _
            AddRec IDSITECOMPARE, 1, 0
    End If
      
    checked = GetCheck(1, 164) + GetCheck(1, 165)
    If checked = 0 Then AddRec IDCORNERNOCK, 1, 164
    If checked > 1 Then AddRec IDCORNERCK, 1, 164

    If Not hasText(1, 166) Then AddRec IDZONINGCLAS, 1, 166
     
    checked = GetCheck(1, 167) + GetCheck(1, 168) + GetCheck(1, 169) + GetCheck(1, 170)
    If checked = 0 Then AddRec IDZONINGNOCHK, 1, 164
    If checked > 1 Then AddRec IDZONINGCOM, 1, 164

    If isChecked(1, 168) Then AddRec IDNONCOFORM, 1, 168
    If isChecked(1, 169) Then AddRec IDILLEGAL, 1, 169
    If isChecked(1, 170) Then AddRec IDNOZONE, 1, 170

    checked = GetCheck(1, 171) + GetCheck(1, 172)
    If checked = 0 Then AddRec IDHIGHNOCK, 1, 171
    If checked > 1 Then AddRec IDHIGHBESTCK, 1, 171
    
    If isChecked(1, 172) And Not hasText(1, 173) Then AddRec IDOTHERUSE, 1, 172

    If hasText(1, 175) Then
      If isChecked(1, 174) Then AddRec IDELECCK, 1, 174
      AddRec IDELECCOMM, 1, 175
    Else
        If Not isChecked(1, 174) Then AddRec IDELECNOCK, 1, 174
    End If
    
    If hasText(1, 177) Then
      If isChecked(1, 176) Then AddRec IDGASCK, 1, 176
      AddRec IDGASCOMM, 1, 177
    Else
        If Not isChecked(1, 176) Then AddRec IDGASNOCK, 1, 176
    End If

    If hasText(1, 179) Then
      If isChecked(1, 178) Then AddRec IDWATERCK, 1, 178
      AddRec IDWATERCOMM, 1, 179
    Else
        If Not isChecked(1, 178) Then AddRec IDWATERNOCK, 1, 178
    End If

    If hasText(1, 181) Then
      If isChecked(1, 180) Then AddRec IDSANCK, 1, 180
      AddRec IDSANCOMM, 1, 181
    Else
        If Not isChecked(1, 180) Then AddRec IDSANNOCK, 1, 180
    End If

    If hasText(1, 183) Then
      If isChecked(1, 182) Then AddRec IDSTORMCK, 1, 182
      AddRec IDSTORMCOMM, 1, 183
    Else
        If Not isChecked(1, 182) Then AddRec IDSTORMNOCK, 1, 182
    End If

    If Not hasText(1, 184) Then AddRec IDSTREETTYPE, 1, 184
    
    checked = GetCheck(1, 185) + GetCheck(1, 186)
    If checked = 0 Then AddRec IDSTREETNOCK, 1, 185
    If checked > 1 Then AddRec IDSTREETCK, 1, 185
    
    If isChecked(1, 186) Then AddRec IDSTREETPRIV, 1, 186
        
    If Not hasText(1, 187) Then AddRec IDCURBTYPE, 1, 187
    
    checked = GetCheck(1, 188) + GetCheck(1, 189)
    If checked = 0 Then AddRec IDCURBNOCHK, 1, 188
    If checked > 1 Then AddRec IDCURBCK, 1, 188
    
    If isChecked(1, 189) Then AddRec IDCURBPRIV, 1, 189
        
    If Not hasText(1, 190) Then AddRec IDSIDETYPE, 1, 190
    
    checked = GetCheck(1, 191) + GetCheck(1, 192)
    If checked = 0 Then AddRec IDSIDENOCK, 1, 191
    If checked > 1 Then AddRec IDSIDECK, 1, 191
    
    If isChecked(1, 192) Then AddRec IDSIDEPRIV, 1, 192
        
    If Not hasText(1, 193) Then AddRec IDLIGHTTYPE, 1, 193
    
    checked = GetCheck(1, 194) + GetCheck(1, 195)
    If checked = 0 Then AddRec IDLIGHTNOCK, 1, 194
    If checked > 1 Then AddRec IDLIGHTCK, 1, 194
    
    If isChecked(1, 195) Then AddRec IDLIGHTPRIV, 1, 195
        
    If Not hasText(1, 199) Then AddRec IDTOPOGRAPHY, 1, 199
    If Not hasText(1, 200) Then AddRec IDSIZE, 1, 200
    If Not hasText(1, 201) Then AddRec IDSHAPE, 1, 201
    If Not hasText(1, 202) Then AddRec IDDRAINAGE, 1, 202
    If Not hasText(1, 203) Then
        AddRec IDVIEW, 1, 203
    Else
        If GetText(4, 18) <> GetText(1, 203) Then AddRec IDVIEWCOMPARE, 1, 203
    End If
    If Not hasText(1, 204) Then AddRec IDLANDSCAPING, 1, 204
    If Not hasText(1, 205) Then AddRec IDDRVSURFACE, 1, 205
    If Not hasText(1, 206) Then AddRec IDEASEMENTS, 1, 206
    If Not hasText(1, 208) And hasText(1, 207) Then AddRec IDEASEMENTS, 1, 207
    
    If isChecked(1, 209) Then
        If Not hasText(1, 211) Then AddRec IDFEMAZONE, 1, 211
        If Not hasText(1, 212) Then AddRec IDFEMADATE, 1, 212
        If Not hasText(1, 213) Then AddRec IDFEMAMAP, 1, 213
    End If
    
    checked = GetCheck(1, 209) + GetCheck(1, 210)
    If checked = 0 Then AddRec IDFEMANOCK, 1, 209
    If checked > 1 Then AddRec IDFEMACK, 1, 209
    
    If Not hasText(1, 214) Then AddRec IDSITECOMMENTS, 1, 214
    
End Sub

Sub ReviewImprovements
    AddTitle String(5, "=") + "FNMA 1025 " + IDIMPROV + String(5, "=") 
    If Not hasText(2, 5) Then AddRec INUNITS, 2, 5
    If Not hasText(2, 6) Then AddRec IDBLDGS, 2, 6
    If Not hasText(2, 7) Then AddRec IDSTORIES, 2, 7
    If Not hasText(2, 8) Then AddRec IDTYPE, 2, 8
    If Not hasText(2, 9) Then AddRec IDDESIGN, 2, 9
    If Not hasText(2, 10) Then AddRec IDEXISTING, 2, 10
    If Not hasText(2, 11) Then AddRec IDCONSTRUT, 2, 11
    If Not hasText(2, 12) Then AddRec IDYEAR, 2, 12
    If Not hasText(2, 13) Then AddRec IDEFFAGE, 2, 13
    If Not hasText(2, 15) And hasText(2, 14) Then AddRec IDXTRAIMP, 2, 14
    If Not hasText(2, 16) Then AddRec IDFOUNDATION, 2, 16
    If Not hasText(2, 17) Then AddRec IDEXT, 2, 17
    If Not hasText(2, 18) Then AddRec IDROOFSUF, 2, 18
    If Not hasText(2, 19) Then AddRec IDGUTTER, 2, 19
    If Not hasText(2, 20) Then AddRec IDWINDOWTYPE, 2, 20
    If Not hasText(2, 21) Then AddRec IDSTORMSCR, 2, 21
    
    checked = GetCheck(2, 22) + GetCheck(2, 23)
    If checked = 0 Then AddRec IDMANUNOCK, 2, 22
    If checked > 1 Then AddRec IDMANUCK, 2, 22

    If Not hasText(2, 24) Then AddRec IDSLAB, 2, 24
    If Not hasText(2, 25) Then AddRec IDCRAWL, 2, 25
    If Not hasText(2, 26) Then AddRec IDSUMP, 2, 26
    If Not hasText(2, 27) Then AddRec IDDAMPNESS, 2, 27
    If Not hasText(2, 28) Then AddRec IDSETTLEMENT, 2, 28
    If Not hasText(2, 29) Then AddRec IDINFEST, 2, 29
    If Not hasText(2, 30) Then AddRec IDBASEMENT, 2, 30
    If Not hasText(2, 31) Then AddRec IDBASEFIN, 2, 31
    If Not hasText(2, 33) And hasText(2, 32) Then AddRec IDXTRAFON, 2, 32
    If Not hasText(2, 102) Then AddRec IDROOMCNT, 2, 102
    If Not hasText(2, 103) Then AddRec IDBEDCNT, 2, 103
    If Not hasText(2, 104) Then AddRec IDBATHCNT, 2, 104
    If Not hasText(2, 105) Then AddRec IDGLA, 2, 105
    If Not hasText(2, 106) Then AddRec IDFLOOR, 2, 106
    If Not hasText(2, 107) Then AddRec IDWALLS, 2, 107
    If Not hasText(2, 108) Then AddRec IDTRIM, 2, 108
    If Not hasText(2, 109) Then AddRec IDBATHFLOOR, 2, 109
    If Not hasText(2, 110) Then AddRec IDWAINSCOT, 2, 110
    If Not hasText(2, 111) Then AddRec IDDOORS, 2, 111
    If Not hasText(2, 118) Then AddRec IDHEATTYPE, 2, 118
    If Not hasText(2, 119) Then AddRec IDHEATFUEL, 2, 119
    If Not hasText(2, 120) Then AddRec IDHEATCOND, 2, 120
    If Not hasText(2, 125) Then AddRec IDCOOLCOND, 2, 125
        
    checked = GetCheck(2, 138) + GetCheck(2, 139) + GetCheck(2, 140) + GetCheck(2, 141) + _
    GetCheck(2, 142) + GetCheck(2, 143)
    If isChecked(2, 137) And checked Then AddRec IDATTICNONE, 2, 137
    checked = checked + GetCheck(2, 137)
    If checked = 0 Then AddRec IDATTICNOCK, 2, 137

    If Not hasText(2, 117) Then AddRec IDFIREPLACE, 2, 117
        
    
	checked = GetCheck(2, 147) + GetCheck(2, 148) + GetCheck(2, 154) 
    'If (checked <> 2 And isChecked(2, 147)) Then AddRec IDCARGAR, 2, 147
    'If (checked And Not isChecked(2, 147)) Then AddRec IDCARNOGAR, 2, 147
    'checked = checked + GetCheck(2, 148)
    'If (isChecked(1, 154)) And checked Then AddRec IDCARNONE, 2, 148
    'checked = checked + GetCheck(2, 154)
    'If Not checked Then AddRec IDCARERROR, 2, 147
	if checked > 1 then
	  AddRec "**CAR STORAGE:" & MANY_CHECK_BOXES, 2, 147
	end if
    if isChecked(2, 147) and isChecked(2, 149) and isChecked(2, 150) then
      AddRec "CAR STORAGE: Garage should be either Attached, Detached, or Built-In.", 2, 147
	end if 	 
	if isChecked(2, 148) and isChecked(2, 149) and isChecked(2, 150) then
	  AddRec "CAR STORAGE: Carport should be Attached, Detached, or Built-In.", 2, 148
	end if
	
	if isChecked(2, 154) and getValue(2,146) > 0 then 
	    AddRec IDCarNone, 2, 146 
	end if

    if isChecked(2, 147) or isChecked(2, 148) then
	  if getValue(2, 146) = 0  then
	    AddRec "**CAR STORAGE: # of cars missing.", 2, 146
	  end if
    end if	
	
	if GetValue(2, 146) > 0 then
	  if not isChecked(2, 147) and not isCHecked(2, 148) then
	    AddREc "** CAR STORAGE: No check box has been checked", 2, 147
      end if 		
	end if
	
	if checked > 0 and GetValue(2, 146) > 0 then
	  if not isChecked(2, 149) and not isChecked(2, 150) and not isChecked(2, 153) then
	    AddRec IDCARGAR, 2, 149 
	  end if
	end if
	
	  
	
	

   
    checked = GetCheck(2, 151) + GetCheck(2, 152)
    If checked = 0 Then AddRec IDADDENCK, 2, 151
    If checked > 1 Then AddRec IDADDCHK, 2, 151
    
    If Not hasText(2, 157) Then AddRec IDDEPRE, 2, 157
    If Not hasText(2, 156) Then AddRec IDCOND, 2, 156
    If Not hasText(2, 158) Then AddRec IDADVERSE, 2, 158
 
End Sub

Sub ReviewCostApproach
   AddTitle String(5, "=") + "FNMA 1025 " + IDCOSTAPP + String(5, "=")     
   If Not hasText(2, 159) Then AddRec IDCOSTSITE, 2, 159
   If Not hasText(2, 189) Then AddRec IDCOSTTOTAL, 2, 189
   If Not hasText(2, 197) Then AddRec IDCOSTVALUE, 2, 197
   If Not hasText(2, 198) Then AddRec IDCOSTASIS, 2, 198
   If Not hasText(2, 199) Then AddRec IDCOSTINVAL, 2, 199
   If Not hasText(2, 200) Then AddRec IDCOSTCOMM, 2, 200
End Sub

Sub ReviewSalesComparison
  AddTitle String(5, "=") + "FNMA 1025 " + IDSALESAPP + String(5, "=")
  ReviewSalesSubject
  for pageCmpNo = 1 to 3
    cmpNo = GetCmpNo(pageCmpNo)
    ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
  next
end Sub

Sub ReviewSalesSubject
    If Not hasText(4, 5) Then AddRec IDSUBADD, 4, 5
    If Not hasText(4, 6) Then AddRec IDSUBCITY, 4, 6
    If Not hasText(4, 7) Then AddRec IDSUBSALES, 4, 7
    If Not hasText(4, 8) Then AddRec IDSUBGBA, 4, 8
    If Not hasText(4, 9) Then AddRec IDSUBGMR, 4, 9
    If Not hasText(4, 10) Then AddRec IDSUBGRM, 4, 10
    If Not hasText(4, 11) Then AddRec IDPRICEUNIT, 4, 11
    If Not hasText(4, 12) Then AddRec IDPRICERM, 4, 12
    If Not hasText(4, 13) Then AddRec IDSUBDATA, 4, 13
    If Not hasText(4, 14) Then AddRec IDSUBVER, 4, 14
    If Not hasText(4, 15) Then AddRec IDSUBLOC, 4, 15
    If Not hasText(4, 16) Then AddRec IDSUBLEASE, 4, 16
    If Not hasText(4, 17) Then AddRec IDSUBSITE, 4, 17
    If Not hasText(4, 18) Then AddRec IDSUBVIEW, 4, 18
    If Not hasText(4, 19) Then AddRec IDSUBDESIGN, 4, 19
    If Not hasText(4, 20) Then AddRec IDSUBQUAL, 4, 20
    If Not hasText(4, 21) Then AddRec IDSUBAGE, 4, 21
    If Not hasText(4, 22) Then AddRec IDSUBCOND, 4, 22
    If Not hasText(4, 23) Then AddRec IDSUBGBA2, 4, 23
    If Not hasText(4, 24) Then AddRec IDSUBUNITS, 4, 24
    If Not hasText(4, 25) Then AddRec IDSUBROOMS, 4, 25
    If Not hasText(4, 26) Then AddRec IDSUBBED, 4, 26
    If Not hasText(4, 27) Then AddRec IDSUBBATHS, 4, 27
    If Not hasText(4, 28) Then AddRec IDSUBNOVAC, 4, 28
    If Not hasText(4, 44) Then AddRec IDSUBBASE, 4, 44
    If Not hasText(4, 45) Then AddRec IDSUBFUNC, 4, 45
    If Not hasText(4, 46) Then AddRec IDSUBHEAT, 4, 46
    If Not hasText(4, 47) Then AddRec IDPARK, 4, 47
    If Not hasText(4, 48) Then AddRec IDAMEN, 4, 48
    If Not hasText(4, 49) Then AddRec IDFEEIFANY, 4, 49

    If Not hasText(4, 296) Then AddRec IDSUBPRIOR, 4, 296

    If Not hasText(4, 295) Then AddRec IDCOMMSALECMP, 4, 295
End Sub

Sub ReviewIncomeApproach
    AddTitle String(5, "=") + "FNMA 1025 " + IDINCOME + String(5, "=")  
    checked = GetCheck(2, 151) + GetCheck(2, 152)
    If checked = 0 Then AddRec IDADDENCK, 2, 151
    If checked > 1 Then AddRec IDADDCHK, 2, 151
    
    If isChecked(1, 22) Then
      If Not hasText(4, 309) Then AddRec IDINCOMERENT, 4, 309
      If Not hasText(4, 310) Then AddRec IDINCOMEGRM, 4, 310
      If Not hasText(4, 311) Then
        AddRec IDINCOMEVALUE, 4, 311
      Else
        price = GetValue(4, 311) / 1000
        If (price > GetValue(1, 60)) Or price < GetValue(1, 61) Then _
            AddRec IDSUBAGERANGE, 4, 311
      End If
     End If
     If Not hasText(4, 312) Then AddRec IDCOMINCOME, 4, 312
End Sub


Sub ReviewReconciliation
    AddTitle String(5, "=") + "FNMA 1025 " + IDRECON + String(5, "=")
    If Not hasText(4, 313) Then AddRec IDSALEVALUE, 4, 313
    If Not hasText(4, 314) Then AddRec IDCOMINCOME, 4, 314
    If Not hasText(4, 315) Then AddRec IDCOSTINVAL, 4, 315

    checked = GetCheck(4, 316) + GetCheck(4, 317) + GetCheck(4, 318)
    If checked = 0 Then AddRec IDSTATUSNOCHK, 4, 316
    If checked > 1 Then AddRec IDSTATUSCHK, 4, 316

    If Not hasText(4, 319) Then AddRec IDCONDCOMM, 4, 319
    If Not hasText(4, 320) Then AddRec IDFINALCOM, 4, 320
    If Not hasText(4, 321) Then AddRec IDFANNIEMAE, 4, 321
    If Not hasText(4, 322) Then AddRec IDASOF, 4, 322
    If Not hasText(4, 323) Then
        AddRec IDTOBE, 4, 323
    Else
        valA = GetValue(4, 323)
        valB = GetValue(2, 199)
        num = 0
        If (valA > valB) Then _
            num = 100 - (valB / valA * 100)
        If (valB > valA) Then _
            num = 100 - (valA / valB * 100)
        If (num > 15) Then AddRec IDTOBECOST, 4, 323
        num = GetValue(4, 323) / 1000
        If (num > GetValue(1, 61)) Or (num < GetValue(1, 60)) Then AddRec IDTOBERANGE, 4, 323
    End If

    If Not hasText(4, 325) Then AddRec IDDATESIGNED, 4, 325
     'Show warning if signaturedate not = today's date 
     IsSignatureDateNOTToday 4, 325
    
    checked = 0
      
    If (hasText(4, 326)) Then
        If Not hasText(4, 327) Then AddRec IDCERTSTATE, 4, 327
        checked = checked + 1
    End If

    If (hasText(4, 328)) Then
        If Not hasText(4, 329) Then AddRec IDLICSTATE, 4, 329
        checked = checked + 1
    End If
        
    If Not checked Then AddRec IDNOCERT, 4, 326
    
End Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = pgCmpNo
end Function

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
  price = GetValue(cmpPg, clBase + 5)
  if price <= 0 then exit Sub
  IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

	if price/1000 > GetValue(1, 61) or price/1000 < GetValue(1, 60)  then
    AddRec IDCOMP + IDCOMPSALERANGE,cmpPg, clBase + 5
  end if

  if hasText(cmpPg,clBase + 31) then
    num = GetValue(cmpPg,clBase + 31)
		if num > GetValue(1, 64) or num < GetValue(1, 63) then
	    AddRec IDCOMP + IDCOMPAGERANGE, cmpPage, clBase + 31
    end if
  end if

  if hasText(cmpPg, clBase + 35) then
	  valA = GetValue(4, 23)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 35)
      if abs(valA - valB)/ valA > 0.25 then
        AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 35
      end if
    end if
  end if

  if hasText(cmpPg, clBase + 6) then
    valA = GetValue(4, 8)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 6)
      if abs(valA - valB)/ valA > 10 then
        AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 6
      end if
    end if
  end if

  for i = 1 to 25
	  cmpCl = clBase + GetAdjCell(i)
    adjString = GetAdjString(i)
    adj = GetValue(cmpPg,cmpCl)
    if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  next

  netAdj = GetValue(cmpPg, clBase + 79)
  if abs(netAdj)/price > 0.15  then
    AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 79
  else
    AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 79
  end if

end Sub

