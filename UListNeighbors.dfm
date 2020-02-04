object NeighborhoodList: TNeighborhoodList
  Left = 763
  Top = 283
  Width = 656
  Height = 494
  BorderIcons = [biSystemMenu]
  Caption = 'List of Neighborhood Records'
  Color = clBtnFace
  Constraints.MinHeight = 476
  Constraints.MinWidth = 630
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NeighborhoodSB: TStatusBar
    Left = 0
    Top = 442
    Width = 648
    Height = 21
    Panels = <>
  end
  object LookupList: TListBox
    Left = 0
    Top = 0
    Width = 146
    Height = 431
    ItemHeight = 13
    Items.Strings = (
      'Cambrian'
      'Campbell'
      'Moutain View'
      'Willow Glen')
    Sorted = True
    TabOrder = 1
    OnClick = LookupListClick
    OnDblClick = LookupListDblClick
  end
  object Panel1: TPanel
    Left = 146
    Top = 0
    Width = 495
    Height = 431
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 88
      Top = 46
      Width = 171
      Height = 13
      Caption = 'from Report'#39's Neighborhood Section'
    end
    object Label5: TLabel
      Left = 89
      Top = 77
      Width = 124
      Height = 13
      Caption = 'this Neighborhood Record'
    end
    object lblNeighbor: TLabel
      Left = 201
      Top = 14
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = 'Neighborhood As:'
    end
    object btnSave: TButton
      Left = 136
      Top = 8
      Width = 57
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnDelete: TButton
      Left = 6
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnUpdate: TButton
      Left = 6
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Update'
      TabOrder = 2
      OnClick = btnUpdateClick
    end
    object btnTransfer: TButton
      Left = 334
      Top = 45
      Width = 123
      Height = 25
      Caption = 'Transfer to Report'
      TabOrder = 3
      OnClick = btnTransferClick
    end
    object cbxXferCensus: TCheckBox
      Left = 336
      Top = 76
      Width = 129
      Height = 17
      Caption = 'Transfer Census Tract'
      TabOrder = 4
    end
    object cbxXferMapRef: TCheckBox
      Left = 336
      Top = 99
      Width = 129
      Height = 17
      Caption = 'Transfer Map Ref'
      TabOrder = 5
    end
    object btnNewLoad: TButton
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = 'New/Load from Report'
      TabOrder = 6
      OnClick = btnNewLoadClick
    end
    object edtLookupName: TDBEdit
      Left = 288
      Top = 9
      Width = 169
      Height = 21
      DataField = 'NeighborhoodName'
      DataSource = ListDMMgr.NeighborSource
      TabOrder = 7
      OnChange = OnChanges
    end
    object PageControl: TPageControl
      Left = 0
      Top = 130
      Width = 495
      Height = 301
      ActivePage = TrendSheet
      Align = alBottom
      TabOrder = 8
      TabWidth = 100
      object TrendSheet: TTabSheet
        Caption = 'Trends'
        object Label8: TLabel
          Left = 16
          Top = 72
          Width = 60
          Height = 13
          Caption = 'Growth Rate'
        end
        object Label9: TLabel
          Left = 16
          Top = 16
          Width = 41
          Height = 13
          Caption = 'Location'
        end
        object Label10: TLabel
          Left = 16
          Top = 44
          Width = 37
          Height = 13
          Caption = 'Built-Up'
        end
        object Label11: TLabel
          Left = 16
          Top = 100
          Width = 74
          Height = 13
          Caption = 'Property Values'
        end
        object Label12: TLabel
          Left = 16
          Top = 128
          Width = 83
          Height = 13
          Caption = 'Demand / Supply'
        end
        object Label13: TLabel
          Left = 16
          Top = 156
          Width = 73
          Height = 13
          Caption = 'Marketing Time'
        end
        object Label14: TLabel
          Left = 16
          Top = 184
          Width = 86
          Height = 13
          Caption = 'Land Use Change'
        end
        object Label15: TLabel
          Left = 16
          Top = 211
          Width = 109
          Height = 13
          Caption = 'Land Use Changing to:'
        end
        object Label16: TLabel
          Left = 344
          Top = 0
          Width = 58
          Height = 13
          Caption = 'Land Usage'
        end
        object Label17: TLabel
          Left = 281
          Top = 21
          Width = 52
          Height = 13
          Caption = 'One Family'
        end
        object Label18: TLabel
          Left = 286
          Top = 45
          Width = 47
          Height = 13
          Caption = '2-4 Family'
        end
        object Label19: TLabel
          Left = 279
          Top = 69
          Width = 54
          Height = 13
          Caption = 'Multi-Family'
        end
        object Label20: TLabel
          Left = 279
          Top = 93
          Width = 54
          Height = 13
          Caption = 'Commercial'
        end
        object Label21: TLabel
          Left = 272
          Top = 117
          Width = 63
          Height = 13
          Caption = 'Condominium'
        end
        object Label22: TLabel
          Left = 303
          Top = 141
          Width = 30
          Height = 13
          Caption = 'Co-Op'
        end
        object Label23: TLabel
          Left = 291
          Top = 165
          Width = 42
          Height = 13
          Caption = 'Industrial'
        end
        object Label24: TLabel
          Left = 299
          Top = 189
          Width = 34
          Height = 13
          Caption = 'Vacant'
        end
        object Label25: TLabel
          Left = 271
          Top = 213
          Width = 62
          Height = 13
          Caption = 'Mobile Home'
        end
        object cmbxLocation: TComboBox
          Left = 113
          Top = 14
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnChange = OnChanges
          Items.Strings = (
            'Urban'
            'Suburban'
            'Rural')
        end
        object cmbxBuilt: TComboBox
          Left = 113
          Top = 41
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          OnChange = OnChanges
          Items.Strings = (
            'Over 75%'
            '25 - 75%'
            'Under 25%')
        end
        object cmbxGrowth: TComboBox
          Left = 113
          Top = 69
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          OnChange = OnChanges
          Items.Strings = (
            'Fully Developed'
            'Rapid'
            'Stable'
            'Slow')
        end
        object cmbxValues: TComboBox
          Left = 113
          Top = 96
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          OnChange = OnChanges
          Items.Strings = (
            'Increasing'
            'Stable'
            'Declining')
        end
        object cmbxDemand: TComboBox
          Left = 113
          Top = 124
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 4
          OnChange = OnChanges
          Items.Strings = (
            'Shortage'
            'In Balance'
            'Over Supply')
        end
        object cmbxTime: TComboBox
          Left = 113
          Top = 151
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 5
          OnChange = OnChanges
          Items.Strings = (
            'Under 3 Months'
            '3 - 6 Months'
            'Over 6 Months')
        end
        object cmbxLandChg: TComboBox
          Left = 113
          Top = 179
          Width = 97
          Height = 21
          ItemHeight = 13
          TabOrder = 6
          OnChange = OnChanges
          Items.Strings = (
            'Not Likely'
            'Likely'
            'In Process')
        end
        object LandUseChg: TDBEdit
          Left = 16
          Top = 232
          Width = 201
          Height = 21
          DataField = 'LandUseChangeTo'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 7
          OnChange = OnChanges
        end
        object LandUse1: TDBEdit
          Left = 344
          Top = 16
          Width = 65
          Height = 21
          DataField = 'LandUseOneFamily'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 8
          OnChange = OnChanges
        end
        object LandUse2: TDBEdit
          Left = 344
          Top = 40
          Width = 65
          Height = 21
          DataField = 'LandUseFourFamily'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 9
          OnChange = OnChanges
        end
        object LandUse3: TDBEdit
          Left = 344
          Top = 64
          Width = 65
          Height = 21
          DataField = 'LandUseMultiFamily'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 10
          OnChange = OnChanges
        end
        object LandUse4: TDBEdit
          Left = 344
          Top = 88
          Width = 65
          Height = 21
          DataField = 'LandUseCommercial'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 11
          OnChange = OnChanges
        end
        object LandUse5: TDBEdit
          Left = 344
          Top = 112
          Width = 65
          Height = 21
          DataField = 'LandUseCondominim'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 12
          OnChange = OnChanges
        end
        object LandUse6: TDBEdit
          Left = 344
          Top = 136
          Width = 65
          Height = 21
          DataField = 'LandUseCoOp'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 13
          OnChange = OnChanges
        end
        object LandUse7: TDBEdit
          Left = 344
          Top = 160
          Width = 65
          Height = 21
          DataField = 'LandUseIndustrial'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 14
          OnChange = OnChanges
        end
        object LandUse8: TDBEdit
          Left = 344
          Top = 184
          Width = 65
          Height = 21
          DataField = 'LandUseVacant'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 15
          OnChange = OnChanges
        end
        object LandUse9: TDBEdit
          Left = 344
          Top = 208
          Width = 65
          Height = 21
          DataField = 'LandUseMobileHm'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 16
          OnChange = OnChanges
        end
        object LandUse10: TDBEdit
          Left = 344
          Top = 232
          Width = 65
          Height = 21
          DataField = 'LandUseOtherAmt'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 17
          OnChange = OnChanges
        end
        object LandUseOther: TDBEdit
          Left = 256
          Top = 232
          Width = 81
          Height = 21
          DataField = 'LandUseOtherDesc'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 18
          OnChange = OnChanges
        end
      end
      object CommentSheet: TTabSheet
        Caption = 'Comments'
        ImageIndex = 1
        object Label1: TLabel
          Left = 3
          Top = 3
          Width = 216
          Height = 13
          Caption = 'Neighborhood Boundaries and Characteristics'
        end
        object Label2: TLabel
          Left = 3
          Top = 72
          Width = 97
          Height = 13
          Caption = 'Marketability Factors'
        end
        object Label4: TLabel
          Left = 4
          Top = 141
          Width = 85
          Height = 13
          Caption = 'Market Conditions'
        end
        object Label6: TLabel
          Left = 4
          Top = 210
          Width = 171
          Height = 13
          Caption = 'Multifamily Rent Controls Description'
        end
        object BoundaryMemo: TDBMemo
          Left = 0
          Top = 18
          Width = 449
          Height = 50
          DataField = 'NeighborhoodCharacteristics'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 0
          OnChange = OnChanges
        end
        object MktFactorsMemo: TDBMemo
          Left = 0
          Top = 88
          Width = 449
          Height = 49
          DataField = 'NeighborhoodMarketabilityFactors'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 1
          OnChange = OnChanges
        end
        object MktConditionsMemo: TDBMemo
          Left = 0
          Top = 156
          Width = 449
          Height = 49
          DataField = 'NeighborhoodMarketConditions'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 2
          OnChange = OnChanges
        end
        object MiscMemo: TDBMemo
          Left = 0
          Top = 225
          Width = 449
          Height = 48
          DataField = 'NeighborhoodRentControlDesc'
          DataSource = ListDMMgr.NeighborSource
          TabOrder = 3
          OnChange = OnChanges
        end
      end
    end
  end
end
