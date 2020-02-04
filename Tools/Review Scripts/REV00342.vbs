'FM00342.vbs 1004c Reviewer Script

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewContract
  AddTitle ""
  ReviewNeighborhood
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewHUD
  AddTitle ""
  ReviewImprovements
  AddTitle ""
  ReviewCostApproach
  AddTitle ""
  ReviewSalesSubject
  AddTitle ""
  ReviewReconciliation
  AddTitle ""
  ReviewIncomeApproach
  AddTitle ""
  ReviewPUD
  AddTitle ""
End Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "FNMA 1004C " + IDSUBJECT + String(5, "=")
  Require IDFilenum, 1, 3
  Require IDAddress, 1, 6
  Require IDCity, 1, 7
  Require IDState, 1, 8
  Require IDZip, 1, 9
  Require IDBorrower, 1, 10
  Require IDOWNERPUB, 1, 11
  Require IDCounty, 1, 12
  Require IDLegal, 1, 13
  Require IDAPN2, 1, 14
  Require IDTaxYear, 1, 15
  Require IDReTaxes, 1, 16
  Require IDProjName, 1, 17
  Require IDMapref, 1, 18
  Require IDCensus, 1, 19
  OnlyOneCheckOfThree 1, 20, 21, 22, IDOccNoCheck, IDOccChk
  OnlyOneCheckOfFour 1, 23, 24, 25, 26, IDPROJTYPE, XXXXXX
   
  If ischecked(1, 26) then
    Require IDPRJTYPEOTHER, 1, 27 
  End If
   
  If not isnegativecomment(1, 29) and hastext(1, 29) then 
    Require IDPUDMISSING, 1, 23 
  End If
   
  Require IDSpecial, 1, 28
   
  If not isnegativecomment(1, 29) Then 
    OnlyOneCheckOfTwo 1, 30, 31, ID_HOA_PERIOD_NONE_CHECKED, ID_HOA_PERIOD_MANY_CHECKED  
  End If

  OnlyOneCheckOfThree 1, 32, 33, 34, IDPRA, IDPRA 
   
  If ischecked(1, 34) then 
    Require IDPRAOTHER, 1, 35 
  End If
   
  OnlyOneCheckOfThree 1, 36, 37, 38, IDASSIGNTYPEC, IDASSIGNTYPEC
   
  If ischecked(1, 38) then
    Require IDASSIGNTYPECOTHER, 1, 39 
  End If
   
  Require IDLender, 1, 40
  Require IDLenderAdd, 1, 41
  OnlyOneCheckOfTwo 1, 42, 43, ID_SUBJECT_FOR_SALE_NONE_CHECKED, ID_SUBJECT_FOR_SALE_MANY_CHECKED
  Require ID_SUBJECT_BLOCK_DATA_SOURCE_REQUIRED, 1, 44
End Sub

Sub ReviewContract
  AddTitle String(5, "=") + "FNMA 1004C " + ID_CONTRACT_BLOCK + String(5, "=")
  
  If not isChecked(1, 37) and not isChecked(1, 38) Then
    ValidateStandardContractBlock 1, 45
    OnlyOneCheckOfTwo 1, 56, 57, IDMANUINVOICE, IDMANUINVOICE
    Require IDMANUINVOICERESULT, 1, 58
    Require IDRETAILERNAME, 1, 59
    
    If (not isChecked(1, 37) and not isChecked(1, 38)) and hasText(1, 48) Then
      Require IDCONTRACTFNMA, 1, 36
    End If
    
    If (not isChecked(1, 37) and not isChecked(1, 38)) and hasText(1, 48) Then
      num = GetValue(1, 48)
        If num > GetValue(3, 268) Then
          AddRec IDCONTRACTFNMA1, 1, 48
        End If
    End If

    If (not isChecked(1, 37) and not isChecked(1, 38)) and hasText(1, 48) Then
      num = GetValue(1, 48)
        If num < GetValue(3, 268) Then
          AddRec IDCONTRACTFNMA2, 1, 48
        End If
    End If
  End If


If isnumeric(GetText(1, 48)) then 
  If isChecked(1, 37) or isChecked(1, 38) Then
'    Require "ASSIGNMENT TYPE: Subject Assigment Type is incorrect", 1, 36
    Require "ASSIGNMENT TYPE: Contract Price is entered but this is not Purchase Transaction", 1, 36
  End If
