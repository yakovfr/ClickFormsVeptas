'REV00357.vbs 2000 Reviewer Script
'01/29/2013: 
' Add code to check for effective date, since no signature date, we use today's date to compare

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewSec1
  AddTitle ""
  ReviewSec2
  AddTitle ""

End Sub

Sub ReviewSubject
   AddTitle String(5, "=") + "FNMA 2000 " + IDSUBJECT + String(5, "=")
   Require IDFilenum, 1,2
   Require IDAddress, 1, 5
   Require IDCity, 1, 6
   Require IDState, 1, 7
   Require IDZip, 1, 8
   Require IDBorrower, 1, 9  
   Require IDOWNERPUB, 1, 10
   Require IDCounty, 1, 11
   Require IDLegal, 1, 12
   Require IDAPN2, 1, 13
   Require IDMapref, 1, 14
   Require IDCensus, 1, 15
   OnlyOneCheckOfThree 1, 16, 17, 18, ID_PROPERTY_RIGHTS_NONE_CHECKED, ID_PROPERTY_RIGHTS_MANY_CHECKED
   
   If isChecked(1, 18) Then
     Require IDOTHERDATA, 1, 19
   End If

      
   OnlyOneCheckOfThree 1, 20, 21, 22, IDPROJTYPE2000, "PROJECT TYPE: Too maby boxes checked"
   Require IDLOANNO, 1, 23
   Require IDEFFDATE2000, 1, 24
   ' Show warning if effective date i= signature date + 14
   IDEffectiveDatePast2Wks = "Effective Date of Appraisal is more than 14 days ago."
  'No signature date, we use today's date here
   sigDate = Date
   effDate = GetText(1,24)
   If (DateDiff("d", effDate, sigDate) > 14)  then
     If IsUAD then 
      AddRec "" &IDEffectiveDatePast2Wks, 1,24
     else
      AddRec IDEffectiveDatePast2Wks, 1,24
     end If
   end If

   OnlyOneCheckOfTwo 1, 25, 26, IDMANHOME2000, "MANUF HOME: Both Yes and No are checked"
   Require IDLender, 1, 27
   Require IDLenderAdd, 1, 28
End Sub

Sub ReviewSec1
   AddTitle String(5, "=") + "FNMA 2000 " + IDSECI + String(5, "=")
   OnlyOneCheckOfTwo 1, 29, 30, IDSUBACCURATE, "SUBJECT SECTION COMPLETE: Bothe Yes and No are Checked"
   Require IDSUBACCURATECOM, 1, 31
   OnlyOneCheckOfThree 1, 32, 33, 34, IDCONTRACTACCURATE, "CONTRACT ACCURATE: More than one box is checked"
   
   If isChecked(1, 32) Then
     Require IDCONTRACTACCURATECOM, 1, 35
   End If
   
   If isChecked(1, 33) Then
     Require IDCONTRACTACCURATECOM, 1, 35
   End If

   OnlyOneCheckOfTwo 1, 36, 37, IDNEIGHACCURATE, "NEIGHBORHOOD SEC ACCURATE: Bothe Yes and No are checked"
   Require IDNEIGHACCURATECOM, 1, 38
   OnlyOneCheckOfTwo 1, 39, 40, IDSITEACCURATE, "SITE SEC ACCURATE: Bothe Yes and No are checked"
   Require IDSITEACCURATECOM, 1, 41
   OnlyOneCheckOfTwo 1, 42, 43, IDIMPROVACCURATE, "IMPROVEMENTS SEC ACCURATE: Both eYes and No are checked"
   Require IDIMPROVEACCURATECOM, 1, 44
   OnlyOneCheckOfTwo 1, 45, 46, IDCOMPACCURATE, "COMPARABLES APPROPRIATE: Both Yes and No are checked"
   Require IDCOMPACCURATECOM, 1, 47
   OnlyOneCheckOfTwo 1, 48, 49, IDSALESACCURATE, "MKT ANALYSIS ACCURATE: Both Yes and No are checked"
   Require IDSALESACCURATECOM, 1, 50
   OnlyOneCheckOfThree 1, 51, 52, 53, IDINCOMEACCURATE, "INCOME/COST ACCURATE: Both Yes and No are checked"
   
   If isChecked(1, 52) Then
     Require IDINCOMEACCURATECOM, 1, 54
   End If

   OnlyOneCheckOfTwo 1, 55, 56, IDTRANSFERACCURATE, "SALES/TRANSFER HISTORY: Both Yes and No are checked"
   Require IDTRANSFERACCURATECOM, 1, 57
   OnlyOneCheckOfTwo 1, 58, 59, IDOPINIONACCURATE, "OPINION OF VALUE REASONABLE: Bothe Yes and No are checked"
End Sub

