object dlgUADPropSubjAddr: TdlgUADPropSubjAddr
  Left = 596
  Top = 209
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Address Compliance'
  ClientHeight = 124
  ClientWidth = 567
  Color = clBtnFace
  Constraints.MinWidth = 547
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    567
    124)
  PixelsPerInch = 96
  TextHeight = 13
  object lblState: TLabel
    Left = 275
    Top = 42
    Width = 29
    Height = 17
    Alignment = taRightJustify
    Caption = 'State'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblZipCode: TLabel
    Left = 405
    Top = 43
    Width = 53
    Height = 17
    Alignment = taRightJustify
    Caption = 'Zip Code'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblUnitNum: TLabel
    Left = 383
    Top = 14
    Width = 75
    Height = 17
    Alignment = taRightJustify
    Caption = 'Unit Number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblStreetAddr: TLabel
    Left = 18
    Top = 16
    Width = 86
    Height = 17
    Alignment = taRightJustify
    Caption = 'Street Address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblCity: TLabel
    Left = 83
    Top = 44
    Width = 21
    Height = 17
    Alignment = taRightJustify
    Caption = 'City'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblZipSep: TLabel
    Left = 500
    Top = 41
    Width = 3
    Height = 13
    Caption = '-'
  end
  object bbtnCancel: TBitBtn
    Left = 399
    Top = 84
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
    Left = 314
    Top = 84
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
  object cbState: TComboBox
    Left = 308
    Top = 39
    Width = 60
    Height = 25
    Hint = '48'
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    MaxLength = 2
    ParentFont = False
    TabOrder = 3
    OnKeyPress = cbStateKeyPress
    Items.Strings = (
      'AK'
      'AL'
      'AR'
      'AS'
      'AZ'
      'CA'
      'CO'
      'CT'
      'DE'
      'DC'
      'FM'
      'FL'
      'GA'
      'GU'
      'HI'
      'IA'
      'ID'
      'IL'
      'IN'
      'KS'
      'KY'
      'LA'
      'MA'
      'MD'
      'ME'
      'MH'
      'MI'
      'MN'
      'MO'
      'MP'
      'MS'
      'MT'
      'NC'
      'ND'
      'NE'
      'NH'
      'NJ'
      'NM'
      'NV'
      'NY'
      'OH'
      'OK'
      'OR'
      'PA'
      'PR'
      'PW'
      'RI'
      'SC'
      'SD'
      'TN'
      'TX'
      'UT'
      'VA'
      'VI'
      'VT'
      'WA'
      'WI'
      'WV'
      'WY')
  end
  object edtZipCode: TEdit
    Tag = 1
    Left = 463
    Top = 39
    Width = 50
    Height = 25
    Hint = '49'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 4
    Text = '99999'
    OnKeyPress = edtZipCodeKeyPress
  end
  object edtZipPlus4: TEdit
    Tag = 2
    Left = 517
    Top = 39
    Width = 38
    Height = 25
    Hint = '49'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 5
    Text = '9999'
    OnKeyPress = edtZipPlus4KeyPress
  end
  object edtUnitNum: TEdit
    Tag = 3
    Left = 463
    Top = 10
    Width = 75
    Height = 25
    Hint = '2141'
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    TabOrder = 1
  end
  object edtStreetAddr: TEdit
    Tag = 3
    Left = 109
    Top = 12
    Width = 259
    Height = 25
    Hint = '46'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 60
    ParentFont = False
    TabOrder = 0
  end
  object edtCity: TEdit
    Tag = 3
    Left = 109
    Top = 40
    Width = 163
    Height = 25
    Hint = '47'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 2
  end
  object bbtnHelp: TBitBtn
    Left = 484
    Top = 84
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
  object bbtnClear: TBitBtn
    Left = 8
    Top = 84
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
    TabOrder = 9
    OnClick = bbtnClearClick
  end
end
