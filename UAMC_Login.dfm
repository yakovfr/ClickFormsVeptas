object AMCCredentialsForm: TAMCCredentialsForm
  Left = 621
  Top = 186
  Width = 563
  Height = 255
  Align = alClient
  AutoSize = True
  Caption = 'OIFInfo.Services.Service[0].Name)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 120
  TextHeight = 16
  object VendorIdLabel: TLabel
    Left = 54
    Top = 23
    Width = 63
    Height = 16
    AutoSize = False
    Caption = 'Vendor ID:'
  end
  object Label1: TLabel
    Left = 69
    Top = 63
    Width = 48
    Height = 16
    AutoSize = False
    Caption = 'User ID:'
  end
  object Label2: TLabel
    Left = 26
    Top = 103
    Width = 95
    Height = 16
    AutoSize = False
    Caption = 'User Password:'
  end
  object editVendorId: TEdit
    Left = 142
    Top = 16
    Width = 188
    Height = 21
    TabOrder = 0
  end
  object btnRecord: TButton
    Left = 393
    Top = 27
    Width = 91
    Height = 31
    Caption = 'OK'
    TabOrder = 3
    OnClick = btnRecordClick
  end
  object editUserID: TEdit
    Left = 142
    Top = 55
    Width = 188
    Height = 21
    TabOrder = 1
  end
  object editUserPassword: TEdit
    Left = 142
    Top = 95
    Width = 188
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 393
    Top = 89
    Width = 91
    Height = 30
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