Sub ReviewSec2
   AddTitle String(5, "=") + "FNMA 2000 " + IDSECII + String(5, "=")
   Require IDFilenum, 2, 2
   If isChecked(1, 59) Then
     Require IDDISAGREEOPINION, 2, 5
     Require IDASSUMPTIONSUSED, 2, 6
     
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num2 >= num3 and num2 >= num4 Then
            If num > num2 Then
              AddRec IDTOBERANGE2, 2, 44
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num3 >= num2 and num3 >= num4 Then
            If num > num3 Then
              AddRec IDTOBERANGE2, 2, 104
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num4 >= num3 and num4 >= num2 Then
            If num > num4 Then
              AddRec IDTOBERANGE2, 2, 164
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num2 <= num3 and num2 <= num4 Then
            If num < num2 Then
              AddRec IDTOBERANGE2, 2, 44
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num3 <= num2 and num3 <= num4 Then
            If num < num3 Then
              AddRec IDTOBERANGE2, 2, 104
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 44)
        num3 = GetValue(2, 104)
        num4 = GetValue(2, 164)
          If num4 <= num3 and num4 <= num2 Then
            If num < num4 Then
              AddRec IDTOBERANGE2, 2, 164
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num2 >= num3 and num2 >= num4 Then
            If num > num2 Then
              AddRec IDTOBERANGE3, 2, 100
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num3 >= num2 and num3 >= num4 Then
            If num > num3 Then
              AddRec IDTOBERANGE3, 2, 160
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num4 >= num3 and num4 >= num2 Then
            If num > num4 Then
              AddRec IDTOBERANGE3, 2, 220
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num2 <= num3 and num2 <= num4 Then
            If num < num2 Then
              AddRec IDTOBERANGE3, 2, 100
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num3 <= num2 and num3 <= num4 Then
            If num < num3 Then
              AddRec IDTOBERANGE3, 2, 160
            End If
          End If
     End If
     If hasText(2, 244) Then
        num = GetValue(2, 244)
        num2 = GetValue(2, 100)
        num3 = GetValue(2, 160)
        num4 = GetValue(2, 220)
          If num4 <= num3 and num4 <= num2 Then
            If num < num4 Then
              AddRec IDTOBERANGE3, 2, 220
            End If
          End If
     End If
     
     Require IDSUBADD, 2, 7
     Require IDSUBCITY, 2, 8
  
     If hasText(2, 8) Then
       text1 = GetText(2, 8)
       text2 = GetText(1, 6)
       text3 = GetText(1, 7)
       text4 = GetText(1, 8)
       If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
         AddRec IDADDMATCH, 2, 8
       End If
     End If

     Require IDSUBSALES, 2, 9
     Require IDSUBPRGLA, 2, 10
     Require IDSUBLOC, 2, 16
     Require IDSUBLEASEHOLD, 2, 17
     Require IDSUBSITE, 2, 18
     Require IDSUBVIEW, 2, 19
     Require IDSUBDESIGN, 2, 20
     Require IDSUBQUAL, 2, 21
     Require IDSUBAGE, 2, 22
     Require IDSUBCOND, 2, 23
     Require IDSUBROOMS, 2, 24
     Require IDSUBBED, 2, 25
     Require IDSUBBATHS, 2, 26
     Require IDSUBGLA, 2, 27
     Require IDSUBBASE, 2, 28
     If not ((GetText(2, 28) = "0sf") or (GetText(2, 28) = "0sqm")) Then
       Require IDSUBBASEPER, 2, 29
     End If
     Require IDSUBFUNC, 2, 30
     Require IDSUBHEAT, 2, 31
     Require IDSUBENERGY, 2, 32
     Require IDSUBGARAGE, 2, 33
     Require IDSUBPORCH, 2, 34


     Require IDCOMP1ADD, 2, 41
     Require IDCOMP1CITY, 2, 42
     Require IDCOMP1PROX, 2, 43
     Require IDCOMP1SALES, 2, 44
     Require IDCOMP1PRGLA, 2, 45
     Require IDCOMP1SOURCE, 2, 46
     Require IDCOMP1VER, 2, 47
     Require IDCOMP1SF, 2, 48
     Require IDCOMP1CONC, 2, 50
     Require IDCOMP1DOS, 2, 52
     Require IDCOMP1LOC, 2, 54
     Require IDCOMP1LEASEHOLD, 2, 56
     Require IDCOMP1SITE, 2, 58
     Require IDCOMP1VIEW, 2, 60
     Require IDCOMP1DESIGN, 2, 62
     Require IDCOMP1QUAL, 2, 64
     Require IDCOMP1AGE, 2, 66
     Require IDCOMP1COND, 2, 68
     Require IDCOMP1ROOMS, 2, 71
     Require IDCOMP1BED, 2, 72
     Require IDCOMP1BATHS, 2, 73
     Require IDCOMP1GLA, 2, 75
     Require IDCOMP1BASE, 2, 77
     If not ((GetText(2, 77) = "0sf") or (GetText(2, 77) = "0sqm")) Then
       Require IDCOMP1BASEPER, 2, 79
     End If
     Require IDCOMP1FUNC, 2, 81
     Require IDCOMP1HEAT, 2, 83
     Require IDCOMP1ENERGY, 2, 85
     Require IDCOMP1GARAGE, 2, 87
     Require IDCOMP1PORCH, 2, 89

     Require IDCOMP2ADD, 2, 101
     Require IDCOMP2CITY, 2, 102
     Require IDCOMP2PROX, 2, 103
     Require IDCOMP2SALES, 2, 104
     Require IDCOMP2PRGLA, 2, 105
     Require IDCOMP2SOURCE, 2, 106
     Require IDCOMP2VER, 2, 107
     Require IDCOMP2SF, 2, 108
     Require IDCOMP2CONC, 2, 110
     Require IDCOMP2DOS, 2, 112
     Require IDCOMP2LOC, 2, 114
     Require IDCOMP2LEASEHOLD, 2, 116 
     Require IDCOMP2SITE, 2, 118
     Require IDCOMP2VIEW, 2, 120
     Require IDCOMP2DESIGN, 2, 122
     Require IDCOMP2QUAL, 2, 124
     Require IDCOMP2AGE, 2, 126
     Require IDCOMP2COND, 2, 128
     Require IDCOMP2ROOMS, 2, 131
     Require IDCOMP2BED, 2, 132
     Require IDCOMP2BATHS, 2, 133
     Require IDCOMP2GLA, 2, 135
     Require IDCOMP2BASE, 2, 137
     If not ((GetText(2, 137) = "0sf") or (GetText(2, 137) = "0sqm")) Then
       Require IDCOMP2BASEPER, 2, 139
     End If
     Require IDCOMP2FUNC, 2, 141
     Require IDCOMP2HEAT, 2, 143
     Require IDCOMP2ENERGY, 2, 145
     Require IDCOMP2GARAGE, 2, 147
     Require IDCOMP2PORCH, 2, 149


     Require IDCOMP3ADD, 2, 161
     Require IDCOMP3CITY, 2, 162
     Require IDCOMP3PROX, 2, 163
     Require IDCOMP3SALES, 2, 164
     Require IDCOMP3PRGLA, 2, 165
     Require IDCOMP3SOURCE, 2, 166 
     Require IDCOMP3VER, 2, 167
     Require IDCOMP3SF, 2, 168
     Require IDCOMP3CONC, 2, 170
     Require IDCOMP3DOS, 2, 172
     Require IDCOMP3LOC, 2, 174
     Require IDCOMP3LEASEHOLD, 2, 176 
     Require IDCOMP3SITE, 2, 178
     Require IDCOMP3VIEW, 2, 180
     Require IDCOMP3DESIGN, 2, 182
     Require IDCOMP3QUAL, 2, 184
     Require IDCOMP3AGE, 2, 186
     Require IDCOMP3COND, 2, 188
     Require IDCOMP3ROOMS, 2, 191
     Require IDCOMP3BED, 2, 192
     Require IDCOMP3BATHS, 2, 193
     Require IDCOMP3GLA, 2, 195
     Require IDCOMP3BASE, 2, 197
     If not ((GetText(2, 197) = "0sf") or (GetText(2, 197) = "0sqm")) Then
       Require IDCOMP3BASEPER, 2, 199
     End If
     Require IDCOMP3FUNC, 2, 201
     Require IDCOMP3HEAT, 2, 203
     Require IDCOMP3ENERGY, 2, 205
     Require IDCOMP3GARAGE, 2, 207
     Require IDCOMP3PORCH, 2, 209

     OnlyOneCheckOfTwo 2, 221, 222, IDRESEARCH2, "SALE TRANSFER HIST RESEARCHED: Yes and No are checked"

     If isChecked(2, 221) Then
       Require IDRESEARCH, 2, 223
     End If

     OnlyOneCheckOfTwo 2, 224, 225, IDRESEARCHCOMP, "PRIOR SALES OF COMPS: Both Yes and No are checked"
     Require IDRESEARCHCOMPDS, 2, 226
     Require IDDATEPSTCOMP1, 2, 227
     Require IDPRICEPSTCOMP1, 2, 228
     Require IDDATASOURCECOMP1, 2, 229
     Require IDDATASOURCEDATECOMP1, 2, 230
     Require IDDATEPSTCOMP2, 2, 231
     Require IDPRICEPSTCOMP2, 2, 232
     Require IDDATASOURCECOMP2, 2, 233 
     Require IDDATASOURCEDATECOMP2, 2, 234
     Require IDDATEPSTCOMP3, 2, 235
     Require IDPRICEPSTCOMP3, 2, 236
     Require IDDATASOURCECOMP3, 2, 237
     Require IDDATASOURCEDATECOMP3, 2, 238 
     Require IDSUMMARYVALUECONC, 2, 240
     OnlyOneCheckOfTwo 2, 241, 242, IDREVIEWOPINION, "REVIEWER OPINION BASIS: Both Exterior and Complete are checked"
     Require IDREVIEWAMT, 2, 243
     Require IDREVIEWASOF, 2, 244
   End If
End Sub