object PrefAppStartUp: TPrefAppStartUp
  Tag = 72
  Left = 0
  Top = 0
  Width = 602
  Height = 410
  TabOrder = 0
  object rdoBxDoNothing: TRadioButton
    Left = 27
    Top = 64
    Width = 329
    Height = 17
    Caption = 'Do Nothing  (i.e. do not open any container windows)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object rdoBxEmptyContainer: TRadioButton
    Left = 27
    Top = 95
    Width = 250
    Height = 17
    Caption = 'Create a New Empty Container window'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object rdoBxSelectTemplate: TRadioButton
    Left = 27
    Top = 125
    Width = 249
    Height = 17
    Caption = 'Display the Template Selection dialog'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object rdoBxReOpenLast: TRadioButton
    Left = 27
    Top = 155
    Width = 262
    Height = 17
    Caption = 'Open the Most Recently Used file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object rdoBxOpenThisFile: TRadioButton
    Left = 27
    Top = 186
    Width = 99
    Height = 17
    Caption = 'Open this file:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object edtStarterFile: TEdit
    Left = 127
    Top = 185
    Width = 372
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'C:\starter file'
  end
  object BtnBrowseStartFile: TButton
    Left = 507
    Top = 183
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 6
    OnClick = BtnBrowseStartFileClick
  end
  object cbxShowFormsLib: TCheckBox
    Left = 17
    Top = 223
    Width = 263
    Height = 17
    Caption = 'Show the Forms Library window at startup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object cbxShowToolBoxMenu: TCheckBox
    Left = 17
    Top = 335
    Width = 283
    Height = 17
    Caption = 'Show Appraiser'#39's ToolBox File Open menus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object pnlAppStartup: TPanel
    Left = 0
    Top = 0
    Width = 602
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Application Startup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object stAtStartup: TStaticText
    Left = 16
    Top = 40
    Width = 64
    Height = 17
    Caption = 'At start up....'
    TabOrder = 12
  end
  object cbxShowNews: TCheckBox
    Left = 17
    Top = 357
    Width = 216
    Height = 17
    Caption = 'Show NewsDesk at startup'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object cbxDisplayExpireAlerts: TCheckBox
    Left = 17
    Top = 378
    Width = 211
    Height = 17
    Caption = 'Show alerts for expiring services'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object cbxUseAddressVerification: TCheckBox
    Left = 17
    Top = 245
    Width = 263
    Height = 17
    Caption = 'Use Address Verification when using Templates'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
end
