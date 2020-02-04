' 04/22/2013 - Add more rule:
' If effective date is AFTER signature date show hard stop.
'FM00343.vbs 1004c Reviewer Script

Sub ReviewForm
  ReviewCertification
  AddTitle ""
End Sub

Sub ReviewCertification
Dim NumLicenses

  AddTitle String(5, "=") + "FNMA 1004C " + IDAPPCERT + String(5, "=")

  Require IDFILENUM, 1, 2
  Require IDFILENUM, 2, 2
  Require IDFILENUM, 3, 2
  Require IDCERTNAMEAPPR, 3, 5
  Require IDCERTCOMPANYAPPR, 3, 6
  Require IDCERTCOMPANYADDAPPR, 3, 7
  Require IDCERTPHONEAPPR, 3, 9
  Require IDCERTEMAILAPPR, 3, 10
  Require IDCERTDATEAPPR, 3, 11
  'Show warning if signaturedate not = today's date 
  IsSignatureDateNOTToday 3,11
  Require IDCERTDATEEFFAPPR, 3, 12
  ' Show warning if effective date i= signature date + 14
  IsEffectiveDatePastSignatureDate2wks 3, 11, 3, 12 
  ' Show hard stop if effective date is AFTER signature date
  IsEffectiveDateAFTERSignatureDate 3,11, 3,12


  NumLicenses = 0
  If hasText(3,13) Then
    NumLicenses = 1
  End If
  If hasText(3,14) Then
    NumLicenses = NumLicenses + 2
  End If
  If hasText(3,15) Then
    NumLicenses = NumLicenses + 4
  End If
  If hasText(3,16) Then
    NumLicenses = NumLicenses + 8
  End If
  Select Case NumLicenses
    Case 0
      AddRec IDCERTNOLICAPPR, 3, 13
    Case 4
      AddRec IDCERTSTATENUMAPPR, 3, 16
    Case 8
      AddRec IDCERTOTHERAPPR, 3, 15
    Case 3, 5, 6, 7, 9, 10, 11, 13, 14, 15
      AddRec IDCERTANDLICAPPR, 3, 13
  End Select

  Select Case NumLicenses
    Case 1, 2, 4, 8, 12
      if not hasText(3,17) Then
        AddRec IDCERTSTATEAPPR, 3, 17
      end If
      if not hasText(3,18) Then
        AddRec IDCERTEXPRIREAPPR, 3, 18
      end If
  End Select

  ' Show warning if Expiration date already today's date  
  IsExpirationDatePastToday 3, 18

  'Show warning if expiration date is BEFORE effective date
   IsExpirationDateBeforeEffectiveDate 3, 18, 3, 12

  Require IDCERTPROPADD, 3, 19
  Require IDCERTAPPRVALUE, 3, 21
  Require IDCERTLENDERNAME, 3, 22 
  Require IDCERTLENDERCOMPNAME, 3, 23
  Require IDCERTLENDERCOMPADD, 3, 24
  Require IDCERTLENDEREMAILADD, 3, 26
  If hasText(3, 27) Then
    Require IDCERTNAMESUP, 3, 27
    Require IDCERTCOMPANYSUP, 3, 28 
    Require IDCERTCOMPANYADDSUP, 3, 29
    Require IDCERTTELEPHONESUP, 3, 31
    Require IDCERTEMAILSUP, 3, 32
    Require IDCERTDATESIGSUP, 3, 33

    NumLicenses = 0
    If hasText(3,34) Then
      NumLicenses = 1
    End If
    If hasText(3,35) Then
      NumLicenses = NumLicenses + 2
    End If

    Select Case NumLicenses
      Case 0
        AddRec IDCERTNOLICSUP, 3, 34
      Case 1, 2
        if not hasText(3,36) Then
          AddRec IDCERTSTATESUP, 3, 36
        end If
        if not hasText(3,37) Then
          AddRec IDCERTEXPIRESUP, 3, 37
        end If
      Case else
        AddRec IDCERTANDLICSUP, 3, 34
    End Select

    OnlyOneCheckOfThree 3, 38, 39, 41, IDCERTSUBINSPECT, XXXXXX
    If isChecked(3, 39) Then
      Require IDCERTINSPECTINTDATE, 3, 40
    End If
    If isChecked(3, 41) Then
      Require IDCERTINSPECTEXTDATE, 3, 42
    End If
    OnlyOneCheckOfTwo 3, 43, 44, IDCERTCOMPINSPECT, XXXXXX
    If isChecked(3, 44) Then
      Require IDCERTDATEOFINSPECTCOMP, 3, 45
    End If
  End If
End Sub
