'Review PCV Sales Grid
' 12/03/2014: For Site, check if lot size in ac convert to sqt to compare.

subjColumn = 0
GSU_SF_GLA = "**THE SUBJECT'S GLA IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
GSU_ST_SITSIZE = "THE SUBJECT'S LOT SIZE IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
GSU_QU_CONSTR = "**THE SUBJECT'S QUALITY OF CONSTRUCTION IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
GSU_COND = "**THE SUBJECT'S CONDITION IS NOT BRACKETED BY THE COMPARABLES PRESENTED."
GSU_AG_COND = "**THE SUBJECT'S CONDITION IS NOT MATCHED BY THE COMPARABLES PRESENTED."
GSU_AG_QUAL = "**THE SUBJECT'S QUALITY IS NOT MATCHED BY THE COMPARABLES PRESENTED."
glaCellID = 1004
siteCellID = 976
qualConstrCellID = 994
condCellID = 998
condValues = Array("C1","C2","C3","C4","C5","C6")
qualConstrValues = Array("Q1","Q2","Q3","Q4","Q5","Q6")

Sub ReviewGrid(isUAD, nComps)
	compsNumber  = nComps - 1
	isSubjectNumValueInCompRange glaCellID, compsNumber, GSU_SF_GLA 
	isSubjectSiteValueInCompRange siteCellID, compsNumber, GSU_ST_SITSIZE 	
	'if isUAD then		'PCV Joanna: use matched not bracketted
	'	isSubjectDescrInCompRange condCellID, compsNumber, condValues, GSU_COND
	' 	isSubjectDescrInCompRange qualConstrCellID, compsNumber, qualConstrValues, GSU_QU_CONSTR
	'end if
	if isUAD then
		isSubjectDescrMatchComps condCellID, compsNumber, GSU_AG_COND 
	end if
	if isUAD then
		isSubjectDescrMatchComps qualConstrCellID, compsNumber, GSU_AG_QUAL 
	end if
end Sub


Sub isSubjectNumValueInCompRange(cellID,noOfComps,errMsg)	
	
	'is subject bracketed by comps
	subjDescr = grid.GetCompDescription(subjColumn,cellID)	
	subjDescr = ExtractNumber(subjDescr)
	
	if not isNumeric(subjDescr) Then	
		Exit Sub
	end if
	subjValue = CDbl(subjDescr)

	NumberOfMeaningComps = 0	
	for compNo = 1 to noOfComps
		compDescr = ""
		compDescr = grid.GetCompDescription(compNo,cellID)	
		compDescr = ExtractNumber(compDescr)
		if isNumeric(compDescr) Then
			NumberOfMeaningComps = NumberOfMeaningComps + 1
			compValue = CDbl(compDescr)
			if NumberOfMeaningComps = 1 then
				minValue = compValue 
				maxValue = compValue 
			else
				if compValue < minValue then
					minValue = compValue 
				end if
				if compValue > maxValue Then
					maxValue = compValue 
				end if
			end if
		end if
	Next
	
	if NumberOfMeaningComps = 0 then
		exit Sub
	end if
	
	'get subject cell location
	form = ""
	page = ""
	cell =""
	subjCellLocation = grid.GetSubjectCellLocation(cellID)
	
	if len(subjCellLocation)  > 0 Then
		list = split(subjCellLocation,",")
		form = list(0)
		page = list(1)
		cell = list(2)
	end if
	if not (isNumeric(form) and isNumeric(page) and isNumeric(cell)) Then
		exit Sub
	end if
	if not ((subjValue >= minValue) and (subjValue <= maxValue))  Then
		scripter.AddRecord errMsg, form,page + 1,cell + 1 
	end if
	
end Sub

Sub isSubjectSiteValueInCompRange(cellID,noOfComps,errMsg)	
	
	'is subject bracketed by comps
	subjSite = grid.GetCompDescription(subjColumn,cellID)	
	subjDescr = grid.GetCompDescription(subjColumn,cellID)	
	subjDescr = ExtractNumber(subjDescr)
	
	if not isNumeric(subjDescr) Then	
		Exit Sub
	end if
	subjValue = CDbl(subjDescr)
    if inStr(subjSite,"ac") > 0 then
	  subjValue = subjValue * 43560
	end if
	
	NumberOfMeaningComps = 0	
	for compNo = 1 to noOfComps
		compDescr = ""
		compDescr = grid.GetCompDescription(compNo,cellID)	
		compSite = grid.GetCompDescription(compNo,cellID)	
		compDescr = ExtractNumber(compDescr)
		if isNumeric(compDescr) Then
			NumberOfMeaningComps = NumberOfMeaningComps + 1
			compValue = CDbl(compDescr)
			if inStr(compSite,"ac") > 0 then
			  compValue = compValue * 43560
			end if
			if NumberOfMeaningComps = 1 then
				minValue = compValue 
				maxValue = compValue 
			else
				if compValue < minValue then
					minValue = compValue 
				end if
				if compValue > maxValue Then
					maxValue = compValue 
				end if
			end if
		end if
	Next
	
	if NumberOfMeaningComps = 0 then
		exit Sub
	end if
	
	'get subject cell location
	form = ""
	page = ""
	cell =""
	subjCellLocation = grid.GetSubjectCellLocation(cellID)
	
	if len(subjCellLocation)  > 0 Then
		list = split(subjCellLocation,",")
		form = list(0)
		page = list(1)
		cell = list(2)
	end if
	if not (isNumeric(form) and isNumeric(page) and isNumeric(cell)) Then
		exit Sub
	end if
	if not ((subjValue >= minValue) and (subjValue <= maxValue))  Then
		scripter.AddRecord errMsg, form,page + 1,cell + 1 
	end if
	
