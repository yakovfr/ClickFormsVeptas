object PrefAppraiserXFer: TPrefAppraiserXFer
  Left = 0
  Top = 0
  Width = 585
  Height = 172
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object chkAddYrSuffix: TCheckBox
    Left = 16
    Top = 48
    Width = 497
    Height = 17
    Caption = 
      'Automatically add suffix "Yrs" when transferring the years value' +
      ' into the grid'
    TabOrder = 0
  end
  object chkAddSiteSuffix: TCheckBox
    Left = 16
    Top = 70
    Width = 505
    Height = 17
    Caption = 
      'Automatically add suffix "SQFT" or "ACRE" when transferring Site' +
      ' Area to grid'
    TabOrder = 1
  end
  object chkAddBasemtSuffix: TCheckBox
    Left = 16
    Top = 92
    Width = 497
    Height = 17
    Caption = 
      'Automatically add suffix "SF" when transferring Basement Area to' +
      ' grid'
    TabOrder = 2
  end
  object chkLenderEmailinPDF: TCheckBox
    Left = 16
    Top = 137
    Width = 497
    Height = 17
    Caption = 'Send PDF files with Lender'#39's email address on To: line'
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 585
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Appraisal Transfers'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object chkGRMTransfer: TCheckBox
    Left = 16
    Top = 114
    Width = 535
    Height = 17
    Caption = 
      'Automatically transfer Gross Rental Multiplier down to Income Ap' +
      'proach Section Gross Rental Multipler Field'
    TabOrder = 5
  end
end
