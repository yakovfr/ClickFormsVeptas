'REV00735.vbs Non-Lender Condo Reviewer Script

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
 
   AddTitle String(5, "=") + "Non-Lender Condo " + IDSUBJECT + String(5, "=")

   Require IDFILENUM, 1, 3
   Require IDADDRESS, 1, 6
   Require IDUNITS, 1, 7
   Require IDCity, 1, 8
   Require IDState, 1, 9
   Require IDZip, 1, 10
   Require IDBorrower, 1, 11
   Require IDOWNERPUB, 1, 12
   Require IDCounty, 1, 13
   Require IDLegal, 1, 14
   Require IDAPN2, 1, 15
   Require IDTaxYear, 1, 16
   Require IDReTaxes, 1, 17
   Require IDProjName2, 1, 18
   Require IDPhase, 1, 19
   Require IDMapref, 1, 20
   Require IDCensus, 1, 21
   OnlyOneCheckOfThree 1, 22, 23, 24, IDOccNoCheck, IDOccChk
   Require IDSpecial, 1, 25
   
   If not isnegativecomment(1, 26) Then 
     OnlyOneCheckOfTwo 1, 27, 28, ID_HOA_PERIOD_NONE_CHECKED, ID_HOA_PERIOD_MANY_CHECKED 
   End If

   OnlyOneCheckOfThree 1, 29, 30, 31, ID_PROPERTY_RIGHTS_NONE_CHECKED, ID_PROPERTY_RIGHTS_MANY_CHECKED

   If isChecked(1, 31) Then
       Require IDOTHERDATA, 1, 32
   End If

   Require "INTENDED USE", 1, 33

   Require IDLender, 1, 34
   Require IDLenderAdd, 1, 35

   OnlyOneCheckOfTwo 1, 36, 37, ID_SUBJECT_FOR_SALE_NONE_CHECKED, ID_SUBJECT_FOR_SALE_MANY_CHECKED
   Require ID_SUBJECT_BLOCK_DATA_SOURCE_REQUIRED, 1, 38
 
End Sub


Sub ReviewContract

  AddTitle String(5, "=") + "Non-Lender Condo " + ID_CONTRACT_BLOCK + String(5, "=")

  ValidateStandardContractBlock 1, 39

End Sub

Sub ReviewNeighborhood

  AddTitle String(5, "=") + "Non-Lender Condo " + IDNeigh + String(5, "=")

   ValidateStandardNeighborhoodBlock107310751004c 1, 50

  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num > GetValue(1, 69) Then
        AddRec IDTOBERANGEC, 1,69
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268) / 1000
      If num < GetValue(1, 68) Then
        AddRec IDTOBERANGEC, 1,68
      End If
  End If

  sum = GetValue(1, 74) + GetValue(1, 75) + GetValue(1, 76) + GetValue(1, 77) + GetValue(1, 79)
  
  If sum <> 100 Then
    AddRec IDLandUse, 1, 74
  End If

   Require IDNEIGHBOUND, 1, 80
   Require IDNEIGHDES, 1, 81
   Require IDNEIGHCOND, 1, 82

End Sub


Sub ReviewSite

   AddTitle String(5, "=") + "Non-Lender Condo " + IDPRoSite + String(5, "=")    

   Require IDTOPOGRAPHY, 1, 83
   Require IDSITEAREA, 1, 84
   Require IDDENSITY, 1, 85
   Require IDVIEW, 1, 86
   Require IDZONINGCLAS, 1, 87
   Require ID_ZONING_DESCRIPTION_REQUIRED, 1, 88

   OnlyOneCheckOfFour 1, 89, 90, 91, 92, IDZONINGCOM, IDZONINGNOCHK   
   If isChecked(1, 90) Then
     OnlyOneCheckOfTwo 1, 91, 92, IDNONCOFORM, IDNONCOFORM
   End If

   If isChecked(1, 94) Then
     Require IDILLEGAL, 1, 95
   End If

   ValidateSiteBlock 1, 96
          
