' PCV rules:
'PCVAC-8: Appraiser Name is "N/A". Provide Appraiser Name.
'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name.
'PCVAC-14: Appraised Value is "N/A".  Provide Appraised Value
'PCVAC-15: Appraised Value is blank.  Provide Appraised Value
'PCVAC-16: Appraiser's Company Name is "N/A".  Provide Company Name
'PCVAC-17: Appraiser's Company Name is Blank.  Provide Company Name
'PCVAC-18: Company Address is "N/A".  Provide Company Address
'PCVAC-19: Company Address is Blank.  Provide Company Address
'PCVAC-20: Date of Signature and Report is "N/A".  Provide Date of Signature and Report
'PCVAC-21: Date of Signature and Report is Blank.  Provide Date of Signature and Report
'PCVAC-22: Effective Date of Appsl is "N/A".  Provide Effective Date of Appraisal.
'PCVAC-23: Effective Date of Appsl is Blank.  Provide Effective Date of Appraisal.
'PCVAC-24: Email address is "N/A".  Provide Email address.
'PCVAC-25: Email address is Blank.  Provide Email address.
'PCVAC-26: Telephone Number is "N/A".  Provide Telephone Number.
'PCVAC-27: Telephone Number is Blank.  Provide Telephone Number.
'PCVAC-28: State of License/Certification is "N/A".  Provide State of License/Certification in USPS Abbreviated format.
'PCVAC-29: State of License/Certification is Blank.  Provide State of License/Certification in USPS Abbreviated format.
'FM00350_PCV.vbs URAR Reviewer Script
' 05/29/2014: Bring up-to-date.
'
' 04/17/2013: Update: if effective date is AFTER signature date give hard stop.
' 04/01/2013: Add more rules
' Show warning if contract date is BEFORE effective date
'01/29/2013: 
' Call:IsSignatureDateNOTToday to check signature date <> today's date gives warning
' Call: IsExpirationDatePastToday to check if expiration date <= today's date gives warning
' Call: IsEffectiveDatePastSignatureDate2wks to check if effective date + 14 < signature date gives warning

Sub ReviewForm
  ReviewCertification
  AddTitle ""
End Sub

Sub ReviewCertification
Dim NumLicenses

  AddTitle String(5, "=") + "FNMA 1025  " + IDAPPCERT + String(5, "=")

  Require IDFILENUM, 1, 2
  Require IDFILENUM, 2, 2
  Require IDFILENUM, 3, 2
  Require IDCERTNAMEAPPR, 3, 5
  Require IDCERTCOMPANYAPPR, 3, 6
  Require IDCERTCOMPANYADDAPPR, 3, 7
  Require IDCERTPHONEAPPR, 3, 9
  Require IDCERTEMAILAPPR, 3, 10
  'Require IDCERTDATEAPPR, 3, 11
  'Show hard stop if no signature date
  IsSignatureDateEMPTY 3,11
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
	'PCV #1: effective date should not be later than expiration date
	RECAPPCERTLICEXPDAT = "**EFFECTIVE DATE IS AFTER EXPIRATION DATE.  PLEASE MODIFY."
	lDate = GetText(3,18)
	eDate = GetText(3,12)
	If DateDiff("d", eDate,lDate)  <  0 Then
		AddRec "**" & RECAPPCERTLICEXPDAT, 3,18
	End If


  Require "**" & IDCERTPROPADD, 3, 19
  'Require "**" & IDCERTAPPRVALUE, 3, 21
  ' --- Lender/Client section
  Require "**" & IDCERTLENDERNAME, 3, 22
  If hasText(3,22) Then
    Require "**" & IDCERTLENDERCOMPNAME, 3, 23
    Require "**" & IDCERTLENDERCOMPADD, 3, 24
    'Require "**" & IDCERTLENDEREMAILADD, 3, 26
    Require IDCERTLENDEREMAILADD, 3, 26
 End If
