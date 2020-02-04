'FM00316.vbs Listing 1-2-3 Photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Listing 1-2-3 Photos" + String(5, "=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Listing #1 photo 
  Require "Listing # 1 " & REQUIRED_DATA_MISSING, 1, 14
  Require "Listing # 1 Address " & REQUIRED_DATA_MISSING, 1, 15
  Require "Listing # 1 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 16
  if not HasImage(1, 17) then
     AddRec "Listing #1 Photo is EMPTY", 1, 17
  end if

  'Listing #2 photo 
  Require "Listing # 2 " & REQUIRED_DATA_MISSING, 1, 18
  Require "Listing # 2 Address " & REQUIRED_DATA_MISSING, 1, 19
  Require "Listing # 2 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 20
  if not HasImage(1, 21) then
     AddRec "Listing #2 Photo is EMPTY", 1, 21
  end if
 
  'Listing #3 photo 
  Require "Listing # 3 " & REQUIRED_DATA_MISSING, 1, 22
  Require "Listing # 3 Address " & REQUIRED_DATA_MISSING, 1, 23
  Require "Listing # 3 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 24
  if not HasImage(1, 25) then
     AddRec "Listing #3 Photo is EMPTY", 1, 25
  end if

 end Sub  


