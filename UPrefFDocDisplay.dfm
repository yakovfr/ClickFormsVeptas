object PrefDocDisplay: TPrefDocDisplay
  Left = 0
  Top = 0
  Width = 516
  Height = 285
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object ckbShowPageMgr: TCheckBox
    Left = 11
    Top = 48
    Width = 428
    Height = 17
    Caption = 
      'Display Forms Manager page list on left side of the Container wi' +
      'ndow'
    TabOrder = 0
  end
  object ckbLastCurCell: TCheckBox
    Left = 12
    Top = 74
    Width = 321
    Height = 17
    Caption = 'When opening reports, start at the last active cell.'
    TabOrder = 1
  end
  object rbtnFitToScreen: TRadioButton
    Left = 41
    Top = 157
    Width = 393
    Height = 32
    Caption = 
      'Maximize Window, scale document to fit window (recommended for L' +
      'aptops)'
    TabOrder = 3
    WordWrap = True
    OnClick = rbtnFitToScreenClick
  end
  object rbtnDoScale: TRadioButton
    Left = 40
    Top = 190
    Width = 17
    Height = 33
    TabOrder = 4
    OnClick = rbtnDoScaleClick
  end
  object edtScale: TEdit
    Left = 233
    Top = 196
    Width = 33
    Height = 21
    MaxLength = 3
    TabOrder = 5
    Text = '100'
    OnExit = edtScaleExit
    OnKeyPress = NumberFilter
  end
  object btnPreview: TButton
    Left = 24
    Top = 228
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 6
    OnClick = btnPreviewClick
  end
  object btnRevert: TButton
    Left = 120
    Top = 228
    Width = 75
    Height = 25
    Caption = 'Revert'
    TabOrder = 7
    OnClick = btnRevertClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Display'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object stResetNote: TStaticText
    Left = 24
    Top = 260
    Width = 175
    Height = 17
    Caption = 'Note: Hit the Revert button to Reset'
    TabOrder = 9
  end
  object stScalePercent: TStaticText
    Left = 270
    Top = 198
    Width = 43
    Height = 17
    Caption = 'percent.'
    TabOrder = 10
  end
  object stDefWindowSize: TStaticText
    Left = 24
    Top = 134
    Width = 125
    Height = 17
    Caption = 'Set Default Window Size:'
    TabOrder = 11
  end
  object stDoScale: TStaticText
    Left = 59
    Top = 198
    Width = 172
    Height = 17
    Caption = 'Normal Window, scale document at'
    TabOrder = 12
  end
  object ckbUADAutoZeroOrNone: TRzCheckBox
    Left = 11
    Top = 100
    Width = 502
    Height = 18
    Caption = 
      'When creating a new UAD report populate controlled cells with "0' +
      '" or "None"'
    State = cbUnchecked
    TabOrder = 2
    Transparent = True
  end
end
