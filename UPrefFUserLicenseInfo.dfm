object PrefUserLicenseInfo: TPrefUserLicenseInfo
  Left = 0
  Top = 0
  Width = 585
  Height = 318
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object lbxUserList: TRzListBox
    Left = 8
    Top = 48
    Width = 193
    Height = 193
    Align = alCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = lbxUserListClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    Caption = '   License and Certification Information'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object rbtnUseCert: TRadioButton
    Left = 209
    Top = 86
    Width = 185
    Height = 17
    Caption = 'Use:  Appraisal Certification No.'
    TabOrder = 2
    OnClick = SelectLicTypeClick
  end
  object edtCertSt1: TEdit
    Left = 248
    Top = 110
    Width = 29
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 3
    OnKeyDown = RegInfoChanged
  end
  object edtCertSt3: TEdit
    Left = 248
    Top = 158
    Width = 29
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 4
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertSt2: TEdit
    Left = 248
    Top = 134
    Width = 29
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 5
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertNo3: TEdit
    Left = 336
    Top = 159
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 6
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertNo2: TEdit
    Left = 336
    Top = 135
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 7
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertNo1: TEdit
    Left = 336
    Top = 111
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 8
    OnKeyDown = RegInfoChanged
  end
  object edtCertExp3: TEdit
    Left = 503
    Top = 158
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 9
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertExp2: TEdit
    Left = 503
    Top = 134
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 10
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtCertExp1: TEdit
    Left = 503
    Top = 110
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 11
    OnKeyDown = RegInfoChanged
  end
  object rbtnUseLic: TRadioButton
    Left = 209
    Top = 191
    Width = 161
    Height = 17
    Caption = 'Use:  Appraisal License No.'
    TabOrder = 12
    OnClick = SelectLicTypeClick
  end
  object edtLicSt3: TEdit
    Left = 248
    Top = 264
    Width = 31
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 13
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicSt2: TEdit
    Left = 248
    Top = 239
    Width = 30
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 14
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicSt1: TEdit
    Left = 248
    Top = 215
    Width = 30
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 7
    TabOrder = 15
    OnKeyDown = RegInfoChanged
  end
  object edtLicNo3: TEdit
    Left = 336
    Top = 264
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 16
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicNo2: TEdit
    Left = 336
    Top = 239
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 17
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicNo1: TEdit
    Left = 336
    Top = 215
    Width = 113
    Height = 21
    MaxLength = 31
    TabOrder = 18
    OnKeyDown = RegInfoChanged
  end
  object edtLicExp3: TEdit
    Left = 503
    Top = 264
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 19
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicExp2: TEdit
    Left = 503
    Top = 239
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 20
    Visible = False
    OnKeyDown = RegInfoChanged
  end
  object edtLicExp1: TEdit
    Left = 503
    Top = 215
    Width = 69
    Height = 21
    MaxLength = 11
    TabOrder = 21
    OnKeyDown = RegInfoChanged
  end
  object StaticText1: TStaticText
    Left = 208
    Top = 48
    Width = 361
    Height = 34
    AutoSize = False
    Caption = 'Please enter your Appraisal License or Certification information'
    TabOrder = 22
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 256
    Width = 177
    Height = 57
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Note: Changes will take effect when you restart ClickFORMS or sw' +
      'itch active users '
    TabOrder = 23
  end
  object lblCertSt1: TStaticText
    Left = 211
    Top = 112
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 24
  end
  object lblCertSt2: TStaticText
    Left = 211
    Top = 136
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 25
    Visible = False
  end
  object lblCertSt3: TStaticText
    Left = 211
    Top = 160
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 26
    Visible = False
  end
  object lblCertNo1: TStaticText
    Left = 284
    Top = 112
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Cert No.'
    TabOrder = 27
  end
  object lblCertNo2: TStaticText
    Left = 284
    Top = 136
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Cert No.'
    TabOrder = 28
    Visible = False
  end
  object lblCertNo3: TStaticText
    Left = 284
    Top = 160
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Cert No.'
    TabOrder = 29
    Visible = False
  end
  object lblCertExp1: TStaticText
    Left = 454
    Top = 112
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 30
  end
  object lblCertExp2: TStaticText
    Left = 454
    Top = 136
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 31
    Visible = False
  end
  object lblCertExp3: TStaticText
    Left = 454
    Top = 160
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 32
    Visible = False
  end
  object lblLicExp1: TStaticText
    Left = 454
    Top = 216
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 33
  end
  object lblLicExp2: TStaticText
    Left = 454
    Top = 240
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 34
    Visible = False
  end
  object lblLicExp3: TStaticText
    Left = 454
    Top = 264
    Width = 48
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expires'
    TabOrder = 35
    Visible = False
  end
  object lblLicNo1: TStaticText
    Left = 284
    Top = 216
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Lic. No.'
    TabOrder = 36
  end
  object lblLicNo2: TStaticText
    Left = 284
    Top = 240
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Lic. No.'
    TabOrder = 37
    Visible = False
  end
  object lblLicNo3: TStaticText
    Left = 284
    Top = 264
    Width = 51
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Lic. No.'
    TabOrder = 38
    Visible = False
  end
  object lblLicSt1: TStaticText
    Left = 211
    Top = 216
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 39
  end
  object lblLicSt2: TStaticText
    Left = 211
    Top = 240
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 40
    Visible = False
  end
  object lblLicSt3: TStaticText
    Left = 211
    Top = 264
    Width = 33
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'State'
    TabOrder = 41
    Visible = False
  end
end
