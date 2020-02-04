object TempLic: TTempLic
  Left = 433
  Top = 216
  Width = 343
  Height = 194
  ActiveControl = edtLicName
  Caption = 'Temporary Evaluation License'
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
    Left = 16
    Top = 16
    Width = 257
    Height = 13
    Caption = 'Enter your name as you want it to appear on the forms.'
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 126
    Height = 13
    Caption = 'Enter your company name.'
  end
  object btnCancel: TButton
    Left = 247
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 151
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object edtLicName: TEdit
    Left = 16
    Top = 32
    Width = 305
    Height = 21
    TabOrder = 2
  end
  object edtCompany: TEdit
    Left = 16
    Top = 80
    Width = 305
    Height = 21
    TabOrder = 3
  end
end