End If 

End Sub

Sub ReviewNeighborhood
  AddTitle String(5, "=") + "FNMA 1004C " + IDNeigh + String(5, "=")
  ValidateStandardNeighborhoodBlock107310751004c 1, 60
  
  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE, 1,79
      End If
  End If
  
  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE, 1,78
      End If
  End If
  
  sum = GetValue(1, 84) + GetValue(1, 85) + GetValue(1, 86) + GetValue(1, 87) + GetValue(1, 89)
  If sum <> 100 Then	
    AddRec IDLandUse, 1, 84
  End If

  Require IDNEIGHBOUND, 1, 90
  Require IDNEIGHDES, 1, 91
  Require IDNEIGHCOND, 1, 92
End Sub


Sub ReviewSite
  AddTitle String(5, "=") + "FNMA 1004C " + IDSITE + String(5, "=")
  ValidateStandardSiteBlock1004c 1, 93
  OnlyOneCheckOfTwo 1, 133, 134, IDSIZEC, IDSIZEC
   
  If ischecked(1, 134) then 
    Require IDSIZECNO, 1, 135 
  End If

  OnlyOneCheckOfTwo 1, 136, 137, IDVEHICLE, IDVEHICLE
   
  If ischecked(1, 137) then 
    Require IDVEHICLENO, 1, 138 
  End If

  OnlyOneCheckOfTwo 1, 139, 140, IDSTREETC, IDSTREETC
   
  If ischecked(1, 140) then 
    Require IDSTREETCNO, 1, 141 
  End If

  OnlyOneCheckOfTwo 1, 142, 143, ID_ADVERSE_SITE_NONE_CHECKED, ID_ADVERSE_SITE_MANY_CHECKED
  ReportIfChecked IDADVERSECOMM, 1, 143, 144
End Sub


Sub ReviewHUD
  AddTitle String(5, "=") + "FNMA 1004C " + IDHUDDATA + String(5, "=")
  OnlyOneCheckOfTwo 1, 145, 146, IDHUDPLATEATTACHED, IDHUDPLATEATTACHED
  Require IDHUDPLATECOMMENT, 1, 147
  OnlyOneCheckOfTwo 1, 148, 149, IDHUDPLATEEXTERIOR, IDHUDPLATEEXTERIOR

  If ischecked(1, 149) then 
    Require IDHUDPLATEEXTERIORCOMMENT, 1, 150 
  End If

  Require IDMANSERIAL, 1, 151
  Require IDHUDCERTLABEL, 1, 152
  Require IDMANNAMEC, 1, 153
  Require IDTRADEMODEL, 1, 154
  Require IDDATEMANC, 1, 155
  OnlyOneCheckOfTwo 1, 156, 157, IDWINDROOFTHERMAL, IDWINDROOFTHERMAL

  If ischecked(1, 157) then 
    Require IDWINDROOFTHERMALNO, 1, 158 
  End If
End Sub


Sub ReviewImprovements
  AddTitle String(5, "=") + "FNMA 1004C " + IDIMPROV + String(5, "=")
  Require IDFilenum, 2, 2
  OnlyOneCheckOfTwo 2, 5, 6, INUNITS2, INUNITS2
  
  If isChecked(2, 6) Then
    Require IDUNITSADD, 2, 7 
  End If
  
  OnlyOneCheckOfThree 2, 8, 9, 10, IDSTORIESCK, IDSTORIESCK
   
  If isChecked(2, 10) Then
    Require IDSTORESCKOTHER, 2, 11 
  End If

  Require IDDESIGN, 2, 12
  OnlyOneCheckOfFour 2, 13, 14, 15, 16, IDSECTIONSCK, IDSECTIONSCK
   
  If isChecked(2, 16) Then 
    Require IDSECTIONSCKOTHER, 2, 17 
  End If
   
  OnlyOneCheckOfThree 2, 18, 19, 20, IDTYPE2, IDTYPE2
  OnlyOneCheckOfThree 2, 21, 22, 23, IDEXISTING2, IDEXISTING2
  Require IDYRBLT, 2, 24
  Require IDEFFAGE, 2, 25
  OnlyOneCheckOfSix 2, 26, 27, 28, 29, 30, 31, IDFOUNDATIONNOCHK, IDFOUNDATIONCHK

  If isChecked(2, 30) Then
    Require IDBASEAREA, 2, 32
    Require IDBASEFIN, 2, 33
