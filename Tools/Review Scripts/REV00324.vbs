'FM00324.vbs 6 photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Subject Interior 6 Photos" + String(5, "=")
  Require IDCompanyName, 1, 1
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  
  'Do not show warning if empty image and no title
  cell = 13
  title = 14
  For count = 1 to 6
    'Photo of count photo
    if hasText(1, title + Count) then 	
      if not HasImage(1, cell + Count) then
        AddRec "Photo #" &count& " is EMPTY", 1, cell + Count
      end if
    end if
	
	if HasImage(1, cell + Count) then
	  Require "Photo #"&count& " Title " &REQUIRED_DATA_MISSING, 1, title + Count
	end if
	
	cell = cell + 1
	title = title + 1
  Next
  
  
  
 end Sub  


