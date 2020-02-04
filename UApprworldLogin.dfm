object AW_UserLogin: TAW_UserLogin
  Left = 775
  Top = 191
  Width = 514
  Height = 153
  Caption = 'Valuation Specialist Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 28
    Width = 110
    Height = 13
    Caption = 'AppraisalWorld UserID:'
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 120
    Height = 13
    Caption = 'AppraisalWorld Password'
  end
  object TLabel
    Left = 24
    Top = 45
    Width = 93
    Height = 13
    Caption = '(your email address)'
  end
  object btnLogin: TButton
    Left = 400
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object BtnCancel: TButton
    Left = 400
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object edtUserID: TEdit
    Left = 152
    Top = 27
    Width = 217
    Height = 21
    TabOrder = 0
  end
  object edtUserPSW: TEdit
    Left = 152
    Top = 68
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnKeyDown = edtUserPSWKeyDown
  end
end