'    Require IDBASEOUTSIDE2, 2, 34
'    Require IDSUMP2, 2, 35
  End If

  If isChecked(2, 31) Then
    Require IDBASEAREA, 2, 32
    Require IDBASEFIN, 2, 33
'    Require IDBASEOUTSIDE2, 2, 34
'    Require IDSUMP2, 2, 35
  End If

  If hasText(2, 32) and (GetText(2, 32) <> "0") Then
    OnlyOneCheckOfTwo 2, 30, 31, IDBASEFULLPART, IDBASEFULLPART
    Require IDBASEFIN, 2, 33
  End If

  If hasText(2, 33) and (GetText(2, 33) <> "0") Then
    OnlyOneCheckOfTwo 2, 30, 31, IDBASEFULLPART, IDBASEFULLPART
    Require IDBASEAREA, 2, 32
  End If

  Require IDSKIRT, 2, 40
  Require IDEXT, 2, 41
  Require IDROOFSUF, 2, 42
  Require IDGUTTER, 2, 43
  Require IDWINDOWTYPE, 2, 44
  Require IDDOORS, 2, 47
  Require IDFLOOR, 2, 48
  Require IDWALLS, 2, 49
  Require IDTRIM, 2, 50
  Require IDBATHFLOOR, 2, 51
  Require IDWAINSCOT, 2, 52

  ' Attic
  checked = GetCheck(2, 53) + GetCheck(2, 54) + GetCheck(2, 55) + GetCheck(2, 56) + GetCheck(2, 57) + GetCheck(2, 58)
  If isChecked(2, 53) Then    '  No Attic
    If checked > 0 Then AddRec IDATTICNONE, 2, 53
  Else
    If checked = 0 Then AddRec IDATTICNOCK, 2, 53
  End If

  OnlyOneCheckOfFour 2, 60, 61, 62, 63, IDHEATTYPE2, XXXXX

  If isChecked(2, 63) Then
    Require IDHEATOTHER, 2, 64
  End If

  Require IDHEATFUEL, 2, 65
  OnlyOneCheckOfThree 2, 66, 67, 68, IDCOOLCOND2, XXXXX

  If isChecked(2, 68) Then
    Require IDCOOLOTHER, 2, 69
  End If

  'Amenities

  OnlyOneCheckOfSeven 2, 70, 72, 74, 76, 78, 80, 82, IDAMENITIES, XXXXXX

  If isChecked(2, 70) Then
    Require IDFIREPLACE2, 2, 71
  End If

  If isChecked(2, 72) Then
    Require IDPATDECK, 2, 73
  End If

  If isChecked(2, 74) Then
    Require IDPOOL2, 2, 75
  End If

  If isChecked(2, 76) Then
    Require IDSTOVES2, 2, 77
  End If

  If isChecked(2, 78) Then
    Require IDFENCE2, 2, 79
  End If

  If isChecked(2, 80) Then
    Require IDPORCH2, 2, 81
  End If

  If isChecked(2, 82) Then
    Require IDOTHER2, 2, 83
  End If

  If hastext(2, 71) Then
    Require IDFIREPLACE2CK, 2, 70
  End If

  If hastext(2, 73) Then
    Require IDPATDECKCK, 2, 72
  End If

  If hastext(2, 75) Then
    Require IDPOOL2CK, 2, 74
  End If

  If hastext(2, 77) Then
    Require IDSTOVES2CK, 2, 76
  End If

  If hastext(2, 79) Then
    Require IDFENCE2CK, 2, 78
  End If

  If hastext(2, 81) Then
    Require IDPORCH2CK, 2, 80
  End If

  If hastext(2, 83) Then
    Require IDOTHER2CK, 2, 82
  End If

  checked = GetTextCheck(2, 85) + GetTextCheck(2, 88) + GetTextCheck(2, 90) + GetTextCheck(2, 92) + GetTextCheck(2, 93) + GetTextCheck(2, 94)
  if isChecked(2, 84) then
    if checked > 0 then AddRec IDCARNONE, 2, 84
  else
    if checked = 0 then AddRec IDCARERROR, 2, 84
  end if

  If isChecked(2, 85) Then
    Require IDDRIVE, 2, 86
  End If

  If isChecked(2, 85) Then
    Require IDDRIVE2, 2, 87
  End If

  If hasText(2, 86) Then
    Require IDDRIVE1, 2, 85
  End If

  If hasText(2, 86) Then
    Require IDDRIVE2, 2, 87
  End If

  If hasText(2, 87) Then
    Require IDDRIVE1, 2, 85
  End If

  If hasText(2, 87) Then
    Require IDDRIVE, 2, 86
  End If

  If isChecked(2, 88) Then
    Require IDGARNUM, 2, 89
  End If

  If isChecked(2, 90) Then
    Require IDCARNUM, 2, 91
  End If

  If hasText(2, 89) Then
    Require IDGARNUM2, 2, 88
  End If

  If hasText(2, 91) Then   
    Require IDCARNUM2, 2, 90
  End If

  If isChecked(2, 88) Then
    OnlyOneCheckOfThree 2, 92, 93, 94, IDCARERROR2, XXXXX
  End If

  OnlyOneCheckOfSeven 2, 95, 96, 97, 98, 99, 100, 101, IDAPPLIANCE, XXXXXX

  If isChecked(2, 101) Then
    Require IDAPPOTHER, 2, 102
  End If

  Require IDROOMCNT, 2, 103
  Require IDBEDCNT, 2, 104
  Require IDBATHCNT, 2, 105
  Require IDGLA, 2, 106
  Require IDADD, 2, 107
  Require IDINSTALLERNAME, 2, 108
  Require IDINSTALLERDATE, 2, 109
  Require IDINSTALLERYEAR, 2, 110

  OnlyOneCheckOfTwo 2, 111, 112, IDATTACHFOUND, XXXXX

  If isChecked(2, 112) Then
    Require IDATTACHFOUNDNO, 2, 113
  End If

  OnlyOneCheckOfTwo 2, 114, 115, IDHITCH, XXXXX

  If isChecked(2, 115) Then
    Require IDHITCHNO, 2, 116
  End If

  OnlyOneCheckOfTwo 2, 117, 118, IDSEPTICC, XXXXX

  If isChecked(2, 118) Then
    Require IDSEPTICCNO, 2, 119
  End If

  OnlyOneCheckOfTwo 2, 120, 121, IDGLAMARKET, XXXXX

  If isChecked(2, 121) Then
    Require IDGLAMARKETNO, 2, 122
  End If

  Require IDADD, 2, 123
  OnlyOneCheckOfFive 2, 124, 125, 126, 127, 128, IDQUALITYC, XXXXX
  Require IDQUALITYCSOURCE, 2, 129
  Require IDCOND, 2, 130
  OnlyOneCheckOfTwo 2, 131, 132, IDADVERSE2, XXXXX

  If isChecked(2, 131) Then
    Require IDADVERSE, 2, 133
  End If

  OnlyOneCheckOfTwo 2, 134, 135, IDCONFORM2, XXXXX

  If isChecked(2, 135) Then
    Require IDCONFORM, 2, 136
  End If
