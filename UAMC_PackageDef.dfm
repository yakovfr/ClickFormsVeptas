inherited AMC_PackageDef: TAMC_PackageDef
  Width = 634
  Height = 303
  object lblHeading: TLabel
    Left = 32
    Top = 19
    Width = 304
    Height = 13
    Caption = 
      'The Appraisal "UAD Package" will consist of the following file(s' +
      '):'
  end
  object chkNeedX26_GSE: TCheckBox
    Left = 32
    Top = 48
    Width = 17
    Height = 17
    TabOrder = 0
    OnClick = chkNeedX26_GSEClick
  end
  object chkNeedPDF: TCheckBox
    Left = 32
    Top = 182
    Width = 17
    Height = 17
    TabOrder = 4
    OnClick = chkNeedPDFClick
  end
  object chkNeedENV: TCheckBox
    Left = 32
    Top = 148
    Width = 17
    Height = 17
    TabOrder = 3
    OnClick = chkNeedENVClick
  end
  object chkNeedX26: TCheckBox
    Left = 32
    Top = 81
    Width = 17
    Height = 17
    TabOrder = 1
    OnClick = chkNeedX26Click
  end
  object stNeedX26GSE: TStaticText
    Left = 209
    Top = 50
    Width = 265
    Height = 17
    Caption = 'Required for forms: 1004, 1004P, 1073, 1075 and 2055'
    TabOrder = 5
  end
  object stNeedX26: TStaticText
    Left = 209
    Top = 83
    Width = 386
    Height = 17
    Caption = 
      'Required for forms: 1004C, 1004D, 1025, 2090 and 2095;  (availab' +
      'le for all forms)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object stNeedENV: TStaticText
    Left = 209
    Top = 150
    Width = 206
    Height = 17
    Caption = 'Required by AppraisalPort and some AMCs'
    TabOrder = 8
  end
  object stNeedPDF: TStaticText
    Left = 209
    Top = 184
    Width = 232
    Height = 17
    Caption = 'Required by GSEs to be embedded into XML file'
    TabOrder = 9
  end
  object sTxNote: TStaticText
    Left = 32
    Top = 228
    Width = 305
    Height = 17
    Caption = 'NOTE: The UAD Package Contents have been set by the AMC'
    TabOrder = 10
  end
  object chkNeedX241: TCheckBox
    Left = 32
    Top = 115
    Width = 17
    Height = 17
    TabOrder = 2
    OnClick = chkNeedX241Click
  end
  object stNeedX241: TStaticText
    Left = 209
    Top = 117
    Width = 200
    Height = 17
    Caption = 'Required for MISMO 2.4.1 version reports'
    TabOrder = 7
  end
  object stxNeedX26_GSE: TStaticText
    Left = 56
    Top = 50
    Width = 112
    Height = 17
    Caption = 'XML File (UAD Format)'
    TabOrder = 11
  end
  object stxNeedX26: TStaticText
    Left = 56
    Top = 83
    Width = 118
    Height = 17
    Caption = 'XML File (2.6 Non-UAD)'
    TabOrder = 12
  end
  object stxNeedX241: TStaticText
    Left = 56
    Top = 117
    Width = 75
    Height = 17
    Caption = 'XML 2.4.1 File '
    TabOrder = 13
  end
  object stxNeedENV: TStaticText
    Left = 56
    Top = 150
    Width = 45
    Height = 17
    Caption = 'ENV File'
    TabOrder = 14
  end
  object stxNeedPDF: TStaticText
    Left = 56
    Top = 184
    Width = 44
    Height = 17
    Caption = 'PDF File'
    TabOrder = 15
  end
end
