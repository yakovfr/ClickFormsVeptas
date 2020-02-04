'FM00304.vbs Comparable photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Comparable Photos" + String(5, "=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Comp #1 photo 
  compid = getText(1, 14)
  addr = getText(1, 15)
  if (compID <> "") and (addr <> "") then
   Require "Comp #"&compid&" Street Address " & REQUIRED_DATA_MISSING, 1, 15
   Require "Comp #"&compid&" City/State/Zip " & REQUIRED_DATA_MISSING, 1, 16
   if not HasImage(1, 17) then
     AddRec "Comp #"&compid&" photo is EMPTY", 1, 17
   end if
  end if
  

  'Comp #2 photo 
  compid = getText(1, 18)
  addr = getText(1, 19)
  if (compid <> "") and (addr <> "") then
    Require "Comp #"&compid&" Street Address "  & REQUIRED_DATA_MISSING, 1, 19
    Require "Comp #"&compid&" City/State/Zip " & REQUIRED_DATA_MISSING, 1, 20
    if not HasImage(1, 21) then
      AddRec "Comp #"&compid&" photo is EMPTY", 1, 21
    end if
  end if

  'Comp #3 photo 
  compid = getText(1, 22)
  addr = getText(1, 23)
  if (compid <> "") and (addr <> "") then
    Require "Comp #"&compid&" Street Address "  & REQUIRED_DATA_MISSING, 1, 23
    Require "Comp #"&compid&" City/State/Zip " & REQUIRED_DATA_MISSING, 1, 24
    if not HasImage(1, 25) then
      AddRec "Comp #"&compid&" photo is EMPTY", 1, 25
    end if
  end if
  

 end Sub  


