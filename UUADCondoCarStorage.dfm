object dlgUADCondoCarStorage: TdlgUADCondoCarStorage
  Left = 489
  Top = 160
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Car Storage'
  ClientHeight = 221
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    476
    221)
  PixelsPerInch = 96
  TextHeight = 17
  object lblAssignedSpaces: TLabel
    Left = 232
    Top = 33
    Width = 98
    Height = 17
    Alignment = taRightJustify
    Caption = 'Assigned Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 244
    Top = 61
    Width = 86
    Height = 17
    Alignment = taRightJustify
    Caption = 'Owned Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblGarageSpaces: TLabel
    Left = 59
    Top = 33
    Width = 88
    Height = 17
    Alignment = taRightJustify
    Caption = 'Garage Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblCoveredSpaces: TLabel
    Left = 53
    Top = 61
    Width = 94
    Height = 17
    Alignment = taRightJustify
    Caption = 'Covered Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblOpenSpaces: TLabel
    Left = 70
    Top = 89
    Width = 77
    Height = 17
    Alignment = taRightJustify
    Caption = 'Open Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblParkingSpaceNum: TLabel
    Left = 236
    Top = 116
    Width = 94
    Height = 17
    Alignment = taRightJustify
    Caption = 'Parking Space #'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblOtherDesc: TLabel
    Left = 227
    Top = 88
    Width = 103
    Height = 17
    Alignment = taRightJustify
    Caption = 'Other Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 296
    Top = 179
    Width = 80
    Height = 27
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 10
  end
  object bbtnOK: TBitBtn
    Left = 206
    Top = 179
    Width = 80
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = bbtnOKClick
  end
  object bbtnHelp: TBitBtn
    Left = 386
    Top = 179
    Width = 79
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 180
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = bbtnClearClick
  end
  object cbNone: TCheckBox
    Left = 31
    Top = 8
    Width = 134
    Height = 21
    Alignment = taLeftJustify
    Caption = 'No Parking Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = cbNoneClick
  end
  object edtParkingSpaceNum: TEdit
    Tag = 5
    Left = 335
    Top = 113
    Width = 98
    Height = 25
    Hint = '4533'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 7
    ParentFont = False
    TabOrder = 7
  end
  object rzseGarageSpaces: TRzSpinEdit
    Left = 152
    Top = 29
    Width = 40
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = EnDisQtyFlds
  end
  object rzseCoveredSpaces: TRzSpinEdit
    Left = 152
    Top = 57
    Width = 40
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = EnDisQtyFlds
  end
  object rzseOpenSpaces: TRzSpinEdit
    Left = 152
    Top = 85
    Width = 40
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = EnDisQtyFlds
  end
  object rzseAssignedSpaces: TRzSpinEdit
    Left = 335
    Top = 29
    Width = 40
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = EnDisQtyFlds
  end
  object rzseOwnedSpaces: TRzSpinEdit
    Left = 335
    Top = 57
    Width = 40
    Height = 25
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnChange = EnDisQtyFlds
  end
  object edtOtherDesc: TEdit
    Tag = 5
    Left = 335
    Top = 85
    Width = 121
    Height = 25
    Hint = '4533'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 20
    ParentFont = False
    TabOrder = 6
  end
  object cbNoAutoDlg: TCheckBox
    Left = 8
    Top = 144
    Width = 353
    Height = 21
    Caption = 'Only show this dialog when the F8 key is pressed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = cbNoneClick
  end
end
