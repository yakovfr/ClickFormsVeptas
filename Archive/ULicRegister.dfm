object Registration: TRegistration
  Left = 660
  Top = 199
  BorderStyle = bsDialog
  Caption = 'Software Registration'
  ClientHeight = 295
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrevNextClose: TPanel
    Left = 0
    Top = 254
    Width = 525
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 420
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnPrev: TButton
      Left = 16
      Top = 8
      Width = 81
      Height = 25
      Caption = '<<< Previous'
      TabOrder = 2
      OnClick = btnPrevClick
    end
    object btnNext: TButton
      Left = 104
      Top = 8
      Width = 81
      Height = 25
      Caption = 'Next >>>'
      TabOrder = 0
      OnClick = btnNextClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 525
    Height = 254
    ActivePage = PgContact
    Align = alClient
    TabOrder = 1
    TabWidth = 100
    object PgUserList: TTabSheet
      Caption = 'PgUserList'
      ImageIndex = 5
      TabVisible = False
      object lblSelectUser: TLabel
        Left = 24
        Top = 16
        Width = 218
        Height = 13
        Caption = 'Select the user to be registered and unlocked:'
      end
      object UserRegList: TStringGrid
        Left = 24
        Top = 40
        Width = 377
        Height = 177
        ColCount = 2
        DefaultColWidth = 175
        DefaultRowHeight = 18
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
        TabOrder = 0
        OnDblClick = UserRegListDblClick
      end
    end
    object PgContact: TTabSheet
      Caption = 'User Info'
      TabVisible = False
      object lblContactInfo: TLabel
        Left = 20
        Top = 5
        Width = 178
        Height = 13
        Caption = 'Please enter your contact information:'
      end
      object lblCompany: TLabel
        Left = 20
        Top = 56
        Width = 44
        Height = 13
        Caption = 'Company'
      end
      object lblAddress: TLabel
        Left = 20
        Top = 82
        Width = 38
        Height = 13
        Caption = 'Address'
      end
      object lblCity: TLabel
        Left = 20
        Top = 109
        Width = 17
        Height = 13
        Caption = 'City'
      end
      object lblState: TLabel
        Left = 246
        Top = 109
        Width = 44
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'State'
      end
      object lblZip: TLabel
        Left = 325
        Top = 109
        Width = 24
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Zip'
      end
      object lblPhone: TLabel
        Left = 20
        Top = 161
        Width = 31
        Height = 13
        Caption = 'Phone'
      end
      object lblFax: TLabel
        Left = 236
        Top = 160
        Width = 17
        Height = 13
        Caption = 'Fax'
      end
      object lblEMail: TLabel
        Left = 20
        Top = 213
        Width = 29
        Height = 13
        Caption = 'E-Mail'
      end
      object lblCellPhone: TLabel
        Left = 21
        Top = 186
        Width = 36
        Height = 13
        Caption = 'Cell Ph.'
      end
      object lblPager: TLabel
        Left = 232
        Top = 186
        Width = 28
        Height = 13
        Caption = 'Pager'
      end
      object lblCountry: TLabel
        Left = 20
        Top = 133
        Width = 36
        Height = 13
        Caption = 'Country'
      end
      object lblFirstName: TLabel
        Left = 14
        Top = 29
        Width = 50
        Height = 13
        Caption = 'First Name'
      end
      object lblLastName: TLabel
        Left = 223
        Top = 29
        Width = 20
        Height = 13
        Caption = 'Last'
      end
      object edtCompany: TEdit
        Left = 72
        Top = 52
        Width = 340
        Height = 21
        MaxLength = 99
        TabOrder = 2
        OnKeyDown = RegInfoChanged
      end
      object edtAddress: TEdit
        Left = 72
        Top = 78
        Width = 340
        Height = 21
        MaxLength = 63
        TabOrder = 3
        OnKeyDown = RegInfoChanged
      end
      object edtCity: TEdit
        Left = 72
        Top = 104
        Width = 171
        Height = 21
        MaxLength = 47
        TabOrder = 4
        OnKeyDown = RegInfoChanged
      end
      object edtState: TEdit
        Left = 293
        Top = 105
        Width = 30
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 5
        OnKeyDown = RegInfoChanged
      end
      object edtZip: TEdit
        Left = 352
        Top = 105
        Width = 60
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 6
        OnKeyDown = RegInfoChanged
      end
      object edtPhone: TEdit
        Left = 72
        Top = 156
        Width = 149
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 23
        TabOrder = 8
        OnKeyDown = RegInfoChanged
      end
      object edtFax: TEdit
        Left = 264
        Top = 157
        Width = 148
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 23
        TabOrder = 9
        OnKeyDown = RegInfoChanged
      end
      object edtEMail: TEdit
        Left = 72
        Top = 209
        Width = 339
        Height = 21
        MaxLength = 63
        TabOrder = 12
        OnKeyDown = RegInfoChanged
      end
      object edtCellPhone: TEdit
        Left = 72
        Top = 182
        Width = 149
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 23
        TabOrder = 10
        OnKeyDown = RegInfoChanged
      end
      object edtPager: TEdit
        Left = 264
        Top = 183
        Width = 148
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 23
        TabOrder = 11
        OnKeyDown = RegInfoChanged
      end
      object cbxCountry: TComboBox
        Left = 72
        Top = 130
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 7
        Text = 'United States'
        OnChange = InfoChanged
        Items.Strings = (
          'United States'
          'Canada'
          'Mexico')
      end
      object edtFirstName: TEdit
        Left = 72
        Top = 26
        Width = 145
        Height = 21
        MaxLength = 63
        TabOrder = 0
        OnChange = InfoChanged
      end
      object edtLastName: TEdit
        Left = 248
        Top = 26
        Width = 163
        Height = 21
        MaxLength = 63
        TabOrder = 1
        OnChange = InfoChanged
      end
    end
    object PgOrderNotice: TTabSheet
      Caption = 'PgOrderNotice'
      ImageIndex = 8
      TabVisible = False
      object lblRcvNotices: TLabel
        Left = 24
        Top = 24
        Width = 346
        Height = 13
        Caption = 
          'How would you like to receive notifications of a pending apprais' +
          'al orders?'
      end
      object lblNoticesByTextMsg: TLabel
        Left = 32
        Top = 56
        Width = 274
        Height = 13
        Caption = 'By Text Message:     Please enter your Cell Phone number'
      end
      object lblNoticesByEmail: TLabel
        Left = 32
        Top = 112
        Width = 380
        Height = 13
        Caption = 
          'By Email:     Please enter the Email Address where you receive o' +
          'rder notifications'
      end
      object edtTxMsgOrder: TEdit
        Left = 32
        Top = 72
        Width = 289
        Height = 21
        TabOrder = 0
        Text = 'edtTxMsgOrder'
        OnChange = InfoChanged
      end
      object edtEmailOrder: TEdit
        Left = 32
        Top = 128
        Width = 297
        Height = 21
        TabOrder = 1
        Text = 'edtEmailOrder'
        OnChange = InfoChanged
      end
    end
    object PgAWLogin: TTabSheet
      Caption = 'PgAWLogin'
      ImageIndex = 7
      TabVisible = False
      object lblEnterAWLogin: TLabel
        Left = 24
        Top = 24
        Width = 298
        Height = 13
        Caption = 'Please enter your AppraisalWorld Email Address and Password:'
      end
      object lblAWLogin: TLabel
        Left = 24
        Top = 56
        Width = 143
        Height = 13
        Caption = 'AppraisalWorld Email Address:'
      end
      object lblAWPassword: TLabel
        Left = 118
        Top = 88
        Width = 49
        Height = 13
        Caption = 'Password:'
      end
      object lblForgotPassword: TRzURLLabel
        Left = 113
        Top = 124
        Width = 130
        Height = 15
        AutoSize = False
        Caption = 'Forgot your password?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        URL = 'http://www.appraisalworld.com/AW/html/forgot_password.php'
      end
      object edtAWLogin: TEdit
        Left = 173
        Top = 56
        Width = 257
        Height = 21
        TabOrder = 0
      end
      object edtAWPassword: TEdit
        Left = 173
        Top = 88
        Width = 257
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
      object cbSaveAWLogin: TCheckBox
        Left = 48
        Top = 168
        Width = 209
        Height = 17
        HelpType = htKeyword
        HelpKeyword = 'SaveAWLogin'
        Caption = 'Save my credentials to my license file.'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object PgWorkInfo: TTabSheet
      Caption = 'Appraisal Info'
      ImageIndex = 1
      TabVisible = False
      object lblCertExp1: TLabel
        Left = 306
        Top = 67
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
      end
      object lblLicExp1: TLabel
        Left = 306
        Top = 164
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
      end
      object lblLicSt1: TLabel
        Left = 41
        Top = 164
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #1'
      end
      object lblCertNo1: TLabel
        Left = 129
        Top = 65
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cert No.:'
      end
      object lblLicNo1: TLabel
        Left = 130
        Top = 162
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Lic. No.:'
      end
      object lblLicSt2: TLabel
        Left = 41
        Top = 188
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #2'
        Visible = False
      end
      object lblLicNo2: TLabel
        Left = 130
        Top = 186
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Lic. No.:'
        Visible = False
      end
      object lblLicExp2: TLabel
        Left = 306
        Top = 188
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
        Visible = False
      end
      object lblLicSt3: TLabel
        Left = 41
        Top = 211
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #3'
        Visible = False
      end
      object lblLicNo3: TLabel
        Left = 130
        Top = 210
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Lic. No.:'
        Visible = False
      end
      object lblLicExp3: TLabel
        Left = 306
        Top = 211
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
        Visible = False
      end
      object lblCertSt1: TLabel
        Left = 41
        Top = 64
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #1'
      end
      object lblCertSt2: TLabel
        Left = 41
        Top = 90
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #2'
        Visible = False
      end
      object lblCertSt3: TLabel
        Left = 41
        Top = 113
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'State #3'
        Visible = False
      end
      object lblCertNo2: TLabel
        Left = 129
        Top = 89
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cert No.:'
        Visible = False
      end
      object lblCertNo3: TLabel
        Left = 129
        Top = 114
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cert No.:'
        Visible = False
      end
      object lblCertExp2: TLabel
        Left = 306
        Top = 91
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
        Visible = False
      end
      object lblCertExp3: TLabel
        Left = 306
        Top = 113
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expires'
        Visible = False
      end
      object lblEnterLicCert: TLabel
        Left = 19
        Top = 8
        Width = 292
        Height = 13
        Caption = 'Please enter your Appraisal License or Certification information'
      end
      object edtCertNo1: TEdit
        Left = 175
        Top = 63
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 1
        OnKeyDown = RegInfoChanged
      end
      object edtLicNo1: TEdit
        Left = 175
        Top = 159
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 10
        OnKeyDown = RegInfoChanged
      end
      object edtCertSt1: TEdit
        Left = 87
        Top = 62
        Width = 29
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 0
        OnKeyDown = RegInfoChanged
      end
      object edtLicSt1: TEdit
        Left = 87
        Top = 159
        Width = 30
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 9
        OnKeyDown = RegInfoChanged
      end
      object edtCertExp1: TEdit
        Left = 343
        Top = 62
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 2
        OnKeyDown = RegInfoChanged
      end
      object edtLicExp1: TEdit
        Left = 343
        Top = 159
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 11
        OnKeyDown = RegInfoChanged
      end
      object rbtnUseCert: TRadioButton
        Left = 17
        Top = 38
        Width = 185
        Height = 17
        Caption = 'Use:  Appraisal Certification No.'
        TabOrder = 18
        OnClick = SelectLicTypeClick
      end
      object rbtnUseLic: TRadioButton
        Left = 17
        Top = 135
        Width = 161
        Height = 17
        Caption = 'Use:  Appraisal License No.'
        TabOrder = 19
        OnClick = SelectLicTypeClick
      end
      object edtLicSt2: TEdit
        Left = 87
        Top = 183
        Width = 30
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 12
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtLicNo2: TEdit
        Left = 175
        Top = 183
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 13
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtLicExp2: TEdit
        Left = 343
        Top = 183
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 14
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtLicSt3: TEdit
        Left = 87
        Top = 208
        Width = 31
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 15
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtLicNo3: TEdit
        Left = 175
        Top = 208
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 16
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtLicExp3: TEdit
        Left = 343
        Top = 208
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 17
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertSt2: TEdit
        Left = 87
        Top = 86
        Width = 29
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 3
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertSt3: TEdit
        Left = 87
        Top = 110
        Width = 29
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 7
        TabOrder = 6
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertNo2: TEdit
        Left = 175
        Top = 87
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 4
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertNo3: TEdit
        Left = 175
        Top = 111
        Width = 113
        Height = 21
        MaxLength = 31
        TabOrder = 7
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertExp2: TEdit
        Left = 343
        Top = 86
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 5
        Visible = False
        OnKeyDown = RegInfoChanged
      end
      object edtCertExp3: TEdit
        Left = 343
        Top = 110
        Width = 70
        Height = 21
        MaxLength = 11
        TabOrder = 8
        Visible = False
        OnKeyDown = RegInfoChanged
      end
    end
    object PgRegister: TTabSheet
      Caption = 'Registration'
      ImageIndex = 2
      TabVisible = False
      OnEnter = PgRegisterEnter
      object lblEnterPrintName: TLabel
        Left = 22
        Top = 16
        Width = 391
        Height = 13
        Caption = 
          'Enter your name and company name EXACTLY as they are to PRINT on' +
          ' the forms.'
      end
      object lblSerialN: TLabel
        Left = 22
        Top = 116
        Width = 96
        Height = 13
        Caption = 'Customer Serial No.:'
      end
      object lblLicName: TLabel
        Left = 23
        Top = 41
        Width = 48
        Height = 13
        Caption = 'Lic Name:'
      end
      object lblLicCoName: TLabel
        Left = 23
        Top = 65
        Width = 47
        Height = 13
        Caption = 'Company:'
      end
      object lblRegN: TLabel
        Left = 354
        Top = 99
        Width = 76
        Height = 13
        Caption = 'Registration No.'
      end
      object edtLicName: TEdit
        Left = 80
        Top = 37
        Width = 351
        Height = 21
        TabOrder = 0
        OnChange = LicNameChange
        OnKeyDown = RegInfoChanged
      end
      object edtSerial1: TEdit
        Left = 120
        Top = 113
        Width = 55
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 2
        OnChange = edtSerial1Change
        OnKeyDown = RegInfoChanged
        OnKeyPress = UppercaseKeys
        OnKeyUp = edtSerial1KeyUp
      end
      object edtSerial2: TEdit
        Left = 177
        Top = 113
        Width = 55
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 3
        OnKeyDown = RegInfoChanged
        OnKeyPress = UppercaseKeys
        OnKeyUp = edtSerial2KeyUp
      end
      object edtSerial3: TEdit
        Left = 235
        Top = 113
        Width = 55
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 4
        OnKeyDown = RegInfoChanged
        OnKeyPress = UppercaseKeys
        OnKeyUp = edtSerial3KeyUp
      end
      object edtSerial4: TEdit
        Left = 293
        Top = 113
        Width = 55
        Height = 21
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 5
        OnKeyDown = RegInfoChanged
        OnKeyPress = UppercaseKeys
        OnKeyUp = edtSerial4KeyUp
      end
      object edtLicCoName: TEdit
        Left = 80
        Top = 61
        Width = 351
        Height = 21
        TabOrder = 1
        OnChange = LicNameChange
        OnKeyDown = RegInfoChanged
      end
      object edtRegN: TEdit
        Left = 351
        Top = 113
        Width = 82
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        ReadOnly = True
        TabOrder = 6
        OnChange = RegNChange
      end
    end
    object PgGetCodes: TTabSheet
      Caption = 'PgGetCodes'
      ImageIndex = 6
      TabVisible = False
      OnShow = PgGetCodesShow
      object CSNComment: TLabel
        Left = 10
        Top = 2
        Width = 412
        Height = 13
        Caption = 
          'Note: Online unlocking requires that you have a Customer Serial ' +
          'Number'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblGetCodes: TLabel
        Left = 8
        Top = 18
        Width = 442
        Height = 13
        Caption = 
          'Click the "Instantly Retrieve Codes" button to unlock your Click' +
          'FORMS software and services'
      end
      object rdoOnLine: TRadioButton
        Left = 16
        Top = 56
        Width = 65
        Height = 17
        Caption = 'Online:'
        TabOrder = 0
        OnClick = rdoOnLineClick
      end
      object rdoFax: TRadioButton
        Left = 16
        Top = 120
        Width = 38
        Height = 17
        Caption = 'Fax:'
        TabOrder = 1
        Visible = False
        OnClick = rdoFaxClick
      end
      object btnFax: TBitBtn
        Left = 96
        Top = 118
        Width = 169
        Height = 25
        Caption = 'Fax Request for Codes'
        TabOrder = 2
        Visible = False
        OnClick = btnFaxClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000730E0000730E00000001000000010000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
          09090909090909E8E8E8E8E88181818181818181818181E8E8E8E85E89898989
          89898989895E5E09E8E8E8E2ACACACACACACACACACE2E281E8E85E5E5E5E5E5E
          5E5E5E5E5E5E095E09E8E2E2E2E2E2E2E2E2E2E2E2E281E281E85ED789898989
          8989898989895E0909E8E2E8ACACACACACACACACACACE28181E85ED789898989
          181289B490895E5E09E8E2E8ACACACACE281ACE281ACE2E281E85ED7D7D7D7D7
          D7D7D7D7D7D75E5E5E09E2E8E8E8E8E8E8E8E8E8E8E8E2E2E2815ED789898989
          8989898989895E5E5E09E2E8ACACACACACACACACACACE2E2E281E85E5E5E5E5E
          5E5E5E5E5E89895E5E09E8E2E2E2E2E2E2E2E2E2E2ACACE2E281E8E85ED7D7D7
          D7D7D7D7D75E89895E09E8E8E2E8E8E8E8E8E8E8E8E2ACACE281E8E8E85ED7E3
          E3E3E3E3D75E5E5E09E8E8E8E8E2E8ACACACACACE8E2E2E281E8E8E8E85ED7D7
          D7D7D7D7D7D75EE8E8E8E8E8E8E2E8E8E8E8E8E8E8E8E2E8E8E8E8E8E8E85ED7
          E3E3E3E3E3D75EE8E8E8E8E8E8E8E2E8ACACACACACE8E2E8E8E8E8E8E8E85ED7
          D7D7D7D7D7D7D75EE8E8E8E8E8E8E2E8E8E8E8E8E8E8E8E2E8E8E8E8E8E8E85E
          5E5E5E5E5E5E5E5EE8E8E8E8E8E8E8E2E2E2E2E2E2E2E2E2E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        NumGlyphs = 2
      end
      object btnOnLine: TBitBtn
        Left = 96
        Top = 52
        Width = 169
        Height = 25
        Caption = 'Instantly Retrieve Codes'
        TabOrder = 3
        OnClick = btnOnLineClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000630E0000630E00000001000000010000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
          00000000E8E8E8E8E8E8E8E8E8E8E8E856565656E8E8E8E8E8E8E8E8E8E80000
          050505050000E8E8E8E8E8E8E8E85656818181815656E8E8E8E8E8E8E8003600
          05350505050500E8E8E8E8E8E856815681AC8181818156E8E8E8E8E836363636
          0035353505050600E8E8E8E88181818156ACACAC81810656E8E8E8363644443D
          360035350C0C0C0C00E8E88181E3E3AC8156ACAC8181818156E8E8364444443D
          3600170C36360C0C00E8E881E3E3E3AC8156AC818181818156E836B2B2B23D0C
          0C170C3D36360C0C0C0081E3E3E3AC8181AC81AC8181818181563636D73D0C17
          41410CB23D360C0C0C008181D7AC81ACE3E381E3AC818181815635B336361741
          4141170CB23D360C0C00ACD78181ACE3E3E3AC81E3AC8181815635B347173035
          17411735350C3D360C00ACD7E3AC81ACACE3ACACAC81AC818156E83530303D30
          3541411735350C0C00E8E8AC8181AC81ACE3E3ACACAC818156E8E836D7B23D3D
          301717413535353500E8E881D7E3ACAC81ACACE3ACACACAC56E8E8E836D7B23D
          3D303017353535DBE8E8E8E881D7E3ACAC8181ACACACAC56E8E8E8E8E836D7B2
          B23D3630353535E8E8E8E8E8E881D7E3E3AC8181ACACACE8E8E8E8E8E8E83636
          D73D3D363535E8E8E8E8E8E8E8E88181D7ACAC81ACACE8E8E8E8E8E8E8E8E8E8
          36363636E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8}
        NumGlyphs = 2
      end
      object btnPhone: TBitBtn
        Left = 344
        Top = 52
        Width = 81
        Height = 25
        Caption = 'Questions'
        TabOrder = 4
        OnClick = btnPhoneClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000230B0000230B00000001000000010000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E3DE56
          E1E1E1E1E1DFACEEE8E8E8E8E8AC8181818181818181ACEEE8E8E8E8E3E2EBE3
          E3E3E3E3DEE1ECE2E3E8E8E8AC81EBACACACACACAC8181E2ACE8E8E3DEE3D7E3
          8282ACEED7E3DF56E2EEE8AC81ACD7ACACACACEED7AC8181E2EEE8ACE3D78210
          3482343482D7E3ECECACE881ACD7AC8181AC8181ACD7AC8181ACE3E3D7580A10
          82D75E0A0A82D7E3E181AC81D7AC8181ACD7818181ACD7AC8181E3D7820A3434
          345E3434340AACE3815681D7AC818181818181818181ACAC8181E3D734343434
          5EE33434343458D7ACE181D78181818181AC81818181ACD7AC81E3E334343434
          5ED7830A343434EEE3E181AC8181818181D7AC81818181EEAC81E3AD34343434
          3488D75E343434EEE3E181AD8181818181ACD781818181EEAC81E3E334343434
          340AACD7343434D7E35681AC818181818181ACD7818181D7AC81E3D75F345EE3
          580A5ED75E105ED7ACED81D7818181ACAC8181D7818181D7ACEDE3EEB33B5ED7
          D789D7D73435D7E381E381EEAC8181D7D7ACD7D78181D7AC81ACE8E3D7E65F83
          E3EEE35F5FADD7E6DEE8E881D7AC81ACACEEAC8181ADD7AC81E8E8E3E3D7D7B3
          89898989D7D7E3DEEEE8E8E881D7D7ACACACACACD7D7AC81EEE8E8E8E3ADE3D7
          D7D7D7D7E3ADACEEE8E8E8E8E88181D7D7D7D7D7818181EEE8E8E8E8E8E8E3AD
          ADADE6ADE3E3E8E8E8E8E8E8E8E8AC8181818181ACACE8E8E8E8}
        NumGlyphs = 2
      end
      object Button1: TButton
        Left = 120
        Top = 200
        Width = 57
        Height = 1
        Caption = 'Button1'
        TabOrder = 5
      end
      object rdoSkip: TRadioButton
        Left = 16
        Top = 192
        Width = 385
        Height = 17
        Caption = 
          'SKIP THIS SECTION. Codes have already been requested and receive' +
          'd.'
        TabOrder = 6
        OnClick = rdoSkipClick
      end
    end
    object PgValidate: TTabSheet
      Caption = 'PgValidate'
      ImageIndex = 3
      TabVisible = False
      OnHide = PgValidateHide
      OnShow = PgValidateShow
      object lblEnterUnlockCodes: TLabel
        Left = 8
        Top = 8
        Width = 374
        Height = 13
        Caption = 
          'If you received your unlocking codes via e-mail or fax, please e' +
          'nter them below.'
      end
      object ProductGrid: TtsGrid
        Left = 8
        Top = 40
        Width = 449
        Height = 193
        CheckBoxStyle = stCheck
        ColMoving = False
        Cols = 4
        ColSelectMode = csNone
        DefaultRowHeight = 18
        ExportDelimiter = ','
        HeadingFont.Charset = DEFAULT_CHARSET
        HeadingFont.Color = clWindowText
        HeadingFont.Height = -11
        HeadingFont.Name = 'MS Sans Serif'
        HeadingFont.Style = []
        HeadingHeight = 16
        HeadingParentFont = False
        ParentShowHint = False
        ResizeCols = rcNone
        ResizeRows = rrNone
        RowBarOn = False
        Rows = 3
        RowSelectMode = rsSingle
        ShowHint = False
        StoreData = True
        TabOrder = 0
        ThumbTracking = True
        Version = '3.01.08'
        XMLExport.Version = '1.0'
        XMLExport.DataPacketVersion = '2.0'
        OnCellEdit = ProductGridCellEdit
        ColProperties = <
          item
            DataCol = 1
            Col.Heading = 'Product'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaLeft
            Col.VertAlignment = vtaCenter
            Col.Width = 165
          end
          item
            DataCol = 2
            Col.Heading = 'Version'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.ReadOnly = True
            Col.HorzAlignment = htaCenter
            Col.VertAlignment = vtaCenter
            Col.Width = 44
          end
          item
            DataCol = 3
            Col.Heading = 'Unlocking Code'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.VertAlignment = vtaCenter
            Col.Width = 110
          end
          item
            DataCol = 4
            Col.ControlType = ctText
            Col.Heading = 'Expires'
            Col.HeadingHorzAlignment = htaCenter
            Col.HeadingVertAlignment = vtaCenter
            Col.ReadOnly = True
            Col.VertAlignment = vtaCenter
            Col.Width = 110
          end>
        Data = {
          0100000004000000010000000000010000000001000000000200000004000000
          0000010000000001000000000000000000000000}
      end
    end
    object PgFinished: TTabSheet
      Caption = 'PgFinished'
      ImageIndex = 4
      TabVisible = False
      object lblPrintRegInfo: TLabel
        Left = 16
        Top = 192
        Width = 321
        Height = 13
        Caption = 
          'Would you like to print your registration information for safe k' +
          'eeping?'
      end
      object FinishedNote: TLabel
        Left = 64
        Top = 56
        Width = 313
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'NOTICE'
        Color = clBtnFace
        ParentColor = False
      end
      object FinishedMsg: TLabel
        Left = 64
        Top = 80
        Width = 313
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'FinishedMsg'
        Color = clBtnFace
        ParentColor = False
      end
      object ExpireMsg: TLabel
        Left = 64
        Top = 104
        Width = 313
        Height = 13
        Alignment = taCenter
        AutoSize = False
      end
      object lblSameRegInfo: TLabel
        Left = 8
        Top = 222
        Width = 435
        Height = 13
        Caption = 
          'If you are installing on multiple computers, use the same regist' +
          'ration information for each one.'
      end
      object btnPrint: TButton
        Left = 372
        Top = 188
        Width = 75
        Height = 25
        Caption = 'Print'
        TabOrder = 0
        OnClick = btnPrintClick
      end
    end
  end
  object HTTP: TIdHTTP
    AuthRetries = 0
    AuthProxyRetries = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentRangeInstanceLength = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 352
    Top = 256
  end
  object SMTPMailer: TIdSMTP
    Host = 'smtp.btmta.net'
    Password = 'ma1luser'
    SASLMechanisms = <>
    Username = 'smtpuser'
    Left = 296
    Top = 256
  end
  object EmailMsg: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 328
    Top = 256
  end
end
