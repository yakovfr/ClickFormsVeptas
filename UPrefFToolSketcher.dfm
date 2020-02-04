object PrefToolSketcher: TPrefToolSketcher
  Left = 0
  Top = 0
  Width = 544
  Height = 228
  TabOrder = 0
  object SketchToolDefault: TRzRadioGroup
    Left = 15
    Top = 62
    Width = 362
    Height = 154
    BorderColor = clWhite
    Caption = 'SKETCHERS - Double-Clicking Cell Starts'
    FlatColor = clBtnHighlight
    Items.Strings = (
      'AreaSketch'
      'WinSketch'
      'Apex'
      'RapidSketch'
      'AreaSketch Special Edition')
    TabOrder = 0
    Transparent = True
    VerticalSpacing = 10
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Sketching Preference'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 40
    Width = 367
    Height = 17
    Caption = 
      'Specify which sketcher you want to start when you double-click a' +
      ' sketch cell'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
