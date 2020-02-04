object dlgUADDateOfSale: TdlgUADDateOfSale
  Left = 553
  Top = 226
  ActiveControl = rzseStatusMo
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Date of Sale'
  ClientHeight = 224
  ClientWidth = 520
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    520
    224)
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatusDate: TLabel
    Left = 217
    Top = 16
    Width = 136
    Height = 17
    Alignment = taRightJustify
    Caption = 'Withdrawn Date mm/yy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblStatusSep: TLabel
    Left = 399
    Top = 15
    Width = 5
    Height = 13
    Caption = '/'
  end
  object lblContractDate: TLabel
    Left = 230
    Top = 48
    Width = 123
    Height = 17
    Alignment = taRightJustify
    Caption = 'Contract Date mm/yy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblContractSep: TLabel
    Left = 399
    Top = 47
    Width = 5
    Height = 13
    Caption = '/'
  end
  object bbtnCancel: TBitBtn
    Left = 352
    Top = 184
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
    TabOrder = 7
  end
  object bbtnOK: TBitBtn
    Left = 267
    Top = 184
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
    TabOrder = 6
    OnClick = bbtnOKClick
  end
  object cbContractDateUnk: TCheckBox
    Tag = 1
    Left = 234
    Top = 79
    Width = 188
    Height = 17
    Hint = '4534'
    Caption = 'Contract Date is Unknown'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = cbContractDateUnkClick
  end
  object rzseStatusYr: TRzSpinEdit
    Tag = 2
    Left = 409
    Top = 12
    Width = 43
    Height = 25
    Hint = '4435'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Value = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object rzseStatusMo: TRzSpinEdit
    Tag = 1
    Left = 357
    Top = 12
    Width = 39
    Height = 25
    Hint = '4435'
    AllowKeyEdit = True
    Max = 13.000000000000000000
    Value = 12.000000000000000000
    OnButtonClick = MonthButtonClick
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object rzseContractYr: TRzSpinEdit
    Tag = 2
    Left = 409
    Top = 44
    Width = 43
    Height = 25
    Hint = '4418'
    AllowKeyEdit = True
    Max = 99.000000000000000000
    Value = 99.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object rzseContractMo: TRzSpinEdit
    Tag = 1
    Left = 357
    Top = 44
    Width = 39
    Height = 25
    Hint = '4418'
    AllowKeyEdit = True
    Max = 12.000000000000000000
    Min = 1.000000000000000000
    Value = 12.000000000000000000
    OnButtonClick = MonthButtonClick
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object bbtnHelp: TBitBtn
    Left = 437
    Top = 184
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
    TabOrder = 8
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TButton
    Left = 8
    Top = 184
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
    TabOrder = 9
    OnClick = bbtnClearClick
  end
  object rgStatusType: TRadioGroup
    Left = 24
    Top = 8
    Width = 153
    Height = 153
    Hint = '4434'
    Caption = 'Sale or Listing Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Settled Sale'
      'Active'
      'In Contract'
      'Expired'
      'Withdrawn')
    ParentFont = False
    TabOrder = 0
    OnClick = cbStatusTypeChange
  end
end
