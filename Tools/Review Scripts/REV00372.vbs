'REV00372.vbs AI Market Area Analysis Reviewer Script

Sub ReviewForm
  ReviewMarket
  AddTitle ""
  ReviewSite
  AddTitle ""
  ReviewHBU
  AddTitle ""
End Sub

Sub ReviewMarket

  AddTitle String(5, "=") + "AI FORMS MARKET ANALYSIS: Market Area Analysis" + String(5, "=") 

  Require IDFilenum, 1, 5

  OnlyOneCheckOfThree 1, 6, 7, 8, IDLOCNOCHK, IDLOCNOCHK
  OnlyOneCheckOfThree 1, 9, 10, 11, IDBUILTNOCHK, IDBUILTNOCHK
  OnlyOneCheckOfThree 1, 12, 13, 14, IDGROWTHNOCHK, IDGROWTHNOCHK
  OnlyOneCheckOfThree 1, 15, 16, 17, IDDEMANDNOCHK, IDDEMANDNOCHK
  OnlyOneCheckOfThree 1, 18, 19, 20, IDVALTRENDNOCHK, IDVALTRENDNOCHK
  OnlyOneCheckOfThree 1, 21, 22, 23, IDTYPMKTTIMENOCHK, IDTYPMKTTIMENOCHK

  Require IDLOWPRICE, 1, 24
  Require IDHIGHPRICE, 1, 25
  Require IDPREDPRICE, 1, 26
  If hasText(1, 26) Then
    num = GetValue(1, 26)
      If num < GetValue(1, 24) or num > GetValue(1, 25) then
        AddRec IDPRICERANGE, 1,26
      End If
  End If

  Require IDLOWAGE, 1, 27
  Require IDHIGHAGE, 1, 28
  Require IDPREDAGE, 1, 29
  If hasText(1, 29) Then
    num = GetValue(1, 29)
      If num < GetValue(1, 27) or num > GetValue(1, 28) then
        AddRec IDAGERANGE, 1,29
      End If
  End If

  Sum = GetValue(1, 30) + GetValue(1, 31) + GetValue(1, 32) + GetValue(1, 33) + GetValue(1, 34) + GetValue(1, 36)
  If Sum <> 100 Then
    AddRec IDLandUse, 1, 30
  End If

  Require IDPROJNAME, 1, 37
  If isChecked(1, 38) Then
    Require IDPUDCONDOHOA, 1, 40
  End If
  If isChecked(1, 39) Then
    Require IDPUDCONDOHOA, 1, 40
  End If
  If not isnegativecomment(1, 40) Then 
    OnlyOneCheckOfTwo 1, 38, 39, IDPUDCONDOHOA2, IDPUDCONDOHOA2
  End If
  If hasText(1, 40) Then
    Require IDPUDCONDOHOA3, 1, 41
  End If
  Require IDAMENITIESDESC, 1, 42

  Require IDAIMARKETAREA, 1, 43

End Sub

Sub ReviewSite

  AddTitle String(5, "=") + "AI FORMS MARKET ANALYSIS: Site Analysis" + String(5, "=")
   
  Require IDDIMEN, 1, 44
  Require IDCOMPVIEW, 1, 45
  Require IDDRAINAGE, 1, 46
  Require IDAIAREA, 1, 47
  Require IDSHAPE, 1, 48  
  Require IDAIUTILITY, 1, 49 

  OnlyOneCheckOfThree 1, 50, 51, 52, IDAISIZECK, IDAISIZECK 
  OnlyOneCheckOfThree 1, 53, 54, 55, IDAIVIEWCK, IDAIVIEWCK

  OnlyOneCheckOfTwo 1, 68, 69, IDAIELECCK, IDAIELECCK
  If isChecked(1, 69) Then
    Require IDAIELECCOMM, 1, 70
  End If
  OnlyOneCheckOfTwo 1, 71, 72, IDAIGASCK, IDAIGASCK
  If isChecked(1, 72) Then
    Require IDAIGASCOMM, 1, 73
  End If
  OnlyOneCheckOfTwo 1, 74, 75, IDAIWATERCK, IDAIWATERCK
  If isChecked(1, 75) Then
    Require IDAIWATERCOMM, 1, 76
  End If
  OnlyOneCheckOfTwo 1, 77, 78, IDAISANCK, IDAISANCK
  If isChecked(1, 78) Then
    Require IDAISANCOMM, 1, 79
  End If

  OnlyOneCheckOfFour 1, 57, 58, 59, 60, IDAIZONINGCK, IDAIZONINGCK
  If not isChecked(1, 58) Then
    Require IDAIZONING, 1, 56
  End If
  OnlyOneCheckOfThree 1, 61, 62, 63, IDAICOVENANT, IDAICOVENANT
  OnlyOneCheckOfTwo 1, 64, 65, IDAIDOCREVIEW, IDAIDOCREVIEW
  Require IDAIGROUNDRENT, 1, 66
  If hasText(1, 66) Then
    Require IDAIGROUNDRENT2,1, 67    
  End If

  OnlyOneCheckOfTwo 1, 80, 81, IDSTREETNOCK, IDSTREETNOCK
  If isChecked(1, 81) Then
    Require IDSTREETPRIV, 1, 82
  End If
  OnlyOneCheckOfTwo 1, 83, 84, IDALLEYNOCK, IDALLEYNOCK
  If isChecked(1, 84) Then
    Require IDALLEYPRIV, 1, 85
  End If
  OnlyOneCheckOfTwo 1, 86, 87, IDSIDENOCK, IDSIDENOCK
  If isChecked(1, 87) Then
    Require IDSIDEPRIV, 1, 88
  End If
  OnlyOneCheckOfTwo 1, 89, 90, IDLIGHTNOCK, IDLIGHTNOCK
  If isChecked(1, 90) Then
    Require IDLIGHTPRIV, 1, 91
  End If

  Require IDAISITEDESC, 1, 92

End Sub

Sub ReviewHBU
  AddTitle String(5, "=") + "AI FORMS MARKET ANALYSIS: Highest and Best Use Analysis" + String(5, "=") 
  OnlyOneCheckOfThree 1, 93, 94, 95, IDAIHBU, IDAIHBU
  If isChecked(1, 95) Then
    Require IDAIHBUCOMM, 1, 96
  End If
  Require IDAIHBUDESC, 1, 97
End Sub
