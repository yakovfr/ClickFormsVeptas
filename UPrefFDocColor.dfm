object PrefDocColor: TPrefDocColor
  Left = 0
  Top = 0
  Width = 466
  Height = 314
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object clrHiliteCell: TShape
    Tag = 6
    Left = 23
    Top = 140
    Width = 41
    Height = 17
    OnMouseDown = ChangeColorMouseDown
  end
  object clrFormLines: TShape
    Tag = 2
    Left = 23
    Top = 108
    Width = 41
    Height = 17
    Brush.Color = 11627572
    OnMouseDown = ChangeColorMouseDown
  end
  object clrFormText: TShape
    Tag = 1
    Left = 23
    Top = 76
    Width = 41
    Height = 17
    Brush.Color = clGrayText
    OnMouseDown = ChangeColorMouseDown
  end
  object clrFreeText: TShape
    Tag = 4
    Left = 189
    Top = 108
    Width = 41
    Height = 17
    OnMouseDown = ChangeColorMouseDown
  end
  object clrInfoText: TShape
    Tag = 3
    Left = 189
    Top = 76
    Width = 41
    Height = 17
    OnMouseDown = ChangeColorMouseDown
  end
  object clrEmptyCell: TShape
    Tag = 5
    Left = 189
    Top = 140
    Width = 41
    Height = 17
    OnMouseDown = ChangeColorMouseDown
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 466
    Height = 33
    Align = alTop
    Style = bsRaised
  end
  object RzLabel1: TRzLabel
    Left = 16
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object clrFilledCell: TShape
    Tag = 7
    Left = 189
    Top = 172
    Width = 41
    Height = 17
    OnMouseDown = ChangeColorMouseDown
  end
  object clrUADCell: TShape
    Tag = 8
    Left = 23
    Top = 212
    Width = 41
    Height = 17
    Brush.Color = clMoneyGreen
    Visible = False
    OnMouseDown = ChangeColorMouseDown
  end
  object clrInvalidCell: TShape
    Tag = 9
    Left = 189
    Top = 212
    Width = 41
    Height = 17
    Brush.Color = 5614335
    Visible = False
    OnMouseDown = ChangeColorMouseDown
  end
  object btnSetColorDefault: TButton
    Left = 360
    Top = 71
    Width = 89
    Height = 25
    Caption = 'Use Defaults'
    TabOrder = 0
    OnClick = btnSetColorDefaultClick
  end
  object btnPreview: TButton
    Left = 360
    Top = 112
    Width = 89
    Height = 25
    Caption = 'Preview'
    TabOrder = 1
    OnClick = btnPreviewClick
  end
  object btnRevert: TButton
    Left = 360
    Top = 152
    Width = 89
    Height = 25
    Caption = 'Revert'
    TabOrder = 2
    OnClick = btnRevertClick
  end
  object StaticText1: TStaticText
    Left = 240
    Top = 142
    Width = 53
    Height = 17
    Caption = 'Empty Cell'
    TabOrder = 4
  end
  object StaticText2: TStaticText
    Left = 240
    Top = 110
    Width = 75
    Height = 17
    Caption = 'Free Form Text'
    TabOrder = 5
  end
  object StaticText3: TStaticText
    Left = 72
    Top = 110
    Width = 55
    Height = 17
    Caption = 'Form Lines'
    TabOrder = 6
  end
  object StaticText4: TStaticText
    Left = 16
    Top = 48
    Width = 186
    Height = 17
    Caption = 'Click the Color Box to change its color.'
    TabOrder = 7
  end
  object StaticText5: TStaticText
    Left = 16
    Top = 281
    Width = 244
    Height = 17
    Caption = 'Note: Hit the Revert button to Reset Default Colors'
    TabOrder = 8
  end
  object StaticText6: TStaticText
    Left = 240
    Top = 78
    Width = 80
    Height = 17
    Caption = 'Information Text'
    TabOrder = 9
  end
  object StaticText7: TStaticText
    Left = 72
    Top = 142
    Width = 77
    Height = 17
    Caption = 'Highlighted Cell'
    TabOrder = 10
  end
  object StaticText8: TStaticText
    Left = 72
    Top = 78
    Width = 51
    Height = 17
    Caption = 'Form Text'
    TabOrder = 11
  end
  object StaticText9: TStaticText
    Left = 240
    Top = 173
    Width = 72
    Height = 17
    Caption = 'Cell With Data'
    TabOrder = 12
  end
  object StaticText10: TStaticText
    Left = 72
    Top = 213
    Width = 47
    Height = 17
    Caption = 'UAD Cell'
    TabOrder = 13
    Visible = False
  end
  object StaticText11: TStaticText
    Left = 240
    Top = 213
    Width = 132
    Height = 17
    Caption = 'UAD Cell With Invalid Data'
    TabOrder = 14
    Visible = False
  end
  object CheckBoxUseUADCellColor: TCheckBox
    Left = 24
    Top = 238
    Width = 313
    Height = 17
    Caption = 'Maintain UAD Cell color even after cell has data.'
    TabOrder = 3
    Visible = False
  end
  object ColorDialog: TColorDialog
    Left = 364
    Top = 224
  end
end