End Sub

Sub ReviewImprovements

   AddTitle String(5, "=") + "Non-Lender Condo " + IDIMPROVM2 + String(5, "=")
   
   Require IDDATASOURCE, 1, 128

   OnlyOneCheckOfSix 1, 129, 130, 131, 132, 133, 134, ID_PROJECT_DESCRIPTION_NONE_CHECKED, ID_PROJECT_DESCRIPTION_MANY_CHECKED
   CheckAndComment 1, 134, 135, "", ""

   Require IDSTORIES, 1, 136
   Require IDELEVATOR, 1, 137
   OnlyOneCheckOfThree 1, 138, 139, 140, IDEXISTING, IDEXISTING
   
   Require IDYRBLT, 1, 141
   Require IDEFFAGE, 1, 142
   Require IDEXT, 1, 143
   Require IDROOFSUF, 1, 144
   Require IDTOTPARK, 1, 145
   Require IDRATIO, 1, 146
   Require IDTYPE, 1, 147
   Require IDGUEST, 1, 148

   If (hasText(1, 155) or hasText(1, 156) or hasText(1, 157) or hasText(1, 158) or hasText(1, 159) or hasText(1, 160)) Then
   'Project Completed
       Require IDUNITS, 1, 156
       Require IDUNITSALE, 1, 157
       Require IDUNITSOLD, 1, 158
       Require IDUNITRENT, 1, 159
       If (hasText(1, 161) or hasText(1, 162) or hasText(1, 163) or hasText(1, 164) or hasText(1, 165) or hasText(1, 166)) Then 
         AddRec IDPROJPLN, 1, 155        'data in both Completed and Incomplete
       End If
   Else
       If (hasText(1, 161) or hasText(1, 162) or hasText(1, 163) or hasText(1, 164) or hasText(1, 165) or hasText(1, 166)) Then 
       'Project Incomplete
           Require IDUNITS, 1, 162
           Require IDUNITSALE, 1, 163
           Require IDUNITSOLD, 1, 164
           Require IDUNITRENT, 1, 165
       End If
   End If

   'Subject Phase
   Require IDSUBNUMPHASES, 1, 149
   Require IDSUBNUMUNITS, 1, 150
   Require IDSUBUNITSALE, 1, 151
   Require IDSUBUNITSOLD, 1, 152
   Require IDSUBUNITRENT, 1, 153
   Require IDSUBOWNEROCC, 1, 154

   'If Proj Completed
   Require IDPCNUMPHASES, 1, 155 
   Require IDPCNUMUNITS, 1, 156 
   Require IDPCUNITSSALE, 1, 157
   Require IDPCUNITSSOLD, 1, 158 
   Require IDPCUNITSRENTED, 1, 159 
   Require IDPCOWNEROCC, 1, 160

   'If Proj Incomplete
   Require IDPIPLANNED, 1, 161
   Require IDPIPLANNEDUNITS, 1, 162 
   Require IDPIUNITESSALE, 1, 163
   Require IDPIUNITSSOLD, 1, 164
   Require IDPIUNITSRENT, 1, 165 
   Require IDPIOWNEROCC, 1, 166

   OnlyOneCheckOfThree 1, 167, 168, 169, IDOCCUPANCY, IDOCCUPANCYCK

   OnlyOneCheckOfTwo 1, 170, 171, IDHOANOCHK, IDHOACHK

   OnlyOneCheckOfThree 1, 172, 173, 174, IDMNGNOCHK, IDMNGCHK
   
   If isChecked(1, 174) Then
     Require IDMGTGRPNAME, 1, 175
   End If

   OnlyOneCheckOfTwo 1, 176, 177, ID_PROJECT_SINGLE_ENTITY_10_PERCENT_NONE_CHECKED, ID_PROJECT_SINGLE_ENTITY_10_PERCENT_MANY_CHECKED

   If isChecked(1, 176) Then
     Require ID_PROJECT_SINGLE_ENTITY_10_PERCENT_NONE_CHECKED_DESC, 1, 178
   End If

   OnlyOneCheckOfTwo 1, 179, 180, IDCONNOCHK, IDCONCHK

   If isChecked(1, 179) Then
     Require IDCONVERUSEANDDATE, 1, 181
   End If

   OnlyOneCheckOfTwo 1, 182, 183, IDCOMELEMENTSUNITS, IDCOMELEMENTSUNITS

   If isChecked(1, 183) Then
     Require IDCOMELEMENTSUNITSNO, 1, 184
   End If

   OnlyOneCheckOfTwo 1, 183, 186, ID_PROJECT_CONTAINS_COMMERCIAL_NONE_CHECKED, ID_PROJECT_CONTAINS_COMMERCIAL_MANY_CHECKED

   If isChecked(1, 185) Then
     Require IDCOMSPACENO, 1, 187
   End If

   Require IDFILENUM, 2, 2
   Require IDCONQUAL, 2, 5
   Require IDCOMELEREC, 2, 6 

   OnlyOneCheckOfTwo 2, 7, 8, IDLEASEDHOA, IDLEASEDHOA
   
   If isChecked(2, 7) Then
      Require IDLEASEDHOAYES, 2, 9
   End If

   OnlyOneCheckOfTwo 2, 10, 11, IDGROUNDRENT, IDGROUNDRENT

   If isChecked(2, 10) Then
       Require IDGROUNDRENTYES, 2, 12
   End If

   If isChecked(2, 10) Then
       Require IDGROUNDRENTYES2, 2, 13
   End If

   OnlyOneCheckOfTwo 2, 14, 15, IDPARKFAC, IDPARKFAC

   If isChecked(2, 15) Then
       Require IDPARKFACNO, 2, 16
   End If