'Is the license expiration date of the appraiser earlier than the date of the report?

  ' ///////  START OF Supervisor Section: ONLY check if supervisor name not BLANK
  If hasText(3, 27) Then
    Require "**" & IDCERTNAMESUP, 3, 27
    Require "**" & IDCERTCOMPANYSUP, 3, 28
    Require "**" & IDCERTCOMPANYADDSUP, 3, 29
    Require IDCERTTELEPHONESUP, 3, 31
    'Require "**" & IDCERTEMAILSUP, 3, 32
    Require IDCERTEMAILSUP, 3, 32
    'PCV Rules #22: Lender/Client must be "PCV MURCOR"
    PCVMurcor = trim(UCase(GetText(3, 22)))
    if PCVMurcor <> "PCV MURCOR" then
      AddRec "Lender/Client name is not 'PCV MURCOR'.  Correct Lender/Client Name.", 3, 22
    end if
	Require "**" & IDCERTDATESIGSUP, 3, 33
    'Show warning if signaturedate not = today's date 
    IsSignatureDateNOTToday 3, 33

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

    ' Show warning if Expiration date already today's date  
    IsExpirationDatePastToday 3, 37
    OnlyOneCheckOfThree 3, 38, 39, 41, IDCERTSUBINSPECT, "SUP APPRAISER INSPECT SUBJECT: Too many checks"
    If isChecked(3, 39) Then
      Require IDCERTINSPECTINTDATE, 3, 40
    End If
    If isChecked(3, 41) Then
      Require IDCERTINSPECTEXTDATE, 3, 42
    End If
    OnlyOneCheckOfTwo 3, 43, 44, IDCERTCOMPINSPECT, "SUP APPRAISER INSPECT COMPS: Both Yes and No are chekced"
    If isChecked(3, 44) Then
      Require IDCERTDATEOFINSPECTCOMP, 3, 45
    End If
  End If
  
 '########################### START PCV RULES  ############################################ 
 'PCVAC-8: Appraiser Name is "N/A". Provide Appraiser Name.
 PCVAC8Msg = "** Appraiser Name is 'N/A'. Provide Appraiser Name."
 apprName = GetText(3, 5)
 if uCase(apprName) = "N/A" then
   AddRec PCVAC8Msg, 3, 5
 end if

 'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name.
 PCVAC9Msg = "** 'PCVAC-9: Appraiser Name is blank. Provide Appraiser Name."
 if GetText(3, 5) = "" then
   AddRec PCVAC9Msg, 3, 5
 end if
 
  
  'PCVAC-14: Appraised Value is "N/A".  Provide Appraised Value
  PCVAC14Msg = "** Appraised Value is 'N/A'.  Provide Appraised Value"
  ApprValue = GetText(3, 21)
  ApprValue = Trim(UCase(ApprValue))
  if ApprValue = "N/A" then
    AddRec PCVAC14Msg, 3, 21
  end if
  
  'PCVAC-15: Appraised Value is blank.  Provide Appraised Value
  PCVAC15Msg = "** Appraised Value is blank.  Provide Appraised Value"
  if GetText(3, 21) = "" then
    AddRec PCVAC15Msg, 3, 21
  end if 

'PCVAC-16: Appraiser's Company Name is "N/A".  Provide Company Name
PCVAC16Msg = "** Appraiser's Company Name is 'N/A'.  Provide Company Name." 
  CoName = GetText(3, 6)
  ApprValue = Trim(UCase(CoName))
  if CoName = "N/A" then
    AddRec PCVAC16Msg, 3, 6
  end if

'PCVAC-17: Appraiser's Company Name is Blank.  Provide Company Name
PCVAC17Msg = "** Appraiser's Company Name is Blank.  Provide Company Name." 
if GetText(3, 6) = "" then
  AddRec PCVAC17Msg, 3, 6
end if

