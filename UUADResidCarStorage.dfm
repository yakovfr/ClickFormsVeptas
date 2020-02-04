object dlgUADResidCarStorage: TdlgUADResidCarStorage
  Left = 573
  Top = 172
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Car Storage'
  ClientHeight = 209
  ClientWidth = 487
  Color = clBtnFace
  Constraints.MinHeight = 240
  Constraints.MinWidth = 495
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    487
    209)
  PixelsPerInch = 96
  TextHeight = 13
  object lblCarportSpaces: TLabel
    Left = 256
    Top = 9
    Width = 90
    Height = 17
    HelpType = htKeyword
    Alignment = taRightJustify
    Caption = 'Carport Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDrivewaySpaces: TLabel
    Left = 249
    Top = 61
    Width = 97
    Height = 17
    Alignment = taRightJustify
    Caption = 'Driveway Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblAttGarageSpaces: TLabel
    Left = 20
    Top = 33
    Width = 143
    Height = 17
    Alignment = taRightJustify
    Caption = 'Attached Garage Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDetGarageSpaces: TLabel
    Left = 16
    Top = 61
    Width = 147
    Height = 17
    Alignment = taRightJustify
    Caption = 'Detached Garage Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblBinGarageSpaces: TLabel
    Left = 32
    Top = 89
    Width = 131
    Height = 17
    Alignment = taRightJustify
    Caption = 'Built-In Garage Spaces'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblDrivewaySurface: TLabel
    Left = 247
    Top = 89
    Width = 99
    Height = 17
    Alignment = taRightJustify
    Caption = 'Driveway Surface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 307
    Top = 167
    Width = 80
    Height = 24
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
    TabOrder = 11
  end
  object bbtnOK: TBitBtn
    Left = 217
    Top = 167
    Width = 80
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = bbtnOKClick
  end
  object bbtnHelp: TBitBtn
    Left = 397
    Top = 167
    Width = 79
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 168
    Width = 75
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = bbtnClearClick
  end
  object cbNone: TCheckBox
    Left = 47
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
  object edtDrivewaySurface: TEdit
    Tag = 5
    Left = 351
    Top = 85
    Width = 130
    Height = 21
    Hint = '4533'
    MaxLength = 20
    TabOrder = 8
    OnChange = CalcSpaceCount
  end
  object rzseAttGarageSpaces: TRzSpinEdit
    Left = 168
    Top = 29
    Width = 40
    Height = 21
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    TabOrder = 1
    OnChange = CalcSpaceCount
  end
  object rzseDetGarageSpaces: TRzSpinEdit
    Left = 168
    Top = 57
    Width = 40
    Height = 21
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    TabOrder = 2
    OnChange = CalcSpaceCount
  end
  object rzseBinGarageSpaces: TRzSpinEdit
    Left = 168
    Top = 85
    Width = 40
    Height = 21
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    TabOrder = 3
    OnChange = CalcSpaceCount
  end
  object rzseCarportSpaces: TRzSpinEdit
    Left = 351
    Top = 8
    Width = 40
    Height = 21
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    TabOrder = 4
    OnChange = CalcSpaceCount
  end
  object rzseDrivewaySpaces: TRzSpinEdit
    Left = 351
    Top = 57
    Width = 40
    Height = 21
    Hint = '4428'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    TabOrder = 7
    OnChange = CalcSpaceCount
  end
  object cbNoAutoDlg: TCheckBox
    Left = 8
    Top = 128
    Width = 433
    Height = 21
    Caption = 'Only show this dialog when the F8 key is pressed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = cbNoneClick
  end
  object cbCarportAttached: TCheckBox
    Tag = 1
    Left = 284
    Top = 32
    Width = 80
    Height = 21
    Alignment = taLeftJustify
    Caption = 'Attached'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = cbCarportAttachedClick
  end
  object cbCarportDetached: TCheckBox
    Tag = 2
    Left = 372
    Top = 32
    Width = 80
    Height = 21
    Alignment = taLeftJustify
    Caption = 'Detached'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = cbCarportDetachedClick
  end
end
