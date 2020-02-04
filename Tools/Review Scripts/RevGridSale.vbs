siteCellID = 976

Sub ReviewGrid(isUAD, nComps)
  if not isUAD and grid.ValidateCellID(siteCellID)  then	'uad reports will be checked by UAD checker
     for comp = 0 to nComps - 1
        validateSitearea comp
     next
  end if
end sub

sub ValidateSitearea(compNo)
   errMsg = "*The site area is missed or format is not correct"
   sfPerAcr = 43560
   sf = "sf"
   ac = "ac"
   
   Dim msg
   Dim isValid
   isValid = true
   msg = ""

   siteDescr = trim(grid.GetCompDescription(compNo,siteCellID)) 
   descrLen = len(siteDescr)      
   if descrLen = 0 then
       msg = errMsg
       isValid = false		
   end if	
   
   if isValid then   
       spacePos = InStr(1,siteDescr," ")
       if spacePos = 0 then
	  msg = errMsg
	  isValid = false
   	end if	
    end if	

    if isValid then
	strVal = Left(siteDescr,spacePos - 1)
	units = LCase(Trim(right(siteDescr,descrLen - spacePos)))
     	if (strVal = "") or (units = "") then
	   msg = errMsg
	   isValid = false
   	end if	
    end if
   
   if isValid then
	if units = sf then
	   val = CLng(strVal)
	   if Val >= sfPerAcr then
	         msg = errMSg
		 isValid = false
	   end if
 	else if units = ac then
	         val = Cdbl(strVal)
	         if val < 1 then
		    msg = errMsg
                    isValid = false
	          end if
	      else
		 msg = errMSg
		 isValid = false	
	    end if		
	end if
    end if

    if not isValid and not grid.isColumnEmpty(compNo) then
	cellLocation = grid.GetCompCellLocation(compNo, siteCellID)	
        form = 0
        page = 0
        cell = 0
        if len(cellLocation)  > 0 Then
     	   list = split(CellLocation,",")
	   form = list(0)
	   page = list(1)
	   cell = list(2)
        end if
	scripter.AddRecord msg, form, page + 1, cell + 1
    end if
end  sub