End Sub

Sub ReviewCostApproach
  AddTitle String(5, "=") + "FNMA 1004C " + IDCOSTAPP + String(5, "=")
  Require IDOPINCOST, 2, 137
  OnlyOneCheckOfTwo 2, 138, 139, IDREPCOST, XXXXX
  Require IDSOURCECOST, 2, 140  
  Require IDEFFDATECOST, 2, 141
  Require IDQUALITYCOST, 2, 142 
  Require IDOPSITEVALC, 2, 143
  Require IDSECONEC, 2, 144
  Require IDSECONECSQFT, 2, 145
  Require IDSECONECSQFTOTAL, 2, 146
  Require IDSECTWOC, 2, 147
  Require IDSECTWOCSQFT, 2, 148
  Require IDSECTWOCSQFTOTAL, 2, 149
  Require IDSECTHREEEC, 2, 150
  Require IDSECTHREECSQFT, 2, 151
  Require IDSECTHREECSQFTOTAL, 2, 152
  Require IDSECFOURC, 2, 153
  Require IDSECFOURCSQFT, 2, 154
  Require IDSECFOURCSQFTOTAL, 2, 155
  Require IDSUBTOTALC, 2, 164
  Require IDCOSTMULTC, 2, 165
  Require IDMODSUBTOTALC, 2, 166
  Require IDPERCENTDEPC, 2, 167
  Require IDPHYSICALDEPC, 2, 168
  Require IDFUNCTIONALC, 2, 169
  Require IDEXTERNALC, 2, 170
  Require IDDELIVERYC, 2, 171
  Require IDDEPSITEC, 2, 172
  Require IDMARKETVALUEC, 2, 173
  Require IDINDVALCOST, 2, 174
  Require IDSECONEDIMENSIONA, 2, 175
  Require IDSECONEDIMENSIONB, 2, 176
  Require IDSECONEDIMENSIONTOTAL, 2, 177
  Require IDSECTWODIMENSIONA, 2, 178
  Require IDSECTWODIMENSIONB, 2, 179
  Require IDSECTWODIMENSIONTOTAL, 2, 180
  Require IDSECTHREEDIMENSIONA, 2, 181
  Require IDSECTHREEDIMENSIONB, 2, 182
  Require IDSECTHREEDIMENSIONTOTAL, 2, 183
  Require IDSECFOURDIMENSIONA, 2, 184
  Require IDSECFOURDIMENSIONB, 2, 185
  Require IDSECFOURDIMENSIONTOTAL, 2, 186
  Require IDTOTALGLACOSTC, 2, 187
  Require IDNADAMONTH, 2, 188
  Require IDNADAYEAR, 2, 189
  Require IDMHSTATE, 2, 190
  Require IDREGIONC, 2, 191
  Require IDSIZECA, 2, 192
  Require IDSIZECB, 2, 193
  Require IDGRAYPAGE, 2, 194
  Require IDWHITEPAGE, 2, 195
  Require IDBLACKPAGE, 2, 196
  Require IDYEARSOLDER, 2, 197
  Require IDYELLOWPAGE, 2, 198
  Require IDCOMMENTSCOSTC, 2, 199
  Require IDESTREMAININGC, 2, 200 
  Require IDCOMMCOST, 2, 201

  If hasText(2, 174) Then
    num = GetValue(3, 255)
    If not num = GetValue(2, 174) Then
      AddRec IDCOSTNOTEQUAL, 2, 174
     End If
  End If
