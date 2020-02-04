object AMCLogin: TAMCLogin
  Left = 570
  Top = 512
  Width = 457
  Height = 264
  Caption = 'AMC Portal Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = OnFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 13
    Width = 81
    Height = 13
    AutoSize = False
    Caption = 'User ID'
  end
  object Label2: TLabel
    Left = 15
    Top = 49
    Width = 81
    Height = 13
    AutoSize = False
    Caption = 'User Password'
  end
  object Label3: TLabel
    Left = 15
    Top = 85
    Width = 81
    Height = 13
    AutoSize = False
    Caption = 'Order ID'
  end
  object edtUserID: TEdit
    Left = 105
    Top = 8
    Width = 230
    Height = 24
    TabOrder = 0
    OnChange = OnEditChanged
  end
  object edtPassword: TEdit
    Left = 105
    Top = 44
    Width = 230
    Height = 24
    PasswordChar = 'x'
    TabOrder = 1
    OnChange = OnEditChanged
  end
  object edtOrderID: TEdit
    Left = 105
    Top = 80
    Width = 230
    Height = 24
    TabOrder = 2
    OnChange = OnEditChanged
  end
  object btnOK: TButton
    Left = 49
    Top = 129
    Width = 75
    Height = 26
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = OnLoginclick
  end
  object btnCancel: TButton
    Left = 249
    Top = 129
    Width = 75
    Height = 26
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object btnSave: TButton
    Left = 145
    Top = 129
    Width = 75
    Height = 26
    Caption = 'Save'
    TabOrder = 5
    OnClick = OnSaveClick
  end
end
