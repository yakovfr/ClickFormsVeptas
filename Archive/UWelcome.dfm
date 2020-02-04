object SelectWorkMode: TSelectWorkMode
  Left = 598
  Top = 188
  Width = 514
  Height = 232
  ActiveControl = btnEvaluate
  Caption = 'Welcome to the AgWare UAAR Report Processor'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Title: TLabel
    Left = 56
    Top = 8
    Width = 395
    Height = 20
    Alignment = taCenter
    Caption = 'Welcome to the AgWare UAAR Report Processor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnRegister: TButton
    Left = 32
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Register'
    TabOrder = 0
    OnClick = btnRegisterClick
  end
  object btnEvaluate: TButton
    Left = 216
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Evaluate'
    TabOrder = 1
    OnClick = btnEvaluateClick
  end
  object btnCancel: TButton
    Left = 400
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Memo: TMemo
    Left = 32
    Top = 40
    Width = 449
    Height = 113
    BorderStyle = bsNone
    Lines.Strings = (
      
        'Welcome to the AgWare UAAR Report Processor. This software is cu' +
        'rrently in EVALUATION '
      
        'mode. It is fully functional and may be used 15 times. If you wo' +
        'uld like to continue working '
      
        'with it after the evaluation period, you must register and unloc' +
        'k the software.'
      ''
      
        'To evaluate the software, click on the Evaluate button and enter' +
        ' your name and company '
      'name EXACTLY as you want them to appear on the forms.'
      ''
      'Thank you for using the AgWare UAAR Report Processor. ')
    ReadOnly = True
    TabOrder = 3
  end
end
