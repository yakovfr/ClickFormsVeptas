'FM00102.vbs Flood Map

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Flood Map" + String(5, "=")
  Require IDFILENUM, 1, 2
  Require IDBORROWER, 1, 5
  Require IDAddress, 1, 6
  Require IDCity, 1, 7
  Require IDCounty, 1, 8
  Require IDState, 1, 9
  Require IDZip, 1, 10
  Require IDLENDER, 1, 11
  Require IDLENDERADD, 1, 12
  
  'Flood Map 
  if not HasImage(1, 13) then
     AddRec "Flood Map is EMPTY", 1, 13
  end if

 end Sub  