End Sub


Sub ReviewProjectAnalysis

AddTitle String(5, "=") + "Non-Lender Condo " + IDANALYSIS + String(5, "=")
   OnlyOneCheckOfTwo 2, 17, 18, IDANALYZEBUDGET, IDANALYZEBUDGET
   Require IDANALYZEBUDGETRESULTS, 2, 19

   OnlyOneCheckOfTwo 2, 20, 21, IDFACFEES, IDFACFEES
   If isChecked(2, 20) Then
       Require IDFACFEESYES, 2, 22
   End If

   OnlyOneCheckOfThree 2, 23, 24, 25, IDUNITCHARGE, IDUNITCHARGE
   If isChecked(2, 23) Then
       Require IDUNITCHARGEHILO, 2, 26
   End If
   If isChecked(2, 25) Then
       Require IDUNITCHARGEHILO, 2, 26
   End If

   OnlyOneCheckOfTwo 2, 27, 28, IDUNUSUALCHAR, IDUNUSUALCHAR
   If isChecked(2, 27) Then
       Require IDUNUSUALCHARYES, 2, 29
   End If


End Sub


Sub ReviewSubjectUnit

  AddTitle String(5, "=") + "Non-Lender Condo " + IDROOMLIST2 + String(5, "=")

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
    Require IDFIREPLACE2, 2, 57
  End If

  If isChecked(2, 58) Then
    Require IDSTOVES2, 2, 59
  End If

  If isChecked(2, 60) Then
    Require IDPATDECK, 2, 61
  End If

  If isChecked(2, 62) Then
    Require IDPORCH2, 2, 63
  End If

  If isChecked(2, 64) Then
    Require IDOTHER2, 2, 65
  End If

  If hastext(2, 57) Then
   Require IDFIREPLACE2CK, 2, 56
  End If

  If hastext(2, 59) Then
    Require IDSTOVES2CK, 2, 58
  End If

  If hastext(2, 61) Then
    Require IDPATDECKCK, 2, 60
  End If

  If hastext(2, 63) Then
    Require IDPORCH2CK, 2, 62
  End If
 
  If hastext(2, 65) Then
    Require IDOTHER2CK, 2, 64
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

  Require IDBEDCNT, 2, 81

  Require IDBATHCNT, 2, 82

  Require IDGLA, 2, 83

  OnlyOneCheckOfTwo 2, 84, 85, IDHEATCOOLMETER, XXXXX

  If isChecked(2, 85) Then
    Require IDHEATCOOLMETERCOM, 2, 86
  End If
  
  Require IDADDFEACONDo, 2, 87
  Require IDCONDITIONCONDO, 2, 88
  OnlyOneCheckOfTwo 2, 89, 90, IDADVERSE2, XXXXX

  If isChecked(2, 89) Then
    Require IDADVERSE, 2, 91
  End If
   
  OnlyOneCheckOfTwo 2, 92, 93, IDCONFORM2, XXXXX

  If isChecked(2, 93) Then
    Require IDCONFORM, 2, 94
  End If

