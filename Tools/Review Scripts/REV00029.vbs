'REV00029.vbs Comparable Rent Review Script

Sub ReviewForm()
  ReviewCompRentData
  AddTitle ""	
End Sub


Sub ReviewCompRentData

   Require IDFilenum, 1, 2

   If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE2, 2, 35
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE2, 2, 82
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE2, 2, 129
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        AddRec IDTOBERANGE2, 2, 35
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE2, 2, 82
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 35)
  num3 = GetValue(2, 82)
  num4 = GetValue(2, 129)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE2, 2, 129
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num2 >= num3 and num2 >= num4 Then
      If num > num2 Then
        AddRec IDTOBERANGE3, 2, 75
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num3 >= num2 and num3 >= num4 Then
      If num > num3 Then
        AddRec IDTOBERANGE3, 2, 122
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num4 >= num3 and num4 >= num2 Then
      If num > num4 Then
        AddRec IDTOBERANGE3, 2, 169
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num2 <= num3 and num2 <= num4 Then
      If num < num2 Then
        AddRec IDTOBERANGE3, 2, 75
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num3 <= num2 and num3 <= num4 Then
      If num < num3 Then
        AddRec IDTOBERANGE3, 2, 122
      End If
    End If
End If

If hasText(2, 173) Then
  num = GetValue(2, 173)
  num2 = GetValue(2, 75)
  num3 = GetValue(2, 122)
  num4 = GetValue(2, 169)
    If num4 <= num3 and num4 <= num2 Then
      If num < num4 Then
        AddRec IDTOBERANGE3, 2, 169
      End If
    End If
End If

   Require IDSUBADD, 1, 5
   Require IDSUBCITY, 1, 6
   Require IDSUBLOC, 1, 15
   Require IDSUBVIEW, 1, 16
   Require IDSUBDESIGN, 1, 17
   Require "SUBJECT APPEAL: Missing", 1, 18
   Require IDSUBAGE, 1, 19
   Require IDSUBCOND, 1, 20
   Require "**SUBJECT ROOM COUNT: Missing", 1, 21
   Require IDSUBBED, 1, 22
   Require IDSUBBATHS, 1, 23
   Require IDSUBGLA, 1, 24

If hasText(1, 29) Then

   Require IDCOMP1ADD, 1, 29
   Require IDCOMP1CITY, 1, 30
   Require IDCOMP1PROX, 1, 31
   Require "COMP1 LEASE BEGINS: Missing date", 1, 33
   Require "COMP1 LEASE ENDS: Missing date", 1, 34
   Require IDCOMP1CURRENT, 1, 35
   Require IDCOMP1RENTDATA, 1, 39
   Require IDCOMP1LOC, 1, 45
   Require IDCOMP1VIEW, 1, 47
   Require IDCOMP1DESIGN, 1, 49
   Require "COMP1 APPEAL: Missing", 1, 51
   Require IDCOMP1AGE, 1, 53
   Require IDCOMP1COND, 1, 55
   Require "**COMP 1 ROOM COUNT: Missing", 1, 58
   Require IDCOMP1BED, 1, 59
   Require IDCOMP1BATHS, 1, 60
   Require IDCOMP1GLA, 1, 62
 End If

If hasText(1, 76) Then

   Require IDCOMP2ADD, 1, 76
   Require IDCOMP2CITY, 1, 77
   Require IDCOMP2PROX, 1, 78
   Require "COMP2 LEASE BEGINS: Missing date", 1, 80
   Require "COMP2 LEASE ENDS: Missing date", 1, 81
   Require IDCOMP2CURRENT, 1, 82
   Require IDCOMP2RENTDATA, 1, 86
   Require IDCOMP2LOC, 1, 92
   Require IDCOMP2VIEW, 1, 94
   Require IDCOMP2DESIGN, 1, 96
   Require "COMP2 APPEAL: Missing", 1, 98
   Require IDCOMP2AGE, 1, 100
   Require IDCOMP2COND, 1, 102
   Require "**COMP 2 ROOM COUNT: Missing", 1, 105
   Require IDCOMP2BED, 1, 106
   Require IDCOMP2BATHS, 1, 107
   Require IDCOMP2GLA, 1, 109
End If

If hasText(1, 123) Then
   Require IDCOMP3ADD, 1, 123
   Require IDCOMP3CITY, 1, 124
   Require IDCOMP3PROX, 1, 125
   Require "COMP3 LEASE BEGINS: Missing date", 1, 127
   Require "COMP3 LEASE ENDS: Missing date", 1, 128
   Require IDCOMP3CURRENT, 1, 129
   Require IDCOMP3RENTDATA, 1, 133
   Require IDCOMP3LOC, 1, 139
   Require IDCOMP3VIEW, 1, 141
   Require IDCOMP3DESIGN, 1, 143
   Require "COMP3 APPEAL: Missing", 1, 145
   Require IDCOMP3AGE, 1, 147
   Require IDCOMP3COND, 1, 149
   Require "**COMP 3 ROOM COUNT: Missing", 1, 152
   Require IDCOMP3BED, 1, 153
   Require IDCOMP3BATHS, 1, 154
   Require IDCOMP3GLA, 1, 156
End If

end Sub