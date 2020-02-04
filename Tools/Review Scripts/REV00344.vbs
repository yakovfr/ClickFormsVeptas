'REV000344.vbs 1004d Reviewer Script
' 04/17/2013: add rule: if effective date is AFTER signature date give hard stop.
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning
' Call: IsEffectiveDatePastSignatureDate2wks to check if effective date + 14 < signature date gives warning


Sub ReviewForm
   ReviewSubject
   AddTitle ""
   ReviewCertification
   AddTitle ""
End Sub

Sub ReviewSubject
   AddTitle String(5, "=") + "FNMA 1004D " + IDSUBJECT + String(5, "=")
   Require IDFILENUM, 1, 2
   Require IDAddress, 1, 5
   Require IDUNITS, 1, 6
   Require IDCity, 1, 7
   Require IDState, 1, 8
   Require IDZip, 1, 9
   Require IDLegal, 1, 10
   Require IDCounty, 1, 11
   Require IDBorrower, 1, 12
   Require ID_EXPLAIN_CONTRACT_PRICE_REQUIRED, 1, 13
   Require ID_EXPLAIN_DATE_PRICE_REQUIRED, 1, 14
   Require IDEFFDATE2000, 1, 15
   OnlyOneCheckOfThree 1, 16, 17, 18, IDPRA, "PROPERTY RIGHTS APPRAISED: More than Once Checked"
   If isChecked(1, 18) Then
     Require IDPRAOTHER, 1, 19
   End If
   Require IDORGAPPRVALUE, 1, 20
   Require IDORGAPPR, 1, 21
   Require IDCOMPNAMED, 1, 22
   Require IDORGLENDER, 1, 23
   Require IDADDRESSD, 1, 24
   OnlyOneCheckOfTwo 1, 25, 29, IDSUMAPPRCERTCOMP, "TYPE OF UPDATE: Both Update Appraisal and Completion Checked"
   If isChecked(1, 25) Then
     OnlyOneCheckOfTwo 1, 26, 27, IDDECLINE, "DECLINING VALUE: Both Yes and No are Checked"
   End If
   If isChecked(1, 29) Then
     OnlyOneCheckOfTwo 1, 30, 31, IDIMPROVECOMPLETE, "COMPLETION: Both Yes and No are Checked"
   End If
   If isChecked(1, 31) Then
     Require IDIMPROVECOMPLETENO, 1, 32
   End If
End Sub

Sub ReviewCertification
   AddTitle String(5, "=") + "FNMA 1004D " + IDAPPCERT + String(5, "=")
   Require IDCERTNAMEAPPR, 1, 33
   Require IDCERTCOMPANYAPPR, 1, 34
   Require IDCERTCOMPANYADDAPPR, 1, 35
   Require IDCERTPHONEAPPR, 1, 37
   Require IDDATESIGREPORT, 1, 38
   'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 1, 38
   Require IDCERTDATEAPPR, 1, 39
   ' Show warning if effective date i= signature date + 14
   IsEffectiveDatePastSignatureDate2wks 1, 38, 1, 39 
  ' Show hard stop if effective date is AFTER signature date
   IsEffectiveDateAFTERSignatureDate 1,38, 1,39
  

 Require IDCERTDATEEFFAPPR, 1, 40
   Require IDCERTSTATECERTAPPR, 1, 41
   If not hasText(1, 41) Then
     Require IDCERTSTATELICAPPR, 1, 42
     Require IDCERTOTHERAPPR, 1, 43
     Require IDCERTSTATENUMAPPR, 1, 44
   End If
   Require IDCERTSTATEAPPR, 1, 45
   Require IDCERTEXPRIREAPPR, 1, 46 
   ' Show warning if Expiration date already today's date  
   IsExpirationDatePastToday 1, 46

   Require IDCERTLENDERNAME, 1, 47 
   Require IDCERTLENDERCOMPNAME, 1, 48
   Require IDCERTLENDERCOMPADD, 1, 49
   If hasText(1, 51) Then
     Require IDCERTNAMESUP, 1, 51
     Require IDCERTCOMPANYSUP, 1, 52 
     Require IDCERTCOMPANYADDSUP, 1, 53
     Require IDCERTTELEPHONESUP, 1, 55
     Require IDCERTDATESIGSUP, 1, 56
     Require IDCERTSTATECERTSUP, 1, 57
     Require IDCERTSTATELICSUP, 1, 58
     Require IDCERTSTATESUP, 1, 59
     Require IDCERTEXPIRESUP, 1, 60
     OnlyOneCheckOfThree 1, 61, 62, 64, IDCERTSUBINSPECT, XXXXX
     OnlyOneCheckOfTwo 1, 61, 62, IDCERTSUBINSPECT, "SUP APPRAISER: Both Did Inspect and Did NOT are Checked"
     OnlyOneCheckOfTwo 1, 61, 64, IDCERTSUBINSPECT, "SUP APPRAISER: Both Did Inspect and Did NOT are Checked"


     If isChecked(1, 62) Then
       Require IDCERTINSPECTINTDATE, 1, 63
     End If
     If isChecked(1, 64) Then
       Require IDCERTINSPECTEXTDATE, 1, 65
     End If
   End If
End Sub