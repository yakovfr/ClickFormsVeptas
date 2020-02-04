'FM0344_EDA.vbs 1004D Additional script for EDA Portal

Sub ReviewForm
   AddTitle ""
   ValidateCaseNo
End Sub

Sub ValidateCaseNo	'Format XXX-XXXXXXX with x is digit
   errMsg = "**EAD PORTAL: FHA Case Number is missing or provided in an invalid format" 
   result = False
   if hasText(1,4) then
      caseNo = getText(1,4)
      if len(trim(caseNo)) = 11 then
	if isNumeric(left(caseNo,3)) then
	 if inStr(caseNo,"-") = 4 then
	   if isNumeric(right(caseNo,7)) then
	    result = True
           End If
         End If
        End If   
      End If
   End IF
   If result = False then
      AddRec errMsg, 1, 4
   End IF
End Sub
