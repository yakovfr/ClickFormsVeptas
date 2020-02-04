object PrefDocFormatting: TPrefDocFormatting
  Left = 0
  Top = 0
  Width = 662
  Height = 381
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object ckbAutoAlignNewForms: TRzCheckBox
    Left = 24
    Top = 40
    Width = 537
    Height = 35
    Caption = 
      'Automatically apply settings to new forms as they are added to t' +
      'he report. Such as when adding extra comps page.'
    State = cbUnchecked
    TabOrder = 0
    Transparent = True
  end
  object AutoAlignCoCells: TRzRadioGroup
    Left = 40
    Top = 138
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Company Name Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 2
    Transparent = True
  end
  object AutoAlignLicUserCells: TRzRadioGroup
    Left = 40
    Top = 194
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Appraiser Name Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 3
    Transparent = True
  end
  object AutoAlignShortCells: TRzRadioGroup
    Left = 40
    Top = 250
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Short Single Line Form Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 4
    Transparent = True
  end
  object AutoAlignLongCells: TRzRadioGroup
    Left = 40
    Top = 306
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Long Single Line Form Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 5
    Transparent = True
  end
  object AutoAlignHeaderCells: TRzRadioGroup
    Left = 304
    Top = 138
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Addendum Header Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 6
    Transparent = True
  end
  object AutoAignGDCells: TRzRadioGroup
    Left = 304
    Top = 194
    Width = 225
    Height = 49
    BorderColor = clWhite
    Caption = 'Grid Description Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right'
      'N/A')
    TabOrder = 7
    Transparent = True
    OnClick = AutoAignGDCellsClick
  end
  object AutoAlignGACells: TRzRadioGroup
    Left = 304
    Top = 250
    Width = 225
    BorderColor = clWhite
    Caption = 'Grid Adjustment Cells'
    Columns = 4
    FlatColor = clBtnHighlight
    Items.Strings = (
      'Left'
      'Center'
      'Right')
    TabOrder = 8
    Transparent = True
    object GACellRounding: TRzComboBox
      Left = 80
      Top = 72
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'Round to 1'
      Items.Strings = (
        'Round to 1000'
        'Round to 500'
        'Round to 100'
        'Round to 1'
        'Round to 0.01')
    end
    object ckbGACellsDisplayZero: TRzCheckBox
      Left = 112
      Top = 44
      Width = 89
      Height = 17
      Caption = 'Display "0"'
      Checked = True
      State = cbChecked
      TabOrder = 1
      Transparent = True
    end
    object ckbGACellsAddPlus: TRzCheckBox
      Left = 24
      Top = 44
      Width = 73
      Height = 17
      Caption = 'Add "+"'
      Checked = True
      State = cbChecked
      TabOrder = 0
      Transparent = True
    end
    object Panel3: TPanel
      Left = 16
      Top = 74
      Width = 57
      Height = 17
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = 'Rounding'
      TabOrder = 3
    end
  end
  object ckbAutoAlignApplyOnOpening: TRzCheckBox
    Left = 24
    Top = 76
    Width = 537
    Height = 35
    Caption = 
      'Automatically apply settings to reports as they are opened. (May' +
      ' overwrite manually set cell formatting.)'
    State = cbUnchecked
    TabOrder = 1
    Transparent = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 662
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Formatting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object Panel2: TPanel
    Left = 216
    Top = 114
    Width = 153
    Height = 25
    BevelOuter = bvNone
    Caption = 'Cell Text Justification'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
end
