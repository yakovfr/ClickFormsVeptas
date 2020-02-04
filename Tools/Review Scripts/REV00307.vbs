'FM00307.vbs Renting 1-2-3 Photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Renting 1-2-3" + String(5, "=")
  Require IDFILENUM, 1, 3
  Require IDBORROWER, 1, 6
  Require IDAddress, 1, 7
  Require IDCity, 1, 8
  Require IDCounty, 1, 9
  Require IDState, 1, 10
  Require IDZip, 1, 11
  Require IDLENDER, 1, 12
  Require IDLENDERADD, 1, 13
  
  'Renting #1 photo 
  rentid = GetText(1, 14)
  addr = GetText(1, 15)
  if (rentid <> "") and (addr <> "") then
    Require "Renting #"&rentid&" Street Address Missing.", 1, 15
    Require "Renting #"&rentid&" City/State/Zip Missing.", 1, 16
    if not HasImage(1, 17) then
       AddRec "Renting #1 Photo is EMPTY", 1, 17
    end if
  end if

  'Renting #2 photo 
  rentid = GetText(1, 18)
  addr = GetText(1, 19)
  if (rentid <> "") and (addr <> "") then
    Require  "Renting #"&rentid&" Street Address Missing. ", 1, 19
    Require "Renting #"&rentid&" City/State/Zip Missing.", 1, 20
    if not HasImage(1, 21) then
       AddRec "Renting "&rentid&" Photo is EMPTY", 1, 21
    end if
  end if
 
 'Renting #3 photo 
 rentid = GetText(1, 22)
 addr = GetText(1, 23)
  if (rentid <> "") and (addr <> "") then
    Require  "Renting #"&rentid&" Street Address Missing. ", 1, 23
    Require "Renting #"&rentid&" City/State/Zip Missing.", 1, 24
    if not HasImage(1, 25) then
       AddRec "Renting "&rentid&" Photo is EMPTY", 1, 25
    end if
  end if
  
 end Sub  


