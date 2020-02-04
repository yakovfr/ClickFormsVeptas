object PhoenixMobileLogin: TPhoenixMobileLogin
  Left = 495
  Top = 117
  Width = 351
  Height = 272
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'PhoenixMobile Login'
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
  object Label1: TLabel
    Left = 31
    Top = 64
    Width = 25
    Height = 13
    Caption = 'Email'
  end
  object Label2: TLabel
    Left = 11
    Top = 100
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object label3: TLabel
    Left = 42
    Top = 15
    Width = 255
    Height = 13
    AutoSize = False
    Caption = 'Please enter your PhoenixMobile account information'
  end
  object edtEmail: TEdit
    Left = 65
    Top = 59
    Width = 209
    Height = 24
    AutoSize = False
    TabOrder = 3
    OnChange = OnUserInput
  end
  object edtPassword: TEdit
    Left = 65
    Top = 94
    Width = 209
    Height = 24
    AutoSize = False
    PasswordChar = 'x'
    TabOrder = 4
    OnChange = OnUserInput
  end
  object btnGo: TButton
    Left = 39
    Top = 183
    Width = 75
    Height = 24
    Caption = '&Go'
    TabOrder = 0
    OnClick = btnGoClick
  end
  object btnCancel: TButton
    Left = 135
    Top = 183
    Width = 75
    Height = 24
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object fldRememberMe: TCheckBox
    Left = 122
    Top = 142
    Width = 105
    Height = 17
    Caption = 'Save Password'
    TabOrder = 5
  end
  object btnHelp: TButton
    Left = 225
    Top = 183
    Width = 75
    Height = 24
    Caption = '&Help'
    TabOrder = 2
    OnClick = btnHelpClick
  end
end
