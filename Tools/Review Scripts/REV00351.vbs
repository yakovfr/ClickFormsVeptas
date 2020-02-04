'REV00351.vbs 2090 Reviewer Script
' 04/25/2013: For Amenities: Add an additional checking when these cell values page 2: 38, 40, 42, 44, 46 is None treat them like EMPTY string do not enforce check box required rule.

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
  ReviewUnit
  AddTitle ""
  ReviewCOOP
  AddTitle ""
  ReviewSalesSubject
  AddTitle ""
End Sub

Sub ReviewSubject

   AddTitle String(5, "=") + "FNMA 2090 " + IDSUBJECT + String(5, "=")

   Require IDFilenum, 1, 3
   Require IDAddress, 1, 6
   Require IDUNITS, 1, 7
   Require IDCity, 1, 8
   Require IDState, 1, 9
   Require IDZip, 1, 10
   Require IDBorrower, 1, 11
   Require IDCUROWN, 1, 12
   Require IDCounty, 1, 13
   'Require IDLegal, 1, 14
   'FRE1040 : Hard Stop for UAD when Legal Description is missing
   if IsUAD then
     Require "**Subject Legal Description is missing.", 1, 14
   else   
     Require IDLegal, 1, 14
   end if 
   Require IDProjName2, 1, 15
   Require IDPHASE, 1, 16
   Require IDMapref, 1, 17
   Require IDCensus, 1, 18 
   OnlyOneCheckOfFour 1, 19, 20, 21, 22, IDOCCNOCHECK, "OCCUPANT: morethan one box checked"
   Require IDMOMAINT, 1, 23
   
   OnlyOneCheckOfTwo 1, 24, 25, "", "MO MAINT FEE: More than one box checked"
   if not isnegativecomment(1, 23) Then 
     OnlyOneCheckOfTwo 1, 24, 25, IDMOMAINTCK, "MO MAINT FEE: More than one box checked"
   end if

   OnlyOneCheckOfThree 1, 26, 27, 28, IDPRA, "PROPERTY RIGHTS APPRAISED: More than one box checked"
   
   If ischecked(1, 28) then 
     require IDPRAOTHER, 1, 29 
   End If
   
   Require IDLEASEEXPIRE, 1, 29
   Require IDSPECIAL, 1, 30
   OnlyOneCheckOfThree 1, 31, 32, 33, ID_ASSIGNMENT_TYPE_NONE_CHECKED, ID_ASSIGNMENT_TYPE_MANY_CHECKED
   
   If ischecked(1, 33) then 
     require IDASSIGNTYPECOTHER, 1, 34 
   End If
   
   Require IDLender, 1, 35
   Require IDLenderAdd, 1, 36
   OnlyOneCheckOfTwo 1, 37, 38, ID_SUBJECT_FOR_SALE_NONE_CHECKED, ID_SUBJECT_FOR_SALE_MANY_CHECKED
   Require ID_SUBJECT_BLOCK_DATA_SOURCE_REQUIRED, 1, 39

End Sub

Sub ReviewContract

  AddTitle String(5, "=") + "FNMA 2090 " + ID_CONTRACT_BLOCK + String(5, "=")
 
  If not isChecked(1, 32) and not isChecked(1, 33) Then
    ValidateStandardContractBlock 1, 40

    If (not isChecked(1, 32) and not isChecked(1, 33)) and hasText(1, 43) Then
      Require IDCONTRACTFNMA, 1, 31
    End If

    If (not isChecked(1, 32) and not isChecked(1, 33)) and hasText(1, 43) Then
      num = GetValue(1, 43)
        If num > GetValue(3, 314) Then
          AddRec IDCONTRACTFNMA1, 1, 43
        End If
    End If

    If (not isChecked(1, 32) and not isChecked(1, 33)) and hasText(1, 43) Then
      num = GetValue(1, 43)
        If num < GetValue(3, 314) Then
          AddRec IDCONTRACTFNMA2, 1, 43
        End If
    End If
  End If

OnlyOneCheckOfTwo 1, 40, 41, "", "CONTRACT ANALYZED: More than one box checked"
OnlyOneCheckOfTwo 1, 45, 46, "", "SELLER IS OWNER: More than one box checked"
OnlyOneCheckOfTwo 1, 48, 49, "", "SELLER FINANCIAL ASSISTANCE: More than one box checked"

If isnumeric(GetText(1, 43)) then 
  If isChecked(1, 32) or isChecked(1, 33) Then
    Require "ASSIGNMENT TYPE: Subject Assigment Type is incorrect", 1, 31
  End If
End If 

End Sub

