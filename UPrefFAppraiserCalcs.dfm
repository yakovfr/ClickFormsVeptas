object PrefAppraiserCalcs: TPrefAppraiserCalcs
  Left = 0
  Top = 0
  Width = 586
  Height = 236
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object chkDoYear2AgeCalc: TCheckBox
    Left = 8
    Top = 43
    Width = 569
    Height = 17
    Caption = 
      'Perform Year-To-Age Calculation when transferring Subject Year B' +
      'uilt to grid'
    TabOrder = 0
  end
  object chkCalcCellEquation: TCheckBox
    Left = 8
    Top = 68
    Width = 569
    Height = 17
    Caption = 
      'Perform Grid Math inside the cell: Convert Year to Age; do math ' +
      'like "20 x 30" inside grid cells'
    TabOrder = 1
  end
  object chkUseLandPriceUnits: TCheckBox
    Left = 8
    Top = 93
    Width = 569
    Height = 17
    Caption = 
      'On Vacant Land Forms - Use Price/Unit instead of Sales Price in ' +
      'Adjustment Calculations'
    TabOrder = 2
  end
  object chkUseOperatingIncomeMarketRent: TCheckBox
    Left = 8
    Top = 118
    Width = 569
    Height = 17
    Caption = 
      'On Operating Income Statement - Use Market Monthly Rent in Gross' +
      ' Annual Rent Calculation'
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 33
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvSpace
    Caption = '   Appraisal Calculations'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object rdoNetGrossDecimal: TRadioGroup
    Left = 8
    Top = 191
    Width = 565
    Height = 35
    Caption = 'Round Gross/Net % to'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'No Decimal'
      '1 Decimal'
      '2 Decimals')
    TabOrder = 4
  end
  object chkIncludeOpinionValue: TCheckBox
    Left = 8
    Top = 142
    Width = 569
    Height = 17
    Caption = 
      'On Cost Approach - Include the Opinion of Site Value to Indicate' +
      'd Value by Cost Approach'
    TabOrder = 6
  end
end
