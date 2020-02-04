'FM0343_EDA.vbs 1004C Certificate Additional script for EDA Portal
Sub ReviewForm
   AddTitle ""			
   CheckAppraisedValue
End Sub

Sub CheckAppraisedValue
   errMsg = "**EAD PORTAL: Appraised Value is missed or less than $5,000"
   result = False
   if hasText(3 ,21) then
	value = getValue(3,21)
      if value >= 5000 then
	  result = True
       end If
   end If
   if result = False then	
   	AddRec errMsg, 3,21
   end If
End Sub