Sub ReviewNeighborhood

  AddTitle String(5, "=") + "FNMA 2090 " + IDNeigh + String(5, "=")

  ValidateStandardNeighborhoodBlock107310751004c 1, 51

  If hasText(3, 309) Then
    num = GetValue(3, 309) / 1000
      If num > GetValue(1, 70) Then
        AddRec IDTOBERANGECO, 1,70
      End If
  End If

  If hasText(3, 309) Then
    num = GetValue(3, 309) / 1000
      If num < GetValue(1, 69) Then
        AddRec IDTOBERANGECO, 1,69
      End If
  End If

  sum = GetValue(1, 75) + GetValue(1, 76) + GetValue(1, 77) + GetValue(1, 78) + GetValue(1, 80)
  if sum <> 100 then
    AddRec IDLandUse, 1, 75
  end if

  Require IDNEIGHBOUND, 1, 81
  Require IDNEIGHDES, 1, 82
  Require IDNEIGHCOND, 1, 83
  OnlyOneCheckOfTwo 1, 84, 85, IDMARKACCEPT, "MARKET ACCEPTANCE: Both Yes and No are checked"
   
  If isChecked(1, 85) then 
    Require IDMARKACCEPTNO, 1, 86 
  End If

End Sub

Sub ReviewSite

   AddTitle String(5, "=") + "FNMA 2090 " + IDPRoSite + String(5, "=") 

   Require IDTOPOGRAPHY, 1, 87
   Require IDSITEAREA, 1, 88
   Require IDDENSITY, 1, 89
   Require IDVIEW, 1, 90
   Require IDZONINGCLAS, 1, 91
   Require ID_ZONING_DESCRIPTION_REQUIRED, 1, 92

   OnlyOneCheckOfFour 1, 93, 94, 97, 98, IDZONINGCOM, IDZONINGNOCHK   
   
   OnlyOneCheckOfTwo 1, 95, 96, "", "ZONING PERMITS REBUILD: Both Yes and No checked"
   If isChecked(1, 94) Then
     OnlyOneCheckOfTwo 1, 95, 96, IDNONCOFORM, "ZONING PERMITS REBUILD: Both Yes and No checked"
   End If

   If isChecked(1, 98) Then
     Require IDILLEGAL, 1, 99
   End If

   ValidateSiteBlock 1, 100
          
End Sub

Sub ReviewImprovements

   AddTitle String(5, "=") + "FNMA 2090 " + IDPROJDESCSECTION + String(5, "=")
   
   Require IDUNITSNODES, 1, 132
   Require IDBLDGSDES, 1, 133
   Require IDSTORIESDES, 1, 134
   Require IDELEDES, 1, 135
   OnlyOneCheckOfThree 1, 136, 137, 138, IDEXPROCON, "EXISTING/PROPOSED: more than one box checked"
   Require IDYRBLT, 1, 139
   Require IDCONDITIONDES, 1, 140
   Require IDEXT, 1, 141
   Require IDROOFSUF, 1, 142
   Require IDWINDOWTYPE, 1, 143
   Require IDTYPEPARK, 1, 144
   OnlyOneCheckOfTwo 1, 145, 146, IDPARKGUEST, "PARKING FACILITIES: More than one box checked"
   Require IDPARKSPNUM, 1, 147
   Require IDPARKRATIO, 1, 148
   OnlyOneCheckOfSix 1, 149, 150, 151, 152, 153, 154, ID_PROJECT_DESCRIPTION_NONE_CHECKED, ID_PROJECT_DESCRIPTION_MANY_CHECKED
   
   If isChecked(1, 154) then
     Require IDPROJDESOTHER, 1, 155
   End If
   
   OnlyOneCheckOfThree 1, 156, 157, 158, IDPROJPRIMOCC, "PRIMARY OCCUPANCY: More than one box checked"
   OnlyOneCheckOfThree 1, 159, 160, 161, IDCOOPMGT, IDCOOPMGT 
   
   If isChecked(1, 161) then
     Require IDCOOPMGTAGENT, 1, 162
   End If
   
   OnlyOneCheckOfTwo 1, 163, 164, IDCOOPMASTER, "CO-OP PART OF MASTER: Both yes and No checked"
   
   If isChecked(1, 163) then
     Require IDCOOPMASTERYES, 1, 165
   End If
  
   OnlyOneCheckOfTwo 1, 166, 167, IDCOOPCONVERT, "CO-OP CREATED BY CONVERSION: Both Yes and No checked"
   
   If isChecked(1, 166) then
     Require IDCOOPCONVERTYES, 1, 168
   End If
   
   OnlyOneCheckOfTwo 1, 169, 170, IDPROJCOMMERCIAL, "CO-OP HAS COMMERCIAL: Both Yes and No are checked"
   
   If isChecked(1, 169) then
     Require IDPROJCOMMERCIALYES, 1, 171
   End If
   
   Require IDPROJAMMENITIESCOOP, 1, 172
   OnlyOneCheckOfTwo 1, 173, 174, IDUNITSTYPICAL, "UNITS TYPICAL: Both Yes and No checked"
   
   If isChecked(1, 174) then
     Require IDUNITSTYPICALNO, 1, 175
   End If
   
   Require IDDESCRIBECOND, 1, 176
   OnlyOneCheckOfTwo 1, 177, 178, IDFEESCOOP, "ADDITIONAL FEES: Both Yes and No checked"
   
   If isChecked(1, 177) then
     Require IDFEESCOOPYES, 1, 179
   End If
   
   Require IDFILENUM, 2, 2
   OnlyOneCheckOfTwo 2, 5, 6, IDCOOPMARKET, "CO-OP MARKETABLE: Both Yes and No checked"
   
   If isChecked(2, 5) then
     Require IDCOOPMARKETYES, 2, 7
   End If
   
   OnlyOneCheckOfTwo 2, 8, 9, IDCOOPCONFORMNEIGH, "CO-OP COMFORMS: Both Yes and No checked"
   
   If isChecked(2, 9) then
     Require IDCOOPCONFORMNEIGHNO, 2, 10
   End If

