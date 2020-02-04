'FM00308.vbs Subject 3 photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Subject 3 Photos" + String(5, "=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Subject Photo #1 photo 
  Require "Subject Photo #1 Title " & REQUIRED_DATA_MISSING, 1, 14
  if not HasImage(1, 16) then
     AddRec "Subject Photo #1 is EMPTY", 1, 16
  end if

  'Subject Photo #2 photo 
  Require "Subject Photo #2 Title " & REQUIRED_DATA_MISSING, 1, 17
  if not HasImage(1, 19) then
     AddRec "Subject Photo #2 is EMPTY", 1, 19
  end if
 
  'Subject Photo #3 photo 
  Require "Subject Photo #3 Title " & REQUIRED_DATA_MISSING, 1, 20
  if not HasImage(1, 22) then
     AddRec "Subject Photo #3 is EMPTY", 1, 22
  end if
 

 end Sub  


