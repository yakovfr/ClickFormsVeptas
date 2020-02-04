object DemoAnnounce: TDemoAnnounce
  Left = 379
  Top = 206
  Width = 539
  Height = 276
  Caption = 'Notice: Program In Evaluation Mode'
  Color = 14594445
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 188
    Top = 16
    Width = 135
    Height = 25
    Caption = 'AgWare2000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 224
    Top = 48
    Width = 62
    Height = 13
    Caption = 'Version #.##'
  end
  object Label3: TLabel
    Left = 48
    Top = 80
    Width = 421
    Height = 16
    Caption = 'AgWare2000 is in a 30 day "fully functional" evaluation mode.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 72
    Top = 116
    Width = 330
    Height = 16
    Caption = '- To continue the evaluation click the EVALUATE button.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 72
    Top = 140
    Width = 389
    Height = 16
    Caption = 
      '- To unlock the program for further use, click the REGISTER Butt' +
      'on'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnRegister: TButton
    Left = 20
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Register'
    ModalResult = 6
    TabOrder = 0
  end
  object btnEval: TButton
    Left = 228
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Evaluate'
    ModalResult = 7
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 432
    Top = 204
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
