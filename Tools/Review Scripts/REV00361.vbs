'FM00361.vbs 2000A Reviewer Script
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning


Sub ReviewForm
  ReviewCertification
  AddTitle ""
End Sub

Sub ReviewCertification
Dim NumLicenses

  AddTitle String(5, "=") + "FNMA 2000A" + IDAPPCERT + String(5, "=")

  Require IDFILENUM, 1, 2
  Require IDFILENUM, 2, 2
  Require IDCERTNAMEAPPR, 2, 5
  Require IDCERTCOMPANYAPPR, 2, 6
  Require IDCERTCOMPANYADDAPPR, 2, 7
  Require IDCERTPHONEAPPR, 2, 9
  Require IDCERTEMAILAPPR, 2, 10
  Require IDCERTDATEAPPR, 2, 11
  'Show warning if signaturedate not = today's date 
   IsSignatureDateNOTToday 2,11


  NumLicenses = 0
  If hasText(2,12) Then
    NumLicenses = 1
  End If
  If hasText(2,13) Then
    NumLicenses = NumLicenses + 2
  End If

  Select Case NumLicenses
    Case 0
      AddRec IDCERTNOLICAPPR2, 2, 12
    Case 3
      AddRec IDCERTANDLICAPPR2, 2, 12
  End Select

  Select Case NumLicenses
    Case 1, 2
      if not hasText(2,14) Then
        AddRec IDCERTSTATEAPPR, 2, 14
      end If
      if not hasText(2,15) Then
        AddRec IDCERTEXPRIREAPPR, 2, 15
      end If
  End Select

  ' Show warning if Expiration date already today's date  
   IsExpirationDatePastToday 2, 15


  Require IDCERTLENDERNAME, 2, 16
  Require IDCERTLENDERCOMPNAME, 2, 17
  Require IDCERTLENDERCOMPADD, 2, 18
  Require IDCERTLENDREVIEW, 2, 20
  Require IDCERTADDREVIEW, 2, 21
  Require IDREVIEWMARKET, 2, 23
  Require IDREVIEWMARKETDATE, 2, 24
End Sub
