'FM00038.vbs 2055 Extra Comps Reviewer Script

Dim compNo
Dim cmpPg
Dim cmpBase
Dim CmpOffset
Dim IDCOMP

cmpPg = 1
cmpBase = 38
cmpOffset = 48

Function GetAdjString(adj)
	Select Case adj
		Case 1: GetAdjString = IDSALESORFIN
		Case 2: GetAdjString = IDCONCESSIONS
		Case 3: GetAdjString = IDDATEOFSALE
		Case 4: GetAdjString = IDLOC
		Case 5: GetAdjString = IDGRIDSITE
		Case 6: GetAdjString = IDGRIDVIEW
		Case 7: GetAdjString = IDGRIDDESIGN
		Case 8: GetAdjString = IDGRIDAGE
		Case 9: GetAdjString = IDCONDITION
		Case 10: GetAdjString = IDROOMCOUNT
		Case 11: GetAdjString = IDGRIDGLA
		Case 12: GetAdjString = IDGRIDBASEMENT
		Case 13: GetAdjString = IDBELOW
		Case 14: GetAdjString = IDGARAGE
		Case 15, 16: GetAdjString = IDOTHER
	End Select
End Function

Function GetAdjCell(n)
  Select Case n
    CASE 1,2,3,4,5,6,7,8,9 GetAdjCell = 7 + (n - 1)*2
    case 10,11,12,13,14,15,16   GetAdjCell = 10 + (n-1)*2
  end Select
end Function

Sub ReviewForm
  ReviewSalesComparison
  AddTitle ""
end Sub

Sub ReviewSalesComparison
AddTitle String(5, "=") + "FNMA 2055 Extra Comparables" + String(5, "=")

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

  if hasText(cmpPg, clBase + 29) then
	  valA = GetValue(1, 27)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 29)
      if abs(valA - valB)/ valA > 0.25 then
        AddRec IDCOMP + IDCOMPGLARANGE, cmpPg, clBase + 29
      end if
    end if
  end if

  if hasText(cmpPg, clBase + 4) then
    valA = GetValue(1, 17)
    if valA > 0 then
      valB = GetValue(cmpPg, clBase + 4)
      if abs(valA - valB)/ valA > 10 then
        AddRec IDCOMP + IDCOMPPRGLARANGE, cmpPg, clBase + 4
      end if
    end if
  end if

  for i = 1 to 16
	  cmpCl = clBase + GetAdjCell(i)
    adjString = GetAdjString(i)
    adj = GetValue(cmpPg,cmpCl)
    if abs(adj)/price > 0.1  then AddRec IDCOMP + adjString,cmpPg,cmpCl
  next

  netAdj = GetValue(cmpPg, clBase + 43)
  if abs(netAdj)/price > 0.15  then
    AddRec IDCOMP + IDNETADJ, cmpPg, clBase + 43
  else
    AddRec IDCOMP +  CStr(FormatNumber(netAdj/price * 100,0)) + IDNET,cmpPg, clBase + 43
  end if

end Sub



