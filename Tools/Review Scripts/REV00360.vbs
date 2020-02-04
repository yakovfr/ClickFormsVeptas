'REV00360.vbs 2000A Reviewer Script

Sub ReviewForm
  ReviewSubject
  AddTitle ""
  ReviewSec1
  AddTitle ""
  ReviewSec2
  AddTitle ""

End Sub

Sub ReviewSubject
   AddTitle String(5, "=") + "FNMA 2000A " + IDSUBJECT + String(5, "=")
   Require IDFilenum, 1, 2
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
   OnlyOneCheckOfThree 1, 19, 20, 21, IDNUMUNITSREVIEW, "NUMBER OF UNITS: More than one box checked"
   Require IDLOANNO, 1, 23
   Require IDEFFDATE2000, 1, 24  
   OnlyOneCheckOfThree 1, 25, 26, 27, IDPROJTYPE2000, "PROJECT TYPE: More than one box checked"
   Require IDLender, 1, 28
   Require IDLenderAdd, 1, 29
End Sub

Sub ReviewSec1
   AddTitle String(5, "=") + "FNMA 2000A " + IDSECI + String(5, "=")
   OnlyOneCheckOfTwo 1, 30, 31, IDSUBACCURATE, "SUBJECT ACCURATE: More than one box checked"
   Require IDSUBACCURATECOM, 1, 32
   OnlyOneCheckOfThree 1, 33, 34, 35, IDCONTRACTACCURATE, "CONTRACT ACCURATE: More than one box checked"
   
   If isChecked(1, 33) Then
     Require IDCONTRACTACCURATECOM, 1, 36
   End If
   
   If isChecked(1, 34) Then
     Require IDCONTRACTACCURATECOM, 1, 36
   End If

   OnlyOneCheckOfTwo 1, 37, 38, IDNEIGHACCURATE, "NEIGHBORHOOD ACCURATE: More than one box checked"
   Require IDNEIGHACCURATECOM, 1, 39

   OnlyOneCheckOfTwo 1, 40, 41, IDSITEACCURATE, "SITE ACCURATE: More than one box checked"
   Require IDSITEACCURATECOM, 1, 42

   OnlyOneCheckOfTwo 1, 43, 44, IDIMPROVACCURATE, "IMPROVEMENTS ACCURATE: More than one box checked"
   Require IDIMPROVEACCURATECOM, 1, 45

   OnlyOneCheckOfTwo 1, 46, 47, IDCOMPRENTACCURATE, "RENTAL DATA ACCURATE: More than one box checked"
   Require IDCOMPRENTACCURATECOM, 1, 48

   OnlyOneCheckOfTwo 1, 49, 50, IDRENTSCHEDULEACCURATE, "SUB RENT SCHEDULE ACCURATE: More than one box checked"
   Require IDRENTSCHEDULEACCURATECOM, 1, 51

   OnlyOneCheckOfTwo 1, 52, 53, IDOPINIONRENTACCURATE, "OPINION OF RENT REASONABLE:  More than one box checked"
   Require IDOPINIONRENTACCURATECOM, 1, 54

   OnlyOneCheckOfTwo 1, 55, 56, IDTRANSFERACCURATE, "TRANSFER HISTORY:  More than one box checked"
   Require IDTRANSFERACCURATECOM, 1, 57

   Require IDFilenum, 2, 2

   OnlyOneCheckOfTwo 2, 5, 6, IDCOMPACCURATE, "COMP SALES APPROPRIATE: More than one box checked"
   Require IDCOMPACCURATECOM, 2, 7

   OnlyOneCheckOfTwo 2, 8, 9, IDSALESACCURATE, "SALES ANALYSIS ACCURATE: More than one box checked"
   Require IDSALESACCURATECOM, 2, 10

   OnlyOneCheckOfTwo 2, 11, 12, IDINDRECONCILED, "SALES ANALYSIS RECONCILED: More than one box checked"
   Require IDINDRECONCILEDCOM, 2, 13

   OnlyOneCheckOfTwo 2, 14, 15, IDOPINIONACCURATE, "OPINON OF VALUE REASONABLE: More than one box checked"
