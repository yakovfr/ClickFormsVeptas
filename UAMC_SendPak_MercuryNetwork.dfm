inherited AMC_SendPak_MercuryNetwork: TAMC_SendPak_MercuryNetwork
  Width = 488
  Height = 353
  object btnUpload: TButton
    Left = 267
    Top = 48
    Width = 118
    Height = 25
    Caption = 'Upload to Mercury'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnUploadClick
  end
  object StaticText1: TStaticText
    Left = 24
    Top = 24
    Width = 166
    Height = 17
    Caption = 'Appraisal Package files to Upload:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object chkBxList: TCheckListBox
    Left = 24
    Top = 48
    Width = 233
    Height = 105
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 2
  end
end
