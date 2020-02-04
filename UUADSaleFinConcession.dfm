object dlgUADSaleFinConcession: TdlgUADSaleFinConcession
  Left = 611
  Top = 192
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'UAD: Sales Type and Financing Concessions'
  ClientHeight = 194
  ClientWidth = 464
  Color = clBtnFace
  Constraints.MinHeight = 225
  Constraints.MinWidth = 472
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    464
    194)
  PixelsPerInch = 96
  TextHeight = 13
  object lblSaleType: TLabel
    Left = 25
    Top = 22
    Width = 61
    Height = 17
    Caption = 'Sales Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object bbtnCancel: TBitBtn
    Left = 295
    Top = 154
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
  object bbtnOK: TBitBtn
    Left = 210
    Top = 154
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
    OnClick = bbtnOKClick
  end
  object cbSaleType: TComboBox
    Left = 95
    Top = 18
    Width = 194
    Height = 25
    Hint = '4532'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 17
    ParentFont = False
    TabOrder = 0
    Items.Strings = (
      'REO sale'
      'Short sale'
      'Court ordered sale'
      'Estate sale'
      'Relocation sale'
      'Non-arms length sale'
      'Arms length sale  '
      'Listing')
  end
  object bbtnHelp: TBitBtn
    Left = 380
    Top = 154
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
  object gbGSEFinConcession: TGroupBox
    Left = 8
    Top = 56
    Width = 449
    Height = 89
    Caption = 'Financing Concessions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblFinType: TLabel
      Left = 7
      Top = 25
      Width = 27
      Height = 17
      Alignment = taRightJustify
      Caption = 'Type'
    end
    object lblTotalConcessAmt: TLabel
      Left = 3
      Top = 61
      Width = 115
      Height = 17
      Alignment = taRightJustify
      Caption = 'Concession Amount'
    end
    object lblFinOtherDesc: TLabel
      Left = 205
      Top = 24
      Width = 144
      Height = 17
      Alignment = taRightJustify
      Caption = '"Other" Type Description'
    end
    object cbFinType: TComboBox
      Left = 39
      Top = 22
      Width = 162
      Height = 25
      Hint = '4432'
      ItemHeight = 17
      TabOrder = 0
      OnChange = cbFinTypeChange
      Items.Strings = (
        'FHA'
        'VA'
        'Conventional'
        'Cash'
        'Seller'
        'Rural housing'
        'Other')
    end
    object edtTotalConcessAmt: TEdit
      Tag = 5
      Left = 130
      Top = 58
      Width = 73
      Height = 25
      Hint = '4533'
      MaxLength = 9
      TabOrder = 2
      Text = '0'
      OnExit = edtTotalConcessAmtExit
      OnKeyPress = edtTotalConcessAmtKeyPress
    end
    object edtFinOtherDesc: TEdit
      Tag = 5
      Left = 354
      Top = 20
      Width = 88
      Height = 25
      Hint = '4433'
      MaxLength = 11
      TabOrder = 1
    end
  end
  object bbtnClear: TBitBtn
    Left = 8
    Top = 154
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
    TabOrder = 5
    OnClick = bbtnClearClick
  end
end
