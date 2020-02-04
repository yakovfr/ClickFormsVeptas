'FM00766.vbs Non-Lender Cert Reviewer Script
' 04/17/2013: Update if effective date is AFTER the sigature date give hard stop.
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning
' Call: IsEffectiveDatePastSignatureDate2wks to check if effective date + 14 < signature date gives warning

Sub ReviewForm
  ReviewCertification
  AddTitle ""
End Sub

Sub ReviewCertification

AddTitle String(5, "=") + "Non-Lender " + IDAPPCERT + String(5, "=")

Require IDFILENUM, 1, 2
Require IDFILENUM, 2, 2
Require IDFILENUM, 3, 2

Require IDCERTNAMEAPPR, 3, 6
Require IDCERTCOMPANYAPPR, 3, 7
Require IDCERTCOMPANYADDAPPR, 3, 8
Require IDCERTPHONEAPPR, 3, 10
Require IDCERTEMAILAPPR, 3, 11
Require IDCERTDATEAPPR, 3, 12
'Show warning if signaturedate not = today's date 
 IsSignatureDateNOTToday 3,12

Require IDCERTDATEEFFAPPR, 3, 13
 ' Show warning if effective date i= signature date + 14
  IsEffectiveDatePastSignatureDate2wks 3, 12, 3, 13 
 ' Show hard stop if effective date is AFTER signature date
  IsEffectiveDateAFTERSignatureDate 3,12, 3,13

Require IDCERTSTATECERTAPPR, 3, 14

If not hasText(3,13) Then
 Require IDCERTSTATELICAPPR, 3, 15
 Require IDCERTOTHERAPPR, 3, 16
 Require IDCERTSTATENUMAPPR, 3, 17
End If

Require IDCERTSTATEAPPR, 3, 18
Require IDCERTEXPRIREAPPR, 3, 19 
 ' Show warning if Expiration date already today's date  
  IsExpirationDatePastToday 3, 19

'Show warning if expiration date is BEFORE effective date
   IsExpirationDateBeforeEffectiveDate 3, 19, 3, 13

Require IDCERTPROPADD, 3, 20
Require IDCERTAPPRVALUE, 3, 22
Require IDCERTLENDERNAME, 3, 23 
Require IDCERTLENDERCOMPNAME, 3, 24
Require IDCERTLENDERCOMPADD, 3, 25
Require IDCERTLENDEREMAILADD, 3, 27

If hasText(3, 28) Then
Require IDCERTNAMESUP, 3, 28
Require IDCERTCOMPANYSUP, 3, 29 
Require IDCERTCOMPANYADDSUP, 3, 30
Require IDCERTTELEPHONESUP, 3, 32
Require IDCERTEMAILSUP, 3, 33
Require IDCERTDATESIGSUP, 3, 34
 'Show warning if signaturedate not = today's date 
 IsSignatureDateNOTToday 3,34

Require IDCERTSTATECERTSUP, 3, 35
Require IDCERTSTATELICSUP, 3, 36
Require IDCERTSTATESUP, 3, 37
Require IDCERTEXPIRESUP, 3, 38
 ' Show warning if Expiration date already today's date  
  IsExpirationDatePastToday 3, 38

OnlyOneCheckOfThree 3, 39, 40, 42, IDCERTSUBINSPECT, XXXXXX

  If isChecked(3, 40) Then
    Require IDCERTINSPECTINTDATE, 3, 41
  End If

  If isChecked(3, 42) Then
    Require IDCERTINSPECTEXTDATE, 3, 43
  End If

OnlyOneCheckOfTwo 3, 44, 45, IDCERTCOMPINSPECT, XXXXXX

  If isChecked(3, 45) Then
    Require IDCERTDATEOFINSPECTCOMP, 3, 46
  End If

End If

End Sub
