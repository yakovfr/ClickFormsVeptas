'FM00317.vbs Rental 1-2-3 Photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Rental 1-2-3 Photos" + String(5, "=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Rental #1 photo 
  Require "Rental # 1 " & REQUIRED_DATA_MISSING, 1, 14
  Require "Rental # 1 Address " & REQUIRED_DATA_MISSING, 1, 15
  Require "Rental # 1 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 16
  if not HasImage(1, 17) then
     AddRec "Rental #1 Photo is EMPTY", 1, 17
  end if

  'Rental #2 photo 
  Require "Rental # 2 " & REQUIRED_DATA_MISSING, 1, 18
  Require "Rental # 2 Address " & REQUIRED_DATA_MISSING, 1, 19
  Require "Rental # 2 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 20
  if not HasImage(1, 21) then
     AddRec "Rental #2 Photo is EMPTY", 1, 21
  end if
 
  'Rental #3 photo 
  Require "Rental # 3 " & REQUIRED_DATA_MISSING, 1, 22
  Require "Rental # 3 Address " & REQUIRED_DATA_MISSING, 1, 23
  Require "Rental # 3 City/State/Zip " & REQUIRED_DATA_MISSING, 1, 24
  if not HasImage(1, 25) then
     AddRec "Rental #3 Photo is EMPTY", 1, 25
  end if

 end Sub  


