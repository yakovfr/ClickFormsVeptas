object dlgUADPropLineAddr: TdlgUADPropLineAddr
  Left = 487
  Top = 224
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Property Address Compliance'
  ClientHeight = 193
  ClientWidth = 569
  Color = clBtnFace
  Constraints.MinWidth = 542
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    569
    193)
  PixelsPerInch = 96
  TextHeight = 17
  object lblState: TLabel
    Left = 267
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
  object lblZipSep: TLabel
    Left = 500
    Top = 41
    Width = 5
    Height = 17
    Caption = '-'
  end
  object lblUnitNum: TLabel
    Left = 380
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
    Left = 12
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
    Left = 77
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
  object ResultText: TLabel
    Left = 105
    Top = 120
    Width = 85
    Height = 17
    Caption = 'Result Search: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 401
    Top = 161
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 9
    OnClick = bbtnCancelClick
  end
  object cbState: TComboBox
    Left = 302
    Top = 39
    Width = 60
    Height = 25
    Hint = '48'
    CharCase = ecUpperCase
    ItemHeight = 17
    MaxLength = 2
    TabOrder = 3
    OnChange = editOnChange
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
    Left = 460
    Top = 39
    Width = 44
    Height = 25
    Hint = '49'
    MaxLength = 5
    TabOrder = 4
    Text = '99999'
    OnChange = editOnChange
    OnKeyPress = edtZipCodeKeyPress
  end
  object edtZipPlus4: TEdit
    Tag = 2
    Left = 515
    Top = 39
    Width = 38
    Height = 25
    Hint = '49'
    MaxLength = 4
    TabOrder = 5
    Text = '9999'
    OnKeyPress = edtZipPlus4KeyPress
  end
  object edtUnitNum: TEdit
    Tag = 3
    Left = 460
    Top = 10
    Width = 75
    Height = 25
    Hint = '2141'
    CharCase = ecUpperCase
    MaxLength = 12
    TabOrder = 1
  end
  object edtStreetAddr: TEdit
    Tag = 3
    Left = 103
    Top = 12
    Width = 259
    Height = 25
    Hint = '46'
    MaxLength = 60
    TabOrder = 0
    OnChange = editOnChange
  end
  object edtCity: TEdit
    Tag = 3
    Left = 103
    Top = 40
    Width = 163
    Height = 25
    Hint = '47'
    MaxLength = 40
    TabOrder = 2
    OnChange = editOnChange
  end
  object bbtnHelp: TBitBtn
    Left = 486
    Top = 161
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 10
    OnClick = bbtnHelpClick
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 161
    Width = 70
    Height = 24
    Anchors = [akLeft, akBottom]
    Caption = 'C&lear'
    TabOrder = 11
    OnClick = bbtnClearClick
  end
  object cbSubjAddr2ToComp: TCheckBox
    Left = 105
    Top = 68
    Width = 399
    Height = 21
    Caption = 'Use the Subject'#39's City, State && Zip Code to populate addresses'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object chkCheckComp: TCheckBox
    Left = 105
    Top = 95
    Width = 399
    Height = 21
    Caption = 'Search if address is in Comps Database'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = chkCheckCompClick
  end
  object bbtnOK: TBitBtn
    Left = 316
    Top = 161
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Save'
    TabOrder = 8
    OnClick = bbtnOKClick
  end
end
