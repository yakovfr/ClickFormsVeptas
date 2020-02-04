object dlgUADSiteArea: TdlgUADSiteArea
  Left = 636
  Top = 281
  BorderStyle = bsSingle
  Caption = 'UAD: Site Area'
  ClientHeight = 94
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    382
    94)
  PixelsPerInch = 96
  TextHeight = 13
  object lblAcres: TLabel
    Left = 213
    Top = 18
    Width = 32
    Height = 21
    Alignment = taRightJustify
    Caption = 'Acres'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblSqFt: TLabel
    Left = 48
    Top = 18
    Width = 69
    Height = 21
    Alignment = taRightJustify
    Caption = 'Square Feet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtAcres: TEdit
    Left = 250
    Top = 14
    Width = 65
    Height = 21
    Hint = '67'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '99,999.99'
    OnEnter = edtAcresEnter
    OnExit = edtAcresExit
    OnKeyPress = edtAcresKeyPress
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 56
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
    TabOrder = 5
    OnClick = bbtnClearClick
  end
  object bbtnSave: TBitBtn
    Left = 120
    Top = 56
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
    TabOrder = 2
    OnClick = bbtnSaveClick
  end
  object bbtnCancel: TBitBtn
    Left = 208
    Top = 56
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
    TabOrder = 3
  end
  object bbtnHelp: TBitBtn
    Left = 296
    Top = 56
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
    TabOrder = 4
    OnClick = bbtnHelpClick
  end
  object edtSqFt: TEdit
    Left = 126
    Top = 14
    Width = 70
    Height = 21
    Hint = '67'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '99,999'
    OnEnter = edtSqFtEnter
    OnExit = edtSqFtExit
    OnKeyPress = edtSqFtKeyPress
  end
end