End Sub

Sub ReviewPriorSales

  AddTitle String(5, "=") + "Non-Lender Condo " + IDPRIORSALES + String(5, "=")
  
  OnlyOneCheckOfTwo 2, 95, 96, IDRESEARCH2, XXXXX

  If isChecked(2, 96) Then
   Require IDRESEARCH, 2, 97
  End If
  
  OnlyOneCheckOfTwo 2, 98, 99, IDRESEARCHSUB2, XXXXX
  Require IDRESEARCHSUB3, 2, 100
  OnlyOneCheckOfTwo 2, 101, 102, IDRESEARCHCOMP2, XXXXX
  Require IDRESEARCHCOMP3, 2, 103
  Require IDDATEPSTSUB, 2, 104
  Require IDPRICEPSTSUB, 2, 105
  Require IDDATASOURCESUB, 2, 106
  Require IDDATASOURCEDATESUB, 2, 107
  Require IDDATEPSTCOMP1, 2, 108
  Require IDPRICEPSTCOMP1, 2, 109
  Require IDDATASOURCECOMP1, 2, 110
  Require IDDATASOURCEDATECOMP1, 2, 111
  Require IDDATEPSTCOMP2, 2, 112
  Require IDPRICEPSTCOMP2, 2, 113
  Require IDDATASOURCECOMP2, 2, 114 
  Require IDDATASOURCEDATECOMP2, 2, 115
  Require IDDATEPSTCOMP3, 2, 116
  Require IDPRICEPSTCOMP3, 2, 117
  Require IDDATASOURCECOMP3, 2, 118
  Require IDDATASOURCEDATECOMP3, 2, 119 
  Require IDANALYSIS2, 2, 120

End Sub

