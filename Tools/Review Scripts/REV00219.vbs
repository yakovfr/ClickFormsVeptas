'FM00219.vbs Cover with Photo

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Cover with Photos" + String(5, "=")
  Require IDCompanyName, 1, 1
  Require IDAddress, 1, 2
  Require IDCityStateZip, 1, 3
  Require IDREVIEWASOF, 1, 4
  'Prepared FOR
  Require IDAMCName, 1, 5
  Require IDLenderName, 1, 6
  Require IDLenderAddress, 1, 7
  Require IDLenderCityState, 1, 8
   
  'Prepared BY
  Require IDCERTNAMEAPPR, 1, 9
  Require IDCERTCOMPANYAPPR, 1, 10
  Require IDCERTCOMPANYADDAPPR, 1, 11
  Require "Appraiser City/State/Zip " & REQUIRED_DATA_MISSING, 1, 12
  
  if not HasImage(1, 13) then
     AddRec "Subject photo is EMPTY", 1, 13
   end if

 end Sub  


