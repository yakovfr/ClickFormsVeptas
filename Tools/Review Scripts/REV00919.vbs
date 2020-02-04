'FM00919.vbs Subject Interior 6 Photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Subject Interior 6 Photos" + String(5, "=")
  Require IDCompanyName, 1, 1
  Require IDFILENUM, 1, 2
  Require IDBORROWER, 1, 5
  Require IDAddress, 1, 6
  Require IDCity, 1, 7
  Require IDCounty, 1, 8
  Require IDState, 1, 9
  Require IDZip, 1, 10
  Require IDLENDER, 1, 11
  Require IDLENDERADD, 1, 12
  
  'Kitchen photo 
  if not HasImage(1, 13) then
     AddRec "Kitchen Photo is EMPTY", 1, 13
  end if

  'Living Room photo 
  if not HasImage(1, 14) then
     AddRec "Living Photo is EMPTY", 1, 14
  end if
  
  'Master Bath #1 photo 
  if not HasImage(1, 17) then
     AddRec "Master Bath #1 is EMPTY", 1, 17
  end if
  
  'Bath #2 photo 
  if not HasImage(1, 18) then
     AddRec "Bath #2 is EMPTY", 1, 18
  end if
  
  'Bath #3 photo 
  if not HasImage(1, 21) then
     AddRec "Bath #3 is EMPTY", 1, 21
  end if
  
'Bath #4 photo 
  if not HasImage(1, 22) then
     AddRec "Bath #4 is EMPTY", 1, 22
  end if
  
  
 end Sub  


