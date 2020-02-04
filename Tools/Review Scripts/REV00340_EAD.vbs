'FM0340_EDA.vbs 1004 URAR Additional script for EDA Portal

Sub ReviewForm
   AddTitle ""
   ValidateCaseNo
   CheckLandUse
   CheckSubjectSitearea
   CheckSubjectEffAge
End Sub

Sub ValidateCaseNo	'Format XXX-XXXXXXX with x is digit
   errMsg = "**EAD PORTAL: FHA Case Number is missing or provided in an invalid format" 
   result = False
   if hasText(1,5) then
      caseNo = getText(1,5)
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
      AddRec errMsg, 1, 5
   End IF
End Sub

Sub CheckLandUse
   errMsg = "**EAD PORTAL: Sum of all land uses must be at least 1% but not greater than 100%"
   result = False
   oneUnit = getValue(1,76)
   TwoFourUnit = getValue(1,77)
   MultiFamily = getValue(1,78)
   Commercial = getValue(1,79)
   Other = getValue(1,81)
   sumUse = oneUnit + TwoFourUnit + MultiFamily + Commercial + Other
   if sumUse < 1 or sumUse > 100 then
      AddRec errMsg, 1, 76
   end If
end Sub		

Sub CheckSubjectSitearea
   errMsg = "**EAD PORTAL: Site Area must be greater than 0"
   area = getValue(1,86)
   if area <= 0 then
      AddRec errMsg, 1, 86
   end if
end Sub

Sub CheckSubjectEffAge
   errMsg = "**EAD Portal: Effective Age must be provided as a whole number or a range of tho whole number; if new , enter 0"
   result = False
   cellText = Trim(getText(1, 139))
   if Len(cellText) > 0 then
      defisPos = InStr(CellText, "-")
      if defisPos > 0 then 'range of numbers
         str1 = Trim(Left(cellText, defisPos - 1))
	 str2 = Trim(Right(cellText, len(cellText) - defisPos))
	 if isNumeric(str1) = True then
	    if CInt(str1) = CDbl(str1) then
	       if isNumeric(str2) then
	          if CInt(str2) = CDbl(str2) then
         	     result = true
                  end IF
	       end if
	    end if
	end if
      else
	 if isNumeric(cellText) = True then
            if CInt(cellText) = CDbl(cellText) then
	       result = True
            end if
         end if
      end if	
   end if
   if not result then
      AddRec errMsg, 1, 139
   end if
end sub

