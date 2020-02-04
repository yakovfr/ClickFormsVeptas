object PasswordDlg: TPasswordDlg
  Left = 390
  Top = 186
  BorderStyle = bsDialog
  Caption = 'Enter Your Password'
  ClientHeight = 93
  ClientWidth = 368
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 18
    Width = 76
    Height = 13
    Caption = 'Enter password:'
  end
  object lblConfirm: TLabel
    Left = 8
    Top = 56
    Width = 84
    Height = 13
    Caption = 'Confirm Password'
  end
  object Password1: TEdit
    Left = 104
    Top = 15
    Width = 145
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 286
    Top = 13
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 286
    Top = 53
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Password2: TEdit
    Left = 104
    Top = 54
    Width = 145
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
end
