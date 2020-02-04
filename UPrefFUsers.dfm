object PrefUsers: TPrefUsers
  Left = 0
  Top = 0
  Width = 562
  Height = 397
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object lbxUserList: TRzListBox
    Left = 18
    Top = 124
    Width = 231
    Height = 189
    Align = alCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = lbxUserListClick
  end
  object btnCurrent: TButton
    Left = 263
    Top = 128
    Width = 106
    Height = 25
    Caption = 'Make Current'
    TabOrder = 1
    OnClick = btnCurrentClick
  end
  object btnDefault: TButton
    Left = 263
    Top = 161
    Width = 106
    Height = 25
    Caption = 'Make Default'
    TabOrder = 2
    OnClick = btnDefaultClick
  end
  object btnRemove: TButton
    Left = 263
    Top = 195
    Width = 106
    Height = 25
    Caption = 'Remove Default'
    TabOrder = 3
    OnClick = btnRemoveClick
  end
  object btnDelete: TButton
    Left = 263
    Top = 231
    Width = 106
    Height = 25
    Caption = 'Delete User'
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object btnNewUser: TButton
    Left = 263
    Top = 268
    Width = 106
    Height = 25
    Caption = 'Add New User'
    TabOrder = 5
    OnClick = btnNewUserClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Licenses'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object stCurUser: TStaticText
    Left = 16
    Top = 56
    Width = 112
    Height = 17
    Caption = 'Current Licensed User:'
    TabOrder = 7
  end
  object stDefUser: TStaticText
    Left = 16
    Top = 88
    Width = 115
    Height = 17
    Caption = 'Default User at Startup:'
    TabOrder = 8
  end
  object lblCurrentUser: TStaticText
    Left = 136
    Top = 49
    Width = 96
    Height = 17
    Caption = 'Select Current User'
    TabOrder = 9
  end
  object lblDefaultUser: TStaticText
    Left = 136
    Top = 81
    Width = 96
    Height = 17
    Caption = 'Select Default User'
    TabOrder = 10
  end
  object stDefUserLine: TStaticText
    Left = 128
    Top = 96
    Width = 217
    Height = 17
    Caption = 
      '----------------------------------------------------------------' +
      '-------'
    TabOrder = 11
  end
  object stCurUserLine: TStaticText
    Left = 128
    Top = 64
    Width = 217
    Height = 17
    Caption = 
      '----------------------------------------------------------------' +
      '-------'
    TabOrder = 12
  end
end