End Sub


Sub ReviewSalesSubject
  
  AddTitle String(5, "=") + "FNMA 1004C " + IDSALESAPP + String(5, "=")
  Require IDFILENUM, 3, 2
  Require IDPROPCOMP, 3, 5
  Require IDPROPCOMPFROM, 3, 6
  Require IDPROPCOMPTO, 3, 7
  Require IDSALECOMP, 3, 8
  Require IDSALECOMPFROM, 3, 9
  Require IDSALECOMPTO, 3, 10

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE2, 3, 48
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE2, 3, 110
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE2, 3, 172
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num2 <= num3 and num2 <= num4 Then
        If num < num2 Then
          AddRec IDTOBERANGE2, 3, 48
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE2, 3, 110
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 48)
    num3 = GetValue(3, 110)
    num4 = GetValue(3, 172)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
          AddRec IDTOBERANGE2, 3, 172
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE3, 3, 106
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE3, 3, 168
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE3, 3, 230
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num2 <= num3 and num2 <= num4 Then
        If num < num2 Then
          AddRec IDTOBERANGE3, 3, 106
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE3, 3, 168
        End If
      End If
  End If
  
  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 106)
    num3 = GetValue(3, 168)
    num4 = GetValue(3, 230)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
          AddRec IDTOBERANGE3, 3, 230
        End If
      End If
  End If

  Require IDSUBADD, 3, 11
  Require IDSUBCITY, 3, 12

  If hasText(3, 12) Then
    text1 = Replace(UCase(GetText(3, 12)), " ", "")
    text2 = Replace(UCase(GetText(1, 7)), " ", "")
    text3 = Replace(UCase(GetText(1, 8)), " ", "")
    text4 = Replace(UCase(GetText(1, 9)), " ", "")
    If not text1 = text2 + IDCOMMA + text3 + text4 Then
      AddRec IDADDMATCH, 3, 12
    End If
  End If
 
  If not isChecked(1, 37) Then
    Require IDSUBSALES, 3, 13
    Require IDSUBPRGLA, 3, 14
  End If

  Require IDSUBLOC, 3, 20
  Require IDSUBLEASEHOLD, 3, 21
  Require IDSUBSITE, 3, 22
  Require IDSUBVIEW, 3, 23
  Require IDSUBDESIGN, 3, 24
  Require IDSUBQUAL, 3, 25
  Require IDSUBAGE, 3, 26
  Require IDSUBCOND, 3, 27
  Require IDSUBROOMS, 3, 28
  Require IDSUBBED, 3, 29
  Require IDSUBBATHS, 3, 30
  Require IDSUBGLA, 3, 31
  Require IDSUBBASE, 3, 32
  If not ((GetText(3, 32) = "0sf") or (GetText(3, 32) = "0sqm")) Then
    Require IDSUBBASEPER, 3, 33
  End If
  Require IDSUBBASEPER, 3, 33
  Require IDSUBFUNC, 3, 34
  Require IDSUBHEAT, 3, 35
  Require IDSUBENERGY, 3, 36
  Require IDSUBGARAGE, 3, 37
  Require IDSUBPORCH, 3, 38

  Require IDCOMP1ADD, 3, 45
  Require IDCOMP1CITY, 3, 46 
  Require IDCOMP1PROX, 3, 47
  Require IDCOMP1SALES, 3, 48

  If hasText(3, 48) Then
    num = GetValue(3, 48) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE4, 3, 48
      End If
  End If

  If hasText(3, 48) Then
    num = GetValue(3, 48) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE4, 3, 48
      End If
  End If

  If hasText(3, 48) Then
    num = GetValue(3, 48)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE10, 3, 48
      End If
  End If

  If hasText(3, 48) Then
    num = GetValue(3, 48)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE10, 3, 48
      End If
  End If

  Require IDCOMP1PRGLA, 3, 49
  OnlyOneCheckOfTwo 3, 50, 51, IDMFGHOMECOMP1, IDMFGHOMECOMP1
  Require IDCOMP1SOURCE, 3, 52
  Require IDCOMP1VER, 3, 53
  Require IDCOMP1SF, 3, 54
  Require IDCOMP1CONC, 3, 56
  Require IDCOMP1DOS, 3, 58
  Require IDCOMP1LOC, 3, 60
  Require IDCOMP1LEASEHOLD, 3, 62
  Require IDCOMP1SITE, 3, 64
  Require IDCOMP1VIEW, 3, 66
  Require IDCOMP1DESIGN, 3, 68
  Require IDCOMP1QUAL, 3, 70
  Require IDCOMP1AGE, 3, 72
  Require IDCOMP1COND, 3, 74
  Require IDCOMP1ROOMS, 3, 77
  Require IDCOMP1BED, 3, 78
  Require IDCOMP1BATHS, 3, 79
  Require IDCOMP1GLA, 3, 81
  Require IDCOMP1BASE, 3, 83
  If not ((GetText(3, 83) = "0sf") or (GetText(3, 83) = "0sqm")) Then
    Require IDCOMP1BASEPER, 3, 85
  End If
  Require IDCOMP1FUNC, 3, 87
  Require IDCOMP1HEAT, 3, 89
  Require IDCOMP1ENERGY, 3, 91
  Require IDCOMP1GARAGE, 3, 93
  Require IDCOMP1PORCH, 3, 95

  If hasText(3, 106) Then
    num = GetValue(3, 106) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE5, 3, 106
      End If
  End If

  If hasText(3, 106) Then
    num = GetValue(3, 106) / 1000
        If num < GetValue(1, 78) Then
                    AddRec IDTOBERANGE5, 3, 106
      End If
  End If

  Require IDCOMP2ADD, 3, 107
  Require IDCOMP2CITY, 3, 108
  Require IDCOMP2PROX, 3, 109
  Require IDCOMP2SALES, 3, 110

  If hasText(3, 110) Then
    num = GetValue(3, 110) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE6, 3, 110
      End If
  End If

  If hasText(3, 110) Then
    num = GetValue(3, 110) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE6, 3, 110
      End If
  End If

  If hasText(3, 110) Then
    num = GetValue(3, 110)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE11, 3, 110
      End If
  End If

  If hasText(3, 110) Then
    num = GetValue(3, 110)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE11, 3, 110
      End If
  End If

  Require IDCOMP2PRGLA, 3, 111
  OnlyOneCheckOfTwo 3, 112, 113, IDMFGHOMECOMP2, IDMFGHOMECOMP2 
  Require IDCOMP2SOURCE, 3, 114
  Require IDCOMP2VER, 3, 115
  Require IDCOMP2SF, 3, 116
  Require IDCOMP2CONC, 3, 118
  Require IDCOMP2DOS, 3, 120
  Require IDCOMP2LOC, 3, 122
  Require IDCOMP2LEASEHOLD, 3, 124 
  Require IDCOMP2SITE, 3, 126
  Require IDCOMP2VIEW, 3, 128
  Require IDCOMP2DESIGN, 3, 130
  Require IDCOMP2QUAL, 3, 132
  Require IDCOMP2AGE, 3, 134
  Require IDCOMP2COND, 3, 136
  Require IDCOMP2ROOMS, 3, 139
  Require IDCOMP2BED, 3, 140
  Require IDCOMP2BATHS, 3, 141
  Require IDCOMP2GLA, 3, 143
  Require IDCOMP2BASE, 3, 145
  If not ((GetText(3, 145) = "0sf") or (GetText(3, 145) = "0sqm")) Then
    Require IDCOMP2BASEPER, 3, 147
  End If
  Require IDCOMP2FUNC, 3, 149
  Require IDCOMP2HEAT, 3, 151
  Require IDCOMP2ENERGY, 3, 153
  Require IDCOMP2GARAGE, 3, 155
  Require IDCOMP2PORCH, 3, 157

  If hasText(3, 168) Then
    num = GetValue(3, 168) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE7, 3, 168
      End If
  End If

  If hasText(3, 168) Then
    num = GetValue(3, 168) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE7, 3, 168
      End If
  End If

  Require IDCOMP3ADD, 3, 169
  Require IDCOMP3CITY, 3, 170
  Require IDCOMP3PROX, 3, 171
  Require IDCOMP3SALES, 3, 172

  If hasText(3, 172) Then
    num = GetValue(3, 172) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE8, 3, 172
      End If
  End If

  If hasText(3, 172) Then
    num = GetValue(3, 172) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE8, 3, 172
      End If
  End If

  If hasText(3, 172) Then
    num = GetValue(3, 172)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE12, 3, 172
      End If
  End If

  If hasText(3, 172) Then
    num = GetValue(3, 172)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE12, 3, 172
      End If
  End If

  Require IDCOMP3PRGLA, 3, 173
  OnlyOneCheckOfTwo 3, 174, 175, IDMFGHOMECOMP3, IDMFGHOMECOMP3
  Require IDCOMP3SOURCE, 3, 176 
  Require IDCOMP3VER, 3, 177
  Require IDCOMP3SF, 3, 178
  Require IDCOMP3CONC, 3, 180
  Require IDCOMP3DOS, 3, 182
  Require IDCOMP3LOC, 3, 184
  Require IDCOMP3LEASEHOLD, 3, 186
  Require IDCOMP3SITE, 3, 188
  Require IDCOMP3VIEW, 3, 190
  Require IDCOMP3DESIGN, 3, 192
  Require IDCOMP3QUAL, 3, 194
  Require IDCOMP3AGE, 3, 196
  Require IDCOMP3COND, 3, 198
  Require IDCOMP3ROOMS, 3, 201
  Require IDCOMP3BED, 3, 202
  Require IDCOMP3BATHS, 3, 203
  Require IDCOMP3GLA, 3, 205
  Require IDCOMP3BASE, 3, 207
  If not ((GetText(3, 207) = "0sf") or (GetText(3, 207) = "0sqm")) Then
    Require IDCOMP3BASEPER, 3, 209
  End If
  Require IDCOMP3FUNC, 3, 211
  Require IDCOMP3HEAT, 3, 213
  Require IDCOMP3ENERGY, 3, 215
  Require IDCOMP3GARAGE, 3, 217
  Require IDCOMP3PORCH, 3, 219

  If hasText(3, 230) Then
    num = GetValue(3, 230) / 1000
      If num > GetValue(1, 79) Then
        AddRec IDTOBERANGE9, 3, 230
      End If
  End If

  If hasText(3, 230) Then
    num = GetValue(3, 230) / 1000
      If num < GetValue(1, 78) Then
        AddRec IDTOBERANGE9, 3, 230
      End If
  End If

  OnlyOneCheckOfTwo 3, 231, 232, IDRESEARCH2, XXXXX

  If isChecked(3, 232) Then
    Require IDRESEARCH, 3, 233
  End If

  OnlyOneCheckOfTwo 3, 234, 235, IDRESEARCHSUB2, XXXXX
  Require IDRESEARCHSUB3, 3, 236
  OnlyOneCheckOfTwo 3, 237, 238, IDRESEARCHCOMP2, XXXXX
  Require IDRESEARCHCOMP2, 3, 239
  Require IDDATEPSTSUB, 3, 240
  Require IDPRICEPSTSUB, 3, 241
  Require IDDATASOURCESUB, 3, 242
  Require IDDATASOURCEDATESUB, 3, 243
  Require IDDATEPSTCOMP1, 3, 244
  Require IDPRICEPSTCOMP1, 3, 245
  Require IDDATASOURCECOMP1, 3, 246
  Require IDDATASOURCEDATECOMP1, 3, 247
  Require IDDATEPSTCOMP2, 3, 248
  Require IDPRICEPSTCOMP2, 3, 249
  Require IDDATASOURCECOMP2, 3, 250 
  Require IDDATASOURCEDATECOMP2, 3, 251
  Require IDDATEPSTCOMP3, 3, 252
  Require IDPRICEPSTCOMP3, 3, 253
  Require IDDATASOURCECOMP3, 3, 254
  Require IDDATASOURCEDATECOMP3, 3, 255
  Require IDANALYSIS2, 3, 256
  Require IDSUMMARYSALES, 3, 257

  If Not hasText(3, 258) Then
    AddRec IDTOBE, 3, 258
  Else
    num = GetValue(3, 258) / 1000
    If num > GetValue(1, 79) Or num < GetValue(1, 78) Then _
      AddRec IDTOBERANGE, 3, 258
  End If
