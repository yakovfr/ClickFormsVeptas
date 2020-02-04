'FM03531.vbs URAR Reviewer Script
'01/17/2013: Put the report name in the header and remove report name from each section header

Sub ReviewForm
    ReviewHeader
    AddTitle ""
    ReviewCertification
    AddTitle ""
    ReviewSource
    AddTitle ""
    ReviewProperty
    AddTitle ""
    ReviewSignature
 End Sub
  



Sub ReviewHeader
  AddTitle String(5, "=") + " CVR CERTIFICATION " + String(5, "=")
  ValidateSubjectHeader 1, 2
End Sub

Sub ReviewCertification
  AddTitle String(10, "*") + " Section: APPRAISER'S CERTIFICATION " + String(10, "*")
  OnlyOneCheckOfTwo 1, 10, 11, IDPerformNoCheck, IDPerformManyCheck
  if isChecked(1,11) then
     Require IDServiceDescr, 1, 12
  end if
  Require IDOtherCert, 1, 13
End Sub

Sub ReviewSource
   AddTitle String(10, "*") + " Section: SOURCE OF DATA " + String(10, "*")
   ' ==== At least one of the check box is checked 
   OnlyOneCheckOfTen 1, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, IDSourceOfDataNoCheck, IDSourceOfDataManyCheck
   if isChecked(1,23) then
   Require IDSourceOfDataDescr, 1, 24
  end if
End Sub

Sub ReviewProperty
  AddTitle String(10, "*") + " Section: SUBJECT PROPERTY " + String(10, "*")
   Require IDAddress, 1, 25
   Require IDCity, 1, 26
   Require IDState, 1, 27
   Require IDZip, 1, 28
   Require IDEstimateValue, 1, 29
   Require IDEffectiveDate, 1, 30
End Sub

Sub ReviewSignature
  AddTitle String(10, "*") + " Section: APPRAISER SIGNATURE " + String(10, "*")
  Require IDSignatureDate, 1, 31
  Require IDCertNameAppr, 1, 32
  Require IDCompanyName, 1, 33
  Require IDAddress, 1, 34
  Require IDCityStateZip, 1, 35
  Require IDLicenseNumAppr, 1, 36
  Require IDCertNumAppr, 1, 37
  Require IDOtherNumAppr, 1, 38
  Require IDCertExtDate, 1, 39
  Require IDCertState, 1, 40

 ' Check to see either on of 3 check boxes is checked 
 OnlyOneCheckOfThree 1, 41, 42, 43, IDInspectionApprNoCheck,IDInspectionApprTooMany
 ' When exterior or interior inspection is checked, inspection date is required 
 if IsChecked(1,42) or IsChecked(1,43) then
    if not hasText(1,44) then
       AddRec IDInspectionDateAppr, 1,44
    end if
  end if

End Sub



 