'FM00301.vbs Subject 3 photos

Sub ReviewForm
  ReviewSubject
end Sub


Sub ReviewSubject
  AddTitle String(5, "=") + "Subject 3 Photos" + String(5, "=")
  Require IDFILENUM, 1, 2
  'Case Number required if text in cell 3 
  ' not for Photo page
  'caseno = getText(1,3)
  'if hasText(1, 3) Then
  '	If Not hasText(1, 4) Then	 
  '  AddRec caseNo&" is missing.", 1, 4
  ' 	Else
  ' 	End if
  '	End If
	
  Require IDBORROWER, 1, 5
  Require IDAddress, 1, 6
  Require IDCity, 1, 7
  Require IDCounty, 1, 8
  Require IDState, 1, 9
  Require IDZip, 1, 10
  Require IDLENDER, 1, 11
  Require IDLENDERADD, 1, 12
  
  'Subject Front photo 
  if not HasImage(1, 15) then
     AddRec "Subject FRONT photo is EMPTY", 1, 15
   end if

  'Subject Rear photo 
  if not HasImage(1, 18) then
     AddRec "Subject REAR photo is EMPTY", 1, 18
   end if

  'Subject Street photo 
  if not HasImage(1, 21) then
     AddRec "Subject STREET photo is EMPTY", 1, 21
   end if
  

 end Sub  


