object PrefAppPDF: TPrefAppPDF
  Left = 0
  Top = 0
  Width = 455
  Height = 158
  TabOrder = 0
  object rbtnUseBuiltIn: TRadioButton
    Left = 16
    Top = 48
    Width = 205
    Height = 17
    Caption = 'Use ClickFORMS PDF Creator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object chkShowAdvancedOptions: TCheckBox
    Left = 48
    Top = 72
    Width = 313
    Height = 17
    Caption = 'Show Advanced Options when creating a PDF file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object rbtnUseAdobe: TRadioButton
    Left = 16
    Top = 109
    Width = 17
    Height = 17
    TabOrder = 2
    OnClick = ChgPDFOptionClick
  end
  object cmbxPDFDriverList: TComboBox
    Left = 167
    Top = 107
    Width = 217
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
    Text = 'Adobe PDF Driver Not Selected'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   PDF Creator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object stUseAdobe: TStaticText
    Left = 35
    Top = 109
    Width = 131
    Height = 17
    Caption = 'Use Adobe Acrobat Driver:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
end
