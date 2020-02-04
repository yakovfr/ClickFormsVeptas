object AMCAcknowForm: TAMCAcknowForm
  Left = 551
  Top = 169
  Width = 462
  Height = 209
  Caption = 'Order Retrieval'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbLogin: TGroupBox
    Left = 0
    Top = 0
    Width = 446
    Height = 173
    Align = alClient
    Caption = 'Retrieve Order'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 327
      Top = 51
      Width = 42
      Height = 13
      Caption = 'User ID'
    end
    object Label2: TLabel
      Left = 307
      Top = 92
      Width = 83
      Height = 13
      Caption = 'User Password'
    end
    object lblOrderNum: TLabel
      Left = 264
      Top = 11
      Width = 169
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Order Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSvcPhone: TLabel
      Left = 12
      Top = 106
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Phone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblSvcFax: TLabel
      Left = 141
      Top = 106
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fax'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtUserPSW: TEdit
      Left = 264
      Top = 107
      Width = 169
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 2
      OnChange = edtUserPSWChange
    end
    object bbtnOK: TBitBtn
      Left = 264
      Top = 135
      Width = 75
      Height = 25
      Caption = 'Get &Order'
      TabOrder = 3
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 358
      Top = 135
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 4
    end
    object edtUserID: TEdit
      Left = 264
      Top = 67
      Width = 169
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtUserIDChange
    end
    object edtSvcName: TEdit
      Tag = 5
      Left = 11
      Top = 27
      Width = 244
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'Nasoft USA'
    end
    object edtSvcAddr: TEdit
      Tag = 6
      Left = 11
      Top = 52
      Width = 244
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = '417 E. Carmel St, Suite 200'
    end
    object edtSvcCityStPC: TEdit
      Tag = 7
      Left = 11
      Top = 77
      Width = 244
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = 'San Marcos, CA 92078'
    end
    object edtSvcPhone: TEdit
      Tag = 8
      Left = 46
      Top = 102
      Width = 92
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = '(760) 410-1210'
    end
    object edtSvcFax: TEdit
      Tag = 9
      Left = 163
      Top = 102
      Width = 92
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Text = '(760) 410-1230'
    end
    object edtSvcEmail: TEdit
      Tag = 10
      Left = 11
      Top = 127
      Width = 244
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = 'www.nasoft.com'
    end
    object edtOrderNum: TEdit
      Left = 264
      Top = 27
      Width = 169
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 30
      ParentFont = False
      TabOrder = 0
      OnChange = edtUserIDChange
    end
  end
end
