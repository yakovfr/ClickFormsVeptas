'FM00008.vbs Condo Extra Comps Reviewer Script

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 47
cmpOffset = 67

Function GetAdjString(adj)
	Select case adj
		case	1:  GetAdjString = IDSALESORFIN
		case	2:  GetAdjString = IDCONCESSIONS
		case	3:  GetAdjString = IDDATEOFSALE
		case	4:  GetAdjString = IDLOC
		case	5:  GetAdjString = IDLEASE
		case	6:  GetAdjString = IDGRIDHOA
		case	7:  GetAdjString = IDGRIDELE
		case	8:  GetAdjString = IDRECADJ
		case	9:  GetAdjString = IDPRJADJ
		case	10:  GetAdjString = IDGRIDFLR
		case	11:  GetAdjString = IDGRIDVIEW
		case	12:  GetAdjString = IDGRIDDESIGN
		case	13:  GetAdjString = IDQUAL
		case	14:  GetAdjString = IDGRIDAGE
		case	15:  GetAdjString = IDCONDITION
		case	16:  GetAdjString = IDABOVEGRADE
		case	17:  GetAdjString = IDROOMCOUNT
		case	18:  GetAdjString = IDGRIDGLA
		case	19:  GetAdjString = IDGRIDBASEMENT
		case	20:  GetAdjString = IDBELOW
		case	21:  GetAdjString = IDFUNC
		case	22:  GetAdjString = IDHEAT
		case	23:  GetAdjString = IDENERGY
		case	24:  GetAdjString = IDGARAGE
		case	25:  GetAdjString = IDPORCH
		case	26:  GetAdjString = IDFIRE
		case	27:  GetAdjString = IDOTHER
	end Select
end Function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 GetAdjCell = 8 + (n - 1)*2
    case 16 GetAdjCell = 37
    case 17,18,18,20,21,22,23,24,25,26,27   GetAdjCell = 9 + (n-1)*2
  end Select
end Function

Sub ReviewForm
  ReviewSalesComparison
  AddTitle ""
end Sub

Sub ReviewSalesComparison
AddTitle String(5, "=") + "FNMA Condo 94 Extra Comparables" + String(5, "=")
  for pageCmpNo = 1 to 3
    cmpNo = GetCmpNo(pageCmpNo)
    ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
  next
end Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
	price = GetValue(cmpPg, clBase + 3)
  	if price <= 0 then exit Sub
  	IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "
  	
	if hasText(cmpPg, clBase + 42) then
		valA = GetValue(2, 35)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 42)
      		if abs(valA - valB)/ valA > 0.25 then
        		AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 42
      		end if
    	end if
  	end if
  
    if hasText(cmpPg, clBase + 4) then
    	valA = GetValue(2, 17)
    	if valA > 0 then
      		valB = GetValue(cmpPg, clBase + 4)
      		if abs(valA - valB)/ valA > 10 then
        		AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 4
      		end if
    	end if
  	end if
  	
	for i = 1 to 27
		cmpCl = clBase + GetAdjCell(i)
    	adjString = GetAdjString(i)
    	adj = GetValue(cmpPg,cmpCl)
    	if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  	next
  
    netAdj = GetValue(cmpPg, clBase + 64)
  	if abs(netAdj)/price > 0.15  then
    	AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 64
  	else
    	AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 64
  	end if
    
End Sub