'PCVAC-18: Company Address is "N/A".  Provide Company Address
PCVAC18Msg = "** Appraiser's Company Address is 'N/A'.  Provide Company Name." 
  CoAddr = GetText(3, 7)
  ApprValue = Trim(UCase(CoAddr))
  if CoAddr = "N/A" then
    AddRec PCVAC16Msg, 3, 7
  end if

'PCVAC-19: Company Address is Blank.  Provide Company Address
PCVAC19Msg = "** Appraiser's Company Address is Blank.  Provide Company Name." 
if GetText(3, 6) = "" then
  AddRec PCVAC19Msg, 3, 6
end if

'PCVAC-20: Date of Signature and Report is "N/A".  Provide Date of Signature and Report
PCVAC20Msg = "** Date of Signature and Report is 'N/A'.  Provide Date of Signature and Report."
SigDate = GetText(3, 11)
SigDate = trim(UCase(SigDate))
if SigDate = "N/A" then
  AddRec PCVAC20Msg, 3, 11
end if

'PCVAC-21: Date of Signature and Report is Blank.  Provide Date of Signature and Report
PCVAC21Msg = "** Date of Signature and Report is Blank.  Provide Date of Signature and Report."
if GetText(3, 11) = "" then
	AddRec PCVAC21Msg, 3, 11
end if

'PCVAC-22: Effective Date of Appsl is "N/A".  Provide Effective Date of Appraisal.
PCVAC22Msg = "** Effective Date of Appraisal is 'N/A'.  Provide Effective Date of Appraisal."
EffDate = GetText(3, 12)
EffDate = trim(UCase(EffDate))
if EffDate = "N/A" then
  AddRec PCVAC22Msg, 3, 12
end if

'PCVAC-23: Effective Date of Appsl is blank.  Provide Effective Date of Appraisal.
PCVAC23Msg = "** Effective Date of Appraisal is Blank.  Provide Effective Date of Appraisal."
if GetText(3, 12) = "" then
  AddRec PCVAC23Msg, 3, 12
end if

'PCVAC-24: Email address is "N/A".  Provide Email address.
 PCVAC24Msg = "** Email address is 'N/A'.  Provide Email address." 
 emailAddr = GetText(3, 10)
  emailAddr = Trim(UCase(emailAddr))
  if emailAddr = "N/A" then
    AddRec PCVAC24Msg, 3, 10
  end if

'PCVAC-25: Email address is Blank.  Provide Email address.
 PCVAC24Msg = "** Email address is Blank.  Provide Email address." 
 if GetText(3, 10) = "" then
   AddRec PCVAC24Msg, 3, 10
 end if

 'PCVAC-26: Telephone Number is "N/A".  Provide Telephone Number.
 PCVAC26Msg = "** Telephone Number is 'N/A'.  Provide Telephone Number." 
 phone = GetText(3, 9)
  phone = Trim(UCase(phone))
  if phone = "N/A" then
    AddRec PCVAC26Msg, 3, 9
  end if

 'PCVAC-27: Telephone Number is Blank.  Provide Telephone Number.
 PCVAC27Msg = "** Telephone Number is Blank.  Provide Telephone Number." 
 if GetText(3, 9) = "" then
   AddRec PCVAC27Msg, 3, 9
 end if
 
 'PCVAC-28: State of License/Certification is "N/A".  Provide State of License/Certification in USPS Abbreviated format.
 PCVAC28Msg = "** State of License/Certification is 'N/A'.  Provide State of License/Certification in USPS Abbreviated format." 
 State = GetText(3, 17)
  State = Trim(UCase(State))
  if State = "N/A" then
    AddRec PCVAC28Msg, 3, 17
  end if

 'PCVAC-29: State of License/Certification is Blank.  Provide State of License/Certification in USPS Abbreviated format.
 PCVAC29Msg = "** State of License/Certification is Blank.  Provide State of License/Certification in USPS Abbreviated format." 
 if GetText(3, 17) = "" then
   AddRec PCVAC29Msg, 3, 17
 end if
 





  
  
  

  
  
  

 '########################### END PCV RULES  ############################################  

  
  
End Sub