Sub ReviewSalesSubject

  AddTitle String(5, "=") + "Non-Lender Condo " + IDSALESAPP + String(5, "=")

  Require IDFILENUM, 3, 2
  Require IDPROPCOMP, 3, 5
  Require IDPROPCOMPFROM, 3, 6
  Require IDPROPCOMPTO, 3, 7
  Require IDSALECOMP, 3, 8
  Require IDSALECOMPFROM, 3, 9
  Require IDSALECOMPTO, 3, 10

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE2, 3, 55
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE2, 3, 123
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE2, 3, 191
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
     If num2 <= num3 and num2 <= num4 Then
       If num < num2 Then
         AddRec IDTOBERANGE2, 3, 55
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE2, 3, 123
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 55)
    num3 = GetValue(3, 123)
    num4 = GetValue(3, 191)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
          AddRec IDTOBERANGE2, 3, 191
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
      If num2 >= num3 and num2 >= num4 Then
        If num > num2 Then
          AddRec IDTOBERANGE3, 3, 117
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
      If num3 >= num2 and num3 >= num4 Then
        If num > num3 Then
          AddRec IDTOBERANGE3, 3, 185
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
      If num4 >= num3 and num4 >= num2 Then
        If num > num4 Then
          AddRec IDTOBERANGE3, 3, 253
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
     If num2 <= num3 and num2 <= num4 Then
       If num < num2 Then
          AddRec IDTOBERANGE3, 3, 117
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
      If num3 <= num2 and num3 <= num4 Then
        If num < num3 Then
          AddRec IDTOBERANGE3, 3, 185
        End If
      End If
  End If

  If hasText(3, 268) Then
    num = GetValue(3, 268)
    num2 = GetValue(3, 117)
    num3 = GetValue(3, 185)
    num4 = GetValue(3, 253)
      If num4 <= num3 and num4 <= num2 Then
        If num < num4 Then
         AddRec IDTOBERANGE3, 3, 253
        End If
      End If
  End If

   Require IDSUBADD, 3, 11

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
   Require IDSUBPHASE, 3, 14
   
   If not isChecked(1, 34) Then
     Require IDSUBSALES, 3, 15
     Require IDSUBPRGLA, 3, 16
   End If
   
   Require IDSUBLOC, 3, 22
   Require IDSUBLEASEHOLD, 3, 23
   Require IDSUBHOA, 3, 24
   Require IDSUBCOMELE, 3, 25
   Require IDSUBRECFAC, 3, 26
   Require IDSUBFLOORLOC, 3, 27
   Require IDSUBVIEW, 3, 28
   Require IDSUBDESIGN, 3, 29
   Require IDSUBQUAL, 3, 30
   Require IDSUBAGE, 3, 31
   Require IDSUBCOND, 3, 32
   Require IDSUBROOMS, 3, 33
   Require IDSUBBED, 3, 34
   Require IDSUBBATHS, 3, 35
   Require IDSUBGLA, 3, 36
   Require IDSUBBASE, 3, 37
   Require IDSUBBASEPER, 3, 38
   Require IDSUBFUNC, 3, 39
   Require IDSUBHEAT, 3, 40
   Require IDSUBENERGY, 3, 41
   Require IDSUBGARAGE, 3, 42
   Require IDSUBPORCH, 3, 43

   Require IDCOMP1ADD, 3, 50
   Require IDCOMP1UNITNO, 3, 51
   Require IDCOMP1NAME, 3, 52
   Require IDCOMP1PHASE, 3, 53
   Require IDCOMP1PROX, 3, 54
   Require IDCOMP1SALES, 3, 55

   If hasText(3, 55) Then
     num = GetValue(3, 55) / 1000
       If num > GetValue(1, 72) Then
         AddRec IDTOBERANGEC4, 3, 55
       End If
   End If

   If hasText(3, 55) Then
     num = GetValue(3, 55) / 1000
       If num < GetValue(1, 71) Then
         AddRec IDTOBERANGEC4, 3, 55
       End If
   End If

   If hasText(3, 55) Then
     num = GetValue(3, 55)
       If num < GetValue(3,9) Then
         AddRec IDTOBERANGE10, 3, 55
       End If
   End If

   If hasText(3, 55) Then
     num = GetValue(3, 55)
       If num > GetValue(3,10) Then
         AddRec IDTOBERANGE10, 3, 55
       End If
   End If

   Require IDCOMP1PRGLA, 3, 56
   Require IDCOMP1SOURCE, 3, 57
   Require IDCOMP1VER, 3, 58
   Require IDCOMP1SF, 3, 59
   Require IDCOMP1CONC, 3, 61
   Require IDCOMP1DOS, 3, 63
   Require IDCOMP1LOC, 3, 65
   Require IDCOMP1LEASEHOLD, 3, 67
   Require IDCOMP1HOA, 3, 69
   Require IDCOMP1COMELE, 3, 71
   Require IDCOMP1RECFAC, 3, 73
   Require IDCOMP1FLOORLOC, 3, 75
   Require IDCOMP1VIEW, 3, 77
   Require IDCOMP1DESIGN, 3, 79
   Require IDCOMP1QUAL, 3, 81
   Require IDCOMP1AGE, 3, 83
   Require IDCOMP1COND, 3, 85
   Require IDCOMP1ROOMS, 3, 88
   Require IDCOMP1BED, 3, 89
   Require IDCOMP1BATHS, 3, 90
   Require IDCOMP1GLA, 3, 92
   Require IDCOMP1BASE, 3, 94
   Require IDCOMP1BASEPER, 3, 96
   Require IDCOMP1FUNC, 3, 98
   Require IDCOMP1HEAT, 3, 100
   Require IDCOMP1ENERGY, 3, 102
   Require IDCOMP1GARAGE, 3, 104
   Require IDCOMP1PORCH, 3, 106


   If hasText(3, 117) Then
     num = GetValue(3, 117) / 1000
       If num > GetValue(1, 72) Then
         AddRec IDTOBERANGEC5, 3, 117
       End If
   End If

   If hasText(3, 117) Then
     num = GetValue(3, 117) / 1000
       If num < GetValue(1, 71) Then
         AddRec IDTOBERANGEC5, 3, 117
       End If
   End If

   Require IDCOMP2ADD, 3, 118
   Require IDCOMP2UNITNO, 3, 119
   Require IDCOMP2NAME, 3, 120
   Require IDCOMP2PHASE, 3, 121
   Require IDCOMP2PROX, 3, 122
   Require IDCOMP2SALES, 3, 123

   If hasText(3, 123) Then
     num = GetValue(3, 123) / 1000
       If num > GetValue(1, 72) Then 
         AddRec IDTOBERANGEC6, 3, 123
      End If
   End If

   If hasText(3, 123) Then
     num = GetValue(3, 123) / 1000
       If num < GetValue(1, 71) Then
         AddRec IDTOBERANGEC6, 3, 123
       End If
   End If
  
   If hasText(3, 123) Then
     num = GetValue(3, 123)
        If num < GetValue(3,9) Then
          AddRec IDTOBERANGE11, 3, 123
        End If
   End If

   If hasText(3, 123) Then
     num = GetValue(3, 123)
       If num > GetValue(3,10) Then
         AddRec IDTOBERANGE11, 3, 123
       End If
   End If
 
  Require IDCOMP2PRGLA, 3, 124
  Require IDCOMP2SOURCE, 3, 125
  Require IDCOMP2VER, 3, 126
  Require IDCOMP2SF, 3, 127
  Require IDCOMP2CONC, 3, 129
  Require IDCOMP2DOS, 3, 131
  Require IDCOMP2LOC, 3, 133
  Require IDCOMP2LEASEHOLD, 3, 135
  Require IDCOMP2HOA, 3, 137
  Require IDCOMP2COMELE, 3, 139
  Require IDCOMP2RECFAC, 3, 141
  Require IDCOMP2FLOORLOC, 3, 143
  Require IDCOMP2VIEW, 3, 145
  Require IDCOMP2DESIGN, 3, 147
  Require IDCOMP2QUAL, 3, 149
  Require IDCOMP2AGE, 3, 151
  Require IDCOMP2COND, 3, 153
  Require IDCOMP2ROOMS, 3, 156
  Require IDCOMP2BED, 3, 157
  Require IDCOMP2BATHS, 3, 158
  Require IDCOMP2GLA, 3, 160
  Require IDCOMP2BASE, 3, 162
  Require IDCOMP2BASEPER, 3, 164
  Require IDCOMP2FUNC, 3, 166
  Require IDCOMP2HEAT, 3, 168
  Require IDCOMP2ENERGY, 3, 170
  Require IDCOMP2GARAGE, 3, 172
  Require IDCOMP2PORCH, 3, 174

  If hasText(3, 185) Then
    num = GetValue(3, 185) / 1000
      If num > GetValue(1, 72) Then
        AddRec IDTOBERANGEC7, 3, 185
      End If
  End If

  If hasText(3, 185) Then
    num = GetValue(3, 185) / 1000
      If num < GetValue(1, 71) Then
        AddRec IDTOBERANGEC7, 3, 185
      End If
  End If

  Require IDCOMP3ADD, 3, 186
  Require IDCOMP3UNITNO, 3, 187
  Require IDCOMP3NAME, 3, 188
  Require IDCOMP3PHASE, 3, 189
  Require IDCOMP3PROX, 3, 190
  Require IDCOMP3SALES, 3, 191

  If hasText(3, 191) Then
    num = GetValue(3, 191) / 1000
      If num > GetValue(1, 72) Then
        AddRec IDTOBERANGEC8, 3, 191
      End If
  End If

  If hasText(3, 191) Then
    num = GetValue(3, 191) / 1000
      If num < GetValue(1, 71) Then
        AddRec IDTOBERANGEC8, 3, 191
      End If
  End If

  If hasText(3, 191) Then
    num = GetValue(3, 191)
      If num < GetValue(3,9) Then
        AddRec IDTOBERANGE12, 3, 191
      End If
  End If

  If hasText(3, 191) Then
    num = GetValue(3, 191)
      If num > GetValue(3,10) Then
        AddRec IDTOBERANGE12, 3, 191
      End If
  End If

  Require IDCOMP3PRGLA, 3, 192
  Require IDCOMP3SOURCE, 3, 193
  Require IDCOMP3VER, 3, 194
  Require IDCOMP3SF, 3, 195
  Require IDCOMP3CONC, 3, 197
  Require IDCOMP3DOS, 3, 199
  Require IDCOMP3LOC, 3, 201
  Require IDCOMP3LEASEHOLD, 3, 203
  Require IDCOMP3HOA, 3, 205
  Require IDCOMP3COMELE, 3, 207
  Require IDCOMP3RECFAC, 3, 209
  Require IDCOMP3FLOORLOC, 3, 211
  Require IDCOMP3VIEW, 3, 213
  Require IDCOMP3DESIGN, 3, 215
  Require IDCOMP3QUAL, 3, 217
  Require IDCOMP3AGE, 3, 219
  Require IDCOMP3COND, 3, 221
  Require IDCOMP3ROOMS, 3, 224
  Require IDCOMP3BED, 3, 225
  Require IDCOMP3BATHS, 3, 226
  Require IDCOMP3GLA, 3, 228
  Require IDCOMP3BASE, 3, 230
  Require IDCOMP3BASEPER, 3, 232
  Require IDCOMP3FUNC, 3, 234
  Require IDCOMP3HEAT, 3, 236
  Require IDCOMP3ENERGY, 3, 238
  Require IDCOMP3GARAGE, 3, 240
  Require IDCOMP3PORCH, 3, 242

  If hasText(3, 253) Then
    num = GetValue(3, 253) / 1000
     If num > GetValue(1, 72) Then
       AddRec IDTOBERANGEC9, 3, 253
     End If
  End If

  If hasText(3, 253) Then
    num = GetValue(3, 253) / 1000
      If num < GetValue(1, 71) Then
        AddRec IDTOBERANGEC9, 3, 253
      End If
  End If

  Require IDSUMMARYSALES, 3, 254

  If Not hasText(3, 255) Then
    AddRec IDTOBE, 3, 255
  End If

End Sub


Sub ReviewIncomeApproach

  AddTitle String(5, "=") + "Non-Lender Condo " + IDINCOME + String(5, "=")   
  
  Require IDINCOMERENT2, 3, 256
  Require IDINCOMEGRM2, 3, 257
  Require IDINCOMEVALUE2, 3, 258
  Require IDSUMMARYINCOME, 3, 259

End Sub


Sub ReviewReconciliation

  AddTitle String(5, "=") + "Non-Lender Condo " + IDRECON + String(5, "=")

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
