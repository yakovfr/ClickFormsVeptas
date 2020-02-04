object ApprWorldRegister: TApprWorldRegister
  Left = 847
  Top = 185
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'AppraisalWord / Appraisal Express Orders Login'
  ClientHeight = 143
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = OnformCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 110
    Height = 13
    Caption = 'AppraisalWorld User ID'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 120
    Height = 13
    Caption = 'AppraisalWorld Password'
  end
  object edtAWID: TEdit
    Left = 16
    Top = 24
    Width = 297
    Height = 21
    TabOrder = 0
  end
  object edtAWPsw: TEdit
    Left = 16
    Top = 72
    Width = 297
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 40
    Top = 168
    Width = 1
    Height = 17
    Caption = 'Button1'
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 352
    Top = 16
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = OnOkBtnclick
  end
  object btnCancel: TButton
    Left = 352
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object chbSaveCredentials: TCheckBox
    Left = 16
    Top = 112
    Width = 177
    Height = 17
    Caption = 'Save my User ID and Password'
    TabOrder = 5
  end
end
