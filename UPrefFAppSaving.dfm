object PrefAppSaving: TPrefAppSaving
  Left = 0
  Top = 0
  Width = 796
  Height = 489
  TabOrder = 0
  object chkAutoSave: TCheckBox
    Left = 16
    Top = 48
    Width = 15
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object edtSaveInterval: TComboBox
    Left = 163
    Top = 46
    Width = 45
    Height = 21
    AutoComplete = False
    AutoDropDown = True
    ItemHeight = 13
    MaxLength = 2
    TabOrder = 2
    OnKeyPress = edtSaveIntervalKeyPress
    Items.Strings = (
      '5'
      '10'
      '15'
      '20'
      '30')
  end
  object chkAutoSaveProperties: TRzCheckBox
    Left = 194
    Top = 162
    Width = 329
    Height = 22
    Caption = 'Automatically save the report properties to the Reports Database'
    TextShadowColor = clCaptionText
    State = cbUnchecked
    TabOrder = 3
    Transparent = True
    OnClick = chkAutoSavePropertiesClick
  end
  object chkConfirmProperties: TRzCheckBox
    Left = 210
    Top = 186
    Width = 325
    Height = 50
    Caption = 
      'Ask before saving the report properties in the Reports Database.' +
      ' Use this option to confirm that the properties are correct befo' +
      're saving to the database the first time.'
    TextShadowColor = clNone
    State = cbUnchecked
    TabOrder = 5
    Transparent = True
  end
  object chkConfirmSaveFormats: TCheckBox
    Left = 16
    Top = 88
    Width = 345
    Height = 17
    Caption = 
      'Always ask if you want to save formatting changes to Forms Libra' +
      'ry.'
    TabOrder = 6
    Visible = False
  end
  object rgpDefaultFileType: TRzRadioGroup
    Left = 16
    Top = 136
    Width = 153
    Height = 137
    BorderColor = clWhite
    Caption = 'Default File Name'
    FlatColor = clNone
    ItemFrameColor = clNone
    Items.Strings = (
      'Untitled'
      'Property Street Address'
      'Report File Number'
      'Borrower'#39's Name'
      'Invoice #')
    TextShadowColor = clNone
    TabOrder = 4
    Transparent = True
    VerticalSpacing = 7
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 796
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Saving Reports'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object stAutoSaveMin: TStaticText
    Left = 211
    Top = 49
    Width = 43
    Height = 17
    Caption = 'minutes.'
    TabOrder = 8
  end
  object stAutoSave: TStaticText
    Left = 35
    Top = 49
    Width = 121
    Height = 17
    Caption = 'Automatically save every'
    TabOrder = 9
  end
  object chkSaveBackup: TCheckBox
    Left = 272
    Top = 48
    Width = 170
    Height = 17
    Caption = 'Save report backup files'
    TabOrder = 1
  end
  object chkAutoSaveComps: TRzCheckBox
    Left = 194
    Top = 329
    Width = 587
    Height = 22
    Caption = 
      'Automatically save Comparables to the Comparables Database when ' +
      'you close your report'
    Checked = True
    TextShadowColor = clCaptionText
    State = cbChecked
    TabOrder = 12
    Transparent = True
    OnClick = chkAutoSaveCompsClick
  end
  object chkAutoSaveSubject: TRzCheckBox
    Left = 194
    Top = 402
    Width = 539
    Height = 22
    Caption = 
      'Automatically save Subject Data to the Comparables Database when' +
      ' you close your report'
    Checked = True
    TextShadowColor = clCaptionText
    State = cbChecked
    TabOrder = 13
    Transparent = True
    OnClick = chkAutoSaveSubjectClick
  end
  object chkConfirmCompsSaving: TRzCheckBox
    Left = 210
    Top = 352
    Width = 547
    Height = 31
    Caption = 
      'Always Ask before saving the Comparables Data to the Comparables' +
      ' Database when you close your report'
    TextShadowColor = clNone
    State = cbUnchecked
    TabOrder = 14
    Transparent = True
  end
  object chkConfirmSubjectSaving: TRzCheckBox
    Left = 210
    Top = 423
    Width = 535
    Height = 31
    Caption = 
      'Always Ask before saving the Subject Data to the Comparables Dat' +
      'abase when you close your report'
    TextShadowColor = clNone
    State = cbUnchecked
    TabOrder = 15
    Transparent = True
  end
  object chkCreateNew: TCheckBox
    Left = 192
    Top = 292
    Width = 169
    Height = 17
    Caption = 'Create Duplicate Comp Entries'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = chkCreateNewClick
  end
  object chkUpdateExisting: TCheckBox
    Left = 396
    Top = 292
    Width = 169
    Height = 17
    Caption = 'Update Existing Comps Entries'
    TabOrder = 11
    OnClick = chkUpdateExistingClick
  end
  object Panel2: TPanel
    Left = 192
    Top = 129
    Width = 205
    Height = 28
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'Report'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 16
  end
  object Panel3: TPanel
    Left = 192
    Top = 255
    Width = 205
    Height = 28
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'Comparables'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 17
  end
  object chkAutoCreateWorkFile: TCheckBox
    Left = 16
    Top = 281
    Width = 153
    Height = 41
    Caption = 'Auto create work file folder with name of Report file'
    Checked = True
    State = cbChecked
    TabOrder = 18
    WordWrap = True
    OnClick = chkCreateNewClick
  end
end
