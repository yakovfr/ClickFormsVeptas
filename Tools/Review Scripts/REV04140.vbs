'FM04140.vbs - Clear Capital Desktop
'08/15/2017: 
'Call:IDSUBDOSMDY AND IDCOMPXDOSMDY to check that the sales date is in the format MM/DD/YYYY
'Call:IDDATEPSTFMTSUBJ and IDDATEPSTFMTCOMPX to check that the sales date is in the fo

Sub ReviewForm
	ReviewSalesComparison
  	AddTitle ""
End Sub

Sub ReviewSalesComparison
	If not IsDateFormatOK(1, 77) Then
       AddRec IDINVALIDDATEFORMAT, 1, 77
    End If

	If not IsDateFormatOK(1, 108) Then
       AddRec IDINVALIDDATEFORMAT, 1, 108
    End If

	If not IsDateFormatOK(1, 156) Then
       AddRec IDINVALIDDATEFORMAT, 1, 156
    End If

	If  not IsDateFormatOK(1, 204) Then
       AddRec IDINVALIDDATEFORMAT, 1, 204
    End If

	If not IsDateFormatOK(1, 251) Then
       AddRec IDINVALIDDATEFORMAT, 1, 251
    End If

	If not IsDateFormatOK(1, 253) Then
       AddRec IDINVALIDDATEFORMAT, 1, 253
    End If

	If not IsDateFormatOK(1, 255) Then
       AddRec IDINVALIDDATEFORMAT, 1, 255
     End If

	If not IsDateFormatOK(1, 257) Then
       AddRec IDINVALIDDATEFORMAT, 1, 257
     End If

	If not IsDateFormatOK(1, 259) Then
       AddRec IDINVALIDDATEFORMAT, 1, 259
     End If

	If not IsDateFormatOK(1, 261) Then
       AddRec IDINVALIDDATEFORMAT, 1, 261
     End If

	If not IsDateFormatOK(1, 263) Then
       AddRec IDINVALIDDATEFORMAT, 1, 263
     End If

	If not IsDateFormatOK(1, 265) Then
       AddRec IDINVALIDDATEFORMAT, 1, 265
     End If
     
End Sub