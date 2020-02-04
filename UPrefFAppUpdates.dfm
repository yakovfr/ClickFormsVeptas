object PrefAppUpdates: TPrefAppUpdates
  Left = 0
  Top = 0
  Width = 399
  Height = 241
  TabOrder = 0
  object btnCheckForUpdateNow: TButton
    Left = 232
    Top = 53
    Width = 121
    Height = 25
    Action = Main.HelpCheckForUpdatesCmd
    TabOrder = 0
  end
  object rdoCheckUpdateFreq: TRzRadioGroup
    Left = 16
    Top = 48
    Width = 169
    Height = 121
    BorderColor = clWhite
    Caption = 'Check for Updates:'
    FlatColor = clBtnHighlight
    ItemFrameColor = clBtnFace
    ItemHighlightColor = clBtnFace
    Items.Strings = (
      'Once Every Day'
      'Once Every Week'
      'Once Every Two Weeks'
      'Once Every Month')
    TextShadowColor = clNone
    TabOrder = 1
    Transparent = True
    VerticalSpacing = 7
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 399
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Auto Updates'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
end
