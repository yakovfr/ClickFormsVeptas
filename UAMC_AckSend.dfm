inherited AMC_AckSend: TAMC_AckSend
  Width = 734
  Height = 260
  object lblAckFinish: TLabel
    Left = 24
    Top = 24
    Width = 329
    Height = 13
    AutoSize = False
    Caption = 'Your Appraisal Report has been successfully created'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 424
    Top = 8
    Width = 248
    Height = 26
    Anchors = [akTop, akRight]
    Caption = 
      'How can we improve the delivery of your appraisals? Send us your' +
      ' suggestions.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnSendSuggestion: TButton
    Left = 424
    Top = 48
    Width = 121
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Send Suggestion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnSendSuggestionClick
  end
end
