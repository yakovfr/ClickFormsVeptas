object SignatureSetup: TSignatureSetup
  Left = 405
  Top = 188
  BorderStyle = bsDialog
  Caption = 'Affix and Remove Report Signatures'
  ClientHeight = 279
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object SignatureDisplay: TImage
    Left = 24
    Top = 157
    Width = 369
    Height = 100
    Proportional = True
    Stretch = True
  end
  object lblNote: TLabel
    Left = 32
    Top = 144
    Width = 3
    Height = 13
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 14
    Top = 11
    Width = 58
    Height = 13
    Caption = 'Select User:'
  end
  object Label2: TLabel
    Left = 14
    Top = 44
    Width = 63
    Height = 13
    Caption = 'Select Action'
  end
  object lblPswNotice: TLabel
    Left = 25
    Top = 140
    Width = 153
    Height = 13
    Caption = 'Signature is Password Protected'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object cbxUserActions: TComboBox
    Left = 82
    Top = 41
    Width = 315
    Height = 21
    AutoDropDown = True
    ItemHeight = 13
    TabOrder = 0
    Text = 'Affix Signature as Appraiser'
    OnChange = cbxUserActionsChange
    Items.Strings = (
      'No Signature Options Available')
  end
  object chkLockIt: TCheckBox
    Left = 16
    Top = 93
    Width = 433
    Height = 17
    Caption = 'Lock the report upon affixing signature'
    TabOrder = 2
    OnClick = chkLockItClick
  end
  object chkAllowSignatures: TCheckBox
    Left = 40
    Top = 113
    Width = 353
    Height = 17
    Caption = 'Allow additional signatures after locking report'
    Enabled = False
    TabOrder = 3
  end
  object btnClose: TButton
    Left = 414
    Top = 221
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 4
  end
  object btnDoIt: TButton
    Left = 414
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Affix'
    TabOrder = 5
    OnClick = btnDoItClick
  end
  object btnSetup: TButton
    Left = 414
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Setup'
    TabOrder = 6
    OnClick = btnSetupClick
  end
  object cbxUserList: TComboBox
    Left = 82
    Top = 8
    Width = 315
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Text = 'cbxUserList'
    OnChange = SwitchUsers
  end
  object chkPassword: TRzCheckBox
    Left = 416
    Top = 116
    Width = 73
    Height = 49
    AlignmentVertical = avCenter
    Caption = 'Password Protect Signature'
    State = cbUnchecked
    TabOrder = 8
    OnClick = chkPasswordClick
  end
  object chkDateIt: TCheckBox
    Left = 16
    Top = 73
    Width = 425
    Height = 17
    Caption = 'Sign with today'#39's date'
    TabOrder = 1
    OnClick = chkDateItClick
  end
end
