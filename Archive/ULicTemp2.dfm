object FreeLicInfo: TFreeLicInfo
  Left = 414
  Top = 214
  Width = 542
  Height = 291
  Caption = 'Temporary User License Setup'
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
  object pnlSetup: TPanel
    Left = 0
    Top = 0
    Width = 530
    Height = 255
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblYourName: TLabel
      Left = 280
      Top = 17
      Width = 231
      Height = 13
      Caption = 'Your name as you want it to appear on the forms.'
    end
    object lblCoName: TLabel
      Left = 280
      Top = 61
      Width = 140
      Height = 13
      Caption = 'Your company name on forms'
    end
    object lblName: TLabel
      Left = 12
      Top = 41
      Width = 28
      Height = 13
      Caption = 'Name'
    end
    object lblContactInfo: TLabel
      Left = 12
      Top = 17
      Width = 178
      Height = 13
      Caption = 'Please enter your contact information:'
    end
    object lblAddr: TLabel
      Left = 12
      Top = 70
      Width = 38
      Height = 13
      Caption = 'Address'
    end
    object lblCity: TLabel
      Left = 12
      Top = 97
      Width = 17
      Height = 13
      Caption = 'City'
    end
    object lblState: TLabel
      Left = 12
      Top = 121
      Width = 25
      Height = 13
      Caption = 'State'
    end
    object lblZip: TLabel
      Left = 96
      Top = 120
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = 'Zip/Postal Code'
    end
    object lblCountry: TLabel
      Left = 12
      Top = 145
      Width = 36
      Height = 13
      Caption = 'Country'
    end
    object lblPhone: TLabel
      Left = 12
      Top = 173
      Width = 31
      Height = 13
      Caption = 'Phone'
    end
    object lblFax: TLabel
      Left = 12
      Top = 196
      Width = 17
      Height = 13
      Caption = 'Fax'
    end
    object lblEMail: TLabel
      Left = 282
      Top = 100
      Width = 92
      Height = 13
      Caption = 'Your e-mail address'
    end
    object btnOk: TButton
      Left = 328
      Top = 200
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 432
      Top = 200
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object edtLicName: TEdit
      Left = 280
      Top = 38
      Width = 233
      Height = 21
      TabOrder = 2
    end
    object edtCompany: TEdit
      Left = 280
      Top = 77
      Width = 233
      Height = 21
      TabOrder = 3
    end
    object edtName: TEdit
      Left = 56
      Top = 38
      Width = 201
      Height = 21
      MaxLength = 63
      TabOrder = 4
    end
    object edtAddress: TEdit
      Left = 56
      Top = 66
      Width = 201
      Height = 21
      MaxLength = 63
      TabOrder = 5
    end
    object edtCity: TEdit
      Left = 56
      Top = 92
      Width = 201
      Height = 21
      MaxLength = 47
      TabOrder = 6
    end
    object edtState: TEdit
      Left = 56
      Top = 117
      Width = 33
      Height = 21
      MaxLength = 7
      TabOrder = 7
    end
    object edtZip: TEdit
      Left = 176
      Top = 117
      Width = 81
      Height = 21
      MaxLength = 15
      TabOrder = 8
    end
    object cbxCountry: TComboBox
      Left = 56
      Top = 142
      Width = 153
      Height = 21
      ItemHeight = 13
      TabOrder = 9
      Text = 'United States'
      Items.Strings = (
        'United States'
        'Canada'
        'Mexico'
        'Puerto Rico'
        'Bahamas'
        'Guam')
    end
    object edtPhone: TEdit
      Left = 56
      Top = 168
      Width = 149
      Height = 21
      MaxLength = 23
      TabOrder = 10
    end
    object edtFax: TEdit
      Left = 56
      Top = 193
      Width = 148
      Height = 21
      MaxLength = 23
      TabOrder = 11
    end
    object edtEMail: TEdit
      Left = 280
      Top = 117
      Width = 233
      Height = 21
      MaxLength = 63
      TabOrder = 12
    end
  end
end
