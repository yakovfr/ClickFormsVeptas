object PrefAutoUpdateFrame: TPrefAutoUpdateFrame
  Left = 0
  Top = 0
  Width = 255
  Height = 104
  TabOrder = 0
  object chkEnableAutoUpdates: TCheckBox
    Left = 19
    Top = 48
    Width = 180
    Height = 21
    Caption = '&Enable Automatic Updates.'
    TabOrder = 0
  end
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 255
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   Auto Updating'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
