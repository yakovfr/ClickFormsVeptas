object PrefDocPrinting: TPrefDocPrinting
  Left = 0
  Top = 0
  Width = 472
  Height = 236
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object ckbPrGrayTitle: TCheckBox
    Tag = 5
    Left = 18
    Top = 44
    Width = 241
    Height = 17
    Caption = 'Print Form Section Titles in Light Gray'
    TabOrder = 0
  end
  object ckbPrInfoCells: TCheckBox
    Tag = 6
    Left = 18
    Top = 77
    Width = 290
    Height = 17
    Caption = 'Print Information Fields (i.e. Net/Gross values)'
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Printing'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
end
