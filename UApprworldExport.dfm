object ApprWorldExport: TApprWorldExport
  Left = 629
  Top = 256
  Width = 357
  Height = 247
  Caption = 'Appraisal World Export Report'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = OnFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 16
    Top = 128
    Width = 40
    Height = 13
    Caption = 'Order ID'
  end
  object rbgFileType: TRadioGroup
    Left = 56
    Top = 8
    Width = 241
    Height = 97
    Caption = 'File to Send'
    Items.Strings = (
      'Report  ClickForms Format (*.clk)'
      'Report Adobe PDF Format (*.pdf)'
      'Invoice Adobe PDF Format (*.pdf)')
    TabOrder = 0
  end
  object btnSend: TButton
    Left = 24
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    TabOrder = 1
    OnClick = btnSendClick
  end
  object btnCancel: TButton
    Left = 232
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = OnCancel
  end
  object edtOrderID: TEdit
    Left = 72
    Top = 120
    Width = 217
    Height = 21
    TabOrder = 3
    OnChange = OnOrderIDChanged
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 189
    Width = 349
    Height = 24
    Panels = <>
    SimplePanel = True
  end
  object OpenDialog: TOpenDialog
    Left = 288
    Top = 48
  end
end
