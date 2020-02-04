'REV04145.vbs Letter of Engagement #2 Review Script

Sub ReviewForm()
	ReviewAgreement
	AddTitle ""
End Sub

Sub ReviewAgreement

	Require IDCERTLENDERNAME, 1, 5
	Require IDAICERTAPPRNAME 1, 6
	Require IDCOUNTY 1, 7
	Require IDState 1, 8
	Require IDSUBADD 1, 10

end Sub