End Sub

Sub ReviewSec2
   AddTitle String(5, "=") + "FNMA 2000A " + IDSECII + String(5, "=")
   If isChecked(2, 15) Then
     Require IDDISAGREEOPINION, 2, 16
     Require IDASSUMPTIONSUSED, 2, 17
     OnlyOneCheckOfTwo 2, 18, 19, IDRESEARCH2, "SALES HISTORY RESEARCHED: Both Did and Did Not are checked"
       If isChecked(2, 19) Then
          Require IDRESEARCH, 2, 20
       End If
     OnlyOneCheckOfTwo 2, 21, 22, IDRESEARCHCOMP, "RESULTS OF SEARCH: Both Did and Did Not are checked"
     Require IDRESEARCHCOMPDS, 2, 23
     Require IDDATEPSTCOMP1, 2, 24
     Require IDPRICEPSTCOMP1, 2, 25
     Require IDDATASOURCECOMP1, 2, 26
     Require IDDATASOURCEDATECOMP1, 2, 27
     Require IDDATEPSTCOMP2, 2, 28
     Require IDPRICEPSTCOMP2, 2, 29
     Require IDDATASOURCECOMP2, 2, 30 
     Require IDDATASOURCEDATECOMP2, 2, 31
     Require IDDATEPSTCOMP3, 2, 32
     Require IDPRICEPSTCOMP3, 2, 33
     Require IDDATASOURCECOMP3, 2, 34
     Require IDDATASOURCEDATECOMP3, 2, 35 
     Require IDANALYSISA, 2, 36 


     Require IDFilenum, 3, 2

     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num2 >= num3 and num2 >= num4 Then
            If num > num2 Then
              AddRec IDTOBERANGE2, 3, 58
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num3 >= num2 and num3 >= num4 Then
            If num > num3 Then
              AddRec IDTOBERANGE2, 3, 140
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num4 >= num3 and num4 >= num2 Then
            If num > num4 Then
              AddRec IDTOBERANGE2, 3, 222
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num2 <= num3 and num2 <= num4 Then
            If num < num2 Then
              AddRec IDTOBERANGE2, 3, 58
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num3 <= num2 and num3 <= num4 Then
            If num < num3 Then
              AddRec IDTOBERANGE2, 3, 140
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 58)
        num3 = GetValue(3, 140)
        num4 = GetValue(3, 222)
          If num4 <= num3 and num4 <= num2 Then
            If num < num4 Then
              AddRec IDTOBERANGE2, 3, 222
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num2 >= num3 and num2 >= num4 Then
            If num > num2 Then
              AddRec IDTOBERANGE3, 3, 133
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num3 >= num2 and num3 >= num4 Then
            If num > num3 Then
              AddRec IDTOBERANGE3, 3, 215
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num4 >= num3 and num4 >= num2 Then
            If num > num4 Then
              AddRec IDTOBERANGE3, 3, 297
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num2 <= num3 and num2 <= num4 Then
            If num < num2 Then
              AddRec IDTOBERANGE3, 3, 133
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num3 <= num2 and num3 <= num4 Then
            If num < num3 Then
              AddRec IDTOBERANGE3, 3, 215
            End If
          End If
     End If
     If hasText(3, 321) Then
        num = GetValue(3, 321)
        num2 = GetValue(3, 133)
        num3 = GetValue(3, 215)
        num4 = GetValue(3, 297)
          If num4 <= num3 and num4 <= num2 Then
            If num < num4 Then
              AddRec IDTOBERANGE3, 3, 297
            End If
          End If
     End If
   
     Require IDSUBADD, 3, 5

     If hasText(3, 6) Then
       text1 = GetText(3, 6)
       text2 = GetText(1, 6)
       text3 = GetText(1, 7)
       text4 = GetText(1, 8)
       If not text1 = text2 + IDCOMMA + IDSPACE + text3 + IDSPACE + text4 Then
         AddRec IDADDMATCH, 3, 6
       End If
     End If

     Require IDSUBSALES, 3, 7
     Require IDSUBPRICEGBA1, 3, 8
     Require IDSUBGMR1, 3, 9
     Require IDSUBGRM1, 3, 10
     Require IDSUBPRICEUNIT, 3, 11
     Require IDSUBPRICEROOM, 3, 12
     Require IDSUBPRICEBED, 3, 13
     OnlyOneCheckOfTwo 3, 14, 15, IDRENTCONTROLSUB, "SUBJET RENT CONTROLS: Both Yes and No are checked"
     Require IDSUBLOC, 3, 21
     Require IDSUBLEASEHOLD, 3, 22
     Require IDSUBSITE, 3, 23
     Require IDSUBVIEW, 3, 24
     Require IDSUBDESIGN, 3, 25
     Require IDSUBQUAL, 3, 26
     Require IDSUBAGE, 3, 27
     Require IDSUBCOND, 3, 28
     Require IDSUBGBA, 3, 29
     
     Require IDUNIT1TOTALSUB, 3, 30 
     Require IDUNIT1BEDSUB, 3, 31
     Require IDUNIT1BATHSUB, 3, 32
     Require IDUNIT2TOTALSUB, 3, 33 
     Require IDUNIT2BEDSUB, 3, 34
     Require IDUNIT2BATHSUB, 3, 35

     If isChecked(1, 20) or isChecked(1, 21) then
       Require IDUNIT3TOTALSUB, 3, 36
       Require IDUNIT3BEDSUB, 3, 37
       Require IDUNIT3BATHSUB, 3, 38
     End If

     If isChecked(1, 21) then
       Require IDUNIT4TOTALSUB, 3, 39
       Require IDUNIT4BEDSUB, 3, 40
       Require IDUNIT4BATHSUB, 3, 41
     End If
     
     Require IDBASEDESCRENTSUB, 3, 42
     If not ((GetText(3, 42) = "0sf") or (GetText(3, 42) = "0sqm")) Then
       Require IDBASEFINRENTSUB, 3, 43
     End If
     Require IDSUBFUNC, 3, 44
     Require IDSUBHEAT, 3, 45
     Require IDSUBENERGY, 3, 46
     Require IDPARKRENTSUB, 3, 47
     Require IDSUBPORCH, 3, 48


     Require IDCOMP1ADD, 3, 55
     Require IDCOMP1PROX, 3, 57
     Require IDCOMP1SALES, 3, 58
     Require IDCOMP1PRICEGBA, 3, 59
     Require IDCOMP1GMR, 3, 60
     Require IDCOMP1GRM, 3, 61
     Require IDCOMP1PRICEUNIT, 3, 62
     Require IDCOMP1PRICEROOM, 3, 63
     Require IDCOMP1PRICEBED, 3, 64
     OnlyOneCheckOfTwo 3, 65, 66, IDRENTCONTROLCOMP1, "RENTAL 1 RENT CONTROLLED: Both Yes and No are checked"
     Require IDCOMP1SOURCE, 3, 67
     Require IDCOMP1VER, 3, 68
     Require IDCOMP1SF, 3, 69
     Require IDCOMP1CONC, 3, 71
     Require IDCOMP1DOS, 3, 73
     Require IDCOMP1LOC, 3, 75
     Require IDCOMP1LEASEHOLD, 3, 77
     Require IDCOMP1SITE, 3, 79
     Require IDCOMP1VIEW, 3, 81
     Require IDCOMP1DESIGN, 3, 83
     Require IDCOMP1QUAL, 3, 85
     Require IDCOMP1AGE, 3, 87
     Require IDCOMP1COND, 3, 89
     Require IDCOMP1GBA, 3, 91
     Require IDUNIT1TOTALCOMP1, 3, 94 
     Require IDUNIT1BEDCOMP1, 3, 95
     Require IDUNIT1BATHCOMP1, 3, 96
     Require IDUNIT2TOTALCOMP1, 3, 98 
     Require IDUNIT2BEDCOMP1, 3, 99
     Require IDUNIT2BATHCOMP1, 3, 100

     If isChecked(1, 20) or isChecked(1, 21) then
       Require IDUNIT3TOTALCOMP1, 3, 102
       Require IDUNIT3BEDCOMP1, 3, 103
       Require IDUNIT3BATHCOMP1, 3, 104
     End If

     If isChecked(1, 21) then
       Require IDUNIT4TOTALCOMP1, 3, 106
       Require IDUNIT4BEDCOMP1, 3, 107
       Require IDUNIT4BATHCOMP1, 3, 108
     End If

     Require IDBASEDESCRENTCOMP1, 3, 110
     If not ((GetText(3, 110) = "0sf") or (GetText(3, 110) = "0sqm")) Then
       Require IDBASEFINRENTCOMP1, 3, 112
     End If
     Require IDCOMP1FUNC, 3, 114
     Require IDCOMP1HEAT, 3, 116
     Require IDCOMP1ENERGY, 3, 118
     Require IDPARKRENTCOMP1, 3, 120
     Require IDCOMP1PORCH, 3, 122


     Require IDCOMP2ADD, 3, 137
     Require IDCOMP2PROX, 3, 139
     Require IDCOMP2SALES, 3, 140
     Require IDCOMP2PRICEGBA, 3, 141
     Require IDCOMP2GMR, 3, 142
     Require IDCOMP2GRM, 3, 143
     Require IDCOMP2PRICEUNIT, 3, 144
     Require IDCOMP2PRICEROOM, 3, 145
     Require IDCOMP2PRICEBED, 3, 146
     OnlyOneCheckOfTwo 3, 147, 148, IDRENTCONTROLCOMP2, "RENTAL 2 RENT CONTROLLED: Both Yes and No are checked"
     Require IDCOMP2SOURCE, 3, 149
     Require IDCOMP2VER, 3, 150
     Require IDCOMP2SF, 3, 151
     Require IDCOMP2CONC, 3, 153
     Require IDCOMP2DOS, 3, 155
     Require IDCOMP2LOC, 3, 157
     Require IDCOMP2LEASEHOLD, 3, 159
     Require IDCOMP2SITE, 3, 161
     Require IDCOMP2VIEW, 3, 163
     Require IDCOMP2DESIGN, 3, 165
     Require IDCOMP2QUAL, 3, 167
     Require IDCOMP2AGE, 3, 169
     Require IDCOMP2COND, 3, 171
     Require IDCOMP2GBA, 3, 173
     Require IDUNIT1TOTALCOMP2, 3, 176 
     Require IDUNIT1BEDCOMP2, 3, 177
     Require IDUNIT1BATHCOMP2, 3, 178
     Require IDUNIT2TOTALCOMP2, 3, 180 
     Require IDUNIT2BEDCOMP2, 3, 181
     Require IDUNIT2BATHCOMP2, 3, 182

     If isChecked(1, 20) or isChecked(1, 21) then
       Require IDUNIT3TOTALCOMP2, 3, 184
       Require IDUNIT3BEDCOMP2, 3, 185
       Require IDUNIT3BATHCOMP2, 3, 186
     End If

     If isChecked(1, 21) then
       Require IDUNIT4TOTALCOMP2, 3, 188
       Require IDUNIT4BEDCOMP2, 3, 189
       Require IDUNIT4BATHCOMP2, 3, 190
     End If

     Require IDBASEDESCRENTCOMP2, 3, 192
     If not ((GetText(3, 192) = "0sf") or (GetText(3, 192) = "0sqm")) Then
       Require IDBASEFINRENTCOMP2, 3, 194
     End If
     Require IDCOMP2FUNC, 3, 196
     Require IDCOMP2HEAT, 3, 198
     Require IDCOMP2ENERGY, 3, 200
     Require IDPARKRENTCOMP2, 3, 202
     Require IDCOMP2PORCH, 3, 204


     Require IDCOMP3ADD, 3, 219
     Require IDCOMP3PROX, 3, 221
     Require IDCOMP3SALES, 3, 222
     Require IDCOMP3PRICEGBA, 3, 223
     Require IDCOMP3GMR, 3, 224
     Require IDCOMP3GRM, 3, 2254
     Require IDCOMP3PRICEUNIT, 3, 226
     Require IDCOMP3PRICEROOM, 3, 227
     Require IDCOMP3PRICEBED, 3, 228
     OnlyOneCheckOfTwo 3, 229, 230, IDRENTCONTROLCOMP3, "RENTAL 3 RENT CONTROLLED: Both Yes and No are checked"
     Require IDCOMP3SOURCE, 3, 231
     Require IDCOMP3VER, 3, 232
     Require IDCOMP3SF, 3, 233
     Require IDCOMP3CONC, 3, 235
     Require IDCOMP3DOS, 3, 237
     Require IDCOMP3LOC, 3, 239
     Require IDCOMP3LEASEHOLD, 3, 241
     Require IDCOMP3SITE, 3, 243
     Require IDCOMP3VIEW, 3, 245
     Require IDCOMP3DESIGN, 3, 247
     Require IDCOMP3QUAL, 3, 249
     Require IDCOMP3AGE, 3, 251
     Require IDCOMP3COND, 3, 253
     Require IDCOMP3GBA, 3, 255
     Require IDUNIT1TOTALCOMP3, 3, 258 
     Require IDUNIT1BEDCOMP3, 3, 259
     Require IDUNIT1BATHCOMP3, 3, 260
     Require IDUNIT2TOTALCOMP3, 3, 262 
     Require IDUNIT2BEDCOMP3, 3, 263
     Require IDUNIT2BATHCOMP3, 3, 264

     If isChecked(1, 20) or isChecked(1, 21) then
       Require IDUNIT3TOTALCOMP3, 3, 266
       Require IDUNIT3BEDCOMP3, 3, 267
       Require IDUNIT3BATHCOMP3, 3, 268
     End If

     If isChecked(1, 21) then
       Require IDUNIT4TOTALCOMP3, 3, 270
       Require IDUNIT4BEDCOMP3, 3, 271
       Require IDUNIT4BATHCOMP3, 3, 272
     End If

     Require IDBASEDESCRENTCOMP3, 3, 274
     If not ((GetText(3, 274) = "0sf") or (GetText(3, 274) = "0sqm")) Then
       Require IDBASEFINRENTCOMP3, 3, 276
     End If
     Require IDCOMP3FUNC, 3, 278
     Require IDCOMP3HEAT, 3, 280
     Require IDCOMP3ENERGY, 3, 282
     Require IDPARKRENTCOMP3, 3, 284
     Require IDCOMP3PORCH, 3, 286


     Require IDADJUNITCOMP1, 3, 134
     Require IDADJROOMCOMP1, 3, 135
     Require IDADJBEDCOMP1, 3, 136
     Require IDADJUNITCOMP2, 3, 216
     Require IDADJROOMCOMP2, 3, 217
     Require IDADJBEDCOMP2, 3, 218
     Require IDADJUNITCOMP3, 3, 298
     Require IDADJROOMCOMP3, 3, 299
     Require IDADJBEDCOMP3, 3, 300

     Require IDVALUNIT, 3, 301
     Require IDUNITRENT, 3, 302
     Require IDVALUNITTOTAL, 3, 303
     Require IDVALROOM, 3, 304
     Require IDROOMRENT, 3, 205
     Require IDVALROOMTOTAL, 3, 306
     Require IDVALGBA, 3, 307
     Require IDGBARENT, 3, 308
     Require IDVALGBATOTAL, 3, 309
     Require IDVALBED, 3, 310
     Require IDBEDRENT, 3, 311
     Require IDVALBEDTOTAL, 3, 312

     Require IDSUMMARYSALES, 3, 313
     Require IDINCOMERENT2, 3, 314
     Require IDINCOMEGRM2, 3, 315
     Require IDINCOMEVALUE2, 3, 316
     Require IDSUMMARYINCOME, 3, 317
     Require IDSUMMARYVALUECONC, 3, 318

     OnlyOneCheckOfTwo 3, 319, 320, IDREVIEWOPINION, "BASIS OF REVIEW: Both Exterior and Complete Inspecton are checked"
     Require IDREVIEWAMT, 3, 321
     Require IDREVIEWASOF, 3, 322
   End If

End Sub