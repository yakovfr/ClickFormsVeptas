inherited AMC_SendPak_ISGN: TAMC_SendPak_ISGN
  Width = 488
  Height = 353
  object btnUpload: TButton
    Left = 240
    Top = 48
    Width = 89
    Height = 25
    Caption = 'Upload'
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
    Width = 185
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
  object edtConfirmEmailAddr: TEdit
    Left = 24
    Top = 184
    Width = 449
    Height = 21
    TabOrder = 3
    Text = 'edtConfirmEmailAddr'
  end
  object stConfirmEmailAddr: TStaticText
    Left = 24
    Top = 165
    Width = 131
    Height = 17
    Caption = 'Confirmation Email Address'
    TabOrder = 4
  end
end