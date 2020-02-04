object CompRanking: TCompRanking
  Left = 280
  Top = 110
  Width = 625
  Height = 622
  Caption = 'Set Ranking'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTitleRating: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 30
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 8
      Top = 7
      Width = 64
      Height = 13
      Caption = 'Characteristic'
    end
    object Label6: TLabel
      Left = 89
      Top = 7
      Width = 19
      Height = 13
      Caption = 'Use'
    end
    object Label7: TLabel
      Left = 127
      Top = 7
      Width = 20
      Height = 13
      Caption = 'Low'
    end
    object Label8: TLabel
      Left = 493
      Top = 7
      Width = 22
      Height = 13
      Caption = 'High'
    end
    object Label9: TLabel
      Left = 204
      Top = 7
      Width = 213
      Height = 13
      Caption = 'Importance that Characteristic Match Subject'
    end
    object RzSeparator1: TRzSeparator
      Left = 80
      Top = 0
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator2: TRzSeparator
      Left = 114
      Top = 0
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
  end
  object PanelProx: TPanel
    Left = 0
    Top = 30
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    Color = clGradientInactiveCaption
    TabOrder = 1
    object StaticText2: TLabel
      Left = 22
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Proximity'
    end
    object RzSeparator7: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator6: TRzSeparator
      Left = 112
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxDistInclude: TCheckBox
      Tag = 1
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object tbProx: TRzTrackBar
      Tag = 1
      Left = 116
      Top = 3
      Width = 45
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
      Visible = False
    end
    object SliderProx: TTrackBar2
      Tag = 1
      Left = 126
      Top = 5
      Width = 400
      Height = 25
      Max = 20
      TrackColor = clMenu
      PositionL = 1
      ThumbColor = clHighlight
      SecondThumb = True
      TabOrder = 2
    end
  end
  object PanelSaleDate: TPanel
    Left = 0
    Top = 71
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    Color = clGradientInactiveCaption
    TabOrder = 2
    object lblDate: TLabel
      Left = 14
      Top = 12
      Width = 59
      Height = 13
      Caption = 'Date of Sale'
    end
    object RzSeparator12: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator11: TRzSeparator
      Left = 112
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxSDateInclude: TCheckBox
      Tag = 2
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object tbSaleDate: TRzTrackBar
      Tag = 2
      Left = 564
      Top = 3
      Width = 21
      Height = 33
      Min = 1
      Orientation = orVertical
      Position = 10
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
      Visible = False
    end
    object SliderSalesDate: TTrackBar2
      Tag = 2
      Left = 126
      Top = 9
      Width = 400
      Height = 25
      Max = 20
      TrackColor = clMenu
      PositionL = 1
      ThumbColor = clHighlight
      SecondThumb = True
      TabOrder = 2
    end
  end
  object PanelGLA: TPanel
    Left = 0
    Top = 112
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 3
    object Label15: TLabel
      Left = 14
      Top = 12
      Width = 58
      Height = 13
      Caption = 'Grs Liv Area'
    end
    object RzSeparator17: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator16: TRzSeparator
      Left = 112
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxGLAInclude: TCheckBox
      Tag = 3
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object tbGLA: TRzTrackBar
      Tag = 3
      Left = 570
      Top = 3
      Width = 23
      Height = 33
      Min = 1
      Orientation = orVertical
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
      Visible = False
    end
    object SliderGLA: TTrackBar2
      Tag = 3
      Left = 126
      Top = 5
      Width = 400
      Height = 25
      Max = 20
      TrackColor = clMenu
      PositionL = 1
      ThumbColor = clHighlight
      SecondThumb = True
      TabOrder = 2
      OnChange = SliderGLAChange
    end
  end
  object PanelBGLA: TPanel
    Left = 0
    Top = 153
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 4
    object Label17: TLabel
      Left = 14
      Top = 12
      Width = 48
      Height = 13
      Caption = 'Bsmt Area'
    end
    object RzSeparator22: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator21: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxBsmtInclude: TCheckBox
      Tag = 4
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbBGLA: TRzTrackBar
      Tag = 4
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelSite: TPanel
    Left = 0
    Top = 194
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 5
    object Label19: TLabel
      Left = 14
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Site Area'
    end
    object RzSeparator27: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator26: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxSiteInclude: TCheckBox
      Tag = 5
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbSite: TRzTrackBar
      Tag = 5
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelAge: TPanel
    Left = 0
    Top = 235
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 6
    object Label22: TLabel
      Left = 14
      Top = 12
      Width = 19
      Height = 13
      Caption = 'Age'
    end
    object RzSeparator32: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator31: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxAgeInclude: TCheckBox
      Tag = 6
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbAge: TRzTrackBar
      Tag = 6
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelStory: TPanel
    Left = 0
    Top = 276
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 7
    object Label4: TLabel
      Left = 14
      Top = 12
      Width = 32
      Height = 13
      Caption = 'Stories'
    end
    object RzSeparator4: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator5: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxStoryInclude: TCheckBox
      Tag = 12
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbStory: TRzTrackBar
      Tag = 12
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelBeds: TPanel
    Left = 0
    Top = 317
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 8
    object Label24: TLabel
      Left = 14
      Top = 12
      Width = 47
      Height = 13
      Caption = 'Bedrooms'
    end
    object RzSeparator37: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator36: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxBedRmInclude: TCheckBox
      Tag = 7
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbBeds: TRzTrackBar
      Tag = 7
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelBaths: TPanel
    Left = 0
    Top = 358
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 9
    object Label26: TLabel
      Left = 14
      Top = 12
      Width = 50
      Height = 13
      Caption = 'Bathrooms'
    end
    object RzSeparator42: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator41: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxBathInclude: TCheckBox
      Tag = 8
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbBaths: TRzTrackBar
      Tag = 8
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelFireplace: TPanel
    Left = 0
    Top = 399
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 10
    object Label28: TLabel
      Left = 14
      Top = 12
      Width = 48
      Height = 13
      Caption = 'Fireplaces'
    end
    object RzSeparator47: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator46: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxFirePlInclude: TCheckBox
      Tag = 9
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbFirePl: TRzTrackBar
      Tag = 9
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelCars: TPanel
    Left = 0
    Top = 440
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 11
    object Label31: TLabel
      Left = 14
      Top = 12
      Width = 56
      Height = 13
      Caption = 'Car Storage'
    end
    object RzSeparator52: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator51: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxCarInclude: TCheckBox
      Tag = 10
      Left = 90
      Top = 11
      Width = 23
      Height = 17
      TabOrder = 0
    end
    object tbCars: TRzTrackBar
      Tag = 10
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object PanelPool: TPanel
    Left = 0
    Top = 481
    Width = 617
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 12
    object Label33: TLabel
      Left = 14
      Top = 12
      Width = 21
      Height = 13
      Caption = 'Pool'
    end
    object RzSeparator57: TRzSeparator
      Left = 78
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object RzSeparator56: TRzSeparator
      Left = 114
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object cbxPoolInclude: TCheckBox
      Tag = 11
      Left = 89
      Top = 11
      Width = 21
      Height = 17
      TabOrder = 0
    end
    object tbPool: TRzTrackBar
      Tag = 11
      Left = 116
      Top = 3
      Width = 333
      Height = 33
      Min = 1
      Position = 5
      ThumbStyle = tsBox
      TickColor = clBlack
      TrackOffset = 12
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 528
    Width = 617
    Height = 66
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 13
    object btnOK: TButton
      Left = 324
      Top = 16
      Width = 75
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 455
      Top = 16
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
