'FM00212.vbs Cover with Photo

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Cover with Photos" + String(5, "=")
  if not HasImage(1, 1) then
     AddRec "Subject photo is EMPTY", 1, 1
  end if

  Require IDAddress, 1, 2
  Require IDCityStateZip, 1, 3
  
  'Prepared FOR
  Require IDAMCName, 1, 4
  Require IDLenderName, 1, 5
  Require IDLenderAddress, 1, 6
  Require IDLenderCityState, 1, 7
  
  Require IDREVIEWASOF, 1, 8
   
  'Prepared BY
  Require IDCERTNAMEAPPR  & REQUIRED_DATA_MISSING, 1, 9
  Require IDCERTCOMPANYADDAPPR & REQUIRED_DATA_MISSING, 1, 10
  Require "Appraiser City/State/Zip " & REQUIRED_DATA_MISSING, 1, 11
  

 end Sub  


