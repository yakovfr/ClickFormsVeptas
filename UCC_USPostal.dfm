object USPostalService: TUSPostalService
  Left = 340
  Top = 107
  Width = 1068
  Height = 733
  Caption = 'Verify Address with US Postal Service'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 1052
    Height = 645
    Align = alClient
    TabOrder = 0
    object TempWebBrowser: TWebBrowser
      Left = 1
      Top = 1
      Width = 1050
      Height = 643
      Align = alClient
      TabOrder = 0
      OnDownloadComplete = TempWebBrowserDownloadComplete
      ControlData = {
        4C000000E8400000CA2700000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1052
    Height = 49
    Align = alTop
    TabOrder = 1
    object LabelMsg: TLabel
      Left = 8
      Top = 16
      Width = 737
      Height = 17
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object btnCancel: TButton
      Left = 912
      Top = 12
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 816
      Top = 12
      Width = 75
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 1
    end
  end
end
