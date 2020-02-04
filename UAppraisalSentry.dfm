object AppraisalSentry: TAppraisalSentry
  Left = 328
  Top = 263
  Width = 450
  Height = 297
  Caption = 'Appraisal Sentry Registration'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 120
    Width = 59
    Height = 13
    Caption = 'User Name :'
  end
  object Label2: TLabel
    Left = 103
    Top = 147
    Width = 52
    Height = 13
    Caption = 'Password :'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 222
    Width = 425
    Height = 2
  end
  object Image1: TImage
    Left = -1
    Top = 0
    Width = 441
    Height = 105
  end
  object Image2: TImage
    Left = 11
    Top = 202
    Width = 17
    Height = 17
    Transparent = True
    Visible = False
  end
  object Label3: TLabel
    Left = 32
    Top = 204
    Width = 3
    Height = 13
    Visible = False
  end
  object EditUserName: TEdit
    Left = 160
    Top = 118
    Width = 184
    Height = 21
    TabOrder = 0
  end
  object ButtonProtect: TButton
    Left = 335
    Top = 232
    Width = 97
    Height = 25
    Caption = '&Register Appraisal'
    TabOrder = 2
    OnClick = ButtonProtectClick
  end
  object EditPassword: TEdit
    Left = 160
    Top = 144
    Width = 184
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object ButtonCancel: TButton
    Left = 255
    Top = 232
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'PDF'
    Filter = 'PDF File|*.PDF'
    Left = 376
    Top = 120
  end
end