End Sub

Sub ReviewReconciliation

  AddTitle String(5, "=") + "FNMA 1004C " + IDRECON + String(5, "=")
  
  If Not hasText(3, 259) Then
    AddRec IDTOBE, 3, 259
  Else
    num = GetValue(3, 259) / 1000
      If num > GetValue(1, 79) Or num < GetValue(1, 78) Then _
        AddRec IDTOBERANGE, 3, 259
  End If

  Require IDCOSTVALUEREC, 3, 260

  If isChecked(1, 21) Then
     Require IDINCOMEVALUE, 3, 261
  End If

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

Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "FNMA 1004C " + IDINCOME + String(5, "=")
  Require IDFILENUM, 4, 2
  
  If isChecked(1, 21) Then
    Require IDINCOMERENT, 4, 6
    Require IDINCOMEGRM, 4, 7
    Require IDINVALINCOME, 4, 8
    Require IDSUMMARYINCOME, 4,9
  End If

End Sub

Sub ReviewPUD
  AddTitle String(5, "=") + "FNMA 1004C " + IDPUD + String(5, "=")

  If isChecked(1, 23) Then
    OnlyOneCheckOfTwo 4, 10, 11, IDCONTROLPUD, XXXXX
    OnlyOneCheckOfTwo 4, 12, 13, IDUNITTYPEPUD, XXXXX
  End If

  If isChecked(4, 10) and isChecked(4, 13) Then
    Require IDLEGALPUD, 4, 14
    Require IDPHASES, 4, 15
    Require IDUNITS, 4, 16
    Require IDUNITSOLD, 4, 17
    Require IDUNITRENT, 4, 18
    Require IDUNITSALE, 4, 19
    Require IDDATASOURCE, 4, 20
    OnlyOneCheckOfTwo 4, 21, 22, IDCONVERSIONPUD, XXXXX
    
    If isChecked(4, 21) Then
      Require IDDATECONVERTPUD, 4, 23
    End If
     
    OnlyOneCheckOfTwo 4, 24, 25, IDMULTIPUD, XXXXX
    Require IDDATEDSPUD, 4, 26
    OnlyOneCheckOfTwo 4, 27, 28, IDCOMPLETEPUD, XXXXX
       
    If isChecked(4, 28) Then
      Require IDCOMPLETESTATUSPUD, 4, 29
    End If
       
    OnlyOneCheckOfTwo 4, 30, 31, IDHOACOMMONPUD, XXXXX

    If isChecked(4, 30) Then
      Require IDRENTALTERMSPUD, 4, 32
    End If
      
    Require IDELEMENTSPUD, 4, 33
  End If   


End Sub

