object CompFilter: TCompFilter
  Left = 599
  Top = 227
  Width = 712
  Height = 600
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Market Filter Preferences'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTitleFilters: TPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 57
    Align = alTop
    TabOrder = 0
    object lblFeatureName: TLabel
      Left = 5
      Top = 31
      Width = 64
      Height = 13
      Caption = 'Characteristic'
    end
    object lblMin: TLabel
      Left = 96
      Top = 31
      Width = 17
      Height = 13
      Caption = 'Min'
    end
    object lblMax: TLabel
      Left = 204
      Top = 31
      Width = 20
      Height = 13
      Caption = 'Max'
    end
    object lblSubject: TLabel
      Left = 141
      Top = 31
      Width = 36
      Height = 13
      Caption = 'Subject'
    end
    object RzSeparator_1: TRzSeparator
      Left = 73
      Top = 11
      Width = 2
      Height = 35
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label5: TLabel
      Left = 282
      Top = 31
      Width = 19
      Height = 13
      Caption = 'Use'
    end
    object lblSales: TLabel
      Left = 331
      Top = 12
      Width = 76
      Height = 13
      Caption = 'Imported Sales :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblListings: TLabel
      Left = 331
      Top = 31
      Width = 85
      Height = 13
      Caption = 'Imported Listings :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalSalesCount: TLabel
      Left = 412
      Top = 12
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalListCount: TLabel
      Left = 422
      Top = 31
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSalesExc: TLabel
      Left = 453
      Top = 12
      Width = 50
      Height = 13
      Caption = 'Excluded :'
    end
    object lblListExc: TLabel
      Left = 455
      Top = 31
      Width = 50
      Height = 13
      Caption = 'Excluded :'
    end
    object lblExcludedSalesCount: TLabel
      Left = 507
      Top = 12
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblExcludedListCount: TLabel
      Left = 511
      Top = 31
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSalesleft: TLabel
      Left = 550
      Top = 12
      Width = 56
      Height = 13
      Caption = 'Remaining :'
    end
    object lblListLeft: TLabel
      Left = 553
      Top = 31
      Width = 56
      Height = 13
      Caption = 'Remaining :'
    end
    object lblFinalSalesCount: TLabel
      Left = 610
      Top = 12
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFinalListCount: TLabel
      Left = 618
      Top = 31
      Width = 6
      Height = 13
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PanelProx: TPanel
    Left = 0
    Top = 57
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 1
    object stxProx: TLabel
      Left = 14
      Top = 12
      Width = 41
      Height = 13
      Caption = 'Proximity'
    end
    object RzSeparator_7: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object lblMileRad: TLabel
      Left = 399
      Top = 12
      Width = 49
      Height = 13
      Caption = 'mile radius'
    end
    object Label1: TLabel
      Left = 240
      Top = 12
      Width = 23
      Height = 13
      Caption = 'miles'
    end
    object Label2: TLabel
      Left = 308
      Top = 12
      Width = 12
      Height = 13
      Caption = '<='
    end
    object chkUseProx: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = UseFilterEvent
    end
    object cbProx: TComboBox
      Tag = 1
      Left = 331
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = '2.0'
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        '0.5'
        '1.0'
        '1.5'
        '2.0'
        '2.5'
        '5'
        '10')
    end
    object edtMaxProx: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 11
      ReadOnly = True
      TabOrder = 2
    end
  end
  object PanelSaleDate: TPanel
    Left = 0
    Top = 98
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 2
    object lblSDate: TLabel
      Left = 6
      Top = 12
      Width = 59
      Height = 13
      Caption = 'Date of Sale'
    end
    object lblDays: TLabel
      Left = 399
      Top = 12
      Width = 35
      Height = 13
      Caption = 'Months'
    end
    object RzSeparator_12: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label10: TLabel
      Left = 240
      Top = 12
      Width = 35
      Height = 13
      Caption = 'Months'
    end
    object Label14: TLabel
      Left = 308
      Top = 12
      Width = 12
      Height = 13
      Caption = '<='
    end
    object Label21: TLabel
      Left = 79
      Top = 13
      Width = 42
      Height = 13
      Caption = 'Eff. Date'
    end
    object chkUseSaledate: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = UseFilterEvent
    end
    object cbSaleDate: TComboBox
      Tag = 2
      Left = 331
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = '6'
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        '3'
        '6'
        '9'
        '12'
        '15'
        '18'
        '24'
        '36'
        '72')
    end
    object edtEffectiveDate: TEdit
      Tag = 3
      Left = 125
      Top = 9
      Width = 65
      Height = 21
      HelpContext = 9
      ReadOnly = True
      TabOrder = 2
    end
    object edtMaxSaleDate: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 11
      ReadOnly = True
      TabOrder = 3
    end
  end
  object PanelGLA: TPanel
    Left = 0
    Top = 139
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 3
    object lblGLA: TLabel
      Left = 8
      Top = 12
      Width = 58
      Height = 13
      Caption = 'Grs Liv Area'
    end
    object lblGLASqft: TLabel
      Left = 240
      Top = 12
      Width = 17
      Height = 13
      Caption = 'sqft'
    end
    object RzSeparator_17: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label3: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label15: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinGLA: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 9
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubGLA: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 10
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxGLA: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 11
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseGLA: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbGLA: TComboBox
      Tag = 3
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelBGLA: TPanel
    Left = 0
    Top = 180
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 4
    object lblBSMT: TLabel
      Left = 14
      Top = 12
      Width = 48
      Height = 13
      Caption = 'Bsmt Area'
    end
    object lblBsmtSqft: TLabel
      Left = 240
      Top = 12
      Width = 17
      Height = 13
      Caption = 'sqft'
    end
    object RzSeparator_22: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label4: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label16: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinBGLA: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 15
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubBGLA: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 16
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxBGLA: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 17
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseBsmt: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbBsmt: TComboBox
      Tag = 4
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelSite: TPanel
    Left = 0
    Top = 221
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 5
    object lblSite: TLabel
      Left = 14
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Site Area'
    end
    object lblSiteSqft: TLabel
      Left = 240
      Top = 12
      Width = 17
      Height = 13
      Caption = 'sqft'
    end
    object RzSeparator_27: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label6: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label17: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinSite: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubSite: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 22
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxSite: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 23
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseSiteArea: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbSite: TComboBox
      Tag = 5
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelAge: TPanel
    Left = 0
    Top = 262
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 6
    object lblAge: TLabel
      Left = 14
      Top = 12
      Width = 19
      Height = 13
      Caption = 'Age'
    end
    object lblAgeYrs: TLabel
      Left = 240
      Top = 12
      Width = 13
      Height = 13
      Caption = 'yrs'
    end
    object RzSeparator_32: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label7: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label18: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinAge: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 27
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubAge: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 28
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxAge: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 29
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseAge: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbAge: TComboBox
      Tag = 6
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelStories: TPanel
    Left = 0
    Top = 303
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 7
    object lblStory: TLabel
      Left = 14
      Top = 12
      Width = 32
      Height = 13
      Caption = 'Stories'
    end
    object lblStoryP: TLabel
      Left = 240
      Top = 12
      Width = 30
      Height = 13
      Caption = 'stories'
    end
    object RzSeparator3: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label8: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label19: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtSubStories: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 34
      ReadOnly = True
      TabOrder = 1
    end
    object edtMinStory: TEdit
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 33
      ReadOnly = True
      TabOrder = 0
    end
    object edtMaxStory: TEdit
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 35
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseStories: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbStories: TComboBox
      Tag = 7
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelBeds: TPanel
    Left = 0
    Top = 344
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 8
    object lblBeds: TLabel
      Left = 14
      Top = 12
      Width = 47
      Height = 13
      Caption = 'Bedrooms'
    end
    object lblBedsRm: TLabel
      Left = 240
      Top = 12
      Width = 16
      Height = 13
      Caption = 'rms'
    end
    object RzSeparator_37: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label9: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label20: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinBeds: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 39
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubBed: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 40
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxBeds: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 41
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseBed: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbBedRm: TComboBox
      Tag = 8
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelFirepl: TPanel
    Left = 0
    Top = 385
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 9
    object lblFire: TLabel
      Left = 14
      Top = 12
      Width = 48
      Height = 13
      Caption = 'Fireplaces'
    end
    object lblFireP: TLabel
      Left = 240
      Top = 12
      Width = 22
      Height = 13
      Caption = 'firepl'
    end
    object RzSeparator_47: TRzSeparator
      Left = 73
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label11: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label22: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinFirePl: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 51
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubFirePl: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 52
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxFirePl: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 53
      ReadOnly = True
      TabOrder = 2
    end
    object ChkUseFirePl: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbFirePl: TComboBox
      Tag = 9
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelCars: TPanel
    Left = 0
    Top = 426
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 10
    object lblGarage: TLabel
      Left = 11
      Top = 12
      Width = 56
      Height = 13
      Caption = 'Car Storage'
    end
    object lblGarageCar: TLabel
      Left = 240
      Top = 12
      Width = 20
      Height = 13
      Caption = 'cars'
    end
    object RzSeparator_52: TRzSeparator
      Left = 75
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label12: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label23: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtMinCars: TEdit
      Tag = 3
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 57
      ReadOnly = True
      TabOrder = 0
    end
    object edtSubCar: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 58
      ReadOnly = True
      TabOrder = 1
    end
    object edtMaxCars: TEdit
      Tag = 3
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 59
      ReadOnly = True
      TabOrder = 2
    end
    object chkUseGarage: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbGarage: TComboBox
      Tag = 10
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object PanelPool: TPanel
    Left = 0
    Top = 467
    Width = 704
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    TabOrder = 11
    object lblPool: TLabel
      Left = 14
      Top = 12
      Width = 21
      Height = 13
      Caption = 'Pool'
    end
    object lblPoolP: TLabel
      Left = 240
      Top = 12
      Width = 20
      Height = 13
      Caption = 'pool'
    end
    object RzSeparator_57: TRzSeparator
      Left = 75
      Top = 7
      Width = 2
      Height = 25
      Orientation = orVertical
      ShowGradient = False
      Color = clGray
      ParentColor = False
    end
    object Label13: TLabel
      Left = 308
      Top = 12
      Width = 14
      Height = 13
      Caption = '+/-'
    end
    object Label24: TLabel
      Left = 399
      Top = 13
      Width = 8
      Height = 13
      Caption = '%'
    end
    object edtSubPool: TEdit
      Left = 140
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 64
      ReadOnly = True
      TabOrder = 1
    end
    object edtMinPool: TEdit
      Left = 90
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 63
      ReadOnly = True
      TabOrder = 0
    end
    object edtMaxPool: TEdit
      Left = 190
      Top = 9
      Width = 45
      Height = 21
      HelpContext = 65
      ReadOnly = True
      TabOrder = 2
    end
    object chkUsePool: TCheckBox
      Left = 288
      Top = 10
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = UseFilterEvent
    end
    object cbPool: TComboBox
      Tag = 11
      Left = 330
      Top = 10
      Width = 60
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnChange = RateChange
      OnEnter = OnEnterTextEvent
      OnSelect = OnComboSelect
      Items.Strings = (
        'Equal'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50')
    end
  end
  object bottomPanel: TPanel
    Left = 0
    Top = 508
    Width = 704
    Height = 64
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 12
    object btnUseDefaultFilters: TButton
      Left = 90
      Top = 14
      Width = 95
      Height = 25
      Caption = 'Save As Default'
      TabOrder = 0
      OnClick = btnUseDefaultFiltersClick
    end
    object btnApplyFilters: TButton
      Left = 301
      Top = 14
      Width = 84
      Height = 25
      Caption = 'Apply Filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnApplyFiltersClick
    end
    object btnReset: TButton
      Left = 412
      Top = 14
      Width = 84
      Height = 25
      Caption = 'Reset Filter'
      TabOrder = 2
      OnClick = btnResetClick
    end
  end
end
