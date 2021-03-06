'FM00341.vbs URAR Reviewer Script
' 05/11/2014: Freddie Mac rules update 
'  FRE1087: Hard Stop: Appraiser Name check - Triggers if the appraiser name is missing from the appraisal.

' 04/17/2013: Update to have effective date is AFTER than the signature date give hard stop.
' 12/17/2014: disable rule 'RULE # FNM0092.
' 04/02/2013: Add new rules:
' If no date of signature, show hard stop.
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning
' Call: IsEffectiveDatePastSignatureDate2wks to check if effective date + 14 < signature date gives warning

Sub ReviewForm
  CheckMultiCheck
  ReviewCertification
  AddTitle ""
End Sub


Sub CheckMultiCheck

  OnlyOneCheckOfThree 3, 38,39,41,"","Supervisor Subject Inspection Too Many Checks"  
  OnlyOneCheckOfTwo 3, 43, 44, "", "Supervisor Comp Inspection Too Many Checks"

End Sub



Sub ReviewCertification
Dim NumLicenses

  AddTitle String(5, "=") + "FNMA 1004 " + IDAPPCERT + String(5, "=")

  Require IDFILENUM, 1, 2
  Require IDFILENUM, 2, 2
  Require IDFILENUM, 3, 2

 'FRE1087: Hard stop: Appraiser Name Check - Triggers if the appraiser name is missing from the appraisal.
  if isUAD then
    Require "** Appraiser's Name is missing from the appraisal.", 3, 5
  else
    Require IDCERTNAMEAPPR, 3, 5
  end if
  Require IDCERTCOMPANYAPPR, 3, 6
  Require IDCERTCOMPANYADDAPPR, 3, 7
  Require IDCERTPHONEAPPR, 3, 9
  Require IDCERTEMAILAPPR, 3, 10
  'Require IDCERTDATEAPPR, 3, 11
  'Show hard stop if no signature date
  IsSignatureDateEMPTY 3,11
 'Show warning if signaturedate not = today's date 
  IsSignatureDateNOTToday 3,11
  If GetCellUADError(3, 11) Then
    AddRec IDCERTDATEAPPRUADERROR, 3, 11
  End If
  Require IDCERTDATEEFFAPPR, 3, 12
 'Show warning if effective date i= signature date + 14
  IsEffectiveDatePastSignatureDate2wks 3, 11, 3, 12 
  'Show hard stop if effective date is AFTER signature date
  IsEffectiveDateAFTERSignatureDate 3, 11, 3, 12
  If GetCellUADError(3, 12) Then
    AddRec IDCERTDATEEFFAPPRUADERROR, 3, 12
  End If

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

  'RULE # FNM0092: State certification is not provided on transaction amount over $1 million.
  if isUAD then  'only for UAD
    stateCert = GetText(3, 13)
    transAmt = GetValue(3, 21)
    if transAmt > 1000000 then
      if stateCert = ""then
        AddRec FNTRANSAMOUNTOVER1MIL, 3, 13
      end if
    end if
  end if


  
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
  If GetCellUADError(3, 18) Then
    AddRec IDCERTEXPRIREAPPRUADERROR, 3, 18
  End If

 'Show warning if expiration date is BEFORE effective date
   IsExpirationDateBeforeEffectiveDate 3, 18, 3, 12

  Require IDCERTPROPADD, 3, 19
  If GetCellUADError(3, 19) OR GetCellUADError(3, 20) Then
    AddRec IDCERTPROPADDUADERROR, 3, 19
  End If
  Require IDCERTAPPRVALUE, 3, 21
  If IsUAD Then
    Require IDUADCERTAMCNAME, 3, 22
  Else
    Require IDCERTLENDERNAME, 3, 22
  End If
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
    If GetCellUADError(3, 33) Then
      AddRec IDCERTDATESIGSUPUADERROR, 3, 33
    End If

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
    If GetCellUADError(3, 37) Then
      AddRec IDCERTEXPIRESUPUADERROR, 3, 37
    End If

    OnlyOneCheckOfThree 3, 38, 39, 41, IDCERTSUBINSPECT, XXXXXX

    If isChecked(3, 39) Then
      Require IDCERTINSPECTINTDATE, 3, 40
    End If
    If GetCellUADError(3, 40) Then
      AddRec IDCERTINSPECTINTDATEUADERROR, 3, 40
    End If


    If isChecked(3, 41) Then
      Require IDCERTINSPECTEXTDATE, 3, 42
    End If
    If GetCellUADError(3, 42) Then
      AddRec IDCERTINSPECTEXTDATEUADERROR, 3, 42
    End If

    OnlyOneCheckOfTwo 3, 43, 44, IDCERTCOMPINSPECT, XXXXXX

    If isChecked(3, 44) Then
      Require IDCERTDATEOFINSPECTCOMP, 3, 45
    End If
    If GetCellUADError(3, 45) Then
      AddRec IDCERTDATEOFINSPECTCOMPUADERROR, 3, 45
    End If

  End If

End Sub
