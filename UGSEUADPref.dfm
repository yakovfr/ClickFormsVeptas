object GSEUADPref: TGSEUADPref
  Left = 524
  Top = 215
  Width = 650
  Height = 365
  Caption = 'UAD Compliance Preferences'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 650
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 264
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 0
      Height = 262
      Caption = 'Select Compliance Interface'
      TabOrder = 0
      Visible = False
      object rdoUADFirstLook: TRadioButton
        Tag = 1
        Left = 24
        Top = 24
        Width = 113
        Height = 17
        Hint = 'Use this interface to become familiar with UAD requirements'
        Caption = 'UAD First Look'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
        OnClick = SelectUADInterfaceClick
      end
      object rdoUADPowerUser: TRadioButton
        Tag = 2
        Left = 24
        Top = 68
        Width = 113
        Height = 17
        Hint = 
          'Use this interface once you are familiar with UAD data requireme' +
          'nts'
        Caption = 'UAD Power User'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = SelectUADInterfaceClick
      end
      object rdoUADSpecialist: TRadioButton
        Tag = 3
        Left = 24
        Top = 112
        Width = 113
        Height = 17
        Hint = 'Coming Soon. Higher Productivity  Interface'
        Caption = 'UAD Specialist'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = SelectUADInterfaceClick
      end
    end
    object stxUADActive: TStaticText
      Left = 59
      Top = 26
      Width = 127
      Height = 17
      Caption = 'Turn UAD Compliance On'
      TabOrder = 1
      Transparent = False
    end
    object stxUADAskToEnable: TStaticText
      Left = 71
      Top = 51
      Width = 296
      Height = 17
      Caption = 'Always ask before activating UAD Compliance for new reports'
      TabOrder = 2
      Transparent = False
    end
    object stxAutoAddUADDefs: TStaticText
      Left = 71
      Top = 83
      Width = 279
      Height = 17
      Caption = 'Automatically append UAD Definitions Addendum to report'
      TabOrder = 3
      Transparent = False
    end
    object chkAutoAddUADDefs: TCheckBox
      Left = 53
      Top = 82
      Width = 17
      Height = 17
      TabOrder = 4
      OnClick = chkAutoAddUADDefsClick
    end
    object chkUADAskToEnable: TCheckBox
      Left = 53
      Top = 50
      Width = 17
      Height = 17
      TabOrder = 5
      OnClick = chkUADAskToEnableClick
    end
    object chkUADActive: TCheckBox
      Left = 34
      Top = 24
      Width = 17
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = chkUADActiveClick
    end
    object stNoUADForms: TStaticText
      Left = 38
      Top = 232
      Width = 345
      Height = 24
      Alignment = taCenter
      AutoSize = False
      BevelKind = bkSoft
      BorderStyle = sbsSunken
      Caption = 'There are no UAD compliant forms in this report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Transparent = False
    end
    object rdoUADoption: TRadioGroup
      Left = 27
      Top = 136
      Width = 449
      Height = 89
      ItemIndex = 1
      Items.Strings = (
        'Do Nothing (No UAD dialog)'
        'Automatically display UAD dialogs')
      TabOrder = 8
      OnClick = rdoUADoptionClick
    end
    object chkAutoAddUADSubjDet: TCheckBox
      Left = 53
      Top = 111
      Width = 286
      Height = 18
      Caption = 'Automatically add UAD Subject Details Form'
      TabOrder = 9
      OnClick = chkAutoAddUADSubjDetClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 264
    Width = 642
    Height = 70
    Align = alBottom
    TabOrder = 1
    object chkDesignAndCarActive: TCheckBox
      Left = 28
      Top = 32
      Width = 241
      Height = 17
      Caption = 'UAD for Design and Car Storage is Active'
      TabOrder = 0
      OnClick = chkDesignAndCarActiveClick
    end
    object btnOK: TButton
      Left = 322
      Top = 24
      Width = 76
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TButton
      Left = 418
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
end
