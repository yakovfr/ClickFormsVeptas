object ReadMe: TReadMe
  Left = 151
  Top = 3
  Width = 903
  Height = 726
  Caption = 'ClickFORMS What'#39's New'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 887
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      887
      41)
    object btnClose: TButton
      Left = 714
      Top = 8
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Ok, I'#39've read What'#39's New'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 41
    Width = 887
    Height = 646
    Align = alClient
    TabOrder = 1
    ControlData = {
      4C000000AD5B0000C44200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
