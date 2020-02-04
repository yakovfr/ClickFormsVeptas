object PortCensus: TPortCensus
  Left = 277
  Top = 71
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Find Census Tract'
  ClientHeight = 62
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelMsg: TLabel
    Left = 73
    Top = 17
    Width = 296
    Height = 31
    AutoSize = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 64
    Top = 8
    Width = 313
    Height = 47
  end
  object TempWebBrowser: TWebBrowser
    Left = 8
    Top = 81
    Width = 161
    Height = 48
    TabOrder = 0
    OnDownloadComplete = TempWebBrowserDownloadComplete
    ControlData = {
      4C000000A4100000F60400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object AnimateProgress: TAnimate
    Left = 7
    Top = 9
    Width = 48
    Height = 45
    StopFrame = 8
  end
end
