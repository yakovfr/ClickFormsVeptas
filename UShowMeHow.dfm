object ShowMeHow: TShowMeHow
  Left = 296
  Top = 157
  Width = 962
  Height = 634
  Caption = 'ClickFORMS: Show Me How '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowserMain: TWebBrowser
    Left = 0
    Top = 41
    Width = 946
    Height = 554
    Align = alClient
    TabOrder = 0
    OnDownloadBegin = WebBrowserMainDownloadBegin
    OnDownloadComplete = WebBrowserMainDownloadComplete
    ControlData = {
      4C000000C6610000423900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 946
    Height = 41
    Align = alTop
    TabOrder = 1
    object PanelProgress: TPanel
      Left = 903
      Top = 1
      Width = 42
      Height = 39
      Align = alRight
      BevelOuter = bvLowered
      TabOrder = 0
      object AnimateProgress: TAnimate
        Left = 1
        Top = 1
        Width = 40
        Height = 37
        Align = alClient
        StopFrame = 8
      end
    end
  end
end
