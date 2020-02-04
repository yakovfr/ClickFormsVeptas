object PrefDocFonts: TPrefDocFonts
  Left = 0
  Top = 0
  Width = 449
  Height = 229
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel2: TPanel
    Left = 24
    Top = 152
    Width = 313
    Height = 33
    BevelOuter = bvLowered
    TabOrder = 12
  end
  object btnChgFonts: TButton
    Left = 352
    Top = 47
    Width = 89
    Height = 25
    Caption = 'Change Font'
    TabOrder = 0
    OnClick = btnChgFontsClick
  end
  object btnSetFontDefaults: TButton
    Left = 352
    Top = 87
    Width = 89
    Height = 25
    Caption = 'Use Default'
    TabOrder = 1
    OnClick = btnSetFontDefaultsClick
  end
  object btnPreview: TButton
    Left = 352
    Top = 128
    Width = 89
    Height = 25
    Caption = 'Preview'
    TabOrder = 2
    OnClick = btnPreviewClick
  end
  object btnRevert: TButton
    Left = 352
    Top = 168
    Width = 89
    Height = 25
    Caption = 'Revert'
    TabOrder = 3
    OnClick = btnRevertClick
  end
  object cbxSetFontDefaults: TCheckBox
    Left = 34
    Top = 160
    Width = 295
    Height = 17
    Caption = 'Use these Font settings for all New Documents'
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Fonts'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 48
    Width = 56
    Height = 17
    Caption = 'Font Name'
    TabOrder = 6
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 72
    Width = 48
    Height = 17
    Caption = 'Font Size'
    TabOrder = 7
  end
  object stSampleText: TStaticText
    Left = 16
    Top = 96
    Width = 63
    Height = 17
    Caption = 'Font Sample'
    TabOrder = 8
  end
  object lblFontName: TStaticText
    Left = 96
    Top = 48
    Width = 24
    Height = 17
    Caption = 'Arial'
    TabOrder = 9
  end
  object lblFontSize: TStaticText
    Left = 96
    Top = 72
    Width = 10
    Height = 17
    Caption = '9'
    TabOrder = 10
  end
  object lblSampleText: TPanel
    Left = 96
    Top = 95
    Width = 185
    Height = 17
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'This is a sample of text'
    TabOrder = 11
  end
  object StaticText4: TStaticText
    Left = 64
    Top = 192
    Width = 175
    Height = 17
    Caption = 'Note: Hit the Revert button to Reset'
    TabOrder = 13
  end
  object StaticText5: TStaticText
    Left = 32
    Top = 128
    Width = 255
    Height = 17
    Caption = 'Note: Font settings apply only to the active document'
    TabOrder = 14
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 284
    Top = 192
  end
end
