inherited AMC_DigitalSignature: TAMC_DigitalSignature
  Width = 773
  Height = 374
  object lblTitle: TLabel
    Left = 40
    Top = 24
    Width = 518
    Height = 13
    Caption = 
      'Digitally sign the MISMO XML file to prevent fraud and tampering' +
      ' of your report. Mandatory for FHA Appraisals.'
  end
  object lblSignerType: TLabel
    Left = 40
    Top = 56
    Width = 279
    Height = 13
    Caption = 'The report will be signed by the Appraisers Digital Signature'
  end
  object lblSignerName: TLabel
    Left = 40
    Top = 88
    Width = 62
    Height = 13
    Caption = 'Appraiser: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblLicenseNum: TLabel
    Left = 248
    Top = 88
    Width = 61
    Height = 13
    Caption = 'License #:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblLicenseState: TLabel
    Left = 432
    Top = 88
    Width = 83
    Height = 13
    Caption = 'License State:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnSign: TButton
    Left = 576
    Top = 80
    Width = 153
    Height = 25
    Caption = 'Digitally Sign MISMO XML'
    TabOrder = 0
    OnClick = SignXML
  end
end
