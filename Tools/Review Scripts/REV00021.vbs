'FM00021.vbs SMALL INCOME Extra Comps Reviewer Script

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 62
cmpOffset = 82

Function GetAdjString(n)
  Select Case n
    case	1 GetAdjString = IDSALESORFIN
    case	2 GetAdjString = IDCONCESSIONS
    case	3 GetAdjString = IDDATEOFSALE
    case	4 GetAdjString = IDLOC
    case	5 GetAdjString = IDLEASE
    case	6 GetAdjString = IDGRIDSITE
    case	7 GetAdjString = IDGRIDVIEW
    case	8 GetAdjString = IDGRIDDESIGN
    case	9 GetAdjString = IDQUAL
    case	10 GetAdjString = IDGRIDAGE
    case	11 GetAdjString = IDCONDITION
    case	12 GetAdjString = IDGRIDGBA
    case	13 GetAdjString = IDABOVEGRADE
    case	14 GetAdjString = IDABOVEGRADE
    case	15,16,17,18 GetAdjString = IDROOMCOUNT
    case	19 GetAdjString = IDGRIDBASEMENT
    case	20 GetAdjString = IDFUNC
    case	21 GetAdjString = IDHEAT
    case	22 GetAdjString = IDGRIDPARK
    case	23 GetAdjString = IDGRIDAMN
    case	24 GetAdjString = IDGRIDFEE
    case	25 GetAdjString = IDOTHER
  end Select
end function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9,10,11,12 GetAdjCell = 14 + (n - 1)*2
    case 13  GetAdjCell = 37
    case 14,15,16,17,18  GetAdjCell = 38 + (n - 15)*6
    case 19,20,21,22,23,24,25  GetAdjCell = 28 + (n-1)*2
  end Select
end Function

Sub ReviewForm
  ReviewSalesComparison
  AddTitle ""
end Sub


Sub ReviewSalesComparison
AddTitle String(5, "=") + "FNMA 1025 Extra Comparables" + String(5, "=")
  for pageCmpNo = 1 to 3
    cmpNo = GetCmpNo(pageCmpNo)
    ReviewSalesComp cmpNo,cmpPg,cmpBase + (pageCmpNo - 1) * cmpOffset
  next
end Sub

function GetCmpNo(pgCmpNo)
  GetCmpNo = GetValue(1, cmpBase + (pgCmpNo - 1) * cmpOffset - 1)
end Function

Sub ReviewSalesComp(cmpNo,cmpPg,clBase)
 price = GetValue(cmpPg, clBase + 5)
  if price <= 0 then exit Sub
  IDCOMP = IDCOMPGEN + CStr(cmpNo) + ": "

  if hasText(cmpPg, clBase + 35) then
	  valA = GetValue(1, 32)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 35)
      if abs(valA - valB)/ valA > 0.25 then
        AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 35
      end if
    end if
  end if

  if hasText(cmpPg, clBase + 6) then
    valA = GetValue(1, 17)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 6)
      if abs(valA - valB)/ valA > 10 then
        AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 6
      end if
    end if
  end if

  for i = 1 to 25
	  cmpCl = clBase + GetAdjCell(i)
    adjString = GetAdjString(i)
    adj = GetValue(cmpPg,cmpCl)
    if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  next

  netAdj = GetValue(cmpPg, clBase + 79)
  if abs(netAdj)/price > 0.15  then
    AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 79
  else
    AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 79
  end if

end Sub