End Sub

Sub ReviewUnit

   AddTitle String(5, "=") + "FNMA 2090 " + IDROOMLIST2 + String(5, "=")
   
   OnlyOneCheckOfNINE 2, 11, 12, 13, 15, 15, 16, 17, 18, 19, IDUTLNOCHK, ""
   
   If isChecked(2, 19) then
     Require IDUTLOTHER, 2, 20
   End If
   
   OnlyOneCheckOfTwo 2, 21, 22, IDUNITSTYPICAL, "UTILITIES TYPICAL: Both Yes and No checked"
   
   If isChecked(2, 22) then
     Require IDUNITSTYPICALNO, 2, 23
   End If

   Require IDFLOORNUM, 2, 24
   Require IDLEVELS, 2, 25
   Require IDHEATTYPEU, 2, 26
   Require IDHEATFUEL, 2, 27
   OnlyOneCheckOfThree 2, 28, 29, 30, IDCOOLCOND2, ""
   
   If isChecked(2, 30) then
     Require IDCOOLOTHER, 2, 31
   End If

   Require IDFLOOR, 2, 32
   Require IDWALLS, 2, 33
   Require IDTRIM, 2, 34
   Require IDWAINSCOT, 2, 35
   Require IDDOORS, 2, 36
   OnlyOneCheckOfFive 2, 37, 39, 41, 43, 45, IDAMENITIES, ""

   If isChecked(2, 37) Then
     Require IDFIREPLACE2, 2, 38
   End If

   If isChecked(2, 39) Then
    Require IDSTOVES2, 2, 40
   End If

   If isChecked(2, 41) Then
    Require IDPATDECK, 2, 42
   End If

   If isChecked(2, 43) Then
    Require IDPORCH2, 2, 44
   End If

   If isChecked(2, 45) Then
    Require IDOTHER2, 2, 46
   End If

  If hasText(2, 38) and (GetValue(2,38)<>0) and not isChecked(2,37)  then
   AddRec IDFIREPLACE2CK, 2, 37  
  End If

  If hasText(2, 40) and (GetValue(2,40)<>0) and not isChecked(2,39)  then
    Require IDSTOVES2CK, 2, 39
  End If

   If hasText(2, 42) and (uCase(GetText(2,42))<>IDNONE) Then
    Require IDPATDECKCK, 2, 41
   End If

   If hasText(2, 44) and (uCase(GetText(2,44))<>IDNONE) Then
    Require IDPORCH2CK, 2, 43
   End If

   If hasText(2, 46) and (uCase(GetText(2,46))<>IDNONE) Then
    Require IDOTHER2CK, 2, 45
   End If

   OnlyOneCheckOfSix 2, 47, 48, 49, 50, 51, 52, IDAPPLIANCE, ""

   checked = GetTextCheck(2, 54) + GetTextCheck(2, 56) + GetTextCheck(2, 58) + GetTextCheck(2, 59)
   if isChecked(2, 53) then
     if checked > 0 then AddRec IDCARNONE , 2, 54
   else
     if checked = 0 then AddRec IDCARERROR, 2, 54
   end if

   If isChecked(2, 54) Then
     Require IDGARNUM, 2, 55
   End If

   If isChecked(2, 56) Then
     Require IDOPENCAR, 2, 57
   End If

   If hasText(2, 55) Then
     Require IDGARNUM2, 2, 54
   End If

   If hasText(2, 57) Then
     Require IDOPENCAR2, 2, 56
   End If

   OnlyOneCheckOfTwo 2, 58, 59, "", "CAR STORAGE: Both Assigned and Owned Checked"
   If isChecked(2, 54) or isChecked(2, 56) Then
     OnlyOneCheckOfTwo 2, 58, 59, IDCARERROR3, "CAR STORAGE: Both Assigned and Owned Checked"
   End If

   Require IDROOMCNT, 2, 61
   Require IDBEDCNT, 2, 62
   Require IDBATHCNT, 2, 63
   Require IDGLA, 2, 64
   Require IDADD, 2, 65
   Require IDCOND, 2, 66
   OnlyOneCheckOfTwo 2, 67, 68, IDADVERSE2, "ADVERSE CONDITIONS: Both Yes and No checked"

   If isChecked(2, 67) Then
     Require IDADVERSE, 2, 69
   End If

