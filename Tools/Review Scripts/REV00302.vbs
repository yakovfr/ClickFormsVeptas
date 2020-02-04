'FM00302.vbs Subject Extra 3 photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Subject 3 Photos" + String(5, "=")
  Require IDFILENUM, 1, 2
  Require IDBORROWER, 1, 5
  Require IDAddress, 1, 6
  Require IDCity, 1, 7
  Require IDCounty, 1, 8
  Require IDState, 1, 9
  Require IDZip, 1, 10
  Require IDLENDER, 1, 11
  Require IDLENDERADD, 1, 12
  
  'Subject Photo #1 photo 
  if hasImage(1, 15) then
    Require "Subject Photo #1 Title " & REQUIRED_DATA_MISSING, 1, 13
  end if
  if hasText(1, 13) then
    if not HasImage(1, 15) then
       AddRec "Subject Photo #1 photo is EMPTY", 1, 15
    end if
  end if

  'Subject Photo #2 photo 
  if hasImage(1, 18) then
    Require "Subject Photo #2 Title " & REQUIRED_DATA_MISSING, 1, 16
  end if
  if hasText(1, 16) then
    if not HasImage(1, 18) then
       AddRec "Subject Photo #2 photo is EMPTY", 1, 18
    end if
  end if
 
  'Subject Photo #3 photo 
  'Require "Subject Photo #3 Title " & REQUIRED_DATA_MISSING, 1, 19
  if hasImage(1, 21) then
    Require "Subject Photo #3 Title " & REQUIRED_DATA_MISSING, 1, 19
  end if
  if hasText(1, 19) then
    if not HasImage(1, 21) then
       AddRec "Subject Photo #3 photo is EMPTY", 1, 21
    end if
  end if
 

 end Sub  