end Sub



Sub isSubjectDescrInCompRange(cellID,noOfComps,ListedValues,errMsg)	
	
	'is subject bracketed by comps
	subjDescr = grid.GetCompDescription(subjColumn,cellID)	
	
	if not isStrListed(subjDescr, ListedValues) Then	
		Exit Sub
	end if
	
	NumberOfMeaningComps = 0	
	for compNo = 1 to noOfComps
		compDescr = ""
		compDescr = grid.GetCompDescription(compNo,cellID)	
		if isStrListed(compDescr,ListedValues) Then
			NumberOfMeaningComps = NumberOfMeaningComps + 1
			if NumberOfMeaningComps = 1 then
				minValue = compDescr 
				maxValue = compDescr
			else
				if compDescr < minValue then
					minValue = compDescr
				end if
				if compDescr > maxValue Then
					maxValue = compDescr
				end if
			end if
		end if
	Next
	if NumberOfMeaningComps = 0 then
		exit Sub
	end if
	
	'get subject cell location
	form = ""
	page = ""
	cell =""
	subjCellLocation = grid.GetSubjectCellLocation(cellID)
	
	if len(subjCellLocation)  > 0 Then
		list = split(subjCellLocation,",")
		form = list(0)
		page = list(1)
		cell = list(2)
	end if
	if not (isNumeric(form) and isNumeric(page) and isNumeric(cell)) Then
		exit Sub
	end if
	'scripter.AddRecord subjdescr & " " & minValue & " " & maxValue, form,page + 1,cell + 1 
	if not ((subjDescr >= minValue) and (subjDescr <= maxValue))  Then
		scripter.AddRecord errMsg, form,page + 1,cell + 1 
	end if
	
end Sub

sub isSubjectDescrMatchComps(cellID,noOfComps,errMsg)
	' Is subject matches any of comps
	Dim compDescrList()
	ReDim compDescrList(noOfComps)
	subjDescr = ""
	subjDescr = grid.GetCompDescription(subjColumn,cellID)
	subjDescr = Trim(subjDescr)
	NumberOfMeaningComps = 0
	for compNo = 1 to noOfComps
		compDescr = ""
		compDescr = grid.GetCompDescription(compNo,cellID)
		compDescr = Trim(compDescr)
		if len(compDescr) > 0 Then			
			compDescrList(NumberOfMeaningComps) = compDescr 
			'scripter.AddRecord compDescrList(NumberOfMeaningComps), 1, 1, 1
			NumberOfMeaningComps = NumberOfMeaningComps + 1
		end if
	Next
	ReDim Preserve compDescrList(NumberOfMeaningComps) 
	'get subject cell location
	form = ""
	page = ""
	cell =""
	subjCellLocation = grid.GetSubjectCellLocation(cellID)
	
	if len(subjCellLocation)  > 0 Then
		list = split(subjCellLocation,",")
		form = list(0)
		page = list(1)
		cell = list(2)
	end if
	if ((NumberOfMeaningComps = 0) and (len(subjDescr) > 0)) or not isStrListed(subjDescr,compDescrList) then
		scripter.AddRecord errMsg, form,page + 1,cell + 1 	
	end if
end sub


function ExtractNumber(rawText)
	ExtractNumber = ""
	Dim temp
	temp = replace(rawText,",","")	'get rid of comma
	for index = 1 to len(temp)
		curChar = mid(temp,index,1)
		if isNumeric(curChar) Or (curChar =".") then	'trim non digit at the begining
			exit for
		end if
	Next
	temp = Right(temp,len(temp) - index + 1)
	
	for index = 1 to len(temp)
		curChar = mid(temp,index,1)
		if isNumeric(curChar) Or (curChar =".") then	
			ExtractNumber = ExtractNumber & curChar
		else
			exit for 'trim non digit after digits
		end if
	Next		
end function

function isStrListed(str,AList)
	isStrListed = false
	for each a in AList
		if StrComp(a,str,vbBinaryCompare)  = 0 then
			isStrListed = true
			exit for
		end if	
		Next
end function