End Sub

Sub ReviewCoop

   AddTitle String(5, "=") + "FNMA 2090 " + IDCOOP + String(5, "=")
  
   OnlyOneCheckOfFour 2, 70, 71, 72, 73, IDDSFORCOOP, ""
   Require IDDSFORCOOPDESCRIBE, 2, 74
   Require IDNUMSHARESCOOP, 2, 75
   Require IDNUMSHARESSUBCOOP, 2, 76
   Require IDPRORATACOOP, 2, 77
   Require IDPRORATALIEN, 2, 78
   Require IDMOMAINFEECOOP, 2, 79
   Require IDMOMAINFEEPERYEAR, 2, 80
   Require IDANNUALMAINFEE, 2, 81
   OnlyOneCheckOfTwo 2, 82, 83, IDSPONSORCONTROL, "DEVELOPER CONTROL: Both Yes and No checked"
   OnlyOneCheckOfTwo 2, 84, 85, IDSALESCONCESSCOOP, "DEVELOPER/SPONSOR FINANCING: Both yes and No checked"
   
   If isChecked(2, 84) Then
      Require IDSALESCONCESSCOOPYES, 2, 86
   End If

   OnlyOneCheckOfTwo 2, 87, 88, IDGROUNDRENTCOOP, "GROUND RENT: Both Yes and No checked"

   If isChecked(2, 87) Then
     Require IDCGROUNDRENTCOOPYES, 2, 89
   End If

   If isChecked(2, 87) Then
     Require IDCGROUNDRENTCOOPYESD, 2, 90
   End If

   OnlyOneCheckOfTwo 2, 91, 92, IDLEASECOOP, "FACLITIES LEASED: Both Yes and No checked"

   If isChecked(2, 91) Then
     Require IDLEASECOOPYES, 2, 93
   End If

   OnlyOneCheckOfTwo 2, 94, 95, IDTAXCOOP, "TAX ABATEMENTS: Both Yes and No checked"

   If isChecked(2, 94) Then
     Require IDTAXCOOPYES, 2, 96
   End If

   OnlyOneCheckOfTwo 2, 97, 98, IDSTOCKCOOP, "STOCK TRANSFER FEE: Both Yes and No checked"

   If isChecked(2, 97) Then
     Require IDSTOCKCOOPYES, 2, 99
   End If

   Require IDOWNERNUMBERCOOP, 2, 100
   OnlyOneCheckOfTwo 2, 101, 102, IDENTITYSTOCK, "SINGLE ENTITY 10%: Both Yes and No checked"

   If isChecked(2, 101) Then
     Require IDENTITYSTOCKYES, 2, 103
   End If

   OnlyOneCheckOfTwo 2, 104, 105, IDBUDGETCOOP, "BUDGET ANALYZED: Both Yes and No checked"
   Require IDBUDGETCOOPRESULTS, 2, 106
   Require IDLIENTYPEFIRST, 2, 107
   Require IDMORTGAGEFIRST, 2, 108
   OnlyOneCheckOfTwo 2, 109, 110, IDBALOONFIRST, "FIRST MORTGAGE BALLOON: Both Yes and No checked"
   Require IDTERMFIRST, 2, 111
   Require IDMOPAYFIRST, 2, 112
   Require IDINTERESTFIRST, 2, 113
   OnlyOneCheckOfTwo 2, 114, 115, IDFIXEDFIRST, "FIRST MORTGAGE FIXED: Both Yes and No checked"
   Require IDLIENFIRST, 2, 116
   Require IDLEANTYPESECOND, 2, 117
   Require IDMORTGAGESECOND, 2, 118
   OnlyOneCheckOfTwo 2, 119, 120, IDBALOONSECOND, "SECOND MORTGAGE BALLOON: Both Yes and No checked"
   Require IDTERMSECOND, 2, 121
   Require IDMOPAYSECOND, 2, 122
   Require IDINTERESTSECOND, 2, 123
   OnlyOneCheckOfTwo 2, 124, 125, IDFIXEDSECOND, "SECOND MORTGAGE FIXED: Both Yes and No checked"
   Require IDLIENSECOND, 2, 126
   Require IDLEANTYPEOTHERPRI, 2, 127
   Require IDLEANTYPEOTHER, 2, 128
   Require IDMORTGAGEOTHER, 2, 129
   OnlyOneCheckOfTwo 2, 130, 131, IDBALOONOTHER, "OTHER MORTGAGE BALLOON: Both Yes and No checked"
   Require IDTERMOTHER, 2, 132
   Require IDMOPAYOTHER, 2, 133
   Require IDINTERESTOTHER, 2, 134
   OnlyOneCheckOfTwo 2, 135, 136, IDFIXEDOTHER, "OTHER MORTGAGE FIXED: Both Yes and No checked"
   Require IDLIENOTHER, 2, 137
   Require IDOWNERUNITS, 2, 138
   Require IDOWNERPROJ, 2, 139
   Require IDSPONSORVACUNITS, 2, 140
   Require IDSPONSORVACPROJ, 2, 141
   Require IDSPONSORTENMUNITS, 2, 142
   Require IDSPONSORTENMPROJ, 2, 143
   Require IDSPONSORTENRUNITS, 2, 144
   Require IDSPONSORTENRPROJ, 2, 145
   Require IDINVESTORVUNITS, 2, 146
   Require IDINVESTORVPROJ, 2, 147
   Require IDINVESTORTMUNITS, 2, 148
   Require IDINVESTORTMPROJ, 2, 149
   Require IDINVESTORTRUNITS, 2, 150
   Require IDINVESTORTRPROJ, 2, 151
   Require IDTOTALUNITS, 2, 152
   Require IDTOTALPROJ, 2, 153

