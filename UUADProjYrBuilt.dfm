object dlgUADProjYrBuilt: TdlgUADProjYrBuilt
  Left = 626
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Year Built'
  ClientHeight = 124
  ClientWidth = 407
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
    407
    124)
  PixelsPerInch = 96
  TextHeight = 17
  object lblYrBuilt: TLabel
    Left = 17
    Top = 9
    Width = 131
    Height = 17
    Caption = 'Enter Year Built or Age'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 239
    Top = 85
    Width = 75
    Height = 25
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
    TabOrder = 4
  end
  object bbtnOK: TBitBtn
    Left = 154
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = bbtnOKClick
  end
  object cbEstimated: TCheckBox
    Tag = 1
    Left = 174
    Top = 34
    Width = 203
    Height = 21
    Hint = '4425'
    Caption = 'Year Built is an Estimate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtYrBuilt: TEdit
    Left = 16
    Top = 32
    Width = 65
    Height = 25
    Hint = '151'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 0
    Text = '9999'
    OnExit = edtYrBuiltExit
    OnKeyPress = edtYrBuiltKeyPress
  end
  object edtAge: TEdit
    Left = 105
    Top = 32
    Width = 48
    Height = 25
    Hint = '996'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 1
    Text = '999'
    OnExit = edtAgeExit
    OnKeyPress = edtAgeKeyPress
  end
  object bbtnHelp: TBitBtn
    Left = 324
    Top = 85
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 85
    Width = 70
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = bbtnClearClick
  end
end
