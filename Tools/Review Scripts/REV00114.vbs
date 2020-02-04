'FM00114.vbs Map

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Map Photos" + String(5, "=")
  Require IDCompanyName, 1, 1
  Require "Company Address " & REQUIRED_DATA_MISSING, 1, 2
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Exhibit 
  if not HasImage(1, 14) then
     AddRec "Map Image is EMPTY", 1, 14
  end if

 end Sub  