End Sub

Sub ReviewSalesSubject

   AddTitle String(5, "=") + "FNMA 2090 " + IDSALESAPP + String(5, "=")
   
   Require IDFILENUM, 3, 2
   Require IDPROPCOMP, 3, 5
   Require IDPROPCOMPFROM, 3, 6
   Require IDPROPCOMPTO, 3, 7
   Require IDSALECOMP, 3, 8
   Require IDSALECOMPFROM, 3, 9
   Require IDSALECOMPTO, 3, 10

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num2 >= num3 and num2 >= num4 Then
         If num > num2 Then
           AddRec IDTOBERANGE2, 3, 58
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num3 >= num2 and num3 >= num4 Then
         If num > num3 Then
           AddRec IDTOBERANGE2, 3, 134
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num4 >= num3 and num4 >= num2 Then
         If num > num4 Then
           AddRec IDTOBERANGE2, 3, 210
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num2 <= num3 and num2 <= num4 Then
         If num < num2 Then
           AddRec IDTOBERANGE2, 3, 58
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num3 <= num2 and num3 <= num4 Then
         If num < num3 Then
           AddRec IDTOBERANGE2, 3, 134
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 58)
     num3 = GetValue(3, 134)
     num4 = GetValue(3, 210)
       If num4 <= num3 and num4 <= num2 Then
         If num < num4 Then
           AddRec IDTOBERANGE2, 3, 210
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num2 >= num3 and num2 >= num4 Then
         If num > num2 Then
           AddRec IDTOBERANGE3, 3, 129
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num3 >= num2 and num3 >= num4 Then
         If num > num3 Then
           AddRec IDTOBERANGE3, 3, 205
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num4 >= num3 and num4 >= num2 Then
         If num > num4 Then
           AddRec IDTOBERANGE3, 3, 281
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num2 <= num3 and num2 <= num4 Then
         If num < num2 Then
           AddRec IDTOBERANGE3, 3, 129
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num3 <= num2 and num3 <= num4 Then
         If num < num3 Then
           AddRec IDTOBERANGE3, 3, 205
         End If
       End If
   End If

   If hasText(3, 314) Then
     num = GetValue(3, 314)
     num2 = GetValue(3, 129)
     num3 = GetValue(3, 205)
     num4 = GetValue(3, 281)
       If num4 <= num3 and num4 <= num2 Then
         If num < num4 Then
           AddRec IDTOBERANGE3, 3, 281
         End If
       End If
   End If

   Require IDSUBADD, 3, 11
   Require IDSUBUNITNO, 3, 12

   If hasText(3, 12) Then
     text1 = GetText(3, 12)
     text2 = GetText(1, 8)
     text3 = GetText(1, 9)
     text4 = GetText(1, 10)
     If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
       AddRec IDADDMATCH, 3, 12
     End If
   End If

   Require IDSUBNAME, 3, 13

   If not isChecked(1, 32) Then
     Require IDSUBSALES, 3, 14
     Require IDSUBPRGLA, 3, 15
   End If
   
   Require IDSUBPRPERSHARE, 3, 16
   Require IDSUBLOC, 3, 22
   Require IDSUBPRJSIZENUM, 3, 23
   Require IDSUBVIEW, 3, 24
   Require IDSUBFLOORLOC, 3, 25
   Require IDSUBMOMAINFEE, 3, 26
   Require IDSUBPRJAMEN, 3, 27
   Require IDSUBFACILITIES, 3, 28
   Require IDSUBPRJSECUR, 3, 29
   Require IDSUBFEATURES, 3, 30
   Require IDSUBDESIGN, 3, 31
   Require IDSUBQUAL, 3, 32
   Require IDSUBAGE, 3, 33
   Require IDSUBCOND, 3, 34
   Require IDSUBREMODEL, 3, 35
   Require IDSUBKITCHBATH, 3, 36
   Require IDSUBROOMS, 3, 37
   Require IDSUBBED, 3, 38
   Require IDSUBBATHS, 3, 39
   Require IDSUBGLA, 3, 40
   Require IDSUBBASE, 3, 41
   If not ((GetText(3, 41) = "0sf") or (GetText(3, 41) = "0sqm")) Then
     Require IDSUBBASEPER, 3, 42
   End If
   Require IDSUBFUNC, 3, 43
   Require IDSUBHEAT, 3, 44
   Require IDSUBENERGY, 3, 45
   Require IDSUBGARAGE, 3, 46
   Require IDSUBPORCH, 3, 47


   Require IDCOMP1ADD, 3, 54
   Require IDCOMP1UNITNO, 3, 55
   Require IDCOMP1NAME, 3, 56
   Require IDCOMP1PROX, 3, 57
   Require IDCOMP1SALES, 3, 58

   If hasText(3, 58) Then
     num = GetValue(3, 58) / 1000
       If num > GetValue(1, 70) Then
         AddRec IDTOBERANGEC10, 3, 58
       End If
   End If

   If hasText(3, 58) Then
     num = GetValue(3, 58) / 1000
       If num < GetValue(1, 69) Then
         AddRec IDTOBERANGEC10, 3, 58
       End If
   End If

   If hasText(3, 58) Then
     num = GetValue(3, 58)
       If num < GetValue(3,9) Then
         AddRec IDTOBERANGE10, 3, 58
       End If
   End If

   If hasText(3, 58) Then
     num = GetValue(3, 58)
       If num > GetValue(3,10) Then
         AddRec IDTOBERANGE10, 3, 58
       End If
   End If

   Require IDCOMP1PRGLA, 3, 59
   Require IDCOMP1PRPERSHARE, 3, 60
   Require IDCOMP1SOURCE, 3, 61
   Require IDCOMP1VER, 3, 62
   Require IDCOMP1SF, 3, 63
   Require IDCOMP1CONC, 3, 65
   Require IDCOMP1DOS, 3, 67
   Require IDCOMP1LOC, 3, 69
   Require IDCOMP1PRJSIZENUM, 3, 71
   Require IDCOMP1VIEW, 3, 73
   Require IDCOMP1FLOORLOC, 3, 75
   Require IDCOMP1MOMAINFEE, 3, 77
   Require IDCOMP1PRJAMEN, 3, 79
   Require IDCOMP1FACILITIES, 3, 81
   Require IDCOMP1PRJSECUR, 3, 83
   Require IDCOMP1FEATURES, 3, 85
   Require IDCOMP1DESIGN, 3, 87
   Require IDCOMP1QUAL, 3, 89
   Require IDCOMP1AGE, 3, 91
   Require IDCOMP1COND, 3, 93
   Require IDCOMP1REMODEL, 3, 95
   Require IDCOMP1KITCHBATH, 3, 97
   Require IDCOMP1ROOMS, 3, 100
   Require IDCOMP1BED, 3, 101
   Require IDCOMP1BATHS, 3, 102
   Require IDCOMP1GLA, 3, 104
   Require IDCOMP1BASE, 3, 106
   If not ((GetText(3, 106) = "0sf") or (GetText(3, 106) = "0sqm")) Then
     Require IDCOMP1BASEPER, 3, 108
   End If
   Require IDCOMP1FUNC, 3, 110
   Require IDCOMP1HEAT, 3, 112
   Require IDCOMP1ENERGY, 3, 114
   Require IDCOMP1GARAGE, 3, 116
   Require IDCOMP1PORCH, 3, 118

   If hasText(3, 129) Then
     num = GetValue(3, 129) / 1000
         If num > GetValue(1, 70) Then
           AddRec IDTOBERANGEC11, 3, 129
         End If
   End If

   If hasText(3, 129) Then
     num = GetValue(3, 129) / 1000
        If num < GetValue(1, 69) Then
          AddRec IDTOBERANGEC11, 3, 129
        End If
   End If

   Require IDCOMP2ADD, 3, 130
   Require IDCOMP2UNITNO, 3, 131
   Require IDCOMP2NAME, 3, 132
   Require IDCOMP2PROX, 3, 133
   Require IDCOMP2SALES, 3, 134


   If hasText(3, 134) Then
     num = GetValue(3, 134) / 1000
       If num > GetValue(1, 70) Then
         AddRec IDTOBERANGEC12, 3, 134
       End If
   End If

   If hasText(3, 134) Then
     num = GetValue(3, 134) / 1000
       If num < GetValue(1, 69) Then
         AddRec IDTOBERANGEC12, 3, 134
       End If
   End If

   If hasText(3, 134) Then
     num = GetValue(3, 134)
       If num < GetValue(3,9) Then
         AddRec IDTOBERANGE11, 3, 134
       End If
   End If

   If hasText(3, 134) Then
     num = GetValue(3, 134)
       If num > GetValue(3,10) Then
         AddRec IDTOBERANGE11, 3, 134
       End If
   End If

   Require IDCOMP2PRGLA, 3, 135
   Require IDCOMP2PRPERSHARE, 3, 136
   Require IDCOMP2SOURCE, 3, 137
   Require IDCOMP2VER, 3, 138
   Require IDCOMP2SF, 3, 139
   Require IDCOMP2CONC, 3, 141
   Require IDCOMP2DOS, 3, 143
   Require IDCOMP2LOC, 3, 145
   Require IDCOMP2PRJSIZENUM, 3, 147
   Require IDCOMP2VIEW, 3, 149
   Require IDCOMP2FLOORLOC, 3, 151
   Require IDCOMP2MOMAINFEE, 3, 153
   Require IDCOMP2PRJAMEN, 3, 155
   Require IDCOMP2FACILITIES, 3, 157
   Require IDCOMP2PRJSECUR, 3, 159
   Require IDCOMP2FEATURES, 3, 161
   Require IDCOMP2DESIGN, 3, 163
   Require IDCOMP2QUAL, 3, 165
   Require IDCOMP2AGE, 3, 167
   Require IDCOMP2COND, 3, 169
   Require IDCOMP2REMODEL, 3, 171
   Require IDCOMP2KITCHBATH, 3, 173
   Require IDCOMP2ROOMS, 3, 176
   Require IDCOMP2BED, 3, 177
   Require IDCOMP2BATHS, 3, 178
   Require IDCOMP2GLA, 3, 180
   Require IDCOMP2BASE, 3, 182
   If not ((GetText(3, 182) = "0sf") or (GetText(3, 182) = "0sqm")) Then
     Require IDCOMP2BASEPER, 3, 184
   End If
   Require IDCOMP2FUNC, 3, 186
   Require IDCOMP2HEAT, 3, 188
   Require IDCOMP2ENERGY, 3, 190
   Require IDCOMP2GARAGE, 3, 192
   Require IDCOMP2PORCH, 3, 194

   If hasText(3, 205) Then
     num = GetValue(3, 205) / 1000
       If num > GetValue(1, 70) Then
         AddRec IDTOBERANGEC13, 3, 205
       End If
   End If

   If hasText(3, 205) Then
     num = GetValue(3, 205) / 1000
       If num < GetValue(1, 69) Then
         AddRec IDTOBERANGEC13, 3, 205
       End If
   End If

   Require IDCOMP3ADD, 3, 206
   Require IDCOMP3UNITNO, 3, 207
   Require IDCOMP3NAME, 3, 208
   Require IDCOMP3PROX, 3, 209
   Require IDCOMP3SALES, 3, 210

   If hasText(3, 210) Then
     num = GetValue(3, 210) / 1000
       If num > GetValue(1, 70) Then
         AddRec IDTOBERANGEC14, 3, 210
       End If
   End If

   If hasText(3, 210) Then
     num = GetValue(3, 210) / 1000
       If num < GetValue(1, 69) Then
         AddRec IDTOBERANGEC14, 3, 210
       End If
   End If

   If hasText(3, 210) Then
     num = GetValue(3, 210)
       If num < GetValue(3,9) Then
         AddRec IDTOBERANGE12, 3, 210
       End If
   End If

   If hasText(3, 210) Then
     num = GetValue(3, 210)
       If num > GetValue(3,10) Then
         AddRec IDTOBERANGE12, 3, 210
       End If
   End If

   Require IDCOMP3PRGLA, 3, 211
   Require IDCOMP3PRPERSHARE, 3, 212
   Require IDCOMP3SOURCE, 3, 213
   Require IDCOMP3VER, 3, 214
   Require IDCOMP3SF, 3, 215
   Require IDCOMP3CONC, 3, 217
   Require IDCOMP3DOS, 3, 219
   Require IDCOMP3LOC, 3,221
   Require IDCOMP3PRJSIZENUM, 3, 223
   Require IDCOMP3VIEW, 3, 225
   Require IDCOMP3FLOORLOC, 3, 227
   Require IDCOMP3MOMAINFEE, 3, 229
   Require IDCOMP3PRJAMEN, 3, 231
   Require IDCOMP3FACILITIES, 3, 233
   Require IDCOMP3PRJSECUR, 3, 235
   Require IDCOMP3FEATURES, 3, 237
   Require IDCOMP3DESIGN, 3, 239
   Require IDCOMP3QUAL, 3, 241
   Require IDCOMP3AGE, 3, 243
   Require IDCOMP3COND, 3, 245
   Require IDCOMP3REMODEL, 3, 247
   Require IDCOMP3KITCHBATH, 3, 249
   Require IDCOMP3ROOMS, 3, 252
   Require IDCOMP3BED, 3, 253
   Require IDCOMP3BATHS, 3, 254
   Require IDCOMP3GLA, 3, 256
   Require IDCOMP3BASE, 3, 258
   If not ((GetText(3, 258) = "0sf") or (GetText(3, 258) = "0sqm")) Then
     Require IDCOMP3BASEPER, 3, 260
   End If
   Require IDCOMP3FUNC, 3, 262
   Require IDCOMP3HEAT, 3, 264
   Require IDCOMP3ENERGY, 3, 266
   Require IDCOMP3GARAGE, 3, 268
   Require IDCOMP3PORCH, 3, 270

   If hasText(3, 281) Then
     num = GetValue(3, 281) / 1000
       If num > GetValue(1, 70) Then
         AddRec IDTOBERANGECO15, 3, 281
       End If
   End If

   If hasText(3, 281) Then
     num = GetValue(3, 281) / 1000
       If num < GetValue(1, 69) Then
         AddRec IDTOBERANGECO15, 3, 281
       End If
   End If

   OnlyOneCheckOfTwo 3, 282, 283, IDRESEARCH2, "HISTORY RESEARCHED: Both Did and Did Not checked"

   If isChecked(3, 283) Then
     Require IDRESEARCH, 3, 284
   End If

   OnlyOneCheckOfTwo 3, 285, 286, IDRESEARCHSUB2, "SUBJECT HISTORY: Both Did and Did Not checked"
   Require IDRESEARCHSUB3, 3, 287
   OnlyOneCheckOfTwo 3, 288, 289, IDRESEARCHCOMP2, "COMP HISTORY: Both Did and Did Not checked"
   Require IDRESEARCHCOMP3, 3, 290
  
   Require IDDATEPSTSUB, 3, 291
   Require IDPRICEPSTSUB, 3, 292
   Require IDDATASOURCESUB, 3, 293
   Require IDDATASOURCEDATESUB, 3, 294

   Require IDDATEPSTCOMP1, 3, 295
   Require IDPRICEPSTCOMP1, 3, 296
   Require IDDATASOURCECOMP1, 3, 297
   Require IDDATASOURCEDATECOMP1, 3, 298

   Require IDDATEPSTCOMP2, 3, 299
   Require IDPRICEPSTCOMP2, 3, 300
   Require IDDATASOURCECOMP2, 3, 301
   Require IDDATASOURCEDATECOMP2, 3, 302

   Require IDDATEPSTCOMP3, 3, 303
   Require IDPRICEPSTCOMP3, 3, 304
   Require IDDATASOURCECOMP3, 3, 305
   Require IDDATASOURCEDATECOMP3, 3, 306
 
   Require IDANALYSIS2, 3, 307
   Require IDSUMMARYSALES, 3, 308
   OnlyOneCheckOfFour 3, 309, 310, 311, 312, IDSTATUSNOCHK, IDSTATUSCHK

   If isChecked(3, 311) Then
     Require IDCONDCOMM, 3, 313
   End If

   If isChecked(3, 312) Then
     Require IDCONDCOMM, 3, 313
   End If

   If Not hasText(3, 314) Then
     AddRec IDTOBE, 3, 314
   End If

   Require IDASOF, 3, 315

End Sub
